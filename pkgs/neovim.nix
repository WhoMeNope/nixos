{ pkgs, nur, neovim ? pkgs.neovim, config }:

let
  python3Packages = packages: with packages; [
    jedi
  ];
in

neovim.override {
  vimAlias = true;
  viAlias = true;

  withPython = true;
  withPython3 = true;
  withNodeJs = true;

  extraPython3Packages = python3Packages;

  configure = {
    customRC = config;
    packages.myVimPackages = with pkgs.vimPlugins; {
      start = [
       # core
       vim-commentary
       vim-unimpaired
       vim-surround
       vim-repeat
       ferret
       vim-trailing-whitespace
       vim-signature
       vim-sneak
       vim-abolish
       vim-speeddating

       coc-nvim

       vimwiki

       # files
       fzf-vim
       vim-eunuch
       vim-vinegar

       # git
       vim-fugitive
       vim-gitgutter

       # look
       vim-airline
       NeoSolarized
       distilled-vim

       # languages
       vim-nix
       vim-javascript
       vim-jsx-pretty
       typescript-vim
       haskell-vim
       vim-go
       Jenkinsfile-vim-syntax
       vim-mdx-js
       vim-terraform
       nur.vimPlugins.vim-racket
     ];
     opt = [
       coc-pairs
       coc-lists
       coc-highlight
       coc-snippets
       coc-smartf
       coc-git
       coc-yaml
       coc-json
       coc-vimtex
     ];
   };
 };
}
