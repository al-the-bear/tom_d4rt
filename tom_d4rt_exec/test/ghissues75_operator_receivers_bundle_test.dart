/// ghissues75 (GitHub al-the-bear/tom_d4rt#18, resolved bundles) on the BUNDLE PATH: extension operators, index operators and setters (`test/fixtures/ghissues75_operator_cases.dart.txt`), through `AstBundler(config: AstBundlerConfig(resolve: true))` with and without its static facts, bundled by `AstBundler`, sent
/// through `toBytes` / `fromBytes` as an app receives a bundle, and run by
/// `D4rtRunner`.
///
/// `ghissues75_operator_receivers_test.dart` next door is the verbatim port of the analyzer-based suite and
/// runs the same cases through `execute(sources:)`. This file is its bundle
/// half, which has no counterpart in `tom_d4rt` and so can only be pinned
/// here; splitting them keeps the shared-name file a verbatim port (see
/// `_plan_e2_static_in_closure_bundle_test.dart`). Expected values are native
/// Dart's, as in the port.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstResolver;
import 'package:tom_d4rt_exec/d4rt.dart';

final _resolver = AstResolver();

/// [sources] bundled from [entry] by the [AstBundler] - parse-only, or with
/// [resolve] the resolving check and its static facts - sent through
/// `toBytes` / `fromBytes` as an app receives a bundle.
Future<AstBundle> _bundle(
  Map<String, String> sources,
  String entry, {
  bool resolve = false,
  Set<String> bridged = const {},
  Map<String, String> stubs = const {},
}) async {
  final bundle = await AstBundler(
    explicitSources: sources,
    bridgedLibraries: bridged,
    declarationStubs: stubs,
    fileAccessValidator: (_) => false,
    config: AstBundlerConfig(resolve: resolve),
    resolver: _resolver,
  ).createFromSource(sources[entry]!, sourcePath: entry);
  return AstBundle.fromBytes(bundle.toBytes());
}

Matcher refusedWith(String text) =>
    throwsA(predicate((Object e) => e.toString().contains(text), text));

const _entry = 'package:map_repro/entry.dart';
const _native = 'package:map_repro/native.dart';

/// The host library, registered at run time; the resolver checks against it
/// (tom_ast_generator's `tool/write_resolved_bundle_fixture.dart`).
const _stub = """
Map<String, int> sameMap() => throw UnimplementedError();
Map<String, int> emptyMap() => throw UnimplementedError();
Set<String> sameSet() => throw UnimplementedError();
""";

D4rtRunner _runner() => D4rtRunner()
  ..registerTopLevelFunction(
    'sameMap',
    (visitor, positional, named, typeArgs) => <String, int>{'x': 7},
    _native,
  )
  ..registerTopLevelFunction(
    'emptyMap',
    (visitor, positional, named, typeArgs) => <String, int>{},
    _native,
  )
  ..registerTopLevelFunction(
    'sameSet',
    (visitor, positional, named, typeArgs) => <String>{'a'},
    _native,
  );

Future<AstBundle> _fixtureBundle(String name, {required bool resolve}) =>
    _bundle(
      {_entry: File('test/fixtures/$name.dart.txt').readAsStringSync()},
      _entry,
      resolve: resolve,
      bridged: {_native},
      stubs: {_native: _stub},
    );

List<String> _strings(Object? value) => [for (final e in value as List) '$e'];

void main() {
  tearDownAll(_resolver.dispose);

  group(
    'ghissues75 on the bundle path: operators, index operators, setters',
    () {
      test(
        'GH75-B1: with the facts it answers as native Dart [2026-11-19]',
        () async {
          final bundle = await _fixtureBundle(
            'ghissues75_operator_cases',
            resolve: true,
          );
          expect(_strings(_runner().executeBundle(bundle)), [
            'plus String',
            'plus dynamic',
            'plus String',
            'tilde String',
            'tilde dynamic',
            'narrow',
            'wide',
            'index String',
            'index dynamic',
            'index String',
            'tag String',
            'tag dynamic',
            'tag String',
            'index set String',
            'index set dynamic',
          ]);
        },
      );

      test('GH75-B2: without them it approximates, as tom_d4rt does '
          '[2026-11-19]', () async {
        final resolved = await _fixtureBundle(
          'ghissues75_operator_cases',
          resolve: true,
        );
        final bundle = AstBundle.fromJson(resolved.toJson()..remove('facts'));
        expect(_strings(_runner().executeBundle(bundle)), [
          'plus String',
          'plus dynamic',
          'plus dynamic',
          'tilde String',
          'tilde dynamic',
          'wide',
          'wide',
          'index String',
          'index dynamic',
          'index dynamic',
          'tag String',
          'tag dynamic',
          'tag dynamic',
          'index set String',
          'index set dynamic',
        ]);
      });
    },
  );
}
