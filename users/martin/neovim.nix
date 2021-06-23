{ pkgs, ... }:

{
  enable = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  withRuby = true;
  withPython3 = true;
  extraPython3Packages = p: with p; [ jedi ];
  withNodeJs = true;

  extraConfig = builtins.readFile ./neovim.vim;

  extraPackages = with pkgs; [
    git

    # fzf-vim
    fzf
    ripgrep
    bat
    delta
  ];

  plugins =
    with pkgs.vimPlugins;
    with pkgs.tinybeachthor.vimPlugins; [
      # core
      { plugin = vim-commentary; }
      { plugin = vim-unimpaired; }
      { plugin = vim-surround; }
      { plugin = vim-repeat; }
      { plugin = ferret;
        config = ''
          nnoremap <leader><S-a> :<C-u>Back<space>
        '';
      }
      { plugin = vim-trailing-whitespace; }
      { plugin = vim-signature; }
      { plugin = vim-sneak; }
      { plugin = vim-abolish; }
      { plugin = vim-speeddating; }
      { plugin = tabular; }

      { plugin = coc-nvim; }

      # files
      { plugin = fzf-vim; }
      { plugin = vim-eunuch;
        config = ''
          let g:netrw_preview   = 1
          let g:netrw_liststyle = 2
          let g:netrw_winsize   = 20
          let g:netrw_banner    = 0
          let g:netrw_altv      = 1
          let g:netrw_list_hide = netrw_gitignore#Hide() . '.*\.swp$,.*\.un\~$,.git/$'
        '';
      }
      { plugin = vim-vinegar; }

      # git
      { plugin = vim-fugitive; }
      { plugin = vim-gitgutter;
        config = ''
          let g:gitgutter_override_sign_column_highlight = 0
          let g:SignatureMarkerTextHLDynamic = 1
        '';
      }

      # look
      { plugin = vim-airline;
        config = ''
          set noshowmode " Hide mode indicator - included in airline
          let g:airline#extensions#tabline#enabled = 1
          let g:airline#extensions#tabline#buffer_idx_mode = 1
          let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
          let g:airline_section_z = '%3p%% %3l/%L:%3v'

          nmap <silent> <leader>1 <Plug>AirlineSelectTab1
          nmap <silent> <leader>2 <Plug>AirlineSelectTab2
          nmap <silent> <leader>3 <Plug>AirlineSelectTab3
          nmap <silent> <leader>4 <Plug>AirlineSelectTab4
          nmap <silent> <leader>5 <Plug>AirlineSelectTab5
          nmap <silent> <leader>6 <Plug>AirlineSelectTab6
          nmap <silent> <leader>7 <Plug>AirlineSelectTab7
          nmap <silent> <leader>8 <Plug>AirlineSelectTab8
          nmap <silent> <leader>9 <Plug>AirlineSelectTab9
          nmap <silent> <leader>0 <Plug>AirlineSelectTab10

          " switch to last buffer
          nnoremap <silent> <Leader>- :b#<CR>

          nmap <silent> <leader>v1 <C-w><C-v><Plug>AirlineSelectTab1
          nmap <silent> <leader>v2 <C-w><C-v><Plug>AirlineSelectTab2
          nmap <silent> <leader>v3 <C-w><C-v><Plug>AirlineSelectTab3
          nmap <silent> <leader>v4 <C-w><C-v><Plug>AirlineSelectTab4
          nmap <silent> <leader>v5 <C-w><C-v><Plug>AirlineSelectTab5
          nmap <silent> <leader>v6 <C-w><C-v><Plug>AirlineSelectTab6
          nmap <silent> <leader>v7 <C-w><C-v><Plug>AirlineSelectTab7
          nmap <silent> <leader>v8 <C-w><C-v><Plug>AirlineSelectTab8
          nmap <silent> <leader>v9 <C-w><C-v><Plug>AirlineSelectTab9
          nmap <silent> <leader>v0 <C-w><C-v><Plug>AirlineSelectTab10

          nmap <silent> <leader>s1 <C-w><C-s><Plug>AirlineSelectTab1
          nmap <silent> <leader>s2 <C-w><C-s><Plug>AirlineSelectTab2
          nmap <silent> <leader>s3 <C-w><C-s><Plug>AirlineSelectTab3
          nmap <silent> <leader>s4 <C-w><C-s><Plug>AirlineSelectTab4
          nmap <silent> <leader>s5 <C-w><C-s><Plug>AirlineSelectTab5
          nmap <silent> <leader>s6 <C-w><C-s><Plug>AirlineSelectTab6
          nmap <silent> <leader>s7 <C-w><C-s><Plug>AirlineSelectTab7
          nmap <silent> <leader>s8 <C-w><C-s><Plug>AirlineSelectTab8
          nmap <silent> <leader>s9 <C-w><C-s><Plug>AirlineSelectTab9
          nmap <silent> <leader>s0 <C-w><C-s><Plug>AirlineSelectTab10

          " split with last buffer
          nnoremap <silent> <Leader>v- :vsplit<CR>:b#<CR>
          nnoremap <silent> <Leader>s- :split<CR>:b#<CR>

        '';
      }
      { plugin = NeoSolarized;
        config = ''
          " terminal color normalization fixes
          if &term =~ '256color'
            " disable Background Color Erase (BCE) so that color schemes
            " render properly when inside 256-color tmux and GNU screen.
            " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
            set t_ut=
          endif
          let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
          let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
          set termguicolors

          set colorcolumn=100

          set background=light
          colorscheme NeoSolarized
        '';
      }

      # languages
      { plugin = vim-nix; }
      { plugin = vim-javascript; }
      { plugin = vim-jsx-pretty; }
      { plugin = typescript-vim; }
      { plugin = haskell-vim; }
      { plugin = vim-go; }
      { plugin = Jenkinsfile-vim-syntax; }
      { plugin = vim-mdx-js; }
      { plugin = vim-terraform; }
      { plugin = vim-racket; }
      { plugin = pkgs.parinfer-rust; }
      { plugin = vimtex; }
    ];
}
