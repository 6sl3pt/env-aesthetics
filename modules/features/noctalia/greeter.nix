{ inputs, ... }: {

  flake.nixosModules.noctalia-greeter = { pkgs, ... }: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    services.displayManager.noctalia-greeter = {
      enable = true;
      passwordless-sync-users = [ "phudit" ];
      settings = {
        appearance = {
          scheme = "Synced";
          hide_logo = true;
        };
        cursor = {
          theme = "Bibata-Modern-Classic";
          size = 24;
          path = pkgs.bibata-cursors;
        };
      };
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
  };

}
