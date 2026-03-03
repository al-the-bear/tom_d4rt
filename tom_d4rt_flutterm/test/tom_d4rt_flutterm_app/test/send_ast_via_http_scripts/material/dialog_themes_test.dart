// D4rt test script: Tests DialogTheme, BottomSheetTheme, BottomSheetThemeData, SnackBarTheme, SnackBarThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dialog themes test executing');

  // ========== DIALOG THEME ==========
  print('--- DialogTheme Tests ---');

  final dialogTheme = DialogTheme(
    backgroundColor: Colors.white,
    elevation: 24.0,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.blue.shade50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28.0),
    ),
    alignment: Alignment.center,
    titleTextStyle: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    contentTextStyle: TextStyle(
      fontSize: 16.0,
      color: Colors.black54,
    ),
    actionsPadding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 20.0),
    iconColor: Colors.blue,
  );
  print('DialogTheme created');
  print('  backgroundColor: ${dialogTheme.backgroundColor}');
  print('  elevation: ${dialogTheme.elevation}');
  print('  shadowColor: ${dialogTheme.shadowColor}');
  print('  surfaceTintColor: ${dialogTheme.surfaceTintColor}');
  print('  shape: ${dialogTheme.shape}');
  print('  alignment: ${dialogTheme.alignment}');
  print('  iconColor: ${dialogTheme.iconColor}');
  print('  actionsPadding: ${dialogTheme.actionsPadding}');

  // Test copyWith
  final copiedDialogTheme = dialogTheme.copyWith(
    backgroundColor: Colors.grey.shade50,
    elevation: 16.0,
  );
  print('DialogTheme.copyWith created');
  print('  new backgroundColor: ${copiedDialogTheme.backgroundColor}');
  print('  new elevation: ${copiedDialogTheme.elevation}');
  print('  shape preserved: ${copiedDialogTheme.shape}');

  // ========== BOTTOM SHEET THEME DATA ==========
  print('--- BottomSheetThemeData Tests ---');

  final bottomSheetThemeData = BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 8.0,
    shadowColor: Colors.black38,
    surfaceTintColor: Colors.grey.shade50,
    modalBackgroundColor: Colors.white,
    modalElevation: 16.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
    ),
    showDragHandle: true,
    dragHandleColor: Colors.grey.shade400,
    dragHandleSize: Size(32.0, 4.0),
    constraints: BoxConstraints(maxWidth: 640.0),
  );
  print('BottomSheetThemeData created');
  print('  backgroundColor: ${bottomSheetThemeData.backgroundColor}');
  print('  elevation: ${bottomSheetThemeData.elevation}');
  print('  modalBackgroundColor: ${bottomSheetThemeData.modalBackgroundColor}');
  print('  modalElevation: ${bottomSheetThemeData.modalElevation}');
  print('  showDragHandle: ${bottomSheetThemeData.showDragHandle}');
  print('  dragHandleColor: ${bottomSheetThemeData.dragHandleColor}');
  print('  dragHandleSize: ${bottomSheetThemeData.dragHandleSize}');
  print('  shape: ${bottomSheetThemeData.shape}');

  // Test copyWith
  final copiedBottomSheetTheme = bottomSheetThemeData.copyWith(
    backgroundColor: Colors.blue.shade50,
    showDragHandle: false,
  );
  print('BottomSheetThemeData.copyWith created');
  print('  new backgroundColor: ${copiedBottomSheetTheme.backgroundColor}');
  print('  new showDragHandle: ${copiedBottomSheetTheme.showDragHandle}');
  print('  elevation preserved: ${copiedBottomSheetTheme.elevation}');

  // ========== SNACK BAR THEME DATA ==========
  print('--- SnackBarThemeData Tests ---');

  final snackBarThemeData = SnackBarThemeData(
    backgroundColor: Colors.grey.shade800,
    actionTextColor: Colors.blue.shade200,
    disabledActionTextColor: Colors.grey,
    contentTextStyle: TextStyle(fontSize: 14.0, color: Colors.white),
    elevation: 6.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    behavior: SnackBarBehavior.floating,
    width: 400.0,
    insetPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    showCloseIcon: true,
    closeIconColor: Colors.white70,
    actionOverflowThreshold: 0.25,
    dismissDirection: DismissDirection.horizontal,
  );
  print('SnackBarThemeData created');
  print('  backgroundColor: ${snackBarThemeData.backgroundColor}');
  print('  actionTextColor: ${snackBarThemeData.actionTextColor}');
  print('  elevation: ${snackBarThemeData.elevation}');
  print('  behavior: ${snackBarThemeData.behavior}');
  print('  width: ${snackBarThemeData.width}');
  print('  showCloseIcon: ${snackBarThemeData.showCloseIcon}');
  print('  closeIconColor: ${snackBarThemeData.closeIconColor}');
  print('  dismissDirection: ${snackBarThemeData.dismissDirection}');
  print('  shape: ${snackBarThemeData.shape}');

  // Test copyWith
  final copiedSnackBarTheme = snackBarThemeData.copyWith(
    backgroundColor: Colors.black87,
    behavior: SnackBarBehavior.fixed,
  );
  print('SnackBarThemeData.copyWith created');
  print('  new backgroundColor: ${copiedSnackBarTheme.backgroundColor}');
  print('  new behavior: ${copiedSnackBarTheme.behavior}');
  print('  elevation preserved: ${copiedSnackBarTheme.elevation}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    dialogTheme: dialogTheme,
    bottomSheetTheme: bottomSheetThemeData,
    snackBarTheme: snackBarThemeData,
  );
  print('ThemeData with dialog themes created');

  return Theme(
    data: themeData,
    child: Builder(builder: (ctx) {
      final resolvedTheme = Theme.of(ctx);
      print('Theme.of resolved');
      print('  dialogTheme.elevation: ${resolvedTheme.dialogTheme.elevation}');
      print('  bottomSheetTheme.elevation: ${resolvedTheme.bottomSheetTheme.elevation}');
      print('  snackBarTheme.behavior: ${resolvedTheme.snackBarTheme.behavior}');

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Dialog: elevation=${dialogTheme.elevation}'),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('BottomSheet: showDragHandle=${bottomSheetThemeData.showDragHandle}'),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('SnackBar: behavior=${snackBarThemeData.behavior}'),
            ),
          ),
          Text('Dialog themes test passed'),
        ],
      );
    }),
  );
}
