import 'package:test/test.dart';

import 'package:aoc2021/10/day_10.dart';

void main() {
  group('10', () {
    test('Test Solver', () {
      final day = Day10();

      var tested = [
        '[({(<(())[]>[[{[]{<()<>>',
        '[(()[<>])]({[<{<<[]>>(',
        '{([(<{}[<>[]}>{[]{[(<()>',
        '(((({<>}<{<{<>}{[]{[]{}',
        '[[<[([]))<([[{}[[()]]]',
        '[{[{({}]{}}([{[{{{}}([]',
        '{<[[]]>}<{[{[{[]{()[[[]',
        '[<(<(<(<{}))><([]([]()',
        '<{([([[(<>()){}]>(<<{{',
        '<{([{{}}[<[[[<>{}]]]>[]]'
      ];

      expect(day.corrupted(tested), 26397);
    });

    test('Second Solver', () {
      final day = Day10();

      var tested = [
        '[({(<(())[]>[[{[]{<()<>>',
        '[(()[<>])]({[<{<<[]>>(',
        '{([(<{}[<>[]}>{[]{[(<()>',
        '(((({<>}<{<{<>}{[]{[]{}',
        '[[<[([]))<([[{}[[()]]]',
        '[{[{({}]{}}([{[{{{}}([]',
        '{<[[]]>}<{[{[{[]{()[[[]',
        '[<(<(<(<{}))><([]([]()',
        '<{([([[(<>()){}]>(<<{{',
        '<{([{{}}[<[[[<>{}]]]>[]]'
      ].where((element) => day.getPrice(element) == 0).toList();

      expect(day.incomplete(tested), 288957);
    });
  });
}
