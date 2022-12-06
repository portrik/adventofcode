"""Solutions for 2019/01."""


def solve_first(items: str) -> int:
    """
    Solve the first part.

    Args:
        items (str): Input

    Returns:
        int: Result
    """
    return sum(int(item) // 3 - 2 for item in items.split("\n") if item)


def calculate_mass(item: int) -> int:
    """
    Recursively calculate the mass for the item and its fuel.

    Args:
        item (int): Item to calculate for

    Returns:
        int: New mass
    """
    new_mass = item // 3 - 2

    if new_mass < 1:
        return 0

    return new_mass + calculate_mass(new_mass)


def solve_second(items: str) -> int:
    """
    Solve the second part.

    Args:
        items (List[int]): Input

    Returns:
        int: Result
    """
    return sum(calculate_mass(int(item)) for item in items.split("\n") if item)
