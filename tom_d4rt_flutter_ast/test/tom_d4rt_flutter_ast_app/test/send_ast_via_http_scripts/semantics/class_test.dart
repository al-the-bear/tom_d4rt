// ignore_for_file: avoid_print
// D4rt deep demo: Semantics class (the primary accessibility annotation widget)
// Demonstrates how to annotate widgets for screen readers and accessibility tools.
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  // ─── Dusk / Twilight palette ───
  const Color dusk = Color(0xFF5C4D7D);
  const Color twilight = Color(0xFF8E79B0);
  const Color nightSky = Color(0xFF2D2248);
  const Color velvet = Color(0xFFF3EFF9);
  const Color plumWine = Color(0xFF6E3A7A);
  const Color amethyst = Color(0xFF9966CC);
  const Color moonlight = Color(0xFFD5CBE8);
  const Color starGold = Color(0xFFE8C547);
  const Color deepIndigo = Color(0xFF3B2F63);

  // ─── Helper builders ───
  Widget smHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [nightSky, dusk],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: dusk.withValues(alpha: 0.35),
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

  Widget smCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: velvet,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: twilight.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget smBullet(String text, {Color dotColor = dusk}) {
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
                style: const TextStyle(fontSize: 12.5, color: nightSky)),
          ),
        ],
      ),
    );
  }

  Widget smDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              twilight.withValues(alpha: 0.0),
              twilight,
              twilight.withValues(alpha: 0.0),
            ],
          ),
        ),
      ),
    );
  }
  Widget smFlowBox(String label, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
  Widget smArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.arrow_forward, size: 18, color: dusk),
    );
  }



  // ─────────────────────────────────────────────
  // Section 1: What is Semantics?
  // ─────────────────────────────────────────────
  print('sm01 Semantics — what and why');
  Widget sm01Overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm01 — What is the Semantics Widget?',
            'The bridge between visual UI and accessibility services'),
        const SizedBox(height: 10),
        smCard([
          const Text(
            'The Semantics widget annotates the widget tree with metadata '
            'that accessibility tools (screen readers, switch access, etc.) '
            'use to describe the UI to users with disabilities.',
            style: TextStyle(fontSize: 13, color: nightSky),
          ),
          const SizedBox(height: 10),
          smBullet('Wraps any widget with accessibility annotations'),
          smBullet('Describes labels, values, hints, and roles'),
          smBullet('Registers actions (tap, longPress, scroll, etc.)'),
          smBullet('Controls how nodes merge in the semantics tree'),
          smBullet('Many Flutter widgets already use Semantics internally'),
        ]),
        const SizedBox(height: 8),
        // Visual: widget → semantics → platform
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonlight.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: twilight.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              smFlowBox('Widget\nTree', dusk, Icons.widgets),
              smArrow(),
              smFlowBox('Semantics\nAnnotations', amethyst, Icons.accessibility_new),
              smArrow(),
              smFlowBox('Platform\nA11Y API', plumWine, Icons.phone_android),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 2: Core parameters — label/value/hint
  // ─────────────────────────────────────────────
  print('sm02 Core parameters: label, value, hint');
  Widget sm02CoreParams() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm02 — Core Parameters: label, value, hint',
            'The three text properties of a Semantics node'),
        const SizedBox(height: 10),
        // Label demo
        smCard([
          const Text('label — what this element is:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 6),
          Semantics(
            label: 'Search',
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: dusk.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: dusk.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: dusk, size: 22),
                  SizedBox(width: 8),
                  Text('Search',
                      style: TextStyle(fontSize: 14, color: nightSky)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text('Screen reader: "Search"',
              style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: dusk.withValues(alpha: 0.8))),
        ]),
        const SizedBox(height: 6),
        // Value demo
        smCard([
          const Text('value — the current value:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 6),
          Semantics(
            label: 'Volume',
            value: '75 percent',
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: amethyst.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: amethyst.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.volume_up, color: amethyst, size: 22),
                  const SizedBox(width: 8),
                  const Text('75%',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: nightSky)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        height: 8,
                        child: LinearProgressIndicator(
                          value: 0.75,
                          backgroundColor: moonlight,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(amethyst),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text('Screen reader: "Volume, 75 percent"',
              style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: dusk.withValues(alpha: 0.8))),
        ]),
        const SizedBox(height: 6),
        // Hint demo
        smCard([
          const Text('hint — how to interact:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 6),
          Semantics(
            label: 'Send message',
            hint: 'Double tap to send',
            button: true,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: plumWine,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Send',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 4),
          Text('Screen reader: "Send message, button, Double tap to send"',
              style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: dusk.withValues(alpha: 0.8))),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 3: Boolean role flags
  // ─────────────────────────────────────────────
  print('sm03 Role flags: button, link, header, image, etc.');
  Widget sm03RoleFlags() {
    final roles = [
      {'flag': 'button', 'icon': Icons.smart_button, 'desc': 'Activatable button', 'color': dusk},
      {'flag': 'link', 'icon': Icons.link, 'desc': 'Navigational hyperlink', 'color': amethyst},
      {'flag': 'header', 'icon': Icons.title, 'desc': 'Section heading', 'color': plumWine},
      {'flag': 'image', 'icon': Icons.image, 'desc': 'Decorative/content image', 'color': deepIndigo},
      {'flag': 'textField', 'icon': Icons.text_fields, 'desc': 'Text input field', 'color': twilight},
      {'flag': 'slider', 'icon': Icons.tune, 'desc': 'Value slider control', 'color': Color(0xFF7A5FA0)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm03 — Role Flags',
            'Boolean flags that tell the platform what type of control this is'),
        const SizedBox(height: 10),
        smCard([
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: roles.map((r) {
              final color = r['color'] as Color;
              return Container(
                width: 160,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(r['icon'] as IconData, size: 22, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['flag'] as String,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  color: color)),
                          Text(r['desc'] as String,
                              style: const TextStyle(
                                  fontSize: 10.5, color: nightSky)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          smBullet(
              'Set these on Semantics widget or SemanticsProperties'),
          smBullet('Platform maps them to native accessibility roles'),
          smBullet(
              'Example: button: true → iOS VoiceOver says "button" after label'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 4: State flags
  // ─────────────────────────────────────────────
  print('sm04 State flags: checked, selected, enabled, etc.');
  Widget sm04StateFlags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm04 — State Flags',
            'Boolean state indicators for interactive controls'),
        const SizedBox(height: 10),
        // Live checked examples
        smCard([
          const Text('checked state:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Semantics(
                  label: 'Notifications',
                  checked: true,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_box, color: Colors.green, size: 20),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text('Notifications ON',
                              style:
                                  TextStyle(fontSize: 12, color: nightSky)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Semantics(
                  label: 'Sound',
                  checked: false,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_box_outline_blank,
                            color: Colors.grey.shade600, size: 20),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text('Sound OFF',
                              style:
                                  TextStyle(fontSize: 12, color: nightSky)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
        const SizedBox(height: 6),
        // Selected vs not selected
        smCard([
          const Text('selected state:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final item in [
                {'label': 'Home', 'selected': true, 'icon': Icons.home},
                {'label': 'Profile', 'selected': false, 'icon': Icons.person},
                {'label': 'Settings', 'selected': false, 'icon': Icons.settings},
              ])
                Expanded(
                  child: Semantics(
                    label: item['label'] as String,
                    selected: item['selected'] as bool,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (item['selected'] as bool)
                            ? dusk.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: (item['selected'] as bool)
                                ? dusk
                                : Colors.grey.shade300,
                            width: (item['selected'] as bool) ? 2 : 1),
                      ),
                      child: Column(
                        children: [
                          Icon(item['icon'] as IconData,
                              size: 22,
                              color: (item['selected'] as bool)
                                  ? dusk
                                  : Colors.grey),
                          const SizedBox(height: 4),
                          Text(item['label'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: (item['selected'] as bool)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: (item['selected'] as bool)
                                      ? dusk
                                      : Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ]),
        const SizedBox(height: 6),
        // Enabled / disabled
        smCard([
          const Text('enabled state:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Semantics(
                  label: 'Submit',
                  enabled: true,
                  button: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: dusk,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('Enabled',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Semantics(
                  label: 'Disabled button',
                  enabled: false,
                  button: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('Disabled',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 5: Actions (onTap, onLongPress, etc.)
  // ─────────────────────────────────────────────
  print('sm05 Semantic actions');
  Widget sm05Actions() {
    final actions = [
      {'name': 'onTap', 'icon': Icons.touch_app, 'desc': 'Single tap/activate'},
      {'name': 'onLongPress', 'icon': Icons.pan_tool, 'desc': 'Long press action'},
      {'name': 'onScrollLeft', 'icon': Icons.arrow_back, 'desc': 'Scroll left'},
      {'name': 'onScrollRight', 'icon': Icons.arrow_forward, 'desc': 'Scroll right'},
      {'name': 'onScrollUp', 'icon': Icons.arrow_upward, 'desc': 'Scroll up'},
      {'name': 'onScrollDown', 'icon': Icons.arrow_downward, 'desc': 'Scroll down'},
      {'name': 'onIncrease', 'icon': Icons.add_circle, 'desc': 'Increase value'},
      {'name': 'onDecrease', 'icon': Icons.remove_circle, 'desc': 'Decrease value'},
      {'name': 'onCopy', 'icon': Icons.content_copy, 'desc': 'Copy content'},
      {'name': 'onCut', 'icon': Icons.content_cut, 'desc': 'Cut content'},
      {'name': 'onPaste', 'icon': Icons.content_paste, 'desc': 'Paste content'},
      {'name': 'onDismiss', 'icon': Icons.close, 'desc': 'Dismiss element'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm05 — Semantic Actions',
            'Callbacks exposed to accessibility services'),
        const SizedBox(height: 10),
        smCard([
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: actions.map((a) {
              return Container(
                width: 145,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: twilight.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: twilight.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    Icon(a['icon'] as IconData, size: 16, color: dusk),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['name'] as String,
                              style: const TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  color: nightSky)),
                          Text(a['desc'] as String,
                              style: TextStyle(
                                  fontSize: 9.5,
                                  color: nightSky.withValues(alpha: 0.7))),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          smBullet('Actions register callbacks with the semantics engine'),
          smBullet(
              'Platform triggers them via VoiceOver gestures, TalkBack, etc.'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 6: Semantics.fromProperties
  // ─────────────────────────────────────────────
  print('sm06 Semantics.fromProperties');
  Widget sm06FromProperties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm06 — Semantics.fromProperties()',
            'Alt constructor using SemanticsProperties object'),
        const SizedBox(height: 10),
        smCard([
          const Text(
            'Instead of passing individual parameters, you can bundle '
            'them into a SemanticsProperties object:',
            style: TextStyle(fontSize: 12.5, color: nightSky),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepIndigo.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: deepIndigo.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Semantics.fromProperties(',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
                Text('  properties: SemanticsProperties(',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
                Text('    label: "Username",',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: amethyst.withValues(alpha: 0.9))),
                Text('    textField: true,',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: amethyst.withValues(alpha: 0.9))),
                Text('    hint: "Enter username",',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: amethyst.withValues(alpha: 0.9))),
                Text('  ),',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
                Text('  child: myTextField,',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
                Text(')',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          smBullet(
              'Useful when you build properties dynamically or share them'),
          smBullet(
              'Identical behavior to the named constructor parameters'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 7: container property
  // ─────────────────────────────────────────────
  print('sm07 container property');
  Widget sm07Container() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm07 — The container Property',
            'Controlling whether Semantics creates its own node or merges'),
        const SizedBox(height: 10),
        smCard([
          const Text(
            'container: true creates a new SemanticsNode, making this '
            'widget a distinct focus target for accessibility. '
            'container: false allows merging with parent.',
            style: TextStyle(fontSize: 12.5, color: nightSky),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: dusk.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: dusk),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.crop_square, size: 28, color: dusk),
                      const SizedBox(height: 4),
                      const Text('container: true',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              color: dusk)),
                      const SizedBox(height: 4),
                      const Text(
                        'Own SemanticsNode\nSeparate focus target',
                        style: TextStyle(fontSize: 10.5, color: nightSky),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: amethyst.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: amethyst),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.merge, size: 28, color: amethyst),
                      const SizedBox(height: 4),
                      const Text('container: false',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              color: amethyst)),
                      const SizedBox(height: 4),
                      const Text(
                        'Merges into parent\nCombined announcement',
                        style: TextStyle(fontSize: 10.5, color: nightSky),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 8: MergeSemantics
  // ─────────────────────────────────────────────
  print('sm08 MergeSemantics widget');
  Widget sm08MergeSemantics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm08 — MergeSemantics Widget',
            'Force child semantics nodes to merge into one'),
        const SizedBox(height: 10),
        smCard([
          const Text('Without MergeSemantics (two stops):',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: 'Star icon',
                  child:
                      const Icon(Icons.star, color: starGold, size: 24),
                ),
                const SizedBox(height: 4),
                Semantics(
                  label: '4.5 stars',
                  child: const Text('4.5',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: nightSky)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text('Screen reader: stop 1: "Star icon", stop 2: "4.5 stars"',
              style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: twilight)),
        ]),
        const SizedBox(height: 8),
        smCard([
          const Text('With MergeSemantics (one stop):',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6),
              border:
                  Border.all(color: Colors.green.withValues(alpha: 0.3)),
            ),
            child: MergeSemantics(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Semantics(
                    label: 'Rating star',
                    child: const Icon(Icons.star,
                        color: starGold, size: 24),
                  ),
                  const SizedBox(width: 6),
                  Semantics(
                    label: '4.5 out of 5',
                    child: const Text('4.5',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: nightSky)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
              'Screen reader: "Rating star, 4.5 out of 5" (single stop)',
              style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: twilight)),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 9: ExcludeSemantics
  // ─────────────────────────────────────────────
  print('sm09 ExcludeSemantics');
  Widget sm09Exclude() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm09 — ExcludeSemantics',
            'Removing widgets from the accessibility tree'),
        const SizedBox(height: 10),
        smCard([
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Visible but excluded:',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: nightSky)),
                    const SizedBox(height: 8),
                    ExcludeSemantics(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.image,
                                size: 36, color: Colors.grey.shade400),
                            const SizedBox(height: 4),
                            const Text('Decorative image',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('No A11Y node',
                        style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    const Text('Included in tree:',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: nightSky)),
                    const SizedBox(height: 8),
                    Semantics(
                      label: 'User avatar, Alice Johnson',
                      image: true,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: amethyst.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: amethyst),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.person,
                                size: 36, color: amethyst),
                            const SizedBox(height: 4),
                            const Text('User avatar',
                                style: TextStyle(
                                    fontSize: 11, color: nightSky)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Has A11Y node',
                        style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: amethyst)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          smBullet(
              'Use ExcludeSemantics for decorative elements with no meaning'),
          smBullet(
              'Keep Semantics for images that convey information'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 10: Sort keys (OrdinalSortKey)
  // ─────────────────────────────────────────────
  print('sm10 Sort keys for focus order');
  Widget sm10SortKeys() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm10 — Semantic Sort Keys',
            'Controlling the focus order for accessibility navigation'),
        const SizedBox(height: 10),
        smCard([
          const Text(
            'By default, accessibility tools traverse in visual (paint) order. '
            'OrdinalSortKey overrides this to set a custom reading order:',
            style: TextStyle(fontSize: 12.5, color: nightSky),
          ),
          const SizedBox(height: 10),
          // Three boxes with custom sort order
          Row(
            children: [
              for (final item in [
                {'order': 3, 'label': 'Third', 'color': plumWine},
                {'order': 1, 'label': 'First', 'color': dusk},
                {'order': 2, 'label': 'Second', 'color': amethyst},
              ])
                Expanded(
                  child: Semantics(
                    sortKey: OrdinalSortKey((item['order'] as int).toDouble()),
                    label: '${item['label']} item (order: ${item['order']})',
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: (item['color'] as Color), width: 2),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: item['color'] as Color,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text('${item['order']}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(item['label'] as String,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: item['color'] as Color)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Visual order: Third | First | Second',
              style: TextStyle(fontSize: 11.5, color: nightSky)),
          Text('A11Y focus order: First → Second → Third',
              style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: dusk.withValues(alpha: 0.9))),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 11: Custom semantic actions
  // ─────────────────────────────────────────────
  print('sm11 Custom semantic actions');
  Widget sm11CustomActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm11 — Custom Semantic Actions',
            'CustomSemanticsAction for domain-specific operations'),
        const SizedBox(height: 10),
        smCard([
          const Text(
            'CustomSemanticsAction allows registering app-specific '
            'actions that screen readers can discover and trigger:',
            style: TextStyle(fontSize: 12.5, color: nightSky),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: deepIndigo.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: deepIndigo.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('customSemanticsActions: {',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
                Text('  CustomSemanticsAction(label: "Archive"): () => ...,',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: amethyst.withValues(alpha: 0.9))),
                Text('  CustomSemanticsAction(label: "Pin"): () => ...,',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: amethyst.withValues(alpha: 0.9))),
                Text('}',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Visual custom action buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final act in [
                {'label': 'Archive', 'icon': Icons.archive, 'color': dusk},
                {'label': 'Pin', 'icon': Icons.push_pin, 'color': amethyst},
                {'label': 'Share', 'icon': Icons.share, 'color': plumWine},
                {'label': 'Report', 'icon': Icons.flag, 'color': deepIndigo},
              ])
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color:
                        (act['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: (act['color'] as Color)
                            .withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(act['icon'] as IconData,
                          size: 16, color: act['color'] as Color),
                      const SizedBox(width: 6),
                      Text(act['label'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: act['color'] as Color)),
                    ],
                  ),
                ),
            ],
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 12: textDirection & attributedLabel
  // ─────────────────────────────────────────────
  print('sm12 textDirection and attributed strings');
  Widget sm12TextDirection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm12 — Text Direction & Attributed Strings',
            'RTL support and rich accessibility labels'),
        const SizedBox(height: 10),
        smCard([
          const Text('textDirection on Semantics:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Semantics(
                  textDirection: TextDirection.ltr,
                  label: 'Left to right text',
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: dusk.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: dusk.withValues(alpha: 0.3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.format_textdirection_l_to_r,
                            size: 18, color: dusk),
                        SizedBox(width: 6),
                        Text('LTR: Hello',
                            style: TextStyle(fontSize: 13, color: nightSky)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Semantics(
                  textDirection: TextDirection.rtl,
                  label: 'Right to left text',
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: plumWine.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: plumWine.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('مرحبا :RTL',
                            style:
                                TextStyle(fontSize: 13, color: nightSky)),
                        const SizedBox(width: 6),
                        const Icon(Icons.format_textdirection_r_to_l,
                            size: 18, color: plumWine),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          smBullet(
              'textDirection tells the platform how to render and read the label'),
          smBullet(
              'AttributedString allows styling parts of a label differently'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 13: Tooltip semantics
  // ─────────────────────────────────────────────
  print('sm13 Tooltip semantics');
  Widget sm13Tooltip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm13 — Tooltip Semantics',
            'How tooltips expose information to accessibility'),
        const SizedBox(height: 10),
        smCard([
          const Text(
            'The tooltip property provides additional hover/context information '
            'that screen readers can announce:',
            style: TextStyle(fontSize: 12.5, color: nightSky),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Semantics(
                  label: 'Settings',
                  tooltip: 'Open application settings',
                  button: true,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: twilight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: twilight),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.settings,
                            size: 28, color: twilight),
                        const SizedBox(height: 6),
                        const Text('Settings',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: nightSky)),
                        const SizedBox(height: 2),
                        Text('tooltip: "Open application settings"',
                            style: TextStyle(
                                fontSize: 9.5,
                                fontStyle: FontStyle.italic,
                                color: nightSky.withValues(alpha: 0.6))),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Semantics(
                  label: 'Refresh',
                  tooltip: 'Refresh the data feed',
                  button: true,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: amethyst.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: amethyst),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.refresh,
                            size: 28, color: amethyst),
                        const SizedBox(height: 6),
                        const Text('Refresh',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: nightSky)),
                        const SizedBox(height: 2),
                        Text('tooltip: "Refresh the data feed"',
                            style: TextStyle(
                                fontSize: 9.5,
                                fontStyle: FontStyle.italic,
                                color: nightSky.withValues(alpha: 0.6))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 14: Live widget gallery
  // ─────────────────────────────────────────────
  print('sm14 Live widget gallery — annotated widgets');
  Widget sm14Gallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm14 — Live Widget Gallery',
            'Widgets with various Semantics annotations'),
        const SizedBox(height: 10),
        // Switch-like control
        smCard([
          const Text('Toggle with semantics:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 8),
          Semantics(
            toggled: true,
            label: 'Dark mode',
            hint: 'Double tap to toggle',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: nightSky,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.dark_mode, size: 18, color: starGold),
                  const SizedBox(width: 8),
                  const Text('Dark Mode ON',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: starGold,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
        const SizedBox(height: 6),
        // Card with multiple annotations
        smCard([
          const Text('Card with mixed semantics:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: nightSky)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: moonlight),
              boxShadow: [
                BoxShadow(
                  color: dusk.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  label: 'Product name: Widget Pro',
                  child: const Text('Widget Pro',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: nightSky)),
                ),
                const SizedBox(height: 4),
                Semantics(
                  label: 'Price: 29 dollars and 99 cents',
                  child: const Text('\$29.99',
                      style: TextStyle(
                          fontSize: 14,
                          color: plumWine,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 6),
                Semantics(
                  label: 'Rating: 4.7 out of 5',
                  child: Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          i < 4 ? Icons.star : Icons.star_half,
                          size: 16,
                          color: starGold,
                        ),
                      const SizedBox(width: 4),
                      const Text('4.7',
                          style: TextStyle(fontSize: 12, color: nightSky)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  button: true,
                  label: 'Add to cart',
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: dusk,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('Add to Cart',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 15: SemanticsDebugger
  // ─────────────────────────────────────────────
  print('sm15 SemanticsDebugger');
  Widget sm15Debugger() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm15 — SemanticsDebugger',
            'Visual overlay for debugging the semantics tree'),
        const SizedBox(height: 10),
        smCard([
          const Text(
            'SemanticsDebugger wraps your app and draws the semantics tree '
            'on screen, showing labels, nodes, and boundaries:',
            style: TextStyle(fontSize: 12.5, color: nightSky),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepIndigo.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: deepIndigo.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SemanticsDebugger(',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
                Text('  child: MaterialApp(...),',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: amethyst.withValues(alpha: 0.9))),
                Text(')',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: dusk.withValues(alpha: 0.9))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Simulated debugger view
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.yellow.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Colors.yellow.shade700.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('┌─ [Scaffold]',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.yellow.shade800)),
                Text('│  ┌─ [AppBar] "My App"',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.yellow.shade800)),
                Text('│  ├─ [Button] "Save" (tap)',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.yellow.shade800)),
                Text('│  └─ [TextField] "Enter name" (editable)',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.yellow.shade800)),
                Text('└──',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.yellow.shade800)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          smBullet(
              'Invaluable during development to verify accessibility'),
          smBullet(
              'Shows which nodes are focusable, actions available, etc.'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 16: Summary dashboard
  // ─────────────────────────────────────────────
  print('sm16 Summary dashboard');
  Widget sm16Dashboard() {
    final stats = [
      {'label': 'Text Props', 'value': '3', 'sub': 'label / value / hint', 'color': dusk},
      {'label': 'Role Flags', 'value': '6+', 'sub': 'button, link, header...', 'color': amethyst},
      {'label': 'State Flags', 'value': '8+', 'sub': 'checked, selected...', 'color': plumWine},
      {'label': 'Actions', 'value': '12+', 'sub': 'tap, scroll, copy...', 'color': twilight},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smHeader('sm16 — Summary Dashboard',
            'The Semantics widget at a glance'),
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
                                color: nightSky)),
                        const SizedBox(height: 2),
                        Text(s['sub'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                color: nightSky.withValues(alpha: 0.7)),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 12),
        smCard([
          smBullet(
              'Semantics is the primary widget for accessibility annotations'),
          smBullet(
              'Labels, values, and hints describe the widget to screen readers'),
          smBullet(
              'Role flags (button, header, etc.) map to platform A11Y roles'),
          smBullet(
              'Actions expose interactive capabilities via accessibility services'),
          smBullet(
              'MergeSemantics and ExcludeSemantics control tree structure'),
          smBullet(
              'OrdinalSortKey customizes navigation order'),
          smBullet(
              'container: true/false controls node creation vs merging'),
        ]),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  // Main scaffold
  // ═══════════════════════════════════════════════
  print('sm: Building Semantics class deep demo');

  return Scaffold(
    appBar: AppBar(
      title: const Text('Semantics Class Deep Demo'),
      backgroundColor: nightSky,
      foregroundColor: Colors.white,
    ),
    body: Container(
      color: velvet.withValues(alpha: 0.5),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sm01Overview(),
            smDivider(),
            sm02CoreParams(),
            smDivider(),
            sm03RoleFlags(),
            smDivider(),
            sm04StateFlags(),
            smDivider(),
            sm05Actions(),
            smDivider(),
            sm06FromProperties(),
            smDivider(),
            sm07Container(),
            smDivider(),
            sm08MergeSemantics(),
            smDivider(),
            sm09Exclude(),
            smDivider(),
            sm10SortKeys(),
            smDivider(),
            sm11CustomActions(),
            smDivider(),
            sm12TextDirection(),
            smDivider(),
            sm13Tooltip(),
            smDivider(),
            sm14Gallery(),
            smDivider(),
            sm15Debugger(),
            smDivider(),
            sm16Dashboard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ),
  );
}
