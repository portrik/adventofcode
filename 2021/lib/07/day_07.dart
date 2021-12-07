import 'dart:math';

import 'package:aoc2021/solution.dart';

class Day07 implements Solution {
  @override
  Future<String> first(String input) async {
    var positions = input
        .split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return leastFuel(positions).toString();
  }

  int leastFuel(List<int> positions) {
    var result = 1000 * 1000 * 1000 * 1000;
    var end = positions.reduce((value, element) => max(value, element));

    for (var i = 0; i < end; ++i) {
      var potential = positions.fold(
          0, (value, element) => (value as int) + (i - element).abs());

      if (potential < result) {
        result = potential;
      }
    }

    return result;
  }

  @override
  Future<String> second(String input) async {
    var positions = input
        .split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return risingLeastFuel(positions).toString();
  }

  int risingLeastFuel(List<int> positions) {
    var result = 1000 * 1000 * 1000 * 1000;
    var end = positions.reduce((value, element) => max(value, element));

    for (var i = 0; i < end; ++i) {
      var potential = 0;

      for (final position in positions) {
        var distance = (i - position).abs();

        for (var j = 1; j <= distance; ++j) {
          potential += j;
        }
      }

      if (potential < result) {
        result = potential;
      }
    }

    return result;
  }
}
