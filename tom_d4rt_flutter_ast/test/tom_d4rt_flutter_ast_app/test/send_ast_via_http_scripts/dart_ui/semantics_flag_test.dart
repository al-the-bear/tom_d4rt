// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsFlag from dart:ui
// Deep Demo: Visual demonstration of accessibility semantic flags used by
// Flutter to describe widgets to TalkBack (Android) and VoiceOver (iOS).

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsFlag Deep Demo executing');

  // ============================================================
  // SECTION 1: Header & Conceptual Overview
  // ============================================================
  print('=== Section 1: Header & Concept ===');

  final header = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.indigo, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.accessibility_new, size: 56.0, color: Colors.white),
        SizedBox(height: 8.0),
        Text(
          'SemanticsFlag',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'dart:ui — Accessibility Semantics Flags',
          style: TextStyle(fontSize: 14.0, color: Colors.white70),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'TalkBack • VoiceOver • Switch Access',
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram of a SemanticsNode
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.teal.shade700),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a SemanticsNode',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _anatomyRow(
          'label',
          'Spoken text — "Submit", "Email field"',
          Colors.indigo,
        ),
        _anatomyRow(
          'value',
          'Current value — "5 of 10", "checked"',
          Colors.purple,
        ),
        _anatomyRow(
          'hint',
          'Action hint — "Double tap to activate"',
          Colors.blue,
        ),
        _anatomyRow(
          'flags',
          'Bitmask of SemanticsFlag — what the node IS',
          Colors.pink,
        ),
        _anatomyRow(
          'actions',
          'Bitmask of SemanticsAction — what it can DO',
          Colors.orange,
        ),
        _anatomyRow(
          'rect',
          'Bounding box — where to focus the cursor',
          Colors.green,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'flags answer "what kind of thing is this?" — actions answer '
            '"what can the user do?". This demo focuses on flags.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.teal.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Flag catalogue — all known SemanticsFlag values
  // ============================================================
  print('=== Section 3: Flag catalogue ===');

  // Native Dart list — bridged-safe iteration only of native lists.
  final flagCatalogue = <Map<String, dynamic>>[
    {
      'flag': ui.SemanticsFlag.hasCheckedState,
      'name': 'hasCheckedState',
      'icon': Icons.check_box_outline_blank,
      'color': Colors.indigo,
      'desc': 'Node has a tri-state checked state.',
      'example': 'Checkbox, Radio',
    },
    {
      'flag': ui.SemanticsFlag.isChecked,
      'name': 'isChecked',
      'icon': Icons.check_box,
      'color': Colors.green,
      'desc': 'Node is currently checked (true).',
      'example': 'Checkbox(value: true)',
    },
    {
      'flag': ui.SemanticsFlag.isSelected,
      'name': 'isSelected',
      'icon': Icons.radio_button_checked,
      'color': Colors.deepOrange,
      'desc': 'Node is currently selected from a set.',
      'example': 'Selected ListTile, Tab',
    },
    {
      'flag': ui.SemanticsFlag.isButton,
      'name': 'isButton',
      'icon': Icons.smart_button,
      'color': Colors.blue,
      'desc': 'Node behaves as a button (tap to activate).',
      'example': 'ElevatedButton, IconButton',
    },
    {
      'flag': ui.SemanticsFlag.isTextField,
      'name': 'isTextField',
      'icon': Icons.text_fields,
      'color': Colors.purple,
      'desc': 'Node is an editable text input.',
      'example': 'TextField, TextFormField',
    },
    {
      'flag': ui.SemanticsFlag.isFocused,
      'name': 'isFocused',
      'icon': Icons.center_focus_strong,
      'color': Colors.amber,
      'desc': 'Node currently has input focus.',
      'example': 'Focused TextField',
    },
    {
      'flag': ui.SemanticsFlag.hasEnabledState,
      'name': 'hasEnabledState',
      'icon': Icons.toggle_off,
      'color': Colors.cyan,
      'desc': 'Node can be enabled or disabled.',
      'example': 'Buttons, form fields',
    },
    {
      'flag': ui.SemanticsFlag.isEnabled,
      'name': 'isEnabled',
      'icon': Icons.power_settings_new,
      'color': Colors.lightGreen,
      'desc': 'Node is currently enabled and interactive.',
      'example': 'Enabled ElevatedButton',
    },
    {
      'flag': ui.SemanticsFlag.isInMutuallyExclusiveGroup,
      'name': 'isInMutuallyExclusiveGroup',
      'icon': Icons.group_work,
      'color': Colors.pink,
      'desc': 'One of N siblings, only one active at a time.',
      'example': 'Radio buttons in a group',
    },
    {
      'flag': ui.SemanticsFlag.isHeader,
      'name': 'isHeader',
      'icon': Icons.title,
      'color': Colors.brown,
      'desc': 'Node is a section heading (navigation).',
      'example': 'AppBar title, list section header',
    },
    {
      'flag': ui.SemanticsFlag.isObscured,
      'name': 'isObscured',
      'icon': Icons.visibility_off,
      'color': Colors.grey,
      'desc': 'Text is masked (password-style).',
      'example': 'TextField(obscureText: true)',
    },
    {
      'flag': ui.SemanticsFlag.isImage,
      'name': 'isImage',
      'icon': Icons.image,
      'color': Colors.teal,
      'desc': 'Node represents an image.',
      'example': 'Image, Icon, decoration',
    },
    {
      'flag': ui.SemanticsFlag.isLiveRegion,
      'name': 'isLiveRegion',
      'icon': Icons.broadcast_on_personal,
      'color': Colors.red,
      'desc': 'Changes should be announced to AT.',
      'example': 'Status banner, error toast',
    },
    {
      'flag': ui.SemanticsFlag.hasToggledState,
      'name': 'hasToggledState',
      'icon': Icons.toggle_on,
      'color': Colors.deepPurple,
      'desc': 'Two-state on/off (no tri-state).',
      'example': 'Switch',
    },
    {
      'flag': ui.SemanticsFlag.isToggled,
      'name': 'isToggled',
      'icon': Icons.toggle_on_outlined,
      'color': Colors.indigo,
      'desc': 'Switch-style node is currently on.',
      'example': 'Switch(value: true)',
    },
    {
      'flag': ui.SemanticsFlag.hasImplicitScrolling,
      'name': 'hasImplicitScrolling',
      'icon': Icons.swap_vert,
      'color': Colors.blueGrey,
      'desc': 'Scrollable but no explicit scroll handle.',
      'example': 'ListView, GridView',
    },
    {
      'flag': ui.SemanticsFlag.isReadOnly,
      'name': 'isReadOnly',
      'icon': Icons.lock_outline,
      'color': Colors.deepOrange,
      'desc': 'Editable widget that is currently read-only.',
      'example': 'TextField(readOnly: true)',
    },
    {
      'flag': ui.SemanticsFlag.isFocusable,
      'name': 'isFocusable',
      'icon': Icons.gps_fixed,
      'color': Colors.amber,
      'desc': 'Can receive input focus (even if not focused now).',
      'example': 'Any focusable input',
    },
    {
      'flag': ui.SemanticsFlag.isLink,
      'name': 'isLink',
      'icon': Icons.link,
      'color': Colors.blue,
      'desc': 'Behaves like a hyperlink.',
      'example': 'TextSpan with onTap',
    },
    {
      'flag': ui.SemanticsFlag.isSlider,
      'name': 'isSlider',
      'icon': Icons.tune,
      'color': Colors.purple,
      'desc': 'Continuous-value selector.',
      'example': 'Slider, RangeSlider',
    },
    {
      'flag': ui.SemanticsFlag.isKeyboardKey,
      'name': 'isKeyboardKey',
      'icon': Icons.keyboard,
      'color': Colors.brown,
      'desc': 'On-screen keyboard key.',
      'example': 'Custom soft keyboard widget',
    },
    {
      'flag': ui.SemanticsFlag.isHidden,
      'name': 'isHidden',
      'icon': Icons.visibility_off_outlined,
      'color': Colors.grey,
      'desc': 'Excluded from the accessibility tree.',
      'example': 'ExcludeSemantics, offstage',
    },
  ];

  print('Catalogue size: ${flagCatalogue.length}');
  for (final entry in flagCatalogue) {
    final flag = entry['flag'] as ui.SemanticsFlag;
    final name = entry['name'] as String;
    print('  $name -> index=${flag.index}');
  }

  final flagCards = <Widget>[];
  for (final entry in flagCatalogue) {
    final flag = entry['flag'] as ui.SemanticsFlag;
    final name = entry['name'] as String;
    final icon = entry['icon'] as IconData;
    final color = entry['color'] as Color;
    final desc = entry['desc'] as String;
    final example = entry['example'] as String;

    flagCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
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
                    color: color.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(icon, size: 22.0, color: color),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              desc,
              style: TextStyle(fontSize: 11.0, color: Colors.black87),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'index=${flag.index}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'e.g. $example',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Common widget → flag combinations
  // ============================================================
  print('=== Section 4: Widget combinations ===');

  final widgetCombinations = <Map<String, dynamic>>[
    {
      'widget': 'Checkbox(value: true)',
      'icon': Icons.check_box,
      'color': Colors.green,
      'flags': [
        'hasCheckedState',
        'isChecked',
        'hasEnabledState',
        'isEnabled',
        'isFocusable',
      ],
    },
    {
      'widget': 'Checkbox(value: false)',
      'icon': Icons.check_box_outline_blank,
      'color': Colors.grey,
      'flags': ['hasCheckedState', 'hasEnabledState', 'isEnabled', 'isFocusable'],
    },
    {
      'widget': 'Switch(value: true)',
      'icon': Icons.toggle_on,
      'color': Colors.indigo,
      'flags': [
        'hasToggledState',
        'isToggled',
        'hasEnabledState',
        'isEnabled',
        'isFocusable',
      ],
    },
    {
      'widget': 'Radio (selected)',
      'icon': Icons.radio_button_checked,
      'color': Colors.deepOrange,
      'flags': [
        'hasCheckedState',
        'isChecked',
        'isInMutuallyExclusiveGroup',
        'hasEnabledState',
        'isEnabled',
      ],
    },
    {
      'widget': 'TextField',
      'icon': Icons.text_fields,
      'color': Colors.purple,
      'flags': ['isTextField', 'isFocusable', 'hasEnabledState', 'isEnabled'],
    },
    {
      'widget': 'TextField(obscureText: true)',
      'icon': Icons.password,
      'color': Colors.deepPurple,
      'flags': [
        'isTextField',
        'isObscured',
        'isFocusable',
        'hasEnabledState',
        'isEnabled',
      ],
    },
    {
      'widget': 'ElevatedButton',
      'icon': Icons.smart_button,
      'color': Colors.blue,
      'flags': ['isButton', 'hasEnabledState', 'isEnabled', 'isFocusable'],
    },
    {
      'widget': 'Slider',
      'icon': Icons.tune,
      'color': Colors.pink,
      'flags': ['isSlider', 'hasEnabledState', 'isEnabled', 'isFocusable'],
    },
    {
      'widget': 'Image / Icon',
      'icon': Icons.image,
      'color': Colors.teal,
      'flags': ['isImage'],
    },
    {
      'widget': 'AppBar title',
      'icon': Icons.title,
      'color': Colors.brown,
      'flags': ['isHeader'],
    },
    {
      'widget': 'ListView',
      'icon': Icons.view_list,
      'color': Colors.blueGrey,
      'flags': ['hasImplicitScrolling'],
    },
    {
      'widget': 'TextSpan link',
      'icon': Icons.link,
      'color': Colors.indigo,
      'flags': ['isLink', 'isFocusable'],
    },
  ];

  final combinationCards = <Widget>[];
  for (final entry in widgetCombinations) {
    final widgetName = entry['widget'] as String;
    final icon = entry['icon'] as IconData;
    final color = entry['color'] as Color;
    final flags = entry['flags'] as List<dynamic>;

    final chips = <Widget>[];
    for (final f in flags) {
      chips.add(
        Container(
          margin: EdgeInsets.only(right: 4.0, bottom: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Text(
            f as String,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: color,
            ),
          ),
        ),
      );
    }

    combinationCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    widgetName,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Wrap(children: chips),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Screen reader announcement simulator
  // ============================================================
  print('=== Section 5: Screen reader simulator ===');

  final announcements = <Map<String, dynamic>>[
    {
      'label': 'Accept Terms',
      'flags': 'isButton + hasCheckedState + isChecked',
      'spoken': '"Accept Terms, checkbox, checked. Double tap to toggle."',
      'icon': Icons.check_box,
      'color': Colors.green,
    },
    {
      'label': 'Email',
      'flags': 'isTextField + isFocused',
      'spoken': '"Email, edit box, editing. Type to enter text."',
      'icon': Icons.text_fields,
      'color': Colors.purple,
    },
    {
      'label': 'Password',
      'flags': 'isTextField + isObscured',
      'spoken': '"Password, edit box, secure."',
      'icon': Icons.password,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Wi-Fi',
      'flags': 'hasToggledState + isToggled',
      'spoken': '"Wi-Fi, switch, on. Double tap to turn off."',
      'icon': Icons.wifi,
      'color': Colors.indigo,
    },
    {
      'label': 'Settings',
      'flags': 'isHeader',
      'spoken': '"Settings, heading."',
      'icon': Icons.title,
      'color': Colors.brown,
    },
    {
      'label': 'Volume',
      'flags': 'isSlider',
      'spoken': '"Volume, slider, 50 percent. Swipe up or down to adjust."',
      'icon': Icons.tune,
      'color': Colors.pink,
    },
    {
      'label': 'Save',
      'flags': 'isButton + isEnabled',
      'spoken': '"Save, button. Double tap to activate."',
      'icon': Icons.save,
      'color': Colors.blue,
    },
    {
      'label': 'Documentation',
      'flags': 'isLink',
      'spoken': '"Documentation, link. Double tap to open."',
      'icon': Icons.link,
      'color': Colors.cyan,
    },
  ];

  final announcementCards = <Widget>[];
  for (final ann in announcements) {
    final label = ann['label'] as String;
    final flags = ann['flags'] as String;
    final spoken = ann['spoken'] as String;
    final icon = ann['icon'] as IconData;
    final color = ann['color'] as Color;

    announcementCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade900,
              color.withValues(alpha: 0.5),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.record_voice_over, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: Colors.white, size: 16.0),
                      SizedBox(width: 6.0),
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    flags,
                    style: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    spoken,
                    style: TextStyle(
                      color: Colors.amber.shade200,
                      fontStyle: FontStyle.italic,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Live Semantics example
  // ============================================================
  print('=== Section 6: Live Semantics widget ===');

  final liveSemantics = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.fact_check, color: Colors.green.shade800),
            SizedBox(width: 8.0),
            Text(
              'Live Semantics widget',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Below is an actual Semantics(...) widget — its bool properties '
          'translate to SemanticsFlag bits in the rendered node:',
          style: TextStyle(fontSize: 12.0, color: Colors.green.shade900),
        ),
        SizedBox(height: 14.0),
        Semantics(
          label: 'Confirm purchase',
          hint: 'Activates secure checkout',
          button: true,
          enabled: true,
          focusable: true,
          container: true,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade600, Colors.teal.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.35),
                  blurRadius: 8.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock, color: Colors.white, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'Confirm purchase',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Semantics(
          label: 'Notifications',
          toggled: true,
          enabled: true,
          child: Row(
            children: [
              Icon(Icons.notifications_active, color: Colors.green.shade700),
              SizedBox(width: 8.0),
              Text(
                'Notifications: ON',
                style: TextStyle(color: Colors.green.shade900),
              ),
              SizedBox(width: 12.0),
              Switch(value: true, onChanged: null),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Semantics(
          header: true,
          child: Text(
            'Account',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Semantics(
          link: true,
          label: 'Open documentation',
          child: Text(
            'docs.flutter.dev',
            style: TextStyle(
              color: Colors.blue.shade700,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Bitmask diagram
  // ============================================================
  print('=== Section 7: Bitmask diagram ===');

  // Compose a virtual bitmask string for "Checkbox(value: true)"
  final bitFlags = <Map<String, dynamic>>[
    {
      'flag': ui.SemanticsFlag.hasCheckedState,
      'name': 'hasCheckedState',
      'on': true,
    },
    {'flag': ui.SemanticsFlag.isChecked, 'name': 'isChecked', 'on': true},
    {
      'flag': ui.SemanticsFlag.hasEnabledState,
      'name': 'hasEnabledState',
      'on': true,
    },
    {'flag': ui.SemanticsFlag.isEnabled, 'name': 'isEnabled', 'on': true},
    {'flag': ui.SemanticsFlag.isFocusable, 'name': 'isFocusable', 'on': true},
    {'flag': ui.SemanticsFlag.isButton, 'name': 'isButton', 'on': false},
    {'flag': ui.SemanticsFlag.isTextField, 'name': 'isTextField', 'on': false},
    {'flag': ui.SemanticsFlag.isImage, 'name': 'isImage', 'on': false},
    {'flag': ui.SemanticsFlag.isHeader, 'name': 'isHeader', 'on': false},
    {'flag': ui.SemanticsFlag.isLink, 'name': 'isLink', 'on': false},
  ];

  final bitRows = <Widget>[];
  for (final b in bitFlags) {
    final flag = b['flag'] as ui.SemanticsFlag;
    final name = b['name'] as String;
    final on = b['on'] as bool;
    final color = on ? Colors.green : Colors.grey;

    bitRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: on
              ? Colors.green.withValues(alpha: 0.12)
              : Colors.grey.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                on ? '1' : '0',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: on ? Colors.green.shade900 : Colors.grey.shade700,
                  fontWeight: on ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Text(
              'idx ${flag.index}',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade600,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  final bitmaskDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: Colors.indigo.shade700),
            SizedBox(width: 8.0),
            Text(
              'Conceptual bitmask — Checkbox(value: true)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...bitRows,
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Each SemanticsFlag.index identifies a single bit. The framework '
            'OR-combines them when building the SemanticsNode.',
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.indigo.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Accessibility checklist
  // ============================================================
  print('=== Section 8: Accessibility checklist ===');

  final checklistItems = [
    'Wrap clickable Containers with Semantics(button: true) when not using a Button widget.',
    'Provide a meaningful label — never rely solely on icons.',
    'Use Semantics(header: true) for section titles to enable navigation.',
    'For decorative-only images, prefer ExcludeSemantics over leaving them announced.',
    'For password fields, set obscureText: true so isObscured is announced.',
    'Use Semantics(liveRegion: true) for transient status updates (toasts, errors).',
    'Group radio buttons so isInMutuallyExclusiveGroup is set automatically.',
    'For custom toggles, mirror Switch via toggled + enabled, not checked.',
    'Test with TalkBack (Android) and VoiceOver (iOS) — emulators differ subtly.',
    'Avoid duplicate semantics: MergeSemantics combines siblings into one node.',
  ];

  final checklistWidgets = <Widget>[];
  for (var i = 0; i < checklistItems.length; i++) {
    final text = checklistItems[i];
    final color = i.isEven ? Colors.teal : Colors.indigo;
    checklistWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: color, width: 4.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22.0,
              height: 22.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final checklist = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade400, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, color: Colors.amber.shade800),
            SizedBox(width: 8.0),
            Text(
              'Accessibility checklist',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...checklistWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final footguns = [
    {
      'title': 'Flag without label',
      'detail':
          'Setting button: true but no label means screen readers say only '
              '"button". Always pair with a label.',
      'icon': Icons.warning_amber,
      'color': Colors.red,
    },
    {
      'title': 'Confusing flags vs actions',
      'detail':
          'isButton describes the node — onTap registers a SemanticsAction. '
              'You typically need both for tappable widgets.',
      'icon': Icons.compare_arrows,
      'color': Colors.orange,
    },
    {
      'title': 'Stacking redundant flags',
      'detail':
          'Wrapping a Checkbox in Semantics(checked: true) duplicates state '
              'tracking. Prefer the inner widget unless overriding.',
      'icon': Icons.layers_clear,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Hiding interactive nodes',
      'detail':
          'Using ExcludeSemantics on a button removes it from the AT tree. '
              'Use only for purely decorative widgets.',
      'icon': Icons.visibility_off,
      'color': Colors.purple,
    },
    {
      'title': 'Toggle vs Check confusion',
      'detail':
          'Switch → hasToggledState/isToggled. Checkbox → '
              'hasCheckedState/isChecked. Mixing them confuses users.',
      'icon': Icons.swap_horiz,
      'color': Colors.indigo,
    },
  ];

  final footgunWidgets = <Widget>[];
  for (final fg in footguns) {
    final title = fg['title'] as String;
    final detail = fg['detail'] as String;
    final icon = fg['icon'] as IconData;
    final color = fg['color'] as Color;

    footgunWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 26.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    detail,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 10: Code samples
  // ============================================================
  print('=== Section 10: Code samples ===');

  final codeSamples = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300),
            SizedBox(width: 8.0),
            Text(
              'Usage examples',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// Manual button semantics on a custom widget\n'
          'Semantics(\n'
          '  label: "Submit form",\n'
          '  hint: "Sends the data",\n'
          '  button: true,\n'
          '  enabled: true,\n'
          '  child: GestureDetector(...),\n'
          ');',
          Colors.lightBlue.shade200,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Custom switch — use toggled, not checked\n'
          'Semantics(\n'
          '  label: "Dark mode",\n'
          '  toggled: darkMode,\n'
          '  enabled: true,\n'
          '  child: ...,\n'
          ');',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Section heading\n'
          'Semantics(\n'
          '  header: true,\n'
          '  child: Text("Settings"),\n'
          ');',
          Colors.amberAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Inspect a flag from dart:ui\n'
          'final flag = SemanticsFlag.isButton;\n'
          'print(flag.index);\n'
          'print(SemanticsFlag.values.length);',
          Colors.pinkAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Stats footer
  // ============================================================
  print('=== Section 11: Stats footer ===');

  final stats = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade400, Colors.purple.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statCell('${flagCatalogue.length}', 'flags shown', Icons.label),
        _statCell(
          '${ui.SemanticsFlag.values.length}',
          'in dart:ui',
          Icons.flag,
        ),
        _statCell(
          '${widgetCombinations.length}',
          'combos',
          Icons.merge_type,
        ),
        _statCell('${announcements.length}', 'spoken', Icons.record_voice_over),
      ],
    ),
  );

  print('SemanticsFlag Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          SizedBox(height: 24.0),
          Text(
            '1. Anatomy of a SemanticsNode',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          anatomy,
          SizedBox(height: 24.0),
          Text(
            '2. Flag catalogue',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.center, children: flagCards),
          SizedBox(height: 24.0),
          Text(
            '3. Common widget → flag combinations',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.center, children: combinationCards),
          SizedBox(height: 24.0),
          Text(
            '4. Screen-reader announcement simulator',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          ...announcementCards,
          SizedBox(height: 24.0),
          Text(
            '5. Live Semantics widget',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          liveSemantics,
          SizedBox(height: 24.0),
          Text(
            '6. Conceptual bitmask',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          bitmaskDiagram,
          SizedBox(height: 24.0),
          Text(
            '7. Accessibility checklist',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          checklist,
          SizedBox(height: 24.0),
          Text(
            '8. Footguns',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          ...footgunWidgets,
          SizedBox(height: 24.0),
          Text(
            '9. Code samples',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          codeSamples,
          SizedBox(height: 24.0),
          Text(
            '10. Stats',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          stats,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// Helper: anatomy row
Widget _anatomyRow(String field, String desc, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6.0),
      border: Border(left: BorderSide(color: color, width: 3.0)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            field,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 12.0, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

// Helper: stat cell
Widget _statCell(String value, String label, IconData icon) {
  return Column(
    children: [
      Icon(icon, color: Colors.white, size: 26.0),
      SizedBox(height: 4.0),
      Text(
        value,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        label,
        style: TextStyle(color: Colors.white70, fontSize: 11.0),
      ),
    ],
  );
}

// Helper: code block
Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}
