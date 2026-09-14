// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PlatformMenuDelegate — Complete Deep Dive
///
/// Palette: Amber / Gold (warm golden spectrum)
/// Primary:   Color(0xFFFFA000) — Amber 700
/// Secondary: Color(0xFFFFB300) — Amber 600
/// Accent:    Color(0xFFFFD54F) — Amber 300
/// Surface:   Color(0xFFFFF8E1) — Amber 50
/// Deep:      Color(0xFFFF6F00) — Amber 900
/// Muted:     Color(0xFFFFE082) — Amber 200
/// Warm:      Color(0xFFFFC107) — Amber 500
/// Highlight: Color(0xFFFFECB3) — Amber 100
/// Light:     Color(0xFFFFFDE7) — Near-white amber
/// Dark:      Color(0xFFFF8F00) — Amber 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PlatformMenuDelegate — Complete Deep Dive           ██');
  print('██   Abstract delegate for platform-native menu bars     ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const amber700 = Color(0xFFFFA000);
  const amber600 = Color(0xFFFFB300);
  const amber300 = Color(0xFFFFD54F);
  const amber50 = Color(0xFFFFF8E1);
  const amber900 = Color(0xFFFF6F00);
  const amber200 = Color(0xFFFFE082);
  const amber500 = Color(0xFFFFC107);
  const amber100 = Color(0xFFFFECB3);
  const nearWhiteAmber = Color(0xFFFFFDE7);
  const amber800 = Color(0xFFFF8F00);

  // ─── Section 2: What Is PlatformMenuDelegate? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PlatformMenuDelegate?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PlatformMenuDelegate is an abstract base class that');
  print('  defines the interface for communicating menu bar');
  print('  structures to the host operating system.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Primary purpose: Bridge between Flutter\'s widget-   │');
  print('  │  layer menu description and the platform\'s native    │');
  print('  │  menu bar rendering.                                  │');
  print('  │                                                       │');
  print('  │  On macOS, this drives the system menu bar at the    │');
  print('  │  top of the screen (File, Edit, View, Window, Help). │');
  print('  │  On other platforms, it could drive equivalent native │');
  print('  │  menu systems.                                        │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Abstract Interface ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Abstract Interface');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  abstract class PlatformMenuDelegate {                │');
  print('  │    const PlatformMenuDelegate();                      │');
  print('  │                                                       │');
  print('  │    // Set the full menu tree on the platform          │');
  print('  │    void setMenus(List<PlatformMenuItem> topLevelMenus)│');
  print('  │                                                       │');
  print('  │    // Remove all menus from the platform              │');
  print('  │    void clearMenus();                                 │');
  print('  │                                                       │');
  print('  │    // Debug: ensure only one PlatformMenuBar active   │');
  print('  │    bool debugLockDelegate(BuildContext context);      │');
  print('  │                                                       │');
  print('  │    // Debug: release the lock                         │');
  print('  │    bool debugUnlockDelegate(BuildContext context);    │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Just 4 methods — a clean, minimal interface.');
  print('');

  // ─── Section 4: DefaultPlatformMenuDelegate ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: DefaultPlatformMenuDelegate');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The framework provides one concrete implementation:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class DefaultPlatformMenuDelegate                    │');
  print('  │      extends PlatformMenuDelegate {                   │');
  print('  │                                                       │');
  print('  │    DefaultPlatformMenuDelegate({                      │');
  print('  │      required this.channel,  // SystemChannels.menu   │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    // Serializes menu items to platform               │');
  print('  │    void setMenus(items) {                             │');
  print('  │      final menuMap = _serializeMenuTree(items);       │');
  print('  │      channel.invokeMethod("Menu.setMenus", menuMap);  │');
  print('  │    }                                                  │');
  print('  │                                                       │');
  print('  │    void clearMenus() {                                │');
  print('  │      channel.invokeMethod("Menu.clearMenus", null);   │');
  print('  │    }                                                  │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  It uses SystemChannels.menu (a MethodChannel) to send');
  print('  serialized menu trees to the platform embedding.');
  print('');

  // ─── Section 5: Platform Channel Architecture ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Platform Channel Architecture');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Flutter App                                          │');
  print('  │  ┌────────────────┐                                  │');
  print('  │  │ PlatformMenuBar│                                  │');
  print('  │  │  (Widget)      │                                  │');
  print('  │  └───────┬────────┘                                  │');
  print('  │          │ calls                                      │');
  print('  │  ┌───────┴────────────────────────┐                  │');
  print('  │  │ PlatformMenuDelegate           │                  │');
  print('  │  │  .setMenus(items)              │                  │');
  print('  │  └───────┬────────────────────────┘                  │');
  print('  │          │ via                                        │');
  print('  │  ┌───────┴────────────────────────┐                  │');
  print('  │  │ DefaultPlatformMenuDelegate     │                 │');
  print('  │  │  channel.invokeMethod(...)      │                 │');
  print('  │  └───────┬────────────────────────┘                  │');
  print('  │          │                                            │');
  print('  │══════════│══════════════════════════════════          │');
  print('  │  Platform│ (MethodChannel)                            │');
  print('  │  ┌───────┴────────────────────────┐                  │');
  print('  │  │ macOS: NSMenu / NSMenuItem      │                 │');
  print('  │  │ Windows: (future HWND menus)    │                 │');
  print('  │  │ Linux: (future GTK menus)       │                 │');
  print('  │  └────────────────────────────────┘                  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: WidgetsBinding Integration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: WidgetsBinding Integration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The delegate is stored on WidgetsBinding:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  WidgetsBinding.instance.platformMenuDelegate        │');
  print('  │                                                       │');
  print('  │  Set automatically during binding initialization:     │');
  print('  │                                                       │');
  print('  │  void initInstances() {                               │');
  print('  │    platformMenuDelegate = DefaultPlatformMenuDelegate(│');
  print('  │      channel: SystemChannels.menu,                    │');
  print('  │    );                                                 │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  You can replace it with a custom delegate for        │');
  print('  │  testing or alternative platform integration.         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: PlatformMenuBar Widget ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: PlatformMenuBar Widget');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PlatformMenuBar is the widget that uses the delegate:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformMenuBar(                                     │');
  print('  │    menus: [                                           │');
  print('  │      PlatformMenu(                                    │');
  print('  │        label: "File",                                 │');
  print('  │        menus: [                                       │');
  print('  │          PlatformMenuItem(                             │');
  print('  │            label: "New",                              │');
  print('  │            onSelected: () { ... },                    │');
  print('  │          ),                                           │');
  print('  │          PlatformMenuItemGroup(                       │');
  print('  │            members: [                                 │');
  print('  │              PlatformMenuItem(label: "Open"),          │');
  print('  │              PlatformMenuItem(label: "Save"),          │');
  print('  │            ],                                         │');
  print('  │          ),                                           │');
  print('  │        ],                                             │');
  print('  │      ),                                               │');
  print('  │    ],                                                 │');
  print('  │    child: MyApp(),                                    │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  // Widget calls delegate.setMenus(menus) on mount   │');
  print('  │  // and whenever menus list changes.                  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Menu Serialization ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Menu Serialization');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The delegate serializes menu items for the platform:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Each PlatformMenuItem has:                           │');
  print('  │  toChannelRepresentation(                             │');
  print('  │    PlatformMenuDelegate delegate,                     │');
  print('  │    MenuItemSerializableIdGenerator getId,             │');
  print('  │  );                                                   │');
  print('  │                                                       │');
  print('  │  Returns a Map like:                                  │');
  print('  │  {                                                    │');
  print('  │    "id": 42,                // unique ID              │');
  print('  │    "label": "New File",     // display text           │');
  print('  │    "enabled": true,         // interactive?           │');
  print('  │    "shortcutTrigger": 78,   // key code for "N"      │');
  print('  │    "shortcutModifiers": 4,  // Cmd modifier           │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  Submenus are nested as "children" arrays.            │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Debug Locking Mechanism ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Debug Locking Mechanism');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Only ONE PlatformMenuBar can be active at a time:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  debugLockDelegate(BuildContext context)               │');
  print('  │    → Called when PlatformMenuBar mounts                │');
  print('  │    → Returns true if lock acquired                    │');
  print('  │    → Returns false if another bar already holds it    │');
  print('  │                                                       │');
  print('  │  debugUnlockDelegate(BuildContext context)             │');
  print('  │    → Called when PlatformMenuBar unmounts              │');
  print('  │    → Releases the lock for another bar                │');
  print('  │                                                       │');
  print('  │  This prevents conflicting menu hierarchies —         │');
  print('  │  only one menu bar should control the platform menus  │');
  print('  │  at any given time.                                   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Platform Support Matrix ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Platform Support Matrix');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────┬────────┬───────────────────────────┐');
  print('  │  Platform         │ Support│ Notes                    │');
  print('  ├──────────────────┼────────┼───────────────────────────┤');
  print('  │  macOS             │ Full  │ NSMenu integration        │');
  print('  │  Windows           │ None  │ Future: HMENU support     │');
  print('  │  Linux             │ None  │ Future: GTK/DBus menus    │');
  print('  │  Android           │ None  │ No native menu bar        │');
  print('  │  iOS               │ None  │ No native menu bar        │');
  print('  │  Web               │ None  │ No native menu bar        │');
  print('  └──────────────────┴────────┴───────────────────────────┘');
  print('');
  print('  On unsupported platforms, the delegate still accepts');
  print('  setMenus calls but they have no visible effect.');
  print('');

  // ─── Section 11: Custom Delegate Pattern ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Custom Delegate Pattern');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  You could implement a custom delegate for testing');
  print('  or alternative menu rendering:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class TestMenuDelegate extends PlatformMenuDelegate {│');
  print('  │    List<PlatformMenuItem> lastMenus = [];             │');
  print('  │    int setMenusCalled = 0;                            │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    void setMenus(List<PlatformMenuItem> menus) {      │');
  print('  │      lastMenus = menus;                               │');
  print('  │      setMenusCalled++;                                │');
  print('  │    }                                                  │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    void clearMenus() { lastMenus = []; }             │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    bool debugLockDelegate(ctx) => true;               │');
  print('  │    @override                                          │');
  print('  │    bool debugUnlockDelegate(ctx) => true;             │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  // Install it:                                       │');
  print('  │  WidgetsBinding.instance.platformMenuDelegate =       │');
  print('  │      TestMenuDelegate();                              │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Menu Item Types ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Menu Item Types');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The delegate receives these item types:');
  print('');
  print('  ┌──────────────────────────┬────────────────────────────┐');
  print('  │  Type                     │  Description              │');
  print('  ├──────────────────────────┼────────────────────────────┤');
  print('  │  PlatformMenu             │  Submenu with children    │');
  print('  │  PlatformMenuItem         │  Clickable item           │');
  print('  │  PlatformMenuItemGroup    │  Separator-delimited group│');
  print('  │  PlatformProvidedMenuItem │  Platform-native item     │');
  print('  │                           │  (About, Quit, etc.)      │');
  print('  └──────────────────────────┴────────────────────────────┘');
  print('');
  print('  All implement PlatformMenuItem (the abstract base) and');
  print('  provide toChannelRepresentation() for serialization.');
  print('');

  // ─── Section 13: Lifecycle Flow ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Lifecycle Flow');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  1. App starts, WidgetsBinding creates               │');
  print('  │     DefaultPlatformMenuDelegate                       │');
  print('  │                                                       │');
  print('  │  2. PlatformMenuBar widget mounts                     │');
  print('  │     → debugLockDelegate() — acquires exclusive lock   │');
  print('  │     → setMenus(menus) — sends menu tree to platform  │');
  print('  │                                                       │');
  print('  │  3. Menu items change (setState)                      │');
  print('  │     → setMenus(updatedMenus) — resends full tree     │');
  print('  │                                                       │');
  print('  │  4. PlatformMenuBar unmounts                          │');
  print('  │     → clearMenus() — removes platform menus          │');
  print('  │     → debugUnlockDelegate() — releases lock          │');
  print('  │                                                       │');
  print('  │  5. User clicks a menu item on the platform           │');
  print('  │     → Platform sends callback via MethodChannel       │');
  print('  │     → Delegate routes to PlatformMenuItem.onSelected  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // Build a visual representation of a platform menu structure
  final demo = Scaffold(
    backgroundColor: nearWhiteAmber,
    appBar: AppBar(
      title: const Text(
        'PlatformMenuDelegate — Visual Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      backgroundColor: Color(0xFF5D4037),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Simulated macOS menu bar ──
          Text(
            'Simulated Platform Menu Bar',
            style: TextStyle(
              color: amber900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Visual representation of what the delegate renders '
            'on macOS via NSMenu',
            style: TextStyle(color: amber800, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),

          // Menu bar simulation
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF5F5F5), Color(0xFFE8E8E8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              border: Border.all(color: Color(0xFFD0D0D0)),
            ),
            child: Row(
              children: [
                Icon(Icons.apple, size: 18, color: Color(0xFF333333)),
                const SizedBox(width: 16),
                ...[
                  'MyApp',
                  'File',
                  'Edit',
                  'View',
                  'Window',
                  'Help',
                ].map((label) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 13,
                        fontWeight: label == 'MyApp'
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Expanded "File" dropdown
          Container(
            width: 200,
            margin: const EdgeInsets.only(left: 54),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Color(0xFFD0D0D0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildMenuItem(
                  label: 'New',
                  shortcut: 'Cmd+N',
                  color: amber700,
                ),
                _buildMenuItem(
                  label: 'Open...',
                  shortcut: 'Cmd+O',
                  color: amber700,
                ),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildMenuItem(
                  label: 'Save',
                  shortcut: 'Cmd+S',
                  color: amber700,
                ),
                _buildMenuItem(
                  label: 'Save As...',
                  shortcut: 'Cmd+Shift+S',
                  color: amber700,
                ),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildMenuItem(
                  label: 'Close',
                  shortcut: 'Cmd+W',
                  color: amber700,
                  enabled: false,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Delegate interface cards ──
          Text(
            'Delegate Interface Methods',
            style: TextStyle(
              color: amber900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          ...[
            {
              'method': 'setMenus(menus)',
              'desc': 'Sends the full menu tree to the platform. '
                  'Called on mount and whenever menus change.',
              'icon': Icons.upload,
            },
            {
              'method': 'clearMenus()',
              'desc': 'Removes all platform menus. Called when '
                  'PlatformMenuBar unmounts.',
              'icon': Icons.clear_all,
            },
            {
              'method': 'debugLockDelegate(ctx)',
              'desc': 'Acquires exclusive lock. Only one '
                  'PlatformMenuBar can be active at a time.',
              'icon': Icons.lock,
            },
            {
              'method': 'debugUnlockDelegate(ctx)',
              'desc': 'Releases the lock so another '
                  'PlatformMenuBar can take over.',
              'icon': Icons.lock_open,
            },
          ].map((item) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: amber200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: amber700.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: amber700,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['method'] as String,
                          style: TextStyle(
                            color: amber900,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['desc'] as String,
                          style: TextStyle(
                            color: amber800,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          // ── Architecture flow card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5D4037), Color(0xFF4E342E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Architecture: Widget → Delegate → Platform',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                ...[
                  {'step': '1', 'text': 'PlatformMenuBar widget defines menu structure'},
                  {'step': '2', 'text': 'Widget calls delegate.setMenus(menuList)'},
                  {'step': '3', 'text': 'DefaultPlatformMenuDelegate serializes items'},
                  {'step': '4', 'text': 'Sends via SystemChannels.menu MethodChannel'},
                  {'step': '5', 'text': 'Platform renders native menu bar (NSMenu)'},
                  {'step': '6', 'text': 'User clicks item → callback via channel → onSelected'},
                ].map((step) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: amber500,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Text(
                              step['step']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            step['text']!,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Platform support matrix ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: amber50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: amber200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform Support',
                  style: TextStyle(
                    color: amber900,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                ...[
                  {'name': 'macOS', 'icon': Icons.laptop_mac, 'status': 'Full support', 'supported': true},
                  {'name': 'Windows', 'icon': Icons.desktop_windows, 'status': 'Not yet', 'supported': false},
                  {'name': 'Linux', 'icon': Icons.computer, 'status': 'Not yet', 'supported': false},
                  {'name': 'Android', 'icon': Icons.phone_android, 'status': 'N/A', 'supported': false},
                  {'name': 'iOS', 'icon': Icons.phone_iphone, 'status': 'N/A', 'supported': false},
                  {'name': 'Web', 'icon': Icons.language, 'status': 'N/A', 'supported': false},
                ].map((platform) {
                  final supported = platform['supported'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          platform['icon'] as IconData,
                          color: supported ? amber700 : Color(0xFFBDBDBD),
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 70,
                          child: Text(
                            platform['name'] as String,
                            style: TextStyle(
                              color: supported ? amber900 : Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Icon(
                          supported ? Icons.check_circle : Icons.cancel,
                          color: supported ? Color(0xFF43A047) : Color(0xFFBDBDBD),
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          platform['status'] as String,
                          style: TextStyle(
                            color: supported ? amber800 : Color(0xFF9E9E9E),
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

  print('  Live widget built: PlatformMenuDelegate visual demo');
  print('  • Simulated macOS menu bar with File dropdown');
  print('  • 4 delegate method cards (setMenus, clearMenus, lock, unlock)');
  print('  • Architecture pipeline (6 steps)');
  print('  • Platform support matrix (6 platforms)');
  print('');

  // ─── Section 15: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                      │');
  print('  │                                                      │');
  print('  │  1. Abstract interface for platform menu communication│');
  print('  │  2. Default impl uses SystemChannels.menu MethodCh   │');
  print('  │  3. Stores on WidgetsBinding.platformMenuDelegate    │');
  print('  │  4. Only one PlatformMenuBar active (debug lock)     │');
  print('  │  5. Currently macOS-only (NSMenu integration)        │');
  print('  │  6. Serializes menu trees for platform channel       │');
  print('  │  7. Replaceable for testing or custom backends       │');
  print('  │  8. Receives callbacks from platform for item clicks │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Amber 900 ${amber900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Amber 800 ${amber800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Amber 700 ${amber700.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Amber 600 ${amber600.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Amber 500 ${amber500.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Amber 300 ${amber300.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Amber 200 ${amber200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Amber 100 ${amber100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Amber 50  ${amber50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Light     ${nearWhiteAmber.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PlatformMenuDelegate — Demonstration Complete         ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}

Widget _buildMenuItem({
  required String label,
  required String shortcut,
  required Color color,
  bool enabled = true,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: enabled ? const Color(0xFF333333) : const Color(0xFFBDBDBD),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          shortcut,
          style: TextStyle(
            color: enabled ? const Color(0xFF9E9E9E) : const Color(0xFFE0E0E0),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
