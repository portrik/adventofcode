import 'package:aoc2021/solution.dart';

class Day13 implements Solution {
  @override
  Future<String> first(String input) async {
    return firstFold(
            input.split('\n').where((element) => element.isNotEmpty).toList())
        .expand((element) => element)
        .where((element) => element)
        .length
        .toString();
  }

  List<List<bool>> firstFold(List<String> input) {
    var xSize = 0;
    var ySize = 0;

    for (final line in input) {
      var split = line.split(',');

      if (split.length < 2) {
        break;
      }

      if (int.parse(split[0]) > xSize) {
        xSize = int.parse(split[0]);
      }

      if (int.parse(split[1]) > ySize) {
        ySize = int.parse(split[1]);
      }
    }

    ++xSize;
    ++ySize;

    List<List<bool>> paper = List.generate(
        ySize, (index) => List<bool>.generate(xSize, (index) => false));

    for (final line in input) {
      var split = line.split(',');

      if (split.length < 2) {
        break;
      }

      var column = int.parse(split[1]);
      var row = int.parse(split[0]);

      paper[column][row] = true;
    }

    var direction = input
        .firstWhere((element) => element.split(',').length == 1)
        .split(' ')[2]
        .split('=');

    paper = fold(paper, int.parse(direction[1]), direction[0] == 'x');

    return paper;
  }

  List<List<bool>> fold(List<List<bool>> input, int position, bool x) {
    var result = x
        ? input.map((e) => e.sublist(0, (e.length / 2).floor())).toList()
        : input.sublist(0, (input.length / 2).floor()).toList();

    var rest = x
        ? input
            .map((e) => e.sublist((e.length / 2).floor()).reversed.toList())
            .toList()
        : input.sublist((input.length / 2).floor()).reversed.toList();

    for (var row = 0; row < result.length; ++row) {
      for (var column = 0; column < result[0].length; ++column) {
        result[row][column] = result[row][column] || rest[row][column];
      }
    }

    return result;
  }

  @override
  Future<String> second(String input) async {
    return foldAndParse(
        input.split('\n').where((element) => element.isNotEmpty).toList());
  }

  String foldAndParse(List<String> input) {
    var xSize = 0;
    var ySize = 0;

    for (final line in input) {
      var split = line.split(',');

      if (split.length < 2) {
        break;
      }

      if (int.parse(split[0]) > xSize) {
        xSize = int.parse(split[0]);
      }

      if (int.parse(split[1]) > ySize) {
        ySize = int.parse(split[1]);
      }
    }

    ++xSize;
    ++ySize;

    List<List<bool>> paper = List.generate(
        ySize, (index) => List<bool>.generate(xSize, (index) => false));

    for (final line in input) {
      var split = line.split(',');

      if (split.length < 2) {
        break;
      }

      var column = int.parse(split[1]);
      var row = int.parse(split[0]);

      paper[column][row] = true;
    }

    var folds = input
        .where((element) => element.split(',').length < 2)
        .map((e) => e.split(' ')[2].split('='))
        .toList();

    for (final f in folds) {
      paper = fold(paper, int.parse(f[1]), f[0] == 'x');
    }

    var result = '';
    for (final row in paper) {
      result += row.map((e) => e ? '#' : '').join('') + '\n';
    }

    return result;
  }
}
