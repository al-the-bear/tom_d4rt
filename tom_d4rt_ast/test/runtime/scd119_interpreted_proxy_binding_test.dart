// SCD119/AST — a native proxy standing in for an interpreted instance binds to
// a parameter declared as the script's own class, in the analyzer-free tree.
//
// THE MIRROR OF `tom_d4rt/test/bridge/scd119_interpreted_proxy_binding_test.dart`,
// AND THE ONE THAT MATTERS. The defect was found in the flutter corpus, which
// runs on THIS interpreter: a script declaring
// `class BrandColors extends ThemeExtension<BrandColors>` hands Flutter a
// registered `D4InterpretedProxy`, and passing that value back to a script
// function declared `Widget brandPreview(BrandColors brand)` was rejected with
//
//     type 'ThemeExtension' is not a subtype of type 'BrandColors' of 'brand'
//
// while every member access on the same value worked. The reference tree can
// run source, so it covers four cases cheaply; this package interprets
// pre-parsed `SAstNode` trees and every case is a bundle built by hand, so it
// carries the claim and its one load-bearing control.
//
// CONTROL, measured by reverting the `bind` retry: `+1 -1`. F-SCD119-AST-1
// fails with the message above; F-SCD119-AST-2 passes either way and is a RAIL
// rather than a witness — it stops the repair from becoming "unwrap and accept
// anything", which is the only way a fix of this shape goes wrong.
//
// WHY THE FIX IS NOT IN `getRuntimeType`. Teaching the environment to see
// through every proxy is the more correct model and a far larger blast radius:
// it changes what `is`, `as` and `runtimeType` answer for every proxied widget
// in a live tree. Cluster 25 was reverted in April for exactly that kind of
// reach on the dispatch path. The retry runs only after the check has ALREADY
// failed, so it can remove a rejection but never add one.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// The native base a bridge is registered for — `ThemeExtension`'s stand-in.
class NativeShape {
  const NativeShape();
}

/// What `D4.registerInterfaceProxy` produces: a real native subtype carrying
/// the interpreted instance it stands for.
///
/// The name is not arbitrary, and since SCD132 neither is the mapping. A native
/// value is mapped back to a bridge by `Environment.toBridgedClass`; its prefix
/// fallback used to claim any bridge whose name prefixed the native type name,
/// which is how `_InterpretedThemeExtension` resolves to `ThemeExtension` in
/// the corpus and how `ShapeProxy` used to resolve here. That rule now requires
/// the bridge to DECLARE the type in `nativeNames`, which this one does.
///
/// The trap is now closed from both ends: rename this `_ShapeProxy` and the
/// lookup still misses, so the file would pass for a reason unrelated to the
/// fix — and drop the `nativeNames` line and it fails outright rather than
/// resolving by accident.
class ShapeProxy extends NativeShape implements D4InterpretedProxy {
  ShapeProxy(this._instance);
  final Object _instance;

  @override
  Object get d4rtInstance => _instance;
}

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: 0, name: name);

SNamedType _type(String name) =>
    SNamedType(offset: 0, length: 0, name: _id(name));

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

/// The native round-trip: hand it the interpreted instance, get the proxy that
/// stands for it. IDEMPOTENT, like the real proxy factories — a proxy is made
/// from an `InterpretedInstance`, never from another proxy.
Object? _wrap(
  InterpreterVisitor visitor,
  List<Object?> positional,
  Map<String, Object?> named,
  List<RuntimeType>? typeArgs,
) {
  final value = positional[0];
  return value is ShapeProxy ? value : ShapeProxy(value as Object);
}

/// A bundle for
///
///     class <declared> extends Shape { <declared>(); int size() => 7; }
///     int take(<param> s) => s.size();
///     main() => take(Shape.wrap(<declared>()));
///
/// [declared] is the class the instance really is; [param] is what `take`
/// declares. Passing the same name is the claim; passing a different one is the
/// control.
AstBundle proxyBundle({required String declared, required String param}) {
  const entry = 'package:probe/main.dart';

  SClassDeclaration shapeSubclass(String name) => SClassDeclaration(
    offset: 0,
    length: 0,
    name: _id(name),
    extendsClause: SExtendsClause(
      offset: 0,
      length: 0,
      superclass: _type('Shape'),
    ),
    members: [
      // Explicit, because a hand-built bundle is not a generated one: nothing
      // here synthesises the unnamed constructor that source omits.
      SConstructorDeclaration(
        offset: 0,
        length: 0,
        returnType: _id(name),
        parameters: _noParams(),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(offset: 0, length: 0, statements: const []),
        ),
      ),
      SMethodDeclaration(
        offset: 0,
        length: 0,
        name: _id('size'),
        returnType: _type('int'),
        parameters: _noParams(),
        body: SExpressionFunctionBody(
          offset: 0,
          length: 0,
          expression: SIntegerLiteral(offset: 0, length: 0, value: 7),
        ),
      ),
    ],
  );

  final takeFn = SFunctionDeclaration(
    offset: 0,
    length: 0,
    name: _id('take'),
    returnType: _type('int'),
    functionExpression: SFunctionExpression(
      offset: 0,
      length: 0,
      parameters: SFormalParameterList(
        offset: 0,
        length: 0,
        parameters: [
          SSimpleFormalParameter(
            offset: 0,
            length: 0,
            name: _id('s'),
            type: _type(param),
            isPositional: true,
          ),
        ],
      ),
      body: SExpressionFunctionBody(
        offset: 0,
        length: 0,
        expression: SMethodInvocation(
          offset: 0,
          length: 0,
          target: _id('s'),
          operator: '.',
          methodName: _id('size'),
          argumentList: _args(),
        ),
      ),
    ),
  );

  final mainFn = SFunctionDeclaration(
    offset: 0,
    length: 0,
    name: _id('main'),
    functionExpression: SFunctionExpression(
      offset: 0,
      length: 0,
      parameters: _noParams(),
      body: SExpressionFunctionBody(
        offset: 0,
        length: 0,
        expression: SMethodInvocation(
          offset: 0,
          length: 0,
          methodName: _id('take'),
          argumentList: _args([
            SMethodInvocation(
              offset: 0,
              length: 0,
              target: _id('Shape'),
              operator: '.',
              methodName: _id('wrap'),
              argumentList: _args([
                SInstanceCreationExpression(
                  offset: 0,
                  length: 0,
                  constructorName: SConstructorName(
                    offset: 0,
                    length: 0,
                    type: _type(declared),
                  ),
                  argumentList: _args(),
                ),
              ]),
            ),
          ]),
        ),
      ),
    ),
  );

  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: [
          shapeSubclass(declared),
          if (param != declared) shapeSubclass(param),
          takeFn,
          mainFn,
        ],
      ),
    },
  );
}

D4rtRunner runnerWithShape() => D4rtRunner()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: NativeShape,
      name: 'Shape',
      // SCD132: declared, not guessed. `toBridgedClass`'s prefix fallback
      // used to resolve `ShapeProxy` to this bridge on the shared name
      // alone; it now requires the bridge to say so. Remove this line and
      // the two cases below fail with "No registered bridged class found".
      nativeNames: const ['ShapeProxy'],
      constructors: {'': (visitor, positional, named) => const NativeShape()},
      staticMethods: {'wrap': _wrap},
    ),
    'package:probe/shape.dart',
    sourceUri: 'package:probe/shape.dart',
  );

void main() {
  group('SCD119/AST: a D4InterpretedProxy binds as the class it stands for', () {
    test('F-SCD119-AST-1: a proxy binds to a parameter declared as the script '
        'class it wraps [2026-09-14]', () {
      expect(
        runnerWithShape().executeBundleAs<Object?>(
          proxyBundle(declared: 'MyShape', param: 'MyShape'),
        ),
        equals(7),
      );
    });

    test(
      'F-SCD119-AST-2 (control): a proxy does NOT bind to an unrelated script '
      'class [2026-09-14]',
      () {
        // Same machinery, wrong declared class. If this passes, the retry has
        // stopped being a type check and become an unwrap-and-accept.
        expect(
          () => runnerWithShape().executeBundleAs<Object?>(
            proxyBundle(declared: 'MyShape', param: 'OtherShape'),
          ),
          throwsA(
            predicate(
              (e) => e.toString().contains('is not a subtype of type'),
              'a subtype rejection naming the declared type',
            ),
          ),
        );
      },
    );
  });
}
