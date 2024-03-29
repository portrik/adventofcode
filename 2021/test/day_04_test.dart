import 'package:test/test.dart';

import 'package:aoc2021/day_04.dart';

void main() {
  group('04', () {
    test('Bingo Board Validation', () {
      var board = Board([
        [14, 21, 17, 24, 4],
        [10, 16, 15, 9, 19],
        [18, 8, 23, 26, 20],
        [22, 11, 13, 6, 5],
        [2, 0, 12, 3, 7]
      ]);

      var result = board.isWinner([]);
      expect(result, null);

      result = board.isWinner([7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21]);
      expect(result, null);

      result = board.isWinner([7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24]);
      expect(result, 4512);
    });

    test('First Solver', () {
      var numbers = [
        7,
        4,
        9,
        5,
        11,
        17,
        23,
        2,
        0,
        14,
        21,
        24,
        10,
        16,
        13,
        6,
        15,
        25,
        12,
        22,
        18,
        20,
        8,
        19,
        3,
        26,
        1
      ];

      var boards = [
        Board([
          [
            22,
            13,
            17,
            11,
            0,
          ],
          [
            8,
            2,
            23,
            4,
            24,
          ],
          [
            21,
            9,
            14,
            16,
            7,
          ],
          [6, 10, 3, 18, 5],
          [1, 12, 20, 15, 19]
        ]),
        Board([
          [
            3,
            15,
            0,
            2,
            22,
          ],
          [9, 18, 13, 17, 5],
          [19, 8, 7, 25, 23],
          [20, 11, 10, 24, 4],
          [14, 21, 16, 12, 6]
        ]),
        Board([
          [14, 21, 17, 24, 4],
          [10, 16, 15, 9, 19],
          [18, 8, 23, 26, 20],
          [22, 11, 13, 6, 5],
          [2, 0, 12, 3, 7]
        ])
      ];

      var day = Day04();
      var result = day.solveBingo(boards, numbers);

      expect(result, 4512);
    });

    test('Second Solver', () {
      var numbers = [
        7,
        4,
        9,
        5,
        11,
        17,
        23,
        2,
        0,
        14,
        21,
        24,
        10,
        16,
        13,
        6,
        15,
        25,
        12,
        22,
        18,
        20,
        8,
        19,
        3,
        26,
        1
      ];

      var boards = [
        Board([
          [
            22,
            13,
            17,
            11,
            0,
          ],
          [
            8,
            2,
            23,
            4,
            24,
          ],
          [
            21,
            9,
            14,
            16,
            7,
          ],
          [6, 10, 3, 18, 5],
          [1, 12, 20, 15, 19]
        ]),
        Board([
          [
            3,
            15,
            0,
            2,
            22,
          ],
          [9, 18, 13, 17, 5],
          [19, 8, 7, 25, 23],
          [20, 11, 10, 24, 4],
          [14, 21, 16, 12, 6]
        ]),
        Board([
          [14, 21, 17, 24, 4],
          [10, 16, 15, 9, 19],
          [18, 8, 23, 26, 20],
          [22, 11, 13, 6, 5],
          [2, 0, 12, 3, 7]
        ])
      ];

      var day = Day04();
      var result = day.solveLastBingo(boards, numbers);

      expect(result, 1924);
    });
  });
}
