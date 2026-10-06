{ ... }: {

  flake.nixosModules.ssh = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      openssl
    ];

    programs.ssh = {
      extraConfig = ''
        Include $HOME/.ssh/config.d/*

        Host *
          IPQoS none

        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/id_ed25519_personal
          IdentitiesOnly yes
          KexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org
      '';
    };
  };

}
