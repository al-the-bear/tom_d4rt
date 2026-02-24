// D4rt test: ASYNC08 - Static sync*/async* methods
// Verifies that static generator methods on classes are correctly bridged.
import 'package:d4_example/dart_overview.dart';

void main() async {
  var errors = <String>[];

  // ── Test static sync* method ─────────────────────────────────────

  var rangeItems = DataProcessor.staticRange(5).toList();
  if (rangeItems.length != 5) {
    errors.add('staticRange(5) expected 5 items, got ${rangeItems.length}');
  }
  if (rangeItems.isNotEmpty && rangeItems[0] != 1) {
    errors.add('staticRange first expected 1, got ${rangeItems[0]}');
  }
  if (rangeItems.length >= 5 && rangeItems[4] != 5) {
    errors.add('staticRange last expected 5, got ${rangeItems[4]}');
  }

  // ── Test static async* method ────────────────────────────────────

  var countdown = <int>[];
  await for (var n in DataProcessor.staticCountdown(3)) {
    countdown.add(n);
  }

  if (countdown.length != 4) {
    errors.add('staticCountdown(3) expected 4 items (3,2,1,0), got ${countdown.length}');
  }
  if (countdown.isNotEmpty && countdown[0] != 3) {
    errors.add('staticCountdown first expected 3, got ${countdown[0]}');
  }
  if (countdown.length >= 4 && countdown[3] != 0) {
    errors.add('staticCountdown last expected 0, got ${countdown[3]}');
  }

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('ASYNC08_PASSED');
  } else {
    print('ASYNC08_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
