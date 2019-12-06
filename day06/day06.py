import os

class Planet:
    def __init__(self, name):
        self.name = name
        self.parent = None
        self.children = []
    
    def add_child(self, child):
        self.children.append(child)

    def add_parent(self, parent):
        self.parent = parent
    
    def get_orbit(self, current):
        total = current

        for child in self.children:
            if child:
                total += child.get_orbit(current + 1)
                
        return total


class Map:
    def __init__(self, map_data):
        planets = {}

        for data in map_data:
            parent = data.split(')')[0].strip()
            child = data.split(')')[1].strip()

            parent_planet = Planet(parent)
            child_planet = Planet(child)

            if not parent in planets.keys():
                planets[parent] = parent_planet
            
            if not child in planets.keys():
                planets[child] = child_planet

            planets[child].add_parent(planets[parent])
            planets[parent].add_child(planets[child])


        for planet in planets.keys():
            if not planets[planet].parent:
                self.root = planets[planet]

    def calculate_orbits(self):
        return self.root.get_orbit(0)


if __name__ == "__main__":
    with open(os.path.dirname(__file__) + '/test_input.txt') as file:
        test_input = file.readlines()

    test_map = Map(test_input)

    print('Number of test orbits is %s' % test_map.calculate_orbits())

    with open(os.path.dirname(__file__) + '/main_input.txt') as file:
        main_input = file.readlines()

    main_map = Map(main_input)

    print('Number of main orbits is %s' % main_map.calculate_orbits())

    