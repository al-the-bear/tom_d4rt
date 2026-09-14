// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SingleActivator.
///
/// SingleActivator is the primary concrete implementation of
/// ShortcutActivator. It matches a single trigger key combined
/// with zero or more modifier keys, and optionally filters by
/// lock key state and repeat events.
///
/// Demonstrates:
/// - Tab 1 (Constructor): Trigger selector, modifier toggles,
///   includeRepeats, const badge, live key combo display
/// - Tab 2 (Matching): accepts() flow, modifier checking,
///   repeat key handling, KeyEvent evaluation
/// - Tab 3 (Lock States): numLock/capsLock/scrollLock
///   LockState tri-state, common shortcut presets

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF283593); // Indigo 800
const Color _kAccent = Color(0xFFF4FF81); // Lime A100
const Color _kSurface = Color(0xFF0F1018);
const Color _kCard = Color(0xFF1E2028);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF2E3038);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kGreen = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);
const Color _kAmber = Color(0xFFFFD54F);
const Color _kPurple = Color(0xFFAB47BC);
const Color _kCyan = Color(0xFF4DD0E1);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _SingleActivatorDemo(),
  );
}

class _SingleActivatorDemo extends StatefulWidget {
  const _SingleActivatorDemo();
  @override
  State<_SingleActivatorDemo> createState() =>
      _SingleActivatorDemoState();
}

class _SingleActivatorDemoState
    extends State<_SingleActivatorDemo>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SingleActivator',
          style: TextStyle(
            color: _kAccent,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kPrimary,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(text: 'Constructor'),
            Tab(text: 'Matching'),
            Tab(text: 'Lock States'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ConstructorTab(),
          _MatchingTab(),
          _LockStatesTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Constructor
// ═══════════════════════════════════════════════════════════════════════════════

class _ConstructorTab extends StatefulWidget {
  const _ConstructorTab();
  @override
  State<_ConstructorTab> createState() =>
      _ConstructorTabState();
}

class _ConstructorTabState extends State<_ConstructorTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedTrigger = 0;
  bool _ctrl = false;
  bool _shift = false;
  bool _alt = false;
  bool _meta = false;
  bool _includeRepeats = true;
  bool _expandParams = false;

  static const _triggers = [
    _Key('A', 'keyA'),
    _Key('S', 'keyS'),
    _Key('C', 'keyC'),
    _Key('V', 'keyV'),
    _Key('Z', 'keyZ'),
    _Key('N', 'keyN'),
    _Key('F1', 'f1'),
    _Key('Esc', 'escape'),
    _Key('Tab', 'tab'),
    _Key('Space', 'space'),
    _Key('Enter', 'enter'),
    _Key('Delete', 'delete'),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Trigger Key'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select the primary trigger key:',
                  style: TextStyle(
                    color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(
                      _triggers.length, (i) {
                    final t = _triggers[i];
                    final sel = _selectedTrigger == i;
                    return GestureDetector(
                      onTap: () => setState(
                          () => _selectedTrigger = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: sel
                              ? _kPrimary
                                  .withValues(alpha: 0.4)
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(4),
                          border: Border.all(
                            color: sel
                                ? _kAccent
                                : _kSubtle,
                            width: sel ? 1.5 : 1,
                          ),
                        ),
                        child: Text(t.label,
                            style: TextStyle(
                              color: sel
                                  ? _kAccent
                                  : _kDimText,
                              fontSize: 11,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              fontFamily: 'monospace',
                            )),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Modifiers
          _sectionTitle('Modifier Keys'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _modToggle('Ctrl', _ctrl, _kHighlight,
                        (v) => setState(() => _ctrl = v)),
                    _modToggle('Shift', _shift, _kGreen,
                        (v) => setState(() => _shift = v)),
                    _modToggle('Alt', _alt, _kAmber,
                        (v) => setState(() => _alt = v)),
                    _modToggle('Meta', _meta, _kPurple,
                        (v) => setState(() => _meta = v)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('includeRepeats:',
                        style: TextStyle(
                          color: _kDimText, fontSize: 11)),
                    const Spacer(),
                    Switch(
                      value: _includeRepeats,
                      onChanged: (v) => setState(
                          () => _includeRepeats = v),
                      activeTrackColor: _kCyan,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Live output
          _sectionTitle('Live Constructor'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _kAccent.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Visual key combo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _kPrimary.withValues(alpha: 0.5)),
                  ),
                  child: Center(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      alignment: WrapAlignment.center,
                      children: _buildKeyBadges(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Code output
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _buildCode(),
                    style: const TextStyle(
                      color: _kAccent,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _badge('const', _kCyan),
                    const SizedBox(width: 6),
                    _badge(
                        'implements '
                        'ShortcutActivator',
                        _kHighlight),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Constructor parameters
          _sectionTitle('All Parameters'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandParams = !_expandParams),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Parameter List',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandParams
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandParams) ...[
                    const SizedBox(height: 8),
                    _paramEntry('trigger',
                        'LogicalKeyboardKey',
                        'Primary key (positional, required)',
                        _kAccent),
                    _paramEntry('control', 'bool',
                        'Require Ctrl key (default: false)',
                        _kHighlight),
                    _paramEntry('shift', 'bool',
                        'Require Shift key (default: false)',
                        _kGreen),
                    _paramEntry('alt', 'bool',
                        'Require Alt key (default: false)',
                        _kAmber),
                    _paramEntry('meta', 'bool',
                        'Require Meta/Cmd key (default: false)',
                        _kPurple),
                    _paramEntry('includeRepeats', 'bool',
                        'Match held-key repeats (default: true)',
                        _kCyan),
                    _paramEntry('numLock', 'LockState',
                        'NumLock state filter (default: ignored)',
                        _kDimText),
                    _paramEntry('capsLock', 'LockState',
                        'CapsLock state filter (default: ignored)',
                        _kDimText),
                    _paramEntry('scrollLock', 'LockState',
                        'ScrollLock state filter '
                        '(default: ignored)',
                        _kDimText),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'SingleActivator is const-constructible, making it '
            'ideal for compile-time shortcut map declarations. '
            'It implements both ShortcutActivator and '
            'MenuSerializableShortcut.',
          ),
        ],
      ),
    );
  }

  List<Widget> _buildKeyBadges() {
    final badges = <Widget>[];
    if (_ctrl) badges.add(_keyBadge('Ctrl', _kHighlight));
    if (_shift) badges.add(_keyBadge('Shift', _kGreen));
    if (_alt) badges.add(_keyBadge('Alt', _kAmber));
    if (_meta) badges.add(_keyBadge('Meta', _kPurple));
    if (badges.isNotEmpty) {
      badges.add(const Text('+',
          style: TextStyle(
            color: _kDimText,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          )));
    }
    badges.add(
        _keyBadge(_triggers[_selectedTrigger].label, _kAccent));
    return badges;
  }

  String _buildCode() {
    final t = _triggers[_selectedTrigger];
    final params = <String>[];
    params.add('  LogicalKeyboardKey.${t.name},');
    if (_ctrl) params.add('  control: true,');
    if (_shift) params.add('  shift: true,');
    if (_alt) params.add('  alt: true,');
    if (_meta) params.add('  meta: true,');
    if (!_includeRepeats) {
      params.add('  includeRepeats: false,');
    }
    return 'const SingleActivator(\n'
        '${params.join('\n')}\n'
        ')';
  }
}

class _Key {
  final String label;
  final String name;
  const _Key(this.label, this.name);
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Matching
// ═══════════════════════════════════════════════════════════════════════════════

class _MatchingTab extends StatefulWidget {
  const _MatchingTab();
  @override
  State<_MatchingTab> createState() => _MatchingTabState();
}

class _MatchingTabState extends State<_MatchingTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandAccepts = true;
  bool _expandModOrder = false;
  bool _expandRepeats = false;
  int _simTrigger = 0;
  bool _simCtrl = false;
  bool _simShift = false;
  bool _simRepeat = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // accepts() method
          _sectionTitle('accepts() Method'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandAccepts = !_expandAccepts),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'bool accepts(KeyEvent, state)',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandAccepts
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandAccepts) ...[
                    const SizedBox(height: 10),
                    _flowStep(1, 'Check Event Type',
                        'Must be KeyDownEvent (or '
                        'KeyRepeatEvent if includeRepeats)',
                        _kHighlight),
                    _flowArrow(),
                    _flowStep(2, 'Check Trigger Key',
                        'event.logicalKey == trigger',
                        _kGreen),
                    _flowArrow(),
                    _flowStep(3, 'Check Modifiers',
                        'Each modifier flag must match '
                        'HardwareKeyboard state',
                        _kAmber),
                    _flowArrow(),
                    _flowStep(4, 'Check Lock States',
                        'numLock/capsLock/scrollLock if not '
                        'LockState.ignored',
                        _kPurple),
                    _flowArrow(),
                    _flowStep(5, 'Return Result',
                        'true if all checks pass; false '
                        'otherwise',
                        _kAccent),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Modifier checking order
          _sectionTitle('Modifier Checking'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandModOrder = !_expandModOrder),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('How modifiers are checked',
                          style: TextStyle(
                            color: _kCyan,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandModOrder
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandModOrder) ...[
                    const SizedBox(height: 8),
                    _checkRow('control',
                        'isControlPressed == control flag',
                        _kHighlight),
                    _checkRow('shift',
                        'isShiftPressed == shift flag',
                        _kGreen),
                    _checkRow('alt',
                        'isAltPressed == alt flag',
                        _kAmber),
                    _checkRow('meta',
                        'isMetaPressed == meta flag',
                        _kPurple),
                    const SizedBox(height: 8),
                    _codeBlock(
                      '// From HardwareKeyboard:\n'
                      'final pressed = HardwareKeyboard\n'
                      '    .instance;\n'
                      'if (control !=\n'
                      '    pressed.isControlPressed)\n'
                      '  return false;\n'
                      '// ... repeat for each modifier',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Repeat events
          _sectionTitle('Repeat Events'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandRepeats = !_expandRepeats),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('includeRepeats',
                          style: TextStyle(
                            color: _kAmber,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandRepeats
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandRepeats) ...[
                    const SizedBox(height: 8),
                    _compRow('true (default)',
                        'Matches KeyDownEvent '
                        'AND KeyRepeatEvent', _kGreen),
                    const SizedBox(height: 4),
                    _compRow('false',
                        'Matches only KeyDownEvent '
                        '(first press)', _kWarning),
                    const SizedBox(height: 8),
                    const Text(
                      'Use false for actions that should not '
                      'fire repeatedly when a key is held, '
                      'such as toggle operations.',
                      style: TextStyle(
                        color: _kDimText, fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Matching simulator
          _sectionTitle('Matching Simulator'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Simulate a key event against '
                  'SingleActivator(keyA, control: true):',
                  style: TextStyle(
                    color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Key:',
                        style: TextStyle(
                          color: _kDimText, fontSize: 10)),
                    const SizedBox(width: 8),
                    _simKeyChip('A', 0),
                    const SizedBox(width: 4),
                    _simKeyChip('B', 1),
                    const SizedBox(width: 4),
                    _simKeyChip('S', 2),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _modToggle('Ctrl', _simCtrl, _kHighlight,
                        (v) => setState(() => _simCtrl = v)),
                    const SizedBox(width: 8),
                    _modToggle('Shift', _simShift, _kGreen,
                        (v) => setState(() => _simShift = v)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text('Repeat:',
                        style: TextStyle(
                          color: _kDimText, fontSize: 10)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => setState(
                          () => _simRepeat = !_simRepeat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _simRepeat
                              ? _kAmber.withValues(alpha: 0.15)
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(12),
                          border: Border.all(
                            color: _simRepeat
                                ? _kAmber
                                : _kSubtle,
                          ),
                        ),
                        child: Text(
                          _simRepeat
                              ? 'KeyRepeatEvent'
                              : 'KeyDownEvent',
                          style: TextStyle(
                            color: _simRepeat
                                ? _kAmber
                                : _kDimText,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _matchResult(),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'SingleActivator checks trigger key, all modifier '
            'flags, lock states, and event type (down vs repeat). '
            'All conditions must pass for accepts() to return true.',
          ),
        ],
      ),
    );
  }

  Widget _simKeyChip(String label, int value) {
    final sel = _simTrigger == value;
    return GestureDetector(
      onTap: () => setState(() => _simTrigger = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: sel
              ? _kPrimary.withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: sel ? _kAccent : _kSubtle),
        ),
        child: Text(label,
            style: TextStyle(
              color: sel ? _kAccent : _kDimText,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight:
                  sel ? FontWeight.w700 : FontWeight.w400,
            )),
      ),
    );
  }

  Widget _matchResult() {
    // Matching against SingleActivator(keyA, control: true)
    final keyMatch = _simTrigger == 0; // A
    final ctrlMatch = _simCtrl == true;
    final shiftMatch = _simShift == false;
    final repeatOk = true; // includeRepeats: true default
    final allMatch =
        keyMatch && ctrlMatch && shiftMatch && repeatOk;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: allMatch
            ? _kGreen.withValues(alpha: 0.08)
            : _kWarning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: allMatch
              ? _kGreen.withValues(alpha: 0.5)
              : _kWarning.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                allMatch
                    ? Icons.check_circle
                    : Icons.cancel,
                size: 16,
                color: allMatch ? _kGreen : _kWarning,
              ),
              const SizedBox(width: 8),
              Text(
                allMatch
                    ? 'MATCH — accepts() returns true'
                    : 'NO MATCH — accepts() returns false',
                style: TextStyle(
                  color: allMatch ? _kGreen : _kWarning,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _matchLine('Trigger: key${_simTrigger == 0 ? 'A' : _simTrigger == 1 ? 'B' : 'S'} == keyA',
              keyMatch),
          _matchLine(
              'Control: $_simCtrl == true', ctrlMatch),
          _matchLine(
              'Shift: $_simShift == false', shiftMatch),
          _matchLine(
              'Event: ${_simRepeat ? 'repeat' : 'down'}'
              ' (repeats: on)',
              repeatOk),
        ],
      ),
    );
  }

  Widget _matchLine(String text, bool ok) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Icon(
            ok ? Icons.check : Icons.close,
            size: 10,
            color: ok ? _kGreen : _kWarning,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text,
                style: TextStyle(
                  color: ok
                      ? _kGreen.withValues(alpha: 0.8)
                      : _kWarning.withValues(alpha: 0.8),
                  fontSize: 9,
                  fontFamily: 'monospace',
                )),
          ),
        ],
      ),
    );
  }

  Widget _checkRow(String name, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 55,
            child: Text(name,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                  color: _kDimText, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _compRow(String label, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    )),
                Text(desc,
                    style: const TextStyle(
                      color: _kDimText, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Lock States
// ═══════════════════════════════════════════════════════════════════════════════

class _LockStatesTab extends StatefulWidget {
  const _LockStatesTab();
  @override
  State<_LockStatesTab> createState() => _LockStatesTabState();
}

class _LockStatesTabState extends State<_LockStatesTab>
    with AutomaticKeepAliveClientMixin {
  int _numLock = 0; // 0=ignored, 1=locked, 2=unlocked
  int _capsLock = 0;
  int _scrollLock = 0;
  bool _expandPresets = true;

  static const _stateLabels = ['ignored', 'locked', 'unlocked'];
  static const _stateColors = [_kDimText, _kGreen, _kWarning];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('LockState Enum'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _codeBlock(
                  'enum LockState {\n'
                  '  ignored,   // Don\'t check\n'
                  '  locked,    // Must be ON\n'
                  '  unlocked,  // Must be OFF\n'
                  '}',
                ),
                const SizedBox(height: 8),
                _lockStateRow('ignored',
                    'Key lock state is not checked — '
                    'matches regardless',
                    _kDimText),
                _lockStateRow('locked',
                    'Key lock must be active (on) to match',
                    _kGreen),
                _lockStateRow('unlocked',
                    'Key lock must be inactive (off) to match',
                    _kWarning),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Interactive lock state
          _sectionTitle('Lock State Builder'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _lockRow('NumLock', _numLock,
                    (v) => setState(() => _numLock = v)),
                const SizedBox(height: 6),
                _lockRow('CapsLock', _capsLock,
                    (v) => setState(() => _capsLock = v)),
                const SizedBox(height: 6),
                _lockRow('ScrollLock', _scrollLock,
                    (v) => setState(() => _scrollLock = v)),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _buildLockCode(),
                    style: const TextStyle(
                      color: _kAccent,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Common shortcut presets
          _sectionTitle('Common Shortcuts'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandPresets = !_expandPresets),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Preset Gallery',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandPresets
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandPresets) ...[
                    const SizedBox(height: 8),
                    _presetRow('Copy', 'Ctrl+C',
                        'CopySelectionTextIntent',
                        _kHighlight),
                    _presetRow('Paste', 'Ctrl+V',
                        'PasteTextIntent', _kGreen),
                    _presetRow('Undo', 'Ctrl+Z',
                        'UndoTextIntent', _kAmber),
                    _presetRow('Redo', 'Ctrl+Shift+Z',
                        'RedoTextIntent', _kPurple),
                    _presetRow('Select All', 'Ctrl+A',
                        'SelectAllTextIntent', _kCyan),
                    _presetRow('Save', 'Ctrl+S',
                        'Custom SaveIntent', _kAccent),
                    _presetRow('New', 'Ctrl+N',
                        'Custom NewDocIntent',
                        _kHighlight),
                    _presetRow('Close', 'Ctrl+W',
                        'Custom CloseTabIntent',
                        _kWarning),
                    _presetRow('Find', 'Ctrl+F',
                        'Custom SearchIntent', _kGreen),
                    _presetRow('Quit (macOS)', 'Meta+Q',
                        'Custom QuitIntent', _kPurple),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // debugDescribeKeys
          _sectionTitle('debugDescribeKeys()'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Output for diagnostics:',
                  style: TextStyle(
                    color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: _kSurface,
                  child: const Text(
                    'SingleActivator(keyA,\n'
                    '  control: true)\n'
                    '\n'
                    '→ "Ctrl + A"\n'
                    '\n'
                    'SingleActivator(keyZ,\n'
                    '  control: true, shift: true)\n'
                    '\n'
                    '→ "Ctrl + Shift + Z"',
                    style: TextStyle(
                      color: _kAccent,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'Lock state parameters default to LockState.ignored, '
            'meaning most shortcuts work regardless of NumLock or '
            'CapsLock. Use locked/unlocked only for keyboard-layout '
            'sensitive applications like numpad entry.',
          ),
        ],
      ),
    );
  }

  Widget _lockRow(
      String name, int value, ValueChanged<int> onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(name,
              style: const TextStyle(
                color: _kAccent,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              )),
        ),
        ...List.generate(3, (i) {
          final sel = value == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                margin: EdgeInsets.only(
                    right: i < 2 ? 4 : 0),
                padding: const EdgeInsets.symmetric(
                    vertical: 5),
                decoration: BoxDecoration(
                  color: sel
                      ? _stateColors[i]
                          .withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: sel
                        ? _stateColors[i]
                        : _kSubtle,
                  ),
                ),
                child: Center(
                  child: Text(_stateLabels[i],
                      style: TextStyle(
                        color: sel
                            ? _stateColors[i]
                            : _kDimText,
                        fontSize: 9,
                        fontWeight: sel
                            ? FontWeight.w700
                            : FontWeight.w400,
                      )),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  String _buildLockCode() {
    final params = <String>['  LogicalKeyboardKey.numpad1,'];
    if (_numLock != 0) {
      params.add(
          '  numLock: LockState.${_stateLabels[_numLock]},');
    }
    if (_capsLock != 0) {
      params.add(
          '  capsLock: LockState.${_stateLabels[_capsLock]},');
    }
    if (_scrollLock != 0) {
      params.add(
          '  scrollLock: LockState.${_stateLabels[_scrollLock]},');
    }
    return 'const SingleActivator(\n'
        '${params.join('\n')}\n'
        ')';
  }

  Widget _lockStateRow(
      String name, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: Text(name,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                  color: _kDimText, fontSize: 9)),
          ),
        ],
      ),
    );
  }

  Widget _presetRow(
      String action, String keys, String intent, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(action,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(keys,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                )),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(intent,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 8,
                  fontFamily: 'monospace',
                )),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _sectionTitle(String title) {
  return Text(title,
      style: const TextStyle(
        color: _kAccent,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ));
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(code,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontFamily: 'monospace',
        )),
  );
}

Widget _infoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline,
            size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  color: _kDimText, fontSize: 11)),
        ),
      ],
    ),
  );
}

Widget _keyBadge(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        )),
  );
}

Widget _badge(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w600,
        )),
  );
}

Widget _modToggle(
    String label, bool on, Color color, ValueChanged<bool> cb) {
  return GestureDetector(
    onTap: () => cb(!on),
    child: Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: on
            ? color.withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: on ? color : _kSubtle,
          width: on ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            on ? Icons.check_circle : Icons.circle_outlined,
            size: 12,
            color: on ? color : _kDimText,
          ),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                color: on ? color : _kDimText,
                fontSize: 10,
                fontWeight:
                    on ? FontWeight.w700 : FontWeight.w400,
              )),
        ],
      ),
    ),
  );
}

Widget _flowStep(
    int step, String title, String desc, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(
                color: color.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Text('$step',
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  )),
              Text(desc,
                  style: const TextStyle(
                    color: _kDimText, fontSize: 9)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 8),
    child: Icon(Icons.arrow_downward,
        size: 12, color: _kDimText),
  );
}

Widget _paramEntry(
    String name, String type, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(name,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              )),
        ),
        SizedBox(
          width: 80,
          child: Text(type,
              style: const TextStyle(
                color: _kHighlight,
                fontSize: 8,
                fontFamily: 'monospace',
              )),
        ),
        Expanded(
          child: Text(desc,
              style: const TextStyle(
                color: _kDimText, fontSize: 9)),
        ),
      ],
    ),
  );
}
