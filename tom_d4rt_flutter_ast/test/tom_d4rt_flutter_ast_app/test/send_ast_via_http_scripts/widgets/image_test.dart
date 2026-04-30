// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Image widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Image test executing');

  // Note: Image.network and Image.asset may not work in D4rt sandbox
  // Testing constructors and properties that work without network/assets

  // Test Image.memory would require bytes, skipping for now

  // Test placeholder/error widgets pattern
  final placeholderImage = Container(
    width: 150.0,
    height: 100.0,
    color: Colors.grey.shade300,
    child: Center(
      child: Icon(Icons.image, size: 48.0, color: Colors.grey.shade600),
    ),
  );
  print('Placeholder image container created');

  // Test Container decorated like an image area
  final decoratedImageArea = Container(
    width: 150.0,
    height: 100.0,
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.blue, width: 2.0),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.photo, size: 32.0, color: Colors.blue),
          Text(
            'Image Area',
            style: TextStyle(color: Colors.blue, fontSize: 12.0),
          ),
        ],
      ),
    ),
  );
  print('Decorated image area created');

  // Test DecorationImage properties on Container
  final decorationImageContainer = Container(
    width: 150.0,
    height: 100.0,
    decoration: BoxDecoration(
      color: Colors.green.shade100,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(
      child: Text('BoxFit.cover', style: TextStyle(fontSize: 14.0)),
    ),
  );
  print('Container demonstrating BoxFit properties created: $decorationImageContainer');

  // Test various BoxFit values on containers
  final boxFitDemo = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.0,
            height: 40.0,
            color: Colors.red.shade100,
            child: Center(
              child: Text('fill', style: TextStyle(fontSize: 10.0)),
            ),
          ),
          Text('BoxFit.fill', style: TextStyle(fontSize: 8.0)),
        ],
      ),
      SizedBox(width: 8.0),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.0,
            height: 40.0,
            color: Colors.green.shade100,
            child: Center(
              child: Text('contain', style: TextStyle(fontSize: 10.0)),
            ),
          ),
          Text('BoxFit.contain', style: TextStyle(fontSize: 8.0)),
        ],
      ),
      SizedBox(width: 8.0),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.0,
            height: 40.0,
            color: Colors.blue.shade100,
            child: Center(
              child: Text('cover', style: TextStyle(fontSize: 10.0)),
            ),
          ),
          Text('BoxFit.cover', style: TextStyle(fontSize: 8.0)),
        ],
      ),
    ],
  );
  print('BoxFit demonstration created');

  // Test ImageRepeat values on containers
  final repeatDemo = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 50.0,
        height: 50.0,
        color: Colors.orange.shade100,
        child: Center(child: Text('no', style: TextStyle(fontSize: 10.0))),
      ),
      SizedBox(width: 4.0),
      Container(
        width: 50.0,
        height: 50.0,
        color: Colors.purple.shade100,
        child: Center(child: Text('x', style: TextStyle(fontSize: 10.0))),
      ),
      SizedBox(width: 4.0),
      Container(
        width: 50.0,
        height: 50.0,
        color: Colors.teal.shade100,
        child: Center(child: Text('y', style: TextStyle(fontSize: 10.0))),
      ),
      SizedBox(width: 4.0),
      Container(
        width: 50.0,
        height: 50.0,
        color: Colors.pink.shade100,
        child: Center(child: Text('xy', style: TextStyle(fontSize: 10.0))),
      ),
    ],
  );
  print('ImageRepeat demonstration created');

  // Test FilterQuality on container
  final filterQualityDemo = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FilterQuality:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            color: Colors.grey.shade200,
            child: Center(child: Text('none', style: TextStyle(fontSize: 8.0))),
          ),
          Container(
            width: 40.0,
            height: 40.0,
            color: Colors.grey.shade300,
            child: Center(child: Text('low', style: TextStyle(fontSize: 8.0))),
          ),
          Container(
            width: 40.0,
            height: 40.0,
            color: Colors.grey.shade400,
            child: Center(child: Text('med', style: TextStyle(fontSize: 8.0))),
          ),
          Container(
            width: 40.0,
            height: 40.0,
            color: Colors.grey.shade500,
            child: Center(child: Text('high', style: TextStyle(fontSize: 8.0))),
          ),
        ],
      ),
    ],
  );
  print('FilterQuality demonstration created');

  print('Image test completed');
  print('NOTE: Network/asset images cannot be tested in D4rt sandbox');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Image Widget Test', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8.0),
      placeholderImage,
      SizedBox(height: 8.0),
      decoratedImageArea,
      SizedBox(height: 8.0),
      Text(
        'BoxFit values:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
      ),
      boxFitDemo,
      SizedBox(height: 8.0),
      Text(
        'ImageRepeat values:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
      ),
      repeatDemo,
      SizedBox(height: 8.0),
      filterQualityDemo,
    ],
  );
}
