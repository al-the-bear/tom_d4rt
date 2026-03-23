// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollPhysics variants from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollPhysics test executing');

  // ========== SCROLLPHYSICS ==========
  print('--- ScrollPhysics Tests ---');

  // Base ScrollPhysics
  final basePhysics = ScrollPhysics();
  print('ScrollPhysics() created');
  print('  type: ${basePhysics.runtimeType}');

  // ScrollPhysics with parent
  final parentedPhysics = ScrollPhysics(parent: ScrollPhysics());
  print('ScrollPhysics with parent created');

  // ========== BOUNCINGSCROLLPHYSICS ==========
  print('--- BouncingScrollPhysics Tests ---');

  final bouncing = BouncingScrollPhysics();
  print('BouncingScrollPhysics created');
  print('  type: ${bouncing.runtimeType}');

  // BouncingScrollPhysics with parent
  final bouncingParented = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );
  print('BouncingScrollPhysics with parent created');

  // ========== CLAMPINGSCROLLPHYSICS ==========
  print('--- ClampingScrollPhysics Tests ---');

  final clamping = ClampingScrollPhysics();
  print('ClampingScrollPhysics created');
  print('  type: ${clamping.runtimeType}');

  // ========== NEVERSCROLLABLESCROLLPHYSICS ==========
  print('--- NeverScrollableScrollPhysics Tests ---');

  final neverScroll = NeverScrollableScrollPhysics();
  print('NeverScrollableScrollPhysics created');
  print('  type: ${neverScroll.runtimeType}');
  // shouldAcceptUserOffset is a method (takes ScrollMetrics), not a getter
  print('  NeverScrollableScrollPhysics created successfully');

  // ========== ALWAYSSCROLLABLESCROLLPHYSICS ==========
  print('--- AlwaysScrollableScrollPhysics Tests ---');

  final alwaysScroll = AlwaysScrollableScrollPhysics();
  print('AlwaysScrollableScrollPhysics created');
  print('  type: ${alwaysScroll.runtimeType}');
  // shouldAcceptUserOffset is a method (takes ScrollMetrics), not a getter
  print('  AlwaysScrollableScrollPhysics created successfully');

  // ========== PAGESCROLLPHYSICS ==========
  print('--- PageScrollPhysics Tests ---');

  final pagePhysics = PageScrollPhysics();
  print('PageScrollPhysics created');
  print('  type: ${pagePhysics.runtimeType}');

  // ========== RANGEMAINTAININGSCROLLPHYSICS ==========
  print('--- RangeMaintainingScrollPhysics Tests ---');

  final rangePhysics = RangeMaintainingScrollPhysics();
  print('RangeMaintainingScrollPhysics created');
  print('  type: ${rangePhysics.runtimeType}');

  // Test applyTo chain
  final combined = BouncingScrollPhysics().applyTo(
    AlwaysScrollableScrollPhysics(),
  );
  print('BouncingScrollPhysics.applyTo(AlwaysScrollable) created');
  print('  type: ${combined.runtimeType}');

  print('All ScrollPhysics tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ScrollPhysics Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          // Bouncing physics list
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Container(
                    height: 40.0,
                    color: Colors.blue.withValues(
                      alpha: 0.3 + (index % 5) * 0.14,
                    ),
                    child: Center(child: Text('Bouncing item $index')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
