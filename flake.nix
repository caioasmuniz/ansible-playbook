{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs;[
          nixpkgs-fmt
          nil

          ansible
          ansible-lint
          docker
          python311
        ];
        shellHook = ''
          ansible-galaxy install -r requirements.yml
        '';
      };
    };
}
