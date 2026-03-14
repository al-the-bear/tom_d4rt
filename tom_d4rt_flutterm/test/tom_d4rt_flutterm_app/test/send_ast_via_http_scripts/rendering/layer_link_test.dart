// D4rt test script: Tests LayerLink from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LayerLink test executing');

  // ========== Basic LayerLink creation ==========
  print('--- Basic LayerLink ---');
  final link = LayerLink();
  print('  created: ${link.runtimeType}');
  print('  leader: ${link.leader}');
  print('  leaderSize: ${link.leaderSize}');

  // ========== Multiple LayerLinks ==========
  print('--- Multiple LayerLinks ---');
  final link1 = LayerLink();
  final link2 = LayerLink();
  final link3 = LayerLink();
  print('  link1: ${link1.runtimeType}');
  print('  link2: ${link2.runtimeType}');
  print('  link3: ${link3.runtimeType}');
  print('  link1 == link2: ${link1 == link2}');
  print('  link1 == link1: ${link1 == link1}');

  // ========== LayerLink hashCode ==========
  print('--- LayerLink hashCode ---');
  print('  link1.hashCode: ${link1.hashCode}');
  print('  link2.hashCode: ${link2.hashCode}');
  print('  link1.hashCode == link2.hashCode: ${link1.hashCode == link2.hashCode}');

  // ========== LayerLink toString ==========
  print('--- LayerLink toString ---');
  print('  link.toString(): ${link.toString()}');
  print('  link1.toString(): ${link1.toString()}');

  // ========== Use with CompositedTransformTarget ==========
  print('--- With CompositedTransformTarget ---');
  final targetLink = LayerLink();
  final target = CompositedTransformTarget(
    link: targetLink,
    child: Container(width: 100.0, height: 100.0, color: Color(0xFF2196F3)),
  );
  print('  CompositedTransformTarget created');
  print('  target.link: ${target.link}');
  print('  target.link == targetLink: ${target.link == targetLink}');

  // ========== Use with CompositedTransformFollower ==========
  print('--- With CompositedTransformFollower ---');
  final followerLink = LayerLink();
  final follower = CompositedTransformFollower(
    link: followerLink,
    offset: Offset(10.0, 10.0),
    child: Container(width: 50.0, height: 50.0, color: Color(0xFFFF5722)),
  );
  print('  CompositedTransformFollower created');
  print('  follower.link: ${follower.link}');
  print('  follower.offset: ${follower.offset}');
  print('  follower.targetAnchor: ${follower.targetAnchor}');
  print('  follower.followerAnchor: ${follower.followerAnchor}');

  print('LayerLink test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('LayerLink Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('LayerLink created: ${link.runtimeType}'),
          Text('Multiple links: 3 created'),
          Text('Equality: link1 != link2'),
          Text('HashCode: unique per instance'),
          CompositedTransformTarget(
            link: LayerLink(),
            child: Container(
              width: 80.0,
              height: 40.0,
              color: Color(0xFF4CAF50),
              child: Center(child: Text('Target')),
            ),
          ),
        ],
      ),
    ),
  );
}
