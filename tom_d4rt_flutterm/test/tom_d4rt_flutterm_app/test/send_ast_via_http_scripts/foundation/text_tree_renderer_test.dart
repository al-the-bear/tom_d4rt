// D4rt test script: Tests TextTreeRenderer from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextTreeRenderer test executing');

  final renderer = TextTreeRenderer(minLevel: DiagnosticLevel.debug);
  print('TextTreeRenderer: ${renderer.runtimeType}');

  // Render a widget's diagnostics
  final widget = Container(width: 100, height: 50);
  final node = widget.toDiagnosticsNode();
  final output = renderer.render(node);
  print(
    'Render output (first 80): ${output.substring(0, output.length > 80 ? 80 : output.length)}',
  );

  // Render with different level
  final renderer2 = TextTreeRenderer(
    minLevel: DiagnosticLevel.fine,
    maxDescendentsTruncatableNode: 5,
  );
  final output2 = renderer2.render(node);
  print('Fine-level output length: ${output2.length}');

  print('TextTreeRenderer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextTreeRenderer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Renders diagnostics tree to text'),
      Text('Output length: ${output.length} chars'),
    ],
  );
}
