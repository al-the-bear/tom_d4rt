// RootElementMixin — BuildOwner Assignment Lab (deep demo).
//
// This harness file does NOT instantiate `RootElementMixin` directly; that is
// impossible from user code, because `RootElementMixin` is a framework-internal
// mixin applied to the single root `Element` produced by
// `WidgetsBinding.attachRootWidget`. Instead this demo VISUALISES what the
// mixin does and surfaces live readings from `WidgetsBinding.instance` so a
// learner can see the abstract machinery with their own eyes.
//
// Teaching arc:
//   1. runApp → WidgetsBinding.attachRootWidget → creates a root element.
//   2. That root element is the one spot in the tree that applies
//      RootElementMixin. The mixin exposes `assignOwner(BuildOwner owner)`.
//   3. The BuildOwner then drives the whole build/rebuild cycle beneath it.
//   4. Swapping the owner (hot reload, test bindings, multi-window embedders)
//      happens through this one seam.
//
// Harness rules honoured here:
//   * top-level `dynamic build(BuildContext context)` returns MaterialApp;
//   * no main/runApp;
//   * StatefulWidget + State + WidgetsBindingObserver;
//   * no RestorationMixin (this demo is about owner/element, not restoration);
//   * tolerates `WidgetsBinding.instance.rootElement == null` on early frames;
//   * uses `debugPrint`, never bare `print`;
//   * uses `withValues(alpha: …)` instead of the deprecated `.withOpacity`.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Entry point expected by the harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RootElementMixin · BuildOwner Assignment Lab',
    home: BuildOwnerAssignmentLabDemo(),
  );
}

// ---------------------------------------------------------------------------
// Palette — steel + electric blue + gentle red accent.
// ---------------------------------------------------------------------------
class _LabPalette {
  static const Color canvas = Color(0xFF0F1620);
  static const Color surface = Color(0xFF182334);
  static const Color surfaceRaised = Color(0xFF22314A);
  static const Color steel = Color(0xFF4E6680);
  static const Color steelSoft = Color(0xFF92A2B8);
  static const Color ink = Color(0xFFE4EBF3);
  static const Color inkMuted = Color(0xFFB6C2D0);
  static const Color electric = Color(0xFF3B82F6);
  static const Color electricSoft = Color(0xFF60A5FA);
  static const Color electricGlow = Color(0xFF1D4ED8);
  static const Color accent = Color(0xFFE05260);
  static const Color accentSoft = Color(0xFFF58490);
  static const Color success = Color(0xFF3CA374);
  static const Color outline = Color(0xFF2E3C54);
}

// ---------------------------------------------------------------------------
// The demo widget.
// ---------------------------------------------------------------------------
class BuildOwnerAssignmentLabDemo extends StatefulWidget {
  const BuildOwnerAssignmentLabDemo({super.key});

  @override
  State<BuildOwnerAssignmentLabDemo> createState() =>
      _BuildOwnerAssignmentLabDemoState();
}

class _BuildOwnerAssignmentLabDemoState
    extends State<BuildOwnerAssignmentLabDemo>
    with WidgetsBindingObserver {
  // Diagnostics state — rendered in section 2 and elsewhere.
  int _refreshCounter = 0;
  DateTime _lastRefreshAt = DateTime.now();
  String _rootRuntimeType = '--';
  String _focusManagerRuntimeType = '--';
  int? _buildOwnerHash;
  bool _rootAttached = false;
  int _directChildren = 0;
  List<_TreeNode> _treeSnapshot = const <_TreeNode>[];

  // Which pipeline box is considered "active" on the hero diagram. This is
  // hardcoded to the RootElementMixin box per spec.
  static const int _activePipelineIndex = 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint(
      'BuildOwnerAssignmentLabDemo: ready, inspecting WidgetsBinding state…',
    );
    // First probe happens after the first frame so the root element exists.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      debugPrint(
        'BuildOwnerAssignmentLabDemo: first post-frame — capturing initial '
        'diagnostics snapshot.',
      );
      _collectDiagnostics(initial: true);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint(
      'BuildOwnerAssignmentLabDemo: disposed; WidgetsBindingObserver removed.',
    );
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    debugPrint(
      'BuildOwnerAssignmentLabDemo: didChangeMetrics — triggering refresh.',
    );
    _collectDiagnostics();
  }

  // -------------------------------------------------------------------------
  // Diagnostics collection.
  // -------------------------------------------------------------------------
  void _collectDiagnostics({bool initial = false}) {
    final WidgetsBinding binding = WidgetsBinding.instance;
    final Element? root = binding.rootElement;
    final BuildOwner owner = binding.buildOwner!;
    final FocusManager fm = binding.focusManager;

    int directChildren = 0;
    List<_TreeNode> snapshot;
    if (root != null) {
      root.visitChildren((Element child) {
        directChildren++;
      });
      snapshot = _probeTree(root, maxDepth: 3);
    } else {
      snapshot = const <_TreeNode>[];
    }

    setState(() {
      _refreshCounter += initial ? 0 : 1;
      _lastRefreshAt = DateTime.now();
      _rootRuntimeType = root?.runtimeType.toString() ?? '--';
      _focusManagerRuntimeType = fm.runtimeType.toString();
      _buildOwnerHash = owner.hashCode;
      _rootAttached = root != null;
      _directChildren = directChildren;
      _treeSnapshot = snapshot;
    });

    debugPrint(
      'BuildOwnerAssignmentLabDemo: diagnostics refresh #$_refreshCounter — '
      'rootAttached=$_rootAttached, directChildren=$directChildren, '
      'treeDepthSampled=${_treeSnapshot.isEmpty ? 0 : _maxDepth(_treeSnapshot)}',
    );
  }

  // Recursive tree walk, depth-limited.
  List<_TreeNode> _probeTree(Element root, {required int maxDepth}) {
    final List<_TreeNode> results = <_TreeNode>[];
    _walk(root, 0, maxDepth, results);
    return results;
  }

  void _walk(
    Element element,
    int depth,
    int maxDepth,
    List<_TreeNode> sink,
  ) {
    if (depth > maxDepth) {
      return;
    }
    final List<_TreeNode> children = <_TreeNode>[];
    element.visitChildren((Element child) {
      _walk(child, depth + 1, maxDepth, children);
    });
    sink.add(
      _TreeNode(
        type: element.runtimeType.toString(),
        depth: depth,
        children: children,
      ),
    );
    debugPrint(
      '  tree-walk: depth=$depth type=${element.runtimeType} '
      'children=${children.length}',
    );
  }

  int _maxDepth(List<_TreeNode> nodes) {
    int best = 0;
    for (final _TreeNode n in nodes) {
      if (n.depth > best) {
        best = n.depth;
      }
      final int inner = _maxDepth(n.children);
      if (inner > best) {
        best = inner;
      }
    }
    return best;
  }

  // -------------------------------------------------------------------------
  // Build.
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _LabPalette.canvas,
      appBar: AppBar(
        backgroundColor: _LabPalette.surface,
        foregroundColor: _LabPalette.ink,
        elevation: 0,
        title: const Text(
          'RootElementMixin · BuildOwner Assignment Lab',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: _HeaderChip(
                label: 'refresh #$_refreshCounter',
                color: _LabPalette.electric,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeroIntro(),
              const SizedBox(height: 20),
              _buildArchitectureDiagram(),
              const SizedBox(height: 20),
              _buildLiveDiagnostics(),
              const SizedBox(height: 20),
              _buildScenarioStrip(),
              const SizedBox(height: 20),
              _buildTreeProbe(),
              const SizedBox(height: 20),
              _buildTeachingPanel(),
              const SizedBox(height: 28),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section: hero intro.
  // -------------------------------------------------------------------------
  Widget _buildHeroIntro() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _LabPalette.surface,
            _LabPalette.surfaceRaised,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _LabPalette.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _LabPalette.electric.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _LabPalette.electric.withValues(alpha: 0.55),
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.hub_rounded,
              color: _LabPalette.electricSoft,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'The seam between runApp and the Element tree',
                  style: TextStyle(
                    color: _LabPalette.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'RootElementMixin is a framework-internal mixin applied to '
                  'the single root Element of a Flutter app. Its only public '
                  'surface is assignOwner(BuildOwner owner) — the hook that '
                  'lets WidgetsBinding bolt a BuildOwner onto the tree so the '
                  'build / rebuild cycle has somewhere to report. Everything '
                  'below (widgets, elements, render objects) hangs off that '
                  'one assignment.',
                  style: TextStyle(
                    color: _LabPalette.inkMuted,
                    fontSize: 14,
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

  // -------------------------------------------------------------------------
  // Section 1: architecture pipeline diagram.
  // -------------------------------------------------------------------------
  Widget _buildArchitectureDiagram() {
    final List<_PipelineStage> stages = <_PipelineStage>[
      const _PipelineStage(
        title: 'runApp()',
        description: 'App bootstraps the binding & hands over the root widget.',
        icon: Icons.play_arrow_rounded,
      ),
      const _PipelineStage(
        title: 'WidgetsBinding.attachRootWidget',
        description: 'Creates the root element and schedules the first build.',
        icon: Icons.link_rounded,
      ),
      const _PipelineStage(
        title: 'RootElement + RootElementMixin',
        description: 'The one element that exposes assignOwner(BuildOwner).',
        icon: Icons.account_tree_rounded,
      ),
      const _PipelineStage(
        title: 'BuildOwner',
        description: 'Drives buildScope, dirty list, rebuild scheduling.',
        icon: Icons.engineering_rounded,
      ),
      const _PipelineStage(
        title: 'Element subtree',
        description: 'Every child Element is reachable from the root.',
        icon: Icons.device_hub_rounded,
      ),
      const _PipelineStage(
        title: 'RenderObject tree',
        description: 'Paints, lays out, composites into a frame.',
        icon: Icons.grid_on_rounded,
      ),
    ];

    return _SectionCard(
      title: 'Architecture diagram',
      subtitle:
          'Where RootElementMixin sits in the pipeline from runApp to pixels.',
      icon: Icons.schema_rounded,
      accent: _LabPalette.electric,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool horizontal = constraints.maxWidth >= 860;
          if (horizontal) {
            final List<Widget> row = <Widget>[];
            for (int i = 0; i < stages.length; i++) {
              row.add(
                Flexible(
                  child: _buildPipelineBox(
                    stage: stages[i],
                    active: i == _activePipelineIndex,
                  ),
                ),
              );
              if (i != stages.length - 1) {
                row.add(_buildArrow(horizontal: true));
              }
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: row,
            );
          }
          final List<Widget> col = <Widget>[];
          for (int i = 0; i < stages.length; i++) {
            col.add(
              _buildPipelineBox(
                stage: stages[i],
                active: i == _activePipelineIndex,
              ),
            );
            if (i != stages.length - 1) {
              col.add(_buildArrow(horizontal: false));
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: col,
          );
        },
      ),
    );
  }

  Widget _buildPipelineBox({
    required _PipelineStage stage,
    required bool active,
  }) {
    final Color border =
        active ? _LabPalette.electricSoft : _LabPalette.outline;
    final Color fill =
        active ? _LabPalette.electricGlow.withValues(alpha: 0.22) : _LabPalette.surface;
    final Color iconTint =
        active ? _LabPalette.electricSoft : _LabPalette.steelSoft;

    return Container(
      constraints: const BoxConstraints(minHeight: 132),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: border,
          width: active ? 2 : 1,
        ),
        boxShadow: active
            ? <BoxShadow>[
                BoxShadow(
                  color: _LabPalette.electric.withValues(alpha: 0.45),
                  blurRadius: 22,
                  spreadRadius: 1,
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(stage.icon, color: iconTint, size: 20),
              const SizedBox(width: 8),
              if (active)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _LabPalette.electric.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: _LabPalette.electricSoft.withValues(alpha: 0.8),
                    ),
                  ),
                  child: const Text(
                    'FOCUS',
                    style: TextStyle(
                      color: _LabPalette.electricSoft,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            stage.title,
            style: const TextStyle(
              color: _LabPalette.ink,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            stage.description,
            style: const TextStyle(
              color: _LabPalette.inkMuted,
              fontSize: 11,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow({required bool horizontal}) {
    if (horizontal) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Center(
          child: Icon(
            Icons.arrow_forward_rounded,
            color: _LabPalette.steelSoft,
            size: 22,
          ),
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Center(
        child: Icon(
          Icons.arrow_downward_rounded,
          color: _LabPalette.steelSoft,
          size: 22,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 2: live diagnostics panel.
  // -------------------------------------------------------------------------
  Widget _buildLiveDiagnostics() {
    final String attachmentLabel =
        _rootAttached ? '✓ Attached' : '✗ Not attached';
    final Color attachmentColor =
        _rootAttached ? _LabPalette.success : _LabPalette.accent;
    final String hashLabel = _buildOwnerHash == null
        ? '--'
        : '#${_buildOwnerHash!.toRadixString(16).padLeft(8, '0')}';

    return _SectionCard(
      title: 'Live diagnostics',
      subtitle:
          'Readings pulled from WidgetsBinding.instance — refresh to re-probe.',
      icon: Icons.insights_rounded,
      accent: _LabPalette.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool twoColumn = constraints.maxWidth >= 720;
              final List<Widget> rows = <Widget>[
                _diagRow(
                  label: 'rootElement.runtimeType',
                  value: _rootRuntimeType,
                ),
                _diagRow(
                  label: 'rootElement attached',
                  value: attachmentLabel,
                  valueColor: attachmentColor,
                ),
                _diagRow(
                  label: 'buildOwner.hashCode',
                  value: hashLabel,
                ),
                _diagRow(
                  label: 'focusManager.runtimeType',
                  value: _focusManagerRuntimeType,
                ),
                _diagRow(
                  label: 'direct children (root)',
                  value: _rootAttached ? '$_directChildren' : '--',
                ),
                _diagRow(
                  label: 'last refresh',
                  value: _formatTimestamp(_lastRefreshAt),
                ),
              ];
              if (!twoColumn) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: rows,
                );
              }
              final List<Widget> left = <Widget>[];
              final List<Widget> right = <Widget>[];
              for (int i = 0; i < rows.length; i++) {
                if (i.isEven) {
                  left.add(rows[i]);
                } else {
                  right.add(rows[i]);
                }
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: left,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: right,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _HeaderChip(
                label:
                    _rootAttached ? 'probe: live' : 'probe: waiting for frame',
                color: _rootAttached
                    ? _LabPalette.electric
                    : _LabPalette.steelSoft,
              ),
              const SizedBox(width: 10),
              _HeaderChip(
                label: 'counter: $_refreshCounter',
                color: _LabPalette.accentSoft,
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _LabPalette.electric,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  debugPrint(
                    'BuildOwnerAssignmentLabDemo: user tapped '
                    '"Refresh diagnostics" — walking tree…',
                  );
                  _collectDiagnostics();
                },
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Refresh diagnostics'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _diagRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _LabPalette.canvas.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _LabPalette.outline),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Text(
                label,
                style: const TextStyle(
                  color: _LabPalette.inkMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: valueColor ?? _LabPalette.ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime t) {
    final String hh = t.hour.toString().padLeft(2, '0');
    final String mm = t.minute.toString().padLeft(2, '0');
    final String ss = t.second.toString().padLeft(2, '0');
    final String ms = t.millisecond.toString().padLeft(3, '0');
    return '$hh:$mm:$ss.$ms';
  }

  // -------------------------------------------------------------------------
  // Section 3: three-scenario strip.
  // -------------------------------------------------------------------------
  Widget _buildScenarioStrip() {
    final List<_Scenario> scenarios = <_Scenario>[
      const _Scenario(
        title: 'Cold start',
        sketch: 'new BuildOwner  →  rootElement.assignOwner(owner)',
        description:
            'First time ever. WidgetsBinding creates a brand-new BuildOwner '
            'and calls assignOwner on the freshly minted root element. '
            'After this point the tree can be built.',
        badgeLabel: '●',
        badgeTone: _LabPalette.electric,
        captionLabel: 'primary path',
      ),
      const _Scenario(
        title: 'Hot reload',
        sketch: 'existing tree  →  assignOwner(newOwner)',
        description:
            'The hot-reload pipeline recomposes the app. A replacement '
            'BuildOwner is swapped in via assignOwner while the element '
            'tree below stays identified — state is preserved.',
        badgeLabel: '↻',
        badgeTone: _LabPalette.accent,
        captionLabel: 'swap owner, keep children',
      ),
      const _Scenario(
        title: 'Test binding',
        sketch: 'TestWidgetsBinding  →  assignOwner(testOwner)',
        description:
            'A test binding substitutes its own BuildOwner so each test '
            'lives in a sealed build scope. Pumping a widget in a test '
            'walks through exactly this seam.',
        badgeLabel: '🧪',
        badgeTone: _LabPalette.electricSoft,
        captionLabel: 'isolation per test',
      ),
    ];

    return _SectionCard(
      title: 'Ownership-transfer scenarios',
      subtitle:
          'Three different moments in a Flutter app where assignOwner fires.',
      icon: Icons.swap_horiz_rounded,
      accent: _LabPalette.electricSoft,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool wide = constraints.maxWidth >= 820;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (int i = 0; i < scenarios.length; i++) ...<Widget>[
                  Expanded(child: _buildScenarioCard(scenarios[i])),
                  if (i != scenarios.length - 1) const SizedBox(width: 12),
                ],
              ],
            );
          }
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final _Scenario s in scenarios)
                SizedBox(
                  width: constraints.maxWidth >= 520
                      ? (constraints.maxWidth - 12) / 2
                      : constraints.maxWidth,
                  child: _buildScenarioCard(s),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScenarioCard(_Scenario s) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _LabPalette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _LabPalette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: s.badgeTone.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: s.badgeTone.withValues(alpha: 0.7),
                  ),
                ),
                child: Text(
                  s.badgeLabel,
                  style: TextStyle(
                    color: s.badgeTone,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  s.title,
                  style: const TextStyle(
                    color: _LabPalette.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _LabPalette.canvas.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _LabPalette.steel),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: _LabPalette.steelSoft,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    s.sketch,
                    style: const TextStyle(
                      color: _LabPalette.electricSoft,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            s.description,
            style: const TextStyle(
              color: _LabPalette.inkMuted,
              fontSize: 12,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          _HeaderChip(label: s.captionLabel, color: s.badgeTone),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Section 4: tree probe panel.
  // -------------------------------------------------------------------------
  Widget _buildTreeProbe() {
    return _SectionCard(
      title: 'Tree probe · 3 levels deep',
      subtitle:
          'visitChildren is called recursively under rootElement to render this.',
      icon: Icons.account_tree_rounded,
      accent: _LabPalette.steelSoft,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _LabPalette.canvas.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _LabPalette.outline),
        ),
        child: _treeSnapshot.isEmpty
            ? const Text(
                '(no root yet — press "Refresh diagnostics" after first frame)',
                style: TextStyle(
                  color: _LabPalette.steelSoft,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (final _TreeNode n in _treeSnapshot)
                    ..._renderNode(n),
                ],
              ),
      ),
    );
  }

  List<Widget> _renderNode(_TreeNode n) {
    final List<Widget> widgets = <Widget>[
      Padding(
        padding: EdgeInsets.only(left: n.depth * 18.0, top: 2, bottom: 2),
        child: Row(
          children: <Widget>[
            Text(
              '- ',
              style: TextStyle(
                color: n.depth == 0
                    ? _LabPalette.electricSoft
                    : _LabPalette.steelSoft,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            Flexible(
              child: Text(
                n.type,
                style: TextStyle(
                  color: n.depth == 0
                      ? _LabPalette.electricSoft
                      : _LabPalette.ink,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight:
                      n.depth == 0 ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            if (n.children.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '(${n.children.length} child${n.children.length == 1 ? '' : 'ren'})',
                  style: const TextStyle(
                    color: _LabPalette.steelSoft,
                    fontFamily: 'monospace',
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    ];
    for (final _TreeNode child in n.children) {
      widgets.addAll(_renderNode(child));
    }
    return widgets;
  }

  // -------------------------------------------------------------------------
  // Section 5: teaching panel.
  // -------------------------------------------------------------------------
  Widget _buildTeachingPanel() {
    return _SectionCard(
      title: 'What / Where / Why',
      subtitle: 'Cemented with a conceptual code sketch at the end.',
      icon: Icons.menu_book_rounded,
      accent: _LabPalette.accentSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool wide = constraints.maxWidth >= 820;
              const List<_TeachColumn> columns = <_TeachColumn>[
                _TeachColumn(
                  heading: 'What the mixin is',
                  body:
                      'A framework-internal mixin on Element that adds the '
                      'single method assignOwner(BuildOwner). It is applied '
                      'once, to the root element of a Flutter app.',
                ),
                _TeachColumn(
                  heading: 'Where it sits',
                  body:
                      'Between runApp and the element subtree. The binding '
                      'creates/holds a BuildOwner; the root element carries '
                      'it downward as the authority for mark-needs-build '
                      'and rebuild scheduling.',
                ),
                _TeachColumn(
                  heading: 'Why it matters',
                  body:
                      'It is the single seam the framework uses to (re)wire '
                      'an entire app to a specific build pipeline — hot '
                      'reload, tests, and embedders all exploit it.',
                ),
              ];
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < columns.length; i++) ...<Widget>[
                      Expanded(child: _buildTeachColumn(columns[i])),
                      if (i != columns.length - 1) const SizedBox(width: 12),
                    ],
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (final _TeachColumn c in columns) ...<Widget>[
                    _buildTeachColumn(c),
                    const SizedBox(height: 10),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Five real-world consequences of RootElementMixin existing:',
            style: TextStyle(
              color: _LabPalette.ink,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          _buildConsequence(
            '1',
            'Hot reload needs to swap the BuildOwner — it does so through '
                'RootElementMixin.assignOwner.',
          ),
          _buildConsequence(
            '2',
            'Test bindings substitute their own BuildOwner per test, giving '
                'isolation from surrounding state.',
          ),
          _buildConsequence(
            '3',
            'Embedders (desktop window hosts, custom runtimes) can supply '
                'their own binding and owner through this seam.',
          ),
          _buildConsequence(
            '4',
            'Multi-window Flutter can pair multiple root elements, each with '
                'its own BuildOwner, by re-using the same mixin.',
          ),
          _buildConsequence(
            '5',
            'WidgetsBinding.drawFrame calls rootElement.buildOwner!.buildScope'
                '(…) — that buildOwner! is what the mixin wires up.',
          ),
          const SizedBox(height: 16),
          _buildCodeBlock(
            'mixin RootElementMixin on Element {\n'
            '  // Framework-internal. Users never override this.\n'
            '  void assignOwner(BuildOwner owner) {\n'
            '    _owner = owner;\n'
            '  }\n'
            '}',
          ),
          const SizedBox(height: 8),
          const Text(
            'Caveat: the real API lives inside package:flutter and is not '
            'something user code overrides. The sketch above is conceptual.',
            style: TextStyle(
              color: _LabPalette.steelSoft,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachColumn(_TeachColumn c) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _LabPalette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _LabPalette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            c.heading,
            style: const TextStyle(
              color: _LabPalette.electricSoft,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            c.body,
            style: const TextStyle(
              color: _LabPalette.inkMuted,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsequence(String n, String text) {
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
              color: _LabPalette.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _LabPalette.accent.withValues(alpha: 0.6),
              ),
            ),
            child: Text(
              n,
              style: const TextStyle(
                color: _LabPalette.accentSoft,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _LabPalette.ink,
                fontSize: 12,
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F18),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _LabPalette.steel),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: _LabPalette.electricSoft,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.4,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Footer.
  // -------------------------------------------------------------------------
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _LabPalette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _LabPalette.outline),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.tips_and_updates_outlined,
            color: _LabPalette.steelSoft,
            size: 18,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'RootElementMixin is invisible 99% of the time — you only meet '
              'it when the tree needs a new BuildOwner. Hot reload, tests, '
              'and multi-window apps all pass through this seam.',
              style: TextStyle(
                color: _LabPalette.inkMuted,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 10),
          _HeaderChip(
            label: _rootAttached ? 'root: live' : 'root: null',
            color:
                _rootAttached ? _LabPalette.success : _LabPalette.steelSoft,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small pieces: section card, chip, data classes.
// ---------------------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _LabPalette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _LabPalette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.55),
                  ),
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _LabPalette.ink,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _LabPalette.inkMuted,
                        fontSize: 12,
                        height: 1.4,
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

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _PipelineStage {
  const _PipelineStage({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}

class _Scenario {
  const _Scenario({
    required this.title,
    required this.sketch,
    required this.description,
    required this.badgeLabel,
    required this.badgeTone,
    required this.captionLabel,
  });

  final String title;
  final String sketch;
  final String description;
  final String badgeLabel;
  final Color badgeTone;
  final String captionLabel;
}

class _TeachColumn {
  const _TeachColumn({required this.heading, required this.body});

  final String heading;
  final String body;
}

class _TreeNode {
  const _TreeNode({
    required this.type,
    required this.depth,
    required this.children,
  });

  final String type;
  final int depth;
  final List<_TreeNode> children;
}
