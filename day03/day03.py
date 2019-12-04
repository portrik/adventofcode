import os
import math

class Vertex:
    def __init__(self, x_position, y_position, steps):
        self.x_position = x_position
        self.y_position = y_position
        self.steps = steps
    
    def add_next(self, vertex):
        self.next_vertext = vertex

class Graph:
    def __init__(self, moves):
        self.vertexes = []
        x_position = 0
        y_position = 0
        steps = 0

        self.vertexes.append(Vertex(x_position, y_position, steps))

        for i in range(len(moves)):
            if moves[i][0] == "U":
                y_position += int(moves[i][1:])
            elif moves[i][0] == "D":
                y_position -= int(moves[i][1:])
            elif moves[i][0] == "R":
                x_position += int(moves[i][1:])
            elif moves[i][0] == "L":
                x_position -= int(moves[i][1:])
            
            steps += int(moves[i][1:])

            self.vertexes.append(Vertex(x_position, y_position, steps))

def get_line(x1, x2, y1, y2):
    line = []

    if x2 < x1:
        x1, x2 = x2, x1

    if y2 < y1:
        y1, y2 = y2, y1

    if x1 == x2:
        for k in range(y1, y2, 1):
            line.append((x1, k))
    else:
        for k in range(x1, x2, 1):
            line.append((k, y1))

    return line

if __name__ == '__main__':
    with open(os.path.dirname(__file__) + '/first_input.txt') as file:
        first = file.readlines()[0].split(',')
    
    with open(os.path.dirname(__file__) + '/second_input.txt') as file:
        second = file.readlines()[0].split(',')

    first = Graph(first)
    second = Graph(second)

    min_distance = math.inf
    steps = math.inf

    for i in range(0, len(first.vertexes) - 1, 1):
        print('Step %s out of %s' % (i, len(first.vertexes) - 2))
        compare_line = get_line(first.vertexes[i].x_position, first.vertexes[i + 1].x_position, first.vertexes[i].y_position, first.vertexes[i + 1].y_position)

        for j in range(0, len(second.vertexes) - 1, 1):
            new_line = get_line(second.vertexes[j].x_position, second.vertexes[j + 1].x_position, second.vertexes[j].y_position, second.vertexes[j + 1].y_position)
            for line in compare_line:
                if line != (0, 0):
                    if line in new_line:
                        if abs(line[0]) + abs(line[1]) < min_distance:
                            min_distance = abs(line[0]) + abs(line[1])
                        
                        steps_first = first.vertexes[i].steps + abs(first.vertexes[i].x_position - line[0]) + abs(first.vertexes[i].y_position - line[1])
                        steps_second = second.vertexes[j].steps + abs(second.vertexes[j].x_position - line[0]) + abs(second.vertexes[j].y_position - line[1])

                        if steps_first + steps_second < steps:
                            steps = steps_first + steps_second

    print('Minimal distance is %s' % min_distance)
    print('Minimal steps needed is %s' % steps)