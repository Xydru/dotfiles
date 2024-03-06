{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        own-battery-nvim = prev.vimUtils.buildVimPlugin {
          name = "battery";
          src = inputs.plugin-battery;
        };
      };
    })
  ];
}
