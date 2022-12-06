"""Main controlling module of Advent of Code 2019."""

import os
import sys

from . import day_01
from . import day_02

if __name__ == "__main__":
    n = sys.argv[1]

    input_path = os.path.join(os.path.dirname(__file__), f"day_{n}", "input.txt")
    with open(input_path, encoding="UTF-8") as file:
        day_input = file.read()

    first = "Not implemented!"
    second = "Not implemented!"

    match n:
        case "01":
            first = f"{day_01.solve_first(day_input)}"
            second = f"{day_01.solve_second(day_input)}"
        case "02":
            first = f"{day_02.solve_first(day_input, True)}"
            second = f"{day_02.solve_second(day_input)}"
        case other:
            raise RuntimeError(f"Unknown day {n}!")

    print(f"First Solution:\t\t{first}")
    print(f"Second Solution:\t{second}")
