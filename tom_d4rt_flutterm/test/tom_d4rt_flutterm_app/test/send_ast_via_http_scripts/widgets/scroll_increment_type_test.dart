// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollIncrementType from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFFE65100); // DeepOrange 900
const _kAccent = Color(0xFFB2FF59); // LightGreen A200
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kLine = Color(0xFF80DEEA); // Cyan 200
const _kPage = Color(0xFFCE93D8); // Purple 200

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
    home: const _ScrollIncrementTypeDemo(),
  );
}

class _ScrollIncrementTypeDemo extends StatefulWidget {
  const _ScrollIncrementTypeDemo();

  @override
  State<_ScrollIncrementTypeDemo> createState() =>
      _ScrollIncrementTypeDemoState();
}

class _ScrollIncrementTypeDemoState extends State<_ScrollIncrementTypeDemo>
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
        title: const Text('ScrollIncrementType',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.list_alt), text: 'Enum Values'),
            Tab(icon: Icon(Icons.keyboard), text: 'Key Bindings'),
            Tab(icon: Icon(Icons.swap_vert), text: 'Live Scroll'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _EnumValuesTab(),
          _KeyBindingsTab(),
          _LiveScrollTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Enum Values
// ═══════════════════════════════════════════════════════════════════════════
class _EnumValuesTab extends StatelessWidget {
  const _EnumValuesTab();

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
              colors: [Color(0xFF4A2800), Color(0xFF7F3900)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.list_alt, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollIncrementType',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _badge('enum', _kPrimary),
                  const SizedBox(width: 6),
                  _badge('2 values', _kAccent),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Determines the granularity of keyboard-triggered scroll '
                'increments: fine-grained line scrolling or large page '
                'scrolling.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // enum.line
        _enumCard(
          value: 'line',
          index: 0,
          color: _kLine,
          icon: Icons.short_text,
          description: 'Scroll by a small fixed amount — one "line" of '
              'content. The default increment is 50.0 logical pixels.',
          trigger: 'Arrow keys (Up, Down, Left, Right)',
          defaultAmount: '50.0 px',
          formula: 'constant = 50.0',
          emoji: '↕',
        ),
        const SizedBox(height: 12),

        // enum.page
        _enumCard(
          value: 'page',
          index: 1,
          color: _kPage,
          icon: Icons.description,
          description: 'Scroll by a viewport-proportional amount — one '
              '"page" of content. Default is 80% of the viewport dimension.',
          trigger: 'PageUp / PageDown keys',
          defaultAmount: '80% viewport',
          formula: '0.8 × viewportDimension',
          emoji: '⏫',
        ),
        const SizedBox(height: 24),

        // Comparison table
        _hdr('Side-by-Side'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(40)),
          ),
          child: Column(
            children: [
              _headerRow(),
              const Divider(height: 1, color: Color(0xFF2A2A2A)),
              _compRow('Name', 'line', 'page'),
              _compRow('Index', '0', '1'),
              _compRow('Default', '50.0 px', '80% viewport'),
              _compRow('Trigger', 'Arrow keys', 'PageUp/Down'),
              _compRow('Use Case', 'Text editing', 'Document browse'),
              _compRow('Granularity', 'Fine', 'Coarse'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Enum signature
        _hdr('Source Signature'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(30)),
          ),
          child: const Text(
            'enum ScrollIncrementType {\n'
            '  /// Scroll by a set number of pixels.\n'
            '  line,\n'
            '\n'
            '  /// Scroll by a fraction of the\n'
            '  /// viewport dimension.\n'
            '  page,\n'
            '}',
            style: TextStyle(
                color: _kBright,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 24),

        // Usage sites
        _hdr('Where It Appears'),
        const SizedBox(height: 10),
        _usageSite('ScrollIntent', 'type parameter',
            'Carried by the Intent to ScrollAction', _kAccent),
        const SizedBox(height: 6),
        _usageSite('ScrollIncrementDetails', 'type field',
            'Bundled with metrics for the calculator', _kPrimary),
        const SizedBox(height: 6),
        _usageSite('ScrollAction', 'calculation switch',
            'Dispatches default 50px vs 80% based on type', _kLine),
        const SizedBox(height: 6),
        _usageSite('Scrollable', 'incrementCalculator',
            'Custom calculator receives type via details', _kPage),
      ],
    );
  }

  static Widget _enumCard({
    required String value,
    required int index,
    required Color color,
    required IconData icon,
    required String description,
    required String trigger,
    required String defaultAmount,
    required String formula,
    required String emoji,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withAlpha(15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('$emoji  .$value',
                            style: TextStyle(
                                color: color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace')),
                        const Spacer(),
                        _badge('index: $index', color),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description,
              style:
                  const TextStyle(color: _kDim, fontSize: 11, height: 1.4)),
          const SizedBox(height: 12),
          Row(
            children: [
              _miniInfo('Trigger', trigger, color),
              const SizedBox(width: 6),
              _miniInfo('Default', defaultAmount, color),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(formula,
                style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  static Widget _miniInfo(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withAlpha(8),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withAlpha(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    color: color.withAlpha(120),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1)),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    color: _kBright, fontSize: 10, height: 1.2)),
          ],
        ),
      ),
    );
  }

  static Widget _headerRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _kPrimary.withAlpha(10),
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(13)),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: Text('Property',
                style: TextStyle(
                    color: _kDim,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text('line',
                style: TextStyle(
                    color: _kLine,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text('page',
                style: TextStyle(
                    color: _kPage,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  static Widget _compRow(String prop, String line, String page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(prop,
                style: const TextStyle(
                    color: _kDim,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(line,
                style: const TextStyle(
                    color: _kLine,
                    fontFamily: 'monospace',
                    fontSize: 10)),
          ),
          Expanded(
            flex: 3,
            child: Text(page,
                style: const TextStyle(
                    color: _kPage,
                    fontFamily: 'monospace',
                    fontSize: 10)),
          ),
        ],
      ),
    );
  }

  static Widget _usageSite(
      String name, String role, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 6),
                    Text(role,
                        style: const TextStyle(
                            color: _kDim,
                            fontSize: 9,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
                Text(desc,
                    style: const TextStyle(
                        color: _kDim, fontSize: 10, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Key Bindings (keyboard interaction diagram)
// ═══════════════════════════════════════════════════════════════════════════
class _KeyBindingsTab extends StatelessWidget {
  const _KeyBindingsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _hdr('Keyboard → ScrollIncrementType'),
        const SizedBox(height: 10),
        const Text(
          'When a scrollable widget has focus, certain keys generate a '
          'ScrollIntent with a specific ScrollIncrementType. The intent '
          'is handled by ScrollAction.',
          style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
        ),
        const SizedBox(height: 16),

        // Line keys
        _keySectionHeader('Line Scroll Keys', _kLine, Icons.short_text),
        const SizedBox(height: 8),
        _keyRow('↑', 'Arrow Up', AxisDirection.up, _kLine),
        _keyRow('↓', 'Arrow Down', AxisDirection.down, _kLine),
        _keyRow('←', 'Arrow Left', AxisDirection.left, _kLine),
        _keyRow('→', 'Arrow Right', AxisDirection.right, _kLine),
        const SizedBox(height: 16),

        // Page keys
        _keySectionHeader('Page Scroll Keys', _kPage, Icons.description),
        const SizedBox(height: 8),
        _keyRow('PgUp', 'Page Up', AxisDirection.up, _kPage),
        _keyRow('PgDn', 'Page Down', AxisDirection.down, _kPage),
        const SizedBox(height: 20),

        // Flow
        _hdr('Intent → Action Pipeline'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(40)),
          ),
          child: Column(
            children: [
              _flowBox('Keyboard Event', _kBright,
                  'Physical key press detected'),
              _flowConnector(),
              _flowBox('ScrollIntent Created', _kAccent,
                  'direction + incrementType'),
              _flowConnector(),
              _flowBox('Actions.invoke()', _kDim,
                  'Finds ScrollAction via Actions widget'),
              _flowConnector(),
              _flowBox('ScrollAction.invoke()', _kPrimary,
                  'Reads type from intent'),
              _flowConnector(),
              _flowBox('Build ScrollIncrementDetails', _kLine,
                  'type + current metrics'),
              _flowConnector(),
              _flowBox('Calculate Increment', _kPage,
                  'line → 50px, page → 80% viewport'),
              _flowConnector(),
              _flowBox('Apply to ScrollPosition', _kAccent,
                  'scrollPosition.moveTo(pixels + delta)'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Default amounts visual
        _hdr('Default Increment Amounts'),
        const SizedBox(height: 10),
        _amountVisual(),
        const SizedBox(height: 20),

        // Edge cases
        _hdr('Edge Cases'),
        const SizedBox(height: 10),
        _edgeCase(
          'At scroll boundary',
          'Increment is clamped to min/max scroll extent',
          Icons.block,
        ),
        const SizedBox(height: 6),
        _edgeCase(
          'Custom calculator',
          'Scrollable.incrementCalculator overrides defaults',
          Icons.functions,
        ),
        const SizedBox(height: 6),
        _edgeCase(
          'Horizontal scrollable',
          'Left/Right arrows produce line increments',
          Icons.swap_horiz,
        ),
        const SizedBox(height: 6),
        _edgeCase(
          'No focus',
          'No ScrollIntent generated — keys go elsewhere',
          Icons.visibility_off,
        ),
      ],
    );
  }

  static Widget _keySectionHeader(String title, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withAlpha(8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(25)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(title,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  static Widget _keyRow(
      String key, String name, AxisDirection dir, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(20)),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 28,
              decoration: BoxDecoration(
                color: color.withAlpha(15),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color.withAlpha(40)),
              ),
              child: Center(
                child: Text(key,
                    style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(name,
                  style:
                      const TextStyle(color: _kBright, fontSize: 11)),
            ),
            _badge(dir.name, color),
          ],
        ),
      ),
    );
  }

  static Widget _flowBox(String title, Color color, String sub) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withAlpha(8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
          Text(sub,
              style: const TextStyle(color: _kDim, fontSize: 9)),
        ],
      ),
    );
  }

  static Widget _flowConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 2, bottom: 2),
      child: Icon(Icons.keyboard_arrow_down,
          size: 14, color: _kDim.withAlpha(30)),
    );
  }

  static Widget _amountVisual() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line bar
          const Text('line: 50px',
              style: TextStyle(
                  color: _kLine,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace')),
          const SizedBox(height: 4),
          Container(
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _kLine.withAlpha(8),
              border: Border.all(color: _kLine.withAlpha(20)),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 50.0 / 480, // 50px in ~480px bar
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: _kLine.withAlpha(60),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Page bar
          const Text('page: 80% viewport (e.g. 480px of 600px)',
              style: TextStyle(
                  color: _kPage,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace')),
          const SizedBox(height: 4),
          Container(
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _kPage.withAlpha(8),
              border: Border.all(color: _kPage.withAlpha(20)),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: _kPage.withAlpha(60),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Line is a constant 50px regardless of viewport.\n'
            'Page scales with viewport — always 80% of visible area.',
            style: TextStyle(color: _kDim, fontSize: 9, height: 1.4),
          ),
        ],
      ),
    );
  }

  static Widget _edgeCase(String title, String desc, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kPrimary.withAlpha(20)),
      ),
      child: Row(
        children: [
          Icon(icon, color: _kPrimary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: _kBright,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
                Text(desc,
                    style: const TextStyle(
                        color: _kDim, fontSize: 10, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Live Scroll (interactive line vs page demonstration)
// ═══════════════════════════════════════════════════════════════════════════
class _LiveScrollTab extends StatefulWidget {
  const _LiveScrollTab();

  @override
  State<_LiveScrollTab> createState() => _LiveScrollTabState();
}

class _LiveScrollTabState extends State<_LiveScrollTab> {
  final ScrollController _ctrl = ScrollController();
  ScrollIncrementType _selectedType = ScrollIncrementType.line;
  int _totalIncrements = 0;
  double _totalDistance = 0;
  double _currentOffset = 0;
  final List<_IncrementRecord> _records = [];

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      if (_ctrl.hasClients) {
        setState(() => _currentOffset = _ctrl.position.pixels);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _doIncrement({bool forward = true}) {
    if (!_ctrl.hasClients) return;
    final pos = _ctrl.position;
    final double amount;
    if (_selectedType == ScrollIncrementType.line) {
      amount = 50.0;
    } else {
      amount = 0.8 * pos.viewportDimension;
    }
    final delta = forward ? amount : -amount;
    final target =
        (_ctrl.offset + delta).clamp(0.0, pos.maxScrollExtent);
    _ctrl.animateTo(target,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut);
    setState(() {
      _totalIncrements++;
      _totalDistance += amount;
      _records.insert(
          0,
          _IncrementRecord(
            type: _selectedType,
            amount: amount,
            direction: forward ? 'Forward' : 'Backward',
            targetOffset: target,
          ));
      if (_records.length > 20) _records.removeLast();
    });
  }

  void _reset() {
    _ctrl.animateTo(0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    setState(() {
      _totalIncrements = 0;
      _totalDistance = 0;
      _records.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Type selector
        Container(
          padding: const EdgeInsets.all(10),
          color: _kCard,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(
                      () => _selectedType = ScrollIncrementType.line),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedType == ScrollIncrementType.line
                          ? _kLine.withAlpha(15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color:
                              _selectedType == ScrollIncrementType.line
                                  ? _kLine.withAlpha(40)
                                  : _kDim.withAlpha(10)),
                    ),
                    child: Center(
                      child: Text('LINE (50px)',
                          style: TextStyle(
                              color: _selectedType ==
                                      ScrollIncrementType.line
                                  ? _kLine
                                  : _kDim,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(
                      () => _selectedType = ScrollIncrementType.page),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedType == ScrollIncrementType.page
                          ? _kPage.withAlpha(15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color:
                              _selectedType == ScrollIncrementType.page
                                  ? _kPage.withAlpha(40)
                                  : _kDim.withAlpha(10)),
                    ),
                    child: Center(
                      child: Text('PAGE (80%)',
                          style: TextStyle(
                              color: _selectedType ==
                                      ScrollIncrementType.page
                                  ? _kPage
                                  : _kDim,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Controls
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              _controlBtn('▲', () => _doIncrement(forward: false)),
              const SizedBox(width: 6),
              _controlBtn('▼', () => _doIncrement(forward: true)),
              const Spacer(),
              Text('${_currentOffset.toStringAsFixed(0)} px',
                  style: const TextStyle(
                      color: _kBright,
                      fontFamily: 'monospace',
                      fontSize: 12)),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _reset,
                child: const Icon(Icons.refresh,
                    color: _kDim, size: 18),
              ),
            ],
          ),
        ),

        // Stats
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              _statChip('Increments', '$_totalIncrements',
                  _selectedType == ScrollIncrementType.line
                      ? _kLine
                      : _kPage),
              const SizedBox(width: 6),
              _statChip('Distance', '${_totalDistance.toStringAsFixed(0)}px',
                  _kAccent),
            ],
          ),
        ),

        // Scrollable
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: (_selectedType == ScrollIncrementType.line
                          ? _kLine
                          : _kPage)
                      .withAlpha(30)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListView.builder(
                controller: _ctrl,
                itemCount: 80,
                itemBuilder: (ctx, i) {
                  final f = i / 80;
                  final isLine =
                      _selectedType == ScrollIncrementType.line;
                  return Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: isLine
                          ? Color.fromARGB(
                              255, 0, (f * 50 + 30).toInt(), (f * 60 + 40).toInt())
                          : Color.fromARGB(
                              255, (f * 40 + 30).toInt(), 0, (f * 50 + 40).toInt()),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text('Item $i',
                        style: TextStyle(
                            color: isLine ? _kLine : _kPage,
                            fontSize: 10)),
                  );
                },
              ),
            ),
          ),
        ),

        // Records log
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPrimary.withAlpha(30)),
            ),
            child: _records.isEmpty
                ? const Center(
                    child: Text('Press ▲ or ▼ to scroll',
                        style: TextStyle(color: _kDim, fontSize: 11)))
                : ListView.builder(
                    itemCount: _records.length,
                    itemBuilder: (ctx, i) {
                      final r = _records[i];
                      final c = r.type == ScrollIncrementType.line
                          ? _kLine
                          : _kPage;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '${r.type.name} ${r.direction} '
                          '+${r.amount.toStringAsFixed(0)}px → '
                          '${r.targetOffset.toStringAsFixed(0)}px',
                          style: TextStyle(
                              color: c,
                              fontFamily: 'monospace',
                              fontSize: 10,
                              height: 1.3),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget _controlBtn(String label, VoidCallback onTap) {
    final color =
        _selectedType == ScrollIncrementType.line ? _kLine : _kPage;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 34,
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(40)),
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _statChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(8),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withAlpha(20)),
        ),
        child: Row(
          children: [
            Text('$label: ',
                style:
                    const TextStyle(color: _kDim, fontSize: 9)),
            Text(value,
                style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _IncrementRecord {
  final ScrollIncrementType type;
  final double amount;
  final String direction;
  final double targetOffset;

  const _IncrementRecord({
    required this.type,
    required this.amount,
    required this.direction,
    required this.targetOffset,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared Helpers
// ═══════════════════════════════════════════════════════════════════════════
Widget _hdr(String title) {
  return Row(
    children: [
      Container(width: 4, height: 20, color: _kAccent),
      const SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: const TextStyle(
                color: _kBright,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

Widget _badge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Text(text,
        style: TextStyle(
            color: color.withAlpha(200),
            fontSize: 10,
            fontFamily: 'monospace')),
  );
}
