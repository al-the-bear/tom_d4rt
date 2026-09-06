import 'package:test/test.dart';
// The registrar barrels re-export `Environment`, so they are the only imports
// needed; the collision under test is between these two registrars.
import 'package:tom_d4rt/src/stdlib/core.dart';
import 'package:tom_d4rt/src/stdlib/io.dart';

/// SCB26: `StringSink` must be owned by exactly one registrar.
///
/// `dart:io` does not declare `StringSink` — it re-exports the `dart:core` one.
/// The io registrar nevertheless shipped its own second definition, and because
/// `CoreStdlib` registers eagerly while `IoStdlib` registers lazily on a
/// `dart:io` import, the io copy always landed *second* and displaced the core
/// one under last-wins.
///
/// That would be a tidiness issue if the two definitions agreed. They did not:
/// the io copy was a strict subset, so importing `dart:io` silently removed
/// `toString`, `hashCode` and `runtimeType` from `StringSink`. Both definitions
/// declare `nativeType: StringSink`, so the collision machinery classified it
/// as a benign re-export and never marked the name ambiguous — the loss was
/// reported only as a `Logger.warn`.
///
/// These assertions are registration-level rather than script-level, and the
/// reason they had to be has since gone away. When this file was written
/// `StringSink` had no script-reachable instance at all: a `StringBuffer`
/// resolved to `StringBufferCore`, `stdout` to the `Stdout` bridge, and no
/// member lookup or type test ever landed on the `StringSink` bridge — which is
/// why the member drift survived its whole lifetime with nothing but a
/// `Logger.warn` to show for it.
///
/// SCC56 declared the supertype edges (`StringBuffer -> StringSink` in
/// `core_hierarchy.dart`, `IOSink -> StreamSink, StringSink` in
/// `io_hierarchy.dart`) and closed that. Measured 2026-09-06,
/// `StringBuffer() is StringSink` is TRUE, so is `stdout is StringSink`, and a
/// `StringBuffer` does now fall through to this bridge for members
/// `StringBufferCore` does not declare. SCC77 pins that reachability in
/// `test/stdlib/core/scc77_string_sink_reachability_test.dart`.
///
/// The assertions below stay registration-level anyway, because what they check
/// is which registrar OWNS the name — a question about the registry, not about
/// a value.
void main() {
  /// The members the `dart:core` definition declares. Named here rather than
  /// inlined per test so a deliberate future change to the core bridge shows up
  /// as one edit, and an accidental narrowing shows up as several failures.
  //
  // SCC77 removed `hashCode` from this set. It was declared in BOTH `methods`
  // and `getters`, and `BridgedInstance.get` consults `methods` first — so the
  // getter was dead and reading `x.hashCode` on a value that resolved here
  // would have yielded the bound callable instead of the int. That is the same
  // shape SCC73 found on `Runes.iterator`. No script could observe it, because
  // nothing resolves to this bridge, which is why it survived; the method entry
  // is gone and the getter is the one that answers.
  const coreMethods = <String>{
    'toString',
    'write',
    'writeAll',
    'writeCharCode',
    'writeln',
  };
  const coreGetters = <String>{'hashCode', 'runtimeType'};

  Environment coreOnly() {
    final env = Environment();
    CoreStdlib.register(env);
    return env;
  }

  Environment coreThenIo() {
    final env = coreOnly();
    IoStdlib.register(env);
    return env;
  }

  group('SCB26: StringSink has a single owning registrar', () {
    test('F-SCB26-1: dart:core declares the full member set — the baseline the '
        'io registrar must not narrow [2026-09-03]', () {
      final sink = coreOnly().findBridgedClassByName('StringSink');
      expect(sink, isNotNull);
      expect(sink!.methods.keys, unorderedEquals(coreMethods));
      expect(sink.getters.keys, unorderedEquals(coreGetters));
    });

    test(
      'F-SCB26-2: importing dart:io does not narrow StringSink — the io copy '
      'was a strict subset and won on last-wins [2026-09-03]',
      () {
        final sink = coreThenIo().findBridgedClassByName('StringSink');
        expect(sink, isNotNull);
        expect(
          sink!.methods.keys,
          unorderedEquals(coreMethods),
          reason: 'the io definition omitted toString and hashCode',
        );
        expect(
          sink.getters.keys,
          unorderedEquals(coreGetters),
          reason: 'the io definition declared no getters at all',
        );
      },
    );

    test('F-SCB26-3: exactly one StringSink definition is registered, so there '
        'is no displaced sibling for resolution to fall back to '
        '[2026-09-03]', () {
      expect(
        coreThenIo().findAllBridgedClassesByName('StringSink'),
        hasLength(1),
      );
    });

    test('F-SCB26-4: the io registrar does not own StringSink at all — dart:io '
        're-exports the dart:core declaration rather than making its own '
        '[2026-09-03]', () {
      final ioOnly = Environment();
      IoStdlib.register(ioOnly);
      expect(
        ioOnly.findBridgedClassByName('StringSink'),
        isNull,
        reason:
            'StringSink belongs to CoreStdlib, which always registers '
            'first; a second copy here can only displace it',
      );
    });
  });
}
