{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        own-battery-nvim = prev.vimUtils.buildVimPlugin {
          name = "battery";
          src = inputs.plugin-battery;
        };
        own-iterm2-navigator = prev.vimUtils.buildVimPlugin {
          name = "iterm2-navigator";
          src = inputs.plugin-iterm2-navigator;
        };
      };
    })
  ];
}
