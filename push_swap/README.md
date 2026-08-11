# push_swap (Mojo)

Sort a stack of integers using only the classic 42 instruction set
(`sa sb ss pa pb ra rb rr rra rrb rrr`).

## Build / run

```bash
./bin/mrun push_swap/main.mojo 4 3 2 1
./bin/mrun push_swap/main.mojo 4 3 2 1 | ./bin/mrun push_swap/checker.mojo 4 3 2 1
# → OK
```

## Layout

| File | Role |
|------|------|
| `stack.mojo` | piles + ops + sort |
| `main.mojo` | push_swap binary |
| `checker.mojo` | validates instruction stream on stdin |
