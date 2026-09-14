// =============================================================================
// root_element_test.dart
// -----------------------------------------------------------------------------
// Deep-demo for the Flutter `RootElement` — the element at the very top of the
// widget element tree returned by `WidgetsBinding.instance.rootElement`.
//
// This demo is consumed by the tom_d4rt_flutter_ast AST-via-HTTP harness. It is
// intentionally structured as a single-file, hand-authored pedagogical module
// rather than a production widget.
//
// RootElement is the concrete Element implementation that sits under the
// embedder's FlutterView. It is instantiated for you — you never build one
// yourself — and it carries out four roles that no other element carries:
//
//   1. It hosts the top-most `View` widget which bridges the embedder's
//      underlying FlutterView to the Dart side of the widget tree.
//   2. It is the handoff point for `WidgetsBinding.attachRootWidget` /
//      `attachToBuildOwner`, turning the boot-time widget into a live
//      element subtree.
//   3. It anchors the `BuildOwner` for the entire tree. Every rebuild,
//      every setState, every markNeedsBuild ultimately propagates up to
//      this element.
//   4. It is the implicit restoration root — the place where
//      `RootRestorationScope` registers its bucket.
//
// Because users can't instantiate `RootElement` directly, the only way to
// demonstrate it is to *observe* it at runtime. That's exactly what this
// demo does: it reaches into `WidgetsBinding.instance.rootElement` and
// renders live, legible facts about the element that is currently hosting
// the app on screen.
//
// Strict harness rules observed:
//   - Single top-level `dynamic build(BuildContext context)` entry point.
//   - No `main()`, no `runApp()`, no RestorationMixin.
//   - Only `package:flutter/material.dart` is imported.
//   - `debugPrint` is used instead of `print`.
//   - `withValues(alpha: ...)` is used instead of `withOpacity(...)`.
//   - No `// ignore_for_file:` directives anywhere.
//
// Style palette (differentiating from sibling demos):
//   - charcoal backdrop   (#1F2430 — IDE "inspector" panel)
//   - emerald accent      (#2DB57C — highlight for the RootElement row)
//   - salmon callout      (#F08A7A — "common confusions" warnings)
//   - parchment surface   (#F6F1E6 — body section backgrounds)
//   - slate text          (#3A4049 — primary text)
//
// No blue-primary is used anywhere — the root_element_mixin sibling owns
// steel-blue, and this demo stays in the charcoal/emerald/salmon IDE-look
// lane.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Palette constants
// -----------------------------------------------------------------------------

const Color _charcoal = Color(0xFF1F2430);
const Color _charcoalSoft = Color(0xFF2A303E);
const Color _charcoalLine = Color(0xFF3B4253);
const Color _emerald = Color(0xFF2DB57C);
const Color _emeraldDeep = Color(0xFF1F8A5D);
const Color _salmon = Color(0xFFF08A7A);
const Color _salmonSoft = Color(0xFFFAD4CD);
const Color _parchment = Color(0xFFF6F1E6);
const Color _parchmentDeep = Color(0xFFECE4D0);
const Color _slate = Color(0xFF3A4049);
const Color _slateSoft = Color(0xFF6B727D);
const Color _cream = Color(0xFFFFFDF6);

// -----------------------------------------------------------------------------
// Top-level entry point (harness requirement — no `main`, no `runApp`)
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RootElement — Element Tree Root Viewer',
    home: ElementTreeRootViewerDemo(),
  );
}

// -----------------------------------------------------------------------------
// Data classes used by the probe & diagram
// -----------------------------------------------------------------------------

/// A single captured row from a walk of the live element tree.
class _ProbeRow {
  _ProbeRow({
    required this.depth,
    required this.typeName,
    required this.hashFragment,
    required this.isRoot,
  });

  final int depth;
  final String typeName;
  final String hashFragment;
  final bool isRoot;
}

/// A single node in the class-hierarchy diagram.
class _HierarchyNode {
  const _HierarchyNode({
    required this.name,
    required this.description,
    required this.icon,
    this.isOnRootPath = false,
    this.isTarget = false,
    this.branchLabel,
  });

  final String name;
  final String description;
  final IconData icon;
  final bool isOnRootPath;
  final bool isTarget;
  final String? branchLabel;
}

/// A role-card describing one of RootElement's 4 unique responsibilities.
class _RoleCard {
  const _RoleCard({
    required this.title,
    required this.description,
    required this.seeAlso,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String description;
  final String seeAlso;
  final IconData icon;
  final Color accent;
}

/// A single "common confusion" entry in the teaching panel.
class _Confusion {
  const _Confusion({
    required this.left,
    required this.right,
    required this.resolution,
  });

  final String left;
  final String right;
  final String resolution;
}

// -----------------------------------------------------------------------------
// The demo widget
// -----------------------------------------------------------------------------

class ElementTreeRootViewerDemo extends StatefulWidget {
  const ElementTreeRootViewerDemo({super.key});

  @override
  State<ElementTreeRootViewerDemo> createState() =>
      _ElementTreeRootViewerDemoState();
}

class _ElementTreeRootViewerDemoState extends State<ElementTreeRootViewerDemo> {
  // Soft counter for the inspector refresh button — lets the user see that
  // `setState` has actually rebuilt the inspector panel.
  int _inspectorGeneration = 0;

  // Cached probe rows from the last tree walk.
  List<_ProbeRow> _probeRows = const <_ProbeRow>[];

  // Whether the probe ran into truncation.
  int _truncatedRowCount = 0;

  // Static view of the Element class-hierarchy diagram.
  late final List<_HierarchyNode> _hierarchyMainPath;
  late final List<_HierarchyNode> _hierarchyBranchPath;

  // Static view of the 4 role-cards.
  late final List<_RoleCard> _roleCards;

  // Static view of the "common confusions" list.
  late final List<_Confusion> _confusions;

  // Maximum number of probe rows rendered before truncation.
  static const int _kProbeCap = 30;

  // Maximum depth walked by the probe.
  static const int _kProbeMaxDepth = 4;

  @override
  void initState() {
    super.initState();

    _hierarchyMainPath = const <_HierarchyNode>[
      _HierarchyNode(
        name: 'Element',
        description: 'Abstract base — location in the tree, not a widget.',
        icon: Icons.account_tree,
      ),
      _HierarchyNode(
        name: 'ComponentElement',
        description: 'Element composed from other widgets (no RenderObject).',
        icon: Icons.settings_ethernet,
      ),
      _HierarchyNode(
        name: 'RenderObjectElement',
        description: 'Element that owns a RenderObject (paints/lays out).',
        icon: Icons.layers,
        isOnRootPath: true,
      ),
      _HierarchyNode(
        name: 'RootRenderObjectElement',
        description: 'Render-tree root — parent is null, slot is null.',
        icon: Icons.polyline,
        isOnRootPath: true,
      ),
      _HierarchyNode(
        name: 'RootElement',
        description: 'THIS — the single top element under FlutterView.',
        icon: Icons.star,
        isOnRootPath: true,
        isTarget: true,
      ),
    ];

    _hierarchyBranchPath = const <_HierarchyNode>[
      _HierarchyNode(
        name: 'StatefulElement',
        description: 'ComponentElement whose widget has a State object.',
        icon: Icons.memory,
        branchLabel: 'cousin branch — from ComponentElement',
      ),
      _HierarchyNode(
        name: 'StatelessElement',
        description: 'ComponentElement whose widget is immutable.',
        icon: Icons.widgets,
        branchLabel: 'cousin branch — from ComponentElement',
      ),
      _HierarchyNode(
        name: 'InheritedElement',
        description: 'Element that propagates data down via dependencies.',
        icon: Icons.alt_route,
        branchLabel: 'cousin branch — from ComponentElement',
      ),
    ];

    _roleCards = const <_RoleCard>[
      _RoleCard(
        title: 'View host',
        description:
            'Hosts the top-level View widget that bridges the embedder '
            "FlutterView to Flutter's widget tree.",
        seeAlso: 'see also: View, FlutterView, RawView',
        icon: Icons.desktop_mac,
        accent: _emerald,
      ),
      _RoleCard(
        title: 'Binding handoff',
        description:
            'Entry point for WidgetsBinding.attachRootWidget and '
            'attachToBuildOwner — boots the widget subtree into life.',
        seeAlso: 'see also: WidgetsBinding.attachRootWidget',
        icon: Icons.power_settings_new,
        accent: _emeraldDeep,
      ),
      _RoleCard(
        title: 'BuildOwner anchor',
        description:
            'The attach point for the single BuildOwner that schedules '
            'rebuilds for every element in the tree.',
        seeAlso: 'see also: BuildOwner, RootElementMixin',
        icon: Icons.anchor,
        accent: _salmon,
      ),
      _RoleCard(
        title: 'Restoration root',
        description:
            'Where RootRestorationScope registers the top restoration '
            'bucket that fans out to every RestorableProperty below.',
        seeAlso: 'see also: RootRestorationScope, RestorationManager',
        icon: Icons.save,
        accent: _charcoalLine,
      ),
    ];

    _confusions = const <_Confusion>[
      _Confusion(
        left: 'RootElement',
        right: 'RootRenderObjectElement',
        resolution:
            'RootElement wraps RootRenderObjectElement — the former is '
            'the observable top, the latter the render-tree pivot.',
      ),
      _Confusion(
        left: 'RootElement',
        right: 'MaterialApp',
        resolution:
            'MaterialApp is a widget that lives far below RootElement — '
            'RootElement is the element, MaterialApp a widget it holds.',
      ),
      _Confusion(
        left: 'RootElement',
        right: "your StatefulWidget's State",
        resolution:
            'State objects sit at arbitrary depth inside the tree — '
            'RootElement is exactly one, at depth zero, framework-owned.',
      ),
    ];

    // Schedule the first probe for just after the first frame so that
    // WidgetsBinding.instance.rootElement is definitely populated.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _runProbe();
    });
  }

  // ---------------------------------------------------------------------------
  // Probe — walks the live element tree from rootElement, down to
  // [_kProbeMaxDepth] levels, capping the total rows at [_kProbeCap].
  // ---------------------------------------------------------------------------

  void _runProbe() {
    debugPrint('ElementTreeRootViewerDemo: probing element tree…');

    final Element? root = WidgetsBinding.instance.rootElement;
    if (root == null) {
      debugPrint(
        'ElementTreeRootViewerDemo: rootElement is null — probe skipped.',
      );
      setState(() {
        _probeRows = const <_ProbeRow>[];
        _truncatedRowCount = 0;
        _inspectorGeneration += 1;
      });
      return;
    }

    final List<_ProbeRow> collected = <_ProbeRow>[];
    int truncated = 0;

    // The root itself is depth 0.
    collected.add(
      _ProbeRow(
        depth: 0,
        typeName: root.runtimeType.toString(),
        hashFragment: _hashFragment(root.hashCode),
        isRoot: true,
      ),
    );

    void walk(Element parent, int depth) {
      if (depth > _kProbeMaxDepth) return;
      parent.visitChildren((Element child) {
        if (collected.length >= _kProbeCap) {
          truncated += 1;
          return;
        }
        collected.add(
          _ProbeRow(
            depth: depth,
            typeName: child.runtimeType.toString(),
            hashFragment: _hashFragment(child.hashCode),
            isRoot: false,
          ),
        );
        walk(child, depth + 1);
      });
    }

    walk(root, 1);

    debugPrint(
      'ElementTreeRootViewerDemo: probe captured '
      '${collected.length} rows (truncated $truncated).',
    );

    setState(() {
      _probeRows = collected;
      _truncatedRowCount = truncated;
      _inspectorGeneration += 1;
    });
  }

  String _hashFragment(int hash) {
    final String hex = hash.toRadixString(16).toUpperCase();
    // Show a short, monospace-friendly prefix — enough to disambiguate
    // nearby elements without overwhelming the line.
    if (hex.length <= 6) return '#$hex';
    return '#${hex.substring(0, 6)}';
  }

  // ---------------------------------------------------------------------------
  // Accessors that describe the *current* rootElement. These are recomputed
  // on every rebuild so the hero card is always live.
  // ---------------------------------------------------------------------------

  Element? get _rootElement => WidgetsBinding.instance.rootElement;

  String get _rootRuntimeType =>
      _rootElement == null ? '--' : _rootElement!.runtimeType.toString();

  String get _rootHashCode =>
      _rootElement == null ? '--' : _hashFragment(_rootElement!.hashCode);

  String get _rootMountState {
    final Element? r = _rootElement;
    if (r == null) return '--';
    return r.mounted ? 'mounted' : 'defunct';
  }

  String get _rootDepth {
    final Element? r = _rootElement;
    if (r == null) return '--';
    // The root element is, by definition, at depth 1 inside the framework's
    // internal depth scheme — but since we don't want to leak framework
    // internals, just report "0 (root)" in a human-readable form.
    return '${r.depth} (framework depth)';
  }

  String get _rootSlot {
    final Element? r = _rootElement;
    if (r == null) return '--';
    final Object? slot = r.slot;
    if (slot == null) return 'null (top of tree)';
    return slot.toString();
  }

  String get _rootChildCount {
    final Element? r = _rootElement;
    if (r == null) return '--';
    int count = 0;
    r.visitChildren((Element _) => count += 1);
    return count.toString();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _parchment,
      appBar: AppBar(
        title: const Text(
          'RootElement — Element Tree Root Viewer',
          style: TextStyle(color: _cream, fontWeight: FontWeight.w600),
        ),
        backgroundColor: _charcoal,
        iconTheme: const IconThemeData(color: _cream),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildLeadingBlurb(),
              const SizedBox(height: 20),
              _buildInspectorHero(),
              const SizedBox(height: 24),
              _buildSectionHeader(
                icon: Icons.schema,
                title: 'Element class hierarchy',
                subtitle:
                    'Where RootElement sits in the Flutter element class tree.',
              ),
              const SizedBox(height: 12),
              _buildHierarchyDiagram(),
              const SizedBox(height: 24),
              _buildSectionHeader(
                icon: Icons.radar,
                title: 'Live tree probe',
                subtitle:
                    'A walk of rootElement.visitChildren up to '
                    '$_kProbeMaxDepth levels deep, capped at $_kProbeCap rows.',
              ),
              const SizedBox(height: 12),
              _buildTreeProbe(),
              const SizedBox(height: 24),
              _buildSectionHeader(
                icon: Icons.workspaces,
                title: 'Four roles of RootElement',
                subtitle:
                    'The unique responsibilities that separate RootElement '
                    'from every other element in the tree.',
              ),
              const SizedBox(height: 12),
              _buildRoleCardsGrid(),
              const SizedBox(height: 24),
              _buildSectionHeader(
                icon: Icons.menu_book,
                title: 'When does RootElement exist?',
                subtitle:
                    'Lifecycle, code patterns, and the three classic '
                    'confusions worth clearing up.',
              ),
              const SizedBox(height: 12),
              _buildTeachingPanel(),
              const SizedBox(height: 24),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Leading blurb
  // ---------------------------------------------------------------------------

  Widget _buildLeadingBlurb() {
    return Container(
      decoration: BoxDecoration(
        color: _charcoal,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _charcoalLine, width: 1),
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _emerald.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _emerald, width: 1.5),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.star, color: _emerald, size: 24),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'RootElement',
                  style: TextStyle(
                    color: _cream,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'The single element instance returned by '
                  'WidgetsBinding.instance.rootElement. It is built for you, '
                  "not by you — the top of the tree, and Flutter's handoff "
                  'point between the embedder FlutterView and the widget '
                  'subtree you actually write.',
                  style: TextStyle(
                    color: Color(0xFFCFD3DC),
                    fontSize: 13,
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

  // ---------------------------------------------------------------------------
  // Section header
  // ---------------------------------------------------------------------------

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _charcoal,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: _emerald, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _slate,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _slateSoft,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Inspector hero card — IDE-inspector style
  // ---------------------------------------------------------------------------

  Widget _buildInspectorHero() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: _charcoal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: _charcoalLine, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _emerald,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Root Element Inspector',
                  style: TextStyle(
                    color: _cream,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: _charcoalSoft,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _charcoalLine, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  child: Text(
                    'gen $_inspectorGeneration',
                    style: const TextStyle(
                      color: _emerald,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Tooltip(
                  message: 'Re-probe rootElement',
                  child: IconButton(
                    icon: const Icon(Icons.refresh, color: _emerald),
                    splashRadius: 20,
                    onPressed: _runProbe,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: _charcoalLine),
            const SizedBox(height: 12),
            _buildInspectorRow(
              label: 'runtimeType',
              value: _rootRuntimeType,
              highlight: true,
            ),
            _buildInspectorRow(
              label: 'hashCode',
              value: _rootHashCode,
            ),
            _buildInspectorRow(
              label: 'debugMountState',
              value: _rootMountState,
            ),
            _buildInspectorRow(
              label: 'depth',
              value: _rootDepth,
            ),
            _buildInspectorRow(
              label: 'slot',
              value: _rootSlot,
            ),
            _buildInspectorRow(
              label: 'childCount (direct)',
              value: _rootChildCount,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectorRow({
    required String label,
    required String value,
    bool highlight = false,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: _charcoalLine, width: 0.5),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF9AA3B2),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: highlight ? _emerald : _cream,
                fontSize: 13,
                fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Hierarchy diagram
  // ---------------------------------------------------------------------------

  Widget _buildHierarchyDiagram() {
    return Container(
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _parchmentDeep, width: 1),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Main path — down to RootElement',
            style: TextStyle(
              color: _slate,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < _hierarchyMainPath.length; i++) ...<Widget>[
            _buildHierarchyNode(_hierarchyMainPath[i]),
            if (i < _hierarchyMainPath.length - 1) _buildHierarchyConnector(),
          ],
          const SizedBox(height: 20),
          const Divider(height: 1, color: _parchmentDeep),
          const SizedBox(height: 16),
          const Text(
            'Cousin branches — also descend from ComponentElement',
            style: TextStyle(
              color: _slate,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final _HierarchyNode branch in _hierarchyBranchPath)
                SizedBox(
                  width: 260,
                  child: _buildHierarchyNode(branch),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 26),
      child: Column(
        children: <Widget>[
          Container(
            width: 2,
            height: 14,
            color: _charcoalLine.withValues(alpha: 0.4),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 20,
            color: _charcoalLine.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyNode(_HierarchyNode node) {
    final bool isTarget = node.isTarget;
    final bool onPath = node.isOnRootPath;

    final Color fill = isTarget
        ? _emerald.withValues(alpha: 0.15)
        : onPath
            ? _parchmentDeep.withValues(alpha: 0.7)
            : _cream;
    final Color border = isTarget
        ? _emerald
        : onPath
            ? _emeraldDeep.withValues(alpha: 0.5)
            : _parchmentDeep;
    final double borderWidth = isTarget ? 2.5 : onPath ? 1.5 : 1;

    return Container(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border, width: borderWidth),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isTarget ? _emerald : _charcoal,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(
              node.icon,
              color: isTarget ? _cream : _emerald,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      node.name,
                      style: TextStyle(
                        color: _slate,
                        fontSize: 14,
                        fontWeight: isTarget ? FontWeight.w800 : FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (isTarget) ...<Widget>[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _emerald,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'THIS',
                          style: TextStyle(
                            color: _cream,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  node.description,
                  style: const TextStyle(
                    color: _slateSoft,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                if (node.branchLabel != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(
                    node.branchLabel!,
                    style: const TextStyle(
                      color: _emeraldDeep,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Live tree probe — depth-coloured list view
  // ---------------------------------------------------------------------------

  Widget _buildTreeProbe() {
    if (_probeRows.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: _cream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _parchmentDeep, width: 1),
        ),
        padding: const EdgeInsets.all(20),
        child: const Row(
          children: <Widget>[
            Icon(Icons.hourglass_empty, color: _slateSoft),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'No probe data yet — rootElement may not be ready. '
                'Try the Refresh button in the inspector panel above.',
                style: TextStyle(color: _slateSoft, fontSize: 13),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _parchmentDeep, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _ProbeRow row in _probeRows) _buildProbeRow(row),
          if (_truncatedRowCount > 0) ...<Widget>[
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                '…and $_truncatedRowCount more rows not shown (cap '
                '$_kProbeCap).',
                style: const TextStyle(
                  color: _slateSoft,
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProbeRow(_ProbeRow row) {
    // Depth 0 darkest, depth 4 lightest.
    final double t = (row.depth.clamp(0, _kProbeMaxDepth)) / _kProbeMaxDepth;
    final Color depthColor = Color.lerp(
          _charcoal,
          _parchment,
          t,
        ) ??
        _charcoal;

    final Color textColor = row.depth <= 1 ? _cream : _slate;
    final Color fill = row.isRoot
        ? _emerald.withValues(alpha: 0.18)
        : depthColor;
    final Color border = row.isRoot ? _emerald : Colors.transparent;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.only(
        left: 10 + (row.depth * 18.0),
        right: 12,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border, width: row.isRoot ? 1.5 : 0),
      ),
      child: Row(
        children: <Widget>[
          Text(
            row.isRoot ? '★' : '└─',
            style: TextStyle(
              color: row.isRoot ? _emerald : textColor.withValues(alpha: 0.7),
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'd${row.depth}',
              style: TextStyle(
                color: textColor,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              row.typeName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: 12.5,
                fontWeight: row.isRoot ? FontWeight.w800 : FontWeight.w500,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            row.hashFragment,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.75),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Role cards
  // ---------------------------------------------------------------------------

  Widget _buildRoleCardsGrid() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool wide = constraints.maxWidth >= 720;
        final double cardWidth =
            wide ? (constraints.maxWidth - 3 * 12) / 4 : 220;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final _RoleCard card in _roleCards)
              SizedBox(
                width: cardWidth.clamp(200, 320),
                height: 188,
                child: _buildRoleCard(card),
              ),
          ],
        );
      },
    );
  }

  Widget _buildRoleCard(_RoleCard card) {
    return Container(
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: card.accent.withValues(alpha: 0.55), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: card.accent.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: card.accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(card.icon, color: card.accent, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            card.title,
            style: const TextStyle(
              color: _slate,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              card.description,
              style: const TextStyle(
                color: _slate,
                fontSize: 11.8,
                height: 1.4,
              ),
              maxLines: 5,
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            card.seeAlso,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: card.accent,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Teaching panel
  // ---------------------------------------------------------------------------

  Widget _buildTeachingPanel() {
    return Container(
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _parchmentDeep, width: 1),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'When does RootElement exist?',
            style: TextStyle(
              color: _slate,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          _buildBullet(
            'Cold start — as soon as WidgetsBinding.instance.attachRootWidget '
            'has mounted the top widget, rootElement is non-null for the '
            'remainder of the app lifetime.',
          ),
          _buildBullet(
            'Hot restart — the old RootElement is unmounted, a new one is '
            'constructed, and WidgetsBinding.instance.rootElement is '
            'replaced in place.',
          ),
          _buildBullet(
            'Test binding — AutomatedTestWidgetsFlutterBinding installs a '
            'RootElement too, so tests can assert against rootElement '
            'exactly like a live app.',
          ),
          const SizedBox(height: 18),
          const Text(
            'Code pattern',
            style: TextStyle(
              color: _slate,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'final rootElement = WidgetsBinding.instance.rootElement;\n'
            'debugPrint(rootElement?.runtimeType.toString());'
            '  // RootElement',
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: _salmon.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _salmon.withValues(alpha: 0.7),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'heads up',
                  style: TextStyle(
                    color: Color(0xFFB74A38),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Common confusions',
                  style: TextStyle(
                    color: _slate,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final _Confusion c in _confusions) _buildConfusion(c),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 7),
            decoration: const BoxDecoration(
              color: _emerald,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _slate,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(String code) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _charcoal,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _charcoalLine, width: 1),
      ),
      padding: const EdgeInsets.all(14),
      child: Text(
        code,
        style: const TextStyle(
          color: _emerald,
          fontSize: 12,
          fontFamily: 'monospace',
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildConfusion(_Confusion c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _salmonSoft.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _salmon.withValues(alpha: 0.55),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildConfusionToken(c.left, isFirst: true),
              const SizedBox(width: 6),
              const Text(
                'vs',
                style: TextStyle(
                  color: _slateSoft,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(child: _buildConfusionToken(c.right, isFirst: false)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            c.resolution,
            style: const TextStyle(
              color: _slate,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfusionToken(String label, {required bool isFirst}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isFirst ? _emerald.withValues(alpha: 0.18) : _cream,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isFirst ? _emerald : _slateSoft.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isFirst ? _emeraldDeep : _slate,
          fontSize: 11.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Footer
  // ---------------------------------------------------------------------------

  Widget _buildFooter() {
    return Container(
      decoration: BoxDecoration(
        color: _charcoal,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          const Icon(Icons.info_outline, color: _emerald, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Inspector generation $_inspectorGeneration · probe cap '
              '$_kProbeCap · max depth $_kProbeMaxDepth · palette charcoal / '
              'emerald / salmon.',
              style: const TextStyle(
                color: Color(0xFFCFD3DC),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
