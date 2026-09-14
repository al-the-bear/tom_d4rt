// ignore_for_file: avoid_print
// Deep demo: DialogWindowControllerLinux — native dialog window management on Linux
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Warm Plum / Soft Lavender
// ─────────────────────────────────────────────────────────────
const Color _wlPlum = Color(0xFF4A148C);
const Color _wlLavender = Color(0xFFF3E5F5);
const Color _wlDarkPlum = Color(0xFF2C0050);
const Color _wlMedPlum = Color(0xFF7B1FA2);
const Color _wlLightPlum = Color(0xFFCE93D8);
const Color _wlWhite = Color(0xFFFFFFFF);
const Color _wlDarkText = Color(0xFF1A0033);
const Color _wlAccentCyan = Color(0xFF00838F);
const Color _wlAccentBlue = Color(0xFF1565C0);
const Color _wlAccentGreen = Color(0xFF2E7D32);
const Color _wlAccentOrange = Color(0xFFE65100);
const Color _wlAccentRed = Color(0xFFC62828);
const Color _wlAccentAmber = Color(0xFFF57F17);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _wlSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wlWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _wlLightPlum, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x154A148C), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _wlPlum,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _wlWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _wlLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _wlDarkPlum,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _wlBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _wlDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _wlCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF9F5FC),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _wlLightPlum.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _wlDarkPlum,
            height: 1.45)),
  );
}

Widget _wlChip(String text, Color bg, Color fg) {
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

Widget _wlDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _wlLightPlum.withValues(alpha: 0.4),
  );
}

Widget _wlInfoBox(String text, Color color) {
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
  print('  DEEP DEMO: DialogWindowControllerLinux');
  print('  Native dialog window management on Linux');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _wlLavender,
      appBarTheme: const AppBarTheme(
        backgroundColor: _wlPlum,
        foregroundColor: _wlWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DialogWindowControllerLinux',
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
                  colors: [_wlDarkPlum, _wlPlum, _wlMedPlum],
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
                      color: _wlWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.desktop_windows,
                        color: _wlWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('DialogWindowControllerLinux',
                      style: TextStyle(
                          color: _wlWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                      'Linux-specific dialog window control via GTK/GDK',
                      style: TextStyle(
                          color: _wlWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _wlChip('Linux', _wlWhite.withValues(alpha: 0.25), _wlWhite),
                      _wlChip('GTK', _wlWhite.withValues(alpha: 0.25), _wlWhite),
                      _wlChip('Dialogs', _wlWhite.withValues(alpha: 0.25), _wlWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('1 · What Is DialogWindowControllerLinux?', [
              _wlBody(
                'DialogWindowControllerLinux is a platform-specific controller '
                'that manages native dialog windows on Linux. It bridges '
                'Flutter to the underlying GTK/GDK windowing system for '
                'file pickers, message dialogs, and modal windows.',
              ),
              _wlLabel('Core responsibilities'),
              _buildResponsibilitiesList(),
              _wlDivider(),
              _wlInfoBox(
                'This controller is part of the Linux embedder layer — '
                'it is not used on other platforms.',
                _wlAccentCyan,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Platform architecture
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('2 · Platform Architecture on Linux', [
              _wlBody(
                'Flutter on Linux uses a layered architecture with GTK '
                'for windowing and GDK for display management.',
              ),
              _buildArchitectureStack(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Dialog types
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('3 · Dialog Types on Linux', [
              _wlBody(
                'Linux dialogs are managed by GTK and presented as native '
                'windows. The controller handles several dialog categories.',
              ),
              _buildDialogTypes(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Controller lifecycle
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('4 · Controller Lifecycle', [
              _wlBody(
                'The dialog controller goes through distinct lifecycle '
                'phases when showing and managing a dialog.',
              ),
              _buildLifecycleFlow(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: GTK integration
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('5 · GTK Integration', [
              _wlBody(
                'The controller interacts with GTK through platform channels '
                'and FFI bindings to manage native dialog windows.',
              ),
              _wlCodeBlock(
                '// Platform channel for Linux dialog control\n'
                'const channel = MethodChannel(\n'
                '    "flutter/dialog_controller_linux");\n'
                '\n'
                '// Show a file open dialog\n'
                'final result = await channel.invokeMethod(\n'
                '  "showOpenDialog",\n'
                '  {\n'
                '    "title": "Select a File",\n'
                '    "initialDirectory": "/home/user",\n'
                '    "allowedExtensions": ["dart", "yaml"],\n'
                '    "allowMultiple": false,\n'
                '  },\n'
                ');',
              ),
              _wlDivider(),
              _wlLabel('GTK dialog creation flow'),
              _wlCodeBlock(
                '// Native side (C/C++):\n'
                '// 1. gtk_file_chooser_dialog_new()\n'
                '// 2. gtk_file_chooser_set_current_folder()\n'
                '// 3. gtk_file_filter_add_pattern()\n'
                '// 4. gtk_dialog_run()\n'
                '// 5. gtk_widget_destroy()',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: File picker dialogs
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('6 · File Picker Dialogs', [
              _wlBody(
                'File pickers are the most common use of the dialog '
                'controller on Linux.',
              ),
              _buildFilePickerFlow(),
              _wlDivider(),
              _wlCodeBlock(
                '// File picker configurations\n'
                '//\n'
                '// Open file:\n'
                '//   GTK_FILE_CHOOSER_ACTION_OPEN\n'
                '//   → Returns selected file path\n'
                '//\n'
                '// Save file:\n'
                '//   GTK_FILE_CHOOSER_ACTION_SAVE\n'
                '//   → Returns chosen save path\n'
                '//\n'
                '// Open folder:\n'
                '//   GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER\n'
                '//   → Returns directory path\n'
                '//\n'
                '// Multiple files:\n'
                '//   gtk_file_chooser_set_select_multiple(TRUE)\n'
                '//   → Returns list of file paths',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Message dialog boxes
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('7 · Message Dialog Boxes', [
              _wlBody(
                'The controller also manages message dialog boxes for '
                'alerts, confirmations, and error messages.',
              ),
              _buildMessageDialogTypes(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Window positioning
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('8 · Window Positioning & Sizing', [
              _wlBody(
                'Dialog positioning on Linux involves working with the '
                'window manager and display geometry.',
              ),
              _buildPositioningDiagram(),
              _wlDivider(),
              _wlCodeBlock(
                '// Positioning strategies\n'
                '//\n'
                '// Center on parent:\n'
                '//   gtk_window_set_position(\n'
                '//     dialog, GTK_WIN_POS_CENTER_ON_PARENT)\n'
                '//\n'
                '// Center on screen:\n'
                '//   gtk_window_set_position(\n'
                '//     dialog, GTK_WIN_POS_CENTER)\n'
                '//\n'
                '// Explicit coordinates:\n'
                '//   gtk_window_move(dialog, x, y)\n'
                '//\n'
                '// Default size:\n'
                '//   gtk_window_set_default_size(\n'
                '//     dialog, width, height)',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Modality and focus
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('9 · Modality and Focus Management', [
              _wlBody(
                'Dialogs can be modal (blocking parent) or modeless '
                '(independent). The controller manages the modal stack.',
              ),
              _buildModalityDiagram(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Cross-platform differences
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('10 · Cross-Platform Dialog Differences', [
              _wlBody(
                'Linux dialog behavior differs from macOS and Windows:',
              ),
              _buildPlatformComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Practical scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('11 · Practical Scenario: File Import', [
              _wlBody(
                'A Flutter desktop app on Ubuntu needs to import a CSV '
                'file using a native file picker dialog.',
              ),
              _buildImportScenario(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _wlSection('12 · Summary', [
              _wlBody(
                'DialogWindowControllerLinux provides native dialog '
                'integration for Flutter apps running on Linux.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_wlPlum, _wlMedPlum],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _wlSummaryRow(Icons.desktop_windows, 'GTK-based native dialog windows'),
                    _wlSummaryRow(Icons.folder_open, 'File open, save, and folder selection'),
                    _wlSummaryRow(Icons.message, 'Alert, confirmation, and error dialogs'),
                    _wlSummaryRow(Icons.open_with, 'Window positioning and sizing'),
                    _wlSummaryRow(Icons.layers, 'Modal and modeless dialog support'),
                    _wlSummaryRow(Icons.devices, 'Linux-specific — macOS/Windows use different controllers'),
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
Widget _buildResponsibilitiesList() {
  final items = <Map<String, dynamic>>[
    {'icon': Icons.folder_open, 'text': 'File open/save dialog management', 'color': _wlAccentBlue},
    {'icon': Icons.message, 'text': 'Message dialog presentation', 'color': _wlAccentGreen},
    {'icon': Icons.open_with, 'text': 'Dialog window positioning', 'color': _wlAccentOrange},
    {'icon': Icons.layers, 'text': 'Modal stack handling', 'color': _wlAccentCyan},
    {'icon': Icons.cleaning_services, 'text': 'Resource cleanup on dismiss', 'color': _wlAccentRed},
    {'icon': Icons.input, 'text': 'Result passing back to Flutter', 'color': _wlAccentAmber},
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
// Section 2: Architecture stack
// ─────────────────────────────────────────────────────────────
Widget _buildArchitectureStack() {
  final layers = <Map<String, dynamic>>[
    {'name': 'Flutter Framework', 'desc': 'showDialog(), FilePicker, etc.', 'color': _wlAccentBlue},
    {'name': 'Platform Channels', 'desc': 'MethodChannel for dialog methods', 'color': _wlAccentCyan},
    {'name': 'Linux Embedder (C++)', 'desc': 'fl_dialog_window_controller.cc', 'color': _wlMedPlum},
    {'name': 'GTK3 / GTK4', 'desc': 'GtkDialog, GtkFileChooser, GtkMessageDialog', 'color': _wlAccentGreen},
    {'name': 'GDK / X11 / Wayland', 'desc': 'Display server for window management', 'color': _wlAccentOrange},
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
                            color: _wlWhite,
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
                              color: _wlDarkText, fontSize: 10)),
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
              color: _wlLightPlum,
            ),
        ],
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Dialog types
// ─────────────────────────────────────────────────────────────
Widget _buildDialogTypes() {
  final types = <Map<String, dynamic>>[
    {
      'type': 'File Open',
      'gtk': 'GtkFileChooserDialog',
      'action': 'GTK_FILE_CHOOSER_ACTION_OPEN',
      'icon': Icons.file_open,
      'color': _wlAccentBlue,
    },
    {
      'type': 'File Save',
      'gtk': 'GtkFileChooserDialog',
      'action': 'GTK_FILE_CHOOSER_ACTION_SAVE',
      'icon': Icons.save,
      'color': _wlAccentGreen,
    },
    {
      'type': 'Folder Select',
      'gtk': 'GtkFileChooserDialog',
      'action': 'GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER',
      'icon': Icons.folder_open,
      'color': _wlAccentOrange,
    },
    {
      'type': 'Alert Message',
      'gtk': 'GtkMessageDialog',
      'action': 'GTK_MESSAGE_WARNING',
      'icon': Icons.warning_amber,
      'color': _wlAccentAmber,
    },
    {
      'type': 'Error Message',
      'gtk': 'GtkMessageDialog',
      'action': 'GTK_MESSAGE_ERROR',
      'icon': Icons.error,
      'color': _wlAccentRed,
    },
    {
      'type': 'Confirmation',
      'gtk': 'GtkMessageDialog',
      'action': 'GTK_MESSAGE_QUESTION',
      'icon': Icons.help_outline,
      'color': _wlAccentCyan,
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
              child: Icon(t['icon'] as IconData, color: _wlWhite, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t['type'] as String,
                      style: TextStyle(
                          color: t['color'] as Color,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                  Text('${t['gtk']}  •  ${t['action']}',
                      style: const TextStyle(
                          fontFamily: 'monospace',
                          color: _wlDarkText,
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
// Section 4: Lifecycle flow
// ─────────────────────────────────────────────────────────────
Widget _buildLifecycleFlow() {
  final steps = <Map<String, dynamic>>[
    {'phase': 'Create', 'desc': 'Instantiate dialog controller with config', 'color': _wlAccentBlue},
    {'phase': 'Configure', 'desc': 'Set title, filters, initial directory', 'color': _wlAccentCyan},
    {'phase': 'Set Parent', 'desc': 'Attach to parent GtkWindow as transient', 'color': _wlAccentGreen},
    {'phase': 'Show', 'desc': 'Present dialog and enter modal loop', 'color': _wlAccentOrange},
    {'phase': 'Wait', 'desc': 'Block or async-wait for user response', 'color': _wlAccentAmber},
    {'phase': 'Collect', 'desc': 'Gather dialog result (path, button, etc.)', 'color': _wlMedPlum},
    {'phase': 'Destroy', 'desc': 'Close and free GTK widget resources', 'color': _wlAccentRed},
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
                            color: _wlWhite,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                if (entry.key < steps.length - 1)
                  Container(
                    width: 2,
                    height: 8,
                    color: _wlLightPlum,
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
                              color: _wlWhite,
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(s['desc'] as String,
                          style: const TextStyle(
                              color: _wlDarkText, fontSize: 10.5)),
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
// Section 6: File picker flow
// ─────────────────────────────────────────────────────────────
Widget _buildFilePickerFlow() {
  final steps = <Map<String, dynamic>>[
    {'icon': Icons.touch_app, 'label': 'User taps "Choose File"', 'color': _wlAccentBlue},
    {'icon': Icons.send, 'label': 'Flutter sends MethodChannel message', 'color': _wlAccentCyan},
    {'icon': Icons.settings, 'label': 'Controller creates GtkFileChooserDialog', 'color': _wlMedPlum},
    {'icon': Icons.filter_list, 'label': 'Applies file filters (*.dart, *.yaml)', 'color': _wlAccentGreen},
    {'icon': Icons.desktop_windows, 'label': 'Native dialog shown on screen', 'color': _wlAccentOrange},
    {'icon': Icons.check_circle, 'label': 'User selects file, dialog closes', 'color': _wlAccentAmber},
    {'icon': Icons.arrow_back, 'label': 'Path returned to Flutter via channel', 'color': _wlAccentRed},
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
              child: Icon(s['icon'] as IconData, color: _wlWhite, size: 14),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _wlPlum.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${entry.key + 1}',
                    style: const TextStyle(
                        color: _wlPlum,
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
// Section 7: Message dialog types
// ─────────────────────────────────────────────────────────────
Widget _buildMessageDialogTypes() {
  final dialogs = <Map<String, dynamic>>[
    {
      'type': 'Information',
      'icon': Icons.info,
      'buttons': 'OK',
      'color': _wlAccentBlue,
      'desc': 'Displays informational text with single acknowledge button',
    },
    {
      'type': 'Warning',
      'icon': Icons.warning_amber,
      'buttons': 'OK',
      'color': _wlAccentAmber,
      'desc': 'Alerts user to potentially dangerous operation',
    },
    {
      'type': 'Error',
      'icon': Icons.error,
      'buttons': 'OK',
      'color': _wlAccentRed,
      'desc': 'Reports a failure or error condition',
    },
    {
      'type': 'Question',
      'icon': Icons.help_outline,
      'buttons': 'Yes / No',
      'color': _wlAccentCyan,
      'desc': 'Asks user for a binary decision',
    },
    {
      'type': 'Confirmation',
      'icon': Icons.check_circle_outline,
      'buttons': 'OK / Cancel',
      'color': _wlAccentGreen,
      'desc': 'Confirms a destructive or irreversible action',
    },
  ];

  return Column(
    children: dialogs.map((d) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (d['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (d['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: d['color'] as Color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(d['icon'] as IconData, color: _wlWhite, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(d['type'] as String,
                          style: TextStyle(
                              color: d['color'] as Color,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      _wlChip(d['buttons'] as String,
                          (d['color'] as Color).withValues(alpha: 0.1),
                          d['color'] as Color),
                    ],
                  ),
                  Text(d['desc'] as String,
                      style: const TextStyle(
                          color: _wlDarkText, fontSize: 10)),
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
// Section 8: Positioning diagram
// ─────────────────────────────────────────────────────────────
Widget _buildPositioningDiagram() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _wlLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wlLightPlum),
    ),
    child: Column(
      children: [
        _wlLabel('Display Layout Example'),
        // Screen representation
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: _wlWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wlMedPlum, width: 2),
          ),
          child: Stack(
            children: [
              // Screen label
              const Positioned(
                top: 4,
                left: 8,
                child: Text('Screen 1920×1080',
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9,
                        color: _wlMedPlum)),
              ),
              // Parent window
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _wlAccentBlue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: _wlAccentBlue, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        color: _wlAccentBlue,
                        child: const Row(
                          children: [
                            Text('Flutter App',
                                style: TextStyle(
                                    color: _wlWhite,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Dialog centered on parent
                      Container(
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _wlMedPlum.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: _wlMedPlum, width: 1.5),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              color: _wlMedPlum,
                              child: const Row(
                                children: [
                                  Text('Open File',
                                      style: TextStyle(
                                          color: _wlWhite,
                                          fontSize: 7,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Text('Dialog (modal)',
                                style: TextStyle(
                                    color: _wlMedPlum,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600)),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: Modality diagram
// ─────────────────────────────────────────────────────────────
Widget _buildModalityDiagram() {
  final modes = <Map<String, dynamic>>[
    {
      'mode': 'Modal',
      'desc': 'Blocks interaction with parent window until dismissed',
      'behavior': 'Parent receives no events • Dialog stays on top • '
          'Close dialog to interact with parent',
      'color': _wlAccentRed,
    },
    {
      'mode': 'Modeless',
      'desc': 'Independent window, parent remains interactive',
      'behavior': 'Both windows receive events • Dialog can go behind parent • '
          'Parent can be focused',
      'color': _wlAccentGreen,
    },
    {
      'mode': 'System Modal',
      'desc': 'Blocks all application windows',
      'behavior': 'All app windows frozen • Requires window manager support • '
          'Used for critical errors',
      'color': _wlAccentAmber,
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: m['color'] as Color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(m['mode'] as String,
                      style: const TextStyle(
                          color: _wlWhite,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(m['desc'] as String,
                      style: const TextStyle(
                          color: _wlDarkText, fontSize: 10.5)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(m['behavior'] as String,
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
// Section 10: Platform comparison
// ─────────────────────────────────────────────────────────────
Widget _buildPlatformComparison() {
  final rows = <List<String>>[
    ['Aspect', 'Linux', 'macOS', 'Windows'],
    ['Toolkit', 'GTK3/GTK4', 'AppKit', 'Win32 API'],
    ['File Picker', 'GtkFileChooser', 'NSOpenPanel', 'IFileDialog'],
    ['Message Box', 'GtkMessageDialog', 'NSAlert', 'MessageBox'],
    ['Modal Stack', 'GTK managed', 'Sheet-based', 'HWND owned'],
    ['Theming', 'GTK theme', 'System', 'System'],
    ['Wayland', 'Supported', 'N/A', 'N/A'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _wlLightPlum),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        final isLinuxRow = entry.key > 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
          color: isHeader
              ? _wlPlum
              : entry.key.isEven
                  ? _wlLavender
                  : _wlWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              final isLinuxCol = col.key == 1 && isLinuxRow;
              return Expanded(
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader
                            ? _wlWhite
                            : isLinuxCol
                                ? _wlMedPlum
                                : _wlDarkText,
                        fontSize: 10,
                        fontWeight: isHeader || isLinuxCol
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
// Section 11: Import scenario
// ─────────────────────────────────────────────────────────────
Widget _buildImportScenario() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'User taps "Import CSV"',
      'code': 'onPressed: () => _importFile(context)',
      'color': _wlAccentBlue,
    },
    {
      'step': 'Controller creates file dialog',
      'code': 'gtk_file_chooser_dialog_new(\n'
          '  "Import CSV", parent,\n'
          '  GTK_FILE_CHOOSER_ACTION_OPEN,\n'
          '  "_Cancel", GTK_RESPONSE_CANCEL,\n'
          '  "_Open", GTK_RESPONSE_ACCEPT, NULL)',
      'color': _wlMedPlum,
    },
    {
      'step': 'Filter applied for CSV files',
      'code': 'GtkFileFilter *filter = gtk_file_filter_new();\n'
          'gtk_file_filter_set_name(filter, "CSV files");\n'
          'gtk_file_filter_add_pattern(filter, "*.csv");',
      'color': _wlAccentGreen,
    },
    {
      'step': 'Dialog shown, user selects file',
      'code': 'gint result = gtk_dialog_run(dialog);\n'
          'if (result == GTK_RESPONSE_ACCEPT) {\n'
          '  char *filename = gtk_file_chooser_get_filename(chooser);\n'
          '  // Pass back to Flutter\n'
          '}',
      'color': _wlAccentOrange,
    },
    {
      'step': 'Path returned to Flutter layer',
      'code': 'fl_method_response_new_success(\n'
          '  fl_value_new_string(filename))',
      'color': _wlAccentCyan,
    },
    {
      'step': 'Flutter processes the CSV file',
      'code': 'final path = await channel.showOpenDialog(...);\n'
          'if (path != null) {\n'
          '  final data = File(path).readAsStringSync();\n'
          '  _parseCSV(data);\n'
          '}',
      'color': _wlAccentAmber,
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
                              color: _wlWhite,
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
              color: _wlWhite,
              child: Text(s['code'] as String,
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: _wlDarkPlum,
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
Widget _wlSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _wlWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _wlWhite.withValues(alpha: 0.95), fontSize: 12.5)),
        ),
      ],
    ),
  );
}
