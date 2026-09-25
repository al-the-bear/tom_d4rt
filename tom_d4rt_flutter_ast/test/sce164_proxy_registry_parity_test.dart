// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — the two twins' hand-duplicated
// proxy registries must agree, and every proxy must expose its instance.
//
// Its subject reaches OUTSIDE this package (the sibling twin's registration
// file), so it runs only when tom_d4rt_flutter_ast's suite runs. SCD129 made
// that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE GUARD'
// */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
/// SCE164 — interface proxies, and the two questions worth asking about them.
///
/// GEN-126's last two rows failed because no proxy was registered for their
/// base AT ALL — `TwoDimensionalChildBuilderDelegate` and `RenderProxyBox`.
/// With nothing carrying the interpreted identity across the boundary, the
/// value really was the bridged base by the time it returned, `getRuntimeType`
/// was answering correctly about it, and SCD119's retry had nothing to retry
/// against. Both are registered now.
///
/// ## The scan the work asked for, and why it is NOT what this file does
///
/// SCE164 proposed: "for every bridged class a corpus script extends, assert a
/// proxy is registered". Measured before writing it — 2 085 corpus scripts, the
/// live Flutter registry:
///
/// | measurement                                   | value |
/// | --------------------------------------------- | ----: |
/// | distinct base classes the corpus extends       |    84 |
/// | of those, registered as bridged classes        |    76 |
/// | of THOSE, with no interface proxy registered   |    36 |
///
/// **`State` alone is extended by 380 scripts and has no proxy, and the corpus
/// is green.** So the proposed property is simply false: a proxy is needed only
/// when the value crosses into native code AND comes back to meet a parameter
/// declared as the script's own class. The scan would have produced a 36-entry
/// allowlist that is mostly noise — a permanently-true exception set nobody can
/// evaluate, which is the shape it would have been written to avoid. Recorded
/// here so the next reader does not re-propose it.
///
/// The corpus already answers that question empirically and precisely: a base
/// that needs a proxy and lacks one produces GEN-126's
/// `type Base is not a subtype of type ScriptClass`. That is a property of a
/// RUN, and the corpus is where it belongs.
///
/// ## What is worth a guard instead
///
/// Two things the corpus cannot see, and both are cheap file I/O.
///
/// F-SCE164-1 — THE TWINS REGISTER THE SAME SET. `d4rt_runtime_registrations
/// .dart` is ~200 KB duplicated BY HAND between the twins with no sync
/// mechanism (sce165 owns that asymmetry). A proxy added to one twin and not
/// the other is a silent divergence that only a corpus run on the neglected
/// twin would find. Adding these two meant remembering to edit both files,
/// which is exactly the step this catches.
///
/// F-SCE164-2 — EVERY PROXY EXPOSES ITS INSTANCE. SCD138 had to sweep
/// `implements D4InterpretedProxy` across 21 classes per twin that had been
/// written without it; SCD119's retry sees nothing without the interface and
/// refuses values that work. Held here rather than re-swept later.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'sibling_trees.dart';

const _ast = 'lib/src/d4rt_runtime_registrations.dart';
const _source = '../tom_d4rt_flutter/lib/src/d4rt_runtime_registrations.dart';

/// The bases SCE164 measured and deliberately did NOT register.
///
/// Registering either one is a regression, each for its own reason, and the
/// registration file records both measurements where the registration would
/// go. This is what stops them being added by somebody reading only GEN-126's
/// entry, which says a proxy is what these rows need — true of the mechanism
/// and false of the outcome. scf31 owns the remaining work.
const _withheldBases = <String>{
  'RenderProxyBox',
  'TwoDimensionalChildBuilderDelegate',
};

/// Classes named like a proxy that are deliberately NOT one.
///
/// `_InterpretedInheritedElement` is an `Element`, not a value that crosses a
/// binding — nothing ever asks it to stand for an interpreted instance.
const _notValueProxies = <String>{'_InterpretedInheritedElement'};

/// Well under the measured count; a floor, not a tracker.
const _minProxies = 25;

Set<String> _registered(String source) => RegExp(
  r"registerInterfaceProxy\(\s*'([A-Za-z0-9_]+)'",
).allMatches(source).map((m) => m.group(1)!).toSet();

Set<String> _capturesSuperArgs(String source) => RegExp(
  r"markProxyCapturesSuperArgs\(\s*'([A-Za-z0-9_]+)'",
).allMatches(source).map((m) => m.group(1)!).toSet();

/// Proxy classes declared in [source], and whether each declares the interface.
///
/// The header runs to the line ending in `{` — `_InterpretedRenderBoxContainer`
/// carries a nine-line `with` clause before its `implements`, so a fixed-size
/// window would read it as missing the interface.
Map<String, bool> _proxyClasses(String source) {
  final lines = source.split('\n');
  final out = <String, bool>{};
  for (var i = 0; i < lines.length; i++) {
    if (!lines[i].startsWith('class _Interpreted')) continue;
    var j = i;
    while (j < lines.length && !lines[j].trimRight().endsWith('{')) {
      j++;
    }
    final header = lines.sublist(i, (j + 1).clamp(0, lines.length)).join(' ');
    final name = lines[i].split(' ')[1].split(RegExp(r'[ <]')).first;
    out[name] = header.contains('D4InterpretedProxy');
  }
  return out;
}

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject: "the two twins' hand-duplicated",
  );

  late String ast;
  late String source;

  setUpAll(() {
    for (final path in <String>[_ast, _source]) {
      expect(
        File(path).existsSync(),
        isTrue,
        reason:
            '$path is this guard\'s subject; if the registration file moved, '
            'move the guard with it rather than leaving one that reads nothing',
      );
    }
    ast = File(_ast).readAsStringSync();
    source = File(_source).readAsStringSync();
  });

  group('SCE164: the twins\' proxy registries agree and every proxy exposes '
      'its instance', () {
    test('F-SCE164-1: both twins register the same proxies, and mark the same '
        'ones as capturing super args', () {
      final astProxies = _registered(ast);
      final sourceProxies = _registered(source);
      expect(
        astProxies.difference(sourceProxies),
        isEmpty,
        reason:
            'registered on the AST line only. The two registration files are '
            'duplicated by hand with no sync mechanism, so a proxy added to '
            'one twin is invisible on the other until a corpus run on that '
            'twin happens to need it',
      );
      expect(
        sourceProxies.difference(astProxies),
        isEmpty,
        reason: 'registered on the source line only — same hazard, other way',
      );

      expect(
        _capturesSuperArgs(ast),
        _capturesSuperArgs(source),
        reason:
            'a proxy marked as capturing `super(...)` args on one twin and not '
            'the other constructs differently on each, which is worse than '
            'being absent because both lines appear to work',
      );
    });

    test('F-SCE164-2: every proxy class exposes its interpreted instance', () {
      for (final (label, src) in <(String, String)>[
        ('tom_d4rt_flutter_ast', ast),
        ('tom_d4rt_flutter', source),
      ]) {
        final classes = _proxyClasses(src);
        final missing = <String>[
          for (final entry in classes.entries)
            if (!entry.value && !_notValueProxies.contains(entry.key))
              entry.key,
        ];
        expect(
          missing,
          isEmpty,
          reason:
              '$label: these stand in for an interpreted instance and do not '
              'say so. `ResolvedBinding.bind` retries against the instance '
              'behind a `D4InterpretedProxy`; without the interface it sees '
              'nothing and refuses a value that works, which is GEN-126\'s '
              'signature. SCD138 swept 21 of these per twin — this is what '
              'stops the next one:\n  ${missing.join('\n  ')}',
        );
      }
    });

    test(
      'F-SCE164-3: the two measured-and-withheld bases stay unregistered',
      () {
        for (final (label, src) in <(String, String)>[
          ('tom_d4rt_flutter_ast', ast),
          ('tom_d4rt_flutter', source),
        ]) {
          final added = _registered(src).intersection(_withheldBases);
          expect(
            added,
            isEmpty,
            reason:
                '$label registers a proxy SCE164 measured and withheld: '
                '${added.join(', ')}. `RenderProxyBox` wedges '
                'rendering/render_shrink_wrapping_viewport_test.dart and takes '
                'flutter_base_13 from +54 to +52 -2; '
                '`TwoDimensionalChildBuilderDelegate` trades three type errors '
                'for 408 framework errors. Read the note where the registration '
                'would go before adding one — scf31 owns the case, and the '
                'repair it needs is not a registration',
          );
        }
      },
    );

    test('F-SCE164-4 (control): the scan found a real registry', () {
      final astProxies = _registered(ast);
      expect(
        astProxies.length,
        greaterThanOrEqualTo(_minProxies),
        reason:
            'only ${astProxies.length} proxies parsed. F-SCE164-1 compares two '
            'sets, and two EMPTY sets are equal — this is what stops a broken '
            'pattern passing every case above',
      );
      expect(
        _proxyClasses(ast).length,
        greaterThanOrEqualTo(_minProxies),
        reason: 'no proxy CLASSES parsed, so F-SCE164-2 iterates nothing',
      );
      expect(
        _proxyClasses(ast)['_InterpretedInheritedElement'],
        isFalse,
        reason:
            'the one recorded exception must still be found and still lack the '
            'interface — if it grew one, the exemption is dead and comes out',
      );
    });
  });
}
