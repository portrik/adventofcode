import 'dart:async';

import '../solution.dart';

class Day02 implements Solution {
  @override
  Future<String> first(String input) async {
    var values = input
        .split('\n')
        .where((element) => element.trim().isNotEmpty)
        .toList();

    return moveSubmarine(values).toString();
  }

  int moveSubmarine(List<String> instructions) {
    var depth = 0;
    var position = 0;

    for (final instruction in instructions) {
      var split = instruction.split(' ');

      if (split[0] == 'forward') {
        position += int.parse(split[1]);
      } else if (split[0] == 'down') {
        depth += int.parse(split[1]);
      } else if (split[0] == 'up') {
        depth -= int.parse(split[1]);
      }
    }

    return depth * position;
  }

  @override
  Future<String> second(String input) async {
    var values = input
        .split('\n')
        .where((element) => element.trim().isNotEmpty)
        .toList();

    return aimSubmarine(values).toString();
  }

  int aimSubmarine(List<String> instructions) {
    var position = 0;
    var depth = 0;
    var aim = 0;

    for (final instruction in instructions) {
      var split = instruction.split(' ');

      if (split[0] == 'forward') {
        position += int.parse(split[1]);
        depth += aim * int.parse(split[1]);
      } else if (split[0] == 'down') {
        aim += int.parse(split[1]);
      } else if (split[0] == 'up') {
        aim -= int.parse(split[1]);
      }
    }

    return position * depth;
  }
}
