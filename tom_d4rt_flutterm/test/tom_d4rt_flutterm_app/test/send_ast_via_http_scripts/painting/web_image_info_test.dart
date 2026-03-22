// D4rt test script: Tests WebImageInfo from painting
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.cyan.shade700,
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

Widget buildPropertyCard(
  String propertyName,
  String propertyType,
  String description,
  Color accentColor,
) {
  print('Building property card: $propertyName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accentColor.withAlpha(30), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accentColor.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                propertyName,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              propertyType,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget buildPlatformComparisonCard(
  String platform,
  String imageInfoType,
  String description,
  IconData icon,
  Color color,
) {
  print('Building platform comparison for: $platform');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                platform,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                imageInfoType,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMemoryInfoCard(
  String title,
  String value,
  String explanation,
  IconData icon,
  Color color,
) {
  print('Building memory info card: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border(left: BorderSide(color: color, width: 4)),
      color: Colors.grey.shade50,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 28),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                explanation,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildConstraintCard(
  String constraint,
  String impact,
  String workaround,
  Color severityColor,
) {
  print('Building constraint card: $constraint');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: severityColor.withAlpha(150)),
      boxShadow: [
        BoxShadow(
          color: severityColor.withAlpha(30),
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
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: severityColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                constraint,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Impact: ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
              Expanded(
                child: Text(
                  impact,
                  style: TextStyle(fontSize: 12, color: Colors.red.shade900),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Solution: ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              Expanded(
                child: Text(
                  workaround,
                  style: TextStyle(fontSize: 12, color: Colors.green.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildScaleExampleCard(
  double scaleValue,
  String deviceType,
  String resolution,
  Color color,
) {
  print('Building scale example: $deviceType at $scaleValue');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${scaleValue}x',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deviceType,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 3),
              Text(
                resolution,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.devices,
          color: color,
          size: 22,
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== WebImageInfo Deep Demo ===');
  print('Exploring web platform image information');

  List<Widget> children = [];

  // -----------------------------
  // Section 1: Class Overview
  // -----------------------------
  children.add(buildSectionHeader('1. WebImageInfo Class Overview'));
  print('\n--- WebImageInfo Class Overview ---');

  children.add(buildInfoCard('Class', 'WebImageInfo extends ImageInfo'));
  children.add(buildInfoCard('Package', 'package:flutter/painting.dart'));
  children.add(buildInfoCard('Platform', 'Web-specific implementation'));
  children.add(buildInfoCard('Availability', 'Only on Flutter Web platform'));

  print('WebImageInfo is a web-specific extension of ImageInfo');
  print('It provides additional metadata for web-based images');
  print('This class is only available when running on Flutter Web');

  children.add(SizedBox(height: 12));

  children.add(
    Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.cyan.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Purpose',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'WebImageInfo extends the standard ImageInfo class to provide '
            'web-specific image handling capabilities. On web platforms, '
            'images may be backed by HTML elements rather than traditional '
            'bitmap data, requiring specialized handling.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ],
      ),
    ),
  );

  children.add(buildCodeBlock('''// WebImageInfo class signature (web platform)
class WebImageInfo implements ImageInfo {
  final ui.Image image;
  final double scale;
  final String debugLabel;
  
  // Web-specific: may wrap HTML <img> element
  // Browser handles actual pixel data
}'''));

  print('WebImageInfo wraps HTML image elements on web');
  print('Browser manages actual image decoding and caching');

  // Inheritance diagram
  children.add(
    Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class Hierarchy',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '  Object\n'
            '    ↳ ImageInfo (base class)\n'
            '        ↳ WebImageInfo (web extension)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Colors.indigo.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  // -----------------------------
  // Section 2: image Property
  // -----------------------------
  children.add(buildSectionHeader('2. Image Property'));
  print('\n--- Image Property ---');

  children.add(
    buildPropertyCard(
      'image',
      'ui.Image',
      'The decoded image data. On web, this wraps browser-managed '
      'image resources rather than raw pixel buffers.',
      Colors.blue,
    ),
  );

  print('The image property holds decoded image data');
  print('On web, browser manages the underlying pixel data');

  children.add(buildCodeBlock('''// Accessing the image property
void processWebImage(WebImageInfo info) {
  ui.Image img = info.image;
  
  // Get dimensions
  int width = img.width;
  int height = img.height;
  
  // Draw to canvas
  canvas.drawImage(img, Offset.zero, Paint());
  
  // Important: dispose when done
  img.dispose();
}'''));

  children.add(
    Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.image, color: Colors.blue.shade700),
              SizedBox(width: 8),
              Text(
                'Web Image Characteristics',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          buildInfoCard('Backing', 'HTML5 Canvas or <img> element'),
          buildInfoCard('Decoding', 'Handled by browser engine'),
          buildInfoCard('Format Support', 'JPEG, PNG, GIF, WebP, AVIF'),
          buildInfoCard('Memory Model', 'Browser garbage collected'),
        ],
      ),
    ),
  );

  // Image dimension examples
  List<Map<String, dynamic>> imageSizes = [
    {'name': 'Thumbnail', 'width': 150, 'height': 150, 'color': Colors.green},
    {'name': 'Avatar', 'width': 200, 'height': 200, 'color': Colors.teal},
    {'name': 'Preview', 'width': 400, 'height': 300, 'color': Colors.blue},
    {'name': 'Full HD', 'width': 1920, 'height': 1080, 'color': Colors.indigo},
    {'name': '4K UHD', 'width': 3840, 'height': 2160, 'color': Colors.purple},
  ];

  children.add(SizedBox(height: 8));
  children.add(
    Text(
      'Common Image Dimensions',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade800,
      ),
    ),
  );

  int sizeIdx = 0;
  for (sizeIdx = 0; sizeIdx < imageSizes.length; sizeIdx = sizeIdx + 1) {
    Map<String, dynamic> size = imageSizes[sizeIdx];
    children.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: (size['color'] as Color).withAlpha(20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              child: Text(
                size['name'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: size['color'] as Color,
                ),
              ),
            ),
            Text(
              '${size['width']} × ${size['height']}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
            Spacer(),
            Text(
              '${((size['width'] as int) * (size['height'] as int) * 4 / 1024 / 1024).toStringAsFixed(1)} MB',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------
  // Section 3: scale Property
  // -----------------------------
  children.add(buildSectionHeader('3. Scale Property'));
  print('\n--- Scale Property ---');

  children.add(
    buildPropertyCard(
      'scale',
      'double',
      'The linear scale factor for the image. A scale of 2.0 means the '
      'image should be displayed at half its pixel dimensions.',
      Colors.orange,
    ),
  );

  print('Scale determines how image pixels map to logical pixels');
  print('Higher scale = higher density display support');

  children.add(buildCodeBlock('''// Understanding scale property
void calculateDisplaySize(WebImageInfo info) {
  int pixelWidth = info.image.width;
  int pixelHeight = info.image.height;
  double scale = info.scale;
  
  // Logical display size
  double displayWidth = pixelWidth / scale;
  double displayHeight = pixelHeight / scale;
  
  print("Pixel: \${pixelWidth}x\${pixelHeight}");
  print("Display: \${displayWidth}x\${displayHeight}");
  print("Scale: \${scale}x");
}'''));

  // Scale examples
  children.add(SizedBox(height: 8));
  children.add(buildScaleExampleCard(
    1.0,
    'Standard Display',
    '1 image pixel = 1 logical pixel',
    Colors.green,
  ));
  children.add(buildScaleExampleCard(
    2.0,
    'Retina / HiDPI',
    '2 image pixels = 1 logical pixel',
    Colors.blue,
  ));
  children.add(buildScaleExampleCard(
    3.0,
    'Super Retina',
    '3 image pixels = 1 logical pixel',
    Colors.purple,
  ));
  children.add(buildScaleExampleCard(
    4.0,
    'Ultra HD Display',
    '4 image pixels = 1 logical pixel',
    Colors.indigo,
  ));

  print('Scale 1.0 = standard resolution');
  print('Scale 2.0 = Retina/HiDPI displays');
  print('Scale 3.0+ = Super high density displays');

  children.add(
    Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb, color: Colors.amber.shade700),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scale Best Practice',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Always provide images at appropriate scales for web. '
                  'Use srcset in HTML or AssetImage with resolution-aware '
                  'asset variants to serve optimal images per device.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // -----------------------------
  // Section 4: Web Platform Considerations
  // -----------------------------
  children.add(buildSectionHeader('4. Web Platform Considerations'));
  print('\n--- Web Platform Considerations ---');

  children.add(buildPlatformComparisonCard(
    'Flutter Web (CanvasKit)',
    'WebImageInfo',
    'Uses WASM-based Skia rendering. Images decoded via browser APIs then '
    'uploaded to GPU via WebGL.',
    Icons.web,
    Colors.blue,
  ));

  children.add(buildPlatformComparisonCard(
    'Flutter Web (HTML)',
    'WebImageInfo',
    'Uses HTML elements directly. <img> tags handle rendering. '
    'More compatible but less consistent.',
    Icons.code,
    Colors.teal,
  ));

  children.add(buildPlatformComparisonCard(
    'Native Platforms',
    'ImageInfo',
    'Standard ImageInfo with direct pixel buffer access. '
    'Skia handles all rendering natively.',
    Icons.phone_android,
    Colors.green,
  ));

  print('CanvasKit renderer uses WebGL for high-fidelity rendering');
  print('HTML renderer uses native browser elements');

  children.add(buildCodeBlock('''// Platform-aware image handling
import "package:flutter/foundation.dart" show kIsWeb;

void handleImageLoad(ImageInfo info) {
  if (kIsWeb) {
    // Web platform - browser manages memory
    print("Web: Browser handles image lifecycle");
    // May be WebImageInfo under the hood
  } else {
    // Native platform - manual disposal needed
    print("Native: Manual memory management");
    info.image.dispose();
  }
}'''));

  // CORS considerations
  children.add(
    Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red.shade700),
              SizedBox(width: 8),
              Text(
                'CORS Requirements',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Web images loaded from external sources must have proper '
            'CORS headers. Without Access-Control-Allow-Origin, the image '
            'cannot be drawn to canvas or manipulated.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          SizedBox(height: 8),
          buildCodeBlock('''// Server must respond with:
Access-Control-Allow-Origin: *
// Or specific origin:
Access-Control-Allow-Origin: https://yourapp.com'''),
        ],
      ),
    ),
  );

  // Browser differences table
  List<Map<String, String>> browserFeatures = [
    {'browser': 'Chrome', 'webp': 'Yes', 'avif': 'Yes', 'notes': 'Full support'},
    {'browser': 'Firefox', 'webp': 'Yes', 'avif': 'Yes', 'notes': 'Full support'},
    {'browser': 'Safari', 'webp': 'Yes', 'avif': 'iOS 16+', 'notes': 'Partial AVIF'},
    {'browser': 'Edge', 'webp': 'Yes', 'avif': 'Yes', 'notes': 'Chromium-based'},
  ];

  children.add(SizedBox(height: 10));
  children.add(
    Text(
      'Browser Format Support',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade800,
      ),
    ),
  );
  children.add(SizedBox(height: 6));

  children.add(
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(child: Text('Browser', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 50, child: Text('WebP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 60, child: Text('AVIF', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(child: Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
              ],
            ),
          ),
          ...browserFeatures.map((row) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(row['browser'] ?? '', style: TextStyle(fontSize: 12))),
                  SizedBox(width: 50, child: Text(row['webp'] ?? '', style: TextStyle(fontSize: 12, color: Colors.green.shade700))),
                  SizedBox(width: 60, child: Text(row['avif'] ?? '', style: TextStyle(fontSize: 12))),
                  Expanded(child: Text(row['notes'] ?? '', style: TextStyle(fontSize: 12, color: Colors.grey.shade600))),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    ),
  );

  // -----------------------------
  // Section 5: Memory Management
  // -----------------------------
  children.add(buildSectionHeader('5. Memory Management'));
  print('\n--- Memory Management ---');

  children.add(buildMemoryInfoCard(
    'Browser GC',
    'Automatic',
    'JavaScript garbage collector manages web image memory. '
    'No manual disposal required for browser-backed images.',
    Icons.memory,
    Colors.green,
  ));

  children.add(buildMemoryInfoCard(
    'GPU Memory',
    'WebGL Managed',
    'CanvasKit uploads textures to GPU via WebGL. Browser manages '
    'texture eviction based on memory pressure.',
    Icons.graphic_eq,
    Colors.blue,
  ));

  children.add(buildMemoryInfoCard(
    'Image Cache',
    'Browser Cache',
    'HTTP cache headers control image persistence. Cache-Control '
    'and ETag headers determine revalidation.',
    Icons.cached,
    Colors.purple,
  ));

  children.add(buildMemoryInfoCard(
    'Disposal',
    'Still Recommended',
    'While browser GC helps, calling dispose() explicitly helps '
    'release resources sooner, especially for large images.',
    Icons.delete_sweep,
    Colors.orange,
  ));

  print('Browser garbage collection handles most cleanup');
  print('Explicit disposal still recommended for large images');

  children.add(buildCodeBlock('''// Memory-conscious image handling on web
class WebImageHandler {
  List<ui.Image> _loadedImages = [];
  
  void loadImage(WebImageInfo info) {
    _loadedImages.add(info.image);
    // Browser tracks references
  }
  
  void clearImages() {
    // Explicitly release references
    int idx = 0;
    for (idx = 0; idx < _loadedImages.length; idx = idx + 1) {
      _loadedImages[idx].dispose();
    }
    _loadedImages.clear();
    // Browser GC will reclaim memory
  }
  
  int get activeImageCount => _loadedImages.length;
}'''));

  // Memory pressure handling
  children.add(
    Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.red.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed, color: Colors.orange.shade700),
              SizedBox(width: 8),
              Text(
                'Memory Pressure on Web',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          buildInfoCard('Tab Memory Limit', '~1-4 GB per tab (browser dependent)'),
          buildInfoCard('Warning Signs', 'Slow rendering, dropped frames'),
          buildInfoCard('Mitigation', 'Lazy loading, image resizing, caching'),
          buildInfoCard('Monitoring', 'Performance DevTools, memory timeline'),
        ],
      ),
    ),
  );

  // -----------------------------
  // Section 6: Web-Specific Constraints
  // -----------------------------
  children.add(buildSectionHeader('6. Web-Specific Constraints'));
  print('\n--- Web-Specific Constraints ---');

  children.add(buildConstraintCard(
    'Same-Origin Policy',
    'Images from different origins cannot be manipulated pixel-by-pixel '
    'without CORS headers. Drawing tainted canvas fails.',
    'Configure server CORS headers, or proxy images through your backend.',
    Colors.red,
  ));

  children.add(buildConstraintCard(
    'No Direct Pixel Access',
    'Unlike native, cannot directly read pixel buffers. Must use canvas '
    'getImageData which is slower and has CORS restrictions.',
    'Process images server-side when pixel manipulation is required.',
    Colors.orange,
  ));

  children.add(buildConstraintCard(
    'Async Decoding Only',
    'All image decoding is asynchronous. No synchronous image load APIs '
    'available in browser environment.',
    'Design UI to handle loading states gracefully with placeholders.',
    Colors.yellow.shade700,
  ));

  children.add(buildConstraintCard(
    'Format Limitations',
    'Some image formats may not be supported across all browsers. Older '
    'browsers lack WebP/AVIF support.',
    'Provide fallback formats (JPEG/PNG) using picture element or checks.',
    Colors.blue,
  ));

  children.add(buildConstraintCard(
    'Memory Fragmentation',
    'Long-running web apps may experience memory fragmentation. Browser '
    'cannot compact JavaScript heap like native.',
    'Periodic page refresh for long sessions, or use service workers.',
    Colors.purple,
  ));

  print('Web has unique constraints: CORS, async-only, format support');
  print('Plan for graceful degradation and fallbacks');

  children.add(buildCodeBlock('''// Handling web constraints gracefully
Future<ui.Image?> loadImageSafely(String url) async {
  try {
    // Use NetworkImage with error handling
    ImageProvider provider = NetworkImage(url);
    
    Completer<ui.Image?> completer = Completer();
    ImageStream stream = provider.resolve(ImageConfiguration());
    
    ImageStreamListener listener = ImageStreamListener(
      (ImageInfo info, bool sync) {
        completer.complete(info.image);
      },
      onError: (dynamic error, StackTrace? stack) {
        print("Image load failed: \$error");
        completer.complete(null);
      },
    );
    
    stream.addListener(listener);
    
    return await completer.future;
  } catch (e) {
    print("Caught exception: \$e");
    return null;
  }
}'''));

  // Summary tips
  children.add(
    Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyan.shade300, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.summarize, color: Colors.cyan.shade700),
              SizedBox(width: 8),
              Text(
                'WebImageInfo Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          buildInfoCard('Class', 'WebImageInfo extends ImageInfo'),
          buildInfoCard('image', 'ui.Image - browser-managed decoded data'),
          buildInfoCard('scale', 'double - device pixel ratio factor'),
          buildInfoCard('Platform', 'Flutter Web only (CanvasKit/HTML)'),
          buildInfoCard('Memory', 'Browser GC + manual dispose recommended'),
          buildInfoCard('Constraints', 'CORS, async, format compatibility'),
        ],
      ),
    ),
  );

  print('\n=== WebImageInfo Deep Demo Complete ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}
