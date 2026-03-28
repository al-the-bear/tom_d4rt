// ignore_for_file: avoid_print
// Deep demo: AnimatedPositionedDirectional - RTL-aware implicit positioning
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedPositionedDirectionalDemo(),
  );
}

class AnimatedPositionedDirectionalDemo extends StatefulWidget {
  const AnimatedPositionedDirectionalDemo({super.key});

  @override
  State<AnimatedPositionedDirectionalDemo> createState() =>
      _AnimatedPositionedDirectionalDemoState();
}

class _AnimatedPositionedDirectionalDemoState
    extends State<AnimatedPositionedDirectionalDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Positioned Placement
  // ═══════════════════════════════════════════════════════════════════════════
  double _basicStart = 10;
  double _basicTop = 10;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Start/End Directional Movement
  // ═══════════════════════════════════════════════════════════════════════════
  double _startValue = 10;
  double _endValue = 10;
  bool _isRtlSec2 = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Top/Bottom Control
  // ═══════════════════════════════════════════════════════════════════════════
  double _topValue = 10;
  double _bottomValue = 10;
  bool _useTop = true;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Width/Height Sizing
  // ═══════════════════════════════════════════════════════════════════════════
  double _sizeWidth = 80;
  double _sizeHeight = 80;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: RTL vs LTR Comparison
  // ═══════════════════════════════════════════════════════════════════════════
  double _compStart = 20;
  double _compTop = 20;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Duration and Curves
  // ═══════════════════════════════════════════════════════════════════════════
  double _curveStart = 10;
  double _curveTop = 10;
  Duration _curveDuration = const Duration(milliseconds: 400);
  Curve _selectedCurve = Curves.easeInOut;
  int _curveIndex = 3;
  final List<MapEntry<String, Curve>> _curves = [
    const MapEntry('linear', Curves.linear),
    const MapEntry('easeIn', Curves.easeIn),
    const MapEntry('easeOut', Curves.easeOut),
    const MapEntry('easeInOut', Curves.easeInOut),
    const MapEntry('bounceOut', Curves.bounceOut),
    const MapEntry('elasticOut', Curves.elasticOut),
    const MapEntry('decelerate', Curves.decelerate),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Combined Property Animation
  // ═══════════════════════════════════════════════════════════════════════════
  int _presetIndex = 0;
  double _combStart = 10;
  double _combTop = 10;
  double _combWidth = 60;
  double _combHeight = 60;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _panelOpen = false;
  bool _showBadge = false;
  int _badgeCount = 0;
  bool _labelFloated = false;
  int _drawerState = 0; // 0=closed, 1=peek, 2=open

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedPositionedDirectional Deep Demo'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic Positioned Placement'),
            _buildBasicSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('2. Start/End Directional Movement'),
            _buildStartEndSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('3. Top/Bottom Control'),
            _buildTopBottomSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('4. Width/Height Sizing'),
            _buildSizingSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('5. RTL vs LTR Comparison'),
            _buildRtlLtrSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('6. Duration and Curves'),
            _buildDurationCurvesSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('7. Combined Property Animation'),
            _buildCombinedSection(),
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
  // SECTION 1: Basic Positioned Placement
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicSection() {
    print('=== Section 1: Basic Positioned Placement ===');
    print('Start: $_basicStart, Top: $_basicTop');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedPositionedDirectional works inside a Stack. It uses '
              'start/end instead of left/right, making it RTL-aware. It '
              'animates position changes with implicit animation.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Grid lines for reference
                  ..._buildGridLines(200),

                  AnimatedPositionedDirectional(
                    start: _basicStart,
                    top: _basicTop,
                    width: 60,
                    height: 60,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
                      ),
                      child: const Center(
                        child: Icon(Icons.navigation, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton('Top-Start', () {
                  setState(() { _basicStart = 10; _basicTop = 10; });
                  print('Position: top-start (10, 10)');
                }),
                _buildActionButton('Top-End', () {
                  setState(() { _basicStart = 250; _basicTop = 10; });
                  print('Position: top-end (250, 10)');
                }),
                _buildActionButton('Center', () {
                  setState(() { _basicStart = 130; _basicTop = 70; });
                  print('Position: center (130, 70)');
                }),
                _buildActionButton('Bottom-Start', () {
                  setState(() { _basicStart = 10; _basicTop = 130; });
                  print('Position: bottom-start (10, 130)');
                }),
                _buildActionButton('Bottom-End', () {
                  setState(() { _basicStart = 250; _basicTop = 130; });
                  print('Position: bottom-end (250, 130)');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Start/End Directional Movement
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStartEndSection() {
    print('=== Section 2: Start/End Directional Movement ===');
    print('Start: $_startValue, End: $_endValue, RTL: $_isRtlSec2');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'start positions from the reading start edge (left in LTR, '
              'right in RTL). end positions from the opposite edge. '
              'Both can be set to stretch the child.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Text('Direction: '),
                ChoiceChip(
                  label: const Text('LTR'),
                  selected: !_isRtlSec2,
                  onSelected: (s) {
                    if (s) setState(() { _isRtlSec2 = false; });
                    print('Direction: LTR');
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('RTL'),
                  selected: _isRtlSec2,
                  onSelected: (s) {
                    if (s) setState(() { _isRtlSec2 = true; });
                    print('Direction: RTL');
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            Directionality(
              textDirection: _isRtlSec2 ? TextDirection.rtl : TextDirection.ltr,
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    // Labels for start/end edges
                    Positioned(
                      left: 4,
                      top: 4,
                      child: Text(
                        _isRtlSec2 ? 'END' : 'START',
                        style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Text(
                        _isRtlSec2 ? 'START' : 'END',
                        style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                      ),
                    ),

                    AnimatedPositionedDirectional(
                      start: _startValue,
                      end: _endValue,
                      top: 30,
                      bottom: 10,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isRtlSec2 ? Colors.orange : Colors.teal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isRtlSec2 ? Icons.format_textdirection_r_to_l
                                    : Icons.format_textdirection_l_to_r,
                                color: Colors.white,
                              ),
                              Text(
                                's:${_startValue.toInt()} e:${_endValue.toInt()}',
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text('Start: '),
                Expanded(
                  child: Slider(
                    value: _startValue,
                    min: 0,
                    max: 200,
                    onChanged: (val) {
                      setState(() { _startValue = val; });
                      print('Start: $val');
                    },
                  ),
                ),
                Text('${_startValue.toInt()}'),
              ],
            ),
            Row(
              children: [
                const Text('End:   '),
                Expanded(
                  child: Slider(
                    value: _endValue,
                    min: 0,
                    max: 200,
                    onChanged: (val) {
                      setState(() { _endValue = val; });
                      print('End: $val');
                    },
                  ),
                ),
                Text('${_endValue.toInt()}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Top/Bottom Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTopBottomSection() {
    print('=== Section 3: Top/Bottom Control ===');
    print('Top: $_topValue, Bottom: $_bottomValue, useTop: $_useTop');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'top and bottom control vertical placement. Setting both '
              'stretches the child vertically within the Stack.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Text('Mode: '),
                ChoiceChip(
                  label: const Text('Top only'),
                  selected: _useTop,
                  onSelected: (s) {
                    if (s) setState(() { _useTop = true; });
                    print('Mode: top only');
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Top + Bottom'),
                  selected: !_useTop,
                  onSelected: (s) {
                    if (s) setState(() { _useTop = false; });
                    print('Mode: top + bottom');
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  if (_useTop)
                    AnimatedPositionedDirectional(
                      start: 40,
                      top: _topValue,
                      width: 80,
                      height: 60,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'top: ${_topValue.toInt()}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    )
                  else
                    AnimatedPositionedDirectional(
                      start: 40,
                      top: _topValue,
                      bottom: _bottomValue,
                      width: 80,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                't: ${_topValue.toInt()}',
                                style: const TextStyle(color: Colors.white, fontSize: 11),
                              ),
                              Text(
                                'b: ${_bottomValue.toInt()}',
                                style: const TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text('Top: '),
                Expanded(
                  child: Slider(
                    value: _topValue,
                    min: 0,
                    max: 150,
                    onChanged: (val) {
                      setState(() { _topValue = val; });
                      print('Top: $val');
                    },
                  ),
                ),
              ],
            ),
            if (!_useTop)
              Row(
                children: [
                  const Text('Bottom: '),
                  Expanded(
                    child: Slider(
                      value: _bottomValue,
                      min: 0,
                      max: 150,
                      onChanged: (val) {
                        setState(() { _bottomValue = val; });
                        print('Bottom: $val');
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Width/Height Sizing
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSizingSection() {
    print('=== Section 4: Width/Height Sizing ===');
    print('Width: $_sizeWidth, Height: $_sizeHeight');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'width and height explicitly set the child dimensions. '
              'These animate smoothly alongside position changes.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  AnimatedPositionedDirectional(
                    start: 20,
                    top: 20,
                    width: _sizeWidth,
                    height: _sizeHeight,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${_sizeWidth.toInt()} x ${_sizeHeight.toInt()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text('Width: '),
                Expanded(
                  child: Slider(
                    value: _sizeWidth,
                    min: 40,
                    max: 280,
                    onChanged: (val) {
                      setState(() { _sizeWidth = val; });
                      print('Width: $val');
                    },
                  ),
                ),
                Text('${_sizeWidth.toInt()}px'),
              ],
            ),
            Row(
              children: [
                const Text('Height: '),
                Expanded(
                  child: Slider(
                    value: _sizeHeight,
                    min: 40,
                    max: 180,
                    onChanged: (val) {
                      setState(() { _sizeHeight = val; });
                      print('Height: $val');
                    },
                  ),
                ),
                Text('${_sizeHeight.toInt()}px'),
              ],
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton('Small', () {
                  setState(() { _sizeWidth = 60; _sizeHeight = 60; });
                  print('Size: 60x60 (small)');
                }),
                _buildActionButton('Wide', () {
                  setState(() { _sizeWidth = 240; _sizeHeight = 60; });
                  print('Size: 240x60 (wide)');
                }),
                _buildActionButton('Tall', () {
                  setState(() { _sizeWidth = 60; _sizeHeight = 160; });
                  print('Size: 60x160 (tall)');
                }),
                _buildActionButton('Large', () {
                  setState(() { _sizeWidth = 200; _sizeHeight = 160; });
                  print('Size: 200x160 (large)');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: RTL vs LTR Comparison
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRtlLtrSection() {
    print('=== Section 5: RTL vs LTR Comparison ===');
    print('Comparison start: $_compStart, top: $_compTop');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Same start/end values appear mirrored in RTL vs LTR. '
              'Both panels animate simultaneously for comparison.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                // LTR panel
                Expanded(
                  child: Column(
                    children: [
                      const Text('LTR', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              AnimatedPositionedDirectional(
                                start: _compStart,
                                top: _compTop,
                                width: 50,
                                height: 50,
                                duration: const Duration(milliseconds: 400),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // RTL panel
                Expanded(
                  child: Column(
                    children: [
                      const Text('RTL', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              AnimatedPositionedDirectional(
                                start: _compStart,
                                top: _compTop,
                                width: 50,
                                height: 50,
                                duration: const Duration(milliseconds: 400),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                                  ),
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
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text('Start: '),
                Expanded(
                  child: Slider(
                    value: _compStart,
                    min: 0,
                    max: 100,
                    onChanged: (val) {
                      setState(() { _compStart = val; });
                      print('Comparison start: $val');
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Top: '),
                Expanded(
                  child: Slider(
                    value: _compTop,
                    min: 0,
                    max: 90,
                    onChanged: (val) {
                      setState(() { _compTop = val; });
                      print('Comparison top: $val');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Duration and Curves
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationCurvesSection() {
    print('=== Section 6: Duration and Curves ===');
    print('Duration: ${_curveDuration.inMilliseconds}ms');
    print('Curve: ${_curves[_curveIndex].key}');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Duration and curve control the speed and easing of position changes.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  AnimatedPositionedDirectional(
                    start: _curveStart,
                    top: _curveTop,
                    width: 60,
                    height: 60,
                    duration: _curveDuration,
                    curve: _selectedCurve,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          '${_curveDuration.inMilliseconds}ms',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  if (_curveStart < 100) {
                    _curveStart = 240;
                    _curveTop = 90;
                  } else {
                    _curveStart = 10;
                    _curveTop = 10;
                  }
                });
                print('Curve toggle: start=$_curveStart, top=$_curveTop');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Animate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            const Text('Duration:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: [100, 300, 600, 1000, 2000].map((ms) {
                return ChoiceChip(
                  label: Text('${ms}ms'),
                  selected: _curveDuration.inMilliseconds == ms,
                  onSelected: (s) {
                    if (s) {
                      setState(() { _curveDuration = Duration(milliseconds: ms); });
                      print('Duration: ${ms}ms');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),

            const Text('Curve:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _curves.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_curves[index].key),
                      selected: _curveIndex == index,
                      onSelected: (s) {
                        if (s) {
                          setState(() {
                            _curveIndex = index;
                            _selectedCurve = _curves[index].value;
                          });
                          print('Curve: ${_curves[index].key}');
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Combined Property Animation
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCombinedSection() {
    print('=== Section 7: Combined Property Animation ===');
    print('Preset: $_presetIndex');
    print('Start: $_combStart, Top: $_combTop, ${_combWidth}x$_combHeight');

    final presets = [
      {'name': 'Top-left small', 'start': 10.0, 'top': 10.0, 'w': 60.0, 'h': 60.0},
      {'name': 'Center medium', 'start': 100.0, 'top': 50.0, 'w': 100.0, 'h': 80.0},
      {'name': 'Bottom-right large', 'start': 160.0, 'top': 100.0, 'w': 140.0, 'h': 60.0},
      {'name': 'Full width', 'start': 5.0, 'top': 60.0, 'w': 290.0, 'h': 40.0},
      {'name': 'Centered square', 'start': 95.0, 'top': 30.0, 'w': 110.0, 'h': 110.0},
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'All properties (start, top, width, height) animate '
              'simultaneously for compound motion effects.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  AnimatedPositionedDirectional(
                    start: _combStart,
                    top: _combTop,
                    width: _combWidth,
                    height: _combHeight,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade400, Colors.teal.shade700],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${_combWidth.toInt()}×${_combHeight.toInt()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(presets.length, (i) {
                final p = presets[i];
                return ChoiceChip(
                  label: Text(p['name'] as String),
                  selected: _presetIndex == i,
                  onSelected: (s) {
                    if (s) {
                      setState(() {
                        _presetIndex = i;
                        _combStart = p['start'] as double;
                        _combTop = p['top'] as double;
                        _combWidth = p['w'] as double;
                        _combHeight = p['h'] as double;
                      });
                      print('Preset: ${p['name']}');
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
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== Section 8: Practical Use Cases ===');
    print('Panel: $_panelOpen, Badge: $_showBadge ($_badgeCount)');
    print('Label: $_labelFloated, Drawer: $_drawerState');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common patterns using AnimatedPositionedDirectional.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Use Case 1: Slide-in notification panel
            const Text('1. Slide-In Panel', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Main content area'),
                  ),
                  AnimatedPositionedDirectional(
                    start: _panelOpen ? 0 : -200,
                    top: 0,
                    bottom: 0,
                    width: 180,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade700,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Side Panel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Navigation items...', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() { _panelOpen = !_panelOpen; });
                print('Panel: ${_panelOpen ? "open" : "closed"}');
              },
              child: Text(_panelOpen ? 'Close Panel' : 'Open Panel'),
            ),
            const SizedBox(height: 24),

            // Use Case 2: Notification badge
            const Text('2. Notification Badge', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.mail_outline, size: 28),
                  ),
                  AnimatedPositionedDirectional(
                    start: _showBadge ? 48 : 35,
                    top: _showBadge ? 2 : 15,
                    width: _showBadge ? 28 : 0,
                    height: _showBadge ? 28 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.elasticOut,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$_badgeCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _badgeCount++;
                      _showBadge = true;
                    });
                    print('Badge: $_badgeCount');
                  },
                  child: const Text('Add Notification'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _badgeCount = 0;
                      _showBadge = false;
                    });
                    print('Badge cleared');
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Use Case 3: Floating label
            const Text('3. Floating Label', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 70,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _labelFloated ? Colors.teal : Colors.grey,
                          width: _labelFloated ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Input value here...', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  AnimatedPositionedDirectional(
                    start: _labelFloated ? 8 : 12,
                    top: _labelFloated ? 0 : 24,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: _labelFloated ? 12 : 16,
                          color: _labelFloated ? Colors.teal : Colors.grey,
                          fontWeight: _labelFloated ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() { _labelFloated = !_labelFloated; });
                print('Label ${_labelFloated ? "floated" : "resting"}');
              },
              child: Text(_labelFloated ? 'Unfocus' : 'Focus Field'),
            ),
            const SizedBox(height: 24),

            // Use Case 4: Directional drawer
            const Text('4. Directional Drawer (3 states)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Content area'),
                  ),
                  AnimatedPositionedDirectional(
                    end: _drawerState == 0 ? -220 : (_drawerState == 1 ? -160 : 0),
                    top: 0,
                    bottom: 0,
                    width: 200,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade700,
                        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('End Drawer',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _drawerState == 0 ? 'Closed'
                                : _drawerState == 1 ? 'Peek' : 'Open',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Closed'),
                  selected: _drawerState == 0,
                  onSelected: (s) {
                    if (s) setState(() { _drawerState = 0; });
                    print('Drawer: closed');
                  },
                ),
                ChoiceChip(
                  label: const Text('Peek'),
                  selected: _drawerState == 1,
                  onSelected: (s) {
                    if (s) setState(() { _drawerState = 1; });
                    print('Drawer: peek');
                  },
                ),
                ChoiceChip(
                  label: const Text('Open'),
                  selected: _drawerState == 2,
                  onSelected: (s) {
                    if (s) setState(() { _drawerState = 2; });
                    print('Drawer: open');
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
  // Helper Methods
  // ═══════════════════════════════════════════════════════════════════════════
  List<Widget> _buildGridLines(double height) {
    return [
      // Vertical center
      Positioned(
        left: 0,
        right: 0,
        top: height / 2,
        child: Container(height: 1, color: Colors.grey.shade300),
      ),
      // Horizontal center
      Positioned(
        top: 0,
        bottom: 0,
        left: MediaQuery.of(context).size.width / 2 - 32,
        child: Container(width: 1, color: Colors.grey.shade300),
      ),
    ];
  }

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
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const Divider(thickness: 2, color: Colors.teal),
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
