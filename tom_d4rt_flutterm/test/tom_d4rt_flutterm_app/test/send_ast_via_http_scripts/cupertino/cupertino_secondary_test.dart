// D4rt test script: Tests CupertinoColors, CupertinoDynamicColor,
// CupertinoDialogAction, CupertinoActionSheetAction, CupertinoPopupSurface,
// CupertinoFormRow, CupertinoScrollbar, CupertinoListTileChevron
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino secondary widgets test executing');

  // ========== CupertinoColors ==========
  print('--- CupertinoColors Tests ---');

  print('CupertinoColors.activeBlue: ${CupertinoColors.activeBlue}');
  print('CupertinoColors.activeGreen: ${CupertinoColors.activeGreen}');
  print('CupertinoColors.activeOrange: ${CupertinoColors.activeOrange}');
  print('CupertinoColors.white: ${CupertinoColors.white}');
  print('CupertinoColors.black: ${CupertinoColors.black}');
  print(
    'CupertinoColors.lightBackgroundGray: ${CupertinoColors.lightBackgroundGray}',
  );
  print(
    'CupertinoColors.extraLightBackgroundGray: ${CupertinoColors.extraLightBackgroundGray}',
  );
  print(
    'CupertinoColors.darkBackgroundGray: ${CupertinoColors.darkBackgroundGray}',
  );
  print('CupertinoColors.inactiveGray: ${CupertinoColors.inactiveGray}');
  print('CupertinoColors.destructiveRed: ${CupertinoColors.destructiveRed}');

  // System colors
  print('CupertinoColors.systemBlue: ${CupertinoColors.systemBlue}');
  print('CupertinoColors.systemGreen: ${CupertinoColors.systemGreen}');
  print('CupertinoColors.systemIndigo: ${CupertinoColors.systemIndigo}');
  print('CupertinoColors.systemOrange: ${CupertinoColors.systemOrange}');
  print('CupertinoColors.systemPink: ${CupertinoColors.systemPink}');
  print('CupertinoColors.systemPurple: ${CupertinoColors.systemPurple}');
  print('CupertinoColors.systemRed: ${CupertinoColors.systemRed}');
  print('CupertinoColors.systemTeal: ${CupertinoColors.systemTeal}');
  print('CupertinoColors.systemYellow: ${CupertinoColors.systemYellow}');

  // ========== CupertinoDynamicColor ==========
  print('--- CupertinoDynamicColor Tests ---');

  final dynamicColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
  );
  print('CupertinoDynamicColor created');
  print('CupertinoDynamicColor color: ${dynamicColor.color}');
  print('CupertinoDynamicColor darkColor: ${dynamicColor.darkColor}');

  final dynamicFull = CupertinoDynamicColor(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
    highContrastColor: Color(0xFF111111),
    darkHighContrastColor: Color(0xFFEEEEEE),
    elevatedColor: Color(0xFF222222),
    darkElevatedColor: Color(0xFFDDDDDD),
    highContrastElevatedColor: Color(0xFF333333),
    darkHighContrastElevatedColor: Color(0xFFCCCCCC),
  );
  print('CupertinoDynamicColor full: color=${dynamicFull.color}');

  // ========== CupertinoDialogAction ==========
  print('--- CupertinoDialogAction Tests ---');

  final dialogAction = CupertinoDialogAction(
    child: Text('OK'),
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () => print('OK pressed'),
  );
  print(
    'CupertinoDialogAction isDefaultAction: ${dialogAction.isDefaultAction}',
  );
  print(
    'CupertinoDialogAction isDestructiveAction: ${dialogAction.isDestructiveAction}',
  );

  final destructiveAction = CupertinoDialogAction(
    child: Text('Delete'),
    isDefaultAction: false,
    isDestructiveAction: true,
    onPressed: () => print('Delete pressed'),
  );
  print(
    'CupertinoDialogAction destructive: ${destructiveAction.isDestructiveAction}',
  );

  // ========== CupertinoActionSheetAction ==========
  print('--- CupertinoActionSheetAction Tests ---');

  final actionSheetAction = CupertinoActionSheetAction(
    child: Text('Share'),
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () => print('Share pressed'),
  );
  print(
    'CupertinoActionSheetAction isDefaultAction: ${actionSheetAction.isDefaultAction}',
  );

  // ========== CupertinoFormRow ==========
  print('--- CupertinoFormRow Tests ---');

  final formRow = CupertinoFormRow(
    prefix: Text('Name'),
    helper: Text('Enter your name'),
    error: null,
    child: CupertinoTextField(placeholder: 'John Doe'),
  );
  print('CupertinoFormRow created');

  print('All cupertino secondary widgets tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Secondary Test'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CupertinoListSection(
                header: Text('Cupertino Colors'),
                children: [
                  CupertinoListTile(
                    title: Text('System Blue'),
                    trailing: Container(
                      width: 24.0,
                      height: 24.0,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                  CupertinoListTile(
                    title: Text('System Red'),
                    trailing: Container(
                      width: 24.0,
                      height: 24.0,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              formRow,
            ],
          ),
        ),
      ),
    ),
  );
}
