

{
  description = "A simple Go package";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      # to work with older version of flakes
      lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";

      # Generate a user-friendly version number.
      version = builtins.substring 0 8 lastModifiedDate;

      # System types to support.
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; config = 
        {
          # These are neccesary to allow certain restrictions to be removed
          allowUnfree = true; 
          permittedInsecurePackages = [
                "python3.12-kerberos-1.3.1"
              ];     
        }; 
        }
      );

    in
    {
      # Provide some binary packages for selected system types.
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          hello = pkgs.hello;
        });

      # Add dependencies that are only needed for development
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          #TODO: create other shells and move ansible-related and terraform-related programs to separate shells

          #? usage: 
          #? nix develop .#default
          default = pkgs.mkShell {          
            buildInputs = with pkgs; [ 
            ansible  # IT automation
            aws-azure-login # Terraform uses this to allow access to state files
            awscli2 # Terraform uses this to allow access to state files
            ansible-lint # Linter for Ansible #! install this directly until solution found to get latest
            google-cloud-sdk # Required for accesing Vault
            glibcLocales  # Ansible  needs this [source: https://github.com/NixOS/nixpkgs/issues/223151]
            gomplate
            go-task # Task runner
            htop 
            jq # Utility to display JSON files 
            nodejs # Needed for aws-azure-login
            packer # Template building automation
            pre-commit # Code valudation upon commit
            python3
            python312Packages.flake8
            python312Packages.kerberos # KERBEROS authentication for Ansible to communicate with domain-joined Windows hosts
            python312Packages.pip
            python312Packages.pywinrm # Allow Ansible to manage Windows-hosts
            python312Packages.requests
            sshpass # For those rare cases when SSH is used with password 
            terraform # Infrastructure deployment automation
            terragrunt # Wrapper for Terraform
            tree # Utility to quickly view folder structure
            tmux # Terminal multiplexer
            whois # DNS lookup
            xorriso # Packer needs this in order to build VMWare VM images
            vault-bin # CLI for accessing our Vault #! --> NOT the one without '-bin' [forget about that one! seriously!]
            zsh # A better shell
              ];
            shellHook = ''              
              echo "==>  Entering generic development environment ==>  "
            '';                
          };

          # #? usage: 
          # #? nix develop .#packer
          # packer = pkgs.mkShell {          
          #   buildInputs = with pkgs; [ 

          #     google-cloud-sdk # Required for accesing Vault

          #     htop 
          #     jq # Utility to display JSON files
          #     just # a [better] 'make'-alternative 
          #     packer # Template building automation
          #     pre-commit # Code valudation upon commit

          #     tree # Utility to quickly view folder structure

          #     whois # DNS lookup
          #     xorriso # Packer needs this in order to build VMWare VM images
          #     vault-bin # CLI for accessing our Vault #! --> NOT the one without '-bin' [forget about that one! seriously!]

          #     ];
          #   shellHook = ''              
          #     echo "==>  Entering PACKER development environment ==>  "
          #   '';                
          # };

          # #? usage: 
          # #? nix develop .#ansible
          # ansible = pkgs.mkShell {         
          #   buildInputs = with pkgs; [ 
          #     ansible  # IT automation
          #     ansible-lint # Linter for Ansible #! install this directly until solution found to get latest
          #     google-cloud-sdk # Required for accesing Vault
          #     glibcLocales  # Ansible  needs this [source: https://github.com/NixOS/nixpkgs/issues/223151]
          #     just # a [better] 'make'-alternative 
          #     pre-commit # Code valudation upon commit
          #     python3
          #     python312Packages.flake8
          #     python312Packages.kerberos # KERBEROS authentication for Ansible to communicate with domain-joined Windows hosts              #FIXME: this needs inseucre packages!
          #     python312Packages.pip
          #     python312Packages.pywinrm # Allow Ansible to manage Windows-hosts
          #     python312Packages.requests
          #     python312Packages.ruamel-yaml #! allowws using: ruamel-yaml:0.18.6
          #     sshpass # For those rare cases when SSH is used with password 
          #     tree # Utility to quickly view folder structure
          #     vault-bin # CLI for accessing our Vault #! --> NOT the one without '-bin' [forget about that one! seriously!]

          #     ];
          #   shellHook = ''
          #     echo "==>  Entering Ansible development environment ==>  "
          #   '';                 
          # };  
                  
        });

      # The default package for 'nix build'. This makes sense if the
      # flake provides only one package or there is a clear "main"
      # package.
      defaultPackage = forAllSystems (system: self.packages.${system}.hello);
    };
}
