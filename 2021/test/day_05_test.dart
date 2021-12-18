import 'package:test/test.dart';

import 'package:aoc2021/day_05.dart';

void main() {
  group('06', () {
    test('First Solver', () {
      var day = Day05();

      var result = day.getOverlappingPoints([
        Line(0, 5, 9, 9),
        Line(8, 0, 0, 8),
        Line(9, 3, 4, 4),
        Line(2, 2, 2, 1),
        Line(7, 7, 0, 4),
        Line(6, 2, 4, 0),
        Line(0, 2, 9, 9),
        Line(3, 1, 4, 4),
        Line(0, 8, 0, 8),
        Line(5, 8, 5, 2)
      ]
          .where(
              (element) => element.x1 == element.x2 || element.y1 == element.y2)
          .toList());

      expect(result, 5);
    });

    test('Second Solver', () {
      var day = Day05();

      var result = day.getOverlappingPoints([
        Line(0, 5, 9, 9),
        Line(8, 0, 0, 8),
        Line(9, 3, 4, 4),
        Line(2, 2, 2, 1),
        Line(7, 7, 0, 4),
        Line(6, 2, 4, 0),
        Line(0, 2, 9, 9),
        Line(3, 1, 4, 4),
        Line(0, 8, 0, 8),
        Line(5, 8, 5, 2)
      ]);

      expect(result, 12);
    });
  });
}
