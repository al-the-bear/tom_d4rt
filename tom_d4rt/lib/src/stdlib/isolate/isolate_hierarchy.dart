import 'package:tom_d4rt/d4rt.dart';

/// Supertype edges for `dart:isolate`.
///
/// A three-edge library, but two of the three are the kind a script hits on its
/// first use. `ReceivePort` is consumed with `await for` or `.listen`, so every
/// explanation of isolates tells the reader they are holding a stream — and a
/// `is Stream` guard written around that explanation answered `false`.
/// `RemoteError` is what an errored isolate delivers, so an `on Error` handler
/// around a spawn never matched it.
///
/// `SendPort -> Capability` was already true, via `CapabilityIsolate`'s
/// predicate, and is declared for the same reason the `dart:core` block declares
/// `RegExpMatch -> Match`: the hierarchy should be readable from one place
/// rather than inferred from a predicate in another file.
///
/// The registry keys on NAME, so `register()` must run after the bridges these
/// names refer to are defined.
class IsolateHierarchyIsolate {
  static void register() {
    BridgedClass.registerSupertypes(const {
      // `class ReceivePort implements Stream<dynamic>`.
      'ReceivePort': ['Stream'],
      // `class RemoteError extends Error`.
      'RemoteError': ['Error'],
      // `abstract interface class SendPort implements Capability`.
      'SendPort': ['Capability'],
    });
  }
}
