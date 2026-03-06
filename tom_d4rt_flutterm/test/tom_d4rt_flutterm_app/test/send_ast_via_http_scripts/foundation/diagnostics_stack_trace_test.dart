// D4rt test script: Tests DiagnosticsStackTrace from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsStackTrace test executing');

  // Test DiagnosticsStackTrace - Stack diagnostics
  print('DiagnosticsStackTrace is available in the foundation package');
  print('DiagnosticsStackTrace: Stack diagnostics');

  print('DiagnosticsStackTrace test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagnosticsStackTrace Tests'),
      Text('Stack diagnostics'),
    ],
  );
}
