import 'dart:io';

import 'package:path/path.dart' as path;

import 'package:aoc2021/solution.dart';

import 'package:aoc2021/01/day_01.dart';
import 'package:aoc2021/02/day_02.dart';
import 'package:aoc2021/03/day_03.dart';
import 'package:aoc2021/04/day_04.dart';
import 'package:aoc2021/05/day_05.dart';
import 'package:aoc2021/06/day_06.dart';
import 'package:aoc2021/07/day_07.dart';
import 'package:aoc2021/08/day_08.dart';
import 'package:aoc2021/09/day_09.dart';
import 'package:aoc2021/10/day_10.dart';
import 'package:aoc2021/11/day_11.dart';
import 'package:aoc2021/12/day_12.dart';
import 'package:aoc2021/13/day_13.dart';
import 'package:aoc2021/14/day_14.dart';

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
      case '05':
        solution = Day05();
        break;
      case '06':
        solution = Day06();
        break;
      case '07':
        solution = Day07();
        break;
      case '08':
        solution = Day08();
        break;
      case '09':
        solution = Day09();
        break;
      case '10':
        solution = Day10();
        break;
      case '11':
        solution = Day11();
        break;
      case '12':
        solution = Day12();
        break;
      case '13':
        solution = Day13();
        break;
      case '14':
        solution = Day14();
        break;
      default:
        throw Exception('Unknown day "$day"!');
    }

    var input = await loadInput(day);

    var first = await solution.first(input);
    print('The first solution of day $day is: $first');

    var second = await solution.second(input);
    print('The second solution of day $day is: $second');
  } catch (e, stacktrace) {
    print('The solution failed with an error!');
    print(e);
    print(stacktrace);
  }
}
