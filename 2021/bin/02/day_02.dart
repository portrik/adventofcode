import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;

import '../solution.dart';

class Day02 implements Solution {
  @override
  Future<String> first() async {
    var contents = await File(path.join(
            Platform.script.path
                .substring(0, Platform.script.path.lastIndexOf('/')),
            '02',
            'input.txt'))
        .readAsString();

    var values = contents
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
  Future<String> second() async {
    var contents = await File(path.join(
            Platform.script.path
                .substring(0, Platform.script.path.lastIndexOf('/')),
            '02',
            'input.txt'))
        .readAsString();

    var values = contents
        .split('\n')
        .where((element) => element.trim().isNotEmpty)
        .toList();

    return aimSumbarine(values).toString();
  }

  int aimSumbarine(List<String> instructions) {
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
