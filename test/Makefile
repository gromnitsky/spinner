sh := sh

1:
	$(sh) smoke1.sh

2:
	$(sh) smoke2.sh | $(sh) smoke2.sh

3:
	$(sh) smoke3.sh | $(sh) smoke3.sh | $(sh) smoke3.sh | $(sh) smoke3.sh | $(sh) smoke3.sh

4:
	$(sh) smoke3.sh | $(sh) smoke3.sh | $(sh) smoke3.sh | $(sh) smoke3.sh | $(sh) smoke3.sh sigterm

tmp := /tmp/$(USER)/sigwait.org/spinner

leftovers:
	pgrep -a spinner
	tree $(tmp)
	cat $(tmp)/*/*/lock

clean:
	pkill spinner
	rm -fr $(tmp)

.IGNORE: leftovers clean
