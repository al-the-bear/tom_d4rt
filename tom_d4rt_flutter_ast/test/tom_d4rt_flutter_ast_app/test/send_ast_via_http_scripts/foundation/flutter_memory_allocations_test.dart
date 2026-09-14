// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests FlutterMemoryAllocations from foundation
// Deep Demo: Visual demonstration of FlutterMemoryAllocations singleton,
// listener subscription model, and the Disposable / ObjectEvent lifecycle
// used by Flutter to surface memory-allocation diagnostics.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =============================================================================
// HERO PALETTE
// -----------------------------------------------------------------------------
// We pick a small set of strongly-typed palette helpers up front. Every section
// below picks at least one gradient and one shadow from this palette so that
// the visual language stays coherent across the nine sections.
// =============================================================================

const Color _kHeroDeep = Color(0xFF1A237E);
const Color _kHeroBright = Color(0xFF512DA8);
const Color _kAccentTeal = Color(0xFF00897B);
const Color _kAccentAmber = Color(0xFFFFB300);
const Color _kAccentRose = Color(0xFFD81B60);
const Color _kSurfaceMuted = Color(0xFFECEFF1);
const Color _kInk = Color(0xFF0D1B2A);

dynamic build(BuildContext context) {
  print('FlutterMemoryAllocations Deep Demo executing');

  // ===========================================================================
  // SINGLETON ACCESS
  // ---------------------------------------------------------------------------
  // FlutterMemoryAllocations exposes a single shared instance that lives for
  // the lifetime of the Flutter engine. The instance is purely a registry and
  // event bus: it does not own the objects it tracks. Tracking is enabled
  // automatically in debug and profile builds when listeners are attached.
  // ===========================================================================

  print('=== Section: Singleton access ===');
  final FlutterMemoryAllocations fma = FlutterMemoryAllocations.instance;
  print('FlutterMemoryAllocations runtimeType: ${fma.runtimeType}');
  print('hasListeners (initial): ${fma.hasListeners}');

  // A simple counting listener used by the demo to make the registry visible.
  int observedEvents = 0;
  void demoListener(ObjectEvent event) {
    observedEvents++;
    print('Observed ObjectEvent: ${event.runtimeType}');
  }

  fma.addListener(demoListener);
  print('Listener added. hasListeners now: ${fma.hasListeners}');
  fma.removeListener(demoListener);
  print('Listener removed. hasListeners now: ${fma.hasListeners}');
  print('Total observed events during demo: $observedEvents');

  // ===========================================================================
  // SECTION 1: HERO HEADER
  // ---------------------------------------------------------------------------
  // The hero header introduces the topic and frames the visualisation. The
  // header always uses an AlwaysStoppedAnimation<double> for any motion-shaped
  // value so that the script remains a pure widget tree without ticking.
  // ===========================================================================

  print('=== Section 1: Hero header ===');
  final AlwaysStoppedAnimation<double> heroPulse =
      AlwaysStoppedAnimation<double>(0.85);
  // Motion is intentionally frozen: every animated widget uses Duration.zero
  // and a fixed AlwaysStoppedAnimation, so the script renders a single still
  // frame without any ticking work.
  const Duration kMotion = Duration.zero;
  final Widget heroHeader = AnimatedContainer(
    duration: kMotion,
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _kHeroDeep,
          _kHeroBright,
          _kAccentRose.withValues(alpha: 0.9),
        ],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: [
        BoxShadow(
          color: _kHeroDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: _kAccentRose.withValues(alpha: 0.25),
          blurRadius: 40.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Icon(
                Icons.memory,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FlutterMemoryAllocations',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Singleton lifecycle registry for Disposable objects',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sensors, size: 18.0, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                'pulse strength: ${heroPulse.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'FlutterMemoryAllocations.instance is the single broadcast point '
          'used by Flutter to surface object-creation and disposal events. '
          'Listeners receive ObjectEvent instances describing the lifecycle '
          'transition; the registry itself never retains the objects.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2: ANATOMY DIAGRAM
  // ---------------------------------------------------------------------------
  // The anatomy diagram shows the moving parts: the singleton in the centre,
  // the dispatchObjectCreated / dispatchObjectDisposed funnels, the listener
  // collection, and the consumers (DevTools, leak_tracker, custom panels).
  // ===========================================================================

  print('=== Section 2: Anatomy diagram ===');
  final Widget anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          _kSurfaceMuted,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.indigo.shade100, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.10),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('2. Anatomy of the registry', _kHeroDeep),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Producers column
            Expanded(
              child: Column(
                children: [
                  _buildAnatomyNode(
                    title: 'Producer',
                    subtitle: 'Disposable.dispose()',
                    icon: Icons.upload,
                    color: _kAccentTeal,
                  ),
                  SizedBox(height: 10.0),
                  _buildAnatomyNode(
                    title: 'Producer',
                    subtitle: 'new ChangeNotifier()',
                    icon: Icons.upload,
                    color: _kAccentTeal,
                  ),
                  SizedBox(height: 10.0),
                  _buildAnatomyNode(
                    title: 'Producer',
                    subtitle: 'manual dispatch',
                    icon: Icons.upload,
                    color: _kAccentTeal,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            // Pipe column
            Column(
              children: [
                Icon(Icons.east, color: _kAccentTeal, size: 28.0),
                SizedBox(height: 16.0),
                Icon(Icons.east, color: _kAccentTeal, size: 28.0),
                SizedBox(height: 16.0),
                Icon(Icons.east, color: _kAccentTeal, size: 28.0),
              ],
            ),
            SizedBox(width: 12.0),
            // Singleton centre
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _kHeroDeep,
                      _kHeroBright,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: [
                    BoxShadow(
                      color: _kHeroDeep.withValues(alpha: 0.45),
                      blurRadius: 12.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.hub, color: Colors.white, size: 36.0),
                    SizedBox(height: 8.0),
                    Text(
                      'instance',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'FlutterMemory\nAllocations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            // Pipe column
            Column(
              children: [
                Icon(Icons.east, color: _kAccentRose, size: 28.0),
                SizedBox(height: 16.0),
                Icon(Icons.east, color: _kAccentRose, size: 28.0),
                SizedBox(height: 16.0),
                Icon(Icons.east, color: _kAccentRose, size: 28.0),
              ],
            ),
            SizedBox(width: 12.0),
            // Consumers column
            Expanded(
              child: Column(
                children: [
                  _buildAnatomyNode(
                    title: 'Consumer',
                    subtitle: 'DevTools panel',
                    icon: Icons.dashboard,
                    color: _kAccentRose,
                  ),
                  SizedBox(height: 10.0),
                  _buildAnatomyNode(
                    title: 'Consumer',
                    subtitle: 'leak_tracker',
                    icon: Icons.bug_report,
                    color: _kAccentRose,
                  ),
                  SizedBox(height: 10.0),
                  _buildAnatomyNode(
                    title: 'Consumer',
                    subtitle: 'custom listener',
                    icon: Icons.code,
                    color: _kAccentRose,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Producers call dispatchObjectCreated and dispatchObjectDisposed. '
          'The singleton fans the event out to every registered listener. '
          'Listeners receive an ObjectEvent (ObjectCreated or ObjectDisposed) '
          'and decide what to do with it — log, count, render, or ignore.',
          style: TextStyle(fontSize: 12.5, height: 1.45, color: _kInk),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3: INSTANCE ACCESS EXAMPLE
  // ---------------------------------------------------------------------------
  // We show how you would actually obtain the instance and inspect its
  // hasListeners property. This is the smallest possible working snippet.
  // ===========================================================================

  print('=== Section 3: Instance access ===');
  final Widget instanceAccess = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.grey.shade900,
          Colors.black,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: _kAccentAmber, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              '3. instance access',
              style: TextStyle(
                color: _kAccentAmber,
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          '// Obtain the singleton — no constructor.\n'
          'final fma = FlutterMemoryAllocations.instance;\n'
          '\n'
          '// Inspect: has anyone subscribed yet?\n'
          'print(fma.hasListeners); // false on a fresh app\n'
          '\n'
          '// runtimeType is FlutterMemoryAllocations.\n'
          'print(fma.runtimeType);',
          Colors.cyan.shade200,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// In this script we observed:\n'
          '//   runtimeType = ${fma.runtimeType}\n'
          '//   hasListeners after add = true\n'
          '//   hasListeners after remove = false\n'
          '//   total events received = $observedEvents',
          Colors.lightGreen.shade200,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4: LISTENER FLOW DIAGRAM
  // ---------------------------------------------------------------------------
  // Shows the four-step flow of a listener subscription:
  //   1. addListener  -> registry stores the callback
  //   2. dispatch     -> registry walks the listener list synchronously
  //   3. callback     -> listener receives an ObjectEvent
  //   4. removeListener -> registry forgets the callback; no leak
  // ===========================================================================

  print('=== Section 4: Listener flow diagram ===');
  final Widget listenerFlow = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.teal.shade50,
          Colors.cyan.shade50,
          Colors.blue.shade50,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _kAccentTeal.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _kAccentTeal.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('4. Listener flow', _kAccentTeal),
        SizedBox(height: 14.0),
        Row(
          children: [
            _buildFlowStep(
              index: 1,
              label: 'addListener',
              detail: 'register cb',
              color: _kAccentTeal,
              icon: Icons.add_circle,
            ),
            _buildFlowConnector(_kAccentTeal),
            _buildFlowStep(
              index: 2,
              label: 'dispatch',
              detail: 'fan-out',
              color: Colors.indigo,
              icon: Icons.share,
            ),
            _buildFlowConnector(Colors.indigo),
            _buildFlowStep(
              index: 3,
              label: 'listener(e)',
              detail: 'callback',
              color: _kAccentAmber,
              icon: Icons.electric_bolt,
            ),
            _buildFlowConnector(_kAccentAmber),
            _buildFlowStep(
              index: 4,
              label: 'removeListener',
              detail: 'unsubscribe',
              color: _kAccentRose,
              icon: Icons.remove_circle,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subscription is symmetric.',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Every addListener must be paired with a removeListener — '
                'usually inside dispose() of the owning State / object. '
                'If you forget removeListener the registry keeps a strong '
                'reference and your listener (and its captured closure) '
                'will outlive the widget. That is itself a memory leak.',
                style: TextStyle(fontSize: 12.0, height: 1.45, color: _kInk),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5: MOCK ALLOCATION TIMELINE STRIP
  // ---------------------------------------------------------------------------
  // We synthesize a sequence of mock allocation / disposal events and render
  // them with a CustomPainter. The timeline strip is purely illustrative: it
  // shows the cadence and balance of created vs disposed events that a real
  // listener would observe over time.
  // ===========================================================================

  print('=== Section 5: Allocation timeline strip ===');
  final List<_MockAllocEvent> mockEvents = <_MockAllocEvent>[
    _MockAllocEvent(t: 0.02, kind: _AllocKind.created, label: 'AnimController#a1'),
    _MockAllocEvent(t: 0.07, kind: _AllocKind.created, label: 'TextEditingController#t1'),
    _MockAllocEvent(t: 0.12, kind: _AllocKind.created, label: 'ScrollController#s1'),
    _MockAllocEvent(t: 0.18, kind: _AllocKind.disposed, label: 'AnimController#a1'),
    _MockAllocEvent(t: 0.24, kind: _AllocKind.created, label: 'ChangeNotifier#c1'),
    _MockAllocEvent(t: 0.31, kind: _AllocKind.created, label: 'AnimController#a2'),
    _MockAllocEvent(t: 0.38, kind: _AllocKind.disposed, label: 'TextEditingController#t1'),
    _MockAllocEvent(t: 0.46, kind: _AllocKind.created, label: 'FocusNode#f1'),
    _MockAllocEvent(t: 0.53, kind: _AllocKind.disposed, label: 'ScrollController#s1'),
    _MockAllocEvent(t: 0.60, kind: _AllocKind.created, label: 'AnimController#a3'),
    _MockAllocEvent(t: 0.66, kind: _AllocKind.disposed, label: 'AnimController#a2'),
    _MockAllocEvent(t: 0.72, kind: _AllocKind.disposed, label: 'ChangeNotifier#c1'),
    _MockAllocEvent(t: 0.78, kind: _AllocKind.created, label: 'TabController#tab1'),
    _MockAllocEvent(t: 0.84, kind: _AllocKind.disposed, label: 'FocusNode#f1'),
    _MockAllocEvent(t: 0.91, kind: _AllocKind.disposed, label: 'AnimController#a3'),
    _MockAllocEvent(t: 0.97, kind: _AllocKind.disposed, label: 'TabController#tab1'),
  ];

  final int mockCreated = mockEvents.where((e) => e.kind == _AllocKind.created).length;
  final int mockDisposed = mockEvents.where((e) => e.kind == _AllocKind.disposed).length;
  final int mockBalance = mockCreated - mockDisposed;

  final Widget timelineStrip = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade50,
          Colors.purple.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.20),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('5. Allocation timeline', Colors.deepPurple.shade700),
        SizedBox(height: 8.0),
        Text(
          'Mock sequence of ObjectCreated / ObjectDisposed events. The '
          'CustomPainter below paints each event as a tick on the timeline '
          'so the cadence and balance can be read at a glance.',
          style: TextStyle(fontSize: 12.0, color: _kInk, height: 1.4),
        ),
        SizedBox(height: 14.0),
        Container(
          height: 110.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withValues(alpha: 0.15),
                blurRadius: 8.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: CustomPaint(
            painter: _TimelinePainter(events: mockEvents),
            size: Size.infinite,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            _buildStatChip(
              'created',
              '$mockCreated',
              Icons.add_box,
              _kAccentTeal,
            ),
            SizedBox(width: 10.0),
            _buildStatChip(
              'disposed',
              '$mockDisposed',
              Icons.delete_sweep,
              _kAccentRose,
            ),
            SizedBox(width: 10.0),
            _buildStatChip(
              'balance',
              '$mockBalance',
              mockBalance == 0 ? Icons.check_circle : Icons.warning_amber,
              mockBalance == 0 ? Colors.green : _kAccentAmber,
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6: LEAK-WARNING BANNER GALLERY
  // ---------------------------------------------------------------------------
  // A real consumer of FlutterMemoryAllocations would emit warnings when the
  // created/disposed balance grows unbounded for a particular type, or when
  // the same instance receives a second creation event. We show a small
  // gallery of three warning banners with different severities.
  // ===========================================================================

  print('=== Section 6: Leak-warning banner gallery ===');
  final Widget warningGallery = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.amber.shade50,
          Colors.orange.shade50,
          Colors.red.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('6. Leak warnings', Colors.orange.shade800),
        SizedBox(height: 12.0),
        _buildWarningBanner(
          severity: 'INFO',
          title: 'Outstanding objects: 0',
          message:
              'created (8) == disposed (8). No outstanding allocations for '
              'tracked types.',
          color: Colors.green.shade700,
          icon: Icons.check_circle,
        ),
        SizedBox(height: 10.0),
        _buildWarningBanner(
          severity: 'WARN',
          title: 'Imbalance: AnimationController growing',
          message:
              'Created 12, disposed 7. 5 instances are still live after the '
              'page was popped. Did the State forget to call dispose()?',
          color: _kAccentAmber,
          icon: Icons.warning_amber,
        ),
        SizedBox(height: 10.0),
        _buildWarningBanner(
          severity: 'CRIT',
          title: 'Double-creation event for FocusNode#f1',
          message:
              'Two ObjectCreated events for the same identityHashCode and no '
              'ObjectDisposed in between. This usually means the listener '
              'sees a recreated proxy or the registry has been corrupted.',
          color: Colors.red.shade700,
          icon: Icons.error,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7: OBJECT-GRAPH VISUAL
  // ---------------------------------------------------------------------------
  // A simple object graph drawn with a CustomPainter. Each node is one of the
  // tracked types; the edges represent reachability paths that keep the node
  // alive. This is conceptually the kind of view a leak inspector builds from
  // the raw ObjectEvent stream plus the heap snapshot.
  // ===========================================================================

  print('=== Section 7: Object-graph visual ===');
  final List<_GraphNode> graphNodes = <_GraphNode>[
    _GraphNode(label: 'State', x: 0.20, y: 0.18, color: _kHeroDeep),
    _GraphNode(label: 'AnimCtrl', x: 0.55, y: 0.10, color: _kAccentTeal),
    _GraphNode(label: 'Ticker', x: 0.85, y: 0.22, color: _kAccentAmber),
    _GraphNode(label: 'Listener', x: 0.55, y: 0.50, color: _kAccentRose),
    _GraphNode(label: 'Closure', x: 0.85, y: 0.62, color: Colors.indigo),
    _GraphNode(label: 'BuildCtx', x: 0.20, y: 0.62, color: Colors.brown),
    _GraphNode(label: 'Element', x: 0.20, y: 0.90, color: Colors.deepPurple),
    _GraphNode(label: 'Disposable', x: 0.55, y: 0.88, color: Colors.green),
  ];
  final List<_GraphEdge> graphEdges = <_GraphEdge>[
    _GraphEdge(from: 0, to: 1),
    _GraphEdge(from: 1, to: 2),
    _GraphEdge(from: 1, to: 3),
    _GraphEdge(from: 3, to: 4),
    _GraphEdge(from: 0, to: 5),
    _GraphEdge(from: 5, to: 6),
    _GraphEdge(from: 6, to: 7),
    _GraphEdge(from: 7, to: 1),
    _GraphEdge(from: 3, to: 7),
  ];

  final Widget objectGraph = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blueGrey.shade50,
          Colors.indigo.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('7. Object reachability graph', _kHeroBright),
        SizedBox(height: 8.0),
        Text(
          'Each node is a tracked allocation. Edges represent strong '
          'references that keep the target reachable. A leak appears when a '
          'disposed root node still has an inbound edge.',
          style: TextStyle(fontSize: 12.0, color: _kInk, height: 1.4),
        ),
        SizedBox(height: 14.0),
        Container(
          height: 280.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.15),
                blurRadius: 8.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: CustomPaint(
            painter: _GraphPainter(nodes: graphNodes, edges: graphEdges),
            size: Size.infinite,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: graphNodes
              .map((n) => _buildLegendChip(n.label, n.color))
              .toList(),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8: RECIPES
  // ---------------------------------------------------------------------------
  // Concrete recipes for the two operations a developer is most likely to do
  // with FlutterMemoryAllocations: subscribe / unsubscribe a listener, and
  // dispatch creation / disposal for a custom Disposable type.
  // ===========================================================================

  print('=== Section 8: Recipes ===');
  final Widget recipesPanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.green.shade50,
          Colors.lightGreen.shade50,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.green.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('8. Recipes', Colors.green.shade800),
        SizedBox(height: 12.0),
        _buildRecipe(
          title: 'Recipe A — subscribe in initState, unsubscribe in dispose',
          body:
              'class _MyMonitorState extends State<MyMonitor> {\n'
              '  void _onEvent(ObjectEvent e) {\n'
              '    // count, log, route to a stream, etc.\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  void initState() {\n'
              '    super.initState();\n'
              '    FlutterMemoryAllocations.instance.addListener(_onEvent);\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  void dispose() {\n'
              '    FlutterMemoryAllocations.instance.removeListener(_onEvent);\n'
              '    super.dispose();\n'
              '  }\n'
              '}',
        ),
        SizedBox(height: 12.0),
        _buildRecipe(
          title: 'Recipe B — dispatch from a custom Disposable',
          body:
              'class MyResource {\n'
              '  MyResource() {\n'
              '    // record creation\n'
              '    FlutterMemoryAllocations.instance.dispatchObjectCreated(\n'
              '      library: \'my_pkg\',\n'
              '      className: \'MyResource\',\n'
              '      object: this,\n'
              '    );\n'
              '  }\n'
              '\n'
              '  void dispose() {\n'
              '    // record disposal — paired with the creation above\n'
              '    FlutterMemoryAllocations.instance.dispatchObjectDisposed(\n'
              '      object: this,\n'
              '    );\n'
              '  }\n'
              '}',
        ),
        SizedBox(height: 12.0),
        _buildRecipe(
          title: 'Recipe C — guard with kFlutterMemoryAllocationsEnabled',
          body:
              '// Avoid the call entirely in release mode.\n'
              'if (kFlutterMemoryAllocationsEnabled) {\n'
              '  FlutterMemoryAllocations.instance.dispatchObjectCreated(\n'
              '    library: \'my_pkg\',\n'
              '    className: \'MyResource\',\n'
              '    object: this,\n'
              '  );\n'
              '}',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9: PITFALLS
  // ---------------------------------------------------------------------------
  // The pitfalls section makes the script feel real: the API has rough edges,
  // and the user should know about them before they start subscribing.
  // ===========================================================================

  print('=== Section 9: Pitfalls ===');
  final Widget pitfallsPanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.red.shade50,
          Colors.pink.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('9. Pitfalls', Colors.red.shade800),
        SizedBox(height: 12.0),
        _buildPitfall(
          title: 'Release-mode no-op',
          body:
              'FlutterMemoryAllocations is intentionally a no-op in release '
              'builds. Do not rely on it for production telemetry — your '
              'listener will simply never be called.',
        ),
        SizedBox(height: 8.0),
        _buildPitfall(
          title: 'kFlutterMemoryAllocationsEnabled gate',
          body:
              'The Flutter framework guards every dispatch with a top-level '
              'kFlutterMemoryAllocationsEnabled constant. Custom producers '
              'should do the same, otherwise their dispatches add overhead '
              'in release without delivering any signal.',
        ),
        SizedBox(height: 8.0),
        _buildPitfall(
          title: 'Listener callbacks must be cheap',
          body:
              'Dispatch is synchronous. A slow listener slows down every '
              'object creation in the app. Defer work into a microtask or '
              'a stream; never block on I/O inside the callback.',
        ),
        SizedBox(height: 8.0),
        _buildPitfall(
          title: 'Forgotten removeListener',
          body:
              'Because the registry is a singleton, a forgotten '
              'removeListener leaks the listener closure forever. Pair every '
              'addListener with a removeListener — typically in dispose().',
        ),
        SizedBox(height: 8.0),
        _buildPitfall(
          title: 'Identity vs equality',
          body:
              'ObjectEvent.object is the actual instance, compared by '
              'identity. Do not use it as a hash-map key after disposal: the '
              'object may already be unreachable elsewhere.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // ASCII FOOTER
  // ---------------------------------------------------------------------------
  // A tiny ASCII art footer wraps up the demo and gives the page a clear end.
  // ===========================================================================

  print('=== Section: ASCII footer ===');
  final Widget asciiFooter = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.black,
          Colors.grey.shade900,
          Colors.indigo.shade900,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.30),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: _kAccentAmber, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'end-of-demo',
              style: TextStyle(
                color: _kAccentAmber,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          '+----------------------------------------------+\n'
          '|   FlutterMemoryAllocations.instance          |\n'
          '|   .addListener(...)  -> hasListeners == true |\n'
          '|   dispatchObjectCreated  *                   |\n'
          '|   dispatchObjectDisposed *                   |\n'
          '|   .removeListener(...) -> hasListeners==false|\n'
          '+----------------------------------------------+\n'
          '              |                                 \n'
          '              v                                 \n'
          '          listeners                             \n'
          '         /    |    \\                            \n'
          '   DevTools  leak_  custom                      \n'
          '             tracker  panel                     ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade100,
            height: 1.35,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // FINAL ASSEMBLY
  // ---------------------------------------------------------------------------
  // Wrap every section into a single MaterialApp(home: Scaffold(...)) so the
  // script-driven runner can mount the result without any extra setup.
  // ===========================================================================

  print('FlutterMemoryAllocations Deep Demo completed successfully');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroHeader,
              anatomyDiagram,
              instanceAccess,
              listenerFlow,
              timelineStrip,
              warningGallery,
              objectGraph,
              recipesPanel,
              pitfallsPanel,
              asciiFooter,
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HELPERS
// =============================================================================

Widget _buildSectionTitle(String text, Color color) {
  return Row(
    children: [
      Container(
        width: 8.0,
        height: 22.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      SizedBox(width: 10.0),
      Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    ],
  );
}

Widget _buildAnatomyNode({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.20),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: _kInk.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowStep({
  required int index,
  required String label,
  required String detail,
  required Color color,
  required IconData icon,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.30),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.4),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 8.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 24.0,
            height: 24.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Icon(icon, color: color, size: 22.0),
          SizedBox(height: 6.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              color: _kInk.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFlowConnector(Color color) {
  return SizedBox(
    width: 18.0,
    child: Icon(Icons.chevron_right, color: color, size: 22.0),
  );
}

Widget _buildStatChip(String label, String value, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 4.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

Widget _buildWarningBanner({
  required String severity,
  required String title,
  required String message,
  required Color color,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      severity,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                message,
                style: TextStyle(
                  fontSize: 11.5,
                  color: _kInk.withValues(alpha: 0.78),
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

Widget _buildLegendChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipe({required String title, required String body}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade300, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.10),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, size: 18.0, color: Colors.green.shade800),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.green.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(body, Colors.cyan.shade200),
      ],
    ),
  );
}

Widget _buildPitfall({required String title, required String body}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade200, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.report_problem, color: Colors.red.shade700, size: 18.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.red.shade800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  height: 1.45,
                  color: _kInk.withValues(alpha: 0.78),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade700, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.5,
      ),
    ),
  );
}

// =============================================================================
// MOCK ALLOCATION EVENT MODEL
// =============================================================================

enum _AllocKind { created, disposed }

class _MockAllocEvent {
  final double t;
  final _AllocKind kind;
  final String label;

  _MockAllocEvent({
    required this.t,
    required this.kind,
    required this.label,
  });
}

// =============================================================================
// CUSTOM PAINTER: TIMELINE STRIP
// -----------------------------------------------------------------------------
// Paints a horizontal timeline. Created events are upward green ticks above
// the baseline; disposed events are downward red ticks below the baseline.
// =============================================================================

class _TimelinePainter extends CustomPainter {
  final List<_MockAllocEvent> events;

  _TimelinePainter({required this.events});

  @override
  void paint(Canvas canvas, Size size) {
    final double padding = 12.0;
    final double midY = size.height / 2.0;

    // Background grid.
    final Paint gridPaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..strokeWidth = 1.0;
    for (int i = 0; i <= 10; i++) {
      final double x = padding + (size.width - padding * 2) * (i / 10.0);
      canvas.drawLine(Offset(x, padding), Offset(x, size.height - padding), gridPaint);
    }

    // Baseline.
    final Paint baseline = Paint()
      ..color = const Color(0xFF455A64)
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(padding, midY),
      Offset(size.width - padding, midY),
      baseline,
    );

    // Axis label arrows.
    final Paint arrowPaint = Paint()
      ..color = const Color(0xFF455A64)
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(size.width - padding, midY),
      Offset(size.width - padding - 6.0, midY - 4.0),
      arrowPaint,
    );
    canvas.drawLine(
      Offset(size.width - padding, midY),
      Offset(size.width - padding - 6.0, midY + 4.0),
      arrowPaint,
    );

    // Tick marks for events.
    final Paint createdPaint = Paint()
      ..color = const Color(0xFF00897B)
      ..strokeWidth = 2.5;
    final Paint disposedPaint = Paint()
      ..color = const Color(0xFFD81B60)
      ..strokeWidth = 2.5;

    for (final _MockAllocEvent ev in events) {
      final double x = padding + (size.width - padding * 2) * ev.t;
      if (ev.kind == _AllocKind.created) {
        canvas.drawLine(
          Offset(x, midY),
          Offset(x, midY - 22.0),
          createdPaint,
        );
        canvas.drawCircle(Offset(x, midY - 22.0), 3.0, createdPaint);
      } else {
        canvas.drawLine(
          Offset(x, midY),
          Offset(x, midY + 22.0),
          disposedPaint,
        );
        canvas.drawCircle(Offset(x, midY + 22.0), 3.0, disposedPaint);
      }
    }

    // Tiny legend in the corner.
    final TextPainter legendCreated = TextPainter(
      text: const TextSpan(
        text: 'created',
        style: TextStyle(
          color: Color(0xFF00897B),
          fontSize: 10.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    legendCreated.paint(canvas, Offset(padding, padding - 2.0));

    final TextPainter legendDisposed = TextPainter(
      text: const TextSpan(
        text: 'disposed',
        style: TextStyle(
          color: Color(0xFFD81B60),
          fontSize: 10.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    legendDisposed.paint(
      canvas,
      Offset(padding, size.height - padding - legendDisposed.height + 2.0),
    );
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.events != events;
  }
}

// =============================================================================
// CUSTOM PAINTER: OBJECT GRAPH
// -----------------------------------------------------------------------------
// Paints labelled nodes connected by simple straight edges. The picture is a
// stylised reachability graph — the kind of view a leak inspector would build
// on top of the ObjectEvent stream plus a heap snapshot.
// =============================================================================

class _GraphNode {
  final String label;
  final double x;
  final double y;
  final Color color;

  _GraphNode({
    required this.label,
    required this.x,
    required this.y,
    required this.color,
  });
}

class _GraphEdge {
  final int from;
  final int to;

  _GraphEdge({required this.from, required this.to});
}

class _GraphPainter extends CustomPainter {
  final List<_GraphNode> nodes;
  final List<_GraphEdge> edges;

  _GraphPainter({required this.nodes, required this.edges});

  @override
  void paint(Canvas canvas, Size size) {
    final double pad = 18.0;
    Offset pos(_GraphNode n) {
      return Offset(
        pad + n.x * (size.width - pad * 2),
        pad + n.y * (size.height - pad * 2),
      );
    }

    // Edges.
    final Paint edgePaint = Paint()
      ..color = const Color(0xFF607D8B)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    for (final _GraphEdge e in edges) {
      final Offset a = pos(nodes[e.from]);
      final Offset b = pos(nodes[e.to]);
      canvas.drawLine(a, b, edgePaint);

      // Arrow head.
      final double dx = b.dx - a.dx;
      final double dy = b.dy - a.dy;
      final double len = (dx * dx + dy * dy);
      if (len > 0) {
        final double ux = dx / len * 8.0;
        final double uy = dy / len * 8.0;
        final Offset arrowBase = Offset(b.dx - dx * 0.10, b.dy - dy * 0.10);
        final Paint arrowFill = Paint()..color = const Color(0xFF455A64);
        final Path arrow = Path()
          ..moveTo(arrowBase.dx, arrowBase.dy)
          ..lineTo(arrowBase.dx - uy, arrowBase.dy + ux)
          ..lineTo(arrowBase.dx + uy, arrowBase.dy - ux)
          ..close();
        canvas.drawPath(arrow, arrowFill);
      }
    }

    // Nodes.
    for (final _GraphNode n in nodes) {
      final Offset c = pos(n);
      final Paint shadow = Paint()
        ..color = n.color.withValues(alpha: 0.30)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
      canvas.drawCircle(c.translate(0.0, 2.0), 22.0, shadow);

      final Paint fill = Paint()..color = n.color;
      canvas.drawCircle(c, 20.0, fill);

      final Paint stroke = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(c, 20.0, stroke);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: n.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 44.0);
      tp.paint(
        canvas,
        Offset(c.dx - tp.width / 2.0, c.dy - tp.height / 2.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GraphPainter oldDelegate) {
    return oldDelegate.nodes != nodes || oldDelegate.edges != edges;
  }
}
