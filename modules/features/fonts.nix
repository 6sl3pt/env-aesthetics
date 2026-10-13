{ self, ... }: {

  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      nerd-fonts.caskaydia-mono
      noto-fonts-color-emoji
      self.packages.${pkgs.system}.ibm-plex-thai
    ];
  };

}
