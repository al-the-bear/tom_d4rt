// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawImage
// Demonstrates RawImage: the low-level image rendering widget that
// paints dart:ui Image objects directly. Exposes all rendering controls:
// fit, alignment, repeat, filter quality, color blending, scale, etc.
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('RawImage Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawImage Is — Concept
  // ============================================================
  print('=== Section 1: RawImage Concept ===');

  // RawImage is the lowest-level image widget in Flutter.
  // It renders a dart:ui Image directly onto the canvas.
  //
  // The widget hierarchy:
  //   NetworkImage / AssetImage / FileImage (providers)
  //       ↓ resolves to
  //   ImageStream → ImageInfo → dart:ui Image
  //       ↓ displayed by
  //   Image widget (convenience)
  //       ↓ uses internally
  //   RawImage (low-level rendering)
  //       ↓ uses internally
  //   RenderImage (render object)
  //
  // Why use RawImage directly?
  //   - Already have a dart:ui Image from Canvas, codec, etc.
  //   - Need maximum rendering control
  //   - Building custom image widgets
  //   - Applying color blend modes for image effects
  //   - Custom image caching without ImageProvider

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.image, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawImage',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Direct dart:ui Image rendering',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The lowest-level image widget in Flutter',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'RawImage takes a dart:ui Image and renders it directly. '
                'Unlike Image (the widget), it does not resolve image providers, '
                'load from network, or decode bytes. It simply paints a '
                'pre-existing bitmap with full control over fit, alignment, '
                'repeat, color blending, and filter quality.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildConceptTag('dart:ui Image', Icons.code),
            _buildConceptTag('Direct Canvas', Icons.brush),
            _buildConceptTag('Full Control', Icons.tune),
          ],
        ),
      ],
    ),
  );

  print('  conceptCard built');

  // ============================================================
  // SECTION 2: Image Widget Hierarchy
  // ============================================================
  print('=== Section 2: Widget Hierarchy ===');

  // Visual diagram showing how Flutter's image widgets relate.

  final hierarchySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2: Image Widget Hierarchy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How Flutter image types relate from top to bottom.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        // Layer diagram
        _buildHierarchyLayer(
          'ImageProvider',
          'AssetImage, NetworkImage, FileImage, MemoryImage',
          'Loads and decodes image data',
          Colors.purple,
          isTop: true,
        ),
        _buildHierarchyConnector(),
        _buildHierarchyLayer(
          'ImageStream / ImageInfo',
          'Stream of image frames with metadata',
          'Contains dart:ui Image + scale',
          Colors.indigo,
          isTop: false,
        ),
        _buildHierarchyConnector(),
        _buildHierarchyLayer(
          'Image (widget)',
          'Convenience widget with named constructors',
          'Image.asset(), Image.network(), Image.file()',
          Colors.blue,
          isTop: false,
        ),
        _buildHierarchyConnector(),
        _buildHierarchyLayer(
          'RawImage',
          'Low-level widget — takes dart:ui Image directly',
          'Full control: fit, alignment, repeat, color, filter',
          Colors.teal,
          isTop: false,
        ),
        _buildHierarchyConnector(),
        _buildHierarchyLayer(
          'RenderImage',
          'RenderObject that paints the image',
          'Canvas.drawImageRect with all parameters',
          Colors.green,
          isTop: false,
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.amber.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Image (widget) calls ImageProvider → ImageStream → '
                  'ImageInfo, then passes the dart:ui Image to RawImage. '
                  'If you already have a dart:ui Image, skip straight '
                  'to RawImage.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blueGrey.shade700,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  hierarchySection built');

  // ============================================================
  // SECTION 3: BoxFit Modes Visualized
  // ============================================================
  print('=== Section 3: BoxFit Modes ===');

  final fitSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3: BoxFit Modes',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How the fit property controls image scaling within its bounds.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // 2x3 grid of fit modes
        Row(
          children: [
            Expanded(
              child: _buildFitDemo(
                'BoxFit.fill',
                'Stretches to fill completely',
                Colors.red.shade400,
                1.5,
                1.0,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildFitDemo(
                'BoxFit.contain',
                'Fits inside — may letterbox',
                Colors.blue.shade400,
                0.8,
                1.0,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildFitDemo(
                'BoxFit.cover',
                'Fills and clips overflow',
                Colors.green.shade400,
                1.2,
                1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: _buildFitDemo(
                'BoxFit.fitWidth',
                'Scales to match width',
                Colors.purple.shade400,
                1.0,
                0.7,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildFitDemo(
                'BoxFit.fitHeight',
                'Scales to match height',
                Colors.teal.shade400,
                0.7,
                1.0,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildFitDemo(
                'BoxFit.none',
                'No scaling — original size',
                Colors.brown.shade400,
                1.0,
                1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildFitDemo(
                'BoxFit.scaleDown',
                'Shrink only — never upscale',
                Colors.indigo.shade400,
                0.6,
                0.6,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'RawImage uses fit to control how the dart:ui Image '
                  'is painted within the constraints. This is the same '
                  'BoxFit used by Image, FittedBox, and DecorationImage.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.orange.shade800,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('  fitSection built with 7 BoxFit modes');

  // ============================================================
  // SECTION 4: Alignment Options
  // ============================================================
  print('=== Section 4: Alignment ===');

  final alignmentSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4: Alignment',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Where within the bounds the image is positioned.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // 3x3 alignment grid
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildAlignmentCell(
                        'topLeft', Alignment.topLeft, true),
                  ),
                  Expanded(
                    child: _buildAlignmentCell(
                        'topCenter', Alignment.topCenter, false),
                  ),
                  Expanded(
                    child: _buildAlignmentCell(
                        'topRight', Alignment.topRight, false),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildAlignmentCell(
                        'centerLeft', Alignment.centerLeft, false),
                  ),
                  Expanded(
                    child: _buildAlignmentCell(
                        'center', Alignment.center, true),
                  ),
                  Expanded(
                    child: _buildAlignmentCell(
                        'centerRight', Alignment.centerRight, false),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildAlignmentCell(
                        'bottomLeft', Alignment.bottomLeft, false),
                  ),
                  Expanded(
                    child: _buildAlignmentCell(
                        'bottomCenter', Alignment.bottomCenter, false),
                  ),
                  Expanded(
                    child: _buildAlignmentCell(
                        'bottomRight', Alignment.bottomRight, true),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'The alignment property positions the image within the '
            'RawImage bounds when the image does not fill the entire box '
            '(e.g., with BoxFit.contain). Default is Alignment.center. '
            'Fractional Alignment values (e.g., Alignment(0.3, -0.5)) '
            'are also supported.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.green.shade800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  alignmentSection built with 9-cell grid');

  // ============================================================
  // SECTION 5: ImageRepeat Modes
  // ============================================================
  print('=== Section 5: Image Repeat ===');

  final repeatSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5: ImageRepeat Modes',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How images tile when smaller than their container.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        Row(
          children: [
            Expanded(
              child: _buildRepeatDemo(
                'noRepeat',
                'Single instance only',
                Colors.blue,
                1,
                1,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildRepeatDemo(
                'repeat',
                'Tile both X and Y',
                Colors.green,
                3,
                3,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: _buildRepeatDemo(
                'repeatX',
                'Tile horizontally only',
                Colors.orange,
                3,
                1,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildRepeatDemo(
                'repeatY',
                'Tile vertically only',
                Colors.red,
                1,
                3,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'The repeat property is useful for pattern backgrounds and '
            'texture fills. Default is ImageRepeat.noRepeat. When the '
            'image is larger than the container, repeat has no visual '
            'effect since there is no remaining space to tile into.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.purple.shade800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  repeatSection built with 4 repeat modes');

  // ============================================================
  // SECTION 6: Color & BlendMode Effects
  // ============================================================
  print('=== Section 6: Color & BlendMode ===');

  final blendSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6: Color & BlendMode Effects',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Apply color tints and blend modes to the rendered image.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // How it works
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How color + colorBlendMode interact:',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade900,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '1. The image is painted normally\n'
                '2. The color is applied using the blend mode\n'
                '3. Result = blend(imagePixel, colorValue)',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.teal.shade700,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        // Blend mode examples
        Row(
          children: [
            Expanded(
              child: _buildBlendModeCard(
                'srcOver',
                'Color overlaid on image',
                Colors.blue,
                0.5,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBlendModeCard(
                'multiply',
                'Darken: color × image',
                Colors.red,
                0.7,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: _buildBlendModeCard(
                'screen',
                'Lighten: 1−(1−c)(1−i)',
                Colors.green,
                0.6,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBlendModeCard(
                'colorBurn',
                'Intense burn effect',
                Colors.orange,
                0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: _buildBlendModeCard(
                'saturation',
                'Apply color saturation only',
                Colors.purple,
                0.8,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBlendModeCard(
                'modulate',
                'Component-wise multiply',
                Colors.brown,
                0.6,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Without a color, colorBlendMode has no effect. The color '
            'parameter provides the tint, and colorBlendMode determines '
            'how that tint is composited with the image pixels. '
            'Common uses: image tinting, grayscale, sepia, color overlays.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.teal.shade800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  blendSection built with 6 blend modes');

  // ============================================================
  // SECTION 7: FilterQuality & Scale
  // ============================================================
  print('=== Section 7: FilterQuality & Scale ===');

  final filterSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7: FilterQuality & Scale',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 16.0),

        // FilterQuality levels
        Text(
          'FilterQuality Levels:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 12.0),

        _buildFilterQualityRow(
          'none',
          'Nearest neighbor — fast, pixelated at high zoom',
          Colors.red,
          1,
        ),
        SizedBox(height: 6.0),
        _buildFilterQualityRow(
          'low',
          'Bilinear — good balance of speed and quality',
          Colors.orange,
          2,
        ),
        SizedBox(height: 6.0),
        _buildFilterQualityRow(
          'medium',
          'Bilinear + mipmaps — better for downscaling',
          Colors.blue,
          3,
        ),
        SizedBox(height: 6.0),
        _buildFilterQualityRow(
          'high',
          'Bicubic — smoothest, most expensive',
          Colors.green,
          4,
        ),

        SizedBox(height: 20.0),

        // Scale property
        Text(
          'Scale Property:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 12.0),

        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The scale property describes the ratio of CSS pixels '
                'to image pixels. It comes from ImageInfo.scale.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.indigo.shade800,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12.0),

              Row(
                children: [
                  Expanded(
                    child: _buildScaleExample(
                      'scale: 1.0',
                      '1 pixel = 1 pixel',
                      '100×100 image → 100×100 CSS px',
                      Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _buildScaleExample(
                      'scale: 2.0',
                      '2 pixels = 1 CSS pixel',
                      '100×100 image → 50×50 CSS px',
                      Colors.green,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _buildScaleExample(
                      'scale: 3.0',
                      '3 pixels = 1 CSS pixel',
                      '100×100 image → 33×33 CSS px',
                      Colors.purple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Colors.amber.shade700, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Higher scale values make images appear smaller because '
                  'more image pixels map to each logical pixel. This is '
                  'how @2x and @3x retina assets work.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.amber.shade900,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  filterSection built');

  // ============================================================
  // SECTION 8: API Properties Reference
  // ============================================================
  print('=== Section 8: API Properties ===');

  final apiSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 8: API Properties',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 16.0),

        _buildApiCard(
          'image',
          'ui.Image?',
          'The dart:ui Image to display. If null, the widget paints '
          'nothing (transparent). This is the raw bitmap data.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'width / height',
          'double?',
          'Optional explicit dimensions. If not given, the widget sizes '
          'itself based on the image dimensions and scale.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'scale',
          'double',
          'Image pixel to logical pixel ratio. Default: 1.0. '
          'Higher values = smaller rendered size.',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'fit',
          'BoxFit?',
          'How the image is inscribed into the available space. '
          'Same as Image.fit. See BoxFit section above.',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'alignment',
          'Alignment',
          'Where the image is positioned within its bounds. '
          'Default: Alignment.center.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'repeat',
          'ImageRepeat',
          'How to tile the image if it does not fill the bounds. '
          'Default: ImageRepeat.noRepeat.',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'centerSlice',
          'Rect?',
          '9-patch center slice for nine-piece stretching. The center '
          'of the rectangle is stretched, edges are tiled, corners fixed.',
          Colors.brown,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'color',
          'Color?',
          'A color to blend with the image using colorBlendMode. '
          'Used for tinting, overlays, and color effects.',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'colorBlendMode',
          'BlendMode?',
          'How to blend color with the image pixels. '
          'Options: srcOver, multiply, screen, overlay, etc.',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'filterQuality',
          'FilterQuality',
          'Rendering quality for scaled images. Default: low. '
          'Options: none, low, medium, high.',
          Colors.amber,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'invertColors',
          'bool',
          'Whether to invert the image colors. Default: false. '
          'Useful for dark mode or accessibility.',
          Colors.grey,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'isAntiAlias',
          'bool',
          'Whether to apply anti-aliasing to the image edges. '
          'Default: false. Smoother edges when true.',
          Colors.lime,
        ),
        SizedBox(height: 8.0),
        _buildApiCard(
          'matchTextDirection',
          'bool',
          'Whether to flip the image in RTL layouts. Default: false. '
          'Useful for directional icons and arrows.',
          Colors.cyan,
        ),
      ],
    ),
  );

  print('  apiSection built with 13 properties');

  // ============================================================
  // SECTION 9: Live RawImage with dart:ui Image
  // ============================================================
  print('=== Section 9: Live RawImage ===');

  // Create a real dart:ui Image using a PictureRecorder
  // and then display it with RawImage.

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  // Draw a gradient circle pattern
  final centerX = 100.0;
  final centerY = 100.0;

  // Background
  canvas.drawRect(
    Rect.fromLTWH(0.0, 0.0, 200.0, 200.0),
    Paint()..color = Color(0xFF1A237E),
  );

  // Concentric rings
  for (var i = 5; i > 0; i--) {
    final radius = i * 18.0;
    final hue = (i * 60.0) % 360.0;
    final ringPaint = Paint()
      ..color = HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;
    canvas.drawCircle(Offset(centerX, centerY), radius, ringPaint);
  }

  // Center dot
  canvas.drawCircle(
    Offset(centerX, centerY),
    10.0,
    Paint()..color = Colors.white,
  );

  // Small decorative dots in corners
  final dotPaint = Paint()..color = Colors.yellowAccent;
  canvas.drawCircle(Offset(30.0, 30.0), 5.0, dotPaint);
  canvas.drawCircle(Offset(170.0, 30.0), 5.0, dotPaint);
  canvas.drawCircle(Offset(30.0, 170.0), 5.0, dotPaint);
  canvas.drawCircle(Offset(170.0, 170.0), 5.0, dotPaint);

  final picture = recorder.endRecording();
  final uiImage = picture.toImageSync(200, 200);

  final liveSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 9: Live RawImage',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A real dart:ui Image created with Canvas and displayed by RawImage.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // The actual RawImage
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withValues(alpha: 0.2),
                  blurRadius: 8.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: RawImage(
                image: uiImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How this image was created:',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.cyanAccent,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'final recorder = ui.PictureRecorder();\n'
                'final canvas = Canvas(recorder);\n'
                '// ... draw shapes ...\n'
                'final picture = recorder.endRecording();\n'
                'final uiImage = picture.toImageSync(200, 200);\n'
                '\n'
                'RawImage(\n'
                '  image: uiImage,\n'
                '  width: 200.0,\n'
                '  height: 200.0,\n'
                '  fit: BoxFit.contain,\n'
                '  filterQuality: FilterQuality.high,\n'
                ')',
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: Colors.white.withValues(alpha: 0.85),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.0),

        // Multiple RawImages with different settings
        Text(
          'Same dart:ui Image with different RawImage settings:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 12.0),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: RawImage(
                      image: uiImage,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('fill + none',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: RawImage(
                      image: uiImage,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      color: Colors.blue,
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('blue modulate',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: RawImage(
                      image: uiImage,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                      invertColors: true,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('invertColors',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: RawImage(
                      image: uiImage,
                      width: 80.0,
                      height: 80.0,
                      scale: 2.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('scale: 2.0',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('  liveSection built with live dart:ui Image');

  // ============================================================
  // SECTION 10: RawImage vs Image Comparison
  // ============================================================
  print('=== Section 10: Comparison ===');

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 10: RawImage vs Image',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Image wraps RawImage with ImageProvider integration.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Comparison header
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Feature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.pink.shade900,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text('RawImage',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.deepOrange.shade700,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text('Image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildVsRow('Input', 'dart:ui Image', 'ImageProvider'),
        _buildVsRow('Loading',
            'None — image must exist', 'Built-in load + decode'),
        _buildVsRow('Caching',
            'None — manual', 'ImageCache integration'),
        _buildVsRow('Network',
            'Not supported', 'Image.network()'),
        _buildVsRow('Assets',
            'Not supported', 'Image.asset()'),
        _buildVsRow('File',
            'Not supported', 'Image.file()'),
        _buildVsRow('Memory',
            'Not supported', 'Image.memory()'),
        _buildVsRow('Rendering',
            'Full control', 'Full control (delegates to RawImage)'),
        _buildVsRow('Library',
            'widgets (framework)', 'widgets (framework)'),
        _buildVsRow('Relationship',
            'Base widget', 'Wrapper around RawImage'),
        _buildVsRow('Use case',
            'Pre-existing ui.Image', 'Standard image display'),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade50, Colors.purple.shade50],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates,
                  color: Colors.pink.shade600, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Use Image for 99% of cases (loading from assets, '
                  'network, files). Use RawImage only when you already '
                  'have a dart:ui Image — typically from Canvas drawing, '
                  'codec decoding, or render object capture.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.pink.shade800,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  comparisonSection built');

  // ============================================================
  // Assemble all sections
  // ============================================================
  print('=== Assembling final layout ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        conceptCard,
        hierarchySection,
        fitSection,
        alignmentSection,
        repeatSection,
        blendSection,
        filterSection,
        apiSection,
        liveSection,
        comparisonSection,
        SizedBox(height: 32.0),
      ],
    ),
  );

  print('RawImage Deep Demo complete — 10 sections');
  return result;
}

// ============================================================
// Helper functions
// ============================================================

Widget _buildConceptTag(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.lightBlueAccent.withValues(alpha: 0.5),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.lightBlueAccent, size: 14.0),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyLayer(
  String title,
  String subtitle,
  String description,
  MaterialColor color, {
  required bool isTop,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300, width: 1.5),
    ),
    child: Row(
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            isTop ? Icons.cloud_download : Icons.layers,
            color: Colors.white,
            size: 22.0,
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color.shade900,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: color.shade700,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11.0, color: color.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyConnector() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Center(
      child: Icon(Icons.arrow_downward,
          color: Colors.grey.shade400, size: 18.0),
    ),
  );
}

Widget _buildFitDemo(
  String name,
  String description,
  Color color,
  double widthRatio,
  double heightRatio,
) {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      children: [
        // Visual box showing fit
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Container(
              width: 40.0 * widthRatio,
              height: 40.0 * heightRatio,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.3),
                border: Border.all(color: color, width: 1.5),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Center(
                child: Icon(Icons.image, color: color, size: 14.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          description,
          style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _buildAlignmentCell(
  String name,
  Alignment alignment,
  bool highlighted,
) {
  return Container(
    height: 60.0,
    decoration: BoxDecoration(
      color: highlighted ? Colors.green.shade50 : Colors.white,
      border: Border.all(color: Colors.green.shade100),
    ),
    child: Stack(
      children: [
        Align(
          alignment: alignment,
          child: Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              color: highlighted ? Colors.green : Colors.green.shade300,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
        ),
        Positioned(
          bottom: 2.0,
          left: 0.0,
          right: 0.0,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 7.0,
              color: Colors.green.shade700,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRepeatDemo(
  String name,
  String description,
  MaterialColor color,
  int tilesX,
  int tilesY,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      children: [
        Container(
          height: 70.0,
          decoration: BoxDecoration(
            border: Border.all(color: color.shade300),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Wrap(
            spacing: 2.0,
            runSpacing: 2.0,
            children: List.generate(
              tilesX * tilesY,
              (i) => Container(
                width: tilesX > 1 ? 18.0 : 30.0,
                height: tilesY > 1 ? 18.0 : 30.0,
                decoration: BoxDecoration(
                  color: color.shade100,
                  border: Border.all(color: color.shade400, width: 0.5),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Icon(Icons.image, color: color, size: 10.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 9.0, color: color.shade700),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildBlendModeCard(
  String mode,
  String description,
  MaterialColor color,
  double intensity,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      children: [
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.shade200,
                color.shade400.withValues(alpha: intensity),
              ],
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Icon(Icons.image, color: Colors.white, size: 22.0),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          mode,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 8.0, color: color.shade700),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildFilterQualityRow(
  String level,
  String description,
  MaterialColor color,
  int stars,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 70.0,
          child: Text(
            level,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Row(
          children: List.generate(
            4,
            (i) => Icon(
              i < stars ? Icons.star : Icons.star_border,
              color: i < stars ? Colors.amber : Colors.grey.shade300,
              size: 14.0,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 10.0, color: color.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildScaleExample(
  String scale,
  String ratio,
  String result,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      children: [
        Text(
          scale,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          ratio,
          style: TextStyle(fontSize: 9.0, color: color.shade700),
          textAlign: TextAlign.center,
        ),
        Text(
          result,
          style: TextStyle(fontSize: 8.0, color: color.shade600),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildApiCard(
  String name,
  String type,
  String description,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6.0,
          height: 6.0,
          margin: EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: color.shade900,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: color.shade600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.0,
                  color: color.shade700,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildVsRow(
  String feature,
  String rawValue,
  String imageValue,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.pink.shade100, width: 0.5),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            feature,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.0,
              color: Colors.pink.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            rawValue,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.deepOrange.shade700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            imageValue,
            style: TextStyle(fontSize: 10.0, color: Colors.blue.shade700),
          ),
        ),
      ],
    ),
  );
}
