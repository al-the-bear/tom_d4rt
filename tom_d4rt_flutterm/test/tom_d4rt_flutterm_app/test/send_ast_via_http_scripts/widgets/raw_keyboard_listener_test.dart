// D4rt test script: Deep Visual Demo — RawKeyboardListener (deprecated → KeyboardListener)
// Demonstrates the deprecated RawKeyboardListener through styled code-text education,
// and provides a live KeyboardListener demo as the modern replacement.
// No RawKeyboardListener is instantiated; only shown as styled monospace text.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
// Top-level state — STATELESS widget approach via ValueNotifiers
// ============================================================

final ValueNotifier<List<String>> _keyLog = ValueNotifier<List<String>>([]);
final ValueNotifier<String> _lastKey = ValueNotifier<String>('(none yet)');
final ValueNotifier<int> _keyCount = ValueNotifier<int>(0);

// ============================================================
// Entry point
// ============================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
    ),
    home: const _RawKeyboardListenerDemoRoot(),
  );
}

// ============================================================
// Root scaffold with DefaultTabController (9 tabs)
// ============================================================

class _RawKeyboardListenerDemoRoot extends StatelessWidget {
  const _RawKeyboardListenerDemoRoot();

  static const List<Tab> _tabs = <Tab>[
    Tab(icon: Icon(Icons.warning_amber_rounded), text: 'Hero'),
    Tab(icon: Icon(Icons.keyboard), text: 'Live Demo'),
    Tab(icon: Icon(Icons.code), text: 'Legacy API'),
    Tab(icon: Icon(Icons.compare_arrows), text: 'Event Models'),
    Tab(icon: Icon(Icons.directions), text: 'Migration'),
    Tab(icon: Icon(Icons.vpn_key), text: 'Key Constants'),
    Tab(icon: Icon(Icons.devices), text: 'Platform Issues'),
    Tab(icon: Icon(Icons.account_tree), text: 'Pipeline'),
    Tab(icon: Icon(Icons.timeline), text: 'Timeline'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RawKeyboardListener — Deprecated & Replaced'),
          centerTitle: false,
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _LiveDemoTab(),
            _LegacyApiTab(),
            _EventModelsTab(),
            _MigrationGuideTab(),
            _KeyConstantsTab(),
            _PlatformIssuesTab(),
            _PipelineDiagramTab(),
            _DeprecationTimelineTab(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SECTION 1: Hero Banner
// ============================================================

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        // --- Deprecation banner ---
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[cs.errorContainer, cs.error.withValues(alpha: 0.15)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.error, width: 2),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.warning_amber_rounded, color: cs.error, size: 36),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'DEPRECATED',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: cs.error,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'RawKeyboardListener',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: cs.onErrorContainer,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This widget is deprecated and should not be used in new code. '
                'It was the original way to listen to raw keyboard input before '
                'Flutter unified its event pipeline across platforms. It relied on '
                'RawKeyboard and RawKeyEvent, which exposed platform-specific key '
                'codes that behaved differently on Android, iOS, and Desktop.',
                style: TextStyle(fontSize: 14, color: cs.onErrorContainer),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // --- What it was ---
        _SectionCard(
          title: 'What Was RawKeyboardListener?',
          icon: Icons.history_edu,
          children: <Widget>[
            const _BodyText(
              'RawKeyboardListener was a StatefulWidget that wrapped a child widget '
              'and notified a callback whenever a keyboard key was pressed or released. '
              'It required a FocusNode to receive focus and dispatched RawKeyEvent '
              'objects to its onKey callback.',
            ),
            const SizedBox(height: 12),
            _CodeBlock(
              code: '''// Typical RawKeyboardListener usage (LEGACY — do not copy):
RawKeyboardListener(
  focusNode: FocusNode(),
  autofocus: true,
  onKey: (RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      // event.logicalKey, event.physicalKey, event.data
      debugPrint(event.logicalKey.keyLabel);
    }
  },
  child: MyWidget(),
)''',
            ),
            const SizedBox(height: 12),
            const _BodyText(
              'The core problem: RawKeyEvent was backed by platform-specific data '
              '(RawKeyEventDataAndroid, RawKeyEventDataIos, RawKeyEventDataLinux, etc.). '
              'This made cross-platform key handling brittle and verbose.',
            ),
          ],
        ),
        const SizedBox(height: 20),
        // --- Why it was replaced ---
        _SectionCard(
          title: 'Why Was It Replaced?',
          icon: Icons.swap_horiz,
          children: <Widget>[
            _ReasonRow(
              icon: Icons.bug_report,
              color: cs.error,
              title: 'Platform fragmentation',
              body: 'Android, iOS, macOS, Windows, Linux all returned different key codes '
                  'for the same physical key. Developers had to write platform-specific branches.',
            ),
            const SizedBox(height: 10),
            _ReasonRow(
              icon: Icons.layers_clear,
              color: cs.tertiary,
              title: 'Two parallel systems',
              body: 'RawKeyboard existed alongside the newer HardwareKeyboard API, '
                  'creating confusion about which to use and causing event duplication.',
            ),
            const SizedBox(height: 10),
            _ReasonRow(
              icon: Icons.verified,
              color: cs.primary,
              title: 'Modern replacement: KeyboardListener',
              body: 'KeyboardListener uses KeyEvent (from HardwareKeyboard), which provides '
                  'consistent logical keys across all platforms with no platform-specific branches needed.',
            ),
          ],
        ),
        const SizedBox(height: 20),
        // --- Quick migration summary ---
        _SectionCard(
          title: 'Quick Migration Summary',
          icon: Icons.rocket_launch,
          children: <Widget>[
            Table(
              border: TableBorder.all(color: cs.outlineVariant, borderRadius: BorderRadius.circular(8)),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(color: cs.surfaceContainerHighest),
                  children: <Widget>[
                    _TableCell(text: 'Old (Deprecated)', isHeader: true),
                    _TableCell(text: 'New (Modern)', isHeader: true),
                  ],
                ),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'RawKeyboardListener'),
                  _TableCell(text: 'KeyboardListener'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'RawKeyEvent / RawKeyDownEvent'),
                  _TableCell(text: 'KeyEvent / KeyDownEvent'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'RawKeyboard.instance'),
                  _TableCell(text: 'HardwareKeyboard.instance'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'event.data (platform-specific)'),
                  _TableCell(text: 'event.logicalKey (unified)'),
                ]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// SECTION 2: Live Demo — KeyboardListener (modern replacement)
// ============================================================

class _LiveDemoTab extends StatelessWidget {
  const _LiveDemoTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Live KeyboardListener Demo',
          icon: Icons.keyboard,
          children: <Widget>[
            Text(
              'This is the modern replacement for RawKeyboardListener. '
              'Click inside the box below, then press any key. '
              'KeyEvent objects are displayed in the log.',
              style: TextStyle(color: cs.onSurface),
            ),
            const SizedBox(height: 16),
            const _KeyboardListenerWidget(),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'How This Demo Works',
          icon: Icons.info_outline,
          children: <Widget>[
            const _BodyText(
              'The live demo above uses KeyboardListener (the modern API). '
              'It wraps a focusable Container. When the container has focus '
              'and a key is pressed, onKeyEvent fires with a KeyEvent. '
              'The event is stored in a top-level ValueNotifier<List<String>> '
              'and displayed via ValueListenableBuilder — all stateless.',
            ),
            const SizedBox(height: 12),
            _CodeBlock(
              code: '''// Modern KeyboardListener usage:
final ValueNotifier<List<String>> _log = ValueNotifier([]);

KeyboardListener(
  focusNode: FocusNode(),
  autofocus: true,
  onKeyEvent: (KeyEvent event) {
    if (event is KeyDownEvent) {
      _log.value = [
        ...?_log.value,
        event.logicalKey.keyLabel,
      ];
    }
  },
  child: MyWidget(),
)''',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'KeyEvent Anatomy',
          icon: Icons.account_tree,
          children: <Widget>[
            _PropRow(label: 'logicalKey', value: 'LogicalKeyboardKey — unified key identity across platforms'),
            _PropRow(label: 'physicalKey', value: 'PhysicalKeyboardKey — hardware scancode (layout-independent)'),
            _PropRow(label: 'character', value: 'String? — printable character (null for non-printable keys)'),
            _PropRow(label: 'timeStamp', value: 'Duration — time since boot when event was generated'),
            _PropRow(label: 'synthesized', value: 'bool — true if generated programmatically (not real hardware)'),
          ],
        ),
      ],
    );
  }
}

// The actual KeyboardListener widget (stateless via ValueNotifier)
class _KeyboardListenerWidget extends StatelessWidget {
  const _KeyboardListenerWidget();

  void _handleKeyEvent(KeyEvent event) {
    final type = switch (event) {
      KeyDownEvent() => 'DOWN',
      KeyUpEvent() => 'UP',
      KeyRepeatEvent() => 'REPEAT',
      _ => 'UNKNOWN',
    };
    final label = event.logicalKey.keyLabel.isEmpty ? '(no label)' : event.logicalKey.keyLabel;
    final char = event.character != null ? ' char="${event.character}"' : '';
    final entry = '[$type] $label$char';
    final current = List<String>.from(_keyLog.value);
    current.insert(0, entry);
    if (current.length > 20) current.removeRange(20, current.length);
    _keyLog.value = current;
    _lastKey.value = label;
    _keyCount.value = _keyCount.value + 1;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Stats row
        ValueListenableBuilder<int>(
          valueListenable: _keyCount,
          builder: (ctx1, count, w1) {
            return ValueListenableBuilder<String>(
              valueListenable: _lastKey,
              builder: (ctx2, last, w2) {
                return Row(
                  children: <Widget>[
                    _StatChip(label: 'Keys pressed', value: '$count', color: cs.primary),
                    const SizedBox(width: 8),
                    _StatChip(label: 'Last key', value: last, color: cs.tertiary),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(height: 12),
        // Focusable KeyboardListener target
        KeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKeyEvent: _handleKeyEvent,
          child: Builder(
            builder: (ctx) {
              final hasFocus = Focus.of(ctx).hasFocus;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 80,
                decoration: BoxDecoration(
                  color: hasFocus ? cs.primaryContainer : cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasFocus ? cs.primary : cs.outlineVariant,
                    width: hasFocus ? 2 : 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  hasFocus ? 'Focused — press any key' : 'Click here to focus',
                  style: TextStyle(
                    color: hasFocus ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Key log
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: cs.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: ValueListenableBuilder<List<String>>(
            valueListenable: _keyLog,
            builder: (ctx3, log, w3) {
              if (log.isEmpty) {
                return Center(
                  child: Text(
                    'No key events yet. Focus the box above and press a key.',
                    style: TextStyle(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: log.length,
                separatorBuilder: (ctx4, i2) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final entry = log[i];
                  Color entryColor = cs.onSurface;
                  if (entry.startsWith('[DOWN]')) entryColor = cs.primary;
                  if (entry.startsWith('[UP]')) entryColor = cs.secondary;
                  if (entry.startsWith('[REPEAT]')) entryColor = cs.tertiary;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                    child: Text(
                      entry,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: entryColor,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            icon: const Icon(Icons.clear_all),
            label: const Text('Clear log'),
            onPressed: () {
              _keyLog.value = [];
              _lastKey.value = '(none yet)';
              _keyCount.value = 0;
            },
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SECTION 3: Legacy API Code Display
// ============================================================

class _LegacyApiTab extends StatelessWidget {
  const _LegacyApiTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.errorContainer,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.error),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline, color: cs.error),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'All code on this tab is shown as educational text only. '
                  'RawKeyboardListener is NOT instantiated anywhere in this file.',
                  style: TextStyle(color: cs.onErrorContainer, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'RawKeyboardListener Constructor (Annotated)',
          icon: Icons.construction,
          children: <Widget>[
            const _BodyText('Each parameter of the deprecated constructor, explained:'),
            const SizedBox(height: 12),
            _CodeBlock(
              code: '''RawKeyboardListener(
  // [REQUIRED] FocusNode to receive keyboard focus.
  // The listener only fires when this node holds focus.
  focusNode: myFocusNode,

  // [optional] If true, steals focus on mount.
  // Equivalent to Focus widget's autofocus.
  autofocus: false,

  // [optional] Whether to include semantics for
  // accessibility. Defaults to true.
  includeSemantics: true,

  // [optional] Callback fired on EVERY key event
  // (down and up). The event is a RawKeyEvent.
  onKey: (RawKeyEvent event) {
    if (event is RawKeyDownEvent) { ... }
    if (event is RawKeyUpEvent)   { ... }
    // No RawKeyRepeatEvent — not in the original API.
  },

  // [REQUIRED] Child widget. Receives focus implicitly
  // via the FocusNode above.
  child: Container(),
)''',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'RawKeyEvent Hierarchy (Legacy)',
          icon: Icons.account_tree,
          children: <Widget>[
            const _BodyText(
              'RawKeyEvent was the base class. Two concrete subtypes existed:',
            ),
            const SizedBox(height: 8),
            _CodeBlock(
              code: '''abstract class RawKeyEvent {
  final RawKeyEventData data;     // platform-specific
  final LogicalKeyboardKey logicalKey;
  final PhysicalKeyboardKey physicalKey;
  final String? character;
  final bool repeat;
  bool isKeyPressed(LogicalKeyboardKey key);
}

class RawKeyDownEvent extends RawKeyEvent { ... }
class RawKeyUpEvent   extends RawKeyEvent { ... }
// No RawKeyRepeatEvent existed — repeat was a bool on RawKeyDownEvent''',
            ),
            const SizedBox(height: 12),
            const _BodyText(
              'The RawKeyEventData field was the main problem: each platform '
              'provided a different subclass with platform-specific raw key codes.',
            ),
            const SizedBox(height: 8),
            _CodeBlock(
              code: '''// Platform-specific data classes (all deprecated now):
RawKeyEventDataAndroid   // scanCode, keyCode, metaState
RawKeyEventDataIos       // keyCode, modifiers, characters
RawKeyEventDataLinux     // keyCode, unicodeScalarValues
RawKeyEventDataMacOs     // keyCode, modifiers, characters
RawKeyEventDataWindows   // keyCode, scanCode, modifiers
RawKeyEventDataWeb       // code, key, metaState''',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Common RawKeyboardListener Patterns (Legacy)',
          icon: Icons.pattern,
          children: <Widget>[
            const _BodyText('Pattern 1: Shortcut detection'),
            _CodeBlock(
              code: '''onKey: (RawKeyEvent e) {
  if (e is RawKeyDownEvent &&
      e.isControlPressed &&
      e.logicalKey == LogicalKeyboardKey.keyS) {
    saveDocument();
  }
},''',
            ),
            const SizedBox(height: 12),
            const _BodyText('Pattern 2: Arrow key navigation'),
            _CodeBlock(
              code: '''onKey: (RawKeyEvent e) {
  if (e is! RawKeyDownEvent) return;
  switch (e.logicalKey) {
    case LogicalKeyboardKey.arrowUp:    move(0, -1); break;
    case LogicalKeyboardKey.arrowDown:  move(0,  1); break;
    case LogicalKeyboardKey.arrowLeft:  move(-1, 0); break;
    case LogicalKeyboardKey.arrowRight: move( 1, 0); break;
  }
},''',
            ),
            const SizedBox(height: 12),
            const _BodyText('Pattern 3: Game loop (multiple keys held)'),
            _CodeBlock(
              code: '''// RawKeyboard.instance.keysPressed returned Set<LogicalKeyboardKey>
// This was available even outside the listener callback.
final pressed = RawKeyboard.instance.keysPressed;
if (pressed.contains(LogicalKeyboardKey.space)) jump();
if (pressed.contains(LogicalKeyboardKey.shiftLeft)) sprint();''',
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// SECTION 4: RawKeyEvent vs KeyEvent comparison
// ============================================================

class _EventModelsTab extends StatelessWidget {
  const _EventModelsTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'RawKeyEvent vs KeyEvent — Side-by-Side',
          icon: Icons.compare_arrows,
          children: <Widget>[
            Table(
              border: TableBorder.all(color: cs.outlineVariant, borderRadius: BorderRadius.circular(8)),
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
              },
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(color: cs.surfaceContainerHighest),
                  children: const <Widget>[
                    _TableCell(text: 'Property', isHeader: true),
                    _TableCell(text: 'RawKeyEvent (Legacy)', isHeader: true),
                    _TableCell(text: 'KeyEvent (Modern)', isHeader: true),
                  ],
                ),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Package', isHeader: true),
                  _TableCell(text: 'flutter/services.dart'),
                  _TableCell(text: 'flutter/services.dart'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Platform data'),
                  _TableCell(text: 'Platform-specific subclass (RawKeyEventDataAndroid, etc.)'),
                  _TableCell(text: 'Unified — no platform branch needed'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Subtypes'),
                  _TableCell(text: 'RawKeyDownEvent, RawKeyUpEvent'),
                  _TableCell(text: 'KeyDownEvent, KeyUpEvent, KeyRepeatEvent'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Repeat events'),
                  _TableCell(text: 'bool repeat on RawKeyDownEvent'),
                  _TableCell(text: 'Dedicated KeyRepeatEvent subclass'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'logicalKey'),
                  _TableCell(text: 'Present but inconsistent on some platforms'),
                  _TableCell(text: 'Fully consistent across all platforms'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'physicalKey'),
                  _TableCell(text: 'Present'),
                  _TableCell(text: 'Present'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'character'),
                  _TableCell(text: 'String? (may be null or incorrect on some platforms)'),
                  _TableCell(text: 'String? (reliable)'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'synthesized'),
                  _TableCell(text: 'Not always accurate'),
                  _TableCell(text: 'bool — accurate'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Global state'),
                  _TableCell(text: 'RawKeyboard.instance.keysPressed'),
                  _TableCell(text: 'HardwareKeyboard.instance.logicalKeysPressed'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Modifiers'),
                  _TableCell(text: 'isControlPressed, isShiftPressed etc. (from RawKeyEventData)'),
                  _TableCell(text: 'HardwareKeyboard.instance.isControlPressed etc.'),
                ]),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Why KeyEvent Is Superior',
          icon: Icons.thumb_up,
          children: <Widget>[
            _ReasonRow(
              icon: Icons.check_circle,
              color: Colors.green,
              title: '1. No platform branches',
              body: 'RawKeyEvent required checking event.data.runtimeType to get platform-specific '
                  'data. KeyEvent eliminates this entirely. One code path handles all platforms.',
            ),
            const SizedBox(height: 10),
            _ReasonRow(
              icon: Icons.check_circle,
              color: Colors.green,
              title: '2. Repeat events are first-class',
              body: 'RawKeyDownEvent had a bool repeat property which was easy to miss. '
                  'KeyRepeatEvent is its own subtype — pattern matching handles it cleanly.',
            ),
            const SizedBox(height: 10),
            _ReasonRow(
              icon: Icons.check_circle,
              color: Colors.green,
              title: '3. Consistent logicalKey',
              body: 'On some older platforms, RawKeyEvent.logicalKey returned incorrect values. '
                  'KeyEvent.logicalKey is normalized by the engine before delivery.',
            ),
            const SizedBox(height: 10),
            _ReasonRow(
              icon: Icons.check_circle,
              color: Colors.green,
              title: '4. Better global state',
              body: 'HardwareKeyboard.instance.logicalKeysPressed is accurate and updated '
                  'in sync with KeyEvents. RawKeyboard.instance.keysPressed had edge cases '
                  'where it desynchronized from actual hardware state.',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'KeyEvent Pattern Matching (Modern Dart)',
          icon: Icons.code,
          children: <Widget>[
            _CodeBlock(
              code: '''// Idiomatic modern key handling:
onKeyEvent: (KeyEvent event) {
  switch (event) {
    case KeyDownEvent(:final logicalKey):
      handleDown(logicalKey);
    case KeyUpEvent(:final logicalKey):
      handleUp(logicalKey);
    case KeyRepeatEvent(:final logicalKey):
      handleRepeat(logicalKey);
  }
},''',
            ),
            const SizedBox(height: 12),
            _CodeBlock(
              code: '''// Checking held modifiers anywhere in code:
final kb = HardwareKeyboard.instance;
if (kb.isControlPressed && kb.isShiftPressed) {
  // Ctrl+Shift combo active
}''',
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// SECTION 5: Migration Guide
// ============================================================

class _MigrationGuideTab extends StatelessWidget {
  const _MigrationGuideTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Step-by-Step Migration Guide',
          icon: Icons.directions,
          children: <Widget>[
            const _BodyText(
              'Migrating from RawKeyboardListener to KeyboardListener involves '
              'three targeted changes. The widget structure stays identical.',
            ),
            const SizedBox(height: 20),
            _MigrationStep(
              step: 1,
              title: 'Change 1 — Widget name',
              before: 'RawKeyboardListener(\n  focusNode: _focusNode,\n  autofocus: true,\n  onKey: _onKey,\n  child: ...,\n)',
              after: 'KeyboardListener(\n  focusNode: _focusNode,\n  autofocus: true,\n  onKeyEvent: _onKeyEvent,\n  child: ...,\n)',
              note: 'The parameter name changes from onKey to onKeyEvent.',
            ),
            const SizedBox(height: 16),
            _MigrationStep(
              step: 2,
              title: 'Change 2 — Callback signature',
              before: 'void _onKey(RawKeyEvent event) {\n  if (event is RawKeyDownEvent) {\n    // handle\n  }\n}',
              after: 'void _onKeyEvent(KeyEvent event) {\n  if (event is KeyDownEvent) {\n    // handle\n  }\n}',
              note: 'RawKeyEvent → KeyEvent. RawKeyDownEvent → KeyDownEvent. '
                  'Consider handling KeyRepeatEvent separately if you previously used event.repeat.',
            ),
            const SizedBox(height: 16),
            _MigrationStep(
              step: 3,
              title: 'Change 3 — Platform-specific data access',
              before: '// OLD: platform branch\nif (event.data is RawKeyEventDataAndroid) {\n  final d = event.data as RawKeyEventDataAndroid;\n  final scanCode = d.scanCode;\n}',
              after: '// NEW: unified — no branching needed\nfinal logicalKey = event.logicalKey;\nfinal physicalKey = event.physicalKey;\n// HardwareKeyboard.instance for global state',
              note: 'Platform-specific data classes are all deprecated. '
                  'Use logicalKey and physicalKey from KeyEvent directly.',
            ),
            const SizedBox(height: 20),
            _SectionCard(
              title: 'Complete Before/After Example',
              icon: Icons.swap_horiz,
              children: <Widget>[
                const _BodyText('Full widget refactor — search widget:'),
                const SizedBox(height: 12),
                _CodeBlock(
                  code: '''// ===== BEFORE (deprecated) =====
class SearchBox extends StatefulWidget { ... }
class _SearchBoxState extends State<SearchBox> {
  final FocusNode _focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focus,
      autofocus: true,
      onKey: (RawKeyEvent e) {
        if (e is RawKeyDownEvent &&
            e.logicalKey == LogicalKeyboardKey.escape) {
          clearSearch();
        }
      },
      child: TextField(...),
    );
  }
}

// ===== AFTER (modern) =====
class SearchBox extends StatefulWidget { ... }
class _SearchBoxState extends State<SearchBox> {
  final FocusNode _focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focus,
      autofocus: true,
      onKeyEvent: (KeyEvent e) {
        if (e is KeyDownEvent &&
            e.logicalKey == LogicalKeyboardKey.escape) {
          clearSearch();
        }
      },
      child: TextField(...),
    );
  }
}''',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// SECTION 6: Key Constants Gallery
// ============================================================

class _KeyConstantsTab extends StatelessWidget {
  const _KeyConstantsTab();

  static const List<Map<String, String>> _keyTable = <Map<String, String>>[
    {'logical': 'LogicalKeyboardKey.keyA', 'physical': 'PhysicalKeyboardKey.keyA', 'raw': 'RawKeyboardKey not needed'},
    {'logical': 'LogicalKeyboardKey.space', 'physical': 'PhysicalKeyboardKey.space', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.enter', 'physical': 'PhysicalKeyboardKey.enter', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.escape', 'physical': 'PhysicalKeyboardKey.escape', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.arrowUp', 'physical': 'PhysicalKeyboardKey.arrowUp', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.shiftLeft', 'physical': 'PhysicalKeyboardKey.shiftLeft', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.controlLeft', 'physical': 'PhysicalKeyboardKey.controlLeft', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.alt', 'physical': 'PhysicalKeyboardKey.altLeft', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.backspace', 'physical': 'PhysicalKeyboardKey.backspace', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.tab', 'physical': 'PhysicalKeyboardKey.tab', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.f1', 'physical': 'PhysicalKeyboardKey.f1', 'raw': 'Platform keyCode varies'},
    {'logical': 'LogicalKeyboardKey.home', 'physical': 'PhysicalKeyboardKey.home', 'raw': 'Platform keyCode varies'},
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'LogicalKeyboardKey vs PhysicalKeyboardKey',
          icon: Icons.vpn_key,
          children: <Widget>[
            _ReasonRow(
              icon: Icons.language,
              color: cs.primary,
              title: 'LogicalKeyboardKey',
              body: 'Represents what the key MEANS — independent of keyboard layout. '
                  'LogicalKeyboardKey.keyA always refers to the "A" key concept, '
                  'even on AZERTY keyboards where the physical key is in a different position. '
                  'Use this for shortcuts and application logic.',
            ),
            const SizedBox(height: 10),
            _ReasonRow(
              icon: Icons.hardware,
              color: cs.secondary,
              title: 'PhysicalKeyboardKey',
              body: 'Represents WHERE the key is on the hardware — the physical scancode. '
                  'PhysicalKeyboardKey.keyA is always the key in the top-left letter row position, '
                  'regardless of what character it produces. Use this for gaming '
                  'where WASD position matters more than meaning.',
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: cs.outlineVariant),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
              },
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(color: cs.surfaceContainerHighest),
                  children: const <Widget>[
                    _TableCell(text: 'LogicalKeyboardKey', isHeader: true),
                    _TableCell(text: 'PhysicalKeyboardKey', isHeader: true),
                    _TableCell(text: 'Legacy RawKeyboard Note', isHeader: true),
                  ],
                ),
                ..._keyTable.map((row) => TableRow(
                      children: <Widget>[
                        _TableCell(text: row['logical']!, mono: true),
                        _TableCell(text: row['physical']!, mono: true),
                        _TableCell(text: row['raw']!),
                      ],
                    )),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Checking Keys in Modern Code',
          icon: Icons.code,
          children: <Widget>[
            _CodeBlock(
              code: '''// Checking a single key in onKeyEvent:
if (event.logicalKey == LogicalKeyboardKey.space) { ... }

// Checking modifiers via HardwareKeyboard:
final hw = HardwareKeyboard.instance;
if (hw.isControlPressed) { ... }
if (hw.isShiftPressed) { ... }
if (hw.isAltPressed) { ... }
if (hw.isMetaPressed) { ... }  // Cmd on macOS, Win on Windows

// Checking all currently held keys:
final held = HardwareKeyboard.instance.logicalKeysPressed;
// held is Set<LogicalKeyboardKey>

// Common shortcut check:
bool isSave(KeyEvent e) =>
  e is KeyDownEvent &&
  HardwareKeyboard.instance.isControlPressed &&
  e.logicalKey == LogicalKeyboardKey.keyS;''',
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// SECTION 7: Platform-specific RawKeyEvent issues
// ============================================================

class _PlatformIssuesTab extends StatelessWidget {
  const _PlatformIssuesTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Why RawKeyEvent Was Problematic Across Platforms',
          icon: Icons.devices,
          children: <Widget>[
            const _BodyText(
              'The fundamental design flaw of RawKeyEvent was that it was a thin wrapper '
              'over the native platform\'s key event representation. Every platform '
              'had a different concept of what a "key code" means:',
            ),
            const SizedBox(height: 16),
            _PlatformCard(
              platform: 'Android',
              color: Colors.green,
              icon: Icons.android,
              details: <String>[
                'keyCode: Android KEYCODE_ constants (int)',
                'scanCode: hardware scancode (int)',
                'metaState: bitmask for modifiers',
                'Problem: KEYCODE values are Android-specific integers',
                'Example: KEYCODE_A = 29 (not meaningful elsewhere)',
              ],
            ),
            const SizedBox(height: 10),
            _PlatformCard(
              platform: 'iOS',
              color: Colors.blue,
              icon: Icons.phone_iphone,
              details: <String>[
                'keyCode: iOS key code (int)',
                'modifiers: bitmask for modifier keys',
                'characters: the character string',
                'Problem: iOS key codes differ from Android',
                'No physical keyboard on most devices — limited testing',
              ],
            ),
            const SizedBox(height: 10),
            _PlatformCard(
              platform: 'Desktop (Win/Mac/Linux)',
              color: Colors.purple,
              icon: Icons.computer,
              details: <String>[
                'Each desktop platform has its own RawKeyEventData subclass',
                'Windows: Virtual Key codes (VK_ constants)',
                'macOS: Carbon/Cocoa key codes',
                'Linux: X11 keysyms or evdev codes',
                'Same physical key → different integer values on each OS',
              ],
            ),
            const SizedBox(height: 10),
            _PlatformCard(
              platform: 'Web',
              color: Colors.orange,
              icon: Icons.web,
              details: <String>[
                'code: DOM KeyboardEvent.code string',
                'key: DOM KeyboardEvent.key string',
                'metaState: bitmask',
                'Problem: web key codes are strings, not integers',
                'Completely different type from native platforms',
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'The Solution: LogicalKeyboardKey',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cs.onPrimaryContainer,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Flutter\'s engine maps all platform-specific codes to unified '
                    'LogicalKeyboardKey and PhysicalKeyboardKey constants before '
                    'delivering KeyEvents. Developers never see raw platform integers. '
                    'This is the core improvement in the HardwareKeyboard pipeline.',
                    style: TextStyle(color: cs.onPrimaryContainer),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Code Required Under Old API (illustrative)',
          icon: Icons.code,
          children: <Widget>[
            const _BodyText(
              'This shows how verbose platform handling was under RawKeyEvent '
              '(displayed as text — not compiled):',
            ),
            const SizedBox(height: 8),
            _CodeBlock(
              code: '''// Legacy: getting scancode required platform branching:
void _legacyOnKey(RawKeyEvent event) {
  final data = event.data;
  int? platformCode;
  if (data is RawKeyEventDataAndroid) {
    platformCode = data.keyCode;
  } else if (data is RawKeyEventDataWindows) {
    platformCode = data.keyCode;
  } else if (data is RawKeyEventDataLinux) {
    platformCode = data.keyCode;
  } else if (data is RawKeyEventDataMacOs) {
    platformCode = data.keyCode;
  } else if (data is RawKeyEventDataIos) {
    platformCode = data.keyCode;
  }
  // platformCode values are incompatible across platforms!
  // 29 on Android ≠ 65 on Linux ≠ 0 on macOS (all for "A")
}

// Modern: no branching needed
void _modernOnKeyEvent(KeyEvent event) {
  // event.logicalKey is consistent everywhere:
  if (event.logicalKey == LogicalKeyboardKey.keyA) { ... }
}''',
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// SECTION 8: Pipeline Diagram (CustomPainter)
// ============================================================

class _PipelineDiagramTab extends StatelessWidget {
  const _PipelineDiagramTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Old Pipeline (Deprecated)',
          icon: Icons.account_tree,
          children: <Widget>[
            const _BodyText(
              'The original keyboard event pipeline passed raw platform events '
              'directly to Dart, requiring platform-specific handling:',
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: CustomPaint(
                painter: _OldPipelinePainter(),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 8),
            const _BodyText('Hardware Key Press → Native Platform → RawKeyboard → RawKeyEvent → RawKeyboardListener → onKey callback'),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'New Pipeline (Modern)',
          icon: Icons.account_tree,
          children: <Widget>[
            const _BodyText(
              'The modern pipeline normalizes events in the engine before Dart '
              'sees them, eliminating platform-specific code entirely:',
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: CustomPaint(
                painter: _NewPipelinePainter(),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 8),
            const _BodyText('Hardware Key Press → Native Platform → Flutter Engine (normalization) → HardwareKeyboard → KeyEvent → KeyboardListener → onKeyEvent callback'),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Key Simplification',
          icon: Icons.compare,
          children: <Widget>[
            _ReasonRow(
              icon: Icons.remove_circle_outline,
              color: Colors.red,
              title: 'Removed: Platform-specific data',
              body: 'RawKeyEventData and all its subclasses (RawKeyEventDataAndroid, etc.) '
                  'are gone. The engine handles normalization internally.',
            ),
            const SizedBox(height: 10),
            _ReasonRow(
              icon: Icons.add_circle_outline,
              color: Colors.green,
              title: 'Added: Engine normalization layer',
              body: 'The Flutter engine maps all platform key codes to LogicalKeyboardKey '
                  'and PhysicalKeyboardKey before dispatching KeyEvents to Dart.',
            ),
            const SizedBox(height: 10),
            _ReasonRow(
              icon: Icons.swap_horiz,
              color: Colors.blue,
              title: 'Changed: Single event hierarchy',
              body: 'KeyDownEvent, KeyUpEvent, KeyRepeatEvent replace the two legacy types '
                  'and the bool repeat property. Pattern matching is cleaner.',
            ),
          ],
        ),
      ],
    );
  }
}

// CustomPainter for old pipeline diagram
class _OldPipelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxes = <String>[
      'Hardware\nKey Press',
      'Native\nPlatform',
      'RawKeyboard\n(deprecated)',
      'RawKeyEvent\n(deprecated)',
      'RawKeyboard\nListener',
      'onKey\ncallback',
    ];
    _drawPipeline(canvas, size, boxes, const Color(0xFFB71C1C), const Color(0xFFFFCDD2));
  }

  @override
  bool shouldRepaint(_OldPipelinePainter oldDelegate) => false;
}

// CustomPainter for new pipeline diagram
class _NewPipelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxes = <String>[
      'Hardware\nKey Press',
      'Native\nPlatform',
      'Engine\nNormalization',
      'HardwareKeyboard\n+ KeyEvent',
      'Keyboard\nListener',
      'onKeyEvent\ncallback',
    ];
    _drawPipeline(canvas, size, boxes, const Color(0xFF1B5E20), const Color(0xFFC8E6C9));
  }

  @override
  bool shouldRepaint(_NewPipelinePainter oldDelegate) => false;
}

void _drawPipeline(Canvas canvas, Size size, List<String> boxes, Color borderColor, Color fillColor) {
  final boxWidth = (size.width - 16) / boxes.length - 8;
  const boxHeight = 60.0;
  final startY = (size.height - boxHeight) / 2;

  final fillPaint = Paint()..color = fillColor;
  final borderPaint = Paint()
    ..color = borderColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;
  final arrowPaint = Paint()
    ..color = borderColor
    ..style = PaintingStyle.fill;

  for (int i = 0; i < boxes.length; i++) {
    final x = 8 + i * (boxWidth + 8);
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x, startY, boxWidth, boxHeight),
      const Radius.circular(6),
    );
    canvas.drawRRect(rect, fillPaint);
    canvas.drawRRect(rect, borderPaint);

    final tp = TextPainter(
      text: TextSpan(
        text: boxes[i],
        style: TextStyle(fontSize: 9, color: borderColor, fontWeight: FontWeight.bold),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: boxWidth - 4);
    tp.paint(canvas, Offset(x + (boxWidth - tp.width) / 2, startY + (boxHeight - tp.height) / 2));

    // Arrow between boxes
    if (i < boxes.length - 1) {
      final arrowX = x + boxWidth + 4;
      final arrowY = startY + boxHeight / 2;
      final path = Path()
        ..moveTo(arrowX - 4, arrowY - 4)
        ..lineTo(arrowX + 4, arrowY)
        ..lineTo(arrowX - 4, arrowY + 4)
        ..close();
      canvas.drawPath(path, arrowPaint);
    }
  }
}

// ============================================================
// SECTION 9: Deprecation Timeline
// ============================================================

class _DeprecationTimelineTab extends StatelessWidget {
  const _DeprecationTimelineTab();

  static const List<Map<String, dynamic>> _events = <Map<String, dynamic>>[
    {
      'version': 'Flutter 1.0',
      'date': '2018',
      'event': 'RawKeyboard and RawKeyboardListener introduced',
      'type': 'launch',
    },
    {
      'version': 'Flutter 2.0',
      'date': '2021',
      'event': 'HardwareKeyboard and KeyEvent introduced as the new API',
      'type': 'new',
    },
    {
      'version': 'Flutter 2.5',
      'date': '2021',
      'event': 'KeyboardListener widget introduced as the replacement for RawKeyboardListener',
      'type': 'new',
    },
    {
      'version': 'Flutter 3.3',
      'date': '2022',
      'event': 'RawKeyboard pipeline officially deprecated; RawKeyEvent and friends marked deprecated',
      'type': 'deprecated',
    },
    {
      'version': 'Flutter 3.7',
      'date': '2023',
      'event': 'RawKeyboardListener deprecated annotation added; migration guide published',
      'type': 'deprecated',
    },
    {
      'version': 'Flutter 3.18+',
      'date': '2024+',
      'event': 'New projects should use only KeyboardListener and HardwareKeyboard',
      'type': 'migration',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Deprecation Timeline',
          icon: Icons.timeline,
          children: <Widget>[
            ..._events.map((e) {
              Color chipColor;
              Color chipTextColor;
              IconData eventIcon;
              switch (e['type'] as String) {
                case 'launch':
                  chipColor = cs.primary;
                  chipTextColor = cs.onPrimary;
                  eventIcon = Icons.rocket_launch;
                case 'new':
                  chipColor = Colors.green;
                  chipTextColor = Colors.white;
                  eventIcon = Icons.add_circle;
                case 'deprecated':
                  chipColor = cs.error;
                  chipTextColor = cs.onError;
                  eventIcon = Icons.warning;
                default:
                  chipColor = cs.tertiary;
                  chipTextColor = cs.onTertiary;
                  eventIcon = Icons.directions;
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: chipColor,
                          radius: 18,
                          child: Icon(eventIcon, color: chipTextColor, size: 18),
                        ),
                        Container(width: 2, height: 30, color: cs.outlineVariant),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Chip(
                                label: Text(
                                  e['version'] as String,
                                  style: TextStyle(fontSize: 11, color: chipTextColor),
                                ),
                                backgroundColor: chipColor,
                                padding: EdgeInsets.zero,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                e['date'] as String,
                                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(e['event'] as String, style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'API Cheat Sheet — Legacy vs Modern',
          icon: Icons.menu_book,
          children: <Widget>[
            Table(
              border: TableBorder.all(color: cs.outlineVariant, borderRadius: BorderRadius.circular(8)),
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
              },
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(color: cs.surfaceContainerHighest),
                  children: const <Widget>[
                    _TableCell(text: 'Concept', isHeader: true),
                    _TableCell(text: 'Legacy (Deprecated)', isHeader: true),
                    _TableCell(text: 'Modern (Use This)', isHeader: true),
                  ],
                ),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Listener widget'),
                  _TableCell(text: 'RawKeyboardListener', mono: true),
                  _TableCell(text: 'KeyboardListener', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Callback param'),
                  _TableCell(text: 'onKey', mono: true),
                  _TableCell(text: 'onKeyEvent', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Event base class'),
                  _TableCell(text: 'RawKeyEvent', mono: true),
                  _TableCell(text: 'KeyEvent', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Key down event'),
                  _TableCell(text: 'RawKeyDownEvent', mono: true),
                  _TableCell(text: 'KeyDownEvent', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Key up event'),
                  _TableCell(text: 'RawKeyUpEvent', mono: true),
                  _TableCell(text: 'KeyUpEvent', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Key repeat'),
                  _TableCell(text: 'RawKeyDownEvent.repeat (bool)', mono: true),
                  _TableCell(text: 'KeyRepeatEvent', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Global keyboard'),
                  _TableCell(text: 'RawKeyboard.instance', mono: true),
                  _TableCell(text: 'HardwareKeyboard.instance', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Keys currently held'),
                  _TableCell(text: 'RawKeyboard.instance.keysPressed', mono: true),
                  _TableCell(text: 'HardwareKeyboard.instance.logicalKeysPressed', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Modifier check'),
                  _TableCell(text: 'event.isControlPressed', mono: true),
                  _TableCell(text: 'HardwareKeyboard.instance.isControlPressed', mono: true),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Platform data'),
                  _TableCell(text: 'event.data (RawKeyEventData subclass)', mono: true),
                  _TableCell(text: 'Not needed — use logicalKey/physicalKey', mono: true),
                ]),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Bottom line: Replace RawKeyboardListener with KeyboardListener, '
                'onKey with onKeyEvent, and RawKeyEvent with KeyEvent. '
                'Delete all platform-specific data access. Done.',
                style: TextStyle(
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// Shared helper widgets
// ============================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.icon, required this.children});
  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: cs.primary, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SelectableText(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: cs.onSurface,
          height: 1.5,
        ),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.onSurface,
        height: 1.5,
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({required this.text, this.isHeader = false, this.mono = false});
  final String text;
  final bool isHeader;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontFamily: mono ? 'monospace' : null,
          color: isHeader ? cs.onSurface : cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ReasonRow extends StatelessWidget {
  const _ReasonRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 2),
              Text(body, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: cs.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$label: ',
            style: TextStyle(fontSize: 12, color: color),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

class _PlatformCard extends StatelessWidget {
  const _PlatformCard({
    required this.platform,
    required this.color,
    required this.icon,
    required this.details,
  });
  final String platform;
  final Color color;
  final IconData icon;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8),
        color: color.withValues(alpha: 0.05),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                platform,
                style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...details.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  '• $d',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              )),
        ],
      ),
    );
  }
}

class _MigrationStep extends StatelessWidget {
  const _MigrationStep({
    required this.step,
    required this.title,
    required this.before,
    required this.after,
    required this.note,
  });
  final int step;
  final String title;
  final String before;
  final String after;
  final String note;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: cs.primary,
                radius: 14,
                child: Text(
                  '$step',
                  style: TextStyle(color: cs.onPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      color: cs.errorContainer,
                      child: Text('BEFORE', style: TextStyle(fontSize: 10, color: cs.error, fontWeight: FontWeight.bold)),
                    ),
                    _CodeBlock(code: before),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      color: const Color(0xFFC8E6C9),
                      child: const Text('AFTER', style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                    _CodeBlock(code: after),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              note,
              style: TextStyle(fontSize: 12, color: cs.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
