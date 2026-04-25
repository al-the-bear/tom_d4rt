import 'package:tom_d4rt/src/stdlib/core.dart';
import 'package:tom_d4rt/src/stdlib/async.dart';
import 'package:tom_d4rt/src/stdlib/typed_data.dart';

class Stdlib {
  final Environment environment;

  Stdlib(this.environment);

  void register() {
    CoreStdlib.register(environment);
    AsyncStdlib.register(environment);
    // GEN-106: register `dart:typed_data` eagerly so ByteData / Uint8List /
    // ByteBuffer / Endian / etc. are reachable from any script without an
    // explicit `import 'dart:typed_data'`. Flutter scripts routinely use
    // these via flutter/services.dart re-exports (binary message codecs,
    // Uint8List buffers) and previously failed with
    // "Undefined variable: ByteData" because the lazy load was only
    // triggered by an explicit dart:typed_data import. The class names
    // (`ByteData`, `Uint8List`, …) are unique enough that name-collision
    // with user code is not a concern; `dart:math` (which has `min`/`max`/
    // `pi`) remains lazy + isolated for that reason.
    TypedDataStdlib.register(environment);
  }
}
