// ignore_for_file: avoid_print
// Deep demo: AnimatedSlide - Implicit animation for position slide transitions
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedSlideDemo(),
  );
}

class AnimatedSlideDemo extends StatefulWidget {
  const AnimatedSlideDemo({super.key});

  @override
  State<AnimatedSlideDemo> createState() => _AnimatedSlideDemoState();
}

class _AnimatedSlideDemoState extends State<AnimatedSlideDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Slide Animation Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  Offset _basicOffset = Offset.zero;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Offset Values and Directions
  // ═══════════════════════════════════════════════════════════════════════════
  Offset _directionOffset = Offset.zero;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  Offset _durationOffset = Offset.zero;
  Duration _selectedDuration = const Duration(milliseconds: 300);
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
  Offset _curveOffset = Offset.zero;
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
  // SECTION 5: Fractional Offset System
  // ═══════════════════════════════════════════════════════════════════════════
  double _xOffset = 0.0;
  double _yOffset = 0.0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _drawerOpen = false;
  bool _notificationVisible = false;
  Offset _menuItemOffset1 = const Offset(-1, 0);
  Offset _menuItemOffset2 = const Offset(-1, 0);
  Offset _menuItemOffset3 = const Offset(-1, 0);
  bool _menuExpanded = false;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Sequential and Staggered Animations
  // ═══════════════════════════════════════════════════════════════════════════
  final List<Offset> _stackOffsets = [
    const Offset(1, 0),
    const Offset(1, 0),
    const Offset(1, 0),
    const Offset(1, 0),
  ];
  bool _stackAnimating = false;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Combined Animations and Edge Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Offset _combinedOffset = Offset.zero;
  double _combinedScale = 1.0;
  double _combinedOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedSlide Deep Demo'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Slide Animation Fundamentals
            _buildSectionHeader('1. Basic Slide Animation Fundamentals'),
            _buildBasicSlideSection(),
            const SizedBox(height: 32),
            
            // Section 2: Offset Values and Directions
            _buildSectionHeader('2. Offset Values and Directions'),
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
            
            // Section 5: Fractional Offset System
            _buildSectionHeader('5. Fractional Offset System'),
            _buildFractionalOffsetSection(),
            const SizedBox(height: 32),
            
            // Section 6: Practical Use Cases
            _buildSectionHeader('6. Practical Use Cases'),
            _buildPracticalUseCasesSection(),
            const SizedBox(height: 32),
            
            // Section 7: Sequential and Staggered Animations
            _buildSectionHeader('7. Sequential and Staggered Animations'),
            _buildSequentialAnimationsSection(),
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
  // SECTION 1: Basic Slide Animation Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicSlideSection() {
    print('=== Section 1: Basic Slide Animation Fundamentals ===');
    print('Current offset: $_basicOffset');
    print('Offset represents fractional child dimensions');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedSlide moves a widget by a fractional offset. '
              'Offset(1, 0) moves it 100% of its width to the right.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container with reference grid
            Container(
              height: 200,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Origin marker
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: CustomPaint(painter: _CrosshairPainter()),
                  ),
                  Center(
                    child: AnimatedSlide(
                      offset: _basicOffset,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: 80,
                        height: 80,
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
                        child: const Icon(Icons.open_with, color: Colors.white, size: 32),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Offset value display
            Text(
              'Offset: (${_basicOffset.dx.toStringAsFixed(1)}, ${_basicOffset.dy.toStringAsFixed(1)})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            
            // Control buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicOffset = const Offset(-1, 0); });
                    print('Slide: left (-1, 0)');
                  },
                  child: const Text('← Left'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicOffset = const Offset(1, 0); });
                    print('Slide: right (1, 0)');
                  },
                  child: const Text('Right →'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicOffset = const Offset(0, -1); });
                    print('Slide: up (0, -1)');
                  },
                  child: const Text('↑ Up'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicOffset = const Offset(0, 1); });
                    print('Slide: down (0, 1)');
                  },
                  child: const Text('Down ↓'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicOffset = Offset.zero; });
                    print('Slide: center (0, 0)');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('Center', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Offset Values and Directions
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDirectionsSection() {
    print('=== Section 2: Offset Values and Directions ===');
    print('Direction offset: $_directionOffset');
    print('X: negative=left, positive=right');
    print('Y: negative=up, positive=down');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Offsets can be fractional (0.5) or larger than 1 (2.0). '
              'Each unit represents the widget\'s own dimension.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 180,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: AnimatedSlide(
                      offset: _directionOffset,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.lightBlue],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '${_directionOffset.dx.toStringAsFixed(1)}\n${_directionOffset.dy.toStringAsFixed(1)}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Direction pad
            Center(
              child: Column(
                children: [
                  // Top row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDirectionButton(const Offset(-1, -1), '↖'),
                      _buildDirectionButton(const Offset(0, -1), '↑'),
                      _buildDirectionButton(const Offset(1, -1), '↗'),
                    ],
                  ),
                  // Middle row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDirectionButton(const Offset(-1, 0), '←'),
                      _buildDirectionButton(Offset.zero, '●'),
                      _buildDirectionButton(const Offset(1, 0), '→'),
                    ],
                  ),
                  // Bottom row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDirectionButton(const Offset(-1, 1), '↙'),
                      _buildDirectionButton(const Offset(0, 1), '↓'),
                      _buildDirectionButton(const Offset(1, 1), '↘'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            
            // Preset offsets
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() { _directionOffset = const Offset(0.5, 0); });
                    print('Half right offset');
                  },
                  child: const Text('(0.5, 0)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() { _directionOffset = const Offset(2, 0); });
                    print('Double right offset');
                  },
                  child: const Text('(2, 0)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() { _directionOffset = const Offset(-0.5, 0.5); });
                    print('Diagonal offset');
                  },
                  child: const Text('(-0.5, 0.5)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionButton(Offset offset, String label) {
    final isSelected = _directionOffset == offset;
    return Container(
      margin: const EdgeInsets.all(2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          minimumSize: const Size(48, 48),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          setState(() { _directionOffset = offset; });
          print('Direction: (${offset.dx}, ${offset.dy})');
        },
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationSection() {
    print('=== Section 3: Duration Control ===');
    print('Selected duration: ${_selectedDuration.inMilliseconds}ms');
    print('Duration offset: $_durationOffset');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Duration controls the animation speed. '
              'Fast slides feel snappy, slow slides feel smooth.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 150,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedSlide(
                  offset: _durationOffset,
                  duration: _selectedDuration,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '${_selectedDuration.inMilliseconds}ms',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
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
                      setState(() { _selectedDuration = duration; });
                      print('Duration: ${duration.inMilliseconds}ms');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() { _durationOffset = const Offset(-1, 0); });
                    print('Duration demo: slide left');
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Left'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() { _durationOffset = Offset.zero; });
                    print('Duration demo: center');
                  },
                  icon: const Icon(Icons.center_focus_strong),
                  label: const Text('Center'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() { _durationOffset = const Offset(1, 0); });
                    print('Duration demo: slide right');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Right'),
                ),
              ],
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
    print('Curve offset: $_curveOffset');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Curves control animation easing. BounceOut creates a '
              'playful bounce, elasticOut adds spring effect.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 150,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedSlide(
                  offset: _curveOffset,
                  duration: const Duration(milliseconds: 800),
                  curve: _selectedCurve,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.animation, color: Colors.white, size: 28),
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
                          print('Curve: ${_curves[index].key}');
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() { _curveOffset = const Offset(-1, 0); });
                    print('Curve demo: left with ${_curves[_curveIndex].key}');
                  },
                  icon: const Icon(Icons.west),
                  label: const Text('Left'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade300),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() { _curveOffset = Offset.zero; });
                    print('Curve demo: center with ${_curves[_curveIndex].key}');
                  },
                  icon: const Icon(Icons.crop_free),
                  label: const Text('Center'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() { _curveOffset = const Offset(1, 0); });
                    print('Curve demo: right with ${_curves[_curveIndex].key}');
                  },
                  icon: const Icon(Icons.east),
                  label: const Text('Right'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Fractional Offset System
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFractionalOffsetSection() {
    print('=== Section 5: Fractional Offset System ===');
    print('X offset: $_xOffset, Y offset: $_yOffset');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Offsets are relative to the widget\'s size. '
              '1.0 = 100% of the widget\'s dimension.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 200,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Grid
                  Positioned.fill(
                    child: CustomPaint(painter: _FractionalGridPainter()),
                  ),
                  Center(
                    child: AnimatedSlide(
                      offset: Offset(_xOffset, _yOffset),
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber.shade700,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.crop_square, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // X offset slider
            Row(
              children: [
                const SizedBox(width: 80, child: Text('X Offset:')),
                Expanded(
                  child: Slider(
                    value: _xOffset,
                    min: -2,
                    max: 2,
                    divisions: 40,
                    label: _xOffset.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() { _xOffset = value; });
                      print('X offset: $value');
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(_xOffset.toStringAsFixed(2)),
                ),
              ],
            ),
            
            // Y offset slider
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Y Offset:')),
                Expanded(
                  child: Slider(
                    value: _yOffset,
                    min: -2,
                    max: 2,
                    divisions: 40,
                    label: _yOffset.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() { _yOffset = value; });
                      print('Y offset: $value');
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(_yOffset.toStringAsFixed(2)),
                ),
              ],
            ),
            
            // Quick presets
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() { _xOffset = 0; _yOffset = 0; });
                    print('Reset offsets');
                  },
                  child: const Text('Reset (0, 0)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() { _xOffset = 0.5; _yOffset = 0.5; });
                    print('Half right-down');
                  },
                  child: const Text('(0.5, 0.5)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() { _xOffset = -1.5; _yOffset = 0; });
                    print('Off-screen left');
                  },
                  child: const Text('(-1.5, 0)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== Section 6: Practical Use Cases ===');
    print('Drawer open: $_drawerOpen');
    print('Notification visible: $_notificationVisible');
    print('Menu expanded: $_menuExpanded');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common use cases for AnimatedSlide in real applications.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            
            // Use Case 1: Side Drawer
            const Text('1. Side Drawer / Panel', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 120,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Main content
                  Positioned.fill(
                    child: Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Text('Main Content'),
                      ),
                    ),
                  ),
                  // Drawer
                  AnimatedSlide(
                    offset: _drawerOpen ? Offset.zero : const Offset(-1, 0),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: Container(
                      width: 150,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(2, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.menu, color: Colors.white),
                          Text('Drawer', style: TextStyle(color: Colors.white)),
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
                setState(() { _drawerOpen = !_drawerOpen; });
                print('Drawer: ${_drawerOpen ? 'opened' : 'closed'}');
              },
              child: Text(_drawerOpen ? 'Close Drawer' : 'Open Drawer'),
            ),
            const SizedBox(height: 24),
            
            // Use Case 2: Toast Notification
            const Text('2. Toast Notification', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedSlide(
                        offset: _notificationVisible ? Offset.zero : const Offset(0, -2),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 4),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.check_circle, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Success!', style: TextStyle(color: Colors.white)),
                            ],
                          ),
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
                setState(() { _notificationVisible = !_notificationVisible; });
                print('Notification: ${_notificationVisible ? 'shown' : 'hidden'}');
              },
              child: Text(_notificationVisible ? 'Hide' : 'Show Notification'),
            ),
            const SizedBox(height: 24),
            
            // Use Case 3: Staggered Menu Items
            const Text('3. Staggered Menu', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 130,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedSlide(
                    offset: _menuItemOffset1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: _buildMenuItem('Home', Icons.home),
                  ),
                  AnimatedSlide(
                    offset: _menuItemOffset2,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: _buildMenuItem('Settings', Icons.settings),
                  ),
                  AnimatedSlide(
                    offset: _menuItemOffset3,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: _buildMenuItem('Profile', Icons.person),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _toggleMenu();
              },
              child: Text(_menuExpanded ? 'Collapse Menu' : 'Expand Menu'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade600,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  void _toggleMenu() async {
    setState(() { _menuExpanded = !_menuExpanded; });
    print('Menu: ${_menuExpanded ? 'expanding' : 'collapsing'}');
    
    if (_menuExpanded) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() { _menuItemOffset1 = Offset.zero; });
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() { _menuItemOffset2 = Offset.zero; });
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() { _menuItemOffset3 = Offset.zero; });
    } else {
      setState(() { _menuItemOffset3 = const Offset(-1, 0); });
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() { _menuItemOffset2 = const Offset(-1, 0); });
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() { _menuItemOffset1 = const Offset(-1, 0); });
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Sequential and Staggered Animations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSequentialAnimationsSection() {
    print('=== Section 7: Sequential and Staggered Animations ===');
    print('Stack animating: $_stackAnimating');
    print('Stack offsets: $_stackOffsets');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedSlide can be chained with delays for '
              'staggered reveal animations.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Staggered cards
            Container(
              height: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(4, (index) {
                  final colors = [Colors.red, Colors.orange, Colors.green, Colors.blue];
                  return AnimatedSlide(
                    offset: _stackOffsets[index],
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: Container(
                      width: 60,
                      height: 80,
                      decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: colors[index].withValues(alpha: 0.4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _stackAnimating ? null : () {
                    _animateStackIn();
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Slide In'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _stackAnimating ? null : () {
                    _animateStackOut();
                  },
                  icon: const Icon(Icons.replay),
                  label: const Text('Slide Out'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Each card slides in with a 100ms delay',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _animateStackIn() async {
    setState(() { _stackAnimating = true; });
    print('Stack: animating in');
    
    for (int i = 0; i < 4; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _stackOffsets[i] = Offset.zero;
      });
      print('Card ${i + 1}: slid in');
    }
    
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() { _stackAnimating = false; });
  }

  void _animateStackOut() async {
    setState(() { _stackAnimating = true; });
    print('Stack: animating out');
    
    for (int i = 3; i >= 0; i--) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _stackOffsets[i] = const Offset(1, 0);
      });
      print('Card ${i + 1}: slid out');
    }
    
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() { _stackAnimating = false; });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Combined Animations and Edge Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCombinedAnimationsSection() {
    print('=== Section 8: Combined Animations and Edge Cases ===');
    print('Combined offset: $_combinedOffset');
    print('Combined scale: $_combinedScale');
    print('Combined opacity: $_combinedOpacity');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Combining AnimatedSlide with other animated widgets.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Combined animations demo
            const Text('Slide + Scale + Opacity', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade100, Colors.orange.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedSlide(
                  offset: _combinedOffset,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedScale(
                    scale: _combinedScale,
                    duration: const Duration(milliseconds: 400),
                    child: AnimatedOpacity(
                      opacity: _combinedOpacity,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.pink, Colors.deepOrange],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.star, color: Colors.white),
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
                const SizedBox(width: 60, child: Text('Slide X:')),
                Expanded(
                  child: Slider(
                    value: _combinedOffset.dx,
                    min: -1,
                    max: 1,
                    onChanged: (value) {
                      setState(() { _combinedOffset = Offset(value, _combinedOffset.dy); });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 60, child: Text('Slide Y:')),
                Expanded(
                  child: Slider(
                    value: _combinedOffset.dy,
                    min: -1,
                    max: 1,
                    onChanged: (value) {
                      setState(() { _combinedOffset = Offset(_combinedOffset.dx, value); });
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
                    onChanged: (value) {
                      setState(() { _combinedScale = value; });
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
                    onChanged: (value) {
                      setState(() { _combinedOpacity = value; });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Edge cases
            const Text('Edge Cases:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEdgeCaseItem('Large offsets', 'Widget moves off-screen (use ClipRect)'),
            _buildEdgeCaseItem('Zero offset', 'Widget at original position'),
            _buildEdgeCaseItem('Same offset', 'No animation triggered'),
            _buildEdgeCaseItem('Duration 0', 'Instant position change'),
            _buildEdgeCaseItem('Nested AnimatedSlide', 'Offsets stack additively'),
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

// Crosshair painter for center reference
class _CrosshairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    
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
    
    // Center dot
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      3,
      paint..color = Colors.grey,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Grid painter for fractional offset visualization
class _FractionalGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber.shade200
      ..strokeWidth = 1;
    
    // Draw grid lines
    for (int i = 1; i <= 4; i++) {
      double x = size.width * i / 5;
      double y = size.height * i / 5;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint..color = Colors.amber.shade200);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    
    // Center lines emphasized
    paint.strokeWidth = 2;
    paint.color = Colors.amber.shade400;
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
