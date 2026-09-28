import 'package:tom_d4rt_ast/runtime.dart';

/// The refusal a bridged `fuse` gives when its argument is not a native
/// `Converter` / `Codec` of the type it needs.
///
/// SCE216. `fuse` builds a NATIVE pipeline: the SDK composes the two converters
/// and runs the result without the interpreter. A converter a SCRIPT defines
/// (`class MyC extends Converter<...>`) is an [InterpretedInstance] with a
/// `convert` method, not a native `Converter`, so no guard can accept it. That
/// is a deliberate limit, not an erasure bug of the SCD181 / SCC68 kind — those
/// lost only a type argument and were recoverable by a coercion. Making it work
/// would mean a native adapter calling back into the interpreter per chunk on
/// a path chosen for streaming; decision (b) was to say so instead.
///
/// So the message distinguishes the two ways a call can land here: a
/// script-defined instance is told about the limit and the workaround, and
/// anything else keeps the plain type requirement.
String fuseArgumentMessage(String member, String expected, Object? argument) {
  if (argument is InterpretedInstance) {
    return '$member requires another native $expected as argument. '
        '${argument.klass.name} is defined in the script, and a script-defined '
        'Converter or Codec cannot be fused: fuse builds a native pipeline the '
        'interpreter does not run. Call convert on each stage in turn instead.';
  }
  return '$member requires another $expected as argument.';
}
