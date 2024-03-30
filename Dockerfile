from ghcr.io/nixos/nix

workdir /workspace

run git clone https://github.com/moergo-sc/zmk src

add config config

run nix-build config -o combined

cmd ["/bin/sh", "-c", "nix-build config -o combined && cp combined/glove80.uf2 out/glove80.uf2"]
