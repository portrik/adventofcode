import '../solution.dart';

class Board {
  List<List<num>> numbers;

  Board(this.numbers);

  num? isWinner(List<num> winning) {
    for (var i = 0; i < numbers.length; ++i) {
      var column = [];
      for (var j = 0; j < numbers[i].length; ++j) {
        column.add(numbers[j][i]);
      }

      num? bingo;

      if (numbers[i].every((element) => winning.contains(element))) {
        bingo = numbers[i].reduce((value, element) => value + element);
      }

      if (column.every((element) => winning.contains(element))) {
        bingo = column.reduce((value, element) => value + element);
      }

      if (bingo != null) {
        var unmarked = numbers
            .map((e) => e.where((element) => !winning.contains(element)))
            .where((element) => element.isNotEmpty)
            .fold(
                0,
                (previous, current) =>
                    (previous as num) +
                    current.reduce((value, element) => value + element));

        return unmarked * winning[winning.length - 1];
      }
    }
  }
}

class Day04 implements Solution {
  @override
  Future<String> first(String input) async {
    var rows = input.split('\n');
    var winningNumbers = rows[0]
        .split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => num.parse(e))
        .toList();

    rows = rows.sublist(1).where((element) => element.isNotEmpty).toList();
    List<Board> boards = [];

    for (var i = 0; i < rows.length; i += 5) {
      List<List<num>> numbers = [];

      for (var j = 0; j < 5; ++j) {
        numbers.add(rows[i + j]
            .split(' ')
            .where((element) => element.isNotEmpty)
            .map((e) => num.parse(e))
            .toList());
      }

      boards.add(Board(numbers));
    }

    return solveBingo(boards, winningNumbers).toString();
  }

  num? solveBingo(List<Board> boards, List<num> numbers) {
    for (var i = 5; i < numbers.length; ++i) {
      for (final board in boards) {
        var solution = board.isWinner(numbers.sublist(0, i));
        if (solution != null) {
          return solution;
        }
      }
    }
  }

  @override
  Future<String> second(String input) async {
    var rows = input.split('\n');
    var winningNumbers = rows[0]
        .split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => num.parse(e))
        .toList();

    rows = rows.sublist(1).where((element) => element.isNotEmpty).toList();
    List<Board> boards = [];

    for (var i = 0; i < rows.length; i += 5) {
      List<List<num>> numbers = [];

      for (var j = 0; j < 5; ++j) {
        numbers.add(rows[i + j]
            .split(' ')
            .where((element) => element.isNotEmpty)
            .map((e) => num.parse(e))
            .toList());
      }

      boards.add(Board(numbers));
    }

    return solveLastBingo(boards, winningNumbers).toString();
  }

  num? solveLastBingo(List<Board> boards, List<num> numbers) {
    var currentBoards = [...boards]
        .where((element) => element.isWinner(numbers) != null)
        .toList();

    for (var i = numbers.length - 1; i > 5; --i) {
      var loser = currentBoards
          .where((element) => element.isWinner(numbers.sublist(0, i)) == null)
          .toList();

      if (loser.isNotEmpty) {
        return loser[0].isWinner(numbers.sublist(0, i + 1));
      }
    }
  }
}
