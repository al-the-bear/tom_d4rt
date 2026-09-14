// D4rt test script: Tests Navigator widget from package:flutter/widgets.dart
// Deep Demo: Navigator — the route stack visualizer.
//
// This file is intentionally long and richly visual. It is executed against
// the analyzer-free Flutter AST by the d4rt interpreter. Every section is
// gated behind a SECTION N marker and accompanied by narrative Text widgets
// so that the rendered output is self-documenting.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('Navigator deep demo executing');

  // ============================================================
  // SECTION 1: Hero header — what Navigator is.
  // ============================================================
  debugPrint('=== Section 1: Hero header ===');

  final Widget heroHeader = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.indigo.shade700,
          Colors.deepPurple.shade400,
          Colors.purple.shade300,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.35),
          blurRadius: 22.0,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 86.0,
          height: 86.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.55),
              width: 2.0,
            ),
          ),
          child: const Icon(
            Icons.layers_rounded,
            color: Colors.white,
            size: 48.0,
          ),
        ),
        const SizedBox(width: 22.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Navigator',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'A widget that owns a stack of routes',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
              const SizedBox(height: 12.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 6.0,
                children: <Widget>[
                  _pill('Imperative 1.0', Colors.white),
                  _pill('Declarative 2.0', Colors.amberAccent),
                  _pill('Routes & Pages', Colors.cyanAccent),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Stack model diagram.
  // ============================================================
  debugPrint('=== Section 2: Stack model diagram ===');

  final List<Widget> stackCards = <Widget>[];
  final List<Map<String, dynamic>> stackEntries = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': '/settings',
      'color': Colors.pink.shade300,
      'top': true,
    },
    <String, dynamic>{
      'name': '/details',
      'color': Colors.orange.shade300,
      'top': false,
    },
    <String, dynamic>{
      'name': '/home',
      'color': Colors.lightBlue.shade300,
      'top': false,
    },
    <String, dynamic>{
      'name': '/ (root)',
      'color': Colors.green.shade300,
      'top': false,
    },
  ];
  for (int i = 0; i < stackEntries.length; i++) {
    final Map<String, dynamic> entry = stackEntries[i];
    stackCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: entry['color'] as Color,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (entry['top'] as bool)
                ? Colors.black87
                : Colors.black.withValues(alpha: 0.25),
            width: (entry['top'] as bool) ? 2.4 : 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              (entry['top'] as bool)
                  ? Icons.arrow_forward_ios
                  : Icons.layers_outlined,
              size: 16.0,
              color: Colors.black87,
            ),
            const SizedBox(width: 10.0),
            Text(
              entry['name'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
              ),
            ),
            const Spacer(),
            if (entry['top'] as bool)
              const Text(
                'TOP',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
          ],
        ),
      ),
    );
  }

  final Widget stackModelDiagram = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.account_tree_outlined,
              color: Colors.indigo.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Section 2 — The route stack (LIFO)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Each push adds a route on top; each pop removes the topmost one.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.indigo.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12.0),
        ...stackCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Imperative push/pop mini-phone with embedded Navigator.
  // ============================================================
  debugPrint('=== Section 3: Imperative push/pop mini-phone ===');

  final Widget imperativePhone = _miniPhone(
    title: 'Imperative push/pop',
    accent: Colors.deepPurple,
    body: Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext ctx) {
            return _coloredPage(
              label: settings.name ?? 'route',
              color: _colorForRoute(settings.name ?? '/'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    debugPrint('imperative: push /child');
                    Navigator.of(ctx).push<void>(
                      MaterialPageRoute<void>(
                        settings: const RouteSettings(name: '/child'),
                        builder: (BuildContext c2) {
                          return _coloredPage(
                            label: '/child',
                            color: Colors.amber.shade200,
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  debugPrint('imperative: pop');
                                  Navigator.of(c2).pop();
                                },
                                child: const Text('Pop'),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Push'),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('imperative: push two pages');
                  },
                  child: const Text('Push x2'),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('imperative: popUntil first');
                    Navigator.of(ctx).popUntil((Route<dynamic> r) => r.isFirst);
                  },
                  child: const Text('PopUntil first'),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    debugPrint('imperative: maybePop');
                    final bool didPop =
                        await Navigator.of(ctx).maybePop<void>();
                    debugPrint('maybePop returned $didPop');
                  },
                  child: const Text('maybePop'),
                ),
              ],
            );
          },
        );
      },
    ),
  );

  final Widget section3 = _sectionFrame(
    number: 3,
    title: 'Imperative push / pop',
    description:
        'A mini phone with its own embedded Navigator. Each push adds '
        'a colored page; popUntil collapses back to the root.',
    accent: Colors.deepPurple,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        imperativePhone,
        const SizedBox(width: 16.0),
        Expanded(child: _stackPreview(<String>['/child', '/'])),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Named routes mini-phone.
  // ============================================================
  debugPrint('=== Section 4: Named routes ===');

  final Map<String, WidgetBuilder> namedRoutes = <String, WidgetBuilder>{
    '/home': (BuildContext c) => _coloredPage(
          label: '/home',
          color: Colors.lightBlue.shade200,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                debugPrint('named: push /details');
                Navigator.of(c).pushNamed('/details');
              },
              child: const Text('Go /details'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                debugPrint('named: push /settings');
                Navigator.of(c).pushNamed('/settings');
              },
              child: const Text('Go /settings'),
            ),
          ],
        ),
    '/details': (BuildContext c) => _coloredPage(
          label: '/details',
          color: Colors.orange.shade200,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                debugPrint('named: pop');
                Navigator.of(c).pop();
              },
              child: const Text('Pop'),
            ),
          ],
        ),
    '/settings': (BuildContext c) => _coloredPage(
          label: '/settings',
          color: Colors.pink.shade200,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                debugPrint('named: pushNamedAndRemoveUntil /home');
                Navigator.of(c).pushNamedAndRemoveUntil(
                  '/home',
                  (Route<dynamic> r) => false,
                );
              },
              child: const Text('Home (clear)'),
            ),
          ],
        ),
  };

  final Widget namedPhone = _miniPhone(
    title: 'Named routes',
    accent: Colors.lightBlue,
    body: Navigator(
      initialRoute: '/home',
      onGenerateRoute: (RouteSettings settings) {
        final WidgetBuilder? b = namedRoutes[settings.name];
        if (b == null) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext c) => _coloredPage(
              label: '404 ${settings.name ?? ""}',
              color: Colors.red.shade200,
              actions: const <Widget>[Text('unknown route')],
            ),
          );
        }
        return MaterialPageRoute<void>(settings: settings, builder: b);
      },
    ),
  );

  final Widget section4 = _sectionFrame(
    number: 4,
    title: 'Named routes — push by name',
    description:
        'Routes resolved by string key in a routes table. A chip shows '
        'the current named route entry.',
    accent: Colors.lightBlue,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        namedPhone,
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _routeChip('/home', Colors.lightBlue),
              const SizedBox(height: 8.0),
              _routeChip('/details', Colors.orange),
              const SizedBox(height: 8.0),
              _routeChip('/settings', Colors.pink),
              const SizedBox(height: 14.0),
              const Text(
                'Tip: pushNamedAndRemoveUntil clears the back stack.',
                style: TextStyle(fontSize: 12.0, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: pushReplacement vs push — side by side.
  // ============================================================
  debugPrint('=== Section 5: pushReplacement vs push ===');

  final Widget pushPhone = _miniPhone(
    title: 'push',
    accent: Colors.teal,
    body: Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext ctx) {
            return _coloredPage(
              label: 'A',
              color: Colors.teal.shade200,
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    debugPrint('push -> stack: [A, B]');
                    Navigator.of(ctx).push<void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext c) => _coloredPage(
                          label: 'B',
                          color: Colors.teal.shade400,
                          actions: const <Widget>[Text('Pop returns to A')],
                        ),
                      ),
                    );
                  },
                  child: const Text('push(B)'),
                ),
              ],
            );
          },
        );
      },
    ),
  );

  final Widget replacePhone = _miniPhone(
    title: 'pushReplacement',
    accent: Colors.deepOrange,
    body: Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext ctx) {
            return _coloredPage(
              label: 'A',
              color: Colors.deepOrange.shade200,
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    debugPrint('pushReplacement -> stack: [B]');
                    Navigator.of(ctx).pushReplacement<void, void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext c) => _coloredPage(
                          label: 'B',
                          color: Colors.deepOrange.shade400,
                          actions: const <Widget>[Text('A is gone')],
                        ),
                      ),
                    );
                  },
                  child: const Text('replace(B)'),
                ),
              ],
            );
          },
        );
      },
    ),
  );

  final Widget section5 = _sectionFrame(
    number: 5,
    title: 'pushReplacement vs push',
    description:
        'push grows the stack; pushReplacement swaps the topmost route — '
        'the previous page is disposed.',
    accent: Colors.teal,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        pushPhone,
        const SizedBox(width: 12.0),
        replacePhone,
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'push:        [A] -> [A, B]',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'replace:    [A] -> [B]',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Use pushReplacement for login flows or onboarding screens.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: pushAndRemoveUntil.
  // ============================================================
  debugPrint('=== Section 6: pushAndRemoveUntil ===');

  final Widget removeUntilPhone = _miniPhone(
    title: 'pushAndRemoveUntil',
    accent: Colors.green,
    body: Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext ctx) {
            return _coloredPage(
              label: 'root',
              color: Colors.green.shade200,
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    debugPrint('pushAndRemoveUntil((r) => r.isFirst)');
                    Navigator.of(ctx).pushAndRemoveUntil<void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext c) => _coloredPage(
                          label: 'newTop',
                          color: Colors.green.shade400,
                          actions: const <Widget>[Text('Stack: [root, this]')],
                        ),
                      ),
                      (Route<dynamic> r) => r.isFirst,
                    );
                  },
                  child: const Text('jump'),
                ),
              ],
            );
          },
        );
      },
    ),
  );

  final Widget section6 = _sectionFrame(
    number: 6,
    title: 'pushAndRemoveUntil',
    description:
        'Push a new route and pop everything until the predicate returns '
        'true. Common idiom: keep root, drop the rest.',
    accent: Colors.green,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        removeUntilPhone,
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Before:  [root, A, B, C]',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'After:   [root, newTop]',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: const Text(
                  'Predicate (route.isFirst) is checked from top down.',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Custom PageRouteBuilder transitions.
  // ============================================================
  debugPrint('=== Section 7: PageRouteBuilder transitions ===');

  Widget transitionCard({
    required String title,
    required IconData icon,
    required Color color,
    required String descriptor,
  }) {
    return Container(
      width: 200.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 20.0),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                descriptor,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Builder: PageRouteBuilder',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section7 = _sectionFrame(
    number: 7,
    title: 'Custom PageRouteBuilder',
    description:
        'Subclasses define transitionsBuilder to swap the default Material '
        'transition for slide / fade / scale animations.',
    accent: Colors.amber,
    body: Wrap(
      children: <Widget>[
        transitionCard(
          title: 'SlideRoute',
          icon: Icons.swipe_right_alt_rounded,
          color: Colors.purple,
          descriptor: '-> slide',
        ),
        transitionCard(
          title: 'FadeRoute',
          icon: Icons.blur_on,
          color: Colors.blueGrey,
          descriptor: 'opacity 0 -> 1',
        ),
        transitionCard(
          title: 'ScaleRoute',
          icon: Icons.zoom_out_map,
          color: Colors.brown,
          descriptor: 'scale 0 -> 1',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: MaterialPageRoute vs CupertinoPageRoute.
  // ============================================================
  debugPrint('=== Section 8: MPR vs CPR ===');

  Widget transitionTimeline({
    required String label,
    required List<String> frames,
    required Color color,
  }) {
    final List<Widget> frameCards = <Widget>[];
    for (int i = 0; i < frames.length; i++) {
      frameCards.add(
        Container(
          width: 60.0,
          height: 70.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15 + (i * 0.15)),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color, width: 1.0),
          ),
          child: Center(
            child: Text(
              frames[i],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w700, color: color),
          ),
          const SizedBox(height: 10.0),
          Row(children: frameCards),
        ],
      ),
    );
  }

  final Widget section8 = _sectionFrame(
    number: 8,
    title: 'MaterialPageRoute vs CupertinoPageRoute',
    description:
        'Material slides up from the bottom; Cupertino slides in from the '
        'right with parallax — even if we can\'t animate live, the timeline '
        'shows the keyframes.',
    accent: Colors.blueGrey,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        transitionTimeline(
          label: 'MaterialPageRoute (Y-axis slide + fade)',
          frames: const <String>['0%', '25%', '60%', '100%'],
          color: Colors.blue,
        ),
        const SizedBox(height: 12.0),
        transitionTimeline(
          label: 'CupertinoPageRoute (X-axis slide + parallax)',
          frames: const <String>['0%', '25%', '60%', '100%'],
          color: Colors.indigo,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Navigator 2.0 — pages-based declarative.
  // ============================================================
  debugPrint('=== Section 9: Navigator 2.0 pages-based ===');

  final List<Page<dynamic>> v2Pages = <Page<dynamic>>[
    const MaterialPage<void>(
      key: ValueKey<String>('home'),
      child: _Page2(label: 'home', color: Colors.cyan),
    ),
    const MaterialPage<void>(
      key: ValueKey<String>('list'),
      child: _Page2(label: 'list', color: Colors.lime),
    ),
    const CupertinoPage<void>(
      key: ValueKey<String>('detail'),
      child: _Page2(label: 'detail', color: Colors.purple),
    ),
  ];

  final Widget v2Phone = _miniPhone(
    title: 'Navigator 2.0',
    accent: Colors.cyan,
    body: Navigator(
      pages: List<Page<dynamic>>.unmodifiable(v2Pages),
      onDidRemovePage: (Page<dynamic> page) {
        debugPrint('onDidRemovePage ${page.name}');
      },
    ),
  );

  final Widget section9 = _sectionFrame(
    number: 9,
    title: 'Navigator 2.0 (pages-based)',
    description:
        'Declarative API: you give Navigator a list of Page configurations '
        'and an onPopPage callback. Adding / removing items in the list '
        'pushes / pops routes for you.',
    accent: Colors.cyan,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        v2Phone,
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'pages: [',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "   MaterialPage(key: 'home', ...),",
                style: TextStyle(fontFamily: 'monospace'),
              ),
              const Text(
                "   MaterialPage(key: 'list', ...),",
                style: TextStyle(fontFamily: 'monospace'),
              ),
              const Text(
                "   CupertinoPage(key: 'detail', ...),",
                style: TextStyle(fontFamily: 'monospace'),
              ),
              const Text(
                ']',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.cyan.shade200),
                ),
                child: const Text(
                  'Use onDidRemovePage to react after a page is removed.',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: NavigatorObserver — captured log.
  // ============================================================
  debugPrint('=== Section 10: NavigatorObserver ===');

  final List<String> observerLog = <String>[
    'didPush /home',
    'didPush /details',
    'didReplace /details -> /settings',
    'didPop /settings',
    'didRemove /home (after pushAndRemoveUntil)',
  ];

  final List<Widget> observerChips = <Widget>[];
  for (final String entry in observerLog) {
    observerChips.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.deepOrange.shade50,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.deepOrange.shade200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.radio_button_checked,
              size: 12.0,
              color: Colors.deepOrange,
            ),
            const SizedBox(width: 6.0),
            Text(
              entry,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget observerPhone = _miniPhone(
    title: 'observed',
    accent: Colors.deepOrange,
    body: Navigator(
      observers: <NavigatorObserver>[_RouteLogObserver()],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext ctx) {
            return _coloredPage(
              label: 'observed',
              color: Colors.deepOrange.shade200,
              actions: const <Widget>[Text('events flow ->')],
            );
          },
        );
      },
    ),
  );

  final Widget section10 = _sectionFrame(
    number: 10,
    title: 'NavigatorObserver',
    description:
        'Subclass NavigatorObserver to receive callbacks for every push, '
        'pop, replace, or remove. Useful for analytics or breadcrumbs.',
    accent: Colors.deepOrange,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        observerPhone,
        const SizedBox(width: 16.0),
        Expanded(
          child: Wrap(children: observerChips),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Modal routes — showDialog & showModalBottomSheet.
  // ============================================================
  debugPrint('=== Section 11: Modal routes ===');

  final Widget modalPhone = _miniPhone(
    title: 'modals',
    accent: Colors.pink,
    body: Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext ctx) {
            return _coloredPage(
              label: 'host',
              color: Colors.pink.shade100,
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    debugPrint('showDialog');
                    showDialog<void>(
                      context: ctx,
                      builder: (BuildContext c) {
                        return const AlertDialog(
                          title: Text('Hello'),
                          content: Text('I am a DialogRoute on the stack.'),
                        );
                      },
                    );
                  },
                  child: const Text('dialog'),
                ),
                const SizedBox(height: 6.0),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('showModalBottomSheet');
                    showModalBottomSheet<void>(
                      context: ctx,
                      builder: (BuildContext c) {
                        return const SizedBox(
                          height: 120.0,
                          child: Center(child: Text('Modal bottom sheet')),
                        );
                      },
                    );
                  },
                  child: const Text('sheet'),
                ),
              ],
            );
          },
        );
      },
    ),
  );

  final Widget modalPreview = Container(
    width: 260.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.pink.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Preview',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.pink.shade900,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.pink.shade200),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'AlertDialog',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.0),
              Text(
                'showDialog uses DialogRoute — added to the Navigator stack.',
                style: TextStyle(fontSize: 11.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.pink.shade200),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ModalBottomSheetRoute',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.0),
              Text(
                'slides up; tap outside to pop.',
                style: TextStyle(fontSize: 11.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final Widget section11 = _sectionFrame(
    number: 11,
    title: 'Modal routes — dialogs & bottom sheets',
    description:
        'showDialog and showModalBottomSheet are just convenience helpers '
        'that push specialised PopupRoute / ModalBottomSheetRoute objects.',
    accent: Colors.pink,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        modalPhone,
        const SizedBox(width: 16.0),
        modalPreview,
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Common pitfalls card.
  // ============================================================
  debugPrint('=== Section 12: Pitfalls ===');

  final List<Map<String, String>> pitfalls = <Map<String, String>>[
    <String, String>{
      'icon': 'context',
      'title': 'Wrong BuildContext',
      'detail':
          'Navigator.of(context) walks up the widget tree. If the context '
          'is above the MaterialApp / Navigator, the lookup fails. Use a '
          'Builder() or a child State context.',
    },
    <String, String>{
      'icon': 'await',
      'title': 'Forgetting await on async result',
      'detail':
          'push returns Future<T?>. If you await, you can read the result '
          'pushed via pop(result).',
    },
    <String, String>{
      'icon': 'rebuild',
      'title': 'Rebuilds invalidate pages list',
      'detail':
          'In Navigator 2.0, mutate the pages list with setState; never '
          'mutate in place.',
    },
    <String, String>{
      'icon': 'keys',
      'title': 'Missing keys on pages',
      'detail':
          'Without unique keys, Navigator can\'t diff the page list — '
          'transitions get confused.',
    },
    <String, String>{
      'icon': 'pop',
      'title': 'Popping the last route',
      'detail':
          'canPop() is false when only one route remains; popping closes '
          'the app on Android. Use maybePop() to be safe.',
    },
  ];

  final List<Widget> pitfallTiles = <Widget>[];
  for (final Map<String, String> p in pitfalls) {
    pitfallTiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade700),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    p['title'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.red.shade900,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['detail'] ?? '',
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section12 = _sectionFrame(
    number: 12,
    title: 'Pitfalls',
    description: 'Common Navigator gotchas distilled into a checklist.',
    accent: Colors.red,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: pitfallTiles,
    ),
  );

  // ============================================================
  // SECTION 13: Cheat-sheet — method to semantics.
  // ============================================================
  debugPrint('=== Section 13: Cheat-sheet ===');

  final List<List<String>> cheatRows = <List<String>>[
    <String>['push',
        'add route on top, returns Future<T?>'],
    <String>['pop',
        'remove topmost; deliver result to the awaiter'],
    <String>['pushReplacement',
        'pop top, push new on top — atomic'],
    <String>['pushAndRemoveUntil',
        'push new, then pop until predicate is true'],
    <String>['pushNamed',
        'lookup builder in routes table by name'],
    <String>['pushNamedAndRemoveUntil',
        'named variant of pushAndRemoveUntil'],
    <String>['popUntil',
        'pop repeatedly while predicate is false'],
    <String>['maybePop',
        'pop if possible; safe at root'],
    <String>['canPop',
        'true if stack has more than one route'],
    <String>['removeRoute',
        'remove a specific route, anywhere in the stack'],
    <String>['replaceRouteBelow',
        'replace the route below an anchor'],
    <String>['restorablePush',
        'push using a restorable route builder'],
  ];

  final List<TableRow> cheatTableRows = <TableRow>[];
  cheatTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: Colors.indigo.shade100),
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'method',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'semantics',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    ),
  );
  for (int i = 0; i < cheatRows.length; i++) {
    final List<String> r = cheatRows[i];
    cheatTableRows.add(
      TableRow(
        decoration: BoxDecoration(
          color: (i.isEven) ? Colors.white : Colors.indigo.shade50,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              r[0],
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(r[1], style: const TextStyle(fontSize: 12.0)),
          ),
        ],
      ),
    );
  }

  final Widget section13 = _sectionFrame(
    number: 13,
    title: 'Cheat-sheet',
    description:
        'A quick reference for the most-used Navigator methods. Bookmark '
        'this card.',
    accent: Colors.indigo,
    body: Table(
      border: TableBorder.all(color: Colors.indigo.shade200),
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: cheatTableRows,
    ),
  );

  // ============================================================
  // Final assembly.
  // ============================================================
  debugPrint('=== Assembling Navigator deep demo ===');

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
      title: const Text('Navigator deep demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          stackModelDiagram,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
          section10,
          section11,
          section12,
          section13,
          const SizedBox(height: 24.0),
          Center(
            child: Text(
              'End of Navigator deep demo',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// =============================================================
// Helpers (top-level so the d4rt AST runner can resolve them).
// =============================================================

Widget _pill(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _routeChip(String name, MaterialColor color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.shade400),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.label_outline, size: 16.0, color: color.shade700),
        const SizedBox(width: 6.0),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: color.shade900,
          ),
        ),
      ],
    ),
  );
}

Color _colorForRoute(String name) {
  if (name.contains('home')) {
    return Colors.lightBlue.shade200;
  }
  if (name.contains('detail')) {
    return Colors.orange.shade200;
  }
  if (name.contains('settings')) {
    return Colors.pink.shade200;
  }
  return Colors.deepPurple.shade200;
}

Widget _miniPhone({
  required String title,
  required MaterialColor accent,
  required Widget body,
}) {
  return Container(
    width: 280.0,
    height: 460.0,
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(28.0),
      border: Border.all(color: Colors.black87, width: 4.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 24.0,
              color: accent.shade700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.wifi,
                          color: Colors.white,
                          size: 11.0,
                        ),
                        SizedBox(width: 4.0),
                        Icon(
                          Icons.battery_full,
                          color: Colors.white,
                          size: 11.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: ColoredBox(color: Colors.white, child: body)),
          ],
        ),
      ),
    ),
  );
}

Widget _coloredPage({
  required String label,
  required Color color,
  required List<Widget> actions,
}) {
  return Container(
    color: color,
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8.0),
        const Divider(),
        const SizedBox(height: 4.0),
        ...actions,
      ],
    ),
  );
}

Widget _stackPreview(List<String> names) {
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < names.length; i++) {
    final bool top = (i == 0);
    tiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 3.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: top ? Colors.indigo.shade100 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: top ? Colors.indigo : Colors.grey.shade400,
            width: top ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              top ? Icons.arrow_right : Icons.layers_outlined,
              size: 14.0,
            ),
            const SizedBox(width: 6.0),
            Text(
              names[i],
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
            if (top) const Spacer(),
            if (top)
              const Text(
                'TOP',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.indigo,
                ),
              ),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'Stack',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 6.0),
      ...tiles,
    ],
  );
}

Widget _sectionFrame({
  required int number,
  required String title,
  required String description,
  required MaterialColor accent,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.shade200, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: accent.shade600,
              radius: 16.0,
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: accent.shade900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
        body,
      ],
    ),
  );
}

// =============================================================
// NavigatorObserver subclass — logs route events.
// =============================================================

class _RouteLogObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('observer didPush ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('observer didPop ${route.settings.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('observer didRemove ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
      'observer didReplace ${oldRoute?.settings.name} -> '
      '${newRoute?.settings.name}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

// =============================================================
// Reusable page widget for Navigator 2.0 demo.
// =============================================================

class _Page2 extends StatelessWidget {
  const _Page2({required this.label, required this.color});

  final String label;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color.shade100,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: color.shade900,
          ),
        ),
      ),
    );
  }
}
