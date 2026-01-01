# eBPF/XDP Nix Dev Shell

This flake provides a reproducible development environment for XDP and other eBPF
workloads. It keeps all toolchains, headers, and pkg-config metadata inside
`/nix/store` so you can build standalone projects (such as `xdp-tutorial`)
without depending on the host `/usr/include`.

## Highlights

- Latest LLVM/Clang from Nixpkgs, with explicit BPF headers and library paths.
- Both amd64 (`glibc.dev`) and 32-bit (`pkgsi686Linux.glibc.dev`) glibc headers
  to satisfy Clang’s `<errno.h>` dependency chain.
- Core tooling (`bpftool`, `xdp-tools`, `libbpf`) plus supporting packages such
  as `pahole`, `perf`, `iproute2`, and `tcpdump`.
- `PKG_CONFIG_PATH` and `LIBRARY_PATH` include `libbpf`, `libelf`, `libpcap`,
  and `zlib` for out-of-tree builds.

## Usage

```bash
nix develop
# or: nix shell .
```

## Home Manager

This repo also exposes a Home Manager configuration that reads `USER` and `HOME`
from the environment. Because of that, it must be evaluated in impure mode.

```bash
nix run github:nix-community/home-manager -- switch --flake .#current --impure
```

Inside the shell you get `CC=clang`, `CXX=clang++`, and hardening disabled.
`PKG_CONFIG_PATH` is pre-populated with the Nix-provided `.pc` files, so builds
like `../xdp-tutorial/configure` will resolve `libbpf`, `libelf`, and `zlib`
without manual paths. `C_INCLUDE_PATH` and `CPLUS_INCLUDE_PATH` are set to keep
Clang on the Nix-provided headers.

## Notes

- Run builds in sibling checkouts (example: `../xdp-tutorial`) and keep this
  repository clean; the included `.gitignore` filters out temporary
  `config.*` dirs and `config.mk` artifacts produced by configure scripts.
- If you add extra libraries or cross-compilation targets, extend
  `packages` in `flake.nix` so everything stays reproducible.
