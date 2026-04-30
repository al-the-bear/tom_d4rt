// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — EmptyTextSelectionControls
// Demonstrates EmptyTextSelectionControls — a TextSelectionControls
// implementation that renders no visual selection handles and no
// toolbar.  The text selection gestures still work (tap, long-press,
// double-tap to select) but no visual overlay appears.  Used when
// selection behavior is needed without the standard handle/toolbar
// UI — common in custom editors, kiosk UIs, and read-only text.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EmptyTextSelectionControls Deep Demo executing');

  // ============================================================
  // SECTION 1: What is EmptyTextSelectionControls?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'title': 'Invisible Selection Handles',
      'body': 'EmptyTextSelectionControls is a TextSelectionControls '
          'implementation that returns zero-size widgets for the '
          'selection handles and toolbar. The text can still be '
          'selected (the selection state exists), but no visual '
          'handles or cut/copy/paste toolbar appear.',
      'accent': Colors.cyan[600]!,
    },
    {
      'icon': Icons.visibility_off,
      'title': 'No-Op Visual Implementation',
      'body': 'The class overrides buildHandle() to return a zero-size '
          'SizedBox, buildToolbar() to return a zero-size SizedBox, '
          'and getHandleSize() to return Size.zero. It\'s a null-object '
          'pattern for text selection visuals.',
      'accent': Colors.pink[400]!,
    },
    {
      'icon': Icons.tune,
      'title': 'Selective UI Removal',
      'body': 'Normally, TextField and SelectableText show platform-'
          'specific handles (teardrop on Android, loupe on iOS) and '
          'a toolbar (cut/copy/paste). EmptyTextSelectionControls '
          'removes only the visual part — the underlying selection '
          'logic, gestures, and state remain intact.',
      'accent': Colors.cyan[500]!,
    },
    {
      'icon': Icons.compare,
      'title': 'When vs MaterialTextSelectionControls',
      'body': 'MaterialTextSelectionControls renders Material-style '
          'handles (teardrop) and toolbar. CupertinoTextSelectionControls '
          'renders iOS-style handles (circles + loupe). '
          'EmptyTextSelectionControls renders neither. All three '
          'implement the same TextSelectionControls interface.',
      'accent': Colors.pink[300]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: TextSelectionControls Interface
  // ============================================================
  print('=== Section 2: Interface ===');

  final interfaceMethods = <Map<String, dynamic>>[
    {
      'name': 'Widget buildHandle(context, type, lineHeight, onTap)',
      'kind': 'Method',
      'color': Colors.cyan[600]!,
      'desc': 'Builds the selection handle widget. Called twice — once '
          'for the left handle and once for the right handle. The '
          'type parameter indicates TextSelectionHandleType (left, '
          'right, collapsed). EmptyTextSelectionControls returns '
          'SizedBox.shrink().',
    },
    {
      'name': 'Widget buildToolbar(context, globalEditableRegion, ...)',
      'kind': 'Method',
      'color': Colors.pink[400]!,
      'desc': 'Builds the text selection toolbar (cut/copy/paste/select-all). '
          'Called when the user taps a selection handle or long-presses. '
          'EmptyTextSelectionControls returns SizedBox.shrink(). No '
          'toolbar appears regardless of selection state.',
    },
    {
      'name': 'Size getHandleSize(double textLineHeight)',
      'kind': 'Method',
      'color': Colors.cyan[500]!,
      'desc': 'Returns the size of a selection handle. The framework '
          'uses this to compute handle positioning and hit-test areas. '
          'EmptyTextSelectionControls returns Size.zero, meaning '
          'handles occupy no space and cannot be tapped.',
    },
    {
      'name': 'Offset getHandleAnchor(type, lineHeight)',
      'kind': 'Method',
      'color': Colors.pink[300]!,
      'desc': 'Returns the anchor offset for the handle relative to '
          'the selection endpoint. This positions the handle widget. '
          'EmptyTextSelectionControls returns Offset.zero since there '
          'is no visual widget to position.',
    },
    {
      'name': 'bool canCut(TextSelectionDelegate)',
      'kind': 'Method',
      'color': Colors.cyan[400]!,
      'desc': 'Returns whether the Cut action should be available. '
          'Even for EmptyTextSelectionControls, this returns true '
          'if there is a selection and the field is editable. The '
          'action exists but the toolbar to invoke it does not.',
    },
    {
      'name': 'bool canCopy / canPaste / canSelectAll',
      'kind': 'Methods',
      'color': Colors.pink[400]!,
      'desc': 'Similar to canCut — returns the availability of each '
          'clipboard action. These are inherited from the base class '
          'implementation. The actions themselves remain functional; '
          'only the toolbar UI to trigger them is missing.',
    },
  ];

  print('  Prepared ${interfaceMethods.length} interface methods');

  // ============================================================
  // SECTION 3: Use Cases
  // ============================================================
  print('=== Section 3: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Custom Editor Overlay',
      'icon': Icons.edit,
      'color': Colors.cyan[600]!,
      'desc': 'When building a custom code editor or rich text editor, '
          'you often want to provide your own selection handles and '
          'toolbar UI. Use EmptyTextSelectionControls to suppress '
          'the default ones, then overlay your custom widgets.',
    },
    {
      'title': 'Read-Only Display',
      'icon': Icons.chrome_reader_mode,
      'color': Colors.pink[400]!,
      'desc': 'For read-only text that should be selectable (for '
          'copy) but shouldn\'t show handles — e.g., code snippets '
          'where a custom selection UI is desired. Selection works '
          'via gestures but no handles clutter the display.',
    },
    {
      'title': 'Kiosk / Presentation Mode',
      'icon': Icons.tv,
      'color': Colors.cyan[500]!,
      'desc': 'In kiosk or presentation contexts, you might want '
          'text fields to be interactive but not show selection '
          'chrome. EmptyTextSelectionControls hides all handles '
          'while text entry still works normally.',
    },
    {
      'title': 'Accessibility Override',
      'icon': Icons.accessibility,
      'color': Colors.pink[300]!,
      'desc': 'Some accessibility scenarios need selection to work '
          'programmatically (through semantics) without visual '
          'handles that might confuse screen readers or switch '
          'access users. Empty controls provide a clean slate.',
    },
    {
      'title': 'Testing',
      'icon': Icons.science,
      'color': Colors.cyan[400]!,
      'desc': 'In widget tests, using EmptyTextSelectionControls '
          'avoids platform-specific handle rendering issues. '
          'Tests can focus on text content and selection state '
          'without dealing with handle positioning or toolbar overlays.',
    },
    {
      'title': 'Inline Editable Labels',
      'icon': Icons.label,
      'color': Colors.pink[400]!,
      'desc': 'For labels that can be tapped to edit (inline editing '
          'pattern), handles would look out of place. The user taps '
          'the label, types, and taps away. No handles needed. '
          'The cursor still blinks, but handles are hidden.',
    },
  ];

  print('  Prepared ${useCases.length} use cases');

  // ============================================================
  // SECTION 4: How to Apply
  // ============================================================
  print('=== Section 4: How to Apply ===');

  final applications = <Map<String, dynamic>>[
    {
      'title': 'TextField with selectionControls',
      'color': Colors.cyan[600]!,
      'code': '// Apply to a single TextField:\n'
          '// TextField(\n'
          '//   selectionControls:\n'
          '//       emptyTextSelectionControls,\n'
          '//   decoration: InputDecoration(\n'
          '//     hintText: \'No handles here\',\n'
          '//   ),\n'
          '// )',
      'note': 'The emptyTextSelectionControls constant is a '
          'pre-built instance. Pass it directly to any text '
          'field or editable widget.',
    },
    {
      'title': 'SelectableText with selectionControls',
      'color': Colors.pink[400]!,
      'code': '// Apply to selectable read-only text:\n'
          '// SelectableText(\n'
          '//   \'Select me, but no handles!\',\n'
          '//   selectionControls:\n'
          '//       emptyTextSelectionControls,\n'
          '//   style: TextStyle(fontSize: 16),\n'
          '// )',
      'note': 'SelectableText supports text selection by default. '
          'Adding emptyTextSelectionControls hides the visual '
          'handles while keeping selection gestures active.',
    },
    {
      'title': 'Global via Theme (TextSelectionThemeData)',
      'color': Colors.cyan[500]!,
      'code': '// Apply globally via theme:\n'
          '// MaterialApp(\n'
          '//   theme: ThemeData(\n'
          '//     textSelectionTheme:\n'
          '//       TextSelectionThemeData(\n'
          '//         selectionColor: Colors.blue[100],\n'
          '//       ),\n'
          '//   ),\n'
          '// )\n'
          '// Note: Theme doesn\'t set controls;\n'
          '// use selectionControls parameter directly.',
      'note': 'TextSelectionThemeData controls colors (cursor, '
          'selection highlight) but NOT the controls object. '
          'You must set selectionControls per-widget or wrap '
          'in a builder.',
    },
    {
      'title': 'EditableText (low-level)',
      'color': Colors.pink[300]!,
      'code': '// On the low-level EditableText:\n'
          '// EditableText(\n'
          '//   controller: _ctrl,\n'
          '//   focusNode: _focus,\n'
          '//   style: TextStyle(fontSize: 14),\n'
          '//   cursorColor: Colors.black,\n'
          '//   backgroundCursorColor: Colors.grey,\n'
          '//   selectionControls:\n'
          '//       emptyTextSelectionControls,\n'
          '// )',
      'note': 'EditableText is the lowest-level editable text widget. '
          'It accepts selectionControls directly. Most apps use '
          'TextField instead, but custom editors use EditableText.',
    },
  ];

  print('  Prepared ${applications.length} applications');

  // ============================================================
  // SECTION 5: Comparison Table
  // ============================================================
  print('=== Section 5: Comparisons ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'feature': 'Handle Shape',
      'material': 'Teardrop',
      'cupertino': 'Circle + loupe',
      'empty': 'None (zero-size)',
    },
    {
      'feature': 'Toolbar',
      'material': 'Material popup menu',
      'cupertino': 'iOS-style bar',
      'empty': 'None (zero-size)',
    },
    {
      'feature': 'Platform',
      'material': 'Android default',
      'cupertino': 'iOS default',
      'empty': 'Platform-agnostic',
    },
    {
      'feature': 'Selection Gestures',
      'material': 'Full support',
      'cupertino': 'Full support',
      'empty': 'Full support',
    },
    {
      'feature': 'Clipboard Actions',
      'material': 'Via toolbar',
      'cupertino': 'Via toolbar',
      'empty': 'Only via keyboard/semantics',
    },
    {
      'feature': 'Handle Hit Area',
      'material': '~48px touch target',
      'cupertino': '~48px touch target',
      'empty': 'Zero (no hit area)',
    },
  ];

  print('  Prepared ${comparisons.length} comparisons');

  // ============================================================
  // SECTION 6: What Still Works
  // ============================================================
  print('=== Section 6: What Still Works ===');

  final stillWorks = <Map<String, dynamic>>[
    {
      'title': 'Selection Gestures',
      'icon': Icons.gesture,
      'color': Colors.green[500]!,
      'desc': 'Tap to place cursor, double-tap to select word, '
          'long-press to select, triple-tap to select paragraph — '
          'all gestures work. Only the visual handles after selection '
          'are removed.',
    },
    {
      'title': 'Selection Highlight',
      'icon': Icons.highlight,
      'color': Colors.green[600]!,
      'desc': 'The text selection highlight (the colored rectangle '
          'behind selected text) still appears. It\'s controlled by '
          'TextSelectionThemeData.selectionColor, not by the '
          'selection controls.',
    },
    {
      'title': 'Cursor',
      'icon': Icons.text_format,
      'color': Colors.green[500]!,
      'desc': 'The blinking cursor still appears. Cursor rendering '
          'is handled by EditableText directly, not by '
          'TextSelectionControls. cursor color, width, and blink '
          'rate are unaffected.',
    },
    {
      'title': 'Keyboard Shortcuts',
      'icon': Icons.keyboard,
      'color': Colors.green[600]!,
      'desc': 'Ctrl+C, Ctrl+V, Ctrl+X, Ctrl+A and all keyboard '
          'selection shortcuts continue to work. These are handled '
          'by the text editing actions system, not the toolbar.',
    },
    {
      'title': 'Semantics and Accessibility',
      'icon': Icons.accessibility_new,
      'color': Colors.green[500]!,
      'desc': 'Screen reader and accessibility actions (select all, '
          'copy, paste) still work through the semantics tree. '
          'These actions bypass the toolbar entirely.',
    },
    {
      'title': 'Selection Changed Callback',
      'icon': Icons.notifications_active,
      'color': Colors.green[600]!,
      'desc': 'onSelectionChanged callbacks still fire. Your code '
          'can still react to selection changes. Selection state '
          'is decoupled from selection visuals.',
    },
  ];

  print('  Prepared ${stillWorks.length} items');

  // ============================================================
  // SECTION 7: Implementation Details
  // ============================================================
  print('=== Section 7: Implementation ===');

  final implDetails = <Map<String, dynamic>>[
    {
      'title': 'Constant Instance',
      'color': Colors.cyan[600]!,
      'desc': 'Flutter provides a const instance: emptyTextSelectionControls. '
          'It\'s a top-level constant of type EmptyTextSelectionControls. '
          'No need to construct your own — just reference the constant. '
          'This is the recommended way to use it.',
    },
    {
      'title': 'Zero-Size Trick',
      'color': Colors.pink[400]!,
      'desc': 'buildHandle() and buildToolbar() return SizedBox.shrink() '
          '(which is SizedBox(width: 0, height: 0)). This creates a '
          'valid widget that takes no space. The overlay system still '
          'creates the overlay entries, but they\'re invisible.',
    },
    {
      'title': 'Source Location',
      'color': Colors.cyan[500]!,
      'desc': 'Defined in package:flutter/src/widgets/text_selection.dart. '
          'It\'s in the widgets layer, not material or cupertino. This '
          'means it works with any design system and has no Material '
          'or Cupertino dependencies.',
    },
    {
      'title': 'Extends TextSelectionControls',
      'color': Colors.pink[300]!,
      'desc': 'EmptyTextSelectionControls extends the base '
          'TextSelectionControls class. It inherits default '
          'implementations of canCut, canCopy, canPaste, '
          'canSelectAll, and handleCut, handleCopy, etc.',
    },
  ];

  print('  Prepared ${implDetails.length} details');

  // ============================================================
  // SECTION 8: Related Concepts
  // ============================================================
  print('=== Section 8: Related ===');

  final relatedConcepts = <Map<String, dynamic>>[
    {
      'name': 'TextSelectionControls',
      'color': Colors.cyan[600]!,
      'desc': 'The base class that defines the interface for building '
          'selection handles and toolbar. EmptyTextSelectionControls, '
          'MaterialTextSelectionControls, and CupertinoTextSelectionControls '
          'all implement this interface.',
    },
    {
      'name': 'SelectionOverlay',
      'color': Colors.pink[400]!,
      'desc': 'The TextSelectionOverlay manages the overlay entries '
          'for handles and toolbar. Even with EmptyTextSelectionControls, '
          'the overlay exists — it just contains zero-size widgets. '
          'The overlay lifecycle is unchanged.',
    },
    {
      'name': 'TextSelectionThemeData',
      'color': Colors.cyan[500]!,
      'desc': 'Controls selection colors (cursor color, selection '
          'highlight color, handle color). This is separate from '
          'TextSelectionControls. You can use EmptyTextSelectionControls '
          'while still customizing selection colors via the theme.',
    },
    {
      'name': 'EditableText',
      'color': Colors.pink[300]!,
      'desc': 'The core editable text widget. Uses TextSelectionControls '
          'to build its selection overlay. TextField wraps EditableText '
          'with Material styling. SelectableText uses a read-only '
          'EditableText under the hood.',
    },
    {
      'name': 'SelectionArea',
      'color': Colors.cyan[400]!,
      'desc': 'Flutter 3.3+ SelectionArea enables selection across '
          'multiple Text widgets. It has its own selection registrar '
          'and doesn\'t use TextSelectionControls. EmptyTextSelectionControls '
          'only affects TextField/EditableText/SelectableText.',
    },
  ];

  print('  Prepared ${relatedConcepts.length} concepts');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Use the Constant',
      'body': 'Always use emptyTextSelectionControls (the pre-built '
          'constant) rather than constructing EmptyTextSelectionControls() '
          'yourself. The constant is efficient and idiomatic. It\'s '
          'imported from material.dart or widgets.dart.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine With Custom Overlay',
      'body': 'Use EmptyTextSelectionControls to suppress default '
          'handles, then build your own selection UI with '
          'CompositedTransformFollower positioned at selection '
          'endpoints. This gives complete control over selection visuals.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Clipboard Still Available',
      'body': 'Even without a toolbar, users can copy text via '
          'keyboard shortcuts or accessibility actions. If you want '
          'to prevent copying, you also need to intercept those '
          'channels. EmptyTextSelectionControls only hides the UI.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Good for Widget Tests',
      'body': 'In widget tests, using emptyTextSelectionControls '
          'avoids platform-dependent handle rendering. Tests become '
          'more stable since they don\'t depend on handle overlay '
          'positioning which can vary by platform.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Selection Color Still Configurable',
      'body': 'Removing handles doesn\'t remove the selection highlight. '
          'Customize it via TextSelectionThemeData.selectionColor in '
          'your theme. You can even make it transparent for fully '
          'invisible selection.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Mobile UX Consideration',
      'body': 'On mobile, users expect selection handles for precise '
          'selection adjustment. Removing them can make text selection '
          'frustrating. Only use EmptyTextSelectionControls on mobile '
          'if you provide alternative UI for selection adjustment.',
      'severity': 'warning',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('EmptyTextSelectionControls'),
      backgroundColor: Colors.cyan[600],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan[600]!, Colors.pink[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.text_fields, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'EmptyTextSelectionControls',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A TextSelectionControls implementation that renders no '
                  'visual handles or toolbar. Selection gestures, keyboard '
                  'shortcuts, and accessibility actions still work — only '
                  'the visual selection overlay is hidden. Useful for '
                  'custom editors, kiosk mode, and widget testing.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _etHead('1', 'What is EmptyTextSelectionControls?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Interface ──
          _etHead('2', 'TextSelectionControls Interface'),
          SizedBox(height: 12),
          ...interfaceMethods.map((im) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: im['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        _etTag(im['kind'] as String,
                            im['color'] as Color),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(im['name'] as String,
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800])),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(im['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Use Cases ──
          _etHead('3', 'Use Cases'),
          SizedBox(height: 12),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: uc['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(uc['icon'] as IconData,
                            color: uc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(uc['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ]),
                      SizedBox(height: 6),
                      Text(uc['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: How to Apply ──
          _etHead('4', 'How to Apply'),
          SizedBox(height: 12),
          ...applications.map((a) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: a['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: a['color'] as Color)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(a['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.cyan[200],
                                height: 1.4)),
                      ),
                      SizedBox(height: 6),
                      Text(a['note'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Comparison Table ──
          _etHead('5', 'Controls Comparison'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.cyan[600],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text('Feature',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text('Material',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text('Cupertino',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text('Empty',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                ...comparisons.asMap().entries.map((entry) {
                  final c = entry.value;
                  final isEven = entry.key.isEven;
                  return Container(
                    padding: EdgeInsets.all(8),
                    color: isEven ? Colors.grey[50] : Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 70,
                            child: Text(c['feature'] as String,
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]))),
                        Expanded(
                            child: Text(c['material'] as String,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.blue[700]))),
                        Expanded(
                            child: Text(c['cupertino'] as String,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.grey[600]))),
                        Expanded(
                            child: Text(c['empty'] as String,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.cyan[700]))),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 6: What Still Works ──
          _etHead('6', 'What Still Works'),
          SizedBox(height: 12),
          ...stillWorks.map((sw) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: sw['color'] as Color, width: 4),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(sw['icon'] as IconData,
                            color: sw['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(sw['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.green[800])),
                      ]),
                      SizedBox(height: 6),
                      Text(sw['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Implementation ──
          _etHead('7', 'Implementation Details'),
          SizedBox(height: 12),
          ...implDetails.map((d) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: d['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 6),
                      Text(d['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Related ──
          _etHead('8', 'Related Concepts'),
          SizedBox(height: 12),
          ...relatedConcepts.map((r) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: r['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _etTag(r['name'] as String, r['color'] as Color),
                      SizedBox(height: 8),
                      Text(r['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _etHead('9', 'Tips & Best Practices'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),
          Center(
            child: Text(
              'End of EmptyTextSelectionControls Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _etHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.cyan[600],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Tag/label
// ──────────────────────────────────────────────────────────
Widget _etTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
