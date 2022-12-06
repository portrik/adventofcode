"""Solutions for Day 02."""

from typing import List


def execute_opcodes(codes: List[int]) -> List[int]:
    """
    Execute the provided opcodes.

    Args:
        codes (List[int]): List of opcodes

    Returns:
        List[int]: Final memory state
    """
    instructions = codes.copy()

    index = 0
    while instructions[index] != 99:
        new_value = -1

        if instructions[index] == 1:
            new_value = (
                instructions[instructions[index + 1]]
                + instructions[instructions[index + 2]]
            )
        elif instructions[index] == 2:
            new_value = (
                instructions[instructions[index + 1]]
                * instructions[instructions[index + 2]]
            )

        instructions[instructions[index + 3]] = new_value
        index += 4

    return instructions


def solve_first(items: str, replacement=False) -> int:
    """
    Solve the first problem.

    Args:
        items (str): The input
        replacement (bool): Should the instructions be replaced?
        Defaults to False. Only used for the main input.

    Returns:
        int: The result
    """
    instructions = [int(item) for item in items.split(",") if item]

    if replacement:
        instructions[1] = 12
        instructions[2] = 2

    instructions = execute_opcodes(instructions)

    return instructions[0]


def solve_second(items: str) -> int:
    """
    Solve the second problem.

    Args:
        items (str): The input

    Returns:
        int: The result
    """
    default_instructions = [int(item) for item in items.split(",") if item]

    for i in range(99):
        for j in range(99):
            current = default_instructions.copy()
            current[1] = i
            current[2] = j
            current = execute_opcodes(current)

            if current[0] == 19690720:
                return 100 * i + j

    return -1
