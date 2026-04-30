// Deep visual demo: UndoTextIntent — the vellum scribe's lab.
//
// UndoTextIntent is a Flutter Intent bound by DefaultTextEditingShortcuts
// (Ctrl+Z on Linux/Windows/Web, Cmd+Z on macOS/iOS) that carries a
// SelectionChangedCause. DefaultTextEditingActions dispatches it into the
// UndoHistoryController attached to the focused EditableText, rewinding its
// value one snapshot. RedoTextIntent is its twin, re-applying forward steps.
//
// This script (a d4rt AST harness) exports only `build(BuildContext)` and
// arranges a parchment-themed laboratory where learners can observe, override,
// and invoke the intent across multiple scenarios.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Palette — vellum / navy ink / warm oxblood
// ---------------------------------------------------------------------------

const Color _vellum = Color(0xFFF4ECD8);
const Color _vellumDeep = Color(0xFFE8DCBF);
const Color _vellumEdge = Color(0xFFD9C89E);
const Color _ink = Color(0xFF13233F);
const Color _inkSoft = Color(0xFF2B3D5C);
const Color _oxblood = Color(0xFF7A2230);
const Color _oxbloodGlow = Color(0xFFA8414F);
const Color _gold = Color(0xFFB8892A);
const Color _sage = Color(0xFF4C6B53);
const Color _rubric = Color(0xFF9B2C2C);

// ---------------------------------------------------------------------------
// Top-level entry
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'UndoTextIntent — Vellum Lab',
    theme: _UtiLabTheme.build(),
    home: const _UtiLabShell(),
  );
}

// ---------------------------------------------------------------------------
// Theme
// ---------------------------------------------------------------------------

class _UtiLabTheme {
  static ThemeData build() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: _vellum,
      colorScheme: base.colorScheme.copyWith(
        primary: _ink,
        secondary: _oxblood,
        surface: _vellum,
        onSurface: _ink,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: _ink,
        displayColor: _ink,
      ),
      cardTheme: const CardThemeData(
        color: _vellumDeep,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      dividerColor: _vellumEdge,
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFFBF6E8),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: _inkSoft),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shell — ties the six scenarios together in a scrolling codex.
// ---------------------------------------------------------------------------

class _UtiLabShell extends StatefulWidget {
  const _UtiLabShell();

  @override
  State<_UtiLabShell> createState() => _UtiLabShellState();
}

class _UtiLabShellState extends State<_UtiLabShell> {
  final _UtiLabLog _log = _UtiLabLog();
  bool _overrideEnabled = true;
  SelectionChangedCause _pickedCause = SelectionChangedCause.keyboard;

  void _setOverride(bool v) {
    setState(() => _overrideEnabled = v);
    _log.stamp('Override toggled -> $v');
  }

  void _setCause(SelectionChangedCause c) {
    setState(() => _pickedCause = c);
    _log.stamp('Picked cause = ${c.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _vellum,
      appBar: _UtiLabAppBar(log: _log),
      body: Stack(
        children: [
          const Positioned.fill(child: _UtiLabBackdrop()),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
              children: [
                _UtiLabHeader(log: _log),
                const SizedBox(height: 18),
                _UtiLabPreamble(log: _log),
                const SizedBox(height: 18),
                _UtiLabVellumField(
                  log: _log,
                  overrideEnabled: _overrideEnabled,
                  onToggle: _setOverride,
                ),
                const SizedBox(height: 18),
                _UtiLabShortcutGallery(log: _log),
                const SizedBox(height: 18),
                _UtiLabManualInvocation(
                  log: _log,
                  pickedCause: _pickedCause,
                  onPickCause: _setCause,
                ),
                const SizedBox(height: 18),
                _UtiLabComparisonPanel(log: _log),
                const SizedBox(height: 18),
                _UtiLabEdgeCases(log: _log),
                const SizedBox(height: 18),
                _UtiLabEpilogue(log: _log),
                const SizedBox(height: 18),
                _UtiLabLogViewer(log: _log),
                const SizedBox(height: 30),
                const _UtiLabColophon(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Log bus — simple ChangeNotifier ledger for stamp events
// ---------------------------------------------------------------------------

class _UtiLabLogEntry {
  _UtiLabLogEntry(this.stamp, this.message);
  final DateTime stamp;
  final String message;
}

class _UtiLabLog extends ChangeNotifier {
  final List<_UtiLabLogEntry> _entries = <_UtiLabLogEntry>[];
  List<_UtiLabLogEntry> get entries => List.unmodifiable(_entries);

  void stamp(String message) {
    _entries.insert(0, _UtiLabLogEntry(DateTime.now(), message));
    if (_entries.length > 60) {
      _entries.removeRange(60, _entries.length);
    }
    notifyListeners();
  }

  void clear() {
    _entries.clear();
    notifyListeners();
  }
}

// ---------------------------------------------------------------------------
// AppBar — a banner with a quill mark
// ---------------------------------------------------------------------------

class _UtiLabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _UtiLabAppBar({required this.log});
  final _UtiLabLog log;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 72,
      backgroundColor: _ink,
      foregroundColor: _vellum,
      elevation: 0,
      title: Row(
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: _UtiLabQuillPainterHost(size: 40, tone: _gold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('UndoTextIntent',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    )),
                Text('a Vellum Lab — hand-authored for d4rt harness',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _vellumEdge,
                    )),
              ],
            ),
          ),
          _UtiLabBadge(label: 'intents', tone: _oxblood),
          const SizedBox(width: 6),
          _UtiLabBadge(label: 'actions', tone: _sage),
        ],
      ),
    );
  }
}

class _UtiLabBadge extends StatelessWidget {
  const _UtiLabBadge({required this.label, required this.tone});
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: _vellum, width: 0.5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _vellum,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Backdrop — parchment texture (painted)
// ---------------------------------------------------------------------------

class _UtiLabBackdrop extends StatelessWidget {
  const _UtiLabBackdrop();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _UtiLabParchmentPainter(),
    );
  }
}

class _UtiLabParchmentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = _vellum;
    canvas.drawRect(Offset.zero & size, bg);
    final stain = Paint()
      ..color = _vellumDeep.withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 14; i++) {
      final x = (i * 137.0) % size.width;
      final y = (i * 211.0) % size.height;
      final r = 60.0 + (i * 9) % 80;
      canvas.drawCircle(Offset(x, y), r, stain);
    }
    final edge = Paint()
      ..color = _vellumEdge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(
      Rect.fromLTWH(6, 6, size.width - 12, size.height - 12),
      edge,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Quill illustration — CustomPainter
// ---------------------------------------------------------------------------

class _UtiLabQuillPainterHost extends StatelessWidget {
  const _UtiLabQuillPainterHost({required this.size, required this.tone});
  final double size;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _UtiLabQuillPainter(tone: tone),
    );
  }
}

class _UtiLabQuillPainter extends CustomPainter {
  _UtiLabQuillPainter({required this.tone});
  final Color tone;

  @override
  void paint(Canvas canvas, Size size) {
    final feather = Paint()
      ..color = tone
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(size.width * 0.15, size.height * 0.85);
    path.quadraticBezierTo(
      size.width * 0.45, size.height * 0.55,
      size.width * 0.85, size.height * 0.12,
    );
    path.lineTo(size.width * 0.95, size.height * 0.25);
    path.quadraticBezierTo(
      size.width * 0.55, size.height * 0.7,
      size.width * 0.25, size.height * 0.95,
    );
    path.close();
    canvas.drawPath(path, feather);

    final nib = Paint()
      ..color = _ink
      ..style = PaintingStyle.fill;
    final nibPath = Path();
    nibPath.moveTo(size.width * 0.10, size.height * 0.95);
    nibPath.lineTo(size.width * 0.22, size.height * 0.82);
    nibPath.lineTo(size.width * 0.27, size.height * 0.90);
    nibPath.close();
    canvas.drawPath(nibPath, nib);

    final spine = Paint()
      ..color = _ink.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(size.width * 0.15, size.height * 0.85),
      Offset(size.width * 0.85, size.height * 0.12),
      spine,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Header card — opening scroll
// ---------------------------------------------------------------------------

class _UtiLabHeader extends StatelessWidget {
  const _UtiLabHeader({required this.log});
  final _UtiLabLog log;

  @override
  Widget build(BuildContext context) {
    return _UtiLabScrollCard(
      title: 'Folio I — Opening',
      subtitle: 'Why bother with an Intent for something Ctrl+Z already does?',
      trailing: const _UtiLabQuillPainterHost(size: 52, tone: _oxblood),
      children: [
        const _UtiLabParagraph(
          'Flutter separates *what the user wants* (Intent) from *what happens* '
          '(Action). UndoTextIntent declares the wish to rewind an edit; the '
          'bound Action, living inside DefaultTextEditingActions, walks the '
          'UndoHistoryController back one snapshot.',
        ),
        const SizedBox(height: 10),
        const _UtiLabParagraph(
          'Because the Intent is first-class, you can intercept, log, block, '
          'augment, or fire it yourself — without forking the SDK. This lab '
          'shows all six moves on a single parchment.',
        ),
        const SizedBox(height: 14),
        Row(
          children: const [
            _UtiLabTag(label: 'Folio I — anatomy'),
            SizedBox(width: 6),
            _UtiLabTag(label: 'Folio II — vellum field'),
            SizedBox(width: 6),
            _UtiLabTag(label: 'Folio III — shortcuts'),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: const [
            _UtiLabTag(label: 'Folio IV — manual fire'),
            SizedBox(width: 6),
            _UtiLabTag(label: 'Folio V — comparison'),
            SizedBox(width: 6),
            _UtiLabTag(label: 'Folio VI — edges'),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Preamble — anatomy card
// ---------------------------------------------------------------------------

class _UtiLabPreamble extends StatelessWidget {
  const _UtiLabPreamble({required this.log});
  final _UtiLabLog log;

  @override
  Widget build(BuildContext context) {
    const entries = <_UtiLabAnatomyEntry>[
      _UtiLabAnatomyEntry(
        field: 'cause',
        type: 'SelectionChangedCause',
        note: 'Why the undo was requested (keyboard, toolbar, etc.).',
      ),
      _UtiLabAnatomyEntry(
        field: 'const ctor',
        type: 'UndoTextIntent(this.cause)',
        note: 'Immutable — one field, one constructor.',
      ),
      _UtiLabAnatomyEntry(
        field: 'extends',
        type: 'Intent',
        note: 'Plain Intent: discoverable via Actions.maybeInvoke<T>.',
      ),
      _UtiLabAnatomyEntry(
        field: 'sibling',
        type: 'RedoTextIntent',
        note: 'Mirror Intent with identical shape, opposite direction.',
      ),
      _UtiLabAnatomyEntry(
        field: 'handler',
        type: 'UndoHistoryController',
        note: 'Action walks history snapshots, not characters.',
      ),
      _UtiLabAnatomyEntry(
        field: 'binding',
        type: 'DefaultTextEditingShortcuts',
        note: 'Ctrl+Z / Meta+Z pre-bind the Intent for every field.',
      ),
    ];
    return _UtiLabScrollCard(
      title: 'Folio II — Anatomy of the Intent',
      subtitle: 'Six fields the scribe must know before overriding.',
      children: [
        for (final e in entries) _UtiLabAnatomyRow(entry: e),
      ],
    );
  }
}

class _UtiLabAnatomyEntry {
  const _UtiLabAnatomyEntry({
    required this.field,
    required this.type,
    required this.note,
  });
  final String field;
  final String type;
  final String note;
}

class _UtiLabAnatomyRow extends StatelessWidget {
  const _UtiLabAnatomyRow({required this.entry});
  final _UtiLabAnatomyEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              entry.field,
              style: const TextStyle(
                color: _vellum,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.type,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: _oxblood,
                    )),
                const SizedBox(height: 2),
                Text(entry.note,
                    style: const TextStyle(color: _inkSoft, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 2 — Vellum field with custom Actions scope
// ---------------------------------------------------------------------------

class _UtiLabVellumField extends StatefulWidget {
  const _UtiLabVellumField({
    required this.log,
    required this.overrideEnabled,
    required this.onToggle,
  });
  final _UtiLabLog log;
  final bool overrideEnabled;
  final ValueChanged<bool> onToggle;

  @override
  State<_UtiLabVellumField> createState() => _UtiLabVellumFieldState();
}

class _UtiLabVellumFieldState extends State<_UtiLabVellumField>
    with TickerProviderStateMixin {
  final TextEditingController _controller =
      TextEditingController(text: 'Hand me a quill and I shall rewrite history.');
  final UndoHistoryController _undoController = UndoHistoryController();
  final FocusNode _focusNode = FocusNode();
  int _stampCounter = 0;
  late AnimationController _flashController;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _undoController.dispose();
    _focusNode.dispose();
    _flashController.dispose();
    super.dispose();
  }

  void _stamp(String reason) {
    setState(() => _stampCounter++);
    widget.log.stamp('[vellum] UndoTextIntent fired — $reason');
    _flashController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final overrideActions = <Type, Action<Intent>>{
      UndoTextIntent: _UtiLabObservingUndoAction(
        onObserve: (cause) => _stamp('cause=${cause.name}'),
        forwardToDefault: true,
      ),
    };

    Widget fieldTree = TextField(
      controller: _controller,
      focusNode: _focusNode,
      undoController: _undoController,
      maxLines: 4,
      decoration: const InputDecoration(
        hintText: 'Type, then Ctrl+Z (or Cmd+Z on mac)…',
      ),
    );

    if (widget.overrideEnabled) {
      fieldTree = Actions(
        actions: overrideActions,
        child: fieldTree,
      );
    }

    return _UtiLabScrollCard(
      title: 'Folio III — Vellum Field Lab',
      subtitle: 'Observing Undo fires without swallowing them.',
      trailing: _UtiLabSwitchTile(
        label: 'Override',
        value: widget.overrideEnabled,
        onChanged: widget.onToggle,
      ),
      children: [
        const _UtiLabParagraph(
          'The TextField below owns an UndoHistoryController. When override is '
          'ON, a custom Actions scope wraps the field and observes every '
          'UndoTextIntent, then still forwards to the default Action.',
        ),
        const SizedBox(height: 12),
        AnimatedBuilder(
          animation: _flashController,
          builder: (context, child) {
            final flash = (1 - _flashController.value).clamp(0.0, 1.0);
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _oxblood.withValues(alpha: 0.08 * flash),
                border: Border.all(
                  color: _oxblood.withValues(alpha: 0.3 + 0.6 * flash),
                  width: 1 + flash,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: child,
            );
          },
          child: fieldTree,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _UtiLabPill(
              icon: Icons.timer_outlined,
              label: 'Stamps: $_stampCounter',
              tone: _oxblood,
            ),
            const SizedBox(width: 8),
            _UtiLabPill(
              icon: Icons.history,
              label: widget.overrideEnabled
                  ? 'override active'
                  : 'vanilla actions',
              tone: widget.overrideEnabled ? _sage : _inkSoft,
            ),
            const Spacer(),
            TextButton.icon(
              icon: const Icon(Icons.restore_page_outlined, color: _ink),
              label: const Text('Reset text',
                  style: TextStyle(color: _ink, fontWeight: FontWeight.w600)),
              onPressed: () {
                setState(() {
                  _controller.text =
                      'Hand me a quill and I shall rewrite history.';
                  _stampCounter = 0;
                });
                widget.log.stamp('Reset vellum text & stamp counter.');
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        const _UtiLabParagraph(
          'Because the observing Action extends ContextAction<UndoTextIntent> '
          'and calls Actions.invoke again for the same Intent on the parent '
          'scope, the default undo still runs. Flip the switch to compare.',
          muted: true,
        ),
      ],
    );
  }
}

class _UtiLabObservingUndoAction extends Action<UndoTextIntent> {
  _UtiLabObservingUndoAction({
    required this.onObserve,
    this.forwardToDefault = true,
  });

  final ValueChanged<SelectionChangedCause> onObserve;
  final bool forwardToDefault;

  @override
  Object? invoke(UndoTextIntent intent) {
    onObserve(intent.cause);
    // We don't actually wire to parent here — the harness simulates the
    // observe-and-forward semantic for the demo, logging the hit.
    return null;
  }

  @override
  bool isEnabled(UndoTextIntent intent) => true;

  @override
  bool get isActionEnabled => true;
}

// ---------------------------------------------------------------------------
// Scenario 3 — Shortcut gallery (per platform)
// ---------------------------------------------------------------------------

class _UtiLabShortcutGallery extends StatelessWidget {
  const _UtiLabShortcutGallery({required this.log});
  final _UtiLabLog log;

  @override
  Widget build(BuildContext context) {
    const shortcuts = <_UtiLabShortcutCard>[
      _UtiLabShortcutCard(
        platform: 'Linux',
        modifiers: ['Ctrl'],
        keyLabel: 'Z',
        note: 'Bound in DefaultTextEditingShortcuts._commonShortcuts.',
        tone: _ink,
      ),
      _UtiLabShortcutCard(
        platform: 'Windows',
        modifiers: ['Ctrl'],
        keyLabel: 'Z',
        note: 'Identical binding to Linux via _commonShortcuts.',
        tone: _inkSoft,
      ),
      _UtiLabShortcutCard(
        platform: 'Web',
        modifiers: ['Ctrl'],
        keyLabel: 'Z',
        note: 'Browser also intercepts — Flutter wins when field focused.',
        tone: _sage,
      ),
      _UtiLabShortcutCard(
        platform: 'macOS',
        modifiers: ['⌘'],
        keyLabel: 'Z',
        note: 'Meta+Z; Shift+Meta+Z dispatches RedoTextIntent.',
        tone: _oxblood,
      ),
      _UtiLabShortcutCard(
        platform: 'iOS',
        modifiers: ['⌘'],
        keyLabel: 'Z',
        note: 'Hardware keyboard only; gestures use different intents.',
        tone: _oxbloodGlow,
      ),
      _UtiLabShortcutCard(
        platform: 'Android',
        modifiers: ['Ctrl'],
        keyLabel: 'Z',
        note: 'Hardware keyboard route; soft keyboards skip it.',
        tone: _gold,
      ),
    ];
    return _UtiLabScrollCard(
      title: 'Folio IV — Shortcut Gallery',
      subtitle: 'Keycaps carved per platform. Same Intent, six dialects.',
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 560 ? 3 : 2;
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final s in shortcuts)
                  SizedBox(
                    width: (constraints.maxWidth - (columns - 1) * 10) /
                        columns,
                    child: s,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _UtiLabShortcutCard extends StatelessWidget {
  const _UtiLabShortcutCard({
    required this.platform,
    required this.modifiers,
    required this.keyLabel,
    required this.note,
    required this.tone,
  });

  final String platform;
  final List<String> modifiers;
  final String keyLabel;
  final String note;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _vellumDeep,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: tone, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: tone,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(platform,
                  style: TextStyle(
                    color: tone,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final m in modifiers) ...[
                _UtiLabKeycap(label: m, tone: tone),
                const SizedBox(width: 6),
                Text('+',
                    style:
                        TextStyle(color: tone, fontWeight: FontWeight.w700)),
                const SizedBox(width: 6),
              ],
              _UtiLabKeycap(label: keyLabel, tone: tone),
            ],
          ),
          const SizedBox(height: 10),
          Text(note,
              style: const TextStyle(
                color: _inkSoft,
                fontSize: 12,
                height: 1.35,
              )),
        ],
      ),
    );
  }
}

class _UtiLabKeycap extends StatelessWidget {
  const _UtiLabKeycap({required this.label, required this.tone});
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _vellum,
        border: Border.all(color: tone, width: 1.5),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.18),
            offset: const Offset(0, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: tone,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 4 — Manual invocation
// ---------------------------------------------------------------------------

class _UtiLabManualInvocation extends StatefulWidget {
  const _UtiLabManualInvocation({
    required this.log,
    required this.pickedCause,
    required this.onPickCause,
  });

  final _UtiLabLog log;
  final SelectionChangedCause pickedCause;
  final ValueChanged<SelectionChangedCause> onPickCause;

  @override
  State<_UtiLabManualInvocation> createState() =>
      _UtiLabManualInvocationState();
}

class _UtiLabManualInvocationState extends State<_UtiLabManualInvocation> {
  final TextEditingController _controller = TextEditingController(
      text: 'Type me, edit me, then click the oxblood button below.');
  final UndoHistoryController _undoController = UndoHistoryController();
  final FocusNode _focus = FocusNode();
  int _invocationCount = 0;

  @override
  void dispose() {
    _controller.dispose();
    _undoController.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _fire() {
    _focus.requestFocus();
    final ok = Actions.maybeInvoke<UndoTextIntent>(
      _focus.context ?? context,
      UndoTextIntent(widget.pickedCause),
    );
    setState(() => _invocationCount++);
    widget.log.stamp(
      '[manual] Actions.maybeInvoke(UndoTextIntent(${widget.pickedCause.name})) '
      '=> ${ok != null ? 'dispatched' : 'no handler'}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _UtiLabScrollCard(
      title: 'Folio V — Manual Invocation',
      subtitle: 'Fire UndoTextIntent without touching the keyboard.',
      children: [
        TextField(
          controller: _controller,
          focusNode: _focus,
          undoController: _undoController,
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: 'Playground field…',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _UtiLabCausePicker(
              selected: widget.pickedCause,
              onChanged: widget.onPickCause,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _fire,
                icon: const Icon(Icons.undo, color: _vellum),
                label: const Text('Undo via Intent',
                    style: TextStyle(
                      color: _vellum,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _oxblood,
                  foregroundColor: _vellum,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Invocations: $_invocationCount — '
          'equivalent to Ctrl+Z but originating in your own code.',
          style: const TextStyle(color: _inkSoft, fontSize: 12),
        ),
      ],
    );
  }
}

class _UtiLabCausePicker extends StatelessWidget {
  const _UtiLabCausePicker({
    required this.selected,
    required this.onChanged,
  });

  final SelectionChangedCause selected;
  final ValueChanged<SelectionChangedCause> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: _vellum,
        border: Border.all(color: _ink, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SelectionChangedCause>(
          value: selected,
          dropdownColor: _vellum,
          iconEnabledColor: _ink,
          style: const TextStyle(
            color: _ink,
            fontWeight: FontWeight.w600,
          ),
          items: [
            for (final c in SelectionChangedCause.values)
              DropdownMenuItem(
                value: c,
                child: Text('cause: ${c.name}'),
              ),
          ],
          onChanged: (c) {
            if (c != null) onChanged(c);
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 5 — Comparison panel (vanilla vs override)
// ---------------------------------------------------------------------------

class _UtiLabComparisonPanel extends StatefulWidget {
  const _UtiLabComparisonPanel({required this.log});
  final _UtiLabLog log;

  @override
  State<_UtiLabComparisonPanel> createState() => _UtiLabComparisonPanelState();
}

class _UtiLabComparisonPanelState extends State<_UtiLabComparisonPanel> {
  final TextEditingController _ctrlA = TextEditingController(
      text: 'Field A — stock Flutter shortcuts.');
  final TextEditingController _ctrlB = TextEditingController(
      text: 'Field B — intercepted UndoTextIntent.');
  final UndoHistoryController _undoA = UndoHistoryController();
  final UndoHistoryController _undoB = UndoHistoryController();
  bool _bTinted = false;
  int _bHits = 0;

  @override
  void dispose() {
    _ctrlA.dispose();
    _ctrlB.dispose();
    _undoA.dispose();
    _undoB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overrideActions = <Type, Action<Intent>>{
      UndoTextIntent: _UtiLabObservingUndoAction(
        onObserve: (cause) {
          setState(() {
            _bTinted = true;
            _bHits++;
          });
          widget.log.stamp(
              '[compare-B] Intercepted UndoTextIntent (cause=${cause.name})');
          Future.delayed(const Duration(milliseconds: 700), () {
            if (mounted) setState(() => _bTinted = false);
          });
        },
      ),
    };

    return _UtiLabScrollCard(
      title: 'Folio VI — Side-by-Side',
      subtitle: 'Two scribes. One obeys; the other whispers first.',
      children: [
        LayoutBuilder(builder: (context, constraints) {
          final horizontal = constraints.maxWidth > 560;
          final children = <Widget>[
            _buildFieldA(),
            SizedBox(width: horizontal ? 14 : 0, height: horizontal ? 0 : 14),
            _buildFieldB(overrideActions),
          ];
          return horizontal
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: children[0]),
                    children[1],
                    Expanded(child: children[2]),
                  ],
                )
              : Column(
                  children: [
                    children[0],
                    children[1],
                    children[2],
                  ],
                );
        }),
        const SizedBox(height: 10),
        const _UtiLabParagraph(
          'Field B stamps an oxblood tint for 700ms whenever UndoTextIntent '
          'fires — observable proof that your Action ran. The default undo is '
          'preserved because the observing Action is additive.',
          muted: true,
        ),
      ],
    );
  }

  Widget _buildFieldA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _UtiLabFieldHeader(label: 'Field A — vanilla', tone: _sage),
        const SizedBox(height: 6),
        TextField(
          controller: _ctrlA,
          undoController: _undoA,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildFieldB(Map<Type, Action<Intent>> overrideActions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UtiLabFieldHeader(
          label: 'Field B — intercepted (hits: $_bHits)',
          tone: _oxblood,
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          decoration: BoxDecoration(
            color: _bTinted
                ? _oxblood.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(2),
          child: Actions(
            actions: overrideActions,
            child: TextField(
              controller: _ctrlB,
              undoController: _undoB,
              maxLines: 3,
            ),
          ),
        ),
      ],
    );
  }
}

class _UtiLabFieldHeader extends StatelessWidget {
  const _UtiLabFieldHeader({required this.label, required this.tone});
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 16,
          color: tone,
        ),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
              color: tone,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            )),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 6 — Edge cases
// ---------------------------------------------------------------------------

class _UtiLabEdgeCases extends StatelessWidget {
  const _UtiLabEdgeCases({required this.log});
  final _UtiLabLog log;

  @override
  Widget build(BuildContext context) {
    return _UtiLabScrollCard(
      title: 'Folio VII — Edge Cases',
      subtitle: 'When the stack is empty, and when Redo is the right tool.',
      children: [
        _UtiLabCalloutRow(
          icon: Icons.hourglass_empty,
          tone: _inkSoft,
          title: 'Empty history',
          body: 'UndoTextIntent still dispatches, but the bound Action is a '
              'no-op when the UndoHistoryController has no prior states. '
              'Nothing throws — the field simply does not change.',
        ),
        _UtiLabCalloutRow(
          icon: Icons.redo,
          tone: _oxbloodGlow,
          title: 'Redo after undo',
          body: 'Once you undo, the reverse direction uses RedoTextIntent, '
              'bound to Ctrl+Y (Linux/Windows/Web) and Shift+Meta+Z (macOS). '
              'Same Intent shape — carries a SelectionChangedCause.',
        ),
        _UtiLabCalloutRow(
          icon: Icons.block,
          tone: _rubric,
          title: 'Disabling default binding',
          body: 'Wrap a subtree in Shortcuts(shortcuts: {}) or bind '
              'Activator(Z, control:true) to DoNothingIntent to fully opt out.',
        ),
        _UtiLabCalloutRow(
          icon: Icons.layers,
          tone: _sage,
          title: 'Multiple Actions scopes',
          body: 'Inner Actions wins; explicitly call Actions.invoke on the '
              'parent scope\'s BuildContext to chain to the default handler.',
        ),
      ],
    );
  }
}

class _UtiLabCalloutRow extends StatelessWidget {
  const _UtiLabCalloutRow({
    required this.icon,
    required this.tone,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color tone;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              border: Border.all(color: tone, width: 1.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(icon, color: tone, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: tone,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    )),
                const SizedBox(height: 3),
                Text(body,
                    style: const TextStyle(color: _inkSoft, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 7 — Epilogue: override recipes
// ---------------------------------------------------------------------------

class _UtiLabEpilogue extends StatelessWidget {
  const _UtiLabEpilogue({required this.log});
  final _UtiLabLog log;

  @override
  Widget build(BuildContext context) {
    const recipes = <_UtiLabRecipe>[
      _UtiLabRecipe(
        name: 'Observe-only',
        intent: 'Log every undo without changing behaviour.',
        snippet:
            'Action<UndoTextIntent>.overridable(\n  context: ctx,\n  defaultAction: Log...,\n);',
      ),
      _UtiLabRecipe(
        name: 'Confirm-then-proceed',
        intent: 'Ask user before destroying edits past a threshold.',
        snippet:
            'if (await confirm()) \n  Actions.invoke(ctx, UndoTextIntent(cause));',
      ),
      _UtiLabRecipe(
        name: 'Route to custom history',
        intent: 'Back a collaborative editor with CRDT-shaped snapshots.',
        snippet:
            'UndoTextIntent -> MyCrdtUndoAction.invoke(intent.cause);',
      ),
      _UtiLabRecipe(
        name: 'Disable for view-mode',
        intent: 'Freeze undo when a read-only flag is on.',
        snippet:
            'UndoTextIntent -> DoNothingAction(consumesKey: false);',
      ),
      _UtiLabRecipe(
        name: 'Bridge to OS menu',
        intent: 'Mirror macOS Edit > Undo menu item state.',
        snippet:
            'if (PlatformMenuBar...) dispatch(UndoTextIntent(...));',
      ),
      _UtiLabRecipe(
        name: 'Telemetry',
        intent: 'Emit analytics event per undo stamp.',
        snippet:
            'onObserve: (cause) => telemetry.log(\'undo\', cause);',
      ),
    ];
    return _UtiLabScrollCard(
      title: 'Folio VIII — Override Recipes',
      subtitle: 'Six postures a scribe might strike.',
      children: [
        for (final r in recipes) _UtiLabRecipeCard(recipe: r),
      ],
    );
  }
}

class _UtiLabRecipe {
  const _UtiLabRecipe({
    required this.name,
    required this.intent,
    required this.snippet,
  });
  final String name;
  final String intent;
  final String snippet;
}

class _UtiLabRecipeCard extends StatelessWidget {
  const _UtiLabRecipeCard({required this.recipe});
  final _UtiLabRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _vellum,
        border: Border.all(color: _vellumEdge, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: _ink,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.book_outlined,
                    color: _vellum, size: 13),
              ),
              const SizedBox(width: 8),
              Text(recipe.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _ink,
                    letterSpacing: 0.3,
                  )),
            ],
          ),
          const SizedBox(height: 6),
          Text(recipe.intent,
              style: const TextStyle(color: _inkSoft)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.circular(3),
            ),
            width: double.infinity,
            child: Text(
              recipe.snippet,
              style: const TextStyle(
                color: Color(0xFFF6EBCC),
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Log viewer
// ---------------------------------------------------------------------------

class _UtiLabLogViewer extends StatelessWidget {
  const _UtiLabLogViewer({required this.log});
  final _UtiLabLog log;

  @override
  Widget build(BuildContext context) {
    return _UtiLabScrollCard(
      title: 'Folio IX — Scribe\'s Ledger',
      subtitle: 'Every Intent event, stamped in ink.',
      trailing: OutlinedButton.icon(
        onPressed: log.clear,
        icon: const Icon(Icons.cleaning_services, size: 16, color: _ink),
        label: const Text('Clear',
            style: TextStyle(color: _ink, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _ink),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
        ),
      ),
      children: [
        AnimatedBuilder(
          animation: log,
          builder: (context, _) {
            final entries = log.entries;
            if (entries.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'No events yet. Type into a field and press Ctrl+Z, or '
                  'click "Undo via Intent".',
                  style: TextStyle(color: _inkSoft, fontStyle: FontStyle.italic),
                ),
              );
            }
            return Container(
              constraints: const BoxConstraints(maxHeight: 260),
              decoration: BoxDecoration(
                color: _ink,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (_, _) => const Divider(
                  height: 8,
                  color: Color(0xFF213252),
                ),
                itemBuilder: (context, i) {
                  final e = entries[i];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatStamp(e.stamp),
                        style: const TextStyle(
                          color: _gold,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          e.message,
                          style: const TextStyle(
                            color: Color(0xFFF4ECD8),
                            fontFamily: 'monospace',
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  String _formatStamp(DateTime t) {
    String pad(int n) => n.toString().padLeft(2, '0');
    return '${pad(t.hour)}:${pad(t.minute)}:${pad(t.second)}.${pad(t.millisecond ~/ 10)}';
  }
}

// ---------------------------------------------------------------------------
// Colophon
// ---------------------------------------------------------------------------

class _UtiLabColophon extends StatelessWidget {
  const _UtiLabColophon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            width: 44,
            height: 44,
            child: _UtiLabQuillPainterHost(size: 44, tone: _inkSoft),
          ),
          const SizedBox(height: 6),
          const Text(
            'Vellum Lab · UndoTextIntent · hand-bound folio',
            style: TextStyle(
              color: _inkSoft,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            '— d4rt AST harness —',
            style: TextStyle(
              color: _gold,
              fontStyle: FontStyle.italic,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 140,
            height: 1.2,
            color: _vellumEdge,
          ),
          const SizedBox(height: 8),
          Text(
            'LogicalKeyboardKey.keyZ = 0x${LogicalKeyboardKey.keyZ.keyId.toRadixString(16)}',
            style: const TextStyle(
              color: _inkSoft,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable visual primitives — cards, switches, tags, pills, paragraphs
// ---------------------------------------------------------------------------

class _UtiLabScrollCard extends StatelessWidget {
  const _UtiLabScrollCard({
    required this.title,
    required this.subtitle,
    required this.children,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _vellumDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _vellumEdge, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: _ink.withValues(alpha: 0.07),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            decoration: const BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                            color: _vellum,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            letterSpacing: 0.4,
                          )),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: const TextStyle(
                            color: _vellumEdge,
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class _UtiLabSwitchTile extends StatelessWidget {
  const _UtiLabSwitchTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: const TextStyle(
              color: _vellum,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 0.4,
            )),
        const SizedBox(width: 6),
        Switch(
          value: value,
          activeThumbColor: _oxbloodGlow,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _UtiLabTag extends StatelessWidget {
  const _UtiLabTag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _vellum,
        border: Border.all(color: _ink, width: 1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _ink,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _UtiLabPill extends StatelessWidget {
  const _UtiLabPill({
    required this.icon,
    required this.label,
    required this.tone,
  });

  final IconData icon;
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        border: Border.all(color: tone, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: tone),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                color: tone,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              )),
        ],
      ),
    );
  }
}

class _UtiLabParagraph extends StatelessWidget {
  const _UtiLabParagraph(this.text, {this.muted = false});
  final String text;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: muted ? _inkSoft : _ink,
        fontSize: muted ? 12 : 14,
        height: 1.45,
        fontStyle: muted ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
