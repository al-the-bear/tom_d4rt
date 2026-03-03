// D4rt test script: Tests ColorFilter, ImageFilter, MaskFilter from dart:ui
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui filters test executing');

  // ========== COLORFILTER ==========
  print('--- ColorFilter Tests ---');

  // ColorFilter.mode
  final modeFilter = ColorFilter.mode(Color(0xFF000000), BlendMode.srcOver);
  print('ColorFilter.mode(black, srcOver): $modeFilter');
  print('  runtimeType: ${modeFilter.runtimeType}');

  final redOverlay = ColorFilter.mode(Color(0x80FF0000), BlendMode.srcATop);
  print('ColorFilter.mode(red50%, srcATop): $redOverlay');

  final tintFilter = ColorFilter.mode(Color(0xFF0000FF), BlendMode.modulate);
  print('ColorFilter.mode(blue, modulate): $tintFilter');

  // ColorFilter.matrix
  final identityMatrix = <double>[
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];
  final matrixFilter = ColorFilter.matrix(identityMatrix);
  print('ColorFilter.matrix(identity): $matrixFilter');

  // Greyscale matrix
  final greyscaleMatrix = <double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];
  final greyscaleFilter = ColorFilter.matrix(greyscaleMatrix);
  print('ColorFilter.matrix(greyscale): $greyscaleFilter');

  // ColorFilter.linearToSrgbGamma
  final linearToSrgb = ColorFilter.linearToSrgbGamma();
  print('ColorFilter.linearToSrgbGamma(): $linearToSrgb');

  // ColorFilter.srgbToLinearGamma
  final srgbToLinear = ColorFilter.srgbToLinearGamma();
  print('ColorFilter.srgbToLinearGamma(): $srgbToLinear');

  // Test various BlendModes with ColorFilter
  final blendModes = [
    BlendMode.src,
    BlendMode.dst,
    BlendMode.srcOver,
    BlendMode.dstOver,
    BlendMode.srcIn,
    BlendMode.dstIn,
    BlendMode.srcOut,
    BlendMode.dstOut,
    BlendMode.srcATop,
    BlendMode.dstATop,
    BlendMode.xor,
    BlendMode.multiply,
    BlendMode.screen,
    BlendMode.overlay,
  ];
  for (final mode in blendModes) {
    final f = ColorFilter.mode(Color(0xFF00FF00), mode);
    print('  ColorFilter.mode(green, $mode): ${f.runtimeType}');
  }

  // ========== MASKFILTER ==========
  print('--- MaskFilter Tests ---');

  final normalBlur = MaskFilter.blur(BlurStyle.normal, 5.0);
  print('MaskFilter.blur(normal, 5.0): $normalBlur');
  print('  runtimeType: ${normalBlur.runtimeType}');

  final solidBlur = MaskFilter.blur(BlurStyle.solid, 3.0);
  print('MaskFilter.blur(solid, 3.0): $solidBlur');

  final outerBlur = MaskFilter.blur(BlurStyle.outer, 8.0);
  print('MaskFilter.blur(outer, 8.0): $outerBlur');

  final innerBlur = MaskFilter.blur(BlurStyle.inner, 2.0);
  print('MaskFilter.blur(inner, 2.0): $innerBlur');

  // Test all BlurStyles
  for (final style in BlurStyle.values) {
    final blur = MaskFilter.blur(style, 4.0);
    print('  MaskFilter.blur($style, 4.0): ${blur.runtimeType}');
  }

  // ========== IMAGEFILTER ==========
  print('--- ImageFilter Tests ---');

  final blurFilter = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  print('ImageFilter.blur(sigmaX: 2, sigmaY: 2): $blurFilter');
  print('  runtimeType: ${blurFilter.runtimeType}');

  final asymBlur = ImageFilter.blur(sigmaX: 5.0, sigmaY: 1.0);
  print('ImageFilter.blur(sigmaX: 5, sigmaY: 1): $asymBlur');

  final noBlur = ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0);
  print('ImageFilter.blur(sigmaX: 0, sigmaY: 0): $noBlur');

  // Note: ImageFilter.matrix requires Float64List which is not available in D4rt

  // ImageFilter.compose
  final composedFilter = ImageFilter.compose(
    outer: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    inner: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
  );
  print('ImageFilter.compose(outer blur + inner blur): $composedFilter');

  // ImageFilter with TileMode
  final clampBlur = ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
    tileMode: TileMode.clamp,
  );
  print('ImageFilter.blur with clamp: $clampBlur');

  final repeatBlur = ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
    tileMode: TileMode.repeated,
  );
  print('ImageFilter.blur with repeat: $repeatBlur');

  // ========== RETURN WIDGET ==========
  print('dart:ui filters test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Filters Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• ColorFilter - color transformation filters'),
          Text('• MaskFilter - blur mask effects'),
          Text('• ImageFilter - image blur/matrix filters'),
          SizedBox(height: 16.0),

          Text('Filter Types:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE0F7FA),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ColorFilter:'),
                Text('  .mode(color, blendMode)'),
                Text('  .matrix(20-element list)'),
                Text('  .linearToSrgbGamma()'),
                Text('  .srgbToLinearGamma()'),
                SizedBox(height: 8.0),
                Text('MaskFilter:'),
                Text('  .blur(BlurStyle, sigma)'),
                SizedBox(height: 8.0),
                Text('ImageFilter:'),
                Text('  .blur(sigmaX, sigmaY)'),
                Text('  .matrix(Float64List)'),
                Text('  .compose(outer, inner)'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
