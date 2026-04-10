// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ShortcutMapProperty.
///
/// ShortcutMapProperty extends DiagnosticsProperty to display
/// `Map<ShortcutActivator, Intent>` in the widget inspector and
/// debug output.
///
/// Demonstrates:
/// - Tab 1 (Diagnostics): DiagnosticsProperty hierarchy, property
///   creation with various levels and showName options
/// - Tab 2 (Shortcut Map): Interactive map builder showing
///   activator→intent pairings with visual key badges
/// - Tab 3 (Debug Tree): Live diagnostics tree visualization,
///   node rendering, filtering by DiagnosticLevel

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF37474F); // BlueGrey 800
const Color _kAccent = Color(0xFFFFD180); // Orange A100
const Color _kSurface = Color(0xFF141A1E);
const Color _kCard = Color(0xFF242A2E);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF343A3E);
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
    home: const _ShortcutMapPropertyDemo(),
  );
}

class _ShortcutMapPropertyDemo extends StatefulWidget {
  const _ShortcutMapPropertyDemo();
  @override
  State<_ShortcutMapPropertyDemo> createState() =>
      _ShortcutMapPropertyDemoState();
}

class _ShortcutMapPropertyDemoState
    extends State<_ShortcutMapPropertyDemo>
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
          'ShortcutMapProperty',
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
            Tab(text: 'Diagnostics'),
            Tab(text: 'Shortcut Map'),
            Tab(text: 'Debug Tree'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _DiagnosticsTab(),
          _ShortcutMapTab(),
          _DebugTreeTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Diagnostics
// ═══════════════════════════════════════════════════════════════════════════════

class _DiagnosticsTab extends StatefulWidget {
  const _DiagnosticsTab();
  @override
  State<_DiagnosticsTab> createState() => _DiagnosticsTabState();
}

class _DiagnosticsTabState extends State<_DiagnosticsTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandHierarchy = false;
  int _selectedLevel = 0;
  bool _showName = true;

  static const _levels = [
    'info',
    'debug',
    'fine',
    'hidden',
  ];
  static const _levelColors = [
    _kHighlight,
    _kSelected,
    _kPurple,
    _kDimText,
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
          _sectionTitle('ShortcutMapProperty'),
          const SizedBox(height: 8),
          _codeBlock(
            'class ShortcutMapProperty\n'
            '    extends DiagnosticsProperty<\n'
            '      Map<ShortcutActivator, Intent>> {\n'
            '  ShortcutMapProperty(\n'
            '    String name,\n'
            '    Map<ShortcutActivator, Intent> value, {\n'
            '    bool showName = true,\n'
            '    Object defaultValue = kNoDefaultValue,\n'
            '    DiagnosticLevel level =\n'
            '      DiagnosticLevel.info,\n'
            '    String? description,\n'
            '  });\n'
            '}',
          ),
          const SizedBox(height: 16),

          // Hierarchy
          _sectionTitle('Type Hierarchy'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandHierarchy = !_expandHierarchy),
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
                      const Text('Inheritance Chain',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandHierarchy
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandHierarchy) ...[
                    const SizedBox(height: 8),
                    _hierNode('DiagnosticsNode', _kDimText),
                    _hierConnector(),
                    _hierNode('DiagnosticsProperty<T>', _kHighlight),
                    _hierConnector(),
                    _hierNodeActive(
                      'ShortcutMapProperty',
                      'T = Map<ShortcutActivator, Intent>',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Level selector
          _sectionTitle('DiagnosticLevel'),
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
                  'Select level to see how property renders:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(4, (i) {
                    final sel = _selectedLevel == i;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedLevel = i),
                        child: Container(
                          margin: EdgeInsets.only(
                              right: i < 3 ? 6 : 0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6),
                          decoration: BoxDecoration(
                            color: sel
                                ? _levelColors[i]
                                    .withValues(alpha: 0.2)
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(6),
                            border: Border.all(
                              color: sel
                                  ? _levelColors[i]
                                  : _kSubtle,
                            ),
                          ),
                          child: Text(
                            _levels[i],
                            style: TextStyle(
                              color: sel
                                  ? _levelColors[i]
                                  : _kDimText,
                              fontSize: 10,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: _kSurface,
                  child: Text(
                    _getLevelDescription(),
                    style: TextStyle(
                      color: _levelColors[_selectedLevel],
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // showName toggle
          _sectionTitle('showName Property'),
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
                    const Text(
                      'Show property name in output:',
                      style: TextStyle(
                          color: _kDimText, fontSize: 11),
                    ),
                    const Spacer(),
                    Switch(
                      value: _showName,
                      onChanged: (v) =>
                          setState(() => _showName = v),
                      activeTrackColor: _kSelected,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: _kSurface,
                  child: Text(
                    _showName
                        ? 'shortcuts: {Ctrl+A: ActivateIntent}'
                        : '{Ctrl+A: ActivateIntent}',
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

          // Constructor parameters
          _sectionTitle('Constructor Parameters'),
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
                _paramRow('name', 'String',
                    'Property name for display', true),
                _paramRow('value',
                    'Map<ShortcutActivator, Intent>',
                    'The shortcut map to display', true),
                _paramRow('showName', 'bool',
                    'Whether to include name in output',
                    false),
                _paramRow('defaultValue', 'Object',
                    'Value considered default (omitted)',
                    false),
                _paramRow('level', 'DiagnosticLevel',
                    'Visibility level in tree output',
                    false),
                _paramRow('description', 'String?',
                    'Custom description override',
                    false),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'ShortcutMapProperty is a specialized DiagnosticsProperty '
            'that formats shortcut maps for the widget inspector. It '
            'overrides valueToString to render activator→intent '
            'pairs in a readable format.',
          ),
        ],
      ),
    );
  }

  String _getLevelDescription() {
    switch (_selectedLevel) {
      case 0:
        return 'info: Always shown in diagnostics output.\n'
            'Default level for ShortcutMapProperty.';
      case 1:
        return 'debug: Shown only with verbose diagnostics.\n'
            'Hidden in standard inspector view.';
      case 2:
        return 'fine: Shown only at highest verbosity.\n'
            'Used for internal framework properties.';
      default:
        return 'hidden: Never shown in any output.\n'
            'Property exists but is invisible.';
    }
  }

  Widget _hierNode(String name, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
        ),
        const SizedBox(width: 8),
        Text(name,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontFamily: 'monospace',
            )),
      ],
    );
  }

  Widget _hierConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Container(
          width: 1,
          height: 8,
          color: _kDimText.withValues(alpha: 0.3)),
    );
  }

  Widget _hierNodeActive(String name, String subtitle) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                )),
            Text(subtitle,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 9,
                  fontFamily: 'monospace',
                )),
          ],
        ),
      ],
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
            width: 80,
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
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Shortcut Map
// ═══════════════════════════════════════════════════════════════════════════════

class _ShortcutMapTab extends StatefulWidget {
  const _ShortcutMapTab();
  @override
  State<_ShortcutMapTab> createState() => _ShortcutMapTabState();
}

class _ShortcutMapTabState extends State<_ShortcutMapTab>
    with AutomaticKeepAliveClientMixin {
  final List<_ShortcutBinding> _bindings = [
    _ShortcutBinding('Ctrl+A', 'ActivateIntent',
        'Activate focused widget'),
    _ShortcutBinding('Escape', 'DismissIntent',
        'Dismiss current overlay'),
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
          _sectionTitle('Shortcut Map Contents'),
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
                  'Map<ShortcutActivator, Intent> entries:',
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ..._bindings.asMap().entries.map((e) {
                  final i = e.key;
                  final b = e.value;
                  return _bindingCard(b, i);
                }),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _bindings.add(_ShortcutBinding(
                              _nextKey(),
                              _nextIntent(),
                              'Custom binding',
                            ));
                          });
                        },
                        icon: const Icon(Icons.add, size: 14),
                        label: const Text('Add Binding',
                            style: TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _kPrimary.withValues(alpha: 0.4),
                          foregroundColor: _kAccent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _bindings.length > 1
                            ? () => setState(
                                () => _bindings.removeLast())
                            : null,
                        icon: const Icon(Icons.remove, size: 14),
                        label: const Text('Remove',
                            style: TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _kWarning.withValues(alpha: 0.15),
                          foregroundColor: _kWarning,
                          disabledBackgroundColor: _kSubtle,
                          disabledForegroundColor:
                              _kDimText.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // valueToString output
          _sectionTitle('valueToString() Output'),
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
                  'How ShortcutMapProperty renders the map:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  color: _kSurface,
                  child: Text(
                    _buildValueString(),
                    style: const TextStyle(
                      color: _kAccent,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_bindings.length} binding(s) in map',
                  style: const TextStyle(
                    color: _kDimText,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Property code
          _sectionTitle('Creating the Property'),
          const SizedBox(height: 8),
          _codeBlock(
            '// In debugFillProperties:\n'
            '@override\n'
            'void debugFillProperties(\n'
            '  DiagnosticPropertiesBuilder properties,\n'
            ') {\n'
            '  super.debugFillProperties(properties);\n'
            '  properties.add(ShortcutMapProperty(\n'
            '    \'shortcuts\',\n'
            '    _shortcuts,\n'
            '    description: description,\n'
            '    showName: true,\n'
            '  ));\n'
            '}',
          ),
          const SizedBox(height: 16),

          // Visual key legend
          _sectionTitle('Key Badge Legend'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _keyBadge('Ctrl', _kHighlight),
                _keyBadge('Shift', _kSelected),
                _keyBadge('Alt', _kPurple),
                _keyBadge('Meta', _kWarning),
                _keyBadge('A-Z', _kAccent),
                _keyBadge('Esc', _kDimText),
                _keyBadge('Tab', _kDimText),
                _keyBadge('F1-F12', _kDimText),
                _keyBadge('Space', _kDimText),
                _keyBadge('Enter', _kDimText),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'ShortcutMapProperty formats the map using each '
            'activator\'s debugDescribeKeys() method. The output '
            'appears in Flutter DevTools and toStringDeep() dumps. '
            'It helps debug which shortcuts are registered.',
          ),
        ],
      ),
    );
  }

  Widget _bindingCard(_ShortcutBinding b, int index) {
    final colors = [_kHighlight, _kSelected, _kPurple, _kAccent,
        _kWarning, _kDimText];
    final color = colors[index % colors.length];
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(6),
        border:
            Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          _keyBadge(b.keys, color),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward,
              size: 12, color: _kDimText),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(b.intent,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    )),
                Text(b.description,
                    style: const TextStyle(
                      color: _kDimText, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildValueString() {
    final entries = _bindings
        .map((b) => '  ${b.keys}: ${b.intent}')
        .join('\n');
    return '{\n$entries\n}';
  }

  String _nextKey() {
    const keys = [
      'Ctrl+S', 'Ctrl+Z', 'Ctrl+Shift+Z',
      'Tab', 'Shift+Tab', 'F1', 'Space',
    ];
    return keys[_bindings.length % keys.length];
  }

  String _nextIntent() {
    const intents = [
      'DismissIntent', 'NextFocusIntent',
      'PreviousFocusIntent', 'ScrollIntent',
      'SelectAllTextIntent', 'UndoTextIntent',
      'RedoTextIntent',
    ];
    return intents[_bindings.length % intents.length];
  }
}

class _ShortcutBinding {
  final String keys;
  final String intent;
  final String description;
  _ShortcutBinding(this.keys, this.intent, this.description);
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Debug Tree
// ═══════════════════════════════════════════════════════════════════════════════

class _DebugTreeTab extends StatefulWidget {
  const _DebugTreeTab();
  @override
  State<_DebugTreeTab> createState() => _DebugTreeTabState();
}

class _DebugTreeTabState extends State<_DebugTreeTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedFilter = 0;
  bool _expandNodes = true;

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
          _sectionTitle('Widget Inspector Tree'),
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
                    const Text(
                      'Diagnostics tree:',
                      style: TextStyle(
                        color: _kAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => setState(
                          () => _expandNodes = !_expandNodes),
                      child: Text(
                        _expandNodes
                            ? 'Collapse'
                            : 'Expand',
                        style: const TextStyle(
                          color: _kHighlight,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _treeNode(0, 'Shortcuts', _kHighlight, false),
                if (_expandNodes) ...[
                  _treeNode(1, 'shortcuts:', _kAccent, false),
                  _treeNode(
                      2,
                      'Ctrl + A → ActivateIntent',
                      _kSelected,
                      false),
                  _treeNode(
                      2,
                      'Escape → DismissIntent',
                      _kSelected,
                      false),
                  _treeNode(
                      2,
                      'Tab → NextFocusIntent',
                      _kSelected,
                      false),
                  _treeNode(1, 'child: Actions', _kDimText, false),
                  _treeNode(
                      2,
                      'actions: {ActivateIntent, DismissIntent}',
                      _kPurple,
                      true),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Filter by level
          _sectionTitle('Filter by Level'),
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
                    _filterChip('All', 0),
                    const SizedBox(width: 6),
                    _filterChip('Info+', 1),
                    const SizedBox(width: 6),
                    _filterChip('Debug+', 2),
                    const SizedBox(width: 6),
                    _filterChip('Fine+', 3),
                  ],
                ),
                const SizedBox(height: 8),
                ..._getFilteredProperties(),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // toStringDeep output
          _sectionTitle('toStringDeep() Output'),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Shortcuts\n'
              ' ├─shortcuts: {\n'
              ' │   Ctrl + A: ActivateIntent\n'
              ' │   Escape: DismissIntent\n'
              ' │   Tab: NextFocusIntent\n'
              ' │ }\n'
              ' └─child: Actions',
              style: TextStyle(
                color: _kAccent,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // How it is used internally
          _sectionTitle('Usage in Shortcuts Widget'),
          const SizedBox(height: 8),
          _codeBlock(
            '// Inside Shortcuts.debugFillProperties:\n'
            'properties.add(\n'
            '  ShortcutMapProperty(\n'
            '    \'shortcuts\',\n'
            '    manager.shortcuts,\n'
            '    description: manager.debugDescribe\n'
            '      ? null : \'<disabled>\',\n'
            '  ),\n'
            ');',
          ),
          const SizedBox(height: 16),

          // Related diagnostics
          _sectionTitle('Related Diagnostics'),
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
                _relatedRow('DiagnosticsProperty<T>',
                    'Base class for typed properties', _kHighlight),
                _relatedRow('FlagProperty',
                    'Boolean flag display', _kSelected),
                _relatedRow('EnumProperty<T>',
                    'Enum value display', _kPurple),
                _relatedRow('IterableProperty<T>',
                    'List/set display', _kAccent),
                _relatedRow('ColorProperty',
                    'Color swatch display', _kWarning),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'The debug tree shows ShortcutMapProperty using each '
            'activator\'s debugDescribeKeys. This output appears '
            'in Flutter DevTools Inspector and in toStringDeep '
            'calls. Filter levels let you control verbosity.',
          ),
        ],
      ),
    );
  }

  Widget _treeNode(
      int depth, String text, Color color, bool isLast) {
    final prefix = depth == 0
        ? ''
        : ' ${'│ ' * (depth - 1)}${isLast ? '└─' : '├─'}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        '$prefix$text',
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _filterChip(String label, int value) {
    final sel = _selectedFilter == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: sel
              ? _kPrimary.withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                sel ? _kAccent : _kDimText.withValues(alpha: 0.3),
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

  List<Widget> _getFilteredProperties() {
    final all = [
      _propEntry('shortcuts', 'info', _kHighlight, true),
      _propEntry('manager', 'debug', _kSelected, true),
      _propEntry('internal_cache', 'fine', _kPurple, true),
      _propEntry('disposed', 'hidden', _kDimText, false),
    ];

    return all
        .where((e) =>
            _selectedFilter == 0 ||
            all.indexOf(e) < _selectedFilter + 1)
        .toList();
  }

  Widget _propEntry(
      String name, String level, Color color, bool visible) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: visible
            ? color.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: visible
              ? color.withValues(alpha: 0.3)
              : _kSubtle.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Text(name,
              style: TextStyle(
                color: visible ? color : _kDimText,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              )),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(level,
                style: TextStyle(
                  color: color,
                  fontSize: 8,
                  fontFamily: 'monospace',
                )),
          ),
          const SizedBox(width: 8),
          Icon(
            visible
                ? Icons.visibility
                : Icons.visibility_off,
            size: 12,
            color: visible
                ? color
                : _kDimText.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }

  Widget _relatedRow(
      String name, String desc, Color color) {
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
          Expanded(
            child: Row(
              children: [
                Text(name,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(desc,
                      style: const TextStyle(
                        color: _kDimText, fontSize: 9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _keyBadge(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        )),
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

Widget _sectionTitle(String title) {
  return Text(title,
      style: const TextStyle(
        color: _kAccent,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ));
}
