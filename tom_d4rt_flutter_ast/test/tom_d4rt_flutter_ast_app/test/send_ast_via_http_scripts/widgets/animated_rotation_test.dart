// ignore_for_file: avoid_print
// Deep demo: AnimatedRotation - Implicit animation for rotation transitions
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedRotationDemo(),
  );
}

class AnimatedRotationDemo extends StatefulWidget {
  const AnimatedRotationDemo({super.key});

  @override
  State<AnimatedRotationDemo> createState() => _AnimatedRotationDemoState();
}

class _AnimatedRotationDemoState extends State<AnimatedRotationDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Rotation Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  double _basicTurns = 0.0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Turn Values and Directions
  // ═══════════════════════════════════════════════════════════════════════════
  double _directionTurns = 0.0;
  int _rotationCount = 0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  double _durationTurns = 0.0;
  Duration _selectedDuration = const Duration(milliseconds: 500);
  final List<Duration> _durations = [
    const Duration(milliseconds: 100),
    const Duration(milliseconds: 300),
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 2000),
  ];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Curve Variations
  // ═══════════════════════════════════════════════════════════════════════════
  double _curveTurns = 0.0;
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
  ];
  int _curveIndex = 3;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Alignment and Transform Origin
  // ═══════════════════════════════════════════════════════════════════════════
  double _alignTurns = 0.0;
  Alignment _rotationAlignment = Alignment.center;
  final List<Alignment> _alignments = [
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
  final List<String> _alignmentNames = [
    'topLeft', 'topCenter', 'topRight',
    'centerLeft', 'center', 'centerRight',
    'bottomLeft', 'bottomCenter', 'bottomRight',
  ];
  int _alignmentIndex = 4;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Filter Quality
  // ═══════════════════════════════════════════════════════════════════════════
  double _qualityTurns = 0.0;
  FilterQuality _filterQuality = FilterQuality.low;
  final List<FilterQuality> _filterQualities = FilterQuality.values;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _isLoading = false;
  double _loadingTurns = 0.0;
  bool _isExpanded = false;
  int _compassDirection = 0;
  bool _isMenuOpen = false;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Combined Animations and Edge Cases
  // ═══════════════════════════════════════════════════════════════════════════
  double _combinedTurns = 0.0;
  double _combinedScale = 1.0;
  double _combinedOpacity = 1.0;
  int _multiRotationCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedRotation Deep Demo'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Rotation Fundamentals
            _buildSectionHeader('1. Basic Rotation Fundamentals'),
            _buildBasicRotationSection(),
            const SizedBox(height: 32),
            
            // Section 2: Turn Values and Directions
            _buildSectionHeader('2. Turn Values and Directions'),
            _buildDirectionsSection(),
            const SizedBox(height: 32),
            
            // Section 3: Duration Control
            _buildSectionHeader('3. Duration Control'),
            _buildDurationSection(),
            const SizedBox(height: 32),
            
            // Section 4: Curve Variations
            _buildSectionHeader('4. Curve Variations'),
            _buildCurvesSection(),
            const SizedBox(height: 32),
            
            // Section 5: Alignment and Transform Origin
            _buildSectionHeader('5. Alignment and Transform Origin'),
            _buildAlignmentSection(),
            const SizedBox(height: 32),
            
            // Section 6: Filter Quality
            _buildSectionHeader('6. Filter Quality'),
            _buildFilterQualitySection(),
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
  // SECTION 1: Basic Rotation Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicRotationSection() {
    print('=== Section 1: Basic Rotation Fundamentals ===');
    print('Current turns: $_basicTurns');
    print('Degrees: ${(_basicTurns * 360).toStringAsFixed(1)}°');
    print('1 turn = 360 degrees = full rotation');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedRotation uses "turns" where 1 turn = 360°. '
              'The rotation animates smoothly when the value changes.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedRotation(
                  turns: _basicTurns,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.white, size: 32),
                        Text('UP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Turn value display
            Text(
              'Turns: ${_basicTurns.toStringAsFixed(2)} (${(_basicTurns * 360).toStringAsFixed(0)}°)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            // Control buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _basicTurns = 0;
                    });
                    print('Basic rotation reset to 0');
                  },
                  child: const Text('0°'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _basicTurns = 0.25;
                    });
                    print('Basic rotation set to 90° (0.25 turns)');
                  },
                  child: const Text('90°'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _basicTurns = 0.5;
                    });
                    print('Basic rotation set to 180° (0.5 turns)');
                  },
                  child: const Text('180°'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _basicTurns = 0.75;
                    });
                    print('Basic rotation set to 270° (0.75 turns)');
                  },
                  child: const Text('270°'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _basicTurns = 1.0;
                    });
                    print('Basic rotation set to 360° (1 turn)');
                  },
                  child: const Text('360°'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Turn Values and Directions
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDirectionsSection() {
    print('=== Section 2: Turn Values and Directions ===');
    print('Direction turns: $_directionTurns');
    print('Rotation count: $_rotationCount');
    print('Positive turns = clockwise, negative = counter-clockwise');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Positive values rotate clockwise, negative values rotate '
              'counter-clockwise. Values can exceed 1 for multiple rotations.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedRotation(
                  turns: _directionTurns,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.navigation, color: Colors.white, size: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Rotation counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Turns: ${_directionTurns.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 16),
                Text(
                  'Full rotations: $_rotationCount',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Direction controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Counter-Clockwise', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _directionTurns -= 1;
                              _rotationCount--;
                            });
                            print('Rotate -1 turn (CCW), total: $_directionTurns');
                          },
                          icon: const Icon(Icons.rotate_left),
                          label: const Text('-1'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _directionTurns -= 0.25;
                            });
                            print('Rotate -0.25 turns (CCW), total: $_directionTurns');
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade200),
                          child: const Text('-90°'),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _directionTurns = 0;
                      _rotationCount = 0;
                    });
                    print('Direction rotation reset');
                  },
                  child: const Text('Reset'),
                ),
                Column(
                  children: [
                    const Text('Clockwise', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _directionTurns += 0.25;
                            });
                            print('Rotate +0.25 turns (CW), total: $_directionTurns');
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade200),
                          child: const Text('+90°'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _directionTurns += 1;
                              _rotationCount++;
                            });
                            print('Rotate +1 turn (CW), total: $_directionTurns');
                          },
                          icon: const Icon(Icons.rotate_right),
                          label: const Text('+1'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade400),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationSection() {
    print('=== Section 3: Duration Control ===');
    print('Selected duration: ${_selectedDuration.inMilliseconds}ms');
    print('Duration turns: $_durationTurns');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Duration controls how long the rotation animation takes. '
              'Longer durations create smoother, slower rotations.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedRotation(
                  turns: _durationTurns,
                  duration: _selectedDuration,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '${_selectedDuration.inMilliseconds}ms',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Duration selector
            const Text('Duration:', style: TextStyle(fontWeight: FontWeight.bold)),
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
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _durationTurns = _durationTurns == 0 ? 1 : 0;
                });
                print('Duration demo toggled: $_durationTurns turns');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Toggle Rotation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Curve Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCurvesSection() {
    print('=== Section 4: Curve Variations ===');
    print('Selected curve: ${_curves[_curveIndex].key}');
    print('Curve turns: $_curveTurns');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Curves control the animation easing. Bounce and elastic '
              'curves add playful effects to rotations.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedRotation(
                  turns: _curveTurns,
                  duration: const Duration(milliseconds: 800),
                  curve: _selectedCurve,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.refresh, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Curve selector
            const Text('Curve:', style: TextStyle(fontWeight: FontWeight.bold)),
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
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _curveTurns += 1;
                });
                print('Curve demo: +1 turn with ${_curves[_curveIndex].key}');
              },
              icon: const Icon(Icons.rotate_right),
              label: const Text('Rotate 1 Turn'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Alignment and Transform Origin
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAlignmentSection() {
    print('=== Section 5: Alignment and Transform Origin ===');
    print('Alignment index: $_alignmentIndex');
    print('Alignment: ${_alignmentNames[_alignmentIndex]}');
    print('Align turns: $_alignTurns');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alignment determines the pivot point for rotation. '
              'Center rotates in place, corners orbit around themselves.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container with origin indicator
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Grid lines for reference
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPainter(),
                    ),
                  ),
                  Center(
                    child: AnimatedRotation(
                      turns: _alignTurns,
                      duration: const Duration(milliseconds: 500),
                      alignment: _rotationAlignment,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.crop_rotate, color: Colors.white, size: 32),
                          ),
                          // Pivot point indicator
                          Positioned(
                            left: 40 + (_rotationAlignment.x * 40) - 6,
                            top: 40 + (_rotationAlignment.y * 40) - 6,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
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
            const SizedBox(height: 16),
            
            // Alignment selector grid
            const Text('Pivot Point:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
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
                final isSelected = _alignmentIndex == index;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.indigo : Colors.grey.shade300,
                    foregroundColor: isSelected ? Colors.white : Colors.black87,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    setState(() {
                      _alignmentIndex = index;
                      _rotationAlignment = _alignments[index];
                    });
                    print('Alignment changed to: ${_alignmentNames[index]}');
                  },
                  child: Text(_alignmentNames[index], style: const TextStyle(fontSize: 9)),
                );
              },
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _alignTurns += 0.5;
                });
                print('Alignment demo: +0.5 turns from ${_alignmentNames[_alignmentIndex]}');
              },
              icon: const Icon(Icons.rotate_right),
              label: const Text('Rotate 180°'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Filter Quality
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFilterQualitySection() {
    print('=== Section 6: Filter Quality ===');
    print('Filter quality: $_filterQuality');
    print('Quality turns: $_qualityTurns');
    print('Higher quality = smoother edges but more processing');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FilterQuality affects rendering quality during rotation. '
              'Higher quality is smoother but uses more resources.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo with image
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedRotation(
                  turns: _qualityTurns,
                  duration: const Duration(milliseconds: 500),
                  filterQuality: _filterQuality,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.purple, Colors.pink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Center(
                      child: Text(
                        'ABC',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Quality selector
            const Text('Filter Quality:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: _filterQualities.map((quality) {
                final isSelected = _filterQuality == quality;
                return ChoiceChip(
                  label: Text(quality.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _filterQuality = quality;
                      });
                      print('Filter quality changed to: ${quality.name}');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            
            Text(
              'Current: ${_filterQuality.name}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _qualityTurns += 0.25;
                });
                print('Quality demo: +0.25 turns with ${_filterQuality.name}');
              },
              icon: const Icon(Icons.rotate_right),
              label: const Text('Rotate 90°'),
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
    print('Is loading: $_isLoading');
    print('Is expanded: $_isExpanded');
    print('Compass direction: $_compassDirection');
    print('Is menu open: $_isMenuOpen');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common use cases for AnimatedRotation in real applications.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            
            // Use Case 1: Loading Indicator
            const Text('1. Continuous Loading Spinner', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: AnimatedRotation(
                      turns: _loadingTurns,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.linear,
                      onEnd: () {
                        if (_isLoading) {
                          setState(() {
                            _loadingTurns += 1;
                          });
                        }
                      },
                      child: const Icon(Icons.sync, color: Colors.blue, size: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = !_isLoading;
                      if (_isLoading) {
                        _loadingTurns += 1;
                      }
                    });
                    print('Loading spinner: ${_isLoading ? 'started' : 'stopped'}');
                  },
                  child: Text(_isLoading ? 'Stop' : 'Start'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Use Case 2: Expand/Collapse Arrow
            const Text('2. Expand/Collapse Indicator', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
                print('Expanded: $_isExpanded');
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.expand_more, color: Colors.green),
                    ),
                    const SizedBox(width: 8),
                    Text(_isExpanded ? 'Click to collapse' : 'Click to expand'),
                    const Spacer(),
                    Text(_isExpanded ? 'Expanded' : 'Collapsed', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Use Case 3: Compass Direction
            const Text('3. Compass/Direction Indicator', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber.shade200, width: 2),
                  ),
                  child: Center(
                    child: AnimatedRotation(
                      turns: _compassDirection * 0.25,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      child: const Icon(Icons.navigation, color: Colors.amber, size: 40),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ['North', 'East', 'South', 'West'][_compassDirection % 4],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      children: ['N', 'E', 'S', 'W'].asMap().entries.map((entry) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _compassDirection = entry.key;
                            });
                            print('Compass: ${entry.value}');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40, 32),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(entry.value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Use Case 4: Menu Toggle
            const Text('4. Hamburger Menu Toggle', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMenuOpen = !_isMenuOpen;
                    });
                    print('Menu: ${_isMenuOpen ? 'open' : 'closed'}');
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: AnimatedRotation(
                        turns: _isMenuOpen ? 0.125 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          _isMenuOpen ? Icons.close : Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(_isMenuOpen ? 'Menu is open' : 'Tap to open menu'),
              ],
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
    print('Combined turns: $_combinedTurns');
    print('Combined scale: $_combinedScale');
    print('Combined opacity: $_combinedOpacity');
    print('Multi-rotation count: $_multiRotationCount');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Combining AnimatedRotation with other animated widgets.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Combined animations demo
            const Text('Rotation + Scale + Opacity', style: TextStyle(fontWeight: FontWeight.bold)),
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
              child: Center(
                child: AnimatedRotation(
                  turns: _combinedTurns,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedScale(
                    scale: _combinedScale,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      opacity: _combinedOpacity,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.star, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Control sliders
            Row(
              children: [
                const SizedBox(width: 60, child: Text('Turns:')),
                Expanded(
                  child: Slider(
                    value: _combinedTurns,
                    min: 0,
                    max: 4,
                    divisions: 16,
                    label: _combinedTurns.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() {
                        _combinedTurns = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 60, child: Text('Scale:')),
                Expanded(
                  child: Slider(
                    value: _combinedScale,
                    min: 0.5,
                    max: 2,
                    divisions: 15,
                    label: _combinedScale.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() {
                        _combinedScale = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 60, child: Text('Opacity:')),
                Expanded(
                  child: Slider(
                    value: _combinedOpacity,
                    min: 0,
                    max: 1,
                    divisions: 10,
                    label: _combinedOpacity.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() {
                        _combinedOpacity = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Multi-turn demo
            const Text('Multiple Full Rotations', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: AnimatedRotation(
                      turns: _multiRotationCount.toDouble(),
                      duration: Duration(milliseconds: 500 * _multiRotationCount.abs().clamp(1, 10)),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.autorenew, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text('Turns: $_multiRotationCount', style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _multiRotationCount += 3;
                    });
                    print('Multi-rotation: +3 turns, total: $_multiRotationCount');
                  },
                  child: const Text('+3 Turns'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Edge cases
            const Text('Edge Cases:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEdgeCaseItem('Very large turn values', 'Animation interpolates through all rotations'),
            _buildEdgeCaseItem('Negative turns', 'Rotates counter-clockwise'),
            _buildEdgeCaseItem('0 duration', 'Instant rotation, no animation'),
            _buildEdgeCaseItem('Same turns value', 'No animation triggered'),
            _buildEdgeCaseItem('Fractional turns', '0.125 = 45°, 0.25 = 90°, 0.5 = 180°'),
          ],
        ),
      ),
    );
  }

  Widget _buildEdgeCaseItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, size: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                children: [
                  TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
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
}

// Grid painter for alignment visualization
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    
    // Center lines
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
