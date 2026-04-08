// ignore_for_file: avoid_print
// Deep demo: DialogWindowControllerWin32 — Win32-specific dialog controller using
// native Windows APIs, COM interfaces, and HWND-based window management for file
// dialogs, message boxes, and custom dialog templates on the Windows platform.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Burnished Copper (#BF360C) on Warm Cream (#FFF8E1)
// Prefix: _wn (win32)
// ────────────────────────────────────────────────────────────

const Color _wnCopper = Color(0xFFBF360C);
const Color _wnCream = Color(0xFFFFF8E1);
const Color _wnDarkCopper = Color(0xFF8C2700);
const Color _wnLightCopper = Color(0xFFE65100);
const Color _wnMuted = Color(0xFF795548);
const Color _wnAccent = Color(0xFFFF6D00);
const Color _wnSurface = Color(0xFFFFF3E0);
const Color _wnDivider = Color(0xFFD7CCC8);
const Color _wnWhite = Color(0xFFFFFFFF);
const Color _wnBlack = Color(0xFF212121);
const Color _wnError = Color(0xFFC62828);
const Color _wnSuccess = Color(0xFF2E7D32);
const Color _wnInfo = Color(0xFF1565C0);

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Banner ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_wnCopper, _wnDarkCopper],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _wnCopper.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.window, color: _wnCream, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DialogWindowControllerWin32',
                      style: TextStyle(
                        color: _wnCream,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Windows-native dialog controller using Win32 API, COM '
                'interfaces, and HWND window management for platform dialogs.',
                style: TextStyle(
                  color: _wnCream.withValues(alpha: 0.88),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _wnSection('1. What Is DialogWindowControllerWin32?'),
        _wnBody(
          'DialogWindowControllerWin32 is the Windows-specific concrete '
          'implementation of DialogWindowController. It uses Win32 API '
          'calls, COM (Component Object Model) interfaces, and HWND '
          '(window handle) management to present native Windows dialogs '
          'such as file open/save dialogs, message boxes, folder pickers, '
          'and custom dialog templates. This subclass translates the '
          'cross-platform DialogWindowController interface into direct '
          'calls to Windows system DLLs like user32.dll, comdlg32.dll, '
          'and shell32.dll.',
        ),
        const SizedBox(height: 12),
        _wnInfoBox(
          'Platform Binding',
          'This controller is only instantiated on Windows. The factory '
          'in DialogWindowController detects Platform.isWindows and '
          'returns a DialogWindowControllerWin32 instance.',
        ),
        const SizedBox(height: 24),

        // ── 2. Win32 API Architecture ──
        _wnSection('2. Win32 API Architecture'),
        _wnBody(
          'The Win32 dialog system is built around window handles (HWND), '
          'message loops, and callback procedures. DialogWindowControllerWin32 '
          'wraps these low-level primitives into a clean Dart interface:',
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _wnSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _wnDivider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _wnLabel('Win32 Dialog Stack'),
              const SizedBox(height: 10),
              _buildWin32StackDiagram(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// Simplified Win32 dialog invocation flow\n'
          'class DialogWindowControllerWin32\n'
          '    extends DialogWindowController {\n'
          '  // HWND of the parent Flutter window\n'
          '  late final int _parentHwnd;\n'
          '\n'
          '  // COM interface pointer for IFileDialog\n'
          '  late final Pointer<COMObject> _fileDialog;\n'
          '\n'
          '  @override\n'
          '  Future<DialogResult> showOpenDialog({\n'
          '    required List<FileFilter> filters,\n'
          '    String? initialDirectory,\n'
          '    bool allowMultiple = false,\n'
          '  }) async {\n'
          '    _initComIfNeeded();\n'
          '    final hr = CoCreateInstance(\n'
          '      CLSID_FileOpenDialog,\n'
          '      nullptr,\n'
          '      CLSCTX_ALL,\n'
          '      IID_IFileOpenDialog,\n'
          '      _fileDialog,\n'
          '    );\n'
          '    if (FAILED(hr)) throw Win32Exception(hr);\n'
          '    _applyFilters(filters);\n'
          '    _setInitialDir(initialDirectory);\n'
          '    if (allowMultiple) _setMultiSelect();\n'
          '    final result = _fileDialog.Show(_parentHwnd);\n'
          '    return _processResult(result);\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 3. COM Interface Integration ──
        _wnSection('3. COM Interface Integration'),
        _wnBody(
          'Modern Windows file dialogs use the COM-based IFileDialog '
          'family rather than the older GetOpenFileName function. '
          'DialogWindowControllerWin32 manages COM initialization, '
          'reference counting, and interface querying:',
        ),
        const SizedBox(height: 12),
        _buildComInterfaceTable(),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// COM lifecycle management\n'
          'void _initComIfNeeded() {\n'
          '  if (!_comInitialized) {\n'
          '    final hr = CoInitializeEx(\n'
          '      nullptr,\n'
          '      COINIT_APARTMENTTHREADED |\n'
          '          COINIT_DISABLE_OLE1DDE,\n'
          '    );\n'
          '    if (SUCCEEDED(hr) ||\n'
          '        hr == RPC_E_CHANGED_MODE) {\n'
          '      _comInitialized = true;\n'
          '    }\n'
          '  }\n'
          '}\n'
          '\n'
          'void _releaseCom() {\n'
          '  if (_comInitialized) {\n'
          '    _fileDialog.Release();\n'
          '    CoUninitialize();\n'
          '    _comInitialized = false;\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 4. HWND Management ──
        _wnSection('4. HWND Window Handle Management'),
        _wnBody(
          'Every Win32 dialog must be associated with a parent window '
          'handle (HWND). DialogWindowControllerWin32 obtains the Flutter '
          'window HWND through the Windows embedder and passes it to '
          'dialog creation functions so dialogs appear as modal children '
          'of the application window:',
        ),
        const SizedBox(height: 12),
        _buildHwndFlowDiagram(),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// Obtaining the Flutter window HWND\n'
          'int _getParentHwnd() {\n'
          '  // Use FindWindow with Flutter window class\n'
          '  final hwnd = FindWindow(\n'
          '    TEXT("FLUTTER_RUNNER_WIN32_WINDOW"),\n'
          '    nullptr,\n'
          '  );\n'
          '  if (hwnd == 0) {\n'
          '    // Fallback: enumerate top-level windows\n'
          '    hwnd = _findFlutterWindowByPid();\n'
          '  }\n'
          '  return hwnd;\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 5. File Dialog Filters ──
        _wnSection('5. File Dialog Filters'),
        _wnBody(
          'Win32 file dialogs accept filter specifications as '
          'COMDLG_FILTERSPEC structures. The controller translates '
          'cross-platform FileFilter objects into Win32-native filter '
          'arrays:',
        ),
        const SizedBox(height: 12),
        _buildFilterMappingTable(),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// Filter translation\n'
          'void _applyFilters(List<FileFilter> filters) {\n'
          '  final specs = calloc<COMDLG_FILTERSPEC>(\n'
          '    filters.length,\n'
          '  );\n'
          '  for (var i = 0; i < filters.length; i++) {\n'
          '    final f = filters[i];\n'
          '    specs[i].pszName = TEXT(f.label);\n'
          '    specs[i].pszSpec = TEXT(\n'
          '      f.extensions\n'
          '          .map((e) => "*.\$e")\n'
          '          .join(";"),\n'
          '    );\n'
          '  }\n'
          '  _fileDialog.SetFileTypes(\n'
          '    filters.length,\n'
          '    specs,\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 6. Message Box Integration ──
        _wnSection('6. MessageBox Integration'),
        _wnBody(
          'For simple alert and confirmation dialogs, the controller '
          'delegates to the Win32 MessageBox function which provides '
          'built-in button configurations and system icons:',
        ),
        const SizedBox(height: 12),
        _buildMessageBoxTypesGrid(),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// MessageBox wrapper\n'
          '@override\n'
          'Future<DialogResult> showMessageDialog({\n'
          '  required String title,\n'
          '  required String message,\n'
          '  MessageDialogType type =\n'
          '      MessageDialogType.info,\n'
          '}) async {\n'
          '  final flags = _mapTypeToFlags(type);\n'
          '  final result = MessageBox(\n'
          '    _parentHwnd,\n'
          '    TEXT(message),\n'
          '    TEXT(title),\n'
          '    flags,\n'
          '  );\n'
          '  return _mapMessageBoxResult(result);\n'
          '}\n'
          '\n'
          'int _mapTypeToFlags(MessageDialogType t) {\n'
          '  switch (t) {\n'
          '    case MessageDialogType.info:\n'
          '      return MB_OK | MB_ICONINFORMATION;\n'
          '    case MessageDialogType.warning:\n'
          '      return MB_OK | MB_ICONWARNING;\n'
          '    case MessageDialogType.error:\n'
          '      return MB_OK | MB_ICONERROR;\n'
          '    case MessageDialogType.question:\n'
          '      return MB_YESNO | MB_ICONQUESTION;\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 7. Folder Picker ──
        _wnSection('7. Folder Picker Dialog'),
        _wnBody(
          'The Win32 folder browser uses either the legacy SHBrowseForFolder '
          'function or the modern IFileDialog with FOS_PICKFOLDERS option. '
          'DialogWindowControllerWin32 prefers the modern approach but '
          'falls back to the legacy API on older Windows versions:',
        ),
        const SizedBox(height: 12),
        _buildFolderPickerComparison(),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// Modern folder picker\n'
          '@override\n'
          'Future<DialogResult> showFolderDialog({\n'
          '  String? initialDirectory,\n'
          '}) async {\n'
          '  _initComIfNeeded();\n'
          '  final hr = CoCreateInstance(\n'
          '    CLSID_FileOpenDialog,\n'
          '    nullptr,\n'
          '    CLSCTX_ALL,\n'
          '    IID_IFileOpenDialog,\n'
          '    _fileDialog,\n'
          '  );\n'
          '  if (FAILED(hr)) throw Win32Exception(hr);\n'
          '  // Add FOS_PICKFOLDERS option\n'
          '  var options = 0;\n'
          '  _fileDialog.GetOptions(options);\n'
          '  _fileDialog.SetOptions(\n'
          '    options | FOS_PICKFOLDERS,\n'
          '  );\n'
          '  _setInitialDir(initialDirectory);\n'
          '  final result = _fileDialog.Show(_parentHwnd);\n'
          '  return _processResult(result);\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 8. Dialog Result Mapping ──
        _wnSection('8. Dialog Result Mapping'),
        _wnBody(
          'Win32 dialog functions return HRESULT codes or integer button '
          'IDs that must be mapped back to the platform-independent '
          'DialogResult enum:',
        ),
        const SizedBox(height: 12),
        _buildResultMappingTable(),
        const SizedBox(height: 24),

        // ── 9. Error Handling ──
        _wnSection('9. Win32 Error Handling'),
        _wnBody(
          'Win32 API errors come as HRESULT codes. The controller '
          'translates these into meaningful Dart exceptions with '
          'context about which operation failed:',
        ),
        const SizedBox(height: 12),
        _buildErrorHandlingScenarios(),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// Win32 error translation\n'
          'Never _throwWin32Error(\n'
          '  int hr,\n'
          '  String operation,\n'
          ') {\n'
          '  final code = hr & 0xFFFF;\n'
          '  final facility = (hr >> 16) & 0x1FFF;\n'
          '  final message = _formatMessage(hr);\n'
          '  throw DialogPlatformException(\n'
          '    platform: "win32",\n'
          '    operation: operation,\n'
          '    code: hr,\n'
          '    message: "Win32 error "\n'
          '        "0x\${hr.toRadixString(16)}: "\n'
          '        "\$message "\n'
          '        "(facility: \$facility, "\n'
          '        "code: \$code)",\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 10. Thread Safety ──
        _wnSection('10. Thread Safety & COM Apartments'),
        _wnBody(
          'Win32 COM dialogs must run on a single-threaded apartment '
          '(STA) thread. Since Flutter\'s platform thread is already '
          'an STA, the controller operates directly on it. However, '
          'care must be taken when interacting with background isolates:',
        ),
        const SizedBox(height: 12),
        _buildThreadSafetyDiagram(),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// Ensuring STA execution\n'
          'Future<T> _runOnPlatformThread<T>(\n'
          '  Future<T> Function() work,\n'
          ') async {\n'
          '  // Verify we are on the platform thread\n'
          '  if (!_isPlatformThread()) {\n'
          '    // Schedule on platform channel\n'
          '    return _platformChannel\n'
          '        .invokeMethod<T>(\n'
          '      "runDialog",\n'
          '      null,\n'
          '    );\n'
          '  }\n'
          '  return work();\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 11. Resource Cleanup ──
        _wnSection('11. Resource Cleanup & Disposal'),
        _wnBody(
          'Win32 dialogs allocate native memory (calloc), COM objects '
          '(AddRef/Release), and window handles. The controller must '
          'release all resources even when exceptions occur:',
        ),
        const SizedBox(height: 12),
        _buildCleanupChecklist(),
        const SizedBox(height: 12),
        _wnCodeBlock(
          '// Dispose pattern\n'
          '@override\n'
          'void dispose() {\n'
          '  // Release COM object if held\n'
          '  if (_fileDialog != nullptr) {\n'
          '    _fileDialog.Release();\n'
          '    _fileDialog = nullptr;\n'
          '  }\n'
          '  // Free native string allocations\n'
          '  for (final ptr in _allocatedStrings) {\n'
          '    free(ptr);\n'
          '  }\n'
          '  _allocatedStrings.clear();\n'
          '  // Uninitialize COM\n'
          '  _releaseCom();\n'
          '  super.dispose();\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 12. Native File Picker Scenario ──
        _wnSection('12. Native File Picker Scenario'),
        _wnBody(
          'A complete walkthrough of opening a multi-select file picker '
          'with custom filters on Windows, showing each Win32 API call '
          'in sequence:',
        ),
        const SizedBox(height: 12),
        _buildNativeFilePickerScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _wnCopper.withValues(alpha: 0.08),
                _wnCream,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _wnCopper.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _wnCopper, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _wnCopper,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _wnSummaryRow(
                'Platform',
                'Windows only — Win32 API + COM interfaces',
              ),
              _wnSummaryRow(
                'Parent Class',
                'DialogWindowController (abstract)',
              ),
              _wnSummaryRow(
                'Dialog Types',
                'Open, Save, Folder, MessageBox, Custom',
              ),
              _wnSummaryRow(
                'COM Model',
                'IFileOpenDialog / IFileSaveDialog (STA)',
              ),
              _wnSummaryRow(
                'HWND Source',
                'Flutter embedder window handle',
              ),
              _wnSummaryRow(
                'Error Model',
                'HRESULT → DialogPlatformException',
              ),
              _wnSummaryRow(
                'Cleanup',
                'COM Release + native free + CoUninitialize',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _wnSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _wnCopper,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _wnLabel(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _wnDarkCopper,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    ),
  );
}

Widget _wnBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _wnBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _wnCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFE0E0E0),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _wnChip(String text, {Color? bg, Color? fg}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bg ?? _wnCopper.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg ?? _wnCopper,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}


Widget _wnInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wnInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wnInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _wnInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _wnInfo,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: _wnBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _wnSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: _wnMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _wnBlack,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── Builder Functions ───────────────────────────────────────

Widget _buildWin32StackDiagram() {
  final layers = <Map<String, dynamic>>[
    {
      'label': 'DialogWindowController (abstract)',
      'sub': 'Platform-independent interface',
      'color': _wnMuted,
    },
    {
      'label': 'DialogWindowControllerWin32',
      'sub': 'Win32-specific implementation',
      'color': _wnCopper,
    },
    {
      'label': 'dart:ffi + win32 package',
      'sub': 'Dart FFI bindings for Win32 APIs',
      'color': _wnLightCopper,
    },
    {
      'label': 'COM Interfaces',
      'sub': 'IFileOpenDialog, IFileSaveDialog, IFileDialogEvents',
      'color': _wnAccent,
    },
    {
      'label': 'Win32 System DLLs',
      'sub': 'user32.dll, comdlg32.dll, shell32.dll, ole32.dll',
      'color': _wnDarkCopper,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < layers.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: (layers[i]['color'] as Color).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (layers[i]['color'] as Color).withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                layers[i]['label'] as String,
                style: TextStyle(
                  color: layers[i]['color'] as Color,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                layers[i]['sub'] as String,
                style: TextStyle(
                  color: _wnMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        if (i < layers.length - 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Icon(Icons.arrow_downward,
                color: _wnDivider, size: 18),
          ),
      ],
    ],
  );
}

Widget _buildComInterfaceTable() {
  final interfaces = <List<String>>[
    ['IFileOpenDialog', 'Open file picker', 'Multi-select, filter'],
    ['IFileSaveDialog', 'Save file picker', 'Default name, overwrite'],
    ['IFileDialogEvents', 'Dialog callbacks', 'Selection change, folder change'],
    ['IShellItem', 'Result item', 'Path extraction, attributes'],
    ['IShellItemArray', 'Multi-result', 'Iteration, count'],
    ['IFileDialogCustomize', 'Custom controls', 'Buttons, combos, checkboxes'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wnDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _wnCopper.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('Interface', style: TextStyle(
                  color: _wnCopper, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Purpose', style: TextStyle(
                  color: _wnCopper, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Features', style: TextStyle(
                  color: _wnCopper, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in interfaces)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _wnDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(row[0], style: TextStyle(
                    color: _wnDarkCopper, fontSize: 12,
                    fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                ),
                Expanded(
                  flex: 3,
                  child: Text(row[1], style: TextStyle(
                    color: _wnBlack, fontSize: 12)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(row[2], style: TextStyle(
                    color: _wnMuted, fontSize: 12)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildHwndFlowDiagram() {
  final steps = <Map<String, String>>[
    {'icon': 'window', 'label': 'Flutter creates Win32 window'},
    {'icon': 'search', 'label': 'FindWindow("FLUTTER_RUNNER_WIN32_WINDOW")'},
    {'icon': 'pin', 'label': 'Store HWND as _parentHwnd'},
    {'icon': 'link', 'label': 'Pass _parentHwnd to dialog Show()'},
    {'icon': 'check', 'label': 'Dialog appears modal to Flutter window'},
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wnSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wnDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _wnCopper.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _wnCopper,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  steps[i]['label']!,
                  style: TextStyle(
                    color: _wnBlack,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          if (i < steps.length - 1) const SizedBox(height: 8),
        ],
      ],
    ),
  );
}

Widget _buildFilterMappingTable() {
  final filters = <List<String>>[
    ['Image files', 'png, jpg, gif', '*.png;*.jpg;*.gif'],
    ['Documents', 'pdf, docx, txt', '*.pdf;*.docx;*.txt'],
    ['Dart files', 'dart', '*.dart'],
    ['All files', '*', '*.*'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wnDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _wnCopper.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('FileFilter.label', style: TextStyle(
                  color: _wnCopper, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Extensions', style: TextStyle(
                  color: _wnCopper, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Win32 pszSpec', style: TextStyle(
                  color: _wnCopper, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in filters)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _wnDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(row[0], style: TextStyle(
                    color: _wnBlack, fontSize: 12)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(row[1], style: TextStyle(
                    color: _wnMuted, fontSize: 12, fontFamily: 'monospace')),
                ),
                Expanded(
                  flex: 3,
                  child: Text(row[2], style: TextStyle(
                    color: _wnDarkCopper, fontSize: 12, fontFamily: 'monospace')),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildMessageBoxTypesGrid() {
  final types = <Map<String, dynamic>>[
    {
      'type': 'MB_OK',
      'icon': Icons.info_outline,
      'desc': 'Simple information',
      'buttons': 'OK',
      'color': _wnInfo,
    },
    {
      'type': 'MB_OKCANCEL',
      'icon': Icons.help_outline,
      'desc': 'Confirm or cancel',
      'buttons': 'OK, Cancel',
      'color': _wnMuted,
    },
    {
      'type': 'MB_YESNO',
      'icon': Icons.question_mark,
      'desc': 'Yes/No decision',
      'buttons': 'Yes, No',
      'color': _wnCopper,
    },
    {
      'type': 'MB_YESNOCANCEL',
      'icon': Icons.quiz,
      'desc': 'Three-way choice',
      'buttons': 'Yes, No, Cancel',
      'color': _wnAccent,
    },
    {
      'type': 'MB_RETRYCANCEL',
      'icon': Icons.refresh,
      'desc': 'Retry operation',
      'buttons': 'Retry, Cancel',
      'color': _wnError,
    },
    {
      'type': 'MB_ABORTRETRYIGNORE',
      'icon': Icons.warning_amber,
      'desc': 'Error recovery',
      'buttons': 'Abort, Retry, Ignore',
      'color': _wnLightCopper,
    },
  ];

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (var t in types)
        Container(
          width: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (t['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (t['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(t['icon'] as IconData,
                      color: t['color'] as Color, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      t['type'] as String,
                      style: TextStyle(
                        color: t['color'] as Color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                t['desc'] as String,
                style: TextStyle(color: _wnBlack, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                t['buttons'] as String,
                style: TextStyle(color: _wnMuted, fontSize: 11),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildFolderPickerComparison() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _wnError.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _wnError.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.history, color: _wnError, size: 16),
                  const SizedBox(width: 6),
                  Text('Legacy', style: TextStyle(
                    color: _wnError, fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text('SHBrowseForFolder', style: TextStyle(
                color: _wnBlack, fontSize: 12, fontFamily: 'monospace')),
              const SizedBox(height: 4),
              Text(
                'Basic folder tree view. No path bar. '
                'Limited customization. Works on XP+.',
                style: TextStyle(color: _wnMuted, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _wnSuccess.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _wnSuccess.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: _wnSuccess, size: 16),
                  const SizedBox(width: 6),
                  Text('Modern', style: TextStyle(
                    color: _wnSuccess, fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text('IFileDialog + FOS', style: TextStyle(
                color: _wnBlack, fontSize: 12, fontFamily: 'monospace')),
              const SizedBox(height: 4),
              Text(
                'Full Explorer-style UI. Path bar, favorites, '
                'search. Custom controls. Vista+.',
                style: TextStyle(color: _wnMuted, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildResultMappingTable() {
  final mappings = <List<String>>[
    ['S_OK', '0x00000000', 'DialogResult.ok', 'User confirmed'],
    ['HRESULT_FROM_WIN32(ERROR_CANCELLED)', '0x800704C7', 'DialogResult.cancelled', 'User cancelled'],
    ['E_FAIL', '0x80004005', 'DialogPlatformException', 'General failure'],
    ['E_OUTOFMEMORY', '0x8007000E', 'DialogPlatformException', 'Out of memory'],
    ['IDYES', '6', 'DialogResult.yes', 'MessageBox Yes'],
    ['IDNO', '7', 'DialogResult.no', 'MessageBox No'],
    ['IDCANCEL', '2', 'DialogResult.cancelled', 'MessageBox Cancel'],
    ['IDRETRY', '4', 'DialogResult.retry', 'MessageBox Retry'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wnDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _wnCopper.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text('Win32 Constant', style: TextStyle(
                  color: _wnCopper, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text('Value', style: TextStyle(
                  color: _wnCopper, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 4,
                child: Text('Dart Mapping', style: TextStyle(
                  color: _wnCopper, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Meaning', style: TextStyle(
                  color: _wnCopper, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in mappings)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _wnDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(row[0], style: TextStyle(
                    color: _wnDarkCopper, fontSize: 11,
                    fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(row[1], style: TextStyle(
                    color: _wnMuted, fontSize: 11, fontFamily: 'monospace')),
                ),
                Expanded(
                  flex: 4,
                  child: Text(row[2], style: TextStyle(
                    color: _wnBlack, fontSize: 11)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(row[3], style: TextStyle(
                    color: _wnMuted, fontSize: 11)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildErrorHandlingScenarios() {
  final scenarios = <Map<String, dynamic>>[
    {
      'error': 'COM Initialization Failure',
      'code': 'RPC_E_CHANGED_MODE',
      'handling': 'Retry with compatible apartment model; '
          'fall back to legacy dialog API if COM unavailable.',
      'icon': Icons.settings,
      'color': _wnError,
    },
    {
      'error': 'HWND Not Found',
      'code': 'FindWindow returns 0',
      'handling': 'Enumerate top-level windows by process ID; '
          'use GetForegroundWindow as last resort.',
      'icon': Icons.desktop_windows,
      'color': _wnLightCopper,
    },
    {
      'error': 'Access Denied',
      'code': 'E_ACCESSDENIED (0x80070005)',
      'handling': 'Check folder permissions; inform user that '
          'the selected path requires elevation.',
      'icon': Icons.lock,
      'color': _wnAccent,
    },
    {
      'error': 'Memory Allocation Failure',
      'code': 'E_OUTOFMEMORY',
      'handling': 'Free cached allocations and retry once; '
          'throw with resource cleanup on second failure.',
      'icon': Icons.memory,
      'color': _wnDarkCopper,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < scenarios.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (scenarios[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (scenarios[i]['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(scenarios[i]['icon'] as IconData,
                      color: scenarios[i]['color'] as Color, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      scenarios[i]['error'] as String,
                      style: TextStyle(
                        color: scenarios[i]['color'] as Color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              _wnChip(scenarios[i]['code'] as String),
              const SizedBox(height: 8),
              Text(
                scenarios[i]['handling'] as String,
                style: TextStyle(
                  color: _wnBlack,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        if (i < scenarios.length - 1) const SizedBox(height: 8),
      ],
    ],
  );
}

Widget _buildThreadSafetyDiagram() {
  final zones = <Map<String, dynamic>>[
    {
      'label': 'UI Thread (STA)',
      'items': ['Flutter rendering', 'Platform channel handlers', 'COM dialog calls'],
      'color': _wnSuccess,
    },
    {
      'label': 'Background Isolate',
      'items': ['File processing', 'Data parsing', 'Cannot call COM'],
      'color': _wnError,
    },
    {
      'label': 'Platform Channel Bridge',
      'items': ['Marshals calls to UI thread', 'Returns results to isolate', 'Thread-safe boundary'],
      'color': _wnInfo,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < zones.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (zones[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (zones[i]['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                zones[i]['label'] as String,
                style: TextStyle(
                  color: zones[i]['color'] as Color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              for (var item in (zones[i]['items'] as List<String>))
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: zones[i]['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item,
                        style: TextStyle(
                          color: _wnBlack,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (i < zones.length - 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Icon(Icons.swap_vert, color: _wnDivider, size: 18),
          ),
      ],
    ],
  );
}

Widget _buildCleanupChecklist() {
  final items = <Map<String, dynamic>>[
    {
      'resource': 'COM Objects (IFileDialog, IShellItem)',
      'action': 'Call Release() to decrement reference count',
      'when': 'After dialog result processed',
      'icon': Icons.delete_outline,
    },
    {
      'resource': 'Native Strings (LPWSTR)',
      'action': 'Call free() on calloc-allocated pointers',
      'when': 'After SetFileTypes / SetFileName',
      'icon': Icons.text_fields,
    },
    {
      'resource': 'COMDLG_FILTERSPEC Array',
      'action': 'Free struct array and all member strings',
      'when': 'After filters applied to dialog',
      'icon': Icons.filter_list,
    },
    {
      'resource': 'COM Library',
      'action': 'Call CoUninitialize() to release apartment',
      'when': 'On controller dispose',
      'icon': Icons.power_settings_new,
    },
    {
      'resource': 'Event Handlers',
      'action': 'Unadvise and release IFileDialogEvents',
      'when': 'Before COM Release',
      'icon': Icons.notifications_off,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < items.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _wnSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wnDivider),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(items[i]['icon'] as IconData,
                  color: _wnCopper, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items[i]['resource'] as String,
                      style: TextStyle(
                        color: _wnDarkCopper,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      items[i]['action'] as String,
                      style: TextStyle(color: _wnBlack, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'When: ${items[i]['when']}',
                      style: TextStyle(
                        color: _wnMuted,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < items.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildNativeFilePickerScenario() {
  final steps = <Map<String, String>>[
    {
      'step': '1. Initialize COM',
      'detail': 'CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED)',
      'result': 'COM library ready for dialog creation',
    },
    {
      'step': '2. Create Dialog Object',
      'detail': 'CoCreateInstance(CLSID_FileOpenDialog, ...)',
      'result': 'IFileOpenDialog pointer obtained',
    },
    {
      'step': '3. Configure Options',
      'detail': 'SetOptions(FOS_ALLOWMULTISELECT | FOS_FILEMUSTEXIST)',
      'result': 'Multi-select enabled, must pick existing files',
    },
    {
      'step': '4. Set Filters',
      'detail': 'SetFileTypes(count, COMDLG_FILTERSPEC array)',
      'result': 'File type dropdown populated',
    },
    {
      'step': '5. Set Initial Folder',
      'detail': 'SHCreateItemFromParsingName → SetFolder',
      'result': 'Dialog opens in specified directory',
    },
    {
      'step': '6. Show Dialog',
      'detail': 'Show(_parentHwnd) — blocks until user closes',
      'result': 'S_OK if confirmed, ERROR_CANCELLED if dismissed',
    },
    {
      'step': '7. Get Results',
      'detail': 'GetResults → IShellItemArray → iterate items',
      'result': 'List of file paths extracted',
    },
    {
      'step': '8. Cleanup',
      'detail': 'Release COM objects, free native memory',
      'result': 'All resources reclaimed',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wnSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _wnDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.folder_open, color: _wnCopper, size: 20),
            const SizedBox(width: 8),
            Text(
              'Multi-Select File Picker Walkthrough',
              style: TextStyle(
                color: _wnCopper,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _wnCopper,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _wnWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step']!,
                      style: TextStyle(
                        color: _wnDarkCopper,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(
                        color: _wnBlack,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      steps[i]['result']!,
                      style: TextStyle(
                        color: _wnMuted,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 4, bottom: 4),
              child: Container(
                width: 2,
                height: 12,
                color: _wnDivider,
              ),
            ),
        ],
      ],
    ),
  );
}
