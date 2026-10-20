{ self, inputs, ... }: {

  flake.nixosConfigurations.hw-laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.hwLaptopConfiguration
    ];
  };

}
