# Usage

## With .direnv

- To load the default shell, create an .envrc file in the folder:

```sh
# $ cat /home/808fsemti/tmp/devshells/.envrc
use flake .#
```

- You can load other sells too, for example to work with Ansible:

```sh
# $ cat /home/808fsemti/tmp/devshells/.envrc
use flake .#ansible
```

## Without .direnv

```sh
# Load Ansible-shell
nix develop github:sportingsolutions/devshells#ansible
```

or

```sh
# Load default-shell
nix develop github:sportingsolutions/devshells#
```

## Find available shells:

```sh
nix flake show github:sportingsolutions/devshells
github:sportingsolutions/devshells/8bfdf888529bec80af935c75eb142b7d33719645?narHash=sha256-ToEoQN15%2B4OEqBhd%2BwbIpSLJQzJJ7B4J1xC3EKMZkWw%3D
├───defaultPackage
│   ├───aarch64-darwin omitted (use '--all-systems' to show)
│   ├───aarch64-linux omitted (use '--all-systems' to show)
│   ├───x86_64-darwin omitted (use '--all-systems' to show)
│   └───x86_64-linux: package 'hello-2.12.1'
├───devShells
│   ├───aarch64-darwin
│   │   ├───ansible omitted (use '--all-systems' to show)
│   │   └───default omitted (use '--all-systems' to show)
│   ├───aarch64-linux
│   │   ├───ansible omitted (use '--all-systems' to show)
│   │   └───default omitted (use '--all-systems' to show)
│   ├───x86_64-darwin
│   │   ├───ansible omitted (use '--all-systems' to show)
│   │   └───default omitted (use '--all-systems' to show)
│   └───x86_64-linux
│       ├───ansible: development environment 'nix-shell'
│       └───default: development environment 'nix-shell'
└───packages
    ├───aarch64-darwin
    │   └───hello omitted (use '--all-systems' to show)
    ├───aarch64-linux
    │   └───hello omitted (use '--all-systems' to show)
    ├───x86_64-darwin
    │   └───hello omitted (use '--all-systems' to show)
    └───x86_64-linux
        └───hello: package 'hello-2.12.1'
```

(the `devShells/<system architecture>/**` path should show the available shellw)