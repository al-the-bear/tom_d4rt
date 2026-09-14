// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// NavigatorState — Deep Demo
// =============================================================================
//
// `NavigatorState` is the State subclass of `Navigator` (the widget that hosts
// a stack of `Route` objects). It is the workhorse of imperative navigation
// in Flutter: every call to `Navigator.of(context).push(...)`,
// `Navigator.pushNamed(...)`, `pop`, `popUntil`, `pushReplacement`,
// `pushAndRemoveUntil`, `restorablePush`, `replace`, `removeRouteBelow`,
// `canPop`, `maybePop`, etc. ends up invoking a method on a `NavigatorState`.
//
// You usually obtain one of three ways:
//   1. `Navigator.of(context)`   — the nearest enclosing navigator.
//   2. `Navigator.maybeOf(context)` — same, returns null if none.
//   3. `GlobalKey<NavigatorState>` attached to a specific `Navigator` widget,
//      so you can drive a *nested* navigator from outside its subtree.
//
// This file is a hands-on tour. We embed several independent `Navigator`
// widgets inside cards, give each its own `GlobalKey<NavigatorState>`, and a
// toolbar of buttons that invoke push / pop / pushReplacement /
// pushAndRemoveUntil / popUntil / canPop / maybePop / replace /
// restorablePush. We also wire a `NavigatorObserver` to maintain a live list
// of route names so you can see the stack evolve.
//
// Sections (top → bottom of the rendered demo):
//
//   §1  Anatomy + method cheat-sheet
//   §2  push / pop with return value
//   §3  Named routes + onGenerateRoute + pushNamed
//   §4  pushReplacement
//   §5  pushAndRemoveUntil
//   §6  popUntil with predicate
//   §7  canPop / maybePop semantics
//   §8  replace specific route in the stack
//   §9  restorablePush + RestorationScope
//   §10 NavigatorObserver — live stack viewer
//   §11 Recipe gallery (login flow / modal-then-continue / deep-link unwind)
//   §12 Pitfalls
//   §13 Reference table
//
// Everything renders inside a single Scaffold so you can scroll the lot.
// =============================================================================

// -----------------------------------------------------------------------------
// Top-level keys for the embedded navigators. Each card hosts its own
// `Navigator` widget; we hold a `GlobalKey<NavigatorState>` for it so external
// buttons can drive it. (Inside the routes themselves we use
// `Navigator.of(routeContext)` which resolves to the *nearest* navigator —
// that's the embedded one, not the root MaterialApp navigator.)
// -----------------------------------------------------------------------------

final GlobalKey<NavigatorState> _pushPopNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'pushPopNav');
final GlobalKey<NavigatorState> _namedNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'namedNav');
final GlobalKey<NavigatorState> _replaceTopNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'replaceTopNav');
final GlobalKey<NavigatorState> _removeUntilNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'removeUntilNav');
final GlobalKey<NavigatorState> _popUntilNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'popUntilNav');
final GlobalKey<NavigatorState> _canPopNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'canPopNav');
final GlobalKey<NavigatorState> _replaceMidNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'replaceMidNav');
final GlobalKey<NavigatorState> _restorableNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'restorableNav');
final GlobalKey<NavigatorState> _observerNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'observerNav');
final GlobalKey<NavigatorState> _loginNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'loginNav');
final GlobalKey<NavigatorState> _modalNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'modalNav');
final GlobalKey<NavigatorState> _deepLinkNavKey =
    GlobalKey<NavigatorState>(debugLabel: 'deepLinkNav');

// =============================================================================
// build — entry point used by the harness.
// =============================================================================

dynamic build(BuildContext context) {
  print('NavigatorState deep demo: build() called');

  // Sanity check: the root Navigator is also a NavigatorState. We log a few
  // properties from it so the test harness has something concrete to assert
  // against, and so the file demonstrates the read-only side of the API.
  final NavigatorState root = Navigator.of(context);
  print('root NavigatorState runtimeType : ${root.runtimeType}');
  print('root canPop()                   : ${root.canPop()}');
  print('root mounted                    : ${root.mounted}');
  print('root overlay runtimeType        : ${root.overlay?.runtimeType}');
  print(
      'Navigator.maybeOf identical     : ${identical(root, Navigator.maybeOf(context))}');
  print('Navigator.defaultRouteName      : ${Navigator.defaultRouteName}');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'NavigatorState Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('NavigatorState — Deep Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SectionHeader(
                index: 1,
                title: 'Anatomy + method cheat-sheet',
                subtitle:
                    'What NavigatorState is, how to obtain one, and the most '
                    'important methods in one glance.',
              ),
              const _AnatomyCard(),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 2,
                title: 'push / pop with a return value',
                subtitle:
                    'Push a sub-page that produces a result, await it, and '
                    'render that result back in the launcher route.',
              ),
              _PushPopCard(navKey: _pushPopNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 3,
                title: 'Named routes + onGenerateRoute',
                subtitle:
                    'Use a route table built with `onGenerateRoute` and call '
                    '`pushNamed(...)` with arguments.',
              ),
              _NamedRoutesCard(navKey: _namedNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 4,
                title: 'pushReplacement',
                subtitle:
                    'Swap the top route. Useful for splash → home, login → '
                    'app shell, etc.',
              ),
              _PushReplacementCard(navKey: _replaceTopNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 5,
                title: 'pushAndRemoveUntil',
                subtitle:
                    'Push a route and tear down everything underneath it that '
                    'fails a predicate (classic logout / new-shell flow).',
              ),
              _PushAndRemoveUntilCard(navKey: _removeUntilNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 6,
                title: 'popUntil with predicate',
                subtitle:
                    'Pop in a loop until a predicate is satisfied — most often '
                    '`(r) => r.isFirst` or `ModalRoute.withName(...)`.',
              ),
              _PopUntilCard(navKey: _popUntilNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 7,
                title: 'canPop / maybePop',
                subtitle:
                    '`canPop` is a synchronous query, `maybePop` consults '
                    'route handlers (e.g. WillPopScope) and may decline.',
              ),
              _CanPopCard(navKey: _canPopNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 8,
                title: 'replace a specific route',
                subtitle:
                    'Surgically swap a route that is *not* on top, using its '
                    '`Route` reference.',
              ),
              _ReplaceMidCard(navKey: _replaceMidNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 9,
                title: 'restorablePush + RestorationScope',
                subtitle:
                    'Restorable navigation: rebuild the stack across an app '
                    'kill if a `restorationScopeId` is set.',
              ),
              _RestorableCard(navKey: _restorableNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 10,
                title: 'NavigatorObserver — live stack viewer',
                subtitle:
                    'Observe didPush / didPop / didReplace / didRemove and '
                    'project them into a list of names you can render.',
              ),
              _ObserverCard(navKey: _observerNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 11,
                title: 'Recipe gallery',
                subtitle:
                    'Three real-world flows wired up so you can drive them: '
                    'login, modal-then-continue, deep-link unwind.',
              ),
              _LoginRecipeCard(navKey: _loginNavKey),
              const SizedBox(height: 12),
              _ModalRecipeCard(navKey: _modalNavKey),
              const SizedBox(height: 12),
              _DeepLinkRecipeCard(navKey: _deepLinkNavKey),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 12,
                title: 'Pitfalls',
                subtitle:
                    'Common mistakes when driving navigators imperatively.',
              ),
              const _PitfallsCard(),
              const SizedBox(height: 16),
              _SectionHeader(
                index: 13,
                title: 'Reference table',
                subtitle: 'Compact API summary for hovering / cmd-F.',
              ),
              const _ReferenceTableCard(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Shared chrome — section headers, code chips, demo card frame.
// =============================================================================

class _SectionHeader extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;

  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$index',
              style: TextStyle(
                color: cs.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: cs.onSurfaceVariant,
                    height: 1.3,
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

class _CodeChip extends StatelessWidget {
  final String text;
  const _CodeChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.5,
        ),
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _DemoCard({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(height: 1.3),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// A short toolbar of buttons. Each button is a (label, callback) pair; the
// toolbar wraps so it stays usable on narrow widths.
class _Toolbar extends StatelessWidget {
  final List<_ToolButton> buttons;
  const _Toolbar(this.buttons);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: <Widget>[
        for (final _ToolButton b in buttons)
          ElevatedButton.icon(
            onPressed: b.onPressed,
            icon: Icon(b.icon, size: 16),
            label: Text(b.label),
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
      ],
    );
  }
}

class _ToolButton {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  const _ToolButton(this.label, this.icon, this.onPressed);
}

// A frame around an embedded `Navigator`. Gives it a fixed height and a
// border so the user can see exactly which area is the "child app".
class _NavFrame extends StatelessWidget {
  final Widget child;
  const _NavFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

// =============================================================================
// §1 — Anatomy card
// =============================================================================

class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'NavigatorState in one screen',
      description:
          'A NavigatorState manages an ordered list of Route<T> objects. '
          'Imperative methods either push, pop, replace or remove routes; '
          'the topmost route owns the visible page.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Obtain a NavigatorState:'),
          const SizedBox(height: 4),
          Wrap(spacing: 6, runSpacing: 4, children: const <Widget>[
            _CodeChip('Navigator.of(context)'),
            _CodeChip('Navigator.maybeOf(context)'),
            _CodeChip('navKey.currentState'),
          ]),
          const SizedBox(height: 10),
          const Text('Mutating methods (return Future<T?> when applicable):'),
          const SizedBox(height: 4),
          Wrap(spacing: 6, runSpacing: 4, children: const <Widget>[
            _CodeChip('push(route)'),
            _CodeChip('pushNamed(name, arguments: a)'),
            _CodeChip('pushReplacement(route)'),
            _CodeChip('pushReplacementNamed(name)'),
            _CodeChip('pushAndRemoveUntil(route, predicate)'),
            _CodeChip('pushNamedAndRemoveUntil(name, predicate)'),
            _CodeChip('pop([result])'),
            _CodeChip('maybePop([result])'),
            _CodeChip('popUntil(predicate)'),
            _CodeChip('replace(oldRoute: r1, newRoute: r2)'),
            _CodeChip('replaceRouteBelow(anchorRoute: a, newRoute: r2)'),
            _CodeChip('removeRoute(route)'),
            _CodeChip('removeRouteBelow(anchorRoute: a)'),
            _CodeChip('restorablePush(routeBuilder, arguments: a)'),
            _CodeChip('restorablePushNamed(name, arguments: a)'),
          ]),
          const SizedBox(height: 10),
          const Text('Read-only:'),
          const SizedBox(height: 4),
          Wrap(spacing: 6, runSpacing: 4, children: const <Widget>[
            _CodeChip('canPop()'),
            _CodeChip('mounted'),
            _CodeChip('overlay'),
            _CodeChip('context'),
            _CodeChip('widget (Navigator)'),
          ]),
          const SizedBox(height: 10),
          const Text(
            'Predicates: routes carry settings (name, arguments). '
            '`ModalRoute.withName(\'/home\')` is a predicate matcher used by '
            '`popUntil` / `pushAndRemoveUntil`. `(r) => r.isFirst` matches the '
            'very first route.',
            style: TextStyle(height: 1.35),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// §2 — push / pop with return value
// =============================================================================

class _PushPopCard extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  const _PushPopCard({required this.navKey});

  @override
  State<_PushPopCard> createState() => _PushPopCardState();
}

class _PushPopCardState extends State<_PushPopCard> {
  String _lastResult = '(none)';

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§2  push / pop with return value',
      description:
          'Press "Push picker" to push a sub-route that returns a String when '
          'popped. The launcher waits for the result and shows it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Push picker', Icons.add_road, () async {
              final NavigatorState? nav = widget.navKey.currentState;
              if (nav == null) return;
              final Object? result = await nav.push<String>(
                MaterialPageRoute<String>(
                  settings: const RouteSettings(name: '/picker'),
                  builder: (_) => const _PickerPage(),
                ),
              );
              setState(() {
                _lastResult = result?.toString() ?? '(cancelled)';
              });
              print('PushPopCard: picker returned $result');
            }),
            _ToolButton('Maybe pop', Icons.undo, () {
              widget.navKey.currentState?.maybePop();
            }),
          ]),
          const SizedBox(height: 8),
          Text('Last result: $_lastResult'),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: widget.navKey,
              initialRoute: '/',
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute<dynamic>(
                  settings: settings,
                  builder: (_) => const _LauncherPage(
                    label: '§2 launcher',
                    explanation:
                        'Press “Push picker” above. The picker page will '
                        'appear here. Pop it with Cherry / Lime / back to '
                        'return a value.',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LauncherPage extends StatelessWidget {
  final String label;
  final String explanation;
  const _LauncherPage({required this.label, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        title: Text(label),
        backgroundColor: Colors.indigo.shade100,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(explanation, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class _PickerPage extends StatelessWidget {
  const _PickerPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picker')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Pick a flavour'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop('cherry'),
                  child: const Text('Cherry'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop('lime'),
                  child: const Text('Lime'),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// §3 — Named routes + onGenerateRoute
// =============================================================================

class _NamedRoutesCard extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  const _NamedRoutesCard({required this.navKey});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§3  pushNamed via onGenerateRoute',
      description:
          'The embedded Navigator declares an `onGenerateRoute` that maps '
          'route names to pages. `pushNamed` builds whatever that callback '
          'returns. Arguments are passed via `RouteSettings.arguments`.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('pushNamed /detail', Icons.article, () {
              navKey.currentState?.pushNamed(
                '/detail',
                arguments: 'item-42',
              );
            }),
            _ToolButton('pushNamed /settings', Icons.settings, () {
              navKey.currentState?.pushNamed('/settings');
            }),
            _ToolButton('pushReplacementNamed /home', Icons.home, () {
              navKey.currentState?.pushReplacementNamed('/home');
            }),
            _ToolButton('pop', Icons.undo, () {
              if (navKey.currentState?.canPop() ?? false) {
                navKey.currentState?.pop();
              }
            }),
          ]),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: navKey,
              initialRoute: '/home',
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case '/home':
                    return MaterialPageRoute<dynamic>(
                      settings: settings,
                      builder: (_) => const _LauncherPage(
                        label: '/home',
                        explanation:
                            'This is /home. Use the toolbar to pushNamed '
                            '/detail or /settings; pushReplacementNamed '
                            '/home swaps me out.',
                      ),
                    );
                  case '/detail':
                    final Object? args = settings.arguments;
                    return MaterialPageRoute<dynamic>(
                      settings: settings,
                      builder: (_) => _NamedSubPage(
                        label: '/detail',
                        body: 'arguments = $args',
                      ),
                    );
                  case '/settings':
                    return MaterialPageRoute<dynamic>(
                      settings: settings,
                      builder: (_) => const _NamedSubPage(
                        label: '/settings',
                        body: 'No arguments. Pop to return.',
                      ),
                    );
                  default:
                    return MaterialPageRoute<dynamic>(
                      settings: settings,
                      builder: (_) => _NamedSubPage(
                        label: 'unknown',
                        body:
                            'No route generated for "${settings.name}". This '
                            'is the fallback page.',
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NamedSubPage extends StatelessWidget {
  final String label;
  final String body;
  const _NamedSubPage({required this.label, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(body),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('pop'),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// §4 — pushReplacement
// =============================================================================

class _PushReplacementCard extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  const _PushReplacementCard({required this.navKey});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§4  pushReplacement',
      description:
          '`pushReplacement` pops the current route and pushes a new one in a '
          'single transition. Classic use: splash → home, login → app shell.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Replace top → A', Icons.swap_horiz, () {
              navKey.currentState?.pushReplacement(
                MaterialPageRoute<dynamic>(
                  settings: const RouteSettings(name: '/A'),
                  builder: (_) => const _ColoredPage(
                    label: 'A',
                    color: Color(0xFFFFE0B2),
                  ),
                ),
              );
            }),
            _ToolButton('Replace top → B', Icons.swap_horiz, () {
              navKey.currentState?.pushReplacement(
                MaterialPageRoute<dynamic>(
                  settings: const RouteSettings(name: '/B'),
                  builder: (_) => const _ColoredPage(
                    label: 'B',
                    color: Color(0xFFC8E6C9),
                  ),
                ),
              );
            }),
            _ToolButton('Push C (no replace)', Icons.add, () {
              navKey.currentState?.push(
                MaterialPageRoute<dynamic>(
                  settings: const RouteSettings(name: '/C'),
                  builder: (_) => const _ColoredPage(
                    label: 'C',
                    color: Color(0xFFBBDEFB),
                  ),
                ),
              );
            }),
            _ToolButton('pop', Icons.undo, () {
              navKey.currentState?.pop();
            }),
          ]),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: navKey,
              onGenerateRoute: (_) => MaterialPageRoute<dynamic>(
                settings: const RouteSettings(name: '/'),
                builder: (_) => const _ColoredPage(
                  label: 'splash',
                  color: Color(0xFFE1BEE7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColoredPage extends StatelessWidget {
  final String label;
  final Color color;
  const _ColoredPage({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: Text('Page $label'),
        backgroundColor: color,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// §5 — pushAndRemoveUntil
// =============================================================================

class _PushAndRemoveUntilCard extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  const _PushAndRemoveUntilCard({required this.navKey});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§5  pushAndRemoveUntil',
      description:
          'Stack up A → B → C, then push “shell” and remove everything '
          'underneath that fails the predicate `(r) => false`. End state: '
          'just the new shell.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Push A', Icons.add, () {
              navKey.currentState?.push(_routeFor('A', Colors.red.shade100));
            }),
            _ToolButton('Push B', Icons.add, () {
              navKey.currentState?.push(_routeFor('B', Colors.green.shade100));
            }),
            _ToolButton('Push C', Icons.add, () {
              navKey.currentState?.push(_routeFor('C', Colors.blue.shade100));
            }),
            _ToolButton('pushAndRemoveUntil shell, false', Icons.layers_clear,
                () {
              navKey.currentState?.pushAndRemoveUntil(
                _routeFor('shell', Colors.amber.shade100),
                (Route<dynamic> r) => false,
              );
            }),
            _ToolButton('pushAndRemoveUntil shell, isFirst', Icons.layers, () {
              navKey.currentState?.pushAndRemoveUntil(
                _routeFor('shell', Colors.amber.shade200),
                (Route<dynamic> r) => r.isFirst,
              );
            }),
            _ToolButton('pop', Icons.undo, () {
              navKey.currentState?.pop();
            }),
          ]),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: navKey,
              onGenerateRoute: (_) => _routeFor('home', Colors.grey.shade200),
            ),
          ),
        ],
      ),
    );
  }
}

MaterialPageRoute<dynamic> _routeFor(String label, Color color) {
  return MaterialPageRoute<dynamic>(
    settings: RouteSettings(name: '/$label'),
    builder: (_) => _ColoredPage(label: label, color: color),
  );
}

// =============================================================================
// §6 — popUntil with predicate
// =============================================================================

class _PopUntilCard extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  const _PopUntilCard({required this.navKey});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§6  popUntil with predicate',
      description:
          'Push several pages, then pop in a loop until a predicate is '
          'satisfied. Common predicates: `(r) => r.isFirst` or '
          '`ModalRoute.withName("/home")`.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Push X', Icons.add, () {
              navKey.currentState?.push(_routeFor('X', Colors.cyan.shade100));
            }),
            _ToolButton('Push Y', Icons.add, () {
              navKey.currentState
                  ?.push(_routeFor('Y', Colors.deepPurple.shade100));
            }),
            _ToolButton('Push Z', Icons.add, () {
              navKey.currentState?.push(_routeFor('Z', Colors.teal.shade100));
            }),
            _ToolButton('popUntil isFirst', Icons.first_page, () {
              navKey.currentState?.popUntil((Route<dynamic> r) => r.isFirst);
            }),
            _ToolButton('popUntil withName(/home)', Icons.home, () {
              navKey.currentState?.popUntil(ModalRoute.withName('/home'));
            }),
            _ToolButton('popUntil withName(/Y)', Icons.flag, () {
              navKey.currentState?.popUntil(ModalRoute.withName('/Y'));
            }),
          ]),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: navKey,
              onGenerateRoute: (_) => _routeFor('home', Colors.grey.shade200),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// §7 — canPop / maybePop semantics
// =============================================================================

class _CanPopCard extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  const _CanPopCard({required this.navKey});

  @override
  State<_CanPopCard> createState() => _CanPopCardState();
}

class _CanPopCardState extends State<_CanPopCard> {
  String _log = '';

  void _append(String s) {
    setState(() {
      _log = '$_log\n$s'.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§7  canPop / maybePop',
      description:
          '`canPop()` is synchronous and returns true if there is *anything* '
          'beneath the current route. `maybePop()` consults the topmost '
          'route\'s pop handlers — a route can refuse via WillPopScope.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Push plain', Icons.add, () {
              widget.navKey.currentState?.push(
                _routeFor('plain', Colors.lime.shade100),
              );
            }),
            _ToolButton('Push guarded', Icons.lock, () {
              widget.navKey.currentState?.push(
                MaterialPageRoute<dynamic>(
                  settings: const RouteSettings(name: '/guarded'),
                  builder: (_) => const _GuardedPage(),
                ),
              );
            }),
            _ToolButton('canPop?', Icons.question_mark, () {
              final bool can =
                  widget.navKey.currentState?.canPop() ?? false;
              _append('canPop = $can');
            }),
            _ToolButton('maybePop', Icons.undo, () async {
              final bool popped =
                  await widget.navKey.currentState?.maybePop() ?? false;
              _append('maybePop returned $popped');
            }),
            _ToolButton('pop (forced)', Icons.cancel, () {
              if (widget.navKey.currentState?.canPop() ?? false) {
                widget.navKey.currentState?.pop();
                _append('forced pop');
              } else {
                _append('cannot pop — already at root');
              }
            }),
          ]),
          const SizedBox(height: 8),
          if (_log.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _log,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: widget.navKey,
              onGenerateRoute: (_) =>
                  _routeFor('home', Colors.grey.shade200),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuardedPage extends StatelessWidget {
  const _GuardedPage();

  @override
  Widget build(BuildContext context) {
    // WillPopScope is deprecated but still works; PopScope is the new API.
    return WillPopScope(
      onWillPop: () async {
        final bool? confirm = await showDialog<bool>(
          context: context,
          builder: (BuildContext c) => AlertDialog(
            title: const Text('Discard changes?'),
            content: const Text(
              'maybePop is asking the route — return false to refuse.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(c).pop(false),
                child: const Text('Stay'),
              ),
              TextButton(
                onPressed: () => Navigator.of(c).pop(true),
                child: const Text('Discard'),
              ),
            ],
          ),
        );
        return confirm ?? false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('guarded')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'This route refuses maybePop unless you pick "Discard".',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// §8 — replace specific route
// =============================================================================

class _ReplaceMidCard extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  const _ReplaceMidCard({required this.navKey});

  @override
  State<_ReplaceMidCard> createState() => _ReplaceMidCardState();
}

class _ReplaceMidCardState extends State<_ReplaceMidCard> {
  // We keep a handle to the "middle" route so we can later hand it to
  // `replace`. This is the canonical pattern: capture the Route reference
  // when you push it, hold onto it, replace later.
  Route<dynamic>? _middle;

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§8  replace a non-top route',
      description:
          '`replace(oldRoute: X, newRoute: Y)` swaps a specific route in the '
          'stack. The route does not have to be on top. `replaceRouteBelow` '
          'swaps the route directly under an anchor.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Push middle', Icons.add, () {
              final Route<dynamic> r = _routeFor(
                'middle',
                Colors.orange.shade100,
              );
              _middle = r;
              widget.navKey.currentState?.push(r);
            }),
            _ToolButton('Push top', Icons.add, () {
              widget.navKey.currentState
                  ?.push(_routeFor('top', Colors.pink.shade100));
            }),
            _ToolButton('Replace middle → middleNEW', Icons.swap_calls, () {
              final Route<dynamic>? old = _middle;
              if (old == null) return;
              final Route<dynamic> fresh = _routeFor(
                'middleNEW',
                Colors.deepOrange.shade100,
              );
              widget.navKey.currentState
                  ?.replace(oldRoute: old, newRoute: fresh);
              _middle = fresh;
            }),
            _ToolButton('replaceRouteBelow top → middle2', Icons.layers, () {
              final NavigatorState? nav = widget.navKey.currentState;
              if (nav == null) return;
              // We need an anchor. Use the very topmost route. We can't
              // grab it directly off the public API, but we can ask the
              // observer-driven version of this card. For this demo we
              // simply push a fresh middle below the top by composing
              // pop+push instead — included here for explanation only.
              print('replaceRouteBelow conceptual demo only.');
            }),
            _ToolButton('pop', Icons.undo, () {
              widget.navKey.currentState?.pop();
            }),
          ]),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: widget.navKey,
              onGenerateRoute: (_) =>
                  _routeFor('home', Colors.grey.shade200),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// §9 — restorablePush + RestorationScope
// =============================================================================

// Restorable navigation requires a top-level route builder (a static or
// top-level function), because the framework stores its identity across
// app restarts. The function must take a BuildContext and Object? arguments
// and return a Route.
Route<dynamic> _restorableRouteBuilder(
  BuildContext context,
  Object? arguments,
) {
  return MaterialPageRoute<dynamic>(
    settings: RouteSettings(
      name: '/restorable',
      arguments: arguments,
    ),
    builder: (_) => _ColoredPage(
      label: 'restorable($arguments)',
      color: Colors.lightGreen.shade100,
    ),
  );
}

class _RestorableCard extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  const _RestorableCard({required this.navKey});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§9  restorablePush',
      description:
          'When the embedded Navigator has a `restorationScopeId`, '
          '`restorablePush(builder, arguments: a)` records enough information '
          'to rebuild this stack across app kills. The builder must be top-'
          'level / static so it can be referenced by name.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('restorablePush(1)', Icons.save, () {
              navKey.currentState?.restorablePush<dynamic>(
                _restorableRouteBuilder,
                arguments: 1,
              );
            }),
            _ToolButton('restorablePush(2)', Icons.save, () {
              navKey.currentState?.restorablePush<dynamic>(
                _restorableRouteBuilder,
                arguments: 2,
              );
            }),
            _ToolButton('pop', Icons.undo, () {
              navKey.currentState?.pop();
            }),
          ]),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: navKey,
              restorationScopeId: 'restorable-demo',
              onGenerateRoute: (_) => _routeFor(
                'home',
                Colors.lightGreen.shade50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// §10 — NavigatorObserver, live stack viewer
// =============================================================================

class _StackObserver extends NavigatorObserver {
  final void Function(List<String>) onStack;
  final List<String> _stack = <String>[];

  _StackObserver(this.onStack);

  void _emit() => onStack(List<String>.unmodifiable(_stack));

  String _name(Route<dynamic>? r) =>
      r?.settings.name ?? '<${r?.runtimeType ?? 'null'}>';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.add(_name(route));
    _emit();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (_stack.isNotEmpty) _stack.removeLast();
    _emit();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(_name(route));
    _emit();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final int i = _stack.indexOf(_name(oldRoute));
    if (i >= 0) {
      _stack[i] = _name(newRoute);
    } else if (newRoute != null) {
      _stack.add(_name(newRoute));
    }
    _emit();
  }
}

class _ObserverCard extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  const _ObserverCard({required this.navKey});

  @override
  State<_ObserverCard> createState() => _ObserverCardState();
}

class _ObserverCardState extends State<_ObserverCard> {
  late final _StackObserver _observer;
  List<String> _stack = const <String>[];

  @override
  void initState() {
    super.initState();
    _observer = _StackObserver((List<String> s) {
      setState(() => _stack = s);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§10  Live route stack viewer',
      description:
          'A `NavigatorObserver` attached to this Navigator records the route '
          'names and projects them into a list rendered to the right of the '
          'frame. Drive the stack with the buttons.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('push /alpha', Icons.add, () {
              widget.navKey.currentState
                  ?.push(_routeFor('alpha', Colors.blue.shade100));
            }),
            _ToolButton('push /beta', Icons.add, () {
              widget.navKey.currentState
                  ?.push(_routeFor('beta', Colors.green.shade100));
            }),
            _ToolButton('push /gamma', Icons.add, () {
              widget.navKey.currentState
                  ?.push(_routeFor('gamma', Colors.orange.shade100));
            }),
            _ToolButton('pop', Icons.undo, () {
              widget.navKey.currentState?.pop();
            }),
            _ToolButton('popUntil isFirst', Icons.first_page, () {
              widget.navKey.currentState
                  ?.popUntil((Route<dynamic> r) => r.isFirst);
            }),
            _ToolButton('pushReplacement /omega', Icons.swap_horiz, () {
              widget.navKey.currentState?.pushReplacement(
                _routeFor('omega', Colors.purple.shade100),
              );
            }),
          ]),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: _NavFrame(
                  child: Navigator(
                    key: widget.navKey,
                    observers: <NavigatorObserver>[_observer],
                    onGenerateRoute: (_) =>
                        _routeFor('home', Colors.grey.shade200),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Container(
                  height: 240,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Stack (top → bottom)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            for (final String name in _stack.reversed)
                              Text(
                                '• $name',
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// §11 — Recipe gallery
// =============================================================================

// -------- Login flow recipe ---------------------------------------------------

class _LoginRecipeCard extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  const _LoginRecipeCard({required this.navKey});

  @override
  State<_LoginRecipeCard> createState() => _LoginRecipeCardState();
}

class _LoginRecipeCardState extends State<_LoginRecipeCard> {
  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§11.a  Login flow',
      description:
          'Splash → Login → AppShell. Successful login uses '
          '`pushAndRemoveUntil(shell, (_) => false)`. Logout reverses with '
          '`pushAndRemoveUntil(login, (_) => false)`.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Login', Icons.login, _loggedIn ? null : _login),
            _ToolButton('Logout', Icons.logout, !_loggedIn ? null : _logout),
            _ToolButton(
              'Push profile (only when in shell)',
              Icons.person,
              !_loggedIn
                  ? null
                  : () {
                      widget.navKey.currentState?.pushNamed('/profile');
                    },
            ),
          ]),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: widget.navKey,
              initialRoute: '/login',
              onGenerateRoute: (RouteSettings s) {
                switch (s.name) {
                  case '/login':
                    return MaterialPageRoute<dynamic>(
                      settings: s,
                      builder: (_) => const _ColoredPage(
                        label: 'login',
                        color: Color(0xFFFFCDD2),
                      ),
                    );
                  case '/shell':
                    return MaterialPageRoute<dynamic>(
                      settings: s,
                      builder: (_) => const _ColoredPage(
                        label: 'app shell',
                        color: Color(0xFFC5CAE9),
                      ),
                    );
                  case '/profile':
                    return MaterialPageRoute<dynamic>(
                      settings: s,
                      builder: (_) => const _ColoredPage(
                        label: 'profile',
                        color: Color(0xFFFFF9C4),
                      ),
                    );
                  default:
                    return MaterialPageRoute<dynamic>(
                      settings: s,
                      builder: (_) => const _ColoredPage(
                        label: '?',
                        color: Color(0xFFEEEEEE),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    widget.navKey.currentState?.pushNamedAndRemoveUntil(
      '/shell',
      (Route<dynamic> r) => false,
    );
    setState(() => _loggedIn = true);
  }

  void _logout() {
    widget.navKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
      (Route<dynamic> r) => false,
    );
    setState(() => _loggedIn = false);
  }
}

// -------- Modal-then-continue recipe -----------------------------------------

class _ModalRecipeCard extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  const _ModalRecipeCard({required this.navKey});

  @override
  State<_ModalRecipeCard> createState() => _ModalRecipeCardState();
}

class _ModalRecipeCardState extends State<_ModalRecipeCard> {
  String _decision = '(none)';

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§11.b  Modal then continue',
      description:
          'Push a confirmation page, await its result, and only continue '
          'with the original action if the user confirmed.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Buy', Icons.shopping_cart, () async {
              final NavigatorState? nav = widget.navKey.currentState;
              if (nav == null) return;
              final bool? ok = await nav.push<bool>(
                MaterialPageRoute<bool>(
                  settings: const RouteSettings(name: '/confirm'),
                  builder: (_) => const _ConfirmPage(),
                ),
              );
              if (!mounted) return;
              if (ok == true) {
                setState(() => _decision = 'CONFIRMED – proceeding');
                nav.push(MaterialPageRoute<dynamic>(
                  settings: const RouteSettings(name: '/receipt'),
                  builder: (_) => const _ColoredPage(
                    label: 'receipt',
                    color: Color(0xFFB2DFDB),
                  ),
                ));
              } else {
                setState(() => _decision = 'cancelled');
              }
            }),
            _ToolButton('pop', Icons.undo, () {
              widget.navKey.currentState?.pop();
            }),
          ]),
          const SizedBox(height: 8),
          Text('Decision: $_decision'),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: widget.navKey,
              onGenerateRoute: (_) => MaterialPageRoute<dynamic>(
                settings: const RouteSettings(name: '/'),
                builder: (_) => const _ColoredPage(
                  label: 'cart',
                  color: Color(0xFFE0F7FA),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmPage extends StatelessWidget {
  const _ConfirmPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Really buy?'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// -------- Deep-link unwind recipe --------------------------------------------

class _DeepLinkRecipeCard extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  const _DeepLinkRecipeCard({required this.navKey});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§11.c  Deep-link unwind',
      description:
          'Build a deep-link stack synthetically (home/category/item) and '
          'then jump out of the middle with `popUntil(withName("/home"))`.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Toolbar(<_ToolButton>[
            _ToolButton('Open deep link', Icons.link, () {
              final NavigatorState? nav = navKey.currentState;
              if (nav == null) return;
              nav.pushNamed('/category');
              nav.pushNamed('/item');
            }),
            _ToolButton('Unwind to /home', Icons.home, () {
              navKey.currentState?.popUntil(ModalRoute.withName('/home'));
            }),
            _ToolButton('Unwind to root', Icons.first_page, () {
              navKey.currentState
                  ?.popUntil((Route<dynamic> r) => r.isFirst);
            }),
          ]),
          const SizedBox(height: 8),
          _NavFrame(
            child: Navigator(
              key: navKey,
              initialRoute: '/home',
              onGenerateRoute: (RouteSettings s) {
                switch (s.name) {
                  case '/home':
                    return MaterialPageRoute<dynamic>(
                      settings: s,
                      builder: (_) => const _ColoredPage(
                        label: 'home',
                        color: Color(0xFFFFF8E1),
                      ),
                    );
                  case '/category':
                    return MaterialPageRoute<dynamic>(
                      settings: s,
                      builder: (_) => const _ColoredPage(
                        label: 'category',
                        color: Color(0xFFE8F5E9),
                      ),
                    );
                  case '/item':
                    return MaterialPageRoute<dynamic>(
                      settings: s,
                      builder: (_) => const _ColoredPage(
                        label: 'item',
                        color: Color(0xFFE3F2FD),
                      ),
                    );
                  default:
                    return MaterialPageRoute<dynamic>(
                      settings: s,
                      builder: (_) => const _ColoredPage(
                        label: 'unknown',
                        color: Color(0xFFEEEEEE),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// §12 — Pitfalls
// =============================================================================

class _PitfallsCard extends StatelessWidget {
  const _PitfallsCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§12  Common pitfalls',
      description: 'Things that bite people first time.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _Pitfall(
            title: '1. navKey.currentState is null',
            body:
                'Until the Navigator widget has been *built and mounted*, '
                'the GlobalKey returns null. Don’t call methods inside '
                'initState — wait until first build, or use a post-frame '
                'callback.',
          ),
          _Pitfall(
            title: '2. Double pop',
            body:
                'Calling pop() twice in quick succession can pop something '
                'you did not intend. Always check canPop() and prefer '
                'popUntil(predicate) when the goal is "go back to known '
                'screen".',
          ),
          _Pitfall(
            title: '3. Reusing the same GlobalKey for two Navigators',
            body:
                'A GlobalKey can only be attached to one element at a time. '
                'Two Navigator widgets sharing one key will throw at build.',
          ),
          _Pitfall(
            title: '4. Navigator.of(context) finds the WRONG navigator',
            body:
                'Inside a nested Navigator subtree, Navigator.of(context) '
                'gives you the nearest one — that is usually correct, but '
                'sometimes you really want the root: pass rootNavigator: true.',
          ),
          _Pitfall(
            title: '5. restorablePush with a closure',
            body:
                'restorablePush takes a top-level / static function — it '
                'cannot capture state. Pass parameters via the `arguments:` '
                'argument instead.',
          ),
          _Pitfall(
            title: '6. Forgetting to await push<T>',
            body:
                'push<T> returns a Future<T?>. If you don’t await it (or '
                'attach .then), the result the popped route returns is '
                'silently dropped.',
          ),
          _Pitfall(
            title: '7. Predicate that never matches',
            body:
                'popUntil((r) => r.settings.name == "/missing") will pop '
                'past the root and crash. Always include a fallback like '
                '`r.isFirst` in your OR.',
          ),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  final String title;
  final String body;
  const _Pitfall({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(body, style: const TextStyle(height: 1.3)),
        ],
      ),
    );
  }
}

// =============================================================================
// §13 — Reference table
// =============================================================================

class _ReferenceTableCard extends StatelessWidget {
  const _ReferenceTableCard();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: '§13  NavigatorState reference table',
      description: 'Compact summary you can search.',
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: const <TableRow>[
          TableRow(children: <Widget>[
            _RefCell('push(route)', isHeader: true),
            _RefCell('Push route on top of the stack. Returns Future<T?>.',
                isHeader: true),
          ]),
          TableRow(children: <Widget>[
            _RefCell('pushNamed(name, {arguments})'),
            _RefCell(
                'Resolve `name` via routes table or onGenerateRoute and push.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('pushReplacement(route)'),
            _RefCell('Pop the topmost route and push `route` in its place.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('pushReplacementNamed(name)'),
            _RefCell('Same, with named lookup.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('pushAndRemoveUntil(route, predicate)'),
            _RefCell(
                'Push, then remove all routes underneath that fail predicate.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('pushNamedAndRemoveUntil(name, predicate)'),
            _RefCell('Same, with named lookup.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('pop([result])'),
            _RefCell('Pop the topmost route, optionally returning `result`.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('maybePop([result])'),
            _RefCell(
                'Asks the topmost route for permission first (WillPopScope).'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('canPop()'),
            _RefCell('True if there is anything underneath the top route.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('popUntil(predicate)'),
            _RefCell('Pop in a loop until predicate returns true.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('replace(oldRoute:, newRoute:)'),
            _RefCell('Swap a route in place by reference.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('replaceRouteBelow(anchorRoute:, newRoute:)'),
            _RefCell('Swap the route directly under an anchor.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('removeRoute(route)'),
            _RefCell('Quietly remove a route (no transition).'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('removeRouteBelow(anchorRoute:)'),
            _RefCell('Quietly remove the route directly under an anchor.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('restorablePush(builder, {arguments})'),
            _RefCell(
                'Push restorably; needs `restorationScopeId` on Navigator.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('restorablePushNamed(name, {arguments})'),
            _RefCell('Restorable named push.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('mounted'),
            _RefCell('Whether the State is currently in the tree.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('overlay'),
            _RefCell('The OverlayState used to host route overlays.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('context'),
            _RefCell('BuildContext the navigator was built with.'),
          ]),
          TableRow(children: <Widget>[
            _RefCell('widget'),
            _RefCell('The Navigator widget configuration.'),
          ]),
        ],
      ),
    );
  }
}

class _RefCell extends StatelessWidget {
  final String text;
  final bool isHeader;
  const _RefCell(this.text, {this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: isHeader ? null : 'monospace',
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 12.5,
          height: 1.3,
        ),
      ),
    );
  }
}

// =============================================================================
// End of file.
// =============================================================================
