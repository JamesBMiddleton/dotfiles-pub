vim.opt.wrap = true
vim.opt.colorcolumn = ""
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.background = 'light'
vim.opt.number = false




-- refresh the file every 4 seconds if cursor isn't moving, to keep in
-- sync with mobile
vim.cmd([[set autoread | au CursorHold * checktime | call feedkeys("lh")]])



-- auto-save 
vim.api.nvim_create_autocmd({"TextChanged", 
                            "TextChangedI", 
                            "TextChangedT"},
                            {command = "silent wa"})

local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}


-- unique note creation
keymap("n", "<C-n>", function()
    name = vim.fn.input("filename: ")
    if name == "" then
        name = "daily"
    end
    local date = vim.fn.system("date +'%Y%m%d%H%M'")
    file = name .. " " .. date:sub(0,-2) .. ".md"
    vim.cmd("silent !touch " .. "'" .. file .. "'")
    template = '***\\ntags:\\nstatus: \\#atomic\\n***\\n'
    vim.cmd("silent !printf " .. "'" .. template .. "' >> " .. "'" .. file .. "'") 
    vim.cmd("e " .. file)

end, opts)

keymap("n", "j", "gj", opts) -- visual line navigation
keymap("n", "k", "gk", opts)
