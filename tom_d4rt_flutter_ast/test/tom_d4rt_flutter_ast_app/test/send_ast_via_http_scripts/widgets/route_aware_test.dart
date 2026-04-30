// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — RouteAware
// Demonstrates RouteAware — a mixin that lets widgets subscribe
// to route lifecycle events (didPush, didPop, didPushNext,
// didPopNext) via a RouteObserver. Essential for pausing media,
// refreshing data, or tracking analytics on page visibility.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RouteAware Deep Demo executing');

  // ============================================================
  // SECTION 1: What is RouteAware?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.route,
      'title': 'Route Lifecycle Observer',
      'body': 'RouteAware is a mixin that provides four lifecycle callbacks: '
          'didPush, didPop, didPushNext, didPopNext. Widgets mix it in '
          'to react when their Route appears, disappears, or is covered '
          'by another route.',
      'accent': Colors.deepOrange[800]!,
    },
    {
      'icon': Icons.visibility,
      'title': 'Page Visibility Tracking',
      'body': 'The most common use case: pause expensive operations (video, '
          'audio, animations) when a page is covered by another route, '
          'and resume when the page becomes visible again.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.hub,
      'title': 'RouteObserver Hub',
      'body': 'RouteAware widgets don\'t watch routes directly. They '
          'subscribe to a RouteObserver<PageRoute> that is registered '
          'as a navigator observer. The observer dispatches events '
          'to all subscribed RouteAware instances.',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.cleaning_services,
      'title': 'Subscription Lifecycle',
      'body': 'Subscribe in didChangeDependencies (not initState, because '
          'ModalRoute.of(context) requires a built tree). Unsubscribe '
          'in dispose to prevent memory leaks.',
      'accent': Colors.teal[600]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: The Four Callbacks
  // ============================================================
  print('=== Section 2: Callbacks ===');

  final callbackEntries = <Map<String, dynamic>>[
    {
      'name': 'didPush',
      'description': 'Called when this route has been pushed onto the '
          'navigator. The route is now the top-most visible route.',
      'trigger': 'Navigator pushes THIS route',
      'example': 'Start playing background music on this page.',
      'icon': Icons.arrow_upward,
      'color': Colors.deepOrange[800]!,
    },
    {
      'name': 'didPopNext',
      'description': 'Called when the route that was on top of this route '
          'has been popped off. This route is now visible again.',
      'trigger': 'Route above THIS is popped',
      'example': 'Resume video playback when returning to this page.',
      'icon': Icons.arrow_downward,
      'color': Colors.teal[700]!,
    },
    {
      'name': 'didPushNext',
      'description': 'Called when a new route has been pushed on top of '
          'this route. This route is now covered / invisible.',
      'trigger': 'New route pushed ABOVE this',
      'example': 'Pause animations or timers while not visible.',
      'icon': Icons.arrow_forward,
      'color': Colors.deepOrange[700]!,
    },
    {
      'name': 'didPop',
      'description': 'Called when this route has been popped off the '
          'navigator. This is the last callback before disposal.',
      'trigger': 'THIS route is popped',
      'example': 'Send analytics event: page exit.',
      'icon': Icons.close,
      'color': Colors.teal[600]!,
    },
  ];

  print('  Callback entries: ${callbackEntries.length}');

  // ============================================================
  // SECTION 3: Setup Pattern
  // ============================================================
  print('=== Section 3: Setup Pattern ===');

  final setupSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Create a RouteObserver',
      'code': 'final routeObserver = RouteObserver<PageRoute>();',
      'detail': 'Typically a top-level or app-level variable. One observer '
          'can serve the entire app.',
    },
    {
      'step': 2,
      'title': 'Register as Navigator Observer',
      'code': 'MaterialApp(\n  navigatorObservers: [routeObserver],\n)',
      'detail': 'The observer must be in the navigator\'s observer list '
          'to receive route change notifications.',
    },
    {
      'step': 3,
      'title': 'Subscribe in didChangeDependencies',
      'code': '@override\n'
          'void didChangeDependencies() {\n'
          '  super.didChangeDependencies();\n'
          '  routeObserver.subscribe(\n'
          '    this, ModalRoute.of(context)! as PageRoute,\n'
          '  );\n'
          '}',
      'detail': 'Must use didChangeDependencies, not initState, because '
          'ModalRoute.of(context) needs the widget to be mounted.',
    },
    {
      'step': 4,
      'title': 'Unsubscribe in dispose',
      'code': '@override\n'
          'void dispose() {\n'
          '  routeObserver.unsubscribe(this);\n'
          '  super.dispose();\n'
          '}',
      'detail': 'Prevents the observer from holding a reference to a '
          'disposed widget, which would cause memory leaks.',
    },
  ];

  print('  Setup steps: ${setupSteps.length}');

  // ============================================================
  // SECTION 4: Route Transition Visualization
  // ============================================================
  print('=== Section 4: Route Transitions ===');

  final transitions = <Map<String, dynamic>>[
    {
      'label': 'A pushed',
      'stack': ['A'],
      'event': 'A.didPush()',
      'color': Colors.deepOrange[800]!,
    },
    {
      'label': 'B pushed over A',
      'stack': ['A', 'B'],
      'event': 'A.didPushNext()\nB.didPush()',
      'color': Colors.teal[700]!,
    },
    {
      'label': 'C pushed over B',
      'stack': ['A', 'B', 'C'],
      'event': 'B.didPushNext()\nC.didPush()',
      'color': Colors.deepOrange[700]!,
    },
    {
      'label': 'C popped',
      'stack': ['A', 'B'],
      'event': 'C.didPop()\nB.didPopNext()',
      'color': Colors.teal[600]!,
    },
    {
      'label': 'B popped',
      'stack': ['A'],
      'event': 'B.didPop()\nA.didPopNext()',
      'color': Colors.deepOrange[600]!,
    },
  ];

  print('  Transitions: ${transitions.length}');

  // ============================================================
  // SECTION 5: Common Use Cases
  // ============================================================
  print('=== Section 5: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Video / Audio Playback',
      'description': 'Pause playback in didPushNext, resume in didPopNext. '
          'Prevents audio from playing behind dialog overlays.',
      'icon': Icons.play_circle,
      'code': '@override\n'
          'void didPushNext() => _controller.pause();\n'
          '@override\n'
          'void didPopNext() => _controller.play();',
      'color': Colors.deepOrange[800]!,
    },
    {
      'title': 'Data Refresh',
      'description': 'Refresh data in didPopNext when returning from a '
          'detail/edit page. The list screen reloads to show changes.',
      'icon': Icons.refresh,
      'code': '@override\nvoid didPopNext() => _loadData();',
      'color': Colors.teal[700]!,
    },
    {
      'title': 'Analytics Tracking',
      'description': 'Track page views and time spent. Start timer in '
          'didPush/didPopNext, stop in didPushNext/didPop.',
      'icon': Icons.analytics,
      'code': '@override\nvoid didPush() => _analytics.pageView(name);\n'
          '@override\nvoid didPop() => _analytics.pageExit(name);',
      'color': Colors.deepOrange[700]!,
    },
    {
      'title': 'Animation Control',
      'description': 'Pause expensive animations when the screen is not '
          'visible. Saves CPU and battery on mobile devices.',
      'icon': Icons.animation,
      'code': '@override\nvoid didPushNext() => _ticker.muted = true;\n'
          '@override\nvoid didPopNext() => _ticker.muted = false;',
      'color': Colors.teal[600]!,
    },
    {
      'title': 'Scroll Position Reset',
      'description': 'Reset scroll position or clear selection when '
          'navigating back. Provides a fresh view on return.',
      'icon': Icons.vertical_align_top,
      'code': '@override\nvoid didPopNext() {\n'
          '  _scrollController.jumpTo(0);\n'
          '}',
      'color': Colors.deepOrange[600]!,
    },
  ];

  print('  Use cases: ${useCases.length}');

  // ============================================================
  // SECTION 6: RouteAware vs Alternatives
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'approach': 'RouteAware + RouteObserver',
      'scope': 'Per-widget',
      'events': '4 callbacks',
      'best': 'Widget-level visibility reactions',
    },
    {
      'approach': 'NavigatorObserver',
      'scope': 'Global',
      'events': 'All route changes',
      'best': 'App-wide analytics or logging',
    },
    {
      'approach': 'WidgetsBindingObserver',
      'scope': 'App lifecycle',
      'events': 'didChangeAppLifecycleState',
      'best': 'Foreground/background transitions',
    },
    {
      'approach': 'Visibility / VisibilityDetector',
      'scope': 'Viewport',
      'events': 'Scroll visibility',
      'best': 'Lazy loading in scroll lists',
    },
  ];

  print('  Comparison rows: ${comparisons.length}');

  // ============================================================
  // SECTION 7: Gotchas & Best Practices
  // ============================================================
  print('=== Section 7: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Use didChangeDependencies, Not initState',
      'detail': 'ModalRoute.of(context) returns null in initState because '
          'the route hasn\'t been associated yet. Always subscribe '
          'in didChangeDependencies.',
      'icon': Icons.warning_amber,
      'color': Colors.deepOrange[800]!,
      'kind': 'Warning',
    },
    {
      'title': 'Guard Against Multiple Subscriptions',
      'detail': 'didChangeDependencies can be called multiple times. '
          'Track whether you\'ve already subscribed, or unsubscribe '
          'before re-subscribing to avoid duplicate notifications.',
      'icon': Icons.shield,
      'color': Colors.teal[700]!,
      'kind': 'Tip',
    },
    {
      'title': 'Always Unsubscribe in dispose',
      'detail': 'Forgetting to unsubscribe leaks the RouteAware reference '
          'inside the RouteObserver set, preventing garbage collection.',
      'icon': Icons.delete_sweep,
      'color': Colors.deepOrange[700]!,
      'kind': 'Warning',
    },
    {
      'title': 'One RouteObserver Per Navigator',
      'detail': 'If you use nested Navigators, each one needs its own '
          'RouteObserver. A single observer only sees events from '
          'the Navigator it is registered with.',
      'icon': Icons.account_tree,
      'color': Colors.teal[600]!,
      'kind': 'Tip',
    },
    {
      'title': 'Dialogs and Modals',
      'detail': 'showDialog creates a route, so didPushNext fires on '
          'the page underneath. This is often desired for pausing, '
          'but can surprise if you only expected full-page pushes.',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.deepOrange[600]!,
      'kind': 'Note',
    },
  ];

  print('  Best practices: ${practices.length}');

  // ============================================================
  // SECTION 8: Complete Implementation Pattern
  // ============================================================
  print('=== Section 8: Full Pattern ===');

  final fullPatternCode = '''class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() => print('Pushed');
  @override
  void didPopNext() => print('Visible again');
  @override
  void didPushNext() => print('Covered');
  @override
  void didPop() => print('Popped');

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}''';

  print('  Full pattern code rendered');

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
              colors: [Colors.deepOrange[800]!, Colors.teal[600]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.route, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'RouteAware',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'A mixin for widgets that need to know when their route '
                'appears, disappears, or is covered by another route — '
                'enabling smart page-visibility reactions.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.deepOrange[800]!),
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

        // ---- Section 2: The Four Callbacks ----
        _sectionHeader('2. The Four Callbacks', Icons.notifications, Colors.teal[700]!),
        SizedBox(height: 10),
        ...callbackEntries.map((cb) => Padding(
              padding: EdgeInsets.only(bottom: 10),
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
                    Row(
                      children: [
                        Icon(cb['icon'] as IconData, color: cb['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(cb['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: cb['color'] as Color)),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: (cb['color'] as Color).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(cb['trigger'] as String,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: cb['color'] as Color)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(cb['description'] as String, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.lightbulb_outline, size: 14, color: Colors.grey[600]),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(cb['example'] as String,
                                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey[600])),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Setup Pattern ----
        _sectionHeader('3. Setup in 4 Steps', Icons.build, Colors.deepOrange[800]!),
        SizedBox(height: 10),
        ...setupSteps.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange[800],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${s['step']}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['title'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(s['code'] as String,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                        ),
                        SizedBox(height: 4),
                        Text(s['detail'] as String,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Route Transition Visualization ----
        _sectionHeader('4. Route Stack & Events', Icons.layers, Colors.teal[700]!),
        SizedBox(height: 10),
        Text(
          'Follow the route stack as pages are pushed and popped, '
          'and see which callbacks fire at each step:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: transitions.map((t) {
              final stack = t['stack'] as List<String>;
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: t['color'] as Color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(9),
                            topRight: Radius.circular(9),
                          ),
                        ),
                        child: Text(t['label'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                      ),
                      SizedBox(height: 6),
                      // Stack visualization
                      ...stack.reversed.map((route) => Container(
                            width: 100,
                            margin: EdgeInsets.only(bottom: 3),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: route == stack.last
                                  ? (t['color'] as Color).withValues(alpha: 0.3)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: route == stack.last
                                    ? t['color'] as Color
                                    : Colors.grey[400]!,
                              ),
                            ),
                            child: Text(route,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: route == stack.last
                                      ? t['color'] as Color
                                      : Colors.grey[600],
                                )),
                          )),
                      SizedBox(height: 6),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(t['event'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: Colors.grey[700])),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 5: Common Use Cases ----
        _sectionHeader('5. Common Use Cases', Icons.cases, Colors.deepOrange[800]!),
        SizedBox(height: 10),
        ...useCases.map((uc) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (uc['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: uc['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(uc['icon'] as IconData, color: uc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(uc['title'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: uc['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(uc['description'] as String, style: TextStyle(fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(uc['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Comparison Table ----
        _sectionHeader('6. RouteAware vs Alternatives', Icons.compare_arrows, Colors.teal[700]!),
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
                color: Colors.teal[700],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Approach', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Scope', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Events', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Best For', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(comparisons.length, (i) {
                final c = comparisons[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.teal[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(c['approach'] as String,
                            style: TextStyle(fontSize: 11, fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(c['scope'] as String, style: TextStyle(fontSize: 11)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(c['events'] as String, style: TextStyle(fontSize: 11)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(c['best'] as String, style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 7: Best Practices ----
        _sectionHeader('7. Gotchas & Best Practices', Icons.tips_and_updates, Colors.deepOrange[800]!),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 10),
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
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 20),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(p['title'] as String,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (p['color'] as Color).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(p['kind'] as String,
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: p['color'] as Color)),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Complete Implementation ----
        _sectionHeader('8. Complete Implementation', Icons.code, Colors.teal[700]!),
        SizedBox(height: 10),
        Text(
          'A complete RouteAware widget pattern showing subscription '
          'lifecycle and all four callbacks:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(fullPatternCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
        ),

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
              Icon(Icons.route, color: Colors.deepOrange[600], size: 28),
              SizedBox(height: 6),
              Text(
                'RouteAware: know when your page is visible, covered, '
                'or gone — and react accordingly.',
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
