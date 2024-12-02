# Apple Nerd Fonts

This repository stores a version of Apple's [San Francisco and New York fonts](https://developer.apple.com/fonts/) (latest as of 1 December 2024) that have been injected with the [Nerd Font Patcher](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-patcher) (with settings `--complete --variable-width-glyphs`).

This repository also provides a Nix flake to allow you to import the fonts into any Nix configuration as an `input`. This is designed as to be an alternative for [apple-fonts.nix](https://github.com/Lyndeno/apple-fonts.nix/) where the fonts are prebuilt as opposed to requiring patching on install, which in my case caused my NixOS build to fail due to over-parallelized patching of the fonts leading to an out of memory condition.

Example using stylix:

```nix
configuration.nix:
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    apple-nerd-fonts.url = "github:gstand/apple-nerd-fonts";
  };

  outputs = { nixpkgs, stylix, ... }: {
    nixosConfigurations."«hostname»" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ stylix.nixosModules.stylix ./stylix.nix ];
    };
  };
}
```

```nix
stylix.nix:
{ inputs, ... }:
{
  stylix = {
    enable = true;

    fonts = {
      sansSerif = {
        package = inputs.apple-nerd-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      serif = {
        name = "New York Nerd Font";
        package = inputs.apple-nerd-fonts.packages.${pkgs.system}.ny-nerd;
      };
    };
  };

}

```

ALL FONTS HEREIN ARE APPLE'S INTELLECTUAL PROPERTY AND ARE PROVIDED HEREIN FOR CONVENIENCE ONLY. PLEASE SEE APPLE'S FONT LICENSE AGREEMENT FOR MORE INFORMATION. NO COPYRIGHT INFRINGEMENT IS INTENDED.
