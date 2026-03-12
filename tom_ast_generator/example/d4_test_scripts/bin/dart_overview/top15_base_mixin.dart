// D4rt test: TOP15 - Base mixin
// Verifies base mixin usage via bridges.
// Base mixins restrict mixing to the same library.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // TrackedItem uses `base mixin Trackable`
  var item = TrackedItem('Widget');

  if (item.trackCount != 0) {
    errors.add('TrackedItem initial trackCount expected 0, got ${item.trackCount}');
  }

  item.track();
  item.track();
  item.track();

  if (item.trackCount != 3) {
    errors.add('TrackedItem after 3 tracks expected 3, got ${item.trackCount}');
  }

  if (item.name != 'Widget') {
    errors.add('TrackedItem.name expected "Widget", got "${item.name}"');
  }

  if (errors.isEmpty) {
    print('TOP15_PASSED');
  } else {
    print('TOP15_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
