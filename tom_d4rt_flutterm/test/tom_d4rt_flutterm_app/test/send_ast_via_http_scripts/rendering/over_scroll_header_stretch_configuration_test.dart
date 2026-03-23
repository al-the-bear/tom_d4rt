// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for OverScrollHeaderStretchConfiguration from rendering
//
// OverScrollHeaderStretchConfiguration - configuration for overscroll header stretch behavior.
// This class defines how sliver persistent headers respond to overscroll gestures,
// creating the elastic stretch effect when users pull beyond scroll boundaries.
//
// Key aspects:
//   - Controls stretch trigger threshold distance
//   - Provides callback mechanism for stretch completion
//   - Integrates with SliverAppBar stretch functionality
//   - Enables pull-to-refresh style interactions
//
// Related classes:
//   - SliverAppBar: Primary consumer with stretch property
//   - SliverPersistentHeader: Base widget that uses this configuration
//   - RenderSliverPersistentHeader: Render object implementing stretch
//   - ScrollPhysics: Determines overscroll bounce behavior
//
// Use cases:
//   - Pull-to-refresh implementations
//   - Elastic header animations
//   - Custom scroll interactions
//   - Header expansion triggers
//
// This demo visualizes OverScrollHeaderStretchConfiguration behavior patterns.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6A1B9A).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.expand, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFAB47BC).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF6A1B9A), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A1B9A),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF7B1FA2),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFF80CBC4),
      ),
    ),
  );
}

Widget _buildStretchIndicator(double offset, Color color, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      children: [
        Text(
          '${offset.toStringAsFixed(1)}px',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: color),
        ),
      ],
    ),
  );
}

Widget _buildArrow({bool vertical = false, Color color = Colors.grey}) {
  if (vertical) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 2, height: 20, color: color),
        Icon(Icons.arrow_drop_down, color: color, size: 20),
      ],
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 20, height: 2, color: color),
      Icon(Icons.arrow_right, color: color, size: 20),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: CONFIGURATION OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildConfigurationOverviewSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Configuration Overview', Icons.tune),
        Text(
          'OverScrollHeaderStretchConfiguration defines how a sliver persistent '
          'header responds when the user overscrolls past the top boundary. '
          'It enables elastic stretch effects with customizable trigger thresholds.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Configuration Structure',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 16),
              _buildCodeBlock(
                'OverScrollHeaderStretchConfiguration(\n'
                '  stretchTriggerOffset: 100.0,\n'
                '  onStretchTrigger: () async {\n'
                '    // Handle stretch completion\n'
                '  },\n'
                ')',
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Class Type', 'Immutable configuration object'),
        _buildInfoRow('Primary Use', 'SliverAppBar stretch behavior'),
        _buildInfoRow('Default Offset', '100.0 logical pixels'),
        _buildInfoRow('Callback Type', 'AsyncCallback (Future<void>)'),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFeatureCard(
                'Threshold Control',
                'Define the exact distance the header must stretch before triggering',
                Icons.straighten,
                Color(0xFF7B1FA2),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildFeatureCard(
                'Async Callback',
                'Execute asynchronous operations when stretch completes',
                Icons.sync,
                Color(0xFF7B1FA2),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFeatureCard(String title, String description, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            color: Color(0xFF546E7A),
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: STRETCH TRIGGER OFFSET PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildStretchTriggerOffsetSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('stretchTriggerOffset Property', Icons.straighten),
        Text(
          'The stretchTriggerOffset defines how far the header must stretch '
          'beyond its normal bounds before the onStretchTrigger callback fires. '
          'This value is measured in logical pixels.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Offset Value Comparison',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOffsetDemo(50.0, 'Quick'),
                  _buildOffsetDemo(100.0, 'Default'),
                  _buildOffsetDemo(200.0, 'Extended'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Property Type', 'double'),
        _buildInfoRow('Default Value', '100.0 pixels'),
        _buildInfoRow('Minimum Practical', '~30.0 pixels (instant feel)'),
        _buildInfoRow('Maximum Recommended', '~300.0 pixels (slow trigger)'),
        SizedBox(height: 16),
        _buildOffsetTimeline(),
      ],
    ),
  );
}

Widget _buildOffsetDemo(double offset, String label) {
  Color color = offset <= 50
      ? Color(0xFF4CAF50)
      : offset <= 100
          ? Color(0xFFFFC107)
          : Color(0xFFF44336);
  return Column(
    children: [
      Container(
        width: 70,
        height: 80,
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.expand_less, color: color, size: 24),
            Text(
              '${offset.toInt()}px',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Color(0xFF546E7A),
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget _buildOffsetTimeline() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stretch Progress Timeline',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
            fontSize: 12,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildTimelinePoint('0px', 'Start', Color(0xFF9E9E9E)),
            Expanded(child: Container(height: 2, color: Color(0xFFE0E0E0))),
            _buildTimelinePoint('50px', '50%', Color(0xFFFFC107)),
            Expanded(child: Container(height: 2, color: Color(0xFFE0E0E0))),
            _buildTimelinePoint('100px', 'Trigger', Color(0xFF4CAF50)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTimelinePoint(String value, String label, Color color) {
  return Column(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
      ),
      Text(
        label,
        style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: ON STRETCH TRIGGER CALLBACK
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOnStretchTriggerSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('onStretchTrigger Callback', Icons.bolt),
        Text(
          'The onStretchTrigger callback is invoked when the header stretch '
          'distance exceeds stretchTriggerOffset. It returns a Future, allowing '
          'asynchronous operations like network requests or animations.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        _buildCodeBlock(
          'onStretchTrigger: () async {\n'
          '  await refreshData();\n'
          '  setState(() => _isRefreshing = false);\n'
          '}',
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Callback Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 16),
              _buildCallbackFlowDiagram(),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Callback Type', 'AsyncCallback? (nullable)'),
        _buildInfoRow('Return Type', 'Future<void>'),
        _buildInfoRow('Invocation', 'Once per stretch threshold crossing'),
        _buildInfoRow('Common Uses', 'Refresh data, animations, haptic feedback'),
        SizedBox(height: 16),
        _buildCallbackUseCasesGrid(),
      ],
    ),
  );
}

Widget _buildCallbackFlowDiagram() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildFlowStep('User\nOverscrolls', Icons.touch_app, Color(0xFF5C6BC0)),
      _buildArrow(color: Color(0xFF7986CB)),
      _buildFlowStep('Offset\nReached', Icons.check_circle, Color(0xFF66BB6A)),
      _buildArrow(color: Color(0xFF81C784)),
      _buildFlowStep('Callback\nFires', Icons.flash_on, Color(0xFFFFB74D)),
      _buildArrow(color: Color(0xFFFFCC80)),
      _buildFlowStep('Async\nComplete', Icons.done_all, Color(0xFF4DB6AC)),
    ],
  );
}

Widget _buildFlowStep(String label, IconData icon, Color color) {
  return Container(
    width: 65,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: color,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildCallbackUseCasesGrid() {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildUseCaseCard(
              'Pull to Refresh',
              'Trigger data reload',
              Icons.refresh,
              Color(0xFF2196F3),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _buildUseCaseCard(
              'Haptic Feedback',
              'Vibration on trigger',
              Icons.vibration,
              Color(0xFF9C27B0),
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: _buildUseCaseCard(
              'Animation Start',
              'Launch custom animation',
              Icons.animation,
              Color(0xFFFF5722),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _buildUseCaseCard(
              'State Update',
              'Modify app state',
              Icons.cached,
              Color(0xFF009688),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildUseCaseCard(String title, String subtitle, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 11,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: SLIVER APP BAR STRETCH DEMOS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSliverAppBarStretchSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('SliverAppBar Stretch Demos', Icons.view_day),
        Text(
          'SliverAppBar integrates OverScrollHeaderStretchConfiguration through '
          'its stretch and stretchTriggerOffset properties. When stretch is true, '
          'the header expands elastically on overscroll.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        _buildCodeBlock(
          'SliverAppBar(\n'
          '  stretch: true,\n'
          '  stretchTriggerOffset: 150.0,\n'
          '  onStretchTrigger: () async {\n'
          '    await _refreshContent();\n'
          '  },\n'
          '  expandedHeight: 200.0,\n'
          '  flexibleSpace: FlexibleSpaceBar(...),\n'
          ')',
        ),
        SizedBox(height: 20),
        _buildStretchStatesDiagram(),
        SizedBox(height: 16),
        _buildInfoRow('stretch Property', 'Enables stretch behavior'),
        _buildInfoRow('stretchTriggerOffset', 'Maps to configuration offset'),
        _buildInfoRow('onStretchTrigger', 'Maps to configuration callback'),
        _buildInfoRow('expandedHeight', 'Maximum height before stretch'),
        SizedBox(height: 16),
        _buildSliverAppBarIntegrationDiagram(),
      ],
    ),
  );
}

Widget _buildStretchStatesDiagram() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'SliverAppBar Stretch States',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStretchStateCard('Collapsed', 56.0, Color(0xFF9E9E9E)),
            _buildStretchStateCard('Expanded', 200.0, Color(0xFF4CAF50)),
            _buildStretchStateCard('Stretched', 300.0, Color(0xFFE91E63)),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(180),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF880E4F), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Stretch occurs when user pulls beyond expanded height at scroll position 0',
                  style: TextStyle(
                    color: Color(0xFF880E4F),
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStretchStateCard(String label, double height, Color color) {
  return Column(
    children: [
      Container(
        width: 80,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withAlpha(60), color.withAlpha(30)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              label == 'Stretched' ? Icons.expand : Icons.view_compact,
              color: color,
              size: 24,
            ),
            Text(
              '${height.toInt()}px',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget _buildSliverAppBarIntegrationDiagram() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'SliverAppBar Integration Flow',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
            fontSize: 13,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIntegrationBox('SliverAppBar', Icons.view_day, Color(0xFF1976D2)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Color(0xFF64B5F6)),
            SizedBox(width: 8),
            _buildIntegrationBox('RenderSliver\nPersistentHeader', Icons.layers, Color(0xFF388E3C)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Color(0xFF81C784)),
            SizedBox(width: 8),
            _buildIntegrationBox('OverScroll\nStretchConfig', Icons.tune, Color(0xFF7B1FA2)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildIntegrationBox(String label, IconData icon, Color color) {
  return Container(
    width: 90,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: color,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: MULTIPLE CONFIGURATIONS COMPARISON
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMultipleConfigurationsSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Multiple Configurations Comparison', Icons.compare),
        Text(
          'Different configuration combinations serve various use cases. Compare '
          'quick-trigger, standard, and delayed configurations to understand '
          'the user experience impact.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        _buildConfigComparisonTable(),
        SizedBox(height: 16),
        _buildConfigurationCards(),
        SizedBox(height: 20),
        _buildConfigComparisonChart(),
      ],
    ),
  );
}

Widget _buildConfigComparisonTable() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFFE0E0E0)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        _buildTableHeader(),
        _buildTableRow('Quick Trigger', '50.0', 'Yes', Color(0xFF4CAF50)),
        _buildTableRow('Standard', '100.0', 'Yes', Color(0xFF2196F3)),
        _buildTableRow('Delayed', '200.0', 'Yes', Color(0xFFFF9800)),
        _buildTableRow('Visual Only', '100.0', 'No', Color(0xFF9E9E9E)),
      ],
    ),
  );
}

Widget _buildTableHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xFF6A1B9A),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(7),
        topRight: Radius.circular(7),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Configuration',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Offset',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Callback',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTableRow(String config, String offset, String callback, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                config,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF37474F),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            offset,
            style: TextStyle(color: Color(0xFF546E7A), fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            callback,
            style: TextStyle(color: Color(0xFF546E7A), fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConfigurationCards() {
  return Column(
    children: [
      _buildConfigCard(
        'Quick Trigger (50px)',
        'Responsive feel, triggers early. Ideal for immediate feedback scenarios.',
        Icons.flash_on,
        Color(0xFF4CAF50),
        'Best for: Pull-to-refresh, haptic feedback',
      ),
      SizedBox(height: 10),
      _buildConfigCard(
        'Standard (100px)',
        'Default behavior, balanced responsiveness and intentionality.',
        Icons.balance,
        Color(0xFF2196F3),
        'Best for: General purpose stretch interactions',
      ),
      SizedBox(height: 10),
      _buildConfigCard(
        'Delayed (200px)',
        'Requires deliberate user action, prevents accidental triggers.',
        Icons.hourglass_bottom,
        Color(0xFFFF9800),
        'Best for: Destructive actions, confirmations',
      ),
    ],
  );
}

Widget _buildConfigCard(String title, String description, IconData icon, Color color, String bestFor) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Color(0xFF546E7A),
                  fontSize: 11,
                ),
              ),
              SizedBox(height: 4),
              Text(
                bestFor,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildConfigComparisonChart() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trigger Offset Comparison',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
            fontSize: 13,
          ),
        ),
        SizedBox(height: 16),
        _buildComparisonBar('Quick', 50, 300, Color(0xFF4CAF50)),
        SizedBox(height: 8),
        _buildComparisonBar('Standard', 100, 300, Color(0xFF2196F3)),
        SizedBox(height: 8),
        _buildComparisonBar('Delayed', 200, 300, Color(0xFFFF9800)),
        SizedBox(height: 8),
        _buildComparisonBar('Max', 300, 300, Color(0xFFF44336)),
      ],
    ),
  );
}

Widget _buildComparisonBar(String label, int value, int max, Color color) {
  double fraction = value / max;
  return Row(
    children: [
      SizedBox(
        width: 70,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF546E7A),
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 24,
          decoration: BoxDecoration(
            color: Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: fraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${value}px',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: fraction > 0.5 ? Colors.white : Color(0xFF37474F),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: STRETCH BEHAVIOR VISUAL
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildStretchBehaviorVisualSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Stretch Behavior Visual', Icons.visibility),
        Text(
          'Visualizing the stretch effect helps understand the physics and '
          'feedback users experience. The header extends beyond its bounds '
          'with elastic deformation based on overscroll distance.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        _buildStretchVisualization(),
        SizedBox(height: 16),
        _buildStretchPhysicsInfo(),
        SizedBox(height: 16),
        _buildStretchProgressBars(),
        SizedBox(height: 16),
        _buildStretchAnimationPhases(),
      ],
    ),
  );
}

Widget _buildStretchVisualization() {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF0288D1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                'Header (Normal)',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0288D1).withAlpha(180), Color(0xFF0288D1).withAlpha(50)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.expand_more, color: Colors.white.withAlpha(200), size: 20),
                  Text(
                    'Stretch Zone',
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 12,
                    ),
                  ),
                  Icon(Icons.expand_more, color: Colors.white.withAlpha(200), size: 20),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 110,
          left: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStretchIndicator(0, Color(0xFF757575), 'Rest'),
                _buildStretchIndicator(50, Color(0xFFFFC107), 'Stretching'),
                _buildStretchIndicator(100, Color(0xFF4CAF50), 'Triggered!'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStretchPhysicsInfo() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.science, color: Color(0xFF6A1B9A), size: 18),
            SizedBox(width: 8),
            Text(
              'Stretch Physics',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
                fontSize: 13,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildPhysicsRow('Overscroll Source', 'BouncingScrollPhysics'),
        _buildPhysicsRow('Stretch Factor', 'Proportional to overscroll distance'),
        _buildPhysicsRow('Release Behavior', 'Spring animation to original size'),
        _buildPhysicsRow('Trigger Timing', 'Peak stretch, before release'),
      ],
    ),
  );
}

Widget _buildPhysicsRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF546E7A),
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Color(0xFF78909C),
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStretchProgressBars() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Stretch Progress Examples',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF37474F),
          fontSize: 13,
        ),
      ),
      SizedBox(height: 12),
      _buildProgressBar('0%', 0.0, Color(0xFF9E9E9E)),
      SizedBox(height: 8),
      _buildProgressBar('25%', 0.25, Color(0xFFFFEB3B)),
      SizedBox(height: 8),
      _buildProgressBar('50%', 0.50, Color(0xFFFFC107)),
      SizedBox(height: 8),
      _buildProgressBar('75%', 0.75, Color(0xFFFF9800)),
      SizedBox(height: 8),
      _buildProgressBar('100% (Triggered)', 1.0, Color(0xFF4CAF50)),
    ],
  );
}

Widget _buildProgressBar(String label, double progress, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 100,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF546E7A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 16,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withAlpha(200), color],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildStretchAnimationPhases() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Phases',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3949AB),
            fontSize: 13,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPhaseIndicator('1. Pull', Icons.pan_tool, Color(0xFF5C6BC0)),
            _buildPhaseIndicator('2. Stretch', Icons.open_with, Color(0xFF7986CB)),
            _buildPhaseIndicator('3. Trigger', Icons.flash_on, Color(0xFFFFB74D)),
            _buildPhaseIndicator('4. Release', Icons.keyboard_return, Color(0xFF4DB6AC)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPhaseIndicator(String label, IconData icon, Color color) {
  return Column(
    children: [
      Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
        child: Center(
          child: Icon(icon, color: color, size: 20),
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// INTERACTIVE DEMO WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

class OverScrollHeaderStretchConfigDemo extends StatefulWidget {
  const OverScrollHeaderStretchConfigDemo({super.key});

  @override
  State<OverScrollHeaderStretchConfigDemo> createState() =>
      _OverScrollHeaderStretchConfigDemoState();
}

class _OverScrollHeaderStretchConfigDemoState
    extends State<OverScrollHeaderStretchConfigDemo> {
  double _currentOffset = 100.0;
  bool _hasCallback = true;
  int _triggerCount = 0;
  String _lastTriggerTime = 'Never';

  void _updateOffset(double value) {
    setState(() {
      _currentOffset = value;
    });
  }

  void _toggleCallback() {
    setState(() {
      _hasCallback = !_hasCallback;
    });
  }

  void _simulateTrigger() {
    setState(() {
      _triggerCount++;
      _lastTriggerTime = DateTime.now().toString().substring(11, 19);
    });
  }

  void _resetDemo() {
    setState(() {
      _triggerCount = 0;
      _lastTriggerTime = 'Never';
      _currentOffset = 100.0;
      _hasCallback = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFFFB74D), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.touch_app, color: Color(0xFFE65100), size: 24),
              SizedBox(width: 8),
              Text(
                'Interactive Configuration Demo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'stretchTriggerOffset: ${_currentOffset.toStringAsFixed(0)}px',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37474F),
                  ),
                ),
                SizedBox(height: 8),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Color(0xFFFF9800),
                    thumbColor: Color(0xFFE65100),
                    inactiveTrackColor: Color(0xFFFFE0B2),
                  ),
                  child: Slider(
                    value: _currentOffset,
                    min: 30.0,
                    max: 300.0,
                    onChanged: _updateOffset,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'onStretchTrigger callback:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF546E7A),
                      ),
                    ),
                    Switch(
                      value: _hasCallback,
                      onChanged: (_) => _toggleCallback(),
                      activeColor: Color(0xFFFF9800),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _simulateTrigger,
                        icon: Icon(Icons.play_arrow),
                        label: Text('Simulate Trigger'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF9800),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _resetDemo,
                      child: Icon(Icons.refresh),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9E9E9E),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildInfoRow('Trigger Count', '$_triggerCount'),
                _buildInfoRow('Last Trigger', _lastTriggerTime),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildCodeBlock(
            'OverScrollHeaderStretchConfiguration(\n'
            '  stretchTriggerOffset: ${_currentOffset.toStringAsFixed(1)},\n'
            '  onStretchTrigger: ${_hasCallback ? "() async { ... }" : "null"},\n'
            ')',
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN WIDGET COMPOSITION
// ═══════════════════════════════════════════════════════════════════════════════

class OverScrollHeaderStretchConfigurationDemo extends StatelessWidget {
  const OverScrollHeaderStretchConfigurationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeader(
                  'OverScrollHeaderStretchConfiguration',
                  'Configuration for overscroll header stretch behavior',
                ),
                SizedBox(height: 20),
                _buildConfigurationOverviewSection(),
                SizedBox(height: 16),
                _buildStretchTriggerOffsetSection(),
                SizedBox(height: 16),
                _buildOnStretchTriggerSection(),
                SizedBox(height: 16),
                _buildSliverAppBarStretchSection(),
                SizedBox(height: 16),
                _buildMultipleConfigurationsSection(),
                SizedBox(height: 16),
                _buildStretchBehaviorVisualSection(),
                SizedBox(height: 16),
                OverScrollHeaderStretchConfigDemo(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN ENTRY POINT
// ═══════════════════════════════════════════════════════════════════════════════

void main() {
  runApp(OverScrollHeaderStretchConfigurationDemo());
}
