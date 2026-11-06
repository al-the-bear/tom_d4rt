// An async bridge over the request channel: the script awaits a value only the
// host has, and catches the host's refusal like any exception.
//
//   dart run example/async_request_example.dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_host/tom_d4rt_host.dart';

/// The application's side inside the worker.
class NotesDelegate extends D4rtWorkerDelegate<Object?> {
  D4rtWorkerRun? _run;

  @override
  void begin(D4rtWorkerRun run) => _run = run;

  @override
  Object? interpreterKey(D4rtWorkerRun run) => 'notes';

  @override
  void furnish(D4rt interpreter, Object? key) {
    // The bridge returns the request's Future; the script awaits the answer.
    interpreter.registertopLevelFunction(
      'loadNote',
      (visitor, args, named, types) => _run!.request('note.load', args.single),
      'package:notes/notes.dart',
    );
  }

  @override
  void end(D4rtWorkerRun run) => _run = null;
}

/// Built inside the worker isolate, so it must be top-level.
D4rtWorkerDelegate<Object?> notesDelegate() => NotesDelegate();

const script = '''
import 'package:notes/notes.dart';
import 'package:tom_d4rt_host/tom_d4rt_host.dart';

Future<int> main() async {
  final first = await loadNote(1);
  print('note 1: \${first['title']}');
  try {
    await loadNote(99);
  } on D4rtHostException catch (e) {
    print('note 99: \${e.message}');
  }
  return (first['title'] as String).length;
}
''';

/// The host's store, out of the worker's reach.
const notes = {
  1: {'title': 'Write the README'},
};

Future<void> main() async {
  final host = D4rtHost(notesDelegate, debugName: 'notes-scripts');
  try {
    final outcome = await host.run(
      const D4rtRunRequest(
        runId: 'run-1',
        source: script,
        sourceHash: 'notes-script-1',
      ),
      deadline: const Duration(seconds: 10),
      // Answers in the caller's zone; a Future is awaited before replying.
      onRequest: (request) async {
        final id = request.data! as int;
        await Future<void>.delayed(const Duration(milliseconds: 5));
        return notes[id] ?? (throw StateError('no note $id'));
      },
    );
    print('status: ${outcome.status.name}, value: ${outcome.value}');
    for (final line in outcome.transcript.lines) {
      print('script: ${line.text}');
    }
  } finally {
    await host.dispose();
  }
}
