import 'dart:async';
import 'package:tom_d4rt_ast/runtime.dart';

import 'run_action.dart';

/// Coerce a script-supplied transformer to a native [StreamTransformer].
///
/// Scripts reach a `transform` member from three directions: with a native
/// transformer built by `StreamTransformer.fromBind` or
/// `StreamTransformer.fromHandlers` (already native), with a bridged one, and
/// — the case `StreamTransformerBase` exists to enable — with an
/// [InterpretedInstance] of a script class that extends
/// `StreamTransformerBase` or implements `StreamTransformer`. The last shape
/// has no native object at all; its `bind` lives only in the interpreter, so
/// the only way to hand it to the SDK is to wrap the interpreted method in
/// `StreamTransformer.fromBind`.
///
/// Returns `null` when the value is not a transformer in any of those senses,
/// leaving the "what do I throw" decision to the call site.
///
/// SHARED BECAUSE FOUR ADAPTERS ASK THE SAME QUESTION, and until sce114 only
/// one of them asked it properly. `Stream.transform` resolved through this
/// helper; `Socket.transform` and `ServerSocket.transform` wrote
/// `positionalArgs[0] as StreamTransformer`, which admits the first two shapes
/// and rejects the third with a host `_TypeError` naming `InterpretedInstance`
/// — so the same script class worked on a stream and failed on a socket, and
/// the failure named an interpreter-internal type rather than the argument.
StreamTransformer? asStreamTransformer(
  InterpreterVisitor visitor,
  Object? value,
) {
  if (value is StreamTransformer) return value;
  if (value is BridgedInstance && value.nativeObject is StreamTransformer) {
    return value.nativeObject as StreamTransformer;
  }
  if (value is InterpretedInstance) {
    final bind = value.get('bind', visitor: visitor);
    if (bind is Callable) {
      return StreamTransformer.fromBind(
        (stream) => runAction<Stream>(visitor, bind, [stream]) as Stream,
      );
    }
  }
  return null;
}

/// The [asStreamTransformer] result for [value], or a readable failure.
///
/// Every `transform` adapter wants the same sentence when the argument is not
/// a transformer, and wants it to name the MEMBER the script called rather
/// than the SDK type the adapter happened to cast to.
StreamTransformer requireStreamTransformer(
  InterpreterVisitor visitor,
  Object? value,
  String member,
) {
  final transformer = asStreamTransformer(visitor, value);
  if (transformer == null) {
    throw RuntimeD4rtException(
      '$member requires a StreamTransformer argument.',
    );
  }
  return transformer;
}
