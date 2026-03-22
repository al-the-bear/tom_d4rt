// D4rt test script: Tests DecorationImagePainter from painting
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
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

Widget buildDecorationImageDemo(
  String label,
  DecorationImage decorationImage,
  double width,
  double height,
) {
  print('Building decoration image demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Center(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: decorationImage,
              border: Border.all(color: Colors.grey.shade400, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBoxFitDemo(String fitName, BoxFit fit, ImageProvider image) {
  print('Building BoxFit demo: $fitName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            image: DecorationImage(
              image: image,
              fit: fit,
            ),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BoxFit.$fitName',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                _getBoxFitDescription(fit),
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _getBoxFitDescription(BoxFit fit) {
  switch (fit) {
    case BoxFit.fill:
      return 'Stretches to fill the entire box';
    case BoxFit.contain:
      return 'Fits within the box, maintains aspect ratio';
    case BoxFit.cover:
      return 'Covers the entire box, may crop';
    case BoxFit.fitWidth:
      return 'Fits the width, may overflow height';
    case BoxFit.fitHeight:
      return 'Fits the height, may overflow width';
    case BoxFit.none:
      return 'No scaling, centered at original size';
    case BoxFit.scaleDown:
      return 'Scales down if larger, no scale up';
  }
}

Widget buildImageRepeatDemo(String repeatName, ImageRepeat repeat, ImageProvider image) {
  print('Building ImageRepeat demo: $repeatName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: image,
              repeat: repeat,
              scale: 4.0,
            ),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ImageRepeat.$repeatName',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                _getImageRepeatDescription(repeat),
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _getImageRepeatDescription(ImageRepeat repeat) {
  switch (repeat) {
    case ImageRepeat.noRepeat:
      return 'Image is not repeated';
    case ImageRepeat.repeat:
      return 'Repeats horizontally and vertically';
    case ImageRepeat.repeatX:
      return 'Repeats only horizontally';
    case ImageRepeat.repeatY:
      return 'Repeats only vertically';
  }
}

Widget buildAlignmentDemo(String alignName, Alignment alignment, ImageProvider image) {
  print('Building Alignment demo: $alignName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    child: Column(
      children: [
        Container(
          width: 70,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            image: DecorationImage(
              image: image,
              fit: BoxFit.none,
              alignment: alignment,
            ),
            border: Border.all(color: Colors.orange.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 4),
        Text(
          alignName,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget buildColorFilterDemo(String filterName, ColorFilter filter, ImageProvider image) {
  print('Building ColorFilter demo: $filterName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
              colorFilter: filter,
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            filterName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

Widget buildOpacityDemo(double opacity, ImageProvider image) {
  print('Building Opacity demo: $opacity');
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      children: [
        Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
              opacity: opacity,
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        SizedBox(height: 4),
        Text(
          '${(opacity * 100).toInt()}%',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget buildFilterQualityDemo(String qualityName, FilterQuality quality, ImageProvider image) {
  print('Building FilterQuality demo: $qualityName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
              filterQuality: quality,
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FilterQuality.$qualityName',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                _getFilterQualityDescription(quality),
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _getFilterQualityDescription(FilterQuality quality) {
  switch (quality) {
    case FilterQuality.none:
      return 'Fastest, lowest quality (nearest neighbor)';
    case FilterQuality.low:
      return 'Low quality, faster rendering';
    case FilterQuality.medium:
      return 'Balanced quality and performance';
    case FilterQuality.high:
      return 'Highest quality, slowest rendering';
  }
}

Widget buildScaleDemo(double scale, ImageProvider image) {
  print('Building Scale demo: $scale');
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 6),
    child: Column(
      children: [
        Container(
          width: 70,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            image: DecorationImage(
              image: image,
              scale: scale,
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        SizedBox(height: 4),
        Text(
          '${scale}x',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DecorationImagePainter deep demo executing');
  print('=' * 60);

  ImageProvider demoImage = NetworkImage(
    'https://via.placeholder.com/150/6366F1/FFFFFF?text=IMG',
  );

  print('\n--- DecorationImage Basics ---');
  print('DecorationImage defines how an image is painted within a BoxDecoration');
  print('DecorationImagePainter is the internal painter class');
  print('Created internally by BoxDecoration when image is provided');

  print('\n--- BoxFit Options ---');
  for (var fit in BoxFit.values) {
    print('BoxFit.${fit.name}: ${_getBoxFitDescription(fit)}');
  }

  print('\n--- ImageRepeat Options ---');
  for (var repeat in ImageRepeat.values) {
    print('ImageRepeat.${repeat.name}: ${_getImageRepeatDescription(repeat)}');
  }

  print('\n--- Alignment Options ---');
  print('Alignment.topLeft: (-1.0, -1.0)');
  print('Alignment.topCenter: (0.0, -1.0)');
  print('Alignment.topRight: (1.0, -1.0)');
  print('Alignment.centerLeft: (-1.0, 0.0)');
  print('Alignment.center: (0.0, 0.0)');
  print('Alignment.centerRight: (1.0, 0.0)');
  print('Alignment.bottomLeft: (-1.0, 1.0)');
  print('Alignment.bottomCenter: (0.0, 1.0)');
  print('Alignment.bottomRight: (1.0, 1.0)');

  print('\n--- ColorFilter Options ---');
  print('ColorFilter.mode: Applies blend mode with color');
  print('ColorFilter.matrix: Applies color transformation matrix');
  print('ColorFilter.linearToSrgbGamma: Linear to sRGB gamma');
  print('ColorFilter.srgbToLinearGamma: sRGB to linear gamma');

  print('\n--- Opacity ---');
  print('opacity: 0.0 = fully transparent');
  print('opacity: 0.5 = half transparent');
  print('opacity: 1.0 = fully opaque (default)');

  print('\n--- FilterQuality Options ---');
  for (var quality in FilterQuality.values) {
    print('FilterQuality.${quality.name}: ${_getFilterQualityDescription(quality)}');
  }

  print('\n--- Scale ---');
  print('scale: 1.0 = original size');
  print('scale: 2.0 = half size (2x density)');
  print('scale: 0.5 = double size');

  print('\nDecorationImagePainter deep demo completed');
  print('=' * 60);

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade600, Colors.indigo.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'DecorationImagePainter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Paints a DecorationImage into a canvas rect',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        buildSectionHeader('DecorationImage Basics'),
        buildInfoCard('Purpose', 'Defines how an image is painted in BoxDecoration'),
        buildInfoCard('Painter', 'DecorationImagePainter handles the actual painting'),
        buildInfoCard('Created by', 'BoxDecoration internally when image is set'),
        buildInfoCard('Key Props', 'image, fit, alignment, repeat, colorFilter, opacity'),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Basic Usage:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                'Container(\n'
                '  decoration: BoxDecoration(\n'
                '    image: DecorationImage(\n'
                '      image: NetworkImage(url),\n'
                '      fit: BoxFit.cover,\n'
                '    ),\n'
                '  ),\n'
                ')',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),

        buildSectionHeader('BoxFit Options'),
        buildInfoCard('Total Values', '${BoxFit.values.length} fit modes'),

        buildBoxFitDemo('fill', BoxFit.fill, demoImage),
        buildBoxFitDemo('contain', BoxFit.contain, demoImage),
        buildBoxFitDemo('cover', BoxFit.cover, demoImage),
        buildBoxFitDemo('fitWidth', BoxFit.fitWidth, demoImage),
        buildBoxFitDemo('fitHeight', BoxFit.fitHeight, demoImage),
        buildBoxFitDemo('none', BoxFit.none, demoImage),
        buildBoxFitDemo('scaleDown', BoxFit.scaleDown, demoImage),

        buildSectionHeader('ImageRepeat Options'),
        buildInfoCard('Total Values', '${ImageRepeat.values.length} repeat modes'),

        buildImageRepeatDemo('noRepeat', ImageRepeat.noRepeat, demoImage),
        buildImageRepeatDemo('repeat', ImageRepeat.repeat, demoImage),
        buildImageRepeatDemo('repeatX', ImageRepeat.repeatX, demoImage),
        buildImageRepeatDemo('repeatY', ImageRepeat.repeatY, demoImage),

        buildSectionHeader('Alignment'),
        buildInfoCard('Type', 'AlignmentGeometry (typically Alignment)'),
        buildInfoCard('Range', 'x: -1.0 to 1.0, y: -1.0 to 1.0'),
        buildInfoCard('Default', 'Alignment.center'),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              buildAlignmentDemo('topLeft', Alignment.topLeft, demoImage),
              buildAlignmentDemo('topCenter', Alignment.topCenter, demoImage),
              buildAlignmentDemo('topRight', Alignment.topRight, demoImage),
              buildAlignmentDemo('centerLeft', Alignment.centerLeft, demoImage),
              buildAlignmentDemo('center', Alignment.center, demoImage),
              buildAlignmentDemo('centerRight', Alignment.centerRight, demoImage),
              buildAlignmentDemo('bottomLeft', Alignment.bottomLeft, demoImage),
              buildAlignmentDemo('bottomCenter', Alignment.bottomCenter, demoImage),
              buildAlignmentDemo('bottomRight', Alignment.bottomRight, demoImage),
            ],
          ),
        ),

        buildSectionHeader('ColorFilter'),
        buildInfoCard('Type', 'ColorFilter'),
        buildInfoCard('Purpose', 'Applies color transformations to the image'),
        buildInfoCard('Default', 'null (no filter)'),

        buildColorFilterDemo(
          'Grayscale (saturation mode)',
          ColorFilter.mode(Colors.grey, BlendMode.saturation),
          demoImage,
        ),
        buildColorFilterDemo(
          'Sepia tint (color mode)',
          ColorFilter.mode(Colors.brown.withAlpha(128), BlendMode.color),
          demoImage,
        ),
        buildColorFilterDemo(
          'Blue overlay (colorBurn)',
          ColorFilter.mode(Colors.blue.withAlpha(100), BlendMode.colorBurn),
          demoImage,
        ),
        buildColorFilterDemo(
          'Red tint (multiply)',
          ColorFilter.mode(Colors.red.withAlpha(150), BlendMode.multiply),
          demoImage,
        ),
        buildColorFilterDemo(
          'Lighten with yellow',
          ColorFilter.mode(Colors.yellow.withAlpha(100), BlendMode.lighten),
          demoImage,
        ),
        buildColorFilterDemo(
          'Darken with black',
          ColorFilter.mode(Colors.black.withAlpha(80), BlendMode.darken),
          demoImage,
        ),

        buildSectionHeader('Opacity'),
        buildInfoCard('Type', 'double'),
        buildInfoCard('Range', '0.0 (transparent) to 1.0 (opaque)'),
        buildInfoCard('Default', '1.0'),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOpacityDemo(0.0, demoImage),
              buildOpacityDemo(0.25, demoImage),
              buildOpacityDemo(0.5, demoImage),
              buildOpacityDemo(0.75, demoImage),
              buildOpacityDemo(1.0, demoImage),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Opacity vs ColorFilter Alpha:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                'opacity property: Direct transparency control\n'
                'ColorFilter alpha: Part of color transformation\n\n'
                'Use opacity for simple fade effects.\n'
                'Use ColorFilter for color adjustments with transparency.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),

        buildSectionHeader('FilterQuality'),
        buildInfoCard('Type', 'FilterQuality'),
        buildInfoCard('Purpose', 'Controls image sampling quality when scaling'),
        buildInfoCard('Default', 'FilterQuality.low'),

        buildFilterQualityDemo('none', FilterQuality.none, demoImage),
        buildFilterQualityDemo('low', FilterQuality.low, demoImage),
        buildFilterQualityDemo('medium', FilterQuality.medium, demoImage),
        buildFilterQualityDemo('high', FilterQuality.high, demoImage),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Performance Tips:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                'FilterQuality.none: Best for pixel art, icons\n'
                'FilterQuality.low: Good for most cases\n'
                'FilterQuality.medium: Balanced\n'
                'FilterQuality.high: Photos, detailed images\n\n'
                'Higher quality = slower rendering',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),

        buildSectionHeader('Scale'),
        buildInfoCard('Type', 'double'),
        buildInfoCard('Purpose', 'Adjusts image density/size'),
        buildInfoCard('Default', '1.0'),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildScaleDemo(0.5, demoImage),
              buildScaleDemo(1.0, demoImage),
              buildScaleDemo(1.5, demoImage),
              buildScaleDemo(2.0, demoImage),
              buildScaleDemo(3.0, demoImage),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scale Values:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '0.5x: Image appears larger (half density)\n'
                '1.0x: Original size\n'
                '2.0x: Image appears smaller (double density)\n'
                '3.0x: For high-DPI screens\n\n'
                'Higher scale = smaller rendered image',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),

        buildSectionHeader('Combined Examples'),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Card Style',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: demoImage,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withAlpha(77),
                      BlendMode.darken,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Cover + Darken Filter',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tiled Background',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: demoImage,
                    repeat: ImageRepeat.repeat,
                    scale: 6.0,
                    opacity: 0.3,
                  ),
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Centered with Contain',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  image: DecorationImage(
                    image: demoImage,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hero Image with Gradient Overlay',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: demoImage,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(179),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'High Quality + Gradient',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        buildSectionHeader('Summary'),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DecorationImagePainter Key Points:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              _buildSummaryItem('Internal painter for DecorationImage'),
              _buildSummaryItem('Created by BoxDecoration automatically'),
              _buildSummaryItem('Supports 7 BoxFit modes for sizing'),
              _buildSummaryItem('4 ImageRepeat modes for tiling'),
              _buildSummaryItem('9 standard Alignment positions'),
              _buildSummaryItem('ColorFilter for color transformations'),
              _buildSummaryItem('Opacity for transparency (0.0 - 1.0)'),
              _buildSummaryItem('4 FilterQuality levels'),
              _buildSummaryItem('Scale for image density control'),
            ],
          ),
        ),

        SizedBox(height: 32),
      ],
    ),
  );
}

Widget _buildSummaryItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.deepPurple, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
