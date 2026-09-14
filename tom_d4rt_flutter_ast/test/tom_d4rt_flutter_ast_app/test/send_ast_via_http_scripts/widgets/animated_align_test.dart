// ignore_for_file: avoid_print
// Deep demo: AnimatedAlign - Implicit animation for alignment transitions
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedAlignDemo(),
  );
}

class AnimatedAlignDemo extends StatefulWidget {
  const AnimatedAlignDemo({super.key});

  @override
  State<AnimatedAlignDemo> createState() => _AnimatedAlignDemoState();
}

class _AnimatedAlignDemoState extends State<AnimatedAlignDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Alignment Animation Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  Alignment _basicAlignment = Alignment.topLeft;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Alignment Preset Variations
  // ═══════════════════════════════════════════════════════════════════════════
  int _presetIndex = 0;
  final List<Alignment> _alignmentPresets = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];
  final List<String> _presetNames = [
    'topLeft', 'topCenter', 'topRight',
    'centerLeft', 'center', 'centerRight',
    'bottomLeft', 'bottomCenter', 'bottomRight',
  ];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Custom Alignment Values
  // ═══════════════════════════════════════════════════════════════════════════
  double _customX = 0.0;
  double _customY = 0.0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  Alignment _durationAlignment = Alignment.topLeft;
  Duration _selectedDuration = const Duration(milliseconds: 300);
  final List<Duration> _durations = [
    const Duration(milliseconds: 100),
    const Duration(milliseconds: 300),
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 2000),
  ];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Curve Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Alignment _curveAlignment = Alignment.topLeft;
  Curve _selectedCurve = Curves.easeInOut;
  final List<MapEntry<String, Curve>> _curves = [
    const MapEntry('linear', Curves.linear),
    const MapEntry('easeIn', Curves.easeIn),
    const MapEntry('easeOut', Curves.easeOut),
    const MapEntry('easeInOut', Curves.easeInOut),
    const MapEntry('bounceIn', Curves.bounceIn),
    const MapEntry('bounceOut', Curves.bounceOut),
    const MapEntry('elasticIn', Curves.elasticIn),
    const MapEntry('elasticOut', Curves.elasticOut),
    const MapEntry('fastOutSlowIn', Curves.fastOutSlowIn),
    const MapEntry('slowMiddle', Curves.slowMiddle),
  ];
  int _curveIndex = 3;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Width and Height Factor
  // ═══════════════════════════════════════════════════════════════════════════
  Alignment _factorAlignment = Alignment.topLeft;
  double? _widthFactor;
  double? _heightFactor;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _isExpanded = false;
  bool _isMenuOpen = false;
  int _notificationPosition = 0;
  bool _centerContent = true;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Combined Animations and Edge Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Alignment _chainedAlignment = Alignment.center;
  int _patternStep = 0;
  bool _animatingPattern = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedAlign Deep Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Alignment Animation Fundamentals
            _buildSectionHeader('1. Basic Alignment Animation Fundamentals'),
            _buildBasicAlignmentSection(),
            const SizedBox(height: 32),
            
            // Section 2: Alignment Preset Variations
            _buildSectionHeader('2. Alignment Preset Variations'),
            _buildPresetVariationsSection(),
            const SizedBox(height: 32),
            
            // Section 3: Custom Alignment Values
            _buildSectionHeader('3. Custom Alignment Values'),
            _buildCustomAlignmentSection(),
            const SizedBox(height: 32),
            
            // Section 4: Duration Control
            _buildSectionHeader('4. Duration Control'),
            _buildDurationControlSection(),
            const SizedBox(height: 32),
            
            // Section 5: Curve Variations
            _buildSectionHeader('5. Curve Variations'),
            _buildCurveVariationsSection(),
            const SizedBox(height: 32),
            
            // Section 6: Width and Height Factor
            _buildSectionHeader('6. Width and Height Factor'),
            _buildFactorSection(),
            const SizedBox(height: 32),
            
            // Section 7: Practical Use Cases
            _buildSectionHeader('7. Practical Use Cases'),
            _buildPracticalUseCasesSection(),
            const SizedBox(height: 32),
            
            // Section 8: Combined Animations and Edge Cases
            _buildSectionHeader('8. Combined Animations and Edge Cases'),
            _buildCombinedAnimationsSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Alignment Animation Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicAlignmentSection() {
    print('=== Section 1: Basic Alignment Animation Fundamentals ===');
    print('Current alignment: $_basicAlignment');
    print('AnimatedAlign animates changes to alignment over time');
    print('Default duration is used when not specified');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedAlign smoothly animates alignment transitions.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: AnimatedAlign(
                alignment: _basicAlignment,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.star, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Control buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _basicAlignment = Alignment.topLeft;
                    });
                    print('Basic alignment changed to: topLeft');
                  },
                  icon: const Icon(Icons.north_west),
                  label: const Text('Top Left'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _basicAlignment = Alignment.center;
                    });
                    print('Basic alignment changed to: center');
                  },
                  icon: const Icon(Icons.center_focus_strong),
                  label: const Text('Center'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _basicAlignment = Alignment.bottomRight;
                    });
                    print('Basic alignment changed to: bottomRight');
                  },
                  icon: const Icon(Icons.south_east),
                  label: const Text('Bottom Right'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Current: ${_basicAlignment.toString().replaceAll('Alignment.', '')}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Alignment Preset Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPresetVariationsSection() {
    print('=== Section 2: Alignment Preset Variations ===');
    print('Current preset index: $_presetIndex');
    print('Preset name: ${_presetNames[_presetIndex]}');
    print('Alignment value: ${_alignmentPresets[_presetIndex]}');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flutter provides 9 standard alignment presets in a 3x3 grid.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Alignment grid visualization
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Stack(
                children: [
                  // Grid lines
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPainter(),
                    ),
                  ),
                  // Animated element
                  AnimatedAlign(
                    alignment: _alignmentPresets[_presetIndex],
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          '${_presetIndex + 1}',
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
            const SizedBox(height: 16),
            
            // 3x3 button grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                final isSelected = _presetIndex == index;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.orange : Colors.grey.shade300,
                    foregroundColor: isSelected ? Colors.white : Colors.black87,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    setState(() {
                      _presetIndex = index;
                    });
                    print('Preset changed to: ${_presetNames[index]}');
                    print('Alignment: ${_alignmentPresets[index]}');
                  },
                  child: Text(
                    _presetNames[index].replaceAll('top', 'T').replaceAll('bottom', 'B').replaceAll('center', 'C').replaceAll('Left', 'L').replaceAll('Right', 'R').replaceAll('Center', 'C'),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              'Selected: ${_presetNames[_presetIndex]} (x: ${_alignmentPresets[_presetIndex].x}, y: ${_alignmentPresets[_presetIndex].y})',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Custom Alignment Values
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCustomAlignmentSection() {
    print('=== Section 3: Custom Alignment Values ===');
    print('Custom X: $_customX, Custom Y: $_customY');
    print('Alignment range: x and y from -1.0 to 1.0');
    print('(-1, -1) = topLeft, (0, 0) = center, (1, 1) = bottomRight');
    
    final customAlignment = Alignment(_customX, _customY);
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create custom alignments using x and y values from -1.0 to 1.0.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Custom alignment demo
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: AnimatedAlign(
                alignment: customAlignment,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.location_on, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // X slider
            Row(
              children: [
                const SizedBox(width: 60, child: Text('X axis:')),
                Expanded(
                  child: Slider(
                    value: _customX,
                    min: -1.0,
                    max: 1.0,
                    divisions: 20,
                    label: _customX.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() {
                        _customX = value;
                      });
                      print('Custom X changed to: $value');
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(_customX.toStringAsFixed(2)),
                ),
              ],
            ),
            
            // Y slider
            Row(
              children: [
                const SizedBox(width: 60, child: Text('Y axis:')),
                Expanded(
                  child: Slider(
                    value: _customY,
                    min: -1.0,
                    max: 1.0,
                    divisions: 20,
                    label: _customY.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() {
                        _customY = value;
                      });
                      print('Custom Y changed to: $value');
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(_customY.toStringAsFixed(2)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Quick presets for custom values
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _customX = -0.5;
                      _customY = -0.5;
                    });
                    print('Custom alignment set to (-0.5, -0.5)');
                  },
                  child: const Text('(-0.5, -0.5)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _customX = 0.5;
                      _customY = -0.5;
                    });
                    print('Custom alignment set to (0.5, -0.5)');
                  },
                  child: const Text('(0.5, -0.5)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _customX = 0;
                      _customY = 0;
                    });
                    print('Custom alignment reset to center (0, 0)');
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationControlSection() {
    print('=== Section 4: Duration Control ===');
    print('Selected duration: $_selectedDuration');
    print('Current alignment: $_durationAlignment');
    print('Duration affects animation speed - longer = smoother but slower');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Duration controls how long the alignment transition takes.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo with duration
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: AnimatedAlign(
                alignment: _durationAlignment,
                duration: _selectedDuration,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${_selectedDuration.inMilliseconds}ms',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Duration selector
            const Text('Select Duration:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _durations.map((duration) {
                final isSelected = _selectedDuration == duration;
                return ChoiceChip(
                  label: Text('${duration.inMilliseconds}ms'),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedDuration = duration;
                      });
                      print('Duration changed to: ${duration.inMilliseconds}ms');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            
            // Toggle button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _durationAlignment = _durationAlignment == Alignment.topLeft
                      ? Alignment.bottomRight
                      : Alignment.topLeft;
                });
                print('Duration demo alignment toggled to: $_durationAlignment');
              },
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Toggle Position'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Curve Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCurveVariationsSection() {
    print('=== Section 5: Curve Variations ===');
    print('Selected curve: ${_curves[_curveIndex].key}');
    print('Curve index: $_curveIndex');
    print('Curves control animation easing - linear, ease, bounce, elastic, etc.');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Curves control the animation easing for smooth or bouncy effects.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo with curves
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: AnimatedAlign(
                alignment: _curveAlignment,
                duration: const Duration(milliseconds: 800),
                curve: _selectedCurve,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade600,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.motion_photos_on, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Curve selector
            const Text('Select Curve:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _curves.length,
                itemBuilder: (context, index) {
                  final isSelected = _curveIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_curves[index].key),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _curveIndex = index;
                            _selectedCurve = _curves[index].value;
                          });
                          print('Curve changed to: ${_curves[index].key}');
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Toggle with curve animation
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _curveAlignment = _curveAlignment == Alignment.centerLeft
                      ? Alignment.centerRight
                      : Alignment.centerLeft;
                });
                print('Curve demo alignment toggled');
                print('Using curve: ${_curves[_curveIndex].key}');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Animate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade600,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Width and Height Factor
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFactorSection() {
    print('=== Section 6: Width and Height Factor ===');
    print('Width factor: $_widthFactor');
    print('Height factor: $_heightFactor');
    print('Factors constrain child size relative to parent');
    print('null means no constraint, values 0-1 are fractions of parent');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Width/height factors constrain the child\'s size as a fraction of parent.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo with factors
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade200, width: 2),
              ),
              child: AnimatedAlign(
                alignment: _factorAlignment,
                duration: const Duration(milliseconds: 400),
                widthFactor: _widthFactor,
                heightFactor: _heightFactor,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.aspect_ratio, color: Colors.white, size: 32),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Width factor control
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Width Factor:')),
                Expanded(
                  child: Slider(
                    value: _widthFactor ?? 0,
                    min: 0,
                    max: 2,
                    divisions: 20,
                    label: _widthFactor?.toStringAsFixed(2) ?? 'null',
                    onChanged: (value) {
                      setState(() {
                        _widthFactor = value == 0 ? null : value;
                      });
                      print('Width factor: $_widthFactor');
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(_widthFactor?.toStringAsFixed(1) ?? 'null'),
                ),
              ],
            ),
            
            // Height factor control
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Height Factor:')),
                Expanded(
                  child: Slider(
                    value: _heightFactor ?? 0,
                    min: 0,
                    max: 2,
                    divisions: 20,
                    label: _heightFactor?.toStringAsFixed(2) ?? 'null',
                    onChanged: (value) {
                      setState(() {
                        _heightFactor = value == 0 ? null : value;
                      });
                      print('Height factor: $_heightFactor');
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(_heightFactor?.toStringAsFixed(1) ?? 'null'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Position toggles
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _factorAlignment = Alignment.topLeft;
                    });
                    print('Factor demo: topLeft');
                  },
                  child: const Text('Top Left'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _factorAlignment = Alignment.center;
                    });
                    print('Factor demo: center');
                  },
                  child: const Text('Center'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _factorAlignment = Alignment.bottomRight;
                    });
                    print('Factor demo: bottomRight');
                  },
                  child: const Text('Bottom Right'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== Section 7: Practical Use Cases ===');
    print('Expanded state: $_isExpanded');
    print('Menu open: $_isMenuOpen');
    print('Notification position: $_notificationPosition');
    print('Center content: $_centerContent');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-world use cases for AnimatedAlign.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            
            // Use Case 1: Expandable FAB
            const Text('1. Expandable Action Button', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Secondary buttons
                  AnimatedAlign(
                    alignment: _isExpanded
                        ? const Alignment(0.5, 0)
                        : Alignment.centerRight,
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedOpacity(
                      opacity: _isExpanded ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: FloatingActionButton.small(
                        heroTag: 'edit',
                        onPressed: () => print('Edit pressed'),
                        backgroundColor: Colors.indigo.shade300,
                        child: const Icon(Icons.edit),
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    alignment: _isExpanded
                        ? const Alignment(0.2, 0)
                        : Alignment.centerRight,
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedOpacity(
                      opacity: _isExpanded ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: FloatingActionButton.small(
                        heroTag: 'share',
                        onPressed: () => print('Share pressed'),
                        backgroundColor: Colors.indigo.shade300,
                        child: const Icon(Icons.share),
                      ),
                    ),
                  ),
                  // Main FAB
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FloatingActionButton(
                        heroTag: 'main',
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                          print('FAB expanded: $_isExpanded');
                        },
                        backgroundColor: Colors.indigo,
                        child: AnimatedRotation(
                          turns: _isExpanded ? 0.125 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Use Case 2: Slide-in Menu
            const Text('2. Slide-in Menu Toggle', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  AnimatedAlign(
                    alignment: _isMenuOpen ? Alignment.centerLeft : const Alignment(-2, 0),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Menu Content', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isMenuOpen = !_isMenuOpen;
                      });
                      print('Menu open: $_isMenuOpen');
                    },
                    icon: Icon(_isMenuOpen ? Icons.menu_open : Icons.menu),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Use Case 3: Notification Position
            const Text('3. Notification Position', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedAlign(
                alignment: [
                  Alignment.topLeft,
                  Alignment.topRight,
                  Alignment.bottomLeft,
                  Alignment.bottomRight,
                ][_notificationPosition],
                duration: const Duration(milliseconds: 300),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.notifications, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text('3 New', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                TextButton(onPressed: () { setState(() { _notificationPosition = 0; }); print('Notification: topLeft'); }, child: const Text('TL')),
                TextButton(onPressed: () { setState(() { _notificationPosition = 1; }); print('Notification: topRight'); }, child: const Text('TR')),
                TextButton(onPressed: () { setState(() { _notificationPosition = 2; }); print('Notification: bottomLeft'); }, child: const Text('BL')),
                TextButton(onPressed: () { setState(() { _notificationPosition = 3; }); print('Notification: bottomRight'); }, child: const Text('BR')),
              ],
            ),
            const SizedBox(height: 24),
            
            // Use Case 4: Content Centering Toggle
            const Text('4. Content Centering Toggle', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedAlign(
                alignment: _centerContent ? Alignment.center : Alignment.centerLeft,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Dynamic Content',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SwitchListTile(
              title: const Text('Center Content'),
              value: _centerContent,
              onChanged: (value) {
                setState(() {
                  _centerContent = value;
                });
                print('Center content: $_centerContent');
              },
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Combined Animations and Edge Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCombinedAnimationsSection() {
    print('=== Section 8: Combined Animations and Edge Cases ===');
    print('Chained alignment: $_chainedAlignment');
    print('Pattern step: $_patternStep');
    print('Animating pattern: $_animatingPattern');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Combining AnimatedAlign with other animations and patterns.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Combined with scale/opacity
            const Text('Combined with Scale and Opacity', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade100, Colors.purple.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedAlign(
                alignment: _chainedAlignment,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                child: AnimatedScale(
                  scale: _chainedAlignment == Alignment.center ? 1.5 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedOpacity(
                    opacity: _chainedAlignment == Alignment.center ? 1.0 : 0.7,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () { setState(() { _chainedAlignment = Alignment.topLeft; }); print('Chained: topLeft'); },
                  child: const Text('TL'),
                ),
                ElevatedButton(
                  onPressed: () { setState(() { _chainedAlignment = Alignment.center; }); print('Chained: center (scale up)'); },
                  child: const Text('Center'),
                ),
                ElevatedButton(
                  onPressed: () { setState(() { _chainedAlignment = Alignment.bottomRight; }); print('Chained: bottomRight'); },
                  child: const Text('BR'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Pattern animation
            const Text('Pattern Animation Sequence', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedAlign(
                alignment: _getPatternAlignment(_patternStep),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                onEnd: () {
                  if (_animatingPattern && _patternStep < 7) {
                    setState(() {
                      _patternStep++;
                    });
                    print('Pattern step: $_patternStep');
                  } else if (_animatingPattern) {
                    setState(() {
                      _animatingPattern = false;
                      _patternStep = 0;
                    });
                    print('Pattern animation complete');
                  }
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${_patternStep + 1}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _animatingPattern ? null : () {
                    setState(() {
                      _animatingPattern = true;
                      _patternStep = 0;
                    });
                    print('Starting pattern animation');
                    // Trigger first step
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (mounted && _animatingPattern) {
                        setState(() {
                          _patternStep = 1;
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Run Pattern'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _animatingPattern = false;
                      _patternStep = 0;
                    });
                    print('Pattern reset');
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Edge case: Rapid changes
            const Text('Edge Case: Rapid Alignment Changes', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'AnimatedAlign handles rapid changes gracefully by interrupting '
              'the current animation and transitioning to the new target.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            
            // Same alignment (no animation)
            const Text('Edge Case: Same Alignment', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              'Setting the same alignment value triggers no animation. '
              'onEnd callback is not called when no animation occurs.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Alignment _getPatternAlignment(int step) {
    final alignments = [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.centerRight,
      Alignment.bottomRight,
      Alignment.bottomLeft,
      Alignment.centerLeft,
      Alignment.center,
      Alignment.topCenter,
    ];
    return alignments[step % alignments.length];
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
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const Divider(thickness: 2, color: Colors.deepPurple),
        ],
      ),
    );
  }
}

// Custom painter for grid visualization
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    
    // Vertical lines
    canvas.drawLine(Offset(size.width / 3, 0), Offset(size.width / 3, size.height), paint);
    canvas.drawLine(Offset(2 * size.width / 3, 0), Offset(2 * size.width / 3, size.height), paint);
    
    // Horizontal lines
    canvas.drawLine(Offset(0, size.height / 3), Offset(size.width, size.height / 3), paint);
    canvas.drawLine(Offset(0, 2 * size.height / 3), Offset(size.width, 2 * size.height / 3), paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
