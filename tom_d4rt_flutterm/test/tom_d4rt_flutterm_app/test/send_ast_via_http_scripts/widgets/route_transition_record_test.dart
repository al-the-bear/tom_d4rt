// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RouteTransitionRecord from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFFEC407A); // Pink 400
const _kAccent = Color(0xFF64FFDA); // Teal A200
const _kSurface = Color(0xFF1B1B1B);
const _kCard = Color(0xFF282828);
const _kDimText = Color(0xFF9E9E9E);
const _kBrightText = Color(0xFFEEEEEE);
const _kEnter = Color(0xFF81C784); // Green 300
const _kExit = Color(0xFFE57373); // Red 300
const _kPush = Color(0xFF4FC3F7); // LightBlue 300
const _kAdd = Color(0xFFAED581); // LightGreen 300

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: ColorScheme.dark(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _RouteTransitionRecordDemo(),
  );
}

class _RouteTransitionRecordDemo extends StatefulWidget {
  const _RouteTransitionRecordDemo();

  @override
  State<_RouteTransitionRecordDemo> createState() =>
      _RouteTransitionRecordDemoState();
}

class _RouteTransitionRecordDemoState
    extends State<_RouteTransitionRecordDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: const Text('RouteTransitionRecord',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.gamepad), text: 'Simulator'),
            Tab(icon: Icon(Icons.integration_instructions), text: 'Delegate'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _TheoryTab(),
          _SimulatorTab(),
          _DelegateTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Theory
// ═══════════════════════════════════════════════════════════════════════════
class _TheoryTab extends StatelessWidget {
  const _TheoryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hero
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF880E4F), Color(0xFF4A148C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: const Column(
            children: [
              Icon(Icons.swap_vert_circle, color: _kAccent, size: 48),
              SizedBox(height: 12),
              Text(
                'RouteTransitionRecord',
                style: TextStyle(
                    color: _kBrightText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Abstract wrapper for routes during page transitions.\n'
                'Used by TransitionDelegate to decide enter/exit animations.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDimText, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // What is it
        _head('What Is RouteTransitionRecord?'),
        const SizedBox(height: 10),
        _tile(
          icon: Icons.layers,
          iconColor: _kPrimary,
          title: 'Route Wrapper for Transitions',
          body: 'When the Navigator\'s page list changes, the framework wraps '
              'each affected Route in a RouteTransitionRecord. The '
              'TransitionDelegate receives these records and decides how '
              'each route should enter or exit.',
        ),
        const SizedBox(height: 10),
        _tile(
          icon: Icons.visibility,
          iconColor: _kAccent,
          title: 'Abstract Contract',
          body: 'RouteTransitionRecord is abstract — you never create one. '
              'The Navigator creates concrete instances internally. Your '
              'TransitionDelegate works with the abstract interface.',
        ),
        const SizedBox(height: 20),

        // Properties
        _head('Abstract Properties'),
        const SizedBox(height: 10),
        _apiCard('route', 'Route<dynamic>',
            'The actual route this record wraps.', _kPrimary),
        const SizedBox(height: 8),
        _apiCard('isWaitingForEnteringDecision', 'bool',
            'True if this record needs an enter decision '
            '(markForPush or markForAdd).', _kEnter),
        const SizedBox(height: 8),
        _apiCard('isWaitingForExitingDecision', 'bool',
            'True if this record needs an exit decision '
            '(markForPop, markForComplete, or markForRemove).', _kExit),
        const SizedBox(height: 20),

        // Methods overview
        _head('Decision Methods'),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _methodGroup(
              'Entering',
              _kEnter,
              [
                ('markForPush()', 'Animate in'),
                ('markForAdd()', 'Add instantly'),
              ],
            ),
            const SizedBox(width: 10),
            _methodGroup(
              'Exiting',
              _kExit,
              [
                ('markForPop()', 'Animate out'),
                ('markForComplete()', 'Remove instantly'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Flow diagram
        _head('Transition Flow'),
        const SizedBox(height: 10),
        _buildTransitionFlow(),
      ],
    );
  }

  static Widget _methodGroup(
      String label, Color color, List<(String, String)> methods) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(label,
                  style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            ...methods.map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.$1,
                          style: TextStyle(
                              color: color,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600)),
                      Text(m.$2,
                          style: const TextStyle(
                              color: _kDimText, fontSize: 11)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTransitionFlow() {
    const steps = [
      ('Pages list changes', Icons.edit_note, _kDimText),
      ('Navigator creates records', Icons.note_add, _kPrimary),
      ('TransitionDelegate.resolve()', Icons.gavel, _kAccent),
      ('Enter decisions applied', Icons.login, _kEnter),
      ('Exit decisions applied', Icons.logout, _kExit),
      ('Animations play', Icons.animation, _kPush),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: steps[i].$3.withAlpha(25),
                    shape: BoxShape.circle,
                    border: Border.all(color: steps[i].$3.withAlpha(80)),
                  ),
                  child: Icon(steps[i].$2,
                      size: 16, color: steps[i].$3),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(steps[i].$1,
                      style: TextStyle(
                          color: steps[i].$3,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                ),
                Text('${i + 1}',
                    style: TextStyle(
                        color: _kDimText.withAlpha(100), fontSize: 11)),
              ],
            ),
            if (i < steps.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 16),
                height: 14,
                width: 2,
                color: steps[i].$3.withAlpha(30),
              ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Decision Simulator
// ═══════════════════════════════════════════════════════════════════════════
class _SimulatorTab extends StatefulWidget {
  const _SimulatorTab();

  @override
  State<_SimulatorTab> createState() => _SimulatorTabState();
}

enum _RouteState { pendingEnter, pendingExit, pushed, added, popped, completed }

class _SimRoute {
  final String name;
  final Color color;
  _RouteState state;

  _SimRoute(this.name, this.color, this.state);
}

class _SimulatorTabState extends State<_SimulatorTab> {
  late List<_SimRoute> _routes;
  String _log = '';

  @override
  void initState() {
    super.initState();
    _resetRoutes();
  }

  void _resetRoutes() {
    _routes = [
      _SimRoute('/home', _kPush, _RouteState.pendingEnter),
      _SimRoute('/profile', _kAdd, _RouteState.pendingEnter),
      _SimRoute('/settings', _kEnter, _RouteState.pendingExit),
      _SimRoute('/about', _kExit, _RouteState.pendingExit),
    ];
    _log = '';
  }

  void _applyDecision(_SimRoute route, _RouteState decision) {
    setState(() {
      route.state = decision;
      final action = decision.name;
      _log += '${route.name} → $action\n';
    });
  }

  bool get _allDecided => _routes.every((r) =>
      r.state != _RouteState.pendingEnter &&
      r.state != _RouteState.pendingExit);

  Color _stateColor(_RouteState s) {
    switch (s) {
      case _RouteState.pendingEnter:
        return _kEnter.withAlpha(120);
      case _RouteState.pendingExit:
        return _kExit.withAlpha(120);
      case _RouteState.pushed:
        return _kPush;
      case _RouteState.added:
        return _kAdd;
      case _RouteState.popped:
        return _kExit;
      case _RouteState.completed:
        return _kDimText;
    }
  }

  IconData _stateIcon(_RouteState s) {
    switch (s) {
      case _RouteState.pendingEnter:
        return Icons.hourglass_top;
      case _RouteState.pendingExit:
        return Icons.hourglass_bottom;
      case _RouteState.pushed:
        return Icons.arrow_forward;
      case _RouteState.added:
        return Icons.add;
      case _RouteState.popped:
        return Icons.arrow_back;
      case _RouteState.completed:
        return Icons.check;
    }
  }

  String _stateLabel(_RouteState s) {
    switch (s) {
      case _RouteState.pendingEnter:
        return 'Awaiting Enter';
      case _RouteState.pendingExit:
        return 'Awaiting Exit';
      case _RouteState.pushed:
        return 'markForPush()';
      case _RouteState.added:
        return 'markForAdd()';
      case _RouteState.popped:
        return 'markForPop()';
      case _RouteState.completed:
        return 'markForComplete()';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _head('Route Decision Simulator'),
        const SizedBox(height: 6),
        const Text(
          'Tap buttons to apply enter/exit decisions to each route record.',
          style: TextStyle(color: _kDimText, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 14),

        // Route cards
        ..._routes.map((route) => _buildRouteCard(route)),

        const SizedBox(height: 14),

        // Status bar
        if (_allDecided)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kEnter.withAlpha(15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kEnter.withAlpha(60)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: _kEnter, size: 20),
                SizedBox(width: 8),
                Text('All records resolved!',
                    style: TextStyle(
                        color: _kEnter,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),

        const SizedBox(height: 14),

        // Decision log
        if (_log.isNotEmpty) ...[
          _head('Decision Log'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPrimary.withAlpha(40)),
            ),
            child: Text(_log.trimRight(),
                style: const TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    height: 1.6)),
          ),
        ],

        const SizedBox(height: 14),

        // Reset button
        Center(
          child: ElevatedButton.icon(
            onPressed: () => setState(_resetRoutes),
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Reset'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _kPrimary.withAlpha(40),
              foregroundColor: _kPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRouteCard(_SimRoute route) {
    final isEnterPending = route.state == _RouteState.pendingEnter;
    final isExitPending = route.state == _RouteState.pendingExit;
    final isPending = isEnterPending || isExitPending;
    final color = _stateColor(route.state);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isPending ? _kCard : color.withAlpha(10),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: isPending ? color.withAlpha(60) : color.withAlpha(80),
              width: isPending ? 1 : 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withAlpha(25),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withAlpha(60)),
                  ),
                  child: Icon(_stateIcon(route.state),
                      color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(route.name,
                          style: TextStyle(
                              color: route.color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace')),
                      Text(_stateLabel(route.state),
                          style: TextStyle(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
            if (isPending) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  if (isEnterPending) ...[
                    _decisionButton(route, _RouteState.pushed,
                        'markForPush', Icons.arrow_forward, _kPush),
                    const SizedBox(width: 8),
                    _decisionButton(route, _RouteState.added,
                        'markForAdd', Icons.add, _kAdd),
                  ],
                  if (isExitPending) ...[
                    _decisionButton(route, _RouteState.popped,
                        'markForPop', Icons.arrow_back, _kExit),
                    const SizedBox(width: 8),
                    _decisionButton(route, _RouteState.completed,
                        'markForComplete', Icons.check, _kDimText),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _decisionButton(_SimRoute route, _RouteState decision,
      String label, IconData icon, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _applyDecision(route, decision),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: color.withAlpha(15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withAlpha(60)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Text(label,
                  style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — TransitionDelegate
// ═══════════════════════════════════════════════════════════════════════════
class _DelegateTab extends StatelessWidget {
  const _DelegateTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _head('TransitionDelegate.resolve()'),
        const SizedBox(height: 10),
        _tile(
          icon: Icons.gavel,
          iconColor: _kAccent,
          title: 'The Decision Maker',
          body: 'TransitionDelegate receives lists of RouteTransitionRecords '
              'and must apply a decision to every record. The resolve() method '
              'is the single override point.',
        ),
        const SizedBox(height: 20),

        // Method signature
        _head('Method Signature'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPrimary.withAlpha(40)),
          ),
          child: const Text(
            'Iterable<RouteTransitionRecord> resolve({\n'
            '  required List<RouteTransitionRecord>\n'
            '    newPageRouteHistory,\n'
            '  required Map<RouteTransitionRecord,\n'
            '    RouteTransitionRecord>\n'
            '    locationToExitingPageRoute,\n'
            '  required Map<RouteTransitionRecord,\n'
            '    List<RouteTransitionRecord>>\n'
            '    pageRouteToPagelessRoutes,\n'
            '})',
            style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 20),

        // Parameters explained
        _head('Parameters Explained'),
        const SizedBox(height: 10),
        _paramCard(
          'newPageRouteHistory',
          'The new ordered list of page routes after the update. Each record '
              'that is new will have isWaitingForEnteringDecision == true.',
          _kEnter,
        ),
        const SizedBox(height: 8),
        _paramCard(
          'locationToExitingPageRoute',
          'Maps a remaining record to the exiting record that was at its '
              'location. Exiting records have isWaitingForExitingDecision == true.',
          _kExit,
        ),
        const SizedBox(height: 8),
        _paramCard(
          'pageRouteToPagelessRoutes',
          'Maps page routes to their associated pageless routes (e.g. dialogs). '
              'When a page exits, its pageless routes must also exit.',
          _kPrimary,
        ),
        const SizedBox(height: 20),

        // DefaultTransitionDelegate
        _head('DefaultTransitionDelegate'),
        const SizedBox(height: 10),
        _tile(
          icon: Icons.auto_fix_high,
          iconColor: _kPush,
          title: 'Built-in Implementation',
          body: 'The framework provides DefaultTransitionDelegate which:\n'
              '• Calls markForPush() on all entering records\n'
              '• Calls markForPop() on all exiting records\n'
              '• This gives standard slide transitions for pages.',
        ),
        const SizedBox(height: 20),

        // Custom delegate pattern
        _head('Custom Delegate Pattern'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(40)),
          ),
          child: const Text(
            'class FadeTransitionDelegate\n'
            '    extends TransitionDelegate<dynamic> {\n'
            '\n'
            '  @override\n'
            '  Iterable<RouteTransitionRecord> resolve({\n'
            '    required newPageRouteHistory,\n'
            '    required locationToExitingPageRoute,\n'
            '    required pageRouteToPagelessRoutes,\n'
            '  }) {\n'
            '    final results = <RouteTransitionRecord>[];\n'
            '\n'
            '    for (final record\n'
            '        in newPageRouteHistory) {\n'
            '      if (record\n'
            '          .isWaitingForEnteringDecision) {\n'
            '        record.markForAdd(); // No animation\n'
            '      }\n'
            '      results.add(record);\n'
            '    }\n'
            '\n'
            '    for (final record\n'
            '        in locationToExitingPageRoute\n'
            '            .values) {\n'
            '      if (record\n'
            '          .isWaitingForExitingDecision) {\n'
            '        record.markForComplete(); // No anim\n'
            '      }\n'
            '      results.add(record);\n'
            '    }\n'
            '\n'
            '    return results;\n'
            '  }\n'
            '}',
            style: TextStyle(
                color: _kBrightText,
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 20),

        // Route types
        _head('Page vs Pageless Routes'),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _routeTypeCard(
              'Page Routes',
              'Have associated Page widgets.\n'
                  'Managed by Navigator.pages.\n'
                  'Declaratively controlled.',
              Icons.pages,
              _kPush,
            ),
            const SizedBox(width: 10),
            _routeTypeCard(
              'Pageless Routes',
              'Created imperatively.\n'
                  'Dialogs, bottom sheets.\n'
                  'Follow their page route.',
              Icons.layers_clear,
              _kPrimary,
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Key rules
        _head('Rules'),
        const SizedBox(height: 10),
        ..._buildRules(),
      ],
    );
  }

  static Widget _routeTypeCard(
      String title, String body, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(body,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: _kDimText, fontSize: 11, height: 1.4)),
          ],
        ),
      ),
    );
  }

  Widget _paramCard(String name, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace')),
          const SizedBox(height: 6),
          Text(desc,
              style: const TextStyle(
                  color: _kDimText, fontSize: 12, height: 1.4)),
        ],
      ),
    );
  }

  List<Widget> _buildRules() {
    const rules = [
      'Every entering record MUST receive markForPush() or markForAdd()',
      'Every exiting record MUST receive markForPop() or markForComplete()',
      'Unresolved records cause assertion errors',
      'markForPop() triggers the Route\'s exit animation',
      'markForAdd() skips the enter animation entirely',
      'markForComplete() can pass a result back to the popper',
    ];

    return rules.map((rule) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(Icons.circle, color: _kAccent, size: 6),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(rule,
                  style: const TextStyle(
                      color: _kDimText, fontSize: 13, height: 1.4)),
            ),
          ],
        ),
      );
    }).toList();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared Helpers
// ═══════════════════════════════════════════════════════════════════════════
Widget _head(String title) {
  return Row(
    children: [
      Container(width: 4, height: 20, color: _kAccent),
      const SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: const TextStyle(
                color: _kBrightText,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

Widget _tile({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: iconColor.withAlpha(50)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: _kBrightText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(body,
                  style: const TextStyle(
                      color: _kDimText, fontSize: 12, height: 1.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _apiCard(
    String name, String type, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(type,
              style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace')),
              const SizedBox(height: 4),
              Text(desc,
                  style: const TextStyle(
                      color: _kDimText, fontSize: 12, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}
