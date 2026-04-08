// ignore_for_file: avoid_print
// Deep demo: MouseCursorSession — mouse cursor lifecycle management
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Midnight / Lavender
// ─────────────────────────────────────────────────────────────
const Color _mcMidnight = Color(0xFF1A237E);
const Color _mcLavender = Color(0xFFE8EAF6);
const Color _mcDeepIndigo = Color(0xFF283593);
const Color _mcMedIndigo = Color(0xFF3F51B5);
const Color _mcLightIndigo = Color(0xFFC5CAE9);
const Color _mcWhite = Color(0xFFFFFFFF);
const Color _mcGray = Color(0xFF546E7A);
const Color _mcDarkGray = Color(0xFF263238);
const Color _mcAccentOrange = Color(0xFFFF6F00);
const Color _mcAccentTeal = Color(0xFF00897B);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _mcSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _mcWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _mcLightIndigo, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _mcMidnight,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _mcWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _mcLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _mcDeepIndigo, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _mcBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _mcGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _mcChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _mcInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(key,
              style: const TextStyle(
                  color: _mcDeepIndigo, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _mcGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _mcDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _mcLightIndigo.withValues(alpha: 0.6),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  MouseCursorSession — Deep Demo');
  print('  Mouse cursor lifecycle and activation management');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _mcLavender,
      appBarTheme: const AppBarTheme(
        backgroundColor: _mcMidnight,
        foregroundColor: _mcWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('MouseCursorSession'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildCursorArchitecture(),
            _buildSessionLifecycle(),
            _buildActivationFlow(),
            _buildSystemCursorCatalog(),
            _buildCustomCursorSessions(),
            _buildSessionStacking(),
            _buildMouseRegionInteraction(),
            _buildPlatformIntegration(),
            _buildDebugVisualizations(),
            _buildSummary(),
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 1 — Banner
// ═══════════════════════════════════════════════════════════════
Widget _buildBanner() {
  print('[Section 1] Banner');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_mcMidnight, _mcDeepIndigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x401A237E), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.mouse, size: 52, color: _mcWhite),
        const SizedBox(height: 12),
        const Text('MouseCursorSession',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _mcWhite, fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _mcWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Cursor Lifecycle · Activation · Deactivation',
            style: TextStyle(color: _mcWhite, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _mcChip('services', _mcWhite),
            _mcChip('MouseCursor', _mcWhite),
            _mcChip('Session', _mcWhite),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 2 — What Is It?
// ═══════════════════════════════════════════════════════════════
Widget _buildWhatIsIt() {
  print('[Section 2] What is MouseCursorSession?');
  return _mcSection('What Is MouseCursorSession?', [
    _mcBody(
      'MouseCursorSession is the abstract class that represents an active '
      'instance of a mouse cursor. When a MouseCursor is activated (e.g., '
      'because the mouse pointer entered a MouseRegion), the cursor creates '
      'a session object that manages the cursor\'s state until it is deactivated.',
    ),
    _mcDivider(),
    _mcLabel('Class Hierarchy'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _mcLavender,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mcBody('MouseCursorSession  (abstract base)'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _mcBody('└─ (platform-specific implementations)'),
          ),
          const SizedBox(height: 8),
          _mcBody('MouseCursor  (creates sessions)'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _mcBody('├─ SystemMouseCursor  → system session'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _mcBody('├─ MaterialStateMouseCursor  → delegated session'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _mcBody('└─ _DeferringMouseCursor  → deferred session'),
          ),
        ],
      ),
    ),
    _mcDivider(),
    _mcLabel('Key Concept'),
    _mcBody(
      'Think of MouseCursor as a factory and MouseCursorSession as the product. '
      'The cursor describes what the cursor should look like, while the session '
      'manages the actual OS-level cursor state. Sessions have activate() and '
      'dispose() methods for lifecycle management.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — Cursor Architecture
// ═══════════════════════════════════════════════════════════════
Widget _buildCursorArchitecture() {
  print('[Section 3] Mouse cursor architecture');

  Widget archBox(String label, String detail, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: color, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(detail,
                    style: const TextStyle(color: _mcGray, fontSize: 11.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _mcSection('Cursor System Architecture', [
    _mcBody(
      'The Flutter mouse cursor system involves several cooperating layers. '
      'Understanding the full architecture helps explain why sessions exist.',
    ),
    _mcDivider(),
    archBox('MouseTracker',
        'Tracks all mouse devices and their current cursor states across the render tree',
        _mcMidnight, Icons.track_changes),
    archBox('MouseRegion / RenderMouseRegion',
        'Declares which cursor should be active when the mouse enters a region',
        _mcDeepIndigo, Icons.crop_square),
    archBox('MouseCursor',
        'Describes a cursor appearance and creates sessions via createSession()',
        _mcMedIndigo, Icons.mouse),
    archBox('MouseCursorSession',
        'Active instance that communicates with the OS to change the cursor',
        _mcAccentOrange, Icons.play_circle_outline),
    archBox('Platform Channel',
        'Sends cursor change events to native code (SystemChannels.mouseCursor)',
        _mcAccentTeal, Icons.send),
    _mcDivider(),
    _mcBody(
      'The flow is: MouseRegion declares a cursor → MouseTracker detects '
      'the mouse entering the region → MouseCursor.createSession() is called → '
      'the session\'s activate() method sends the change to the platform.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — Session Lifecycle
// ═══════════════════════════════════════════════════════════════
Widget _buildSessionLifecycle() {
  print('[Section 4] Session lifecycle states');

  Widget stateBox(String name, String description, Color color,
      {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: isActive ? 2.5 : 1),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(description,
                    style: const TextStyle(color: _mcGray, fontSize: 11.5)),
              ],
            ),
          ),
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('ACTIVE',
                  style: TextStyle(
                      color: _mcWhite,
                      fontSize: 9,
                      fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }

  Widget arrow(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.arrow_downward, size: 14, color: _mcLightIndigo),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: _mcGray.withValues(alpha: 0.7), fontSize: 11)),
        ],
      ),
    );
  }

  return _mcSection('Session Lifecycle', [
    _mcBody(
      'A MouseCursorSession goes through a well-defined lifecycle:',
    ),
    _mcDivider(),
    stateBox('Created', 'cursor.createSession(deviceId) called by MouseTracker',
        const Color(0xFF9E9E9E)),
    arrow('session.activate()'),
    stateBox('Activated',
        'Platform cursor changed via SystemChannels.mouseCursor',
        _mcAccentTeal, isActive: true),
    arrow('mouse leaves region / new cursor assigned'),
    stateBox('Disposed',
        'session.dispose() called — cursor resources released',
        const Color(0xFFE53935)),
    _mcDivider(),
    _mcLabel('Session Contract'),
    _mcInfoRow('activate()', 'Must send the cursor change to the platform'),
    _mcInfoRow('dispose()', 'Must clean up any resources held by the session'),
    _mcInfoRow('cursor', 'Reference back to the MouseCursor that created this session'),
    _mcInfoRow('device', 'The mouse device ID this session applies to'),
    _mcDivider(),
    _mcBody(
      'Note: activate() may be called multiple times on the same session '
      '(e.g., when the framework needs to re-apply the cursor). Each call '
      'should be idempotent — requesting the same cursor again is a no-op.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Activation / Deactivation Flow
// ═══════════════════════════════════════════════════════════════
Widget _buildActivationFlow() {
  print('[Section 5] Activation and deactivation flow');
  return _mcSection('Activation & Deactivation', [
    _mcBody(
      'When the mouse moves between MouseRegions, sessions are activated and '
      'deactivated in a coordinated sequence:',
    ),
    _mcDivider(),
    // Scenario visualization
    Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _mcLavender,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mcLabel('Scenario: Mouse Moves Between Two Regions'),
          const SizedBox(height: 8),
          // Two regions side by side
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: _mcMedIndigo.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _mcMedIndigo),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.text_fields, size: 20, color: _mcMedIndigo),
                      const SizedBox(height: 4),
                      const Text('Region A',
                          style: TextStyle(
                              color: _mcMedIndigo,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      const Text('cursor: text',
                          style: TextStyle(color: _mcGray, fontSize: 10)),
                    ],
                  ),
                ),
              ),
              // Arrow
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const Icon(Icons.arrow_forward, size: 20, color: _mcAccentOrange),
                    const Text('mouse\nmoves',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _mcAccentOrange, fontSize: 9)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: _mcAccentTeal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _mcAccentTeal),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.pan_tool, size: 20, color: _mcAccentTeal),
                      const SizedBox(height: 4),
                      const Text('Region B',
                          style: TextStyle(
                              color: _mcAccentTeal,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      const Text('cursor: grab',
                          style: TextStyle(color: _mcGray, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _mcBody('1. MouseTracker detects pointer entered Region B'),
          _mcBody('2. Old session (text cursor) → dispose()'),
          _mcBody('3. New cursor (grab) → createSession(deviceId)'),
          _mcBody('4. New session → activate()'),
          _mcBody('5. Platform receives "set cursor: grab" message'),
        ],
      ),
    ),
    _mcDivider(),
    _mcLabel('Edge Cases'),
    _mcBody(
      '• Same cursor in both regions → session is reused, no activate()\n'
      '• Mouse exits all regions → session disposed, default cursor restored\n'
      '• Cursor changes while mouse is stationary → old disposed, new created\n'
      '• Multiple mouse devices → each device has its own session',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — System Cursor Catalog
// ═══════════════════════════════════════════════════════════════
Widget _buildSystemCursorCatalog() {
  print('[Section 6] System cursor visual catalog');

  Widget cursorCard(String name, IconData icon, String description, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _mcWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _mcLightIndigo),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 18, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(description,
                    style: const TextStyle(color: _mcGray, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _mcSection('System Cursor Catalog', [
    _mcBody(
      'Each SystemMouseCursor creates a specific session type. Here are '
      'the built-in system cursors that Flutter supports:',
    ),
    _mcDivider(),
    _mcLabel('Basic Cursors'),
    cursorCard('basic', Icons.mouse, 'Default arrow pointer', _mcMidnight),
    cursorCard('click', Icons.touch_app, 'Hand pointer for clickable elements', _mcDeepIndigo),
    cursorCard('text', Icons.text_fields, 'I-beam for text selection', _mcMedIndigo),
    cursorCard('forbidden', Icons.block, 'Circle-slash for disabled areas', const Color(0xFFE53935)),
    cursorCard('none', Icons.visibility_off, 'Hidden cursor (invisible)', _mcGray),
    _mcDivider(),
    _mcLabel('Resize Cursors'),
    cursorCard('resizeUp', Icons.arrow_upward, 'Resize handle pointing up', _mcAccentTeal),
    cursorCard('resizeDown', Icons.arrow_downward, 'Resize handle pointing down', _mcAccentTeal),
    cursorCard('resizeLeft', Icons.arrow_back, 'Resize handle pointing left', _mcAccentTeal),
    cursorCard('resizeRight', Icons.arrow_forward, 'Resize handle pointing right', _mcAccentTeal),
    cursorCard('resizeUpDown', Icons.swap_vert, 'Vertical resize (↕)', _mcAccentTeal),
    cursorCard('resizeLeftRight', Icons.swap_horiz, 'Horizontal resize (↔)', _mcAccentTeal),
    _mcDivider(),
    _mcLabel('Drag & Move Cursors'),
    cursorCard('grab', Icons.pan_tool, 'Open hand for grabbable content', _mcAccentOrange),
    cursorCard('grabbing', Icons.back_hand, 'Closed hand during drag', _mcAccentOrange),
    cursorCard('move', Icons.open_with, 'Four-direction move indicator', _mcAccentOrange),
    cursorCard('allScroll', Icons.drag_indicator, 'Scroll in all directions', _mcAccentOrange),
    _mcDivider(),
    _mcLabel('Special Cursors'),
    cursorCard('wait', Icons.hourglass_top, 'Busy/loading cursor (spinner)', _mcDeepIndigo),
    cursorCard('progress', Icons.hourglass_bottom, 'Background activity indicator', _mcDeepIndigo),
    cursorCard('help', Icons.help_outline, 'Question mark for help context', _mcDeepIndigo),
    cursorCard('cell', Icons.grid_4x4, 'Cell/crosshair selection', _mcDeepIndigo),
    cursorCard('precise', Icons.gps_fixed, 'Crosshair for precision', _mcDeepIndigo),
    cursorCard('copy', Icons.copy, 'Copy indicator during drag', _mcDeepIndigo),
    cursorCard('alias', Icons.shortcut, 'Alias/shortcut creation', _mcDeepIndigo),
    cursorCard('noDrop', Icons.do_not_disturb, 'Cannot drop here indicator', const Color(0xFFE53935)),
    cursorCard('disappearing', Icons.exit_to_app, 'Item will be removed if dropped', _mcGray),
    _mcDivider(),
    _mcBody(
      'Each cursor kind maps to a platform-specific cursor constant. '
      'When the session is activated, the cursor name is sent via '
      'SystemChannels.mouseCursor to the platform.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Custom Cursor Sessions
// ═══════════════════════════════════════════════════════════════
Widget _buildCustomCursorSessions() {
  print('[Section 7] Custom cursor sessions');
  return _mcSection('Custom Cursor Sessions', [
    _mcBody(
      'While system cursors cover most use cases, developers can create '
      'custom MouseCursor subclasses with custom session behavior:',
    ),
    _mcDivider(),
    _mcLabel('Creating a Custom Cursor'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _mcLavender,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mcBody('class AnimatedCursor extends MouseCursor {'),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('@override'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('MouseCursorSession createSession(int device) {'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: _mcBody('return AnimatedCursorSession(cursor: this, device: device);'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('}'),
          ),
          _mcBody('}'),
          const SizedBox(height: 8),
          _mcBody('class AnimatedCursorSession extends MouseCursorSession {'),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('@override'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('Future<void> activate() async {'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: _mcBody('// Send cursor data to platform'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('}'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('@override'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('void dispose() {'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: _mcBody('// Clean up animation resources'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _mcBody('}'),
          ),
          _mcBody('}'),
        ],
      ),
    ),
    _mcDivider(),
    _mcLabel('Use Cases for Custom Sessions'),
    _mcBody(
      '• Animated cursors that change appearance over time\n'
      '• Application-specific cursor images loaded at runtime\n'
      '• Theme-dependent cursors that match the app\'s color scheme\n'
      '• Platform-specific cursor fallbacks\n'
      '• Cursors that track state (e.g., tool selection in a drawing app)',
    ),
    _mcDivider(),
    _mcBody(
      'Custom sessions should be idempotent in their activate() method and '
      'must properly release resources in dispose(). The framework may call '
      'activate() multiple times before dispose() is called.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Session Stacking
// ═══════════════════════════════════════════════════════════════
Widget _buildSessionStacking() {
  print('[Section 8] Session stacking with nested regions');
  return _mcSection('Session Stacking', [
    _mcBody(
      'When MouseRegions are nested, the innermost region\'s cursor takes '
      'priority. The session system handles this through a stack-like '
      'resolution mechanism.',
    ),
    _mcDivider(),
    _mcLabel('Nested Region Priority'),
    // Nested boxes visualization
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _mcMidnight.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _mcMidnight, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.mouse, size: 14, color: _mcMidnight),
              const SizedBox(width: 4),
              const Text('Outer Region: cursor.basic (arrow)',
                  style: TextStyle(color: _mcMidnight, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _mcMedIndigo.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _mcMedIndigo, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.touch_app, size: 14, color: _mcMedIndigo),
                    const SizedBox(width: 4),
                    const Text('Middle Region: cursor.click (hand)',
                        style: TextStyle(
                            color: _mcMedIndigo,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _mcAccentOrange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _mcAccentOrange, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.text_fields, size: 20, color: _mcAccentOrange),
                        const SizedBox(height: 4),
                        const Text('Inner: cursor.text',
                            style: TextStyle(
                                color: _mcAccentOrange,
                                fontSize: 11,
                                fontWeight: FontWeight.w700)),
                        const Text('(takes priority ★)',
                            style: TextStyle(color: _mcAccentOrange, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    _mcDivider(),
    _mcLabel('Resolution Rules'),
    _mcBody(
      '1. Innermost MouseRegion that contains the pointer wins\n'
      '2. If the inner region has cursor: MouseCursor.defer, the parent\'s cursor is used\n'
      '3. If all regions defer, SystemMouseCursors.basic is the fallback\n'
      '4. Session is only created for the resolved cursor, not intermediate ones',
    ),
    _mcDivider(),
    _mcLabel('MouseCursor.defer'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _mcAccentTeal.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _mcAccentTeal.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_upward, size: 20, color: _mcAccentTeal),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MouseCursor.defer',
                    style: TextStyle(
                        color: _mcAccentTeal,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _mcBody(
                  'A special cursor that means "use the parent region\'s cursor". '
                  'This allows transparent overlay regions that don\'t interfere '
                  'with cursor behavior. No session is created for defer.',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — MouseRegion Interaction
// ═══════════════════════════════════════════════════════════════
Widget _buildMouseRegionInteraction() {
  print('[Section 9] MouseRegion and session interaction');
  return _mcSection('MouseRegion Integration', [
    _mcBody(
      'MouseRegion is the primary widget for declaring cursor behavior. '
      'It triggers session creation via the MouseTracker:',
    ),
    _mcDivider(),
    _mcLabel('MouseRegion Properties Affecting Sessions'),
    _mcInfoRow('cursor', 'The MouseCursor to use (creates the session)'),
    _mcInfoRow('onEnter', 'Called when mouse enters — session activated before this'),
    _mcInfoRow('onExit', 'Called when mouse exits — session disposed after this'),
    _mcInfoRow('onHover', 'Called during movement — session remains active'),
    _mcInfoRow('opaque', 'Whether the region blocks hit testing for regions below'),
    _mcDivider(),
    // Visual timeline
    _mcLabel('Event Timeline'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _mcLavender,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTimelineEvent('Mouse enters region', 'create & activate session',
              _mcAccentTeal, Icons.login),
          _buildTimelineEvent('Mouse moves within', 'session stays active, onHover fires',
              _mcMedIndigo, Icons.open_with),
          _buildTimelineEvent('Widget rebuilds with new cursor',
              'old session disposed, new session created',
              _mcAccentOrange, Icons.refresh),
          _buildTimelineEvent('Mouse leaves region', 'session disposed, fallback activated',
              const Color(0xFFE53935), Icons.logout),
        ],
      ),
    ),
    _mcDivider(),
    _mcLabel('Common Patterns'),
    // Interactive demo — colored regions
    Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: _mcMidnight.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _mcMidnight.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.touch_app, size: 18, color: _mcMidnight),
                const Text('Button',
                    style: TextStyle(color: _mcMidnight, fontSize: 11)),
                const Text('→ click',
                    style: TextStyle(color: _mcGray, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: _mcDeepIndigo.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _mcDeepIndigo.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.text_fields, size: 18, color: _mcDeepIndigo),
                const Text('TextField',
                    style: TextStyle(color: _mcDeepIndigo, fontSize: 11)),
                const Text('→ text',
                    style: TextStyle(color: _mcGray, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: _mcAccentOrange.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _mcAccentOrange.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.pan_tool, size: 18, color: _mcAccentOrange),
                const Text('Draggable',
                    style: TextStyle(color: _mcAccentOrange, fontSize: 11)),
                const Text('→ grab',
                    style: TextStyle(color: _mcGray, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: _mcAccentTeal.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _mcAccentTeal.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.swap_horiz, size: 18, color: _mcAccentTeal),
                const Text('Resize',
                    style: TextStyle(color: _mcAccentTeal, fontSize: 11)),
                const Text('→ resizeLR',
                    style: TextStyle(color: _mcGray, fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    ),
  ]);
}

Widget _buildTimelineEvent(String event, String detail, Color color, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, size: 14, color: _mcWhite),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w600)),
              Text(detail, style: const TextStyle(color: _mcGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Platform Integration
// ═══════════════════════════════════════════════════════════════
Widget _buildPlatformIntegration() {
  print('[Section 10] Platform integration details');
  return _mcSection('Platform Integration', [
    _mcBody(
      'Mouse cursor sessions communicate with the native platform through '
      'a standardized channel. The mapping varies by platform:',
    ),
    _mcDivider(),
    // Platform mapping table
    _mcLabel('Platform Channel: SystemChannels.mouseCursor'),
    _mcInfoRow('Method', 'activateSystemCursor'),
    _mcInfoRow('Arguments', '{device: int, kind: String}'),
    _mcInfoRow('Return', 'Future<void> (completes when cursor set)'),
    _mcDivider(),
    _mcLabel('Cursor Mapping by Platform'),
    _buildPlatformCursorMap('Windows', 'IDC_ARROW, IDC_HAND, IDC_IBEAM, ...',
        Icons.desktop_windows, _mcMidnight),
    _buildPlatformCursorMap('macOS', 'NSCursor.arrow, .pointingHand, .iBeam, ...',
        Icons.laptop_mac, _mcDeepIndigo),
    _buildPlatformCursorMap('Linux/GTK', 'GDK_ARROW, GDK_HAND2, GDK_XTERM, ...',
        Icons.computer, _mcMedIndigo),
    _buildPlatformCursorMap('Web', 'CSS cursor: default, pointer, text, ...',
        Icons.public, _mcAccentTeal),
    _buildPlatformCursorMap('Android', 'Not applicable (touch only)',
        Icons.android, _mcGray),
    _buildPlatformCursorMap('iOS', 'Not applicable (touch only)',
        Icons.phone_iphone, _mcGray),
    _mcDivider(),
    _mcBody(
      'Mouse cursor sessions are only meaningful on desktop and web platforms '
      'where a pointing device is available. On touch-only platforms (Android, '
      'iOS), sessions are still created but activate() is essentially a no-op.',
    ),
  ]);
}

Widget _buildPlatformCursorMap(
    String platform, String mapping, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        SizedBox(
          width: 75,
          child: Text(platform,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.w700)),
        ),
        Expanded(
          child: Text(mapping,
              style: const TextStyle(color: _mcGray, fontSize: 11)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Debug Visualizations
// ═══════════════════════════════════════════════════════════════
Widget _buildDebugVisualizations() {
  print('[Section 11] Debug visualizations for cursor regions');
  return _mcSection('Debug Visualizations', [
    _mcBody(
      'When debugging cursor behavior, it helps to visualize which regions '
      'exist and which cursor each region registers:',
    ),
    _mcDivider(),
    // Simulated debug overlay
    _mcLabel('Simulated Debug Overlay'),
    Container(
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _mcDarkGray),
      ),
      child: Stack(
        children: [
          // Grid lines
          Positioned.fill(child: CustomPaint(painter: _DebugGridPainter())),
          // Region outlines with labels
          Positioned(
            left: 10,
            top: 10,
            right: 10,
            bottom: 60,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x8000FF00), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text('MouseRegion: basic',
                      style: TextStyle(color: Color(0x8000FF00), fontSize: 9)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 40,
            width: 140,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x80FFFF00), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: const Color(0x40FFFF00),
                    child: const Text('click',
                        style: TextStyle(color: Color(0xFFFFFF00), fontSize: 9)),
                  ),
                  const Expanded(
                    child: Center(
                      child: Icon(Icons.touch_app, size: 24, color: Color(0x60FFFF00)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 40,
            width: 120,
            height: 80,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x80FF6600), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: const Color(0x40FF6600),
                    child: const Text('text',
                        style: TextStyle(color: Color(0xFFFF6600), fontSize: 9)),
                  ),
                  const Expanded(
                    child: Center(
                      child: Icon(Icons.text_fields, size: 24, color: Color(0x60FF6600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Mouse position indicator
          Positioned(
            left: 70,
            top: 80,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _mcWhite,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFF0000), width: 1.5),
              ),
            ),
          ),
          // Debug info panel
          Positioned(
            left: 10,
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xCC000000),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                  Text('Active: ',
                      style: TextStyle(color: Color(0xFF888888), fontSize: 10)),
                  Text('SystemMouseCursor(click) ',
                      style: TextStyle(color: Color(0xFFFFFF00), fontSize: 10)),
                  Text('| Device: 0 | Session: active',
                      style: TextStyle(color: Color(0xFF888888), fontSize: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    _mcDivider(),
    _mcLabel('Debug Techniques'),
    _mcBody(
      '• Enable debugPrintMouseCursorEvents for console logging\n'
      '• Use debugDescribeChildren() on MouseTracker\n'
      '• Check RendererBinding.instance.mouseTracker for active sessions\n'
      '• Paint overlay borders on MouseRegion widgets during development',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 12] Summary');
  print('MouseCursorSession deep demo complete.');
  return _mcSection('Summary', [
    _mcBody(
      'MouseCursorSession is the runtime representation of an active mouse '
      'cursor. It bridges the gap between Flutter\'s declarative cursor '
      'system (MouseCursor + MouseRegion) and the imperative platform cursor API.',
    ),
    _mcDivider(),
    _mcLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _mcMidnight.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mcBody('✦ MouseCursor creates sessions via createSession(device)'),
          _mcBody('✦ Sessions manage activate() and dispose() lifecycle'),
          _mcBody('✦ MouseTracker coordinates session switching between regions'),
          _mcBody('✦ Innermost MouseRegion with a non-defer cursor wins'),
          _mcBody('✦ Sessions communicate via SystemChannels.mouseCursor'),
          _mcBody('✦ Platform mapping varies (Win32, NSCursor, GDK, CSS)'),
          _mcBody('✦ Only meaningful on desktop/web (no-op on mobile)'),
          _mcBody('✦ 24+ built-in SystemMouseCursor kinds available'),
        ],
      ),
    ),
    _mcDivider(),
    Wrap(
      children: [
        _mcChip('MouseCursorSession', _mcMidnight),
        _mcChip('MouseTracker', _mcDeepIndigo),
        _mcChip('MouseRegion', _mcMedIndigo),
        _mcChip('SystemMouseCursor', _mcAccentOrange),
        _mcChip('Platform Channel', _mcAccentTeal),
      ],
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Custom painter — debug grid for cursor region visualization
// ═══════════════════════════════════════════════════════════════
class _DebugGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x15FFFFFF)
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 25) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 0; x < size.width; x += 25) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
