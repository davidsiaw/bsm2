# bsm2

Fast version of bsm. bsm2 converts input that describes a binary file in a human-readable format and outputs a binary file.

# Building

requires `sudo apt install flex libfl-dev`

```bash
make
```

# Example file

bsm2 is a "literate language". All lines are ignored except the ones starting with a semicolon (;). When we create binary files we are engaging in the worst kind of micromanagement and should be encouraged to document our every move.

```
this file is called input.bsm

writes ABC

; 41 42 43

writes D

; 44

```

You can find more examples in the `spec` directory, as well as more detailed documentation on how to use different features and explanations about edge cases.

# Running

```bash
bin/bsm2 < input.bsm
```

# Testing

The spec for this program is written in Markdown. See the `spec` directory.

In order to run the tests, you need `markspec`, which you can install with `gem install markspec`

Run the tests by going `markspec`

You can run an individual test too by going `markspec spec/abc_test.md`
