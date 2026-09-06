// GENERATED — regenerate with:
//   dart run tool/stdlib_member_diff.dart --baseline
//
// The standing member-coverage baseline for the `dart:*` stdlib bridges, read by
// `member_coverage_baseline_test.dart`. Do not hand-edit: a hand-edited entry is
// an assertion about the interpreter that nothing measured, which is exactly the
// claim this baseline was introduced to stop anyone making.
//
// Current state: 0 confirmed-unreachable members across 0 classes,
// 5 members on 2 classes unreachable by decision,
// and 73 members on 4 classes that cannot be measured at all.
// Those totals are documentation, not assertions — the test derives them from the
// tables below, so there is only ever one thing to update.
//
// Regenerating is a normal part of closing a gap and a normal part of adding an
// instance recipe. It is NOT a normal part of making a red suite green: if
// `no previously-reachable member became unreachable` is the test that failed,
// regenerating hides a live defect.

/// Members proven unreachable through the interpreter, per bridged class.
const confirmedGaps = <String, List<String>>{};

/// Members unreachable BY DECISION, per bridged class. Each carries its reason
/// in `_declined` in the tool.
///
/// Separate from [confirmedGaps] because the two make different claims. A
/// confirmed gap is work not yet done and the guard wants that list to shrink;
/// a declined member is a boundary that was chosen, and shrinking it would mean
/// reversing a decision rather than fixing a defect.
const declinedMembers = <String, List<String>>{
  'ByteBuffer': [r'asFloat32x4List', r'asFloat64x2List', r'asInt32x4List'],
  'RawSocket': [r'readMessage', r'sendMessage'],
};

/// Candidates that could not be measured, per bridged class. Each of these has a
/// stated reason in `_notAuditable` in the tool; they are pinned so that a member
/// moving out of this bucket is reported as the new information it is, rather
/// than as a fresh defect.
const unmeasurable = <String, List<String>>{
  'HttpClientRequest': [r'writeCharCode'],
  'HttpClientResponse': [
    r'any',
    r'asBroadcastStream',
    r'asyncExpand',
    r'asyncMap',
    r'cast',
    r'contains',
    r'distinct',
    r'drain',
    r'elementAt',
    r'every',
    r'expand',
    r'first',
    r'firstWhere',
    r'fold',
    r'forEach',
    r'handleError',
    r'isBroadcast',
    r'isEmpty',
    r'join',
    r'last',
    r'lastWhere',
    r'length',
    r'map',
    r'pipe',
    r'reduce',
    r'single',
    r'singleWhere',
    r'skip',
    r'skipWhile',
    r'take',
    r'takeWhile',
    r'timeout',
    r'toList',
    r'toSet',
    r'where',
  ],
  'HttpHeaders': [r'[]'],
  'Stdin': [
    r'any',
    r'asBroadcastStream',
    r'asyncExpand',
    r'asyncMap',
    r'cast',
    r'contains',
    r'distinct',
    r'drain',
    r'elementAt',
    r'every',
    r'expand',
    r'first',
    r'firstWhere',
    r'fold',
    r'forEach',
    r'handleError',
    r'isBroadcast',
    r'isEmpty',
    r'join',
    r'last',
    r'lastWhere',
    r'length',
    r'map',
    r'pipe',
    r'reduce',
    r'single',
    r'singleWhere',
    r'skip',
    r'skipWhile',
    r'take',
    r'takeWhile',
    r'timeout',
    r'toList',
    r'toSet',
    r'transform',
    r'where',
  ],
};

/// Classes carrying unmeasured members with NO stated reason — i.e. a bridged
/// class nobody has written an instance recipe for yet.
///
/// Pinned at empty on purpose. Three classes (`HttpRequest`, `WebSocket`,
/// `WebSocketTransformer`) sat here for a whole release cycle with 73 members
/// between them: they were bridged, no recipe followed, and the audit simply
/// stopped seeing that surface. Nothing failed, because the old baseline folded
/// them in with the classes that have a stated reason. Measuring them found a
/// real gap on the first run.
const unfinishedClasses = <String>{};

/// Classes whose instance recipe produced a usable instance when the baseline was
/// taken. A class dropping out of this list means its gaps stopped being
/// measured, which the test reports as a failure rather than as a pass.
const measuredClasses = <String>{
  'AsciiCodec',
  'BigInt',
  'ByteBuffer',
  'ByteData',
  'ContentType',
  'Converter',
  'DateTime',
  'Directory',
  'DoubleLinkedQueue',
  'Duration',
  'Encoding',
  'File',
  'FileSystemEntityType',
  'Float32List',
  'Float64List',
  'HashMap',
  'HashSet',
  'HtmlEscape',
  'HtmlEscapeMode',
  'HttpClient',
  'HttpRequest',
  'HttpServer',
  'IOSink',
  'Int16List',
  'Int32List',
  'Int64List',
  'Int8List',
  'InternetAddress',
  'InternetAddressType',
  'Iterable',
  'JsonDecoder',
  'JsonEncoder',
  'Latin1Codec',
  'LineSplitter',
  'LinkedHashMap',
  'LinkedHashSet',
  'LinkedList',
  'LinkedListEntry',
  'List',
  'ListQueue',
  'OSError',
  'Object',
  'Point',
  'ProcessSignal',
  'ProcessStartMode',
  'Queue',
  'RawDatagramSocket',
  'RawServerSocket',
  'RawSocket',
  'RawSocketEvent',
  'ReceivePort',
  'Rectangle',
  'RegExp',
  'RegExpMatch',
  'RemoteError',
  'Runes',
  'SendPort',
  'ServerSocket',
  'Set',
  'Socket',
  'SplayTreeMap',
  'SplayTreeSet',
  'StdioType',
  'Stdout',
  'StreamController',
  'StreamSubscription',
  'StreamTransformerBase',
  'StreamView',
  'String',
  'StringBuffer',
  'StringConversionSink',
  'Symbol',
  'Uint16List',
  'Uint32List',
  'Uint64List',
  'Uint8ClampedList',
  'Uint8List',
  'UnmodifiableListView',
  'UnmodifiableMapView',
  'Uri',
  'UriData',
  'Utf8Codec',
  'WebSocket',
  'WebSocketTransformer',
  'bool',
  'double',
  'int',
  'num',
};
