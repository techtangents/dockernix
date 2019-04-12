# dockernix

Docker container and basic tooling for running nix on docker for macos. 

This is useful if you run a macos workstation, but need a Linux Nix environment to build and test your code.

# Setup

## Prerequisites

 - A Mac
 - Docker for Mac

It assumes you put all of your code checkouts under `~/src`.

## Installing

 1. Clone this repo.
 2. `cd` into the repo folder and run these commands:

```
docker volume create nix
./build-dockernix
ln -s "`pwd`/nix-shell-docker ~/bin
ln -s "`pwd`/start-dockernix" ~/bin
ln -s "`pwd`/stop-dockernix" ~/bin
```

I don't currently run nix on macos, so I rename the first link to `nix-shell`.

# Usage

Firstly, run `start-dockernix` to start up.

Then, use `nix-shell-docker` just like you would `nix-shell`. `cd` into your project folder and run `nix-shell-docker`. 

# How it works

The docker image is based on a simple minimal nixos build. 
`/nix` is in a volume, so you don't lose your cache between restarts.
`start-dockernix` starts the container and keeps it alive with a dummy process. 
This container has the nix volume mounted, and also mounts your `~/src` folder as `~/src` in the container.

`nix-shell-docker` runs `docker exec` against this container. 
It calls into a simple script on the container, which `cds` into your current folder mounted on the container,
and passes the rest of its arguments through to `nix-shell`.

The effect is fairly seamless. Pretend you're nix-ing on Linux.

# Why one container?

We could run each nix-shell in its own container, but I was concerned about a few things:

 - do we need to?
 - startup time
 - nix store size
 - concurrent access to nix store from multiple containers

Maybe these aren't a big deal - fork the repo and try it.

# Customizing

Tweak `start-dockernix` to change the mount points you expose.

Tweak the `Dockerfile` and run `build-dockernix`, e.g. if you want to use a different Nix channel.

As mentioned above, you could rename/alias so the command is `nix-shell` instead of `nix-shell-docker`.

# Potential enhancements

Support a few other commands, like `nix-build`.

Bundle this up into a homebrew package.

# Links

[nixos/nix docker image](https://hub.docker.com/r/nixos/nix)

[Provisioning a NixOS server from macOS](https://medium.com/@zw3rk/provisioning-a-nixos-server-from-macos-d36055afc4ad)

[Nix in Docker - Best of Both Worlds](http://datakurre.pandala.org/2015/11/nix-in-docker-best-of-both-worlds.html)

[Docker Docs](https://docs.docker.com/)

[Nix Manual](https://nixos.org/nix/manual/)

