// ignore_for_file: avoid_print
// D4rt test script: Tests PaintingBinding from painting
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
    margin: EdgeInsets.symmetric(vertical: 6),
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

Widget buildPaintingBindingInstanceSection() {
  print('Building PaintingBinding.instance section');
  
  List<String> instanceFacts = [
    'PaintingBinding.instance returns the singleton binding',
    'Accessed after WidgetsFlutterBinding.ensureInitialized()',
    'Provides painting-related services to the app',
    'Part of the binding mixin hierarchy',
    'Never null after binding initialization',
    'Thread-safe singleton access pattern',
  ];
  
  List<IconData> factIcons = [
    Icons.star,
    Icons.play_arrow,
    Icons.brush,
    Icons.layers,
    Icons.check_circle,
    Icons.lock,
  ];
  
  List<Color> factColors = [
    Colors.amber,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.teal,
    Colors.orange,
  ];
  
  List<Widget> factWidgets = [];
  int f = 0;
  for (f = 0; f < instanceFacts.length; f = f + 1) {
    factWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: factColors[f].withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: factColors[f].withAlpha(100)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: factColors[f],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                factIcons[f],
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                instanceFacts[f],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.settings_applications, color: Colors.indigo, size: 24),
            SizedBox(width: 8),
            Text(
              'PaintingBinding.instance',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildCodeBlock('PaintingBinding binding = PaintingBinding.instance;'),
        SizedBox(height: 12),
        Column(children: factWidgets),
      ],
    ),
  );
}

Widget buildInstanceAccessPatterns() {
  print('Building instance access patterns');
  
  List<String> patternTitles = [
    'Ensure Initialization First',
    'Direct Instance Access',
    'Via WidgetsBinding',
    'Null-Safe Access Pattern',
  ];
  
  List<String> patternCodes = [
    'void main() {\n  WidgetsFlutterBinding.ensureInitialized();\n  runApp(MyApp());\n}',
    'PaintingBinding binding = PaintingBinding.instance;\nImageCache cache = binding.imageCache;',
    'WidgetsBinding.instance;\n// Also provides PaintingBinding functionality',
    'PaintingBinding? binding = PaintingBinding.instance;\nif (binding != null) {\n  // Safe to use\n}',
  ];
  
  List<String> patternNotes = [
    'Always ensure binding is initialized before accessing',
    'Direct access when you know binding is initialized',
    'WidgetsBinding includes all binding mixins',
    'Use null-safe pattern in edge cases',
  ];
  
  List<Widget> patternWidgets = [];
  int p = 0;
  for (p = 0; p < patternTitles.length; p = p + 1) {
    patternWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade600,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${p + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    patternTitles[p],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                patternCodes[p],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.amber.shade300,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              patternNotes[p],
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instance Access Patterns',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different ways to access PaintingBinding',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: patternWidgets),
      ],
    ),
  );
}

Widget buildImageCachePropertySection() {
  print('Building imageCache property section');
  
  List<String> cacheProperties = [
    'maximumSize: max number of images',
    'maximumSizeBytes: max memory in bytes',
    'currentSize: current cached image count',
    'currentSizeBytes: current memory usage',
    'liveImageCount: images with active handles',
    'pendingImageCount: images being loaded',
  ];
  
  List<IconData> propIcons = [
    Icons.format_list_numbered,
    Icons.memory,
    Icons.image,
    Icons.data_usage,
    Icons.visibility,
    Icons.hourglass_empty,
  ];
  
  List<Widget> propWidgets = [];
  int i = 0;
  for (i = 0; i < cacheProperties.length; i = i + 1) {
    Color rowColor = (i % 2 == 0) ? Colors.blue.shade50 : Colors.white;
    propWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: rowColor,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Icon(
              propIcons[i],
              size: 20,
              color: Colors.blue.shade700,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                cacheProperties[i],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.cached, color: Colors.blue.shade700, size: 22),
              SizedBox(width: 10),
              Text(
                'imageCache Property',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
        ),
        buildCodeBlock('ImageCache get imageCache => PaintingBinding.instance.imageCache;'),
        Column(children: propWidgets),
      ],
    ),
  );
}

Widget buildImageCacheConfigurationSection() {
  print('Building imageCache configuration section');
  
  List<String> configTitles = [
    'Set Maximum Image Count',
    'Set Maximum Memory Size',
    'Clear All Cached Images',
    'Clear Specific Image',
    'Evict Image by Key',
  ];
  
  List<String> configCodes = [
    'PaintingBinding.instance.imageCache.maximumSize = 1000;',
    'PaintingBinding.instance.imageCache.maximumSizeBytes = 100 << 20;',
    'PaintingBinding.instance.imageCache.clear();',
    'PaintingBinding.instance.imageCache.clearLiveImages();',
    'PaintingBinding.instance.imageCache.evict(imageKey);',
  ];
  
  List<String> configDescriptions = [
    'Default is 1000 images. Increase for image-heavy apps.',
    'Default is 100MB. Set based on available memory.',
    'Removes all cached images. Use sparingly.',
    'Clears images with active handles only.',
    'Removes specific image by its cache key.',
  ];
  
  List<Color> configColors = [
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
  ];
  
  List<Widget> configWidgets = [];
  int c = 0;
  for (c = 0; c < configTitles.length; c = c + 1) {
    configWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: configColors[c].withAlpha(20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: configColors[c].withAlpha(80)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: configColors[c],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${c + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    configTitles[c],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: configColors[c],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                configCodes[c],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.cyan.shade300,
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              configDescriptions[c],
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ImageCache Configuration',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Methods to configure and manage the image cache',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: configWidgets),
      ],
    ),
  );
}

Widget buildInstantiateImageCodecSection() {
  print('Building instantiateImageCodec section');
  
  List<String> codecSteps = [
    'Obtain image bytes from source',
    'Call instantiateImageCodec with bytes',
    'Await the Future<Codec> result',
    'Use codec to get frames',
    'Dispose codec when done',
  ];
  
  List<String> stepDetails = [
    'Load bytes from network, asset, or file system',
    'Binding decodes bytes into a Codec instance',
    'Codec is ready for frame extraction',
    'getNextFrame() returns FrameInfo objects',
    'Always dispose to release native resources',
  ];
  
  List<IconData> stepIcons = [
    Icons.download,
    Icons.transform,
    Icons.hourglass_bottom,
    Icons.video_library,
    Icons.delete_outline,
  ];
  
  List<Widget> stepWidgets = [];
  int s = 0;
  for (s = 0; s < codecSteps.length; s = s + 1) {
    stepWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade600,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  stepIcons[s],
                  color: Colors.white,
                  size: 24,
                ),
              ),
              if (s < codecSteps.length - 1)
                Container(
                  width: 3,
                  height: 40,
                  color: Colors.deepOrange.shade200,
                ),
            ],
          ),
          SizedBox(width: 14),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.deepOrange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    codecSteps[s],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    stepDetails[s],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.deepOrange, size: 24),
            SizedBox(width: 8),
            Text(
              'instantiateImageCodec',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildCodeBlock('Future<ui.Codec> instantiateImageCodec(\n  Uint8List bytes, {\n  int? cacheWidth,\n  int? cacheHeight,\n  bool allowUpscaling = false,\n});'),
        SizedBox(height: 12),
        Column(children: stepWidgets),
      ],
    ),
  );
}

Widget buildInstantiateImageCodecExample() {
  print('Building instantiateImageCodec example');
  
  String exampleCode = '''
Future<ui.Image> decodeImage(Uint8List bytes) async {
  ui.Codec codec = await PaintingBinding.instance
      .instantiateImageCodec(bytes);
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  ui.Image image = frameInfo.image;
  codec.dispose();
  return image;
}''';

  String resizeCode = '''
Future<ui.Image> decodeResized(Uint8List bytes) async {
  ui.Codec codec = await PaintingBinding.instance
      .instantiateImageCodec(
        bytes,
        cacheWidth: 200,
        cacheHeight: 200,
      );
  ui.FrameInfo frame = await codec.getNextFrame();
  return frame.image;
}''';

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'instantiateImageCodec Examples',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.image, color: Colors.green.shade700, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Basic Decode',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  exampleCode,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.green.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.photo_size_select_small, color: Colors.orange.shade700, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Decode with Resize',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  resizeCode,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.orange.shade300,
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

Widget buildInstantiateImageCodecWithSizeSection() {
  print('Building instantiateImageCodecWithSize section');
  
  List<String> features = [
    'Returns codec along with natural image dimensions',
    'Useful when you need size before decoding',
    'getTargetSize callback determines output dimensions',
    'More efficient for responsive image loading',
    'Avoids double-decode for size detection',
  ];
  
  List<Widget> featureWidgets = [];
  int f = 0;
  for (f = 0; f < features.length; f = f + 1) {
    featureWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 18,
              color: Colors.purple.shade600,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                features[f],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.aspect_ratio, color: Colors.purple, size: 24),
            SizedBox(width: 8),
            Text(
              'instantiateImageCodecWithSize',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildCodeBlock('Future<ui.Codec> instantiateImageCodecWithSize(\n  ui.ImmutableBuffer buffer, {\n  TargetImageSizeCallback? getTargetSize,\n});'),
        SizedBox(height: 12),
        Column(children: featureWidgets),
      ],
    ),
  );
}

Widget buildCodecWithSizeExample() {
  print('Building codec with size example');
  
  String callbackCode = '''
typedef TargetImageSizeCallback = TargetImageSize Function(
  int intrinsicWidth,
  int intrinsicHeight,
);''';

  String usageCode = '''
Future<ui.Codec> loadResponsiveImage(Uint8List bytes) async {
  ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
  
  ui.Codec codec = await PaintingBinding.instance
      .instantiateImageCodecWithSize(
        buffer,
        getTargetSize: (int width, int height) {
          // Calculate responsive size
          double aspectRatio = width / height;
          int targetWidth = 400;
          int targetHeight = (targetWidth / aspectRatio).round();
          return TargetImageSize(
            width: targetWidth,
            height: targetHeight,
          );
        },
      );
  
  return codec;
}''';

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'instantiateImageCodecWithSize Examples',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TargetImageSizeCallback Typedef',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  callbackCode,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Colors.indigo.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Responsive Image Loading',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  usageCode,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.teal.shade300,
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

Widget buildSystemFontsChangedSection() {
  print('Building system fonts changed section');
  
  List<String> eventDetails = [
    'Triggered when system fonts change',
    'Fonts may change during app runtime',
    'User installs new fonts on device',
    'System font settings modified',
    'Font accessibility settings changed',
  ];
  
  List<String> handlerActions = [
    'Notify text rendering widgets',
    'Invalidate cached text layouts',
    'Trigger text repainting',
    'Update font metrics',
    'Refresh font family lists',
  ];
  
  List<Widget> detailWidgets = [];
  int d = 0;
  for (d = 0; d < eventDetails.length; d = d + 1) {
    detailWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.cyan.shade600,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                eventDetails[d],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  List<Widget> actionWidgets = [];
  int a = 0;
  for (a = 0; a < handlerActions.length; a = a + 1) {
    actionWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward,
              size: 16,
              color: Colors.orange.shade600,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                handlerActions[a],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.font_download, color: Colors.cyan.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'System Fonts Changed Handling',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildCodeBlock('void handleSystemFontsChanged() {\n  systemFonts.notifyListeners();\n}'),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When This Event Occurs',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade800,
                ),
              ),
              SizedBox(height: 8),
              Column(children: detailWidgets),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Handler Actions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
              SizedBox(height: 8),
              Column(children: actionWidgets),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSystemFontsListenerExample() {
  print('Building system fonts listener example');
  
  String listenerCode = '''
class FontAwareWidget extends StatefulWidget {
  @override
  State createState() => _FontAwareWidgetState();
}

class _FontAwareWidgetState extends State<FontAwareWidget> {
  @override
  void initState() {
    super.initState();
    PaintingBinding.instance.systemFonts.addListener(_onFontsChanged);
  }
  
  void _onFontsChanged() {
    setState(() {
      // Rebuild to pick up new fonts
    });
  }
  
  @override
  void dispose() {
    PaintingBinding.instance.systemFonts.removeListener(_onFontsChanged);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text("I update when system fonts change");
  }
}''';

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listening to System Font Changes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How to respond when system fonts change',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            listenerCode,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.lime.shade300,
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.amber.shade700, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Always remove listener in dispose() to prevent memory leaks',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBindingMixinHierarchy() {
  print('Building binding mixin hierarchy');
  
  List<String> mixinNames = [
    'BindingBase',
    'GestureBinding',
    'SchedulerBinding',
    'ServicesBinding',
    'PaintingBinding',
    'SemanticsBinding',
    'RendererBinding',
    'WidgetsBinding',
  ];
  
  List<String> mixinDescriptions = [
    'Base class for all bindings',
    'Gesture recognition and hit testing',
    'Frame scheduling and timing',
    'Platform services integration',
    'Image caching and codec',
    'Accessibility tree management',
    'Render tree management',
    'Widget tree management',
  ];
  
  List<Color> mixinColors = [
    Colors.grey,
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.indigo,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];
  
  List<Widget> mixinWidgets = [];
  int m = 0;
  for (m = 0; m < mixinNames.length; m = m + 1) {
    bool isPainting = mixinNames[m] == 'PaintingBinding';
    mixinWidgets.add(
      Container(
        margin: EdgeInsets.only(left: m * 8.0),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isPainting ? Colors.indigo.shade100 : mixinColors[m].withAlpha(30),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isPainting ? Colors.indigo : mixinColors[m].withAlpha(100),
            width: isPainting ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: mixinColors[m],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10),
            Text(
              mixinNames[m],
              style: TextStyle(
                fontSize: 13,
                fontWeight: isPainting ? FontWeight.bold : FontWeight.normal,
                color: isPainting ? Colors.indigo.shade800 : Colors.grey.shade800,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '- ${mixinDescriptions[m]}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
    if (m < mixinNames.length - 1) {
      mixinWidgets.add(SizedBox(height: 4));
    }
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.blueGrey, size: 24),
            SizedBox(width: 8),
            Text(
              'Binding Mixin Hierarchy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'PaintingBinding in the Flutter binding stack',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: mixinWidgets,
        ),
      ],
    ),
  );
}

Widget buildPaintingBindingSummary() {
  print('Building PaintingBinding summary');
  
  List<String> summaryPoints = [
    'PaintingBinding is a mixin that provides painting services',
    'Access via PaintingBinding.instance after binding init',
    'imageCache manages decoded image caching',
    'instantiateImageCodec decodes image bytes to Codec',
    'instantiateImageCodecWithSize enables responsive sizing',
    'systemFonts notifies when system fonts change',
    'Part of WidgetsFlutterBinding mixin hierarchy',
  ];
  
  List<IconData> summaryIcons = [
    Icons.extension,
    Icons.login,
    Icons.cached,
    Icons.image,
    Icons.aspect_ratio,
    Icons.font_download,
    Icons.layers,
  ];
  
  List<Widget> summaryWidgets = [];
  int s = 0;
  for (s = 0; s < summaryPoints.length; s = s + 1) {
    summaryWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: (s % 2 == 0) ? Colors.indigo.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              summaryIcons[s],
              size: 20,
              color: Colors.indigo.shade600,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                summaryPoints[s],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade300, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.indigo.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'PaintingBinding Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: summaryWidgets),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PaintingBinding deep demo test executing');
  print('Testing PaintingBinding from painting library');
  
  print('\n--- PaintingBinding.instance ---');
  print('Singleton access to painting binding');
  print('Available after WidgetsFlutterBinding.ensureInitialized()');
  
  print('\n--- imageCache Property ---');
  print('ImageCache manages decoded image storage');
  print('Configurable max size and memory limits');
  
  print('\n--- instantiateImageCodec ---');
  print('Decodes image bytes into ui.Codec');
  print('Supports resize during decode');
  
  print('\n--- instantiateImageCodecWithSize ---');
  print('Returns codec with natural dimensions');
  print('getTargetSize callback for responsive sizing');
  
  print('\n--- System Fonts Changed ---');
  print('handleSystemFontsChanged() notifies listeners');
  print('systemFonts Listenable for font updates');
  
  print('\nPaintingBinding deep demo completed');

  List<Widget> allSections = [];
  
  allSections.add(buildSectionHeader('PaintingBinding Deep Demo'));
  
  allSections.add(buildSectionHeader('1. PaintingBinding.instance'));
  allSections.add(buildPaintingBindingInstanceSection());
  allSections.add(buildInstanceAccessPatterns());
  
  allSections.add(buildSectionHeader('2. imageCache Property'));
  allSections.add(buildImageCachePropertySection());
  allSections.add(buildImageCacheConfigurationSection());
  
  allSections.add(buildSectionHeader('3. instantiateImageCodec'));
  allSections.add(buildInstantiateImageCodecSection());
  allSections.add(buildInstantiateImageCodecExample());
  
  allSections.add(buildSectionHeader('4. instantiateImageCodecWithSize'));
  allSections.add(buildInstantiateImageCodecWithSizeSection());
  allSections.add(buildCodecWithSizeExample());
  
  allSections.add(buildSectionHeader('5. System Fonts Changed Handling'));
  allSections.add(buildSystemFontsChangedSection());
  allSections.add(buildSystemFontsListenerExample());
  
  allSections.add(buildSectionHeader('Binding Hierarchy'));
  allSections.add(buildBindingMixinHierarchy());
  
  allSections.add(buildSectionHeader('Summary'));
  allSections.add(buildPaintingBindingSummary());

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allSections,
    ),
  );
}
