// ignore_for_file: avoid_print
// Deep demo: RenderSemanticsGestureHandler — Gesture Recognition Gallery
// Demonstrates how Flutter routes semantic accessibility gestures through
// GestureDetector, InkWell, Dismissible, Draggable, and related widgets
// to GestureRecognizers via the rendering layer.
import 'dart:math';
import 'package:flutter/material.dart';

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
  _Pal('Indigo / Amber', Color(0xFF283593), Color(0xFFFF8F00),
      Color(0xFFE8EAF6), Color(0xFF1A237E), Color(0xFF536DFE), Color(0xFF9FA8DA)),
  _Pal('Teal / Coral', Color(0xFF00695C), Color(0xFFE64A19),
      Color(0xFFE0F2F1), Color(0xFF004D40), Color(0xFF1DE9B6), Color(0xFF80CBC4)),
  _Pal('Slate / Lime', Color(0xFF37474F), Color(0xFF9E9D24),
      Color(0xFFECEFF1), Color(0xFF263238), Color(0xFFEEFF41), Color(0xFF90A4AE)),
];

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _GestureRecognitionGallery();
}

class _GestureRecognitionGallery extends StatefulWidget {
  const _GestureRecognitionGallery();
  @override
  State<_GestureRecognitionGallery> createState() =>
      _GestureRecognitionGalleryState();
}

class _GestureRecognitionGalleryState
    extends State<_GestureRecognitionGallery> {
  int _scenario = 0;
  int _palette = 0;
  bool _verbose = false;

  static const _scenarioTitles = <String>[
    '1 · Tap & Double-Tap',
    '2 · Long Press Studio',
    '3 · Drag & Pan Workshop',
    '4 · Scale & Rotation Lab',
    '5 · Swipe & Dismissible',
    '6 · Verification & Guide',
  ];

  _Pal get _p => _palettes[_palette];

  void _log(String msg) {
    if (_verbose) print('[GestureGallery] $msg');
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
              Icon(Icons.touch_app, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Text('Gesture Recognition Gallery',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'RenderSemanticsGestureHandler routes semantic accessibility '
            'actions to GestureRecognizer callbacks. This demo explores '
            'taps, long-press, drags, scale, swipe, and dismissible patterns.',
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
      color: _p.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Wrap(
        spacing: 10,
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
              onSelected: (_) =>
                  setState(() { _scenario = i; _log('scenario=$i'); }),
            ),
          const SizedBox(width: 14),
          Text('Palette:', style: TextStyle(fontWeight: FontWeight.w600,
              color: _p.onSurface, fontSize: 13)),
          for (var j = 0; j < _palettes.length; j++)
            GestureDetector(
              onTap: () =>
                  setState(() { _palette = j; _log('palette=$j'); }),
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
          const SizedBox(width: 8),
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
      case 0: return _buildTapArena();
      case 1: return _buildLongPressStudio();
      case 2: return _buildDragPanWorkshop();
      case 3: return _buildScaleRotationLab();
      case 4: return _buildSwipeDismissible();
      case 5: return _buildVerification();
      default: return const SizedBox.shrink();
    }
  }

  // =======================================================================
  // SCENARIO 1 — Tap & Double-Tap Arena
  // =======================================================================
  Widget _buildTapArena() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Tap & Double-Tap Arena'),
          const SizedBox(height: 6),
          Text(
            'GestureDetector registers TapGestureRecognizer and '
            'DoubleTapGestureRecognizer. The rendering layer creates a '
            'RenderSemanticsGestureHandler that maps semantic "activate" '
            'actions to these recognizers so screen readers can trigger taps.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // Tap pad row
          _tapPadRow(),
          const SizedBox(height: 14),
          // Double-tap comparison
          _doubleTapComparison(),
          const SizedBox(height: 14),
          // TapDown / TapUp / TapCancel lifecycle
          _tapLifecycleCards(),
          const SizedBox(height: 14),
          // Multiple recognizers on same widget
          _multiRecognizerDemo(),
          const SizedBox(height: 14),
          // InkWell tap showcase
          _inkWellTapShowcase(),
          const SizedBox(height: 20),
          _instructionBox(
            'Key insight: When you use GestureDetector(onTap:), Flutter '
            'creates a TapGestureRecognizer and the rendering layer '
            'automatically creates a RenderSemanticsGestureHandler that '
            'maps the semantic "tap" action to that recognizer. Screen '
            'readers use this mapping to let users activate tappable elements.',
          ),
        ],
      ),
    );
  }

  Widget _tapPadRow() {
    final colors = [_p.primary, _p.secondary, _p.accent,
        Color(0xFF6A1B9A)];
    final labels = ['Single Tap', 'Double Tap', 'Tap Down', 'Tap Cancel'];
    final icons = [Icons.touch_app, Icons.double_arrow,
        Icons.arrow_downward, Icons.cancel_outlined];
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
          Text('Tap Pads', style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('Each pad responds to a different tap gesture type.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < 4; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 8 : 0),
                    child: GestureDetector(
                      onTap: i == 0
                          ? () => _log('single tap')
                          : null,
                      onDoubleTap: i == 1
                          ? () => _log('double tap')
                          : null,
                      onTapDown: i == 2
                          ? (_) => _log('tap down')
                          : null,
                      onTapCancel: i == 3
                          ? () => _log('tap cancel')
                          : null,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: colors[i].withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colors[i], width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icons[i], color: colors[i], size: 24),
                            const SizedBox(height: 4),
                            Text(labels[i],
                                style: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: colors[i]),
                                textAlign: TextAlign.center),
                          ],
                        ),
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

  Widget _doubleTapComparison() {
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
          Text('Single vs Double Tap', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('When both are registered, Flutter waits ~300ms after a '
              'single tap to see if a second tap arrives before firing onTap.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _log('left: single tap'),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [_p.primary.withValues(alpha: 0.1),
                            _p.primary.withValues(alpha: 0.2)]),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: _p.primary.withValues(alpha: 0.4)),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.looks_one, color: _p.primary, size: 22),
                        Text('onTap only',
                            style: TextStyle(fontSize: 11,
                                color: _p.primary,
                                fontWeight: FontWeight.w600)),
                        Text('fires immediately',
                            style: TextStyle(fontSize: 9,
                                color: _p.muted)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => _log('right: single tap (delayed)'),
                  onDoubleTap: () => _log('right: double tap'),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [_p.secondary.withValues(alpha: 0.1),
                            _p.secondary.withValues(alpha: 0.2)]),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: _p.secondary.withValues(alpha: 0.4)),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.looks_two, color: _p.secondary, size: 22),
                        Text('onTap + onDoubleTap',
                            style: TextStyle(fontSize: 11,
                                color: _p.secondary,
                                fontWeight: FontWeight.w600)),
                        Text('tap delayed ~300ms',
                            style: TextStyle(fontSize: 9,
                                color: _p.muted)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _p.surface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Timeline: tap → 300ms wait → no 2nd tap → onTap fires\n'
              'Timeline: tap → tap (< 300ms) → onDoubleTap fires',
              style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                  color: _p.muted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tapLifecycleCards() {
    final phases = <(String, String, IconData, Color)>[
      ('onTapDown', 'Finger contacts the screen at a specific position. '
          'Provides TapDownDetails with globalPosition and localPosition.',
          Icons.arrow_downward, Color(0xFF1565C0)),
      ('onTapUp', 'Finger lifts after a successful tap. Provides '
          'TapUpDetails with position info.',
          Icons.arrow_upward, Color(0xFF2E7D32)),
      ('onTapCancel', 'Gesture was aborted (finger moved too far or '
          'another recognizer won the arena).',
          Icons.cancel_outlined, Color(0xFFC62828)),
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
          Text('Tap Lifecycle', style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('The full tap lifecycle from finger-down to completion '
              'or cancellation.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          for (var i = 0; i < phases.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: phases[i].$4.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: phases[i].$4, width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: Icon(phases[i].$3, color: phases[i].$4, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(phases[i].$1, style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13,
                          fontFamily: 'monospace', color: phases[i].$4)),
                      Text(phases[i].$2, style: TextStyle(fontSize: 11,
                          color: _p.onSurface.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ],
            ),
            if (i < phases.length - 1) ...[
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Container(
                    width: 2, height: 16,
                    color: _p.muted.withValues(alpha: 0.3)),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _multiRecognizerDemo() {
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
          Text('Multiple Recognizers', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('A single GestureDetector can register tap, double-tap, and '
              'long-press simultaneously. The gesture arena resolves conflicts.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: () => _log('multi: tap'),
              onDoubleTap: () => _log('multi: double tap'),
              onLongPress: () => _log('multi: long press'),
              child: Container(
                width: 180, height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_p.primary, _p.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: _p.primary.withValues(alpha: 0.3),
                      blurRadius: 8, offset: Offset(0, 4))],
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.gesture, color: Colors.white, size: 28),
                    const SizedBox(height: 4),
                    Text('Tap · Double · Long',
                        style: TextStyle(color: Colors.white, fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    Text('3 recognizers, 1 widget',
                        style: TextStyle(color: Colors.white60, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _p.surface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Arena resolution order:\n'
              '1. Quick release → TapGestureRecognizer wins\n'
              '2. Fast double-touch → DoubleTapGestureRecognizer wins\n'
              '3. Hold > 500ms → LongPressGestureRecognizer wins',
              style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                  color: _p.muted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inkWellTapShowcase() {
    final items = <(String, IconData, Color)>[
      ('Tap ripple', Icons.water_drop, _p.primary),
      ('Highlight', Icons.highlight, _p.secondary),
      ('Splash', Icons.blur_on, _p.accent),
      ('Custom', Icons.auto_awesome, Color(0xFF6A1B9A)),
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
          Text('InkWell Tap Effects', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('InkWell creates the same semantic gesture handler as '
              'GestureDetector but adds Material ink splash effects.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 6 : 0),
                    child: Material(
                      color: items[i].$3.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: items[i].$3.withValues(alpha: 0.3),
                        highlightColor: items[i].$3.withValues(alpha: 0.1),
                        onTap: () => _log('inkwell ${items[i].$1}'),
                        child: Container(
                          height: 72,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(items[i].$2, color: items[i].$3, size: 22),
                              const SizedBox(height: 3),
                              Text(items[i].$1,
                                  style: TextStyle(fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: items[i].$3)),
                            ],
                          ),
                        ),
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

  // =======================================================================
  // SCENARIO 2 — Long Press Studio
  // =======================================================================
  Widget _buildLongPressStudio() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Long Press Studio'),
          const SizedBox(height: 6),
          Text(
            'LongPressGestureRecognizer fires when a pointer stays in '
            'approximately the same position for 500+ milliseconds. The '
            'semantic handler maps the accessibility "long press" action '
            'to this recognizer.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // Basic long press
          _longPressBasic(),
          const SizedBox(height: 14),
          // Long press lifecycle
          _longPressLifecycle(),
          const SizedBox(height: 14),
          // Context menu trigger
          _contextMenuTrigger(),
          const SizedBox(height: 14),
          // Long press drag
          _longPressDragDemo(),
          const SizedBox(height: 14),
          // Duration comparison
          _durationComparison(),
          const SizedBox(height: 20),
          _instructionBox(
            'Long press is often used for secondary actions: context menus, '
            'drag initiation, selection mode, and reordering. The semantic '
            'gesture handler ensures all these patterns work with assistive '
            'technology through the "long press" semantic action.',
          ),
        ],
      ),
    );
  }

  Widget _longPressBasic() {
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
          Text('Basic Long Press', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Hold the target for 500ms+ to trigger onLongPress.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onLongPress: () => _log('long press fired'),
              child: Container(
                width: 140, height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [_p.primary.withValues(alpha: 0.08),
                      _p.primary.withValues(alpha: 0.25)],
                  ),
                  border: Border.all(color: _p.primary, width: 3),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.fingerprint, color: _p.primary, size: 36),
                    const SizedBox(height: 4),
                    Text('Hold me',
                        style: TextStyle(color: _p.primary, fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    Text('500ms',
                        style: TextStyle(color: _p.muted, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _longPressLifecycle() {
    final steps = <(String, String, Color)>[
      ('onLongPressDown', 'Initial contact detected (before timer starts)',
          Color(0xFF0277BD)),
      ('onLongPressCancel', 'Finger moved too far before 500ms',
          Color(0xFFC62828)),
      ('onLongPress', 'Timer reached 500ms — long press confirmed',
          Color(0xFF2E7D32)),
      ('onLongPressMoveUpdate', 'Finger moves after long press confirmed',
          Color(0xFFE65100)),
      ('onLongPressUp', 'Finger lifts after long press',
          Color(0xFF6A1B9A)),
      ('onLongPressEnd', 'Long press gesture completely finished',
          Color(0xFF37474F)),
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
          Text('Long Press Lifecycle', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 10),
          for (var i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: steps[i].$3,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text('${i + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(steps[i].$1, style: TextStyle(
                          fontFamily: 'monospace', fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: steps[i].$3)),
                      Text(steps[i].$2, style: TextStyle(fontSize: 11,
                          color: _p.onSurface.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ],
            ),
            if (i < steps.length - 1)
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Container(width: 2, height: 10,
                    color: _p.muted.withValues(alpha: 0.2)),
              ),
          ],
        ],
      ),
    );
  }

  Widget _contextMenuTrigger() {
    final menuItems = ['Copy', 'Paste', 'Select All', 'Delete'];
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
          Text('Context Menu Pattern', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('Long press typically shows a context menu. This is one '
              'of the most common uses of onLongPress.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trigger area
              GestureDetector(
                onLongPress: () => _log('context menu triggered'),
                child: Container(
                  width: 160, height: 80,
                  decoration: BoxDecoration(
                    color: _p.secondary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: _p.secondary.withValues(alpha: 0.3)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.text_snippet,
                          color: _p.secondary, size: 24),
                      Text('Long-press here',
                          style: TextStyle(fontSize: 11,
                              color: _p.secondary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Simulated menu
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black26,
                      blurRadius: 8, offset: Offset(0, 3))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in menuItems)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(item,
                            style: TextStyle(fontSize: 12,
                                color: _p.onSurface)),
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

  Widget _longPressDragDemo() {
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
          Text('Long Press + Drag', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('onLongPressMoveUpdate tracks movement after the long press '
              'is confirmed. Used for reorder handles and drag-after-hold.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          GestureDetector(
            onLongPress: () => _log('drag: long press started'),
            onLongPressMoveUpdate: (d) =>
                _log('drag: offset=${d.localOffsetFromOrigin}'),
            onLongPressEnd: (_) => _log('drag: ended'),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _p.surface,
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: _p.primary.withValues(alpha: 0.15),
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10)),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.drag_handle,
                        color: _p.primary, size: 24),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reorderable Item',
                              style: TextStyle(fontWeight: FontWeight.w600,
                                  fontSize: 13, color: _p.onSurface)),
                          Text('Long-press handle to drag',
                              style: TextStyle(fontSize: 10,
                                  color: _p.muted)),
                        ],
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: _p.muted),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _durationComparison() {
    final durations = [200, 500, 800, 1200];
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
          Text('Duration Thresholds', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Default long-press threshold is 500ms. Shown here with '
              'visual gauge representation.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          for (var d in durations) ...[
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text('${d}ms', style: TextStyle(fontSize: 11,
                      fontFamily: 'monospace', fontWeight: FontWeight.w600,
                      color: d >= 500 ? _p.primary : _p.muted)),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: _p.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (d / 1500).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: d >= 500
                                ? [_p.primary, _p.accent]
                                : [_p.muted.withValues(alpha: 0.4),
                                    _p.muted.withValues(alpha: 0.6)],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(d >= 500 ? Icons.check_circle : Icons.cancel,
                    color: d >= 500 ? Color(0xFF2E7D32) : _p.muted,
                    size: 18),
              ],
            ),
            const SizedBox(height: 6),
          ],
          const SizedBox(height: 4),
          Center(
            child: Text('← 500ms threshold →',
                style: TextStyle(fontSize: 10, color: _p.muted)),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 3 — Drag & Pan Workshop
  // =======================================================================
  Widget _buildDragPanWorkshop() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Drag & Pan Workshop'),
          const SizedBox(height: 6),
          Text(
            'DragGestureRecognizer comes in three variants: horizontal, '
            'vertical, and pan (both axes). The semantic gesture handler '
            'maps scroll semantic actions to drag recognizers.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // Horizontal drag
          _horizontalDragTrack(),
          const SizedBox(height: 14),
          // Vertical drag
          _verticalDragTrack(),
          const SizedBox(height: 14),
          // Pan demo
          _panCanvas(),
          const SizedBox(height: 14),
          // Drag details
          _dragDetailsCard(),
          const SizedBox(height: 14),
          // Drag direction comparison
          _dragDirectionComparison(),
          const SizedBox(height: 20),
          _instructionBox(
            'Drag gestures fire continuously during pointer movement. '
            'onDragStart provides the initial position, onDragUpdate gives '
            'delta/offset changes, and onDragEnd provides velocity. '
            'The semantic handler translates scroll actions from screen '
            'readers into corresponding drag callbacks.',
          ),
        ],
      ),
    );
  }

  Widget _horizontalDragTrack() {
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
          Text('Horizontal Drag Track', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('onHorizontalDragUpdate fires as the finger moves '
              'left or right along the track.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          GestureDetector(
            onHorizontalDragUpdate: (d) =>
                _log('h-drag delta=${d.delta.dx.toStringAsFixed(1)}'),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: _p.surface,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Track markers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < 7; i++)
                        Container(
                          width: 2, height: i.isEven ? 20 : 12,
                          color: _p.muted.withValues(alpha: 0.3),
                        ),
                    ],
                  ),
                  // Thumb
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _p.primary,
                      boxShadow: [BoxShadow(
                          color: _p.primary.withValues(alpha: 0.3),
                          blurRadius: 6)],
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.swap_horiz,
                        color: Colors.white, size: 22),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(Icons.arrow_back, size: 12, color: _p.muted),
                Text(' Left', style: TextStyle(fontSize: 10,
                    color: _p.muted)),
              ]),
              Text('onHorizontalDragUpdate',
                  style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                      color: _p.muted)),
              Row(children: [
                Text('Right ', style: TextStyle(fontSize: 10,
                    color: _p.muted)),
                Icon(Icons.arrow_forward, size: 12, color: _p.muted),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _verticalDragTrack() {
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
          Text('Vertical Drag Track', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('onVerticalDragUpdate fires as the finger moves up or '
              'down. Often used for custom scrolling and pull-to-refresh.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onVerticalDragUpdate: (d) =>
                  _log('v-drag delta=${d.delta.dy.toStringAsFixed(1)}'),
              child: Container(
                width: 60, height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: _p.surface,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var i = 0; i < 7; i++)
                          Container(
                            width: i.isEven ? 20 : 12, height: 2,
                            color: _p.muted.withValues(alpha: 0.3),
                          ),
                      ],
                    ),
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _p.secondary,
                        boxShadow: [BoxShadow(
                            color: _p.secondary.withValues(alpha: 0.3),
                            blurRadius: 6)],
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.swap_vert,
                          color: Colors.white, size: 22),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text('onVerticalDragUpdate',
                style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                    color: _p.muted)),
          ),
        ],
      ),
    );
  }

  Widget _panCanvas() {
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
          Text('2D Pan Canvas', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Pan combines horizontal and vertical into free 2D movement. '
              'Used for image viewers, map panning, and drawing apps.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          GestureDetector(
            onPanUpdate: (d) =>
                _log('pan dx=${d.delta.dx.toStringAsFixed(1)} '
                    'dy=${d.delta.dy.toStringAsFixed(1)}'),
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _p.surface,
              ),
              child: CustomPaint(
                painter: _GridPainter(_p.muted.withValues(alpha: 0.2)),
                child: Stack(
                  children: [
                    // Crosshair center
                    Center(
                      child: Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _p.primary.withValues(alpha: 0.15),
                          border: Border.all(color: _p.primary, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.open_with,
                            color: _p.primary, size: 22),
                      ),
                    ),
                    // Direction arrows
                    Positioned(
                      top: 10, left: 0, right: 0,
                      child: Center(child: Icon(Icons.arrow_upward,
                          color: _p.muted.withValues(alpha: 0.4), size: 16)),
                    ),
                    Positioned(
                      bottom: 10, left: 0, right: 0,
                      child: Center(child: Icon(Icons.arrow_downward,
                          color: _p.muted.withValues(alpha: 0.4), size: 16)),
                    ),
                    Positioned(
                      left: 10, top: 0, bottom: 0,
                      child: Center(child: Icon(Icons.arrow_back,
                          color: _p.muted.withValues(alpha: 0.4), size: 16)),
                    ),
                    Positioned(
                      right: 10, top: 0, bottom: 0,
                      child: Center(child: Icon(Icons.arrow_forward,
                          color: _p.muted.withValues(alpha: 0.4), size: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text('onPanUpdate: DragUpdateDetails(delta, '
                'globalPosition, localPosition)',
                style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                    color: _p.muted)),
          ),
        ],
      ),
    );
  }

  Widget _dragDetailsCard() {
    final details = <(String, String, String)>[
      ('DragStartDetails', 'globalPosition, localPosition',
          'Starting point of drag'),
      ('DragUpdateDetails', 'delta, primaryDelta, globalPosition',
          'Movement since last update'),
      ('DragEndDetails', 'velocity, primaryVelocity',
          'Final velocity when released'),
      ('DragDownDetails', 'globalPosition, localPosition',
          'Contact point before drag starts'),
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
          Text('Drag Detail Types', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 10),
          for (var i = 0; i < details.length; i++) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: i.isEven ? _p.primary.withValues(alpha: 0.04)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(details[i].$1, style: TextStyle(
                      fontFamily: 'monospace', fontSize: 12,
                      fontWeight: FontWeight.bold, color: _p.primary)),
                  Text('Properties: ${details[i].$2}',
                      style: TextStyle(fontSize: 11,
                          fontFamily: 'monospace', color: _p.muted)),
                  Text(details[i].$3, style: TextStyle(fontSize: 11,
                      color: _p.onSurface.withValues(alpha: 0.7))),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _dragDirectionComparison() {
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
          Text('Drag vs Pan: When to Use', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _p.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: _p.primary.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.swap_horiz,
                          color: _p.primary, size: 24),
                      const SizedBox(height: 4),
                      Text('Horizontal',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 12, color: _p.primary)),
                      const SizedBox(height: 4),
                      Text('Sliders\nCarousels\nSwipe cards',
                          style: TextStyle(fontSize: 10,
                              color: _p.onSurface),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _p.secondary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: _p.secondary.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.swap_vert,
                          color: _p.secondary, size: 24),
                      const SizedBox(height: 4),
                      Text('Vertical',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 12, color: _p.secondary)),
                      const SizedBox(height: 4),
                      Text('Scroll views\nPull refresh\nBottom sheets',
                          style: TextStyle(fontSize: 10,
                              color: _p.onSurface),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _p.accent.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: _p.accent.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.open_with,
                          color: _p.accent, size: 24),
                      const SizedBox(height: 4),
                      Text('Pan (2D)',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 12, color: _p.accent)),
                      const SizedBox(height: 4),
                      Text('Maps\nImage viewers\nDrawing canvas',
                          style: TextStyle(fontSize: 10,
                              color: _p.onSurface),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 4 — Scale & Rotation Lab
  // =======================================================================
  Widget _buildScaleRotationLab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Scale & Rotation Lab'),
          const SizedBox(height: 6),
          Text(
            'ScaleGestureRecognizer detects pinch-zoom and rotation gestures '
            'from two or more pointers. It reports scale, rotation, and '
            'focal point. The semantic handler provides no direct mapping '
            'for scale — it is purely pointer-based.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // Scale concept
          _scaleConceptCard(),
          const SizedBox(height: 14),
          // Scale detail breakdown
          _scaleDetailBreakdown(),
          const SizedBox(height: 14),
          // Rotation visual
          _rotationVisual(),
          const SizedBox(height: 14),
          // Transform preview
          _transformPreview(),
          const SizedBox(height: 14),
          // Scale vs Drag competition
          _scaleVsDrag(),
          const SizedBox(height: 20),
          _instructionBox(
            'Scale gestures only work with two or more pointers (fingers). '
            'They cannot be triggered via semantic actions. Applications '
            'that rely on pinch-zoom should provide alternative controls '
            '(zoom buttons, slider) for accessibility.',
          ),
        ],
      ),
    );
  }

  Widget _scaleConceptCard() {
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
          Text('Pinch-to-Zoom Concept', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Two fingers move apart to zoom in, together to zoom out.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          GestureDetector(
            onScaleUpdate: (d) =>
                _log('scale=${d.scale.toStringAsFixed(2)} '
                    'rotation=${d.rotation.toStringAsFixed(2)}'),
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _p.surface,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Zoom rings
                  for (var r = 1; r <= 3; r++)
                    Container(
                      width: r * 40.0 + 20,
                      height: r * 40.0 + 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _p.primary.withValues(
                              alpha: 0.1 + r * 0.08),
                          width: 1.5,
                        ),
                      ),
                    ),
                  // Center icon
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _p.primary,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.zoom_in,
                        color: Colors.white, size: 24),
                  ),
                  // Finger indicators
                  Positioned(
                    top: 20, left: 60,
                    child: _fingerIndicator('1'),
                  ),
                  Positioned(
                    bottom: 20, right: 60,
                    child: _fingerIndicator('2'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fingerIndicator(String label) {
    return Container(
      width: 28, height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _p.secondary,
        boxShadow: [BoxShadow(color: _p.secondary.withValues(alpha: 0.3),
            blurRadius: 6)],
      ),
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(color: Colors.white,
          fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _scaleDetailBreakdown() {
    final props = <(String, String, String)>[
      ('scale', 'double', 'Multiplier: 1.0 = original, 2.0 = 2x zoom'),
      ('horizontalScale', 'double', 'Scale in X axis only'),
      ('verticalScale', 'double', 'Scale in Y axis only'),
      ('rotation', 'double', 'Angle in radians between fingers'),
      ('focalPoint', 'Offset', 'Center point between pointers'),
      ('localFocalPoint', 'Offset', 'Focal point in widget coordinates'),
      ('pointerCount', 'int', 'Number of active pointers (fingers)'),
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
          Text('ScaleUpdateDetails Properties', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 10),
          for (var i = 0; i < props.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              color: i.isEven ? _p.surface : Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(props[i].$1, style: TextStyle(
                        fontFamily: 'monospace', fontSize: 11,
                        fontWeight: FontWeight.w600, color: _p.primary)),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(props[i].$2, style: TextStyle(
                        fontFamily: 'monospace', fontSize: 10,
                        color: _p.muted)),
                  ),
                  Expanded(
                    child: Text(props[i].$3, style: TextStyle(
                        fontSize: 11, color: _p.onSurface)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _rotationVisual() {
    final angles = [0.0, pi / 6, pi / 4, pi / 3, pi / 2];
    final labels = ['0°', '30°', '45°', '60°', '90°'];
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
          Text('Rotation Angles', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('The rotation property reports the angle in radians '
              'between the two pointers.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < angles.length; i++)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.rotate(
                      angle: angles[i],
                      child: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: _p.secondary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _p.secondary, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_upward,
                            color: _p.secondary, size: 18),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(labels[i], style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w600,
                        color: _p.secondary)),
                    Text('${angles[i].toStringAsFixed(2)} rad',
                        style: TextStyle(fontSize: 9,
                            fontFamily: 'monospace', color: _p.muted)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _transformPreview() {
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
          Text('Scale Transform Preview', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Showing how different scale factors affect a widget.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var s in [0.5, 0.75, 1.0, 1.25, 1.5])
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50, height: 50,
                      child: Center(
                        child: Transform.scale(
                          scale: s,
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: _p.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Icon(Icons.photo,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${s}x', style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold,
                        color: _p.primary)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scaleVsDrag() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _p.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Scale vs Pan: Arena Competition', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 8),
          Text('ScaleGestureRecognizer subsumes Pan. If you register '
              'both onScaleUpdate and onPanUpdate, Pan will never fire. '
              'Use ScaleGestureRecognizer alone when you need both zoom '
              'and pan — it reports both via focalPoint changes.',
              style: TextStyle(fontSize: 12, color: _p.onSurface)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFC62828).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cancel, color: Color(0xFFC62828), size: 20),
                      Text('Pan + Scale\n(conflicts!)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10,
                              color: Color(0xFFC62828))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle,
                          color: Color(0xFF2E7D32), size: 20),
                      Text('Scale only\n(handles both)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10,
                              color: Color(0xFF2E7D32))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 5 — Swipe & Dismissible Board
  // =======================================================================
  Widget _buildSwipeDismissible() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Swipe & Dismissible Board'),
          const SizedBox(height: 6),
          Text(
            'Dismissible wraps a child with horizontal or vertical '
            'drag recognizers that trigger dismissal. The semantic gesture '
            'handler maps the "dismiss" semantic action to this behavior '
            'for screen reader users.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          // Swipe direction cards
          _swipeDirectionCards(),
          const SizedBox(height: 14),
          // Dismissible list
          _dismissibleList(),
          const SizedBox(height: 14),
          // Velocity thresholds
          _velocityThresholds(),
          const SizedBox(height: 14),
          // Dismiss confirmation pattern
          _dismissConfirmation(),
          const SizedBox(height: 14),
          // Swipe action types
          _swipeActionTypes(),
          const SizedBox(height: 20),
          _instructionBox(
            'Dismissible uses DragGestureRecognizer internally and adds '
            'semantic dismiss action. Screen readers can trigger dismissal '
            'without swiping. Always implement confirmDismiss for '
            'destructive actions to prevent accidental deletions.',
          ),
        ],
      ),
    );
  }

  Widget _swipeDirectionCards() {
    final directions = <(String, IconData, Color, String)>[
      ('Left', Icons.arrow_back, _p.primary, 'DismissDirection.endToStart'),
      ('Right', Icons.arrow_forward, _p.secondary,
          'DismissDirection.startToEnd'),
      ('Up', Icons.arrow_upward, _p.accent, 'DismissDirection.up'),
      ('Down', Icons.arrow_downward, Color(0xFFE65100),
          'DismissDirection.down'),
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
          Text('Swipe Directions', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Dismissible supports four primary directions and two '
              'combined modes (horizontal, vertical).',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < directions.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 6 : 0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: directions[i].$3.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: directions[i].$3.withValues(alpha: 0.4)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(directions[i].$2,
                              color: directions[i].$3, size: 24),
                          const SizedBox(height: 3),
                          Text(directions[i].$1,
                              style: TextStyle(fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: directions[i].$3)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              for (final d in directions)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: d.$3.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(d.$4, style: TextStyle(fontSize: 9,
                      fontFamily: 'monospace', color: d.$3)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dismissibleList() {
    final items = <(String, IconData, Color)>[
      ('Email from Sarah', Icons.mail, _p.primary),
      ('Meeting reminder', Icons.event, _p.secondary),
      ('Task: Review PR', Icons.task_alt, Color(0xFF2E7D32)),
      ('Update available', Icons.system_update, Color(0xFFE65100)),
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
          Text('Dismissible List Items', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Each row is wrapped in Dismissible. Swipe to remove. '
              'Background shows delete/archive action.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          for (var i = 0; i < items.length; i++) ...[
            // Simulated dismissible (no actual state change in demo)
            SizedBox(
              height: 56,
              child: Stack(
                children: [
                  // Background
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFC62828),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delete,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 4),
                          Text('Delete',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  // Foreground
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: _p.muted.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Icon(items[i].$2, color: items[i].$3, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(items[i].$1,
                              style: TextStyle(fontSize: 13,
                                  color: _p.onSurface)),
                        ),
                        Icon(Icons.chevron_left,
                            color: _p.muted, size: 16),
                        Text('swipe',
                            style: TextStyle(fontSize: 9,
                                color: _p.muted)),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (i < items.length - 1) const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }

  Widget _velocityThresholds() {
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
          Text('Fling Velocity', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Dismissible checks both displacement threshold (40%) and '
              'fling velocity. A fast fling dismisses even with small offset.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var vLabel in ['Slow', 'Medium', 'Fast', 'Fling']) ...[
                if (vLabel != 'Slow') const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    children: [
                      _velocityBar(vLabel),
                      const SizedBox(height: 4),
                      Text(vLabel, style: TextStyle(fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _p.onSurface)),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _p.surface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'dismissThresholds: {DismissDirection.endToStart: 0.4}\n'
              'Fling minimum velocity: 700 px/sec',
              style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                  color: _p.muted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _velocityBar(String level) {
    final heights = {'Slow': 20.0, 'Medium': 40.0,
        'Fast': 60.0, 'Fling': 80.0};
    final colors = {'Slow': _p.muted, 'Medium': _p.secondary,
        'Fast': _p.primary, 'Fling': _p.accent};
    return Container(
      height: 80,
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: heights[level] ?? 20,
        decoration: BoxDecoration(
          color: (colors[level] ?? _p.muted).withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: colors[level] ?? _p.muted, width: 1),
        ),
      ),
    );
  }

  Widget _dismissConfirmation() {
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
          Text('Confirm Dismiss Pattern', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: Color(0xFFC62828))),
          const SizedBox(height: 4),
          Text('Always use confirmDismiss for destructive actions. '
              'Returns a Future<bool> to allow or cancel the dismissal.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFC62828).withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Color(0xFFC62828).withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber,
                    color: Color(0xFFC62828), size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Delete this item?',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 14, color: _p.onSurface)),
                      Text('This action cannot be undone.',
                          style: TextStyle(fontSize: 12,
                              color: _p.muted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _p.muted),
                ),
                child: Text('Cancel',
                    style: TextStyle(fontSize: 12, color: _p.onSurface)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFC62828),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Delete',
                    style: TextStyle(fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _swipeActionTypes() {
    final actions = <(String, String, IconData, Color)>[
      ('Delete', 'Remove item permanently', Icons.delete,
          Color(0xFFC62828)),
      ('Archive', 'Move to archive folder', Icons.archive,
          Color(0xFF1565C0)),
      ('Mark Read', 'Toggle read status', Icons.mark_email_read,
          Color(0xFF2E7D32)),
      ('Pin', 'Pin to top of list', Icons.push_pin,
          Color(0xFFE65100)),
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
          Text('Common Swipe Actions', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 10),
          Row(
            children: [
              for (var i = 0; i < actions.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 6 : 0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: actions[i].$4.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(actions[i].$3,
                              color: actions[i].$4, size: 22),
                          const SizedBox(height: 4),
                          Text(actions[i].$1,
                              style: TextStyle(fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: actions[i].$4)),
                          Text(actions[i].$2,
                              style: TextStyle(fontSize: 9,
                                  color: _p.onSurface),
                              textAlign: TextAlign.center),
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

  // =======================================================================
  // SCENARIO 6 — Verification & Guide
  // =======================================================================
  Widget _buildVerification() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification & Guide'),
          const SizedBox(height: 12),
          _gestureRecognizerTable(),
          const SizedBox(height: 16),
          _semanticMappingTable(),
          const SizedBox(height: 16),
          _verificationChecklist(),
          const SizedBox(height: 16),
          _faqSection(),
          const SizedBox(height: 16),
          _bestPractices(),
          const SizedBox(height: 16),
          _instructionBox(
            'RenderSemanticsGestureHandler is the rendering-layer bridge '
            'that connects semantic accessibility actions to concrete '
            'GestureRecognizer instances. It ensures that taps, long '
            'presses, scrolls, and dismissals all work correctly for '
            'users who rely on assistive technology.',
          ),
        ],
      ),
    );
  }

  Widget _gestureRecognizerTable() {
    final rows = <(String, String, String)>[
      ('TapGestureRecognizer', 'onTap, onTapDown, onTapUp, onTapCancel',
          'Single tap'),
      ('DoubleTapGestureRecognizer', 'onDoubleTap, onDoubleTapDown',
          'Rapid double touch'),
      ('LongPressGestureRecognizer',
          'onLongPress, onLongPressStart/End/Up',
          'Hold > 500ms'),
      ('HorizontalDragGestureRecognizer',
          'onHorizontalDragStart/Update/End',
          'Left-right movement'),
      ('VerticalDragGestureRecognizer',
          'onVerticalDragStart/Update/End',
          'Up-down movement'),
      ('PanGestureRecognizer', 'onPanStart/Update/End',
          'Free 2D movement'),
      ('ScaleGestureRecognizer', 'onScaleStart/Update/End',
          'Pinch zoom/rotate'),
      ('ForcePressGestureRecognizer', 'onForcePress...',
          '3D Touch / Force Touch'),
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
              color: _p.primary.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10)),
            ),
            child: Text('GestureRecognizer Reference',
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 14, color: _p.primary)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            color: _p.onSurface.withValues(alpha: 0.03),
            child: Row(
              children: [
                SizedBox(width: 180,
                    child: Text('Recognizer',
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 11, color: _p.muted))),
                Expanded(child: Text('Callbacks',
                    style: TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 11, color: _p.muted))),
                SizedBox(width: 100,
                    child: Text('Trigger',
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 11, color: _p.muted))),
              ],
            ),
          ),
          for (var i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 5),
              color: i.isEven ? Colors.transparent
                  : _p.onSurface.withValues(alpha: 0.02),
              child: Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(rows[i].$1, style: TextStyle(
                        fontSize: 10, fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: _p.primary)),
                  ),
                  Expanded(
                    child: Text(rows[i].$2, style: TextStyle(
                        fontSize: 10, color: _p.onSurface)),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(rows[i].$3, style: TextStyle(
                        fontSize: 10, color: _p.muted)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _semanticMappingTable() {
    final mappings = <(String, String)>[
      ('Semantic "activate"', 'TapGestureRecognizer.onTap'),
      ('Semantic "long press"', 'LongPressGestureRecognizer.onLongPress'),
      ('Semantic "scroll left"', 'HorizontalDragGestureRecognizer'),
      ('Semantic "scroll right"', 'HorizontalDragGestureRecognizer'),
      ('Semantic "scroll up"', 'VerticalDragGestureRecognizer'),
      ('Semantic "scroll down"', 'VerticalDragGestureRecognizer'),
      ('Semantic "dismiss"', 'Dismissible drag + confirm'),
      ('Semantic "increase"', 'Slider onIncrease'),
      ('Semantic "decrease"', 'Slider onDecrease'),
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
          Text('Semantic → Recognizer Mapping', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 10),
          for (var i = 0; i < mappings.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Container(
                    width: 160,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: _p.secondary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(mappings[i].$1, style: TextStyle(
                        fontSize: 10, color: _p.secondary,
                        fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_forward,
                        size: 14, color: _p.muted),
                  ),
                  Expanded(
                    child: Text(mappings[i].$2, style: TextStyle(
                        fontSize: 10, fontFamily: 'monospace',
                        color: _p.primary)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _verificationChecklist() {
    final checks = <String>[
      'GestureDetector onTap creates semantic activate action',
      'GestureDetector onLongPress creates semantic long-press action',
      'Horizontal drag enables semantic scroll left/right',
      'Vertical drag enables semantic scroll up/down',
      'Dismissible registers semantic dismiss action',
      'InkWell provides same semantic actions as GestureDetector',
      'Multiple recognizers coexist via gesture arena',
      'Scale gesture has no semantic equivalent (needs alt UI)',
      'DoubleTap creates its own recognizer with delay',
      'Long press lifecycle: down → confirm → move → up → end',
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
                  Icon(Icons.check_circle,
                      color: Color(0xFF2E7D32), size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(c, style: TextStyle(
                      fontSize: 12, color: _p.onSurface))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _faqSection() {
    final faqs = <(String, String)>[
      ('What is RenderSemanticsGestureHandler?',
       'It is a render object that translates semantic accessibility '
       'actions (like "activate" and "long press") into corresponding '
       'GestureRecognizer callbacks. Created automatically when you '
       'use GestureDetector or similar widgets.'),
      ('Can scale gestures be triggered by screen readers?',
       'No. Scale requires two pointers and has no semantic action '
       'equivalent. Provide alternative UI controls (zoom buttons, '
       'slider) for accessibility.'),
      ('What happens when tap and double-tap compete?',
       'The gesture arena holds the tap for ~300ms to see if a second '
       'tap arrives. If it does, DoubleTapGestureRecognizer wins. If '
       'not, TapGestureRecognizer fires with a delay.'),
      ('How does Dismissible work with assistive tech?',
       'It registers a semantic "dismiss" action. Screen reader users '
       'can trigger dismissal through the actions menu without needing '
       'to physically swipe.'),
      ('When should I use Pan vs separate H/V drag?',
       'Use horizontal or vertical drag when movement is constrained '
       'to one axis (slider, scroll). Use pan for free 2D movement '
       '(image viewer, canvas, map). Never combine pan with individual '
       'drag recognizers on the same widget.'),
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
      'Always provide semantic labels on gesture-detecting widgets',
      'Use confirmDismiss for destructive Dismissible actions',
      'Offer alternative UI for scale/rotate (zoom buttons, slider)',
      'Prefer InkWell over raw GestureDetector for Material apps',
      'Avoid combining pan with horizontal/vertical drag recognizers',
      'Test gesture interactions with TalkBack and VoiceOver',
      'Use HitTestBehavior.opaque for gesture areas without children',
      'Set excludeFromSemantics: true on decorative gesture detectors',
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _p.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.primary.withValues(alpha: 0.15)),
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
          Text('RenderSemanticsGestureHandler',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace',
                  color: _p.muted)),
        ],
      ),
    );
  }
}

// =========================================================================
// Custom painter — grid lines for pan canvas
// =========================================================================
class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;
    const step = 20.0;
    for (var x = 0.0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
