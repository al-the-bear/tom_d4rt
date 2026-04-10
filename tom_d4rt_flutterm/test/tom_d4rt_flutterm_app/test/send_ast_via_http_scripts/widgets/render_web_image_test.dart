// Deep visual test for RenderWebImage
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

/// Deep visual exploration of RenderWebImage
/// A web-only render object for rendering HTML img elements in Flutter.
///
/// RenderWebImage extends RenderShiftedBox and provides:
/// - Native HTMLImageElement integration on web platform
/// - width/height for controlling size
/// - BoxFit for image fitting within bounds
/// - Alignment positioning
/// - matchTextDirection for RTL support
/// - Clipping when image exceeds bounds
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RenderWebImageDemo(),
  );
}

// =============================================================================
// PALETTE: Brown 700 / LightBlue 400
// =============================================================================
const Color _kPrimary = Color(0xFF5D4037); // Brown 700
const Color _kAccent = Color(0xFF29B6F6); // LightBlue 400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kWeb = Color(0xFF66BB6A);
const Color _kNative = Color(0xFFFFCA28);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RenderWebImageDemo extends StatefulWidget {
  @override
  State<_RenderWebImageDemo> createState() => _RenderWebImageDemoState();
}

class _RenderWebImageDemoState extends State<_RenderWebImageDemo>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RenderWebImage Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.aspect_ratio), text: 'BoxFit Lab'),
            Tab(icon: Icon(Icons.format_textdirection_r_to_l), text: 'RTL & Alignment'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _BoxFitLabTab(),
          _RTLAlignmentTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: THEORY
// =============================================================================
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(),
          SizedBox(height: 24),
          _buildPlatformSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildConstructorSection(),
          SizedBox(height: 24),
          _buildPropertiesSection(),
          SizedBox(height: 24),
          _buildClippingSection(),
          SizedBox(height: 24),
          _buildComparisonSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.web, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RenderWebImage',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'A web-only render object that renders HTML img elements directly '
            'in Flutter, leveraging native browser image handling for optimal '
            'performance on the web platform.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _kWeb,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'WEB ONLY',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This class is only available on Flutter Web platform',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSection() {
    return _TheoryCard(
      title: 'Web Platform Integration',
      icon: Icons.language,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _PlatformCard(
                  title: 'dart:html',
                  icon: Icons.code,
                  color: _kWeb,
                  items: [
                    'HTMLImageElement',
                    'Native DOM element',
                    'Browser image loading',
                    'CSS styling support',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _PlatformCard(
                  title: 'Flutter Web',
                  icon: Icons.flutter_dash,
                  color: _kAccent,
                  items: [
                    'Platform view',
                    'Element positioning',
                    'Size constraints',
                    'Hit testing',
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How It Works:',
                  style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                _StepItem(1, 'Flutter creates HTMLImageElement via dart:html'),
                _StepItem(2, 'Image is positioned via platform view mechanism'),
                _StepItem(3, 'Browser handles image loading and rendering'),
                _StepItem(4, 'RenderWebImage manages size and clipping'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassHierarchySection() {
    return _TheoryCard(
      title: 'Class Hierarchy',
      icon: Icons.account_tree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RenderWebImage extends RenderShiftedBox:',
            style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HierarchyItem(level: 0, name: 'RenderObject', desc: 'Base render tree node'),
                _HierarchyItem(level: 1, name: 'RenderBox', desc: 'Box protocol'),
                _HierarchyItem(level: 2, name: 'RenderShiftedBox', desc: 'Positioned child'),
                _HierarchyItem(level: 3, name: 'RenderWebImage', desc: 'Web image rendering', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          _buildInfoBox(
            'RenderShiftedBox provides positioning via paintOffset. RenderWebImage '
            'uses this to position the native image element based on alignment.',
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildConstructorSection() {
    return _TheoryCard(
      title: 'Constructor',
      icon: Icons.build,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAccent.withOpacity(0.3)),
            ),
            child: Text(
              '''RenderWebImage({
  RenderBox? child,
  required HTMLImageElement image,
  double? width,
  double? height,
  BoxFit? fit,
  AlignmentGeometry alignment = Alignment.center,
  bool matchTextDirection = false,
  TextDirection? textDirection,
})''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 16),
          _ParameterTable(
            parameters: [
              _ParameterInfo('image', 'HTMLImageElement', 'The native HTML image element to render'),
              _ParameterInfo('width', 'double?', 'Requested width (null = intrinsic)'),
              _ParameterInfo('height', 'double?', 'Requested height (null = intrinsic)'),
              _ParameterInfo('fit', 'BoxFit?', 'How to inscribe image into bounds'),
              _ParameterInfo('alignment', 'AlignmentGeometry', 'Position within available space'),
              _ParameterInfo('matchTextDirection', 'bool', 'Flip image for RTL text direction'),
              _ParameterInfo('textDirection', 'TextDirection?', 'Text direction for matching'),
              _ParameterInfo('child', 'RenderBox?', 'Optional child render object'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesSection() {
    return _TheoryCard(
      title: 'Key Properties',
      icon: Icons.settings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PropertyExplainer(
            name: 'image',
            type: 'HTMLImageElement',
            description: 'The native HTML image element. On web, images are created '
                'via dart:html and passed to this render object for display.',
            codeExample: '''// Creating image element on web
final img = HTMLImageElement()
  ..src = 'https://example.com/photo.jpg';
// Pass to RenderWebImage''',
          ),
          Divider(color: _kDivider, height: 32),
          _PropertyExplainer(
            name: 'fit',
            type: 'BoxFit?',
            description: 'Controls how the image is inscribed into the layout bounds. '
                'Same fitting options as Flutter\'s Image widget.',
            codeExample: '''BoxFit.contain  // Fit within, preserve aspect
BoxFit.cover    // Cover all bounds, may clip
BoxFit.fill     // Stretch to fill exactly
BoxFit.none     // No scaling''',
          ),
          Divider(color: _kDivider, height: 32),
          _PropertyExplainer(
            name: 'matchTextDirection',
            type: 'bool',
            description: 'When true and textDirection is RTL, the image is flipped '
                'horizontally. Useful for directional icons designed for LTR.',
            codeExample: '''// Icon points right in LTR
// Flips to point left in RTL
matchTextDirection: true,
textDirection: TextDirection.rtl''',
          ),
        ],
      ),
    );
  }

  Widget _buildClippingSection() {
    return _TheoryCard(
      title: 'Clipping Behavior',
      icon: Icons.crop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RenderWebImage clips when image exceeds available bounds:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ClipScenarioCard(
                  title: 'Needs Clipping',
                  icon: Icons.crop_free,
                  needsClip: true,
                  scenarios: [
                    'BoxFit.cover with small container',
                    'BoxFit.none with large image',
                    'Explicit size smaller than image',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ClipScenarioCard(
                  title: 'No Clipping',
                  icon: Icons.check_box_outline_blank,
                  needsClip: false,
                  scenarios: [
                    'BoxFit.contain always fits',
                    'BoxFit.fill stretches exactly',
                    'Container >= image size',
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '''bool get _needsClip {
  // Compare destination rect with layout bounds
  return _destinationRect.width > size.width ||
         _destinationRect.height > size.height;
}''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'RenderWebImage vs Image Widget',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ComparisonRow(
            feature: 'Platform',
            webImage: 'Web only',
            imageWidget: 'All platforms',
          ),
          _ComparisonRow(
            feature: 'Image Source',
            webImage: 'HTMLImageElement',
            imageWidget: 'ImageProvider',
          ),
          _ComparisonRow(
            feature: 'Rendering',
            webImage: 'Native browser',
            imageWidget: 'Flutter canvas',
          ),
          _ComparisonRow(
            feature: 'Performance',
            webImage: 'Browser optimized',
            imageWidget: 'Framework managed',
          ),
          _ComparisonRow(
            feature: 'CSS Support',
            webImage: 'Native CSS filters',
            imageWidget: 'ColorFilter, etc.',
          ),
          SizedBox(height: 16),
          _buildInfoBox(
            'Use RenderWebImage when you need direct access to browser image APIs '
            'or want to leverage browser-native image handling on web.',
            Icons.lightbulb_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _kAccent, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: BOXFIT LAB
// =============================================================================
class _BoxFitLabTab extends StatefulWidget {
  @override
  State<_BoxFitLabTab> createState() => _BoxFitLabTabState();
}

class _BoxFitLabTabState extends State<_BoxFitLabTab> {
  BoxFit _selectedFit = BoxFit.contain;
  double _containerWidth = 200;
  double _containerHeight = 150;
  final double _imageWidth = 300;
  final double _imageHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BoxFit selector
        Container(
          padding: EdgeInsets.all(12),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select BoxFit:',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: BoxFit.values.map((fit) {
                  final isSelected = _selectedFit == fit;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFit = fit),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? _kPrimary : _kCardBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? _kAccent : _kDivider,
                        ),
                      ),
                      child: Text(
                        fit.name,
                        style: TextStyle(
                          color: isSelected ? _kAccent : _kTextSecondary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        // Size sliders
        Container(
          padding: EdgeInsets.all(12),
          color: _kCardBg,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Container W: ${_containerWidth.toInt()}',
                      style: TextStyle(color: _kTextSecondary, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _containerWidth,
                      min: 50,
                      max: 350,
                      activeColor: _kAccent,
                      onChanged: (v) => setState(() => _containerWidth = v),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Container H: ${_containerHeight.toInt()}',
                      style: TextStyle(color: _kTextSecondary, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _containerHeight,
                      min: 50,
                      max: 300,
                      activeColor: _kAccent,
                      onChanged: (v) => setState(() => _containerHeight = v),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Visualization
        Expanded(
          child: Container(
            color: _kSurface,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container with simulated image
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Original image size indicator (dashed)
                      Container(
                        width: _imageWidth,
                        height: _imageHeight,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _kNative.withOpacity(0.5),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      // Container bounds
                      Container(
                        width: _containerWidth,
                        height: _containerHeight,
                        decoration: BoxDecoration(
                          border: Border.all(color: _kAccent, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: _SimulatedFittedImage(
                            fit: _selectedFit,
                            imageWidth: _imageWidth,
                            imageHeight: _imageHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LegendItem(
                        color: _kAccent,
                        label: 'Container bounds',
                      ),
                      SizedBox(width: 24),
                      _LegendItem(
                        color: _kNative,
                        label: 'Original image size',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Fit description
        Container(
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: _BoxFitDescription(fit: _selectedFit),
        ),
      ],
    );
  }
}

class _SimulatedFittedImage extends StatelessWidget {
  final BoxFit fit;
  final double imageWidth;
  final double imageHeight;

  const _SimulatedFittedImage({
    required this.fit,
    required this.imageWidth,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _kPrimary,
            _kPrimary.withOpacity(0.6),
            Colors.purple.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: FittedBox(
        fit: fit,
        child: SizedBox(
          width: imageWidth,
          height: imageHeight,
          child: Stack(
            children: [
              // Grid pattern to show distortion
              ...List.generate(6, (i) {
                return Positioned(
                  left: i * imageWidth / 6,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 1,
                    color: Colors.white24,
                  ),
                );
              }),
              ...List.generate(4, (i) {
                return Positioned(
                  top: i * imageHeight / 4,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 1,
                    color: Colors.white24,
                  ),
                );
              }),
              // Center label
              Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${imageWidth.toInt()}×${imageHeight.toInt()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 3,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(color: _kTextSecondary, fontSize: 12),
        ),
      ],
    );
  }
}

class _BoxFitDescription extends StatelessWidget {
  final BoxFit fit;

  const _BoxFitDescription({required this.fit});

  String get _description {
    switch (fit) {
      case BoxFit.fill:
        return 'Stretch the image to fill the entire container. May distort aspect ratio.';
      case BoxFit.contain:
        return 'Scale to fit within container while preserving aspect ratio. May leave gaps.';
      case BoxFit.cover:
        return 'Scale to cover entire container while preserving aspect ratio. May clip image.';
      case BoxFit.fitWidth:
        return 'Scale to match container width. Height may exceed or fall short.';
      case BoxFit.fitHeight:
        return 'Scale to match container height. Width may exceed or fall short.';
      case BoxFit.none:
        return 'Display at original size. May be clipped or have gaps.';
      case BoxFit.scaleDown:
        return 'Like contain, but never scales up. Only scales down if too large.';
    }
  }

  bool get _mayClip {
    switch (fit) {
      case BoxFit.cover:
      case BoxFit.fitWidth:
      case BoxFit.fitHeight:
      case BoxFit.none:
        return true;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _kPrimary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'BoxFit.${fit.name}',
            style: TextStyle(
              color: _kAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            _description,
            style: TextStyle(color: _kTextPrimary, fontSize: 13),
          ),
        ),
        if (_mayClip)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.orange),
            ),
            child: Text(
              'May clip',
              style: TextStyle(color: Colors.orange, fontSize: 11),
            ),
          ),
      ],
    );
  }
}

// =============================================================================
// TAB 3: RTL & ALIGNMENT
// =============================================================================
class _RTLAlignmentTab extends StatefulWidget {
  @override
  State<_RTLAlignmentTab> createState() => _RTLAlignmentTabState();
}

class _RTLAlignmentTabState extends State<_RTLAlignmentTab> {
  bool _matchTextDirection = false;
  TextDirection _textDirection = TextDirection.ltr;
  Alignment _alignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMatchTextDirectionSection(),
          SizedBox(height: 24),
          _buildAlignmentSection(),
          SizedBox(height: 24),
          _buildPreviewSection(),
          SizedBox(height: 24),
          _buildCodeSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMatchTextDirectionSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_textdirection_r_to_l, color: _kAccent, size: 22),
              SizedBox(width: 12),
              Text(
                'matchTextDirection',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ToggleCard(
                  title: 'matchTextDirection',
                  value: _matchTextDirection,
                  onChanged: (v) => setState(() => _matchTextDirection = v),
                  description: _matchTextDirection
                      ? 'Image flips for RTL'
                      : 'Image stays same',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _DirectionSelector(
                  direction: _textDirection,
                  onChanged: (d) => setState(() => _textDirection = d),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: _kAccent, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _matchTextDirection && _textDirection == TextDirection.rtl
                        ? 'Image will be flipped horizontally (scale -1 on X axis)'
                        : 'Image displays in original orientation',
                    style: TextStyle(color: _kTextSecondary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlignmentSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.align_horizontal_center, color: _kAccent, size: 22),
              SizedBox(width: 12),
              Text(
                'Alignment',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _AlignmentPicker(
            alignment: _alignment,
            onChanged: (a) => setState(() => _alignment = a),
          ),
          SizedBox(height: 12),
          Text(
            'Current: ${_alignmentString(_alignment)}',
            style: TextStyle(
              color: _kAccent,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.preview, color: _kAccent, size: 22),
              SizedBox(width: 12),
              Text(
                'Preview',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDivider),
            ),
            child: Stack(
              children: [
                // Grid lines
                ..._buildGridLines(),
                // Aligned arrow
                Align(
                  alignment: _alignment,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(
                        (_matchTextDirection && _textDirection == TextDirection.rtl)
                            ? -1.0
                            : 1.0,
                        1.0,
                      ),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _kPrimary,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: _kPrimary.withOpacity(0.5),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: _kAccent,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Arrow icon demonstrates flip behavior',
              style: TextStyle(color: _kTextSecondary, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGridLines() {
    return [
      // Center horizontal
      Positioned(
        top: 100,
        left: 0,
        right: 0,
        child: Container(height: 1, color: _kDivider),
      ),
      // Center vertical
      Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Center(
          child: Container(width: 1, height: double.infinity, color: _kDivider),
        ),
      ),
    ];
  }

  Widget _buildCodeSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: _kAccent, size: 22),
              SizedBox(width: 12),
              Text(
                'Generated Code',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '''RenderWebImage(
  image: htmlImageElement,
  alignment: ${_alignmentString(_alignment)},
  matchTextDirection: $_matchTextDirection,
  textDirection: TextDirection.${_textDirection.name},
)''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _alignmentString(Alignment a) {
    if (a == Alignment.topLeft) return 'Alignment.topLeft';
    if (a == Alignment.topCenter) return 'Alignment.topCenter';
    if (a == Alignment.topRight) return 'Alignment.topRight';
    if (a == Alignment.centerLeft) return 'Alignment.centerLeft';
    if (a == Alignment.center) return 'Alignment.center';
    if (a == Alignment.centerRight) return 'Alignment.centerRight';
    if (a == Alignment.bottomLeft) return 'Alignment.bottomLeft';
    if (a == Alignment.bottomCenter) return 'Alignment.bottomCenter';
    if (a == Alignment.bottomRight) return 'Alignment.bottomRight';
    return 'Alignment(${a.x}, ${a.y})';
  }
}

class _ToggleCard extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String description;

  const _ToggleCard({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value ? _kPrimary.withOpacity(0.2) : _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: value ? _kAccent : _kDivider),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: _kAccent,
              ),
            ],
          ),
          Text(
            description,
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _DirectionSelector extends StatelessWidget {
  final TextDirection direction;
  final ValueChanged<TextDirection> onChanged;

  const _DirectionSelector({
    required this.direction,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        children: [
          Text(
            'textDirection',
            style: TextStyle(
              color: _kTextPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _DirectionButton(
                  label: 'LTR',
                  icon: Icons.format_textdirection_l_to_r,
                  isSelected: direction == TextDirection.ltr,
                  onTap: () => onChanged(TextDirection.ltr),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _DirectionButton(
                  label: 'RTL',
                  icon: Icons.format_textdirection_r_to_l,
                  isSelected: direction == TextDirection.rtl,
                  onTap: () => onChanged(TextDirection.rtl),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DirectionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _DirectionButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? _kPrimary : _kCardBg,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? _kAccent : _kDivider,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? _kAccent : _kTextSecondary,
              size: 20,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? _kAccent : _kTextSecondary,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlignmentPicker extends StatelessWidget {
  final Alignment alignment;
  final ValueChanged<Alignment> onChanged;

  const _AlignmentPicker({
    required this.alignment,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final alignments = [
      [Alignment.topLeft, Alignment.topCenter, Alignment.topRight],
      [Alignment.centerLeft, Alignment.center, Alignment.centerRight],
      [Alignment.bottomLeft, Alignment.bottomCenter, Alignment.bottomRight],
    ];

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: alignments.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((a) {
              final isSelected = alignment == a;
              return GestureDetector(
                onTap: () => onChanged(a),
                child: Container(
                  width: 48,
                  height: 48,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected ? _kPrimary : _kCardBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? _kAccent : _kDivider,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, color: _kAccent, size: 20)
                      : null,
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================
class _TheoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _TheoryCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _kDivider)),
            ),
            child: Row(
              children: [
                Icon(icon, color: _kAccent, size: 22),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _PlatformCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  const _PlatformCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      item,
                      style: TextStyle(color: _kTextSecondary, fontSize: 11),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final int step;
  final String description;

  const _StepItem(this.step, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _kPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$step',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(color: _kTextSecondary, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _HierarchyItem extends StatelessWidget {
  final int level;
  final String name;
  final String desc;
  final bool isHighlighted;

  const _HierarchyItem({
    required this.level,
    required this.name,
    required this.desc,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0, top: level > 0 ? 8 : 0),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: _kDivider),
                  bottom: BorderSide(color: _kDivider),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isHighlighted ? _kAccent.withOpacity(0.2) : _kCardBg,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isHighlighted ? _kAccent : _kDivider,
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: isHighlighted ? _kAccent : _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            desc,
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ParameterInfo {
  final String name;
  final String type;
  final String desc;

  _ParameterInfo(this.name, this.type, this.desc);
}

class _ParameterTable extends StatelessWidget {
  final List<_ParameterInfo> parameters;

  const _ParameterTable({required this.parameters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: parameters
          .map((p) => Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: _kDivider.withOpacity(0.5))),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: TextStyle(
                              color: _kAccent,
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            p.type,
                            style: TextStyle(
                              color: _kTextSecondary,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        p.desc,
                        style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _PropertyExplainer extends StatelessWidget {
  final String name;
  final String type;
  final String description;
  final String codeExample;

  const _PropertyExplainer({
    required this.name,
    required this.type,
    required this.description,
    required this.codeExample,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: _kAccent,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              type,
              style: TextStyle(
                color: _kTextSecondary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(color: _kTextPrimary, height: 1.5),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            codeExample,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _ClipScenarioCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool needsClip;
  final List<String> scenarios;

  const _ClipScenarioCard({
    required this.title,
    required this.icon,
    required this.needsClip,
    required this.scenarios,
  });

  @override
  Widget build(BuildContext context) {
    final color = needsClip ? Colors.orange : _kWeb;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ...scenarios.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: color)),
                    Expanded(
                      child: Text(
                        s,
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String feature;
  final String webImage;
  final String imageWidget;

  const _ComparisonRow({
    required this.feature,
    required this.webImage,
    required this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: _kDivider.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              feature,
              style: TextStyle(
                color: _kTextSecondary,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kWeb.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                webImage,
                style: TextStyle(color: _kWeb, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                imageWidget,
                style: TextStyle(color: _kAccent, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
