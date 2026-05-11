// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Visual deep demo for the `Diagnosticable` mixin from
// `package:flutter/foundation.dart`.
//
// `Diagnosticable` is the **base** debug-property protocol used throughout the
// Flutter framework. Any object that wishes to expose a structured, machine-
// readable property dump — visible in `toString()`, the DevTools Inspector,
// and assertion failure messages — mixes in `Diagnosticable` and overrides
// `debugFillProperties(DiagnosticPropertiesBuilder properties)`.
//
// The sister file `diagnosticable_tree_test.dart` covers the *tree-walking*
// variant (`DiagnosticableTree` + `toStringDeep`). This file focuses on the
// flat property surface: `DiagnosticsProperty<T>`, the typed subclasses, and
// the `DiagnosticLevel` axis.
// ---------------------------------------------------------------------------

// A small demonstration class. Its only purpose is to make the code-block
// section authentic — we never instantiate it during build.
class FooConfig with Diagnosticable {
  final String name;
  final int retries;
  final bool sticky;
  final double timeoutSeconds;
  final Color tint;

  const FooConfig({
    required this.name,
    this.retries = 3,
    this.sticky = false,
    this.timeoutSeconds = 30.0,
    this.tint = const Color(0xFF6750A4),
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(IntProperty('retries', retries, defaultValue: 3));
    properties.add(FlagProperty('sticky', value: sticky, ifTrue: 'sticky'));
    properties.add(DoubleProperty('timeoutSeconds', timeoutSeconds));
    properties.add(ColorProperty('tint', tint));
  }
}

// ---------------------------------------------------------------------------
// Palette — Material 3 inspired, warm paper background.
// ---------------------------------------------------------------------------
const Color _kPaper = Color(0xFFF7F5F0);
const Color _kInk = Color(0xFF1B1B1F);
const Color _kInkSoft = Color(0xFF45464F);
const Color _kInkMuted = Color(0xFF73747D);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kBorder = Color(0xFFE2DFD8);

const Color _kPrimary = Color(0xFF6750A4);
const Color _kPrimaryDark = Color(0xFF4F378B);
const Color _kPrimaryTint = Color(0xFFEADDFF);

const Color _kTeal = Color(0xFF006A6A);
const Color _kAmber = Color(0xFFB58900);
const Color _kAccent = Color(0xFFCB4154);
const Color _kForest = Color(0xFF2E7D32);
const Color _kSlate = Color(0xFF455A64);

const Color _kCodeBg = Color(0xFF1E1B2E);
const Color _kCodeFg = Color(0xFFE6E1FF);
const Color _kCodeComment = Color(0xFF8A85B6);
const Color _kCodeKeyword = Color(0xFFCFA8FF);
const Color _kCodeString = Color(0xFFFFC580);
const Color _kCodeIdent = Color(0xFF9EE6FF);
const Color _kCodeNumber = Color(0xFFFFB4AB);

// ---------------------------------------------------------------------------
// build()
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(children: const <Widget>[
            _HeroCard(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '01',
              title: 'Class hierarchy',
              subtitle: 'Where Diagnosticable sits in the foundation tower',
              accent: _kPrimary,
            ),
            SizedBox(height: 16),
            _HierarchyDiagram(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '02',
              title: 'Anatomy of debugFillProperties',
              subtitle: 'The one method every Diagnosticable overrides',
              accent: _kTeal,
            ),
            SizedBox(height: 16),
            _AnatomyCard(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '03',
              title: 'DiagnosticsProperty<T> subtypes',
              subtitle: 'Typed property wrappers shipped by foundation',
              accent: _kAmber,
            ),
            SizedBox(height: 16),
            _PropertyTypeGrid(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '04',
              title: 'DiagnosticLevel — the visibility axis',
              subtitle: 'Nine levels controlling how (or whether) a property shows',
              accent: _kAccent,
            ),
            SizedBox(height: 16),
            _LevelList(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '05',
              title: 'toString variants',
              subtitle: 'Four entry points into the same property graph',
              accent: _kForest,
            ),
            SizedBox(height: 16),
            _ToStringVariantsCard(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '06',
              title: 'DevTools-style property table',
              subtitle: 'A visual mock of the Flutter Inspector pane',
              accent: _kSlate,
            ),
            SizedBox(height: 16),
            _DevToolsMock(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '07',
              title: 'Custom Diagnosticable — FooConfig',
              subtitle: 'A small idiomatic implementation, line by line',
              accent: _kPrimaryDark,
            ),
            SizedBox(height: 16),
            _CustomImplementationCard(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '08',
              title: 'defaultValue & showName interactions',
              subtitle: 'Two flags, four combined behaviors',
              accent: _kTeal,
            ),
            SizedBox(height: 16),
            _DefaultShowNameMatrix(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '09',
              title: 'Use cases',
              subtitle: 'Where Diagnosticable pays off in real life',
              accent: _kForest,
            ),
            SizedBox(height: 16),
            _UseCasesGrid(),
            SizedBox(height: 28),
            _SectionHeader(
              index: '10',
              title: 'Pitfalls',
              subtitle: 'Things to avoid when overriding debugFillProperties',
              accent: _kAccent,
            ),
            SizedBox(height: 16),
            _PitfallsList(),
            SizedBox(height: 32),
            _Footer(),
          ]),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero
// ---------------------------------------------------------------------------
class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF4F378B),
            Color(0xFF6750A4),
            Color(0xFF8A6FBF),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF4F378B).withValues(alpha: 0.35),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white.withValues(alpha: 0.18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.30),
                    width: 1.2,
                  ),
                ),
                child: const Icon(
                  Icons.bug_report_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'foundation · debug protocol',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.78),
                        fontSize: 11.5,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Diagnosticable',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Structured property dumping for every Flutter framework type — '
            'widgets, render objects, themes, configs. Override one method, '
            'gain printable debug output, DevTools rows, and assertion context.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 14.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(children: const <Widget>[
            _HeroPill(label: 'mixin', accent: Color(0xFFFFD9A8)),
            SizedBox(width: 8),
            _HeroPill(label: 'foundation', accent: Color(0xFFA8E0FF)),
            SizedBox(width: 8),
            _HeroPill(label: 'debug-only output', accent: Color(0xFFFFB4AB)),
            SizedBox(width: 8),
            _HeroPill(label: 'used by Inspector', accent: Color(0xFFB6F2C5)),
          ]),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  final String label;
  final Color accent;
  const _HeroPill({required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: accent.withValues(alpha: 0.55),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section header
// ---------------------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  final String index;
  final String title;
  final String subtitle;
  final Color accent;
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            accent.withValues(alpha: 0.18),
            accent.withValues(alpha: 0.04),
          ],
        ),
        border: Border(
          left: BorderSide(color: accent, width: 4),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: accent.withValues(alpha: 0.18),
              border: Border.all(
                color: accent.withValues(alpha: 0.40),
                width: 1.0,
              ),
            ),
            child: Text(
              index,
              style: TextStyle(
                color: accent,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _kInkMuted,
                    fontSize: 12.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 01 Hierarchy diagram
// ---------------------------------------------------------------------------
class _HierarchyDiagram extends StatelessWidget {
  const _HierarchyDiagram();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _HierBox(
            label: 'DiagnosticableMixin',
            note: 'historic alias — same surface as Diagnosticable',
            accent: _kInkMuted,
            dashed: true,
          ),
          const _HierLine(),
          const _HierBox(
            label: 'Diagnosticable',
            note: 'mixin. debugFillProperties(...) + toStringShort()',
            accent: _kPrimary,
            highlight: true,
          ),
          const _HierLine(),
          const _HierBox(
            label: 'DiagnosticableTree',
            note: 'adds debugDescribeChildren + toStringDeep',
            accent: _kTeal,
          ),
          const _HierLine(),
          Row(
            children: const <Widget>[
              Expanded(
                child: _HierBox(
                  label: 'Widget',
                  note: '@immutable build()',
                  accent: _kAccent,
                  compact: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _HierBox(
                  label: 'Element',
                  note: 'lifecycle host',
                  accent: _kAmber,
                  compact: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _HierBox(
                  label: 'RenderObject',
                  note: 'paint / layout',
                  accent: _kForest,
                  compact: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _kPrimaryTint.withValues(alpha: 0.45),
              border: Border.all(
                color: _kPrimary.withValues(alpha: 0.18),
              ),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.info_outline,
                    color: _kPrimaryDark, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Diagnosticable is the *flat* property surface. '
                    'Anything that owns children (and therefore should print '
                    'as a tree) extends DiagnosticableTree instead.',
                    style: TextStyle(
                      color: _kInkSoft,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HierBox extends StatelessWidget {
  final String label;
  final String note;
  final Color accent;
  final bool highlight;
  final bool compact;
  final bool dashed;
  const _HierBox({
    required this.label,
    required this.note,
    required this.accent,
    this.highlight = false,
    this.compact = false,
    this.dashed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 14,
        vertical: compact ? 10 : 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: highlight
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  accent.withValues(alpha: 0.22),
                  accent.withValues(alpha: 0.06),
                ],
              )
            : null,
        color: highlight ? null : Colors.white,
        border: Border.all(
          color: accent.withValues(alpha: dashed ? 0.25 : 0.55),
          width: highlight ? 1.4 : 1.0,
          style: dashed ? BorderStyle.solid : BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: _kInk,
                  fontSize: compact ? 13 : 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            note,
            style: TextStyle(
              color: _kInkMuted,
              fontSize: compact ? 10.5 : 11.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _HierLine extends StatelessWidget {
  const _HierLine();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: Center(
        child: Container(
          width: 2,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[_kPrimary, _kTeal],
            ),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 02 Anatomy
// ---------------------------------------------------------------------------
class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Signature',
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          _CodeBlock(
            lines: const <_CodeLine>[
              _CodeLine(text: '@override', kind: _LineKind.annotation),
              _CodeLine(text: 'void debugFillProperties(', kind: _LineKind.code),
              _CodeLine(
                  text: '    DiagnosticPropertiesBuilder properties,',
                  kind: _LineKind.code),
              _CodeLine(text: ') {', kind: _LineKind.code),
              _CodeLine(
                  text: '  // 1. delegate up the chain — required.',
                  kind: _LineKind.comment),
              _CodeLine(
                  text: '  super.debugFillProperties(properties);',
                  kind: _LineKind.code),
              _CodeLine(text: '', kind: _LineKind.code),
              _CodeLine(
                  text: '  // 2. add one entry per visible property.',
                  kind: _LineKind.comment),
              _CodeLine(
                  text:
                      "  properties.add(StringProperty('name', name));",
                  kind: _LineKind.code),
              _CodeLine(
                  text:
                      "  properties.add(IntProperty('retries', retries));",
                  kind: _LineKind.code),
              _CodeLine(text: '}', kind: _LineKind.code),
            ],
          ),
          const SizedBox(height: 16),
          const _AnatomyRow(
            tag: '1',
            title: 'Always call super',
            body:
                'Without `super.debugFillProperties(...)` a subclass silently '
                'erases every property the parent contributed.',
            color: _kAccent,
          ),
          const SizedBox(height: 10),
          const _AnatomyRow(
            tag: '2',
            title: 'Add typed properties',
            body:
                'Use a typed subclass (StringProperty, IntProperty, …) over '
                'the raw DiagnosticsProperty<T> constructor whenever one '
                'exists — it pre-wires defaults, formatting, and level.',
            color: _kPrimary,
          ),
          const SizedBox(height: 10),
          const _AnatomyRow(
            tag: '3',
            title: 'Be deterministic & cheap',
            body:
                'Property values are read during error reporting and inspector '
                'polling. Avoid IO, locks, or async; keep the computation '
                'side-effect free.',
            color: _kTeal,
          ),
          const SizedBox(height: 10),
          const _AnatomyRow(
            tag: '4',
            title: 'Use level wisely',
            body:
                'Pass `level: DiagnosticLevel.fine` for noisy internals so '
                'they only show in verbose dumps but stay reachable for '
                'tooling.',
            color: _kAmber,
          ),
        ],
      ),
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  final String tag;
  final String title;
  final String body;
  final Color color;
  const _AnatomyRow({
    required this.tag,
    required this.title,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withValues(alpha: 0.06),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 03 DiagnosticsProperty subtypes
// ---------------------------------------------------------------------------
class _PropertyTypeGrid extends StatelessWidget {
  const _PropertyTypeGrid();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: const <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: _PropertyTypeCard(
                name: 'StringProperty',
                accent: _kPrimary,
                kind: 'String',
                ctor:
                    "StringProperty('name', name, quoted: false, ifEmpty: '<empty>')",
                blurb: 'Optional quoting; collapses to placeholder when blank.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PropertyTypeCard(
                name: 'IntProperty',
                accent: _kTeal,
                kind: 'int',
                ctor:
                    "IntProperty('count', count, defaultValue: 0, ifNull: '?')",
                blurb: 'Numeric format. Honors defaultValue.',
              ),
            ),
          ]),
          SizedBox(height: 12),
          Row(children: <Widget>[
            Expanded(
              child: _PropertyTypeCard(
                name: 'DoubleProperty',
                accent: _kAmber,
                kind: 'double',
                ctor:
                    "DoubleProperty('size', size, unit: 'px', tolerance: 0.01)",
                blurb: 'Optional unit suffix and equality tolerance.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PropertyTypeCard(
                name: 'FlagProperty',
                accent: _kAccent,
                kind: 'bool',
                ctor:
                    "FlagProperty('sticky', value: v, ifTrue: 'sticky', ifFalse: 'loose')",
                blurb: 'Renders the flag *name*, not the literal true/false.',
              ),
            ),
          ]),
          SizedBox(height: 12),
          Row(children: <Widget>[
            Expanded(
              child: _PropertyTypeCard(
                name: 'EnumProperty',
                accent: _kForest,
                kind: 'enum',
                ctor:
                    "EnumProperty<Axis>('axis', axis, defaultValue: Axis.horizontal)",
                blurb: 'Strips the Type. prefix. Generic over the enum.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PropertyTypeCard(
                name: 'IterableProperty',
                accent: _kSlate,
                kind: 'Iterable<T>',
                ctor:
                    "IterableProperty<int>('ids', ids, ifEmpty: '<none>')",
                blurb: 'Truncates long lists; respects DiagnosticsTreeStyle.',
              ),
            ),
          ]),
          SizedBox(height: 12),
          Row(children: <Widget>[
            Expanded(
              child: _PropertyTypeCard(
                name: 'ObjectFlagProperty',
                accent: _kPrimaryDark,
                kind: 'T?',
                ctor:
                    "ObjectFlagProperty<VoidCallback>('onTap', onTap, ifNull: 'disabled')",
                blurb: 'Best for callbacks — shows presence, not the closure.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PropertyTypeCard(
                name: 'MessageProperty',
                accent: _kAmber,
                kind: 'String',
                ctor:
                    "MessageProperty('mode', 'opt-in beta')",
                blurb: 'No name/value pair — emits a freeform tag line.',
              ),
            ),
          ]),
          SizedBox(height: 12),
          Row(children: <Widget>[
            Expanded(
              child: _PropertyTypeCard(
                name: 'ColorProperty',
                accent: _kPrimary,
                kind: 'Color',
                ctor:
                    "ColorProperty('tint', tint, defaultValue: Colors.purple)",
                blurb: 'Prints Color(0x…ARGB) with a swatch in DevTools.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PropertyTypeCard(
                name: 'IconDataProperty',
                accent: _kTeal,
                kind: 'IconData',
                ctor:
                    "IconDataProperty('icon', icon, ifNull: '<no icon>')",
                blurb: 'Material/Cupertino-aware. Used by Icon.',
              ),
            ),
          ]),
          SizedBox(height: 12),
          Row(children: <Widget>[
            Expanded(
              child: _PropertyTypeCard(
                name: 'PercentProperty',
                accent: _kForest,
                kind: 'double',
                ctor:
                    "PercentProperty('progress', 0.42, showName: true)",
                blurb: 'Formats 0..1 doubles as e.g. 42.0%.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PropertyTypeCard(
                name: 'DiagnosticsProperty<T>',
                accent: _kInkMuted,
                kind: 'T',
                ctor:
                    "DiagnosticsProperty<MyType>('it', it, description: '…')",
                blurb: 'Generic fallback when no specialized subclass fits.',
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _PropertyTypeCard extends StatelessWidget {
  final String name;
  final String kind;
  final String ctor;
  final String blurb;
  final Color accent;
  const _PropertyTypeCard({
    required this.name,
    required this.kind,
    required this.ctor,
    required this.blurb,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.10),
            accent.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  kind,
                  style: TextStyle(
                    color: accent,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              ctor,
              style: const TextStyle(
                color: _kCodeFg,
                fontSize: 10.5,
                height: 1.35,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            blurb,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 04 DiagnosticLevel
// ---------------------------------------------------------------------------
class _LevelList extends StatelessWidget {
  const _LevelList();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: const <Widget>[
          _LevelRow(
            name: 'hidden',
            color: _kInkMuted,
            description:
                'Property exists but is not shown in textual dumps. Still '
                'reachable through the DiagnosticsNode API.',
            example: 'Internal cache ids, debug-only memoization seeds.',
          ),
          SizedBox(height: 10),
          _LevelRow(
            name: 'fine',
            color: Color(0xFF7986CB),
            description:
                'Verbose. Only printed when the requested minimum level is '
                'fine or lower.',
            example: 'Layout protocol intermediate values.',
          ),
          SizedBox(height: 10),
          _LevelRow(
            name: 'debug',
            color: Color(0xFF26A69A),
            description:
                'Default for properties intended for developers but not as '
                'broad as info-level.',
            example: 'BuildContext element depth.',
          ),
          SizedBox(height: 10),
          _LevelRow(
            name: 'info',
            color: _kPrimary,
            description:
                'The standard. Shown in `toString()` and in the inspector '
                'without expanding anything.',
            example: 'Widget key, color, width, height.',
          ),
          SizedBox(height: 10),
          _LevelRow(
            name: 'warning',
            color: _kAmber,
            description:
                'Highlights potentially problematic configuration; rendered '
                'in yellow in DevTools.',
            example: 'Non-finite size, deprecated configuration option.',
          ),
          SizedBox(height: 10),
          _LevelRow(
            name: 'hint',
            color: Color(0xFF66BB6A),
            description:
                'Actionable suggestion appended after the failure context '
                '— renders with the "💡" / hint glyph.',
            example: '"Did you mean to wrap this in a Material?"',
          ),
          SizedBox(height: 10),
          _LevelRow(
            name: 'summary',
            color: Color(0xFF8D6E63),
            description:
                'Promoted property used as the headline when an object is '
                'shown in compact one-line form.',
            example: 'FlutterError messages: the summary line.',
          ),
          SizedBox(height: 10),
          _LevelRow(
            name: 'error',
            color: _kAccent,
            description:
                'Indicates an invariant violation; framework asserts often '
                'attach properties at this level.',
            example: 'Negative dimensions, null required argument.',
          ),
          SizedBox(height: 10),
          _LevelRow(
            name: 'off',
            color: Color(0xFF424242),
            description:
                'Sentinel used to suppress output entirely — both textual '
                'and structured.',
            example: 'Properties redacted for privacy in shared dumps.',
          ),
        ],
      ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  final String name;
  final Color color;
  final String description;
  final String example;
  const _LevelRow({
    required this.name,
    required this.color,
    required this.description,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 92,
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  color.withValues(alpha: 0.85),
                  color.withValues(alpha: 0.55),
                ],
              ),
            ),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  description,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.bookmark_outline,
                          color: color, size: 13),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          example,
                          style: TextStyle(
                            color: color,
                            fontSize: 11.5,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 05 toString variants
// ---------------------------------------------------------------------------
class _ToStringVariantsCard extends StatelessWidget {
  const _ToStringVariantsCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: const <Widget>[
          _VariantRow(
            method: 'toString()',
            blurb:
                'One-line, info-level properties. Default Object.toString '
                'override; cheap and safe to call in production.',
            output: "FooConfig(name: \"alpha\", retries: 5, tint: Color(0xFF6750A4))",
            color: _kPrimary,
          ),
          SizedBox(height: 12),
          _VariantRow(
            method: 'toStringShort()',
            blurb:
                'runtimeType only. Used as the headline in deep dumps and as '
                'the row title in DevTools.',
            output: 'FooConfig',
            color: _kTeal,
          ),
          SizedBox(height: 12),
          _VariantRow(
            method: 'toStringShallow()',
            blurb:
                'Like toString but emits each property on its own line. '
                'Joiner and prefixes are configurable.',
            output:
                "FooConfig#a7e2f\n  name: \"alpha\"\n  retries: 5\n  sticky: false",
            color: _kAmber,
          ),
          SizedBox(height: 12),
          _VariantRow(
            method: 'toStringDeep()',
            blurb:
                'Recursive — walks DiagnosticableTree.debugDescribeChildren. '
                'Bare Diagnosticable has no children, so this collapses to '
                'toStringShallow.',
            output:
                'FooConfig#a7e2f\n └─ name: "alpha"\n    retries: 5\n    tint: Color(0xFF6750A4)',
            color: _kForest,
            note: 'See diagnosticable_tree_test.dart for the full tree story.',
          ),
        ],
      ),
    );
  }
}

class _VariantRow extends StatelessWidget {
  final String method;
  final String blurb;
  final String output;
  final Color color;
  final String? note;
  const _VariantRow({
    required this.method,
    required this.blurb,
    required this.output,
    required this.color,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  method,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward,
                  color: _kInkMuted, size: 14),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  blurb,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kCodeKeyword.withValues(alpha: 0.18)),
            ),
            child: Text(
              output,
              style: const TextStyle(
                color: _kCodeFg,
                fontSize: 11.5,
                height: 1.45,
                fontFamily: 'monospace',
              ),
            ),
          ),
          if (note != null) ...<Widget>[
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Icon(Icons.subdirectory_arrow_right,
                    size: 14, color: color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    note!,
                    style: TextStyle(
                      color: color,
                      fontSize: 11.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 06 DevTools mock
// ---------------------------------------------------------------------------
class _DevToolsMock extends StatelessWidget {
  const _DevToolsMock();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF2A2235),
            Color(0xFF1B1726),
          ],
        ),
        border: Border.all(color: const Color(0xFF3F3550)),
      ),
      child: Column(
        children: <Widget>[
          // window chrome
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF120F1B),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: <Widget>[
                const _DotCluster(),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2138),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'DevTools · Inspector · FooConfig',
                    style: TextStyle(
                      color: Color(0xFFD9D2FF),
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.refresh,
                    color: Color(0xFF8A85B6), size: 14),
              ],
            ),
          ),
          // header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFF3F3550).withValues(alpha: 0.6),
                ),
              ),
            ),
            child: Row(
              children: const <Widget>[
                _MockHeaderCell(text: 'Property', flex: 3),
                _MockHeaderCell(text: 'Value', flex: 5),
                _MockHeaderCell(text: 'Level', flex: 2),
              ],
            ),
          ),
          // rows
          const _MockRow(
            name: 'key',
            value: 'null',
            level: 'info',
            levelColor: _kPrimary,
            kind: _MockKind.muted,
          ),
          const _MockRow(
            name: 'name',
            value: '"alpha"',
            level: 'info',
            levelColor: _kPrimary,
            kind: _MockKind.string,
          ),
          const _MockRow(
            name: 'retries',
            value: '5',
            level: 'info',
            levelColor: _kPrimary,
            kind: _MockKind.number,
          ),
          const _MockRow(
            name: 'sticky',
            value: 'sticky',
            level: 'info',
            levelColor: _kPrimary,
            kind: _MockKind.flag,
          ),
          const _MockRow(
            name: 'timeoutSeconds',
            value: '30.0',
            level: 'info',
            levelColor: _kPrimary,
            kind: _MockKind.number,
          ),
          const _MockRow(
            name: 'tint',
            value: 'Color(0xFF6750A4)',
            level: 'info',
            levelColor: _kPrimary,
            kind: _MockKind.color,
            swatch: _kPrimary,
          ),
          const _MockRow(
            name: 'lastUpdate',
            value: 'DateTime<2026-05-11 10:14:00>',
            level: 'fine',
            levelColor: Color(0xFF7986CB),
            kind: _MockKind.muted,
          ),
          const _MockRow(
            name: 'fallback',
            value: '<default>',
            level: 'debug',
            levelColor: Color(0xFF26A69A),
            kind: _MockKind.muted,
          ),
          const _MockRow(
            name: 'experimentalFlag',
            value: 'on',
            level: 'warning',
            levelColor: _kAmber,
            kind: _MockKind.flag,
          ),
          const _MockRow(
            name: 'wrap?',
            value: 'Did you mean to wrap this in a Material?',
            level: 'hint',
            levelColor: Color(0xFF66BB6A),
            kind: _MockKind.hint,
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _DotCluster extends StatelessWidget {
  const _DotCluster();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        _WinDot(color: Color(0xFFFF5F57)),
        SizedBox(width: 6),
        _WinDot(color: Color(0xFFFEBC2E)),
        SizedBox(width: 6),
        _WinDot(color: Color(0xFF28C840)),
      ],
    );
  }
}

class _WinDot extends StatelessWidget {
  final Color color;
  const _WinDot({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class _MockHeaderCell extends StatelessWidget {
  final String text;
  final int flex;
  const _MockHeaderCell({required this.text, required this.flex});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF8A85B6),
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

enum _MockKind { muted, string, number, flag, color, hint }

class _MockRow extends StatelessWidget {
  final String name;
  final String value;
  final String level;
  final Color levelColor;
  final _MockKind kind;
  final Color? swatch;
  const _MockRow({
    required this.name,
    required this.value,
    required this.level,
    required this.levelColor,
    required this.kind,
    this.swatch,
  });

  @override
  Widget build(BuildContext context) {
    Color valueColor;
    switch (kind) {
      case _MockKind.muted:
        valueColor = const Color(0xFF8A85B6);
        break;
      case _MockKind.string:
        valueColor = _kCodeString;
        break;
      case _MockKind.number:
        valueColor = _kCodeNumber;
        break;
      case _MockKind.flag:
        valueColor = _kCodeKeyword;
        break;
      case _MockKind.color:
        valueColor = _kCodeIdent;
        break;
      case _MockKind.hint:
        valueColor = const Color(0xFFB6F2C5);
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF3F3550).withValues(alpha: 0.30),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                Icon(_iconFor(kind), size: 12, color: valueColor),
                const SizedBox(width: 7),
                Flexible(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Color(0xFFE6E1FF),
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                if (swatch != null) ...<Widget>[
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: swatch,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                ],
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: valueColor,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: levelColor.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                  border:
                      Border.all(color: levelColor.withValues(alpha: 0.5)),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    color: levelColor,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(_MockKind k) {
    switch (k) {
      case _MockKind.muted:
        return Icons.remove_circle_outline;
      case _MockKind.string:
        return Icons.format_quote;
      case _MockKind.number:
        return Icons.numbers;
      case _MockKind.flag:
        return Icons.flag_outlined;
      case _MockKind.color:
        return Icons.palette_outlined;
      case _MockKind.hint:
        return Icons.lightbulb_outline;
    }
  }
}

// ---------------------------------------------------------------------------
// 07 Custom implementation
// ---------------------------------------------------------------------------
class _CustomImplementationCard extends StatelessWidget {
  const _CustomImplementationCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A complete, idiomatic Diagnosticable subclass:',
            style: TextStyle(
              color: _kInkSoft,
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          _CodeBlock(
            lines: const <_CodeLine>[
              _CodeLine(
                  text: '// Mixin Diagnosticable on a plain value class.',
                  kind: _LineKind.comment),
              _CodeLine(
                  text: 'class FooConfig with Diagnosticable {',
                  kind: _LineKind.code),
              _CodeLine(
                  text: '  final String name;', kind: _LineKind.code),
              _CodeLine(
                  text: '  final int retries;', kind: _LineKind.code),
              _CodeLine(
                  text: '  final bool sticky;', kind: _LineKind.code),
              _CodeLine(
                  text: '  final double timeoutSeconds;',
                  kind: _LineKind.code),
              _CodeLine(
                  text: '  final Color tint;', kind: _LineKind.code),
              _CodeLine(text: '', kind: _LineKind.code),
              _CodeLine(
                  text: '  const FooConfig({',
                  kind: _LineKind.code),
              _CodeLine(
                  text: '    required this.name,',
                  kind: _LineKind.code),
              _CodeLine(
                  text: '    this.retries = 3,', kind: _LineKind.code),
              _CodeLine(
                  text: '    this.sticky = false,',
                  kind: _LineKind.code),
              _CodeLine(
                  text: '    this.timeoutSeconds = 30.0,',
                  kind: _LineKind.code),
              _CodeLine(
                  text:
                      "    this.tint = const Color(0xFF6750A4),",
                  kind: _LineKind.code),
              _CodeLine(text: '  });', kind: _LineKind.code),
              _CodeLine(text: '', kind: _LineKind.code),
              _CodeLine(text: '  @override', kind: _LineKind.annotation),
              _CodeLine(
                  text:
                      '  void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
                  kind: _LineKind.code),
              _CodeLine(
                  text:
                      '    super.debugFillProperties(properties);',
                  kind: _LineKind.code),
              _CodeLine(
                  text:
                      "    properties.add(StringProperty('name', name));",
                  kind: _LineKind.code),
              _CodeLine(
                  text:
                      "    properties.add(IntProperty('retries', retries, defaultValue: 3));",
                  kind: _LineKind.code),
              _CodeLine(
                  text:
                      "    properties.add(FlagProperty('sticky', value: sticky, ifTrue: 'sticky'));",
                  kind: _LineKind.code),
              _CodeLine(
                  text:
                      "    properties.add(DoubleProperty('timeoutSeconds', timeoutSeconds));",
                  kind: _LineKind.code),
              _CodeLine(
                  text:
                      "    properties.add(ColorProperty('tint', tint));",
                  kind: _LineKind.code),
              _CodeLine(text: '  }', kind: _LineKind.code),
              _CodeLine(text: '}', kind: _LineKind.code),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kPrimary.withValues(alpha: 0.12),
                  _kTeal.withValues(alpha: 0.06),
                ],
              ),
              border: Border.all(
                color: _kPrimary.withValues(alpha: 0.25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.bolt, color: _kPrimary, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Free benefits',
                      style: TextStyle(
                        color: _kPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const _BulletLine(
                  text:
                      "FooConfig.toString() now returns a printable summary line.",
                ),
                const _BulletLine(
                  text:
                      "The DevTools Inspector shows every property in a row, "
                      "with type-aware editing where supported.",
                ),
                const _BulletLine(
                  text:
                      "Assertion failures referencing the instance include "
                      "the full property dump in the failure context.",
                ),
                const _BulletLine(
                  text:
                      "Tooling can navigate to specific properties via the "
                      "service extension protocol — no extra reflection.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  final String text;
  const _BulletLine({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: _kPrimary,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 08 defaultValue & showName matrix
// ---------------------------------------------------------------------------
class _DefaultShowNameMatrix extends StatelessWidget {
  const _DefaultShowNameMatrix();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFFEADDFF),
                  Color(0xFFCFE8E8),
                ],
              ),
            ),
            child: Row(
              children: const <Widget>[
                _MxHeader(text: 'Config', flex: 4),
                _MxHeader(text: 'Property', flex: 4),
                _MxHeader(text: 'Rendered', flex: 5),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const _MxRow(
            cfg: 'showName: true\ndefault: ≠ value',
            prop: "IntProperty('retries', 5, defaultValue: 3)",
            out: 'retries: 5',
            tone: _kPrimary,
          ),
          const _MxRow(
            cfg: 'showName: true\ndefault: == value',
            prop: "IntProperty('retries', 3, defaultValue: 3)",
            out: '(omitted — matches default)',
            tone: _kInkMuted,
          ),
          const _MxRow(
            cfg: 'showName: false\ndefault: ≠ value',
            prop: "IntProperty('retries', 5, showName: false)",
            out: '5',
            tone: _kTeal,
          ),
          const _MxRow(
            cfg: 'showName: false\ndefault: == value',
            prop: "IntProperty('retries', 3, defaultValue: 3, showName: false)",
            out: '(omitted — matches default)',
            tone: _kInkMuted,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _kAmber.withValues(alpha: 0.10),
              border: Border.all(
                color: _kAmber.withValues(alpha: 0.30),
              ),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.warning_amber_rounded,
                    color: _kAmber, size: 18),
                SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'A property whose value equals defaultValue is hidden by '
                    'default — but it remains in the DiagnosticsNode graph at '
                    'DiagnosticLevel.fine, so tooling can still read it.',
                    style: TextStyle(
                      color: Color(0xFF6F5400),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MxHeader extends StatelessWidget {
  final String text;
  final int flex;
  const _MxHeader({required this.text, required this.flex});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: _kInk,
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

class _MxRow extends StatelessWidget {
  final String cfg;
  final String prop;
  final String out;
  final Color tone;
  const _MxRow({
    required this.cfg,
    required this.prop,
    required this.out,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              cfg,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 11.5,
                height: 1.4,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: _kCodeBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                prop,
                style: const TextStyle(
                  color: _kCodeFg,
                  fontSize: 10.5,
                  height: 1.4,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    tone.withValues(alpha: 0.20),
                    tone.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: Text(
                out,
                style: TextStyle(
                  color: tone,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 09 Use cases
// ---------------------------------------------------------------------------
class _UseCasesGrid extends StatelessWidget {
  const _UseCasesGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: _UseCaseCard(
              icon: Icons.error_outline,
              title: 'Error messages',
              body:
                  'FlutterError appends the full property dump of the '
                  'offending object to the failure header — turning "build '
                  'failed" into a debuggable scene.',
              accent: _kAccent,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _UseCaseCard(
              icon: Icons.dvr_outlined,
              title: 'DevTools Inspector',
              body:
                  'Each Widget/RenderObject row is rendered from its '
                  'DiagnosticsNode. Typed properties drive the proper '
                  'edit affordance.',
              accent: _kPrimary,
            ),
          ),
        ]),
        SizedBox(height: 12),
        Row(children: <Widget>[
          Expanded(
            child: _UseCaseCard(
              icon: Icons.local_fire_department_outlined,
              title: 'Hot-reload preservation',
              body:
                  'Frameworks compare diagnostics across reload boundaries '
                  'to detect intent. Stable property names help reload do '
                  'the right thing.',
              accent: _kAmber,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _UseCaseCard(
              icon: Icons.science_outlined,
              title: 'Post-mortem debugging',
              body:
                  'Stack traces enriched with property dumps make crash '
                  'reports actionable without re-running the app to '
                  'reproduce the state.',
              accent: _kForest,
            ),
          ),
        ]),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Color accent;
  const _UseCaseCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.14),
            accent.withValues(alpha: 0.03),
          ],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: accent.withValues(alpha: 0.22),
            ),
            child: Icon(icon, color: accent, size: 19),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 10 Pitfalls
// ---------------------------------------------------------------------------
class _PitfallsList extends StatelessWidget {
  const _PitfallsList();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: const <Widget>[
          _Pitfall(
            number: '1',
            title: 'Forgetting super.debugFillProperties',
            body:
                'The single most common mistake. The compiler will not warn — '
                'your superclass properties simply disappear from every '
                'dump.',
          ),
          SizedBox(height: 10),
          _Pitfall(
            number: '2',
            title: 'Expensive property computation',
            body:
                'Diagnostics are read during error reporting and the '
                'inspector polling loop. Avoid IO, network calls, or '
                'allocation-heavy work; cache or precompute instead.',
          ),
          SizedBox(height: 10),
          _Pitfall(
            number: '3',
            title: 'Breaking const-constructibility',
            body:
                'Adding non-const fields purely for diagnostics defeats '
                'widget caching. Prefer derived getters or use defaultValue '
                'to avoid storing redundant state.',
          ),
          SizedBox(height: 10),
          _Pitfall(
            number: '4',
            title: 'Leaking debug-only state',
            body:
                'Property values are visible in shipped release builds where '
                'inspectors are connected (e.g. profile mode). Never expose '
                'secrets, tokens, or PII via DiagnosticsProperty.',
          ),
          SizedBox(height: 10),
          _Pitfall(
            number: '5',
            title: 'Using DiagnosticsProperty<T> when a subclass exists',
            body:
                'StringProperty quotes, IntProperty/DoubleProperty format '
                'numbers, FlagProperty hides false. Reaching for the raw '
                'generic skips those affordances and downgrades the '
                'inspector UX.',
          ),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  final String number;
  final String title;
  final String body;
  const _Pitfall({
    required this.number,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFFFFEFEE),
            Color(0xFFFFF6F1),
          ],
        ),
        border: Border.all(color: _kAccent.withValues(alpha: 0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[_kAccent, Color(0xFFE0826F)],
              ),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFF1B1B1F),
            Color(0xFF2A2335),
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.tag, color: Color(0xFF9EE6FF), size: 14),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Diagnosticable · visual deep demo · sister of '
              'diagnosticable_tree_test.dart',
              style: TextStyle(
                color: Color(0xFFE6E1FF),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            child: const Text(
              'v1 · static snapshot',
              style: TextStyle(
                color: Color(0xFFB6F2C5),
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared widgets
// ---------------------------------------------------------------------------
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

enum _LineKind { code, comment, annotation }

class _CodeLine {
  final String text;
  final _LineKind kind;
  const _CodeLine({required this.text, required this.kind});
}

class _CodeBlock extends StatelessWidget {
  final List<_CodeLine> lines;
  const _CodeBlock({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1E1B2E),
            Color(0xFF13101D),
          ],
        ),
        border: Border.all(color: const Color(0xFF3F3550)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F57),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEBC2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFF28C840),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'foo_config.dart',
                style: TextStyle(
                  color: Color(0xFF8A85B6),
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < lines.length; i++)
            _renderLine(i + 1, lines[i]),
        ],
      ),
    );
  }

  Widget _renderLine(int n, _CodeLine line) {
    final Color color;
    final FontStyle style;
    switch (line.kind) {
      case _LineKind.comment:
        color = _kCodeComment;
        style = FontStyle.italic;
        break;
      case _LineKind.annotation:
        color = _kCodeKeyword;
        style = FontStyle.normal;
        break;
      case _LineKind.code:
        color = _kCodeFg;
        style = FontStyle.normal;
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 26,
            child: Text(
              n.toString().padLeft(2, ' '),
              style: const TextStyle(
                color: Color(0xFF55507A),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              line.text.isEmpty ? ' ' : line.text,
              style: TextStyle(
                color: color,
                fontSize: 11.5,
                height: 1.45,
                fontStyle: style,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
