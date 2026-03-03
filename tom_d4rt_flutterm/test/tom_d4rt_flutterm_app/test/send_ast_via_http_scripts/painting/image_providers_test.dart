// D4rt test script: Tests ExactAssetImage, FractionalOffset
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageProvidersTest test executing');

  // ExactAssetImage
  final exactAsset = ExactAssetImage(
    'assets/placeholder.png',
    scale: 2.0,
  );
  print('ExactAssetImage assetName: ${exactAsset.assetName}');
  print('ExactAssetImage scale: ${exactAsset.scale}');

  // FractionalOffset
  final offset1 = FractionalOffset(0.5, 0.5);
  print('FractionalOffset(0.5, 0.5) dx: ${offset1.dx}');
  print('FractionalOffset(0.5, 0.5) dy: ${offset1.dy}');

  final offset2 = FractionalOffset(0.0, 1.0);
  print('FractionalOffset(0.0, 1.0) dx: ${offset2.dx}');
  print('FractionalOffset(0.0, 1.0) dy: ${offset2.dy}');

  // FractionalOffset constants
  final topLeft = FractionalOffset.topLeft;
  final center = FractionalOffset.center;
  final bottomRight = FractionalOffset.bottomRight;
  print('FractionalOffset.topLeft: $topLeft');
  print('FractionalOffset.center: $center');
  print('FractionalOffset.bottomRight: $bottomRight');

  // Use FractionalOffset in alignment
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 200.0,
        height: 60.0,
        color: Colors.blue.shade50,
        alignment: offset1,
        child: Text('Centered (0.5, 0.5)'),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 200.0,
        height: 60.0,
        color: Colors.green.shade50,
        alignment: offset2,
        child: Text('Bottom-left (0.0, 1.0)'),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 200.0,
        height: 60.0,
        color: Colors.orange.shade50,
        alignment: topLeft,
        child: Text('FractionalOffset.topLeft'),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 200.0,
        height: 60.0,
        color: Colors.purple.shade50,
        alignment: bottomRight,
        child: Text('FractionalOffset.bottomRight'),
      ),
      SizedBox(height: 16.0),
      Text(
        'ExactAssetImage: ${exactAsset.assetName} @${exactAsset.scale}x',
        style: TextStyle(fontSize: 12.0, color: Colors.grey),
      ),
    ],
  );
}
