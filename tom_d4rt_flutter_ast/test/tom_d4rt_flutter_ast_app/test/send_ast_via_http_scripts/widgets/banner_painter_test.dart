// ignore_for_file: avoid_print
// Deep demo: BannerPainter - CustomPainter for diagonal banners
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const BannerPainterDemo(),
  );
}

class BannerPainterDemo extends StatefulWidget {
  const BannerPainterDemo({super.key});

  @override
  State<BannerPainterDemo> createState() => _BannerPainterDemoState();
}

class _BannerPainterDemoState extends State<BannerPainterDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Banner
  // ═══════════════════════════════════════════════════════════════════════════
  String _basicMessage = 'DEBUG';

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Message Customization
  // ═══════════════════════════════════════════════════════════════════════════
  int _messageIndex = 0;
  final List<String> _messages = [
    'DEBUG', 'RELEASE', 'BETA', 'ALPHA', 'STAGING', 'DEV', 'TEST', 'PREVIEW',
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Text Direction
  // ═══════════════════════════════════════════════════════════════════════════
  TextDirection _textDirection = TextDirection.ltr;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Banner Location
  // ═══════════════════════════════════════════════════════════════════════════
  BannerLocation _location = BannerLocation.topEnd;
  int _locationIndex = 1;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Color Customization
  // ═══════════════════════════════════════════════════════════════════════════
  Color _bannerColor = Colors.red;
  int _colorIndex = 0;
  final List<MapEntry<String, Color>> _bannerColors = [
    const MapEntry('Red', Colors.red),
    const MapEntry('Blue', Colors.blue),
    const MapEntry('Green', Colors.green),
    const MapEntry('Orange', Colors.orange),
    const MapEntry('Purple', Colors.purple),
    const MapEntry('Teal', Colors.teal),
    const MapEntry('Black', Colors.black),
    const MapEntry('Brown', Colors.brown),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Text Style Control
  // ═══════════════════════════════════════════════════════════════════════════
  double _fontSize = 10;
  Color _textColor = Colors.white;
  int _textStyleIndex = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Layout Offset
  // ═══════════════════════════════════════════════════════════════════════════
  double _layoutDirection = 40;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  String _envLabel = 'DEV';
  final bool _showWatermark = false;
  String _versionText = 'v1.0.0';
  int _statusIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BannerPainter Deep Demo'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic Banner'),
            _buildBasicSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('2. Message Customization'),
            _buildMessageSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('3. Text Direction'),
            _buildTextDirectionSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('4. Banner Location'),
            _buildLocationSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('5. Color Customization'),
            _buildColorSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('6. Text Style Control'),
            _buildTextStyleSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('7. Layout Offset'),
            _buildLayoutOffsetSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('8. Practical Use Cases'),
            _buildPracticalUseCasesSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Banner
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicSection() {
    print('=== Section 1: Basic Banner ===');
    print('Message: $_basicMessage');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BannerPainter is a CustomPainter that draws a diagonal '
              'banner ribbon, commonly used for debug/release indicators. '
              'It paints a colored strip with text at a 45-degree angle.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Center(
              child: SizedBox(
                width: 200,
                height: 160,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: _basicMessage,
                    textDirection: TextDirection.ltr,
                    location: BannerLocation.topEnd,
                    color: Colors.red,
                    layoutDirection: TextDirection.ltr,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_android, size: 40, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('App Screen', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton('DEBUG', () {
                  setState(() { _basicMessage = 'DEBUG'; });
                  print('Basic message: DEBUG');
                }),
                _buildActionButton('RELEASE', () {
                  setState(() { _basicMessage = 'RELEASE'; });
                  print('Basic message: RELEASE');
                }),
                _buildActionButton('DEMO', () {
                  setState(() { _basicMessage = 'DEMO'; });
                  print('Basic message: DEMO');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Message Customization
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildMessageSection() {
    print('=== Section 2: Message Customization ===');
    print('Message index: $_messageIndex (${_messages[_messageIndex]})');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The message appears on the diagonal strip. Shorter '
              'messages look cleaner. Long messages may overflow.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Center(
              child: SizedBox(
                width: 200,
                height: 160,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: _messages[_messageIndex],
                    textDirection: TextDirection.ltr,
                    location: BannerLocation.topEnd,
                    color: Colors.blue,
                    layoutDirection: TextDirection.ltr,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Center(
                      child: Text(
                        '"${_messages[_messageIndex]}"',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_messages.length, (i) {
                return ChoiceChip(
                  label: Text(_messages[i]),
                  selected: _messageIndex == i,
                  onSelected: (s) {
                    if (s) {
                      setState(() { _messageIndex = i; });
                      print('Message: ${_messages[i]}');
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Text Direction
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTextDirectionSection() {
    print('=== Section 3: Text Direction ===');
    print('Text direction: $_textDirection');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'textDirection controls how the text is laid out on the '
              'banner strip. layoutDirection affects the physical position.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // LTR banner
                Column(
                  children: [
                    const Text('LTR', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 140,
                      height: 120,
                      child: CustomPaint(
                        painter: BannerPainter(
                          message: 'LTR',
                          textDirection: TextDirection.ltr,
                          location: BannerLocation.topEnd,
                          color: Colors.green,
                          layoutDirection: TextDirection.ltr,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: const Center(child: Icon(Icons.format_textdirection_l_to_r)),
                        ),
                      ),
                    ),
                  ],
                ),

                // RTL banner
                Column(
                  children: [
                    const Text('RTL', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 140,
                      height: 120,
                      child: CustomPaint(
                        painter: BannerPainter(
                          message: 'RTL',
                          textDirection: TextDirection.rtl,
                          location: BannerLocation.topEnd,
                          color: Colors.orange,
                          layoutDirection: TextDirection.rtl,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange.shade200),
                          ),
                          child: const Center(child: Icon(Icons.format_textdirection_r_to_l)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Interactive
            Center(
              child: SizedBox(
                width: 180,
                height: 140,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: 'TEST',
                    textDirection: _textDirection,
                    location: BannerLocation.topEnd,
                    color: _textDirection == TextDirection.ltr ? Colors.teal : Colors.deepOrange,
                    layoutDirection: _textDirection,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        _textDirection == TextDirection.ltr ? 'Left to Right' : 'Right to Left',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('LTR'),
                  selected: _textDirection == TextDirection.ltr,
                  onSelected: (s) {
                    if (s) setState(() { _textDirection = TextDirection.ltr; });
                    print('Text direction: LTR');
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('RTL'),
                  selected: _textDirection == TextDirection.rtl,
                  onSelected: (s) {
                    if (s) setState(() { _textDirection = TextDirection.rtl; });
                    print('Text direction: RTL');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Banner Location
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLocationSection() {
    print('=== Section 4: Banner Location ===');
    print('Location: $_location (index: $_locationIndex)');

    final locations = [
      const MapEntry('topStart', BannerLocation.topStart),
      const MapEntry('topEnd', BannerLocation.topEnd),
      const MapEntry('bottomStart', BannerLocation.bottomStart),
      const MapEntry('bottomEnd', BannerLocation.bottomEnd),
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BannerLocation places the banner in one of four corners: '
              'topStart, topEnd, bottomStart, bottomEnd.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // All four corners shown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: locations.map((loc) {
                final isSelected = _location == loc.value;
                return Column(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CustomPaint(
                        painter: BannerPainter(
                          message: 'X',
                          textDirection: TextDirection.ltr,
                          location: loc.value,
                          color: isSelected ? Colors.red : Colors.grey,
                          layoutDirection: TextDirection.ltr,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.red.shade50 : Colors.grey.shade100,
                            border: Border.all(
                              color: isSelected ? Colors.red : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(loc.key, style: TextStyle(
                      fontSize: 9,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    )),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Interactive large view
            Center(
              child: SizedBox(
                width: 220,
                height: 160,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: 'BANNER',
                    textDirection: TextDirection.ltr,
                    location: _location,
                    color: Colors.red,
                    layoutDirection: TextDirection.ltr,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        locations[_locationIndex].key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(locations.length, (i) {
                return ChoiceChip(
                  label: Text(locations[i].key),
                  selected: _locationIndex == i,
                  onSelected: (s) {
                    if (s) {
                      setState(() {
                        _locationIndex = i;
                        _location = locations[i].value;
                      });
                      print('Location: ${locations[i].key}');
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Color Customization
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildColorSection() {
    print('=== Section 5: Color Customization ===');
    print('Banner color: $_bannerColor (index: $_colorIndex)');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The color property sets the background color of the '
              'banner ribbon. Default is a dark red.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Color gallery
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(_bannerColors.length, (i) {
                final entry = _bannerColors[i];
                final isSelected = _colorIndex == i;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _colorIndex = i;
                      _bannerColor = entry.value;
                    });
                    print('Banner color: ${entry.key}');
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: 70,
                        height: 60,
                        child: CustomPaint(
                          painter: BannerPainter(
                            message: entry.key.substring(0, entry.key.length > 4 ? 4 : entry.key.length).toUpperCase(),
                            textDirection: TextDirection.ltr,
                            location: BannerLocation.topEnd,
                            color: entry.value,
                            layoutDirection: TextDirection.ltr,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: isSelected ? entry.value : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(entry.key, style: TextStyle(
                        fontSize: 10,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      )),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            Center(
              child: SizedBox(
                width: 200,
                height: 140,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: 'COLOR',
                    textDirection: TextDirection.ltr,
                    location: BannerLocation.topEnd,
                    color: _bannerColor,
                    layoutDirection: TextDirection.ltr,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _bannerColor, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        _bannerColors[_colorIndex].key,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _bannerColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Text Style Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTextStyleSection() {
    print('=== Section 6: Text Style Control ===');
    print('Font size: $_fontSize, Text color: $_textColor');
    print('Style preset: $_textStyleIndex');

    final textStyles = [
      {'name': 'Default', 'size': 10.0, 'color': Colors.white},
      {'name': 'Large', 'size': 14.0, 'color': Colors.white},
      {'name': 'Small', 'size': 8.0, 'color': Colors.white},
      {'name': 'Yellow', 'size': 10.0, 'color': Colors.yellow},
      {'name': 'Cyan', 'size': 12.0, 'color': Colors.cyan},
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BannerPainter uses a fixed text style internally, but the '
              'visual size and appearance depend on the banner dimensions. '
              'The text is automatically centered on the diagonal strip.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Comparison gallery
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStyledBanner('DEBUG', Colors.red, 'Standard'),
                _buildStyledBanner('BETA', Colors.blue, 'Info'),
                _buildStyledBanner('!', Colors.amber.shade800, 'Warning'),
              ],
            ),
            const SizedBox(height: 24),

            // Interactive with presets
            Center(
              child: SizedBox(
                width: 200,
                height: 160,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: 'STYLE',
                    textDirection: TextDirection.ltr,
                    location: BannerLocation.topEnd,
                    color: _textColor == Colors.white ? Colors.red : _textColor,
                    layoutDirection: TextDirection.ltr,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        textStyles[_textStyleIndex]['name'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(textStyles.length, (i) {
                final style = textStyles[i];
                return ChoiceChip(
                  label: Text(style['name'] as String),
                  selected: _textStyleIndex == i,
                  onSelected: (s) {
                    if (s) {
                      setState(() {
                        _textStyleIndex = i;
                        _fontSize = style['size'] as double;
                        _textColor = style['color'] as Color;
                      });
                      print('Text style: ${style['name']}');
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledBanner(String message, Color color, String label) {
    return Column(
      children: [
        SizedBox(
          width: 90,
          height: 80,
          child: CustomPaint(
            painter: BannerPainter(
              message: message,
              textDirection: TextDirection.ltr,
              location: BannerLocation.topEnd,
              color: color,
              layoutDirection: TextDirection.ltr,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Layout Offset
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLayoutOffsetSection() {
    print('=== Section 7: Layout Offset ===');
    print('Layout direction value: $_layoutDirection');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The layoutDirection parameter (TextDirection) determines '
              'how the banner position resolves for start/end locations. '
              'The banner size is fixed by Flutter\'s internal calculation.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Side by side comparison: different layout directions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('layoutDir: LTR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 130,
                      height: 110,
                      child: CustomPaint(
                        painter: BannerPainter(
                          message: 'LTR',
                          textDirection: TextDirection.ltr,
                          location: BannerLocation.topStart,
                          color: Colors.green,
                          layoutDirection: TextDirection.ltr,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: const Center(child: Text('topStart')),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('layoutDir: RTL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 130,
                      height: 110,
                      child: CustomPaint(
                        painter: BannerPainter(
                          message: 'RTL',
                          textDirection: TextDirection.rtl,
                          location: BannerLocation.topStart,
                          color: Colors.deepOrange,
                          layoutDirection: TextDirection.rtl,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.deepOrange.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.deepOrange.shade200),
                          ),
                          child: const Center(child: Text('topStart')),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // All four corners with varying offset
            const Text('Banner offset visual (px from edge):',
              style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Center(
              child: SizedBox(
                width: 200,
                height: 160,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: 'OFFSET',
                    textDirection: TextDirection.ltr,
                    location: BannerLocation.topEnd,
                    color: Colors.purple,
                    layoutDirection: TextDirection.ltr,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.purple.shade200),
                    ),
                    child: Center(
                      child: Text(
                        'Offset: ${_layoutDirection.toInt()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Slider(
              value: _layoutDirection,
              min: 0,
              max: 100,
              divisions: 20,
              label: _layoutDirection.toStringAsFixed(0),
              onChanged: (val) {
                setState(() { _layoutDirection = val; });
                print('Layout offset: $val');
              },
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== Section 8: Practical Use Cases ===');
    print('Env: $_envLabel, Watermark: $_showWatermark');
    print('Version: $_versionText, Status: $_statusIndex');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common real-world uses of BannerPainter.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Use Case 1: Environment indicator
            const Text('1. Environment Indicator', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEnvironmentIndicator(),
            const SizedBox(height: 24),

            // Use Case 2: Multiple banners on cards
            const Text('2. Product Status Badges', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildProductStatusBadges(),
            const SizedBox(height: 24),

            // Use Case 3: Version ribbon
            const Text('3. Version Ribbon', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildVersionRibbon(),
            const SizedBox(height: 24),

            // Use Case 4: Navigation with banner status
            const Text('4. Screen Status Overlays', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildScreenStatusOverlays(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentIndicator() {
    final envs = [
      {'label': 'DEV', 'color': Colors.green},
      {'label': 'STAGING', 'color': Colors.orange},
      {'label': 'PROD', 'color': Colors.red},
    ];

    return Column(
      children: [
        SizedBox(
          width: 220,
          height: 120,
          child: CustomPaint(
            painter: BannerPainter(
              message: _envLabel,
              textDirection: TextDirection.ltr,
              location: BannerLocation.topStart,
              color: envs.firstWhere((e) => e['label'] == _envLabel)['color'] as Color,
              layoutDirection: TextDirection.ltr,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud, size: 32, color: Colors.grey),
                    Text('My Application', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: envs.map((env) {
            return ChoiceChip(
              label: Text(env['label'] as String),
              selected: _envLabel == env['label'],
              onSelected: (s) {
                if (s) {
                  setState(() { _envLabel = env['label'] as String; });
                  print('Environment: ${env['label']}');
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProductStatusBadges() {
    final statuses = [
      {'label': 'NEW', 'color': Colors.green},
      {'label': 'SALE', 'color': Colors.red},
      {'label': 'HOT', 'color': Colors.orange},
      {'label': 'SOLD', 'color': Colors.grey},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: statuses.map((status) {
        return SizedBox(
          width: 72,
          height: 72,
          child: CustomPaint(
            painter: BannerPainter(
              message: status['label'] as String,
              textDirection: TextDirection.ltr,
              location: BannerLocation.topEnd,
              color: status['color'] as Color,
              layoutDirection: TextDirection.ltr,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(
                child: Icon(Icons.shopping_bag, color: status['color'] as Color),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVersionRibbon() {
    final versions = ['v1.0.0', 'v2.0.0-beta', 'v3.0.0-rc'];

    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 120,
          child: CustomPaint(
            painter: BannerPainter(
              message: _versionText,
              textDirection: TextDirection.ltr,
              location: BannerLocation.bottomEnd,
              color: Colors.deepPurple,
              layoutDirection: TextDirection.ltr,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.deepPurple),
                    Text(_versionText,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: versions.map((v) {
            return ChoiceChip(
              label: Text(v),
              selected: _versionText == v,
              onSelected: (s) {
                if (s) {
                  setState(() { _versionText = v; });
                  print('Version: $v');
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildScreenStatusOverlays() {
    final statusItems = [
      {'name': 'Normal', 'banner': '', 'color': Colors.grey},
      {'name': 'Loading', 'banner': 'LOADING', 'color': Colors.blue},
      {'name': 'Error', 'banner': 'ERROR', 'color': Colors.red},
      {'name': 'Offline', 'banner': 'OFFLINE', 'color': Colors.orange},
    ];

    final status = statusItems[_statusIndex];

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 100,
          child: CustomPaint(
            painter: _statusIndex > 0
                ? BannerPainter(
                    message: status['banner'] as String,
                    textDirection: TextDirection.ltr,
                    location: BannerLocation.topEnd,
                    color: status['color'] as Color,
                    layoutDirection: TextDirection.ltr,
                  )
                : null,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _statusIndex > 0
                      ? (status['color'] as Color)
                      : Colors.grey.shade300,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _statusIndex == 0 ? Icons.check_circle
                          : _statusIndex == 1 ? Icons.hourglass_empty
                          : _statusIndex == 2 ? Icons.error
                          : Icons.cloud_off,
                      color: status['color'] as Color,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      status['name'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: status['color'] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(statusItems.length, (i) {
            return ChoiceChip(
              label: Text(statusItems[i]['name'] as String),
              selected: _statusIndex == i,
              onSelected: (s) {
                if (s) {
                  setState(() { _statusIndex = i; });
                  print('Status: ${statusItems[i]['name']}');
                }
              },
            );
          }),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Helper Methods
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSectionHeader(String title) {
    print('');
    print('════════════════════════════════════════════════════════════');
    print(title);
    print('════════════════════════════════════════════════════════════');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          Divider(thickness: 2, color: Colors.red.shade700),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
