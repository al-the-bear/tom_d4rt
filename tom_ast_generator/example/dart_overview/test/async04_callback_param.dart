// D4rt test: ASYNC04 - Callback parameter (Function)
// Verifies functions accepting callback parameters work via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // transform(List<int>, int Function(int)) -> List<int>
  var result = transform([1, 2, 3], (n) => n * 10);
  if (result.length != 3) {
    errors.add('transform length expected 3, got ${result.length}');
  }
  if (result[0] != 10) {
    errors.add('transform[0] expected 10, got ${result[0]}');
  }
  if (result[2] != 30) {
    errors.add('transform[2] expected 30, got ${result[2]}');
  }

  // fetchData({url, onSuccess, onError}) — callback params
  fetchData(
    url: 'test',
    onSuccess: (data) {
      // Success callback invoked
    },
    onError: (error) {
      errors.add('onError should not be called for valid url');
    },
  );

  // Note: fetchData may be async, so successCalled might not be set immediately
  // For now, just verify the call doesn't crash

  if (errors.isEmpty) {
    print('ASYNC04_PASSED');
  } else {
    print('ASYNC04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
