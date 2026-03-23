// ignore_for_file: avoid_print
// D4rt test script: Tests EdgeInsets from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EdgeInsets test executing');

  // Test EdgeInsets.all
  final all = EdgeInsets.all(16.0);
  print(
    'EdgeInsets.all(16): left=${all.left}, top=${all.top}, right=${all.right}, bottom=${all.bottom}',
  );

  // Test EdgeInsets.symmetric
  final symmetric = EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);
  print('EdgeInsets.symmetric: h=${symmetric.left}, v=${symmetric.top}');

  // Test EdgeInsets.only
  final only = EdgeInsets.only(left: 8.0, top: 16.0, right: 24.0, bottom: 32.0);
  print(
    'EdgeInsets.only: ${only.left}, ${only.top}, ${only.right}, ${only.bottom}',
  );

  // Test EdgeInsets.fromLTRB
  final ltrb = EdgeInsets.fromLTRB(5.0, 10.0, 15.0, 20.0);
  print(
    'EdgeInsets.fromLTRB: ${ltrb.left}, ${ltrb.top}, ${ltrb.right}, ${ltrb.bottom}',
  );

  // Test EdgeInsets.zero
  final zero = EdgeInsets.zero;
  print('EdgeInsets.zero: ${zero.left}, ${zero.top}');

  // Test EdgeInsets properties
  final total = all.horizontal + all.vertical;
  print('all.horizontal + all.vertical: $total');

  // Test EdgeInsets operations
  final scaled = all * 2.0;
  print('all * 2: ${scaled.left}');

  final added = all + symmetric;
  print('all + symmetric: ${added.left}, ${added.top}');

  print('EdgeInsets test completed');

  return Container(
    padding: all,
    color: Colors.teal,
    child: Container(
      padding: symmetric,
      color: Colors.tealAccent,
      child: Container(
        padding: only,
        color: Colors.cyan,
        child: Center(
          child: Text(
            'EdgeInsets works!',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ),
      ),
    ),
  );
}
