// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep-visual demo: DiagnosticsTreeStyle from package:flutter/foundation.dart
// Demonstrates each enum value (none, sparse, offstage, dense, transition,
// error, whitespace, flat, singleLine, errorProperty, shallow, truncateChildren)
// with hand-authored tree art, gradients, shadows and recipe cards.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Pinned animations (static motion only, no controllers).
  // ============================================================
  final AlwaysStoppedAnimation<double> pulse = AlwaysStoppedAnimation<double>(
    0.62,
  );
  final AlwaysStoppedAnimation<double> drift = AlwaysStoppedAnimation<double>(
    0.18,
  );
  final AlwaysStoppedAnimation<double> warp = AlwaysStoppedAnimation<double>(
    0.94,
  );
  final Duration heartbeat = Duration.zero;

  // ============================================================
  // Per-style metadata table. Each entry drives a card.
  // ============================================================
  final List<_StyleSpec> specs = <_StyleSpec>[
    _StyleSpec(
      style: DiagnosticsTreeStyle.none,
      glyph: '∅',
      icon: Icons.visibility_off_outlined,
      headline: 'Invisible in release',
      tagline: 'no tree at all',
      paletteA: Color(0xFF2E2E36),
      paletteB: Color(0xFF55555F),
      tone: Color(0xFF8A8A93),
      sample: <String>[
        '(no tree emitted)',
        '// Used so debugFillProperties stays cheap',
        '// when the tree is not meant to be printed.',
      ],
      uses: <String>[
        'Release builds where description is suppressed.',
        'Synthetic helpers that should never appear.',
        'Replacement for verbose debug output.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.sparse,
      glyph: '┊',
      icon: Icons.account_tree_outlined,
      headline: 'Default RenderObject look',
      tagline: 'classic dotted spine',
      paletteA: Color(0xFF1E3A8A),
      paletteB: Color(0xFF3B82F6),
      tone: Color(0xFF1E40AF),
      sample: <String>[
        'RenderFlex#a1b2c (relayoutBoundary=up1)',
        '│ creator: Column ← Center ← _BodyBuilder',
        '│ size: Size(411.4, 707.4)',
        '│ direction: vertical',
        '╞═╦══ child 1: RenderConstrainedBox',
        '│ ║   size: Size(120.0, 40.0)',
        '╘═╩══ child 2: RenderPadding',
      ],
      uses: <String>[
        'Render trees from `debugDumpRenderTree`.',
        'Verbose component snapshots.',
        'When you need parent → child traceability.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.offstage,
      glyph: '⋯',
      icon: Icons.layers_outlined,
      headline: 'Dashed offstage spine',
      tagline: 'nodes that exist but do not paint',
      paletteA: Color(0xFF4A1D96),
      paletteB: Color(0xFF8B5CF6),
      tone: Color(0xFF6D28D9),
      sample: <String>[
        'RenderSliverMultiBoxAdaptor',
        '╎╴ visible: child 0 (paint=true)',
        '╎╴ visible: child 1 (paint=true)',
        '╎┄ offstage: child 2 (paint=false)',
        '╎┄ offstage: child 3 (paint=false)',
      ],
      uses: <String>[
        'Slivers caching off-screen children.',
        'Marking elements kept-alive but not painted.',
        'Distinguishing skeleton from active nodes.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.dense,
      glyph: '▎',
      icon: Icons.format_list_numbered,
      headline: 'Compact element dump',
      tagline: 'less padding, more rows',
      paletteA: Color(0xFF064E3B),
      paletteB: Color(0xFF10B981),
      tone: Color(0xFF047857),
      sample: <String>[
        'StatefulElement(MyHomePage(state:_MyHomePageState))',
        '├StatelessElement(MaterialApp)',
        '├StatelessElement(Scaffold)',
        '│├StatelessElement(AppBar)',
        '│└StatelessElement(Center)',
        '│ └StatelessElement(Column)',
      ],
      uses: <String>[
        'Element trees from `debugDumpApp`.',
        'High-fanout widget hierarchies.',
        'Logs where vertical space is precious.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.transition,
      glyph: '⇿',
      icon: Icons.swap_horiz,
      headline: 'Cross-style adapter',
      tagline: 'lets a child use a different style',
      paletteA: Color(0xFF7C2D12),
      paletteB: Color(0xFFF97316),
      tone: Color(0xFFC2410C),
      sample: <String>[
        'RenderParagraph',
        '│ text:',
        '│   TextSpan("Hello, ")',
        '│   ╘ TextSpan("world", style: bold)',
        '└── (transition into TextSpan tree)',
      ],
      uses: <String>[
        '`RenderParagraph` embedding `TextSpan`.',
        'Bridging widget tree into custom tree.',
        'Composing multiple diagnostic models.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.error,
      glyph: '✖',
      icon: Icons.error_outline,
      headline: 'Big red error banner',
      tagline: 'root style of FlutterError',
      paletteA: Color(0xFF7F1D1D),
      paletteB: Color(0xFFEF4444),
      tone: Color(0xFFB91C1C),
      sample: <String>[
        '══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞══',
        'The following assertion was thrown building Foo:',
        'A RenderFlex overflowed by 42 pixels.',
        'The relevant error-causing widget was: Column',
        '════════════════════════════════════════════',
      ],
      uses: <String>[
        'Top of any FlutterError dump.',
        'Surfacing assertion failures.',
        'Highlighting truly fatal contexts.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.whitespace,
      glyph: '␣',
      icon: Icons.space_bar,
      headline: 'No connecting lines',
      tagline: 'pure indentation',
      paletteA: Color(0xFF134E4A),
      paletteB: Color(0xFF14B8A6),
      tone: Color(0xFF0F766E),
      sample: <String>[
        'SliverGeometry',
        '  scrollExtent: 1200.0',
        '  paintExtent: 600.0',
        '  layoutExtent: 600.0',
        '  hasVisualOverflow: false',
      ],
      uses: <String>[
        'Geometry/value records.',
        'Configurations & numeric breakdowns.',
        'When line connectors would distract.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.flat,
      glyph: '═',
      icon: Icons.linear_scale,
      headline: 'No indentation at all',
      tagline: 'every child at column zero',
      paletteA: Color(0xFF1F2937),
      paletteB: Color(0xFF6B7280),
      tone: Color(0xFF374151),
      sample: <String>[
        'DiagnosticsStackTrace #0   main (file:///app/lib/main.dart:42:5)',
        '#1   _runMain (dart:ui/hooks.dart:130:23)',
        '#2   _delayEntrypointInvocation (dart:isolate-patch:300:19)',
        '#3   <asynchronous suspension>',
      ],
      uses: <String>[
        'Stack traces and frame lists.',
        'Single-column ledgers.',
        'When indentation would mislead.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.singleLine,
      glyph: '⟶',
      icon: Icons.short_text,
      headline: 'One line, no children',
      tagline: 'most properties default here',
      paletteA: Color(0xFF1E40AF),
      paletteB: Color(0xFF60A5FA),
      tone: Color(0xFF2563EB),
      sample: <String>[
        'padding: EdgeInsets.all(8.0)',
        'duration: 250ms',
        'curve: Curves.easeOutCubic',
        'visible: true',
      ],
      uses: <String>[
        'Almost every leaf `DiagnosticsProperty`.',
        'Inline values inside a parent dump.',
        'Compact one-property-per-line lists.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.errorProperty,
      glyph: '⚑',
      icon: Icons.flag_outlined,
      headline: 'Error context property',
      tagline: 'name on one line, body below',
      paletteA: Color(0xFF92400E),
      paletteB: Color(0xFFFBBF24),
      tone: Color(0xFFB45309),
      sample: <String>[
        'context:',
        '  building Builder',
        'library:',
        '  widgets library',
        'stack:',
        '  #0  main (file:///app/lib/main.dart:42:5)',
      ],
      uses: <String>[
        'Properties inside a FlutterError dump.',
        'Multi-line values that need a label.',
        'Stack & context blocks attached to errors.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.shallow,
      glyph: '⊙',
      icon: Icons.center_focus_weak,
      headline: 'Self only, no descend',
      tagline: 'immediate properties; ignore children',
      paletteA: Color(0xFF581C87),
      paletteB: Color(0xFFC084FC),
      tone: Color(0xFF7E22CE),
      sample: <String>[
        'RenderFlex (overflow=42px)',
        '│ direction: vertical',
        '│ size: Size(120.0, 80.0)',
        '│ (children intentionally omitted)',
      ],
      uses: <String>[
        '`DebugOverflowIndicatorMixin` summaries.',
        'When the subtree is huge or recursive.',
        'Debug overlays needing a one-shot snapshot.',
      ],
    ),
    _StyleSpec(
      style: DiagnosticsTreeStyle.truncateChildren,
      glyph: '✂',
      icon: Icons.content_cut,
      headline: 'First 5 children + ellipsis',
      tagline: 'caps verbose subtrees',
      paletteA: Color(0xFFB45309),
      paletteB: Color(0xFFFCD34D),
      tone: Color(0xFFD97706),
      sample: <String>[
        'RenderListBody (12 children)',
        '├ child 0: RenderTile',
        '├ child 1: RenderTile',
        '├ child 2: RenderTile',
        '├ child 3: RenderTile',
        '├ child 4: RenderTile',
        '└ … 7 more children',
      ],
      uses: <String>[
        'Long list-style children dumps.',
        'Limiting Console / DevTools spam.',
        'Keeping web logs scrollable.',
      ],
    ),
  ];

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final Widget hero = _HeroHeader(specs: specs);

  // ============================================================
  // SECTION 2: Anatomy of a debug tree
  // ============================================================
  final Widget anatomy = _AnatomySection();

  // ============================================================
  // SECTION 3: Per-value cards
  // ============================================================
  final Widget cards = _CardsSection(specs: specs, pulse: pulse);

  // ============================================================
  // SECTION 4: Recipes
  // ============================================================
  final Widget recipes = _RecipesSection();

  // ============================================================
  // SECTION 5: Pitfalls
  // ============================================================
  final Widget pitfalls = _PitfallsSection();

  // ============================================================
  // SECTION 6: Comparison table
  // ============================================================
  final Widget comparison = _ComparisonTable(specs: specs);

  // ============================================================
  // SECTION 7: Debugging workflows
  // ============================================================
  final Widget workflows = _WorkflowsSection(drift: drift, warp: warp);

  // ============================================================
  // SECTION 8: Quick reference
  // ============================================================
  final Widget quickRef = _QuickReference(specs: specs);

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  final Widget footer = _AsciiFooter(heartbeat: heartbeat);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hero,
            SizedBox(height: 32.0),
            _SectionTitle(
              index: 1,
              text: 'Anatomy of a debug tree',
              swatch: Color(0xFF2563EB),
            ),
            anatomy,
            SizedBox(height: 32.0),
            _SectionTitle(
              index: 2,
              text: 'All ${specs.length} DiagnosticsTreeStyle values',
              swatch: Color(0xFF7C3AED),
            ),
            cards,
            SizedBox(height: 32.0),
            _SectionTitle(
              index: 3,
              text: 'Style recipes',
              swatch: Color(0xFF10B981),
            ),
            recipes,
            SizedBox(height: 32.0),
            _SectionTitle(
              index: 4,
              text: 'Common pitfalls',
              swatch: Color(0xFFEF4444),
            ),
            pitfalls,
            SizedBox(height: 32.0),
            _SectionTitle(
              index: 5,
              text: 'Comparison matrix',
              swatch: Color(0xFFF97316),
            ),
            comparison,
            SizedBox(height: 32.0),
            _SectionTitle(
              index: 6,
              text: 'Debugging workflows',
              swatch: Color(0xFF14B8A6),
            ),
            workflows,
            SizedBox(height: 32.0),
            _SectionTitle(
              index: 7,
              text: 'Quick reference',
              swatch: Color(0xFFFBBF24),
            ),
            quickRef,
            SizedBox(height: 32.0),
            footer,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// MODELS
// ============================================================

class _StyleSpec {
  _StyleSpec({
    required this.style,
    required this.glyph,
    required this.icon,
    required this.headline,
    required this.tagline,
    required this.paletteA,
    required this.paletteB,
    required this.tone,
    required this.sample,
    required this.uses,
  });

  final DiagnosticsTreeStyle style;
  final String glyph;
  final IconData icon;
  final String headline;
  final String tagline;
  final Color paletteA;
  final Color paletteB;
  final Color tone;
  final List<String> sample;
  final List<String> uses;
}

// ============================================================
// HERO HEADER
// ============================================================

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.specs});

  final List<_StyleSpec> specs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF0F172A),
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF1E1B4B).withValues(alpha: 0.45),
            blurRadius: 28.0,
            offset: Offset(0.0, 14.0),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF22D3EE), Color(0xFF6366F1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFF22D3EE).withValues(alpha: 0.5),
                      blurRadius: 18.0,
                      offset: Offset(0.0, 6.0),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.account_tree,
                  color: Colors.white,
                  size: 36.0,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'DiagnosticsTreeStyle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'package:flutter/foundation.dart',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              _HeroBadge(count: specs.length),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            'How a DiagnosticsNode subtree renders to text. '
            'Every Flutter framework dump (`toStringDeep`, `debugDumpApp`, '
            '`debugDumpRenderTree`, `FlutterError`) picks one of these '
            'styles per node — they decide the connector glyphs, '
            'indentation, child handling, and overall vibe of the output.',
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 14.5,
              height: 1.55,
            ),
          ),
          SizedBox(height: 22.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              for (final _StyleSpec s in specs)
                _HeroChip(label: s.style.name, glyph: s.glyph, tone: s.tone),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFF472B6), Color(0xFFFB7185)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(999.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFFFB7185).withValues(alpha: 0.6),
            blurRadius: 14.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.tag, color: Colors.white, size: 16.0),
          SizedBox(width: 6.0),
          Text(
            '$count values',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({
    required this.label,
    required this.glyph,
    required this.tone,
  });

  final String label;
  final String glyph;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: tone.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            glyph,
            style: TextStyle(
              fontFamily: 'monospace',
              color: tone.withValues(alpha: 0.95),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION TITLE
// ============================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.index,
    required this.text,
    required this.swatch,
  });

  final int index;
  final String text;
  final Color swatch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  swatch,
                  Color.lerp(swatch, Colors.black, 0.35)!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: swatch.withValues(alpha: 0.45),
                  blurRadius: 12.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Text(
              '$index',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 1: ANATOMY
// ============================================================

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFEFF6FF), Color(0xFFE0E7FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Color(0xFFC7D2FE), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF6366F1).withValues(alpha: 0.12),
            blurRadius: 16.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Every node renders with three things:',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3A8A),
            ),
          ),
          SizedBox(height: 12.0),
          _anatomyRow(
            Icons.south_east,
            'Connector glyphs',
            'The lines or whitespace that link parents to children. '
                '`sparse` uses ╞ ╘, `whitespace` uses spaces, `flat` uses '
                'nothing at all.',
          ),
          _anatomyRow(
            Icons.format_indent_increase,
            'Indentation',
            'Per-style indentation rule. `flat` keeps everything at column '
                'zero; `dense` uses tighter steps than `sparse`.',
          ),
          _anatomyRow(
            Icons.account_tree_outlined,
            'Child policy',
            'How children are listed. `shallow` skips them, '
                '`truncateChildren` caps them at 5, `singleLine` puts them '
                'inline.',
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _codeLine(
                  '@override',
                  Color(0xFF94A3B8),
                ),
                _codeLine(
                  'void debugFillProperties(DiagnosticPropertiesBuilder p) {',
                  Color(0xFFE2E8F0),
                ),
                _codeLine(
                  '  super.debugFillProperties(p);',
                  Color(0xFFE2E8F0),
                ),
                _codeLine(
                  '  p.add(DiagnosticsProperty<int>(',
                  Color(0xFFE2E8F0),
                ),
                _codeLine(
                  "      'count', count,",
                  Color(0xFFFCD34D),
                ),
                _codeLine(
                  '      style: DiagnosticsTreeStyle.singleLine));',
                  Color(0xFF7DD3FC),
                ),
                _codeLine('}', Color(0xFFE2E8F0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _anatomyRow(IconData icon, String title, String body) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32.0,
            height: 32.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFC7D2FE),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: Color(0xFF1E3A8A), size: 18.0),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E3A8A),
                    fontSize: 13.5,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  body,
                  style: TextStyle(
                    color: Color(0xFF334155),
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

  Widget _codeLine(String text, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.0,
          color: color,
          height: 1.5,
        ),
      ),
    );
  }
}

// ============================================================
// SECTION 2: PER-VALUE CARDS
// ============================================================

class _CardsSection extends StatelessWidget {
  const _CardsSection({required this.specs, required this.pulse});

  final List<_StyleSpec> specs;
  final AlwaysStoppedAnimation<double> pulse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < specs.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 14.0),
            child: _StyleCard(spec: specs[i], index: i, fade: pulse),
          ),
      ],
    );
  }
}

class _StyleCard extends StatelessWidget {
  const _StyleCard({
    required this.spec,
    required this.index,
    required this.fade,
  });

  final _StyleSpec spec;
  final int index;
  final AlwaysStoppedAnimation<double> fade;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        gradient: LinearGradient(
          colors: <Color>[
            spec.paletteA.withValues(alpha: 0.96),
            spec.paletteB.withValues(alpha: 0.92),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: spec.tone.withValues(alpha: 0.45),
            blurRadius: 22.0,
            offset: Offset(0.0, 10.0),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 4.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardHeader(),
            SizedBox(height: 14.0),
            _cardSample(),
            SizedBox(height: 14.0),
            _cardUses(),
          ],
        ),
      ),
    );
  }

  Widget _cardHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.2,
            ),
          ),
          child: Text(
            spec.glyph,
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24.0,
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(999.0),
                    ),
                    child: Text(
                      '#${index.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(spec.icon, color: Colors.white, size: 18.0),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                'DiagnosticsTreeStyle.${spec.style.name}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                spec.headline,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                spec.tagline,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Opacity(
          opacity: fade.value,
          child: Container(
            width: 8.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardSample() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFF0B1220).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.terminal,
                color: Colors.white.withValues(alpha: 0.6),
                size: 14.0,
              ),
              SizedBox(width: 6.0),
              Text(
                'sample output',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 10.5,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          for (final String line in spec.sample)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Text(
                line,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Color(0xFF93C5FD),
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _cardUses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.lightbulb_outline,
              color: Colors.white.withValues(alpha: 0.85),
              size: 14.0,
            ),
            SizedBox(width: 6.0),
            Text(
              'When to use it',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        for (final String use in spec.uses)
          Padding(
            padding: EdgeInsets.only(bottom: 4.0, left: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '•',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    use,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ============================================================
// SECTION 3: RECIPES
// ============================================================

class _RecipesSection extends StatelessWidget {
  const _RecipesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _recipe(
          'Custom RenderObject (default look)',
          DiagnosticsTreeStyle.sparse,
          Color(0xFF1E40AF),
          Color(0xFF60A5FA),
          Icons.layers,
          <String>[
            'class RenderBadge extends RenderBox {',
            '  @override',
            '  void debugFillProperties(',
            '      DiagnosticPropertiesBuilder properties) {',
            '    super.debugFillProperties(properties);',
            '    properties.add(IntProperty(\'count\', count));',
            '    properties.add(DiagnosticsProperty<bool>(',
            '        \'pinned\', pinned,',
            '        style: DiagnosticsTreeStyle.singleLine));',
            '  }',
            '}',
          ],
          'RenderBox itself is `sparse`; per-property leaves are '
              '`singleLine`. Output uses ╞ ╘ connectors.',
        ),
        _recipe(
          'Truncate noisy children',
          DiagnosticsTreeStyle.truncateChildren,
          Color(0xFFB45309),
          Color(0xFFFCD34D),
          Icons.content_cut,
          <String>[
            'DiagnosticsBlock(',
            '    name: \'children\',',
            '    children: tiles',
            '        .map((Tile t) => t.toDiagnosticsNode())',
            '        .toList(),',
            '    style: DiagnosticsTreeStyle.truncateChildren,',
            ');',
          ],
          'Caps the printed children at 5 with "… N more" — perfect '
              'for verbose lists of identical tiles.',
        ),
        _recipe(
          'Self-only summary',
          DiagnosticsTreeStyle.shallow,
          Color(0xFF581C87),
          Color(0xFFC084FC),
          Icons.center_focus_weak,
          <String>[
            'DiagnosticsProperty<RenderBox>(',
            '    \'culprit\', overflowingChild,',
            '    style: DiagnosticsTreeStyle.shallow,',
            ');',
          ],
          'Prints the node name and immediate properties, hides '
              'descendants. Useful for overflow indicators.',
        ),
        _recipe(
          'Whitespace style for value bags',
          DiagnosticsTreeStyle.whitespace,
          Color(0xFF134E4A),
          Color(0xFF14B8A6),
          Icons.space_bar,
          <String>[
            'class SliverGeometry with Diagnosticable {',
            '  @override',
            '  void debugFillProperties(',
            '      DiagnosticPropertiesBuilder p) {',
            '    p.defaultDiagnosticsTreeStyle =',
            '        DiagnosticsTreeStyle.whitespace;',
            '    p.add(DoubleProperty(\'scrollExtent\', scrollExtent));',
            '    p.add(DoubleProperty(\'paintExtent\', paintExtent));',
            '  }',
            '}',
          ],
          '`whitespace` is great for record-like objects whose children '
              'are conceptual rather than hierarchical.',
        ),
      ],
    );
  }

  Widget _recipe(
    String title,
    DiagnosticsTreeStyle style,
    Color a,
    Color b,
    IconData icon,
    List<String> code,
    String note,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        border: Border.all(color: a.withValues(alpha: 0.25), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: a.withValues(alpha: 0.18),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[a, b],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(icon, color: Colors.white, size: 22.0),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        'style: DiagnosticsTreeStyle.${style.name}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFF111827),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final String line in code)
                    Text(
                      line,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Color(0xFFE5E7EB),
                        fontSize: 12.0,
                        height: 1.5,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline, color: a, size: 16.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    note,
                    style: TextStyle(
                      color: Color(0xFF334155),
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

// ============================================================
// SECTION 4: PITFALLS
// ============================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _pitfall(
          Icons.cancel_outlined,
          'Using `none` in debug builds',
          'Setting `style: DiagnosticsTreeStyle.none` makes the node '
              'effectively invisible. Useful for release, surprising in '
              'debug — devs spend ages wondering why their node never '
              'appears in `toStringDeep`.',
          Color(0xFFB91C1C),
          Color(0xFFFEE2E2),
        ),
        _pitfall(
          Icons.warning_amber_outlined,
          'Mixing `flat` with deep trees',
          'Stack-trace style with no indentation flattens parent/child '
              'relationships. If used on a real tree, every node looks '
              'like a sibling. Reserve `flat` for ledger-shaped output.',
          Color(0xFFB45309),
          Color(0xFFFEF3C7),
        ),
        _pitfall(
          Icons.crop_free,
          '`shallow` hides bugs you actually want',
          'When debugging an overflow, `shallow` may hide the offending '
              'descendant. Switch back to `sparse` once you have the '
              'overflow indicator pointing the right way.',
          Color(0xFF7C3AED),
          Color(0xFFEDE9FE),
        ),
        _pitfall(
          Icons.unfold_more,
          '`truncateChildren` cap is fixed',
          'The cap is implementation-defined (currently 5 children). '
              'Do not rely on the truncation count; if you need the full '
              'list, use `sparse` and live with the noise.',
          Color(0xFF0F766E),
          Color(0xFFCCFBF1),
        ),
        _pitfall(
          Icons.error_outline,
          '`error` outside of `FlutterError`',
          'The big banner style is meant for the *root* of error dumps. '
              'Using it for a non-error makes regular logs look like '
              'crashes — and confuses tooling that scrapes for it.',
          Color(0xFFB91C1C),
          Color(0xFFFEE2E2),
        ),
        _pitfall(
          Icons.swap_horiz,
          '`transition` is not a free conversion',
          'It only marks a boundary where the *child* picks a new style. '
              'The parent stays whatever it was. If both should change, '
              'set the style on each `DiagnosticsNode` explicitly.',
          Color(0xFFC2410C),
          Color(0xFFFFEDD5),
        ),
      ],
    );
  }

  Widget _pitfall(
    IconData icon,
    String title,
    String body,
    Color tone,
    Color tint,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(14.0),
        border: Border(
          left: BorderSide(color: tone, width: 4.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withValues(alpha: 0.15),
            blurRadius: 10.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: tone, size: 22.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: tone,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 12.5,
                    height: 1.5,
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

// ============================================================
// SECTION 5: COMPARISON TABLE
// ============================================================

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({required this.specs});

  final List<_StyleSpec> specs;

  @override
  Widget build(BuildContext context) {
    final List<_TableRow> rows = <_TableRow>[
      _TableRow('none', 'no glyphs', 'none', 'hidden', 'release'),
      _TableRow('sparse', '╞ ╘', 'standard', 'all listed', 'render trees'),
      _TableRow('offstage', '╎┄', 'standard', 'all listed', 'kept-alive'),
      _TableRow('dense', '├ │', 'tight', 'all listed', 'element trees'),
      _TableRow('transition', '╘═>', 'standard', 'children switch', 'paragraph'),
      _TableRow('error', '═══', 'banner', 'all listed', 'FlutterError'),
      _TableRow('whitespace', '"  "', 'standard', 'all listed', 'value bags'),
      _TableRow('flat', 'none', 'zero', 'flat list', 'stack traces'),
      _TableRow('singleLine', '⟶', 'inline', 'inline', 'leaves'),
      _TableRow('errorProperty', '⚑', 'split', 'multi-line', 'error props'),
      _TableRow('shallow', '⊙', 'standard', 'omitted', 'overflow'),
      _TableRow('truncateChildren', '✂', 'standard', 'first 5 + …', 'lists'),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF94A3B8).withValues(alpha: 0.25),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFF97316), Color(0xFFFB923C)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: <Widget>[
                  _hCell('style', 130.0),
                  _hCell('connectors', 90.0),
                  _hCell('indent', 80.0),
                  _hCell('children', 110.0),
                  _hCell('typical use', 110.0),
                ],
              ),
            ),
            for (int i = 0; i < rows.length; i++)
              Container(
                color: i.isEven ? Color(0xFFFFF7ED) : Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: <Widget>[
                    _dCell(rows[i].name, 130.0, bold: true, mono: true),
                    _dCell(rows[i].connector, 90.0, mono: true),
                    _dCell(rows[i].indent, 80.0),
                    _dCell(rows[i].child, 110.0),
                    _dCell(rows[i].use, 110.0, italic: true),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _hCell(String text, double w) {
    return SizedBox(
      width: w,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 12.0,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _dCell(
    String text,
    double w, {
    bool bold = false,
    bool italic = false,
    bool mono = false,
  }) {
    return SizedBox(
      width: w,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF1F2937),
          fontSize: 12.0,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          fontFamily: mono ? 'monospace' : null,
        ),
      ),
    );
  }
}

class _TableRow {
  _TableRow(this.name, this.connector, this.indent, this.child, this.use);

  final String name;
  final String connector;
  final String indent;
  final String child;
  final String use;
}

// ============================================================
// SECTION 6: WORKFLOWS
// ============================================================

class _WorkflowsSection extends StatelessWidget {
  const _WorkflowsSection({required this.drift, required this.warp});

  final AlwaysStoppedAnimation<double> drift;
  final AlwaysStoppedAnimation<double> warp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _flow(
          'Tracking down a layout overflow',
          <_FlowStep>[
            _FlowStep(
              'debugDumpRenderTree()',
              'sparse on RenderObjects',
              Color(0xFF2563EB),
            ),
            _FlowStep(
              'Find OverflowingFlex',
              'shallow under DebugOverflowIndicator',
              Color(0xFFA855F7),
            ),
            _FlowStep(
              'Inspect properties',
              'singleLine per leaf',
              Color(0xFF10B981),
            ),
            _FlowStep(
              'Fix Column → Flexible',
              'no more banner',
              Color(0xFFF59E0B),
            ),
          ],
          drift.value,
        ),
        SizedBox(height: 12.0),
        _flow(
          'Diagnosing a build-phase exception',
          <_FlowStep>[
            _FlowStep(
              'FlutterError caught',
              'error style root',
              Color(0xFFEF4444),
            ),
            _FlowStep(
              'Library / context',
              'errorProperty multi-line',
              Color(0xFFF97316),
            ),
            _FlowStep(
              'Stack trace',
              'flat (no indent)',
              Color(0xFF6B7280),
            ),
            _FlowStep(
              'Fault widget',
              'sparse subtree',
              Color(0xFF2563EB),
            ),
          ],
          warp.value,
        ),
        SizedBox(height: 12.0),
        _flow(
          'Trimming noisy DevTools logs',
          <_FlowStep>[
            _FlowStep(
              'List has 200 tiles',
              'sparse → wall of text',
              Color(0xFF94A3B8),
            ),
            _FlowStep(
              'Switch to truncateChildren',
              'first 5 + “… 195 more”',
              Color(0xFFF59E0B),
            ),
            _FlowStep(
              'Inspect culprit tile',
              'shallow snapshot',
              Color(0xFFA855F7),
            ),
            _FlowStep(
              'Re-run with sparse',
              'now selectively',
              Color(0xFF14B8A6),
            ),
          ],
          (drift.value + warp.value) / 2.0,
        ),
      ],
    );
  }

  Widget _flow(String title, List<_FlowStep> steps, double progress) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFECFEFF), Color(0xFFCFFAFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Color(0xFF67E8F9), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF06B6D4).withValues(alpha: 0.18),
            blurRadius: 14.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFF155E75),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 8.0,
            decoration: BoxDecoration(
              color: Color(0xFFCFFAFE),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF06B6D4),
                      Color(0xFF0EA5E9),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          for (int i = 0; i < steps.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 28.0,
                    height: 28.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          steps[i].tone,
                          Color.lerp(steps[i].tone, Colors.black, 0.25)!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: steps[i].tone.withValues(alpha: 0.45),
                          blurRadius: 6.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          steps[i].title,
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0,
                          ),
                        ),
                        Text(
                          steps[i].subtitle,
                          style: TextStyle(
                            color: Color(0xFF334155),
                            fontSize: 11.5,
                            fontFamily: 'monospace',
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

class _FlowStep {
  _FlowStep(this.title, this.subtitle, this.tone);

  final String title;
  final String subtitle;
  final Color tone;
}

// ============================================================
// SECTION 7: QUICK REFERENCE
// ============================================================

class _QuickReference extends StatelessWidget {
  const _QuickReference({required this.specs});

  final List<_StyleSpec> specs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFFEF3C7), Color(0xFFFDE68A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Color(0xFFF59E0B), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFFF59E0B).withValues(alpha: 0.25),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.bookmark, color: Color(0xFF92400E), size: 20.0),
              SizedBox(width: 8.0),
              Text(
                'Cheat sheet',
                style: TextStyle(
                  color: Color(0xFF92400E),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              for (final _StyleSpec s in specs)
                Container(
                  width: 168.0,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: s.tone.withValues(alpha: 0.5),
                      width: 1.2,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: s.tone.withValues(alpha: 0.18),
                        blurRadius: 6.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            s.glyph,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w800,
                              color: s.tone,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              s.style.name,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111827),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        s.tagline,
                        style: TextStyle(
                          color: Color(0xFF374151),
                          fontSize: 11.0,
                          height: 1.35,
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

// ============================================================
// SECTION 8: ASCII FOOTER
// ============================================================

class _AsciiFooter extends StatelessWidget {
  const _AsciiFooter({required this.heartbeat});

  final Duration heartbeat;

  @override
  Widget build(BuildContext context) {
    final List<String> ascii = <String>[
      '╔══════════════════════════════════════════════════════════╗',
      '║              DiagnosticsTreeStyle  cheat                ║',
      '╠══════════════════════════════════════════════════════════╣',
      '║   none           ∅   silent in release                  ║',
      '║   sparse         ┊   render trees, default              ║',
      '║   offstage       ⋯   kept-alive but not painted         ║',
      '║   dense          ▎   element trees, tight               ║',
      '║   transition     ⇿   parent → child style swap          ║',
      '║   error          ✖   FlutterError root                  ║',
      '║   whitespace     ␣   no connectors, just indent         ║',
      '║   flat           ═   stack traces, zero indent          ║',
      '║   singleLine     ⟶   inline leaves                      ║',
      '║   errorProperty  ⚑   labelled multi-line value          ║',
      '║   shallow        ⊙   self only                          ║',
      '║   truncateChildren ✂  first 5 + ellipsis                ║',
      '╚══════════════════════════════════════════════════════════╝',
    ];

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF22D3EE),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFF22D3EE).withValues(alpha: 0.7),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'static sample · heartbeat ${heartbeat.inMilliseconds}ms',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          for (final String line in ascii)
            Text(
              line,
              style: TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFE0F2FE),
                fontSize: 11.5,
                height: 1.3,
              ),
            ),
          SizedBox(height: 10.0),
          Text(
            'Generated by hand for the tom_d4rt_flutter_ast corpus.',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontStyle: FontStyle.italic,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}
