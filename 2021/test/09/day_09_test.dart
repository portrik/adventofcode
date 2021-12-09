import 'package:test/test.dart';

import 'package:aoc2021/09/day_09.dart';

void main() {
  group('09', () {
    test('First Solver', () {
      final day = Day09();

      var result = day.lowestPoints(
          '2199943210\n3987894921\n9856789892\n8767896789\n9899965678\n'
              .split('\n')
              .where((element) => element.isNotEmpty)
              .map((e) => e
                  .split('')
                  .where((element) => element.isNotEmpty)
                  .map((e) => int.parse(e))
                  .toList())
              .toList());

      expect(result, 15);
    });

    test('Second Solver', () {
      final day = Day09();

      var result = day.basins(
          '2199943210\n3987894921\n9856789892\n8767896789\n9899965678\n'
              .split('\n')
              .where((element) => element.isNotEmpty)
              .map((e) => e
                  .split('')
                  .where((element) => element.isNotEmpty)
                  .map((e) => int.parse(e))
                  .toList())
              .toList());

      expect(result, 1134);
    });
  });
}
