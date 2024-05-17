{
  description = "my nixops configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixops-flake.url = "github:input-output-hk/nixops-flake";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, nixops-flake }:
    flake-utils.lib.eachDefaultSystem
      (system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              # Packages for Ansible
              ansible
              ansible-lint
              glibcLocales
              python3
              python311Packages.dnspython
              python311Packages.pykerberos
              python311Packages.pip
              python311Packages.pyspnego
              python311Packages.pywinrm
              sshpass

              # Packages for Terraform
              aws-azure-login
              awscli2
              terraform
              terragrunt
              nodejs

              # Packages for Vault access
              google-cloud-sdk
              vault-bin

              # Packages for Packer
              packer
              xorriso

              # Utilities
              go-task
              htop 
              jq 
              tree
              tmux
              whois

              # Developer tools
              niv
              pre-commit
              zsh

              # Default packages from Nixpkgs
              hello
              nixops-flake.defaultPackage.${system}
            ];
          };
        }
      );
}
