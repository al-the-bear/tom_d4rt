// ignore_for_file: avoid_print
// Deep demo: DialogWindowController — abstract base for platform dialog management
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Steel Indigo / Pearl Mist
// ─────────────────────────────────────────────────────────────
const Color _dcIndigo = Color(0xFF303F9F);
const Color _dcPearl = Color(0xFFE8EAF6);
const Color _dcDarkIndigo = Color(0xFF1A237E);
const Color _dcMedIndigo = Color(0xFF5C6BC0);
const Color _dcLightIndigo = Color(0xFF9FA8DA);
const Color _dcWhite = Color(0xFFFFFFFF);
const Color _dcDarkText = Color(0xFF1A1A2E);
const Color _dcAccentCyan = Color(0xFF00838F);
const Color _dcAccentGreen = Color(0xFF2E7D32);
const Color _dcAccentOrange = Color(0xFFE65100);
const Color _dcAccentRed = Color(0xFFC62828);
const Color _dcAccentAmber = Color(0xFFF57F17);
const Color _dcAccentPurple = Color(0xFF6A1B9A);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _dcSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dcWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dcLightIndigo, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x15303F9F), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _dcIndigo,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _dcWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _dcLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _dcDarkIndigo,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _dcBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _dcDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _dcCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5FC),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _dcLightIndigo.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _dcDarkIndigo,
            height: 1.45)),
  );
}

Widget _dcChip(String text, Color bg, Color fg) {
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

Widget _dcDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _dcLightIndigo.withValues(alpha: 0.4),
  );
}

Widget _dcInfoBox(String text, Color color) {
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
  print('  DEEP DEMO: DialogWindowController');
  print('  Abstract base class for platform dialog control');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _dcPearl,
      appBarTheme: const AppBarTheme(
        backgroundColor: _dcIndigo,
        foregroundColor: _dcWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DialogWindowController',
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
                  colors: [_dcDarkIndigo, _dcIndigo, _dcMedIndigo],
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
                      color: _dcWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.web_asset,
                        color: _dcWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('DialogWindowController',
                      style: TextStyle(
                          color: _dcWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                      'Abstract base for cross-platform dialog management',
                      style: TextStyle(
                          color: _dcWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dcChip('Abstract', _dcWhite.withValues(alpha: 0.25), _dcWhite),
                      _dcChip('Cross-Platform', _dcWhite.withValues(alpha: 0.25), _dcWhite),
                      _dcChip('Dialogs', _dcWhite.withValues(alpha: 0.25), _dcWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('1 · What Is DialogWindowController?', [
              _dcBody(
                'DialogWindowController is the abstract base class that '
                'defines the cross-platform API for managing native dialog '
                'windows in Flutter desktop applications. Platform-specific '
                'implementations (Linux, macOS, Windows) inherit from this '
                'class and implement the actual dialog presentation.',
              ),
              _dcLabel('Design principle'),
              _dcInfoBox(
                'One abstract controller, many platform implementations. '
                'Flutter chooses the right implementation at runtime based '
                'on the current platform.',
                _dcAccentCyan,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Inheritance hierarchy
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('2 · Inheritance Hierarchy', [
              _dcBody(
                'The controller sits at the top of the dialog controller '
                'hierarchy, with platform-specific subclasses.',
              ),
              _buildControllerHierarchy(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Abstract interface
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('3 · Abstract Interface Methods', [
              _dcBody(
                'The base class defines the contract that all platform '
                'controllers must implement.',
              ),
              _buildInterfaceMethods(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Dialog result handling
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('4 · Dialog Result Handling', [
              _dcBody(
                'When a dialog completes, the controller returns a result '
                'to the Flutter layer. The result type depends on the '
                'dialog kind.',
              ),
              _buildResultTypes(),
              _dcDivider(),
              _dcCodeBlock(
                '// Result handling pattern\n'
                '// The controller returns platform-neutral results:\n'
                '\n'
                '// File dialog → String? (path) or List<String>\n'
                '// Message dialog → DialogResult enum\n'
                '// Confirmation → bool (confirmed or not)\n'
                '// Color picker → Color? (selected color)\n'
                '// Font picker → FontDescription? (selected font)',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Factory pattern
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('5 · Controller Factory Pattern', [
              _dcBody(
                'Flutter uses a factory to instantiate the correct '
                'platform controller at runtime.',
              ),
              _buildFactoryPattern(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Platform dispatch
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('6 · Platform Dispatch', [
              _dcBody(
                'The controller delegates to platform-specific implementations '
                'through the embedder layer.',
              ),
              _buildPlatformDispatch(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Configuration options
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('7 · Configuration Options', [
              _dcBody(
                'The base controller accepts configuration common across '
                'all platforms for dialog presentation.',
              ),
              _buildConfigOptions(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Lifecycle management
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('8 · Lifecycle Management', [
              _dcBody(
                'The abstract lifecycle is defined at the base level but '
                'executed by platform implementations.',
              ),
              _buildLifecycleDiagram(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Delegate pattern
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('9 · Delegate Pattern', [
              _dcBody(
                'The controller works with a delegate that receives '
                'callbacks during the dialog lifecycle.',
              ),
              _dcCodeBlock(
                '// DialogWindowControllerDelegate\n'
                '//\n'
                '// abstract class DialogWindowControllerDelegate {\n'
                '//   void dialogWillShow(DialogWindowController ctrl);\n'
                '//   void dialogDidShow(DialogWindowController ctrl);\n'
                '//   void dialogWillDismiss(DialogWindowController ctrl);\n'
                '//   void dialogDidDismiss(\n'
                '//       DialogWindowController ctrl, dynamic result);\n'
                '// }\n'
                '\n'
                '// The delegate receives lifecycle events from the\n'
                '// controller, allowing the app to react to dialog\n'
                '// state changes without subclassing the controller.',
              ),
              _dcDivider(),
              _buildDelegateFlow(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Error handling
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('10 · Error Handling', [
              _dcBody(
                'The base controller defines how errors during dialog '
                'display are caught and reported.',
              ),
              _buildErrorScenarios(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Practical scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('11 · Practical Scenario: Cross-Platform File Picker', [
              _dcBody(
                'A Flutter app that runs on Linux, macOS, and Windows '
                'uses the same high-level API, but each platform uses '
                'its own controller implementation.',
              ),
              _buildCrossPlatformScenario(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('12 · Summary', [
              _dcBody(
                'DialogWindowController provides the abstract contract that '
                'unifies dialog management across all Flutter desktop platforms.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_dcIndigo, _dcMedIndigo],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _dcSummaryRow(Icons.web_asset, 'Abstract base defining the dialog contract'),
                    _dcSummaryRow(Icons.device_hub, 'Platform dispatch via factory pattern'),
                    _dcSummaryRow(Icons.computer, 'Linux (GTK), macOS (AppKit), Windows (Win32)'),
                    _dcSummaryRow(Icons.settings, 'Common configuration across platforms'),
                    _dcSummaryRow(Icons.loop, 'Unified lifecycle: create → show → collect → destroy'),
                    _dcSummaryRow(Icons.extension, 'Delegate pattern for event callbacks'),
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
// Section 2: Controller hierarchy
// ─────────────────────────────────────────────────────────────
Widget _buildControllerHierarchy() {
  final nodes = <Map<String, dynamic>>[
    {'name': 'DialogWindowController', 'desc': 'Abstract base (defines API)', 'color': _dcIndigo, 'indent': 0, 'highlight': true},
    {'name': 'DialogWindowControllerLinux', 'desc': 'GTK3/GTK4 dialogs', 'color': _dcAccentGreen, 'indent': 1, 'highlight': false},
    {'name': 'DialogWindowControllerMacOS', 'desc': 'AppKit/Cocoa panels & alerts', 'color': _dcAccentCyan, 'indent': 1, 'highlight': false},
    {'name': 'DialogWindowControllerWin32', 'desc': 'Win32 API IFileDialog, MessageBox', 'color': _dcAccentOrange, 'indent': 1, 'highlight': false},
    {'name': 'DialogWindowControllerDelegate', 'desc': 'Lifecycle callback interface', 'color': _dcAccentPurple, 'indent': 0, 'highlight': false},
  ];

  return Column(
    children: nodes.map((n) {
      final indent = (n['indent'] as int) * 24.0;
      final isHigh = n['highlight'] as bool;
      return Container(
        margin: EdgeInsets.only(left: indent, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: (n['color'] as Color).withValues(alpha: isHigh ? 0.12 : 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: (n['color'] as Color).withValues(alpha: isHigh ? 0.5 : 0.3),
              width: isHigh ? 2 : 1),
        ),
        child: Row(
          children: [
            if (isHigh)
              Container(
                margin: const EdgeInsets.only(right: 6),
                child: const Icon(Icons.star, color: _dcIndigo, size: 14),
              ),
            Text(n['name'] as String,
                style: TextStyle(
                    color: n['color'] as Color,
                    fontSize: 11,
                    fontWeight: isHigh ? FontWeight.w800 : FontWeight.w600,
                    fontFamily: 'monospace')),
            const SizedBox(width: 8),
            Expanded(
              child: Text(n['desc'] as String,
                  style: const TextStyle(color: _dcDarkText, fontSize: 10)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Interface methods
// ─────────────────────────────────────────────────────────────
Widget _buildInterfaceMethods() {
  final methods = <Map<String, dynamic>>[
    {'name': 'showOpenDialog()', 'desc': 'Present a file/folder open dialog', 'ret': 'Future<List<String>?>', 'color': _dcAccentGreen},
    {'name': 'showSaveDialog()', 'desc': 'Present a file save dialog', 'ret': 'Future<String?>', 'color': _dcAccentCyan},
    {'name': 'showMessageDialog()', 'desc': 'Present a message/alert dialog', 'ret': 'Future<DialogResult>', 'color': _dcAccentOrange},
    {'name': 'showConfirmDialog()', 'desc': 'Present a yes/no confirmation', 'ret': 'Future<bool>', 'color': _dcAccentAmber},
    {'name': 'dismiss()', 'desc': 'Programmatically close the current dialog', 'ret': 'void', 'color': _dcAccentRed},
    {'name': 'dispose()', 'desc': 'Release all native resources', 'ret': 'void', 'color': _dcAccentPurple},
  ];

  return Column(
    children: methods.map((m) {
      return Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (m['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (m['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(m['name'] as String,
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: m['color'] as Color,
                      fontWeight: FontWeight.w700)),
            ),
            Expanded(
              flex: 4,
              child: Text(m['desc'] as String,
                  style: const TextStyle(
                      color: _dcDarkText, fontSize: 10.5)),
            ),
            _dcChip(m['ret'] as String,
                (m['color'] as Color).withValues(alpha: 0.1),
                m['color'] as Color),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Result types
// ─────────────────────────────────────────────────────────────
Widget _buildResultTypes() {
  final results = <Map<String, dynamic>>[
    {'dialog': 'File Open', 'result': 'List<String>?', 'example': '["/home/user/doc.dart"]', 'color': _dcAccentGreen},
    {'dialog': 'File Save', 'result': 'String?', 'example': '"/home/user/export.csv"', 'color': _dcAccentCyan},
    {'dialog': 'Folder Select', 'result': 'String?', 'example': '"/home/user/projects"', 'color': _dcAccentOrange},
    {'dialog': 'Message/Alert', 'result': 'DialogResult', 'example': 'DialogResult.ok', 'color': _dcAccentAmber},
    {'dialog': 'Confirmation', 'result': 'bool', 'example': 'true (user confirmed)', 'color': _dcAccentPurple},
    {'dialog': 'Cancelled', 'result': 'null / false', 'example': 'null (user cancelled)', 'color': _dcAccentRed},
  ];

  return Column(
    children: results.map((r) {
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: (r['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (r['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(r['dialog'] as String,
                  style: TextStyle(
                      color: r['color'] as Color,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _dcPearl,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(r['result'] as String,
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: r['color'] as Color)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(r['example'] as String,
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      color: _dcDarkText,
                      fontSize: 9.5)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: Factory pattern
// ─────────────────────────────────────────────────────────────
Widget _buildFactoryPattern() {
  return Column(
    children: [
      _dcCodeBlock(
        '// Factory determines the platform controller\n'
        '//\n'
        '// DialogWindowController create() {\n'
        '//   if (Platform.isLinux) {\n'
        '//     return DialogWindowControllerLinux();\n'
        '//   } else if (Platform.isMacOS) {\n'
        '//     return DialogWindowControllerMacOS();\n'
        '//   } else if (Platform.isWindows) {\n'
        '//     return DialogWindowControllerWin32();\n'
        '//   }\n'
        '//   throw UnsupportedError(\n'
        '//     "No dialog controller for this platform");\n'
        '// }',
      ),
      _dcDivider(),
      _dcLabel('Factory dispatch visualization'),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _dcPearl,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _dcLightIndigo),
        ),
        child: Column(
          children: [
            // Factory box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _dcIndigo,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text('DialogWindowController.create()',
                    style: TextStyle(
                        fontFamily: 'monospace',
                        color: _dcWhite,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 8),
            // Three branches
            Row(
              children: [
                Expanded(child: _dcPlatformBox('Linux', 'GTK', _dcAccentGreen)),
                const SizedBox(width: 6),
                Expanded(child: _dcPlatformBox('macOS', 'AppKit', _dcAccentCyan)),
                const SizedBox(width: 6),
                Expanded(child: _dcPlatformBox('Windows', 'Win32', _dcAccentOrange)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _dcPlatformBox(String platform, String toolkit, Color color) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      children: [
        Text(platform,
            style: TextStyle(
                color: color, fontSize: 11, fontWeight: FontWeight.w700)),
        Text(toolkit,
            style: TextStyle(
                fontFamily: 'monospace',
                color: color.withValues(alpha: 0.7),
                fontSize: 9)),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Platform dispatch
// ─────────────────────────────────────────────────────────────
Widget _buildPlatformDispatch() {
  final steps = <Map<String, dynamic>>[
    {'icon': Icons.touch_app, 'label': 'App calls showOpenDialog()', 'color': _dcIndigo},
    {'icon': Icons.device_hub, 'label': 'Base controller validates config', 'color': _dcMedIndigo},
    {'icon': Icons.send, 'label': 'Dispatches to platform implementation', 'color': _dcAccentCyan},
    {'icon': Icons.desktop_windows, 'label': 'Platform creates native dialog', 'color': _dcAccentGreen},
    {'icon': Icons.check_circle, 'label': 'User interacts, dialog closes', 'color': _dcAccentOrange},
    {'icon': Icons.arrow_back, 'label': 'Platform-neutral result returned', 'color': _dcAccentPurple},
  ];

  return Column(
    children: steps.asMap().entries.map((entry) {
      final s = entry.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 5),
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
              child: Icon(s['icon'] as IconData, color: _dcWhite, size: 14),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _dcIndigo.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${entry.key + 1}',
                    style: const TextStyle(
                        color: _dcIndigo,
                        fontSize: 9,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(s['label'] as String,
                  style: TextStyle(
                      color: s['color'] as Color,
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
// Section 7: Configuration options
// ─────────────────────────────────────────────────────────────
Widget _buildConfigOptions() {
  final opts = <Map<String, dynamic>>[
    {'opt': 'title', 'type': 'String', 'desc': 'Dialog window title text', 'color': _dcAccentCyan},
    {'opt': 'initialDirectory', 'type': 'String?', 'desc': 'Starting directory for file dialogs', 'color': _dcAccentGreen},
    {'opt': 'allowedExtensions', 'type': 'List<String>?', 'desc': 'File type filter (e.g., ["dart", "yaml"])', 'color': _dcAccentOrange},
    {'opt': 'allowMultiple', 'type': 'bool', 'desc': 'Allow selecting multiple files', 'color': _dcAccentAmber},
    {'opt': 'confirmButtonText', 'type': 'String?', 'desc': 'Custom text for confirm button', 'color': _dcAccentPurple},
    {'opt': 'parentWindow', 'type': 'Window?', 'desc': 'Parent window for modal attachment', 'color': _dcIndigo},
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dcLightIndigo),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          color: _dcIndigo,
          child: const Row(
            children: [
              Expanded(flex: 2, child: Text('Option', style: TextStyle(color: _dcWhite, fontSize: 10.5, fontWeight: FontWeight.w700))),
              Expanded(flex: 2, child: Text('Type', style: TextStyle(color: _dcWhite, fontSize: 10.5, fontWeight: FontWeight.w700))),
              Expanded(flex: 4, child: Text('Description', style: TextStyle(color: _dcWhite, fontSize: 10.5, fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        ...opts.asMap().entries.map((entry) {
          final o = entry.value;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            color: entry.key.isEven ? _dcPearl : _dcWhite,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(o['opt'] as String,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: o['color'] as Color,
                          fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(o['type'] as String,
                      style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _dcDarkText)),
                ),
                Expanded(
                  flex: 4,
                  child: Text(o['desc'] as String,
                      style: const TextStyle(
                          fontSize: 10, color: _dcDarkText)),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Lifecycle diagram
// ─────────────────────────────────────────────────────────────
Widget _buildLifecycleDiagram() {
  final phases = <Map<String, dynamic>>[
    {'phase': 'Idle', 'desc': 'Controller created, no dialog shown', 'color': _dcMedIndigo},
    {'phase': 'Configuring', 'desc': 'Setting title, filters, options', 'color': _dcAccentCyan},
    {'phase': 'Presenting', 'desc': 'Native dialog being displayed', 'color': _dcAccentGreen},
    {'phase': 'Active', 'desc': 'User interacting with dialog', 'color': _dcAccentOrange},
    {'phase': 'Collecting', 'desc': 'Gathering user selection/response', 'color': _dcAccentAmber},
    {'phase': 'Completing', 'desc': 'Returning result to Flutter', 'color': _dcAccentPurple},
    {'phase': 'Disposed', 'desc': 'Native resources released', 'color': _dcAccentRed},
  ];

  return Column(
    children: phases.asMap().entries.map((entry) {
      final p = entry.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 3),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: p['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${entry.key + 1}',
                        style: const TextStyle(
                            color: _dcWhite,
                            fontSize: 9,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                if (entry.key < phases.length - 1)
                  Container(width: 2, height: 6, color: _dcLightIndigo),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: (p['color'] as Color).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: p['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(p['phase'] as String,
                          style: const TextStyle(
                              color: _dcWhite,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(p['desc'] as String,
                          style: const TextStyle(
                              color: _dcDarkText, fontSize: 10)),
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
// Section 9: Delegate flow
// ─────────────────────────────────────────────────────────────
Widget _buildDelegateFlow() {
  final callbacks = <Map<String, dynamic>>[
    {'cb': 'dialogWillShow', 'when': 'Before dialog becomes visible', 'color': _dcAccentCyan},
    {'cb': 'dialogDidShow', 'when': 'After dialog is on screen', 'color': _dcAccentGreen},
    {'cb': 'dialogWillDismiss', 'when': 'Before dialog starts closing', 'color': _dcAccentOrange},
    {'cb': 'dialogDidDismiss', 'when': 'After dialog fully closed, with result', 'color': _dcAccentPurple},
  ];

  return Column(
    children: callbacks.map((c) {
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (c['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (c['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: c['color'] as Color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(c['cb'] as String,
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      color: _dcWhite,
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(c['when'] as String,
                  style: const TextStyle(
                      color: _dcDarkText, fontSize: 10.5)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Error scenarios
// ─────────────────────────────────────────────────────────────
Widget _buildErrorScenarios() {
  final errors = <Map<String, dynamic>>[
    {
      'error': 'Platform Not Supported',
      'desc': 'Dialog requested on unsupported platform (e.g., web)',
      'handling': 'Throws UnsupportedError with platform name',
      'color': _dcAccentRed,
    },
    {
      'error': 'No Parent Window',
      'desc': 'Modal dialog requested but no parent window available',
      'handling': 'Falls back to non-modal or throws StateError',
      'color': _dcAccentOrange,
    },
    {
      'error': 'Already Showing',
      'desc': 'Show called while another dialog is active',
      'handling': 'Queues the request or throws StateError',
      'color': _dcAccentAmber,
    },
    {
      'error': 'Disposed Controller',
      'desc': 'Show called after dispose()',
      'handling': 'Throws StateError: controller already disposed',
      'color': _dcAccentPurple,
    },
  ];

  return Column(
    children: errors.map((e) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (e['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (e['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber, size: 14, color: e['color'] as Color),
                const SizedBox(width: 6),
                Text(e['error'] as String,
                    style: TextStyle(
                        color: e['color'] as Color,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 4),
            Text(e['desc'] as String,
                style: const TextStyle(color: _dcDarkText, fontSize: 10.5)),
            const SizedBox(height: 2),
            Text(e['handling'] as String,
                style: TextStyle(
                    color: (e['color'] as Color).withValues(alpha: 0.8),
                    fontSize: 10,
                    fontStyle: FontStyle.italic)),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Cross-platform scenario
// ─────────────────────────────────────────────────────────────
Widget _buildCrossPlatformScenario() {
  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'Linux',
      'impl': 'DialogWindowControllerLinux',
      'native': 'GtkFileChooserDialog',
      'icon': Icons.computer,
      'color': _dcAccentGreen,
    },
    {
      'platform': 'macOS',
      'impl': 'DialogWindowControllerMacOS',
      'native': 'NSOpenPanel (sheet)',
      'icon': Icons.laptop_mac,
      'color': _dcAccentCyan,
    },
    {
      'platform': 'Windows',
      'impl': 'DialogWindowControllerWin32',
      'native': 'IFileOpenDialog (COM)',
      'icon': Icons.desktop_windows,
      'color': _dcAccentOrange,
    },
  ];

  return Column(
    children: [
      _dcCodeBlock(
        '// Same Flutter code on all platforms:\n'
        '//\n'
        '// final controller =\n'
        '//     DialogWindowController.create();\n'
        '//\n'
        '// final files = await controller.showOpenDialog(\n'
        '//   title: "Import Data",\n'
        '//   allowedExtensions: ["csv", "json"],\n'
        '//   allowMultiple: true,\n'
        '// );\n'
        '//\n'
        '// if (files != null) {\n'
        '//   for (final path in files) {\n'
        '//     await processFile(path);\n'
        '//   }\n'
        '// }\n'
        '//\n'
        '// controller.dispose();',
      ),
      _dcDivider(),
      _dcLabel('Platform-specific execution'),
      ...platforms.map((p) {
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (p['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: (p['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: p['color'] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(p['icon'] as IconData, color: _dcWhite, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['platform'] as String,
                        style: TextStyle(
                            color: p['color'] as Color,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    Text('${p['impl']}  →  ${p['native']}',
                        style: const TextStyle(
                            fontFamily: 'monospace',
                            color: _dcDarkText,
                            fontSize: 9.5)),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ],
  );
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _dcSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _dcWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _dcWhite.withValues(alpha: 0.95), fontSize: 12.5)),
        ),
      ],
    ),
  );
}
