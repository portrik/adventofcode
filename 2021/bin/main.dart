import './solution.dart';

import './01/day_01.dart';
import './02/day_02.dart';

void main(List<String> arguments) async {
  try {
    if (arguments.isEmpty) {
      throw Exception('No day was selected!');
    }

    var day = arguments[0];
    Solution solution;

    switch (day) {
      case '01':
        solution = Day01();
        break;
      case '02':
        solution = Day02();
        break;
      default:
        throw Exception('Unknown day "$day"!');
    }

    var first = await solution.first();
    print('The first solution of day $day is: $first');

    var second = await solution.second();
    print('The second solution of day $day is: $second');
  } catch (e) {
    print('The solution failed with an error!');
    print(e);
  }
}
