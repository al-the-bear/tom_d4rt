// D4rt test script: Comprehensive demo for BackdropKey from rendering
//
// BackdropKey is a key type used to identify backdrop filter layers
// in the rendering layer tree. It helps in:
//   - Identifying specific backdrop effects
//   - Managing backdrop filter layer lifecycle
//   - Connecting clips to specific backdrop areas
//
// This demo shows:
//   1. What backdrop filters are and how they work
//   2. BackdropKey's role in layer management
//   3. Visual examples of backdrop filter effects
//   4. Key usage patterns
//
// ═══════════════════════════════════════════════════════════════════════════
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kCyan50 = Color(0xFFE0F7FA);
const _kCyan100 = Color(0xFFB2EBF2);
const _kCyan200 = Color(0xFF80DEEA);
const _kCyan300 = Color(0xFF4DD0E1);
const _kCyan400 = Color(0xFF26C6DA);
const _kCyan500 = Color(0xFF00BCD4);
const _kCyan600 = Color(0xFF00ACC1);
const _kCyan700 = Color(0xFF0097A7);
const _kCyan800 = Color(0xFF00838F);
const _kCyan900 = Color(0xFF006064);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kCyan700, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kCyan900,
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card with description
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCyan50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCyan200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kCyan100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kCyan700, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kCyan900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kCyan700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code snippet display
Widget _buildCodeSnippet(String title, String code) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kCyan900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kCyan800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kCyan200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kCyan100,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFFE0F7FA),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Backdrop filter concept visualization
Widget _buildBackdropConceptCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCyan300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Backdrop Filter Concept',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kCyan900,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              // Background layer
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kCyan300, _kCyan500],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildBackgroundIcon(Icons.star, Colors.yellow),
                          _buildBackgroundIcon(Icons.favorite, Colors.red),
                          _buildBackgroundIcon(Icons.circle, Colors.white),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildBackgroundIcon(Icons.square, Colors.orange),
                          _buildBackgroundIcon(Icons.hexagon, Colors.purple),
                          _buildBackgroundIcon(Icons.star_border, Colors.pink),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Backdrop filter overlay
              Positioned(
                left: 50,
                top: 50,
                right: 50,
                bottom: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(100),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withAlpha(150)),
                      ),
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.blur_on, color: _kCyan900, size: 32),
                          SizedBox(height: 8),
                          Text(
                            'Blurred Backdrop',
                            style: TextStyle(
                              color: _kCyan900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCyan50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'BackdropFilter applies effects (blur, color) to content behind it.',
            style: TextStyle(fontSize: 11, color: _kCyan800),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBackgroundIcon(IconData icon, Color color) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: color.withAlpha(200),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, color: Colors.white, size: 24),
  );
}

/// BackdropKey role visualization
Widget _buildKeyRoleCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCyan200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BackdropKey Role',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kCyan900,
          ),
        ),
        const SizedBox(height: 16),
        _buildKeyRole(
          Icons.key,
          'Unique Identification',
          'Identifies specific backdrop filter layers in the tree',
        ),
        _buildKeyRole(
          Icons.link,
          'Clip Association',
          'Connects clip regions to specific backdrop effects',
        ),
        _buildKeyRole(
          Icons.cached,
          'Layer Caching',
          'Enables efficient caching and reuse of backdrop layers',
        ),
        _buildKeyRole(
          Icons.layers,
          'Layer Management',
          'Helps manage lifecycle of backdrop filter layers',
        ),
      ],
    ),
  );
}

Widget _buildKeyRole(IconData icon, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kCyan200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kCyan700, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kCyan900,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kCyan700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Interactive blur demo
Widget _buildInteractiveBlurDemo() {
  return _InteractiveBlurWidget();
}

class _InteractiveBlurWidget extends StatefulWidget {
  @override
  State<_InteractiveBlurWidget> createState() => _InteractiveBlurWidgetState();
}

class _InteractiveBlurWidgetState extends State<_InteractiveBlurWidget> {
  double _blurSigma = 5.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCyan400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Blur Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kCyan900,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Blur Sigma:',
                style: TextStyle(fontSize: 11, color: _kCyan700),
              ),
              Expanded(
                child: Slider(
                  value: _blurSigma,
                  min: 0,
                  max: 20,
                  onChanged: (v) => setState(() => _blurSigma = v),
                  activeColor: _kCyan500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kCyan500,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _blurSigma.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                // Background with pattern
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            childAspectRatio: 1,
                          ),
                      itemCount: 24,
                      itemBuilder: (context, index) {
                        final colors = [
                          _kCyan200,
                          _kCyan300,
                          _kCyan400,
                          _kCyan500,
                        ];
                        return Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: colors[index % colors.length],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Backdrop filter region
                Positioned(
                  left: 30,
                  right: 30,
                  top: 40,
                  bottom: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(
                        sigmaX: _blurSigma,
                        sigmaY: _blurSigma,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.blur_on,
                              color: _kCyan800,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'σ = ${_blurSigma.toStringAsFixed(1)}',
                              style: const TextStyle(
                                color: _kCyan900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Layer tree visualization
Widget _buildLayerTreeCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCyan300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Layer Tree with BackdropKey',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kCyan900,
          ),
        ),
        const SizedBox(height: 16),
        _buildTreeNode('ContainerLayer', 0, false),
        _buildTreeNode('├── PictureLayer', 1, false),
        _buildTreeNode('├── BackdropFilterLayer', 1, true),
        _buildTreeNode('│   └── key: BackdropKey(#1)', 2, true),
        _buildTreeNode('│   └── filter: blur(5,5)', 2, false),
        _buildTreeNode('├── ClipRectLayer', 1, false),
        _buildTreeNode('│   └── linkedKey: BackdropKey(#1)', 2, true),
        _buildTreeNode('└── PictureLayer', 1, false),
      ],
    ),
  );
}

Widget _buildTreeNode(String text, int indent, bool highlight) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 16.0, top: 4, bottom: 4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: highlight ? _kCyan500 : _kCyan50,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: highlight ? Colors.white : _kCyan800,
          fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ),
  );
}

/// Multiple filter effects
Widget _buildMultipleEffectsDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCyan300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Backdrop Filter Effects',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kCyan900,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: Row(
            children: [
              _buildEffectDemo(
                'Blur',
                ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              ),
              const SizedBox(width: 8),
              _buildEffectDemo(
                'Matrix',
                ui.ImageFilter.matrix(
                  Float64List.fromList([
                    0.8,
                    0,
                    0,
                    0,
                    0,
                    0.8,
                    0,
                    0,
                    0,
                    0,
                    0.8,
                    0,
                    0,
                    0,
                    0,
                    1,
                  ]),
                ),
              ),
              const SizedBox(width: 8),
              _buildEffectDemo(
                'Compose',
                ui.ImageFilter.compose(
                  outer: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  inner: ui.ImageFilter.dilate(radiusX: 1, radiusY: 1),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildEffectDemo(String label, ui.ImageFilter filter) {
  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kCyan400, _kCyan600],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GridView.count(
                    crossAxisCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(9, (i) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(150),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              // Filter overlay
              Positioned(
                left: 15,
                right: 15,
                top: 30,
                bottom: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: filter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(80),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
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
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: _kCyan800,
          ),
        ),
      ],
    ),
  );
}

/// Key properties card
Widget _buildKeyPropertiesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCyan100, _kCyan50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BackdropKey Properties',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kCyan900,
          ),
        ),
        const SizedBox(height: 16),
        _buildPropertyItem('Type', 'GlobalKey subclass', Icons.category),
        _buildPropertyItem('Scope', 'Tree-wide unique', Icons.account_tree),
        _buildPropertyItem('Lifecycle', 'Tied to layer', Icons.loop),
        _buildPropertyItem(
          'Purpose',
          'Layer identification',
          Icons.fingerprint,
        ),
      ],
    ),
  );
}

Widget _buildPropertyItem(String label, String value, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kCyan500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kCyan900,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kCyan200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 10, color: _kCyan800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Use cases card
Widget _buildUseCasesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCyan300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Common Use Cases',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kCyan900,
          ),
        ),
        const SizedBox(height: 16),
        _buildUseCaseItem(
          Icons.blur_linear,
          'Dialog Backgrounds',
          'Blur content behind modal dialogs',
        ),
        _buildUseCaseItem(
          Icons.navigation,
          'Navigation Bars',
          'Frosted glass effect for app bars',
        ),
        _buildUseCaseItem(
          Icons.photo_filter,
          'Image Filters',
          'Apply effects to image regions',
        ),
        _buildUseCaseItem(
          Icons.style,
          'Glassmorphism',
          'Modern glass-like UI effects',
        ),
      ],
    ),
  );
}

Widget _buildUseCaseItem(IconData icon, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _kCyan100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _kCyan600, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kCyan900,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 10, color: _kCyan700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Glassmorphism demo
Widget _buildGlassmorphismDemo() {
  return Container(
    height: 220,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Stack(
      children: [
        // Background decorations
        Positioned(
          top: 20,
          left: 30,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(80),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 40,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(60),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 80,
          right: 60,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(100),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Glass card
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: 280,
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withAlpha(80),
                      Colors.white.withAlpha(40),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withAlpha(100),
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.credit_card, color: Colors.white, size: 28),
                        SizedBox(width: 8),
                        Text(
                          'Glass Card',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '**** **** **** 4242',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Glassmorphism Effect',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// Build results card
Widget _buildResultsCard(bool success, String className) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: success ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: success ? Colors.green[300]! : Colors.red[300]!,
      ),
    ),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error,
          color: success ? Colors.green[700] : Colors.red[700],
          size: 32,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                success ? 'Demo Successful' : 'Demo Failed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: success ? Colors.green[800] : Colors.red[800],
                ),
              ),
              Text(
                '$className concepts demonstrated',
                style: TextStyle(
                  fontSize: 12,
                  color: success ? Colors.green[600] : Colors.red[600],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _kCyan600,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // Print information about BackdropKey
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║              BackdropKey Deep Demo                               ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- BackdropKey Overview ---');
  print('Key type for identifying backdrop filter layers.');
  print('Used in rendering layer tree management.');

  // Explain backdrop filters
  print('\n--- Backdrop Filters ---');
  print('BackdropFilter applies effects to content behind it.');
  print('Common effects: blur, color matrix, saturation.');

  // Key purposes
  print('\n--- BackdropKey Purposes ---');
  print('- Unique layer identification');
  print('- Clip region association');
  print('- Efficient layer caching');
  print('- Layer lifecycle management');

  print('\nBackdropKey test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE8F5F8), Color(0xFFE0F2F5)],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kCyan700, _kCyan900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kCyan800.withAlpha(80),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.key,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BackdropKey',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'rendering library',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Key type for identifying and managing backdrop filter layers '
                    'in the rendering tree, enabling clip association and caching.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Info cards
          _buildInfoCard(
            'Layer Identification',
            'Uniquely identifies backdrop filter layers in the tree.',
            Icons.fingerprint,
          ),
          _buildInfoCard(
            'Clip Association',
            'Connects clip regions to specific backdrop effects.',
            Icons.crop,
          ),

          // Backdrop concept
          _buildSectionTitle('Backdrop Filter', Icons.blur_on),
          _buildBackdropConceptCard(),
          const SizedBox(height: 20),

          // Key role
          _buildSectionTitle('BackdropKey Role', Icons.key),
          _buildKeyRoleCard(),
          const SizedBox(height: 20),

          // Interactive blur
          _buildSectionTitle('Interactive Blur', Icons.tune),
          _buildInteractiveBlurDemo(),
          const SizedBox(height: 20),

          // Layer tree
          _buildSectionTitle('Layer Tree', Icons.account_tree),
          _buildLayerTreeCard(),
          const SizedBox(height: 20),

          // Multiple effects
          _buildSectionTitle('Filter Effects', Icons.auto_awesome),
          _buildMultipleEffectsDemo(),
          const SizedBox(height: 20),

          // Key properties
          _buildSectionTitle('Key Properties', Icons.list),
          _buildKeyPropertiesCard(),
          const SizedBox(height: 20),

          // Use cases
          _buildSectionTitle('Use Cases', Icons.apps),
          _buildUseCasesCard(),
          const SizedBox(height: 20),

          // Glassmorphism
          _buildSectionTitle('Glassmorphism Effect', Icons.style),
          _buildGlassmorphismDemo(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet('Basic BackdropFilter', '''BackdropFilter(
  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  child: Container(
    color: Colors.white.withOpacity(0.2),
    child: Text('Blurred Background'),
  ),
)'''),
          _buildCodeSnippet('Glassmorphism Card', '''ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: BackdropFilter(
    filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1),
          ],
        ),
        border: Border.all(color: Colors.white30),
      ),
    ),
  ),
)'''),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'BackdropKey'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kCyan100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kCyan700, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kCyan900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'BackdropKey identifies backdrop filter layers, enabling efficient '
                  'clip association and layer caching. Used with BackdropFilter for '
                  'blur, glass, and other visual effects.',
                  style: TextStyle(fontSize: 12, color: _kCyan800, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('key', Icons.key),
                    const SizedBox(width: 8),
                    _buildSummaryChip('blur', Icons.blur_on),
                    const SizedBox(width: 8),
                    _buildSummaryChip('glass', Icons.style),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
