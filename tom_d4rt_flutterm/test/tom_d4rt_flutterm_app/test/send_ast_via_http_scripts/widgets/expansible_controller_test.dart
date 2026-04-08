// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ExpansibleController
// Demonstrates ExpansibleController — a controller for managing
// the expand/collapse state of expansible widgets such as
// ExpansionTile. Enables programmatic control over expansion,
// listening to state changes, and coordinating multiple panels.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExpansibleController Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ExpansibleController?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.unfold_more,
      'title': 'Programmatic Expansion Control',
      'body': 'ExpansibleController is a ChangeNotifier that manages '
          'the expanded/collapsed state of an expansible widget. '
          'Pass it to ExpansionTile\'s controller parameter to '
          'expand or collapse the tile from code, listen for '
          'state changes, and query the current state.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.hearing,
      'title': 'Reactive State with ChangeNotifier',
      'body': 'Because ExpansibleController extends ChangeNotifier, '
          'you can addListener() to react when the expansion state '
          'changes. This enables building dependent UI — disable a '
          'button when a section is collapsed, update a summary '
          'when expanded, etc.',
      'accent': Colors.blue[700]!,
    },
    {
      'icon': Icons.link,
      'title': 'Controller Pattern',
      'body': 'Just like ScrollController for scrollable widgets or '
          'TextEditingController for text fields, ExpansibleController '
          'follows Flutter\'s controller pattern: create in initState, '
          'pass to the widget, use methods/properties, dispose in '
          'dispose().',
      'accent': Colors.indigo[600]!,
    },
    {
      'icon': Icons.playlist_add_check,
      'title': 'One Controller Per Tile',
      'body': 'Each ExpansionTile gets its own controller. To coordinate '
          'multiple tiles (e.g., accordion behavior where only one is '
          'open), manage multiple controllers and collapse others when '
          'one expands. This gives full flexibility.',
      'accent': Colors.blue[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties & Methods
  // ============================================================
  print('=== Section 2: Properties & Methods ===');

  final members = <Map<String, dynamic>>[
    {
      'name': 'isExpanded',
      'kind': 'Property',
      'type': 'bool',
      'icon': Icons.expand_more,
      'color': Colors.indigo[700]!,
      'description': 'Returns whether the controller is in expanded '
          'state. Read this to conditionally render UI based on '
          'expansion. When the value changes, listeners are notified.',
    },
    {
      'name': 'expand()',
      'kind': 'Method',
      'type': 'void',
      'icon': Icons.unfold_more,
      'color': Colors.blue[700]!,
      'description': 'Programmatically expand the tile. If already '
          'expanded, this is a no-op. Triggers the expansion animation '
          'and notifies listeners. Equivalent to the user tapping the '
          'tile header to open it.',
    },
    {
      'name': 'collapse()',
      'kind': 'Method',
      'type': 'void',
      'icon': Icons.unfold_less,
      'color': Colors.indigo[600]!,
      'description': 'Programmatically collapse the tile. If already '
          'collapsed, this is a no-op. Triggers the collapse animation '
          'and notifies listeners. Equivalent to the user tapping the '
          'header to close it.',
    },
    {
      'name': 'value',
      'kind': 'Property',
      'type': 'bool',
      'icon': Icons.data_usage,
      'color': Colors.blue[600]!,
      'description': 'Alias for isExpanded. Returns the current boolean '
          'value of the expansion state. Follows the ValueNotifier '
          'convention where .value gives the current state.',
    },
    {
      'name': 'addListener()',
      'kind': 'Method (inherited)',
      'type': 'void',
      'icon': Icons.hearing,
      'color': Colors.indigo[500]!,
      'description': 'Register a callback to be invoked whenever the '
          'expansion state changes. Inherited from ChangeNotifier. '
          'Always pair with removeListener() in dispose to avoid '
          'memory leaks.',
    },
    {
      'name': 'dispose()',
      'kind': 'Method (inherited)',
      'type': 'void',
      'icon': Icons.delete_outline,
      'color': Colors.blue[500]!,
      'description': 'Release resources. Call in your State\'s dispose() '
          'method. After dispose, calling expand/collapse or accessing '
          'isExpanded throws an error.',
    },
  ];

  print('  Prepared ${members.length} members');

  // ============================================================
  // SECTION 3: State Diagram
  // ============================================================
  print('=== Section 3: State Diagram ===');

  final stateTransitions = <Map<String, dynamic>>[
    {
      'from': 'Collapsed',
      'to': 'Expanding',
      'trigger': 'expand() or user tap',
      'icon': Icons.play_arrow,
    },
    {
      'from': 'Expanding',
      'to': 'Expanded',
      'trigger': 'Animation completes',
      'icon': Icons.check,
    },
    {
      'from': 'Expanded',
      'to': 'Collapsing',
      'trigger': 'collapse() or user tap',
      'icon': Icons.play_arrow,
    },
    {
      'from': 'Collapsing',
      'to': 'Collapsed',
      'trigger': 'Animation completes',
      'icon': Icons.check,
    },
  ];

  print('  Prepared ${stateTransitions.length} state transitions');

  // ============================================================
  // SECTION 4: ExpansionTile Integration
  // ============================================================
  print('=== Section 4: ExpansionTile Integration ===');

  final integrationSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Create Controller',
      'color': Colors.indigo[700]!,
      'detail': 'In initState(), create the ExpansibleController. '
          'Optionally set the initial expanded state via the '
          'constructor parameter.',
      'code': 'late final _controller =\n'
          '    ExpansibleController();',
    },
    {
      'step': 2,
      'title': 'Pass to ExpansionTile',
      'color': Colors.blue[700]!,
      'detail': 'Assign the controller to ExpansionTile\'s controller '
          'parameter. The tile reads isExpanded from the controller '
          'and responds to expand/collapse calls.',
      'code': 'ExpansionTile(\n'
          '  controller: _controller,\n'
          '  title: Text(\'Settings\'),\n'
          '  children: [ /* content */ ],\n'
          ')',
    },
    {
      'step': 3,
      'title': 'Use Programmatically',
      'color': Colors.indigo[600]!,
      'detail': 'Call expand() or collapse() from button handlers, '
          'gestures, or async operations. Query isExpanded anytime '
          'to check current state.',
      'code': 'ElevatedButton(\n'
          '  onPressed: () {\n'
          '    if (_controller.isExpanded) {\n'
          '      _controller.collapse();\n'
          '    } else {\n'
          '      _controller.expand();\n'
          '    }\n'
          '  },\n'
          '  child: Text(\'Toggle\'),\n'
          ')',
    },
    {
      'step': 4,
      'title': 'Listen for Changes',
      'color': Colors.blue[600]!,
      'detail': 'Add a listener to react when expansion state changes. '
          'Common uses: update external state, animate other widgets, '
          'log analytics events.',
      'code': '_controller.addListener(() {\n'
          '  print(_controller.isExpanded\n'
          '      ? \'Expanded!\'\n'
          '      : \'Collapsed!\');\n'
          '});',
    },
    {
      'step': 5,
      'title': 'Dispose',
      'color': Colors.indigo[500]!,
      'detail': 'Call dispose() in the State\'s dispose method to '
          'release the controller and its listeners. Failing to '
          'dispose causes memory leaks.',
      'code': '@override\n'
          'void dispose() {\n'
          '  _controller.dispose();\n'
          '  super.dispose();\n'
          '}',
    },
  ];

  print('  Prepared ${integrationSteps.length} integration steps');

  // ============================================================
  // SECTION 5: Programmatic Control
  // ============================================================
  print('=== Section 5: Programmatic Control ===');

  final controlExamples = <Map<String, dynamic>>[
    {
      'title': 'Expand All',
      'icon': Icons.unfold_more,
      'color': Colors.indigo[700]!,
      'description': 'Expand every panel at once — useful for a '
          '"Show All" button in an FAQ or settings page.',
      'code': 'void expandAll() {\n'
          '  for (final c in _controllers) {\n'
          '    c.expand();\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Collapse All',
      'icon': Icons.unfold_less,
      'color': Colors.blue[700]!,
      'description': 'Collapse every panel — useful for a "Reset" or '
          '"Collapse All" toolbar action.',
      'code': 'void collapseAll() {\n'
          '  for (final c in _controllers) {\n'
          '    c.collapse();\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Accordion (Only One Open)',
      'icon': Icons.view_day,
      'color': Colors.indigo[600]!,
      'description': 'When one panel expands, collapse all others. '
          'Implement by listening to each controller and collapsing '
          'siblings on change.',
      'code': 'void _onExpand(int index) {\n'
          '  for (int i = 0;\n'
          '       i < _controllers.length;\n'
          '       i++) {\n'
          '    if (i != index) {\n'
          '      _controllers[i].collapse();\n'
          '    }\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Delayed Expand',
      'icon': Icons.timer,
      'color': Colors.blue[600]!,
      'description': 'Expand a section after a delay — for guided tours, '
          'onboarding flows, or timed reveals.',
      'code': 'Future.delayed(\n'
          '  Duration(seconds: 2),\n'
          '  () {\n'
          '    if (mounted) {\n'
          '      _controller.expand();\n'
          '    }\n'
          '  },\n'
          ');',
    },
  ];

  print('  Prepared ${controlExamples.length} control examples');

  // ============================================================
  // SECTION 6: Code Patterns
  // ============================================================
  print('=== Section 6: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Full Lifecycle Example',
      'color': Colors.indigo[700]!,
      'code': 'class _SettingsState extends State<Settings> {\n'
          '  late final _generalCtrl =\n'
          '      ExpansibleController();\n'
          '  late final _advancedCtrl =\n'
          '      ExpansibleController();\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _generalCtrl.addListener(_onChanged);\n'
          '    _advancedCtrl.addListener(_onChanged);\n'
          '  }\n'
          '\n'
          '  void _onChanged() => setState(() {});\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _generalCtrl.dispose();\n'
          '    _advancedCtrl.dispose();\n'
          '    super.dispose();\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    return Column(children: [\n'
          '      ExpansionTile(\n'
          '        controller: _generalCtrl,\n'
          '        title: Text(\'General\'),\n'
          '        children: [/* ... */],\n'
          '      ),\n'
          '      ExpansionTile(\n'
          '        controller: _advancedCtrl,\n'
          '        title: Text(\'Advanced\'),\n'
          '        children: [/* ... */],\n'
          '      ),\n'
          '    ]);\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Conditional Content Based on State',
      'color': Colors.blue[700]!,
      'code': '// Show summary when collapsed,\n'
          '// full form when expanded\n'
          'Column(\n'
          '  children: [\n'
          '    ExpansionTile(\n'
          '      controller: _controller,\n'
          '      title: Text(\'Details\'),\n'
          '      children: [\n'
          '        _buildFullForm(),\n'
          '      ],\n'
          '    ),\n'
          '    if (!_controller.isExpanded)\n'
          '      Padding(\n'
          '        padding: EdgeInsets.all(12),\n'
          '        child: Text(\n'
          '          \'Tap to view all details\',\n'
          '          style: TextStyle(\n'
          '            color: Colors.grey,\n'
          '          ),\n'
          '        ),\n'
          '      ),\n'
          '  ],\n'
          ')',
    },
    {
      'title': 'Accordion Pattern',
      'color': Colors.indigo[600]!,
      'code': '// Only one panel open at a time\n'
          'final _controllers = List.generate(\n'
          '  5,\n'
          '  (_) => ExpansibleController(),\n'
          ');\n'
          '\n'
          '@override\n'
          'void initState() {\n'
          '  super.initState();\n'
          '  for (int i = 0;\n'
          '       i < _controllers.length;\n'
          '       i++) {\n'
          '    _controllers[i].addListener(() {\n'
          '      if (_controllers[i].isExpanded) {\n'
          '        for (int j = 0;\n'
          '             j < _controllers.length;\n'
          '             j++) {\n'
          '          if (j != i) {\n'
          '            _controllers[j].collapse();\n'
          '          }\n'
          '        }\n'
          '      }\n'
          '    });\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Expand on Search Match',
      'color': Colors.blue[600]!,
      'code': '// Auto-expand sections that match\n'
          '// the search query\n'
          'void _onSearch(String query) {\n'
          '  for (int i = 0;\n'
          '       i < _sections.length;\n'
          '       i++) {\n'
          '    final matches = _sections[i]\n'
          '        .content\n'
          '        .contains(query);\n'
          '    if (matches) {\n'
          '      _controllers[i].expand();\n'
          '    } else {\n'
          '      _controllers[i].collapse();\n'
          '    }\n'
          '  }\n'
          '}',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 7: Multiple Controller Coordination
  // ============================================================
  print('=== Section 7: Coordination ===');

  final coordinationRows = <Map<String, dynamic>>[
    {
      'pattern': 'Independent',
      'description': 'Each tile operates independently. Multiple tiles '
          'can be open at the same time. Simplest pattern.',
      'icon': Icons.grid_view,
      'color': Colors.indigo[700]!,
    },
    {
      'pattern': 'Accordion',
      'description': 'Only one tile can be open at a time. When one '
          'expands, all others collapse. Classic FAQ pattern.',
      'icon': Icons.view_day,
      'color': Colors.blue[700]!,
    },
    {
      'pattern': 'Group Toggle',
      'description': 'All tiles expand or collapse together via a '
          '"Show All" / "Hide All" button. Settings pages.',
      'icon': Icons.select_all,
      'color': Colors.indigo[600]!,
    },
    {
      'pattern': 'Dependent',
      'description': 'Expanding tile A enables tile B\'s expansion. '
          'Collapsing A also forces B to collapse. Wizard flow.',
      'icon': Icons.account_tree,
      'color': Colors.blue[600]!,
    },
    {
      'pattern': 'Sequential',
      'description': 'Tiles must be opened in order. Tile 2 only '
          'becomes expandable after tile 1 is completed. Stepper.',
      'icon': Icons.linear_scale,
      'color': Colors.indigo[500]!,
    },
  ];

  print('  Prepared ${coordinationRows.length} coordination patterns');

  // ============================================================
  // SECTION 8: Comparison
  // ============================================================
  print('=== Section 8: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Type',
      'expansible': 'ChangeNotifier',
      'scrollCtrl': 'ChangeNotifier',
      'textCtrl': 'ValueNotifier<TextEditingValue>',
      'tabCtrl': 'ChangeNotifier',
    },
    {
      'aspect': 'State',
      'expansible': 'bool (expanded/collapsed)',
      'scrollCtrl': 'double (offset)',
      'textCtrl': 'TextEditingValue',
      'tabCtrl': 'int (tab index)',
    },
    {
      'aspect': 'Main Action',
      'expansible': 'expand() / collapse()',
      'scrollCtrl': 'animateTo() / jumpTo()',
      'textCtrl': 'text = "..." / clear()',
      'tabCtrl': 'animateTo(index)',
    },
    {
      'aspect': 'Widget',
      'expansible': 'ExpansionTile',
      'scrollCtrl': 'ListView / ScrollView',
      'textCtrl': 'TextField / TextFormField',
      'tabCtrl': 'TabBar / TabBarView',
    },
    {
      'aspect': 'Dispose Needed',
      'expansible': 'Yes',
      'scrollCtrl': 'Yes',
      'textCtrl': 'Yes',
      'tabCtrl': 'Yes (with vsync)',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Always Dispose Controllers',
      'body': 'ExpansibleController extends ChangeNotifier which holds '
          'listener references. Call dispose() in your State\'s '
          'dispose() method. For lists of controllers, iterate and '
          'dispose each one.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Reuse Controllers',
      'body': 'Each ExpansionTile needs its own controller. Sharing '
          'a controller between two tiles causes both to animate '
          'together. If you want synchronized behavior, use '
          'listeners to coordinate separate controllers.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Initial Expanded State',
      'body': 'The ExpansionTile\'s initiallyExpanded parameter still '
          'works when no controller is provided. When using a '
          'controller, set the initial state at construction time '
          'or call expand() in initState after the first frame.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Avoid Calling expand/collapse in build()',
      'body': 'Calling expand() or collapse() inside the build method '
          'can trigger infinite rebuilds. Always call them from event '
          'handlers, initState\'s post-frame callback, or listener '
          'callbacks — never during build.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'ListenableBuilder for Reactive UI',
      'body': 'Wrap dependent UI in ListenableBuilder(listenable: '
          'controller, builder: ...) for widgets that rebuild when '
          'expansion changes. This avoids calling setState at the '
          'parent level for small UI updates.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test with Controller',
      'body': 'In widget tests, create a controller and pass it to '
          'ExpansionTile. Then call controller.expand() to test '
          'expanded states without simulating taps. Makes tests '
          'more reliable and less flaky.',
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
      title: Text('ExpansibleController'),
      backgroundColor: Colors.indigo[700],
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
                colors: [Colors.indigo[700]!, Colors.blue[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.unfold_more, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ExpansibleController',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A ChangeNotifier controller for managing the '
                  'expand/collapse state of ExpansionTile and similar '
                  'expansible widgets. Enables programmatic control, '
                  'state listening, and multi-panel coordination.',
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
          _ecHead('1', 'What is ExpansibleController?'),
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

          // ── Section 2: Properties & Methods ──
          _ecHead('2', 'Properties & Methods'),
          SizedBox(height: 12),
          ...members.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: m['color'] as Color, width: 4),
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
                        Icon(m['icon'] as IconData,
                            color: m['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(m['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                        _ecTag(m['kind'] as String, m['color'] as Color),
                      ]),
                      SizedBox(height: 6),
                      Text(m['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: State Diagram ──
          _ecHead('3', 'State Transitions'),
          SizedBox(height: 12),
          Container(
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
              children: [
                Text('Expansion State Machine',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[800])),
                SizedBox(height: 14),
                ...stateTransitions.asMap().entries.map((entry) {
                  final t = entry.value;
                  final index = entry.key;
                  final isForward = index < 2;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(children: [
                      // From state
                      Container(
                        width: 72,
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        decoration: BoxDecoration(
                          color: isForward
                              ? Colors.indigo[50]
                              : Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: isForward
                                  ? Colors.indigo[300]!
                                  : Colors.blue[300]!),
                        ),
                        child: Center(
                          child: Text(t['from'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 6),
                      // Arrow
                      Icon(t['icon'] as IconData,
                          size: 14,
                          color: isForward
                              ? Colors.indigo[400]
                              : Colors.blue[400]),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: isForward
                              ? Colors.indigo[200]
                              : Colors.blue[200],
                        ),
                      ),
                      Icon(Icons.arrow_forward,
                          size: 12,
                          color: isForward
                              ? Colors.indigo[400]
                              : Colors.blue[400]),
                      SizedBox(width: 6),
                      // To state
                      Container(
                        width: 72,
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        decoration: BoxDecoration(
                          color: isForward
                              ? Colors.indigo[50]
                              : Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: isForward
                                  ? Colors.indigo[300]!
                                  : Colors.blue[300]!),
                        ),
                        child: Center(
                          child: Text(t['to'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 8),
                      // Trigger label
                      Expanded(
                        flex: 2,
                        child: Text(t['trigger'] as String,
                            style: TextStyle(
                                fontSize: 8,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600])),
                      ),
                    ]),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 4: ExpansionTile Integration ──
          _ecHead('4', 'ExpansionTile Integration'),
          SizedBox(height: 12),
          ...integrationSteps.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: s['color'] as Color, width: 4),
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
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: s['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text('${s['step']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(s['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(s['detail'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(s['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.blue[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Programmatic Control ──
          _ecHead('5', 'Programmatic Control Examples'),
          SizedBox(height: 12),
          ...controlExamples.map((ce) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ce['color'] as Color, width: 4),
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
                        Icon(ce['icon'] as IconData,
                            color: ce['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ce['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(ce['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(ce['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.blue[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Code Patterns ──
          _ecHead('6', 'Code Patterns'),
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
                                color: Colors.blue[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Multi-Controller Coordination ──
          _ecHead('7', 'Multi-Controller Coordination'),
          SizedBox(height: 12),
          ...coordinationRows.map((cr) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: cr['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(children: [
                    Icon(cr['icon'] as IconData,
                        color: cr['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cr['pattern'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                          SizedBox(height: 3),
                          Text(cr['description'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  height: 1.3)),
                        ],
                      ),
                    ),
                  ]),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Comparison ──
          _ecHead('8', 'Controller Comparison'),
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
                    EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.indigo[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 50,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                  Expanded(
                      child: Text('Expansible',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                  Expanded(
                      child: Text('Scroll',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                  Expanded(
                      child: Text('TextEditing',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                  Expanded(
                      child: Text('Tab',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6, vertical: 4),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 50,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 7,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['expansible'] as String,
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.indigo[700]))),
                      Expanded(
                          child: Text(r['scrollCtrl'] as String,
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['textCtrl'] as String,
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['tabCtrl'] as String,
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _ecHead('9', 'Tips & Gotchas'),
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
              'End of ExpansibleController Deep Demo',
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
Widget _ecHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.indigo[700],
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
// Helper: Tag label
// ──────────────────────────────────────────────────────────
Widget _ecTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold)),
  );
}
