// Small formatting helper used by the calculator entry point.
//
// It lives in a *subfolder* and is imported as `import 'util/format.dart';`
// from `main.dart`. That exercises subfolder-relative imports: the runner loads
// the example folder recursively and the interpreter resolves the import
// against the entry file's `file://` URI, so `util/format.dart` is found.

/// Render [expression] and its [value], dropping a trailing `.0` so whole
/// numbers read cleanly (`6` rather than `6.0`).
String formatResult(String expression, double value) {
  final shown =
      value == value.roundToDouble() ? value.toInt().toString() : '$value';
  return '$expression = $shown';
}
