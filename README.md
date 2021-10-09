# bsm2

Fast version of bsm

# Building

requires `sudo apt install flex`

```bash
make
```

# Example file

bsm2 is a "literate language". All lines are ignored except the ones starting with a semicolon (;). When we create binary files we are engaging in the worst kind of micromanagement and should be encouraged to document our every move.

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
