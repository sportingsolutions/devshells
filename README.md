# Usage

# Install nix package manager [note: this is done on `dc1devjump02p`!]

You will need [Nix](https://nixos.org/download/).
We could get - and probably will - get the fullblown NixOS, but for the time being we only use the package manager [and a Debian OS].

Installer scripts:

- a prefered one: <https://zero-to-nix.com/start/install>
- alternatively you can use the one on the main page <https://nixos.org/download/> (make sure to pick multi-user install!)

## Edit the `/etc/nix/nix` file [note: this is done on `dc1devjump02p`!]

```sh
 cat /etc/nix/nix.conf 
# Generated by https://github.com/DeterminateSystems/nix-installer.
# See `/nix/nix-installer --version` for the version details.

build-users-group = nixbld
experimental-features = nix-command flakes repl-flake
auto-optimise-store = true
bash-prompt-prefix = (nix:$name)\040
max-jobs = auto
extra-nix-path = nixpkgs=flake:nixpkgs
upgrade-nix-store-path-url = https://install.determinate.systems/nix-upgrade/stable/universal
```
> note: `sudo` is needed to edit this file

The 2 key lines lines you need to have are:

```sh
...
build-users-group = nixbld
experimental-features = nix-command flakes repl-flake
...
```

## Direnv

### Installation

Ensure [direnv](https://direnv.net/) is installed and [hooked to your shell](https://direnv.net/docs/hook.html)

> note: on `dc1devjump02p` the program is installed, but _your shell profile is your responsibility!_

### Configuration

- direnv uses an `.envrc` file to add things to your `env` --> create a folder (mine is `/home/808fsemti/projects`) that will contain _all_ the working repos you have

> note: the reason for this is you want the programs available for all the projects of ours

- copy the template `.envrc` file to your project folder

```sh
cp .envrc_example /home/123JBloggs/myprojects/.envrc
```
- fill the blank values (refer mostly to our LastPass for the missing information)

> note: obviously replace the `123JBloggs/myprojects` with your actual values!

- now go to the folder and allow direnv to use this file (you will get a warning when entering; that is OK) with `direnv allow`

## Nix

Download the `flake.nix` and place it to the (same as above) project folder of yours. Then enter to this folder

### Validate

If done correctly, you will see something along the lines of:

```sh
808fsemti in 🌐 dc1devjump02p in devshells on  dev [⇡] on ☁️  fsemti@sportinggroup.co.uk
❯ cd ~/projects/
copying '/' to the storedirenv: ([/usr/bin/direnv export bash]) is taking a while to execute. Use CTRL-C to give up.
....
Hello, world!
```

This means:
- direnv is working
- it uses the nix file 
- it will load all the programs listed in the `flake.nix` file

> note: on a new system, **this will take time** as there is a _lot_ to download; but due to the way `nix` works, if you are using a system where the packages are already there, so the load time should not be bad

To test all is well, do a single command:

```sh
hello
Hello, world!
```

If you get this, you can now use all the programs I defined here. They will be loaded each time you `cd` into the project folder or to any of it's subfolders, and will be available for use.

<details>
  <summary>bonus check: if you want to, you can also look under the hood</summary>

```sh
808fsemti in 🌐 dc1devjump02p in ~/projects via ❄️  impure (nix-shell) on ☁️  fsemti@sportinggroup.co.uk took 17s
❯ which packer
/nix/store/f93hg0kc069kqzqd24mrrx92midnpbiw-packer-1.10.3/bin/packer

808fsemti in 🌐 dc1devjump02p in ~/projects via ❄️  impure (nix-shell) on ☁️  fsemti@sportinggroup.co.uk
❯ which ansible
/nix/store/pzfspr5w3ii79apxq26xx4pcj5jv765l-python3.11-ansible-core-2.16.5/bin/ansible
```

- as you can see, `nix` makes you use a program that is in the `nix store` (you can read up on this if you like)
- the program is symlinked to the store path
- an actually installed program is in `/bin` folders, ie.

```sh
❯ which direnv
/usr/bin/direnv
```

- however, the programs defined in the `flake.nix` are only available in the folder you put it and it's children
- if you leave the folder, the nix-programs wont be available for you (but the ones in `/bin` will be)

```sh
808fsemti in 🌐 dc1devjump02p in ~/projects via ❄️  impure (nix-shell) on ☁️  fsemti@sportinggroup.co.uk
❯ pwd
/home/808fsemti/projects

808fsemti in 🌐 dc1devjump02p in ~/projects via ❄️  impure (nix-shell) on ☁️  fsemti@sportinggroup.co.uk
❯ which packer
/nix/store/f93hg0kc069kqzqd24mrrx92midnpbiw-packer-1.10.3/bin/packer

808fsemti in 🌐 dc1devjump02p in ~/projects via ❄️  impure (nix-shell) on ☁️  fsemti@sportinggroup.co.uk
❯ which direnv
/usr/bin/direnv

808fsemti in 🌐 dc1devjump02p in ~/projects via ❄️  impure (nix-shell) on ☁️  fsemti@sportinggroup.co.uk
❯ cd ..
direnv: unloading

808fsemti in 🌐 dc1devjump02p in ~ on ☁️  fsemti@sportinggroup.co.uk
❯ which packer

808fsemti in 🌐 dc1devjump02p in ~ on ☁️  fsemti@sportinggroup.co.uk
❯ which direnv
/usr/bin/direnv
```

> note: notice that above, Packer is not known to the system once you are folder above the project folder!

</details>





