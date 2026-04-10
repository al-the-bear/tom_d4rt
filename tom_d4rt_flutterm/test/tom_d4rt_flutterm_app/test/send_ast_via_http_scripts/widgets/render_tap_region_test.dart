// Deep visual test for RenderTapRegion
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

/// Deep visual exploration of RenderTapRegion
/// The render object that detects taps inside and outside its bounds.
///
/// RenderTapRegion extends RenderProxyBoxWithHitTestBehavior and provides:
/// - Four callback types: onTapOutside, onTapInside, onTapUpOutside, onTapUpInside
/// - enabled property to control callback invocation
/// - consumeOutsideTaps to prevent tap propagation
/// - groupId for treating multiple regions as one logical unit
/// - Registration with TapRegionRegistry (usually via TapRegionSurface)
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RenderTapRegionDemo(),
  );
}

// =============================================================================
// PALETTE: Indigo 600 / Amber 400
// =============================================================================
const Color _kPrimary = Color(0xFF3949AB); // Indigo 600
const Color _kAccent = Color(0xFFFFCA28); // Amber 400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RenderTapRegionDemo extends StatefulWidget {
  @override
  State<_RenderTapRegionDemo> createState() => _RenderTapRegionDemoState();
}

class _RenderTapRegionDemoState extends State<_RenderTapRegionDemo>
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
        title: Text('RenderTapRegion Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.touch_app), text: 'Callbacks Lab'),
            Tab(icon: Icon(Icons.group_work), text: 'Group Behavior'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _CallbacksLabTab(),
          _GroupBehaviorTab(),
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
          _buildCallbackTypesSection(),
          SizedBox(height: 24),
          _buildPropertiesSection(),
          SizedBox(height: 24),
          _buildRegistrationSection(),
          SizedBox(height: 24),
          _buildComparisonSection(),
          SizedBox(height: 24),
          _buildUseCasesSection(),
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
              Icon(Icons.touch_app, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RenderTapRegion',
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
            'The render object that detects taps inside and outside its bounds, '
            'enabling dismiss-on-tap-outside patterns for menus, popups, and modals.',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Key Features:',
                  style: TextStyle(
                    color: _kAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildFeatureRow(Icons.arrow_downward, 'onTapOutside/onTapInside for PointerDownEvent'),
                _buildFeatureRow(Icons.arrow_upward, 'onTapUpOutside/onTapUpInside for PointerUpEvent'),
                _buildFeatureRow(Icons.toggle_on, 'enabled property to control callbacks'),
                _buildFeatureRow(Icons.block, 'consumeOutsideTaps prevents propagation'),
                _buildFeatureRow(Icons.group, 'groupId treats multiple regions as one'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white70, fontSize: 13),
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
          Text(
            'RenderTapRegion extends RenderProxyBoxWithHitTestBehavior:',
            style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HierarchyItem(level: 0, name: 'RenderObject', desc: 'Base render tree node'),
                _HierarchyItem(level: 1, name: 'RenderBox', desc: 'Box protocol'),
                _HierarchyItem(level: 2, name: 'RenderProxyBox', desc: 'Single child proxy'),
                _HierarchyItem(level: 3, name: 'RenderProxyBoxWithHitTestBehavior', desc: 'Hit test control'),
                _HierarchyItem(level: 4, name: 'RenderTapRegion', desc: 'Tap detection', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          _buildInfoBox(
            'RenderProxyBoxWithHitTestBehavior provides the behavior property that '
            'controls how hit testing works (opaque, translucent, deferToChild).',
            Icons.info_outline,
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
              '''RenderTapRegion({
  required TapRegionRegistry? registry,
  required bool enabled,
  bool consumeOutsideTaps = false,
  String? debugLabel,
  Object? groupId,
  TapRegionCallback? onTapOutside,
  TapRegionCallback? onTapInside,
  TapRegionUpCallback? onTapUpOutside,
  TapRegionUpCallback? onTapUpInside,
  RenderBox? child,
})''',
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 16),
          _ParameterTable(
            parameters: [
              _ParameterInfo('registry', 'TapRegionRegistry?', 'Registry for tap distribution (usually from TapRegionSurface)'),
              _ParameterInfo('enabled', 'bool', 'Whether callbacks are invoked'),
              _ParameterInfo('consumeOutsideTaps', 'bool', 'Whether to consume outside taps'),
              _ParameterInfo('debugLabel', 'String?', 'Label for debugging'),
              _ParameterInfo('groupId', 'Object?', 'Group identifier for treating regions as one'),
              _ParameterInfo('onTapOutside', 'TapRegionCallback?', 'Called on tap outside (PointerDownEvent)'),
              _ParameterInfo('onTapInside', 'TapRegionCallback?', 'Called on tap inside (PointerDownEvent)'),
              _ParameterInfo('onTapUpOutside', 'TapRegionUpCallback?', 'Called on tap up outside (PointerUpEvent)'),
              _ParameterInfo('onTapUpInside', 'TapRegionUpCallback?', 'Called on tap up inside (PointerUpEvent)'),
              _ParameterInfo('child', 'RenderBox?', 'The child render object'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallbackTypesSection() {
    return _TheoryCard(
      title: 'Callback Types',
      icon: Icons.call_received,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CallbackTypeCard(
            name: 'TapRegionCallback',
            signature: 'typedef TapRegionCallback = void Function(PointerDownEvent event)',
            description: 'Called when a pointer down event occurs inside or outside the region.',
            usedBy: ['onTapOutside', 'onTapInside'],
          ),
          SizedBox(height: 12),
          _CallbackTypeCard(
            name: 'TapRegionUpCallback',
            signature: 'typedef TapRegionUpCallback = void Function(PointerUpEvent event)',
            description: 'Called when a pointer up event occurs inside or outside the region.',
            usedBy: ['onTapUpOutside', 'onTapUpInside'],
          ),
          SizedBox(height: 16),
          _buildInfoBox(
            'Down callbacks fire immediately on touch/click, while Up callbacks fire '
            'when the pointer is released. Use Down for dismiss-on-tap, Up for complete actions.',
            Icons.lightbulb_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesSection() {
    return _TheoryCard(
      title: 'Key Properties',
      icon: Icons.settings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PropertyExplainer(
            name: 'enabled',
            type: 'bool',
            description: 'Controls whether callbacks are invoked. When false, the region '
                'is still registered with the registry but callbacks are skipped.',
            codeExample: '''// Disable callbacks temporarily
tapRegion.enabled = false; // Callbacks won't fire
tapRegion.enabled = true;  // Callbacks active again''',
          ),
          Divider(color: _kDivider, height: 32),
          _PropertyExplainer(
            name: 'consumeOutsideTaps',
            type: 'bool',
            description: 'When true, outside taps are consumed and won\'t propagate to '
                'other tap regions. Useful for modal behavior where only this region '
                'should respond.',
            codeExample: '''// Modal-like behavior
tapRegion.consumeOutsideTaps = true;
// Outside taps won't reach regions behind this one''',
          ),
          Divider(color: _kDivider, height: 32),
          _PropertyExplainer(
            name: 'groupId',
            type: 'Object?',
            description: 'Regions with the same groupId are treated as a single logical unit. '
                'A tap inside any region of the group counts as inside for all of them.',
            codeExample: '''// Group multiple regions
final menuGroup = Object();
region1.groupId = menuGroup;
region2.groupId = menuGroup;
// Tap in region2 won't trigger onTapOutside of region1''',
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationSection() {
    return _TheoryCard(
      title: 'Registration Lifecycle',
      icon: Icons.app_registration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RenderTapRegion registers with a TapRegionRegistry during its lifecycle:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _LifecycleStep(
            step: 1,
            title: 'attach()',
            description: 'When added to tree, calls _updateRegistration() to register '
                'with the registry if one is available.',
          ),
          _LifecycleStep(
            step: 2,
            title: 'Registry Notification',
            description: 'Registry (usually RenderTapRegionSurface) tracks all registered '
                'regions and distributes tap events to them.',
          ),
          _LifecycleStep(
            step: 3,
            title: 'Hit Test',
            description: 'When a tap occurs, registry performs hit test on all regions '
                'to determine which are inside vs outside.',
          ),
          _LifecycleStep(
            step: 4,
            title: 'Callback Invocation',
            description: 'Each region receives appropriate callback based on hit test '
                'results (inside/outside) and pointer event type (down/up).',
          ),
          _LifecycleStep(
            step: 5,
            title: 'detach()',
            isLast: true,
            description: 'When removed from tree, unregisters from the registry.',
          ),
          SizedBox(height: 16),
          _buildInfoBox(
            'Without a TapRegionSurface ancestor, RenderTapRegion won\'t receive '
            'any tap notifications because there\'s no registry to coordinate.',
            Icons.warning_amber,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'TapRegion vs RenderTapRegion vs TapRegionSurface',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ComparisonRow(
            name: 'TapRegion',
            type: 'Widget',
            description: 'High-level widget API. Wraps RenderTapRegion and provides '
                'easy-to-use callbacks for common use cases.',
          ),
          Divider(color: _kDivider, height: 24),
          _ComparisonRow(
            name: 'RenderTapRegion',
            type: 'RenderObject',
            description: 'The actual render object doing hit testing and callback '
                'invocation. Registers with TapRegionRegistry.',
          ),
          Divider(color: _kDivider, height: 24),
          _ComparisonRow(
            name: 'TapRegionSurface',
            type: 'Widget',
            description: 'Provides the TapRegionRegistry via InheritedWidget. Must be '
                'ancestor of TapRegion widgets for them to work.',
          ),
          Divider(color: _kDivider, height: 24),
          _ComparisonRow(
            name: 'RenderTapRegionSurface',
            type: 'RenderObject',
            description: 'Implements TapRegionRegistry, manages all regions, and '
                'distributes pointer events.',
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAccent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.layers, color: _kAccent, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Typical tree: TapRegionSurface → ... → TapRegion → child',
                    style: TextStyle(color: _kTextPrimary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCasesSection() {
    return _TheoryCard(
      title: 'Common Use Cases',
      icon: Icons.cases,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UseCaseItem(
            icon: Icons.menu,
            title: 'Dropdown Menus',
            description: 'Dismiss menu when user taps outside. Use onTapOutside to '
                'close the menu overlay.',
          ),
          _UseCaseItem(
            icon: Icons.chat_bubble,
            title: 'Popup Dialogs',
            description: 'Close popups on outside tap, optionally with consumeOutsideTaps '
                'to prevent interaction with background.',
          ),
          _UseCaseItem(
            icon: Icons.text_fields,
            title: 'Text Field Focus',
            description: 'Remove focus from text field when tapping elsewhere in the app.',
          ),
          _UseCaseItem(
            icon: Icons.edit,
            title: 'Inline Editing',
            description: 'Exit edit mode when user taps outside the editable area.',
          ),
          _UseCaseItem(
            icon: Icons.menu_book,
            title: 'Multi-Section Menus',
            description: 'Use groupId to keep submenu open when moving between menu sections.',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _kAccent, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: CALLBACKS LAB
// =============================================================================
class _CallbacksLabTab extends StatefulWidget {
  @override
  State<_CallbacksLabTab> createState() => _CallbacksLabTabState();
}

class _CallbacksLabTabState extends State<_CallbacksLabTab> {
  final List<_TapEvent> _events = [];
  bool _enabled = true;
  int _downOutsideCount = 0;
  int _downInsideCount = 0;
  int _upOutsideCount = 0;
  int _upInsideCount = 0;

  void _logEvent(String type, String position, Offset localPos) {
    setState(() {
      _events.insert(0, _TapEvent(
        type: type,
        position: position,
        localPos: localPos,
        timestamp: DateTime.now(),
      ));
      if (_events.length > 20) _events.removeLast();

      if (type == 'Down' && position == 'Outside') _downOutsideCount++;
      if (type == 'Down' && position == 'Inside') _downInsideCount++;
      if (type == 'Up' && position == 'Outside') _upOutsideCount++;
      if (type == 'Up' && position == 'Inside') _upInsideCount++;
    });
  }

  void _clearEvents() {
    setState(() {
      _events.clear();
      _downOutsideCount = 0;
      _downInsideCount = 0;
      _upOutsideCount = 0;
      _upInsideCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Controls bar
        Container(
          padding: EdgeInsets.all(12),
          color: _kSurface,
          child: Row(
            children: [
              Text('enabled:', style: TextStyle(color: _kTextSecondary)),
              SizedBox(width: 8),
              Switch(
                value: _enabled,
                onChanged: (v) => setState(() => _enabled = v),
                activeColor: _kAccent,
              ),
              Spacer(),
              TextButton.icon(
                onPressed: _clearEvents,
                icon: Icon(Icons.clear_all, color: _kAccent),
                label: Text('Clear', style: TextStyle(color: _kAccent)),
              ),
            ],
          ),
        ),
        // Counter badges
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: _kCardBg,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _CounterBadge('Down/Out', _downOutsideCount, Colors.orange),
              _CounterBadge('Down/In', _downInsideCount, Colors.green),
              _CounterBadge('Up/Out', _upOutsideCount, Colors.red),
              _CounterBadge('Up/In', _upInsideCount, Colors.blue),
            ],
          ),
        ),
        // Main interaction area
        Expanded(
          child: TapRegionSurface(
            child: Stack(
              children: [
                // Background tap area (outside)
                Positioned.fill(
                  child: Container(
                    color: _kSurface,
                    child: Center(
                      child: Text(
                        'Tap anywhere to test callbacks',
                        style: TextStyle(color: _kTextSecondary),
                      ),
                    ),
                  ),
                ),
                // Tap region in center
                Center(
                  child: TapRegion(
                    enabled: _enabled,
                    onTapOutside: (event) {
                      _logEvent('Down', 'Outside', event.localPosition);
                    },
                    onTapInside: (event) {
                      _logEvent('Down', 'Inside', event.localPosition);
                    },
                    onTapUpOutside: (event) {
                      _logEvent('Up', 'Outside', event.localPosition);
                    },
                    onTapUpInside: (event) {
                      _logEvent('Up', 'Inside', event.localPosition);
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_kPrimary, _kPrimary.withOpacity(0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _enabled ? _kAccent : _kDivider,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _kPrimary.withOpacity(0.4),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _enabled ? Icons.touch_app : Icons.do_not_touch,
                            color: _kAccent,
                            size: 48,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'TAP REGION',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _enabled ? 'Active' : 'Disabled',
                            style: TextStyle(
                              color: _enabled ? _kAccent : _kTextSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Event log
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: _kCardBg,
            border: Border(top: BorderSide(color: _kDivider)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.history, color: _kAccent, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Event Log',
                      style: TextStyle(
                        color: _kTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_events.length}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _events.isEmpty
                    ? Center(
                        child: Text(
                          'No events yet. Tap inside or outside the region.',
                          style: TextStyle(color: _kTextSecondary),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _events.length,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        itemBuilder: (context, index) {
                          final event = _events[index];
                          return _EventLogItem(event: event);
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TapEvent {
  final String type;
  final String position;
  final Offset localPos;
  final DateTime timestamp;

  _TapEvent({
    required this.type,
    required this.position,
    required this.localPos,
    required this.timestamp,
  });
}

class _CounterBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CounterBadge(this.label, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              '$count',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: _kTextSecondary, fontSize: 10),
        ),
      ],
    );
  }
}

class _EventLogItem extends StatelessWidget {
  final _TapEvent event;

  const _EventLogItem({required this.event});

  @override
  Widget build(BuildContext context) {
    final isInside = event.position == 'Inside';
    final isDown = event.type == 'Down';
    final color = isInside
        ? (isDown ? Colors.green : Colors.blue)
        : (isDown ? Colors.orange : Colors.red);

    return Container(
      margin: EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            isDown ? Icons.arrow_downward : Icons.arrow_upward,
            color: color,
            size: 16,
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              event.position,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
          SizedBox(width: 8),
          Text(
            'onTap${event.type}${event.position}',
            style: TextStyle(color: _kTextPrimary, fontSize: 12),
          ),
          Spacer(),
          Text(
            '(${event.localPos.dx.toInt()}, ${event.localPos.dy.toInt()})',
            style: TextStyle(color: _kTextSecondary, fontSize: 11, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: GROUP BEHAVIOR
// =============================================================================
class _GroupBehaviorTab extends StatefulWidget {
  @override
  State<_GroupBehaviorTab> createState() => _GroupBehaviorTabState();
}

class _GroupBehaviorTabState extends State<_GroupBehaviorTab> {
  bool _useGroupId = false;
  bool _consumeOutsideTaps = false;
  final Object _groupId = Object();

  final List<String> _logs = [];
  final Map<String, Color> _activeRegions = {};

  void _onTapRegion(String name, String type, Color color) {
    setState(() {
      _logs.insert(0, '$name: $type');
      if (_logs.length > 15) _logs.removeLast();

      if (type == 'Inside') {
        _activeRegions[name] = color;
      } else {
        _activeRegions.remove(name);
      }
    });

    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _activeRegions.remove(name);
        });
      }
    });
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
      _activeRegions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Controls
        Container(
          padding: EdgeInsets.all(12),
          color: _kSurface,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _ToggleControl(
                      label: 'Use groupId',
                      description: 'Regions act as one unit',
                      value: _useGroupId,
                      onChanged: (v) => setState(() => _useGroupId = v),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _ToggleControl(
                      label: 'consumeOutsideTaps',
                      description: 'Prevent propagation',
                      value: _consumeOutsideTaps,
                      onChanged: (v) => setState(() => _consumeOutsideTaps = v),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    _useGroupId ? Icons.link : Icons.link_off,
                    color: _useGroupId ? _kSuccess : _kTextSecondary,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _useGroupId
                          ? 'Regions A, B, C share the same groupId'
                          : 'Each region has independent groupId (null)',
                      style: TextStyle(color: _kTextSecondary, fontSize: 12),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _clearLogs,
                    icon: Icon(Icons.clear_all, color: _kAccent, size: 18),
                    label: Text('Clear', style: TextStyle(color: _kAccent, fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Tap regions demo
        Expanded(
          child: TapRegionSurface(
            child: Container(
              color: _kCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _GroupTapRegion(
                              name: 'A',
                              color: Colors.blue,
                              groupId: _useGroupId ? _groupId : null,
                              consumeOutsideTaps: _consumeOutsideTaps,
                              isActive: _activeRegions.containsKey('A'),
                              onTap: (type) => _onTapRegion('A', type, Colors.blue),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _GroupTapRegion(
                              name: 'B',
                              color: Colors.green,
                              groupId: _useGroupId ? _groupId : null,
                              consumeOutsideTaps: _consumeOutsideTaps,
                              isActive: _activeRegions.containsKey('B'),
                              onTap: (type) => _onTapRegion('B', type, Colors.green),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _GroupTapRegion(
                              name: 'C',
                              color: Colors.orange,
                              groupId: _useGroupId ? _groupId : null,
                              consumeOutsideTaps: _consumeOutsideTaps,
                              isActive: _activeRegions.containsKey('C'),
                              onTap: (type) => _onTapRegion('C', type, Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Explanation
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _kPrimary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _kPrimary.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: _kAccent, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'How groupId Works',
                              style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          _useGroupId
                              ? 'With groupId: Tapping inside ANY region (A, B, or C) is considered '
                                '"inside" for ALL regions. You\'ll only see "Outside" callbacks when '
                                'tapping the gray background.'
                              : 'Without groupId: Each region is independent. Tapping region B triggers '
                                '"Outside" for A and C, plus "Inside" for B.',
                          style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        // Log panel
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(top: BorderSide(color: _kDivider)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.history, color: _kAccent, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Callback Log',
                      style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _logs.isEmpty
                    ? Center(
                        child: Text(
                          'Tap inside or outside the regions',
                          style: TextStyle(color: _kTextSecondary),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _logs.length,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        itemBuilder: (context, index) {
                          final log = _logs[index];
                          final isInside = log.contains('Inside');
                          return Container(
                            margin: EdgeInsets.only(bottom: 4),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: (isInside ? _kSuccess : _kWarning).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              log,
                              style: TextStyle(
                                color: isInside ? _kSuccess : _kWarning,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleControl extends StatelessWidget {
  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleControl({
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value ? _kPrimary.withOpacity(0.2) : _kCardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: value ? _kAccent : _kDivider),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(color: _kTextSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: _kAccent,
          ),
        ],
      ),
    );
  }
}

class _GroupTapRegion extends StatelessWidget {
  final String name;
  final Color color;
  final Object? groupId;
  final bool consumeOutsideTaps;
  final bool isActive;
  final void Function(String type) onTap;

  const _GroupTapRegion({
    required this.name,
    required this.color,
    required this.groupId,
    required this.consumeOutsideTaps,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      groupId: groupId,
      consumeOutsideTaps: consumeOutsideTaps,
      onTapOutside: (event) => onTap('Outside'),
      onTapInside: (event) => onTap('Inside'),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.3) : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? color : color.withOpacity(0.5),
            width: isActive ? 3 : 2,
          ),
          boxShadow: isActive
              ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 12)]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: isActive ? 64 : 56,
              height: isActive ? 64 : 56,
              decoration: BoxDecoration(
                color: color.withOpacity(isActive ? 0.8 : 0.5),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isActive ? 28 : 24,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Region $name',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              groupId != null ? 'Grouped' : 'Independent',
              style: TextStyle(
                color: color.withOpacity(0.7),
                fontSize: 11,
              ),
            ),
          ],
        ),
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

class _ParameterInfo {
  final String name;
  final String type;
  final String desc;

  _ParameterInfo(this.name, this.type, this.desc);
}

class _ParameterTable extends StatelessWidget {
  final List<_ParameterInfo> parameters;

  const _ParameterTable({required this.parameters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: parameters
          .map((p) => Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: _kDivider.withOpacity(0.5))),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: TextStyle(
                              color: _kAccent,
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            p.type,
                            style: TextStyle(
                              color: _kTextSecondary,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        p.desc,
                        style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _CallbackTypeCard extends StatelessWidget {
  final String name;
  final String signature;
  final String description;
  final List<String> usedBy;

  const _CallbackTypeCard({
    required this.name,
    required this.signature,
    required this.description,
    required this.usedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: _kAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kCardBg,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              signature,
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.4),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: usedBy
                .map((cb) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _kPrimary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        cb,
                        style: TextStyle(
                          color: _kTextPrimary,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
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

class _LifecycleStep extends StatelessWidget {
  final int step;
  final String title;
  final String description;
  final bool isLast;

  const _LifecycleStep({
    required this.step,
    required this.title,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _kPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '$step',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: _kDivider,
              ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _kAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String name;
  final String type;
  final String description;

  const _ComparisonRow({
    required this.name,
    required this.type,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: _kAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: _kTextSecondary,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(color: _kTextPrimary, fontSize: 13, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _UseCaseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isLast;

  const _UseCaseItem({
    required this.icon,
    required this.title,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _kAccent, size: 22),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
