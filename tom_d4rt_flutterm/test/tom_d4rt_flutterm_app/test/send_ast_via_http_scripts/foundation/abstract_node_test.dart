// D4rt test script: Tests AbstractNode from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AbstractNode test executing');

  final node = AbstractNode();
  print('AbstractNode: ${node.runtimeType}');
  print('attached: ${node.attached}');
  print('depth: ${node.depth}');
  print('owner: ${node.owner}');
  print('parent: ${node.parent}');

  // Redepth, adopt, drop — these need an owner to work fully
  print('AbstractNode is the base class for render tree nodes');

  print('AbstractNode test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('AbstractNode Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('attached: ${node.attached}'),
    Text('depth: ${node.depth}'),
  ]);
}
