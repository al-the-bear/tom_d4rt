// D4rt test script: Comprehensive demo for DecorationPosition from rendering
//
// DecorationPosition is an enum that specifies where a decoration should be
// painted relative to its child widget.
//
// Values:
//   - background: Decoration is painted behind the child
//   - foreground: Decoration is painted in front of the child
//
// This demo shows:
//   1. Visual comparison of background vs foreground positioning
//   2. Effect on different decoration types (gradients, borders, etc.)
//   3. Layering behavior with semi-transparent decorations
//   4. Common use cases for each position
//   5. How position affects readability and visual hierarchy
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kRose100 = Color(0xFFFFE4E6);
const _kRose200 = Color(0xFFFECDD3);
const _kRose300 = Color(0xFFFDA4AF);
const _kRose400 = Color(0xFFFB7185);
const _kRose500 = Color(0xFFF43F5E);
const _kRose600 = Color(0xFFE11D48);
const _kRose700 = Color(0xFFBE123C);
const _kRose800 = Color(0xFF9F1239);

const _kSky100 = Color(0xFFE0F2FE);
const _kSky300 = Color(0xFF7DD3FC);
const _kSky400 = Color(0xFF38BDF8);
const _kSky500 = Color(0xFF0EA5E9);
const _kSky600 = Color(0xFF0284C7);
const _kSky700 = Color(0xFF0369A1);

const _kSlate700 = Color(0xFF334155);
const _kSlate800 = Color(0xFF1E293B);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section header
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kRose700, _kRose500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kRose700.withAlpha(80),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a card with content
Widget _buildCard(String title, Widget content, {Color? accentColor}) {
  final color = accentColor ?? _kRose500;
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(16), child: content),
      ],
    ),
  );
}

/// Builds the main header
Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kRose800, _kRose600, _kRose400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: _kRose800.withAlpha(100),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.layers, color: Colors.white, size: 48),
        const SizedBox(height: 12),
        const Text(
          'DecorationPosition',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Control decoration paint order',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatBadge('background', Icons.flip_to_back),
            const SizedBox(width: 12),
            _buildStatBadge('foreground', Icons.flip_to_front),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStatBadge(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(40),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

/// Builds a layer stack visualization
Widget _buildLayerStack(DecorationPosition position) {
  final isBackground = position == DecorationPosition.background;

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kSlate800.withAlpha(10),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          position.name.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isBackground ? _kRose600 : _kSky600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        // Stack visualization
        SizedBox(
          height: 120,
          width: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bottom layer indicator
              Positioned(
                bottom: 0,
                left: 10,
                right: 10,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: isBackground
                        ? _kRose300.withAlpha(180)
                        : _kSky300.withAlpha(100),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isBackground ? _kRose500 : _kSky400,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isBackground ? 'Decoration' : 'Child',
                      style: TextStyle(
                        color: isBackground ? _kRose700 : _kSky600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Top layer indicator
              Positioned(
                top: 0,
                left: 30,
                right: 30,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: isBackground ? _kSky100 : _kRose200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isBackground ? _kSky500 : _kRose500,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      isBackground ? 'Child' : 'Decoration',
                      style: TextStyle(
                        color: isBackground ? _kSky700 : _kRose700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isBackground
              ? '↑ Child on top, decoration behind'
              : '↑ Decoration on top, covers child',
          style: const TextStyle(fontSize: 11, color: _kSlate700),
        ),
      ],
    ),
  );
}

/// Builds an info card
Widget _buildInfoCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: color.withAlpha(180)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds code snippet display
Widget _buildCodeSnippet(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xFF9CDCFE),
        fontFamily: 'monospace',
        height: 1.4,
      ),
    ),
  );
}

/// Builds use case example with decoration position
Widget _buildUseCaseExample(
  String title,
  String description,
  DecorationPosition position,
  Widget child,
  Decoration decoration,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kRose200),
      boxShadow: [BoxShadow(color: _kRose100.withAlpha(100), blurRadius: 8)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              position == DecorationPosition.background
                  ? Icons.flip_to_back
                  : Icons.flip_to_front,
              color: _kRose600,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: _kRose800,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _kRose100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                position.name,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: _kRose700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: _kSlate700),
        ),
        const SizedBox(height: 12),
        Center(
          child: DecoratedBox(
            position: position,
            decoration: decoration,
            child: child,
          ),
        ),
      ],
    ),
  );
}

/// Builds border example
Widget _buildBorderExample(DecorationPosition position) {
  return Container(
    width: 120,
    height: 80,
    child: DecoratedBox(
      position: position,
      decoration: BoxDecoration(
        border: Border.all(color: _kRose500, width: 4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _kRose100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: Text(
            'Content',
            style: TextStyle(color: _kRose800, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

/// Builds shadow example
Widget _buildShadowExample(DecorationPosition position) {
  return Container(
    width: 120,
    height: 80,
    child: DecoratedBox(
      position: position,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _kRose500.withAlpha(120),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Content',
            style: TextStyle(color: _kSlate800, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

/// Builds pattern overlay example
Widget _buildPatternOverlayExample(DecorationPosition position) {
  return Container(
    width: 120,
    height: 80,
    child: DecoratedBox(
      position: position,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withAlpha(50), Colors.white.withAlpha(0)],
          stops: const [0.0, 0.5],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_kRose400, _kRose600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Card',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

/// Builds the enum values list
Widget _buildEnumValuesList() {
  return Column(
    children: [
      _buildEnumValueRow(
        DecorationPosition.background,
        'Decoration painted behind child',
        Icons.flip_to_back,
        _kRose500,
      ),
      const SizedBox(height: 12),
      _buildEnumValueRow(
        DecorationPosition.foreground,
        'Decoration painted in front of child',
        Icons.flip_to_front,
        _kSky500,
      ),
    ],
  );
}

Widget _buildEnumValueRow(
  DecorationPosition value,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    value.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'index: ${value.index}',
                      style: TextStyle(
                        fontSize: 10,
                        color: color,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: color.withAlpha(180)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a visual comparison row
Widget _buildVisualComparisonRow(
  String label,
  Widget background,
  Widget foreground,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: _kSlate800,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                background,
                const SizedBox(height: 4),
                const Text(
                  'background',
                  style: TextStyle(
                    fontSize: 10,
                    color: _kRose600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            Column(
              children: [
                foreground,
                const SizedBox(height: 4),
                const Text(
                  'foreground',
                  style: TextStyle(
                    fontSize: 10,
                    color: _kSky600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

/// Build translucent effect showcase
Widget _buildTranslucentShowcase() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // Background - child in front visible
      Column(
        children: [
          Container(
            width: 100,
            height: 80,
            child: DecoratedBox(
              position: DecorationPosition.background,
              decoration: BoxDecoration(
                color: _kRose400.withAlpha(150),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.visibility,
                    color: _kRose600,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Child visible',
            style: TextStyle(fontSize: 10, color: _kSlate700),
          ),
        ],
      ),
      // Foreground - decoration covers child
      Column(
        children: [
          Container(
            width: 100,
            height: 80,
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                color: _kSky400.withAlpha(200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.visibility_off,
                    color: _kSky600,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Child obscured',
            style: TextStyle(fontSize: 10, color: _kSlate700),
          ),
        ],
      ),
    ],
  );
}

/// Build real-world use case cards
Widget _buildRealWorldUseCases() {
  return Column(
    children: [
      // Card with shadow (background)
      _buildUseCaseExample(
        'Card with Shadow',
        'Shadow decoration painted behind for depth effect',
        DecorationPosition.background,
        Container(
          width: 150,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Card Content',
              style: TextStyle(color: _kSlate800, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: _kRose400.withAlpha(80),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
      ),

      // Image overlay (foreground)
      _buildUseCaseExample(
        'Image with Gradient Overlay',
        'Gradient painted on top for text readability',
        DecorationPosition.foreground,
        Container(
          width: 150,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [_kRose400, _kRose600]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Stack(
            children: [
              Center(child: Icon(Icons.photo, color: Colors.white, size: 32)),
              Positioned(
                bottom: 8,
                left: 8,
                child: Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                ),
              ),
            ],
          ),
        ),
        BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withAlpha(120)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),

      // Glass morphism effect (foreground)
      _buildUseCaseExample(
        'Glass Effect',
        'Frosted glass effect painted on top',
        DecorationPosition.foreground,
        Container(
          width: 150,
          height: 80,
          decoration: BoxDecoration(
            color: _kSky400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(Icons.auto_awesome, color: Colors.white, size: 32),
          ),
        ),
        BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.white.withAlpha(40), Colors.white.withAlpha(10)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withAlpha(50)),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════════════');
  print('DecorationPosition Deep Demo');
  print('═══════════════════════════════════════════════════════════════');

  // Enumerate all values
  print('\nDecorationPosition values:');
  for (final value in DecorationPosition.values) {
    print('  ${value.name} (index: ${value.index})');
  }

  print('\nEnum properties:');
  print('  Total values: ${DecorationPosition.values.length}');
  print('  First: ${DecorationPosition.values.first.name}');
  print('  Last: ${DecorationPosition.values.last.name}');

  print('\nUsage context:');
  print('  - Used with DecoratedBox widget');
  print('  - Controls paint order relative to child');
  print('  - background: decoration behind child');
  print('  - foreground: decoration in front of child');

  print('\nDecorationPosition demo completed');
  print('═══════════════════════════════════════════════════════════════');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main header
        _buildMainHeader(),
        const SizedBox(height: 24),

        // Section 1: What is DecorationPosition
        _buildSectionHeader('What is DecorationPosition?', Icons.help_outline),
        _buildCard(
          'Overview',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DecorationPosition is an enum that determines whether '
                'a decoration should be painted behind or in front of its child widget.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _buildCodeSnippet(
                'enum DecorationPosition {\n'
                '  background,  // Paint behind child\n'
                '  foreground,  // Paint in front of child\n'
                '}',
              ),
            ],
          ),
        ),

        // Section 2: Enum Values
        _buildSectionHeader('Enum Values', Icons.list),
        _buildCard('All DecorationPosition Values', _buildEnumValuesList()),

        // Section 3: Visual Layer Stack
        _buildSectionHeader('Paint Order Visualization', Icons.layers),
        _buildCard(
          'How Decoration Layers Work',
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildLayerStack(DecorationPosition.background),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildLayerStack(DecorationPosition.foreground),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                'Key Difference',
                'With foreground, decoration can obscure child content if opaque',
                Icons.info,
                _kSky500,
              ),
            ],
          ),
        ),

        // Section 4: Side-by-Side Comparisons
        _buildSectionHeader('Side-by-Side Comparisons', Icons.compare),
        _buildCard(
          'Visual Differences',
          Column(
            children: [
              _buildVisualComparisonRow(
                'Border Decoration',
                _buildBorderExample(DecorationPosition.background),
                _buildBorderExample(DecorationPosition.foreground),
              ),
              _buildVisualComparisonRow(
                'Shadow Decoration',
                _buildShadowExample(DecorationPosition.background),
                _buildShadowExample(DecorationPosition.foreground),
              ),
              _buildVisualComparisonRow(
                'Gradient Shine',
                _buildPatternOverlayExample(DecorationPosition.background),
                _buildPatternOverlayExample(DecorationPosition.foreground),
              ),
            ],
          ),
        ),

        // Section 5: Translucent Effects
        _buildSectionHeader('Translucent Decorations', Icons.opacity),
        _buildCard(
          'Effect of Opacity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Semi-transparent decorations interact differently based on position:',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 16),
              _buildTranslucentShowcase(),
              const SizedBox(height: 12),
              _buildInfoCard(
                'Tip',
                'Use foreground for overlays, background for shadows and backdrops',
                Icons.lightbulb,
                Colors.amber,
              ),
            ],
          ),
        ),

        // Section 6: DecoratedBox Usage
        _buildSectionHeader('Using with DecoratedBox', Icons.widgets),
        _buildCard(
          'Code Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeSnippet(
                '// Background decoration (default)\n'
                'DecoratedBox(\n'
                '  position: DecorationPosition.background,\n'
                '  decoration: BoxDecoration(\n'
                '    color: Colors.blue,\n'
                '    boxShadow: [BoxShadow(...)],\n'
                '  ),\n'
                '  child: Text("Content"),\n'
                ')\n\n'
                '// Foreground decoration (overlay)\n'
                'DecoratedBox(\n'
                '  position: DecorationPosition.foreground,\n'
                '  decoration: BoxDecoration(\n'
                '    gradient: LinearGradient(...),\n'
                '  ),\n'
                '  child: Image.network(url),\n'
                ')',
              ),
            ],
          ),
        ),

        // Section 7: Real-World Use Cases
        _buildSectionHeader('Real-World Use Cases', Icons.apps),
        _buildCard('Practical Examples', _buildRealWorldUseCases()),

        // Section 8: When to Use Each
        _buildSectionHeader('Guidelines', Icons.rule),
        _buildCard(
          'When to Use Each Position',
          Column(
            children: [
              _buildInfoCard(
                'Use background for:',
                'Shadows, glow effects, background colors, border decorations',
                Icons.flip_to_back,
                _kRose500,
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                'Use foreground for:',
                'Gradient overlays, shine effects, loading states, watermarks',
                Icons.flip_to_front,
                _kSky500,
              ),
            ],
          ),
        ),

        // Section 9: Container Integration
        _buildSectionHeader('Container Widget', Icons.crop_square),
        _buildCard(
          'Container decoration parameter',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Note: Container widget always uses DecorationPosition.background '
                'for its decoration parameter. Use DecoratedBox directly for '
                'foreground decorations.',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 16),
              _buildCodeSnippet(
                '// Container (background only)\n'
                'Container(\n'
                '  decoration: myDecoration,  // Always background\n'
                '  child: content,\n'
                ')\n\n'
                '// For foreground, use DecoratedBox\n'
                'DecoratedBox(\n'
                '  position: DecorationPosition.foreground,\n'
                '  decoration: overlayDecoration,\n'
                '  child: Container(...),\n'
                ')',
              ),
            ],
          ),
        ),

        // Footer
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kRose100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Icon(Icons.check_circle, color: _kRose700, size: 32),
              const SizedBox(height: 8),
              const Text(
                'DecorationPosition Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _kRose800,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Control where decorations appear relative to children',
                style: TextStyle(fontSize: 12, color: _kRose600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}
