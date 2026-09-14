// ignore_for_file: avoid_print
// D4rt deep demo: InspectorButtonVariant — represents different visual and
// behavioral variants that an inspector button can assume. In the Flutter
// widget inspector, buttons switch between standard, selected, disabled,
// and grouped variants depending on the current inspection context.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Pine / Evergreen palette ───
  const Color pine = Color(0xFF166534);
  const Color evergreen = Color(0xFF15803D);
  const Color deepPine = Color(0xFF052E16);
  const Color paleMeadow = Color(0xFFDCFCE7);
  const Color fern = Color(0xFF22C55E);
  const Color mint = Color(0xFFF0FDF4);
  const Color moss = Color(0xFF14532D);
  const Color sage = Color(0xFF4ADE80);
  const Color clover = Color(0xFFBBF7D0);
  const Color forest = Color(0xFF065F46);

  print('===== INSPECTOR BUTTON VARIANT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepPine, moss],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepPine.withValues(alpha: 0.35),
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
              color: pine,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: fern, width: 1.5),
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
        color: mint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: clover),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepPine.withValues(alpha: 0.9),
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
        border: Border.all(color: clover),
        boxShadow: [
          BoxShadow(
            color: pine.withValues(alpha: 0.08),
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
              color: paleMeadow,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepPine)),
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
                    color: deepPine)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: moss)),
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
                  color: deepPine.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepPine),
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
                  style: TextStyle(fontSize: 11, color: deepPine)),
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
              color: clover.withValues(alpha: 0.5),
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

  Widget variantCard(String name, IconData icon, Color varColor, String description, List<String> traits) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: varColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: varColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: varColor.withValues(alpha: 0.12),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: varColor),
                const SizedBox(width: 8),
                Text(name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: varColor)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: TextStyle(fontSize: 12, color: deepPine, height: 1.4)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: traits
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: varColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: varColor.withValues(alpha: 0.25)),
                            ),
                            child: Text(t,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: varColor)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget transitionArrow(String from, String event, String to) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: paleMeadow,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: clover),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(from,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: pine)),
          ),
          Icon(Icons.arrow_forward, size: 14, color: evergreen),
          const SizedBox(width: 4),
          Expanded(
            child: Text(event,
                style: TextStyle(fontSize: 10, color: forest),
                textAlign: TextAlign.center),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_forward, size: 14, color: evergreen),
          SizedBox(
            width: 80,
            child: Text(to,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: pine),
                textAlign: TextAlign.end),
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
          'InspectorButtonVariant defines the different visual and behavioral '
          'modes that an inspector toolbar button can assume. Each variant '
          'controls the button\'s appearance, tap behavior, and state '
          'semantics within the widget inspector overlay.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Enum / configuration type'),
              dataRow('Package', 'flutter/widgets (widgetInspector)'),
              dataRow('Purpose', 'Define button presentation modes'),
              dataRow('Used by', 'InspectorButton rendering logic'),
              dataRow('Controls', 'Visual state and interaction mode'),
            ],
          )),
    ],
  );

  // ─── Section 2: Variant Types ───
  print('[Section 2] Variant Types');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Variant Types'),
      noteBox(
          'Each variant type represents a distinct visual configuration '
          'that the InspectorButton can adopt depending on context.'),
      variantCard(
        'Standard',
        Icons.radio_button_unchecked,
        evergreen,
        'Default inactive state. The button is ready to be tapped but '
            'represents a currently-disabled feature.',
        ['Muted icon', 'No background', 'Full opacity container'],
      ),
      variantCard(
        'Selected',
        Icons.check_circle,
        pine,
        'Active state indicating the feature is currently enabled. Visual '
            'emphasis draws attention to the active debugging tool.',
        ['Accent icon', 'Tinted background', 'Bold weight'],
      ),
      variantCard(
        'Disabled',
        Icons.block,
        const Color(0xFF9CA3AF),
        'The button cannot be interacted with. The feature is unavailable '
            'in the current context or mode.',
        ['Grey icon', 'Reduced opacity', 'No tap handler'],
      ),
      variantCard(
        'Grouped',
        Icons.view_module,
        forest,
        'Button belongs to a mutually exclusive group where selecting one '
            'deselects others. Radio-button semantics.',
        ['Group identity', 'Auto-deselect peers', 'Single active'],
      ),
    ],
  );

  // ─── Section 3: Visual Comparison ───
  print('[Section 3] Visual Comparison');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Visual Comparison'),
      noteBox(
          'Side-by-side comparison of how the same icon appears across '
          'different variants.'),
      infoCard(
          'Same Icon, Four Variants',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: clover),
                        ),
                        child: Icon(Icons.touch_app, size: 20, color: evergreen.withValues(alpha: 0.5)),
                      ),
                      const SizedBox(height: 4),
                      Text('Standard', style: TextStyle(fontSize: 10, color: deepPine)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: pine.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: pine, width: 2),
                        ),
                        child: Icon(Icons.touch_app, size: 20, color: pine),
                      ),
                      const SizedBox(height: 4),
                      Text('Selected', style: TextStyle(fontSize: 10, color: deepPine)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFD1D5DB)),
                        ),
                        child: Icon(Icons.touch_app, size: 20, color: const Color(0xFF9CA3AF)),
                      ),
                      const SizedBox(height: 4),
                      Text('Disabled', style: TextStyle(fontSize: 10, color: deepPine)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: forest.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: forest),
                        ),
                        child: Icon(Icons.touch_app, size: 20, color: forest),
                      ),
                      const SizedBox(height: 4),
                      Text('Grouped', style: TextStyle(fontSize: 10, color: deepPine)),
                    ],
                  ),
                ],
              ),
            ],
          )),
    ],
  );

  // ─── Section 4: State Transitions ───
  print('[Section 4] State Transitions');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'State Transitions'),
      noteBox(
          'Variants transition between states based on user interaction '
          'and inspector context changes.'),
      infoCard(
          'Transition Diagram',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              transitionArrow('Standard', 'onTap', 'Selected'),
              transitionArrow('Selected', 'onTap', 'Standard'),
              transitionArrow('Standard', 'context lost', 'Disabled'),
              transitionArrow('Disabled', 'context restored', 'Standard'),
              transitionArrow('Grouped', 'peer selected', 'Standard'),
              transitionArrow('Standard', 'group join', 'Grouped'),
            ],
          )),
    ],
  );

  // ─── Section 5: Variant Properties ───
  print('[Section 5] Variant Properties');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Variant Properties'),
      noteBox(
          'Each variant defines a set of visual and behavioral properties '
          'that the InspectorButton reads to render itself.'),
      infoCard(
          'Property Matrix',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Background color', 'Varies: transparent → tinted'),
              dataRow('Icon color', 'Varies: muted → accent'),
              dataRow('Icon opacity', '0.5 (standard) → 1.0 (selected)'),
              dataRow('Border', 'None → accent border (selected)'),
              dataRow('Tap enabled', 'true (standard/selected) → false'),
              dataRow('Semantics', 'button / toggleButton / disabled'),
            ],
          )),
      infoCard(
          'Detailed Breakdown',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Standard bg', 'Colors.transparent'),
              dataRow('Selected bg', 'accent.withValues(alpha: 0.15)'),
              dataRow('Disabled bg', 'grey[100]'),
              dataRow('Grouped bg', 'groupColor.withValues(alpha: 0.1)'),
            ],
          )),
    ],
  );

  // ─── Section 6: Grouped Variant ───
  print('[Section 6] Grouped Variant');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Grouped Variant Detail'),
      noteBox(
          'The grouped variant implements radio-button semantics. When one '
          'button in a group is selected, all others automatically deselect.'),
      infoCard(
          'Group Mechanics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Group ID', 'Shared identifier for related buttons'),
              dataRow('Selection', 'Only one active per group'),
              dataRow('Deselect', 'Automatic when peer activates'),
              dataRow('Default', 'First button or none selected'),
            ],
          )),
      infoCard(
          'Group Example: Inspection Modes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: pine.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: pine, width: 2),
                        ),
                        child: Icon(Icons.touch_app, size: 20, color: pine),
                      ),
                      const SizedBox(height: 4),
                      Text('Select', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: pine)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: clover),
                        ),
                        child: Icon(Icons.layers, size: 20, color: evergreen.withValues(alpha: 0.5)),
                      ),
                      const SizedBox(height: 4),
                      Text('Layout', style: TextStyle(fontSize: 10, color: deepPine)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: clover),
                        ),
                        child: Icon(Icons.speed, size: 20, color: evergreen.withValues(alpha: 0.5)),
                      ),
                      const SizedBox(height: 4),
                      Text('Perf', style: TextStyle(fontSize: 10, color: deepPine)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              dataRow('Active', 'Select mode (bold border)'),
              dataRow('Others', 'Automatically deselected'),
            ],
          )),
    ],
  );

  // ─── Section 7: Disabled Variant ───
  print('[Section 7] Disabled Variant');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Disabled Variant Detail'),
      noteBox(
          'The disabled variant prevents interaction and communicates '
          'that the action is unavailable in the current context.'),
      infoCard(
          'When Disabled',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No debug connection', 'DevTools not attached'),
              dataRow('Incompatible mode', 'Feature conflicts with active'),
              dataRow('Platform limit', 'Feature not available on web'),
              dataRow('App paused', 'Cannot interact while paused'),
            ],
          )),
      infoCard(
          'Disabled Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Tap', 'Ignored — no callback fired'),
              dataRow('Visual', 'Greyed out icon and background'),
              dataRow('Cursor', 'Not-allowed (desktop)'),
              dataRow('Semantics', 'Announced as disabled'),
              dataRow('Tooltip', 'Still available (explains why)'),
            ],
          )),
    ],
  );

  // ─── Section 8: Selected Variant ───
  print('[Section 8] Selected Variant');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Selected Variant Detail'),
      noteBox(
          'The selected variant provides strong visual emphasis to indicate '
          'an actively-enabled debugging feature.'),
      infoCard(
          'Selected Visual Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Background', 'Accent color at 15% opacity'),
              dataRow('Icon', 'Full accent color, 100% opacity'),
              dataRow('Border', '2px accent color border'),
              dataRow('Shadow', 'Subtle elevation shadow'),
              dataRow('Weight', 'Bold label if text present'),
            ],
          )),
      infoCard(
          'Toggle Semantics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Role', 'toggleButton'),
              dataRow('State', 'checked = true'),
              dataRow('Label', 'Feature name + " enabled"'),
              dataRow('Action hint', '"Double tap to disable"'),
            ],
          )),
    ],
  );

  // ─── Section 9: Variant Resolution ───
  print('[Section 9] Variant Resolution');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Variant Resolution'),
      noteBox(
          'The variant is resolved at build time based on multiple inputs '
          'including the button\'s own state and the inspector\'s context.'),
      infoCard(
          'Resolution Priority',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Disabled check', 'If feature unavailable → disabled'),
              dataRow('2. Selected check', 'If isSelected true → selected'),
              dataRow('3. Group check', 'If in group → grouped/standard'),
              dataRow('4. Default', 'Standard variant'),
            ],
          )),
      infoCard(
          'Resolution Decision Tree',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              transitionArrow('Input', 'isEnabled?', 'No → Disabled'),
              transitionArrow('Enabled', 'isSelected?', 'Yes → Selected'),
              transitionArrow('Not selected', 'hasGroup?', 'Yes → Grouped'),
              transitionArrow('No group', 'default', 'Standard'),
            ],
          )),
    ],
  );

  // ─── Section 10: Animation Between Variants ───
  print('[Section 10] Animation');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Animation Between Variants'),
      noteBox(
          'Variant transitions can be animated to provide smooth visual '
          'feedback when the button state changes.'),
      infoCard(
          'Animated Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Background color', 'AnimatedContainer or ColorTween'),
              dataRow('Icon color', 'Synced with background transition'),
              dataRow('Border width', '0 → 2px on selection'),
              dataRow('Opacity', '1.0 → 0.5 on disable'),
              dataRow('Duration', '~200ms standard'),
            ],
          )),
      infoCard(
          'Transition Timing',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Standard → Selected', 0.85, pine),
              progressBar('Selected → Standard', 0.85, evergreen),
              progressBar('Any → Disabled', 0.6, const Color(0xFF9CA3AF)),
              progressBar('Disabled → Standard', 0.7, forest),
            ],
          )),
    ],
  );

  // ─── Section 11: Variant in Toolbar Context ───
  print('[Section 11] Toolbar Context');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Variant in Toolbar Context'),
      noteBox(
          'In the full toolbar, variants interact — one button becoming '
          'selected may cause others to change variant.'),
      infoCard(
          'Toolbar State Snapshot',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: deepPine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: clover),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: pine.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: pine, width: 2),
                          ),
                          child: Icon(Icons.touch_app, size: 16, color: pine),
                        ),
                        const SizedBox(height: 2),
                        Text('Selected', style: TextStyle(fontSize: 8, color: pine)),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: clover),
                          ),
                          child: Icon(Icons.border_all, size: 16, color: evergreen.withValues(alpha: 0.5)),
                        ),
                        const SizedBox(height: 2),
                        Text('Standard', style: TextStyle(fontSize: 8, color: deepPine)),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: clover),
                          ),
                          child: Icon(Icons.gradient, size: 16, color: evergreen.withValues(alpha: 0.5)),
                        ),
                        const SizedBox(height: 2),
                        Text('Standard', style: TextStyle(fontSize: 8, color: deepPine)),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFD1D5DB)),
                          ),
                          child: Icon(Icons.slow_motion_video, size: 16, color: const Color(0xFF9CA3AF)),
                        ),
                        const SizedBox(height: 2),
                        Text('Disabled', style: TextStyle(fontSize: 8, color: const Color(0xFF9CA3AF))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    ],
  );

  // ─── Section 12: Variant Testing ───
  print('[Section 12] Variant Testing');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Testing Variants'),
      noteBox(
          'Each variant should be tested for correct visual rendering '
          'and interaction behavior.'),
      infoCard(
          'Test Cases per Variant',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Standard: render', 'Correct colors and opacity'),
              dataRow('Standard: tap', 'Fires onPressed, transitions'),
              dataRow('Selected: render', 'Accent background and icon'),
              dataRow('Selected: tap', 'Deselects on toggle'),
              dataRow('Disabled: render', 'Greyed out appearance'),
              dataRow('Disabled: tap', 'No callback fired'),
              dataRow('Grouped: render', 'Group visual indicator'),
              dataRow('Grouped: select', 'Peers auto-deselect'),
            ],
          )),
      infoCard(
          'Assertion Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('find.byIcon', 'Verify icon is correct'),
              dataRow('Theme check', 'Container color matches variant'),
              dataRow('tap + pump', 'State transitions correctly'),
              dataRow('Semantics', 'Role and state match variant'),
            ],
          )),
    ],
  );

  // ─── Section 13: Extending Variants ───
  print('[Section 13] Extending Variants');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Extending Variants'),
      noteBox(
          'Custom inspector tools may need additional variants beyond '
          'the standard set.'),
      infoCard(
          'Custom Variant Ideas',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Loading', 'Spinner while action runs'),
              dataRow('Error', 'Red tint for failed action'),
              dataRow('Warning', 'Yellow tint for caution'),
              dataRow('Info', 'Blue tint for informational'),
              dataRow('Compact', 'Smaller size for crowded toolbars'),
            ],
          )),
      infoCard(
          'Implementation Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Define enum value', 'Add to variant enum'),
              dataRow('2. Set colors', 'Background, icon, border'),
              dataRow('3. Set behavior', 'Tap enabled, semantics'),
              dataRow('4. Add transition', 'How to animate in/out'),
            ],
          )),
    ],
  );

  // ─── Section 14: Variant and Theme ───
  print('[Section 14] Variant and Theme');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Variant and Theme Integration'),
      noteBox(
          'Inspector variants can adapt to the app\'s theme to maintain '
          'visual consistency with the DevTools color scheme.'),
      infoCard(
          'Theme Adaptation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Light theme', 'Darker icon colors on light bg'),
              dataRow('Dark theme', 'Lighter icon colors on dark bg'),
              dataRow('Overlay bg', 'Semi-transparent black or white'),
              dataRow('Accent', 'From DevTools theme settings'),
            ],
          )),
      infoCard(
          'Color Resolution',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Primary source', 'Inspector internal constants'),
              dataRow('Fallback', 'Theme.of(context) colors'),
              dataRow('Override', 'DevTools extension theme'),
              dataRow('High contrast', 'Supported for accessibility'),
            ],
          )),
    ],
  );

  // ─── Section 15: Performance Considerations ───
  print('[Section 15] Performance');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Performance Considerations'),
      noteBox(
          'Variant resolution and rendering should be lightweight since '
          'inspector UI runs alongside the app being debugged.'),
      infoCard(
          'Optimization Points',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Const constructors', 'Variant data is immutable'),
              dataRow('Minimal rebuilds', 'Only changed buttons rebuild'),
              dataRow('No layout shift', 'Fixed size across variants'),
              dataRow('Simple painting', 'Solid colors, no gradients'),
            ],
          )),
      infoCard(
          'Memory Footprint',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Per button', '~5 fields (color, icon, enabled)'),
              dataRow('Toolbar total', '5-8 buttons typical'),
              dataRow('Variant enum', '4 values, negligible'),
              dataRow('Animation', 'Only active during transitions'),
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
      noteBox('Complete overview of the InspectorButtonVariant deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Pine', pine),
              colorSwatch('Evergreen', evergreen),
              colorSwatch('Deep Pine', deepPine),
              colorSwatch('Pale Meadow', paleMeadow),
              colorSwatch('Fern', fern),
              colorSwatch('Mint', mint),
              colorSwatch('Moss', moss),
              colorSwatch('Sage', sage),
              colorSwatch('Clover', clover),
              colorSwatch('Forest', forest),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, pine),
              progressBar('Variant Types', 1.0, evergreen),
              progressBar('Visual Comparison', 1.0, forest),
              progressBar('State Transitions', 1.0, fern),
              progressBar('Variant Properties', 1.0, pine),
              progressBar('Grouped Variant', 1.0, evergreen),
              progressBar('Disabled Variant', 1.0, forest),
              progressBar('Selected Variant', 1.0, fern),
              progressBar('Variant Resolution', 1.0, pine),
              progressBar('Animation', 1.0, evergreen),
              progressBar('Toolbar Context', 1.0, forest),
              progressBar('Testing', 1.0, fern),
              progressBar('Extending Variants', 1.0, pine),
              progressBar('Theme Integration', 1.0, evergreen),
              progressBar('Performance', 1.0, forest),
              progressBar('Dashboard', 1.0, fern),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Pine / Evergreen'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('InspectorButtonVariant', pine, Colors.white),
          tag('State Machine', evergreen, Colors.white),
          tag('Visual Modes', forest, Colors.white),
          tag('Group Semantics', moss, Colors.white),
          tag('Transitions', fern, deepPine),
          tag('Theme Aware', sage, deepPine),
        ],
      ),
    ],
  );

  print('===== END INSPECTOR BUTTON VARIANT DEEP DEMO =====');

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
