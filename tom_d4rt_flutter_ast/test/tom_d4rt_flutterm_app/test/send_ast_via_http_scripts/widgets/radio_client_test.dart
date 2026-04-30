// ignore_for_file: avoid_print
// D4rt test script: Tests RadioClient mixin from widgets library
// Deep Demo: Visual demonstration of the radio group client contract
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RadioClient Deep Demo executing');

  // ============================================================
  // SECTION 1: What is RadioClient?
  // ============================================================
  print('=== Section 1: RadioClient Overview ===');

  // Color palette: Teal / Aquamarine
  final teal900 = Color(0xFF003D3D);
  final teal800 = Color(0xFF005959);
  final teal700 = Color(0xFF007575);
  final teal600 = Color(0xFF009191);
  final teal500 = Color(0xFF00ADAD);
  final aqua400 = Color(0xFF33C2C2);
  final aqua300 = Color(0xFF66D6D6);
  final aqua200 = Color(0xFF99E5E5);
  final aqua100 = Color(0xFFCCF2F2);
  final aqua50 = Color(0xFFE8F9F9);

  final overviewCards = <Widget>[];

  // Hero card
  overviewCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [teal900, teal600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: teal900.withValues(alpha: 0.5),
            blurRadius: 14.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.radio_button_checked, size: 38.0, color: aqua200),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'RadioClient',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: aqua400.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'mixin RadioClient<T>',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: aqua200,
              ),
            ),
          ),
          SizedBox(height: 14.0),
          Text(
            'RadioClient is a mixin that defines the contract between an '
            'individual radio button and its RadioGroupRegistry. It provides '
            'four read-only getters — tristate, radioValue, enabled, focusNode — '
            'and a registry setter that handles automatic registration and '
            'unregistration. Typically mixed with a State class.',
            style: TextStyle(
              fontSize: 13.5,
              color: aqua100,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Key properties
  final properties = <Map<String, String>>[
    {
      'label': 'tristate',
      'type': 'bool',
      'desc': 'Whether this radio can be toggled back to null (unselected)',
    },
    {
      'label': 'radioValue',
      'type': 'T',
      'desc': 'The value this radio button represents in the group',
    },
    {
      'label': 'enabled',
      'type': 'bool',
      'desc': 'Whether this radio is interactive (registry skips if false)',
    },
    {
      'label': 'focusNode',
      'type': 'FocusNode',
      'desc': 'Focus node for keyboard navigation support',
    },
    {
      'label': 'registry',
      'type': 'RadioGroupRegistry<T>?',
      'desc': 'Auto-registers/unregisters — set to null on dispose',
    },
  ];

  for (final prop in properties) {
    overviewCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: teal900.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: teal700, width: 3.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: teal700.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                prop['label']!,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: teal700,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Color(0xFF37474F).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                prop['type']!,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: Color(0xFF37474F),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                prop['desc']!,
                style: TextStyle(
                  fontSize: 12.0,
                  color: teal800,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('  RadioClient: mixin with 4 getters + registry setter');
  print('  Provides: tristate, radioValue, enabled, focusNode');

  // ============================================================
  // SECTION 2: The RadioGroup Ecosystem
  // ============================================================
  print('=== Section 2: RadioGroup Ecosystem ===');

  final ecosystemCards = <Widget>[];

  ecosystemCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.hub, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Text(
            'Section 2: RadioGroup Ecosystem',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  // Three-part ecosystem
  final ecosystem = <Map<String, dynamic>>[
    {
      'name': 'RadioGroup<T>',
      'role': 'StatefulWidget — the container',
      'icon': Icons.group_work,
      'color': Color(0xFF1565C0),
      'desc': 'Wraps a subtree of radios, manages groupValue, '
          'provides keyboard shortcuts (arrow keys, Space, Tab)',
    },
    {
      'name': 'RadioGroupRegistry<T>',
      'role': 'Abstract interface — the contract',
      'icon': Icons.article,
      'color': Color(0xFF6A1B9A),
      'desc': 'Defines groupValue getter, registerClient/unregisterClient, '
          'and onChanged callback. _RadioGroupState implements this.',
    },
    {
      'name': 'RadioClient<T>',
      'role': 'Mixin — the participant',
      'icon': Icons.radio_button_checked,
      'color': teal600,
      'desc': 'Each radio mixes this in. Exposes tristate, radioValue, '
          'enabled, focusNode. Auto-registers via registry setter.',
    },
  ];

  for (final part in ecosystem) {
    final isClient = part['name'] == 'RadioClient<T>';
    ecosystemCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: isClient
              ? teal600.withValues(alpha: 0.1)
              : (part['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isClient
                ? teal500
                : (part['color'] as Color).withValues(alpha: 0.3),
            width: isClient ? 2.5 : 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: (part['color'] as Color).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                part['icon'] as IconData,
                color: part['color'] as Color,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        part['name'] as String,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          color: part['color'] as Color,
                        ),
                      ),
                      if (isClient) ...[
                        SizedBox(width: 8.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: teal500,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'THIS',
                            style: TextStyle(
                              fontSize: 8.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    part['role'] as String,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF616161),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    part['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF37474F),
                      height: 1.35,
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

  // Flow arrows
  ecosystemCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: aqua50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: teal500, width: 3.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registration flow:',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: teal700,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            '1. RadioGroup creates a _RadioGroupState (implements RadioGroupRegistry)\n'
            '2. Each RawRadio/Radio in the subtree mixes in RadioClient\n'
            '3. Client sets registry = RadioGroup.maybeOf(context)\n'
            '4. The setter calls registry.registerClient(this)\n'
            '5. On dispose: setting registry = null calls unregisterClient',
            style: TextStyle(
              fontSize: 11.5,
              color: teal800,
              height: 1.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );

  print('  Ecosystem: RadioGroup → RadioGroupRegistry → RadioClient');
  print('  Registration is automatic via the registry setter');

  // ============================================================
  // SECTION 3: The Four Getters in Detail
  // ============================================================
  print('=== Section 3: The Four Getters ===');

  final getterCards = <Widget>[];

  getterCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.visibility, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Text(
            'Section 3: The Four Getters',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  final getters = <Map<String, dynamic>>[
    {
      'name': 'bool get tristate',
      'icon': Icons.toggle_on,
      'color': Color(0xFFEF6C00),
      'purpose': 'Toggleable behavior',
      'detail': 'When true, selecting an already-selected radio deselects it '
          '(calls onChanged(null)). When false, once selected, the radio '
          'can only be unselected by selecting another radio in the group.',
      'used': 'Registry reads this to decide whether Space key toggles off',
    },
    {
      'name': 'T get radioValue',
      'icon': Icons.label,
      'color': Color(0xFF1565C0),
      'purpose': 'Identity in the group',
      'detail': 'The value this radio represents. When this equals '
          'groupValue, this radio is the selected one. The type T is the '
          'generic type of the entire RadioGroup.',
      'used': 'Registry compares this to groupValue for selection state',
    },
    {
      'name': 'bool get enabled',
      'icon': Icons.block,
      'color': Color(0xFFC62828),
      'purpose': 'Interaction gate',
      'detail': 'If false, the registry skips this client during keyboard '
          'navigation (arrow keys will jump over disabled radios). '
          'The radio is still visible but not interactive.',
      'used': 'Arrow key navigation filters out disabled radios',
    },
    {
      'name': 'FocusNode get focusNode',
      'icon': Icons.center_focus_strong,
      'color': Color(0xFF2E7D32),
      'purpose': 'Keyboard focus target',
      'detail': 'Used by the registry for keyboard navigation — arrow keys '
          'call focusNode.requestFocus() on the next/previous radio. '
          'Also used to detect which radio currently has focus.',
      'used': 'Registry sorts focusNodes in reading order for traversal',
    },
  ];

  for (final getter in getters) {
    getterCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: (getter['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: (getter['color'] as Color).withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  getter['icon'] as IconData,
                  color: getter['color'] as Color,
                  size: 20.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    getter['name'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: getter['color'] as Color,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: (getter['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    getter['purpose'] as String,
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.w600,
                      color: getter['color'] as Color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              getter['detail'] as String,
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF37474F),
                height: 1.4,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Used by registry: ${getter['used']}',
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('  Four getters: tristate, radioValue, enabled, focusNode');
  print('  All read by RadioGroupRegistry for group behavior');

  // ============================================================
  // SECTION 4: The Registry Property — Auto-Register
  // ============================================================
  print('=== Section 4: Registry Auto-Registration ===');

  final registryCards = <Widget>[];

  registryCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.app_registration, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 4: Auto-Registration',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // The setter mechanism
  registryCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: aqua100.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: aqua300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'set registry(RadioGroupRegistry<T>? newRegistry)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: teal700,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'The registry setter is the heart of RadioClient. It handles '
            'registration lifecycle automatically:',
            style: TextStyle(
              fontSize: 12.5,
              color: teal800,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

  // Step by step
  final registrySteps = <Map<String, String>>[
    {
      'step': '1',
      'action': 'Check if new != old',
      'detail': 'If newRegistry is the same object, do nothing',
    },
    {
      'step': '2',
      'action': 'Unregister from old',
      'detail': '_registry?.unregisterClient(this)',
    },
    {
      'step': '3',
      'action': 'Store new registry',
      'detail': '_registry = newRegistry',
    },
    {
      'step': '4',
      'action': 'Register with new',
      'detail': '_registry?.registerClient(this)',
    },
  ];

  for (final step in registrySteps) {
    registryCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: teal600.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: teal500, width: 3.0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                color: teal600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step['step']!,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['action']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: teal700,
                    ),
                  ),
                  Text(
                    step['detail']!,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF616161),
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

  // Dispose pattern
  registryCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: Color(0xFFE65100), width: 3.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber, color: Color(0xFFE65100), size: 20.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Important: Set registry = null in dispose() to unregister. '
              'This prevents the registry from holding stale references to '
              'disposed radio clients.',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF4E342E),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('  registry setter: auto unregisters old, registers new');
  print('  Set to null on dispose to clean up');

  // ============================================================
  // SECTION 5: RawRadio — Primary Consumer
  // ============================================================
  print('=== Section 5: RawRadio — Primary Consumer ===');

  final rawRadioCards = <Widget>[];

  rawRadioCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.smart_button, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 5: RawRadio — Primary Consumer',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // RawRadio architecture
  rawRadioCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF263238), Color(0xFF37474F)],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RawRadio<T> → _RawRadioState<T> with RadioClient<T>',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: aqua200,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'RawRadio is not a publicly visible API with a visual appearance — '
            'it provides the base radio behavior. Its State class mixes in '
            'RadioClient<T> and ToggleableStateMixin. Both Material Radio '
            'and CupertinoRadio use RawRadio internally, providing their '
            'own builder for the visual appearance.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Hierarchy
  final radioHierarchy = <Map<String, dynamic>>[
    {'name': 'Radio<T> (Material)', 'depth': 0, 'color': Color(0xFF1565C0)},
    {'name': 'CupertinoRadio<T>', 'depth': 0, 'color': Color(0xFFE65100)},
    {'name': 'RawRadio<T> (shared)', 'depth': 1, 'color': Color(0xFF37474F)},
    {'name': '_RawRadioState<T>', 'depth': 2, 'color': Color(0xFF37474F)},
    {'name': 'with RadioClient<T>', 'depth': 3, 'color': teal600},
    {'name': 'with ToggleableStateMixin', 'depth': 3, 'color': Color(0xFF6A1B9A)},
  ];

  for (final node in radioHierarchy) {
    final depth = node['depth'] as int;
    final isClient = (node['name'] as String).contains('RadioClient');
    rawRadioCards.add(
      Container(
        margin: EdgeInsets.only(
          left: 12.0 + (depth * 20.0),
          right: 12.0,
          top: 3.0,
          bottom: 3.0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isClient
              ? teal600.withValues(alpha: 0.1)
              : (node['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: isClient
              ? Border.all(color: teal500, width: 2.0)
              : Border(left: BorderSide(
                  color: (node['color'] as Color).withValues(alpha: 0.4), width: 3.0)),
        ),
        child: Row(
          children: [
            Text(
              node['name'] as String,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isClient ? FontWeight.bold : FontWeight.w500,
                fontFamily: 'monospace',
                color: node['color'] as Color,
              ),
            ),
            if (isClient) ...[
              SizedBox(width: 8.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: teal500,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(
                  'THIS MIXIN',
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  print('  RawRadio._RawRadioState mixes in RadioClient');
  print('  Material Radio and CupertinoRadio both use RawRadio');

  // ============================================================
  // SECTION 6: Keyboard Navigation
  // ============================================================
  print('=== Section 6: Keyboard Navigation ===');

  final keyboardCards = <Widget>[];

  keyboardCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.keyboard, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Text(
            'Section 6: Keyboard Navigation',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  // Keyboard shortcuts
  final shortcuts = <Map<String, dynamic>>[
    {
      'keys': 'Tab',
      'action': 'Enter the radio group',
      'detail': 'Focuses selected radio (or first if none selected)',
      'icon': Icons.login,
    },
    {
      'keys': 'Shift+Tab',
      'action': 'Leave the radio group',
      'detail': 'Moves focus out to the previous focusable widget',
      'icon': Icons.logout,
    },
    {
      'keys': 'Arrow Right / Down',
      'action': 'Select next radio',
      'detail': 'ReadingOrderTraversalPolicy sorts by position, wraps around',
      'icon': Icons.arrow_forward,
    },
    {
      'keys': 'Arrow Left / Up',
      'action': 'Select previous radio',
      'detail': 'Wraps to last if at first radio',
      'icon': Icons.arrow_back,
    },
    {
      'keys': 'Space',
      'action': 'Toggle selection',
      'detail': 'Selects focused radio; if tristate and already selected, unselects',
      'icon': Icons.space_bar,
    },
  ];

  for (final shortcut in shortcuts) {
    keyboardCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: aqua50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: aqua200),
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: teal700.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                shortcut['icon'] as IconData,
                color: teal700,
                size: 20.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: teal700,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          shortcut['keys'] as String,
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        shortcut['action'] as String,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: teal800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    shortcut['detail'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF616161),
                      height: 1.3,
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

  // Connection to RadioClient
  keyboardCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: aqua50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: teal500, width: 3.5)),
      ),
      child: Text(
        'All keyboard navigation works through RadioClient getters: '
        'focusNode for focus movement, enabled for skip logic, '
        'radioValue for selection, tristate for toggle behavior.',
        style: TextStyle(
          fontSize: 12.0,
          color: teal800,
          height: 1.4,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );

  print('  Arrow keys: next/previous radio (wraps around)');
  print('  Space: toggle selection; Tab: enter/leave group');

  // ============================================================
  // SECTION 7: Visual RadioGroup Demo
  // ============================================================
  print('=== Section 7: Visual RadioGroup Demo ===');

  final visualRadioCards = <Widget>[];

  visualRadioCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.radio_button_checked, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 7: Visual RadioGroup Demo',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Visual radio group simulation
  final radioOptions = <Map<String, dynamic>>[
    {'label': 'Small', 'value': 'S', 'selected': false, 'icon': Icons.text_fields},
    {'label': 'Medium', 'value': 'M', 'selected': true, 'icon': Icons.format_size},
    {'label': 'Large', 'value': 'L', 'selected': false, 'icon': Icons.title},
    {'label': 'Extra Large', 'value': 'XL', 'selected': false, 'icon': Icons.format_bold},
  ];

  visualRadioCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: aqua50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: aqua300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Font Size Selection',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: teal700,
            ),
          ),
          Text(
            'Each radio below would be a RadioClient in the group',
            style: TextStyle(fontSize: 10.5, color: Colors.grey),
          ),
          SizedBox(height: 12.0),
          ...radioOptions.map((opt) {
            final selected = opt['selected'] as bool;
            return Container(
              margin: EdgeInsets.only(bottom: 8.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: selected
                    ? teal600.withValues(alpha: 0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: selected ? teal500 : Colors.grey.withValues(alpha: 0.3),
                  width: selected ? 2.0 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? teal600 : Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: selected
                        ? Center(
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: teal600,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(width: 12.0),
                  Icon(
                    opt['icon'] as IconData,
                    color: selected ? teal700 : Colors.grey,
                    size: 20.0,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opt['label'] as String,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                            color: selected ? teal800 : Color(0xFF37474F),
                          ),
                        ),
                        Text(
                          'value: "${opt['value']}"',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontFamily: 'monospace',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selected)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: teal600,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'SELECTED',
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
          SizedBox(height: 8.0),
          Text(
            'Each radio option has: radioValue (S/M/L/XL), enabled, '
            'focusNode, and tristate. The registry tracks groupValue = "M".',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF616161),
              fontStyle: FontStyle.italic,
              height: 1.3,
            ),
          ),
        ],
      ),
    ),
  );

  print('  Visual: 4 radio options, Medium selected');
  print('  Each option is a RadioClient in the registry');

  // ============================================================
  // SECTION 8: Tristate Toggle Behavior
  // ============================================================
  print('=== Section 8: Tristate Toggle ===');

  final tristateCards = <Widget>[];

  tristateCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.toggle_on, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Text(
            'Section 8: Tristate Toggle',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  // Tristate comparison
  tristateCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Color(0xFF2E7D32).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.toggle_off, color: Color(0xFF2E7D32), size: 28.0),
                  SizedBox(height: 6.0),
                  Text(
                    'tristate: false',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Select A → A selected\n'
                    'Tap A again → nothing\n'
                    'Select B → A deselected',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Color(0xFF37474F),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Standard radio behavior',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Color(0xFFEF6C00).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Color(0xFFEF6C00).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.toggle_on, color: Color(0xFFEF6C00), size: 28.0),
                  SizedBox(height: 6.0),
                  Text(
                    'tristate: true',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Color(0xFFEF6C00),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Select A → A selected\n'
                    'Tap A again → null (none)\n'
                    'Select B → B selected',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Color(0xFF37474F),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Allows "no selection"',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // How registry uses tristate
  tristateCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: aqua50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: teal500, width: 3.5)),
      ),
      child: Text(
        'When Space is pressed on a focused radio, _toggleFocusedRadio() '
        'checks: if radioValue != groupValue, it calls onChanged(radioValue). '
        'But if radioValue == groupValue AND tristate is true, it calls '
        'onChanged(null) — deselecting the current selection.',
        style: TextStyle(
          fontSize: 12.0,
          color: teal800,
          height: 1.5,
        ),
      ),
    ),
  );

  print('  tristate false: standard radio (can only deselect by selecting another)');
  print('  tristate true: tapping selected radio unselects it (null)');

  // ============================================================
  // SECTION 9: Focus Traversal — SkipUnselectedRadioPolicy
  // ============================================================
  print('=== Section 9: Focus Traversal Policy ===');

  final traversalCards = <Widget>[];

  traversalCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.tab, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 9: Focus Traversal Policy',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // The SkipUnselectedRadioPolicy
  traversalCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF263238), Color(0xFF37474F)],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '_SkipUnselectedRadioPolicy<T>',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: aqua200,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'RadioGroup wraps its content in a FocusTraversalGroup with a '
            'custom policy. When Tab focuses into the group, this policy '
            'only includes the selected radio (or the first radio if none '
            'is selected). Unselected radios are skipped by Tab — they are '
            'only reachable via arrow keys within the group.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Tab vs Arrow keys visual
  traversalCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: aqua50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: aqua200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tab behavior with 4 radios (B selected):',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: teal700,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              for (final label in ['A', 'B', 'C', 'D'])
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: label == 'B'
                          ? teal600.withValues(alpha: 0.2)
                          : Colors.grey.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: label == 'B' ? teal500 : Colors.grey.withValues(alpha: 0.3),
                        width: label == 'B' ? 2.0 : 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 18.0,
                          height: 18.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: label == 'B' ? teal600 : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          child: label == 'B'
                              ? Center(
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: teal600,
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: label == 'B' ? FontWeight.bold : FontWeight.normal,
                            color: label == 'B' ? teal700 : Colors.grey,
                          ),
                        ),
                        if (label == 'B')
                          Text(
                            'Tab here',
                            style: TextStyle(fontSize: 8.0, color: teal600),
                          ),
                        if (label != 'B')
                          Text(
                            'skipped',
                            style: TextStyle(fontSize: 8.0, color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Tab jumps directly to B (selected). Arrow keys then navigate A↔B↔C↔D.',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF616161),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );

  print('  Tab: focuses only the selected radio (skips unselected)');
  print('  Arrow keys: navigate all radios in reading order');

  // ============================================================
  // SECTION 10: Enabled vs Disabled Radio States
  // ============================================================
  print('=== Section 10: Enabled vs Disabled ===');

  final enabledCards = <Widget>[];

  enabledCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.block, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Text(
            'Section 10: Enabled vs Disabled',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  // Visual comparison
  final enableStates = <Map<String, dynamic>>[
    {
      'label': 'Option A',
      'enabled': true,
      'selected': false,
      'note': 'Enabled — arrow keys can reach, tappable',
    },
    {
      'label': 'Option B',
      'enabled': true,
      'selected': true,
      'note': 'Enabled + Selected — current value',
    },
    {
      'label': 'Option C',
      'enabled': false,
      'selected': false,
      'note': 'Disabled — arrow keys skip, not tappable',
    },
    {
      'label': 'Option D',
      'enabled': true,
      'selected': false,
      'note': 'Enabled — arrow keys jump from B to D (skip C)',
    },
  ];

  for (final state in enableStates) {
    final isEnabled = state['enabled'] as bool;
    final isSelected = state['selected'] as bool;
    enabledCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: !isEnabled
              ? Colors.grey.withValues(alpha: 0.08)
              : isSelected
                  ? teal600.withValues(alpha: 0.1)
                  : aqua50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: !isEnabled
                ? Colors.grey.withValues(alpha: 0.2)
                : isSelected
                    ? teal500
                    : aqua200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: !isEnabled ? Colors.grey.withValues(alpha: 0.3) : teal600,
                  width: 2.0,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: teal600,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state['label'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: !isEnabled
                          ? Colors.grey.withValues(alpha: 0.5)
                          : Color(0xFF212121),
                    ),
                  ),
                  Text(
                    state['note'] as String,
                    style: TextStyle(
                      fontSize: 10.5,
                      color: !isEnabled
                          ? Colors.grey.withValues(alpha: 0.4)
                          : Color(0xFF616161),
                    ),
                  ),
                ],
              ),
            ),
            if (!isEnabled)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'DISABLED',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  enabledCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: aqua50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: teal500, width: 3.5)),
      ),
      child: Text(
        'The enabled getter is checked by _selectRadioInDirection(): '
        'disabled radios are filtered out of the sorted list before '
        'determining the next/previous radio to select.',
        style: TextStyle(
          fontSize: 12.0,
          color: teal800,
          height: 1.4,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );

  print('  enabled: true → interactive, keyboard reachable');
  print('  enabled: false → skipped by arrow keys, grayed out');

  // ============================================================
  // SECTION 11: RadioGroup vs Standalone Radio
  // ============================================================
  print('=== Section 11: RadioGroup vs Standalone ===');

  final standaloneCards = <Widget>[];

  standaloneCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.compare, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 11: Group vs Standalone',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Comparison
  standaloneCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: teal600.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: teal500.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.group_work, color: teal600, size: 28.0),
                  SizedBox(height: 6.0),
                  Text(
                    'With RadioGroup',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: teal700,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Automatic groupValue\n'
                    'Keyboard navigation\n'
                    'APG semantics\n'
                    'RadioClient registered\n'
                    'Focus policy applied',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Color(0xFF37474F),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'RECOMMENDED',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 28.0),
                  SizedBox(height: 6.0),
                  Text(
                    'Without RadioGroup',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF37474F),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Manual groupValue\n'
                    'No keyboard nav\n'
                    'Basic semantics\n'
                    'No RadioClient\n'
                    'Standard Tab focus',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Color(0xFF37474F),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFE65100),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'LEGACY',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('  With RadioGroup: full keyboard nav, APG semantics, RadioClient registered');
  print('  Without: manual groupValue, no keyboard nav, no RadioClient');

  // ============================================================
  // SECTION 12: APG Accessibility Compliance
  // ============================================================
  print('=== Section 12: APG Accessibility ===');

  final accessCards = <Widget>[];

  accessCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.accessibility_new, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Text(
            'Section 12: APG Accessibility',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  // APG compliance points
  final apgPoints = <Map<String, String>>[
    {
      'requirement': 'role="radiogroup"',
      'implementation': 'RadioGroup wraps its build in Semantics(role: SemanticsRole.radioGroup)',
    },
    {
      'requirement': 'Tab moves to selected radio',
      'implementation': '_SkipUnselectedRadioPolicy skips unselected radios for Tab',
    },
    {
      'requirement': 'Arrow keys move between radios',
      'implementation': '_RadioGroupShortcutManager handles Left/Right/Up/Down',
    },
    {
      'requirement': 'Space selects the focused radio',
      'implementation': '_toggleFocusedRadio() handles Space via VoidCallbackIntent',
    },
    {
      'requirement': 'Arrow wraps from last to first',
      'implementation': '_selectRadioInDirection() wraps: nextFocus ??= first',
    },
  ];

  for (final point in apgPoints) {
    accessCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: aqua50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: aqua200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    point['requirement']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: teal700,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    point['implementation']!,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF616161),
                      height: 1.3,
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

  print('  RadioGroup follows W3C APG radio group pattern');
  print('  RadioClient getters enable all APG requirements');

  // ============================================================
  // SECTION 13: Custom Radio Implementation Architecture
  // ============================================================
  print('=== Section 13: Custom Radio Architecture ===');

  final customCards = <Widget>[];

  customCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.build, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 13: Custom Radio Architecture',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Steps to create a custom radio
  final customSteps = <Map<String, String>>[
    {
      'step': '1',
      'title': 'Create a StatefulWidget',
      'desc': 'Your custom radio widget with value, enabled, toggleable params',
    },
    {
      'step': '2',
      'title': 'Mix RadioClient<T> into State',
      'desc': 'class _MyRadioState<T> extends State<MyRadio<T>> with RadioClient<T>',
    },
    {
      'step': '3',
      'title': 'Implement 4 getters',
      'desc': 'tristate → widget.toggleable, radioValue → widget.value, etc.',
    },
    {
      'step': '4',
      'title': 'Set registry in didChangeDependencies',
      'desc': 'registry = RadioGroup.maybeOf<T>(context)',
    },
    {
      'step': '5',
      'title': 'Clear registry in dispose',
      'desc': 'registry = null (auto-unregisters)',
    },
    {
      'step': '6',
      'title': 'Build custom visual',
      'desc': 'Use registry?.groupValue == radioValue for selection state',
    },
  ];

  for (final step in customSteps) {
    customCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: teal600.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: teal500, width: 3.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                color: teal600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step['step']!,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title']!,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: teal700,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    step['desc']!,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF616161),
                      height: 1.3,
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

  print('  6-step pattern to create a custom radio using RadioClient');

  // ============================================================
  // SECTION 14: Material vs Cupertino — Both Use RadioClient
  // ============================================================
  print('=== Section 14: Material vs Cupertino ===');

  final platformCards = <Widget>[];

  platformCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: teal800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.devices, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 14: Material vs Cupertino',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Side by side comparison
  platformCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Color(0xFF1565C0).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Color(0xFF1565C0).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.android, color: Color(0xFF1565C0), size: 30.0),
                  SizedBox(height: 6.0),
                  Text(
                    'Radio<T>',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Color(0xFF1565C0),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Material Design',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF37474F)),
                  ),
                  SizedBox(height: 8.0),
                  // Visual radio
                  Container(
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF1565C0), width: 2.0),
                    ),
                    child: Center(
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Filled circle\nInk splash',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Color(0xFFE65100).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Color(0xFFE65100).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.apple, color: Color(0xFFE65100), size: 30.0),
                  SizedBox(height: 6.0),
                  Text(
                    'CupertinoRadio<T>',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Color(0xFFE65100),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'iOS / macOS Style',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF37474F)),
                  ),
                  SizedBox(height: 8.0),
                  // Visual radio
                  Container(
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF007AFF),
                    ),
                    child: Center(
                      child: Icon(Icons.check, size: 14.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Filled with check\nGentle animation',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Shared architecture
  platformCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: aqua50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: teal500, width: 3.5)),
      ),
      child: Text(
        'Both Radio and CupertinoRadio build a RawRadio internally. The '
        'RawRadio State class mixes in RadioClient. So regardless of visual '
        'style, the underlying group registration, keyboard navigation, and '
        'accessibility semantics are handled identically through RadioClient.',
        style: TextStyle(
          fontSize: 12.0,
          color: teal800,
          height: 1.5,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );

  print('  Material Radio + CupertinoRadio → both use RawRadio → RadioClient');
  print('  Different visuals, same RadioClient contract underneath');

  // ============================================================
  // SECTION 15: Integration Summary
  // ============================================================
  print('=== Section 15: Integration Summary ===');

  final summaryCards = <Widget>[];

  summaryCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [teal900, teal700],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.summarize, size: 24.0, color: aqua200),
          SizedBox(width: 10.0),
          Text(
            'Section 15: Integration Summary',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  final summaryPoints = <Map<String, String>>[
    {
      'key': 'Nature',
      'value': 'A mixin, not a class — mixed into State objects',
    },
    {
      'key': 'Purpose',
      'value': 'Contract between a radio button and its RadioGroupRegistry',
    },
    {
      'key': 'Getters',
      'value': 'tristate, radioValue, enabled, focusNode — all read by registry',
    },
    {
      'key': 'Registry',
      'value': 'Auto-register/unregister via setter; null on dispose',
    },
    {
      'key': 'Consumers',
      'value': 'RawRadio (via Radio, CupertinoRadio) is the primary implementor',
    },
    {
      'key': 'Keyboard',
      'value': 'Enables arrow keys, Space, Tab/Shift+Tab in RadioGroup',
    },
    {
      'key': 'Traversal',
      'value': 'SkipUnselectedRadioPolicy: Tab focuses only selected radio',
    },
    {
      'key': 'APG',
      'value': 'Fully compliant with W3C ARIA radio group pattern',
    },
    {
      'key': 'Tristate',
      'value': 'Optional: allows deselection back to null',
    },
    {
      'key': 'Custom',
      'value': '6-step pattern to create custom RadioClient-based widgets',
    },
  ];

  for (final point in summaryPoints) {
    summaryCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: teal600.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: aqua400, width: 3.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80.0,
              child: Text(
                point['key']!,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: teal700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                point['value']!,
                style: TextStyle(
                  fontSize: 12.0,
                  color: teal800,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Final badge
  summaryCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 20.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [teal900, teal600],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.radio_button_checked, color: aqua200, size: 30.0),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(
              'RadioClient — the mixin that gives every radio button '
              'its voice in the group: identity (radioValue), '
              'capability (enabled, tristate), and reachability (focusNode).',
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('  RadioClient: the mixin contract for radio group participation');
  print('RadioClient Deep Demo complete');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: teal700,
      scaffoldBackgroundColor: Color(0xFFF8FDFD),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RadioClient Deep Demo'),
        backgroundColor: teal800,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...overviewCards,
            ...ecosystemCards,
            ...getterCards,
            ...registryCards,
            ...rawRadioCards,
            ...keyboardCards,
            ...visualRadioCards,
            ...tristateCards,
            ...traversalCards,
            ...enabledCards,
            ...standaloneCards,
            ...accessCards,
            ...customCards,
            ...platformCards,
            ...summaryCards,
          ],
        ),
      ),
    ),
  );
}
