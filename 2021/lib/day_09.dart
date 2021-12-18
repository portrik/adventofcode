import 'package:aoc2021/solution.dart';

class Day09 implements Solution {
  @override
  Future<String> first(String input) async {
    return lowestPoints(input
            .split('\n')
            .where((element) => element.isNotEmpty)
            .map((e) => e
                .split('')
                .where((element) => element.isNotEmpty)
                .map((e) => int.parse(e))
                .toList())
            .toList())
        .toString();
  }

  int lowestPoints(List<List<int>> input) {
    var result = 0;

    for (var i = 0; i < input.length; ++i) {
      for (var j = 0; j < input[i].length; ++j) {
        var current = input[i][j];

        bool top = (i - 1) >= 0 ? (current < input[i - 1][j]) : true;
        bool bottom =
            (i + 1) < input.length ? (current < input[i + 1][j]) : true;
        bool left = (j - 1) >= 0 ? (current < input[i][j - 1]) : true;
        bool right =
            (j + 1) < input[i].length ? (current < input[i][j + 1]) : true;

        if (top && bottom && left && right) {
          result += (current + 1);
        }
      }
    }

    return result;
  }

  @override
  Future<String> second(String input) async {
    return basins(input
            .split('\n')
            .where((element) => element.isNotEmpty)
            .map((e) => e
                .split('')
                .where((element) => element.isNotEmpty)
                .map((e) => int.parse(e))
                .toList())
            .toList())
        .toString();
  }

  int basins(List<List<int>> input) {
    Map<String, int> basins = {};

    for (var i = 0; i < input.length; ++i) {
      for (var j = 0; j < input[i].length; ++j) {
        var current = input[i][j];

        bool top = (i - 1) >= 0 ? (current < input[i - 1][j]) : true;
        bool bottom =
            (i + 1) < input.length ? (current < input[i + 1][j]) : true;
        bool left = (j - 1) >= 0 ? (current < input[i][j - 1]) : true;
        bool right =
            (j + 1) < input[i].length ? (current < input[i][j + 1]) : true;

        if (top && bottom && left && right) {
          basins['$i,$j'] = getBasinSize(i, j, input);
        }
      }
    }

    var sizes = basins.values.toList();
    sizes.sort();

    return sizes[sizes.length - 3] *
        sizes[sizes.length - 2] *
        sizes[sizes.length - 1];
  }

  int getBasinSize(int startX, int startY, List<List<int>> board) {
    List<List<int>> points = [
      [startX, startY]
    ];
    List<String> used = [];
    int size = -1;

    while (points.isNotEmpty) {
      var coords = points.removeAt(0);
      var current = board[coords[0]][coords[1]];

      if (current > 8) {
        continue;
      }

      ++size;

      if (coords[0] > 0 && !used.contains('${coords[0] - 1},${coords[1]}')) {
        points.add([coords[0] - 1, coords[1]]);
        used.add('${coords[0] - 1},${coords[1]}');
      }

      if (coords[0] < board.length - 1 &&
          !used.contains('${coords[0] + 1},${coords[1]}')) {
        points.add([coords[0] + 1, coords[1]]);
        used.add('${coords[0] + 1},${coords[1]}');
      }

      if (coords[1] > 0 && !used.contains('${coords[0]},${coords[1] - 1}')) {
        points.add([coords[0], coords[1] - 1]);
        used.add('${coords[0]},${coords[1] - 1}');
      }

      if (coords[1] < board[coords[0]].length - 1 &&
          !used.contains('${coords[0]},${coords[1] + 1}')) {
        points.add([coords[0], coords[1] + 1]);
        used.add('${coords[0]},${coords[1] + 1}');
      }
    }

    return size;
  }
}
