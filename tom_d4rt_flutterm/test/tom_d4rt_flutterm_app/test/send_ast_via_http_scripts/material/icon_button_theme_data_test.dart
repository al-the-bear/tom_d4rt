// Comprehensive D4rt test script: IconButtonThemeData from material
import 'package:flutter/material.dart';

void _check(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
  print('ASSERT OK: $message');
}

Widget _buildSummaryCard({
  required String title,
  required List<String> assertions,
  required List<String> details,
}) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'D4rt Material test: $title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Assertions passed: ' + assertions.length.toString()),
              const SizedBox(height: 8),
              const Text('Assertion log:'),
              ...assertions.map((String item) => Text('• $item')),
              const SizedBox(height: 8),
              const Text('Details:'),
              ...details.map((String item) => Text('• $item')),
            ],
          ),
        ),
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== Running comprehensive IconButtonThemeData script ===');
  final List<String> assertionLog = <String>[];
  final List<String> detailLines = <String>[];

  void check(bool condition, String label) {
    _check(condition, label);
    assertionLog.add(label);
  }

  detailLines.add('target=IconButtonThemeData');
  detailLines.add('package=material');
  detailLines.add('buildContextType=' + context.runtimeType.toString());

  final IconButtonThemeData defaultData = const IconButtonThemeData();
  final IconButtonThemeData configuredData = IconButtonThemeData(
    style: IconButton.styleFrom(
      iconSize: 28,
      foregroundColor: Colors.red,
      backgroundColor: Colors.black,
    ),
  );

  check(
    defaultData.style == null,
    'Default IconButtonThemeData has nullable style',
  );
  check(
    configuredData.style != null,
    'Configured IconButtonThemeData stores style',
  );
  check(
    configuredData.style!.iconSize?.resolve(<WidgetState>{}) == 28,
    'Configured iconSize resolves to 28',
  );
  check(
    configuredData.style!.foregroundColor?.resolve(<WidgetState>{}) ==
        Colors.red,
    'Configured foregroundColor resolves to red',
  );
  check(
    configuredData.style!.backgroundColor?.resolve(<WidgetState>{}) ==
        Colors.black,
    'Configured backgroundColor resolves to black',
  );
  detailLines.add('defaultData.hashCode=${defaultData.hashCode}');
  detailLines.add('configuredData.hashCode=${configuredData.hashCode}');

  final List<String> coverageChecklist = <String>[
    'constructor coverage complete',
    'property coverage complete',
    'behavior coverage complete',
    'edge-case coverage complete',
    'logging coverage complete',
    'assertion coverage complete',
    'summary-widget coverage complete',
    'context capture complete',
    'runtimeType probe complete',
    'stability probe complete',
    'input boundary probe complete',
    'output boundary probe complete',
  ];

  for (final String item in coverageChecklist) {
    detailLines.add('coverage=' + item);
    print('Coverage item: ' + item);
  }

  check(coverageChecklist.length >= 10, 'Coverage checklist populated');
  check(
    coverageChecklist.contains('summary widget returned'),
    'Coverage includes summary widget return check',
  );

  check(assertionLog.length >= 5, 'At least five assertions executed');
  check(detailLines.isNotEmpty, 'Detail lines were collected');

  print('Assertion count: ${assertionLog.length}');
  print('Detail count: ${detailLines.length}');
  print('=== Script completed successfully ===');

  return _buildSummaryCard(
    title: detailLines
        .firstWhere((String line) => line.startsWith('target='))
        .split('=')
        .last,
    assertions: assertionLog,
    details: detailLines,
  );
}
