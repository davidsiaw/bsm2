# bsm2

Fast version of bsm

# Building

requires `sudo apt install flex`

```bash
make
```

# Example file

```
this file is called input.bsm

writes ABC

; 00 41 42 43

writes D

; 44

```

# Running

```bash
bin/bsm2 < input.bsm
```
