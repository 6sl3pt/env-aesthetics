{ self, ... }: {

  flake.nixosModules.fonts = { pkgs, ... }: {
    nixpkgs.overlays = [
      self.overlays.ibm-plex-thai
    ];

    fonts.packages = [
      pkgs.nerd-fonts.caskaydia-mono
      pkgs.ibm-plex-thai
    ];
  };

}
