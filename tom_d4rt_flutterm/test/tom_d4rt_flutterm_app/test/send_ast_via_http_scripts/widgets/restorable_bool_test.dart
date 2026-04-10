// Deep visual test for RestorableBool
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableBool
/// A restorable property that holds a non-nullable boolean value.
///
/// RestorableBool is the workhorse for binary state restoration:
/// - Toggle switches
/// - Feature flags
/// - Binary preferences
/// - On/off states
///
/// Always has a value - never null.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableBoolDemo(),
  );
}

// =============================================================================
// PALETTE: Red 700 / Lime 400
// =============================================================================
const Color _kPrimary = Color(0xFFD32F2F); // Red 700
const Color _kAccent = Color(0xFFC6FF00); // Lime A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kTrue = Color(0xFF66BB6A);
const Color _kFalse = Color(0xFFEF5350);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableBoolDemo extends StatefulWidget {
  @override
  State<_RestorableBoolDemo> createState() => _RestorableBoolDemoState();
}

class _RestorableBoolDemoState extends State<_RestorableBoolDemo>
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
        title: Text('RestorableBool Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.toggle_on), text: 'Toggle Lab'),
            Tab(icon: Icon(Icons.settings_backup_restore), text: 'Mixin Demo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _ToggleLabTab(),
          _MixinDemoTab(),
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
          _buildBinaryNatureSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildConstructorSection(),
          SizedBox(height: 24),
          _buildApiSection(),
          SizedBox(height: 24),
          _buildRestorationMixinSection(),
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
              Icon(Icons.toggle_on, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableBool',
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
            'A restorable property for non-nullable boolean values. Perfect for '
            'binary state that must survive app lifecycle events like rotation, '
            'backgrounding, or process death.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _ValueBadge(value: true, label: 'Always true'),
              SizedBox(width: 12),
              _ValueBadge(value: false, label: 'Or false'),
              SizedBox(width: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.block, color: Colors.red.shade300, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'Never null',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBinaryNatureSection() {
    return _TheoryCard(
      title: 'Binary Nature',
      icon: Icons.looks_two,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableBool is strictly binary - no null, no maybe, just true or false:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _BinaryStateCard(
                  value: true,
                  examples: ['Feature enabled', 'Logged in', 'Dark mode on', 'Agreed to terms'],
                ),
              ),
              Container(
                width: 40,
                child: Column(
                  children: [
                    Icon(Icons.swap_horiz, color: _kAccent, size: 24),
                    SizedBox(height: 4),
                    Text(
                      'only',
                      style: TextStyle(color: _kTextSecondary, fontSize: 10),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _BinaryStateCard(
                  value: false,
                  examples: ['Feature disabled', 'Logged out', 'Light mode', 'Not agreed'],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kPrimary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: _kAccent, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Need a third "unknown" state? Use RestorableBoolN instead.',
                    style: TextStyle(color: _kTextPrimary, fontSize: 12),
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
                _HierarchyItem(level: 0, name: 'Listenable', desc: 'Listener pattern'),
                _HierarchyItem(level: 1, name: 'RestorableProperty<T>', desc: 'Restoration bridge'),
                _HierarchyItem(level: 2, name: 'RestorableValue<T>', desc: 'Mutable value'),
                _HierarchyItem(level: 3, name: '_RestorablePrimitiveValue<T>', desc: 'Primitive storage'),
                _HierarchyItem(level: 4, name: 'RestorableBool', desc: 'Non-null bool', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.info_outline, color: _kTextSecondary, size: 16),
              SizedBox(width: 8),
              Text(
                'Implements Listenable for reactive updates',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
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
              'RestorableBool(bool defaultValue)',
              style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 16),
          _ParameterRow(
            name: 'defaultValue',
            type: 'bool',
            desc: 'Initial value, must be true or false - cannot be null',
            isRequired: true,
          ),
          SizedBox(height: 16),
          _CodeExample(
            title: 'Usage:',
            code: '''// Defaults to enabled
final _isEnabled = RestorableBool(true);

// Defaults to off
final _isDarkMode = RestorableBool(false);''',
          ),
        ],
      ),
    );
  }

  Widget _buildApiSection() {
    return _TheoryCard(
      title: 'API Reference',
      icon: Icons.api,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ApiItem(
            category: 'getter',
            name: 'value',
            returnType: 'bool',
            desc: 'Current boolean value',
          ),
          _ApiItem(
            category: 'setter',
            name: 'value =',
            returnType: 'void',
            desc: 'Update value (notifies listeners)',
          ),
          _ApiItem(
            category: 'getter',
            name: 'enabled',
            returnType: 'bool',
            desc: 'Whether restoration is active',
          ),
          _ApiItem(
            category: 'method',
            name: 'dispose()',
            returnType: 'void',
            desc: 'Release resources',
          ),
          _ApiItem(
            category: 'method',
            name: 'addListener()',
            returnType: 'void',
            desc: 'Subscribe to value changes',
          ),
          _ApiItem(
            category: 'method',
            name: 'removeListener()',
            returnType: 'void',
            desc: 'Unsubscribe from changes',
          ),
        ],
      ),
    );
  }

  Widget _buildRestorationMixinSection() {
    return _TheoryCard(
      title: 'RestorationMixin Integration',
      icon: Icons.extension,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableBool works with RestorationMixin to persist state:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 12),
          _CodeExample(
            title: 'Complete pattern:',
            code: '''class _MyWidgetState extends State<MyWidget>
    with RestorationMixin {
  
  // 1. Declare restorable properties
  final _isExpanded = RestorableBool(false);
  final _isPlaying = RestorableBool(false);
  
  // 2. Provide restoration ID
  @override
  String? get restorationId => 'my_widget';
  
  // 3. Register properties
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isExpanded, 'expanded');
    registerForRestoration(_isPlaying, 'playing');
  }
  
  // 4. Dispose properties
  @override
  void dispose() {
    _isExpanded.dispose();
    _isPlaying.dispose();
    super.dispose();
  }
}''',
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
            icon: Icons.expand_more,
            title: 'Expansion State',
            desc: 'Preserve whether panels/sections are expanded',
          ),
          _UseCaseItem(
            icon: Icons.visibility,
            title: 'Visibility Toggles',
            desc: 'Track show/hide state of UI elements',
          ),
          _UseCaseItem(
            icon: Icons.dark_mode,
            title: 'Theme Preference',
            desc: 'Persist light/dark mode selection',
          ),
          _UseCaseItem(
            icon: Icons.notifications_active,
            title: 'Feature Flags',
            desc: 'Track enabled/disabled features',
          ),
          _UseCaseItem(
            icon: Icons.check_circle,
            title: 'Acknowledgment',
            desc: 'Terms accepted, tips dismissed',
          ),
        ],
      ),
    );
  }
}

class _ValueBadge extends StatelessWidget {
  final bool value;
  final String label;

  const _ValueBadge({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final color = value ? _kTrue : _kFalse;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(value ? Icons.check : Icons.close, color: color, size: 14),
          SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

class _BinaryStateCard extends StatelessWidget {
  final bool value;
  final List<String> examples;

  const _BinaryStateCard({required this.value, required this.examples});

  @override
  Widget build(BuildContext context) {
    final color = value ? _kTrue : _kFalse;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(value ? Icons.check_circle : Icons.cancel, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value.toString().toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 12),
          ...examples.map((e) => Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  e,
                  style: TextStyle(color: _kTextSecondary, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              )),
        ],
      ),
    );
  }
}

class _ParameterRow extends StatelessWidget {
  final String name;
  final String type;
  final String desc;
  final bool isRequired;

  const _ParameterRow({
    required this.name,
    required this.type,
    required this.desc,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              type,
              style: TextStyle(color: _kPrimary, fontSize: 11, fontFamily: 'monospace'),
            ),
          ),
          SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              color: _kAccent,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
          if (isRequired) ...[
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: _kFalse.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                'required',
                style: TextStyle(color: _kFalse, fontSize: 9),
              ),
            ),
          ],
          Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              desc,
              style: TextStyle(color: _kTextSecondary, fontSize: 11),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiItem extends StatelessWidget {
  final String category;
  final String name;
  final String returnType;
  final String desc;

  const _ApiItem({
    required this.category,
    required this.name,
    required this.returnType,
    required this.desc,
  });

  Color get _categoryColor {
    switch (category) {
      case 'getter':
        return _kTrue;
      case 'setter':
        return _kAccent;
      case 'method':
        return _kPrimary;
      default:
        return _kTextSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: _categoryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              category,
              style: TextStyle(color: _categoryColor, fontSize: 8),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: _kDivider,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              returnType,
              style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 9),
            ),
          ),
          SizedBox(width: 8),
          Text(
            name,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
          Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              desc,
              style: TextStyle(color: _kTextSecondary, fontSize: 10),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _UseCaseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _UseCaseItem({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _kAccent, size: 20),
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
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 2),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: TOGGLE LAB
// =============================================================================
class _ToggleLabTab extends StatefulWidget {
  @override
  State<_ToggleLabTab> createState() => _ToggleLabTabState();
}

class _ToggleLabTabState extends State<_ToggleLabTab> {
  // Simulated RestorableBool properties
  bool _isExpanded = false;
  bool _isDarkMode = true;
  bool _notificationsEnabled = true;
  bool _soundEnabled = false;
  bool _vibrationEnabled = true;
  bool _locationEnabled = false;

  final List<String> _eventLog = [];

  void _toggle(String name, bool Function() getter, void Function(bool) setter) {
    setState(() {
      setter(!getter());
      _logEvent('$name toggled to: ${getter()}');
    });
  }

  void _logEvent(String event) {
    _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
    if (_eventLog.length > 10) _eventLog.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(bottom: BorderSide(color: _kDivider)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Binary Toggle Lab',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Each toggle represents a RestorableBool property. Toggle states and observe value changes.',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        // Toggle grid
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(16),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _ToggleCard(
                title: 'Expanded',
                icon: Icons.expand_more,
                value: _isExpanded,
                subtitle: 'Panel state',
                onTap: () => _toggle('isExpanded', () => _isExpanded, (v) => _isExpanded = v),
              ),
              _ToggleCard(
                title: 'Dark Mode',
                icon: Icons.dark_mode,
                value: _isDarkMode,
                subtitle: 'Theme preference',
                onTap: () => _toggle('isDarkMode', () => _isDarkMode, (v) => _isDarkMode = v),
              ),
              _ToggleCard(
                title: 'Notifications',
                icon: Icons.notifications,
                value: _notificationsEnabled,
                subtitle: 'Push alerts',
                onTap: () => _toggle('notifications', () => _notificationsEnabled, (v) => _notificationsEnabled = v),
              ),
              _ToggleCard(
                title: 'Sound',
                icon: Icons.volume_up,
                value: _soundEnabled,
                subtitle: 'Audio feedback',
                onTap: () => _toggle('sound', () => _soundEnabled, (v) => _soundEnabled = v),
              ),
              _ToggleCard(
                title: 'Vibration',
                icon: Icons.vibration,
                value: _vibrationEnabled,
                subtitle: 'Haptic feedback',
                onTap: () => _toggle('vibration', () => _vibrationEnabled, (v) => _vibrationEnabled = v),
              ),
              _ToggleCard(
                title: 'Location',
                icon: Icons.location_on,
                value: _locationEnabled,
                subtitle: 'GPS access',
                onTap: () => _toggle('location', () => _locationEnabled, (v) => _locationEnabled = v),
              ),
            ],
          ),
        ),
        // State summary
        Container(
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RestorableBool State Map:',
                style: TextStyle(color: _kAccent, fontSize: 12),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _StateBadge('isExpanded', _isExpanded),
                  _StateBadge('isDarkMode', _isDarkMode),
                  _StateBadge('notifications', _notificationsEnabled),
                  _StateBadge('sound', _soundEnabled),
                  _StateBadge('vibration', _vibrationEnabled),
                  _StateBadge('location', _locationEnabled),
                ],
              ),
            ],
          ),
        ),
        // Event log
        Container(
          height: 100,
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event Log:', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              SizedBox(height: 8),
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
      ],
    );
  }
}

class _ToggleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final String subtitle;
  final VoidCallback onTap;

  const _ToggleCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.subtitle,
    required this.onTap,
  });

  Color get _stateColor => value ? _kTrue : _kFalse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _stateColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _stateColor.withOpacity(0.4), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _stateColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: _stateColor, size: 28),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: _kTextPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: _kTextSecondary, fontSize: 10),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _stateColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value ? 'ON' : 'OFF',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StateBadge extends StatelessWidget {
  final String name;
  final bool value;

  const _StateBadge(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    final color = value ? _kTrue : _kFalse;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(width: 6),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: MIXIN DEMO
// =============================================================================
class _MixinDemoTab extends StatefulWidget {
  @override
  State<_MixinDemoTab> createState() => _MixinDemoTabState();
}

class _MixinDemoTabState extends State<_MixinDemoTab> {
  // Simulated restoration state
  final Map<String, bool> _boolProperties = {
    'showWelcome': true,
    'agreedToTerms': false,
    'completedTutorial': false,
    'enabledPro': true,
  };

  int _simulatedBuildCount = 0;
  Map<String, bool>? _savedBucket;
  bool _hasRestored = false;
  final List<_LifecycleEvent> _lifecycleEvents = [];

  void _setValue(String key, bool value) {
    setState(() {
      _boolProperties[key] = value;
      _addEvent(_LifecycleEventType.valueChange, '$key = $value');
    });
  }

  void _simulateSave() {
    _savedBucket = Map.from(_boolProperties);
    _addEvent(_LifecycleEventType.save, 'State saved to bucket');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('RestorationBucket saved!'),
        backgroundColor: _kPrimary,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _simulateRestore() {
    if (_savedBucket != null) {
      setState(() {
        _boolProperties.clear();
        _boolProperties.addAll(_savedBucket!);
        _simulatedBuildCount++;
        _hasRestored = true;
      });
      _addEvent(_LifecycleEventType.restore, 'State restored (build #$_simulatedBuildCount)');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('State restored! Build #$_simulatedBuildCount'),
          backgroundColor: _kAccent,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _simulateProcessDeath() {
    setState(() {
      // Pretend we lost state
      _boolProperties['showWelcome'] = true;
      _boolProperties['agreedToTerms'] = false;
      _boolProperties['completedTutorial'] = false;
      _boolProperties['enabledPro'] = true;
      _simulatedBuildCount++;
      _hasRestored = false;
    });
    _addEvent(_LifecycleEventType.processDeath, 'Process killed - defaults restored');
  }

  void _addEvent(_LifecycleEventType type, String message) {
    _lifecycleEvents.insert(0, _LifecycleEvent(type: type, message: message, time: DateTime.now()));
    if (_lifecycleEvents.length > 8) _lifecycleEvents.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(bottom: BorderSide(color: _kDivider)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _hasRestored ? _kAccent.withOpacity(0.2) : _kPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _hasRestored ? Icons.restore : Icons.fiber_new,
                  color: _hasRestored ? _kAccent : _kPrimary,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _hasRestored ? 'Restored State' : 'Fresh Instance',
                      style: TextStyle(
                        color: _kTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Build count: $_simulatedBuildCount',
                      style: TextStyle(color: _kTextSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _savedBucket != null ? _kTrue.withOpacity(0.2) : _kSurface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _savedBucket != null ? _kTrue : _kDivider),
                ),
                child: Text(
                  _savedBucket != null ? 'Bucket exists' : 'No bucket',
                  style: TextStyle(
                    color: _savedBucket != null ? _kTrue : _kTextSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Properties list
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              _PropertyTile(
                name: 'showWelcome',
                value: _boolProperties['showWelcome']!,
                desc: 'Show welcome screen on first launch',
                icon: Icons.waving_hand,
                onToggle: () => _setValue('showWelcome', !_boolProperties['showWelcome']!),
              ),
              SizedBox(height: 12),
              _PropertyTile(
                name: 'agreedToTerms',
                value: _boolProperties['agreedToTerms']!,
                desc: 'User accepted terms of service',
                icon: Icons.gavel,
                onToggle: () => _setValue('agreedToTerms', !_boolProperties['agreedToTerms']!),
              ),
              SizedBox(height: 12),
              _PropertyTile(
                name: 'completedTutorial',
                value: _boolProperties['completedTutorial']!,
                desc: 'Tutorial walkthrough completed',
                icon: Icons.school,
                onToggle: () => _setValue('completedTutorial', !_boolProperties['completedTutorial']!),
              ),
              SizedBox(height: 12),
              _PropertyTile(
                name: 'enabledPro',
                value: _boolProperties['enabledPro']!,
                desc: 'Pro features activated',
                icon: Icons.star,
                onToggle: () => _setValue('enabledPro', !_boolProperties['enabledPro']!),
              ),
              SizedBox(height: 24),
              _buildCodePreview(),
            ],
          ),
        ),
        // Lifecycle simulation controls
        Container(
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Simulate Lifecycle Events:',
                style: TextStyle(color: _kAccent, fontSize: 12),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _LifecycleButton(
                      label: 'Save',
                      icon: Icons.save,
                      color: _kPrimary,
                      onTap: _simulateSave,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _LifecycleButton(
                      label: 'Restore',
                      icon: Icons.restore,
                      color: _kAccent,
                      enabled: _savedBucket != null,
                      onTap: _simulateRestore,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _LifecycleButton(
                      label: 'Process Death',
                      icon: Icons.dangerous,
                      color: _kFalse,
                      onTap: _simulateProcessDeath,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Event timeline
        Container(
          height: 110,
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lifecycle Timeline:', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: _lifecycleEvents
                      .map((e) => _LifecycleEventRow(event: e))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCodePreview() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: _kAccent, size: 16),
              SizedBox(width: 8),
              Text(
                'restoreState() equivalent',
                style: TextStyle(color: _kAccent, fontSize: 11),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '''registerForRestoration(
  RestorableBool(${_boolProperties['showWelcome']}),
  'showWelcome'
);
registerForRestoration(
  RestorableBool(${_boolProperties['agreedToTerms']}),
  'agreedToTerms'
);
registerForRestoration(
  RestorableBool(${_boolProperties['completedTutorial']}),
  'completedTutorial'
);
registerForRestoration(
  RestorableBool(${_boolProperties['enabledPro']}),
  'enabledPro'
);''',
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 10,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyTile extends StatelessWidget {
  final String name;
  final bool value;
  final String desc;
  final IconData icon;
  final VoidCallback onToggle;

  const _PropertyTile({
    required this.name,
    required this.value,
    required this.desc,
    required this.icon,
    required this.onToggle,
  });

  Color get _stateColor => value ? _kTrue : _kFalse;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _stateColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _stateColor, size: 22),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: _kTextPrimary,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _stateColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        value.toString(),
                        style: TextStyle(
                          color: _stateColor,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(color: _kTextSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (_) => onToggle(),
            activeColor: _kTrue,
            inactiveThumbColor: _kFalse,
          ),
        ],
      ),
    );
  }
}

class _LifecycleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool enabled;

  const _LifecycleButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: enabled ? color.withOpacity(0.2) : _kDivider.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: enabled ? color : _kDivider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: enabled ? color : _kTextSecondary, size: 16),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: enabled ? color : _kTextSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _LifecycleEventType { valueChange, save, restore, processDeath }

class _LifecycleEvent {
  final _LifecycleEventType type;
  final String message;
  final DateTime time;

  _LifecycleEvent({required this.type, required this.message, required this.time});
}

class _LifecycleEventRow extends StatelessWidget {
  final _LifecycleEvent event;

  const _LifecycleEventRow({required this.event});

  Color get _color {
    switch (event.type) {
      case _LifecycleEventType.valueChange:
        return _kTextSecondary;
      case _LifecycleEventType.save:
        return _kPrimary;
      case _LifecycleEventType.restore:
        return _kAccent;
      case _LifecycleEventType.processDeath:
        return _kFalse;
    }
  }

  IconData get _icon {
    switch (event.type) {
      case _LifecycleEventType.valueChange:
        return Icons.edit;
      case _LifecycleEventType.save:
        return Icons.save;
      case _LifecycleEventType.restore:
        return Icons.restore;
      case _LifecycleEventType.processDeath:
        return Icons.dangerous;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            event.time.toString().substring(11, 19),
            style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 9),
          ),
          SizedBox(width: 8),
          Icon(_icon, color: _color, size: 12),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              event.message,
              style: TextStyle(color: _color, fontSize: 10),
              overflow: TextOverflow.ellipsis,
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
      padding: EdgeInsets.only(left: level * 14.0, top: level > 0 ? 6 : 0),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: _kDivider),
                  bottom: BorderSide(color: _kDivider),
                ),
              ),
            ),
            SizedBox(width: 6),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: isHighlighted ? _kAccent.withOpacity(0.2) : _kCardBg,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: isHighlighted ? _kAccent : _kDivider),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: isHighlighted ? _kAccent : _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 6),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}

class _CodeExample extends StatelessWidget {
  final String title;
  final String code;

  const _CodeExample({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: _kTextSecondary, fontSize: 12)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccent.withOpacity(0.2)),
          ),
          child: Text(
            code,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 10,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
