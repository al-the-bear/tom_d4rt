// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsConfiguration from semantics
// Deep Demo: Visual exploration of SemanticsConfiguration — the object that
// describes a RenderObject's accessibility properties for assistive services.
//
// SemanticsConfiguration is the central data bag that every RenderObject fills
// in via describeSemanticsConfiguration(). It carries labels, hints, values,
// boolean traits (isButton, isLink, isHeader, …), semantic actions, and tree
// merging instructions. Platform accessibility services (TalkBack, VoiceOver)
// read these configurations to build a navigable representation of the UI.
//
// Scene 1 — Boolean Trait Flags Catalog
// Scene 2 — Labeling & Attributed Strings Workshop
// Scene 3 — Semantic Actions Palette
// Scene 4 — Tree Merging & Boundary Lab
// Scene 5 — Absorb & Copy Operations Theater
// Scene 6 — Practical Accessibility Patterns Compendium
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('SemanticsConfiguration Deep Demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────────────────
  // Color palette — warm amber/purple accessibility theme
  // ──────────────────────────────────────────────────────────
  const cPrimary = Color(0xFF6A1B9A);
  const cSecondary = Color(0xFFF57C00);
  const cSurface = Color(0xFFFFF3E0);
  const cAccent = Color(0xFF00897B);
  const cDisabled = Color(0xFFBDBDBD);
  const cError = Color(0xFFC62828);
  const cSuccess = Color(0xFF2E7D32);

  // ──────────────────────────────────────────────────────────
  // Helper builders
  // ──────────────────────────────────────────────────────────

  Widget sectionHeader(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 28.0, bottom: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32.0, color: color),
          SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: color)),
                SizedBox(height: 3.0),
                Text(subtitle, style: TextStyle(fontSize: 12.0, color: color.withValues(alpha: 0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoBox(String text, {Color color = const Color(0xFF424242)}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(text, style: TextStyle(fontSize: 12.0, height: 1.5, color: color)),
    );
  }

  Widget traitCard({
    required String name,
    required String description,
    required IconData icon,
    required Color color,
    required bool currentValue,
    required String category,
  }) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: currentValue ? color.withValues(alpha: 0.12) : Colors.grey.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: currentValue ? color : Colors.grey.withValues(alpha: 0.3),
          width: currentValue ? 2.0 : 1.0,
        ),
        boxShadow: currentValue
            ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 6.0, offset: Offset(0.0, 2.0))]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.0, color: currentValue ? color : Colors.grey),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: currentValue ? color : Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: currentValue ? cSuccess.withValues(alpha: 0.15) : cDisabled.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  currentValue ? 'ON' : 'OFF',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    color: currentValue ? cSuccess : cDisabled,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(description, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
          SizedBox(height: 3.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.5),
            decoration: BoxDecoration(
              color: cPrimary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(category, style: TextStyle(fontSize: 8.0, color: cPrimary)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SCENE 1: Boolean Trait Flags Catalog
  // ============================================================
  print('\n=== Scene 1: Boolean Trait Flags Catalog ===');

  final configTraits = SemanticsConfiguration();
  // Read default values for each trait before modification
  print('Default isButton: ${configTraits.isButton}');
  print('Default isLink: ${configTraits.isLink}');
  print('Default isHeader: ${configTraits.isHeader}');
  print('Default isImage: ${configTraits.isImage}');
  print('Default isTextField: ${configTraits.isTextField}');
  print('Default isEnabled: ${configTraits.isEnabled}');
  print('Default isSelected: ${configTraits.isSelected}');
  print('Default isChecked: ${configTraits.isChecked}');
  print('Default isToggled: ${configTraits.isToggled}');
  print('Default isReadOnly: ${configTraits.isReadOnly}');
  print('Default isFocusable: ${configTraits.isFocusable}');
  print('Default isFocused: ${configTraits.isFocused}');
  print('Default isHidden: ${configTraits.isHidden}');
  print('Default isObscured: ${configTraits.isObscured}');
  print('Default isMultiline: ${configTraits.isMultiline}');
  print('Default isSlider: ${configTraits.isSlider}');
  print('Default hasImplicitScrolling: ${configTraits.hasImplicitScrolling}');
  print('Default liveRegion: ${configTraits.liveRegion}');

  // Create a config with some traits turned on
  final configOn = SemanticsConfiguration();
  configOn.isButton = true;
  configOn.isEnabled = true;
  configOn.isFocusable = true;
  configOn.isSelected = true;
  print('After setting isButton=true, isEnabled=true, isFocusable=true, isSelected=true');

  // Interactive category: traits affecting user interaction
  final interactiveTraits = <Widget>[
    traitCard(
      name: 'isButton',
      description: 'Marks the node as a button. Assistive tech announces "button" after the label.',
      icon: Icons.smart_button,
      color: cSecondary,
      currentValue: configOn.isButton,
      category: 'Interactive',
    ),
    traitCard(
      name: 'isLink',
      description: 'Marks the node as a hyperlink. Screen readers announce "link" for navigation elements.',
      icon: Icons.link,
      color: cSecondary,
      currentValue: configTraits.isLink,
      category: 'Interactive',
    ),
    traitCard(
      name: 'isTextField',
      description: 'Marks as text input. Enables keyboard entry actions on assistive services.',
      icon: Icons.text_fields,
      color: cSecondary,
      currentValue: configTraits.isTextField,
      category: 'Interactive',
    ),
    traitCard(
      name: 'isSlider',
      description: 'Indicates an adjustable slider control. Enables increase/decrease gestures.',
      icon: Icons.tune,
      color: cSecondary,
      currentValue: configTraits.isSlider,
      category: 'Interactive',
    ),
  ];

  // State category: traits describing current state
  final stateTraits = <Widget>[
    traitCard(
      name: 'isEnabled',
      description: 'Whether the control is active. Disabled controls still appear but are non-interactive.',
      icon: Icons.toggle_on,
      color: cAccent,
      currentValue: configOn.isEnabled == true,
      category: 'State',
    ),
    traitCard(
      name: 'isSelected',
      description: 'Current selection state. Used by tabs, chips, list items in selection mode.',
      icon: Icons.check_box,
      color: cAccent,
      currentValue: configOn.isSelected,
      category: 'State',
    ),
    traitCard(
      name: 'isChecked',
      description: 'Checkbox/Toggle tri-state. Null = mixed, true = checked, false = unchecked.',
      icon: Icons.check_circle_outline,
      color: cAccent,
      currentValue: configTraits.isChecked == true,
      category: 'State',
    ),
    traitCard(
      name: 'isToggled',
      description: 'On/off toggle state. Similar to isChecked but for switches.',
      icon: Icons.toggle_off_outlined,
      color: cAccent,
      currentValue: configTraits.isToggled == true,
      category: 'State',
    ),
    traitCard(
      name: 'isFocusable',
      description: 'Whether the node can receive focus. Focus-able nodes are traversed by screen readers.',
      icon: Icons.center_focus_strong,
      color: cAccent,
      currentValue: configOn.isFocusable,
      category: 'State',
    ),
    traitCard(
      name: 'isFocused',
      description: 'Whether the node currently has focus. Only one node should be focused at a time.',
      icon: Icons.gps_fixed,
      color: cAccent,
      currentValue: configTraits.isFocused == true,
      category: 'State',
    ),
    traitCard(
      name: 'isReadOnly',
      description: 'Text field that cannot be edited. Content is readable but not modifiable.',
      icon: Icons.lock_outline,
      color: cAccent,
      currentValue: configTraits.isReadOnly,
      category: 'State',
    ),
  ];

  // Structural category: traits defining node classification
  final structuralTraits = <Widget>[
    traitCard(
      name: 'isHeader',
      description: 'Marks a heading element. Screen readers allow quick navigation between headers.',
      icon: Icons.title,
      color: cPrimary,
      currentValue: configTraits.isHeader,
      category: 'Structural',
    ),
    traitCard(
      name: 'isImage',
      description: 'Marks image content. The label serves as alternative text for the image.',
      icon: Icons.image,
      color: cPrimary,
      currentValue: configTraits.isImage,
      category: 'Structural',
    ),
    traitCard(
      name: 'isHidden',
      description: 'Hides node from accessibility tree. Use sparingly; content becomes invisible.',
      icon: Icons.visibility_off,
      color: cPrimary,
      currentValue: configTraits.isHidden,
      category: 'Structural',
    ),
    traitCard(
      name: 'isObscured',
      description: 'Content is obscured (password fields). Prevents reading of sensitive text.',
      icon: Icons.password,
      color: cPrimary,
      currentValue: configTraits.isObscured,
      category: 'Structural',
    ),
    traitCard(
      name: 'isMultiline',
      description: 'Multi-line text area. Affects how screen readers announce line breaks.',
      icon: Icons.notes,
      color: cPrimary,
      currentValue: configTraits.isMultiline,
      category: 'Structural',
    ),
    traitCard(
      name: 'liveRegion',
      description: 'Announces changes automatically. For toast notifications, countdowns, progress.',
      icon: Icons.campaign,
      color: cPrimary,
      currentValue: configTraits.liveRegion,
      category: 'Structural',
    ),
    traitCard(
      name: 'hasImplicitScrolling',
      description: 'Node is implicitly scrollable. Assistive tech adds scroll gestures to the node.',
      icon: Icons.swap_vert,
      color: cPrimary,
      currentValue: configTraits.hasImplicitScrolling,
      category: 'Structural',
    ),
  ];

  final scene1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        'Scene 1 — Boolean Trait Flags',
        'Every property that SemanticsConfiguration exposes to assistive services',
        Icons.flag_circle,
        cPrimary,
      ),
      infoBox(
        'SemanticsConfiguration carries boolean flags that describe WHAT a UI element '
        'is (button, link, header, image, text field, slider) and its STATE (enabled, '
        'selected, checked, focused, obscured, hidden). These are read by TalkBack/'
        'VoiceOver to announce the element correctly.',
        color: cPrimary,
      ),

      // Interactive traits section
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: cSecondary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text('Interactive Traits', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: cSecondary)),
      ),
      Wrap(
        children: interactiveTraits.map((card) {
          return SizedBox(width: 180.0, child: card);
        }).toList(),
      ),

      SizedBox(height: 12.0),

      // State traits section
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: cAccent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text('State Traits', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: cAccent)),
      ),
      Wrap(
        children: stateTraits.map((card) {
          return SizedBox(width: 180.0, child: card);
        }).toList(),
      ),

      SizedBox(height: 12.0),

      // Structural traits section
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: cPrimary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text('Structural Traits', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: cPrimary)),
      ),
      Wrap(
        children: structuralTraits.map((card) {
          return SizedBox(width: 180.0, child: card);
        }).toList(),
      ),

      SizedBox(height: 8.0),

      // Visual summary of the "configOn" instance we configured
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cSuccess.withValues(alpha: 0.1), cSuccess.withValues(alpha: 0.03)],
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cSuccess.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, size: 18.0, color: cSuccess),
                SizedBox(width: 8.0),
                Text('Active Config Snapshot', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cSuccess)),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'isButton: ${configOn.isButton}  |  isEnabled: ${configOn.isEnabled}  |  '
              'isFocusable: ${configOn.isFocusable}  |  isSelected: ${configOn.isSelected}',
              style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade800),
            ),
            SizedBox(height: 4.0),
            Text(
              'This configuration tells assistive services: "I am a focusable, '
              'enabled, selected button."',
              style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 2: Labeling & Attributed Strings Workshop
  // ============================================================
  print('\n=== Scene 2: Labeling & Attributed Strings Workshop ===');

  // Demonstrate the five labeling axes
  final configLabels = SemanticsConfiguration();
  configLabels.label = 'Submit Order';
  configLabels.hint = 'Double-tap to submit your order';
  configLabels.value = '3 items, \$42.99';
  configLabels.increasedValue = '4 items, \$56.99';
  configLabels.decreasedValue = '2 items, \$28.99';
  configLabels.tooltip = 'Order submission button';
  configLabels.textDirection = TextDirection.ltr;
  print('Label: ${configLabels.label}');
  print('Hint: ${configLabels.hint}');
  print('Value: ${configLabels.value}');
  print('IncreasedValue: ${configLabels.increasedValue}');
  print('DecreasedValue: ${configLabels.decreasedValue}');
  print('Tooltip: ${configLabels.tooltip}');
  print('TextDirection: ${configLabels.textDirection}');

  // Attributed strings demonstration
  final attrLabel = AttributedString(
    'Spell: NASA means National Aeronautics',
    attributes: [
      SpellOutStringAttribute(range: TextRange(start: 7, end: 11)),
    ],
  );
  print('AttributedString created with SpellOut range 7-11');

  final attrLabelLocale = AttributedString(
    'Bonjour from Paris, Hello from London',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 18), locale: Locale('fr', 'FR')),
      LocaleStringAttribute(range: TextRange(start: 20, end: 37), locale: Locale('en', 'GB')),
    ],
  );
  print('AttributedString with locale attributes: fr-FR (0-18), en-GB (20-37)');
  print('Locale string length: ${attrLabelLocale.string.length}');

  final configAttr = SemanticsConfiguration();
  configAttr.attributedLabel = attrLabel;
  print('Attributed label set on config: ${configAttr.attributedLabel.string}');

  Widget labelAxisCard(String axis, String value, IconData icon, Color color, String explanation) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 4.0)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, size: 22.0, color: color),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(axis, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: color)),
                SizedBox(height: 2.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text('"$value"', style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: color)),
                ),
                SizedBox(height: 4.0),
                Text(explanation, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Character grid showing span ranges for attributed strings
  Widget attributeSpanVisualizer(String text, List<Map<String, dynamic>> spans) {
    final charWidgets = <Widget>[];
    for (var i = 0; i < text.length; i++) {
      Color bgColor = Colors.grey.withValues(alpha: 0.05);
      Color textColor = Colors.grey.shade700;
      for (final span in spans) {
        final start = span['start'] as int;
        final end = span['end'] as int;
        if (i >= start && i < end) {
          bgColor = (span['color'] as Color).withValues(alpha: 0.2);
          textColor = span['color'] as Color;
        }
      }
      charWidgets.add(
        Container(
          width: 16.0,
          height: 24.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2), width: 0.5),
          ),
          child: Text(
            text[i],
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return Wrap(children: charWidgets);
  }

  final scene2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        'Scene 2 — Labeling & Attributed Strings',
        'The five labeling axes plus rich text attributes for precise pronunciation',
        Icons.label_important,
        cSecondary,
      ),
      infoBox(
        'Every SemanticsConfiguration has FIVE text axes that assistive services '
        'read aloud: label (name), hint (instruction), value (current state), '
        'increasedValue/decreasedValue (for adjustable controls), and tooltip. '
        'Each also has an attributed variant with SpellOut and Locale spans.',
        color: cSecondary,
      ),

      labelAxisCard('label', configLabels.label, Icons.label, cPrimary,
          'The main identity. Screen readers announce this first. "Submit Order".'),
      labelAxisCard('hint', configLabels.hint, Icons.info_outline, cAccent,
          'Action instruction. VoiceOver says this after the label. "Double-tap to submit your order".'),
      labelAxisCard('value', configLabels.value, Icons.data_object, cSecondary,
          'Current state value. For sliders, counters, dropdowns. "3 items, \$42.99".'),
      labelAxisCard('increasedValue', configLabels.increasedValue, Icons.arrow_upward, cSuccess,
          'What value becomes after increase gesture. "4 items, \$56.99".'),
      labelAxisCard('decreasedValue', configLabels.decreasedValue, Icons.arrow_downward, cError,
          'What value becomes after decrease gesture. "2 items, \$28.99".'),
      labelAxisCard('tooltip', configLabels.tooltip, Icons.chat_bubble_outline, Colors.blueGrey,
          'Additional context shown on hover/long-focus. "Order submission button".'),

      SizedBox(height: 16.0),

      // Attributed String visualization
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: cPrimary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SpellOut Attribute Span', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cPrimary)),
            SizedBox(height: 4.0),
            Text(
              'Range 7–11 is spelled out letter by letter (N-A-S-A)',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8.0),
            attributeSpanVisualizer(
              'Spell: NASA means National Aeronautics',
              [
                {'start': 7, 'end': 11, 'color': cSecondary},
              ],
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Container(width: 14.0, height: 14.0, color: cSecondary.withValues(alpha: 0.2)),
                SizedBox(width: 6.0),
                Text('SpellOut range', style: TextStyle(fontSize: 10.0, color: cSecondary)),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: 10.0),

      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: cAccent.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cAccent.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Locale Attribute Spans', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cAccent)),
            SizedBox(height: 4.0),
            Text(
              'Different ranges read in different languages by TTS engine',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8.0),
            attributeSpanVisualizer(
              'Bonjour from Paris, Hello from London',
              [
                {'start': 0, 'end': 18, 'color': Colors.blue},
                {'start': 20, 'end': 37, 'color': cError},
              ],
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Container(width: 14.0, height: 14.0, color: Colors.blue.withValues(alpha: 0.2)),
                SizedBox(width: 4.0),
                Text('fr-FR', style: TextStyle(fontSize: 10.0, color: Colors.blue)),
                SizedBox(width: 12.0),
                Container(width: 14.0, height: 14.0, color: cError.withValues(alpha: 0.2)),
                SizedBox(width: 4.0),
                Text('en-GB', style: TextStyle(fontSize: 10.0, color: cError)),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: 8.0),

      // Text direction badge
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(Icons.format_textdirection_l_to_r, size: 18.0, color: Colors.grey.shade600),
            SizedBox(width: 8.0),
            Text(
              'textDirection: ${configLabels.textDirection} — controls reading order for all labels',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 3: Semantic Actions Palette
  // ============================================================
  print('\n=== Scene 3: Semantic Actions Palette ===');

  // Register actions on a config to verify they appear
  final configActions = SemanticsConfiguration();
  var tapCount = 0;
  var longPressCount = 0;
  var scrollCount = 0;
  var increaseCount = 0;
  var decreaseCount = 0;
  var copyCount = 0;
  var dismissCount = 0;

  configActions.onTap = () {
    tapCount++;
    print('  Action: onTap fired ($tapCount)');
  };
  configActions.onLongPress = () {
    longPressCount++;
    print('  Action: onLongPress fired ($longPressCount)');
  };
  configActions.onScrollLeft = () {
    scrollCount++;
    print('  Action: onScrollLeft fired ($scrollCount)');
  };
  configActions.onScrollRight = () {
    scrollCount++;
    print('  Action: onScrollRight fired ($scrollCount)');
  };
  configActions.onScrollUp = () {
    scrollCount++;
    print('  Action: onScrollUp fired ($scrollCount)');
  };
  configActions.onScrollDown = () {
    scrollCount++;
    print('  Action: onScrollDown fired ($scrollCount)');
  };
  configActions.onIncrease = () {
    increaseCount++;
    print('  Action: onIncrease fired ($increaseCount)');
  };
  configActions.onDecrease = () {
    decreaseCount++;
    print('  Action: onDecrease fired ($decreaseCount)');
  };
  configActions.onCopy = () {
    copyCount++;
    print('  Action: onCopy fired ($copyCount)');
  };
  configActions.onDismiss = () {
    dismissCount++;
    print('  Action: onDismiss fired ($dismissCount)');
  };

  // Fire a couple to verify handler wiring
  configActions.onTap!();
  configActions.onLongPress!();
  configActions.onIncrease!();
  configActions.onDecrease!();
  configActions.onCopy!();
  configActions.onDismiss!();
  print('After firing: tap=$tapCount, longPress=$longPressCount, increase=$increaseCount, decrease=$decreaseCount, copy=$copyCount, dismiss=$dismissCount');

  // Custom actions
  final customAction1 = CustomSemanticsAction(label: 'Archive');
  final customAction2 = CustomSemanticsAction(label: 'Star');
  configActions.customSemanticsActions = {
    customAction1: () => print('  Custom action: Archive'),
    customAction2: () => print('  Custom action: Star'),
  };
  print('Custom actions registered: ${configActions.customSemanticsActions.length}');

  // Build action tile visual
  Widget actionTile(String name, IconData icon, Color color, String gesture, bool isRegistered) {
    return Container(
      width: 110.0,
      margin: EdgeInsets.all(3.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isRegistered ? color.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isRegistered ? color.withValues(alpha: 0.5) : Colors.grey.withValues(alpha: 0.2),
          width: isRegistered ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.0, color: isRegistered ? color : cDisabled),
          SizedBox(height: 4.0),
          Text(
            name,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: isRegistered ? color : cDisabled),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.0),
          Text(gesture, style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500), textAlign: TextAlign.center),
          SizedBox(height: 3.0),
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRegistered ? cSuccess : cDisabled,
            ),
          ),
        ],
      ),
    );
  }

  final scene3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        'Scene 3 — Semantic Actions Palette',
        'Every action a user can trigger through assistive technology gestures',
        Icons.touch_app,
        cAccent,
      ),
      infoBox(
        'SemanticsConfiguration registers ACTION HANDLERS that assistive services '
        'can invoke. When a screen reader user double-taps, swipes, or uses a '
        'rotor action, the corresponding handler fires. The green dot means the '
        'action is registered on this config; grey means not registered.',
        color: cAccent,
      ),

      // Primary actions row
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text('Primary Actions', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: Colors.deepOrange)),
      ),
      Wrap(
        children: [
          actionTile('onTap', Icons.touch_app, Colors.deepOrange, 'Double-tap', true),
          actionTile('onLongPress', Icons.pan_tool, Colors.deepOrange, 'Double-tap & hold', true),
          actionTile('onDismiss', Icons.close, Colors.deepOrange, 'Swipe dismiss', true),
        ],
      ),

      SizedBox(height: 8.0),

      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text('Scroll Actions', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: Colors.blue)),
      ),
      Wrap(
        children: [
          actionTile('onScrollUp', Icons.arrow_upward, Colors.blue, '3-finger swipe up', true),
          actionTile('onScrollDown', Icons.arrow_downward, Colors.blue, '3-finger swipe down', true),
          actionTile('onScrollLeft', Icons.arrow_back, Colors.blue, '3-finger swipe left', true),
          actionTile('onScrollRight', Icons.arrow_forward, Colors.blue, '3-finger swipe right', true),
        ],
      ),

      SizedBox(height: 8.0),

      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: cSuccess.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text('Adjustment Actions', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: cSuccess)),
      ),
      Wrap(
        children: [
          actionTile('onIncrease', Icons.add_circle, cSuccess, 'Swipe up', true),
          actionTile('onDecrease', Icons.remove_circle, cSuccess, 'Swipe down', true),
        ],
      ),

      SizedBox(height: 8.0),

      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: cPrimary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text('Text & Clipboard Actions', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: cPrimary)),
      ),
      Wrap(
        children: [
          actionTile('onCopy', Icons.copy, cPrimary, 'Rotor: copy', true),
          actionTile('onCut', Icons.cut, cPrimary, 'Rotor: cut', false),
          actionTile('onPaste', Icons.paste, cPrimary, 'Rotor: paste', false),
          actionTile('onSetText', Icons.edit, cPrimary, 'Voice input', false),
          actionTile('onSetSelection', Icons.select_all, cPrimary, 'Cursor move', false),
          actionTile('onMoveCursor\nFwd', Icons.keyboard_arrow_right, cPrimary, 'Cursor forward', false),
          actionTile('onMoveCursor\nBack', Icons.keyboard_arrow_left, cPrimary, 'Cursor backward', false),
        ],
      ),

      SizedBox(height: 8.0),

      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: cSecondary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text('Custom Actions', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: cSecondary)),
      ),
      Wrap(
        children: [
          actionTile('Archive', Icons.archive, cSecondary, 'Custom rotor', true),
          actionTile('Star', Icons.star, cSecondary, 'Custom rotor', true),
        ],
      ),

      SizedBox(height: 8.0),

      // Fire summary
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: cSuccess.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: cSuccess.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Handler Fire Results', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cSuccess)),
            SizedBox(height: 6.0),
            Text(
              'onTap: $tapCount  |  onLongPress: $longPressCount  |  onIncrease: $increaseCount  |  '
              'onDecrease: $decreaseCount  |  onCopy: $copyCount  |  onDismiss: $dismissCount',
              style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 4: Tree Merging & Boundary Lab
  // ============================================================
  print('\n=== Scene 4: Tree Merging & Boundary Lab ===');

  // Demonstrate merging via Semantics widget configurations
  final configBoundary = SemanticsConfiguration();
  configBoundary.isSemanticBoundary = true;
  print('isSemanticBoundary: ${configBoundary.isSemanticBoundary}');

  final configExplicit = SemanticsConfiguration();
  configExplicit.explicitChildNodes = true;
  print('explicitChildNodes: ${configExplicit.explicitChildNodes}');

  final configMerging = SemanticsConfiguration();
  configMerging.isSemanticBoundary = true;
  configMerging.isMergingSemanticsOfDescendants = true;
  print('isMergingSemanticsOfDescendants: ${configMerging.isMergingSemanticsOfDescendants}');

  Widget treeNodeVisual(String label, Color color, List<Widget> children, {bool isBoundary = false, bool isMerge = false}) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: isBoundary ? 3.0 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isBoundary) Icon(Icons.fence, size: 14.0, color: color),
              if (isMerge) Icon(Icons.merge, size: 14.0, color: color),
              SizedBox(width: 4.0),
              Flexible(
                child: Text(label, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: color)),
              ),
            ],
          ),
          if (children.isNotEmpty) ...[
            SizedBox(height: 4.0),
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
            ),
          ],
        ],
      ),
    );
  }

  final scene4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        'Scene 4 — Tree Merging & Boundary Lab',
        'How isSemanticBoundary, explicitChildNodes, and isMergingSemanticsOfDescendants shape the tree',
        Icons.account_tree,
        Colors.indigo,
      ),
      infoBox(
        'The semantics tree is NOT a 1:1 copy of the widget tree. Three config '
        'flags control how render nodes contribute to the tree:\n'
        '• isSemanticBoundary — forces a new semantics node\n'
        '• explicitChildNodes — children get their own nodes\n'
        '• isMergingSemanticsOfDescendants — absorbs descendants',
        color: Colors.indigo,
      ),

      // Scenario A: Default (no boundaries)
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scenario A: Default — No Boundaries', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            Text(
              'All labels merge upward into the nearest ancestor boundary. '
              'Screen reader reads all concatenated text as one unit.',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
            ),
            SizedBox(height: 8.0),
            treeNodeVisual('Row (merged)', Colors.grey, [
              treeNodeVisual('Icon: star', Colors.grey, []),
              treeNodeVisual('Text: "Favorite"', Colors.grey, []),
              treeNodeVisual('Text: "(12)"', Colors.grey, []),
            ]),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Result: One semantics node → "star, Favorite, (12)"',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.amber.shade900),
              ),
            ),
          ],
        ),
      ),

      // Scenario B: With semantic boundary
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scenario B: isSemanticBoundary = true', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.blue)),
            SizedBox(height: 4.0),
            Text(
              'Forces a NEW semantics node. Children are separate from parent. '
              'Each boundary creates a navigable focus target.',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
            ),
            SizedBox(height: 8.0),
            treeNodeVisual('ListTile', Colors.blue, [
              treeNodeVisual('Icon: mail [BOUNDARY]', Colors.blue, [], isBoundary: true),
              treeNodeVisual('Column', Colors.blue, [
                treeNodeVisual('Text: "Inbox" [BOUNDARY]', Colors.blue, [], isBoundary: true),
                treeNodeVisual('Text: "32 new"', Colors.blue, []),
              ]),
            ]),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Result: 3 nodes → [mail icon] [Inbox] [32 new, …]',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.blue.shade900),
              ),
            ),
          ],
        ),
      ),

      // Scenario C: Merging descendants
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: cPrimary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scenario C: isMergingSemanticsOfDescendants = true', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cPrimary)),
            SizedBox(height: 4.0),
            Text(
              'All descendant labels fuse into this node. The subtree collapses '
              'into a single accessibility element. Used by buttons with icons+text.',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
            ),
            SizedBox(height: 8.0),
            treeNodeVisual('ElevatedButton [MERGING]', cPrimary, [
              treeNodeVisual('Row', cPrimary.withValues(alpha: 0.5), [
                treeNodeVisual('Icon: send', cPrimary.withValues(alpha: 0.5), []),
                treeNodeVisual('Text: "Send Message"', cPrimary.withValues(alpha: 0.5), []),
              ]),
            ], isMerge: true),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: cPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Result: 1 node → "send, Send Message" (button)',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: cPrimary),
              ),
            ),
          ],
        ),
      ),

      // Scenario D: explicitChildNodes
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: cAccent.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cAccent.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scenario D: explicitChildNodes = true', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cAccent)),
            SizedBox(height: 4.0),
            Text(
              'Children get their own separate nodes even without explicit boundaries. '
              'Used when each child needs independent focus (e.g., list items).',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
            ),
            SizedBox(height: 8.0),
            treeNodeVisual('ListView [EXPLICIT CHILDREN]', cAccent, [
              treeNodeVisual('Item: "Apple"', cAccent, [], isBoundary: true),
              treeNodeVisual('Item: "Banana"', cAccent, [], isBoundary: true),
              treeNodeVisual('Item: "Cherry"', cAccent, [], isBoundary: true),
            ]),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: cAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Result: 4 nodes → [ListView] [Apple] [Banana] [Cherry]',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: cAccent),
              ),
            ),
          ],
        ),
      ),

      // Config flag readback
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.indigo.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Config Readback', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.indigo)),
            SizedBox(height: 4.0),
            Text(
              'configBoundary.isSemanticBoundary: ${configBoundary.isSemanticBoundary}\n'
              'configExplicit.explicitChildNodes: ${configExplicit.explicitChildNodes}\n'
              'configMerging.isMergingSemanticsOfDescendants: ${configMerging.isMergingSemanticsOfDescendants}',
              style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.indigo.shade700),
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 5: Absorb & Copy Operations Theater
  // ============================================================
  print('\n=== Scene 5: Absorb & Copy Operations ===');

  // Create two configs to absorb
  final configA = SemanticsConfiguration();
  configA.label = 'Play';
  configA.isButton = true;
  configA.isEnabled = true;
  configA.hint = 'Double-tap to play';
  print('Config A: label="${configA.label}", isButton=${configA.isButton}, isEnabled=${configA.isEnabled}');

  final configB = SemanticsConfiguration();
  configB.value = 'Track 3 of 12';
  configB.isSelected = true;
  configB.increasedValue = 'Track 4 of 12';
  configB.decreasedValue = 'Track 2 of 12';
  print('Config B: value="${configB.value}", isSelected=${configB.isSelected}');

  // Copy first
  final copyOfA = configA.copy();
  print('Copy of A: label="${copyOfA.label}", isButton=${copyOfA.isButton}');

  // Absorb B into copy of A
  copyOfA.absorb(configB);
  print('After absorb(B): label="${copyOfA.label}", value="${copyOfA.value}", isSelected=${copyOfA.isSelected}');

  // isCompatibleWith check
  final configC = SemanticsConfiguration();
  final isCompat = configC.isCompatibleWith(configA);
  print('Empty config compatible with A: $isCompat');

  Widget configCard(String title, Map<String, String> props, Color color, {String annotation = ''}) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: color)),
          if (annotation.isNotEmpty) ...[
            SizedBox(height: 2.0),
            Text(annotation, style: TextStyle(fontSize: 9.0, fontStyle: FontStyle.italic, color: color.withValues(alpha: 0.7))),
          ],
          SizedBox(height: 8.0),
          ...props.entries.map((e) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.5),
              child: Row(
                children: [
                  SizedBox(
                    width: 100.0,
                    child: Text(e.key, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade600)),
                  ),
                  Expanded(
                    child: Text(e.value, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: color)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  final scene5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        'Scene 5 — Absorb & Copy Operations',
        'How configs merge, clone, and check compatibility',
        Icons.merge_type,
        Colors.deepPurple,
      ),
      infoBox(
        'copy() creates an independent clone of the configuration. absorb(other) '
        'takes all non-null properties from the other config and applies them to '
        'this one — labels concatenate, flags OR together. isCompatibleWith() '
        'checks if a merge would produce inconsistencies.',
        color: Colors.deepPurple,
      ),

      // Before panels
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: configCard('Config A (Original)', {
              'label': '"${configA.label}"',
              'hint': '"${configA.hint}"',
              'value': '""',
              'isButton': '${configA.isButton}',
              'isEnabled': '${configA.isEnabled}',
              'isSelected': 'false',
            }, Colors.blue),
          ),
          Expanded(
            child: configCard('Config B', {
              'label': '""',
              'hint': '""',
              'value': '"${configB.value}"',
              'isButton': 'false',
              'isEnabled': 'false',
              'isSelected': '${configB.isSelected}',
              'inc. value': '"${configB.increasedValue}"',
              'dec. value': '"${configB.decreasedValue}"',
            }, cSecondary),
          ),
        ],
      ),

      // Arrow
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('copy() + absorb(B)', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            Icon(Icons.arrow_downward, size: 28.0, color: Colors.deepPurple),
          ],
        ),
      ),

      // After panel
      configCard(
        'Result: copy(A).absorb(B)',
        {
          'label': '"${copyOfA.label}"',
          'hint': '"${copyOfA.hint}"',
          'value': '"${copyOfA.value}"',
          'isButton': '${copyOfA.isButton}',
          'isEnabled': '${copyOfA.isEnabled}',
          'isSelected': '${copyOfA.isSelected}',
          'inc. value': '"${copyOfA.increasedValue}"',
          'dec. value': '"${copyOfA.decreasedValue}"',
        },
        Colors.deepPurple,
        annotation: 'Labels concatenate, boolean flags OR together, values from B fill in',
      ),

      SizedBox(height: 12.0),

      // Compatibility check visual
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: (isCompat ? cSuccess : cError).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: (isCompat ? cSuccess : cError).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(
              isCompat ? Icons.check_circle : Icons.cancel,
              size: 22.0,
              color: isCompat ? cSuccess : cError,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('isCompatibleWith()', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                  Text(
                    'Empty config ↔ Config A: ${isCompat ? "Compatible" : "Incompatible"}',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'Two configs are compatible if absorb would not produce conflicting '
                    'boolean flag states (e.g., both setting isButton to different values).',
                    style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 6: Practical Accessibility Patterns Compendium
  // ============================================================
  print('\n=== Scene 6: Practical Accessibility Patterns ===');

  // Pattern 1: Custom semantic button
  print('Pattern 1: Custom semantic button with label + hint');
  // Pattern 2: Slider semantics
  print('Pattern 2: Slider with value + increase/decrease');
  // Pattern 3: Image with description
  print('Pattern 3: Image with semantic description');
  // Pattern 4: Live region announcement
  print('Pattern 4: Live region for status updates');
  // Pattern 5: Text field semantics
  print('Pattern 5: Read-only text field');
  // Pattern 6: Header navigation
  print('Pattern 6: Section headers for quick nav');

  Widget patternCard({
    required String patternName,
    required String description,
    required Widget visual,
    required String configCode,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 8.0, offset: Offset(0.0, 3.0)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, size: 24.0, color: color),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patternName, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color)),
                    Text(description, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          visual,
          SizedBox(height: 8.0),

          // Config snippet
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
            ),
            child: Text(
              configCode,
              style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Colors.grey.shade800, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // Pattern 1 visual: Custom button with semantic overlay
  final pattern1Visual = Semantics(
    button: true,
    enabled: true,
    label: 'Add to Cart',
    hint: 'Double-tap to add item to shopping cart',
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cSecondary, cSecondary.withValues(alpha: 0.8)],
        ),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(color: cSecondary.withValues(alpha: 0.3), blurRadius: 8.0, offset: Offset(0.0, 4.0)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_shopping_cart, color: Colors.white, size: 20.0),
          SizedBox(width: 8.0),
          Text('Add to Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0)),
        ],
      ),
    ),
  );

  // Pattern 2 visual: Slider with semantic values
  final pattern2Visual = Semantics(
    slider: true,
    value: 'Volume: 70%',
    increasedValue: 'Volume: 80%',
    decreasedValue: 'Volume: 60%',
    label: 'Volume control',
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.volume_up, color: cAccent, size: 20.0),
              SizedBox(width: 8.0),
              Text('Volume', style: TextStyle(fontSize: 12.0, color: cAccent, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 8.0),
          Stack(
            children: [
              Container(
                height: 6.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: Container(
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: cAccent,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text('70%', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cAccent)),
        ],
      ),
    ),
  );

  // Pattern 3 visual: Image with semantic description
  final pattern3Visual = Semantics(
    image: true,
    label: 'Sunset over mountain range with orange and purple sky',
    child: Container(
      height: 100.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF6B35),
            Color(0xFFE91E63),
            Color(0xFF9C27B0),
            Color(0xFF3F51B5),
            Color(0xFF1A237E),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          // Mountain silhouette
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: CustomPaint(
                size: Size(double.infinity, 50.0),
                painter: MountainPainter(),
              ),
            ),
          ),
          // ALT text overlay
          Positioned(
            bottom: 6.0,
            right: 8.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text('ALT', style: TextStyle(color: Colors.white, fontSize: 9.0, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    ),
  );

  // Pattern 4 visual: Live region
  final pattern4Visual = Semantics(
    liveRegion: true,
    label: 'Download 73% complete',
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 36.0,
            height: 36.0,
            child: CircularProgressIndicator(
              value: 0.73,
              strokeWidth: 3.0,
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Downloading file.zip', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600)),
                Text('73% complete — auto-announced by TalkBack', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text('LIVE', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.amber.shade800)),
          ),
        ],
      ),
    ),
  );

  // Pattern 5 visual: Read-only text field
  final pattern5Visual = Semantics(
    textField: true,
    readOnly: true,
    value: 'API Key: sk-...a8f2',
    label: 'API Key (read-only)',
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, size: 18.0, color: Colors.grey.shade600),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'sk-proj-abc123...a8f2',
              style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: Colors.grey.shade700),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: cDisabled.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text('READ-ONLY', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600)),
          ),
        ],
      ),
    ),
  );

  // Pattern 6 visual: Section headers for quick nav
  final pattern6Visual = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Semantics(
        header: true,
        label: 'Account Settings',
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: cPrimary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Icon(Icons.settings, size: 18.0, color: cPrimary),
              SizedBox(width: 8.0),
              Text('Account Settings', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cPrimary)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: cPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text('H1', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cPrimary)),
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 20.0, top: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: cPrimary.withValues(alpha: 0.3), width: 2.0)),
        ),
        child: Text('Profile  ·  Security  ·  Notifications', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
      ),
      SizedBox(height: 6.0),
      Semantics(
        header: true,
        label: 'Billing',
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: cAccent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Icon(Icons.payment, size: 18.0, color: cAccent),
              SizedBox(width: 8.0),
              Text('Billing', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cAccent)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: cAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text('H1', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cAccent)),
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 20.0, top: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: cAccent.withValues(alpha: 0.3), width: 2.0)),
        ),
        child: Text('Plans  ·  Invoices  ·  Payment Methods', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
      ),
    ],
  );

  final scene6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionHeader(
        'Scene 6 — Practical Accessibility Patterns',
        'Real-world patterns wired via Semantics widgets that populate SemanticsConfiguration',
        Icons.accessibility_new,
        Colors.teal,
      ),
      infoBox(
        'In practice, you rarely create SemanticsConfiguration directly — the '
        'Semantics widget does it for you. But understanding the configuration '
        'object lets you build custom render objects with precise accessibility. '
        'Each pattern below shows the visual + the config properties it sets.',
        color: Colors.teal,
      ),

      patternCard(
        patternName: 'Custom Semantic Button',
        description: 'Button with label + hint for action description',
        visual: pattern1Visual,
        configCode: 'config.isButton = true;\nconfig.isEnabled = true;\nconfig.label = "Add to Cart";\nconfig.hint = "Double-tap to add item to shopping cart";',
        icon: Icons.smart_button,
        color: cSecondary,
      ),

      patternCard(
        patternName: 'Slider with Semantic Values',
        description: 'Adjustable control announcing current/next values',
        visual: pattern2Visual,
        configCode: 'config.isSlider = true;\nconfig.value = "Volume: 70%";\nconfig.increasedValue = "Volume: 80%";\nconfig.decreasedValue = "Volume: 60%";',
        icon: Icons.tune,
        color: cAccent,
      ),

      patternCard(
        patternName: 'Image with Alt Text',
        description: 'Decorative/informational image described for screen readers',
        visual: pattern3Visual,
        configCode: 'config.isImage = true;\nconfig.label = "Sunset over mountain range\\nwith orange and purple sky";',
        icon: Icons.image,
        color: Colors.deepOrange,
      ),

      patternCard(
        patternName: 'Live Region Announcement',
        description: 'Auto-announced progress for dynamic status updates',
        visual: pattern4Visual,
        configCode: 'config.liveRegion = true;\nconfig.label = "Download 73% complete";\n// TalkBack auto-reads on change',
        icon: Icons.campaign,
        color: Colors.blue,
      ),

      patternCard(
        patternName: 'Read-Only Text Field',
        description: 'Non-editable text that screen readers identify as a field',
        visual: pattern5Visual,
        configCode: 'config.isTextField = true;\nconfig.isReadOnly = true;\nconfig.value = "sk-proj-abc123...a8f2";\nconfig.label = "API Key (read-only)";',
        icon: Icons.lock_outline,
        color: Colors.grey,
      ),

      patternCard(
        patternName: 'Section Headers for Quick Nav',
        description: 'Heading-level semantics for screen reader rotor navigation',
        visual: pattern6Visual,
        configCode: 'config.isHeader = true;\nconfig.label = "Account Settings";\n// VoiceOver heading rotor skips between these',
        icon: Icons.title,
        color: cPrimary,
      ),
    ],
  );

  // ============================================================
  // EVENT TIMELINE
  // ============================================================
  print('\n=== Build Summary ===');
  print('Scene 1: Boolean Trait Flags — 18 traits cataloged');
  print('Scene 2: Labeling & Attributed Strings — 6 axes + 2 attribute types');
  print('Scene 3: Semantic Actions Palette — 16 actions demonstrated');
  print('Scene 4: Tree Merging & Boundary — 4 scenarios visualized');
  print('Scene 5: Absorb & Copy — merge + clone + compatibility');
  print('Scene 6: Practical Patterns — 6 real-world accessibility widgets');
  print('SemanticsConfiguration Deep Demo completed');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: cPrimary,
      scaffoldBackgroundColor: cSurface,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('SemanticsConfiguration Deep Demo'),
        centerTitle: true,
        backgroundColor: cPrimary,
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cPrimary.withValues(alpha: 0.1), cSecondary.withValues(alpha: 0.06)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: cPrimary.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.accessibility, size: 36.0, color: cPrimary),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          'SemanticsConfiguration',
                          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: cPrimary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'The data payload behind every accessibility node. When a render '
                    'object calls describeSemanticsConfiguration(), it fills in this '
                    'object — labels, traits, actions, merging rules. Platform '
                    'services read it to present the UI to users with disabilities.',
                    style: TextStyle(fontSize: 13.0, height: 1.5, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 8.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: [
                      Chip(label: Text('semantics.dart'), backgroundColor: cPrimary.withValues(alpha: 0.08)),
                      Chip(label: Text('Accessibility'), backgroundColor: cSecondary.withValues(alpha: 0.08)),
                      Chip(label: Text('RenderObject'), backgroundColor: cAccent.withValues(alpha: 0.08)),
                      Chip(label: Text('TalkBack / VoiceOver'), backgroundColor: Colors.blue.withValues(alpha: 0.08)),
                    ],
                  ),
                ],
              ),
            ),

            scene1,
            scene2,
            scene3,
            scene4,
            scene5,
            scene6,

            // Footer
            SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
              ),
              child: Column(
                children: [
                  Text('End of SemanticsConfiguration Deep Demo', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600)),
                  SizedBox(height: 4.0),
                  Text(
                    '6 scenes · 18 trait flags · 16 action types · 4 tree strategies · 6 practical patterns',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ================================================================
// Mountain silhouette painter for the sunset image pattern
// ================================================================
class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF1A237E).withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(0.0, size.height * 0.6);
    path.lineTo(size.width * 0.15, size.height * 0.3);
    path.lineTo(size.width * 0.25, size.height * 0.5);
    path.lineTo(size.width * 0.4, size.height * 0.15);
    path.lineTo(size.width * 0.55, size.height * 0.45);
    path.lineTo(size.width * 0.65, size.height * 0.25);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.lineTo(size.width * 0.9, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.55);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
