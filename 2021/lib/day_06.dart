import 'package:aoc2021/solution.dart';

class Day06 implements Solution {
  Map<String, int> map = {};

  @override
  Future<String> first(String input) async {
    var numbers = input
        .split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return simulateFish(numbers, 80).toString();
  }

  int simulateFish(List<int> initial, int time) {
    var fishes = initial.length;

    for (final fish in initial) {
      fishes += fishesToSpawn(fish, time);
    }

    return fishes;
  }

  int fishesToSpawn(int initialTime, int initialDay) {
    if (map.containsKey('$initialTime,$initialDay')) {
      return map['$initialTime,$initialDay'] as int;
    }

    var counter = 0;
    var time = initialTime;
    var day = initialDay - 1;

    while (day > 0) {
      day -= time;
      time = 7;

      if (day >= 0) {
        ++counter;
        counter += fishesToSpawn(8, day);
      }
    }

    map['$initialTime,$initialDay'] = counter;
    return counter;
  }

  @override
  Future<String> second(String input) async {
    var numbers = input
        .split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return simulateFish(numbers, 256).toString();
  }
}
