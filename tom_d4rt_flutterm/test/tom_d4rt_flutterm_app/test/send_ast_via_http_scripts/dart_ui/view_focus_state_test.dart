// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for ViewFocusState from dart:ui
// ViewFocusState represents the focus state of a view
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// GLOBAL HELPER FUNCTIONS (declared before build)
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildHeader() {
  return Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade700, Colors.teal.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const Icon(Icons.center_focus_strong, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        const Text(
          'ViewFocusState',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'View Focus States from dart:ui',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Focused and unfocused view states',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
            letterSpacing: 1.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverviewCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.green, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ViewFocusState Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint('Represents view-level focus state'),
              _buildBulletPoint('Used with ViewFocusEvent'),
              _buildBulletPoint('Binary state: focused or unfocused'),
              _buildBulletPoint('Tracks whether a view has focus'),
              _buildBulletPoint('Essential for window/view management'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateCard(
  ViewFocusState state,
  IconData icon,
  Color color,
  String description,
  List<String> traits,
  List<String> scenarios,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ViewFocusState.${state.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Index: ${state.index}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Characteristics',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...traits.map(
                      (t) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: color, fontSize: 12),
                            ),
                            Expanded(
                              child: Text(
                                t,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 14,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Common Scenarios',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...scenarios.map(
                      (s) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '→ ',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                s,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
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
      ],
    ),
  );
}

Widget _buildQuickRefGrid() {
  final items = [
    (
      ViewFocusState.focused,
      Icons.center_focus_strong,
      Colors.green,
      'Focused',
    ),
    (
      ViewFocusState.unfocused,
      Icons.center_focus_weak,
      Colors.grey,
      'Unfocused',
    ),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Reference',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${ViewFocusState.values.length} focus state values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        Row(
          children: items
              .map(
                (item) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: item.$3.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: item.$3.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(item.$2, color: item.$3, size: 36),
                        const SizedBox(height: 12),
                        Text(
                          item.$4,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: item.$3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '[${item.$1.index}]',
                          style: TextStyle(
                            fontSize: 11,
                            color: item.$3.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildStateTransitionVisualization() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'State Transitions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'How view focus state changes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 24),
        // State diagram
        Center(
          child: Column(
            children: [
              // Focused state
              Container(
                width: 160,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.center_focus_strong,
                      color: Colors.green,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'FOCUSED',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Arrows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.arrow_downward,
                        color: Colors.grey,
                        size: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'blur',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 60),
                  Column(
                    children: [
                      const Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                        size: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'focus',
                          style: TextStyle(fontSize: 10, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Unfocused state
              Container(
                width: 160,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.center_focus_weak,
                      color: Colors.grey.shade400,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'UNFOCUSED',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'A view receives focus when the user clicks on it, tabs into it, '
            'or when focus is programmatically assigned. It loses focus when '
            'another view receives focus.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ),
      ],
    ),
  );
}

Widget _buildWindowFocusVisualization() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Multi-Window Focus',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildWindowVisual('Window A', true)),
            const SizedBox(width: 12),
            Expanded(child: _buildWindowVisual('Window B', false)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.green.shade700),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Only one view can have focus at a time. Clicking Window B '
                  'would change it to focused and Window A to unfocused.',
                  style: TextStyle(fontSize: 11, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildWindowVisual(String title, bool isFocused) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isFocused ? Colors.green : Colors.grey.shade400,
        width: isFocused ? 2 : 1,
      ),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isFocused ? Colors.green : Colors.grey.shade300,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade600,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isFocused ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              isFocused ? 'FOCUSED' : 'UNFOCUSED',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isFocused ? Colors.green : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeExamples() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Code Examples',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Handle ViewFocusEvent',
          '''void handleViewFocusEvent(ViewFocusEvent event) {
  switch (event.state) {
    case ViewFocusState.focused:
      onViewFocused();
      break;
    case ViewFocusState.unfocused:
      onViewBlurred();
      break;
  }
}''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Listen for focus changes',
          '''WidgetsBinding.instance.platformDispatcher
  .onViewFocusChange = (ViewFocusEvent event) {
    final state = event.state;
    final viewId = event.viewId;
    
    print('View \$viewId state: \$state');
    
    if (state == ViewFocusState.focused) {
      resumeAnimations();
      enableKeyboardInput();
    } else {
      pauseAnimations();
      disableKeyboardInput();
    }
  };''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Check current focus state',
          '''bool isViewFocused(ViewFocusState state) {
  return state == ViewFocusState.focused;
}

void updateUI(ViewFocusState state) {
  if (isViewFocused(state)) {
    titleBar.showActive();
  } else {
    titleBar.showInactive();
  }
}''',
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String title, String code) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: Colors.lightGreenAccent,
          ),
        ),
      ),
    ],
  );
}

Widget _buildUseCases() {
  final cases = [
    (
      Icons.pause_circle,
      Colors.orange,
      'Pause Animations',
      'Pause resource-intensive animations when view loses focus',
    ),
    (
      Icons.volume_off,
      Colors.red,
      'Mute Audio',
      'Pause audio playback when user switches windows',
    ),
    (
      Icons.keyboard_hide,
      Colors.blue,
      'Keyboard Input',
      'Enable/disable keyboard shortcuts based on focus',
    ),
    (
      Icons.timer,
      Colors.purple,
      'Auto-save',
      'Trigger auto-save when view loses focus',
    ),
    (
      Icons.notifications_off,
      Colors.grey,
      'Notifications',
      'Show notifications only when view is unfocused',
    ),
    (
      Icons.games,
      Colors.green,
      'Game Pause',
      'Auto-pause games when window loses focus',
    ),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Common Use Cases',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...cases.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: c.$2.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(c.$1, color: c.$2, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.$3,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        c.$4,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlatformBehavior() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.devices, color: Colors.blue.shade700),
            const SizedBox(width: 8),
            Text(
              'Platform Behavior',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildPlatformBehaviorItem(
          'Desktop',
          'Focus changes when clicking or Alt+Tab between windows',
        ),
        _buildPlatformBehaviorItem(
          'Mobile',
          'Focus tied to app lifecycle (foreground/background)',
        ),
        _buildPlatformBehaviorItem(
          'Web',
          'Focus changes when switching browser tabs',
        ),
        _buildPlatformBehaviorItem(
          'Embedded',
          'Focus managed by host application',
        ),
      ],
    ),
  );
}

Widget _buildPlatformBehaviorItem(String platform, String behavior) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            platform,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            behavior,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRelatedTypes() {
  final types = [
    ('ViewFocusEvent', 'The event with state', Colors.blue),
    ('ViewFocusDirection', 'Forward/backward', Colors.purple),
    ('FocusNode', 'Widget-level focus', Colors.green),
    ('FocusScopeNode', 'Focus scope', Colors.orange),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Related Types',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: types
              .map(
                (t) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: t.$3.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: t.$3.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.$1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: t.$3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.$2,
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildSummaryStats() {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade400, Colors.teal.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Total', '${ViewFocusState.values.length}'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Active', 'focused'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Inactive', 'unfocused'),
      ],
    ),
  );
}

Widget _buildStatItem(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.white.withValues(alpha: 0.8),
        ),
      ),
    ],
  );
}

Widget _buildFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'ViewFocusState Deep Demo Complete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Demonstrating ${ViewFocusState.values.length} focus state values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== ViewFocusState Deep Demo ===');

  // Log all values
  print('ViewFocusState represents the focus state of a view');
  print('All values: ${ViewFocusState.values}');
  print('Count: ${ViewFocusState.values.length}');

  for (final s in ViewFocusState.values) {
    print('${s.name}: index=${s.index}');
  }

  print('\n--- State Details ---');
  print('focused: The view has focus and receives input');
  print('unfocused: The view does not have focus');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 16),

              // Overview
              _buildOverviewCard(),
              const SizedBox(height: 16),

              // Quick reference
              _buildSectionHeader('QUICK REFERENCE'),
              _buildQuickRefGrid(),
              const SizedBox(height: 16),

              // Summary stats
              _buildSummaryStats(),
              const SizedBox(height: 16),

              // State cards
              _buildSectionHeader('STATE DETAILS'),

              _buildStateCard(
                ViewFocusState.focused,
                Icons.center_focus_strong,
                Colors.green,
                'The view currently has focus and is the active recipient of input events. Keyboard events, mouse events, and other input are directed to this view.',
                [
                  'Receives keyboard input',
                  'Active for mouse events',
                  'Title bar shown as active',
                  'Cursor blinks in text fields',
                  'Animations may be running',
                ],
                [
                  'User clicked on the window',
                  'User tabbed into the view',
                  'View was programmatically focused',
                  'App came to foreground',
                ],
              ),

              _buildStateCard(
                ViewFocusState.unfocused,
                Icons.center_focus_weak,
                Colors.grey,
                'The view does not have focus. Input events are directed elsewhere. This state typically occurs when another view or window becomes active.',
                [
                  'Does not receive input',
                  'Title bar may appear dimmed',
                  'Cursor hidden in text fields',
                  'May pause animations',
                  'Good time for auto-save',
                ],
                [
                  'User clicked another window',
                  'User Alt+Tab to another app',
                  'Focus moved programmatically',
                  'App went to background',
                ],
              ),

              const SizedBox(height: 16),

              // State transition visualization
              _buildSectionHeader('STATE TRANSITIONS'),
              _buildStateTransitionVisualization(),
              const SizedBox(height: 16),

              // Multi-window visualization
              _buildSectionHeader('MULTI-WINDOW'),
              _buildWindowFocusVisualization(),
              const SizedBox(height: 16),

              // Use cases
              _buildSectionHeader('USE CASES'),
              _buildUseCases(),
              const SizedBox(height: 16),

              // Code examples
              _buildSectionHeader('CODE EXAMPLES'),
              _buildCodeExamples(),
              const SizedBox(height: 16),

              // Platform behavior
              _buildSectionHeader('PLATFORM BEHAVIOR'),
              _buildPlatformBehavior(),
              const SizedBox(height: 16),

              // Related types
              _buildSectionHeader('RELATED TYPES'),
              _buildRelatedTypes(),
              const SizedBox(height: 16),

              // Footer
              _buildFooter(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
