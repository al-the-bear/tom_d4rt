// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - System Services Cockpit
// Theme: A pilot-style instrument cockpit that documents the Flutter services
// surface. Each section is a "console panel" for one capability: keyboard
// input (logical + physical), haptic engines, system chrome (overlay style,
// UI mode, orientation), system navigation, and text input pipeline
// (formatters + length enforcement). Visual showcase only — no runtime side
// effects are triggered.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: LOGICAL KEYBOARD KEYS — control & navigation register
  // ============================================================================

  final navKeys = <Map<String, dynamic>>[
    {'name': 'escape', 'key': LogicalKeyboardKey.escape, 'role': 'Cancel / dismiss', 'glyph': 'Esc'},
    {'name': 'tab', 'key': LogicalKeyboardKey.tab, 'role': 'Focus traversal', 'glyph': 'Tab'},
    {'name': 'enter', 'key': LogicalKeyboardKey.enter, 'role': 'Submit / activate', 'glyph': 'Ent'},
    {'name': 'backspace', 'key': LogicalKeyboardKey.backspace, 'role': 'Delete previous', 'glyph': '<-'},
    {'name': 'delete', 'key': LogicalKeyboardKey.delete, 'role': 'Delete next', 'glyph': 'Del'},
    {'name': 'home', 'key': LogicalKeyboardKey.home, 'role': 'Line start', 'glyph': 'Hom'},
    {'name': 'end', 'key': LogicalKeyboardKey.end, 'role': 'Line end', 'glyph': 'End'},
    {'name': 'pageUp', 'key': LogicalKeyboardKey.pageUp, 'role': 'Scroll page up', 'glyph': 'PgU'},
    {'name': 'pageDown', 'key': LogicalKeyboardKey.pageDown, 'role': 'Scroll page down', 'glyph': 'PgD'},
  ];

  final functionKeys = <Map<String, dynamic>>[
    {'name': 'f1', 'key': LogicalKeyboardKey.f1, 'role': 'Help / context'},
    {'name': 'f2', 'key': LogicalKeyboardKey.f2, 'role': 'Rename / inline edit'},
    {'name': 'f5', 'key': LogicalKeyboardKey.f5, 'role': 'Refresh / run'},
    {'name': 'f10', 'key': LogicalKeyboardKey.f10, 'role': 'Step over (debug)'},
    {'name': 'f11', 'key': LogicalKeyboardKey.f11, 'role': 'Full screen'},
    {'name': 'f12', 'key': LogicalKeyboardKey.f12, 'role': 'Devtools'},
  ];

  final numpadKeys = <Map<String, dynamic>>[
    {'name': 'numpad0', 'key': LogicalKeyboardKey.numpad0, 'role': 'Numeric 0'},
    {'name': 'numpad5', 'key': LogicalKeyboardKey.numpad5, 'role': 'Numeric 5'},
    {'name': 'numpad9', 'key': LogicalKeyboardKey.numpad9, 'role': 'Numeric 9'},
    {'name': 'numpadEnter', 'key': LogicalKeyboardKey.numpadEnter, 'role': 'Confirm entry'},
    {'name': 'capsLock', 'key': LogicalKeyboardKey.capsLock, 'role': 'Toggle case'},
    {'name': 'numLock', 'key': LogicalKeyboardKey.numLock, 'role': 'Toggle numpad'},
  ];

  // ============================================================================
  // SECTION 2: PHYSICAL KEYBOARD KEYS — USB HID register
  // ============================================================================

  final physicalKeys = <Map<String, dynamic>>[
    {'name': 'keyA', 'key': PhysicalKeyboardKey.keyA, 'group': 'Letter'},
    {'name': 'keyS', 'key': PhysicalKeyboardKey.keyS, 'group': 'Letter'},
    {'name': 'keyD', 'key': PhysicalKeyboardKey.keyD, 'group': 'Letter'},
    {'name': 'keyW', 'key': PhysicalKeyboardKey.keyW, 'group': 'Letter'},
    {'name': 'digit1', 'key': PhysicalKeyboardKey.digit1, 'group': 'Digit'},
    {'name': 'digit5', 'key': PhysicalKeyboardKey.digit5, 'group': 'Digit'},
    {'name': 'arrowUp', 'key': PhysicalKeyboardKey.arrowUp, 'group': 'Arrow'},
    {'name': 'arrowDown', 'key': PhysicalKeyboardKey.arrowDown, 'group': 'Arrow'},
    {'name': 'arrowLeft', 'key': PhysicalKeyboardKey.arrowLeft, 'group': 'Arrow'},
    {'name': 'arrowRight', 'key': PhysicalKeyboardKey.arrowRight, 'group': 'Arrow'},
    {'name': 'space', 'key': PhysicalKeyboardKey.space, 'group': 'Whitespace'},
  ];

  // ============================================================================
  // SECTION 3: HAPTIC FEEDBACK ENGINE — vibration intensity register
  // ============================================================================

  final hapticChannels = <Map<String, dynamic>>[
    {
      'name': 'vibrate',
      'method': 'HapticFeedback.vibrate()',
      'intensity': 1.0,
      'duration': '400 ms',
      'cue': 'Generic alert',
    },
    {
      'name': 'heavyImpact',
      'method': 'HapticFeedback.heavyImpact()',
      'intensity': 0.85,
      'duration': '120 ms',
      'cue': 'Critical action',
    },
    {
      'name': 'mediumImpact',
      'method': 'HapticFeedback.mediumImpact()',
      'intensity': 0.6,
      'duration': '90 ms',
      'cue': 'Toggle / commit',
    },
    {
      'name': 'lightImpact',
      'method': 'HapticFeedback.lightImpact()',
      'intensity': 0.35,
      'duration': '60 ms',
      'cue': 'Selection step',
    },
    {
      'name': 'selectionClick',
      'method': 'HapticFeedback.selectionClick()',
      'intensity': 0.2,
      'duration': '30 ms',
      'cue': 'Picker tick',
    },
  ];

  // ============================================================================
  // SECTION 4: SYSTEM CHROME — operator surface methods
  // ============================================================================

  final systemChromeMethods = <Map<String, dynamic>>[
    {
      'name': 'setPreferredOrientations',
      'signature': 'Future<void> setPreferredOrientations(List<DeviceOrientation>)',
      'desc': 'Lock the screen to one or more allowed orientations.',
      'category': 'Layout',
    },
    {
      'name': 'setSystemUIOverlayStyle',
      'signature': 'void setSystemUIOverlayStyle(SystemUiOverlayStyle)',
      'desc': 'Tint the system status / navigation bars.',
      'category': 'Appearance',
    },
    {
      'name': 'setEnabledSystemUIMode',
      'signature': 'Future<void> setEnabledSystemUIMode(SystemUiMode, {List<SystemUiOverlay>? overlays})',
      'desc': 'Choose between immersive, edge-to-edge, manual modes.',
      'category': 'Visibility',
    },
    {
      'name': 'setApplicationSwitcherDescription',
      'signature': 'Future<void> setApplicationSwitcherDescription(ApplicationSwitcherDescription)',
      'desc': 'Set label & tint shown in the OS task switcher.',
      'category': 'Identity',
    },
    {
      'name': 'restoreSystemUIOverlays',
      'signature': 'Future<void> restoreSystemUIOverlays()',
      'desc': 'Bring previously hidden overlays back into view.',
      'category': 'Visibility',
    },
  ];

  // ============================================================================
  // SECTION 5: SYSTEM UI OVERLAY STYLE — chrome tint presets
  // ============================================================================

  final lightStyle = SystemUiOverlayStyle(
    statusBarColor: Color(0x00000000),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFFFFFFFF),
    systemNavigationBarDividerColor: Color(0xFFE0E0E0),
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  final darkPanelStyle = SystemUiOverlayStyle(
    statusBarColor: Color(0xFF0D1B2A),
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D1B2A),
    systemNavigationBarDividerColor: Color(0xFF1B263B),
    systemNavigationBarIconBrightness: Brightness.light,
  );

  final defaultDark = SystemUiOverlayStyle.dark;
  final defaultLight = SystemUiOverlayStyle.light;

  final overlayPresets = <Map<String, dynamic>>[
    {
      'name': 'lightStyle (custom)',
      'statusBg': 'transparent',
      'statusIcons': 'dark',
      'navBg': '#FFFFFF',
      'navIcons': 'dark',
      'preview': Color(0xFFFFFFFF),
      'iconColor': Color(0xFF263238),
    },
    {
      'name': 'darkPanelStyle (custom)',
      'statusBg': '#0D1B2A',
      'statusIcons': 'light',
      'navBg': '#0D1B2A',
      'navIcons': 'light',
      'preview': Color(0xFF0D1B2A),
      'iconColor': Color(0xFFE0E1DD),
    },
    {
      'name': 'SystemUiOverlayStyle.light',
      'statusBg': 'default',
      'statusIcons': defaultLight.statusBarBrightness == Brightness.light ? 'light' : 'dark',
      'navBg': 'default',
      'navIcons': 'auto',
      'preview': Color(0xFFEEEEEE),
      'iconColor': Color(0xFF424242),
    },
    {
      'name': 'SystemUiOverlayStyle.dark',
      'statusBg': 'default',
      'statusIcons': defaultDark.statusBarBrightness == Brightness.dark ? 'dark' : 'light',
      'navBg': 'default',
      'navIcons': 'auto',
      'preview': Color(0xFF212121),
      'iconColor': Color(0xFFEEEEEE),
    },
  ];

  // ============================================================================
  // SECTION 6: SYSTEM UI MODE — chrome visibility profiles
  // ============================================================================

  final uiModeData = <Map<String, dynamic>>[];
  for (final mode in SystemUiMode.values) {
    String desc;
    String emoji;
    if (mode.name == 'edgeToEdge') {
      desc = 'Content draws under both status and nav bars.';
      emoji = 'EDG';
    } else if (mode.name == 'immersive') {
      desc = 'Hides bars; reveals on swipe (sticky press).';
      emoji = 'IMM';
    } else if (mode.name == 'immersiveSticky') {
      desc = 'Hides bars; reveals briefly on swipe, then re-hides.';
      emoji = 'STK';
    } else if (mode.name == 'leanBack') {
      desc = 'Hides bars; one tap anywhere brings them back.';
      emoji = 'LBK';
    } else if (mode.name == 'manual') {
      desc = 'Use provided overlays list explicitly.';
      emoji = 'MAN';
    } else {
      desc = 'System-defined visibility mode.';
      emoji = 'SYS';
    }
    uiModeData.add({
      'name': mode.name,
      'index': mode.index,
      'desc': desc,
      'emoji': emoji,
    });
  }

  // ============================================================================
  // SECTION 7: DEVICE ORIENTATION — rotation profiles
  // ============================================================================

  final orientationData = <Map<String, dynamic>>[];
  for (final orientation in DeviceOrientation.values) {
    int degrees;
    String axis;
    String useCase;
    if (orientation.name == 'portraitUp') {
      degrees = 0;
      axis = 'Vertical';
      useCase = 'Default phone hold';
    } else if (orientation.name == 'landscapeRight') {
      degrees = 90;
      axis = 'Horizontal';
      useCase = 'Right-handed video';
    } else if (orientation.name == 'portraitDown') {
      degrees = 180;
      axis = 'Vertical';
      useCase = 'Upside-down (rare)';
    } else if (orientation.name == 'landscapeLeft') {
      degrees = 270;
      axis = 'Horizontal';
      useCase = 'Left-handed video';
    } else {
      degrees = 0;
      axis = 'Unknown';
      useCase = 'Unspecified';
    }
    orientationData.add({
      'name': orientation.name,
      'index': orientation.index,
      'degrees': degrees,
      'axis': axis,
      'useCase': useCase,
    });
  }

  // ============================================================================
  // SECTION 8: SYSTEM NAVIGATOR — app lifecycle controls
  // ============================================================================

  final navigatorCommands = <Map<String, dynamic>>[
    {
      'name': 'pop',
      'signature': 'Future<void> SystemNavigator.pop({bool? animated})',
      'desc': 'Asks the OS to pop the top-level route; on Android this exits.',
      'risk': 'high',
    },
    {
      'name': 'routeUpdated',
      'signature': 'Future<void> SystemNavigator.routeUpdated({String? routeName, String? previousRouteName})',
      'desc': 'Notifies the host about a route change (web URL sync).',
      'risk': 'low',
    },
    {
      'name': 'routeInformationUpdated',
      'signature': 'void SystemNavigator.routeInformationUpdated({Uri? uri, Object? state, bool replace = false})',
      'desc': 'Pushes router-2 state to the embedder (browser history).',
      'risk': 'low',
    },
    {
      'name': 'selectSingleEntryHistory',
      'signature': 'Future<void> SystemNavigator.selectSingleEntryHistory()',
      'desc': 'Switches to single-entry browser history mode.',
      'risk': 'med',
    },
    {
      'name': 'selectMultiEntryHistory',
      'signature': 'Future<void> SystemNavigator.selectMultiEntryHistory()',
      'desc': 'Switches to standard multi-entry browser history mode.',
      'risk': 'med',
    },
  ];

  // ============================================================================
  // SECTION 9: TEXT INPUT FORMATTERS — input pipeline filters
  // ============================================================================

  final lengthFormatter = LengthLimitingTextInputFormatter(100);
  final shortLength = LengthLimitingTextInputFormatter(8);
  final digitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  final lettersOnly = FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'));
  final noAngles = FilteringTextInputFormatter.deny(RegExp(r'[<>]'));
  final singleDigit = FilteringTextInputFormatter.digitsOnly;
  final singleLine = FilteringTextInputFormatter.singleLineFormatter;

  final formatterCatalog = <Map<String, dynamic>>[
    {
      'name': 'LengthLimitingTextInputFormatter(100)',
      'kind': 'length',
      'rule': 'max 100 chars',
      'sample': 'truncates at the limit',
      'color': Color(0xFF00897B),
    },
    {
      'name': 'LengthLimitingTextInputFormatter(8)',
      'kind': 'length',
      'rule': 'max 8 chars',
      'sample': 'short OTP / PIN field',
      'color': Color(0xFF00897B),
    },
    {
      'name': 'FilteringTextInputFormatter.allow(0-9)',
      'kind': 'allow',
      'rule': r'pattern: [0-9]',
      'sample': '"abc123" -> "123"',
      'color': Color(0xFF1E88E5),
    },
    {
      'name': 'FilteringTextInputFormatter.allow(A-Za-z)',
      'kind': 'allow',
      'rule': r'pattern: [A-Za-z]',
      'sample': '"hi5" -> "hi"',
      'color': Color(0xFF1E88E5),
    },
    {
      'name': 'FilteringTextInputFormatter.deny(<,>)',
      'kind': 'deny',
      'rule': r'pattern: [<>]',
      'sample': '"<b>x" -> "bx"',
      'color': Color(0xFFE53935),
    },
    {
      'name': 'FilteringTextInputFormatter.digitsOnly',
      'kind': 'allow',
      'rule': 'built-in',
      'sample': '"a1b2" -> "12"',
      'color': Color(0xFF1E88E5),
    },
    {
      'name': 'FilteringTextInputFormatter.singleLineFormatter',
      'kind': 'deny',
      'rule': 'strips \\n',
      'sample': '"hi\\nthere" -> "hithere"',
      'color': Color(0xFFE53935),
    },
  ];

  // ============================================================================
  // SECTION 10: MAX LENGTH ENFORCEMENT — overflow strategy enum
  // ============================================================================

  final enforcementData = <Map<String, dynamic>>[];
  for (final enforcement in MaxLengthEnforcement.values) {
    String desc;
    String when;
    if (enforcement.name == 'none') {
      desc = 'Allow text to exceed maxLength.';
      when = 'Show counter only, no hard cap.';
    } else if (enforcement.name == 'enforced') {
      desc = 'Hard-stop input at maxLength characters.';
      when = 'Strict fields (codes, IDs).';
    } else if (enforcement.name == 'truncateAfterCompositionEnds') {
      desc = 'Allow over-length while composing (IME), then truncate.';
      when = 'CJK / IME-friendly fields.';
    } else {
      desc = 'Platform-defined behavior.';
      when = 'Default heuristic.';
    }
    enforcementData.add({
      'name': enforcement.name,
      'index': enforcement.index,
      'desc': desc,
      'when': when,
    });
  }

  // ============================================================================
  // BUILD COCKPIT UI
  // ============================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnnotatedRegion<SystemUiOverlayStyle>(
      value: lightStyle,
      child: Scaffold(
        backgroundColor: Color(0xFFF4F6F8),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ===== HERO HEADER =====
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0D1B2A), Color(0xFF1B263B), Color(0xFF415A77)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              color: Color(0x33FFFFFF),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Color(0x66FFFFFF), width: 1.0),
                            ),
                            child: Center(
                              child: Text(
                                'SYS',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
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
                                  'System Services Cockpit',
                                  style: TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Deep Demo: Flutter services surface — keyboard, haptics, chrome, navigation, text input',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xFFE0E1DD),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          _heroChip('LogicalKeyboardKey'),
                          _heroChip('PhysicalKeyboardKey'),
                          _heroChip('HapticFeedback'),
                          _heroChip('SystemChrome'),
                          _heroChip('SystemUiOverlayStyle'),
                          _heroChip('SystemUiMode'),
                          _heroChip('DeviceOrientation'),
                          _heroChip('SystemNavigator'),
                          _heroChip('TextInputFormatter'),
                          _heroChip('MaxLengthEnforcement'),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.0),

                // ===== CONCEPT OVERVIEW =====
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFF90CAF9), width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF1976D2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'i',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              'Cockpit Overview',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        'The flutter/services library exposes the platform plumbing that '
                        'lives between Dart and the host OS. This cockpit groups the most '
                        'common controls into ten panels so the bridged interpreter can '
                        'document each surface without invoking real side effects.',
                        style: TextStyle(fontSize: 13.0, height: 1.5),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        'Panels in this cockpit:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                      ),
                      SizedBox(height: 6.0),
                      _bulletLine('1. LogicalKeyboardKey  — semantic key identifiers'),
                      _bulletLine('2. PhysicalKeyboardKey — USB HID layout keys'),
                      _bulletLine('3. HapticFeedback      — tactile cue channels'),
                      _bulletLine('4. SystemChrome        — system bar control methods'),
                      _bulletLine('5. SystemUiOverlayStyle — status/nav tint presets'),
                      _bulletLine('6. SystemUiMode        — visibility profiles'),
                      _bulletLine('7. DeviceOrientation   — rotation profiles'),
                      _bulletLine('8. SystemNavigator     — app lifecycle exit / route sync'),
                      _bulletLine('9. TextInputFormatter  — input pipeline filters'),
                      _bulletLine('10. MaxLengthEnforcement — overflow strategy enum'),
                    ],
                  ),
                ),

                SizedBox(height: 24.0),

                // ===== SECTION 1: LOGICAL KEYBOARD KEYS =====
                _sectionContainer(
                  bg: Color(0xFFE8F5E9),
                  border: Color(0xFF81C784),
                  title: '1. LogicalKeyboardKey',
                  titleColor: Color(0xFF2E7D32),
                  subtitle: 'Semantic key identifiers (independent of physical layout).',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Navigation & control keys',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      for (final entry in navKeys)
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFC8E6C9),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44.0,
                                  height: 28.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2E7D32),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      entry['glyph'] as String,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    entry['name'] as String,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    entry['role'] as String,
                                    style: TextStyle(fontSize: 11.0),
                                  ),
                                ),
                                Text(
                                  'id ${(entry['key'] as LogicalKeyboardKey).keyId}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'monospace',
                                    color: Color(0xFF424242),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 12.0),
                      Text(
                        'Function keys',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          for (final fn in functionKeys)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFA5D6A7),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Color(0xFF66BB6A), width: 1.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (fn['name'] as String).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  Text(
                                    fn['role'] as String,
                                    style: TextStyle(fontSize: 10.0),
                                  ),
                                  Text(
                                    'id ${(fn['key'] as LogicalKeyboardKey).keyId}',
                                    style: TextStyle(
                                      fontSize: 9.0,
                                      fontFamily: 'monospace',
                                      color: Color(0xFF424242),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        'Numpad & lock keys',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      for (final np in numpadKeys)
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            children: [
                              Container(
                                width: 90.0,
                                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF388E3C),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  np['name'] as String,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  np['role'] as String,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ),
                              Text(
                                'id ${(np['key'] as LogicalKeyboardKey).keyId}',
                                style: TextStyle(
                                  fontSize: 9.0,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF616161),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 12.0),
                      _recipeCard(
                        bg: Color(0xFFB9F6CA),
                        title: 'Recipe',
                        code: 'if (event.logicalKey == LogicalKeyboardKey.escape) {\n  closeDialog();\n}',
                        codeColor: Color(0xFF1B5E20),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 2: PHYSICAL KEYBOARD KEYS =====
                _sectionContainer(
                  bg: Color(0xFFE0F2F1),
                  border: Color(0xFF4DB6AC),
                  title: '2. PhysicalKeyboardKey',
                  titleColor: Color(0xFF00695C),
                  subtitle: 'USB HID usage codes — tied to the physical key location.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Group',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'USB HID',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
                      for (final pk in physicalKeys)
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFB2DFDB),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    pk['name'] as String,
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00897B),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      pk['group'] as String,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '0x${(pk['key'] as PhysicalKeyboardKey).usbHidUsage.toRadixString(16)}',
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      fontFamily: 'monospace',
                                      color: Color(0xFF004D40),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 12.0),
                      _recipeCard(
                        bg: Color(0xFFB2DFDB),
                        title: 'Logical vs Physical',
                        code:
                            '// Logical = "what the user means"\n// Physical = "which key was pressed (by position)"',
                        codeColor: Color(0xFF004D40),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 3: HAPTIC FEEDBACK =====
                _sectionContainer(
                  bg: Color(0xFFFCE4EC),
                  border: Color(0xFFF06292),
                  title: '3. HapticFeedback',
                  titleColor: Color(0xFFC2185B),
                  subtitle: 'Five tactile cue channels ordered from strong to subtle.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final cue in hapticChannels)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8BBD0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        cue['name'] as String,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF880E4F),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEC407A),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        cue['duration'] as String,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Color(0xFFFFFFFF),
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  cue['method'] as String,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'monospace',
                                    color: Color(0xFF6A1B4D),
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                Row(
                                  children: [
                                    Text(
                                      'Intensity',
                                      style: TextStyle(fontSize: 10.0, color: Color(0xFF424242)),
                                    ),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4.0),
                                        child: LinearProgressIndicator(
                                          value: cue['intensity'] as double,
                                          minHeight: 8.0,
                                          backgroundColor: Color(0xFFFFFFFF),
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD81B60)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      '${((cue['intensity'] as double) * 100).toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Use case: ${cue['cue']}',
                                  style: TextStyle(fontSize: 11.0, color: Color(0xFF424242)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      _recipeCard(
                        bg: Color(0xFFF48FB1),
                        title: 'Pattern',
                        code: 'onTap: () { HapticFeedback.selectionClick(); _select(item); }',
                        codeColor: Color(0xFF880E4F),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 4: SYSTEM CHROME METHODS =====
                _sectionContainer(
                  bg: Color(0xFFFFF3E0),
                  border: Color(0xFFFFB74D),
                  title: '4. SystemChrome',
                  titleColor: Color(0xFFE65100),
                  subtitle: 'Static methods controlling system bars, orientation, and app metadata.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Method',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Category',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
                      for (final m in systemChromeMethods)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE0B2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        m['name'] as String,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'monospace',
                                          color: Color(0xFFBF360C),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFB8C00),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        m['category'] as String,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.0),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF3E2723),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      m['signature'] as String,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontFamily: 'monospace',
                                        color: Color(0xFFFFCC80),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  m['desc'] as String,
                                  style: TextStyle(fontSize: 11.0, color: Color(0xFF4E342E)),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 5: SYSTEM UI OVERLAY STYLE =====
                _sectionContainer(
                  bg: Color(0xFFEDE7F6),
                  border: Color(0xFFB39DDB),
                  title: '5. SystemUiOverlayStyle',
                  titleColor: Color(0xFF4527A0),
                  subtitle: 'Tint presets for status & system-navigation bars.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final preset in overlayPresets)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFD1C4E9),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  preset['name'] as String,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF311B92),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Container(
                                  width: double.infinity,
                                  height: 56.0,
                                  decoration: BoxDecoration(
                                    color: preset['preview'] as Color,
                                    borderRadius: BorderRadius.circular(6.0),
                                    border: Border.all(color: Color(0xFF7E57C2), width: 1.0),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 10.0,
                                        height: 10.0,
                                        decoration: BoxDecoration(
                                          color: preset['iconColor'] as Color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        '12:34',
                                        style: TextStyle(
                                          color: preset['iconColor'] as Color,
                                          fontSize: 12.0,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      Expanded(child: SizedBox(width: 0.0)),
                                      Container(
                                        width: 14.0,
                                        height: 14.0,
                                        decoration: BoxDecoration(
                                          color: preset['iconColor'] as Color,
                                          borderRadius: BorderRadius.circular(3.0),
                                        ),
                                      ),
                                      SizedBox(width: 6.0),
                                      Container(
                                        width: 14.0,
                                        height: 14.0,
                                        decoration: BoxDecoration(
                                          color: preset['iconColor'] as Color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _kv('statusBg', preset['statusBg'] as String),
                                    ),
                                    Expanded(
                                      child: _kv('statusIcons', preset['statusIcons'] as String),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _kv('navBg', preset['navBg'] as String),
                                    ),
                                    Expanded(
                                      child: _kv('navIcons', preset['navIcons'] as String),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      _recipeCard(
                        bg: Color(0xFFB39DDB),
                        title: 'Apply on a route',
                        code: 'AnnotatedRegion<SystemUiOverlayStyle>(\n  value: SystemUiOverlayStyle.dark,\n  child: Scaffold(...),\n)',
                        codeColor: Color(0xFF311B92),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 6: SYSTEM UI MODE =====
                _sectionContainer(
                  bg: Color(0xFFE1F5FE),
                  border: Color(0xFF4FC3F7),
                  title: '6. SystemUiMode',
                  titleColor: Color(0xFF01579B),
                  subtitle: 'Pick how the OS treats status & navigation chrome.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final mode in uiModeData)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFB3E5FC),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0288D1),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      mode['emoji'] as String,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
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
                                            mode['name'] as String,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'monospace',
                                              color: Color(0xFF01579B),
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF0277BD),
                                              borderRadius: BorderRadius.circular(3.0),
                                            ),
                                            child: Text(
                                              '#${mode['index']}',
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 9.0,
                                                fontFamily: 'monospace',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        mode['desc'] as String,
                                        style: TextStyle(fontSize: 11.0, color: Color(0xFF263238)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 8.0),
                      Text(
                        'Comparison',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                      ),
                      SizedBox(height: 6.0),
                      _compRow(['Mode', 'Status bar', 'Nav bar', 'On swipe'], header: true),
                      _compRow(['edgeToEdge', 'visible', 'visible', '-']),
                      _compRow(['immersive', 'hidden', 'hidden', 'reveal']),
                      _compRow(['immersiveSticky', 'hidden', 'hidden', 'peek']),
                      _compRow(['leanBack', 'hidden', 'hidden', 'tap reveals']),
                      _compRow(['manual', 'configured', 'configured', '-']),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 7: DEVICE ORIENTATION =====
                _sectionContainer(
                  bg: Color(0xFFFFF8E1),
                  border: Color(0xFFFFD54F),
                  title: '7. DeviceOrientation',
                  titleColor: Color(0xFFF57F17),
                  subtitle: 'The four rotation profiles a Flutter app may opt into.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 12.0,
                        runSpacing: 12.0,
                        children: [
                          for (final ori in orientationData)
                            Container(
                              width: 160.0,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFECB3),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Color(0xFFFFB300), width: 1.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Transform.rotate(
                                      angle: ((ori['degrees'] as int) * 3.14159265 / 180.0),
                                      child: Container(
                                        width: 30.0,
                                        height: 52.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFA000),
                                          borderRadius: BorderRadius.circular(6.0),
                                          border: Border.all(color: Color(0xFFFF6F00), width: 2.0),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 18.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFFF8E1),
                                              borderRadius: BorderRadius.circular(3.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    ori['name'] as String,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  Text(
                                    '${ori['degrees']}° • ${ori['axis']}',
                                    style: TextStyle(fontSize: 10.0, color: Color(0xFF6D4C41)),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    ori['useCase'] as String,
                                    style: TextStyle(fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      _recipeCard(
                        bg: Color(0xFFFFE082),
                        title: 'Lock to portrait',
                        code:
                            'SystemChrome.setPreferredOrientations(\n  <DeviceOrientation>[DeviceOrientation.portraitUp],\n);',
                        codeColor: Color(0xFF4E342E),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 8: SYSTEM NAVIGATOR =====
                _sectionContainer(
                  bg: Color(0xFFFFEBEE),
                  border: Color(0xFFEF9A9A),
                  title: '8. SystemNavigator',
                  titleColor: Color(0xFFB71C1C),
                  subtitle: 'Talk to the OS about app exit and route history.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final cmd in navigatorCommands)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFCDD2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'SystemNavigator.${cmd['name']}',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'monospace',
                                          color: Color(0xFFB71C1C),
                                        ),
                                      ),
                                    ),
                                    _riskBadge(cmd['risk'] as String),
                                  ],
                                ),
                                SizedBox(height: 6.0),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF263238),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      cmd['signature'] as String,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontFamily: 'monospace',
                                        color: Color(0xFFFFCDD2),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  cmd['desc'] as String,
                                  style: TextStyle(fontSize: 11.0, color: Color(0xFF4E342E)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      _recipeCard(
                        bg: Color(0xFFEF9A9A),
                        title: 'Caution',
                        code:
                            '// SystemNavigator.pop() exits on Android.\n// Prefer Navigator.maybePop(context) inside an app.',
                        codeColor: Color(0xFFB71C1C),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 9: TEXT INPUT FORMATTERS =====
                _sectionContainer(
                  bg: Color(0xFFE8EAF6),
                  border: Color(0xFF7986CB),
                  title: '9. TextInputFormatter',
                  titleColor: Color(0xFF283593),
                  subtitle: 'Filters applied to TextField/TextFormField input on every edit.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final f in formatterCatalog)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFC5CAE9),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        color: f['color'] as Color,
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        (f['kind'] as String).toUpperCase(),
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        f['name'] as String,
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          fontFamily: 'monospace',
                                          color: Color(0xFF1A237E),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1A237E),
                                        borderRadius: BorderRadius.circular(3.0),
                                      ),
                                      child: Text(
                                        f['rule'] as String,
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 10.0,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        f['sample'] as String,
                                        style: TextStyle(fontSize: 10.0, color: Color(0xFF283593)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 12.0),
                      Text(
                        'Live preview field',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Color(0xFF7986CB), width: 1.0),
                        ),
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            lengthFormatter,
                            digitsOnly,
                            noAngles,
                          ],
                          decoration: InputDecoration(
                            labelText: 'Numbers only • max 100 • no <>',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Color(0xFF7986CB), width: 1.0),
                        ),
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            shortLength,
                            lettersOnly,
                            singleLine,
                          ],
                          decoration: InputDecoration(
                            labelText: 'Letters only • max 8 • single line',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      _recipeCard(
                        bg: Color(0xFF9FA8DA),
                        title: 'Chained filters',
                        code:
                            'inputFormatters: <TextInputFormatter>[\n  LengthLimitingTextInputFormatter(8),\n  FilteringTextInputFormatter.digitsOnly,\n],',
                        codeColor: Color(0xFF1A237E),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                // ===== SECTION 10: MAX LENGTH ENFORCEMENT =====
                _sectionContainer(
                  bg: Color(0xFFF1F8E9),
                  border: Color(0xFFAED581),
                  title: '10. MaxLengthEnforcement',
                  titleColor: Color(0xFF33691E),
                  subtitle: 'Enum that decides how an over-length edit is handled.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _compRow(['Value', 'Index', 'Strict?'], header: true),
                      for (final en in enforcementData)
                        _compRow([
                          en['name'] as String,
                          '${en['index']}',
                          en['name'] == 'enforced' ? 'yes' : (en['name'] == 'none' ? 'no' : 'IME-aware'),
                        ]),
                      SizedBox(height: 12.0),
                      for (final en in enforcementData)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFDCEDC8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 26.0,
                                      height: 26.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF558B2F),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${en['index']}',
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: Text(
                                        en['name'] as String,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'monospace',
                                          color: Color(0xFF1B5E20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  en['desc'] as String,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                                SizedBox(height: 2.0),
                                Text(
                                  'When to use: ${en['when']}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xFF424242),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      _recipeCard(
                        bg: Color(0xFFAED581),
                        title: 'Recipe',
                        code:
                            'TextField(\n  maxLength: 8,\n  maxLengthEnforcement: MaxLengthEnforcement.enforced,\n)',
                        codeColor: Color(0xFF1B5E20),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.0),

                // ===== GLOSSARY =====
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFECEFF1),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF546E7A),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'A-Z',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            'Glossary',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263238),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      _glossaryItem(
                        'AnnotatedRegion',
                        'Widget that publishes a value (here, SystemUiOverlayStyle) to ancestors.',
                      ),
                      _glossaryItem(
                        'HID',
                        'Human Interface Device protocol — defines stable usage codes per key.',
                      ),
                      _glossaryItem(
                        'IME',
                        'Input Method Editor — composes CJK characters; impacts length enforcement.',
                      ),
                      _glossaryItem(
                        'keyId',
                        'Logical, layout-independent identifier produced by LogicalKeyboardKey.',
                      ),
                      _glossaryItem(
                        'overlay',
                        'A system-drawn surface (status bar or navigation bar) above app content.',
                      ),
                      _glossaryItem(
                        'route',
                        'A stack entry managed by Navigator; SystemNavigator syncs with the host.',
                      ),
                      _glossaryItem(
                        'usbHidUsage',
                        'Integer code identifying the physical key position (USB HID page 0x07).',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.0),

                // ===== EPILOGUE / SUMMARY =====
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0D1B2A), Color(0xFF1B263B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cockpit Summary',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      _summaryItem('LogicalKeyboardKey panel', 'READY'),
                      _summaryItem('PhysicalKeyboardKey panel', 'READY'),
                      _summaryItem('HapticFeedback panel', 'READY'),
                      _summaryItem('SystemChrome panel', 'READY'),
                      _summaryItem('SystemUiOverlayStyle panel', 'READY'),
                      _summaryItem('SystemUiMode panel', 'READY'),
                      _summaryItem('DeviceOrientation panel', 'READY'),
                      _summaryItem('SystemNavigator panel', 'READY'),
                      _summaryItem('TextInputFormatter panel', 'READY'),
                      _summaryItem('MaxLengthEnforcement panel', 'READY'),
                      SizedBox(height: 12.0),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'System Services Cockpit: ',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              'All Panels Online',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12.0),

                // ===== FOOTER =====
                Center(
                  child: Text(
                    'Deep Demo • System Services Cockpit • flutter/services',
                    style: TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HELPER WIDGETS
// ============================================================================

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Color(0x44FFFFFF), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _bulletLine(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 3.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 12.0, fontFamily: 'monospace'),
    ),
  );
}

Widget _sectionContainer({
  required Color bg,
  required Color border,
  required String title,
  required Color titleColor,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

Widget _recipeCard({
  required Color bg,
  required String title,
  required String code,
  required Color codeColor,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: codeColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              code,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFFB2DFDB),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kv(String key, String value) {
  return Row(
    children: [
      Text(
        '$key:',
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF311B92),
        ),
      ),
      SizedBox(width: 4.0),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF1A237E),
          ),
        ),
      ),
    ],
  );
}

Widget _compRow(List<String> cells, {bool header = false}) {
  return Container(
    margin: EdgeInsets.only(bottom: 2.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: header ? Color(0xFF455A64) : Color(0xFFCFD8DC),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      children: [
        for (final cell in cells)
          Expanded(
            child: Text(
              cell,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                fontWeight: header ? FontWeight.bold : FontWeight.normal,
                color: header ? Color(0xFFFFFFFF) : Color(0xFF263238),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _riskBadge(String risk) {
  Color c;
  String label;
  if (risk == 'high') {
    c = Color(0xFFD32F2F);
    label = 'HIGH';
  } else if (risk == 'med') {
    c = Color(0xFFFB8C00);
    label = 'MED';
  } else {
    c = Color(0xFF388E3C);
    label = 'LOW';
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 9.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _glossaryItem(String term, String definition) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110.0,
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0xFF607D8B),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            term,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            definition,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF37474F)),
          ),
        ),
      ],
    ),
  );
}

Widget _summaryItem(String label, String status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
