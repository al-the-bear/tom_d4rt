// ignore_for_file: avoid_print
// Deep demo: PhysicalModel - Draw physical 3D-like models with elevation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const PhysicalModelDemo(),
  );
}

class PhysicalModelDemo extends StatefulWidget {
  const PhysicalModelDemo({super.key});

  @override
  State<PhysicalModelDemo> createState() => _PhysicalModelDemoState();
}

class _PhysicalModelDemoState extends State<PhysicalModelDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Elevation
  // ═══════════════════════════════════════════════════════════════════════════
  double _basicElevation = 8.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Shape & Border Radius
  // ═══════════════════════════════════════════════════════════════════════════
  int _shapeType = 0;
  double _borderRadius = 12.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Shadow Colors
  // ═══════════════════════════════════════════════════════════════════════════
  Color _shadowColor = Colors.black;
  double _shadowOpacity = 1.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Model Colors
  // ═══════════════════════════════════════════════════════════════════════════
  int _colorIndex = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Clipping Behavior
  // ═══════════════════════════════════════════════════════════════════════════
  bool _clipBehavior = true;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Animated Elevation
  // ═══════════════════════════════════════════════════════════════════════════
  double _animatedElevation = 4.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Comparison with Material
  // ═══════════════════════════════════════════════════════════════════════════
  double _compareElevation = 6.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhysicalModel Deep Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Elevation
            _buildSectionHeader('1. Basic Elevation'),
            _buildBasicElevationSection(),
            const SizedBox(height: 32),

            // Section 2: Shape & Border Radius
            _buildSectionHeader('2. Shape & Border Radius'),
            _buildShapeSection(),
            const SizedBox(height: 32),

            // Section 3: Shadow Colors
            _buildSectionHeader('3. Shadow Colors'),
            _buildShadowColorSection(),
            const SizedBox(height: 32),

            // Section 4: Model Colors
            _buildSectionHeader('4. Model Colors'),
            _buildModelColorSection(),
            const SizedBox(height: 32),

            // Section 5: Clipping Behavior
            _buildSectionHeader('5. Clipping Behavior'),
            _buildClippingSection(),
            const SizedBox(height: 32),

            // Section 6: Animated Elevation
            _buildSectionHeader('6. Animated Elevation'),
            _buildAnimatedElevationSection(),
            const SizedBox(height: 32),

            // Section 7: PhysicalModel vs Material
            _buildSectionHeader('7. PhysicalModel vs Material'),
            _buildComparisonSection(),
            const SizedBox(height: 32),

            // Section 8: Practical Use Cases
            _buildSectionHeader('8. Practical Use Cases'),
            _buildPracticalUseCasesSection(),
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
  // SECTION 1: Basic Elevation
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicElevationSection() {
    print('=== SECTION 1: Basic Elevation ===');
    print('PhysicalModel creates a physical layer with elevation');
    print('Current elevation: $_basicElevation');
    print('Higher elevation = larger/softer shadow');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Elevation creates depth with shadow effects:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Demo models with different elevations
            Center(
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [0.0, 2.0, 4.0, 8.0, 16.0, 24.0].map((elev) {
                  return Column(
                    children: [
                      PhysicalModel(
                        elevation: elev,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        shadowColor: Colors.black,
                        child: Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.layers, color: Colors.deepPurple.shade300),
                              Text(
                                '${elev.toInt()}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('elevation: ${elev.toInt()}', style: const TextStyle(fontSize: 11)),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Interactive demo
            const Text('Interactive elevation control:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Center(
              child: PhysicalModel(
                elevation: _basicElevation,
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(16),
                shadowColor: Colors.deepPurple,
                child: Container(
                  width: 150,
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Elevation: ${_basicElevation.toStringAsFixed(1)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const SizedBox(width: 80, child: Text('Elevation:')),
                Expanded(
                  child: Slider(
                    value: _basicElevation,
                    min: 0,
                    max: 30,
                    onChanged: (v) {
                      setState(() => _basicElevation = v);
                      print('Elevation: ${v.toStringAsFixed(1)}');
                    },
                  ),
                ),
                SizedBox(width: 40, child: Text(_basicElevation.toStringAsFixed(1))),
              ],
            ),

            print('Basic elevation section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Shape & Border Radius
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildShapeSection() {
    print('=== SECTION 2: Shape & Border Radius ===');
    print('PhysicalModel supports BoxShape.rectangle and BoxShape.circle');
    print('Border radius only applies to rectangle shape');
    print('Current shape: $_shapeType (0=rectangle, 1=circle)');
    print('Current border radius: $_borderRadius');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shape variations:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Shape selector
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Rectangle'),
                  selected: _shapeType == 0,
                  onSelected: (_) {
                    setState(() => _shapeType = 0);
                    print('Shape: Rectangle');
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Circle'),
                  selected: _shapeType == 1,
                  onSelected: (_) {
                    setState(() => _shapeType = 1);
                    print('Shape: Circle');
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Border radius (only for rectangle)
            if (_shapeType == 0) ...[
              Row(
                children: [
                  const SizedBox(width: 100, child: Text('Border Radius:')),
                  Expanded(
                    child: Slider(
                      value: _borderRadius,
                      min: 0,
                      max: 50,
                      onChanged: (v) {
                        setState(() => _borderRadius = v);
                        print('Border radius: ${v.toStringAsFixed(1)}');
                      },
                    ),
                  ),
                  SizedBox(width: 40, child: Text(_borderRadius.toStringAsFixed(0))),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // Demo
            Center(
              child: PhysicalModel(
                elevation: 8,
                color: Colors.amber.shade100,
                shape: _shapeType == 0 ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: _shapeType == 0 ? BorderRadius.circular(_borderRadius) : null,
                shadowColor: Colors.amber.shade700,
                child: Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _shapeType == 0 ? Icons.crop_square : Icons.circle,
                        color: Colors.amber.shade700,
                        size: 32,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _shapeType == 0 ? 'Rectangle' : 'Circle',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber.shade800),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Shape comparison
            const Text('All shape variants:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Rectangle with sharp corners
                Column(
                  children: [
                    PhysicalModel(
                      elevation: 6,
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.zero,
                      shadowColor: Colors.blue,
                      child: const SizedBox(width: 60, height: 60),
                    ),
                    const SizedBox(height: 8),
                    const Text('Sharp', style: TextStyle(fontSize: 11)),
                  ],
                ),
                // Rectangle with slight radius
                Column(
                  children: [
                    PhysicalModel(
                      elevation: 6,
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                      shadowColor: Colors.green,
                      child: const SizedBox(width: 60, height: 60),
                    ),
                    const SizedBox(height: 8),
                    const Text('Rounded', style: TextStyle(fontSize: 11)),
                  ],
                ),
                // Rectangle with pill shape
                Column(
                  children: [
                    PhysicalModel(
                      elevation: 6,
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.orange,
                      child: const SizedBox(width: 60, height: 60),
                    ),
                    const SizedBox(height: 8),
                    const Text('Pill', style: TextStyle(fontSize: 11)),
                  ],
                ),
                // Circle
                Column(
                  children: [
                    PhysicalModel(
                      elevation: 6,
                      color: Colors.purple.shade100,
                      shape: BoxShape.circle,
                      shadowColor: Colors.purple,
                      child: const SizedBox(width: 60, height: 60),
                    ),
                    const SizedBox(height: 8),
                    const Text('Circle', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),

            print('Shape section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Shadow Colors
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildShadowColorSection() {
    print('=== SECTION 3: Shadow Colors ===');
    print('shadowColor determines the color of the elevation shadow');
    print('Current shadow color: $_shadowColor');
    print('Shadow opacity: $_shadowOpacity');

    final shadowColors = [
      ('Black', Colors.black),
      ('Red', Colors.red),
      ('Blue', Colors.blue),
      ('Green', Colors.green),
      ('Purple', Colors.purple),
      ('Orange', Colors.orange),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shadow color variations:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Color selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: shadowColors.map((entry) {
                return ChoiceChip(
                  label: Text(entry.$1),
                  selected: _shadowColor == entry.$2,
                  onSelected: (_) {
                    setState(() => _shadowColor = entry.$2);
                    print('Shadow color: ${entry.$1}');
                  },
                  avatar: CircleAvatar(backgroundColor: entry.$2, radius: 8),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Opacity slider
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Opacity:')),
                Expanded(
                  child: Slider(
                    value: _shadowOpacity,
                    min: 0,
                    max: 1,
                    onChanged: (v) {
                      setState(() => _shadowOpacity = v);
                      print('Shadow opacity: ${v.toStringAsFixed(2)}');
                    },
                  ),
                ),
                SizedBox(width: 40, child: Text(_shadowOpacity.toStringAsFixed(2))),
              ],
            ),

            const SizedBox(height: 16),

            // Demo
            Center(
              child: PhysicalModel(
                elevation: 16,
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                shadowColor: _shadowColor.withValues(alpha: _shadowOpacity),
                child: Container(
                  width: 160,
                  height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _shadowColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Shadow: ${shadowColors.firstWhere((e) => e.$2 == _shadowColor).$1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // All colors comparison
            const Text('Shadow color comparison:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: shadowColors.map((entry) {
                return Column(
                  children: [
                    PhysicalModel(
                      elevation: 12,
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      shadowColor: entry.$2,
                      child: const SizedBox(width: 50, height: 50),
                    ),
                    const SizedBox(height: 8),
                    Text(entry.$1, style: const TextStyle(fontSize: 11)),
                  ],
                );
              }).toList(),
            ),

            print('Shadow color section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Model Colors
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildModelColorSection() {
    print('=== SECTION 4: Model Colors ===');
    print('The color property sets the surface color of the model');
    print('This is the physical surface color, not child background');
    print('Current color index: $_colorIndex');

    final colors = [
      ('White', Colors.white),
      ('Grey', Colors.grey.shade200),
      ('Blue', Colors.blue.shade100),
      ('Green', Colors.green.shade100),
      ('Pink', Colors.pink.shade100),
      ('Yellow', Colors.yellow.shade100),
      ('Deep Purple', Colors.deepPurple.shade100),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Model surface color:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Color selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(colors.length, (index) {
                return ChoiceChip(
                  label: Text(colors[index].$1),
                  selected: _colorIndex == index,
                  onSelected: (_) {
                    setState(() => _colorIndex = index);
                    print('Model color: ${colors[index].$1}');
                  },
                  avatar: CircleAvatar(backgroundColor: colors[index].$2, radius: 8),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Demo
            Center(
              child: PhysicalModel(
                elevation: 10,
                color: colors[_colorIndex].$2,
                borderRadius: BorderRadius.circular(20),
                shadowColor: Colors.black54,
                child: Container(
                  width: 180,
                  height: 120,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.palette, size: 36, color: Colors.grey.shade600),
                      const SizedBox(height: 8),
                      Text(
                        colors[_colorIndex].$1,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Note: The color fills the entire model surface and clips the child.',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
            ),

            print('Model color section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Clipping Behavior
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildClippingSection() {
    print('=== SECTION 5: Clipping Behavior ===');
    print('PhysicalModel clips its child to the model shape');
    print('clipBehavior controls how content is clipped');
    print('Current clip enabled: $_clipBehavior');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clipping demonstrates shape boundary:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text('Enable clipping: '),
                Switch(
                  value: _clipBehavior,
                  onChanged: (v) {
                    setState(() => _clipBehavior = v);
                    print('Clipping: $v');
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Demo: Content that overflows
            Center(
              child: PhysicalModel(
                elevation: 8,
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(20),
                shadowColor: Colors.teal,
                clipBehavior: _clipBehavior ? Clip.antiAlias : Clip.none,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Background
                      Container(color: Colors.teal.shade100),
                      // Overflowing content
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          width: 180,
                          height: 40,
                          color: Colors.red.shade400,
                          alignment: Alignment.center,
                          child: const Text(
                            'Overflowing Content',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      // Another overflow
                      Positioned(
                        bottom: -20,
                        right: 10,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Center indicator
                      const Center(
                        child: Icon(Icons.crop, size: 40, color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              _clipBehavior
                  ? 'Clip.antiAlias: Content is clipped to model bounds'
                  : 'Clip.none: Content can overflow model bounds',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 24),

            // Clip modes comparison
            const Text('Clip modes:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildClipDemo('none', Clip.none),
                _buildClipDemo('hardEdge', Clip.hardEdge),
                _buildClipDemo('antiAlias', Clip.antiAlias),
                _buildClipDemo('antiAliasWithSaveLayer', Clip.antiAliasWithSaveLayer),
              ],
            ),

            print('Clipping section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  Widget _buildClipDemo(String name, Clip clip) {
    return Column(
      children: [
        PhysicalModel(
          elevation: 4,
          color: Colors.blue.shade50,
          shape: BoxShape.circle,
          clipBehavior: clip,
          child: Container(
            width: 60,
            height: 60,
            color: Colors.blue.shade200,
            child: const Align(
              alignment: Alignment(0, -0.5),
              child: Icon(Icons.arrow_upward, color: Colors.blue),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 9)),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Animated Elevation
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAnimatedElevationSection() {
    print('=== SECTION 6: Animated Elevation ===');
    print('Use AnimatedPhysicalModel for smooth transitions');
    print('Or TweenAnimationBuilder with regular PhysicalModel');
    print('Current animated elevation: $_animatedElevation');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedPhysicalModel smoothly transitions elevation:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Demo with AnimatedPhysicalModel
            Center(
              child: AnimatedPhysicalModel(
                duration: const Duration(milliseconds: 300),
                elevation: _animatedElevation,
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(16),
                shadowColor: Colors.indigo,
                shape: BoxShape.rectangle,
                child: Container(
                  width: 160,
                  height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.animation, color: Colors.indigo),
                      const SizedBox(height: 4),
                      Text(
                        'Elevation: ${_animatedElevation.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Elevation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [0.0, 4.0, 8.0, 16.0, 24.0].map((elev) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _animatedElevation = elev);
                      print('Animated elevation: $elev');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _animatedElevation == elev ? Colors.indigo : null,
                      foregroundColor: _animatedElevation == elev ? Colors.white : null,
                    ),
                    child: Text(elev.toInt().toString()),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Hover effect simulation
            const Text('Hover effect (tap to toggle):', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return _HoverElevationCard(
                  label: 'Card ${index + 1}',
                  color: [Colors.red, Colors.green, Colors.blue][index],
                );
              }),
            ),

            print('Animated elevation section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: PhysicalModel vs Material
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildComparisonSection() {
    print('=== SECTION 7: PhysicalModel vs Material ===');
    print('PhysicalModel: Lower-level, direct control');
    print('Material: Higher-level, respects theme');
    print('Card: Material with defaults, most convenient');
    print('Comparison elevation: $_compareElevation');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comparing PhysicalModel, Material, and Card:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const SizedBox(width: 80, child: Text('Elevation:')),
                Expanded(
                  child: Slider(
                    value: _compareElevation,
                    min: 0,
                    max: 20,
                    onChanged: (v) {
                      setState(() => _compareElevation = v);
                      print('Comparison elevation: ${v.toStringAsFixed(1)}');
                    },
                  ),
                ),
                SizedBox(width: 40, child: Text(_compareElevation.toStringAsFixed(0))),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // PhysicalModel
                Column(
                  children: [
                    PhysicalModel(
                      elevation: _compareElevation,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      shadowColor: Colors.black,
                      child: Container(
                        width: 90,
                        height: 70,
                        alignment: Alignment.center,
                        child: const Text('Physical\nModel', textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('PhysicalModel', style: TextStyle(fontSize: 11)),
                  ],
                ),

                // Material
                Column(
                  children: [
                    Material(
                      elevation: _compareElevation,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      shadowColor: Colors.black,
                      child: Container(
                        width: 90,
                        height: 70,
                        alignment: Alignment.center,
                        child: const Text('Material', textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Material', style: TextStyle(fontSize: 11)),
                  ],
                ),

                // Card
                Column(
                  children: [
                    Card(
                      elevation: _compareElevation,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        width: 90,
                        height: 70,
                        alignment: Alignment.center,
                        child: const Text('Card', textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Card', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Comparison table
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Key differences:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('• PhysicalModel: Direct control, fixed color, no ripples'),
                  Text('• Material: Theme-aware, supports InkWell effects'),
                  Text('• Card: Material + default styling + margin'),
                ],
              ),
            ),

            print('Comparison section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPracticalUseCasesSection() {
    print('=== SECTION 8: Practical Use Cases ===');
    print('PhysicalModel is useful for:');
    print('  - Custom buttons without Material overhead');
    print('  - Floating action indicators');
    print('  - Avatar badges');
    print('  - Toast notifications');

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

            // Use Case 1: Custom Button
            const Text('1. Custom Button:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: GestureDetector(
                onTapDown: (_) => print('Button pressed'),
                onTapUp: (_) => print('Button released'),
                child: PhysicalModel(
                  elevation: 6,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                  shadowColor: Colors.blue.shade700,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.send, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Send Message', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Use Case 2: Floating Badge
            const Text('2. Floating Badge:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  PhysicalModel(
                    elevation: 4,
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    child: const SizedBox(width: 80, height: 80),
                  ),
                  Positioned(
                    top: -8,
                    right: -8,
                    child: PhysicalModel(
                      elevation: 8,
                      color: Colors.red,
                      shape: BoxShape.circle,
                      child: const SizedBox(
                        width: 28,
                        height: 28,
                        child: Center(
                          child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Use Case 3: Avatar Group
            const Text('3. Avatar Group:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: SizedBox(
                width: 180,
                height: 50,
                child: Stack(
                  children: List.generate(4, (index) {
                    return Positioned(
                      left: index * 35.0,
                      child: PhysicalModel(
                        elevation: 4,
                        color: [Colors.blue, Colors.green, Colors.orange, Colors.purple][index],
                        shape: BoxShape.circle,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              ['A', 'B', 'C', 'D'][index],
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Use Case 4: Toast/Snackbar style
            const Text('4. Toast Notification:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: PhysicalModel(
                elevation: 12,
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 12),
                      Text('Message sent successfully', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Use Case 5: Floating Action Button
            const Text('5. Custom FAB:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: PhysicalModel(
                elevation: 10,
                color: Colors.deepOrange,
                shape: BoxShape.circle,
                shadowColor: Colors.deepOrange.shade700,
                child: const SizedBox(
                  width: 56,
                  height: 56,
                  child: Center(
                    child: Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),

            print('Practical use cases section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // API Reference
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildApiReference() {
    print('=== API Reference Summary ===');
    print('PhysicalModel Properties:');
    print('  - color: Color - Surface color of the model');
    print('  - elevation: double - Z-depth of the model');
    print('  - shape: BoxShape - rectangle or circle');
    print('  - borderRadius: BorderRadius? - For rectangles only');
    print('  - shadowColor: Color - Color of the shadow');
    print('  - clipBehavior: Clip - How to clip child');
    print('');
    print('AnimatedPhysicalModel adds:');
    print('  - duration: Duration - Animation duration');
    print('  - curve: Curve - Animation curve');

    return Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PhysicalModel API',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),

            _buildApiRow('color', 'Color', 'Surface color of the physical model'),
            _buildApiRow('elevation', 'double', 'Z-depth that creates shadow'),
            _buildApiRow('shape', 'BoxShape', 'rectangle or circle'),
            _buildApiRow('borderRadius', 'BorderRadius?', 'Corners (rectangles only)'),
            _buildApiRow('shadowColor', 'Color', 'Color of elevation shadow'),
            _buildApiRow('clipBehavior', 'Clip', 'How to clip child content'),
            _buildApiRow('child', 'Widget?', 'Content of the model'),

            const SizedBox(height: 12),
            const Text(
              'AnimatedPhysicalModel:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            _buildApiRow('duration', 'Duration', 'Transition animation duration'),
            _buildApiRow('curve', 'Curve', 'Animation easing curve'),
            _buildApiRow('onEnd', 'VoidCallback?', 'Called when animation ends'),

            const SizedBox(height: 12),
            const Text(
              'Performance Tips:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• Use Clip.hardEdge for better performance when aliasing not needed'),
            const Text('• PhysicalModel is cheaper than Material widget'),
            const Text('• For ripple effects, use Material instead'),
            const Text('• Shadow rendering is GPU-accelerated'),
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
            width: 100,
            child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            width: 100,
            child: Text(type, style: const TextStyle(fontFamily: 'monospace', color: Colors.deepPurple, fontSize: 12)),
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
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Helper: Hover elevation card for animated section
// ═══════════════════════════════════════════════════════════════════════════
class _HoverElevationCard extends StatefulWidget {
  final String label;
  final Color color;

  const _HoverElevationCard({required this.label, required this.color});

  @override
  State<_HoverElevationCard> createState() => _HoverElevationCardState();
}

class _HoverElevationCardState extends State<_HoverElevationCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedPhysicalModel(
        duration: const Duration(milliseconds: 150),
        elevation: _isPressed ? 2 : 8,
        color: widget.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        shadowColor: widget.color,
        child: Container(
          width: 80,
          height: 60,
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, color: widget.color),
          ),
        ),
      ),
    );
  }
}
