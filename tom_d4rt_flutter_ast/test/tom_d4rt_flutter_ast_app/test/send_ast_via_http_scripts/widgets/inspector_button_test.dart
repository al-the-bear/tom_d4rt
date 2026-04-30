// ignore_for_file: avoid_print
// D4rt deep demo: InspectorButton — a compact icon button used in the Flutter
// DevTools widget inspector overlay. It provides quick debugging actions like
// selecting widgets, toggling paint baselines, displaying repaint rainbows,
// and enabling slow animations.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Amber / Honey palette ───
  const Color amber = Color(0xFFF59E0B);
  const Color honey = Color(0xFFD97706);
  const Color deepAmber = Color(0xFF92400E);
  const Color paleGold = Color(0xFFFEF3C7);
  const Color butterscotch = Color(0xFFFBBF24);
  const Color cream = Color(0xFFFFFBEB);
  const Color caramel = Color(0xFFB45309);
  const Color sunflower = Color(0xFFEAB308);
  const Color wheat = Color(0xFFFDE68A);
  const Color saffron = Color(0xFFCA8A04);

  print('===== INSPECTOR BUTTON DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepAmber, caramel],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepAmber.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: honey,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: butterscotch, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wheat),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepAmber.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wheat),
        boxShadow: [
          BoxShadow(
            color: amber.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleGold,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepAmber)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepAmber)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: caramel)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepAmber.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepAmber),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: deepAmber)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: wheat.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inspectorButtonMock(IconData icon, String label, bool active, Color activeColor) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: active ? activeColor.withValues(alpha: 0.15) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: active ? activeColor : wheat,
                width: active ? 2 : 1,
              ),
            ),
            child: Icon(icon,
                size: 20,
                color: active ? activeColor : saffron.withValues(alpha: 0.5)),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: active ? FontWeight.w700 : FontWeight.normal,
                  color: active ? activeColor : saffron),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget stateRow(String state, String description, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(state,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color)),
          ),
          Expanded(
            child: Text(description,
                style: TextStyle(fontSize: 11, color: deepAmber)),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'InspectorButton is a small icon button used in the Flutter '
          'widget inspector overlay toolbar. It represents a single '
          'debugging action that the developer can toggle on or off '
          'while inspecting the widget tree in a running application.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'StatelessWidget'),
              dataRow('Package', 'flutter/widgets (widgetInspector)'),
              dataRow('Purpose', 'Toolbar button for inspector actions'),
              dataRow('Appearance', 'Small icon with active/inactive state'),
              dataRow('Used by', 'WidgetInspector overlay toolbar'),
            ],
          )),
      infoCard(
          'Where You See It',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Debug mode', 'Inspector overlay bottom bar'),
              dataRow('DevTools', 'Widget inspector panel'),
              dataRow('Select mode', 'Tap widgets to inspect'),
              dataRow('Paint toggles', 'Baselines, repaint rainbows'),
            ],
          )),
    ],
  );

  // ─── Section 2: Visual Anatomy ───
  print('[Section 2] Visual Anatomy');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Visual Anatomy'),
      noteBox(
          'An InspectorButton is composed of a GestureDetector wrapping '
          'a Container with an Icon. The active state changes the '
          'background color to indicate the toggle is on.'),
      infoCard(
          'Widget Tree',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Root', 'GestureDetector (onTap handler)'),
              dataRow('├─ Container', 'Background + padding + decoration'),
              dataRow('│  ├─ BoxDecoration', 'Color based on active state'),
              dataRow('│  └─ Icon', 'The action icon'),
              dataRow('Touch target', '~40x40 logical pixels'),
            ],
          )),
      infoCard(
          'Button Mockups',
          Wrap(
            children: [
              inspectorButtonMock(Icons.touch_app, 'Select', true, amber),
              inspectorButtonMock(Icons.border_all, 'Baselines', false, amber),
              inspectorButtonMock(Icons.gradient, 'Repaint', false, amber),
              inspectorButtonMock(Icons.slow_motion_video, 'Slow', false, amber),
              inspectorButtonMock(Icons.zoom_in, 'Zoom', true, amber),
            ],
          )),
    ],
  );

  // ─── Section 3: Constructor Parameters ───
  print('[Section 3] Constructor Parameters');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Constructor Parameters'),
      noteBox(
          'InspectorButton takes an icon, the active/inactive state, '
          'a callback for tap, and a tooltip description.'),
      infoCard(
          'Parameters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('icon', 'IconData — the visual icon'),
              dataRow('onPressed', 'VoidCallback — tap action'),
              dataRow('isSelected', 'bool — active toggle state'),
              dataRow('tooltip', 'String — accessibility description'),
            ],
          )),
      infoCard(
          'Parameter Details',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('icon required', 'Always needed for visual'),
              dataRow('onPressed required', 'Must handle the action'),
              dataRow('isSelected default', 'false — inactive by default'),
              dataRow('tooltip optional', 'For long-press hint'),
            ],
          )),
    ],
  );

  // ─── Section 4: Active vs Inactive State ───
  print('[Section 4] Active vs Inactive');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Active vs Inactive State'),
      noteBox(
          'The button\'s visual state indicates whether the inspector '
          'feature is currently enabled or disabled.'),
      infoCard(
          'State Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              stateRow('Active', 'Colored background, bold icon', amber),
              stateRow('Inactive', 'Transparent bg, muted icon', saffron),
              stateRow('Pressed', 'Brief highlight on tap', honey),
              stateRow('Disabled', 'Greyed out, no tap response', const Color(0xFF9CA3AF)),
            ],
          )),
      infoCard(
          'Visual Differences',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  inspectorButtonMock(Icons.touch_app, 'Active', true, amber),
                  const SizedBox(width: 16),
                  inspectorButtonMock(Icons.touch_app, 'Inactive', false, amber),
                ],
              ),
              const SizedBox(height: 8),
              dataRow('Background active', 'Semi-transparent accent color'),
              dataRow('Background inactive', 'Transparent'),
              dataRow('Icon active', 'Full opacity, accent color'),
              dataRow('Icon inactive', 'Reduced opacity'),
            ],
          )),
    ],
  );

  // ─── Section 5: Inspector Actions ───
  print('[Section 5] Inspector Actions');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Inspector Actions'),
      noteBox(
          'Each InspectorButton in the toolbar corresponds to a specific '
          'debugging action. These actions help visualize layout, '
          'performance, and widget boundaries.'),
      infoCard(
          'Standard Inspector Buttons',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Select Widget', 'Tap a widget to inspect its tree'),
              dataRow('Paint Baselines', 'Show text baseline alignment'),
              dataRow('Repaint Rainbow', 'Flash colors on repaint'),
              dataRow('Slow Animations', 'Reduce animation speed 5x'),
              dataRow('Debug Paint', 'Show layout borders and padding'),
            ],
          )),
      infoCard(
          'Action Categories',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Selection', 'Select Widget mode'),
              dataRow('Layout debug', 'Baselines, Debug Paint'),
              dataRow('Performance', 'Repaint Rainbow, Slow Animations'),
              dataRow('Navigation', 'Back to previous selection'),
            ],
          )),
    ],
  );

  // ─── Section 6: GestureDetector Integration ───
  print('[Section 6] GestureDetector Integration');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'GestureDetector Integration'),
      noteBox(
          'InspectorButton uses GestureDetector for tap handling rather '
          'than InkWell or TextButton, because it sits in the inspector '
          'overlay which has its own rendering layer.'),
      infoCard(
          'Why GestureDetector',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Inspector overlay', 'Not in the normal widget tree'),
              dataRow('No Material ancestor', 'InkWell needs Material'),
              dataRow('Simple tap', 'No ripple effect needed'),
              dataRow('Lightweight', 'Minimal widget overhead'),
            ],
          )),
      infoCard(
          'Tap Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('onTap', 'Calls onPressed callback'),
              dataRow('Hit test', 'Contained within button bounds'),
              dataRow('Feedback', 'Visual state change only'),
              dataRow('Long press', 'Shows tooltip if provided'),
            ],
          )),
    ],
  );

  // ─── Section 7: Toolbar Layout ───
  print('[Section 7] Toolbar Layout');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Toolbar Layout'),
      noteBox(
          'Multiple InspectorButtons are arranged horizontally in a '
          'Row to form the inspector toolbar at the bottom of the '
          'debug overlay.'),
      infoCard(
          'Toolbar Mockup',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: deepAmber.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: wheat),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    inspectorButtonMock(Icons.touch_app, 'Select', true, amber),
                    inspectorButtonMock(Icons.border_all, 'Baselines', false, amber),
                    inspectorButtonMock(Icons.gradient, 'Repaint', false, amber),
                    inspectorButtonMock(Icons.slow_motion_video, 'Slow', false, amber),
                    inspectorButtonMock(Icons.bug_report, 'Paint', false, amber),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              dataRow('Layout', 'Row with spaceEvenly'),
              dataRow('Spacing', 'Even distribution across width'),
              dataRow('Position', 'Bottom of inspector overlay'),
            ],
          )),
    ],
  );

  // ─── Section 8: Accessibility ───
  print('[Section 8] Accessibility');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Accessibility'),
      noteBox(
          'Inspector tools are developer-only UI, but good accessibility '
          'practices still apply for screen readers and keyboard nav.'),
      infoCard(
          'Accessibility Features',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Semantics label', 'From tooltip parameter'),
              dataRow('Tap target size', '≥40x40 for easy tap'),
              dataRow('State indication', 'Semantic toggle state'),
              dataRow('Contrast', 'Active state clearly distinct'),
            ],
          )),
      infoCard(
          'Tooltip Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Long press', 'Shows tooltip text'),
              dataRow('Hover (desktop)', 'Shows tooltip after delay'),
              dataRow('Screen reader', 'Announces tooltip as label'),
              dataRow('Empty tooltip', 'No announcement made'),
            ],
          )),
    ],
  );

  // ─── Section 9: Inspector Overlay Architecture ───
  print('[Section 9] Overlay Architecture');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Inspector Overlay Architecture'),
      noteBox(
          'The inspector overlay is a special layer above the app\'s '
          'widget tree. InspectorButtons live in this overlay, not in '
          'the app\'s normal rendering pipeline.'),
      infoCard(
          'Overlay Layers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Layer 1 (bottom)', 'App widget tree'),
              dataRow('Layer 2', 'Selection highlight overlay'),
              dataRow('Layer 3', 'Inspector info panel'),
              dataRow('Layer 4 (top)', 'Inspector toolbar (buttons)'),
            ],
          )),
      infoCard(
          'Overlay Entry',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'OverlayEntry or custom CompositedTransformFollower'),
              dataRow('Positioned', 'Bottom of screen, full width'),
              dataRow('Z-order', 'Above all app content'),
              dataRow('Input', 'Captures taps before app widgets'),
            ],
          )),
    ],
  );

  // ─── Section 10: Button Variants ───
  print('[Section 10] Button Variants');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Button Variants'),
      noteBox(
          'While InspectorButton is the base, different inspector tools '
          'may present slight variations in icon, tooltip, and behavior.'),
      infoCard(
          'Variant Examples',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Toggle button', 'Select mode, debug paint'),
              dataRow('One-shot button', 'Screenshot, navigate back'),
              dataRow('Group toggle', 'Only one active in group'),
              dataRow('Compound button', 'Button with dropdown'),
            ],
          )),
      infoCard(
          'Icon Selection',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  inspectorButtonMock(Icons.touch_app, 'Select', true, amber),
                  inspectorButtonMock(Icons.border_all, 'Baselines', true, honey),
                  inspectorButtonMock(Icons.gradient, 'Repaint', true, caramel),
                  inspectorButtonMock(Icons.slow_motion_video, 'Slow', true, saffron),
                  inspectorButtonMock(Icons.bug_report, 'Debug', true, deepAmber),
                  inspectorButtonMock(Icons.zoom_in, 'Zoom', true, butterscotch),
                ],
              ),
            ],
          )),
    ],
  );

  // ─── Section 11: Interaction Patterns ───
  print('[Section 11] Interaction Patterns');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Interaction Patterns'),
      noteBox(
          'Different interaction patterns are used depending on how '
          'the inspector button connects to the debugging feature.'),
      infoCard(
          'Toggle Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Tap once', 'Enable feature'),
              dataRow('Tap again', 'Disable feature'),
              dataRow('State', 'Persists until toggled or overlay closes'),
              dataRow('Example', 'Select Widget mode'),
            ],
          )),
      infoCard(
          'Radio Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Tap one', 'Activates, deactivates others'),
              dataRow('Mutual exclusion', 'Only one active'),
              dataRow('State', 'Always one selected'),
              dataRow('Example', 'Inspection mode vs layout mode'),
            ],
          )),
      infoCard(
          'Action Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Tap', 'Execute once'),
              dataRow('No toggle', 'Button returns to inactive'),
              dataRow('Feedback', 'Brief animation or confirmation'),
              dataRow('Example', 'Take screenshot, go back'),
            ],
          )),
    ],
  );

  // ─── Section 12: Styling ───
  print('[Section 12] Styling');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Styling'),
      noteBox(
          'InspectorButton uses minimal styling since it\'s a debugging '
          'tool, not a user-facing widget. The colors come from the '
          'inspector theme constants.'),
      infoCard(
          'Style Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Background active', 'Theme accent with low opacity'),
              dataRow('Background inactive', 'Transparent'),
              dataRow('Icon color active', 'Theme accent color'),
              dataRow('Icon color inactive', 'Muted grey'),
              dataRow('Border', 'None (clean look)'),
              dataRow('Padding', 'Symmetric ~8px'),
            ],
          )),
      infoCard(
          'Inspector Theme Colors',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Selection blue', '#42A5F5 — selected widget'),
              dataRow('Active green', '#66BB6A — enabled features'),
              dataRow('Background', '#333333 — toolbar background'),
              dataRow('Icon default', '#FFFFFF — standard icon color'),
            ],
          )),
    ],
  );

  // ─── Section 13: DevTools Connection ───
  print('[Section 13] DevTools Connection');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'DevTools Connection'),
      noteBox(
          'InspectorButton actions communicate with the Dart DevTools '
          'service extension protocol to toggle debug flags.'),
      infoCard(
          'Service Extension Protocol',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('debugPaintBaselinesEnabled', 'Paint baselines toggle'),
              dataRow('debugRepaintRainbowEnabled', 'Repaint rainbow toggle'),
              dataRow('timeDilation', 'Slow animations (5.0 or 1.0)'),
              dataRow('debugPaintSizeEnabled', 'Debug paint toggle'),
            ],
          )),
      infoCard(
          'Communication Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Button tapped', 'onPressed callback fires'),
              dataRow('2. Toggle state', 'Flip bool / set timeDilation'),
              dataRow('3. Service ext call', 'Register for DevTools query'),
              dataRow('4. Repaint', 'UI updates with debug visualization'),
            ],
          )),
    ],
  );

  // ─── Section 14: Custom Inspector Buttons ───
  print('[Section 14] Custom Inspector Buttons');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Custom Inspector Buttons'),
      noteBox(
          'While InspectorButton is internal to the framework, understanding '
          'its pattern helps when building custom debugging overlays.'),
      infoCard(
          'Building Custom Debug Buttons',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Define action', 'What debug flag to toggle'),
              dataRow('2. Choose icon', 'Recognizable symbol'),
              dataRow('3. Track state', 'bool active/inactive'),
              dataRow('4. Overlay entry', 'Position in debug toolbar'),
              dataRow('5. Service ext', 'Register with DevTools'),
            ],
          )),
      infoCard(
          'Custom Examples',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Network logger', 'Toggle request/response logging'),
              dataRow('State viewer', 'Show state tree overlay'),
              dataRow('Performance', 'Toggle performance overlay'),
              dataRow('Accessibility', 'Show semantics overlay'),
            ],
          )),
    ],
  );

  // ─── Section 15: Limitations ───
  print('[Section 15] Limitations');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Limitations'),
      noteBox(
          'InspectorButton is an internal widget not intended for '
          'direct use in application code. It has specific limitations.'),
      infoCard(
          'Known Limitations',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Debug only', 'Not available in release builds'),
              dataRow('Internal API', 'Not exported for app use'),
              dataRow('No customization', 'Fixed size and style'),
              dataRow('Platform', 'Same appearance on all platforms'),
              dataRow('Animation', 'No built-in press animation'),
            ],
          )),
      infoCard(
          'Alternatives for Apps',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('IconButton', 'Material icon button'),
              dataRow('InkWell + Icon', 'Custom tap feedback'),
              dataRow('CupertinoButton', 'iOS-style button'),
              dataRow('GestureDetector', 'Same approach, your styling'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the InspectorButton deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Amber', amber),
              colorSwatch('Honey', honey),
              colorSwatch('Deep Amber', deepAmber),
              colorSwatch('Pale Gold', paleGold),
              colorSwatch('Butterscotch', butterscotch),
              colorSwatch('Cream', cream),
              colorSwatch('Caramel', caramel),
              colorSwatch('Sunflower', sunflower),
              colorSwatch('Wheat', wheat),
              colorSwatch('Saffron', saffron),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, amber),
              progressBar('Visual Anatomy', 1.0, honey),
              progressBar('Constructor Parameters', 1.0, caramel),
              progressBar('Active vs Inactive', 1.0, saffron),
              progressBar('Inspector Actions', 1.0, amber),
              progressBar('GestureDetector', 1.0, honey),
              progressBar('Toolbar Layout', 1.0, caramel),
              progressBar('Accessibility', 1.0, saffron),
              progressBar('Overlay Architecture', 1.0, amber),
              progressBar('Button Variants', 1.0, honey),
              progressBar('Interaction Patterns', 1.0, caramel),
              progressBar('Styling', 1.0, saffron),
              progressBar('DevTools Connection', 1.0, amber),
              progressBar('Custom Inspector Buttons', 1.0, honey),
              progressBar('Limitations', 1.0, caramel),
              progressBar('Dashboard', 1.0, saffron),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Amber / Honey'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('InspectorButton', amber, Colors.white),
          tag('Widget Inspector', honey, Colors.white),
          tag('Debug Overlay', caramel, Colors.white),
          tag('DevTools', deepAmber, Colors.white),
          tag('Toggle State', saffron, Colors.white),
          tag('Toolbar', butterscotch, deepAmber),
        ],
      ),
    ],
  );

  print('===== END INSPECTOR BUTTON DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
