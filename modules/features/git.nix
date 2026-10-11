{ ... }: {

  flake.nixosModules.git = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      betterleaks
    ];

    programs.git = {
      enable = true;

      config = {
        init.defaultBranch = "main";
        init.templateDir = "~/.config/git/template";
        core.editor = "vim";
      };
    };
  };

}
