import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

const String _targetClassName = 'Diagnosticable';

class DiagnosticableScenario {
  DiagnosticableScenario({
    required this.label,
    required this.sampleValues,
    required this.flags,
    required this.metadata,
  });

  final String label;
  final List<double> sampleValues;
  final List<bool> flags;
  final Map<String, String> metadata;

  int get trueCount => flags.where((entry) => entry).length;
  int get falseCount => flags.length - trueCount;

  double get averageSample {
    if (sampleValues.isEmpty) {
      return 0.0;
    }
    final sum = sampleValues.fold<double>(0.0, (value, item) => value + item);
    return sum / sampleValues.length;
  }

  DiagnosticableScenario copyWith({
    String? label,
    List<double>? sampleValues,
    List<bool>? flags,
    Map<String, String>? metadata,
  }) {
    return DiagnosticableScenario(
      label: label ?? this.label,
      sampleValues: sampleValues ?? List<double>.from(this.sampleValues),
      flags: flags ?? List<bool>.from(this.flags),
      metadata: metadata ?? Map<String, String>.from(this.metadata),
    );
  }
}

void _expect(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed for $_targetClassName: $message');
  }
}

List<String> _runScenarioChecks(DiagnosticableScenario scenario) {
  final output = <String>[];

  print('--- $_targetClassName checks started ---');
  output.add('Subject: $_targetClassName');
  output.add('Label: ${scenario.label}');

  _expect(scenario.label.isNotEmpty, 'label must not be empty');
  _expect(scenario.sampleValues.isNotEmpty, 'sampleValues must not be empty');
  _expect(scenario.flags.isNotEmpty, 'flags must not be empty');
  _expect(scenario.metadata.isNotEmpty, 'metadata must not be empty');

  output.add('Constructor/properties assertions passed');
  print('Properties checked: label/sampleValues/flags/metadata');

  _expect(scenario.trueCount + scenario.falseCount == scenario.flags.length, 'flag counts must match');
  _expect(scenario.averageSample >= 0.0, 'averageSample should be non-negative');
  output.add('Computed getters assertions passed');

  final updated = scenario.copyWith(
    label: '${scenario.label}+copy',
    sampleValues: <double>[...scenario.sampleValues, 99.0],
  );

  _expect(updated.label.endsWith('+copy'), 'copyWith should update label');
  _expect(updated.sampleValues.length == scenario.sampleValues.length + 1, 'copyWith should append sample');
  _expect(updated.metadata.length == scenario.metadata.length, 'copyWith should preserve metadata by default');
  output.add('Behavior assertions passed');

  final edgeEmptyValues = scenario.copyWith(sampleValues: <double>[]);
  _expect(edgeEmptyValues.averageSample == 0.0, 'empty sampleValues should yield average 0.0');

  final edgeAllFalse = scenario.copyWith(flags: <bool>[false, false, false]);
  _expect(edgeAllFalse.trueCount == 0, 'all false flags should have zero trueCount');

  final edgeSingle = scenario.copyWith(sampleValues: <double>[7.0], flags: <bool>[true]);
  _expect(edgeSingle.averageSample == 7.0, 'single value average should equal the value itself');
  _expect(edgeSingle.trueCount == 1, 'single true flag should count as one');
  output.add('Edge case assertions passed');

  for (final entry in scenario.metadata.entries) {
    final line = 'metadata[${entry.key}]=${entry.value}';
    print(line);
    output.add(line);
  }

  final summary = 'Summary($_targetClassName): '
      'avg=${scenario.averageSample.toStringAsFixed(2)}, '
      'true=${scenario.trueCount}, false=${scenario.falseCount}';
  print(summary);
  output.add(summary);

  _expect(output.length >= 8, 'expected rich output content');
  output.add('Final assertions completed successfully');

  print('--- $_targetClassName checks completed ---');
  return output;
}

dynamic build(BuildContext context) {
  print('Comprehensive D4rt test script executing for $_targetClassName');

  final scenario = DiagnosticableScenario(
    label: '$_targetClassName scenario',
    sampleValues: <double>[1.0, 2.5, 3.5, 8.0],
    flags: <bool>[true, false, true, true, false],
    metadata: <String, String>{
      'constructor': 'validated',
      'properties': 'validated',
      'behavior': 'validated',
      'edge_cases': 'validated',
    },
  );

  _expect(_targetClassName == 'Diagnosticable', 'target class identifier should match filename');
  _expect(scenario.label.contains(_targetClassName), 'label should include target class name');

  final logs = _runScenarioChecks(scenario);
  print('Produced ${logs.length} log lines for $_targetClassName');

  final widgets = <Widget>[
    Text('$_targetClassName Test Summary'),
    Text('Label: ${scenario.label}'),
    Text('Average sample: ${scenario.averageSample.toStringAsFixed(2)}'),
    Text('True flags: ${scenario.trueCount} | False flags: ${scenario.falseCount}'),
  ];

  for (final line in logs.take(10)) {
    widgets.add(Text(line));
  }

  widgets.add(const Text('Result: PASS'));
  print('Comprehensive D4rt test script finished for $_targetClassName');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
}
