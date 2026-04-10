// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollDecelerationRate from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF00796B); // Teal 700
const _kAccent = Color(0xFFFFFF00); // Yellow A200
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kNormal = Color(0xFF64B5F6); // Blue 300
const _kFast = Color(0xFFEF5350); // Red 400

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
    home: const _ScrollDecelerationRateDemo(),
  );
}

class _ScrollDecelerationRateDemo extends StatefulWidget {
  const _ScrollDecelerationRateDemo();

  @override
  State<_ScrollDecelerationRateDemo> createState() =>
      _ScrollDecelerationRateDemoState();
}

class _ScrollDecelerationRateDemoState
    extends State<_ScrollDecelerationRateDemo>
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
        title: const Text('ScrollDecelerationRate',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.list_alt), text: 'Values'),
            Tab(icon: Icon(Icons.science), text: 'Physics Lab'),
            Tab(icon: Icon(Icons.devices), text: 'Platform'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ValuesTab(),
          _PhysicsLabTab(),
          _PlatformTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Values
// ═══════════════════════════════════════════════════════════════════════════
class _ValuesTab extends StatelessWidget {
  const _ValuesTab();

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
              colors: [Color(0xFF004D40), Color(0xFF00695C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.speed, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollDecelerationRate',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kAccent.withAlpha(80)),
                ),
                child: Text(
                  'enum ScrollDecelerationRate',
                  style: TextStyle(
                      color: _kAccent.withAlpha(200),
                      fontSize: 11,
                      fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Controls how quickly scroll momentum decays. Used by '
                'ClampingScrollSimulation to determine the friction factor. '
                'Higher deceleration = scroll stops sooner.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Value count
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${ScrollDecelerationRate.values.length} Values',
                style: const TextStyle(
                    color: _kAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              const Text('|',
                  style: TextStyle(color: _kDim, fontSize: 14)),
              const SizedBox(width: 12),
              Text(
                'first: ${ScrollDecelerationRate.values.first.name}',
                style: const TextStyle(
                    color: _kNormal,
                    fontSize: 12,
                    fontFamily: 'monospace'),
              ),
              const SizedBox(width: 12),
              Text(
                'last: ${ScrollDecelerationRate.values.last.name}',
                style: const TextStyle(
                    color: _kFast,
                    fontSize: 12,
                    fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Value 1: normal
        _hdr('ScrollDecelerationRate.normal'),
        const SizedBox(height: 10),
        _valueCard(
          ScrollDecelerationRate.normal,
          _kNormal,
          'Standard mobile deceleration',
          'Mimics the native feel of iOS and Android touch scrolling. '
              'After the user lifts their finger, scroll coasts for a '
              'comfortable distance before stopping. Feels natural for '
              'reading long content.',
          [
            'Index: ${ScrollDecelerationRate.normal.index}',
            'Default for: Touch-screen scrolling',
            'Coast distance: Longer (scroll glides far)',
            'Stop time: Slower (gradual deceleration)',
            'User feel: Smooth, fluid, inertial',
          ],
          Icons.touch_app,
        ),
        const SizedBox(height: 16),

        // Value 2: fast
        _hdr('ScrollDecelerationRate.fast'),
        const SizedBox(height: 10),
        _valueCard(
          ScrollDecelerationRate.fast,
          _kFast,
          'Increased desktop deceleration',
          'Designed for mouse wheel and trackpad input. Scroll stops '
              'quickly after the user finishes their gesture. This matches '
              'desktop application expectations where precise positioning '
              'matters more than fluid coasting.',
          [
            'Index: ${ScrollDecelerationRate.fast.index}',
            'Default for: Mouse wheel, trackpad',
            'Coast distance: Shorter (stops quickly)',
            'Stop time: Faster (abrupt deceleration)',
            'User feel: Precise, controlled, snappy',
          ],
          Icons.mouse,
        ),
        const SizedBox(height: 20),

        // Equality matrix
        _hdr('Equality Matrix'),
        const SizedBox(height: 10),
        _buildEqualityMatrix(),
        const SizedBox(height: 20),

        // Visual deceleration curves
        _hdr('Deceleration Profile Comparison'),
        const SizedBox(height: 10),
        _buildDecelerationBars(),
      ],
    );
  }

  Widget _buildEqualityMatrix() {
    final values = ScrollDecelerationRate.values;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          // Header row
          Row(
            children: [
              const SizedBox(width: 80),
              ...values.map((v) => Expanded(
                    child: Center(
                      child: Text(v.name,
                          style: TextStyle(
                              color: v == ScrollDecelerationRate.normal
                                  ? _kNormal
                                  : _kFast,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace')),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 8),
          // Rows
          ...values.map((row) {
            final rowColor = row == ScrollDecelerationRate.normal
                ? _kNormal
                : _kFast;
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(row.name,
                        style: TextStyle(
                            color: rowColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace')),
                  ),
                  ...values.map((col) {
                    final equal = row == col;
                    return Expanded(
                      child: Center(
                        child: Container(
                          width: 36,
                          height: 28,
                          decoration: BoxDecoration(
                            color: equal
                                ? const Color(0xFF2E7D32).withAlpha(25)
                                : const Color(0xFFC62828).withAlpha(15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: equal
                                    ? const Color(0xFF66BB6A)
                                    : const Color(0xFFE57373)),
                          ),
                          child: Center(
                            child: Text(
                              equal ? '==' : '!=',
                              style: TextStyle(
                                  color: equal
                                      ? const Color(0xFF66BB6A)
                                      : const Color(0xFFE57373),
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDecelerationBars() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          const Text('Relative Scroll Distance After Fling',
              style: TextStyle(
                  color: _kDim, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          // Normal (long bar)
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Text('normal',
                    style: TextStyle(
                        color: _kNormal,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kNormal, _kNormal.withAlpha(40)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Fast (short bar)
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Text('fast',
                    style: TextStyle(
                        color: _kFast,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_kFast, _kFast.withAlpha(40)],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const Expanded(flex: 6, child: SizedBox()),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Same initial velocity → normal coasts ~2.5× farther than fast',
            textAlign: TextAlign.center,
            style: TextStyle(color: _kDim, fontSize: 10, height: 1.3),
          ),
        ],
      ),
    );
  }

  static Widget _valueCard(
    ScrollDecelerationRate value,
    Color color,
    String subtitle,
    String description,
    List<String> facts,
    IconData icon,
  ) {
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('.${value.name}',
                        style: TextStyle(
                            color: color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace')),
                    Text(subtitle,
                        style: const TextStyle(
                            color: _kDim, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description,
              style: const TextStyle(
                  color: _kDim, fontSize: 12, height: 1.5)),
          const SizedBox(height: 12),
          ...facts.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_right, size: 14, color: color),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(f,
                          style: const TextStyle(
                              color: _kDim, fontSize: 11, height: 1.3)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Physics Lab (side-by-side scrollables)
// ═══════════════════════════════════════════════════════════════════════════
class _PhysicsLabTab extends StatelessWidget {
  const _PhysicsLabTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _kCard,
          child: const Text(
            'Drag both lists and feel the difference. '
            'Left uses bouncing (normal-feel), right uses clamping (fast-feel).',
            textAlign: TextAlign.center,
            style: TextStyle(color: _kDim, fontSize: 11, height: 1.3),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              // Left: Normal / Bouncing
              Expanded(
                child: _ScrollPanel(
                  label: 'normal',
                  color: _kNormal,
                  physics: const BouncingScrollPhysics(),
                  itemPrefix: 'Coast',
                ),
              ),
              Container(width: 1, color: _kDim.withAlpha(25)),
              // Right: Fast / Clamping
              Expanded(
                child: _ScrollPanel(
                  label: 'fast',
                  color: _kFast,
                  physics: const ClampingScrollPhysics(),
                  itemPrefix: 'Snap',
                ),
              ),
            ],
          ),
        ),

        // Bottom info panel
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Column(
            children: [
              _hdr('How ScrollPhysics Uses DecelerationRate'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kPrimary.withAlpha(30)),
                ),
                child: const Text(
                  'ClampingScrollSimulation(\n'
                  '  position: pixels,\n'
                  '  velocity: velocity,\n'
                  '  friction: decelerationRate == fast\n'
                  '    ? 0.07 : 0.015,  // higher = stops sooner\n'
                  ')',
                  style: TextStyle(
                      color: _kBright,
                      fontFamily: 'monospace',
                      fontSize: 11,
                      height: 1.5),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'The deceleration rate selects a friction coefficient. '
                'Fast uses ~4.7× more friction than normal.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 10, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ScrollPanel extends StatefulWidget {
  final String label;
  final Color color;
  final ScrollPhysics physics;
  final String itemPrefix;

  const _ScrollPanel({
    required this.label,
    required this.color,
    required this.physics,
    required this.itemPrefix,
  });

  @override
  State<_ScrollPanel> createState() => _ScrollPanelState();
}

class _ScrollPanelState extends State<_ScrollPanel> {
  final ScrollController _ctrl = ScrollController();
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      if (_ctrl.hasClients) {
        setState(() => _offset = _ctrl.position.pixels);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: widget.color.withAlpha(15),
          child: Column(
            children: [
              Text(widget.label.toUpperCase(),
                  style: TextStyle(
                      color: widget.color,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5)),
              Text('${_offset.toStringAsFixed(0)} px',
                  style: TextStyle(
                      color: widget.color.withAlpha(150),
                      fontSize: 10,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        // List
        Expanded(
          child: ListView.builder(
            controller: _ctrl,
            physics: widget.physics,
            itemCount: 60,
            itemBuilder: (ctx, i) {
              final hue = widget.color == _kNormal
                  ? (200 + i * 2.0) % 360
                  : (0 + i * 3.0) % 360;
              return Container(
                height: 46,
                margin: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      HSLColor.fromAHSL(1, hue, 0.25, 0.16).toColor(),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: HSLColor.fromAHSL(1, hue, 0.35, 0.28)
                          .toColor()),
                ),
                alignment: Alignment.center,
                child: Text('${widget.itemPrefix} $i',
                    style: TextStyle(
                        color: HSLColor.fromAHSL(1, hue, 0.5, 0.6)
                            .toColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Platform Defaults
// ═══════════════════════════════════════════════════════════════════════════
class _PlatformTab extends StatelessWidget {
  const _PlatformTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _hdr('Platform Input Mapping'),
        const SizedBox(height: 10),
        const Text(
          'Flutter automatically picks the deceleration rate based on '
          'the input device and target platform. Here are the common '
          'defaults:',
          style: TextStyle(color: _kDim, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 16),

        // Device cards
        _deviceCard(
          'Touch (finger)',
          Icons.touch_app,
          _kNormal,
          'ScrollDecelerationRate.normal',
          'Android, iOS, and any touch input. Long coasting distance for '
              'natural flick scrolling. The user expects content to glide.',
          ['Android phones/tablets', 'iOS devices', 'Touch-screen laptops'],
        ),
        const SizedBox(height: 12),
        _deviceCard(
          'Mouse Wheel',
          Icons.mouse,
          _kFast,
          'ScrollDecelerationRate.fast',
          'Desktop mouse scroll wheel. Short momentum for precise control. '
              'Each discrete wheel notch scrolls a small fixed amount.',
          ['Windows desktop', 'macOS with mouse', 'Linux desktop'],
        ),
        const SizedBox(height: 12),
        _deviceCard(
          'Trackpad',
          Icons.laptop,
          _kFast,
          'ScrollDecelerationRate.fast',
          'Laptop trackpad gestures. While trackpads are continuous like '
              'touch, Flutter uses fast deceleration on desktop platforms '
              'for consistency with mouse wheel behavior.',
          ['macOS trackpad', 'Windows precision touchpad', 'Linux touchpad'],
        ),
        const SizedBox(height: 12),
        _deviceCard(
          'Stylus / Pen',
          Icons.edit,
          _kNormal,
          'ScrollDecelerationRate.normal',
          'Stylus input behaves like touch. The user drags with precision '
              'but expects fluid coasting. Same deceleration as finger input.',
          ['Surface Pen', 'Apple Pencil (via touch)', 'Wacom tablets'],
        ),
        const SizedBox(height: 20),

        _hdr('Override Example'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(30)),
          ),
          child: const Text(
            'class FastScrollPhysics\n'
            '    extends ClampingScrollPhysics {\n'
            '  @override\n'
            '  ScrollDecelerationRate get\n'
            '    decelerationRate =>\n'
            '      ScrollDecelerationRate.fast;\n'
            '}',
            style: TextStyle(
                color: _kBright,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kAccent.withAlpha(8),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kAccent.withAlpha(30)),
          ),
          child: const Text(
            'You can override decelerationRate in a custom ScrollPhysics '
            'subclass to control momentum behavior regardless of platform.',
            style: TextStyle(color: _kDim, fontSize: 12, height: 1.4),
          ),
        ),
        const SizedBox(height: 20),

        _hdr('Decision Table'),
        const SizedBox(height: 10),
        _buildDecisionTable(),
      ],
    );
  }

  static Widget _deviceCard(
    String title,
    IconData icon,
    Color color,
    String rate,
    String description,
    List<String> platforms,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title,
                          style: const TextStyle(
                              color: _kBright,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withAlpha(15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: color.withAlpha(40)),
                      ),
                      child: Text(rate.split('.').last,
                          style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(description,
                    style: const TextStyle(
                        color: _kDim, fontSize: 11, height: 1.4)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: platforms
                      .map((p) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withAlpha(10),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: color.withAlpha(20)),
                            ),
                            child: Text(p,
                                style: TextStyle(
                                    color: color.withAlpha(180),
                                    fontSize: 9)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionTable() {
    const rows = [
      ('Touch fling', 'normal', 'Long coast', _kNormal),
      ('Mouse wheel', 'fast', 'Short burst', _kFast),
      ('Trackpad swipe', 'fast', 'Controlled', _kFast),
      ('animateTo()', 'N/A', 'Uses curve', _kDim),
      ('jumpTo()', 'N/A', 'Instant', _kDim),
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
                    flex: 3,
                    child: Text('Input',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11))),
                Expanded(
                    flex: 2,
                    child: Text('Rate',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11))),
                Expanded(
                    flex: 3,
                    child: Text('Behavior',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11))),
              ],
            ),
          ),
          ...rows.map((r) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: _kPrimary.withAlpha(20))),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(r.$1,
                            style: const TextStyle(
                                color: _kBright, fontSize: 11))),
                    Expanded(
                        flex: 2,
                        child: Text(r.$2,
                            style: TextStyle(
                                color: r.$4,
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold))),
                    Expanded(
                        flex: 3,
                        child: Text(r.$3,
                            style: const TextStyle(
                                color: _kDim, fontSize: 11))),
                  ],
                ),
              )),
        ],
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
