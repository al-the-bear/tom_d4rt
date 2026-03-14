// D4rt test script: Tests LeaderLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LeaderLayer test executing');

  // ========== Basic LeaderLayer creation ==========
  print('--- Basic LeaderLayer ---');
  final link1 = LayerLink();
  final leader1 = LeaderLayer(link: link1);
  print('  created: ${leader1.runtimeType}');
  print('  link: ${leader1.link}');
  print('  offset: ${leader1.offset}');

  // ========== LeaderLayer with offset ==========
  print('--- LeaderLayer with offset ---');
  final link2 = LayerLink();
  final leader2 = LeaderLayer(link: link2, offset: Offset(10.0, 20.0));
  print('  offset: ${leader2.offset}');

  final leader3 = LeaderLayer(link: LayerLink(), offset: Offset(-5.0, 15.0));
  print('  negative x offset: ${leader3.offset}');

  final leader4 = LeaderLayer(link: LayerLink(), offset: Offset.zero);
  print('  zero offset: ${leader4.offset}');

  // ========== LayerLink relationship ==========
  print('--- LayerLink relationship ---');
  final sharedLink = LayerLink();
  final leaderWithLink = LeaderLayer(link: sharedLink);
  print('  leader.link == sharedLink: ${leaderWithLink.link == sharedLink}');
  print('  sharedLink.leader: ${sharedLink.leader}');

  // ========== LeaderLayer properties ==========
  print('--- LeaderLayer properties ---');
  print('  leader1.debugCreator: ${leader1.debugCreator}');
  print('  leader1.parent: ${leader1.parent}');
  print('  leader1.nextSibling: ${leader1.nextSibling}');
  print('  leader1.previousSibling: ${leader1.previousSibling}');

  // ========== Multiple LeaderLayers ==========
  print('--- Multiple LeaderLayers ---');
  final leaderA = LeaderLayer(link: LayerLink(), offset: Offset(0.0, 0.0));
  final leaderB = LeaderLayer(link: LayerLink(), offset: Offset(50.0, 0.0));
  final leaderC = LeaderLayer(link: LayerLink(), offset: Offset(100.0, 0.0));
  print('  leaderA offset: ${leaderA.offset}');
  print('  leaderB offset: ${leaderB.offset}');
  print('  leaderC offset: ${leaderC.offset}');

  // ========== Layer hierarchy ==========
  print('--- Layer hierarchy ---');
  print('  LeaderLayer extends ContainerLayer');
  print('  leader1 is ContainerLayer: ${leader1 is ContainerLayer}');
  print('  leader1 is Layer: ${leader1 is Layer}');

  // ========== Offset modifications ==========
  print('--- Offset modifications ---');
  final modifiableLeader = LeaderLayer(link: LayerLink());
  print('  initial offset: ${modifiableLeader.offset}');
  modifiableLeader.offset = Offset(25.0, 35.0);
  print('  modified offset: ${modifiableLeader.offset}');
  modifiableLeader.offset = Offset(100.0, 200.0);
  print('  further modified: ${modifiableLeader.offset}');

  // ========== Using with CompositedTransformTarget ==========
  print('--- With CompositedTransformTarget widget ---');
  final widgetLink = LayerLink();
  final targetWidget = CompositedTransformTarget(
    link: widgetLink,
    child: Container(width: 80.0, height: 40.0, color: Color(0xFF4CAF50)),
  );
  print('  CompositedTransformTarget created');
  print('  uses LeaderLayer internally');

  print('LeaderLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'LeaderLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic leader: ${leader1.runtimeType}'),
          Text('Link: ${leader1.link.runtimeType}'),
          Text('Offset: ${leader2.offset}'),
          SizedBox(height: 8.0),
          Text('Layer hierarchy:'),
          Text('  - extends ContainerLayer'),
          Text('  - implements Layer'),
          SizedBox(height: 8.0),
          CompositedTransformTarget(
            link: LayerLink(),
            child: Container(
              width: 100.0,
              height: 50.0,
              color: Color(0xFF2196F3),
              child: Center(
                child: Text(
                  'Target',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          Text('CompositedTransformTarget uses LeaderLayer'),
        ],
      ),
    ),
  );
}
