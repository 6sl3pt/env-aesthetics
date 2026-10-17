{ inputs, ... }: {

  flake.nixosModules.wslCommonConfiguration = { ... }: {
    imports = [
      inputs.nix-wsl.nixosModules.default
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    wsl.enable = true;
    wsl.defaultUser = "phudit";

    users.users.phudit = {
      isNormalUser = true;
      description = "Phudit";
      extraGroups = [
        "wheel"
      ];
    };

    system.stateVersion = "26.05";
    time.timeZone = "Asia/Bangkok";
  };

}
