#!/bin/sh
set -e
cd "$(dirname "$0")/.."
MRUN=./bin/mrun
echo "push_swap op counts (lower is better)"
for n in 3 5 10 50 100; do
  # shell seq
  args=$(seq $n -1 1 | tr '\n' ' ')
  ops=$($MRUN push_swap/main.mojo $args 2>/dev/null | wc -l | tr -d ' ')
  # verify OK
  ok=$( $MRUN push_swap/main.mojo $args 2>/dev/null | $MRUN push_swap/checker.mojo $args 2>/dev/null | tail -1 )
  printf '  n=%-4s ops=%-6s checker=%s\n' "$n" "$ops" "$ok"
done
