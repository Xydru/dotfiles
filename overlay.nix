{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        own-battery-nvim = prev.vimUtils.buildVimPlugin {
          name = "battery";
          src = inputs.plugin-battery;
        };
        own-mini-hipatterns = prev.vimUtils.buildVimPlugin {
          name = "mini-hipatterns";
          src = inputs.plugin-mini-hipatterns;
        };
      };
    })
  ];
}
