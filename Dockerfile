from ghcr.io/nixos/nix

workdir /workspace

run git clone https://github.com/moergo-sc/zmk src

add config config

run nix-env --quiet -j8 -iA cachix -f https://cachix.org/api/v1/install

run cachix use moergo-glove80-zmk-dev

run nix-build config -o combined

cmd ["/bin/sh", "-c", "nix-build config -o combined && cp combined/glove80.uf2 out/glove80.uf2"]
