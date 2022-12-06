"""Test Day 02."""

import os

from . import solve_first, solve_second


def test_day_02_solve_first():
    """Test the first solution."""
    assert solve_first("1,9,10,3,2,3,11,0,99,30,40,50") == 3500


def test_day_02_solve_second():
    """Test the second solution."""
    input_path = os.path.join(os.path.dirname(__file__), "input.txt")
    with open(input_path, encoding="UTF-8") as file:
        day_input = file.read()

    assert solve_second(day_input) == 9820
