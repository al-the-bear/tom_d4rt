// D4rt test script: Tests TextTreeConfiguration from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextTreeConfiguration test executing');

  final ttc = TextTreeConfiguration(
    prefixLineOne: '├─',
    prefixLastChildLineOne: '└─',
    prefixOtherLines: '│ ',
    linkCharacter: '│',
    prefixOtherLinesRootNode: '  ',
  );
  print('TextTreeConfiguration: ${ttc.runtimeType}');
  print('prefixLineOne: ${ttc.prefixLineOne}');
  print('prefixLastChildLineOne: ${ttc.prefixLastChildLineOne}');
  print('prefixOtherLines: ${ttc.prefixOtherLines}');
  print('linkCharacter: ${ttc.linkCharacter}');
  print('showChildren: ${ttc.showChildren}');
  print('addBlankLineIfNoChildren: ${ttc.addBlankLineIfNoChildren}');
  print('isBlankLineBetweenPropertiesAndChildren: ${ttc.isBlankLineBetweenPropertiesAndChildren}');

  // Pre-built configs
  print('sparseTextConfiguration: ${sparseTextConfiguration.runtimeType}');
  print('denseTextConfiguration: ${denseTextConfiguration.runtimeType}');

  print('TextTreeConfiguration test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('TextTreeConfiguration Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Custom config created'),
    Text('prefix: ${ttc.prefixLineOne}'),
  ]);
}
