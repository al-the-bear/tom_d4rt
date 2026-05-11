// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
//
// =============================================================================
//  Visual Deep Demo: Dart Class Metadata & Runtime Inspection
// =============================================================================
//  Subject: Dart language facilities for class introspection at runtime —
//           runtimeType, Type, is / as, identical, mixins, sealed-class style
//           discriminators, Object.hashCode / == / toString, and the Flutter
//           foundation DiagnosticableTreeMixin integration.
//
//  This file is a single hand-authored screen. It deliberately holds no state,
//  no async work and no test imports. Everything you see is a pure description
//  tree that walks through the conceptual surface of a Dart *class* from the
//  vantage point of someone who has to write reliable, predictable Flutter code
//  without dart:mirrors. The previous version was a small "Class Metadata
//  Inspection" card; we preserve that intent but blow it open into a full
//  illustrated dossier.
//
//  Sections (top-down):
//    1.  Dossier hero card                      — what is "class metadata" in Dart?
//    2.  Anatomy of Object's class-level surface — Type, runtimeType, is, as,
//                                                  identical, hashCode, ==, toString
//    3.  RuntimeType comparison table            — Container / Row / Column / Text
//    4.  Inheritance & mixin chain diagram       — visual tree of widget chain
//    5.  Recipe: equality                        — == and hashCode with collections
//    6.  Recipe: type checks                     — is and as with Object?
//    7.  Recipe: identical() vs ==               — when two references are *the* same
//    8.  Recipe: Diagnosticable tree node        — debugFillProperties live class
//    9.  Reflection in Flutter: the caveat       — why dart:mirrors is unavailable
//   10.  Comparison: dart:mirrors vs runtime checks
//   11.  Sealed-class style discriminators       — modelling closed type families
//   12.  Common pitfalls                         — Type equality fragility, generics
//   13.  Glossary
//   14.  Recap & footer
//
//  Visuals are hand-drawn with CustomPainter-free, Material-only widgets: boxes,
//  arrows (Container shaped lines), badges, tables, and code blocks. No assets.
//
//  All classes outside build() are plain demonstration classes — no Stateful,
//  no controllers, no async. The DiagnosticableTreeMixin demo class is real and
//  is rendered into the page via toStringDeep() inside a console block.
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Theme tokens — picked to match the surrounding foundation/* demos.
// -----------------------------------------------------------------------------

const Color _ink = Color(0xFF0F172A);
const Color _inkSoft = Color(0xFF334155);
const Color _inkMute = Color(0xFF64748B);
const Color _paper = Color(0xFFF8FAFC);
const Color _paperAlt = Color(0xFFEEF2F7);
const Color _line = Color(0xFFCBD5E1);
const Color _accent = Color(0xFF6366F1); // indigo
const Color _accentAlt = Color(0xFF8B5CF6); // violet
const Color _mint = Color(0xFF10B981);
const Color _amber = Color(0xFFF59E0B);
const Color _rose = Color(0xFFE11D48);
const Color _sky = Color(0xFF0EA5E9);
const Color _teal = Color(0xFF14B8A6);
const Color _slate = Color(0xFF475569);
const Color _consoleBg = Color(0xFF0B1220);
const Color _consoleFg = Color(0xFFE2E8F0);
const Color _consoleAccent = Color(0xFF93C5FD);
const Color _consoleMint = Color(0xFF6EE7B7);
const Color _consoleAmber = Color(0xFFFCD34D);
const Color _consoleRose = Color(0xFFFCA5A5);

const TextStyle _mono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.45,
  color: _consoleFg,
);

const TextStyle _monoInk = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.45,
  color: _ink,
);

const TextStyle _monoSmall = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11,
  height: 1.4,
  color: _inkSoft,
);

const TextStyle _title = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w800,
  color: _ink,
  letterSpacing: -0.4,
);

const TextStyle _subtitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: _inkSoft,
  height: 1.5,
);

const TextStyle _section = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: _ink,
  letterSpacing: -0.2,
);

const TextStyle _label = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: _inkMute,
  letterSpacing: 0.6,
);

const TextStyle _body = TextStyle(
  fontSize: 13.5,
  height: 1.55,
  color: _inkSoft,
);

const TextStyle _bodyStrong = TextStyle(
  fontSize: 13.5,
  height: 1.55,
  color: _ink,
  fontWeight: FontWeight.w600,
);

// -----------------------------------------------------------------------------
// Demonstration classes (plain — no Stateful, no controllers).
// These exist so the page can show real runtimeType / mixin chains.
// -----------------------------------------------------------------------------

/// A simple value-like class that overrides == and hashCode correctly.
class _Point {
  final double x;
  final double y;
  const _Point(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _Point) return false;
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => '_Point($x, $y)';
}

/// A "bad" value class that *does not* override == / hashCode — used to
/// illustrate the pitfall where two structurally-equal instances are not equal.
class _BadPoint {
  final double x;
  final double y;
  const _BadPoint(this.x, this.y);
}

/// Mixin demonstration: a logging contract.
mixin _Logger {
  String get tag => 'Logger';
  String log(String message) => '[$tag] $message';
}

/// Mixin demonstration: a tickable contract.
mixin _Tickable {
  int get tickCount => 0;
}

/// A base shape with abstract area().
abstract class _Shape {
  const _Shape();
  String get name;
  double area();
}

/// A concrete Circle using mixins.
class _Circle extends _Shape with _Logger, _Tickable {
  final double radius;
  const _Circle(this.radius);
  @override
  String get name => 'Circle';
  @override
  String get tag => 'Circle';
  @override
  double area() => 3.141592653589793 * radius * radius;
}

/// A concrete Square using mixins.
class _Square extends _Shape with _Logger {
  final double side;
  const _Square(this.side);
  @override
  String get name => 'Square';
  @override
  String get tag => 'Square';
  @override
  double area() => side * side;
}

/// A concrete Triangle that does not mix in _Logger — used to demonstrate
/// `is _Logger` returning false.
class _Triangle extends _Shape {
  final double base;
  final double height;
  const _Triangle(this.base, this.height);
  @override
  String get name => 'Triangle';
  @override
  double area() => 0.5 * base * height;
}

/// Sealed-class-style discriminator. Dart 3 sealed types let the compiler
/// enforce exhaustiveness. Here we model an Event with closed subclasses.
sealed class _Event {
  const _Event();
}

class _Tap extends _Event {
  final int x;
  final int y;
  const _Tap(this.x, this.y);
}

class _Drag extends _Event {
  final int dx;
  final int dy;
  const _Drag(this.dx, this.dy);
}

class _Release extends _Event {
  const _Release();
}

/// A live DiagnosticableTreeMixin class — rendered into the page using
/// toStringDeep(). This shows the real output of `debugFillProperties` and
/// `debugDescribeChildren`.
class _Node with DiagnosticableTreeMixin {
  _Node(this.name, {this.value = 0, this.children = const []});
  final String name;
  final int value;
  final List<_Node> children;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(IntProperty('value', value));
    properties.add(IntProperty('childCount', children.length));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return <DiagnosticsNode>[
      for (final c in children) c.toDiagnosticsNode(name: c.name),
    ];
  }

  @override
  String toStringShort() => 'Node($name)';
}

// -----------------------------------------------------------------------------
// build() — the entry point. All Flutter widgets returned from here are
// constructed inline; helper widgets are defined as small stateless classes
// at the bottom of the file.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Construct the example node tree used in the Diagnosticable section.
  final _Node tree = _Node(
    'root',
    value: 1,
    children: <_Node>[
      _Node('left', value: 2, children: <_Node>[_Node('left.a', value: 4)]),
      _Node('right', value: 3),
    ],
  );

  final String treeDump = tree.toStringDeep();

  // Concrete widget instances we will inspect.
  final Object cWidget = Container();
  final Object rWidget = Row();
  final Object colWidget = Column();
  const Object tWidget = Text('hello');

  // Value-class equality demo data.
  const _Point p1 = _Point(1, 2);
  const _Point p2 = _Point(1, 2);
  const _Point p3 = _Point(3, 4);
  final _BadPoint b1 = _BadPoint(1, 2);
  final _BadPoint b2 = _BadPoint(1, 2);

  // Build a list of shapes for the type-check recipes.
  final List<_Shape> shapes = <_Shape>[
    const _Circle(2),
    const _Square(3),
    const _Triangle(4, 5),
  ];

  // Build a list of events for the sealed-class recipe.
  final List<_Event> events = <_Event>[
    const _Tap(10, 20),
    const _Drag(3, 5),
    const _Release(),
  ];

  return Scaffold(
    backgroundColor: _paper,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: _ink),
      title: const Text(
        'class — Dart Class Metadata & Runtime Inspection',
        style: TextStyle(
          color: _ink,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, color: _line),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ---- §1 Dossier hero -----------------------------------------------
          const _SectionTag(index: 1, label: 'DOSSIER'),
          const SizedBox(height: 8),
          const _HeroCard(),
          const SizedBox(height: 32),

          // ---- §2 Anatomy ----------------------------------------------------
          const _SectionTag(index: 2, label: 'ANATOMY'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Anatomy of Object — the class-level surface',
            subtitle:
                'Every Dart object inherits a small but powerful surface from '
                'Object. The pieces below are what you actually have at hand '
                'without dart:mirrors: a Type token, a runtimeType getter, '
                'three operators (==, is, as), a primitive identical() check, '
                'a hashCode contract, and the toString() fallback.',
          ),
          const SizedBox(height: 12),
          const _AnatomyGrid(),
          const SizedBox(height: 32),

          // ---- §3 Runtime type table -----------------------------------------
          const _SectionTag(index: 3, label: 'RUNTIME TYPES'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'runtimeType across familiar Widget subclasses',
            subtitle:
                'runtimeType returns a Type token that *names* the concrete '
                'class of an instance. The table below compares four common '
                'Material widgets. Notice that runtimeType for a const Text is '
                'still Text — `const` does not change the class.',
          ),
          const SizedBox(height: 12),
          _RuntimeTypeTable(
            rows: <_RuntimeTypeRow>[
              _RuntimeTypeRow(
                instance: 'Container()',
                runtimeTypeName: cWidget.runtimeType.toString(),
                chain: <String>[
                  'Container',
                  'StatelessWidget',
                  'Widget',
                  'DiagnosticableTree',
                  'Diagnosticable',
                  'Object',
                ],
                isWidget: cWidget is Widget,
                isStateless: cWidget is StatelessWidget,
                color: _sky,
              ),
              _RuntimeTypeRow(
                instance: 'Row()',
                runtimeTypeName: rWidget.runtimeType.toString(),
                chain: <String>[
                  'Row',
                  'Flex',
                  'MultiChildRenderObjectWidget',
                  'RenderObjectWidget',
                  'Widget',
                  'Object',
                ],
                isWidget: rWidget is Widget,
                isStateless: rWidget is StatelessWidget,
                color: _mint,
              ),
              _RuntimeTypeRow(
                instance: 'Column()',
                runtimeTypeName: colWidget.runtimeType.toString(),
                chain: <String>[
                  'Column',
                  'Flex',
                  'MultiChildRenderObjectWidget',
                  'RenderObjectWidget',
                  'Widget',
                  'Object',
                ],
                isWidget: colWidget is Widget,
                isStateless: colWidget is StatelessWidget,
                color: _accent,
              ),
              _RuntimeTypeRow(
                instance: "Text('hello')",
                runtimeTypeName: tWidget.runtimeType.toString(),
                chain: <String>[
                  'Text',
                  'StatelessWidget',
                  'Widget',
                  'DiagnosticableTree',
                  'Diagnosticable',
                  'Object',
                ],
                isWidget: tWidget is Widget,
                isStateless: tWidget is StatelessWidget,
                color: _amber,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // ---- §4 Inheritance & mixin chain diagram --------------------------
          const _SectionTag(index: 4, label: 'INHERITANCE'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Inheritance & mixin chain diagram',
            subtitle:
                'In Dart, a class has *one* superclass, zero-or-more mixins '
                '(applied in order) and zero-or-more interfaces (via the '
                'implements clause). The diagram below shows how _Circle '
                'composes _Shape, _Logger and _Tickable.',
          ),
          const SizedBox(height: 12),
          const _InheritanceDiagram(),
          const SizedBox(height: 32),

          // ---- §5 Equality recipe --------------------------------------------
          const _SectionTag(index: 5, label: 'RECIPE'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Recipe — equality with == and hashCode',
            subtitle:
                'Two structurally-equal _Point instances are equal because we '
                'overrode == and hashCode. Two _BadPoint instances are *not* '
                'equal because the default Object.== is reference equality. '
                'This matters the moment your value lands in a Set or a Map.',
          ),
          const SizedBox(height: 12),
          _EqualityRecipe(
            p1: p1,
            p2: p2,
            p3: p3,
            b1: b1,
            b2: b2,
          ),
          const SizedBox(height: 32),

          // ---- §6 Type-check recipe ------------------------------------------
          const _SectionTag(index: 6, label: 'RECIPE'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Recipe — type checks: is and as on Object?',
            subtitle:
                'The `is` operator returns a boolean and promotes the variable '
                'to the checked type inside the branch. `as` is a cast — it '
                'throws TypeError if the cast fails. Below we walk a list of '
                '_Shape and inspect each one.',
          ),
          const SizedBox(height: 12),
          _TypeCheckRecipe(shapes: shapes),
          const SizedBox(height: 32),

          // ---- §7 identical() vs == ------------------------------------------
          const _SectionTag(index: 7, label: 'RECIPE'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Recipe — identical() vs ==',
            subtitle:
                'identical(a, b) is *reference* equality. It never calls user '
                'code and is therefore extremely fast and predictable. == is '
                'whatever the class defines. For const values, identical may '
                'return true because the compiler canonicalises them.',
          ),
          const SizedBox(height: 12),
          const _IdenticalRecipe(),
          const SizedBox(height: 32),

          // ---- §8 Diagnosticable tree recipe ---------------------------------
          const _SectionTag(index: 8, label: 'RECIPE'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Recipe — DiagnosticableTreeMixin in 30 lines',
            subtitle:
                'A class can opt into the Flutter inspector by mixing in '
                'DiagnosticableTreeMixin and overriding debugFillProperties / '
                'debugDescribeChildren. The dump below is the *real* output '
                'of toStringDeep() on the _Node tree built at the top of build().',
          ),
          const SizedBox(height: 12),
          _DiagnosticableRecipe(treeDump: treeDump),
          const SizedBox(height: 32),

          // ---- §9 Reflection caveat ------------------------------------------
          const _SectionTag(index: 9, label: 'CAVEAT'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Reflection in Flutter — the dart:mirrors caveat',
            subtitle:
                'dart:mirrors is *unavailable* in Flutter and in AOT-compiled '
                'Dart in general. Tree-shaking and code size are the trade-off. '
                'What you have instead is runtime type checks, code generation '
                '(build_runner) and the bridge generators from this very repo.',
          ),
          const SizedBox(height: 12),
          const _ReflectionCaveat(),
          const SizedBox(height: 32),

          // ---- §10 Comparison: mirrors vs runtime checks ---------------------
          const _SectionTag(index: 10, label: 'COMPARISON'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Comparison — dart:mirrors vs runtime checks vs codegen',
            subtitle:
                'Three different answers to the same question: "what is this '
                'object?". The table picks the right answer for each context.',
          ),
          const SizedBox(height: 12),
          const _MirrorsComparison(),
          const SizedBox(height: 32),

          // ---- §11 Sealed-class discriminators -------------------------------
          const _SectionTag(index: 11, label: 'SEALED'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Sealed-class style discriminators',
            subtitle:
                'Dart 3 introduced sealed classes — closed type families '
                'whose subclasses must live in the same library. The compiler '
                'enforces exhaustiveness when you switch over them. This is '
                'the modern alternative to manual enum-plus-payload tricks.',
          ),
          const SizedBox(height: 12),
          _SealedRecipe(events: events),
          const SizedBox(height: 32),

          // ---- §12 Pitfalls --------------------------------------------------
          const _SectionTag(index: 12, label: 'PITFALLS'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Common pitfalls',
            subtitle:
                'Class metadata at runtime is sharper than it looks. The '
                'pitfalls below have all bitten real Flutter code bases.',
          ),
          const SizedBox(height: 12),
          const _PitfallsList(),
          const SizedBox(height: 32),

          // ---- §13 Glossary --------------------------------------------------
          const _SectionTag(index: 13, label: 'GLOSSARY'),
          const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Glossary',
            subtitle:
                'Short definitions of the terms used in the previous sections.',
          ),
          const SizedBox(height: 12),
          const _Glossary(),
          const SizedBox(height: 32),

          // ---- §14 Recap -----------------------------------------------------
          const _SectionTag(index: 14, label: 'RECAP'),
          const SizedBox(height: 8),
          const _Recap(),
          const SizedBox(height: 24),
          const _Footer(),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// _SectionTag — small "01 / DOSSIER" pill above every section header.
// -----------------------------------------------------------------------------

class _SectionTag extends StatelessWidget {
  final int index;
  final String label;
  const _SectionTag({required this.index, required this.label});

  @override
  Widget build(BuildContext context) {
    final String paddedIndex = index.toString().padLeft(2, '0');
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _accent.withOpacity(0.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: _accent.withOpacity(0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                paddedIndex,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: _accent,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(width: 8),
              Container(width: 1, height: 12, color: _accent.withOpacity(0.4)),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: _accent,
                  letterSpacing: 0.9,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// _SectionHeader — title + subtitle pair used at the top of every section.
// -----------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: _section),
        const SizedBox(height: 6),
        Text(subtitle, style: _subtitle),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// _HeroCard — §1, big dossier-style introduction.
// -----------------------------------------------------------------------------

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _line),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _ink.withOpacity(0.04),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[_accent, _accentAlt],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.class_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Dart Class Metadata',
                      style: _title,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Runtime inspection without dart:mirrors',
                      style: _subtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: _line),
          const SizedBox(height: 20),
          const Text(
            'In Dart, a class is the unit of code organisation, the unit of '
            'identity for the type system, and the carrier of behaviour for '
            'every value that is not null. At runtime you do not get a full '
            'reflective view of a class — Dart trades that flexibility for '
            'aggressive AOT compilation and tree-shaking. What you do get is '
            'a tiny but precise surface: a Type token, a runtimeType getter, '
            'two operators (is, as), a privileged identical() check, and the '
            'Object protocol (==, hashCode, toString).',
            style: _body,
          ),
          const SizedBox(height: 12),
          const Text(
            'This page treats that surface as a dossier: every facet has a '
            'cell, every recipe has a code block, and every pitfall has a '
            'concrete example.',
            style: _body,
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _HeroPill(
                icon: Icons.fingerprint,
                label: 'runtimeType',
                color: _accent,
              ),
              const SizedBox(width: 8),
              _HeroPill(icon: Icons.checklist, label: 'is / as', color: _mint),
              const SizedBox(width: 8),
              _HeroPill(
                icon: Icons.balance,
                label: '== / hashCode',
                color: _amber,
              ),
              const SizedBox(width: 8),
              _HeroPill(
                icon: Icons.account_tree_outlined,
                label: 'mixins',
                color: _accentAlt,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _HeroPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _AnatomyGrid — §2, grid of cards explaining each piece of Object's surface.
// -----------------------------------------------------------------------------

class _AnatomyGrid extends StatelessWidget {
  const _AnatomyGrid();

  @override
  Widget build(BuildContext context) {
    const List<_AnatomyEntry> entries = <_AnatomyEntry>[
      _AnatomyEntry(
        icon: Icons.fingerprint,
        title: 'runtimeType',
        signature: 'Type get runtimeType',
        body:
            'Returns a Type token naming the concrete class of the receiver. '
            'Cannot be used to discover fields, methods or annotations.',
        color: _accent,
      ),
      _AnatomyEntry(
        icon: Icons.token,
        title: 'Type',
        signature: 'class Type',
        body:
            'Reified handle to a type. Comparable for equality, useful as a '
            'Map key. Cannot be instantiated and has no public surface.',
        color: _accentAlt,
      ),
      _AnatomyEntry(
        icon: Icons.rule,
        title: 'is',
        signature: 'expr is T  ->  bool',
        body:
            'Tests whether the runtime type of expr is a subtype of T. '
            'Inside the true branch the analyzer promotes expr to T.',
        color: _mint,
      ),
      _AnatomyEntry(
        icon: Icons.swap_horiz,
        title: 'as',
        signature: 'expr as T  ->  T',
        body:
            'Cast. If the runtime check fails, throws TypeError. Use only when '
            'you have a stronger external invariant than the type system.',
        color: _amber,
      ),
      _AnatomyEntry(
        icon: Icons.compare_arrows,
        title: 'identical()',
        signature: 'bool identical(Object? a, Object? b)',
        body:
            'Top-level function — reference equality. Never calls user code, '
            'so it is the cheapest possible comparison.',
        color: _sky,
      ),
      _AnatomyEntry(
        icon: Icons.balance,
        title: '==',
        signature: 'bool operator ==(Object other)',
        body:
            'User-overridable equality. Contract: reflexive, symmetric, '
            'transitive, consistent with hashCode. Must accept Object.',
        color: _teal,
      ),
      _AnatomyEntry(
        icon: Icons.tag,
        title: 'hashCode',
        signature: 'int get hashCode',
        body:
            'Hash for use in Set / Map. Must be equal for two values that '
            'compare ==. Object.hash() and Object.hashAll() help.',
        color: _rose,
      ),
      _AnatomyEntry(
        icon: Icons.text_fields,
        title: 'toString()',
        signature: 'String toString()',
        body:
            'Debug-only string. Default is "Instance of ClassName". '
            'Override for log readability; never parse the output.',
        color: _slate,
      ),
    ];
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints constraints) {
        final int columns = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 640
                ? 2
                : 1;
        final double spacing = 12;
        final double itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: <Widget>[
            for (final _AnatomyEntry e in entries)
              SizedBox(
                width: itemWidth,
                child: _AnatomyCard(entry: e),
              ),
          ],
        );
      },
    );
  }
}

class _AnatomyEntry {
  final IconData icon;
  final String title;
  final String signature;
  final String body;
  final Color color;
  const _AnatomyEntry({
    required this.icon,
    required this.title,
    required this.signature,
    required this.body,
    required this.color,
  });
}

class _AnatomyCard extends StatelessWidget {
  final _AnatomyEntry entry;
  const _AnatomyCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: entry.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(entry.icon, color: entry.color, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  entry.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _paperAlt,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _line),
            ),
            child: Text(entry.signature, style: _monoInk),
          ),
          const SizedBox(height: 10),
          Text(entry.body, style: _body),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _RuntimeTypeRow + _RuntimeTypeTable — §3
// -----------------------------------------------------------------------------

class _RuntimeTypeRow {
  final String instance;
  final String runtimeTypeName;
  final List<String> chain;
  final bool isWidget;
  final bool isStateless;
  final Color color;
  const _RuntimeTypeRow({
    required this.instance,
    required this.runtimeTypeName,
    required this.chain,
    required this.isWidget,
    required this.isStateless,
    required this.color,
  });
}

class _RuntimeTypeTable extends StatelessWidget {
  final List<_RuntimeTypeRow> rows;
  const _RuntimeTypeTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      child: Column(
        children: <Widget>[
          // Header row.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: _paperAlt,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  flex: 3,
                  child: Text('Instance', style: _label),
                ),
                Expanded(
                  flex: 3,
                  child: Text('runtimeType', style: _label),
                ),
                Expanded(
                  flex: 6,
                  child: Text('Inheritance chain (root → Object)', style: _label),
                ),
                SizedBox(width: 90, child: Text('is Widget', style: _label)),
                SizedBox(width: 110, child: Text('is Stateless', style: _label)),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++) ...<Widget>[
            if (i > 0) Container(height: 1, color: _line),
            _RuntimeTypeRowView(row: rows[i]),
          ],
        ],
      ),
    );
  }
}

class _RuntimeTypeRowView extends StatelessWidget {
  final _RuntimeTypeRow row;
  const _RuntimeTypeRowView({required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: row.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(row.instance, style: _monoInk)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: row.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: row.color.withOpacity(0.35)),
              ),
              child: Text(
                row.runtimeTypeName,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: row.color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: <Widget>[
                for (int i = 0; i < row.chain.length; i++) ...<Widget>[
                  _ChainPill(
                    label: row.chain[i],
                    color: row.color,
                    bold: i == 0,
                  ),
                  if (i < row.chain.length - 1)
                    const Icon(Icons.arrow_forward, size: 12, color: _inkMute),
                ],
              ],
            ),
          ),
          SizedBox(
            width: 90,
            child: _BoolDot(value: row.isWidget),
          ),
          SizedBox(
            width: 110,
            child: _BoolDot(value: row.isStateless),
          ),
        ],
      ),
    );
  }
}

class _ChainPill extends StatelessWidget {
  final String label;
  final Color color;
  final bool bold;
  const _ChainPill({required this.label, required this.color, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bold ? color.withOpacity(0.18) : _paperAlt,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: bold ? color.withOpacity(0.45) : _line,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          color: bold ? color : _inkSoft,
        ),
      ),
    );
  }
}

class _BoolDot extends StatelessWidget {
  final bool value;
  const _BoolDot({required this.value});

  @override
  Widget build(BuildContext context) {
    final Color c = value ? _mint : _rose;
    return Row(
      children: <Widget>[
        Icon(
          value ? Icons.check_circle : Icons.cancel,
          color: c,
          size: 14,
        ),
        const SizedBox(width: 6),
        Text(
          value ? 'true' : 'false',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: c,
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// _InheritanceDiagram — §4. Visual tree of _Circle's chain + sibling overview.
// -----------------------------------------------------------------------------

class _InheritanceDiagram extends StatelessWidget {
  const _InheritanceDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Chain for: class _Circle extends _Shape with _Logger, _Tickable',
            style: _bodyStrong,
          ),
          const SizedBox(height: 16),
          // Row of boxes top — Object → _Shape → _Circle (with mixins as side
          // applications).
          _ChainRow(
            nodes: const <_ChainNode>[
              _ChainNode(label: 'Object', color: _slate),
              _ChainNode(label: '_Shape', color: _accent, subtitle: 'abstract'),
              _ChainNode(label: '_Circle', color: _mint, subtitle: 'concrete'),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: _line),
          const SizedBox(height: 16),
          const Text('Applied mixins (in order):', style: _bodyStrong),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              _MixinBox(label: '_Logger', color: _amber),
              const SizedBox(width: 12),
              const Icon(Icons.add, color: _inkMute, size: 18),
              const SizedBox(width: 12),
              _MixinBox(label: '_Tickable', color: _accentAlt),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _paperAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _line),
            ),
            child: const Text(
              'Linearization:\n'
              '  _Circle  →  _Tickable&_Shape&_Logger\n'
              '            →  _Logger&_Shape\n'
              '            →  _Shape\n'
              '            →  Object\n'
              'Each "with" produces a synthetic class in the chain.',
              style: _monoInk,
            ),
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: _line),
          const SizedBox(height: 20),
          const Text('Sibling concrete shapes — same base, different mixins:',
              style: _bodyStrong),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const <Widget>[
              _SiblingCard(
                name: '_Circle',
                base: '_Shape',
                mixins: <String>['_Logger', '_Tickable'],
                color: _mint,
              ),
              _SiblingCard(
                name: '_Square',
                base: '_Shape',
                mixins: <String>['_Logger'],
                color: _amber,
              ),
              _SiblingCard(
                name: '_Triangle',
                base: '_Shape',
                mixins: <String>[],
                color: _rose,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChainNode {
  final String label;
  final Color color;
  final String? subtitle;
  const _ChainNode({required this.label, required this.color, this.subtitle});
}

class _ChainRow extends StatelessWidget {
  final List<_ChainNode> nodes;
  const _ChainRow({required this.nodes});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < nodes.length; i++) ...<Widget>[
          _ChainBox(node: nodes[i]),
          if (i < nodes.length - 1) const _ChainArrow(),
        ],
      ],
    );
  }
}

class _ChainBox extends StatelessWidget {
  final _ChainNode node;
  const _ChainBox({required this.node});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: node.color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: node.color.withOpacity(0.5), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            node.label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: node.color,
            ),
          ),
          if (node.subtitle != null)
            Text(
              node.subtitle!,
              style: const TextStyle(
                fontSize: 10,
                color: _inkMute,
                letterSpacing: 0.4,
              ),
            ),
        ],
      ),
    );
  }
}

class _ChainArrow extends StatelessWidget {
  const _ChainArrow();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: 18, height: 1.5, color: _inkMute),
          const Icon(Icons.arrow_right, size: 18, color: _inkMute),
        ],
      ),
    );
  }
}

class _MixinBox extends StatelessWidget {
  final String label;
  final Color color;
  const _MixinBox({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.5),
          style: BorderStyle.solid,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.extension_outlined, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: color.withOpacity(0.20),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              'mixin',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SiblingCard extends StatelessWidget {
  final String name;
  final String base;
  final List<String> mixins;
  final Color color;
  const _SiblingCard({
    required this.name,
    required this.base,
    required this.mixins,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text('extends $base', style: _monoSmall),
          const SizedBox(height: 4),
          if (mixins.isEmpty)
            const Text('with (none)', style: _monoSmall)
          else
            Text('with ${mixins.join(', ')}', style: _monoSmall),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _EqualityRecipe — §5
// -----------------------------------------------------------------------------

class _EqualityRecipe extends StatelessWidget {
  final _Point p1;
  final _Point p2;
  final _Point p3;
  final _BadPoint b1;
  final _BadPoint b2;
  const _EqualityRecipe({
    required this.p1,
    required this.p2,
    required this.p3,
    required this.b1,
    required this.b2,
  });

  @override
  Widget build(BuildContext context) {
    // Compute the live results.
    final bool p1EqP2 = p1 == p2;
    final bool p1EqP3 = p1 == p3;
    final bool b1EqB2 = b1 == b2;
    final int p1Hash = p1.hashCode;
    final int p2Hash = p2.hashCode;
    final int p3Hash = p3.hashCode;
    final int b1Hash = b1.hashCode;
    final int b2Hash = b2.hashCode;
    final Set<_Point> pointSet = <_Point>{p1, p2, p3};
    final Set<_BadPoint> badSet = <_BadPoint>{b1, b2};
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _CodeBlock(
            code: '''
class _Point {
  final double x, y;
  const _Point(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _Point) return false;
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => Object.hash(x, y);
}''',
          ),
          const SizedBox(height: 14),
          _ResultGrid(
            rows: <_ResultRow>[
              _ResultRow(
                expression: 'p1 == p2  // _Point(1,2) == _Point(1,2)',
                value: p1EqP2.toString(),
                ok: p1EqP2,
              ),
              _ResultRow(
                expression: 'p1 == p3  // _Point(1,2) == _Point(3,4)',
                value: p1EqP3.toString(),
                ok: !p1EqP3,
              ),
              _ResultRow(
                expression: 'b1 == b2  // _BadPoint without override',
                value: b1EqB2.toString(),
                ok: false,
              ),
              _ResultRow(
                expression: 'p1.hashCode == p2.hashCode',
                value: (p1Hash == p2Hash).toString(),
                ok: p1Hash == p2Hash,
              ),
              _ResultRow(
                expression: '{p1, p2, p3}.length',
                value: pointSet.length.toString(),
                ok: pointSet.length == 2,
              ),
              _ResultRow(
                expression: '{b1, b2}.length  // bad — keeps both',
                value: badSet.length.toString(),
                ok: badSet.length == 1,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _Callout(
            tone: _CalloutTone.tip,
            title: 'Why == must be symmetric',
            body: 'If a == b is true but b == a is false, your value will '
                'silently misbehave in Set, Map, and listEquals. The first '
                'line of operator == should always be a type guard.',
          ),
        ],
      ),
    );
  }
}

class _ResultRow {
  final String expression;
  final String value;
  final bool ok;
  const _ResultRow({
    required this.expression,
    required this.value,
    required this.ok,
  });
}

class _ResultGrid extends StatelessWidget {
  final List<_ResultRow> rows;
  const _ResultGrid({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _paperAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _line),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++) ...<Widget>[
            if (i > 0) Container(height: 1, color: _line),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Text(rows[i].expression, style: _monoInk),
                  ),
                  const Icon(Icons.arrow_right_alt,
                      size: 14, color: _inkMute),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (rows[i].ok ? _mint : _rose).withOpacity(0.14),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: (rows[i].ok ? _mint : _rose).withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      rows[i].value,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: rows[i].ok ? _mint : _rose,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _consoleBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(code, style: _mono),
    );
  }
}

enum _CalloutTone { tip, warn, info }

class _Callout extends StatelessWidget {
  final _CalloutTone tone;
  final String title;
  final String body;
  const _Callout({
    required this.tone,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final Color c = switch (tone) {
      _CalloutTone.tip => _mint,
      _CalloutTone.warn => _rose,
      _CalloutTone.info => _sky,
    };
    final IconData icon = switch (tone) {
      _CalloutTone.tip => Icons.lightbulb_outline,
      _CalloutTone.warn => Icons.warning_amber_outlined,
      _CalloutTone.info => Icons.info_outline,
    };
    return Container(
      decoration: BoxDecoration(
        color: c.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.withOpacity(0.35)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: c, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: c,
                  ),
                ),
                const SizedBox(height: 4),
                Text(body, style: _body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _TypeCheckRecipe — §6
// -----------------------------------------------------------------------------

class _TypeCheckRecipe extends StatelessWidget {
  final List<_Shape> shapes;
  const _TypeCheckRecipe({required this.shapes});

  @override
  Widget build(BuildContext context) {
    final List<_TypeCheckEntry> entries = <_TypeCheckEntry>[];
    for (final _Shape shape in shapes) {
      final Object s = shape;
      entries.add(
        _TypeCheckEntry(
          subject: shape.name,
          subjectRuntimeType: s.runtimeType.toString(),
          checks: <_TypeCheckBit>[
            _TypeCheckBit('is _Shape', s is _Shape),
            _TypeCheckBit('is _Circle', s is _Circle),
            _TypeCheckBit('is _Square', s is _Square),
            _TypeCheckBit('is _Triangle', s is _Triangle),
            _TypeCheckBit('is _Logger', s is _Logger),
            _TypeCheckBit('is _Tickable', s is _Tickable),
          ],
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _CodeBlock(
            code: '''
String describe(_Shape s) {
  if (s is _Circle) return 'Circle r=\${s.radius}';
  if (s is _Square) return 'Square s=\${s.side}';
  if (s is _Triangle) return 'Tri b=\${s.base}';
  return 'unknown';
}

// `as` cast — throws if the runtime type does not match.
final _Circle c = shapes.first as _Circle;''',
          ),
          const SizedBox(height: 12),
          for (final _TypeCheckEntry e in entries) ...<Widget>[
            _TypeCheckEntryView(entry: e),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 4),
          _Callout(
            tone: _CalloutTone.warn,
            title: 'as throws — prefer pattern matching',
            body: 'Use `if (x case Circle c)` (Dart 3 pattern) or `if (x is '
                'Circle)` rather than `x as Circle`. A failed cast is a '
                'TypeError, not a checked exception.',
          ),
        ],
      ),
    );
  }
}

class _TypeCheckBit {
  final String label;
  final bool value;
  const _TypeCheckBit(this.label, this.value);
}

class _TypeCheckEntry {
  final String subject;
  final String subjectRuntimeType;
  final List<_TypeCheckBit> checks;
  const _TypeCheckEntry({
    required this.subject,
    required this.subjectRuntimeType,
    required this.checks,
  });
}

class _TypeCheckEntryView extends StatelessWidget {
  final _TypeCheckEntry entry;
  const _TypeCheckEntryView({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _paperAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.account_tree_outlined,
                  color: _accent, size: 16),
              const SizedBox(width: 6),
              Text(entry.subject,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                  )),
              const SizedBox(width: 8),
              Text(
                'runtimeType=${entry.subjectRuntimeType}',
                style: _monoSmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: <Widget>[
              for (final _TypeCheckBit b in entry.checks)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (b.value ? _mint : _rose).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: (b.value ? _mint : _rose).withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        b.value ? Icons.check : Icons.close,
                        size: 12,
                        color: b.value ? _mint : _rose,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        b.label,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: b.value ? _mint : _rose,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _IdenticalRecipe — §7
// -----------------------------------------------------------------------------

class _IdenticalRecipe extends StatelessWidget {
  const _IdenticalRecipe();

  @override
  Widget build(BuildContext context) {
    const _Point a = _Point(1, 2);
    const _Point b = _Point(1, 2);
    final _Point c = _Point(1.0, 2.0);
    final _Point d = a;
    final bool ia = identical(a, b);
    final bool ic = identical(a, c);
    final bool id = identical(a, d);
    final bool eq = a == c;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _CodeBlock(
            code: '''
const _Point a = _Point(1, 2);
const _Point b = _Point(1, 2); // canonicalised
final _Point c = _Point(1, 2); // fresh instance
final _Point d = a;            // alias

identical(a, b); // true  — const canonicalisation
identical(a, c); // false — different reference
identical(a, d); // true  — same reference
a == c;          // true  — structural equality''',
          ),
          const SizedBox(height: 14),
          _ResultGrid(
            rows: <_ResultRow>[
              _ResultRow(
                expression: 'identical(a, b)  // both const _Point(1,2)',
                value: ia.toString(),
                ok: ia,
              ),
              _ResultRow(
                expression: 'identical(a, c)  // c constructed at runtime',
                value: ic.toString(),
                ok: !ic,
              ),
              _ResultRow(
                expression: 'identical(a, d)  // d = a',
                value: id.toString(),
                ok: id,
              ),
              _ResultRow(
                expression: 'a == c           // structurally equal',
                value: eq.toString(),
                ok: eq,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _Callout(
            tone: _CalloutTone.info,
            title: 'When to reach for identical()',
            body: 'In hot paths (Widget.canUpdate, Listenable equality, '
                'memoisation): identical() is O(1) and side-effect-free. '
                'Use == when you actually care about value equality.',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _DiagnosticableRecipe — §8
// -----------------------------------------------------------------------------

class _DiagnosticableRecipe extends StatelessWidget {
  final String treeDump;
  const _DiagnosticableRecipe({required this.treeDump});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _CodeBlock(
            code: '''
class _Node with DiagnosticableTreeMixin {
  _Node(this.name, {this.value = 0, this.children = const []});
  final String name;
  final int value;
  final List<_Node> children;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder p) {
    super.debugFillProperties(p);
    p.add(StringProperty('name', name));
    p.add(IntProperty('value', value));
    p.add(IntProperty('childCount', children.length));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() => <DiagnosticsNode>[
        for (final c in children) c.toDiagnosticsNode(name: c.name),
      ];

  @override
  String toStringShort() => 'Node(\$name)';
}''',
          ),
          const SizedBox(height: 14),
          const Text('Live toStringDeep() output:', style: _bodyStrong),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _consoleBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(treeDump, style: _mono),
          ),
          const SizedBox(height: 14),
          _Callout(
            tone: _CalloutTone.tip,
            title: 'The inspector calls this for you',
            body: 'When a widget is selected in DevTools, the inspector calls '
                'toDiagnosticsNode() to build the property panel. Mixing in '
                'DiagnosticableTreeMixin is the cheapest way to make your '
                'domain objects first-class citizens there.',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _ReflectionCaveat — §9
// -----------------------------------------------------------------------------

class _ReflectionCaveat extends StatelessWidget {
  const _ReflectionCaveat();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'In a Flutter app you cannot:',
            style: _bodyStrong,
          ),
          const SizedBox(height: 8),
          const _BulletList(items: <String>[
            'Enumerate the fields of a class.',
            'Look up a method by name and invoke it.',
            'Read annotations at runtime.',
            'Discover subclasses of a base class.',
            'Construct an instance from a Type token.',
          ]),
          const SizedBox(height: 12),
          const Text('In a Flutter app you *can*:', style: _bodyStrong),
          const SizedBox(height: 8),
          const _BulletList(items: <String>[
            'Use `is` and `as` against any type the compiler can see.',
            'Compare runtimeType for equality (with caveats — see §12).',
            'Override == / hashCode / toString to make values inspectable.',
            'Use DiagnosticableTreeMixin to expose properties to DevTools.',
            'Generate reflective metadata at build time via build_runner.',
          ]),
          const SizedBox(height: 12),
          _Callout(
            tone: _CalloutTone.warn,
            title: 'Why Flutter omits mirrors',
            body: 'dart:mirrors prevents tree-shaking — the compiler has to '
                'assume any class could be queried, so it must keep every '
                'method symbol. That alone would multiply binary size. AOT '
                'Dart on iOS / web / desktop simply does not ship mirrors.',
          ),
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final String s in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 7, right: 8),
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: _accent,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(child: Text(s, style: _body)),
              ],
            ),
          ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// _MirrorsComparison — §10
// -----------------------------------------------------------------------------

class _MirrorsComparison extends StatelessWidget {
  const _MirrorsComparison();

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>['Capability', 'dart:mirrors', 'is / as / runtimeType', 'codegen'],
      <String>[
        'List fields of a class',
        'yes',
        'no',
        'yes (with @JsonSerializable etc.)'
      ],
      <String>[
        'Invoke method by name',
        'yes',
        'no',
        'yes (generated dispatch table)'
      ],
      <String>[
        'Test if x is a T',
        'yes',
        'yes (preferred)',
        'yes'
      ],
      <String>[
        'Read annotations',
        'yes',
        'no',
        'yes (build-time)'
      ],
      <String>[
        'Discover all subclasses',
        'yes',
        'no',
        'yes (sealed classes for closed sets)'
      ],
      <String>[
        'AOT-compatible',
        'no',
        'yes',
        'yes'
      ],
      <String>[
        'Tree-shakeable',
        'no',
        'yes',
        'yes'
      ],
      <String>[
        'Binary size cost',
        'high',
        'zero',
        'predictable (only what is generated)'
      ],
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++) ...<Widget>[
            if (i > 0) Container(height: 1, color: _line),
            Container(
              decoration: BoxDecoration(
                color: i == 0 ? _paperAlt : Colors.white,
                borderRadius: i == 0
                    ? const BorderRadius.vertical(top: Radius.circular(14))
                    : (i == rows.length - 1
                        ? const BorderRadius.vertical(
                            bottom: Radius.circular(14))
                        : null),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i][0],
                      style: i == 0 ? _label : _bodyStrong,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _MirrorsCell(
                      text: rows[i][1],
                      isHeader: i == 0,
                      color: _rose,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _MirrorsCell(
                      text: rows[i][2],
                      isHeader: i == 0,
                      color: _mint,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: _MirrorsCell(
                      text: rows[i][3],
                      isHeader: i == 0,
                      color: _accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MirrorsCell extends StatelessWidget {
  final String text;
  final bool isHeader;
  final Color color;
  const _MirrorsCell({
    required this.text,
    required this.isHeader,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return Text(text, style: _label);
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.5,
        color: text == 'no' || text == 'high'
            ? _rose
            : (text == 'yes' || text == 'zero'
                ? _mint
                : _inkSoft),
        fontWeight: FontWeight.w600,
        fontFamily: 'monospace',
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _SealedRecipe — §11
// -----------------------------------------------------------------------------

class _SealedRecipe extends StatelessWidget {
  final List<_Event> events;
  const _SealedRecipe({required this.events});

  @override
  Widget build(BuildContext context) {
    final List<String> renders = <String>[];
    for (final _Event e in events) {
      final String r = switch (e) {
        _Tap(:final int x, :final int y) => 'Tap at ($x, $y)',
        _Drag(:final int dx, :final int dy) => 'Drag by ($dx, $dy)',
        _Release() => 'Release',
      };
      renders.add(r);
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _CodeBlock(
            code: '''
sealed class _Event { const _Event(); }
class _Tap     extends _Event { final int x, y; const _Tap(this.x, this.y); }
class _Drag    extends _Event { final int dx, dy; const _Drag(this.dx, this.dy); }
class _Release extends _Event { const _Release(); }

String describe(_Event e) => switch (e) {
  _Tap(:final x, :final y)     => 'Tap at (\$x, \$y)',
  _Drag(:final dx, :final dy)  => 'Drag by (\$dx, \$dy)',
  _Release()                   => 'Release',
};''',
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < events.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _accent.withOpacity(0.4)),
                    ),
                    child: Text(
                      events[i].runtimeType.toString(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: _accent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_right_alt,
                      size: 14, color: _inkMute),
                  const SizedBox(width: 8),
                  Expanded(child: Text(renders[i], style: _monoInk)),
                ],
              ),
            ),
          const SizedBox(height: 12),
          _Callout(
            tone: _CalloutTone.tip,
            title: 'Exhaustiveness wins',
            body: 'Because _Event is sealed, the analyzer flags the switch '
                'if you add a new subclass and forget to handle it. This is '
                'the closest Dart gets to algebraic data types.',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _PitfallsList — §12
// -----------------------------------------------------------------------------

class _PitfallsList extends StatelessWidget {
  const _PitfallsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _Pitfall(
          tag: 'P1',
          title: 'Comparing runtimeType across libraries',
          body: 'Two classes with the same name in different libraries have '
              'different Type tokens. Never use runtimeType.toString() as a '
              'wire-format discriminator — refactor and they break silently.',
        ),
        SizedBox(height: 10),
        _Pitfall(
          tag: 'P2',
          title: 'Generic type erasure surprises',
          body: 'List<int>() and List<num>() have different runtimeTypes — '
              'but `<int>[] is List<num>` is true because Dart generics are '
              'reified covariantly. Read the spec before relying on this.',
        ),
        SizedBox(height: 10),
        _Pitfall(
          tag: 'P3',
          title: 'Forgetting the type guard in operator ==',
          body: 'If you write `return x == other.x` without first checking '
              '`other is _Point`, you crash on `_Point(1,2) == "hi"` instead '
              'of returning false. Always guard the type first.',
        ),
        SizedBox(height: 10),
        _Pitfall(
          tag: 'P4',
          title: 'Mutable hashCode',
          body: 'If a field used in hashCode changes after the object is put '
              'in a Set, the Set silently loses it. Prefer final fields, or '
              'compute hashCode from immutable identity.',
        ),
        SizedBox(height: 10),
        _Pitfall(
          tag: 'P5',
          title: 'Using Type as a map key for "class registry"',
          body: 'Type is comparable and hashable, but Type tokens for generic '
              'classes differ for each type argument. Prefer codegen or '
              'sealed classes for closed type families.',
        ),
        SizedBox(height: 10),
        _Pitfall(
          tag: 'P6',
          title: 'Treating identical() as semantic equality',
          body: 'For numbers, strings and const objects, identical() may '
              'unexpectedly be true *or* false depending on canonicalisation '
              'rules. Use it only as an optimisation, never as truth.',
        ),
      ],
    );
  }
}

class _Pitfall extends StatelessWidget {
  final String tag;
  final String title;
  final String body;
  const _Pitfall({required this.tag, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _rose.withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              tag,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: _rose,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: _bodyStrong),
                const SizedBox(height: 4),
                Text(body, style: _body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _Glossary — §13
// -----------------------------------------------------------------------------

class _Glossary extends StatelessWidget {
  const _Glossary();

  @override
  Widget build(BuildContext context) {
    const List<_GlossEntry> entries = <_GlossEntry>[
      _GlossEntry('Class', 'Unit of code declaring fields, methods, '
          'constructors, and inherited or mixed-in behaviour.'),
      _GlossEntry('Instance', 'A heap-allocated value whose runtime '
          'representation is determined by a class.'),
      _GlossEntry('runtimeType', 'A Type token that names the concrete class '
          'of an instance. Equal to the class declaration token.'),
      _GlossEntry('Type', 'Reified handle to a type. Has equality and '
          'hashCode but no introspective surface.'),
      _GlossEntry('Mixin', 'A class fragment combined into another class '
          'via "with". Cannot be instantiated directly.'),
      _GlossEntry('Interface', 'Any class implicitly defines an interface; '
          'use "implements" to commit to satisfying it without inheriting.'),
      _GlossEntry('Sealed class', 'A class whose subclasses must live in the '
          'same library. Enables exhaustive pattern matching.'),
      _GlossEntry('Linearization', 'The compiler-imposed order of superclasses '
          'and mixins used to resolve method calls.'),
      _GlossEntry('Reified generics', 'Dart preserves type arguments at '
          'runtime, unlike Java\'s erased generics.'),
      _GlossEntry('Tree-shaking', 'Compiler optimisation that drops unused '
          'code; defeated by reflective APIs like dart:mirrors.'),
      _GlossEntry('Canonicalisation', 'Process by which the compiler shares '
          'one heap object for all const expressions that compare equal.'),
      _GlossEntry('Diagnosticable', 'Foundation type whose toDiagnosticsNode() '
          'powers the Flutter inspector property panel.'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < entries.length; i++) ...<Widget>[
            if (i > 0) Container(height: 1, color: _line),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 160,
                    child: Text(
                      entries[i].term,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: _ink,
                      ),
                    ),
                  ),
                  Expanded(child: Text(entries[i].body, style: _body)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GlossEntry {
  final String term;
  final String body;
  const _GlossEntry(this.term, this.body);
}

// -----------------------------------------------------------------------------
// _Recap & _Footer — §14
// -----------------------------------------------------------------------------

class _Recap extends StatelessWidget {
  const _Recap();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFFEEF2FF),
            Color(0xFFFAF5FF),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.bookmark_outline,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text('Recap', style: _section),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Dart gives you a small, predictable surface for class metadata '
            'at runtime. Treat runtimeType as a debugging aid, prefer is / as '
            'for control flow, and override == / hashCode together. Reach for '
            'sealed classes when the subclass set is closed, and reach for '
            'DiagnosticableTreeMixin when you want your domain objects to '
            'show up in DevTools.',
            style: _body,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _RecapChip(label: 'runtimeType — debug only', color: _accent),
              _RecapChip(label: 'is / as — control flow', color: _mint),
              _RecapChip(label: '== + hashCode — together', color: _amber),
              _RecapChip(label: 'sealed — closed families', color: _accentAlt),
              _RecapChip(
                label: 'DiagnosticableTreeMixin — inspector',
                color: _sky,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecapChip extends StatelessWidget {
  final String label;
  final Color color;
  const _RecapChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 1, color: _line),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const Icon(Icons.tag, color: _inkMute, size: 14),
            const SizedBox(width: 6),
            Text(
              'foundation/class — hand-authored visual deep demo',
              style: _monoSmall,
            ),
            const Spacer(),
            const Icon(Icons.code, color: _inkMute, size: 14),
            const SizedBox(width: 6),
            Text(
              'Object · Type · runtimeType · is · as · identical · == · hashCode',
              style: _monoSmall,
            ),
          ],
        ),
      ],
    );
  }
}
