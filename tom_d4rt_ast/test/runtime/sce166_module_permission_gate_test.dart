/// SCE166 — the analyzer-free interpreter enforces the same import gates as the
/// reference line.
///
/// `tom_d4rt`'s `ModuleLoader._checkModulePermissions` refuses a script that
/// imports `dart:io` without `FilesystemPermission`, or `dart:isolate` without
/// `IsolatePermission`. This tree DECLARED both permission classes and checked
/// NEITHER: a bundle could import `dart:isolate`, build `ReceivePort`s, obtain
/// `SendPort`s and call `Isolate.spawn` with the embedder granting nothing.
///
/// THE PLACE THE GAP WAS MATTERS MORE THAN THE GAP. The quest's own constraint
/// is that the interpreter stays fully sandboxed, and THIS is the tree that
/// ships inside Flutter apps executing bundles downloaded at runtime. A
/// permission class present in the public API but never consulted is worse than
/// one that is absent: an embedder reading `IsolatePermission` reasonably
/// concludes the capability is gated.
///
/// Found by scd139 while auditing a corpus skip whose justification was false —
/// the AST twin ran a script the source twin refused, and the asymmetry was the
/// gate.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

int _offset = 0;
int _next() => _offset += 2;

SImportDirective _import(String uri) => SImportDirective(
  offset: _next(),
  length: 1,
  uri: SSimpleStringLiteral(offset: _next(), length: 1, value: uri),
);

/// A bundle that imports [uri] and whose `main` returns 1.
///
/// The body is deliberately trivial: the gate is on the IMPORT, so a script
/// that merely names the library is the whole hazard. Nothing here has to
/// construct an `Isolate` for the capability to have been handed over.
AstBundle _bundleImporting(String uri) {
  const entry = 'package:probe/main.dart';
  final mainFn = SFunctionDeclaration(
    offset: _next(),
    length: 1,
    name: SSimpleIdentifier(offset: _next(), length: 4, name: 'main'),
    functionExpression: SFunctionExpression(
      offset: _next(),
      length: 1,
      parameters: SFormalParameterList(offset: _next(), length: 1),
      body: SExpressionFunctionBody(
        offset: _next(),
        length: 1,
        expression: SIntegerLiteral(offset: _next(), length: 1, value: 1),
      ),
    ),
  );

  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [_import(uri)],
        declarations: [mainFn],
      ),
    },
  );
}

Object? _run(D4rtRunner runner, String uri) =>
    runner.executeBundle(_bundleImporting(uri), name: 'main');

void main() {
  group('SCE166: dangerous imports are gated on the analyzer-free line', () {
    test('F-SCE166-1: `dart:isolate` is refused without IsolatePermission '
        '[2026-09-23]', () {
      expect(
        () => _run(D4rtRunner(), 'dart:isolate'),
        throwsA(
          predicate(
            (e) => e.toString().contains('requires IsolatePermission'),
            'a refusal naming IsolatePermission',
          ),
        ),
        reason:
            'this tree declared IsolatePermission and consulted it nowhere. A '
            'downloaded bundle could reach the isolate API with the embedder '
            'granting nothing',
      );
    });

    test('F-SCE166-2: granting IsolatePermission admits it [2026-09-23]', () {
      final runner = D4rtRunner()..grant(IsolatePermission.any);
      expect(
        _run(runner, 'dart:isolate'),
        1,
        reason:
            'the gate must be a gate and not a wall — a granted capability has '
            'to work, or embedders route around the permission system',
      );
    });

    test('F-SCE166-3: `dart:io` is refused without FilesystemPermission '
        '[2026-09-23]', () {
      // The same method on the reference line guards both, and this tree was
      // missing both. Measured before the fix: `dart:io` was admitted too.
      expect(
        () => _run(D4rtRunner(), 'dart:io'),
        throwsA(
          predicate(
            (e) => e.toString().contains('requires FilesystemPermission'),
            'a refusal naming FilesystemPermission',
          ),
        ),
      );
    });

    test(
      'F-SCE166-4: granting FilesystemPermission admits it [2026-09-23]',
      () {
        final runner = D4rtRunner()..grant(FilesystemPermission.any);
        expect(_run(runner, 'dart:io'), 1);
      },
    );

    test(
      'F-SCE166-5 (control): an ungated import still loads [2026-09-23]',
      () {
        // Without this, a gate that refused EVERY `dart:` import would pass all
        // four cases above while breaking every script in the corpus.
        expect(
          _run(D4rtRunner(), 'dart:math'),
          1,
          reason:
              'only the two libraries the reference line names are gated; a '
              'blanket refusal is a different defect wearing the same green',
        );
      },
    );
  });
}
