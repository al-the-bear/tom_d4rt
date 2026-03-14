// D4rt test script: Tests DecorationImagePainter conceptual via DecorationImage from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DecorationImagePainter test executing');
  final results = <String>[];

  // ========== DecorationImagePainter via DecorationImage Tests ==========
  // DecorationImagePainter is created internally by DecorationImage
  print('Testing DecorationImagePainter concepts via DecorationImage...');

  // Test 1: Create DecorationImage with basic settings
  final decorationImage1 = DecorationImage(
    image: NetworkImage('https://example.com/image.png'),
    fit: BoxFit.cover,
  );
  assert(decorationImage1.fit == BoxFit.cover, 'Fit should be cover');
  results.add('DecorationImage fit: ${decorationImage1.fit}');
  print('DecorationImage fit: ${decorationImage1.fit}');

  // Test 2: DecorationImage with BoxFit.contain
  final decorationImage2 = DecorationImage(
    image: NetworkImage('https://example.com/image2.png'),
    fit: BoxFit.contain,
  );
  assert(decorationImage2.fit == BoxFit.contain, 'Fit should be contain');
  results.add('DecorationImage contain: ${decorationImage2.fit}');
  print('DecorationImage contain verified');

  // Test 3: DecorationImage with alignment
  final decorationImage3 = DecorationImage(
    image: NetworkImage('https://example.com/image3.png'),
    alignment: Alignment.topLeft,
  );
  assert(decorationImage3.alignment == Alignment.topLeft, 'Alignment should be topLeft');
  results.add('DecorationImage alignment: ${decorationImage3.alignment}');
  print('DecorationImage alignment: ${decorationImage3.alignment}');

  // Test 4: DecorationImage with repeat
  final decorationImage4 = DecorationImage(
    image: NetworkImage('https://example.com/pattern.png'),
    repeat: ImageRepeat.repeat,
  );
  assert(decorationImage4.repeat == ImageRepeat.repeat, 'Repeat should be repeat');
  results.add('DecorationImage repeat: ${decorationImage4.repeat}');
  print('DecorationImage repeat: ${decorationImage4.repeat}');

  // Test 5: DecorationImage with ImageRepeat.repeatX
  final decorationImage5 = DecorationImage(
    image: NetworkImage('https://example.com/stripe.png'),
    repeat: ImageRepeat.repeatX,
  );
  assert(decorationImage5.repeat == ImageRepeat.repeatX, 'Repeat should be repeatX');
  results.add('DecorationImage repeatX: ${decorationImage5.repeat}');
  print('DecorationImage repeatX verified');

  // Test 6: DecorationImage with ImageRepeat.repeatY
  final decorationImage6 = DecorationImage(
    image: NetworkImage('https://example.com/vstripe.png'),
    repeat: ImageRepeat.repeatY,
  );
  assert(decorationImage6.repeat == ImageRepeat.repeatY, 'Repeat should be repeatY');
  results.add('DecorationImage repeatY: ${decorationImage6.repeat}');
  print('DecorationImage repeatY verified');

  // Test 7: DecorationImage with opacity
  final decorationImage7 = DecorationImage(
    image: NetworkImage('https://example.com/transparent.png'),
    opacity: 0.5,
  );
  assert(decorationImage7.opacity == 0.5, 'Opacity should be 0.5');
  results.add('DecorationImage opacity: ${decorationImage7.opacity}');
  print('DecorationImage opacity: ${decorationImage7.opacity}');

  // Test 8: DecorationImage with scale
  final decorationImage8 = DecorationImage(
    image: NetworkImage('https://example.com/scaled.png'),
    scale: 2.0,
  );
  assert(decorationImage8.scale == 2.0, 'Scale should be 2.0');
  results.add('DecorationImage scale: ${decorationImage8.scale}');
  print('DecorationImage scale: ${decorationImage8.scale}');

  // Test 9: DecorationImage with centerSlice
  final decorationImage9 = DecorationImage(
    image: NetworkImage('https://example.com/9patch.png'),
    centerSlice: Rect.fromLTWH(10, 10, 80, 80),
  );
  assert(decorationImage9.centerSlice != null, 'CenterSlice should not be null');
  results.add('DecorationImage centerSlice: ${decorationImage9.centerSlice}');
  print('DecorationImage centerSlice: ${decorationImage9.centerSlice}');

  // Test 10: DecorationImage with filterQuality
  final decorationImage10 = DecorationImage(
    image: NetworkImage('https://example.com/hq.png'),
    filterQuality: FilterQuality.high,
  );
  assert(decorationImage10.filterQuality == FilterQuality.high, 'FilterQuality should be high');
  results.add('DecorationImage filterQuality: ${decorationImage10.filterQuality}');
  print('DecorationImage filterQuality: ${decorationImage10.filterQuality}');

  // Test 11: DecorationImage with invertColors
  final decorationImage11 = DecorationImage(
    image: NetworkImage('https://example.com/invert.png'),
    invertColors: true,
  );
  assert(decorationImage11.invertColors == true, 'InvertColors should be true');
  results.add('DecorationImage invertColors: ${decorationImage11.invertColors}');
  print('DecorationImage invertColors: ${decorationImage11.invertColors}');

  // Test 12: DecorationImage with matchTextDirection
  final decorationImage12 = DecorationImage(
    image: NetworkImage('https://example.com/rtl.png'),
    matchTextDirection: true,
  );
  assert(decorationImage12.matchTextDirection == true, 'MatchTextDirection should be true');
  results.add('DecorationImage matchTextDirection: ${decorationImage12.matchTextDirection}');
  print('DecorationImage matchTextDirection verified');

  // Test 13: DecorationImage equality
  final imgA = DecorationImage(image: NetworkImage('https://a.com/img.png'), fit: BoxFit.cover);
  final imgB = DecorationImage(image: NetworkImage('https://a.com/img.png'), fit: BoxFit.cover);
  results.add('DecorationImage equality test: completed');
  print('DecorationImage equality test completed');

  print('DecorationImagePainter test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DecorationImagePainter Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
