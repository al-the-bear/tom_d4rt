// Deep visual test for RequestFocusIntent
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual exploration of RequestFocusIntent
/// An Intent that requests focus for a specific FocusNode.
///
/// RequestFocusIntent is part of Flutter's Actions/Shortcuts system:
/// - Extends Intent for use with Actions widget
/// - Targets a specific FocusNode
/// - Optional custom callback for focus behavior
/// - Default callback also ensures visibility in scrollables
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RequestFocusIntentDemo(),
  );
}

// =============================================================================
// PALETTE: Cyan 700 / Amber 400
// =============================================================================
const Color _kPrimary = Color(0xFF0097A7); // Cyan 700
const Color _kAccent = Color(0xFFFFCA28); // Amber 400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kFocused = Color(0xFF66BB6A);
const Color _kUnfocused = Color(0xFF78909C);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RequestFocusIntentDemo extends StatefulWidget {
  @override
  State<_RequestFocusIntentDemo> createState() => _RequestFocusIntentDemoState();
}

class _RequestFocusIntentDemoState extends State<_RequestFocusIntentDemo>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RequestFocusIntent Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.touch_app), text: 'Focus Lab'),
            Tab(icon: Icon(Icons.keyboard), text: 'Shortcuts'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _FocusLabTab(),
          _ShortcutsTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: THEORY
// =============================================================================
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildConstructorSection(),
          SizedBox(height: 24),
          _buildPropertiesSection(),
          SizedBox(height: 24),
          _buildCallbackSection(),
          SizedBox(height: 24),
          _buildActionsSystemSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.center_focus_strong, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RequestFocusIntent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'An Intent that programmatically requests focus for a specific '
            'FocusNode. Used with Flutter\'s Actions/Shortcuts system to '
            'enable keyboard-driven focus management.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard, color: _kAccent, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Part of Flutter\'s accessibility and keyboard navigation',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassHierarchySection() {
    return _TheoryCard(
      title: 'Class Hierarchy',
      icon: Icons.account_tree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HierarchyItem(level: 0, name: 'Intent', desc: 'Base intent class'),
                _HierarchyItem(level: 1, name: 'RequestFocusIntent', desc: 'Focus a specific node', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          _buildRelatedClasses(),
        ],
      ),
    );
  }

  Widget _buildRelatedClasses() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Related Classes:',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ClassChip('Intent', 'Base class'),
              _ClassChip('FocusNode', 'Target'),
              _ClassChip('Actions', 'Handler'),
              _ClassChip('Shortcuts', 'Keys'),
              _ClassChip('RequestFocusAction', 'Action'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConstructorSection() {
    return _TheoryCard(
      title: 'Constructor',
      icon: Icons.build,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAccent.withOpacity(0.3)),
            ),
            child: Text(
              '''const RequestFocusIntent(
  this.focusNode, {
  TraversalRequestFocusCallback? requestFocusCallback,
})''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 16),
          _ParameterRow(
            name: 'focusNode',
            type: 'FocusNode',
            description: 'The node that should receive focus when intent is invoked',
            isRequired: true,
          ),
          Divider(color: _kDivider, height: 24),
          _ParameterRow(
            name: 'requestFocusCallback',
            type: 'TraversalRequestFocusCallback?',
            description: 'Custom callback for how focus is requested. Defaults to '
                'defaultTraversalRequestFocusCallback',
            isRequired: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesSection() {
    return _TheoryCard(
      title: 'Properties',
      icon: Icons.settings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PropertyExplainer(
            name: 'focusNode',
            type: 'FocusNode',
            description: 'The FocusNode to focus. Must be attached to the widget tree '
                'when the intent is invoked. Can target any focusable widget.',
            codeExample: '''final myFocusNode = FocusNode();
// Attach to widget:
TextField(focusNode: myFocusNode)

// Create intent:
RequestFocusIntent(myFocusNode)''',
          ),
          Divider(color: _kDivider, height: 32),
          _PropertyExplainer(
            name: 'requestFocusCallback',
            type: 'TraversalRequestFocusCallback',
            description: 'How focus is actually requested. The default callback '
                'calls requestFocus() and ensures visibility if in a scrollable.',
            codeExample: '''// Typedef:
typedef TraversalRequestFocusCallback = 
    void Function(FocusNode node);

// Custom callback example:
RequestFocusIntent(
  focusNode,
  requestFocusCallback: (node) {
    print('Focusing: \${node.debugLabel}');
    node.requestFocus();
  },
)''',
          ),
        ],
      ),
    );
  }

  Widget _buildCallbackSection() {
    return _TheoryCard(
      title: 'Default Callback Behavior',
      icon: Icons.call_merge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The default callback (defaultTraversalRequestFocusCallback) does:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _StepList(
            steps: [
              'Calls focusNode.requestFocus()',
              'If widget is in a Scrollable, calls Scrollable.ensureVisible()',
              'Scrolls the focused widget into view with curve & duration',
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '''static void defaultTraversalRequestFocusCallback(
  FocusNode node,
  {Duration duration = const Duration(milliseconds: 100),
   Curve curve = Curves.ease}
) {
  node.requestFocus();
  // If in scrollable, ensures visibility...
}''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSystemSection() {
    return _TheoryCard(
      title: 'Integration with Actions/Shortcuts',
      icon: Icons.integration_instructions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FlowDiagram(),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '''// 1. Invoke directly:
Actions.invoke(
  context,
  RequestFocusIntent(focusNode),
);

// 2. Via shortcut:
Shortcuts(
  shortcuts: {
    SingleActivator(LogicalKeyboardKey.f1):
      RequestFocusIntent(focusNode),
  },
  child: Focus(child: ...),
)''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FlowBox(label: 'Shortcut\n(Key)', color: _kAccent),
          Icon(Icons.arrow_forward, color: _kTextSecondary),
          _FlowBox(label: 'Intent\n(What)', color: _kPrimary),
          Icon(Icons.arrow_forward, color: _kTextSecondary),
          _FlowBox(label: 'Action\n(How)', color: _kFocused),
          Icon(Icons.arrow_forward, color: _kTextSecondary),
          _FlowBox(label: 'FocusNode\n(Target)', color: Colors.purple),
        ],
      ),
    );
  }
}

class _FlowBox extends StatelessWidget {
  final String label;
  final Color color;

  const _FlowBox({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, height: 1.3),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// =============================================================================
// TAB 2: FOCUS LAB
// =============================================================================
class _FocusLabTab extends StatefulWidget {
  @override
  State<_FocusLabTab> createState() => _FocusLabTabState();
}

class _FocusLabTabState extends State<_FocusLabTab> {
  final List<FocusNode> _focusNodes = List.generate(6, (i) => FocusNode(debugLabel: 'Field ${i + 1}'));
  int? _currentFocusIndex;
  final List<String> _eventLog = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() => _onFocusChange(i));
    }
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onFocusChange(int index) {
    if (_focusNodes[index].hasFocus) {
      setState(() {
        _currentFocusIndex = index;
        _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: Focus → Field ${index + 1}');
        if (_eventLog.length > 8) _eventLog.removeLast();
      });
    }
  }

  void _requestFocus(int index) {
    final intent = RequestFocusIntent(_focusNodes[index]);
    Actions.invoke(context, intent);
    setState(() {
      _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: Intent sent for Field ${index + 1}');
      if (_eventLog.length > 8) _eventLog.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Current focus indicator
        Container(
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Row(
            children: [
              Icon(Icons.center_focus_strong, color: _kFocused),
              SizedBox(width: 12),
              Text(
                _currentFocusIndex != null
                    ? 'Currently focused: Field ${_currentFocusIndex! + 1}'
                    : 'No field focused',
                style: TextStyle(
                  color: _currentFocusIndex != null ? _kFocused : _kTextSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Fields grid
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final isFocused = _currentFocusIndex == index;
                return _FocusableField(
                  index: index,
                  focusNode: _focusNodes[index],
                  isFocused: isFocused,
                  onRequestFocus: () => _requestFocus(index),
                );
              },
            ),
          ),
        ),
        // Quick focus buttons
        Container(
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Focus (via RequestFocusIntent):',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(6, (i) {
                  final isFocused = _currentFocusIndex == i;
                  return ElevatedButton(
                    onPressed: () => _requestFocus(i),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFocused ? _kFocused : _kPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(48, 36),
                    ),
                    child: Text('${i + 1}'),
                  );
                }),
              ),
            ],
          ),
        ),
        // Event log
        Container(
          height: 120,
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event Log:',
                style: TextStyle(color: _kAccent, fontSize: 12),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: _eventLog
                      .map((e) => Text(
                            e,
                            style: TextStyle(
                              color: _kTextPrimary,
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FocusableField extends StatelessWidget {
  final int index;
  final FocusNode focusNode;
  final bool isFocused;
  final VoidCallback onRequestFocus;

  const _FocusableField({
    required this.index,
    required this.focusNode,
    required this.isFocused,
    required this.onRequestFocus,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isFocused ? _kFocused.withOpacity(0.15) : _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFocused ? _kFocused : _kDivider,
          width: isFocused ? 2 : 1,
        ),
        boxShadow: isFocused
            ? [BoxShadow(color: _kFocused.withOpacity(0.3), blurRadius: 12)]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isFocused ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: isFocused ? _kFocused : _kUnfocused,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Field ${index + 1}',
                style: TextStyle(
                  color: isFocused ? _kFocused : _kTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            width: 120,
            child: TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Type here...',
                hintStyle: TextStyle(color: _kTextSecondary, fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: _kFocused),
                ),
              ),
              style: TextStyle(color: _kTextPrimary, fontSize: 12),
            ),
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: onRequestFocus,
            child: Text(
              'Focus',
              style: TextStyle(color: _kAccent, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: SHORTCUTS
// =============================================================================
class _ShortcutsTab extends StatefulWidget {
  @override
  State<_ShortcutsTab> createState() => _ShortcutsTabState();
}

class _ShortcutsTabState extends State<_ShortcutsTab> {
  final _node1 = FocusNode(debugLabel: 'Email');
  final _node2 = FocusNode(debugLabel: 'Password');
  final _node3 = FocusNode(debugLabel: 'Submit');
  String _lastAction = 'None';
  final List<String> _eventLog = [];

  @override
  void dispose() {
    _node1.dispose();
    _node2.dispose();
    _node3.dispose();
    super.dispose();
  }

  void _logEvent(String event) {
    setState(() {
      _lastAction = event;
      _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
      if (_eventLog.length > 10) _eventLog.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.digit1, control: true):
            RequestFocusIntent(_node1),
        SingleActivator(LogicalKeyboardKey.digit2, control: true):
            RequestFocusIntent(_node2),
        SingleActivator(LogicalKeyboardKey.digit3, control: true):
            RequestFocusIntent(_node3),
      },
      child: Actions(
        actions: {
          RequestFocusIntent: CallbackAction<RequestFocusIntent>(
            onInvoke: (intent) {
              _logEvent('Shortcut: Focus ${intent.focusNode.debugLabel}');
              intent.focusNode.requestFocus();
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: Column(
            children: [
              // Instructions
              Container(
                padding: EdgeInsets.all(16),
                color: _kSurface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.keyboard, color: _kAccent),
                        SizedBox(width: 12),
                        Text(
                          'Keyboard Shortcuts Demo',
                          style: TextStyle(
                            color: _kTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Use these shortcuts to focus fields:',
                      style: TextStyle(color: _kTextSecondary),
                    ),
                    SizedBox(height: 8),
                    _ShortcutHint(keys: 'Ctrl+1', action: 'Focus Email'),
                    _ShortcutHint(keys: 'Ctrl+2', action: 'Focus Password'),
                    _ShortcutHint(keys: 'Ctrl+3', action: 'Focus Submit'),
                  ],
                ),
              ),
              // Form
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _FormField(
                        label: 'Email',
                        hint: 'Enter email...',
                        icon: Icons.email,
                        focusNode: _node1,
                        shortcut: 'Ctrl+1',
                      ),
                      SizedBox(height: 20),
                      _FormField(
                        label: 'Password',
                        hint: 'Enter password...',
                        icon: Icons.lock,
                        focusNode: _node2,
                        shortcut: 'Ctrl+2',
                        obscure: true,
                      ),
                      SizedBox(height: 20),
                      _SubmitButton(
                        focusNode: _node3,
                        shortcut: 'Ctrl+3',
                      ),
                      SizedBox(height: 32),
                      _CodePanel(),
                    ],
                  ),
                ),
              ),
              // Event log
              Container(
                height: 100,
                color: _kCardBg,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Action:',
                              style: TextStyle(color: _kTextSecondary, fontSize: 12),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _lastAction,
                              style: TextStyle(
                                color: _kAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(width: 1, color: _kDivider),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Event Log:',
                              style: TextStyle(color: _kTextSecondary, fontSize: 12),
                            ),
                            Expanded(
                              child: ListView(
                                children: _eventLog
                                    .map((e) => Text(
                                          e,
                                          style: TextStyle(
                                            color: _kTextPrimary,
                                            fontFamily: 'monospace',
                                            fontSize: 10,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShortcutHint extends StatelessWidget {
  final String keys;
  final String action;

  const _ShortcutHint({required this.keys, required this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kCardBg,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kDivider),
            ),
            child: Text(
              keys,
              style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            action,
            style: TextStyle(color: _kTextPrimary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final FocusNode focusNode;
  final String shortcut;
  final bool obscure;

  const _FormField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.focusNode,
    required this.shortcut,
    this.obscure = false,
  });

  @override
  State<_FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<_FormField> {
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _hasFocus = widget.focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _hasFocus ? _kFocused.withOpacity(0.1) : _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _hasFocus ? _kFocused : _kDivider,
          width: _hasFocus ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: _hasFocus ? _kFocused : _kTextSecondary, size: 20),
              SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hasFocus ? _kFocused : _kTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.shortcut,
                  style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          TextField(
            focusNode: widget.focusNode,
            obscureText: widget.obscure,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: _kTextSecondary),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: _kFocused, width: 2),
              ),
            ),
            style: TextStyle(color: _kTextPrimary),
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final FocusNode focusNode;
  final String shortcut;

  const _SubmitButton({required this.focusNode, required this.shortcut});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _hasFocus = widget.focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: Focus(
        focusNode: widget.focusNode,
        child: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _hasFocus ? _kFocused : _kPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Submit', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.shortcut,
                      style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CodePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: _kAccent, size: 18),
              SizedBox(width: 8),
              Text(
                'Code Example',
                style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '''Shortcuts(
  shortcuts: {
    SingleActivator(
      LogicalKeyboardKey.digit1,
      control: true,
    ): RequestFocusIntent(emailFocusNode),
  },
  child: Actions(
    actions: {
      RequestFocusIntent: RequestFocusAction(),
    },
    child: myForm,
  ),
)''',
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================
class _TheoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _TheoryCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _kDivider)),
            ),
            child: Row(
              children: [
                Icon(icon, color: _kAccent, size: 22),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _HierarchyItem extends StatelessWidget {
  final int level;
  final String name;
  final String desc;
  final bool isHighlighted;

  const _HierarchyItem({
    required this.level,
    required this.name,
    required this.desc,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0, top: level > 0 ? 8 : 0),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: _kDivider),
                  bottom: BorderSide(color: _kDivider),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isHighlighted ? _kAccent.withOpacity(0.2) : _kCardBg,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isHighlighted ? _kAccent : _kDivider,
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: isHighlighted ? _kAccent : _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            desc,
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ClassChip extends StatelessWidget {
  final String name;
  final String role;

  const _ClassChip(this.name, this.role);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              color: _kAccent,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
          Text(
            role,
            style: TextStyle(color: _kTextSecondary, fontSize: 9),
          ),
        ],
      ),
    );
  }
}

class _ParameterRow extends StatelessWidget {
  final String name;
  final String type;
  final String description;
  final bool isRequired;

  const _ParameterRow({
    required this.name,
    required this.type,
    required this.description,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isRequired)
          Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              'required',
              style: TextStyle(color: Colors.red, fontSize: 9),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  type,
                  style: TextStyle(
                    color: _kTextSecondary,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            SizedBox(
              width: 280,
              child: Text(
                description,
                style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PropertyExplainer extends StatelessWidget {
  final String name;
  final String type;
  final String description;
  final String codeExample;

  const _PropertyExplainer({
    required this.name,
    required this.type,
    required this.description,
    required this.codeExample,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: _kAccent,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              type,
              style: TextStyle(
                color: _kTextSecondary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(color: _kTextPrimary, height: 1.5),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            codeExample,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepList extends StatelessWidget {
  final List<String> steps;

  const _StepList({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: _kPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${entry.key + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.value,
                  style: TextStyle(color: _kTextPrimary, height: 1.4),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
