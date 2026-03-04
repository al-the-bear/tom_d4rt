// D4rt test script: Tests CupertinoSwitch, CupertinoSlider,
// CupertinoActivityIndicator, CupertinoSearchTextField
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino controls advanced test executing');

  // ========== CupertinoSwitch ==========
  print('--- CupertinoSwitch Tests ---');
  final cupertinoSwitch = CupertinoSwitch(
    value: true,
    onChanged: (bool value) => print('Switch: $value'),
    activeColor: CupertinoColors.activeGreen,
    trackColor: CupertinoColors.systemGrey4,
    thumbColor: CupertinoColors.white,
  );
  print('CupertinoSwitch created: value=true');

  final offSwitch = CupertinoSwitch(
    value: false,
    onChanged: (v) {},
  );
  print('CupertinoSwitch off created');

  // ========== CupertinoSlider ==========
  print('--- CupertinoSlider Tests ---');
  final slider = CupertinoSlider(
    value: 0.5,
    min: 0.0,
    max: 1.0,
    divisions: 10,
    activeColor: CupertinoColors.activeBlue,
    thumbColor: CupertinoColors.white,
    onChanged: (double value) => print('Slider: $value'),
    onChangeStart: (double value) => print('Slider start: $value'),
    onChangeEnd: (double value) => print('Slider end: $value'),
  );
  print('CupertinoSlider created: value=0.5, divisions=10');

  // ========== CupertinoActivityIndicator ==========
  print('--- CupertinoActivityIndicator Tests ---');
  final indicator = CupertinoActivityIndicator(
    radius: 15.0,
    color: CupertinoColors.activeBlue,
    animating: true,
  );
  print('CupertinoActivityIndicator created: radius=15');

  final partialIndicator = CupertinoActivityIndicator.partiallyRevealed(
    radius: 15.0,
    progress: 0.7,
  );
  print('CupertinoActivityIndicator.partiallyRevealed: 0.7');

  // ========== CupertinoSearchTextField ==========
  print('--- CupertinoSearchTextField Tests ---');
  final searchField = CupertinoSearchTextField(
    placeholder: 'Search...',
    onChanged: (String value) => print('Search: $value'),
    onSubmitted: (String value) => print('Submit: $value'),
    autocorrect: false,
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    prefixIcon: Icon(CupertinoIcons.search, size: 20.0),
    suffixIcon: Icon(CupertinoIcons.xmark_circle_fill, size: 18.0),
    suffixMode: OverlayVisibilityMode.editing,
    style: TextStyle(fontSize: 16.0),
    borderRadius: BorderRadius.circular(8.0),
    backgroundColor: CupertinoColors.systemGrey6,
  );
  print('CupertinoSearchTextField created');

  // ========== OverlayVisibilityMode ==========
  print('--- OverlayVisibilityMode Tests ---');
  for (final mode in OverlayVisibilityMode.values) {
    print('OverlayVisibilityMode: ${mode.name}');
  }

  print('All cupertino controls tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Controls Test'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              searchField,
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Switch:'),
                  cupertinoSwitch,
                ],
              ),
              SizedBox(height: 16.0),
              slider,
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [indicator, partialIndicator],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
