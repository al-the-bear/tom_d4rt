// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ToggleableStateMixin
// Demonstrates ToggleableStateMixin — the mixin that powers the
// animation and interaction logic behind Checkbox, Switch, and Radio.
// Covers animation controllers, curves, toggle states, the custom
// painter integration, and how Material widgets consume the mixin.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ToggleableStateMixin Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.toggle_on,
      'title': 'Toggle Animation Mixin',
      'body': 'ToggleableStateMixin is mixed into State classes to '
          'provide the animation controllers, curves, and interaction '
          'handling that make toggle widgets (Checkbox, Switch, Radio) '
          'feel alive. It encapsulates the entire toggle lifecycle.',
      'accent': Color(0xFF00897B),
    },
    {
      'icon': Icons.animation,
      'title': 'Four Animation Channels',
      'body': 'The mixin creates four coordinated animation controllers: '
          'position (main toggle), reaction (ink radial press), '
          'reactionHoverFade, and reactionFocusFade. Together they '
          'produce the layered visual response users expect.',
      'accent': Color(0xFFF9A825),
    },
    {
      'icon': Icons.touch_app,
      'title': 'Interaction Model',
      'body': 'Handles tap, hover, and focus semantics via Actions and '
          'FocusNode integration. The mixin registers an ActivateIntent '
          'action to trigger toggles from keyboard activation or '
          'accessibility services.',
      'accent': Color(0xFF00897B),
    },
    {
      'icon': Icons.palette,
      'title': 'CustomPainter Bridge',
      'body': 'buildToggleable() returns a widget that draws via a '
          'ToggleablePainter (custom painter). The mixin pumps '
          'animation values into the painter so subclasses only '
          'need to implement paint logic.',
      'accent': Color(0xFFF9A825),
    },
  ];

  print('  Cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: Animation Architecture
  // ============================================================
  print('=== Section 2: Animation Architecture ===');

  final animationChannels = <Map<String, dynamic>>[
    {
      'name': 'positionController',
      'type': 'AnimationController',
      'duration': '200 ms',
      'purpose': 'Drives the main toggle motion: unchecked ↔ checked. '
          'Value 0.0 = off, 1.0 = on. For tristate: 0.0 → 0.5 → 1.0.',
      'curve': 'Curves.easeIn / easeOut',
      'color': Color(0xFF00897B),
      'icon': Icons.swap_horiz,
    },
    {
      'name': 'reactionController',
      'type': 'AnimationController',
      'duration': '100 ms',
      'purpose': 'Drives the radial ink splash that appears on tap. '
          'Grows from center outward during press, fades on release.',
      'curve': 'Curves.fastOutSlowIn',
      'color': Color(0xFFF9A825),
      'icon': Icons.radio_button_unchecked,
    },
    {
      'name': 'reactionHoverFade',
      'type': 'AnimationController',
      'duration': '50 ms',
      'purpose': 'Controls the opacity ramp of the hover overlay. '
          'Separate from reaction so hover and press layers stack.',
      'curve': 'Curves.fastOutSlowIn',
      'color': Color(0xFF00897B),
      'icon': Icons.mouse,
    },
    {
      'name': 'reactionFocusFade',
      'type': 'AnimationController',
      'duration': '50 ms',
      'purpose': 'Controls the focus ring overlay opacity. Active '
          'when the widget has keyboard focus, blends with hover.',
      'curve': 'Curves.fastOutSlowIn',
      'color': Color(0xFFF9A825),
      'icon': Icons.center_focus_strong,
    },
  ];

  print('  Channels: ${animationChannels.length}');

  // ============================================================
  // SECTION 3: Curves & Timing
  // ============================================================
  print('=== Section 3: Curves & Timing ===');

  final timingData = <Map<String, dynamic>>[
    {
      'label': 'Toggle duration',
      'value': '200 ms',
      'detail': 'Position snaps between states with a quick ease-in '
          'forward and ease-out reverse, giving crisp yet smooth motion.',
      'bar': 0.4,
      'color': Color(0xFF00897B),
    },
    {
      'label': 'Reaction duration',
      'value': '100 ms',
      'detail': 'The ink radial is fast to create responsive feedback. '
          'Uses fastOutSlowIn for natural acceleration.',
      'bar': 0.2,
      'color': Color(0xFFF9A825),
    },
    {
      'label': 'Hover/Focus fade',
      'value': '50 ms',
      'detail': 'Near-instant opacity transition for hover and focus '
          'overlays. Fast enough to feel immediate.',
      'bar': 0.1,
      'color': Color(0xFF00897B),
    },
    {
      'label': 'Forward curve',
      'value': 'easeIn',
      'detail': 'Position starts slowly and accelerates into the '
          'target state — gives weight to the motion.',
      'bar': 0.5,
      'color': Color(0xFFF9A825),
    },
    {
      'label': 'Reverse curve',
      'value': 'easeOut',
      'detail': 'Position decelerates as it returns to off state, '
          'providing a soft landing after un-toggling.',
      'bar': 0.5,
      'color': Color(0xFF00897B),
    },
  ];

  print('  Timing entries: ${timingData.length}');

  // ============================================================
  // SECTION 4: Toggle States
  // ============================================================
  print('=== Section 4: Toggle States ===');

  final toggleStates = <Map<String, dynamic>>[
    {
      'state': 'false',
      'position': 0.0,
      'description': 'Unchecked / Off. The position controller is at '
          '0.0. The painter draws the inactive visual.',
      'icon': Icons.check_box_outline_blank,
      'color': Colors.grey[600]!,
    },
    {
      'state': 'true',
      'position': 1.0,
      'description': 'Checked / On. The position controller is at '
          '1.0. The painter draws the active visual with fill.',
      'icon': Icons.check_box,
      'color': Color(0xFF00897B),
    },
    {
      'state': 'null (tristate)',
      'position': 0.5,
      'description': 'Indeterminate. Only when tristate is true. '
          'Position settles at 0.5. The painter draws a dash.',
      'icon': Icons.indeterminate_check_box,
      'color': Color(0xFFF9A825),
    },
  ];

  print('  States: ${toggleStates.length}');

  // ============================================================
  // SECTION 5: Widget Implementations
  // ============================================================
  print('=== Section 5: Widget Implementations ===');

  final implementations = <Map<String, dynamic>>[
    {
      'widget': 'Checkbox',
      'painter': '_CheckboxPainter',
      'shape': 'Rounded rectangle with check / dash marks',
      'extra': 'Supports tristate, custom colors, shape override',
      'color': Color(0xFF00897B),
      'icon': Icons.check_box,
    },
    {
      'widget': 'Switch',
      'painter': '_SwitchPainter',
      'shape': 'Track with sliding thumb; thumb travels along position',
      'extra': 'Thumb image, track color, Material 3 icon on thumb',
      'color': Color(0xFFF9A825),
      'icon': Icons.toggle_on,
    },
    {
      'widget': 'Radio<T>',
      'painter': '_RadioPainter',
      'shape': 'Outer circle with inner dot that scales via position',
      'extra': 'groupValue comparison, toggleable for deselect',
      'color': Color(0xFF00897B),
      'icon': Icons.radio_button_checked,
    },
    {
      'widget': 'CupertinoSwitch',
      'painter': '—',
      'shape': 'iOS-style track and thumb via CustomPaint path',
      'extra': 'Uses same mixin but Cupertino paint style',
      'color': Color(0xFFF9A825),
      'icon': Icons.phone_iphone,
    },
    {
      'widget': 'CupertinoCheckbox',
      'painter': '—',
      'shape': 'iOS-style rounded checkbox with check mark',
      'extra': 'Cupertino colors, border, tristate support',
      'color': Color(0xFF00897B),
      'icon': Icons.check_circle,
    },
    {
      'widget': 'CupertinoRadio',
      'painter': '—',
      'shape': 'iOS-style circular radio with inner dot',
      'extra': 'Cupertino styling, same position animation',
      'color': Color(0xFFF9A825),
      'icon': Icons.circle_outlined,
    },
  ];

  print('  Implementations: ${implementations.length}');

  // ============================================================
  // SECTION 6: Custom Toggle Implementation
  // ============================================================
  print('=== Section 6: Custom Toggle ===');

  final customCode = '''class HeartToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  const HeartToggle({
    super.key,
    required this.value,
    this.onChanged,
  });
  @override
  State<HeartToggle> createState() =>
      _HeartToggleState();
}

class _HeartToggleState extends State<HeartToggle>
    with TickerProviderStateMixin,
         ToggleableStateMixin {
  @override
  bool get value => widget.value;

  @override
  bool get tristate => false;

  @override
  ValueChanged<bool?>? get onChanged =>
      widget.onChanged;

  @override
  Widget build(BuildContext context) {
    return buildToggleable(
      size: Size(40, 40),
      painter: _HeartPainter(
        position: position,
        reaction: reaction,
      ),
    );
  }
}''';

  final painterCode = '''class _HeartPainter extends ToggleablePainter {
  _HeartPainter({
    required Animation<double> position,
    required Animation<double> reaction,
  }) {
    this.position = position;
    this.reaction = reaction;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final t = position.value; // 0..1
    final color = Color.lerp(
      Colors.grey,
      Colors.red,
      t,
    )!;
    // Draw heart shape scaled by t
    final paint = Paint()..color = color;
    // ... custom path drawing
    canvas.drawPath(heartPath, paint);
  }
}''';

  print('  Custom code ready');

  // ============================================================
  // SECTION 7: Interaction Flow
  // ============================================================
  print('=== Section 7: Interaction Flow ===');

  final interactionSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'event': 'Pointer enters',
      'response': 'reactionHoverFade → forward()',
      'visual': 'Hover overlay fades in (50 ms)',
      'color': Color(0xFF00897B),
    },
    {
      'step': '2',
      'event': 'Pointer down',
      'response': 'reactionController → forward()',
      'visual': 'Ink radial grows from center (100 ms)',
      'color': Color(0xFFF9A825),
    },
    {
      'step': '3',
      'event': 'Pointer up (tap)',
      'response': 'onChanged(newValue) called',
      'visual': 'Value toggles; positionController animates',
      'color': Color(0xFF00897B),
    },
    {
      'step': '4',
      'event': 'setState with new value',
      'response': 'animateToValue() drives position',
      'visual': 'Toggle slides to new state (200 ms)',
      'color': Color(0xFFF9A825),
    },
    {
      'step': '5',
      'event': 'Focus gained',
      'response': 'reactionFocusFade → forward()',
      'visual': 'Focus ring overlay appears (50 ms)',
      'color': Color(0xFF00897B),
    },
    {
      'step': '6',
      'event': 'ActivateIntent (Space/Enter)',
      'response': 'Same as tap — onChanged fires',
      'visual': 'Toggle + ink reaction simultaneously',
      'color': Color(0xFFF9A825),
    },
  ];

  print('  Steps: ${interactionSteps.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Always Mix TickerProviderStateMixin',
      'detail': 'ToggleableStateMixin creates AnimationControllers '
          'that require a TickerProvider. Mix TickerProviderStateMixin '
          'on the same State class.',
      'icon': Icons.timer,
      'color': Color(0xFF00897B),
    },
    {
      'title': 'Override the Three Getters',
      'detail': 'value (bool?), tristate (bool), and onChanged '
          '(ValueChanged<bool?>?) must be overridden. These drive '
          'the mixin\'s animation target and interactivity.',
      'icon': Icons.input,
      'color': Color(0xFFF9A825),
    },
    {
      'title': 'Use buildToggleable()',
      'detail': 'Call buildToggleable(painter:, size:) from your '
          'build() method. It assembles the gesture detector, '
          'semantics node, and CustomPaint wiring for you.',
      'icon': Icons.build,
      'color': Color(0xFF00897B),
    },
    {
      'title': 'Extend ToggleablePainter',
      'detail': 'Your painter receives position and reaction '
          'Animations. Use their .value in paint() to interpolate '
          'color, shape, and size. The mixin repumps values '
          'on tick.',
      'icon': Icons.brush,
      'color': Color(0xFFF9A825),
    },
    {
      'title': 'Handle Tristate Correctly',
      'detail': 'When tristate is true, value cycles: '
          'false → true → null → false. Position animates through '
          '0.0, 1.0, 0.5. Your painter must render the null state '
          '(typically a dash).',
      'icon': Icons.horizontal_rule,
      'color': Color(0xFF00897B),
    },
  ];

  print('  Practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00897B), Color(0xFFF9A825)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.toggle_on, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text('ToggleableStateMixin',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'The animation and interaction engine behind Checkbox, '
                'Switch, and Radio — four coordinated controllers, '
                'gesture handling, and a painter bridge in one mixin.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.lightbulb_outline, Color(0xFF00897B)),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Animation Architecture ----
        _sectionHeader('2. Animation Architecture', Icons.layers, Color(0xFFF9A825)),
        SizedBox(height: 10),
        ...animationChannels.map((ch) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (ch['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: (ch['color'] as Color).withValues(alpha: 0.3)),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(ch['icon'] as IconData, color: ch['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ch['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 13,
                                  color: ch['color'] as Color)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(ch['duration'] as String,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(ch['purpose'] as String, style: TextStyle(fontSize: 12)),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.timeline, size: 12, color: Colors.grey[500]),
                        SizedBox(width: 4),
                        Text('Curve: ${ch['curve']}',
                            style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey[600])),
                      ],
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Curves & Timing ----
        _sectionHeader('3. Curves & Timing', Icons.speed, Color(0xFF00897B)),
        SizedBox(height: 10),
        ...timingData.map((t) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(t['label'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: t['color'] as Color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(t['value'] as String,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    // Timing bar visualization
                    Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: t['bar'] as double,
                        child: Container(
                          decoration: BoxDecoration(
                            color: t['color'] as Color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(t['detail'] as String,
                        style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Toggle States ----
        _sectionHeader('4. Toggle States', Icons.swap_vert, Color(0xFFF9A825)),
        SizedBox(height: 10),
        ...toggleStates.map((ts) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (ts['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: ts['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (ts['color'] as Color).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(ts['icon'] as IconData, color: ts['color'] as Color, size: 28),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('value: ${ts['state']}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 13)),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text('position = ${ts['position']}',
                                    style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(ts['description'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Widget Implementations ----
        _sectionHeader('5. Widget Implementations', Icons.widgets, Color(0xFF00897B)),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Color(0xFF00897B),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(width: 28),
                    SizedBox(width: 8),
                    Expanded(flex: 2, child: Text('Widget',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Shape',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Extra',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(implementations.length, (i) {
                final im = implementations[i];
                return Container(
                  color: i.isEven ? Colors.white : Color(0xFFF1F8E9),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      Icon(im['icon'] as IconData, color: im['color'] as Color, size: 20),
                      SizedBox(width: 8),
                      Expanded(flex: 2, child: Text(im['widget'] as String,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                      Expanded(flex: 3, child: Text(im['shape'] as String,
                          style: TextStyle(fontSize: 10))),
                      Expanded(flex: 3, child: Text(im['extra'] as String,
                          style: TextStyle(fontSize: 10))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 6: Custom Toggle Implementation ----
        _sectionHeader('6. Custom Toggle', Icons.code, Color(0xFFF9A825)),
        SizedBox(height: 10),
        Text('Creating a custom toggleable widget using the mixin:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(customCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFB2FF59))),
        ),
        SizedBox(height: 12),
        Text('The ToggleablePainter that draws from animation values:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(painterCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFFFD54F))),
        ),

        SizedBox(height: 20),

        // ---- Section 7: Interaction Flow ----
        _sectionHeader('7. Interaction Flow', Icons.touch_app, Color(0xFF00897B)),
        SizedBox(height: 10),
        ...List.generate(interactionSteps.length, (i) {
          final s = interactionSteps[i];
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: (s['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(left: BorderSide(color: s['color'] as Color, width: 4)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: s['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(s['step'] as String,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s['event'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          SizedBox(height: 2),
                          Text(s['response'] as String,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: s['color'] as Color)),
                          Text(s['visual'] as String,
                              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (i < interactionSteps.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Icon(Icons.arrow_downward, size: 14, color: Colors.grey[400]),
                ),
            ],
          );
        }),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Color(0xFFF9A825)),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_box, color: Color(0xFF00897B), size: 24),
                  SizedBox(width: 8),
                  Icon(Icons.toggle_on, color: Color(0xFFF9A825), size: 24),
                  SizedBox(width: 8),
                  Icon(Icons.radio_button_checked, color: Color(0xFF00897B), size: 24),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'ToggleableStateMixin: four animation controllers, one '
                'interaction model — the shared engine that makes '
                'every toggle widget in Flutter feel consistent.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
