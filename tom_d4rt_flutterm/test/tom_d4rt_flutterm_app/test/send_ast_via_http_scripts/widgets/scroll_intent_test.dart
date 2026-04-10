// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollIntent from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF1565C0); // Blue 800
const _kAccent = Color(0xFFFFEB3B); // Yellow 500
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kUp = Color(0xFF81C784); // Green 300
const _kDown = Color(0xFFE57373); // Red 300
const _kLeft = Color(0xFF4FC3F7); // LightBlue 300
const _kRight = Color(0xFFFFB74D); // Orange 300

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
    home: const _ScrollIntentDemo(),
  );
}

class _ScrollIntentDemo extends StatefulWidget {
  const _ScrollIntentDemo();

  @override
  State<_ScrollIntentDemo> createState() => _ScrollIntentDemoState();
}

class _ScrollIntentDemoState extends State<_ScrollIntentDemo>
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
        title: const Text('ScrollIntent',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.architecture), text: 'Anatomy'),
            Tab(icon: Icon(Icons.explore), text: 'Directions'),
            Tab(icon: Icon(Icons.science), text: 'Intent Builder'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _AnatomyTab(),
          _DirectionsTab(),
          _IntentBuilderTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Anatomy
// ═══════════════════════════════════════════════════════════════════════════
class _AnatomyTab extends StatelessWidget {
  const _AnatomyTab();

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
              colors: [Color(0xFF0D2740), Color(0xFF0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.swipe, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollIntent',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _badge('extends Intent', _kPrimary),
                  const SizedBox(width: 6),
                  _badge('immutable', _kAccent),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'An Intent subclass that requests scrolling in a specific '
                'direction with a specified increment type. Created by '
                'keyboard shortcuts, consumed by ScrollAction.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Constructor
        _hdr('Constructor'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPrimary.withAlpha(30)),
          ),
          child: const Text(
            'const ScrollIntent({\n'
            '  required AxisDirection direction,\n'
            '  ScrollIncrementType type =\n'
            '    ScrollIncrementType.line,\n'
            '})',
            style: TextStyle(
                color: _kBright,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 20),

        // Properties
        _hdr('Properties'),
        const SizedBox(height: 10),
        _propCard(
          'direction',
          'AxisDirection',
          'required',
          'The direction in which to scroll: up, down, left, or right',
          _kUp,
          Icons.explore,
        ),
        const SizedBox(height: 8),
        _propCard(
          'type',
          'ScrollIncrementType',
          'default: line',
          'How much to scroll — line (50px) or page (80% viewport)',
          _kAccent,
          Icons.straighten,
        ),
        const SizedBox(height: 20),

        // Inheritance
        _hdr('Inheritance Chain'),
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
              _inheritBox('Object', _kDim),
              _inheritArrow(),
              _inheritBox('Intent', _kPrimary),
              _inheritArrow(),
              _inheritBox('ScrollIntent', _kAccent),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Pipeline
        _hdr('Action Pipeline'),
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
              _flowStep('Key press on focused Scrollable', _kBright, 1),
              _flowArrow(),
              _flowStep('Shortcut maps key → ScrollIntent', _kAccent, 2),
              _flowArrow(),
              _flowStep(
                  'Actions.invoke(context, ScrollIntent(...))', _kDim, 3),
              _flowArrow(),
              _flowStep('ScrollAction.invoke() receives intent', _kPrimary, 4),
              _flowArrow(),
              _flowStep('Reads intent.direction + intent.type', _kUp, 5),
              _flowArrow(),
              _flowStep('Builds ScrollIncrementDetails', _kLeft, 6),
              _flowArrow(),
              _flowStep('Calculates pixel delta', _kRight, 7),
              _flowArrow(),
              _flowStep('ScrollPosition.moveTo()', _kDown, 8),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Key concepts
        _hdr('Key Concepts'),
        const SizedBox(height: 10),
        _conceptRow(Icons.keyboard, 'Keyboard-driven',
            'ScrollIntent is the bridge between keyboard '
            'events and scroll position changes'),
        const SizedBox(height: 6),
        _conceptRow(Icons.settings, 'Configurable',
            'Default type is line; page type sends '
            'larger increments for Page keys'),
        const SizedBox(height: 6),
        _conceptRow(Icons.lock, 'Immutable',
            'Once created, a ScrollIntent cannot be modified — '
            'this ensures safe propagation through the framework'),
        const SizedBox(height: 6),
        _conceptRow(Icons.layers, 'Actions framework',
            'Part of Flutter\'s Intent → Action pattern: '
            'Shortcuts create intents, Actions handle them'),
      ],
    );
  }

  static Widget _propCard(String name, String type, String req,
      String desc, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                            color: color,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace')),
                    const SizedBox(width: 6),
                    _badge(req, _kDim),
                  ],
                ),
                Text('→ $type',
                    style: const TextStyle(
                        color: _kDim,
                        fontFamily: 'monospace',
                        fontSize: 10)),
                const SizedBox(height: 4),
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

  static Widget _inheritBox(String name, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Center(
        child: Text(name,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: 'monospace')),
      ),
    );
  }

  static Widget _inheritArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Icon(Icons.arrow_downward,
          size: 14, color: _kDim.withAlpha(30)),
    );
  }

  static Widget _conceptRow(IconData icon, String title, String desc) {
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
// TAB 2 — Directions (AxisDirection explorer)
// ═══════════════════════════════════════════════════════════════════════════
class _DirectionsTab extends StatefulWidget {
  const _DirectionsTab();

  @override
  State<_DirectionsTab> createState() => _DirectionsTabState();
}

class _DirectionsTabState extends State<_DirectionsTab> {
  AxisDirection _selected = AxisDirection.down;
  ScrollIncrementType _type = ScrollIncrementType.line;

  Color _dirColor(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return _kUp;
      case AxisDirection.down:
        return _kDown;
      case AxisDirection.left:
        return _kLeft;
      case AxisDirection.right:
        return _kRight;
    }
  }

  IconData _dirIcon(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return Icons.arrow_upward;
      case AxisDirection.down:
        return Icons.arrow_downward;
      case AxisDirection.left:
        return Icons.arrow_back;
      case AxisDirection.right:
        return Icons.arrow_forward;
    }
  }

  String _dirKey(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return _type == ScrollIncrementType.line ? '↑' : 'PgUp';
      case AxisDirection.down:
        return _type == ScrollIncrementType.line ? '↓' : 'PgDn';
      case AxisDirection.left:
        return '←';
      case AxisDirection.right:
        return '→';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _dirColor(_selected);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Direction compass
        _hdr('Direction Compass'),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            width: 220,
            height: 220,
            child: Stack(
              children: [
                // Center
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withAlpha(15),
                      border: Border.all(color: color.withAlpha(50), width: 2),
                    ),
                    child: Center(
                      child: Icon(_dirIcon(_selected),
                          color: color, size: 24),
                    ),
                  ),
                ),
                // Up
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _dirBtn(AxisDirection.up),
                  ),
                ),
                // Down
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _dirBtn(AxisDirection.down),
                  ),
                ),
                // Left
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _dirBtn(AxisDirection.left),
                  ),
                ),
                // Right
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _dirBtn(AxisDirection.right),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Type toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () =>
                  setState(() => _type = ScrollIncrementType.line),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: _type == ScrollIncrementType.line
                      ? _kAccent.withAlpha(15)
                      : _kCard,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _type == ScrollIncrementType.line
                          ? _kAccent.withAlpha(40)
                          : _kDim.withAlpha(15)),
                ),
                child: Text('Line',
                    style: TextStyle(
                        color: _type == ScrollIncrementType.line
                            ? _kAccent
                            : _kDim,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () =>
                  setState(() => _type = ScrollIncrementType.page),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: _type == ScrollIncrementType.page
                      ? _kAccent.withAlpha(15)
                      : _kCard,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _type == ScrollIncrementType.page
                          ? _kAccent.withAlpha(40)
                          : _kDim.withAlpha(15)),
                ),
                child: Text('Page',
                    style: TextStyle(
                        color: _type == ScrollIncrementType.page
                            ? _kAccent
                            : _kDim,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Current intent card
        _hdr('Current Intent'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withAlpha(50)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withAlpha(15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(_dirIcon(_selected),
                        color: color, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ScrollIntent',
                            style: TextStyle(
                                color: color,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text('Key: ${_dirKey(_selected)}',
                            style: const TextStyle(
                                color: _kDim, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'ScrollIntent(\n'
                  '  direction: AxisDirection.${_selected.name},\n'
                  '  type: ScrollIncrementType.${_type.name},\n'
                  ')',
                  style: const TextStyle(
                      color: _kBright,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // All 4 directions
        _hdr('All Directions'),
        const SizedBox(height: 10),
        ...AxisDirection.values.map((d) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _dirDetailCard(d),
            )),
      ],
    );
  }

  Widget _dirBtn(AxisDirection dir) {
    final c = _dirColor(dir);
    final active = _selected == dir;
    return GestureDetector(
      onTap: () => setState(() => _selected = dir),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? c.withAlpha(25) : _kCard,
          border: Border.all(
              color: active ? c.withAlpha(60) : _kDim.withAlpha(15),
              width: active ? 2 : 1),
        ),
        child: Center(
          child: Icon(_dirIcon(dir),
              color: active ? c : _kDim.withAlpha(40), size: 22),
        ),
      ),
    );
  }

  Widget _dirDetailCard(AxisDirection d) {
    final c = _dirColor(d);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: d == _selected ? c.withAlpha(50) : _kDim.withAlpha(10)),
      ),
      child: Row(
        children: [
          Icon(_dirIcon(d), color: c, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AxisDirection.${d.name}',
                    style: TextStyle(
                        color: c,
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
                Text(_dirDesc(d),
                    style: const TextStyle(
                        color: _kDim, fontSize: 9)),
              ],
            ),
          ),
          _badge(_dirKey(d), c),
        ],
      ),
    );
  }

  static String _dirDesc(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return 'Scroll content upward (offset decreases)';
      case AxisDirection.down:
        return 'Scroll content downward (offset increases)';
      case AxisDirection.left:
        return 'Scroll content leftward (horizontal)';
      case AxisDirection.right:
        return 'Scroll content rightward (horizontal)';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Intent Builder (interactive constructor)
// ═══════════════════════════════════════════════════════════════════════════
class _IntentBuilderTab extends StatefulWidget {
  const _IntentBuilderTab();

  @override
  State<_IntentBuilderTab> createState() => _IntentBuilderTabState();
}

class _IntentBuilderTabState extends State<_IntentBuilderTab> {
  AxisDirection _dir = AxisDirection.down;
  ScrollIncrementType _type = ScrollIncrementType.line;
  final ScrollController _ctrl = ScrollController();
  final List<_IntentExec> _history = [];
  double _currentOffset = 0;

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

  Color _dirColor() {
    switch (_dir) {
      case AxisDirection.up:
        return _kUp;
      case AxisDirection.down:
        return _kDown;
      case AxisDirection.left:
        return _kLeft;
      case AxisDirection.right:
        return _kRight;
    }
  }

  void _execute() {
    if (!_ctrl.hasClients) return;
    final pos = _ctrl.position;
    final double amount;
    if (_type == ScrollIncrementType.line) {
      amount = 50.0;
    } else {
      amount = 0.8 * pos.viewportDimension;
    }
    final bool isForward =
        _dir == AxisDirection.down || _dir == AxisDirection.right;
    final delta = isForward ? amount : -amount;
    final target = (_ctrl.offset + delta).clamp(0.0, pos.maxScrollExtent);
    _ctrl.animateTo(target,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut);
    setState(() {
      _history.insert(
          0,
          _IntentExec(
            direction: _dir,
            type: _type,
            amount: amount,
            targetOffset: target,
          ));
      if (_history.length > 15) _history.removeLast();
    });
  }

  void _reset() {
    _ctrl.animateTo(0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    setState(() => _history.clear());
  }

  @override
  Widget build(BuildContext context) {
    final dc = _dirColor();
    return Column(
      children: [
        // Builder
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Column(
            children: [
              // Direction selector
              Row(
                children: [
                  const Text('Direction:',
                      style: TextStyle(
                          color: _kDim,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  ...AxisDirection.values.map((d) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: GestureDetector(
                          onTap: () => setState(() => _dir = d),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _dir == d
                                  ? _colorFor(d).withAlpha(15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: _dir == d
                                      ? _colorFor(d).withAlpha(40)
                                      : _kDim.withAlpha(10)),
                            ),
                            child: Text(d.name,
                                style: TextStyle(
                                    color:
                                        _dir == d ? _colorFor(d) : _kDim,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 6),
              // Type selector
              Row(
                children: [
                  const Text('Type:',
                      style: TextStyle(
                          color: _kDim,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  ...ScrollIncrementType.values.map((t) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: GestureDetector(
                          onTap: () => setState(() => _type = t),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _type == t
                                  ? _kAccent.withAlpha(15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: _type == t
                                      ? _kAccent.withAlpha(40)
                                      : _kDim.withAlpha(10)),
                            ),
                            child: Text(t.name,
                                style: TextStyle(
                                    color: _type == t ? _kAccent : _kDim,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),

        // Code preview
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: const Color(0xFF1A1A2E),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'ScrollIntent(direction: .${_dir.name}, '
                  'type: .${_type.name})',
                  style: TextStyle(
                      color: dc,
                      fontFamily: 'monospace',
                      fontSize: 10),
                ),
              ),
              GestureDetector(
                onTap: _execute,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: dc.withAlpha(20),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: dc.withAlpha(50)),
                  ),
                  child: Text('Execute',
                      style: TextStyle(
                          color: dc,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),

        // Offset
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Text('Offset: ${_currentOffset.toStringAsFixed(0)} px',
                  style: const TextStyle(
                      color: _kBright,
                      fontFamily: 'monospace',
                      fontSize: 11)),
              const Spacer(),
              GestureDetector(
                onTap: _reset,
                child: const Icon(Icons.refresh, color: _kDim, size: 16),
              ),
            ],
          ),
        ),

        // Scrollable
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: dc.withAlpha(30)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListView.builder(
                controller: _ctrl,
                itemCount: 80,
                itemBuilder: (ctx, i) {
                  final f = i / 80;
                  return Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255,
                          (f * 30 + 10).toInt(),
                          (f * 40 + 20).toInt(),
                          (f * 60 + 40).toInt()),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text('$i',
                        style: const TextStyle(
                            color: _kAccent, fontSize: 10)),
                  );
                },
              ),
            ),
          ),
        ),

        // History
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
            child: _history.isEmpty
                ? const Center(
                    child: Text('Execute intents to see history',
                        style: TextStyle(color: _kDim, fontSize: 11)))
                : ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (ctx, i) {
                      final h = _history[i];
                      final c = _colorFor(h.direction);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '${h.direction.name} '
                          '${h.type.name} '
                          '${h.amount.toStringAsFixed(0)}px → '
                          '${h.targetOffset.toStringAsFixed(0)}px',
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

  static Color _colorFor(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return _kUp;
      case AxisDirection.down:
        return _kDown;
      case AxisDirection.left:
        return _kLeft;
      case AxisDirection.right:
        return _kRight;
    }
  }
}

class _IntentExec {
  final AxisDirection direction;
  final ScrollIncrementType type;
  final double amount;
  final double targetOffset;

  const _IntentExec({
    required this.direction,
    required this.type,
    required this.amount,
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

Widget _flowStep(String text, Color color, int num) {
  return Row(
    children: [
      Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withAlpha(20),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Center(
          child: Text('$num',
              style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(text,
            style: TextStyle(color: color, fontSize: 11, height: 1.3)),
      ),
    ],
  );
}

Widget _flowArrow() {
  return Padding(
    padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
    child: Icon(Icons.keyboard_arrow_down,
        size: 14, color: _kDim.withAlpha(40)),
  );
}
