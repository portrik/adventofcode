import 'package:aoc2021/solution.dart';

class Day15 implements Solution {
  @override
  Future<String> first(String input) async {
    var nodes = input
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e
            .split('')
            .where((element) => element.isNotEmpty)
            .map((e) => int.parse(e))
            .toList())
        .toList();

    return safest(nodes).toString();
  }

  int safest(List<List<int>> nodes) {
    List<List<int>> prices = List.generate(
        nodes.length,
        (index) => List<int>.generate(
            nodes[index].length, (index) => 9223372036854775807));
    prices[0][0] = 0;

    List<List<int>> queue = [];
    queue.add([0, 0]);

    while (queue.isNotEmpty) {
      var coords = queue.removeAt(0);
      var current = prices[coords[0]][coords[1]];

      if (coords[0] > 0 &&
          current + nodes[coords[0] - 1][coords[1]] <
              prices[coords[0] - 1][coords[1]]) {
        prices[coords[0] - 1][coords[1]] =
            current + nodes[coords[0] - 1][coords[1]];

        queue.add([coords[0] - 1, coords[1]]);
      }

      if (coords[0] < nodes.length - 1 &&
          current + nodes[coords[0] + 1][coords[1]] <
              prices[coords[0] + 1][coords[1]]) {
        prices[coords[0] + 1][coords[1]] =
            current + nodes[coords[0] + 1][coords[1]];

        queue.add([coords[0] + 1, coords[1]]);
      }

      if (coords[1] > 0 &&
          current + nodes[coords[0]][coords[1] - 1] <
              prices[coords[0]][coords[1] - 1]) {
        prices[coords[0]][coords[1] - 1] =
            current + nodes[coords[0]][coords[1] - 1];

        queue.add([coords[0], coords[1] - 1]);
      }

      if (coords[1] < nodes[coords[0]].length - 1 &&
          current + nodes[coords[0]][coords[1] + 1] <
              prices[coords[0]][coords[1] + 1]) {
        prices[coords[0]][coords[1] + 1] =
            current + nodes[coords[0]][coords[1] + 1];

        queue.add([coords[0], coords[1] + 1]);
      }

      print(prices
          .expand((element) => element)
          .where((element) => element >= 9223372036854775807)
          .length);
    }

    return prices.last.last;
  }

  @override
  Future<String> second(String input) async {
    var nodes = input
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e
            .split('')
            .where((element) => element.isNotEmpty)
            .map((e) => int.parse(e))
            .toList())
        .toList();

    return largeSafest(nodes).toString();
  }

  int largeSafest(List<List<int>> nodes) {
    List<List<int>> largerNodes = List.generate(nodes.length * 5,
        (index) => List<int>.generate(nodes[0].length * 5, (index) => 0));

    for (var i = 0; i < largerNodes.length; ++i) {
      var x = i % nodes.length;
      var xSize = (i / nodes.length).floor();

      for (var j = 0; j < largerNodes[0].length; ++j) {
        var y = j % nodes[0].length;
        var ySize = (j / nodes[0].length).floor();

        largerNodes[i][j] = (nodes[x][y] + xSize + ySize) % 9;

        if (largerNodes[i][j] < 1) {
          largerNodes[i][j] = 9;
        }
      }
    }

    return safest(largerNodes);
  }
}
