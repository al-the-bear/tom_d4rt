// D4rt test script: Tests dart:ui core class availability and type system
// Comprehensive overview of dart:ui class hierarchy and categories
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                  dart:ui Class Overview - Deep Demo                ║');
  print('║           Core Flutter Rendering & Graphics Classes                ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: dart:ui Introduction
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: dart:ui Introduction                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('dart:ui is the lowest-level Dart API for Flutter rendering.');
  print('');
  print('What dart:ui provides:');
  print('  - Platform abstraction for Skia/Impeller');
  print('  - Core geometry classes (Offset, Size, Rect)');
  print('  - Painting primitives (Paint, Path, Canvas)');
  print('  - Text layout (Paragraph, TextStyle)');
  print('  - Platform channel communication');
  print('  - Semantics and accessibility');
  print('  - Window and display management');
  print('');
  print('Relationship to Flutter:');
  print('  dart:ui → rendering layer → widgets layer');
  print('');
  print('Note: Many dart:ui classes are re-exported by flutter/widgets');
  print('      or have higher-level wrappers.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Geometry Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: Geometry Classes                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Core geometry building blocks:');
  print('');

  // Offset
  final offset = const Offset(10, 20);
  print('Offset - 2D point/vector:');
  print('  Instance: $offset');
  print('  Type: ${offset.runtimeType}');
  print('  dx: ${offset.dx}, dy: ${offset.dy}');
  print('  distance: ${offset.distance}');
  print('  direction: ${offset.direction} radians');
  print('');

  // Size
  final size = const Size(100, 50);
  print('Size - width/height dimensions:');
  print('  Instance: $size');
  print('  Type: ${size.runtimeType}');
  print('  width: ${size.width}, height: ${size.height}');
  print('  aspectRatio: ${size.aspectRatio}');
  print('  longestSide: ${size.longestSide}');
  print('');

  // Rect
  final rect = Rect.fromLTWH(0, 0, 100, 100);
  print('Rect - rectangle:');
  print('  Instance: $rect');
  print('  Type: ${rect.runtimeType}');
  print('  left: ${rect.left}, top: ${rect.top}');
  print('  width: ${rect.width}, height: ${rect.height}');
  print('  center: ${rect.center}');
  print('');

  // RRect
  final rrect = RRect.fromRectXY(rect, 8, 8);
  print('RRect - rounded rectangle:');
  print('  Instance: $rrect');
  print('  Type: ${rrect.runtimeType}');
  print('  outerRect: ${rrect.outerRect}');
  print('');

  // Radius
  final radius = const Radius.circular(10);
  print('Radius - corner radius:');
  print('  Instance: $radius');
  print('  Type: ${radius.runtimeType}');
  print('  x: ${radius.x}, y: ${radius.y}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: OffsetBase Hierarchy
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: OffsetBase Hierarchy                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('OffsetBase is abstract base class:');
  print('');
  print('  OffsetBase (abstract)');
  print('    ├── Offset (dx, dy) - point/vector');
  print('    └── Size (width, height) - dimensions');
  print('');
  print('Type checks:');
  print('  Offset is OffsetBase: ${offset is ui.OffsetBase}');
  print('  Size is OffsetBase: ${size is ui.OffsetBase}');
  print('');
  print('Common OffsetBase properties:');
  print('  - isInfinite');
  print('  - isFinite');
  print('');
  print('Offset.isFinite: ${offset.isFinite}');
  print('Size.isFinite: ${size.isFinite}');
  print('');
  print('Why inheritance:');
  print('  Both represent pairs of doubles');
  print('  Share validation and comparison logic');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Painting Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: Painting Classes                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // Paint
  final paint = Paint()
    ..color = const Color(0xFF2196F3)
    ..style = PaintingStyle.fill
    ..strokeWidth = 2.0;
  print('Paint - drawing style configuration:');
  print('  Instance type: ${paint.runtimeType}');
  print('  color: ${paint.color}');
  print('  style: ${paint.style}');
  print('  strokeWidth: ${paint.strokeWidth}');
  print('  isAntiAlias: ${paint.isAntiAlias}');
  print('');

  // Color
  final color = const Color.fromARGB(255, 100, 200, 50);
  print('Color - ARGB color value:');
  print('  Instance: $color');
  print('  Type: ${color.runtimeType}');
  print('  alpha: ${color.a}, red: ${color.r}');
  print('  green: ${color.g}, blue: ${color.b}');
  print('');

  // Path
  final path = Path()
    ..moveTo(0, 0)
    ..lineTo(100, 100)
    ..close();
  print('Path - vector graphics path:');
  print('  Instance type: ${path.runtimeType}');
  print('  fillType: ${path.fillType}');
  print('  bounds: ${path.getBounds()}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Text Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: Text Classes                                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // ParagraphStyle
  final ps = ui.ParagraphStyle(
    fontSize: 14,
    textAlign: TextAlign.left,
    maxLines: 1,
  );
  print('ParagraphStyle - paragraph-level text style:');
  print('  Instance type: ${ps.runtimeType}');
  print('  Use: Defines how paragraphs are laid out');
  print('  Properties: textAlign, maxLines, textDirection, etc.');
  print('');

  // ui.TextStyle
  final ts = ui.TextStyle(
    fontSize: 14,
    color: const Color(0xFF000000),
    fontWeight: FontWeight.normal,
  );
  print('ui.TextStyle - character-level text style:');
  print('  Instance type: ${ts.runtimeType}');
  print('  Use: Defines how individual characters look');
  print('  Note: Different from flutter/widgets TextStyle');
  print('');

  // TextPosition
  final tp = const TextPosition(offset: 0);
  print('TextPosition - cursor position in text:');
  print('  Instance: $tp');
  print('  Type: ${tp.runtimeType}');
  print('  offset: ${tp.offset}');
  print('  affinity: ${tp.affinity}');
  print('');

  // TextRange
  final tr = const TextRange(start: 0, end: 5);
  print('TextRange - selection or substring range:');
  print('  Instance: $tr');
  print('  Type: ${tr.runtimeType}');
  print('  start: ${tr.start}, end: ${tr.end}');
  print('  isCollapsed: ${tr.isCollapsed}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Recording & Scene Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: Recording & Scene Classes                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // PictureRecorder
  final recorder = ui.PictureRecorder();
  print('PictureRecorder - records Canvas operations:');
  print('  Instance type: ${recorder.runtimeType}');
  print('  isRecording: ${recorder.isRecording}');
  print('');
  print('Typical usage:');
  print('  1. Create PictureRecorder');
  print('  2. Create Canvas from recorder');
  print('  3. Draw on canvas');
  print('  4. Call recorder.endRecording()');
  print('  5. Get Picture to render');
  print('');

  // Create a Canvas from recorder
  final canvas = Canvas(recorder);
  print('Canvas - 2D drawing surface:');
  print('  Instance type: ${canvas.runtimeType}');
  print('  Created from: PictureRecorder');
  print('');

  // Draw something
  canvas.drawRect(rect, paint);
  print('Drew rectangle to canvas');
  print('');

  // Get Picture
  final picture = recorder.endRecording();
  print('Picture - recorded draw operations:');
  print('  Instance type: ${picture.runtimeType}');
  print('  approximateBytesUsed: ${picture.approximateBytesUsed}');
  picture.dispose();
  print('  (disposed)');
  print('');

  // SceneBuilder
  final sb = ui.SceneBuilder();
  print('SceneBuilder - builds render tree for compositor:');
  print('  Instance type: ${sb.runtimeType}');
  print('  Methods: pushClipRect, pushOpacity, pushTransform, ...');
  sb.build().dispose();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Semantics Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: Semantics Classes                                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // SemanticsUpdateBuilder
  final sub = ui.SemanticsUpdateBuilder();
  print('SemanticsUpdateBuilder - builds accessibility tree updates:');
  print('  Instance type: ${sub.runtimeType}');
  print('');
  print('Related classes:');
  print('  - SemanticsUpdate (result of build())');
  print('  - SemanticsFlag (accessibility flags)');
  print('  - SemanticsAction (user actions)');
  print('');

  final update = sub.build();
  print('SemanticsUpdate built:');
  print('  Instance type: ${update.runtimeType}');
  update.dispose();
  print('  (disposed)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Image & Codec Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: Image & Codec Classes                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Image-related classes in dart:ui:');
  print('');
  print('ui.Image:');
  print('  - Raster image decoded into GPU memory');
  print('  - Properties: width, height');
  print('  - Methods: toByteData(), dispose()');
  print('');
  print('ui.Codec:');
  print('  - Decodes image data (PNG, JPEG, GIF, WebP)');
  print('  - Supports multi-frame images (GIF)');
  print('  - Methods: getNextFrame(), dispose()');
  print('');
  print('ui.FrameInfo:');
  print('  - Single frame from Codec');
  print('  - Contains image and duration');
  print('');
  print('ImageDescriptor:');
  print('  - Describes image without full decoding');
  print('  - Useful for dimension checks');
  print('');
  print('Loading images:');
  print('  final data = await rootBundle.load("asset.png");');
  print('  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());');
  print('  final frame = await codec.getNextFrame();');
  print('  final image = frame.image;');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Platform Channel Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: Platform Channel Classes                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Platform communication classes:');
  print('');
  print('ChannelBuffers:');
  print('  - Message buffering for platform channels');
  print('  - Accessed via: ui.channelBuffers');
  print('');
  print('CallbackHandle:');
  print('  - Handle for callbacks from native code');
  print('  - Used with PluginUtilities');
  print('');
  print('PlatformDispatcher:');
  print('  - Interface to platform (main dispatcher)');
  print('  - Accessed via: ui.PlatformDispatcher.instance');
  print('  - Handles: locales, text scale, brightness');
  print('');
  print('Related methods:');
  print('  ui.PlatformDispatcher.instance.views');
  print('  ui.PlatformDispatcher.instance.onPlatformMessage');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Window & View Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: Window & View Classes                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Display-related classes:');
  print('');
  print('FlutterView:');
  print('  - Represents a view/window');
  print('  - Properties: devicePixelRatio, physicalSize');
  print('  - Methods: render()');
  print('');
  print('Display:');
  print('  - Physical display information');
  print('  - Properties: id, size, refreshRate, devicePixelRatio');
  print('');
  print('ViewPadding:');
  print('  - Safe area insets (notches, system UI)');
  print('  - Properties: left, top, right, bottom');
  print('');
  print('Accessing in Flutter:');
  print('  final view = View.of(context);');
  print('  final devicePixelRatio = view.devicePixelRatio;');
  print('  final padding = MediaQuery.of(context).padding;');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Shader & Effect Classes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: Shader & Effect Classes                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Effect classes for advanced rendering:');
  print('');
  print('Gradient:');
  print('  - Base class for gradient shaders');
  print('  - Subclasses: LinearGradient, RadialGradient, SweepGradient');
  print('');
  print('ImageShader:');
  print('  - Fill with image pattern');
  print('  - Supports tiling modes');
  print('');
  print('FragmentShader:');
  print('  - Custom SPIR-V shaders');
  print('  - GPU-accelerated effects');
  print('');
  print('ColorFilter:');
  print('  - Color transformations');
  print('  - Matrix, blend mode, linearToSrgb, etc.');
  print('');
  print('ImageFilter:');
  print('  - Blur, matrix transforms, compose');
  print('  - Applied to whole drawing');
  print('');
  print('MaskFilter:');
  print('  - Blur effect for Paint');
  print('  - Used for shadows');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Enums in dart:ui
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Enums in dart:ui                                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Key enums in dart:ui:');
  print('');
  print('Painting enums:');
  print('  - PaintingStyle (fill, stroke)');
  print('  - BlendMode (srcOver, multiply, etc.)');
  print('  - StrokeCap, StrokeJoin');
  print('  - FilterQuality');
  print('  - BlurStyle');
  print('');
  print('Path enums:');
  print('  - PathFillType (nonZero, evenOdd)');
  print('  - PathOperation (difference, intersect, union, etc.)');
  print('');
  print('Text enums:');
  print('  - TextAlign, TextDirection');
  print('  - TextBaseline');
  print('  - TextAffinity');
  print('  - BoxHeightStyle, BoxWidthStyle');
  print('');
  print('Clipping enums:');
  print('  - Clip (none, hardEdge, antiAlias, etc.)');
  print('  - ClipOp (difference, intersect)');
  print('');
  print('App lifecycle:');
  print('  - AppLifecycleState');
  print('  - AppExitType');
  print('  - Brightness');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Native Resources & Disposal
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Native Resources & Disposal                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('dart:ui classes that require disposal:');
  print('');
  print('Always dispose:');
  print('  - Image (GPU texture)');
  print('  - Picture (recorded operations)');
  print('  - Scene (compositor scene)');
  print('  - SemanticsUpdate');
  print('  - Codec');
  print('  - Paragraph');
  print('');
  print('Example:');
  print('  final image = await loadImage();');
  print('  try {');
  print('    canvas.drawImage(image, Offset.zero, paint);');
  print('  } finally {');
  print('    image.dispose();');
  print('  }');
  print('');
  print('Why disposal matters:');
  print('  - These wrap native GPU/memory resources');
  print('  - Dart GC doesn\'t track native memory');
  print('  - Memory leaks if not disposed');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Class Categories Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Class Categories Summary                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('dart:ui class categories:');
  print('');
  print('┌─────────────────────┬──────────────────────────────────────────────┐');
  print('│ Category            │ Key Classes                                  │');
  print('├─────────────────────┼──────────────────────────────────────────────┤');
  print('│ Geometry            │ Offset, Size, Rect, RRect, Radius            │');
  print('│ Painting            │ Paint, Path, Color, Canvas                   │');
  print('│ Text                │ Paragraph, ParagraphStyle, TextStyle         │');
  print('│ Image               │ Image, Codec, FrameInfo                      │');
  print('│ Effects             │ Gradient, Shader, ColorFilter, ImageFilter   │');
  print('│ Recording           │ PictureRecorder, Picture, SceneBuilder       │');
  print('│ Accessibility       │ SemanticsUpdateBuilder, SemanticsUpdate      │');
  print('│ Platform            │ ChannelBuffers, PlatformDispatcher           │');
  print('│ Display             │ FlutterView, Display, ViewPadding            │');
  print('└─────────────────────┴──────────────────────────────────────────────┘');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('dart:ui is Flutter\'s rendering foundation:');
  print('');
  print('Key takeaways:');
  print('  1. Lowest-level Flutter API (above Skia/Impeller)');
  print('  2. Provides geometry, painting, text primitives');
  print('  3. OffsetBase hierarchy: Offset and Size');
  print('  4. Canvas + PictureRecorder for custom drawing');
  print('  5. SceneBuilder for compositor operations');
  print('  6. Many classes require explicit disposal');
  print('  7. Most classes re-exported by flutter/widgets');
  print('');
  print('When to use dart:ui directly:');
  print('  - Custom painting (CustomPainter)');
  print('  - Low-level image processing');
  print('  - Custom shaders');
  print('  - Direct platform communication');
  print('');
  print('When to use Flutter wrappers:');
  print('  - Most app development');
  print('  - Widget building');
  print('  - Standard UI components');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('dart:ui class overview deep demo completed');

  // Return visual UI showing class categories
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.data_object, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'dart:ui Classes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Core Flutter Rendering API',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Class categories grid
        Text(
          'Class Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _CategoryChip(
              icon: Icons.crop_square,
              label: 'Geometry',
              examples: 'Offset, Size, Rect',
              color: Colors.blue,
            ),
            _CategoryChip(
              icon: Icons.brush,
              label: 'Painting',
              examples: 'Paint, Path, Canvas',
              color: Colors.orange,
            ),
            _CategoryChip(
              icon: Icons.text_fields,
              label: 'Text',
              examples: 'Paragraph, TextStyle',
              color: Colors.green,
            ),
            _CategoryChip(
              icon: Icons.image,
              label: 'Image',
              examples: 'Image, Codec',
              color: Colors.purple,
            ),
            _CategoryChip(
              icon: Icons.auto_fix_high,
              label: 'Effects',
              examples: 'Shader, Filter',
              color: Colors.pink,
            ),
            _CategoryChip(
              icon: Icons.fiber_manual_record,
              label: 'Recording',
              examples: 'Picture, Scene',
              color: Colors.teal,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Hierarchy example
        Text(
          'Type Hierarchy Example',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OffsetBase (abstract)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('├── ', style: TextStyle(fontFamily: 'monospace', color: Colors.grey)),
                        Text('Offset', style: TextStyle(fontFamily: 'monospace', color: Colors.blue.shade700, fontWeight: FontWeight.bold)),
                        Text(' (dx, dy)', style: TextStyle(fontFamily: 'monospace', color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('└── ', style: TextStyle(fontFamily: 'monospace', color: Colors.grey)),
                        Text('Size', style: TextStyle(fontFamily: 'monospace', color: Colors.green.shade700, fontWeight: FontWeight.bold)),
                        Text(' (width, height)', style: TextStyle(fontFamily: 'monospace', color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Key info
        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.memory,
                title: 'Native',
                content: 'Dispose required',
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _InfoCard(
                icon: Icons.layers,
                title: 'Low-level',
                content: 'Foundation API',
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _InfoCard(
                icon: Icons.upload,
                title: 'Re-exported',
                content: 'In flutter/',
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'dart:ui provides the core rendering primitives that Flutter widgets are built upon',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.indigo.shade700,
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

// Helper widget for category chips
class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String examples;
  final Color color;

  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.examples,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color.shade700),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
              Text(
                examples,
                style: TextStyle(
                  fontSize: 9,
                  color: color.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Helper widget for info cards
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 9,
              color: color.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
