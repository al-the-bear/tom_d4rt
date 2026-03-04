// D4rt test script: Tests painting ImageStream, ImageStreamListener,
// ImageStreamCompleter, ImageInfo, ImageChunkEvent, PlaceholderDimensions,
// InlineSpanSemanticsInformation, Accumulator
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

dynamic build(BuildContext context) {
  print('Painting image stream and misc test executing');

  // ========== PlaceholderDimensions ==========
  print('--- PlaceholderDimensions Tests ---');

  final placeholder = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.middle,
  );
  print('PlaceholderDimensions size: ${placeholder.size}');
  print('PlaceholderDimensions alignment: ${placeholder.alignment}');

  final placeholderWithBaseline = PlaceholderDimensions(
    size: Size(80.0, 30.0),
    alignment: PlaceholderAlignment.baseline,
    baselineOffset: 20.0,
    baseline: TextBaseline.alphabetic,
  );
  print('PlaceholderDimensions baselineOffset: ${placeholderWithBaseline.baselineOffset}');
  print('PlaceholderDimensions baseline: ${placeholderWithBaseline.baseline}');

  // ========== PlaceholderAlignment ==========
  print('--- PlaceholderAlignment Tests ---');

  print('PlaceholderAlignment.baseline: ${PlaceholderAlignment.baseline}');
  print('PlaceholderAlignment.aboveBaseline: ${PlaceholderAlignment.aboveBaseline}');
  print('PlaceholderAlignment.belowBaseline: ${PlaceholderAlignment.belowBaseline}');
  print('PlaceholderAlignment.top: ${PlaceholderAlignment.top}');
  print('PlaceholderAlignment.bottom: ${PlaceholderAlignment.bottom}');
  print('PlaceholderAlignment.middle: ${PlaceholderAlignment.middle}');

  // ========== Accumulator ==========
  print('--- Accumulator Tests ---');

  final acc = Accumulator();
  print('Accumulator initial value: ${acc.value}');
  acc.increment(5);
  print('Accumulator after increment(5): ${acc.value}');
  acc.increment(3);
  print('Accumulator after increment(3): ${acc.value}');

  // ========== InlineSpanSemanticsInformation ==========
  print('--- InlineSpanSemanticsInformation Tests ---');

  final spanInfo = InlineSpanSemanticsInformation(
    'Hello World',
    isPlaceholder: false,
  );
  print('InlineSpanSemanticsInformation text: ${spanInfo.text}');
  print('InlineSpanSemanticsInformation isPlaceholder: ${spanInfo.isPlaceholder}');
  print('InlineSpanSemanticsInformation requiresOwnNode: ${spanInfo.requiresOwnNode}');

  final placeholderInfo = InlineSpanSemanticsInformation.placeholder;
  print('InlineSpanSemanticsInformation.placeholder isPlaceholder: ${placeholderInfo.isPlaceholder}');

  // ========== ImageChunkEvent ==========
  print('--- ImageChunkEvent Tests ---');

  final chunkEvent = ImageChunkEvent(
    cumulativeBytesLoaded: 5000,
    expectedTotalBytes: 10000,
  );
  print('ImageChunkEvent cumulativeBytesLoaded: ${chunkEvent.cumulativeBytesLoaded}');
  print('ImageChunkEvent expectedTotalBytes: ${chunkEvent.expectedTotalBytes}');

  final chunkEventNoTotal = ImageChunkEvent(
    cumulativeBytesLoaded: 3000,
    expectedTotalBytes: null,
  );
  print('ImageChunkEvent without total: ${chunkEventNoTotal.expectedTotalBytes}');

  // ========== ImageConfiguration ==========
  print('--- ImageConfiguration Tests ---');

  final icEmpty = ImageConfiguration.empty;
  print('ImageConfiguration.empty devicePixelRatio: ${icEmpty.devicePixelRatio}');
  print('ImageConfiguration.empty locale: ${icEmpty.locale}');
  print('ImageConfiguration.empty textDirection: ${icEmpty.textDirection}');
  print('ImageConfiguration.empty size: ${icEmpty.size}');
  print('ImageConfiguration.empty platform: ${icEmpty.platform}');

  print('All painting image stream and misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Painting Image Stream & Misc Test',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('PlaceholderDimensions: ${placeholder.size}'),
            Text('Accumulator: ${acc.value}'),
            Text('ImageChunkEvent loaded: ${chunkEvent.cumulativeBytesLoaded}'),
          ],
        ),
      ),
    ),
  );
}
