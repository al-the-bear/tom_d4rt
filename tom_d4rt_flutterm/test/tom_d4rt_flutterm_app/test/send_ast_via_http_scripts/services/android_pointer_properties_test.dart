// D4rt test script: Tests AndroidPointerProperties from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidPointerProperties comprehensive test executing');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Helper to record test results
  void recordTest(String name, bool passed) {
    if (passed) {
      passCount++;
      results.add('✓ $name');
      print('PASS: $name');
    } else {
      failCount++;
      results.add('✗ $name');
      print('FAIL: $name');
    }
  }

  // Test 1: Basic AndroidPointerProperties creation
  print('\n--- Test 1: Basic AndroidPointerProperties creation ---');
  try {
    final props = AndroidPointerProperties(id: 0, toolType: 1);
    assert(props.id == 0);
    assert(props.toolType == 1);
    print(
      'Created properties with id: ${props.id}, toolType: ${props.toolType}',
    );
    recordTest('Basic AndroidPointerProperties creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Basic AndroidPointerProperties creation', false);
  }

  // Test 2: Different pointer IDs
  print('\n--- Test 2: Different pointer IDs ---');
  try {
    final props0 = AndroidPointerProperties(id: 0, toolType: 1);
    final props1 = AndroidPointerProperties(id: 1, toolType: 1);
    final props2 = AndroidPointerProperties(id: 2, toolType: 1);

    assert(props0.id == 0);
    assert(props1.id == 1);
    assert(props2.id == 2);
    print('Pointer 0 id: ${props0.id}');
    print('Pointer 1 id: ${props1.id}');
    print('Pointer 2 id: ${props2.id}');
    recordTest('Different pointer IDs', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Different pointer IDs', false);
  }

  // Test 3: Tool type FINGER (1)
  print('\n--- Test 3: Tool type FINGER ---');
  try {
    final fingerProps = AndroidPointerProperties(id: 0, toolType: 1);
    assert(fingerProps.toolType == 1);
    print('FINGER tool type: ${fingerProps.toolType}');
    recordTest('Tool type FINGER', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type FINGER', false);
  }

  // Test 4: Tool type STYLUS (2)
  print('\n--- Test 4: Tool type STYLUS ---');
  try {
    final stylusProps = AndroidPointerProperties(id: 0, toolType: 2);
    assert(stylusProps.toolType == 2);
    print('STYLUS tool type: ${stylusProps.toolType}');
    recordTest('Tool type STYLUS', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type STYLUS', false);
  }

  // Test 5: Tool type MOUSE (3)
  print('\n--- Test 5: Tool type MOUSE ---');
  try {
    final mouseProps = AndroidPointerProperties(id: 0, toolType: 3);
    assert(mouseProps.toolType == 3);
    print('MOUSE tool type: ${mouseProps.toolType}');
    recordTest('Tool type MOUSE', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type MOUSE', false);
  }

  // Test 6: Tool type ERASER (4)
  print('\n--- Test 6: Tool type ERASER ---');
  try {
    final eraserProps = AndroidPointerProperties(id: 0, toolType: 4);
    assert(eraserProps.toolType == 4);
    print('ERASER tool type: ${eraserProps.toolType}');
    recordTest('Tool type ERASER', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type ERASER', false);
  }

  // Test 7: Tool type UNKNOWN (0)
  print('\n--- Test 7: Tool type UNKNOWN ---');
  try {
    final unknownProps = AndroidPointerProperties(id: 0, toolType: 0);
    assert(unknownProps.toolType == 0);
    print('UNKNOWN tool type: ${unknownProps.toolType}');
    recordTest('Tool type UNKNOWN', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type UNKNOWN', false);
  }

  // Test 8: Multiple pointers with different tools
  print('\n--- Test 8: Multiple pointers with different tools ---');
  try {
    final propsList = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1), // Finger
      AndroidPointerProperties(id: 1, toolType: 1), // Finger
      AndroidPointerProperties(id: 2, toolType: 2), // Stylus
    ];
    assert(propsList.length == 3);
    assert(propsList[0].toolType == 1);
    assert(propsList[1].toolType == 1);
    assert(propsList[2].toolType == 2);
    print('Created ${propsList.length} pointer properties');
    for (int i = 0; i < propsList.length; i++) {
      print('Pointer ${propsList[i].id}: toolType ${propsList[i].toolType}');
    }
    recordTest('Multiple pointers with different tools', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Multiple pointers with different tools', false);
  }

  // Test 9: High pointer ID values
  print('\n--- Test 9: High pointer ID values ---');
  try {
    final highIdProps = AndroidPointerProperties(id: 99, toolType: 1);
    assert(highIdProps.id == 99);
    print('High ID pointer: ${highIdProps.id}');

    final maxIdProps = AndroidPointerProperties(id: 255, toolType: 1);
    assert(maxIdProps.id == 255);
    print('Max ID pointer: ${maxIdProps.id}');
    recordTest('High pointer ID values', true);
  } catch (e) {
    print('Error: $e');
    recordTest('High pointer ID values', false);
  }

  // Test 10: Properties for multi-touch gesture
  print('\n--- Test 10: Properties for multi-touch gesture ---');
  try {
    // Simulating a pinch gesture with two fingers
    final pinchProps = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
      AndroidPointerProperties(id: 1, toolType: 1),
    ];
    assert(pinchProps.length == 2);
    assert(pinchProps[0].id != pinchProps[1].id);
    print(
      'Pinch gesture with pointers: ${pinchProps[0].id} and ${pinchProps[1].id}',
    );
    recordTest('Properties for multi-touch gesture', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Properties for multi-touch gesture', false);
  }

  // Test 11: Stylus with eraser end
  print('\n--- Test 11: Stylus tool transitions ---');
  try {
    // Regular stylus tip
    final stylusTip = AndroidPointerProperties(id: 0, toolType: 2);
    assert(stylusTip.toolType == 2);
    print('Stylus tip: toolType ${stylusTip.toolType}');

    // Stylus eraser end
    final stylusEraser = AndroidPointerProperties(id: 0, toolType: 4);
    assert(stylusEraser.toolType == 4);
    print('Stylus eraser: toolType ${stylusEraser.toolType}');
    recordTest('Stylus tool transitions', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Stylus tool transitions', false);
  }

  // Print summary
  print('\n========================================');
  print('AndroidPointerProperties Test Summary');
  print('========================================');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('Total:  ${passCount + failCount}');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'AndroidPointerProperties Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount | Failed: $failCount',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
