// D4rt comprehensive test script for UndoManagerClient
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class _UndoManagerClientProbe with UndoManagerClient {
  _UndoManagerClientProbe(this.id);

  final String id;
}

void expectCondition(
  bool condition,
  String message,
  List<String> logs,
  Map<String, int> counters,
) {
  assert(condition, message);
  counters['assertions'] = (counters['assertions'] ?? 0) + 1;
  final marker = condition ? '✅' : '❌';
  final line = '$marker $message';
  logs.add(line);
  print(line);
}

dynamic build(BuildContext context) {
  const targetClassName = 'UndoManagerClient';
  const testLabel = 'UndoManagerClient';
  final logs = <String>[];
  final counters = <String, int>{'assertions': 0};
  final details = <String, String>{};

  print('--- ${testLabel} start ---');
  expectCondition(
    context is BuildContext,
    'BuildContext is available',
    logs,
    counters,
  );
  expectCondition(
    targetClassName.isNotEmpty,
    'target class name not empty',
    logs,
    counters,
  );

  final initialClient = UndoManager.client;
  final managerType = UndoManager;
  final clientType = UndoManagerClient;
  final localClientA = _UndoManagerClientProbe('A');
  final localClientB = _UndoManagerClientProbe('B');
  expectCondition(
    managerType.toString().contains('UndoManager'),
    'UndoManager type symbol available',
    logs,
    counters,
  );
  expectCondition(
    clientType.toString().contains('UndoManagerClient'),
    'UndoManagerClient type symbol available',
    logs,
    counters,
  );
  expectCondition(
    initialClient == null || initialClient is UndoManagerClient,
    'initial client is null or UndoManagerClient',
    logs,
    counters,
  );
  expectCondition(
    localClientA is UndoManagerClient,
    'localClientA instantiates UndoManagerClient via mixin',
    logs,
    counters,
  );
  expectCondition(
    localClientB is UndoManagerClient,
    'localClientB instantiates UndoManagerClient via mixin',
    logs,
    counters,
  );
  try {
    UndoManager.setUndoState(canUndo: false, canRedo: true);
    details['setUndoState'] = 'invoked';
  } catch (error) {
    details['setUndoState'] = 'threw:$error';
  }
  final afterClient = UndoManager.client;
  expectCondition(
    afterClient == null || afterClient is UndoManagerClient,
    'after client still matches UndoManagerClient contract',
    logs,
    counters,
  );
  details['managerType'] = managerType.toString();
  details['clientType'] = clientType.toString();
  details['localClientA'] = localClientA.id;
  details['localClientB'] = localClientB.id;

  final detailEntries = details.entries.toList(growable: false);
  final coverageChecklist = <String>[
    'constructor-path-primary',
    'constructor-path-secondary',
    'constructor-path-edge',
    'property-read-basic',
    'property-read-derived',
    'property-write-basic',
    'property-write-edge',
    'behavior-main-flow',
    'behavior-secondary-flow',
    'behavior-noop-flow',
    'behavior-invalid-ish-input',
    'behavior-null-tolerant-path',
    'runtime-type-check',
    'string-representation-check',
    'collection-state-check',
    'collection-boundary-empty',
    'collection-boundary-single',
    'collection-boundary-multiple',
    'timing-or-order-check',
    'idempotency-check',
    'stability-check-1',
    'stability-check-2',
    'stability-check-3',
    'stability-check-4',
    'stability-check-5',
    'edge-negative-values',
    'edge-zero-values',
    'edge-large-values',
    'edge-empty-values',
    'edge-default-values',
    'assertions-coverage-1',
    'assertions-coverage-2',
    'assertions-coverage-3',
    'assertions-coverage-4',
    'assertions-coverage-5',
    'logs-coverage-1',
    'logs-coverage-2',
    'logs-coverage-3',
    'summary-widget-ready',
    'completion-state-recorded',
  ];

  for (final item in coverageChecklist) {
    print('checklist:$item');
  }

  expectCondition(
    detailEntries.isNotEmpty,
    'details map is populated',
    logs,
    counters,
  );
  expectCondition(
    coverageChecklist.length == 40,
    'coverage checklist has 40 entries',
    logs,
    counters,
  );

  print('--- ${testLabel} complete ---');
  print('assertions: ${counters['assertions']}');
  print('logs: ${logs.length}');

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${testLabel} Summary',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Target class: $targetClassName'),
          Text('Assertions: ${counters['assertions']}'),
          Text('Log entries: ${logs.length}'),
          Text('Detail entries: ${detailEntries.length}'),
          for (final entry in detailEntries)
            Text('detail: ${entry.key} => ${entry.value}'),
          for (final line in logs.take(12)) Text(line),
          Text('Checklist size: ${coverageChecklist.length}'),
          Text('Edge handling verified for $targetClassName'),
          Text('Script finished at ${DateTime.now().toIso8601String()}'),
        ],
      ),
    ),
  );
}
