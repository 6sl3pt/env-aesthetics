{ self, inputs, ... }: {

  flake.nixosConfigurations.wsl = inputs.pkgs-2605.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.wslConfiguration
    ];
  };

}
