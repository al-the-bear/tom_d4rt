// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =============================================================================
//  Visual Deep Demo: DiagnosticableTree
// =============================================================================
//  Subject: package:flutter/foundation.dart  ->  DiagnosticableTree
//
//  This single-screen, hand-written demo replaces the previous tiny smoke test
//  for the DiagnosticableTree fixture. It pours into one scrollable view a
//  guided tour of the abstract class, the supporting Diagnostics types, and
//  the way the Flutter inspector consumes them. The demo deliberately avoids
//  any state, async work, controllers or timers; everything is a pure
//  declarative description tree.
//
//  Sections (14 total):
//    1.  Hero card with a "tree of nodes" graphic
//    2.  Anatomy of DiagnosticableTree = Diagnosticable + getChildren()
//    3.  debugFillProperties walkthrough with annotated code
//    4.  Sample subclass _DemoNode and the rendered toStringDeep output
//    5.  Console-styled toStringDeep code block
//    6.  DiagnosticPropertiesBuilder add* method gallery
//    7.  DiagnosticLevel enum strip
//    8.  debugDescribeChildren explainer
//    9.  Flutter Inspector / DevTools integration diagram (visual)
//   10.  Comparison: toString vs toStringShort vs toStringDeep
//   11.  Tree-formatting algorithm card (sparse vs dense vs offstage)
//   12.  Diagnosticable vs DiagnosticableTree feature matrix
//   13.  Pitfalls and best practices
//   14.  Footer
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Theme tokens (private to this fixture; underscore prefixes silence the
// "private types in public API" lint when this file is ingested by AST tools).
// -----------------------------------------------------------------------------

const Color _ink = Color(0xFF0B1120);
const Color _inkSoft = Color(0xFF334155);
const Color _inkMute = Color(0xFF64748B);
const Color _paper = Color(0xFFF8FAFC);
const Color _paperAlt = Color(0xFFEEF2F7);
const Color _line = Color(0xFFCBD5E1);
const Color _accent = Color(0xFF4F46E5);
const Color _accentAlt = Color(0xFF7C3AED);
const Color _mint = Color(0xFF059669);
const Color _amber = Color(0xFFD97706);
const Color _rose = Color(0xFFE11D48);
const Color _sky = Color(0xFF0284C7);
const Color _consoleBg = Color(0xFF0B1220);
const Color _consoleFg = Color(0xFFE2E8F0);
const Color _consoleDim = Color(0xFF94A3B8);
const Color _consoleHi = Color(0xFFFACC15);
const Color _consoleSt = Color(0xFF7DD3FC);

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
  fontSize: 11.5,
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
  height: 1.45,
);

const TextStyle _section = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: _ink,
  letterSpacing: -0.2,
);

const TextStyle _label = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: _accent,
  letterSpacing: 1.4,
);

const TextStyle _body = TextStyle(
  fontSize: 13.5,
  height: 1.5,
  color: _inkSoft,
);

const TextStyle _bodyStrong = TextStyle(
  fontSize: 13.5,
  height: 1.5,
  color: _ink,
  fontWeight: FontWeight.w600,
);

// -----------------------------------------------------------------------------
// Plain data shapes used by various sections. They are not diagnosable;
// the goal of this file is to *talk about* DiagnosticableTree, not to be one.
// -----------------------------------------------------------------------------

class _DemoNode {
  const _DemoNode({
    required this.label,
    required this.kind,
    this.depth = 0,
    this.flagged = false,
    this.weight = 0,
    this.tint = _accent,
    this.children = const <_DemoNode>[],
  });

  final String label;
  final String kind;
  final int depth;
  final bool flagged;
  final int weight;
  final Color tint;
  final List<_DemoNode> children;
}

class _PropEntry {
  const _PropEntry({
    required this.title,
    required this.kind,
    required this.summary,
    required this.example,
    required this.tint,
  });

  final String title;
  final String kind;
  final String summary;
  final String example;
  final Color tint;
}

class _LevelEntry {
  const _LevelEntry({
    required this.name,
    required this.glyph,
    required this.purpose,
    required this.tint,
  });

  final String name;
  final String glyph;
  final String purpose;
  final Color tint;
}

class _StyleEntry {
  const _StyleEntry({
    required this.name,
    required this.summary,
    required this.glyph,
    required this.tint,
  });

  final String name;
  final String summary;
  final String glyph;
  final Color tint;
}

class _MatrixRow {
  const _MatrixRow({
    required this.feature,
    required this.diagnosticable,
    required this.diagnosticableTree,
  });

  final String feature;
  final String diagnosticable;
  final String diagnosticableTree;
}

class _PitfallEntry {
  const _PitfallEntry({
    required this.title,
    required this.bad,
    required this.good,
    required this.tint,
  });

  final String title;
  final String bad;
  final String good;
  final Color tint;
}

class _Step {
  const _Step({required this.n, required this.title, required this.body});
  final int n;
  final String title;
  final String body;
}

// -----------------------------------------------------------------------------
// Sample tree (pure data; mirrors the structure we will *describe* using
// DiagnosticableTree's vocabulary in the visual sections).
// -----------------------------------------------------------------------------

_DemoNode _buildSampleTree() {
  const _DemoNode toolbar = _DemoNode(
    label: 'Toolbar',
    kind: 'AppBarSlot',
    depth: 2,
    weight: 3,
    tint: _accentAlt,
  );
  const _DemoNode logo = _DemoNode(
    label: 'Logo',
    kind: 'ImageSlot',
    depth: 2,
    weight: 1,
    tint: _mint,
  );
  const _DemoNode header = _DemoNode(
    label: 'Header',
    kind: 'Region',
    depth: 1,
    weight: 4,
    flagged: true,
    tint: _accent,
    children: <_DemoNode>[toolbar, logo],
  );
  const _DemoNode listTile = _DemoNode(
    label: 'ListTile',
    kind: 'Item',
    depth: 2,
    weight: 1,
    tint: _sky,
  );
  const _DemoNode footnote = _DemoNode(
    label: 'Footnote',
    kind: 'Caption',
    depth: 2,
    weight: 1,
    tint: _inkMute,
  );
  const _DemoNode body = _DemoNode(
    label: 'Body',
    kind: 'Region',
    depth: 1,
    weight: 5,
    tint: _accentAlt,
    children: <_DemoNode>[listTile, footnote],
  );
  const _DemoNode footer = _DemoNode(
    label: 'Footer',
    kind: 'Region',
    depth: 1,
    weight: 2,
    tint: _amber,
  );
  return const _DemoNode(
    label: 'AppShell',
    kind: 'Root',
    depth: 0,
    weight: 11,
    tint: _accent,
    children: <_DemoNode>[header, body, footer],
  );
}

// -----------------------------------------------------------------------------
// Reusable presentational widgets
// -----------------------------------------------------------------------------

class _Card extends StatelessWidget {
  const _Card({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color = Colors.white,
    this.borderColor = _line,
    this.borderRadius = 18,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color borderColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.tag,
    required this.title,
    required this.subtitle,
    this.tint = _accent,
  });

  final String tag;
  final String title;
  final String subtitle;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: tint.withValues(alpha: 0.35)),
          ),
          child: Text(
            tag,
            style: _label.copyWith(color: tint, letterSpacing: 1.4),
          ),
        ),
        SizedBox(height: 10),
        Text(title, style: _section),
        SizedBox(height: 6),
        Text(subtitle, style: _body),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.tint});

  final String text;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tint.withValues(alpha: 0.40)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: tint,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: _line);
  }
}

class _ConsoleBlock extends StatelessWidget {
  const _ConsoleBlock({required this.lines, this.title});

  final List<TextSpan> lines;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _consoleBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _ink.withValues(alpha: 0.40)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null) ...<Widget>[
            Row(
              children: <Widget>[
                _ConsoleDot(color: Color(0xFFEF4444)),
                SizedBox(width: 6),
                _ConsoleDot(color: Color(0xFFF59E0B)),
                SizedBox(width: 6),
                _ConsoleDot(color: Color(0xFF22C55E)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title!,
                    style: TextStyle(
                      color: _consoleDim,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
          RichText(
            text: TextSpan(
              style: _mono,
              children: <InlineSpan>[
                for (int i = 0; i < lines.length; i++) ...<InlineSpan>[
                  lines[i],
                  if (i < lines.length - 1) TextSpan(text: '\n'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsoleDot extends StatelessWidget {
  const _ConsoleDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

TextSpan _consoleLine(String text, {Color? color, FontWeight? weight}) {
  return TextSpan(
    text: text,
    style: _mono.copyWith(color: color ?? _consoleFg, fontWeight: weight),
  );
}

TextSpan _consoleSeq(List<TextSpan> spans) {
  return TextSpan(children: spans);
}

// -----------------------------------------------------------------------------
// Entry point — single static MaterialApp, no setState anywhere.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  final _DemoNode tree = _buildSampleTree();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DiagnosticableTree Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _paper,
      colorScheme: ColorScheme.fromSeed(seedColor: _accent),
      textTheme: Typography.blackMountainView.apply(
        bodyColor: _ink,
        displayColor: _ink,
      ),
    ),
    home: Scaffold(
      backgroundColor: _paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 56),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _HeroSection(tree: tree),
                SizedBox(height: 28),
                _AnatomySection(),
                SizedBox(height: 28),
                _DebugFillPropertiesSection(),
                SizedBox(height: 28),
                _SampleSubclassSection(),
                SizedBox(height: 28),
                _ToStringDeepConsoleSection(),
                SizedBox(height: 28),
                _PropertiesBuilderGallerySection(),
                SizedBox(height: 28),
                _DiagnosticLevelSection(),
                SizedBox(height: 28),
                _DescribeChildrenSection(),
                SizedBox(height: 28),
                _DevToolsSection(),
                SizedBox(height: 28),
                _ToStringComparisonSection(),
                SizedBox(height: 28),
                _TreeStyleAlgorithmSection(),
                SizedBox(height: 28),
                _DiagnosticableMatrixSection(),
                SizedBox(height: 28),
                _PitfallsSection(),
                SizedBox(height: 28),
                _Footer(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Section 1 — Hero
// =============================================================================

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.tree});
  final _DemoNode tree;

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: EdgeInsets.all(28),
      borderRadius: 24,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _Pill(text: 'foundation.dart', tint: _accent),
                    SizedBox(width: 8),
                    _Pill(text: 'abstract class', tint: _accentAlt),
                    SizedBox(width: 8),
                    _Pill(text: 'inspector', tint: _mint),
                  ],
                ),
                SizedBox(height: 14),
                Text('DiagnosticableTree', style: _title),
                SizedBox(height: 10),
                Text(
                  'A Diagnosticable that has a list of children and therefore '
                  'knows how to print itself as a tree. Widget, Element and '
                  'RenderObject all extend DiagnosticableTree, which is what '
                  'lets the Flutter Inspector render the live UI as a clickable '
                  'hierarchy and what gives toStringDeep() its glyphs.',
                  style: _subtitle,
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    _Pill(text: 'debugFillProperties()', tint: _accent),
                    _Pill(text: 'debugDescribeChildren()', tint: _accentAlt),
                    _Pill(text: 'toStringDeep()', tint: _mint),
                    _Pill(text: 'toDiagnosticsNode()', tint: _amber),
                    _Pill(text: 'toStringShort()', tint: _sky),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 28),
          Expanded(
            flex: 5,
            child: _HeroTreeGraphic(tree: tree),
          ),
        ],
      ),
    );
  }
}

class _HeroTreeGraphic extends StatelessWidget {
  const _HeroTreeGraphic({required this.tree});
  final _DemoNode tree;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _paperAlt,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _line),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('DESCRIBED TREE', style: _label),
          SizedBox(height: 10),
          _TreeGlyphNode(node: tree, isRoot: true),
        ],
      ),
    );
  }
}

class _TreeGlyphNode extends StatelessWidget {
  const _TreeGlyphNode({required this.node, this.isRoot = false});
  final _DemoNode node;
  final bool isRoot;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 6),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: node.tint.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: node.tint.withValues(alpha: 0.55)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: node.tint,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '${node.label}  ',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
              Text(
                '<${node.kind}>',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _inkMute,
                ),
              ),
              if (node.flagged) ...<Widget>[
                SizedBox(width: 8),
                _Pill(text: 'FLAGGED', tint: _rose),
              ],
            ],
          ),
        ),
        if (node.children.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final _DemoNode child in node.children)
                  _TreeGlyphNode(node: child),
              ],
            ),
          ),
      ],
    );
  }
}

// =============================================================================
// Section 2 — Anatomy: DiagnosticableTree = Diagnosticable + getChildren()
// =============================================================================

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '02 — ANATOMY',
            title: 'DiagnosticableTree = Diagnosticable + children',
            subtitle:
                'DiagnosticableTree extends Diagnosticable. It adds the ability '
                'to enumerate child diagnostics nodes, which the rendering '
                'layer chains together to produce the recognisable indented '
                'tree-with-glyphs you see in the console and in DevTools.',
            tint: _accentAlt,
          ),
          SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _AnatomyBlock(
                  tag: 'INHERITS',
                  title: 'Diagnosticable',
                  tint: _accent,
                  rows: const <List<String>>[
                    <String>['toString()', 'A short, single-line description'],
                    <String>['toStringShort()', 'Just the runtimeType label'],
                    <String>[
                      'toDiagnosticsNode()',
                      'Wraps "this" as a DiagnosticsNode'
                    ],
                    <String>[
                      'debugFillProperties()',
                      'Build a flat list of properties'
                    ],
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _AnatomyBlock(
                  tag: 'ADDS',
                  title: 'DiagnosticableTree',
                  tint: _mint,
                  rows: const <List<String>>[
                    <String>[
                      'debugDescribeChildren()',
                      'Returns a List<DiagnosticsNode> of children'
                    ],
                    <String>[
                      'toStringDeep()',
                      'Recursive, indented multi-line dump'
                    ],
                    <String>[
                      'toStringShallow()',
                      'Like toStringDeep but only one level'
                    ],
                    <String>[
                      'toDiagnosticsNode()',
                      'Style defaults to DiagnosticsTreeStyle.sparse'
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          _Divider(),
          SizedBox(height: 18),
          Text(
            'Inheritance chain — DiagnosticableTree is the layer that turns a '
            'flat property bag into a hierarchy:',
            style: _body,
          ),
          SizedBox(height: 12),
          _InheritanceChain(),
        ],
      ),
    );
  }
}

class _AnatomyBlock extends StatelessWidget {
  const _AnatomyBlock({
    required this.tag,
    required this.title,
    required this.tint,
    required this.rows,
  });

  final String tag;
  final String title;
  final Color tint;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _Pill(text: tag, tint: tint),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: tint,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          for (final List<String> row in rows)
            Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(top: 8, right: 8),
                    decoration: BoxDecoration(
                      color: tint,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(row[0],
                            style: _monoInk.copyWith(
                              fontWeight: FontWeight.w700,
                            )),
                        Text(row[1], style: _body),
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

class _InheritanceChain extends StatelessWidget {
  const _InheritanceChain();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _paperAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      child: Row(
        children: <Widget>[
          _ChainBox(label: 'Object', tint: _inkMute),
          _ChainArrow(),
          _ChainBox(label: 'Diagnosticable', tint: _accent),
          _ChainArrow(),
          _ChainBox(label: 'DiagnosticableTree', tint: _accentAlt, primary: true),
          _ChainArrow(),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                _ChainBox(label: 'Widget', tint: _mint),
                _ChainBox(label: 'Element', tint: _sky),
                _ChainBox(label: 'RenderObject', tint: _amber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChainBox extends StatelessWidget {
  const _ChainBox({
    required this.label,
    required this.tint,
    this.primary = false,
  });

  final String label;
  final Color tint;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: primary ? 0.18 : 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: tint.withValues(alpha: 0.55),
          width: primary ? 1.5 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: primary ? FontWeight.w800 : FontWeight.w600,
          color: tint,
        ),
      ),
    );
  }
}

class _ChainArrow extends StatelessWidget {
  const _ChainArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.arrow_forward_rounded, size: 16, color: _inkMute),
    );
  }
}

// =============================================================================
// Section 3 — debugFillProperties walkthrough
// =============================================================================

class _DebugFillPropertiesSection extends StatelessWidget {
  const _DebugFillPropertiesSection();

  @override
  Widget build(BuildContext context) {
    final List<_Step> steps = const <_Step>[
      _Step(
        n: 1,
        title: 'Override the method',
        body:
            'Subclasses override debugFillProperties(DiagnosticPropertiesBuilder '
            'properties) and ALWAYS call super first. The super call lets '
            'parent classes contribute their own diagnostics before yours.',
      ),
      _Step(
        n: 2,
        title: 'Build properties with a typed factory',
        body:
            'Each instance field is wrapped in a typed DiagnosticsProperty: '
            'IntProperty for ints, DoubleProperty for doubles, FlagProperty '
            'for bools, EnumProperty<E> for enums, IterableProperty<T> for '
            'lists, and DiagnosticsProperty<T> for everything else.',
      ),
      _Step(
        n: 3,
        title: 'Tag with metadata',
        body:
            'Use defaultValue: to hide boring values, level: to demote rarely '
            'useful entries to fine, ifTrue/ifFalse: for boolean flags and '
            'description: for friendlier inspector labels.',
      ),
      _Step(
        n: 4,
        title: 'Push to the builder',
        body:
            'properties.add(...) appends to the ordered list that the inspector '
            'and toString() machinery later reads. Order matters — important '
            'fields first.',
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '03 — debugFillProperties',
            title: 'How a subclass tells Diagnostics what it has',
            subtitle:
                'debugFillProperties is the only hook every Diagnosticable '
                'subclass should override. DiagnosticableTree adds '
                'debugDescribeChildren on top, which we cover in section 8.',
            tint: _accent,
          ),
          SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (final _Step step in steps) _StepCard(step: step),
                  ],
                ),
              ),
              SizedBox(width: 18),
              Expanded(
                flex: 6,
                child: _CodeBlock(
                  title: 'lib/widgets/region_card.dart',
                  lines: const <_CodeLine>[
                    _CodeLine('class RegionCard extends StatelessWidget {',
                        kind: _CodeKind.keyword),
                    _CodeLine('  const RegionCard({'),
                    _CodeLine('    super.key,'),
                    _CodeLine('    required this.label,'),
                    _CodeLine('    required this.depth,'),
                    _CodeLine('    this.weight = 0,'),
                    _CodeLine('    this.flagged = false,'),
                    _CodeLine('    this.tint = Colors.indigo,'),
                    _CodeLine('  });'),
                    _CodeLine(''),
                    _CodeLine('  final String label;'),
                    _CodeLine('  final int depth;'),
                    _CodeLine('  final int weight;'),
                    _CodeLine('  final bool flagged;'),
                    _CodeLine('  final Color tint;'),
                    _CodeLine(''),
                    _CodeLine('  @override', kind: _CodeKind.annotation),
                    _CodeLine('  void debugFillProperties('),
                    _CodeLine('      DiagnosticPropertiesBuilder properties,'),
                    _CodeLine('  ) {'),
                    _CodeLine('    super.debugFillProperties(properties);',
                        kind: _CodeKind.call),
                    _CodeLine(
                        "    properties.add(StringProperty('label', label));"),
                    _CodeLine(
                        "    properties.add(IntProperty('depth', depth));"),
                    _CodeLine(
                        "    properties.add(IntProperty('weight', weight,"),
                    _CodeLine('        defaultValue: 0));'),
                    _CodeLine('    properties.add(FlagProperty('),
                    _CodeLine("        'flagged',"),
                    _CodeLine('        value: flagged,'),
                    _CodeLine("        ifTrue: 'FLAGGED',"),
                    _CodeLine("        ifFalse: 'normal',"),
                    _CodeLine('    ));'),
                    _CodeLine(
                        "    properties.add(ColorProperty('tint', tint));"),
                    _CodeLine('  }'),
                    _CodeLine('}'),
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

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step});
  final _Step step;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _paperAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _accent.withValues(alpha: 0.45)),
            ),
            child: Text(
              '${step.n}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _accent,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(step.title, style: _bodyStrong),
                SizedBox(height: 4),
                Text(step.body, style: _body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _CodeKind { plain, keyword, annotation, call, comment, string }

class _CodeLine {
  const _CodeLine(this.text, {this.kind = _CodeKind.plain});
  final String text;
  final _CodeKind kind;
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.title, required this.lines});

  final String title;
  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _consoleBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _ink.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _ConsoleDot(color: Color(0xFFEF4444)),
              SizedBox(width: 6),
              _ConsoleDot(color: Color(0xFFF59E0B)),
              SizedBox(width: 6),
              _ConsoleDot(color: Color(0xFF22C55E)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _consoleDim,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          for (final _CodeLine line in lines)
            Text(
              line.text.isEmpty ? ' ' : line.text,
              style: _mono.copyWith(color: _codeColor(line.kind)),
            ),
        ],
      ),
    );
  }

  Color _codeColor(_CodeKind kind) {
    switch (kind) {
      case _CodeKind.keyword:
        return Color(0xFFA78BFA);
      case _CodeKind.annotation:
        return Color(0xFFFBBF24);
      case _CodeKind.call:
        return Color(0xFF7DD3FC);
      case _CodeKind.comment:
        return _consoleDim;
      case _CodeKind.string:
        return Color(0xFF86EFAC);
      case _CodeKind.plain:
        return _consoleFg;
    }
  }
}

// =============================================================================
// Section 4 — Sample subclass that extends DiagnosticableTree
// =============================================================================

class _SampleSubclassSection extends StatelessWidget {
  const _SampleSubclassSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '04 — SAMPLE SUBCLASS',
            title: 'class TreeNode extends DiagnosticableTree',
            subtitle:
                'A non-widget Diagnosticable tree. Notice both overrides: '
                'debugFillProperties (for the labels) and debugDescribeChildren '
                '(for the children that toStringDeep recurses into).',
            tint: _mint,
          ),
          SizedBox(height: 18),
          _CodeBlock(
            title: 'lib/tree_node.dart',
            lines: const <_CodeLine>[
              _CodeLine("import 'package:flutter/foundation.dart';",
                  kind: _CodeKind.keyword),
              _CodeLine(''),
              _CodeLine('class TreeNode extends DiagnosticableTree {',
                  kind: _CodeKind.keyword),
              _CodeLine('  TreeNode({'),
              _CodeLine('    required this.label,'),
              _CodeLine('    required this.kind,'),
              _CodeLine('    this.depth = 0,'),
              _CodeLine('    this.weight = 0,'),
              _CodeLine('    this.flagged = false,'),
              _CodeLine('    this.tint = const Color(0xFF4F46E5),'),
              _CodeLine('    this.children = const <TreeNode>[],'),
              _CodeLine('  });'),
              _CodeLine(''),
              _CodeLine('  final String label;'),
              _CodeLine('  final String kind;'),
              _CodeLine('  final int depth;'),
              _CodeLine('  final int weight;'),
              _CodeLine('  final bool flagged;'),
              _CodeLine('  final Color tint;'),
              _CodeLine('  final List<TreeNode> children;'),
              _CodeLine(''),
              _CodeLine('  @override', kind: _CodeKind.annotation),
              _CodeLine(
                  "  String toStringShort() => 'TreeNode(\$label / \$kind)';"),
              _CodeLine(''),
              _CodeLine('  @override', kind: _CodeKind.annotation),
              _CodeLine('  void debugFillProperties('),
              _CodeLine('      DiagnosticPropertiesBuilder properties,'),
              _CodeLine('  ) {'),
              _CodeLine('    super.debugFillProperties(properties);',
                  kind: _CodeKind.call),
              _CodeLine("    properties.add(StringProperty('label', label));"),
              _CodeLine("    properties.add(StringProperty('kind', kind));"),
              _CodeLine("    properties.add(IntProperty('depth', depth));"),
              _CodeLine(
                  "    properties.add(IntProperty('weight', weight, defaultValue: 0));"),
              _CodeLine('    properties.add(FlagProperty('),
              _CodeLine("        'flagged',"),
              _CodeLine('        value: flagged,'),
              _CodeLine("        ifTrue: 'FLAGGED',"),
              _CodeLine("        ifFalse: 'normal',"),
              _CodeLine('        level: DiagnosticLevel.info,'),
              _CodeLine('    ));'),
              _CodeLine("    properties.add(ColorProperty('tint', tint));"),
              _CodeLine('  }'),
              _CodeLine(''),
              _CodeLine('  @override', kind: _CodeKind.annotation),
              _CodeLine('  List<DiagnosticsNode> debugDescribeChildren() {'),
              _CodeLine('    return <DiagnosticsNode>['),
              _CodeLine('      for (int i = 0; i < children.length; i++)'),
              _CodeLine(
                  "        children[i].toDiagnosticsNode(name: 'child[\$i]'),"),
              _CodeLine('    ];'),
              _CodeLine('  }'),
              _CodeLine('}'),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _mint.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _mint.withValues(alpha: 0.40)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.lightbulb_outline,
                    color: _mint, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Notice that TreeNode is NOT a Widget. DiagnosticableTree '
                    'is useful for any object you want to surface in the '
                    'inspector or print as a tree — controllers, models, '
                    'configuration trees, parser ASTs, scene graphs, and so on.',
                    style: _body,
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

// =============================================================================
// Section 5 — toStringDeep console output
// =============================================================================

class _ToStringDeepConsoleSection extends StatelessWidget {
  const _ToStringDeepConsoleSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '05 — toStringDeep()',
            title: 'What the renderer produces',
            subtitle:
                'Below is the output that AppShell.toStringDeep() would write '
                'to the console once TreeNode from the previous section is '
                'instantiated for the AppShell sample tree. Notice the glyphs: '
                '"\u2502" for a continuation, "\u251C\u2500" for a child, '
                '"\u2514\u2500" for the last child, and the indented '
                'property block under each header.',
            tint: _accent,
          ),
          SizedBox(height: 16),
          _ConsoleBlock(
            title: r'$ dart run — print(appShell.toStringDeep())',
            lines: <TextSpan>[
              _consoleLine(
                'TreeNode(AppShell / Root)',
                color: _consoleHi,
                weight: FontWeight.w700,
              ),
              _consoleLine('\u2502   label: "AppShell"'),
              _consoleLine('\u2502   kind: "Root"'),
              _consoleLine('\u2502   depth: 0'),
              _consoleLine('\u2502   weight: 11'),
              _consoleLine('\u2502   flagged: normal'),
              _consoleLine('\u2502   tint: Color(0xff4f46e5)',
                  color: _consoleSt),
              _consoleLine('\u2502'),
              _consoleSeq(<TextSpan>[
                _consoleLine('\u251C\u2500'),
                _consoleLine('child[0]: ', color: _consoleDim),
                _consoleLine('TreeNode(Header / Region)',
                    color: _consoleHi, weight: FontWeight.w700),
              ]),
              _consoleLine('\u2502 \u2502   label: "Header"'),
              _consoleLine('\u2502 \u2502   kind: "Region"'),
              _consoleLine('\u2502 \u2502   depth: 1'),
              _consoleLine('\u2502 \u2502   weight: 4'),
              _consoleLine('\u2502 \u2502   flagged: FLAGGED',
                  color: Color(0xFFF87171), weight: FontWeight.w700),
              _consoleLine('\u2502 \u2502   tint: Color(0xff4f46e5)',
                  color: _consoleSt),
              _consoleLine('\u2502 \u2502'),
              _consoleSeq(<TextSpan>[
                _consoleLine('\u2502 \u251C\u2500'),
                _consoleLine('child[0]: ', color: _consoleDim),
                _consoleLine('TreeNode(Toolbar / AppBarSlot)',
                    color: _consoleHi, weight: FontWeight.w700),
              ]),
              _consoleLine('\u2502 \u2502     label: "Toolbar"'),
              _consoleLine('\u2502 \u2502     kind: "AppBarSlot"'),
              _consoleLine('\u2502 \u2502     depth: 2'),
              _consoleLine('\u2502 \u2502     weight: 3'),
              _consoleLine('\u2502 \u2502     flagged: normal'),
              _consoleLine('\u2502 \u2502     tint: Color(0xff7c3aed)',
                  color: _consoleSt),
              _consoleLine('\u2502 \u2502'),
              _consoleSeq(<TextSpan>[
                _consoleLine('\u2502 \u2514\u2500'),
                _consoleLine('child[1]: ', color: _consoleDim),
                _consoleLine('TreeNode(Logo / ImageSlot)',
                    color: _consoleHi, weight: FontWeight.w700),
              ]),
              _consoleLine('\u2502       label: "Logo"'),
              _consoleLine('\u2502       kind: "ImageSlot"'),
              _consoleLine('\u2502       depth: 2'),
              _consoleLine('\u2502       weight: 1'),
              _consoleLine('\u2502       flagged: normal'),
              _consoleLine('\u2502       tint: Color(0xff059669)',
                  color: _consoleSt),
              _consoleLine('\u2502'),
              _consoleSeq(<TextSpan>[
                _consoleLine('\u251C\u2500'),
                _consoleLine('child[1]: ', color: _consoleDim),
                _consoleLine('TreeNode(Body / Region)',
                    color: _consoleHi, weight: FontWeight.w700),
              ]),
              _consoleLine('\u2502 \u2502   label: "Body"'),
              _consoleLine('\u2502 \u2502   kind: "Region"'),
              _consoleLine('\u2502 \u2502   depth: 1'),
              _consoleLine('\u2502 \u2502   weight: 5'),
              _consoleLine('\u2502 \u2502   flagged: normal'),
              _consoleLine('\u2502 \u2502   tint: Color(0xff7c3aed)',
                  color: _consoleSt),
              _consoleLine('\u2502 \u2502'),
              _consoleSeq(<TextSpan>[
                _consoleLine('\u2502 \u251C\u2500'),
                _consoleLine('child[0]: ', color: _consoleDim),
                _consoleLine('TreeNode(ListTile / Item)',
                    color: _consoleHi, weight: FontWeight.w700),
              ]),
              _consoleLine('\u2502 \u2502     label: "ListTile"'),
              _consoleLine('\u2502 \u2502     depth: 2'),
              _consoleLine('\u2502 \u2502     weight: 1'),
              _consoleLine('\u2502 \u2502'),
              _consoleSeq(<TextSpan>[
                _consoleLine('\u2502 \u2514\u2500'),
                _consoleLine('child[1]: ', color: _consoleDim),
                _consoleLine('TreeNode(Footnote / Caption)',
                    color: _consoleHi, weight: FontWeight.w700),
              ]),
              _consoleLine('\u2502       label: "Footnote"'),
              _consoleLine('\u2502       depth: 2'),
              _consoleLine('\u2502       weight: 1'),
              _consoleLine('\u2502'),
              _consoleSeq(<TextSpan>[
                _consoleLine('\u2514\u2500'),
                _consoleLine('child[2]: ', color: _consoleDim),
                _consoleLine('TreeNode(Footer / Region)',
                    color: _consoleHi, weight: FontWeight.w700),
              ]),
              _consoleLine('      label: "Footer"'),
              _consoleLine('      depth: 1'),
              _consoleLine('      weight: 2'),
              _consoleLine('      flagged: normal'),
              _consoleLine('      tint: Color(0xffd97706)',
                  color: _consoleSt),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Output is recursively assembled by the framework — your subclass '
            'never has to deal with prefixes or indentation. You only describe '
            'WHAT the node holds; the renderer decides HOW to draw the joints.',
            style: _body,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 6 — DiagnosticPropertiesBuilder add* gallery
// =============================================================================

class _PropertiesBuilderGallerySection extends StatelessWidget {
  const _PropertiesBuilderGallerySection();

  @override
  Widget build(BuildContext context) {
    final List<_PropEntry> entries = const <_PropEntry>[
      _PropEntry(
        title: 'StringProperty',
        kind: 'String',
        summary: 'Quoted string with optional defaultValue.',
        example: "StringProperty('label', label, defaultValue: 'untitled')",
        tint: _accent,
      ),
      _PropEntry(
        title: 'IntProperty',
        kind: 'int',
        summary: 'Decimal int with optional unit suffix and defaultValue.',
        example: "IntProperty('depth', depth, defaultValue: 0)",
        tint: _accentAlt,
      ),
      _PropEntry(
        title: 'DoubleProperty',
        kind: 'double',
        summary: 'Float with optional unit and tolerance — handy for sizes.',
        example: "DoubleProperty('opacity', opacity, unit: 'x', defaultValue: 1.0)",
        tint: _mint,
      ),
      _PropEntry(
        title: 'FlagProperty',
        kind: 'bool',
        summary: 'Renders ifTrue/ifFalse text instead of "true"/"false".',
        example:
            "FlagProperty('flagged', value: flagged, ifTrue: 'FLAGGED', ifFalse: 'normal')",
        tint: _amber,
      ),
      _PropEntry(
        title: 'EnumProperty<T>',
        kind: 'enum',
        summary: 'Prints "EnumName.value" with optional defaultValue.',
        example:
            "EnumProperty<DiagnosticLevel>('level', level, defaultValue: DiagnosticLevel.info)",
        tint: _sky,
      ),
      _PropEntry(
        title: 'IterableProperty<T>',
        kind: 'List/Iterable',
        summary: 'Comma-separated short list with optional style override.',
        example:
            "IterableProperty<TreeNode>('children', children)",
        tint: _rose,
      ),
      _PropEntry(
        title: 'DiagnosticsProperty<T>',
        kind: 'any',
        summary:
            'Generic container — fall back here when no specialised property '
            'exists for your value type.',
        example:
            "DiagnosticsProperty<EdgeInsets>('padding', padding, defaultValue: EdgeInsets.zero)",
        tint: _accent,
      ),
      _PropEntry(
        title: 'ColorProperty',
        kind: 'Color',
        summary: 'Renders as Color(0xAARRGGBB) — easy to spot in console logs.',
        example: "ColorProperty('tint', tint, defaultValue: Colors.black)",
        tint: _accentAlt,
      ),
      _PropEntry(
        title: 'ObjectFlagProperty<T>',
        kind: 'T?',
        summary:
            'Like FlagProperty for nullable references — ifNull / ifPresent.',
        example:
            "ObjectFlagProperty<VoidCallback>.has('onTap', onTap)",
        tint: _mint,
      ),
      _PropEntry(
        title: 'PercentProperty',
        kind: 'double',
        summary: 'Wraps a 0..1 double and renders it as a percentage.',
        example: "PercentProperty('progress', progress)",
        tint: _amber,
      ),
      _PropEntry(
        title: 'MessageProperty',
        kind: 'String',
        summary:
            'Plain "name: message" pair — useful for a free-form note.',
        example:
            "MessageProperty('mode', 'detached, awaiting attach()')",
        tint: _sky,
      ),
      _PropEntry(
        title: 'StackTraceProperty',
        kind: 'StackTrace',
        summary: 'Lazy stack trace formatting with optional filtering.',
        example:
            "DiagnosticsStackTrace('captured', stack, showSeparator: false)",
        tint: _rose,
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '06 — DiagnosticPropertiesBuilder',
            title: 'add* method gallery',
            subtitle:
                'DiagnosticPropertiesBuilder is the accumulator passed into '
                'debugFillProperties. It exposes a single .add(DiagnosticsNode) '
                'method, but in practice you always feed it one of these '
                'pre-built properties so the inspector and console can format '
                'each value with the right decorations.',
            tint: _accentAlt,
          ),
          SizedBox(height: 18),
          // 20260524-2003 baseline §6/H-hardly1 todo #15
          // (diagnosticable_tree_test): 9 _PropEntry × 6.3 px bottom
          // overflow in this 2-col grid (childAspectRatio: 2.05 gives
          // cell height ≈ 167 px but _PropCard natural ≈ 173 px). Drop
          // to 1.85 for a few px of headroom.
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.85,
            children: <Widget>[
              for (final _PropEntry entry in entries) _PropCard(entry: entry),
            ],
          ),
        ],
      ),
    );
  }
}

class _PropCard extends StatelessWidget {
  const _PropCard({required this.entry});
  final _PropEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: entry.tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: entry.tint.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  entry.title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: entry.tint,
                  ),
                ),
              ),
              _Pill(text: entry.kind, tint: entry.tint),
            ],
          ),
          SizedBox(height: 6),
          Text(entry.summary, style: _body),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _consoleBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ink.withValues(alpha: 0.40)),
            ),
            child: Text(
              entry.example,
              style: _mono.copyWith(fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 7 — DiagnosticLevel enum strip
// =============================================================================

class _DiagnosticLevelSection extends StatelessWidget {
  const _DiagnosticLevelSection();

  @override
  Widget build(BuildContext context) {
    final List<_LevelEntry> levels = const <_LevelEntry>[
      _LevelEntry(
        name: 'hidden',
        glyph: '\u25CB',
        purpose:
            'Always omit. Used to mute properties that have a defaultValue '
            'and currently equal it.',
        tint: _inkMute,
      ),
      _LevelEntry(
        name: 'fine',
        glyph: '\u25C7',
        purpose:
            'Only useful when explicitly asked for. Flutter inspector hides '
            'these by default.',
        tint: _sky,
      ),
      _LevelEntry(
        name: 'debug',
        glyph: '\u25C9',
        purpose:
            'Useful in debug-only build mode. Suppressed in release builds.',
        tint: _accent,
      ),
      _LevelEntry(
        name: 'info',
        glyph: '\u25A0',
        purpose:
            'Default level. Appears in toString, toStringDeep and the '
            'inspector.',
        tint: _accentAlt,
      ),
      _LevelEntry(
        name: 'warning',
        glyph: '\u25B2',
        purpose:
            'Property reflects something unusual; the inspector tints these '
            'amber.',
        tint: _amber,
      ),
      _LevelEntry(
        name: 'hint',
        glyph: '\u25CE',
        purpose:
            'Suggestion attached to a node. Used for "Did you mean…" copy.',
        tint: _mint,
      ),
      _LevelEntry(
        name: 'summary',
        glyph: '\u2605',
        purpose:
            'Top-line summary that always renders even when the node is '
            'collapsed.',
        tint: _accent,
      ),
      _LevelEntry(
        name: 'error',
        glyph: '\u25BC',
        purpose:
            'Property describes an error. Always rendered. Inspector tints '
            'red.',
        tint: _rose,
      ),
      _LevelEntry(
        name: 'off',
        glyph: '\u2715',
        purpose:
            'Property is suppressed entirely. Useful as a guard-rail for '
            'conditional output.',
        tint: _inkMute,
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '07 — DiagnosticLevel',
            title: 'Severity ladder for properties',
            subtitle:
                'Each DiagnosticsProperty carries a level. The renderer and '
                'inspector look at the level to decide whether to show, hide '
                'or highlight a property. Picking the right level keeps the '
                'output focused.',
            tint: _amber,
          ),
          SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final _LevelEntry level in levels)
                _LevelChip(level: level),
            ],
          ),
        ],
      ),
    );
  }
}

class _LevelChip extends StatelessWidget {
  const _LevelChip({required this.level});
  final _LevelEntry level;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: level.tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: level.tint.withValues(alpha: 0.40)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: level.tint.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: level.tint.withValues(alpha: 0.55)),
            ),
            child: Text(
              level.glyph,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: level.tint,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'DiagnosticLevel.${level.name}',
                  style: _monoInk.copyWith(
                    fontWeight: FontWeight.w700,
                    color: level.tint,
                  ),
                ),
                SizedBox(height: 2),
                Text(level.purpose, style: _body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 8 — debugDescribeChildren explainer
// =============================================================================

class _DescribeChildrenSection extends StatelessWidget {
  const _DescribeChildrenSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '08 — debugDescribeChildren',
            title: 'How a tree exposes its children',
            subtitle:
                'This is the override that distinguishes DiagnosticableTree '
                'from plain Diagnosticable. It returns a List<DiagnosticsNode> '
                '— each child wrapped (typically by toDiagnosticsNode) so the '
                'renderer knows what name and style to use for it.',
            tint: _sky,
          ),
          SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: _CodeBlock(
                  title: 'lib/tree_node.dart (excerpt)',
                  lines: const <_CodeLine>[
                    _CodeLine('@override', kind: _CodeKind.annotation),
                    _CodeLine('List<DiagnosticsNode> debugDescribeChildren() {'),
                    _CodeLine('  return <DiagnosticsNode>['),
                    _CodeLine(
                        '    // 1. Named, default style:',
                        kind: _CodeKind.comment),
                    _CodeLine(
                        "    header.toDiagnosticsNode(name: 'header'),"),
                    _CodeLine(''),
                    _CodeLine(
                        '    // 2. Anonymous slot:',
                        kind: _CodeKind.comment),
                    _CodeLine('    body.toDiagnosticsNode(),'),
                    _CodeLine(''),
                    _CodeLine(
                        '    // 3. Custom rendering style:',
                        kind: _CodeKind.comment),
                    _CodeLine('    footer.toDiagnosticsNode('),
                    _CodeLine("        name: 'footer',"),
                    _CodeLine(
                        '        style: DiagnosticsTreeStyle.dense,'),
                    _CodeLine('    ),'),
                    _CodeLine(''),
                    _CodeLine(
                        '    // 4. Loose / non-Diagnosticable child:',
                        kind: _CodeKind.comment),
                    _CodeLine('    DiagnosticsProperty<Object>('),
                    _CodeLine("        'overlay',"),
                    _CodeLine('        overlay,'),
                    _CodeLine('        style: DiagnosticsTreeStyle.error,'),
                    _CodeLine('    ),'),
                    _CodeLine('  ];'),
                    _CodeLine('}'),
                  ],
                ),
              ),
              SizedBox(width: 18),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _DescribeNote(
                      title: 'Naming children',
                      body:
                          'Always pass a name when the slot is meaningful — '
                          '"header", "body", "child[0]". The inspector shows '
                          'the name as the prefix of the child node.',
                      tint: _accent,
                    ),
                    _DescribeNote(
                      title: 'Picking a style',
                      body:
                          'DiagnosticsTreeStyle controls indentation and '
                          'glyphs. sparse is the default; dense is good for '
                          'long lists; offstage hides the node from console '
                          'output; error tints it red.',
                      tint: _accentAlt,
                    ),
                    _DescribeNote(
                      title: 'Order matters',
                      body:
                          'Children appear in the order returned. Match it to '
                          'the visual order of your widget so inspector tree '
                          'navigation feels natural.',
                      tint: _mint,
                    ),
                    _DescribeNote(
                      title: 'Skip null children',
                      body:
                          'Filter or use ObjectFlagProperty.has(...) to keep '
                          'unset slots from cluttering output.',
                      tint: _amber,
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

class _DescribeNote extends StatelessWidget {
  const _DescribeNote({
    required this.title,
    required this.body,
    required this.tint,
  });

  final String title;
  final String body;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: tint,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 4),
          Text(body, style: _body),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 9 — Flutter Inspector / DevTools integration (visual)
// =============================================================================

class _DevToolsSection extends StatelessWidget {
  const _DevToolsSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '09 — DEVTOOLS',
            title: 'How the Inspector consumes DiagnosticableTree',
            subtitle:
                'The Flutter inspector pulls each Element\'s diagnostics tree '
                'over the VM service. It walks debugDescribeChildren to draw '
                'the hierarchy and reads debugFillProperties to populate the '
                'right-hand details panel.',
            tint: _accent,
          ),
          SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: _paperAlt,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _line),
            ),
            padding: EdgeInsets.all(16),
            // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #15):
            // `Row(crossAxisAlignment: stretch)` inside the outer
            // SingleChildScrollView propagates infinite height to the
            // Expanded children. Wrap in IntrinsicHeight so the Row sizes
            // to its tallest intrinsic child.
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(flex: 4, child: _DevToolsTreePane()),
                  SizedBox(width: 14),
                  Expanded(flex: 5, child: _DevToolsDetailsPane()),
                ],
              ),
            ),
          ),
          SizedBox(height: 18),
          _DevToolsFlow(),
        ],
      ),
    );
  }
}

class _DevToolsTreePane extends StatelessWidget {
  const _DevToolsTreePane();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _paper,
              border: Border(bottom: BorderSide(color: _line)),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.account_tree_outlined, size: 14, color: _accent),
                SizedBox(width: 6),
                Text(
                  'Widget Tree',
                  style: _monoInk.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _DevToolsRow(
                    glyph: '\u25BC', label: 'MaterialApp', tint: _accent),
                _DevToolsRow(
                    glyph: '  \u25BC',
                    label: 'Scaffold',
                    tint: _accentAlt),
                _DevToolsRow(
                    glyph: '    \u25BC',
                    label: 'AppShell',
                    tint: _accent,
                    selected: true),
                _DevToolsRow(
                    glyph: '      \u25BC',
                    label: 'Header (RegionCard)',
                    tint: _accent),
                _DevToolsRow(
                    glyph: '        \u25CF',
                    label: 'Toolbar',
                    tint: _accentAlt),
                _DevToolsRow(
                    glyph: '        \u25CF',
                    label: 'Logo',
                    tint: _mint),
                _DevToolsRow(
                    glyph: '      \u25BC',
                    label: 'Body (RegionCard)',
                    tint: _accentAlt),
                _DevToolsRow(
                    glyph: '        \u25CF',
                    label: 'ListTile',
                    tint: _sky),
                _DevToolsRow(
                    glyph: '        \u25CF',
                    label: 'Footnote',
                    tint: _inkMute),
                _DevToolsRow(
                    glyph: '      \u25CF',
                    label: 'Footer',
                    tint: _amber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DevToolsRow extends StatelessWidget {
  const _DevToolsRow({
    required this.glyph,
    required this.label,
    required this.tint,
    this.selected = false,
  });

  final String glyph;
  final String label;
  final Color tint;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: selected
            ? tint.withValues(alpha: 0.10)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          Text(
            glyph,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: tint,
            ),
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: selected ? tint : _ink,
              fontWeight:
                  selected ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DevToolsDetailsPane extends StatelessWidget {
  const _DevToolsDetailsPane();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _paper,
              border: Border(bottom: BorderSide(color: _line)),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.tune_rounded, size: 14, color: _accentAlt),
                SizedBox(width: 6),
                Text(
                  'AppShell — Properties',
                  style: _monoInk.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _DevPropRow(name: 'label', value: '"AppShell"', tint: _accent),
                _DevPropRow(name: 'kind', value: '"Root"', tint: _accent),
                _DevPropRow(name: 'depth', value: '0', tint: _accentAlt),
                _DevPropRow(
                    name: 'weight',
                    value: '11',
                    tint: _accentAlt,
                    note: 'non-default'),
                _DevPropRow(
                    name: 'flagged', value: 'normal', tint: _mint),
                _DevPropRow(
                    name: 'tint',
                    value: 'Color(0xff4f46e5)',
                    tint: _accent,
                    swatch: true),
                _DevPropRow(
                    name: 'children',
                    value: '[Header, Body, Footer]',
                    tint: _amber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DevPropRow extends StatelessWidget {
  const _DevPropRow({
    required this.name,
    required this.value,
    required this.tint,
    this.note,
    this.swatch = false,
  });

  final String name;
  final String value;
  final Color tint;
  final String? note;
  final bool swatch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: _monoInk.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
                color: tint,
              ),
            ),
          ),
          if (swatch)
            Container(
              margin: EdgeInsets.only(right: 6, top: 2),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: _ink, width: 0.5),
              ),
            ),
          Expanded(
            child: Text(
              value,
              style: _mono.copyWith(color: _ink, fontSize: 11.5),
            ),
          ),
          if (note != null)
            Container(
              margin: EdgeInsets.only(left: 4),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _amber.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _amber.withValues(alpha: 0.40)),
              ),
              child: Text(
                note!,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.5,
                  color: _amber,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DevToolsFlow extends StatelessWidget {
  const _DevToolsFlow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _paperAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('DATA FLOW', style: _label),
          SizedBox(height: 8),
          Row(
            children: const <Widget>[
              _FlowBox(
                  label: 'Element',
                  sub: 'extends DiagnosticableTree',
                  tint: _accent),
              _FlowArrow(),
              _FlowBox(
                  label: 'WidgetInspectorService',
                  sub: 'serialises tree to JSON',
                  tint: _accentAlt),
              _FlowArrow(),
              _FlowBox(
                  label: 'VM Service',
                  sub: 'streams to DevTools',
                  tint: _mint),
              _FlowArrow(),
              _FlowBox(
                  label: 'Inspector UI',
                  sub: 'renders tree + details',
                  tint: _amber),
            ],
          ),
        ],
      ),
    );
  }
}

class _FlowBox extends StatelessWidget {
  const _FlowBox({required this.label, required this.sub, required this.tint});
  final String label;
  final String sub;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tint.withValues(alpha: 0.45)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: tint,
              ),
            ),
            SizedBox(height: 2),
            Text(
              sub,
              style: TextStyle(
                fontSize: 10.5,
                color: _inkSoft,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.east_rounded, size: 18, color: _inkMute),
    );
  }
}

// =============================================================================
// Section 10 — toString vs toStringShort vs toStringDeep
// =============================================================================

class _ToStringComparisonSection extends StatelessWidget {
  const _ToStringComparisonSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '10 — STRINGIFICATION',
            title: 'Three sibling methods, three audiences',
            subtitle:
                'DiagnosticableTree inherits toString and toStringShort from '
                'Diagnosticable but adds toStringDeep and toStringShallow on '
                'top. Choosing the right one keeps logs concise.',
            tint: _accent,
          ),
          SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _ComparePanel(
                  tint: _sky,
                  tag: 'shortest',
                  title: 'toStringShort()',
                  body:
                      'Returns just the runtimeType, optionally tagged with a '
                      'short summary. Good for log lines that mention the '
                      'object in passing.',
                  sample: 'TreeNode(AppShell / Root)',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _ComparePanel(
                  tint: _accent,
                  tag: 'medium',
                  title: 'toString()',
                  body:
                      'One line. Includes the runtimeType plus a comma-'
                      'separated list of properties at level info or higher. '
                      r'Default for "$obj" interpolation.',
                  sample:
                      'TreeNode#0a3f4(label: "AppShell", kind: "Root", depth: 0, weight: 11)',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _ComparePanel(
                  tint: _accentAlt,
                  tag: 'deepest',
                  title: 'toStringDeep()',
                  body:
                      'Multi-line, recursive, indented. Calls '
                      'debugDescribeChildren on every node. Best for "what is '
                      'in my widget tree" debugging.',
                  sample:
                      'TreeNode(AppShell / Root)\n\u251C\u2500 child[0]: TreeNode(Header / Region)\n\u2502  \u251C\u2500 child[0]: TreeNode(Toolbar / AppBarSlot)\n\u2502  \u2514\u2500 child[1]: TreeNode(Logo / ImageSlot)\n\u251C\u2500 child[1]: TreeNode(Body / Region)\n\u2514\u2500 child[2]: TreeNode(Footer / Region)',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _amber.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _amber.withValues(alpha: 0.40)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.warning_amber_rounded,
                    color: _amber, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'toStringDeep() is O(n) in the size of the tree and emits '
                    'every visible property. Avoid calling it on hot paths or '
                    'for live UI traces — wrap it in a kDebugMode guard.',
                    style: _body,
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

class _ComparePanel extends StatelessWidget {
  const _ComparePanel({
    required this.tint,
    required this.tag,
    required this.title,
    required this.body,
    required this.sample,
  });

  final Color tint;
  final String tag;
  final String title;
  final String body;
  final String sample;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Pill(text: tag.toUpperCase(), tint: tint),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: tint,
            ),
          ),
          SizedBox(height: 6),
          Text(body, style: _body),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _consoleBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ink.withValues(alpha: 0.40)),
            ),
            child: Text(
              sample,
              style: _mono.copyWith(fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 11 — Tree-formatting algorithm (DiagnosticsTreeStyle)
// =============================================================================

class _TreeStyleAlgorithmSection extends StatelessWidget {
  const _TreeStyleAlgorithmSection();

  @override
  Widget build(BuildContext context) {
    final List<_StyleEntry> styles = const <_StyleEntry>[
      _StyleEntry(
        name: 'sparse',
        summary:
            'Default for DiagnosticableTree. One blank line between nodes; '
            'each child prefixed with \u251C\u2500 / \u2514\u2500 glyphs.',
        glyph: '\u251C\u2500',
        tint: _accent,
      ),
      _StyleEntry(
        name: 'dense',
        summary:
            'Compact siblings without separator lines. Good for very long '
            'children lists like RenderObject layout dumps.',
        glyph: '\u2502',
        tint: _accentAlt,
      ),
      _StyleEntry(
        name: 'transition',
        summary:
            'Used for animation transitions. Renders an arrow between the '
            'before/after states.',
        glyph: '\u21D2',
        tint: _mint,
      ),
      _StyleEntry(
        name: 'errorProperty',
        summary:
            'Calls out an offending value: thick block prefix and red tint '
            'in the inspector.',
        glyph: '\u2589\u2589',
        tint: _rose,
      ),
      _StyleEntry(
        name: 'whitespace',
        summary:
            'Indented but free of glyphs. Good when the parent already drew '
            'connector lines around the block.',
        glyph: ' \u00B7',
        tint: _inkMute,
      ),
      _StyleEntry(
        name: 'flat',
        summary:
            'No indentation, no glyphs — single-level rendering. Used by '
            'inline diagnostics blocks.',
        glyph: '\u25A1',
        tint: _sky,
      ),
      _StyleEntry(
        name: 'singleLine',
        summary:
            'Children are concatenated onto one line. Used when an object '
            'description must fit a log entry.',
        glyph: '\u2014',
        tint: _amber,
      ),
      _StyleEntry(
        name: 'errorPropertyBox',
        summary:
            'Boxed presentation for compound errors. Wraps the whole node in '
            'a frame.',
        glyph: '\u2554\u2550',
        tint: _rose,
      ),
      _StyleEntry(
        name: 'shallow',
        summary:
            'Top-level only — children are not recursed. Useful when one '
            'node should defer expansion.',
        glyph: '\u2026',
        tint: _accentAlt,
      ),
      _StyleEntry(
        name: 'truncateChildren',
        summary:
            'Renders the first N children and replaces the rest with a '
            'summary entry "... and N more".',
        glyph: '\u2702',
        tint: _accent,
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '11 — TREE STYLES',
            title: 'How DiagnosticsTreeStyle reshapes the output',
            subtitle:
                'Every DiagnosticsNode carries a style. The renderer picks the '
                'right glyphs and indentation rules from a registry of '
                'TextTreeConfiguration instances. Below is a tour of the most '
                'commonly used styles.',
            tint: _accentAlt,
          ),
          SizedBox(height: 18),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 3.4,
            children: <Widget>[
              for (final _StyleEntry style in styles) _StyleCard(style: style),
            ],
          ),
          SizedBox(height: 16),
          _AlgorithmStrip(),
        ],
      ),
    );
  }
}

class _StyleCard extends StatelessWidget {
  const _StyleCard({required this.style});
  final _StyleEntry style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: style.tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: style.tint.withValues(alpha: 0.40)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: style.tint.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: style.tint.withValues(alpha: 0.55)),
            ),
            child: Text(
              style.glyph,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: style.tint,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'DiagnosticsTreeStyle.${style.name}',
                  style: _monoInk.copyWith(
                    fontWeight: FontWeight.w700,
                    color: style.tint,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 3),
                Text(style.summary, style: _body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AlgorithmStrip extends StatelessWidget {
  const _AlgorithmStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _paperAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('RENDER LOOP', style: _label),
          SizedBox(height: 10),
          Row(
            children: const <Widget>[
              _AlgoStep(
                  n: '1',
                  title: 'startNode',
                  body:
                      'Header line: name, value description.',
                  tint: _accent),
              _AlgoArrow(),
              _AlgoStep(
                  n: '2',
                  title: 'properties',
                  body:
                      'For every visible DiagnosticsProperty, indent + line.',
                  tint: _accentAlt),
              _AlgoArrow(),
              _AlgoStep(
                  n: '3',
                  title: 'children',
                  body:
                      'For every DiagnosticsNode in debugDescribeChildren, '
                      'recurse with the right prefix glyphs.',
                  tint: _mint),
              _AlgoArrow(),
              _AlgoStep(
                  n: '4',
                  title: 'endNode',
                  body:
                      'Trailing blank line if the tree style demands it.',
                  tint: _amber),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlgoStep extends StatelessWidget {
  const _AlgoStep({
    required this.n,
    required this.title,
    required this.body,
    required this.tint,
  });

  final String n;
  final String title;
  final String body;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tint.withValues(alpha: 0.40)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: tint.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: tint.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Text(
                    n,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: tint,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: tint,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              body,
              style: TextStyle(
                fontSize: 11.5,
                color: _inkSoft,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlgoArrow extends StatelessWidget {
  const _AlgoArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.east_rounded, size: 16, color: _inkMute),
    );
  }
}

// =============================================================================
// Section 12 — Diagnosticable vs DiagnosticableTree feature matrix
// =============================================================================

class _DiagnosticableMatrixSection extends StatelessWidget {
  const _DiagnosticableMatrixSection();

  @override
  Widget build(BuildContext context) {
    final List<_MatrixRow> rows = const <_MatrixRow>[
      _MatrixRow(
        feature: 'Has properties',
        diagnosticable: 'Yes — debugFillProperties',
        diagnosticableTree: 'Yes — inherits',
      ),
      _MatrixRow(
        feature: 'Has children',
        diagnosticable: 'No',
        diagnosticableTree: 'Yes — debugDescribeChildren',
      ),
      _MatrixRow(
        feature: 'toStringDeep()',
        diagnosticable: 'Not available',
        diagnosticableTree: 'Recursive multi-line dump',
      ),
      _MatrixRow(
        feature: 'toStringShallow()',
        diagnosticable: 'Not available',
        diagnosticableTree: 'One level, like toStringDeep but flat',
      ),
      _MatrixRow(
        feature: 'Default tree style',
        diagnosticable: 'singleLine',
        diagnosticableTree: 'sparse',
      ),
      _MatrixRow(
        feature: 'Used by',
        diagnosticable: 'TextStyle, BoxDecoration, ScrollPhysics, ...',
        diagnosticableTree: 'Widget, Element, RenderObject',
      ),
      _MatrixRow(
        feature: 'Visible in inspector tree',
        diagnosticable: 'As a leaf entry only',
        diagnosticableTree: 'As an expandable node',
      ),
      _MatrixRow(
        feature: 'When to pick it',
        diagnosticable: 'Value object with a flat property bag',
        diagnosticableTree: 'Tree-shaped object that owns sub-objects',
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '12 — MATRIX',
            title: 'Diagnosticable vs DiagnosticableTree',
            subtitle:
                'A side-by-side comparison so you know which base to extend. '
                'Reach for DiagnosticableTree only when you genuinely have '
                'children worth recursing into.',
            tint: _mint,
          ),
          SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: _paperAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _line),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _MatrixHeaderRow(),
                for (int i = 0; i < rows.length; i++)
                  _MatrixDataRow(row: rows[i], shaded: i.isEven),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixHeaderRow extends StatelessWidget {
  const _MatrixHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _ink.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text('Feature',
                style: _bodyStrong.copyWith(color: _ink)),
          ),
          Expanded(
            flex: 4,
            child: Text('Diagnosticable',
                style: _bodyStrong.copyWith(color: _accent)),
          ),
          Expanded(
            flex: 4,
            child: Text('DiagnosticableTree',
                style: _bodyStrong.copyWith(color: _accentAlt)),
          ),
        ],
      ),
    );
  }
}

class _MatrixDataRow extends StatelessWidget {
  const _MatrixDataRow({required this.row, required this.shaded});
  final _MatrixRow row;
  final bool shaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: shaded ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              row.feature,
              style: _monoInk.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(row.diagnosticable, style: _body),
          ),
          Expanded(
            flex: 4,
            child: Text(row.diagnosticableTree, style: _body),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 13 — Pitfalls and best practices
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    final List<_PitfallEntry> pitfalls = const <_PitfallEntry>[
      _PitfallEntry(
        title: 'Forgetting to call super',
        bad:
            'void debugFillProperties(DiagnosticPropertiesBuilder p) {\n'
            '  // skipping super lets parent class properties go missing\n'
            "  p.add(StringProperty('label', label));\n"
            '}',
        good:
            'void debugFillProperties(DiagnosticPropertiesBuilder p) {\n'
            '  super.debugFillProperties(p);\n'
            "  p.add(StringProperty('label', label));\n"
            '}',
        tint: _rose,
      ),
      _PitfallEntry(
        title: 'Using DiagnosticsProperty<T> for typed values',
        bad:
            "p.add(DiagnosticsProperty<int>('depth', depth));",
        good:
            "p.add(IntProperty('depth', depth));",
        tint: _amber,
      ),
      _PitfallEntry(
        title: 'Leaking children with toString',
        bad:
            "Logger.info('built \$widget');  // toStringDeep on hot path!",
        good:
            'assert(() {\n'
            "  Logger.info('built \${widget.toStringShort()}');\n"
            '  return true;\n'
            '}());',
        tint: _accent,
      ),
      _PitfallEntry(
        title: 'Skipping defaultValue',
        bad:
            "p.add(IntProperty('weight', weight));  // always shown",
        good:
            "p.add(IntProperty('weight', weight, defaultValue: 0));",
        tint: _accentAlt,
      ),
      _PitfallEntry(
        title: 'Using bool directly for flags',
        bad:
            "p.add(DiagnosticsProperty<bool>('flagged', flagged));",
        good:
            "p.add(FlagProperty('flagged', value: flagged,\n"
            "    ifTrue: 'FLAGGED', ifFalse: 'normal'));",
        tint: _mint,
      ),
      _PitfallEntry(
        title: 'Recursing into mutable cycles',
        bad:
            'List<DiagnosticsNode> debugDescribeChildren() {\n'
            '  // emits a child whose own debugDescribeChildren\n'
            '  // returns this node again -> infinite recursion.\n'
            '  return <DiagnosticsNode>[parent.toDiagnosticsNode()];\n'
            '}',
        good:
            'List<DiagnosticsNode> debugDescribeChildren() {\n'
            "  return <DiagnosticsNode>[parent.toDiagnosticsNode(\n"
            '      style: DiagnosticsTreeStyle.sparse,\n'
            "      name: 'parent (back-edge, not recursed)')];\n"
            '}',
        tint: _sky,
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionHeader(
            tag: '13 — PITFALLS',
            title: 'Sharp edges to avoid',
            subtitle:
                'A grab-bag of mistakes the inspector makes you regret. Each '
                'card pairs a "bad" snippet with the recommended fix.',
            tint: _rose,
          ),
          SizedBox(height: 18),
          Column(
            children: <Widget>[
              for (final _PitfallEntry pitfall in pitfalls)
                _PitfallCard(entry: pitfall),
            ],
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.entry});
  final _PitfallEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: entry.tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: entry.tint.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.report_problem_rounded,
                  size: 18, color: entry.tint),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  entry.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: entry.tint,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #15):
          // Same stretch-Row pattern as above — wrap in IntrinsicHeight.
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _PitfallSnippet(
                    label: 'Avoid',
                    body: entry.bad,
                    tint: _rose,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _PitfallSnippet(
                    label: 'Prefer',
                    body: entry.good,
                    tint: _mint,
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

class _PitfallSnippet extends StatelessWidget {
  const _PitfallSnippet({
    required this.label,
    required this.body,
    required this.tint,
  });

  final String label;
  final String body;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _consoleBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withValues(alpha: 0.50)),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: tint,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(body, style: _mono.copyWith(fontSize: 11.5)),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 14 — Footer
// =============================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _ink,
      borderColor: _ink,
      borderRadius: 22,
      padding: EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                child: Text(
                  'TL;DR',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'DiagnosticableTree',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Subclass it whenever your object owns child objects worth '
            'showing in the inspector. Override debugFillProperties to expose '
            'fields, debugDescribeChildren to expose children, and let the '
            'framework take care of indentation, glyphs, levels and the '
            'Inspector wiring.',
            style: TextStyle(
              fontSize: 14,
              height: 1.55,
              color: Colors.white.withValues(alpha: 0.90),
            ),
          ),
          SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _FooterChip(text: 'foundation.dart'),
              _FooterChip(text: 'flutter inspector'),
              _FooterChip(text: 'devtools'),
              _FooterChip(text: 'toStringDeep()'),
              _FooterChip(text: 'DiagnosticPropertiesBuilder'),
              _FooterChip(text: 'DiagnosticLevel'),
              _FooterChip(text: 'DiagnosticsTreeStyle'),
            ],
          ),
          SizedBox(height: 18),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.18),
          ),
          SizedBox(height: 14),
          Text(
            'tom_d4rt_flutter_ast \u00B7 visual deep demo \u00B7 '
            'foundation/diagnosticable_tree_test.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  const _FooterChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
