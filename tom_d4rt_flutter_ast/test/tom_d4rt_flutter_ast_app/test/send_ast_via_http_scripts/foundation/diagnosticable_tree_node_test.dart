// ignore_for_file: avoid_print, deprecated_member_use, unused_local_variable, unused_element, unused_field
//
// =============================================================================
//  Visual Deep Demo: DiagnosticableTreeNode
// =============================================================================
//  Subject: package:flutter/foundation.dart  ->  DiagnosticableTreeNode
//
//  `DiagnosticableTreeNode` is the concrete `DiagnosticsNode` subtype that wraps
//  a `DiagnosticableTree` value so the diagnostics infrastructure can walk it as
//  a tree. It is what `DiagnosticableTree.toDiagnosticsNode()` returns. The node
//  exposes:
//
//    * `value`        : the wrapped `Diagnosticable` (usually a tree)
//    * `name`         : optional label used when this node is a child slot
//    * `style`        : a `DiagnosticsTreeStyle` controlling sparse / dense /
//                       offstage / whitespace / errorProperty rendering
//    * `getProperties()` : flat property list (from `debugFillProperties`)
//    * `getChildren()`   : structural children (from `debugDescribeChildren`)
//    * `toJsonMap`       : machine-readable serialization
//    * `toStringDeep`    : recursive pretty-print used by the inspector
//
//  This file is a single-screen, hand-written visual demonstration of those
//  facets. It builds two real `DiagnosticableTree` subclasses (`_Folder` and
//  `_File`), walks them via `getChildren()` / `getProperties()`, and renders
//  the result as an indented tree of Material `Card`s. Static recipe and
//  glossary data complete the dossier.
//
//  Sections (11 total):
//    1.  Dossier  — role & relationship to DiagnosticsNode / DiagnosticableTree
//    2.  Anatomy  — constructor parameters and inherited methods
//    3.  Sample classes (_Folder / _File) — live DiagnosticableTree subjects
//    4.  Live walk — toDiagnosticsNode() rendered as indented Card tree
//    5.  Style comparison — dense / sparse / offstage / whitespace toStringDeep
//    6.  toJsonMap viewer — the JSON shape of the tree
//    7.  Property builder — how debugFillProperties populates getProperties()
//    8.  Recipe cards (8) — common patterns and idioms
//    9.  Comparison table — Node vs DiagnosticsNode vs DiagnosticsProperty
//   10.  Glossary (10 terms)
//   11.  Final widget tree (the assembled scrolling demo)
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Theme tokens.  Private to this fixture (underscore prefix) so the AST tools
// that ingest the file do not trip on "private types in public API" lint.
// -----------------------------------------------------------------------------

const Color _ink = Color(0xFF101828);
const Color _inkSoft = Color(0xFF344054);
const Color _inkMute = Color(0xFF667085);
const Color _paper = Color(0xFFF9FAFB);
const Color _paperAlt = Color(0xFFF2F4F7);
const Color _line = Color(0xFFD0D5DD);
const Color _accent = Color(0xFF6938EF);
const Color _accentAlt = Color(0xFF9E77ED);
const Color _accentTint = Color(0xFFEDE7FB);
const Color _mint = Color(0xFF12B76A);
const Color _mintTint = Color(0xFFD1FADF);
const Color _amber = Color(0xFFDC6803);
const Color _amberTint = Color(0xFFFEF0C7);
const Color _rose = Color(0xFFD92D20);
const Color _roseTint = Color(0xFFFEE4E2);
const Color _sky = Color(0xFF0086C9);
const Color _skyTint = Color(0xFFE0F2FE);
const Color _consoleBg = Color(0xFF0F1115);
const Color _consoleFg = Color(0xFFE5E7EB);
const Color _consoleDim = Color(0xFF98A2B3);
const Color _consoleHi = Color(0xFFFCD34D);
const Color _consoleStr = Color(0xFF7DD3FC);
const Color _consoleKey = Color(0xFFC4B5FD);
const Color _consoleNum = Color(0xFFFCA5A5);

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
  fontSize: 24,
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
  fontSize: 11,
  fontWeight: FontWeight.w800,
  color: _accent,
  letterSpacing: 1.4,
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

const TextStyle _tag = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.6,
  color: Colors.white,
);

// -----------------------------------------------------------------------------
// Sample DiagnosticableTree classes used in SECTIONS 3 & 4.
//
// `_Folder` and `_File` form a small filesystem-like tree. Both extend
// `DiagnosticableTree`, override `debugFillProperties` and `debugDescribeChildren`
// so that `toDiagnosticsNode()` produces a real `DiagnosticableTreeNode` we can
// inspect at runtime.
// -----------------------------------------------------------------------------

class _File extends DiagnosticableTree {
  _File({required this.name, required this.bytes, this.readOnly = false});

  final String name;
  final int bytes;
  final bool readOnly;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(IntProperty('bytes', bytes));
    properties.add(FlagProperty(
      'readOnly',
      value: readOnly,
      ifTrue: 'read-only',
      ifFalse: 'writable',
    ));
  }
}

class _Folder extends DiagnosticableTree {
  _Folder({required this.name, this.children = const <Object>[]});

  final String name;
  final List<Object> children;

  int get totalEntries => children.length;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(IntProperty('entries', children.length));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> out = <DiagnosticsNode>[];
    for (int i = 0; i < children.length; i++) {
      final Object c = children[i];
      if (c is _File) {
        out.add(c.toDiagnosticsNode(name: 'file_$i'));
      } else if (c is _Folder) {
        out.add(c.toDiagnosticsNode(name: 'dir_$i'));
      }
    }
    return out;
  }
}

// -----------------------------------------------------------------------------
// Plain data shapes used by the static visual sections.  These are not
// `Diagnosticable`; they are just declarative records the cards consume.
// -----------------------------------------------------------------------------

class _RecipeSpec {
  const _RecipeSpec({
    required this.title,
    required this.summary,
    required this.code,
    required this.accent,
  });

  final String title;
  final String summary;
  final String code;
  final Color accent;
}

class _MatrixRow {
  const _MatrixRow(this.label, this.node, this.diag, this.prop);
  final String label;
  final String node;
  final String diag;
  final String prop;
}

class _GlossaryEntry {
  const _GlossaryEntry(this.term, this.gloss);
  final String term;
  final String gloss;
}

class _StyleSample {
  const _StyleSample({
    required this.style,
    required this.summary,
    required this.snippet,
    required this.tint,
  });

  final String style;
  final String summary;
  final String snippet;
  final Color tint;
}

// -----------------------------------------------------------------------------
// build()  --  the entry point used by the D4rt runner.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Construct live diagnosticable tree (used in sections 4, 6, 7).
  final _Folder root = _Folder(
    name: '/project',
    children: <Object>[
      _Folder(
        name: 'lib',
        children: <Object>[
          _File(name: 'main.dart', bytes: 1280),
          _File(name: 'app.dart', bytes: 4096),
          _Folder(
            name: 'widgets',
            children: <Object>[
              _File(name: 'hero_card.dart', bytes: 5210),
              _File(name: 'glossary.dart', bytes: 2300, readOnly: true),
            ],
          ),
        ],
      ),
      _Folder(
        name: 'test',
        children: <Object>[
          _File(name: 'all_test.dart', bytes: 720),
        ],
      ),
      _File(name: 'README.md', bytes: 980, readOnly: true),
    ],
  );

  final DiagnosticsNode rootNode = root.toDiagnosticsNode(name: 'root');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: _paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _HeroCard(),
              const SizedBox(height: 28),

              // SECTION 1 ------------------------------------------------------
              const _SectionHeader(
                index: '01',
                title: 'Dossier',
                subtitle:
                    'Where DiagnosticableTreeNode sits in the diagnostics tower.',
                accent: _accent,
              ),
              const SizedBox(height: 14),
              const _DossierCard(),
              const SizedBox(height: 28),

              // SECTION 2 ------------------------------------------------------
              const _SectionHeader(
                index: '02',
                title: 'Anatomy',
                subtitle:
                    'Constructor signature, inherited surface and the role of '
                    'DiagnosticsTreeStyle.',
                accent: _sky,
              ),
              const SizedBox(height: 14),
              const _AnatomyCard(),
              const SizedBox(height: 28),

              // SECTION 3 ------------------------------------------------------
              const _SectionHeader(
                index: '03',
                title: 'Sample DiagnosticableTree classes',
                subtitle:
                    '_Folder and _File: a tiny filesystem to inspect at runtime.',
                accent: _mint,
              ),
              const SizedBox(height: 14),
              const _SampleClassesCard(),
              const SizedBox(height: 28),

              // SECTION 4 ------------------------------------------------------
              const _SectionHeader(
                index: '04',
                title: 'Live walk: toDiagnosticsNode()',
                subtitle:
                    'Walks the rootNode via getChildren() / getProperties() and '
                    'renders the result as an indented Card tree.',
                accent: _accent,
              ),
              const SizedBox(height: 14),
              _LiveWalkCard(rootNode: rootNode),
              const SizedBox(height: 28),

              // SECTION 5 ------------------------------------------------------
              const _SectionHeader(
                index: '05',
                title: 'DiagnosticsTreeStyle comparison',
                subtitle:
                    'Side-by-side panels for dense, sparse, offstage and '
                    'whitespace renderings.',
                accent: _amber,
              ),
              const SizedBox(height: 14),
              const _StyleComparisonCard(),
              const SizedBox(height: 28),

              // SECTION 6 ------------------------------------------------------
              const _SectionHeader(
                index: '06',
                title: 'toJsonMap viewer',
                subtitle:
                    'The diagnostics tree expressed as a JSON map suitable for '
                    'wire transport to DevTools.',
                accent: _sky,
              ),
              const SizedBox(height: 14),
              _JsonViewerCard(rootNode: rootNode),
              const SizedBox(height: 28),

              // SECTION 7 ------------------------------------------------------
              const _SectionHeader(
                index: '07',
                title: 'Property builder pipeline',
                subtitle:
                    'How debugFillProperties + DiagnosticPropertiesBuilder.add '
                    'populate getProperties().',
                accent: _mint,
              ),
              const SizedBox(height: 14),
              const _PropertyPipelineCard(),
              const SizedBox(height: 28),

              // SECTION 8 ------------------------------------------------------
              const _SectionHeader(
                index: '08',
                title: 'Recipe cards',
                subtitle: 'Eight idioms you will reach for most often.',
                accent: _accentAlt,
              ),
              const SizedBox(height: 14),
              const _RecipeGrid(),
              const SizedBox(height: 28),

              // SECTION 9 ------------------------------------------------------
              const _SectionHeader(
                index: '09',
                title: 'Comparison matrix',
                subtitle:
                    'DiagnosticableTreeNode vs DiagnosticsNode vs '
                    'DiagnosticsProperty<T>.',
                accent: _rose,
              ),
              const SizedBox(height: 14),
              const _ComparisonMatrix(),
              const SizedBox(height: 28),

              // SECTION 10 -----------------------------------------------------
              const _SectionHeader(
                index: '10',
                title: 'Glossary',
                subtitle: 'Ten terms you will see in stack traces and DevTools.',
                accent: _sky,
              ),
              const SizedBox(height: 14),
              const _GlossaryGrid(),
              const SizedBox(height: 28),

              // SECTION 11 -----------------------------------------------------
              const _SectionHeader(
                index: '11',
                title: 'Final widget tree',
                subtitle:
                    'The assembled demo is itself the final widget tree returned '
                    'by build().',
                accent: _accent,
              ),
              const SizedBox(height: 14),
              const _FinalCard(),
              const SizedBox(height: 24),
              const _Footer(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Hero card
// =============================================================================

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1F1147), Color(0xFF4A1FB8), Color(0xFF6938EF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x336938EF),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _HeroTag(),
          SizedBox(height: 18),
          Text(
            'DiagnosticableTreeNode',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.6,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'The DiagnosticsNode subtype that wraps a DiagnosticableTree value '
            'and exposes its properties and children to the inspector.',
            style: TextStyle(
              fontSize: 14.5,
              height: 1.55,
              color: Color(0xFFE9D7FE),
            ),
          ),
          SizedBox(height: 22),
          _HeroBadges(),
        ],
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.22)),
      ),
      child: const Text(
        'package:flutter/foundation.dart  ->  DiagnosticableTreeNode',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: Color(0xFFE9D7FE),
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _HeroBadges extends StatelessWidget {
  const _HeroBadges();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const <Widget>[
        _Badge(label: 'extends', value: 'DiagnosticsNode'),
        _Badge(label: 'wraps', value: 'DiagnosticableTree'),
        _Badge(label: 'children', value: 'getChildren()'),
        _Badge(label: 'props', value: 'getProperties()'),
        _Badge(label: 'serial', value: 'toJsonMap'),
        _Badge(label: 'pretty', value: 'toStringDeep'),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFFD6BBFB),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section header
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String index;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _section),
              const SizedBox(height: 2),
              Text(subtitle, style: _subtitle),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 1 — Dossier
// =============================================================================

class _DossierCard extends StatelessWidget {
  const _DossierCard();

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Role',
            style: _label,
          ),
          const SizedBox(height: 6),
          const Text(
            'DiagnosticableTreeNode is the concrete DiagnosticsNode subtype '
            'returned by DiagnosticableTree.toDiagnosticsNode(). It carries '
            'the diagnostic identity (name, value, style) of a tree-rooted '
            'subject as the inspector walks downwards.',
            style: _body,
          ),
          const SizedBox(height: 16),
          const Text('Hierarchy', style: _label),
          const SizedBox(height: 6),
          _MiniHierarchyDiagram(),
          const SizedBox(height: 16),
          const Text('Why it exists', style: _label),
          const SizedBox(height: 6),
          const Text(
            'Flat objects use DiagnosticableNode<T>. Tree-rooted objects need '
            'children — and that is exactly the extra cap DiagnosticableTreeNode '
            'adds: it forwards debugDescribeChildren() into getChildren().',
            style: _body,
          ),
        ],
      ),
    );
  }
}

class _MiniHierarchyDiagram extends StatelessWidget {
  const _MiniHierarchyDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _paperAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _HierarchyRow('DiagnosticsNode', 'abstract base, name + getProperties/Children'),
          _HierarchyRow('  DiagnosticableNode<T>', 'wraps any Diagnosticable value'),
          _HierarchyRow('    DiagnosticableTreeNode', 'specialises for DiagnosticableTree'),
          _HierarchyRow('  DiagnosticsProperty<T>', 'leaf node carrying a value'),
          _HierarchyRow('    StringProperty / IntProperty / ...', 'typed leaves'),
        ],
      ),
    );
  }
}

class _HierarchyRow extends StatelessWidget {
  const _HierarchyRow(this.cls, this.note);
  final String cls;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(cls, style: _monoInk),
          ),
          Expanded(
            flex: 6,
            child: Text(note, style: _monoSmall),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — Anatomy
// =============================================================================

class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Constructor', style: _label),
          const SizedBox(height: 6),
          _CodeBlock(lines: const <String>[
            'DiagnosticableTreeNode({',
            '  required String? name,',
            '  required DiagnosticableTree value,',
            '  required DiagnosticsTreeStyle? style,',
            '});',
          ]),
          const SizedBox(height: 16),
          const Text('Key parameters', style: _label),
          const SizedBox(height: 6),
          Column(
            children: const <Widget>[
              _ParamRow(
                'name',
                'Optional label. Set when the node is a child slot in a parent.',
              ),
              _ParamRow(
                'value',
                'The DiagnosticableTree being wrapped. Stored as the node value.',
              ),
              _ParamRow(
                'style',
                'A DiagnosticsTreeStyle controlling spacing, indentation, and '
                'visibility of the rendered tree.',
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Inherited surface', style: _label),
          const SizedBox(height: 6),
          Column(
            children: const <Widget>[
              _ParamRow('getProperties()', 'List<DiagnosticsNode> from debugFillProperties.'),
              _ParamRow('getChildren()', 'List<DiagnosticsNode> from debugDescribeChildren.'),
              _ParamRow('toJsonMap(delegate)', 'Serialises into a Map<String, Object?>.'),
              _ParamRow('toStringDeep()', 'Recursive ASCII tree (the inspector view).'),
              _ParamRow('toDescription(parentConfiguration)', 'Short headline label.'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ParamRow extends StatelessWidget {
  const _ParamRow(this.name, this.desc);
  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(name, style: _monoInk),
          ),
          Expanded(child: Text(desc, style: _body)),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — Sample classes
// =============================================================================

class _SampleClassesCard extends StatelessWidget {
  const _SampleClassesCard();

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('_File extends DiagnosticableTree', style: _label),
          const SizedBox(height: 6),
          _CodeBlock(lines: const <String>[
            'class _File extends DiagnosticableTree {',
            '  _File({required this.name, required this.bytes, this.readOnly = false});',
            '  final String name;',
            '  final int bytes;',
            '  final bool readOnly;',
            '',
            '  @override',
            '  void debugFillProperties(DiagnosticPropertiesBuilder p) {',
            '    super.debugFillProperties(p);',
            '    p.add(StringProperty(\'name\', name));',
            '    p.add(IntProperty(\'bytes\', bytes));',
            '    p.add(FlagProperty(\'readOnly\', value: readOnly,',
            '        ifTrue: \'read-only\', ifFalse: \'writable\'));',
            '  }',
            '}',
          ]),
          const SizedBox(height: 16),
          const Text('_Folder extends DiagnosticableTree', style: _label),
          const SizedBox(height: 6),
          _CodeBlock(lines: const <String>[
            'class _Folder extends DiagnosticableTree {',
            '  _Folder({required this.name, this.children = const <Object>[]});',
            '  final String name;',
            '  final List<Object> children;',
            '',
            '  @override',
            '  List<DiagnosticsNode> debugDescribeChildren() {',
            '    final out = <DiagnosticsNode>[];',
            '    for (int i = 0; i < children.length; i++) {',
            '      final c = children[i];',
            '      if (c is _File)   out.add(c.toDiagnosticsNode(name: \'file_\$i\'));',
            '      if (c is _Folder) out.add(c.toDiagnosticsNode(name: \'dir_\$i\'));',
            '    }',
            '    return out;',
            '  }',
            '}',
          ]),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Live walk
// =============================================================================

class _LiveWalkCard extends StatelessWidget {
  const _LiveWalkCard({required this.rootNode});

  final DiagnosticsNode rootNode;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Walk', style: _label),
          const SizedBox(height: 6),
          const Text(
            'The rootNode is a DiagnosticableTreeNode (when value is a '
            'DiagnosticableTree). Each call to getChildren() yields more '
            'DiagnosticsNode instances; getProperties() yields the leaves.',
            style: _body,
          ),
          const SizedBox(height: 14),
          _NodeCard(node: rootNode, depth: 0),
        ],
      ),
    );
  }
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({required this.node, required this.depth});

  final DiagnosticsNode? node;
  final int depth;

  @override
  Widget build(BuildContext context) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #14, P7):
    // The bridged DiagnosticsNode root / getChildren() / getProperties()
    // calls can return null values that the interpreter exposes even though
    // the static type is non-nullable. Make `node` nullable and bail out
    // early; defensively filter null list elements as well.
    final DiagnosticsNode? n = node;
    if (n == null) {
      return const SizedBox.shrink();
    }
    final List<DiagnosticsNode> kids = <DiagnosticsNode>[
      for (final DiagnosticsNode? c in n.getChildren())
        if (c != null) c,
    ];
    final List<DiagnosticsNode> props = <DiagnosticsNode>[
      for (final DiagnosticsNode? p in n.getProperties())
        if (p != null) p,
    ];
    final String label = n.name ?? '<unnamed>';
    final String desc = n.toDescription();
    return Padding(
      padding: EdgeInsets.only(left: depth * 16.0, top: 6, bottom: 6),
      child: Container(
        decoration: BoxDecoration(
          color: depth.isEven ? _paperAlt : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _line),
        ),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  kids.isEmpty ? Icons.description_outlined : Icons.folder_outlined,
                  size: 16,
                  color: kids.isEmpty ? _amber : _accent,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: _bodyStrong,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _accentTint,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    desc,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      color: _accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (props.isNotEmpty) ...<Widget>[
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: props
                    .map<Widget>((DiagnosticsNode p) => _PropPill(node: p))
                    .toList(),
              ),
            ],
            if (kids.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final DiagnosticsNode child in kids)
                    _NodeCard(node: child, depth: depth + 1),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _PropPill extends StatelessWidget {
  const _PropPill({required this.node});
  final DiagnosticsNode? node;

  @override
  Widget build(BuildContext context) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #14, P7):
    // DiagnosticsNode entries may surface as null in the interpreter even
    // when typed non-nullable. Bail out early on null.
    final DiagnosticsNode? n = node;
    if (n == null) {
      return const SizedBox.shrink();
    }
    final String label = n.name ?? '?';
    final String shown = n.toDescription();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _skyTint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _line),
      ),
      child: Text(
        '$label: $shown',
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: _sky,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — Style comparison
// =============================================================================

const List<_StyleSample> _styleSamples = <_StyleSample>[
  _StyleSample(
    style: 'dense',
    tint: _accent,
    summary: 'Minimal padding; one line per node where possible. Default for '
        'inline diagnostics in error messages.',
    snippet: 'Foo#a1b2(name: hi, retries: 3, sticky: false)\n'
        '\u2502\u2500\u2500 inner: Bar#c0ff(weight: 0.5)\n'
        '\u2514\u2500\u2500 child: Baz#dead(flag: on)',
  ),
  _StyleSample(
    style: 'sparse',
    tint: _sky,
    summary: 'Blank lines and full property labels. Standard inspector view; '
        'most readable for humans.',
    snippet: 'Foo#a1b2\n'
        '   name: hi\n'
        '   retries: 3\n'
        '   sticky: false\n'
        '   \u2502\n'
        '   \u2514\u2500\u2500 inner: Bar#c0ff',
  ),
  _StyleSample(
    style: 'offstage',
    tint: _amber,
    summary: 'Reserved for offstage subtrees. Their toStringDeep is included '
        'but the visual hierarchy is dimmed.',
    snippet: 'Offstage \u2192 Foo#a1b2\n'
        '              \u2514\u2500\u2500 inner: Bar#c0ff\n'
        '                     [offstage – not rendered]',
  ),
  _StyleSample(
    style: 'whitespace',
    tint: _mint,
    summary: 'Plain indentation only; no box-drawing glyphs. Useful when the '
        'consumer escapes Unicode (e.g. CSV).',
    snippet: 'Foo#a1b2\n'
        '  name: hi\n'
        '  inner: Bar#c0ff\n'
        '    weight: 0.5\n'
        '  child: Baz#dead',
  ),
];

class _StyleComparisonCard extends StatelessWidget {
  const _StyleComparisonCard();

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Each panel shows the same tree printed with a different '
            'DiagnosticsTreeStyle. Set on a node via its style property.',
            style: _body,
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.05,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: <Widget>[
              for (final _StyleSample s in _styleSamples) _StyleTile(sample: s),
            ],
          ),
        ],
      ),
    );
  }
}

class _StyleTile extends StatelessWidget {
  const _StyleTile({required this.sample});
  final _StyleSample sample;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _consoleBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: sample.tint,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  sample.style.toUpperCase(),
                  style: _tag,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            sample.summary,
            style: const TextStyle(
              color: _consoleDim,
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(sample.snippet, style: _mono),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — JSON viewer
// =============================================================================

class _JsonViewerCard extends StatelessWidget {
  const _JsonViewerCard({required this.rootNode});

  final DiagnosticsNode rootNode;

  @override
  Widget build(BuildContext context) {
    final List<String> lines = _flattenJson(rootNode, 0);
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'rootNode.toJsonMap(...) feeds the wire protocol used by DevTools. '
            'Below is a flattened view of the shape (depth-limited).',
            style: _body,
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: _consoleBg,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final String line in lines)
                  Text(line, style: _mono),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static List<String> _flattenJson(DiagnosticsNode? n, int depth) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #14, P7):
    // The bridged DiagnosticableTreeNode.getChildren() / .getProperties()
    // calls can return list entries that the interpreter exposes as null,
    // and the root rootNode itself may arrive null. Bail out, filter nulls
    // and null-guard member access on each entry.
    final String pad = '  ' * depth;
    final List<String> out = <String>[];
    if (n == null) {
      out.add('$pad{ "node": null }');
      return out;
    }
    out.add('$pad{');
    out.add('$pad  "name": "${n.name ?? ''}",');
    out.add('$pad  "description": "${n.toDescription()}",');
    out.add('$pad  "style": "${n.style?.toString().split('.').last ?? 'null'}",');
    final List<DiagnosticsNode> props = <DiagnosticsNode>[
      for (final DiagnosticsNode? p in n.getProperties())
        if (p != null) p,
    ];
    if (props.isNotEmpty) {
      out.add('$pad  "properties": [');
      for (int i = 0; i < props.length; i++) {
        final DiagnosticsNode p = props[i];
        final String comma = i == props.length - 1 ? '' : ',';
        out.add(
          '$pad    { "name": "${p.name ?? ''}", "value": "${p.toDescription()}" }$comma',
        );
      }
      out.add('$pad  ],');
    }
    final List<DiagnosticsNode> kids = <DiagnosticsNode>[
      for (final DiagnosticsNode? c in n.getChildren())
        if (c != null) c,
    ];
    if (kids.isNotEmpty && depth < 3) {
      out.add('$pad  "children": [');
      for (int i = 0; i < kids.length; i++) {
        out.addAll(_flattenJson(kids[i], depth + 2));
        if (i != kids.length - 1) {
          out[out.length - 1] = '${out[out.length - 1]},';
        }
      }
      out.add('$pad  ]');
    }
    out.add('$pad}');
    return out;
  }
}

// =============================================================================
// SECTION 7 — Property pipeline
// =============================================================================

class _PropertyPipelineCard extends StatelessWidget {
  const _PropertyPipelineCard();

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Each Diagnosticable supplies its properties through a callback. '
            'The framework allocates a builder, hands it in, and your override '
            'fills it. The same builder backs getProperties() on the node.',
            style: _body,
          ),
          const SizedBox(height: 12),
          _CodeBlock(lines: const <String>[
            'class _File extends DiagnosticableTree {',
            '  @override',
            '  void debugFillProperties(DiagnosticPropertiesBuilder p) {',
            '    super.debugFillProperties(p);',
            '    p.add(StringProperty(\'name\', name));',
            '    p.add(IntProperty(\'bytes\', bytes));',
            '    p.add(FlagProperty(\'readOnly\', value: readOnly,',
            '        ifTrue: \'read-only\', ifFalse: \'writable\'));',
            '  }',
            '}',
          ]),
          const SizedBox(height: 12),
          const _PipelineSteps(),
        ],
      ),
    );
  }
}

class _PipelineSteps extends StatelessWidget {
  const _PipelineSteps();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _paperAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _Step('1', 'value.toDiagnosticsNode(name: ...)', _accent),
          _Step('2', 'returns DiagnosticableTreeNode (subclass of DiagnosticsNode)', _accent),
          _Step('3', 'node.getProperties() calls debugFillProperties via builder', _sky),
          _Step('4', 'node.getChildren() calls debugDescribeChildren', _sky),
          _Step('5', 'inspector renders style + name + value + children', _mint),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step(this.idx, this.label, this.color);
  final String idx;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              idx,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: _body)),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — Recipes
// =============================================================================

const List<_RecipeSpec> _recipes = <_RecipeSpec>[
  _RecipeSpec(
    title: 'Expose a property',
    summary: 'Add a single typed property via the builder.',
    accent: _accent,
    code:
        '@override\n'
        'void debugFillProperties(DiagnosticPropertiesBuilder p) {\n'
        '  super.debugFillProperties(p);\n'
        '  p.add(StringProperty(\'label\', label));\n'
        '}',
  ),
  _RecipeSpec(
    title: 'Hide defaults',
    summary: 'Avoid noise by skipping the value when it matches the default.',
    accent: _sky,
    code:
        'p.add(IntProperty(\'retries\', retries,\n'
        '    defaultValue: 3,\n'
        '    level: DiagnosticLevel.fine));',
  ),
  _RecipeSpec(
    title: 'Add a flag',
    summary: 'Render true/false as semantically meaningful tokens.',
    accent: _mint,
    code:
        'p.add(FlagProperty(\'visible\',\n'
        '    value: visible,\n'
        '    ifTrue: \'shown\', ifFalse: \'hidden\'));',
  ),
  _RecipeSpec(
    title: 'Custom child slot',
    summary: 'Name the slot when adding to debugDescribeChildren.',
    accent: _amber,
    code:
        '@override\n'
        'List<DiagnosticsNode> debugDescribeChildren() {\n'
        '  return <DiagnosticsNode>[\n'
        '    inner.toDiagnosticsNode(name: \'inner\'),\n'
        '  ];\n'
        '}',
  ),
  _RecipeSpec(
    title: 'Skip a subtree',
    summary: 'Return DiagnosticsNode.message() to short-circuit recursion.',
    accent: _rose,
    code:
        'return <DiagnosticsNode>[\n'
        '  DiagnosticsNode.message(summary),\n'
        '];',
  ),
  _RecipeSpec(
    title: 'Override toStringShort',
    summary: 'Customise the headline shown in error messages.',
    accent: _accentAlt,
    code:
        '@override\n'
        'String toStringShort() => \'_Folder(\$name, \${children.length})\';',
  ),
  _RecipeSpec(
    title: 'Pick a style',
    summary: 'Force a tree style on a single node.',
    accent: _sky,
    code:
        'final DiagnosticsNode node = value.toDiagnosticsNode(\n'
        '  name: \'root\',\n'
        '  style: DiagnosticsTreeStyle.sparse,\n'
        ');',
  ),
  _RecipeSpec(
    title: 'Serialise to JSON',
    summary: 'Use toJsonMap to send the tree across a wire.',
    accent: _mint,
    code:
        'final Map<String, Object?> json = node.toJsonMap(\n'
        '  const DiagnosticsSerializationDelegate(\n'
        '    minLevel: DiagnosticLevel.fine,\n'
        '    subtreeDepth: 4,\n'
        '  ),\n'
        ');',
  ),
];

class _RecipeGrid extends StatelessWidget {
  const _RecipeGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.0,
      children: <Widget>[
        for (final _RecipeSpec r in _recipes) _RecipeTile(spec: r),
      ],
    );
  }
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile({required this.spec});
  final _RecipeSpec spec;

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: spec.accent,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text('RECIPE', style: _tag),
          ),
          const SizedBox(height: 8),
          Text(
            spec.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: _ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(spec.summary, style: _body),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _consoleBg,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Text(spec.code, style: _mono),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 9 — Comparison matrix
// =============================================================================

const List<_MatrixRow> _matrixRows = <_MatrixRow>[
  _MatrixRow('Wraps', 'DiagnosticableTree', 'Any Diagnosticable or none', 'A single typed value'),
  _MatrixRow('Has children', 'Yes (debugDescribeChildren)', 'Sometimes', 'No (leaf node)'),
  _MatrixRow('Returns properties', 'Yes (via builder)', 'Sometimes', 'Returns its own value'),
  _MatrixRow('Typical use', 'Widget / Element / RenderObject', 'Inspector roots, summaries', 'Properties on Diagnosticable'),
  _MatrixRow('toStringDeep', 'Full recursive tree', 'Recursive if children', 'Single-line value'),
  _MatrixRow('Created via', 'toDiagnosticsNode()', 'manual construction', 'StringProperty / IntProperty / ...'),
  _MatrixRow('JSON shape', 'Includes children array', 'Children when present', 'Leaf object'),
];

class _ComparisonMatrix extends StatelessWidget {
  const _ComparisonMatrix();

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(flex: 3, child: Text('Trait', style: _label)),
              Expanded(flex: 4, child: Text('DiagnosticableTreeNode', style: _label)),
              Expanded(flex: 4, child: Text('DiagnosticsNode', style: _label)),
              Expanded(flex: 4, child: Text('DiagnosticsProperty<T>', style: _label)),
            ],
          ),
          const SizedBox(height: 6),
          const Divider(color: _line, height: 1),
          for (final _MatrixRow row in _matrixRows) _MatrixCellRow(row: row),
        ],
      ),
    );
  }
}

class _MatrixCellRow extends StatelessWidget {
  const _MatrixCellRow({required this.row});
  final _MatrixRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 3, child: Text(row.label, style: _bodyStrong)),
          Expanded(flex: 4, child: Text(row.node, style: _body)),
          Expanded(flex: 4, child: Text(row.diag, style: _body)),
          Expanded(flex: 4, child: Text(row.prop, style: _body)),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 10 — Glossary
// =============================================================================

const List<_GlossaryEntry> _glossary = <_GlossaryEntry>[
  _GlossaryEntry(
    'Diagnosticable',
    'Mixin/interface that lets an object expose properties.',
  ),
  _GlossaryEntry(
    'DiagnosticableTree',
    'Subclass of Diagnosticable that can also produce children.',
  ),
  _GlossaryEntry(
    'DiagnosticsNode',
    'Abstract base of every node in the diagnostics tree.',
  ),
  _GlossaryEntry(
    'DiagnosticableNode<T>',
    'Concrete node wrapping any Diagnosticable value.',
  ),
  _GlossaryEntry(
    'DiagnosticableTreeNode',
    'Concrete node wrapping a DiagnosticableTree; this file\'s subject.',
  ),
  _GlossaryEntry(
    'DiagnosticPropertiesBuilder',
    'Mutable buffer that collects property nodes.',
  ),
  _GlossaryEntry(
    'DiagnosticsTreeStyle',
    'Enum describing layout/visibility of the rendered tree.',
  ),
  _GlossaryEntry(
    'getProperties()',
    'Returns the leaf property list collected by debugFillProperties.',
  ),
  _GlossaryEntry(
    'getChildren()',
    'Returns the structural child nodes (next level).',
  ),
  _GlossaryEntry(
    'toStringDeep',
    'Renders the entire subtree as an indented ASCII string.',
  ),
];

class _GlossaryGrid extends StatelessWidget {
  const _GlossaryGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.4,
      children: <Widget>[
        for (final _GlossaryEntry g in _glossary) _GlossaryCard(entry: g),
      ],
    );
  }
}

class _GlossaryCard extends StatelessWidget {
  const _GlossaryCard({required this.entry});
  final _GlossaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(entry.term, style: _monoInk),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              entry.gloss,
              style: _monoSmall,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 11 — Final card & footer
// =============================================================================

class _FinalCard extends StatelessWidget {
  const _FinalCard();

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'The widget you are scrolling through is itself the value returned '
            'by build(BuildContext). Every Card, Column, and Text below this '
            'string would, if it inherited DiagnosticableTree directly, '
            'produce its own DiagnosticableTreeNode upon toDiagnosticsNode().',
            style: _body,
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: _accentTint,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(12),
            child: const Text(
              'return MaterialApp(\n'
              '  home: Scaffold(\n'
              '    body: SingleChildScrollView(\n'
              '      child: Column(children: <Widget>[ ... 11 sections ... ]),\n'
              '    ),\n'
              '  ),\n'
              ');',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _accent,
                height: 1.45,
              ),
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
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Center(
        child: Text(
          'D4rt visual demo  •  package:flutter/foundation.dart  •  DiagnosticableTreeNode',
          style: TextStyle(
            color: _inkMute,
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Shared surface card and code block
// =============================================================================

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _line),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A101828),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.lines});
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _consoleBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final String line in lines) Text(line, style: _mono),
        ],
      ),
    );
  }
}
