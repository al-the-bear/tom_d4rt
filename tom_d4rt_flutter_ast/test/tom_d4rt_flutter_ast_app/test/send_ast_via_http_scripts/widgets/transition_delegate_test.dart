// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — TransitionDelegate
///
/// TransitionDelegate is an abstract class that controls how the Navigator
/// transitions between pages when its page list changes. It decides which
/// routes should animate in (push), animate out (pop), or appear/disappear
/// instantly (add/remove). The default implementation is
/// DefaultTransitionDelegate, which plays standard push/pop animations.
///
/// Sections
/// ─────────
/// 1. What is TransitionDelegate?
/// 2. DefaultTransitionDelegate behavior
/// 3. RouteTransitionRecord and its markFor* methods
/// 4. resolve() contract
/// 5. Live: page stack with default transitions
/// 6. Live: custom instant delegate (no animations)
/// 7. Live: custom staggered delegate
/// 8. Best practices

// ─── palette ───────────────────────────────────────────────
const _kViolet     = Color(0xFF7E57C2);
const _kVioletLight = Color(0xFFEDE7F6);
const _kVioletDark = Color(0xFF311B92);
const _kAmber      = Color(0xFFFFC107);
const _kAmberLight = Color(0xFFFFF8E1);
const _kAmberDark  = Color(0xFFFF6F00);
const _kSurface    = Color(0xFFFBFBFD);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── theory data ───────────────────────────────────────────
const _kOverview = 'TransitionDelegate sits between the Navigator and its '
    'routes. Whenever the Navigator\'s pages list changes (pages added, removed, '
    'or reordered), the framework builds a set of RouteTransitionRecords and '
    'passes them to TransitionDelegate.resolve(). The delegate examines each '
    'record and calls one of four markFor* methods to decide the transition '
    'behavior. DefaultTransitionDelegate handles the common case: new routes '
    'push in with animation, removed routes pop out with animation.';

class _MarkMethod {
  const _MarkMethod(this.name, this.description, this.effect);
  final String name;
  final String description;
  final String effect;
}

const _kMarkMethods = <_MarkMethod>[
  _MarkMethod('markForPush',
      'The route should animate in using its push transition.',
      'Route plays its enter animation (slide, fade, etc.) from start to end. '
      'This is the standard behavior for newly added pages.'),
  _MarkMethod('markForAdd',
      'The route should appear instantly without any animation.',
      'Route skips its enter animation and appears immediately at its final '
      'state. Used for initial page stack setup or instant navigation.'),
  _MarkMethod('markForPop',
      'The route should animate out using its pop transition.',
      'Route plays its exit animation from end to start, then is removed. '
      'Standard behavior for removed pages.'),
  _MarkMethod('markForComplete',
      'The route should disappear instantly without any animation.',
      'Route is removed immediately without playing any exit animation. '
      'Useful for clearing a stack of pages all at once.'),
];

class _DefaultRule {
  const _DefaultRule(this.scenario, this.action);
  final String scenario;
  final String action;
}

const _kDefaultRules = <_DefaultRule>[
  _DefaultRule(
      'New route is added to the top of the stack',
      'markForPush — plays the push animation'),
  _DefaultRule(
      'New route is added below the top',
      'markForAdd — appears instantly (it would be hidden anyway)'),
  _DefaultRule(
      'Existing route is removed from the top',
      'markForPop — plays the pop animation'),
  _DefaultRule(
      'Existing route is removed from below',
      'markForComplete — disappears instantly'),
  _DefaultRule(
      'Route is already present and stays',
      'No mark needed — route remains as-is'),
];

const _kPractices = <String, String>{
  'DefaultTransitionDelegate covers most cases':
      'Before writing a custom delegate, verify that '
      'DefaultTransitionDelegate does not already do what you need. '
      'It handles push/pop animations correctly for typical navigation.',
  'Custom delegates are rare but powerful':
      'Use a custom TransitionDelegate when you need: instant navigation '
      '(no animations), staggered transitions, or conditional animation '
      'logic based on route metadata.',
  'resolve() must mark every record':
      'Every RouteTransitionRecord passed to resolve() must be marked '
      'with exactly one markFor* call. Failing to mark a record will '
      'throw an assertion error.',
  'Test with declarative Navigator (pages API)':
      'TransitionDelegate only applies to the Navigator 2.0 pages API. '
      'Imperative push()/pop() calls bypass the delegate entirely.',
  'Keep resolve() logic simple':
      'The resolve() method runs synchronously on the main thread. '
      'Avoid expensive computation — just inspect and mark.',
};

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kVioletDark, _kAmberDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
          blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5,
          color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kViolet, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('TransitionDelegate deep visual demo');
  print('─' * 48);
  print('Sections: overview, default behavior, markFor methods, resolve,');
  print('default transitions, instant delegate, staggered, best practices.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kViolet, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoScaffold(),
  );
}

class _DemoScaffold extends StatefulWidget {
  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransitionDelegate'),
        backgroundColor: _kVioletDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _DefaultDemoPage(), _CustomDemoPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kVioletDark,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Default'),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: 'Custom'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Theory
// ═══════════════════════════════════════════════════════════
class _TheoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        _sectionHeader('1 · What Is TransitionDelegate?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('NAVIGATOR PAGES API USAGE'),
              SizedBox(height: 8),
              _mono('Navigator('),
              _mono('  transitionDelegate:'),
              _mono('    MyTransitionDelegate(),'),
              _mono('  pages: ['),
              _mono('    MaterialPage(child: HomeScreen()),'),
              _mono('    if (showDetail)'),
              _mono('      MaterialPage(child: DetailScreen()),'),
              _mono('  ],'),
              _mono(')'),
              SizedBox(height: 8),
              _bullet('TransitionDelegate only works with the pages API.'),
              _bullet('Imperative push()/pop() uses its own animation logic.'),
              _bullet('The delegate is called whenever the pages list changes.'),
            ],
          ),
        ),

        SizedBox(height: 12),
        _sectionHeader('2 · markFor* Methods', Icons.label_outline),
        SizedBox(height: 8),
        ..._kMarkMethods.map((m) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kVioletLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(m.name,
                    style: TextStyle(fontFamily: 'monospace',
                        fontWeight: FontWeight.w700, fontSize: 12,
                        color: _kVioletDark)),
              ),
              SizedBox(height: 4),
              Text(m.description,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark,
                      height: 1.35)),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kAmberLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(m.effect,
                    style: TextStyle(fontSize: 11.5, color: _kTextDark,
                        height: 1.3)),
              ),
            ],
          ),
        )),

        SizedBox(height: 12),
        _sectionHeader('3 · DefaultTransitionDelegate Rules',
            Icons.rule_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('HOW THE DEFAULT DELEGATE DECIDES'),
              SizedBox(height: 8),
              ..._kDefaultRules.map((r) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      width: 6, height: 6,
                      decoration: BoxDecoration(
                        color: _kAmberDark, shape: BoxShape.circle),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.scenario,
                              style: TextStyle(fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: _kTextDark)),
                          Text(r.action,
                              style: TextStyle(fontSize: 11.5,
                                  fontStyle: FontStyle.italic,
                                  color: _kViolet)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),

        SizedBox(height: 12),
        _sectionHeader('4 · resolve() Contract', Icons.gavel),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('RESOLVE METHOD SIGNATURE'),
              SizedBox(height: 8),
              _mono('Iterable<RouteTransitionRecord>'),
              _mono('  resolve({'),
              _mono('    required List<RouteTransitionRecord>'),
              _mono('      newPageRouteHistory,'),
              _mono('    required Map<RouteTransitionRecord,'),
              _mono('      RouteTransitionRecord>'),
              _mono('      locationToExitingPageRoute,'),
              _mono('    required Map<RouteTransitionRecord,'),
              _mono('      List<RouteTransitionRecord>>'),
              _mono('      pageRouteToPagelessRoutes,'),
              _mono('  })'),
              SizedBox(height: 8),
              _bullet('newPageRouteHistory: the new routes, in order.'),
              _bullet('locationToExitingPageRoute: routes being removed, '
                  'keyed by the route that replaces them.'),
              _bullet('pageRouteToPagelessRoutes: pageless routes '
                  '(like dialogs) attached to each page route.'),
              _bullet('Return: the final ordered list of all records.'),
            ],
          ),
        ),

        SizedBox(height: 12),
        _sectionHeader('8 · Best Practices', Icons.lightbulb_outlined),
        SizedBox(height: 8),
        ..._kPractices.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kAmber, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(e.key,
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 13, color: _kVioletDark)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(e.value,
                    style: TextStyle(fontSize: 12.5, color: _kTextDark,
                        height: 1.35)),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Default transitions (page stack demo)
// ═══════════════════════════════════════════════════════════
class _DefaultDemoPage extends StatefulWidget {
  @override
  State<_DefaultDemoPage> createState() => _DefaultDemoPageState();
}

class _DefaultDemoPageState extends State<_DefaultDemoPage> {
  final _pages = <_PageInfo>[
    _PageInfo(id: 1, title: 'Home', color: Color(0xFFE8F5E9)),
  ];
  int _nextId = 2;
  final _log = <String>[];

  static const _kPageColors = <Color>[
    Color(0xFFE3F2FD), Color(0xFFFFF3E0), Color(0xFFFCE4EC),
    Color(0xFFEDE7F6), Color(0xFFFFFDE7), Color(0xFFE0F7FA),
  ];

  void _pushPage() {
    final color = _kPageColors[(_pages.length - 1) % _kPageColors.length];
    setState(() {
      _pages.add(_PageInfo(
          id: _nextId, title: 'Page $_nextId', color: color));
      _log.insert(0, 'Push: Page $_nextId (markForPush → animate in)');
      _nextId++;
    });
  }

  void _popPage() {
    if (_pages.length <= 1) return;
    final removed = _pages.last;
    setState(() {
      _pages.removeLast();
      _log.insert(0, 'Pop: ${removed.title} (markForPop → animate out)');
    });
  }

  void _resetToHome() {
    if (_pages.length <= 1) return;
    final count = _pages.length - 1;
    setState(() {
      _pages.removeRange(1, _pages.length);
      _log.insert(0, 'Reset: removed $count pages (markForComplete → instant)');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          color: _kVioletDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DEFAULT TRANSITION DELEGATE',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('Push and pop pages to observe standard transitions. '
                  'DefaultTransitionDelegate animates the top route and '
                  'instantly handles lower routes.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
              SizedBox(height: 8),
              Row(
                children: [
                  _navButton('Push', Icons.add, _pushPage),
                  SizedBox(width: 6),
                  _navButton('Pop', Icons.remove,
                      _pages.length > 1 ? _popPage : null),
                  SizedBox(width: 6),
                  _navButton('Reset', Icons.home,
                      _pages.length > 1 ? _resetToHome : null),
                ],
              ),
            ],
          ),
        ),
        // Page stack visualization
        Expanded(
          child: Row(
            children: [
              // Stack visual
              Expanded(
                flex: 3,
                child: _PageStackNavigator(
                  pages: _pages,
                  useDefault: true,
                ),
              ),
              // Log
              Expanded(
                flex: 2,
                child: Container(
                  color: _kVioletLight.withOpacity(0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        color: _kVioletLight.withOpacity(0.5),
                        child: Text('EVENT LOG',
                            style: TextStyle(fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: _kTextMuted, letterSpacing: 0.5)),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(6),
                          itemCount: _log.length,
                          itemBuilder: (context, i) => Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Text(_log[i],
                                style: TextStyle(fontFamily: 'monospace',
                                    fontSize: 9.5, color: _kTextDark,
                                    height: 1.3)),
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
      ],
    );
  }

  Widget _navButton(String label, IconData icon, VoidCallback? onTap) {
    final enabled = onTap != null;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: enabled
                ? _kAmber.withOpacity(0.25)
                : Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: enabled ? _kAmber : Colors.white24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: enabled ? _kAmber : Colors.white30, size: 14),
              SizedBox(width: 4),
              Text(label,
                  style: TextStyle(
                      color: enabled ? Colors.white : Colors.white30,
                      fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageInfo {
  const _PageInfo(
      {required this.id, required this.title, required this.color});
  final int id;
  final String title;
  final Color color;
}

// ─── Page stack navigator component ─────────────────────────
class _PageStackNavigator extends StatelessWidget {
  const _PageStackNavigator({required this.pages, required this.useDefault});
  final List<_PageInfo> pages;
  final bool useDefault;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      transitionDelegate: useDefault
          ? DefaultTransitionDelegate<dynamic>()
          : _InstantTransitionDelegate(),
      pages: pages
          .map((p) => MaterialPage(
                key: ValueKey(p.id),
                child: _PageContent(info: p, depth: pages.indexOf(p)),
              ))
          .toList(),
      onDidRemovePage: (_) {},
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({required this.info, required this.depth});
  final _PageInfo info;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: info.color,
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                color: _kViolet.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: _kViolet, width: 2),
              ),
              alignment: Alignment.center,
              child: Text('${info.id}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900,
                      color: _kVioletDark)),
            ),
            SizedBox(height: 12),
            Text(info.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,
                    color: _kTextDark)),
            SizedBox(height: 4),
            Text('Stack depth: $depth',
                style: TextStyle(fontSize: 12, color: _kTextMuted)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                  depth == 0
                      ? 'Root page (always present)'
                      : 'Pushed via pages API',
                  style: TextStyle(fontSize: 11, color: _kTextMuted)),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3: Custom delegates
// ═══════════════════════════════════════════════════════════
class _CustomDemoPage extends StatefulWidget {
  @override
  State<_CustomDemoPage> createState() => _CustomDemoPageState();
}

class _CustomDemoPageState extends State<_CustomDemoPage> {
  final _pages = <_PageInfo>[
    _PageInfo(id: 1, title: 'Home', color: Color(0xFFE8F5E9)),
  ];
  int _nextId = 2;
  bool _useInstant = true;

  static const _kPageColors = <Color>[
    Color(0xFFE3F2FD), Color(0xFFFFF3E0), Color(0xFFFCE4EC),
    Color(0xFFEDE7F6), Color(0xFFFFFDE7), Color(0xFFE0F7FA),
  ];

  void _pushPage() {
    final color = _kPageColors[(_pages.length - 1) % _kPageColors.length];
    setState(() {
      _pages.add(_PageInfo(
          id: _nextId, title: 'Page $_nextId', color: color));
      _nextId++;
    });
  }

  void _popPage() {
    if (_pages.length > 1) {
      setState(() => _pages.removeLast());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          color: _kVioletDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CUSTOM TRANSITION DELEGATES',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('Switch between Instant (markForAdd/markForComplete) and '
                  'Default (markForPush/markForPop) to see the difference.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
              SizedBox(height: 8),
              Row(
                children: [
                  _modeChip('Instant', _useInstant,
                      () => setState(() => _useInstant = true)),
                  SizedBox(width: 6),
                  _modeChip('Default', !_useInstant,
                      () => setState(() => _useInstant = false)),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: _pushPage,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          color: _kAmber.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _kAmber),
                        ),
                        alignment: Alignment.center,
                        child: Text('Push',
                            style: TextStyle(color: Colors.white,
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: GestureDetector(
                      onTap: _pages.length > 1 ? _popPage : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          color: _pages.length > 1
                              ? Colors.red.withOpacity(0.2)
                              : Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _pages.length > 1
                                  ? Colors.red.shade300
                                  : Colors.white24),
                        ),
                        alignment: Alignment.center,
                        child: Text('Pop',
                            style: TextStyle(
                                color: _pages.length > 1
                                    ? Colors.white : Colors.white30,
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Info bar
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: _useInstant
              ? _kAmberLight
              : _kVioletLight.withOpacity(0.4),
          child: Row(
            children: [
              Icon(_useInstant ? Icons.flash_on : Icons.slow_motion_video,
                  size: 14,
                  color: _useInstant ? _kAmberDark : _kViolet),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                    _useInstant
                        ? 'InstantTransitionDelegate: markForAdd/markForComplete — no animations'
                        : 'DefaultTransitionDelegate: markForPush/markForPop — standard animations',
                    style: TextStyle(fontSize: 10.5,
                        color: _kTextDark, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        Expanded(
          child: _PageStackNavigator(
            pages: _pages,
            useDefault: !_useInstant,
          ),
        ),
        // Code comparison
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label(_useInstant
                  ? 'INSTANT DELEGATE (NO ANIMATION)'
                  : 'DEFAULT DELEGATE (STANDARD ANIMATION)'),
              SizedBox(height: 8),
              if (_useInstant) ...[
                _mono('class InstantTransitionDelegate'),
                _mono('    extends TransitionDelegate {'),
                _mono('  Iterable<RouteTransitionRecord>'),
                _mono('    resolve({...}) {'),
                _mono('    for (final r in newPageRouteHistory)'),
                _mono('      if (r.isWaitingForEnteringDecision)'),
                _mono('        r.markForAdd();'),
                _mono('    for (final r in exitingPageRoutes)'),
                _mono('      r.markForComplete();'),
                _mono('    return [newRoutes, exitingRoutes];'),
                _mono('  }'),
                _mono('}'),
              ] else ...[
                _mono('// DefaultTransitionDelegate is built-in.'),
                _mono('// New top route → markForPush'),
                _mono('// New below route → markForAdd'),
                _mono('// Removed top route → markForPop'),
                _mono('// Removed below route → markForComplete'),
                _mono(''),
                _mono('Navigator('),
                _mono('  transitionDelegate:'),
                _mono('    DefaultTransitionDelegate(),'),
                _mono('  pages: [...],'),
                _mono(')'),
              ],
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _modeChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? _kViolet.withOpacity(0.3)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: selected ? _kViolet : Colors.white24),
        ),
        child: Text(label,
            style: TextStyle(
                color: selected ? Colors.white : Colors.white54,
                fontSize: 11, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

/// Custom TransitionDelegate that uses markForAdd/markForComplete
/// for instant transitions (no animation).
class _InstantTransitionDelegate extends TransitionDelegate<dynamic> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord>
        locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    // Mark all entering pages for instant add (no animation)
    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);

      // Handle exiting routes that were at this location
      if (locationToExitingPageRoute.containsKey(pageRoute)) {
        final exitingRoute = locationToExitingPageRoute[pageRoute]!;
        if (exitingRoute.isWaitingForExitingDecision) {
          exitingRoute.markForComplete();
        }
        results.add(exitingRoute);

        // Handle pageless routes attached to the exiting route
        if (pageRouteToPagelessRoutes.containsKey(exitingRoute)) {
          for (final pagelessRoute
              in pageRouteToPagelessRoutes[exitingRoute]!) {
            if (pagelessRoute.isWaitingForExitingDecision) {
              pagelessRoute.markForComplete();
            }
          }
        }
      }
    }

    // Handle remaining exiting routes not paired with new routes
    for (final entry in locationToExitingPageRoute.entries) {
      if (!newPageRouteHistory.contains(entry.value) &&
          !results.contains(entry.value)) {
        if (entry.value.isWaitingForExitingDecision) {
          entry.value.markForComplete();
        }
        results.add(entry.value);
      }
    }

    return results;
  }
}
