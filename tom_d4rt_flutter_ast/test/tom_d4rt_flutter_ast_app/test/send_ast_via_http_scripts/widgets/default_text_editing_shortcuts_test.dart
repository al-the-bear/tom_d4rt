// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// DefaultTextEditingShortcuts — Deep Demo
// =============================================================================
//
// This file is a long-form, hand-authored demo of the
// `DefaultTextEditingShortcuts` widget. The widget is one of those quietly
// load-bearing pieces of the Flutter framework: you almost never instantiate
// it directly, yet every single TextField in the wild ends up underneath
// one. It is what makes Cmd+C, Cmd+V, Cmd+A, Home/End, arrow-jumps,
// undo/redo, and a long catalog of platform-specific bindings actually do
// what users expect, in a way that respects the host operating system's
// conventions.
//
// The widget itself is a thin `Shortcuts` subclass. It picks an appropriate
// `Map<ShortcutActivator, Intent>` based on the inferred (or themed)
// `TargetPlatform` and exposes those intents to descendants. Real handling
// happens further down — `EditableText` provides matching `Actions`, and
// the `TextEditingActionTarget` mixin walks the controller.
//
// Because this is a "harness-safe" demo (we want it to render in any
// flavor of test harness, including ones with virtual keyboards or
// stripped HID layers), we do not actually pump key events here. We
// instead build live UI demonstrating where the shortcuts attach, what
// each platform binds, how to override, how to disable, and how to layer
// custom shortcuts on top.
//
// Sections (12 in total):
//   1.  Intro — what the widget does and where it sits
//   2.  Live TextField under DefaultTextEditingShortcuts
//   3.  Platform shortcut catalog (5-column Table)
//   4.  Per-platform sandbox cells
//   5.  Custom shortcut layered above defaults
//   6.  Disabling defaults via empty ShortcutManager
//   7.  EditableText with custom controller
//   8.  RTL / IME interplay
//   9.  Per-platform cheatsheet card
//   10. Pitfalls
//   11. Recipe gallery
//   12. Reference table
//
// Total target: ≥1500 lines of hand-authored content.
//
// Each section is built by its own helper so that the top-level `build`
// stays scannable. Section helpers all return `Widget` and take no shared
// mutable state — the demo is intentionally simple wiring.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== DefaultTextEditingShortcuts Deep Demo (Hand-Authored) ===');
  print('Building 12 sections covering the platform shortcut layer.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DefaultTextEditingShortcuts Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DefaultTextEditingShortcuts — Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSectionHeader(
                context,
                number: 1,
                title: 'What is DefaultTextEditingShortcuts?',
                subtitle:
                    'A ShortcutManager pre-populated with the OS-appropriate '
                    'text-editing keybindings.',
              ),
              _buildIntroSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 2,
                title: 'Live TextField wrapped in DefaultTextEditingShortcuts',
                subtitle:
                    'Try Cmd/Ctrl+C, Cmd/Ctrl+X, Cmd/Ctrl+V, Cmd/Ctrl+A '
                    'while focused — the framework dispatches the intent.',
              ),
              _buildLiveTextFieldSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 3,
                title: 'Platform shortcut catalog',
                subtitle:
                    'Five columns: Android / iOS / macOS / Windows / Linux. '
                    'The current platform column is highlighted.',
              ),
              _buildPlatformCatalogSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 4,
                title: 'Per-platform sandbox',
                subtitle:
                    'Five Theme(data: ThemeData(platform: …)) overrides, '
                    'each with its own DefaultTextEditingShortcuts wrapper.',
              ),
              _buildPerPlatformSandboxSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 5,
                title: 'Custom shortcut layered above defaults',
                subtitle:
                    'A Shortcuts widget adds Cmd/Ctrl+K → CommandPaletteIntent. '
                    'Defaults still flow through.',
              ),
              _buildCustomShortcutSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 6,
                title: 'Disabling default shortcuts',
                subtitle:
                    'Wrapping the child with a Shortcuts(manager:) using an '
                    'empty map suppresses the defaults.',
              ),
              _buildDisableDefaultsSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 7,
                title: 'EditableText with a custom controller',
                subtitle:
                    'Talking directly to EditableText — cut/copy/paste flows '
                    'still feed the controller through Actions.',
              ),
              _buildEditableTextSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 8,
                title: 'RTL / IME interplay',
                subtitle:
                    'Wrapped in Directionality.rtl: arrow keys remap so that '
                    'Right moves backward visually.',
              ),
              _buildRtlSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 9,
                title: 'Per-platform cheatsheet card',
                subtitle:
                    'Modifiers: Cmd vs Ctrl, Option/Alt, Shift. The active '
                    'platform line is highlighted.',
              ),
              _buildCheatsheetSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 10,
                title: 'Pitfalls',
                subtitle:
                    'Common mistakes when working with the default text '
                    'shortcut layer.',
              ),
              _buildPitfallsSection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 11,
                title: 'Recipe gallery',
                subtitle:
                    'Practical patterns: command palettes, vim-style word '
                    'jumps, autosave, and emacs kill rings.',
              ),
              _buildRecipeGallerySection(context),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                number: 12,
                title: 'Reference table',
                subtitle:
                    'Quick lookup of related types in the Flutter framework.',
              ),
              _buildReferenceTableSection(context),
              const SizedBox(height: 32),
              _buildFooter(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Common helpers
// -----------------------------------------------------------------------------

Widget _buildSectionHeader(
  BuildContext context, {
  required int number,
  required String title,
  required String subtitle,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.indigo.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Section $number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Divider(color: Colors.indigo.shade100, thickness: 1),
      ],
    ),
  );
}

Widget _paragraph(String text, {bool emphasis = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        height: 1.45,
        fontWeight: emphasis ? FontWeight.w600 : FontWeight.normal,
        color: emphasis ? Colors.indigo.shade900 : Colors.black87,
      ),
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, top: 2, bottom: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 8),
          child: Icon(Icons.circle, size: 6, color: Colors.indigo),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.indigo.shade300),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        color: Colors.greenAccent,
        height: 1.4,
      ),
    ),
  );
}

Widget _kbd(String label) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: Colors.black87,
      ),
    ),
  );
}

Widget _kbdRow(List<String> keys) {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: <Widget>[
      for (int i = 0; i < keys.length; i++) ...<Widget>[
        if (i > 0)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text('+', style: TextStyle(fontSize: 12)),
          ),
        _kbd(keys[i]),
      ],
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 1 — Intro
// -----------------------------------------------------------------------------

Widget _buildIntroSection(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'DefaultTextEditingShortcuts is a Shortcuts subclass that ships '
            'with Flutter. Its job is to inject a sensible, OS-aware set of '
            'shortcut bindings into the widget tree so that descendants like '
            'EditableText and TextField behave like native text controls on '
            'every platform Flutter targets.',
          ),
          _paragraph(
            'You almost never construct it yourself. Instead, WidgetsApp '
            '(and therefore MaterialApp and CupertinoApp) wraps the entire '
            'application in one for you. The widget then chooses a binding '
            'table per platform — fewer Cmd-key bindings on Linux, more '
            'word-jump bindings on macOS, Home/End where applicable, etc.',
          ),
          _paragraph(
            'The reason you should still understand it:',
            emphasis: true,
          ),
          _bullet(
            'You may want to layer custom shortcuts that interact with text '
            'editing — for example a Cmd+K command palette.',
          ),
          _bullet(
            'You may want to disable some defaults — e.g. inside a code '
            'editor with vim emulation, or a chat composer that uses Enter '
            'as send.',
          ),
          _bullet(
            'You may want to test platform-specific behavior. The widget '
            'observes Theme(data: ThemeData(platform: …)) so you can stage '
            'sandboxes for any TargetPlatform.',
          ),
          _bullet(
            'You may need to debug why a binding "stopped working" when '
            'someone wrapped a subtree with their own Shortcuts widget.',
          ),
          const SizedBox(height: 8),
          _paragraph(
            'Where it sits in the tree:',
            emphasis: true,
          ),
          _codeBlock(
            'WidgetsApp\n'
            '  └── DefaultTextEditingShortcuts            ← injects bindings\n'
            '        └── DefaultTextEditingActions        ← provides Actions\n'
            '              └── (your app)\n'
            '                    └── TextField / EditableText\n'
            '                          └── TextEditingActionTarget mixin\n'
            '                                └── TextEditingController',
          ),
          _paragraph(
            'When a key event arrives at a focused EditableText, Flutter '
            'walks the focus chain looking for a Shortcuts widget whose map '
            'contains a matching activator. DefaultTextEditingShortcuts is '
            'one such widget: by virtue of being near the root, it always '
            'gets the last word unless a more specific Shortcuts further '
            'down the tree intercepts the event.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 2 — Live TextField under DefaultTextEditingShortcuts
// -----------------------------------------------------------------------------

Widget _buildLiveTextFieldSection(BuildContext context) {
  // Note: MaterialApp already wraps the tree in DefaultTextEditingShortcuts.
  // We add an explicit one here to demonstrate where it sits and how it is
  // composed. Re-wrapping is harmless — Shortcuts widgets compose, with
  // inner ones taking precedence.
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'Below is an explicit DefaultTextEditingShortcuts wrapping a '
            'TextField. Try clicking into the field and pressing Cmd/Ctrl+A '
            'to select all, Cmd/Ctrl+C to copy, Cmd/Ctrl+V to paste, '
            'Cmd/Ctrl+X to cut. On a desktop platform you can also try '
            'arrow keys with Shift to extend selection, and Home/End to '
            'jump to line start/end.',
          ),
          _codeBlock(
            'DefaultTextEditingShortcuts(\n'
            '  child: TextField(\n'
            '    controller: _controller,\n'
            '    decoration: InputDecoration(\n'
            '      labelText: "Try keyboard shortcuts",\n'
            '    ),\n'
            '  ),\n'
            ')',
          ),
          const SizedBox(height: 12),
          DefaultTextEditingShortcuts(
            child: TextField(
              controller: TextEditingController(
                text: 'Select me, copy me, paste me, cut me, undo me.',
              ),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Live demo (Section 2)',
                helperText:
                    'Cmd/Ctrl + A / C / V / X / Z, arrows, Home/End, etc.',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _paragraph(
            'Status hint: this demo does not pump synthetic key events. It '
            'is meant to be exercised by a human pressing real keys. The '
            'point is to show where the wrapper attaches and to confirm '
            'that nothing else is intercepting your shortcuts.',
          ),
          _bullet(
            'If the shortcuts do nothing, suspect a Shortcuts widget '
            'further down or a global focus issue (no FocusNode has '
            'primary focus).',
          ),
          _bullet(
            'If a "platform-specific" shortcut behaves wrongly, suspect a '
            'Theme override or that the platform is being inferred from '
            'defaultTargetPlatform during tests.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 3 — Platform shortcut catalog
// -----------------------------------------------------------------------------

Widget _buildPlatformCatalogSection(BuildContext context) {
  // The catalog is intentionally hand-curated to highlight the *interesting*
  // platform divergences. There are dozens more bindings than fit here; the
  // goal is to teach the shape of the table, not enumerate every entry.
  final TargetPlatform current = Theme.of(context).platform;
  final List<_PlatformColumn> columns = <_PlatformColumn>[
    const _PlatformColumn(
      platform: TargetPlatform.android,
      header: 'Android',
      icon: Icons.android,
    ),
    const _PlatformColumn(
      platform: TargetPlatform.iOS,
      header: 'iOS',
      icon: Icons.phone_iphone,
    ),
    const _PlatformColumn(
      platform: TargetPlatform.macOS,
      header: 'macOS',
      icon: Icons.laptop_mac,
    ),
    const _PlatformColumn(
      platform: TargetPlatform.windows,
      header: 'Windows',
      icon: Icons.laptop_windows,
    ),
    const _PlatformColumn(
      platform: TargetPlatform.linux,
      header: 'Linux',
      icon: Icons.laptop_chromebook,
    ),
  ];

  final List<_CatalogRow> rows = <_CatalogRow>[
    const _CatalogRow(
      intent: 'Copy',
      android: 'Ctrl+C',
      iOS: 'Cmd+C',
      macOS: 'Cmd+C',
      windows: 'Ctrl+C',
      linux: 'Ctrl+C',
    ),
    const _CatalogRow(
      intent: 'Cut',
      android: 'Ctrl+X',
      iOS: 'Cmd+X',
      macOS: 'Cmd+X',
      windows: 'Ctrl+X',
      linux: 'Ctrl+X',
    ),
    const _CatalogRow(
      intent: 'Paste',
      android: 'Ctrl+V',
      iOS: 'Cmd+V',
      macOS: 'Cmd+V',
      windows: 'Ctrl+V',
      linux: 'Ctrl+V',
    ),
    const _CatalogRow(
      intent: 'Select all',
      android: 'Ctrl+A',
      iOS: 'Cmd+A',
      macOS: 'Cmd+A',
      windows: 'Ctrl+A',
      linux: 'Ctrl+A',
    ),
    const _CatalogRow(
      intent: 'Undo',
      android: 'Ctrl+Z',
      iOS: 'Cmd+Z',
      macOS: 'Cmd+Z',
      windows: 'Ctrl+Z',
      linux: 'Ctrl+Z',
    ),
    const _CatalogRow(
      intent: 'Redo',
      android: 'Ctrl+Shift+Z',
      iOS: 'Cmd+Shift+Z',
      macOS: 'Cmd+Shift+Z',
      windows: 'Ctrl+Y',
      linux: 'Ctrl+Shift+Z',
    ),
    const _CatalogRow(
      intent: 'Move to line start',
      android: 'Home',
      iOS: 'Cmd+Left',
      macOS: 'Cmd+Left',
      windows: 'Home',
      linux: 'Home',
    ),
    const _CatalogRow(
      intent: 'Move to line end',
      android: 'End',
      iOS: 'Cmd+Right',
      macOS: 'Cmd+Right',
      windows: 'End',
      linux: 'End',
    ),
    const _CatalogRow(
      intent: 'Move to document start',
      android: 'Ctrl+Home',
      iOS: 'Cmd+Up',
      macOS: 'Cmd+Up',
      windows: 'Ctrl+Home',
      linux: 'Ctrl+Home',
    ),
    const _CatalogRow(
      intent: 'Move to document end',
      android: 'Ctrl+End',
      iOS: 'Cmd+Down',
      macOS: 'Cmd+Down',
      windows: 'Ctrl+End',
      linux: 'Ctrl+End',
    ),
    const _CatalogRow(
      intent: 'Move word left',
      android: 'Ctrl+Left',
      iOS: 'Alt+Left',
      macOS: 'Alt+Left',
      windows: 'Ctrl+Left',
      linux: 'Ctrl+Left',
    ),
    const _CatalogRow(
      intent: 'Move word right',
      android: 'Ctrl+Right',
      iOS: 'Alt+Right',
      macOS: 'Alt+Right',
      windows: 'Ctrl+Right',
      linux: 'Ctrl+Right',
    ),
    const _CatalogRow(
      intent: 'Delete word left',
      android: 'Ctrl+Backspace',
      iOS: 'Alt+Backspace',
      macOS: 'Alt+Backspace',
      windows: 'Ctrl+Backspace',
      linux: 'Ctrl+Backspace',
    ),
    const _CatalogRow(
      intent: 'Delete word right',
      android: 'Ctrl+Delete',
      iOS: 'Alt+Delete',
      macOS: 'Alt+Delete',
      windows: 'Ctrl+Delete',
      linux: 'Ctrl+Delete',
    ),
    const _CatalogRow(
      intent: 'Extend selection (line)',
      android: 'Shift+End',
      iOS: 'Shift+Cmd+Right',
      macOS: 'Shift+Cmd+Right',
      windows: 'Shift+End',
      linux: 'Shift+End',
    ),
    const _CatalogRow(
      intent: 'Extend selection (doc)',
      android: 'Ctrl+Shift+End',
      iOS: 'Shift+Cmd+Down',
      macOS: 'Shift+Cmd+Down',
      windows: 'Ctrl+Shift+End',
      linux: 'Ctrl+Shift+End',
    ),
  ];

  Widget header(_PlatformColumn col) {
    final bool isCurrent = col.platform == current;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      color: isCurrent ? Colors.indigo.shade100 : Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Icon(col.icon, size: 18, color: Colors.indigo.shade700),
          const SizedBox(height: 2),
          Text(
            col.header,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
              color: isCurrent ? Colors.indigo.shade900 : Colors.black87,
            ),
          ),
          if (isCurrent)
            const Text(
              '(current)',
              style: TextStyle(fontSize: 10, color: Colors.indigo),
            ),
        ],
      ),
    );
  }

  Widget cell(String text, {bool currentColumn = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      color: currentColumn ? Colors.indigo.shade50 : null,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
        ),
      ),
    );
  }

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'The catalog below shows how DefaultTextEditingShortcuts maps '
            'common editing intents to keys, per platform. The current '
            'platform column is shaded so you can spot what is "live".',
          ),
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2.0),
                1: FlexColumnWidth(1.0),
                2: FlexColumnWidth(1.0),
                3: FlexColumnWidth(1.1),
                4: FlexColumnWidth(1.1),
                5: FlexColumnWidth(1.0),
              },
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade300, width: 0.5),
              ),
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Intent',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    for (final _PlatformColumn col in columns) header(col),
                  ],
                ),
                for (final _CatalogRow row in rows)
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          row.intent,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      cell(
                        row.android,
                        currentColumn: current == TargetPlatform.android,
                      ),
                      cell(
                        row.iOS,
                        currentColumn: current == TargetPlatform.iOS,
                      ),
                      cell(
                        row.macOS,
                        currentColumn: current == TargetPlatform.macOS,
                      ),
                      cell(
                        row.windows,
                        currentColumn: current == TargetPlatform.windows,
                      ),
                      cell(
                        row.linux,
                        currentColumn: current == TargetPlatform.linux,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _paragraph(
            'A few divergences are worth noting:',
            emphasis: true,
          ),
          _bullet(
            'On macOS/iOS, line navigation uses Cmd+Left/Right instead of '
            'Home/End. This matches Apple HIG and breaks the "Home means '
            'top" muscle memory of Windows users.',
          ),
          _bullet(
            'On macOS/iOS, word navigation uses Alt+Left/Right (Option key), '
            'whereas everywhere else it is Ctrl+Left/Right.',
          ),
          _bullet(
            'Redo on Windows is Ctrl+Y, while every other platform uses '
            'Ctrl/Cmd+Shift+Z.',
          ),
          _bullet(
            'The selection-extending variants are derived by adding Shift '
            'to the navigation activators — Flutter codifies the cross '
            'product, so you do not need to remember every combination.',
          ),
        ],
      ),
    ),
  );
}

class _PlatformColumn {
  final TargetPlatform platform;
  final String header;
  final IconData icon;

  const _PlatformColumn({
    required this.platform,
    required this.header,
    required this.icon,
  });
}

class _CatalogRow {
  final String intent;
  final String android;
  final String iOS;
  final String macOS;
  final String windows;
  final String linux;

  const _CatalogRow({
    required this.intent,
    required this.android,
    required this.iOS,
    required this.macOS,
    required this.windows,
    required this.linux,
  });
}

// -----------------------------------------------------------------------------
// Section 4 — Per-platform sandbox
// -----------------------------------------------------------------------------

Widget _buildPerPlatformSandboxSection(BuildContext context) {
  // Each cell forces a TargetPlatform via Theme. Inside, the
  // DefaultTextEditingShortcuts inherits that platform and selects its
  // binding map accordingly. The user can focus each field and observe
  // behavior — though "behavior" in this hand-authored demo is mostly
  // about telling them *what to expect*; the actual binding tables are
  // what change.
  final List<_SandboxCell> cells = <_SandboxCell>[
    _SandboxCell(
      platform: TargetPlatform.android,
      title: 'Android',
      bullets: <String>[
        'Home / End → line start/end (no Cmd needed).',
        'Ctrl+Left/Right → previous/next word.',
        'Ctrl+Z undo, Ctrl+Shift+Z redo.',
        'Soft keyboard suppresses many of these in practice.',
      ],
      icon: Icons.android,
      color: Colors.green,
    ),
    _SandboxCell(
      platform: TargetPlatform.iOS,
      title: 'iOS',
      bullets: <String>[
        'Cmd+Left/Right → line start/end.',
        'Alt+Left/Right (Option) → previous/next word.',
        'Cmd+Up/Down → document start/end.',
        'External Bluetooth keyboards primarily; on-screen keyboard '
            'rarely surfaces these.',
      ],
      icon: Icons.phone_iphone,
      color: Colors.blueGrey,
    ),
    _SandboxCell(
      platform: TargetPlatform.macOS,
      title: 'macOS',
      bullets: <String>[
        'Cmd+Left/Right → line start/end.',
        'Alt+Left/Right (Option) → previous/next word.',
        'Cmd+Up/Down → document start/end.',
        'Ctrl+A / Ctrl+E (emacs-ish) sometimes also recognized.',
      ],
      icon: Icons.laptop_mac,
      color: Colors.indigo,
    ),
    _SandboxCell(
      platform: TargetPlatform.windows,
      title: 'Windows',
      bullets: <String>[
        'Home / End → line start/end.',
        'Ctrl+Left/Right → previous/next word.',
        'Ctrl+Y for redo (legacy convention).',
        'Ctrl+Backspace deletes preceding word.',
      ],
      icon: Icons.laptop_windows,
      color: Colors.lightBlue,
    ),
    _SandboxCell(
      platform: TargetPlatform.linux,
      title: 'Linux',
      bullets: <String>[
        'Home / End → line start/end.',
        'Ctrl+Left/Right → previous/next word.',
        'Ctrl+Shift+Z for redo (GTK convention).',
        'Toolkit-dependent quirks; assume parity with Windows.',
      ],
      icon: Icons.laptop_chromebook,
      color: Colors.orange,
    ),
  ];

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'The sandbox below renders five live TextFields, each forced to '
            'a particular TargetPlatform via Theme. The same key combo will '
            'be resolved differently in each cell. For example, pressing '
            'Cmd+Left in the macOS cell will jump to line start, while '
            'pressing Cmd+Left in the Windows cell does nothing (because '
            'Windows binds Home/End for line jumps and ignores Cmd).',
          ),
          const SizedBox(height: 12),
          for (final _SandboxCell cell in cells) ...<Widget>[
            _buildSandboxCell(context, cell),
            const SizedBox(height: 12),
          ],
          _paragraph(
            'Why does this work? Because DefaultTextEditingShortcuts reads '
            'Theme.of(context).platform when building its binding map. By '
            'overriding ThemeData(platform: …) in a subtree, you change '
            'what that lookup returns, and the widget rebuilds with a '
            'different keymap — without you ever touching '
            'defaultTargetPlatform globally.',
          ),
        ],
      ),
    ),
  );
}

class _SandboxCell {
  final TargetPlatform platform;
  final String title;
  final List<String> bullets;
  final IconData icon;
  final MaterialColor color;

  _SandboxCell({
    required this.platform,
    required this.title,
    required this.bullets,
    required this.icon,
    required this.color,
  });
}

Widget _buildSandboxCell(BuildContext context, _SandboxCell cell) {
  return Theme(
    data: ThemeData(platform: cell.platform, useMaterial3: true),
    child: Builder(
      builder: (BuildContext innerContext) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: cell.color.withOpacity(0.4), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(cell.icon, color: cell.color, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    cell.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cell.color.shade800,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(TargetPlatform.${cell.platform.name})',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (final String bullet in cell.bullets) _bullet(bullet),
              const SizedBox(height: 8),
              DefaultTextEditingShortcuts(
                child: TextField(
                  controller: TextEditingController(
                    text:
                        'A quick brown fox jumps over the lazy dog. '
                        'Try line / word jumps and selection extension here.',
                  ),
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: '${cell.title} sandbox',
                    helperText:
                        'Theme(platform: ${cell.platform.name}) is in effect',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 5 — Custom shortcut layered above defaults
// -----------------------------------------------------------------------------

Widget _buildCustomShortcutSection(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'Layering a custom shortcut above DefaultTextEditingShortcuts is '
            'the recommended way to add app-level keybindings without '
            'breaking text editing. The layering is straightforward: '
            'wrap your subtree in a Shortcuts widget that contains only '
            'your custom map, then place DefaultTextEditingShortcuts (or '
            'a TextField that already has one inherited) as a child.',
          ),
          _codeBlock(
            'Shortcuts(\n'
            '  shortcuts: <ShortcutActivator, Intent>{\n'
            '    SingleActivator(LogicalKeyboardKey.keyK,\n'
            '        meta: true): const _CommandPaletteIntent(),\n'
            '    SingleActivator(LogicalKeyboardKey.keyK,\n'
            '        control: true): const _CommandPaletteIntent(),\n'
            '  },\n'
            '  child: Actions(\n'
            '    actions: <Type, Action<Intent>>{\n'
            '      _CommandPaletteIntent: _OpenCommandPaletteAction(),\n'
            '    },\n'
            '    child: DefaultTextEditingShortcuts(\n'
            '      child: TextField(...),\n'
            '    ),\n'
            '  ),\n'
            ')',
          ),
          _paragraph(
            'Resolution order:',
            emphasis: true,
          ),
          _bullet(
            '1. The focused widget receives a key event.',
          ),
          _bullet(
            '2. Flutter walks ancestors looking for a Shortcuts widget '
            'whose map includes a matching activator.',
          ),
          _bullet(
            '3. The closest match wins. So your outer custom Shortcuts '
            'gets first dibs, which is correct: you want Cmd+K to open '
            'the palette regardless of whether a TextField is focused.',
          ),
          _bullet(
            '4. Any unmatched events fall through to inner Shortcuts — '
            'including DefaultTextEditingShortcuts — which then handle '
            'C, X, V, A, Z, Y, arrows, etc.',
          ),
          const SizedBox(height: 8),
          _paragraph(
            'Live demo (the action is wired but harmless — it just calls '
            'showDialog):',
          ),
          _CommandPaletteDemo(),
        ],
      ),
    ),
  );
}

class _CommandPaletteIntent extends Intent {
  const _CommandPaletteIntent();
}

class _OpenCommandPaletteAction extends Action<_CommandPaletteIntent> {
  _OpenCommandPaletteAction(this.context);
  final BuildContext context;

  @override
  Object? invoke(_CommandPaletteIntent intent) {
    print('[shortcuts] Cmd/Ctrl+K → opening command palette');
    showDialog<void>(
      context: context,
      builder: (BuildContext c) => AlertDialog(
        title: const Text('Command Palette'),
        content: const SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Pretend search box, recent files list, fuzzy match…'),
              SizedBox(height: 8),
              Text(
                'This dialog only opens because we layered a custom '
                'Shortcuts above DefaultTextEditingShortcuts.',
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(c).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
    return null;
  }
}

class _CommandPaletteDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext innerContext) {
        return Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            const CharacterActivator('k', meta: true):
                const _CommandPaletteIntent(),
            const CharacterActivator('k', control: true):
                const _CommandPaletteIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              _CommandPaletteIntent:
                  _OpenCommandPaletteAction(innerContext),
            },
            child: DefaultTextEditingShortcuts(
              child: TextField(
                controller: TextEditingController(
                  text: 'Try Cmd+K (or Ctrl+K) here.',
                ),
                decoration: const InputDecoration(
                  labelText: 'Custom shortcut + defaults coexist',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// Section 6 — Disabling defaults
// -----------------------------------------------------------------------------

Widget _buildDisableDefaultsSection(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'You can suppress the default editing shortcuts by wrapping a '
            'subtree with a Shortcuts widget whose ShortcutManager has an '
            'empty map. The way Shortcuts resolution works, the inner '
            'manager will claim "I have something to say about every key '
            'event" and refuse to fall through. The ancestor '
            'DefaultTextEditingShortcuts never sees the events.',
          ),
          _codeBlock(
            'Shortcuts.manager(\n'
            '  manager: ShortcutManager(\n'
            '    shortcuts: const <ShortcutActivator, Intent>{},\n'
            '    modal: true,\n'
            '  ),\n'
            '  child: TextField(...),\n'
            ')',
          ),
          _paragraph(
            'The effect of `modal: true` is critical here. Without it, the '
            'manager would pass through unhandled events to ancestors, '
            'and your defaults would resume working. With it, this layer '
            'becomes a wall.',
          ),
          _bullet(
            'Use case: a code editor with vim emulation that uses raw key '
            'events directly and would conflict with default bindings.',
          ),
          _bullet(
            'Use case: a chess board input where Cmd+A means "select all '
            'pieces" inside the board, but you do not want it leaking to '
            'a TextField below.',
          ),
          _bullet(
            'Use case: a kiosk / single-key data entry app that disables '
            'rich editing entirely.',
          ),
          const SizedBox(height: 8),
          _paragraph('Live demo — try Cmd/Ctrl+A inside this field:'),
          Shortcuts.manager(
            manager: ShortcutManager(
              shortcuts: const <ShortcutActivator, Intent>{},
              modal: true,
            ),
            child: TextField(
              controller: TextEditingController(
                text:
                    'Default editing shortcuts are disabled in this field. '
                    'Cmd+A will not select all here.',
              ),
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Defaults disabled (modal)',
                helperText:
                    'Modal Shortcuts.manager with empty map blocks defaults',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _paragraph(
            'Note: this is a heavy hammer. In production you would more '
            'often disable specific intents by mapping them to '
            'DoNothingIntent or DoNothingAndStopPropagationIntent at a '
            'narrower scope. The "modal empty map" trick is a useful '
            'illustration but not always the right tool.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 7 — EditableText with custom controller
// -----------------------------------------------------------------------------

Widget _buildEditableTextSection(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'A bare EditableText is the lower-level building block beneath '
            'TextField. It exposes more wiring (focus node, selection '
            'controls, text style) but still benefits from the ancestor '
            'DefaultTextEditingShortcuts. Cut/copy/paste flow through the '
            'same Actions pipeline; the text controller updates, and the '
            'usual undo/redo stack is recorded.',
          ),
          _codeBlock(
            'DefaultTextEditingShortcuts(\n'
            '  child: EditableText(\n'
            '    controller: TextEditingController(text: "..."),\n'
            '    focusNode: FocusNode(),\n'
            '    style: const TextStyle(fontSize: 16, color: Colors.black),\n'
            '    cursorColor: Colors.indigo,\n'
            '    backgroundCursorColor: Colors.indigoAccent,\n'
            '  ),\n'
            ')',
          ),
          const SizedBox(height: 8),
          _EditableTextLiveDemo(),
          const SizedBox(height: 12),
          _paragraph(
            'Note that EditableText does not paint itself a Material '
            'background, decoration, or selection toolbar by default. '
            'TextField wraps it with all of those. For this demo we put '
            'it inside a small bordered container.',
          ),
          _bullet(
            'Even without TextField chrome, Cmd+C still copies and Cmd+V '
            'still pastes — those are pure intent dispatches, not visual '
            'features.',
          ),
          _bullet(
            'undo/redo, however, depends on `undoController` / '
            '`UndoHistoryController`. Without one wired up, Cmd+Z is a '
            'no-op even though the activator is registered.',
          ),
        ],
      ),
    ),
  );
}

class _EditableTextLiveDemo extends StatefulWidget {
  @override
  State<_EditableTextLiveDemo> createState() => _EditableTextLiveDemoState();
}

class _EditableTextLiveDemoState extends State<_EditableTextLiveDemo> {
  late final TextEditingController _controller;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text:
          'EditableText demo. Type, select, copy, paste — controller will '
          'reflect changes.',
    );
    _focus = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo.shade200),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DefaultTextEditingShortcuts(
        child: EditableText(
          controller: _controller,
          focusNode: _focus,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
          cursorColor: Colors.indigo,
          backgroundCursorColor: Colors.indigoAccent,
          maxLines: 3,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 8 — RTL / IME interplay
// -----------------------------------------------------------------------------

Widget _buildRtlSection(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'The "directional" intents — MoveSelectionLeft, '
            'MoveSelectionRight, ExtendSelectionToNextWord, etc. — are '
            'remapped under Directionality.rtl. Pressing the right arrow '
            'in an RTL text field moves the caret backward (visually '
            'leftward in source order), and vice versa. '
            'DefaultTextEditingShortcuts itself does not flip the '
            'bindings; the corresponding Action implementations consult '
            'the active Directionality and adjust.',
          ),
          _codeBlock(
            'Directionality(\n'
            '  textDirection: TextDirection.rtl,\n'
            '  child: DefaultTextEditingShortcuts(\n'
            '    child: TextField(...),\n'
            '  ),\n'
            ')',
          ),
          const SizedBox(height: 12),
          Directionality(
            textDirection: TextDirection.rtl,
            child: DefaultTextEditingShortcuts(
              child: TextField(
                controller: TextEditingController(
                  text: 'مرحبا بالعالم — try the arrow keys here.',
                ),
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'RTL field',
                  helperText:
                      'Right arrow moves backward in source order in RTL',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _paragraph(
            'IME (Input Method Editor) considerations layer on top of '
            'this. While an IME composition is in progress, certain '
            'keys (arrows, Backspace, Enter) are intercepted by the '
            'platform IME and never reach Flutter. Your '
            'DefaultTextEditingShortcuts therefore appears to "stop '
            'working" while a Japanese / Korean / Chinese composition is '
            'active. This is correct behavior — once the composition is '
            'committed, the bindings resume.',
          ),
          _bullet(
            'Do not try to fight the IME. Layer-7 logic should never '
            'see composition fragments.',
          ),
          _bullet(
            'Test RTL behavior with Directionality wrappers, not by '
            'switching system locale — the shortcut layer only reads '
            'Directionality.of(context).',
          ),
          _bullet(
            'Bidi mixed text (Arabic + English) can produce caret '
            'positions that surprise users; the shortcuts behave '
            'consistently but the visual jumps are by spec.',
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 9 — Per-platform cheatsheet card
// -----------------------------------------------------------------------------

Widget _buildCheatsheetSection(BuildContext context) {
  final TargetPlatform current = Theme.of(context).platform;
  final List<_CheatLine> lines = <_CheatLine>[
    _CheatLine(
      platform: TargetPlatform.macOS,
      modifier: 'Cmd (⌘)',
      role: 'Primary editing modifier (copy, paste, line jumps).',
    ),
    _CheatLine(
      platform: TargetPlatform.macOS,
      modifier: 'Option (⌥)',
      role: 'Word-level navigation. Replaces Ctrl on Apple platforms.',
    ),
    _CheatLine(
      platform: TargetPlatform.iOS,
      modifier: 'Cmd (⌘)',
      role: 'Same as macOS — copy/paste/select all/line jumps.',
    ),
    _CheatLine(
      platform: TargetPlatform.iOS,
      modifier: 'Option (⌥)',
      role: 'Word jumps, requires external keyboard.',
    ),
    _CheatLine(
      platform: TargetPlatform.windows,
      modifier: 'Ctrl',
      role: 'Primary editing modifier. Works for clipboard, word jumps, '
          'line range.',
    ),
    _CheatLine(
      platform: TargetPlatform.windows,
      modifier: 'Alt',
      role: 'Mostly used for menu access; not bound for editing.',
    ),
    _CheatLine(
      platform: TargetPlatform.linux,
      modifier: 'Ctrl',
      role: 'Same as Windows for editing operations.',
    ),
    _CheatLine(
      platform: TargetPlatform.android,
      modifier: 'Ctrl',
      role: 'Bluetooth/USB keyboard editing modifier.',
    ),
    _CheatLine(
      platform: TargetPlatform.android,
      modifier: 'Shift',
      role: 'Selection extension across all platforms.',
    ),
  ];

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'Modifier cheatsheet — which key plays what role per platform. '
            'The line for the current platform is highlighted.',
          ),
          const SizedBox(height: 8),
          for (final _CheatLine line in lines)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: line.platform == current
                    ? Colors.indigo.shade50
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: line.platform == current
                      ? Colors.indigo.shade300
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 78,
                    child: Text(
                      line.platform.name,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      line.modifier,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      line.role,
                      style: const TextStyle(fontSize: 13, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          _paragraph(
            'Quick example combos (current platform):',
            emphasis: true,
          ),
          const SizedBox(height: 4),
          if (current == TargetPlatform.macOS ||
              current == TargetPlatform.iOS) ...<Widget>[
            _kbdRow(<String>['⌘', 'A']),
            _kbdRow(<String>['⌘', 'C']),
            _kbdRow(<String>['⌘', '←']),
            _kbdRow(<String>['⌥', '←']),
          ] else ...<Widget>[
            _kbdRow(<String>['Ctrl', 'A']),
            _kbdRow(<String>['Ctrl', 'C']),
            _kbdRow(<String>['Home']),
            _kbdRow(<String>['Ctrl', '←']),
          ],
        ],
      ),
    ),
  );
}

class _CheatLine {
  final TargetPlatform platform;
  final String modifier;
  final String role;

  _CheatLine({
    required this.platform,
    required this.modifier,
    required this.role,
  });
}

// -----------------------------------------------------------------------------
// Section 10 — Pitfalls
// -----------------------------------------------------------------------------

Widget _buildPitfallsSection(BuildContext context) {
  final List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      title: 'Double-wrapping is harmless but pointless',
      detail:
          'WidgetsApp / MaterialApp / CupertinoApp already include a '
          'DefaultTextEditingShortcuts at the root. Wrapping a TextField '
          'in another one does not break anything, but it also adds no '
          'value. Use it only when you have explicitly stripped the '
          'ancestor (rare) or when you want to be self-documenting.',
      icon: Icons.layers,
    ),
    _Pitfall(
      title: 'Platform overrides need Theme(data: …)',
      detail:
          'Setting defaultTargetPlatform from a test or app-level main '
          'changes everything globally and survives between tests. The '
          'safer approach is to wrap a subtree in Theme(data: '
          'ThemeData(platform: TargetPlatform.x)) and let the inherited '
          'theme drive the binding map.',
      icon: Icons.swap_horiz,
    ),
    _Pitfall(
      title: 'Layering order matters',
      detail:
          'Custom Shortcuts MUST be placed above DefaultTextEditingShortcuts '
          'in the tree, not below. Inverting the order means your custom '
          'binding will never be reached if the default already matches '
          'the same activator. Standard pattern: '
          'Shortcuts(... child: DefaultTextEditingShortcuts(child: ...))',
      icon: Icons.format_list_numbered,
    ),
    _Pitfall(
      title: 'SelectAllTextIntent on web',
      detail:
          'On Flutter Web, the browser may steal Cmd/Ctrl+A and select '
          'page content rather than letting Flutter dispatch '
          'SelectAllTextIntent. The fix is platform-aware: prevent '
          'default at the JS layer, or live with the platform behavior. '
          'A bare TextField inside a CanvasKit canvas usually works '
          'correctly; HTML renderer can drift.',
      icon: Icons.web,
    ),
    _Pitfall(
      title: 'Accessibility shortcuts',
      detail:
          'Screen readers (VoiceOver, TalkBack, NVDA, JAWS) hijack many '
          'modifier combinations to drive their own command surface. '
          'When a screen reader is active, your custom Cmd+K may never '
          'reach Flutter — and you should not try to claw it back. '
          'Provide alternative entry points (menus, floating buttons) '
          'so non-keyboard users can still reach the feature.',
      icon: Icons.accessibility,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (final _Pitfall p in pitfalls)
        Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: Colors.amber.shade50,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(p.icon, color: Colors.amber.shade800, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        p.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.detail,
                        style: const TextStyle(fontSize: 13.5, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

class _Pitfall {
  final String title;
  final String detail;
  final IconData icon;

  _Pitfall({
    required this.title,
    required this.detail,
    required this.icon,
  });
}

// -----------------------------------------------------------------------------
// Section 11 — Recipe gallery
// -----------------------------------------------------------------------------

Widget _buildRecipeGallerySection(BuildContext context) {
  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'Recipe: Command palette (Cmd/Ctrl+K)',
      summary:
          'Add a global command palette without breaking text editing.',
      code:
          'Shortcuts(\n'
          '  shortcuts: {\n'
          '    SingleActivator(LogicalKeyboardKey.keyK, meta: true):\n'
          '        const _CommandPaletteIntent(),\n'
          '    SingleActivator(LogicalKeyboardKey.keyK, control: true):\n'
          '        const _CommandPaletteIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: {\n'
          '      _CommandPaletteIntent: _OpenCommandPaletteAction(),\n'
          '    },\n'
          '    child: child,\n'
          '  ),\n'
          ')',
      bullets: <String>[
        'Use SingleActivator with both meta and control to cover macOS '
            'and Linux/Windows simultaneously.',
        'Place the Shortcuts above DefaultTextEditingShortcuts so it '
            'wins over editing defaults.',
        'Wire an Actions widget at the same level so the intent has '
            'somewhere to dispatch.',
      ],
      color: Colors.indigo,
      icon: Icons.search,
    ),
    _Recipe(
      title: 'Recipe: vim-style word jumps via custom Shortcuts overlay',
      summary:
          'Make w / b / e move by word inside an editor view, without '
          'breaking Cmd+C / Cmd+V.',
      code:
          'Shortcuts(\n'
          '  shortcuts: {\n'
          '    SingleActivator(LogicalKeyboardKey.keyW):\n'
          '        const ExtendSelectionToNextWordBoundaryIntent(\n'
          '            forward: true, collapseSelection: true),\n'
          '    SingleActivator(LogicalKeyboardKey.keyB):\n'
          '        const ExtendSelectionToNextWordBoundaryIntent(\n'
          '            forward: false, collapseSelection: true),\n'
          '  },\n'
          '  child: DefaultTextEditingShortcuts(child: TextField(...)),\n'
          ')',
      bullets: <String>[
        'Reuses Flutter\'s built-in directional/word intents — no need '
            'to roll your own Action.',
        'Only active in the vim-mode editor view; rest of the app sees '
            'the default editing shortcuts.',
        'Pair with a mode-toggle (insert vs normal) so plain "w" still '
            'types a "w" in insert mode.',
      ],
      color: Colors.green,
      icon: Icons.terminal,
    ),
    _Recipe(
      title: 'Recipe: Autosave on Cmd/Ctrl+S',
      summary:
          'Intercept the platform "save" key combo and trigger a domain '
          'action.',
      code:
          'Shortcuts(\n'
          '  shortcuts: {\n'
          '    SingleActivator(LogicalKeyboardKey.keyS, meta: true):\n'
          '        const _SaveIntent(),\n'
          '    SingleActivator(LogicalKeyboardKey.keyS, control: true):\n'
          '        const _SaveIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: {_SaveIntent: _SaveAction(model)},\n'
          '    child: child,\n'
          '  ),\n'
          ')',
      bullets: <String>[
        'Override at the document scope, not globally — otherwise '
            'Cmd+S inside dialogs may also trigger save.',
        'Show feedback via SnackBar / Toast / status bar.',
        'Disable while a save is already in progress.',
      ],
      color: Colors.teal,
      icon: Icons.save,
    ),
    _Recipe(
      title: 'Recipe: Emacs-style "kill ring" add-on',
      summary:
          'Add Ctrl+K (kill to end of line) and Ctrl+Y (yank) as auxiliary '
          'commands.',
      code:
          'Shortcuts(\n'
          '  shortcuts: {\n'
          '    SingleActivator(LogicalKeyboardKey.keyK, control: true):\n'
          '        const _KillLineIntent(),\n'
          '    SingleActivator(LogicalKeyboardKey.keyY, control: true):\n'
          '        const _YankIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: {\n'
          '      _KillLineIntent: _KillLineAction(ring),\n'
          '      _YankIntent: _YankAction(ring),\n'
          '    },\n'
          '    child: DefaultTextEditingShortcuts(child: child),\n'
          '  ),\n'
          ')',
      bullets: <String>[
        'Conflicts with Windows redo (Ctrl+Y) — namespace your editor '
            'with a focus scope.',
        'The "ring" is just a stack; Ctrl+Y rotates / pastes.',
        'Maintains the muscle memory of long-time emacs users without '
            'forcing the rest of the app into a different paradigm.',
      ],
      color: Colors.purple,
      icon: Icons.recycling,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (final _Recipe r in recipes) _buildRecipeCard(r),
    ],
  );
}

Widget _buildRecipeCard(_Recipe r) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(r.icon, color: r.color, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  r.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: r.color.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            r.summary,
            style: TextStyle(
              fontSize: 13.5,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade700,
            ),
          ),
          _codeBlock(r.code),
          for (final String b in r.bullets) _bullet(b),
        ],
      ),
    ),
  );
}

class _Recipe {
  final String title;
  final String summary;
  final String code;
  final List<String> bullets;
  final MaterialColor color;
  final IconData icon;

  _Recipe({
    required this.title,
    required this.summary,
    required this.code,
    required this.bullets,
    required this.color,
    required this.icon,
  });
}

// -----------------------------------------------------------------------------
// Section 12 — Reference table
// -----------------------------------------------------------------------------

Widget _buildReferenceTableSection(BuildContext context) {
  final List<_RefRow> refs = <_RefRow>[
    const _RefRow(
      type: 'DefaultTextEditingShortcuts',
      kind: 'Widget',
      summary:
          'Provides the platform-default text-editing keybinding map to '
          'descendants.',
    ),
    const _RefRow(
      type: 'Shortcuts',
      kind: 'Widget',
      summary:
          'Declarative mapping from ShortcutActivator to Intent. Composable '
          'via tree position.',
    ),
    const _RefRow(
      type: 'ShortcutManager',
      kind: 'Class',
      summary:
          'Imperative manager backing a Shortcuts widget. Exposes modal '
          'flag and dynamic add/remove.',
    ),
    const _RefRow(
      type: 'Actions',
      kind: 'Widget',
      summary:
          'Maps Intent types to Action implementations. Pairs with '
          'Shortcuts for full handling.',
    ),
    const _RefRow(
      type: 'TextEditingController',
      kind: 'Class',
      summary:
          'Holds the current text and selection. Observed by EditableText '
          'and TextField.',
    ),
    const _RefRow(
      type: 'EditableText',
      kind: 'Widget',
      summary:
          'Low-level text editing primitive. TextField is its Material '
          'wrapper.',
    ),
    const _RefRow(
      type: 'TextField',
      kind: 'Widget',
      summary:
          'Material-styled text input. Inherits DefaultTextEditingShortcuts '
          'from MaterialApp.',
    ),
    const _RefRow(
      type: 'TextEditingActionTarget',
      kind: 'Mixin',
      summary:
          'Adapter that lets text-editing intents reach a controller. '
          'Implemented by EditableTextState.',
    ),
    const _RefRow(
      type: 'CopyTextIntent',
      kind: 'Intent',
      summary:
          'Triggered by Cmd/Ctrl+C. Calls clipboard write and signals the '
          'selection toolbar.',
    ),
    const _RefRow(
      type: 'PasteTextIntent',
      kind: 'Intent',
      summary:
          'Triggered by Cmd/Ctrl+V. Inserts clipboard text at the caret.',
    ),
    const _RefRow(
      type: 'CutTextIntent',
      kind: 'Intent',
      summary:
          'Triggered by Cmd/Ctrl+X. Equivalent to copy + delete selection.',
    ),
    const _RefRow(
      type: 'SelectAllTextIntent',
      kind: 'Intent',
      summary:
          'Triggered by Cmd/Ctrl+A. Sets selection to the full text range.',
    ),
    const _RefRow(
      type: 'ExtendSelectionByCharacterIntent',
      kind: 'Intent',
      summary:
          'Drives Shift+Arrow and friends. Forward + collapseSelection '
          'parameters control direction and mode.',
    ),
    const _RefRow(
      type: 'ExtendSelectionToNextWordBoundaryIntent',
      kind: 'Intent',
      summary:
          'Word-level navigation. Used by Ctrl+Left/Right and '
          'Alt+Left/Right depending on platform.',
    ),
    const _RefRow(
      type: 'UndoTextIntent / RedoTextIntent',
      kind: 'Intent',
      summary:
          'Bound to Cmd/Ctrl+Z and platform-specific redo combos. Requires '
          'an UndoHistoryController to be effective.',
    ),
  ];

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _paragraph(
            'A quick lookup of the most relevant types in the Flutter '
            'framework that surround DefaultTextEditingShortcuts.',
          ),
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2.4),
                1: FlexColumnWidth(1.0),
                2: FlexColumnWidth(4.5),
              },
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade300, width: 0.5),
              ),
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Kind',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Summary',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                for (final _RefRow r in refs)
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          r.type,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          r.kind,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          r.summary,
                          style: const TextStyle(fontSize: 12.5, height: 1.35),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _paragraph(
            'A reasonable mental model:',
            emphasis: true,
          ),
          _bullet(
            'Shortcuts widgets define the *triggers* (what key combos '
            'count as which intents).',
          ),
          _bullet(
            'Actions widgets define the *handlers* (what each intent '
            'actually does in this scope).',
          ),
          _bullet(
            'TextEditingController + EditableText form the *target* '
            '(where the changes land).',
          ),
          _bullet(
            'DefaultTextEditingShortcuts and DefaultTextEditingActions '
            'provide platform-aware defaults for both halves of that '
            'pipeline so you rarely need to think about the wiring.',
          ),
        ],
      ),
    ),
  );
}

class _RefRow {
  final String type;
  final String kind;
  final String summary;

  const _RefRow({
    required this.type,
    required this.kind,
    required this.summary,
  });
}

// -----------------------------------------------------------------------------
// Footer
// -----------------------------------------------------------------------------

Widget _buildFooter(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Wrap up',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _paragraph(
          'DefaultTextEditingShortcuts is a small widget with a large '
          'effect. Knowing where it sits, what it binds, and how to '
          'compose around it lets you build keyboard-first UIs that '
          'feel native on every platform Flutter targets.',
        ),
        _bullet(
          'Reach for it when you need a deterministic, platform-aware '
          'baseline of editing shortcuts.',
        ),
        _bullet(
          'Layer custom Shortcuts above it for app-level commands.',
        ),
        _bullet(
          'Disable it surgically (DoNothingIntent) — the "modal empty '
          'map" trick is a sledgehammer.',
        ),
        _bullet(
          'Use Theme(data: ThemeData(platform: …)) to test platform '
          'variants without globally mutating defaultTargetPlatform.',
        ),
        const SizedBox(height: 8),
        _paragraph(
          'End of demo.',
          emphasis: true,
        ),
      ],
    ),
  );
}
