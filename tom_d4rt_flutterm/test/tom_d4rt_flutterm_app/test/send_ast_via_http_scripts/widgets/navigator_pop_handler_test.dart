import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — permitted in STATELESS demos
// ---------------------------------------------------------------------------

final ValueNotifier<List<String>> _log = ValueNotifier<List<String>>([]);
final ValueNotifier<bool> _enabled = ValueNotifier<bool>(true);
final ValueNotifier<bool> _dirty = ValueNotifier<bool>(false);
final ValueNotifier<int> _nestedFired = ValueNotifier<int>(-1);
final ValueNotifier<List<String>> _nestedLog =
    ValueNotifier<List<String>>([]);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
    ),
    home: const _NavigatorPopHandlerDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root shell with DefaultTabController
// ---------------------------------------------------------------------------

class _NavigatorPopHandlerDemo extends StatelessWidget {
  const _NavigatorPopHandlerDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(icon: Icon(Icons.star), text: 'Hero'),
    Tab(icon: Icon(Icons.touch_app), text: 'Live'),
    Tab(icon: Icon(Icons.toggle_on), text: 'Toggle'),
    Tab(icon: Icon(Icons.layers), text: 'Nested'),
    Tab(icon: Icon(Icons.edit_note), text: 'Form'),
    Tab(icon: Icon(Icons.account_tree), text: 'Diagram'),
    Tab(icon: Icon(Icons.compare_arrows), text: 'Compare'),
    Tab(icon: Icon(Icons.code), text: 'Snippet'),
    Tab(icon: Icon(Icons.warning_amber), text: 'Pitfalls'),
    Tab(icon: Icon(Icons.menu_book), text: 'API'),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          title: const Text(
            'NavigatorPopHandler',
            style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.4),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: cs.onPrimary,
            unselectedLabelColor: cs.onPrimary.withAlpha(153),
            indicatorColor: cs.onPrimary,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _LiveInterceptionTab(),
            _EnabledToggleTab(),
            _NestedHandlersTab(),
            _FormProtectionTab(),
            _DiagramTab(),
            _ComparisonTab(),
            _SnippetTab(),
            _PitfallsTab(),
            _ApiCheatSheetTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: cs.primary,
              ),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.label, {this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (color ?? cs.primaryContainer).withAlpha(200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color != null ? Colors.white : cs.onPrimaryContainer,
        ),
      ),
    );
  }
}

Widget _monoBox(BuildContext context, String code) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cs.outlineVariant),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        color: cs.onSurface,
        height: 1.55,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tab 1 — Hero Banner
// ---------------------------------------------------------------------------

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Gradient hero
          Container(
            height: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  cs.primary,
                  cs.tertiary,
                  cs.secondary,
                ],
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(20),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          const Text(
                            'NavigatorPopHandler',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Intercept back-navigation in Navigator 2.0 / Router apps',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: const <Widget>[
                          _HeroChip('Navigator 2.0'),
                          SizedBox(width: 8),
                          _HeroChip('Router API'),
                          SizedBox(width: 8),
                          _HeroChip('Sync callback'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // What it does
          _SectionCard(
            title: 'What is NavigatorPopHandler?',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'NavigatorPopHandler is a Flutter widget introduced to solve a specific pain point in '
                  'Navigator 2.0 (Router API) apps: intercepting the system back button or programmatic '
                  'Navigator.pop() calls in a synchronous, composable way without inheriting from '
                  'RouterDelegate.',
                  style: TextStyle(
                      fontSize: 14, color: cs.onSurface, height: 1.6),
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                  label: 'Synchronous onPop callback — no Future<bool> needed',
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                  label: 'Composable — wrap any subtree, nest freely',
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                  label: 'Works with Router / RouterDelegate navigation',
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                  label: 'enabled flag to temporarily bypass interception',
                ),
              ],
            ),
          ),

          // Navigator 2.0 context
          _SectionCard(
            title: 'Navigator 2.0 Context',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Navigator 2.0 separates page stack management from the widget tree. Apps use a '
                  'RouterDelegate that rebuilds the Navigator with a new list of Pages when state changes. '
                  'Because the back button is handled by BackButtonDispatcher (via Router), the old '
                  'WillPopScope / PopScope hooks may not integrate cleanly.',
                  style: TextStyle(
                      fontSize: 14, color: cs.onSurface, height: 1.6),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.info_outline,
                          color: cs.onSecondaryContainer, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'NavigatorPopHandler registers a BackButtonDispatcher child listener '
                          'automatically, so it slots cleanly into the Router architecture without '
                          'manual dispatcher wiring.',
                          style: TextStyle(
                            fontSize: 13,
                            color: cs.onSecondaryContainer,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Contrast with BackButtonListener
          _SectionCard(
            title: 'Contrast with BackButtonListener',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'BackButtonListener also works in Navigator 2.0 but its callback returns '
                  'Future<bool>. NavigatorPopHandler fires synchronously via onPop: VoidCallback '
                  'and does not need to signal whether the pop was consumed — it focuses purely on '
                  'intercepting, not on the result boolean.',
                  style: TextStyle(
                      fontSize: 14, color: cs.onSurface, height: 1.6),
                ),
                const SizedBox(height: 16),
                Table(
                  border: TableBorder.all(
                      color: cs.outlineVariant,
                      borderRadius: BorderRadius.circular(8)),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(3),
                  },
                  children: <TableRow>[
                    TableRow(
                      decoration: BoxDecoration(color: cs.primaryContainer),
                      children: <Widget>[
                        _TH(''),
                        _TH('NavigatorPopHandler'),
                        _TH('BackButtonListener'),
                      ],
                    ),
                    _tr('Callback type', 'VoidCallback', 'ValueGetter<Future<bool>>'),
                    _tr('Return value', 'none (void)', 'bool (consumed?)'),
                    _tr('API style', 'Synchronous', 'Asynchronous'),
                    _tr('Router 2.0', 'Yes', 'Yes'),
                    _tr('Navigator 1.0', 'No', 'Yes'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TableRow _tr(String a, String b, String c) {
  return TableRow(
    children: <Widget>[_TD(a), _TD(b), _TD(c)],
  );
}

class _TH extends StatelessWidget {
  const _TH(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: cs.onPrimaryContainer)),
    );
  }
}

class _TD extends StatelessWidget {
  const _TD(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(text,
          style: const TextStyle(fontSize: 12, height: 1.4)),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(100)),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600)),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(
      {required this.icon, required this.color, required this.label});

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 13, height: 1.45))),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 — Live pop interception
// ---------------------------------------------------------------------------

class _LiveInterceptionTab extends StatelessWidget {
  const _LiveInterceptionTab();

  void _simulatePop() {
    if (_enabled.value) {
      final List<String> updated = List<String>.from(_log.value);
      updated.add(
          '[${_timestamp()}] NavigatorPopHandler intercepted system back');
      _log.value = updated;
    } else {
      final List<String> updated = List<String>.from(_log.value);
      updated.add('[${_timestamp()}] Handler disabled — pop passed through');
      _log.value = updated;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'Live Pop Interception Demo',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'The card below is wrapped by a NavigatorPopHandler. Tapping "Simulate pop" '
                  'fires the onPop callback synchronously. Each interception is logged below.',
                  style: TextStyle(fontSize: 14, color: cs.onSurface, height: 1.6),
                ),
                const SizedBox(height: 16),
                // Simulated NavigatorPopHandler widget
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: cs.primary, width: 2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: cs.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'NavigatorPopHandler',
                              style: TextStyle(
                                  color: cs.onPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _enabled,
                              builder: (BuildContext ctx, bool en, _) =>
                                  _Chip(
                                    en ? 'enabled' : 'disabled',
                                    color: en ? Colors.green : Colors.red,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Card(
                        margin: EdgeInsets.zero,
                        color: cs.secondaryContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.arrow_back,
                                  size: 40, color: cs.onSecondaryContainer),
                              const SizedBox(height: 8),
                              Text(
                                'Child Widget',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: cs.onSecondaryContainer),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'NavigatorPopHandler wraps this subtree.\n'
                                'Any back-pop destined for this Navigator\n'
                                'will fire the onPop callback instead.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: cs.onSecondaryContainer,
                                    height: 1.5),
                              ),
                              const SizedBox(height: 14),
                              FilledButton.icon(
                                onPressed: _simulatePop,
                                icon: const Icon(Icons.arrow_back_ios, size: 16),
                                label: const Text('Simulate pop'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Interception Log',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Events will appear here',
                        style: TextStyle(
                            fontSize: 13,
                            color: cs.onSurfaceVariant,
                            fontStyle: FontStyle.italic)),
                    TextButton.icon(
                      onPressed: () => _log.value = <String>[],
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text('Clear'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<List<String>>(
                  valueListenable: _log,
                  builder: (BuildContext ctx, List<String> entries, _) {
                    if (entries.isEmpty) {
                      return Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text('No events yet — tap Simulate pop',
                            style: TextStyle(
                                fontSize: 13, color: cs.onSurfaceVariant)),
                      );
                    }
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 240),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: cs.outlineVariant),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext c, int i) {
                          final String entry = entries[entries.length - 1 - i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.arrow_back,
                                    size: 13,
                                    color: entry.contains('intercepted')
                                        ? cs.primary
                                        : cs.error),
                                const SizedBox(width: 6),
                                Expanded(
                                    child: Text(entry,
                                        style:
                                            const TextStyle(fontSize: 12))),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'How onPop fires',
            child: _monoBox(
              context,
              'NavigatorPopHandler(\n'
              '  enabled: true,\n'
              '  onPop: () {\n'
              '    // Called synchronously when the system back button fires\n'
              '    // and the current Navigator canPop() == true.\n'
              '    _log.value = [..._log.value, \'intercepted\'];\n'
              '  },\n'
              '  child: MyPage(),\n'
              ')',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3 — enabled toggle
// ---------------------------------------------------------------------------

class _EnabledToggleTab extends StatelessWidget {
  const _EnabledToggleTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'enabled property',
            child: Text(
              'Setting enabled: false on NavigatorPopHandler deactivates interception entirely. '
              'Back pops pass through to the normal Navigator resolution chain, as if the handler '
              'were not present at all. This is useful for conditional protection — for example, '
              'enabling only when a form has unsaved data.',
              style: TextStyle(fontSize: 14, color: cs.onSurface, height: 1.6),
            ),
          ),
          _SectionCard(
            title: 'Toggle enabled state',
            child: Column(
              children: <Widget>[
                ValueListenableBuilder<bool>(
                  valueListenable: _enabled,
                  builder: (BuildContext ctx, bool en, _) {
                    return Column(
                      children: <Widget>[
                        SegmentedButton<bool>(
                          segments: const <ButtonSegment<bool>>[
                            ButtonSegment<bool>(
                              value: true,
                              label: Text('enabled: true'),
                              icon: Icon(Icons.lock),
                            ),
                            ButtonSegment<bool>(
                              value: false,
                              label: Text('enabled: false'),
                              icon: Icon(Icons.lock_open),
                            ),
                          ],
                          selected: <bool>{en},
                          onSelectionChanged: (Set<bool> val) =>
                              _enabled.value = val.first,
                        ),
                        const SizedBox(height: 20),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: en
                                ? cs.primaryContainer
                                : cs.errorContainer,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: en ? cs.primary : cs.error,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                en ? Icons.shield : Icons.shield_outlined,
                                size: 48,
                                color: en ? cs.primary : cs.error,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                en
                                    ? 'Handler is ACTIVE\nonPop will fire on back press'
                                    : 'Handler is BYPASSED\nPops pass through unintercepted',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: en
                                      ? cs.onPrimaryContainer
                                      : cs.onErrorContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Code — conditional enable',
            child: _monoBox(
              context,
              'ValueListenableBuilder<bool>(\n'
              '  valueListenable: _isDirty,\n'
              '  builder: (context, dirty, child) {\n'
              '    return NavigatorPopHandler(\n'
              '      enabled: dirty,   // only intercept when unsaved\n'
              '      onPop: _showDiscardDialog,\n'
              '      child: child!,\n'
              '    );\n'
              '  },\n'
              '  child: MyFormPage(),\n'
              ')',
            ),
          ),
          _SectionCard(
            title: 'Behavioral notes',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _InfoRow(
                  icon: Icons.info_outline,
                  color: cs.primary,
                  label: 'Changing enabled does not trigger a rebuild of child — it only affects '
                      'whether the BackButtonDispatcher listener is registered.',
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.info_outline,
                  color: cs.primary,
                  label: 'When enabled flips from false to true, the handler re-registers '
                      'automatically on the next build cycle.',
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.warning_amber_outlined,
                  color: Colors.orange,
                  label: 'Do not toggle enabled inside the onPop callback itself — it can cause '
                      're-entrancy issues with the BackButtonDispatcher.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 4 — Nested handlers priority
// ---------------------------------------------------------------------------

class _NestedHandlersTab extends StatelessWidget {
  const _NestedHandlersTab();

  void _fireNested(int level, String name) {
    _nestedFired.value = level;
    final List<String> updated = List<String>.from(_nestedLog.value);
    updated.add('[${_timestamp()}] Handler "$name" (level $level) fired');
    _nestedLog.value = updated;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'Nested NavigatorPopHandler priority',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'When multiple NavigatorPopHandlers are nested, the innermost handler fires '
                  'first. Each handler is independent — only the one whose Navigator canPop() '
                  'returns true at the time of the back press will receive the callback.',
                  style: TextStyle(fontSize: 14, color: cs.onSurface, height: 1.6),
                ),
                const SizedBox(height: 16),
                // Visualise 3 nested handlers
                _NestedHandlerBox(
                  level: 1,
                  name: 'Outer',
                  color: cs.primaryContainer,
                  onColor: cs.onPrimaryContainer,
                  fireNested: _fireNested,
                  child: _NestedHandlerBox(
                    level: 2,
                    name: 'Middle',
                    color: cs.secondaryContainer,
                    onColor: cs.onSecondaryContainer,
                    fireNested: _fireNested,
                    child: _NestedHandlerBox(
                      level: 3,
                      name: 'Inner',
                      color: cs.tertiaryContainer,
                      onColor: cs.onTertiaryContainer,
                      fireNested: _fireNested,
                      child: FilledButton.icon(
                        onPressed: () => _fireNested(3, 'Inner'),
                        icon: const Icon(Icons.arrow_back_ios, size: 14),
                        label: const Text('Simulate back'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Nested event log',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Innermost handler fires — tap button above',
                      style: TextStyle(
                          fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _nestedLog.value = <String>[];
                        _nestedFired.value = -1;
                      },
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text('Clear'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<List<String>>(
                  valueListenable: _nestedLog,
                  builder: (BuildContext ctx, List<String> entries, _) {
                    if (entries.isEmpty) {
                      return Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('No events yet',
                            style: TextStyle(
                                fontSize: 12, color: cs.onSurfaceVariant)),
                      );
                    }
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 180),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: cs.outlineVariant),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext c, int i) {
                          return Text(
                            entries[entries.length - 1 - i],
                            style: const TextStyle(
                                fontFamily: 'monospace', fontSize: 12),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Priority rules',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _PriorityRule('1', 'Innermost NavigatorPopHandler with enabled: true fires first.'),
                const SizedBox(height: 8),
                _PriorityRule(
                    '2',
                    'If inner handler is disabled or its Navigator canPop() == false, '
                    'the next outer handler is tried.'),
                const SizedBox(height: 8),
                _PriorityRule(
                    '3',
                    'This traversal mirrors the BackButtonDispatcher child priority chain.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NestedHandlerBox extends StatelessWidget {
  const _NestedHandlerBox({
    required this.level,
    required this.name,
    required this.color,
    required this.onColor,
    required this.fireNested,
    required this.child,
  });

  final int level;
  final String name;
  final Color color;
  final Color onColor;
  final void Function(int, String) fireNested;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withAlpha(180),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.layers, size: 14, color: onColor),
              const SizedBox(width: 4),
              Text(
                'NavigatorPopHandler — $name (L$level)',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: onColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _PriorityRule extends StatelessWidget {
  const _PriorityRule(this.number, this.text);

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: cs.primary,
            shape: BoxShape.circle,
          ),
          child: Text(number,
              style: TextStyle(
                  color: cs.onPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 10),
        Expanded(
            child:
                Text(text, style: const TextStyle(fontSize: 13, height: 1.45))),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5 — Form protection pattern
// ---------------------------------------------------------------------------

class _FormProtectionTab extends StatelessWidget {
  const _FormProtectionTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'Form protection with NavigatorPopHandler',
            child: Text(
              'A common use case: protect unsaved form data. '
              'When the user has edited fields (_dirty == true), '
              'NavigatorPopHandler intercepts the back press and shows a discard warning '
              'instead of navigating away.',
              style:
                  TextStyle(fontSize: 14, color: cs.onSurface, height: 1.6),
            ),
          ),
          _SectionCard(
            title: 'Interactive form demo',
            child: ValueListenableBuilder<bool>(
              valueListenable: _dirty,
              builder: (BuildContext ctx, bool dirty, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Form state indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: dirty ? cs.errorContainer : cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: dirty ? cs.error : cs.outlineVariant),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            dirty
                                ? Icons.edit
                                : Icons.check_circle_outline,
                            color: dirty ? cs.error : cs.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            dirty
                                ? 'Unsaved changes — NavigatorPopHandler ACTIVE'
                                : 'No unsaved changes — handler INACTIVE',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color:
                                  dirty ? cs.onErrorContainer : cs.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Simulated form fields
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => _dirty.value = true,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => _dirty.value = true,
                    ),
                    const SizedBox(height: 16),
                    // Control buttons
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _dirty.value = true,
                            icon: const Icon(Icons.edit, size: 16),
                            label: const Text('Mark dirty'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => _dirty.value = false,
                            icon: const Icon(Icons.save_outlined, size: 16),
                            label: const Text('Save (clear)'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Simulate back press
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: cs.error,
                          side: BorderSide(color: cs.error),
                        ),
                        onPressed: () {
                          if (dirty) {
                            _showDiscardWarning(ctx);
                          } else {
                            _log.value = <String>[
                              ..._log.value,
                              '[${_timestamp()}] Form: back allowed (not dirty)',
                            ];
                          }
                        },
                        icon: const Icon(Icons.arrow_back_ios, size: 14),
                        label: const Text('Simulate back press'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          if (_dirty.value)
            _SectionCard(
              title: 'Warning card (shown by onPop)',
              child: _DiscardWarningCard(),
            ),
          _SectionCard(
            title: 'Pattern code',
            child: _monoBox(
              context,
              'NavigatorPopHandler(\n'
              '  enabled: _dirty.value,\n'
              '  onPop: () {\n'
              '    // Intercept only when form is unsaved\n'
              '    showDialog(\n'
              '      context: context,\n'
              '      builder: (_) => AlertDialog(\n'
              '        title: const Text(\'Discard changes?\'),\n'
              '        actions: [\n'
              '          TextButton(\n'
              '            onPressed: () {\n'
              '              _dirty.value = false;\n'
              '              Navigator.of(context).pop();\n'
              '            },\n'
              '            child: const Text(\'Discard\'),\n'
              '          ),\n'
              '        ],\n'
              '      ),\n'
              '    );\n'
              '  },\n'
              '  child: MyFormPage(),\n'
              ')',
            ),
          ),
        ],
      ),
    );
  }

  void _showDiscardWarning(BuildContext context) {
    _log.value = <String>[
      ..._log.value,
      '[${_timestamp()}] Form: NavigatorPopHandler intercepted — showing discard warning',
    ];
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        icon: const Icon(Icons.warning_amber, size: 36, color: Colors.orange),
        title: const Text('Discard changes?'),
        content: const Text(
            'You have unsaved changes. Are you sure you want to leave?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Stay'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () {
              _dirty.value = false;
              Navigator.of(ctx).pop();
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }
}

class _DiscardWarningCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber, color: cs.error, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'NavigatorPopHandler intercepted the back press',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onErrorContainer,
                      fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'You have unsaved changes. Tap "Discard" to discard them and navigate away, '
            'or tap "Stay" to continue editing.',
            style:
                TextStyle(fontSize: 13, color: cs.onErrorContainer, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: cs.onErrorContainer,
                    side: BorderSide(color: cs.error)),
                onPressed: () {},
                child: const Text('Stay'),
              ),
              const SizedBox(width: 10),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: cs.error),
                onPressed: () => _dirty.value = false,
                child: const Text('Discard'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 6 — Diagram (CustomPainter)
// ---------------------------------------------------------------------------

class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'Pop event flow diagram',
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 340,
                  child: CustomPaint(
                    painter: _FlowDiagramPainter(cs),
                    child: const SizedBox.expand(),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: <Widget>[
                    _LegendItem(Colors.blue.shade700, 'Normal path (enabled)'),
                    _LegendItem(Colors.orange.shade700, 'Bypass path (disabled)'),
                    _LegendItem(Colors.green.shade700, 'onPop callback'),
                  ],
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Step-by-step walkthrough',
            child: Column(
              children: <Widget>[
                _DiagramStep('1', 'System back',
                    'User presses the system back button or calls Navigator.maybePop()', cs),
                const SizedBox(height: 8),
                _DiagramStep('2', 'BackButtonDispatcher',
                    'Router\'s BackButtonDispatcher receives the event and dispatches to registered children', cs),
                const SizedBox(height: 8),
                _DiagramStep('3', 'NavigatorPopHandler',
                    'The handler intercepts if enabled == true and the Navigator canPop()', cs),
                const SizedBox(height: 8),
                _DiagramStep('4a', 'onPop callback',
                    'If enabled: true → onPop() fires synchronously. Normal pop is suppressed.', cs,
                    color: Colors.green),
                const SizedBox(height: 8),
                _DiagramStep('4b', 'Pass-through',
                    'If enabled: false → event passes to the Router delegate for default navigation.', cs,
                    color: Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem(this.color, this.label);

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 16,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _DiagramStep extends StatelessWidget {
  const _DiagramStep(this.id, this.title, this.body, this.cs,
      {this.color});

  final String id;
  final String title;
  final String body;
  final ColorScheme cs;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color c = color ?? cs.primary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8)),
          child: Text(id,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: c)),
              Text(body,
                  style: const TextStyle(fontSize: 12, height: 1.45)),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlowDiagramPainter extends CustomPainter {
  const _FlowDiagramPainter(this.cs);

  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()..style = PaintingStyle.fill;
    final Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final double cx = size.width / 2;
    const double bw = 180;
    const double bh = 44;

    void drawBox(double cy, String label, Color color) {
      final RRect rr = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy), width: bw, height: bh),
        const Radius.circular(10),
      );
      boxPaint.color = color;
      canvas.drawRRect(rr, boxPaint);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: bw - 10);
      tp.paint(canvas,
          Offset(cx - tp.width / 2, cy - tp.height / 2));
    }

    void drawArrow(double y1, double y2, Color color, {double? dx}) {
      final double x = cx + (dx ?? 0);
      arrowPaint.color = color;
      canvas.drawLine(Offset(x, y1 + bh / 2), Offset(x, y2 - bh / 2),
          arrowPaint);
      final Path head = Path()
        ..moveTo(x - 7, y2 - bh / 2 - 10)
        ..lineTo(x, y2 - bh / 2)
        ..lineTo(x + 7, y2 - bh / 2 - 10);
      canvas.drawPath(
          head, arrowPaint..style = PaintingStyle.stroke);
    }

    void drawLabel(double y, String text, Color color) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
              color: color, fontSize: 10, fontWeight: FontWeight.w600),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(cx + 8, y));
    }

    final Color blue = Colors.blue.shade700;
    final Color orange = Colors.orange.shade700;
    final Color green = Colors.green.shade700;

    // Boxes
    drawBox(30, 'System Back Button', blue);
    drawBox(110, 'BackButtonDispatcher', blue);
    drawBox(190, 'NavigatorPopHandler', cs.primary);
    drawBox(270, 'onPop() callback', green);
    // Bypass target
    final RRect bypassBox = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: Offset(cx + 130, 270), width: 120, height: 40),
      const Radius.circular(8),
    );
    boxPaint.color = orange;
    canvas.drawRRect(bypassBox, boxPaint);
    final TextPainter bypassTp = TextPainter(
      text: const TextSpan(
        text: 'RouterDelegate\n(default pop)',
        style: TextStyle(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 110);
    bypassTp.paint(canvas,
        Offset(cx + 130 - bypassTp.width / 2, 270 - bypassTp.height / 2));

    // Normal arrows
    drawArrow(30, 110, blue);
    drawArrow(110, 190, blue);
    drawArrow(190, 270, green);
    drawLabel(130, 'dispatch', blue);
    drawLabel(210, 'enabled=true', green);

    // Bypass arrow from NavigatorPopHandler to RouterDelegate
    arrowPaint
      ..color = orange
      ..style = PaintingStyle.stroke;
    final Path bypass = Path()
      ..moveTo(cx + bw / 2, 190)
      ..lineTo(cx + 70, 190)
      ..lineTo(cx + 70, 270);
    canvas.drawPath(bypass, arrowPaint);
    final Path bypassHead = Path()
      ..moveTo(cx + 63, 260)
      ..lineTo(cx + 70, 270)
      ..lineTo(cx + 77, 260);
    canvas.drawPath(bypassHead, arrowPaint..style = PaintingStyle.stroke);
    drawLabel(220, 'enabled=false', orange);
  }

  @override
  bool shouldRepaint(_FlowDiagramPainter old) => false;
}

// ---------------------------------------------------------------------------
// Tab 7 — Comparison table
// ---------------------------------------------------------------------------

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'Back-navigation widget comparison',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Flutter has evolved its back-navigation interception story over time. '
                  'Each widget serves a different use case or era.',
                  style: TextStyle(
                      fontSize: 14, color: cs.onSurface, height: 1.6),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStatePropertyAll<Color>(
                        cs.primaryContainer),
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text('Feature',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cs.onPrimaryContainer))),
                      DataColumn(
                          label: Text('NavigatorPopHandler',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cs.onPrimaryContainer))),
                      DataColumn(
                          label: Text('BackButtonListener',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cs.onPrimaryContainer))),
                      DataColumn(
                          label: Text('PopScope',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cs.onPrimaryContainer))),
                      DataColumn(
                          label: Text('WillPopScope',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cs.onPrimaryContainer))),
                    ],
                    rows: <DataRow>[
                      _dRow('Callback type', 'VoidCallback', 'Future<bool>', 'onPopInvokedWithResult', 'Future<bool>'),
                      _dRow('Router 2.0', 'Yes', 'Yes', 'Partial', 'No'),
                      _dRow('Navigator 1.0', 'No', 'Yes', 'Yes', 'Yes'),
                      _dRow('Synchronous', 'Yes', 'No', 'Yes', 'No'),
                      _dRow('Deprecated', 'No', 'No', 'No', 'YES'),
                      _dRow('Nestable', 'Yes', 'Yes', 'Yes', 'Yes (buggy)'),
                      _dRow('Introduced', 'Flutter 3.14', 'Flutter 2.0', 'Flutter 3.14', 'Flutter 1.x'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'When to use which',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _WhenRow(
                  widget: 'NavigatorPopHandler',
                  when: 'You are using Router / Navigator 2.0 and need a synchronous VoidCallback '
                      'when the back button fires (e.g., form protection, analytics).',
                  recommended: true,
                ),
                const SizedBox(height: 10),
                _WhenRow(
                  widget: 'BackButtonListener',
                  when: 'You need async logic (e.g., "await shouldWeLeave()") or you are in a '
                      'mixed Navigator 1.0/2.0 setup that requires the Future<bool> contract.',
                  recommended: true,
                ),
                const SizedBox(height: 10),
                _WhenRow(
                  widget: 'PopScope',
                  when: 'You need fine-grained control with canPop and the newer '
                      'onPopInvokedWithResult callback that includes the pop result value.',
                  recommended: true,
                ),
                const SizedBox(height: 10),
                _WhenRow(
                  widget: 'WillPopScope',
                  when: 'Legacy code only — deprecated, do not use in new code.',
                  recommended: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _dRow(String a, String b, String c, String d, String e) {
    return DataRow(cells: <DataCell>[
      DataCell(Text(a,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
      DataCell(Text(b, style: const TextStyle(fontSize: 12))),
      DataCell(Text(c, style: const TextStyle(fontSize: 12))),
      DataCell(Text(d, style: const TextStyle(fontSize: 12))),
      DataCell(Text(e,
          style: TextStyle(
              fontSize: 12,
              color: e == 'YES' ? Colors.red : null,
              fontWeight: e == 'YES' ? FontWeight.w700 : null))),
    ]);
  }
}

class _WhenRow extends StatelessWidget {
  const _WhenRow(
      {required this.widget, required this.when, required this.recommended});

  final String widget;
  final String when;
  final bool recommended;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: recommended ? cs.surfaceContainerLow : cs.errorContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: recommended ? cs.outlineVariant : cs.error.withAlpha(100)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(recommended ? Icons.check_circle : Icons.cancel,
              color: recommended ? Colors.green : cs.error, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 4),
                Text(when,
                    style: const TextStyle(fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 8 — Router integration snippet
// ---------------------------------------------------------------------------

class _SnippetTab extends StatelessWidget {
  const _SnippetTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'Router-based app integration',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'NavigatorPopHandler must live inside the widget tree that is built by a '
                  'RouterDelegate. The snippet below shows the typical integration pattern '
                  'inside a RouterDelegate.build() override.',
                  style: TextStyle(
                      fontSize: 14, color: cs.onSurface, height: 1.6),
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'RouterDelegate integration',
            child: _monoBox(
              context,
              'class MyRouterDelegate extends RouterDelegate<MyRoute>\n'
              '    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoute> {\n'
              '\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return NavigatorPopHandler(\n'
              '      // Intercepts back before Navigator processes it\n'
              '      enabled: _canInterceptBack(),\n'
              '      onPop: () {\n'
              '        // Custom back logic — e.g., confirm navigation\n'
              '        _handleBack();\n'
              '      },\n'
              '      child: Navigator(\n'
              '        key: navigatorKey,\n'
              '        pages: _buildPages(),\n'
              '        onDidRemovePage: (Page<dynamic> page) {\n'
              '          _onPageRemoved(page);\n'
              '        },\n'
              '      ),\n'
              '    );\n'
              '  }\n'
              '\n'
              '  bool _canInterceptBack() {\n'
              '    // Return true only when custom interception is needed\n'
              '    return _currentRoute.requiresConfirmation;\n'
              '  }\n'
              '\n'
              '  void _handleBack() {\n'
              '    // Show dialog, trigger state change, etc.\n'
              '    notifyListeners();\n'
              '  }\n'
              '}',
            ),
          ),
          _SectionCard(
            title: 'GoRouter integration',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'With GoRouter (which uses Navigator 2.0 under the hood), wrap the '
                  'MaterialApp.router or the page shell with NavigatorPopHandler:',
                  style: TextStyle(
                      fontSize: 13, color: cs.onSurface, height: 1.5),
                ),
                const SizedBox(height: 12),
                _monoBox(
                  context,
                  '// In your shell route or top-level route builder:\n'
                  'NavigatorPopHandler(\n'
                  '  enabled: ref.watch(formDirtyProvider),\n'
                  '  onPop: () {\n'
                  '    ref.read(formControllerProvider).confirmDiscard();\n'
                  '  },\n'
                  '  child: Scaffold(\n'
                  '    body: child, // GoRouter child\n'
                  '  ),\n'
                  ')',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Key integration rules',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _InfoRow(
                  icon: Icons.rule,
                  color: cs.primary,
                  label: 'Place NavigatorPopHandler as a direct ancestor of the Navigator widget '
                      'whose pops you want to intercept.',
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.rule,
                  color: cs.primary,
                  label: 'Do NOT place it above MaterialApp — it must be inside the Router\'s '
                      'widget tree to receive BackButtonDispatcher events.',
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.rule,
                  color: cs.primary,
                  label: 'The onPop callback does not automatically call Navigator.pop(). '
                      'If you want the pop to proceed after custom logic, call it explicitly.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 9 — Pitfalls
// ---------------------------------------------------------------------------

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'Common pitfalls',
            child: Text(
              'These are the three most frequent mistakes developers make when adopting '
              'NavigatorPopHandler. Each pitfall includes the symptom, the cause, and the fix.',
              style: TextStyle(
                  fontSize: 14, color: cs.onSurface, height: 1.6),
            ),
          ),
          _PitfallCard(
            number: 1,
            color: Colors.red.shade700,
            icon: Icons.swap_horiz,
            title: 'Confusing NavigatorPopHandler with BackButtonListener',
            symptom: 'onPop never fires even though the system back button is pressed.',
            cause: 'Developer placed the widget in a plain Navigator 1.0 stack (e.g., inside '
                'Scaffold pushed with Navigator.push). NavigatorPopHandler only activates in '
                'Router / Navigator 2.0 contexts where BackButtonDispatcher dispatches events.',
            fix: 'Use BackButtonListener (returns Future<bool>) when working inside a traditional '
                'Navigator.push/pop stack. Reserve NavigatorPopHandler for Router-based navigation.',
          ),
          _PitfallCard(
            number: 2,
            color: Colors.orange.shade700,
            icon: Icons.lock_open,
            title: 'enabled is false when interception is expected',
            symptom: 'Back button navigates away even though the handler is present.',
            cause: 'The enabled property was left as false (or wired to a condition that is '
                'currently false) while the developer expects the handler to be active.',
            fix: 'Use a ValueListenableBuilder or similar reactive widget so that enabled '
                'accurately reflects your interception condition. Add a debug assertion or log '
                'to verify the value at the time of the back press.',
          ),
          _PitfallCard(
            number: 3,
            color: Colors.purple.shade700,
            icon: Icons.timer,
            title: 'Async work inside onPop',
            symptom: 'UI state is inconsistent after the back press; or the pop proceeds before '
                'the async operation completes.',
            cause: 'onPop is a VoidCallback — it is synchronous. Any async operation (e.g., '
                'await showDialog()) starts but the framework does not await it. The '
                'BackButtonDispatcher may consider the event handled before the async flow finishes.',
            fix: 'Use BackButtonListener (which returns Future<bool>) if you need to await '
                'async logic and conditionally suppress the pop. Alternatively, start the async '
                'operation in onPop but use a state flag to prevent re-entrancy.',
          ),
          _SectionCard(
            title: 'Quick reference — avoid these',
            child: _monoBox(
              context,
              '// WRONG — async work in onPop\n'
              'NavigatorPopHandler(\n'
              '  onPop: () async {            // ← VoidCallback, async ignored\n'
              '    final ok = await showDialog(...);\n'
              '    if (ok) doSomething();      // may never run cleanly\n'
              '  },\n'
              '  child: MyPage(),\n'
              ');\n'
              '\n'
              '// CORRECT — use BackButtonListener for async\n'
              'BackButtonListener(\n'
              '  onBackButtonPressed: () async {\n'
              '    final ok = await showDialog(...);\n'
              '    return ok;   // true = handled, false = pass through\n'
              '  },\n'
              '  child: MyPage(),\n'
              ');',
            ),
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.color,
    required this.icon,
    required this.title,
    required this.symptom,
    required this.cause,
    required this.fix,
  });

  final int number;
  final Color color;
  final IconData icon;
  final String title;
  final String symptom;
  final String cause;
  final String fix;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white30, shape: BoxShape.circle),
                  child: Text('$number',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14)),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _PitfallSection(Icons.bug_report_outlined, 'Symptom', symptom,
                    Colors.red),
                const SizedBox(height: 10),
                _PitfallSection(Icons.search, 'Cause', cause, Colors.orange),
                const SizedBox(height: 10),
                _PitfallSection(Icons.build_circle_outlined, 'Fix', fix,
                    Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PitfallSection extends StatelessWidget {
  const _PitfallSection(this.icon, this.label, this.text, this.color);

  final IconData icon;
  final String label;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontSize: 12, height: 1.45),
              children: <TextSpan>[
                TextSpan(
                    text: '$label: ',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: color)),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 10 — API cheat sheet
// ---------------------------------------------------------------------------

class _ApiCheatSheetTab extends StatelessWidget {
  const _ApiCheatSheetTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionCard(
            title: 'NavigatorPopHandler constructor',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _monoBox(
                  context,
                  'const NavigatorPopHandler({\n'
                  '  Key? key,\n'
                  '  VoidCallback? onPop,\n'
                  '  bool enabled = true,\n'
                  '  required Widget child,\n'
                  '})',
                ),
                const SizedBox(height: 14),
                Text(
                  'NavigatorPopHandler is a const-constructible StatefulWidget. '
                  'It registers itself as a child BackButtonDispatcher when inserted into the tree '
                  'and deregisters on dispose.',
                  style: TextStyle(
                      fontSize: 13, color: cs.onSurface, height: 1.5),
                ),
              ],
            ),
          ),
          _ApiParamCard(
            param: 'key',
            type: 'Key?',
            defaultVal: 'null',
            desc: 'Standard widget key for identity-based updates. Use a GlobalKey if you need '
                'imperative access to state.',
            optional: true,
          ),
          _ApiParamCard(
            param: 'onPop',
            type: 'VoidCallback?',
            defaultVal: 'null',
            desc: 'Called synchronously when the system back button fires and the attached Navigator '
                'canPop() returns true. Does NOT automatically call Navigator.pop() — you must '
                'do that yourself if you want the pop to proceed.',
            optional: true,
          ),
          _ApiParamCard(
            param: 'enabled',
            type: 'bool',
            defaultVal: 'true',
            desc: 'When true the handler intercepts back-navigation and fires onPop. '
                'When false the handler is transparent — pops pass through to the normal '
                'Router/BackButtonDispatcher resolution chain. Changing this value causes '
                'the handler to re-register or de-register from the BackButtonDispatcher.',
            optional: false,
          ),
          _ApiParamCard(
            param: 'child',
            type: 'Widget',
            defaultVal: 'required',
            desc: 'The subtree that the handler wraps. Typically contains a Navigator widget '
                '(or a widget tree that includes one). The child is not rebuilt when enabled '
                'changes.',
            optional: false,
          ),
          _SectionCard(
            title: 'Lifecycle summary',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _LifecycleRow('initState', 'Registers as child of nearest BackButtonDispatcher if enabled'),
                _LifecycleRow('didUpdateWidget', 'Re-registers/de-registers if enabled changed'),
                _LifecycleRow('build', 'Returns child unchanged — NavigatorPopHandler is transparent'),
                _LifecycleRow('dispose', 'Deregisters from BackButtonDispatcher'),
              ],
            ),
          ),
          _SectionCard(
            title: 'Minimum viable usage',
            child: _monoBox(
              context,
              'import \'package:flutter/material.dart\';\n'
              '\n'
              'class MyPage extends StatelessWidget {\n'
              '  const MyPage({super.key});\n'
              '\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return NavigatorPopHandler(\n'
              '      onPop: () {\n'
              '        // custom logic here\n'
              '      },\n'
              '      child: Scaffold(\n'
              '        appBar: AppBar(title: const Text(\'Page\')),\n'
              '        body: const Center(child: Text(\'content\')),\n'
              '      ),\n'
              '    );\n'
              '  }\n'
              '}',
            ),
          ),
          _SectionCard(
            title: 'Related APIs',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _RelatedApi(
                  name: 'BackButtonDispatcher',
                  desc: 'The system object that routes back-button events to child handlers.',
                  icon: Icons.settings_input_component,
                ),
                const SizedBox(height: 8),
                _RelatedApi(
                  name: 'BackButtonListener',
                  desc: 'Similar to NavigatorPopHandler but async (Future<bool>) — for Navigator 1.0.',
                  icon: Icons.hearing,
                ),
                const SizedBox(height: 8),
                _RelatedApi(
                  name: 'PopScope',
                  desc: 'Replacement for WillPopScope; provides canPop and onPopInvokedWithResult.',
                  icon: Icons.undo,
                ),
                const SizedBox(height: 8),
                _RelatedApi(
                  name: 'RouterDelegate',
                  desc: 'The delegate that manages the Navigator page stack in Navigator 2.0.',
                  icon: Icons.route,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiParamCard extends StatelessWidget {
  const _ApiParamCard({
    required this.param,
    required this.type,
    required this.defaultVal,
    required this.desc,
    required this.optional,
  });

  final String param;
  final String type;
  final String defaultVal;
  final String desc;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    param,
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: cs.onPrimaryContainer),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: cs.onSecondaryContainer),
                  ),
                ),
                const SizedBox(width: 8),
                _Chip(
                  optional ? 'optional' : 'required',
                  color: optional ? Colors.green.shade700 : cs.primary,
                ),
                const Spacer(),
                Text(
                  'default: $defaultVal',
                  style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurfaceVariant,
                      fontFamily: 'monospace'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(desc,
                style: const TextStyle(fontSize: 13, height: 1.45)),
          ],
        ),
      ),
    );
  }
}

class _LifecycleRow extends StatelessWidget {
  const _LifecycleRow(this.phase, this.description);

  final String phase;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(phase,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: cs.primary)),
          ),
          Expanded(
              child: Text(description,
                  style: const TextStyle(fontSize: 12, height: 1.4))),
        ],
      ),
    );
  }
}

class _RelatedApi extends StatelessWidget {
  const _RelatedApi(
      {required this.name, required this.desc, required this.icon});

  final String name;
  final String desc;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 18, color: cs.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13)),
              Text(desc,
                  style: const TextStyle(fontSize: 12, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Utility
// ---------------------------------------------------------------------------

String _timestamp() {
  final DateTime now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:'
      '${now.minute.toString().padLeft(2, '0')}:'
      '${now.second.toString().padLeft(2, '0')}';
}
