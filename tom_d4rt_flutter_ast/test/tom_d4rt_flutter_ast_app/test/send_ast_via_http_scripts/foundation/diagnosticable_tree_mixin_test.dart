// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =============================================================================
//  Visual Deep Demo: DiagnosticableTreeMixin
// =============================================================================
//  Subject: package:flutter/foundation.dart  ->  DiagnosticableTreeMixin
//
//  This single-screen, hand-written demo replaces the previous tiny smoke test
//  for the DiagnosticableTreeMixin fixture. It pours into one scrollable view
//  a guided tour of the mixin, the supporting Diagnostics types, and the way
//  the Flutter inspector consumes them. The demo deliberately avoids any
//  state, async work or controllers; everything is a pure description tree.
//
//  Sections (>=9):
//    1.  Hero card with a tree-of-nodes graphic
//    2.  Anatomy of DiagnosticableTreeMixin methods
//    3.  Live class _PrivateNode mixing in DiagnosticableTreeMixin + console
//    4.  DiagnosticsProperty<T> gallery
//    5.  DiagnosticsTreeStyle enum cards
//    6.  DiagnosticPropertiesBuilder use-flow diagram
//    7.  Diagnosticable / DiagnosticableTree / DiagnosticableTreeMixin matrix
//    8.  Flutter Inspector integration diagram
//    9.  Recipe code listing (overriding debugFillProperties)
//   10.  Pitfalls & best practices
//   11.  Footer
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Theme tokens
// -----------------------------------------------------------------------------

const Color _privateInk = Color(0xFF0F172A);
const Color _privateInkSoft = Color(0xFF334155);
const Color _privateInkMute = Color(0xFF64748B);
const Color _privatePaper = Color(0xFFF8FAFC);
const Color _privatePaperAlt = Color(0xFFEEF2F7);
const Color _privateAccent = Color(0xFF6366F1);
const Color _privateAccentAlt = Color(0xFF8B5CF6);
const Color _privateMint = Color(0xFF10B981);
const Color _privateAmber = Color(0xFFF59E0B);
const Color _privateRose = Color(0xFFE11D48);
const Color _privateSky = Color(0xFF0EA5E9);
const Color _privateLine = Color(0xFFCBD5E1);
const Color _privateConsoleBg = Color(0xFF0B1220);
const Color _privateConsoleFg = Color(0xFFE2E8F0);

const TextStyle _privateMono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.4,
  color: _privateConsoleFg,
);

const TextStyle _privateMonoInk = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.4,
  color: _privateInk,
);

const TextStyle _privateTitle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w800,
  color: _privateInk,
  letterSpacing: -0.4,
);

const TextStyle _privateSubtitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: _privateInkSoft,
  height: 1.45,
);

const TextStyle _privateSection = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: _privateInk,
  letterSpacing: -0.2,
);

const TextStyle _privateLabel = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: _privateAccent,
  letterSpacing: 1.2,
);

// -----------------------------------------------------------------------------
// Live diagnosable types
// -----------------------------------------------------------------------------

/// A demo node that mixes in [DiagnosticableTreeMixin] so we can pull a real
/// `toStringDeep()` rendering out of it and pipe it into the console panel.
class _PrivateNode with DiagnosticableTreeMixin {
  _PrivateNode({
    required this.label,
    required this.kind,
    this.depth = 0,
    this.flagged = false,
    this.weight = 0,
    this.tint = _privateAccent,
    this.children = const <_PrivateNode>[],
  });

  final String label;
  final String kind;
  final int depth;
  final bool flagged;
  final int weight;
  final Color tint;
  final List<_PrivateNode> children;

  @override
  String toStringShort() => '_PrivateNode($label)';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(StringProperty('kind', kind));
    properties.add(IntProperty('depth', depth));
    properties.add(IntProperty('weight', weight, defaultValue: 0));
    properties.add(
      FlagProperty(
        'flagged',
        value: flagged,
        ifTrue: 'FLAGGED',
        ifFalse: 'normal',
      ),
    );
    properties.add(ColorProperty('tint', tint));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> out = <DiagnosticsNode>[];
    for (int i = 0; i < children.length; i++) {
      out.add(children[i].toDiagnosticsNode(name: 'child[$i]'));
    }
    return out;
  }
}

/// A miniature property-pack that we render in the gallery; it is a plain
/// data holder, not bound to widgets.
class _PrivatePropertyShape {
  const _PrivatePropertyShape({
    required this.title,
    required this.summary,
    required this.example,
    required this.color,
  });

  final String title;
  final String summary;
  final String example;
  final Color color;
}

/// A description for one entry in the tree-style enum gallery.
class _PrivateStyleShape {
  const _PrivateStyleShape({
    required this.name,
    required this.purpose,
    required this.glyph,
    required this.color,
  });

  final String name;
  final String purpose;
  final String glyph;
  final Color color;
}

/// A row in the comparison table at the bottom.
class _PrivateMatrixRow {
  const _PrivateMatrixRow({
    required this.feature,
    required this.diagnosticable,
    required this.diagnosticableTree,
    required this.mixin,
  });

  final String feature;
  final String diagnosticable;
  final String diagnosticableTree;
  final String mixin;
}

typedef _PrivateBuilderFn = Widget Function(BuildContext);

// -----------------------------------------------------------------------------
// Sample tree (constructed once at build time)
// -----------------------------------------------------------------------------

_PrivateNode _privateBuildSampleTree() {
  final _PrivateNode child1 = _PrivateNode(
    label: 'Toolbar',
    kind: 'AppBarSlot',
    depth: 2,
    weight: 3,
    tint: _privateAccentAlt,
  );
  final _PrivateNode child2 = _PrivateNode(
    label: 'Logo',
    kind: 'ImageSlot',
    depth: 2,
    weight: 1,
    tint: _privateMint,
  );
  final _PrivateNode header = _PrivateNode(
    label: 'Header',
    kind: 'Region',
    depth: 1,
    weight: 4,
    flagged: true,
    tint: _privateAccent,
    children: <_PrivateNode>[child1, child2],
  );

  final _PrivateNode listTile = _PrivateNode(
    label: 'ListTile',
    kind: 'Item',
    depth: 2,
    weight: 1,
    tint: _privateSky,
  );
  final _PrivateNode footerNote = _PrivateNode(
    label: 'Footnote',
    kind: 'Caption',
    depth: 2,
    weight: 1,
    tint: _privateInkMute,
  );
  final _PrivateNode body = _PrivateNode(
    label: 'Body',
    kind: 'Region',
    depth: 1,
    weight: 5,
    tint: _privateAccentAlt,
    children: <_PrivateNode>[listTile, footerNote],
  );

  final _PrivateNode footer = _PrivateNode(
    label: 'Footer',
    kind: 'Region',
    depth: 1,
    weight: 2,
    tint: _privateAmber,
  );

  return _PrivateNode(
    label: 'AppShell',
    kind: 'Root',
    depth: 0,
    weight: 11,
    tint: _privateAccent,
    children: <_PrivateNode>[header, body, footer],
  );
}

// -----------------------------------------------------------------------------
// Reusable presentational widgets
// -----------------------------------------------------------------------------

class _PrivateCard extends StatelessWidget {
  const _PrivateCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color = Colors.white,
    this.borderColor = _privateLine,
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

class _PrivateSectionHeader extends StatelessWidget {
  const _PrivateSectionHeader({
    required this.tag,
    required this.title,
    required this.subtitle,
    this.color = _privateAccent,
  });

  final String tag;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(title, style: _privateTitle),
        SizedBox(height: 6),
        Text(subtitle, style: _privateSubtitle),
      ],
    );
  }
}

class _PrivateBadge extends StatelessWidget {
  const _PrivateBadge({
    required this.label,
    this.color = _privateAccent,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _PrivateConsole extends StatelessWidget {
  const _PrivateConsole({
    required this.lines,
    this.title = 'console',
  });

  final List<String> lines;
  final String title;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[];
    for (int i = 0; i < lines.length; i++) {
      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.5),
          child: RichText(
            text: TextSpan(
              style: _privateMono,
              children: <InlineSpan>[
                TextSpan(
                  text: '${(i + 1).toString().padLeft(3, ' ')}  ',
                  style: _privateMono.copyWith(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                TextSpan(text: lines[i]),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: _privateConsoleBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _privateTrafficDot(Color(0xFFFF5F57)),
              SizedBox(width: 6),
              _privateTrafficDot(Color(0xFFFEBC2E)),
              SizedBox(width: 6),
              _privateTrafficDot(Color(0xFF28C840)),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontFamily: 'monospace',
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ...widgets,
        ],
      ),
    );
  }

  Widget _privateTrafficDot(Color color) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. Hero card -- tree of nodes graphic
// -----------------------------------------------------------------------------

class _PrivateHeroCard extends StatelessWidget {
  const _PrivateHeroCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      padding: EdgeInsets.fromLTRB(24, 26, 24, 26),
      borderRadius: 22,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _PrivateBadge(label: 'foundation.dart'),
              SizedBox(width: 8),
              _PrivateBadge(
                label: 'mixin',
                color: _privateAccentAlt,
              ),
              SizedBox(width: 8),
              _PrivateBadge(
                label: 'tree-aware diagnostics',
                color: _privateMint,
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            'DiagnosticableTreeMixin',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: _privateInk,
              letterSpacing: -0.8,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'A mixin that grafts toStringDeep, toDiagnosticsNode and '
            'debugDescribeChildren onto any class -- the same plumbing the '
            'Flutter inspector uses to render Element, RenderObject and '
            'Widget trees.',
            style: _privateSubtitle.copyWith(fontSize: 15),
          ),
          SizedBox(height: 22),
          _PrivateHeroTreeGraphic(),
        ],
      ),
    );
  }
}

class _PrivateHeroTreeGraphic extends StatelessWidget {
  const _PrivateHeroTreeGraphic();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _privateAccent.withValues(alpha: 0.08),
            _privateAccentAlt.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _privateAccent.withValues(alpha: 0.2)),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _privateTreeNodeBubble(
            'AppShell',
            'Root',
            _privateAccent,
            big: true,
          ),
          _privateConnector(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _privateTreeBranch('Header', _privateAccent),
              _privateTreeBranch('Body', _privateAccentAlt),
              _privateTreeBranch('Footer', _privateAmber),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _privateTreeLeaf('Toolbar'),
              _privateTreeLeaf('Logo'),
              _privateTreeLeaf('ListTile'),
              _privateTreeLeaf('Footnote'),
              SizedBox(width: 60),
            ],
          ),
        ],
      ),
    );
  }

  Widget _privateTreeNodeBubble(
    String name,
    String role,
    Color color, {
    bool big = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: big ? 22 : 14,
        vertical: big ? 14 : 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color, width: big ? 2 : 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: big ? 16 : 13,
            ),
          ),
          SizedBox(height: 2),
          Text(
            role,
            style: TextStyle(
              color: _privateInkMute,
              fontWeight: FontWeight.w500,
              fontSize: big ? 11 : 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _privateConnector() {
    return Container(
      width: 2,
      height: 24,
      color: _privateLine,
      margin: EdgeInsets.symmetric(vertical: 4),
    );
  }

  Widget _privateTreeBranch(String name, Color color) {
    return Column(
      children: <Widget>[
        _privateTreeNodeBubble(name, 'Region', color),
        Container(width: 2, height: 22, color: _privateLine),
      ],
    );
  }

  Widget _privateTreeLeaf(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _privatePaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _privateLine),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 11,
          color: _privateInkSoft,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. Anatomy of DiagnosticableTreeMixin methods
// -----------------------------------------------------------------------------

class _PrivateAnatomyCard extends StatelessWidget {
  const _PrivateAnatomyCard();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>[
        'toStringDeep',
        'String toStringDeep({prefixLineOne, prefixOtherLines, minLevel})',
        'Walks the children, formats each level with line prefixes, and '
            'returns the multi-line tree dump used by widget inspector logs.',
      ],
      <String>[
        'toDiagnosticsNode',
        'DiagnosticsNode toDiagnosticsNode({name, style})',
        'Wraps the receiver into a DiagnosticsNode that an inspector can '
            'traverse: it pulls properties via debugFillProperties and '
            'children via debugDescribeChildren.',
      ],
      <String>[
        'debugDescribeChildren',
        'List<DiagnosticsNode> debugDescribeChildren()',
        'Override this to expose the child sub-tree. Each entry is a '
            'DiagnosticsNode named to give a hint of role (child[0], '
            'child<header>, etc.).',
      ],
      <String>[
        'debugFillProperties',
        'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
        'Override to advertise scalar attributes (colors, flags, sizes). '
            'These show up in DevTools and on toStringDeep output blocks.',
      ],
      <String>[
        'toStringShort',
        'String toStringShort()',
        'A compact label for the node. Override to swap the default '
            'runtimeType-based formatting for something nicer.',
      ],
    ];

    final List<Widget> rowWidgets = <Widget>[];
    for (int i = 0; i < rows.length; i++) {
      rowWidgets.add(_buildRow(rows[i], i.isOdd));
    }

    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'ANATOMY',
            title: 'What the mixin gives you',
            subtitle:
                'Five hooks that turn an ordinary class into a tree node the '
                'Flutter inspector can crawl and render.',
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: _privateLine),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(children: rowWidgets),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> row, bool alt) {
    return Container(
      decoration: BoxDecoration(
        color: alt ? _privatePaperAlt : Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _PrivateBadge(label: row[0]),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  row[1],
                  style: _privateMonoInk.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            row[2],
            style: _privateSubtitle.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. Live class section + console-style toStringDeep dump
// -----------------------------------------------------------------------------

class _PrivateLiveClassCard extends StatelessWidget {
  const _PrivateLiveClassCard({required this.tree});

  final _PrivateNode tree;

  @override
  Widget build(BuildContext context) {
    final List<String> deepLines = _splitNonEmpty(tree.toStringDeep());
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'LIVE EXAMPLE',
            title: 'class _PrivateNode with DiagnosticableTreeMixin',
            subtitle:
                'A real instance of our diagnosable node, three children deep, '
                'rendered through .toStringDeep() into the console panel.',
            color: _privateAccentAlt,
          ),
          SizedBox(height: 16),
          _privateClassListing(),
          SizedBox(height: 16),
          _PrivateConsole(
            title: 'AppShell.toStringDeep()',
            lines: deepLines,
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _privatePaper,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _privateLine),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.info_outline,
                    color: _privateAccent, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Notice the indentation glyphs (├─, │, └─) are produced '
                    'automatically by toStringDeep based on each child position '
                    'and the active DiagnosticsTreeStyle.',
                    style: _privateSubtitle.copyWith(fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _privateClassListing() {
    final List<String> snippet = <String>[
      'class _PrivateNode with DiagnosticableTreeMixin {',
      '  _PrivateNode({',
      '    required this.label,',
      '    required this.kind,',
      '    this.children = const <_PrivateNode>[],',
      '  });',
      '',
      '  final String label;',
      '  final String kind;',
      '  final List<_PrivateNode> children;',
      '',
      '  @override',
      '  void debugFillProperties(DiagnosticPropertiesBuilder p) {',
      '    super.debugFillProperties(p);',
      '    p.add(StringProperty(\'label\', label));',
      '    p.add(StringProperty(\'kind\', kind));',
      '    p.add(IntProperty(\'children\', children.length));',
      '  }',
      '',
      '  @override',
      '  List<DiagnosticsNode> debugDescribeChildren() => <DiagnosticsNode>[',
      '    for (int i = 0; i < children.length; i++)',
      '      children[i].toDiagnosticsNode(name: \'child[\$i]\'),',
      '  ];',
      '}',
    ];
    return Container(
      decoration: BoxDecoration(
        color: _privatePaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _privateLine),
      ),
      padding: EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < snippet.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.5),
              child: Text(snippet[i], style: _privateMonoInk),
            ),
        ],
      ),
    );
  }

  List<String> _splitNonEmpty(String text) {
    final List<String> raw = text.split('\n');
    final List<String> out = <String>[];
    for (int i = 0; i < raw.length; i++) {
      if (raw[i].trim().isEmpty && i == raw.length - 1) {
        continue;
      }
      out.add(raw[i].isEmpty ? ' ' : raw[i]);
    }
    return out;
  }
}

// -----------------------------------------------------------------------------
// 4. DiagnosticsProperty<T> gallery
// -----------------------------------------------------------------------------

class _PrivatePropertyGalleryCard extends StatelessWidget {
  const _PrivatePropertyGalleryCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivatePropertyShape> shapes = <_PrivatePropertyShape>[
      _PrivatePropertyShape(
        title: 'StringProperty',
        summary:
            'Adds a string attribute. Quotes the value and respects '
            'defaultValue suppression.',
        example: "StringProperty('label', 'AppShell')",
        color: _privateAccent,
      ),
      _PrivatePropertyShape(
        title: 'IntProperty',
        summary:
            'Numeric attribute, hides default values and unit-formats with '
            'optional unit string.',
        example: "IntProperty('depth', 0, defaultValue: 0)",
        color: _privateAccentAlt,
      ),
      _PrivatePropertyShape(
        title: 'DoubleProperty',
        summary:
            'Floating point with sensible truncation and unit suffix '
            'support such as "px" or "ms".',
        example: "DoubleProperty('opacity', 0.85, unit: 'a')",
        color: _privateMint,
      ),
      _PrivatePropertyShape(
        title: 'FlagProperty',
        summary:
            'Bool attribute with custom strings for true / false; great '
            'for "ENABLED" vs "disabled".',
        example: "FlagProperty('flagged', value: true, ifTrue: 'FLAGGED')",
        color: _privateRose,
      ),
      _PrivatePropertyShape(
        title: 'EnumProperty',
        summary:
            'Renders an enum value compactly using its short name '
            'ignoring the full prefix.',
        example: "EnumProperty('style', DiagnosticsTreeStyle.dense)",
        color: _privateSky,
      ),
      _PrivatePropertyShape(
        title: 'IterableProperty',
        summary:
            'A list/iterable attribute; collapses long collections and '
            'renders one entry per line in expanded form.',
        example: "IterableProperty<String>('tags', <String>['hot','live'])",
        color: _privateAmber,
      ),
      _PrivatePropertyShape(
        title: 'DiagnosticsProperty<T>',
        summary:
            'The base class. Handy for arbitrary objects -- their '
            'toString() becomes the rendered value.',
        example: "DiagnosticsProperty<Object>('payload', myObject)",
        color: _privateInkSoft,
      ),
      _PrivatePropertyShape(
        title: 'ColorProperty',
        summary:
            'Pretty-prints a Color as #AARRGGBB so colour values stay '
            'comparable in inspector output.',
        example: "ColorProperty('tint', Color(0xFF6366F1))",
        color: _privateAccent,
      ),
    ];

    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'GALLERY',
            title: 'DiagnosticsProperty<T> family',
            subtitle:
                'Specialised property classes used inside debugFillProperties '
                'to declare what an inspector should show.',
            color: _privateMint,
          ),
          SizedBox(height: 14),
          _privateGrid(shapes),
        ],
      ),
    );
  }

  Widget _privateGrid(List<_PrivatePropertyShape> shapes) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < shapes.length; i++) {
      children.add(_buildItem(shapes[i]));
    }
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: children,
    );
  }

  Widget _buildItem(_PrivatePropertyShape shape) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 280,
        maxWidth: 360,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _privateLine),
        ),
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: shape.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: shape.color.withValues(alpha: 0.4),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    shape.title.substring(0, 1),
                    style: TextStyle(
                      color: shape.color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    shape.title,
                    style: TextStyle(
                      color: _privateInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(shape.summary,
                style: _privateSubtitle.copyWith(fontSize: 12.5)),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: _privatePaper,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _privateLine),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(shape.example, style: _privateMonoInk),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 5. DiagnosticsTreeStyle enum cards
// -----------------------------------------------------------------------------

class _PrivateTreeStyleCard extends StatelessWidget {
  const _PrivateTreeStyleCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateStyleShape> styles = <_PrivateStyleShape>[
      _PrivateStyleShape(
        name: 'sparse',
        purpose:
            'Default style for widgets, elements and render objects: '
            'spacious tree with vertical bars between siblings.',
        glyph: '├─ child',
        color: _privateAccent,
      ),
      _PrivateStyleShape(
        name: 'dense',
        purpose:
            'Compact one-line-per-property layout used when many small '
            'properties need to fit a tight context.',
        glyph: '· child',
        color: _privateAccentAlt,
      ),
      _PrivateStyleShape(
        name: 'offstage',
        purpose:
            'Indicates that a sub-tree exists but is not currently '
            'mounted/laid out -- inspector may render it dim.',
        glyph: '╌ child',
        color: _privateInkMute,
      ),
      _PrivateStyleShape(
        name: 'transition',
        purpose:
            'Used for nodes that span two parents (e.g. routes, theme '
            'transitions). Adds a separator line above.',
        glyph: '↘ child',
        color: _privateMint,
      ),
      _PrivateStyleShape(
        name: 'error',
        purpose:
            'Highlighted style for nodes representing exceptions; usually '
            'rendered with a red glyph in the inspector.',
        glyph: '✗ child',
        color: _privateRose,
      ),
      _PrivateStyleShape(
        name: 'whitespace',
        purpose:
            'Strips connector glyphs entirely, leaving only indentation. '
            'Best for terminal output that already wraps content.',
        glyph: '   child',
        color: _privateAmber,
      ),
      _PrivateStyleShape(
        name: 'flat',
        purpose:
            'No indentation at all -- properties are rendered as a flat '
            'sequence. Useful for property-only nodes.',
        glyph: 'child',
        color: _privateSky,
      ),
      _PrivateStyleShape(
        name: 'singleLine',
        purpose:
            'Forces toString to compress everything onto one line. The '
            'inspector falls back to this for compact tooltips.',
        glyph: 'a, b, c',
        color: _privateInkSoft,
      ),
      _PrivateStyleShape(
        name: 'truncateChildren',
        purpose:
            'Children are summarised with "..." once their count exceeds '
            'a threshold; useful for huge collections.',
        glyph: '... +N',
        color: _privateAccentAlt,
      ),
    ];

    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < styles.length; i++) {
      tiles.add(_buildTile(styles[i]));
    }

    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'ENUM',
            title: 'DiagnosticsTreeStyle values',
            subtitle:
                'How the inspector renders each child relationship -- '
                'choose the style on debugDescribeChildren or via '
                'toDiagnosticsNode(style: ...).',
            color: _privateAmber,
          ),
          SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: tiles,
          ),
        ],
      ),
    );
  }

  Widget _buildTile(_PrivateStyleShape shape) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 240, maxWidth: 320),
      child: Container(
        decoration: BoxDecoration(
          color: shape.color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: shape.color.withValues(alpha: 0.4)),
        ),
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: shape.color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    shape.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  shape.glyph,
                  style: _privateMonoInk.copyWith(
                    color: shape.color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              shape.purpose,
              style: _privateSubtitle.copyWith(fontSize: 12.5),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 6. DiagnosticPropertiesBuilder use-flow diagram
// -----------------------------------------------------------------------------

class _PrivateBuilderFlowCard extends StatelessWidget {
  const _PrivateBuilderFlowCard();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> steps = <List<String>>[
      <String>[
        '1',
        'Inspector calls toDiagnosticsNode',
        'On every visible node the inspector requests a DiagnosticsNode for '
            'rendering in the tree panel.',
      ],
      <String>[
        '2',
        'Node creates a DiagnosticPropertiesBuilder',
        'The node instantiates an empty builder. The builder is the '
            'collector of all subsequent property declarations.',
      ],
      <String>[
        '3',
        'debugFillProperties is invoked',
        'Your override (and super.debugFillProperties) push '
            'DiagnosticsProperty<T> entries via builder.add(...).',
      ],
      <String>[
        '4',
        'Properties are converted to DiagnosticsNodes',
        'Each property becomes its own DiagnosticsNode; together they form '
            'the property block under the parent node.',
      ],
      <String>[
        '5',
        'Children are added separately',
        'debugDescribeChildren returns DiagnosticsNodes too -- those become '
            'the structural sub-tree below the property block.',
      ],
      <String>[
        '6',
        'Output is rendered',
        'toStringDeep collapses everything into text; the IDE inspector '
            'turns it into the visual tree you see in DevTools.',
      ],
    ];

    final List<Widget> stepWidgets = <Widget>[];
    for (int i = 0; i < steps.length; i++) {
      stepWidgets.add(_buildStep(steps[i], i == steps.length - 1));
    }

    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'FLOW',
            title: 'How DiagnosticPropertiesBuilder is used',
            subtitle:
                'A six-step lifecycle from the inspector\'s call site down '
                'to your overrides and back.',
            color: _privateSky,
          ),
          SizedBox(height: 16),
          Column(children: stepWidgets),
        ],
      ),
    );
  }

  Widget _buildStep(List<String> step, bool last) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: _privateAccent,
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: Alignment.center,
              child: Text(
                step[0],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (!last)
              Container(
                width: 2,
                height: 38,
                color: _privateLine,
                margin: EdgeInsets.symmetric(vertical: 4),
              ),
          ],
        ),
        SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: last ? 0 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  step[1],
                  style: TextStyle(
                    color: _privateInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  step[2],
                  style: _privateSubtitle.copyWith(fontSize: 12.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 7. Comparison: Diagnosticable vs DiagnosticableTree vs DiagnosticableTreeMixin
// -----------------------------------------------------------------------------

class _PrivateComparisonCard extends StatelessWidget {
  const _PrivateComparisonCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateMatrixRow> rows = <_PrivateMatrixRow>[
      _PrivateMatrixRow(
        feature: 'shape',
        diagnosticable: 'abstract class',
        diagnosticableTree: 'abstract class extends Diagnosticable',
        mixin: 'mixin on Diagnosticable',
      ),
      _PrivateMatrixRow(
        feature: 'has properties',
        diagnosticable: 'yes',
        diagnosticableTree: 'yes',
        mixin: 'yes',
      ),
      _PrivateMatrixRow(
        feature: 'has children',
        diagnosticable: 'no',
        diagnosticableTree: 'yes',
        mixin: 'yes',
      ),
      _PrivateMatrixRow(
        feature: 'toStringDeep',
        diagnosticable: '-',
        diagnosticableTree: 'available',
        mixin: 'available',
      ),
      _PrivateMatrixRow(
        feature: 'use case',
        diagnosticable: 'leaf data classes',
        diagnosticableTree: 'tree-like classes you author from scratch',
        mixin: 'tree-like classes that already extend something else',
      ),
      _PrivateMatrixRow(
        feature: 'Flutter examples',
        diagnosticable: 'TextStyle, BoxConstraints',
        diagnosticableTree: 'Widget, Element',
        mixin: 'RenderObject, Layer',
      ),
    ];

    final List<Widget> rowWidgets = <Widget>[];
    rowWidgets.add(_buildHeader());
    for (int i = 0; i < rows.length; i++) {
      rowWidgets.add(_buildRow(rows[i], i.isOdd));
    }

    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'MATRIX',
            title: 'Diagnosticable vs Tree vs Mixin',
            subtitle:
                'Three closely related types -- pick the one whose '
                'inheritance shape matches your existing class hierarchy.',
            color: _privateAccentAlt,
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: _privateLine),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(children: rowWidgets),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: _privateInk,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: <Widget>[
          _headerCell('feature', flex: 2),
          _headerCell('Diagnosticable', flex: 3),
          _headerCell('DiagnosticableTree', flex: 3),
          _headerCell('DiagnosticableTreeMixin', flex: 3),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 12,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _buildRow(_PrivateMatrixRow row, bool alt) {
    return Container(
      decoration: BoxDecoration(
        color: alt ? _privatePaperAlt : Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _bodyCell(row.feature, flex: 2, bold: true),
          _bodyCell(row.diagnosticable, flex: 3),
          _bodyCell(row.diagnosticableTree, flex: 3),
          _bodyCell(row.mixin, flex: 3),
        ],
      ),
    );
  }

  Widget _bodyCell(String text, {int flex = 1, bool bold = false}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: bold ? _privateInk : _privateInkSoft,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          fontSize: 12.5,
          height: 1.45,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 8. Flutter Inspector integration diagram
// -----------------------------------------------------------------------------

class _PrivateInspectorDiagramCard extends StatelessWidget {
  const _PrivateInspectorDiagramCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'INSPECTOR',
            title: 'Where the Flutter Inspector picks this up',
            subtitle:
                'A lane diagram of the calls flowing from the IDE through '
                'the VM service to your overrides.',
            color: _privateRose,
          ),
          SizedBox(height: 16),
          _privateLane(
            'IDE / DevTools',
            <String>[
              'tree panel renders',
              'requests diagnostics for selection',
              'serialises to JSON RPC',
            ],
            _privateAccent,
          ),
          _privateArrow(),
          _privateLane(
            'VM service / extension',
            <String>[
              'ext.flutter.inspector.getRootWidget',
              'ext.flutter.inspector.getChildren',
              'ext.flutter.inspector.getProperties',
            ],
            _privateAccentAlt,
          ),
          _privateArrow(),
          _privateLane(
            'Flutter framework',
            <String>[
              'Element.toDiagnosticsNode()',
              'Element.debugDescribeChildren()',
              'Element.debugFillProperties()',
            ],
            _privateMint,
          ),
          _privateArrow(),
          _privateLane(
            'Your widgets',
            <String>[
              'override debugFillProperties',
              'add DiagnosticsProperty<T> entries',
              'optionally override debugDescribeChildren',
            ],
            _privateAmber,
          ),
        ],
      ),
    );
  }

  Widget _privateLane(String name, List<String> bullets, Color color) {
    final List<Widget> bulletWidgets = <Widget>[];
    for (int i = 0; i < bullets.length; i++) {
      bulletWidgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  bullets[i],
                  style: _privateMonoInk.copyWith(
                    color: _privateInk,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  color: _privateInk,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ...bulletWidgets,
        ],
      ),
    );
  }

  Widget _privateArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Center(
        child: Icon(Icons.arrow_downward, color: _privateInkMute, size: 18),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 9. Recipe code listing
// -----------------------------------------------------------------------------

class _PrivateRecipeCard extends StatelessWidget {
  const _PrivateRecipeCard();

  @override
  Widget build(BuildContext context) {
    final List<String> snippet = <String>[
      "// minimal recipe: enabling rich diagnostics on your own type",
      "import 'package:flutter/foundation.dart';",
      "",
      "class GraphNode with DiagnosticableTreeMixin {",
      "  GraphNode({",
      "    required this.id,",
      "    required this.label,",
      "    this.weight = 0,",
      "    this.color,",
      "    this.children = const <GraphNode>[],",
      "  });",
      "",
      "  final String id;",
      "  final String label;",
      "  final int weight;",
      "  final Color? color;",
      "  final List<GraphNode> children;",
      "",
      "  @override",
      "  String toStringShort() => 'GraphNode(\$id)';",
      "",
      "  @override",
      "  void debugFillProperties(DiagnosticPropertiesBuilder p) {",
      "    super.debugFillProperties(p);",
      "    p.add(StringProperty('id', id));",
      "    p.add(StringProperty('label', label));",
      "    p.add(IntProperty('weight', weight, defaultValue: 0));",
      "    p.add(ColorProperty('color', color, defaultValue: null));",
      "    p.add(IntProperty('children', children.length));",
      "  }",
      "",
      "  @override",
      "  List<DiagnosticsNode> debugDescribeChildren() {",
      "    return <DiagnosticsNode>[",
      "      for (int i = 0; i < children.length; i++)",
      "        children[i].toDiagnosticsNode(name: 'child[\$i]'),",
      "    ];",
      "  }",
      "}",
      "",
      "// later, anywhere:",
      "//   final dump = root.toStringDeep();",
      "//   debugPrint(dump);",
    ];

    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'RECIPE',
            title: 'Override debugFillProperties / debugDescribeChildren',
            subtitle:
                'A copy-paste-ready skeleton for adding tree diagnostics '
                'to any class with one mixin.',
            color: _privateMint,
          ),
          SizedBox(height: 16),
          _PrivateConsole(
            title: 'graph_node.dart',
            lines: snippet,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 10. Pitfalls
// -----------------------------------------------------------------------------

class _PrivatePitfallsCard extends StatelessWidget {
  const _PrivatePitfallsCard();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> pitfalls = <List<String>>[
      <String>[
        'Forgetting super.debugFillProperties',
        'Always start your override with super.debugFillProperties(p) so '
            'inherited properties (e.g. key, hashCode) keep showing up.',
      ],
      <String>[
        'Computing values in toStringDeep',
        'toStringDeep is invoked from devtools without a frame -- avoid '
            'expensive computations or anything that allocates per call.',
      ],
      <String>[
        'Hiding defaults too aggressively',
        'defaultValue: kNoDefaultValue keeps the property visible even when '
            'it equals the default; useful for required attributes.',
      ],
      <String>[
        'Confusing children with properties',
        'Children are structural sub-trees. If something is just metadata '
            'about the parent, declare it via debugFillProperties instead.',
      ],
      <String>[
        'Using FlagProperty for tri-state',
        'FlagProperty is bool only. For tri-state attributes use '
            'EnumProperty or DiagnosticsProperty<MyEnum?>.',
      ],
      <String>[
        'Calling toStringDeep in production',
        'It is intended for development tooling. Wrap calls behind '
            'kDebugMode or assertions to keep release output lean.',
      ],
    ];

    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < pitfalls.length; i++) {
      tiles.add(_buildTile(pitfalls[i]));
    }

    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PrivateSectionHeader(
            tag: 'PITFALLS',
            title: 'Things that bite you in code reviews',
            subtitle:
                'Six recurring mistakes worth a sticker on your monitor.',
            color: _privateRose,
          ),
          SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: tiles,
          ),
        ],
      ),
    );
  }

  Widget _buildTile(List<String> entry) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 280, maxWidth: 360),
      child: Container(
        decoration: BoxDecoration(
          color: _privateRose.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _privateRose.withValues(alpha: 0.4)),
        ),
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.warning_amber_rounded,
                    color: _privateRose, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    entry[0],
                    style: TextStyle(
                      color: _privateInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(entry[1],
                style: _privateSubtitle.copyWith(fontSize: 12.5)),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 11. Footer
// -----------------------------------------------------------------------------

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      color: _privateInk,
      borderColor: _privateInk,
      padding: EdgeInsets.fromLTRB(22, 20, 22, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.account_tree_rounded,
                  color: Colors.white, size: 22),
              SizedBox(width: 10),
              Text(
                'DiagnosticableTreeMixin -- visual deep demo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Foundation primitives for inspector-friendly classes. '
            'Mix in the trait, override debugFillProperties and optionally '
            'debugDescribeChildren -- DevTools and toStringDeep do the rest.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          SizedBox(height: 14),
          Row(
            children: <Widget>[
              _privateChip('package:flutter/foundation.dart'),
              SizedBox(width: 8),
              _privateChip('mixin on Diagnosticable'),
              SizedBox(width: 8),
              _privateChip('used by Element / RenderObject'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _privateChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Top-level page composition
// -----------------------------------------------------------------------------

Widget _privateBuildPage(BuildContext context) {
  final _PrivateNode tree = _privateBuildSampleTree();

  // Demonstrate DiagnosticPropertiesBuilder usage independent of a node:
  final DiagnosticPropertiesBuilder _privateAuxBuilder =
      DiagnosticPropertiesBuilder();
  _privateAuxBuilder.add(StringProperty('demoTag', 'foundation'));
  _privateAuxBuilder.add(IntProperty('demoCount', 3));
  _privateAuxBuilder.add(
    FlagProperty('demoFlag', value: true, ifTrue: 'ON', ifFalse: 'off'),
  );
  _privateAuxBuilder.add(ColorProperty('demoTint', _privateAccent));

  final List<Widget> sections = <Widget>[
    _PrivateHeroCard(),
    _PrivateAnatomyCard(),
    _PrivateLiveClassCard(tree: tree),
    _PrivatePropertyGalleryCard(),
    _PrivateTreeStyleCard(),
    _PrivateBuilderFlowCard(),
    _PrivateComparisonCard(),
    _PrivateInspectorDiagramCard(),
    _PrivateRecipeCard(),
    _PrivatePitfallsCard(),
    _PrivateFooter(),
  ];

  final List<Widget> spaced = <Widget>[];
  for (int i = 0; i < sections.length; i++) {
    spaced.add(sections[i]);
    if (i < sections.length - 1) {
      spaced.add(SizedBox(height: 18));
    }
  }

  return Container(
    color: _privatePaper,
    padding: EdgeInsets.fromLTRB(20, 24, 20, 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: spaced,
    ),
  );
}

// -----------------------------------------------------------------------------
// Entry point
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DiagnosticableTreeMixin -- Visual Deep Demo',
    theme: ThemeData(
      scaffoldBackgroundColor: _privatePaper,
      useMaterial3: true,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: _privateInk),
      ),
    ),
    home: Scaffold(
      backgroundColor: _privatePaper,
      body: SingleChildScrollView(
        child: _privateBuildPage(context),
      ),
    ),
  );
}
