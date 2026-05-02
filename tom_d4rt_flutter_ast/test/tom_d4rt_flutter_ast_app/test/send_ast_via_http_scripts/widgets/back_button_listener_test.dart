// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// BackButtonListener Deep Demo
// =============================================================================
//
// BackButtonListener is a Flutter widget that registers an `onBackButtonPressed`
// callback (returning Future<bool>) on the nearest BackButtonDispatcher provided
// by the surrounding Router (typically supplied by MaterialApp / WidgetsApp).
//
// Behavior summary:
//   * On Android, the system back gesture/button triggers the dispatcher.
//   * On iOS / desktop / web, BackButtonListener responds to ROOT back actions
//     such as Router.maybePop(context); it is NOT invoked by Navigator.pop()
//     called directly from app code, and it is NOT triggered by tapping a
//     back arrow in the AppBar.
//   * Multiple BackButtonListeners stack; the LAST registered (deepest in tree)
//     fires first. The first listener whose Future resolves to `true` "handles"
//     the back press, and subsequent listeners (and the framework's default
//     route pop) are skipped.
//
//   Listener stack (registration order: outer -> middle -> inner):
//
//       +------------------------------------+
//       |  Outer BackButtonListener (A)      |
//       |  +------------------------------+  |
//       |  |  Middle BackButtonListener   |  |
//       |  |  +------------------------+  |  |
//       |  |  | Inner Listener (C)     |  |  |
//       |  |  +------------------------+  |  |
//       |  +------------------------------+  |
//       +------------------------------------+
//
//   System back press -> tries C first; if C returns false -> tries B;
//   if B returns false -> tries A; if A returns false -> framework default.
//
// Because this demo runs in an interpreter harness (not on Android), the most
// faithful "simulated back press" is `Router.maybePop(context)` which routes
// through the same BackButtonDispatcher pipeline.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== BackButtonListener Deep Demo START ===');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BackButtonListener Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: const _Root(),
  );
}

class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BackButtonListener'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _SectionIntro(),
              SizedBox(height: 16),
              _SectionSingleListener(),
              SizedBox(height: 16),
              _SectionStacked(),
              SizedBox(height: 16),
              _SectionDraftGuard(),
              SizedBox(height: 16),
              _SectionToggleable(),
              SizedBox(height: 16),
              _SectionPriority(),
              SizedBox(height: 16),
              _SectionAsync(),
              SizedBox(height: 16),
              _SectionWillPopVsBackButton(),
              SizedBox(height: 16),
              _SectionNestedNavigator(),
              SizedBox(height: 16),
              _SectionSystemVsAppBack(),
              SizedBox(height: 16),
              _SectionRecipeGallery(),
              SizedBox(height: 16),
              _SectionReferenceTable(),
              SizedBox(height: 24),
              _Footer(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Helper widgets (cards, banners, headings)
// =============================================================================

class _SectionCard extends StatelessWidget {
  final String number;
  final String title;
  final String? subtitle;
  final Widget child;
  final Color? accent;

  const _SectionCard({
    required this.number,
    required this.title,
    this.subtitle,
    required this.child,
    this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final accentColor = accent ?? cs.primary;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: accentColor.withOpacity(0.25), width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    number,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  final String text;
  const _Caption(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 12.5,
          height: 1.35,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock(this.code);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFE0E5EC),
          height: 1.35,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _LabeledBox extends StatelessWidget {
  final String label;
  final Color color;
  final Widget child;
  const _LabeledBox({
    required this.label,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// 1. INTRO SECTION
// =============================================================================

class _SectionIntro extends StatelessWidget {
  const _SectionIntro();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      number: '1',
      title: 'Intro: BackButtonListener basics',
      subtitle: 'How registration & dispatch work',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text(
            'BackButtonListener registers its onBackButtonPressed callback on '
            'the nearest BackButtonDispatcher provided by the enclosing Router '
            '(MaterialApp / WidgetsApp create one for you). Listeners stack: '
            'the deepest-registered listener fires FIRST. The first listener '
            'whose Future<bool> resolves to true claims the back press and '
            'stops propagation; otherwise it falls through, eventually to the '
            'framework default which calls Navigator.maybePop.',
            style: TextStyle(height: 1.4),
          ),
          SizedBox(height: 12),
          _StackDiagram(),
          SizedBox(height: 12),
          _PlatformNotes(),
          SizedBox(height: 12),
          _CodeBlock(
            'BackButtonListener(\n'
            '  onBackButtonPressed: () async {\n'
            '    if (canHandle) {\n'
            '      handle();\n'
            '      return true; // claim the back press\n'
            '    }\n'
            '    return false; // fall through to outer listeners / framework\n'
            '  },\n'
            '  child: subtree,\n'
            ')',
          ),
          _Caption(
            'Note: returning true here does NOT pop the route — it only tells '
            'the dispatcher "I handled it, do nothing else". Returning false '
            'lets the next listener up the tree decide.',
          ),
        ],
      ),
    );
  }
}

class _StackDiagram extends StatelessWidget {
  const _StackDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _LabeledBox(
            label: 'Outer (A) — registered first',
            color: Colors.indigo,
            child: _LabeledBox(
              label: 'Middle (B) — registered second',
              color: Colors.teal,
              child: _LabeledBox(
                label: 'Inner (C) — registered last, fires FIRST',
                color: Colors.deepOrange,
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(
                    'subtree (button, form, list, ...)',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_upward, size: 16),
              SizedBox(width: 6),
              Text(
                'Back press flows: C → B → A → framework default',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlatformNotes extends StatelessWidget {
  const _PlatformNotes();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade700, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Platform behavior',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '• Android: hardware/system back triggers BackButtonDispatcher.\n'
            '• iOS / Desktop / Web: no system back; only ROOT back actions '
            '(Router.maybePop) flow through the dispatcher.\n'
            '• Tapping AppBar back arrow calls Navigator.pop directly — it does '
            'NOT pass through BackButtonListener.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 2. SINGLE INTERCEPTING LISTENER
// =============================================================================

class _SectionSingleListener extends StatelessWidget {
  const _SectionSingleListener();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      number: '2',
      title: 'Single intercepting listener',
      subtitle: 'Always returns true — claims every back press',
      child: _SingleListenerDemo(),
    );
  }
}

class _SingleListenerDemo extends StatefulWidget {
  const _SingleListenerDemo();

  @override
  State<_SingleListenerDemo> createState() => _SingleListenerDemoState();
}

class _SingleListenerDemoState extends State<_SingleListenerDemo> {
  int _interceptCount = 0;

  Future<bool> _onBack() async {
    setState(() => _interceptCount++);
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(
      const SnackBar(
        content: Text('Back intercepted!'),
        duration: Duration(milliseconds: 1200),
      ),
    );
    print('SingleListenerDemo: back intercepted (count=$_interceptCount)');
    return true; // claim the back press
  }

  Future<void> _simulate() async {
    final handled = await _onBack();
    print('SingleListenerDemo: simulate result handled=$handled');
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: _onBack,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.shield, color: Colors.indigo),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'BackButtonListener active (returns true)',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                _Pill('claims', Colors.indigo),
              ],
            ),
            const SizedBox(height: 8),
            Text('Times intercepted: $_interceptCount'),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: _simulate,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Simulate back press'),
              ),
            ),
            const _Caption(
              'On Android the system back triggers this. Here we call the '
              'callback directly, which mirrors what the dispatcher would do.',
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 3. STACKED LISTENERS
// =============================================================================

class _SectionStacked extends StatelessWidget {
  const _SectionStacked();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      number: '3',
      title: 'Two stacked listeners',
      subtitle: 'Inner returns true → outer never fires',
      accent: Colors.teal,
      child: _StackedDemo(),
    );
  }
}

class _StackedDemo extends StatefulWidget {
  const _StackedDemo();

  @override
  State<_StackedDemo> createState() => _StackedDemoState();
}

class _StackedDemoState extends State<_StackedDemo> {
  final List<String> _log = [];

  void _logEvent(String event) {
    setState(() {
      _log.insert(0, event);
      if (_log.length > 10) _log.removeLast();
    });
    print('StackedDemo: $event');
  }

  Future<bool> _outer() async {
    _logEvent('Outer fired (returns false)');
    return false;
  }

  Future<bool> _inner() async {
    _logEvent('Inner fired (returns TRUE — stops propagation)');
    return true;
  }

  Future<void> _simulate() async {
    _logEvent('--- back press dispatched ---');
    // Simulate dispatcher: inner first, then outer if inner returned false
    final innerHandled = await _inner();
    if (!innerHandled) {
      final outerHandled = await _outer();
      _logEvent('framework default ${outerHandled ? "skipped" : "would run"}');
    } else {
      _logEvent('outer NOT called (inner claimed it)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: _outer,
      child: _LabeledBox(
        label: 'Outer listener (returns false)',
        color: Colors.indigo,
        child: BackButtonListener(
          onBackButtonPressed: _inner,
          child: _LabeledBox(
            label: 'Inner listener (returns true)',
            color: Colors.deepOrange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 4),
                ElevatedButton.icon(
                  onPressed: _simulate,
                  icon: const Icon(Icons.bolt),
                  label: const Text('Simulate back press'),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _log.isEmpty
                      ? const Center(child: Text('No events yet'))
                      : ListView(
                          children: _log
                              .map((e) => Text(
                                    e,
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 11,
                                    ),
                                  ))
                              .toList(),
                        ),
                ),
                const _Caption(
                  'Inner is registered last, so it fires first. It returns '
                  'true → propagation stops; outer never sees the back press.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 4. CONDITIONAL HANDLING — DRAFT GUARD
// =============================================================================

class _SectionDraftGuard extends StatelessWidget {
  const _SectionDraftGuard();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      number: '4',
      title: 'Conditional handling — draft guard',
      subtitle: 'Return true only when there is unsaved input',
      accent: Colors.deepPurple,
      child: _DraftGuardDemo(),
    );
  }
}

class _DraftGuardDemo extends StatefulWidget {
  const _DraftGuardDemo();

  @override
  State<_DraftGuardDemo> createState() => _DraftGuardDemoState();
}

class _DraftGuardDemoState extends State<_DraftGuardDemo> {
  final TextEditingController _ctrl = TextEditingController();
  String _lastResult = '(none)';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<bool> _onBack() async {
    if (_ctrl.text.trim().isEmpty) {
      setState(() => _lastResult = 'fall-through (no draft)');
      print('DraftGuardDemo: empty → return false');
      return false;
    }
    final discard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('Your draft will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep editing'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    if (discard == true) {
      _ctrl.clear();
      setState(() => _lastResult = 'discarded → return false (let it pop)');
      return false;
    }
    setState(() => _lastResult = 'kept editing → return true');
    return true;
  }

  Future<void> _simulate() async {
    final claimed = await _onBack();
    print('DraftGuardDemo: claimed=$claimed');
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: _onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _ctrl,
            decoration: const InputDecoration(
              labelText: 'Draft note',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.edit_note),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _simulate,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Simulate back'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Last: $_lastResult',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const _Caption(
            'Returns true only when the field has unsaved text — and only if '
            'the user chose to keep editing. Empty input falls through.',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 5. TOGGLEABLE LISTENER
// =============================================================================

class _SectionToggleable extends StatelessWidget {
  const _SectionToggleable();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      number: '5',
      title: 'Toggleable listener',
      subtitle: 'Conditionally insert BackButtonListener via ternary',
      accent: Colors.green,
      child: _ToggleableListenerDemo(),
    );
  }
}

class _ToggleableListenerDemo extends StatefulWidget {
  const _ToggleableListenerDemo();

  @override
  State<_ToggleableListenerDemo> createState() =>
      _ToggleableListenerDemoState();
}

class _ToggleableListenerDemoState extends State<_ToggleableListenerDemo> {
  bool _enabled = true;
  String _lastResult = '(none)';

  Future<bool> _onBack() async {
    setState(() => _lastResult = 'listener active → returned true');
    print('ToggleableListenerDemo: listener fired');
    return true;
  }

  Future<void> _simulate() async {
    if (_enabled) {
      final r = await _onBack();
      print('Toggleable: handled=$r');
    } else {
      setState(() => _lastResult = 'no listener → would fall through');
      print('Toggleable: no listener registered');
    }
  }

  @override
  Widget build(BuildContext context) {
    final core = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          value: _enabled,
          title: const Text('Enable BackButtonListener'),
          subtitle: Text(_enabled ? 'Listener registered' : 'Listener absent'),
          onChanged: (v) => setState(() => _enabled = v),
        ),
        ElevatedButton.icon(
          onPressed: _simulate,
          icon: const Icon(Icons.swap_horiz),
          label: const Text('Simulate back'),
        ),
        const SizedBox(height: 8),
        Text(
          'Last: $_lastResult',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );

    return _enabled
        ? BackButtonListener(
            onBackButtonPressed: _onBack,
            child: core,
          )
        : core;
  }
}

// =============================================================================
// 6. PRIORITY VIA NESTING
// =============================================================================

class _SectionPriority extends StatelessWidget {
  const _SectionPriority();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      number: '6',
      title: 'Listener priority via nesting',
      subtitle: 'Three nested listeners — pick which one claims the press',
      accent: Colors.deepOrange,
      child: _PriorityDemo(),
    );
  }
}

enum _Owner { a, b, c }

class _PriorityDemo extends StatefulWidget {
  const _PriorityDemo();

  @override
  State<_PriorityDemo> createState() => _PriorityDemoState();
}

class _PriorityDemoState extends State<_PriorityDemo> {
  _Owner _winner = _Owner.c;
  final List<String> _trace = [];

  void _logTrace(String s) {
    setState(() {
      _trace.insert(0, s);
      if (_trace.length > 12) _trace.removeLast();
    });
    print('PriorityDemo: $s');
  }

  Future<bool> _make(_Owner who) async {
    final claims = who == _winner;
    _logTrace('${_label(who)} fired → returns ${claims ? "TRUE" : "false"}');
    return claims;
  }

  String _label(_Owner o) => switch (o) {
        _Owner.a => 'A (outer)',
        _Owner.b => 'B (middle)',
        _Owner.c => 'C (inner)',
      };

  Future<void> _simulate() async {
    _trace.clear();
    _logTrace('--- back press ---');
    // Listeners fire in deepest-first order: C, B, A
    for (final who in [_Owner.c, _Owner.b, _Owner.a]) {
      final handled = await _make(who);
      if (handled) {
        _logTrace('claimed by ${_label(who)} → stop');
        return;
      }
    }
    _logTrace('framework default would pop now');
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () => _make(_Owner.a),
      child: _LabeledBox(
        label: 'A (outer) — registered first',
        color: Colors.indigo,
        child: BackButtonListener(
          onBackButtonPressed: () => _make(_Owner.b),
          child: _LabeledBox(
            label: 'B (middle) — registered second',
            color: Colors.teal,
            child: BackButtonListener(
              onBackButtonPressed: () => _make(_Owner.c),
              child: _LabeledBox(
                label: 'C (inner) — registered LAST, fires FIRST',
                color: Colors.deepOrange,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Which listener returns true?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    for (final o in _Owner.values)
                      RadioListTile<_Owner>(
                        value: o,
                        groupValue: _winner,
                        title: Text(_label(o)),
                        dense: true,
                        onChanged: (v) =>
                            setState(() => _winner = v ?? _winner),
                      ),
                    const SizedBox(height: 4),
                    ElevatedButton.icon(
                      onPressed: _simulate,
                      icon: const Icon(Icons.bolt),
                      label: const Text('Simulate back press'),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 130,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _trace.isEmpty
                          ? const Center(child: Text('No events yet'))
                          : ListView(
                              children: _trace
                                  .map((e) => Text(
                                        e,
                                        style: const TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 11,
                                        ),
                                      ))
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 7. ASYNC HANDLER
// =============================================================================

class _SectionAsync extends StatelessWidget {
  const _SectionAsync();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      number: '7',
      title: 'Async handler',
      subtitle: 'The dispatcher awaits Future<bool>',
      accent: Colors.cyan,
      child: _AsyncDemo(),
    );
  }
}

class _AsyncDemo extends StatefulWidget {
  const _AsyncDemo();

  @override
  State<_AsyncDemo> createState() => _AsyncDemoState();
}

class _AsyncDemoState extends State<_AsyncDemo> {
  bool _busy = false;
  int _runs = 0;

  Future<bool> _onBack() async {
    setState(() => _busy = true);
    print('AsyncDemo: starting 500ms async work');
    // Show a transient busy dialog — auto-dismissed below
    final navigator = Navigator.of(context, rootNavigator: true);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _BusyDialog(),
    );
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (navigator.canPop()) navigator.pop();
    if (!mounted) return false;
    setState(() {
      _busy = false;
      _runs++;
    });
    print('AsyncDemo: async work done → returning true');
    return true;
  }

  Future<void> _simulate() async {
    if (_busy) return;
    final r = await _onBack();
    print('AsyncDemo: handled=$r');
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: _onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.timelapse, color: Colors.cyan),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _busy
                      ? 'Working… framework is awaiting Future<bool>'
                      : 'Idle — async handler returns after 500ms',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _busy ? null : _simulate,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Simulate back (async)'),
          ),
          const SizedBox(height: 8),
          Text('Completed runs: $_runs'),
          const _Caption(
            'BackButtonDispatcher awaits the future. While it is pending, no '
            'further back presses are dispatched (the dispatcher serializes).',
          ),
        ],
      ),
    );
  }
}

class _BusyDialog extends StatelessWidget {
  const _BusyDialog();

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 16),
            Text('Awaiting handler...'),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 8. WillPopScope vs BackButtonListener
// =============================================================================

class _SectionWillPopVsBackButton extends StatelessWidget {
  const _SectionWillPopVsBackButton();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      number: '8',
      title: 'WillPopScope vs BackButtonListener',
      subtitle: 'Route-scoped vs widget-scoped',
      accent: Colors.brown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: _ComparisonCard(
                  title: 'WillPopScope',
                  color: Colors.brown,
                  bullets: [
                    'Scope: ROUTE (the enclosing ModalRoute)',
                    'Triggered by: Navigator pop attempts',
                    'Returns Future<bool> → block/allow pop',
                    'Older, Navigator 1.0 era',
                    'Replaced by PopScope in newer SDKs',
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ComparisonCard(
                  title: 'BackButtonListener',
                  color: Colors.indigo,
                  bullets: [
                    'Scope: WIDGET subtree',
                    'Triggered by: BackButtonDispatcher (system back)',
                    'Returns Future<bool> → claim or fall through',
                    'Works with Router (Navigator 2.0)',
                    'Stacks naturally via nesting',
                  ],
                ),
              ),
            ],
          ),
          const _Caption(
            'Rule of thumb: use WillPopScope/PopScope for "is this route safe '
            'to pop?" (entire route guard); use BackButtonListener when only '
            'a specific subtree (e.g. a panel inside a route) wants to react '
            'to the system back gesture.',
          ),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> bullets;
  const _ComparisonCard({
    required this.title,
    required this.color,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          for (final b in bullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('•  ', style: TextStyle(color: color)),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(fontSize: 12, height: 1.35),
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

// =============================================================================
// 9. NESTED NAVIGATOR
// =============================================================================

class _SectionNestedNavigator extends StatelessWidget {
  const _SectionNestedNavigator();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      number: '9',
      title: 'Multiple Navigators',
      subtitle: 'Inner navigator hijacks the back press, falls through if empty',
      accent: Colors.purple,
      child: _NestedNavDemo(),
    );
  }
}

class _NestedNavDemo extends StatefulWidget {
  const _NestedNavDemo();

  @override
  State<_NestedNavDemo> createState() => _NestedNavDemoState();
}

class _NestedNavDemoState extends State<_NestedNavDemo> {
  final GlobalKey<NavigatorState> _innerKey = GlobalKey<NavigatorState>();
  String _lastResult = '(none)';

  Future<bool> _onBack() async {
    final nav = _innerKey.currentState;
    if (nav == null) return false;
    if (nav.canPop()) {
      nav.pop();
      setState(() => _lastResult = 'inner popped → returned true');
      print('NestedNav: inner pop, claimed back');
      return true;
    }
    setState(() => _lastResult = 'inner empty → returned false (fall-through)');
    print('NestedNav: inner empty, falling through');
    return false;
  }

  Future<void> _simulate() async {
    final r = await _onBack();
    print('NestedNav: handled=$r');
  }

  void _push() {
    _innerKey.currentState?.pushNamed('/detail');
    setState(() => _lastResult = 'pushed inner /detail');
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: _onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Navigator(
                key: _innerKey,
                initialRoute: '/',
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    settings: settings,
                    builder: (ctx) {
                      switch (settings.name) {
                        case '/detail':
                          return _InnerDetailPage(
                            onPushDeeper: () =>
                                Navigator.of(ctx).pushNamed('/deeper'),
                          );
                        case '/deeper':
                          return const _InnerDeeperPage();
                        case '/':
                        default:
                          return _InnerHomePage(onPush: _push);
                      }
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _push,
                icon: const Icon(Icons.add),
                label: const Text('Push inner'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _simulate,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Simulate back'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Last: $_lastResult',
            style: const TextStyle(fontSize: 12),
          ),
          const _Caption(
            'BackButtonListener pops the inner Navigator first; only when the '
            'inner stack is empty does it return false to let the outer route '
            'handle the back press.',
          ),
        ],
      ),
    );
  }
}

class _InnerHomePage extends StatelessWidget {
  final VoidCallback onPush;
  const _InnerHomePage({required this.onPush});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.withOpacity(0.05),
      appBar: AppBar(
        title: const Text('Inner / home'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Inner navigator at root'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onPush,
              child: const Text('Push /detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InnerDetailPage extends StatelessWidget {
  final VoidCallback onPushDeeper;
  const _InnerDetailPage({required this.onPushDeeper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.withOpacity(0.08),
      appBar: AppBar(
        title: const Text('Inner / detail'),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Detail page'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onPushDeeper,
              child: const Text('Push /deeper'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InnerDeeperPage extends StatelessWidget {
  const _InnerDeeperPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.withOpacity(0.12),
      appBar: AppBar(
        title: const Text('Inner / deeper'),
        backgroundColor: Colors.purple.shade300,
      ),
      body: const Center(child: Text('Deeper page (use back to pop)')),
    );
  }
}

// =============================================================================
// 10. SYSTEM BACK vs IN-APP BACK COMPARISON
// =============================================================================

class _SectionSystemVsAppBack extends StatelessWidget {
  const _SectionSystemVsAppBack();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      number: '10',
      title: 'System back vs in-app back-button',
      subtitle: 'What does — and does not — flow through BackButtonListener',
      accent: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _BackSourceRow(
            icon: Icons.android,
            label: 'Android system back gesture/button',
            triggers: true,
            color: Colors.green,
            note: 'Always flows through BackButtonDispatcher.',
          ),
          _BackSourceRow(
            icon: Icons.swap_horiz,
            label: 'Router.maybePop(context)',
            triggers: true,
            color: Colors.green,
            note: 'Explicit root back action — flows through dispatcher.',
          ),
          _BackSourceRow(
            icon: Icons.arrow_back,
            label: 'AppBar back arrow tap',
            triggers: false,
            color: Colors.red,
            note: 'Calls Navigator.pop directly — bypasses dispatcher.',
          ),
          _BackSourceRow(
            icon: Icons.code,
            label: 'Navigator.pop(context) in app code',
            triggers: false,
            color: Colors.red,
            note: 'Direct route pop — does not invoke BackButtonListener.',
          ),
          _BackSourceRow(
            icon: Icons.swipe,
            label: 'iOS edge-swipe back',
            triggers: false,
            color: Colors.orange,
            note: 'Handled by CupertinoPageRoute interactivity, not dispatcher.',
          ),
          _BackSourceRow(
            icon: Icons.keyboard,
            label: 'Browser back button (web)',
            triggers: true,
            color: Colors.green,
            note: 'Goes through Router → dispatcher.',
          ),
          const _Caption(
            'BackButtonListener is specifically about the BackButtonDispatcher '
            'pipeline. If you want to intercept programmatic pops, use '
            'PopScope / WillPopScope on the route instead.',
          ),
        ],
      ),
    );
  }
}

class _BackSourceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool triggers;
  final Color color;
  final String note;

  const _BackSourceRow({
    required this.icon,
    required this.label,
    required this.triggers,
    required this.color,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    _Pill(triggers ? 'fires' : 'no', color),
                  ],
                ),
                Text(
                  note,
                  style: const TextStyle(fontSize: 12, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 11. RECIPE GALLERY
// =============================================================================

class _SectionRecipeGallery extends StatelessWidget {
  const _SectionRecipeGallery();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      number: '11',
      title: 'Recipe gallery',
      subtitle: 'Four working snippets',
      accent: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ConfirmOnBackRecipe(),
          SizedBox(height: 10),
          _TwoTapToExitRecipe(),
          SizedBox(height: 10),
          _InnerNavHijackRecipe(),
          SizedBox(height: 10),
          _TabBackStackRecipe(),
        ],
      ),
    );
  }
}

class _ConfirmOnBackRecipe extends StatefulWidget {
  const _ConfirmOnBackRecipe();

  @override
  State<_ConfirmOnBackRecipe> createState() => _ConfirmOnBackRecipeState();
}

class _ConfirmOnBackRecipeState extends State<_ConfirmOnBackRecipe> {
  String _status = 'idle';

  Future<bool> _onBack() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave page?'),
        content: const Text('Confirm you really want to go back.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Stay'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    final stay = ok != true;
    setState(() => _status = stay ? 'staying' : 'leaving');
    print('ConfirmOnBackRecipe: stay=$stay');
    return stay;
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeCard(
      title: 'Confirm-on-back dialog',
      child: BackButtonListener(
        onBackButtonPressed: _onBack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Status: $_status'),
            const SizedBox(height: 6),
            ElevatedButton(
              onPressed: () async {
                final r = await _onBack();
                print('ConfirmOnBackRecipe: stay=$r');
              },
              child: const Text('Simulate back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TwoTapToExitRecipe extends StatefulWidget {
  const _TwoTapToExitRecipe();

  @override
  State<_TwoTapToExitRecipe> createState() => _TwoTapToExitRecipeState();
}

class _TwoTapToExitRecipeState extends State<_TwoTapToExitRecipe> {
  DateTime? _firstTap;
  String _status = 'tap once to arm exit';

  Future<bool> _onBack() async {
    final now = DateTime.now();
    if (_firstTap == null ||
        now.difference(_firstTap!) > const Duration(seconds: 2)) {
      setState(() {
        _firstTap = now;
        _status = 'press back again within 2s to exit';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(milliseconds: 1200),
        ),
      );
      return true; // intercept first press
    }
    setState(() => _status = 'exiting (would call SystemNavigator.pop)');
    _firstTap = null;
    print('TwoTapToExit: exit');
    return false; // let it pop / exit
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeCard(
      title: 'Two-tap-to-exit',
      child: BackButtonListener(
        onBackButtonPressed: _onBack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(_status, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            ElevatedButton(
              onPressed: () async {
                final r = await _onBack();
                print('TwoTapToExit: handled=$r');
              },
              child: const Text('Simulate back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InnerNavHijackRecipe extends StatefulWidget {
  const _InnerNavHijackRecipe();

  @override
  State<_InnerNavHijackRecipe> createState() => _InnerNavHijackRecipeState();
}

class _InnerNavHijackRecipeState extends State<_InnerNavHijackRecipe> {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  Future<bool> _onBack() async {
    final nav = _key.currentState;
    if (nav != null && nav.canPop()) {
      nav.pop();
      print('InnerNavHijack: pop inner');
      return true;
    }
    print('InnerNavHijack: nothing to pop, fall through');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeCard(
      title: 'Inner navigator hijack',
      child: BackButtonListener(
        onBackButtonPressed: _onBack,
        child: Column(
          children: [
            SizedBox(
              height: 110,
              child: Navigator(
                key: _key,
                onGenerateRoute: (s) => MaterialPageRoute(
                  settings: s,
                  builder: (ctx) {
                    if (s.name == '/x') {
                      return Scaffold(
                        backgroundColor: Colors.amber.withOpacity(0.1),
                        body: const Center(child: Text('Inner /x')),
                      );
                    }
                    return Scaffold(
                      backgroundColor: Colors.amber.withOpacity(0.04),
                      body: Center(
                        child: ElevatedButton(
                          onPressed: () =>
                              Navigator.of(ctx).pushNamed('/x'),
                          child: const Text('Push /x'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 6),
            ElevatedButton(
              onPressed: () async {
                final r = await _onBack();
                print('InnerNavHijack: handled=$r');
              },
              child: const Text('Simulate back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBackStackRecipe extends StatefulWidget {
  const _TabBackStackRecipe();

  @override
  State<_TabBackStackRecipe> createState() => _TabBackStackRecipeState();
}

class _TabBackStackRecipeState extends State<_TabBackStackRecipe> {
  int _index = 0;
  final List<int> _history = [0];

  void _select(int i) {
    setState(() {
      _index = i;
      _history.add(i);
      if (_history.length > 16) _history.removeAt(0);
    });
  }

  Future<bool> _onBack() async {
    if (_history.length > 1) {
      _history.removeLast();
      setState(() => _index = _history.last);
      print('TabBackStack: pop tab → ${_history.last}');
      return true;
    }
    print('TabBackStack: only one tab in history → fall through');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Home', 'Search', 'Profile'];
    return _RecipeCard(
      title: 'Tab back-stack handler',
      child: BackButtonListener(
        onBackButtonPressed: _onBack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                for (int i = 0; i < tabs.length; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ElevatedButton(
                        onPressed: () => _select(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: i == _index
                              ? Colors.amber.shade300
                              : null,
                        ),
                        child: Text(tabs[i]),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Active: ${tabs[_index]}\n'
                'History: ${_history.map((i) => tabs[i]).join(" → ")}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 6),
            ElevatedButton(
              onPressed: () async {
                final r = await _onBack();
                print('TabBackStack: handled=$r');
              },
              child: const Text('Simulate back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _RecipeCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.06),
        border: Border.all(color: Colors.amber.shade700),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.restaurant_menu,
                  color: Colors.amber, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// 12. REFERENCE TABLE
// =============================================================================

class _SectionReferenceTable extends StatelessWidget {
  const _SectionReferenceTable();

  @override
  Widget build(BuildContext context) {
    final rows = <_RefRow>[
      _RefRow(
        name: 'BackButtonListener',
        kind: 'Widget',
        purpose:
            'Registers Future<bool> onBackButtonPressed on nearest dispatcher; '
            'widget-scoped; stacks via nesting (deepest fires first).',
      ),
      _RefRow(
        name: 'BackButtonDispatcher',
        kind: 'Service',
        purpose:
            'Object that fans out back-press intents to registered listeners. '
            'Provided by Router; RootBackButtonDispatcher hooks Android.',
      ),
      _RefRow(
        name: 'Router',
        kind: 'Widget',
        purpose:
            'Owns the BackButtonDispatcher in Navigator 2.0; coordinates app '
            'state ↔ pages. Created internally by MaterialApp.router.',
      ),
      _RefRow(
        name: 'NavigatorPopHandler',
        kind: 'Widget',
        purpose:
            'Higher-level wrapper around PopScope for nested Navigators; '
            'auto-handles "pop inner first" pattern.',
      ),
      _RefRow(
        name: 'PopScope',
        kind: 'Widget (newer API)',
        purpose:
            'Replacement for WillPopScope. Synchronous canPop + onPopInvoked '
            'callback; works with predictive-back on Android 14.',
      ),
      _RefRow(
        name: 'PopEntry',
        kind: 'Concept',
        purpose:
            'A registration in a route\'s pop-handling list (used by PopScope) '
            '— controls whether pop is permitted and reacts after invocation.',
      ),
      _RefRow(
        name: 'WillPopScope',
        kind: 'Widget (deprecated)',
        purpose:
            'Older route-scoped guard returning Future<bool>; kept for '
            'backward compatibility. Prefer PopScope.',
      ),
    ];

    return _SectionCard(
      number: '12',
      title: 'Reference table',
      subtitle: 'Related APIs at a glance',
      accent: Colors.blueGrey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _refHeader(),
                for (int i = 0; i < rows.length; i++)
                  _refRow(rows[i], i.isEven),
              ],
            ),
          ),
          const _Caption(
            'BackButtonListener is the lowest-friction primitive when only a '
            'subtree (not the whole route) cares about back. Use PopScope on '
            'the route itself when you need true pop-prevention semantics.',
          ),
        ],
      ),
    );
  }

  Widget _refHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              'API',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Kind',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              'Purpose',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _refRow(_RefRow r, bool zebra) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: zebra ? Colors.transparent : Colors.blueGrey.withOpacity(0.05),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              r.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              r.kind,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              r.purpose,
              style: const TextStyle(fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefRow {
  final String name;
  final String kind;
  final String purpose;
  const _RefRow({
    required this.name,
    required this.kind,
    required this.purpose,
  });
}

// =============================================================================
// FOOTER
// =============================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 6),
          Text(
            'BackButtonListener is the canonical way to handle the system '
            'back gesture in a widget-scoped fashion. Stack listeners via '
            'nesting; deepest fires first; first true claims the press; '
            'asynchronous handlers are awaited; combine with PopScope for '
            'route-level safety nets.',
            style: TextStyle(fontSize: 12.5, height: 1.45),
          ),
          SizedBox(height: 8),
          Text(
            'Demo end. Scroll up to revisit any section.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
