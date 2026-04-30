// ignore_for_file: avoid_print
// Deep demo: DialogWindowControllerMacOS — native dialog window management on macOS
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Deep Forest / Ivory Mist
// ─────────────────────────────────────────────────────────────
const Color _wmForest = Color(0xFF1B5E20);
const Color _wmIvory = Color(0xFFF1F8E9);
const Color _wmDarkForest = Color(0xFF003300);
const Color _wmMedForest = Color(0xFF388E3C);
const Color _wmLightGreen = Color(0xFFA5D6A7);
const Color _wmWhite = Color(0xFFFFFFFF);
const Color _wmDarkText = Color(0xFF0A1F0A);
const Color _wmAccentCyan = Color(0xFF006064);
const Color _wmAccentBlue = Color(0xFF0D47A1);
const Color _wmAccentOrange = Color(0xFFE65100);
const Color _wmAccentRed = Color(0xFFB71C1C);
const Color _wmAccentPurple = Color(0xFF6A1B9A);
const Color _wmAccentAmber = Color(0xFFF57F17);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _wmSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wmWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _wmLightGreen, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x151B5E20), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _wmForest,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _wmWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _wmLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _wmDarkForest,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _wmBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _wmDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _wmCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF5FAF0),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _wmLightGreen.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _wmDarkForest,
            height: 1.45)),
  );
}

Widget _wmChip(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text,
        style:
            TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _wmDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _wmLightGreen.withValues(alpha: 0.4),
  );
}

Widget _wmInfoBox(String text, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(text,
        style: TextStyle(
            color: color, fontSize: 11.5, fontWeight: FontWeight.w500)),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: DialogWindowControllerMacOS');
  print('  Native dialog window management on macOS');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _wmIvory,
      appBarTheme: const AppBarTheme(
        backgroundColor: _wmForest,
        foregroundColor: _wmWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DialogWindowControllerMacOS',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Banner
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_wmDarkForest, _wmForest, _wmMedForest],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _wmWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.laptop_mac,
                        color: _wmWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('DialogWindowControllerMacOS',
                      style: TextStyle(
                          color: _wmWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                      'macOS-specific dialog control via AppKit/Cocoa',
                      style: TextStyle(
                          color: _wmWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _wmChip('macOS', _wmWhite.withValues(alpha: 0.25), _wmWhite),
                      _wmChip('AppKit', _wmWhite.withValues(alpha: 0.25), _wmWhite),
                      _wmChip('Dialogs', _wmWhite.withValues(alpha: 0.25), _wmWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('1 · What Is DialogWindowControllerMacOS?', [
              _wmBody(
                'DialogWindowControllerMacOS is the macOS-specific controller '
                'that manages native dialog windows. It bridges Flutter to '
                'the AppKit/Cocoa windowing system for file panels, alerts, '
                'sheets, and modal windows.',
              ),
              _wmLabel('Core responsibilities'),
              _buildMacResponsibilities(),
              _wmDivider(),
              _wmInfoBox(
                'This controller is exclusive to macOS — Linux and Windows '
                'have their own platform-specific dialog controllers.',
                _wmAccentCyan,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: macOS architecture
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('2 · macOS Window Architecture', [
              _wmBody(
                'Flutter on macOS uses AppKit for windowing. Dialogs are '
                'native NSWindow or NSPanel instances managed by the embedder.',
              ),
              _buildMacArchitecture(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Dialog types on macOS
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('3 · Dialog Types on macOS', [
              _wmBody(
                'macOS provides multiple native dialog types through AppKit:',
              ),
              _buildMacDialogTypes(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Sheet vs. window dialogs
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('4 · Sheets vs. Window Dialogs', [
              _wmBody(
                'macOS has a unique dialog concept: sheets that attach '
                'to the parent window\'s title bar, sliding down from it.',
              ),
              _buildSheetComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: NSOpenPanel and NSSavePanel
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('5 · NSOpenPanel & NSSavePanel', [
              _wmBody(
                'The primary file dialogs on macOS are NSOpenPanel for '
                'opening files and NSSavePanel for saving.',
              ),
              _wmCodeBlock(
                '// NSOpenPanel configuration (Objective-C)\n'
                'NSOpenPanel *panel = [NSOpenPanel openPanel];\n'
                '[panel setCanChooseFiles:YES];\n'
                '[panel setCanChooseDirectories:NO];\n'
                '[panel setAllowsMultipleSelection:YES];\n'
                '[panel setAllowedFileTypes:@["dart", "yaml"]];\n'
                '[panel setDirectoryURL:\n'
                '  [NSURL fileURLWithPath:@"/Users/dev"]];\n'
                '[panel setTitle:@"Select Dart Files"];',
              ),
              _wmDivider(),
              _wmCodeBlock(
                '// NSSavePanel configuration (Objective-C)\n'
                'NSSavePanel *panel = [NSSavePanel savePanel];\n'
                '[panel setNameFieldStringValue:@"export.csv"];\n'
                '[panel setAllowedFileTypes:@["csv", "txt"]];\n'
                '[panel setDirectoryURL:\n'
                '  [NSURL fileURLWithPath:@"/Users/dev/Desktop"]];\n'
                '[panel setTitle:@"Export Data"];',
              ),
              _wmDivider(),
              _wmLabel('Key differences from Linux'),
              _wmInfoBox(
                'NSOpenPanel uses URL-based paths (not string paths). '
                'File type filtering uses UTIs on modern macOS. '
                'Panels can be presented as sheets or modal windows.',
                _wmAccentBlue,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: NSAlert dialogs
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('6 · NSAlert Dialogs', [
              _wmBody(
                'NSAlert is the standard macOS alert dialog for messages, '
                'warnings, and confirmations.',
              ),
              _buildAlertStyles(),
              _wmDivider(),
              _wmCodeBlock(
                '// NSAlert creation (Objective-C)\n'
                'NSAlert *alert = [[NSAlert alloc] init];\n'
                '[alert setMessageText:@"Unsaved Changes"];\n'
                '[alert setInformativeText:\n'
                '  @"Save changes before closing?"];\n'
                '[alert setAlertStyle:NSAlertStyleWarning];\n'
                '[alert addButtonWithTitle:@"Save"];\n'
                '[alert addButtonWithTitle:@"Discard"];\n'
                '[alert addButtonWithTitle:@"Cancel"];\n'
                '\n'
                '// Present as sheet on parent window\n'
                '[alert beginSheetModalForWindow:parentWindow\n'
                '  completionHandler:^(NSModalResponse r) {\n'
                '    // Handle response\n'
                '}];',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Controller lifecycle
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('7 · Controller Lifecycle on macOS', [
              _wmBody(
                'The dialog controller lifecycle on macOS follows '
                'AppKit patterns with runloop integration.',
              ),
              _buildMacLifecycle(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Sandbox and security
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('8 · Sandbox & Security Scoped Bookmarks', [
              _wmBody(
                'macOS App Sandbox affects how dialogs work — file access '
                'requires security-scoped bookmarks for persistent access.',
              ),
              _buildSandboxFlow(),
              _wmDivider(),
              _wmCodeBlock(
                '// Security-scoped bookmark workflow\n'
                '// 1. User selects file via NSOpenPanel\n'
                '//    → Temporary access granted by sandbox\n'
                '//\n'
                '// 2. Create bookmark for persistent access:\n'
                '//    NSData *bookmark = [url\n'
                '//      bookmarkDataWithOptions:\n'
                '//        NSURLBookmarkCreationWith\n'
                '//          SecurityScope\n'
                '//      includingResourceValuesForKeys:nil\n'
                '//      relativeToURL:nil error:&error];\n'
                '//\n'
                '// 3. Later, resolve bookmark:\n'
                '//    NSURL *resolved = [NSURL\n'
                '//      URLByResolvingBookmarkData:bookmark\n'
                '//      options:\n'
                '//        NSURLBookmarkResolutionWith\n'
                '//          SecurityScope\n'
                '//      relativeToURL:nil\n'
                '//      bookmarkDataIsStale:&stale\n'
                '//      error:&error];\n'
                '//    [resolved startAccessingSecurityScopedResource];',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Window management
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('9 · Window Management', [
              _wmBody(
                'Dialog windows on macOS have distinct positioning and '
                'appearance behaviors compared to Linux.',
              ),
              _buildWindowManagement(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Linux vs. macOS comparison
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('10 · Linux vs. macOS Dialog Comparison', [
              _wmBody(
                'Key differences between the two platform controllers:',
              ),
              _buildLinuxMacComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Practical scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('11 · Practical Scenario: Multi-File Export', [
              _wmBody(
                'A Flutter desktop app on macOS exports multiple files '
                'to a user-chosen directory using NSSavePanel.',
              ),
              _buildExportScenario(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wmSection('12 · Summary', [
              _wmBody(
                'DialogWindowControllerMacOS provides native-quality '
                'dialog integration for Flutter on Apple platforms.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_wmForest, _wmMedForest],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _wmSummaryRow(Icons.laptop_mac, 'AppKit/Cocoa native dialog integration'),
                    _wmSummaryRow(Icons.file_open, 'NSOpenPanel and NSSavePanel support'),
                    _wmSummaryRow(Icons.warning_amber, 'NSAlert for messages and confirmations'),
                    _wmSummaryRow(Icons.web_asset, 'Sheets that attach to parent window'),
                    _wmSummaryRow(Icons.security, 'App Sandbox and security-scoped bookmarks'),
                    _wmSummaryRow(Icons.devices, 'macOS-only — Linux/Windows use separate controllers'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 1: Responsibilities
// ─────────────────────────────────────────────────────────────
Widget _buildMacResponsibilities() {
  final items = <Map<String, dynamic>>[
    {'icon': Icons.file_open, 'text': 'NSOpenPanel file/folder selection', 'color': _wmAccentBlue},
    {'icon': Icons.save, 'text': 'NSSavePanel file save dialogs', 'color': _wmAccentCyan},
    {'icon': Icons.warning_amber, 'text': 'NSAlert message presentation', 'color': _wmAccentAmber},
    {'icon': Icons.web_asset, 'text': 'Sheet dialog management', 'color': _wmMedForest},
    {'icon': Icons.security, 'text': 'Security-scoped bookmark handling', 'color': _wmAccentOrange},
    {'icon': Icons.arrow_back, 'text': 'Result passing to Flutter through channels', 'color': _wmAccentPurple},
  ];

  return Column(
    children: items.map((item) {
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: (item['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (item['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(item['icon'] as IconData, size: 16, color: item['color'] as Color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(item['text'] as String,
                  style: TextStyle(
                      color: item['color'] as Color,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2: Architecture
// ─────────────────────────────────────────────────────────────
Widget _buildMacArchitecture() {
  final layers = <Map<String, dynamic>>[
    {'name': 'Flutter Framework', 'desc': 'showDialog(), FilePicker API', 'color': _wmAccentBlue},
    {'name': 'Platform Channels', 'desc': 'FlutterMethodChannel for dialog calls', 'color': _wmAccentCyan},
    {'name': 'macOS Embedder (Swift/ObjC)', 'desc': 'FLEDialogWindowController', 'color': _wmMedForest},
    {'name': 'AppKit', 'desc': 'NSOpenPanel, NSSavePanel, NSAlert, NSWindow', 'color': _wmAccentOrange},
    {'name': 'WindowServer / Quartz', 'desc': 'Display compositing and window management', 'color': _wmAccentPurple},
  ];

  return Column(
    children: layers.asMap().entries.map((entry) {
      final l = entry.value;
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (l['color'] as Color).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: (l['color'] as Color).withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: l['color'] as Color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('${entry.key + 1}',
                        style: const TextStyle(
                            color: _wmWhite,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l['name'] as String,
                          style: TextStyle(
                              color: l['color'] as Color,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      Text(l['desc'] as String,
                          style: const TextStyle(
                              color: _wmDarkText, fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (entry.key < layers.length - 1)
            Container(
              width: 2,
              height: 12,
              color: _wmLightGreen,
            ),
        ],
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Dialog types
// ─────────────────────────────────────────────────────────────
Widget _buildMacDialogTypes() {
  final types = <Map<String, dynamic>>[
    {
      'type': 'File Open',
      'api': 'NSOpenPanel',
      'detail': 'setCanChooseFiles, setAllowsMultipleSelection',
      'icon': Icons.file_open,
      'color': _wmAccentBlue,
    },
    {
      'type': 'File Save',
      'api': 'NSSavePanel',
      'detail': 'setNameFieldStringValue, setAllowedFileTypes',
      'icon': Icons.save,
      'color': _wmAccentCyan,
    },
    {
      'type': 'Folder Select',
      'api': 'NSOpenPanel',
      'detail': 'setCanChooseDirectories:YES, setCanChooseFiles:NO',
      'icon': Icons.folder_open,
      'color': _wmMedForest,
    },
    {
      'type': 'Alert / Warning',
      'api': 'NSAlert',
      'detail': 'NSAlertStyleWarning, custom buttons',
      'icon': Icons.warning_amber,
      'color': _wmAccentAmber,
    },
    {
      'type': 'Error Alert',
      'api': 'NSAlert',
      'detail': 'NSAlertStyleCritical, error icon',
      'icon': Icons.error,
      'color': _wmAccentRed,
    },
    {
      'type': 'Confirmation',
      'api': 'NSAlert',
      'detail': 'NSAlertStyleInformational, Save/Discard/Cancel',
      'icon': Icons.help_outline,
      'color': _wmAccentOrange,
    },
  ];

  return Column(
    children: types.map((t) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (t['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (t['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: t['color'] as Color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(t['icon'] as IconData, color: _wmWhite, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(t['type'] as String,
                          style: TextStyle(
                              color: t['color'] as Color,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      _wmChip(t['api'] as String,
                          (t['color'] as Color).withValues(alpha: 0.1),
                          t['color'] as Color),
                    ],
                  ),
                  Text(t['detail'] as String,
                      style: const TextStyle(
                          fontFamily: 'monospace',
                          color: _wmDarkText,
                          fontSize: 9)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Sheets vs. modal
// ─────────────────────────────────────────────────────────────
Widget _buildSheetComparison() {
  final modes = <Map<String, dynamic>>[
    {
      'mode': 'Sheet Dialog',
      'desc': 'Slides down from the window title bar',
      'traits': 'Attached to parent • Animates in/out • '
          'macOS-specific UX pattern • Cannot be moved independently',
      'icon': Icons.web_asset,
      'color': _wmAccentBlue,
    },
    {
      'mode': 'Modal Window',
      'desc': 'Separate floating window over the app',
      'traits': 'Independent window • Blocks parent • '
          'Can be moved freely • More traditional dialog',
      'icon': Icons.open_in_new,
      'color': _wmAccentOrange,
    },
    {
      'mode': 'Modeless Window',
      'desc': 'Independent window, parent stays interactive',
      'traits': 'Non-blocking • Can lose focus to parent • '
          'Used for inspectors and tool palettes',
      'icon': Icons.layers,
      'color': _wmMedForest,
    },
  ];

  return Column(
    children: modes.map((m) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (m['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (m['color'] as Color).withValues(alpha: 0.3), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: m['color'] as Color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(m['icon'] as IconData, color: _wmWhite, size: 14),
                ),
                const SizedBox(width: 8),
                Text(m['mode'] as String,
                    style: TextStyle(
                        color: m['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 4),
            Text(m['desc'] as String,
                style: const TextStyle(
                    color: _wmDarkText, fontSize: 11)),
            const SizedBox(height: 4),
            Text(m['traits'] as String,
                style: TextStyle(
                    color: (m['color'] as Color).withValues(alpha: 0.8),
                    fontSize: 10,
                    height: 1.4)),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Alert styles
// ─────────────────────────────────────────────────────────────
Widget _buildAlertStyles() {
  final styles = <Map<String, dynamic>>[
    {
      'style': 'NSAlertStyleInformational',
      'desc': 'Blue info icon, standard spacing',
      'icon': Icons.info,
      'color': _wmAccentBlue,
    },
    {
      'style': 'NSAlertStyleWarning',
      'desc': 'Yellow caution triangle icon',
      'icon': Icons.warning_amber,
      'color': _wmAccentAmber,
    },
    {
      'style': 'NSAlertStyleCritical',
      'desc': 'Red stop/error icon, urgent appearance',
      'icon': Icons.error,
      'color': _wmAccentRed,
    },
  ];

  return Column(
    children: styles.map((s) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (s['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: s['color'] as Color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(s['icon'] as IconData, color: _wmWhite, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['style'] as String,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          color: s['color'] as Color,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700)),
                  Text(s['desc'] as String,
                      style: const TextStyle(
                          color: _wmDarkText, fontSize: 10.5)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: Lifecycle
// ─────────────────────────────────────────────────────────────
Widget _buildMacLifecycle() {
  final steps = <Map<String, dynamic>>[
    {'phase': 'Receive', 'desc': 'MethodChannel call from Flutter', 'color': _wmAccentBlue},
    {'phase': 'Create', 'desc': 'Instantiate NSOpenPanel/NSAlert', 'color': _wmAccentCyan},
    {'phase': 'Configure', 'desc': 'Apply filters, title, initial URL', 'color': _wmMedForest},
    {'phase': 'Present', 'desc': 'beginSheetModal or runModal', 'color': _wmAccentOrange},
    {'phase': 'RunLoop', 'desc': 'AppKit processes events while dialog is open', 'color': _wmAccentAmber},
    {'phase': 'Collect', 'desc': 'Extract URLs/button response from panel', 'color': _wmAccentPurple},
    {'phase': 'Reply', 'desc': 'Send FlutterResult back to Flutter layer', 'color': _wmAccentRed},
  ];

  return Column(
    children: steps.asMap().entries.map((entry) {
      final s = entry.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: s['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${entry.key + 1}',
                        style: const TextStyle(
                            color: _wmWhite,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                if (entry.key < steps.length - 1)
                  Container(
                    width: 2,
                    height: 8,
                    color: _wmLightGreen,
                  ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: (s['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: s['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(s['phase'] as String,
                          style: const TextStyle(
                              color: _wmWhite,
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(s['desc'] as String,
                          style: const TextStyle(
                              color: _wmDarkText, fontSize: 10.5)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Sandbox flow
// ─────────────────────────────────────────────────────────────
Widget _buildSandboxFlow() {
  final steps = <Map<String, dynamic>>[
    {'icon': Icons.lock, 'label': 'App runs in sandbox — no direct filesystem access', 'color': _wmAccentRed},
    {'icon': Icons.folder_open, 'label': 'NSOpenPanel grants temporary access to selected files', 'color': _wmAccentBlue},
    {'icon': Icons.bookmark, 'label': 'Create security-scoped bookmark for persistent access', 'color': _wmMedForest},
    {'icon': Icons.lock_open, 'label': 'Resolve bookmark later to regain access', 'color': _wmAccentCyan},
    {'icon': Icons.check_circle, 'label': 'Call startAccessingSecurityScopedResource before reading', 'color': _wmAccentOrange},
    {'icon': Icons.lock, 'label': 'Call stopAccessingSecurityScopedResource when done', 'color': _wmAccentAmber},
  ];

  return Column(
    children: steps.asMap().entries.map((entry) {
      final s = entry.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (s['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: s['color'] as Color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(s['icon'] as IconData, color: _wmWhite, size: 14),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _wmForest.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${entry.key + 1}',
                    style: const TextStyle(
                        color: _wmForest,
                        fontSize: 9,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(s['label'] as String,
                  style: TextStyle(
                      color: s['color'] as Color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: Window management
// ─────────────────────────────────────────────────────────────
Widget _buildWindowManagement() {
  final features = <Map<String, dynamic>>[
    {
      'feature': 'Window Level',
      'desc': 'Dialogs use NSModalPanelWindowLevel to stay above app windows',
      'color': _wmAccentBlue,
    },
    {
      'feature': 'Title Bar Style',
      'desc': 'macOS-native title bar with traffic light buttons (close/min/max)',
      'color': _wmMedForest,
    },
    {
      'feature': 'Vibrancy',
      'desc': 'NSVisualEffectView for translucent sidebar backgrounds',
      'color': _wmAccentCyan,
    },
    {
      'feature': 'Auto-sizing',
      'desc': 'Panels auto-size based on content and sidebar expansion',
      'color': _wmAccentOrange,
    },
    {
      'feature': 'Restoration',
      'desc': 'NSWindow restorable property for state preservation across launches',
      'color': _wmAccentPurple,
    },
  ];

  return Column(
    children: features.map((f) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (f['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (f['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: f['color'] as Color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(f['feature'] as String,
                  style: const TextStyle(
                      color: _wmWhite,
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(f['desc'] as String,
                  style: const TextStyle(
                      color: _wmDarkText, fontSize: 10.5)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Linux vs macOS comparison
// ─────────────────────────────────────────────────────────────
Widget _buildLinuxMacComparison() {
  final rows = <List<String>>[
    ['Aspect', 'Linux Controller', 'macOS Controller'],
    ['Toolkit', 'GTK3/GTK4', 'AppKit (Cocoa)'],
    ['File Open', 'GtkFileChooserDialog', 'NSOpenPanel'],
    ['File Save', 'GtkFileChooserDialog', 'NSSavePanel'],
    ['Alerts', 'GtkMessageDialog', 'NSAlert'],
    ['Sheets', 'Not available', 'Native sheet support'],
    ['Sandbox', 'No sandbox (Snap/Flatpak)', 'App Sandbox + bookmarks'],
    ['Language', 'C / C++', 'Swift / Objective-C'],
    ['Display', 'X11 / Wayland', 'Quartz / WindowServer'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _wmLightGreen),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
          color: isHeader
              ? _wmForest
              : entry.key.isEven
                  ? _wmIvory
                  : _wmWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _wmWhite : _wmDarkText,
                        fontSize: 10,
                        fontWeight: isHeader || col.key == 0
                            ? FontWeight.w700
                            : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Export scenario
// ─────────────────────────────────────────────────────────────
Widget _buildExportScenario() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'User taps "Export All"',
      'code': 'onPressed: () => _exportFiles(context)',
      'color': _wmAccentBlue,
    },
    {
      'step': 'Controller asks for save directory',
      'code': 'NSOpenPanel *panel = [NSOpenPanel openPanel];\n'
          '[panel setCanChooseDirectories:YES];\n'
          '[panel setCanChooseFiles:NO];\n'
          '[panel setPrompt:@"Choose Export Folder"];',
      'color': _wmMedForest,
    },
    {
      'step': 'Sheet slides down from title bar',
      'code': '[panel beginSheetModalForWindow:self.window\n'
          '  completionHandler:^(NSModalResponse r) {\n'
          '    if (r == NSModalResponseOK) {\n'
          '      NSURL *dir = [panel URL];\n'
          '      // Pass URL back to Flutter\n'
          '    }\n'
          '}];',
      'color': _wmAccentOrange,
    },
    {
      'step': 'User selects folder, sheet closes',
      'code': '// Security-scoped access\n'
          'BOOL ok = [url startAccessing\n'
          '  SecurityScopedResource];\n'
          '// Write files to directory\n'
          '// ...\n'
          '[url stopAccessingSecurityScopedResource];',
      'color': _wmAccentCyan,
    },
    {
      'step': 'Flutter receives directory path',
      'code': 'final dir = await channel.showSavePanel(...);\n'
          'if (dir != null) {\n'
          '  for (final file in filesToExport) {\n'
          '    File("\$dir/\${file.name}")\n'
          '        .writeAsStringSync(file.content);\n'
          '  }\n'
          '}',
      'color': _wmAccentAmber,
    },
    {
      'step': 'Success notification shown',
      'code': 'ScaffoldMessenger.of(context).showSnackBar(\n'
          '  SnackBar(content: Text(\n'
          '    "Exported \${files.length} files")),\n'
          ');',
      'color': _wmAccentPurple,
    },
  ];

  return Column(
    children: steps.asMap().entries.map((entry) {
      final s = entry.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: (s['color'] as Color).withValues(alpha: 0.08),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: s['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('${entry.key + 1}',
                          style: const TextStyle(
                              color: _wmWhite,
                              fontSize: 9,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(s['step'] as String,
                        style: TextStyle(
                            color: s['color'] as Color,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: _wmWhite,
              child: Text(s['code'] as String,
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: _wmDarkForest,
                      height: 1.3)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _wmSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _wmWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _wmWhite.withValues(alpha: 0.95), fontSize: 12.5)),
        ),
      ],
    ),
  );
}
