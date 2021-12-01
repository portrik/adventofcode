import 'package:test/test.dart';

import '../../bin/01/day_01.dart';

void main() {
  group('01', () {
    test('First Solver', () {
      final day = Day01();

      var result = day.submarineIncreases([
        199,
        200,
        208,
        210,
        200,
        207,
        240,
        269,
        260,
        263,
      ]);

      expect(result, 7);
    });

    test('Second Solver', () {
      final day = Day01();

      var result = day.submarineTripleIncrease([
        199,
        200,
        208,
        210,
        200,
        207,
        240,
        269,
        260,
        263,
      ]);

      expect(result, 5);
    });
  });
}
