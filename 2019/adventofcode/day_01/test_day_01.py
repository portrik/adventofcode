"""Test Day 01."""

from . import solve_first, solve_second


def test_day_01_solve_first():
    """Test the first solution."""
    assert solve_first("12\n14\n1969\n100756") == 34241


def test_day_01_solve_second():
    """Test the second solution."""
    assert solve_second("12\n14\n1969\n100756") == 51316
