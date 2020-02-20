call plug#begin('~/.vim/plugged')
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/tango.vim'
call plug#end()

filetype plugin indent on
colorscheme tango
syntax enable

" Line numbering
set nu
highlight LineNr ctermbg=255 ctermfg=101

" Change <Leader>
let mapleader=","

" Quick timeouts on key combinations.
set timeoutlen=300

" Set some basic global defaults.
if !has('nvim')
  set viminfo='50,<1000,s100,:0,n~/.viminfo
endif
set notitle
set nobackup
set mousehide
set nofoldenable
set nojoinspaces
set nowrap
set wildchar=^I
set ts=2
set sw=2
set et
set noerrorbells
set vb t_vb=
set modeline
set modelines=5
set sidescroll=1
set sidescrolloff=3
set autoindent

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase

" Move up/down by screen row instead of line.
nmap j gj
nmap k gk

" Allow switching edited buffers without saving.
set hidden

" Use the system clipboard.
set clipboard^=unnamedplus

" ` is more useful than ' but less accessible.
nnoremap ' `
nnoremap ` '

" Toggle highlighting.
nmap <silent> <leader>q :silent :nohlsearch<CR>

" Fix command typos.
nmap ; :

" Buffer management
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-d> :bw<CR>

" Scroll better.
set scrolloff=3
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Wrap text in Markdown files.
autocmd BufEnter *.md set wrap linebreak nolist nofoldenable tw=72

" Visual Studio project files are basically XML.
au BufRead,BufNewFile *.proj set filetype=xml
au BufRead,BufNewFile *.vcxproj set filetype=xml

" C-like files
au BufRead,BufNewFile *.cs set ts=4 et sw=4 sts=4 tw=72 ai
au BufRead,BufNewFile *.cpp set ts=4 et sw=4 sts=4 tw=72 ai

" This is slow, but it ensures that syntax highlights stay in sync.
au BufEnter * :syntax sync minlines=500

" Configure airline.
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_theme = 'light'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_min_count = 2

" Configure ALE
let g:ale_sign_column_always = 1
let g:ale_sign_error = '▶▶'
let g:ale_sign_warning = '▶▶'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight SignColumn ctermbg=255 ctermfg=Green
highlight ALEErrorSign ctermbg=255 ctermfg=Red
highlight ALEWarningSign ctermbg=255 ctermfg=DarkYellow

" Configure file finder
nmap <silent> <leader>t :GFiles<CR>

"===== Begin OmniSharp configuration =====

" Use the stdio OmniSharp-roslyn server
"let g:OmniSharp_server_stdio = 1

" Set the type lookup function to use the preview window instead of echoing it
"let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

" Fetch full documentation during omnicomplete requests.
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

" Update semantic highlighting on BufEnter and InsertLeave
let g:OmniSharp_highlight_types = 2

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Enable snippet completion
let g:OmniSharp_want_snippet=1

" Configure asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

"===== End OmniSharp configuration =====

" Rewrap the current paragraph with Leader-r.
nnoremap <silent> <leader>r gq}

" Find common non-ASCII characters.
nmap <silent> <leader>u /\([‘’”“—…·®ﬁ‬‭  ]\\| \+$\)<CR>

" vim: set ts=2 sw=2 et:
