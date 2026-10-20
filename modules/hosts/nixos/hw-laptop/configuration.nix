{
  self,
  ...
}:
{

  flake.nixosModules.hwLaptopConfiguration =
    { ... }:
    {
      imports = [
        self.nixosModules.hwLaptopHardware
        self.nixosModules.btop
        self.nixosModules.cursors
        self.nixosModules.dotfiles
        self.nixosModules.emacs
        self.nixosModules.fonts
        self.nixosModules.git
        self.nixosModules.kitty
        self.nixosModules.noctalia
        self.nixosModules.noctalia-greeter
        self.nixosModules.nvim
        self.nixosModules.pcmanfm-qt
        self.nixosModules.secrets
        self.nixosModules.shell
        self.nixosModules.spicetify
        self.nixosModules.ssh
        self.nixosModules.umbriel
        self.nixosModules.zen-browser
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.systemd-boot.configurationLimit = 10;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixos";
      networking.networkmanager.enable = true;

      time.timeZone = "Asia/Bangkok";

      i18n.defaultLocale = "en_GB.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "th_TH.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };

      services.xserver.xkb = {
        layout = "us,th";
        options = "grp:win_space_toggle";
      };

      security.polkit.enable = true;
      services.pulseaudio.enable = false;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      users.users."phudit" = {
        isNormalUser = true;
        description = "Phudit";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = "26.05";

      my.dotfiles = {
        enable = true;
        user = "phudit";
        source = "/home/phudit/personal/env-aesthetics/dotfiles";
      };

      my.pcmanfm.user = "phudit";

      my.secrets = {
        user = "phudit";
        keyFile = "/home/phudit/.config/sops/age/nix-secrets.txt";
      };

      my.shell = {
        tmuxInit.enable = false;
      };
    };

}
