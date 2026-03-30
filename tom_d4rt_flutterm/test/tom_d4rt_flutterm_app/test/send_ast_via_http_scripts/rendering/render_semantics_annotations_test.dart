// ignore_for_file: avoid_print
// Deep demo: RenderSemanticsAnnotations — Accessibility Annotations Lab
// Demonstrates the Semantics widget and underlying RenderSemanticsAnnotations,
// covering labels, actions, merge/exclude, live regions, custom properties,
// and a verification/summary panel.
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// ---------------------------------------------------------------------------
// Palette definitions
// ---------------------------------------------------------------------------
class _Pal {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color onSurface;
  final Color accent;
  final Color muted;
  final String name;
  const _Pal(this.name, this.primary, this.secondary, this.surface,
      this.onSurface, this.accent, this.muted);
}

const _palettes = <_Pal>[
  _Pal('Deep Purple / Teal', Color(0xFF4527A0), Color(0xFF00897B),
      Color(0xFFF3E5F5), Color(0xFF1B0036), Color(0xFFE040FB), Color(0xFF9575CD)),
  _Pal('Warm Amber / Indigo', Color(0xFFFF8F00), Color(0xFF283593),
      Color(0xFFFFF8E1), Color(0xFF3E2723), Color(0xFFFF6D00), Color(0xFFFFCC80)),
  _Pal('Forest / Rose', Color(0xFF2E7D32), Color(0xFFAD1457),
      Color(0xFFE8F5E9), Color(0xFF1B5E20), Color(0xFF69F0AE), Color(0xFFA5D6A7)),
];

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _SemanticsAnnotationsLab();
}

class _SemanticsAnnotationsLab extends StatefulWidget {
  const _SemanticsAnnotationsLab();
  @override
  State<_SemanticsAnnotationsLab> createState() =>
      _SemanticsAnnotationsLabState();
}

class _SemanticsAnnotationsLabState extends State<_SemanticsAnnotationsLab> {
  int _scenario = 0;
  int _palette = 0;
  bool _verbose = false;

  static const _scenarioTitles = <String>[
    '1 · Labeling Fundamentals',
    '2 · Action Annotations',
    '3 · Container & Merge',
    '4 · Live Regions',
    '5 · Properties Dashboard',
    '6 · Verification & Summary',
  ];

  _Pal get _p => _palettes[_palette];

  void _log(String msg) {
    if (_verbose) print('[SemanticsLab] $msg');
  }

  @override
  Widget build(BuildContext context) {
    _log('build scenario=$_scenario palette=$_palette');
    return Scaffold(
      backgroundColor: _p.surface,
      body: Column(
        children: [
          _buildHeader(),
          _buildControlBoard(),
          Expanded(child: _buildScenario()),
          _buildFooter(),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Header
  // -----------------------------------------------------------------------
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_p.primary, _p.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.accessibility_new, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Text('Accessibility Annotations Lab',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'RenderSemanticsAnnotations attaches accessibility metadata '
            '(labels, hints, actions, flags) to the render tree so assistive '
            'technologies like screen readers can describe the UI.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Control Board
  // -----------------------------------------------------------------------
  Widget _buildControlBoard() {
    return Container(
      width: double.infinity,
      color: _p.primary.withValues(alpha: 0.07),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Scenario:', style: TextStyle(fontWeight: FontWeight.w600,
              color: _p.onSurface, fontSize: 13)),
          for (var i = 0; i < _scenarioTitles.length; i++)
            ChoiceChip(
              label: Text('${i + 1}',
                  style: TextStyle(
                      color: _scenario == i ? Colors.white : _p.onSurface,
                      fontSize: 12)),
              selected: _scenario == i,
              selectedColor: _p.primary,
              backgroundColor: _p.surface,
              onSelected: (_) => setState(() { _scenario = i; _log('scenario=$i'); }),
            ),
          const SizedBox(width: 16),
          Text('Palette:', style: TextStyle(fontWeight: FontWeight.w600,
              color: _p.onSurface, fontSize: 13)),
          for (var j = 0; j < _palettes.length; j++)
            GestureDetector(
              onTap: () => setState(() { _palette = j; _log('palette=$j'); }),
              child: Container(
                width: 22, height: 22,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: _palettes[j].primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _palette == j ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 10),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Verbose', style: TextStyle(fontSize: 12,
                color: _p.onSurface)),
            Switch(
                value: _verbose,
                activeTrackColor: _p.accent,
                onChanged: (v) => setState(() => _verbose = v)),
          ]),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Scenario dispatcher
  // -----------------------------------------------------------------------
  Widget _buildScenario() {
    switch (_scenario) {
      case 0: return _buildLabelingFundamentals();
      case 1: return _buildActionAnnotations();
      case 2: return _buildContainerMerge();
      case 3: return _buildLiveRegions();
      case 4: return _buildPropertiesDashboard();
      case 5: return _buildVerification();
      default: return const SizedBox.shrink();
    }
  }

  // =======================================================================
  // SCENARIO 1 — Labeling Fundamentals
  // =======================================================================
  Widget _buildLabelingFundamentals() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Labeling Fundamentals'),
          const SizedBox(height: 6),
          Text(
            'The Semantics widget wraps any child and attaches accessibility '
            'labels, hints, and values. Screen readers announce these strings '
            'to users who cannot see the visual UI. Below, each card shows a '
            'different labeling configuration.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // Card 1: Simple label
          _labelCard(
            title: 'Simple Label',
            description: 'Semantics(label: "Play") adds a readable text label '
                'that a screen reader will announce.',
            child: Semantics(
              label: 'Play button',
              child: Container(
                width: 120, height: 80,
                decoration: BoxDecoration(
                  color: _p.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.play_arrow, color: Colors.white, size: 36),
              ),
            ),
            properties: {'label': 'Play button'},
          ),
          const SizedBox(height: 14),
          // Card 2: Label + hint
          _labelCard(
            title: 'Label + Hint',
            description: 'Adding a hint gives the user context about what '
                'will happen when they activate the element.',
            child: Semantics(
              label: 'Submit order',
              hint: 'Double tap to confirm your purchase',
              child: Container(
                width: 180, height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [_p.primary, _p.secondary]),
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text('Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            properties: {'label': 'Submit order',
                'hint': 'Double tap to confirm your purchase'},
          ),
          const SizedBox(height: 14),
          // Card 3: Value
          _labelCard(
            title: 'Value Annotation',
            description: 'Semantics(value: "75%") communicates the current '
                'state of a control, separate from its label.',
            child: Semantics(
              label: 'Volume',
              value: '75 percent',
              child: Container(
                width: 200, height: 50,
                decoration: BoxDecoration(
                  color: _p.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _p.primary, width: 2),
                ),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.75,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _p.primary.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    Center(
                      child: Text('75 %',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16, color: _p.onSurface)),
                    ),
                  ],
                ),
              ),
            ),
            properties: {'label': 'Volume', 'value': '75 percent'},
          ),
          const SizedBox(height: 14),
          // Card 4: attributedLabel
          _labelCard(
            title: 'Tooltip Annotation',
            description: 'Semantics(tooltip:) adds a tooltip that assistive '
                'technologies can surface separately from the label.',
            child: Semantics(
              label: 'Settings',
              tooltip: 'Opens the settings panel',
              child: Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: _p.secondary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.settings, color: Colors.white, size: 32),
              ),
            ),
            properties: {'label': 'Settings',
                'tooltip': 'Opens the settings panel'},
          ),
          const SizedBox(height: 14),
          // Card 5: Multiple-child grouping with label
          _labelCard(
            title: 'Group Label',
            description: 'Wrapping a group of widgets in Semantics(label:) '
                'describes the entire section to assistive tech.',
            child: Semantics(
              label: 'Playback controls',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _miniButton(Icons.skip_previous, 'Previous'),
                  const SizedBox(width: 8),
                  _miniButton(Icons.pause, 'Pause'),
                  const SizedBox(width: 8),
                  _miniButton(Icons.skip_next, 'Next'),
                ],
              ),
            ),
            properties: {'label': 'Playback controls'},
          ),
          const SizedBox(height: 20),
          _instructionBox(
            'Key insight: label describes *what* the element is, hint '
            'describes *what happens* when activated, value describes '
            'the *current state*, and tooltip gives *additional context*. '
            'Each fulfills a different accessibility need.',
          ),
        ],
      ),
    );
  }

  Widget _miniButton(IconData icon, String semantic) {
    return Semantics(
      label: semantic,
      button: true,
      child: Container(
        width: 48, height: 48,
        decoration: BoxDecoration(
          color: _p.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: _p.primary, size: 24),
      ),
    );
  }

  Widget _labelCard({
    required String title,
    required String description,
    required Widget child,
    required Map<String, String> properties,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 15, color: _p.primary)),
          const SizedBox(height: 4),
          Text(description, style: TextStyle(fontSize: 12,
              color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(child: child),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _p.surface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Semantic properties:',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                        color: _p.muted)),
                for (final e in properties.entries)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text('${e.key}: "${e.value}"',
                        style: TextStyle(fontSize: 11,
                            fontFamily: 'monospace',
                            color: _p.onSurface)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 2 — Action Annotations
  // =======================================================================
  Widget _buildActionAnnotations() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Action Annotations'),
          const SizedBox(height: 6),
          Text(
            'Semantic actions describe how users can interact with elements. '
            'Assistive tech uses these to present available actions (tap, '
            'long press, scroll, increase, decrease, etc.).',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // Tap action
          _actionDemo(
            title: 'Tap Action',
            description: 'Semantics(onTap:) marks the element as tappable. '
                'Screen readers announce "activate" or similar.',
            icon: Icons.touch_app,
            actionName: 'onTap',
            color: _p.primary,
          ),
          const SizedBox(height: 12),
          // Long press
          _actionDemo(
            title: 'Long Press Action',
            description: 'Semantics(onLongPress:) signals that long-pressing '
                'performs a secondary action.',
            icon: Icons.pan_tool,
            actionName: 'onLongPress',
            color: _p.secondary,
          ),
          const SizedBox(height: 12),
          // Increase / Decrease
          _actionPairDemo(
            title: 'Increase / Decrease',
            description: 'For sliders and steppers, onIncrease and onDecrease '
                'let assistive tech adjust values.',
            iconUp: Icons.add_circle_outline,
            iconDown: Icons.remove_circle_outline,
          ),
          const SizedBox(height: 12),
          // Scroll actions
          _scrollActionDemo(),
          const SizedBox(height: 12),
          // Custom action
          _customActionDemo(),
          const SizedBox(height: 12),
          // Dismiss action
          _actionDemo(
            title: 'Dismiss Action',
            description: 'Semantics(onDismiss:) enables swipe-to-dismiss '
                'in accessibility mode (e.g., notifications).',
            icon: Icons.swipe,
            actionName: 'onDismiss',
            color: Color(0xFFD84315),
          ),
          const SizedBox(height: 20),
          _instructionBox(
            'Actions are critical for accessibility: they tell assistive '
            'tech exactly how users can interact. Without action annotations, '
            'interactive elements may appear inert to screen reader users.',
          ),
        ],
      ),
    );
  }

  Widget _actionDemo({
    required String title,
    required String description,
    required IconData icon,
    required String actionName,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Semantics(
            label: title,
            button: true,
            onTap: () => _log('$actionName triggered'),
            child: Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: color, width: 2),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: color, size: 30),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 14, color: color)),
                const SizedBox(height: 3),
                Text(description, style: TextStyle(fontSize: 12,
                    color: _p.onSurface.withValues(alpha: 0.7))),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(actionName,
                      style: TextStyle(fontSize: 11, fontFamily: 'monospace',
                          color: color, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionPairDemo({
    required String title,
    required String description,
    required IconData iconUp,
    required IconData iconDown,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text(description, style: TextStyle(fontSize: 12,
              color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Semantics(
            label: 'Temperature',
            value: '22 degrees',
            increasedValue: '23 degrees',
            decreasedValue: '21 degrees',
            onIncrease: () => _log('increase'),
            onDecrease: () => _log('decrease'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: _p.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Icon(iconDown, color: _p.secondary, size: 28),
                ),
                Container(
                  width: 100, height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [_p.primary.withValues(alpha: 0.1),
                          _p.secondary.withValues(alpha: 0.1)]),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _p.primary, width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Text('22°',
                      style: TextStyle(fontSize: 24,
                          fontWeight: FontWeight.bold, color: _p.primary)),
                ),
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: _p.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Icon(iconUp, color: _p.primary, size: 28),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _p.surface,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('onIncrease / onDecrease + value + '
                  'increasedValue / decreasedValue',
                  style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                      color: _p.muted)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollActionDemo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Scroll Actions', style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text(
            'Semantics(onScrollLeft:, onScrollRight:, onScrollUp:, '
            'onScrollDown:) enables directional scrolling via accessibility.',
            style: TextStyle(fontSize: 12,
                color: _p.onSurface.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 12),
          Semantics(
            label: 'Scrollable gallery',
            onScrollLeft: () => _log('scroll left'),
            onScrollRight: () => _log('scroll right'),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _p.surface,
              ),
              child: Row(
                children: [
                  for (var i = 0; i < 5; i++)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _p.primary.withValues(alpha: 0.2 + i * 0.15),
                              _p.secondary.withValues(alpha: 0.2 + i * 0.15),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text('${i + 1}',
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: _p.primary, fontSize: 18)),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, size: 14, color: _p.muted),
              Text('  onScrollLeft / onScrollRight  ',
                  style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                      color: _p.muted)),
              Icon(Icons.arrow_forward, size: 14, color: _p.muted),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customActionDemo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Custom Semantic Actions',
              style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text(
            'CustomSemanticsAction allows defining app-specific actions '
            'beyond the standard set, with custom labels.',
            style: TextStyle(fontSize: 12,
                color: _p.onSurface.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 12),
          Semantics(
            label: 'Message card',
            customSemanticsActions: <CustomSemanticsAction, VoidCallback>{
              const CustomSemanticsAction(label: 'Reply'): () =>
                  _log('reply'),
              const CustomSemanticsAction(label: 'Forward'): () =>
                  _log('forward'),
              const CustomSemanticsAction(label: 'Archive'): () =>
                  _log('archive'),
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _p.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: _p.secondary,
                        child: Text('JD',
                            style: TextStyle(color: Colors.white,
                                fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jane Doe',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 13, color: _p.onSurface)),
                          Text('2 min ago',
                              style: TextStyle(fontSize: 10,
                                  color: _p.muted)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Check out the new accessibility features!',
                      style: TextStyle(fontSize: 13,
                          color: _p.onSurface)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: ['Reply', 'Forward', 'Archive'].map((a) =>
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _p.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(a, style: TextStyle(fontSize: 11,
                            color: _p.primary, fontWeight: FontWeight.w600)),
                      ),
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text('customSemanticsActions: {Reply, Forward, Archive}',
                style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                    color: _p.muted)),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 3 — Container & Merge Semantics
  // =======================================================================
  Widget _buildContainerMerge() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Container & Merge Semantics'),
          const SizedBox(height: 6),
          Text(
            'Flutter provides several widgets that control how semantic nodes '
            'are grouped in the tree: MergeSemantics combines children, '
            'ExcludeSemantics hides them, and BlockSemantics prevents siblings '
            'behind the widget from being accessible.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // MergeSemantics
          _mergeDemo(),
          const SizedBox(height: 14),
          // ExcludeSemantics
          _excludeDemo(),
          const SizedBox(height: 14),
          // BlockSemantics
          _blockDemo(),
          const SizedBox(height: 14),
          // Semantics container
          _containerDemo(),
          const SizedBox(height: 14),
          // Nested semantics
          _nestedDemo(),
          const SizedBox(height: 20),
          _instructionBox(
            'MergeSemantics: all children read as one node. '
            'ExcludeSemantics: children invisible to accessibility. '
            'BlockSemantics: underlying siblings blocked. '
            'Semantics(container: true): creates its own semantic node even '
            'without explicit properties — useful for grouping.',
          ),
        ],
      ),
    );
  }

  Widget _mergeDemo() {
    return _scenarioCard(
      title: 'MergeSemantics',
      description: 'Merges all child semantics into a single node. '
          'Below, the icon and text are read together as one element.',
      child: MergeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(label: 'Warning icon', child:
              Icon(Icons.warning_amber, color: Color(0xFFE65100), size: 28)),
            const SizedBox(width: 8),
            Semantics(label: 'Battery low', child:
              Text('Battery low',
                  style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold, color: _p.onSurface))),
          ],
        ),
      ),
      badge: 'MergeSemantics',
      color: Color(0xFFE65100),
    );
  }

  Widget _excludeDemo() {
    return _scenarioCard(
      title: 'ExcludeSemantics',
      description: 'Completely removes child widgets from the semantic tree. '
          'Useful for decorative elements that should not be announced.',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(
            child: Container(
              width: 50, height: 50,
              decoration: BoxDecoration(
                color: _p.muted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.texture, color: _p.muted, size: 24),
            ),
          ),
          const SizedBox(width: 12),
          Text('← decorative (excluded)',
              style: TextStyle(fontSize: 13, color: _p.muted,
                  fontStyle: FontStyle.italic)),
          const SizedBox(width: 16),
          Semantics(
            label: 'Important content',
            child: Container(
              width: 50, height: 50,
              decoration: BoxDecoration(
                color: _p.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.star, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 8),
          Text('← included',
              style: TextStyle(fontSize: 13, color: _p.primary,
                  fontWeight: FontWeight.w600)),
        ],
      ),
      badge: 'ExcludeSemantics',
      color: Color(0xFF7B1FA2),
    );
  }

  Widget _blockDemo() {
    return _scenarioCard(
      title: 'BlockSemantics',
      description: 'Prevents semantics nodes behind (in z-order) this widget '
          'from being accessible. Commonly used by dialogs and overlays.',
      child: SizedBox(
        height: 100, width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: _p.muted.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Semantics(
                  label: 'Background content (blocked)',
                  child: Text('Background content',
                      style: TextStyle(color: _p.muted, fontSize: 13)),
                ),
              ),
            ),
            Positioned(
              left: 40, right: 40, top: 20, bottom: 20,
              child: BlockSemantics(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black26,
                        blurRadius: 8, offset: Offset(0, 3))],
                  ),
                  alignment: Alignment.center,
                  child: Semantics(
                    label: 'Dialog overlay',
                    child: Text('Dialog (blocks background)',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: _p.primary, fontSize: 14)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      badge: 'BlockSemantics',
      color: Color(0xFFC62828),
    );
  }

  Widget _containerDemo() {
    return _scenarioCard(
      title: 'Semantics Container',
      description: 'Semantics(container: true) creates a distinct semantic '
          'node, even without explicit label/hint/value. This groups '
          'children logically.',
      child: Semantics(
        container: true,
        label: 'Profile section',
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: _p.primary, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: _p.secondary,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Alex Chen', style: TextStyle(
                      fontWeight: FontWeight.bold, color: _p.onSurface)),
                  Text('Software Engineer',
                      style: TextStyle(fontSize: 12, color: _p.muted)),
                ],
              ),
            ],
          ),
        ),
      ),
      badge: 'container: true',
      color: Color(0xFF00695C),
    );
  }

  Widget _nestedDemo() {
    return _scenarioCard(
      title: 'Nested Semantics',
      description: 'When Semantics nodes are nested, properties merge '
          'following specific rules. Inner nodes can override outer labels.',
      child: Semantics(
        label: 'Outer group',
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: _p.muted, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Outer: label = "Outer group"',
                  style: TextStyle(fontSize: 11, color: _p.muted)),
              const SizedBox(height: 8),
              Semantics(
                label: 'Inner item A',
                child: Container(
                  width: 160, height: 36,
                  decoration: BoxDecoration(
                    color: _p.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text('Inner A', style: TextStyle(
                      fontSize: 13, color: _p.primary)),
                ),
              ),
              const SizedBox(height: 6),
              Semantics(
                label: 'Inner item B',
                child: Container(
                  width: 160, height: 36,
                  decoration: BoxDecoration(
                    color: _p.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text('Inner B', style: TextStyle(
                      fontSize: 13, color: _p.secondary)),
                ),
              ),
            ],
          ),
        ),
      ),
      badge: 'nested Semantics',
      color: Color(0xFF37474F),
    );
  }

  Widget _scenarioCard({
    required String title,
    required String description,
    required Widget child,
    required String badge,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 14, color: color)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(badge, style: TextStyle(fontSize: 10,
                    fontFamily: 'monospace', color: color,
                    fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(description, style: TextStyle(fontSize: 12,
              color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(child: child),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 4 — Live Regions
  // =======================================================================
  Widget _buildLiveRegions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Live Regions & Announcements'),
          const SizedBox(height: 6),
          Text(
            'Live regions notify assistive technologies when content changes '
            'dynamically. This is essential for notifications, timers, chat '
            'messages, and any content that updates without user action.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // Live region basic
          _liveRegionBasic(),
          const SizedBox(height: 14),
          // Notification ticker
          _notificationTicker(),
          const SizedBox(height: 14),
          // Timer with live region
          _timerLiveRegion(),
          const SizedBox(height: 14),
          // Status indicators
          _statusIndicators(),
          const SizedBox(height: 14),
          // Announcement log
          _announcementLog(),
          const SizedBox(height: 20),
          _instructionBox(
            'Semantics(liveRegion: true) marks a subtree so that whenever '
            'its semantic content changes, the new content is automatically '
            'announced to screen readers. Use sparingly — too many live '
            'regions can overwhelm users with constant announcements.',
          ),
        ],
      ),
    );
  }

  Widget _liveRegionBasic() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Live Region', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('When liveRegion is true, content changes are announced '
              'automatically without user focus.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Semantics(
            liveRegion: true,
            label: 'Stock price updated',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B5E20).withValues(alpha: 0.1),
                    Color(0xFF1B5E20).withValues(alpha: 0.05)],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF1B5E20).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_up, color: Color(0xFF1B5E20), size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ACME Corp',
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 14, color: _p.onSurface)),
                        Text('\$142.38  +2.4%',
                            style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20))),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Color(0xFF1B5E20).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('LIVE',
                        style: TextStyle(fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationTicker() {
    final notifications = [
      ('New message from Alex', Icons.message, Color(0xFF1565C0)),
      ('Download complete', Icons.cloud_done, Color(0xFF2E7D32)),
      ('Low battery warning', Icons.battery_alert, Color(0xFFE65100)),
      ('Meeting in 5 minutes', Icons.event, Color(0xFF6A1B9A)),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notification Ticker', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('Each notification would be announced as it appears, '
              'thanks to liveRegion: true.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          for (var i = 0; i < notifications.length; i++) ...[
            Semantics(
              liveRegion: true,
              label: notifications[i].$1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: notifications[i].$3.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: notifications[i].$3.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Icon(notifications[i].$2,
                        color: notifications[i].$3, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(notifications[i].$1,
                          style: TextStyle(fontSize: 13,
                              color: _p.onSurface)),
                    ),
                    Text('${i + 1}s ago',
                        style: TextStyle(fontSize: 10, color: _p.muted)),
                  ],
                ),
              ),
            ),
            if (i < notifications.length - 1) const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }

  Widget _timerLiveRegion() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Timer (Live Region)', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: _p.secondary)),
          const SizedBox(height: 4),
          Text('Countdown timers are classic live region candidates — '
              'the changing value needs announcing.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: Semantics(
              liveRegion: true,
              value: '4 minutes 32 seconds remaining',
              child: Container(
                width: 180, height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_p.secondary, _p.secondary.withValues(alpha: 0.7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('04:32',
                        style: TextStyle(fontSize: 36,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontFamily: 'monospace')),
                    Text('remaining',
                        style: TextStyle(fontSize: 12,
                            color: Colors.white60)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusIndicators() {
    final statuses = [
      ('Online', Color(0xFF2E7D32), Icons.circle, true),
      ('Away', Color(0xFFF9A825), Icons.circle, true),
      ('Busy', Color(0xFFC62828), Icons.circle, true),
      ('Offline', Color(0xFF757575), Icons.circle_outlined, false),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status Indicators', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('Status changes should be live regions so users know '
              'when availability changes.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final s in statuses)
                Semantics(
                  liveRegion: s.$4,
                  label: 'Status: ${s.$1}',
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(s.$3, color: s.$2, size: 24),
                      const SizedBox(height: 4),
                      Text(s.$1, style: TextStyle(fontSize: 11,
                          color: _p.onSurface,
                          fontWeight: FontWeight.w600)),
                      if (s.$4) Text('live',
                          style: TextStyle(fontSize: 9,
                              color: s.$2, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _announcementLog() {
    final entries = [
      '10:01 — "New message from Alex" announced',
      '10:02 — "Download complete" announced',
      '10:03 — "Status changed to Away" announced',
      '10:05 — "Meeting starting now" announced',
      '10:06 — "Battery at 15%" announced',
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.history, color: _p.primary, size: 18),
            const SizedBox(width: 6),
            Text('Announcement Log', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: _p.primary)),
          ]),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _p.onSurface.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final e in entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(e, style: TextStyle(fontSize: 11,
                        fontFamily: 'monospace', color: _p.onSurface)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 5 — Properties Dashboard
  // =======================================================================
  Widget _buildPropertiesDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Custom Properties Dashboard'),
          const SizedBox(height: 6),
          Text(
            'Semantics supports many boolean flags and properties that '
            'describe the nature of a widget to assistive tech. Each tile '
            'below shows a different flag with an illustrative widget.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          _propertyGrid(),
          const SizedBox(height: 16),
          // Textfield semantics
          _textFieldSemantics(),
          const SizedBox(height: 14),
          // Image semantics
          _imageSemantics(),
          const SizedBox(height: 14),
          // Slider semantics
          _sliderSemantics(),
          const SizedBox(height: 20),
          _instructionBox(
            'Each property tells assistive tech the nature of the element: '
            'button, header, image, link, slider, text field, checked, '
            'toggled, enabled, focused, hidden, etc. Setting these correctly '
            'ensures screen readers give users accurate context.',
          ),
        ],
      ),
    );
  }

  Widget _propertyGrid() {
    final props = <(String, IconData, String, bool)>[
      ('button', Icons.smart_button, 'Activatable element', true),
      ('header', Icons.title, 'Section heading', true),
      ('link', Icons.link, 'Navigable link', true),
      ('image', Icons.image, 'Visual content', true),
      ('slider', Icons.linear_scale, 'Range selector', true),
      ('checked', Icons.check_box, 'Checkbox state', true),
      ('toggled', Icons.toggle_on, 'Switch/toggle state', true),
      ('enabled', Icons.power, 'Can be interacted with', true),
      ('focused', Icons.center_focus_strong, 'Has input focus', false),
      ('hidden', Icons.visibility_off, 'Present but hidden', false),
      ('readOnly', Icons.lock, 'Visible but not editable', true),
      ('selected', Icons.radio_button_checked, 'Currently selected', true),
      ('multiline', Icons.wrap_text, 'Multi-line text input', false),
      ('obscured', Icons.password, 'Password field', true),
      ('scopesRoute', Icons.route, 'Navigation scope', false),
      ('namesRoute', Icons.label, 'Names the route', false),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final p in props)
          Container(
            width: 175,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: p.$4
                    ? _p.primary.withValues(alpha: 0.4)
                    : _p.muted.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 3, offset: Offset(0, 1))],
            ),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: (p.$4 ? _p.primary : _p.muted)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Icon(p.$2,
                      color: p.$4 ? _p.primary : _p.muted, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.$1, style: TextStyle(fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          color: p.$4 ? _p.primary : _p.muted)),
                      Text(p.$3, style: TextStyle(fontSize: 9,
                          color: _p.onSurface.withValues(alpha: 0.6))),
                    ],
                  ),
                ),
                Container(
                  width: 14, height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.$4
                        ? Color(0xFF2E7D32).withValues(alpha: 0.8)
                        : _p.muted.withValues(alpha: 0.3),
                  ),
                  alignment: Alignment.center,
                  child: Icon(p.$4 ? Icons.check : Icons.remove,
                      color: Colors.white, size: 10),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _textFieldSemantics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TextField Semantics', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('TextFields automatically get textField, multiline, '
              'readOnly, obscured flags as appropriate.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _fieldExample('Username', false, false,
                    Icons.person_outline),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _fieldExample('Password', true, false,
                    Icons.lock_outline),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _fieldExample('Bio (multiline)', false, true,
              Icons.text_snippet_outlined),
        ],
      ),
    );
  }

  Widget _fieldExample(String label, bool obscured, bool multiline,
      IconData icon) {
    return Semantics(
      textField: true,
      label: label,
      obscured: obscured,
      multiline: multiline,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: _p.primary.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: _p.muted),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 12,
                      color: _p.muted)),
                  if (obscured)
                    Text('••••••••', style: TextStyle(fontSize: 14,
                        color: _p.onSurface))
                  else if (multiline)
                    Text('Long text that\nspans multiple lines…',
                        style: TextStyle(fontSize: 12,
                            color: _p.onSurface.withValues(alpha: 0.5)))
                  else
                    Text('user_name',
                        style: TextStyle(fontSize: 14,
                            color: _p.onSurface)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSemantics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Image Semantics', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('Images need a semantic label describing their content. '
              'Decorative images should be excluded from semantics.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              // Informative image
              Expanded(
                child: Semantics(
                  image: true,
                  label: 'Mountain landscape at sunset',
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFF6F00),
                          Color(0xFF1A237E),
                        ],
                      ),
                    ),
                    child: CustomPaint(
                      painter: _MountainPainter(_p.primary),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text('Labeled ✓',
                              style: TextStyle(fontSize: 10,
                                  color: Colors.white70)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Decorative image
              Expanded(
                child: ExcludeSemantics(
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _p.muted.withValues(alpha: 0.15),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.texture, color: _p.muted, size: 32),
                        const SizedBox(height: 4),
                        Text('Decorative (excluded)',
                            style: TextStyle(fontSize: 10,
                                color: _p.muted)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sliderSemantics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Slider Semantics', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('Sliders use value, increasedValue, decreasedValue, and '
              'the slider flag together.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Semantics(
            slider: true,
            label: 'Brightness',
            value: '60 percent',
            increasedValue: '65 percent',
            decreasedValue: '55 percent',
            onIncrease: () => _log('brightness +5'),
            onDecrease: () => _log('brightness -5'),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.brightness_low, color: _p.muted, size: 18),
                    Expanded(
                      child: Container(
                        height: 26,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: _p.surface,
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.6,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              gradient: LinearGradient(
                                  colors: [_p.primary, _p.accent]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.brightness_high, color: _p.primary, size: 18),
                  ],
                ),
                const SizedBox(height: 4),
                Text('60%', style: TextStyle(fontWeight: FontWeight.bold,
                    color: _p.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 6 — Verification & Summary
  // =======================================================================
  Widget _buildVerification() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification & Summary'),
          const SizedBox(height: 12),
          // Quick-reference table
          _referenceTable(),
          const SizedBox(height: 16),
          // Semantic flags grid
          _flagsVerificationGrid(),
          const SizedBox(height: 16),
          // FAQ
          _faqSection(),
          const SizedBox(height: 16),
          // Best practices
          _bestPractices(),
          const SizedBox(height: 16),
          _instructionBox(
            'RenderSemanticsAnnotations is the rendering-layer engine behind '
            'the Semantics widget. Every label, hint, value, action, and flag '
            'set via Semantics ultimately becomes a SemanticsAnnotation on a '
            'RenderObject in the render tree. Understanding these annotations '
            'is essential for building truly accessible Flutter apps.',
          ),
        ],
      ),
    );
  }

  Widget _referenceTable() {
    final rows = <(String, String, String)>[
      ('label', 'String', 'Primary accessible name'),
      ('hint', 'String', 'Activation guidance'),
      ('value', 'String', 'Current state/value'),
      ('tooltip', 'String', 'Additional context'),
      ('increasedValue', 'String', 'Value after increase'),
      ('decreasedValue', 'String', 'Value after decrease'),
      ('onTap', 'VoidCallback?', 'Tap action'),
      ('onLongPress', 'VoidCallback?', 'Long press action'),
      ('onIncrease', 'VoidCallback?', 'Increase action'),
      ('onDecrease', 'VoidCallback?', 'Decrease action'),
      ('onScrollLeft', 'VoidCallback?', 'Scroll left'),
      ('onScrollRight', 'VoidCallback?', 'Scroll right'),
      ('onDismiss', 'VoidCallback?', 'Dismiss action'),
      ('liveRegion', 'bool', 'Auto-announce changes'),
      ('container', 'bool', 'Creates semantic node'),
      ('button', 'bool', 'Is a button'),
      ('header', 'bool', 'Is a heading'),
      ('link', 'bool', 'Is a link'),
      ('image', 'bool', 'Is an image'),
      ('slider', 'bool', 'Is a slider'),
      ('textField', 'bool', 'Is a text field'),
      ('readOnly', 'bool', 'Not editable'),
      ('obscured', 'bool', 'Content hidden'),
      ('multiline', 'bool', 'Multi-line input'),
      ('focused', 'bool', 'Has focus'),
      ('enabled', 'bool', 'Is interactive'),
      ('checked', 'bool?', 'Checkbox/radio state'),
      ('toggled', 'bool?', 'Toggle/switch state'),
      ('selected', 'bool', 'Is selected'),
      ('hidden', 'bool', 'Exists but hidden'),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _p.primary.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10)),
            ),
            child: Text('Semantics Properties Reference',
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 14, color: _p.primary)),
          ),
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _p.onSurface.withValues(alpha: 0.04),
            ),
            child: Row(
              children: [
                SizedBox(width: 130, child: Text('Property',
                    style: TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 11, color: _p.muted))),
                SizedBox(width: 100, child: Text('Type',
                    style: TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 11, color: _p.muted))),
                Expanded(child: Text('Purpose',
                    style: TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 11, color: _p.muted))),
              ],
            ),
          ),
          for (var i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 5),
              color: i.isEven
                  ? Colors.transparent
                  : _p.onSurface.withValues(alpha: 0.02),
              child: Row(
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(rows[i].$1,
                        style: TextStyle(fontSize: 11,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                            color: _p.primary)),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(rows[i].$2,
                        style: TextStyle(fontSize: 10,
                            fontFamily: 'monospace',
                            color: _p.muted)),
                  ),
                  Expanded(
                    child: Text(rows[i].$3,
                        style: TextStyle(fontSize: 11,
                            color: _p.onSurface)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _flagsVerificationGrid() {
    final checks = <(String, bool)>[
      ('Semantics(label:) renders annotations', true),
      ('Semantics(hint:) adds activation hint', true),
      ('Semantics(value:) communicates state', true),
      ('Semantics(tooltip:) adds tooltip', true),
      ('MergeSemantics combines children', true),
      ('ExcludeSemantics hides from tree', true),
      ('BlockSemantics blocks siblings', true),
      ('liveRegion auto-announces changes', true),
      ('customSemanticsActions adds actions', true),
      ('onIncrease/onDecrease for range controls', true),
      ('button/header/link/image flags work', true),
      ('textField + obscured for passwords', true),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Verification Checklist', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: Color(0xFF2E7D32))),
          const SizedBox(height: 10),
          for (final c in checks)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(c.$2 ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: c.$2 ? Color(0xFF2E7D32) : _p.muted, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(c.$1,
                      style: TextStyle(fontSize: 12,
                          color: _p.onSurface))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _faqSection() {
    final faqs = <(String, String)>[
      ('What is RenderSemanticsAnnotations?',
       'It is the rendering-layer RenderObject that stores semantic '
       'annotations (labels, actions, flags) on a node in the render tree. '
       'The Semantics widget creates it.'),
      ('When should I use Semantics vs MergeSemantics?',
       'Use Semantics to annotate individual elements. Use MergeSemantics '
       'when multiple elements should be read as one (e.g., icon + text).'),
      ('Are live regions expensive?',
       'Not performance-wise, but they can be annoying — every change is '
       'spoken aloud. Only use them for content the user needs to know '
       'about immediately.'),
      ('How do custom semantic actions work?',
       'CustomSemanticsAction creates named actions that appear in the '
       'accessibility actions menu. Users can activate them via switch '
       'access or screen reader action lists.'),
      ('Should every widget have a Semantics wrapper?',
       'No. Interactive widgets (Button, TextField) add their own semantics. '
       'CustomPaint, raw Container, and icon-only widgets often need help.'),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.help_outline, color: _p.primary, size: 18),
            const SizedBox(width: 6),
            Text('FAQ', style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 14, color: _p.primary)),
          ]),
          const SizedBox(height: 10),
          for (var i = 0; i < faqs.length; i++) ...[
            Text('Q: ${faqs[i].$1}',
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 12, color: _p.onSurface)),
            const SizedBox(height: 3),
            Text('A: ${faqs[i].$2}',
                style: TextStyle(fontSize: 12,
                    color: _p.onSurface.withValues(alpha: 0.8))),
            if (i < faqs.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _bestPractices() {
    final practices = [
      'Always add labels to interactive custom widgets',
      'Use hint to describe the result of activation, not the action itself',
      'Set image: true for visual content with descriptive labels',
      'Exclude purely decorative elements with ExcludeSemantics',
      'Use MergeSemantics when icon + text form a single unit',
      'Mark dynamic content with liveRegion: true sparingly',
      'Provide increasedValue/decreasedValue for sliders and steppers',
      'Test with TalkBack (Android) and VoiceOver (iOS) regularly',
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _p.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.lightbulb_outline, color: _p.accent, size: 18),
            const SizedBox(width: 6),
            Text('Best Practices', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14,
                color: _p.primary)),
          ]),
          const SizedBox(height: 10),
          for (var i = 0; i < practices.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${i + 1}. ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12,
                      color: _p.accent)),
                  Expanded(child: Text(practices[i],
                      style: TextStyle(fontSize: 12,
                          color: _p.onSurface))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Shared helpers
  // -----------------------------------------------------------------------
  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4, height: 20,
          decoration: BoxDecoration(
            color: _p.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold, color: _p.onSurface)),
      ],
    );
  }

  Widget _instructionBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _p.secondary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.secondary.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _p.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 12,
                color: _p.onSurface, height: 1.4)),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Footer
  // -----------------------------------------------------------------------
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: _p.onSurface.withValues(alpha: 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_scenarioTitles[_scenario],
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                  color: _p.muted)),
          Text('Palette: ${_p.name}',
              style: TextStyle(fontSize: 11, color: _p.muted)),
          Text('RenderSemanticsAnnotations',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace',
                  color: _p.muted)),
        ],
      ),
    );
  }
}

// =========================================================================
// Custom painter — mountain silhouette for image semantics demo
// =========================================================================
class _MountainPainter extends CustomPainter {
  final Color color;
  _MountainPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.25);
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.2, size.height * 0.4)
      ..lineTo(size.width * 0.35, size.height * 0.6)
      ..lineTo(size.width * 0.55, size.height * 0.25)
      ..lineTo(size.width * 0.7, size.height * 0.5)
      ..lineTo(size.width * 0.85, size.height * 0.35)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
