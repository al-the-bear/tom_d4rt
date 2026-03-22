// D4rt test script: Deep demo of ImageInfo - pair of dart:ui Image with scale
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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

Widget buildSubsectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 12, bottom: 6),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.teal.shade800,
      ),
    ),
  );
}

Widget buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.green.shade300,
      ),
    ),
  );
}

Widget buildScaleDemoCard(
  String scaleName,
  double scaleValue,
  int physicalWidth,
  int physicalHeight,
  Color cardColor,
) {
  double logicalWidth = physicalWidth / scaleValue;
  double logicalHeight = physicalHeight / scaleValue;
  
  print('Scale demo: $scaleName - ${physicalWidth}x$physicalHeight physical = ${logicalWidth}x$logicalHeight logical');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cardColor.withAlpha(30),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cardColor, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                scaleName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'scale: $scaleValue',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Physical Size',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '${physicalWidth}x$physicalHeight px',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward, color: cardColor),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logical Size',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '${logicalWidth.toStringAsFixed(1)}x${logicalHeight.toStringAsFixed(1)} dp',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cardColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Formula: physical / scale = logical',
          style: TextStyle(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

Widget buildImagePropertyCard(
  String propertyName,
  String propertyType,
  String description,
  String exampleUsage,
  IconData icon,
  Color iconColor,
) {
  print('Image property card: $propertyName ($propertyType)');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    propertyName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    propertyType,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.teal.shade600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            exampleUsage,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildPlaceholderGraphic(
  double width,
  double height,
  double scale,
  String label,
  Color color,
) {
  double displayWidth = width / scale;
  double displayHeight = height / scale;
  
  print('Placeholder graphic: $label - display ${displayWidth}x$displayHeight');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        Container(
          width: displayWidth,
          height: displayHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withAlpha(200), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image, color: Colors.white, size: 24),
                SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${width.toInt()}x${height.toInt()} @ ${scale}x',
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Logical: ${displayWidth.toInt()}x${displayHeight.toInt()} dp',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildSizeBytesEstimation(
  int width,
  int height,
  int bytesPerPixel,
  String formatName,
  Color accentColor,
) {
  int totalPixels = width * height;
  int estimatedBytes = totalPixels * bytesPerPixel;
  double estimatedKB = estimatedBytes / 1024;
  double estimatedMB = estimatedKB / 1024;
  
  print('sizeBytes estimation: ${width}x$height * $bytesPerPixel = $estimatedBytes bytes');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: accentColor.withAlpha(20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: accentColor, size: 24),
            SizedBox(width: 8),
            Text(
              formatName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: accentColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dimensions:', style: TextStyle(fontSize: 13)),
            Text('${width}x$height', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total Pixels:', style: TextStyle(fontSize: 13)),
            Text('$totalPixels', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bytes/Pixel:', style: TextStyle(fontSize: 13)),
            Text('$bytesPerPixel', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        Divider(color: accentColor.withAlpha(50)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Estimated Size:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${estimatedBytes.toString()} bytes',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  estimatedMB >= 1 
                      ? '${estimatedMB.toStringAsFixed(2)} MB'
                      : '${estimatedKB.toStringAsFixed(2)} KB',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
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

Widget buildCloneComparisonCard(
  String scenario,
  String behavior,
  bool needsClone,
  Color statusColor,
) {
  print('Clone comparison: $scenario - needsClone=$needsClone');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: needsClone ? Colors.orange.shade300 : Colors.green.shade300,
        width: 2,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: statusColor.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(
            needsClone ? Icons.copy : Icons.check_circle,
            color: statusColor,
            size: 22,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                scenario,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                behavior,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            needsClone ? 'CLONE' : 'OK',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDebugLabelExample(
  String labelValue,
  String usageContext,
  IconData icon,
) {
  print('Debug label example: $labelValue');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.purple.shade400, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelValue,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.purple.shade700,
                ),
              ),
              SizedBox(height: 2),
              Text(
                usageContext,
                style: TextStyle(
                  fontSize: 12,
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

Widget buildScaleComparisonVisual() {
  print('Building scale comparison visual');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Same Asset at Different Device Pixel Ratios',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('1x', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 4),
                Text('50x50 px', style: TextStyle(fontSize: 11)),
                Text('@1x', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade300, Colors.blue.shade400],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('2x', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 4),
                Text('100x100 px', style: TextStyle(fontSize: 11)),
                Text('@2x', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade500, Colors.blue.shade700],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('3x', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 4),
                Text('150x150 px', style: TextStyle(fontSize: 11)),
                Text('@3x', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        Center(
          child: Text(
            'All display at 50x50 logical pixels',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.blue.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== ImageInfo Deep Demo ===');
  print('ImageInfo pairs a dart:ui Image object with its scale.');
  print('The scale describes the ratio of physical pixels to logical pixels.');
  
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade600, Colors.teal.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.image, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'ImageInfo Deep Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pair of dart:ui Image object with its scale',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ),
        
        // Section 1: ImageInfo Creation
        buildSectionHeader('1. ImageInfo Creation'),
        
        buildInfoCard('Class', 'ImageInfo (from painting.dart)'),
        buildInfoCard('Purpose', 'Wraps decoded image with display metadata'),
        buildInfoCard('Immutable', 'Yes - all properties are final'),
        
        buildSubsectionTitle('Constructor'),
        buildCodeBlock('''ImageInfo({
  required ui.Image image,
  double scale = 1.0,
  String? debugLabel,
})'''),
        
        buildSubsectionTitle('Creation Examples'),
        buildCodeBlock('''// Basic creation with default scale
final info = ImageInfo(image: myImage);

// With explicit scale for retina
final retinaInfo = ImageInfo(
  image: myRetinaImage,
  scale: 2.0,
);

// With debug label for diagnostics
final labeledInfo = ImageInfo(
  image: myImage,
  scale: 3.0,
  debugLabel: 'profile_avatar@3x',
);'''),
        
        buildInfoCard('Note', 'ImageInfo does NOT decode images - it wraps already decoded ui.Image'),
        buildInfoCard('Lifecycle', 'You must dispose() when done to free GPU memory'),
        
        // Section 2: Image Property
        buildSectionHeader('2. Image Property'),
        
        buildImagePropertyCard(
          'image',
          'ui.Image',
          'The raw pixel data decoded from the image source. This is the actual image that will be drawn to the screen. Provides width, height, and pixel data for rendering.',
          'final myImage = imageInfo.image;\nprint(myImage.width);  // 200\nprint(myImage.height); // 150',
          Icons.photo_library,
          Colors.blue,
        ),
        
        buildSubsectionTitle('ui.Image Properties'),
        buildInfoCard('width', 'Physical pixel width of the image'),
        buildInfoCard('height', 'Physical pixel height of the image'),
        buildInfoCard('debugDisposed', 'Whether the image has been disposed'),
        
        buildCodeBlock('''// Accessing image properties
void processImage(ImageInfo info) {
  final image = info.image;
  
  print('Physical dimensions:');
  print('  Width: \${image.width} pixels');
  print('  Height: \${image.height} pixels');
  
  // Calculate logical size
  final logicalWidth = image.width / info.scale;
  final logicalHeight = image.height / info.scale;
  
  print('Logical dimensions:');
  print('  Width: \$logicalWidth dp');
  print('  Height: \$logicalHeight dp');
}'''),
        
        // Section 3: Scale Property
        buildSectionHeader('3. Scale Property (Device Pixel Ratios)'),
        
        buildImagePropertyCard(
          'scale',
          'double',
          'The ratio of physical pixels to logical pixels. Higher values mean more detail in the same logical space. Used to provide crisp images on high-DPI displays.',
          'final scale = imageInfo.scale;\n// 1.0 = standard, 2.0 = retina, 3.0 = super retina',
          Icons.aspect_ratio,
          Colors.orange,
        ),
        
        buildScaleDemoCard('Standard (1x)', 1.0, 100, 100, Colors.blue),
        buildScaleDemoCard('Retina (2x)', 2.0, 200, 200, Colors.green),
        buildScaleDemoCard('Super Retina (3x)', 3.0, 300, 300, Colors.purple),
        
        buildScaleComparisonVisual(),
        
        buildSubsectionTitle('Scale Impact on Display'),
        buildCodeBlock('''// Same logical size, different physical resolution
//
// 1x device: 50x50 logical = 50x50 physical
// 2x device: 50x50 logical = 100x100 physical  
// 3x device: 50x50 logical = 150x150 physical
//
// Formula: physical_size = logical_size * scale
// Inverse: logical_size = physical_size / scale'''),
        
        buildInfoCard('Performance', 'Higher scale images use more memory and GPU bandwidth'),
        buildInfoCard('Best Practice', 'Provide @1x, @2x, @3x variants and let Flutter select'),
        
        buildSubsectionTitle('Device Pixel Ratio Examples'),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Common Device Pixel Ratios:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('- iPhone SE (1st gen): 2.0x'),
              Text('- iPhone 11/12/13: 2.0x'),
              Text('- iPhone 11/12/13 Pro: 3.0x'),
              Text('- iPad: 2.0x'),
              Text('- Android (varies): 1.0x - 4.0x'),
              Text('- Desktop (standard): 1.0x'),
              Text('- Desktop (HiDPI): 2.0x'),
            ],
          ),
        ),
        
        // Section 4: sizeBytes Estimation
        buildSectionHeader('4. sizeBytes Estimation'),
        
        buildImagePropertyCard(
          'sizeBytes',
          'int?',
          'The number of bytes used by this image. May be null if the size is unknown. Calculated as width * height * bytesPerPixel for uncompressed images.',
          'final bytes = imageInfo.sizeBytes;\nprint(\'Memory: \${bytes ?? "unknown"} bytes\');',
          Icons.data_usage,
          Colors.red,
        ),
        
        buildSubsectionTitle('Memory Estimation Examples'),
        
        buildSizeBytesEstimation(100, 100, 4, 'Small icon (RGBA)', Colors.green),
        buildSizeBytesEstimation(512, 512, 4, 'Standard asset (RGBA)', Colors.blue),
        buildSizeBytesEstimation(1920, 1080, 4, 'Full HD image (RGBA)', Colors.orange),
        buildSizeBytesEstimation(3840, 2160, 4, '4K image (RGBA)', Colors.red),
        
        buildCodeBlock('''// Estimating memory usage
void estimateMemory(ImageInfo info) {
  final bytes = info.sizeBytes;
  if (bytes != null) {
    final kb = bytes / 1024;
    final mb = kb / 1024;
    print('Image uses \${mb.toStringAsFixed(2)} MB');
  }
  
  // Manual calculation when sizeBytes is null
  final width = info.image.width;
  final height = info.image.height;
  final estimated = width * height * 4; // 4 bytes for RGBA
  print('Estimated: \$estimated bytes');
}'''),
        
        buildInfoCard('RGBA', '4 bytes per pixel (Red, Green, Blue, Alpha)'),
        buildInfoCard('RGB', '3 bytes per pixel (no alpha channel)'),
        buildInfoCard('Warning', 'Large images can quickly exhaust GPU memory'),
        
        // Section 5: Clone Method
        buildSectionHeader('5. Clone Method'),
        
        buildImagePropertyCard(
          'clone()',
          'ImageInfo',
          'Creates a new ImageInfo with a cloned underlying image. The clone has its own reference to the GPU texture, so disposing one does not affect the other.',
          'final cloned = imageInfo.clone();\n// Use cloned independently\ncloned.dispose(); // Does not affect original',
          Icons.copy,
          Colors.indigo,
        ),
        
        buildSubsectionTitle('When to Clone'),
        
        buildCloneComparisonCard(
          'Store image beyond callback',
          'ImageStreamListener callback ends - image may be disposed',
          true,
          Colors.orange,
        ),
        buildCloneComparisonCard(
          'Pass to multiple widgets',
          'Each widget needs independent lifecycle control',
          true,
          Colors.orange,
        ),
        buildCloneComparisonCard(
          'Cache for later use',
          'Original may be disposed by image provider',
          true,
          Colors.orange,
        ),
        buildCloneComparisonCard(
          'Immediate use in same frame',
          'No async operations, using synchronously',
          false,
          Colors.green,
        ),
        buildCloneComparisonCard(
          'Framework-managed Image widget',
          'Flutter handles lifecycle automatically',
          false,
          Colors.green,
        ),
        
        buildCodeBlock('''// Clone pattern for caching
class ImageCache {
  final Map<String, ImageInfo> _cache = {};
  
  void cacheImage(String key, ImageInfo original) {
    // Must clone to own the image
    _cache[key] = original.clone();
  }
  
  void dispose() {
    for (final info in _cache.values) {
      info.dispose();
    }
    _cache.clear();
  }
}'''),
        
        buildInfoCard('Important', 'Each clone MUST be disposed independently'),
        buildInfoCard('Memory', 'Clones share texture initially but may duplicate on modification'),
        
        // Section 6: debugLabel
        buildSectionHeader('6. debugLabel'),
        
        buildImagePropertyCard(
          'debugLabel',
          'String?',
          'Optional label for debugging purposes. Shows up in debug output and diagnostics. Helps identify which image caused issues during development.',
          'final info = ImageInfo(\n  image: myImage,\n  debugLabel: \'user_profile_picture\',\n);',
          Icons.label,
          Colors.purple,
        ),
        
        buildSubsectionTitle('Debug Label Examples'),
        
        buildDebugLabelExample(
          'assets/images/logo.png',
          'Asset path as label',
          Icons.folder,
        ),
        buildDebugLabelExample(
          'network:https://example.com/avatar.jpg',
          'Network URL source',
          Icons.cloud,
        ),
        buildDebugLabelExample(
          'memory:profile_123_thumb',
          'Generated thumbnail identifier',
          Icons.photo_size_select_actual,
        ),
        buildDebugLabelExample(
          'placeholder:100x100@2x',
          'Placeholder dimensions',
          Icons.crop,
        ),
        
        buildCodeBlock('''// Debug label in diagnostics
void debugPrintImageInfo(ImageInfo info) {
  print('ImageInfo:');
  print('  debugLabel: \${info.debugLabel ?? "none"}');
  print('  image: \${info.image.width}x\${info.image.height}');
  print('  scale: \${info.scale}');
  print('  sizeBytes: \${info.sizeBytes}');
}

// toString() includes debugLabel
print(imageInfo);
// Output: ImageInfo(assets/icons/star.png@2x, ...)'''),
        
        // Section 7: Visual Demonstration
        buildSectionHeader('7. Visual Demonstration'),
        
        buildSubsectionTitle('Placeholder Graphics at Different Scales'),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildPlaceholderGraphic(100, 100, 1.0, '1x', Colors.blue),
            buildPlaceholderGraphic(100, 100, 2.0, '2x', Colors.green),
            buildPlaceholderGraphic(100, 100, 3.0, '3x', Colors.purple),
          ],
        ),
        
        buildSubsectionTitle('Same Source at Different Scales'),
        
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildScaledPlaceholder(1.0, Colors.red),
                  _buildScaledPlaceholder(2.0, Colors.amber),
                  _buildScaledPlaceholder(3.0, Colors.green),
                ],
              ),
              SizedBox(height: 12),
              Text(
                '120px source at 1x, 2x, 3x scales',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        
        buildSubsectionTitle('Aspect Ratio Preservation'),
        
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAspectDemo(1, 1, 'Square'),
                  _buildAspectDemo(16, 9, 'Wide'),
                  _buildAspectDemo(9, 16, 'Portrait'),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'ImageInfo preserves source aspect ratio',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        
        // Summary
        buildSectionHeader('Summary'),
        
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Takeaways',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 12),
              _buildTakeawayItem('ImageInfo wraps ui.Image with metadata'),
              _buildTakeawayItem('scale converts physical to logical pixels'),
              _buildTakeawayItem('sizeBytes estimates GPU memory usage'),
              _buildTakeawayItem('clone() creates independent copy'),
              _buildTakeawayItem('Always dispose() when finished'),
              _buildTakeawayItem('debugLabel aids development debugging'),
            ],
          ),
        ),
        
        SizedBox(height: 24),
        
        Center(
          child: Text(
            'ImageInfo Demo Complete',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        
        SizedBox(height: 16),
      ],
    ),
  );
}

Widget _buildScaledPlaceholder(double scale, Color color) {
  double displaySize = 120 / scale;
  
  return Column(
    children: [
      Container(
        width: displaySize,
        height: displaySize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '${scale.toInt()}x',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      Text('${displaySize.toInt()}dp', style: TextStyle(fontSize: 10)),
    ],
  );
}

Widget _buildAspectDemo(int aspectW, int aspectH, String label) {
  double baseSize = 40.0;
  double width = aspectW > aspectH ? baseSize : baseSize * aspectW / aspectH;
  double height = aspectH > aspectW ? baseSize : baseSize * aspectH / aspectW;
  
  return Column(
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.cyan.shade400,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10)),
      Text('$aspectW:$aspectH', style: TextStyle(fontSize: 9, color: Colors.grey)),
    ],
  );
}

Widget _buildTakeawayItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.teal, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    ),
  );
}
