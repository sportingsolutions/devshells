{
  description = "my nixops configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixops-flake.url = "github:input-output-hk/nixops-flake";
    nixpkgs.url = "github:NixOS/nixpkgs";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {

    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, ... }@inputs:
    let pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
      devShell.x86_64-linux = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          ({ pkgs, config, ... }: {
            # This is your devenv configuration
            packages = with pkgs; [

              # Packages for Ansible
              ansible
              ansible-lint
              glibcLocales
              python3
              python311Packages.dnspython
              python311Packages.mitogen # https://www.linkedin.com/pulse/how-speed-up-ansible-playbooks-drastically-lionel-gurret          # ❯ python -c "import mitogen; print(mitogen.__file__)"
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
              just
              tree
              tmux
              whois

              # Developer tools
              niv
              nixfmt-rfc-style
              nixfmt-classic
              pre-commit

              # Terminal
              zsh
              tmux

              # Default packages from Nixpkgs
              hello
              # nixops-flake.defaultPackage.${system}
            ];

            enterShell = ''
              hello
            '';

            processes.run.exec = "hello";
          })
        ];
      };
    };
}
