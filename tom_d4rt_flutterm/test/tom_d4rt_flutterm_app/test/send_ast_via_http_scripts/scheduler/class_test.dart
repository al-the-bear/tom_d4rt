// D4rt test script: Tests scheduler package classes (Priority enum)
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Scheduler package class test executing');
  final results = <String>[];

  // Test 1: Priority enum exists
  results.add('Test 1: Priority enum exists in scheduler package');
  print('Priority enum available');

  // Test 2: Priority.idle value
  final idlePriority = Priority.idle;
  results.add('Priority.idle: $idlePriority');
  print('Priority.idle: $idlePriority');
  assert(idlePriority != null, 'Priority.idle should exist');

  // Test 3: Priority.animation value
  final animPriority = Priority.animation;
  results.add('Priority.animation: $animPriority');
  print('Priority.animation: $animPriority');
  assert(animPriority != null, 'Priority.animation should exist');

  // Test 4: Priority.touch value
  final touchPriority = Priority.touch;
  results.add('Priority.touch: $touchPriority');
  print('Priority.touch: $touchPriority');
  assert(touchPriority != null, 'Priority.touch should exist');

  // Test 5: Priority.kMaxOffset constant
  final maxOffset = Priority.kMaxOffset;
  results.add('Priority.kMaxOffset: $maxOffset');
  print('Priority.kMaxOffset: $maxOffset');
  assert(maxOffset != null, 'kMaxOffset should be defined');

  // Test 6: Priority index access (idle)
  final idleIndex = Priority.idle.index;
  results.add('Priority.idle.index: $idleIndex');
  print('Priority.idle index: $idleIndex');

  // Test 7: Priority index access (animation)
  final animIndex = Priority.animation.index;
  results.add('Priority.animation.index: $animIndex');
  print('Priority.animation index: $animIndex');

  // Test 8: Priority index access (touch)
  final touchIndex = Priority.touch.index;
  results.add('Priority.touch.index: $touchIndex');
  print('Priority.touch index: $touchIndex');

  // Test 9: Priority ordering (touch > animation > idle)
  results.add('Test 9: Priority ordering');
  print('Checking priority ordering');
  assert(touchIndex > animIndex, 'touch should have higher index than animation');
  assert(animIndex > idleIndex, 'animation should have higher index than idle');

  // Test 10: Priority values list
  final values = Priority.values;
  results.add('Priority.values count: ${values.length}');
  print('Priority values count: ${values.length}');
  assert(values.length >= 3, 'Should have at least 3 priority values');

  // Test 11: Priority values contains idle
  final containsIdle = values.contains(Priority.idle);
  results.add('values contains idle: $containsIdle');
  print('Priority.values contains idle: $containsIdle');
  assert(containsIdle, 'Values should contain idle');

  // Test 12: Priority values contains animation
  final containsAnim = values.contains(Priority.animation);
  results.add('values contains animation: $containsAnim');
  print('Priority.values contains animation: $containsAnim');
  assert(containsAnim, 'Values should contain animation');

  // Test 13: Priority values contains touch
  final containsTouch = values.contains(Priority.touch);
  results.add('values contains touch: $containsTouch');
  print('Priority.values contains touch: $containsTouch');
  assert(containsTouch, 'Values should contain touch');

  // Test 14: Priority name getter (idle)
  final idleName = Priority.idle.name;
  results.add('Priority.idle.name: $idleName');
  print('Priority.idle name: $idleName');
  assert(idleName == 'idle', 'Idle name should be "idle"');

  // Test 15: Priority name getter (animation)
  final animName = Priority.animation.name;
  results.add('Priority.animation.name: $animName');
  print('Priority.animation name: $animName');
  assert(animName == 'animation', 'Animation name should be "animation"');

  // Test 16: Priority name getter (touch)
  final touchName = Priority.touch.name;
  results.add('Priority.touch.name: $touchName');
  print('Priority.touch name: $touchName');
  assert(touchName == 'touch', 'Touch name should be "touch"');

  // Test 17: Priority toString
  final idleStr = Priority.idle.toString();
  results.add('Priority.idle.toString(): $idleStr');
  print('Priority.idle toString: $idleStr');
  assert(idleStr.contains('idle'), 'toString should contain "idle"');

  // Test 18: Priority comparison
  results.add('Test 18: Priority comparison via index');
  final isIdleLowerThanAnim = idleIndex < animIndex;
  results.add('idle < animation: $isIdleLowerThanAnim');
  print('Idle lower than animation: $isIdleLowerThanAnim');
  assert(isIdleLowerThanAnim, 'Idle should be lower priority than animation');

  // Test 19: Priority enum iteration
  var iterCount = 0;
  for (final p in Priority.values) {
    iterCount++;
    print('Iterating: $p');
  }
  results.add('Iteration count: $iterCount');
  assert(iterCount >= 3, 'Should iterate at least 3 values');

  // Test 20: Priority identity
  final idle1 = Priority.idle;
  final idle2 = Priority.idle;
  results.add('Priority.idle identity: ${identical(idle1, idle2)}');
  print('Priority identity check');
  assert(identical(idle1, idle2), 'Same priority should be identical');

  print('Scheduler package class test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Scheduler Package Class Tests (${results.length} tests)',
           style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 12)),
      )),
    ],
  );
}
