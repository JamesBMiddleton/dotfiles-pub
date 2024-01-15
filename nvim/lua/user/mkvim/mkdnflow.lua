local mkdnflow = require "mkdnflow"

-- https://github.com/jakewvincent/mkdnflow.nvim#config-descriptions
mkdnflow.setup({
    modules = {
        bib = false, -- parse bib files and follow citations
        buffers = false, -- buffer navigation
        conceal = true, -- link concealing
        cursor = false, -- using tab to jump between links
        folds = false, -- folding sections
        links = true, -- following links
        lists = false, -- list manip
        maps = true, -- to set custom mappings below
        paths = true, -- link interpretation and following links
        tables = false,
        yaml = false, -- parse yaml blocks
        cmp = false -- link autocompletion
    },
    filetypes = {md = true, rmd = true, markdown = true},
    create_dirs = false,
    perspective = {
        priority = 'root', -- links are relative to current dir
        fallback = 'current',
        root_tell = 'INDEX.md',
        nvim_wd_heel = false,
        update = false
    },    
    wrap = false, -- not relevant unless 'cursor' module enabled
    silent = false,
    links = {
        style = 'markdown',
        name_is_source = true, -- obsidian style [[source]] links
        conceal = true,
        context = 0,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
            return(text)
        end
    },
    mappings = {
        MkdnEnter = {{'n', 'v'}, '<CR>'},
        MkdnTab = false,
        MkdnSTab = false,
        MkdnNextLink = false,
        MkdnPrevLink = false,
        MkdnNextHeading = false,
        MkdnPrevHeading = false,
        MkdnGoBack = false,
        MkdnGoForward = false,
        MkdnCreateLink = false, -- see MkdnEnter
        MkdnCreateLinkFromClipboard = false,
        MkdnFollowLink = false, -- see MkdnEnter
        MkdnDestroyLink = false,
        MkdnTagSpan = false,
        MkdnMoveSource = false,
        MkdnYankAnchorLink = false,
        MkdnYankFileAnchorLink = false,
        MkdnIncreaseHeading = false,
        MkdnDecreaseHeading = false,
        MkdnToggleToDo = false,
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = false,
        MkdnNewListItemAboveInsert = false,
        MkdnExtendList = false,
        MkdnUpdateNumbering = false,
        MkdnTableNextCell = false,
        MkdnTablePrevCell = false,
        MkdnTableNextRow = false,
        MkdnTablePrevRow = false,
        MkdnTableNewRowBelow = false,
        MkdnTableNewRowAbove = false,
        MkdnTableNewColAfter = false,
        MkdnTableNewColBefore = false,
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
    }
})
