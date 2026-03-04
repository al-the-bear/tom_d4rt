// D4rt test script: Tests PreferredSize, OrientationBuilder, GridPaper from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PreferredSize test executing');

  // ========== PREFERREDSIZE ==========
  print('--- PreferredSize Tests ---');

  // PreferredSize wraps a widget with a preferred size hint
  final preferred = PreferredSize(
    preferredSize: Size.fromHeight(80.0),
    child: Container(
      color: Colors.blue,
      child: Center(
        child: Text('Custom AppBar', style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
    ),
  );
  print('PreferredSize created');
  print('  preferredSize: ${preferred.preferredSize}');

  // Another PreferredSize
  final preferred2 = PreferredSize(
    preferredSize: Size(double.infinity, 120.0),
    child: Container(
      color: Colors.green,
      child: Center(
        child: Text('Tall AppBar', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('PreferredSize(infinity, 120) created');
  print('  preferredSize: ${preferred2.preferredSize}');

  // ========== GRIDPAPER ==========
  print('--- GridPaper Tests ---');

  // Default GridPaper
  final defaultGrid = GridPaper();
  print('Default GridPaper created');

  // GridPaper with custom colors
  final customGrid = GridPaper(
    color: Colors.red.withValues(alpha: 0.3),
    interval: 50.0,
    divisions: 2,
    subdivisions: 5,
  );
  print('Custom GridPaper created');
  print('  interval: ${customGrid.interval}');
  print('  divisions: ${customGrid.divisions}');
  print('  subdivisions: ${customGrid.subdivisions}');

  // GridPaper with larger interval
  final largeGrid = GridPaper(
    interval: 100.0,
    divisions: 4,
    subdivisions: 2,
    color: Colors.blue.withValues(alpha: 0.2),
  );
  print('Large GridPaper created');

  // ========== POPSCOPE ==========
  print('--- PopScope Tests ---');

  final popScope = PopScope(
    canPop: false,
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.orange,
      child: Center(child: Text('No pop')),
    ),
  );
  print('PopScope(canPop=false) created');
  print('  canPop: ${popScope.canPop}');

  final popScopeAllow = PopScope(
    canPop: true,
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.green,
      child: Center(child: Text('Can pop')),
    ),
  );
  print('PopScope(canPop=true) created');
  print('  canPop: ${popScopeAllow.canPop}');

  print('All PreferredSize tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text('PreferredSize Test'),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Widget Misc Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Stack(
                children: [
                  customGrid,
                  Center(child: Text('Grid Paper')),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            popScope,
            SizedBox(height: 4.0),
            popScopeAllow,
          ],
        ),
      ),
    ),
  );
}
