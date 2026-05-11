// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// DiagnosticsNode Deep Demo
// ----------------------------------------------------------------------------
// This file is a visual, fully static exploration of the DiagnosticsNode
// hierarchy from package:flutter/foundation.dart. DiagnosticsNode is the
// recursive primitive used throughout the Flutter framework to render
// developer-facing descriptions of widgets, render objects, layers, and
// arbitrary objects via toStringDeep / debugFillProperties / devtools.
// ============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DiagnosticsNode Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('DiagnosticsNode - The Description Tree'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _HeroBannerSection(),
            SizedBox(height: 26),
            _HierarchyDiagramSection(),
            SizedBox(height: 26),
            _PropertyTypeTableSection(),
            SizedBox(height: 26),
            _TreeStyleGallerySection(),
            SizedBox(height: 26),
            _DiagnosticLevelScaleSection(),
            SizedBox(height: 26),
            _PracticalExampleSection(),
            SizedBox(height: 26),
            _JsonMapPreviewSection(),
            SizedBox(height: 26),
            _PitfallsSection(),
            SizedBox(height: 26),
            _BestPracticesSection(),
            SizedBox(height: 26),
            _FooterSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 - Hero banner
// ----------------------------------------------------------------------------
// Wide gradient panel introducing DiagnosticsNode with a short pitch.
// Gradient #1 of the required >=6.
// ============================================================================

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF1A237E),
            const Color(0xFF3949AB),
            const Color(0xFF5C6BC0).withValues(alpha: 0.92),
          ],
          stops: const <double>[0.0, 0.55, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.55),
                    width: 1.4,
                  ),
                ),
                child: const Icon(
                  Icons.account_tree_outlined,
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
                      'DiagnosticsNode',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white.withValues(alpha: 0.98),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'The recursive description-tree primitive',
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            'DiagnosticsNode is how Flutter explains itself to developers. '
            'Every widget tree dump, every property pane in DevTools, every '
            'error-banner field, and every toStringDeep output is built by '
            'composing DiagnosticsNode instances into a tree which is then '
            'rendered by a TextTreeRenderer or serialized to JSON.',
            style: TextStyle(
              fontSize: 14.5,
              height: 1.55,
              color: Colors.white.withValues(alpha: 0.94),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _HeroBadge(label: 'abstract', color: Color(0xFFFFAB91)),
              _HeroBadge(label: 'recursive', color: Color(0xFFA5D6A7)),
              _HeroBadge(label: 'lazy', color: Color(0xFF90CAF9)),
              _HeroBadge(label: 'styleable', color: Color(0xFFCE93D8)),
              _HeroBadge(label: 'json-able', color: Color(0xFFFFE082)),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amberAccent.withValues(alpha: 0.95),
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'You almost never construct DiagnosticsNode directly. '
                    'Instead you add DiagnosticsProperty<T> instances inside '
                    'debugFillProperties on your Diagnosticable.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.92),
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

class _HeroBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _HeroBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.65), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: color.withValues(alpha: 0.98),
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 2 - Class hierarchy diagram
// ----------------------------------------------------------------------------
// A static "boxes and connectors" rendering of the DiagnosticsNode subtype
// tree. Gradient #2.
// ============================================================================

class _HierarchyDiagramSection extends StatelessWidget {
  const _HierarchyDiagramSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Class hierarchy',
      subtitle: 'DiagnosticsNode and its built-in descendants',
      accent: const Color(0xFF00838F),
      icon: Icons.schema_outlined,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              const Color(0xFFE0F7FA),
              const Color(0xFFB2EBF2).withValues(alpha: 0.65),
              const Color(0xFF80DEEA).withValues(alpha: 0.35),
            ],
          ),
          border: Border.all(
              color: const Color(0xFF00ACC1).withValues(alpha: 0.4)),
        ),
        child: Column(
          children: <Widget>[
            _HierarchyBox(
              label: 'DiagnosticsNode',
              subLabel: 'abstract',
              color: const Color(0xFF006064),
              width: 280,
            ),
            const _HierarchyConnector(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _HierarchyBox(
                  label: 'MessageProperty',
                  subLabel: 'string-only',
                  color: const Color(0xFF0277BD),
                  width: 150,
                ),
                _HierarchyBox(
                  label: 'DiagnosticableNode<T>',
                  subLabel: 'wraps Diagnosticable',
                  color: const Color(0xFF00695C),
                  width: 180,
                ),
                _HierarchyBox(
                  label: 'DiagnosticsProperty<T>',
                  subLabel: 'named value',
                  color: const Color(0xFF4527A0),
                  width: 180,
                ),
                _HierarchyBox(
                  label: 'DiagnosticsBlock',
                  subLabel: 'group',
                  color: const Color(0xFFAD1457),
                  width: 150,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _HierarchyConnector(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color(0xFF4527A0).withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Concrete DiagnosticsProperty<T> subclasses',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4527A0).withValues(alpha: 0.95),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const <Widget>[
                      _LeafChip('StringProperty'),
                      _LeafChip('IntProperty'),
                      _LeafChip('DoubleProperty'),
                      _LeafChip('PercentProperty'),
                      _LeafChip('FlagProperty'),
                      _LeafChip('EnumProperty<T>'),
                      _LeafChip('IterableProperty<T>'),
                      _LeafChip('ObjectFlagProperty<T>'),
                      _LeafChip('ColorProperty'),
                      _LeafChip('IconDataProperty'),
                      _LeafChip('AttributedStringProperty'),
                      _LeafChip('StackTraceProperty'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HierarchyBox extends StatelessWidget {
  final String label;
  final String subLabel;
  final Color color;
  final double width;
  const _HierarchyBox({
    required this.label,
    required this.subLabel,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.98),
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 10.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _HierarchyConnector extends StatelessWidget {
  final double height;
  const _HierarchyConnector({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: height,
      color: const Color(0xFF006064).withValues(alpha: 0.6),
    );
  }
}

class _LeafChip extends StatelessWidget {
  final String label;
  const _LeafChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE7F6),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFF4527A0).withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: const Color(0xFF311B92).withValues(alpha: 0.95),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ============================================================================
// Shared section shell (helper, not counted)
// ============================================================================

class _SectionShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color accent;
  final IconData icon;
  final Widget child;
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: accent.withValues(alpha: 0.92),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black.withValues(alpha: 0.55),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 3 - Property type table
// ----------------------------------------------------------------------------
// Tabular listing of the most commonly used DiagnosticsProperty subclasses,
// their typical usage in debugFillProperties, and a sample rendered string.
// Gradient #3.
// ============================================================================

class _PropertyTypeTableSection extends StatelessWidget {
  const _PropertyTypeTableSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Property type catalog',
      subtitle: 'Pick the right DiagnosticsProperty<T> subclass',
      accent: const Color(0xFF6A1B9A),
      icon: Icons.table_chart_outlined,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              const Color(0xFFF3E5F5),
              const Color(0xFFE1BEE7).withValues(alpha: 0.55),
              const Color(0xFFCE93D8).withValues(alpha: 0.35),
            ],
          ),
        ),
        child: Column(
          children: const <Widget>[
            _PropTableHeader(),
            _PropRow(
              type: 'StringProperty',
              ctor: "StringProperty('label', value)",
              rendering: 'label: "hello world"',
              note: 'auto-quotes; supports defaultValue & quoted:false',
              color: Color(0xFF1E88E5),
            ),
            _PropRow(
              type: 'IntProperty',
              ctor: "IntProperty('count', n)",
              rendering: 'count: 42',
              note: 'hidden when value matches defaultValue',
              color: Color(0xFF43A047),
            ),
            _PropRow(
              type: 'DoubleProperty',
              ctor: "DoubleProperty('opacity', 0.8)",
              rendering: 'opacity: 0.8',
              note: 'fractionDigits formats output',
              color: Color(0xFFFB8C00),
            ),
            _PropRow(
              type: 'PercentProperty',
              ctor: "PercentProperty('progress', 0.75)",
              rendering: 'progress: 75.0%',
              note: 'multiplies by 100 and appends %',
              color: Color(0xFFEF6C00),
            ),
            _PropRow(
              type: 'FlagProperty',
              ctor: "FlagProperty('visible', value: true, ifTrue: 'shown')",
              rendering: 'shown',
              note: 'ifTrue/ifFalse messages; no name when shown',
              color: Color(0xFF8E24AA),
            ),
            _PropRow(
              type: 'EnumProperty<TextAlign>',
              ctor: "EnumProperty('align', TextAlign.center)",
              rendering: 'align: center',
              note: 'strips enum class prefix',
              color: Color(0xFFD81B60),
            ),
            _PropRow(
              type: 'IterableProperty<T>',
              ctor: "IterableProperty('items', list)",
              rendering: 'items: [a, b, c]',
              note: 'or one-per-line in non-singleLine styles',
              color: Color(0xFF00ACC1),
            ),
            _PropRow(
              type: 'ObjectFlagProperty<T>',
              ctor: "ObjectFlagProperty('onTap', cb, ifNull: 'disabled')",
              rendering: 'disabled',
              note: 'great for callback presence indicators',
              color: Color(0xFF6D4C41),
            ),
            _PropRow(
              type: 'ColorProperty',
              ctor: "ColorProperty('color', Colors.red)",
              rendering: 'color: Color(0xfff44336)',
              note: 'renders as Color(0xAARRGGBB)',
              color: Color(0xFFE53935),
            ),
            _PropRow(
              type: 'IconDataProperty',
              ctor: "IconDataProperty('icon', Icons.star)",
              rendering: 'icon: IconData(U+0E5F8)',
              note: 'shows code-point of the glyph',
              color: Color(0xFFFFB300),
            ),
            _PropRow(
              type: 'AttributedStringProperty',
              ctor: "AttributedStringProperty('label', attr)",
              rendering: 'label: "hi" [bold]',
              note: 'preserves attributes in description',
              color: Color(0xFF3949AB),
            ),
            _PropRow(
              type: 'StackTraceProperty',
              ctor: "DiagnosticsStackTrace('thrown at', stack)",
              rendering: 'thrown at:\\n  #0 main...',
              note: 'block-style; readable line wrapping',
              color: Color(0xFFC62828),
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

class _PropTableHeader extends StatelessWidget {
  const _PropTableHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF6A1B9A).withValues(alpha: 0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Type',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.98),
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'Constructor',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.98),
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Rendering',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.98),
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'Note',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.98),
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PropRow extends StatelessWidget {
  final String type;
  final String ctor;
  final String rendering;
  final String note;
  final Color color;
  const _PropRow({
    required this.type,
    required this.ctor,
    required this.rendering,
    required this.note,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        border: Border(
          bottom: BorderSide(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: color.withValues(alpha: 0.95),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 4,
            child: Text(
              ctor,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.black.withValues(alpha: 0.78),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 3,
            child: Text(
              rendering,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.black.withValues(alpha: 0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 4,
            child: Text(
              note,
              style: TextStyle(
                fontSize: 11,
                color: Colors.black.withValues(alpha: 0.62),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 4 - DiagnosticsTreeStyle gallery
// ----------------------------------------------------------------------------
// For each value of DiagnosticsTreeStyle, a tile showing what a small
// rendered tree looks like under that style. Uses ASCII-style line drawing
// inside fixed-width code blocks. Gradient #4.
// ============================================================================

class _TreeStyleGallerySection extends StatelessWidget {
  const _TreeStyleGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'DiagnosticsTreeStyle gallery',
      subtitle: 'Same tree, rendered eleven different ways',
      accent: const Color(0xFF2E7D32),
      icon: Icons.style_outlined,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              const Color(0xFFE8F5E9),
              const Color(0xFFC8E6C9).withValues(alpha: 0.6),
              const Color(0xFFA5D6A7).withValues(alpha: 0.4),
            ],
          ),
        ),
        child: Column(
          children: const <Widget>[
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.dense',
              note: 'compact; minimal whitespace; default for many props',
              accent: Color(0xFF1B5E20),
              rendering: '''
Container
├─ child: Padding(padding: EdgeInsets.all(8))
│  └─ child: Text("hi", style: TextStyle(color: Color(0xff000000)))
└─ decoration: BoxDecoration(color: Color(0xffeeeeee))''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.sparse',
              note: 'default for child nodes of Element/RenderObject',
              accent: Color(0xFF2E7D32),
              rendering: '''
Container

 ├── child: Padding
 │     padding: EdgeInsets.all(8)
 │
 │     └── child: Text("hi")
 │
 └── decoration: BoxDecoration
       color: Color(0xffeeeeee)''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.offstage',
              note: 'used for offstage nodes; muted prefix style',
              accent: Color(0xFF558B2F),
              rendering: '''
[OFFSTAGE]
  Container
  ├─ child: SizedBox(width: 100, height: 100)
  └─ color: Color(0xff9e9e9e)''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.transition',
              note: 'used in animations; arrow-like prefix',
              accent: Color(0xFF00897B),
              rendering: '''
AnimationController
  ⤳ status: forward
  ⤳ value: 0.42
  ⤳ duration: 300ms''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.error',
              note: 'used by FlutterError for the headline of an error',
              accent: Color(0xFFC62828),
              rendering: '''
═══════════ Exception caught by widgets library ═══════════
The following assertion was thrown building MyWidget:
'package:foo/bar.dart': Failed assertion: line 12 pos 7
═══════════════════════════════════════════════════════════''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.whitespace',
              note: 'no connectors; pure indentation',
              accent: Color(0xFF6A1B9A),
              rendering: '''
Container
    child: Padding
        padding: EdgeInsets.all(8)
        child: Text("hi")
    decoration: BoxDecoration
        color: Color(0xffeeeeee)''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.flat',
              note: 'children inline; no nesting indentation',
              accent: Color(0xFF4527A0),
              rendering: '''
Container
child: Padding
padding: EdgeInsets.all(8)
child: Text("hi")
decoration: BoxDecoration
color: Color(0xffeeeeee)''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.singleLine',
              note: 'everything on one line; used inside Iterable rendering',
              accent: Color(0xFF1565C0),
              rendering: '''
Container(child: Padding(padding: EdgeInsets.all(8), child: Text("hi")), decoration: BoxDecoration(color: Color(0xffeeeeee)))''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.errorProperty',
              note: 'used for property nodes inside error reports',
              accent: Color(0xFFB71C1C),
              rendering: '''
The relevant error-causing widget was:
   MyWidget MyWidget:file:///lib/main.dart:42:7''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.shallow',
              note: 'expand only one level',
              accent: Color(0xFFEF6C00),
              rendering: '''
Container
  child: Padding (collapsed)
  decoration: BoxDecoration (collapsed)''',
            ),
            SizedBox(height: 10),
            _TreeStyleTile(
              styleName: 'DiagnosticsTreeStyle.truncateChildren',
              note: 'long child lists get a "(N more)" tail',
              accent: Color(0xFF00838F),
              rendering: '''
Row
├─ child 1: Text("a")
├─ child 2: Text("b")
├─ child 3: Text("c")
└─ ...(47 more children)''',
            ),
          ],
        ),
      ),
    );
  }
}

class _TreeStyleTile extends StatelessWidget {
  final String styleName;
  final String note;
  final String rendering;
  final Color accent;
  const _TreeStyleTile({
    required this.styleName,
    required this.note,
    required this.rendering,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
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
                  shape: BoxShape.circle,
                  color: accent.withValues(alpha: 0.85),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                styleName,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: accent.withValues(alpha: 0.95),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  note,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                    color: Colors.black.withValues(alpha: 0.55),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF263238),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: accent.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Text(
              rendering,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.4,
                color: const Color(0xFFB2DFDB).withValues(alpha: 0.95),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 5 - DiagnosticLevel scale
// ----------------------------------------------------------------------------
// Vertical color-coded ladder from hidden -> off, illustrating how level
// affects whether a node appears in textual or DevTools output.
// Gradient #5.
// ============================================================================

class _DiagnosticLevelScaleSection extends StatelessWidget {
  const _DiagnosticLevelScaleSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'DiagnosticLevel scale',
      subtitle: 'How visibility escalates from hidden to off',
      accent: const Color(0xFFEF6C00),
      icon: Icons.stairs_outlined,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              const Color(0xFFFFF3E0),
              const Color(0xFFFFE0B2).withValues(alpha: 0.55),
              const Color(0xFFFFCC80).withValues(alpha: 0.35),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _LevelRow(
              level: 'hidden',
              code: '0',
              color: Color(0xFF9E9E9E),
              description:
                  'Never shown in textual output. Used for properties that '
                  'matched their defaultValue or are otherwise uninteresting.',
              example: 'IntProperty("count", 0, defaultValue: 0)',
            ),
            _LevelRow(
              level: 'fine',
              code: '1',
              color: Color(0xFF607D8B),
              description:
                  'Only shown in verbose dumps. Hidden by default in the '
                  'standard toStringDeep output.',
              example: 'lowest-detail counters or stats',
            ),
            _LevelRow(
              level: 'debug',
              code: '2',
              color: Color(0xFF455A64),
              description:
                  'Shown only when debug mode wants every detail; below the '
                  'normal display threshold.',
              example: 'internal cache hits / dirty flags',
            ),
            _LevelRow(
              level: 'info',
              code: '3',
              color: Color(0xFF1976D2),
              description:
                  'Default level. Most properties live here and appear in '
                  'normal toStringDeep output.',
              example: 'StringProperty("title", "hello")',
            ),
            _LevelRow(
              level: 'warning',
              code: '4',
              color: Color(0xFFF9A825),
              description:
                  'Indicates a property whose value is suspicious — like a '
                  'callback supplied where one usually is not.',
              example: 'ObjectFlagProperty<Function>("onTap", null, ifNull: "MISSING")',
            ),
            _LevelRow(
              level: 'hint',
              code: '5',
              color: Color(0xFF00897B),
              description:
                  'Hint nodes used in error reports — "did you mean ...?" '
                  'guidance.',
              example: 'ErrorHint("Did you forget to call super?")',
            ),
            _LevelRow(
              level: 'summary',
              code: '6',
              color: Color(0xFF6A1B9A),
              description:
                  'Short, human-readable headline of an error. Always shown '
                  'even when other levels are filtered.',
              example: 'ErrorSummary("Multiple widgets used the same key")',
            ),
            _LevelRow(
              level: 'error',
              code: '7',
              color: Color(0xFFC62828),
              description:
                  'Properties documenting an actual error. Stay visible at '
                  'almost every level.',
              example: 'DiagnosticsProperty<Object>("exception", e, level: error)',
            ),
            _LevelRow(
              level: 'off',
              code: '8',
              color: Color(0xFF263238),
              description:
                  'Completely suppress the node. Even verbose dumps will '
                  'skip it; useful for redacted secrets.',
              example: 'StringProperty("password", "***", level: off)',
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  final String level;
  final String code;
  final Color color;
  final String description;
  final String example;
  const _LevelRow({
    required this.level,
    required this.code,
    required this.color,
    required this.description,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: color.withValues(alpha: 0.85), width: 6),
          top: BorderSide(color: color.withValues(alpha: 0.18)),
          right: BorderSide(color: color.withValues(alpha: 0.18)),
          bottom: BorderSide(color: color.withValues(alpha: 0.18)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  level,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withValues(alpha: 0.98),
                  ),
                ),
                Text(
                  '#$code',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.78),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: Colors.black.withValues(alpha: 0.78),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: color.withValues(alpha: 0.32), width: 1),
                  ),
                  child: Text(
                    example,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: color.withValues(alpha: 0.92),
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

// ============================================================================
// SECTION 6 - Practical example
// ----------------------------------------------------------------------------
// Source code for a fake DiagnosticableTree subclass and a static rendering
// of what its toStringDeep would output. No gradient here (uses chrome).
// ============================================================================

class _PracticalExampleSection extends StatelessWidget {
  const _PracticalExampleSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Practical example',
      subtitle: 'A fake widget, its debugFillProperties, and toStringDeep',
      accent: const Color(0xFF00695C),
      icon: Icons.code,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _CodeBlock(
            title: 'lib/my_widget.dart',
            language: 'dart',
            background: const Color(0xFF1B2A2A),
            foreground: const Color(0xFFB2DFDB),
            code: '''
class MyWidget extends StatelessWidget with DiagnosticableTreeMixin {
  const MyWidget({
    super.key,
    required this.label,
    required this.count,
    this.color = Colors.blue,
    this.enabled = true,
    this.onTap,
    this.tags = const <String>[],
  });

  final String label;
  final int count;
  final Color color;
  final bool enabled;
  final VoidCallback? onTap;
  final List<String> tags;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(IntProperty('count', count, defaultValue: 0));
    properties.add(ColorProperty('color', color));
    properties.add(FlagProperty(
      'enabled',
      value: enabled,
      ifTrue: 'enabled',
      ifFalse: 'disabled',
    ));
    properties.add(ObjectFlagProperty<VoidCallback>(
      'onTap',
      onTap,
      ifNull: 'no tap handler',
    ));
    properties.add(IterableProperty<String>('tags', tags,
        defaultValue: const <String>[]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Text(label),
    );
  }
}''',
          ),
          const SizedBox(height: 14),
          _CodeBlock(
            title: 'MyWidget(...).toStringDeep()',
            language: 'output',
            background: const Color(0xFF263238),
            foreground: const Color(0xFFFFE0B2),
            code: '''
MyWidget
 │ label: "submit"
 │ count: 3
 │ color: Color(0xff2196f3)
 │ enabled
 │ no tap handler
 │ tags: [primary, action, hot]
 │
 └─Container(color: Color(0xff2196f3))
      │ alignment: null
      │ padding: null
      │ bg: Color(0xff2196f3)
      │
      └─Text("submit")
          textAlign: null
          maxLines: unlimited
          softWrap: wrapping at box width''',
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF00695C).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF00695C).withValues(alpha: 0.9),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Notice: count=0 would be elided because defaultValue: 0. '
                    'enabled=true renders as the word "enabled" (no name) '
                    'because FlagProperty supplies ifTrue. onTap=null renders '
                    'as "no tap handler" because ObjectFlagProperty supplies '
                    'ifNull. Empty tags lists are elided.',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: const Color(0xFF004D40).withValues(alpha: 0.88),
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

class _CodeBlock extends StatelessWidget {
  final String title;
  final String language;
  final String code;
  final Color background;
  final Color foreground;
  const _CodeBlock({
    required this.title,
    required this.language,
    required this.code,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: background,
        border: Border.all(color: foreground.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amberAccent.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: foreground.withValues(alpha: 0.85),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: foreground.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    language,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: foreground.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
                color: foreground.withValues(alpha: 0.95),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 7 - JSON map preview
// ----------------------------------------------------------------------------
// What DevTools sees when it calls toJsonMap on a DiagnosticsNode. Shown as a
// styled JSON block with colored keys and values. Gradient #6.
// ============================================================================

class _JsonMapPreviewSection extends StatelessWidget {
  const _JsonMapPreviewSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'toJsonMap output',
      subtitle: 'How DevTools consumes a DiagnosticsNode',
      accent: const Color(0xFF1565C0),
      icon: Icons.data_object_outlined,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              const Color(0xFFE3F2FD),
              const Color(0xFFBBDEFB).withValues(alpha: 0.6),
              const Color(0xFF90CAF9).withValues(alpha: 0.35),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Each DiagnosticsProperty serializes to a JSON map carrying its '
              'description, type, level, style, optional value preview, and a '
              'lazy list of children that DevTools can request on demand.',
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.black.withValues(alpha: 0.7),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1B2A),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF1565C0).withValues(alpha: 0.6),
                ),
              ),
              child: const _JsonLines(lines: <_JsonLine>[
                _JsonLine(indent: 0, text: '{'),
                _JsonLine(indent: 1, kind: _JK.key, text: '"description"'),
                _JsonLine(indent: 1, kind: _JK.string, text: ': "MyWidget",'),
                _JsonLine(indent: 1, kind: _JK.key, text: '"type"'),
                _JsonLine(indent: 1, kind: _JK.string,
                    text: ': "_ElementDiagnosticableTreeNode",'),
                _JsonLine(indent: 1, kind: _JK.key, text: '"hasChildren"'),
                _JsonLine(indent: 1, kind: _JK.bool, text: ': true,'),
                _JsonLine(indent: 1, kind: _JK.key, text: '"allowWrap"'),
                _JsonLine(indent: 1, kind: _JK.bool, text: ': false,'),
                _JsonLine(indent: 1, kind: _JK.key, text: '"objectId"'),
                _JsonLine(indent: 1, kind: _JK.string,
                    text: ': "inspector-1842",'),
                _JsonLine(indent: 1, kind: _JK.key, text: '"valueId"'),
                _JsonLine(indent: 1, kind: _JK.string,
                    text: ': "inspector-1843",'),
                _JsonLine(indent: 1, kind: _JK.key,
                    text: '"summaryTree"'),
                _JsonLine(indent: 1, kind: _JK.bool, text: ': true,'),
                _JsonLine(indent: 1, kind: _JK.key, text: '"properties"'),
                _JsonLine(indent: 1, text: ': ['),
                _JsonLine(indent: 2, text: '{'),
                _JsonLine(indent: 3, kind: _JK.key,
                    text: '"description"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "\\"submit\\"",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"name"'),
                _JsonLine(indent: 3, kind: _JK.string, text: ': "label",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"type"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "StringProperty",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"level"'),
                _JsonLine(indent: 3, kind: _JK.string, text: ': "info",'),
                _JsonLine(indent: 3, kind: _JK.key,
                    text: '"propertyType"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "String"'),
                _JsonLine(indent: 2, text: '},'),
                _JsonLine(indent: 2, text: '{'),
                _JsonLine(indent: 3, kind: _JK.key,
                    text: '"description"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "Color(0xff2196f3)",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"name"'),
                _JsonLine(indent: 3, kind: _JK.string, text: ': "color",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"type"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "ColorProperty",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"level"'),
                _JsonLine(indent: 3, kind: _JK.string, text: ': "info"'),
                _JsonLine(indent: 2, text: '},'),
                _JsonLine(indent: 2, text: '{'),
                _JsonLine(indent: 3, kind: _JK.key,
                    text: '"description"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "enabled",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"name"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "enabled",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"type"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "FlagProperty",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"ifTrue"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "enabled",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"ifFalse"'),
                _JsonLine(indent: 3, kind: _JK.string,
                    text: ': "disabled",'),
                _JsonLine(indent: 3, kind: _JK.key, text: '"showName"'),
                _JsonLine(indent: 3, kind: _JK.bool,
                    text: ': false'),
                _JsonLine(indent: 2, text: '}'),
                _JsonLine(indent: 1, text: '],'),
                _JsonLine(indent: 1, kind: _JK.key,
                    text: '"createdByLocalProject"'),
                _JsonLine(indent: 1, kind: _JK.bool, text: ': true'),
                _JsonLine(indent: 0, text: '}'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

enum _JK { plain, key, string, number, bool }

class _JsonLine {
  final int indent;
  final _JK kind;
  final String text;
  const _JsonLine({
    required this.indent,
    this.kind = _JK.plain,
    required this.text,
  });
}

class _JsonLines extends StatelessWidget {
  final List<_JsonLine> lines;
  const _JsonLines({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map(_render).toList(),
    );
  }

  Widget _render(_JsonLine line) {
    Color color;
    switch (line.kind) {
      case _JK.key:
        color = const Color(0xFF80DEEA);
        break;
      case _JK.string:
        color = const Color(0xFFC5E1A5);
        break;
      case _JK.number:
        color = const Color(0xFFFFAB91);
        break;
      case _JK.bool:
        color = const Color(0xFFCE93D8);
        break;
      case _JK.plain:
        color = const Color(0xFFECEFF1);
        break;
    }
    return Padding(
      padding: EdgeInsets.only(left: 14.0 * line.indent),
      child: Text(
        line.text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.4,
          color: color.withValues(alpha: 0.95),
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 8 - Pitfalls
// ----------------------------------------------------------------------------
// Common mistakes when implementing debugFillProperties or wiring custom
// diagnostics.
// ============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Pitfalls and footguns',
      subtitle: 'Mistakes that quietly break debug output',
      accent: const Color(0xFFC62828),
      icon: Icons.warning_amber_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _Pitfall(
            title: 'Forgetting super.debugFillProperties(properties)',
            badCode: '''
@override
void debugFillProperties(DiagnosticPropertiesBuilder p) {
  p.add(StringProperty('label', label));
}''',
            goodCode: '''
@override
void debugFillProperties(DiagnosticPropertiesBuilder p) {
  super.debugFillProperties(p);
  p.add(StringProperty('label', label));
}''',
            explanation:
                'Without super, you lose all properties contributed by the '
                'parent class — key, hashCode, runtimeType, etc.',
          ),
          _Pitfall(
            title: 'Re-implementing toString instead of describeIdentity',
            badCode: '''
@override
String toString() => 'MyWidget(\$label)';''',
            goodCode: '''
// Just override debugFillProperties; toString already
// invokes it via the Diagnosticable machinery.''',
            explanation:
                'Overriding toString bypasses style/level handling and breaks '
                'DevTools rendering.',
          ),
          _Pitfall(
            title: 'Forgetting defaultValue on common defaults',
            badCode: '''
p.add(IntProperty('count', count));
p.add(IterableProperty('tags', tags));''',
            goodCode: '''
p.add(IntProperty('count', count, defaultValue: 0));
p.add(IterableProperty<String>(
  'tags',
  tags,
  defaultValue: const <String>[],
));''',
            explanation:
                'Without defaultValue, you cannot elide uninteresting "zero" '
                'properties and your toStringDeep output becomes noisy.',
          ),
          _Pitfall(
            title: 'Wrong showName for FlagProperty',
            badCode: '''
p.add(FlagProperty('enabled', value: enabled,
    ifTrue: 'enabled', showName: true));''',
            goodCode: '''
p.add(FlagProperty('enabled', value: enabled,
    ifTrue: 'enabled', ifFalse: 'disabled'));''',
            explanation:
                'FlagProperty is meant to read like a sentence: "enabled" or '
                '"disabled", not "enabled: enabled".',
          ),
          _Pitfall(
            title: 'Calling toStringDeep on a hot path',
            badCode: '''
print(widget.toStringDeep()); // every frame, in release too!''',
            goodCode: '''
assert(() {
  debugPrint(widget.toStringDeep());
  return true;
}());''',
            explanation:
                'toStringDeep is intentionally expensive (walks the entire '
                'tree, allocates many strings). Gate behind assert(...).',
          ),
          _Pitfall(
            title: 'Passing non-Diagnosticable values to ObjectFlagProperty',
            badCode: '''
p.add(ObjectFlagProperty<dynamic>('config', config,
    ifNull: 'no config'));''',
            goodCode: '''
p.add(DiagnosticsProperty<Config>('config', config,
    defaultValue: null));''',
            explanation:
                'ObjectFlagProperty is for "has a callback?" booleans, not '
                'arbitrary object descriptions. Use DiagnosticsProperty<T>.',
          ),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  final String title;
  final String badCode;
  final String goodCode;
  final String explanation;
  const _Pitfall({
    required this.title,
    required this.badCode,
    required this.goodCode,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFC62828).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.error_outline,
                color: const Color(0xFFC62828).withValues(alpha: 0.85),
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF8E0000).withValues(alpha: 0.95),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _MiniCode(
                  label: 'BAD',
                  labelColor: const Color(0xFFC62828),
                  code: badCode,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _MiniCode(
                  label: 'GOOD',
                  labelColor: const Color(0xFF2E7D32),
                  code: goodCode,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            explanation,
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniCode extends StatelessWidget {
  final String label;
  final Color labelColor;
  final String code;
  const _MiniCode({
    required this.label,
    required this.labelColor,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: labelColor.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: labelColor.withValues(alpha: 0.85),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: Colors.white.withValues(alpha: 0.98),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.88),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 9 - Best practices card
// ============================================================================

class _BestPracticesSection extends StatelessWidget {
  const _BestPracticesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Best practices checklist',
      subtitle: 'Habits that keep debug output legible and cheap',
      accent: const Color(0xFF2E7D32),
      icon: Icons.checklist_rtl_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _PracticeRow(
            ok: true,
            title: 'Always call super.debugFillProperties first',
            detail:
                'Preserves parent class properties. Without it, runtimeType, '
                'key, hashCode, and base-class state vanish from output.',
          ),
          _PracticeRow(
            ok: true,
            title: 'Provide defaultValue for every property that has one',
            detail:
                'Allows toStringDeep to elide the property when the value is '
                'uninteresting. Keeps logs small and readable.',
          ),
          _PracticeRow(
            ok: true,
            title: 'Use the most specific Property subclass available',
            detail:
                'ColorProperty for Color, EnumProperty for enums, etc. They '
                'know how to format values in the standard Flutter way.',
          ),
          _PracticeRow(
            ok: true,
            title: 'Pair ifTrue/ifFalse with showName: false on FlagProperty',
            detail:
                'Yields readable "enabled" / "disabled" output instead of '
                '"enabled: enabled".',
          ),
          _PracticeRow(
            ok: true,
            title: 'Use ObjectFlagProperty for callback presence',
            detail:
                'Especially with ifNull. Communicates that an optional '
                'callback was not supplied.',
          ),
          _PracticeRow(
            ok: true,
            title: 'Gate any custom toStringDeep() calls behind assert',
            detail:
                'They walk the entire descendant tree and can dominate frame '
                'time if invoked in production.',
          ),
          _PracticeRow(
            ok: true,
            title: 'Prefer DiagnosticableTreeMixin over DiagnosticableTree',
            detail:
                'Mixin works with any superclass and lets you add tree '
                'capabilities without changing the inheritance chain.',
          ),
          _PracticeRow(
            ok: false,
            title: "Don't override toString manually",
            detail:
                'The Diagnosticable machinery already calls debugFillProperties '
                'and renders the result. Overriding toString breaks style/level.',
          ),
          _PracticeRow(
            ok: false,
            title: "Don't add expensive computations in debugFillProperties",
            detail:
                'It may be called many times (DevTools refresh, error reports, '
                'tests). Keep it side-effect free and fast.',
          ),
          _PracticeRow(
            ok: false,
            title: "Don't leak secrets through DiagnosticsProperty",
            detail:
                'Passwords, tokens, PII — use level: DiagnosticLevel.off or '
                'redact the value before passing it to a property.',
          ),
        ],
      ),
    );
  }
}

class _PracticeRow extends StatelessWidget {
  final bool ok;
  final String title;
  final String detail;
  const _PracticeRow({
    required this.ok,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = ok ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    final IconData icon = ok ? Icons.check_circle : Icons.cancel;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color.withValues(alpha: 0.9), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: color.withValues(alpha: 0.95),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: Colors.black.withValues(alpha: 0.72),
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

// ============================================================================
// SECTION 10 - Footer
// ============================================================================

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            const Color(0xFF263238),
            const Color(0xFF37474F),
            const Color(0xFF455A64).withValues(alpha: 0.95),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(
                  Icons.menu_book_outlined,
                  color: Colors.white.withValues(alpha: 0.95),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Further reading',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white.withValues(alpha: 0.98),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Source files inside the Flutter SDK',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _FooterRef(
            path: 'packages/flutter/lib/src/foundation/diagnostics.dart',
            note:
                'Primary file. Contains DiagnosticsNode, MessageProperty, '
                'DiagnosticsProperty<T> and all builtin subclasses, plus '
                'TextTreeRenderer / TextTreeConfiguration.',
          ),
          _FooterRef(
            path: 'packages/flutter/lib/src/foundation/_features.dart',
            note:
                'Feature gates that affect how diagnostics behave in profile '
                'and release builds.',
          ),
          _FooterRef(
            path: 'packages/flutter/lib/src/widgets/widget_inspector.dart',
            note:
                'How the inspector consumes toJsonMap / toJsonList for the '
                'DevTools widget tree pane.',
          ),
          _FooterRef(
            path: 'packages/flutter/lib/src/foundation/assertions.dart',
            note:
                'FlutterErrorDetails composes DiagnosticsNode trees to '
                'produce the formatted error banner you see in red.',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.copyright_outlined,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Manual deep-demo for tom_d4rt_flutter_ast — '
                    'DiagnosticsNode visualization. Fully static; no async, '
                    'no I/O, no stateful widgets.',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.white.withValues(alpha: 0.7),
                      fontStyle: FontStyle.italic,
                      height: 1.5,
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

class _FooterRef extends StatelessWidget {
  final String path;
  final String note;
  const _FooterRef({required this.path, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: const Color(0xFF80DEEA).withValues(alpha: 0.8),
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            path,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF80DEEA).withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            note,
            style: TextStyle(
              fontSize: 11.5,
              height: 1.45,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}
