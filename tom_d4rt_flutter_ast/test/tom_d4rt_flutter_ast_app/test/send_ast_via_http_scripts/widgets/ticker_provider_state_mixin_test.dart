// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — TickerProviderStateMixin
// Demonstrates TickerProviderStateMixin — a mixin on State that
// provides Ticker objects required by AnimationController. Covers
// the ticker lifecycle, the difference from SingleTickerProvider,
// vsync parameter, and how tickers drive the animation pipeline.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TickerProviderStateMixin Deep Demo executing');

  // ============================================================
  // SECTION 1: What is TickerProviderStateMixin?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.timer,
      'title': 'Ticker Factory for State',
      'body': 'TickerProviderStateMixin is a mixin applied to State '
          'that implements TickerProvider. It creates Ticker objects '
          'that fire callbacks once per animation frame (vsync). '
          'AnimationController requires a TickerProvider to run.',
      'accent': Colors.purple[800]!,
    },
    {
      'icon': Icons.animation,
      'title': 'The vsync Parameter',
      'body': 'When you create an AnimationController, you pass vsync: '
          'this. That "this" must be a TickerProvider. The mixin '
          'makes your State class satisfy that interface, connecting '
          'the controller to the frame scheduler.',
      'accent': Colors.amber[800]!,
    },
    {
      'icon': Icons.numbers,
      'title': 'Multiple Tickers',
      'body': 'Unlike SingleTickerProviderStateMixin (which asserts '
          'only one ticker exists), TickerProviderStateMixin supports '
          'multiple simultaneous AnimationControllers. Use it when '
          'your widget runs 2+ animations concurrently.',
      'accent': Colors.purple[700]!,
    },
    {
      'icon': Icons.pause_circle,
      'title': 'Auto-Mute on Visibility',
      'body': 'When the widget tree is not visible (offscreen, app in '
          'background), tickers are automatically muted — they stop '
          'firing frame callbacks. This saves CPU/battery. Tickers '
          'resume when visibility returns.',
      'accent': Colors.amber[700]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: Ticker Lifecycle
  // ============================================================
  print('=== Section 2: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Mixin Applied',
      'detail': 'Add "with TickerProviderStateMixin" to your State '
          'class declaration. This makes the State implement '
          'TickerProvider.createTicker().',
      'icon': Icons.add_circle,
      'color': Colors.purple[800]!,
    },
    {
      'step': '2',
      'title': 'Controller Created',
      'detail': 'In initState(), create AnimationController(vsync: this). '
          'The controller calls createTicker() to get a Ticker. '
          'The Ticker registers with the scheduler.',
      'icon': Icons.build,
      'color': Colors.amber[800]!,
    },
    {
      'step': '3',
      'title': 'Ticking Active',
      'detail': 'When the controller is started (forward, repeat, etc.), '
          'the Ticker fires its callback on every vsync frame (~60fps). '
          'Each callback updates the animation value.',
      'icon': Icons.play_arrow,
      'color': Colors.purple[700]!,
    },
    {
      'step': '4',
      'title': 'Muted When Hidden',
      'detail': 'If the widget becomes invisible (e.g., pushed behind '
          'another route), the mixin mutes all tickers. Frame '
          'callbacks stop. No CPU wasted on invisible animations.',
      'icon': Icons.visibility_off,
      'color': Colors.amber[700]!,
    },
    {
      'step': '5',
      'title': 'Dispose',
      'detail': 'In dispose(), call controller.dispose() which stops '
          'and disposes the Ticker. The mixin asserts all tickers '
          'are disposed before super.dispose().',
      'icon': Icons.delete_forever,
      'color': Colors.purple[600]!,
    },
  ];

  print('  Lifecycle steps: ${lifecycleSteps.length}');

  // ============================================================
  // SECTION 3: Single vs Multi Ticker
  // ============================================================
  print('=== Section 3: Single vs Multi ===');

  final comparison = <Map<String, dynamic>>[
    {
      'feature': 'Class name',
      'single': 'SingleTickerProviderStateMixin',
      'multi': 'TickerProviderStateMixin',
    },
    {
      'feature': 'Ticker count',
      'single': 'Exactly 1',
      'multi': 'Unlimited',
    },
    {
      'feature': 'Assertion',
      'single': 'Throws if 2nd ticker created',
      'multi': 'No limit enforcement',
    },
    {
      'feature': 'Overhead',
      'single': 'Slightly lower',
      'multi': 'Tracks Set of tickers',
    },
    {
      'feature': 'Use when',
      'single': '1 AnimationController',
      'multi': '2+ AnimationControllers',
    },
    {
      'feature': 'Common mistake',
      'single': 'Using with multiple controllers',
      'multi': 'Using when single suffices',
    },
  ];

  print('  Comparison rows: ${comparison.length}');

  // ============================================================
  // SECTION 4: Animation Pipeline
  // ============================================================
  print('=== Section 4: Animation Pipeline ===');

  final pipelineSteps = <Map<String, dynamic>>[
    {
      'label': 'SchedulerBinding',
      'detail': 'Frame scheduler fires at vsync (~16ms)',
      'color': Colors.grey[700]!,
    },
    {
      'label': 'Ticker',
      'detail': 'Receives frame callback, calculates elapsed time',
      'color': Colors.purple[600]!,
    },
    {
      'label': 'AnimationController',
      'detail': 'Updates value based on elapsed/duration',
      'color': Colors.purple[700]!,
    },
    {
      'label': 'Animation/Tween',
      'detail': 'Transforms 0.0→1.0 to target range/curve',
      'color': Colors.amber[700]!,
    },
    {
      'label': 'Widget rebuild',
      'detail': 'setState or AnimatedBuilder triggers paint',
      'color': Colors.amber[800]!,
    },
  ];

  print('  Pipeline steps: ${pipelineSteps.length}');

  // ============================================================
  // SECTION 5: Usage Patterns
  // ============================================================
  print('=== Section 5: Usage Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Basic Setup',
      'code': 'class _MyState extends State<MyWidget>\n'
          '    with TickerProviderStateMixin {\n'
          '  late final AnimationController _ctrl;\n\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _ctrl = AnimationController(\n'
          '      vsync: this,\n'
          '      duration: Duration(seconds: 1),\n'
          '    );\n'
          '  }\n\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _ctrl.dispose();\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
      'description': 'Standard pattern: mixin on State, create '
          'controller in initState, dispose it in dispose.',
      'color': Colors.purple[800]!,
    },
    {
      'title': 'Multiple Controllers',
      'code': 'late final AnimationController _fadeCtrl;\n'
          'late final AnimationController _slideCtrl;\n'
          'late final AnimationController _scaleCtrl;\n\n'
          '@override\n'
          'void initState() {\n'
          '  super.initState();\n'
          '  _fadeCtrl = AnimationController(\n'
          '    vsync: this, duration: ms(300));\n'
          '  _slideCtrl = AnimationController(\n'
          '    vsync: this, duration: ms(500));\n'
          '  _scaleCtrl = AnimationController(\n'
          '    vsync: this, duration: ms(200));\n'
          '}',
      'description': 'The main reason to choose TickerProviderStateMixin '
          'over Single — multiple concurrent animations.',
      'color': Colors.amber[800]!,
    },
    {
      'title': 'With TabController',
      'code': 'class _TabState extends State<MyTabs>\n'
          '    with TickerProviderStateMixin {\n'
          '  late final TabController _tabs;\n\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _tabs = TabController(\n'
          '      length: 3, vsync: this);\n'
          '  }\n'
          '}',
      'description': 'TabController also needs a TickerProvider. '
          'If you have a TabController plus animations, you need '
          'the multi-ticker mixin.',
      'color': Colors.purple[700]!,
    },
  ];

  print('  Usage patterns: ${patterns.length}');

  // ============================================================
  // SECTION 6: Common Mistakes
  // ============================================================
  print('=== Section 6: Common Mistakes ===');

  final mistakes = <Map<String, dynamic>>[
    {
      'title': 'Forgetting to Dispose',
      'detail': 'Not calling controller.dispose() causes "Ticker was '
          'not disposed" assertion failures. Every controller must '
          'be disposed in State.dispose().',
      'icon': Icons.error_outline,
      'color': Colors.red[700]!,
    },
    {
      'title': 'Creating in build()',
      'detail': 'Creating AnimationController in build() creates a new '
          'ticker every frame, leaking resources. Always create '
          'in initState() and store as a field.',
      'icon': Icons.error_outline,
      'color': Colors.red[600]!,
    },
    {
      'title': 'Wrong Mixin Choice',
      'detail': 'Using SingleTickerProviderStateMixin with 2+ controllers '
          'causes assertion error. Switch to TickerProviderStateMixin.',
      'icon': Icons.swap_horiz,
      'color': Colors.orange[800]!,
    },
    {
      'title': 'Using After Dispose',
      'detail': 'Accessing a disposed AnimationController (e.g., from an '
          'async callback after navigation) throws. Guard with '
          'mounted check.',
      'icon': Icons.error_outline,
      'color': Colors.red[500]!,
    },
    {
      'title': 'Mixin on Wrong Class',
      'detail': 'The mixin can only be applied to State subclasses. '
          'Attempting to use it on a StatelessWidget or plain class '
          'will not compile.',
      'icon': Icons.warning_amber,
      'color': Colors.orange[700]!,
    },
  ];

  print('  Common mistakes: ${mistakes.length}');

  // ============================================================
  // SECTION 7: Ticker Internals
  // ============================================================
  print('=== Section 7: Ticker Internals ===');

  final internals = <Map<String, dynamic>>[
    {
      'name': 'createTicker(onTick)',
      'detail': 'The method from TickerProvider that the mixin '
          'implements. Creates a new Ticker with the given callback. '
          'The mixin tracks all created tickers in a Set.',
      'icon': Icons.settings,
      'color': Colors.purple[800]!,
    },
    {
      'name': 'Ticker.start()',
      'detail': 'Registers the ticker with SchedulerBinding. It '
          'receives _tick callbacks synchronized with the display '
          'vsync signal, typically 60 or 120 times per second.',
      'icon': Icons.play_arrow,
      'color': Colors.amber[800]!,
    },
    {
      'name': 'Ticker.muted',
      'detail': 'When true, the ticker silences its callback without '
          'unregistering from the scheduler. The mixin sets this '
          'based on TickerMode.of(context).',
      'icon': Icons.volume_off,
      'color': Colors.purple[700]!,
    },
    {
      'name': 'TickerMode widget',
      'detail': 'Ancestor widget that controls whether tickers should '
          'be active. TickerMode(enabled: false, child: ...) mutes '
          'all descendant tickers created by the mixin.',
      'icon': Icons.layers,
      'color': Colors.amber[700]!,
    },
  ];

  print('  Internals: ${internals.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Choose the Right Mixin',
      'detail': 'Use SingleTickerProviderStateMixin for exactly 1 '
          'AnimationController. Use TickerProviderStateMixin for 2+. '
          'The single variant catches accidental double-creation.',
      'icon': Icons.rule,
      'color': Colors.purple[800]!,
    },
    {
      'title': 'Always Dispose All Controllers',
      'detail': 'Every AnimationController must be disposed. For N '
          'controllers, you need N dispose() calls. Consider storing '
          'them in a list for batch disposal.',
      'icon': Icons.delete_sweep,
      'color': Colors.amber[800]!,
    },
    {
      'title': 'Use late final',
      'detail': 'Declare controllers as "late final" fields. This '
          'ensures they are initialized exactly once in initState() '
          'and prevents accidental reassignment.',
      'icon': Icons.lock,
      'color': Colors.purple[700]!,
    },
    {
      'title': 'Leverage TickerMode',
      'detail': 'Wrap offscreen content with TickerMode(enabled: false) '
          'to mute animations. This saves CPU when content is hidden '
          'behind other widgets.',
      'icon': Icons.visibility_off,
      'color': Colors.amber[700]!,
    },
    {
      'title': 'Guard Async Callbacks',
      'detail': 'After await, check "if (!mounted) return" before '
          'accessing the controller. The widget may have been '
          'disposed during the async gap.',
      'icon': Icons.shield,
      'color': Colors.purple[600]!,
    },
  ];

  print('  Best practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[800]!, Colors.amber[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.timer, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text('TickerProviderStateMixin',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'The State mixin that connects AnimationControllers '
                'to the frame scheduler — providing the vsync tickers '
                'that drive every Flutter animation.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.purple[800]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Lifecycle ----
        _sectionHeader('2. Ticker Lifecycle', Icons.timeline, Colors.amber[800]!),
        SizedBox(height: 10),
        ...lifecycleSteps.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: s['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(s['step'] as String,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (s['color'] as Color).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border(left: BorderSide(color: s['color'] as Color, width: 3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(s['icon'] as IconData, color: s['color'] as Color, size: 18),
                              SizedBox(width: 6),
                              Text(s['title'] as String,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: s['color'] as Color)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(s['detail'] as String, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Comparison Table ----
        _sectionHeader('3. Single vs Multi Ticker', Icons.compare_arrows, Colors.purple[800]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.purple[800],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text('Feature', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Single', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Multi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(comparison.length, (i) {
                final c = comparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.purple[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(c['feature'] as String,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                      Expanded(flex: 3, child: Text(c['single'] as String,
                          style: TextStyle(fontSize: 11))),
                      Expanded(flex: 3, child: Text(c['multi'] as String,
                          style: TextStyle(fontSize: 11))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 4: Animation Pipeline ----
        _sectionHeader('4. Animation Pipeline', Icons.auto_awesome, Colors.amber[800]!),
        SizedBox(height: 10),
        Text('How a single frame flows from scheduler to pixels:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        ...List.generate(pipelineSteps.length, (i) {
          final s = pipelineSteps[i];
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color: (s['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: s['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text('${i + 1}',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s['label'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: s['color'] as Color)),
                          Text(s['detail'] as String,
                              style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (i < pipelineSteps.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.arrow_downward, size: 18, color: Colors.grey[400]),
                ),
            ],
          );
        }),

        SizedBox(height: 20),

        // ---- Section 5: Usage Patterns ----
        _sectionHeader('5. Usage Patterns', Icons.code, Colors.purple[800]!),
        SizedBox(height: 10),
        ...patterns.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                    SizedBox(height: 4),
                    Text(p['description'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(p['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.purpleAccent[100])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Common Mistakes ----
        _sectionHeader('6. Common Mistakes', Icons.error_outline, Colors.red[700]!),
        SizedBox(height: 10),
        ...mistakes.map((m) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (m['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: m['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(m['icon'] as IconData, color: m['color'] as Color, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(m['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Ticker Internals ----
        _sectionHeader('7. Ticker Internals', Icons.settings, Colors.amber[800]!),
        SizedBox(height: 10),
        ...internals.map((t) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(t['icon'] as IconData, color: t['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: t['color'] as Color)),
                          SizedBox(height: 3),
                          Text(t['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Colors.purple[800]!),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.timer, color: Colors.purple[600], size: 28),
              SizedBox(height: 6),
              Text(
                'TickerProviderStateMixin: the essential bridge between '
                'AnimationController and the frame scheduler — making '
                'every Flutter animation tick.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
