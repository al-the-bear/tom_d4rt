// GENERATED — regenerate with:
//   dart run tool/stdlib_member_diff.dart --hierarchy --baseline
//
// The standing SUPERTYPE-EDGE baseline for the `dart:*` stdlib bridges, read by
// `hierarchy_baseline_test.dart`. Do not hand-edit: a hand-edited entry is an
// assertion about the interpreter that nothing measured.
//
// A missing edge is the more expensive of the two defects this tool finds. It
// costs the whole inherited surface at once rather than one member, and it makes
// `is` and `on` answer wrongly — `LinkedList` went from 27 unreachable members
// to 2 when one edge was declared. The member baseline DOES catch a deleted
// edge, but reports it as N unrelated member regressions; this one names the
// edge.
//
// Current state: 0 confirmed missing edges across 0 classes,
// 1 edges on 1 classes missing by decision,
// and 0 edges on 0 classes that cannot be measured at all.
// Those totals are documentation, not assertions — the test derives them from the
// tables below, so there is only ever one thing to update.

/// Edges proven absent through the interpreter (`o is T` answered false).
const confirmedEdges = <String, List<String>>{};

/// Edges deliberately not declared — see `_declinedEdges` in the tool.
const declinedEdges = <String, List<String>>{
  'HttpClientResponseCompressionState': [r'Enum'],
};

/// Edges no probe could measure.
///
/// Pinned for the reason SCC13 learned the hard way on the member side: without
/// it, `unverified -> confirmed` is indistinguishable from
/// `reachable -> confirmed`, so adding an instance recipe would read as a wave
/// of fresh regressions rather than as new information.
const unmeasurableEdges = <String, List<String>>{};

/// Classes whose instance recipe yielded an instance when this was taken.
///
/// The floor under the tolerance above: a recipe that stops working turns every
/// one of its class's edges UNVERIFIED, and an unverified edge is not asserted
/// about. Without pinning which classes COULD be measured, the guard can go
/// dark and still report success.
const measuredEdgeClasses = <String>{
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
  'HttpClientRequest',
  'HttpClientResponse',
  'HttpClientResponseCompressionState',
  'HttpHeaders',
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
