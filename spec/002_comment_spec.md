The input bsm2 takes is a [Literate Language](https://en.wikipedia.org/wiki/Literate_programming). This means that by default all the code in a bsm2 file is comment, and the code that is translated into binary are only on lines preceded by a ';'

All input that does not start the line with a `;` is ignored.

```bash command
echo 'Hello' | bin/bsm2
```

You should get:

```text expected stdout
```

Thus you can comment what you are doing conveniently without having to constantly remind the compiler that you are writing comments.

```bash command
cat <<STRINGS | bin/bsm2
This line writes out the letters A and B

; 41 42
STRINGS
```

You should get:

```text expected stdout
AB
```
