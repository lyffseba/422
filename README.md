# 422

Mojo-native twin of [421](https://github.com/lyffseba/421) — the same École 42
curriculum ladder (structure, purpose, progression), implemented in
**[Mojo 1.0](https://mojolang.org/docs/manual/)** instead of C.

Learn systems fundamentals twice: once in C (`421`), once in Mojo (`422`).

## Contents

Curriculum order (top → bottom):

```
piscine_reloaded/
libft/
get_next_line/
fillit/
ft_printf/
push_swap/
lem_in/
corewar/
fdf/
fractol/
roger_skyline_1/
python_piscine/
workshops_machinelearning/
resources/
```

| Path | Project | Notes |
|------|---------|-------|
| `piscine_reloaded/` | Piscine Reloaded | Mojo basics (ex00–ex27) |
| `libft/` | Libft | string/list utility package |
| `get_next_line/` | Get Next Line | buffered line reader |
| `fillit/` | Fillit | tetrimino backtracking |
| `ft_printf/` | ft_printf | format-string printer |
| `push_swap/` | Push swap | two-stack sort |
| `lem_in/` | Lem-in | graph BFS + ants |
| `corewar/` | Corewar | tiny VM + assembler |
| `fdf/` | FdF | ASCII wireframe maps |
| `fractol/` | Fract'ol | Mandelbrot / Julia |
| `roger_skyline_1/` | Roger-Skyline-1 | toolchain / ops hygiene |
| `python_piscine/` | Python interop | maps 421 php_piscine |
| `workshops_machinelearning/` | 42AI-style labs | regression, k-means |
| `resources/MOJO_NORM.md` | Style guide | Mojo Norm |
| `resources/CURRICULUM_MAP.md` | 421↔422 map | skill alignment |

## Requirements

- [pixi](https://pixi.sh/)
- Mojo **1.0.0b2+** (installed via `pixi.toml`)

```bash
curl -fsSL https://pixi.sh/install.sh | sh
cd 422
pixi install
pixi run mojo --version
```

## Build & test

```bash
make verify   # trees present
make check    # run each smoke main (fails on error)
make test     # functional suite
```

Or directly:

```bash
pixi run mojo run -I . libft/main.mojo
pixi run mojo run -I . push_swap/main.mojo 4 3 2 1
pixi run mojo run -I . fractol/main.mojo mandelbrot
```

## Design notes

- Packages use `__init__.mojo` and are imported as `from libft.string import …`.
- Mojo 1.0 has no C varargs — `ft_printf` uses an explicit `FormatArgs` bag
  while still teaching format parsing.
- Graphics projects render ASCII/PGM (no MiniLibX); algorithms stay faithful.
- `python_piscine` replaces PHP with Mojo↔Python interop.

## Provenance

Scaffolding and Mojo ports are original to this repository (MIT).
Pedagogical structure follows the public 42 project ladder mirrored in
[lyffseba/421](https://github.com/lyffseba/421).

## Links

- https://github.com/lyffseba/422
- https://github.com/lyffseba/421
- https://mojolang.org/docs/manual/
- https://42.fr/
