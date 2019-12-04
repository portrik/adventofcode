import os
import math

class Vertex:
    def __init__(self, x_position, y_position):
        self.x_position = x_position
        self.y_position = y_position
    
    def add_next(self, vertex):
        self.next_vertext = vertex

class Graph:
    def __init__(self, moves):
        self.vertexes = []
        x_position = 0
        y_position = 0

        for i in range(len(moves)):
            if moves[i][0] == "U":
                y_position += int(moves[i][1:])
            elif moves[i][0] == "D":
                y_position -= int(moves[i][1:])
            elif moves[i][0] == "R":
                x_position += int(moves[i][1:])
            elif moves[i][0] == "L":
                x_position -= int(moves[i][1:])

            self.vertexes.append(Vertex(x_position, y_position))   

if __name__ == '__main__':
    with open(os.path.dirname(__file__) + '/first_input.txt') as file:
        first = file.readlines()[0].split(',')
    
    with open(os.path.dirname(__file__) + '/second_input.txt') as file:
        second = file.readlines()[0].split(',')

    first = Graph(first)
    second = Graph(second)

    min_distance = math.inf

    for i in range(len(first.vertexes) - 1):
        for j in range(len(second.vertexes) - 1):
            if first.vertexes[i].x_position == first.vertexes[i + 1].x_position and second.vertexes[j].y_position == second.vertexes[j + 1].y_position:
                further = second.vertexes[j].x_position
                closer = second.vertexes[j + 1].x_position
                higher = first.vertexes[i].y_position
                lower = first.vertexes[i + 1].y_position

                x_pos = first.vertexes[i].x_position
                y_pos = second.vertexes[j].y_position

                if further < closer:
                    further, closer = closer, further
                
                if higher < lower:
                    higher, lower = lower, higher

                if (x_pos > closer and x_pos < further) and (y_pos > lower and y_pos < higher):
                    if abs(x_pos) + abs(y_pos) < min_distance:
                        min_distance = abs(x_pos) + abs(y_pos)

            elif first.vertexes[i].y_position == first.vertexes[i + 1].y_position and second.vertexes[j].x_position == second.vertexes[j + 1].x_position:
                further = second.vertexes[j].y_position
                closer = second.vertexes[j + 1].y_position
                higher = first.vertexes[i].x_position
                lower = first.vertexes[i + 1].x_position

                x_pos = first.vertexes[i].y_position
                y_pos = second.vertexes[j].x_position

                if further < closer:
                    further, closer = closer, further
                
                if higher < lower:
                    higher, lower = lower, higher

                if (x_pos > closer and x_pos < further) and (y_pos > lower and y_pos < higher):
                    if abs(x_pos) + abs(y_pos) < min_distance:
                        min_distance = abs(x_pos) + abs(y_pos)


    print(min_distance)