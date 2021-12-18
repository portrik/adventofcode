import 'package:test/test.dart';

import 'package:aoc2021/day_07.dart';

void main() {
  group('07', () {
    test('First Solver', () {
      final day = Day07();

      var result = day.leastFuel([16, 1, 2, 0, 4, 2, 7, 1, 2, 14]);

      expect(result, 37);
    });

    test('Second Solver', () {
      final day = Day07();

      var result = day.risingLeastFuel([16, 1, 2, 0, 4, 2, 7, 1, 2, 14]);

      expect(result, 168);
    });
  });
}
