import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// RootRenderObjectElement — Render Tree Genesis
// ---------------------------------------------------------------------------
//
// This file is a deep, teaching-oriented demo for Flutter's
// `RootRenderObjectElement`. That class is the anchor point where Flutter's
// three parallel trees — the widget tree, the element tree, and the render
// object tree — touch the framework's pipeline owner and become a "live"
// running user interface.
//
// The demo does NOT subclass `RootRenderObjectElement` — that class is
// framework-internal and should never be subclassed by application code.
// Instead, it VISUALISES what the root means: it draws the three trees side
// by side, probes the live root render object via `WidgetsBinding`, walks
// through the four pipeline phases (build → layout → paint → composite),
// shows how a pointer event enters at the root and is dispatched downward
// to leaf render objects, and finally offers a small teaching panel with a
// simplified class signature.
//
// Palette: deep violet + warm peach + gold accent. These colours are used
// consistently across helper widgets to distinguish this demo from its
// sibling `root_element_test.dart`, which uses charcoal + emerald.
//
// Harness rules:
//   * top-level `dynamic build(BuildContext context)` returns a MaterialApp.
//   * no `main()`, no `runApp()`, no RestorationMixin.
//   * only `package:flutter/material.dart` + `package:flutter/rendering.dart`.
//   * no `// ignore_for_file:` comments. `debugPrint` not `print`.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

const Color _kVioletDeep = Color(0xFF3B1F6B);
const Color _kVioletMid = Color(0xFF5D3FA8);
const Color _kVioletSoft = Color(0xFFBFA7E8);
const Color _kPeachWarm = Color(0xFFFFB38A);
const Color _kPeachSoft = Color(0xFFFFE2CE);
const Color _kGoldAccent = Color(0xFFE8B339);
const Color _kGoldSoft = Color(0xFFFFE9B3);
const Color _kInk = Color(0xFF231237);
const Color _kInkSoft = Color(0xFF534567);
const Color _kPaper = Color(0xFFFBF7EE);
const Color _kPaperMid = Color(0xFFF2EAD8);

// Tree-specific colours for the trinity diagram.
const Color _kWidgetTreeColour = Color(0xFF2E6FB5); // blue
const Color _kWidgetTreeSoft = Color(0xFFCFE1F4);
const Color _kElementTreeColour = Color(0xFF1E8A6D); // emerald
const Color _kElementTreeSoft = Color(0xFFCFEFE1);
const Color _kRenderTreeColour = Color(0xFFB8791F); // amber
const Color _kRenderTreeSoft = Color(0xFFF7E7C4);

// ---------------------------------------------------------------------------
// Harness entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('=== RootRenderObjectElement Deep Demo — boot ===');
  debugPrint('Palette: deep violet + warm peach + gold accent.');
  debugPrint('Theme: Render Tree Genesis.');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Render Tree Genesis',
    home: RenderTreeGenesisDemo(),
  );
}

// ---------------------------------------------------------------------------
// RenderTreeGenesisDemo — StatefulWidget
// ---------------------------------------------------------------------------

class RenderTreeGenesisDemo extends StatefulWidget {
  const RenderTreeGenesisDemo({super.key});

  @override
  State<RenderTreeGenesisDemo> createState() => _RenderTreeGenesisDemoState();
}

class _RenderTreeGenesisDemoState extends State<RenderTreeGenesisDemo> {
  // State-kept snapshots of the last render-tree probe. We refresh them on
  // demand so the user can see changes after a layout pass.
  _RootProbeSnapshot _probe = const _RootProbeSnapshot.empty();

  // Simulated hit-test trace for the pointer-entry panel. We don't actually
  // perform a hit test — we render a believable narrative so users learn the
  // order in which render objects are consulted.
  final List<String> _hitTrace = <String>[
    'pointer down at (172, 384)',
    'RenderView.hitTest entered',
    'walked into RenderPadding (padding: 16)',
    'walked into RenderConstrainedBox',
    'walked into RenderParagraph (leaf)',
    'hit test returned true, dispatching to gesture arena',
  ];

  @override
  void initState() {
    super.initState();
    debugPrint('[RenderTreeGenesis] initState — narrating the boot sequence.');
    debugPrint('[RenderTreeGenesis]   1. buildOwner kicks rebuild list.');
    debugPrint('[RenderTreeGenesis]   2. root element attaches pipeline.');
    debugPrint('[RenderTreeGenesis]   3. RenderView schedules first frame.');
    debugPrint('[RenderTreeGenesis]   4. Layout walks from RenderView down.');
    debugPrint('[RenderTreeGenesis]   5. Paint produces a layer tree.');
    debugPrint('[RenderTreeGenesis]   6. Engine composites and presents.');
    // Probe once after first frame so the live panel has real data.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshProbe(silent: true);
    });
  }

  void _refreshProbe({bool silent = false}) {
    final _RootProbeSnapshot next = _probeRoot();
    if (!silent) {
      debugPrint('[RenderTreeGenesis] probe refresh: '
          'root=${next.rootRuntimeType} attached=${next.attached} '
          'children=${next.childCount}');
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _probe = next;
    });
  }

  _RootProbeSnapshot _probeRoot() {
    // Try to reach the live root element and its render object. Both may be
    // null in pathological harness runs, so we handle that gracefully.
    final Element? rootElement = WidgetsBinding.instance.rootElement;
    if (rootElement == null) {
      return _RootProbeSnapshot(
        rootRuntimeType: 'RenderView (root pipeline owner)',
        hasSize: null,
        attached: false,
        ownerRuntimeType: 'PipelineOwner (unreachable)',
        childCount: 0,
        note: 'WidgetsBinding.instance.rootElement was null — probe fallback.',
      );
    }
    final RenderObject? rootRender = rootElement.renderObject;
    if (rootRender == null) {
      return _RootProbeSnapshot(
        rootRuntimeType: 'RenderView (root pipeline owner)',
        hasSize: null,
        attached: false,
        ownerRuntimeType: 'PipelineOwner (unreachable)',
        childCount: 0,
        note: 'rootElement.renderObject was null — probe fallback.',
      );
    }
    bool? hasSize;
    if (rootRender is RenderBox) {
      hasSize = rootRender.hasSize;
    }
    // Count children via visitChildren (capped for safety).
    int count = 0;
    rootRender.visitChildren((RenderObject child) {
      count += 1;
    });
    return _RootProbeSnapshot(
      rootRuntimeType: rootRender.runtimeType.toString(),
      hasSize: hasSize,
      attached: rootRender.attached,
      ownerRuntimeType: rootRender.owner?.runtimeType.toString() ??
          'PipelineOwner (detached)',
      childCount: count,
      note: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPaper,
      appBar: AppBar(
        backgroundColor: _kVioletDeep,
        foregroundColor: _kPaper,
        elevation: 0,
        titleSpacing: 20,
        title: const Row(
          children: <Widget>[
            Icon(Icons.account_tree_rounded, size: 22),
            SizedBox(width: 10),
            Text(
              'RootRenderObjectElement — Render Tree Genesis',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _kGoldAccent.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'framework-internal class',
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
          children: <Widget>[
            _buildHeroHeader(),
            const SizedBox(height: 24),
            _buildTrinityDiagram(),
            const SizedBox(height: 24),
            _buildRenderProbe(),
            const SizedBox(height: 24),
            _buildPipelineStrip(),
            const SizedBox(height: 24),
            _buildHitTestPanel(),
            const SizedBox(height: 24),
            _buildTeachingPanel(),
            const SizedBox(height: 16),
            _buildFooterBand(),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Hero header — sets the tone + palette
  // -------------------------------------------------------------------------

  Widget _buildHeroHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kVioletDeep, _kVioletMid],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kVioletDeep.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: _kGoldAccent.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.hub_rounded,
              color: _kInk,
              size: 30,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Where does Flutter layout begin?',
                  style: TextStyle(
                    color: _kPaper,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'At the RootRenderObjectElement — the anchor that binds the '
                  'widget tree, the element tree, and the render-object tree '
                  "to the framework's pipeline owner and scheduler.",
                  style: TextStyle(
                    color: _kPaper.withValues(alpha: 0.92),
                    fontSize: 13.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _buildHeroPill('three-tree trinity'),
                    _buildHeroPill('live root probe'),
                    _buildHeroPill('pipeline phases'),
                    _buildHeroPill('hit-test origin'),
                    _buildHeroPill('framework-internal'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _kPaper.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: _kPaper.withValues(alpha: 0.32),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _kPaper.withValues(alpha: 0.95),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 1 — Three-tree trinity diagram
  // -------------------------------------------------------------------------

  Widget _buildTrinityDiagram() {
    return _SectionCard(
      title: 'Three-tree trinity',
      subtitle:
          'Widgets configure. Elements mediate. Render objects do the work. '
          'The root element is where these three trees touch the framework.',
      accent: _kVioletMid,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _buildTreeColumn(
                    header: 'Widget tree',
                    subheader: 'immutable configuration',
                    accent: _kWidgetTreeColour,
                    accentSoft: _kWidgetTreeSoft,
                    rootLabel: null,
                    nodes: const <String>[
                      'MaterialApp',
                      'Scaffold',
                      'Column',
                      'Padding',
                      'Text',
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildTreeColumn(
                    header: 'Element tree',
                    subheader: 'lifecycle + inflation',
                    accent: _kElementTreeColour,
                    accentSoft: _kElementTreeSoft,
                    rootLabel: 'RootRenderObjectElement',
                    nodes: const <String>[
                      'StatefulElement(MaterialApp)',
                      'StatefulElement(Scaffold)',
                      'MultiChildRenderObjectElement',
                      'SingleChildRenderObjectElement',
                      'LeafRenderObjectElement(Text)',
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildTreeColumn(
                    header: 'RenderObject tree',
                    subheader: 'layout + paint + hit-test',
                    accent: _kRenderTreeColour,
                    accentSoft: _kRenderTreeSoft,
                    rootLabel: 'RenderView',
                    nodes: const <String>[
                      'RenderView',
                      'RenderPadding',
                      'RenderFlex',
                      'RenderConstrainedBox',
                      'RenderParagraph',
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTrinityLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeColumn({
    required String header,
    required String subheader,
    required Color accent,
    required Color accentSoft,
    required String? rootLabel,
    required List<String> nodes,
  }) {
    final List<Widget> children = <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              header,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subheader,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    ];
    for (int i = 0; i < nodes.length; i++) {
      final bool isRoot = i == 0 && rootLabel != null;
      children.add(const SizedBox(height: 8));
      children.add(
        _buildTreeNode(
          label: nodes[i],
          accent: accent,
          accentSoft: accentSoft,
          isRoot: isRoot,
          rootLabel: isRoot ? rootLabel : null,
        ),
      );
      if (i != nodes.length - 1) {
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Icon(
              Icons.arrow_downward_rounded,
              size: 18,
              color: accent.withValues(alpha: 0.75),
            ),
          ),
        );
      }
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentSoft, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget _buildTreeNode({
    required String label,
    required Color accent,
    required Color accentSoft,
    required bool isRoot,
    String? rootLabel,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: accentSoft,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: accent.withValues(alpha: isRoot ? 1.0 : 0.45),
          width: isRoot ? 2.4 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (isRoot)
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'ROOT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          Text(
            label,
            style: TextStyle(
              color: _kInk,
              fontSize: 12,
              fontWeight: isRoot ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          if (isRoot && rootLabel != null && rootLabel != label)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                'aka $rootLabel',
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrinityLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPaperMid,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kVioletSoft.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.lightbulb_outline_rounded,
                  size: 16, color: _kVioletDeep),
              const SizedBox(width: 6),
              const Text(
                'How to read the diagram',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Each column shows a separate tree. Arrows indicate parent → child '
            'relationships. The thick bordered boxes at the top of the middle '
            'and right columns are ROOT positions — the RootRenderObjectElement '
            'and its RenderView render object respectively. The widget tree has '
            'no explicit "root element" concept because widgets are immutable '
            'configuration objects, not stateful anchors.',
            style: TextStyle(
              color: _kInkSoft,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 2 — Live render tree probe
  // -------------------------------------------------------------------------

  Widget _buildRenderProbe() {
    return _SectionCard(
      title: 'Live render tree probe',
      subtitle: 'We query WidgetsBinding.instance.rootElement, walk to its '
          'RenderObject, and print a few observable properties.',
      accent: _kPeachWarm,
      trailing: TextButton.icon(
        onPressed: () => _refreshProbe(),
        icon: const Icon(Icons.refresh_rounded, size: 18),
        label: const Text('Refresh probe'),
        style: TextButton.styleFrom(
          foregroundColor: _kVioletDeep,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildProbeTable(_probe),
            if (_probe.note != null) ...<Widget>[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kGoldSoft,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _kGoldAccent.withValues(alpha: 0.55),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: _kInk,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _probe.note!,
                        style: const TextStyle(
                          color: _kInk,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 14),
            _buildProbeCallout(),
          ],
        ),
      ),
    );
  }

  Widget _buildProbeTable(_RootProbeSnapshot probe) {
    final List<_ProbeRow> rows = <_ProbeRow>[
      _ProbeRow('runtimeType', probe.rootRuntimeType),
      _ProbeRow(
        'hasSize',
        probe.hasSize == null ? '— (not a RenderBox)' : '${probe.hasSize}',
      ),
      _ProbeRow('attached', '${probe.attached}'),
      _ProbeRow('owner.runtimeType', probe.ownerRuntimeType),
      _ProbeRow('child count (visitChildren)', '${probe.childCount}'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kVioletSoft.withValues(alpha: 0.45)),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            _buildProbeTableRow(rows[i], i.isOdd),
        ],
      ),
    );
  }

  Widget _buildProbeTableRow(_ProbeRow row, bool isOdd) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isOdd ? _kPaperMid : _kPaper,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              row.label,
              style: const TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.value,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProbeCallout() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _kPeachSoft.withValues(alpha: 0.9),
            _kGoldSoft.withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kPeachWarm.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.sensors_rounded,
            color: _kInk,
            size: 18,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Probes come from WidgetsBinding.instance.rootElement. In older "
              "Flutter versions WidgetsBinding.instance.renderViewElement was "
              "used directly but is now deprecated — reach the render object "
              "via rootElement?.renderObject instead. The owner is always a "
              "PipelineOwner created by the binding, not something user code "
              "constructs.",
              style: TextStyle(
                color: _kInk,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 3 — Pipeline responsibility strip
  // -------------------------------------------------------------------------

  Widget _buildPipelineStrip() {
    return _SectionCard(
      title: 'Pipeline phases the root kicks off',
      subtitle: 'Every frame, the root element / render object drives these '
          'four phases in order. All four must succeed for a frame to appear.',
      accent: _kGoldAccent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _buildPhaseCard(
                index: 1,
                title: 'Build phase',
                description:
                    'buildScope runs the dirty element list, reconciling '
                    'widgets into elements and creating render objects.',
                icon: Icons.construction,
                accent: _kWidgetTreeColour,
                accentSoft: _kWidgetTreeSoft,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildPhaseCard(
                index: 2,
                title: 'Layout phase',
                description:
                    'performLayout starts at RenderView with incoming '
                    'viewport constraints and walks to each leaf.',
                icon: Icons.view_column_rounded,
                accent: _kElementTreeColour,
                accentSoft: _kElementTreeSoft,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildPhaseCard(
                index: 3,
                title: 'Paint phase',
                description:
                    'Paint recorders walk from root, producing a layer tree '
                    'of drawing commands for the engine to replay.',
                icon: Icons.brush_rounded,
                accent: _kRenderTreeColour,
                accentSoft: _kRenderTreeSoft,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildPhaseCard(
                index: 4,
                title: 'Composite phase',
                description:
                    'The engine composites the layer tree and calls '
                    'scheduleFrame for the next vsync.',
                icon: Icons.layers_rounded,
                accent: _kVioletMid,
                accentSoft: _kVioletSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseCard({
    required int index,
    required String title,
    required String description,
    required IconData icon,
    required Color accent,
    required Color accentSoft,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accentSoft,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '#$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: _kInk,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: _kGoldSoft,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: _kGoldAccent.withValues(alpha: 0.55),
              ),
            ),
            child: const Text(
              'fires on each frame',
              style: TextStyle(
                color: _kInk,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 4 — Hit-test / paint origin panel
  // -------------------------------------------------------------------------

  Widget _buildHitTestPanel() {
    return _SectionCard(
      title: 'Hit-test origin — pointer enters at the root',
      subtitle: 'Pointer events always enter the render tree at the root. From '
          'there they walk downward until a leaf claims them.',
      accent: _kVioletSoft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: _buildPhoneMock(),
            ),
            const SizedBox(width: 18),
            Expanded(
              flex: 4,
              child: _buildHitTestTrace(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneMock() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kPaperMid,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kVioletSoft),
      ),
      child: AspectRatio(
        aspectRatio: 9 / 18,
        child: Container(
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _kVioletDeep, width: 2),
          ),
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              // Simulated screen content.
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: _kPaper,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 18,
                        decoration: BoxDecoration(
                          color: _kVioletMid,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: _kVioletSoft,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 10,
                        width: 80,
                        decoration: BoxDecoration(
                          color: _kVioletSoft,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: _kPeachWarm,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Tap here',
                          style: TextStyle(
                            color: _kInk,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Simulated finger-tap indicator.
              Positioned(
                right: 28,
                bottom: 48,
                child: _buildTapIndicator(),
              ),
              // Arrow + caption pointing into the tree on the right side.
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _kGoldAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'PointerDown',
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTapIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _kGoldAccent.withValues(alpha: 0.35),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 14,
          height: 14,
          decoration: const BoxDecoration(
            color: _kGoldAccent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildHitTestTrace() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kVioletSoft.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.route_rounded, color: _kVioletDeep, size: 18),
              const SizedBox(width: 6),
              const Text(
                'Trace — a pointer walking the tree',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildRenderMiniTree(),
          const SizedBox(height: 14),
          for (int i = 0; i < _hitTrace.length; i++) _buildTraceLine(i),
          const SizedBox(height: 8),
          Text(
            'Note: this is a believable, narrated walk — not live capture. '
            'In a real app the trace would come from a GestureBinding '
            'HitTestResult.',
            style: TextStyle(
              color: _kInkSoft.withValues(alpha: 0.85),
              fontSize: 11,
              fontStyle: FontStyle.italic,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRenderMiniTree() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kPaperMid,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildMiniNode('RenderView', isRoot: true),
          const Icon(Icons.arrow_forward_rounded,
              size: 16, color: _kInkSoft),
          _buildMiniNode('RenderPadding'),
          const Icon(Icons.arrow_forward_rounded,
              size: 16, color: _kInkSoft),
          _buildMiniNode('RenderParagraph', isLeaf: true),
        ],
      ),
    );
  }

  Widget _buildMiniNode(String label,
      {bool isRoot = false, bool isLeaf = false}) {
    final Color tint = isRoot
        ? _kRenderTreeColour
        : isLeaf
            ? _kPeachWarm
            : _kVioletSoft;
    final Color tintSoft = isRoot
        ? _kRenderTreeSoft
        : isLeaf
            ? _kPeachSoft
            : _kVioletSoft.withValues(alpha: 0.35);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: tintSoft,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint, width: isRoot ? 2 : 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isRoot)
            const Text(
              'ROOT',
              style: TextStyle(
                color: _kInk,
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          if (isLeaf)
            const Text(
              'LEAF',
              style: TextStyle(
                color: _kInk,
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          Text(
            label,
            style: const TextStyle(
              color: _kInk,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTraceLine(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kVioletMid,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _hitTrace[index],
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                fontFamily: 'monospace',
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 5 — Teaching panel
  // -------------------------------------------------------------------------

  Widget _buildTeachingPanel() {
    return _SectionCard(
      title: 'Teaching panel — take these with you',
      subtitle: 'Three short columns + a signature snippet. Internalise these '
          'and the rest of the framework becomes legible.',
      accent: _kPeachWarm,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _buildTeachingColumn(
                    icon: Icons.stars_rounded,
                    accent: _kVioletDeep,
                    title: 'Why root is special',
                    bullets: const <String>[
                      'It has no parent Element — its "parent" is the binding.',
                      'It holds the link to the PipelineOwner and BuildOwner.',
                      'It owns the RenderView, the top of the render tree.',
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTeachingColumn(
                    icon: Icons.block_rounded,
                    accent: _kPeachWarm,
                    title: "How you'd subclass it",
                    bullets: const <String>[
                      'Never. It is a framework-internal implementation detail.',
                      'Application code extends SingleChildRenderObjectWidget or MultiChildRenderObjectWidget.',
                      'Custom render objects live on the RenderObject side, not the Element side.',
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTeachingColumn(
                    icon: Icons.bookmark_rounded,
                    accent: _kGoldAccent,
                    title: 'What to remember',
                    bullets: const <String>[
                      'The three trees are rooted at the root element + RenderView.',
                      'Layout walks downward from the root; intrinsic sizing walks upward from leaves.',
                      'Pointer events always enter at the root render object.',
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _buildSignatureSnippet(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeachingColumn({
    required IconData icon,
    required Color accent,
    required String title,
    required List<String> bullets,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final String bullet in bullets) _buildTeachingBullet(bullet),
        ],
      ),
    );
  }

  Widget _buildTeachingBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 6),
            child: Icon(
              Icons.circle,
              size: 6,
              color: _kVioletMid,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureSnippet() {
    const String code = '''
abstract class RootRenderObjectElement extends RenderObjectElement {
  /// Called by the binding to attach the pipeline owner.
  void assignOwner(BuildOwner owner);

  /// Bootstraps the root into the element tree on the first frame.
  void mount(Element? parent, Object? newSlot);

  // ... framework internal ...
}''';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGoldAccent.withValues(alpha: 0.65)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF6B6B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: _kGoldAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF2DCC70),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'RootRenderObjectElement.dart (simplified)',
                style: TextStyle(
                  color: _kPaper.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            code,
            style: TextStyle(
              color: Color(0xFFF5E7C6),
              fontSize: 12.5,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Footer band — wraps the demo with a reminder
  // -------------------------------------------------------------------------

  Widget _buildFooterBand() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: _kVioletDeep,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.library_books_rounded,
              color: _kGoldAccent, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'TL;DR',
                  style: TextStyle(
                    color: _kGoldAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'RootRenderObjectElement is where the three trees meet the '
                  'binding. You never subclass it, but understanding it gives '
                  'you the mental model for build, layout, paint, composite, '
                  'and hit-test — the whole Flutter pipeline.',
                  style: TextStyle(
                    color: _kPaper.withValues(alpha: 0.92),
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
}

// ---------------------------------------------------------------------------
// Reusable section card (shared by every numbered section above)
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kVioletSoft.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 14, 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.18),
                  accent.withValues(alpha: 0.04),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: accent.withValues(alpha: 0.35),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 6,
                  height: 44,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: _kInk,
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: _kInkSoft,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null) ...<Widget>[
                  const SizedBox(width: 8),
                  trailing!,
                ],
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small data helpers — grouped at the bottom so the widget body stays scannable
// ---------------------------------------------------------------------------

class _ProbeRow {
  const _ProbeRow(this.label, this.value);
  final String label;
  final String value;
}

class _RootProbeSnapshot {
  const _RootProbeSnapshot({
    required this.rootRuntimeType,
    required this.hasSize,
    required this.attached,
    required this.ownerRuntimeType,
    required this.childCount,
    required this.note,
  });

  const _RootProbeSnapshot.empty()
      : rootRuntimeType = 'RenderView (probe pending)',
        hasSize = null,
        attached = false,
        ownerRuntimeType = 'PipelineOwner (probe pending)',
        childCount = 0,
        note = 'Probe has not run yet — waiting for first frame.';

  final String rootRuntimeType;
  final bool? hasSize;
  final bool attached;
  final String ownerRuntimeType;
  final int childCount;
  final String? note;
}
