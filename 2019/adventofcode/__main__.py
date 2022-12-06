"""Main controlling module of Advent of Code 2019."""

import os
import sys

from . import day_01

if __name__ == "__main__":
    n = sys.argv[1]

    input_path = os.path.join(os.path.dirname(__file__), f"day_{n}", "input.txt")
    with open(input_path, encoding="UTF-8") as file:
        day_input = file.read()

    match n:
        case "01":
            print(day_01.solve_first(day_input))
            print(day_01.solve_second(day_input))
        case other:
            raise RuntimeError(f"Unknown day {n}!")
