# Start here — 422 (Mojo 42 ladder)

This repo is the **Mojo 1.0** twin of [421](https://github.com/lyffseba/421).
Same pedagogical order. Different substrate.

## 0. Install

```bash
curl -fsSL https://pixi.sh/install.sh | sh
cd 422
pixi install
make test
```

Use `./bin/mrun` (not bare `mojo run`) so packages resolve from the repo root.

## 1. Path (in order)

| # | Project | Command |
|---|---------|---------|
| 1 | Piscine drills | `./bin/mrun piscine_reloaded/ex00/main.mojo` |
| 2 | libft | `./bin/mrun libft/main.mojo` |
| 3 | get_next_line | `./bin/mrun get_next_line/main.mojo README.md` |
| 4 | fillit | `./bin/mrun fillit/main.mojo fillit/resources/valid_files/test2` |
| 5 | ft_printf | `./bin/mrun ft_printf/main.mojo` |
| 6 | push_swap | `./bin/mrun push_swap/main.mojo 4 3 2 1 \| ./bin/mrun push_swap/checker.mojo 4 3 2 1` |
| 7 | lem_in | `./bin/mrun lem_in/main.mojo lem_in/resources/valid_maps/simple` |
| 8 | corewar | `./bin/mrun corewar/main.mojo corewar/resources/champs/add.s` |
| 9 | fdf | `./bin/mrun fdf/main.mojo fdf/resources/maps/42.fdf` |
| 10 | fractol | `./bin/mrun fractol/main.mojo mandelbrot` |
| 11 | python interop | `./bin/mrun python_piscine/day00/main.mojo` |
| 12 | ML labs | `./bin/mrun workshops_machinelearning/linear_regression.mojo` |

## 2. How this differs from C 421

- Ownership/`^` transfers replace `malloc`/`free` discipline.
- Packages + `__init__.mojo` replace headers/`.a` archives.
- `FormatArgs` replaces C varargs in ft_printf.
- ASCII/PGM replace MiniLibX (math stays).
- Python interop replaces the PHP piscine slot.

Read [`resources/MOJO_NORM.md`](resources/MOJO_NORM.md) and
[`resources/CURRICULUM_MAP.md`](resources/CURRICULUM_MAP.md).

## 3. Quality bar

```bash
make verify
make check
make test
make bench   # push_swap op counts
```
