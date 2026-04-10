// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ScrollToDocumentBoundaryIntent.
///
/// ScrollToDocumentBoundaryIntent is an Intent that scrolls to the beginning
/// or end of a document based on the forward parameter. It extends
/// DirectionalTextEditingIntent and is used by text editing shortcuts.
///
/// Demonstrates:
/// - Tab 1 (Intent Anatomy): Constructor with forward parameter, inheritance
///   from DirectionalTextEditingIntent, relationship to Intent/Action pattern,
///   and keyboard shortcut binding
/// - Tab 2 (Shortcuts Mapping): Platform keyboard shortcuts (Ctrl+Home/End,
///   Cmd+Up/Down), DefaultTextEditingShortcuts integration, and how Shortcuts
///   widget maps key combinations to this intent
/// - Tab 3 (Actions Pattern): Flutter Actions/Shortcuts/Intent architecture,
///   _ScrollToDocumentBoundaryAction binding, related editing intents, and
///   integration with TextField/EditableText

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF546E7A); // BlueGrey 700
const Color _kAccent = Color(0xFFB9F6CA); // Green A100
const Color _kSurface = Color(0xFF1A1C1F);
const Color _kCard = Color(0xFF292B2E);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3A3C3F);
const Color _kHighlight = Color(0xFF7E57C2);
const Color _kForward = Color(0xFF42A5F5);
const Color _kBackward = Color(0xFFEF5350);

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
    home: const _IntentDemo(),
  );
}

class _IntentDemo extends StatefulWidget {
  const _IntentDemo();
  @override
  State<_IntentDemo> createState() => _IntentDemoState();
}

class _IntentDemoState extends State<_IntentDemo>
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
          'ScrollToDocumentBoundaryIntent',
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
            Tab(text: 'Shortcuts'),
            Tab(text: 'Actions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _IntentAnatomyTab(),
          _ShortcutsMappingTab(),
          _ActionsPatternTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Intent Anatomy
// ═══════════════════════════════════════════════════════════════════════════════

class _IntentAnatomyTab extends StatefulWidget {
  const _IntentAnatomyTab();
  @override
  State<_IntentAnatomyTab> createState() => _IntentAnatomyTabState();
}

class _IntentAnatomyTabState extends State<_IntentAnatomyTab>
    with AutomaticKeepAliveClientMixin {
  bool _forward = true;
  final List<String> _intentLog = [];

  @override
  bool get wantKeepAlive => true;

  void _createIntent() {
    setState(() {
      _intentLog.insert(
        0,
        'ScrollToDocumentBoundaryIntent(forward: $_forward) '
        '→ scroll to ${_forward ? "END" : "START"}',
      );
    });
  }

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
          _buildCodeBlock(
            'const ScrollToDocumentBoundaryIntent({\n'
            '  required bool forward,\n'
            '})',
          ),
          const SizedBox(height: 16),

          // ── Forward parameter ──
          _buildSectionTitle('forward Parameter'),
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _forward = true),
                      child: _directionCard(
                        'forward: true',
                        'Scroll to document END',
                        Icons.vertical_align_bottom,
                        _kForward,
                        _forward,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => setState(() => _forward = false),
                      child: _directionCard(
                        'forward: false',
                        'Scroll to document START',
                        Icons.vertical_align_top,
                        _kBackward,
                        !_forward,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _createIntent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      'Create Intent (forward: $_forward)',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Inheritance chain ──
          _buildSectionTitle('Inheritance Chain'),
          const SizedBox(height: 8),
          _buildInheritanceChain(),
          const SizedBox(height: 16),

          // ── Intent properties ──
          _buildSectionTitle('Properties'),
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
                _propRow(
                  'forward',
                  'bool',
                  'Inherited from DirectionalTextEditingIntent',
                ),
                _propRow(
                  'runtimeType',
                  'Type',
                  'ScrollToDocumentBoundaryIntent',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Log ──
          if (_intentLog.isNotEmpty) ...[
            _buildSectionTitle('Intent Creation Log'),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 160),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kSubtle),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _intentLog.length,
                itemBuilder: (_, i) {
                  final msg = _intentLog[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      msg,
                      style: TextStyle(
                        color: msg.contains('END') ? _kForward : _kBackward,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 12),

          _buildInfoBanner(
            'ScrollToDocumentBoundaryIntent is a const Intent — it carries only '
            'the forward flag. The Action that handles it reads the flag to '
            'determine scroll direction.',
          ),
        ],
      ),
    );
  }

  Widget _directionCard(
    String label,
    String desc,
    IconData icon,
    Color color,
    bool selected,
  ) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? color : _kSubtle,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              desc,
              style: const TextStyle(color: _kDimText, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
          _chainRow('Intent', 'Base class', _kDimText, false),
          _chainConnector(),
          _chainRow(
            'DirectionalTextEditingIntent',
            'Adds forward: bool',
            _kHighlight,
            false,
          ),
          _chainConnector(),
          _chainRow(
            'ScrollToDocumentBoundaryIntent',
            'Scroll to start/end',
            _kAccent,
            true,
          ),
        ],
      ),
    );
  }

  Widget _chainRow(String name, String desc, Color color, bool current) {
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: current ? FontWeight.w700 : FontWeight.w500,
                  fontFamily: 'monospace',
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

  Widget _chainConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 16,
          color: _kDimText.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Shortcuts Mapping
// ═══════════════════════════════════════════════════════════════════════════════

class _ShortcutsMappingTab extends StatefulWidget {
  const _ShortcutsMappingTab();
  @override
  State<_ShortcutsMappingTab> createState() => _ShortcutsMappingTabState();
}

class _ShortcutsMappingTabState extends State<_ShortcutsMappingTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedPlatform = 'windows';
  int _simulatedPosition = 50; // 0-100% simulated
  final List<String> _shortcutLog = [];

  @override
  bool get wantKeepAlive => true;

  void _simulateShortcut(String shortcut, bool forward) {
    setState(() {
      _simulatedPosition = forward ? 100 : 0;
      _shortcutLog.insert(
        0,
        '$shortcut → ScrollToDocumentBoundaryIntent(forward: $forward) '
        '→ position: $_simulatedPosition%',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Platform selector ──
          _buildSectionTitle('Platform Shortcuts'),
          const SizedBox(height: 8),
          Row(
            children: [
              _platformChip('Windows/Linux', 'windows'),
              const SizedBox(width: 8),
              _platformChip('macOS', 'macos'),
            ],
          ),
          const SizedBox(height: 16),

          // ── Shortcut cards ──
          _buildShortcutCards(),
          const SizedBox(height: 16),

          // ── Position visualizer ──
          _buildSectionTitle('Simulated Document Position'),
          const SizedBox(height: 8),
          _buildPositionVisualizer(),
          const SizedBox(height: 16),

          // ── DefaultTextEditingShortcuts ──
          _buildSectionTitle('DefaultTextEditingShortcuts'),
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
                  'Registered by DefaultTextEditingShortcuts widget:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _buildCodeBlock(
                  'Shortcuts(\n'
                  '  shortcuts: {\n'
                  '    SingleActivator(LogicalKeyboardKey.home,\n'
                  '      control: true):\n'
                  '        ScrollToDocumentBoundaryIntent(\n'
                  '          forward: false),\n'
                  '    SingleActivator(LogicalKeyboardKey.end,\n'
                  '      control: true):\n'
                  '        ScrollToDocumentBoundaryIntent(\n'
                  '          forward: true),\n'
                  '  },\n'
                  '  child: ...\n'
                  ')',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Compatible widgets ──
          _buildSectionTitle('Compatible Widgets'),
          const SizedBox(height: 8),
          _buildCompatWidgets(),
          const SizedBox(height: 16),

          // ── Log ──
          if (_shortcutLog.isNotEmpty) ...[
            _buildSectionTitle('Shortcut Simulation Log'),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 140),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kSubtle),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _shortcutLog.length,
                itemBuilder: (_, i) {
                  final msg = _shortcutLog[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      msg,
                      style: TextStyle(
                        color: msg.contains('true') ? _kForward : _kBackward,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 12),

          _buildInfoBanner(
            'Shortcuts are registered by DefaultTextEditingShortcuts which '
            'is included in WidgetsApp/MaterialApp. It provides platform-'
            'specific key binding for all text editing intents.',
          ),
        ],
      ),
    );
  }

  Widget _platformChip(String label, String value) {
    final selected = _selectedPlatform == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlatform = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? _kPrimary.withValues(alpha: 0.3) : Colors.transparent,
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

  Widget _buildShortcutCards() {
    final isWindows = _selectedPlatform == 'windows';
    return Column(
      children: [
        _shortcutCard(
          isWindows ? 'Ctrl + Home' : 'Cmd + ↑',
          'forward: false',
          'Scroll to document START',
          _kBackward,
          Icons.vertical_align_top,
          () => _simulateShortcut(
            isWindows ? 'Ctrl+Home' : 'Cmd+Up',
            false,
          ),
        ),
        const SizedBox(height: 8),
        _shortcutCard(
          isWindows ? 'Ctrl + End' : 'Cmd + ↓',
          'forward: true',
          'Scroll to document END',
          _kForward,
          Icons.vertical_align_bottom,
          () => _simulateShortcut(
            isWindows ? 'Ctrl+End' : 'Cmd+Down',
            true,
          ),
        ),
      ],
    );
  }

  Widget _shortcutCard(
    String keys,
    String param,
    String desc,
    Color color,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _keyBadge(keys),
                      const SizedBox(width: 8),
                      Text(
                        param,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: const TextStyle(color: _kDimText, fontSize: 11),
                  ),
                ],
              ),
            ),
            const Icon(Icons.play_arrow, color: _kDimText, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _keyBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kDimText.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPositionVisualizer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'START',
                style: TextStyle(
                  color: _kBackward,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Text(
                'END',
                style: TextStyle(
                  color: _kForward,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: _kSubtle,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                widthFactor: _simulatedPosition / 100.0,
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kBackward, _kForward],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$_simulatedPosition%',
            style: const TextStyle(
              color: _kDimText,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompatWidgets() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _compatRow('TextField', 'Single-line text input', true),
          _compatRow('TextFormField', 'Form-validated text input', true),
          _compatRow('EditableText', 'Low-level editable text', true),
          _compatRow('CupertinoTextField', 'Cupertino text input', true),
          _compatRow('ListView', 'Not applicable (no text)', false),
        ],
      ),
    );
  }

  Widget _compatRow(String widget, String desc, bool supported) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            supported ? Icons.check_circle : Icons.remove_circle_outline,
            size: 14,
            color: supported ? _kAccent : _kDimText.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 130,
            child: Text(
              widget,
              style: TextStyle(
                color: supported ? _kAccent : _kDimText,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(color: _kDimText, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Actions Pattern
// ═══════════════════════════════════════════════════════════════════════════════

class _ActionsPatternTab extends StatefulWidget {
  const _ActionsPatternTab();
  @override
  State<_ActionsPatternTab> createState() => _ActionsPatternTabState();
}

class _ActionsPatternTabState extends State<_ActionsPatternTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedComponent = 'intent';
  final List<String> _flowLog = [];

  @override
  bool get wantKeepAlive => true;

  void _simulateFlow(bool forward) {
    setState(() {
      _flowLog.clear();
      _flowLog.add(
        '1. User presses ${forward ? "Ctrl+End" : "Ctrl+Home"}',
      );
      _flowLog.add(
        '2. Shortcuts widget matches → ScrollToDocumentBoundaryIntent'
        '(forward: $forward)',
      );
      _flowLog.add(
        '3. Actions widget finds → _ScrollToDocumentBoundaryAction',
      );
      _flowLog.add(
        '4. Action.invoke(intent) → reads intent.forward = $forward',
      );
      _flowLog.add(
        '5. scrollPosition.moveTo(${forward ? "maxScrollExtent" : "0.0"})',
      );
      _flowLog.add(
        '6. Document scrolls to ${forward ? "end" : "start"}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Architecture diagram ──
          _buildSectionTitle('Flutter Actions Architecture'),
          const SizedBox(height: 8),
          _buildArchitectureDiagram(),
          const SizedBox(height: 16),

          // ── Component explorer ──
          _buildSectionTitle('Component Details'),
          const SizedBox(height: 8),
          Row(
            children: [
              _componentChip('Intent', 'intent'),
              const SizedBox(width: 6),
              _componentChip('Action', 'action'),
              const SizedBox(width: 6),
              _componentChip('Shortcuts', 'shortcuts'),
            ],
          ),
          const SizedBox(height: 12),
          _buildComponentDetail(),
          const SizedBox(height: 16),

          // ── Flow simulation ──
          _buildSectionTitle('End-to-End Flow'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _simulateFlow(false),
                  icon: const Icon(Icons.vertical_align_top, size: 16),
                  label: const Text('To Start', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kBackward.withValues(alpha: 0.2),
                    foregroundColor: _kBackward,
                    side: BorderSide(color: _kBackward.withValues(alpha: 0.5)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _simulateFlow(true),
                  icon: const Icon(Icons.vertical_align_bottom, size: 16),
                  label: const Text('To End', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kForward.withValues(alpha: 0.2),
                    foregroundColor: _kForward,
                    side: BorderSide(color: _kForward.withValues(alpha: 0.5)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (_flowLog.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _flowLog.asMap().entries.map((entry) {
                  final i = entry.key;
                  final msg = entry.value;
                  final color = i == 0
                      ? _kDimText
                      : i <= 2
                          ? _kAccent
                          : i <= 4
                              ? _kHighlight
                              : _kForward;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      msg,
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          const SizedBox(height: 16),

          // ── Related intents ──
          _buildSectionTitle('Related Text Editing Intents'),
          const SizedBox(height: 8),
          _buildRelatedIntents(),
          const SizedBox(height: 12),

          // ── Accessibility ──
          _buildSectionTitle('Accessibility'),
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
                _a11yRow(
                  Icons.keyboard,
                  'Keyboard Navigation',
                  'Essential for keyboard-only users',
                ),
                _a11yRow(
                  Icons.accessibility_new,
                  'Screen Readers',
                  'Works with assistive technologies',
                ),
                _a11yRow(
                  Icons.devices,
                  'Platform Consistent',
                  'Follows platform key conventions',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'The Intent → Action pattern decouples WHAT to do from HOW to do it. '
            'Custom Actions can override the default behavior by wrapping the '
            'child tree with an Actions widget that maps the same Intent.',
          ),
        ],
      ),
    );
  }

  Widget _buildArchitectureDiagram() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _archRow('Key Event', 'Raw platform input', _kDimText),
          _archArrow(),
          _archRow('Shortcuts Widget', 'Maps keys → Intent', _kHighlight),
          _archArrow(),
          _archRow('Intent', 'Describes what to do', _kAccent),
          _archArrow(),
          _archRow('Actions Widget', 'Maps Intent → Action', _kHighlight),
          _archArrow(),
          _archRow('Action.invoke()', 'Executes behavior', _kForward),
        ],
      ),
    );
  }

  Widget _archRow(String label, String desc, Color color) {
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
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 140,
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
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

  Widget _archArrow() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 10,
          color: _kDimText.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _componentChip(String label, String value) {
    final selected = _selectedComponent == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedComponent = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? _kPrimary.withValues(alpha: 0.3) : Colors.transparent,
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

  Widget _buildComponentDetail() {
    final String title;
    final String code;
    final String desc;
    switch (_selectedComponent) {
      case 'intent':
        title = 'ScrollToDocumentBoundaryIntent';
        code =
            'ScrollToDocumentBoundaryIntent(\n'
            '  forward: true, // or false\n'
            ')';
        desc = 'Immutable data object describing the desired action. '
            'Carries only the forward flag.';
      case 'action':
        title = '_ScrollToDocumentBoundaryAction';
        code =
            'class _ScrollToDocumentBoundaryAction\n'
            '    extends Action<ScrollToDocumentBoundary'
            'Intent> {\n'
            '  @override\n'
            '  Object? invoke(covariant intent) {\n'
            '    // Read intent.forward\n'
            '    // Scroll to start or end\n'
            '  }\n'
            '}';
        desc = 'Private action class that handles the intent. '
            'Registered by EditableText via Actions widget.';
      default:
        title = 'Shortcuts Widget';
        code =
            'Shortcuts(\n'
            '  shortcuts: <ShortcutActivator, Intent>{\n'
            '    SingleActivator(key, control: true):\n'
            '      ScrollToDocumentBoundaryIntent(…),\n'
            '  },\n'
            '  child: ...\n'
            ')';
        desc = 'Maps key combinations to Intent objects. '
            'DefaultTextEditingShortcuts registers platform-specific bindings.';
    }

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
          Text(
            title,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8),
          _buildCodeBlock(code),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(color: _kDimText, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedIntents() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _relatedRow(
            'SelectAllTextIntent',
            'Select all text in field',
          ),
          _relatedRow(
            'ExtendSelectionByPageIntent',
            'Extend selection by one page',
          ),
          _relatedRow(
            'ExtendSelectionToDocumentBoundaryIntent',
            'Extend selection to start/end',
          ),
          _relatedRow(
            'MoveSelectionToStartTextBoundaryIntent',
            'Move cursor to text boundary',
          ),
          _relatedRow(
            'ScrollToDocumentBoundaryIntent',
            'THIS — Scroll to start/end',
          ),
        ],
      ),
    );
  }

  Widget _relatedRow(String name, String desc) {
    final isCurrent = name == 'ScrollToDocumentBoundaryIntent';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCurrent ? Icons.arrow_right : Icons.remove,
            size: 14,
            color: isCurrent ? _kAccent : _kDimText.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: isCurrent ? _kAccent : Colors.white70,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight:
                        isCurrent ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: _kDimText, fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _a11yRow(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: _kAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
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
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _propRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            type,
            style: const TextStyle(
              color: _kForward,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(color: _kDimText, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

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
