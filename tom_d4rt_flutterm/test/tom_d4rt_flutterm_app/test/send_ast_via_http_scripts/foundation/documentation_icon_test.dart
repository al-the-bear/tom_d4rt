// D4rt test script: Tests DocumentationIcon from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DocumentationIcon test executing');

  final icon = DocumentationIcon('https://flutter.dev/assets/icon.png');
  print('DocumentationIcon: ${icon.runtimeType}');
  print('url: ${icon.url}');

  final icon2 = DocumentationIcon('https://example.com/logo.svg');
  print('icon2 url: ${icon2.url}');

  print('DocumentationIcon test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DocumentationIcon Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Annotation for doc icons'),
    Text('url: ${icon.url}'),
  ]);
}
