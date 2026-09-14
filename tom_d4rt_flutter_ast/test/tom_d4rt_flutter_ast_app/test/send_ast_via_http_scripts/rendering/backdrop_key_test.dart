// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo of BackdropKey from rendering
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildPropertyRow(String property, String type, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            property,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.indigo.shade800,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildConceptCard(String title, String explanation, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.indigo.shade600, size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo.shade900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                explanation,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBlurEffectDemo(String effectName, double sigmaX, double sigmaY) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          effectName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.indigo.shade700,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pink, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  'Original',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
            SizedBox(width: 12),
            Icon(Icons.arrow_forward, color: Colors.grey.shade400),
            SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                child: Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      'Blurred',
                      style: TextStyle(color: Colors.grey.shade800, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sigmaX: ${sigmaX.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                Text(
                  'sigmaY: ${sigmaY.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildOptimizationCard(String optimization, String benefit, Color accentColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accentColor.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accentColor.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 50,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                optimization,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey.shade900,
                ),
              ),
              SizedBox(height: 2),
              Text(
                benefit,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildLayerCacheCard(String cacheName, String description, bool isCached) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isCached ? Colors.green.shade50 : Colors.orange.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isCached ? Colors.green.shade300 : Colors.orange.shade300,
      ),
    ),
    child: Row(
      children: [
        Icon(
          isCached ? Icons.cached : Icons.refresh,
          color: isCached ? Colors.green.shade700 : Colors.orange.shade700,
          size: 22,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cacheName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey.shade900,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isCached ? Colors.green.shade100 : Colors.orange.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isCached ? 'CACHED' : 'RECOMPUTED',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isCached ? Colors.green.shade800 : Colors.orange.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildUsagePatternCard(String pattern, String codeExample) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pattern,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.amber.shade300,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            codeExample,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.green.shade300,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonRow(String feature, String withoutKey, String withKey) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            feature,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              withoutKey,
              style: TextStyle(fontSize: 11, color: Colors.red.shade700),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              withKey,
              style: TextStyle(fontSize: 11, color: Colors.green.shade700),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildLayerHierarchyCard(int depth, String layerName, String role) {
  return Container(
    margin: EdgeInsets.only(left: depth * 20.0, top: 4, bottom: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Row(
      children: [
        Icon(Icons.layers, color: Colors.indigo.shade400, size: 18),
        SizedBox(width: 8),
        Text(
          layerName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            role,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget buildPerformanceMetricCard(String metric, String value, String impact) {
  return Container(
    width: 160,
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          metric,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 2),
        Text(
          impact,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildFilterTypeCard(String filterType, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.filter_alt, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filterType,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey.shade900,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBlendModeCard(String modeName, String description) {
  return Container(
    width: 150,
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          modeName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.indigo.shade700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildWarningCard(String title, String warning) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber, color: Colors.amber.shade700, size: 24),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.amber.shade900,
                ),
              ),
              Text(
                warning,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSummaryPoint(String point) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.indigo.shade700, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            point,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('BackdropKey Deep Demo'),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: BackdropKey Purpose
            buildSectionHeader('1. BackdropKey Purpose'),
            
            buildInfoCard(
              'Definition',
              'BackdropKey is a specialized key type used to uniquely identify backdrop filter layers in the Flutter rendering layer tree',
            ),
            
            buildInfoCard(
              'Primary Role',
              'Enables precise identification and management of backdrop effects across the widget tree hierarchy',
            ),
            
            buildInfoCard(
              'Layer Association',
              'Associates a key with backdrop filter operations allowing selective caching and invalidation',
            ),
            
            buildConceptCard(
              'Key-Based Layer Identification',
              'BackdropKey provides a stable identity for backdrop filter layers. When the rendering pipeline processes multiple backdrop effects, keys help distinguish between different filter applications and their associated backdrop regions.',
              Icons.vpn_key,
            ),
            
            buildConceptCard(
              'Lifecycle Management',
              'Keys enable the framework to track backdrop filter layer lifecycles. When a widget with a BackdropKey is removed or repositioned, the framework can efficiently clean up or transfer the associated layer resources.',
              Icons.autorenew,
            ),
            
            buildConceptCard(
              'Clip Region Binding',
              'BackdropKey helps bind specific clip regions to backdrop filters. This ensures that blur effects are applied only within designated areas, preventing visual artifacts from bleeding across boundaries.',
              Icons.crop,
            ),
            
            buildPropertyRow('key', 'Key', 'The unique identifier for the backdrop layer'),
            buildPropertyRow('layerId', 'int', 'Internal layer identifier assigned by the rendering engine'),
            buildPropertyRow('clipRegion', 'Rect?', 'Optional clip bounds for the backdrop effect'),
            buildPropertyRow('blendMode', 'BlendMode', 'How the backdrop filter result blends with the scene'),
            
            buildConceptCard(
              'Widget Tree Integration',
              'BackdropKey integrates with the element tree reconciliation process. When setState triggers rebuilds, keys help Flutter match old and new backdrop elements correctly preserving layer state.',
              Icons.account_tree,
            ),
            
            buildConceptCard(
              'Debug Identification',
              'In debug mode and when using Flutter DevTools, BackdropKey provides meaningful names for backdrop layers making it easier to identify specific effects in the layer visualization.',
              Icons.bug_report,
            ),
            
            SizedBox(height: 16),
            
            // Section 2: BackdropFilter Widget Usage
            buildSectionHeader('2. BackdropFilter Widget Usage'),
            
            buildInfoCard(
              'Widget Purpose',
              'BackdropFilter applies a filter to existing painted content beneath it in the widget tree',
            ),
            
            buildInfoCard(
              'Filter Types',
              'Supports ImageFilter operations including blur, matrix transforms, color filters, and composed effects',
            ),
            
            buildUsagePatternCard(
              'Basic BackdropFilter Usage',
              'BackdropFilter(\n'
              '  filter: ImageFilter.blur(\n'
              '    sigmaX: 5.0,\n'
              '    sigmaY: 5.0,\n'
              '  ),\n'
              '  child: Container(\n'
              '    color: Colors.white24,\n'
              '    child: Text(\'Blurred Background\'),\n'
              '  ),\n'
              ')',
            ),
            
            buildUsagePatternCard(
              'BackdropFilter with Key',
              'BackdropFilter(\n'
              '  key: backdropKey,\n'
              '  filter: ImageFilter.blur(\n'
              '    sigmaX: 10.0,\n'
              '    sigmaY: 10.0,\n'
              '  ),\n'
              '  blendMode: BlendMode.srcOver,\n'
              '  child: frostedGlassContent,\n'
              ')',
            ),
            
            buildUsagePatternCard(
              'Nested BackdropFilter Stack',
              'Stack(\n'
              '  children: [\n'
              '    backgroundImage,\n'
              '    Positioned(\n'
              '      child: BackdropFilter(\n'
              '        key: Key(\'blur-layer-1\'),\n'
              '        filter: blurFilter,\n'
              '        child: overlayContent,\n'
              '      ),\n'
              '    ),\n'
              '  ],\n'
              ')',
            ),
            
            buildConceptCard(
              'Child Widget Requirements',
              'BackdropFilter requires a child widget to define the filter application area. The child determines where the backdrop effect is visible. Without a child, the filter has no visible region to apply the effect.',
              Icons.child_care,
            ),
            
            buildConceptCard(
              'Clipping Context',
              'BackdropFilter typically needs a clipping ancestor to define bounds. Using ClipRect, ClipRRect, or ClipPath above the BackdropFilter ensures the effect is contained within a specific region.',
              Icons.content_cut,
            ),
            
            buildFilterTypeCard(
              'Gaussian Blur',
              'Most common filter type using sigmaX and sigmaY parameters',
              Colors.blue,
            ),
            
            buildFilterTypeCard(
              'Matrix Transform',
              'Applies transformation matrix to backdrop pixels',
              Colors.purple,
            ),
            
            buildFilterTypeCard(
              'Color Filter',
              'Modifies color values of backdrop content',
              Colors.orange,
            ),
            
            buildFilterTypeCard(
              'Composed Filter',
              'Combines multiple filter effects in sequence',
              Colors.teal,
            ),
            
            buildWarningCard(
              'ClipRect Requirement',
              'Without a clipping ancestor, the backdrop filter may affect the entire screen or produce unexpected visual results.',
            ),
            
            SizedBox(height: 16),
            
            // Section 3: Blur Effects
            buildSectionHeader('3. Blur Effects'),
            
            buildInfoCard(
              'Gaussian Blur',
              'The most common backdrop filter effect using ImageFilter.blur with sigma values for horizontal and vertical blur radius',
            ),
            
            buildBlurEffectDemo('Subtle Blur', 2.0, 2.0),
            buildBlurEffectDemo('Medium Blur', 5.0, 5.0),
            buildBlurEffectDemo('Strong Blur', 10.0, 10.0),
            buildBlurEffectDemo('Horizontal Blur', 8.0, 0.0),
            buildBlurEffectDemo('Vertical Blur', 0.0, 8.0),
            buildBlurEffectDemo('Asymmetric Blur', 3.0, 12.0),
            
            buildConceptCard(
              'Sigma Value Meaning',
              'Sigma represents the standard deviation of the Gaussian kernel. Higher values create more blur. A sigma of 0 means no blur in that direction. Values between 1-5 are subtle, 5-15 are moderate, and above 15 creates heavy blur.',
              Icons.tune,
            ),
            
            buildConceptCard(
              'Performance Cost of Blur',
              'Blur operations are GPU-intensive. Each pixel requires sampling multiple neighboring pixels based on sigma. Larger sigma values require more samples, increasing GPU workload. Using BackdropKey allows caching to mitigate repeated computations.',
              Icons.speed,
            ),
            
            buildConceptCard(
              'Blur Tile Mode',
              'The tile mode determines how pixels outside the source bounds are handled during blur. Options include clamp, repeat, mirror, and decal modes affecting edge appearance.',
              Icons.grid_on,
            ),
            
            buildUsagePatternCard(
              'Creating Frosted Glass Effect',
              'ClipRRect(\n'
              '  borderRadius: BorderRadius.circular(16),\n'
              '  child: BackdropFilter(\n'
              '    filter: ImageFilter.blur(\n'
              '      sigmaX: 10.0,\n'
              '      sigmaY: 10.0,\n'
              '    ),\n'
              '    child: Container(\n'
              '      color: Colors.white.withOpacity(0.2),\n'
              '      child: content,\n'
              '    ),\n'
              '  ),\n'
              ')',
            ),
            
            buildUsagePatternCard(
              'Blur with Color Overlay',
              'BackdropFilter(\n'
              '  filter: ImageFilter.compose(\n'
              '    outer: ImageFilter.blur(\n'
              '      sigmaX: 8.0,\n'
              '      sigmaY: 8.0,\n'
              '    ),\n'
              '    inner: ColorFilter.mode(\n'
              '      Colors.blue.withOpacity(0.3),\n'
              '      BlendMode.srcOver,\n'
              '    ),\n'
              '  ),\n'
              '  child: overlayWidget,\n'
              ')',
            ),
            
            Text(
              'Common Blur Scenarios',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8),
            
            buildOptimizationCard(
              'Modal Overlays',
              'Blur background when showing dialogs or bottom sheets',
              Colors.blue,
            ),
            
            buildOptimizationCard(
              'App Bars',
              'Frosted glass effect for iOS-style navigation bars',
              Colors.purple,
            ),
            
            buildOptimizationCard(
              'Card Backgrounds',
              'Subtle blur for floating cards over images',
              Colors.green,
            ),
            
            buildOptimizationCard(
              'Status Bars',
              'Blur content beneath status and navigation areas',
              Colors.orange,
            ),
            
            SizedBox(height: 16),
            
            // Section 4: Layer Caching Concepts
            buildSectionHeader('4. Layer Caching Concepts'),
            
            buildInfoCard(
              'Layer Cache Purpose',
              'Caching stores rendered layer output to avoid redundant GPU operations when content has not changed',
            ),
            
            buildInfoCard(
              'Cache Invalidation',
              'When backdrop content changes, the cache must be invalidated and the filter re-applied to reflect updates',
            ),
            
            buildLayerCacheCard(
              'Static Content Cache',
              'Backdrop over static images or non-animated content',
              true,
            ),
            
            buildLayerCacheCard(
              'Animated Content',
              'Backdrop over scrolling or animated widgets',
              false,
            ),
            
            buildLayerCacheCard(
              'Key-Identified Layer',
              'BackdropKey enables selective cache retention across rebuilds',
              true,
            ),
            
            buildLayerCacheCard(
              'Anonymous Layer',
              'Without key, layer may be discarded and recreated on rebuild',
              false,
            ),
            
            buildConceptCard(
              'Layer Tree Structure',
              'The Flutter rendering layer tree consists of ContainerLayer, PictureLayer, BackdropFilterLayer, and other specialized layers. BackdropFilterLayer captures the background, applies the filter, and composites the result. Keys help maintain layer identity through tree updates.',
              Icons.account_tree,
            ),
            
            buildLayerHierarchyCard(0, 'TransformLayer', 'Root transformation'),
            buildLayerHierarchyCard(1, 'ContainerLayer', 'Groups child layers'),
            buildLayerHierarchyCard(2, 'PictureLayer', 'Background content'),
            buildLayerHierarchyCard(2, 'ClipRectLayer', 'Defines clip bounds'),
            buildLayerHierarchyCard(3, 'BackdropFilterLayer', 'Applies blur effect'),
            buildLayerHierarchyCard(3, 'PictureLayer', 'Foreground content'),
            
            buildConceptCard(
              'Cache Key Computation',
              'Layer cache keys incorporate multiple factors: the BackdropKey identity, filter parameters, clip bounds, and layer position. Changes to any factor invalidate the cache for that specific layer.',
              Icons.fingerprint,
            ),
            
            buildConceptCard(
              'Retained Rendering',
              'Flutter can retain layer subtrees across frames when they have not changed. BackdropKey helps the framework identify which backdrop layers are candidates for retention versus those requiring recomputation.',
              Icons.save_alt,
            ),
            
            buildUsagePatternCard(
              'Cache-Friendly Pattern',
              'RepaintBoundary(\n'
              '  child: BackdropFilter(\n'
              '    key: Key(\'stable-backdrop\'),\n'
              '    filter: staticBlurFilter,\n'
              '    child: RepaintBoundary(\n'
              '      child: stableContent,\n'
              '    ),\n'
              '  ),\n'
              ')',
            ),
            
            buildInfoCard(
              'RepaintBoundary Role',
              'RepaintBoundary creates a separate layer that can be cached independently, isolating repaint regions',
            ),
            
            buildConceptCard(
              'Texture Caching',
              'When a backdrop filter layer is cached, the GPU stores the filtered result as a texture. Subsequent frames can reuse this texture directly without re-running the blur shader, significantly reducing GPU workload.',
              Icons.memory,
            ),
            
            buildConceptCard(
              'Cache Memory Tradeoff',
              'Caching consumes GPU memory proportional to the cached region size. For large backdrops, memory usage increases. The framework balances cache retention with memory pressure, potentially evicting less-used caches.',
              Icons.storage,
            ),
            
            SizedBox(height: 16),
            
            // Section 5: Optimization Benefits
            buildSectionHeader('5. Optimization Benefits'),
            
            buildInfoCard(
              'Performance Impact',
              'Proper use of BackdropKey and caching strategies can significantly reduce GPU workload and improve frame rates',
            ),
            
            buildOptimizationCard(
              'Reduced Recomputation',
              'Cache hit avoids re-running expensive blur shader',
              Colors.green,
            ),
            
            buildOptimizationCard(
              'Layer Stability',
              'Key-based identity prevents unnecessary layer recreation',
              Colors.blue,
            ),
            
            buildOptimizationCard(
              'Memory Efficiency',
              'Targeted caching avoids storing redundant layer outputs',
              Colors.purple,
            ),
            
            buildOptimizationCard(
              'GPU Bandwidth Savings',
              'Cached textures reduce GPU memory transfers per frame',
              Colors.orange,
            ),
            
            buildOptimizationCard(
              'Smooth Animations',
              'Consistent frame times by avoiding blur recalculation spikes',
              Colors.teal,
            ),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                buildPerformanceMetricCard('Frame Time', '8.3ms', 'Target: 16.6ms'),
                buildPerformanceMetricCard('GPU Usage', '45%', 'vs 78% without cache'),
                buildPerformanceMetricCard('Cache Hits', '94%', 'Layer reuse rate'),
                buildPerformanceMetricCard('Memory', '12MB', 'Layer cache footprint'),
              ],
            ),
            
            SizedBox(height: 12),
            
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comparison: With vs Without BackdropKey',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(width: 140),
                      Expanded(
                        child: Text(
                          'Without Key',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.red.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'With BackdropKey',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.green.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  buildComparisonRow(
                    'Layer Identity',
                    'Anonymous, may be recreated',
                    'Stable identifier',
                  ),
                  buildComparisonRow(
                    'Cache Behavior',
                    'Often invalidated',
                    'Retained when possible',
                  ),
                  buildComparisonRow(
                    'Widget Rebuild',
                    'May cause layer rebuild',
                    'Layer preserved',
                  ),
                  buildComparisonRow(
                    'Debugging',
                    'Hard to identify layers',
                    'Named for debugging',
                  ),
                  buildComparisonRow(
                    'Performance',
                    'Variable frame times',
                    'Consistent performance',
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16),
            
            buildConceptCard(
              'Best Practice: Use Keys for Heavy Effects',
              'When backdrop filters have high sigma values or cover large areas, always provide a BackdropKey. This enables the rendering pipeline to cache and reuse the expensive filter output when the background content remains stable.',
              Icons.star,
            ),
            
            buildConceptCard(
              'Best Practice: Combine with RepaintBoundary',
              'Wrapping BackdropFilter and its backdrop content in RepaintBoundary widgets helps isolate repaints. Changes outside the boundary do not invalidate the backdrop cache, maximizing cache effectiveness.',
              Icons.border_all,
            ),
            
            buildConceptCard(
              'Best Practice: Minimize Backdrop Changes',
              'Design layouts so that content behind BackdropFilter changes infrequently. Separate frequently changing content from backdrop regions to maintain cache validity and consistent performance.',
              Icons.change_history,
            ),
            
            buildUsagePatternCard(
              'Optimized Modal Blur Pattern',
              'Scaffold(\n'
              '  body: Stack(\n'
              '    children: [\n'
              '      RepaintBoundary(\n'
              '        child: mainContent,\n'
              '      ),\n'
              '      if (showModal)\n'
              '        Positioned.fill(\n'
              '          child: ClipRect(\n'
              '            child: BackdropFilter(\n'
              '              key: Key(\'modal-blur\'),\n'
              '              filter: modalBlurFilter,\n'
              '              child: modalContent,\n'
              '            ),\n'
              '          ),\n'
              '        ),\n'
              '    ],\n'
              '  ),\n'
              ')',
            ),
            
            buildUsagePatternCard(
              'AppBar Blur with Stability',
              'SliverAppBar(\n'
              '  flexibleSpace: ClipRect(\n'
              '    child: BackdropFilter(\n'
              '      key: Key(\'appbar-backdrop\'),\n'
              '      filter: ImageFilter.blur(\n'
              '        sigmaX: 15.0,\n'
              '        sigmaY: 15.0,\n'
              '      ),\n'
              '      child: Container(\n'
              '        color: theme.withOpacity(0.7),\n'
              '      ),\n'
              '    ),\n'
              '  ),\n'
              ')',
            ),
            
            Text(
              'Blend Modes for Backdrop',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                buildBlendModeCard('srcOver', 'Default compositing'),
                buildBlendModeCard('multiply', 'Darkens backdrop'),
                buildBlendModeCard('screen', 'Lightens backdrop'),
                buildBlendModeCard('overlay', 'Contrast boost'),
                buildBlendModeCard('softLight', 'Subtle tinting'),
                buildBlendModeCard('colorDodge', 'Bright highlights'),
              ],
            ),
            
            SizedBox(height: 16),
            
            buildWarningCard(
              'Avoid Animating Sigma',
              'Animating blur sigma values causes cache invalidation every frame, negating performance benefits. Instead, animate opacity or position of the backdrop filter widget.',
            ),
            
            buildWarningCard(
              'Large Backdrop Regions',
              'Full-screen backdrop filters are very expensive. Consider limiting blur to smaller overlay regions or using lower sigma values for better performance.',
            ),
            
            SizedBox(height: 20),
            
            // Summary Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade100, Colors.purple.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BackdropKey Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  SizedBox(height: 12),
                  buildSummaryPoint(
                    'BackdropKey provides stable identity for backdrop filter layers',
                  ),
                  buildSummaryPoint(
                    'Used with BackdropFilter widget for blur and other visual effects',
                  ),
                  buildSummaryPoint(
                    'Enables layer caching to avoid redundant GPU computations',
                  ),
                  buildSummaryPoint(
                    'Improves performance for heavy blur effects on stable content',
                  ),
                  buildSummaryPoint(
                    'Combine with RepaintBoundary for maximum cache effectiveness',
                  ),
                  buildSummaryPoint(
                    'Essential for smooth 60fps performance with backdrop effects',
                  ),
                  buildSummaryPoint(
                    'Debug-friendly identification in DevTools layer inspector',
                  ),
                  buildSummaryPoint(
                    'Works with various ImageFilter types beyond blur',
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: Builder(
        builder: (context) => build(context),
      ),
    ),
  );
}
