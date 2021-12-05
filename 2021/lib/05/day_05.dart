import 'package:aoc2021/solution.dart';

class Line {
  int x1;
  int x2;
  int y1;
  int y2;

  Line(this.x1, this.x2, this.y1, this.y2);

  bool xCheck(int x) {
    return x1 < x2 ? x < x2 : x > x2;
  }

  bool yCheck(int y) {
    return y1 < y2 ? y < y2 : y > y2;
  }

  List<String> points() {
    List<String> result = [];

    var x = x1 < x2 ? x1 - 1 : x1 + 1;
    var y = y1 < y2 ? y1 - 1 : y1 + 1;

    while (xCheck(x) || yCheck(y)) {
      if (xCheck(x)) {
        x1 < x2 ? ++x : --x;
      }

      if (yCheck(y)) {
        y1 < y2 ? ++y : --y;
      }

      result.add('$x,$y');
    }

    return result;
  }
}

class Day05 implements Solution {
  @override
  Future<String> first(String input) async {
    var split =
        input.split('\n').where((element) => element.isNotEmpty).toList();

    List<Line> lines = [];
    for (final l in split) {
      var tmp = l.split('->').where((element) => element.isNotEmpty).toList();
      var start = tmp[0].split(',');
      var end = tmp[1].split(',');

      lines.add(Line(int.parse(start[0]), int.parse(end[0]),
          int.parse(start[1]), int.parse(end[1])));
    }

    return getOverlappingPoints(lines
            .where((element) =>
                element.x1 == element.x2 || element.y1 == element.y2)
            .toList())
        .toString();
  }

  /// Bruteforce solution of the problem.
  int getOverlappingPoints(List<Line> lines) {
    Map<String, int> map = {};
    var i = 0;

    for (final line in lines) {
      for (final point in line.points()) {
        map.putIfAbsent(point, () => 0);
        map.update(point, (value) => value + 1);
      }
    }

    return map.values.where((element) => element > 1).toList().length;
  }

  @override
  Future<String> second(String input) async {
    var split =
        input.split('\n').where((element) => element.isNotEmpty).toList();

    List<Line> lines = [];
    for (final l in split) {
      var tmp = l.split('->').where((element) => element.isNotEmpty).toList();
      var start = tmp[0].split(',');
      var end = tmp[1].split(',');

      lines.add(Line(int.parse(start[0]), int.parse(end[0]),
          int.parse(start[1]), int.parse(end[1])));
    }

    return getOverlappingPoints(lines).toString();
  }
}
