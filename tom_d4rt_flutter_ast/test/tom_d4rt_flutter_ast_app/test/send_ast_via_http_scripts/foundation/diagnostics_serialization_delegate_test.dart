// ignore_for_file: avoid_print, deprecated_member_use, unused_local_variable, unused_element, unused_field, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Visual deep demo for `DiagnosticsSerializationDelegate` from
// `package:flutter/foundation.dart`.
//
// `DiagnosticsSerializationDelegate` is the abstract knob box that
// `DiagnosticsNode.toJsonMap` consults at every step of its descent. Anything
// that you want to do to the serialized output — hide a child, attach an
// annotation, truncate a long list, swap delegates per-node, stop the descent
// after N levels — is expressed as an override on a subclass of this delegate.
//
// The class itself ships exactly one default implementation (via the
// `const factory DiagnosticsSerializationDelegate({subtreeDepth,
// includeProperties})` factory). Everything else is meant to be subclassed.
//
// This file walks the surface across ten numbered sections, then concludes
// with a footer.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------
const Color _kPaper = Color(0xFFF7F5F0);
const Color _kInk = Color(0xFF1B1B1F);
const Color _kInkSoft = Color(0xFF45464F);
const Color _kInkMuted = Color(0xFF73747D);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kBorder = Color(0xFFE2DFD8);

const Color _kPrimary = Color(0xFF1F5A9C);
const Color _kPrimaryDark = Color(0xFF153F6E);
const Color _kPrimaryTint = Color(0xFFDDE9F7);

const Color _kTeal = Color(0xFF006A6A);
const Color _kAmber = Color(0xFFB58900);
const Color _kAccent = Color(0xFFCB4154);
const Color _kForest = Color(0xFF2E7D32);
const Color _kSlate = Color(0xFF455A64);
const Color _kPlum = Color(0xFF6750A4);

const Color _kCodeBg = Color(0xFF15212F);
const Color _kCodeFg = Color(0xFFDDEAF7);
const Color _kCodeComment = Color(0xFF7A8AA0);
const Color _kCodeKeyword = Color(0xFFBBD0FF);
const Color _kCodeString = Color(0xFFFFC580);
const Color _kCodeIdent = Color(0xFF9EE6FF);
const Color _kCodeNumber = Color(0xFFFFB4AB);

// ---------------------------------------------------------------------------
// Demo subject types
// ---------------------------------------------------------------------------

// A small enum that we render as an EnumProperty inside the demo tree.
enum _DemoMode { compact, normal, verbose }

// The "thing being serialized": a configuration object that contributes a
// handful of typed DiagnosticsProperty<T> entries.
class _DemoConfig with DiagnosticableTreeMixin {
  final String label;
  final int retries;
  final double timeoutSeconds;
  final bool sticky;
  final _DemoMode mode;
  final Color tint;
  final List<_DemoConfig> children;

  const _DemoConfig({
    required this.label,
    this.retries = 3,
    this.timeoutSeconds = 30.0,
    this.sticky = false,
    this.mode = _DemoMode.normal,
    this.tint = const Color(0xFF6750A4),
    this.children = const <_DemoConfig>[],
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(IntProperty('retries', retries, defaultValue: 3));
    properties.add(DoubleProperty('timeoutSeconds', timeoutSeconds));
    properties.add(FlagProperty('sticky', value: sticky, ifTrue: 'sticky'));
    properties.add(EnumProperty<_DemoMode>('mode', mode));
    properties.add(ColorProperty('tint', tint));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return children
        .map<DiagnosticsNode>((_DemoConfig c) => c.toDiagnosticsNode(
              name: 'child',
              style: DiagnosticsTreeStyle.sparse,
            ))
        .toList();
  }
}

// A delegate that exposes only the top level of children. This is what you
// would write if you wanted DevTools to fetch a single layer at a time.
class _ShallowDelegate implements DiagnosticsSerializationDelegate {
  const _ShallowDelegate({
    this.subtreeDepth = 1,
    this.includeProperties = true,
  });

  @override
  final int subtreeDepth;

  @override
  final bool includeProperties;

  @override
  bool get expandPropertyValues => false;

  @override
  Map<String, Object?> additionalNodeProperties(
    DiagnosticsNode node, {
    bool fullDetails = true,
  }) {
    return <String, Object?>{'_delegate': 'shallow'};
  }

  @override
  DiagnosticsSerializationDelegate delegateForNode(DiagnosticsNode node) {
    return subtreeDepth > 0
        ? _ShallowDelegate(
            subtreeDepth: subtreeDepth - 1,
            includeProperties: includeProperties,
          )
        : const _ShallowDelegate(subtreeDepth: 0, includeProperties: true);
  }

  @override
  List<DiagnosticsNode> filterChildren(
      List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes;
  }

  @override
  List<DiagnosticsNode> filterProperties(
      List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes;
  }

  @override
  List<DiagnosticsNode> truncateNodesList(
      List<DiagnosticsNode> nodes, DiagnosticsNode? owner) {
    return nodes;
  }

  @override
  DiagnosticsSerializationDelegate copyWith({
    int? subtreeDepth,
    bool? includeProperties,
  }) {
    return _ShallowDelegate(
      subtreeDepth: subtreeDepth ?? this.subtreeDepth,
      includeProperties: includeProperties ?? this.includeProperties,
    );
  }
}

// A delegate that drops properties whose name starts with a given prefix.
class _FilteredDelegate implements DiagnosticsSerializationDelegate {
  const _FilteredDelegate({
    required this.hidePrefix,
    this.subtreeDepth = 2,
    this.includeProperties = true,
  });

  final String hidePrefix;

  @override
  final int subtreeDepth;

  @override
  final bool includeProperties;

  @override
  bool get expandPropertyValues => false;

  @override
  Map<String, Object?> additionalNodeProperties(
    DiagnosticsNode node, {
    bool fullDetails = true,
  }) {
    return <String, Object?>{
      '_delegate': 'filtered',
      '_hiding': hidePrefix,
    };
  }

  @override
  DiagnosticsSerializationDelegate delegateForNode(DiagnosticsNode node) {
    return subtreeDepth > 0
        ? _FilteredDelegate(
            hidePrefix: hidePrefix,
            subtreeDepth: subtreeDepth - 1,
            includeProperties: includeProperties,
          )
        : _FilteredDelegate(
            hidePrefix: hidePrefix,
            subtreeDepth: 0,
            includeProperties: includeProperties,
          );
  }

  @override
  List<DiagnosticsNode> filterChildren(
      List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes;
  }

  @override
  List<DiagnosticsNode> filterProperties(
      List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    final List<DiagnosticsNode> out = <DiagnosticsNode>[];
    for (final DiagnosticsNode n in nodes) {
      final String name = n.name ?? '';
      if (!name.startsWith(hidePrefix)) {
        out.add(n);
      }
    }
    return out;
  }

  @override
  List<DiagnosticsNode> truncateNodesList(
      List<DiagnosticsNode> nodes, DiagnosticsNode? owner) {
    return nodes;
  }

  @override
  DiagnosticsSerializationDelegate copyWith({
    int? subtreeDepth,
    bool? includeProperties,
  }) {
    return _FilteredDelegate(
      hidePrefix: hidePrefix,
      subtreeDepth: subtreeDepth ?? this.subtreeDepth,
      includeProperties: includeProperties ?? this.includeProperties,
    );
  }
}

// A delegate that attaches a "depth" tag to every emitted map. It also
// truncates children to a fixed maximum count.
class _DepthTaggedDelegate implements DiagnosticsSerializationDelegate {
  const _DepthTaggedDelegate({
    this.depth = 0,
    this.maxChildren = 3,
    this.subtreeDepth = 4,
    this.includeProperties = true,
  });

  final int depth;
  final int maxChildren;

  @override
  final int subtreeDepth;

  @override
  final bool includeProperties;

  @override
  bool get expandPropertyValues => false;

  @override
  Map<String, Object?> additionalNodeProperties(
    DiagnosticsNode node, {
    bool fullDetails = true,
  }) {
    return <String, Object?>{
      '_delegate': 'depth-tagged',
      '_depth': depth,
    };
  }

  @override
  DiagnosticsSerializationDelegate delegateForNode(DiagnosticsNode node) {
    return _DepthTaggedDelegate(
      depth: depth + 1,
      maxChildren: maxChildren,
      subtreeDepth: subtreeDepth > 0 ? subtreeDepth - 1 : 0,
      includeProperties: includeProperties,
    );
  }

  @override
  List<DiagnosticsNode> filterChildren(
      List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes;
  }

  @override
  List<DiagnosticsNode> filterProperties(
      List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes;
  }

  @override
  List<DiagnosticsNode> truncateNodesList(
      List<DiagnosticsNode> nodes, DiagnosticsNode? owner) {
    if (nodes.length <= maxChildren) {
      return nodes;
    }
    return nodes.sublist(0, maxChildren);
  }

  @override
  DiagnosticsSerializationDelegate copyWith({
    int? subtreeDepth,
    bool? includeProperties,
  }) {
    return _DepthTaggedDelegate(
      depth: depth,
      maxChildren: maxChildren,
      subtreeDepth: subtreeDepth ?? this.subtreeDepth,
      includeProperties: includeProperties ?? this.includeProperties,
    );
  }
}

// A composed delegate that hands different delegates to different nodes,
// based on the node's runtime characteristics.
class _ComposedDelegate implements DiagnosticsSerializationDelegate {
  const _ComposedDelegate({
    this.subtreeDepth = 3,
    this.includeProperties = true,
  });

  @override
  final int subtreeDepth;

  @override
  final bool includeProperties;

  @override
  bool get expandPropertyValues => false;

  @override
  Map<String, Object?> additionalNodeProperties(
    DiagnosticsNode node, {
    bool fullDetails = true,
  }) {
    return <String, Object?>{'_delegate': 'composed'};
  }

  @override
  DiagnosticsSerializationDelegate delegateForNode(DiagnosticsNode node) {
    final String name = node.name ?? '';
    if (name == 'child') {
      return _DepthTaggedDelegate(
        depth: 1,
        maxChildren: 2,
        subtreeDepth: subtreeDepth > 0 ? subtreeDepth - 1 : 0,
        includeProperties: includeProperties,
      );
    }
    return _FilteredDelegate(
      hidePrefix: 'timeout',
      subtreeDepth: subtreeDepth > 0 ? subtreeDepth - 1 : 0,
      includeProperties: includeProperties,
    );
  }

  @override
  List<DiagnosticsNode> filterChildren(
      List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes;
  }

  @override
  List<DiagnosticsNode> filterProperties(
      List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes;
  }

  @override
  List<DiagnosticsNode> truncateNodesList(
      List<DiagnosticsNode> nodes, DiagnosticsNode? owner) {
    return nodes;
  }

  @override
  DiagnosticsSerializationDelegate copyWith({
    int? subtreeDepth,
    bool? includeProperties,
  }) {
    return _ComposedDelegate(
      subtreeDepth: subtreeDepth ?? this.subtreeDepth,
      includeProperties: includeProperties ?? this.includeProperties,
    );
  }
}

// ---------------------------------------------------------------------------
// Pretty-printer for the serialized maps. We render only a small whitelist of
// keys so the JSON viewer cards stay legible.
// ---------------------------------------------------------------------------

const List<String> _kInterestingKeys = <String>[
  '_delegate',
  '_depth',
  '_hiding',
  'name',
  'description',
  'type',
  'level',
  'showName',
  'children',
  'properties',
  'propertyType',
  'truncated',
  'allowTruncate',
  'allowNameWrap',
];

String _prettyJson(Object? value, {int indent = 0}) {
  final StringBuffer buf = StringBuffer();
  _writeValue(buf, value, indent);
  return buf.toString();
}

void _writeValue(StringBuffer buf, Object? value, int indent) {
  if (value is Map) {
    _writeMap(buf, value, indent);
  } else if (value is List) {
    _writeList(buf, value, indent);
  } else if (value is String) {
    buf.write('"');
    buf.write(_escape(value));
    buf.write('"');
  } else if (value == null) {
    buf.write('null');
  } else {
    buf.write(value.toString());
  }
}

void _writeMap(StringBuffer buf, Map<dynamic, dynamic> map, int indent) {
  final List<MapEntry<dynamic, dynamic>> filtered =
      <MapEntry<dynamic, dynamic>>[];
  for (final MapEntry<dynamic, dynamic> e in map.entries) {
    if (_kInterestingKeys.contains(e.key)) {
      filtered.add(e);
    }
  }
  if (filtered.isEmpty) {
    buf.write('{}');
    return;
  }
  buf.write('{\n');
  for (int i = 0; i < filtered.length; i++) {
    final MapEntry<dynamic, dynamic> e = filtered[i];
    _pad(buf, indent + 2);
    buf.write('"');
    buf.write(e.key.toString());
    buf.write('": ');
    _writeValue(buf, e.value, indent + 2);
    if (i != filtered.length - 1) {
      buf.write(',');
    }
    buf.write('\n');
  }
  _pad(buf, indent);
  buf.write('}');
}

void _writeList(StringBuffer buf, List<dynamic> list, int indent) {
  if (list.isEmpty) {
    buf.write('[]');
    return;
  }
  buf.write('[\n');
  for (int i = 0; i < list.length; i++) {
    _pad(buf, indent + 2);
    _writeValue(buf, list[i], indent + 2);
    if (i != list.length - 1) {
      buf.write(',');
    }
    buf.write('\n');
  }
  _pad(buf, indent);
  buf.write(']');
}

void _pad(StringBuffer buf, int n) {
  for (int i = 0; i < n; i++) {
    buf.write(' ');
  }
}

String _escape(String s) {
  return s
      .replaceAll(r'\', r'\\')
      .replaceAll('"', r'\"')
      .replaceAll('\n', r'\n');
}

// ---------------------------------------------------------------------------
// Build the demo tree once so every section sees the same input.
// ---------------------------------------------------------------------------

_DemoConfig _buildDemoTree() {
  return const _DemoConfig(
    label: 'root',
    retries: 5,
    timeoutSeconds: 12.5,
    sticky: true,
    mode: _DemoMode.verbose,
    tint: Color(0xFF1F5A9C),
    children: <_DemoConfig>[
      _DemoConfig(
        label: 'fetcher',
        retries: 3,
        timeoutSeconds: 8.0,
        mode: _DemoMode.normal,
        children: <_DemoConfig>[
          _DemoConfig(label: 'http', retries: 1, timeoutSeconds: 2.0),
          _DemoConfig(label: 'cache', retries: 0, timeoutSeconds: 0.5),
        ],
      ),
      _DemoConfig(
        label: 'renderer',
        retries: 2,
        timeoutSeconds: 4.0,
        sticky: true,
        mode: _DemoMode.compact,
      ),
      _DemoConfig(
        label: 'reporter',
        retries: 1,
        timeoutSeconds: 1.0,
        mode: _DemoMode.compact,
      ),
    ],
  );
}

Map<String, Object?> _serializeWith(
  _DemoConfig config,
  DiagnosticsSerializationDelegate delegate,
) {
  final DiagnosticsNode node = config.toDiagnosticsNode(name: 'root');
  return node.toJsonMap(delegate);
}

// ---------------------------------------------------------------------------
// build()
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  final _DemoConfig tree = _buildDemoTree();

  // Pre-compute every serialization so the widget tree can render synchronous
  // text blocks; running it inside the build is fine for a demo.
  final Map<String, Object?> defaultMap = _serializeWith(
    tree,
    const DiagnosticsSerializationDelegate(
      subtreeDepth: 2,
      includeProperties: true,
    ),
  );
  final Map<String, Object?> shallowMap = _serializeWith(
    tree,
    const _ShallowDelegate(),
  );
  final Map<String, Object?> filteredMap = _serializeWith(
    tree,
    const _FilteredDelegate(hidePrefix: 'timeout'),
  );
  final Map<String, Object?> depthMap = _serializeWith(
    tree,
    const _DepthTaggedDelegate(),
  );
  final Map<String, Object?> composedMap = _serializeWith(
    tree,
    const _ComposedDelegate(),
  );

  // A copyWith chain, demonstrated as four progressively tighter delegates.
  final DiagnosticsSerializationDelegate d0 =
      const DiagnosticsSerializationDelegate(
    subtreeDepth: 3,
    includeProperties: true,
  );
  final DiagnosticsSerializationDelegate d1 =
      d0.copyWith(includeProperties: false);
  final DiagnosticsSerializationDelegate d2 = d1.copyWith(subtreeDepth: 1);
  final DiagnosticsSerializationDelegate d3 = d2.copyWith(subtreeDepth: 0);

  final List<Map<String, Object?>> copyChain = <Map<String, Object?>>[
    _serializeWith(tree, d0),
    _serializeWith(tree, d1),
    _serializeWith(tree, d2),
    _serializeWith(tree, d3),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _HeroCard(),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '01',
                title: 'Dossier',
                subtitle: 'What this delegate is and why it exists',
                accent: _kPrimary,
              ),
              const SizedBox(height: 16),
              const _DossierCard(),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '02',
                title: 'Anatomy',
                subtitle: 'The members you override and the ones you read',
                accent: _kTeal,
              ),
              const SizedBox(height: 16),
              const _AnatomyTable(),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '03',
                title: 'Default vs shallow delegate',
                subtitle:
                    'Same node, two delegates: the factory default and a depth-one cut',
                accent: _kAmber,
              ),
              const SizedBox(height: 16),
              _SideBySideJson(
                leftTitle: 'DiagnosticsSerializationDelegate(2, true)',
                leftJson: _prettyJson(defaultMap),
                rightTitle: '_ShallowDelegate(subtreeDepth: 1)',
                rightJson: _prettyJson(shallowMap),
                accent: _kAmber,
              ),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '04',
                title: 'Filtered delegate',
                subtitle:
                    'Hide every property whose name starts with "timeout"',
                accent: _kAccent,
              ),
              const SizedBox(height: 16),
              _SingleJson(
                title: '_FilteredDelegate(hidePrefix: "timeout")',
                json: _prettyJson(filteredMap),
                accent: _kAccent,
              ),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '05',
                title: 'copyWith chain',
                subtitle: 'Four progressively tighter snapshots of one config',
                accent: _kForest,
              ),
              const SizedBox(height: 16),
              _CopyChainGrid(
                snapshots: <_CopySnapshot>[
                  _CopySnapshot(
                    label: 'd0',
                    config: 'subtreeDepth: 3, includeProperties: true',
                    json: _prettyJson(copyChain[0]),
                  ),
                  _CopySnapshot(
                    label: 'd1',
                    config: 'd0.copyWith(includeProperties: false)',
                    json: _prettyJson(copyChain[1]),
                  ),
                  _CopySnapshot(
                    label: 'd2',
                    config: 'd1.copyWith(subtreeDepth: 1)',
                    json: _prettyJson(copyChain[2]),
                  ),
                  _CopySnapshot(
                    label: 'd3',
                    config: 'd2.copyWith(subtreeDepth: 0)',
                    json: _prettyJson(copyChain[3]),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '06',
                title: 'delegateForNode composition',
                subtitle:
                    'A composed delegate that hands a child to one delegate and properties to another',
                accent: _kSlate,
              ),
              const SizedBox(height: 16),
              _SideBySideJson(
                leftTitle: '_DepthTaggedDelegate (max 3 children)',
                leftJson: _prettyJson(depthMap),
                rightTitle: '_ComposedDelegate (per-node routing)',
                rightJson: _prettyJson(composedMap),
                accent: _kSlate,
              ),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '07',
                title: 'Recipes',
                subtitle: 'Patterns you can copy when authoring delegates',
                accent: _kPlum,
              ),
              const SizedBox(height: 16),
              const _RecipeGrid(),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '08',
                title: 'Comparison table',
                subtitle:
                    'Five preset delegates and what they include or exclude',
                accent: _kPrimaryDark,
              ),
              const SizedBox(height: 16),
              const _ComparisonTable(),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '09',
                title: 'Glossary',
                subtitle: 'Names that appear in the API and what they mean',
                accent: _kTeal,
              ),
              const SizedBox(height: 16),
              const _GlossaryList(),
              const SizedBox(height: 28),
              _SectionHeader(
                index: '10',
                title: 'Final widget tree',
                subtitle: 'A miniature DevTools panel mocked from the data',
                accent: _kForest,
              ),
              const SizedBox(height: 16),
              const _DevToolsMock(),
              const SizedBox(height: 32),
              const _Footer(),
            ],
          ),
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
            Color(0xFF153F6E),
            Color(0xFF1F5A9C),
            Color(0xFF3D7DBE),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF153F6E).withValues(alpha: 0.35),
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
                  Icons.data_object_outlined,
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
                      'foundation · serialization',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.78),
                        fontSize: 11.5,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'DiagnosticsSerializationDelegate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
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
            'The abstract knob box that DiagnosticsNode.toJsonMap consults at '
            'every step of its descent. Subclass it to shape the JSON tree '
            'the Flutter Inspector sees: hide nodes, attach annotations, '
            'truncate lists, swap delegates per-node, stop after N levels.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 14.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: const <Widget>[
              _HeroPill(label: 'abstract', accent: Color(0xFFFFD9A8)),
              SizedBox(width: 8),
              _HeroPill(label: 'foundation', accent: Color(0xFFA8E0FF)),
              SizedBox(width: 8),
              _HeroPill(label: 'DevTools-facing', accent: Color(0xFFFFB4AB)),
              SizedBox(width: 8),
              _HeroPill(label: 'subtreeDepth aware', accent: Color(0xFFB6F2C5)),
            ],
          ),
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
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.14),
        border: Border.all(
          color: accent.withValues(alpha: 0.85),
          width: 1.2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: accent,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: accent.withValues(alpha: 0.12),
            border: Border.all(color: accent.withValues(alpha: 0.4), width: 1),
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
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _kInkMuted,
                  fontSize: 13.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Dossier
// ---------------------------------------------------------------------------
class _DossierCard extends StatelessWidget {
  const _DossierCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _DossierRow(
            label: 'Library',
            value: 'package:flutter/foundation.dart',
            icon: Icons.library_books_outlined,
          ),
          SizedBox(height: 10),
          _DossierRow(
            label: 'Kind',
            value: 'abstract class with a const factory default',
            icon: Icons.architecture_outlined,
          ),
          SizedBox(height: 10),
          _DossierRow(
            label: 'Consumer',
            value: 'DiagnosticsNode.toJsonMap(delegate)',
            icon: Icons.swap_calls_outlined,
          ),
          SizedBox(height: 10),
          _DossierRow(
            label: 'Goal',
            value: 'Customize how a DiagnosticsNode tree turns into JSON',
            icon: Icons.flag_outlined,
          ),
          SizedBox(height: 10),
          _DossierRow(
            label: 'Default',
            value:
                'subtreeDepth: 0, includeProperties: false, expandPropertyValues: false',
            icon: Icons.tune_outlined,
          ),
          SizedBox(height: 10),
          _DossierRow(
            label: 'Customization axes',
            value:
                'depth · filtering · annotation · truncation · per-node swap',
            icon: Icons.list_alt_outlined,
          ),
        ],
      ),
    );
  }
}

class _DossierRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DossierRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: _kPrimary, size: 18),
        const SizedBox(width: 10),
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: _kInk, fontSize: 13.5, height: 1.35),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Anatomy
// ---------------------------------------------------------------------------
class _AnatomyTable extends StatelessWidget {
  const _AnatomyTable();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>[
        'subtreeDepth',
        'int',
        'How many child levels to include',
      ],
      <String>[
        'includeProperties',
        'bool',
        'Whether to emit the DiagnosticsProperty list',
      ],
      <String>[
        'expandPropertyValues',
        'bool',
        'Whether Diagnosticable-valued properties recurse',
      ],
      <String>[
        'additionalNodeProperties',
        'Map<String, Object?>',
        'Extra keys merged into every emitted node map',
      ],
      <String>[
        'delegateForNode',
        'DiagnosticsSerializationDelegate',
        'Delegate handed down to a child or property',
      ],
      <String>[
        'filterChildren',
        'List<DiagnosticsNode>',
        'Hide or replace children before recursion',
      ],
      <String>[
        'filterProperties',
        'List<DiagnosticsNode>',
        'Hide or replace properties before recursion',
      ],
      <String>[
        'truncateNodesList',
        'List<DiagnosticsNode>',
        'Cut the list short; leaves a truncated marker',
      ],
      <String>[
        'copyWith',
        'DiagnosticsSerializationDelegate',
        'Derive a new delegate with two knobs changed',
      ],
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: _kPrimaryTint,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(15.5)),
            ),
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 200,
                  child: Text(
                    'Member',
                    style: TextStyle(
                      color: _kPrimaryDark,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'Type',
                    style: TextStyle(
                      color: _kPrimaryDark,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Role',
                    style: TextStyle(
                      color: _kPrimaryDark,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              decoration: BoxDecoration(
                color: i.isEven ? _kCard : _kPaper,
                border: Border(
                  bottom: BorderSide(
                    color: i == rows.length - 1
                        ? Colors.transparent
                        : _kBorder.withValues(alpha: 0.6),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: Text(
                      rows[i][0],
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 13,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      rows[i][1],
                      style: const TextStyle(
                        color: _kPrimaryDark,
                        fontSize: 12.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rows[i][2],
                      style: const TextStyle(
                        color: _kInkSoft,
                        fontSize: 13,
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

// ---------------------------------------------------------------------------
// JSON viewer panels
// ---------------------------------------------------------------------------
class _SingleJson extends StatelessWidget {
  final String title;
  final String json;
  final Color accent;

  const _SingleJson({
    required this.title,
    required this.json,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _kCard,
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.10),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15.5)),
              border: Border(
                bottom:
                    BorderSide(color: accent.withValues(alpha: 0.4), width: 1),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.code_outlined, color: accent, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: accent,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: _kCodeBg,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(15.5)),
            ),
            child: Text(
              json,
              style: const TextStyle(
                color: _kCodeFg,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideBySideJson extends StatelessWidget {
  final String leftTitle;
  final String leftJson;
  final String rightTitle;
  final String rightJson;
  final Color accent;

  const _SideBySideJson({
    required this.leftTitle,
    required this.leftJson,
    required this.rightTitle,
    required this.rightJson,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _SingleJson(
            title: leftTitle,
            json: leftJson,
            accent: accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SingleJson(
            title: rightTitle,
            json: rightJson,
            accent: accent,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// copyWith chain
// ---------------------------------------------------------------------------
class _CopySnapshot {
  final String label;
  final String config;
  final String json;
  const _CopySnapshot({
    required this.label,
    required this.config,
    required this.json,
  });
}

class _CopyChainGrid extends StatelessWidget {
  final List<_CopySnapshot> snapshots;
  const _CopyChainGrid({required this.snapshots});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < snapshots.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == snapshots.length - 1 ? 0 : 12),
            child: Container(
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _kBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: _kForest.withValues(alpha: 0.10),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15.5)),
                      border: Border(
                        bottom: BorderSide(
                          color: _kForest.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _kForest,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            snapshots[i].label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            snapshots[i].config,
                            style: const TextStyle(
                              color: _kForest,
                              fontSize: 12.5,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: _kCodeBg,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(15.5)),
                    ),
                    child: Text(
                      snapshots[i].json,
                      style: const TextStyle(
                        color: _kCodeFg,
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Recipes
// ---------------------------------------------------------------------------
class _RecipeGrid extends StatelessWidget {
  const _RecipeGrid();

  @override
  Widget build(BuildContext context) {
    final List<_Recipe> recipes = const <_Recipe>[
      _Recipe(
        icon: Icons.layers_outlined,
        title: 'Cap recursion to a single layer',
        body:
            'Return a copyWith(subtreeDepth: 0) from delegateForNode so the next level emits children: [] markers without descending.',
      ),
      _Recipe(
        icon: Icons.filter_alt_outlined,
        title: 'Hide secret properties',
        body:
            'In filterProperties, drop any DiagnosticsNode whose name starts with "secret" or matches an allow-list. Children stay untouched.',
      ),
      _Recipe(
        icon: Icons.short_text_outlined,
        title: 'Truncate long lists',
        body:
            'In truncateNodesList, return nodes.sublist(0, N). DiagnosticsNode adds a "truncated": true marker downstream.',
      ),
      _Recipe(
        icon: Icons.tag_outlined,
        title: 'Annotate every node',
        body:
            'In additionalNodeProperties, return a map with a "_source": "myAgent" key — every emitted node will carry it.',
      ),
      _Recipe(
        icon: Icons.alt_route_outlined,
        title: 'Branch per node kind',
        body:
            'In delegateForNode, inspect node.name or node.value and return a different delegate for children vs properties.',
      ),
      _Recipe(
        icon: Icons.search_off_outlined,
        title: 'Strip properties entirely',
        body:
            'Set includeProperties to false in the default factory: DiagnosticsSerializationDelegate(includeProperties: false).',
      ),
      _Recipe(
        icon: Icons.expand_outlined,
        title: 'Expand Diagnosticable values',
        body:
            'Override expandPropertyValues to true so properties whose value is itself Diagnosticable recurse into a nested map.',
      ),
      _Recipe(
        icon: Icons.swap_horiz_outlined,
        title: 'Drop the subtree at depth N',
        body:
            'Return subtreeDepth - 1 from each delegateForNode and stop returning new delegates once subtreeDepth reaches 0.',
      ),
    ];

    return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints cs) {
      final bool wide = cs.maxWidth > 720;
      final int cols = wide ? 2 : 1;
      final double itemW = (cs.maxWidth - (cols - 1) * 12) / cols;
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          for (final _Recipe r in recipes)
            SizedBox(
              width: itemW,
              child: _RecipeCard(recipe: r),
            ),
        ],
      );
    });
  }
}

class _Recipe {
  final IconData icon;
  final String title;
  final String body;
  const _Recipe({
    required this.icon,
    required this.title,
    required this.body,
  });
}

class _RecipeCard extends StatelessWidget {
  final _Recipe recipe;
  const _RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _kPlum.withValues(alpha: 0.12),
                ),
                child: Icon(recipe.icon, color: _kPlum, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            recipe.body,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Comparison table
// ---------------------------------------------------------------------------
class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>[
        'minimal',
        'DiagnosticsSerializationDelegate()',
        '0',
        'no',
        'no',
        'no',
      ],
      <String>[
        'default-with-props',
        'DiagnosticsSerializationDelegate(includeProperties: true)',
        '0',
        'yes',
        'no',
        'no',
      ],
      <String>[
        'expanded',
        'DiagnosticsSerializationDelegate(subtreeDepth: 4)',
        '4',
        'no',
        'no',
        'no',
      ],
      <String>[
        'filtered',
        '_FilteredDelegate(hidePrefix: "timeout")',
        '2',
        'yes',
        'yes',
        'no',
      ],
      <String>[
        'depth-limited',
        '_DepthTaggedDelegate(maxChildren: 3)',
        '4',
        'yes',
        'no',
        'yes',
      ],
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: _kPrimaryTint,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(15.5)),
            ),
            child: Row(
              children: const <Widget>[
                _HeadCell(text: 'Preset', flex: 2),
                _HeadCell(text: 'Construction', flex: 5),
                _HeadCell(text: 'Depth', flex: 1),
                _HeadCell(text: 'Props', flex: 1),
                _HeadCell(text: 'Filter', flex: 1),
                _HeadCell(text: 'Trunc', flex: 1),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven ? _kCard : _kPaper,
                border: Border(
                  bottom: BorderSide(
                    color: i == rows.length - 1
                        ? Colors.transparent
                        : _kBorder.withValues(alpha: 0.6),
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  _BodyCell(text: rows[i][0], flex: 2, bold: true),
                  _BodyCell(text: rows[i][1], flex: 5, mono: true),
                  _BodyCell(text: rows[i][2], flex: 1, mono: true),
                  _YesNoCell(value: rows[i][3], flex: 1),
                  _YesNoCell(value: rows[i][4], flex: 1),
                  _YesNoCell(value: rows[i][5], flex: 1),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _HeadCell extends StatelessWidget {
  final String text;
  final int flex;
  const _HeadCell({required this.text, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          color: _kPrimaryDark,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _BodyCell extends StatelessWidget {
  final String text;
  final int flex;
  final bool bold;
  final bool mono;
  const _BodyCell({
    required this.text,
    required this.flex,
    this.bold = false,
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: bold ? _kInk : _kInkSoft,
          fontSize: 12.5,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          fontFamily: mono ? 'monospace' : null,
        ),
      ),
    );
  }
}

class _YesNoCell extends StatelessWidget {
  final String value;
  final int flex;
  const _YesNoCell({required this.value, required this.flex});

  @override
  Widget build(BuildContext context) {
    final bool yes = value == 'yes';
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: yes
              ? _kForest.withValues(alpha: 0.12)
              : _kAccent.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: yes
                ? _kForest.withValues(alpha: 0.5)
                : _kAccent.withValues(alpha: 0.45),
          ),
        ),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: yes ? _kForest : _kAccent,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Glossary
// ---------------------------------------------------------------------------
class _GlossaryList extends StatelessWidget {
  const _GlossaryList();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> entries = <List<String>>[
      <String>[
        'DiagnosticsNode',
        'A piece of debug information. Has a name, a value, a description, '
            'and possibly children.',
      ],
      <String>[
        'toJsonMap',
        'Method on DiagnosticsNode that turns the node into '
            'Map<String, Object?> using a supplied delegate.',
      ],
      <String>[
        'subtreeDepth',
        'Remaining depth budget. Each delegateForNode call typically returns '
            'a delegate with depth - 1.',
      ],
      <String>[
        'includeProperties',
        'If true, the property nodes attached to a Diagnosticable show up in '
            'the JSON under "properties".',
      ],
      <String>[
        'expandPropertyValues',
        'If true, a property whose value is itself Diagnosticable is '
            'serialized recursively rather than as a leaf.',
      ],
      <String>[
        'additionalNodeProperties',
        'Map merged into every emitted node entry. Useful for annotating '
            'origin, color, or trace IDs.',
      ],
      <String>[
        'filterChildren / filterProperties',
        'Visit hooks that can hide nodes outright. The hidden nodes never '
            'appear in the JSON, not even as truncated stubs.',
      ],
      <String>[
        'truncateNodesList',
        'Cuts a list short and leaves a "truncated": true marker in the '
            'emitted JSON for the dropped tail.',
      ],
      <String>[
        'delegateForNode',
        'Returns the delegate used for a given child or property. This is '
            'where you swap behavior partway through the tree.',
      ],
      <String>[
        'copyWith',
        'Convenience for deriving a new delegate with subtreeDepth and/or '
            'includeProperties changed.',
      ],
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < entries.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: i.isEven ? _kCard : _kPaper,
                border: Border(
                  bottom: BorderSide(
                    color: i == entries.length - 1
                        ? Colors.transparent
                        : _kBorder.withValues(alpha: 0.6),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 230,
                    child: Text(
                      entries[i][0],
                      style: const TextStyle(
                        color: _kTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entries[i][1],
                      style: const TextStyle(
                        color: _kInkSoft,
                        fontSize: 13,
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

// ---------------------------------------------------------------------------
// DevTools-style mock
// ---------------------------------------------------------------------------
class _DevToolsMock extends StatelessWidget {
  const _DevToolsMock();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2330),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF394155)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.bug_report_outlined,
                  color: Color(0xFFA8E0FF), size: 18),
              const SizedBox(width: 8),
              const Text(
                'Inspector · root',
                style: TextStyle(
                  color: Color(0xFFA8E0FF),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF394155),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'subtreeDepth: 3',
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
          const SizedBox(height: 12),
          const _DevToolsRow(
            indent: 0,
            kind: 'config',
            name: 'root',
            value: 'mode: verbose, retries: 5',
            color: Color(0xFFFFC580),
          ),
          const _DevToolsRow(
            indent: 1,
            kind: 'child',
            name: 'fetcher',
            value: 'mode: normal, retries: 3',
            color: Color(0xFF9EE6FF),
          ),
          const _DevToolsRow(
            indent: 2,
            kind: 'child',
            name: 'http',
            value: 'retries: 1, timeoutSeconds: 2.0',
            color: Color(0xFF9EE6FF),
          ),
          const _DevToolsRow(
            indent: 2,
            kind: 'child',
            name: 'cache',
            value: 'retries: 0, timeoutSeconds: 0.5',
            color: Color(0xFF9EE6FF),
          ),
          const _DevToolsRow(
            indent: 1,
            kind: 'child',
            name: 'renderer',
            value: 'mode: compact, sticky',
            color: Color(0xFF9EE6FF),
          ),
          const _DevToolsRow(
            indent: 1,
            kind: 'child',
            name: 'reporter',
            value: 'mode: compact, retries: 1',
            color: Color(0xFF9EE6FF),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '// Output is shaped entirely by the chosen delegate.\n'
              '// Changing the delegate at runtime changes this view.',
              style: TextStyle(
                color: Color(0xFF8A85B6),
                fontSize: 11.5,
                fontFamily: 'monospace',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DevToolsRow extends StatelessWidget {
  final int indent;
  final String kind;
  final String name;
  final String value;
  final Color color;

  const _DevToolsRow({
    required this.indent,
    required this.kind,
    required this.name,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(indent * 20.0, 4, 0, 4),
      child: Row(
        children: <Widget>[
          Icon(
            kind == 'config'
                ? Icons.account_tree_outlined
                : Icons.arrow_right_outlined,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              kind,
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFFB6BBC9),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _kPrimary.withValues(alpha: 0.12),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: _kPrimary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'DiagnosticsSerializationDelegate is small in surface area but '
              'pivotal: it is the only configuration object that travels with '
              'a DiagnosticsNode tree as it is turned into JSON. Master it and '
              'you control what every DevTools client downstream of your '
              'Diagnosticable types is allowed to see.',
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
