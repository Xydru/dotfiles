{ pkgs, ... }: {
  users.users."felix" = {
    name = "felix";
    home = "/Users/felix";
    shell = pkgs.zsh;
  };

  # here go the darwin preferences and config items
  programs.zsh = {
    enable = true;
    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };

  environment = with pkgs; {
    loginShell = zsh;
    systemPath = [ "/opt/homebrew/bin" ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  fonts.fontDir.enable = true;
  fonts.fonts = [ pkgs.nerdfonts ];
  services.nix-daemon.enable = true;
  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 2;
  };

  system.activationScripts = 
  let
    USER = "felix";
    PROJECT_ROOT = builtins.toString ./.;
  in {
    extraActivation.text = ''
      # Custom shell commands can be executed here
      cp ${PROJECT_ROOT}/iterm/preferences/com.googlecode.iterm2.plist /Users/${USER}/Library/Preferences
      cp ${PROJECT_ROOT}/skim/preferences/net.sourceforge.skim-app.skim.plist /Users/${USER}/Library/Preferences
    '';
  };

  # backwards compat; don't change
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
