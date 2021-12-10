import 'package:aoc2021/solution.dart';

class Day10 implements Solution {
  final opening = ['(', '[', '{', '<'];
  final closing = [')', ']', '}', '>'];

  @override
  Future<String> first(String input) async {
    return corrupted(
            input.split('\n').where((element) => element.isNotEmpty).toList())
        .toString();
  }

  int corrupted(List<String> lines) {
    return lines.map(getPrice).reduce((value, element) => value + element);
  }

  int getPrice(String line) {
    final price = [3, 57, 1197, 25137];

    var current = 1;
    var openers = [line[0]];

    while (openers.isNotEmpty && current < line.length) {
      if (opening.contains(line[current])) {
        openers.add(line[current]);
        ++current;
        continue;
      }

      if (closing.indexOf(line[current]) == opening.indexOf(openers.last)) {
        openers.removeLast();
        ++current;
        continue;
      }

      return price[closing.indexOf(line[current])];
    }

    return 0;
  }

  @override
  Future<String> second(String input) async {
    return incomplete(input
            .split('\n')
            .where((element) => element.isNotEmpty)
            .where((element) => getPrice(element) == 0)
            .toList())
        .toString();
  }

  int incomplete(List<String> lines) {
    var prices = lines.map(getCompletePrice).toList();
    prices.sort();

    return prices[(prices.length / 2).floor()];
  }

  int getCompletePrice(String line) {
    var prices = [1, 2, 3, 4];
    var current = 1;
    var openers = [line[0]];

    while (current < line.length) {
      if (opening.contains(line[current])) {
        openers.add(line[current]);
        ++current;
        continue;
      }

      if (closing.indexOf(line[current]) == opening.indexOf(openers.last)) {
        openers.removeLast();
        ++current;
        continue;
      }

      throw Exception('Unexpected missing closing bracket!');
    }

    var value = 0;
    for (final opener in openers.reversed) {
      value *= 5;
      value += prices[opening.indexOf(opener)];
    }

    return value;
  }
}
