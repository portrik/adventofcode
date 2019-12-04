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
            if first.vertexes[i].x_position == first.vertexes[i + 1].x_position:
                higher = first.vertexes[i].y_position
                lower = first.vertexes[i + 1].y_position

                if higher < lower:
                    higher, lower = lower, higher 

                if second.vertexes[j].y_position >= lower and second.vertexes[j].y_position <= higher:
                    if abs(first.vertexes[i].x_position) + abs(second.vertexes[j].y_position) < min_distance:
                        min_distance = abs(first.vertexes[i].x_position) + abs(second.vertexes[j].y_position)
            else:
                higher = first.vertexes[i].x_position
                lower = first.vertexes[i + 1].x_position

                if higher < lower:
                    higher, lower = lower, higher 
                
                if second.vertexes[j].x_position >= lower and second.vertexes[j].x_position <= higher:
                    if abs(first.vertexes[i].y_position) + abs(second.vertexes[j].x_position) < min_distance:
                        min_distance = abs(first.vertexes[i].y_position) + abs(second.vertexes[j].x_position)


    print(min_distance)