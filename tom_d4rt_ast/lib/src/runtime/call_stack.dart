/// The interpreted call stack, and the trace an error leaves on its way out.
///
/// A script that throws three calls deep used to reach the host with the
/// *interpreter's* Dart trace — frames of the visitor, not of the script — and
/// no position at all. This keeps the script's own stack: which interpreted
/// functions were active, and which statement each was executing. The first
/// time an error escapes an interpreted call, the stack is snapshotted against
/// that error, innermost first; the host reads it back with [traceOf].
///
/// AST-agnostic on purpose: a statement is held as an `Object` and turned into
/// a position by a locator the front end supplies, so this file is the same in
/// both interpreters and neither needs the other's AST.
library;

/// One frame of an interpreted call stack.
class D4rtStackFrame {
  /// The interpreted function this frame is executing, as declared.
  final String member;

  /// 1-based line of the statement the frame was executing.
  final int line;

  /// 1-based column of that statement.
  final int column;

  /// The library the statement is in, or null when the front end does not name
  /// it (`tom_d4rt` leaves its main source unnamed).
  final Uri? source;

  const D4rtStackFrame({
    required this.member,
    required this.line,
    required this.column,
    this.source,
  });

  @override
  String toString() => '$member (${source ?? '<main>'}:$line:$column)';
}

/// Where a statement is: its line and column, and the library it is in.
typedef D4rtFrameLocator =
    ({int line, int column, Uri? source})? Function(Object statement);

/// The stack itself, one per run.
///
/// Two parallel lists rather than a list of frame objects, because [enter]
/// runs on every interpreted call and the frame object is only worth building
/// when an error actually escapes.
class D4rtCallStack {
  D4rtCallStack(this._locate);

  final D4rtFrameLocator _locate;
  final List<String> _members = [];
  final List<Object?> _callSites = [];

  /// The statement the innermost frame is executing. Set by the interpreter
  /// before each statement; restored to the call site when a call returns.
  Object? current;

  /// How deep the interpreted stack is.
  int get depth => _members.length;

  /// A call to [member] begins; the caller is at [current].
  void enter(String member) {
    _members.add(member);
    _callSites.add(current);
  }

  /// The innermost call ends, normally or not; the caller resumes at the
  /// statement that made it.
  void exit() {
    _members.removeLast();
    current = _callSites.removeLast();
  }

  /// [error] is leaving the innermost call. The first call it leaves is the
  /// one that knows where it was raised, so only that one records.
  ///
  /// A value an `Expando` cannot hold — a string, a number, a boolean, null —
  /// gets no trace: the interpreter wraps a script's own `throw` in an object,
  /// so this is only ever a host value thrown natively.
  void recordEscape(Object? error) {
    if (error == null || error is String || error is num || error is bool) {
      return;
    }
    if (_traces[error] != null) return;
    _traces[error] = _snapshot();
  }

  List<D4rtStackFrame> _snapshot() {
    final frames = <D4rtStackFrame>[];
    for (var i = _members.length - 1; i >= 0; i--) {
      final at = i == _members.length - 1 ? current : _callSites[i + 1];
      if (at == null) continue;
      final where = _locate(at);
      if (where == null) continue;
      frames.add(
        D4rtStackFrame(
          member: _members[i],
          line: where.line,
          column: where.column,
          source: where.source,
        ),
      );
    }
    return List.unmodifiable(frames);
  }

  static final Expando<List<D4rtStackFrame>> _traces = Expando(
    'd4rt interpreted trace',
  );

  /// The interpreted frames [error] left, innermost first — empty when it
  /// left none (raised outside any interpreted call, or a value no trace can
  /// be attached to).
  static List<D4rtStackFrame> traceOf(Object? error) {
    if (error == null || error is String || error is num || error is bool) {
      return const [];
    }
    return _traces[error] ?? const [];
  }
}
