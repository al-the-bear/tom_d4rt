// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Material Dialog widgets (AlertDialog, SimpleDialog,
// Dialog, DialogTheme, SimpleDialogOption)
// Deep Demo: Static inline previews of dialog widgets (no showDialog calls).
// Each dialog is constructed and rendered directly inside a sized faded
// Container so the viewer can see exactly what it would look like when
// presented as an overlay.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material Dialog widgets Deep Demo executing');

  // ============================================================
  // SECTION 1: Dialog Type Overview
  // ============================================================
  print('=== Section 1: Dialog Type Overview ===');

  final overviewCards = <Widget>[];

  // Card 1: AlertDialog
  overviewCards.add(
    Container(
      width: 180.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade50, Colors.orange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.warning_amber, size: 40.0, color: Colors.red.shade700),
          SizedBox(height: 8.0),
          Text(
            'AlertDialog',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Title + content + actions.\nFor confirmations & warnings.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.red.shade800),
          ),
        ],
      ),
    ),
  );

  // Card 2: SimpleDialog
  overviewCards.add(
    Container(
      width: 180.0,
      margin: EdgeInsets.all(8.0),
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
          Icon(Icons.list_alt, size: 40.0, color: Colors.blue.shade700),
          SizedBox(height: 8.0),
          Text(
            'SimpleDialog',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Title + option list.\nFor choosing one of many.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.blue.shade800),
          ),
        ],
      ),
    ),
  );

  // Card 3: Dialog (raw)
  overviewCards.add(
    Container(
      width: 180.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.crop_square, size: 40.0, color: Colors.green.shade700),
          SizedBox(height: 8.0),
          Text(
            'Dialog',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Raw Material surface.\nBuild anything inside.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.green.shade800),
          ),
        ],
      ),
    ),
  );

  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: AlertDialog Variants (inline previews)
  // ============================================================
  print('=== Section 2: AlertDialog variants ===');

  // 2a. Basic AlertDialog: title + content (no actions)
  final basicAlert = AlertDialog(
    title: Text('Alert'),
    content: Text('This is a basic alert dialog with title and content.'),
  );
  print('Basic AlertDialog created: ${basicAlert.runtimeType}');

  // 2b. AlertDialog with two actions (Cancel / OK)
  final twoActionAlert = AlertDialog(
    title: Text('Confirm'),
    content: Text('Are you sure you want to continue?'),
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
  print('Two-action AlertDialog created');

  // 2c. AlertDialog with icon (warning)
  final iconAlert = AlertDialog(
    icon: Icon(Icons.warning_amber, color: Colors.orange, size: 48.0),
    iconColor: Colors.orange,
    title: Text('Unsaved Changes'),
    content: Text('You have unsaved changes. Discard them?'),
    actions: [
      TextButton(onPressed: () {}, child: Text('Keep editing')),
      TextButton(
        onPressed: () {},
        child: Text('Discard', style: TextStyle(color: Colors.red)),
      ),
    ],
  );
  print('Icon AlertDialog created');

  // 2d. AlertDialog with custom shape and backgroundColor + elevation
  final shapedAlert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    backgroundColor: Colors.amber.shade50,
    elevation: 24.0,
    title: Text('Styled'),
    content: Text('Rounded 24px corners, amber background, elevation 24.'),
    actions: [
      TextButton(onPressed: () {}, child: Text('Got it')),
    ],
  );
  print('Shaped AlertDialog created');

  // 2e. AlertDialog with centered actions and custom padding
  final centeredActionsAlert = AlertDialog(
    titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
    contentPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
    actionsPadding: EdgeInsets.all(12.0),
    actionsAlignment: MainAxisAlignment.center,
    title: Text('Rate your experience'),
    content: Text('Tap a star to leave a quick rating.'),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.star, color: Colors.amber),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.star, color: Colors.amber),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.star, color: Colors.amber),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.star_border, color: Colors.amber),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.star_border, color: Colors.amber),
      ),
    ],
  );
  print('Centered-actions AlertDialog created');

  // 2f. AlertDialog with scrollable long content
  final scrollableAlert = AlertDialog(
    title: Text('Terms of Service'),
    content: SizedBox(
      width: 280.0,
      height: 160.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            12,
            (i) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'Clause ${i + 1}. By tapping Accept you agree to clause ${i + 1}.',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ),
      ),
    ),
    actions: [
      TextButton(onPressed: () {}, child: Text('Decline')),
      TextButton(onPressed: () {}, child: Text('Accept')),
    ],
  );
  print('Scrollable AlertDialog created');

  // Wrap dialogs in framed previews
  final alertVariants = <_DialogPreview>[
    _DialogPreview('Basic', basicAlert, 180.0, Colors.red),
    _DialogPreview('Two actions', twoActionAlert, 200.0, Colors.red),
    _DialogPreview('With icon', iconAlert, 280.0, Colors.orange),
    _DialogPreview('Custom shape', shapedAlert, 220.0, Colors.amber),
    _DialogPreview('Centered actions', centeredActionsAlert, 260.0, Colors.purple),
    _DialogPreview('Scrollable', scrollableAlert, 320.0, Colors.teal),
  ];

  final alertWidgets = <Widget>[];
  for (final v in alertVariants) {
    alertWidgets.add(_buildDialogPreview(v));
  }
  print('Created ${alertWidgets.length} AlertDialog preview frames');

  // ============================================================
  // SECTION 3: SimpleDialog Variants
  // ============================================================
  print('=== Section 3: SimpleDialog variants ===');

  // 3a. Account picker
  final accountPickerDialog = SimpleDialog(
    title: Text('Choose an account'),
    children: [
      SimpleDialogOption(
        onPressed: () {
          print('Selected account: alice@example.com');
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('A', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 12.0),
            Text('alice@example.com'),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () {
          print('Selected account: bob@example.com');
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('B', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 12.0),
            Text('bob@example.com'),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () {
          print('Selected account: carol@example.com');
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              child: Text('C', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 12.0),
            Text('carol@example.com'),
          ],
        ),
      ),
      Divider(),
      SimpleDialogOption(
        onPressed: () {
          print('Add account');
        },
        child: Row(
          children: [
            Icon(Icons.add, color: Colors.blue),
            SizedBox(width: 12.0),
            Text(
              'Add account',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    ],
  );
  print('Account-picker SimpleDialog created');

  // 3b. Language picker
  final languagePickerDialog = SimpleDialog(
    title: Text('Select language'),
    children: [
      SimpleDialogOption(
        onPressed: () {},
        child: Text('English'),
      ),
      SimpleDialogOption(
        onPressed: () {},
        child: Text('Deutsch'),
      ),
      SimpleDialogOption(
        onPressed: () {},
        child: Text('Français'),
      ),
      SimpleDialogOption(
        onPressed: () {},
        child: Text('日本語'),
      ),
      SimpleDialogOption(
        onPressed: () {},
        child: Text('Español'),
      ),
    ],
  );
  print('Language-picker SimpleDialog created');

  // 3c. Styled SimpleDialog (custom shape + colored bg)
  final styledSimpleDialog = SimpleDialog(
    backgroundColor: Colors.indigo.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    elevation: 16.0,
    title: Text(
      'Sort by',
      style: TextStyle(color: Colors.indigo.shade900),
    ),
    children: [
      SimpleDialogOption(
        onPressed: () {},
        child: Row(
          children: [
            Icon(Icons.sort_by_alpha, color: Colors.indigo),
            SizedBox(width: 12.0),
            Text('Name'),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () {},
        child: Row(
          children: [
            Icon(Icons.date_range, color: Colors.indigo),
            SizedBox(width: 12.0),
            Text('Date modified'),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () {},
        child: Row(
          children: [
            Icon(Icons.straighten, color: Colors.indigo),
            SizedBox(width: 12.0),
            Text('Size'),
          ],
        ),
      ),
    ],
  );
  print('Styled SimpleDialog created');

  final simpleVariants = <_DialogPreview>[
    _DialogPreview('Account picker', accountPickerDialog, 320.0, Colors.blue),
    _DialogPreview('Language picker', languagePickerDialog, 280.0, Colors.blue),
    _DialogPreview('Styled / sort by', styledSimpleDialog, 240.0, Colors.indigo),
  ];

  final simpleWidgets = <Widget>[];
  for (final v in simpleVariants) {
    simpleWidgets.add(_buildDialogPreview(v));
  }
  print('Created ${simpleWidgets.length} SimpleDialog preview frames');

  // ============================================================
  // SECTION 4: Raw Dialog + DialogTheme
  // ============================================================
  print('=== Section 4: Raw Dialog + DialogTheme ===');

  // 4a. Basic raw Dialog with custom child
  final rawDialog = Dialog(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.celebration, size: 48.0, color: Colors.pink),
          SizedBox(height: 12.0),
          Text(
            'You did it!',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'A raw Dialog can contain any widget tree.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: Text('Continue'),
          ),
        ],
      ),
    ),
  );
  print('Raw Dialog created');

  // 4b. Heavily styled Dialog: shape, backgroundColor, elevation, insetPadding
  final styledRawDialog = Dialog(
    backgroundColor: Colors.deepPurple.shade50,
    elevation: 32.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28.0),
      side: BorderSide(color: Colors.deepPurple, width: 2.0),
    ),
    insetPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.brush, size: 40.0, color: Colors.deepPurple),
          SizedBox(height: 12.0),
          Text(
            'Heavily styled Dialog',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'shape, backgroundColor, elevation,\ninsetPadding all customised.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ],
      ),
    ),
  );
  print('Styled raw Dialog created');

  // 4c. Dialog.fullscreen
  final fullscreenDialog = Dialog.fullscreen(
    backgroundColor: Colors.lightBlue.shade50,
    child: Column(
      children: [
        AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('Fullscreen Dialog'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flight_takeoff, size: 64.0, color: Colors.lightBlue),
                SizedBox(height: 12.0),
                Text(
                  'Dialog.fullscreen',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Covers the entire screen.',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Fullscreen Dialog created');

  // 4d. Themed dialog via DialogTheme
  final themedDialog = Theme(
    data: ThemeData(
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.teal.shade50,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        titleTextStyle: TextStyle(
          color: Colors.teal.shade900,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 13.0,
        ),
      ),
    ),
    child: AlertDialog(
      title: Text('Themed via DialogThemeData'),
      content: Text(
        'All visual properties (background, shape, text styles, elevation) '
        'come from the surrounding DialogTheme.',
      ),
      actions: [
        TextButton(onPressed: () {}, child: Text('Got it')),
      ],
    ),
  );
  print('Themed dialog created');

  final rawVariants = <_DialogPreview>[
    _DialogPreview('Raw Dialog', rawDialog, 280.0, Colors.pink),
    _DialogPreview('Styled raw', styledRawDialog, 260.0, Colors.deepPurple),
    _DialogPreview(
      'Fullscreen',
      fullscreenDialog,
      320.0,
      Colors.lightBlue,
      isFullscreen: true,
    ),
    _DialogPreview('DialogTheme', themedDialog, 240.0, Colors.teal),
  ];

  final rawWidgets = <Widget>[];
  for (final v in rawVariants) {
    rawWidgets.add(_buildDialogPreview(v));
  }
  print('Created ${rawWidgets.length} raw/themed Dialog preview frames');

  // ============================================================
  // SECTION 5: Real-world Examples
  // ============================================================
  print('=== Section 5: Real-world examples ===');

  // 5a. Confirm delete
  final confirmDeleteDialog = AlertDialog(
    icon: Icon(Icons.delete_forever, size: 48.0, color: Colors.red),
    iconColor: Colors.red,
    title: Text('Delete photo?'),
    content: Text(
      'This photo will be permanently removed from your library. '
      'This action cannot be undone.',
    ),
    actions: [
      TextButton(
        onPressed: () {
          print('Delete cancelled');
        },
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          print('Delete confirmed');
        },
        style: TextButton.styleFrom(foregroundColor: Colors.red),
        child: Text('Delete'),
      ),
    ],
  );

  // 5b. Choose-account real-world
  final chooseAccountDialog = SimpleDialog(
    title: Text('Sign in as'),
    children: [
      SimpleDialogOption(
        onPressed: () {},
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Work',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'me@company.com',
                    style: TextStyle(fontSize: 11.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () {},
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'me@home.com',
                    style: TextStyle(fontSize: 11.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // 5c. License list dialog (scrollable)
  final licenseDialog = AlertDialog(
    title: Row(
      children: [
        Icon(Icons.description, color: Colors.indigo),
        SizedBox(width: 8.0),
        Text('Open-source licenses'),
      ],
    ),
    content: SizedBox(
      width: 280.0,
      height: 180.0,
      child: ListView(
        children: [
          _licenseRow('flutter', 'BSD-3-Clause'),
          _licenseRow('material_design_icons', 'Apache-2.0'),
          _licenseRow('http', 'BSD-3-Clause'),
          _licenseRow('shared_preferences', 'BSD-3-Clause'),
          _licenseRow('path_provider', 'BSD-3-Clause'),
          _licenseRow('intl', 'BSD-3-Clause'),
          _licenseRow('provider', 'MIT'),
          _licenseRow('go_router', 'BSD-3-Clause'),
        ],
      ),
    ),
    actions: [
      TextButton(onPressed: () {}, child: Text('Close')),
    ],
  );

  // 5d. Error-message dialog
  final errorDialog = AlertDialog(
    icon: Icon(Icons.error_outline, color: Colors.red, size: 48.0),
    iconColor: Colors.red,
    title: Text('Connection failed'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Could not reach the server. Please check your network '
          'connection and try again.',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Text(
            'Error code: ECONNREFUSED',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.red.shade900,
            ),
          ),
        ),
      ],
    ),
    actions: [
      TextButton(onPressed: () {}, child: Text('Dismiss')),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(foregroundColor: Colors.red),
        child: Text('Retry'),
      ),
    ],
  );

  final realWorldVariants = <_DialogPreview>[
    _DialogPreview('Confirm delete', confirmDeleteDialog, 300.0, Colors.red),
    _DialogPreview('Choose account', chooseAccountDialog, 260.0, Colors.blue),
    _DialogPreview('License list', licenseDialog, 340.0, Colors.indigo),
    _DialogPreview('Error message', errorDialog, 340.0, Colors.red),
  ];

  final realWorldWidgets = <Widget>[];
  for (final v in realWorldVariants) {
    realWorldWidgets.add(_buildDialogPreview(v));
  }
  print('Created ${realWorldWidgets.length} real-world preview frames');

  // ============================================================
  // SECTION 6: Comparison Table
  // ============================================================
  print('=== Section 6: Comparison table ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'type': 'AlertDialog',
      'use': 'Confirm/warn',
      'slots': 'icon, title, content, actions',
      'color': Colors.red,
    },
    {
      'type': 'SimpleDialog',
      'use': 'Pick one option',
      'slots': 'title, children (SimpleDialogOption)',
      'color': Colors.blue,
    },
    {
      'type': 'Dialog',
      'use': 'Custom layout',
      'slots': 'arbitrary child',
      'color': Colors.green,
    },
    {
      'type': 'Dialog.fullscreen',
      'use': 'Modal page',
      'slots': 'arbitrary child (full surface)',
      'color': Colors.lightBlue,
    },
    {
      'type': 'DialogTheme',
      'use': 'Style defaults',
      'slots': 'background, shape, text styles, elevation',
      'color': Colors.teal,
    },
  ];

  final comparisonWidgets = <Widget>[];
  // Header row
  comparisonWidgets.add(
    Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Type',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Use case',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Slots',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  for (int i = 0; i < comparisonRows.length; i++) {
    final row = comparisonRows[i];
    final color = row['color'] as Color;
    final isLast = i == comparisonRows.length - 1;
    comparisonWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.grey.shade50 : Colors.white,
          border: Border(
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
          borderRadius: isLast
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                )
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      row['type'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                row['use'] as String,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                row['slots'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created comparison table with ${comparisonRows.length} rows');

  // ============================================================
  // SECTION 7: Code panels
  // ============================================================
  print('=== Section 7: Code panels ===');

  final codePanelAlert = _codePanel(
    Icons.warning_amber,
    Colors.red.shade300,
    'AlertDialog',
    '// AlertDialog: confirm/warn pattern\n'
        'final dialog = AlertDialog(\n'
        '  icon: Icon(Icons.warning_amber),\n'
        '  title: Text("Delete photo?"),\n'
        '  content: Text("This cannot be undone."),\n'
        '  actions: [\n'
        '    TextButton(onPressed: () {}, child: Text("Cancel")),\n'
        '    TextButton(\n'
        '      onPressed: () {},\n'
        '      style: TextButton.styleFrom(foregroundColor: Colors.red),\n'
        '      child: Text("Delete"),\n'
        '    ),\n'
        '  ],\n'
        ');',
  );

  final codePanelSimple = _codePanel(
    Icons.list_alt,
    Colors.blue.shade300,
    'SimpleDialog + SimpleDialogOption',
    '// SimpleDialog: pick-one pattern\n'
        'final dialog = SimpleDialog(\n'
        '  title: Text("Choose an account"),\n'
        '  children: [\n'
        '    SimpleDialogOption(\n'
        '      onPressed: () {},\n'
        '      child: Text("alice@example.com"),\n'
        '    ),\n'
        '    SimpleDialogOption(\n'
        '      onPressed: () {},\n'
        '      child: Text("bob@example.com"),\n'
        '    ),\n'
        '  ],\n'
        ');',
  );

  final codePanelStyling = _codePanel(
    Icons.brush,
    Colors.deepPurple.shade300,
    'Dialog + custom shape/elevation',
    '// Custom-styled raw Dialog\n'
        'final dialog = Dialog(\n'
        '  backgroundColor: Colors.deepPurple.shade50,\n'
        '  elevation: 32.0,\n'
        '  shape: RoundedRectangleBorder(\n'
        '    borderRadius: BorderRadius.circular(28.0),\n'
        '    side: BorderSide(color: Colors.deepPurple, width: 2.0),\n'
        '  ),\n'
        '  insetPadding: EdgeInsets.all(24.0),\n'
        '  child: Padding(\n'
        '    padding: EdgeInsets.all(20.0),\n'
        '    child: Text("Anything inside"),\n'
        '  ),\n'
        ');',
  );

  final codePanelTheme = _codePanel(
    Icons.palette,
    Colors.teal.shade300,
    'DialogTheme / DialogThemeData',
    '// Apply defaults to every Dialog in the subtree\n'
        'Theme(\n'
        '  data: ThemeData(\n'
        '    dialogTheme: DialogThemeData(\n'
        '      backgroundColor: Colors.teal.shade50,\n'
        '      elevation: 8.0,\n'
        '      shape: RoundedRectangleBorder(\n'
        '        borderRadius: BorderRadius.circular(16.0),\n'
        '      ),\n'
        '      titleTextStyle: TextStyle(\n'
        '        fontSize: 18, fontWeight: FontWeight.bold,\n'
        '      ),\n'
        '    ),\n'
        '  ),\n'
        '  child: AlertDialog(title: Text("Themed")),\n'
        ');',
  );

  final codeExamplesPanel = Container(
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
              'Code snippets',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        codePanelAlert,
        SizedBox(height: 10.0),
        codePanelSimple,
        SizedBox(height: 10.0),
        codePanelStyling,
        SizedBox(height: 10.0),
        codePanelTheme,
      ],
    ),
  );
  print('Created code-snippet panel');

  // ============================================================
  // SECTION 8: Summary panel
  // ============================================================
  print('=== Section 8: Summary ===');

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
          Icons.warning_amber,
          'AlertDialog for confirmations',
          'Use icon + title + content + actions for yes/no flows.',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.list_alt,
          'SimpleDialog for option lists',
          'Wrap each choice in SimpleDialogOption.onPressed.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.crop_square,
          'Dialog for full custom UI',
          'Drop any widget tree as the child.',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.fullscreen,
          'Dialog.fullscreen for modal pages',
          'Edge-to-edge surface, perfect for forms.',
          Colors.lightBlue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.palette,
          'DialogThemeData for shared style',
          'Centralise shape/colour/text style for the whole app.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.preview,
          'Static previews avoid showDialog',
          'Render dialogs inline in a Container for design review.',
          Colors.purple,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Material Dialog widgets Deep Demo completed successfully');

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
                  colors: [Colors.indigo, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.4),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.layers, size: 56.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    'Material Dialog Widgets',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'AlertDialog · SimpleDialog · Dialog · DialogTheme',
                    style: TextStyle(fontSize: 13.0, color: Colors.white70),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Static inline previews (no showDialog overlay).',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.white60,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. Dialog Type Overview',
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
              '2. AlertDialog Variants',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              'Six configurations: basic, two actions, icon, custom shape, '
              'centered actions, scrollable content.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: alertWidgets),
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. SimpleDialog Variants',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              'Pick-one patterns with SimpleDialogOption children.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: simpleWidgets),
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. Dialog + DialogTheme',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              'Raw Dialog, styled Dialog, Dialog.fullscreen and themed via '
              'DialogThemeData.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: rawWidgets),
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Real-world Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              'Confirm-delete, choose-account, license list and error message.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: realWorldWidgets),
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. Comparison Table',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(children: comparisonWidgets),
            ),
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Code Snippets',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            codeExamplesPanel,
            SizedBox(height: 32.0),

            // Section 8
            Text(
              '8. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
            SizedBox(height: 16.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helper data class: a labelled dialog preview frame
// ============================================================
class _DialogPreview {
  final String label;
  final Widget dialog;
  final double height;
  final Color accent;
  // True for dialogs that contain Expanded children (e.g. Dialog.fullscreen).
  // Such dialogs require a bounded-height parent and must not be wrapped in
  // a vertical SingleChildScrollView (which would pass unbounded height).
  final bool isFullscreen;
  _DialogPreview(
    this.label,
    this.dialog,
    this.height,
    this.accent, {
    this.isFullscreen = false,
  });
}

// Helper: build a framed preview around a real dialog widget.
// The dialog is rendered inline (no showDialog) inside a faded grey area
// so it visually mimics what the user would see when the overlay is active.
Widget _buildDialogPreview(_DialogPreview preview) {
  return Container(
    width: 320.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: preview.accent.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: preview.accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.preview, size: 14.0, color: preview.accent),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  preview.label,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: preview.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Faded backdrop with the dialog floating in the middle.
        // Keep a fixed height so dialogs containing Expanded children
        // (e.g. Dialog.fullscreen with its app-bar + Expanded center body)
        // have a bounded height to lay out against. To prevent natural
        // dialog sizes that exceed the preview frame from triggering
        // RenderFlex overflows, wrap the dialog in nested
        // SingleChildScrollViews: vertical absorbs bottom overflow, the
        // inner horizontal absorbs long title/action rows.
        Container(
          height: preview.height,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          padding: EdgeInsets.all(12.0),
          // Dialog.fullscreen contains Expanded children and requires a
          // bounded-height parent. Other dialogs may have natural sizes that
          // exceed the preview frame, so we wrap them in nested
          // SingleChildScrollViews (vertical + horizontal) to absorb overflow.
          child: preview.isFullscreen
              ? Center(child: preview.dialog)
              : SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Center(child: preview.dialog),
                  ),
                ),
        ),
      ],
    ),
  );
}

// Helper: a license-list row used by the license dialog preview
Widget _licenseRow(String package, String license) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.inventory_2, size: 14.0, color: Colors.indigo),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            package,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Text(
            license,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: a dark code panel with title chip
Widget _codePanel(IconData icon, Color accent, String title, String code) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.green.shade300,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// Helper: build a summary item row for the summary panel
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
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
