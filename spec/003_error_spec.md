## Errors

If you provide invalid input, bsm2 will try to show where your input has errors:

```bash command
echo '; 41 42 43 sfkjghsd' | bin/bsm2
```

You should get:

```text expected stderr
BSM: Error at line 1 and column 11
---
; 41 42 43 sfkjghsd
           ^~around here
```

bsm2 will also work with multiline input whether its from a file or from standard input:

```bash command
cat <<STRINGS | bin/bsm2
The following is invalid input because 'asd' does not make sense to bsm2

; 45 asd
STRINGS
```

You should get:

```text expected stderr
BSM: Error at line 3 and column 5
---
; 45 asd
     ^~around here
```
