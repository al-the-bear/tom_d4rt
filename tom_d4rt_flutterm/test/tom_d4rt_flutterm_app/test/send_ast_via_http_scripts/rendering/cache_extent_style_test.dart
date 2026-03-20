// D4rt test script: Comprehensive demo for CacheExtentStyle from rendering
//
// CacheExtentStyle controls how scrollable widgets pre-build off-screen content.
// It defines the caching behavior for viewport-based scrolling:
//   - pixel: Cache extent measured in logical pixels
//   - viewport: Cache extent measured as viewport fraction
//
// This demo shows:
//   1. What CacheExtentStyle enum values mean
//   2. How cache extent affects scrolling performance
//   3. Visual comparison of caching strategies
//   4. Practical configuration examples
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kAmber50 = Color(0xFFFFF8E1);
const _kAmber100 = Color(0xFFFFECB3);
const _kAmber200 = Color(0xFFFFE082);
const _kAmber300 = Color(0xFFFFD54F);
const _kAmber400 = Color(0xFFFFCA28);
const _kAmber500 = Color(0xFFFFC107);
const _kAmber600 = Color(0xFFFFB300);
const _kAmber700 = Color(0xFFFFA000);
const _kAmber800 = Color(0xFFFF8F00);
const _kAmber900 = Color(0xFFFF6F00);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kAmber800, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kAmber900,
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
      color: _kAmber50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kAmber100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kAmber800, size: 24),
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
                  color: _kAmber900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kAmber800),
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
      color: _kAmber900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kAmber800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kAmber200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kAmber100,
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
              color: Color(0xFFFFF8E1),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Enum values visualization
Widget _buildEnumValuesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CacheExtentStyle Enum Values',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kAmber900,
          ),
        ),
        const SizedBox(height: 16),
        _buildEnumValue(
          'pixel',
          0,
          'Cache extent in logical pixels (default: 250px)',
          Icons.straighten,
        ),
        const SizedBox(height: 12),
        _buildEnumValue(
          'viewport',
          1,
          'Cache extent as fraction of viewport (0.0 to 1.0+)',
          Icons.aspect_ratio,
        ),
      ],
    ),
  );
}

Widget _buildEnumValue(String name, int index, String desc, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kAmber50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kAmber200),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _kAmber500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: _kAmber700, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'CacheExtentStyle.$name',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kAmber900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kAmber700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Cache extent visualization
Widget _buildCacheExtentVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cache Extent Visualization',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kAmber900,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildPixelStyleDemo()),
            const SizedBox(width: 12),
            Expanded(child: _buildViewportStyleDemo()),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPixelStyleDemo() {
  return Container(
    height: 260,
    decoration: BoxDecoration(
      border: Border.all(color: _kAmber300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kAmber500,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
          ),
          child: const Center(
            child: Text(
              'pixel',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              // Top cache region
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 40,
                child: Container(
                  color: _kAmber100,
                  child: const Center(
                    child: Text(
                      '250px cache',
                      style: TextStyle(fontSize: 9, color: _kAmber700),
                    ),
                  ),
                ),
              ),
              // Viewport
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                bottom: 40,
                child: Container(
                  color: _kAmber400,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility, color: Colors.white, size: 24),
                        SizedBox(height: 4),
                        Text(
                          'Viewport',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom cache region
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 40,
                child: Container(
                  color: _kAmber100,
                  child: const Center(
                    child: Text(
                      '250px cache',
                      style: TextStyle(fontSize: 9, color: _kAmber700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            'Fixed 250px',
            style: TextStyle(fontSize: 10, color: _kAmber800),
          ),
        ),
      ],
    ),
  );
}

Widget _buildViewportStyleDemo() {
  return Container(
    height: 260,
    decoration: BoxDecoration(
      border: Border.all(color: _kAmber300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kAmber700,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
          ),
          child: const Center(
            child: Text(
              'viewport',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              // Top cache region (1.0 = full viewport)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 50,
                child: Container(
                  color: _kAmber200,
                  child: const Center(
                    child: Text(
                      '1.0 × viewport',
                      style: TextStyle(fontSize: 9, color: _kAmber800),
                    ),
                  ),
                ),
              ),
              // Viewport
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                bottom: 50,
                child: Container(
                  color: _kAmber700,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility, color: Colors.white, size: 24),
                        SizedBox(height: 4),
                        Text(
                          'Viewport',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom cache region
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 50,
                child: Container(
                  color: _kAmber200,
                  child: const Center(
                    child: Text(
                      '1.0 × viewport',
                      style: TextStyle(fontSize: 9, color: _kAmber800),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            'Scales with viewport',
            style: TextStyle(fontSize: 10, color: _kAmber800),
          ),
        ),
      ],
    ),
  );
}

/// Interactive comparison demo
Widget _buildInteractiveComparisonDemo() {
  return _InteractiveComparisonWidget();
}

class _InteractiveComparisonWidget extends StatefulWidget {
  @override
  State<_InteractiveComparisonWidget> createState() =>
      _InteractiveComparisonWidgetState();
}

class _InteractiveComparisonWidgetState
    extends State<_InteractiveComparisonWidget> {
  CacheExtentStyle _style = CacheExtentStyle.pixel;
  double _extent = 250;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAmber400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Cache Configuration',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kAmber900,
            ),
          ),
          const SizedBox(height: 16),
          // Style selector
          Row(
            children: [
              const Text(
                'Style: ',
                style: TextStyle(fontSize: 12, color: _kAmber800),
              ),
              const SizedBox(width: 8),
              _buildStyleButton(CacheExtentStyle.pixel),
              const SizedBox(width: 8),
              _buildStyleButton(CacheExtentStyle.viewport),
            ],
          ),
          const SizedBox(height: 12),
          // Extent slider
          Row(
            children: [
              Text(
                _style == CacheExtentStyle.pixel ? 'Pixels: ' : 'Fraction: ',
                style: const TextStyle(fontSize: 12, color: _kAmber800),
              ),
              Expanded(
                child: Slider(
                  value: _extent,
                  min: _style == CacheExtentStyle.pixel ? 0 : 0,
                  max: _style == CacheExtentStyle.pixel ? 500 : 2,
                  divisions: _style == CacheExtentStyle.pixel ? 50 : 20,
                  onChanged: (v) => setState(() => _extent = v),
                  activeColor: _kAmber600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kAmber500,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _style == CacheExtentStyle.pixel
                      ? '${_extent.toInt()}px'
                      : '${_extent.toStringAsFixed(1)}x',
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Preview
          _buildPreviewCard(),
        ],
      ),
    );
  }

  Widget _buildStyleButton(CacheExtentStyle style) {
    final isSelected = _style == style;
    return GestureDetector(
      onTap: () => setState(() {
        _style = style;
        _extent = style == CacheExtentStyle.pixel ? 250 : 1.0;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? _kAmber600 : _kAmber100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kAmber400),
        ),
        child: Text(
          style.name,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : _kAmber800,
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    final cacheHeight = _style == CacheExtentStyle.pixel
        ? (_extent / 250 * 30).clamp(0.0, 60.0)
        : (_extent * 30).clamp(0.0, 60.0);

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: _kAmber50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Top cache
          Container(
            height: cacheHeight,
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kAmber200,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(6),
              ),
            ),
            alignment: Alignment.center,
            child: cacheHeight > 15
                ? Text(
                    'Cache ${_style == CacheExtentStyle.pixel ? "${_extent.toInt()}px" : "${_extent.toStringAsFixed(1)}×"}',
                    style: const TextStyle(fontSize: 9, color: _kAmber800),
                  )
                : null,
          ),
          // Viewport
          Flexible(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: _kAmber500,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_android, color: Colors.white, size: 20),
                  Text(
                    'Viewport',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom cache
          Container(
            height: cacheHeight,
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kAmber200,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(6),
              ),
            ),
            alignment: Alignment.center,
            child: cacheHeight > 15
                ? const Text(
                    'Cache',
                    style: TextStyle(fontSize: 9, color: _kAmber800),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

/// Performance implications card
Widget _buildPerformanceCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kAmber100, _kAmber50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Considerations',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kAmber900,
          ),
        ),
        const SizedBox(height: 16),
        _buildPerformanceItem(
          Icons.speed,
          'Larger Cache = Smoother Scrolling',
          'More items pre-built, less jank',
          true,
        ),
        _buildPerformanceItem(
          Icons.memory,
          'Larger Cache = More Memory',
          'More widgets held in memory',
          false,
        ),
        _buildPerformanceItem(
          Icons.aspect_ratio,
          'Viewport Style = Adaptive',
          'Scales with screen size automatically',
          true,
        ),
        _buildPerformanceItem(
          Icons.straighten,
          'Pixel Style = Predictable',
          'Consistent behavior across devices',
          true,
        ),
      ],
    ),
  );
}

Widget _buildPerformanceItem(
  IconData icon,
  String title,
  String desc,
  bool isPositive,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isPositive ? Colors.green[100] : Colors.red[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isPositive ? Colors.green[700] : Colors.red[700],
            size: 20,
          ),
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
                  color: _kAmber900,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 10, color: _kAmber700),
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
      border: Border.all(color: _kAmber300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'When to Use Each Style',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kAmber900,
          ),
        ),
        const SizedBox(height: 16),
        _buildUseCaseComparison('pixel', [
          'Fixed-height list items',
          'Consistent memory budget',
          'Cross-device consistency',
        ], _kAmber500),
        const SizedBox(height: 12),
        _buildUseCaseComparison('viewport', [
          'Variable-size screens',
          'Responsive layouts',
          'Tablet/phone adaptability',
        ], _kAmber700),
      ],
    ),
  );
}

Widget _buildUseCaseComparison(String style, List<String> cases, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                style,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...cases.map(
          (c) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: color, size: 14),
                const SizedBox(width: 6),
                Text(
                  c,
                  style: const TextStyle(fontSize: 11, color: _kAmber800),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// Live scrolling demo
Widget _buildLiveScrollDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live Scroll Demo',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kAmber900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Scroll the list - items are cached above and below viewport:',
          style: TextStyle(fontSize: 11, color: _kAmber700),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            cacheExtent: 250, // Default cache extent
            itemCount: 50,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: _kAmber100.withAlpha(150 + (index % 3) * 35),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: _kAmber500,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'List Item ${index + 1}',
                      style: const TextStyle(fontSize: 13, color: _kAmber900),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: _kAmber200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'cached',
                        style: TextStyle(fontSize: 9, color: _kAmber800),
                      ),
                    ),
                  ],
                ),
              );
            },
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
      color: _kAmber600,
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
  // Print information about CacheExtentStyle
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║           CacheExtentStyle Deep Demo                             ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- CacheExtentStyle Overview ---');
  print('Controls how scrollable widgets cache off-screen content.');
  print('Two styles: pixel (fixed) and viewport (proportional).');

  // Enumerate values
  print('\n--- Enum Values ---');
  for (final style in CacheExtentStyle.values) {
    print('${style.index}: ${style.name}');
  }

  // Explain each style
  print('\n--- Style Details ---');
  print('pixel: Cache extent in logical pixels (default 250px)');
  print('  - Fixed size regardless of screen');
  print('  - Predictable memory usage');
  print('viewport: Cache extent as viewport fraction');
  print('  - Scales with screen size');
  print('  - Adaptive for different devices');

  print('\nCacheExtentStyle test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFAF0), Color(0xFFFFF5E0)],
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
                colors: [_kAmber700, _kAmber900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kAmber800.withAlpha(80),
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
                        Icons.cached,
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
                            'CacheExtentStyle',
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
                    'Enum controlling how scrollable widgets pre-build and cache '
                    'off-screen content for smooth scrolling performance.',
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
            'Scrolling Performance',
            'Pre-building items before they scroll into view prevents jank.',
            Icons.speed,
          ),
          _buildInfoCard(
            'Memory Trade-off',
            'Larger cache = smoother scroll, but more memory usage.',
            Icons.memory,
          ),

          // Enum values
          _buildSectionTitle('Enum Values', Icons.list),
          _buildEnumValuesCard(),
          const SizedBox(height: 20),

          // Visualization
          _buildSectionTitle('Cache Visualization', Icons.visibility),
          _buildCacheExtentVisualization(),
          const SizedBox(height: 20),

          // Interactive demo
          _buildSectionTitle('Configure Cache', Icons.tune),
          _buildInteractiveComparisonDemo(),
          const SizedBox(height: 20),

          // Live scroll demo
          _buildSectionTitle('Live Scroll Demo', Icons.view_list),
          _buildLiveScrollDemo(),
          const SizedBox(height: 20),

          // Performance
          _buildSectionTitle('Performance', Icons.analytics),
          _buildPerformanceCard(),
          const SizedBox(height: 20),

          // Use cases
          _buildSectionTitle('When to Use', Icons.help_outline),
          _buildUseCasesCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet('Using Pixel Style', '''ListView.builder(
  cacheExtent: 250, // 250 pixels
  // cacheExtentStyle defaults to pixel
  itemBuilder: (context, index) {
    return ListTile(title: Text('Item \$index'));
  },
)'''),
          _buildCodeSnippet(
            'Using Viewport Style',
            '''// In RenderViewport or custom viewport
RenderViewport(
  // Cache 1.5x viewport height above/below
  cacheExtent: 1.5,
  cacheExtentStyle: CacheExtentStyle.viewport,
  // ...
)''',
          ),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'CacheExtentStyle'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kAmber100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kAmber700, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kAmber900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'CacheExtentStyle controls how viewports cache off-screen content: '
                  'pixel for fixed pixel distance, viewport for proportional sizing. '
                  'Choose based on your app\'s scrolling needs and memory constraints.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kAmber800,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('pixel', Icons.straighten),
                    const SizedBox(width: 8),
                    _buildSummaryChip('viewport', Icons.aspect_ratio),
                    const SizedBox(width: 8),
                    _buildSummaryChip('scroll', Icons.swap_vert),
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
