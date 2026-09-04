// SCB30: `Zone.current` and `Zoen.current` used to fail identically —
// `Undefined variable: Zone` / `Undefined variable: Zoen` — so the message
// carried no signal that one of them is a decision and the other is a typo.
// A reader could only learn the difference by guessing that a limitations doc
// existed and grepping it.
//
// This map closes that gap at the point of failure: when the undefined name is
// one the stdlib deliberately does not bridge, the message continues with the
// reason and a pointer to the section that holds the full argument.
//
// The prefix `Undefined variable: <name>` is deliberately unchanged. It is what
// doc/d4rt_limitations.md tells readers to search for, what the SC11 test files
// match on with `contains`, and what interpreter_visitor.dart's
// extension-resolution path inspects. The reason is strictly a suffix.
//
// KEEPING THIS HONEST: the keys must be exactly the identifiers listed in the
// "Reported as" columns of doc/d4rt_limitations.md § Intentionally-Unbridged SDK
// Classes, minus the three `ByteBuffer` SIMD views — those are missing *members*
// on a class that IS bridged, so they never reach a variable lookup and cannot
// be reached from here. `test/stdlib/intentionally_unbridged_test.dart` derives
// that identifier set from the doc and asserts the equality, so a name added to
// one and not the other fails a test rather than rotting quietly.
//
// Mirrored in tom_d4rt_ast/lib/src/runtime/unbridged_reasons.dart.

/// Why a deliberately-unbridged SDK identifier is absent, keyed by the name a
/// script actually writes.
///
/// The key is the *reported* identifier, not the class: a script reaches `Zone`
/// by writing `runZoned`, and the `dart:io` compression codecs by writing the
/// `gzip` / `zlib` globals, so those spellings are keys in their own right.
const Map<String, String> kUnbridgedReasons = <String, String>{
  // Cannot be honoured meaningfully — each asks the interpreter for a guarantee
  // it structurally cannot give.
  'Zone': _zone,
  'runZoned': _zone,
  'runZonedGuarded': _zone,
  'Expando':
      'an identity side-table needs stable native identity, which a '
      'value crossing the bridge does not have',
  'WeakReference':
      'weakness is a property of the native heap, and interpreter '
      'structures the script cannot see keep the target reachable',
  'Finalizer':
      'same as WeakReference, plus a GC-timed callback would be '
      'non-deterministic re-entry into sandboxed code',

  // Deferred pending a concrete consumer — no semantic obstacle, simply unbuilt.
  'Link':
      'deferred: symlink manipulation, would need FilesystemPermission '
      'path granularity and no consumer has asked',
  'WebSocket': _webSocket,
  'WebSocketTransformer': _webSocket,
  'WebSocketException': _webSocket,
  'WebSocketStatus': _webSocket,
  'CompressionOptions': _webSocket,
  'gzip': _compression,
  'zlib': _compression,
  'GZipCodec': _compression,
  'ZLibCodec': _compression,
  'ZLibEncoder': _compression,
  'ZLibDecoder': _compression,
  'MutableRectangle':
      'deferred: the immutable Rectangle is bridged and covers '
      'the common case',
  'Float32x4': _simd,
  'Int32x4': _simd,
  'Float64x2': _simd,
  'Float32x4List': _simd,
  'Int32x4List': _simd,
  'Float64x2List': _simd,
};

const String _zone =
    'zones intercept the control flow, scheduling and error '
    'handling the interpreter owns, so a bridged Zone would be a no-op shell';

const String _webSocket =
    'deferred: a large stateful surface (upgrade '
    'handshake, ping/pong, close codes) behind NetworkPermission that no '
    'current script exercises';

const String _compression =
    'deferred: compression codecs, to be added on '
    'concrete demand';

const String _simd =
    'deferred: every lane operation would cost a bridge '
    'crossing, so bridged SIMD is slower than the scalar code it replaces';

/// The message for a failed variable lookup of [name].
///
/// Returns the bare `Undefined variable: <name>` for an ordinary miss — a typo,
/// a scope error, a genuinely missing declaration. For a name in
/// [kUnbridgedReasons] the reason follows, so the reader learns that the absence
/// is a decision without having to know the limitations doc exists.
String undefinedVariableMessage(String name) {
  final reason = kUnbridgedReasons[name];
  if (reason == null) return 'Undefined variable: $name';
  return 'Undefined variable: $name '
      '(not bridged: $reason; see doc/d4rt_limitations.md)';
}
