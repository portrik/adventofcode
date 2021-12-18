import 'dart:math';

import 'package:test/test.dart';

import 'package:aoc2021/day_15.dart';

void main() {
  group('15', () {
    test('First Solver', () {
      final day = Day15();

      var input = [
        '1163751742',
        '1381373672',
        '2136511328',
        '3694931569',
        '7463417111',
        '1319128137',
        '1359912421',
        '3125421639',
        '1293138521',
        '2311944581'
      ]
          .map((e) => e
              .split('')
              .where((element) => element.isNotEmpty)
              .map((e) => int.parse(e))
              .toList())
          .toList();

      var result = day.safest(input);

      expect(result, 40);
    });

    test('Second Solver', () {
      final day = Day15();

      var input = [
        '1163751742',
        '1381373672',
        '2136511328',
        '3694931569',
        '7463417111',
        '1319128137',
        '1359912421',
        '3125421639',
        '1293138521',
        '2311944581'
      ]
          .map((e) => e
              .split('')
              .where((element) => element.isNotEmpty)
              .map((e) => int.parse(e))
              .toList())
          .toList();

      var result = day.largeSafest(input);

      expect(result, 315);
    });
  });
}
