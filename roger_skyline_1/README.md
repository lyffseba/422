# roger_skyline_1 (Mojo tooling track)

In 421 this is a sysadmin project. Here the analogue is **environment & tooling
hygiene for Mojo systems work**:

1. Pin a reproducible toolchain (`pixi.toml` + lockfile).
2. Never commit `.pixi/` virtualenvs.
3. Prefer `pixi run mojo ...` over global compiler drift.
4. Keep secrets out of the tree; use env vars.
5. Document ports/services if you later expose a Mojo HTTP demo.

## Checklist

- [ ] `pixi install` succeeds on a clean machine
- [ ] `make verify` / `make test` green
- [ ] No credentials in git history
- [ ] README states required OS packages (none beyond pixi/mojo for smoke)

## Optional lab

Write a tiny health script:

```bash
pixi run mojo --version
pixi run mojo run libft/main.mojo
```
