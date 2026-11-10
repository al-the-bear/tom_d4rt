/// The scripting-API bridges and tom_todo_model 2.x: a script reads and
/// builds repeated todos (`waiting-for-repeat`, `repeat`, `next_repeat`,
/// `repeat_count`) through the bridged `TomTodo`, `TomTodoRepeat` and
/// `TomTodoRepeatRule` — a todo file holding one was refused by the 1.x
/// model.
library;

import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'package:tom_d4rt_dcli/dartscript.b.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';

void main() {
  late Directory tempDir;
  late D4rtCliController controller;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('todo_model_bridges_');
    final d4rt = D4rt()..grant(FilesystemPermission.any);
    TomD4rtDcliBridge.register(d4rt);
    controller = D4rtCliController(
      d4rt: d4rt,
      state: CliState(
        dataDirectory: tempDir.path,
        initialDirectory: tempDir.path,
      ),
      toolName: 'Test',
    );
  });

  tearDown(() {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  Future<List<String>> run(String code) async {
    final lines = <String>[];
    final result = await runZoned(
      () => controller.execute('''
import 'package:tom_vscode_scripting_api/script_globals.dart';

$code
'''),
      zoneSpecification: ZoneSpecification(
        print: (_, _, _, line) => lines.add(line),
      ),
    );
    if (!result.success) fail('Execution failed: ${result.error}');
    return lines;
  }

  test('TMB-1: a script reads a repeated todo from its map', () async {
    final lines = await run('''
void main() {
  final todo = TomTodo.fromMap({
    'id': 'R1',
    'title': 'Rotate the key',
    'status': 'waiting-for-repeat',
    'repeat': {'rule': 'weekly', 'weekdays': ['fri'], 'time': '10:00'},
    'next_repeat': '2026-11-13T10:00+01:00',
    'repeat_count': 2,
  });
  print(todo.status == TomTodoStatus.waitingForRepeat);
  print(todo.repeat!.rule == TomTodoRepeatRule.weekly);
  print(todo.repeat!.weekdays.join(','));
  print(todo.nextRepeat);
  print(todo.repeatCount);
}
''');
    expect(lines, ['true', 'true', 'fri', '2026-11-13T10:00+01:00', '2']);
  });

  test('TMB-2: a script builds one and writes its map', () async {
    final lines = await run('''
void main() {
  final todo = TomTodo(id: 'R2', title: 'Water the plants')
    ..status = TomTodoStatus.waitingForRepeat
    ..repeat = TomTodoRepeat(rule: TomTodoRepeatRule.daily, every: 2)
    ..repeatCount = 1;
  final map = todo.toMap();
  print(map['status']);
  print((map['repeat'] as Map)['rule']);
  print((map['repeat'] as Map)['every']);
  print(map['repeat_count']);
}
''');
    expect(lines, ['waiting-for-repeat', 'daily', '2', '1']);
  });
}
