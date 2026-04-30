// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Dialog, AlertDialog, SimpleDialog, BottomSheet, SnackBar from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dialog/Overlay widgets test executing');

  // ========== DIALOG ==========
  print('--- Dialog Tests ---');

  // Test basic Dialog
  final basicDialog = Dialog(
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Basic Dialog')),
  );
  print('Basic Dialog created');

  // Test Dialog with backgroundColor
  final coloredDialog = Dialog(
    backgroundColor: Colors.lightBlue.shade50,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Colored Dialog'),
    ),
  );
  print('Dialog with backgroundColor created: $coloredDialog');

  // Test Dialog with elevation
  final elevatedDialog = Dialog(
    elevation: 24.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Elevated Dialog'),
    ),
  );
  print('Dialog with elevation created: $elevatedDialog');

  // Test Dialog with shape
  final shapedDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Rounded Dialog'),
    ),
  );
  print('Dialog with shape created: $shapedDialog');

  // Test Dialog with insetPadding
  final insetDialog = Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Inset Dialog')),
  );
  print('Dialog with insetPadding created: $insetDialog');

  // Test Dialog.fullscreen
  final fullscreenDialog = Dialog.fullscreen(
    child: Center(child: Text('Fullscreen Dialog')),
  );
  print('Dialog.fullscreen created: $fullscreenDialog');

  // ========== ALERTDIALOG ==========
  print('--- AlertDialog Tests ---');

  // Test basic AlertDialog
  final basicAlert = AlertDialog(
    title: Text('Alert'),
    content: Text('This is an alert dialog.'),
  );
  print('Basic AlertDialog created: $basicAlert');

  // Test AlertDialog with actions
  final actionAlert = AlertDialog(
    title: Text('Confirm'),
    content: Text('Are you sure?'),
    actions: [
      TextButton(
        onPressed: () {
          print('Cancel pressed');
        },
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          print('OK pressed');
        },
        child: Text('OK'),
      ),
    ],
  );
  print('AlertDialog with actions created');

  // Test AlertDialog with icon
  final iconAlert = AlertDialog(
    icon: Icon(Icons.warning, color: Colors.orange, size: 48.0),
    title: Text('Warning'),
    content: Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () {}, child: Text('Cancel')),
      TextButton(onPressed: () {}, child: Text('Delete')),
    ],
  );
  print('AlertDialog with icon created: $iconAlert');

  // Test AlertDialog with backgroundColor
  final coloredAlert = AlertDialog(
    backgroundColor: Colors.amber.shade50,
    title: Text('Colored'),
    content: Text('Custom background color'),
  );
  print('AlertDialog with backgroundColor created: $coloredAlert');

  // Test AlertDialog with shape
  final shapedAlert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    title: Text('Rounded'),
    content: Text('Rounded corners'),
  );
  print('AlertDialog with shape created: $shapedAlert');

  // Test AlertDialog with elevation
  final elevatedAlert = AlertDialog(
    elevation: 32.0,
    title: Text('Elevated'),
    content: Text('High elevation'),
  );
  print('AlertDialog with elevation created: $elevatedAlert');

  // Test AlertDialog with titlePadding
  final paddedAlert = AlertDialog(
    titlePadding: EdgeInsets.all(24.0),
    contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    actionsPadding: EdgeInsets.all(8.0),
    title: Text('Custom Padding'),
    content: Text('Custom padding values'),
    actions: [TextButton(onPressed: () {}, child: Text('OK'))],
  );
  print('AlertDialog with custom padding created: $paddedAlert');

  // Test AlertDialog with actionsAlignment
  final alignedActionsAlert = AlertDialog(
    title: Text('Actions Alignment'),
    content: Text('Actions are centered'),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      TextButton(onPressed: () {}, child: Text('A')),
      TextButton(onPressed: () {}, child: Text('B')),
    ],
  );
  print('AlertDialog with actionsAlignment created: $alignedActionsAlert');

  // Test AlertDialog with scrollable content
  final scrollableAlert = AlertDialog(
    title: Text('Scrollable'),
    content: SingleChildScrollView(
      child: Column(children: List.generate(10, (i) => Text('Item $i'))),
    ),
    actions: [TextButton(onPressed: () {}, child: Text('Close'))],
  );
  print('AlertDialog with scrollable content created: $scrollableAlert');

  // ========== SIMPLEDIALOG ==========
  print('--- SimpleDialog Tests ---');

  // Test basic SimpleDialog
  final basicSimple = SimpleDialog(
    title: Text('Select'),
    children: [
      SimpleDialogOption(
        child: Text('Option 1'),
        onPressed: () {
          print('Option 1 selected');
        },
      ),
      SimpleDialogOption(
        child: Text('Option 2'),
        onPressed: () {
          print('Option 2 selected');
        },
      ),
    ],
  );
  print('Basic SimpleDialog created');

  // Test SimpleDialog with backgroundColor
  final coloredSimple = SimpleDialog(
    backgroundColor: Colors.green.shade50,
    title: Text('Colored'),
    children: [
      SimpleDialogOption(child: Text('A')),
      SimpleDialogOption(child: Text('B')),
    ],
  );
  print('SimpleDialog with backgroundColor created: $coloredSimple');

  // Test SimpleDialog with shape
  final shapedSimple = SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    title: Text('Rounded'),
    children: [SimpleDialogOption(child: Text('Option'))],
  );
  print('SimpleDialog with shape created: $shapedSimple');

  // ========== BOTTOMSHEET ==========
  print('--- BottomSheet Tests ---');

  // Test basic BottomSheet
  final basicBottomSheet = BottomSheet(
    onClosing: () {
      print('BottomSheet closing');
    },
    builder: (BuildContext context) {
      return Container(
        height: 200.0,
        padding: EdgeInsets.all(16.0),
        child: Text('Bottom Sheet Content'),
      );
    },
  );
  print('Basic BottomSheet created: $basicBottomSheet');

  // Test BottomSheet with backgroundColor
  final coloredBottomSheet = BottomSheet(
    backgroundColor: Colors.purple.shade50,
    onClosing: () {},
    builder: (context) {
      return SizedBox(
        height: 150.0,
        child: Center(child: Text('Colored BottomSheet')),
      );
    },
  );
  print('BottomSheet with backgroundColor created: $coloredBottomSheet');

  // Test BottomSheet with elevation
  final elevatedBottomSheet = BottomSheet(
    elevation: 16.0,
    onClosing: () {},
    builder: (context) {
      return SizedBox(
        height: 150.0,
        child: Center(child: Text('Elevated BottomSheet')),
      );
    },
  );
  print('BottomSheet with elevation created: $elevatedBottomSheet');

  // Test BottomSheet with shape
  final shapedBottomSheet = BottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    onClosing: () {},
    builder: (context) {
      return SizedBox(
        height: 150.0,
        child: Center(child: Text('Rounded BottomSheet')),
      );
    },
  );
  print('BottomSheet with shape created');

  // Test BottomSheet with clipBehavior
  final clippedBottomSheet = BottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    onClosing: () {},
    builder: (context) {
      return Container(
        height: 150.0,
        color: Colors.blue,
        child: Center(
          child: Text('Clipped', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('BottomSheet with clipBehavior created: $clippedBottomSheet');

  // Test BottomSheet enableDrag
  final draggableBottomSheet = BottomSheet(
    enableDrag: true,
    onClosing: () {},
    builder: (context) {
      return SizedBox(
        height: 150.0,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(child: Center(child: Text('Drag to close'))),
          ],
        ),
      );
    },
  );
  print('BottomSheet enableDrag created: $draggableBottomSheet');

  // ========== SNACKBAR ==========
  print('--- SnackBar Tests ---');

  // Test basic SnackBar
  final basicSnackBar = SnackBar(content: Text('This is a snack bar'));
  print('Basic SnackBar created: $basicSnackBar');

  // Test SnackBar with action
  final actionSnackBar = SnackBar(
    content: Text('Item deleted'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        print('Undo pressed');
      },
    ),
  );
  print('SnackBar with action created: $actionSnackBar');

  // Test SnackBar with duration
  final longSnackBar = SnackBar(
    content: Text('Long duration'),
    duration: Duration(seconds: 10),
  );
  print('SnackBar with long duration created: $longSnackBar');

  // Test SnackBar with backgroundColor
  final coloredSnackBar = SnackBar(
    content: Text('Success!'),
    backgroundColor: Colors.green,
  );
  print('SnackBar with backgroundColor created: $coloredSnackBar');

  // Test SnackBar with behavior
  final floatingSnackBar = SnackBar(
    content: Text('Floating snack bar'),
    behavior: SnackBarBehavior.floating,
  );
  print('SnackBar with floating behavior created: $floatingSnackBar');

  // Test SnackBar with margin
  final marginedSnackBar = SnackBar(
    content: Text('With margin'),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(16.0),
  );
  print('SnackBar with margin created: $marginedSnackBar');

  // Test SnackBar with shape
  final shapedSnackBar = SnackBar(
    content: Text('Rounded snack bar'),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  );
  print('SnackBar with shape created: $shapedSnackBar');

  // Test SnackBar with elevation
  final elevatedSnackBar = SnackBar(content: Text('Elevated'), elevation: 8.0);
  print('SnackBar with elevation created: $elevatedSnackBar');

  // Test SnackBar with padding
  final paddedSnackBar = SnackBar(
    content: Text('Padded content'),
    padding: EdgeInsets.all(24.0),
  );
  print('SnackBar with padding created: $paddedSnackBar');

  // Test SnackBar with width
  final widthSnackBar = SnackBar(
    content: Text('Fixed width'),
    behavior: SnackBarBehavior.floating,
    width: 300.0,
  );
  print('SnackBar with width created: $widthSnackBar');

  // Test SnackBar with onVisible
  final onVisibleSnackBar = SnackBar(
    content: Text('Visible callback'),
    onVisible: () {
      print('SnackBar is now visible');
    },
  );
  print('SnackBar with onVisible created: $onVisibleSnackBar');

  // Test SnackBar with dismissDirection
  final dismissSnackBar = SnackBar(
    content: Text('Swipe to dismiss'),
    dismissDirection: DismissDirection.horizontal,
  );
  print('SnackBar with dismissDirection created: $dismissSnackBar');

  // Test SnackBar with showCloseIcon
  final closeIconSnackBar = SnackBar(
    content: Text('With close icon'),
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );
  print('SnackBar with showCloseIcon created: $closeIconSnackBar');

  print('Dialog/Overlay widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dialog & Overlay Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Dialog:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150, child: basicDialog),
        SizedBox(height: 8.0),

        Text('AlertDialog:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200, child: actionAlert),
        SizedBox(height: 8.0),

        Text('SimpleDialog:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200, child: basicSimple),
        SizedBox(height: 8.0),

        Text('BottomSheet:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200, child: shapedBottomSheet),
        SizedBox(height: 8.0),

        Text(
          'SnackBar (preview):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          color: Colors.grey.shade800,
          padding: EdgeInsets.all(16.0),
          child: Text(
            'SnackBars are shown via ScaffoldMessenger',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
