// ignore_for_file: avoid_print
// Deep demo: AnimatedPhysicalModel - Implicit animation for physical model properties
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const AnimatedPhysicalModelDemo(),
  );
}

class AnimatedPhysicalModelDemo extends StatefulWidget {
  const AnimatedPhysicalModelDemo({super.key});

  @override
  State<AnimatedPhysicalModelDemo> createState() =>
      _AnimatedPhysicalModelDemoState();
}

class _AnimatedPhysicalModelDemoState extends State<AnimatedPhysicalModelDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Physical Model
  // ═══════════════════════════════════════════════════════════════════════════
  double _basicElevation = 4.0;
  Color _basicColor = Colors.white;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Shape Variations
  // ═══════════════════════════════════════════════════════════════════════════
  BoxShape _shape = BoxShape.rectangle;
  double _shapeElevation = 8.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Elevation and Shadow Depth
  // ═══════════════════════════════════════════════════════════════════════════
  double _elevationValue = 4.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Color Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  Color _surfaceColor = Colors.white;
  int _colorIndex = 0;
  final List<MapEntry<String, Color>> _colors = [
    const MapEntry('White', Colors.white),
    MapEntry('Red 100', Colors.red.shade100),
    MapEntry('Blue 100', Colors.blue.shade100),
    MapEntry('Green 100', Colors.green.shade100),
    MapEntry('Amber 100', Colors.amber.shade100),
    MapEntry('Purple 100', Colors.purple.shade100),
    MapEntry('Teal 100', Colors.teal.shade100),
    const MapEntry('Red', Colors.red),
    const MapEntry('Blue', Colors.blue),
    const MapEntry('Deep Orange', Colors.deepOrange),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Shadow Color Control
  // ═══════════════════════════════════════════════════════════════════════════
  Color _shadowColor = Colors.black;
  double _shadowElevation = 12.0;
  int _shadowColorIndex = 0;
  final List<MapEntry<String, Color>> _shadowColors = [
    const MapEntry('Black', Colors.black),
    const MapEntry('Blue', Colors.blue),
    const MapEntry('Red', Colors.red),
    const MapEntry('Green', Colors.green),
    const MapEntry('Purple', Colors.purple),
    const MapEntry('Orange', Colors.orange),
    const MapEntry('Grey', Colors.grey),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Border Radius
  // ═══════════════════════════════════════════════════════════════════════════
  double _borderRadius = 8.0;
  double _brElevation = 8.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Duration and Curves
  // ═══════════════════════════════════════════════════════════════════════════
  double _animElevation = 4.0;
  Duration _animDuration = const Duration(milliseconds: 300);
  Curve _animCurve = Curves.easeInOut;
  int _curveIndex = 3;
  final List<MapEntry<String, Curve>> _animCurves = [
    const MapEntry('linear', Curves.linear),
    const MapEntry('easeIn', Curves.easeIn),
    const MapEntry('easeOut', Curves.easeOut),
    const MapEntry('easeInOut', Curves.easeInOut),
    const MapEntry('bounceOut', Curves.bounceOut),
    const MapEntry('elasticOut', Curves.elasticOut),
    const MapEntry('fastOutSlowIn', Curves.fastOutSlowIn),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _cardPressed = false;
  int _selectedTile = -1;
  bool _fabExtended = false;
  double _layerDepth1 = 2.0;
  double _layerDepth2 = 6.0;
  double _layerDepth3 = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedPhysicalModel Deep Demo'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic Physical Model'),
            _buildBasicSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('2. Shape Variations'),
            _buildShapeSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('3. Elevation and Shadow Depth'),
            _buildElevationSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('4. Color Transitions'),
            _buildColorSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('5. Shadow Color Control'),
            _buildShadowColorSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('6. Border Radius'),
            _buildBorderRadiusSection(),
            const SizedBox(height: 32),

            _buildSectionHeader('7. Duration and Curves'),
            _buildDurationCurvesSection(),
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
  // SECTION 1: Basic Physical Model
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicSection() {
    print('=== Section 1: Basic Physical Model ===');
    print('Elevation: $_basicElevation, Color: $_basicColor');
    print('PhysicalModel renders a box with elevation shadow');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedPhysicalModel smoothly animates shape, elevation, '
              'color, and shadow changes. It renders a physical material '
              'surface with realistic shadows.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Center(
              child: AnimatedPhysicalModel(
                shape: BoxShape.rectangle,
                elevation: _basicElevation,
                color: _basicColor,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(12),
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 160,
                  height: 120,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.layers, size: 32, color: Colors.brown.shade700),
                      const SizedBox(height: 8),
                      Text(
                        'Elevation: ${_basicElevation.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton('Flat', () {
                  setState(() { _basicElevation = 0; _basicColor = Colors.grey.shade100; });
                  print('Basic: flat, grey');
                }),
                _buildActionButton('Low', () {
                  setState(() { _basicElevation = 2; _basicColor = Colors.white; });
                  print('Basic: low elevation');
                }),
                _buildActionButton('Medium', () {
                  setState(() { _basicElevation = 8; _basicColor = Colors.blue.shade50; });
                  print('Basic: medium elevation');
                }),
                _buildActionButton('High', () {
                  setState(() { _basicElevation = 20; _basicColor = Colors.amber.shade50; });
                  print('Basic: high elevation');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Shape Variations
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildShapeSection() {
    print('=== Section 2: Shape Variations ===');
    print('Shape: $_shape, Elevation: $_shapeElevation');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedPhysicalModel supports rectangle and circle shapes. '
              'For rectangles, borderRadius rounds the corners.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Rectangle
                Column(
                  children: [
                    AnimatedPhysicalModel(
                      shape: BoxShape.rectangle,
                      elevation: _shape == BoxShape.rectangle ? _shapeElevation : 2,
                      color: _shape == BoxShape.rectangle
                          ? Colors.indigo.shade100 : Colors.grey.shade200,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.rectangle_outlined, size: 28),
                              Text('Rectangle', style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() { _shape = BoxShape.rectangle; });
                        print('Shape: rectangle');
                      },
                      child: const Text('Select'),
                    ),
                  ],
                ),

                // Circle
                Column(
                  children: [
                    AnimatedPhysicalModel(
                      shape: BoxShape.circle,
                      elevation: _shape == BoxShape.circle ? _shapeElevation : 2,
                      color: _shape == BoxShape.circle
                          ? Colors.teal.shade100 : Colors.grey.shade200,
                      shadowColor: Colors.black,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.circle_outlined, size: 28),
                              Text('Circle', style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() { _shape = BoxShape.circle; });
                        print('Shape: circle');
                      },
                      child: const Text('Select'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Text('Elevation: '),
                Expanded(
                  child: Slider(
                    value: _shapeElevation,
                    min: 0,
                    max: 24,
                    divisions: 24,
                    label: _shapeElevation.toStringAsFixed(0),
                    onChanged: (val) {
                      setState(() { _shapeElevation = val; });
                      print('Shape elevation: $val');
                    },
                  ),
                ),
                Text('${_shapeElevation.toStringAsFixed(0)}dp'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Elevation and Shadow Depth
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildElevationSection() {
    print('=== Section 3: Elevation and Shadow Depth ===');
    print('Elevation: $_elevationValue');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Elevation controls the shadow depth. Higher values cast '
              'larger, softer shadows. Material Design uses 0-24dp.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Elevation gallery
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [0, 1, 2, 4, 6, 8, 12, 16, 24].map((e) {
                return AnimatedPhysicalModel(
                  shape: BoxShape.rectangle,
                  elevation: e.toDouble(),
                  color: Colors.white,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: Text(
                        '${e}dp',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Interactive elevation
            const Text('Interactive:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Center(
              child: AnimatedPhysicalModel(
                shape: BoxShape.rectangle,
                elevation: _elevationValue,
                color: Colors.white,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(12),
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: 120,
                  height: 80,
                  child: Center(
                    child: Text(
                      '${_elevationValue.toStringAsFixed(0)}dp',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text('Elevation: '),
                Expanded(
                  child: Slider(
                    value: _elevationValue,
                    min: 0,
                    max: 24,
                    divisions: 24,
                    label: _elevationValue.toStringAsFixed(0),
                    onChanged: (val) {
                      setState(() { _elevationValue = val; });
                      print('Elevation: $val dp');
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
  // SECTION 4: Color Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildColorSection() {
    print('=== Section 4: Color Transitions ===');
    print('Surface color: $_surfaceColor (index: $_colorIndex)');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The color property animates the surface color. '
              'Transitions blend smoothly between colors.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Center(
              child: AnimatedPhysicalModel(
                shape: BoxShape.rectangle,
                elevation: 8,
                color: _surfaceColor,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(16),
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: 180,
                  height: 120,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.palette, size: 32),
                        const SizedBox(height: 4),
                        Text(
                          _colors[_colorIndex].key,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_colors.length, (i) {
                final isSelected = _colorIndex == i;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _colorIndex = i;
                      _surfaceColor = _colors[i].value;
                    });
                    print('Color: ${_colors[i].key}');
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _colors[i].value,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey.shade400,
                        width: isSelected ? 3 : 1,
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
  // SECTION 5: Shadow Color Control
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildShadowColorSection() {
    print('=== Section 5: Shadow Color Control ===');
    print('Shadow color: $_shadowColor (index: $_shadowColorIndex)');
    print('Shadow elevation: $_shadowElevation');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shadow color changes the tint of the shadow. Colored shadows '
              'can create moody or thematic elevation effects.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedPhysicalModel(
                  shape: BoxShape.rectangle,
                  elevation: _shadowElevation,
                  color: Colors.white,
                  shadowColor: _shadowColor,
                  borderRadius: BorderRadius.circular(16),
                  duration: const Duration(milliseconds: 400),
                  child: SizedBox(
                    width: 140,
                    height: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wb_shade, size: 28, color: _shadowColor),
                          const SizedBox(height: 4),
                          Text(
                            _shadowColors[_shadowColorIndex].key,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text('Shadow Color:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_shadowColors.length, (i) {
                final isSelected = _shadowColorIndex == i;
                return ChoiceChip(
                  label: Text(_shadowColors[i].key),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _shadowColorIndex = i;
                        _shadowColor = _shadowColors[i].value;
                      });
                      print('Shadow color: ${_shadowColors[i].key}');
                    }
                  },
                );
              }),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Text('Elevation: '),
                Expanded(
                  child: Slider(
                    value: _shadowElevation,
                    min: 0,
                    max: 24,
                    divisions: 24,
                    onChanged: (val) {
                      setState(() { _shadowElevation = val; });
                      print('Shadow elevation: $val');
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
  // SECTION 6: Border Radius
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBorderRadiusSection() {
    print('=== Section 6: Border Radius ===');
    print('Border radius: $_borderRadius');
    print('Elevation: $_brElevation');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BorderRadius rounds the corners of rectangle-shaped models. '
              'Note: borderRadius only applies when shape is rectangle.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Gallery of radii
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [0.0, 8.0, 16.0, 32.0].map((r) {
                return Column(
                  children: [
                    AnimatedPhysicalModel(
                      shape: BoxShape.rectangle,
                      elevation: _brElevation,
                      color: Colors.indigo.shade100,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.circular(r),
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: Center(
                          child: Text('${r.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('r=${r.toInt()}', style: const TextStyle(fontSize: 10)),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Interactive radius
            Center(
              child: AnimatedPhysicalModel(
                shape: BoxShape.rectangle,
                elevation: _brElevation,
                color: Colors.deepPurple.shade100,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(_borderRadius),
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Center(
                    child: Text(
                      'r=${_borderRadius.toInt()}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Text('Radius: '),
                Expanded(
                  child: Slider(
                    value: _borderRadius,
                    min: 0,
                    max: 60,
                    divisions: 60,
                    label: _borderRadius.toStringAsFixed(0),
                    onChanged: (val) {
                      setState(() { _borderRadius = val; });
                      print('Border radius: $val');
                    },
                  ),
                ),
                Text('${_borderRadius.toStringAsFixed(0)}px'),
              ],
            ),
            Row(
              children: [
                const Text('Elevation: '),
                Expanded(
                  child: Slider(
                    value: _brElevation,
                    min: 0,
                    max: 24,
                    divisions: 24,
                    onChanged: (val) {
                      setState(() { _brElevation = val; });
                      print('Radius elevation: $val');
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
  // SECTION 7: Duration and Curves
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDurationCurvesSection() {
    print('=== Section 7: Duration and Curves ===');
    print('Duration: ${_animDuration.inMilliseconds}ms');
    print('Curve: ${_animCurves[_curveIndex].key}');
    print('Elevation: $_animElevation');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Control animation speed and easing for smooth transitions.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            Center(
              child: AnimatedPhysicalModel(
                shape: BoxShape.rectangle,
                elevation: _animElevation,
                color: _animElevation > 12 ? Colors.amber.shade100 : Colors.white,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(12),
                duration: _animDuration,
                curve: _animCurve,
                child: SizedBox(
                  width: 140,
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_animDuration.inMilliseconds}ms',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(_animCurves[_curveIndex].key,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text('Duration:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: [100, 300, 600, 1000, 2000].map((ms) {
                final isSelected = _animDuration.inMilliseconds == ms;
                return ChoiceChip(
                  label: Text('${ms}ms'),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() { _animDuration = Duration(milliseconds: ms); });
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
                itemCount: _animCurves.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_animCurves[index].key),
                      selected: _curveIndex == index,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _curveIndex = index;
                            _animCurve = _animCurves[index].value;
                          });
                          print('Curve: ${_animCurves[index].key}');
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _animElevation = _animElevation < 12 ? 20 : 2;
                });
                print('Elevation toggle: $_animElevation');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Toggle Elevation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
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
    print('Card pressed: $_cardPressed');
    print('Selected tile: $_selectedTile');
    print('FAB extended: $_fabExtended');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-world applications of AnimatedPhysicalModel.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Use Case 1: Press effect card
            const Text('1. Press Effect Card', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GestureDetector(
              onTapDown: (_) {
                setState(() { _cardPressed = true; });
                print('Card pressed');
              },
              onTapUp: (_) {
                setState(() { _cardPressed = false; });
                print('Card released');
              },
              onTapCancel: () {
                setState(() { _cardPressed = false; });
              },
              child: AnimatedPhysicalModel(
                shape: BoxShape.rectangle,
                elevation: _cardPressed ? 2 : 8,
                color: _cardPressed ? Colors.grey.shade100 : Colors.white,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(12),
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.touch_app,
                        color: _cardPressed ? Colors.grey : Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text('Press and hold to see elevation drop'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Use Case 2: Selectable tiles
            const Text('2. Selectable Tiles', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (i) {
                final isSelected = _selectedTile == i;
                final tileColors = [Colors.red, Colors.green, Colors.blue];
                final tileNames = ['Option A', 'Option B', 'Option C'];
                return GestureDetector(
                  onTap: () {
                    setState(() { _selectedTile = isSelected ? -1 : i; });
                    print('Tile $i ${isSelected ? "deselected" : "selected"}');
                  },
                  child: AnimatedPhysicalModel(
                    shape: BoxShape.rectangle,
                    elevation: isSelected ? 12 : 2,
                    color: isSelected ? tileColors[i].shade100 : Colors.grey.shade100,
                    shadowColor: isSelected ? tileColors[i] : Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    duration: const Duration(milliseconds: 200),
                    child: SizedBox(
                      width: 90,
                      height: 80,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: isSelected ? tileColors[i] : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Text(tileNames[i], style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Use Case 3: Material depth layers
            const Text('3. Material Depth Layers', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 140,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDepthLayer('Background', _layerDepth1, Colors.brown.shade100, () {
                    setState(() { _layerDepth1 = _layerDepth1 == 2 ? 10 : 2; });
                    print('Layer 1 depth: $_layerDepth1');
                  }),
                  _buildDepthLayer('Surface', _layerDepth2, Colors.brown.shade200, () {
                    setState(() { _layerDepth2 = _layerDepth2 == 6 ? 16 : 6; });
                    print('Layer 2 depth: $_layerDepth2');
                  }),
                  _buildDepthLayer('Foreground', _layerDepth3, Colors.brown.shade300, () {
                    setState(() { _layerDepth3 = _layerDepth3 == 12 ? 24 : 12; });
                    print('Layer 3 depth: $_layerDepth3');
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Use Case 4: FAB toggle
            const Text('4. FAB State Toggle', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() { _fabExtended = !_fabExtended; });
                  print('FAB ${_fabExtended ? "extended" : "collapsed"}');
                },
                child: AnimatedPhysicalModel(
                  shape: _fabExtended ? BoxShape.rectangle : BoxShape.circle,
                  elevation: _fabExtended ? 12 : 6,
                  color: _fabExtended ? Colors.green : Colors.blue,
                  shadowColor: _fabExtended ? Colors.green : Colors.blue,
                  borderRadius: _fabExtended
                      ? BorderRadius.circular(28)
                      : BorderRadius.circular(0),
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    width: _fabExtended ? 160 : 56,
                    height: 56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: Colors.white),
                        if (_fabExtended) ...[
                          const SizedBox(width: 8),
                          const Text(
                            'Create',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ],
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

  Widget _buildDepthLayer(String label, double elevation, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedPhysicalModel(
        shape: BoxShape.rectangle,
        elevation: elevation,
        color: color,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(8),
        duration: const Duration(milliseconds: 300),
        child: SizedBox(
          width: 80,
          height: 80,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('${elevation.toInt()}dp', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
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
              color: Colors.brown,
            ),
          ),
          const Divider(thickness: 2, color: Colors.brown),
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
