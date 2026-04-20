/// UserBridge override for BasicMessageChannel.setMessageHandler.
///
/// `BasicMessageChannel<T>.setMessageHandler` takes a
/// `Future<T> Function(T? message)?` handler. The bridge generator
/// can't preserve the class-level `T` at bridge-generation time, so
/// the auto-emitted adapter would install a `(dynamic) => Future<dynamic>`
/// closure which fails Dart's runtime function-type check against a
/// concrete `BasicMessageChannel<String>` (or any other T).
///
/// This override bypasses the typed `setMessageHandler` and installs
/// the handler at the underlying `BinaryMessenger` layer, using the
/// channel's own `MessageCodec` to encode/decode `T` — the exact
/// pattern Flutter's own `BasicMessageChannel.setMessageHandler`
/// uses internally. The handler we install has the non-generic
/// `MessageHandler` signature (`(ByteData?) => Future<ByteData?>`)
/// which Dart accepts regardless of the channel's `T`.
library;

import 'package:flutter/services.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';

/// Bypasses `BasicMessageChannel<T>.setMessageHandler`'s typed signature
/// by installing the handler at the `BinaryMessenger` layer.
@D4rtUserBridge('package:flutter/src/services/platform_channel.dart',
    'BasicMessageChannel')
class BasicMessageChannelUserBridge extends D4UserBridge {
  /// Override for `setMessageHandler(Future<T> Function(T? message)? handler)`.
  ///
  /// Installs a `MessageHandler` on the channel's `binaryMessenger` that
  /// round-trips through the channel's own `MessageCodec`, so the
  /// interpreted callback only ever sees decoded `T` values and
  /// returns encoded `ByteData?` — no generic-closure type check is
  /// involved.
  static Object? overrideMethodSetMessageHandler(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArguments,
  ) {
    final channel = D4.validateTarget<BasicMessageChannel>(
      target,
      'BasicMessageChannel',
    );
    final handlerRaw = positional.isNotEmpty ? positional[0] : null;
    if (handlerRaw == null) {
      channel.binaryMessenger.setMessageHandler(channel.name, null);
      return null;
    }
    final codec = channel.codec;
    channel.binaryMessenger.setMessageHandler(channel.name,
        (ByteData? message) async {
      final decoded = codec.decodeMessage(message);
      final result = D4.callInterpreterCallback(visitor, handlerRaw, [decoded]);
      final awaited = result is Future ? await result : result;
      return codec.encodeMessage(awaited);
    });
    return null;
  }
}
