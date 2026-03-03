// D4rt test script: Tests CupertinoAdaptiveTextSelectionToolbar, CupertinoTextSelectionToolbar, CupertinoTextSelectionToolbarButton, CupertinoDesktopTextSelectionToolbar, CupertinoDesktopTextSelectionToolbarButton from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino toolbar test executing');

  // ========== CUPERTINOTEXTSELECTIONTOOLBARBUTTON ==========
  print('--- CupertinoTextSelectionToolbarButton Tests ---');

  // Test basic CupertinoTextSelectionToolbarButton
  final basicToolbarButton = CupertinoTextSelectionToolbarButton(
    child: Text('Copy'),
    onPressed: () {
      print('Copy pressed');
    },
  );
  print('Basic CupertinoTextSelectionToolbarButton created');

  // Test CupertinoTextSelectionToolbarButton with text
  final textToolbarButton = CupertinoTextSelectionToolbarButton.text(
    text: 'Paste',
    onPressed: () {
      print('Paste pressed');
    },
  );
  print('CupertinoTextSelectionToolbarButton.text created');

  // Test disabled CupertinoTextSelectionToolbarButton
  final disabledToolbarButton = CupertinoTextSelectionToolbarButton(
    child: Text('Disabled'),
    onPressed: null,
  );
  print('Disabled CupertinoTextSelectionToolbarButton created');

  // ========== CUPERTINOTEXTSELECTIONTOOLBAR ==========
  print('--- CupertinoTextSelectionToolbar Tests ---');

  // Test CupertinoTextSelectionToolbar with buttons
  final toolbar = CupertinoTextSelectionToolbar(
    anchorAbove: Offset(100.0, 50.0),
    anchorBelow: Offset(100.0, 80.0),
    children: [
      CupertinoTextSelectionToolbarButton.text(
        text: 'Cut',
        onPressed: () {},
      ),
      CupertinoTextSelectionToolbarButton.text(
        text: 'Copy',
        onPressed: () {},
      ),
      CupertinoTextSelectionToolbarButton.text(
        text: 'Paste',
        onPressed: () {},
      ),
      CupertinoTextSelectionToolbarButton.text(
        text: 'Select All',
        onPressed: () {},
      ),
    ],
  );
  print('CupertinoTextSelectionToolbar created');

  // ========== CUPERTINOADAPTIVETEXTSELECTIONTOOLBAR ==========
  print('--- CupertinoAdaptiveTextSelectionToolbar Tests ---');

  // Test CupertinoAdaptiveTextSelectionToolbar
  final adaptiveToolbar = CupertinoAdaptiveTextSelectionToolbar(
    anchors: TextSelectionToolbarAnchors(
      primaryAnchor: Offset(150.0, 100.0),
    ),
    children: [
      CupertinoTextSelectionToolbarButton.text(
        text: 'Cut',
        onPressed: () {},
      ),
      CupertinoTextSelectionToolbarButton.text(
        text: 'Copy',
        onPressed: () {},
      ),
      CupertinoTextSelectionToolbarButton.text(
        text: 'Paste',
        onPressed: () {},
      ),
    ],
  );
  print('CupertinoAdaptiveTextSelectionToolbar created');

  // ========== CUPERTINODESKTOPTEXTSELECTIONTOOLBAR ==========
  print('--- CupertinoDesktopTextSelectionToolbar Tests ---');

  // Test CupertinoDesktopTextSelectionToolbar
  final desktopToolbar = CupertinoDesktopTextSelectionToolbar(
    anchor: Offset(200.0, 100.0),
    children: [
      CupertinoDesktopTextSelectionToolbarButton(
        child: Text('Cut'),
        onPressed: () {},
      ),
      CupertinoDesktopTextSelectionToolbarButton(
        child: Text('Copy'),
        onPressed: () {},
      ),
      CupertinoDesktopTextSelectionToolbarButton(
        child: Text('Paste'),
        onPressed: () {},
      ),
    ],
  );
  print('CupertinoDesktopTextSelectionToolbar created');

  // ========== CUPERTINODESKTOPTEXTSELECTIONTOOLBARBUTTON ==========
  print('--- CupertinoDesktopTextSelectionToolbarButton Tests ---');

  // Test basic CupertinoDesktopTextSelectionToolbarButton
  final desktopButton = CupertinoDesktopTextSelectionToolbarButton(
    child: Text('Select All'),
    onPressed: () {
      print('Select All pressed');
    },
  );
  print('Basic CupertinoDesktopTextSelectionToolbarButton created');

  // Test CupertinoDesktopTextSelectionToolbarButton.text
  final desktopTextButton = CupertinoDesktopTextSelectionToolbarButton.text(
    text: 'Look Up',
    onPressed: () {
      print('Look Up pressed');
    },
  );
  print('CupertinoDesktopTextSelectionToolbarButton.text created');

  // Test multiple desktop toolbar buttons
  final multiDesktopToolbar = CupertinoDesktopTextSelectionToolbar(
    anchor: Offset(200.0, 150.0),
    children: [
      CupertinoDesktopTextSelectionToolbarButton.text(
        text: 'Cut',
        onPressed: () {},
      ),
      CupertinoDesktopTextSelectionToolbarButton.text(
        text: 'Copy',
        onPressed: () {},
      ),
      CupertinoDesktopTextSelectionToolbarButton.text(
        text: 'Paste',
        onPressed: () {},
      ),
      CupertinoDesktopTextSelectionToolbarButton.text(
        text: 'Select All',
        onPressed: () {},
      ),
      CupertinoDesktopTextSelectionToolbarButton.text(
        text: 'Look Up',
        onPressed: () {},
      ),
    ],
  );
  print('Multi-button CupertinoDesktopTextSelectionToolbar created');

  print('All Cupertino toolbar tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Toolbar Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cupertino Text Selection Toolbars:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text('Toolbar buttons:'),
              SizedBox(height: 8.0),
              Row(
                children: [
                  basicToolbarButton,
                  textToolbarButton,
                ],
              ),
              SizedBox(height: 16.0),
              Text('Desktop toolbar buttons:'),
              SizedBox(height: 8.0),
              Row(
                children: [
                  desktopButton,
                  desktopTextButton,
                ],
              ),
              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• CupertinoTextSelectionToolbar'),
              Text('• CupertinoTextSelectionToolbarButton'),
              Text('• CupertinoAdaptiveTextSelectionToolbar'),
              Text('• CupertinoDesktopTextSelectionToolbar'),
              Text('• CupertinoDesktopTextSelectionToolbarButton'),
            ],
          ),
        ),
      ),
    ),
  );
}
