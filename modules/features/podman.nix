{ ... }: {

  flake.nixosModules.podman = { pkgs, ... }: {
    virtualisation.podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = with pkgs; [
      podman-compose
    ];

    boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
  };

}
