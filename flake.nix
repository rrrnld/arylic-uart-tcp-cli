{
  description = "A flake describing the build and dev environment for arnes.space";
  inputs.nixpkgs.url = github:NixOS/nixpkgs;

  outputs = { self, nixpkgs }: let
    platform = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${platform};
  in {
    devShell.${platform} = pkgs.mkShell {
      buildInputs = with pkgs; [
        janet
        multimarkdown
        entr
        sassc
      ];
    };
  };
}
