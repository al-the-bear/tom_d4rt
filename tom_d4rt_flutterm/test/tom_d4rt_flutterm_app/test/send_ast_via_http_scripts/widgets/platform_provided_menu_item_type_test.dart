// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PlatformProvidedMenuItemType — Complete Deep Dive
///
/// Palette: Ruby / Garnet (deep red-burgundy spectrum)
/// Primary:   Color(0xFFC62828) — Red 800
/// Secondary: Color(0xFFD32F2F) — Red 700
/// Accent:    Color(0xFFEF5350) — Red 400
/// Surface:   Color(0xFFFFEBEE) — Red 50
/// Deep:      Color(0xFFB71C1C) — Red 900
/// Muted:     Color(0xFFEF9A9A) — Red 200
/// Warm:      Color(0xFFF44336) — Red 500
/// Highlight: Color(0xFFFFCDD2) — Red 100
/// Light:     Color(0xFFFFF5F5) — Near-white red
/// Dark:      Color(0xFF8E0000) — Deep garnet

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PlatformProvidedMenuItemType — Complete Deep Dive   ██');
  print('██   12 enum values for platform-native menu actions      ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const red800 = Color(0xFFC62828);
  const red700 = Color(0xFFD32F2F);
  const red400 = Color(0xFFEF5350);
  const red50 = Color(0xFFFFEBEE);
  const red900 = Color(0xFFB71C1C);
  const red200 = Color(0xFFEF9A9A);
  const red500 = Color(0xFFF44336);
  const red100 = Color(0xFFFFCDD2);
  const nearWhiteRed = Color(0xFFFFF5F5);
  const deepGarnet = Color(0xFF8E0000);

  // ─── Section 2: What Is PlatformProvidedMenuItemType? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PlatformProvidedMenuItemType?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PlatformProvidedMenuItemType is an enum that identifies');
  print('  which platform-native menu action to include.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  It is the "type" parameter of                        │');
  print('  │  PlatformProvidedMenuItem:                            │');
  print('  │                                                       │');
  print('  │  PlatformProvidedMenuItem(                            │');
  print('  │    type: PlatformProvidedMenuItemType.about,          │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  Each value maps to a specific macOS selector / API   │');
  print('  │  call that the platform embedding knows how to handle.│');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Enum Definition ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Enum Definition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  enum PlatformProvidedMenuItemType {                  │');
  print('  │    about,                                             │');
  print('  │    quit,                                              │');
  print('  │    servicesSubmenu,                                   │');
  print('  │    hide,                                              │');
  print('  │    hideOtherApplications,                             │');
  print('  │    showAllApplications,                               │');
  print('  │    startSpeaking,                                     │');
  print('  │    stopSpeaking,                                      │');
  print('  │    toggleFullScreen,                                  │');
  print('  │    minimizeWindow,                                    │');
  print('  │    zoomWindow,                                        │');
  print('  │    arrangeWindowsInFront,                             │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  12 values total. All currently map to macOS actions. │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: Category Grouping ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Category Grouping');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  APP MENU ITEMS (6 values)                            │');
  print('  │  ┌────────────────────────┬──────────────────────────┐');
  print('  │  │  about                  │ App info / About dialog │');
  print('  │  │  quit                   │ Terminate application   │');
  print('  │  │  servicesSubmenu        │ OS services submenu     │');
  print('  │  │  hide                   │ Hide current app        │');
  print('  │  │  hideOtherApplications  │ Hide all other apps     │');
  print('  │  │  showAllApplications    │ Show all apps           │');
  print('  │  └────────────────────────┴──────────────────────────┘');
  print('  │                                                       │');
  print('  │  EDIT MENU ITEMS (2 values)                           │');
  print('  │  ┌────────────────────────┬──────────────────────────┐');
  print('  │  │  startSpeaking          │ Begin TTS on selection  │');
  print('  │  │  stopSpeaking           │ Stop TTS playback       │');
  print('  │  └────────────────────────┴──────────────────────────┘');
  print('  │                                                       │');
  print('  │  WINDOW MENU ITEMS (4 values)                         │');
  print('  │  ┌────────────────────────┬──────────────────────────┐');
  print('  │  │  toggleFullScreen       │ Enter/exit full screen  │');
  print('  │  │  minimizeWindow         │ Minimize to dock        │');
  print('  │  │  zoomWindow             │ Zoom / maximize         │');
  print('  │  │  arrangeWindowsInFront  │ Bring all to front      │');
  print('  │  └────────────────────────┴──────────────────────────┘');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: macOS Selector Mapping ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: macOS Selector Mapping');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Each enum maps to an Objective-C selector on macOS:');
  print('');
  print('  ┌──────────────────────────────┬────────────────────────┐');
  print('  │  Enum Value                   │ macOS Selector         │');
  print('  ├──────────────────────────────┼────────────────────────┤');
  print('  │  about                        │ orderFrontStandardAbout│');
  print('  │  quit                         │ terminate:             │');
  print('  │  servicesSubmenu              │ (NSApp.servicesMenu)   │');
  print('  │  hide                         │ hide:                  │');
  print('  │  hideOtherApplications        │ hideOtherApplications: │');
  print('  │  showAllApplications          │ unhideAllApplications: │');
  print('  │  startSpeaking                │ startSpeaking:         │');
  print('  │  stopSpeaking                 │ stopSpeaking:          │');
  print('  │  toggleFullScreen             │ toggleFullScreen:      │');
  print('  │  minimizeWindow               │ performMiniaturize:    │');
  print('  │  zoomWindow                   │ performZoom:           │');
  print('  │  arrangeWindowsInFront        │ arrangeInFront:        │');
  print('  └──────────────────────────────┴────────────────────────┘');
  print('');
  print('  The Flutter macOS embedding handles the selector dispatch');
  print('  when the user clicks the corresponding menu item.');
  print('');

  // ─── Section 6: Enum Index Serialization ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: Enum Index Serialization');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  When serialized for the platform channel:            │');
  print('  │                                                       │');
  print('  │  { "platformProvidedMenu": <enum.index> }             │');
  print('  │                                                       │');
  print('  │  Index values:                                        │');
  print('  │  0 = about          6 = startSpeaking                 │');
  print('  │  1 = quit           7 = stopSpeaking                  │');
  print('  │  2 = servicesSubmenu 8 = toggleFullScreen             │');
  print('  │  3 = hide           9 = minimizeWindow                │');
  print('  │  4 = hideOther     10 = zoomWindow                    │');
  print('  │  5 = showAll       11 = arrangeWindowsInFront         │');
  print('  │                                                       │');
  print('  │  IMPORTANT: These indices are a public API contract.  │');
  print('  │  Adding new values at the end is safe, but reordering │');
  print('  │  would break existing platform embeddings.            │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: Standard macOS Keyboard Shortcuts ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: Standard macOS Keyboard Shortcuts');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────┬────────────────────────┐');
  print('  │  Type                         │ Default Shortcut       │');
  print('  ├──────────────────────────────┼────────────────────────┤');
  print('  │  quit                         │ Cmd+Q                  │');
  print('  │  hide                         │ Cmd+H                  │');
  print('  │  hideOtherApplications        │ Cmd+Option+H           │');
  print('  │  minimizeWindow               │ Cmd+M                  │');
  print('  │  toggleFullScreen             │ Ctrl+Cmd+F             │');
  print('  │  about                        │ (none — menu only)     │');
  print('  │  servicesSubmenu              │ (submenu — no shortcut)│');
  print('  │  showAllApplications          │ (none — menu only)     │');
  print('  │  startSpeaking                │ (none — menu only)     │');
  print('  │  stopSpeaking                 │ (none — menu only)     │');
  print('  │  zoomWindow                   │ (none — menu only)     │');
  print('  │  arrangeWindowsInFront        │ (none — menu only)     │');
  print('  └──────────────────────────────┴────────────────────────┘');
  print('');
  print('  The OS provides these shortcuts automatically — Flutter');
  print('  does not need to register them.');
  print('');

  // ─── Section 8: Which Menu Contains Each Type ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Which Menu Contains Each Type');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Apple HIG places them in specific menus:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  App Menu (bold app name):                            │');
  print('  │    about, servicesSubmenu, hide,                      │');
  print('  │    hideOtherApplications, showAllApplications, quit   │');
  print('  │                                                       │');
  print('  │  Edit Menu:                                           │');
  print('  │    startSpeaking, stopSpeaking                        │');
  print('  │    (usually in a "Speech" submenu)                    │');
  print('  │                                                       │');
  print('  │  View Menu:                                           │');
  print('  │    toggleFullScreen                                   │');
  print('  │    (Apple puts it here or in Window)                  │');
  print('  │                                                       │');
  print('  │  Window Menu:                                         │');
  print('  │    minimizeWindow, zoomWindow,                        │');
  print('  │    arrangeWindowsInFront                              │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Platform Availability ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Platform Availability');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Platform     │ All 12 types │ Notes                  │');
  print('  │  ─────────────┼──────────────┼────────────────────────│');
  print('  │  macOS         │ Available    │ Full native support    │');
  print('  │  Windows       │ Unavailable  │ No equivalent yet      │');
  print('  │  Linux         │ Unavailable  │ No equivalent yet      │');
  print('  │  Android       │ Unavailable  │ No menu bar concept    │');
  print('  │  iOS           │ Unavailable  │ No menu bar concept    │');
  print('  │  Web           │ Unavailable  │ No native menu access  │');
  print('  │                                                       │');
  print('  │  PlatformProvidedMenuItem.hasMenu(type) returns false │');
  print('  │  on all non-macOS platforms for all 12 enum values.   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Deep Dive — about ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Deep Dive — about');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformProvidedMenuItemType.about                   │');
  print('  │                                                       │');
  print('  │  macOS selector: orderFrontStandardAboutPanel:        │');
  print('  │                                                       │');
  print('  │  Shows the standard macOS "About" dialog with:        │');
  print('  │  • App icon (from CFBundleIconFile)                   │');
  print('  │  • App name (from CFBundleName)                       │');
  print('  │  • Version (from CFBundleShortVersionString)          │');
  print('  │  • Build number (from CFBundleVersion)                │');
  print('  │  • Copyright (from NSHumanReadableCopyright)          │');
  print('  │                                                       │');
  print('  │  The About panel reads Info.plist automatically —     │');
  print('  │  no Flutter code needed to populate it.               │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: Deep Dive — quit ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Deep Dive — quit');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformProvidedMenuItemType.quit                    │');
  print('  │                                                       │');
  print('  │  macOS selector: terminate:                           │');
  print('  │  Keyboard shortcut: Cmd+Q                             │');
  print('  │                                                       │');
  print('  │  Sends NSApplication.terminate: which triggers:       │');
  print('  │  1. applicationShouldTerminate: delegate callback     │');
  print('  │  2. If allowed: sends willTerminate notification      │');
  print('  │  3. Closes all windows and exits process              │');
  print('  │                                                       │');
  print('  │  Flutter intercepts this to run any cleanup or        │');
  print('  │  "save unsaved changes?" dialogs if needed.           │');
  print('  │  WidgetsBindingObserver.didRequestAppExit is called.  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Deep Dive — servicesSubmenu ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Deep Dive — servicesSubmenu');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformProvidedMenuItemType.servicesSubmenu         │');
  print('  │                                                       │');
  print('  │  This is unique — it creates a SUBMENU, not a single │');
  print('  │  item. macOS dynamically populates it with actions    │');
  print('  │  from other installed apps:                           │');
  print('  │                                                       │');
  print('  │  Services ▸                                           │');
  print('  │    ├── Send via Mail                                  │');
  print('  │    ├── Look Up in Dictionary                          │');
  print('  │    ├── Search with Google                             │');
  print('  │    ├── Create New Sticky Note                         │');
  print('  │    └── ... (depends on installed apps)                │');
  print('  │                                                       │');
  print('  │  The available services depend on the current          │');
  print('  │  selection context and installed apps.                │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 13: Deep Dive — Window Group ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Deep Dive — Window Management Group');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │                                                       │');
  print('  │  minimizeWindow                                       │');
  print('  │    Selector: performMiniaturize:                      │');
  print('  │    Shortcut: Cmd+M                                    │');
  print('  │    Shrinks window to Dock with genie effect           │');
  print('  │                                                       │');
  print('  │  zoomWindow                                           │');
  print('  │    Selector: performZoom:                              │');
  print('  │    Toggles between "standard" and "user" sizes        │');
  print('  │    (macOS zoom ≠ maximize on other platforms)          │');
  print('  │                                                       │');
  print('  │  toggleFullScreen                                     │');
  print('  │    Selector: toggleFullScreen:                         │');
  print('  │    Shortcut: Ctrl+Cmd+F                               │');
  print('  │    Enters/exits true full-screen mode with animation  │');
  print('  │                                                       │');
  print('  │  arrangeWindowsInFront                                │');
  print('  │    Selector: arrangeInFront:                           │');
  print('  │    Brings all app windows to the front of the Z-order │');
  print('  │                                                       │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Deep Dive — Visibility Group ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Deep Dive — Visibility Group');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │                                                       │');
  print('  │  hide                                                 │');
  print('  │    Selector: hide:                                    │');
  print('  │    Shortcut: Cmd+H                                    │');
  print('  │    Hides all windows of the current application       │');
  print('  │    App stays running, just invisible                  │');
  print('  │                                                       │');
  print('  │  hideOtherApplications                                │');
  print('  │    Selector: hideOtherApplications:                    │');
  print('  │    Shortcut: Cmd+Option+H                             │');
  print('  │    Hides every app EXCEPT the current one              │');
  print('  │                                                       │');
  print('  │  showAllApplications                                  │');
  print('  │    Selector: unhideAllApplications:                    │');
  print('  │    Unhides all previously hidden applications         │');
  print('  │                                                       │');
  print('  │  These three form a visibility triad — use them       │');
  print('  │  together in the app menu for standard macOS UX.      │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 15: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  final typeData = <Map<String, dynamic>>[
    {'name': 'about', 'icon': Icons.info_outline, 'shortcut': '—', 'category': 'App', 'desc': 'Show About panel'},
    {'name': 'quit', 'icon': Icons.exit_to_app, 'shortcut': 'Cmd+Q', 'category': 'App', 'desc': 'Terminate app'},
    {'name': 'servicesSubmenu', 'icon': Icons.miscellaneous_services, 'shortcut': '(submenu)', 'category': 'App', 'desc': 'OS Services'},
    {'name': 'hide', 'icon': Icons.visibility_off, 'shortcut': 'Cmd+H', 'category': 'App', 'desc': 'Hide app'},
    {'name': 'hideOtherApplications', 'icon': Icons.layers_clear, 'shortcut': 'Cmd+Opt+H', 'category': 'App', 'desc': 'Hide Others'},
    {'name': 'showAllApplications', 'icon': Icons.layers, 'shortcut': '—', 'category': 'App', 'desc': 'Show All'},
    {'name': 'startSpeaking', 'icon': Icons.record_voice_over, 'shortcut': '—', 'category': 'Edit', 'desc': 'Begin TTS'},
    {'name': 'stopSpeaking', 'icon': Icons.voice_over_off, 'shortcut': '—', 'category': 'Edit', 'desc': 'Stop TTS'},
    {'name': 'toggleFullScreen', 'icon': Icons.fullscreen, 'shortcut': 'Ctrl+Cmd+F', 'category': 'Window', 'desc': 'Full screen'},
    {'name': 'minimizeWindow', 'icon': Icons.minimize, 'shortcut': 'Cmd+M', 'category': 'Window', 'desc': 'Minimize'},
    {'name': 'zoomWindow', 'icon': Icons.zoom_out_map, 'shortcut': '—', 'category': 'Window', 'desc': 'Zoom / maximize'},
    {'name': 'arrangeWindowsInFront', 'icon': Icons.flip_to_front, 'shortcut': '—', 'category': 'Window', 'desc': 'Bring all front'},
  ];

  Color categoryColor(String cat) {
    switch (cat) {
      case 'App':
        return red800;
      case 'Edit':
        return Color(0xFF880E4F);
      case 'Window':
        return deepGarnet;
      default:
        return red700;
    }
  }

  final demo = Scaffold(
    backgroundColor: nearWhiteRed,
    appBar: AppBar(
      title: const Text(
        'PlatformProvidedMenuItemType — Visual Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      backgroundColor: red900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [red900, deepGarnet],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'enum PlatformProvidedMenuItemType',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '12 values that map to native macOS menu actions. '
                  'Each tells the platform which standard item to render.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Category filter chips ──
          Row(
            children: [
              _buildCategoryChip('App', red800, 6),
              const SizedBox(width: 8),
              _buildCategoryChip('Edit', Color(0xFF880E4F), 2),
              const SizedBox(width: 8),
              _buildCategoryChip('Window', deepGarnet, 4),
            ],
          ),

          const SizedBox(height: 12),

          // ── All 12 type cards ──
          ...typeData.map((item) {
            final cat = item['category'] as String;
            final cc = categoryColor(cat);
            final idx = typeData.indexOf(item);
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: cc.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: cc.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        '$idx',
                        style: TextStyle(
                          color: cc,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(item['icon'] as IconData, color: cc, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] as String,
                          style: TextStyle(
                            color: red900,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          item['desc'] as String,
                          style: TextStyle(
                            color: red700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: cc.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item['shortcut'] as String,
                      style: TextStyle(
                        color: cc,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          // ── Serialization card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: red50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: red200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.data_object, color: red800, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Channel Serialization',
                      style: TextStyle(
                        color: red900,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Each type is sent to the platform as its enum index '
                  '(0-11). The macOS embedding maps the index back to '
                  'the corresponding Objective-C selector. Adding new '
                  'values at the end is safe; reordering would break the API.',
                  style: TextStyle(
                    color: red800,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Platform availability card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: red50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: red200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.devices, color: red800, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Platform Availability',
                      style: TextStyle(
                        color: red900,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...[
                  {'platform': 'macOS', 'supported': true},
                  {'platform': 'Windows', 'supported': false},
                  {'platform': 'Linux', 'supported': false},
                  {'platform': 'Android', 'supported': false},
                  {'platform': 'iOS', 'supported': false},
                  {'platform': 'Web', 'supported': false},
                ].map((p) {
                  final ok = p['supported'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Row(
                      children: [
                        Icon(
                          ok ? Icons.check_circle : Icons.cancel,
                          color: ok ? Color(0xFF43A047) : Color(0xFFBDBDBD),
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${p["platform"]}${ok ? " — all 12 types" : " — none"}',
                          style: TextStyle(
                            color: ok ? red900 : Color(0xFF9E9E9E),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('  Live widget built: PlatformProvidedMenuItemType visual demo');
  print('  • Title card with enum description');
  print('  • 3 category chips (App:6, Edit:2, Window:4)');
  print('  • 12 type cards with index, icon, name, desc, shortcut');
  print('  • Serialization info card');
  print('  • Platform availability matrix');
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
  print('  │  1. Enum with 12 values for platform-native actions  │');
  print('  │  2. Three categories: App (6), Edit (2), Window (4)  │');
  print('  │  3. Each maps to a macOS Objective-C selector        │');
  print('  │  4. Serialized as enum index (0-11) over channel     │');
  print('  │  5. Currently macOS-only — all 12 available there    │');
  print('  │  6. OS provides label, shortcut, icon, and behavior  │');
  print('  │  7. servicesSubmenu is special: creates a submenu    │');
  print('  │  8. Use with PlatformProvidedMenuItem widget         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Red 900     ${red900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Deep Garnet ${deepGarnet.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Red 800     ${red800.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Red 700     ${red700.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Red 500     ${red500.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Red 400     ${red400.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Red 200     ${red200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Red 100     ${red100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Red 50      ${red50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Light       ${nearWhiteRed.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PlatformProvidedMenuItemType — Demo Complete          ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}

Widget _buildCategoryChip(String label, Color color, int count) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
