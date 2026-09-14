// ignore_for_file: avoid_print
// Deep demo: BaseWindowController — abstract multi-window controller
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Deep Charcoal / Slate Silver
// ─────────────────────────────────────────────────────────────
const Color _bwCharcoal = Color(0xFF37474F);
const Color _bwSlateSilver = Color(0xFFECEFF1);
const Color _bwDarkCharcoal = Color(0xFF1B2328);
const Color _bwMedCharcoal = Color(0xFF546E7A);
const Color _bwLightSlate = Color(0xFFB0BEC5);
const Color _bwWhite = Color(0xFFFFFFFF);
const Color _bwGray = Color(0xFF78909C);
const Color _bwAccentBlue = Color(0xFF1565C0);
const Color _bwAccentGreen = Color(0xFF2E7D32);
const Color _bwAccentOrange = Color(0xFFE65100);
const Color _bwAccentPurple = Color(0xFF6A1B9A);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _bwSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bwWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _bwLightSlate, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x1A37474F), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _bwCharcoal,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _bwWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _bwLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _bwDarkCharcoal,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _bwBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _bwGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _bwCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF4F6F7),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _bwLightSlate.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _bwDarkCharcoal,
            height: 1.45)),
  );
}

Widget _bwChip(String text, Color bg, Color fg) {
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

Widget _bwDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _bwLightSlate.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: BaseWindowController');
  print('  Abstract base for multi-window management');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _bwSlateSilver,
      appBarTheme: const AppBarTheme(
        backgroundColor: _bwCharcoal,
        foregroundColor: _bwWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('BaseWindowController',
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
                  colors: [_bwDarkCharcoal, _bwCharcoal, _bwMedCharcoal],
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
                      color: _bwWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.window_rounded,
                        color: _bwWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('BaseWindowController',
                      style: TextStyle(
                          color: _bwWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Abstract base class for multi-window management',
                      style: TextStyle(
                          color: _bwWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _bwChip('Abstract', _bwWhite.withValues(alpha: 0.25), _bwWhite),
                      _bwChip('Controller', _bwWhite.withValues(alpha: 0.25), _bwWhite),
                      _bwChip('Multi-Window', _bwWhite.withValues(alpha: 0.25), _bwWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('1 · What Is BaseWindowController?', [
              _bwBody(
                'BaseWindowController is an abstract class that provides '
                'the foundational contract for managing windows in a '
                'multi-window Flutter application. It defines the lifecycle '
                'methods and state management required to create, manage, '
                'and destroy individual application windows.',
              ),
              _bwLabel('Class heritage'),
              _bwCodeBlock(
                'abstract class BaseWindowController {\n'
                '  // Window identity\n'
                '  int get windowId;\n'
                '  String get title;\n'
                '\n'
                '  // Lifecycle\n'
                '  Future<void> initialize();\n'
                '  Future<void> show();\n'
                '  Future<void> hide();\n'
                '  Future<void> close();\n'
                '  Future<void> destroy();\n'
                '\n'
                '  // State\n'
                '  WindowState get state;\n'
                '  Stream<WindowState> get stateChanges;\n'
                '}',
              ),
              _bwDivider(),
              _bwBody(
                'Concrete platform implementations extend this class to '
                'handle macOS NSWindow, Windows HWND, or Linux GTK '
                'window management through platform channels.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Abstract contract
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('2 · The Abstract Contract', [
              _bwBody(
                'BaseWindowController defines three categories of members '
                'that concrete implementations must provide.',
              ),
              _buildContractCategories(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Window lifecycle
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('3 · Window Lifecycle', [
              _bwBody(
                'Each window progresses through defined states. The '
                'controller ensures transitions happen in the correct order.',
              ),
              _buildLifecycleDiagram(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Controller-window relationship
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('4 · Controller-Window Relationship', [
              _bwBody(
                'Each controller manages exactly one native window. The '
                'application maintains a registry of controllers, one '
                'per window.',
              ),
              _buildRelationshipDiagram(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: State management
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('5 · State Management Pattern', [
              _bwBody(
                'The controller exposes window state as a stream, enabling '
                'reactive UI updates when window state changes.',
              ),
              _bwLabel('Window states'),
              _buildStateCards(),
              _bwDivider(),
              _bwLabel('State transition code'),
              _bwCodeBlock(
                'class MyWindowController extends BaseWindowController {\n'
                '  final _stateController =\n'
                '      StreamController<WindowState>.broadcast();\n'
                '\n'
                '  WindowState _state = WindowState.created;\n'
                '\n'
                '  @override\n'
                '  WindowState get state => _state;\n'
                '\n'
                '  @override\n'
                '  Stream<WindowState> get stateChanges =>\n'
                '      _stateController.stream;\n'
                '\n'
                '  void _transition(WindowState newState) {\n'
                '    _state = newState;\n'
                '    _stateController.add(newState);\n'
                '  }\n'
                '}',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Multi-window coordination
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('6 · Multi-Window Coordination', [
              _bwBody(
                'A WindowManager coordinates multiple BaseWindowController '
                'instances, handling spawning, focus tracking, and '
                'cross-window communication.',
              ),
              _buildCoordinationDiagram(),
              _bwDivider(),
              _bwLabel('Manager pattern'),
              _bwCodeBlock(
                'class WindowManager {\n'
                '  final Map<int, BaseWindowController> _windows = {};\n'
                '  int _nextId = 1;\n'
                '\n'
                '  Future<BaseWindowController> spawn({\n'
                '    required String title,\n'
                '    Rect? frame,\n'
                '  }) async {\n'
                '    final controller = PlatformWindowController(\n'
                '      windowId: _nextId++,\n'
                '      title: title,\n'
                '    );\n'
                '    await controller.initialize();\n'
                '    _windows[controller.windowId] = controller;\n'
                '    return controller;\n'
                '  }\n'
                '\n'
                '  List<BaseWindowController> get all =>\n'
                '      _windows.values.toList();\n'
                '}',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Platform differences
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('7 · Platform-Specific Implementations', [
              _bwBody(
                'Each desktop platform requires a different native '
                'implementation behind the abstract controller.',
              ),
              _buildPlatformTable(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Window spawn flow
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('8 · Window Spawn Flow', [
              _bwBody(
                'Creating a new window involves multiple coordinated steps '
                'between Dart and the native platform.',
              ),
              ..._buildSpawnFlowSteps(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Chat app scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('9 · Scenario: Multi-Window Chat App', [
              _bwBody(
                'A desktop chat application where each conversation opens '
                'in its own window, each managed by a BaseWindowController.',
              ),
              _buildChatAppDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: IDE scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('10 · Scenario: IDE with Multi-Window Support', [
              _bwBody(
                'An IDE where users can detach editor tabs into separate '
                'windows. Each detached tab becomes a window with its own '
                'controller.',
              ),
              _buildIdeWindowDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Disposal and cleanup
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('11 · Disposal and Cleanup', [
              _bwBody(
                'Proper disposal is critical for multi-window apps. The '
                'controller must clean up native resources, streams, and '
                'cross-window references.',
              ),
              _bwLabel('Cleanup sequence'),
              _bwCodeBlock(
                '@override\n'
                'Future<void> destroy() async {\n'
                '  // 1. Notify listeners of impending destruction\n'
                '  _transition(WindowState.destroying);\n'
                '\n'
                '  // 2. Close native window\n'
                '  await _platformChannel.invokeMethod(\n'
                '    \'destroyWindow\', windowId);\n'
                '\n'
                '  // 3. Clean up Dart-side resources\n'
                '  await _stateController.close();\n'
                '  _eventSubscription?.cancel();\n'
                '\n'
                '  // 4. Remove from manager registry\n'
                '  _manager._unregister(windowId);\n'
                '\n'
                '  // 5. Mark as destroyed\n'
                '  _state = WindowState.destroyed;\n'
                '}',
              ),
              _bwDivider(),
              _buildCleanupChecklist(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _bwSection('12 · Summary', [
              _bwBody(
                'BaseWindowController establishes the foundation for managed '
                'multi-window Flutter desktop applications.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_bwCharcoal, _bwMedCharcoal],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _bwSummaryRow(Icons.window, 'Abstract base for window management'),
                    _bwSummaryRow(Icons.account_tree, 'Defines lifecycle: create → show → hide → close → destroy'),
                    _bwSummaryRow(Icons.stream, 'Reactive state via Stream<WindowState>'),
                    _bwSummaryRow(Icons.devices, 'Platform-abstract — one API, per-OS implementations'),
                    _bwSummaryRow(Icons.hub, 'WindowManager coordinates multiple controllers'),
                    _bwSummaryRow(Icons.cleaning_services, 'Proper disposal prevents native resource leaks'),
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
// Section 2: Contract categories
// ─────────────────────────────────────────────────────────────
Widget _buildContractCategories() {
  final categories = <Map<String, dynamic>>[
    {
      'name': 'Identity',
      'color': _bwAccentBlue,
      'icon': Icons.badge,
      'members': ['int windowId', 'String title', 'Rect frame'],
    },
    {
      'name': 'Lifecycle',
      'color': _bwAccentGreen,
      'icon': Icons.loop,
      'members': ['initialize()', 'show()', 'hide()', 'close()', 'destroy()'],
    },
    {
      'name': 'State',
      'color': _bwAccentPurple,
      'icon': Icons.data_usage,
      'members': ['WindowState state', 'Stream stateChanges', 'bool isVisible'],
    },
  ];
  return Column(
    children: categories.map((c) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (c['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: (c['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: c['color'] as Color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(c['icon'] as IconData,
                      color: _bwWhite, size: 18),
                ),
                const SizedBox(width: 10),
                Text(c['name'] as String,
                    style: TextStyle(
                        color: c['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: (c['members'] as List<String>).map((m) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _bwWhite,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color:
                            (c['color'] as Color).withValues(alpha: 0.3)),
                  ),
                  child: Text(m,
                      style: TextStyle(
                          color: c['color'] as Color,
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600)),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Lifecycle diagram
// ─────────────────────────────────────────────────────────────
Widget _buildLifecycleDiagram() {
  final stages = <Map<String, dynamic>>[
    {'state': 'Created', 'action': 'new', 'color': _bwGray},
    {'state': 'Initialized', 'action': 'initialize()', 'color': _bwAccentBlue},
    {'state': 'Visible', 'action': 'show()', 'color': _bwAccentGreen},
    {'state': 'Hidden', 'action': 'hide()', 'color': _bwAccentOrange},
    {'state': 'Closing', 'action': 'close()', 'color': _bwAccentPurple},
    {'state': 'Destroyed', 'action': 'destroy()', 'color': _bwDarkCharcoal},
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _bwSlateSilver,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _bwLightSlate),
    ),
    child: Column(
      children: stages.asMap().entries.map((entry) {
        final s = entry.value;
        final isLast = entry.key == stages.length - 1;
        return Column(
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: s['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text('${entry.key + 1}',
                      style: const TextStyle(
                          color: _bwWhite,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s['state'] as String,
                          style: TextStyle(
                              color: s['color'] as Color,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                      Text(s['action'] as String,
                          style: const TextStyle(
                              color: _bwGray,
                              fontSize: 10.5,
                              fontFamily: 'monospace')),
                    ],
                  ),
                ),
              ],
            ),
            if (!isLast)
              Container(
                margin: const EdgeInsets.only(left: 17),
                height: 16,
                width: 2,
                color: _bwLightSlate,
              ),
          ],
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Relationship diagram
// ─────────────────────────────────────────────────────────────
Widget _buildRelationshipDiagram() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _bwSlateSilver,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _bwLightSlate),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _bwAccentBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _bwAccentBlue.withValues(alpha: 0.3)),
          ),
          child: const Column(
            children: [
              Text('WindowManager',
                  style: TextStyle(
                      color: _bwAccentBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
              Text('Coordinates all windows',
                  style: TextStyle(color: _bwGray, fontSize: 10)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(width: 2, height: 20, color: _bwLightSlate),
            Container(width: 2, height: 20, color: _bwLightSlate),
            Container(width: 2, height: 20, color: _bwLightSlate),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildWindowBox('Window 1', 'Main', _bwAccentGreen, true),
            const SizedBox(width: 6),
            _buildWindowBox('Window 2', 'Settings', _bwAccentOrange, false),
            const SizedBox(width: 6),
            _buildWindowBox('Window 3', 'Preview', _bwAccentPurple, false),
          ],
        ),
        const SizedBox(height: 10),
        _bwBody(
          '1 Controller ↔ 1 Native Window\n'
          'Each controller wraps exactly one platform window handle.\n'
          'The manager maintains the registry of all controllers.',
        ),
      ],
    ),
  );
}

Widget _buildWindowBox(String id, String title, Color color, bool isMain) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: color, width: isMain ? 2 : 1),
      ),
      child: Column(
        children: [
          Icon(Icons.desktop_windows, size: 18, color: color),
          const SizedBox(height: 4),
          Text(id,
              style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w700)),
          Text(title,
              style: TextStyle(
                  color: color.withValues(alpha: 0.8), fontSize: 9)),
          if (isMain)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Text('main',
                  style: TextStyle(
                      color: _bwWhite,
                      fontSize: 8,
                      fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: State cards
// ─────────────────────────────────────────────────────────────
Widget _buildStateCards() {
  final states = <Map<String, dynamic>>[
    {'name': 'created', 'desc': 'Controller instantiated, no native window yet', 'color': _bwGray},
    {'name': 'initialized', 'desc': 'Native window handle allocated', 'color': _bwAccentBlue},
    {'name': 'visible', 'desc': 'Window shown on screen', 'color': _bwAccentGreen},
    {'name': 'hidden', 'desc': 'Minimized or hidden', 'color': _bwAccentOrange},
    {'name': 'destroying', 'desc': 'Cleanup in progress', 'color': _bwAccentPurple},
    {'name': 'destroyed', 'desc': 'Native resources freed', 'color': _bwDarkCharcoal},
  ];
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: states.map((s) {
      return Container(
        width: 150,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (s['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: (s['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: s['color'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 4),
            Text(s['name'] as String,
                style: TextStyle(
                    color: s['color'] as Color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace')),
            Text(s['desc'] as String,
                style: const TextStyle(
                    color: _bwGray, fontSize: 9, height: 1.3)),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Coordination diagram
// ─────────────────────────────────────────────────────────────
Widget _buildCoordinationDiagram() {
  final features = <Map<String, dynamic>>[
    {'name': 'Spawn', 'desc': 'Create new window + controller', 'icon': Icons.add_circle, 'color': _bwAccentGreen},
    {'name': 'Focus', 'desc': 'Track which window is active', 'icon': Icons.center_focus_strong, 'color': _bwAccentBlue},
    {'name': 'Broadcast', 'desc': 'Send data across windows', 'icon': Icons.broadcast_on_personal, 'color': _bwAccentPurple},
    {'name': 'Close All', 'desc': 'Orderly shutdown of all windows', 'icon': Icons.close_fullscreen, 'color': _bwAccentOrange},
  ];
  return Row(
    children: features.map((f) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (f['color'] as Color).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: (f['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(f['icon'] as IconData,
                  size: 22, color: f['color'] as Color),
              const SizedBox(height: 4),
              Text(f['name'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: f['color'] as Color,
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
              Text(f['desc'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: _bwGray, fontSize: 8.5, height: 1.2)),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: Platform table
// ─────────────────────────────────────────────────────────────
Widget _buildPlatformTable() {
  final rows = <List<String>>[
    ['Platform', 'Native Handle', 'Channel Method'],
    ['macOS', 'NSWindow', 'FlutterMethodChannel'],
    ['Windows', 'HWND', 'MethodChannel (Win32)'],
    ['Linux', 'GtkWindow', 'MethodChannel (GTK)'],
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _bwLightSlate),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        final row = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: isHeader
              ? _bwCharcoal
              : entry.key.isEven
                  ? _bwSlateSilver
                  : _bwWhite,
          child: Row(
            children: row.asMap().entries.map((col) {
              return Expanded(
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _bwWhite : _bwGray,
                        fontSize: 11,
                        fontWeight:
                            isHeader ? FontWeight.w700 : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Spawn flow steps
// ─────────────────────────────────────────────────────────────
List<Widget> _buildSpawnFlowSteps() {
  final steps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'App requests new window',
      'detail': 'WindowManager.spawn(title: "Settings")',
      'color': _bwAccentBlue,
    },
    {
      'step': '2',
      'title': 'Controller created',
      'detail': 'PlatformWindowController(id: 2, title: "Settings")',
      'color': _bwAccentGreen,
    },
    {
      'step': '3',
      'title': 'Platform channel invoked',
      'detail': 'channel.invokeMethod("createWindow", {id, title, frame})',
      'color': _bwAccentOrange,
    },
    {
      'step': '4',
      'title': 'Native window allocated',
      'detail': 'OS creates NSWindow/HWND/GtkWindow with Flutter view',
      'color': _bwAccentPurple,
    },
    {
      'step': '5',
      'title': 'Widget tree attached',
      'detail': 'AppRouter provides content for the new window',
      'color': _bwCharcoal,
    },
    {
      'step': '6',
      'title': 'Window shown',
      'detail': 'controller.show() → state = visible',
      'color': _bwAccentBlue,
    },
  ];
  return steps.map((s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (s['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: (s['color'] as Color).withValues(alpha: 0.3)),
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
            alignment: Alignment.center,
            child: Text(s['step'] as String,
                style: const TextStyle(
                    color: _bwWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['title'] as String,
                    style: TextStyle(
                        color: s['color'] as Color,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
                Text(s['detail'] as String,
                    style: const TextStyle(
                        color: _bwGray,
                        fontSize: 10,
                        fontFamily: 'monospace')),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 9: Chat app demo
// ─────────────────────────────────────────────────────────────
Widget _buildChatAppDemo() {
  final windows = <Map<String, dynamic>>[
    {'id': 1, 'title': 'Chat — Main', 'contact': 'Contacts List', 'state': 'visible', 'isMain': true},
    {'id': 2, 'title': 'Chat — Alice', 'contact': 'Alice Chen', 'state': 'visible', 'isMain': false},
    {'id': 3, 'title': 'Chat — Team', 'contact': 'Team Channel', 'state': 'visible', 'isMain': false},
    {'id': 4, 'title': 'Chat — Bob', 'contact': 'Bob Rivera', 'state': 'hidden', 'isMain': false},
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _bwSlateSilver,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _bwLightSlate),
    ),
    child: Column(
      children: windows.map((w) {
        final isHidden = w['state'] == 'hidden';
        final isMain = w['isMain'] as bool;
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isHidden
                ? _bwGray.withValues(alpha: 0.08)
                : isMain
                    ? _bwAccentBlue.withValues(alpha: 0.08)
                    : _bwWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isHidden
                    ? _bwGray.withValues(alpha: 0.3)
                    : isMain
                        ? _bwAccentBlue
                        : _bwLightSlate,
                width: isMain ? 2 : 1),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isHidden
                      ? _bwGray.withValues(alpha: 0.2)
                      : _bwCharcoal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Icon(
                    isHidden ? Icons.visibility_off : Icons.chat_bubble,
                    size: 16,
                    color: isHidden ? _bwGray : _bwCharcoal),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(w['title'] as String,
                            style: TextStyle(
                                color: isHidden
                                    ? _bwGray
                                    : _bwDarkCharcoal,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        if (isMain) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: _bwAccentBlue,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Text('main',
                                style: TextStyle(
                                    color: _bwWhite,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ],
                    ),
                    Text('${w['contact']} · ${w['state']}',
                        style: TextStyle(
                            color: _bwGray.withValues(alpha: 0.7),
                            fontSize: 10)),
                  ],
                ),
              ),
              Text('id: ${w['id']}',
                  style: const TextStyle(
                      color: _bwGray,
                      fontSize: 9,
                      fontFamily: 'monospace')),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: IDE demo
// ─────────────────────────────────────────────────────────────
Widget _buildIdeWindowDemo() {
  final tabs = <Map<String, dynamic>>[
    {'file': 'main.dart', 'window': 'Main', 'detached': false, 'icon': Icons.code},
    {'file': 'settings.json', 'window': 'Window 2', 'detached': true, 'icon': Icons.settings},
    {'file': 'README.md', 'window': 'Window 3', 'detached': true, 'icon': Icons.description},
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _bwSlateSilver,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _bwLightSlate),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _bwDarkCharcoal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(Icons.code, size: 14, color: _bwLightSlate),
                  SizedBox(width: 6),
                  Text('FlutterIDE — Multi Window',
                      style: TextStyle(
                          color: _bwWhite,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: tabs.map((t) {
                  final isDetached = t['detached'] as bool;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDetached
                            ? _bwAccentOrange.withValues(alpha: 0.15)
                            : _bwCharcoal,
                        borderRadius: BorderRadius.circular(4),
                        border: isDetached
                            ? Border.all(
                                color: _bwAccentOrange.withValues(alpha: 0.4))
                            : null,
                      ),
                      child: Column(
                        children: [
                          Icon(t['icon'] as IconData,
                              size: 14,
                              color: isDetached
                                  ? _bwAccentOrange
                                  : _bwLightSlate),
                          const SizedBox(height: 2),
                          Text(t['file'] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: isDetached
                                      ? _bwAccentOrange
                                      : _bwWhite,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600)),
                          Text(isDetached ? '↗ ${t['window']}' : 'here',
                              style: TextStyle(
                                  color: isDetached
                                      ? _bwAccentOrange.withValues(alpha: 0.7)
                                      : _bwGray,
                                  fontSize: 8)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _bwBody(
          'Detached tabs each get a BaseWindowController instance. They '
          'can be dragged back to the main window, which triggers '
          'controller.close() and tab reattachment.',
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Cleanup checklist
// ─────────────────────────────────────────────────────────────
Widget _buildCleanupChecklist() {
  final items = <Map<String, dynamic>>[
    {'check': 'Close StreamControllers', 'icon': Icons.check_circle, 'color': _bwAccentGreen},
    {'check': 'Cancel event subscriptions', 'icon': Icons.check_circle, 'color': _bwAccentGreen},
    {'check': 'Release native window handle', 'icon': Icons.check_circle, 'color': _bwAccentGreen},
    {'check': 'Remove from WindowManager registry', 'icon': Icons.check_circle, 'color': _bwAccentGreen},
    {'check': 'Notify other windows of closure', 'icon': Icons.info, 'color': _bwAccentOrange},
    {'check': 'Persist window position for restore', 'icon': Icons.info, 'color': _bwAccentOrange},
  ];
  return Column(
    children: items.map((item) {
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _bwWhite,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: (item['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(item['icon'] as IconData,
                size: 16, color: item['color'] as Color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(item['check'] as String,
                  style: const TextStyle(
                      color: _bwDarkCharcoal,
                      fontSize: 11,
                      fontWeight: FontWeight.w500)),
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
Widget _bwSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _bwWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _bwWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}
