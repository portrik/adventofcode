import 'dart:io';

import 'package:path/path.dart' as path;

import './solution.dart';

import './01/day_01.dart';
import './02/day_02.dart';
import './03/day_03.dart';
import './04/day_04.dart';

Future<String> loadInput(String name) async {
  var inputFolder =
      Platform.script.path.substring(0, Platform.script.path.lastIndexOf('/'));
  inputFolder = inputFolder.substring(0, inputFolder.lastIndexOf('/'));

  var contents =
      await File(path.join(inputFolder, 'input', '$name.txt')).readAsString();

  return contents;
}

void main(List<String> arguments) async {
  try {
    if (arguments.isEmpty) {
      throw Exception('No day was selected!');
    }

    var day = arguments[0];
    Solution solution;

    switch (day) {
      case '01':
        solution = Day01();
        break;
      case '02':
        solution = Day02();
        break;
      case '03':
        solution = Day03();
        break;
      case '04':
        solution = Day04();
        break;
      default:
        throw Exception('Unknown day "$day"!');
    }

    var input = await loadInput(day);

    var first = await solution.first(input);
    print('The first solution of day $day is: $first');

    var second = await solution.second(input);
    print('The second solution of day $day is: $second');
  } catch (e) {
    print('The solution failed with an error!');
    print(e);
  }
}
