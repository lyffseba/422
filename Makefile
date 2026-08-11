TREES = piscine_reloaded libft get_next_line fillit ft_printf \
	push_swap lem_in corewar fdf fractol roger_skyline_1 \
	php_piscine python_piscine workshops_machinelearning resources

SMOKE = libft get_next_line fillit ft_printf push_swap lem_in corewar fdf fractol
MRUN = ./bin/mrun

.PHONY: all verify check test clean help

all: verify

help:
	@echo "make verify  - every project tree present"
	@echo "make check   - run each smoke main (fails on error)"
	@echo "make test    - full functional suite"
	@echo "make clean   - remove temp artifacts"
	@echo "./bin/mrun <file.mojo> [args...]  - run with package path"

verify:
	@fail=0; \
	for t in $(TREES); do \
		if [ ! -d "$$t" ] || [ -z "$$(ls -A $$t 2>/dev/null)" ]; then \
			echo "missing $$t"; fail=1; \
		fi; \
	done; \
	if [ ! -x bin/mrun ]; then echo "missing bin/mrun"; fail=1; fi; \
	if [ "$$fail" -ne 0 ]; then exit 1; fi; \
	echo "verify ok"

check: verify
	@fail=0; \
	for t in $(SMOKE); do \
		echo "++ $$t"; \
		if $(MRUN) $$t/main.mojo > /tmp/422_$$t.out 2> /tmp/422_$$t.err; then \
			echo "ok  $$t"; \
		else \
			echo "FAIL $$t"; \
			tail -20 /tmp/422_$$t.err; \
			tail -10 /tmp/422_$$t.out; \
			fail=1; \
		fi; \
	done; \
	if [ "$$fail" -ne 0 ]; then echo "check failed"; exit 1; fi; \
	echo "check ok"

test: verify
	@./scripts/test.sh

clean:
	@rm -f /tmp/422_*.out /tmp/422_*.err /tmp/gnl_422.txt /tmp/ps_ops.txt
