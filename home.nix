{ config, pkgs, inputs, ... }:

{
  home.username = "felix";
  home.homeDirectory = "/Users/felix";
  home.stateVersion = "23.05";

    # Custom shell commands can be executed here
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ripgrep
    fd
    zsh
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  #};

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/felix/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "vi";
  };

  # ZSH setup
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    loginExtra = "neofetch --ascii_distro NixOS";
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "common-aliases" 
        "dirhistory"
      ];
      theme = "eastwood";
    };
  };

  # Neovim Setup
  programs.neovim = 
  let
    fileToString = file: "${builtins.readFile file}";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = fileToString ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        type = "lua";
        config = ''require("Comment").setup()'';
      }

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      neodev-nvim

      nvim-cmp 
      {
        plugin = nvim-cmp;
        type = "lua";
        config = fileToString ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = fileToString ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-bash
          p.tree-sitter-json
          p.tree-sitter-lua
          p.tree-sitter-nix
          p.tree-sitter-python
          p.tree-sitter-vim
          p.tree-sitter-vimdoc
        ]));
        type = "lua";
        config = fileToString ./nvim/plugin/treesitter.lua;
      }

      vim-nix

      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = fileToString ./nvim/plugin/web-devicons.lua;
      }

      {
        plugin = own-battery-nvim;
        type = "lua";
        config = ''require("battery").setup({})'';
      }

      {
        plugin = lualine-nvim;
        type = "lua";
        config = fileToString ./nvim/plugin/lualine.lua;
      }

      vim-tmux-navigator
      vim-tmux

      own-iterm2-navigator

    ];
    
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };

  programs.tmux = {
    enable = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-s";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      gruvbox
      battery
    ];
    extraConfig = ''
      ${builtins.readFile ./tmux/options.conf}
    '';
  };

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
