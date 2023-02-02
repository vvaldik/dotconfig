call plug#begin("~/.config/nvim/plugged")
  " Plugin Section
  " Plug 'savq/melange' "color theme
  Plug 'EdenEast/nightfox.nvim' "color theme
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'farmergreg/vim-lastplace' "save cursor position
  Plug 'scrooloose/nerdtree' "ide capabilities
  Plug 'ryanoasis/vim-devicons' "icons for ide
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fuzzy finder
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'} "code completion
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-go']
  Plug 'leafgarland/typescript-vim' "typescript support
  Plug 'peitalin/vim-jsx-typescript' "jsx support
  Plug 'chrisbra/Colorizer'
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'kevinoid/vim-jsonc' "jsonc support (json with comments)
call plug#end()

set mouse= "disabling default nvi behavior
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set wildmode=longest:full,full
set guicursor=a:blinkon1 " enable cursor blinking
set guicursor+=i:ver1 " enable vertical cursor when in insert mode

"Config Section
if (has("termguicolors"))
 set termguicolors
endif

lua << END
require('lualine').setup {
  options = { theme = 'valdik' }
}

local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  fox = "nordfox", -- Which fox style should be applied
  transparent = false, -- Disable setting the background color
  alt_nc = false, -- Non current window bg to alt color see `hl-NormalNC`
  terminal_colors = true, -- Configure the colors used when opening :terminal
  styles = {
    comments = "NONE", -- Style that is applied to comments: see `highlight-args` for options
    functions = "NONE", -- Style that is applied to functions: see `highlight-args` for options
    keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
    strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
    variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
  },
  inverse = {
    match_paren = false, -- Enable/Disable inverse highlighting for match parens
    visual = false, -- Enable/Disable inverse highlighting for visual selection
    search = false, -- Enable/Disable inverse highlights for search highlights
  },
  colors = {}, -- Override default colors
  hlgroups = {}, -- Override highlight groups
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()

END

syntax enable
colorscheme nightfox

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" ctrl+space for auto completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"fuzzy finder
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"ctrl+s for save in insert mode
inoremap <silent><c-s> <c-o>:update<cr>

"fix of golang function color
"vim-go syntax highlighting bs
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

highlight goFunction guifg=#F7591B
highlight goFunctionCall guifg=#F17D1C
highlight goFormatSpecifier guifg=#EBCB8B
highlight goEscapeOctal guifg=#EBCB8B                 
highlight goEscapeC guifg=#EBCB8B
highlight goEscapeX guifg=#EBCB8B
highlight goEscapeU guifg=#EBCB8B     
highlight goEscapeBigU guifg=#EBCB8B           
highlight goEscapeError guifg=#EBCB8B
