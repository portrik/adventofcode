def calculate_mass(inp_mass):
    new_mass =inp_mass // 3 - 2

    if new_mass > 0:
        new_mass += calculate_mass(new_mass)
        return new_mass
    else:
        return 0

if __name__ == "__main__":
    total = 0

    with open('./day01.txt') as file:
        lines = file.readlines()

    for line in lines:
        total += calculate_mass(int(line))
    
    print(total)
