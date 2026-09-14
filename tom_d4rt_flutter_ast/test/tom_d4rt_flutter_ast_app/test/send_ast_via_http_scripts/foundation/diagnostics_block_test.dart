// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =============================================================================
// DiagnosticsBlock — Deep Visual Demo
// =============================================================================
//
// `DiagnosticsBlock` is a `DiagnosticsNode` subtype that groups multiple
// sub-`DiagnosticsNode`s under a single named header. Flutter uses these
// nodes to render Inspector trees and to format `FlutterError` messages in
// the console. A block can contain children (nested DiagnosticsNodes) and
// properties (typed values) and is rendered with a `DiagnosticsTreeStyle`.
//
// Constructor under study:
//
//     DiagnosticsBlock({
//       String name,
//       Object? value,
//       String linePrefix,
//       String? description,
//       DiagnosticLevel level,
//       bool showName,
//       bool showSeparator,
//       DiagnosticsTreeStyle style,
//       List<DiagnosticsNode> children,
//       List<DiagnosticsNode> properties,
//     })
//
// This file is a hand-written, analyzer-clean visual demo intended for the
// d4rt Flutter AST corpus. It focuses on the *shape* of DiagnosticsBlock
// and its sibling diagnostics node types, rendered with explanatory cards,
// console-style mock-ups, and a recipe section.
// =============================================================================

// -----------------------------------------------------------------------------
// Palette
// -----------------------------------------------------------------------------

const Color kPalettePrimary = Color(0xFF1565C0);
const Color kPaletteAccent = Color(0xFFEF6C00);
const Color kPaletteOk = Color(0xFF2E7D32);
const Color kPaletteWarn = Color(0xFFF9A825);
const Color kPaletteErr = Color(0xFFC62828);
const Color kPaletteInfo = Color(0xFF00838F);
const Color kPaletteMuted = Color(0xFF546E7A);
const Color kPaletteSurface = Color(0xFFF5F7FA);
const Color kPaletteCard = Color(0xFFFFFFFF);
const Color kPaletteOutline = Color(0xFFCFD8DC);
const Color kPaletteConsoleBg = Color(0xFF0F1115);
const Color kPaletteConsoleFg = Color(0xFFE0F2F1);
const Color kPaletteConsoleHi = Color(0xFFFFD54F);
const Color kPaletteConsoleErr = Color(0xFFFF8A80);

// -----------------------------------------------------------------------------
// Tiny data model used by the demo
// -----------------------------------------------------------------------------

class DiagFakeProperty {
  final String name;
  final String value;
  final String type;
  final String? description;

  const DiagFakeProperty({
    required this.name,
    required this.value,
    required this.type,
    this.description,
  });
}

class DiagFakeBlock {
  final String name;
  final List<DiagFakeProperty> properties;
  final List<DiagFakeBlock> children;
  final String style;

  const DiagFakeBlock({
    required this.name,
    this.properties = const [],
    this.children = const [],
    this.style = 'sparse',
  });
}

class DiagSibling {
  final String typeName;
  final String purpose;
  final String example;
  final IconData icon;
  final Color color;

  const DiagSibling({
    required this.typeName,
    required this.purpose,
    required this.example,
    required this.icon,
    required this.color,
  });
}

class DiagStyleEntry {
  final String name;
  final String summary;
  final String visualHint;
  final IconData icon;
  final Color color;

  const DiagStyleEntry({
    required this.name,
    required this.summary,
    required this.visualHint,
    required this.icon,
    required this.color,
  });
}

class DiagPitfall {
  final String title;
  final String body;
  final String recommendation;
  final IconData icon;
  final Color color;

  const DiagPitfall({
    required this.title,
    required this.body,
    required this.recommendation,
    required this.icon,
    required this.color,
  });
}

// -----------------------------------------------------------------------------
// Sample data — siblings of DiagnosticsBlock
// -----------------------------------------------------------------------------

const List<DiagSibling> kSiblings = [
  DiagSibling(
    typeName: 'DiagnosticsBlock',
    purpose:
        'Groups multiple DiagnosticsNodes under a header — used for nested '
        'sections in the Inspector and console output.',
    example: 'DiagnosticsBlock(name: "Layout", children: [...])',
    icon: Icons.view_module_outlined,
    color: kPalettePrimary,
  ),
  DiagSibling(
    typeName: 'DiagnosticsProperty<T>',
    purpose:
        'Typed property holding a single value with a name. Most numeric, '
        'bool, and string properties on widgets use this.',
    example: 'DiagnosticsProperty<double>("width", 200.0)',
    icon: Icons.label_outline,
    color: kPaletteInfo,
  ),
  DiagSibling(
    typeName: 'MessageProperty',
    purpose:
        'Free-form name + message string. Useful when there is no structured '
        'value, only a hand-written description.',
    example: 'MessageProperty("status", "ready to paint")',
    icon: Icons.message_outlined,
    color: kPaletteAccent,
  ),
  DiagSibling(
    typeName: 'ErrorDescription',
    purpose:
        'Long-form description of an error. Renders as a paragraph in the '
        'console error block.',
    example: 'ErrorDescription("The build method threw an exception.")',
    icon: Icons.subject,
    color: kPaletteErr,
  ),
  DiagSibling(
    typeName: 'ErrorSummary',
    purpose:
        'A single short headline for an error. Always appears at the top of '
        'a FlutterError in the console.',
    example: 'ErrorSummary("RenderFlex overflowed by 12 pixels.")',
    icon: Icons.priority_high,
    color: kPaletteWarn,
  ),
  DiagSibling(
    typeName: 'ErrorHint',
    purpose:
        'Suggestion or remediation text. Used after the description to '
        'tell the developer what to do.',
    example: 'ErrorHint("Wrap the widget in an Expanded.")',
    icon: Icons.tips_and_updates_outlined,
    color: kPaletteOk,
  ),
  DiagSibling(
    typeName: 'DiagnosticsStackTrace',
    purpose:
        'A captured StackTrace rendered as a compact list of frames inside '
        'a diagnostics tree.',
    example: 'DiagnosticsStackTrace("when the exception was thrown", st)',
    icon: Icons.layers_outlined,
    color: kPaletteMuted,
  ),
];

// -----------------------------------------------------------------------------
// Sample data — DiagnosticsTreeStyle entries
// -----------------------------------------------------------------------------

const List<DiagStyleEntry> kStyleEntries = [
  DiagStyleEntry(
    name: 'sparse',
    summary:
        'Default style. Keeps a blank line between siblings and indents '
        'children. Friendly for human reading.',
    visualHint: '   Block                      \n     a: 1                   \n     b: 2                   ',
    icon: Icons.view_agenda_outlined,
    color: kPalettePrimary,
  ),
  DiagStyleEntry(
    name: 'dense',
    summary:
        'Compact style without blank lines. Good when many properties are '
        'shown together.',
    visualHint: 'Block\n  a:1 b:2 c:3',
    icon: Icons.compress,
    color: kPaletteInfo,
  ),
  DiagStyleEntry(
    name: 'transition',
    summary:
        'Renders a visual jump between two trees, e.g., for animated '
        'inspector transitions.',
    visualHint: 'Old ──> New',
    icon: Icons.compare_arrows,
    color: kPaletteAccent,
  ),
  DiagStyleEntry(
    name: 'errorProperty',
    summary:
        'Used for error properties — emphasises the property and renders '
        'the parent error block prominently.',
    visualHint: '╳ Block ╳\n  cause: …',
    icon: Icons.error_outline,
    color: kPaletteErr,
  ),
  DiagStyleEntry(
    name: 'whitespace',
    summary:
        'Pure whitespace separator — drops bullets and connectors, just '
        'indents children.',
    visualHint: '  Block\n    a\n    b',
    icon: Icons.space_bar,
    color: kPaletteMuted,
  ),
  DiagStyleEntry(
    name: 'flat',
    summary:
        'Renders all entries on a single line of text, separated by '
        'commas. Useful for tooltips.',
    visualHint: 'Block(a:1, b:2)',
    icon: Icons.horizontal_rule,
    color: kPaletteOk,
  ),
  DiagStyleEntry(
    name: 'singleLine',
    summary:
        'Variant of flat used by short summaries; never wraps to a second '
        'line.',
    visualHint: 'Block(a:1,b:2)',
    icon: Icons.short_text,
    color: kPaletteWarn,
  ),
  DiagStyleEntry(
    name: 'headerLine',
    summary:
        'Used by FlutterError to render the headline; bold, uppercase '
        'separators above and below.',
    visualHint: '═══ Block ═══',
    icon: Icons.format_align_center,
    color: kPaletteAccent,
  ),
  DiagStyleEntry(
    name: 'truncateChildren',
    summary:
        'Hides children past a threshold. Renders an ellipsis to indicate '
        'truncation.',
    visualHint: 'Block\n  a\n  b\n  …',
    icon: Icons.more_horiz,
    color: kPaletteInfo,
  ),
  DiagStyleEntry(
    name: 'shallow',
    summary:
        'Shows only direct children, not deeper grandchildren. Avoids '
        'huge inspector dumps.',
    visualHint: 'Block\n  Child*',
    icon: Icons.layers_clear_outlined,
    color: kPaletteMuted,
  ),
];

// -----------------------------------------------------------------------------
// Sample data — pitfalls
// -----------------------------------------------------------------------------

const List<DiagPitfall> kPitfalls = [
  DiagPitfall(
    title: 'Do not pass null to children',
    body:
        'DiagnosticsBlock requires a non-null List<DiagnosticsNode> for '
        'children. Passing null leads to runtime assertions in debug mode.',
    recommendation: 'Use const <DiagnosticsNode>[] or build the list lazily.',
    icon: Icons.do_not_disturb_alt,
    color: kPaletteErr,
  ),
  DiagPitfall(
    title: 'Avoid filtering hidden nodes manually',
    body:
        'DiagnosticsNode has a level (info, hidden, fine, debug, warning, '
        'hint, error). Renderers already drop hidden nodes — filtering '
        'manually duplicates the work and can hide useful debug data.',
    recommendation: 'Set the level on each child instead of pre-filtering.',
    icon: Icons.filter_alt_off,
    color: kPaletteWarn,
  ),
  DiagPitfall(
    title: 'Mind the showName flag',
    body:
        'When a block is unnamed and showName is true, output looks empty. '
        'Either supply a name or set showName: false explicitly.',
    recommendation: 'Pass `showName: false` for anonymous wrapping blocks.',
    icon: Icons.visibility_off_outlined,
    color: kPaletteInfo,
  ),
  DiagPitfall(
    title: 'Choose a style that matches the consumer',
    body:
        'Inspector renders styles differently from console output. The '
        'flat style works in tooltips; sparse and dense are best for trees.',
    recommendation: 'Pass `style:` only when default sparse is unsuitable.',
    icon: Icons.style_outlined,
    color: kPaletteAccent,
  ),
  DiagPitfall(
    title: 'Block diagnostics are pure data',
    body:
        'A DiagnosticsBlock has no widget identity and does not own state. '
        'Rebuilding does not allocate widgets, only descriptive nodes.',
    recommendation: 'Construct fresh blocks inside debugFillProperties calls.',
    icon: Icons.functions,
    color: kPaletteMuted,
  ),
  DiagPitfall(
    title: 'Do not misuse blocks as transport',
    body:
        'DiagnosticsBlock is for *describing* a value, not for *carrying* '
        'business data. Treat it as a debug projection only.',
    recommendation: 'Keep your domain model separate from its diagnostics.',
    icon: Icons.swap_horizontal_circle_outlined,
    color: kPaletteOk,
  ),
];

// -----------------------------------------------------------------------------
// Build entry — single static dynamic build(BuildContext) function
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'DiagnosticsBlock — Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: kPalettePrimary,
      scaffoldBackgroundColor: kPaletteSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: kPalettePrimary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DiagnosticsBlock — Deep Demo'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(child: Text('foundation.dart')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHero(),
            const SizedBox(height: 24),
            buildAnatomySection(),
            const SizedBox(height: 24),
            buildSiblingGallery(),
            const SizedBox(height: 24),
            buildWorkedExamplesSection(),
            const SizedBox(height: 24),
            buildStylePanel(),
            const SizedBox(height: 24),
            buildFlutterErrorIntegrationSection(),
            const SizedBox(height: 24),
            buildInspectorDiagram(),
            const SizedBox(height: 24),
            buildRecipeSection(),
            const SizedBox(height: 24),
            buildPitfallsSection(),
            const SizedBox(height: 24),
            buildFooter(),
          ],
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section: Hero
// -----------------------------------------------------------------------------

Widget buildHero() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          kPalettePrimary,
          kPalettePrimary.withValues(alpha: 0.85),
          kPaletteInfo,
        ],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: kPalettePrimary.withValues(alpha: 0.25),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DiagnosticsBlock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A named group of DiagnosticsNodes — used by the Flutter '
                'Inspector and FlutterError to format trees of debug '
                'information for humans.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  buildHeroChip('package:flutter/foundation.dart'),
                  buildHeroChip('extends DiagnosticsNode'),
                  buildHeroChip('groups children'),
                  buildHeroChip('renders to console'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: buildHeroBlockGraphic(),
        ),
      ],
    ),
  );
}

Widget buildHeroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(40),
      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget buildHeroBlockGraphic() {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_tree_outlined,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              'RenderFlex#abc123',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.95),
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(child: buildHeroBlockGraphicChildren()),
      ],
    ),
  );
}

Widget buildHeroBlockGraphicChildren() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      _HeroBlockLine(prefix: '├─', text: 'creator: Column ← Padding'),
      _HeroBlockLine(prefix: '├─', text: 'parentData: <none>'),
      _HeroBlockLine(prefix: '├─', text: 'constraints: BoxConstraints(...)'),
      _HeroBlockLine(prefix: '├─', text: 'size: Size(360.0, 80.0)'),
      _HeroBlockLine(prefix: '├─', text: 'direction: vertical'),
      _HeroBlockLine(prefix: '└─', text: 'mainAxisAlignment: start'),
    ],
  );
}

class _HeroBlockLine extends StatelessWidget {
  final String prefix;
  final String text;
  const _HeroBlockLine({required this.prefix, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Text(
            prefix,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section: Anatomy of DiagnosticsBlock(name:, children:, properties:, style:)
// -----------------------------------------------------------------------------

Widget buildAnatomySection() {
  return buildCardShell(
    title: 'Anatomy of the constructor',
    subtitle:
        'DiagnosticsBlock has many parameters — these four shape the bulk '
        'of its output.',
    icon: Icons.architecture,
    color: kPalettePrimary,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAnatomyRow(
          'name',
          'String',
          'Header text shown at the top of the block. Drives the title '
              'rendered in the Inspector and console.',
          Icons.title,
          kPalettePrimary,
        ),
        buildAnatomyRow(
          'children',
          'List<DiagnosticsNode>',
          'Nested diagnostic nodes that appear indented under the header. '
              'These can be other blocks, properties, or messages.',
          Icons.account_tree_outlined,
          kPaletteAccent,
        ),
        buildAnatomyRow(
          'properties',
          'List<DiagnosticsNode>',
          'Inline properties of the block. Rendered before children and '
              'usually contain DiagnosticsProperty<T> entries.',
          Icons.list_alt,
          kPaletteInfo,
        ),
        buildAnatomyRow(
          'style',
          'DiagnosticsTreeStyle',
          'Visual layout used when rendering. Examples: sparse, dense, '
              'transition, errorProperty.',
          Icons.style_outlined,
          kPaletteOk,
        ),
        const SizedBox(height: 16),
        buildAnatomyConstructorBlock(),
      ],
    ),
  );
}

Widget buildAnatomyRow(
  String name,
  String type,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAnatomyConstructorBlock() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaletteConsoleBg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      'DiagnosticsBlock(\n'
      '  name: \'Layout\',\n'
      '  style: DiagnosticsTreeStyle.sparse,\n'
      '  properties: <DiagnosticsNode>[\n'
      '    DiagnosticsProperty<double>(\'width\', 200.0),\n'
      '    DiagnosticsProperty<double>(\'height\', 100.0),\n'
      '    MessageProperty(\'alignment\', \'center\'),\n'
      '  ],\n'
      '  children: <DiagnosticsNode>[\n'
      '    DiagnosticsBlock(name: \'Padding\', properties: [...]),\n'
      '  ],\n'
      ')',
      style: TextStyle(
        fontFamily: 'monospace',
        color: kPaletteConsoleFg,
        fontSize: 12,
        height: 1.45,
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section: Sibling-node gallery
// -----------------------------------------------------------------------------

Widget buildSiblingGallery() {
  return buildCardShell(
    title: 'Sibling diagnostic node types',
    subtitle:
        'DiagnosticsBlock lives among many other DiagnosticsNode subtypes. '
        'Each has a specific role.',
    icon: Icons.diversity_3,
    color: kPaletteAccent,
    child: Column(
      children: kSiblings.map((s) => buildSiblingCard(s)).toList(),
    ),
  );
}

Widget buildSiblingCard(DiagSibling s) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kPaletteCard,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: s.color.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: s.color.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: s.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(s.icon, color: s.color, size: 26),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.typeName,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: s.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(s.purpose, style: const TextStyle(fontSize: 13, height: 1.4)),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPaletteConsoleBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  s.example,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: kPaletteConsoleFg,
                    fontSize: 12,
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

// -----------------------------------------------------------------------------
// Section: Worked examples — four blocks rendered as console output
// -----------------------------------------------------------------------------

Widget buildWorkedExamplesSection() {
  return buildCardShell(
    title: 'Worked examples',
    subtitle:
        'Each example constructs a DiagnosticsBlock with properties and '
        'children, then shows what its `.toString()` would render.',
    icon: Icons.science_outlined,
    color: kPaletteInfo,
    child: Column(
      children: [
        buildWorkedExample(buildLayoutBlock()),
        const SizedBox(height: 12),
        buildWorkedExample(buildPaintingBlock()),
        const SizedBox(height: 12),
        buildWorkedExample(buildAnimationBlock()),
        const SizedBox(height: 12),
        buildWorkedExample(buildErrorBlock()),
      ],
    ),
  );
}

DiagFakeBlock buildLayoutBlock() {
  return const DiagFakeBlock(
    name: 'Layout',
    properties: [
      DiagFakeProperty(name: 'width', value: '200.0', type: 'double'),
      DiagFakeProperty(name: 'height', value: '100.0', type: 'double'),
      DiagFakeProperty(name: 'alignment', value: 'center', type: 'Alignment'),
      DiagFakeProperty(name: 'fit', value: 'BoxFit.cover', type: 'BoxFit'),
      DiagFakeProperty(name: 'clip', value: 'Clip.hardEdge', type: 'Clip'),
    ],
    children: [
      DiagFakeBlock(
        name: 'Padding',
        properties: [
          DiagFakeProperty(name: 'top', value: '8.0', type: 'double'),
          DiagFakeProperty(name: 'right', value: '12.0', type: 'double'),
          DiagFakeProperty(name: 'bottom', value: '8.0', type: 'double'),
          DiagFakeProperty(name: 'left', value: '12.0', type: 'double'),
        ],
      ),
      DiagFakeBlock(
        name: 'Margin',
        properties: [
          DiagFakeProperty(name: 'top', value: '0.0', type: 'double'),
          DiagFakeProperty(name: 'horizontal', value: '16.0', type: 'double'),
        ],
      ),
    ],
  );
}

DiagFakeBlock buildPaintingBlock() {
  return const DiagFakeBlock(
    name: 'Painting',
    style: 'dense',
    properties: [
      DiagFakeProperty(name: 'color', value: 'Color(0xff1565c0)', type: 'Color'),
      DiagFakeProperty(name: 'opacity', value: '0.92', type: 'double'),
      DiagFakeProperty(
        name: 'borderRadius',
        value: 'BorderRadius.all(Radius.circular(8.0))',
        type: 'BorderRadius',
      ),
      DiagFakeProperty(
        name: 'shadow',
        value: 'BoxShadow(blur: 4, dy: 2)',
        type: 'BoxShadow',
      ),
    ],
    children: [
      DiagFakeBlock(
        name: 'Gradient',
        properties: [
          DiagFakeProperty(name: 'kind', value: 'linear', type: 'String'),
          DiagFakeProperty(
            name: 'colors',
            value: '[blue, cyan, white]',
            type: 'List<Color>',
          ),
          DiagFakeProperty(
            name: 'stops',
            value: '[0.0, 0.6, 1.0]',
            type: 'List<double>',
          ),
        ],
      ),
    ],
  );
}

DiagFakeBlock buildAnimationBlock() {
  return const DiagFakeBlock(
    name: 'Animation',
    properties: [
      DiagFakeProperty(name: 'controller', value: 'AnimationController#a4b', type: 'AnimationController'),
      DiagFakeProperty(name: 'duration', value: '320ms', type: 'Duration'),
      DiagFakeProperty(name: 'curve', value: 'Curves.easeInOut', type: 'Curve'),
      DiagFakeProperty(name: 'reverseCurve', value: 'Curves.easeOut', type: 'Curve'),
    ],
    children: [
      DiagFakeBlock(
        name: 'Listeners',
        properties: [
          DiagFakeProperty(name: 'count', value: '3', type: 'int'),
        ],
      ),
      DiagFakeBlock(
        name: 'StatusListeners',
        properties: [
          DiagFakeProperty(name: 'count', value: '2', type: 'int'),
        ],
      ),
    ],
  );
}

DiagFakeBlock buildErrorBlock() {
  return const DiagFakeBlock(
    name: 'Error context',
    style: 'errorProperty',
    properties: [
      DiagFakeProperty(
        name: 'summary',
        value: 'RenderFlex overflowed by 16.5 pixels on the right.',
        type: 'ErrorSummary',
      ),
      DiagFakeProperty(
        name: 'description',
        value:
            'A child has produced a layout larger than the available space.',
        type: 'ErrorDescription',
      ),
      DiagFakeProperty(
        name: 'hint',
        value:
            'Wrap the offending widget in an Expanded or Flexible.',
        type: 'ErrorHint',
      ),
    ],
    children: [
      DiagFakeBlock(
        name: 'Stack frames',
        properties: [
          DiagFakeProperty(name: 'frame[0]', value: 'RenderFlex.performLayout', type: 'String'),
          DiagFakeProperty(name: 'frame[1]', value: 'RenderObject.layout', type: 'String'),
          DiagFakeProperty(name: 'frame[2]', value: 'PipelineOwner.flushLayout', type: 'String'),
        ],
      ),
    ],
  );
}

Widget buildWorkedExample(DiagFakeBlock block) {
  return Container(
    decoration: BoxDecoration(
      color: kPaletteCard,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kPaletteOutline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: kPaletteSurface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.terminal,
                size: 16,
                color: kPaletteMuted,
              ),
              const SizedBox(width: 6),
              Text(
                'DiagnosticsBlock(name: ${quote(block.name)}, style: ${block.style})',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: kPaletteMuted,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: kPaletteConsoleBg,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(9)),
          ),
          child: Text(
            renderFakeBlock(block),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: kPaletteConsoleFg,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// Render a DiagFakeBlock to a multi-line string mimicking
// `DiagnosticsBlock.toString(minLevel: ..., wrapWidth: 80)` output.
String renderFakeBlock(DiagFakeBlock block) {
  final StringBuffer buffer = StringBuffer();
  appendFakeBlock(buffer, block, '');
  return buffer.toString();
}

void appendFakeBlock(StringBuffer buffer, DiagFakeBlock block, String indent) {
  buffer.writeln('${indent}${block.name}');
  final String childIndent = '$indent  ';
  for (int i = 0; i < block.properties.length; i++) {
    final DiagFakeProperty p = block.properties[i];
    buffer.writeln('$childIndent├─ ${p.name}: ${p.value}');
  }
  for (int i = 0; i < block.children.length; i++) {
    final bool isLast = i == block.children.length - 1;
    final String connector = isLast ? '└─ ' : '├─ ';
    final String continuation = isLast ? '   ' : '│  ';
    final DiagFakeBlock c = block.children[i];
    buffer.writeln('$childIndent$connector${c.name}');
    final String deeperIndent = '$childIndent$continuation  ';
    for (int j = 0; j < c.properties.length; j++) {
      final DiagFakeProperty p = c.properties[j];
      buffer.writeln('$deeperIndent├─ ${p.name}: ${p.value}');
    }
    for (int j = 0; j < c.children.length; j++) {
      appendFakeBlock(buffer, c.children[j], deeperIndent);
    }
  }
}

String quote(String s) {
  return '\'$s\'';
}

// -----------------------------------------------------------------------------
// Section: DiagnosticsTreeStyle panel
// -----------------------------------------------------------------------------

Widget buildStylePanel() {
  return buildCardShell(
    title: 'DiagnosticsTreeStyle',
    subtitle:
        'A style controls how a block is rendered. Different consumers '
        '(Inspector, console, tooltips) prefer different styles.',
    icon: Icons.style_outlined,
    color: kPaletteOk,
    child: Column(
      children: [
        ...kStyleEntries.map(buildStyleRow),
        const SizedBox(height: 12),
        buildStyleAppliedExample(),
      ],
    ),
  );
}

Widget buildStyleRow(DiagStyleEntry entry) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: entry.color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: entry.color.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: entry.color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(entry.icon, color: entry.color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: entry.color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                entry.summary,
                style: const TextStyle(fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: kPaletteConsoleBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              entry.visualHint,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: kPaletteConsoleFg,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildStyleAppliedExample() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaletteSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kPaletteOutline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Same block, three styles:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 8),
        const Text(
          'block = DiagnosticsBlock(name: "Box", properties: [a:1, b:2], '
          'children: [Inner(c:3)])',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
        const SizedBox(height: 12),
        buildStyleSnippet('sparse', 'Box\n  ├─ a: 1\n  ├─ b: 2\n  └─ Inner\n        └─ c: 3'),
        const SizedBox(height: 8),
        buildStyleSnippet('dense', 'Box\n  ├─a:1 ├─b:2 └─Inner(c:3)'),
        const SizedBox(height: 8),
        buildStyleSnippet('errorProperty', '╳ Box ╳\n  ├─ a: 1\n  ├─ b: 2\n  └─ Inner\n        └─ c: 3'),
      ],
    ),
  );
}

Widget buildStyleSnippet(String label, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 90,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: kPalettePrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: kPalettePrimary,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kPaletteConsoleBg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: kPaletteConsoleFg,
              height: 1.5,
            ),
          ),
        ),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Section: Integration with FlutterError
// -----------------------------------------------------------------------------

Widget buildFlutterErrorIntegrationSection() {
  return buildCardShell(
    title: 'FlutterError integration',
    subtitle:
        'FlutterError uses a tree of DiagnosticsNodes — including '
        'DiagnosticsBlock — to render console output.',
    icon: Icons.error_outline,
    color: kPaletteErr,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'A FlutterErrorDetails carries a list of "context" nodes that are '
          'flattened into the formatted error message. Many of those '
          'nodes are DiagnosticsBlocks.',
          style: TextStyle(fontSize: 13, height: 1.45),
        ),
        const SizedBox(height: 12),
        buildFlutterErrorMockConsole(),
        const SizedBox(height: 12),
        const Text(
          'Order in console output:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 6),
        ...const [
          'ErrorSummary  — single short headline',
          'ErrorDescription — one or more paragraphs',
          'ErrorHint — actionable suggestions',
          'DiagnosticsBlock(name: "context") — the diagnostic tree',
          'DiagnosticsStackTrace — frames where it was thrown',
        ].map(buildOrderedBullet),
      ],
    ),
  );
}

Widget buildOrderedBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.adjust, size: 12, color: kPaletteErr),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 13)),
        ),
      ],
    ),
  );
}

Widget buildFlutterErrorMockConsole() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaletteConsoleBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kPaletteErr.withValues(alpha: 0.4)),
    ),
    child: const Text(
      '════════ Exception caught by widgets library ════════\n'
      'The following assertion was thrown building MyWidget(dirty):\n'
      '\n'
      'A RenderFlex overflowed by 16.5 pixels on the right.\n'
      '\n'
      'The relevant error-causing widget was:\n'
      '  Row file:///lib/screen.dart:42:14\n'
      '\n'
      'When the exception was thrown, this was the stack:\n'
      '#0   RenderFlex.performLayout (flex.dart:880:7)\n'
      '#1   RenderObject.layout (object.dart:1932:7)\n'
      '#2   PipelineOwner.flushLayout (binding.dart:413:11)\n'
      '\n'
      'Diagnostics:\n'
      '  Layout\n'
      '    ├─ width: 200.0\n'
      '    ├─ height: 100.0\n'
      '    └─ alignment: center\n'
      '\n'
      '════════════════════════════════════════════════════\n',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: kPaletteConsoleErr,
        height: 1.5,
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section: Inspector diagram
// -----------------------------------------------------------------------------

Widget buildInspectorDiagram() {
  return buildCardShell(
    title: 'How the Flutter Inspector uses DiagnosticsNodes',
    subtitle:
        'The Inspector serialises DiagnosticsNodes over the VM service. '
        'Blocks become collapsible sections in the UI.',
    icon: Icons.bubble_chart,
    color: kPaletteAccent,
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: buildInspectorBox(
              title: 'Flutter App',
              subtitle: 'debugFillProperties → DiagnosticsNode tree',
              icon: Icons.phone_android,
              color: kPaletteOk,
            )),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward, color: kPaletteMuted),
            const SizedBox(width: 12),
            Expanded(child: buildInspectorBox(
              title: 'VM Service',
              subtitle: 'Serialised JSON of nodes + metadata',
              icon: Icons.cloud_sync,
              color: kPaletteInfo,
            )),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward, color: kPaletteMuted),
            const SizedBox(width: 12),
            Expanded(child: buildInspectorBox(
              title: 'DevTools',
              subtitle: 'Renders blocks as collapsible UI',
              icon: Icons.developer_board,
              color: kPaletteAccent,
            )),
          ],
        ),
        const SizedBox(height: 16),
        buildInspectorSerializationExample(),
      ],
    ),
  );
}

Widget buildInspectorBox({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
}) {
  return Container(
    height: 100,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 10, color: kPaletteMuted),
        ),
      ],
    ),
  );
}

Widget buildInspectorSerializationExample() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kPaletteConsoleBg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      '{\n'
      '  "type": "DiagnosticsBlock",\n'
      '  "name": "Layout",\n'
      '  "style": "sparse",\n'
      '  "properties": [\n'
      '    {"type": "DiagnosticsProperty<double>", "name": "width", "value": 200.0},\n'
      '    {"type": "DiagnosticsProperty<double>", "name": "height", "value": 100.0}\n'
      '  ],\n'
      '  "children": []\n'
      '}',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: kPaletteConsoleFg,
        height: 1.5,
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section: Recipe — adding a custom DiagnosticsBlock to debugFillProperties
// -----------------------------------------------------------------------------

Widget buildRecipeSection() {
  return buildCardShell(
    title: 'Recipe — custom DiagnosticsBlock in debugFillProperties',
    subtitle:
        'When your widget has many related properties, group them into a '
        'DiagnosticsBlock to reduce noise.',
    icon: Icons.restaurant_menu,
    color: kPaletteOk,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRecipeStep(
          1,
          'Override debugFillProperties',
          'Subclass any DiagnosticableTree (Widget, RenderObject, ChangeNotifier) '
              'and override debugFillProperties.',
        ),
        buildRecipeStep(
          2,
          'Add primary properties first',
          'Use properties.add(DiagnosticsProperty<T>(...)) for the most '
              'important values directly on the widget.',
        ),
        buildRecipeStep(
          3,
          'Group related values inside a block',
          'Build a DiagnosticsBlock with name and a list of children — for '
              'example all painting-related properties.',
        ),
        buildRecipeStep(
          4,
          'Add the block as a property',
          'Call properties.add(myBlock). The Inspector will render it as a '
              'collapsible section.',
        ),
        const SizedBox(height: 12),
        buildRecipeListing(),
      ],
    ),
  );
}

Widget buildRecipeStep(int n, String title, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kPaletteOk.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kPaletteOk.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: kPaletteOk,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$n',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(body, style: const TextStyle(fontSize: 12, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildRecipeListing() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaletteConsoleBg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      '@override\n'
      'void debugFillProperties(DiagnosticPropertiesBuilder properties) {\n'
      '  super.debugFillProperties(properties);\n'
      '  properties.add(DiagnosticsProperty<double>(\'width\', width));\n'
      '  properties.add(DiagnosticsProperty<double>(\'height\', height));\n'
      '\n'
      '  final DiagnosticsBlock paintingBlock = DiagnosticsBlock(\n'
      '    name: \'painting\',\n'
      '    style: DiagnosticsTreeStyle.sparse,\n'
      '    properties: <DiagnosticsNode>[\n'
      '      DiagnosticsProperty<Color>(\'color\', color),\n'
      '      DiagnosticsProperty<double>(\'opacity\', opacity),\n'
      '      MessageProperty(\'shader\', shader == null ? \'none\' : \'custom\'),\n'
      '    ],\n'
      '  );\n'
      '  properties.add(paintingBlock);\n'
      '}',
      style: TextStyle(
        fontFamily: 'monospace',
        color: kPaletteConsoleFg,
        fontSize: 12,
        height: 1.5,
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section: Pitfalls
// -----------------------------------------------------------------------------

Widget buildPitfallsSection() {
  return buildCardShell(
    title: 'Pitfalls and best practices',
    subtitle:
        'A short list of mistakes that come up when authoring or consuming '
        'DiagnosticsBlock instances.',
    icon: Icons.report_problem_outlined,
    color: kPaletteWarn,
    child: Column(
      children: kPitfalls.map(buildPitfallRow).toList(),
    ),
  );
}

Widget buildPitfallRow(DiagPitfall p) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: p.color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: p.color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: p.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(p.icon, color: p.color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: p.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(p.body, style: const TextStyle(fontSize: 13, height: 1.4)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: p.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 14, color: p.color),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        p.recommendation,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: p.color,
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

// -----------------------------------------------------------------------------
// Section: Footer
// -----------------------------------------------------------------------------

Widget buildFooter() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: kPaletteCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kPaletteOutline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.bookmark_outline, color: kPalettePrimary),
            SizedBox(width: 8),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kPalettePrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'DiagnosticsBlock is the structural workhorse of Flutter\'s '
          'diagnostics system. It groups related DiagnosticsNodes under a '
          'header and lets the Inspector and FlutterError render coherent, '
          'human-readable trees. Compose it with DiagnosticsProperty<T>, '
          'MessageProperty, ErrorDescription, ErrorSummary, ErrorHint, and '
          'DiagnosticsStackTrace to surface debug information without '
          'overwhelming the reader.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _FooterBadge(label: 'foundation', color: kPalettePrimary),
            _FooterBadge(label: 'diagnostics', color: kPaletteAccent),
            _FooterBadge(label: 'inspector', color: kPaletteInfo),
            _FooterBadge(label: 'tree-style', color: kPaletteOk),
            _FooterBadge(label: 'devtools', color: kPaletteMuted),
          ],
        ),
      ],
    ),
  );
}

class _FooterBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _FooterBadge({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Card shell — reusable section wrapper
// -----------------------------------------------------------------------------

Widget buildCardShell({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: kPaletteCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: kPaletteMuted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(height: 1, color: kPaletteOutline),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// Lightweight smoke test — exercises the foundation library once at parse
// time. The constant is referenced from a const list so it cannot be
// tree-shaken away in test builds.
// -----------------------------------------------------------------------------

const DiagnosticLevel kReferencedDiagnosticLevel = DiagnosticLevel.info;
const DiagnosticsTreeStyle kReferencedDiagnosticsTreeStyle =
    DiagnosticsTreeStyle.sparse;
const List<Object> kFoundationReferences = <Object>[
  kReferencedDiagnosticLevel,
  kReferencedDiagnosticsTreeStyle,
];
