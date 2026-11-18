// GitHub #23's `main.dart` (ghissues79): a constructor tear-off of a class
// reached through an import prefix, `generated.Protocol.new`, as Serverpod
// 4.1's generated `ProtocolDeserialization.cached` writes it. `main` is the
// issue's own; `extras` adds the shapes ghissues79 covers. Valid Dart.
// ignore_for_file: unnecessary_lambdas

import 'dart:core' as core;
import 'dart:core';

import 'protocol.dart' as generated;

/// Provides a same-library control with the same unnamed factory shape.
class LocalProtocol {
  /// Creates the stable singleton used by the factory.
  LocalProtocol._(this.value);

  final int value;

  static final LocalProtocol _instance = LocalProtocol._(7);

  /// Matches the factory shape of the prefixed Protocol fixture.
  factory LocalProtocol() => _instance;
}

/// Returns `[7, 7, 11, 11]` when local and prefixed constructor tear-offs work.
Object main() {
  final LocalProtocol Function() localTearOff = LocalProtocol.new;
  final generated.Protocol Function() prefixedTearOff = generated.Protocol.new;
  return <int>[
    LocalProtocol().value,
    localTearOff().value,
    generated.Protocol().value,
    prefixedTearOff().value,
  ];
}

/// The other constructor shapes through the prefix, each torn off and
/// called, as strings.
List<String> extras() {
  final generated.Plain Function(int) plain = generated.Plain.new;
  final generated.Implicit Function() implicit = generated.Implicit.new;
  final generated.Box<int> Function(int, String) named =
      generated.Box<int>.named;
  final generated.Box<int> Function(int) generic = generated.Box<int>.new;
  final StringBuffer Function([Object]) buffer = core.StringBuffer.new;
  return [
    '${plain(3).value}',
    '${implicit().value}',
    named(4, 'n').describe(),
    generic(6).describe(),
    (buffer('ab')..write('c')).toString(),
    '${[1, 2].map(generated.Plain.new).map((p) => p.value).toList()}',
  ];
}
