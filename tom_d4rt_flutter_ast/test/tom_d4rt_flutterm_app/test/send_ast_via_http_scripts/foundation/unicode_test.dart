// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Unicode utilities from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Unicode test executing');

  // Unicode constants
  print('Unicode.LRE: ${Unicode.LRE}');
  print('Unicode.RLE: ${Unicode.RLE}');
  print('Unicode.PDF: ${Unicode.PDF}');
  print('Unicode.LRO: ${Unicode.LRO}');
  print('Unicode.RLO: ${Unicode.RLO}');
  print('Unicode.LRI: ${Unicode.LRI}');
  print('Unicode.RLI: ${Unicode.RLI}');
  print('Unicode.FSI: ${Unicode.FSI}');
  print('Unicode.PDI: ${Unicode.PDI}');
  print('Unicode.LRM: ${Unicode.LRM}');
  print('Unicode.RLM: ${Unicode.RLM}');
  print('Unicode.ALM: ${Unicode.ALM}');

  print('Unicode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Unicode Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('12 bidirectional constants tested'),
      Text('LRE: 0x${Unicode.LRE.codeUnitAt(0).toRadixString(16)}'),
    ],
  );
}
