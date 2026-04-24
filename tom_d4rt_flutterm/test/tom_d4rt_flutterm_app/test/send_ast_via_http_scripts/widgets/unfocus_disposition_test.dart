// Deep visual demo for `UnfocusDisposition` — a Flutter framework enum that
// controls how `FocusNode.unfocus(disposition: ...)` routes focus after it
// gives up its claim. The enum has exactly two members:
//
//   * `UnfocusDisposition.scope` — focus jumps to the nearest enclosing
//     focusable scope and the scope's `focusedChild` history is cleared.
//   * `UnfocusDisposition.previouslyFocusedChild` — focus walks up to the
//     enclosing scope, then walks back down to the leaf node recorded as
//     `FocusScopeNode.focusedChild`, preserving the history.
//
// The file is authored as a d4rt AST harness script: there is no `main()`
// and no `runApp()`. The runtime drives it through a single top-level
// `build(BuildContext context)` function that returns a `MaterialApp`.
//
// Theme: stage-spotlight — black velvet background, gold picture frames,
// ruby focus halo, cream-coloured TextFields. A CustomPainter draws soft
// spotlights and arrows that show where focus travels on unfocus.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  Palette & theme tokens
// ---------------------------------------------------------------------------

const Color _kVelvet = Color(0xFF0B0A0C);
const Color _kVelvetHigh = Color(0xFF151014);
const Color _kGold = Color(0xFFE8C27A);
const Color _kGoldDim = Color(0xFF8E6B33);
const Color _kRuby = Color(0xFFB91C34);
const Color _kRubyGlow = Color(0x66B91C34);
const Color _kCream = Color(0xFFF4ECD8);
const Color _kCreamDim = Color(0xFFC9BFA8);
const Color _kSmoke = Color(0xFF2A2430);
const Color _kInk = Color(0xFF1A1520);
const Color _kTeal = Color(0xFF4FD1C5);
const Color _kAmber = Color(0xFFF5B400);

// ---------------------------------------------------------------------------
//  Entry point for the d4rt harness
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'UnfocusDisposition — Stage Spotlight',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kVelvet,
      primaryColor: _kGold,
      colorScheme: const ColorScheme.dark(
        primary: _kGold,
        secondary: _kRuby,
        surface: _kVelvetHigh,
        onPrimary: _kVelvet,
        onSecondary: _kCream,
        onSurface: _kCream,
      ),
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kCream, fontSize: 14, height: 1.45),
        titleLarge: TextStyle(
          color: _kGold,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
        titleMedium: TextStyle(
          color: _kGold,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
        labelLarge: TextStyle(
          color: _kCream,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    home: const _UdStageHome(),
  );
}

// ---------------------------------------------------------------------------
//  Home shell
// ---------------------------------------------------------------------------

class _UdStageHome extends StatefulWidget {
  const _UdStageHome();

  @override
  State<_UdStageHome> createState() => _UdStageHomeState();
}

class _UdStageHomeState extends State<_UdStageHome>
    with TickerProviderStateMixin {
  UnfocusDisposition _disposition = UnfocusDisposition.scope;
  bool _useNestedScopes = false;
  String _lastAction = 'No unfocus yet — focus a field and press a velvet button.';
  DateTime _lastActionTime = DateTime.now();

  late final FocusScopeNode _stageAScope;
  late final FocusScopeNode _stageBScope;
  late final FocusScopeNode _outerScope;

  late final List<FocusNode> _stageANodes;
  late final List<FocusNode> _stageBNodes;
  late final List<TextEditingController> _stageAControllers;
  late final List<TextEditingController> _stageBControllers;

  final List<_UdLogEntry> _journal = <_UdLogEntry>[];

  late final AnimationController _haloController;

  String _currentFocusLabel = '(none)';

  @override
  void initState() {
    super.initState();
    _stageAScope = FocusScopeNode(debugLabel: 'StageA');
    _stageBScope = FocusScopeNode(debugLabel: 'StageB');
    _outerScope = FocusScopeNode(debugLabel: 'OuterFrame');

    _stageANodes = List<FocusNode>.generate(
      4,
      (i) => FocusNode(debugLabel: 'A#${i + 1}'),
    );
    _stageBNodes = List<FocusNode>.generate(
      4,
      (i) => FocusNode(debugLabel: 'B#${i + 1}'),
    );
    _stageAControllers = List<TextEditingController>.generate(
      4,
      (i) => TextEditingController(text: 'line A-${i + 1}'),
    );
    _stageBControllers = List<TextEditingController>.generate(
      4,
      (i) => TextEditingController(text: 'line B-${i + 1}'),
    );

    for (final n in [..._stageANodes, ..._stageBNodes]) {
      n.addListener(() => _refreshFocusLabel());
    }

    _haloController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    for (final n in _stageANodes) {
      n.dispose();
    }
    for (final n in _stageBNodes) {
      n.dispose();
    }
    for (final c in _stageAControllers) {
      c.dispose();
    }
    for (final c in _stageBControllers) {
      c.dispose();
    }
    _stageAScope.dispose();
    _stageBScope.dispose();
    _outerScope.dispose();
    _haloController.dispose();
    super.dispose();
  }

  void _refreshFocusLabel() {
    String label = '(none)';
    for (int i = 0; i < _stageANodes.length; i++) {
      if (_stageANodes[i].hasFocus) {
        label = 'A#${i + 1}';
      }
    }
    for (int i = 0; i < _stageBNodes.length; i++) {
      if (_stageBNodes[i].hasFocus) {
        label = 'B#${i + 1}';
      }
    }
    if (label != _currentFocusLabel) {
      setState(() => _currentFocusLabel = label);
    }
  }

  void _logAction(String message) {
    setState(() {
      _lastAction = message;
      _lastActionTime = DateTime.now();
      _journal.insert(
        0,
        _UdLogEntry(
          timestamp: _lastActionTime,
          disposition: _disposition,
          description: message,
          focusedBefore: _currentFocusLabel,
        ),
      );
      while (_journal.length > 14) {
        _journal.removeLast();
      }
    });
  }

  void _unfocusScope(FocusScopeNode scope, UnfocusDisposition disp) {
    if (scope.focusedChild != null) {
      scope.focusedChild!.unfocus(disposition: disp);
    } else {
      // No focused child — just flip the global focus away.
      FocusManager.instance.primaryFocus?.unfocus(disposition: disp);
    }
    _logAction(
      'unfocus(${_dispShortLabel(disp)}) on ${scope.debugLabel} — '
      'previous focus was $_currentFocusLabel',
    );
  }

  String _dispShortLabel(UnfocusDisposition d) =>
      d == UnfocusDisposition.scope ? 'scope' : 'previouslyFocusedChild';

  String _dispLongLabel(UnfocusDisposition d) => d == UnfocusDisposition.scope
      ? 'UnfocusDisposition.scope'
      : 'UnfocusDisposition.previouslyFocusedChild';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kVelvet,
      body: FocusScope(
        node: _outerScope,
        child: SafeArea(
          child: CustomPaint(
            painter: const _UdSpotlightBackdropPainter(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 960;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _UdHeader(
                        disposition: _disposition,
                        onDispositionChanged: (v) =>
                            setState(() => _disposition = v),
                        useNested: _useNestedScopes,
                        onToggleNested: (v) =>
                            setState(() => _useNestedScopes = v),
                        lastAction: _lastAction,
                        lastActionTime: _lastActionTime,
                      ),
                      const SizedBox(height: 28),
                      _UdAnatomyCard(),
                      const SizedBox(height: 28),
                      _UdDispositionComparisonCard(
                        current: _disposition,
                      ),
                      const SizedBox(height: 28),
                      wide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildStageA()),
                                const SizedBox(width: 20),
                                Expanded(child: _buildStageB()),
                              ],
                            )
                          : Column(
                              children: [
                                _buildStageA(),
                                const SizedBox(height: 20),
                                _buildStageB(),
                              ],
                            ),
                      const SizedBox(height: 28),
                      _UdFocusReadoutPanel(
                        focusLabel: _currentFocusLabel,
                        disposition: _disposition,
                        dispositionLongLabel: _dispLongLabel(_disposition),
                        scopes: [_outerScope, _stageAScope, _stageBScope],
                        primaryFocus: FocusManager.instance.primaryFocus,
                      ),
                      const SizedBox(height: 28),
                      _UdTransitionDiagram(disposition: _disposition),
                      const SizedBox(height: 28),
                      _UdCompositionDemo(nested: _useNestedScopes),
                      const SizedBox(height: 28),
                      _UdTabWalkCard(
                        disposition: _disposition,
                      ),
                      const SizedBox(height: 28),
                      _UdJournalCard(entries: _journal),
                      const SizedBox(height: 28),
                      _UdEpilogueCard(),
                      const SizedBox(height: 24),
                      const _UdFooterStrip(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStageA() {
    return _UdStageFrame(
      title: 'Stage A — cathedral scope',
      subtitle: 'Four TextFields inside an independent FocusScope.',
      scopeLabel: _stageAScope.debugLabel ?? 'StageA',
      haloController: _haloController,
      child: FocusScope(
        node: _stageAScope,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < 4; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _UdSpotlightField(
                  label: 'A — field ${i + 1}',
                  controller: _stageAControllers[i],
                  focusNode: _stageANodes[i],
                  haloController: _haloController,
                ),
              ),
            const SizedBox(height: 6),
            _UdButtonRow(
              onScope: () => _unfocusScope(_stageAScope, UnfocusDisposition.scope),
              onPrev: () => _unfocusScope(
                _stageAScope,
                UnfocusDisposition.previouslyFocusedChild,
              ),
              onFocusFirst: () => _stageANodes.first.requestFocus(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageB() {
    return _UdStageFrame(
      title: 'Stage B — ballroom scope',
      subtitle: 'Mirror of Stage A. Each scope keeps its own history.',
      scopeLabel: _stageBScope.debugLabel ?? 'StageB',
      haloController: _haloController,
      child: FocusScope(
        node: _stageBScope,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < 4; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _UdSpotlightField(
                  label: 'B — field ${i + 1}',
                  controller: _stageBControllers[i],
                  focusNode: _stageBNodes[i],
                  haloController: _haloController,
                ),
              ),
            const SizedBox(height: 6),
            _UdButtonRow(
              onScope: () =>
                  _unfocusScope(_stageBScope, UnfocusDisposition.scope),
              onPrev: () => _unfocusScope(
                _stageBScope,
                UnfocusDisposition.previouslyFocusedChild,
              ),
              onFocusFirst: () => _stageBNodes.first.requestFocus(),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Header with disposition segmented control
// ---------------------------------------------------------------------------

class _UdHeader extends StatelessWidget {
  const _UdHeader({
    required this.disposition,
    required this.onDispositionChanged,
    required this.useNested,
    required this.onToggleNested,
    required this.lastAction,
    required this.lastActionTime,
  });

  final UnfocusDisposition disposition;
  final ValueChanged<UnfocusDisposition> onDispositionChanged;
  final bool useNested;
  final ValueChanged<bool> onToggleNested;
  final String lastAction;
  final DateTime lastActionTime;

  @override
  Widget build(BuildContext context) {
    final ts = lastActionTime;
    final stamp =
        '${ts.hour.toString().padLeft(2, '0')}:${ts.minute.toString().padLeft(2, '0')}:${ts.second.toString().padLeft(2, '0')}';
    return _UdGoldFrame(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.theaters_outlined, color: _kGold, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'UnfocusDisposition — Stage Spotlight',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kInk,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _kGoldDim),
                ),
                child: Text(
                  'harness: d4rt',
                  style: TextStyle(
                    color: _kGoldDim,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Pick a disposition, focus a field, then press an unfocus '
            'button. Watch where the ruby halo lands next.',
            style: TextStyle(color: _kCreamDim, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _UdDispositionSegments(
                current: disposition,
                onChanged: onDispositionChanged,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Nested scopes',
                    style: TextStyle(
                      color: _kCream,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: useNested,
                    activeTrackColor: _kRubyGlow,
                    inactiveTrackColor: _kSmoke,
                    onChanged: onToggleNested,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kInk,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kGoldDim, width: 0.6),
            ),
            child: Row(
              children: [
                const Icon(Icons.history, color: _kTeal, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    lastAction,
                    style: const TextStyle(color: _kCream, fontSize: 13),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  stamp,
                  style: const TextStyle(
                    color: _kCreamDim,
                    fontFamily: 'monospace',
                    fontSize: 12,
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

class _UdDispositionSegments extends StatelessWidget {
  const _UdDispositionSegments({
    required this.current,
    required this.onChanged,
  });

  final UnfocusDisposition current;
  final ValueChanged<UnfocusDisposition> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _kGoldDim),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segment(
            label: 'scope',
            value: UnfocusDisposition.scope,
            icon: Icons.open_in_full,
          ),
          _segment(
            label: 'previouslyFocusedChild',
            value: UnfocusDisposition.previouslyFocusedChild,
            icon: Icons.history_toggle_off,
          ),
        ],
      ),
    );
  }

  Widget _segment({
    required String label,
    required UnfocusDisposition value,
    required IconData icon,
  }) {
    final selected = current == value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _kRuby : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _kRubyGlow,
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: InkWell(
          onTap: () => onChanged(value),
          borderRadius: BorderRadius.circular(999),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: selected ? _kCream : _kGold,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected ? _kCream : _kGold,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Gold picture-frame wrapper
// ---------------------------------------------------------------------------

class _UdGoldFrame extends StatelessWidget {
  const _UdGoldFrame({
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kGold, _kGoldDim, _kGold],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          color: _kVelvetHigh,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Preamble anatomy card
// ---------------------------------------------------------------------------

class _UdAnatomyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _UdGoldFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Anatomy of UnfocusDisposition',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          const Text(
            'An enum lives in `package:flutter/src/widgets/focus_manager.dart` '
            'next to FocusNode and FocusScopeNode. It is passed to '
            '`FocusNode.unfocus(disposition: ...)` to answer a single question: '
            'after the node gives up focus, what should happen next?',
            style: TextStyle(color: _kCream, height: 1.5),
          ),
          const SizedBox(height: 14),
          _UdBullet(
            icon: Icons.keyboard_return,
            title: 'scope',
            body:
                'Move focus to the enclosing focusable scope. Clears the scope '
                'history, so the next traversal method (nextFocus, previousFocus) '
                'picks whichever node the FocusTraversalPolicy treats as first.',
          ),
          _UdBullet(
            icon: Icons.history,
            title: 'previouslyFocusedChild',
            body:
                'Walk up to the enclosing scope, then walk back down to the leaf '
                'node that was last recorded as focusedChild. If no history '
                'exists, it falls back to `scope`.',
          ),
          const SizedBox(height: 10),
          _UdCalloutPill(
            label: 'Default',
            text: 'UnfocusDisposition.scope — this is the disposition used when '
                'you call `node.unfocus()` with no arguments.',
          ),
          const SizedBox(height: 6),
          _UdCalloutPill(
            label: 'Tree rule',
            text: 'Both variants first ascend to the nearest *focusable* scope. '
                'A scope is focusable if it has `canRequestFocus == true`.',
          ),
          const SizedBox(height: 6),
          _UdCalloutPill(
            label: 'Keyboard',
            text: 'The most common reason to unfocus is to dismiss the soft '
                'keyboard; `scope` is almost always what that pattern wants.',
          ),
        ],
      ),
    );
  }
}

class _UdBullet extends StatelessWidget {
  const _UdBullet({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _kInk,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kGoldDim),
            ),
            child: Icon(icon, size: 16, color: _kGold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _kGold,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(body,
                    style:
                        const TextStyle(color: _kCream, height: 1.4, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UdCalloutPill extends StatelessWidget {
  const _UdCalloutPill({required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kGoldDim, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _kRuby,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: _kCream,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _kCream, height: 1.4, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Comparison card
// ---------------------------------------------------------------------------

class _UdDispositionComparisonCard extends StatelessWidget {
  const _UdDispositionComparisonCard({required this.current});

  final UnfocusDisposition current;

  @override
  Widget build(BuildContext context) {
    return _UdGoldFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Side-by-side comparison',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          LayoutBuilder(builder: (context, constraints) {
            final wide = constraints.maxWidth > 640;
            final left = _buildColumn(
              context,
              title: 'scope',
              highlighted: current == UnfocusDisposition.scope,
              rows: const [
                ('History', 'Cleared when the scope receives focus.'),
                ('Next tab', 'Traversal policy picks the first node.'),
                ('Keyboard', 'Dismisses the soft keyboard cleanly.'),
                ('Nesting', 'Target: the nearest focusable scope.'),
                ('Equivalent', '`node.unfocus()` — the default.'),
              ],
            );
            final right = _buildColumn(
              context,
              title: 'previouslyFocusedChild',
              highlighted: current == UnfocusDisposition.previouslyFocusedChild,
              rows: const [
                ('History', 'Preserved; walks down to the leaf focusedChild.'),
                ('Next tab', 'Starts from the previously focused node.'),
                ('Fallback', 'Acts like `scope` when no history exists.'),
                ('Nesting', 'Descends to leaf, skipping scope nodes.'),
                ('Equivalent', '`node.unfocus(disposition: previouslyFocusedChild)`.'),
              ],
            );
            return wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: left),
                      const SizedBox(width: 16),
                      Expanded(child: right),
                    ],
                  )
                : Column(
                    children: [left, const SizedBox(height: 14), right],
                  );
          }),
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context,
      {required String title,
      required bool highlighted,
      required List<(String, String)> rows}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlighted ? _kRuby : _kGoldDim,
          width: highlighted ? 1.6 : 0.8,
        ),
        boxShadow: highlighted
            ? [BoxShadow(color: _kRubyGlow, blurRadius: 18)]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                highlighted ? Icons.radio_button_checked : Icons.radio_button_off,
                color: highlighted ? _kRuby : _kGoldDim,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: highlighted ? _kRuby : _kGold,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 76,
                    child: Text(
                      row.$1,
                      style: const TextStyle(
                        color: _kTeal,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      row.$2,
                      style: const TextStyle(
                          color: _kCream, fontSize: 13, height: 1.35),
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

// ---------------------------------------------------------------------------
//  Stage frame (gold picture frame with a title bar)
// ---------------------------------------------------------------------------

class _UdStageFrame extends StatelessWidget {
  const _UdStageFrame({
    required this.title,
    required this.subtitle,
    required this.scopeLabel,
    required this.child,
    required this.haloController,
  });

  final String title;
  final String subtitle;
  final String scopeLabel;
  final Widget child;
  final AnimationController haloController;

  @override
  Widget build(BuildContext context) {
    return _UdGoldFrame(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    color: _kRuby, shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kInk,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _kGoldDim),
                ),
                child: Text(
                  'scope: $scopeLabel',
                  style: const TextStyle(
                    color: _kGold,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: _kCreamDim, fontSize: 13)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Spotlight TextField — halo + cream pad
// ---------------------------------------------------------------------------

class _UdSpotlightField extends StatefulWidget {
  const _UdSpotlightField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.haloController,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final AnimationController haloController;

  @override
  State<_UdSpotlightField> createState() => _UdSpotlightFieldState();
}

class _UdSpotlightFieldState extends State<_UdSpotlightField> {
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocus);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocus);
    super.dispose();
  }

  void _handleFocus() {
    if (widget.focusNode.hasFocus != _hasFocus) {
      setState(() => _hasFocus = widget.focusNode.hasFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.haloController,
      builder: (context, _) {
        final pulse = widget.haloController.value; // 0..1
        final haloStrength = _hasFocus ? 0.65 + pulse * 0.35 : 0.0;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: haloStrength > 0
                ? [
                    BoxShadow(
                      color: _kRuby.withValues(alpha: haloStrength),
                      blurRadius: 22 + pulse * 8,
                      spreadRadius: 1 + pulse * 1.4,
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            cursorColor: _kRuby,
            style: const TextStyle(color: _kInk, fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: _kCream,
              labelText: widget.label,
              labelStyle: const TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: _kGoldDim, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: _kGoldDim, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: _kRuby, width: 1.8),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
//  Button row — the unfocus controls
// ---------------------------------------------------------------------------

class _UdButtonRow extends StatelessWidget {
  const _UdButtonRow({
    required this.onScope,
    required this.onPrev,
    required this.onFocusFirst,
  });

  final VoidCallback onScope;
  final VoidCallback onPrev;
  final VoidCallback onFocusFirst;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        _VelvetButton(
          label: 'Unfocus (scope)',
          icon: Icons.open_in_full,
          onPressed: onScope,
          primary: true,
        ),
        _VelvetButton(
          label: 'Unfocus (previouslyFocusedChild)',
          icon: Icons.history_toggle_off,
          onPressed: onPrev,
        ),
        _VelvetButton(
          label: 'Focus first field',
          icon: Icons.first_page,
          onPressed: onFocusFirst,
          muted: true,
        ),
      ],
    );
  }
}

class _VelvetButton extends StatelessWidget {
  const _VelvetButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.primary = false,
    this.muted = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool primary;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final bg = primary
        ? _kRuby
        : muted
            ? _kSmoke
            : _kInk;
    final fg = primary ? _kCream : _kGold;
    final border = primary ? _kGold : _kGoldDim;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: border, width: 0.8),
          boxShadow: primary
              ? [BoxShadow(color: _kRubyGlow, blurRadius: 14, spreadRadius: 1)]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: fg),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Focus readout panel
// ---------------------------------------------------------------------------

class _UdFocusReadoutPanel extends StatelessWidget {
  const _UdFocusReadoutPanel({
    required this.focusLabel,
    required this.disposition,
    required this.dispositionLongLabel,
    required this.scopes,
    required this.primaryFocus,
  });

  final String focusLabel;
  final UnfocusDisposition disposition;
  final String dispositionLongLabel;
  final List<FocusScopeNode> scopes;
  final FocusNode? primaryFocus;

  String get _dispositionHint => disposition == UnfocusDisposition.scope
      ? 'Scope-level unfocus clears focusedChild history.'
      : 'History is preserved: next tab resumes from the remembered leaf.';

  @override
  Widget build(BuildContext context) {
    final chain = scopes
        .map((s) => '${s.debugLabel ?? "Scope"} ← ${s.hasFocus ? "focused" : "idle"}')
        .toList();
    return _UdGoldFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Focus readout',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          const Text(
            'Real-time view of the focus ladder. Updates whenever a TextField '
            'gains or loses focus.',
            style: TextStyle(color: _kCreamDim, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(builder: (context, constraints) {
            final wide = constraints.maxWidth > 720;
            final left = _metric(
              title: 'Currently focused',
              value: focusLabel,
              accent: _kRuby,
            );
            final mid = _metric(
              title: 'Disposition (armed)',
              value: dispositionLongLabel,
              accent: _kAmber,
            );
            final right = _metric(
              title: 'primaryFocus.debugLabel',
              value: primaryFocus?.debugLabel ?? '—',
              accent: _kTeal,
            );
            return wide
                ? Row(
                    children: [
                      Expanded(child: left),
                      const SizedBox(width: 10),
                      Expanded(child: mid),
                      const SizedBox(width: 10),
                      Expanded(child: right),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      left,
                      const SizedBox(height: 8),
                      mid,
                      const SizedBox(height: 8),
                      right,
                    ],
                  );
          }),
          const SizedBox(height: 14),
          const Text('Scope chain',
              style: TextStyle(
                  color: _kGold, fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          for (final line in chain)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '· $line',
                style: const TextStyle(
                  color: _kCream,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 10),
          Text(
            _dispositionHint,
            style: const TextStyle(color: _kCreamDim, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _metric({
    required String title,
    required String value,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.55), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                color: accent,
                fontSize: 11,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w800,
              )),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                color: _kCream,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Transition diagram — a CustomPainter showing the travel arrow
// ---------------------------------------------------------------------------

class _UdTransitionDiagram extends StatelessWidget {
  const _UdTransitionDiagram({required this.disposition});

  final UnfocusDisposition disposition;

  @override
  Widget build(BuildContext context) {
    return _UdGoldFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transition diagram',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            'Starting from a focused leaf, here is the path focus takes when you '
            'call `unfocus(disposition: ${disposition == UnfocusDisposition.scope ? "scope" : "previouslyFocusedChild"})`.',
            style: const TextStyle(
                color: _kCreamDim, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: 16 / 7,
            child: Container(
              decoration: BoxDecoration(
                color: _kInk,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kGoldDim, width: 0.6),
              ),
              child: CustomPaint(
                painter: _UdTransitionPainter(disposition: disposition),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              _UdLegendDot(color: _kRuby, label: 'Starting node'),
              SizedBox(width: 14),
              _UdLegendDot(color: _kAmber, label: 'Scope ancestor'),
              SizedBox(width: 14),
              _UdLegendDot(color: _kTeal, label: 'Landing node'),
            ],
          ),
        ],
      ),
    );
  }
}

class _UdLegendDot extends StatelessWidget {
  const _UdLegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(color: _kCream, fontSize: 12)),
      ],
    );
  }
}

class _UdTransitionPainter extends CustomPainter {
  _UdTransitionPainter({required this.disposition});

  final UnfocusDisposition disposition;

  @override
  void paint(Canvas canvas, Size size) {
    final leafY = size.height * 0.78;
    final scopeY = size.height * 0.22;
    final leafX = size.width * 0.18;
    final scopeX = size.width * 0.5;
    final landingX = disposition == UnfocusDisposition.scope
        ? size.width * 0.82
        : size.width * 0.18;
    final landingY = disposition == UnfocusDisposition.scope
        ? scopeY + 10
        : leafY;

    final linePaint = Paint()
      ..color = _kGoldDim
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Tree skeleton: leaf -> scope, scope -> landing.
    canvas.drawLine(
      Offset(leafX, leafY),
      Offset(scopeX, scopeY),
      linePaint,
    );
    canvas.drawLine(
      Offset(scopeX, scopeY),
      Offset(landingX, landingY),
      linePaint,
    );

    // Arrow along the route: leaf -> scope -> landing
    final arrowPaint = Paint()
      ..color = _kRuby
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(leafX, leafY)
      ..quadraticBezierTo(
        (leafX + scopeX) / 2,
        scopeY - 30,
        scopeX,
        scopeY,
      )
      ..quadraticBezierTo(
        (scopeX + landingX) / 2,
        landingY - 30,
        landingX,
        landingY,
      );
    canvas.drawPath(path, arrowPaint);

    // Arrowhead
    _drawArrowhead(canvas, arrowPaint, Offset(landingX, landingY),
        disposition == UnfocusDisposition.scope ? 0.2 : 2.9);

    // Nodes
    _drawNode(canvas, Offset(leafX, leafY), _kRuby, 'leaf');
    _drawNode(canvas, Offset(scopeX, scopeY), _kAmber, 'scope');
    _drawNode(canvas, Offset(landingX, landingY), _kTeal,
        disposition == UnfocusDisposition.scope
            ? 'traversal\'s first'
            : 'previously\nfocused child');

    // Caption
    final caption = disposition == UnfocusDisposition.scope
        ? 'scope: focus to enclosing scope; history cleared'
        : 'previouslyFocusedChild: walk back to the leaf from history';
    final tp = TextPainter(
      text: TextSpan(
        text: caption,
        style: const TextStyle(color: _kCreamDim, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 20);
    tp.paint(canvas, Offset(14, size.height - tp.height - 6));
  }

  void _drawArrowhead(Canvas canvas, Paint paint, Offset tip, double angle) {
    const armLen = 10.0;
    final left = tip -
        Offset(armLen * (angle.cos()), armLen * (angle.sin()))
            .rotate(0.5);
    final right = tip -
        Offset(armLen * (angle.cos()), armLen * (angle.sin()))
            .rotate(-0.5);
    final p = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(left.dx, left.dy)
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(right.dx, right.dy);
    canvas.drawPath(p, paint..strokeWidth = 2.2);
  }

  void _drawNode(Canvas canvas, Offset center, Color color, String label) {
    final glow = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, 14, glow);
    final fill = Paint()..color = color;
    canvas.drawCircle(center, 8, fill);
    final outline = Paint()
      ..color = _kCream
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(center, 8, outline);

    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(color: _kCream, fontSize: 11, height: 1.2),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 120);
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy + 14));
  }

  @override
  bool shouldRepaint(covariant _UdTransitionPainter old) =>
      old.disposition != disposition;
}

// Lightweight math helpers — the d4rt interpreter supports extension methods
// in our harness, but we inline tiny maths to stay portable.
extension _UdTrig on double {
  double cos() => _cosApprox(this);
  double sin() => _sinApprox(this);
}

double _cosApprox(double x) {
  // Rough cosine using Taylor series around 0; good enough for diagram angles.
  final nx = _normalize(x);
  final x2 = nx * nx;
  return 1 - x2 / 2 + (x2 * x2) / 24 - (x2 * x2 * x2) / 720;
}

double _sinApprox(double x) {
  final nx = _normalize(x);
  final x2 = nx * nx;
  return nx - (nx * x2) / 6 + (nx * x2 * x2) / 120;
}

double _normalize(double x) {
  const twoPi = 6.283185307179586;
  var v = x;
  while (v > 3.141592653589793) {
    v -= twoPi;
  }
  while (v < -3.141592653589793) {
    v += twoPi;
  }
  return v;
}

extension _UdOffsetRotate on Offset {
  Offset rotate(double radians) {
    final c = _cosApprox(radians);
    final s = _sinApprox(radians);
    return Offset(dx * c - dy * s, dx * s + dy * c);
  }
}

// ---------------------------------------------------------------------------
//  Composition demo — nested scopes
// ---------------------------------------------------------------------------

class _UdCompositionDemo extends StatelessWidget {
  const _UdCompositionDemo({required this.nested});

  final bool nested;

  @override
  Widget build(BuildContext context) {
    return _UdGoldFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Composition: nested vs flat scopes',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          const Text(
            'When a dialog or panel nests FocusScopes, disposition matters a lot. '
            'With `scope`, only the ancestor gets the keyboard back. With '
            '`previouslyFocusedChild`, each scope remembers where focus was and '
            'restores it on return.',
            style:
                TextStyle(color: _kCreamDim, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kInk,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kGoldDim, width: 0.6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _UdScopeTreeRow(
                  depth: 0,
                  name: nested ? 'OuterFrame' : 'RootScope',
                  role: 'enclosing scope',
                  color: _kAmber,
                ),
                if (nested)
                  _UdScopeTreeRow(
                    depth: 1,
                    name: 'DialogScope',
                    role: 'inner scope — remembered via focusedChild',
                    color: _kTeal,
                  ),
                _UdScopeTreeRow(
                  depth: nested ? 2 : 1,
                  name: 'DialogField',
                  role: 'leaf node currently focused',
                  color: _kRuby,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _UdCalloutPill(
            label: nested ? 'Nested' : 'Flat',
            text: nested
                ? 'Pressing Unfocus(scope) will snap focus up to OuterFrame. '
                    'Pressing Unfocus(previouslyFocusedChild) will walk OuterFrame → '
                    'DialogScope → DialogField again on the next interaction.'
                : 'With a single scope, both dispositions often look identical — '
                    'the difference only matters after a second focus request.',
          ),
        ],
      ),
    );
  }
}

class _UdScopeTreeRow extends StatelessWidget {
  const _UdScopeTreeRow({
    required this.depth,
    required this.name,
    required this.role,
    required this.color,
  });

  final int depth;
  final String name;
  final String role;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 18.0, top: 4, bottom: 4),
      child: Row(
        children: [
          Icon(Icons.subdirectory_arrow_right,
              color: _kGoldDim, size: depth == 0 ? 0 : 15),
          SizedBox(width: depth == 0 ? 0 : 6),
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              color: _kCream,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              role,
              style: const TextStyle(color: _kCreamDim, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Tab walk card
// ---------------------------------------------------------------------------

class _UdTabWalkCard extends StatefulWidget {
  const _UdTabWalkCard({required this.disposition});

  final UnfocusDisposition disposition;

  @override
  State<_UdTabWalkCard> createState() => _UdTabWalkCardState();
}

class _UdTabWalkCardState extends State<_UdTabWalkCard> {
  late FocusScopeNode _walkScope;
  late List<FocusNode> _walkNodes;
  late List<TextEditingController> _walkControllers;
  String _walkLog = 'Press Tab to walk. The disposition you chose governs the '
      'first landing after you unfocus below.';

  @override
  void initState() {
    super.initState();
    _walkScope = FocusScopeNode(debugLabel: 'TabWalk');
    _walkNodes = List<FocusNode>.generate(
      5,
      (i) => FocusNode(debugLabel: 'walk#${i + 1}'),
    );
    _walkControllers = List<TextEditingController>.generate(
      5,
      (i) => TextEditingController(text: 'w-${i + 1}'),
    );
  }

  @override
  void dispose() {
    for (final n in _walkNodes) {
      n.dispose();
    }
    for (final c in _walkControllers) {
      c.dispose();
    }
    _walkScope.dispose();
    super.dispose();
  }

  void _walkUnfocus() {
    final active = _walkScope.focusedChild;
    active?.unfocus(disposition: widget.disposition);
    setState(() {
      _walkLog =
          'Called unfocus(${widget.disposition == UnfocusDisposition.scope ? "scope" : "previouslyFocusedChild"}). '
          'Press Tab now to see where focus lands.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _UdGoldFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tab walk experiment',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          const Text(
            'Focus the first field, press Tab a few times, then press the '
            'Unfocus button. Pressing Tab again reveals where the traversal '
            'resumes based on your disposition choice.',
            style:
                TextStyle(color: _kCreamDim, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          FocusScope(
            node: _walkScope,
            child: Column(
              children: [
                for (int i = 0; i < _walkNodes.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _walkControllers[i],
                      focusNode: _walkNodes[i],
                      style: const TextStyle(color: _kInk, fontSize: 13),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _kCream,
                        isDense: true,
                        labelText: 'walk field ${i + 1}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: _kGoldDim, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: _kRuby, width: 1.4),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              _VelvetButton(
                label: 'Unfocus with armed disposition',
                icon: Icons.blur_on,
                onPressed: _walkUnfocus,
                primary: true,
              ),
              _VelvetButton(
                label: 'Focus walk#1',
                icon: Icons.first_page,
                onPressed: () => _walkNodes.first.requestFocus(),
                muted: true,
              ),
              _VelvetButton(
                label: 'Next (traversal)',
                icon: Icons.navigate_next,
                onPressed: () {
                  final primary = FocusManager.instance.primaryFocus;
                  primary?.nextFocus();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kInk,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kGoldDim, width: 0.5),
            ),
            child: Row(
              children: [
                const Icon(Icons.keyboard_tab, color: _kTeal, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _walkLog,
                    style: const TextStyle(color: _kCream, fontSize: 13),
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

// ---------------------------------------------------------------------------
//  Journal card
// ---------------------------------------------------------------------------

class _UdJournalCard extends StatelessWidget {
  const _UdJournalCard({required this.entries});

  final List<_UdLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return _UdGoldFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Action journal',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          const Text(
            'Every unfocus call is recorded with its disposition and the '
            'previously focused node. Scroll the list to replay the session.',
            style:
                TextStyle(color: _kCreamDim, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          if (entries.isEmpty)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kInk,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kGoldDim, width: 0.5),
              ),
              child: const Text(
                'No entries yet — focus a field and press a velvet button.',
                style: TextStyle(color: _kCreamDim, fontSize: 13),
              ),
            )
          else
            for (final entry in entries)
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _kInk,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: entry.disposition == UnfocusDisposition.scope
                        ? _kAmber.withValues(alpha: 0.55)
                        : _kTeal.withValues(alpha: 0.55),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: entry.disposition == UnfocusDisposition.scope
                            ? _kAmber
                            : _kTeal,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 70,
                      child: Text(
                        _formatTime(entry.timestamp),
                        style: const TextStyle(
                          color: _kCreamDim,
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.description,
                        style: const TextStyle(
                          color: _kCream,
                          fontSize: 13,
                          height: 1.35,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _kSmoke,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        entry.disposition == UnfocusDisposition.scope
                            ? 'scope'
                            : 'prev',
                        style: const TextStyle(
                          color: _kGold,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  String _formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:${t.second.toString().padLeft(2, '0')}';
}

class _UdLogEntry {
  _UdLogEntry({
    required this.timestamp,
    required this.disposition,
    required this.description,
    required this.focusedBefore,
  });

  final DateTime timestamp;
  final UnfocusDisposition disposition;
  final String description;
  final String focusedBefore;
}

// ---------------------------------------------------------------------------
//  Epilogue card — use cases
// ---------------------------------------------------------------------------

class _UdEpilogueCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _UdGoldFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Epilogue — patterns that use UnfocusDisposition',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _UdBullet(
            icon: Icons.keyboard_hide,
            title: 'Close-keyboard pattern',
            body:
                'Wrap the page in a GestureDetector that calls `FocusScope.of(context).unfocus()` '
                'on tap — the default `scope` disposition is ideal because it '
                'forgets which field had focus, so the next tap starts fresh.',
          ),
          _UdBullet(
            icon: Icons.article_outlined,
            title: 'Modal-return pattern',
            body:
                'When a modal closes, restoring focus to the exact triggering '
                'button uses `previouslyFocusedChild` — the outer scope kept '
                'history while the modal ran.',
          ),
          _UdBullet(
            icon: Icons.dashboard_customize_outlined,
            title: 'Multi-form panels',
            body:
                'In complex editors with multiple scopes, `previouslyFocusedChild` '
                'lets each panel "remember where you were" after a detour.',
          ),
          _UdBullet(
            icon: Icons.accessibility_new,
            title: 'Accessibility',
            body:
                'Screen readers rely on consistent focus position; choosing the '
                'right disposition prevents announcement jumps during transitions.',
          ),
          _UdBullet(
            icon: Icons.bug_report_outlined,
            title: 'Common gotcha',
            body:
                'If the nearest ancestor scope is not focusable (i.e. '
                '`canRequestFocus == false`), both dispositions walk further up. '
                'Log `scope.debugLabel` during development to verify.',
          ),
          const SizedBox(height: 10),
          _UdCalloutPill(
            label: 'Quote',
            text: '"Calling a traversal method like FocusNode.nextFocus after '
                'unfocusing will cause the FocusTraversalPolicy to pick the '
                'node it thinks should be first in the scope." — Flutter '
                'framework docs.',
          ),
          const SizedBox(height: 14),
          const _UdCheatSheet(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Footer strip
// ---------------------------------------------------------------------------

class _UdFooterStrip extends StatelessWidget {
  const _UdFooterStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.star, size: 10, color: _kGoldDim),
        SizedBox(width: 8),
        Text(
          'Stage Spotlight — a visual study of UnfocusDisposition',
          style: TextStyle(
            color: _kCreamDim,
            fontSize: 12,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(width: 8),
        Icon(Icons.star, size: 10, color: _kGoldDim),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
//  Backdrop painter — velvet + soft spotlights
// ---------------------------------------------------------------------------

class _UdSpotlightBackdropPainter extends CustomPainter {
  const _UdSpotlightBackdropPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()..color = _kVelvet;
    canvas.drawRect(Offset.zero & size, base);

    // Subtle vignette and two golden spotlights.
    final spotOne = Paint()
      ..shader = RadialGradient(
        colors: [
          _kGold.withValues(alpha: 0.12),
          _kVelvet.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.15, size.height * 0.2),
        radius: size.width * 0.4,
      ));
    canvas.drawRect(Offset.zero & size, spotOne);

    final spotTwo = Paint()
      ..shader = RadialGradient(
        colors: [
          _kRuby.withValues(alpha: 0.08),
          _kVelvet.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.88, size.height * 0.85),
        radius: size.width * 0.5,
      ));
    canvas.drawRect(Offset.zero & size, spotTwo);

    // Faint grid to evoke a stage floor.
    final grid = Paint()
      ..color = _kGoldDim.withValues(alpha: 0.05)
      ..strokeWidth = 0.5;
    for (double y = 0; y < size.height; y += 48) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (double x = 0; x < size.width; x += 48) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _UdSpotlightBackdropPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
//  Keyboard shortcut helper (demonstration — intentionally lightweight)
// ---------------------------------------------------------------------------

class _UdShortcutHint extends StatelessWidget {
  const _UdShortcutHint({required this.keys, required this.description});

  final List<String> keys;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          for (final k in keys)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kInk,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _kGoldDim, width: 0.5),
                ),
                child: Text(
                  k,
                  style: const TextStyle(
                    color: _kGold,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(description,
                style: const TextStyle(color: _kCream, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

// A small "cheat sheet" widget rendered inside the Epilogue card; it keeps
// the demo self-contained with a quick keyboard reference.
class _UdCheatSheet extends StatelessWidget {
  const _UdCheatSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kGoldDim, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Keyboard cheat sheet',
              style: TextStyle(
                  color: _kGold,
                  fontWeight: FontWeight.w700,
                  fontSize: 13)),
          SizedBox(height: 6),
          _UdShortcutHint(keys: ['Tab'], description: 'Move to next focusable'),
          _UdShortcutHint(
              keys: ['Shift', 'Tab'], description: 'Move to previous focusable'),
          _UdShortcutHint(
              keys: ['Esc'], description: 'Typical modal-close key'),
          _UdShortcutHint(
              keys: ['Enter'], description: 'Submit form / activate control'),
        ],
      ),
    );
  }
}

