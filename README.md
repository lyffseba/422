# 422

Mojo-native twin of [421](https://github.com/lyffseba/421) — the same École 42
curriculum ladder (order, purpose, project roles), implemented in
**[Mojo 1.0](https://mojolang.org/docs/manual/)** instead of C.

| | |
|-|-|
| C vault | [`lyffseba/421`](https://github.com/lyffseba/421) |
| Mojo vault | **this repo** |
| Language | Mojo **1.0.0b2+** via [pixi](https://pixi.sh/) |

## Contents

```
piscine_reloaded/          # ex00–ex27 drills
libft/                     # utility package
get_next_line/             # buffered line reader
fillit/                    # tetrimino backtracking
ft_printf/                 # format-string printer
push_swap/                 # two-stack sort + checker
lem_in/                    # graph BFS + ants
corewar/                   # tiny VM + assembler
fdf/                       # ASCII wireframe maps
fractol/                   # Mandelbrot / Julia
roger_skyline_1/           # toolchain / ops hygiene
php_piscine/               # pointer → python_piscine (421 parity)
python_piscine/            # Mojo ↔ Python interop track
workshops_machinelearning/ # OLS + k-means labs
resources/                 # Mojo Norm + 421↔422 map
bin/mrun                   # mojo run -I <repo root>
```

See [`resources/CURRICULUM_MAP.md`](resources/CURRICULUM_MAP.md) for the
skill-for-skill mapping from 421.

New here? Read **[START_HERE.md](START_HERE.md)** first.

## Setup

```bash
curl -fsSL https://pixi.sh/install.sh | sh   # once
cd 422
pixi install
pixi run mojo --version
```

## Verify / test

```bash
make verify   # trees present
make check    # every smoke main exits 0
make test     # functional suite (printf, push_swap|checker, fillit, …)
make bench    # push_swap op counts for n=3..100
```

## Run examples

Always use the wrapper so packages resolve from the repo root:

```bash
./bin/mrun libft/main.mojo
./bin/mrun push_swap/main.mojo 5 4 3 2 1
./bin/mrun push_swap/main.mojo 5 4 3 2 1 | ./bin/mrun push_swap/checker.mojo 5 4 3 2 1
./bin/mrun fillit/main.mojo fillit/resources/valid_files/test2
./bin/mrun lem_in/main.mojo lem_in/resources/valid_maps/simple
./bin/mrun corewar/main.mojo corewar/resources/champs/add.s
./bin/mrun fractol/main.mojo mandelbrot
./bin/mrun python_piscine/day00/main.mojo
```

Equivalent: `pixi run mojo run -I . <file> [args…]`.

## Design choices (intentional)

| 421 | 422 |
|-----|-----|
| `libft.a` + headers | Mojo package `libft/` with `__init__.mojo` |
| C varargs `ft_printf` | `FormatArgs` bag + format parser (same skill) |
| MiniLibX FdF/Fractol | ASCII / PGM renderers (same math) |
| Full Corewar `.cor` | Educational VM + text assembler |
| PHP piscine | `python_piscine` (+ `php_piscine/` stub for tree parity) |
| Norm (C) | [`resources/MOJO_NORM.md`](resources/MOJO_NORM.md) |

## Links

- https://github.com/lyffseba/422
- https://github.com/lyffseba/421
- https://mojolang.org/docs/manual/
- https://42.fr/
