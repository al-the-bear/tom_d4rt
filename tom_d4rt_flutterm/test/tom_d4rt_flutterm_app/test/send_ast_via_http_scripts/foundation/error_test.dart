// D4rt test script: Tests FlutterError, FlutterErrorDetails, ErrorDescription, ErrorHint, ErrorSummary from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation error test executing');

  // ========== FLUTTERERROR ==========
  print('--- FlutterError Tests ---');

  final error = FlutterError('Test error message');
  print('FlutterError created: $error');
  print('FlutterError message: ${error.message}');
  print('FlutterError runtimeType: ${error.runtimeType}');
  print('FlutterError diagnostics count: ${error.diagnostics.length}');

  // FlutterError with multiple diagnostics
  final complexError = FlutterError.fromParts([
    ErrorSummary('A render error occurred'),
    ErrorDescription('The widget failed to render properly.'),
    ErrorHint('Try checking the widget constraints.'),
  ]);
  print('Complex FlutterError created');
  print('  diagnostics: ${complexError.diagnostics.length} parts');
  for (final diag in complexError.diagnostics) {
    print('  - ${diag.runtimeType}: ${diag.toStringDeep()}');
  }

  // ========== FLUTTERERRORDETAILS ==========
  print('--- FlutterErrorDetails Tests ---');

  final details = FlutterErrorDetails(
    exception: 'Test exception string',
    library: 'test library',
    context: ErrorDescription('during test execution'),
  );
  print('FlutterErrorDetails created');
  print('  exception: ${details.exception}');
  print('  library: ${details.library}');
  print('  context: ${details.context}');
  print('  runtimeType: ${details.runtimeType}');

  // FlutterErrorDetails with stack trace
  final detailsWithStack = FlutterErrorDetails(
    exception: Exception('something went wrong'),
    library: 'widgets library',
    context: ErrorDescription('while building MyWidget'),
    silent: false,
  );
  print('FlutterErrorDetails with exception:');
  print('  exception: ${detailsWithStack.exception}');
  print('  library: ${detailsWithStack.library}');
  print('  silent: ${detailsWithStack.silent}');

  // FlutterErrorDetails with informationCollector
  final detailsWithInfo = FlutterErrorDetails(
    exception: 'Detailed error',
    library: 'rendering library',
    context: ErrorDescription('during layout'),
    informationCollector: () => [
      ErrorDescription('Additional info line 1'),
      ErrorHint('Maybe try a different approach'),
    ],
  );
  print('FlutterErrorDetails with informationCollector:');
  print('  exception: ${detailsWithInfo.exception}');
  print('  context: ${detailsWithInfo.context}');

  // ========== ERRORDESCRIPTION ==========
  print('--- ErrorDescription Tests ---');

  final desc = ErrorDescription('This describes the error context');
  print('ErrorDescription: $desc');
  print('  runtimeType: ${desc.runtimeType}');
  print('  toString: ${desc.toString()}');
  print('  toStringDeep: ${desc.toStringDeep()}');

  // Multiple ErrorDescriptions
  final desc1 = ErrorDescription('First description line');
  final desc2 = ErrorDescription('Second description line');
  print('Multiple descriptions: $desc1, $desc2');

  // ========== ERRORHINT ==========
  print('--- ErrorHint Tests ---');

  final hint = ErrorHint('Try using a ConstrainedBox to limit size');
  print('ErrorHint: $hint');
  print('  runtimeType: ${hint.runtimeType}');
  print('  toString: ${hint.toString()}');

  final hint2 = ErrorHint(
    'Consider wrapping your widget in a SizedBox with specific dimensions.',
  );
  print('ErrorHint 2: $hint2');

  // ========== ERRORSUMMARY ==========
  print('--- ErrorSummary Tests ---');

  final summary = ErrorSummary('RenderBox was not laid out');
  print('ErrorSummary: $summary');
  print('  runtimeType: ${summary.runtimeType}');
  print('  toString: ${summary.toString()}');

  final summary2 = ErrorSummary('A RenderFlex overflowed by 42 pixels');
  print('ErrorSummary 2: $summary2');

  // ========== COMBINED ERROR CONSTRUCTION ==========
  print('--- Combined Error Tests ---');

  final fullError = FlutterError.fromParts([
    ErrorSummary('Widget rendering failed'),
    ErrorDescription('The Container widget could not be laid out.'),
    ErrorDescription('It was given infinite constraints.'),
    ErrorHint(
      'Consider using a SizedBox or ConstrainedBox to provide finite constraints.',
    ),
    ErrorHint(
      'See also: https://flutter.dev/docs/development/ui/layout/constraints',
    ),
  ]);
  print('Full combined error:');
  print('  message: ${fullError.message}');
  print('  diagnostics count: ${fullError.diagnostics.length}');
  for (int i = 0; i < fullError.diagnostics.length; i++) {
    print(
      '  [$i] ${fullError.diagnostics[i].runtimeType}: ${fullError.diagnostics[i]}',
    );
  }

  // Test FlutterError.defaultStackFilter behavior
  print('FlutterError.presentError is available');

  // ========== RETURN WIDGET ==========
  print('Foundation error test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foundation Error Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• FlutterError - error with diagnostics'),
          Text('• FlutterErrorDetails - detailed error info'),
          Text('• ErrorDescription - describes error context'),
          Text('• ErrorHint - provides suggested fixes'),
          Text('• ErrorSummary - one-line error summary'),
          SizedBox(height: 16.0),

          Text(
            'Error Construction:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• FlutterError("message") - simple'),
          Text('• FlutterError.fromParts([...]) - complex'),
          Text('• FlutterErrorDetails(exception:...) - full details'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFFEBEE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sample Error:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F),
                  ),
                ),
                Text('Summary: ${summary.toString()}'),
                Text('Description: ${desc.toString()}'),
                Text('Hint: ${hint.toString()}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
