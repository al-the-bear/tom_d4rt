import 'package:tom_d4rt_ast/runtime.dart';

/// Supertype edges for the `dart:convert` chunked-sink hierarchy.
///
/// `ChunkedConversionSink` is the root of the sink half of `dart:convert`, and
/// both `StringConversionSink` and `ByteConversionSink` implement it. Once the
/// root carries an `isAssignable` predicate, *every* sink in the library
/// matches it — so without these edges the root steals dispatch from its own
/// subtypes and the specific surface disappears:
///
///     StringConversionSink.withCallback(...).asStringSink()
///     // Bridged class 'ChunkedConversionSink' has no instance method
///     // named 'asStringSink'.
///
/// The private implementations the SDK actually hands back make this concrete.
/// `withCallback` / `from` and every `startChunkedConversion` return a private
/// class — `_StringCallbackSink`, `_ByteCallbackSink`, `_ByteAdapterSink`,
/// `_Utf8EncoderSink`, `_Utf8StringSinkAdapter`, `_LineSplitterSink` — so the
/// direct-`Type` lookup never fires and resolution always lands in the
/// `isAssignable` pass, where the union-based supertype filter is the only
/// thing that can tell a byte sink from a string sink.
///
/// Expressed as registry edges rather than by narrowing any `isAssignable`,
/// for the reason spelled out on `QueueHierarchyCollection`: the predicate
/// decides *ownership*, and every hand-written stdlib bridge has
/// `hierarchyDepth == 0`, so feeding the registry lets
/// `Environment._filterToMostSpecific` drop supertype matches — making
/// dispatch more exact rather than less.
class ConvertHierarchyConvert {
  static void register() {
    BridgedClass.registerSupertypes(const {
      'StringConversionSink': ['ChunkedConversionSink', 'Sink'],
      'ByteConversionSink': ['ChunkedConversionSink', 'Sink'],
      'ChunkedConversionSink': ['Sink'],
      'ClosableStringSink': ['StringSink'],
    });
  }
}
