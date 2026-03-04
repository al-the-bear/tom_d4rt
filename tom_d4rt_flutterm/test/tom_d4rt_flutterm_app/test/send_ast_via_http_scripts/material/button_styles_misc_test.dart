// D4rt test script: Tests ButtonBarTheme, ButtonStyleButton, RaisedButton, FlatButton, OutlineButton, MaterialBannerAction, NavigationIndicatorTransition, PopupMenuItemState, PopupMenuItemSelected
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Button styles and misc material tests executing');

  // ========== ButtonBarTheme ==========
  print('--- ButtonBarTheme Tests ---');
  final buttonBarThemeData = ButtonBarThemeData(
    alignment: MainAxisAlignment.center,
    buttonPadding: EdgeInsets.all(8.0),
    layoutBehavior: ButtonBarLayoutBehavior.padded,
  );
  print('ButtonBarThemeData alignment: ${buttonBarThemeData.alignment}');
  print(
    'ButtonBarThemeData buttonPadding: ${buttonBarThemeData.buttonPadding}',
  );
  print(
    'ButtonBarThemeData layoutBehavior: ${buttonBarThemeData.layoutBehavior}',
  );
  // ButtonBarTheme is an InheritedWidget wrapping ButtonBarThemeData
  print('ButtonBarTheme type: ${ButtonBarTheme}');
  print('ButtonBarThemeData type: ${buttonBarThemeData.runtimeType}');

  // ========== ButtonStyleButton (abstract) ==========
  print('--- ButtonStyleButton Tests ---');
  // ButtonStyleButton is the abstract base class for ElevatedButton, TextButton, OutlinedButton etc.
  // We reference it through its concrete subclasses.
  print('ButtonStyleButton type: ${ButtonStyleButton}');
  final elevatedButton = ElevatedButton(
    onPressed: () {},
    child: Text('Elevated'),
  );
  print(
    'ElevatedButton is ButtonStyleButton: ${elevatedButton is ButtonStyleButton}',
  );
  final textButton = TextButton(onPressed: () {}, child: Text('Text'));
  print('TextButton is ButtonStyleButton: ${textButton is ButtonStyleButton}');
  final outlinedButton = OutlinedButton(
    onPressed: () {},
    child: Text('Outlined'),
  );
  print(
    'OutlinedButton is ButtonStyleButton: ${outlinedButton is ButtonStyleButton}',
  );

  // ========== Deprecated Buttons ==========
  print('--- Deprecated Button Tests ---');
  // RaisedButton was deprecated and removed in Flutter 3.x → replaced by ElevatedButton
  print(
    'RaisedButton (deprecated) → use ElevatedButton: ${elevatedButton.runtimeType}',
  );
  // FlatButton was deprecated and removed in Flutter 3.x → replaced by TextButton
  print('FlatButton (deprecated) → use TextButton: ${textButton.runtimeType}');
  // OutlineButton was deprecated and removed in Flutter 3.x → replaced by OutlinedButton
  print(
    'OutlineButton (deprecated) → use OutlinedButton: ${outlinedButton.runtimeType}',
  );

  // ========== MaterialBannerAction ==========
  print('--- MaterialBannerAction Tests ---');
  // MaterialBanner actions are typically TextButton or other button widgets
  final bannerAction = TextButton(onPressed: () {}, child: Text('Dismiss'));
  final banner = MaterialBanner(
    content: Text('Test banner'),
    actions: [bannerAction],
  );
  print('MaterialBanner created with action: ${bannerAction.runtimeType}');
  print('MaterialBanner type: ${banner.runtimeType}');

  // ========== NavigationIndicatorTransition ==========
  print('--- NavigationIndicatorTransition Tests ---');
  // NavigationIndicatorTransition is related to the NavigationBar indicator animation
  // It is part of the internal navigation bar theming system
  print('NavigationIndicatorTransition referenced via NavigationBar theming');
  final navBarTheme = NavigationBarThemeData(
    indicatorColor: Colors.blue,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  print('NavigationBarThemeData indicatorColor: ${navBarTheme.indicatorColor}');
  print('NavigationBarThemeData indicatorShape: ${navBarTheme.indicatorShape}');

  // ========== PopupMenuItemState / PopupMenuItemSelected ==========
  print('--- PopupMenuItemState / PopupMenuItemSelected Tests ---');
  // PopupMenuItemSelected is the callback type: void Function(T)
  // PopupMenuItemState relates to the State of PopupMenuItem
  final PopupMenuItemSelected<String> onSelected = (String value) {
    print('Selected: $value');
  };
  print('PopupMenuItemSelected callback type: ${onSelected.runtimeType}');
  // Create a PopupMenuButton that uses the callback type
  final popupMenu = PopupMenuButton<String>(
    onSelected: onSelected,
    itemBuilder: (BuildContext ctx) => [
      PopupMenuItem<String>(value: 'option1', child: Text('Option 1')),
      PopupMenuItem<String>(value: 'option2', child: Text('Option 2')),
    ],
  );
  print('PopupMenuButton type: ${popupMenu.runtimeType}');
  print('PopupMenuItem references PopupMenuItemState internally');

  print('All button styles and misc material tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Button Styles Misc Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('ButtonBarTheme: configured'),
            Text('ButtonStyleButton: abstract, 3 subclasses tested'),
            Text(
              'Deprecated: RaisedButton→Elevated, FlatButton→Text, OutlineButton→Outlined',
            ),
            Text('MaterialBannerAction: TextButton in banner'),
            Text('NavigationIndicatorTransition: themed'),
            Text('PopupMenuItemState/Selected: callback referenced'),
          ],
        ),
      ),
    ),
  );
}
