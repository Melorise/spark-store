{
  description = "星火应用商店";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    amber-pm = {
      url = "github:Melorise/amber-pm/nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, amber-pm, ... }:
    {
      packages = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ] (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          spark-store = pkgs.callPackage ./nix/package.nix {
            apm = amber-pm.packages.${system}.default;
          };
        in
        {
          inherit spark-store;
          default = spark-store;
        }
      );
    };
}
