FROM nixos/nix
VOLUME ["/nix"]
RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN nix-channel --update
COPY build/shellme.sh /root/shellme.sh
