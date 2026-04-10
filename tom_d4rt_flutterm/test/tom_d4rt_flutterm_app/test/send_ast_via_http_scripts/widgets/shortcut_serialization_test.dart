// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ShortcutSerialization.
///
/// ShortcutSerialization provides two named constructors — character
/// and modifier — to serialize keyboard shortcuts into a platform-
/// consumable format for PlatformMenuBar native rendering.
///
/// Demonstrates:
/// - Tab 1 (Constructors): character vs modifier constructors,
///   parameter comparison, serialization format
/// - Tab 2 (Modifiers): Interactive modifier toggle builder
///   with live serialized output, disallowed triggers
/// - Tab 3 (Platform Menu): PlatformMenuBar integration,
///   MenuSerializableShortcut mixin, native rendering flow

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF00695C); // Teal 800
const Color _kAccent = Color(0xFFFF80AB); // Pink A100
const Color _kSurface = Color(0xFF0E1614);
const Color _kCard = Color(0xFF1C2623);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF2A3633);
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
    home: const _ShortcutSerializationDemo(),
  );
}

class _ShortcutSerializationDemo extends StatefulWidget {
  const _ShortcutSerializationDemo();
  @override
  State<_ShortcutSerializationDemo> createState() =>
      _ShortcutSerializationDemoState();
}

class _ShortcutSerializationDemoState
    extends State<_ShortcutSerializationDemo>
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
          'ShortcutSerialization',
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
            Tab(text: 'Constructors'),
            Tab(text: 'Modifiers'),
            Tab(text: 'Platform Menu'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ConstructorsTab(),
          _ModifiersTab(),
          _PlatformMenuTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Constructors
// ═══════════════════════════════════════════════════════════════════════════════

class _ConstructorsTab extends StatefulWidget {
  const _ConstructorsTab();
  @override
  State<_ConstructorsTab> createState() =>
      _ConstructorsTabState();
}

class _ConstructorsTabState extends State<_ConstructorsTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedCtor = 0;
  bool _expandComparison = false;
  bool _expandFormat = false;

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
          _sectionTitle('Named Constructors'),
          const SizedBox(height: 8),

          // Constructor selector
          Row(
            children: [
              _ctorChip('character', 0),
              const SizedBox(width: 8),
              _ctorChip('modifier', 1),
            ],
          ),
          const SizedBox(height: 10),

          // Constructor detail
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
                if (_selectedCtor == 0) ...[
                  const Text(
                    'ShortcutSerialization.character()',
                    style: TextStyle(
                      color: _kAccent,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _codeBlock(
                    'ShortcutSerialization.character(\n'
                    '  String character, {\n'
                    '  bool alt = false,\n'
                    '  bool control = false,\n'
                    '  bool meta = false,\n'
                    '})',
                  ),
                  const SizedBox(height: 8),
                  _paramRow('character', 'String',
                      'Single character (length == 1)', true),
                  _paramRow(
                      'alt', 'bool', 'Alt modifier', false),
                  _paramRow('control', 'bool',
                      'Control modifier', false),
                  _paramRow(
                      'meta', 'bool', 'Meta modifier', false),
                  const SizedBox(height: 8),
                  const Text(
                    'Used by CharacterActivator to serialize '
                    'itself for platform menu rendering.',
                    style: TextStyle(
                      color: _kDimText, fontSize: 11),
                  ),
                ] else ...[
                  const Text(
                    'ShortcutSerialization.modifier()',
                    style: TextStyle(
                      color: _kCyan,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _codeBlock(
                    'ShortcutSerialization.modifier(\n'
                    '  LogicalKeyboardKey trigger, {\n'
                    '  bool alt = false,\n'
                    '  bool control = false,\n'
                    '  bool meta = false,\n'
                    '  bool shift = false,\n'
                    '})',
                  ),
                  const SizedBox(height: 8),
                  _paramRow('trigger', 'LogicalKeyboardKey',
                      'Non-modifier key to trigger', true),
                  _paramRow(
                      'alt', 'bool', 'Alt modifier', false),
                  _paramRow('control', 'bool',
                      'Control modifier', false),
                  _paramRow(
                      'meta', 'bool', 'Meta modifier', false),
                  _paramRow('shift', 'bool',
                      'Shift modifier', false),
                  const SizedBox(height: 8),
                  const Text(
                    'Used by SingleActivator to serialize '
                    'itself for platform menu rendering.',
                    style: TextStyle(
                      color: _kDimText, fontSize: 11),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Comparison
          _sectionTitle('Constructor Comparison'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandComparison = !_expandComparison),
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
                      const Text('character vs modifier',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandComparison
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandComparison) ...[
                    const SizedBox(height: 8),
                    _compRow('Input Type', 'String char',
                        'LogicalKeyboardKey'),
                    _compRow('Shift', 'Not available',
                        'Available'),
                    _compRow('Trigger Source',
                        'CharacterActivator', 'SingleActivator'),
                    _compRow('Serialized Key',
                        '_kShortcutCharacter',
                        '_kShortcutTrigger'),
                    _compRow('Example', '"a"',
                        'LogicalKeyboardKey.keyA'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Serialization format
          _sectionTitle('Serialization Format'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () =>
                setState(() => _expandFormat = !_expandFormat),
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
                      const Text('Internal Data Structure',
                          style: TextStyle(
                            color: _kGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandFormat
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandFormat) ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _kSurface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '// character constructor:\n'
                        '{\n'
                        '  "shortcutCharacter": "a",\n'
                        '  "shortcutModifiers": [\n'
                        '    0x04,  // control\n'
                        '  ],\n'
                        '}\n'
                        '\n'
                        '// modifier constructor:\n'
                        '{\n'
                        '  "shortcutTrigger": 0x00000061,\n'
                        '  "shortcutModifiers": [\n'
                        '    0x04,  // control\n'
                        '    0x01,  // shift\n'
                        '  ],\n'
                        '}',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _dataRow('_kShortcutCharacter',
                        '"shortcutCharacter"', _kAccent),
                    _dataRow('_kShortcutTrigger',
                        '"shortcutTrigger"', _kCyan),
                    _dataRow('_kShortcutModifiers',
                        '"shortcutModifiers"', _kGreen),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'ShortcutSerialization converts keyboard shortcuts into '
            'a map of strings and values that the platform can '
            'understand. This enables native menu rendering on '
            'macOS via PlatformMenuBar.',
          ),
        ],
      ),
    );
  }

  Widget _ctorChip(String label, int value) {
    final sel = _selectedCtor == value;
    final color = value == 0 ? _kAccent : _kCyan;
    return GestureDetector(
      onTap: () => setState(() => _selectedCtor = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: sel
              ? color.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: sel ? color : _kSubtle,
            width: sel ? 1.5 : 1,
          ),
        ),
        child: Text('.$label',
            style: TextStyle(
              color: sel ? color : _kDimText,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight:
                  sel ? FontWeight.w700 : FontWeight.w400,
            )),
      ),
    );
  }

  Widget _compRow(String label, String char, String mod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 2),
              color: _kAccent.withValues(alpha: 0.06),
              child: Text(char,
                  style: const TextStyle(
                    color: _kAccent,
                    fontSize: 9,
                    fontFamily: 'monospace',
                  )),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 2),
              color: _kCyan.withValues(alpha: 0.06),
              child: Text(mod,
                  style: const TextStyle(
                    color: _kCyan,
                    fontSize: 9,
                    fontFamily: 'monospace',
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataRow(String key, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
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
          Text(key,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(width: 8),
          Text(value,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 9,
                fontFamily: 'monospace',
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Modifiers
// ═══════════════════════════════════════════════════════════════════════════════

class _ModifiersTab extends StatefulWidget {
  const _ModifiersTab();
  @override
  State<_ModifiersTab> createState() => _ModifiersTabState();
}

class _ModifiersTabState extends State<_ModifiersTab>
    with AutomaticKeepAliveClientMixin {
  bool _ctrl = false;
  bool _alt = false;
  bool _shift = false;
  bool _meta = false;
  int _selectedTrigger = 0;
  bool _useCharCtor = false;
  bool _expandDisallowed = false;

  static const _triggers = [
    _TriggerInfo('A', 'keyA', 0x00000061),
    _TriggerInfo('S', 'keyS', 0x00000073),
    _TriggerInfo('Z', 'keyZ', 0x0000007A),
    _TriggerInfo('N', 'keyN', 0x0000006E),
    _TriggerInfo('F1', 'f1', 0x00100070),
    _TriggerInfo('Esc', 'escape', 0x0010001B),
    _TriggerInfo('Tab', 'tab', 0x00100009),
    _TriggerInfo('Space', 'space', 0x00000020),
  ];

  static const _disallowed = [
    'alt', 'altLeft', 'altRight',
    'control', 'controlLeft', 'controlRight',
    'meta', 'metaLeft', 'metaRight',
    'shift', 'shiftLeft', 'shiftRight',
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
          _sectionTitle('Interactive Builder'),
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
                // Constructor mode
                Row(
                  children: [
                    const Text('Mode:',
                        style: TextStyle(
                          color: _kDimText, fontSize: 11)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => setState(
                          () => _useCharCtor = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: !_useCharCtor
                              ? _kCyan.withValues(alpha: 0.15)
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(12),
                          border: Border.all(
                            color: !_useCharCtor
                                ? _kCyan
                                : _kSubtle,
                          ),
                        ),
                        child: Text('.modifier',
                            style: TextStyle(
                              color: !_useCharCtor
                                  ? _kCyan
                                  : _kDimText,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            )),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => setState(() {
                        _useCharCtor = true;
                        _shift = false;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _useCharCtor
                              ? _kAccent.withValues(alpha: 0.15)
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(12),
                          border: Border.all(
                            color: _useCharCtor
                                ? _kAccent
                                : _kSubtle,
                          ),
                        ),
                        child: Text('.character',
                            style: TextStyle(
                              color: _useCharCtor
                                  ? _kAccent
                                  : _kDimText,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Modifier toggles
                const Text('Modifiers:',
                    style: TextStyle(
                      color: _kDimText, fontSize: 11)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _modChip('Ctrl', _ctrl, _kHighlight,
                        (v) => setState(() => _ctrl = v)),
                    _modChip('Alt', _alt, _kGreen,
                        (v) => setState(() => _alt = v)),
                    if (!_useCharCtor)
                      _modChip('Shift', _shift, _kAmber,
                          (v) => setState(() => _shift = v)),
                    _modChip('Meta', _meta, _kPurple,
                        (v) => setState(() => _meta = v)),
                  ],
                ),
                const SizedBox(height: 12),

                // Trigger selector
                const Text('Trigger key:',
                    style: TextStyle(
                      color: _kDimText, fontSize: 11)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(
                      _triggers.length, (i) {
                    final t = _triggers[i];
                    final sel = _selectedTrigger == i;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedTrigger = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
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
                          ),
                        ),
                        child: Text(t.label,
                            style: TextStyle(
                              color: sel
                                  ? _kAccent
                                  : _kDimText,
                              fontSize: 10,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              fontFamily: 'monospace',
                            )),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 12),

                // Live output
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: (_useCharCtor ? _kAccent : _kCyan)
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        _buildConstructorCode(),
                        style: TextStyle(
                          color: _useCharCtor
                              ? _kAccent
                              : _kCyan,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Divider(
                          color: _kSubtle, height: 1),
                      const SizedBox(height: 6),
                      Text(
                        _buildVisualCombo(),
                        style: const TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Serialized output
          _sectionTitle('Serialized Output'),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _buildSerializedOutput(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Disallowed triggers
          _sectionTitle('Disallowed Triggers'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandDisallowed = !_expandDisallowed),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _kWarning.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber,
                          size: 14, color: _kWarning),
                      const SizedBox(width: 6),
                      const Text('Modifier keys cannot be triggers',
                          style: TextStyle(
                            color: _kWarning,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandDisallowed
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandDisallowed) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: _disallowed
                          .map((k) => Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: _kWarning
                                      .withValues(alpha: 0.08),
                                  borderRadius:
                                      BorderRadius.circular(4),
                                  border: Border.all(
                                    color: _kWarning
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(k,
                                    style: const TextStyle(
                                      color: _kWarning,
                                      fontSize: 9,
                                      fontFamily: 'monospace',
                                    )),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'These keys are used as modifiers, not '
                      'triggers. Using them as a trigger in the '
                      'modifier constructor throws an assertion.',
                      style: TextStyle(
                        color: _kDimText, fontSize: 10),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'The modifier constructor supports shift but '
            'character does not — the platform infers shift from '
            'the character itself (e.g., "A" vs "a"). The modifier '
            'constructor asserts that the trigger is not a '
            'modifier key.',
          ),
        ],
      ),
    );
  }

  Widget _modChip(
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

  String _buildConstructorCode() {
    final t = _triggers[_selectedTrigger];
    if (_useCharCtor) {
      final mods = <String>[];
      if (_ctrl) mods.add('  control: true,');
      if (_alt) mods.add('  alt: true,');
      if (_meta) mods.add('  meta: true,');
      final modsStr = mods.isEmpty
          ? ''
          : '\n${mods.join('\n')}\n';
      return 'ShortcutSerialization.character(\n'
          '  \'${t.label.toLowerCase()}\',$modsStr'
          ')';
    } else {
      final mods = <String>[];
      if (_ctrl) mods.add('  control: true,');
      if (_alt) mods.add('  alt: true,');
      if (_shift) mods.add('  shift: true,');
      if (_meta) mods.add('  meta: true,');
      final modsStr = mods.isEmpty
          ? ''
          : '\n${mods.join('\n')}\n';
      return 'ShortcutSerialization.modifier(\n'
          '  LogicalKeyboardKey.${t.name},$modsStr'
          ')';
    }
  }

  String _buildVisualCombo() {
    final parts = <String>[];
    if (_ctrl) parts.add('Ctrl');
    if (_alt) parts.add('Alt');
    if (_shift && !_useCharCtor) parts.add('Shift');
    if (_meta) parts.add('Meta');
    parts.add(_triggers[_selectedTrigger].label);
    return parts.join(' + ');
  }

  String _buildSerializedOutput() {
    final t = _triggers[_selectedTrigger];
    final mods = <String>[];
    if (_ctrl) mods.add('    0x04,  // control');
    if (_alt) mods.add('    0x02,  // alt');
    if (_shift && !_useCharCtor) {
      mods.add('    0x01,  // shift');
    }
    if (_meta) mods.add('    0x08,  // meta');

    final modsStr = mods.isEmpty
        ? '  "shortcutModifiers": []'
        : '  "shortcutModifiers": [\n${mods.join('\n')}\n  ]';

    if (_useCharCtor) {
      return '{\n'
          '  "shortcutCharacter": "${t.label.toLowerCase()}",\n'
          '$modsStr\n'
          '}';
    } else {
      return '{\n'
          '  "shortcutTrigger": 0x${t.keyId.toRadixString(16).padLeft(8, '0')},\n'
          '$modsStr\n'
          '}';
    }
  }
}

class _TriggerInfo {
  final String label;
  final String name;
  final int keyId;
  const _TriggerInfo(this.label, this.name, this.keyId);
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Platform Menu
// ═══════════════════════════════════════════════════════════════════════════════

class _PlatformMenuTab extends StatefulWidget {
  const _PlatformMenuTab();
  @override
  State<_PlatformMenuTab> createState() =>
      _PlatformMenuTabState();
}

class _PlatformMenuTabState extends State<_PlatformMenuTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedView = 0;
  bool _expandMixin = false;
  bool _expandFlow = false;

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
          _sectionTitle('PlatformMenuBar'),
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
                Row(
                  children: [
                    _viewBtn('Menu', 0),
                    const SizedBox(width: 6),
                    _viewBtn('Code', 1),
                    const SizedBox(width: 6),
                    _viewBtn('Struct', 2),
                  ],
                ),
                const SizedBox(height: 10),
                if (_selectedView == 0) _buildMenuView(),
                if (_selectedView == 1) _buildCodeView(),
                if (_selectedView == 2) _buildStructView(),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // MenuSerializableShortcut mixin
          _sectionTitle('MenuSerializableShortcut'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () =>
                setState(() => _expandMixin = !_expandMixin),
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
                      const Text('Mixin Interface',
                          style: TextStyle(
                            color: _kPurple,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandMixin
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandMixin) ...[
                    const SizedBox(height: 8),
                    _codeBlock(
                      'mixin MenuSerializableShortcut {\n'
                      '  ShortcutSerialization\n'
                      '      serializeForMenu();\n'
                      '}\n'
                      '\n'
                      '// Implemented by:\n'
                      '// - SingleActivator\n'
                      '// - CharacterActivator',
                    ),
                    const SizedBox(height: 8),
                    _bulletItem(
                        'SingleActivator uses .modifier()',
                        _kCyan),
                    _bulletItem(
                        'CharacterActivator uses .character()',
                        _kAccent),
                    _bulletItem(
                        'PlatformMenuItem calls serializeForMenu',
                        _kGreen),
                    _bulletItem(
                        'Result sent to platform channel',
                        _kAmber),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Native rendering flow
          _sectionTitle('Native Rendering Flow'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () =>
                setState(() => _expandFlow = !_expandFlow),
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
                      const Text('Platform Channel Flow',
                          style: TextStyle(
                            color: _kCyan,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandFlow
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandFlow) ...[
                    const SizedBox(height: 8),
                    _flowStep(1,
                        'PlatformMenuItem', 'Creates menu item '
                        'with shortcut', _kHighlight),
                    _flowArrow(),
                    _flowStep(2,
                        'serializeForMenu()', 'Activator returns '
                        'ShortcutSerialization', _kGreen),
                    _flowArrow(),
                    _flowStep(3,
                        'toChannelRepresentation()', 'Converts to '
                        'platform map', _kAmber),
                    _flowArrow(),
                    _flowStep(4,
                        'SystemChannels.menu', 'Sends via method '
                        'channel to engine', _kPurple),
                    _flowArrow(),
                    _flowStep(5,
                        'Native Menu API', 'macOS NSMenu renders '
                        'with shortcut symbol', _kAccent),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Platform differences
          _sectionTitle('Platform Support'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _platformRow('macOS', 'Full native menu support',
                    _kGreen, true),
                _platformRow('Linux', 'No native menu bar',
                    _kWarning, false),
                _platformRow('Windows', 'No native menu bar',
                    _kWarning, false),
                _platformRow('Web', 'No native menu bar',
                    _kWarning, false),
                _platformRow('iOS/Android', 'Not applicable',
                    _kDimText, false),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'ShortcutSerialization is primarily used on macOS where '
            'PlatformMenuBar renders native NSMenu items. The '
            'serialized data flows through the platform channel to '
            'the engine, which passes it to the native menu API.',
          ),
        ],
      ),
    );
  }

  Widget _viewBtn(String label, int value) {
    final sel = _selectedView == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedView = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: sel
              ? _kPrimary.withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: sel
                ? _kAccent
                : _kDimText.withValues(alpha: 0.3),
          ),
        ),
        child: Text(label,
            style: TextStyle(
              color: sel ? _kAccent : _kDimText,
              fontSize: 10,
              fontWeight:
                  sel ? FontWeight.w600 : FontWeight.w400,
            )),
      ),
    );
  }

  Widget _buildMenuView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('macOS Menu Bar:',
              style: TextStyle(
                color: _kDimText, fontSize: 9)),
          const SizedBox(height: 6),
          _menuItem('File', null),
          _menuItem('  New', 'Cmd+N'),
          _menuItem('  Open', 'Cmd+O'),
          _menuItem('  Save', 'Cmd+S'),
          _menuSeparator(),
          _menuItem('Edit', null),
          _menuItem('  Undo', 'Cmd+Z'),
          _menuItem('  Redo', 'Cmd+Shift+Z'),
          _menuItem('  Copy', 'Cmd+C'),
          _menuItem('  Paste', 'Cmd+V'),
        ],
      ),
    );
  }

  Widget _buildCodeView() {
    return _codeBlock(
      'PlatformMenuBar(\n'
      '  menus: [\n'
      '    PlatformMenu(\n'
      '      label: \'File\',\n'
      '      menus: [\n'
      '        PlatformMenuItem(\n'
      '          label: \'New\',\n'
      '          shortcut: SingleActivator(\n'
      '            LogicalKeyboardKey.keyN,\n'
      '            meta: true,\n'
      '          ),\n'
      '          onSelected: () => ...,\n'
      '        ),\n'
      '      ],\n'
      '    ),\n'
      '  ],\n'
      ')',
    );
  }

  Widget _buildStructView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _structRow('PlatformMenuBar', 0, _kHighlight),
        _structRow('menus: List<PlatformMenuItem>', 1, _kGreen),
        _structRow('PlatformMenu', 2, _kAmber),
        _structRow('label: String', 3, _kDimText),
        _structRow('menus: List<PlatformMenuItem>', 3, _kDimText),
        _structRow('PlatformMenuItem', 2, _kPurple),
        _structRow('label: String', 3, _kDimText),
        _structRow('shortcut: MenuSerializableShortcut?', 3,
            _kAccent),
        _structRow('→ serializeForMenu()', 4, _kCyan),
        _structRow('→ ShortcutSerialization', 5, _kAccent),
      ],
    );
  }

  Widget _structRow(String text, int depth, Color color) {
    return Padding(
      padding: EdgeInsets.only(
          left: depth * 12.0, top: 2, bottom: 2),
      child: Text(text,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFamily: 'monospace',
          )),
    );
  }

  Widget _menuItem(String label, String? shortcut) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 10,
                  fontFamily: 'monospace',
                )),
          ),
          if (shortcut != null)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: _kPrimary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(shortcut,
                  style: const TextStyle(
                    color: _kCyan,
                    fontSize: 9,
                    fontFamily: 'monospace',
                  )),
            ),
        ],
      ),
    );
  }

  Widget _menuSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Divider(color: _kSubtle, height: 1),
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
        border:
            Border.all(color: color.withValues(alpha: 0.3)),
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

  Widget _platformRow(
      String name, String desc, Color color, bool supported) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            supported
                ? Icons.check_circle
                : Icons.cancel_outlined,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: Text(name,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
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

Widget _bulletItem(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
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

Widget _paramRow(
    String name, String type, String desc, bool required) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Row(
            children: [
              if (required)
                const Text('* ',
                    style: TextStyle(
                      color: _kWarning, fontSize: 10)),
              Text(name,
                  style: const TextStyle(
                    color: _kAccent,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
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
