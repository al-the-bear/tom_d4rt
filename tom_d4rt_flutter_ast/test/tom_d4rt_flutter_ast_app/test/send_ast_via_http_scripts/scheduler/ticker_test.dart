// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Ticker / TickerProvider / TickerFuture from scheduler
// Deep Demo: Visual demonstration of the Ticker family of APIs
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Ticker Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept Cards - The Ticker family
  // ============================================================
  print('=== Section 1: Ticker Concept Cards ===');

  final conceptCards = <Widget>[];

  // Concept 1: Ticker
  conceptCards.add(
    Container(
      width: 230.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.timer, size: 44.0, color: Colors.deepPurple),
          SizedBox(height: 10.0),
          Text(
            'Ticker',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Calls onTick(elapsed)\non every animation frame',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  // Concept 2: TickerProvider
  conceptCards.add(
    Container(
      width: 230.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.tune, size: 44.0, color: Colors.teal),
          SizedBox(height: 10.0),
          Text(
            'TickerProvider',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Factory that hands out\nTickers wired to vsync',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: TickerFuture
  conceptCards.add(
    Container(
      width: 230.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.flag, size: 44.0, color: Colors.orange),
          SizedBox(height: 10.0),
          Text(
            'TickerFuture',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Returned by start();\ncompletes when stopped',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 4: Provider mixins
  conceptCards.add(
    Container(
      width: 230.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade50, Colors.red.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.pink.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.extension, size: 44.0, color: Colors.pink),
          SizedBox(height: 10.0),
          Text(
            'Provider Mixins',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'SingleTickerProviderStateMixin\nTickerProviderStateMixin',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.pink.shade700),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Construction code panels
  // ============================================================
  print('=== Section 2: Ticker construction examples ===');

  Widget buildCodePanel(String title, String code, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: accent, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.green.shade300,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final constructionPanels = <Widget>[
    buildCodePanel(
      'Bare Ticker (needs a vsync host)',
      '// Inside a State<T> with SingleTickerProviderStateMixin\n'
          'late final Ticker _ticker = createTicker((Duration elapsed) {\n'
          "  print('elapsed = \$elapsed');\n"
          '});\n'
          '\n'
          '@override\n'
          'void initState() {\n'
          '  super.initState();\n'
          '  _ticker.start();\n'
          '}',
      Colors.cyan.shade300,
    ),
    buildCodePanel(
      'Stopping and disposing safely',
      '@override\n'
          'void dispose() {\n'
          '  _ticker.stop();   // safe even if already stopped\n'
          '  _ticker.dispose(); // releases the vsync hookup\n'
          '  super.dispose();\n'
          '}',
      Colors.amber.shade300,
    ),
    buildCodePanel(
      'Awaiting completion via TickerFuture',
      'final TickerFuture future = _ticker.start();\n'
          'await future;                 // completes on stop()\n'
          'await future.orCancel;        // throws if canceled',
      Colors.pink.shade200,
    ),
    buildCodePanel(
      'Muting (e.g. when route is not visible)',
      '// muted = true pauses callbacks but keeps the ticker active\n'
          '_ticker.muted = true;\n'
          'assert(_ticker.isActive == true);\n'
          'assert(_ticker.isTicking == false);',
      Colors.lightGreenAccent.shade100,
    ),
  ];

  // ============================================================
  // SECTION 3: Lifecycle timeline
  // ============================================================
  print('=== Section 3: Ticker lifecycle timeline ===');

  final lifecycleSteps = [
    {
      'step': 'createTicker(onTick)',
      'desc':
          'TickerProvider hands out a Ticker bound to vsync. isActive=false, isTicking=false.',
      'icon': Icons.add_circle,
      'color': Colors.blue,
    },
    {
      'step': 'ticker.start()',
      'desc':
          'Returns a TickerFuture. isActive becomes true, isTicking becomes true.',
      'icon': Icons.play_circle,
      'color': Colors.green,
    },
    {
      'step': 'onTick(elapsed)',
      'desc':
          'Called once per animation frame with cumulative time since start.',
      'icon': Icons.bolt,
      'color': Colors.amber.shade800,
    },
    {
      'step': 'ticker.muted = true',
      'desc':
          'Active but paused. isActive=true, isTicking=false. No callbacks fire.',
      'icon': Icons.volume_off,
      'color': Colors.orange,
    },
    {
      'step': 'ticker.stop()',
      'desc':
          'Completes the TickerFuture. isActive=false, isTicking=false.',
      'icon': Icons.stop_circle,
      'color': Colors.red,
    },
    {
      'step': 'ticker.dispose()',
      'desc': 'Releases the vsync registration. Required in dispose().',
      'icon': Icons.delete_forever,
      'color': Colors.brown,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (int i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final color = step['color'] as Color;
    final isLast = i == lifecycleSteps.length - 1;
    lifecycleWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.45),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 36.0,
                  color: color.withValues(alpha: 0.45),
                ),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 14.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.35),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          '#${i + 1}',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        step['step'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  print('Created ${lifecycleWidgets.length} lifecycle steps');

  // ============================================================
  // SECTION 4: Comparison table (Ticker vs Timer vs AnimationController)
  // ============================================================
  print('=== Section 4: Comparison table ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'feature': 'Cadence',
      'ticker': 'Per animation frame (vsync)',
      'timer': 'Fixed Duration interval',
      'controller': 'Per frame via internal Ticker',
    },
    {
      'feature': 'Backed by vsync',
      'ticker': 'Yes',
      'timer': 'No',
      'controller': 'Yes',
    },
    {
      'feature': 'Pauseable',
      'ticker': 'muted = true',
      'timer': 'Cancel + recreate',
      'controller': 'stop() / TickerMode',
    },
    {
      'feature': 'Returns Future',
      'ticker': 'TickerFuture from start()',
      'timer': 'No (callback only)',
      'controller': 'TickerFuture from forward()',
    },
    {
      'feature': 'Typical use',
      'ticker': 'Custom render loops',
      'timer': 'Delays, polling',
      'controller': 'UI animations w/ curves',
    },
    {
      'feature': 'Disposal',
      'ticker': 'dispose() required',
      'timer': 'cancel() required',
      'controller': 'dispose() required',
    },
  ];

  Widget buildCompCell(String text, Color color, {bool header = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: header
            ? color.withValues(alpha: 0.85)
            : color.withValues(alpha: 0.10),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
          width: 0.6,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: header ? 12.0 : 11.0,
          fontWeight: header ? FontWeight.bold : FontWeight.normal,
          color: header ? Colors.white : Colors.grey.shade900,
        ),
      ),
    );
  }

  final compHeader = Row(
    children: [
      Expanded(
        flex: 2,
        child: buildCompCell('Feature', Colors.blueGrey, header: true),
      ),
      Expanded(
        flex: 3,
        child: buildCompCell('Ticker', Colors.deepPurple, header: true),
      ),
      Expanded(
        flex: 3,
        child: buildCompCell('Timer', Colors.orange, header: true),
      ),
      Expanded(
        flex: 3,
        child: buildCompCell(
          'AnimationController',
          Colors.teal,
          header: true,
        ),
      ),
    ],
  );

  final compRows = <Widget>[];
  for (final row in comparisonRows) {
    compRows.add(
      // Fix(H23): wrap stretch-Row in IntrinsicHeight to bound the
      // unbounded vertical constraint coming from
      // SingleChildScrollView → Column(stretch) → ClipRRect → Column.
      // Without it, RenderDecoratedBox inside buildCompCell sees
      // BoxConstraints(h=Infinity) and the framework asserts.
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: buildCompCell(row['feature'] as String, Colors.blueGrey),
            ),
            Expanded(
              flex: 3,
              child: buildCompCell(row['ticker'] as String, Colors.deepPurple),
            ),
            Expanded(
              flex: 3,
              child: buildCompCell(row['timer'] as String, Colors.orange),
            ),
            Expanded(
              flex: 3,
              child: buildCompCell(row['controller'] as String, Colors.teal),
            ),
          ],
        ),
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        children: [
          compHeader,
          ...compRows,
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 5: Frame-callback diagram (vsync -> onTick -> render)
  // ============================================================
  print('=== Section 5: Frame-callback diagram ===');

  Widget buildDiagramNode({
    required IconData icon,
    required String label,
    required String sublabel,
    required Color color,
  }) {
    return Container(
      width: 130.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.9), color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30.0),
          SizedBox(height: 6.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            sublabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_forward, color: Colors.grey.shade700, size: 24.0),
          Text(
            'frame',
            style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  final frameDiagram = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'How a Ticker plugs into the Flutter frame pipeline',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDiagramNode(
              icon: Icons.flash_on,
              label: 'vsync',
              sublabel: 'engine signal',
              color: Colors.indigo,
            ),
            buildArrow(),
            buildDiagramNode(
              icon: Icons.timeline,
              label: 'SchedulerBinding',
              sublabel: 'transient phase',
              color: Colors.deepPurple,
            ),
            buildArrow(),
            buildDiagramNode(
              icon: Icons.timer,
              label: 'Ticker',
              sublabel: 'onTick(elapsed)',
              color: Colors.teal,
            ),
            buildArrow(),
            buildDiagramNode(
              icon: Icons.brush,
              label: 'render',
              sublabel: 'build + paint',
              color: Colors.orange,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade800, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'elapsed is the cumulative Duration since start(); '
                  'it resets if the ticker is stopped and started again.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.amber.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Real-world usage patterns
  // ============================================================
  print('=== Section 6: Real-world usage patterns ===');

  Widget buildPatternCard({
    required IconData icon,
    required String title,
    required String when,
    required String snippet,
    required Color color,
  }) {
    return Container(
      width: 320.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 20.0),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        when,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14.0),
                bottomRight: Radius.circular(14.0),
              ),
            ),
            child: Text(
              snippet,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: Colors.green.shade300,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final patternCards = <Widget>[
    buildPatternCard(
      icon: Icons.animation,
      title: 'AnimationController',
      when: 'UI animations driven by curves',
      snippet:
          'final c = AnimationController(\n'
          '  vsync: this,\n'
          '  duration: Duration(milliseconds: 600),\n'
          ');\n'
          'c.forward();',
      color: Colors.teal,
    ),
    buildPatternCard(
      icon: Icons.sports_esports,
      title: 'Custom game loop',
      when: 'Per-frame physics or simulation',
      snippet:
          'late final Ticker _loop = createTicker((Duration t) {\n'
          '  final dt = t - _last;\n'
          '  _last = t;\n'
          '  _world.advance(dt);\n'
          "  setState(() {});\n"
          '});',
      color: Colors.deepPurple,
    ),
    buildPatternCard(
      icon: Icons.pan_tool,
      title: 'Smooth drag inertia',
      when: 'Decelerate after a drag gesture',
      snippet:
          'late final Ticker _coast = createTicker((Duration t) {\n'
          '  _v *= 0.95;\n'
          '  _offset += _v;\n'
          '  if (_v.abs() < 0.01) _coast.stop();\n'
          '});',
      color: Colors.orange,
    ),
    buildPatternCard(
      icon: Icons.movie_filter,
      title: 'Marquee text scroller',
      when: 'Continuous, looping ticker-driven scroll',
      snippet:
          'late final Ticker _scroll = createTicker((Duration t) {\n'
          '  final px = (t.inMilliseconds / 8) % width;\n'
          '  controller.jumpTo(px);\n'
          '});\n'
          '_scroll.start();',
      color: Colors.pink,
    ),
  ];

  // ============================================================
  // SECTION 7: State matrix (isActive / isTicking / muted)
  // ============================================================
  print('=== Section 7: State matrix ===');

  final stateRows = <Map<String, dynamic>>[
    {
      'state': 'Fresh ticker',
      'active': false,
      'ticking': false,
      'muted': false,
      'desc': 'Returned by createTicker(), not started yet',
      'color': Colors.grey,
    },
    {
      'state': 'After start()',
      'active': true,
      'ticking': true,
      'muted': false,
      'desc': 'TickerFuture pending; callbacks every frame',
      'color': Colors.green,
    },
    {
      'state': 'start() + muted',
      'active': true,
      'ticking': false,
      'muted': true,
      'desc': 'Active but paused; no callbacks fire',
      'color': Colors.orange,
    },
    {
      'state': 'After stop()',
      'active': false,
      'ticking': false,
      'muted': false,
      'desc': 'TickerFuture completes normally',
      'color': Colors.red,
    },
    {
      'state': 'stop(canceled: true)',
      'active': false,
      'ticking': false,
      'muted': false,
      'desc': 'TickerFuture.orCancel throws TickerCanceled',
      'color': Colors.brown,
    },
  ];

  Widget buildStateChip(bool value) {
    return Container(
      width: 28.0,
      height: 28.0,
      decoration: BoxDecoration(
        color: value
            ? Colors.green.shade400
            : Colors.grey.shade300,
        shape: BoxShape.circle,
        border: Border.all(
          color: value ? Colors.green.shade700 : Colors.grey.shade500,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Icon(
          value ? Icons.check : Icons.close,
          color: Colors.white,
          size: 18.0,
        ),
      ),
    );
  }

  final stateMatrixWidgets = <Widget>[];

  stateMatrixWidgets.add(
    Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade600,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'State',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'isActive',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'isTicking',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'muted',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 11.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  for (int i = 0; i < stateRows.length; i++) {
    final row = stateRows[i];
    final color = row['color'] as Color;
    final isLast = i == stateRows.length - 1;
    stateMatrixWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: isLast ? 0 : 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row['state'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    row['desc'] as String,
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(child: buildStateChip(row['active'] as bool)),
            ),
            Expanded(
              flex: 1,
              child: Center(child: buildStateChip(row['ticking'] as bool)),
            ),
            Expanded(
              flex: 1,
              child: Center(child: buildStateChip(row['muted'] as bool)),
            ),
          ],
        ),
      ),
    );
  }

  final stateMatrix = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(children: stateMatrixWidgets),
    ),
  );

  // ============================================================
  // SECTION 8: Vsync relationship diagram
  // ============================================================
  print('=== Section 8: Vsync ownership chain ===');

  Widget buildVsyncBox(String title, String detail, Color color) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'monospace',
              fontSize: 13.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  final vsyncDiagram = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade300, width: 1.5),
    ),
    child: Column(
      children: [
        Text(
          'Who owns the vsync?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        buildVsyncBox(
          'SchedulerBinding',
          'Engine vsync signal',
          Colors.indigo,
        ),
        Icon(Icons.arrow_downward, color: Colors.indigo.shade400),
        buildVsyncBox(
          'TickerProvider',
          'this  (the State<T>)',
          Colors.deepPurple,
        ),
        Icon(Icons.arrow_downward, color: Colors.deepPurple.shade400),
        buildVsyncBox(
          'Ticker',
          'createTicker(onTick)',
          Colors.teal,
        ),
        Icon(Icons.arrow_downward, color: Colors.teal.shade400),
        buildVsyncBox(
          'TickerFuture',
          'returned from start()',
          Colors.orange,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'A Ticker without its provider would be leaked. The mixins '
            'automatically dispose tickers tied to the host State.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Summary panel
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade100, Colors.teal.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.timer,
          'One callback per frame',
          'Ticker.onTick fires once per vsync, with cumulative elapsed time.',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.tune,
          'Always need a TickerProvider',
          'Use SingleTickerProviderStateMixin or TickerProviderStateMixin.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.pause_circle,
          'muted != stopped',
          'muted keeps the ticker active but suppresses callbacks.',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.flag,
          'start() returns TickerFuture',
          'Completes on stop(); use .orCancel to detect cancellation.',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.delete_forever,
          'Dispose in State.dispose()',
          'Forgetting dispose() leaks the vsync registration.',
          Colors.brown,
        ),
      ],
    ),
  );

  print('Ticker Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withValues(alpha: 0.3),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.timer, size: 60.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    'Ticker, TickerProvider & TickerFuture',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/scheduler.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.0),

            // Section 1
            Text(
              '1. The Ticker family at a glance',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: conceptCards,
            ),
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. Construction & basic usage',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...constructionPanels,
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. Lifecycle timeline',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(children: lifecycleWidgets),
            ),
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. Ticker vs Timer vs AnimationController',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            comparisonTable,
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Frame-callback pipeline',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            frameDiagram,
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. Real-world usage patterns',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: patternCards,
            ),
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. State matrix (isActive / isTicking / muted)',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            stateMatrix,
            SizedBox(height: 32.0),

            // Section 8
            Text(
              '8. Vsync ownership chain',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            vsyncDiagram,
            SizedBox(height: 32.0),

            // Section 9
            Text(
              '9. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
            SizedBox(height: 16.0),
          ],
        ),
      ),
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
