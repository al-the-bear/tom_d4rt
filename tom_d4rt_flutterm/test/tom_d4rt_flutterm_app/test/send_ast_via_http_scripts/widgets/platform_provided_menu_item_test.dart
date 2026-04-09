// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PlatformProvidedMenuItem — Complete Deep Dive
///
/// Palette: Pine / Evergreen (deep forest greens)
/// Primary:   Color(0xFF2E7D32) — Green 800
/// Secondary: Color(0xFF388E3C) — Green 700
/// Accent:    Color(0xFF66BB6A) — Green 400
/// Surface:   Color(0xFFE8F5E9) — Green 50
/// Deep:      Color(0xFF1B5E20) — Green 900
/// Muted:     Color(0xFFA5D6A7) — Green 200
/// Warm:      Color(0xFF4CAF50) — Green 500
/// Highlight: Color(0xFFC8E6C9) — Green 100
/// Light:     Color(0xFFF1F8E9) — Light Green 50
/// Dark:      Color(0xFF33691E) — Light Green 900

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PlatformProvidedMenuItem — Complete Deep Dive       ██');
  print('██   Platform-native menu items for system integration    ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const green800 = Color(0xFF2E7D32);
  const green700 = Color(0xFF388E3C);
  const green400 = Color(0xFF66BB6A);
  const green50 = Color(0xFFE8F5E9);
  const green900 = Color(0xFF1B5E20);
  const green200 = Color(0xFFA5D6A7);
  const green500 = Color(0xFF4CAF50);
  const green100 = Color(0xFFC8E6C9);
  const lightGreen50 = Color(0xFFF1F8E9);
  const lightGreen900 = Color(0xFF33691E);

  // ─── Section 2: What Is PlatformProvidedMenuItem? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PlatformProvidedMenuItem?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PlatformProvidedMenuItem represents a menu item that is');
  print('  provided and rendered by the host operating system.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Unlike regular PlatformMenuItem, this item maps to  │');
  print('  │  a platform-specific built-in action. On macOS these │');
  print('  │  include "About", "Quit", "Hide", "Services", etc.  │');
  print('  │                                                       │');
  print('  │  The platform knows the label, icon, shortcut, and   │');
  print('  │  the action — Flutter just says "add this type" and  │');
  print('  │  the OS provides all the details.                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Class Definition ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Class Definition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class PlatformProvidedMenuItem extends PlatformMenuItem{│');
  print('  │    const PlatformProvidedMenuItem({                    │');
  print('  │      required this.type,  // PlatformProvidedMenuItemType│');
  print('  │      this.enabled = true, // can be disabled          │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    final PlatformProvidedMenuItemType type;           │');
  print('  │    final bool enabled;                                │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    Iterable<Map<String, Object?>>                     │');
  print('  │    toChannelRepresentation(...) { ... }               │');
  print('  │                                                       │');
  print('  │    static bool hasMenu(                               │');
  print('  │      PlatformProvidedMenuItemType menu);              │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Two properties: type (which platform item) and enabled.');
  print('  hasMenu() checks if the current platform supports the type.');
  print('');

  // ─── Section 4: Inheritance Chain ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Inheritance Chain');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  DiagnosticableTree                                   │');
  print('  │    └─ Widget                                          │');
  print('  │       └─ StatelessWidget                              │');
  print('  │          └─ PlatformMenuItem                          │');
  print('  │             └─ PlatformProvidedMenuItem  ◄── this     │');
  print('  │                                                       │');
  print('  │  It IS a widget (StatelessWidget), but its build()   │');
  print('  │  returns const SizedBox.shrink() — it never renders  │');
  print('  │  in the Flutter UI. Its purpose is to describe data   │');
  print('  │  for the platform delegate.                           │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: Key Difference from PlatformMenuItem ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Key Difference from PlatformMenuItem');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────┬───────────────────────────┐');
  print('  │  PlatformMenuItem         │ PlatformProvidedMenuItem  │');
  print('  ├──────────────────────────┼───────────────────────────┤');
  print('  │  You define label         │ OS provides label         │');
  print('  │  You define shortcut      │ OS provides shortcut      │');
  print('  │  You define onSelected    │ OS provides action        │');
  print('  │  Custom behavior          │ Standard OS behavior      │');
  print('  │  Works any platform       │ Platform check needed     │');
  print('  │  Fully controlled         │ Partially delegated       │');
  print('  └──────────────────────────┴───────────────────────────┘');
  print('');
  print('  PlatformMenuItem = you control everything');
  print('  PlatformProvidedMenuItem = OS controls appearance + action');
  print('');

  // ─── Section 6: hasMenu() Static Method ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: hasMenu() Static Method');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformProvidedMenuItem.hasMenu(                    │');
  print('  │    PlatformProvidedMenuItemType.about,                │');
  print('  │  )                                                    │');
  print('  │  // → true on macOS                                   │');
  print('  │  // → false on Windows, Linux, Android, iOS, Web     │');
  print('  │                                                       │');
  print('  │  Implementation checks DefaultTargetPlatform:         │');
  print('  │  static bool hasMenu(PlatformProvidedMenuItemType t) {│');
  print('  │    switch (defaultTargetPlatform) {                   │');
  print('  │      case TargetPlatform.macOS:                       │');
  print('  │        return true; // all types available on macOS   │');
  print('  │      default:                                         │');
  print('  │        return false;                                  │');
  print('  │    }                                                  │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Use hasMenu() to conditionally include platform items.');
  print('');

  // ─── Section 7: toChannelRepresentation ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: toChannelRepresentation()');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  When the delegate sends menus to the platform, each │');
  print('  │  item is serialized via toChannelRepresentation():    │');
  print('  │                                                       │');
  print('  │  Returns an iterable containing a Map like:           │');
  print('  │  {                                                    │');
  print('  │    "platformProvidedMenu": 0,  // enum index          │');
  print('  │    "enabled": true,                                   │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  The platform side maps the index back to the         │');
  print('  │  appropriate native menu type:                        │');
  print('  │  0 = about, 1 = quit, 2 = servicesSubmenu, etc.      │');
  print('  │                                                       │');
  print('  │  No label, shortcut, or callback needed — the OS      │');
  print('  │  knows all of that for platform-provided items.       │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Usage in PlatformMenuBar ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Usage in PlatformMenuBar');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformMenuBar(                                     │');
  print('  │    menus: [                                           │');
  print('  │      PlatformMenu(                                    │');
  print('  │        label: "MyApp",                                │');
  print('  │        menus: [                                       │');
  print('  │          PlatformProvidedMenuItem(                     │');
  print('  │            type: PlatformProvidedMenuItemType.about,   │');
  print('  │          ),                                           │');
  print('  │          PlatformProvidedMenuItem(                     │');
  print('  │            type: PlatformProvidedMenuItemType         │');
  print('  │                .servicesSubmenu,                       │');
  print('  │          ),                                           │');
  print('  │          PlatformProvidedMenuItem(                     │');
  print('  │            type: PlatformProvidedMenuItemType.hide,    │');
  print('  │          ),                                           │');
  print('  │          PlatformProvidedMenuItem(                     │');
  print('  │            type: PlatformProvidedMenuItemType.quit,    │');
  print('  │          ),                                           │');
  print('  │        ],                                             │');
  print('  │      ),                                               │');
  print('  │      PlatformMenu(                                    │');
  print('  │        label: "File",                                 │');
  print('  │        menus: [                                       │');
  print('  │          PlatformMenuItem(                             │');
  print('  │            label: "New",                              │');
  print('  │            onSelected: () { ... },                    │');
  print('  │          ),                                           │');
  print('  │        ],                                             │');
  print('  │      ),                                               │');
  print('  │    ],                                                 │');
  print('  │    child: MyApp(),                                    │');
  print('  │  )                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Typically the app-name menu mixes PlatformProvidedMenuItems');
  print('  with a few custom PlatformMenuItems.');
  print('');

  // ─── Section 9: Conditional Platform Usage ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Conditional Platform Usage');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  // Only add platform items on supported platforms:   │');
  print('  │                                                       │');
  print('  │  PlatformMenu(                                        │');
  print('  │    label: "MyApp",                                    │');
  print('  │    menus: [                                           │');
  print('  │      if (PlatformProvidedMenuItem.hasMenu(            │');
  print('  │          PlatformProvidedMenuItemType.about))          │');
  print('  │        PlatformProvidedMenuItem(                       │');
  print('  │          type: PlatformProvidedMenuItemType.about,     │');
  print('  │        ),                                             │');
  print('  │      if (PlatformProvidedMenuItem.hasMenu(            │');
  print('  │          PlatformProvidedMenuItemType.quit))           │');
  print('  │        PlatformProvidedMenuItem(                       │');
  print('  │          type: PlatformProvidedMenuItemType.quit,      │');
  print('  │        ),                                             │');
  print('  │    ],                                                 │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  This way the menu gracefully degrades on unsupported │');
  print('  │  platforms instead of showing empty items.             │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: All 12 Type Values ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: All 12 PlatformProvidedMenuItemType Values');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────┬────────────────────────┐');
  print('  │  Type                         │ macOS Action           │');
  print('  ├──────────────────────────────┼────────────────────────┤');
  print('  │  about                        │ Show About dialog      │');
  print('  │  quit                         │ Quit application       │');
  print('  │  servicesSubmenu              │ macOS Services ▸       │');
  print('  │  hide                         │ Hide application       │');
  print('  │  hideOtherApplications        │ Hide Others            │');
  print('  │  showAllApplications          │ Show All               │');
  print('  │  startSpeaking                │ Start speaking text    │');
  print('  │  stopSpeaking                 │ Stop speaking text     │');
  print('  │  toggleFullScreen             │ Toggle full screen     │');
  print('  │  minimizeWindow               │ Minimize window        │');
  print('  │  zoomWindow                   │ Zoom / maximize window │');
  print('  │  arrangeWindowsInFront        │ Bring all to front     │');
  print('  └──────────────────────────────┴────────────────────────┘');
  print('');

  // ─── Section 11: enabled Property ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: enabled Property');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformProvidedMenuItem(                            │');
  print('  │    type: PlatformProvidedMenuItemType.quit,           │');
  print('  │    enabled: false,  // grays out on macOS             │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  When enabled = false:                                │');
  print('  │  • macOS: item appears grayed out, not clickable      │');
  print('  │  • Serialized as "enabled": false in channel data     │');
  print('  │  • Platform respects this for appearance only         │');
  print('  │                                                       │');
  print('  │  Default is true. Disabling a platform item is        │');
  print('  │  uncommon but useful for "Save" when no document      │');
  print('  │  is modified.                                         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Diagnostics and Debugging ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Diagnostics and Debugging');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformProvidedMenuItem has debugFillProperties():  │');
  print('  │                                                       │');
  print('  │  void debugFillProperties(DiagnosticPropertiesBuilder │');
  print('  │      properties) {                                    │');
  print('  │    super.debugFillProperties(properties);             │');
  print('  │    properties.add(EnumProperty("type", type));        │');
  print('  │    properties.add(                                    │');
  print('  │      FlagProperty("enabled",                          │');
  print('  │        value: enabled,                                │');
  print('  │        ifFalse: "DISABLED",                           │');
  print('  │      ),                                               │');
  print('  │    );                                                 │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  In devtools, you see:                                │');
  print('  │    PlatformProvidedMenuItem(type: about)              │');
  print('  │    PlatformProvidedMenuItem(type: quit, DISABLED)     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 13: Standard macOS Menu Layout ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Standard macOS Menu Layout');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Apple Human Interface Guidelines recommend this layout:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  App Menu (bold)                                      │');
  print('  │  ├── About MyApp                 (platform-provided)  │');
  print('  │  ├── ─────────────── (separator)                      │');
  print('  │  ├── Preferences...              (custom)             │');
  print('  │  ├── ─────────────── (separator)                      │');
  print('  │  ├── Services ▸                  (platform-provided)  │');
  print('  │  ├── ─────────────── (separator)                      │');
  print('  │  ├── Hide MyApp                  (platform-provided)  │');
  print('  │  ├── Hide Others                 (platform-provided)  │');
  print('  │  ├── Show All                    (platform-provided)  │');
  print('  │  ├── ─────────────── (separator)                      │');
  print('  │  └── Quit MyApp                  (platform-provided)  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Using PlatformProvidedMenuItem ensures these items look');
  print('  and behave exactly as users expect on macOS.');
  print('');

  // ─── Section 14: Common Patterns ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Common Patterns');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Pattern 1: App Menu with standard items              │');
  print('  │  PlatformMenu(label: "MyApp", menus: [                │');
  print('  │    PPI(type: about),                                  │');
  print('  │    PPI(type: servicesSubmenu),                         │');
  print('  │    PPI(type: hide),                                   │');
  print('  │    PPI(type: hideOtherApplications),                  │');
  print('  │    PPI(type: showAllApplications),                    │');
  print('  │    PPI(type: quit),                                   │');
  print('  │  ])                                                   │');
  print('  │                                                       │');
  print('  │  Pattern 2: Edit Menu with speech items               │');
  print('  │  PlatformMenu(label: "Edit", menus: [                 │');
  print('  │    PlatformMenuItem(label: "Undo", ...),              │');
  print('  │    PlatformMenuItem(label: "Redo", ...),              │');
  print('  │    PPI(type: startSpeaking),                          │');
  print('  │    PPI(type: stopSpeaking),                           │');
  print('  │  ])                                                   │');
  print('  │                                                       │');
  print('  │  Pattern 3: Window Menu with standard items           │');
  print('  │  PlatformMenu(label: "Window", menus: [               │');
  print('  │    PPI(type: minimizeWindow),                         │');
  print('  │    PPI(type: zoomWindow),                             │');
  print('  │    PPI(type: toggleFullScreen),                       │');
  print('  │    PPI(type: arrangeWindowsInFront),                  │');
  print('  │  ])                                                   │');
  print('  │                                                       │');
  print('  │  (PPI = PlatformProvidedMenuItem for brevity)         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 15: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  final demo = Scaffold(
    backgroundColor: lightGreen50,
    appBar: AppBar(
      title: const Text(
        'PlatformProvidedMenuItem — Visual Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      backgroundColor: green900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── All 12 types ──
          Text(
            'All 12 Platform-Provided Item Types',
            style: TextStyle(
              color: green900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Each represents a macOS-native menu action',
            style: TextStyle(color: green800, fontSize: 12),
          ),
          const SizedBox(height: 10),
          ...[
            {'type': 'about', 'desc': 'Show About dialog', 'icon': Icons.info_outline, 'cat': 'App'},
            {'type': 'quit', 'desc': 'Quit application (Cmd+Q)', 'icon': Icons.exit_to_app, 'cat': 'App'},
            {'type': 'servicesSubmenu', 'desc': 'macOS Services submenu', 'icon': Icons.miscellaneous_services, 'cat': 'App'},
            {'type': 'hide', 'desc': 'Hide current app (Cmd+H)', 'icon': Icons.visibility_off, 'cat': 'App'},
            {'type': 'hideOtherApplications', 'desc': 'Hide all other apps', 'icon': Icons.layers_clear, 'cat': 'App'},
            {'type': 'showAllApplications', 'desc': 'Show all apps again', 'icon': Icons.layers, 'cat': 'App'},
            {'type': 'startSpeaking', 'desc': 'Begin text-to-speech', 'icon': Icons.record_voice_over, 'cat': 'Edit'},
            {'type': 'stopSpeaking', 'desc': 'Stop text-to-speech', 'icon': Icons.voice_over_off, 'cat': 'Edit'},
            {'type': 'toggleFullScreen', 'desc': 'Toggle full-screen mode', 'icon': Icons.fullscreen, 'cat': 'Window'},
            {'type': 'minimizeWindow', 'desc': 'Minimize to dock (Cmd+M)', 'icon': Icons.minimize, 'cat': 'Window'},
            {'type': 'zoomWindow', 'desc': 'Zoom / maximize window', 'icon': Icons.zoom_out_map, 'cat': 'Window'},
            {'type': 'arrangeWindowsInFront', 'desc': 'Bring all to front', 'icon': Icons.flip_to_front, 'cat': 'Window'},
          ].map((item) {
            final cat = item['cat'] as String;
            final catColor = cat == 'App'
                ? green800
                : cat == 'Edit'
                    ? Color(0xFF558B2F)
                    : lightGreen900;
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: green200),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: catColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: catColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['type'] as String,
                          style: TextStyle(
                            color: green900,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          item['desc'] as String,
                          style: TextStyle(
                            color: green800,
                            fontSize: 11,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: catColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: catColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          // ── Simulated App Menu ──
          Text(
            'Simulated myApp Menu (macOS)',
            style: TextStyle(
              color: green900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Color(0xFFD0D0D0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPlatformItem(
                  label: 'About MyApp',
                  type: 'about',
                  iconData: Icons.info_outline,
                  color: green700,
                ),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildPlatformItem(
                  label: 'Preferences...',
                  type: 'custom',
                  shortcut: 'Cmd+,',
                  iconData: Icons.settings,
                  color: green500,
                ),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildPlatformItem(
                  label: 'Services',
                  type: 'servicesSubmenu',
                  iconData: Icons.miscellaneous_services,
                  color: green700,
                  hasSubmenu: true,
                ),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildPlatformItem(
                  label: 'Hide MyApp',
                  type: 'hide',
                  shortcut: 'Cmd+H',
                  iconData: Icons.visibility_off,
                  color: green700,
                ),
                _buildPlatformItem(
                  label: 'Hide Others',
                  type: 'hideOther',
                  shortcut: 'Cmd+Opt+H',
                  iconData: Icons.layers_clear,
                  color: green700,
                ),
                _buildPlatformItem(
                  label: 'Show All',
                  type: 'showAll',
                  iconData: Icons.layers,
                  color: green700,
                ),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildPlatformItem(
                  label: 'Quit MyApp',
                  type: 'quit',
                  shortcut: 'Cmd+Q',
                  iconData: Icons.exit_to_app,
                  color: green700,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Comparison card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [green900, Color(0xFF004D40)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PlatformMenuItem vs PlatformProvidedMenuItem',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                _buildComparisonRow(
                  leftText: 'PlatformMenuItem',
                  rightText: 'PlatformProvidedMenuItem',
                  leftColor: green400,
                  rightColor: green200,
                  isHeader: true,
                ),
                _buildComparisonRow(
                  leftText: 'You define label',
                  rightText: 'OS provides label',
                  leftColor: green400,
                  rightColor: green200,
                ),
                _buildComparisonRow(
                  leftText: 'You define shortcut',
                  rightText: 'OS provides shortcut',
                  leftColor: green400,
                  rightColor: green200,
                ),
                _buildComparisonRow(
                  leftText: 'You provide onSelected',
                  rightText: 'OS handles action',
                  leftColor: green400,
                  rightColor: green200,
                ),
                _buildComparisonRow(
                  leftText: 'Works anywhere',
                  rightText: 'macOS-only (check hasMenu)',
                  leftColor: green400,
                  rightColor: green200,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── hasMenu check card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: green50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: green200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: green800, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'hasMenu() Platform Check',
                      style: TextStyle(
                        color: green900,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Call PlatformProvidedMenuItem.hasMenu(type) before '
                  'including platform items. Returns true only on macOS. '
                  'This ensures your menus degrade gracefully on all platforms.',
                  style: TextStyle(
                    color: green800,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('  Live widget built: PlatformProvidedMenuItem visual demo');
  print('  • 12 type cards with icons, descriptions, and categories');
  print('  • Simulated macOS App Menu dropdown (7 items)');
  print('  • Comparison table (PlatformMenuItem vs Provided)');
  print('  • hasMenu() platform check info card');
  print('');

  // ─── Section 16: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 16: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                      │');
  print('  │                                                      │');
  print('  │  1. Extends PlatformMenuItem for OS-native items     │');
  print('  │  2. Type property selects from 12 predefined actions │');
  print('  │  3. OS provides label, shortcut, icon, and behavior  │');
  print('  │  4. hasMenu() static checks platform support         │');
  print('  │  5. Currently macOS-only (all 12 types available)    │');
  print('  │  6. enabled: false grays out the item on macOS       │');
  print('  │  7. Serialized via toChannelRepresentation()         │');
  print('  │  8. Widget renders SizedBox.shrink() — data only     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Green 900   ${green900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  LtGreen 900 ${lightGreen900.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Green 800   ${green800.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Green 700   ${green700.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Green 500   ${green500.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Green 400   ${green400.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Green 200   ${green200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Green 100   ${green100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Green 50    ${green50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  LtGreen 50  ${lightGreen50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PlatformProvidedMenuItem — Demonstration Complete     ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}

Widget _buildPlatformItem({
  required String label,
  required String type,
  required IconData iconData,
  required Color color,
  String? shortcut,
  bool hasSubmenu = false,
}) {
  final isPlatform = type != 'custom';
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        if (isPlatform)
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          )
        else
          const SizedBox(width: 6),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 13,
              fontWeight: isPlatform ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        if (hasSubmenu)
          Icon(Icons.arrow_right, size: 14, color: Color(0xFF9E9E9E)),
        if (shortcut != null)
          Text(
            shortcut,
            style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 11),
          ),
      ],
    ),
  );
}

Widget _buildComparisonRow({
  required String leftText,
  required String rightText,
  required Color leftColor,
  required Color rightColor,
  bool isHeader = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            leftText,
            style: TextStyle(
              color: leftColor,
              fontSize: isHeader ? 11 : 12,
              fontWeight: isHeader ? FontWeight.w800 : FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            rightText,
            style: TextStyle(
              color: rightColor,
              fontSize: isHeader ? 11 : 12,
              fontWeight: isHeader ? FontWeight.w800 : FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
