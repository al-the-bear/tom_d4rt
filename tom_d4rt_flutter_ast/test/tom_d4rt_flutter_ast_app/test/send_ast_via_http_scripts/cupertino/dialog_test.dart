// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Cupertino dialog widgets from cupertino library
// Deep Demo: Visual demonstration of CupertinoAlertDialog, CupertinoDialogAction,
// CupertinoActionSheet, CupertinoActionSheetAction, and CupertinoPopupSurface
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino Dialog Deep Demo executing');

  // ============================================================
  // SECTION 1: Cupertino Dialog Family Overview
  // ============================================================
  print('=== Section 1: Cupertino Dialog Family Overview ===');

  final overviewCards = <Widget>[];

  // Overview card 1 - CupertinoAlertDialog
  overviewCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            CupertinoIcons.exclamationmark_circle,
            size: 44.0,
            color: Colors.blue.shade700,
          ),
          SizedBox(height: 12.0),
          Text(
            'CupertinoAlertDialog',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'iOS-style modal alert with\ntitle, content and actions',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.blue.shade700),
          ),
        ],
      ),
    ),
  );

  // Overview card 2 - CupertinoActionSheet
  overviewCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            CupertinoIcons.square_list,
            size: 44.0,
            color: Colors.orange.shade700,
          ),
          SizedBox(height: 12.0),
          Text(
            'CupertinoActionSheet',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Bottom-sheet style chooser\nwith optional cancel button',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.orange.shade800),
          ),
        ],
      ),
    ),
  );

  // Overview card 3 - CupertinoPopupSurface
  overviewCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            CupertinoIcons.rectangle_stack,
            size: 44.0,
            color: Colors.purple.shade700,
          ),
          SizedBox(height: 12.0),
          Text(
            'CupertinoPopupSurface',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Translucent rounded panel\nused under custom popups',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.purple.shade800),
          ),
        ],
      ),
    ),
  );

  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: CupertinoAlertDialog Variants
  // ============================================================
  print('=== Section 2: CupertinoAlertDialog Variants ===');

  // Variant 2A: Single OK action
  final basicAlertDialog = CupertinoAlertDialog(
    title: Text('Alert'),
    content: Text('This is a simple iOS alert message.'),
    actions: [
      CupertinoDialogAction(child: Text('OK'), onPressed: () {}),
    ],
  );
  print('Variant 2A: basic single-action alert created');

  // Variant 2B: Cancel + Confirm
  final confirmAlertDialog = CupertinoAlertDialog(
    title: Text('Confirm Action'),
    content: Text('Are you sure you want to proceed?'),
    actions: [
      CupertinoDialogAction(child: Text('Cancel'), onPressed: () {}),
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('Confirm'),
        onPressed: () {},
      ),
    ],
  );
  print('Variant 2B: confirm alert with default action created');

  // Variant 2C: Three actions
  final tripleAlertDialog = CupertinoAlertDialog(
    title: Text('Unsaved Changes'),
    content: Text('Do you want to save, discard, or keep editing?'),
    actions: [
      CupertinoDialogAction(child: Text('Keep Editing'), onPressed: () {}),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text('Discard'),
        onPressed: () {},
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('Save'),
        onPressed: () {},
      ),
    ],
  );
  print('Variant 2C: triple-action alert created');

  // Variant 2D: Scrollable content
  final scrollableAlertDialog = CupertinoAlertDialog(
    title: Text('Terms and Conditions'),
    content: SingleChildScrollView(
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
        'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
        'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla '
        'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in '
        'culpa qui officia deserunt mollit anim id est laborum.',
      ),
    ),
    actions: [
      CupertinoDialogAction(child: Text('Decline'), onPressed: () {}),
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('Accept'),
        onPressed: () {},
      ),
    ],
  );
  print('Variant 2D: scrollable terms alert created');

  // Variant 2E: No title, content only
  final noTitleAlertDialog = CupertinoAlertDialog(
    content: Text('Your changes have been saved.'),
    actions: [
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('Dismiss'),
        onPressed: () {},
      ),
    ],
  );
  print('Variant 2E: no-title alert created');

  // Variant 2F: Custom inset animation duration / curve
  final animatedAlertDialog = CupertinoAlertDialog(
    insetAnimationDuration: Duration(milliseconds: 220),
    insetAnimationCurve: Curves.easeInOut,
    title: Text('Custom Animation'),
    content: Text('This alert uses a custom inset animation.'),
    actions: [
      CupertinoDialogAction(child: Text('OK'), onPressed: () {}),
    ],
  );
  print('Variant 2F: animated alert created');

  final alertVariants = <Map<String, dynamic>>[
    {
      'label': 'Single OK Action',
      'desc': 'Title + content + one button',
      'dialog': basicAlertDialog,
      'accent': Colors.blue,
      'icon': CupertinoIcons.checkmark_circle,
    },
    {
      'label': 'Cancel / Confirm',
      'desc': 'Two actions, Confirm is default (bold)',
      'dialog': confirmAlertDialog,
      'accent': Colors.green,
      'icon': CupertinoIcons.question_circle,
    },
    {
      'label': 'Three Actions',
      'desc': 'Default + destructive + neutral',
      'dialog': tripleAlertDialog,
      'accent': Colors.deepOrange,
      'icon': CupertinoIcons.exclamationmark_triangle,
    },
    {
      'label': 'Scrollable Content',
      'desc': 'Long body wrapped in SingleChildScrollView',
      'dialog': scrollableAlertDialog,
      'accent': Colors.indigo,
      'icon': CupertinoIcons.doc_text,
    },
    {
      'label': 'Content Only',
      'desc': 'Title omitted, message-driven dialog',
      'dialog': noTitleAlertDialog,
      'accent': Colors.teal,
      'icon': CupertinoIcons.info_circle,
    },
    {
      'label': 'Custom Inset Animation',
      'desc': 'insetAnimationDuration & insetAnimationCurve',
      'dialog': animatedAlertDialog,
      'accent': Colors.purple,
      'icon': CupertinoIcons.bolt,
    },
  ];

  final alertVariantWidgets = <Widget>[];
  for (int i = 0; i < alertVariants.length; i++) {
    final entry = alertVariants[i];
    final accent = entry['accent'] as Color;
    alertVariantWidgets.add(
      Container(
        width: 360.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.18),
              blurRadius: 12.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header strip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: accent,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Icon(entry['icon'] as IconData, size: 20.0, color: accent),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry['label'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: accent,
                            fontSize: 13.0,
                          ),
                        ),
                        Text(
                          entry['desc'] as String,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Dialog preview
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: entry['dialog'] as Widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${alertVariantWidgets.length} alert variant cards');

  // ============================================================
  // SECTION 3: CupertinoDialogAction States
  // ============================================================
  print('=== Section 3: CupertinoDialogAction States ===');

  final actionStates = <Map<String, dynamic>>[
    {
      'name': 'Default',
      'desc': 'Plain action button',
      'action': CupertinoDialogAction(child: Text('OK'), onPressed: () {}),
      'color': Colors.blue,
      'icon': CupertinoIcons.checkmark,
    },
    {
      'name': 'isDefaultAction',
      'desc': 'Bold text, primary CTA',
      'action': CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('Confirm'),
        onPressed: () {},
      ),
      'color': Colors.green,
      'icon': CupertinoIcons.star_fill,
    },
    {
      'name': 'isDestructiveAction',
      'desc': 'Red text for destructive operations',
      'action': CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () {},
      ),
      'color': Colors.red,
      'icon': CupertinoIcons.trash,
    },
    {
      'name': 'Custom textStyle',
      'desc': 'Override text style explicitly',
      'action': CupertinoDialogAction(
        textStyle: TextStyle(
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
          color: CupertinoColors.systemPurple,
        ),
        child: Text('Stylish'),
        onPressed: () {},
      ),
      'color': Colors.purple,
      'icon': CupertinoIcons.paintbrush,
    },
    {
      'name': 'Disabled (onPressed: null)',
      'desc': 'Greyed out, not tappable',
      'action': CupertinoDialogAction(
        onPressed: null,
        child: Text('Disabled'),
      ),
      'color': Colors.grey,
      'icon': CupertinoIcons.nosign,
    },
  ];

  final actionStateWidgets = <Widget>[];
  for (final entry in actionStates) {
    final accent = entry['color'] as Color;
    actionStateWidgets.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.5),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(entry['icon'] as IconData, color: accent, size: 20.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    entry['name'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accent,
                      fontSize: 12.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Text(
              entry['desc'] as String,
              style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: accent.withValues(alpha: 0.3)),
              ),
              child: entry['action'] as Widget,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${actionStateWidgets.length} action state cards');

  // ============================================================
  // SECTION 4: CupertinoActionSheet Variants
  // ============================================================
  print('=== Section 4: CupertinoActionSheet Variants ===');

  // Sheet 4A: Plain actions only
  final plainSheet = CupertinoActionSheet(
    actions: [
      CupertinoActionSheetAction(child: Text('Option A'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Option B'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Option C'), onPressed: () {}),
    ],
  );
  print('Sheet 4A: plain action sheet created');

  // Sheet 4B: Title only
  final titledSheet = CupertinoActionSheet(
    title: Text('Select Option'),
    actions: [
      CupertinoActionSheetAction(child: Text('Option 1'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Option 2'), onPressed: () {}),
    ],
  );
  print('Sheet 4B: titled action sheet created');

  // Sheet 4C: Title + message + cancel
  final shareSheet = CupertinoActionSheet(
    title: Text('Share Photo'),
    message: Text('Choose where to share this photo'),
    actions: [
      CupertinoActionSheetAction(
        child: Text('Share to Messages'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Share to Mail'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Copy Link'),
        onPressed: () {},
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('Sheet 4C: share sheet with cancel created');

  // Sheet 4D: With destructive action
  final destructiveSheet = CupertinoActionSheet(
    title: Text('Delete Photo?'),
    message: Text('This action cannot be undone.'),
    actions: [
      CupertinoActionSheetAction(
        isDestructiveAction: true,
        child: Text('Delete Photo'),
        onPressed: () {},
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      isDefaultAction: true,
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('Sheet 4D: destructive action sheet created');

  // Sheet 4E: Default action highlighted
  final defaultActionSheet = CupertinoActionSheet(
    title: Text('Save Document'),
    actions: [
      CupertinoActionSheetAction(
        isDefaultAction: true,
        child: Text('Save'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Save As...'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Export'),
        onPressed: () {},
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('Sheet 4E: default action sheet created');

  final sheetVariants = <Map<String, dynamic>>[
    {
      'label': 'Actions Only',
      'desc': 'No title/message - just buttons',
      'sheet': plainSheet,
      'accent': Colors.blue,
      'icon': CupertinoIcons.list_bullet,
    },
    {
      'label': 'With Title',
      'desc': 'Title above the action list',
      'sheet': titledSheet,
      'accent': Colors.teal,
      'icon': CupertinoIcons.text_alignleft,
    },
    {
      'label': 'Title + Message + Cancel',
      'desc': 'Share-style action sheet',
      'sheet': shareSheet,
      'accent': Colors.orange,
      'icon': CupertinoIcons.share,
    },
    {
      'label': 'Destructive Sheet',
      'desc': 'Single destructive action + cancel',
      'sheet': destructiveSheet,
      'accent': Colors.red,
      'icon': CupertinoIcons.trash,
    },
    {
      'label': 'Default + Multiple Options',
      'desc': 'Save-style sheet with default CTA',
      'sheet': defaultActionSheet,
      'accent': Colors.green,
      'icon': CupertinoIcons.floppy_disk,
    },
  ];

  final sheetVariantWidgets = <Widget>[];
  for (int i = 0; i < sheetVariants.length; i++) {
    final entry = sheetVariants[i];
    final accent = entry['accent'] as Color;
    sheetVariantWidgets.add(
      Container(
        width: 360.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.15),
              blurRadius: 10.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Icon(entry['icon'] as IconData, color: accent, size: 20.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry['label'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: accent,
                            fontSize: 13.0,
                          ),
                        ),
                        Text(
                          entry['desc'] as String,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: entry['sheet'] as Widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${sheetVariantWidgets.length} sheet variant cards');

  // ============================================================
  // SECTION 5: Real-World Examples
  // ============================================================
  print('=== Section 5: Real-World Examples ===');

  // Example A: Confirm Delete
  final confirmDeleteExample = CupertinoAlertDialog(
    title: Text('Delete Item?'),
    content: Text(
      'This item will be removed permanently from your library.',
    ),
    actions: [
      CupertinoDialogAction(child: Text('Cancel'), onPressed: () {}),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () {},
      ),
    ],
  );

  // Example B: Sign-Out
  final signOutExample = CupertinoAlertDialog(
    title: Text('Sign Out'),
    content: Text('You can sign back in anytime. Continue?'),
    actions: [
      CupertinoDialogAction(child: Text('Stay Signed In'), onPressed: () {}),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text('Sign Out'),
        onPressed: () {},
      ),
    ],
  );

  // Example C: Share Sheet
  final shareExample = CupertinoActionSheet(
    title: Text('Share Document'),
    message: Text('How would you like to share this file?'),
    actions: [
      CupertinoActionSheetAction(
        child: Text('Send via Mail'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('AirDrop'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Copy Link'),
        onPressed: () {},
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );

  // Example D: Error message
  final errorExample = CupertinoAlertDialog(
    title: Text('Connection Failed'),
    content: Text(
      'Unable to reach the server. Please check your internet connection and try again.',
    ),
    actions: [
      CupertinoDialogAction(child: Text('Retry'), onPressed: () {}),
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('OK'),
        onPressed: () {},
      ),
    ],
  );

  // Example E: Select Photo Source
  final selectPhotoExample = CupertinoActionSheet(
    title: Text('Select Photo'),
    message: Text('Choose a source for your new photo'),
    actions: [
      CupertinoActionSheetAction(
        isDefaultAction: true,
        child: Text('Take Photo'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Choose from Library'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Browse Files'),
        onPressed: () {},
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );

  final examples = <Map<String, dynamic>>[
    {
      'title': 'Confirm Delete',
      'subtitle': 'Destructive action with cancel',
      'icon': CupertinoIcons.delete_solid,
      'accent': Colors.red,
      'preview': confirmDeleteExample,
    },
    {
      'title': 'Sign Out',
      'subtitle': 'Account exit confirmation',
      'icon': CupertinoIcons.square_arrow_right,
      'accent': Colors.deepOrange,
      'preview': signOutExample,
    },
    {
      'title': 'Share Document',
      'subtitle': 'Action sheet with cancel',
      'icon': CupertinoIcons.share,
      'accent': Colors.blue,
      'preview': shareExample,
    },
    {
      'title': 'Error Message',
      'subtitle': 'Retry / OK dialog',
      'icon': CupertinoIcons.wifi_slash,
      'accent': Colors.indigo,
      'preview': errorExample,
    },
    {
      'title': 'Select Photo',
      'subtitle': 'Picker action sheet',
      'icon': CupertinoIcons.camera,
      'accent': Colors.purple,
      'preview': selectPhotoExample,
    },
  ];

  final exampleWidgets = <Widget>[];
  for (int i = 0; i < examples.length; i++) {
    final ex = examples[i];
    final accent = ex['accent'] as Color;
    exampleWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.05),
              accent.withValues(alpha: 0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Container(
                    width: 42.0,
                    height: 42.0,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      ex['icon'] as IconData,
                      color: accent,
                      size: 22.0,
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Example ${i + 1}: ${ex['title']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: accent,
                          ),
                        ),
                        Text(
                          ex['subtitle'] as String,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14.0, 0, 14.0, 14.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: CupertinoColors.systemGrey4),
                ),
                child: ex['preview'] as Widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${exampleWidgets.length} real-world example cards');

  // ============================================================
  // SECTION 6: CupertinoPopupSurface + Comparison Table
  // ============================================================
  print('=== Section 6: CupertinoPopupSurface + Comparison ===');

  // Two CupertinoPopupSurface instances
  final paintedPopupSurface = CupertinoPopupSurface(
    isSurfacePainted: true,
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.checkmark_seal_fill,
            color: CupertinoColors.activeBlue,
            size: 36.0,
          ),
          SizedBox(height: 12.0),
          Text(
            'Painted Popup Surface',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'isSurfacePainted: true — draws the default translucent background.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: CupertinoColors.systemGrey),
          ),
        ],
      ),
    ),
  );

  final unpaintedPopupSurface = CupertinoPopupSurface(
    isSurfacePainted: false,
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade100, Colors.purple.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.paintbrush_fill,
            color: Colors.white,
            size: 36.0,
          ),
          SizedBox(height: 12.0),
          Text(
            'Custom-Painted Surface',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'isSurfacePainted: false — caller supplies the background.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    ),
  );

  final popupSurfaceWidgets = <Widget>[
    Container(
      width: 280.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: CupertinoColors.systemGrey3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: paintedPopupSurface,
      ),
    ),
    Container(
      width: 280.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: CupertinoColors.systemGrey3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: unpaintedPopupSurface,
      ),
    ),
  ];

  // Comparison table
  final comparisonRows = <Map<String, dynamic>>[
    {
      'property': 'Use case',
      'alert': 'Yes/No question or info',
      'sheet': 'Pick from list',
      'popup': 'Custom popup canvas',
    },
    {
      'property': 'Has title',
      'alert': 'Optional',
      'sheet': 'Optional',
      'popup': 'No (caller-built)',
    },
    {
      'property': 'Has message',
      'alert': 'Via content',
      'sheet': 'Optional',
      'popup': 'No (caller-built)',
    },
    {
      'property': 'Actions',
      'alert': 'CupertinoDialogAction',
      'sheet': 'CupertinoActionSheetAction',
      'popup': 'Any widget',
    },
    {
      'property': 'Cancel button',
      'alert': 'Just another action',
      'sheet': 'Dedicated slot',
      'popup': 'Not applicable',
    },
    {
      'property': 'Layout',
      'alert': 'Centered modal',
      'sheet': 'Bottom-anchored sheet',
      'popup': 'Free-form panel',
    },
  ];

  Widget buildComparisonCell(
    String text, {
    bool header = false,
    Color? color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: header
            ? (color ?? Colors.grey).withValues(alpha: 0.25)
            : Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300, width: 1.0),
          bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: header ? FontWeight.bold : FontWeight.normal,
          color: header ? (color ?? Colors.black) : Colors.grey.shade800,
        ),
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.0),
          1: FlexColumnWidth(1.4),
          2: FlexColumnWidth(1.4),
          3: FlexColumnWidth(1.4),
        },
        children: [
          TableRow(
            children: [
              buildComparisonCell(
                'Property',
                header: true,
                color: Colors.blueGrey,
              ),
              buildComparisonCell(
                'AlertDialog',
                header: true,
                color: Colors.blue,
              ),
              buildComparisonCell(
                'ActionSheet',
                header: true,
                color: Colors.orange,
              ),
              buildComparisonCell(
                'PopupSurface',
                header: true,
                color: Colors.purple,
              ),
            ],
          ),
          for (final row in comparisonRows)
            TableRow(
              children: [
                buildComparisonCell(
                  row['property'] as String,
                  header: true,
                  color: Colors.blueGrey,
                ),
                buildComparisonCell(row['alert'] as String),
                buildComparisonCell(row['sheet'] as String),
                buildComparisonCell(row['popup'] as String),
              ],
            ),
        ],
      ),
    ),
  );

  // Code panel
  final codePanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Classic confirm dialog\n'
            'CupertinoAlertDialog(\n'
            '  title: Text("Delete Item?"),\n'
            '  content: Text("This cannot be undone."),\n'
            '  actions: [\n'
            '    CupertinoDialogAction(\n'
            '      child: Text("Cancel"),\n'
            '      onPressed: () => Navigator.pop(context),\n'
            '    ),\n'
            '    CupertinoDialogAction(\n'
            '      isDestructiveAction: true,\n'
            '      child: Text("Delete"),\n'
            '      onPressed: () { /* delete */ },\n'
            '    ),\n'
            '  ],\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Share-style action sheet\n'
            'CupertinoActionSheet(\n'
            '  title: Text("Share Photo"),\n'
            '  message: Text("Choose where to share"),\n'
            '  actions: [\n'
            '    CupertinoActionSheetAction(\n'
            '      child: Text("Send via Mail"),\n'
            '      onPressed: () {},\n'
            '    ),\n'
            '    CupertinoActionSheetAction(\n'
            '      child: Text("AirDrop"),\n'
            '      onPressed: () {},\n'
            '    ),\n'
            '  ],\n'
            '  cancelButton: CupertinoActionSheetAction(\n'
            '    child: Text("Cancel"),\n'
            '    onPressed: () => Navigator.pop(context),\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Custom popup using CupertinoPopupSurface\n'
            'CupertinoPopupSurface(\n'
            '  isSurfacePainted: false,\n'
            '  child: Container(\n'
            '    decoration: BoxDecoration(\n'
            '      gradient: LinearGradient(/* ... */),\n'
            '    ),\n'
            '    child: MyCustomPopupContent(),\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purpleAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code panel and comparison table');

  // ============================================================
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          CupertinoIcons.exclamationmark_circle,
          'CupertinoAlertDialog',
          'Centered iOS-style modal for yes/no questions',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          CupertinoIcons.square_list,
          'CupertinoActionSheet',
          'Bottom sheet picker with optional cancel slot',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          CupertinoIcons.checkmark_seal,
          'isDefaultAction',
          'Bold-text primary action emphasized by iOS',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          CupertinoIcons.trash,
          'isDestructiveAction',
          'Red tint marking irreversible operations',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          CupertinoIcons.rectangle_stack,
          'CupertinoPopupSurface',
          'Translucent rounded canvas for custom popups',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          CupertinoIcons.scribble,
          'Static Previews',
          'These widgets render fine inline for visual demos',
          Colors.teal,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Cupertino Dialog Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.blue, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.3),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.bubble_left_bubble_right_fill,
                    size: 56.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Cupertino Dialog Widgets',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'AlertDialog · DialogAction · ActionSheet · PopupSurface',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. Cupertino Dialog Family Overview',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: overviewCards,
            ),
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. CupertinoAlertDialog Variants',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: alertVariantWidgets,
            ),
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. CupertinoDialogAction States',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: actionStateWidgets,
            ),
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. CupertinoActionSheet Variants',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: sheetVariantWidgets,
            ),
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Real-World Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...exampleWidgets,
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. CupertinoPopupSurface + Comparison',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: popupSurfaceWidgets,
            ),
            SizedBox(height: 16.0),
            Text(
              'Comparison: AlertDialog vs ActionSheet vs PopupSurface',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            comparisonTable,
            SizedBox(height: 16.0),
            codePanel,
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
          ],
        ),
      ),
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
