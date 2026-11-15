/// Stdio capture with `dart:io`: a script's `stdout` / `stderr` writes go to
/// the run's [D4rtOutput] sinks through [IOOverrides] in the run's Zone.
///
/// This file is mirrored between `tom_d4rt` (lib/src/) and `tom_d4rt_ast`
/// (lib/src/runtime/); keep the two identical.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Forks a Zone from [zone] whose `stdout` / `stderr` write to [out] /
/// [err] (and, with [echo], to the process's streams as well).
Zone forkStdioCapture(
  Zone zone, {
  required void Function(String text) out,
  required void Function(String text) err,
  required bool echo,
}) {
  final realOut = stdout;
  final realErr = stderr;
  return zone.run(
    () => IOOverrides.runZoned(
      () => Zone.current,
      stdout: () => _CapturedStdout(out, echo ? realOut : null, realOut),
      stderr: () => _CapturedStdout(err, echo ? realErr : null, realErr),
    ),
  );
}

/// A [Stdout] whose writes go to a sink.
class _CapturedStdout implements Stdout {
  _CapturedStdout(this._sink, this._echo, this._real);

  final void Function(String text) _sink;
  final Stdout? _echo;
  final Stdout _real;

  @override
  Encoding encoding = utf8;

  @override
  String lineTerminator = '\n';

  void _emit(String text) {
    _sink(text);
    _echo?.write(text);
  }

  @override
  void write(Object? object) => _emit('$object');

  @override
  void writeln([Object? object = '']) => _emit('$object$lineTerminator');

  @override
  void writeAll(Iterable<Object?> objects, [String separator = '']) =>
      _emit(objects.join(separator));

  @override
  void writeCharCode(int charCode) => _emit(String.fromCharCode(charCode));

  @override
  void add(List<int> data) => _emit(encoding.decode(data));

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      _real.addError(error, stackTrace);

  @override
  Future<void> addStream(Stream<List<int>> stream) => stream.forEach(add);

  @override
  Future<void> flush() => Future<void>.value();

  @override
  Future<void> close() => Future<void>.value();

  @override
  Future<void> get done => _real.done;

  @override
  bool get hasTerminal => false;

  @override
  int get terminalColumns => _real.terminalColumns;

  @override
  int get terminalLines => _real.terminalLines;

  @override
  bool get supportsAnsiEscapes => false;

  @override
  IOSink get nonBlocking => this;
}
