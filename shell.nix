
let
  pkgs = import (fetchTarball https://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz) { };

in pkgs.mkShell {
  packages = with pkgs; [

    hello # just check if nix is working

    #? Packages for Ansible
    ansible  # IT automation
    ansible-lint # Linter for Ansible #! install this directly until solution found to get latest
    glibcLocales  # Ansible  needs this [source: https://github.com/NixOS/nixpkgs/issues/223151]
    python3
    # python311Packages.flake8
    python311Packages.pykerberos # KERBEROS authentication for Ansible to communicate with domain-joined Windows hosts
    python311Packages.pip
    python311Packages.pywinrm # Allow Ansible to manage Windows-hosts
    # python311Packages.requests
    # python311Packages.ruamel-yaml #! allowws using: ruamel-yaml:0.18.6
    sshpass # For those rare cases when SSH is used with password 

    #? Packages for Terraform
    aws-azure-login # Terraform uses this to allow access to state files
    awscli2 # Terraform uses this to allow access to state files
    terraform # Infrastructure deployment automation
    terragrunt # Wrapper for Terraform
    nodejs # Needed for aws-azure-login

    #? Packages for Vault access
    google-cloud-sdk # Required for accesing Vault
    vault-bin # CLI for accessing our Vault #! --> NOT the one without '-bin' [forget about that one! seriously!]

    #? Packages for Packer
    packer # Template building automation
    xorriso # Packer needs this in order to build VMWare VM images

    #? Utilities
    # gomplate
    go-task # Task runner
    htop 
    jq # Utility to display JSON files 
    tree # Utility to quickly view folder structure
    tmux # Terminal multiplexer
    whois # DNS lookup

    #? Developper tools
    pre-commit # Code valudation upon commit    
    zsh # A better shell

  ];
}