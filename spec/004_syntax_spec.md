## Syntax

bsm2 supports a wide variety of syntax. There are many different ways to represent bytes in a binary file depending on their meaning to humans and thus bsm2 gives you the option to write out bytes in many different ways that can be clearly read by a human being.

### Hex Codes

The simplest and most basic way to represent bytes is by hexadecimal codes. These are pairs of characters that describe a byte. Hence as shown in the [basic usage spec](001_basic_usage_spec.md), you can write the characters 'abc' like this:

If you run this command

```bash command
echo ';61 62 63' | bin/bsm2
```

You should get:

```text expected stdout
abc
```

### C Char Format

Clearly hex codes are very good for control characters and bytes that are not printable, but printable characters are better off being represented as printable characters. Therefore, you can also output 'abc' in a way you would write it in the C language like this:

If you run this command

```bash command
cat <<BSM | bin/bsm2
; 'a' 'b' 'c'
BSM
```

You should get:

```text expected stdout
abc
```

Unlike C however, you cannot use escapes to show different characters like: `'\n'` or `'\0'`. This is mostly because you can write the character codes of these in bsm2 already.

If you run this command

```bash command
cat <<BSM | bin/bsm2
; 61 62 0D
BSM
```

You should get:

```text expected stdout
ab

```

(notice the newline)

If you attempt to use backslashes in bsm2, it will output a backslash character:

If you run this command

```bash command
cat <<BSM | bin/bsm2
; '\'
BSM
```

You should get:

```text expected stdout
\
```

And if you attempt to use the C convention, you will get an error (because bsm2 only expects one character between a pair of single quotes).

If you run this command

```bash command
cat <<BSM | bin/bsm2
; '\n'
BSM
```

You should get:

```text expected stderr
BSM: Error at line 1 and column 2
---
; '\n'
  ^~around here
```

### C String Format

Writing long lines of characters with constantly opening and closing quotes is very troublesome. Thus, bsm2 allows you to write most printable characters between a pair of double quotes:

If you run this command

```bash command
cat <<BSM | bin/bsm2
; "Hello!"
BSM
```

You should get:

```text expected stdout
Hello!
```

Similar to quotes, bsm2 does not support backlash escapes, so any backslash escapes will just come out verbatim:

If you run this command

```bash command
cat <<BSM | bin/bsm2
; "hi everyone my name is \n"
BSM
```

You should get:

```text expected stdout
hi everyone my name is \n
```

### Bitfield

You can write bytes by representing their individual bits too by doing this:

```bash command
cat <<BSM | bin/bsm2
; <01100001> <.11...1.>
BSM
```

You should get:

```text expected stdout
ab
```

`0` and `.` are both 0 and `1` is 1. Use these characters in a way that makes it easy to read.

### Tricks

Let's say you want to output actual quotes and double quotes, you can simply use the opposite syntax to represent them:

To output quotes, you can run this command:

```bash command
cat <<BSM | bin/bsm2
; "'" 41 42 44 "'"
BSM
```

You should get:

```text expected stdout
'ABD'
```

To output double quotes, you can do this:

```bash command
cat <<BSM | bin/bsm2
; "Good morning, my name is " '"' "David" '"'
BSM
```

You should get:

```text expected stdout
Good morning, my name is "David"
```
