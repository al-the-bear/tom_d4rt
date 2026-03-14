// D4rt test script: Tests Priority enum from scheduler in detail
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Priority enum detailed test executing');
  final results = <String>[];

  // Test 1: Priority.idle exists and is valid
  final idle = Priority.idle;
  results.add('Test 1: Priority.idle = $idle');
  print('Priority.idle: $idle');
  assert(idle == Priority.idle, 'idle should equal itself');

  // Test 2: Priority.animation exists and is valid
  final animation = Priority.animation;
  results.add('Test 2: Priority.animation = $animation');
  print('Priority.animation: $animation');
  assert(animation == Priority.animation, 'animation should equal itself');

  // Test 3: Priority.touch exists and is valid
  final touch = Priority.touch;
  results.add('Test 3: Priority.touch = $touch');
  print('Priority.touch: $touch');
  assert(touch == Priority.touch, 'touch should equal itself');

  // Test 4: Index of idle
  results.add('Test 4: Priority.idle.index = ${idle.index}');
  print('idle index: ${idle.index}');

  // Test 5: Index of animation
  results.add('Test 5: Priority.animation.index = ${animation.index}');
  print('animation index: ${animation.index}');

  // Test 6: Index of touch
  results.add('Test 6: Priority.touch.index = ${touch.index}');
  print('touch index: ${touch.index}');

  // Test 7: Index ordering (idle < animation)
  final idleLessAnim = idle.index < animation.index;
  results.add('Test 7: idle.index < animation.index = $idleLessAnim');
  print('idle < animation: $idleLessAnim');
  assert(idleLessAnim, 'idle should have lower index than animation');

  // Test 8: Index ordering (animation < touch)
  final animLessTouch = animation.index < touch.index;
  results.add('Test 8: animation.index < touch.index = $animLessTouch');
  print('animation < touch: $animLessTouch');
  assert(animLessTouch, 'animation should have lower index than touch');

  // Test 9: Name of idle
  results.add('Test 9: Priority.idle.name = "${idle.name}"');
  print('idle.name: ${idle.name}');
  assert(idle.name == 'idle', 'idle.name should be "idle"');

  // Test 10: Name of animation
  results.add('Test 10: Priority.animation.name = "${animation.name}"');
  print('animation.name: ${animation.name}');
  assert(animation.name == 'animation', 'animation.name should be "animation"');

  // Test 11: Name of touch
  results.add('Test 11: Priority.touch.name = "${touch.name}"');
  print('touch.name: ${touch.name}');
  assert(touch.name == 'touch', 'touch.name should be "touch"');

  // Test 12: Priority.values list
  final values = Priority.values;
  results.add('Test 12: Priority.values.length = ${values.length}');
  print('Priority.values.length: ${values.length}');
  assert(values.length >= 3, 'Should have at least 3 values');

  // Test 13: Values contains all three main priorities
  final hasAll = values.contains(idle) && values.contains(animation) && values.contains(touch);
  results.add('Test 13: values contains all three = $hasAll');
  print('Contains all three: $hasAll');
  assert(hasAll, 'Values should contain all three priorities');

  // Test 14: kMaxOffset constant
  final maxOffset = Priority.kMaxOffset;
  results.add('Test 14: Priority.kMaxOffset = $maxOffset');
  print('kMaxOffset: $maxOffset');
  assert(maxOffset >= 0, 'kMaxOffset should be non-negative');

  // Test 15: Priority toString contains name
  final idleStr = idle.toString();
  results.add('Test 15: idle.toString() = "$idleStr"');
  print('idle.toString: $idleStr');
  assert(idleStr.contains('idle'), 'toString should contain "idle"');

  // Test 16: Animation toString
  final animStr = animation.toString();
  results.add('Test 16: animation.toString() = "$animStr"');
  print('animation.toString: $animStr');
  assert(animStr.contains('animation'), 'toString should contain "animation"');

  // Test 17: Touch toString
  final touchStr = touch.toString();
  results.add('Test 17: touch.toString() = "$touchStr"');
  print('touch.toString: $touchStr');
  assert(touchStr.contains('touch'), 'toString should contain "touch"');

  // Test 18: Equality tests (same enum values)
  results.add('Test 18: Priority.idle == Priority.idle = ${Priority.idle == Priority.idle}');
  print('idle == idle: ${Priority.idle == Priority.idle}');
  assert(Priority.idle == Priority.idle, 'Same enum value should be equal');

  // Test 19: Inequality tests (different enum values)
  final idleNotAnim = Priority.idle != Priority.animation;
  results.add('Test 19: idle != animation = $idleNotAnim');
  print('idle != animation: $idleNotAnim');
  assert(idleNotAnim, 'Different enum values should not be equal');

  // Test 20: Inequality tests (animation != touch)
  final animNotTouch = Priority.animation != Priority.touch;
  results.add('Test 20: animation != touch = $animNotTouch');
  print('animation != touch: $animNotTouch');
  assert(animNotTouch, 'Different enum values should not be equal');

  // Test 21: Values are ordered
  var orderedProperly = true;
  for (var i = 0; i < values.length - 1; i++) {
    if (values[i].index >= values[i + 1].index) {
      orderedProperly = false;
      break;
    }
  }
  results.add('Test 21: values ordered by index = $orderedProperly');
  print('Values ordered: $orderedProperly');

  // Test 22: First value is idle
  results.add('Test 22: values[0] = ${values[0]}');
  print('First value: ${values[0]}');

  // Test 23: Last value has highest index
  final lastVal = values.last;
  results.add('Test 23: values.last.index = ${lastVal.index}');
  print('Last value index: ${lastVal.index}');

  // Test 24: Hash code consistency
  final hash1 = idle.hashCode;
  final hash2 = idle.hashCode;
  results.add('Test 24: hashCode consistent = ${hash1 == hash2}');
  print('Hash code consistent: ${hash1 == hash2}');

  print('Priority enum detailed test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Priority Enum Detailed Tests (${results.length} tests)',
           style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 12)),
      )),
    ],
  );
}
