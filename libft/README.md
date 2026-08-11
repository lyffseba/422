# libft (Mojo)

Native Mojo port of the École 42 **libft** project.

## Purpose

Rebuild foundational utilities yourself instead of leaning only on the stdlib:
character classes, string conversion, splitting, and linked lists.

## Layout

```
libft/
  __init__.mojo   package exports
  ctype.mojo      isalpha / isdigit / toupper ...
  string.mojo     atoi / itoa / strcmp / split ...
  list.mojo       arena-backed linked list
  put.mojo        putchar / putstr / putnbr
  main.mojo       demo + self-check entrypoint
```

## Run

```bash
pixi run mojo run libft/main.mojo
```

## Maps from 421

| C (421) | Mojo (422) |
|---------|------------|
| `ft_*.c` sources | `libft/*.mojo` modules |
| `libft.a` | importable package `libft` |
| libc ctype/string | reimplemented learning APIs |
