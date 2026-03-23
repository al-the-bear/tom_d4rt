// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageDescriptor from dart:ui (async — type reference)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageDescriptor test executing');

  // ImageDescriptor requires ImmutableBuffer for construction
  print('ImageDescriptor type: ${ui.ImageDescriptor}');
  print('Constructors: ImageDescriptor.raw(buffer, width:, height:, pixelFormat:)');
  print('Static: ImageDescriptor.encoded(buffer) -> Future<ImageDescriptor>');
  print('Properties: width, height, bytesPerPixel');
  print('Methods: instantiateCodec(), dispose()');

  // ImmutableBuffer — async factory
  print('ImmutableBuffer type: ${ui.ImmutableBuffer}');
  print('ImmutableBuffer.fromUint8List: async factory');
  print('ImmutableBuffer properties: length, debugDisposed');

  // PixelFormat enum reference
  for (final pf in ui.PixelFormat.values) {
    print('PixelFormat: ${pf.name}');
  }

  // TargetPixelFormat enum reference
  for (final tpf in ui.TargetPixelFormat.values) {
    print('TargetPixelFormat: ${tpf.name}');
  }

  print('ImageDescriptor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageDescriptor Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('ImageDescriptor: type reference'),
      Text('Requires ImmutableBuffer (async)'),
      Text('PixelFormat: ${ui.PixelFormat.values.length} values'),
      Text('TargetPixelFormat: ${ui.TargetPixelFormat.values.length} values'),
    ],
  );
}
