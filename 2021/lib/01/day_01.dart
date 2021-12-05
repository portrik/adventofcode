import 'dart:async';

import 'package:aoc2021/solution.dart';

class Day01 implements Solution {
  @override
  Future<String> first(String input) async {
    var values = input
        .split('\n')
        .where((element) => element.trim().isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return submarineIncreases(values).toString();
  }

  int submarineIncreases(List<int> values) {
    var increases = 0;

    for (var i = 1; i < values.length; ++i) {
      if (values[i - 1] < values[i]) {
        ++increases;
      }
    }

    return increases;
  }

  @override
  Future<String> second(String input) async {
    var values = input
        .split('\n')
        .where((element) => element.trim().isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return submarineTripleIncrease(values).toString();
  }

  int submarineTripleIncrease(List<int> values) {
    var increases = 0;

    for (var i = 3; i < values.length; ++i) {
      var previous = values[i - 3] + values[i - 2] + values[i - 1];
      var current = values[i - 2] + values[i - 1] + values[i];

      if (current > previous) {
        ++increases;
      }
    }

    return increases;
  }
}
