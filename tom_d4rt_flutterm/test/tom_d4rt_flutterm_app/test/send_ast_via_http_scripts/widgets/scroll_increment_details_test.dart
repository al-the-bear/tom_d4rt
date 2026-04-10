// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollIncrementDetails from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF00695C); // Teal 800
const _kAccent = Color(0xFFFF80AB); // Pink A100
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kLine = Color(0xFF4FC3F7); // LightBlue 300
const _kPage = Color(0xFFFFD54F); // Amber 300

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
    home: const _ScrollIncrementDetailsDemo(),
  );
}

class _ScrollIncrementDetailsDemo extends StatefulWidget {
  const _ScrollIncrementDetailsDemo();

  @override
  State<_ScrollIncrementDetailsDemo> createState() =>
      _ScrollIncrementDetailsDemoState();
}

class _ScrollIncrementDetailsDemoState
    extends State<_ScrollIncrementDetailsDemo>
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
        title: const Text('ScrollIncrementDetails',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.data_object), text: 'Structure'),
            Tab(icon: Icon(Icons.calculate), text: 'Calculator'),
            Tab(icon: Icon(Icons.compare_arrows), text: 'Live Compare'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _StructureTab(),
          _CalculatorTab(),
          _LiveCompareTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Structure
// ═══════════════════════════════════════════════════════════════════════════
class _StructureTab extends StatelessWidget {
  const _StructureTab();

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
              colors: [Color(0xFF00332D), Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.data_object, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollIncrementDetails',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _badge('immutable class', _kPrimary),
                  const SizedBox(width: 6),
                  _badge('data holder', _kAccent),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'An immutable data class that bundles the increment type '
                '(line or page) together with the current scroll metrics. '
                'Passed to ScrollIncrementCalculator functions.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

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
            'const ScrollIncrementDetails({\n'
            '  required ScrollIncrementType type,\n'
            '  required ScrollMetrics metrics,\n'
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
          'type',
          'ScrollIncrementType',
          'Describes whether the scroll is by line or page',
          _kLine,
          Icons.text_rotation_none,
        ),
        const SizedBox(height: 8),
        _propCard(
          'metrics',
          'ScrollMetrics',
          'Snapshot of the scrollable viewport — contains pixels, extents, '
          'viewport dimension, and axis direction',
          _kPage,
          Icons.straighten,
        ),
        const SizedBox(height: 20),

        // Metrics contents
        _hdr('ScrollMetrics Fields'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(40)),
          ),
          child: Column(
            children: [
              _metricRow('pixels', 'double',
                  'Current scroll offset'),
              const Divider(height: 1, color: Color(0xFF2A2A2A)),
              _metricRow('minScrollExtent', 'double',
                  'Minimum scrollable offset'),
              const Divider(height: 1, color: Color(0xFF2A2A2A)),
              _metricRow('maxScrollExtent', 'double',
                  'Maximum scrollable offset'),
              const Divider(height: 1, color: Color(0xFF2A2A2A)),
              _metricRow('viewportDimension', 'double',
                  'Viewport size along scroll axis'),
              const Divider(height: 1, color: Color(0xFF2A2A2A)),
              _metricRow('axisDirection', 'AxisDirection',
                  'Scroll direction (down, up, left, right)'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Typedef
        _hdr('ScrollIncrementCalculator'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'typedef ScrollIncrementCalculator =\n'
                '  double Function(\n'
                '    ScrollIncrementDetails details,\n'
                '  );',
                style: TextStyle(
                    color: _kBright,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    height: 1.5),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Set on Scrollable.incrementCalculator to customize '
                  'how much to scroll for keyboard-triggered increments.',
                  style: TextStyle(
                      color: _kDim, fontSize: 10, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Flow
        _hdr('Pipeline'),
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
              _flowStep('Keyboard sends ScrollIntent', _kBright, 1),
              _flowArrow(),
              _flowStep('ScrollAction receives intent', _kDim, 2),
              _flowArrow(),
              _flowStep(
                  'Builds ScrollIncrementDetails(type, metrics)', _kAccent, 3),
              _flowArrow(),
              _flowStep('Calls incrementCalculator(details)', _kLine, 4),
              _flowArrow(),
              _flowStep('Returns pixel delta', _kPage, 5),
              _flowArrow(),
              _flowStep('Applies offset to ScrollPosition', _kPrimary, 6),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _propCard(
    String name,
    String type,
    String desc,
    Color color,
    IconData icon,
  ) {
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
                    Text('→ $type',
                        style: const TextStyle(
                            color: _kDim,
                            fontFamily: 'monospace',
                            fontSize: 10)),
                  ],
                ),
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

  static Widget _metricRow(String name, String type, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(name,
                style: const TextStyle(
                    color: _kBright,
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(type,
                style: const TextStyle(
                    color: _kPrimary,
                    fontFamily: 'monospace',
                    fontSize: 10)),
          ),
          Expanded(
            flex: 4,
            child: Text(desc,
                style: const TextStyle(color: _kDim, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Calculator (interactive calculation demo)
// ═══════════════════════════════════════════════════════════════════════════
class _CalculatorTab extends StatefulWidget {
  const _CalculatorTab();

  @override
  State<_CalculatorTab> createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<_CalculatorTab> {
  double _viewport = 600;
  double _pixels = 200;
  double _maxExtent = 2000;
  bool _isPageType = false;
  double _customMultiplier = 1.0;

  double get _defaultLine => 50.0;
  double get _defaultPage => 0.8 * _viewport;
  double get _customResult => _isPageType
      ? _defaultPage * _customMultiplier
      : _defaultLine * _customMultiplier;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Type selector
        _hdr('Increment Type'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isPageType = false),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: !_isPageType
                        ? _kLine.withAlpha(15)
                        : _kCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: !_isPageType
                            ? _kLine.withAlpha(60)
                            : _kDim.withAlpha(15)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.text_fields,
                          color: !_isPageType ? _kLine : _kDim,
                          size: 28),
                      const SizedBox(height: 6),
                      Text('LINE',
                          style: TextStyle(
                              color:
                                  !_isPageType ? _kLine : _kDim,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 1)),
                      const SizedBox(height: 4),
                      Text('Arrow keys',
                          style: TextStyle(
                              color: !_isPageType
                                  ? _kLine.withAlpha(150)
                                  : _kDim.withAlpha(50),
                              fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isPageType = true),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _isPageType
                        ? _kPage.withAlpha(15)
                        : _kCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: _isPageType
                            ? _kPage.withAlpha(60)
                            : _kDim.withAlpha(15)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.description,
                          color: _isPageType ? _kPage : _kDim,
                          size: 28),
                      const SizedBox(height: 6),
                      Text('PAGE',
                          style: TextStyle(
                              color:
                                  _isPageType ? _kPage : _kDim,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 1)),
                      const SizedBox(height: 4),
                      Text('PageUp / PageDown',
                          style: TextStyle(
                              color: _isPageType
                                  ? _kPage.withAlpha(150)
                                  : _kDim.withAlpha(50),
                              fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Metrics sliders
        _hdr('Scroll Metrics'),
        const SizedBox(height: 10),
        _sliderRow('Viewport', _viewport, 200, 1200,
            (v) => setState(() => _viewport = v), _kPrimary),
        _sliderRow('Pixels', _pixels, 0, _maxExtent,
            (v) => setState(() => _pixels = v), _kAccent),
        _sliderRow('Max Extent', _maxExtent, 500, 5000,
            (v) {
          setState(() {
            _maxExtent = v;
            if (_pixels > _maxExtent) _pixels = _maxExtent;
          });
        }, _kDim),
        const SizedBox(height: 16),

        // Details object
        _hdr('ScrollIncrementDetails Object'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPrimary.withAlpha(30)),
          ),
          child: Text(
            'ScrollIncrementDetails(\n'
            '  type: ScrollIncrementType.${_isPageType ? "page" : "line"},\n'
            '  metrics: ScrollMetrics(\n'
            '    pixels: ${_pixels.toStringAsFixed(0)},\n'
            '    maxScrollExtent: ${_maxExtent.toStringAsFixed(0)},\n'
            '    viewportDimension: ${_viewport.toStringAsFixed(0)},\n'
            '  ),\n'
            ')',
            style: const TextStyle(
                color: _kBright,
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 20),

        // Calculation
        _hdr('Default Calculation'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: (_isPageType ? _kPage : _kLine).withAlpha(40)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isPageType ? 'Page increment' : 'Line increment',
                    style: TextStyle(
                        color: _isPageType ? _kPage : _kLine,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  _badge(
                    _isPageType ? 'page' : 'line',
                    _isPageType ? _kPage : _kLine,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _isPageType
                      ? '0.8 × ${_viewport.toStringAsFixed(0)} = ${_defaultPage.toStringAsFixed(0)} px'
                      : '50.0 px (constant)',
                  style: TextStyle(
                      color: _isPageType ? _kPage : _kLine,
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Custom multiplier
        _hdr('Custom Calculator'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kAccent.withAlpha(40)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Multiplier:',
                      style: TextStyle(color: _kDim, fontSize: 11)),
                  Expanded(
                    child: Slider(
                      value: _customMultiplier,
                      min: 0.2,
                      max: 3.0,
                      divisions: 28,
                      activeColor: _kAccent,
                      inactiveColor: _kDim.withAlpha(20),
                      onChanged: (v) =>
                          setState(() => _customMultiplier = v),
                    ),
                  ),
                  Text('${_customMultiplier.toStringAsFixed(1)}×',
                      style: const TextStyle(
                          color: _kAccent,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Custom result:',
                        style: TextStyle(
                            color: _kDim,
                            fontSize: 11,
                            fontFamily: 'monospace')),
                    Text('${_customResult.toStringAsFixed(0)} px',
                        style: const TextStyle(
                            color: _kAccent,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'double myCustomCalculator(\n'
                  '  ScrollIncrementDetails details,\n'
                  ') {\n'
                  '  final base = details.type ==\n'
                  '    ScrollIncrementType.page\n'
                  '    ? details.metrics.\n'
                  '        viewportDimension * 0.8\n'
                  '    : 50.0;\n'
                  '  return base * multiplier;\n'
                  '}',
                  style: TextStyle(
                      color: _kDim,
                      fontFamily: 'monospace',
                      fontSize: 9,
                      height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sliderRow(String label, double value, double min, double max,
      ValueChanged<double> onChanged, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: TextStyle(
                    color: color, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              activeColor: color,
              inactiveColor: _kDim.withAlpha(15),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(value.toStringAsFixed(0),
                textAlign: TextAlign.right,
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
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Live Compare (side-by-side line vs page in real scroll)
// ═══════════════════════════════════════════════════════════════════════════
class _LiveCompareTab extends StatefulWidget {
  const _LiveCompareTab();

  @override
  State<_LiveCompareTab> createState() => _LiveCompareTabState();
}

class _LiveCompareTabState extends State<_LiveCompareTab> {
  final ScrollController _lineCtrl = ScrollController();
  final ScrollController _pageCtrl = ScrollController();
  int _lineIncrements = 0;
  int _pageIncrements = 0;
  double _lineOffset = 0;
  double _pageOffset = 0;

  @override
  void initState() {
    super.initState();
    _lineCtrl.addListener(() {
      if (_lineCtrl.hasClients) {
        setState(() => _lineOffset = _lineCtrl.position.pixels);
      }
    });
    _pageCtrl.addListener(() {
      if (_pageCtrl.hasClients) {
        setState(() => _pageOffset = _pageCtrl.position.pixels);
      }
    });
  }

  @override
  void dispose() {
    _lineCtrl.dispose();
    _pageCtrl.dispose();
    super.dispose();
  }

  void _doLineIncrement() {
    if (!_lineCtrl.hasClients) return;
    const inc = 50.0;
    final target = (_lineCtrl.offset + inc)
        .clamp(0.0, _lineCtrl.position.maxScrollExtent);
    _lineCtrl.animateTo(target,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut);
    setState(() => _lineIncrements++);
  }

  void _doPageIncrement() {
    if (!_pageCtrl.hasClients) return;
    final inc = 0.8 * _pageCtrl.position.viewportDimension;
    final target = (_pageCtrl.offset + inc)
        .clamp(0.0, _pageCtrl.position.maxScrollExtent);
    _pageCtrl.animateTo(target,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    setState(() => _pageIncrements++);
  }

  void _reset() {
    _lineCtrl.animateTo(0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    _pageCtrl.animateTo(0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    setState(() {
      _lineIncrements = 0;
      _pageIncrements = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Explanation
        Container(
          padding: const EdgeInsets.all(10),
          color: _kCard,
          child: const Text(
            'Compare line vs page increments side by side. Each button '
            'simulates the ScrollIncrementDetails being passed to the '
            'default calculator.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _kDim, fontSize: 10, height: 1.3),
          ),
        ),

        // Stats
        Row(
          children: [
            _statBox('LINE', _lineIncrements, _lineOffset, _kLine),
            _statBox('PAGE', _pageIncrements, _pageOffset, _kPage),
          ],
        ),

        // Scrollable pair
        Expanded(
          child: Row(
            children: [
              // Line side
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: GestureDetector(
                        onTap: _doLineIncrement,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 14),
                          decoration: BoxDecoration(
                            color: _kLine.withAlpha(15),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: _kLine.withAlpha(40)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward,
                                  size: 14, color: _kLine),
                              const SizedBox(width: 4),
                              const Text('Line +50px',
                                  style: TextStyle(
                                      color: _kLine,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 8, right: 2, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: _kLine.withAlpha(30)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ListView.builder(
                            controller: _lineCtrl,
                            itemCount: 60,
                            itemBuilder: (ctx, i) => Container(
                              height: 38,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    255,
                                    0,
                                    (i / 60 * 40 + 40).toInt(),
                                    (i / 60 * 50 + 30).toInt()),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: Text('$i',
                                  style: const TextStyle(
                                      color: _kLine, fontSize: 10)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Page side
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: GestureDetector(
                        onTap: _doPageIncrement,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 14),
                          decoration: BoxDecoration(
                            color: _kPage.withAlpha(15),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: _kPage.withAlpha(40)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward,
                                  size: 14, color: _kPage),
                              const SizedBox(width: 4),
                              const Text('Page +80%',
                                  style: TextStyle(
                                      color: _kPage,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 2, right: 8, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: _kPage.withAlpha(30)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ListView.builder(
                            controller: _pageCtrl,
                            itemCount: 60,
                            itemBuilder: (ctx, i) => Container(
                              height: 38,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    255,
                                    (i / 60 * 40 + 40).toInt(),
                                    (i / 60 * 30 + 30).toInt(),
                                    0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: Text('$i',
                                  style: const TextStyle(
                                      color: _kPage, fontSize: 10)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Reset
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: _reset,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              decoration: BoxDecoration(
                color: _kDim.withAlpha(10),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kDim.withAlpha(20)),
              ),
              child: const Text('Reset',
                  style: TextStyle(
                      color: _kDim,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statBox(String label, int count, double offset, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        color: color.withAlpha(8),
        child: Row(
          children: [
            _badge(label, color),
            const Spacer(),
            Text('#$count',
                style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text('${offset.toStringAsFixed(0)}px',
                style: const TextStyle(
                    color: _kBright,
                    fontFamily: 'monospace',
                    fontSize: 10)),
          ],
        ),
      ),
    );
  }
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
