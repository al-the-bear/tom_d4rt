// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ShortcutActivator.
///
/// ShortcutActivator is the abstract interface for defining when a keyboard
/// shortcut should be triggered. Implementations: SingleActivator,
/// LogicalKeySet, CharacterActivator.
///
/// Demonstrates:
/// - Tab 1 (Anatomy): Class hierarchy, abstract members (triggers, accepts,
///   debugDescribeKeys), const constructor, first-pass optimization
/// - Tab 2 (Implementations): Side-by-side comparison of SingleActivator,
///   LogicalKeySet, CharacterActivator with modifier key visualization
/// - Tab 3 (Shortcuts Widget): Integration with Shortcuts/Actions, shortcut
///   map builder, common bindings table, live shortcut activation display

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF4E342E); // Brown 800
const Color _kAccent = Color(0xFFFFE57F); // Amber A100
const Color _kSurface = Color(0xFF1A1714);
const Color _kCard = Color(0xFF2A2724);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3A3734);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kSelected = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);
const Color _kPurple = Color(0xFFAB47BC);

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
    home: const _ShortcutActivatorDemo(),
  );
}

class _ShortcutActivatorDemo extends StatefulWidget {
  const _ShortcutActivatorDemo();
  @override
  State<_ShortcutActivatorDemo> createState() =>
      _ShortcutActivatorDemoState();
}

class _ShortcutActivatorDemoState extends State<_ShortcutActivatorDemo>
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
          'ShortcutActivator',
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
            Tab(text: 'Anatomy'),
            Tab(text: 'Implementations'),
            Tab(text: 'Shortcuts Widget'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _AnatomyTab(),
          _ImplementationsTab(),
          _ShortcutsWidgetTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Anatomy
// ═══════════════════════════════════════════════════════════════════════════════

class _AnatomyTab extends StatefulWidget {
  const _AnatomyTab();
  @override
  State<_AnatomyTab> createState() => _AnatomyTabState();
}

class _AnatomyTabState extends State<_AnatomyTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandMembers = false;
  bool _expandOptimization = false;

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
          _sectionTitle('Abstract Interface'),
          const SizedBox(height: 8),
          _codeBlock(
            'abstract class ShortcutActivator {\n'
            '  const ShortcutActivator();\n'
            '\n'
            '  Iterable<LogicalKeyboardKey>? get triggers;\n'
            '  bool accepts(KeyEvent event,\n'
            '    HardwareKeyboard state);\n'
            '  String debugDescribeKeys();\n'
            '}',
          ),
          const SizedBox(height: 16),

          // Hierarchy
          _sectionTitle('Type Hierarchy'),
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
                _hierNode('ShortcutActivator (abstract)', true, _kAccent),
                _hierArrow(),
                Row(
                  children: [
                    Expanded(child: _hierLeaf('SingleActivator', _kHighlight)),
                    const SizedBox(width: 6),
                    Expanded(child: _hierLeaf('LogicalKeySet', _kSelected)),
                    const SizedBox(width: 6),
                    Expanded(
                        child: _hierLeaf('CharacterActivator', _kPurple)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Abstract members
          _sectionTitle('Abstract Members'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () =>
                setState(() => _expandMembers = !_expandMembers),
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
                      const Text('3 abstract members',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandMembers
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandMembers) ...[
                    const SizedBox(height: 10),
                    _memberCard(
                      'triggers',
                      'Iterable<LogicalKeyboardKey>?',
                      'The set of keys that the shortcut may '
                          'respond to. Used for first-pass filtering. '
                          'Return null to check all events (slow).',
                      _kHighlight,
                    ),
                    const SizedBox(height: 8),
                    _memberCard(
                      'accepts(event, state)',
                      'bool',
                      'Whether the given key event and keyboard '
                          'state match this shortcut. Must not cause '
                          'side effects. Called only after triggers '
                          'pass the first filter.',
                      _kSelected,
                    ),
                    const SizedBox(height: 8),
                    _memberCard(
                      'debugDescribeKeys()',
                      'String',
                      'Human-readable description used in debug '
                          'logging. Example output: "Ctrl + A".',
                      _kPurple,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Const constructor
          _sectionTitle('Const Constructor'),
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
                  'const ShortcutActivator()',
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Abstract const constructor enables compile-time '
                  'constant shortcut maps. All built-in implementations '
                  'support const construction for efficient shortcut '
                  'registration.',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _codeBlock(
                  'const shortcuts = <ShortcutActivator, Intent>{\n'
                  '  SingleActivator(LogicalKeyboardKey.keyA,\n'
                  '    control: true): ActivateIntent(),\n'
                  '};\n'
                  '// Entire map is const-evaluated',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // First-pass optimization
          _sectionTitle('First-Pass Optimization'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandOptimization = !_expandOptimization),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: _kHighlight.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.speed, size: 16,
                          color: _kHighlight),
                      const SizedBox(width: 6),
                      const Text('Trigger Optimization',
                          style: TextStyle(
                            color: _kHighlight,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandOptimization
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandOptimization) ...[
                    const SizedBox(height: 8),
                    _flowStep(
                      '1',
                      'Key event arrives',
                      'System dispatches KeyEvent',
                      _kDimText,
                    ),
                    _flowStep(
                      '2',
                      'Check triggers',
                      'Framework checks if event.logicalKey '
                          'is in activator.triggers',
                      _kHighlight,
                    ),
                    _flowStep(
                      '3',
                      'Filter non-matching',
                      'Skip activators whose triggers '
                          'don\'t include this key',
                      _kWarning,
                    ),
                    _flowStep(
                      '4',
                      'Call accepts()',
                      'Only matching activators get '
                          'full accepts() check',
                      _kSelected,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(6),
                      color: _kSurface,
                      child: const Text(
                        'triggers = null → every event calls '
                        'accepts() (inefficient, avoid!)',
                        style: TextStyle(
                          color: _kWarning,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'ShortcutActivator is the contract for keyboard shortcut '
            'matching. It separates "what triggers a shortcut" from '
            '"what happens when triggered" (Intent/Action). The const '
            'constructor allows compile-time shortcut map creation.',
          ),
        ],
      ),
    );
  }

  Widget _memberCard(
      String name, String ret, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  )),
              const Spacer(),
              Text('→ $ret',
                  style: const TextStyle(
                    color: _kDimText,
                    fontSize: 9,
                    fontFamily: 'monospace',
                  )),
            ],
          ),
          const SizedBox(height: 4),
          Text(desc,
              style: const TextStyle(
                color: _kDimText, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _flowStep(
      String num, String title, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: color),
            ),
            child: Center(
              child: Text(num,
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
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    )),
                Text(desc,
                    style: const TextStyle(
                      color: _kDimText, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Implementations
// ═══════════════════════════════════════════════════════════════════════════════

class _ImplementationsTab extends StatefulWidget {
  const _ImplementationsTab();
  @override
  State<_ImplementationsTab> createState() =>
      _ImplementationsTabState();
}

class _ImplementationsTabState extends State<_ImplementationsTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedImpl = 0; // 0=Single, 1=LogicalKeySet, 2=Character
  bool _ctrlOn = true;
  bool _shiftOn = false;
  bool _altOn = false;
  bool _metaOn = false;
  bool _includeRepeats = true;

  @override
  bool get wantKeepAlive => true;

  static const _implNames = [
    'SingleActivator',
    'LogicalKeySet',
    'CharacterActivator',
  ];
  static const _implColors = [_kHighlight, _kSelected, _kPurple];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selector
          _sectionTitle('Built-in Implementations'),
          const SizedBox(height: 8),
          Row(
            children: List.generate(3, (i) {
              final sel = _selectedImpl == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedImpl = i),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: i < 2 ? 6 : 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: sel
                          ? _implColors[i]
                              .withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: sel
                            ? _implColors[i]
                            : _kSubtle,
                      ),
                    ),
                    child: Text(
                      _implNames[i],
                      style: TextStyle(
                        color: sel ? _implColors[i] : _kDimText,
                        fontSize: 10,
                        fontWeight:
                            sel ? FontWeight.w700 : FontWeight.w400,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Detail panel
          _buildImplDetail(),
          const SizedBox(height: 16),

          // Interactive modifier builder (SingleActivator)
          if (_selectedImpl == 0) ...[
            _sectionTitle('Modifier Builder'),
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
                    'Toggle modifiers to build a SingleActivator:',
                    style: TextStyle(
                        color: _kDimText, fontSize: 11),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      _modChip('Ctrl', _ctrlOn, (v) =>
                          setState(() => _ctrlOn = v)),
                      _modChip('Shift', _shiftOn, (v) =>
                          setState(() => _shiftOn = v)),
                      _modChip('Alt', _altOn, (v) =>
                          setState(() => _altOn = v)),
                      _modChip('Meta', _metaOn, (v) =>
                          setState(() => _metaOn = v)),
                      _modChip('Repeats', _includeRepeats, (v) =>
                          setState(() => _includeRepeats = v)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Visual key combo
                  _buildKeyCombo(),
                  const SizedBox(height: 8),
                  // Code output
                  _codeBlock(_buildActivatorCode()),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Comparison table
          _sectionTitle('Comparison'),
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
                _compareHeader(),
                _compareRow(
                  'Const',
                  ['Yes', 'No', 'Yes'],
                  [_kSelected, _kWarning, _kSelected],
                ),
                _compareRow(
                  'Modifiers',
                  ['Boolean flags', 'In key set', 'Optional'],
                  [_kHighlight, _kSelected, _kPurple],
                ),
                _compareRow(
                  'Key count',
                  ['1 trigger', 'N keys', '1 char'],
                  [_kHighlight, _kSelected, _kPurple],
                ),
                _compareRow(
                  'Repeats',
                  ['Configurable', 'No', 'No'],
                  [_kSelected, _kDimText, _kDimText],
                ),
                _compareRow(
                  'Use case',
                  ['Most common', 'Legacy', 'Character'],
                  [_kHighlight, _kDimText, _kPurple],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'SingleActivator is the recommended implementation for '
            'most shortcuts. LogicalKeySet is older and cannot be const. '
            'CharacterActivator matches the character generated, '
            'regardless of modifier keys.',
          ),
        ],
      ),
    );
  }

  Widget _buildImplDetail() {
    switch (_selectedImpl) {
      case 0:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: _kHighlight.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('SingleActivator',
                  style: TextStyle(
                    color: _kHighlight,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  )),
              const SizedBox(height: 6),
              const Text(
                'The most common ShortcutActivator. Matches a single '
                'trigger key plus optional modifier flags (ctrl, shift, '
                'alt, meta). Supports const construction and key '
                'repeat handling.',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 8),
              _codeBlock(
                'const SingleActivator(\n'
                '  LogicalKeyboardKey.keyA,\n'
                '  control: true,\n'
                '  shift: false,\n'
                '  alt: false,\n'
                '  meta: false,\n'
                '  includeRepeats: true,\n'
                ')',
              ),
              const SizedBox(height: 8),
              _propRow('trigger', 'LogicalKeyboardKey',
                  'The key that triggers when pressed'),
              _propRow('control', 'bool',
                  'Whether Ctrl must be held'),
              _propRow('shift', 'bool',
                  'Whether Shift must be held'),
              _propRow('alt', 'bool',
                  'Whether Alt must be held'),
              _propRow('meta', 'bool',
                  'Whether Meta/Cmd must be held'),
              _propRow('includeRepeats', 'bool',
                  'Fire on key-repeat events too'),
            ],
          ),
        );
      case 1:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: _kSelected.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LogicalKeySet',
                  style: TextStyle(
                    color: _kSelected,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  )),
              const SizedBox(height: 6),
              const Text(
                'Set-based activator that triggers when all specified '
                'keys are pressed simultaneously. Cannot be const. '
                'Considered legacy — prefer SingleActivator.',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 8),
              _codeBlock(
                'LogicalKeySet(\n'
                '  LogicalKeyboardKey.control,\n'
                '  LogicalKeyboardKey.shift,\n'
                '  LogicalKeyboardKey.keyA,\n'
                ')',
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(6),
                color: _kWarning.withValues(alpha: 0.08),
                child: const Text(
                  'Note: Cannot distinguish key-down from '
                  'key-repeat events. Not const-constructible.',
                  style: TextStyle(
                    color: _kWarning,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: _kPurple.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('CharacterActivator',
                  style: TextStyle(
                    color: _kPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  )),
              const SizedBox(height: 6),
              const Text(
                'Matches the character generated by a key event, '
                'regardless of modifier keys. Useful for shortcuts '
                'that depend on the character typed (e.g. "?" for help).',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 8),
              _codeBlock(
                'const CharacterActivator(\'?\')\n'
                '// Matches ? regardless of how it\'s typed',
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _keyBadge('Shift', _kDimText),
                  const SizedBox(width: 4),
                  const Text('+',
                      style: TextStyle(
                        color: _kDimText, fontSize: 10)),
                  const SizedBox(width: 4),
                  _keyBadge('/', _kPurple),
                  const SizedBox(width: 8),
                  const Text('→',
                      style: TextStyle(
                        color: _kDimText, fontSize: 10)),
                  const SizedBox(width: 8),
                  _keyBadge('?', _kAccent),
                  const SizedBox(width: 8),
                  const Text('(character match)',
                      style: TextStyle(
                        color: _kDimText, fontSize: 9)),
                ],
              ),
            ],
          ),
        );
    }
  }

  Widget _modChip(String label, bool on, ValueChanged<bool> toggle) {
    return GestureDetector(
      onTap: () => toggle(!on),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: on
              ? _kPrimary.withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: on ? _kAccent : _kDimText.withValues(alpha: 0.3),
          ),
        ),
        child: Text(label,
            style: TextStyle(
              color: on ? _kAccent : _kDimText,
              fontSize: 11,
              fontWeight: on ? FontWeight.w600 : FontWeight.w400,
            )),
      ),
    );
  }

  Widget _buildKeyCombo() {
    final keys = <Widget>[];
    if (_ctrlOn) {
      keys.add(_keyBadge('Ctrl', _kHighlight));
      keys.add(_plusSign());
    }
    if (_shiftOn) {
      keys.add(_keyBadge('Shift', _kSelected));
      keys.add(_plusSign());
    }
    if (_altOn) {
      keys.add(_keyBadge('Alt', _kPurple));
      keys.add(_plusSign());
    }
    if (_metaOn) {
      keys.add(_keyBadge('Meta', _kWarning));
      keys.add(_plusSign());
    }
    keys.add(_keyBadge('A', _kAccent));

    return Row(children: keys);
  }

  Widget _plusSign() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Text('+',
          style: TextStyle(color: _kDimText, fontSize: 12)),
    );
  }

  String _buildActivatorCode() {
    final mods = <String>[];
    if (_ctrlOn) mods.add('  control: true,');
    if (_shiftOn) mods.add('  shift: true,');
    if (_altOn) mods.add('  alt: true,');
    if (_metaOn) mods.add('  meta: true,');
    if (!_includeRepeats) mods.add('  includeRepeats: false,');
    final inner =
        mods.isEmpty ? '' : '\n${mods.join('\n')}\n';
    return 'const SingleActivator(\n'
        '  LogicalKeyboardKey.keyA,$inner)';
  }

  Widget _compareHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const SizedBox(width: 70),
          ...List.generate(3, (i) => Expanded(
            child: Text(_implNames[i],
                style: TextStyle(
                  color: _implColors[i],
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center),
          )),
        ],
      ),
    );
  }

  Widget _compareRow(
      String label, List<String> vals, List<Color> colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(label,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                )),
          ),
          ...List.generate(3, (i) => Expanded(
            child: Text(vals[i],
                style: TextStyle(
                  color: colors[i],
                  fontSize: 9,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center),
          )),
        ],
      ),
    );
  }

  Widget _propRow(String name, String type, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(name,
                style: const TextStyle(
                  color: _kHighlight,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(
            width: 80,
            child: Text(type,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 9,
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
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Shortcuts Widget
// ═══════════════════════════════════════════════════════════════════════════════

class _ShortcutsWidgetTab extends StatefulWidget {
  const _ShortcutsWidgetTab();
  @override
  State<_ShortcutsWidgetTab> createState() =>
      _ShortcutsWidgetTabState();
}

class _ShortcutsWidgetTabState extends State<_ShortcutsWidgetTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedView = 'integration';
  int _actionCount = 0;
  String _lastAction = 'None';
  bool _expandCommon = false;

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
          // View switcher
          _sectionTitle('Shortcuts Integration'),
          const SizedBox(height: 8),
          Row(
            children: [
              _viewChip('Pattern', 'integration'),
              const SizedBox(width: 8),
              _viewChip('Map Builder', 'builder'),
              const SizedBox(width: 8),
              _viewChip('Live Demo', 'live'),
            ],
          ),
          const SizedBox(height: 12),
          _buildSelectedView(),
          const SizedBox(height: 16),

          // Common bindings
          _sectionTitle('Common Shortcut Bindings'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () =>
                setState(() => _expandCommon = !_expandCommon),
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
                      const Text('Standard Shortcuts',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandCommon
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandCommon) ...[
                    const SizedBox(height: 8),
                    _shortcutEntry('Ctrl+A', 'SelectAllTextIntent',
                        'Select all text'),
                    _shortcutEntry('Ctrl+C', 'CopySelectionTextIntent',
                        'Copy selection'),
                    _shortcutEntry('Ctrl+V', 'PasteTextIntent',
                        'Paste clipboard'),
                    _shortcutEntry('Ctrl+X', 'CutSelectionTextIntent',
                        'Cut selection'),
                    _shortcutEntry('Ctrl+Z', 'UndoTextIntent',
                        'Undo last action'),
                    _shortcutEntry('Ctrl+Shift+Z', 'RedoTextIntent',
                        'Redo undone action'),
                    _shortcutEntry('Tab', 'NextFocusIntent',
                        'Move focus forward'),
                    _shortcutEntry('Shift+Tab', 'PreviousFocusIntent',
                        'Move focus backward'),
                    _shortcutEntry('Escape', 'DismissIntent',
                        'Dismiss current action'),
                    _shortcutEntry('Enter/Space', 'ActivateIntent',
                        'Activate focused widget'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Architecture diagram
          _sectionTitle('Architecture Flow'),
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
                _archNode('KeyEvent', _kDimText),
                _archArrow(),
                _archNode('Shortcuts widget', _kHighlight),
                _archArrow(),
                _archNode('ShortcutActivator.accepts()', _kAccent),
                _archArrow(),
                _archNode('Intent created', _kPurple),
                _archArrow(),
                _archNode('Actions widget', _kSelected),
                _archArrow(),
                _archNode('Action.invoke()', _kWarning),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'Shortcuts widget holds a Map<ShortcutActivator, Intent>. '
            'When a key event arrives, it iterates activators and '
            'calls accepts(). The first match produces an Intent, '
            'which Actions dispatches to the appropriate Action '
            'handler via Actions.invoke().',
          ),
        ],
      ),
    );
  }

  Widget _viewChip(String label, String value) {
    final sel = _selectedView == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedView = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: sel
              ? _kPrimary.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: sel
                ? _kAccent
                : _kDimText.withValues(alpha: 0.4),
          ),
        ),
        child: Text(label,
            style: TextStyle(
              color: sel ? _kAccent : _kDimText,
              fontSize: 11,
              fontWeight:
                  sel ? FontWeight.w600 : FontWeight.w400,
            )),
      ),
    );
  }

  Widget _buildSelectedView() {
    switch (_selectedView) {
      case 'integration':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Shortcuts + Actions Pattern',
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 8),
              _codeBlock(
                'Shortcuts(\n'
                '  shortcuts: <ShortcutActivator, Intent>{\n'
                '    const SingleActivator(\n'
                '      LogicalKeyboardKey.keyN,\n'
                '      control: true,\n'
                '    ): const _CreateNewIntent(),\n'
                '  },\n'
                '  child: Actions(\n'
                '    actions: <Type, Action<Intent>>{\n'
                '      _CreateNewIntent: CallbackAction(\n'
                '        onInvoke: (_) => doCreate(),\n'
                '      ),\n'
                '    },\n'
                '    child: const Focus(\n'
                '      autofocus: true,\n'
                '      child: MyApp(),\n'
                '    ),\n'
                '  ),\n'
                ')',
              ),
              const SizedBox(height: 8),
              const Text(
                'Keys:\n'
                '• ShortcutActivator maps key events to Intents\n'
                '• Intent is a lightweight description of action\n'
                '• Action handles the actual logic\n'
                '• Focus is required for key event delivery',
                style: TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      case 'builder':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Shortcut Map Construction',
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 8),
              _codeBlock(
                '// Const map (recommended)\n'
                'const kShortcuts =\n'
                '  <ShortcutActivator, Intent>{\n'
                '  SingleActivator(LogicalKeyboardKey.keyA,\n'
                '    control: true): ActivateIntent(),\n'
                '  SingleActivator(LogicalKeyboardKey.escape):\n'
                '    DismissIntent(),\n'
                '};\n'
                '\n'
                '// Runtime map (for dynamic shortcuts)\n'
                'final shortcuts =\n'
                '  <ShortcutActivator, Intent>{\n'
                '  for (final binding in userBindings)\n'
                '    binding.activator: binding.intent,\n'
                '};',
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(6),
                color: _kSurface,
                child: const Text(
                  'Const maps are evaluated at compile time. '
                  'Dynamic maps support user-configurable '
                  'shortcuts.',
                  style: TextStyle(
                    color: _kDimText, fontSize: 10),
                ),
              ),
            ],
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Live Action Demo',
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 8),
              const Text(
                'Tap buttons to simulate shortcut actions:',
                style: TextStyle(
                  color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _actionButton('Copy', Icons.copy, _kHighlight),
                  _actionButton('Paste', Icons.paste, _kSelected),
                  _actionButton('Cut', Icons.cut, _kPurple),
                  _actionButton('Undo', Icons.undo, _kWarning),
                  _actionButton('Redo', Icons.redo, _kAccent),
                  _actionButton(
                      'Select All', Icons.select_all, _kDimText),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: _kSurface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last: $_lastAction',
                      style: TextStyle(
                        color: _actionCount > 0
                            ? _kAccent
                            : _kDimText,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      'Total actions: $_actionCount',
                      style: const TextStyle(
                        color: _kDimText,
                        fontSize: 9,
                        fontFamily: 'monospace',
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

  Widget _actionButton(String name, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _actionCount++;
          _lastAction = '#$_actionCount $name';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
          border:
              Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(name,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }

  Widget _shortcutEntry(
      String keys, String intent, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(keys,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(
            width: 120,
            child: Text(intent,
                style: const TextStyle(
                  color: _kHighlight,
                  fontSize: 9,
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

  Widget _archNode(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }

  Widget _archArrow() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 8,
          color: _kDimText.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _keyBadge(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        )),
  );
}

Widget _hierNode(String name, bool current, Color color) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: current ? color : Colors.transparent,
          border: Border.all(color: color, width: 1.5),
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 10),
      Text(name,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: current ? FontWeight.w700 : FontWeight.w500,
          )),
    ],
  );
}

Widget _hierArrow() {
  return Padding(
    padding: const EdgeInsets.only(left: 4),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
          width: 1,
          height: 10,
          color: _kDimText.withValues(alpha: 0.3)),
    ),
  );
}

Widget _hierLeaf(String name, Color color) {
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(name,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontFamily: 'monospace',
        ),
        textAlign: TextAlign.center),
  );
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
    color: _kPrimary.withValues(alpha: 0.08),
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

Widget _sectionTitle(String title) {
  return Text(title,
      style: const TextStyle(
        color: _kAccent,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ));
}
