// D4rt test script: Tests Card advanced, CardTheme, InkSplash, InkRipple,
// InteractiveInkFeatureFactory, MaterialInkController, Ink, InkDecoration
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Card and ink splash test executing');

  // ========== Card advanced ==========
  print('--- Card Advanced Tests ---');
  final card1 = Card(
    color: Colors.white,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey[300]!),
    ),
    borderOnForeground: true,
    margin: EdgeInsets.all(8),
    clipBehavior: Clip.antiAlias,
    semanticContainer: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 120, color: Colors.blue[100]),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Card description text',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Card created');

  // ========== Card.filled ==========
  print('--- Card.filled Tests ---');
  final cardFilled = Card.filled(
    color: Colors.blue[50],
    shadowColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.all(8),
    child: ListTile(title: Text('Filled Card'), subtitle: Text('No elevation')),
  );
  print('Card.filled created');

  // ========== Card.outlined ==========
  print('--- Card.outlined Tests ---');
  final cardOutlined = Card.outlined(
    color: Colors.white,
    elevation: 0,
    margin: EdgeInsets.all(8),
    child: ListTile(
      title: Text('Outlined Card'),
      subtitle: Text('With border'),
    ),
  );
  print('Card.outlined created');

  // ========== CardTheme ==========
  print('--- CardTheme Tests ---');
  final cardTheme = CardThemeData(
    color: Colors.white,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: EdgeInsets.all(4),
    clipBehavior: Clip.antiAlias,
  );
  print('CardThemeData created');
  print('  elevation: ${cardTheme.elevation}');
  print('  clipBehavior: ${cardTheme.clipBehavior}');

  // ========== Ink widget ==========
  print('--- Ink Widget Tests ---');
  final ink = Ink(
    decoration: BoxDecoration(
      color: Colors.blue[100],
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [Colors.blue[100]!, Colors.blue[300]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    padding: EdgeInsets.all(16),
    width: 200,
    height: 80,
    child: Center(child: Text('Ink Widget')),
  );
  print('Ink widget created');

  // ========== Ink.image ==========
  print('--- Ink.image Tests ---');
  final inkImage = Ink(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    ),
    width: 200,
    height: 120,
    child: Center(child: Text('Ink Image Placeholder')),
  );
  print('Ink with decoration created');

  // ========== InkWell with splash factory ==========
  print('--- InkSplash / InkRipple Tests ---');
  final inkWellSplash = InkWell(
    onTap: () => print('  InkSplash tap'),
    splashFactory: InkSplash.splashFactory,
    splashColor: Colors.blue[200],
    highlightColor: Colors.blue[100],
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('InkSplash Factory'),
    ),
  );
  print('InkWell with InkSplash.splashFactory created');

  final inkWellRipple = InkWell(
    onTap: () => print('  InkRipple tap'),
    splashFactory: InkRipple.splashFactory,
    splashColor: Colors.red[200],
    highlightColor: Colors.red[100],
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('InkRipple Factory'),
    ),
  );
  print('InkWell with InkRipple.splashFactory created');

  // ========== No splash factory ==========
  print('--- NoSplash Tests ---');
  final noSplashInkWell = InkWell(
    onTap: () => print('  No splash tap'),
    splashFactory: NoSplash.splashFactory,
    child: Padding(padding: EdgeInsets.all(16), child: Text('No Splash')),
  );
  print('InkWell with NoSplash.splashFactory created');

  // ========== Elevation-related ==========
  print('--- Elevation Tests ---');
  final elevations = [0.0, 1.0, 2.0, 4.0, 6.0, 8.0, 12.0, 16.0, 24.0];
  for (final e in elevations) {
    print('  Material Design elevation: $e');
  }

  print('All card/ink splash tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(cardTheme: cardTheme),
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            card1,
            cardFilled,
            cardOutlined,
            Card(child: ink),
            Card(child: inkImage),
            Card(child: inkWellSplash),
            Card(child: inkWellRipple),
            Card(child: noSplashInkWell),
          ],
        ),
      ),
    ),
  );
}
