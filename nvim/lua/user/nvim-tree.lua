local nvim_tree = require "nvim-tree"

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup{
    on_attach = on_attach,
    update_focused_file = {
        enable = true,
        update_cwd = false
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "H",
            info = "I",
            error = "E",
            warning = "W"
        }
    },
    renderer = {
        root_folder_label = false,
        add_trailing = true,
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = true,
          },
          glyphs = {
            git = {
              unstaged = "U",
              staged = "S",
              unmerged = "M",
              renamed = "R",
              untracked = "-",
              deleted = "D",
              ignored = "~",
            },
          },
        },
    },
    view = {
        width = 25,
    },
    git = {
        ignore = false
    }
}

-- open nvim-tree if nvim opened in directory, used to be a simple option...
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end
  vim.cmd.cd(data.file)
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })



--
-- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
--
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
  vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
  vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
  vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
  vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
  vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
  vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
  vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
  vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
  vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
  vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
  vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
  vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
  vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
  vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
  vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
  vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
  vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
  vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
  vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
  vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
  vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
  vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
  vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
  vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
  vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
  vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
  vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
  vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
  vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
  vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
  vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
  vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  -- END_DEFAULT_ON_ATTACH

  -- START_CUSTOM_ON_ATTACH
  -- END_CUSTOM_ON_ATTACH


end


--- KEYMAPS ---

local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}

-- toggle nvim-tree focus
keymap("n", "<leader>e", function()
    local api = require "nvim-tree.api"
    if vim.fn.expand("%") == "NvimTree_1" then
        api.tree.close()
        api.tree.toggle(false, true)
    else
        api.tree.open()
    end
end, opts)

-- toggle nvim-tree
keymap("n", "<leader>E", ":NvimTreeToggle<CR>", opts)


-- OVERRIDE: close buffer without focusing nvim-tree
vim.cmd([[cmap bd Bd]])
vim.api.nvim_create_user_command("Bd", function()
    local ok, result 
    if require "nvim-tree.view".is_visible() then
        local api = require "nvim-tree.api"
        api.tree.close()
        ok, result = pcall(vim.cmd, 'bd')
        api.tree.toggle(false, true)
    else
        ok, result = pcall(vim.cmd, 'bd')
    end
    if not ok then
        vim.cmd([[echo "E88: No write since last change for buffer (add ! to override)"]])
    end
end, {}) 

-- OVERRIDE: force close buffer without focusing nvim-tree
vim.cmd([[cmap bd! Bdforce]])
vim.api.nvim_create_user_command("Bdforce", function()
    if require "nvim-tree.view".is_visible() then
        local api = require "nvim-tree.api"
        api.tree.close()
        vim.cmd([[bd!]])
        api.tree.toggle(false, true)
    else
        vim.cmd([[bd!]])
    end
end, {}) 

-- OVERRIDE: close all but current buffer
vim.api.nvim_create_user_command("Bda", function()
    local ok, result
    if require "nvim-tree.view".is_visible() then
        local api = require "nvim-tree.api"
        api.tree.close()
        ok, result = pcall(vim.cmd, '%bd|e#|bd#')
        api.tree.toggle(false, true)
    else
        ok, result = pcall(vim.cmd, '%bd|e#|bd#')
    end
    if not ok then
        vim.cmd([[echo "E88: No write since last change for buffer (add ! to override)"]])
    end
end, {}) 

-- OVERRIDE: handle nvim-tree edge-case when window splitting
keymap("n", "<C-w><C-h>", function()
    local tree_open = require "nvim-tree.view".is_visible()
    if tree_open then
        require "nvim-tree.api".tree.close()
    end
    local curr = vim.api.nvim_get_current_win()
    vim.cmd([[wincmd h]])
    local new = vim.api.nvim_get_current_win()
    local name = vim.api.nvim_buf_get_name(0)
    if curr == new then
        vim.cmd([[vsplit | b# | wincmd h ]])
    else
        vim.cmd([[wincmd l]])
        name = vim.api.nvim_buf_get_name(0)
        vim.cmd([[b# | wincmd h]])
        vim.cmd([[b ]] .. name)
    end
    if tree_open then
        require "nvim-tree.api".tree.toggle(false, true)
    end
end, opts)

