import 'package:flutter/material.dart';

const Color _bg = Color(0xFF10151E);
const Color _panel = Color(0xFF1A2638);
const Color _panel2 = Color(0xFF27384F);
const Color _text = Color(0xFFDBE9FF);
const Color _cyan = Color(0xFF78E5FF);
const Color _mint = Color(0xFF8DE8C5);
const Color _gold = Color(0xFFFFD37A);
const Color _rose = Color(0xFFFF9CB3);
const Color _violet = Color(0xFFC7B4FF);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _cyan,
        secondary: _gold,
        surface: _panel,
      ),
    ),
    home: const _TextMagnifierConfigurationDemo(),
  );
}

class _TextMagnifierConfigurationDemo extends StatefulWidget {
  const _TextMagnifierConfigurationDemo();

  @override
  State<_TextMagnifierConfigurationDemo> createState() =>
      _TextMagnifierConfigurationDemoState();
}

class _TextMagnifierConfigurationDemoState extends State<_TextMagnifierConfigurationDemo>
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
      appBar: AppBar(
        backgroundColor: _panel,
        title: const Text(
          'TextMagnifierConfiguration Deep Demo',
          style: TextStyle(color: _gold, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _gold,
          labelColor: _gold,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Profiles'),
            Tab(text: 'Lens Lab'),
            Tab(text: 'Platform Strategy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ProfilesTab(),
          _LensLabTab(),
          _PlatformStrategyTab(),
        ],
      ),
    );
  }
}

class _ProfilesTab extends StatefulWidget {
  const _ProfilesTab();

  @override
  State<_ProfilesTab> createState() => _ProfilesTabState();
}

class _ProfilesTabState extends State<_ProfilesTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _MagnifierProfile profile = _profiles[_selected];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Configuration Intent'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('TextMagnifierConfiguration controls whether and how a text magnifier appears during selection gestures.'),
                _Bullet('It can disable magnifier behavior, or provide a custom magnifier builder/shape policy.'),
                _Bullet('Useful for tailoring text-selection ergonomics across input methods and platforms.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Profile Selector'),
          const SizedBox(height: 8),
          _box(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_profiles.length, (int index) {
                final bool active = index == _selected;
                final _MagnifierProfile item = _profiles[index];
                return GestureDetector(
                  onTap: () => setState(() => _selected = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: active ? item.color.withValues(alpha: 0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: active ? item.color : _panel2),
                    ),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: active ? item.color : _text,
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),
          _title('Profile Details'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: profile.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: profile.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile.summary, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  ...profile.notes.map(
                    (String n) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.chevron_right_rounded, size: 16, color: profile.color),
                          const SizedBox(width: 4),
                          Expanded(child: Text(n, style: const TextStyle(color: _text, fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Pseudo Configuration Snippet'),
          const SizedBox(height: 8),
          _box(child: _code(profile.code)),
        ],
      ),
    );
  }
}

class _LensLabTab extends StatefulWidget {
  const _LensLabTab();

  @override
  State<_LensLabTab> createState() => _LensLabTabState();
}

class _LensLabTabState extends State<_LensLabTab>
    with AutomaticKeepAliveClientMixin {
  int _profileIndex = 1;
  double _focusX = 0.5;
  double _focusY = 0.4;
  double _zoom = 1.8;
  bool _showGrid = true;
  bool _enableMagnifier = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _MagnifierProfile profile = _profiles[_profileIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Lens Simulator'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Profile', style: TextStyle(color: _text, fontSize: 11)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<int>(
                        value: _profileIndex,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        dropdownColor: _panel2,
                        items: List.generate(_profiles.length, (int index) {
                          return DropdownMenuItem<int>(
                            value: index,
                            child: Text(_profiles[index].name, style: const TextStyle(color: _text, fontSize: 11)),
                          );
                        }),
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() => _profileIndex = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _enableMagnifier,
                  activeThumbColor: _gold,
                  title: const Text('Enable magnifier', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool v) => setState(() => _enableMagnifier = v),
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _showGrid,
                  activeThumbColor: _violet,
                  title: const Text('Show source grid', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool v) => setState(() => _showGrid = v),
                ),
                const Text('Focus X', style: TextStyle(color: _text, fontSize: 11)),
                Slider(
                  min: 0,
                  max: 1,
                  value: _focusX,
                  activeColor: _cyan,
                  onChanged: (double v) => setState(() => _focusX = v),
                ),
                const Text('Focus Y', style: TextStyle(color: _text, fontSize: 11)),
                Slider(
                  min: 0,
                  max: 1,
                  value: _focusY,
                  activeColor: _mint,
                  onChanged: (double v) => setState(() => _focusY = v),
                ),
                const Text('Zoom', style: TextStyle(color: _text, fontSize: 11)),
                Slider(
                  min: 1,
                  max: 3,
                  value: _zoom,
                  activeColor: _rose,
                  onChanged: (double v) => setState(() => _zoom = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Source + Lens Preview'),
          const SizedBox(height: 8),
          _box(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double width = constraints.maxWidth;
                final double height = 260;
                final double px = _focusX * width;
                final double py = _focusY * height;

                return SizedBox(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _panel2,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _cyan.withValues(alpha: 0.85)),
                          ),
                          child: _showGrid
                              ? CustomPaint(
                                  painter: _GridPainter(),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                      Positioned(
                        left: px - 8,
                        top: py - 8,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _gold,
                            shape: BoxShape.circle,
                            border: Border.all(color: _bg, width: 2),
                          ),
                        ),
                      ),
                      if (_enableMagnifier)
                        Positioned(
                          left: (px - 56).clamp(0.0, width - 112),
                          top: (py - 124).clamp(0.0, height - 112),
                          child: _lens(profile: profile, zoom: _zoom),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          _title('Live Metrics'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                _metric('magnifier enabled', _enableMagnifier ? 'yes' : 'no', _gold),
                _metric('focus', '(${_focusX.toStringAsFixed(2)}, ${_focusY.toStringAsFixed(2)})', _cyan),
                _metric('zoom', _zoom.toStringAsFixed(2), _rose),
                _metric('profile', profile.name, profile.color),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lens({required _MagnifierProfile profile, required double zoom}) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        color: profile.color.withValues(alpha: 0.22),
        shape: profile.round ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: profile.round ? null : BorderRadius.circular(16),
        border: Border.all(color: profile.color.withValues(alpha: 0.95), width: 2),
      ),
      child: Center(
        child: Text(
          'x${zoom.toStringAsFixed(1)}',
          style: TextStyle(color: profile.color, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _metric(String label, String value, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700))),
          Text(value, style: TextStyle(color: color, fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

class _PlatformStrategyTab extends StatefulWidget {
  const _PlatformStrategyTab();

  @override
  State<_PlatformStrategyTab> createState() => _PlatformStrategyTabState();
}

class _PlatformStrategyTabState extends State<_PlatformStrategyTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedScenario = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _Scenario scenario = _scenarios[_selectedScenario];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Platform and Product Strategy'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('Magnifier behavior should align with platform conventions and input ergonomics.'),
                _Bullet('Disable magnifier in constrained contexts where it harms readability or overlays critical UI.'),
                _Bullet('Custom builder style can preserve brand while retaining usability.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Scenario Picker'),
          const SizedBox(height: 8),
          _box(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_scenarios.length, (int i) {
                final bool active = i == _selectedScenario;
                final _Scenario s = _scenarios[i];
                return GestureDetector(
                  onTap: () => setState(() => _selectedScenario = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: active ? s.color.withValues(alpha: 0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: active ? s.color : _panel2),
                    ),
                    child: Text(
                      s.name,
                      style: TextStyle(
                        color: active ? s.color : _text,
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),
          _title('Recommendation'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: scenario.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: scenario.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recommended: ${scenario.profile}', style: TextStyle(color: scenario.color, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(scenario.reason, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  ...scenario.tips.map(
                    (String tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_rounded, size: 14, color: scenario.color),
                          const SizedBox(width: 5),
                          Expanded(child: Text(tip, style: const TextStyle(color: _text, fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Comparison Matrix'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              children: [
                _Row('Disabled', 'No lens shown', 'Desktop-heavy text tools with precise cursoring', _rose),
                _Row('Platform Default', 'Native-like lens', 'General mobile text selection', _cyan),
                _Row('Custom Rounded', 'Brand round lens', 'Reading-focused branded experiences', _mint),
                _Row('Custom Rect', 'Rectangular preview lens', 'Code/document precise copy contexts', _gold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = _violet.withValues(alpha: 0.25)
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y <= size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MagnifierProfile {
  const _MagnifierProfile({
    required this.name,
    required this.summary,
    required this.notes,
    required this.round,
    required this.color,
    required this.code,
  });

  final String name;
  final String summary;
  final List<String> notes;
  final bool round;
  final Color color;
  final String code;
}

class _Scenario {
  const _Scenario({
    required this.name,
    required this.profile,
    required this.reason,
    required this.tips,
    required this.color,
  });

  final String name;
  final String profile;
  final String reason;
  final List<String> tips;
  final Color color;
}

const List<_MagnifierProfile> _profiles = [
  _MagnifierProfile(
    name: 'Disabled',
    summary: 'Turns off magnifier visuals entirely for text selection interactions.',
    notes: [
      'Useful when overlays would obstruct dense UIs.',
      'Common in desktop-like precise cursor contexts.',
    ],
    round: true,
    color: _rose,
    code: 'const TextMagnifierConfiguration.disabled()',
  ),
  _MagnifierProfile(
    name: 'Platform Default',
    summary: 'Leverages platform-preferred magnifier style and motion behavior.',
    notes: [
      'Best baseline for native feel on touch devices.',
      'Good default when no brand-specific requirement exists.',
    ],
    round: true,
    color: _cyan,
    code: 'const TextMagnifierConfiguration()',
  ),
  _MagnifierProfile(
    name: 'Custom Rounded',
    summary: 'Custom rounded lens preserving soft visual language.',
    notes: [
      'Balances brand style with familiar magnifier semantics.',
      'Great for editorial and reading applications.',
    ],
    round: true,
    color: _mint,
    code: 'TextMagnifierConfiguration(\n'
        '  magnifierBuilder: (context, controller) => MyRoundedMagnifier(...),\n'
        ')',
  ),
  _MagnifierProfile(
    name: 'Custom Rect',
    summary: 'Rectangular lens for precise linear text inspection.',
    notes: [
      'Works well in code/document tools with monospaced text.',
      'Can align better to line/column workflows.',
    ],
    round: false,
    color: _gold,
    code: 'TextMagnifierConfiguration(\n'
        '  magnifierBuilder: (context, controller) => MyRectMagnifier(...),\n'
        ')',
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario(
    name: 'Mobile article reader',
    profile: 'Platform Default',
    reason: 'Touch-heavy long-form reading benefits from familiar native magnifier behavior.',
    tips: [
      'Keep lens unobtrusive over body text.',
      'Ensure high contrast in bright conditions.',
    ],
    color: _cyan,
  ),
  _Scenario(
    name: 'Design-system branded notes app',
    profile: 'Custom Rounded',
    reason: 'Branded rounded magnifier can align with product aesthetics while staying ergonomic.',
    tips: [
      'Validate readability against varied backgrounds.',
      'Keep gesture latency low for smooth drag updates.',
    ],
    color: _mint,
  ),
  _Scenario(
    name: 'Dense code editor panel',
    profile: 'Custom Rect',
    reason: 'Rectangular lens can better preview monospaced line fragments and alignment.',
    tips: [
      'Prefer crisp borders and restrained blur.',
      'Avoid hiding adjacent syntax context.',
    ],
    color: _gold,
  ),
  _Scenario(
    name: 'Desktop precision workflow',
    profile: 'Disabled',
    reason: 'Pointer precision may make magnifier unnecessary and visually distracting.',
    tips: [
      'Offer configurable toggle in accessibility settings.',
      'Retain clear cursor and selection affordances.',
    ],
    color: _rose,
  ),
];

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(color: _gold, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _text, fontSize: 11))),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.name, this.effect, this.useCase, this.color);

  final String name;
  final String effect;
  final String useCase;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(name, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          ),
          Expanded(child: Text(effect, style: const TextStyle(color: _text, fontSize: 10))),
          const SizedBox(width: 8),
          Expanded(child: Text(useCase, style: const TextStyle(color: _text, fontSize: 10))),
        ],
      ),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(color: _gold, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

Widget _box({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _panel2),
    ),
    child: child,
  );
}

Widget _code(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      code,
      style: const TextStyle(color: _cyan, fontSize: 10, fontFamily: 'monospace'),
    ),
  );
}
