import 'dart:io';

import 'package:logger/logger.dart';

import './solution.dart';

import './01/day_01.dart';

void main(List<String> arguments) async {
  var logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: stdout.terminalColumns,
          colors: stdout.supportsAnsiEscapes,
          printEmojis: true,
          printTime: false));
  Solution solution;

  try {
    var day = arguments[0];

    switch (day) {
      case '01':
        solution = Day01();
        break;
      default:
        throw Exception('Unknown day "$day"!');
    }

    var first = await solution.first();
    logger.i('The first solution of day $day is: $first');

    var second = await solution.second();
    logger.i('The second solution of day $day is: $second');
  } catch (e) {
    logger.e('The solution failed with an error!');
    logger.e(e);
  }
}
