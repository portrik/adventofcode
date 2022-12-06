"""Test Day 02."""

from . import solve_first


def test_day_02_solve_first():
    """Test the first solution."""
    assert solve_first("1,9,10,3,2,3,11,0,99,30,40,50") == 3500
