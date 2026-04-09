// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PlatformSelectableRegionContextMenu — Complete Deep Dive
///
/// Palette: Ocean / Marine (deep sea blues and teals)
/// Primary:   Color(0xFF006064) — Cyan 900
/// Secondary: Color(0xFF00838F) — Cyan 800
/// Accent:    Color(0xFF4DD0E1) — Cyan 300
/// Surface:   Color(0xFFE0F7FA) — Cyan 50
/// Deep:      Color(0xFF004D40) — Teal 900
/// Muted:     Color(0xFF80DEEA) — Cyan 200
/// Warm:      Color(0xFF00ACC1) — Cyan 600
/// Highlight: Color(0xFFB2EBF2) — Cyan 100
/// Light:     Color(0xFFE0F2F1) — Teal 50
/// Dark:      Color(0xFF00695C) — Teal 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PlatformSelectableRegionContextMenu — Deep Dive     ██');
  print('██   Native context menus for selectable text regions     ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const cyan900 = Color(0xFF006064);
  const cyan800 = Color(0xFF00838F);
  const cyan300 = Color(0xFF4DD0E1);
  const cyan50 = Color(0xFFE0F7FA);
  const teal900 = Color(0xFF004D40);
  const cyan200 = Color(0xFF80DEEA);
  const cyan600 = Color(0xFF00ACC1);
  const cyan100 = Color(0xFFB2EBF2);
  const teal50 = Color(0xFFE0F2F1);
  const teal800 = Color(0xFF00695C);

  // ─── Section 2: What Is PlatformSelectableRegionContextMenu? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PlatformSelectableRegionContextMenu?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  This widget provides platform-native context menus');
  print('  (right-click menus) for selectable text regions.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  On the web: it registers a hidden platform view      │');
  print('  │  that intercepts right-click, converts coordinates,  │');
  print('  │  dispatches SelectWordSelectionEvent, and enables     │');
  print('  │  the browser\'s native context menu (Copy, Select All).│');
  print('  │                                                       │');
  print('  │  On non-web platforms: all methods throw              │');
  print('  │  UnimplementedError. The native platform handles      │');
  print('  │  context menus through different mechanisms.          │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Class Definition ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Class Definition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class PlatformSelectableRegionContextMenu            │');
  print('  │      extends StatelessWidget {                        │');
  print('  │                                                       │');
  print('  │    PlatformSelectableRegionContextMenu({              │');
  print('  │      required Widget child,                           │');
  print('  │      super.key,                                       │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    static void attach(                                │');
  print('  │      SelectionContainerDelegate client);              │');
  print('  │                                                       │');
  print('  │    static void detach(                                │');
  print('  │      SelectionContainerDelegate client);              │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Simple widget wrapper with static attach/detach for');
  print('  managing the active selection delegate.');
  print('');

  // ─── Section 4: Web vs Non-Web ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Web vs Non-Web Implementation');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  WEB IMPLEMENTATION                                   │');
  print('  │  ─────────────────                                    │');
  print('  │  File: _platform_selectable_region_context_menu_web   │');
  print('  │                                                       │');
  print('  │  • Registers a singleton HTML platform view           │');
  print('  │  • Intercepts "contextmenu" browser event             │');
  print('  │  • Converts DOM coordinates → Flutter coordinates     │');
  print('  │  • Dispatches SelectWordSelectionEvent to             │');
  print('  │    the attached SelectionContainerDelegate            │');
  print('  │  • Programmatically selects text in DOM so browser    │');
  print('  │    shows native context menu with Copy/Select All     │');
  print('  │  • The widget\'s build() returns an HtmlElementView   │');
  print('  │                                                       │');
  print('  │  IO IMPLEMENTATION (Stub)                             │');
  print('  │  ───────────────────────                              │');
  print('  │  File: _platform_selectable_region_context_menu_io    │');
  print('  │                                                       │');
  print('  │  • attach() → throws UnimplementedError               │');
  print('  │  • detach() → throws UnimplementedError               │');
  print('  │  • build() → throws UnimplementedError                │');
  print('  │  • Should never be instantiated on native platforms   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: Attach / Detach Lifecycle ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Attach / Detach Lifecycle');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  1. SelectableRegion mounts                           │');
  print('  │     → Creates SelectionContainerDelegate              │');
  print('  │     → Calls PlatformSelectableRegionContextMenu       │');
  print('  │       .attach(delegate)                               │');
  print('  │     → Delegate becomes the "active client"            │');
  print('  │                                                       │');
  print('  │  2. User right-clicks on selectable text (web)        │');
  print('  │     → Browser dispatches "contextmenu" event          │');
  print('  │     → Platform view intercepts coordinates            │');
  print('  │     → Dispatches SelectWordSelectionEvent to client   │');
  print('  │     → Client selects word under cursor                │');
  print('  │     → Text is selected in DOM                         │');
  print('  │     → Browser shows native Copy/Select All menu       │');
  print('  │                                                       │');
  print('  │  3. SelectableRegion unmounts                         │');
  print('  │     → Calls .detach(delegate)                         │');
  print('  │     → Active client is cleared                        │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: SelectableRegion Integration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: SelectableRegion Integration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  SelectableRegion is the widget that uses this:       │');
  print('  │                                                       │');
  print('  │  SelectableRegion(                                    │');
  print('  │    focusNode: focusNode,                              │');
  print('  │    selectionControls: materialTextSelectionControls,  │');
  print('  │    child: Column(                                     │');
  print('  │      children: [                                      │');
  print('  │        Text("This text is selectable"),               │');
  print('  │        Text("Right-click for context menu on web"),   │');
  print('  │      ],                                               │');
  print('  │    ),                                                 │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  On web, SelectableRegion wraps itself with           │');
  print('  │  PlatformSelectableRegionContextMenu to enable        │');
  print('  │  native right-click context menus.                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: Selection Architecture ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: Selection Architecture');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Widget Layer:                                        │');
  print('  │  ┌─────────────────────────────────────────────┐      │');
  print('  │  │  SelectableRegion                            │     │');
  print('  │  │  └─ SelectionContainer                       │     │');
  print('  │  │     └─ SelectionContainerDelegate            │     │');
  print('  │  │        (manages selection state for children) │     │');
  print('  │  └─────────────────────────────────────────────┘      │');
  print('  │                                                       │');
  print('  │  Context Menu Layer (web only):                       │');
  print('  │  ┌─────────────────────────────────────────────┐      │');
  print('  │  │  PlatformSelectableRegionContextMenu         │     │');
  print('  │  │  └─ Registers HtmlElementView                │     │');
  print('  │  │     └─ Intercepts browser "contextmenu" event│     │');
  print('  │  │        └─ Routes to SelectionContainerDelegate│    │');
  print('  │  └─────────────────────────────────────────────┘      │');
  print('  │                                                       │');
  print('  │  Context operations: Copy, Select All, Share          │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Use in SelectionArea ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: SelectionArea — The Convenience Widget');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  SelectionArea is the high-level API most developers  │');
  print('  │  use. It wraps SelectableRegion for you:              │');
  print('  │                                                       │');
  print('  │  SelectionArea(                                       │');
  print('  │    child: Column(                                     │');
  print('  │      children: [                                      │');
  print('  │        Text("Selectable text"),                       │');
  print('  │        Icon(Icons.star), // not selectable            │');
  print('  │        Text("More selectable text"),                  │');
  print('  │      ],                                               │');
  print('  │    ),                                                 │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  Under the hood:                                      │');
  print('  │  SelectionArea → SelectableRegion → (web only)        │');
  print('  │    PlatformSelectableRegionContextMenu                │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Browser Context Menu Items ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Browser Context Menu Items');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  When text is selected on web, the browser shows:     │');
  print('  │                                                       │');
  print('  │  ┌─────────────────────────┐                          │');
  print('  │  │  Copy              Ctrl+C│                         │');
  print('  │  │  Select All        Ctrl+A│                         │');
  print('  │  │  ─────────────────────── │                         │');
  print('  │  │  Search Google for "..." │                         │');
  print('  │  │  Print...                │                         │');
  print('  │  │  Inspect Element         │                         │');
  print('  │  └─────────────────────────┘                          │');
  print('  │                                                       │');
  print('  │  The widget makes Flutter text selection work with    │');
  print('  │  the standard browser menu that users expect.         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Testing Support ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Testing Support');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  For testing, the class provides:                     │');
  print('  │                                                       │');
  print('  │  @visibleForTesting                                   │');
  print('  │  static set debugOverrideRegisterViewFactory(         │');
  print('  │    Function(String viewType, Function viewFactory)    │');
  print('  │    value);                                            │');
  print('  │                                                       │');
  print('  │  @visibleForTesting                                   │');
  print('  │  static void debugResetRegistry();                    │');
  print('  │                                                       │');
  print('  │  This lets widget tests mock the platform view        │');
  print('  │  registration that normally only works on real web    │');
  print('  │  browsers.                                            │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: Platform Comparison ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Platform Comparison');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬─────────────────────────────────┐');
  print('  │  Platform             │ Context Menu Behavior           │');
  print('  ├──────────────────────┼─────────────────────────────────┤');
  print('  │  Web                  │ Browser native (via this widget)│');
  print('  │  Android              │ Toolbar above selection          │');
  print('  │  iOS                  │ Magnifying glass + callout bar  │');
  print('  │  macOS                │ Right-click NSMenu              │');
  print('  │  Windows              │ Right-click popup menu          │');
  print('  │  Linux                │ Right-click GTK/Qt menu         │');
  print('  └──────────────────────┴─────────────────────────────────┘');
  print('');
  print('  This widget is ONLY used for the web implementation.');
  print('  Other platforms have their own native context menus.');
  print('');

  // ─── Section 12: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  final demo = Scaffold(
    backgroundColor: teal50,
    appBar: AppBar(
      title: const Text(
        'PlatformSelectableRegionContextMenu — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: teal900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Architecture diagram ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [teal900, cyan900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selection Architecture (Web)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'label': 'SelectionArea / SelectableRegion', 'detail': 'Widget that enables text selection'},
                  {'label': 'SelectionContainerDelegate', 'detail': 'Manages selection state for children'},
                  {'label': 'PlatformSelectableRegionContextMenu', 'detail': 'Web: registers platform view'},
                  {'label': 'HtmlElementView', 'detail': 'Invisible overlay intercepts contextmenu'},
                  {'label': 'Browser Native Context Menu', 'detail': 'Copy / Select All / Search'},
                ].asMap().entries.map((entry) {
                  final i = entry.key;
                  final item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: cyan300.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['label']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                item['detail']!,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.75),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (i < 4)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Icon(Icons.arrow_downward, color: cyan300, size: 14),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Selectable text demo ──
          Text(
            'Selectable Text Regions',
            style: TextStyle(
              color: teal900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'On web, these would have native right-click menus',
            style: TextStyle(color: cyan800, fontSize: 12),
          ),
          const SizedBox(height: 8),
          SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cyan200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.article, color: cyan900, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Article Content',
                            style: TextStyle(
                              color: cyan900,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'PlatformSelectableRegionContextMenu enables '
                        'native browser context menus for Flutter text. '
                        'When a user right-clicks on this selectable text '
                        'in a web browser, the platform-native context menu '
                        'appears with Copy, Select All, and other options.',
                        style: TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cyan200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.code, color: cyan900, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Code Snippet',
                            style: TextStyle(
                              color: cyan900,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFF263238),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'SelectionArea(\n'
                          '  child: Column(\n'
                          '    children: [\n'
                          '      Text("Selectable text here"),\n'
                          '    ],\n'
                          '  ),\n'
                          ')',
                          style: TextStyle(
                            color: Color(0xFF80CBC4),
                            fontSize: 12,
                            fontFamily: 'monospace',
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Simulated context menu ──
          Text(
            'Simulated Browser Context Menu (Web)',
            style: TextStyle(
              color: teal900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selected text block
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cyan200),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 13,
                        height: 1.4,
                      ),
                      children: [
                        const TextSpan(text: 'The '),
                        TextSpan(
                          text: 'selected text',
                          style: TextStyle(
                            backgroundColor: Color(0xFF90CAF9).withValues(alpha: 0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: ' appears highlighted with the native selection color.'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Context menu simulation
              Container(
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildContextMenuItem(
                      label: 'Copy',
                      shortcut: 'Ctrl+C',
                      color: cyan900,
                      enabled: true,
                    ),
                    _buildContextMenuItem(
                      label: 'Select All',
                      shortcut: 'Ctrl+A',
                      color: cyan900,
                      enabled: true,
                    ),
                    Container(height: 1, color: Color(0xFFEEEEEE)),
                    _buildContextMenuItem(
                      label: 'Search Google',
                      shortcut: '',
                      color: cyan800,
                      enabled: true,
                    ),
                    Container(height: 1, color: Color(0xFFEEEEEE)),
                    _buildContextMenuItem(
                      label: 'Inspect',
                      shortcut: '',
                      color: Color(0xFF757575),
                      enabled: true,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Lifecycle card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cyan50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cyan100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attach / Detach Lifecycle',
                  style: TextStyle(
                    color: teal900,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                ...[
                  {'step': 'attach(delegate)', 'desc': 'SelectableRegion mounts → registers delegate', 'icon': Icons.link},
                  {'step': 'Right-click', 'desc': 'Browser contextmenu → word selection → native menu', 'icon': Icons.touch_app},
                  {'step': 'detach(delegate)', 'desc': 'SelectableRegion unmounts → clears delegate', 'icon': Icons.link_off},
                ].map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: cyan900.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: cyan900,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['step'] as String,
                                style: TextStyle(
                                  color: teal900,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Text(
                                item['desc'] as String,
                                style: TextStyle(
                                  color: cyan800,
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
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Platform comparison ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cyan200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Context Menu by Platform',
                  style: TextStyle(
                    color: teal900,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'platform': 'Web', 'mechanism': 'Browser native (this widget)', 'icon': Icons.language, 'uses': true},
                  {'platform': 'Android', 'mechanism': 'Selection toolbar above text', 'icon': Icons.phone_android, 'uses': false},
                  {'platform': 'iOS', 'mechanism': 'Callout bar + magnifier', 'icon': Icons.phone_iphone, 'uses': false},
                  {'platform': 'macOS', 'mechanism': 'NSMenu right-click', 'icon': Icons.laptop_mac, 'uses': false},
                  {'platform': 'Windows', 'mechanism': 'Win32 popup menu', 'icon': Icons.desktop_windows, 'uses': false},
                  {'platform': 'Linux', 'mechanism': 'GTK/Qt context menu', 'icon': Icons.computer, 'uses': false},
                ].map((p) {
                  final uses = p['uses'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          p['icon'] as IconData,
                          color: uses ? cyan900 : Color(0xFF9E9E9E),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 65,
                          child: Text(
                            p['platform'] as String,
                            style: TextStyle(
                              color: uses ? teal900 : Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        if (uses)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: Color(0xFF43A047),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            p['mechanism'] as String,
                            style: TextStyle(
                              color: uses ? cyan800 : Color(0xFF9E9E9E),
                              fontSize: 12,
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
        ],
      ),
    ),
  );

  print('  Live widget built: PlatformSelectableRegionContextMenu demo');
  print('  • Selection architecture diagram (5 layers)');
  print('  • Two selectable text regions (article + code)');
  print('  • Simulated browser context menu');
  print('  • Attach/Detach lifecycle (3 steps)');
  print('  • Platform comparison (6 platforms)');
  print('');

  // ─── Section 13: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                      │');
  print('  │                                                      │');
  print('  │  1. Web-only widget for native browser context menus │');
  print('  │  2. Bridges Flutter selection → browser selection     │');
  print('  │  3. Static attach/detach for delegate management     │');
  print('  │  4. Used internally by SelectableRegion on web       │');
  print('  │  5. Registers HtmlElementView to intercept events    │');
  print('  │  6. Non-web: throws UnimplementedError (stub)        │');
  print('  │  7. Enables Copy/Select All in browser menu          │');
  print('  │  8. SelectionArea is the high-level convenience API  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Teal 900  ${teal900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Teal 800  ${teal800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Cyan 900  ${cyan900.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Cyan 800  ${cyan800.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Cyan 600  ${cyan600.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Cyan 300  ${cyan300.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Cyan 200  ${cyan200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Cyan 100  ${cyan100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Cyan 50   ${cyan50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Teal 50   ${teal50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PlatformSelectableRegionContextMenu — Demo Complete   ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}

Widget _buildContextMenuItem({
  required String label,
  required String shortcut,
  required Color color,
  required bool enabled,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: enabled ? const Color(0xFF333333) : const Color(0xFFBDBDBD),
            fontSize: 13,
          ),
        ),
        if (shortcut.isNotEmpty)
          Text(
            shortcut,
            style: TextStyle(
              color: const Color(0xFF9E9E9E),
              fontSize: 11,
            ),
          ),
      ],
    ),
  );
}
