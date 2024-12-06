~~~
$ wc -l < spinner
116
~~~

The spinner is a rotating bar (`-\|/`) printed to stderr, unless
stderr is not connected to a TTY, in which case it outputs nada.

## Async spinner tied to a particular tty

Each TTY can have exactly 1 running spinner--if you try to start
multiple of them simultaneously, only 1 will succeed, and the others
will exit immediately.

The spinner runs in the background, but the commands to start and stop
it are *synchronous*. Internally, named pipes are used for
synchronisation.

~~~
$ spinner start
$ # *spins*
$ r=$!
$ echo $r
0
$ ps -o pid,ppid,comm -p `pgrep spinner`
    PID    PPID COMMAND
  87385       1 spinner
~~~

0 means the spinner is running. You pass this value to the `stop`
command:

    $ spinner stop $r

The `stop` command only works if executed from the same TTY as the
`start` was. The exit code from `start` is required, otherwise it
would be too easy to stop a spinner you haven't started.

There is also `clean` command. See examples in `test/`.

## Wrapper for an external command

~~~
$ head -c $((1024*1024*100)) < /dev/urandom > junk
$ spinner wrap xz junk
*spins*
$ file junk.xz
junk.xz: XZ compressed data, checksum CRC64
~~~

Here, `xz` runs in the background, making the `wrap` command useless
for programs that read from stdin.

## BUGS

In the most desperate cases, when many spinners are being started and
stopped, an impudent SIGINT from a user might still leave a single
spinner running. I failed to reproduce this IRL on Fedora, but it
occasionally happened in FreeBSD VMs under unrealistic test loads.

## &#x2672; Loicense

MIT
