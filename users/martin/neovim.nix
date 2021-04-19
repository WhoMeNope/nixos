{ pkgs, ... }:

{
  enable = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  withRuby = true;
  withPython = true;
  withPython3 = true;
  withNodeJs = true;

  extraPythonPackages = p: with p; [ ];
  extraPython3Packages = p: with p; [ jedi ];

  configure = {
    customRC = builtins.readFile ./neovim.vim;
    packages.myVimPackages =
      with pkgs.vimPlugins;
      with pkgs.tinybeachthor.vimPlugins; {
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
       tabular

       coc-nvim

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
       vim-simplicity
       toast-vim

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
       vim-racket
       pkgs.parinfer-rust
       agda-vim
       vimtex
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
