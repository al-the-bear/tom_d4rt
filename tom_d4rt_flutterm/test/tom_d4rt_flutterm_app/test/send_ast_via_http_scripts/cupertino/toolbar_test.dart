// D4rt test script: Deep Demo for Cupertino Text Selection Toolbars
// Tests CupertinoTextSelectionToolbar, CupertinoAdaptiveTextSelectionToolbar,
// CupertinoDesktopTextSelectionToolbar, and related button widgets
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Divider;

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║          CUPERTINO TOOLBAR WIDGETS DEEP DEMO                      ║',
  );
  print(
    '║     Text Selection Toolbars with iOS-Style Buttons                ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: TOOLBAR FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: TOOLBAR FUNDAMENTALS                                   │',
  );
  print(
    '│ Understanding Cupertino text selection toolbars                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Cupertino toolbar widgets provide:');
  print('  • iOS-native text selection UX');
  print('  • Adaptive platform behavior');
  print('  • Desktop and mobile variants');
  print('  • Styled action buttons');
  print('');

  print('Available toolbar classes:');
  print(
    '┌────────────────────────────────────────────────────┬───────────────┐',
  );
  print(
    '│   Class                                            │   Platform    │',
  );
  print(
    '├────────────────────────────────────────────────────┼───────────────┤',
  );
  print(
    '│ CupertinoTextSelectionToolbar                      │ Mobile iOS    │',
  );
  print(
    '│ CupertinoTextSelectionToolbarButton                │ Mobile iOS    │',
  );
  print(
    '│ CupertinoAdaptiveTextSelectionToolbar              │ Adaptive      │',
  );
  print(
    '│ CupertinoDesktopTextSelectionToolbar               │ Desktop macOS │',
  );
  print(
    '│ CupertinoDesktopTextSelectionToolbarButton         │ Desktop macOS │',
  );
  print(
    '└────────────────────────────────────────────────────┴───────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: TOOLBAR BUTTON BASICS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: TOOLBAR BUTTON BASICS                                  │',
  );
  print(
    '│ CupertinoTextSelectionToolbarButton fundamentals                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final basicButton = CupertinoTextSelectionToolbarButton(
    child: Text('Copy'),
    onPressed: () => print('Copy pressed'),
  );

  print('CupertinoTextSelectionToolbarButton properties:');
  print('  • runtimeType: ${basicButton.runtimeType}');
  print('  • child: Text widget with action label');
  print('  • onPressed: Callback or null (disabled)');
  print('');

  print('Visual style:');
  print('  ┌─────────────────────────────────────────┐');
  print('  │  Cut  │ Copy  │ Paste │ Select All      │');
  print('  └─────────────────────────────────────────┘');
  print('      Horizontal button row with dividers');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BUTTON .TEXT CONSTRUCTOR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: BUTTON .TEXT CONSTRUCTOR                               │',
  );
  print(
    '│ Convenience constructor for text-only buttons                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final textButton = CupertinoTextSelectionToolbarButton.text(
    text: 'Paste',
    onPressed: () => print('Paste pressed'),
  );

  print('CupertinoTextSelectionToolbarButton.text:');
  print('  • text: "Paste" (String parameter)');
  print('  • Automatically creates styled Text widget');
  print('  • Standard iOS toolbar text styling');
  print('');

  print('Comparison of constructors:');
  print('  // Full control over child:');
  print('  CupertinoTextSelectionToolbarButton(');
  print('    child: Row(children: [Icon(...), Text("Cut")]),');
  print('    onPressed: () {},');
  print('  )');
  print('');
  print('  // Simple text button:');
  print('  CupertinoTextSelectionToolbarButton.text(');
  print('    text: "Cut",');
  print('    onPressed: () {},');
  print('  )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: DISABLED BUTTONS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: DISABLED BUTTONS                                       │',
  );
  print(
    '│ Handling unavailable actions                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final disabledButton = CupertinoTextSelectionToolbarButton(
    onPressed: null,
    child: Text('Paste'),
  );

  print('Disabled button configuration:');
  print('  • onPressed: null');
  print('  • Visual: Dimmed/grayed text');
  print('  • Tap: No response');
  print('');

  print('Common disabled scenarios:');
  print('  • Paste → Clipboard empty');
  print('  • Cut/Copy → No selection');
  print('  • Undo → Nothing to undo');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: CUPERTINO TEXT SELECTION TOOLBAR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: CUPERTINO TEXT SELECTION TOOLBAR                       │',
  );
  print(
    '│ Mobile iOS toolbar container                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final mobileToolbar = CupertinoTextSelectionToolbar(
    anchorAbove: Offset(100.0, 50.0),
    anchorBelow: Offset(100.0, 80.0),
    children: [
      CupertinoTextSelectionToolbarButton.text(text: 'Cut', onPressed: () {}),
      CupertinoTextSelectionToolbarButton.text(text: 'Copy', onPressed: () {}),
      CupertinoTextSelectionToolbarButton.text(text: 'Paste', onPressed: () {}),
      CupertinoTextSelectionToolbarButton.text(
        text: 'Select All',
        onPressed: () {},
      ),
    ],
  );

  print('CupertinoTextSelectionToolbar properties:');
  print('  • runtimeType: ${mobileToolbar.runtimeType}');
  print('  • anchorAbove: Offset(100.0, 50.0)');
  print('  • anchorBelow: Offset(100.0, 80.0)');
  print('  • children: 4 toolbar buttons');
  print('');

  print('Anchor positioning:');
  print('             anchorAbove');
  print('                 │');
  print('  ┌──────────────▼───────────────┐');
  print('  │ Cut │ Copy │ Paste │ Select  │  ← Toolbar');
  print('  └────────────────────────────────┘');
  print('                 │');
  print('             anchorBelow');
  print('');
  print('  • Toolbar appears above selection if space');
  print('  • Falls back to below if needed');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: ADAPTIVE TOOLBAR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: ADAPTIVE TOOLBAR                                       │',
  );
  print(
    '│ CupertinoAdaptiveTextSelectionToolbar                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final adaptiveToolbar = CupertinoAdaptiveTextSelectionToolbar(
    anchors: TextSelectionToolbarAnchors(primaryAnchor: Offset(150.0, 100.0)),
    children: [
      CupertinoTextSelectionToolbarButton.text(text: 'Cut', onPressed: () {}),
      CupertinoTextSelectionToolbarButton.text(text: 'Copy', onPressed: () {}),
      CupertinoTextSelectionToolbarButton.text(text: 'Paste', onPressed: () {}),
    ],
  );

  print('CupertinoAdaptiveTextSelectionToolbar properties:');
  print('  • runtimeType: ${adaptiveToolbar.runtimeType}');
  print('  • anchors: TextSelectionToolbarAnchors');
  print('  • children: 3 toolbar buttons');
  print('');

  print('Adaptive behavior:');
  print('  • iOS/macOS: Cupertino styling');
  print('  • Automatically adapts to platform');
  print('  • Uses TextSelectionToolbarAnchors');
  print('');

  print('TextSelectionToolbarAnchors:');
  print('  • primaryAnchor: Main position');
  print('  • secondaryAnchor: Fallback position');
  print('  • Used for smart positioning');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: DESKTOP TOOLBAR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: DESKTOP TOOLBAR                                        │',
  );
  print(
    '│ CupertinoDesktopTextSelectionToolbar                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

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
      CupertinoDesktopTextSelectionToolbarButton(
        child: Text('Select All'),
        onPressed: () {},
      ),
    ],
  );

  print('CupertinoDesktopTextSelectionToolbar properties:');
  print('  • runtimeType: ${desktopToolbar.runtimeType}');
  print('  • anchor: Offset(200.0, 100.0)');
  print('  • children: 4 desktop toolbar buttons');
  print('');

  print('Desktop vs Mobile toolbars:');
  print(
    '┌──────────────────────┬──────────────────────┬──────────────────────┐',
  );
  print(
    '│      Feature         │       Mobile         │       Desktop        │',
  );
  print(
    '├──────────────────────┼──────────────────────┼──────────────────────┤',
  );
  print(
    '│ Style                │ Rounded bubble       │ Menu-like dropdown   │',
  );
  print(
    '│ Position             │ Above/below text     │ At cursor position   │',
  );
  print(
    '│ Layout               │ Horizontal row       │ Vertical list        │',
  );
  print(
    '│ Button style         │ Inline with dividers │ Full-width rows      │',
  );
  print(
    '└──────────────────────┴──────────────────────┴──────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: DESKTOP TOOLBAR BUTTON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: DESKTOP TOOLBAR BUTTON                                 │',
  );
  print(
    '│ CupertinoDesktopTextSelectionToolbarButton                        │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final desktopButton = CupertinoDesktopTextSelectionToolbarButton(
    child: Text('Select All'),
    onPressed: () => print('Select All pressed'),
  );

  print('CupertinoDesktopTextSelectionToolbarButton properties:');
  print('  • runtimeType: ${desktopButton.runtimeType}');
  print('  • child: Text("Select All")');
  print('  • onPressed: Callback function');
  print('');

  final desktopTextButton = CupertinoDesktopTextSelectionToolbarButton.text(
    text: 'Look Up',
    onPressed: () => print('Look Up pressed'),
  );

  print('Desktop button .text constructor:');
  print('  • text: "Look Up" (String)');
  print('  • Same convenience as mobile');
  print('');

  print('Visual representation (Desktop):');
  print('  ┌─────────────────────┐');
  print('  │ Cut            ⌘X  │');
  print('  │ Copy           ⌘C  │');
  print('  │ Paste          ⌘V  │');
  print('  │ Select All     ⌘A  │');
  print('  └─────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: COMPLETE TOOLBAR EXAMPLE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: COMPLETE TOOLBAR EXAMPLE                               │',
  );
  print(
    '│ Building a full-featured toolbar                                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final fullToolbar = CupertinoDesktopTextSelectionToolbar(
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

  print('Full-featured toolbar created:');
  print('  • 5 action buttons');
  print('  • Desktop styling');
  print('  • Positioned at (200, 150)');
  print('');

  print('Common toolbar actions:');
  print(
    '┌────────────────┬────────────────────────────────────────────────────┐',
  );
  print(
    '│     Action     │   Description                                      │',
  );
  print(
    '├────────────────┼────────────────────────────────────────────────────┤',
  );
  print(
    '│ Cut            │ Move selection to clipboard                        │',
  );
  print(
    '│ Copy           │ Copy selection to clipboard                        │',
  );
  print(
    '│ Paste          │ Insert clipboard contents                          │',
  );
  print(
    '│ Select All     │ Select entire text content                         │',
  );
  print(
    '│ Look Up        │ Dictionary/definition lookup (macOS)               │',
  );
  print(
    '│ Share          │ Share selected text                                │',
  );
  print(
    '│ Translate      │ Translate selected text                            │',
  );
  print(
    '└────────────────┴────────────────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: PRACTICAL USE CASES                                   │',
  );
  print(
    '│ When and how to use Cupertino toolbars                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Custom Text Field Selection');
  print('   Use CupertinoTextSelectionToolbar to build');
  print('   custom text selection behavior');
  print('');

  print('2. Rich Text Editors');
  print('   Add formatting buttons to the toolbar:');
  print('   Bold, Italic, Underline, etc.');
  print('');

  print('3. Cross-Platform Apps');
  print('   Use CupertinoAdaptiveTextSelectionToolbar');
  print('   for automatic platform adaptation');
  print('');

  print('4. Desktop-First Apps');
  print('   Use CupertinoDesktopTextSelectionToolbar');
  print('   for macOS-native experience');
  print('');

  print('5. Context Menus');
  print('   Build custom context menus using');
  print('   toolbar button widgets');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║           CUPERTINO TOOLBAR WIDGETS SUMMARY                       ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('Cupertino toolbar key features:');
  print('  • 5 main toolbar widgets');
  print('  • Mobile and desktop variants');
  print('  • Adaptive platform support');
  print('  • Standard iOS/macOS actions');
  print('');
  print('Widget selection guide:');
  print('  • Mobile iOS: CupertinoTextSelectionToolbar');
  print('  • Desktop macOS: CupertinoDesktopTextSelectionToolbar');
  print('  • Cross-platform: CupertinoAdaptiveTextSelectionToolbar');
  print('');
  print('Cupertino Toolbar Widgets Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.systemGroupedBackground,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Cupertino Toolbar Widgets',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Text Selection Toolbars',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: CupertinoColors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Widget List
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WIDGETS COVERED',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C4DFF),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  _buildWidgetRow(
                    'CupertinoTextSelectionToolbar',
                    'Mobile container',
                  ),
                  _buildWidgetRow(
                    'CupertinoTextSelectionToolbarButton',
                    'Mobile button',
                  ),
                  _buildWidgetRow(
                    'CupertinoAdaptiveTextSelectionToolbar',
                    'Adaptive',
                  ),
                  _buildWidgetRow(
                    'CupertinoDesktopTextSelectionToolbar',
                    'Desktop container',
                  ),
                  _buildWidgetRow(
                    'CupertinoDesktopTextSelectionToolbarButton',
                    'Desktop button',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Mobile Toolbar Demo
            _buildSectionTitle('MOBILE TOOLBAR BUTTONS'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMobileButton('Cut', true),
                  _buildMobileButton('Copy', true),
                  _buildMobileButton('Paste', false),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Desktop Toolbar Demo
            _buildSectionTitle('DESKTOP TOOLBAR STYLE'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: CupertinoColors.systemGrey4),
              ),
              child: Column(
                children: [
                  _buildDesktopMenuItem('Cut', '⌘X'),
                  Divider(height: 1),
                  _buildDesktopMenuItem('Copy', '⌘C'),
                  Divider(height: 1),
                  _buildDesktopMenuItem('Paste', '⌘V'),
                  Divider(height: 1),
                  _buildDesktopMenuItem('Select All', '⌘A'),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Platform comparison
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'PLATFORM COMPARISON',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPlatformBox(
                          'iOS',
                          'Bubble',
                          Color(0xFF4CAF50),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildPlatformBox(
                          'macOS',
                          'Menu',
                          Color(0xFF2196F3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Summary
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'SUMMARY',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryStat('Widgets', '5'),
                      _buildSummaryStat('Platforms', '2'),
                      _buildSummaryStat('Sections', '10'),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Deep Demo • Cupertino Toolbar Widgets • Flutter',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: CupertinoColors.systemGrey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildWidgetRow(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Color(0xFF7C4DFF),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 10, color: CupertinoColors.systemGrey),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF7C4DFF),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _buildMobileButton(String label, bool enabled) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: enabled ? CupertinoColors.activeBlue : CupertinoColors.systemGrey4,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 13,
        color: enabled ? CupertinoColors.white : CupertinoColors.systemGrey,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildDesktopMenuItem(String label, String shortcut) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13)),
        Text(
          shortcut,
          style: TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
        ),
      ],
    ),
  );
}

Widget _buildPlatformBox(String platform, String style, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          platform,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          style,
          style: TextStyle(
            fontSize: 11,
            color: CupertinoColors.white.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryStat(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF90A4AE))),
    ],
  );
}
