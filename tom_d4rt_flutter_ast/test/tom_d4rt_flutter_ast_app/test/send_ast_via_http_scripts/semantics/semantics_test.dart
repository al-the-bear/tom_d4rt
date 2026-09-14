// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Semantics widget from widgets/basic.dart
// Deep Demo: Visual exploration of the Semantics widget — the primary way to
// annotate Flutter widget trees with accessibility information.
//
// The Semantics widget wraps any child and attaches metadata that assistive
// technologies (TalkBack on Android, VoiceOver on iOS/macOS) use to describe
// the UI to users with visual, motor, or cognitive impairments. It is the
// bridge between visual Flutter widgets and the platform accessibility layer.
//
// Unlike SemanticsConfiguration (the raw data bag), this widget integrates
// seamlessly into the widget tree, passing properties through the standard
// build/layout pipeline.
//
// Scene 1 — Label Gallery: all text annotation properties
// Scene 2 — Trait Flags Showcase: boolean property effects
// Scene 3 — Container vs Non-Container Semantics
// Scene 4 — MergeSemantics & ExcludeSemantics companion widgets
// Scene 5 — Semantic Actions Workshop: interactive callbacks
// Scene 6 — Real-World Accessibility Patterns compendium
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('Semantics Widget Deep Demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────────────────
  // Color palette — teal/indigo accessibility-themed
  // ──────────────────────────────────────────────────────────
  const cPrimary = Color(0xFF00695C);      // deep teal
  const cSecondary = Color(0xFF283593);    // deep indigo
  const cSurface = Color(0xFFE0F2F1);      // teal-tinted surface
  const cAccent = Color(0xFFE65100);       // burnt orange accent
  const cSuccess = Color(0xFF2E7D32);      // green
  const cWarning = Color(0xFFF9A825);      // amber
  const cError = Color(0xFFC62828);        // red
  const cMuted = Color(0xFF78909C);        // blue-grey muted

  // ──────────────────────────────────────────────────────────
  // Helper builders — unique to this demo
  // ──────────────────────────────────────────────────────────

  Widget sceneHeader(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30.0, bottom: 14.0),
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.18), color.withValues(alpha: 0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28.0, color: color),
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: color)),
                SizedBox(height: 2.0),
                Text(subtitle, style: TextStyle(fontSize: 11.0, color: color.withValues(alpha: 0.65))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget explanationBox(String text, {Color color = const Color(0xFF37474F)}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: color.withValues(alpha: 0.4), width: 3.0)),
      ),
      child: Text(text, style: TextStyle(fontSize: 12.0, height: 1.55, color: color.withValues(alpha: 0.85))),
    );
  }

  // ============================================================
  // SCENE 1: Label Gallery — all text annotation properties
  // ============================================================
  print('\n=== Scene 1: Label Gallery ===');

  // Demonstrate each labeling property with a live Semantics widget
  print('Creating Semantics with label, hint, value, tooltip...');

  Widget labelDemo(String propName, String propValue, IconData icon, Color color, String explanation, Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 8.0, offset: Offset(0.0, 3.0))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22.0, color: color),
              SizedBox(width: 10.0),
              Text(propName, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: color)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text('"$propValue"', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: color)),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(explanation, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600, height: 1.3)),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color.withValues(alpha: 0.12)),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  // 1a. label — identity text
  final labelWidget = Semantics(
    label: 'Shopping cart with 3 items',
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: cPrimary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart, color: cPrimary, size: 28.0),
          SizedBox(width: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: cAccent,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text('3', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ),
  );
  print('  label: "Shopping cart with 3 items"');

  // 1b. hint — instruction for the user
  final hintWidget = Semantics(
    hint: 'Double-tap to open settings menu',
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cSecondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.settings, color: cSecondary, size: 24.0),
          SizedBox(width: 8.0),
          Text('Settings', style: TextStyle(color: cSecondary, fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
  print('  hint: "Double-tap to open settings menu"');

  // 1c. value — current state
  final valueWidget = Semantics(
    value: 'Brightness: 75%',
    label: 'Brightness slider',
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cWarning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.brightness_6, color: cWarning, size: 22.0),
              SizedBox(width: 8.0),
              Text('Brightness', style: TextStyle(color: Colors.grey.shade800, fontSize: 13.0)),
              Spacer(),
              Text('75%', style: TextStyle(color: cWarning, fontWeight: FontWeight.bold, fontSize: 14.0)),
            ],
          ),
          SizedBox(height: 8.0),
          Stack(
            children: [
              Container(
                height: 6.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cWarning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.75,
                child: Container(
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: cWarning,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  print('  value: "Brightness: 75%"');

  // 1d. increasedValue / decreasedValue
  final incDecWidget = Semantics(
    value: 'Quantity: 4',
    increasedValue: 'Quantity: 5',
    decreasedValue: 'Quantity: 3',
    label: 'Item quantity',
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cSuccess.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: cSuccess.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Icon(Icons.remove, color: cSuccess, size: 18.0),
          ),
          SizedBox(width: 16.0),
          Column(
            children: [
              Text('Quantity', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
              Text('4', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: cSuccess)),
            ],
          ),
          SizedBox(width: 16.0),
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: cSuccess.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Icon(Icons.add, color: cSuccess, size: 18.0),
          ),
        ],
      ),
    ),
  );
  print('  increasedValue: "Quantity: 5", decreasedValue: "Quantity: 3"');

  // 1e. tooltip
  final tooltipWidget = Semantics(
    tooltip: 'Compose a new email message',
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: Icon(Icons.edit, color: cAccent, size: 26.0),
    ),
  );
  print('  tooltip: "Compose a new email message"');

  // 1f. textDirection
  final rtlWidget = Semantics(
    label: 'مرحبا بك في التطبيق',
    textDirection: TextDirection.rtl,
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cMuted.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('مرحبا بك في التطبيق', style: TextStyle(fontSize: 14.0, color: cMuted)),
          SizedBox(width: 8.0),
          Icon(Icons.language, color: cMuted, size: 22.0),
        ],
      ),
    ),
  );
  print('  textDirection: RTL with Arabic label');

  final scene1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 1 — Label Gallery',
        'Every text annotation property the Semantics widget exposes',
        Icons.text_snippet,
        cPrimary,
      ),
      explanationBox(
        'The Semantics widget has SIX text axes that assistive services read:\n'
        '• label — identity (WHAT the element is)\n'
        '• hint — instruction (HOW to interact)\n'
        '• value — current state (what it currently shows)\n'
        '• increasedValue / decreasedValue — what changes on adjust gestures\n'
        '• tooltip — supplementary context on hover/long-focus\n'
        '• textDirection — reading direction for the labels',
        color: cPrimary,
      ),
      labelDemo('label', 'Shopping cart with 3 items', Icons.label, cPrimary,
          'The primary identity. Screen readers announce this first — it names the element.',
          labelWidget),
      labelDemo('hint', 'Double-tap to open settings menu', Icons.info_outline, cSecondary,
          'Action instruction appended after the label. Tells the user HOW to interact.',
          hintWidget),
      labelDemo('value', 'Brightness: 75%', Icons.data_object, cWarning,
          'Current state of an adjustable control. Updated as the user changes the slider.',
          valueWidget),
      labelDemo('increased/decreased', 'Qty: 5 / Qty: 3', Icons.swap_vert, cSuccess,
          'What the value becomes after increase (swipe up) or decrease (swipe down) gestures.',
          incDecWidget),
      labelDemo('tooltip', 'Compose a new email message', Icons.chat_bubble_outline, cAccent,
          'Supplementary text shown on hover or long-focus. Adds context beyond the label.',
          tooltipWidget),
      labelDemo('textDirection', 'RTL: Arabic label', Icons.format_textdirection_r_to_l, cMuted,
          'Controls reading direction. Essential for RTL languages (Arabic, Hebrew, Urdu).',
          rtlWidget),
    ],
  );

  // ============================================================
  // SCENE 2: Trait Flags Showcase
  // ============================================================
  print('\n=== Scene 2: Trait Flags Showcase ===');

  Widget traitTile({
    required String name,
    required bool isActive,
    required IconData icon,
    required Color color,
    required String whenTrue,
    required String whenFalse,
    required Widget example,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: isActive ? color.withValues(alpha: 0.04) : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isActive ? color.withValues(alpha: 0.4) : Colors.grey.withValues(alpha: 0.15),
          width: isActive ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          // Status indicator strip
          Container(
            width: 5.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: isActive ? color : Colors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
            ),
          ),
          SizedBox(width: 12.0),
          // Info column
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 18.0, color: isActive ? color : cMuted),
                      SizedBox(width: 6.0),
                      Text(name, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: isActive ? color : cMuted)),
                      SizedBox(width: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: (isActive ? cSuccess : cMuted).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          isActive ? 'ACTIVE' : 'OFF',
                          style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: isActive ? cSuccess : cMuted),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    isActive ? whenTrue : whenFalse,
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, height: 1.3),
                  ),
                ],
              ),
            ),
          ),
          // Live example
          Container(
            margin: EdgeInsets.only(right: 12.0),
            child: example,
          ),
        ],
      ),
    );
  }

  // button trait
  final buttonSem = Semantics(
    button: true,
    enabled: true,
    label: 'Save',
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      decoration: BoxDecoration(color: cPrimary, borderRadius: BorderRadius.circular(8.0)),
      child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.bold)),
    ),
  );
  print('  button=true: Save button');

  // link trait
  final linkSem = Semantics(
    link: true,
    label: 'Privacy Policy',
    child: Text('Privacy Policy', style: TextStyle(color: cSecondary, decoration: TextDecoration.underline, fontSize: 11.0)),
  );
  print('  link=true: Privacy Policy');

  // header trait
  final headerSem = Semantics(
    header: true,
    label: 'Settings',
    child: Text('Settings', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
  );
  print('  header=true: Settings heading');

  // image trait
  final imageSem = Semantics(
    image: true,
    label: 'Mountain landscape',
    child: Container(
      width: 60.0,
      height: 40.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFFE65100)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
    ),
  );
  print('  image=true: Mountain landscape');

  // slider trait
  final sliderSem = Semantics(
    slider: true,
    value: '50%',
    label: 'Volume',
    child: Container(
      width: 70.0,
      child: Stack(
        children: [
          Container(height: 4.0, width: 70.0, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.0))),
          Container(height: 4.0, width: 35.0, decoration: BoxDecoration(color: cAccent, borderRadius: BorderRadius.circular(2.0))),
        ],
      ),
    ),
  );
  print('  slider=true: Volume 50%');

  // textField trait
  final textFieldSem = Semantics(
    textField: true,
    label: 'Email',
    value: 'user@example.com',
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text('user@...', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade700)),
    ),
  );
  print('  textField=true: Email input');

  // enabled/disabled
  final disabledSem = Semantics(
    button: true,
    enabled: false,
    label: 'Submit (Disabled)',
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8.0)),
      child: Text('Submit', style: TextStyle(color: Colors.grey.shade500, fontSize: 11.0)),
    ),
  );
  print('  enabled=false: Disabled submit');

  // selected
  final selectedSem = Semantics(
    selected: true,
    label: 'Home tab selected',
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: cPrimary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cPrimary, width: 2.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.home, size: 16.0, color: cPrimary),
          SizedBox(width: 4.0),
          Text('Home', style: TextStyle(fontSize: 11.0, color: cPrimary, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
  print('  selected=true: Home tab');

  // checked
  final checkedSem = Semantics(
    checked: true,
    label: 'Enable notifications',
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_box, size: 20.0, color: cSuccess),
        SizedBox(width: 4.0),
        Text('Notif.', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700)),
      ],
    ),
  );
  print('  checked=true: Notifications checkbox');

  // toggled
  final toggledSem = Semantics(
    toggled: true,
    label: 'Dark mode on',
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.dark_mode, size: 16.0, color: cSecondary),
        SizedBox(width: 4.0),
        Container(
          width: 32.0,
          height: 18.0,
          decoration: BoxDecoration(color: cSecondary, borderRadius: BorderRadius.circular(9.0)),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(2.0),
          child: Container(width: 14.0, height: 14.0, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
        ),
      ],
    ),
  );
  print('  toggled=true: Dark mode switch');

  // hidden
  final hiddenSem = Semantics(
    hidden: true,
    child: Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Icon(Icons.visibility_off, size: 18.0, color: Colors.grey.shade400),
    ),
  );
  print('  hidden=true: Hidden decorative element');

  // readOnly
  final readOnlySem = Semantics(
    readOnly: true,
    textField: true,
    value: 'API-KEY-123',
    label: 'API Key',
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock, size: 12.0, color: Colors.grey.shade500),
          SizedBox(width: 4.0),
          Text('API-...', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade600)),
        ],
      ),
    ),
  );
  print('  readOnly=true: Locked API key field');

  // liveRegion
  final liveSem = Semantics(
    liveRegion: true,
    label: '3 new messages',
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: cError.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: cError.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.campaign, size: 14.0, color: cError),
          SizedBox(width: 4.0),
          Text('3 new', style: TextStyle(fontSize: 10.0, color: cError, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
  print('  liveRegion=true: Message notification');

  final scene2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 2 — Trait Flags Showcase',
        'Boolean properties that tell assistive tech WHAT kind of element this is',
        Icons.flag,
        cSecondary,
      ),
      explanationBox(
        'The Semantics widget exposes boolean constructor parameters that map to '
        'accessibility roles and states. Each flag changes how a screen reader '
        'announces the element. A button gets "button" appended, a header enables '
        'heading navigation, a liveRegion auto-announces on change.\n\n'
        'These flags correspond to SemanticsConfiguration properties internally — '
        'the Semantics widget is simply the convenience wrapper.',
        color: cSecondary,
      ),

      traitTile(name: 'button', isActive: true, icon: Icons.smart_button, color: cPrimary,
          whenTrue: 'Announced as "button". Enables double-tap to activate.',
          whenFalse: 'No button role. Standard navigation element.',
          example: buttonSem),
      traitTile(name: 'link', isActive: true, icon: Icons.link, color: cSecondary,
          whenTrue: 'Announced as "link". Screen readers group links for quick nav.',
          whenFalse: 'Standard text element without link role.',
          example: linkSem),
      traitTile(name: 'header', isActive: true, icon: Icons.title, color: Colors.brown,
          whenTrue: 'Announced as "heading". VoiceOver rotor lists it for quick jump.',
          whenFalse: 'Normal text — not treated as navigation landmark.',
          example: headerSem),
      traitTile(name: 'image', isActive: true, icon: Icons.image, color: cAccent,
          whenTrue: 'Announced as "image". label becomes ALT text.',
          whenFalse: 'Decorative node — may be ignored if no label.',
          example: imageSem),
      traitTile(name: 'slider', isActive: true, icon: Icons.tune, color: cAccent,
          whenTrue: 'Adjustable control. Enables swipe up/down gestures.',
          whenFalse: 'Static display — no adjustment actions available.',
          example: sliderSem),
      traitTile(name: 'textField', isActive: true, icon: Icons.text_fields, color: Colors.teal,
          whenTrue: 'Announced as "text field". Enables keyboard input actions.',
          whenFalse: 'Not an input — cannot receive text entry.',
          example: textFieldSem),
      traitTile(name: 'enabled', isActive: false, icon: Icons.block, color: cMuted,
          whenTrue: 'Control is interactive. All actions available.',
          whenFalse: 'Disabled — announced as "dimmed". Actions blocked.',
          example: disabledSem),
      traitTile(name: 'selected', isActive: true, icon: Icons.check_circle, color: cPrimary,
          whenTrue: 'Announced as "selected". Used for tabs, chips, list items.',
          whenFalse: 'Not selected — normal traversal.',
          example: selectedSem),
      traitTile(name: 'checked', isActive: true, icon: Icons.check_box, color: cSuccess,
          whenTrue: 'Announced as "checked". For checkboxes and toggle buttons.',
          whenFalse: 'Unchecked or not applicable.',
          example: checkedSem),
      traitTile(name: 'toggled', isActive: true, icon: Icons.toggle_on, color: cSecondary,
          whenTrue: 'Switch is ON. Announced as "on" for switches.',
          whenFalse: 'Switch is OFF. Announced as "off".',
          example: toggledSem),
      traitTile(name: 'hidden', isActive: true, icon: Icons.visibility_off, color: cMuted,
          whenTrue: 'Invisible to screen readers. Completely excluded from tree.',
          whenFalse: 'Visible in accessibility tree.',
          example: hiddenSem),
      traitTile(name: 'readOnly', isActive: true, icon: Icons.lock, color: Colors.blueGrey,
          whenTrue: 'Content readable but not editable. No keyboard input.',
          whenFalse: 'Editable text — keyboard and dictation actions available.',
          example: readOnlySem),
      traitTile(name: 'liveRegion', isActive: true, icon: Icons.campaign, color: cError,
          whenTrue: 'Auto-announced on change. For toasts, progress, notifications.',
          whenFalse: 'Silent — changes not auto-announced.',
          example: liveSem),
    ],
  );

  // ============================================================
  // SCENE 3: Container vs Non-Container Semantics
  // ============================================================
  print('\n=== Scene 3: Container vs Non-Container ===');

  // container: false (default) — merges label upward
  final nonContainerExample = Semantics(
    label: 'Favorite star icon',
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          label: 'Star',
          child: Icon(Icons.star, color: cWarning, size: 22.0),
        ),
        SizedBox(width: 6.0),
        Semantics(
          label: 'Favorite',
          child: Text('Favorite', style: TextStyle(fontSize: 13.0)),
        ),
        SizedBox(width: 6.0),
        Semantics(
          label: '(12)',
          child: Text('(12)', style: TextStyle(fontSize: 11.0, color: Colors.grey)),
        ),
      ],
    ),
  );
  print('  Non-container: labels merge into parent → "Favorite star icon, Star, Favorite, (12)"');

  // container: true — creates a boundary
  final containerExample = Semantics(
    container: true,
    label: 'Favorite action',
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          container: true,
          label: 'Star icon',
          child: Icon(Icons.star, color: cWarning, size: 22.0),
        ),
        SizedBox(width: 6.0),
        Semantics(
          container: true,
          label: 'Favorite label',
          child: Text('Favorite', style: TextStyle(fontSize: 13.0)),
        ),
        SizedBox(width: 6.0),
        Semantics(
          container: true,
          label: 'Count: 12',
          child: Text('(12)', style: TextStyle(fontSize: 11.0, color: Colors.grey)),
        ),
      ],
    ),
  );
  print('  Container: each child is a separate focus target');

  // explicitChildNodes
  final explicitChildExample = Semantics(
    explicitChildNodes: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(label: 'Apple', child: Padding(padding: EdgeInsets.all(4.0), child: Text('🍎 Apple', style: TextStyle(fontSize: 12.0)))),
        Semantics(label: 'Banana', child: Padding(padding: EdgeInsets.all(4.0), child: Text('🍌 Banana', style: TextStyle(fontSize: 12.0)))),
        Semantics(label: 'Cherry', child: Padding(padding: EdgeInsets.all(4.0), child: Text('🍒 Cherry', style: TextStyle(fontSize: 12.0)))),
      ],
    ),
  );
  print('  explicitChildNodes: each child navigated independently');

  Widget containerScenario(String title, String description, Widget visual, Color color, String result, IconData icon) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.0, color: color),
              SizedBox(width: 8.0),
              Expanded(child: Text(title, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color))),
            ],
          ),
          SizedBox(height: 4.0),
          Text(description, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600, height: 1.3)),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color.withValues(alpha: 0.1)),
            ),
            child: visual,
          ),
          SizedBox(height: 8.0),
          // Result line
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.record_voice_over, size: 14.0, color: color),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(result, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: color, height: 1.3)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final scene3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 3 — Container vs Non-Container',
        'How the container property controls semantics node boundaries',
        Icons.border_all,
        Colors.deepPurple,
      ),
      explanationBox(
        'When container: false (default), labels from Semantics widgets merge '
        'upward into the nearest ancestor boundary — screen readers read them as '
        'one chunk. When container: true, the Semantics widget creates its own '
        'semantics node, making it a separate focus target.\n\n'
        'explicitChildNodes: true forces each child to appear independently '
        'in the accessibility tree, even without explicit containers.',
        color: Colors.deepPurple,
      ),

      containerScenario(
        'Non-Container (Default)',
        'Labels from all Semantics widgets merge upward. The screen reader reads '
        'the entire group as a single, concatenated announcement.',
        nonContainerExample,
        Colors.deepPurple,
        'Screen reader: "Favorite star icon, Star, Favorite, (12)" → 1 focus stop',
        Icons.merge,
      ),

      containerScenario(
        'Container = true',
        'Each Semantics(container: true) creates a boundary. The screen reader '
        'focuses on each child separately, allowing detailed navigation.',
        containerExample,
        cPrimary,
        'Screen reader: [Star icon] → [Favorite label] → [Count: 12] → 3 focus stops',
        Icons.view_module,
      ),

      containerScenario(
        'Explicit Child Nodes',
        'explicitChildNodes: true preserves each child as an independent semantics '
        'node. Ideal for scrollable lists where each item is a focus target.',
        explicitChildExample,
        cAccent,
        'Screen reader: [Apple] → [Banana] → [Cherry] → 3 focus stops',
        Icons.list,
      ),

      // Visual comparison diagram
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Decision Guide', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.merge, size: 20.0, color: Colors.deepPurple),
                        SizedBox(height: 4.0),
                        Text('No container', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                        Text('Group reads as one unit', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: cPrimary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.view_module, size: 20.0, color: cPrimary),
                        SizedBox(height: 4.0),
                        Text('container: true', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cPrimary)),
                        Text('Each child focused separately', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: cAccent.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.list, size: 20.0, color: cAccent),
                        SizedBox(height: 4.0),
                        Text('explicitChildNodes', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cAccent)),
                        Text('All children are nodes', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 4: MergeSemantics & ExcludeSemantics
  // ============================================================
  print('\n=== Scene 4: MergeSemantics & ExcludeSemantics ===');

  // MergeSemantics — combines children into one node
  final mergeExample = MergeSemantics(
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cPrimary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: cPrimary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.wifi, color: cPrimary, size: 24.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Wi-Fi', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)),
                Text('Connected to HomeNetwork', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    ),
  );
  print('  MergeSemantics: Wi-Fi + "Connected" → merged into one');

  // Without merge — children separate
  final unmergedExample = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        Semantics(label: 'Wi-Fi icon', child: Icon(Icons.wifi, color: cMuted, size: 24.0)),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(label: 'Wi-Fi', child: Text('Wi-Fi', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: cMuted))),
              Semantics(label: 'Connected to HomeNetwork', child: Text('Connected to HomeNetwork', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500))),
            ],
          ),
        ),
        Semantics(label: 'Navigate to Wi-Fi settings', child: Icon(Icons.chevron_right, color: Colors.grey.shade400)),
      ],
    ),
  );
  print('  Without merge: 4 separate focus targets');

  // ExcludeSemantics — hiding decorative content
  final excludeExample = Row(
    children: [
      ExcludeSemantics(
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: cWarning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(Icons.star, color: cWarning, size: 28.0),
        ),
      ),
      SizedBox(width: 12.0),
      Semantics(
        label: 'Premium member, gold star badge',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Premium Member', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
            Text('Gold star badge', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
          ],
        ),
      ),
    ],
  );
  print('  ExcludeSemantics: Star icon excluded — label carries description');

  // ExcludeSemantics on decorative divider
  final decorativeExclude = Column(
    children: [
      Semantics(label: 'Section A content', child: Text('Section A', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600))),
      ExcludeSemantics(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, cPrimary.withValues(alpha: 0.3), Colors.transparent],
            ),
          ),
        ),
      ),
      Semantics(label: 'Section B content', child: Text('Section B', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600))),
    ],
  );
  print('  ExcludeSemantics: Decorative divider excluded');

  Widget companionCard(String title, String description, Widget visual, Color color, String effect) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 6.0, offset: Offset(0.0, 2.0))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 4.0),
          Text(description, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600, height: 1.3)),
          SizedBox(height: 10.0),
          visual,
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(effect, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: color)),
          ),
        ],
      ),
    );
  }

  final scene4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 4 — MergeSemantics & ExcludeSemantics',
        'Companion widgets that control how children appear in the accessibility tree',
        Icons.merge_type,
        Colors.teal,
      ),
      explanationBox(
        'MergeSemantics wraps a subtree and fuses all descendant labels into a '
        'single semantics node. This is perfect for list tiles, cards, and other '
        'composite widgets where the group should be a single focus target.\n\n'
        'ExcludeSemantics hides its subtree from the accessibility tree entirely. '
        'Use it for decorative elements (dividers, background images, ornamental '
        'icons) that would add noise for screen reader users.',
        color: Colors.teal,
      ),

      companionCard(
        'MergeSemantics — Fused List Tile',
        'All children merge into one announcement: icon + title + subtitle + chevron become '
        'a single focus target, read as "Wi-Fi, Connected to HomeNetwork".',
        mergeExample,
        cPrimary,
        'Focus: 1 node → "Wi-Fi, Connected to HomeNetwork"',
      ),

      companionCard(
        'Without MergeSemantics — Separate Nodes',
        'Without the merge wrapper, each Semantics child creates its own focus target. '
        'The user must swipe through 4 elements to navigate past this tile.',
        unmergedExample,
        cMuted,
        'Focus: 4 nodes → [icon] → [title] → [subtitle] → [chevron]',
      ),

      companionCard(
        'ExcludeSemantics — Hidden Decorative Icon',
        'The star icon is purely decorative — the text label already describes "Gold star '
        'badge". ExcludeSemantics prevents the icon from cluttering the tree.',
        excludeExample,
        cWarning,
        'Star excluded → Focus only on "Premium Member, Gold star badge"',
      ),

      companionCard(
        'ExcludeSemantics — Decorative Divider',
        'Visual dividers between sections serve no informational purpose for screen readers. '
        'Excluding them keeps navigation clean: Section A → Section B.',
        decorativeExclude,
        Colors.teal,
        'Divider excluded → Focus: [Section A] → [Section B]',
      ),
    ],
  );

  // ============================================================
  // SCENE 5: Semantic Actions Workshop
  // ============================================================
  print('\n=== Scene 5: Semantic Actions Workshop ===');

  var tapFired = false;
  var longPressFired = false;
  var increaseFired = false;
  var decreaseFired = false;
  var scrollLeftFired = false;
  var scrollRightFired = false;
  var copyFired = false;
  var dismissFired = false;

  // Widget with all actions wired
  final actionWidget = Semantics(
    label: 'Multi-action element',
    hint: 'Has 8 registered semantic actions',
    button: true,
    enabled: true,
    onTap: () {
      tapFired = true;
      print('  Action fired: onTap');
    },
    onLongPress: () {
      longPressFired = true;
      print('  Action fired: onLongPress');
    },
    onIncrease: () {
      increaseFired = true;
      print('  Action fired: onIncrease');
    },
    onDecrease: () {
      decreaseFired = true;
      print('  Action fired: onDecrease');
    },
    onScrollLeft: () {
      scrollLeftFired = true;
      print('  Action fired: onScrollLeft');
    },
    onScrollRight: () {
      scrollRightFired = true;
      print('  Action fired: onScrollRight');
    },
    onCopy: () {
      copyFired = true;
      print('  Action fired: onCopy');
    },
    onDismiss: () {
      dismissFired = true;
      print('  Action fired: onDismiss');
    },
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cSecondary.withValues(alpha: 0.12), cPrimary.withValues(alpha: 0.06)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: cSecondary.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.touch_app, size: 36.0, color: cSecondary),
          SizedBox(height: 6.0),
          Text('Multi-Action Element', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cSecondary)),
          Text('8 semantic actions registered', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
        ],
      ),
    ),
  );
  print('  Created Semantics widget with 8 action handlers');

  Widget actionInfoTile(String name, String gesture, IconData icon, Color color, bool fired) {
    return Container(
      margin: EdgeInsets.all(3.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: fired ? cSuccess.withValues(alpha: 0.08) : color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20.0, color: color),
          SizedBox(height: 3.0),
          Text(name, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color), textAlign: TextAlign.center),
          SizedBox(height: 2.0),
          Text(gesture, style: TextStyle(fontSize: 7.5, color: Colors.grey.shade500), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // Individual action examples with dedicated Semantics widgets
  final tapOnlyWidget = Semantics(
    label: 'Delete item',
    button: true,
    enabled: true,
    onTap: () => print('  Tap-only button activated'),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: cError.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cError.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete_outline, size: 18.0, color: cError),
          SizedBox(width: 6.0),
          Text('Delete', style: TextStyle(color: cError, fontSize: 12.0, fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );

  final adjustableWidget = Semantics(
    label: 'Font size',
    slider: true,
    value: '14pt',
    increasedValue: '16pt',
    decreasedValue: '12pt',
    onIncrease: () => print('  Font size increased'),
    onDecrease: () => print('  Font size decreased'),
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cSuccess.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: cSuccess.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('A', style: TextStyle(fontSize: 10.0, color: cSuccess)),
          SizedBox(width: 12.0),
          Container(
            width: 60.0,
            child: Stack(
              children: [
                Container(height: 4.0, width: 60.0, decoration: BoxDecoration(color: cSuccess.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(2.0))),
                Positioned(left: 20.0, top: -4.0, child: Container(width: 12.0, height: 12.0, decoration: BoxDecoration(color: cSuccess, shape: BoxShape.circle))),
              ],
            ),
          ),
          SizedBox(width: 12.0),
          Text('A', style: TextStyle(fontSize: 18.0, color: cSuccess, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );

  final scrollableWidget = Semantics(
    label: 'Photo carousel',
    onScrollLeft: () => print('  Scrolled left'),
    onScrollRight: () => print('  Scrolled right'),
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: cAccent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: cAccent.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chevron_left, color: cAccent.withValues(alpha: 0.5), size: 20.0),
          SizedBox(width: 4.0),
          Container(width: 40.0, height: 30.0, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4.0))),
          SizedBox(width: 4.0),
          Container(width: 40.0, height: 30.0, decoration: BoxDecoration(color: cAccent.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4.0), border: Border.all(color: cAccent))),
          SizedBox(width: 4.0),
          Container(width: 40.0, height: 30.0, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4.0))),
          SizedBox(width: 4.0),
          Icon(Icons.chevron_right, color: cAccent.withValues(alpha: 0.5), size: 20.0),
        ],
      ),
    ),
  );

  final dismissibleWidget = Semantics(
    label: 'Notification: New update available',
    onDismiss: () => print('  Notification dismissed'),
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cSecondary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: cSecondary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.notifications_active, color: cSecondary, size: 22.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New update available', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: cSecondary)),
                Text('Swipe to dismiss', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
              ],
            ),
          ),
          Icon(Icons.close, size: 18.0, color: Colors.grey.shade400),
        ],
      ),
    ),
  );
  print('  Created focused action examples: tap-only, adjustable, scrollable, dismissible');

  final scene5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 5 — Semantic Actions Workshop',
        'How to wire interactive callbacks through the Semantics widget',
        Icons.touch_app,
        cSecondary,
      ),
      explanationBox(
        'Semantic actions are callbacks that assistive services can invoke. When '
        'VoiceOver user double-taps, the onTap handler fires. When they swipe up '
        'on an adjustable, onIncrease fires. These actions make custom widgets '
        'fully navigable without visible tap targets.\n\n'
        'The Semantics widget accepts: onTap, onLongPress, onIncrease, onDecrease, '
        'onScrollLeft, onScrollRight, onScrollUp, onScrollDown, onCopy, onCut, '
        'onPaste, onDismiss, onMoveCursorForwardByCharacter, onMoveCursorBackwardByCharacter, '
        'onSetSelection, onSetText, and customSemanticsActions.',
        color: cSecondary,
      ),

      // All-actions widget
      Center(child: actionWidget),
      SizedBox(height: 10.0),

      // Action grid
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registered Actions Map', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
            SizedBox(height: 6.0),
            Wrap(
              children: [
                actionInfoTile('onTap', 'Double-tap', Icons.touch_app, Colors.deepOrange, tapFired),
                actionInfoTile('onLongPress', 'Double-tap\n& hold', Icons.pan_tool, Colors.deepOrange, longPressFired),
                actionInfoTile('onIncrease', 'Swipe up', Icons.add_circle, cSuccess, increaseFired),
                actionInfoTile('onDecrease', 'Swipe down', Icons.remove_circle, cSuccess, decreaseFired),
                actionInfoTile('onScrollLeft', '3-finger\nswipe left', Icons.arrow_back, Colors.blue, scrollLeftFired),
                actionInfoTile('onScrollRight', '3-finger\nswipe right', Icons.arrow_forward, Colors.blue, scrollRightFired),
                actionInfoTile('onCopy', 'Rotor:\ncopy', Icons.copy, cSecondary, copyFired),
                actionInfoTile('onDismiss', 'Swipe\ndismiss', Icons.close, cError, dismissFired),
              ].map((tile) => SizedBox(width: 90.0, child: tile)).toList(),
            ),
          ],
        ),
      ),

      SizedBox(height: 14.0),

      // Focused examples
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: cPrimary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text('Focused Action Patterns', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: cPrimary)),
      ),

      // Tap-only button
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cError.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            tapOnlyWidget,
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tap-Only Button', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cError)),
                  Text('Only onTap registered. Double-tap is the single interaction.',
                      style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ),

      // Adjustable control
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cSuccess.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            adjustableWidget,
            SizedBox(height: 8.0),
            Text('Adjustable Control (slider: true + onIncrease/onDecrease)',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cSuccess)),
            Text('Swipe up increases, swipe down decreases. value/increasedValue/decreasedValue announce the change.',
                style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600)),
          ],
        ),
      ),

      // Scrollable region
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cAccent.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            scrollableWidget,
            SizedBox(height: 8.0),
            Text('Scrollable Region (onScrollLeft/onScrollRight)',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cAccent)),
            Text('Three-finger swipe gestures navigate through carousel content.',
                style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600)),
          ],
        ),
      ),

      // Dismissible notification
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cSecondary.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dismissibleWidget,
            SizedBox(height: 8.0),
            Text('Dismissible (onDismiss)',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cSecondary)),
            Text('Z-gesture on iOS or swipe-dismiss on Android removes the notification.',
                style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600)),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 6: Real-World Accessibility Patterns
  // ============================================================
  print('\n=== Scene 6: Real-World Accessibility Patterns ===');

  // Pattern 1: Accessible custom icon button with merged semantics
  print('  Pattern 1: Custom tab bar with semantic selection');
  final tabBar = MergeSemantics(
    child: Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              selected: true,
              label: 'Inbox tab, selected',
              hint: 'Currently showing inbox',
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: cPrimary,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [BoxShadow(color: cPrimary.withValues(alpha: 0.3), blurRadius: 4.0)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox, color: Colors.white, size: 18.0),
                    SizedBox(width: 6.0),
                    Text('Inbox', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Semantics(
              selected: false,
              label: 'Sent tab',
              hint: 'Double-tap to switch to sent mail',
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.grey.shade500, size: 18.0),
                    SizedBox(width: 6.0),
                    Text('Sent', style: TextStyle(color: Colors.grey.shade500, fontSize: 12.0)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Semantics(
              selected: false,
              label: 'Drafts tab',
              hint: 'Double-tap to switch to drafts',
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.drafts, color: Colors.grey.shade500, size: 18.0),
                    SizedBox(width: 6.0),
                    Text('Drafts', style: TextStyle(color: Colors.grey.shade500, fontSize: 12.0)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Pattern 2: Accessible progress indicator with live region
  print('  Pattern 2: Download progress with live region');
  final progressPattern = Semantics(
    liveRegion: true,
    label: 'Download progress',
    value: '64 percent complete',
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: Colors.blue.withValues(alpha: 0.06), blurRadius: 8.0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 28.0,
                height: 28.0,
                child: CircularProgressIndicator(
                  value: 0.64,
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
                    Text('Downloading flutter_sdk.zip', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600)),
                    Text('128 MB of 200 MB', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
                  ],
                ),
              ),
              Text('64%', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue)),
            ],
          ),
          SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Stack(
              children: [
                Container(height: 6.0, width: double.infinity, color: Colors.blue.withValues(alpha: 0.1)),
                FractionallySizedBox(
                  widthFactor: 0.64,
                  child: Container(height: 6.0, color: Colors.blue),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: cWarning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text('LIVE', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: cWarning)),
              ),
              SizedBox(width: 8.0),
              Text('Auto-announced by TalkBack on value change', style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500)),
            ],
          ),
        ],
      ),
    ),
  );

  // Pattern 3: Accessible form with validation hints
  print('  Pattern 3: Form field with validation semantics');
  final formPattern = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Valid field
      Semantics(
        textField: true,
        label: 'Email address',
        value: 'user@example.com',
        hint: 'Double-tap to edit',
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cSuccess.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Icon(Icons.email, size: 20.0, color: cSuccess),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email', style: TextStyle(fontSize: 10.0, color: cSuccess)),
                    Text('user@example.com', style: TextStyle(fontSize: 13.0)),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 18.0, color: cSuccess),
            ],
          ),
        ),
      ),
      SizedBox(height: 8.0),
      // Invalid field with error semantics
      Semantics(
        textField: true,
        label: 'Password, error: Must be at least 8 characters',
        value: '****',
        hint: 'Double-tap to edit. Password is too short.',
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cError.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Icon(Icons.lock, size: 20.0, color: cError),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password', style: TextStyle(fontSize: 10.0, color: cError)),
                    Text('••••', style: TextStyle(fontSize: 13.0)),
                    SizedBox(height: 2.0),
                    Text('Must be at least 8 characters', style: TextStyle(fontSize: 10.0, color: cError)),
                  ],
                ),
              ),
              Icon(Icons.error, size: 18.0, color: cError),
            ],
          ),
        ),
      ),
    ],
  );

  // Pattern 4: Accessible card with custom semantics action
  print('  Pattern 4: Card with custom semantic actions');
  final cardPattern = Semantics(
    label: 'Email from Alice: Meeting tomorrow',
    hint: 'Double-tap to open, swipe actions available',
    customSemanticsActions: {
      CustomSemanticsAction(label: 'Archive'): () => print('    Archive action'),
      CustomSemanticsAction(label: 'Mark as read'): () => print('    Mark as read action'),
      CustomSemanticsAction(label: 'Star'): () => print('    Star action'),
    },
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: cSecondary.withValues(alpha: 0.15)),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.08), blurRadius: 6.0)],
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: cSecondary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text('A', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: cSecondary)),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alice', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
                Text('Meeting tomorrow at 3pm', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                SizedBox(height: 4.0),
                Wrap(
                  spacing: 4.0,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(color: cSecondary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(4.0)),
                      child: Text('Archive', style: TextStyle(fontSize: 8.0, color: cSecondary)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(color: cPrimary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(4.0)),
                      child: Text('Mark read', style: TextStyle(fontSize: 8.0, color: cPrimary)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(color: cWarning.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4.0)),
                      child: Text('Star', style: TextStyle(fontSize: 8.0, color: cWarning)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text('2:30 PM', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade400)),
        ],
      ),
    ),
  );

  // Pattern 5: Accessible image gallery item
  print('  Pattern 5: Image gallery with description + actions');
  final galleryPattern = Semantics(
    image: true,
    label: 'Photo 3 of 12: Golden Gate Bridge at sunset, taken June 2024',
    hint: 'Double-tap to view full size, swipe to navigate gallery',
    onTap: () => print('    Open full-size image'),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            height: 100.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6F00), Color(0xFFE91E63), Color(0xFF3F51B5), Color(0xFF1A237E)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Stack(
              children: [
                // Bridge silhouette hint
                Positioned(
                  bottom: 10.0,
                  left: 20.0,
                  right: 20.0,
                  child: Container(
                    height: 3.0,
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 40.0,
                  child: Container(width: 2.0, height: 30.0, color: Colors.orange.withValues(alpha: 0.5)),
                ),
                Positioned(
                  bottom: 10.0,
                  right: 40.0,
                  child: Container(width: 2.0, height: 30.0, color: Colors.orange.withValues(alpha: 0.5)),
                ),
                // Photo counter
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text('3 / 12', style: TextStyle(color: Colors.white, fontSize: 10.0)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Golden Gate Bridge', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                      Text('June 2024 · Sunset', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: cAccent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image, size: 12.0, color: cAccent),
                      SizedBox(width: 2.0),
                      Text('ALT', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: cAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // Pattern 6: Semantic grouping for a settings section
  print('  Pattern 6: Settings section with header hierarchy');
  final settingsPattern = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Semantics(
        header: true,
        label: 'Privacy Settings',
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: cPrimary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text('Privacy Settings', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: cPrimary)),
        ),
      ),
      SizedBox(height: 6.0),
      // Toggle item with merged semantics
      MergeSemantics(
        child: Semantics(
          toggled: true,
          label: 'Location services, enabled',
          hint: 'Double-tap to toggle',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 22.0, color: cPrimary),
                SizedBox(width: 12.0),
                Expanded(child: Text('Location Services', style: TextStyle(fontSize: 13.0))),
                Container(
                  width: 44.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: cPrimary,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(2.0),
                  child: Container(width: 20.0, height: 20.0, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      MergeSemantics(
        child: Semantics(
          toggled: false,
          label: 'Analytics, disabled',
          hint: 'Double-tap to toggle',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.analytics, size: 22.0, color: Colors.grey.shade400),
                SizedBox(width: 12.0),
                Expanded(child: Text('Analytics', style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600))),
                Container(
                  width: 44.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(2.0),
                  child: Container(width: 20.0, height: 20.0, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      MergeSemantics(
        child: Semantics(
          label: 'Clear browsing data',
          button: true,
          hint: 'Double-tap to clear all browsing data',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: cError.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                Icon(Icons.delete_sweep, size: 22.0, color: cError),
                SizedBox(width: 12.0),
                Expanded(child: Text('Clear Browsing Data', style: TextStyle(fontSize: 13.0, color: cError))),
                Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20.0),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget patternPanel(String name, String description, Widget visual, Color color, String a11yNote) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.05), blurRadius: 8.0, offset: Offset(0.0, 3.0))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 3.0),
          Text(description, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600)),
          SizedBox(height: 12.0),
          visual,
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(6.0),
              border: Border(left: BorderSide(color: color.withValues(alpha: 0.4), width: 2.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.accessibility, size: 14.0, color: color),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(a11yNote, style: TextStyle(fontSize: 9.5, color: color.withValues(alpha: 0.8), height: 1.3)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final scene6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 6 — Real-World Accessibility Patterns',
        'Complete practical examples combining multiple Semantics features',
        Icons.apps,
        Colors.brown,
      ),
      explanationBox(
        'In real apps, accessibility is achieved by combining Semantics, '
        'MergeSemantics, ExcludeSemantics, and careful labeling. Here are six '
        'patterns that demonstrate best practices — each wires multiple Semantics '
        'properties together to create a fully accessible UI element.',
        color: Colors.brown,
      ),

      patternPanel(
        'Tab Bar with Selected State',
        'Tabs use selected: true/false to announce which is active',
        tabBar,
        cPrimary,
        'VoiceOver: "Inbox tab, selected" → "Sent tab, double-tap to switch" — '
        'selected state communicates current tab without visual cues.',
      ),

      patternPanel(
        'Live Progress Indicator',
        'liveRegion auto-announces percentage changes without user interaction',
        progressPattern,
        Colors.blue,
        'TalkBack auto-reads: "Download progress, 64 percent complete" every time '
        'value changes. No swipe needed — essential for background tasks.',
      ),

      patternPanel(
        'Form Field with Validation Hints',
        'Error messages appear as label suffixes, hint explains how to fix',
        formPattern,
        cSuccess,
        'Screen reader: "Password, error: Must be at least 8 characters, double-tap to edit. '
        'Password is too short." — full context without seeing the red border.',
      ),

      patternPanel(
        'Email Card with Custom Actions',
        'customSemanticsActions add Archive/Star/Mark-read to the rotor menu',
        cardPattern,
        cSecondary,
        'VoiceOver rotor shows: Actions → [Archive] [Mark as read] [Star]. Power users '
        'can act without opening the email.',
      ),

      patternPanel(
        'Image Gallery with Full Description',
        'image: true + descriptive label + navigation hint + onTap',
        galleryPattern,
        cAccent,
        'Screen reader: "Photo 3 of 12: Golden Gate Bridge at sunset, taken June 2024, '
        'image. Double-tap to view full size, swipe to navigate gallery."',
      ),

      patternPanel(
        'Settings Section with Header + Toggles',
        'header for section nav, toggled for switches, MergeSemantics for row grouping',
        settingsPattern,
        cPrimary,
        'Heading rotor: "Privacy Settings" → quick jump. Each toggle: "Location services, '
        'enabled, switch. Double-tap to toggle." Actions + state in one focus stop.',
      ),
    ],
  );

  // ============================================================
  // BUILD SUMMARY
  // ============================================================
  print('\n=== Build Summary ===');
  print('Scene 1: Label Gallery — 6 text annotation properties');
  print('Scene 2: Trait Flags — 13 boolean properties demonstrated');
  print('Scene 3: Container vs Non-Container — 3 boundary modes');
  print('Scene 4: MergeSemantics & ExcludeSemantics — 4 companion patterns');
  print('Scene 5: Semantic Actions — 8 action types + 4 focused examples');
  print('Scene 6: Real-World Patterns — 6 complete accessibility implementations');
  print('Semantics Widget Deep Demo completed');

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
        title: Text('Semantics Widget Deep Demo'),
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
                  colors: [cPrimary.withValues(alpha: 0.12), cSecondary.withValues(alpha: 0.06)],
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
                      Icon(Icons.accessibility_new, size: 38.0, color: cPrimary),
                      SizedBox(width: 14.0),
                      Expanded(
                        child: Text(
                          'Semantics Widget',
                          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: cPrimary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'The Semantics widget is Flutter\'s primary API for making apps '
                    'accessible. It wraps any child widget and attaches metadata — '
                    'labels, hints, values, trait flags, and action callbacks — that '
                    'platform assistive services read to present the UI to users '
                    'with disabilities. Every button, image, toggle, and heading in '
                    'a well-built Flutter app uses Semantics.\n\n'
                    'While SemanticsConfiguration is the raw data bag, this widget '
                    'is the ergonomic wrapper you use day-to-day in widget trees.',
                    style: TextStyle(fontSize: 12.5, height: 1.55, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 10.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: [
                      Chip(label: Text('widgets/basic.dart'), backgroundColor: cPrimary.withValues(alpha: 0.08)),
                      Chip(label: Text('Accessibility'), backgroundColor: cSecondary.withValues(alpha: 0.08)),
                      Chip(label: Text('TalkBack / VoiceOver'), backgroundColor: cAccent.withValues(alpha: 0.08)),
                      Chip(label: Text('Screen Readers'), backgroundColor: Colors.teal.withValues(alpha: 0.08)),
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
                color: cPrimary.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: cPrimary.withValues(alpha: 0.15)),
              ),
              child: Column(
                children: [
                  Text('End of Semantics Widget Deep Demo', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cPrimary)),
                  SizedBox(height: 4.0),
                  Text(
                    '6 scenes · 6 label types · 13 trait flags · 3 boundary modes · '
                    '4 companion patterns · 8 action types · 6 real-world patterns',
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
