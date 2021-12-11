import 'package:aoc2021/solution.dart';

class Day11 implements Solution {
  @override
  Future<String> first(String input) async {
    var octopuses = input
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split('').map(int.parse).toList())
        .toList();

    return flash(octopuses, 100).toString();
  }

  int flash(List<List<int>> input, int steps) {
    var octopuses = [...input];
    var flashes = 0;

    for (var i = 0; i < steps; ++i) {
      // Increase level of everyone by one
      for (var row = 0; row < octopuses.length; ++row) {
        for (var column = 0; column < octopuses[row].length; ++column) {
          ++octopuses[row][column];
        }
      }

      var charged = octopuses
          .expand((element) => element)
          .where((element) => element > 9)
          .length;

      while (charged > 0) {
        for (var row = 0; row < octopuses.length; ++row) {
          for (var column = 0; column < octopuses[row].length; ++column) {
            // Skip non-charged
            if (octopuses[row][column] < 10) {
              continue;
            }

            ++flashes;
            octopuses[row][column] = 0;

            if (row > 0) {
              if (octopuses[row - 1][column] > 0) {
                ++octopuses[row - 1][column];
              }

              if (column > 0 && octopuses[row - 1][column - 1] > 0) {
                ++octopuses[row - 1][column - 1];
              }

              if (column < octopuses[row].length - 1 &&
                  octopuses[row - 1][column + 1] > 0) {
                ++octopuses[row - 1][column + 1];
              }
            }

            if (row < octopuses.length - 1) {
              if (octopuses[row + 1][column] > 0) {
                ++octopuses[row + 1][column];
              }

              if (column > 0 && octopuses[row + 1][column - 1] > 0) {
                ++octopuses[row + 1][column - 1];
              }

              if (column < octopuses[row].length - 1 &&
                  octopuses[row + 1][column + 1] > 0) {
                ++octopuses[row + 1][column + 1];
              }
            }

            if (column > 0 && octopuses[row][column - 1] > 0) {
              ++octopuses[row][column - 1];
            }

            if (column < octopuses[row].length - 1 &&
                octopuses[row][column + 1] > 0) {
              ++octopuses[row][column + 1];
            }
          }
        }

        charged = octopuses
            .expand((element) => element)
            .where((element) => element > 9)
            .length;
      }
    }

    return flashes;
  }

  @override
  Future<String> second(String input) async {
    var octopuses = input
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split('').map(int.parse).toList())
        .toList();

    return simultaneousFlash(octopuses).toString();
  }

  int simultaneousFlash(List<List<int>> input) {
    var octopuses = [...input];
    var i = 0;

    while (true) {
      ++i;

      // Increase level of everyone by one
      for (var row = 0; row < octopuses.length; ++row) {
        for (var column = 0; column < octopuses[row].length; ++column) {
          ++octopuses[row][column];
        }
      }

      var charged = octopuses
          .expand((element) => element)
          .where((element) => element > 9)
          .length;

      while (charged > 0) {
        if (charged == (octopuses.length * octopuses[0].length)) {
          return i - 10;
        }

        for (var row = 0; row < octopuses.length; ++row) {
          for (var column = 0; column < octopuses[row].length; ++column) {
            // Skip non-charged
            if (octopuses[row][column] < 10) {
              continue;
            }

            octopuses[row][column] = 0;

            if (row > 0) {
              if (octopuses[row - 1][column] > 0) {
                ++octopuses[row - 1][column];
              }

              if (column > 0 && octopuses[row - 1][column - 1] > 0) {
                ++octopuses[row - 1][column - 1];
              }

              if (column < octopuses[row].length - 1 &&
                  octopuses[row - 1][column + 1] > 0) {
                ++octopuses[row - 1][column + 1];
              }
            }

            if (row < octopuses.length - 1) {
              if (octopuses[row + 1][column] > 0) {
                ++octopuses[row + 1][column];
              }

              if (column > 0 && octopuses[row + 1][column - 1] > 0) {
                ++octopuses[row + 1][column - 1];
              }

              if (column < octopuses[row].length - 1 &&
                  octopuses[row + 1][column + 1] > 0) {
                ++octopuses[row + 1][column + 1];
              }
            }

            if (column > 0 && octopuses[row][column - 1] > 0) {
              ++octopuses[row][column - 1];
            }

            if (column < octopuses[row].length - 1 &&
                octopuses[row][column + 1] > 0) {
              ++octopuses[row][column + 1];
            }
          }
        }

        charged = octopuses
            .expand((element) => element)
            .where((element) => element > 9)
            .length;
      }
    }
  }
}
