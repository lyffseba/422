#!/bin/sh
set -e
cd "$(dirname "$0")/.."
MRUN="./bin/mrun"
fail=0
ok() { printf 'ok  %s\n' "$1"; }
bad() { printf 'FAIL %s: %s\n' "$1" "$2"; fail=1; }

echo "== unit mains (TestSuite) =="
for t in libft get_next_line fillit ft_printf push_swap lem_in corewar fdf fractol; do
  if $MRUN "$t/main.mojo" >/tmp/422u_$t.out 2>/tmp/422u_$t.err; then
    if grep -q "failed!" /tmp/422u_$t.out /tmp/422u_$t.err 2>/dev/null; then
      bad "unit_$t" "suite reported failure"
    else
      ok "unit_$t"
    fi
  else
    bad "unit_$t" "$(tail -5 /tmp/422u_$t.err 2>/dev/null; tail -5 /tmp/422u_$t.out)"
  fi
done

echo "== push_swap | checker =="
ops=$($MRUN push_swap/main.mojo 4 3 2 1 2>/dev/null || true)
[ -n "$ops" ] && ok push_swap_ops || bad push_swap_ops "empty"
res=$(printf '%s\n' "$ops" | $MRUN push_swap/checker.mojo 4 3 2 1 2>/dev/null | tail -1)
[ "$res" = "OK" ] && ok push_swap_checker || bad push_swap_checker "$res"
ops2=$($MRUN push_swap/main.mojo 1 2 3 2>/dev/null || true)
res2=$(printf '%s\n' "$ops2" | $MRUN push_swap/checker.mojo 1 2 3 2>/dev/null | tail -1)
[ "$res2" = "OK" ] && ok push_swap_sorted || bad push_swap_sorted "$res2"
res3=$(printf 'nope\n' | $MRUN push_swap/checker.mojo 1 2 2>/dev/null | tail -1)
[ "$res3" = "Error" ] && ok push_swap_bad_op || bad push_swap_bad_op "$res3"
# n=100 reverse under 700
nops=$($MRUN push_swap/main.mojo $(seq 100 -1 1) 2>/dev/null | wc -l | tr -d ' ')
if [ "$nops" -lt 700 ]; then ok "push_swap_n100_ops($nops)"; else bad push_swap_n100_ops "$nops"; fi
nok=$($MRUN push_swap/main.mojo $(seq 100 -1 1) 2>/dev/null | $MRUN push_swap/checker.mojo $(seq 100 -1 1) 2>/dev/null | tail -1)
[ "$nok" = "OK" ] && ok push_swap_n100_ok || bad push_swap_n100_ok "$nok"

echo "== fillit =="
fill=$($MRUN fillit/main.mojo fillit/resources/valid_files/test2 2>/dev/null || true)
echo "$fill" | grep -q A && echo "$fill" | grep -q B && ok fillit_board || bad fillit_board "$fill"
inv=$($MRUN fillit/main.mojo fillit/resources/invalid_files/test1 2>/dev/null | tail -1 || true)
[ "$inv" = "error" ] && ok fillit_invalid || bad fillit_invalid "$inv"

echo "== gnl =="
printf 'one\ntwo\nthree\n' > /tmp/gnl_422.txt
gnl=$($MRUN get_next_line/main.mojo /tmp/gnl_422.txt 2>/dev/null || true)
echo "$gnl" | grep -q one && echo "$gnl" | grep -q three && ok gnl || bad gnl "$gnl"

echo "== lem_in =="
li=$($MRUN lem_in/main.mojo lem_in/resources/valid_maps/simple 2>/dev/null || true)
echo "$li" | grep -q 'L1-' && echo "$li" | grep -q '##start' && ok lem_in || bad lem_in "$li"
# concurrent: a turn with two ants mentioned
echo "$li" | grep -E 'L[0-9]+-.*L[0-9]+-' >/dev/null && ok lem_in_concurrent || bad lem_in_concurrent "no multi-ant turn"

echo "== corewar =="
cw=$($MRUN corewar/main.mojo corewar/resources/champs/add.s 2>/dev/null || true)
echo "$cw" | grep -q '^42$' && ok corewar_champ || bad corewar_champ "$cw"

echo "== fdf / fractol =="
$MRUN fdf/main.mojo fdf/resources/maps/42.fdf >/tmp/422_fdf.out 2>/dev/null && ok fdf || bad fdf "fail"
$MRUN fractol/main.mojo mandelbrot >/tmp/422_fr.out 2>/dev/null && ok fractol_m || bad fractol_m "fail"
$MRUN fractol/main.mojo julia >/tmp/422_frj.out 2>/dev/null && ok fractol_j || bad fractol_j "fail"

echo "== piscine =="
$MRUN piscine_reloaded/ex00/main.mojo 2>/dev/null | grep -q Hello && ok ex00 || bad ex00 "no hello"
fac=$($MRUN piscine_reloaded/ex14/main.mojo 5 2>/dev/null | tail -1)
[ "$fac" = "120" ] && ok ex14_fact || bad ex14_fact "$fac"
$MRUN piscine_reloaded/ex27/main.mojo pixi.toml 2>/dev/null | grep -q workspace && ok ex27 || bad ex27 "no file"

echo "== python_piscine =="
$MRUN python_piscine/day00/main.mojo >/tmp/422_py0.out 2>/tmp/422_py0.err \
  && grep -q '16' /tmp/422_py0.out && ok py_day00 \
  || bad py_day00 "$(cat /tmp/422_py0.err /tmp/422_py0.out | tail -8)"
$MRUN python_piscine/day01/main.mojo >/tmp/422_py1.out 2>/tmp/422_py1.err \
  && ok py_day01 || bad py_day01 "$(tail -5 /tmp/422_py1.err)"
$MRUN python_piscine/day02/main.mojo 2>/dev/null | grep -q 404 && ok py_day02 || bad py_day02 "no 404"

echo "== workshops =="
$MRUN workshops_machinelearning/linear_regression.mojo 2>/dev/null | grep -q '2.0' && ok ml_ols || bad ml_ols "no slope"
$MRUN workshops_machinelearning/kmeans.mojo 2>/dev/null | grep -q centroids && ok ml_kmeans || bad ml_kmeans "fail"

if [ "$fail" -ne 0 ]; then
  echo "test failed"
  exit 1
fi
echo "test ok"
