// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// summary_test.dart
// =============================================================================
// Visual deep demo: Flutter "summary" rendering.
//
// This file is a hand-crafted, analyzer-free tour of how Flutter renders short,
// single-line "summary" representations of widgets, elements and render objects
// throughout DevTools, the Inspector, and error messages. It contrasts deep
// renderings (`toStringDeep`) with the much shorter `singleLine`/`shallow`
// styles used as compact summaries.
//
// Topics covered (>= 9 sections):
//   1. Hero panel: stylized "tree → summary line" graphic.
//   2. Why summaries matter (DevTools, error messages, profile mode).
//   3. DiagnosticsTreeStyle.singleLine: deep tree vs single-line summary.
//   4. DiagnosticsTreeStyle.shallow: deep tree vs shallow summary.
//   5. truncateChildren: pre/post truncation table.
//   6. Console panel: 6 sample "summary" strings.
//   7. Anatomy of a summary: type-name, hash short, key fields.
//   8. DiagnosticPropertiesBuilder.add(...): order matters.
//   9. Diagnosticable.toStringShort()/toStringShallow() panel.
//   10. Pitfalls (don't include heavy state; truncate Iterables).
//   11. Footer.
//
// All construction is synchronous, no controllers, no async, no setState.
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// SECTION 0: shared palette and tiny utility helpers.
// -----------------------------------------------------------------------------

const Color _privateBg = Color(0xFF0F1320);
const Color _privateSurface = Color(0xFF182039);
const Color _privateSurface2 = Color(0xFF202A48);
const Color _privateAccent = Color(0xFF6CC2FF);
const Color _privateAccent2 = Color(0xFFFFC371);
const Color _privateAccent3 = Color(0xFFB39CFF);
const Color _privateAccent4 = Color(0xFF4ADEAD);
const Color _privateText = Color(0xFFE7ECF7);
const Color _privateMuted = Color(0xFF8B95B7);
const Color _privateError = Color(0xFFFF7E8A);

TextStyle _privateMono({double size = 12.5, Color? color, FontWeight? w}) {
  return TextStyle(
    fontFamily: 'monospace',
    fontSize: size,
    color: color ?? _privateText,
    fontWeight: w ?? FontWeight.w400,
    height: 1.35,
  );
}

TextStyle _privateSans({double size = 13, Color? color, FontWeight? w}) {
  return TextStyle(
    fontSize: size,
    color: color ?? _privateText,
    fontWeight: w ?? FontWeight.w400,
    height: 1.35,
  );
}

BoxDecoration _privatePanelDeco({Color? color, Color? border}) {
  return BoxDecoration(
    color: color ?? _privateSurface,
    border: Border.all(color: border ?? _privateSurface2, width: 1),
    borderRadius: BorderRadius.circular(10),
  );
}

// -----------------------------------------------------------------------------
// SECTION 0.1: tiny "summary record" data classes.
// These are PURE DATA — no Flutter widgets here.
// -----------------------------------------------------------------------------

class _PrivateSummaryRecord {
  final String typeName;
  final String hashShort;
  final List<_PrivateSummaryField> fields;

  const _PrivateSummaryRecord({
    required this.typeName,
    required this.hashShort,
    required this.fields,
  });

  String renderSingleLine({int? maxLen}) {
    final buf = StringBuffer();
    buf.write(typeName);
    buf.write('#');
    buf.write(hashShort);
    if (fields.isNotEmpty) {
      buf.write('(');
      for (var i = 0; i < fields.length; i++) {
        if (i > 0) buf.write(', ');
        buf.write(fields[i].renderInline());
      }
      buf.write(')');
    }
    final s = buf.toString();
    if (maxLen != null && s.length > maxLen) {
      return '${s.substring(0, maxLen - 1)}…';
    }
    return s;
  }
}

class _PrivateSummaryField {
  final String name;
  final String value;
  final bool isKey;

  const _PrivateSummaryField({
    required this.name,
    required this.value,
    this.isKey = false,
  });

  String renderInline() {
    if (name.isEmpty) return value;
    return '$name: $value';
  }
}

// -----------------------------------------------------------------------------
// SECTION 0.2: tiny tree node data class for our fake widget trees.
// -----------------------------------------------------------------------------

class _PrivateTreeNode {
  final String name;
  final String? hash;
  final List<_PrivateSummaryField> props;
  final List<_PrivateTreeNode> children;

  const _PrivateTreeNode({
    required this.name,
    this.hash,
    this.props = const [],
    this.children = const [],
  });
}

// -----------------------------------------------------------------------------
// SECTION 0.3: tree → text renderers (deep vs shallow vs singleLine).
// -----------------------------------------------------------------------------

String _privateRenderDeep(_PrivateTreeNode node, {String prefix = ''}) {
  final buf = StringBuffer();
  buf.write(_privateRenderHead(node));
  if (node.children.isEmpty) {
    return buf.toString();
  }
  buf.writeln();
  for (var i = 0; i < node.children.length; i++) {
    final isLast = i == node.children.length - 1;
    final connector = isLast ? '└─ ' : '├─ ';
    final indent = isLast ? '   ' : '│  ';
    final child = node.children[i];
    buf.write('$prefix$connector');
    buf.write(_privateRenderDeep(child, prefix: '$prefix$indent'));
    if (!isLast || child.children.isNotEmpty) buf.writeln();
  }
  return buf.toString().trimRight();
}

String _privateRenderShallow(_PrivateTreeNode node) {
  final buf = StringBuffer();
  buf.write(_privateRenderHead(node));
  if (node.children.isNotEmpty) {
    buf.write(' [+${node.children.length} children]');
  }
  return buf.toString();
}

String _privateRenderSingleLine(_PrivateTreeNode node, {int? maxLen}) {
  final s = _privateRenderHead(node);
  if (maxLen != null && s.length > maxLen) {
    return '${s.substring(0, maxLen - 1)}…';
  }
  return s;
}

String _privateRenderHead(_PrivateTreeNode node) {
  final buf = StringBuffer();
  buf.write(node.name);
  if (node.hash != null) {
    buf.write('#');
    buf.write(node.hash);
  }
  if (node.props.isNotEmpty) {
    buf.write('(');
    for (var i = 0; i < node.props.length; i++) {
      if (i > 0) buf.write(', ');
      buf.write(node.props[i].renderInline());
    }
    buf.write(')');
  }
  return buf.toString();
}

// -----------------------------------------------------------------------------
// SECTION 0.4: a small "fake" widget tree used in multiple sections below.
// -----------------------------------------------------------------------------

_PrivateTreeNode _privateBuildFakeTree() {
  return _PrivateTreeNode(
    name: 'Container',
    hash: 'a3b21',
    props: const [
      _PrivateSummaryField(
        name: 'constraints',
        value: 'BoxConstraints(0.0<=w<=320.0, 0.0<=h<=240.0)',
      ),
      _PrivateSummaryField(name: 'color', value: 'Color(0xff202a48)'),
    ],
    children: const [
      _PrivateTreeNode(
        name: 'Padding',
        hash: '7c1f0',
        props: [
          _PrivateSummaryField(
            name: 'padding',
            value: 'EdgeInsets.all(12.0)',
          ),
        ],
        children: [
          _PrivateTreeNode(
            name: 'Column',
            hash: '99a8e',
            props: [
              _PrivateSummaryField(
                name: 'mainAxisAlignment',
                value: 'start',
              ),
              _PrivateSummaryField(
                name: 'crossAxisAlignment',
                value: 'stretch',
              ),
            ],
            children: [
              _PrivateTreeNode(
                name: 'Text',
                hash: '4dd33',
                props: [
                  _PrivateSummaryField(name: '', value: '"Hello"'),
                  _PrivateSummaryField(
                    name: 'softWrap',
                    value: 'true',
                  ),
                ],
              ),
              _PrivateTreeNode(
                name: 'Text',
                hash: 'b1188',
                props: [
                  _PrivateSummaryField(
                    name: '',
                    value: '"World, this is a deeper render."',
                  ),
                ],
              ),
              _PrivateTreeNode(
                name: 'Spacer',
                hash: '0e2a4',
              ),
            ],
          ),
        ],
      ),
      _PrivateTreeNode(
        name: 'Positioned',
        hash: '2a771',
        props: [
          _PrivateSummaryField(name: 'top', value: '8.0'),
          _PrivateSummaryField(name: 'right', value: '8.0'),
        ],
        children: [
          _PrivateTreeNode(
            name: 'Icon',
            hash: 'f00ba',
            props: [
              _PrivateSummaryField(name: '', value: 'Icons.close'),
              _PrivateSummaryField(name: 'size', value: '16.0'),
            ],
          ),
        ],
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// SECTION 0.5: predefined summary records (used in console + anatomy panels).
// -----------------------------------------------------------------------------

const List<_PrivateSummaryRecord> _privateSampleSummaries = [
  _PrivateSummaryRecord(
    typeName: 'Container',
    hashShort: 'a3b21',
    fields: [
      _PrivateSummaryField(
        name: 'constraints',
        value: 'BoxConstraints(0.0<=w<=100.0, 0.0<=h<=…)',
      ),
      _PrivateSummaryField(name: 'color', value: 'Color(0xff202a48)'),
    ],
  ),
  _PrivateSummaryRecord(
    typeName: 'RenderParagraph',
    hashShort: '7c1f0',
    fields: [
      _PrivateSummaryField(
        name: 'text',
        value: 'TextSpan("Hello, world!", style: …)',
      ),
      _PrivateSummaryField(name: 'softWrap', value: 'true'),
    ],
  ),
  _PrivateSummaryRecord(
    typeName: 'StatelessElement',
    hashShort: '4dd33',
    fields: [
      _PrivateSummaryField(name: 'widget', value: 'MyHeader#bb44e', isKey: true),
      _PrivateSummaryField(name: 'depth', value: '7'),
    ],
  ),
  _PrivateSummaryRecord(
    typeName: 'RenderFlex',
    hashShort: '99a8e',
    fields: [
      _PrivateSummaryField(name: 'direction', value: 'vertical'),
      _PrivateSummaryField(name: 'mainAxisAlignment', value: 'start'),
      _PrivateSummaryField(name: 'crossAxisAlignment', value: 'stretch'),
      _PrivateSummaryField(name: 'children', value: '[3 widgets]'),
    ],
  ),
  _PrivateSummaryRecord(
    typeName: 'KeyedSubtree',
    hashShort: '2a771',
    fields: [
      _PrivateSummaryField(
        name: 'key',
        value: '<ValueKey<String>("hero")>',
        isKey: true,
      ),
      _PrivateSummaryField(name: 'child', value: 'Hero#f00ba'),
    ],
  ),
  _PrivateSummaryRecord(
    typeName: 'StatefulElement',
    hashShort: 'b1188',
    fields: [
      _PrivateSummaryField(name: 'widget', value: 'MyForm#0e2a4', isKey: true),
      _PrivateSummaryField(name: 'state', value: '_MyFormState#3210d'),
      _PrivateSummaryField(name: 'dirty', value: 'false'),
    ],
  ),
];

// -----------------------------------------------------------------------------
// SECTION 0.6: simple "section card" wrapper used everywhere.
// -----------------------------------------------------------------------------

Widget _privateSectionCard({
  required String title,
  required String subtitle,
  required Widget body,
  Color? accent,
}) {
  final acc = accent ?? _privateAccent;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: _privatePanelDeco(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 22,
              decoration: BoxDecoration(
                color: acc,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: _privateSans(size: 15, w: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            subtitle,
            style: _privateSans(size: 12.5, color: _privateMuted),
          ),
        ),
        const SizedBox(height: 12),
        body,
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 1: hero — stylized "tree → summary line" graphic.
// -----------------------------------------------------------------------------

Widget _privateBuildHero() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 6),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _privateSurface2,
          _privateSurface,
          Color(0xFF0B0F1A),
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _privateAccent.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Flutter Summary Rendering',
          style: _privateSans(size: 22, w: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'How Flutter turns deep trees into one-line summaries',
          style: _privateSans(size: 13.5, color: _privateMuted),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: _privateHeroTreeBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Icon(Icons.arrow_forward,
                      color: _privateAccent, size: 32),
                  const SizedBox(height: 4),
                  Text(
                    'singleLine',
                    style: _privateMono(size: 11, color: _privateAccent),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: _privateHeroSummaryBox(),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateHeroTreeBox() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: _privatePanelDeco(color: Color(0xFF0C1124)),
    child: Text(
      'Container#a3b21\n'
      '├─ Padding#7c1f0\n'
      '│   └─ Column#99a8e\n'
      '│       ├─ Text#4dd33("Hello")\n'
      '│       ├─ Text#b1188("World")\n'
      '│       └─ Spacer#0e2a4\n'
      '└─ Positioned#2a771\n'
      '    └─ Icon#f00ba(Icons.close)',
      style: _privateMono(size: 12, color: _privateAccent2),
    ),
  );
}

Widget _privateHeroSummaryBox() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: _privatePanelDeco(color: Color(0xFF0C1124)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('singleLine summary',
            style: _privateMono(size: 11, color: _privateMuted)),
        const SizedBox(height: 6),
        Text(
          'Container#a3b21(constraints: '
          'BoxConstraints(0.0<=w<=320.0, …), color: Color(0xff202a48))',
          style: _privateMono(size: 12, color: _privateAccent4),
        ),
        const SizedBox(height: 10),
        Text('shallow summary',
            style: _privateMono(size: 11, color: _privateMuted)),
        const SizedBox(height: 6),
        Text(
          'Container#a3b21 [+2 children]',
          style: _privateMono(size: 12, color: _privateAccent3),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 2: intro card — why summaries matter.
// -----------------------------------------------------------------------------

// Reference a foundation-only symbol so the foundation import is required.
final bool _privateInReleaseMode = kReleaseMode;
final TargetPlatform _privateHostPlatform = defaultTargetPlatform;

Widget _privateBuildIntroCard() {
  final platformNote =
      'host=${_privateHostPlatform.name}, release=$_privateInReleaseMode';
  final reasons = <List<String>>[
    [
      'DevTools',
      'The Flutter Inspector renders one summary line per tree node so '
          'thousands of nodes can be scrolled smoothly.',
    ],
    [
      'Error messages',
      'When the framework throws a FlutterError, it shows summary lines for '
          'each frame of the widget tree to keep the report readable.',
    ],
    [
      'Profile mode',
      'In profile/release builds, deep tree dumps are disabled; only summary '
          'strings remain for diagnostic logs.',
    ],
    [
      'IDE hovers',
      'Tooling such as the VS Code Flutter extension calls toStringShort() to '
          'show a compact preview of an Element under the cursor.',
    ],
  ];
  return _privateSectionCard(
    title: '1. Why summaries matter',
    subtitle:
        'Single-line summaries keep tooling responsive and human readable.',
    accent: _privateAccent,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final r in reasons)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5, right: 10),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _privateAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: _privateSans(size: 13),
                      children: [
                        TextSpan(
                          text: '${r[0]}. ',
                          style: _privateSans(
                              size: 13,
                              w: FontWeight.w700,
                              color: _privateAccent),
                        ),
                        TextSpan(text: r[1]),
                      ],
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
// SECTION 3: DiagnosticsTreeStyle.singleLine — deep vs single line.
// -----------------------------------------------------------------------------

Widget _privateBuildSingleLineSection() {
  final tree = _privateBuildFakeTree();
  final deep = _privateRenderDeep(tree);
  final single = _privateRenderSingleLine(tree);
  return _privateSectionCard(
    title: '2. DiagnosticsTreeStyle.singleLine',
    subtitle:
        'Compare a full toStringDeep dump with the singleLine variant of the '
        'same root node.',
    accent: _privateAccent4,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _privateLabelledCode(
            label: 'toStringDeep()',
            code: deep,
            color: _privateAccent2,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 5,
          child: _privateLabelledCode(
            label: 'toString(minLevel: info, style: singleLine)',
            code: single,
            color: _privateAccent4,
          ),
        ),
      ],
    ),
  );
}

Widget _privateLabelledCode({
  required String label,
  required String code,
  Color? color,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: _privatePanelDeco(color: Color(0xFF0C1124)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: _privateMono(size: 11, color: _privateMuted),
        ),
        const SizedBox(height: 6),
        SelectableText(
          code,
          style: _privateMono(size: 12, color: color ?? _privateText),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 4: DiagnosticsTreeStyle.shallow.
// -----------------------------------------------------------------------------

Widget _privateBuildShallowSection() {
  final tree = _privateBuildFakeTree();
  final deep = _privateRenderDeep(tree);
  final shallow = _privateRenderShallow(tree);
  final shallowChildren = StringBuffer();
  for (final child in tree.children) {
    shallowChildren.writeln('  • ${_privateRenderShallow(child)}');
  }
  return _privateSectionCard(
    title: '3. DiagnosticsTreeStyle.shallow',
    subtitle:
        'Shallow shows the node and a hint about its children, but does not '
        'recurse into them.',
    accent: _privateAccent3,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: _privateLabelledCode(
                label: 'toStringDeep()',
                code: deep,
                color: _privateAccent2,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 5,
              child: _privateLabelledCode(
                label: 'toStringShallow()',
                code: shallow,
                color: _privateAccent3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _privateLabelledCode(
          label: 'shallow on each top-level child',
          code: shallowChildren.toString().trimRight(),
          color: _privateAccent3,
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 5: truncateChildren — pre/post truncation table.
// -----------------------------------------------------------------------------

class _PrivateTruncateRow {
  final String label;
  final List<String> children;
  final int truncateAt;

  const _PrivateTruncateRow({
    required this.label,
    required this.children,
    required this.truncateAt,
  });
}

Widget _privateBuildTruncateChildrenSection() {
  final rows = <_PrivateTruncateRow>[
    _PrivateTruncateRow(
      label: 'small list',
      children: [
        'Text#001',
        'Text#002',
      ],
      truncateAt: 5,
    ),
    _PrivateTruncateRow(
      label: 'mid list',
      children: [
        'Text#001',
        'Text#002',
        'Text#003',
        'Text#004',
        'Text#005',
        'Text#006',
        'Text#007',
      ],
      truncateAt: 5,
    ),
    _PrivateTruncateRow(
      label: 'big list',
      children: [
        'ListItem#0',
        'ListItem#1',
        'ListItem#2',
        'ListItem#3',
        'ListItem#4',
        'ListItem#5',
        'ListItem#6',
        'ListItem#7',
        'ListItem#8',
        'ListItem#9',
        'ListItem#10',
        'ListItem#11',
      ],
      truncateAt: 5,
    ),
    _PrivateTruncateRow(
      label: 'huge list',
      children: [
        for (var i = 0; i < 32; i++) 'Tile#${i.toRadixString(16)}',
      ],
      truncateAt: 5,
    ),
  ];

  return _privateSectionCard(
    title: '4. truncateChildren in DiagnosticsNode',
    subtitle:
        'When a tree has many children, the diagnostics framework caps the '
        'displayed count to keep summaries readable.',
    accent: _privateAccent2,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _privateTruncateHeader(),
        const SizedBox(height: 4),
        for (final row in rows) ...[
          _privateTruncateRowWidget(row),
          const SizedBox(height: 4),
        ],
      ],
    ),
  );
}

Widget _privateTruncateHeader() {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Text('Tree shape',
            style: _privateMono(size: 11, color: _privateMuted)),
      ),
      Expanded(
        flex: 5,
        child: Text('Pre-truncation',
            style: _privateMono(size: 11, color: _privateMuted)),
      ),
      Expanded(
        flex: 4,
        child: Text('Post-truncation (cap=5)',
            style: _privateMono(size: 11, color: _privateMuted)),
      ),
    ],
  );
}

Widget _privateTruncateRowWidget(_PrivateTruncateRow row) {
  final pre = row.children.join(', ');
  final shown = row.children.take(row.truncateAt).toList();
  final more = row.children.length - shown.length;
  final post = more > 0
      ? '${shown.join(', ')}, …(+$more more)'
      : shown.join(', ');
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: Color(0xFF0E1428),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '${row.label}\n(${row.children.length})',
            style: _privateMono(size: 11.5, color: _privateAccent2),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            pre,
            style: _privateMono(size: 11.5),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            post,
            style: _privateMono(size: 11.5, color: _privateAccent4),
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 6: console panel — six sample summary strings.
// -----------------------------------------------------------------------------

Widget _privateBuildConsoleSection() {
  return _privateSectionCard(
    title: '5. Console: 6 sample summary strings',
    subtitle:
        'These are the kinds of one-line summaries the inspector shows when '
        'you hover or expand a diagnostic node.',
    accent: _privateAccent,
    body: Container(
      padding: const EdgeInsets.all(14),
      decoration: _privatePanelDeco(color: Color(0xFF06091A)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < _privateSampleSummaries.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _privateConsoleLine(
                index: i + 1,
                summary: _privateSampleSummaries[i],
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _privateConsoleLine({
  required int index,
  required _PrivateSummaryRecord summary,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 26,
        child: Text(
          '${index.toString().padLeft(2)}',
          style: _privateMono(size: 12, color: _privateMuted),
        ),
      ),
      Expanded(
        child: SelectableText(
          summary.renderSingleLine(maxLen: 96),
          style: _privateMono(size: 12.5, color: _privateAccent4),
        ),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// SECTION 7: anatomy of a sample summary — type, hash, key fields.
// -----------------------------------------------------------------------------

Widget _privateBuildAnatomySection() {
  final sample = _privateSampleSummaries[0]; // Container
  final raw = sample.renderSingleLine();
  return _privateSectionCard(
    title: '6. Anatomy of a summary',
    subtitle:
        'A single line breaks down into a type-name, a short hash, and a '
        'comma-separated list of "key" properties.',
    accent: _privateAccent3,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: _privatePanelDeco(color: Color(0xFF0C1124)),
          child: SelectableText(
            raw,
            style: _privateMono(size: 13, color: _privateAccent2),
          ),
        ),
        const SizedBox(height: 12),
        _privateAnatomyTable(sample),
      ],
    ),
  );
}

Widget _privateAnatomyTable(_PrivateSummaryRecord sample) {
  final rows = <List<String>>[
    [
      'Type name',
      sample.typeName,
      'Result of runtimeType.toString(); the public class name for '
          'Diagnosticable.',
    ],
    [
      'Hash short',
      '#${sample.hashShort}',
      'shortHash(this) of identityHashCode — disambiguates instances.',
    ],
    for (final f in sample.fields)
      [
        f.isKey ? '★ ${f.name}' : f.name,
        f.value,
        f.isKey
            ? 'Marked as a "key" property — appears in summary by default.'
            : 'Plain property — included because order says so.',
      ],
  ];
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Part',
                style: _privateMono(size: 11, color: _privateMuted)),
          ),
          Expanded(
            flex: 4,
            child: Text('Value',
                style: _privateMono(size: 11, color: _privateMuted)),
          ),
          Expanded(
            flex: 5,
            child: Text('Origin',
                style: _privateMono(size: 11, color: _privateMuted)),
          ),
        ],
      ),
      const SizedBox(height: 4),
      for (var i = 0; i < rows.length; i++)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: i.isEven ? Color(0xFF0E1428) : Color(0xFF11182F),
            borderRadius: BorderRadius.circular(4),
          ),
          margin: const EdgeInsets.only(bottom: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(rows[i][0],
                    style: _privateMono(size: 12, color: _privateAccent3)),
              ),
              Expanded(
                flex: 4,
                child: Text(rows[i][1], style: _privateMono(size: 12)),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  rows[i][2],
                  style: _privateSans(size: 12, color: _privateMuted),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

// -----------------------------------------------------------------------------
// SECTION 8: DiagnosticPropertiesBuilder.add(...) — order matters.
// -----------------------------------------------------------------------------

Widget _privateBuildAddOrderSection() {
  const recipe = '''
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  super.debugFillProperties(properties);
  // Order in this method = order in the summary line.
  properties.add(StringProperty('label', label, showName: true));
  properties.add(IntProperty('itemCount', itemCount));
  properties.add(EnumProperty<Axis>('direction', direction));
  properties.add(DiagnosticsProperty<Color>('background', background));
  properties.add(FlagProperty(
    'isPinned',
    value: isPinned,
    ifTrue: 'pinned',
    ifFalse: 'scrollable',
  ));
}
''';

  const summaryBefore =
      'MyHeader#bb44e(label: "Inbox", itemCount: 12, direction: vertical, '
      'background: Color(0xff202a48), pinned)';

  const summaryReordered =
      'MyHeader#bb44e(direction: vertical, label: "Inbox", '
      'background: Color(0xff202a48), itemCount: 12, scrollable)';

  return _privateSectionCard(
    title: '7. DiagnosticPropertiesBuilder.add(...) — order matters',
    subtitle:
        'The sequence of add() calls in debugFillProperties determines the '
        'order of fields in the resulting summary line.',
    accent: _privateAccent2,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _privateLabelledCode(
          label: 'recipe',
          code: recipe.trim(),
          color: _privateAccent2,
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateLabelledCode(
                label: 'summary (default order)',
                code: summaryBefore,
                color: _privateAccent4,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _privateLabelledCode(
                label: 'summary (reordered add() calls)',
                code: summaryReordered,
                color: _privateAccent3,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 9: Diagnosticable.toStringShort() / toStringShallow() panel.
// -----------------------------------------------------------------------------

class _PrivateDiagnosticableExample {
  final String label;
  final String description;
  final String toStringShort;
  final String toStringShallow;
  final String toStringDeepFirstLines;

  const _PrivateDiagnosticableExample({
    required this.label,
    required this.description,
    required this.toStringShort,
    required this.toStringShallow,
    required this.toStringDeepFirstLines,
  });
}

Widget _privateBuildDiagnosticableSection() {
  final examples = const [
    _PrivateDiagnosticableExample(
      label: 'RenderBox',
      description:
          'A simple render box; toStringShort just returns the type name and '
          'a hash.',
      toStringShort: 'RenderConstrainedBox#a3b21',
      toStringShallow:
          'RenderConstrainedBox#a3b21(needsCompositing, additionalConstraints: '
          'BoxConstraints(0.0<=w<=320.0, 0.0<=h<=240.0))',
      toStringDeepFirstLines:
          'RenderConstrainedBox#a3b21\n'
          ' │ creator: ConstrainedBox ← Padding ← Column ← …\n'
          ' │ parentData: <none>\n'
          ' │ constraints: BoxConstraints(0.0<=w<=320.0, 0.0<=h<=240.0)\n'
          ' │ size: Size(320.0, 240.0)\n'
          ' │ additionalConstraints: BoxConstraints(0.0<=w<=320.0, …)\n'
          ' └─child: RenderPadding#7c1f0\n'
          '     │ creator: Padding ← Column ← …',
    ),
    _PrivateDiagnosticableExample(
      label: 'Element',
      description:
          'An Element prints its widget reference; the short form is great '
          'for IDE hovers.',
      toStringShort: 'StatelessElement#4dd33',
      toStringShallow:
          'StatelessElement#4dd33(widget: MyHeader#bb44e, depth: 7)',
      toStringDeepFirstLines:
          'StatelessElement#4dd33\n'
          ' │ widget: MyHeader#bb44e\n'
          ' │ depth: 7\n'
          ' │ dirty: false\n'
          ' └─child: SingleChildRenderObjectElement#7c1f0',
    ),
    _PrivateDiagnosticableExample(
      label: 'Widget',
      description:
          'Widgets default to type-only short strings unless they override '
          'debugFillProperties.',
      toStringShort: 'MyHeader',
      toStringShallow:
          'MyHeader(label: "Inbox", itemCount: 12, direction: vertical)',
      toStringDeepFirstLines:
          'MyHeader\n'
          ' │ label: "Inbox"\n'
          ' │ itemCount: 12\n'
          ' │ direction: vertical\n'
          ' │ background: Color(0xff202a48)\n'
          ' │ pinned\n'
          ' └─(no children at widget level)',
    ),
  ];
  return _privateSectionCard(
    title: '8. toStringShort / toStringShallow / toStringDeep',
    subtitle:
        'Three layers of detail. Pick the shortest one the consumer can use.',
    accent: _privateAccent4,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final ex in examples) ...[
          _privateDiagnosticableExample(ex),
          const SizedBox(height: 10),
        ],
      ],
    ),
  );
}

Widget _privateDiagnosticableExample(_PrivateDiagnosticableExample ex) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: _privatePanelDeco(color: Color(0xFF0E1428)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _privateAccent4.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(ex.label,
                  style: _privateMono(size: 11.5, color: _privateAccent4)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                ex.description,
                style: _privateSans(size: 12, color: _privateMuted),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('toStringShort()',
            style: _privateMono(size: 10.5, color: _privateMuted)),
        SelectableText(ex.toStringShort,
            style: _privateMono(size: 12, color: _privateAccent2)),
        const SizedBox(height: 6),
        Text('toStringShallow()',
            style: _privateMono(size: 10.5, color: _privateMuted)),
        SelectableText(ex.toStringShallow,
            style: _privateMono(size: 12, color: _privateAccent3)),
        const SizedBox(height: 6),
        Text('toStringDeep() (first lines)',
            style: _privateMono(size: 10.5, color: _privateMuted)),
        SelectableText(ex.toStringDeepFirstLines,
            style: _privateMono(size: 12, color: _privateText)),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 10: pitfalls — anti-patterns when writing summaries.
// -----------------------------------------------------------------------------

class _PrivatePitfall {
  final String name;
  final String bad;
  final String good;
  final String explanation;

  const _PrivatePitfall({
    required this.name,
    required this.bad,
    required this.good,
    required this.explanation,
  });
}

Widget _privateBuildPitfallsSection() {
  final pitfalls = const [
    _PrivatePitfall(
      name: 'Don\'t include heavy state in summary',
      bad: 'MyForm#bb44e(formState: {field1: "...", field2: <huge map>, …})',
      good: 'MyForm#bb44e(fields: 12, dirty: false)',
      explanation:
          'A summary line is read by tooling thousands of times per second. '
          'Never serialize big collections eagerly.',
    ),
    _PrivatePitfall(
      name: 'Truncate long Iterables',
      bad: 'TodoList#7c1f0(items: [Todo("..."), Todo("..."), … 10000 more])',
      good: 'TodoList#7c1f0(itemCount: 10000, head: 3)',
      explanation:
          'Use IterableProperty or write your own bounded summary. Otherwise '
          'a single hover can copy 10MB to the clipboard.',
    ),
    _PrivatePitfall(
      name: 'Avoid nested DiagnosticsNode dumps',
      bad: 'Outer#a3b21(child: <Inner.toStringDeep multi-line dump>)',
      good: 'Outer#a3b21(child: Inner#7c1f0)',
      explanation:
          'Use DiagnosticsProperty<Diagnosticable> with the singleLine style; '
          'never embed a deep dump in a parent\'s summary.',
    ),
    _PrivatePitfall(
      name: 'Quote strings, redact secrets',
      bad: 'AuthHeader#0e2a4(token: eyJhbGciOiJI…big.secret.string)',
      good: 'AuthHeader#0e2a4(token: <redacted, len=347>)',
      explanation:
          'Apply ObjectFlagProperty / StringProperty.showName=false sparingly; '
          'prefer custom redaction for secrets.',
    ),
    _PrivatePitfall(
      name: 'Keep numbers human readable',
      bad: 'RenderSliver#2a771(layoutOffset: 1234567.89012345e-3)',
      good: 'RenderSliver#2a771(layoutOffset: 1234.6)',
      explanation:
          'DoubleProperty has a unit and a fractionDigits parameter; use them.',
    ),
  ];

  return _privateSectionCard(
    title: '9. Pitfalls when writing summaries',
    subtitle:
        'Treat summary lines like log lines: bounded, searchable, free of '
        'sensitive data.',
    accent: _privateError,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final p in pitfalls) ...[
          _privatePitfallRow(p),
          const SizedBox(height: 8),
        ],
      ],
    ),
  );
}

Widget _privatePitfallRow(_PrivatePitfall p) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFF1B1224),
      border: Border.all(color: _privateError.withValues(alpha: 0.35)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: _privateError, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(p.name,
                  style:
                      _privateSans(size: 13, w: FontWeight.w700)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(p.explanation,
            style: _privateSans(size: 12, color: _privateMuted)),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateLabelledCode(
                label: 'NOT this',
                code: p.bad,
                color: _privateError,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _privateLabelledCode(
                label: 'this',
                code: p.good,
                color: _privateAccent4,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 11: footer.
// -----------------------------------------------------------------------------

Widget _privateBuildFooter() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 10, 16, 24),
    padding: const EdgeInsets.all(16),
    decoration: _privatePanelDeco(),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _privateAccent.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.summarize_outlined,
              color: _privateAccent, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Summary, in summary',
                  style: _privateSans(size: 14, w: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(
                'Choose the shortest representation your consumer can use. '
                'singleLine for inline logs, shallow for inspector rows, deep '
                'only on demand.',
                style: _privateSans(size: 12, color: _privateMuted),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 12: section divider widget.
// -----------------------------------------------------------------------------

Widget _privateSectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
    height: 1,
    color: _privateSurface2.withValues(alpha: 0.6),
  );
}

// -----------------------------------------------------------------------------
// ENTRY POINT
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Compose the page in a single scrollable column. No state, no controllers.
  final children = <Widget>[
    _privateBuildHero(),
    _privateBuildIntroCard(),
    _privateSectionDivider(),
    _privateBuildSingleLineSection(),
    _privateBuildShallowSection(),
    _privateSectionDivider(),
    _privateBuildTruncateChildrenSection(),
    _privateBuildConsoleSection(),
    _privateSectionDivider(),
    _privateBuildAnatomySection(),
    _privateBuildAddOrderSection(),
    _privateSectionDivider(),
    _privateBuildDiagnosticableSection(),
    _privateBuildPitfallsSection(),
    _privateSectionDivider(),
    _privateBuildFooter(),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _privateBg,
      textTheme: TextTheme(
        bodyMedium: _privateSans(),
        bodySmall: _privateSans(size: 11.5, color: _privateMuted),
        titleLarge: _privateSans(size: 18, w: FontWeight.w800),
      ),
    ),
    home: Scaffold(
      backgroundColor: _privateBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    ),
  );
}
