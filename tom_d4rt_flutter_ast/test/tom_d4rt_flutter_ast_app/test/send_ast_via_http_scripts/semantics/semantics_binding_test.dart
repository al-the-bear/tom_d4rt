// ignore_for_file: avoid_print
// D4rt deep demo: SemanticsBinding
// Explores the binding that bridges the Flutter framework's semantics
// layer with the engine and platform accessibility services.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Glacier / Frost palette ───
  const Color glacier = Color(0xFF6BA3BE);
  const Color frost = Color(0xFFA8D5E2);
  const Color iceSheet = Color(0xFFECF6FA);
  const Color arcticDeep = Color(0xFF2C5F7A);
  const Color permafrost = Color(0xFF4A8FA8);
  const Color snowDrift = Color(0xFFD0E8F0);
  const Color bergBlue = Color(0xFF3D7C99);
  const Color icicle = Color(0xFF7CBDD1);
  const Color crevasse = Color(0xFF1E4D63);
  const Color rime = Color(0xFFBCD4DD);

  // ─── Helper builders ───
  Widget sbHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [crevasse, glacier],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: glacier.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 3),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget sbCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: iceSheet,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: frost.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget sbBullet(String text, {Color dotColor = arcticDeep}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 7,
            height: 7,
            margin: const EdgeInsets.only(top: 5, right: 8),
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 12.5, color: crevasse)),
          ),
        ],
      ),
    );
  }

  Widget sbDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              glacier.withValues(alpha: 0.0),
              glacier,
              glacier.withValues(alpha: 0.0),
            ],
          ),
        ),
      ),
    );
  }
  Widget sbArchBox(String label, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }


  // ─────────────────────────────────────────────
  // Section 1: What is SemanticsBinding?
  // ─────────────────────────────────────────────
  print('sb01 SemanticsBinding overview');
  Widget sb01Overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb01 — What is SemanticsBinding?',
            'The binding that manages the semantics bridge to the platform'),
        const SizedBox(height: 10),
        sbCard([
          const Text(
            'SemanticsBinding is a mixin on BindingBase that manages how '
            'Flutter\'s semantics tree communicates with the platform\'s '
            'accessibility services. It handles:',
            style: TextStyle(fontSize: 13, color: crevasse),
          ),
          const SizedBox(height: 10),
          sbBullet('Semantics tree lifecycle and updates'),
          sbBullet(
              'Accessibility features detection (boldText, highContrast, etc.)'),
          sbBullet('SemanticsHandle management (ensureSemantics)'),
          sbBullet('Platform accessibility event dispatch'),
          sbBullet('Animation disabling for accessibility'),
        ]),
        const SizedBox(height: 8),
        // Architecture diagram
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: snowDrift.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: glacier.withValues(alpha: 0.4)),
          ),
          child: Column(
            children: [
              sbArchBox('Platform A11Y Service', crevasse, Icons.phone_android),
              const SizedBox(height: 4),
              const Icon(Icons.swap_vert, size: 20, color: arcticDeep),
              const SizedBox(height: 4),
              sbArchBox('Flutter Engine', bergBlue, Icons.engineering),
              const SizedBox(height: 4),
              const Icon(Icons.swap_vert, size: 20, color: arcticDeep),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: glacier.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: glacier, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.link, size: 20, color: glacier),
                    const SizedBox(width: 8),
                    const Text('SemanticsBinding',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: glacier)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Icon(Icons.swap_vert, size: 20, color: arcticDeep),
              const SizedBox(height: 4),
              sbArchBox('Semantics Tree', permafrost, Icons.account_tree),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 2: Binding hierarchy
  // ─────────────────────────────────────────────
  print('sb02 Binding hierarchy');
  Widget sb02Hierarchy() {
    final bindings = [
      {'name': 'BindingBase', 'desc': 'Root of all binding mixins', 'color': crevasse},
      {'name': 'GestureBinding', 'desc': 'Touch input & gestures', 'color': arcticDeep},
      {'name': 'SchedulerBinding', 'desc': 'Frame scheduling', 'color': bergBlue},
      {'name': 'ServicesBinding', 'desc': 'Platform channels', 'color': permafrost},
      {'name': 'PaintingBinding', 'desc': 'Image cache & painting', 'color': glacier},
      {'name': 'SemanticsBinding', 'desc': 'Accessibility semantics', 'color': icicle},
      {'name': 'RendererBinding', 'desc': 'Render tree & pipeline', 'color': frost},
      {'name': 'WidgetsBinding', 'desc': 'Widget tree lifecycle', 'color': rime},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb02 — Binding Hierarchy',
            'Where SemanticsBinding sits in the Flutter binding chain'),
        const SizedBox(height: 10),
        sbCard([
          ...bindings.asMap().entries.map((entry) {
            final b = entry.value;
            final isSemantics = (b['name'] as String) == 'SemanticsBinding';
            return Container(
              margin: EdgeInsets.only(left: entry.key * 10.0, top: 3, bottom: 3),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                color: isSemantics
                    ? glacier.withValues(alpha: 0.25)
                    : (b['color'] as Color).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSemantics
                      ? glacier
                      : (b['color'] as Color).withValues(alpha: 0.3),
                  width: isSemantics ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSemantics)
                    const Icon(Icons.star, size: 14, color: glacier)
                  else
                    Icon(Icons.circle, size: 8, color: b['color'] as Color),
                  const SizedBox(width: 8),
                  Text(b['name'] as String,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              isSemantics ? FontWeight.bold : FontWeight.w500,
                          fontFamily: 'monospace',
                          color: b['color'] as Color)),
                  const SizedBox(width: 8),
                  Text(b['desc'] as String,
                      style: TextStyle(
                          fontSize: 10.5,
                          color:
                              (b['color'] as Color).withValues(alpha: 0.7))),
                ],
              ),
            );
          }),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 3: AccessibilityFeatures
  // ─────────────────────────────────────────────
  print('sb03 AccessibilityFeatures');
  Widget sb03Features() {
    final features = [
      {'name': 'boldText', 'icon': Icons.format_bold, 'desc': 'User prefers bold text', 'on': true},
      {'name': 'highContrast', 'icon': Icons.contrast, 'desc': 'High contrast mode', 'on': false},
      {'name': 'reduceMotion', 'icon': Icons.animation, 'desc': 'Minimize animations', 'on': false},
      {'name': 'disableAnimations', 'icon': Icons.stop_circle, 'desc': 'Disable all animations', 'on': false},
      {'name': 'invertColors', 'icon': Icons.invert_colors, 'desc': 'Colors are inverted', 'on': false},
      {'name': 'accessibleNavigation', 'icon': Icons.navigation, 'desc': 'Switch access / directional nav', 'on': false},
      {'name': 'reduceTransparency', 'icon': Icons.opacity, 'desc': 'Reduce transparency', 'on': false},
      {'name': 'onOffSwitchLabels', 'icon': Icons.toggle_on, 'desc': 'Show on/off labels on switches', 'on': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb03 — AccessibilityFeatures',
            'Platform accessibility settings exposed via SemanticsBinding'),
        const SizedBox(height: 10),
        sbCard([
          const Text(
            'SemanticsBinding.instance.accessibilityFeatures exposes '
            'the current platform accessibility settings. Apps should '
            'respond to these to be truly accessible:',
            style: TextStyle(fontSize: 12.5, color: crevasse),
          ),
          const SizedBox(height: 10),
          ...features.map((f) => Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (f['on'] as bool)
                      ? glacier.withValues(alpha: 0.15)
                      : permafrost.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: (f['on'] as bool)
                        ? glacier
                        : permafrost.withValues(alpha: 0.2),
                    width: (f['on'] as bool) ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(f['icon'] as IconData,
                        size: 20,
                        color: (f['on'] as bool)
                            ? glacier
                            : permafrost),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f['name'] as String,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  color: (f['on'] as bool)
                                      ? glacier
                                      : crevasse)),
                          Text(f['desc'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  color:
                                      crevasse.withValues(alpha: 0.7))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: (f['on'] as bool)
                            ? Colors.green
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        (f['on'] as bool) ? 'ON' : 'OFF',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 4: bold text visual
  // ─────────────────────────────────────────────
  print('sb04 Bold text accessibility feature');
  Widget sb04BoldText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb04 — Bold Text Feature',
            'How boldText affects rendering'),
        const SizedBox(height: 10),
        sbCard([
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: rime),
                  ),
                  child: Column(
                    children: [
                      const Text('Normal',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: crevasse)),
                      const SizedBox(height: 8),
                      const Text('Hello world',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: crevasse)),
                      const SizedBox(height: 4),
                      const Text('Button label',
                          style: TextStyle(fontSize: 12, color: crevasse)),
                      const SizedBox(height: 4),
                      Text('Caption text',
                          style: TextStyle(
                              fontSize: 10, color: crevasse.withValues(alpha: 0.6))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: glacier.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: glacier, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text('Bold Text ON',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: glacier)),
                      const SizedBox(height: 8),
                      const Text('Hello world',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: crevasse)),
                      const SizedBox(height: 4),
                      const Text('Button label',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: crevasse)),
                      const SizedBox(height: 4),
                      const Text('Caption text',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: crevasse)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          sbBullet(
              'When boldText is on, all text should render with increased weight'),
          sbBullet(
              'MediaQuery passes this to the widget tree'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 5: High contrast
  // ─────────────────────────────────────────────
  print('sb05 High contrast accessibility feature');
  Widget sb05HighContrast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb05 — High Contrast Mode',
            'How highContrast affects visual presentation'),
        const SizedBox(height: 10),
        sbCard([
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      const Text('Normal',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: crevasse)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: glacier.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Light button',
                            style: TextStyle(
                                fontSize: 12,
                                color: glacier.withValues(alpha: 0.7))),
                      ),
                      const SizedBox(height: 6),
                      Text('Subtle text',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text('High Contrast',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text('Bold button',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      const SizedBox(height: 6),
                      const Text('High visibility text',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          sbBullet(
              'High contrast mode increases color differentiation'),
          sbBullet(
              'Apps should provide a HighContrastTheme or adapt colors'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 6: Reduce motion
  // ─────────────────────────────────────────────
  print('sb06 Reduce motion');
  Widget sb06ReduceMotion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb06 — Reduce Motion',
            'Adapting animations for vestibular sensitivity'),
        const SizedBox(height: 10),
        sbCard([
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: rime),
                  ),
                  child: Column(
                    children: [
                      const Text('Normal',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: crevasse)),
                      const SizedBox(height: 6),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                            colors: [glacier, permafrost, bergBlue],
                          ),
                        ),
                        child: const Center(
                          child: Text('Animated slide + fade',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Icon(Icons.animation, size: 24, color: glacier),
                      const Text('Animations ON',
                          style: TextStyle(fontSize: 10, color: glacier)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: glacier.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: glacier, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text('Reduce Motion',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: glacier)),
                      const SizedBox(height: 6),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: glacier,
                        ),
                        child: const Center(
                          child: Text('Instant transition',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Icon(Icons.stop_circle_outlined,
                          size: 24, color: arcticDeep),
                      const Text('Animations OFF',
                          style: TextStyle(fontSize: 10, color: arcticDeep)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          sbBullet(
              'Users with vestibular disorders may enable reduce motion'),
          sbBullet(
              'Replace slide/bounce with fade or instant transitions'),
          sbBullet(
              'Check MediaQuery.disableAnimations or reduceMotion'),
        ]),
      ],
    );
  }
  Widget sbStepCard(int step, String title, String code, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$step',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: color)),
                Text(code,
                    style: const TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: crevasse)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ─────────────────────────────────────────────
  // Section 7: ensureSemantics() / SemanticsHandle
  // ─────────────────────────────────────────────
  print('sb07 ensureSemantics and SemanticsHandle');
  Widget sb07EnsureSemantics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb07 — ensureSemantics() & SemanticsHandle',
            'Keeping the semantics tree alive'),
        const SizedBox(height: 10),
        sbCard([
          const Text(
            'By default, Flutter only maintains the semantics tree when a '
            'screen reader or other accessibility service is active. '
            'ensureSemantics() creates a SemanticsHandle that forces '
            'the tree to stay alive:',
            style: TextStyle(fontSize: 12.5, color: crevasse),
          ),
          const SizedBox(height: 10),
          // Flow: call ensureSemantics → get handle → dispose
          sbStepCard(1, 'Request handle',
              'SemanticsBinding.instance.ensureSemantics()', glacier),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Center(
                child:
                    Icon(Icons.arrow_downward, size: 16, color: arcticDeep)),
          ),
          sbStepCard(2, 'Semantics tree is alive',
              'Tree generating & sending updates to engine', permafrost),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Center(
                child:
                    Icon(Icons.arrow_downward, size: 16, color: arcticDeep)),
          ),
          sbStepCard(3, 'Dispose handle',
              'handle.dispose() — tree shuts down if last handle', bergBlue),
          const SizedBox(height: 10),
          sbBullet(
              'Multiple handles can be active; tree shuts down only when all disposed'),
          sbBullet(
              'SemanticsDebugger internally calls ensureSemantics()'),
          sbBullet(
              'Useful for testing or custom accessibility tooling'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 8: Text scale factor
  // ─────────────────────────────────────────────
  print('sb08 Text scale factor');
  Widget sb08TextScale() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb08 — Text Scale Factor',
            'Platform text size preference relayed through the binding'),
        const SizedBox(height: 10),
        sbCard([
          const Text(
            'The platform\'s text scale setting flows through the binding '
            'to MediaQuery.textScaleFactor:',
            style: TextStyle(fontSize: 12.5, color: crevasse),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final scale in [
                {'factor': '1.0×', 'size': 13.0, 'label': 'Default'},
                {'factor': '1.3×', 'size': 17.0, 'label': 'Large'},
                {'factor': '1.6×', 'size': 21.0, 'label': 'Extra Large'},
              ])
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: glacier.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: glacier.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(scale['factor'] as String,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: glacier)),
                        const SizedBox(height: 4),
                        Text('Abc',
                            style: TextStyle(
                                fontSize: scale['size'] as double,
                                color: crevasse)),
                        const SizedBox(height: 4),
                        Text(scale['label'] as String,
                            style: const TextStyle(
                                fontSize: 10, color: arcticDeep)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          sbBullet(
              'Respect text scale — never clamp fontSize at a fixed value'),
          sbBullet(
              'Text overflow should be handled gracefully at all scales'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 9: Semantic events flow
  // ─────────────────────────────────────────────
  print('sb09 Semantic events pipeline');
  Widget sb09Events() {
    final events = [
      {'event': 'AnnounceSemanticsEvent', 'desc': 'Read text aloud via screen reader', 'icon': Icons.campaign},
      {'event': 'TooltipSemanticsEvent', 'desc': 'Tooltip opened / closed', 'icon': Icons.info_outline},
      {'event': 'LongPressSemanticsEvent', 'desc': 'Long press action occurred', 'icon': Icons.pan_tool},
      {'event': 'TapSemanticsEvent', 'desc': 'Tap action occurred', 'icon': Icons.touch_app},
      {'event': 'FocusSemanticsEvent', 'desc': 'Focus gained / lost', 'icon': Icons.center_focus_strong},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb09 — Semantic Events Pipeline',
            'Events dispatched through the binding to the engine'),
        const SizedBox(height: 10),
        sbCard([
          ...events.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: permafrost.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: permafrost.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Icon(e['icon'] as IconData, size: 20, color: bergBlue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e['event'] as String,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  color: crevasse)),
                          Text(e['desc'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: crevasse.withValues(alpha: 0.7))),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 6),
          sbBullet(
              'Events are dispatched via SemanticsEvent.dispatch()'),
          sbBullet(
              'The binding routes them to the platform via SystemChannels.accessibility'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 10: Invert colors
  // ─────────────────────────────────────────────
  print('sb10 Invert colors visual');
  Widget sb10InvertColors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb10 — Invert Colors',
            'Platform color inversion for visual impairment'),
        const SizedBox(height: 10),
        sbCard([
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: rime),
                  ),
                  child: Column(
                    children: [
                      const Text('Normal',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: crevasse)),
                      const SizedBox(height: 8),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4CAF50), Color(0xFF2196F3)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('Green → Blue',
                          style: TextStyle(fontSize: 10, color: crevasse)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: Colors.orange.shade300, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text('Inverted',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade200)),
                      const SizedBox(height: 8),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade300,
                              Colors.orange.shade300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Purple → Orange',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.orange.shade200)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          sbBullet(
              'invertColors is handled at the engine level'),
          sbBullet(
              'Apps can detect it and provide custom inverted themes'),
        ]),
      ],
    );
  }
  Widget sbNavRow(String behavior, String touch, String switchMode) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border:
            Border(top: BorderSide(color: glacier.withValues(alpha: 0.2))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(behavior,
                style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: crevasse)),
          ),
          Expanded(
            child: Text(touch,
                style: TextStyle(
                    fontSize: 11.5,
                    color: crevasse.withValues(alpha: 0.7))),
          ),
          Expanded(
            child: Text(switchMode,
                style: const TextStyle(fontSize: 11.5, color: glacier)),
          ),
        ],
      ),
    );
  }


  // ─────────────────────────────────────────────
  // Section 11: Accessible navigation
  // ─────────────────────────────────────────────
  print('sb11 Accessible navigation');
  Widget sb11Navigation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb11 — Accessible Navigation',
            'How the binding relays navigation accessibility mode'),
        const SizedBox(height: 10),
        sbCard([
          const Text(
            'When accessibleNavigation is on, it means the user is navigating '
            'with a switch device, D-pad, or keyboard — not a touchscreen. '
            'This affects how focus and scrolling behave:',
            style: TextStyle(fontSize: 12.5, color: crevasse),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: glacier),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  color: glacier.withValues(alpha: 0.15),
                  child: const Row(
                    children: [
                      SizedBox(
                          width: 120,
                          child: Text('Behavior',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: crevasse))),
                      Expanded(
                          child: Text('Touch',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: crevasse))),
                      Expanded(
                          child: Text('Switch / D-Pad',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: glacier))),
                    ],
                  ),
                ),
                sbNavRow('Focus ring', 'Hidden', 'Visible'),
                sbNavRow('Scroll extent', 'Infinite', 'Page-by-page'),
                sbNavRow('Time-based UI', 'Normal', 'Paused/extended'),
                sbNavRow('Hover effects', 'Yes', 'No'),
              ],
            ),
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 12: PlatformDispatcher connection
  // ─────────────────────────────────────────────
  print('sb12 PlatformDispatcher connection');
  Widget sb12PlatformDispatcher() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb12 — PlatformDispatcher Connection',
            'How the binding connects to the engine\'s dispatcher'),
        const SizedBox(height: 10),
        sbCard([
          const Text(
            'SemanticsBinding reads accessibility features from '
            'PlatformDispatcher.instance.accessibilityFeatures and '
            'listens for changes:',
            style: TextStyle(fontSize: 12.5, color: crevasse),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: arcticDeep.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: arcticDeep.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.settings_ethernet,
                        size: 16, color: arcticDeep),
                    const SizedBox(width: 6),
                    const Text('PlatformDispatcher',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: arcticDeep)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                    '  .onAccessibilityFeaturesChanged → notifies binding',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: crevasse.withValues(alpha: 0.8))),
                Text('  .accessibilityFeatures → current flags',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: crevasse.withValues(alpha: 0.8))),
                Text('  .onSemanticsEnabledChanged → semantics toggle',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: crevasse.withValues(alpha: 0.8))),
                Text('  .updateSemantics() → send tree to engine',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: crevasse.withValues(alpha: 0.8))),
              ],
            ),
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 13: Reduce transparency
  // ─────────────────────────────────────────────
  print('sb13 Reduce transparency');
  Widget sb13ReduceTransparency() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb13 — Reduce Transparency',
            'Accessibility feature for users who struggle with translucent UI'),
        const SizedBox(height: 10),
        sbCard([
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: [glacier, permafrost],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        child: const Text('Normal (30% opacity)',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: [glacier, permafrost],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.85),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        child: const Text('Reduced (85% opacity)',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          sbBullet(
              'Replace translucent overlays with opaque backgrounds'),
          sbBullet(
              'Check MediaQuery.reduceTransparency to adapt'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 14: On/off switch labels
  // ─────────────────────────────────────────────
  print('sb14 On/off switch labels');
  Widget sb14SwitchLabels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb14 — On/Off Switch Labels',
            'Accessibility feature: visible I/O labels on switches'),
        const SizedBox(height: 10),
        sbCard([
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: rime),
                  ),
                  child: Column(
                    children: [
                      const Text('Without labels',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: crevasse)),
                      const SizedBox(height: 8),
                      Container(
                        width: 48,
                        height: 28,
                        decoration: BoxDecoration(
                          color: glacier,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 22,
                            height: 22,
                            margin: const EdgeInsets.only(right: 3),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: glacier.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: glacier, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text('With labels',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: glacier)),
                      const SizedBox(height: 8),
                      Container(
                        width: 48,
                        height: 28,
                        decoration: BoxDecoration(
                          color: glacier,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 7),
                            const Text('I',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const Spacer(),
                            Container(
                              width: 22,
                              height: 22,
                              margin: const EdgeInsets.only(right: 3),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
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
          const SizedBox(height: 8),
          sbBullet(
              'onOffSwitchLabels: true adds I/O labels for color-blind users'),
          sbBullet(
              'Material Switch can show this automatically when the flag is set'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 15: MediaQuery integration
  // ─────────────────────────────────────────────
  print('sb15 MediaQuery integration');
  Widget sb15MediaQuery() {
    final mappings = [
      {'binding': 'accessibilityFeatures.boldText', 'mq': 'boldText'},
      {'binding': 'accessibilityFeatures.highContrast', 'mq': 'highContrast'},
      {'binding': 'accessibilityFeatures.reduceMotion', 'mq': 'disableAnimations'},
      {'binding': 'accessibilityFeatures.invertColors', 'mq': 'invertColors'},
      {'binding': 'accessibilityFeatures.accessibleNavigation', 'mq': 'accessibleNavigation'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb15 — MediaQuery Integration',
            'How binding features flow into the widget tree'),
        const SizedBox(height: 10),
        sbCard([
          const Text(
            'SemanticsBinding features are surfaced through MediaQueryData '
            'so widgets can respond to accessibility settings:',
            style: TextStyle(fontSize: 12.5, color: crevasse),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: glacier),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  color: glacier.withValues(alpha: 0.15),
                  child: const Row(
                    children: [
                      Expanded(
                          child: Text('SemanticsBinding',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: crevasse))),
                      SizedBox(width: 20),
                      Expanded(
                          child: Text('MediaQuery',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: glacier))),
                    ],
                  ),
                ),
                ...mappings.map((m) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: glacier.withValues(alpha: 0.2))),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(m['binding']!,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: crevasse)),
                          ),
                          const Icon(Icons.arrow_forward,
                              size: 12, color: glacier),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(m['mq']!,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: glacier)),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 16: Summary dashboard
  // ─────────────────────────────────────────────
  print('sb16 Summary dashboard');
  Widget sb16Dashboard() {
    final stats = [
      {'label': 'A11Y Features', 'value': '8', 'sub': 'boldText, highContrast...', 'color': glacier},
      {'label': 'Semantic Events', 'value': '5+', 'sub': 'announce, tooltip, tap...', 'color': permafrost},
      {'label': 'Handle System', 'value': '1', 'sub': 'ensureSemantics()', 'color': bergBlue},
      {'label': 'Bindings', 'value': '8', 'sub': 'in the mixin chain', 'color': arcticDeep},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeader('sb16 — Summary Dashboard',
            'SemanticsBinding at a glance'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: stats
              .map((s) => Container(
                    width: 170,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (s['color'] as Color).withValues(alpha: 0.15),
                          (s['color'] as Color).withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color:
                              (s['color'] as Color).withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(s['value'] as String,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: s['color'] as Color)),
                        Text(s['label'] as String,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: crevasse)),
                        const SizedBox(height: 2),
                        Text(s['sub'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                color:
                                    crevasse.withValues(alpha: 0.7)),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 12),
        sbCard([
          sbBullet(
              'SemanticsBinding bridges the framework and engine accessibility'),
          sbBullet(
              'AccessibilityFeatures flags relay platform settings to the app'),
          sbBullet(
              'ensureSemantics() keeps the tree alive even without a screen reader'),
          sbBullet(
              'Features flow through MediaQuery for easy widget consumption'),
          sbBullet(
              'Semantic events dispatch through the binding to the platform'),
          sbBullet(
              'Apps must respond to boldText, highContrast, reduceMotion, etc.'),
        ]),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  // Main scaffold
  // ═══════════════════════════════════════════════
  print('sb: Building SemanticsBinding deep demo');

  return Scaffold(
    appBar: AppBar(
      title: const Text('SemanticsBinding Deep Demo'),
      backgroundColor: crevasse,
      foregroundColor: Colors.white,
    ),
    body: Container(
      color: iceSheet.withValues(alpha: 0.5),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sb01Overview(),
            sbDivider(),
            sb02Hierarchy(),
            sbDivider(),
            sb03Features(),
            sbDivider(),
            sb04BoldText(),
            sbDivider(),
            sb05HighContrast(),
            sbDivider(),
            sb06ReduceMotion(),
            sbDivider(),
            sb07EnsureSemantics(),
            sbDivider(),
            sb08TextScale(),
            sbDivider(),
            sb09Events(),
            sbDivider(),
            sb10InvertColors(),
            sbDivider(),
            sb11Navigation(),
            sbDivider(),
            sb12PlatformDispatcher(),
            sbDivider(),
            sb13ReduceTransparency(),
            sbDivider(),
            sb14SwitchLabels(),
            sbDivider(),
            sb15MediaQuery(),
            sbDivider(),
            sb16Dashboard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ),
  );
}
