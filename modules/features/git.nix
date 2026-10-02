{ ... }: {

  flake.nixosModules.git = { ... }: {
    programs.git = {
      enable = true;

      config = {
        user = {
          name = "6sl3pt";
          email = "eochannelformal@gmail.com";
        };

        includeIf."gitdir:~/projects/".path = "~/projects/.gitconfig";
      };
    };
  };

}

