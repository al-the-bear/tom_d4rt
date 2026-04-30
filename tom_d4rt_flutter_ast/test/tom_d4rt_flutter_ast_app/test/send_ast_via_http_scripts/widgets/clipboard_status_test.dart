// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ClipboardStatus
// Demonstrates ClipboardStatus — the enum that represents the
// clipboard's paste-ability state: pasteable, notPasteable, or
// unknown. Used primarily with ClipboardStatusNotifier to
// conditionally enable/disable paste actions in toolbars and menus.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClipboardStatus Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ClipboardStatus?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.content_paste,
      'title': 'Clipboard State Enum',
      'body': 'ClipboardStatus is a simple three-value enum that '
          'tracks whether the system clipboard contains pasteable '
          'text data. It allows widgets to update their UI in response '
          'to clipboard state changes, such as enabling or disabling '
          'a paste button.',
      'accent': Colors.blueGrey[700]!,
    },
    {
      'icon': Icons.help_outline,
      'title': 'Three Possible States',
      'body': 'pasteable: Clipboard has text content that can be pasted. '
          'notPasteable: Clipboard is empty or holds non-text data. '
          'unknown: The clipboard state has not been checked yet, or the '
          'platform does not provide this information.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Used with ClipboardStatusNotifier',
      'body': 'ClipboardStatusNotifier is a ValueNotifier<ClipboardStatus> '
          'that periodically polls the clipboard. When the status changes, '
          'listeners are notified. EditableText and SelectableText use this '
          'internally to show/hide the paste button in the selection menu.',
      'accent': Colors.blueGrey[600]!,
    },
    {
      'icon': Icons.timer,
      'title': 'Polling, Not Events',
      'body': 'Most platforms do not fire clipboard-change events. '
          'ClipboardStatusNotifier polls the system clipboard at regular '
          'intervals. This means there can be a brief delay between '
          'copying text and the paste button becoming active.',
      'accent': Colors.cyan[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Enum Values Detail
  // ============================================================
  print('=== Section 2: Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'name': 'ClipboardStatus.pasteable',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
      'bgColor': Colors.green[50]!,
      'meaning': 'The clipboard contains text data that can be pasted.',
      'uiEffect': 'Paste button enabled, full opacity, tap-active',
      'scenario': 'User copied text from another app, selected text in '
          'a TextField then copied it, or used Ctrl+C to copy content. '
          'The system clipboard now has text content.',
      'when': 'Clipboard.getData returns non-null text',
    },
    {
      'name': 'ClipboardStatus.notPasteable',
      'icon': Icons.cancel,
      'color': Colors.red[600]!,
      'bgColor': Colors.red[50]!,
      'meaning': 'The clipboard is empty or contains non-text data.',
      'uiEffect': 'Paste button disabled, reduced opacity, tap-ignored',
      'scenario': 'User has not copied anything yet, copied an image, '
          'or the clipboard was cleared. No text data is available.',
      'when': 'Clipboard.getData returns null or throws',
    },
    {
      'name': 'ClipboardStatus.unknown',
      'icon': Icons.help_outline,
      'color': Colors.orange[600]!,
      'bgColor': Colors.orange[50]!,
      'meaning': 'The clipboard state has not been determined yet.',
      'uiEffect': 'Paste button in loading/indeterminate state',
      'scenario': 'Initial state before the first clipboard poll completes, '
          'or the platform does not support clipboard status queries (e.g., '
          'some web browsers restrict clipboard access).',
      'when': 'Before first check or platform restriction',
    },
  ];

  print('  Prepared ${enumValues.length} enum values');

  // ============================================================
  // SECTION 3: State Transition Flow
  // ============================================================
  print('=== Section 3: State Flow ===');

  final transitions = <Map<String, dynamic>>[
    {
      'from': 'unknown',
      'to': 'pasteable',
      'trigger': 'First poll: clipboard has text',
      'icon': Icons.arrow_forward,
      'fromColor': Colors.orange[400]!,
      'toColor': Colors.green[400]!,
    },
    {
      'from': 'unknown',
      'to': 'notPasteable',
      'trigger': 'First poll: clipboard empty',
      'icon': Icons.arrow_forward,
      'fromColor': Colors.orange[400]!,
      'toColor': Colors.red[400]!,
    },
    {
      'from': 'pasteable',
      'to': 'notPasteable',
      'trigger': 'Clipboard cleared or overwritten with image',
      'icon': Icons.arrow_forward,
      'fromColor': Colors.green[400]!,
      'toColor': Colors.red[400]!,
    },
    {
      'from': 'notPasteable',
      'to': 'pasteable',
      'trigger': 'User copies text to clipboard',
      'icon': Icons.arrow_forward,
      'fromColor': Colors.red[400]!,
      'toColor': Colors.green[400]!,
    },
    {
      'from': 'pasteable',
      'to': 'pasteable',
      'trigger': 'Clipboard replaced with different text',
      'icon': Icons.refresh,
      'fromColor': Colors.green[400]!,
      'toColor': Colors.green[500]!,
    },
    {
      'from': 'notPasteable',
      'to': 'notPasteable',
      'trigger': 'Clipboard still empty on next poll',
      'icon': Icons.refresh,
      'fromColor': Colors.red[400]!,
      'toColor': Colors.red[500]!,
    },
  ];

  print('  Prepared ${transitions.length} transitions');

  // ============================================================
  // SECTION 4: ClipboardStatusNotifier Integration
  // ============================================================
  print('=== Section 4: Notifier ===');

  final notifierDetails = <Map<String, dynamic>>[
    {
      'title': 'Lifecycle Management',
      'icon': Icons.repeat,
      'color': Colors.blueGrey[700]!,
      'items': [
        'Create in initState() or late final field',
        'Call dispose() in dispose() to stop polling',
        'Notifier starts polling on first listener addition',
        'Polling stops when all listeners are removed',
      ],
    },
    {
      'title': 'Using with ValueListenableBuilder',
      'icon': Icons.widgets,
      'color': Colors.cyan[700]!,
      'items': [
        'Wrap paste button with ValueListenableBuilder<ClipboardStatus>',
        'Check value == ClipboardStatus.pasteable to enable',
        'Show loading indicator for unknown status',
        'Rebuild automatically on status changes',
      ],
    },
    {
      'title': 'Manual Update',
      'icon': Icons.update,
      'color': Colors.blueGrey[600]!,
      'items': [
        'Call update() to force an immediate clipboard check',
        'Useful after performing a copy operation',
        'Avoids waiting for next polling cycle',
        'Fires listeners if status changed',
      ],
    },
    {
      'title': 'Platform Behavior',
      'icon': Icons.devices,
      'color': Colors.cyan[600]!,
      'items': [
        'Android: Clipboard.hasStrings() for efficient check',
        'iOS: UIPasteboard.general.hasStrings via channel',
        'Web: May stay "unknown" if API restricted',
        'Desktop: Usually full clipboard access',
      ],
    },
  ];

  print('  Prepared ${notifierDetails.length} notifier sections');

  // ============================================================
  // SECTION 5: UI Pattern Showcase
  // ============================================================
  print('=== Section 5: UI Patterns ===');

  final uiPatterns = <Map<String, dynamic>>[
    {
      'name': 'Toolbar Paste Button',
      'description': 'A standard paste button in an editing toolbar. '
          'Disabled with reduced opacity when not pasteable, shown '
          'in accent color when pasteable, and with a subtle spinner '
          'when unknown.',
      'states': [
        {'status': 'pasteable', 'icon': Icons.content_paste, 'opacity': 1.0,
          'color': Colors.blueGrey[700]!},
        {'status': 'notPasteable', 'icon': Icons.content_paste, 'opacity': 0.3,
          'color': Colors.grey[400]!},
        {'status': 'unknown', 'icon': Icons.hourglass_empty, 'opacity': 0.5,
          'color': Colors.orange[400]!},
      ],
    },
    {
      'name': 'Context Menu Action',
      'description': 'The paste entry in a right-click or long-press '
          'context menu. When not pasteable, the menu item is greyed '
          'out and non-interactive. Tapping it does nothing.',
      'states': [
        {'status': 'Paste available', 'icon': Icons.content_paste_go,
          'opacity': 1.0, 'color': Colors.blueGrey[700]!},
        {'status': 'Paste disabled', 'icon': Icons.content_paste_off,
          'opacity': 0.4, 'color': Colors.grey[500]!},
        {'status': 'Checking...', 'icon': Icons.more_horiz,
          'opacity': 0.6, 'color': Colors.orange[400]!},
      ],
    },
    {
      'name': 'Clipboard Badge',
      'description': 'A small indicator badge attached to a clipboard '
          'icon showing current state. Green dot for pasteable, red dot '
          'for not, amber dot for unknown. Good for status bars.',
      'states': [
        {'status': 'Has data', 'icon': Icons.circle,
          'opacity': 1.0, 'color': Colors.green[500]!},
        {'status': 'Empty', 'icon': Icons.circle,
          'opacity': 1.0, 'color': Colors.red[500]!},
        {'status': 'Unknown', 'icon': Icons.circle,
          'opacity': 0.8, 'color': Colors.amber[500]!},
      ],
    },
  ];

  print('  Prepared ${uiPatterns.length} UI patterns');

  // ============================================================
  // SECTION 6: Comparison with Other Clipboard APIs
  // ============================================================
  print('=== Section 6: Comparison ===');

  final apiComparisons = <Map<String, dynamic>>[
    {
      'aspect': 'API',
      'clipboardStatus': 'ClipboardStatus enum',
      'clipboardData': 'Clipboard.getData()',
      'systemClipboard': 'SystemClipboard',
    },
    {
      'aspect': 'Purpose',
      'clipboardStatus': 'Check paste availability',
      'clipboardData': 'Read clipboard content',
      'systemClipboard': 'Rich format clipboard',
    },
    {
      'aspect': 'Return',
      'clipboardStatus': 'pasteable|notPasteable|unknown',
      'clipboardData': 'ClipboardData? (text)',
      'systemClipboard': 'Iterable<DataReader>',
    },
    {
      'aspect': 'Async?',
      'clipboardStatus': 'Polled by notifier',
      'clipboardData': 'Future (async method)',
      'systemClipboard': 'Future (async method)',
    },
    {
      'aspect': 'Use Case',
      'clipboardStatus': 'Enable/disable paste UI',
      'clipboardData': 'Actually paste content',
      'systemClipboard': 'Paste images, HTML, etc.',
    },
    {
      'aspect': 'Overhead',
      'clipboardStatus': 'Low (bool check)',
      'clipboardData': 'Medium (reads data)',
      'systemClipboard': 'High (rich format)',
    },
  ];

  print('  Prepared ${apiComparisons.length} API comparison rows');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic Notifier Setup',
      'color': Colors.blueGrey[700]!,
      'code': 'class _MyWidgetState extends State<MyWidget> {\n'
          '  late final ClipboardStatusNotifier _clipboard;\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _clipboard = ClipboardStatusNotifier();\n'
          '    _clipboard.addListener(_onClipboardChanged);\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _clipboard.removeListener(_onClipboardChanged);\n'
          '    _clipboard.dispose();\n'
          '    super.dispose();\n'
          '  }\n'
          '\n'
          '  void _onClipboardChanged() {\n'
          '    setState(() {});\n'
          '  }\n'
          '}',
    },
    {
      'title': 'ValueListenableBuilder Pattern',
      'color': Colors.cyan[700]!,
      'code': 'ValueListenableBuilder<ClipboardStatus>(\n'
          '  valueListenable: _clipboard,\n'
          '  builder: (context, status, child) {\n'
          '    final canPaste =\n'
          '      status == ClipboardStatus.pasteable;\n'
          '    return IconButton(\n'
          '      icon: Icon(Icons.content_paste),\n'
          '      onPressed: canPaste ? _doPaste : null,\n'
          '      color: canPaste\n'
          '        ? Theme.of(context).primaryColor\n'
          '        : Colors.grey,\n'
          '    );\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Switch on Status',
      'color': Colors.blueGrey[600]!,
      'code': 'Widget buildPasteIndicator(ClipboardStatus status) {\n'
          '  return switch (status) {\n'
          '    ClipboardStatus.pasteable => Icon(\n'
          '      Icons.content_paste_go,\n'
          '      color: Colors.green,\n'
          '    ),\n'
          '    ClipboardStatus.notPasteable => Icon(\n'
          '      Icons.content_paste_off,\n'
          '      color: Colors.red,\n'
          '    ),\n'
          '    ClipboardStatus.unknown => SizedBox(\n'
          '      width: 24, height: 24,\n'
          '      child: CircularProgressIndicator(\n'
          '        strokeWidth: 2,\n'
          '      ),\n'
          '    ),\n'
          '  };\n'
          '}',
    },
    {
      'title': 'Force Update After Copy',
      'color': Colors.cyan[600]!,
      'code': 'Future<void> _copyAndUpdate(String text) async {\n'
          '  await Clipboard.setData(\n'
          '    ClipboardData(text: text),\n'
          '  );\n'
          '  // Force immediate status refresh\n'
          '  _clipboard.update();\n'
          '}',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 8: Real-World Scenarios
  // ============================================================
  print('=== Section 8: Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'name': 'Text Editor Toolbar',
      'icon': Icons.edit,
      'color': Colors.blueGrey[700]!,
      'description': 'A rich text editor with cut/copy/paste buttons. The '
          'paste button observes ClipboardStatus. Cut and copy are always '
          'enabled (when text is selected), but paste dynamically reflects '
          'the clipboard state.',
      'flow': [
        'App starts → paste button: unknown (loading)',
        'First poll → clipboard empty → paste: disabled',
        'User copies text in browser → next poll → paste: enabled',
        'User taps paste → text inserted → paste stays enabled',
        'User clears clipboard → next poll → paste: disabled',
      ],
    },
    {
      'name': 'Selection Toolbar',
      'icon': Icons.select_all,
      'color': Colors.cyan[700]!,
      'description': 'The selection toolbar that appears when you long-press '
          'or double-tap text. Shows cut/copy/paste/select-all. On Android '
          'and iOS, there is special handling for the paste button visibility '
          'in the selection toolbar.',
      'flow': [
        'User long-presses text → toolbar appears',
        'ClipboardStatusNotifier queried for paste state',
        'If pasteable → "Paste" action shown',
        'If notPasteable → "Paste" omitted from toolbar',
        'If unknown → small delay then show/hide paste',
      ],
    },
    {
      'name': 'Password Manager',
      'icon': Icons.lock,
      'color': Colors.blueGrey[600]!,
      'description': 'A password manager that auto-clears the clipboard '
          'after 30 seconds. The ClipboardStatus transitions from pasteable '
          'to notPasteable after the timer fires and clears the clipboard.',
      'flow': [
        'User taps "Copy Password" → Clipboard.setData()',
        'Notifier.update() → status: pasteable',
        '30-second timer starts',
        'Timer fires → Clipboard.setData(empty)',
        'Notifier.update() → status: notPasteable',
      ],
    },
  ];

  print('  Prepared ${scenarios.length} scenarios');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Don\'t Poll Too Frequently',
      'body': 'The default polling interval is reasonable, but custom '
          'implementations should avoid polling more than once per second. '
          'Clipboard access on some platforms involves IPC and can be '
          'expensive. Use update() for one-off refreshes instead.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Web Platform Limitations',
      'body': 'On the web, clipboard access requires user gesture or '
          'Permissions API. The status may remain "unknown" if the browser '
          'denies access. Always handle the unknown state gracefully — '
          'consider showing the paste button anyway on web.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with canPaste()',
      'body': 'ClipboardStatus tells you if paste is available. But also '
          'check if the target field accepts paste (not readOnly, has focus, '
          'etc.). A paste button should be enabled only when both clipboard '
          'is pasteable AND the field can receive input.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Dispose the Notifier',
      'body': 'A forgotten ClipboardStatusNotifier continues polling in the '
          'background, wasting resources and potentially causing errors '
          'if the widget is disposed. Always call dispose() in your '
          'State.dispose() method.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Enum Exhaustiveness',
      'body': 'Dart\'s switch expression on an enum is exhaustive. Using '
          'switch(status) { ClipboardStatus.pasteable => ..., '
          'ClipboardStatus.notPasteable => ..., ClipboardStatus.unknown '
          '=> ... } guarantees all cases are handled at compile time.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Accessibility Consideration',
      'body': 'When the paste button is disabled due to notPasteable, '
          'provide a tooltip explaining why: "Nothing to paste" or '
          '"Clipboard is empty". Screen readers need this context to '
          'convey the button state to users.',
      'severity': 'tip',
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
      title: Text('ClipboardStatus'),
      backgroundColor: Colors.blueGrey[700],
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
                colors: [Colors.blueGrey[700]!, Colors.cyan[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.content_paste, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ClipboardStatus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Enum representing the system clipboard\'s paste '
                  'availability state. Three values — pasteable, '
                  'notPasteable, and unknown — drive paste button '
                  'visibility throughout the framework.',
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
          _csHead('1', 'What is ClipboardStatus?'),
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

          // ── Section 2: Enum Values ──
          _csHead('2', 'The Three Values'),
          SizedBox(height: 12),
          ...enumValues.map((ev) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ev['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(14),
                    border: Border(
                      left: BorderSide(
                          color: ev['color'] as Color, width: 5),
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
                        Icon(ev['icon'] as IconData,
                            color: ev['color'] as Color, size: 28),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(ev['name'] as String,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 10),
                      _csChip('Meaning', ev['meaning'] as String,
                          ev['color'] as Color),
                      SizedBox(height: 6),
                      _csChip('UI Effect', ev['uiEffect'] as String,
                          ev['color'] as Color),
                      SizedBox(height: 6),
                      _csChip('When', ev['when'] as String,
                          ev['color'] as Color),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: (ev['color'] as Color).withOpacity(0.3)),
                        ),
                        child: Text(ev['scenario'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: State Transitions ──
          _csHead('3', 'State Transitions'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
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
              children: transitions.map((t) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(children: [
                      Container(
                        width: 80,
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: (t['fromColor'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: t['fromColor'] as Color, width: 1),
                        ),
                        child: Center(
                          child: Text(t['from'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: t['fromColor'] as Color)),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(t['icon'] as IconData,
                          size: 16, color: Colors.blueGrey[400]),
                      SizedBox(width: 6),
                      Container(
                        width: 80,
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: (t['toColor'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: t['toColor'] as Color, width: 1),
                        ),
                        child: Center(
                          child: Text(t['to'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: t['toColor'] as Color)),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(t['trigger'] as String,
                            style: TextStyle(
                                fontSize: 9, color: Colors.grey[600])),
                      ),
                    ]),
                  )).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 4: Notifier Details ──
          _csHead('4', 'ClipboardStatusNotifier'),
          SizedBox(height: 12),
          ...notifierDetails.map((nd) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: nd['color'] as Color, width: 4),
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
                        Icon(nd['icon'] as IconData,
                            color: nd['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(nd['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      ...(nd['items'] as List<String>).map((item) => Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('• ',
                                    style: TextStyle(
                                        color: nd['color'] as Color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                Expanded(
                                  child: Text(item,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                          height: 1.3)),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: UI Patterns ──
          _csHead('5', 'UI Pattern Showcase'),
          SizedBox(height: 12),
          ...uiPatterns.map((up) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(up['name'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey[900])),
                      SizedBox(height: 4),
                      Text(up['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              height: 1.3)),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: (up['states']
                                  as List<Map<String, dynamic>>)
                              .map((s) => Column(children: [
                                    Opacity(
                                      opacity: s['opacity'] as double,
                                      child: Icon(
                                          s['icon'] as IconData,
                                          color: s['color'] as Color,
                                          size: 28),
                                    ),
                                    SizedBox(height: 4),
                                    Text(s['status'] as String,
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: Colors.grey[600])),
                                  ]))
                              .toList()),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Comparison Table ──
          _csHead('6', 'Clipboard APIs Comparison'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 55,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('ClipboardStatus',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Clipboard.getData',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('SystemClipboard',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...apiComparisons.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 55,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['clipboardStatus'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.blueGrey[700]))),
                      Expanded(
                          child: Text(r['clipboardData'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['systemClipboard'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Code Patterns ──
          _csHead('7', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
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
                      Text(cp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.cyan[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Scenarios ──
          _csHead('8', 'Real-World Scenarios'),
          SizedBox(height: 12),
          ...scenarios.map((sc) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: sc['color'] as Color, width: 4),
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
                        Icon(sc['icon'] as IconData,
                            color: sc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(sc['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(sc['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      ...(sc['flow'] as List<String>).asMap().entries.map(
                          (entry) => Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: Color.lerp(
                                              Colors.blueGrey[300],
                                              Colors.cyan[700],
                                              entry.key /
                                                  ((sc['flow'] as List)
                                                          .length -
                                                      1))!,
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: Center(
                                          child: Text(
                                              '${entry.key + 1}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontWeight:
                                                      FontWeight.bold)),
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(entry.value,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey[700],
                                                height: 1.3)),
                                      ),
                                    ]),
                              )),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _csHead('9', 'Tips & Gotchas'),
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
              'End of ClipboardStatus Deep Demo',
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
Widget _csHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.blueGrey[700],
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
// Helper: Info chip row
// ──────────────────────────────────────────────────────────
Widget _csChip(String label, String value, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color)),
      ),
      SizedBox(width: 6),
      Expanded(
        child: Text(value,
            style: TextStyle(
                fontSize: 11, color: Colors.grey[700], height: 1.3)),
      ),
    ],
  );
}
