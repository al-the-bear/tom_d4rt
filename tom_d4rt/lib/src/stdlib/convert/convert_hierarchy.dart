import 'package:tom_d4rt/d4rt.dart';

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
/// for the reason spelled out on `CollectionHierarchyCollection`: the predicate
/// decides *ownership*, and every hand-written stdlib bridge has
/// `hierarchyDepth == 0`, so feeding the registry lets
/// `Environment._filterToMostSpecific` drop supertype matches — making
/// dispatch more exact rather than less.
///
/// SCB23 added the second block: the codec/converter half, which is the half
/// scripts actually touch. Until then `utf8 is Codec`, `utf8 is Encoding` and
/// `JsonEncoder() is Converter` all answered `false`. That half also carried
/// the block's one real member loss — `Encoding.decodeStream` is declared on
/// `Encoding` alone, so the three encodings could not reach it; the edge plus
/// the adapter added to `EncodingConvert` is what restores it.
///
/// **Each edge is declared ONCE**, exactly as the SDK declares it. This block
/// used to spell out every closure by hand — `'JsonEncoder': ['Converter',
/// 'StreamTransformerBase', 'StreamTransformer']` for a class the SDK declares
/// as `implements Converter` — because [BridgedClass.isSubtypeOf] consulted the
/// direct supertypes and ONE further hop and then stopped, so the three-hop
/// answer came out `false`. That predicate now reads the full closure through
/// [BridgedClass.transitiveSupertypeNames], the same walk the MEMBER lookup has
/// always used, so the two mechanisms no longer disagree about depth and the
/// hand-flattening is gone. Add a new converter by naming its immediate
/// supertype only.
class ConvertHierarchyConvert {
  static void register() {
    BridgedClass.registerSupertypes(const {
      // The sink half (SC9).
      'StringConversionSink': ['ChunkedConversionSink'],
      'ByteConversionSink': ['ChunkedConversionSink'],
      'ChunkedConversionSink': ['Sink'],
      'ClosableStringSink': ['StringSink'],

      // The codec half (SCB23). `abstract class Encoding extends
      // Codec<String, List<int>>`, and the three character encodings extend
      // `Encoding`. `JsonCodec` and `Base64Codec` extend `Codec` directly —
      // they are NOT encodings, and the tests pin that negative.
      'Encoding': ['Codec'],
      'Utf8Codec': ['Encoding'],
      'AsciiCodec': ['Encoding'],
      'Latin1Codec': ['Encoding'],
      'JsonCodec': ['Codec'],
      'Base64Codec': ['Codec'],

      // The converter half (SCB23). `abstract mixin class Converter<S, T>
      // implements StreamTransformerBase<S, T>`; dart:async declares
      // `StreamTransformerBase -> StreamTransformer`, so the leaves reach
      // `StreamTransformer` three hops out through the registry walk.
      'Converter': ['StreamTransformerBase'],
      'JsonEncoder': ['Converter'],
      'JsonDecoder': ['Converter'],
      'JsonUtf8Encoder': ['Converter'],
      'Utf8Encoder': ['Converter'],
      'Utf8Decoder': ['Converter'],
      'AsciiEncoder': ['Converter'],
      'AsciiDecoder': ['Converter'],
      'Latin1Encoder': ['Converter'],
      'Latin1Decoder': ['Converter'],
      'Base64Encoder': ['Converter'],
      'Base64Decoder': ['Converter'],
      'HtmlEscape': ['Converter'],

      // `final class LineSplitter extends StreamTransformerBase<String,
      // String>` — deliberately NOT a Converter. It carries `convert` and
      // `startChunkedConversion` of its own, which is what makes the wrong
      // edge tempting; adding it would turn a false `is` answer into a
      // confidently wrong `true`.
      'LineSplitter': ['StreamTransformerBase'],
    });
  }
}
