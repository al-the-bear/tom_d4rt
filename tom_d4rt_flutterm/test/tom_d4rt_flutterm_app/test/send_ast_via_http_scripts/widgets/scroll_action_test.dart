// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollAction from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF689F38); // Lime 700 (darker)
const _kAccent = Color(0xFFEA80FC); // Purple A100
const _kSurface = Color(0xFF181818);
const _kCard = Color(0xFF252525);
const _kDimText = Color(0xFF9E9E9E);
const _kBrightText = Color(0xFFEEEEEE);
const _kLine = Color(0xFF81D4FA); // LightBlue 200
const _kPage = Color(0xFFFFAB91); // DeepOrange 200

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
    home: const _ScrollActionDemo(),
  );
}

class _ScrollActionDemo extends StatefulWidget {
  const _ScrollActionDemo();

  @override
  State<_ScrollActionDemo> createState() => _ScrollActionDemoState();
}

class _ScrollActionDemoState extends State<_ScrollActionDemo>
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
        title: const Text('ScrollAction',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(icon: Icon(Icons.menu_book), text: 'Concepts'),
            Tab(icon: Icon(Icons.science), text: 'Scroll Lab'),
            Tab(icon: Icon(Icons.keyboard), text: 'Bindings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConceptsTab(),
          _ScrollLabTab(),
          _BindingsTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Concepts
// ═══════════════════════════════════════════════════════════════════════════
class _ConceptsTab extends StatelessWidget {
  const _ConceptsTab();

  @override
  Widget build(BuildContext context) {
    // Create a ScrollAction for live inspection
    final action = ScrollAction();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hero
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF33691E), Color(0xFF1B5E20)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.swap_vert, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text(
                'ScrollAction',
                style: TextStyle(
                    color: _kBrightText,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kAccent.withAlpha(80)),
                ),
                child: Text(
                  'extends ContextAction<ScrollIntent>',
                  style: TextStyle(
                      color: _kAccent.withAlpha(200),
                      fontSize: 11,
                      fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Responds to ScrollIntent by scrolling the nearest '
                'Scrollable widget in the requested direction.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDimText, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // What it does
        _hdr('What Does ScrollAction Do?'),
        const SizedBox(height: 10),
        _card(
          icon: Icons.keyboard_arrow_down,
          iconColor: _kPrimary,
          title: 'Keyboard Scrolling',
          body: 'ScrollAction is the default action that handles '
              'keyboard-initiated scrolling. When the user presses arrow '
              'keys, Page Up/Down, or Home/End while a Scrollable has focus, '
              'the Actions widget dispatches a ScrollIntent.',
        ),
        const SizedBox(height: 10),
        _card(
          icon: Icons.search,
          iconColor: _kAccent,
          title: 'Finds the Nearest Scrollable',
          body: 'When invoked, ScrollAction looks for the nearest ancestor '
              'Scrollable via Scrollable.maybeOf(context). If none is found, '
              'it checks the PrimaryScrollController.',
        ),
        const SizedBox(height: 10),
        _card(
          icon: Icons.calculate,
          iconColor: _kLine,
          title: 'Calculates Scroll Amount',
          body: 'The static getDirectionalIncrement() method computes the '
              'exact pixel amount to scroll based on the ScrollIntent\'s '
              'direction and type (line vs page).',
        ),
        const SizedBox(height: 20),

        // Live type info
        _hdr('Live Type Inspection'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            children: [
              _typeRow('runtimeType', '${action.runtimeType}'),
              _typeRow('intentType', 'ScrollIntent'),
              _typeRow('isActionEnabled', 'context-dependent'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Scroll increments
        _hdr('Default Scroll Increments'),
        const SizedBox(height: 10),
        Row(
          children: [
            _incrementCard(
              'Line',
              '50.0',
              'logical pixels',
              'Arrow keys, mouse wheel clicks',
              _kLine,
              Icons.short_text,
            ),
            const SizedBox(width: 10),
            _incrementCard(
              'Page',
              '80%',
              'viewport height',
              'Page Up/Down, large jumps',
              _kPage,
              Icons.article,
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Action flow
        _hdr('Invocation Flow'),
        const SizedBox(height: 10),
        _buildActionFlow(),
      ],
    );
  }

  Widget _typeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    color: _kDimText,
                    fontSize: 12,
                    fontFamily: 'monospace')),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccent.withAlpha(10),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _kAccent.withAlpha(30)),
              ),
              child: Text(value,
                  style: const TextStyle(
                      color: _kAccent,
                      fontSize: 12,
                      fontFamily: 'monospace')),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _incrementCard(String label, String amount, String unit,
      String desc, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(amount,
                style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            Text(unit,
                style: const TextStyle(color: _kDimText, fontSize: 11)),
            const SizedBox(height: 6),
            Text(desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: _kDimText, fontSize: 10, height: 1.3)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionFlow() {
    const steps = [
      ('User presses key', Icons.keyboard, _kDimText),
      ('Shortcuts matches ScrollIntent', Icons.shortcut, _kAccent),
      ('Actions finds ScrollAction', Icons.search, _kPrimary),
      ('isEnabled checks for Scrollable', Icons.verified, _kLine),
      ('getDirectionalIncrement()', Icons.calculate, _kPage),
      ('ScrollPosition.moveTo()', Icons.swap_vert, _kPrimary),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: steps[i].$3.withAlpha(25),
                    shape: BoxShape.circle,
                    border: Border.all(color: steps[i].$3.withAlpha(80)),
                  ),
                  child: Icon(steps[i].$2,
                      size: 16, color: steps[i].$3),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(steps[i].$1,
                      style: TextStyle(
                          color: steps[i].$3,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            if (i < steps.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 16),
                height: 14,
                width: 2,
                color: steps[i].$3.withAlpha(30),
              ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Scroll Lab (Interactive)
// ═══════════════════════════════════════════════════════════════════════════
class _ScrollLabTab extends StatefulWidget {
  const _ScrollLabTab();

  @override
  State<_ScrollLabTab> createState() => _ScrollLabTabState();
}

class _ScrollLabTabState extends State<_ScrollLabTab> {
  final ScrollController _scrollCtrl = ScrollController();
  AxisDirection _direction = AxisDirection.down;
  ScrollIncrementType _type = ScrollIncrementType.line;
  final List<String> _logEntries = [];

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _executeScroll() {
    if (!_scrollCtrl.hasClients) return;

    final pos = _scrollCtrl.position;
    double increment;
    if (_type == ScrollIncrementType.line) {
      increment = 50.0;
    } else {
      increment = pos.viewportDimension * 0.8;
    }

    final isForward =
        _direction == AxisDirection.down || _direction == AxisDirection.right;
    final target = isForward
        ? (pos.pixels + increment).clamp(pos.minScrollExtent, pos.maxScrollExtent)
        : (pos.pixels - increment).clamp(pos.minScrollExtent, pos.maxScrollExtent);

    _scrollCtrl.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );

    setState(() {
      _logEntries.insert(0,
          '${_direction.name} ${_type.name} → ${increment.toStringAsFixed(0)}px → ${target.toStringAsFixed(0)}');
      if (_logEntries.length > 8) _logEntries.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Controls
        Container(
          padding: const EdgeInsets.all(14),
          color: _kCard,
          child: Column(
            children: [
              // Direction selector
              Row(
                children: [
                  const Text('Direction:',
                      style: TextStyle(color: _kDimText, fontSize: 12)),
                  const SizedBox(width: 10),
                  _dirButton(AxisDirection.up, Icons.arrow_upward),
                  const SizedBox(width: 6),
                  _dirButton(AxisDirection.down, Icons.arrow_downward),
                  const SizedBox(width: 6),
                  _dirButton(AxisDirection.left, Icons.arrow_back),
                  const SizedBox(width: 6),
                  _dirButton(AxisDirection.right, Icons.arrow_forward),
                ],
              ),
              const SizedBox(height: 10),
              // Type selector
              Row(
                children: [
                  const Text('Type:',
                      style: TextStyle(color: _kDimText, fontSize: 12)),
                  const SizedBox(width: 10),
                  _typeButton(ScrollIncrementType.line, 'Line', _kLine),
                  const SizedBox(width: 8),
                  _typeButton(ScrollIncrementType.page, 'Page', _kPage),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _executeScroll,
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Scroll'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kPrimary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Scrollable content
        Expanded(
          child: Row(
            children: [
              // Scroll area
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kPrimary.withAlpha(50)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ListView.builder(
                    controller: _scrollCtrl,
                    itemCount: 50,
                    itemBuilder: (ctx, i) {
                      final hue = (i * 7.2) % 360;
                      return Container(
                        height: 52,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: HSLColor.fromAHSL(1, hue, 0.3, 0.2)
                              .toColor(),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: HSLColor.fromAHSL(1, hue, 0.4, 0.35)
                                .toColor(),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text('Item $i',
                            style: TextStyle(
                                color: HSLColor.fromAHSL(
                                        1, hue, 0.6, 0.7)
                                    .toColor(),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      );
                    },
                  ),
                ),
              ),

              // Log panel
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kAccent.withAlpha(40)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Scroll Log',
                          style: TextStyle(
                              color: _kAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      const Divider(color: _kDimText, height: 16),
                      Expanded(
                        child: _logEntries.isEmpty
                            ? const Center(
                                child: Text('Press Scroll →',
                                    style: TextStyle(
                                        color: _kDimText,
                                        fontSize: 11)))
                            : ListView(
                                children: _logEntries.map((e) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 4),
                                    child: Text(e,
                                        style: const TextStyle(
                                            color: _kBrightText,
                                            fontFamily: 'monospace',
                                            fontSize: 10,
                                            height: 1.4)),
                                  );
                                }).toList(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dirButton(AxisDirection dir, IconData icon) {
    final active = _direction == dir;
    return GestureDetector(
      onTap: () => setState(() => _direction = dir),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: active ? _kAccent.withAlpha(25) : _kSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: active ? _kAccent : _kDimText.withAlpha(40)),
        ),
        child: Icon(icon,
            size: 18,
            color: active ? _kAccent : _kDimText),
      ),
    );
  }

  Widget _typeButton(ScrollIncrementType t, String label, Color color) {
    final active = _type == t;
    return GestureDetector(
      onTap: () => setState(() => _type = t),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? color.withAlpha(20) : _kSurface,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: active ? color : _kDimText.withAlpha(40)),
        ),
        child: Text(label,
            style: TextStyle(
                color: active ? color : _kDimText,
                fontSize: 12,
                fontWeight: active ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Keyboard Bindings
// ═══════════════════════════════════════════════════════════════════════════
class _BindingsTab extends StatelessWidget {
  const _BindingsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _hdr('Shortcut → Intent → Action'),
        const SizedBox(height: 10),
        _card(
          icon: Icons.keyboard,
          iconColor: _kPrimary,
          title: 'The Actions Framework',
          body: 'Flutter\'s actions system connects keyboard shortcuts to '
              'specific behaviors. A Shortcuts widget maps key combos to '
              'Intents, and an Actions widget maps Intents to Action objects.',
        ),
        const SizedBox(height: 20),

        // Chain diagram
        _hdr('Event Chain'),
        const SizedBox(height: 10),
        _buildChainDiagram(),
        const SizedBox(height: 20),

        // Key bindings table
        _hdr('Default Scroll Bindings'),
        const SizedBox(height: 10),
        _buildBindingsTable(),
        const SizedBox(height: 20),

        // ScrollIntent anatomy
        _hdr('ScrollIntent Anatomy'),
        const SizedBox(height: 10),
        _buildIntentAnatomy(),
        const SizedBox(height: 20),

        // isEnabled logic
        _hdr('isEnabled Logic'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ScrollAction.isEnabled(intent, context) returns true when:',
                style: TextStyle(
                    color: _kBrightText, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 12),
              _checkItem('Scrollable.maybeOf(context) != null',
                  'A Scrollable exists as ancestor'),
              const SizedBox(height: 8),
              _checkItem('OR PrimaryScrollController.maybeOf(context)?.hasClients',
                  'Primary controller has attached scrollables'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(10),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kAccent.withAlpha(40)),
                ),
                child: const Text(
                  'If neither condition is met, the action is disabled '
                  'and the key event falls through to other handlers.',
                  style: TextStyle(
                      color: _kDimText, fontSize: 12, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // getDirectionalIncrement
        _hdr('getDirectionalIncrement()'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(40)),
          ),
          child: const Text(
            'static double getDirectionalIncrement(\n'
            '  ScrollableState state,\n'
            '  ScrollIntent intent,\n'
            ') {\n'
            '  // 1. Check if axes align\n'
            '  //    (horizontal intent vs vertical\n'
            '  //     scrollable → returns 0)\n'
            '  // 2. Line: 50.0 px (or custom)\n'
            '  // 3. Page: viewport * 0.8\n'
            '  // 4. Negate if scrolling backward\n'
            '}',
            style: TextStyle(
                color: _kBrightText,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 20),

        // Usage pattern
        _hdr('Custom Scroll Increment'),
        const SizedBox(height: 10),
        _card(
          icon: Icons.tune,
          iconColor: _kAccent,
          title: 'Scrollable.incrementCalculator',
          body: 'You can customise the line scroll increment by providing '
              'an incrementCalculator callback to your Scrollable. This '
              'replaces the default 50.0 px with your own calculation.\n\n'
              'Example: scroll exactly one list item height per keystroke.',
        ),
      ],
    );
  }

  Widget _buildChainDiagram() {
    const links = [
      ('Key Event', Icons.keyboard, _kDimText),
      ('Shortcuts widget', Icons.shortcut, _kPrimary),
      ('ScrollIntent', Icons.swap_vert, _kAccent),
      ('Actions widget', Icons.settings_input_component, _kPrimary),
      ('ScrollAction', Icons.play_circle, _kAccent),
      ('Scrollable scrolls', Icons.arrow_downward, _kPrimary),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < links.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: links[i].$3.withAlpha(25),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: links[i].$3.withAlpha(80)),
                  ),
                  child: Icon(links[i].$2,
                      size: 16, color: links[i].$3),
                ),
                const SizedBox(width: 12),
                Text(links[i].$1,
                    style: TextStyle(
                        color: links[i].$3,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            if (i < links.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 16),
                height: 12,
                width: 2,
                color: links[i].$3.withAlpha(30),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildBindingsTable() {
    const bindings = [
      ('↑ Arrow', 'up', 'line', _kLine),
      ('↓ Arrow', 'down', 'line', _kLine),
      ('← Arrow', 'left', 'line', _kLine),
      ('→ Arrow', 'right', 'line', _kLine),
      ('Page Up', 'up', 'page', _kPage),
      ('Page Down', 'down', 'page', _kPage),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _kPrimary.withAlpha(20),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: const Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Key',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
                Expanded(
                    child: Text('Direction',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
                Expanded(
                    child: Text('Type',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
              ],
            ),
          ),
          ...bindings.map((b) => Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _kPrimary.withAlpha(25))),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: b.$4.withAlpha(15),
                                borderRadius:
                                    BorderRadius.circular(4),
                                border: Border.all(
                                    color: b.$4.withAlpha(40)),
                              ),
                              child: Text(b.$1,
                                  style: TextStyle(
                                      color: b.$4,
                                      fontSize: 12,
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        )),
                    Expanded(
                        child: Text(b.$2,
                            style: const TextStyle(
                                color: _kDimText,
                                fontSize: 12,
                                fontFamily: 'monospace'))),
                    Expanded(
                        child: Text(b.$3,
                            style: TextStyle(
                                color: b.$4,
                                fontSize: 12,
                                fontWeight: FontWeight.w600))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildIntentAnatomy() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ScrollIntent',
              style: TextStyle(
                  color: _kAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace')),
          const SizedBox(height: 12),
          _propRow('direction', 'AxisDirection', 'up, down, left, right', _kLine),
          const SizedBox(height: 6),
          _propRow('type', 'ScrollIncrementType', 'line or page', _kPage),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kPrimary.withAlpha(30)),
            ),
            child: const Text(
              'ScrollIntent(\n'
              '  direction: AxisDirection.down,\n'
              '  type: ScrollIncrementType.line,\n'
              ')',
              style: TextStyle(
                  color: _kBrightText,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _propRow(
      String name, String type, String values, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withAlpha(15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(type,
              style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace')),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace')),
              Text(values,
                  style: const TextStyle(
                      color: _kDimText, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _checkItem(String code, String desc) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.check_circle_outline,
          color: _kPrimary, size: 16),
      const SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(code,
                style: const TextStyle(
                    color: _kAccent,
                    fontSize: 11,
                    fontFamily: 'monospace')),
            Text(desc,
                style: const TextStyle(
                    color: _kDimText, fontSize: 11)),
          ],
        ),
      ),
    ],
  );
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
                color: _kBrightText,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

Widget _card({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: iconColor.withAlpha(50)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: _kBrightText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(body,
                  style: const TextStyle(
                      color: _kDimText, fontSize: 12, height: 1.5)),
            ],
          ),
        ),
      ],
    ),
  );
}
