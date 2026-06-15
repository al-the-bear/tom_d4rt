// geometry_calc — vector arithmetic from a script, all on bridged native types.
//
// Shows bridged operators (+, -, *), getters (.magnitude) and methods
// (.dot, .normalized) on the native Vector2 class.

import 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart';

void main(List<String> args) {
  final a = Vector2(3, 4);
  final b = Vector2(1, 2);

  print('a = $a   (magnitude ${a.magnitude})');
  print('b = $b');
  print('a + b   = ${a + b}');
  print('a - b   = ${a - b}');
  print('a * 2   = ${a * 2.0}');
  print('a . b   = ${a.dot(b)}');
  print('a norm  = ${a.normalized()}  (magnitude ${a.normalized().magnitude})');
}
