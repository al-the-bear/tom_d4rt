// ignore_for_file: avoid_print
// Deep demo: ShaderMask - Apply shader-based masks to widgets
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


// D4rt bridge workaround: bridged TickerProvider mixins cannot be used as mixin
mixin _TickerProviderShim<T extends StatefulWidget> on State<T> implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

dynamic build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    home: const ShaderMaskDemo(),
  );
}

class ShaderMaskDemo extends StatefulWidget {
  const ShaderMaskDemo({super.key});

  @override
  State<ShaderMaskDemo> createState() => _ShaderMaskDemoState();
}

class _ShaderMaskDemoState extends State<ShaderMaskDemo>
    with _TickerProviderShim {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Basic Gradient Masks
  // ═══════════════════════════════════════════════════════════════════════════
  int _gradientType = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Blend Modes
  // ═══════════════════════════════════════════════════════════════════════════
  BlendMode _blendMode = BlendMode.srcIn;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Text Effects
  // ═══════════════════════════════════════════════════════════════════════════
  int _textEffect = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Image Effects
  // ═══════════════════════════════════════════════════════════════════════════
  int _imageEffect = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Fade Effects
  // ═══════════════════════════════════════════════════════════════════════════
  int _fadeDirection = 0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Animated Shaders
  // ═══════════════════════════════════════════════════════════════════════════
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShaderMask Deep Demo'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Gradients
            _buildSectionHeader('1. Basic Gradient Masks'),
            _buildBasicGradientSection(),
            const SizedBox(height: 32),

            // Section 2: Blend Modes
            _buildSectionHeader('2. Blend Modes'),
            _buildBlendModeSection(),
            const SizedBox(height: 32),

            // Section 3: Text Effects
            _buildSectionHeader('3. Text Effects'),
            _buildTextEffectsSection(),
            const SizedBox(height: 32),

            // Section 4: Image Effects
            _buildSectionHeader('4. Image Effects'),
            _buildImageEffectsSection(),
            const SizedBox(height: 32),

            // Section 5: Fade Effects
            _buildSectionHeader('5. Fade Effects'),
            _buildFadeEffectsSection(),
            const SizedBox(height: 32),

            // Section 6: Animated Shaders
            _buildSectionHeader('6. Animated Shaders'),
            _buildAnimatedShaderSection(),
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
  // SECTION 1: Basic Gradient Masks
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBasicGradientSection() {
    print('=== SECTION 1: Basic Gradient Masks ===');
    print('ShaderMask applies a shader to mask its child');
    print('Common shaders: LinearGradient, RadialGradient, SweepGradient');
    print('Current gradient type: $_gradientType');

    Shader getShader(Rect bounds) {
      switch (_gradientType) {
        case 0:
          return const LinearGradient(
            colors: [Colors.red, Colors.yellow, Colors.green],
          ).createShader(bounds);
        case 1:
          return const RadialGradient(
            colors: [Colors.purple, Colors.blue, Colors.transparent],
          ).createShader(bounds);
        case 2:
          return const SweepGradient(
            colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.red],
          ).createShader(bounds);
        default:
          return const LinearGradient(colors: [Colors.white, Colors.white]).createShader(bounds);
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Different gradient types:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Gradient type selector
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Linear'),
                  selected: _gradientType == 0,
                  onSelected: (_) {
                    setState(() => _gradientType = 0);
                    print('Gradient: Linear');
                  },
                ),
                ChoiceChip(
                  label: const Text('Radial'),
                  selected: _gradientType == 1,
                  onSelected: (_) {
                    setState(() => _gradientType = 1);
                    print('Gradient: Radial');
                  },
                ),
                ChoiceChip(
                  label: const Text('Sweep'),
                  selected: _gradientType == 2,
                  onSelected: (_) {
                    setState(() => _gradientType = 2);
                    print('Gradient: Sweep');
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Demo
            Center(
              child: ShaderMask(
                shaderCallback: getShader,
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  Icons.star,
                  size: 150,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // All gradient types comparison
            const Text('All gradient types:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGradientDemo(
                  'Linear',
                  (bounds) => const LinearGradient(colors: [Colors.blue, Colors.cyan]).createShader(bounds),
                ),
                _buildGradientDemo(
                  'Radial',
                  (bounds) => const RadialGradient(colors: [Colors.red, Colors.orange]).createShader(bounds),
                ),
                _buildGradientDemo(
                  'Sweep',
                  (bounds) => const SweepGradient(colors: [Colors.purple, Colors.pink, Colors.purple]).createShader(bounds),
                ),
              ],
            ),

            print('Basic gradient section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  Widget _buildGradientDemo(String label, Shader Function(Rect) shaderCallback) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: shaderCallback,
          blendMode: BlendMode.srcIn,
          child: Container(
            width: 80,
            height: 80,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Blend Modes
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBlendModeSection() {
    print('=== SECTION 2: Blend Modes ===');
    print('BlendMode determines how shader composites with child');
    print('Common modes: srcIn, srcATop, modulate, dstIn');
    print('Current blend mode: $_blendMode');

    final blendModes = <String, BlendMode>{
      'srcIn': BlendMode.srcIn,
      'srcATop': BlendMode.srcATop,
      'modulate': BlendMode.modulate,
      'dstIn': BlendMode.dstIn,
      'srcOver': BlendMode.srcOver,
      'multiply': BlendMode.multiply,
      'screen': BlendMode.screen,
      'overlay': BlendMode.overlay,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Blend mode effects:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Blend mode selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: blendModes.entries.map((entry) {
                return ChoiceChip(
                  label: Text(entry.key),
                  selected: _blendMode == entry.value,
                  onSelected: (_) {
                    setState(() => _blendMode = entry.value);
                    print('Blend mode: ${entry.key}');
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Demo with icon
            Center(
              child: Container(
                color: Colors.grey.shade200,
                padding: const EdgeInsets.all(16),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.red, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  blendMode: _blendMode,
                  child: const Icon(
                    Icons.favorite,
                    size: 120,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              'Current: ${blendModes.entries.firstWhere((e) => e.value == _blendMode).key}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Common blend modes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text('• srcIn: Shows shader inside child bounds', style: TextStyle(fontSize: 11)),
                  Text('• srcATop: Shader over child, respecting alpha', style: TextStyle(fontSize: 11)),
                  Text('• modulate: Multiplies colors', style: TextStyle(fontSize: 11)),
                  Text('• dstIn: Child masked by shader alpha', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),

            print('Blend mode section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Text Effects
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTextEffectsSection() {
    print('=== SECTION 3: Text Effects ===');
    print('ShaderMask is great for gradient text effects');
    print('Common effects: rainbow, metallic, fire, ocean');
    print('Current text effect: $_textEffect');

    final effects = [
      (
        'Rainbow',
        const LinearGradient(colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple])
      ),
      (
        'Gold',
        const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFFFFF8DC), Color(0xFFD4AF37)],
          stops: [0.0, 0.5, 1.0],
        )
      ),
      (
        'Silver',
        const LinearGradient(
          colors: [Color(0xFF808080), Color(0xFFC0C0C0), Color(0xFFE8E8E8), Color(0xFFC0C0C0)],
          stops: [0.0, 0.3, 0.6, 1.0],
        )
      ),
      (
        'Fire',
        const LinearGradient(
          colors: [Colors.red, Colors.orange, Colors.yellow],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )
      ),
      ('Ocean', const LinearGradient(colors: [Color(0xFF0077BE), Color(0xFF00C6FF)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gradient text effects:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Effect selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(effects.length, (index) {
                return ChoiceChip(
                  label: Text(effects[index].$1),
                  selected: _textEffect == index,
                  onSelected: (_) {
                    setState(() => _textEffect = index);
                    print('Text effect: ${effects[index].$1}');
                  },
                );
              }),
            ),

            const SizedBox(height: 24),

            // Demo text
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) => effects[_textEffect].$2.createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'FLUTTER',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // All effects showcase
            const Text('All text effects:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            ...effects.map((effect) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(effect.$1, style: const TextStyle(fontSize: 12)),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => effect.$2.createShader(bounds),
                      blendMode: BlendMode.srcIn,
                      child: const Text(
                        'ShaderMask',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            print('Text effects section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Image Effects
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildImageEffectsSection() {
    print('=== SECTION 4: Image Effects ===');
    print('ShaderMask can add gradient overlays to images/icons');
    print('Current image effect: $_imageEffect');

    final imageEffects = [
      ('None', null),
      (
        'Vignette',
        const RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [Colors.transparent, Colors.black87],
        )
      ),
      (
        'Spotlight',
        const RadialGradient(
          center: Alignment.center,
          radius: 0.5,
          colors: [Colors.white, Colors.transparent],
        )
      ),
      (
        'Horizontal Fade',
        const LinearGradient(
          colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
          stops: [0.0, 0.2, 0.8, 1.0],
        )
      ),
      (
        'Duotone',
        const LinearGradient(
          colors: [Colors.cyan, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
    ];

    Widget buildDemoImage() {
      return Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Simple pattern
            for (int i = 0; i < 5; i++)
              Positioned(
                left: 20 + i * 35.0,
                top: 30,
                child: Icon(Icons.star, color: Colors.white.withValues(alpha: 0.6), size: 24),
              ),
            const Center(
              child: Icon(Icons.landscape, size: 60, color: Colors.white),
            ),
          ],
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Image overlay effects:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Effect selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(imageEffects.length, (index) {
                return ChoiceChip(
                  label: Text(imageEffects[index].$1),
                  selected: _imageEffect == index,
                  onSelected: (_) {
                    setState(() => _imageEffect = index);
                    print('Image effect: ${imageEffects[index].$1}');
                  },
                );
              }),
            ),

            const SizedBox(height: 16),

            // Demo
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageEffects[_imageEffect].$2 == null
                    ? buildDemoImage()
                    : ShaderMask(
                        shaderCallback: (bounds) => imageEffects[_imageEffect].$2!.createShader(bounds),
                        blendMode: _imageEffect == 4 ? BlendMode.srcIn : BlendMode.dstIn,
                        child: buildDemoImage(),
                      ),
              ),
            ),

            const SizedBox(height: 8),
            Center(
              child: Text(
                'Effect: ${imageEffects[_imageEffect].$1}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),

            print('Image effects section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Fade Effects
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFadeEffectsSection() {
    print('=== SECTION 5: Fade Effects ===');
    print('ShaderMask is perfect for fade edges on scrollable content');
    print('Common use: list fade at top/bottom');
    print('Current fade direction: $_fadeDirection');

    final directions = ['Top', 'Bottom', 'Both', 'Left', 'Right'];

    LinearGradient getFadeGradient() {
      switch (_fadeDirection) {
        case 0: // Top
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.white],
            stops: [0.0, 0.3],
          );
        case 1: // Bottom
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.transparent],
            stops: [0.7, 1.0],
          );
        case 2: // Both
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
            stops: [0.0, 0.15, 0.85, 1.0],
          );
        case 3: // Left
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.transparent, Colors.white],
            stops: [0.0, 0.3],
          );
        case 4: // Right
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.white, Colors.transparent],
            stops: [0.7, 1.0],
          );
        default:
          return const LinearGradient(colors: [Colors.white, Colors.white]);
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fade edge effects:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Direction selector
            Wrap(
              spacing: 8,
              children: List.generate(directions.length, (index) {
                return ChoiceChip(
                  label: Text(directions[index]),
                  selected: _fadeDirection == index,
                  onSelected: (_) {
                    setState(() => _fadeDirection = index);
                    print('Fade direction: ${directions[index]}');
                  },
                );
              }),
            ),

            const SizedBox(height: 16),

            // Demo: Faded list
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => getFadeGradient().createShader(bounds),
                blendMode: BlendMode.dstIn,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 16,
                            child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                          const SizedBox(width: 12),
                          Text('List item ${index + 1}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              'Scroll the list to see the fade effect at edges.',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
            ),

            print('Fade effects section rendered'),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Animated Shaders
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAnimatedShaderSection() {
    print('=== SECTION 6: Animated Shaders ===');
    print('Combine ShaderMask with AnimationBuilder for dynamic effects');
    print('Animation controller running continuously');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Animated gradient effects:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Animated shimmer text
            const Text('1. Shimmer Text:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: const [
                          Colors.grey,
                          Colors.white,
                          Colors.grey,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                        transform: _SlideGradientTransform(_animController.value * 2 - 0.5),
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      'SHIMMER',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Rotating sweep gradient
            const Text('2. Rotating Sweep:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return SweepGradient(
                        colors: const [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.red],
                        startAngle: _animController.value * 2 * math.pi,
                        endAngle: (_animController.value + 1) * 2 * math.pi,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: const Icon(Icons.settings, size: 80, color: Colors.white),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Pulsing radial
            const Text('3. Pulsing Radial:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  final radius = 0.3 + 0.5 * math.sin(_animController.value * 2 * math.pi);
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return RadialGradient(
                        colors: const [Colors.cyan, Colors.blue, Colors.purple],
                        radius: radius,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(Icons.favorite, color: Colors.white, size: 50),
                      ),
                    ),
                  );
                },
              ),
            ),

            print('Animated shader section rendered'),
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
    print('Common ShaderMask applications:');
    print('  - Logo gradients');
    print('  - Loading skeletons');
    print('  - Highlight effects');
    print('  - Disabled state styling');

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

            // Use Case 1: App Logo
            const Text('1. Gradient Logo:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: const Icon(Icons.flutter_dash, size: 48, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      'MyApp',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Use Case 2: Loading Skeleton
            const Text('2. Loading Skeleton:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.grey.shade300,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    transform: _SlideGradientTransform(_animController.value * 2 - 0.5),
                  ).createShader(bounds),
                  blendMode: BlendMode.srcATop,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: double.infinity, height: 14, color: Colors.grey.shade300),
                              const SizedBox(height: 8),
                              Container(width: 150, height: 14, color: Colors.grey.shade300),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Use Case 3: Disabled State
            const Text('3. Disabled State:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Normal
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Enabled', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 4),
                    const Text('Normal', style: TextStyle(fontSize: 11)),
                  ],
                ),
                const SizedBox(width: 24),
                // Disabled with shader
                Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.grey, Colors.grey],
                      ).createShader(bounds),
                      blendMode: BlendMode.saturation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('Disabled', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Desaturated', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Use Case 4: Badge Highlight
            const Text('4. Premium Badge:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFF8DC), Color(0xFFFFD700)],
                  stops: [0.0, 0.5, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.white),
                      SizedBox(width: 6),
                      Text('PREMIUM', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                    ],
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
    print('ShaderMask Properties:');
    print('  - shaderCallback: (Rect) => Shader');
    print('  - blendMode: BlendMode - How shader blends (default: modulate)');
    print('  - child: Widget? - Widget to mask');
    print('');
    print('Common Shader sources:');
    print('  - LinearGradient.createShader(bounds)');
    print('  - RadialGradient.createShader(bounds)');
    print('  - SweepGradient.createShader(bounds)');
    print('  - ImageShader for texture-based masks');

    return Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ShaderMask API',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),

            _buildApiRow('shaderCallback', '(Rect) => Shader', 'Function that creates shader from bounds'),
            _buildApiRow('blendMode', 'BlendMode', 'How shader composites (default: modulate)'),
            _buildApiRow('child', 'Widget?', 'Widget to be masked'),

            const SizedBox(height: 12),
            const Text(
              'Gradient Shaders:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• LinearGradient - Directional gradient'),
            const Text('• RadialGradient - Circular gradient from center'),
            const Text('• SweepGradient - Angular gradient around center'),

            const SizedBox(height: 12),
            const Text(
              'Key Blend Modes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• srcIn - Show shader inside child alpha'),
            const Text('• dstIn - Show child inside shader alpha'),
            const Text('• modulate - Multiply colors together'),
            const Text('• srcATop - Shader over child, respecting alpha'),

            const SizedBox(height: 12),
            const Text(
              'Performance Notes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('• Shader creation happens every rebuild'),
            const Text('• Cache gradients when possible'),
            const Text('• Avoid complex shaders on large areas'),
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
            width: 120,
            child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            width: 120,
            child: Text(type, style: const TextStyle(fontFamily: 'monospace', color: Colors.deepOrange, fontSize: 12)),
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
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Helper: Gradient transform for shimmer animation
// ═══════════════════════════════════════════════════════════════════════════
class _SlideGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlideGradientTransform(this.slidePercent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
