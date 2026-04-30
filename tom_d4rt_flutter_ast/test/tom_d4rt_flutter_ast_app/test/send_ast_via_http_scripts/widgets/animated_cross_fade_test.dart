// ignore_for_file: avoid_print
// Deep demo: AnimatedCrossFade - Cross-fading animation between two children
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedCrossFadeDemo(),
  );
}

class AnimatedCrossFadeDemo extends StatefulWidget {
  const AnimatedCrossFadeDemo({super.key});

  @override
  State<AnimatedCrossFadeDemo> createState() => _AnimatedCrossFadeDemoState();
}

class _AnimatedCrossFadeDemoState extends State<AnimatedCrossFadeDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Cross-Fade Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  CrossFadeState _basicState = CrossFadeState.showFirst;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Duration Variations
  // ═══════════════════════════════════════════════════════════════════════════
  CrossFadeState _durationState = CrossFadeState.showFirst;
  Duration _selectedDuration = const Duration(milliseconds: 300);
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Curve Configurations
  // ═══════════════════════════════════════════════════════════════════════════
  CrossFadeState _curveState = CrossFadeState.showFirst;
  Curve _firstCurve = Curves.easeIn;
  Curve _secondCurve = Curves.easeOut;
  Curve _sizeCurve = Curves.linear;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Layout Builder Customization
  // ═══════════════════════════════════════════════════════════════════════════
  CrossFadeState _layoutState = CrossFadeState.showFirst;
  int _layoutBuilderType = 0;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Alignment Variations
  // ═══════════════════════════════════════════════════════════════════════════
  CrossFadeState _alignState = CrossFadeState.showFirst;
  AlignmentGeometry _alignment = Alignment.center;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Size Differences
  // ═══════════════════════════════════════════════════════════════════════════
  CrossFadeState _sizeState = CrossFadeState.showFirst;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _isExpanded = false;
  bool _isLoading = true;
  bool _showDetails = false;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Chained Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  int _chainedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCrossFade Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Cross-Fade Fundamentals
            _buildSectionHeader('1. Basic Cross-Fade Fundamentals'),
            _buildBasicCrossFadeSection(),
            const SizedBox(height: 32),
            
            // Section 2: Duration Variations
            _buildSectionHeader('2. Duration Variations'),
            _buildDurationSection(),
            const SizedBox(height: 32),
            
            // Section 3: Curve Configurations
            _buildSectionHeader('3. Curve Configurations'),
            _buildCurvesSection(),
            const SizedBox(height: 32),
            
            // Section 4: Layout Builder Customization
            _buildSectionHeader('4. Layout Builder Customization'),
            _buildLayoutBuilderSection(),
            const SizedBox(height: 32),
            
            // Section 5: Alignment Variations
            _buildSectionHeader('5. Alignment Variations'),
            _buildAlignmentSection(),
            const SizedBox(height: 32),
            
            // Section 6: Size Differences
            _buildSectionHeader('6. Size Differences'),
            _buildSizeDifferenceSection(),
            const SizedBox(height: 32),
            
            // Section 7: Practical Use Cases
            _buildSectionHeader('7. Practical Use Cases'),
            _buildPracticalUseCasesSection(),
            const SizedBox(height: 32),
            
            // Section 8: Chained Transitions
            _buildSectionHeader('8. Chained Transitions'),
            _buildChainedSection(),
            const SizedBox(height: 32),
            
            // API Reference
            _buildSectionHeader('API Reference'),
            _buildApiReference(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Cross-Fade Implementation
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicCrossFadeSection() {
    print('=== SECTION 1: Basic Cross-Fade Fundamentals ===');
    print('AnimatedCrossFade animates between firstChild and secondChild');
    print('Uses CrossFadeState enum to determine which child to show');
    print('Current state: $_basicState');
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic cross-fade between two widgets:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Basic cross-fade display
            Center(
              child: AnimatedCrossFade(
                firstChild: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.looks_one, size: 36, color: Colors.blue),
                        Text('First Child', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
                secondChild: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.looks_two, size: 36, color: Colors.orange),
                        Text('Second Child', style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ),
                ),
                crossFadeState: _basicState,
                duration: const Duration(milliseconds: 400),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Toggle button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _basicState = _basicState == CrossFadeState.showFirst
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst;
                  });
                  print('Toggled to: $_basicState');
                },
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Toggle Cross-Fade'),
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'CrossFadeState: ${_basicState == CrossFadeState.showFirst ? "showFirst" : "showSecond"}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            
            print('Basic cross-fade rendered successfully'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Duration Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationSection() {
    print('=== SECTION 2: Duration Variations ===');
    print('Duration controls how long the cross-fade animation takes');
    print('Selected duration: ${_selectedDuration.inMilliseconds}ms');
    
    final durations = [
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 600),
      const Duration(milliseconds: 1000),
      const Duration(milliseconds: 2000),
    ];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adjust animation duration:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            // Duration selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: durations.map((duration) {
                final isSelected = duration == _selectedDuration;
                return ChoiceChip(
                  label: Text('${duration.inMilliseconds}ms'),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedDuration = duration);
                      print('Duration changed to: ${duration.inMilliseconds}ms');
                    }
                  },
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Cross-fade with selected duration
            Center(
              child: AnimatedCrossFade(
                firstChild: _buildDurationChild(
                  Icons.brightness_7,
                  Colors.amber,
                  'Day Mode',
                ),
                secondChild: _buildDurationChild(
                  Icons.brightness_2,
                  Colors.indigo,
                  'Night Mode',
                ),
                crossFadeState: _durationState,
                duration: _selectedDuration,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _durationState = _durationState == CrossFadeState.showFirst
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst;
                  });
                  print('Duration demo toggled with ${_selectedDuration.inMilliseconds}ms duration');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play Animation'),
              ),
            ),
            
            print('Duration section rendered with ${_selectedDuration.inMilliseconds}ms'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
  
  Widget _buildDurationChild(IconData icon, Color color, String label) {
    return Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: color),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Curve Configurations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCurvesSection() {
    print('=== SECTION 3: Curve Configurations ===');
    print('AnimatedCrossFade supports three curves:');
    print('  - firstCurve: Controls fade-out of first child');
    print('  - secondCurve: Controls fade-in of second child');
    print('  - sizeCurve: Controls size animation between children');
    
    final curves = <String, Curve>{
      'linear': Curves.linear,
      'easeIn': Curves.easeIn,
      'easeOut': Curves.easeOut,
      'easeInOut': Curves.easeInOut,
      'bounceIn': Curves.bounceIn,
      'bounceOut': Curves.bounceOut,
      'elasticIn': Curves.elasticIn,
      'elasticOut': Curves.elasticOut,
    };
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configure animation curves:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            // First curve selector
            _buildCurveSelector('First Curve (fade-out):', curves, _firstCurve, (curve) {
              setState(() => _firstCurve = curve);
              print('First curve changed to: ${curves.entries.firstWhere((e) => e.value == curve).key}');
            }),
            
            const SizedBox(height: 8),
            
            // Second curve selector
            _buildCurveSelector('Second Curve (fade-in):', curves, _secondCurve, (curve) {
              setState(() => _secondCurve = curve);
              print('Second curve changed to: ${curves.entries.firstWhere((e) => e.value == curve).key}');
            }),
            
            const SizedBox(height: 8),
            
            // Size curve selector
            _buildCurveSelector('Size Curve:', curves, _sizeCurve, (curve) {
              setState(() => _sizeCurve = curve);
              print('Size curve changed to: ${curves.entries.firstWhere((e) => e.value == curve).key}');
            }),
            
            const SizedBox(height: 16),
            
            // Cross-fade with curves
            Center(
              child: AnimatedCrossFade(
                firstChild: _buildCurveChild(Colors.purple, 'A', 100),
                secondChild: _buildCurveChild(Colors.teal, 'B', 140),
                crossFadeState: _curveState,
                duration: const Duration(milliseconds: 800),
                firstCurve: _firstCurve,
                secondCurve: _secondCurve,
                sizeCurve: _sizeCurve,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _curveState = _curveState == CrossFadeState.showFirst
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst;
                  });
                  print('Curves demo toggled');
                },
                icon: const Icon(Icons.timeline),
                label: const Text('Test Curves'),
              ),
            ),
            
            print('Curves section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
  
  Widget _buildCurveSelector(String label, Map<String, Curve> curves, Curve selected, ValueChanged<Curve> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: curves.entries.map((entry) {
              final isSelected = entry.value == selected;
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: FilterChip(
                  label: Text(entry.key, style: const TextStyle(fontSize: 11)),
                  selected: isSelected,
                  onSelected: (_) => onChanged(entry.value),
                  visualDensity: VisualDensity.compact,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCurveChild(Color color, String label, double height) {
    return Container(
      width: 160,
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Layout Builder Customization
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLayoutBuilderSection() {
    print('=== SECTION 4: Layout Builder Customization ===');
    print('layoutBuilder controls how children are positioned during transition');
    print('Default stacks children; custom builders allow different layouts');
    print('Current layout type: $_layoutBuilderType');
    
    // Different layout builders
    Widget Function(Widget, Key, Widget, Key) layoutBuilder;
    String layoutDescription;
    
    switch (_layoutBuilderType) {
      case 0:
        layoutBuilder = AnimatedCrossFade.defaultLayoutBuilder;
        layoutDescription = 'Default (Stack)';
        break;
      case 1:
        layoutBuilder = (topChild, topKey, bottomChild, bottomKey) {
          return Stack(
            alignment: Alignment.topLeft,
            children: [
              Positioned(key: bottomKey, child: bottomChild),
              Positioned(key: topKey, child: topChild),
            ],
          );
        };
        layoutDescription = 'Top-Left Aligned';
        break;
      case 2:
        layoutBuilder = (topChild, topKey, bottomChild, bottomKey) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              Positioned(key: bottomKey, child: bottomChild),
              Positioned(key: topKey, child: topChild),
            ],
          );
        };
        layoutDescription = 'Bottom-Right Aligned';
        break;
      default:
        layoutBuilder = (topChild, topKey, bottomChild, bottomKey) {
          return Stack(
            children: [
              Positioned.fill(key: bottomKey, child: bottomChild),
              Positioned.fill(key: topKey, child: topChild),
            ],
          );
        };
        layoutDescription = 'Fill Positioned';
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom layout builders:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            // Layout type selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Default'),
                  selected: _layoutBuilderType == 0,
                  onSelected: (_) {
                    setState(() => _layoutBuilderType = 0);
                    print('Layout builder: Default');
                  },
                ),
                ChoiceChip(
                  label: const Text('Top-Left'),
                  selected: _layoutBuilderType == 1,
                  onSelected: (_) {
                    setState(() => _layoutBuilderType = 1);
                    print('Layout builder: Top-Left');
                  },
                ),
                ChoiceChip(
                  label: const Text('Bottom-Right'),
                  selected: _layoutBuilderType == 2,
                  onSelected: (_) {
                    setState(() => _layoutBuilderType = 2);
                    print('Layout builder: Bottom-Right');
                  },
                ),
                ChoiceChip(
                  label: const Text('Fill'),
                  selected: _layoutBuilderType == 3,
                  onSelected: (_) {
                    setState(() => _layoutBuilderType = 3);
                    print('Layout builder: Fill');
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            Text('Current: $layoutDescription', style: const TextStyle(fontStyle: FontStyle.italic)),
            
            const SizedBox(height: 16),
            
            // Cross-fade with custom layout
            SizedBox(
              height: 140,
              child: Center(
                child: AnimatedCrossFade(
                  firstChild: Container(
                    width: 100,
                    height: 80,
                    color: Colors.red.shade200,
                    child: const Center(child: Text('Small', style: TextStyle(color: Colors.red))),
                  ),
                  secondChild: Container(
                    width: 160,
                    height: 120,
                    color: Colors.green.shade200,
                    child: const Center(child: Text('Large', style: TextStyle(color: Colors.green))),
                  ),
                  crossFadeState: _layoutState,
                  duration: const Duration(milliseconds: 500),
                  layoutBuilder: layoutBuilder,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _layoutState = _layoutState == CrossFadeState.showFirst
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst;
                  });
                  print('Layout demo toggled with: $layoutDescription');
                },
                icon: const Icon(Icons.grid_view),
                label: const Text('Toggle Layout'),
              ),
            ),
            
            print('Layout builder section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Alignment Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAlignmentSection() {
    print('=== SECTION 5: Alignment Variations ===');
    print('alignment property controls positioning during size transition');
    print('Current alignment: $_alignment');
    
    final alignments = <String, AlignmentGeometry>{
      'topLeft': Alignment.topLeft,
      'topCenter': Alignment.topCenter,
      'topRight': Alignment.topRight,
      'centerLeft': Alignment.centerLeft,
      'center': Alignment.center,
      'centerRight': Alignment.centerRight,
      'bottomLeft': Alignment.bottomLeft,
      'bottomCenter': Alignment.bottomCenter,
      'bottomRight': Alignment.bottomRight,
    };
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alignment during size transition:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            // Alignment selector grid
            SizedBox(
              height: 120,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                physics: const NeverScrollableScrollPhysics(),
                children: alignments.entries.map((entry) {
                  final isSelected = entry.value == _alignment;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _alignment = entry.value);
                      print('Alignment changed to: ${entry.key}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.indigo.shade100 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isSelected ? Colors.indigo : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          entry.key.replaceAll('center', 'ctr').replaceAll('bottom', 'btm').replaceAll('Left', 'L').replaceAll('Right', 'R'),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.indigo : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Cross-fade with alignment
            Container(
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AnimatedCrossFade(
                firstChild: Container(
                  width: 60,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('S', style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                secondChild: Container(
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('LARGE', style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                crossFadeState: _alignState,
                duration: const Duration(milliseconds: 600),
                alignment: _alignment,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _alignState = _alignState == CrossFadeState.showFirst
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst;
                  });
                  print('Alignment demo toggled with alignment: $_alignment');
                },
                icon: const Icon(Icons.aspect_ratio),
                label: const Text('Toggle Size'),
              ),
            ),
            
            print('Alignment section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Size Differences
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSizeDifferenceSection() {
    print('=== SECTION 6: Size Differences ===');
    print('AnimatedCrossFade handles different-sized children automatically');
    print('Size transition uses sizeCurve property');
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Handling different child sizes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Extreme size difference
            Row(
              children: [
                const Text('Extreme: '),
                Expanded(
                  child: Center(
                    child: AnimatedCrossFade(
                      firstChild: Container(
                        width: 40,
                        height: 30,
                        color: Colors.red,
                        child: const Center(child: Text('XS', style: TextStyle(color: Colors.white, fontSize: 10))),
                      ),
                      secondChild: Container(
                        width: 200,
                        height: 80,
                        color: Colors.blue,
                        child: const Center(child: Text('Extra Large Container', style: TextStyle(color: Colors.white))),
                      ),
                      crossFadeState: _sizeState,
                      duration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Height only difference
            Row(
              children: [
                const Text('Height: '),
                Expanded(
                  child: Center(
                    child: AnimatedCrossFade(
                      firstChild: Container(
                        width: 150,
                        height: 30,
                        color: Colors.green,
                        child: const Center(child: Text('Short', style: TextStyle(color: Colors.white))),
                      ),
                      secondChild: Container(
                        width: 150,
                        height: 100,
                        color: Colors.teal,
                        child: const Center(child: Text('Tall\nContent\nHere', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))),
                      ),
                      crossFadeState: _sizeState,
                      duration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Width only difference
            Row(
              children: [
                const Text('Width: '),
                Expanded(
                  child: Center(
                    child: AnimatedCrossFade(
                      firstChild: Container(
                        width: 60,
                        height: 60,
                        color: Colors.purple,
                        child: const Center(child: Text('N', style: TextStyle(color: Colors.white, fontSize: 20))),
                      ),
                      secondChild: Container(
                        width: 200,
                        height: 60,
                        color: Colors.deepPurple,
                        child: const Center(child: Text('Wide Content', style: TextStyle(color: Colors.white))),
                      ),
                      crossFadeState: _sizeState,
                      duration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _sizeState = _sizeState == CrossFadeState.showFirst
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst;
                  });
                  print('Size difference demo toggled');
                },
                icon: const Icon(Icons.height),
                label: const Text('Toggle All Sizes'),
              ),
            ),
            
            print('Size difference section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== SECTION 7: Practical Use Cases ===');
    print('AnimatedCrossFade is ideal for:');
    print('  - Expand/collapse content');
    print('  - Loading states');
    print('  - Show/hide details');
    print('  - Toggle between views');
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-world applications:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Use Case 1: Expand/Collapse Card
            const Text('1. Expandable Card:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                setState(() => _isExpanded = !_isExpanded);
                print('Expandable card toggled: $_isExpanded');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.article, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Card Title', style: TextStyle(fontWeight: FontWeight.bold))),
                        Icon(_isExpanded ? Icons.expand_less : Icons.expand_more, color: Colors.blue),
                      ],
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          'This is the expanded content that appears when you tap the card. '
                          'It smoothly fades in with AnimatedCrossFade.',
                        ),
                      ),
                      crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Use Case 2: Loading State
            const Text('2. Loading State:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: AnimatedCrossFade(
                    firstChild: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                            SizedBox(width: 12),
                            Text('Loading...'),
                          ],
                        ),
                      ),
                    ),
                    secondChild: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Content Loaded!', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                    ),
                    crossFadeState: _isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 400),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _isLoading = !_isLoading);
                    print('Loading state toggled: $_isLoading');
                  },
                  child: Text(_isLoading ? 'Complete' : 'Reset'),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Use Case 3: Show/Hide Details
            const Text('3. Show/Hide Details:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Software Developer', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _showDetails = !_showDetails);
                          print('Details toggled: $_showDetails');
                        },
                        child: Text(_showDetails ? 'Hide' : 'Details'),
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [Icon(Icons.email, size: 16), SizedBox(width: 8), Text('john@example.com')]),
                          SizedBox(height: 4),
                          Row(children: [Icon(Icons.phone, size: 16), SizedBox(width: 8), Text('+1 234 567 890')]),
                          SizedBox(height: 4),
                          Row(children: [Icon(Icons.location_on, size: 16), SizedBox(width: 8), Text('San Francisco, CA')]),
                        ],
                      ),
                    ),
                    crossFadeState: _showDetails ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
            
            print('Practical use cases section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Chained Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildChainedSection() {
    print('=== SECTION 8: Chained Transitions ===');
    print('Multiple AnimatedCrossFade widgets can be chained');
    print('Create multi-step transitions by nesting or sequencing');
    print('Current index: $_chainedIndex');
    
    final colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple];
    final icons = [Icons.filter_1, Icons.filter_2, Icons.filter_3, Icons.filter_4, Icons.filter_5, Icons.filter_6];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sequential multi-state transitions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Multi-state display using nested cross-fades
            Center(
              child: SizedBox(
                height: 120,
                child: AnimatedCrossFade(
                  firstChild: AnimatedCrossFade(
                    firstChild: AnimatedCrossFade(
                      firstChild: _buildChainedChild(colors[0], icons[0], '1'),
                      secondChild: _buildChainedChild(colors[1], icons[1], '2'),
                      crossFadeState: _chainedIndex == 1 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                    secondChild: _buildChainedChild(colors[2], icons[2], '3'),
                    crossFadeState: _chainedIndex == 2 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  secondChild: AnimatedCrossFade(
                    firstChild: AnimatedCrossFade(
                      firstChild: _buildChainedChild(colors[3], icons[3], '4'),
                      secondChild: _buildChainedChild(colors[4], icons[4], '5'),
                      crossFadeState: _chainedIndex == 4 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                    secondChild: _buildChainedChild(colors[5], icons[5], '6'),
                    crossFadeState: _chainedIndex == 5 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  crossFadeState: _chainedIndex >= 3 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _chainedIndex == index ? colors[index] : colors[index].withValues(alpha: 0.3),
                    border: Border.all(
                      color: _chainedIndex == index ? colors[index].shade700 : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: _chainedIndex == index ? Colors.white : colors[index].shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 16),
            
            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _chainedIndex > 0
                      ? () {
                          setState(() => _chainedIndex--);
                          print('Chained index decreased to: $_chainedIndex');
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Prev'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _chainedIndex < 5
                      ? () {
                          setState(() => _chainedIndex++);
                          print('Chained index increased to: $_chainedIndex');
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                ),
              ],
            ),
            
            print('Chained transitions section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
  
  Widget _buildChainedChild(MaterialColor color, IconData icon, String label) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.shade300, color.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 4),
            Text('Step $label', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // API Reference
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildApiReference() {
    print('=== API Reference Summary ===');
    print('AnimatedCrossFade Properties:');
    print('  - firstChild: Widget - First child to display');
    print('  - secondChild: Widget - Second child to display');
    print('  - crossFadeState: CrossFadeState - showFirst or showSecond');
    print('  - duration: Duration - Animation duration');
    print('  - reverseDuration: Duration? - Reverse animation duration');
    print('  - firstCurve: Curve - Curve for first child fade');
    print('  - secondCurve: Curve - Curve for second child fade');
    print('  - sizeCurve: Curve - Curve for size animation');
    print('  - alignment: AlignmentGeometry - Child alignment during transition');
    print('  - layoutBuilder: Function - Custom layout during transition');
    print('  - excludeBottomFocus: bool - Exclude bottom child from focus');
    print('');
    print('CrossFadeState enum:');
    print('  - showFirst: Display firstChild');
    print('  - showSecond: Display secondChild');
    
    return Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedCrossFade API',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            
            _buildApiRow('firstChild', 'Widget', 'First child widget'),
            _buildApiRow('secondChild', 'Widget', 'Second child widget'),
            _buildApiRow('crossFadeState', 'CrossFadeState', 'Which child to show'),
            _buildApiRow('duration', 'Duration', 'Animation duration'),
            _buildApiRow('reverseDuration', 'Duration?', 'Optional reverse duration'),
            _buildApiRow('firstCurve', 'Curve', 'Fade curve for first child (default: linear)'),
            _buildApiRow('secondCurve', 'Curve', 'Fade curve for second child (default: linear)'),
            _buildApiRow('sizeCurve', 'Curve', 'Size transition curve (default: linear)'),
            _buildApiRow('alignment', 'AlignmentGeometry', 'Alignment during transition (default: center)'),
            _buildApiRow('layoutBuilder', 'Function', 'Custom layout builder'),
            _buildApiRow('excludeBottomFocus', 'bool', 'Exclude hidden child from focus tree'),
            
            const SizedBox(height: 12),
            const Text(
              'CrossFadeState',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• showFirst - Display the firstChild'),
            const Text('• showSecond - Display the secondChild'),
            
            const SizedBox(height: 12),
            const Text(
              'Key Notes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• Both children are always built (for size calculation)'),
            const Text('• Use for simple two-state transitions'),
            const Text('• For 3+ states, consider AnimatedSwitcher'),
            const Text('• Size animates automatically between children'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildApiRow(String name, String type, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            width: 120,
            child: Text(type, style: const TextStyle(fontFamily: 'monospace', color: Colors.blue, fontSize: 12)),
          ),
          Expanded(child: Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey))),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
