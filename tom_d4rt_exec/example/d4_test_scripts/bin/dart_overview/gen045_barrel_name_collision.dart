// D4rt test: GEN-045 - Barrel-level name collision
// Tests constrained mixins (mixin X on Y) which require Bird/Eagle/Penguin.
//
// NOTE: This test CANNOT currently run because the types it needs
// (Bird, Eagle, Penguin, Flying, Walking) are excluded from the barrel
// due to a name collision: both mixins/basics and classes/inheritance
// define a class named `Animal`. See GEN-045.
//
// When GEN-045 is fixed (e.g., via import aliasing or name-collision
// detection), uncomment the actual test code below and re-enable the
// corresponding test in d4rt_coverage_test.dart.

// ignore: unused_import
import 'package:d4_example/dart_overview.dart';

void main() {
  // The following code is what this test SHOULD exercise, but can't
  // until GEN-045 is resolved:
  //
  //   var bird = Bird('Sparrow');
  //   assert(bird.name == 'Sparrow');
  //
  //   var eagle = Eagle('Golden Eagle');
  //   eagle.fly(); // "Golden Eagle is flying through the air"
  //
  //   var penguin = Penguin('Emperor');
  //   penguin.walk(); // "Emperor is walking on the ground"
  //
  print('GEN045_BLOCKED: Bird/Eagle/Penguin not in barrel (Animal name collision)');
}
