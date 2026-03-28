// ignore_for_file: avoid_print
// Deep demo: AnimatedFractionallySizedBox - Implicit animation for fractional sizing
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedFractionallySizedBoxDemo(),
  );
}

class AnimatedFractionallySizedBoxDemo extends StatefulWidget {
  const AnimatedFractionallySizedBoxDemo({super.key});

  @override
  State<AnimatedFractionallySizedBoxDemo> createState() =>
      _AnimatedFractionallySizedBoxDemoState();
}

class _AnimatedFractionallySizedBoxDemoState
    extends State<AnimatedFractionallySizedBoxDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Fractional Sizing
  // ═══════════════════════════════════════════════════════════════════════════
  double _basicWidthFactor = 0.5;
  double _basicHeightFactor = 0.5;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Width Factor Exploration
  // ═══════════════════════════════════════════════════════════════════════════
  double _widthFactor = 0.5;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Height Factor Exploration
  // ═══════════════════════════════════════════════════════════════════════════
  double _heightFactor = 0.5;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Combined Width and Height Factors
  // ═══════════════════════════════════════════════════════════════════════════
  double _comboWidth = 0.5;
  double _comboHeight = 0.5;
  int _presetIndex = -1;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  double _durWidthFactor = 0.5;
  Duration _selectedDuration = const Duration(milliseconds: 300);
  final List<Duration> _durations = [
    const Duration(milliseconds: 100),
    const Duration(milliseconds: 300),
    const Duration(milliseconds: 600),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 2000),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Curve Variations
  // ═══════════════════════════════════════════════════════════════════════════
  double _curveWidthFactor = 0.5;
  Curve _selectedCurve = Curves.easeInOut;
  final List<MapEntry<String, Curve>> _curves = [
    const MapEntry('linear', Curves.linear),
    const MapEntry('easeIn', Curves.easeIn),
    const MapEntry('easeOut', Curves.easeOut),
    const MapEntry('easeInOut', Curves.easeInOut),
    const MapEntry('bounceOut', Curves.bounceOut),
    const MapEntry('elasticOut', Curves.elasticOut),
    const MapEntry('fastOutSlowIn', Curves.fastOutSlowIn),
    const MapEntry('decelerate', Curves.decelerate),
  ];
  int _curveIndex = 3;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Alignment Control
  // ═══════════════════════════════════════════════════════════════════════════
  double _alignWidthFactor = 0.4;
  Alignment _boxAlignment = Alignment.center;
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
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  double _progressValue = 0.3;
  bool _panelExpanded = false;
  bool _sidebarCollapsed = false;
  double _splitPosition = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedFractionallySizedBox Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic Fractional Sizing'),
            _buildBasicSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('2. Width Factor Exploration'),
            _buildWidthFactorSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('3. Height Factor Exploration'),
            _buildHeightFactorSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('4. Combined Width and Height Factors'),
            _buildCombinedSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('5. Duration Control'),
            _buildDurationSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('6. Curve Variations'),
            _buildCurvesSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('7. Alignment Control'),
            _buildAlignmentSection(),
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
  // SECTION 1: Basic Fractional Sizing
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicSection() {
    print('=== Section 1: Basic Fractional Sizing ===');
    print('Width factor: $_basicWidthFactor, Height factor: $_basicHeightFactor');
    print('FractionallySizedBox sizes itself as a fraction of its parent');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedFractionallySizedBox smoothly animates changes to '
              'widthFactor and heightFactor. Values are fractions of the parent: '
              '0.5 = half width/height, 1.0 = full width/height.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Demo container
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: AnimatedFractionallySizedBox(
                widthFactor: _basicWidthFactor,
                heightFactor: _basicHeightFactor,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.indigo, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${(_basicWidthFactor * 100).round()}% × ${(_basicHeightFactor * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quick presets
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPresetButton('Quarter', () {
                  setState(() { _basicWidthFactor = 0.25; _basicHeightFactor = 0.25; });
                  print('Basic: 25% × 25%');
                }),
                _buildPresetButton('Half', () {
                  setState(() { _basicWidthFactor = 0.5; _basicHeightFactor = 0.5; });
                  print('Basic: 50% × 50%');
                }),
                _buildPresetButton('Three-Quarter', () {
                  setState(() { _basicWidthFactor = 0.75; _basicHeightFactor = 0.75; });
                  print('Basic: 75% × 75%');
                }),
                _buildPresetButton('Full', () {
                  setState(() { _basicWidthFactor = 1.0; _basicHeightFactor = 1.0; });
                  print('Basic: 100% × 100%');
                }),
                _buildPresetButton('Wide', () {
                  setState(() { _basicWidthFactor = 0.9; _basicHeightFactor = 0.3; });
                  print('Basic: 90% × 30%');
                }),
                _buildPresetButton('Tall', () {
                  setState(() { _basicWidthFactor = 0.3; _basicHeightFactor = 0.9; });
                  print('Basic: 30% × 90%');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Width Factor Exploration
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildWidthFactorSection() {
    print('=== Section 2: Width Factor Exploration ===');
    print('Width factor: $_widthFactor');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The widthFactor controls what fraction of the parent\'s width '
              'the child occupies. null means the child sizes itself.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Visual width demo with stacked bars
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Animated bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: AnimatedFractionallySizedBox(
                        widthFactor: _widthFactor,
                        alignment: Alignment.centerLeft,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              '${(_widthFactor * 100).round()}%',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Reference bars
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: List.generate(10, (i) {
                        return Expanded(
                          child: Container(
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            color: (i + 1) * 0.1 <= _widthFactor
                                ? Colors.deepPurple.shade400
                                : Colors.deepPurple.shade100,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Width slider
            Row(
              children: [
                const Text('Width: '),
                Expanded(
                  child: Slider(
                    value: _widthFactor,
                    min: 0.05,
                    max: 1.0,
                    divisions: 19,
                    label: '${(_widthFactor * 100).round()}%',
                    onChanged: (val) {
                      setState(() { _widthFactor = val; });
                      print('Width factor: $val');
                    },
                  ),
                ),
                SizedBox(width: 50, child: Text('${(_widthFactor * 100).round()}%')),
              ],
            ),

            // Quick values
            Wrap(
              spacing: 8,
              children: [0.1, 0.25, 0.5, 0.75, 1.0].map((v) {
                return TextButton(
                  onPressed: () {
                    setState(() { _widthFactor = v; });
                    print('Width: ${(v * 100).round()}%');
                  },
                  child: Text('${(v * 100).round()}%'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Height Factor Exploration
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeightFactorSection() {
    print('=== Section 3: Height Factor Exploration ===');
    print('Height factor: $_heightFactor');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The heightFactor controls what fraction of the parent\'s height '
              'the child occupies. Useful for collapsible panels.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Vertical bar demo
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Animated vertical bar
                  SizedBox(
                    width: 80,
                    child: AnimatedFractionallySizedBox(
                      heightFactor: _heightFactor,
                      alignment: Alignment.bottomCenter,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.teal, Colors.teal.shade300],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              '${(_heightFactor * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Visual scale
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('100%', style: TextStyle(fontSize: 10)),
                      const Text('75%', style: TextStyle(fontSize: 10)),
                      const Text('50%', style: TextStyle(fontSize: 10)),
                      const Text('25%', style: TextStyle(fontSize: 10)),
                      const Text('0%', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                  // Info panel
                  SizedBox(
                    width: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Height: ${(_heightFactor * 100).round()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The bar fills ${(_heightFactor * 100).round()}% '
                          'of the container height, growing from bottom.',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Height slider
            Row(
              children: [
                const Text('Height: '),
                Expanded(
                  child: Slider(
                    value: _heightFactor,
                    min: 0.05,
                    max: 1.0,
                    divisions: 19,
                    label: '${(_heightFactor * 100).round()}%',
                    onChanged: (val) {
                      setState(() { _heightFactor = val; });
                      print('Height factor: $val');
                    },
                  ),
                ),
                SizedBox(width: 50, child: Text('${(_heightFactor * 100).round()}%')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Combined Width and Height Factors
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCombinedSection() {
    print('=== Section 4: Combined Width and Height Factors ===');
    print('Combo width: $_comboWidth, height: $_comboHeight');

    final presets = [
      {'name': 'Tiny', 'w': 0.2, 'h': 0.2},
      {'name': 'Square M', 'w': 0.5, 'h': 0.5},
      {'name': 'Letterbox', 'w': 0.9, 'h': 0.3},
      {'name': 'Portrait', 'w': 0.4, 'h': 0.9},
      {'name': 'Full', 'w': 1.0, 'h': 1.0},
      {'name': 'Golden', 'w': 0.618, 'h': 0.382},
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Both width and height factors can be animated simultaneously. '
              'The animation interpolates each independently.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: AnimatedFractionallySizedBox(
                widthFactor: _comboWidth,
                heightFactor: _comboHeight,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.aspect_ratio, color: Colors.white, size: 28),
                        const SizedBox(height: 4),
                        Text(
                          '${(_comboWidth * 100).round()}% × ${(_comboHeight * 100).round()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Presets
            const Text('Shape Presets:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(presets.length, (i) {
                final preset = presets[i];
                final isSelected = _presetIndex == i;
                return ChoiceChip(
                  label: Text(preset['name'] as String),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _presetIndex = i;
                      _comboWidth = preset['w'] as double;
                      _comboHeight = preset['h'] as double;
                    });
                    print('Preset: ${preset['name']} (${preset['w']} × ${preset['h']})');
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
  // SECTION 5: Duration Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationSection() {
    print('=== Section 5: Duration Control ===');
    print('Duration: ${_selectedDuration.inMilliseconds}ms');
    print('Width factor: $_durWidthFactor');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Duration controls how fast the sizing animation completes. '
              'Short durations feel snappy; longer ones give a gentle resize.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedFractionallySizedBox(
                widthFactor: _durWidthFactor,
                heightFactor: 0.7,
                alignment: Alignment.centerLeft,
                duration: _selectedDuration,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${_selectedDuration.inMilliseconds}ms',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text('Duration:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _durations.map((d) {
                final isSelected = _selectedDuration == d;
                return ChoiceChip(
                  label: Text('${d.inMilliseconds}ms'),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() { _selectedDuration = d; });
                      print('Duration: ${d.inMilliseconds}ms');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _durWidthFactor = _durWidthFactor < 0.7 ? 0.9 : 0.2;
                });
                print('Duration demo: width $_durWidthFactor');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Toggle Width'),
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
  // SECTION 6: Curve Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCurvesSection() {
    print('=== Section 6: Curve Variations ===');
    print('Curve: ${_curves[_curveIndex].key}');
    print('Curve width factor: $_curveWidthFactor');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Curves define the animation easing. elasticOut and bounceOut '
              'create playful size transitions.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedFractionallySizedBox(
                widthFactor: _curveWidthFactor,
                heightFactor: 0.7,
                duration: const Duration(milliseconds: 700),
                curve: _selectedCurve,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.auto_fix_high, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(height: 12),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() { _curveWidthFactor = 0.2; });
                    print('Curve demo: shrink');
                  },
                  child: const Text('Shrink'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _curveWidthFactor = 0.5; });
                    print('Curve demo: half');
                  },
                  child: const Text('Half'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() { _curveWidthFactor = 0.9; });
                    print('Curve demo: expand');
                  },
                  child: const Text('Expand'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Alignment Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAlignmentSection() {
    print('=== Section 7: Alignment Control ===');
    print('Alignment: ${_alignmentNames[_alignmentIndex]}');
    print('Width factor: $_alignWidthFactor');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alignment determines where the sized child is placed '
              'within the parent. This affects how the resize animation looks.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: AnimatedFractionallySizedBox(
                widthFactor: _alignWidthFactor,
                heightFactor: 0.4,
                alignment: _boxAlignment,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _alignmentNames[_alignmentIndex],
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
            const SizedBox(height: 16),

            // Alignment grid
            const Text('Alignment:', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      _boxAlignment = _alignments[index];
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
                  _alignWidthFactor = _alignWidthFactor > 0.5 ? 0.3 : 0.8;
                });
                print('Alignment demo: width $_alignWidthFactor');
              },
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Toggle Size'),
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
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== Section 8: Practical Use Cases ===');
    print('Progress: $_progressValue');
    print('Panel expanded: $_panelExpanded');
    print('Sidebar collapsed: $_sidebarCollapsed');
    print('Split: $_splitPosition');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-world scenarios where animated fractional sizing shines.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Use Case 1: Animated progress bar
            const Text('1. Animated Progress Bar', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: AnimatedFractionallySizedBox(
                widthFactor: _progressValue,
                alignment: Alignment.centerLeft,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue.shade300],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      '${(_progressValue * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [0.1, 0.3, 0.5, 0.75, 1.0].map((v) {
                return TextButton(
                  onPressed: () {
                    setState(() { _progressValue = v; });
                    print('Progress: ${(v * 100).round()}%');
                  },
                  child: Text('${(v * 100).round()}%'),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Use Case 2: Collapsible panel
            const Text('2. Collapsible Panel', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AnimatedFractionallySizedBox(
                heightFactor: _panelExpanded ? 1.0 : 0.3,
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Panel Header',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      if (_panelExpanded) ...[
                        const SizedBox(height: 8),
                        const Text(
                          'This panel reveals its content when expanded. '
                          'AnimatedFractionallySizedBox handles the transition.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() { _panelExpanded = !_panelExpanded; });
                print('Panel: ${_panelExpanded ? 'expanded' : 'collapsed'}');
              },
              child: Text(_panelExpanded ? 'Collapse' : 'Expand'),
            ),
            const SizedBox(height: 24),

            // Use Case 3: Split pane
            const Text('3. Animated Split Pane', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: (_splitPosition * 100).round(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: Colors.red.shade100,
                      child: Center(
                        child: Text(
                          'Left ${(_splitPosition * 100).round()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 2, color: Colors.grey),
                  Expanded(
                    flex: ((1.0 - _splitPosition) * 100).round(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: Colors.blue.shade100,
                      child: Center(
                        child: Text(
                          'Right ${((1.0 - _splitPosition) * 100).round()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Split: '),
                Expanded(
                  child: Slider(
                    value: _splitPosition,
                    min: 0.1,
                    max: 0.9,
                    onChanged: (val) {
                      setState(() { _splitPosition = val; });
                      print('Split: ${(val * 100).round()}%');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Use Case 4: Sidebar toggle
            const Text('4. Sidebar Toggle', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _sidebarCollapsed ? 40 : 120,
                    color: Colors.grey.shade800,
                    child: Center(
                      child: _sidebarCollapsed
                          ? const Icon(Icons.menu, color: Colors.white)
                          : const Text('Sidebar', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: Text('Main Content')),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                setState(() { _sidebarCollapsed = !_sidebarCollapsed; });
                print('Sidebar: ${_sidebarCollapsed ? 'collapsed' : 'expanded'}');
              },
              icon: Icon(_sidebarCollapsed ? Icons.chevron_right : Icons.chevron_left),
              label: Text(_sidebarCollapsed ? 'Expand Sidebar' : 'Collapse Sidebar'),
            ),
          ],
        ),
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
              color: Colors.indigo,
            ),
          ),
          const Divider(thickness: 2, color: Colors.indigo),
        ],
      ),
    );
  }

  Widget _buildPresetButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
