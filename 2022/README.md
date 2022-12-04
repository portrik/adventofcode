# 2022 - V

[![2022 Tests](https://github.com/tehSIRius/adventofcode/actions/workflows/2022.yaml/badge.svg)](https://github.com/tehSIRius/adventofcode/actions/workflows/2022.yaml)

This year I wanted to go with `zig`. But the language proved to have a too steep learning curve for me. So `V` came to the rescue. Thank you, V! Very cool!

## Technical Information

* V language version `V 0.2.4 b72a2de`
* VS Code
* MacOS

### How to Run

From the `2022` directory execute the following command. `DAY_NUMBER` represents day number with a leading zero.

```bash
v run ./ -d <DAY_NUMBER>
```

The project also includes automated tests. These can be run separately for each day by running the following command.

```bash
v test ./day_<DAY_NUMBER>/day_<DAY_NUMBER>_test.v
```

Or the test suite can be run as whole through following command.

```bash
v test .
```
