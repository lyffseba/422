# The Mojo Norm (422)

Educational style guide inspired by 42's Norm, adapted for Mojo 1.0.

1. **Four-space indent**, no tabs.
2. Prefer `def` (Mojo 1.0: `fn` removed).
3. Explicit types on struct fields and public APIs.
4. One package concern per directory; `__init__.mojo` marks packages.
5. Errors are values — use `raises` and `Error`, don't crash silently.
6. No unused imports.
7. Name modules after their responsibility (`string.mojo`, `graph.mojo`).
8. Keep functions focused; extract helpers instead of deep nesting.
9. Prefer safe collections (`List`, `String`) before `UnsafePointer`.
10. Every project ships a `README.md` with run instructions.

Reference: https://mojolang.org/docs/manual/
