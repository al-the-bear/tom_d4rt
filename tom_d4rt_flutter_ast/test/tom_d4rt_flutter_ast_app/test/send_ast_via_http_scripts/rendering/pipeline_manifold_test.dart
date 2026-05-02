// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// PipelineManifold — Deep, Hand-Authored Demo
// =============================================================================
//
// PipelineManifold is the abstract bridge that a RenderObject uses to talk to
// the rendering pipeline as a whole. A PipelineOwner sits between a
// RenderObject tree and the engine; the PipelineManifold sits one level
// further up, between PipelineOwners and the Flutter engine. In a single-view
// application the manifold is supplied by the RootPipelineManifold inside
// RendererBinding; in multi-view setups (View widget, off-screen rendering)
// each PipelineOwner can be attached to the same manifold.
//
// The manifold's contract is small but load-bearing:
//
//   abstract interface class PipelineManifold implements Listenable {
//     void requestVisualUpdate();
//     MouseTracker get mouseTracker;
//     SemanticsOwner? get semanticsOwner;       // null when semantics are off
//     bool get semanticsEnabled;
//     // Listenable: addListener / removeListener notify on
//     // semanticsEnabled changes.
//   }
//
// This file is a hand-built tour through every observable effect the manifold
// mediates. Each section is a self-contained Card with its own palette,
// stateful behaviour, and explanatory copy.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== PipelineManifold Deep Demo ===');
  print('Sections: 14, painters: 4');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PipelineManifold Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('PipelineManifold — Deep Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeroIntro(),
              const SizedBox(height: 16),
              _buildVisualUpdateInAction(),
              const SizedBox(height: 16),
              _buildMouseTrackerCapability(),
              const SizedBox(height: 16),
              _buildSemanticsCapability(),
              const SizedBox(height: 16),
              _buildFrameSchedulingDemo(),
              const SizedBox(height: 16),
              _buildListenableContractDemo(),
              const SizedBox(height: 16),
              _buildVisualUpdateUnderPressure(),
              const SizedBox(height: 16),
              _buildLayoutVsPaintDirty(),
              const SizedBox(height: 16),
              _buildCustomCursorGrid(),
              const SizedBox(height: 16),
              _buildSemanticsTreeExplorer(),
              const SizedBox(height: 16),
              _buildPipelineArchitectureDiagram(),
              const SizedBox(height: 16),
              _buildDecisionCard(),
              const SizedBox(height: 16),
              _buildReferenceTable(),
              const SizedBox(height: 16),
              _buildFooter(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Hero intro & architectural diagram (CustomPainter #1)
// =============================================================================

Widget _buildHeroIntro() {
  return Card(
    elevation: 6,
    color: Colors.indigo.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.hub, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'PipelineManifold',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                    Text(
                      'The bridge between PipelineOwner and the engine',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.indigo.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'A PipelineManifold is the abstract surface that a RenderObject '
            'reaches through to schedule frames, query the MouseTracker, and '
            'consult the SemanticsOwner. It is rarely instantiated by user '
            'code; instead, RendererBinding wires up a RootPipelineManifold '
            'so that every PipelineOwner shares one consistent view of the '
            'engine. When you call setState() and the framework calls '
            'markNeedsPaint(), the work eventually surfaces as '
            'PipelineManifold.requestVisualUpdate().',
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: Colors.indigo.shade900,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.indigo.shade200, width: 2),
            ),
            child: CustomPaint(
              painter: _PipelineChainDiagramPainter(),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Above: the chain a paint request travels. setState in a State '
            'object marks an Element dirty, which forwards to the linked '
            'RenderObject. The RenderObject, having an attached '
            'PipelineOwner, asks the PipelineManifold for a visual update; '
            'the manifold in turn asks the engine to schedule a frame.',
            style: TextStyle(fontSize: 12.5, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 2 — requestVisualUpdate in action
// =============================================================================

Widget _buildVisualUpdateInAction() {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);
  final ValueNotifier<int> visualUpdateCount = ValueNotifier<int>(0);

  return Card(
    elevation: 4,
    color: Colors.teal.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.refresh,
            title: '2. requestVisualUpdate() in action',
            color: Colors.teal.shade700,
          ),
          const SizedBox(height: 8),
          Text(
            'Every successful setState in a StatefulWidget that ends up '
            'mutating the visual tree results in a chain of markNeedsPaint() '
            'or markNeedsLayout() calls on RenderObjects. Those calls bubble '
            'up to the PipelineOwner and ultimately call '
            'PipelineManifold.requestVisualUpdate(). Below, every press of '
            'the button bumps the counter (a setState) and we keep a '
            'manual tally of "logical visual update requests" to model what '
            'the manifold sees.',
            style: TextStyle(fontSize: 13.5, color: Colors.teal.shade900),
          ),
          const SizedBox(height: 16),
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Counter',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.teal.shade800,
                            ),
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: counter,
                            builder: (BuildContext context, int v, Widget? _) {
                              return Text(
                                '$v',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.teal.shade900,
                                ),
                              );
                            },
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: visualUpdateCount,
                            builder: (BuildContext context, int v, Widget? _) {
                              return Text(
                                'Visual updates requested: $v',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.teal.shade700,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            counter.value++;
                            visualUpdateCount.value++;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade700,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('setState → markNeedsPaint'),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: () {
                            counter.value = 0;
                            visualUpdateCount.value = 0;
                            setState(() {});
                          },
                          icon: const Icon(Icons.restart_alt),
                          label: const Text('Reset'),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.teal.shade300),
                          ),
                          child: Text(
                            '// Conceptually:\n'
                            'setState(() => counter++)\n'
                            '  → markNeedsBuild()\n'
                            '  → element.rebuild()\n'
                            '  → renderObject.markNeedsPaint()\n'
                            '  → owner.requestVisualUpdate()\n'
                            '  → manifold.requestVisualUpdate()',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: Colors.teal.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 3 — MouseTracker capability
// =============================================================================

Widget _buildMouseTrackerCapability() {
  return Card(
    elevation: 4,
    color: Colors.amber.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.mouse,
            title: '3. MouseTracker capability',
            color: Colors.amber.shade800,
          ),
          const SizedBox(height: 8),
          Text(
            'PipelineManifold.mouseTracker exposes the singleton MouseTracker '
            'used by RendererBinding to dispatch mouse events. Every '
            'MouseRegion in the tree relies on this object to receive '
            'enter/exit notifications and to resolve cursors.',
            style: TextStyle(fontSize: 13.5, color: Colors.amber.shade900),
          ),
          const SizedBox(height: 16),
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              final List<_HoverDef> defs = <_HoverDef>[
                _HoverDef('Indigo', Colors.indigo, Icons.bolt),
                _HoverDef('Teal', Colors.teal, Icons.water_drop),
                _HoverDef('Amber', Colors.amber, Icons.local_fire_department),
                _HoverDef('Pink', Colors.pink, Icons.favorite),
                _HoverDef('Cyan', Colors.cyan, Icons.cloud),
                _HoverDef('Lime', Colors.lime, Icons.eco),
              ];
              final List<bool> hovered = List<bool>.filled(defs.length, false);
              return StatefulBuilder(
                builder: (BuildContext c, StateSetter set2) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List<Widget>.generate(defs.length, (int i) {
                      final _HoverDef def = defs[i];
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) {
                          hovered[i] = true;
                          set2(() {});
                        },
                        onExit: (_) {
                          hovered[i] = false;
                          set2(() {});
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutCubic,
                          width: hovered[i] ? 150 : 130,
                          height: hovered[i] ? 110 : 100,
                          decoration: BoxDecoration(
                            color: hovered[i] ? def.color.shade400 : def.color.shade100,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: def.color.shade700,
                              width: hovered[i] ? 3 : 1,
                            ),
                            boxShadow: hovered[i]
                                ? <BoxShadow>[
                                    BoxShadow(
                                      color: def.color.withValues(alpha: 0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ]
                                : <BoxShadow>[],
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                def.icon,
                                size: hovered[i] ? 36 : 28,
                                color: hovered[i]
                                    ? Colors.white
                                    : def.color.shade800,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                def.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: hovered[i]
                                      ? Colors.white
                                      : def.color.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            'Hover triggers MouseRegion.onEnter / onExit; under the hood, the '
            'MouseTracker walks the hit-test result, diffs the previous '
            'tracked regions, and fires the appropriate callbacks before '
            'asking the manifold to schedule a paint for the cursor change.',
            style: TextStyle(fontSize: 12.5, color: Colors.amber.shade800),
          ),
        ],
      ),
    ),
  );
}

class _HoverDef {
  const _HoverDef(this.label, this.color, this.icon);
  final String label;
  final MaterialColor color;
  final IconData icon;
}

// =============================================================================
// SECTION 4 — Semantics capability
// =============================================================================

Widget _buildSemanticsCapability() {
  return Card(
    elevation: 4,
    color: Colors.deepOrange.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.accessibility_new,
            title: '4. Semantics capability',
            color: Colors.deepOrange.shade700,
          ),
          const SizedBox(height: 8),
          Text(
            'PipelineManifold.semanticsOwner is the SemanticsOwner that '
            'consolidates the semantics tree handed off to the engine for '
            'screen readers and accessibility tooling. It is null when '
            'semantics are not currently enabled. The widgets below '
            'demonstrate the most common semantic annotations.',
            style: TextStyle(fontSize: 13.5, color: Colors.deepOrange.shade900),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              Semantics(
                label: 'Primary action card. Save changes to the document.',
                button: true,
                child: _semanticsCard(
                  'button: true',
                  'Save',
                  Icons.save,
                  Colors.deepOrange.shade400,
                ),
              ),
              Semantics(
                header: true,
                child: _semanticsCard(
                  'header: true',
                  'Section title',
                  Icons.title,
                  Colors.deepOrange.shade300,
                ),
              ),
              Semantics(
                label: 'Account total: 42 items',
                hint: 'Double-tap to open',
                child: _semanticsCard(
                  'label + hint',
                  'Account: 42',
                  Icons.account_circle,
                  Colors.deepOrange.shade500,
                ),
              ),
              MergeSemantics(
                child: _semanticsCard(
                  'MergeSemantics',
                  'Merged children',
                  Icons.merge_type,
                  Colors.deepOrange.shade600,
                ),
              ),
              ExcludeSemantics(
                child: _semanticsCard(
                  'ExcludeSemantics',
                  'Hidden to AT',
                  Icons.visibility_off,
                  Colors.deepOrange.shade200,
                ),
              ),
              Semantics(
                liveRegion: true,
                label: 'Live region — updates are announced',
                child: _semanticsCard(
                  'liveRegion: true',
                  'Live update',
                  Icons.podcasts,
                  Colors.deepOrange.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.deepOrange.shade200),
            ),
            child: const SelectableText(
              '// To find the SemanticsOwner from a RenderObject:\n'
              'final owner = renderObject.owner;\n'
              'final manifold = owner?.manifold;\n'
              'final semOwner = manifold?.semanticsOwner;\n'
              '// semOwner is non-null only when semanticsEnabled == true.',
              style: TextStyle(fontFamily: 'monospace', fontSize: 11.5),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _semanticsCard(String tag, String title, IconData icon, Color color) {
  return Container(
    width: 170,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          tag,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5 — Frame scheduling
// =============================================================================

Widget _buildFrameSchedulingDemo() {
  return Card(
    elevation: 4,
    color: Colors.pink.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.schedule,
            title: '5. Frame scheduling',
            color: Colors.pink.shade700,
          ),
          const SizedBox(height: 8),
          Text(
            'addPostFrameCallback runs once after the next frame is drawn. '
            'The clock below uses a Ticker (via AnimatedBuilder + '
            'AnimationController repeat) to repaint every frame; each '
            'repaint is, conceptually, a manifold-driven visual update.',
            style: TextStyle(fontSize: 13.5, color: Colors.pink.shade900),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.pink.shade200, width: 2),
                  ),
                  child: const _ClockTickerDemo(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 200,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const _PostFrameCallbackDemo(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Both panels show how scheduling intersects with the manifold: '
            'animation drivers ask for repeating frames, and post-frame '
            'callbacks let you inspect or reschedule work after a frame '
            'commits.',
            style: TextStyle(fontSize: 12.5, color: Colors.pink.shade700),
          ),
        ],
      ),
    ),
  );
}

class _ClockTickerDemo extends StatefulWidget {
  const _ClockTickerDemo();

  @override
  State<_ClockTickerDemo> createState() => _ClockTickerDemoState();
}

class _ClockTickerDemoState extends State<_ClockTickerDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClockPainter(_ctrl),
      child: const SizedBox.expand(),
    );
  }
}

class _PostFrameCallbackDemo extends StatefulWidget {
  const _PostFrameCallbackDemo();

  @override
  State<_PostFrameCallbackDemo> createState() => _PostFrameCallbackDemoState();
}

class _PostFrameCallbackDemoState extends State<_PostFrameCallbackDemo> {
  int _frames = 0;
  String _lastAt = 'never';

  @override
  void initState() {
    super.initState();
    _scheduleNext();
  }

  void _scheduleNext() {
    WidgetsBinding.instance.addPostFrameCallback((Duration ts) {
      if (!mounted) return;
      setState(() {
        _frames++;
        _lastAt = '${ts.inMilliseconds}ms';
      });
      if (_frames < 50) {
        _scheduleNext();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'addPostFrameCallback',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.pink.shade900,
          ),
        ),
        const SizedBox(height: 8),
        Text('Frames observed: $_frames'),
        Text('Last timestamp: $_lastAt'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _frames = 0;
              _lastAt = 'never';
            });
            _scheduleNext();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade700,
            foregroundColor: Colors.white,
          ),
          child: const Text('Reschedule'),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 6 — Listenable contract
// =============================================================================

Widget _buildListenableContractDemo() {
  return Card(
    elevation: 4,
    color: Colors.cyan.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.notifications_active,
            title: '6. Listenable contract',
            color: Colors.cyan.shade800,
          ),
          const SizedBox(height: 8),
          Text(
            'PipelineManifold itself is a Listenable: addListener / '
            'removeListener fire whenever PipelineManifold.semanticsEnabled '
            'changes (typically because an assistive technology has been '
            'turned on or off, or because debugSemantics is toggled). The '
            'panel below mirrors that observation by listening to '
            'WidgetsBinding.instance and the platform dispatcher state.',
            style: TextStyle(fontSize: 13.5, color: Colors.cyan.shade900),
          ),
          const SizedBox(height: 16),
          const _SemanticsEnabledMonitor(),
        ],
      ),
    ),
  );
}

class _SemanticsEnabledMonitor extends StatefulWidget {
  const _SemanticsEnabledMonitor();

  @override
  State<_SemanticsEnabledMonitor> createState() =>
      _SemanticsEnabledMonitorState();
}

class _SemanticsEnabledMonitorState extends State<_SemanticsEnabledMonitor> {
  bool _enabled = false;
  int _changes = 0;

  @override
  void initState() {
    super.initState();
    _enabled = WidgetsBinding.instance.platformDispatcher.semanticsEnabled;
    WidgetsBinding.instance.platformDispatcher.onSemanticsEnabledChanged =
        _onChanged;
  }

  void _onChanged() {
    setState(() {
      _enabled =
          WidgetsBinding.instance.platformDispatcher.semanticsEnabled;
      _changes++;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.platformDispatcher.onSemanticsEnabledChanged =
        null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.cyan.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            _enabled ? Icons.hearing : Icons.hearing_disabled,
            size: 36,
            color: _enabled ? Colors.cyan.shade900 : Colors.cyan.shade600,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Semantics enabled: $_enabled',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.cyan.shade900,
                  ),
                ),
                Text(
                  'Listener fire count: $_changes',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.cyan.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '// PipelineManifold equivalent:\n'
                  'manifold.addListener(() {\n'
                  '  print(manifold.semanticsEnabled);\n'
                  '});',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Colors.cyan.shade900,
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

// =============================================================================
// SECTION 7 — Visual update under pressure (100 dots)
// =============================================================================

Widget _buildVisualUpdateUnderPressure() {
  return Card(
    elevation: 4,
    color: Colors.lime.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.scatter_plot,
            title: '7. Visual update under pressure',
            color: Colors.lime.shade800,
          ),
          const SizedBox(height: 8),
          Text(
            '100 small dots animated by a single AnimationController. The '
            'manifold receives one requestVisualUpdate per frame, not per '
            'dot — Flutter coalesces dirtying so the engine schedules at '
            'most one frame regardless of how many RenderObjects mark '
            'themselves dirty.',
            style: TextStyle(fontSize: 13.5, color: Colors.lime.shade900),
          ),
          const SizedBox(height: 16),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.lime.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              child: _DotsField(),
            ),
          ),
        ],
      ),
    ),
  );
}

class _DotsField extends StatefulWidget {
  const _DotsField();

  @override
  State<_DotsField> createState() => _DotsFieldState();
}

class _DotsFieldState extends State<_DotsField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DotsPainter(_ctrl),
      child: const SizedBox.expand(),
    );
  }
}

// =============================================================================
// SECTION 8 — Layout vs paint dirty (side-by-side)
// =============================================================================

Widget _buildLayoutVsPaintDirty() {
  return Card(
    elevation: 4,
    color: Colors.brown.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.compare_arrows,
            title: '8. Layout vs paint dirty',
            color: Colors.brown.shade700,
          ),
          const SizedBox(height: 8),
          Text(
            'Left panel: setState rebuilds the subtree, marking the '
            'RenderObject as needing both layout and paint. Right panel: a '
            'CustomPainter listens to a Listenable for repaint, bypassing '
            'rebuild entirely — only the paint phase runs. The manifold '
            'schedules the same kind of frame, but the work each pipeline '
            'does is very different.',
            style: TextStyle(fontSize: 13.5, color: Colors.brown.shade900),
          ),
          const SizedBox(height: 16),
          const _LayoutVsPaintComparison(),
        ],
      ),
    ),
  );
}

class _LayoutVsPaintComparison extends StatefulWidget {
  const _LayoutVsPaintComparison();

  @override
  State<_LayoutVsPaintComparison> createState() =>
      _LayoutVsPaintComparisonState();
}

class _LayoutVsPaintComparisonState extends State<_LayoutVsPaintComparison>
    with SingleTickerProviderStateMixin {
  int _setStateFrames = 0;
  late final AnimationController _ctrl;
  final ValueNotifier<double> _paintOnly = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addListener(() {
        _paintOnly.value = _ctrl.value;
      });
    _ctrl.repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _paintOnly.dispose();
    super.dispose();
  }

  void _bumpSetState() {
    setState(() => _setStateFrames++);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 220,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.brown.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Layout + Paint (setState)',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.brown.shade900,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Manual frames: $_setStateFrames'),
                const Spacer(),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'rebuilt $_setStateFrames times',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _bumpSetState,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade700,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('setState bump'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.brown.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomPaint(
                painter: _PaintOnlyBarPainter(_paintOnly),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 9 — MouseTracker + custom cursor grid
// =============================================================================

Widget _buildCustomCursorGrid() {
  final List<_CursorDef> cursors = <_CursorDef>[
    _CursorDef('basic', SystemMouseCursors.basic),
    _CursorDef('click', SystemMouseCursors.click),
    _CursorDef('text', SystemMouseCursors.text),
    _CursorDef('forbidden', SystemMouseCursors.forbidden),
    _CursorDef('grab', SystemMouseCursors.grab),
    _CursorDef('grabbing', SystemMouseCursors.grabbing),
    _CursorDef('help', SystemMouseCursors.help),
    _CursorDef('progress', SystemMouseCursors.progress),
    _CursorDef('resizeRow', SystemMouseCursors.resizeRow),
    _CursorDef('resizeColumn', SystemMouseCursors.resizeColumn),
    _CursorDef('move', SystemMouseCursors.move),
    _CursorDef('cell', SystemMouseCursors.cell),
    _CursorDef('alias', SystemMouseCursors.alias),
    _CursorDef('copy', SystemMouseCursors.copy),
    _CursorDef('disappearing', SystemMouseCursors.disappearing),
    _CursorDef('zoomIn', SystemMouseCursors.zoomIn),
  ];

  return Card(
    elevation: 4,
    color: Colors.purple.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.touch_app,
            title: '9. MouseTracker + custom cursor grid',
            color: Colors.purple.shade700,
          ),
          const SizedBox(height: 8),
          Text(
            'When the cursor enters a MouseRegion, the MouseTracker '
            '(retrieved from PipelineManifold.mouseTracker) consults the '
            'region\'s cursor and asks the engine to switch to that system '
            'cursor. Hover each cell to see a different SystemMouseCursors '
            'value.',
            style: TextStyle(fontSize: 13.5, color: Colors.purple.shade900),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: cursors.map((_CursorDef def) {
              return MouseRegion(
                cursor: def.cursor,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.purple.shade400),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    def.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple.shade900,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

class _CursorDef {
  const _CursorDef(this.label, this.cursor);
  final String label;
  final MouseCursor cursor;
}

// =============================================================================
// SECTION 10 — Semantics tree explorer recipe
// =============================================================================

Widget _buildSemanticsTreeExplorer() {
  return Card(
    elevation: 4,
    color: Colors.blueGrey.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.account_tree,
            title: '10. Semantics tree explorer recipe',
            color: Colors.blueGrey.shade700,
          ),
          const SizedBox(height: 8),
          Text(
            'You can traverse what the manifold\'s SemanticsOwner has built '
            'using debugDumpSemanticsTree() or the Flutter Inspector\'s '
            'Widget Details Tree → Semantics view. The snippet below shows '
            'the API call and the typical bootstrap from a State.',
            style: TextStyle(fontSize: 13.5, color: Colors.blueGrey.shade900),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const SelectableText(
              "// 1. Ensure semantics are turned on:\n"
              "WidgetsBinding.instance.ensureSemantics();\n\n"
              "// 2. Dump the semantics tree from any context:\n"
              "debugDumpSemanticsTree(DebugSemanticsDumpOrder.traversalOrder);\n\n"
              "// 3. Reach the manifold from a RenderObject (advanced):\n"
              "final ro = context.findRenderObject();\n"
              "final manifold = ro?.owner?.manifold;\n"
              "final semOwner = manifold?.semanticsOwner;\n\n"
              "// semOwner.rootSemanticsNode is the entry point.",
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Color(0xFFE0F7FA),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _chip('Flutter Inspector', Colors.blueGrey),
              _chip('debugDumpSemanticsTree', Colors.indigo),
              _chip('SemanticsOwner.rootSemanticsNode', Colors.teal),
              _chip('SemanticsHandle', Colors.deepPurple),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _chip(String label, MaterialColor color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.shade400),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color.shade900,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    ),
  );
}

// =============================================================================
// SECTION 11 — PipelineOwner architecture (CustomPainter #2)
// =============================================================================

Widget _buildPipelineArchitectureDiagram() {
  return Card(
    elevation: 4,
    color: Colors.blue.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.architecture,
            title: '11. Multi-view PipelineOwner architecture',
            color: Colors.blue.shade800,
          ),
          const SizedBox(height: 8),
          Text(
            'In multi-view applications (View widget, embedded windows, '
            'off-screen rendering), each PipelineOwner is connected to the '
            'same RootPipelineManifold. The manifold ensures that all owners '
            'share one MouseTracker and one SemanticsOwner-coordinator and '
            'that a single visual update is scheduled even when multiple '
            'subtrees dirty themselves in the same frame.',
            style: TextStyle(fontSize: 13.5, color: Colors.blue.shade900),
          ),
          const SizedBox(height: 16),
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.blue.shade200, width: 2),
            ),
            child: CustomPaint(
              painter: _MultiViewArchitecturePainter(),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const _ListenerFlowAnimation(),
          ),
        ],
      ),
    ),
  );
}

class _ListenerFlowAnimation extends StatefulWidget {
  const _ListenerFlowAnimation();

  @override
  State<_ListenerFlowAnimation> createState() => _ListenerFlowAnimationState();
}

class _ListenerFlowAnimationState extends State<_ListenerFlowAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ListenerFlowPainter(_ctrl),
      child: const SizedBox.expand(),
    );
  }
}

// =============================================================================
// SECTION 12 — Decision card
// =============================================================================

Widget _buildDecisionCard() {
  final List<_DecisionRow> rows = <_DecisionRow>[
    _DecisionRow(
      'Trigger a repaint after data changed',
      'setState / markNeedsPaint',
      'Almost never reach into manifold here.',
      Colors.green,
    ),
    _DecisionRow(
      'Schedule once after current frame',
      'WidgetsBinding.instance.addPostFrameCallback',
      'Use the binding API; the manifold is downstream.',
      Colors.amber,
    ),
    _DecisionRow(
      'Custom RenderObject needs visual update',
      'markNeedsPaint() / markNeedsLayout()',
      'These call into owner → manifold automatically.',
      Colors.indigo,
    ),
    _DecisionRow(
      'Off-screen rendering or multi-view',
      'Manage your own PipelineOwner attached to root manifold',
      'Direct manifold interaction is appropriate.',
      Colors.deepPurple,
    ),
    _DecisionRow(
      'Listening for semantics on/off',
      'manifold.addListener / SemanticsBinding',
      'The Listenable contract on manifold is the right hook.',
      Colors.teal,
    ),
    _DecisionRow(
      'Need MouseTracker explicitly',
      'RendererBinding.instance.mouseTracker',
      'Or read from manifold.mouseTracker in custom render objects.',
      Colors.pink,
    ),
  ];

  return Card(
    elevation: 4,
    color: Colors.deepPurple.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.psychology_alt,
            title: '12. When do I touch PipelineManifold?',
            color: Colors.deepPurple.shade700,
          ),
          const SizedBox(height: 8),
          Text(
            'Most application code never needs to know that PipelineManifold '
            'exists. The cases below show the rough decision tree for when '
            'a developer would interact with it directly.',
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.deepPurple.shade900,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: rows.map((_DecisionRow row) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: row.color.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: row.color.shade300),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 60,
                      decoration: BoxDecoration(
                        color: row.color.shade700,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            row.scenario,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: row.color.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Use: ${row.recommendation}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              color: row.color.shade800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            row.note,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontStyle: FontStyle.italic,
                              color: row.color.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

class _DecisionRow {
  const _DecisionRow(
      this.scenario, this.recommendation, this.note, this.color);
  final String scenario;
  final String recommendation;
  final String note;
  final MaterialColor color;
}

// =============================================================================
// SECTION 13 — Reference table
// =============================================================================

Widget _buildReferenceTable() {
  return Card(
    elevation: 4,
    color: Colors.grey.shade100,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            icon: Icons.table_chart,
            title: '13. PipelineManifold reference',
            color: Colors.grey.shade800,
          ),
          const SizedBox(height: 8),
          Text(
            'Every member of the abstract PipelineManifold interface, with '
            'its role and typical caller.',
            style: TextStyle(fontSize: 13.5, color: Colors.grey.shade800),
          ),
          const SizedBox(height: 12),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
                columns: const <DataColumn>[
                  DataColumn(label: Text('Member')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Role')),
                  DataColumn(label: Text('Typical caller')),
                ],
                rows: const <DataRow>[
                  DataRow(cells: <DataCell>[
                    DataCell(Text('requestVisualUpdate()')),
                    DataCell(Text('void')),
                    DataCell(Text('Mark pipeline dirty for next frame')),
                    DataCell(Text('PipelineOwner')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('mouseTracker')),
                    DataCell(Text('MouseTracker')),
                    DataCell(Text('Hit-test cursor / hover dispatcher')),
                    DataCell(Text('MouseRegion / RenderMouseRegion')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('semanticsOwner')),
                    DataCell(Text('SemanticsOwner?')),
                    DataCell(Text('Aggregator of the semantics tree')),
                    DataCell(Text('PipelineOwner')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('semanticsEnabled')),
                    DataCell(Text('bool')),
                    DataCell(Text('Whether semantics are currently active')),
                    DataCell(Text('Custom semantics-aware render objects')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('addListener(...)')),
                    DataCell(Text('void')),
                    DataCell(Text('Subscribe to semanticsEnabled changes')),
                    DataCell(Text('PipelineOwner / consumers')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('removeListener(...)')),
                    DataCell(Text('void')),
                    DataCell(Text('Cancel subscription')),
                    DataCell(Text('PipelineOwner / consumers')),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 14 — Footer
// =============================================================================

Widget _buildFooter() {
  return Card(
    elevation: 2,
    color: Colors.indigo.shade900,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.menu_book, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                'Further reading',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo.shade50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Closely related Flutter rendering surfaces — these are the '
            'classes you will actually subclass or instantiate when working '
            'around PipelineManifold:',
            style: TextStyle(
              fontSize: 13,
              color: Colors.indigo.shade100,
            ),
          ),
          const SizedBox(height: 8),
          ..._footerItems().map(
            (String s) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.arrow_right, color: Colors.indigo.shade200),
                  Expanded(
                    child: Text(
                      s,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.indigo.shade50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

List<String> _footerItems() {
  return <String>[
    'PipelineOwner — owns a render tree, schedules layout/paint/semantics passes.',
    'RendererBinding — binds the framework to the engine; sets up the root manifold.',
    'RootPipelineManifold — the concrete implementation used in standard apps.',
    'MouseTracker — dispatches MouseEvents and tracks cursor regions.',
    'SemanticsOwner — root of the semantics tree handed to the engine.',
    'View widget — declares additional PipelineOwner subtrees in multi-view apps.',
    'SchedulerBinding — runs frame callbacks; addPostFrameCallback lives here.',
  ];
}

// =============================================================================
// Shared helpers
// =============================================================================

Widget _sectionHeader({
  required IconData icon,
  required String title,
  required Color color,
}) {
  return Row(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      const SizedBox(width: 10),
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    ],
  );
}

// =============================================================================
// CustomPainter #1 — pipeline chain diagram (static)
// =============================================================================

class _PipelineChainDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final List<_DiagramBox> boxes = <_DiagramBox>[
      _DiagramBox('Element\ntree', Colors.indigo.shade400),
      _DiagramBox('RenderObject\ntree', Colors.indigo.shade500),
      _DiagramBox('PipelineOwner', Colors.indigo.shade600),
      _DiagramBox('PipelineManifold', Colors.indigo.shade800),
      _DiagramBox('Engine', Colors.black87),
    ];
    final double margin = 12;
    final double gap = 8;
    final double totalGap = gap * (boxes.length - 1);
    final double boxW = (size.width - margin * 2 - totalGap) / boxes.length;
    final double boxH = 70;
    final double y = (size.height - boxH) / 2;
    for (int i = 0; i < boxes.length; i++) {
      final double x = margin + i * (boxW + gap);
      final RRect rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, boxW, boxH),
        const Radius.circular(10),
      );
      canvas.drawRRect(rect, Paint()..color = boxes[i].color);
      _drawCenteredText(
        canvas,
        boxes[i].label,
        Rect.fromLTWH(x, y, boxW, boxH),
        Colors.white,
      );
      if (i < boxes.length - 1) {
        final double ax = x + boxW;
        final double ay = y + boxH / 2;
        final double bx = ax + gap;
        canvas.drawLine(
          Offset(ax, ay),
          Offset(bx - 2, ay),
          Paint()
            ..color = Colors.indigo.shade700
            ..strokeWidth = 2,
        );
        final Path arrow = Path()
          ..moveTo(bx, ay)
          ..lineTo(bx - 5, ay - 4)
          ..lineTo(bx - 5, ay + 4)
          ..close();
        canvas.drawPath(arrow, Paint()..color = Colors.indigo.shade700);
      }
    }
    _drawCenteredText(
      canvas,
      'paint request flow →',
      Rect.fromLTWH(0, y + boxH + 6, size.width, 20),
      Colors.indigo.shade400,
      fontSize: 11,
    );
    _drawCenteredText(
      canvas,
      'frame schedule ←',
      Rect.fromLTWH(0, y - 26, size.width, 20),
      Colors.indigo.shade400,
      fontSize: 11,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DiagramBox {
  const _DiagramBox(this.label, this.color);
  final String label;
  final Color color;
}

void _drawCenteredText(
  Canvas canvas,
  String text,
  Rect rect,
  Color color, {
  double fontSize = 12,
}) {
  final TextPainter tp = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    ),
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: rect.width - 8);
  final Offset offset = Offset(
    rect.left + (rect.width - tp.width) / 2,
    rect.top + (rect.height - tp.height) / 2,
  );
  tp.paint(canvas, offset);
}

// =============================================================================
// CustomPainter #2 — multi-view architecture (static)
// =============================================================================

class _MultiViewArchitecturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()..color = Colors.blue.shade400;
    final Paint linePaint = Paint()
      ..color = Colors.blue.shade700
      ..strokeWidth = 2;
    final Rect manifoldRect = Rect.fromLTWH(
      size.width / 2 - 100,
      20,
      200,
      54,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(manifoldRect, const Radius.circular(10)),
      Paint()..color = Colors.blue.shade800,
    );
    _drawCenteredText(
      canvas,
      'RootPipelineManifold',
      manifoldRect,
      Colors.white,
      fontSize: 13,
    );

    final List<String> ownerLabels = <String>[
      'PipelineOwner\n(Main view)',
      'PipelineOwner\n(Side view)',
      'PipelineOwner\n(Off-screen)',
    ];
    final double ownerY = 110;
    final double ownerW = 130;
    final double ownerH = 50;
    final double spacing =
        (size.width - ownerW * ownerLabels.length) / (ownerLabels.length + 1);

    for (int i = 0; i < ownerLabels.length; i++) {
      final double x = spacing + i * (ownerW + spacing);
      final Rect r = Rect.fromLTWH(x, ownerY, ownerW, ownerH);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8)),
        boxPaint,
      );
      _drawCenteredText(canvas, ownerLabels[i], r, Colors.white, fontSize: 12);

      canvas.drawLine(
        Offset(x + ownerW / 2, ownerY),
        Offset(manifoldRect.left + manifoldRect.width / 2, manifoldRect.bottom),
        linePaint,
      );
    }

    final List<String> leafLabels = <String>[
      'RenderObject tree',
      'RenderObject tree',
      'RenderObject tree',
    ];
    final double leafY = 200;
    for (int i = 0; i < leafLabels.length; i++) {
      final double x = spacing + i * (ownerW + spacing);
      final Rect r = Rect.fromLTWH(x, leafY, ownerW, 50);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8)),
        Paint()..color = Colors.blue.shade300,
      );
      _drawCenteredText(canvas, leafLabels[i], r, Colors.blue.shade900,
          fontSize: 11);
      canvas.drawLine(
        Offset(x + ownerW / 2, leafY),
        Offset(x + ownerW / 2, ownerY + ownerH),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// CustomPainter #3 — listener-flow animation
// =============================================================================

class _ListenerFlowPainter extends CustomPainter {
  _ListenerFlowPainter(this._anim) : super(repaint: _anim);

  final Animation<double> _anim;

  @override
  void paint(Canvas canvas, Size size) {
    final double t = _anim.value;
    const int steps = 4;
    final double cellW = size.width / steps;
    final List<String> labels = <String>[
      'manifold',
      'addListener',
      'semanticsEnabled?',
      'consumer',
    ];
    final List<MaterialColor> colors = <MaterialColor>[
      Colors.blue,
      Colors.indigo,
      Colors.teal,
      Colors.green,
    ];
    for (int i = 0; i < steps; i++) {
      final Rect r = Rect.fromLTWH(
        i * cellW + 12,
        size.height / 2 - 24,
        cellW - 24,
        48,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(10)),
        Paint()..color = colors[i].shade400,
      );
      _drawCenteredText(canvas, labels[i], r, Colors.white, fontSize: 12);
    }
    final double pulseX = 12 + t * (size.width - 24);
    canvas.drawCircle(
      Offset(pulseX, size.height / 2),
      8,
      Paint()..color = Colors.orange,
    );
    canvas.drawCircle(
      Offset(pulseX, size.height / 2),
      14,
      Paint()
        ..color = Colors.orange.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _ListenerFlowPainter oldDelegate) => true;
}

// =============================================================================
// CustomPainter #4 — animated dots field
// =============================================================================

class _DotsPainter extends CustomPainter {
  _DotsPainter(this._anim) : super(repaint: _anim);

  final Animation<double> _anim;

  @override
  void paint(Canvas canvas, Size size) {
    const int count = 100;
    final double t = _anim.value;
    for (int i = 0; i < count; i++) {
      final double phase = (i / count) * 6.283 + t * 6.283;
      final double x =
          size.width * 0.5 + (size.width * 0.45) * _wave(phase, 0);
      final double y =
          size.height * 0.5 + (size.height * 0.40) * _wave(phase, 1);
      final double radius = 2 + 4 * (0.5 + 0.5 * _wave(phase * 2, 2));
      final Color c = HSVColor.fromAHSV(
        1,
        (i * 3.6 + t * 360) % 360,
        0.6,
        0.85,
      ).toColor();
      canvas.drawCircle(Offset(x, y), radius, Paint()..color = c);
    }
  }

  double _wave(double phase, int kind) {
    switch (kind) {
      case 0:
        return _sin(phase);
      case 1:
        return _cos(phase * 1.3);
      default:
        return _sin(phase * 0.7);
    }
  }

  // Tiny inline trig — avoid importing dart:math purely for variety. The
  // values are fine for animation aesthetics.
  double _sin(double x) {
    final double xr = x % 6.283185307179586;
    final double v = xr - 3.141592653589793;
    final double v2 = v * v;
    return v *
        (1 - v2 / 6 + v2 * v2 / 120 - v2 * v2 * v2 / 5040) *
        ((xr < 3.141592653589793) ? -1 : 1);
  }

  double _cos(double x) => _sin(x + 1.5707963267948966);

  @override
  bool shouldRepaint(covariant _DotsPainter oldDelegate) => true;
}

// =============================================================================
// CustomPainter #5 — clock ticker
// =============================================================================

class _ClockPainter extends CustomPainter {
  _ClockPainter(this._anim) : super(repaint: _anim);
  final Animation<double> _anim;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius =
        (size.shortestSide / 2) - 12;
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = Colors.pink.shade100,
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.pink.shade400
        ..strokeWidth = 3,
    );
    for (int i = 0; i < 12; i++) {
      final double a = i * 6.283 / 12;
      final Offset p1 = center +
          Offset(_cos(a) * (radius - 4), _sin(a) * (radius - 4));
      final Offset p2 =
          center + Offset(_cos(a) * (radius - 14), _sin(a) * (radius - 14));
      canvas.drawLine(
        p1,
        p2,
        Paint()
          ..color = Colors.pink.shade700
          ..strokeWidth = 2,
      );
    }
    final double t = _anim.value;
    final double angle = t * 6.283 - 1.5707963;
    final Offset hand = center +
        Offset(_cos(angle) * (radius - 18), _sin(angle) * (radius - 18));
    canvas.drawLine(
      center,
      hand,
      Paint()
        ..color = Colors.pink.shade900
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(center, 4, Paint()..color = Colors.pink.shade900);
    _drawCenteredText(
      canvas,
      'Ticker',
      Rect.fromCenter(center: center.translate(0, radius * 0.55), width: 80, height: 18),
      Colors.pink.shade900,
      fontSize: 11,
    );
  }

  double _sin(double x) {
    final double xr = x % 6.283185307179586;
    final double v = xr - 3.141592653589793;
    final double v2 = v * v;
    return v *
        (1 - v2 / 6 + v2 * v2 / 120 - v2 * v2 * v2 / 5040) *
        ((xr < 3.141592653589793) ? -1 : 1);
  }

  double _cos(double x) => _sin(x + 1.5707963267948966);

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) => true;
}

// =============================================================================
// CustomPainter #6 — paint-only bar (driven by a Listenable)
// =============================================================================

class _PaintOnlyBarPainter extends CustomPainter {
  _PaintOnlyBarPainter(this._listenable) : super(repaint: _listenable);
  final ValueNotifier<double> _listenable;

  @override
  void paint(Canvas canvas, Size size) {
    final double t = _listenable.value;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.brown.shade200,
    );
    final double barH = 30;
    final double barW = size.width - 32;
    final double barY = (size.height - barH) / 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(16, barY, barW, barH),
        const Radius.circular(8),
      ),
      Paint()..color = Colors.brown.shade400,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(16, barY, barW * t, barH),
        const Radius.circular(8),
      ),
      Paint()..color = Colors.brown.shade800,
    );
    _drawCenteredText(
      canvas,
      'Paint-only (CustomPainter repaint)',
      Rect.fromLTWH(0, barY - 24, size.width, 18),
      Colors.brown.shade900,
      fontSize: 12,
    );
    _drawCenteredText(
      canvas,
      '${(t * 100).toStringAsFixed(0)}%',
      Rect.fromLTWH(0, barY + barH + 6, size.width, 18),
      Colors.brown.shade900,
      fontSize: 12,
    );
  }

  @override
  bool shouldRepaint(covariant _PaintOnlyBarPainter oldDelegate) => true;
}
