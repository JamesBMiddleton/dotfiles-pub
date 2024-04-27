--- Taken from:
--- https://github.com/akinsho/git-conflict.nvim/blob/main/lua/git-conflict.lua
--- Only wanted the keymapping for choosing 'ours' or 'theirs' and the 
--- highlighting

local api = vim.api

local SIDES = {
  OURS = 'ours',
  THEIRS = 'theirs',
  BOTH = 'both',
  BASE = 'base',
  NONE = 'none',
}

-- A mapping between the internal names and the display names
local name_map = {
  ours = 'current',
  theirs = 'incoming',
  base = 'ancestor',
  both = 'both',
  none = 'none',
}

local conflict_start = '^<<<<<<<'
local conflict_middle = '^======='
local conflict_end = '^>>>>>>>'
local conflict_ancestor = '^|||||||'

local CURRENT_HL = 'GitConflictCurrent'
local INCOMING_HL = 'GitConflictIncoming'
local ANCESTOR_HL = 'GitConflictAncestor'
local CURRENT_LABEL_HL = 'GitConflictCurrentLabel'
local INCOMING_LABEL_HL = 'GitConflictIncomingLabel'
local ANCESTOR_LABEL_HL = 'GitConflictAncestorLabel'
local NAMESPACE = api.nvim_create_namespace('conflicts')
local PRIORITY = vim.highlight.priorities.user

local DEFAULT_CURRENT_BG_COLOR = 4218238 -- #405d7e
local DEFAULT_INCOMING_BG_COLOR = 3229523 -- #314753
local DEFAULT_ANCESTOR_BG_COLOR = 6824314 -- #68217A

api.nvim_set_hl(0, CURRENT_HL, { background = DEFAULT_CURRENT_BG_COLOR, bold = true, default = true })
api.nvim_set_hl(0, INCOMING_HL, { background = DEFAULT_INCOMING_BG_COLOR, bold = true, default = true })
api.nvim_set_hl(0, ANCESTOR_HL, { background = DEFAULT_ANCESTOR_BG_COLOR, bold = true, default = true })
-- api.nvim_set_hl(0, CURRENT_LABEL_HL, { background = current_label_bg, default = true })
-- api.nvim_set_hl(0, INCOMING_LABEL_HL, { background = incoming_label_bg, default = true })
-- api.nvim_set_hl(0, ANCESTOR_LABEL_HL, { background = ancestor_label_bg, default = true })


---Wrapper around `api.nvim_buf_get_lines` which defaults to the current buffer
local function get_buf_lines(start, _end, buf)
  return api.nvim_buf_get_lines(buf or 0, start, _end, false)
end

---Get cursor row and column as (1, 0) based
local function get_cursor_pos(win_id) return unpack(api.nvim_win_get_cursor(win_id or 0)) end

---Iterate through the buffer line by line checking there is a matching conflict marker
---when we find a starting mark we collect the position details and add it to a list of positions
local function detect_conflicts(lines)
  local positions = {}
  local position, has_start, has_middle, has_ancestor = nil, false, false, false
  for index, line in ipairs(lines) do
    local lnum = index - 1
    if line:match(conflict_start) then
      has_start = true
      position = {
        current = { range_start = lnum, content_start = lnum + 1 },
        middle = {},
        incoming = {},
        ancestor = {},
      }
    end
    if has_start and line:match(conflict_ancestor) then
      has_ancestor = true
      position.ancestor.range_start = lnum
      position.ancestor.content_start = lnum + 1
      position.current.range_end = lnum - 1
      position.current.content_end = lnum - 1
    end
    if has_start and line:match(conflict_middle) then
      has_middle = true
      if has_ancestor then
        position.ancestor.content_end = lnum - 1
        position.ancestor.range_end = lnum - 1
      else
        position.current.range_end = lnum - 1
        position.current.content_end = lnum - 1
      end
      position.middle.range_start = lnum
      position.middle.range_end = lnum + 1
      position.incoming.range_start = lnum + 1
      position.incoming.content_start = lnum + 1
    end
    if has_start and has_middle and line:match(conflict_end) then
      position.incoming.range_end = lnum
      position.incoming.content_end = lnum - 1
      positions[#positions + 1] = position

      position, has_start, has_middle, has_ancestor = nil, false, false, false
    end
  end
  return #positions > 0, positions
end

---Helper function to find a conflict position based on a comparator function
local function find_position(bufnr, comparator, opts)
  local match = {}
  _, match.positions = detect_conflicts(get_buf_lines(0, -1, bufnr))
  if not match then return end
  local line = get_cursor_pos()

  if opts and opts.reverse then
    for i = #match.positions, 1, -1 do
      local position = match.positions[i]
      if comparator(line, position) then return position end
    end
    return nil
  end

  for _, position in ipairs(match.positions) do
    if comparator(line, position) then return position end
  end
  return nil
end

---Retrieves a conflict marker position by checking the visited buffers for a supported range
local function get_current_position(bufnr)
  return find_position(
    bufnr,
    function(line, position)
      return position.current.range_start <= line and position.incoming.range_end >= line
    end
  )
end

---Set an extmark for each section of the git conflict
local function hl_range(bufnr, hl, range_start, range_end)
  if not range_start or not range_end then return end
  return api.nvim_buf_set_extmark(bufnr, NAMESPACE, range_start, 0, {
    hl_group = hl,
    hl_eol = true,
    hl_mode = 'combine',
    end_row = range_end,
    priority = PRIORITY,
  })
end

---Add highlights and additional data to each section heading of the conflict marker
---These works by covering the underlying text with an extmark that contains the same information
---with some extra detail appended.
local function draw_section_label(bufnr, hl_group, label, lnum)
  local remaining_space = api.nvim_win_get_width(0) - api.nvim_strwidth(label)
  return api.nvim_buf_set_extmark(bufnr, NAMESPACE, lnum, 0, {
    hl_group = hl_group,
    virt_text = { { label .. string.rep(' ', remaining_space), hl_group } },
    virt_text_pos = 'overlay',
    priority = PRIORITY,
  })
end

---Highlight each part of a git conflict i.e. the incoming changes vs the current/HEAD changes
local function highlight_conflict()

  position = get_current_position(0)
  if position == nil then return end
  lines = get_buf_lines(0, -1)
  local bufnr = api.nvim_get_current_buf()

  local current_start = position.current.range_start
  local current_end = position.current.range_end
  local incoming_start = position.incoming.range_start
  local incoming_end = position.incoming.range_end
  -- Add one since the index access in lines is 1 based
  local current_label = lines[current_start + 1] 
  local incoming_label = lines[incoming_end + 1]

  local curr_label_id = draw_section_label(bufnr, CURRENT_LABEL_HL, current_label, current_start)
  local curr_id = hl_range(bufnr, CURRENT_HL, current_start, current_end + 1)
  local inc_id = hl_range(bufnr, INCOMING_HL, incoming_start, incoming_end)
  local inc_label_id = draw_section_label(bufnr, INCOMING_LABEL_HL, incoming_label, incoming_end)

  position.marks = {
    current = { label = curr_label_id, content = curr_id },
    incoming = { label = inc_label_id, content = inc_id },
    ancestor = {},
  }
  if not vim.tbl_isempty(position.ancestor) then
    local ancestor_start = position.ancestor.range_start
    local ancestor_end = position.ancestor.range_end
    local ancestor_label = lines[ancestor_start + 1]
    local id = hl_range(bufnr, ANCESTOR_HL, ancestor_start + 1, ancestor_end + 1)
    local label_id = draw_section_label(bufnr, ANCESTOR_LABEL_HL, ancestor_label, ancestor_start)
    position.marks.ancestor = { label = label_id, content = id }
  end
end

--- Select the changes to keep
local function choose(side)
  local bufnr = api.nvim_get_current_buf()
  local position = get_current_position(bufnr)
  if not position then return end
  local lines = {}
  if vim.tbl_contains({ SIDES.OURS, SIDES.THEIRS, SIDES.BASE }, side) then
    local data = position[name_map[side]]
    lines = get_buf_lines(data.content_start, data.content_end + 1)
  elseif side == SIDES.BOTH then
    local first =
      get_buf_lines(position.current.content_start, position.current.content_end + 1)
    local second =
      get_buf_lines(position.incoming.content_start, position.incoming.content_end + 1)
    lines = vim.list_extend(first, second)
  elseif side == SIDES.NONE then
    lines = {}
  else
    return
  end

  local pos_start = position.current.range_start < 0 and 0 or position.current.range_start
  local pos_end = position.incoming.range_end + 1

  api.nvim_buf_set_lines(0, pos_start, pos_end, false, lines)

  api.nvim_buf_clear_namespace(bufnr, NAMESPACE, 0, -1)
  print("'" .. side .. "' chosen")
end


--- KEYMAPS ---
local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}

keymap("n", "co", function() choose("ours") end, opts)
keymap("n", "ct", function() choose("theirs") end, opts)
keymap("n", "cb", function() choose("both") end, opts)

-- next git change
keymap('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal({']c', bang = true})
  else
    require('gitsigns').next_hunk()
    highlight_conflict()
  end
end, opts)

-- previous git change
keymap('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal({'[c', bang = true})
  else
    require('gitsigns').prev_hunk()
    highlight_conflict()
  end
end, opts)

vim.g.conflict_hl_toggle = false
keymap("n", "ch", function() 
    if vim.g.conflict_hl_toggle == true then
        highlight_conflict()
    else
      api.nvim_buf_clear_namespace(0, NAMESPACE, 0, -1)
    end
    vim.g.conflict_hl_toggle = not vim.g.conflict_hl_toggle
end, opts)

keymap("n", "ca", function() 
    vim.api.nvim_command('write')
    conflicts = detect_conflicts(get_buf_lines(0, -1, 0))
    if conflicts == true then
        print("ERROR: Cannot stage with conflicts!")
    else
        print("Buffer was staged")
        require('gitsigns').stage_buffer()
    end
end, opts)
    

