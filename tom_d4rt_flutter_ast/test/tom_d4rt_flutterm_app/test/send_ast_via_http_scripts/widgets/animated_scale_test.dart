// ignore_for_file: avoid_print
// Deep demo: AnimatedScale - Implicit animation for scale transitions
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedScaleDemo(),
  );
}

class AnimatedScaleDemo extends StatefulWidget {
  const AnimatedScaleDemo({super.key});

  @override
  State<AnimatedScaleDemo> createState() => _AnimatedScaleDemoState();
}

class _AnimatedScaleDemoState extends State<AnimatedScaleDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Scale Animation Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  double _basicScale = 1.0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Scale Value Ranges
  // ═══════════════════════════════════════════════════════════════════════════
  double _rangeScale = 1.0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  double _durationScale = 1.0;
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
  double _curveScale = 1.0;
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
  double _alignScale = 1.0;
  Alignment _scaleAlignment = Alignment.center;
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
  double _qualityScale = 1.0;
  FilterQuality _filterQuality = FilterQuality.low;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _buttonPressed = false;
  bool _isHovered = false;
  bool _showAttention = false;
  double _attentionScale = 1.0;
  int _selectedCardIndex = -1;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Combined Animations and Edge Cases
  // ═══════════════════════════════════════════════════════════════════════════
  double _combinedScale = 1.0;
  double _combinedRotation = 0.0;
  double _combinedOpacity = 1.0;
  bool _pulseActive = false;
  double _pulseScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedScale Deep Demo'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Scale Animation Fundamentals
            _buildSectionHeader('1. Basic Scale Animation Fundamentals'),
            _buildBasicScaleSection(),
            const SizedBox(height: 32),
            
            // Section 2: Scale Value Ranges
            _buildSectionHeader('2. Scale Value Ranges'),
            _buildScaleRangesSection(),
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
  // SECTION 1: Basic Scale Animation Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicScaleSection() {
    print('=== Section 1: Basic Scale Animation Fundamentals ===');
    print('Current scale: $_basicScale');
    print('Scale 1.0 = original size, 0.5 = half, 2.0 = double');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedScale smoothly animates scale transitions. '
              '1.0 is the original size, values < 1 shrink, values > 1 enlarge.',
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
                child: AnimatedScale(
                  scale: _basicScale,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.zoom_out_map, color: Colors.white, size: 32),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Scale value display
            Text(
              'Scale: ${_basicScale.toStringAsFixed(2)}x',
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
                    setState(() { _basicScale = 0.5; });
                    print('Basic scale: 0.5x (half size)');
                  },
                  child: const Text('0.5x'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicScale = 0.75; });
                    print('Basic scale: 0.75x');
                  },
                  child: const Text('0.75x'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicScale = 1.0; });
                    print('Basic scale: 1.0x (original)');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                  child: const Text('1.0x', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicScale = 1.25; });
                    print('Basic scale: 1.25x');
                  },
                  child: const Text('1.25x'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicScale = 1.5; });
                    print('Basic scale: 1.5x (50% larger)');
                  },
                  child: const Text('1.5x'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _basicScale = 2.0; });
                    print('Basic scale: 2.0x (double size)');
                  },
                  child: const Text('2.0x'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Scale Value Ranges
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildScaleRangesSection() {
    print('=== Section 2: Scale Value Ranges ===');
    print('Range scale: $_rangeScale');
    print('0 = invisible, negative = mirrored (not recommended)');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scale can range from 0 (invisible) to any positive value. '
              'Use the slider to explore different scale values.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedScale(
                  scale: _rangeScale,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${(_rangeScale * 100).round()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Scale slider
            Row(
              children: [
                const Text('Scale: '),
                Expanded(
                  child: Slider(
                    value: _rangeScale,
                    min: 0,
                    max: 3,
                    divisions: 30,
                    label: _rangeScale.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() { _rangeScale = value; });
                      print('Range scale: $value');
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(_rangeScale.toStringAsFixed(2)),
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
                    setState(() { _rangeScale = 0; });
                    print('Range scale: 0 (invisible)');
                  },
                  child: const Text('0 (invisible)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() { _rangeScale = 0.1; });
                    print('Range scale: 0.1 (tiny)');
                  },
                  child: const Text('0.1 (tiny)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() { _rangeScale = 1.0; });
                    print('Range scale: 1.0 (normal)');
                  },
                  child: const Text('1.0 (normal)'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() { _rangeScale = 3.0; });
                    print('Range scale: 3.0 (large)');
                  },
                  child: const Text('3.0 (large)'),
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
    print('Duration scale: $_durationScale');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Duration controls the animation speed. Short durations '
              'feel snappy, longer durations feel smooth and intentional.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedScale(
                  scale: _durationScale,
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
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _durationScale = _durationScale == 1.0 ? 1.5 : 1.0;
                });
                print('Duration demo scale: $_durationScale');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Toggle Scale'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
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
    print('Curve scale: $_curveScale');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Curves control animation easing. BounceOut and elasticOut '
              'are particularly effective for scale animations.',
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
                child: AnimatedScale(
                  scale: _curveScale,
                  duration: const Duration(milliseconds: 600),
                  curve: _selectedCurve,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_fix_high, color: Colors.white, size: 28),
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
                    setState(() { _curveScale = 0.5; });
                    print('Curve demo: scale down with ${_curves[_curveIndex].key}');
                  },
                  icon: const Icon(Icons.zoom_in_map),
                  label: const Text('Shrink'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade300),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() { _curveScale = 1.0; });
                    print('Curve demo: normal with ${_curves[_curveIndex].key}');
                  },
                  icon: const Icon(Icons.crop_free),
                  label: const Text('Normal'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() { _curveScale = 1.5; });
                    print('Curve demo: scale up with ${_curves[_curveIndex].key}');
                  },
                  icon: const Icon(Icons.zoom_out_map),
                  label: const Text('Grow'),
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
  // SECTION 5: Alignment and Transform Origin
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAlignmentSection() {
    print('=== Section 5: Alignment and Transform Origin ===');
    print('Alignment index: $_alignmentIndex');
    print('Alignment: ${_alignmentNames[_alignmentIndex]}');
    print('Align scale: $_alignScale');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alignment determines the anchor point for scaling. '
              'Center scales uniformly, corners scale from that corner.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container with origin indicator
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Grid reference
                  Positioned.fill(
                    child: CustomPaint(painter: _GridPainter()),
                  ),
                  Center(
                    child: AnimatedScale(
                      scale: _alignScale,
                      duration: const Duration(milliseconds: 400),
                      alignment: _scaleAlignment,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.amber.shade700,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.fullscreen, color: Colors.white, size: 32),
                          ),
                          // Anchor point indicator
                          Positioned(
                            left: 40 + (_scaleAlignment.x * 40) - 6,
                            top: 40 + (_scaleAlignment.y * 40) - 6,
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
            const Text('Scale Origin:', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    backgroundColor: isSelected ? Colors.amber.shade700 : Colors.grey.shade300,
                    foregroundColor: isSelected ? Colors.white : Colors.black87,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    setState(() {
                      _alignmentIndex = index;
                      _scaleAlignment = _alignments[index];
                    });
                    print('Alignment: ${_alignmentNames[index]}');
                  },
                  child: Text(_alignmentNames[index], style: const TextStyle(fontSize: 9)),
                );
              },
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _alignScale = _alignScale == 1.0 ? 1.5 : 1.0;
                });
                print('Alignment demo: scale $_alignScale from ${_alignmentNames[_alignmentIndex]}');
              },
              icon: const Icon(Icons.aspect_ratio),
              label: const Text('Toggle Scale'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade700,
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
    print('Quality scale: $_qualityScale');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FilterQuality affects rendering during scale. '
              'Higher quality shows smoother edges when scaled up.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Demo container
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedScale(
                  scale: _qualityScale,
                  duration: const Duration(milliseconds: 300),
                  filterQuality: _filterQuality,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.cyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Hi-Q',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
              children: FilterQuality.values.map((quality) {
                final isSelected = _filterQuality == quality;
                return ChoiceChip(
                  label: Text(quality.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() { _filterQuality = quality; });
                      print('Filter quality: ${quality.name}');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() { _qualityScale = 1.0; });
                    print('Quality demo: 1.0x');
                  },
                  child: const Text('1x'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _qualityScale = 2.0; });
                    print('Quality demo: 2.0x (scaled up)');
                  },
                  child: const Text('2x'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _qualityScale = 3.0; });
                    print('Quality demo: 3.0x (observe quality)');
                  },
                  child: const Text('3x'),
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
    print('Button pressed: $_buttonPressed');
    print('Is hovered: $_isHovered');
    print('Show attention: $_showAttention');
    print('Selected card: $_selectedCardIndex');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common use cases for AnimatedScale in real applications.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            
            // Use Case 1: Button Press Effect
            const Text('1. Button Press Effect', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GestureDetector(
              onTapDown: (_) {
                setState(() { _buttonPressed = true; });
                print('Button pressed down');
              },
              onTapUp: (_) {
                setState(() { _buttonPressed = false; });
                print('Button released');
              },
              onTapCancel: () {
                setState(() { _buttonPressed = false; });
                print('Button tap cancelled');
              },
              child: AnimatedScale(
                scale: _buttonPressed ? 0.95 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.4),
                        blurRadius: _buttonPressed ? 4 : 8,
                        offset: Offset(0, _buttonPressed ? 2 : 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Press Me',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Use Case 2: Hover Effect
            const Text('2. Hover/Focus Effect', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            MouseRegion(
              onEnter: (_) {
                setState(() { _isHovered = true; });
                print('Hover entered');
              },
              onExit: (_) {
                setState(() { _isHovered = false; });
                print('Hover exited');
              },
              child: AnimatedScale(
                scale: _isHovered ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _isHovered ? Colors.green : Colors.green.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('Hover Me', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Use Case 3: Attention Animation
            const Text('3. Attention Animation', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                AnimatedScale(
                  scale: _attentionScale,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  onEnd: () {
                    if (_showAttention) {
                      setState(() {
                        _attentionScale = _attentionScale == 1.0 ? 1.15 : 1.0;
                      });
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.4),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showAttention = !_showAttention;
                      if (_showAttention) {
                        _attentionScale = 1.15;
                      } else {
                        _attentionScale = 1.0;
                      }
                    });
                    print('Attention: $_showAttention');
                  },
                  child: Text(_showAttention ? 'Stop' : 'Pulse'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Use Case 4: Card Selection
            const Text('4. Card Selection', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                final isSelected = _selectedCardIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCardIndex = isSelected ? -1 : index;
                    });
                    print('Card ${index + 1} ${isSelected ? 'deselected' : 'selected'}');
                  },
                  child: AnimatedScale(
                    scale: isSelected ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: Container(
                      width: 80,
                      height: 100,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.indigo : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: Colors.indigo.shade700, width: 3)
                            : null,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: isSelected ? Colors.white : Colors.grey.shade600,
                            ),
                            Text(
                              'Card ${index + 1}',
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey.shade700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
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
    print('Combined scale: $_combinedScale');
    print('Combined rotation: $_combinedRotation');
    print('Combined opacity: $_combinedOpacity');
    print('Pulse active: $_pulseActive');
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Combining AnimatedScale with other animated widgets.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Combined animations demo
            const Text('Scale + Rotation + Opacity', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade100, Colors.orange.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedScale(
                  scale: _combinedScale,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedRotation(
                    turns: _combinedRotation,
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
                        child: const Icon(Icons.auto_awesome, color: Colors.white),
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
                const SizedBox(width: 60, child: Text('Rotate:')),
                Expanded(
                  child: Slider(
                    value: _combinedRotation,
                    min: 0,
                    max: 2,
                    onChanged: (value) {
                      setState(() { _combinedRotation = value; });
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
            
            // Continuous pulse
            const Text('Continuous Pulse Animation', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                AnimatedScale(
                  scale: _pulseScale,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  onEnd: () {
                    if (_pulseActive) {
                      setState(() {
                        _pulseScale = _pulseScale == 1.0 ? 1.2 : 1.0;
                      });
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withValues(alpha: 0.4),
                          blurRadius: _pulseScale > 1 ? 16 : 8,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.favorite, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _pulseActive = !_pulseActive;
                      if (_pulseActive) {
                        _pulseScale = 1.2;
                      } else {
                        _pulseScale = 1.0;
                      }
                    });
                    print('Pulse: ${_pulseActive ? 'started' : 'stopped'}');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: Text(_pulseActive ? 'Stop' : 'Start', style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Edge cases
            const Text('Edge Cases:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEdgeCaseItem('Scale 0', 'Widget becomes invisible but still occupies space'),
            _buildEdgeCaseItem('Negative scale', 'Results in mirroring (not recommended)'),
            _buildEdgeCaseItem('Very large scale', 'May cause overflow - use ClipRect'),
            _buildEdgeCaseItem('Same scale value', 'No animation triggered'),
            _buildEdgeCaseItem('Duration 0', 'Instant scale change'),
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
              color: Colors.deepOrange,
            ),
          ),
          const Divider(thickness: 2, color: Colors.deepOrange),
        ],
      ),
    );
  }
}

// Grid painter for reference
class _GridPainter extends CustomPainter {
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
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
