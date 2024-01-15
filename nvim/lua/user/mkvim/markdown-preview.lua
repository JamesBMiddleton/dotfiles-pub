-- something about this is buggy - sometimes it just doesn't work

vim.cmd([[let g:mkdp_auto_start = 1]])
vim.cmd([[let g:mkdp_auto_close = 0]])
vim.cmd([[let g:mkdp_combine_preview = 1]])

-- vim.cmd([[
--     function OpenMarkdownPreview (url)
--         execute "silent ! firefox --new-window " . a:url
--     endfunction
--     let g:mkdp_browserfunc = 'OpenMarkdownPreview'
-- ]])

vim.cmd([[
    let g:mkdp_preview_options = {
        \ 'mkit': {},
        \ 'katex': {},
        \ 'uml': {},
        \ 'maid': {},
        \ 'disable_sync_scroll': 1,
        \ 'sync_scroll_type': 'middle',
        \ 'hide_yaml_meta': 1,
        \ 'sequence_diagrams': {},
        \ 'flowchart_diagrams': {},
        \ 'content_editable': v:false,
        \ 'disable_filename': 0,
        \ 'toc': {}
        \ }
]])
