// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawWebImage
// Demonstrates RawWebImage — a web-specific widget that renders images
// using the HTML <img> element instead of Flutter's canvas pipeline.
// On non-web platforms, the standard Image widget is used. RawWebImage
// enables better performance, caching, and accessibility on the web.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawWebImage Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is RawWebImage?
  // ============================================================
  print('=== Section 1: Concept ===');

  // RawWebImage is a Flutter widget designed for web deployment
  // that renders images via the browser's native <img> element
  // rather than through the Skia/CanvasKit pipeline.
  //
  // Benefits:
  //   - Browser handles caching (HTTP cache, CDN edge cache)
  //   - Native lazy loading (loading="lazy")
  //   - Better accessibility (alt text read by screen readers)
  //   - Lower Wasm memory usage (no decode into canvas bitmap)
  //   - Format negotiation (WebP, AVIF via Accept header)
  //
  // Trade-offs:
  //   - No pixel-level manipulation (shaders, color filters)
  //   - Limited compositing control
  //   - Only available on web platform

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF0D47A1), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.web, size: 36.0, color: Color(0xFF0D47A1)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'RawWebImage',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'A web-specific widget that renders images via the browser\'s '
          'native <img> element rather than the Skia/CanvasKit pipeline. '
          'This gives better caching, lazy loading, accessibility, and '
          'lower memory usage on web deployments.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF1565C0)),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Why use RawWebImage on web?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 8.0),
              _buildWebImageBullet(
                'Browser-managed HTTP caching & CDN edge caching',
                Color(0xFF1565C0),
              ),
              _buildWebImageBullet(
                'Native lazy loading (loading="lazy" attribute)',
                Color(0xFF2E7D32),
              ),
              _buildWebImageBullet(
                'Screen reader accessibility via alt text',
                Color(0xFFE65100),
              ),
              _buildWebImageBullet(
                'Lower Wasm memory — no decode to canvas bitmap',
                Color(0xFF6A1B9A),
              ),
              _buildWebImageBullet(
                'Format negotiation — browser picks WebP/AVIF',
                Color(0xFF00838F),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Web vs Canvas Image Rendering
  // ============================================================
  print('=== Section 2: Web vs Canvas rendering ===');

  // Compare the two rendering paths for images on Flutter web.

  Widget buildRenderingPath(
    String title,
    String subtitle,
    List<String> steps,
    Color color,
    IconData icon,
    bool isHighlighted,
  ) {
    return Container(
      width: 250.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isHighlighted
            ? color.withValues(alpha: 0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: color,
          width: isHighlighted ? 2.0 : 1.0,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.15),
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: color,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: color.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isHighlighted)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'THIS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: steps.asMap().entries.map((entry) {
                final idx = entry.key;
                final step = entry.value;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${idx + 1}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          step,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  final renderingComparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Image Rendering Paths on Web',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Two different ways Flutter can display images on web.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildRenderingPath(
              'Canvas Path',
              'Standard Image widget',
              [
                'Fetch image bytes via HTTP',
                'Decode to pixel buffer in Wasm',
                'Upload to WebGL texture',
                'Draw on Skia/CanvasKit surface',
                'Composite into HTML canvas',
              ],
              Color(0xFF795548),
              Icons.brush,
              false,
            ),
            buildRenderingPath(
              'HTML Path',
              'RawWebImage widget',
              [
                'Browser creates <img> element',
                'Browser fetches (uses HTTP cache)',
                'Browser decodes natively',
                'Browser composites on page',
                'CSS handles sizing/cropping',
              ],
              Color(0xFF0D47A1),
              Icons.web,
              true,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Image Fit Modes
  // ============================================================
  print('=== Section 3: Image fit modes ===');

  // Show how different BoxFit values affect image layout.
  // Using colored placeholder containers since we can't load
  // actual network images in this test context.

  Widget buildFitDemo(String fitName, BoxFit fit, String description) {
    return Container(
      width: 140.0,
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Color(0xFF0D47A1).withValues(alpha: 0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Center(
              child: Text(
                fitName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  color: Color(0xFF0D47A1),
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          // Demo area: a frame showing how the "image" would be placed
          Container(
            width: 120.0,
            height: 80.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: FittedBox(
              fit: fit,
              child: Container(
                width: 160.0,
                height: 100.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF42A5F5),
                      Color(0xFF1565C0),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.photo,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 30.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 6.0, right: 6.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final fitSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Image Fit Modes',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How the image scales within its container.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildFitDemo(
              'BoxFit.contain',
              BoxFit.contain,
              'Fits inside without cropping',
            ),
            buildFitDemo(
              'BoxFit.cover',
              BoxFit.cover,
              'Fills frame, may crop edges',
            ),
            buildFitDemo(
              'BoxFit.fill',
              BoxFit.fill,
              'Stretches to fill — distorts',
            ),
            buildFitDemo(
              'BoxFit.fitWidth',
              BoxFit.fitWidth,
              'Matches width, may overflow',
            ),
            buildFitDemo(
              'BoxFit.fitHeight',
              BoxFit.fitHeight,
              'Matches height, may overflow',
            ),
            buildFitDemo(
              'BoxFit.none',
              BoxFit.none,
              'No scaling — original size',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Loading States
  // ============================================================
  print('=== Section 4: Loading states ===');

  Widget buildLoadingState(
    String name,
    IconData icon,
    Color color,
    Widget preview,
    String description,
  ) {
    return Container(
      width: 160.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70.0,
            margin: EdgeInsets.all(10.0),
            child: Center(child: preview),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10.0,
              left: 8.0,
              right: 8.0,
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final loadingSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Image Loading States',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'What the user sees during the image lifecycle.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildLoadingState(
              'Placeholder',
              Icons.image_outlined,
              Color(0xFF9E9E9E),
              Container(
                width: 60.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.grey.shade400,
                    size: 24.0,
                  ),
                ),
              ),
              'Before any network request starts.',
            ),
            buildLoadingState(
              'Loading',
              Icons.downloading,
              Color(0xFF1565C0),
              Container(
                width: 60.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color(0xFF1565C0).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ),
              'Browser is fetching the image bytes.',
            ),
            buildLoadingState(
              'Loaded',
              Icons.check_circle,
              Color(0xFF2E7D32),
              Container(
                width: 60.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF42A5F5),
                      Color(0xFF1565C0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.landscape,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
              'Image decoded and displayed.',
            ),
            buildLoadingState(
              'Error',
              Icons.broken_image,
              Color(0xFFC62828),
              Container(
                width: 60.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color(0xFFC62828).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: Color(0xFFC62828).withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Color(0xFFC62828),
                    size: 24.0,
                  ),
                ),
              ),
              'Network error or invalid format.',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Accessibility on Web
  // ============================================================
  print('=== Section 5: Web accessibility ===');

  Widget buildA11yCard(
    String attribute,
    String htmlOutput,
    String purpose,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18.0),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attribute,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
                SizedBox(height: 3.0),
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF263238),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    htmlOutput,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: Color(0xFF80CBC4),
                    ),
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  purpose,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final a11ySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new,
                color: Color(0xFF2E7D32), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Web Accessibility Features',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'RawWebImage maps to real <img> — screen readers work natively.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        buildA11yCard(
          'alt attribute',
          '<img alt="A sunset over mountains" />',
          'Screen readers announce this text when the image '
              'cannot be seen or is decorative.',
          Color(0xFF2E7D32),
          Icons.record_voice_over,
        ),
        buildA11yCard(
          'role="img"',
          '<img role="img" aria-label="Chart" />',
          'Explicit role for complex images like charts '
              'or diagrams.',
          Color(0xFF1565C0),
          Icons.analytics,
        ),
        buildA11yCard(
          'loading="lazy"',
          '<img loading="lazy" src="..." />',
          'Browser defers loading until the image is near '
              'the viewport — saves bandwidth.',
          Color(0xFFE65100),
          Icons.speed,
        ),
        buildA11yCard(
          'decoding="async"',
          '<img decoding="async" src="..." />',
          'Browser decodes off the main thread — prevents '
              'jank during page load.',
          Color(0xFF6A1B9A),
          Icons.memory,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: RawWebImage vs Image Widget Comparison
  // ============================================================
  print('=== Section 6: Comparison table ===');

  Widget buildCompareRow(
    String feature,
    String rawWebImage,
    String imageWidget,
    Color rowColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: rowColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              rawWebImage,
              style: TextStyle(fontSize: 10.0, color: Color(0xFF0D47A1)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              imageWidget,
              style: TextStyle(fontSize: 10.0, color: Color(0xFF795548)),
            ),
          ),
        ],
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'RawWebImage vs Image Widget',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        // Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Feature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'RawWebImage',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Color(0xFF0D47A1),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Color(0xFF795548),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        buildCompareRow(
          'Platform',
          'Web only',
          'All platforms',
          Color(0xFF1565C0),
        ),
        buildCompareRow(
          'Rendering',
          'HTML <img>',
          'CanvasKit / Skia',
          Color(0xFF2E7D32),
        ),
        buildCompareRow(
          'Caching',
          'Browser HTTP cache',
          'Manual / ImageCache',
          Color(0xFFE65100),
        ),
        buildCompareRow(
          'Lazy loading',
          'Native support',
          'Manual with scroll',
          Color(0xFF6A1B9A),
        ),
        buildCompareRow(
          'Screen readers',
          'Native alt text',
          'Semantics widget',
          Color(0xFF00838F),
        ),
        buildCompareRow(
          'Color filters',
          'CSS only',
          'Full Skia pipeline',
          Color(0xFFC62828),
        ),
        buildCompareRow(
          'Pixel ops',
          'Not possible',
          'Full access',
          Color(0xFF795548),
        ),
        buildCompareRow(
          'Memory',
          'Lower (browser)',
          'Higher (Wasm heap)',
          Color(0xFF37474F),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Platform-Conditional Code
  // ============================================================
  print('=== Section 7: Platform-conditional usage ===');

  // Show how to conditionally use RawWebImage on web
  // and Image on native platforms.

  final platformSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.device_hub, color: Color(0xFF37474F), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Platform-Conditional Usage',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Widget buildImage(String url) {\n'
            '  if (kIsWeb) {\n'
            '    // Use browser-native rendering\n'
            '    return RawWebImage(\n'
            '      src: url,\n'
            '      alt: \'Product photo\',\n'
            '      width: 300,\n'
            '      height: 200,\n'
            '      fit: BoxFit.cover,\n'
            '    );\n'
            '  } else {\n'
            '    // Use standard Image on native\n'
            '    return Image.network(\n'
            '      url,\n'
            '      width: 300,\n'
            '      height: 200,\n'
            '      fit: BoxFit.cover,\n'
            '    );\n'
            '  }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // Platform decision tree
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xFF0D47A1).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Color(0xFF0D47A1).withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.web,
                        color: Color(0xFF0D47A1), size: 28.0),
                    SizedBox(height: 4.0),
                    Text(
                      'Web',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    Text(
                      'RawWebImage',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.compare_arrows,
                  color: Colors.grey.shade400, size: 24.0),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xFF795548).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Color(0xFF795548).withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.phone_android,
                        color: Color(0xFF795548), size: 28.0),
                    SizedBox(height: 4.0),
                    Text(
                      'Native',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Color(0xFF795548),
                      ),
                    ),
                    Text(
                      'Image.network()',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Color(0xFF795548),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Performance Considerations
  // ============================================================
  print('=== Section 8: Performance ===');

  Widget buildPerfItem(
    IconData icon,
    String title,
    String detail,
    Color color,
    String metric,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18.0),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: color,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        metric,
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.0),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final perfSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFF57C00)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.speed, color: Color(0xFFF57C00), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Performance Considerations',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        buildPerfItem(
          Icons.cached,
          'HTTP caching',
          'Browser reuses cached images across pages — '
              'no re-download on re-render.',
          Color(0xFF2E7D32),
          'High impact',
        ),
        buildPerfItem(
          Icons.memory,
          'Wasm memory',
          'No Dart-side pixel buffers — browser owns the '
              'decoded bitmap.',
          Color(0xFF1565C0),
          'Medium impact',
        ),
        buildPerfItem(
          Icons.visibility,
          'Lazy loading',
          'Images below the fold wait until near-viewport '
              'to start fetching.',
          Color(0xFFE65100),
          'High impact',
        ),
        buildPerfItem(
          Icons.format_paint,
          'CSS compositing',
          'Browser uses GPU-accelerated compositing for '
              '<img> elements.',
          Color(0xFF6A1B9A),
          'Low overhead',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Summary
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF0D47A1), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFF0D47A1), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildWebImageSummaryItem(
          Icons.web,
          'Web-only widget',
          'Uses HTML <img> instead of Skia/CanvasKit canvas',
          Color(0xFF0D47A1),
        ),
        SizedBox(height: 8.0),
        _buildWebImageSummaryItem(
          Icons.cached,
          'Browser caching',
          'Leverages HTTP cache and CDN edge caching natively',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 8.0),
        _buildWebImageSummaryItem(
          Icons.accessibility_new,
          'Accessible by default',
          'Alt text and ARIA attributes work with screen readers',
          Color(0xFFE65100),
        ),
        SizedBox(height: 8.0),
        _buildWebImageSummaryItem(
          Icons.speed,
          'Better web performance',
          'Lower memory, lazy loading, native decoding',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 8.0),
        _buildWebImageSummaryItem(
          Icons.brush,
          'Trade-off: No pixel ops',
          'Cannot use ColorFilter, ImageFilter, or shaders',
          Color(0xFFC62828),
        ),
      ],
    ),
  );

  print('RawWebImage Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF1565C0),
                Color(0xFF1976D2),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.web, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'RawWebImage',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Browser-native image rendering for Flutter web',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. Rendering Paths',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        renderingComparison,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. Image Fit Modes',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        fitSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Loading States',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        loadingSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Web Accessibility',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        a11ySection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Comparison',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        comparisonTable,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Platform Usage',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        platformSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Performance',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        perfSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '9. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildWebImageBullet(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: color),
          ),
        ),
      ],
    ),
  );
}

Widget _buildWebImageSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
