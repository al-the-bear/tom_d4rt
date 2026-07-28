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
/// **The edges are flattened deliberately.** [BridgedClass.isSubtypeOf]
/// consults the registry for a class's direct supertypes and ONE further hop,
/// not the full transitive closure — so `JsonEncoder -> Converter ->
/// StreamTransformerBase -> StreamTransformer` would still answer `false` at
/// three hops if each edge were declared only once. Writing the closure out is
/// what makes the deep answers correct. (The MEMBER walk uses
/// [BridgedClass.transitiveSupertypeNames], which *is* transitive, so the two
/// mechanisms disagree about depth; unifying them is tracked separately.)
class ConvertHierarchyConvert {
  static void register() {
    BridgedClass.registerSupertypes(const {
      // The sink half (SC9).
      'StringConversionSink': ['ChunkedConversionSink', 'Sink'],
      'ByteConversionSink': ['ChunkedConversionSink', 'Sink'],
      'ChunkedConversionSink': ['Sink'],
      'ClosableStringSink': ['StringSink'],

      // The codec half (SCB23). `abstract class Encoding extends
      // Codec<String, List<int>>`, and the three character encodings extend
      // `Encoding`. `JsonCodec` and `Base64Codec` extend `Codec` directly —
      // they are NOT encodings, and the tests pin that negative.
      'Encoding': ['Codec'],
      'Utf8Codec': ['Encoding', 'Codec'],
      'AsciiCodec': ['Encoding', 'Codec'],
      'Latin1Codec': ['Encoding', 'Codec'],
      'JsonCodec': ['Codec'],
      'Base64Codec': ['Codec'],

      // The converter half (SCB23). `abstract mixin class Converter<S, T>
      // implements StreamTransformerBase<S, T>`; dart:async already declares
      // `StreamTransformerBase -> StreamTransformer`, but the leaves need the
      // closure spelled out for the reason in the class doc above.
      'Converter': ['StreamTransformerBase', 'StreamTransformer'],
      'JsonEncoder': ['Converter', 'StreamTransformerBase', 'StreamTransformer'],
      'JsonDecoder': ['Converter', 'StreamTransformerBase', 'StreamTransformer'],
      'JsonUtf8Encoder': [
        'Converter',
        'StreamTransformerBase',
        'StreamTransformer'
      ],
      'Utf8Encoder': ['Converter', 'StreamTransformerBase', 'StreamTransformer'],
      'Utf8Decoder': ['Converter', 'StreamTransformerBase', 'StreamTransformer'],
      'AsciiEncoder': [
        'Converter',
        'StreamTransformerBase',
        'StreamTransformer'
      ],
      'AsciiDecoder': [
        'Converter',
        'StreamTransformerBase',
        'StreamTransformer'
      ],
      'Latin1Encoder': [
        'Converter',
        'StreamTransformerBase',
        'StreamTransformer'
      ],
      'Latin1Decoder': [
        'Converter',
        'StreamTransformerBase',
        'StreamTransformer'
      ],
      'Base64Encoder': [
        'Converter',
        'StreamTransformerBase',
        'StreamTransformer'
      ],
      'Base64Decoder': [
        'Converter',
        'StreamTransformerBase',
        'StreamTransformer'
      ],
      'HtmlEscape': ['Converter', 'StreamTransformerBase', 'StreamTransformer'],

      // `final class LineSplitter extends StreamTransformerBase<String,
      // String>` — deliberately NOT a Converter. It carries `convert` and
      // `startChunkedConversion` of its own, which is what makes the wrong
      // edge tempting; adding it would turn a false `is` answer into a
      // confidently wrong `true`.
      'LineSplitter': ['StreamTransformerBase', 'StreamTransformer'],
    });
  }
}
