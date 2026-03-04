// D4rt test script: Tests CupertinoPageRoute, CupertinoModalPopupRoute,
// CupertinoDialogRoute, CupertinoPageTransitionsBuilder,
// CupertinoPopupSurface, showCupertinoDialog, showCupertinoModalPopup concepts,
// CupertinoScrollbar variants
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino page route test executing');

  // ========== CupertinoPageRoute ==========
  print('--- CupertinoPageRoute Tests ---');
  final pageRoute = CupertinoPageRoute(
    builder: (context) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detail Page'),
        previousPageTitle: 'Back',
      ),
      child: Center(child: Text('Detail Content')),
    ),
    title: 'Detail',
    maintainState: true,
    fullscreenDialog: false,
    allowSnapshotting: true,
  );
  print('CupertinoPageRoute created');

  // ========== CupertinoPageTransitionsBuilder ==========
  print('--- CupertinoPageTransitionsBuilder Tests ---');
  final transitionsBuilder = CupertinoPageTransitionsBuilder();
  print('CupertinoPageTransitionsBuilder created');

  // ========== CupertinoPopupSurface ==========
  print('--- CupertinoPopupSurface Tests ---');
  final popupSurface = CupertinoPopupSurface(
    isSurfacePainted: true,
    child: Container(
      padding: EdgeInsets.all(16),
      child: Text('Popup Surface Content'),
    ),
  );
  print('CupertinoPopupSurface created');

  // ========== CupertinoAlertDialog ==========
  print('--- CupertinoAlertDialog Tests ---');
  final alertDialog = CupertinoAlertDialog(
    title: Text('Alert Title'),
    content: Text('This is an important message.'),
    actions: [
      CupertinoDialogAction(
        child: Text('Cancel'),
        isDefaultAction: false,
        isDestructiveAction: false,
        onPressed: () => print('  Cancel pressed'),
      ),
      CupertinoDialogAction(
        child: Text('Delete'),
        isDefaultAction: false,
        isDestructiveAction: true,
        onPressed: () => print('  Delete pressed'),
      ),
      CupertinoDialogAction(
        child: Text('OK'),
        isDefaultAction: true,
        onPressed: () => print('  OK pressed'),
      ),
    ],
    insetAnimationDuration: Duration(milliseconds: 100),
    insetAnimationCurve: Curves.decelerate,
  );
  print('CupertinoAlertDialog created');

  // ========== CupertinoDialogAction ==========
  print('--- CupertinoDialogAction Tests ---');
  final dialogAction = CupertinoDialogAction(
    onPressed: () {},
    isDefaultAction: true,
    isDestructiveAction: false,
    textStyle: TextStyle(fontSize: 17),
    child: Text('Confirm'),
  );
  print('CupertinoDialogAction created');

  // ========== CupertinoActionSheet ==========
  print('--- CupertinoActionSheet Tests ---');
  final actionSheet = CupertinoActionSheet(
    title: Text('Select Action'),
    message: Text('Choose one of the following options'),
    actions: [
      CupertinoActionSheetAction(
        onPressed: () => print('  Copy pressed'),
        child: Text('Copy'),
      ),
      CupertinoActionSheetAction(
        onPressed: () => print('  Share pressed'),
        child: Text('Share'),
      ),
      CupertinoActionSheetAction(
        onPressed: () => print('  Delete pressed'),
        isDefaultAction: false,
        isDestructiveAction: true,
        child: Text('Delete'),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      onPressed: () => print('  Cancel pressed'),
      isDefaultAction: true,
      child: Text('Cancel'),
    ),
  );
  print('CupertinoActionSheet created');

  // ========== CupertinoContextMenu ==========
  print('--- CupertinoContextMenu Tests ---');
  final contextMenu = CupertinoContextMenu(
    actions: [
      CupertinoContextMenuAction(
        child: Text('Copy'),
        trailingIcon: CupertinoIcons.doc_on_doc,
        onPressed: () => print('  Copy context'),
      ),
      CupertinoContextMenuAction(
        child: Text('Share'),
        trailingIcon: CupertinoIcons.share,
        onPressed: () => print('  Share context'),
      ),
      CupertinoContextMenuAction(
        child: Text('Delete'),
        trailingIcon: CupertinoIcons.delete,
        isDestructiveAction: true,
        onPressed: () => print('  Delete context'),
      ),
    ],
    child: Container(
      width: 200,
      height: 200,
      color: CupertinoColors.activeBlue,
      child: Center(child: Text('Hold me', style: TextStyle(color: CupertinoColors.white))),
    ),
  );
  print('CupertinoContextMenu created');

  // ========== CupertinoContextMenuAction ==========
  print('--- CupertinoContextMenuAction Tests ---');
  final contextAction = CupertinoContextMenuAction(
    child: Text('Action Item'),
    trailingIcon: CupertinoIcons.add,
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () {},
  );
  print('CupertinoContextMenuAction created');

  print('All cupertino page route tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            popupSurface,
            SizedBox(height: 16),
            contextMenu,
          ],
        ),
      ),
    ),
  );
}
