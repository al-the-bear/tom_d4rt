// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unnecessary_underscores
// D4rt deep demo: RouteObserver<R extends Route<dynamic>> from
// package:flutter/widgets.dart. This script does NOT mount a live Navigator;
// instead it constructs synthetic routes and *simulates* observer callbacks
// by calling didPush / didPop / didReplace / didRemove directly on a
// RouteObserver, then renders an instructive UI dossier of the events.
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ===========================================================================
// _LoggingRouteAware
//
// A reusable RouteAware that records every lifecycle callback into a shared
// log. Each entry captures the screen identity, the callback name, and an
// auto-incrementing sequence number so the rendered timeline preserves
// causal ordering even when many subscribers fire on the same notification.
// ===========================================================================
class _LoggingRouteAware with RouteAware {
  _LoggingRouteAware(this.screen, this.log);

  final String screen;
  final List<Map<String, dynamic>> log;
  int _localCalls = 0;

  int get localCalls => _localCalls;

  @override
  void didPush() {
    _localCalls += 1;
    log.add(<String, dynamic>{
      'screen': screen,
      'callback': 'didPush',
      'order': log.length,
    });
  }

  @override
  void didPopNext() {
    _localCalls += 1;
    log.add(<String, dynamic>{
      'screen': screen,
      'callback': 'didPopNext',
      'order': log.length,
    });
  }

  @override
  void didPushNext() {
    _localCalls += 1;
    log.add(<String, dynamic>{
      'screen': screen,
      'callback': 'didPushNext',
      'order': log.length,
    });
  }

  @override
  void didPop() {
    _localCalls += 1;
    log.add(<String, dynamic>{
      'screen': screen,
      'callback': 'didPop',
      'order': log.length,
    });
  }
}

// ===========================================================================
// _DemoRouteObserver
//
// Script-side stand-in for the native `RouteObserver`. The native bridge for
// `RouteObserver.subscribe(RouteAware aware, R route)` validates `aware`
// with `D4.getRequiredArg<RouteAware>`, which rejects a d4rt
// `InterpretedInstance` even when the script class declares `with
// RouteAware`. See interpreter_unfixable.md (entry "U9 — Script-defined
// RouteAware cannot be subscribed to a native RouteObserver").
//
// This class mirrors the *observable* contract of `RouteObserver` (subscribe,
// unsubscribe, didPush, didPop, didReplace) using only script-side types, so
// the demo's call-order timeline and per-subscriber counters are produced
// without crossing the d4rt→native boundary. The native `RouteObserver`
// instance further down is still constructed — purely to demonstrate that
// the type exists — but it is never given a script-defined `RouteAware`.
// ===========================================================================
class _DemoRouteObserver {
  final Map<Route<dynamic>, List<_LoggingRouteAware>> _subs =
      <Route<dynamic>, List<_LoggingRouteAware>>{};

  void subscribe(_LoggingRouteAware aware, Route<dynamic> route) {
    _subs.putIfAbsent(route, () => <_LoggingRouteAware>[]).add(aware);
  }

  void unsubscribe(_LoggingRouteAware aware) {
    for (final list in _subs.values) {
      list.remove(aware);
    }
  }

  void didPush(Route<dynamic> route, Route<dynamic>? previous) {
    for (final a in _subs[route] ?? const <_LoggingRouteAware>[]) {
      a.didPush();
    }
    if (previous != null) {
      for (final a in _subs[previous] ?? const <_LoggingRouteAware>[]) {
        a.didPushNext();
      }
    }
  }

  void didPop(Route<dynamic> route, Route<dynamic>? previous) {
    for (final a in _subs[route] ?? const <_LoggingRouteAware>[]) {
      a.didPop();
    }
    if (previous != null) {
      for (final a in _subs[previous] ?? const <_LoggingRouteAware>[]) {
        a.didPopNext();
      }
    }
  }

  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      for (final a in _subs[newRoute] ?? const <_LoggingRouteAware>[]) {
        a.didPush();
      }
    }
    if (oldRoute != null) {
      for (final a in _subs[oldRoute] ?? const <_LoggingRouteAware>[]) {
        a.didPop();
      }
    }
  }
}

// ===========================================================================
// _StackOp
//
// Synthetic representation of a navigator stack mutation. We use this to
// drive the conceptual stack model rendered in SECTION 3.
// ===========================================================================
class _StackOp {
  _StackOp(this.kind, this.route, [this.previous]);
  final String kind; // push | pop | replace | remove
  final String route;
  final String? previous;
}

dynamic build(BuildContext context) {
  print('RouteObserver deep demo executing');

  // =========================================================================
  // SECTION 1: DOSSIER DATA
  // =========================================================================
  final dossier = <Map<String, String>>[
    {
      'field': 'Type',
      'value': 'class RouteObserver<R extends Route<dynamic>>',
    },
    {
      'field': 'Library',
      'value': 'package:flutter/widgets.dart',
    },
    {
      'field': 'Extends',
      'value': 'NavigatorObserver',
    },
    {
      'field': 'Generic R',
      'value': 'The Route subtype to track (e.g. PageRoute, ModalRoute)',
    },
    {
      'field': 'Primary Job',
      'value': 'Notify RouteAware listeners about routes of type R',
    },
    {
      'field': 'Subscribe',
      'value': 'subscribe(RouteAware aware, R route)',
    },
    {
      'field': 'Unsubscribe',
      'value': 'unsubscribe(RouteAware aware)',
    },
    {
      'field': 'Wired Via',
      'value': 'MaterialApp.navigatorObservers / Navigator.observers',
    },
    {
      'field': 'Common Use',
      'value': 'Analytics, route-aware widgets, refresh-on-return',
    },
    {
      'field': 'Pairs With',
      'value': 'RouteAware mixin on State subclasses',
    },
  ];

  // =========================================================================
  // SECTION 2: ANATOMY ENTRIES
  // =========================================================================
  final anatomy = <Map<String, String>>[
    {
      'symbol': 'didPush(Route route, Route? previous)',
      'origin': 'NavigatorObserver',
      'role':
          'Navigator pushed `route` onto the stack; previous (if any) was '
          'on top before this push.',
    },
    {
      'symbol': 'didPop(Route route, Route? previous)',
      'origin': 'NavigatorObserver',
      'role':
          'Navigator popped `route`; `previous` is now on top.',
    },
    {
      'symbol': 'didReplace({Route? newRoute, Route? oldRoute})',
      'origin': 'NavigatorObserver',
      'role':
          'Navigator replaced `oldRoute` with `newRoute` at the same depth.',
    },
    {
      'symbol': 'didRemove(Route route, Route? previous)',
      'origin': 'NavigatorObserver',
      'role':
          'Navigator removed `route` without animating; rare but supported.',
    },
    {
      'symbol': 'subscribe(RouteAware aware, R route)',
      'origin': 'RouteObserver',
      'role':
          'Register `aware` to receive callbacks tied to `route` lifecycle. '
          'Multiple awares per route are supported.',
    },
    {
      'symbol': 'unsubscribe(RouteAware aware)',
      'origin': 'RouteObserver',
      'role':
          'Detach an aware from every route it was attached to.',
    },
    {
      'symbol': 'didPush()',
      'origin': 'RouteAware',
      'role':
          'My subscribed route just became visible because it was pushed.',
    },
    {
      'symbol': 'didPopNext()',
      'origin': 'RouteAware',
      'role':
          'My subscribed route is visible again because the next route popped.',
    },
    {
      'symbol': 'didPushNext()',
      'origin': 'RouteAware',
      'role':
          'A new route was pushed on top of mine — I am now obscured.',
    },
    {
      'symbol': 'didPop()',
      'origin': 'RouteAware',
      'role':
          'My subscribed route was popped — I am leaving the stack.',
    },
  ];

  // =========================================================================
  // SECTION 3: SYNTHETIC ROUTES + STACK MODEL
  // =========================================================================
  final homeRoute = MaterialPageRoute<void>(
    settings: RouteSettings(name: '/home'),
    builder: (_) => Scaffold(body: Text('Home')),
  );
  final detailRoute = MaterialPageRoute<void>(
    settings: RouteSettings(name: '/detail', arguments: <String, int>{'id': 7}),
    builder: (_) => Scaffold(body: Text('Detail')),
  );
  final settingsRoute = MaterialPageRoute<void>(
    settings: RouteSettings(name: '/settings'),
    builder: (_) => Scaffold(body: Text('Settings')),
  );
  final modalRoute = PageRouteBuilder<void>(
    settings: RouteSettings(name: '/modal'),
    barrierDismissible: true,
    opaque: false,
    pageBuilder: (_, __, ___) => Scaffold(body: Text('Modal')),
    transitionDuration: Duration(milliseconds: 220),
    reverseTransitionDuration: Duration(milliseconds: 160),
  );

  final routeCards = <Map<String, dynamic>>[
    {
      'name': '/home',
      'kind': 'MaterialPageRoute',
      'opaque': homeRoute.opaque,
      'fullscreenDialog': homeRoute.fullscreenDialog,
      'maintainState': homeRoute.maintainState,
    },
    {
      'name': '/detail',
      'kind': 'MaterialPageRoute',
      'opaque': detailRoute.opaque,
      'fullscreenDialog': detailRoute.fullscreenDialog,
      'maintainState': detailRoute.maintainState,
    },
    {
      'name': '/settings',
      'kind': 'MaterialPageRoute',
      'opaque': settingsRoute.opaque,
      'fullscreenDialog': settingsRoute.fullscreenDialog,
      'maintainState': settingsRoute.maintainState,
    },
    {
      'name': '/modal',
      'kind': 'PageRouteBuilder',
      'opaque': modalRoute.opaque,
      'fullscreenDialog': modalRoute.fullscreenDialog,
      'maintainState': modalRoute.maintainState,
    },
  ];

  // Build a conceptual stack by walking a script of operations.
  final stackScript = <_StackOp>[
    _StackOp('push', '/home'),
    _StackOp('push', '/detail', '/home'),
    _StackOp('push', '/settings', '/detail'),
    _StackOp('pop', '/settings', '/detail'),
    _StackOp('replace', '/modal', '/detail'),
    _StackOp('pop', '/modal', '/home'),
  ];

  final stackSnapshots = <List<String>>[];
  final current = <String>[];
  for (final op in stackScript) {
    if (op.kind == 'push') {
      current.add(op.route);
    } else if (op.kind == 'pop') {
      if (current.isNotEmpty) {
        current.removeLast();
      }
    } else if (op.kind == 'replace') {
      if (current.isNotEmpty) {
        current.removeLast();
        current.add(op.route);
      }
    } else if (op.kind == 'remove') {
      current.remove(op.route);
    }
    stackSnapshots.add(List<String>.from(current));
  }

  // =========================================================================
  // SECTION 4: SIMULATE OBSERVER CALLBACKS
  //
  // We build a RouteObserver<PageRoute>, subscribe several RouteAwares, and
  // *manually* invoke the lifecycle callbacks. This mirrors what a live
  // Navigator would do, but stays fully synchronous and observable.
  // =========================================================================
  // The native RouteObserver is still constructed to demonstrate the type
  // exists in Flutter — but a d4rt InterpretedInstance cannot be subscribed
  // to it (see interpreter_unfixable.md U9). We use _DemoRouteObserver
  // (defined at the top of this file) to perform the actual lifecycle
  // dispatch, mirroring the native protocol exactly.
  // ignore: unused_local_variable
  final routeObserver = RouteObserver<PageRoute<dynamic>>();
  final demoObserver = _DemoRouteObserver();
  final callLog = <Map<String, dynamic>>[];

  final homeAware = _LoggingRouteAware('home', callLog);
  final detailAware = _LoggingRouteAware('detail', callLog);
  final detailAware2 = _LoggingRouteAware('detail-analytics', callLog);
  final settingsAware = _LoggingRouteAware('settings', callLog);

  demoObserver.subscribe(homeAware, homeRoute);
  demoObserver.subscribe(detailAware, detailRoute);
  demoObserver.subscribe(detailAware2, detailRoute);
  demoObserver.subscribe(settingsAware, settingsRoute);

  // Push /home (no previous).
  demoObserver.didPush(homeRoute, null);
  // Push /detail on top of /home.
  demoObserver.didPush(detailRoute, homeRoute);
  // Push /settings on top of /detail.
  demoObserver.didPush(settingsRoute, detailRoute);
  // Pop /settings back to /detail.
  demoObserver.didPop(settingsRoute, detailRoute);
  // Replace /detail with /modal at the same depth.
  demoObserver.didReplace(newRoute: modalRoute, oldRoute: detailRoute);
  // Pop /modal back to /home.
  demoObserver.didPop(modalRoute, homeRoute);

  // Unsubscribe one of the duplicate detail awares to demonstrate detach.
  demoObserver.unsubscribe(detailAware2);

  final eventTimeline = <Map<String, dynamic>>[
    {'kind': 'push', 'route': '/home', 'previous': null},
    {'kind': 'push', 'route': '/detail', 'previous': '/home'},
    {'kind': 'push', 'route': '/settings', 'previous': '/detail'},
    {'kind': 'pop', 'route': '/settings', 'previous': '/detail'},
    {'kind': 'replace', 'route': '/modal', 'previous': '/detail'},
    {'kind': 'pop', 'route': '/modal', 'previous': '/home'},
  ];

  // =========================================================================
  // SECTION 5: PER-SUBSCRIBER COUNTS
  // =========================================================================
  final subscriberStats = <Map<String, dynamic>>[
    {
      'name': 'homeAware',
      'screen': 'home',
      'calls': homeAware.localCalls,
      'route': '/home',
    },
    {
      'name': 'detailAware',
      'screen': 'detail',
      'calls': detailAware.localCalls,
      'route': '/detail',
    },
    {
      'name': 'detailAware2',
      'screen': 'detail-analytics',
      'calls': detailAware2.localCalls,
      'route': '/detail (unsubscribed at end)',
    },
    {
      'name': 'settingsAware',
      'screen': 'settings',
      'calls': settingsAware.localCalls,
      'route': '/settings',
    },
  ];

  // =========================================================================
  // SECTION 6: GENERIC TYPE SHOWCASE
  // =========================================================================
  final genericObservers = <Map<String, dynamic>>[
    {
      'type': 'RouteObserver<PageRoute<dynamic>>',
      'tracks': 'Only PageRoute subclasses (e.g. MaterialPageRoute)',
      'ignores': 'DialogRoute, PopupRoute that are not PageRoute',
    },
    {
      'type': 'RouteObserver<ModalRoute<dynamic>>',
      'tracks':
          'Any ModalRoute — covers PageRoute, DialogRoute, PopupRoute, '
          'BottomSheetRoute, RawDialogRoute',
      'ignores': 'Non-modal routes (rare in apps)',
    },
    {
      'type': 'RouteObserver<MaterialPageRoute<dynamic>>',
      'tracks': 'Strictly MaterialPageRoute',
      'ignores': 'CupertinoPageRoute, PageRouteBuilder, custom subclasses',
    },
    {
      'type': 'RouteObserver<Route<dynamic>>',
      'tracks': 'Everything (default fallback)',
      'ignores': 'Nothing — broadest filter',
    },
  ];

  // =========================================================================
  // SECTION 7: RECIPE CARDS
  // =========================================================================
  final recipes = <Map<String, String>>[
    {
      'title': 'Refresh on return from detail',
      'when': 'List screen should reload after user pops back from detail',
      'how':
          'Mixin RouteAware on the list-state; in didChangeDependencies '
          'call routeObserver.subscribe(this, ModalRoute.of(context)!); '
          'implement didPopNext() to reload data.',
    },
    {
      'title': 'Analytics screen-view tracking',
      'when': 'Send analytics event whenever a screen becomes top-of-stack',
      'how':
          'Use a single global RouteObserver<PageRoute>; in your screen '
          'didPush() / didPopNext() send "screen_view" with route name.',
    },
    {
      'title': 'Pause heavy work while obscured',
      'when': 'A video / map screen should pause when another route covers it',
      'how':
          'Implement didPushNext() to pause and didPopNext() to resume; the '
          'controller is held in the State.',
    },
    {
      'title': 'Cleanup when route is permanently popped',
      'when': 'Release resources only when the screen actually leaves stack',
      'how':
          'Implement didPop() (called once during route removal). Do NOT use '
          'dispose() alone for "back navigation" semantics.',
    },
    {
      'title': 'Multiple awares for one screen',
      'when':
          'Separate concerns: analytics tracker and refresh controller for '
          'the same route',
      'how':
          'Call routeObserver.subscribe(aware, route) twice with different '
          'aware instances. Both receive every callback.',
    },
    {
      'title': 'Scoped observer per nested Navigator',
      'when': 'Tabbed app with per-tab Navigator',
      'how':
          'Each Navigator gets its own RouteObserver in its observers list. '
          'Don\'t reuse the root observer for nested navigators.',
    },
    {
      'title': 'Filter to a specific route subtype',
      'when':
          'You only care about full pages, not dialogs/snackbars/popups',
      'how':
          'Use RouteObserver<PageRoute<dynamic>>; dialogs and bottom sheets '
          'are skipped automatically.',
    },
    {
      'title': 'Subscribe in didChangeDependencies, not initState',
      'when': 'Need ModalRoute.of(context) to find the current route',
      'how':
          'Call subscribe in didChangeDependencies because ModalRoute.of '
          'needs the inherited widget tree.',
    },
  ];

  // =========================================================================
  // SECTION 8: COMPARISON TABLE
  // =========================================================================
  final comparison = <Map<String, String>>[
    {
      'feature': 'Notifies widgets directly?',
      'routeObserver': 'Yes — via RouteAware mixin',
      'navigatorObserver': 'No — only the observer instance is called',
      'onGenerateRoute': 'No — only builds routes',
    },
    {
      'feature': 'Tied to a specific route?',
      'routeObserver': 'Yes — per (aware, route) pair',
      'navigatorObserver': 'No — global to a Navigator',
      'onGenerateRoute': 'No',
    },
    {
      'feature': 'Knows about didPopNext / didPushNext?',
      'routeObserver': 'Yes — derived events for subscribers',
      'navigatorObserver': 'No — only didPush/didPop raw events',
      'onGenerateRoute': 'No',
    },
    {
      'feature': 'Filters by Route subtype?',
      'routeObserver': 'Yes — generic R',
      'navigatorObserver': 'No — receives all',
      'onGenerateRoute': 'N/A',
    },
    {
      'feature': 'Typical use case',
      'routeObserver': 'Per-screen lifecycle awareness',
      'navigatorObserver': 'Cross-cutting logging / debugging',
      'onGenerateRoute': 'Route construction from name',
    },
    {
      'feature': 'Where wired',
      'routeObserver': 'MaterialApp.navigatorObservers',
      'navigatorObserver': 'MaterialApp.navigatorObservers',
      'onGenerateRoute': 'MaterialApp.onGenerateRoute',
    },
  ];

  // =========================================================================
  // SECTION 9: GLOSSARY
  // =========================================================================
  final glossary = <Map<String, String>>[
    {
      'term': 'Route',
      'def':
          'An abstraction representing a screen or overlay in a Navigator.',
    },
    {
      'term': 'ModalRoute',
      'def':
          'A Route that blocks input to routes below it (most screens are '
          'ModalRoutes).',
    },
    {
      'term': 'PageRoute',
      'def':
          'A ModalRoute that represents a full-screen page with platform '
          'transition.',
    },
    {
      'term': 'MaterialPageRoute',
      'def':
          'PageRoute with Material Design transition; the default route '
          'type in MaterialApp.',
    },
    {
      'term': 'PageRouteBuilder',
      'def':
          'PageRoute that lets you supply custom pageBuilder and '
          'transitionsBuilder closures.',
    },
    {
      'term': 'NavigatorObserver',
      'def':
          'Hook that receives didPush / didPop / didReplace / didRemove for '
          'a Navigator.',
    },
    {
      'term': 'RouteObserver',
      'def':
          'NavigatorObserver subclass that fans out events to RouteAware '
          'subscribers per route.',
    },
    {
      'term': 'RouteAware',
      'def':
          'Mixin offering didPush / didPopNext / didPushNext / didPop '
          'callbacks for the route it is subscribed to.',
    },
    {
      'term': 'subscribe / unsubscribe',
      'def':
          'RouteObserver methods to attach / detach a RouteAware to a route.',
    },
    {
      'term': 'didPopNext',
      'def':
          'Called on my subscriber when the route above mine is popped and '
          'my screen becomes top-of-stack again.',
    },
    {
      'term': 'didPushNext',
      'def':
          'Called when something is pushed *on top of* my route — I am now '
          'covered.',
    },
    {
      'term': 'Stack snapshot',
      'def':
          'Conceptual list of currently-mounted routes from bottom to top.',
    },
  ];

  // =========================================================================
  // SECTION SUMMARY DATA
  // =========================================================================
  final summary = <Map<String, String>>[
    {'label': 'Dossier rows', 'count': '${dossier.length}'},
    {'label': 'Anatomy entries', 'count': '${anatomy.length}'},
    {'label': 'Synthetic routes', 'count': '${routeCards.length}'},
    {'label': 'Stack ops', 'count': '${stackScript.length}'},
    {'label': 'Logged callbacks', 'count': '${callLog.length}'},
    {'label': 'Subscribers', 'count': '${subscriberStats.length}'},
    {'label': 'Generic showcases', 'count': '${genericObservers.length}'},
    {'label': 'Recipes', 'count': '${recipes.length}'},
    {'label': 'Comparison rows', 'count': '${comparison.length}'},
    {'label': 'Glossary entries', 'count': '${glossary.length}'},
  ];

  print('Observer simulated ${callLog.length} RouteAware callbacks');
  print('Stack snapshots: ${stackSnapshots.length}');
  print('Final stack: ${stackSnapshots.isNotEmpty ? stackSnapshots.last : <String>[]}');

  // =========================================================================
  // BUILD WIDGET TREE
  // =========================================================================
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ============================================================
          // HEADER BANNER
          // ============================================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RouteObserver<R>',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'Deep Demo · package:flutter/widgets.dart',
                  style: TextStyle(fontSize: 15.0, color: Color(0xFFC5CAE9)),
                ),
                SizedBox(height: 14.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 6.0,
                  children: [
                    _pill('NavigatorObserver subclass', Color(0xFF5C6BC0)),
                    _pill('RouteAware fan-out', Color(0xFF7E57C2)),
                    _pill('Generic R extends Route<dynamic>', Color(0xFF26A69A)),
                    _pill('subscribe / unsubscribe', Color(0xFFEF6C00)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 1: DOSSIER
          // ============================================================
          _sectionHeader('1. Dossier', Color(0xFF1A237E)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF9FA8DA), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final row in dossier)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 110.0,
                          child: Text(
                            row['field']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color(0xFF283593),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            row['value']!,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 2: ANATOMY
          // ============================================================
          _sectionHeader('2. Anatomy', Color(0xFF00695C)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF4DB6AC), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final entry in anatomy)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFFB2DFDB),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  entry['symbol']!,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004D40),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: entry['origin'] == 'RouteAware'
                                      ? Color(0xFF7B1FA2)
                                      : entry['origin'] == 'RouteObserver'
                                          ? Color(0xFF1565C0)
                                          : Color(0xFF2E7D32),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  entry['origin']!,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            entry['role']!,
                            style: TextStyle(
                              fontSize: 12.0,
                              height: 1.4,
                              color: Color(0xFF37474F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 3: SYNTHETIC ROUTES + STACK MODEL
          // ============================================================
          _sectionHeader('3. Synthetic Routes & Stack Snapshots',
              Color(0xFF4E342E)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFEFEBE9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFA1887F), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Route cards',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Color(0xFF3E2723),
                  ),
                ),
                SizedBox(height: 8.0),
                for (final card in routeCards)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFFBCAAA4),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF5D4037),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              card['name'] as String,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              card['kind'] as String,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          _flag('opaque', card['opaque'] as bool,
                              Color(0xFF6D4C41)),
                          _flag('maintainState',
                              card['maintainState'] as bool,
                              Color(0xFF8D6E63)),
                          _flag('fullscreenDialog',
                              card['fullscreenDialog'] as bool,
                              Color(0xFFA1887F)),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 14.0),
                Text(
                  'Conceptual stack after each operation:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Color(0xFF3E2723),
                  ),
                ),
                SizedBox(height: 8.0),
                for (int i = 0; i < stackSnapshots.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80.0,
                          child: Text(
                            'step ${i + 1}: ${stackScript[i].kind}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4E342E),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: [
                              for (final r in stackSnapshots[i])
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: r == stackSnapshots[i].last
                                        ? Color(0xFF5D4037)
                                        : Color(0xFFD7CCC8),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    r,
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: r == stackSnapshots[i].last
                                          ? Color(0xFFFFFFFF)
                                          : Color(0xFF3E2723),
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                              if (stackSnapshots[i].isEmpty)
                                Text(
                                  '(empty)',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xFF6D4C41),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 4: ROUTEAWARE CALL LOG
          // ============================================================
          _sectionHeader('4. RouteAware Call Log', Color(0xFF4A148C)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFBA68C8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Every callback recorded by every subscribed _LoggingRouteAware:',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF6A1B9A)),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    SizedBox(
                      width: 36.0,
                      child: Text(
                        '#',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Screen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Callback',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Color(0xFFCE93D8)),
                if (callLog.isEmpty)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '(no callbacks recorded)',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                  ),
                for (final entry in callLog)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 36.0,
                          child: Text(
                            '${entry['order']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                              color: Color(0xFF6A1B9A),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            entry['screen'] as String,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: _callbackColor(
                                entry['callback'] as String,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              entry['callback'] as String,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFEDE7F6),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'Total callbacks: ${callLog.length}',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4527A0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 5: EVENT TIMELINE (horizontal pills)
          // ============================================================
          _sectionHeader('5. Push/Pop Event Timeline', Color(0xFFBF360C)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFAB91), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Raw NavigatorObserver-level events fed to the RouteObserver:',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFFBF360C)),
                ),
                SizedBox(height: 12.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < eventTimeline.length; i++) ...[
                        _timelinePill(
                          (i + 1).toString(),
                          eventTimeline[i]['kind'] as String,
                          eventTimeline[i]['route'] as String,
                          eventTimeline[i]['previous'] as String?,
                        ),
                        if (i != eventTimeline.length - 1)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 14.0,
                              color: Color(0xFFBF360C),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 6: MULTIPLE SUBSCRIBERS
          // ============================================================
          _sectionHeader('6. Multiple Subscribers per Route',
              Color(0xFF0D47A1)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF64B5F6), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'detailAware and detailAware2 both subscribed to /detail; '
                  'detailAware2 was unsubscribed after the replace event.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF1565C0)),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Subscriber',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Route',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.0,
                      child: Text(
                        'Calls',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Divider(color: Color(0xFF90CAF9)),
                for (final s in subscriberStats)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            s['name'] as String,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            s['route'] as String,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 3.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF1976D2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${s['calls']}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 7: GENERIC PARAM SHOWCASE
          // ============================================================
          _sectionHeader('7. Generic Parameter Showcase',
              Color(0xFF1B5E20)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF81C784), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final g in genericObservers)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFFC8E6C9),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            g['type'] as String,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF388E3C),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  'tracks',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.0),
                              Expanded(
                                child: Text(
                                  g['tracks'] as String,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFC62828),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  'ignores',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.0),
                              Expanded(
                                child: Text(
                                  g['ignores'] as String,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 8: RECIPE CARDS
          // ============================================================
          _sectionHeader('8. Recipes', Color(0xFFE65100)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFCA28), width: 1.0),
            ),
            child: Column(
              children: [
                for (int i = 0; i < recipes.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFFFFE082),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 26.0,
                                height: 26.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE65100),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  recipes[i]['title']!,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFBF360C),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 48.0,
                                child: Text(
                                  'When',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE65100),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  recipes[i]['when']!,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 48.0,
                                child: Text(
                                  'How',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE65100),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  recipes[i]['how']!,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 9: COMPARISON TABLE
          // ============================================================
          _sectionHeader('9. RouteObserver vs NavigatorObserver vs '
              'onGenerateRoute', Color(0xFF263238)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Color(0xFFECEFF1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF455A64),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Feature',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'RouteObserver',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'NavigatorObserver',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'onGenerateRoute',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                for (int i = 0; i < comparison.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: i.isEven
                          ? Color(0xFFFFFFFF)
                          : Color(0xFFCFD8DC),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            comparison[i]['feature']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0,
                              color: Color(0xFF263238),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            comparison[i]['routeObserver']!,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            comparison[i]['navigatorObserver']!,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            comparison[i]['onGenerateRoute']!,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 10: GLOSSARY
          // ============================================================
          _sectionHeader('10. Glossary', Color(0xFF311B92)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final g in glossary)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 140.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF512DA8),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              g['term']!,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            g['def']!,
                            style: TextStyle(fontSize: 12.0, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.0),

          // ============================================================
          // SECTION 11: FINAL COMPOSED TREE / SUMMARY
          // ============================================================
          _sectionHeader('11. Final Summary', Color(0xFF004D40)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF004D40), Color(0xFF00695C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Demo coverage',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                for (final row in summary)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            row['label']!,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 3.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0x33FFFFFF),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            row['count']!,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 14.0),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'RouteObserver demo: ',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        'all sections rendered',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: Text(
              'Deep Demo · RouteObserver<R> · NavigatorObserver · RouteAware',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF607D8B)),
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ===========================================================================
// HELPERS
// ===========================================================================
Widget _sectionHeader(String title, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _pill(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Text(
      label,
      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
    ),
  );
}

Widget _flag(String label, bool value, Color color) {
  return Container(
    margin: EdgeInsets.only(left: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: value ? color : Color(0xFFE0E0E0),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      '$label:${value ? "T" : "F"}',
      style: TextStyle(
        color: value ? Color(0xFFFFFFFF) : Color(0xFF757575),
        fontSize: 9.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _timelinePill(
  String index,
  String kind,
  String route,
  String? previous,
) {
  Color color;
  if (kind == 'push') {
    color = Color(0xFF2E7D32);
  } else if (kind == 'pop') {
    color = Color(0xFFC62828);
  } else if (kind == 'replace') {
    color = Color(0xFF6A1B9A);
  } else {
    color = Color(0xFF455A64);
  }
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  index,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              kind.toUpperCase(),
              style: TextStyle(
                color: color,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          route,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'prev: ${previous ?? "—"}',
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF607D8B),
          ),
        ),
      ],
    ),
  );
}

Color _callbackColor(String name) {
  if (name == 'didPush') return Color(0xFF2E7D32);
  if (name == 'didPop') return Color(0xFFC62828);
  if (name == 'didPushNext') return Color(0xFF6A1B9A);
  if (name == 'didPopNext') return Color(0xFF1565C0);
  return Color(0xFF455A64);
}
