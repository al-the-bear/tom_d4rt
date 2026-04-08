// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DefaultTransitionDelegate
// Demonstrates DefaultTransitionDelegate — the default implementation
// of TransitionDelegate used by Navigator 2.0 (Router API) to decide
// how route transitions animate when the route stack changes. Covers
// resolution logic, push/pop behavior, custom delegates, and how it
// compares to Navigator 1.0 transitions.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DefaultTransitionDelegate Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DefaultTransitionDelegate?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swap_horiz,
      'title': 'Navigator 2.0 Transition Resolver',
      'body': 'DefaultTransitionDelegate is the default implementation '
          'of TransitionDelegate in Flutter\'s Router/Navigator 2.0 API. '
          'When the declared page list changes, it resolves which routes '
          'should animate in (push), animate out (pop), or not animate '
          '(add/remove without transition).',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Push vs Pop vs Add vs Remove',
      'body': 'The delegate classifies each route change into one of four '
          'actions: push (animate in forward), pop (animate in reverse), '
          'add (appear instantly without animation), or remove (disappear '
          'instantly). DefaultTransitionDelegate uses simple heuristics.',
      'accent': Colors.lightBlue[700]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Works with Page-Based Navigation',
      'body': 'In Navigator 2.0, you declare a list of Page objects. '
          'When this list changes (pages added, removed, reordered), the '
          'Navigator calls the TransitionDelegate to decide how each '
          'affected route should animate. This is the declarative version '
          'of push/pop transitions.',
      'accent': Colors.indigo[600]!,
    },
    {
      'icon': Icons.auto_fix_high,
      'title': 'Automatic & Customizable',
      'body': 'DefaultTransitionDelegate is the out-of-box behavior. '
          'For most apps, it works correctly: new pages push, removed '
          'pages pop. But you can subclass TransitionDelegate to create '
          'custom resolution logic for complex navigation patterns.',
      'accent': Colors.lightBlue[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: TransitionDelegate Overview
  // ============================================================
  print('=== Section 2: TransitionDelegate ===');

  final baseMethods = <Map<String, dynamic>>[
    {
      'name': 'resolve()',
      'signature': 'Iterable<RouteTransitionRecord> resolve({...})',
      'icon': Icons.mediation,
      'color': Colors.indigo[700]!,
      'description': 'The main method. Receives lists of new routes, '
          'location-changed routes, and previous-active routes. Returns '
          'an ordered iterable of RouteTransitionRecord entries with '
          'their resolved transition actions.',
    },
    {
      'name': 'RouteTransitionRecord',
      'signature': 'abstract class RouteTransitionRecord',
      'icon': Icons.article,
      'color': Colors.lightBlue[700]!,
      'description': 'Represents a single route in the resolution process. '
          'Contains the Route object and provides methods to mark the route '
          'as push, pop, add, or remove. The delegate calls these methods '
          'to assign each route its transition action.',
    },
    {
      'name': 'markForPush()',
      'signature': 'void markForPush()',
      'icon': Icons.arrow_forward,
      'color': Colors.indigo[600]!,
      'description': 'Marks a route to animate in with its push transition. '
          'This is the standard forward animation — typically sliding in '
          'from the right or fading in, depending on the route\'s '
          'PageRoute implementation.',
    },
    {
      'name': 'markForPop()',
      'signature': 'void markForPop([dynamic result])',
      'icon': Icons.arrow_back,
      'color': Colors.lightBlue[600]!,
      'description': 'Marks a route to animate out with its pop transition. '
          'The reverse of the push animation — sliding out to the right '
          'or fading out. Optionally carries a result value.',
    },
    {
      'name': 'markForAdd()',
      'signature': 'void markForAdd()',
      'icon': Icons.add,
      'color': Colors.indigo[500]!,
      'description': 'Marks a route to appear instantly without animation. '
          'Used for routes that should just be present immediately, such '
          'as the initial route or routes restored from state.',
    },
    {
      'name': 'markForRemove()',
      'signature': 'void markForRemove()',
      'icon': Icons.remove,
      'color': Colors.lightBlue[500]!,
      'description': 'Marks a route to disappear instantly without animation. '
          'The route is removed from the stack immediately. Used for '
          'cleanup or replacing the entire navigation stack.',
    },
  ];

  print('  Prepared ${baseMethods.length} base methods');

  // ============================================================
  // SECTION 3: Resolution Algorithm
  // ============================================================
  print('=== Section 3: Algorithm ===');

  final algorithmSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'Receive Inputs',
      'icon': Icons.input,
      'description': 'The Navigator provides three lists to resolve():\n'
          '• newPageRouteHistory: Routes for newly added pages\n'
          '• locationToExitingPageRoute: Map of old routes to their '
          'screen location\n'
          '• pageRouteToPagelessRoutes: Map linking page routes to '
          'their associated pageless routes (dialogs, etc.)',
    },
    {
      'step': 2,
      'label': 'Process New Routes',
      'icon': Icons.fiber_new,
      'description': 'For each new route that was not in the previous '
          'stack:\n'
          '• If it is the initial route → markForAdd() (no animation)\n'
          '• If it appears at the top → markForPush() (animate in)\n'
          '• Otherwise → markForAdd() (added below top, no animation)',
    },
    {
      'step': 3,
      'label': 'Process Removed Routes',
      'icon': Icons.delete_outline,
      'description': 'For each route in the old stack not in the new '
          'stack:\n'
          '• If it was at the top of the old stack → markForPop()\n'
          '• Otherwise → markForRemove() (disappeared from middle)\n'
          '• Associated pageless routes follow their parent.',
    },
    {
      'step': 4,
      'label': 'Process Unchanged Routes',
      'icon': Icons.check,
      'description': 'Routes present in both old and new stacks are '
          'kept as-is. They don\'t need any transition action. Their '
          'position in the final list preserves the new ordering.',
    },
    {
      'step': 5,
      'label': 'Return Ordered Results',
      'icon': Icons.list,
      'description': 'Returns the complete ordered list of '
          'RouteTransitionRecord entries. The Navigator uses this '
          'to animate the transitions and update the route stack '
          'accordingly.',
    },
  ];

  print('  Prepared ${algorithmSteps.length} algorithm steps');

  // ============================================================
  // SECTION 4: Visual State Transitions
  // ============================================================
  print('=== Section 4: Transitions ===');

  // Simulated route stack changes
  final stackExamples = <Map<String, dynamic>>[
    {
      'title': 'Simple Push',
      'before': ['Home', 'Products'],
      'after': ['Home', 'Products', 'Detail'],
      'actions': {'Detail': 'PUSH'},
      'description': 'New page "Detail" added at top → animate in.',
    },
    {
      'title': 'Simple Pop',
      'before': ['Home', 'Products', 'Detail'],
      'after': ['Home', 'Products'],
      'actions': {'Detail': 'POP'},
      'description': 'Top page "Detail" removed → animate out.',
    },
    {
      'title': 'Replace Top',
      'before': ['Home', 'Products'],
      'after': ['Home', 'Settings'],
      'actions': {'Products': 'POP', 'Settings': 'PUSH'},
      'description': 'Products removed, Settings added at top.',
    },
    {
      'title': 'Deep Link (Replace All)',
      'before': ['Home', 'Products', 'Detail'],
      'after': ['Home', 'Profile', 'Orders'],
      'actions': {
        'Products': 'REMOVE',
        'Detail': 'POP',
        'Profile': 'ADD',
        'Orders': 'PUSH'
      },
      'description': 'Complete stack replacement from deep link.',
    },
    {
      'title': 'Initial State',
      'before': <String>[],
      'after': ['Home'],
      'actions': {'Home': 'ADD'},
      'description': 'First navigation — no animation, just appear.',
    },
  ];

  print('  Prepared ${stackExamples.length} stack examples');

  // ============================================================
  // SECTION 5: Navigator 1.0 vs 2.0
  // ============================================================
  print('=== Section 5: 1.0 vs 2.0 ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'API Style',
      'nav1': 'Imperative (push/pop calls)',
      'nav2': 'Declarative (page list changes)',
    },
    {
      'aspect': 'Transition Control',
      'nav1': 'Automatic: push → forward, pop → reverse',
      'nav2': 'TransitionDelegate resolves each change',
    },
    {
      'aspect': 'Default Behavior',
      'nav1': 'Built-in to Navigator',
      'nav2': 'DefaultTransitionDelegate',
    },
    {
      'aspect': 'Custom Transitions',
      'nav1': 'Override PageRoute.buildTransitions()',
      'nav2': 'Subclass TransitionDelegate + PageRoute',
    },
    {
      'aspect': 'Multi-Page Changes',
      'nav1': 'Sequential push/pop with await',
      'nav2': 'Single page list update, batch resolution',
    },
    {
      'aspect': 'Deep Links',
      'nav1': 'Manual stack manipulation',
      'nav2': 'Set new page list, delegate resolves',
    },
    {
      'aspect': 'State Restoration',
      'nav1': 'Complex, manual',
      'nav2': 'Built into Router + Pages',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 6: Custom TransitionDelegate Examples
  // ============================================================
  print('=== Section 6: Custom Delegates ===');

  final customDelegates = <Map<String, dynamic>>[
    {
      'name': 'NoAnimationTransitionDelegate',
      'icon': Icons.flash_off,
      'color': Colors.indigo[700]!,
      'description': 'A delegate that suppresses all animations. Every '
          'new route gets markForAdd(), every removed route gets '
          'markForRemove(). Useful for instant navigation changes like '
          'tab switching or deep link resolution.',
      'code': 'class NoAnimationTransitionDelegate\n'
          '    extends TransitionDelegate<dynamic> {\n'
          '  @override\n'
          '  Iterable<RouteTransitionRecord> resolve({...}) {\n'
          '    for (final route in newRoutes) {\n'
          '      route.markForAdd();\n'
          '    }\n'
          '    for (final route in exitingRoutes) {\n'
          '      route.markForRemove();\n'
          '    }\n'
          '    return [...newRoutes, ...exitingRoutes];\n'
          '  }\n'
          '}',
    },
    {
      'name': 'FadeTransitionDelegate',
      'icon': Icons.blur_on,
      'color': Colors.lightBlue[700]!,
      'description': 'A delegate that always uses push for entering routes '
          'and pop for exiting routes, even for mid-stack changes. Combined '
          'with a FadePage that uses fade transitions, this creates a '
          'consistent cross-fade effect for all navigation changes.',
      'code': 'class FadeTransitionDelegate\n'
          '    extends TransitionDelegate<dynamic> {\n'
          '  @override\n'
          '  Iterable<RouteTransitionRecord> resolve({...}) {\n'
          '    for (final route in newRoutes) {\n'
          '      route.markForPush(); // Always animate in\n'
          '    }\n'
          '    for (final route in exitingRoutes) {\n'
          '      route.markForPop();  // Always animate out\n'
          '    }\n'
          '    return [...newRoutes, ...exitingRoutes];\n'
          '  }\n'
          '}',
    },
    {
      'name': 'ConditionalTransitionDelegate',
      'icon': Icons.rule,
      'color': Colors.indigo[600]!,
      'description': 'A delegate that chooses transition style based on '
          'route metadata. Auth routes use no animation, content routes '
          'use push/pop, modals use add. Demonstrates per-route logic.',
      'code': 'class ConditionalTransitionDelegate\n'
          '    extends TransitionDelegate<dynamic> {\n'
          '  @override\n'
          '  Iterable<RouteTransitionRecord> resolve({...}) {\n'
          '    for (final route in newRoutes) {\n'
          '      if (route.route.settings.name == \'/login\') {\n'
          '        route.markForAdd(); // Auth: instant\n'
          '      } else {\n'
          '        route.markForPush(); // Content: animate\n'
          '      }\n'
          '    }\n'
          '    // ... handle exiting routes\n'
          '  }\n'
          '}',
    },
  ];

  print('  Prepared ${customDelegates.length} custom delegates');

  // ============================================================
  // SECTION 7: Navigator Configuration
  // ============================================================
  print('=== Section 7: Configuration ===');

  final configPatterns = <Map<String, dynamic>>[
    {
      'title': 'Setting TransitionDelegate on Navigator',
      'color': Colors.indigo[700]!,
      'code': 'Navigator(\n'
          '  // Default behavior (can be omitted):\n'
          '  transitionDelegate: DefaultTransitionDelegate<dynamic>(),\n'
          '  pages: [\n'
          '    MaterialPage(child: HomeScreen()),\n'
          '    if (showProfile)\n'
          '      MaterialPage(child: ProfileScreen()),\n'
          '    if (showSettings)\n'
          '      MaterialPage(child: SettingsScreen()),\n'
          '  ],\n'
          '  onPopPage: (route, result) {\n'
          '    if (!route.didPop(result)) return false;\n'
          '    // handle state change\n'
          '    return true;\n'
          '  },\n'
          ')',
    },
    {
      'title': 'With Router and RouterDelegate',
      'color': Colors.lightBlue[700]!,
      'code': 'class MyRouterDelegate extends RouterDelegate<AppRoute>\n'
          '    with PopNavigatorRouterDelegateMixin {\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    return Navigator(\n'
          '      key: navigatorKey,\n'
          '      transitionDelegate:\n'
          '        DefaultTransitionDelegate(),\n'
          '      pages: _buildPages(),\n'
          '      onPopPage: _onPopPage,\n'
          '    );\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Custom Delegate for Tab Navigation',
      'color': Colors.indigo[600]!,
      'code': '// Tabs should not animate between each other\n'
          'Navigator(\n'
          '  transitionDelegate:\n'
          '    NoAnimationTransitionDelegate(),\n'
          '  pages: [\n'
          '    // Only one tab page at a time\n'
          '    _buildCurrentTabPage(selectedTab),\n'
          '  ],\n'
          '  onPopPage: (route, result) => false,\n'
          ')',
    },
  ];

  print('  Prepared ${configPatterns.length} config patterns');

  // ============================================================
  // SECTION 8: Page Types
  // ============================================================
  print('=== Section 8: Page Types ===');

  final pageTypes = <Map<String, dynamic>>[
    {
      'name': 'MaterialPage',
      'icon': Icons.android,
      'color': Colors.indigo[700]!,
      'transition': 'Slide from right (Android), zoom (Material 3)',
      'description': 'The standard Material Design page. Creates a '
          'MaterialPageRoute under the hood. The transition delegate '
          'decides push vs add, but the animation style comes from '
          'the page type.',
    },
    {
      'name': 'CupertinoPage',
      'icon': Icons.phone_iphone,
      'color': Colors.lightBlue[700]!,
      'transition': 'Slide from right with parallax',
      'description': 'iOS-style page transition. Creates a '
          'CupertinoPageRoute. The back-swipe gesture is also enabled. '
          'The transition delegate still controls push vs add, but the '
          'animation is iOS-native.',
    },
    {
      'name': 'CustomTransitionPage',
      'icon': Icons.tune,
      'color': Colors.indigo[600]!,
      'transition': 'Your custom animation',
      'description': 'A Page that takes a transitionsBuilder function. '
          'You define the exact animation. Combined with a custom '
          'TransitionDelegate, this gives full control over both '
          'when and how routes animate.',
    },
    {
      'name': 'NoTransitionPage',
      'icon': Icons.flash_off,
      'color': Colors.lightBlue[600]!,
      'transition': 'None (instant)',
      'description': 'A page that produces a route with zero-duration '
          'transition. Even if the delegate calls markForPush(), the '
          'animation is instant. Useful when you want the delegate '
          'logic but not the animation.',
    },
  ];

  print('  Prepared ${pageTypes.length} page types');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Don\'t Override Without Reason',
      'body': 'DefaultTransitionDelegate works correctly for most apps. '
          'Only create a custom TransitionDelegate if you need specific '
          'behavior like no-animation tab switching, cross-fade between '
          'all pages, or conditional transitions per route.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Page Keys Are Essential',
      'body': 'The delegate relies on Page keys to identify which pages '
          'are new vs existing. Always provide unique keys to your Pages. '
          'Without keys, the framework may misidentify page reorders as '
          'remove+add, leading to wrong transitions.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Pageless Routes Follow Parents',
      'body': 'Dialogs, bottom sheets, and other pageless routes are '
          'associated with their parent page route. When the parent is '
          'popped/removed, its pageless children animate with it. The '
          'delegate doesn\'t need to handle pageless routes directly.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'All Records Must Be Resolved',
      'body': 'Your custom resolve() must call markForPush, markForPop, '
          'markForAdd, or markForRemove on every RouteTransitionRecord. '
          'Leaving a record unresolved causes an assertion error in '
          'debug mode and undefined behavior in release.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Push vs Add for New Routes',
      'body': 'Use markForPush for new top routes that the user navigated '
          'to (they expect animation). Use markForAdd for routes that appear '
          'as side effects (deep link resolution, state restoration, initial '
          'route). Users don\'t expect animation for structural changes.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Debugging: RouteAware',
      'body': 'Use RouteAware and RouteObserver to debug which transitions '
          'are happening. Log didPush, didPop, didPushNext, didPopNext to '
          'verify your delegate is producing the expected actions.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('DefaultTransitionDelegate'),
      backgroundColor: Colors.indigo[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo[700]!, Colors.lightBlue[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.swap_horiz, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DefaultTransitionDelegate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The default TransitionDelegate for Navigator 2.0 '
                  'that resolves how routes animate when the declared '
                  'page list changes. Decides push, pop, add, or '
                  'remove for each route transition.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _dtHead('1', 'What is DefaultTransitionDelegate?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: TransitionDelegate API ──
          _dtHead('2', 'TransitionDelegate API'),
          SizedBox(height: 12),
          ...baseMethods.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: m['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(m['icon'] as IconData,
                            color: m['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(m['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 4),
                      _dtBadge(m['signature'] as String, m['color'] as Color),
                      SizedBox(height: 6),
                      Text(m['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Algorithm ──
          _dtHead('3', 'Resolution Algorithm'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(
              children: algorithmSteps.map((as_) => Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigo[700]!,
                                Colors.lightBlue[600]!
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text('${as_['step']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(as_['icon'] as IconData,
                                    color: Colors.indigo[600], size: 16),
                                SizedBox(width: 6),
                                Text(as_['label'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ]),
                              SizedBox(height: 4),
                              Text(as_['description'] as String,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[700],
                                      height: 1.4)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 4: Stack Transitions ──
          _dtHead('4', 'Visual Stack Transitions'),
          SizedBox(height: 12),
          ...stackExamples.map((se) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(se['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.indigo[700])),
                      SizedBox(height: 6),
                      Text(se['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic)),
                      SizedBox(height: 8),
                      Row(children: [
                        // Before stack
                        Expanded(
                          child: Column(children: [
                            Text('Before',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500])),
                            SizedBox(height: 4),
                            ...(se['before'] as List<String>)
                                .reversed
                                .map((r) => Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.indigo[100],
                                        borderRadius:
                                            BorderRadius.circular(4),
                                      ),
                                      child: Text(r,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.indigo[800])),
                                    )),
                            if ((se['before'] as List).isEmpty)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text('(empty)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.grey[500])),
                              ),
                          ]),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward,
                            color: Colors.indigo[400], size: 20),
                        SizedBox(width: 8),
                        // After stack
                        Expanded(
                          child: Column(children: [
                            Text('After',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500])),
                            SizedBox(height: 4),
                            ...(se['after'] as List<String>)
                                .reversed
                                .map((r) {
                              final actions =
                                  se['actions'] as Map<String, String>;
                              final action = actions[r];
                              Color bgColor;
                              if (action == 'PUSH') {
                                bgColor = Colors.green[100]!;
                              } else if (action == 'ADD') {
                                bgColor = Colors.lightBlue[100]!;
                              } else {
                                bgColor = Colors.indigo[100]!;
                              }
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 2),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(r,
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo[800])),
                                    if (action != null) ...[
                                      SizedBox(width: 4),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: Colors.indigo[700],
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(action,
                                            style: TextStyle(
                                                fontSize: 7,
                                                color: Colors.white,
                                                fontWeight:
                                                    FontWeight.bold)),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }),
                          ]),
                        ),
                      ]),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: 1.0 vs 2.0 ──
          _dtHead('5', 'Navigator 1.0 vs 2.0'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.indigo[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 75,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Navigator 1.0',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Navigator 2.0',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 75,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['nav1'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['nav2'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.indigo[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 6: Custom Delegates ──
          _dtHead('6', 'Custom TransitionDelegate Examples'),
          SizedBox(height: 12),
          ...customDelegates.map((cd) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cd['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(cd['icon'] as IconData,
                            color: cd['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cd['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(cd['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cd['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.lightBlue[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Configuration ──
          _dtHead('7', 'Navigator Configuration'),
          SizedBox(height: 12),
          ...configPatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.indigo[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Page Types ──
          _dtHead('8', 'Page Types & Transitions'),
          SizedBox(height: 12),
          ...pageTypes.map((pt) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: pt['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(pt['icon'] as IconData,
                            color: pt['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(pt['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 4),
                      _dtBadge(
                          pt['transition'] as String, pt['color'] as Color),
                      SizedBox(height: 6),
                      Text(pt['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _dtHead('9', 'Tips & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),
          Center(
            child: Text(
              'End of DefaultTransitionDelegate Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _dtHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.indigo[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Badge
// ──────────────────────────────────────────────────────────
Widget _dtBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
