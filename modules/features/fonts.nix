{ self, ... }: {

  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      nerd-fonts.caskaydia-mono
      noto-fonts-color-emoji
      undefined-medium
      self.packages.${pkgs.stdenv.hostPlatform.system}.ibm-plex-thai
    ];
  };

}
