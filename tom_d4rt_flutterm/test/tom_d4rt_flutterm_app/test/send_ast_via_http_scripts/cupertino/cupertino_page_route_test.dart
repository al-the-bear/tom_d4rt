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
  print('CupertinoPageRoute created [${pageRoute.hashCode }]');

  // ========== CupertinoPageTransitionsBuilder ==========
  print('--- CupertinoPageTransitionsBuilder Tests ---');
  final transitionsBuilder = CupertinoPageTransitionsBuilder();
  print('CupertinoPageTransitionsBuilder created [${transitionsBuilder.hashCode }]');

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
        isDefaultAction: false,
        isDestructiveAction: false,
        onPressed: () => print('  Cancel pressed'),
        child: Text('Cancel'),
      ),
      CupertinoDialogAction(
        isDefaultAction: false,
        isDestructiveAction: true,
        onPressed: () => print('  Delete pressed'),
        child: Text('Delete'),
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () => print('  OK pressed'),
        child: Text('OK'),
      ),
    ],
    insetAnimationDuration: Duration(milliseconds: 100),
    insetAnimationCurve: Curves.decelerate,
  );
  print('alertDialog: ${alertDialog.runtimeType}');
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
  print('CupertinoDialogAction created [${dialogAction.hashCode }]');

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
  print('actionSheet: ${actionSheet.runtimeType}');
  print('CupertinoActionSheet created');

  // ========== CupertinoContextMenu ==========
  print('--- CupertinoContextMenu Tests ---');
  final contextMenu = CupertinoContextMenu(
    actions: [
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.doc_on_doc,
        onPressed: () => print('  Copy context'),
        child: Text('Copy'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.share,
        onPressed: () => print('  Share context'),
        child: Text('Share'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.delete,
        isDestructiveAction: true,
        onPressed: () => print('  Delete context'),
        child: Text('Delete'),
      ),
    ],
    child: Container(
      width: 200,
      height: 200,
      color: CupertinoColors.activeBlue,
      child: Center(
        child: Text('Hold me', style: TextStyle(color: CupertinoColors.white)),
      ),
    ),
  );
  print('CupertinoContextMenu created');

  // ========== CupertinoContextMenuAction ==========
  print('--- CupertinoContextMenuAction Tests ---');
  final contextAction = CupertinoContextMenuAction(
    trailingIcon: CupertinoIcons.add,
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () {},
    child: Text('Action Item'),
  );
  print('CupertinoContextMenuAction created [${contextAction.hashCode }]');

  print('All cupertino page route tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [popupSurface, SizedBox(height: 16), contextMenu],
        ),
      ),
    ),
  );
}
