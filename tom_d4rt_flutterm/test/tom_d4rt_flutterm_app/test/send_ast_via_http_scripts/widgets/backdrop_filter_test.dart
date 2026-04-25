// ignore_for_file: avoid_print
// Deep demo: BackdropFilter - Apply visual effects to content behind
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const BackdropFilterDemo(),
  );
}

class BackdropFilterDemo extends StatefulWidget {
  const BackdropFilterDemo({super.key});

  @override
  State<BackdropFilterDemo> createState() => _BackdropFilterDemoState();
}

class _BackdropFilterDemoState extends State<BackdropFilterDemo> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Blur Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  double _basicBlurX = 5.0;
  double _basicBlurY = 5.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Blur Styles
  // ═══════════════════════════════════════════════════════════════════════════
  ui.TileMode _tileMode = ui.TileMode.clamp;
  double _styleBlur = 10.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Color Matrix Filters
  // ═══════════════════════════════════════════════════════════════════════════
  int _colorMatrixType = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Combined Filters
  // ═══════════════════════════════════════════════════════════════════════════
  double _combinedBlur = 5.0;
  double _combinedOpacity = 1.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Shaped Backdrop
  // ═══════════════════════════════════════════════════════════════════════════
  int _shapeType = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Animated Blur
  // ═══════════════════════════════════════════════════════════════════════════
  double _animatedBlur = 0.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  bool _showDialog = false;
  bool _showNavOverlay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BackdropFilter Deep Demo'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Blur
            _buildSectionHeader('1. Basic Blur Fundamentals'),
            _buildBasicBlurSection(),
            const SizedBox(height: 32),

            // Section 2: Blur Styles
            _buildSectionHeader('2. Blur Tile Modes'),
            _buildBlurStylesSection(),
            const SizedBox(height: 32),

            // Section 3: Color Matrix Filters
            _buildSectionHeader('3. Color Matrix Filters'),
            _buildColorMatrixSection(),
            const SizedBox(height: 32),

            // Section 4: Combined Filters
            _buildSectionHeader('4. Combined Filters'),
            _buildCombinedFiltersSection(),
            const SizedBox(height: 32),

            // Section 5: Shaped Backdrop
            _buildSectionHeader('5. Shaped Backdrop Areas'),
            _buildShapedBackdropSection(),
            const SizedBox(height: 32),

            // Section 6: Animated Blur
            _buildSectionHeader('6. Animated Blur Effects'),
            _buildAnimatedBlurSection(),
            const SizedBox(height: 32),

            // Section 7: Practical Use Cases
            _buildSectionHeader('7. Practical Use Cases'),
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
  // Helper: Background pattern for demos
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBackgroundPattern({double height = 200}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.blue, Colors.teal, Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Grid pattern
          for (int i = 0; i < 8; i++)
            for (int j = 0; j < 4; j++)
              Positioned(
                left: 20 + i * 45.0,
                top: 20 + j * 45.0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${i + j}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          // Some text
          const Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              'Background Content',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Blur
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicBlurSection() {
    print('=== SECTION 1: Basic Blur Fundamentals ===');
    print('BackdropFilter applies ImageFilter to content behind it');
    print('sigma X: $_basicBlurX, sigma Y: $_basicBlurY');
    print('Higher sigma = more blur');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gaussian blur with independent X/Y control:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Demo area
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    // Background
                    _buildBackgroundPattern(),
                    // Backdrop filter overlay
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: _basicBlurX, sigmaY: _basicBlurY),
                          child: Container(
                            width: 180,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                            ),
                            child: Center(
                              child: Text(
                                'Blurred Area',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [Shadow(blurRadius: 2, color: Colors.black.withValues(alpha: 0.5))],
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
            ),

            const SizedBox(height: 16),

            // Sigma X slider
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Sigma X:')),
                Expanded(
                  child: Slider(
                    value: _basicBlurX,
                    min: 0,
                    max: 30,
                    onChanged: (v) {
                      setState(() => _basicBlurX = v);
                      print('Sigma X: ${v.toStringAsFixed(1)}');
                    },
                  ),
                ),
                SizedBox(width: 40, child: Text(_basicBlurX.toStringAsFixed(1))),
              ],
            ),

            // Sigma Y slider
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Sigma Y:')),
                Expanded(
                  child: Slider(
                    value: _basicBlurY,
                    min: 0,
                    max: 30,
                    onChanged: (v) {
                      setState(() => _basicBlurY = v);
                      print('Sigma Y: ${v.toStringAsFixed(1)}');
                    },
                  ),
                ),
                SizedBox(width: 40, child: Text(_basicBlurY.toStringAsFixed(1))),
              ],
            ),

            const SizedBox(height: 8),
            const Text(
              'Note: BackdropFilter only affects content visually behind it in the stack.',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
            ),

            print('Basic blur section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Blur Styles (Tile Modes)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBlurStylesSection() {
    print('=== SECTION 2: Blur Tile Modes ===');
    print('TileMode affects how edges are handled:');
    print('  - clamp: Extends edge pixels');
    print('  - repeated: Tiles the content');
    print('  - mirror: Mirrors at edges');
    print('  - decal: Transparent beyond edges');
    print('Selected tile mode: $_tileMode');

    final tileModes = <String, ui.TileMode>{
      'clamp': ui.TileMode.clamp,
      'repeated': ui.TileMode.repeated,
      'mirror': ui.TileMode.mirror,
      'decal': ui.TileMode.decal,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Blur tile mode variations:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Tile mode selector
            Wrap(
              spacing: 8,
              children: tileModes.entries.map((entry) {
                return ChoiceChip(
                  label: Text(entry.key),
                  selected: _tileMode == entry.value,
                  onSelected: (_) {
                    setState(() => _tileMode = entry.value);
                    print('Tile mode: ${entry.key}');
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Blur amount slider
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Blur:')),
                Expanded(
                  child: Slider(
                    value: _styleBlur,
                    min: 0,
                    max: 30,
                    onChanged: (v) {
                      setState(() => _styleBlur = v);
                      print('Style blur: ${v.toStringAsFixed(1)}');
                    },
                  ),
                ),
                SizedBox(width: 40, child: Text(_styleBlur.toStringAsFixed(1))),
              ],
            ),

            const SizedBox(height: 16),

            // Demo
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    // Colorful background
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'FLUTTER',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                    // Backdrop filter
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(
                            sigmaX: _styleBlur,
                            sigmaY: _styleBlur,
                            tileMode: _tileMode,
                          ),
                          child: Container(
                            width: 200,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.1),
                              border: Border.all(color: Colors.white54),
                            ),
                            child: Center(
                              child: Text(
                                'TileMode: ${tileModes.entries.firstWhere((e) => e.value == _tileMode).key}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            print('Blur styles section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Color Matrix Filters
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildColorMatrixSection() {
    print('=== SECTION 3: Color Matrix Filters ===');
    print('ImageFilter.matrix applies 5x4 color matrix transformations');
    print('Common effects: grayscale, sepia, invert, etc.');
    print('Selected matrix type: $_colorMatrixType');

    // Identity matrix (no change)
    const identity = <double>[
      1, 0, 0, 0, 0, // Red
      0, 1, 0, 0, 0, // Green
      0, 0, 1, 0, 0, // Blue
      0, 0, 0, 1, 0, // Alpha
    ];

    // Grayscale matrix
    const grayscale = <double>[
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0, 0, 0, 1, 0,
    ];

    // Sepia matrix
    const sepia = <double>[
      0.393, 0.769, 0.189, 0, 0,
      0.349, 0.686, 0.168, 0, 0,
      0.272, 0.534, 0.131, 0, 0,
      0, 0, 0, 1, 0,
    ];

    // Invert matrix
    const invert = <double>[
      -1, 0, 0, 0, 255,
      0, -1, 0, 0, 255,
      0, 0, -1, 0, 255,
      0, 0, 0, 1, 0,
    ];

    // High contrast
    const highContrast = <double>[
      2, 0, 0, 0, -128,
      0, 2, 0, 0, -128,
      0, 0, 2, 0, -128,
      0, 0, 0, 1, 0,
    ];

    final matrices = [identity, grayscale, sepia, invert, highContrast];
    final matrixNames = ['Identity', 'Grayscale', 'Sepia', 'Invert', 'High Contrast'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Color matrix transformations:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Matrix selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(matrixNames.length, (index) {
                return ChoiceChip(
                  label: Text(matrixNames[index]),
                  selected: _colorMatrixType == index,
                  onSelected: (_) {
                    setState(() => _colorMatrixType = index);
                    print('Color matrix: ${matrixNames[index]}');
                  },
                );
              }),
            ),

            const SizedBox(height: 16),

            // Demo — color matrices belong to ColorFilter.matrix (5x4 = 20
            // entries), not ImageFilter.matrix (geometric 4x4 = 16 entries).
            // BackdropFilter takes ImageFilter, so the right widget for color
            // matrix transforms is ColorFiltered wrapping the content to be
            // tinted.
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(matrices[_colorMatrixType]),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const NetworkImage('https://picsum.photos/400/200'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.transparent.withValues(alpha: 0), BlendMode.dst),
                        onError: (_, __) {},
                      ),
                      gradient: const LinearGradient(
                        colors: [Colors.pink, Colors.purple, Colors.indigo, Colors.cyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 60, color: Colors.white.withValues(alpha: 0.8)),
                          const SizedBox(height: 8),
                          Text('Sample Content', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 18)),
                          const SizedBox(height: 8),
                          Text(
                            matrixNames[_colorMatrixType],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              'Note: Color matrices transform RGBA values using a 5x4 matrix multiplication.',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
            ),

            print('Color matrix section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Combined Filters
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCombinedFiltersSection() {
    print('=== SECTION 4: Combined Filters ===');
    print('Multiple filters can be combined with ImageFilter.compose');
    print('Blur: $_combinedBlur, Overlay opacity: $_combinedOpacity');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Blur combined with color overlay:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Controls
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Blur:')),
                Expanded(
                  child: Slider(
                    value: _combinedBlur,
                    min: 0,
                    max: 20,
                    onChanged: (v) {
                      setState(() => _combinedBlur = v);
                      print('Combined blur: ${v.toStringAsFixed(1)}');
                    },
                  ),
                ),
                SizedBox(width: 40, child: Text(_combinedBlur.toStringAsFixed(1))),
              ],
            ),

            Row(
              children: [
                const SizedBox(width: 80, child: Text('Overlay:')),
                Expanded(
                  child: Slider(
                    value: _combinedOpacity,
                    min: 0,
                    max: 1,
                    onChanged: (v) {
                      setState(() => _combinedOpacity = v);
                      print('Overlay opacity: ${v.toStringAsFixed(2)}');
                    },
                  ),
                ),
                SizedBox(width: 40, child: Text(_combinedOpacity.toStringAsFixed(2))),
              ],
            ),

            const SizedBox(height: 16),

            // Demo
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    _buildBackgroundPattern(),
                    // Combined effect
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: _combinedBlur, sigmaY: _combinedBlur),
                          child: Container(
                            color: Colors.teal.withValues(alpha: _combinedOpacity * 0.5),
                            child: const Center(
                              child: Text(
                                'Blur + Color Overlay',
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
                  ],
                ),
              ),
            ),

            print('Combined filters section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Shaped Backdrop
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildShapedBackdropSection() {
    print('=== SECTION 5: Shaped Backdrop Areas ===');
    print('BackdropFilter requires ClipRect/ClipRRect/ClipOval to define area');
    print('Without clip, entire stack is affected');
    print('Selected shape: $_shapeType');

    Widget buildShapedFilter(int shapeIndex) {
      Widget child = BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            border: Border.all(color: Colors.white),
          ),
        ),
      );

      switch (shapeIndex) {
        case 0:
          return ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: child,
          );
        case 1:
          return ClipOval(child: child);
        case 2:
          return ClipPath(
            clipper: _DiamondClipper(),
            child: child,
          );
        case 3:
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: child,
          );
        default:
          return ClipRect(child: child);
      }
    }

    final shapeNames = ['Circle (RRect)', 'Oval', 'Diamond', 'Rounded', 'Rectangle'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Different clip shapes for backdrop:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Shape selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(shapeNames.length, (index) {
                return ChoiceChip(
                  label: Text(shapeNames[index]),
                  selected: _shapeType == index,
                  onSelected: (_) {
                    setState(() => _shapeType = index);
                    print('Shape: ${shapeNames[index]}');
                  },
                );
              }),
            ),

            const SizedBox(height: 16),

            // Demo
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    _buildBackgroundPattern(),
                    Center(child: buildShapedFilter(_shapeType)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Current shape: ${shapeNames[_shapeType]}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),

            print('Shaped backdrop section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Animated Blur
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAnimatedBlurSection() {
    print('=== SECTION 6: Animated Blur Effects ===');
    print('BackdropFilter can be animated by updating filter values');
    print('Use TweenAnimationBuilder or AnimationController');
    print('Current animated blur: $_animatedBlur');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive blur animation:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Demo with animated blur
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    _buildBackgroundPattern(),
                    Positioned.fill(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: _animatedBlur),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) {
                          return BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: value, sigmaY: value),
                            child: Container(
                              color: Colors.transparent,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.blur_on, size: 48, color: Colors.white),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Blur: ${value.toStringAsFixed(1)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Blur level buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [0.0, 5.0, 10.0, 15.0, 20.0].map((blur) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _animatedBlur = blur);
                      print('Animated blur target: $blur');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _animatedBlur == blur ? Colors.teal : null,
                    ),
                    child: Text(blur.toInt().toString()),
                  ),
                );
              }).toList(),
            ),

            print('Animated blur section rendered'),
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
    print('BackdropFilter is commonly used for:');
    print('  - Frosted glass dialogs');
    print('  - Blurred navigation overlays');
    print('  - iOS-style blur effects');
    print('  - Image overlays');

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

            // Use Case 1: Frosted Glass Dialog
            const Text('1. Frosted Glass Dialog:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    _buildBackgroundPattern(height: 180),
                    if (_showDialog)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.3),
                              child: Center(
                                child: Container(
                                  width: 250,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Frosted Dialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      const SizedBox(height: 8),
                                      const Text('This dialog has a frosted glass effect behind it.'),
                                      const SizedBox(height: 12),
                                      ElevatedButton(
                                        onPressed: () => setState(() => _showDialog = false),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!_showDialog)
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => _showDialog = true);
                              print('Dialog shown');
                            },
                            child: const Text('Show Dialog'),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Use Case 2: Navigation Overlay
            const Text('2. Blurred Navigation:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    _buildBackgroundPattern(height: 180),
                    // Bottom navigation with blur
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: _showNavOverlay ? 15 : 0, sigmaY: _showNavOverlay ? 15 : 0),
                          child: Container(
                            height: 60,
                            color: Colors.white.withValues(alpha: _showNavOverlay ? 0.7 : 0.95),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(icon: const Icon(Icons.home), onPressed: () {}),
                                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                                IconButton(icon: const Icon(Icons.favorite), onPressed: () {}),
                                IconButton(icon: const Icon(Icons.person), onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Blur navigation: '),
                Switch(
                  value: _showNavOverlay,
                  onChanged: (v) {
                    setState(() => _showNavOverlay = v);
                    print('Nav blur: $v');
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Use Case 3: iOS-style card
            const Text('3. iOS-style Blur Card:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    _buildBackgroundPattern(height: 150),
                    Positioned(
                      left: 16,
                      right: 16,
                      top: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.music_note, color: Colors.white, size: 32),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Now Playing', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                      Text('Beautiful Song', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Icon(Icons.play_arrow, color: Colors.white, size: 32),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
    print('BackdropFilter Properties:');
    print('  - filter: ImageFilter - The filter to apply');
    print('  - blendMode: BlendMode - How filter composites');
    print('  - child: Widget? - Widget above the filter');
    print('');
    print('Common ImageFilter factories (geometric transforms):');
    print('  - ImageFilter.blur(sigmaX, sigmaY, tileMode)');
    print('  - ImageFilter.matrix(Float64List)  // 4x4 = 16 entries');
    print('  - ImageFilter.compose(outer, inner)');
    print('  - ImageFilter.dilate(radiusX, radiusY)');
    print('  - ImageFilter.erode(radiusX, radiusY)');
    print('For color matrix transforms use ColorFilter.matrix + ColorFiltered');

    return Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BackdropFilter API',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),

            _buildApiRow('filter', 'ImageFilter', 'Filter to apply to backdrop'),
            _buildApiRow('blendMode', 'BlendMode', 'Blend mode for composition (default: srcOver)'),
            _buildApiRow('child', 'Widget?', 'Widget to display above the filter'),

            const SizedBox(height: 12),
            const Text(
              'ImageFilter Factories:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• blur(sigmaX, sigmaY, [tileMode]) - Gaussian blur'),
            const Text('• matrix(Float64List 4x4) - Geometric transform (use ColorFilter.matrix for color)'),
            const Text('• compose(outer, inner) - Chain two filters'),
            const Text('• dilate(radiusX, radiusY) - Morphological dilation'),
            const Text('• erode(radiusX, radiusY) - Morphological erosion'),

            const SizedBox(height: 12),
            const Text(
              'Important Notes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• Requires a Clip widget (ClipRect, ClipRRect, ClipOval) to bound effect'),
            const Text('• Only affects content behind in the render tree'),
            const Text('• Can be expensive - use judiciously'),
            const Text('• Common for frosted glass, blur overlays, iOS-style effects'),
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
          color: Colors.teal,
        ),
      ),
    );
  }
}

// Custom diamond clipper for shaped backdrop demo
class _DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
