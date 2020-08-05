let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline = {
      \ 'colorscheme': 'ayu_mirage',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename' ] ],
      \   'right':  [ ['lineinfo'],
      \             [ 'linenoindicator' ],
      \             [ 'rvm' ],
      \             [ 'fileformat' ],
      \             [ 'fileencoding' ],
      \             [ 'filetype' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'Lightlinegit',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'rvm': 'rvm#statusline',
      \   'filename': 'LightlineFilename',
      \   'readonly': 'LightLineReadonly',
      \   'currentfunction'  : 'CocCurrentFunction',
      \   'method'  : 'NearestMethodOrFunction',
      \   'mode'  : 'LightlineMode',
      \   'linenoindicator'  : 'LineNoIndicator',
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \   'cocerror': 'LightLineCocError',
      \   'cocwarn': 'LightLineCocWarn',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \   'cocerror': 'error',
      \   'cocwarn' : 'warning',
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [['cocerror', 'cocwarn', 'currentfunction' ]]
      \ }
      \ }

function! LightlineMode()
  return &filetype ==# 'vista' ? 'VISTA' :
        \ &filetype ==# 'ctrlsf' ? 'CTRLSF' :
        \ &filetype ==# 'fugitive' ? 'FUGITIVE' :
        \ &filetype ==# 'fzf' ? 'FZF' :
        \ lightline#mode()
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineFilename()
  let modified = &modified ? ' +' : ''
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:] . modified
  endif
  return expand('%') . modified
endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineCocError()
  let s:error_sign = get(g:, 'coc_status_error_sign')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif
  let errmsgs = []
  if get(info, 'error', 0)
    call add(errmsgs, s:error_sign . info['error'])
  endif
  return trim(join(errmsgs, ' ') . ' ' . get(g:, 'coc_status', ''))
endfunction

function! LightLineCocWarn() abort
  let s:warning_sign = get(g:, 'coc_status_warning_sign')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif
  let warnmsgs = []
  if get(info, 'warning', 0)
    call add(warnmsgs, s:warning_sign . info['warning'])
  endif
  return trim(join(warnmsgs, ' ') . ' ' . get(g:, 'coc_status', ''))
endfunction

function! Lightlinegit()
  let l:branch = fugitive#head()
  return l:branch ==# '' ? '' : ' ' . l:branch
endfunction


function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

autocmd User CocDiagnosticChange call lightline#update()
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
