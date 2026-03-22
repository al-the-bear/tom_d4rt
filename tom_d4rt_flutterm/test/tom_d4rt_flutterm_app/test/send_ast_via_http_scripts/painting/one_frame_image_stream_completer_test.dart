// D4rt test script: Deep demo of OneFrameImageStreamCompleter from painting
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
        Container(
          width: 120,
          child: Text(
            property,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.teal.shade800,
            ),
          ),
        ),
        Container(
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

Widget buildImageFormatCard(String format, String extension, bool isSupported) {
  return Container(
    width: 110,
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: isSupported ? Colors.green.shade50 : Colors.red.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isSupported ? Colors.green : Colors.red,
        width: 2,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isSupported ? Icons.check_circle : Icons.cancel,
          color: isSupported ? Colors.green : Colors.red,
          size: 24,
        ),
        SizedBox(height: 4),
        Text(
          format,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        SizedBox(height: 2),
        Text(
          extension,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildComparisonCard(
  String title,
  String oneFrameValue,
  String multiFrameValue,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Text(
                      'OneFrame',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      oneFrameValue,
                      style: TextStyle(fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Text(
                      'MultiFrame',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      multiFrameValue,
                      style: TextStyle(fontSize: 11),
                      textAlign: TextAlign.center,
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
}

Widget buildErrorCard(String errorType, String cause, String handling) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.red.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 20),
            SizedBox(width: 8),
            Text(
              errorType,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cause:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(cause, style: TextStyle(fontSize: 11)),
              SizedBox(height: 6),
              Text(
                'Handling:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(handling, style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildScaleExampleCard(double scale, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.blue.shade300),
          ),
          child: Center(
            child: Text(
              '${scale}x',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scale: $scale',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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

Widget buildLifecycleStep(int step, String title, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.teal,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
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

Widget buildDebugLabelCard(String label, String purpose) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.bug_report, color: Colors.amber.shade700, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                purpose,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFeatureCard(String feature, bool hasFeature) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: hasFeature ? Colors.green.shade50 : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: hasFeature ? Colors.green.shade300 : Colors.grey.shade300,
      ),
    ),
    child: Row(
      children: [
        Icon(
          hasFeature ? Icons.check : Icons.close,
          color: hasFeature ? Colors.green : Colors.grey,
          size: 18,
        ),
        SizedBox(width: 8),
        Text(
          feature,
          style: TextStyle(
            fontSize: 12,
            color: hasFeature ? Colors.green.shade800 : Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

void demonstrateOneFrameImageStreamCompleterConstructor() {
  print('\n=== OneFrameImageStreamCompleter Constructor Demo ===');
  
  print('\nConstructor signature:');
  print('OneFrameImageStreamCompleter(');
  print('  Future<ImageInfo> image, {');
  print('  InformationCollector? informationCollector,');
  print('})');
  
  print('\nKey characteristics:');
  print('- Takes a Future<ImageInfo> as the primary parameter');
  print('- Future resolves to a single image frame');
  print('- No codec parameter needed (unlike MultiFrame)');
  print('- Simpler construction for static images');
  
  print('\nImageInfo contains:');
  print('- ui.Image image: The decoded image data');
  print('- double scale: The intended display scale');
  print('- String? debugLabel: Optional debug identifier');
}

void demonstrateImageFutureParameter() {
  print('\n=== Image Future Parameter Demo ===');
  
  print('\nThe Future<ImageInfo> parameter:');
  print('- Represents async image loading operation');
  print('- Resolves when image bytes are decoded');
  print('- Contains the final ui.Image and metadata');
  
  print('\nCreating ImageInfo:');
  print('Future<ImageInfo> loadImage() async {');
  print('  final bytes = await fetchBytes();');
  print('  final codec = await ui.instantiateImageCodec(bytes);');
  print('  final frame = await codec.getNextFrame();');
  print('  return ImageInfo(image: frame.image);');
  print('}');
  
  print('\nFuture states handled:');
  print('1. Pending: Listeners wait for completion');
  print('2. Completed: All listeners notified with ImageInfo');
  print('3. Error: Error forwarded to listeners via onError');
  
  print('\nWhen Future completes:');
  print('- setImage() is called internally');
  print('- All registered listeners receive the image');
  print('- Late listeners immediately get the cached image');
}

void demonstrateScaleParameter() {
  print('\n=== Scale Parameter Demo ===');
  
  print('\nImageInfo scale property:');
  print('- Indicates device pixel ratio for the image');
  print('- 1.0 = standard density');
  print('- 2.0 = @2x retina/high-DPI');
  print('- 3.0 = @3x extra-high density');
  
  print('\nScale affects rendering:');
  print('- Logical size = physical size / scale');
  print('- 200x200 image at 2.0 scale = 100x100 logical');
  print('- Ensures crisp display on high-DPI screens');
  
  print('\nCommon scale values:');
  print('- 1.0: MDPI Android, standard desktop');
  print('- 1.5: HDPI Android');
  print('- 2.0: @2x iOS, XHDPI Android');
  print('- 3.0: @3x iOS, XXHDPI Android');
  print('- 4.0: XXXHDPI Android');
  
  print('\nSetting scale in ImageInfo:');
  print('ImageInfo(');
  print('  image: decodedImage,');
  print('  scale: 2.0,');
  print(')');
}

void demonstrateDebugLabel() {
  print('\n=== Debug Label Demo ===');
  
  print('\nPurpose of debugLabel:');
  print('- Identifies images in debug output');
  print('- Appears in flutter inspector');
  print('- Helps trace image loading issues');
  print('- Optional but recommended for debugging');
  
  print('\nSetting debugLabel:');
  print('ImageInfo(');
  print('  image: decodedImage,');
  print('  debugLabel: "profile_avatar"');
  print(')');
  
  print('\nEffective labeling patterns:');
  print('- Include source: "network:example.com/img.png"');
  print('- Include asset path: "asset:images/logo.png"');
  print('- Include context: "user_123_avatar"');
  print('- Include size: "thumbnail_64x64"');
  
  print('\nWhere debugLabel appears:');
  print('- ImageStreamCompleter.debugLabel property');
  print('- DevTools image list');
  print('- Memory profiler');
  print('- Error messages');
}

void demonstrateSingleVsMultiFrameComparison() {
  print('\n=== Single Frame vs Multi-Frame Comparison ===');
  
  print('\nOneFrameImageStreamCompleter:');
  print('- For static images (JPEG, PNG, BMP, WebP static)');
  print('- Single Future<ImageInfo>');
  print('- No animation support');
  print('- Simpler memory management');
  print('- Notifies listeners once');
  
  print('\nMultiFrameImageStreamCompleter:');
  print('- For animated images (GIF, APNG, WebP animated)');
  print('- Uses ui.Codec for frame iteration');
  print('- Manages frame timing');
  print('- Continuous listener notification');
  print('- More complex lifecycle');
  
  print('\nWhen to use OneFrame:');
  print('- JPEG photographs');
  print('- PNG icons and graphics');
  print('- BMP legacy images');
  print('- Static WebP images');
  print('- SVG rasterized outputs');
  
  print('\nWhen to use MultiFrame:');
  print('- Animated GIFs');
  print('- Animated PNGs (APNG)');
  print('- Animated WebP');
  print('- Image sequences');
}

void demonstrateErrorHandling() {
  print('\n=== Error Handling Demo ===');
  
  print('\nError scenarios:');
  print('1. Network failure during fetch');
  print('2. Invalid/corrupted image bytes');
  print('3. Unsupported image format');
  print('4. Memory allocation failure');
  print('5. Codec initialization error');
  
  print('\nError propagation:');
  print('- Future rejects with error');
  print('- OneFrameImageStreamCompleter catches it');
  print('- Calls reportError() internally');
  print('- Listeners onError callback invoked');
  
  print('\nHandling errors with InformationCollector:');
  print('OneFrameImageStreamCompleter(');
  print('  imageFuture,');
  print('  informationCollector: () => [');
  print('    StringProperty("url", imageUrl),');
  print('    IntProperty("retry", retryCount),');
  print('  ],');
  print(')');
  
  print('\nListening for errors:');
  print('stream.addListener(ImageStreamListener(');
  print('  (image, sync) => handleImage(image),');
  print('  onError: (error, stack) => handleError(error),');
  print('))');
  
  print('\nRecovery strategies:');
  print('- Retry with exponential backoff');
  print('- Fall back to placeholder image');
  print('- Show error widget');
  print('- Log to error reporting service');
}

Widget buildConstructorSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('OneFrameImageStreamCompleter Constructor'),
      buildInfoCard(
        'Purpose',
        'Creates an image stream completer for single-frame static images',
      ),
      buildPropertyRow(
        'image',
        'Future<ImageInfo>',
        'The future that resolves to the decoded image data',
      ),
      buildPropertyRow(
        'collector',
        'InformationCollector?',
        'Optional callback for debug information collection',
      ),
      SizedBox(height: 12),
      buildCodeBlock(
        'OneFrameImageStreamCompleter(\n'
        '  loadImageBytes().then((bytes) {\n'
        '    return ui.instantiateImageCodec(bytes);\n'
        '  }).then((codec) {\n'
        '    return codec.getNextFrame();\n'
        '  }).then((frame) {\n'
        '    return ImageInfo(image: frame.image);\n'
        '  }),\n'
        ')',
      ),
      buildInfoCard(
        'Inheritance',
        'Extends ImageStreamCompleter abstract class',
      ),
      buildInfoCard(
        'Behavior',
        'Waits for Future to complete, then notifies all listeners',
      ),
    ],
  );
}

Widget buildImageFutureSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('Image Future Parameter'),
      buildInfoCard(
        'Type',
        'Future<ImageInfo> - async operation returning decoded image',
      ),
      buildInfoCard(
        'Resolution',
        'Future must resolve to valid ImageInfo with ui.Image',
      ),
      SizedBox(height: 8),
      Text(
        'Future Lifecycle States:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      buildLifecycleStep(
        1,
        'Future Created',
        'Image loading operation begins (network fetch, file read, etc.)',
      ),
      buildLifecycleStep(
        2,
        'Bytes Received',
        'Raw image bytes available for decoding',
      ),
      buildLifecycleStep(
        3,
        'Codec Created',
        'ui.instantiateImageCodec() processes bytes',
      ),
      buildLifecycleStep(
        4,
        'Frame Extracted',
        'codec.getNextFrame() gets the single frame',
      ),
      buildLifecycleStep(
        5,
        'ImageInfo Created',
        'Frame wrapped in ImageInfo with scale and label',
      ),
      buildLifecycleStep(
        6,
        'Listeners Notified',
        'All registered listeners receive the ImageInfo',
      ),
      SizedBox(height: 12),
      buildCodeBlock(
        'Future<ImageInfo> createImageFuture() async {\n'
        '  final response = await http.get(url);\n'
        '  final bytes = response.bodyBytes;\n'
        '  final codec = await ui.instantiateImageCodec(bytes);\n'
        '  final frame = await codec.getNextFrame();\n'
        '  return ImageInfo(\n'
        '    image: frame.image,\n'
        '    scale: devicePixelRatio,\n'
        '  );\n'
        '}',
      ),
    ],
  );
}

Widget buildScaleSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('Scale Parameter'),
      buildInfoCard(
        'Definition',
        'Device pixel ratio indicating image density',
      ),
      buildInfoCard(
        'Purpose',
        'Ensures images render at correct logical size on all screens',
      ),
      SizedBox(height: 12),
      Text(
        'Common Scale Values:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      buildScaleExampleCard(
        1.0,
        'Standard density - 100px physical = 100px logical',
      ),
      buildScaleExampleCard(
        1.5,
        'Medium-high density - 150px physical = 100px logical',
      ),
      buildScaleExampleCard(
        2.0,
        'High density (@2x/Retina) - 200px physical = 100px logical',
      ),
      buildScaleExampleCard(
        3.0,
        'Extra-high density (@3x) - 300px physical = 100px logical',
      ),
      buildScaleExampleCard(
        4.0,
        'Ultra-high density - 400px physical = 100px logical',
      ),
      SizedBox(height: 12),
      buildCodeBlock(
        'ImageInfo(\n'
        '  image: decodedFrame.image,\n'
        '  scale: MediaQuery.of(context).devicePixelRatio,\n'
        '  debugLabel: "adaptive_image",\n'
        ')',
      ),
      buildInfoCard(
        'Asset Resolution',
        'Flutter auto-selects 1x, 2x, 3x assets based on screen density',
      ),
    ],
  );
}

Widget buildDebugLabelSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('Debug Label'),
      buildInfoCard(
        'Purpose',
        'Identifies images in DevTools and error messages',
      ),
      buildInfoCard(
        'Type',
        'String? - optional identifier string',
      ),
      SizedBox(height: 12),
      Text(
        'Effective Label Patterns:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      buildDebugLabelCard(
        'network:api.example.com/user/123/avatar.png',
        'Network image with full URL for tracing',
      ),
      buildDebugLabelCard(
        'asset:assets/images/logo@2x.png',
        'Asset image with resolution variant',
      ),
      buildDebugLabelCard(
        'memory:generated_thumbnail_64x64',
        'Dynamically generated in-memory image',
      ),
      buildDebugLabelCard(
        'file:/data/user/cache/img_001.jpg',
        'Cached file from local storage',
      ),
      buildDebugLabelCard(
        'blob:camera_capture_20240315_143022',
        'Camera or generated image with timestamp',
      ),
      SizedBox(height: 12),
      buildCodeBlock(
        'ImageInfo(\n'
        '  image: frame.image,\n'
        '  debugLabel: "network:\${url.host}\${url.path}",\n'
        ')',
      ),
      buildInfoCard(
        'Visibility',
        'Appears in Flutter DevTools image inspector and error traces',
      ),
    ],
  );
}

Widget buildComparisonSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('Single Frame vs Multi-Frame Comparison'),
      buildComparisonCard(
        'Constructor Parameter',
        'Future<ImageInfo>',
        'ui.Codec',
      ),
      buildComparisonCard(
        'Frame Count',
        'Exactly one frame',
        'One or more frames',
      ),
      buildComparisonCard(
        'Animation Support',
        'No animation',
        'Full animation with timing',
      ),
      buildComparisonCard(
        'Listener Notification',
        'Once on completion',
        'Per frame during playback',
      ),
      buildComparisonCard(
        'Memory Management',
        'Simple - single image',
        'Complex - frame disposal',
      ),
      buildComparisonCard(
        'Timing Control',
        'None needed',
        'Frame duration handling',
      ),
      SizedBox(height: 16),
      Text(
        'Supported Formats - OneFrame:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      Wrap(
        children: [
          buildImageFormatCard('JPEG', '.jpg/.jpeg', true),
          buildImageFormatCard('PNG', '.png', true),
          buildImageFormatCard('WebP', '.webp (static)', true),
          buildImageFormatCard('BMP', '.bmp', true),
          buildImageFormatCard('WBMP', '.wbmp', true),
          buildImageFormatCard('ICO', '.ico', true),
        ],
      ),
      SizedBox(height: 16),
      Text(
        'MultiFrame Required:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      Wrap(
        children: [
          buildImageFormatCard('GIF', '.gif (animated)', false),
          buildImageFormatCard('APNG', '.png (animated)', false),
          buildImageFormatCard('WebP', '.webp (animated)', false),
        ],
      ),
      SizedBox(height: 12),
      Text(
        'OneFrame Features:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      buildFeatureCard('Simple async image loading', true),
      buildFeatureCard('Scale/DPI support', true),
      buildFeatureCard('Debug labeling', true),
      buildFeatureCard('Error handling', true),
      buildFeatureCard('Late listener support', true),
      buildFeatureCard('Animation playback', false),
      buildFeatureCard('Frame iteration', false),
      buildFeatureCard('Duration timing', false),
    ],
  );
}

Widget buildErrorHandlingSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('Error Handling'),
      buildInfoCard(
        'Error Source',
        'Future rejection propagates to completer error handling',
      ),
      SizedBox(height: 12),
      Text(
        'Common Error Scenarios:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      buildErrorCard(
        'NetworkImageLoadException',
        'HTTP error status (404, 500, timeout)',
        'Check connectivity, retry with backoff, show placeholder',
      ),
      buildErrorCard(
        'ImageCodecException',
        'Invalid or corrupted image bytes',
        'Validate source, try alternate format, report to server',
      ),
      buildErrorCard(
        'OutOfMemoryError',
        'Image too large for available memory',
        'Resize before decoding, limit max dimensions',
      ),
      buildErrorCard(
        'FormatException',
        'Unsupported or unknown image format',
        'Check file extension, validate MIME type, use fallback',
      ),
      buildErrorCard(
        'FileSystemException',
        'Cannot read local file (permissions, not found)',
        'Check permissions, verify path, handle missing gracefully',
      ),
      SizedBox(height: 12),
      buildCodeBlock(
        'stream.addListener(ImageStreamListener(\n'
        '  (info, synchronousCall) {\n'
        '    setState(() => _image = info.image);\n'
        '  },\n'
        '  onError: (error, stackTrace) {\n'
        '    print("Image load failed: \$error");\n'
        '    setState(() => _hasError = true);\n'
        '  },\n'
        '));',
      ),
      SizedBox(height: 12),
      buildInfoCard(
        'InformationCollector',
        'Provides context in error reports (URL, retry count, etc.)',
      ),
      buildCodeBlock(
        'OneFrameImageStreamCompleter(\n'
        '  imageFuture,\n'
        '  informationCollector: () => [\n'
        '    StringProperty("source", imageUrl),\n'
        '    IntProperty("attempt", attemptNumber),\n'
        '    DiagnosticsProperty("context", buildContext),\n'
        '  ],\n'
        ')',
      ),
    ],
  );
}

Widget buildUsageExamplesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('Usage Examples'),
      buildInfoCard(
        'Custom ImageProvider',
        'Implementing load() to return OneFrameImageStreamCompleter',
      ),
      buildCodeBlock(
        'class MyImageProvider extends ImageProvider<MyImageKey> {\n'
        '  ImageStreamCompleter loadImage(\n'
        '    MyImageKey key,\n'
        '    ImageDecoderCallback decode,\n'
        '  ) {\n'
        '    return OneFrameImageStreamCompleter(\n'
        '      _loadAsync(key, decode),\n'
        '    );\n'
        '  }\n'
        '\n'
        '  Future<ImageInfo> _loadAsync(\n'
        '    MyImageKey key,\n'
        '    ImageDecoderCallback decode,\n'
        '  ) async {\n'
        '    final bytes = await fetchBytes(key.url);\n'
        '    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);\n'
        '    final codec = await decode(buffer);\n'
        '    final frame = await codec.getNextFrame();\n'
        '    return ImageInfo(\n'
        '      image: frame.image,\n'
        '      scale: key.scale,\n'
        '      debugLabel: key.url,\n'
        '    );\n'
        '  }\n'
        '}',
      ),
      SizedBox(height: 12),
      buildInfoCard(
        'Direct Usage',
        'Creating completer manually for custom scenarios',
      ),
      buildCodeBlock(
        'final completer = OneFrameImageStreamCompleter(\n'
        '  generateThumbnail(originalImage, Size(64, 64)),\n'
        ');\n'
        '\n'
        'final stream = ImageStream();\n'
        'stream.setCompleter(completer);\n'
        '\n'
        'stream.addListener(ImageStreamListener(\n'
        '  (info, sync) => handleThumbnail(info),\n'
        '  onError: (e, s) => handleError(e),\n'
        '));',
      ),
    ],
  );
}

Widget buildBestPracticesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('Best Practices'),
      buildInfoCard(
        'Always Set Scale',
        'Match scale to device pixel ratio for crisp rendering',
      ),
      buildInfoCard(
        'Use Debug Labels',
        'Include source info in debugLabel for easier debugging',
      ),
      buildInfoCard(
        'Handle Errors',
        'Always provide onError callback to ImageStreamListener',
      ),
      buildInfoCard(
        'Dispose Images',
        'Call image.dispose() when no longer needed to free memory',
      ),
      buildInfoCard(
        'Provide Context',
        'Use InformationCollector for richer error diagnostics',
      ),
      SizedBox(height: 12),
      Text(
        'Memory Management Tips:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      buildFeatureCard('Cache decoded images appropriately', true),
      buildFeatureCard('Dispose images when widgets unmount', true),
      buildFeatureCard('Use ImageCache size limits', true),
      buildFeatureCard('Consider resize before decode for large images', true),
      buildFeatureCard('Avoid keeping references to disposed images', true),
    ],
  );
}

dynamic build(BuildContext context) {
  print('=== OneFrameImageStreamCompleter Deep Demo ===');
  print('Testing static image loading completer');
  
  demonstrateOneFrameImageStreamCompleterConstructor();
  demonstrateImageFutureParameter();
  demonstrateScaleParameter();
  demonstrateDebugLabel();
  demonstrateSingleVsMultiFrameComparison();
  demonstrateErrorHandling();
  
  print('\n=== Creating Visual Demo ===');
  
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade600, Colors.teal.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.image, color: Colors.white, size: 48),
              SizedBox(height: 12),
              Text(
                'OneFrameImageStreamCompleter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Static Image Loading for Flutter',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'painting library',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        buildConstructorSection(),
        buildImageFutureSection(),
        buildScaleSection(),
        buildDebugLabelSection(),
        buildComparisonSection(),
        buildErrorHandlingSection(),
        buildUsageExamplesSection(),
        buildBestPracticesSection(),
        SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Text(
                'Demo Complete',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'OneFrameImageStreamCompleter handles single-frame static images with simple async loading, scale support, and comprehensive error handling.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
      ],
    ),
  );
}
