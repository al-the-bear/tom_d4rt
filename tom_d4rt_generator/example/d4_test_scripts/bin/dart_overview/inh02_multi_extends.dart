// D4rt test: INH02 - Multi-level extends
// Verifies multi-level class inheritance chains work via bridges.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Machine → Robot → AdvancedRobot (3-level chain)
  var robot = Robot();
  robot.move(); // void — prints 'Robot moving'

  var advanced = AdvancedRobot();
  // Inherited from Robot (which overrides Machine.move())
  advanced.move(); // void — prints 'Robot moving'

  // AdvancedRobot implements Speakable
  advanced.speak(); // void — prints 'Robot speaking: Hello!'

  // AdvancedRobot implements Connectable
  advanced.connect(); // void — prints 'Robot connected to network'

  if (errors.isEmpty) {
    print('INH02_PASSED');
  } else {
    print('INH02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
