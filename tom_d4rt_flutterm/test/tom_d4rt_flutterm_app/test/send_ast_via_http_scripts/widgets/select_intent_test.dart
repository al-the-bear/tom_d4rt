// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SelectIntent.
///
/// SelectIntent is a simple, parameterless Intent that signals the desire
/// to select the currently focused control. Distinct from ActivateIntent
/// which triggers/activates the control.
///
/// Demonstrates:
/// - Tab 1 (Intent Pattern): SelectIntent anatomy, const constructor,
///   Intent inheritance, Select vs Activate vs Dismiss comparison
/// - Tab 2 (Action Binding): Actions widget registration, invoke/find
///   patterns, isActionEnabled checks, Shortcuts integration
/// - Tab 3 (Use Cases): Multi-select list, checkbox toggle, focus-select
///   interaction, custom SelectAction implementation

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF00796B); // Teal 700
const Color _kAccent = Color(0xFFFF80AB); // Pink A100
const Color _kSurface = Color(0xFF1A1C1E);
const Color _kCard = Color(0xFF2A2C2E);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3A3C3E);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kSelected = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);

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
    home: const _SelectIntentDemo(),
  );
}

class _SelectIntentDemo extends StatefulWidget {
  const _SelectIntentDemo();
  @override
  State<_SelectIntentDemo> createState() => _SelectIntentDemoState();
}

class _SelectIntentDemoState extends State<_SelectIntentDemo>
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
          'SelectIntent',
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
            Tab(text: 'Intent Pattern'),
            Tab(text: 'Action Binding'),
            Tab(text: 'Use Cases'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _IntentPatternTab(),
          _ActionBindingTab(),
          _UseCasesTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Intent Pattern
// ═══════════════════════════════════════════════════════════════════════════════

class _IntentPatternTab extends StatefulWidget {
  const _IntentPatternTab();
  @override
  State<_IntentPatternTab> createState() => _IntentPatternTabState();
}

class _IntentPatternTabState extends State<_IntentPatternTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedComparison = 0;

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
          // ── Constructor ──
          _buildSectionTitle('Constructor'),
          const SizedBox(height: 8),
          _buildCodeBlock('const SelectIntent()'),
          const SizedBox(height: 4),
          const Text(
            'No parameters. A pure signal intent — '
            'just declares the user\'s desire to select.',
            style: TextStyle(color: _kDimText, fontSize: 11),
          ),
          const SizedBox(height: 16),

          // ── Inheritance ──
          _buildSectionTitle('Inheritance'),
          const SizedBox(height: 8),
          _buildInheritanceChain(),
          const SizedBox(height: 16),

          // ── Intent anatomy ──
          _buildSectionTitle('Anatomy of SelectIntent'),
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
                _anatomyRow(
                  'Type',
                  'Intent (abstract base)',
                  Icons.category,
                ),
                const Divider(color: _kSubtle, height: 16),
                _anatomyRow(
                  'Parameters',
                  'None — const, parameterless',
                  Icons.data_object,
                ),
                const Divider(color: _kSubtle, height: 16),
                _anatomyRow(
                  'Package',
                  'flutter/src/widgets/actions.dart',
                  Icons.folder_outlined,
                ),
                const Divider(color: _kSubtle, height: 16),
                _anatomyRow(
                  'Default Key',
                  'No default key binding',
                  Icons.keyboard_alt_outlined,
                ),
                const Divider(color: _kSubtle, height: 16),
                _anatomyRow(
                  'Semantics',
                  'Select, do not activate',
                  Icons.check_box,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Intent flow ──
          _buildSectionTitle('Intent → Action Flow'),
          const SizedBox(height: 8),
          _buildFlowDiagram(),
          const SizedBox(height: 16),

          // ── Select vs Activate vs Dismiss ──
          _buildSectionTitle('Intent Comparison'),
          const SizedBox(height: 8),
          _buildComparisonSelector(),
          const SizedBox(height: 8),
          _buildComparisonDetail(),
          const SizedBox(height: 16),

          _buildInfoBanner(
            'SelectIntent has no parameters because "select" is a generic '
            'concept. The meaning of "select" depends entirely on the '
            'Action implementation registered for the current widget subtree.',
          ),
        ],
      ),
    );
  }

  Widget _buildInheritanceChain() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _chainRow('Object', false),
          _chainConnector(),
          _chainRow('Intent', false),
          _chainConnector(),
          _chainRow('SelectIntent', true),
        ],
      ),
    );
  }

  Widget _chainRow(String name, bool current) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: current ? _kAccent : Colors.transparent,
            border: Border.all(
              color: current ? _kAccent : _kDimText,
              width: 1.5,
            ),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(
            color: current ? _kAccent : _kDimText,
            fontSize: 12,
            fontWeight: current ? FontWeight.w700 : FontWeight.w500,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _chainConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 12,
          color: _kDimText.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _anatomyRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: _kPrimary),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlowDiagram() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _flowNode('User gesture / programmatic trigger', _kDimText),
          _flowConnector(),
          _flowNode('const SelectIntent() created', _kAccent),
          _flowConnector(),
          _flowNode('Actions.invoke(context, intent)', _kPrimary),
          _flowConnector(),
          _flowNode('Walk ancestor tree → find Action<SelectIntent>',
              _kHighlight),
          _flowConnector(),
          _flowNode(
              'action.isActionEnabled ? invoke(intent) : noop', _kSelected),
        ],
      ),
    );
  }

  Widget _flowNode(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _flowConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 10,
          color: _kDimText.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildComparisonSelector() {
    final items = ['SelectIntent', 'ActivateIntent', 'DismissIntent'];
    return Row(
      children: List.generate(3, (i) {
        final selected = _selectedComparison == i;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => setState(() => _selectedComparison = i),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: selected
                    ? _kPrimary.withValues(alpha: 0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      selected ? _kAccent : _kDimText.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                items[i],
                style: TextStyle(
                  color: selected ? _kAccent : _kDimText,
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildComparisonDetail() {
    final data = _comparisonData[_selectedComparison];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: data['color'] as Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(data['icon'] as IconData, size: 18,
                  color: data['color'] as Color),
              const SizedBox(width: 8),
              Text(
                data['name'] as String,
                style: TextStyle(
                  color: data['color'] as Color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data['purpose'] as String,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 6),
          ...(data['examples'] as List<String>).map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('•  ',
                      style: TextStyle(
                          color: data['color'] as Color, fontSize: 10)),
                  Expanded(
                    child: Text(e,
                        style: const TextStyle(
                            color: _kDimText, fontSize: 10)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text(
                'Default Key: ',
                style: TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  data['key'] as String,
                  style: TextStyle(
                    color: data['color'] as Color,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get _comparisonData => [
        {
          'name': 'SelectIntent',
          'color': _kAccent,
          'icon': Icons.check_box_outlined,
          'purpose':
              'Select or toggle the focused control\'s selection state '
                  'without triggering its primary action.',
          'examples': [
            'Select a checkbox in a list (changes selection, not form value)',
            'Mark item in multi-select without navigating',
            'Toggle highlight on focused widget',
          ],
          'key': 'None (app-defined)',
        },
        {
          'name': 'ActivateIntent',
          'color': _kHighlight,
          'icon': Icons.touch_app,
          'purpose':
              'Activate the primary action of the focused control — '
                  'equivalent to tapping or clicking it.',
          'examples': [
            'Press a button (triggers onPressed)',
            'Toggle a switch (ON/OFF)',
            'Submit a form field',
          ],
          'key': 'Enter / Space',
        },
        {
          'name': 'DismissIntent',
          'color': _kWarning,
          'icon': Icons.close,
          'purpose':
              'Dismiss the current focused overlay, dialog, or widget — '
                  'like pressing Escape.',
          'examples': [
            'Close a popup menu',
            'Dismiss a dialog',
            'Exit full-screen overlay',
          ],
          'key': 'Escape',
        },
      ];
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Action Binding
// ═══════════════════════════════════════════════════════════════════════════════

class _ActionBindingTab extends StatefulWidget {
  const _ActionBindingTab();
  @override
  State<_ActionBindingTab> createState() => _ActionBindingTabState();
}

class _ActionBindingTabState extends State<_ActionBindingTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedPattern = 'register';
  int _invokeCount = 0;
  bool _actionEnabled = true;
  String _lastResult = 'No invocation yet';
  bool _foundAction = false;

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
          // ── Pattern tabs ──
          _buildSectionTitle('Registration Patterns'),
          const SizedBox(height: 8),
          Row(
            children: [
              _patternChip('Register', 'register'),
              const SizedBox(width: 8),
              _patternChip('Invoke', 'invoke'),
              const SizedBox(width: 8),
              _patternChip('Find', 'find'),
            ],
          ),
          const SizedBox(height: 12),
          _buildPatternCode(),
          const SizedBox(height: 16),

          // ── Live action demo ──
          _buildSectionTitle('Live Action Demo'),
          const SizedBox(height: 8),
          _buildLiveActionDemo(),
          const SizedBox(height: 16),

          // ── Action enabled toggle ──
          _buildSectionTitle('isActionEnabled'),
          const SizedBox(height: 8),
          _buildEnabledDemo(),
          const SizedBox(height: 16),

          // ── maybeFind demo ──
          _buildSectionTitle('Actions.maybeFind'),
          const SizedBox(height: 8),
          _buildMaybeFindDemo(),
          const SizedBox(height: 16),

          // ── Shortcuts binding ──
          _buildSectionTitle('Binding to Shortcuts'),
          const SizedBox(height: 8),
          _buildShortcutsBinding(),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectIntent is typically not bound to any default keyboard '
            'shortcut. Your app must define custom Shortcuts if you want '
            'keyboard-triggered selection.',
          ),
        ],
      ),
    );
  }

  Widget _patternChip(String label, String value) {
    final selected = _selectedPattern == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPattern = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? _kPrimary.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _kAccent : _kDimText.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _kAccent : _kDimText,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildPatternCode() {
    final codes = <String, String>{
      'register':
          'Actions(\n'
          '  actions: <Type, Action<Intent>>{\n'
          '    SelectIntent: CallbackAction<SelectIntent>(\n'
          '      onInvoke: (intent) {\n'
          '        // Handle selection\n'
          '        toggleSelection();\n'
          '        return null;\n'
          '      },\n'
          '    ),\n'
          '  },\n'
          '  child: myWidget,\n'
          ')',
      'invoke':
          '// Programmatic invocation:\n'
          'Actions.invoke<SelectIntent>(\n'
          '  context,\n'
          '  const SelectIntent(),\n'
          ');\n'
          '\n'
          '// Returns the result from\n'
          '// Action.invoke()',
      'find':
          '// Check if action exists:\n'
          'final action = Actions.maybeFind<SelectIntent>(\n'
          '  context,\n'
          ');\n'
          '\n'
          'if (action != null) {\n'
          '  // Action registered upstream\n'
          '  final enabled = action.isActionEnabled;\n'
          '  if (enabled) {\n'
          '    Actions.invoke(context,\n'
          '      const SelectIntent());\n'
          '  }\n'
          '}',
    };
    return _buildCodeBlock(codes[_selectedPattern]!);
  }

  Widget _buildLiveActionDemo() {
    return Actions(
      actions: <Type, Action<Intent>>{
        SelectIntent: CallbackAction<SelectIntent>(
          onInvoke: (_) {
            setState(() {
              _invokeCount++;
              _lastResult = 'Invocation #$_invokeCount received';
            });
            return null;
          },
        ),
      },
      child: Builder(
        builder: (innerContext) {
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
                const Text(
                  'Actions widget with CallbackAction<SelectIntent>:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Actions.invoke<SelectIntent>(
                            innerContext,
                            const SelectIntent(),
                          );
                        },
                        icon: const Icon(Icons.check_box_outlined, size: 16),
                        label: const Text(
                          'Invoke SelectIntent',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kPrimary.withValues(alpha: 0.3),
                          foregroundColor: _kAccent,
                          side: BorderSide(
                              color: _kAccent.withValues(alpha: 0.4)),
                        ),
                      ),
                    ),
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
                        _lastResult,
                        style: TextStyle(
                          color: _invokeCount > 0 ? _kSelected : _kDimText,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total invocations: $_invokeCount',
                        style: const TextStyle(
                          color: _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEnabledDemo() {
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
          const Text(
            'Actions can be conditionally enabled/disabled:',
            style: TextStyle(color: _kDimText, fontSize: 11),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Action enabled:',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const Spacer(),
              Switch(
                value: _actionEnabled,
                onChanged: (v) => setState(() => _actionEnabled = v),
                activeTrackColor: _kSelected,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(8),
            color: _kSurface,
            child: Row(
              children: [
                Icon(
                  _actionEnabled ? Icons.check : Icons.block,
                  size: 14,
                  color: _actionEnabled ? _kSelected : _kWarning,
                ),
                const SizedBox(width: 8),
                Text(
                  _actionEnabled
                      ? 'isActionEnabled = true → invoke() will run'
                      : 'isActionEnabled = false → invoke() is a no-op',
                  style: TextStyle(
                    color: _actionEnabled ? _kSelected : _kWarning,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'class MySelectAction extends Action<SelectIntent> {\n'
            '  @override\n'
            '  bool get isActionEnabled => _canSelect;\n'
            '\n'
            '  @override\n'
            '  void invoke(SelectIntent intent) {\n'
            '    // Only called when enabled\n'
            '  }\n'
            '}',
          ),
        ],
      ),
    );
  }

  Widget _buildMaybeFindDemo() {
    return Actions(
      actions: <Type, Action<Intent>>{
        SelectIntent: CallbackAction<SelectIntent>(
          onInvoke: (_) => null,
        ),
      },
      child: Builder(
        builder: (innerContext) {
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
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final action =
                              Actions.maybeFind<SelectIntent>(innerContext);
                          setState(() => _foundAction = action != null);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kHighlight.withValues(alpha: 0.2),
                          foregroundColor: _kHighlight,
                        ),
                        child: const Text(
                          'Actions.maybeFind<SelectIntent>',
                          style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: _kSurface,
                  child: Row(
                    children: [
                      Icon(
                        _foundAction ? Icons.check_circle : Icons.help_outline,
                        size: 14,
                        color: _foundAction ? _kSelected : _kDimText,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _foundAction
                            ? 'Found: Action<SelectIntent> registered ✓'
                            : 'Tap button to search ancestors',
                        style: TextStyle(
                          color: _foundAction ? _kSelected : _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShortcutsBinding() {
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
          const Text(
            'Add custom keyboard binding:',
            style: TextStyle(
              color: _kAccent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'Shortcuts(\n'
            '  shortcuts: {\n'
            '    SingleActivator(\n'
            '      LogicalKeyboardKey.space,\n'
            '      control: true,\n'
            '    ): const SelectIntent(),\n'
            '  },\n'
            '  child: Actions(\n'
            '    actions: {\n'
            '      SelectIntent: myAction,\n'
            '    },\n'
            '    child: myWidget,\n'
            '  ),\n'
            ')',
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            color: _kSurface,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Common binding patterns:',
                  style: TextStyle(
                    color: _kDimText,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '  Ctrl+Space → SelectIntent()\n'
                  '  Enter      → ActivateIntent()\n'
                  '  Escape     → DismissIntent()',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
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

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Use Cases
// ═══════════════════════════════════════════════════════════════════════════════

class _UseCasesTab extends StatefulWidget {
  const _UseCasesTab();
  @override
  State<_UseCasesTab> createState() => _UseCasesTabState();
}

class _UseCasesTabState extends State<_UseCasesTab>
    with AutomaticKeepAliveClientMixin {
  // Multi-select demo
  final Set<int> _selectedItems = {};
  int _focusedItem = -1;

  // Checkbox toggle demo
  final List<bool> _checkStates = [false, false, false, false, false];
  final List<String> _checkLabels = [
    'Review code changes',
    'Update documentation',
    'Run integration tests',
    'Deploy to staging',
    'Notify team members',
  ];

  // Focus-select demo
  int _focusSelectIndex = -1;
  int _selectEventCount = 0;

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
          // ── Multi-select list ──
          _buildSectionTitle('Use Case 1: Multi-Select List'),
          const SizedBox(height: 8),
          _buildMultiSelectDemo(),
          const SizedBox(height: 16),

          // ── Checkbox toggle ──
          _buildSectionTitle('Use Case 2: Checkbox Toggle'),
          const SizedBox(height: 8),
          _buildCheckboxDemo(),
          const SizedBox(height: 16),

          // ── Focus-select interaction ──
          _buildSectionTitle('Use Case 3: Focus-Select Interaction'),
          const SizedBox(height: 8),
          _buildFocusSelectDemo(),
          const SizedBox(height: 16),

          // ── Custom action implementation ──
          _buildSectionTitle('Custom SelectAction Implementation'),
          const SizedBox(height: 8),
          _buildCustomActionCode(),
          const SizedBox(height: 16),

          // ── When to use ──
          _buildSectionTitle('When to Use SelectIntent'),
          const SizedBox(height: 8),
          _buildUsageGuidance(),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'Use SelectIntent when you need to distinguish between '
            '"selecting" (marking/highlighting) and "activating" '
            '(triggering) a control. If your control only has one action, '
            'ActivateIntent is usually sufficient.',
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSelectDemo() {
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
          Row(
            children: [
              const Text(
                'Tap items to select/deselect',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const Spacer(),
              Text(
                '${_selectedItems.length} selected',
                style: TextStyle(
                  color: _selectedItems.isNotEmpty ? _kAccent : _kDimText,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...List.generate(6, (i) {
            final selected = _selectedItems.contains(i);
            final focused = _focusedItem == i;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _focusedItem = i;
                  if (selected) {
                    _selectedItems.remove(i);
                  } else {
                    _selectedItems.add(i);
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: selected
                      ? _kPrimary.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: focused
                        ? _kAccent
                        : selected
                            ? _kPrimary.withValues(alpha: 0.4)
                            : Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      selected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 16,
                      color: selected ? _kAccent : _kDimText,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Item ${i + 1}',
                      style: TextStyle(
                        color: selected ? _kAccent : Colors.white70,
                        fontSize: 12,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    if (focused)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _kAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'focused',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 8,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 6),
          if (_selectedItems.isNotEmpty)
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _selectedItems.clear()),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _kWarning.withValues(alpha: 0.4)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Clear All',
                      style:
                          TextStyle(color: _kWarning, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCheckboxDemo() {
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
          const Text(
            'SelectIntent toggles check state without activating:',
            style: TextStyle(color: _kDimText, fontSize: 11),
          ),
          const SizedBox(height: 8),
          ...List.generate(5, (i) {
            return GestureDetector(
              onTap: () {
                setState(() => _checkStates[i] = !_checkStates[i]);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: _checkStates[i]
                            ? _kPrimary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: _checkStates[i] ? _kPrimary : _kDimText,
                          width: 1.5,
                        ),
                      ),
                      child: _checkStates[i]
                          ? const Icon(Icons.check,
                              size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _checkLabels[i],
                        style: TextStyle(
                          color: _checkStates[i]
                              ? Colors.white70
                              : _kDimText,
                          fontSize: 12,
                          decoration: _checkStates[i]
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(6),
            color: _kSurface,
            child: Text(
              'Done: ${_checkStates.where((b) => b).length}/${_checkStates.length}',
              style: const TextStyle(
                color: _kDimText,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusSelectDemo() {
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
          const Text(
            'Focus + SelectIntent → selection follows focus:',
            style: TextStyle(color: _kDimText, fontSize: 11),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (i) {
              final focused = _focusSelectIndex == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _focusSelectIndex = i;
                      _selectEventCount++;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 50,
                    decoration: BoxDecoration(
                      color: focused
                          ? _kPrimary.withValues(alpha: 0.3)
                          : _kSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: focused ? _kAccent : _kSubtle,
                        width: focused ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            focused
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            size: 16,
                            color: focused ? _kAccent : _kDimText,
                          ),
                          Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: focused ? _kAccent : _kDimText,
                              fontSize: 10,
                              fontWeight: focused
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(6),
            color: _kSurface,
            child: Row(
              children: [
                Text(
                  'Focus-select events: $_selectEventCount',
                  style: const TextStyle(
                    color: _kDimText,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
                const Spacer(),
                Text(
                  _focusSelectIndex >= 0
                      ? 'Selected: #${_focusSelectIndex + 1}'
                      : 'None selected',
                  style: TextStyle(
                    color: _focusSelectIndex >= 0 ? _kAccent : _kDimText,
                    fontSize: 10,
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

  Widget _buildCustomActionCode() {
    return _buildCodeBlock(
      'class MySelectAction extends Action<SelectIntent> {\n'
      '  final ValueNotifier<Set<int>> selection;\n'
      '  final int itemIndex;\n'
      '\n'
      '  MySelectAction(this.selection, this.itemIndex);\n'
      '\n'
      '  @override\n'
      '  bool get isActionEnabled => true;\n'
      '\n'
      '  @override\n'
      '  Object? invoke(SelectIntent intent) {\n'
      '    final current = Set<int>.from(selection.value);\n'
      '    if (current.contains(itemIndex)) {\n'
      '      current.remove(itemIndex);\n'
      '    } else {\n'
      '      current.add(itemIndex);\n'
      '    }\n'
      '    selection.value = current;\n'
      '    return null;\n'
      '  }\n'
      '}',
    );
  }

  Widget _buildUsageGuidance() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _guidanceRow(
            'Use SelectIntent',
            'Multi-select lists, checkbox grids, focus-follows-selection',
            true,
          ),
          const Divider(color: _kSubtle, height: 16),
          _guidanceRow(
            'Use ActivateIntent',
            'Buttons, switches, single-action controls',
            false,
          ),
          const Divider(color: _kSubtle, height: 16),
          _guidanceRow(
            'Use DismissIntent',
            'Closing overlays, canceling dialogs',
            false,
          ),
          const Divider(color: _kSubtle, height: 16),
          _guidanceRow(
            'Combine both',
            'List items: Select marks them, Activate opens detail',
            true,
          ),
        ],
      ),
    );
  }

  Widget _guidanceRow(String title, String desc, bool recommended) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          recommended ? Icons.check_circle : Icons.info_outline,
          size: 14,
          color: recommended ? _kSelected : _kDimText,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: recommended ? _kAccent : Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(color: _kDimText, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.08),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline, size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _kDimText, fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: _kAccent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}
