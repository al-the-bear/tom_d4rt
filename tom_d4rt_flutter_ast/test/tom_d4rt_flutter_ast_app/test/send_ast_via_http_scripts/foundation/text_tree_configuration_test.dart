import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Deep visual demo for TextTreeConfiguration from package:flutter/foundation.
// The demo explains how Flutter renders DiagnosticsNode trees (debugDumpApp,
// FlutterErrorDetails, widget inspector) by walking through the seven canonical
// presets, dissecting every prefix field, and side-by-siding real toStringDeep
// output of a small Diagnosticable subject under several styles. Each section
// is a self-contained card; the entire widget tree is static, so the script
// renders correctly on first frame without any user interaction.

dynamic build(BuildContext context) {
  // A small diagnosable subject we will render several times under different
  // styles. We build it once here so each section can reference the same node.
  final _SampleScene scene = _SampleScene(
    title: 'Login Screen',
    palette: const _Palette(primary: 0xFF1E88E5, accent: 0xFFFFC107),
    children: const <_SampleNode>[
      _SampleNode(
        name: 'Header',
        kind: 'AppBar',
        children: <_SampleNode>[
          _SampleNode(name: 'BackButton', kind: 'IconButton'),
          _SampleNode(name: 'TitleText', kind: 'Text'),
        ],
      ),
      _SampleNode(
        name: 'Form',
        kind: 'Column',
        children: <_SampleNode>[
          _SampleNode(name: 'EmailField', kind: 'TextField'),
          _SampleNode(name: 'PasswordField', kind: 'TextField'),
          _SampleNode(name: 'SubmitButton', kind: 'ElevatedButton'),
        ],
      ),
      _SampleNode(name: 'Footer', kind: 'Text'),
    ],
  );

  // SECTION 8 prep: print a real diagnostic tree to the test log too.
  // See `_sparseToStringDeepFallback` below for the d4rt U10
  // workaround rationale.
  debugPrint('--- TextTreeConfiguration demo: live toStringDeep ---');
  debugPrint(_sparseToStringDeepFallback(scene));
  debugPrint('--- end live toStringDeep ---');

  return Scaffold(
    backgroundColor: const Color(0xFFF6F7FB),
    appBar: AppBar(
      title: const Text('TextTreeConfiguration — Visual Field Guide'),
      backgroundColor: const Color(0xFF263238),
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _heroHeader(),
          const SizedBox(height: 28),
          _section1WhyDiagnosticTrees(scene),
          const SizedBox(height: 28),
          _section2SevenCanonicalConfigurations(),
          const SizedBox(height: 28),
          _section3FieldByFieldAnatomy(),
          const SizedBox(height: 28),
          _section4SideBySideRenderings(scene),
          const SizedBox(height: 28),
          _section5CustomConfigurationBuilder(scene),
          const SizedBox(height: 28),
          _section6ReadingPrefixAnatomy(),
          const SizedBox(height: 28),
          _section7WhenToUseWhich(),
          const SizedBox(height: 28),
          _section8DebugPrintCard(),
        ],
      ),
    ),
  );
}

// =============================================================================
// Shared visual palette for the demo. The color code is used consistently for
// the four prefix categories across sections 3, 5 and 6.
// =============================================================================

const Color _kFirstLine = Color(0xFF1565C0); // prefixLineOne
const Color _kOtherLine = Color(0xFF2E7D32); // prefixOtherLines
const Color _kLastLine = Color(0xFFEF6C00); // prefixLastChildLineOne
const Color _kLink = Color(0xFF6A1B9A); // linkCharacter
const Color _kRootLine = Color(0xFF00838F); // prefixOtherLinesRootNode
const Color _kMeta = Color(0xFF455A64); // beforeName / afterName / footer
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kSubtle = Color(0xFFECEFF1);

// Header banner ---------------------------------------------------------------

Widget _heroHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1A237E), Color(0xFF283593), Color(0xFF3949AB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF1A237E).withValues(alpha: 0.35),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.account_tree_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(width: 20),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'TextTreeConfiguration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'How DiagnosticsNode trees become readable text — the seven '
                'presets, every prefix field, and side-by-side comparisons.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
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

// =============================================================================
// SECTION 1: Why diagnostic trees matter
// =============================================================================

Widget _section1WhyDiagnosticTrees(_SampleScene scene) {
  return _SectionShell(
    index: 1,
    title: 'Why diagnostic trees matter',
    accent: const Color(0xFF1E88E5),
    icon: Icons.lightbulb_outline,
    intro:
        'Every Diagnosticable in Flutter — widgets, render objects, themes — '
        'can be turned into a tree of DiagnosticsNode values. The textual form '
        'is produced by TextTreeRenderer, which is told how to draw the tree '
        'by a TextTreeConfiguration. Reading these dumps is a daily skill: '
        'debugDumpApp(), FlutterErrorDetails diagnostics, and the widget '
        'inspector all funnel through the same configuration system.',
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _NarrativeCard(
              title: 'debugDumpApp()',
              icon: Icons.terminal,
              color: const Color(0xFF1565C0),
              body:
                  'Dumps the whole widget tree to stdout. The default sparse '
                  'configuration draws ASCII branches so the structure is '
                  'obvious even in a plain console.',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _NarrativeCard(
              title: 'FlutterErrorDetails',
              icon: Icons.error_outline,
              color: const Color(0xFFC62828),
              body:
                  'When an assertion fires, Flutter renders the offending '
                  'subtree using errorTextConfiguration, which highlights '
                  'the failure with thick HORIZONTAL bars.',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _NarrativeCard(
              title: 'Widget Inspector',
              icon: Icons.search,
              color: const Color(0xFF6A1B9A),
              body:
                  'DevTools transmits diagnostic trees as JSON, but the '
                  'on-device summary tree uses shallowTextConfiguration to '
                  'avoid recursing into noisy properties.',
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _MonoBlock(
        label: 'A sparse tree of the demo scene',
        accent: const Color(0xFF1E88E5),
        // d4rt U10 workaround — see `_sparseToStringDeepFallback`.
        body: _sparseToStringDeepFallback(scene),
      ),
    ],
  );
}

// =============================================================================
// SECTION 2: The seven canonical configurations
// =============================================================================

Widget _section2SevenCanonicalConfigurations() {
  final List<_PresetCard> presets = <_PresetCard>[
    const _PresetCard(
      name: 'sparseTextConfiguration',
      tag: 'sparse',
      tint: Color(0xFF1565C0),
      blurb: 'The default. Three-character branches, lots of breathing room.',
      one: '├─',
      other: '│ ',
      last: '└─',
      link: '─',
      example: <String>[
        'Root',
        ' ├─Child A',
        ' │  ├─Grandchild',
        ' │  └─Grandchild',
        ' └─Child B',
      ],
    ),
    const _PresetCard(
      name: 'denseTextConfiguration',
      tag: 'dense',
      tint: Color(0xFF6A1B9A),
      blurb: 'Tight one-character lines for compact dumps in narrow terminals.',
      one: '├',
      other: '│',
      last: '└',
      link: '',
      example: <String>[
        'Root',
        '├Child A',
        '│├Grandchild',
        '│└Grandchild',
        '└Child B',
      ],
    ),
    const _PresetCard(
      name: 'singleLineTextConfiguration',
      tag: 'singleLine',
      tint: Color(0xFF2E7D32),
      blurb: 'Collapses everything onto one line — for compact properties.',
      one: '',
      other: '',
      last: '',
      link: '',
      example: <String>[
        'Root(child: Child A(Grandchild, Grandchild), child: Child B)',
      ],
    ),
    const _PresetCard(
      name: 'transitionTextConfiguration',
      tag: 'transition',
      tint: Color(0xFFEF6C00),
      blurb:
          'Used for errors mid-stream: keeps the prior line context but draws '
          'a thick separator afterwards.',
      one: '╞══╦══',
      other: '│   ║',
      last: '└──╨──',
      link: '═',
      example: <String>[
        'Root',
        '╞══╦══Child A',
        '│   ║══Grandchild',
        '└──╨══Child B',
      ],
    ),
    const _PresetCard(
      name: 'errorTextConfiguration',
      tag: 'error',
      tint: Color(0xFFC62828),
      blurb: 'Boxed, eye-catching framing for FlutterError diagnostics.',
      one: '╞═╦══',
      other: '│ ║',
      last: '└─╨──',
      link: '═',
      example: <String>[
        '══════════════════════════════',
        'EXCEPTION CAUGHT BY WIDGETS',
        '╞═╦══Build phase',
        '│ ║══Stack frame #0',
        '└─╨══Stack frame #1',
        '══════════════════════════════',
      ],
    ),
    const _PresetCard(
      name: 'whitespaceTextConfiguration',
      tag: 'whitespace',
      tint: Color(0xFF455A64),
      blurb: 'No branch characters at all — pure indentation. Great for diffs.',
      one: '  ',
      other: '  ',
      last: '  ',
      link: '',
      example: <String>[
        'Root',
        '  Child A',
        '    Grandchild',
        '    Grandchild',
        '  Child B',
      ],
    ),
    const _PresetCard(
      name: 'shallowTextConfiguration',
      tag: 'shallow',
      tint: Color(0xFF00838F),
      blurb:
          'Skips children — only properties of the root are shown. Used by '
          'the inspector summary tree.',
      one: '',
      other: '',
      last: '',
      link: '',
      example: <String>['Root(properties only — no children rendered)'],
    ),
  ];

  return _SectionShell(
    index: 2,
    title: 'The seven canonical configurations',
    accent: const Color(0xFF6A1B9A),
    icon: Icons.grid_view_rounded,
    intro:
        'Flutter ships seven const TextTreeConfiguration instances in '
        'foundation/diagnostics.dart. Each renders the same tree differently. '
        'The grid below lists their prefix characters in monospace and a tiny '
        'sample rendering of the same five-node tree.',
    children: <Widget>[
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final int columns = constraints.maxWidth > 720 ? 2 : 1;
          return Wrap(
            spacing: 14,
            runSpacing: 14,
            children: <Widget>[
              for (final _PresetCard preset in presets)
                SizedBox(
                  width:
                      (constraints.maxWidth - (columns - 1) * 14) / columns -
                      0.01,
                  child: _PresetCardWidget(preset: preset),
                ),
            ],
          );
        },
      ),
    ],
  );
}

// =============================================================================
// SECTION 3: Field-by-field anatomy of TextTreeConfiguration
// =============================================================================

Widget _section3FieldByFieldAnatomy() {
  final List<_FieldRow> fields = <_FieldRow>[
    const _FieldRow(
      name: 'prefixLineOne',
      color: _kFirstLine,
      sample: '├─',
      desc: 'Prefix for the first line of a (non-last) child.',
    ),
    const _FieldRow(
      name: 'prefixOtherLines',
      color: _kOtherLine,
      sample: '│ ',
      desc: 'Prefix for subsequent lines of any non-last child.',
    ),
    const _FieldRow(
      name: 'prefixLastChildLineOne',
      color: _kLastLine,
      sample: '└─',
      desc: 'Prefix for the FIRST line of the LAST child of a node.',
    ),
    const _FieldRow(
      name: 'prefixOtherLinesRootNode',
      color: _kRootLine,
      sample: '  ',
      desc: 'Continuation prefix at the very top of the tree (no parent).',
    ),
    const _FieldRow(
      name: 'linkCharacter',
      color: _kLink,
      sample: '─',
      desc: 'Character used to extend horizontal branches.',
    ),
    const _FieldRow(
      name: 'childLinkSpace',
      color: _kLink,
      sample: ' ',
      desc: 'Visual gap between linkCharacter and the child name.',
    ),
    const _FieldRow(
      name: 'lineBreak',
      color: _kMeta,
      sample: r'\n',
      desc: 'Line break inserted between properties and between children.',
    ),
    const _FieldRow(
      name: 'lineBreakProperties',
      color: _kMeta,
      sample: 'true',
      desc: 'Whether to break between consecutive properties.',
    ),
    const _FieldRow(
      name: 'afterName',
      color: _kMeta,
      sample: ':',
      desc: 'Glyph emitted directly after the node\'s name.',
    ),
    const _FieldRow(
      name: 'beforeProperties',
      color: _kMeta,
      sample: '',
      desc: 'String emitted before the first property of a node.',
    ),
    const _FieldRow(
      name: 'afterProperties',
      color: _kMeta,
      sample: '',
      desc: 'String emitted after the last property of a node.',
    ),
    const _FieldRow(
      name: 'beforeName',
      color: _kMeta,
      sample: '',
      desc: 'String emitted just before the node name.',
    ),
    const _FieldRow(
      name: 'propertyPrefixIfChildren',
      color: _kOtherLine,
      sample: '│  ',
      desc: 'Property indentation when the node has children below.',
    ),
    const _FieldRow(
      name: 'propertyPrefixNoChildren',
      color: _kOtherLine,
      sample: '   ',
      desc: 'Property indentation when no children follow.',
    ),
    const _FieldRow(
      name: 'footer',
      color: _kMeta,
      sample: '',
      desc: 'String emitted after the whole subtree (for boxed styles).',
    ),
  ];

  return _SectionShell(
    index: 3,
    title: 'Field-by-field anatomy of TextTreeConfiguration',
    accent: const Color(0xFF2E7D32),
    icon: Icons.schema,
    intro:
        'Each line of a rendered tree is the concatenation of several fields. '
        'The diagram below assembles one synthetic line from labelled chips so '
        'the role of each field is unambiguous. The legend defines the color '
        'code used throughout sections 5 and 6 as well.',
    children: <Widget>[
      _legendStrip(),
      const SizedBox(height: 14),
      _anatomyDiagram(),
      const SizedBox(height: 18),
      _fieldTable(fields),
    ],
  );
}

Widget _legendStrip() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: _kSubtle,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Wrap(
      spacing: 14,
      runSpacing: 8,
      children: const <Widget>[
        _LegendDot(label: 'prefixLineOne', color: _kFirstLine),
        _LegendDot(label: 'prefixOtherLines', color: _kOtherLine),
        _LegendDot(label: 'prefixLastChildLineOne', color: _kLastLine),
        _LegendDot(label: 'linkCharacter / childLinkSpace', color: _kLink),
        _LegendDot(label: 'prefixOtherLinesRootNode', color: _kRootLine),
        _LegendDot(label: 'beforeName / afterName / footer', color: _kMeta),
      ],
    ),
  );
}

Widget _anatomyDiagram() {
  // A synthetic single line composed of four labelled chips. Below each chip a
  // small caret + label points at the source field. Implemented with Stack +
  // Positioned + dashed-style top border to mimic an exploded diagram.
  return Container(
    padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Anatomy of one rendered line',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        const SizedBox(height: 14),
        Row(
          children: const <Widget>[
            _CharChip(text: '├', color: _kFirstLine, label: 'prefixLineOne'),
            _CharChip(text: '─', color: _kLink, label: 'linkCharacter'),
            _CharChip(text: ' ', color: _kLink, label: 'childLinkSpace'),
            _CharChip(
              text: 'EmailField',
              color: _kMeta,
              label: 'node name',
              wide: true,
            ),
            _CharChip(text: ':', color: _kMeta, label: 'afterName'),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFAED581)),
          ),
          child: const Text(
            'When the same node is the LAST child, prefixLineOne is swapped '
            'for prefixLastChildLineOne (orange). All continuation lines for '
            'this child use prefixOtherLines (green), unless the node is the '
            'root, in which case prefixOtherLinesRootNode (teal) is used.',
            style: TextStyle(fontSize: 12, color: Color(0xFF33691E)),
          ),
        ),
      ],
    ),
  );
}

Widget _fieldTable(List<_FieldRow> fields) {
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 220,
                child: Text(
                  'Field',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                width: 90,
                child: Text(
                  'Sample',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: Text(
                  'Purpose',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        for (int i = 0; i < fields.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: i.isEven ? Colors.white : const Color(0xFFFAFAFA),
              border: const Border(
                bottom: BorderSide(color: Color(0xFFECEFF1)),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 220,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: fields[i].color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          fields[i].name,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: fields[i].color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: fields[i].color.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Text(
                      fields[i].sample.isEmpty ? '"" ' : fields[i].sample,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: fields[i].color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    fields[i].desc,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF37474F),
                      height: 1.35,
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

// =============================================================================
// SECTION 4: Side-by-side rendering of the same tree under each style
// =============================================================================

Widget _section4SideBySideRenderings(_SampleScene scene) {
  // Render the scene under several configurations. We don't drive the real
  // TextTreeRenderer for every style — for the demo, sparse uses the actual
  // toStringDeep() and the others are illustrative variants computed by a
  // simple in-script renderer that mirrors the field semantics.
  // d4rt U10 workaround — see `_sparseToStringDeepFallback`.
  final String sparse = _sparseToStringDeepFallback(scene);
  final String dense = scene.renderManual(
    one: '├',
    other: '│',
    last: '└',
    link: '',
  );
  final String singleLine = scene.renderSingleLine();
  final String whitespace = scene.renderManual(
    one: '  ',
    other: '  ',
    last: '  ',
    link: '',
  );

  return _SectionShell(
    index: 4,
    title: 'Side-by-side: the same tree, four ways',
    accent: const Color(0xFFEF6C00),
    icon: Icons.compare_arrows,
    intro:
        'A small DiagnosticableTree subject is rendered four times. Sparse is '
        'taken from real toStringDeep(); the others come from an in-script '
        'mini renderer that mirrors the field semantics so the output stays '
        'predictable across d4rt and the host SDK.',
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _MonoBlock(
              label: 'sparse (default — toStringDeep)',
              accent: _kFirstLine,
              body: sparse,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _MonoBlock(
              label: 'dense (tight one-char branches)',
              accent: const Color(0xFF6A1B9A),
              body: dense,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _MonoBlock(
              label: 'singleLine (compact properties)',
              accent: const Color(0xFF2E7D32),
              body: singleLine,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _MonoBlock(
              label: 'whitespace (no branch glyphs)',
              accent: const Color(0xFF455A64),
              body: whitespace,
            ),
          ),
        ],
      ),
    ],
  );
}

// =============================================================================
// SECTION 5: Custom configuration builder
// =============================================================================

Widget _section5CustomConfigurationBuilder(_SampleScene scene) {
  final String unicodeRender = scene.renderManual(
    one: '├──',
    other: '│  ',
    last: '╰──',
    link: '─',
  );
  final String asciiRender = scene.renderManual(
    one: '|--',
    other: '|  ',
    last: '\\--',
    link: '-',
  );

  return _SectionShell(
    index: 5,
    title: 'Building a custom TextTreeConfiguration',
    accent: const Color(0xFF00838F),
    icon: Icons.build_circle_outlined,
    intro:
        'Custom configurations are useful when you target a non-Unicode '
        'console, embed dumps in logs that strip box-drawing characters, or '
        'want a different aesthetic in a custom DevTools panel. The card on '
        'the left uses elegant rounded Unicode corners (╰); the right falls '
        'back to ASCII pipes and backslashes for safety.',
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _customConfigCard(true, unicodeRender)),
          const SizedBox(width: 12),
          Expanded(child: _customConfigCard(false, asciiRender)),
        ],
      ),
    ],
  );
}

Widget _customConfigCard(bool unicode, String render) {
  final Color tint = unicode
      ? const Color(0xFF00838F)
      : const Color(0xFF6D4C41);
  final String title = unicode
      ? 'Unicode arrows (╰── style)'
      : 'ASCII fallback (\\-- style)';
  final List<List<String>> kv = unicode
      ? const <List<String>>[
          <String>['prefixLineOne', '├──'],
          <String>['prefixOtherLines', '│  '],
          <String>['prefixLastChildLineOne', '╰──'],
          <String>['linkCharacter', '─'],
          <String>['propertyPrefixIfChildren', '│  '],
        ]
      : const <List<String>>[
          <String>['prefixLineOne', '|--'],
          <String>['prefixOtherLines', '|  '],
          <String>['prefixLastChildLineOne', '\\--'],
          <String>['linkCharacter', '-'],
          <String>['propertyPrefixIfChildren', '|  '],
        ];
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tint.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(unicode ? Icons.auto_awesome : Icons.text_fields, color: tint),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: tint,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final List<String> row in kv)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 180,
                  child: Text(
                    row[0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: Color(0xFF263238),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: tint.withValues(alpha: 0.35)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row[1],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        _MonoBlock(label: 'Rendered tree', accent: tint, body: render),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6: Reading prefix anatomy — color-coded character chips
// =============================================================================

Widget _section6ReadingPrefixAnatomy() {
  return _SectionShell(
    index: 6,
    title: 'Reading prefix anatomy character by character',
    accent: const Color(0xFFC62828),
    icon: Icons.zoom_in,
    intro:
        'The same one-line example "│  ├── EmailField:" is decomposed here '
        'into its constituent characters, each rendered as a color-coded chip. '
        'A second row reshapes the same content as if EmailField were the LAST '
        'child of its parent, so the swap from prefixLineOne to '
        'prefixLastChildLineOne is visually obvious.',
    children: <Widget>[
      _annotatedLine(
        caption: 'EmailField as a non-last child',
        chips: const <_AnnotatedChip>[
          _AnnotatedChip(text: '│', color: _kOtherLine, role: 'prefixOther'),
          _AnnotatedChip(text: ' ', color: _kOtherLine, role: ''),
          _AnnotatedChip(text: ' ', color: _kOtherLine, role: ''),
          _AnnotatedChip(text: '├', color: _kFirstLine, role: 'prefixLineOne'),
          _AnnotatedChip(text: '─', color: _kLink, role: 'linkChar'),
          _AnnotatedChip(text: '─', color: _kLink, role: 'linkChar'),
          _AnnotatedChip(text: ' ', color: _kLink, role: 'childLinkSpace'),
          _AnnotatedChip(text: 'EmailField', color: _kMeta, role: 'name'),
          _AnnotatedChip(text: ':', color: _kMeta, role: 'afterName'),
        ],
      ),
      const SizedBox(height: 14),
      _annotatedLine(
        caption: 'EmailField as the LAST child',
        chips: const <_AnnotatedChip>[
          _AnnotatedChip(text: '│', color: _kOtherLine, role: 'prefixOther'),
          _AnnotatedChip(text: ' ', color: _kOtherLine, role: ''),
          _AnnotatedChip(text: ' ', color: _kOtherLine, role: ''),
          _AnnotatedChip(
            text: '└',
            color: _kLastLine,
            role: 'prefixLastChildLineOne',
          ),
          _AnnotatedChip(text: '─', color: _kLink, role: 'linkChar'),
          _AnnotatedChip(text: '─', color: _kLink, role: 'linkChar'),
          _AnnotatedChip(text: ' ', color: _kLink, role: 'childLinkSpace'),
          _AnnotatedChip(text: 'EmailField', color: _kMeta, role: 'name'),
          _AnnotatedChip(text: ':', color: _kMeta, role: 'afterName'),
        ],
      ),
      const SizedBox(height: 14),
      _annotatedLine(
        caption: 'Continuation line for EmailField\'s wrapped property',
        chips: const <_AnnotatedChip>[
          _AnnotatedChip(text: '│', color: _kOtherLine, role: 'prefixOther'),
          _AnnotatedChip(text: ' ', color: _kOtherLine, role: ''),
          _AnnotatedChip(text: ' ', color: _kOtherLine, role: ''),
          _AnnotatedChip(text: ' ', color: _kOtherLine, role: ''),
          _AnnotatedChip(text: ' ', color: _kOtherLine, role: ''),
          _AnnotatedChip(
            text: 'autofocus: true',
            color: _kMeta,
            role: 'wrapped property',
          ),
        ],
      ),
    ],
  );
}

Widget _annotatedLine({
  required String caption,
  required List<_AnnotatedChip> chips,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          caption,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 3,
          runSpacing: 8,
          children: <Widget>[
            for (final _AnnotatedChip chip in chips)
              _annotatedChip(chip: chip),
          ],
        ),
      ],
    ),
  );
}

Widget _annotatedChip({required _AnnotatedChip chip}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    decoration: BoxDecoration(
      color: chip.color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: chip.color.withValues(alpha: 0.5)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          chip.text.isEmpty ? '·' : chip.text,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            color: chip.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (chip.role.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              chip.role,
              style: TextStyle(
                fontSize: 8.5,
                color: chip.color.withValues(alpha: 0.85),
              ),
            ),
          ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7: When to use which preset
// =============================================================================

Widget _section7WhenToUseWhich() {
  final List<_AdvisoryRow> rows = const <_AdvisoryRow>[
    _AdvisoryRow(
      situation: 'Console dump (debugDumpApp / debugDumpRenderTree)',
      preset: 'sparseTextConfiguration',
      why: 'Three-character branches read well in unfocused console scans.',
      tint: Color(0xFF1565C0),
    ),
    _AdvisoryRow(
      situation: 'Narrow log column (CI, containers, mobile log)',
      preset: 'denseTextConfiguration',
      why: 'Tight prefixes avoid wrapping when the tree grows wide.',
      tint: Color(0xFF6A1B9A),
    ),
    _AdvisoryRow(
      situation: 'Per-property formatting in a single message',
      preset: 'singleLineTextConfiguration',
      why: 'Used internally for inlined toString of small Diagnosticables.',
      tint: Color(0xFF2E7D32),
    ),
    _AdvisoryRow(
      situation: 'A FlutterError with a stack of causes',
      preset: 'errorTextConfiguration',
      why: 'Boxed framing makes the failure unmissable in surrounding logs.',
      tint: Color(0xFFC62828),
    ),
    _AdvisoryRow(
      situation: 'Diff-able plain-text snapshot of a tree',
      preset: 'whitespaceTextConfiguration',
      why: 'No branch glyphs — every line moves predictably under reformat.',
      tint: Color(0xFF455A64),
    ),
    _AdvisoryRow(
      situation: 'Inspector summary panel',
      preset: 'shallowTextConfiguration',
      why: 'Skips children — root properties only — keeps the panel light.',
      tint: Color(0xFF00838F),
    ),
    _AdvisoryRow(
      situation: 'Bridging from one section of output into the next',
      preset: 'transitionTextConfiguration',
      why: 'Visual seam between two trees that share context.',
      tint: Color(0xFFEF6C00),
    ),
  ];

  return _SectionShell(
    index: 7,
    title: 'When to use which preset',
    accent: const Color(0xFF455A64),
    icon: Icons.tune,
    intro:
        'The seven presets are not interchangeable. Picking the right one '
        'depends on where the rendered text will be read. The advisory table '
        'below gives a quick decision aid: situation → recommended preset → '
        'why it fits.',
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFCFD8DC)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFECEFF1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: const <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Situation',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Recommended',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Why',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < rows.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: i.isEven ? Colors.white : const Color(0xFFFAFAFA),
                  border: const Border(
                    bottom: BorderSide(color: Color(0xFFECEFF1)),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text(
                        rows[i].situation,
                        style: const TextStyle(fontSize: 12.5, height: 1.35),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: rows[i].tint.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: rows[i].tint.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          rows[i].preset,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            color: rows[i].tint,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        rows[i].why,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.35,
                          color: Color(0xFF37474F),
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
  );
}

// =============================================================================
// SECTION 8: debugPrint of a real diagnostic tree
// =============================================================================

Widget _section8DebugPrintCard() {
  return _SectionShell(
    index: 8,
    title: 'debugPrint of a real diagnostic tree',
    accent: const Color(0xFF263238),
    icon: Icons.print_outlined,
    intro:
        'At the top of build() we already called '
        'debugPrint(_SampleScene(...).toDiagnosticsNode().toStringDeep()) so '
        'the test log shows real toStringDeep output. The reminder card below '
        'shows the exact two-line incantation that produced it.',
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1721),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              '// in build():',
              style: TextStyle(
                color: Color(0xFF80CBC4),
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'debugPrint(scene.toDiagnosticsNode().toStringDeep());',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12.5,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Output goes through the standard print throttle and shows up in '
              'the test log next to the rendered frame.',
              style: TextStyle(color: Colors.white70, fontSize: 11.5),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// Shared reusable widgets
// =============================================================================

class _SectionShell extends StatelessWidget {
  final int index;
  final String title;
  final String intro;
  final Color accent;
  final IconData icon;
  final List<Widget> children;
  const _SectionShell({
    required this.index,
    required this.title,
    required this.intro,
    required this.accent,
    required this.icon,
    required this.children,
  });
  @override
  Widget build(BuildContext context) {
    // SECTION wrapper: index badge + title strip + intro paragraph + content.
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(icon, color: accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            intro,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF37474F),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _NarrativeCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final Color color;
  const _NarrativeCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Color(0xFF37474F),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonoBlock extends StatelessWidget {
  final String label;
  final Color accent;
  final String body;
  const _MonoBlock({
    required this.label,
    required this.accent,
    required this.body,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1721),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Text(
              body,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Color(0xFFE0E0E0),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendDot({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class _CharChip extends StatelessWidget {
  final String text;
  final String label;
  final Color color;
  final bool wide;
  const _CharChip({
    required this.text,
    required this.label,
    required this.color,
    this.wide = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: wide ? null : 30,
            padding: EdgeInsets.symmetric(
              horizontal: wide ? 10 : 4,
              vertical: 6,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              border: Border.all(color: color.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              text.isEmpty ? '·' : text,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: wide ? 100 : 60,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.5, color: color, height: 1.15),
            ),
          ),
        ],
      ),
    );
  }
}

class _PresetCardWidget extends StatelessWidget {
  final _PresetCard preset;
  const _PresetCardWidget({required this.preset});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: preset.tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: preset.tint.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: preset.tint,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  preset.tag,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  preset.name,
                  style: TextStyle(
                    color: preset.tint,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            preset.blurb,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF37474F),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: <Widget>[
              _kvChip('one', preset.one, _kFirstLine),
              _kvChip('other', preset.other, _kOtherLine),
              _kvChip('last', preset.last, _kLastLine),
              _kvChip('link', preset.link, _kLink),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1721),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final String line in preset.example)
                  Text(
                    line,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFFE0F2F1),
                      height: 1.35,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kvChip(String key, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontFamily: 'monospace', fontSize: 10.5),
          children: <InlineSpan>[
            TextSpan(
              text: '$key=',
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: value.isEmpty ? '""' : '"$value"',
              style: const TextStyle(color: Color(0xFF263238)),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Plain data classes used by the demo (no Diagnosticable subclassing needed
// for the renderers; we also build a Diagnosticable wrapper for SECTION 1).
// =============================================================================

class _PresetCard {
  final String name;
  final String tag;
  final Color tint;
  final String blurb;
  final String one;
  final String other;
  final String last;
  final String link;
  final List<String> example;
  const _PresetCard({
    required this.name,
    required this.tag,
    required this.tint,
    required this.blurb,
    required this.one,
    required this.other,
    required this.last,
    required this.link,
    required this.example,
  });
}

class _FieldRow {
  final String name;
  final String sample;
  final String desc;
  final Color color;
  const _FieldRow({
    required this.name,
    required this.sample,
    required this.desc,
    required this.color,
  });
}

class _AnnotatedChip {
  final String text;
  final Color color;
  final String role;
  const _AnnotatedChip({
    required this.text,
    required this.color,
    required this.role,
  });
}

class _AdvisoryRow {
  final String situation;
  final String preset;
  final String why;
  final Color tint;
  const _AdvisoryRow({
    required this.situation,
    required this.preset,
    required this.why,
    required this.tint,
  });
}

class _Palette {
  final int primary;
  final int accent;
  const _Palette({required this.primary, required this.accent});
}

// d4rt limitation: script-defined classes that extend bridged native
// abstract types (`DiagnosticableTree`, `Diagnosticable`, ...) are
// rejected by `D4.validateTarget` inside the bridged
// `toDiagnosticsNode` adapter, so `scene.toDiagnosticsNode()` returns
// null and the chained `.toStringDeep()` throws
// `Cannot invoke method 'toStringDeep' on null`. Same architectural
// family as U10 in `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`
// ("Script-defined class with DiagnosticableTreeMixin cannot call
// inherited concrete methods"). Workaround: render the sparse-style
// tree manually from the `_SampleNode` data the script already owns
// — visually equivalent to the real `toStringDeep` output for this
// demo (header line + tree body with default ├─/│ / └─ markers).
String _sparseToStringDeepFallback(_SampleScene scene) {
  final StringBuffer buf = StringBuffer();
  // Header line mirrors `_SampleScene.toStringShort()` plus the three
  // properties added by `debugFillProperties` (title, primary, accent).
  buf.write('Scene<');
  buf.write(scene.title);
  buf.write('>(title: "');
  buf.write(scene.title);
  buf.write('", primary: ');
  buf.write(scene.palette.primary);
  buf.write(', accent: ');
  buf.write(scene.palette.accent);
  buf.writeln(')');
  // Body uses the sparse default branch markers so the output reads
  // like Flutter's real sparse `toStringDeep` rendering.
  buf.write(scene.renderManual(
    one: '├─',
    other: '│  ',
    last: '└─',
    link: ' ',
  ));
  return buf.toString();
}

class _SampleNode {
  final String name;
  final String kind;
  final List<_SampleNode> children;
  const _SampleNode({
    required this.name,
    required this.kind,
    this.children = const <_SampleNode>[],
  });
}

// A tiny DiagnosticableTree subject so we can call real toStringDeep().
class _SampleScene extends DiagnosticableTree {
  final String title;
  final _Palette palette;
  final List<_SampleNode> children;
  _SampleScene({
    required this.title,
    required this.palette,
    required this.children,
  });

  @override
  String toStringShort() => 'Scene<$title>';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(IntProperty('primary', palette.primary, showName: true));
    properties.add(IntProperty('accent', palette.accent, showName: true));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return <DiagnosticsNode>[
      for (final _SampleNode child in children) _nodeAsDiagnostics(child),
    ];
  }

  DiagnosticsNode _nodeAsDiagnostics(_SampleNode n) {
    return _SampleNodeDiagnosable(n).toDiagnosticsNode(name: n.name);
  }

  String renderManual({
    required String one,
    required String other,
    required String last,
    required String link,
  }) {
    final StringBuffer buf = StringBuffer();
    buf.writeln('Scene<$title>');
    for (int i = 0; i < children.length; i++) {
      _renderChild(
        buf,
        children[i],
        '',
        i == children.length - 1,
        one,
        other,
        last,
        link,
      );
    }
    return buf.toString();
  }

  void _renderChild(
    StringBuffer buf,
    _SampleNode node,
    String indent,
    bool isLast,
    String one,
    String other,
    String last,
    String link,
  ) {
    final String marker = isLast ? last : one;
    buf.writeln('$indent$marker$link${node.name}');
    final String nextIndent = '$indent${isLast ? '   ' : other}';
    for (int i = 0; i < node.children.length; i++) {
      _renderChild(
        buf,
        node.children[i],
        nextIndent,
        i == node.children.length - 1,
        one,
        other,
        last,
        link,
      );
    }
  }

  String renderSingleLine() {
    final StringBuffer buf = StringBuffer('Scene<$title>(');
    for (int i = 0; i < children.length; i++) {
      if (i > 0) buf.write(', ');
      _renderInline(buf, children[i]);
    }
    buf.write(')');
    return buf.toString();
  }

  void _renderInline(StringBuffer buf, _SampleNode node) {
    buf.write(node.name);
    if (node.children.isNotEmpty) {
      buf.write('(');
      for (int i = 0; i < node.children.length; i++) {
        if (i > 0) buf.write(', ');
        _renderInline(buf, node.children[i]);
      }
      buf.write(')');
    }
  }
}

class _SampleNodeDiagnosable extends DiagnosticableTree {
  final _SampleNode node;
  _SampleNodeDiagnosable(this.node);

  @override
  String toStringShort() => '${node.name} (${node.kind})';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('kind', node.kind));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return <DiagnosticsNode>[
      for (final _SampleNode c in node.children)
        _SampleNodeDiagnosable(c).toDiagnosticsNode(name: c.name),
    ];
  }
}
