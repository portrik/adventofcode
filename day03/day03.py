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

def dumb_approach(first, second):
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
    
    return min_distance, steps

def better_approach(first, second):
    min_distance = math.inf
    steps = math.inf

    for i in range(0, len(first.vertexes) - 1, 1):
        print('Step %s out of %s' % (i, len(first.vertexes) - 2))

        x1 = first.vertexes[i].x_position
        x2 = first.vertexes[i + 1].x_position
        y1 = first.vertexes[i].y_position
        y2 = first.vertexes[i + 1].y_position

        if x1 > x2:
            x1, x2 = x2, x1
        
        if y1 > y2:
            y1, y2 = y2, y1
        
        for j in range(0, len(second.vertexes) - 1, 1):
            x3 = second.vertexes[j].x_position
            x4 = second.vertexes[j + 1].x_position
            y3 = second.vertexes[j].y_position
            y4 = second.vertexes[j + 1].y_position

            if x3 > x4:
                x3, x4 = x4, x4

            if y3 > y4:
                y3, y4 = y4, y3

            if (x1 == x2) and (y3 == y4):
                if ((x1 > x3) and (x1 < x4)) and ((y3 > y1) and (y3 < y4)):
                    if abs(x1) + abs(y3) < min_distance:
                        min_distance = abs(x1) + abs(y3)
                    
                    steps_first = first.vertexes[i].steps + abs(first.vertexes[i].x_position - x1) + abs(first.vertexes[i].y_position - y3)
                    steps_second = second.vertexes[j].steps + abs(second.vertexes[j].x_position - x1) + abs(second.vertexes[j].y_position - y3)

                    if steps_first + steps_second < steps:
                        steps = steps_first + steps_second 

            elif (x3 == x4) and (y1 == y2):
                if ((x3 > x1) and (x3 < x2)) and ((y1 > y3) and (y1 < y4)):
                    if abs(x3) + abs(y1) < min_distance:
                        min_distance = abs(x3) + abs(y1)

                        steps_first = first.vertexes[i].steps + abs(first.vertexes[i].x_position - x3) + abs(first.vertexes[i].y_position - y1)
                        steps_second = second.vertexes[j].steps + abs(second.vertexes[j].x_position - x3) + abs(second.vertexes[j].y_position - y1)

                        if steps_first + steps_second < steps:
                            steps = steps_first + steps_second

    return min_distance, steps

if __name__ == '__main__':
    with open(os.path.dirname(__file__) + '/first_input.txt') as file:
        first = file.readlines()[0].split(',')
    
    with open(os.path.dirname(__file__) + '/second_input.txt') as file:
        second = file.readlines()[0].split(',')

    first = Graph(first)
    second = Graph(second)

    min_distance, steps = better_approach(first, second)

    print('Minimal distance is %s' % min_distance)
    print('Minimal steps needed is %s' % steps)