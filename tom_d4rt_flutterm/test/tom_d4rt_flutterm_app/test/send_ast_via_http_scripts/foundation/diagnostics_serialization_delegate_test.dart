// D4rt test script: Tests DiagnosticsSerializationDelegate from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsSerializationDelegate test executing');

  // Test DiagnosticsSerializationDelegate - DiagnosticsSerializationDelegate
  print('DiagnosticsSerializationDelegate is available in the foundation package');
  print('DiagnosticsSerializationDelegate: DiagnosticsSerializationDelegate');

  print('DiagnosticsSerializationDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagnosticsSerializationDelegate Tests'),
      Text('DiagnosticsSerializationDelegate'),
    ],
  );
}
