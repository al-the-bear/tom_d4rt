// D4rt test script: Tests CupertinoAlertDialog, CupertinoActionSheet, CupertinoDialogAction from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino dialog test executing');

  // ========== CUPERTINOALERTDIALOG ==========
  print('--- CupertinoAlertDialog Tests ---');

  // Test basic CupertinoAlertDialog
  final basicDialog = CupertinoAlertDialog(
    title: Text('Alert'),
    content: Text('This is an alert message.'),
    actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {})],
  );
  print('Basic CupertinoAlertDialog created');

  // Test CupertinoAlertDialog with multiple actions
  final multiActionDialog = CupertinoAlertDialog(
    title: Text('Confirm'),
    content: Text('Are you sure you want to proceed?'),
    actions: [
      CupertinoDialogAction(child: Text('Cancel'), onPressed: () {}),
      CupertinoDialogAction(child: Text('Confirm'), onPressed: () {}),
    ],
  );
  print('CupertinoAlertDialog with multiple actions created [${multiActionDialog.hashCode }]');

  // Test CupertinoAlertDialog with destructive action
  final destructiveDialog = CupertinoAlertDialog(
    title: Text('Delete Item'),
    content: Text('This action cannot be undone.'),
    actions: [
      CupertinoDialogAction(child: Text('Cancel'), onPressed: () {}),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () {},
      ),
    ],
  );
  print('CupertinoAlertDialog with destructive action created');

  // Test CupertinoAlertDialog with default action
  final defaultActionDialog = CupertinoAlertDialog(
    title: Text('Save Changes'),
    content: Text('Do you want to save your changes?'),
    actions: [
      CupertinoDialogAction(child: Text("Don't Save"), onPressed: () {}),
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('Save'),
        onPressed: () {},
      ),
    ],
  );
  print('CupertinoAlertDialog with default action created [${defaultActionDialog.hashCode }]');

  // Test CupertinoAlertDialog with scrollable content
  final scrollableDialog = CupertinoAlertDialog(
    title: Text('Terms and Conditions'),
    content: SingleChildScrollView(
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
      ),
    ),
    actions: [
      CupertinoDialogAction(child: Text('Decline'), onPressed: () {}),
      CupertinoDialogAction(child: Text('Accept'), onPressed: () {}),
    ],
  );
  print('CupertinoAlertDialog with scrollable content created [${scrollableDialog.hashCode }]');

  // Test CupertinoAlertDialog without title
  final noTitleDialog = CupertinoAlertDialog(
    content: Text('Message without title'),
    actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {})],
  );
  print('CupertinoAlertDialog without title created [${noTitleDialog.hashCode }]');

  // Test CupertinoAlertDialog without content
  final noContentDialog = CupertinoAlertDialog(
    title: Text('Notification'),
    actions: [CupertinoDialogAction(child: Text('Dismiss'), onPressed: () {})],
  );
  print('CupertinoAlertDialog without content created [${noContentDialog.hashCode }]');

  // Test CupertinoAlertDialog with insetAnimationDuration
  final animatedDialog = CupertinoAlertDialog(
    insetAnimationDuration: Duration(milliseconds: 200),
    title: Text('Animated'),
    content: Text('With custom animation duration'),
    actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {})],
  );
  print('CupertinoAlertDialog with insetAnimationDuration created [${animatedDialog.hashCode }]');

  // Test CupertinoAlertDialog with insetAnimationCurve
  final curvedDialog = CupertinoAlertDialog(
    insetAnimationCurve: Curves.easeInOut,
    title: Text('Curved'),
    content: Text('With custom animation curve'),
    actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {})],
  );
  print('CupertinoAlertDialog with insetAnimationCurve created [${curvedDialog.hashCode }]');

  // ========== CUPERTINODIALOGACTION ==========
  print('--- CupertinoDialogAction Tests ---');

  // Test basic CupertinoDialogAction
  final basicAction = CupertinoDialogAction(
    child: Text('Action'),
    onPressed: () {
      print('Action pressed [${basicAction.hashCode }]');
    },
  );
  print('Basic CupertinoDialogAction created');

  // Test CupertinoDialogAction with isDefaultAction
  final defaultAction = CupertinoDialogAction(
    isDefaultAction: true,
    child: Text('Default'),
    onPressed: () {},
  );
  print('CupertinoDialogAction with isDefaultAction created [${defaultAction.hashCode }]');

  // Test CupertinoDialogAction with isDestructiveAction
  final destructiveAction = CupertinoDialogAction(
    isDestructiveAction: true,
    child: Text('Delete'),
    onPressed: () {},
  );
  print('CupertinoDialogAction with isDestructiveAction created [${destructiveAction.hashCode }]');

  // Test CupertinoDialogAction with textStyle
  final styledAction = CupertinoDialogAction(
    textStyle: TextStyle(fontSize: 18.0),
    child: Text('Styled'),
    onPressed: () {},
  );
  print('CupertinoDialogAction with textStyle created [${styledAction.hashCode }]');

  // Test CupertinoDialogAction disabled
  final disabledAction = CupertinoDialogAction(
    onPressed: null,
    child: Text('Disabled'),
  );
  print('CupertinoDialogAction disabled created [${disabledAction.hashCode }]');

  // ========== CUPERTINOACTIONSHEET ==========
  print('--- CupertinoActionSheet Tests ---');

  // Test basic CupertinoActionSheet
  final basicActionSheet = CupertinoActionSheet(
    actions: [
      CupertinoActionSheetAction(child: Text('Action 1'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Action 2'), onPressed: () {}),
    ],
  );
  print('Basic CupertinoActionSheet created [${basicActionSheet.hashCode }]');

  // Test CupertinoActionSheet with title
  final titledActionSheet = CupertinoActionSheet(
    title: Text('Select Option'),
    actions: [
      CupertinoActionSheetAction(child: Text('Option 1'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Option 2'), onPressed: () {}),
    ],
  );
  print('CupertinoActionSheet with title created [${titledActionSheet.hashCode }]');

  // Test CupertinoActionSheet with message
  final messageActionSheet = CupertinoActionSheet(
    title: Text('Share Photo'),
    message: Text('Choose how you want to share this photo'),
    actions: [
      CupertinoActionSheetAction(
        child: Text('Share to Instagram'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Share to Twitter'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(child: Text('Copy Link'), onPressed: () {}),
    ],
  );
  print('CupertinoActionSheet with message created [${messageActionSheet.hashCode }]');

  // Test CupertinoActionSheet with cancelButton
  final cancelButtonActionSheet = CupertinoActionSheet(
    title: Text('Options'),
    actions: [
      CupertinoActionSheetAction(child: Text('Save'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Share'), onPressed: () {}),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('CupertinoActionSheet with cancelButton created');

  // Test CupertinoActionSheet with destructive action
  final destructiveActionSheet = CupertinoActionSheet(
    title: Text('Delete Photo'),
    message: Text('This action cannot be undone'),
    actions: [
      CupertinoActionSheetAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () {},
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('CupertinoActionSheet with destructive action created [${destructiveActionSheet.hashCode }]');

  // Test CupertinoActionSheet with default action
  final defaultActionSheet = CupertinoActionSheet(
    title: Text('Save Document'),
    actions: [
      CupertinoActionSheetAction(
        isDefaultAction: true,
        child: Text('Save'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(child: Text('Save As...'), onPressed: () {}),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('CupertinoActionSheet with default action created [${defaultActionSheet.hashCode }]');

  // ========== CUPERTINOACTIONSHEETACTION ==========
  print('--- CupertinoActionSheetAction Tests ---');

  // Test basic CupertinoActionSheetAction
  final basicSheetAction = CupertinoActionSheetAction(
    child: Text('Action'),
    onPressed: () {
      print('Sheet action pressed [${basicSheetAction.hashCode }]');
    },
  );
  print('Basic CupertinoActionSheetAction created');

  // Test CupertinoActionSheetAction with isDefaultAction
  final defaultSheetAction = CupertinoActionSheetAction(
    isDefaultAction: true,
    child: Text('Default Action'),
    onPressed: () {},
  );
  print('CupertinoActionSheetAction with isDefaultAction created [${defaultSheetAction.hashCode }]');

  // Test CupertinoActionSheetAction with isDestructiveAction
  final destructiveSheetAction = CupertinoActionSheetAction(
    isDestructiveAction: true,
    child: Text('Delete'),
    onPressed: () {},
  );
  print('CupertinoActionSheetAction with isDestructiveAction created [${destructiveSheetAction.hashCode }]');

  // ========== CUPERTINOPOPUPSURFACE ==========
  print('--- CupertinoPopupSurface Tests ---');

  // Test basic CupertinoPopupSurface
  final basicPopupSurface = CupertinoPopupSurface(
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Popup content')),
  );
  print('Basic CupertinoPopupSurface created [${basicPopupSurface.hashCode }]');

  // Test CupertinoPopupSurface with isSurfacePainted
  final paintedPopupSurface = CupertinoPopupSurface(
    isSurfacePainted: true,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Painted surface'),
    ),
  );
  print('CupertinoPopupSurface with isSurfacePainted created');

  // Test CupertinoPopupSurface not painted
  final unpaintedPopupSurface = CupertinoPopupSurface(
    isSurfacePainted: false,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Unpainted surface'),
    ),
  );
  print('CupertinoPopupSurface with isSurfacePainted=false created [${unpaintedPopupSurface.hashCode }]');

  print('Cupertino dialog test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Dialog Tests')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Alert Dialog Preview:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: basicDialog,
              ),

              SizedBox(height: 24.0),
              Text(
                'Destructive Dialog Preview:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: destructiveDialog,
              ),

              SizedBox(height: 24.0),
              Text(
                'Action Sheet Preview:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: cancelButtonActionSheet,
              ),

              SizedBox(height: 24.0),
              Text(
                'Popup Surface Preview:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: paintedPopupSurface,
              ),

              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• CupertinoAlertDialog'),
              Text('• CupertinoDialogAction'),
              Text('• CupertinoActionSheet'),
              Text('• CupertinoActionSheetAction'),
              Text('• CupertinoPopupSurface'),
            ],
          ),
        ),
      ),
    ),
  );
}
