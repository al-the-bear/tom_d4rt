// Deep visual demo for UpdateSelectionIntent — a laboratory for text selection
// mutation via Flutter's Actions/Intents pipeline.
//
// This file is consumed by the d4rt AST harness. It exposes a single
// top-level `build(BuildContext)` function and uses only widget-level APIs.
// No `main()`, no `runApp()`, no `flutter_test` — the harness renders the
// returned widget tree directly.
//
// Theme: laboratory — cool white, brushed-steel grey, teal accents, black
// serifed labels. A CustomPainter draws petri-dish glyphs; the demo offers
// seven discrete scenarios that together illustrate what
// `UpdateSelectionIntent` is, how it travels through the Actions tree, and
// how callers can override the default `UpdateSelectionAction`.
//
// Class under study:
//   class UpdateSelectionIntent extends Intent {
//     const UpdateSelectionIntent(
//       this.currentTextEditingValue,
//       this.newSelection,
//       this.cause,
//     );
//     final TextEditingValue currentTextEditingValue;
//     final TextSelection   newSelection;
//     final SelectionChangedCause cause;
//   }
// Source: flutter/lib/src/widgets/text_editing_intents.dart (Flutter 3.x).

import 'package:flutter/material.dart';

// ───────────────────────────────────────────────────────────────────────────
// Laboratory palette
// ───────────────────────────────────────────────────────────────────────────
const Color _usiLabPaper = Color(0xFFF6F8FA);
const Color _usiLabPaperDeep = Color(0xFFE7ECEF);
const Color _usiLabSteel = Color(0xFF8A97A1);
const Color _usiLabSteelDeep = Color(0xFF566573);
const Color _usiLabInk = Color(0xFF0B1116);
const Color _usiLabInkSoft = Color(0xFF394451);
const Color _usiLabTeal = Color(0xFF1EA7A1);
const Color _usiLabTealDeep = Color(0xFF0E6B68);
const Color _usiLabTealPale = Color(0xFFCFEDEB);
const Color _usiLabAmber = Color(0xFFCF8A00);
const Color _usiLabRose = Color(0xFFB53A5B);
const Color _usiLabViolet = Color(0xFF6C4AB6);
const Color _usiLabDivider = Color(0xFFD6DBE0);

// ───────────────────────────────────────────────────────────────────────────
// Small type helpers (named as a consistent typographic system)
// ───────────────────────────────────────────────────────────────────────────
const TextStyle _usiLabSerif = TextStyle(
  fontFamily: 'Georgia',
  color: _usiLabInk,
  fontWeight: FontWeight.w700,
);

const TextStyle _usiLabSans = TextStyle(
  fontFamily: 'Helvetica',
  color: _usiLabInkSoft,
);

const TextStyle _usiLabMono = TextStyle(
  fontFamily: 'Courier',
  color: _usiLabInk,
  height: 1.35,
);

// ───────────────────────────────────────────────────────────────────────────
// Petri-dish glyph painter — purely decorative
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabPetriPainter extends CustomPainter {
  const _UsiLabPetriPainter({
    required this.seed,
    required this.tone,
  });

  final int seed;
  final Color tone;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ring = Paint()
      ..color = (tone ?? const Color(0xFF000000)).withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Paint fill = Paint()
      ..color = (tone ?? const Color(0xFF000000)).withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;
    final Offset c = Offset(size.width / 2, size.height / 2);
    final double r = size.shortestSide / 2 - 2;
    canvas.drawCircle(c, r, fill);
    canvas.drawCircle(c, r, ring);
    // colony dots
    final int n = 6 + (seed % 7);
    for (int i = 0; i < n; i++) {
      final double t = (seed * 17 + i * 29) % 360 * 3.14159 / 180.0;
      final double radius = (r * 0.65) * (((seed * 7 + i * 11) % 100) / 100.0);
      final Offset p = Offset(
        c.dx + radius * _cos(t),
        c.dy + radius * _sin(t),
      );
      final Paint dot = Paint()
        ..color = (tone ?? const Color(0xFF000000)).withValues(alpha: 0.55)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(p, 1.8 + (i % 3) * 0.6, dot);
    }
    // crosshair
    final Paint cross = Paint()
      ..color = (tone ?? const Color(0xFF000000)).withValues(alpha: 0.35)
      ..strokeWidth = 0.8;
    canvas.drawLine(Offset(c.dx - r, c.dy), Offset(c.dx + r, c.dy), cross);
    canvas.drawLine(Offset(c.dx, c.dy - r), Offset(c.dx, c.dy + r), cross);
  }

  // tiny polynomial cos/sin approximations so we avoid importing dart:math
  // (the harness tolerates dart:math, but this keeps the file self contained
  // and analyzer-clean regardless of execution sandbox).
  double _cos(double x) {
    while (x > 3.14159) {
      x -= 6.28318;
    }
    while (x < -3.14159) {
      x += 6.28318;
    }
    final double x2 = x * x;
    return 1 - x2 / 2 + x2 * x2 / 24 - x2 * x2 * x2 / 720;
  }

  double _sin(double x) {
    while (x > 3.14159) {
      x -= 6.28318;
    }
    while (x < -3.14159) {
      x += 6.28318;
    }
    final double x2 = x * x;
    return x - x * x2 / 6 + x * x2 * x2 / 120 - x * x2 * x2 * x2 / 5040;
  }

  @override
  bool shouldRepaint(covariant _UsiLabPetriPainter oldDelegate) =>
      oldDelegate.seed != seed || oldDelegate.tone != tone;
}

// ───────────────────────────────────────────────────────────────────────────
// Selection ribbon painter — draws old→new selection shift
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabRibbonPainter extends CustomPainter {
  const _UsiLabRibbonPainter({
    required this.fromBase,
    required this.fromExtent,
    required this.toBase,
    required this.toExtent,
    required this.totalLength,
  });

  final int fromBase;
  final int fromExtent;
  final int toBase;
  final int toExtent;
  final int totalLength;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint track = Paint()
      ..color = _usiLabDivider
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final Paint oldBand = Paint()
      ..color = (_usiLabSteel ?? const Color(0xFF000000)).withValues(alpha: 0.7)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final Paint newBand = Paint()
      ..color = _usiLabTeal
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final double midY = size.height / 2;
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), track);

    final double safeTotal = totalLength == 0 ? 1.0 : totalLength.toDouble();
    final double oa = size.width * (fromBase.clamp(0, totalLength) / safeTotal);
    final double ob =
        size.width * (fromExtent.clamp(0, totalLength) / safeTotal);
    final double na = size.width * (toBase.clamp(0, totalLength) / safeTotal);
    final double nb =
        size.width * (toExtent.clamp(0, totalLength) / safeTotal);

    canvas.drawLine(Offset(oa, midY - 6), Offset(ob, midY - 6), oldBand);
    canvas.drawLine(Offset(na, midY + 6), Offset(nb, midY + 6), newBand);

    // markers
    final Paint tick = Paint()..color = _usiLabInk;
    canvas.drawCircle(Offset(na, midY + 6), 2.5, tick);
    canvas.drawCircle(Offset(nb, midY + 6), 2.5, tick);
  }

  @override
  bool shouldRepaint(covariant _UsiLabRibbonPainter old) =>
      old.fromBase != fromBase ||
      old.fromExtent != fromExtent ||
      old.toBase != toBase ||
      old.toExtent != toExtent ||
      old.totalLength != totalLength;
}

// ───────────────────────────────────────────────────────────────────────────
// Small primitive widgets — shared between scenarios
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabScaffoldBg extends StatelessWidget {
  const _UsiLabScaffoldBg({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_usiLabPaper, _usiLabPaperDeep],
        ),
      ),
      child: child,
    );
  }
}

class _UsiLabBadge extends StatelessWidget {
  const _UsiLabBadge({required this.label, required this.tone});
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.14),
        border: Border.all(color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: _usiLabMono.copyWith(fontSize: 11, color: tone),
      ),
    );
  }
}

class _UsiLabPanel extends StatelessWidget {
  const _UsiLabPanel({
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _usiLabDivider, width: 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: (_usiLabSteel ?? const Color(0xFF000000)).withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: _usiLabDivider),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: CustomPaint(
                    painter: _UsiLabPetriPainter(
                      seed: title.hashCode,
                      tone: _usiLabTealDeep,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: _usiLabSerif.copyWith(fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: _usiLabSans.copyWith(fontSize: 12)),
                    ],
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _UsiLabKeyValue extends StatelessWidget {
  const _UsiLabKeyValue({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
  static const Color tone = _usiLabTealDeep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(label,
                style: _usiLabSans.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _usiLabSteelDeep,
                )),
          ),
          Expanded(
            child: Text(value,
                style: _usiLabMono.copyWith(fontSize: 12.5, color: tone)),
          ),
        ],
      ),
    );
  }
}

class _UsiLabDivider extends StatelessWidget {
  const _UsiLabDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1, color: _usiLabDivider),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Scenario 1: Preamble anatomy card
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabPreamble extends StatelessWidget {
  const _UsiLabPreamble();

  @override
  Widget build(BuildContext context) {
    return _UsiLabPanel(
      title: 'Anatomy of UpdateSelectionIntent',
      subtitle: 'The three fields that describe a selection mutation',
      trailing: const _UsiLabBadge(label: 'widgets', tone: _usiLabTeal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _UsiLabKeyValue(
            label: 'Signature',
            value:
                'UpdateSelectionIntent(currentTextEditingValue, newSelection, cause)',
          ),
          _UsiLabKeyValue(
            label: 'currentTextEditingValue',
            value:
                'TextEditingValue — the pre-change text + selection snapshot.',
          ),
          _UsiLabKeyValue(
            label: 'newSelection',
            value:
                'TextSelection — the target {base, extent, affinity} the action should adopt.',
          ),
          _UsiLabKeyValue(
            label: 'cause',
            value:
                'SelectionChangedCause — describes the user interaction that triggered it.',
          ),
          _UsiLabDivider(),
          _UsiLabKeyValue(
            label: 'Default action',
            value:
                'UpdateSelectionAction — inside EditableTextState, routes to _value via controller.',
          ),
          _UsiLabKeyValue(
            label: 'Propagation',
            value:
                'Actions.maybeInvoke<UpdateSelectionIntent>(context, intent)',
          ),
          _UsiLabKeyValue(
            label: 'Common callers',
            value:
                'Keyboard shortcuts, IME events, stylus handwriting, accessibility tools.',
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Scenario 2: Lab TextField with Selection Microscope panel + custom action
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabEvent {
  _UsiLabEvent({
    required this.cause,
    required this.fromBase,
    required this.fromExtent,
    required this.toBase,
    required this.toExtent,
    required this.textLength,
    required this.timestamp,
  });

  final SelectionChangedCause cause;
  final int fromBase;
  final int fromExtent;
  final int toBase;
  final int toExtent;
  final int textLength;
  final DateTime timestamp;
}

class _UsiLabLaboratory extends StatefulWidget {
  const _UsiLabLaboratory();

  @override
  State<_UsiLabLaboratory> createState() => _UsiLabLaboratoryState();
}

class _UsiLabLaboratoryState extends State<_UsiLabLaboratory> {
  final TextEditingController _controller = TextEditingController(
    text:
        'Flutter text editing intents travel through the Actions tree; '
        'UpdateSelectionIntent is the canonical way to mutate caret and range.',
  );
  final FocusNode _focusNode = FocusNode();
  final List<_UsiLabEvent> _events = <_UsiLabEvent>[];

  bool _interceptEnabled = true;
  bool _shoutOnFire = true;
  SelectionChangedCause _selectedCause = SelectionChangedCause.keyboard;
  double _baseSlider = 0;
  double _extentSlider = 7;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_syncSliders);
    _syncSliders();
  }

  @override
  void dispose() {
    _controller.removeListener(_syncSliders);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _syncSliders() {
    final TextSelection sel = _controller.selection;
    if (sel.baseOffset >= 0) {
      _baseSlider = sel.baseOffset.toDouble();
      _extentSlider = sel.extentOffset.toDouble();
    }
  }

  void _logEvent(UpdateSelectionIntent intent, TextSelection old) {
    _events.insert(
      0,
      _UsiLabEvent(
        cause: intent.cause,
        fromBase: old.baseOffset.clamp(0, intent.currentTextEditingValue.text.length),
        fromExtent:
            old.extentOffset.clamp(0, intent.currentTextEditingValue.text.length),
        toBase: intent.newSelection.baseOffset
            .clamp(0, intent.currentTextEditingValue.text.length),
        toExtent: intent.newSelection.extentOffset
            .clamp(0, intent.currentTextEditingValue.text.length),
        textLength: intent.currentTextEditingValue.text.length,
        timestamp: DateTime.now(),
      ),
    );
    if (_events.length > 12) {
      _events.removeRange(12, _events.length);
    }
    if (_shoutOnFire) {
      debugPrint(
        '[UsiLab] intent cause=${intent.cause.name} '
        'old=${old.baseOffset}..${old.extentOffset} '
        'new=${intent.newSelection.baseOffset}..${intent.newSelection.extentOffset}',
      );
    }
  }

  void _fireIntent(TextSelection target, SelectionChangedCause cause) {
    final TextSelection old = _controller.selection;
    final TextEditingValue value = _controller.value;
    final UpdateSelectionIntent intent = UpdateSelectionIntent(value, target, cause);
    // Direct controller mutation is fine for demo — we also route through
    // Actions so the instrumented CallbackAction fires.
    Actions.maybeInvoke<UpdateSelectionIntent>(context, intent);
    _controller.selection = target;
    setState(() {
      _logEvent(intent, old);
    });
  }

  TextSelection _clamp(TextSelection sel) {
    final int len = _controller.text.length;
    return TextSelection(
      baseOffset: sel.baseOffset.clamp(0, len),
      extentOffset: sel.extentOffset.clamp(0, len),
      affinity: sel.affinity,
      isDirectional: sel.isDirectional,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        UpdateSelectionIntent: CallbackAction<UpdateSelectionIntent>(
          onInvoke: (UpdateSelectionIntent intent) {
            if (_interceptEnabled) {
              final TextSelection old = _controller.selection;
              _logEvent(intent, old);
            }
            return null;
          },
        ),
      },
      child: _UsiLabPanel(
        title: 'Laboratory TextField',
        subtitle:
            'A big input plus a microscope panel that reads TextSelection live',
        trailing: _UsiLabBadge(
          label: 'active: ${_interceptEnabled ? 'yes' : 'no'}',
          tone: _usiLabTealDeep,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(),
            const SizedBox(height: 12),
            _buildMicroscope(),
            const _UsiLabDivider(),
            _buildManualControls(),
            const _UsiLabDivider(),
            _buildProgrammer(),
            const _UsiLabDivider(),
            _buildCauseRow(),
            const _UsiLabDivider(),
            _buildObserverStrip(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _usiLabPaper,
        border: Border.all(color: (_usiLabSteel ?? const Color(0xFF000000)).withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLines: 4,
        minLines: 3,
        style: _usiLabMono.copyWith(fontSize: 14, color: _usiLabInk),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: (_usiLabSteelDeep ?? const Color(0xFF000000)).withValues(alpha: 0.6)),
            borderRadius: BorderRadius.circular(6),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Type, select, and watch the microscope update…',
          hintStyle: _usiLabSans.copyWith(fontSize: 13),
          labelStyle: _usiLabSans,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        onChanged: (String _) => setState(() {}),
        onTap: () => setState(() {
          debugPrint('[UsiLab] TextField tap; focusNode=${_focusNode.hasFocus}');
        }),
      ),
    );
  }

  Widget _buildMicroscope() {
    final TextSelection sel = _controller.selection;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _usiLabPaperDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _usiLabDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('Selection Microscope',
                  style: _usiLabSerif.copyWith(fontSize: 14)),
              const Spacer(),
              _UsiLabBadge(label: 'length=${_controller.text.length}', tone: _usiLabTeal),
            ],
          ),
          const SizedBox(height: 8),
          _UsiLabKeyValue(label: 'base', value: '${sel.baseOffset}'),
          _UsiLabKeyValue(label: 'extent', value: '${sel.extentOffset}'),
          _UsiLabKeyValue(label: 'affinity', value: sel.affinity.name),
          _UsiLabKeyValue(
              label: 'isCollapsed', value: '${sel.isCollapsed}'),
          _UsiLabKeyValue(
              label: 'isDirectional', value: '${sel.isDirectional}'),
          _UsiLabKeyValue(
              label: 'selected text',
              value: sel.isValid && !sel.isCollapsed
                  ? '"${sel.textInside(_controller.text)}"'
                  : '<collapsed caret>'),
        ],
      ),
    );
  }

  Widget _buildManualControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Manual invocation', style: _usiLabSerif.copyWith(fontSize: 14)),
        const SizedBox(height: 6),
        Text(
          'Each button constructs an UpdateSelectionIntent and routes it through '
          'Actions.maybeInvoke<UpdateSelectionIntent>(context, intent).',
          style: _usiLabSans.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _pillButton('caret ← 1', () => _moveCaret(-1)),
            _pillButton('caret → 1', () => _moveCaret(1)),
            _pillButton('← word', () => _moveWord(-1)),
            _pillButton('→ word', () => _moveWord(1)),
            _pillButton('home', _moveHome),
            _pillButton('end', _moveEnd),
            _pillButton('select word', _selectWord),
            _pillButton('select line', _selectLine),
            _pillButton('select all', _selectAll),
            _pillButton('collapse', _collapseToBase),
          ],
        ),
      ],
    );
  }

  Widget _buildProgrammer() {
    final int len = _controller.text.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Selection programmer',
            style: _usiLabSerif.copyWith(fontSize: 14)),
        const SizedBox(height: 6),
        Text(
          'Use sliders to precisely set base/extent and fire an intent with '
          'the currently-selected SelectionChangedCause.',
          style: _usiLabSans.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 8),
        _sliderRow('base', _baseSlider, len, (double v) {
          setState(() => _baseSlider = v);
        }),
        _sliderRow('extent', _extentSlider, len, (double v) {
          setState(() => _extentSlider = v);
        }),
        const SizedBox(height: 6),
        Row(
          children: [
            _pillButton('apply', _applyProgrammer),
            const SizedBox(width: 8),
            _pillButton('reset', () {
              setState(() {
                _baseSlider = 0;
                _extentSlider = 0;
              });
            }),
            const Spacer(),
            Text('→ cause: ${_selectedCause.name}',
                style: _usiLabMono.copyWith(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _sliderRow(String label, double value, int max,
      ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(label,
                style: _usiLabSans.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: _usiLabTealDeep,
                inactiveTrackColor: _usiLabDivider,
                thumbColor: _usiLabTeal,
                overlayColor: (_usiLabTeal ?? const Color(0xFF000000)).withValues(alpha: 0.18),
              ),
              child: Slider(
                value: value.clamp(0, max == 0 ? 1 : max).toDouble(),
                min: 0,
                max: (max == 0 ? 1 : max).toDouble(),
                divisions: max == 0 ? 1 : max,
                label: value.toInt().toString(),
                onChanged: onChanged,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(value.toInt().toString(),
                textAlign: TextAlign.right,
                style: _usiLabMono.copyWith(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildCauseRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Cause showcase', style: _usiLabSerif.copyWith(fontSize: 14)),
        const SizedBox(height: 6),
        Text(
          'Fire the same selection change with different SelectionChangedCause values '
          'and inspect how consumers can differentiate sources.',
          style: _usiLabSans.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            for (final SelectionChangedCause cause in SelectionChangedCause.values)
              _causeChip(cause),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Active cause:', style: _usiLabSans),
            const SizedBox(width: 8),
            _UsiLabBadge(
                label: _selectedCause.name, tone: _causeColor(_selectedCause)),
            const Spacer(),
            Row(
              children: [
                const Text('intercept', style: _usiLabSans),
                Switch(
                  value: _interceptEnabled,
                  onChanged: (bool v) =>
                      setState(() => _interceptEnabled = v),
                  activeThumbColor: _usiLabTealDeep,
                ),
                const SizedBox(width: 8),
                const Text('debugPrint', style: _usiLabSans),
                Switch(
                  value: _shoutOnFire,
                  onChanged: (bool v) => setState(() => _shoutOnFire = v),
                  activeThumbColor: _usiLabAmber,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _causeChip(SelectionChangedCause cause) {
    final bool active = _selectedCause == cause;
    final Color tone = _causeColor(cause);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => setState(() => _selectedCause = cause),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: active ? tone : Colors.white,
          border: Border.all(color: tone),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          cause.name,
          style: _usiLabMono.copyWith(
            fontSize: 11.5,
            color: active ? Colors.white : tone,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Color _causeColor(SelectionChangedCause cause) {
    switch (cause) {
      case SelectionChangedCause.tap:
        return _usiLabTealDeep;
      case SelectionChangedCause.doubleTap:
        return _usiLabViolet;
      case SelectionChangedCause.longPress:
        return _usiLabAmber;
      case SelectionChangedCause.forcePress:
        return _usiLabRose;
      case SelectionChangedCause.keyboard:
        return _usiLabSteelDeep;
      case SelectionChangedCause.toolbar:
        return _usiLabInkSoft;
      case SelectionChangedCause.drag:
        return _usiLabTeal;
      case SelectionChangedCause.stylusHandwriting:
        return _usiLabVioletDark;
    }
  }

  Widget _buildObserverStrip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('Observer strip', style: _usiLabSerif.copyWith(fontSize: 14)),
            const Spacer(),
            _UsiLabBadge(label: 'events=${_events.length}', tone: _usiLabTeal),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Each row shows a recent intent fire. The twin ribbon visualises '
          'old (grey) vs new (teal) selection positions on the text track.',
          style: _usiLabSans.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 10),
        if (_events.isEmpty)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _usiLabPaperDeep,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _usiLabDivider),
            ),
            child: Text(
              'No events yet — move the caret, drag, or apply the programmer.',
              style: _usiLabSans.copyWith(fontSize: 12),
            ),
          )
        else
          Column(
            children: [
              for (final _UsiLabEvent ev in _events) _eventRow(ev),
            ],
          ),
      ],
    );
  }

  Widget _eventRow(_UsiLabEvent ev) {
    final Color tone = _causeColor(ev.cause);
    final String ts =
        '${ev.timestamp.hour.toString().padLeft(2, '0')}:${ev.timestamp.minute.toString().padLeft(2, '0')}:${ev.timestamp.second.toString().padLeft(2, '0')}';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _usiLabDivider),
      ),
      child: Row(
        children: [
          _UsiLabBadge(label: ev.cause.name, tone: tone),
          const SizedBox(width: 10),
          SizedBox(
            width: 72,
            child: Text(ts,
                style: _usiLabMono.copyWith(fontSize: 11, color: _usiLabSteelDeep)),
          ),
          Expanded(
            child: SizedBox(
              height: 24,
              child: CustomPaint(
                painter: _UsiLabRibbonPainter(
                  fromBase: ev.fromBase,
                  fromExtent: ev.fromExtent,
                  toBase: ev.toBase,
                  toExtent: ev.toExtent,
                  totalLength: ev.textLength,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${ev.fromBase}..${ev.fromExtent} → ${ev.toBase}..${ev.toExtent}',
            style: _usiLabMono.copyWith(fontSize: 11.5),
          ),
        ],
      ),
    );
  }

  Widget _pillButton(String label, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _usiLabTealDeep),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: (_usiLabTealDeep ?? const Color(0xFF000000)).withValues(alpha: 0.15),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          label,
          style: _usiLabMono.copyWith(
            fontSize: 12,
            color: _usiLabTealDeep,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ── Manual movement helpers ────────────────────────────────────────────
  void _moveCaret(int delta) {
    final TextSelection s = _controller.selection;
    final int cursor = s.extentOffset < 0 ? 0 : s.extentOffset;
    final int target = (cursor + delta).clamp(0, _controller.text.length);
    _fireIntent(
      TextSelection.collapsed(offset: target),
      SelectionChangedCause.keyboard,
    );
  }

  void _moveWord(int direction) {
    final String text = _controller.text;
    final int cursor = _controller.selection.extentOffset < 0
        ? 0
        : _controller.selection.extentOffset;
    int target = cursor;
    if (direction < 0) {
      int i = cursor - 1;
      while (i > 0 && _isWordChar(text, i - 1)) {
        i--;
      }
      target = i < 0 ? 0 : i;
    } else {
      int i = cursor;
      while (i < text.length && _isWordChar(text, i)) {
        i++;
      }
      while (i < text.length && !_isWordChar(text, i)) {
        i++;
      }
      target = i > text.length ? text.length : i;
    }
    _fireIntent(
      TextSelection.collapsed(offset: target),
      SelectionChangedCause.keyboard,
    );
  }

  bool _isWordChar(String s, int i) {
    if (i < 0 || i >= s.length) return false;
    final int code = s.codeUnitAt(i);
    final bool letter = (code >= 0x41 && code <= 0x5A) ||
        (code >= 0x61 && code <= 0x7A);
    final bool digit = code >= 0x30 && code <= 0x39;
    return letter || digit || code == 0x5F;
  }

  void _moveHome() {
    _fireIntent(const TextSelection.collapsed(offset: 0),
        SelectionChangedCause.keyboard);
  }

  void _moveEnd() {
    _fireIntent(
      TextSelection.collapsed(offset: _controller.text.length),
      SelectionChangedCause.keyboard,
    );
  }

  void _selectWord() {
    final String text = _controller.text;
    final int cursor = _controller.selection.extentOffset < 0
        ? 0
        : _controller.selection.extentOffset;
    int a = cursor;
    int b = cursor;
    while (a > 0 && _isWordChar(text, a - 1)) {
      a--;
    }
    while (b < text.length && _isWordChar(text, b)) {
      b++;
    }
    _fireIntent(
      TextSelection(baseOffset: a, extentOffset: b),
      SelectionChangedCause.doubleTap,
    );
  }

  void _selectLine() {
    _fireIntent(
      TextSelection(baseOffset: 0, extentOffset: _controller.text.length),
      SelectionChangedCause.tap,
    );
  }

  void _selectAll() {
    _fireIntent(
      TextSelection(baseOffset: 0, extentOffset: _controller.text.length),
      SelectionChangedCause.toolbar,
    );
  }

  void _collapseToBase() {
    final int b = _controller.selection.baseOffset < 0
        ? 0
        : _controller.selection.baseOffset;
    _fireIntent(
      TextSelection.collapsed(offset: b),
      SelectionChangedCause.keyboard,
    );
  }

  void _applyProgrammer() {
    final int len = _controller.text.length;
    final TextSelection target = _clamp(TextSelection(
      baseOffset: _baseSlider.toInt().clamp(0, len),
      extentOffset: _extentSlider.toInt().clamp(0, len),
    ));
    _fireIntent(target, _selectedCause);
  }
}

// A distinct tone so stylusHandwriting maps to a dedicated color.
const Color _usiLabVioletDark = Color(0xFF3E2F82);

// ───────────────────────────────────────────────────────────────────────────
// Scenario 3: Epilogue — recipe cards
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabRecipe {
  const _UsiLabRecipe({
    required this.title,
    required this.summary,
    required this.code,
    required this.note,
    required this.tone,
  });

  final String title;
  final String summary;
  final String code;
  final String note;
  final Color tone;
}

class _UsiLabEpilogue extends StatelessWidget {
  const _UsiLabEpilogue();

  static const List<_UsiLabRecipe> _recipes = <_UsiLabRecipe>[
    _UsiLabRecipe(
      title: 'Recipe 1 — Log every selection mutation',
      summary:
          'Wrap a subtree in Actions that intercepts UpdateSelectionIntent '
          'and forwards to the default action.',
      code: 'Actions(\n'
          '  actions: {\n'
          '    UpdateSelectionIntent: CallbackAction<UpdateSelectionIntent>(\n'
          '      onInvoke: (i) {\n'
          '        debugPrint("[sel] \${i.cause} -> \${i.newSelection}");\n'
          '        return null; // fall through to parent\n'
          '      },\n'
          '    ),\n'
          '  },\n'
          '  child: EditableText(...),\n'
          ');',
      note:
          'Returning null lets Actions.invoke continue up the tree when the\n'
          'next nearest action wants to handle it (chained behaviour).',
      tone: _usiLabTealDeep,
    ),
    _UsiLabRecipe(
      title: 'Recipe 2 — Veto a selection mutation',
      summary:
          'Use Action.overridable so your action becomes the primary handler '
          'and can decide whether to consume the intent.',
      code: 'class _GuardedSelectionAction\n'
          '    extends Action<UpdateSelectionIntent> {\n'
          '  @override\n'
          '  Object? invoke(UpdateSelectionIntent intent) {\n'
          '    if (intent.newSelection.isCollapsed) {\n'
          '      return null; // swallow: disallow caret moves\n'
          '    }\n'
          '    // defer to default UpdateSelectionAction\n'
          '    return controller.value = intent.currentTextEditingValue\n'
          '      .copyWith(selection: intent.newSelection);\n'
          '  }\n'
          '}',
      note:
          'Swallowing an intent breaks standard behaviour — only do this for\n'
          'deliberate UX constraints (e.g. read-only mode).',
      tone: _usiLabAmber,
    ),
    _UsiLabRecipe(
      title: 'Recipe 3 — Programmatic selection from outside',
      summary:
          'Dispatch UpdateSelectionIntent from application code (e.g. a '
          '"go to line" command).',
      code: 'void goToLine(BuildContext ctx, int offset, int len) {\n'
          '  final controller = ctx.read<TextEditingController>();\n'
          '  final intent = UpdateSelectionIntent(\n'
          '    controller.value,\n'
          '    TextSelection(baseOffset: offset, extentOffset: offset+len),\n'
          '    SelectionChangedCause.toolbar,\n'
          '  );\n'
          '  Actions.maybeInvoke<UpdateSelectionIntent>(ctx, intent);\n'
          '}',
      note:
          'Prefer maybeInvoke so callers do not crash if no Actions ancestor\n'
          'registered a handler.',
      tone: _usiLabViolet,
    ),
    _UsiLabRecipe(
      title: 'Recipe 4 — Respect the cause',
      summary:
          'When building custom text editors, branch on '
          'SelectionChangedCause to show toolbar, haptics, or accessibility hints.',
      code: 'void onSelectionChanged(\n'
          '    TextSelection sel, SelectionChangedCause? cause) {\n'
          '  switch (cause) {\n'
          '    case SelectionChangedCause.longPress:\n'
          '    case SelectionChangedCause.forcePress:\n'
          '      showMagnifier(sel);\n'
          '    case SelectionChangedCause.doubleTap:\n'
          '      showContextMenu(sel);\n'
          '    case _:\n'
          '      hideOverlays();\n'
          '  }\n'
          '}',
      note:
          'cause is informational — it does not alter the mutation itself,\n'
          'only your response to it.',
      tone: _usiLabRose,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _UsiLabPanel(
      title: 'Epilogue — Recipes',
      subtitle: 'Patterns for overriding, chaining and dispatching UpdateSelectionIntent',
      trailing: const _UsiLabBadge(label: 'advisory', tone: _usiLabAmber),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final _UsiLabRecipe r in _recipes) _recipeCard(r),
        ],
      ),
    );
  }

  Widget _recipeCard(_UsiLabRecipe r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _usiLabPaper,
        border: Border.all(color: (r.tone ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            decoration: BoxDecoration(
              color: (r.tone ?? const Color(0xFF000000)).withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(color: (r.tone ?? const Color(0xFF000000)).withValues(alpha: 0.3)),
              ),
            ),
            child: Row(
              children: [
                _UsiLabBadge(label: r.title.split(' — ').first, tone: r.tone),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    r.title.split(' — ').last,
                    style: _usiLabSerif.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(r.summary, style: _usiLabSans.copyWith(fontSize: 12.5)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _usiLabInk,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    r.code,
                    style: _usiLabMono.copyWith(
                        fontSize: 12, color: const Color(0xFFE8FFFB)),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline,
                        size: 16, color: r.tone),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        r.note,
                        style: _usiLabSans.copyWith(
                            fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Scenario 4: Footer — keyboard shortcut cheat sheet (reference only)
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabCheatSheet extends StatelessWidget {
  const _UsiLabCheatSheet();

  static const List<List<String>> _rows = <List<String>>[
    <String>['Ctrl/Cmd + A', 'select all', 'toolbar'],
    <String>['Ctrl/Cmd + Shift + ←/→', 'extend by word', 'keyboard'],
    <String>['Shift + ↑/↓', 'extend by line', 'keyboard'],
    <String>['Tap', 'collapse at caret', 'tap'],
    <String>['Double-tap', 'select word', 'doubleTap'],
    <String>['Long-press', 'magnifier + word', 'longPress'],
    <String>['3D Touch / force', 'peek-and-pop', 'forcePress'],
    <String>['Mouse drag', 'range select', 'drag'],
    <String>['Stylus scribble', 'inline edit', 'stylusHandwriting'],
  ];

  @override
  Widget build(BuildContext context) {
    return _UsiLabPanel(
      title: 'Cheat sheet — gestures & causes',
      subtitle:
          'How common text-editing gestures surface as SelectionChangedCause',
      trailing: const _UsiLabBadge(label: 'ref', tone: _usiLabSteelDeep),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text('gesture',
                      style: _usiLabSans.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w700))),
              Expanded(
                  flex: 4,
                  child: Text('effect',
                      style: _usiLabSans.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w700))),
              Expanded(
                  flex: 3,
                  child: Text('cause',
                      style: _usiLabSans.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w700))),
            ],
          ),
          const _UsiLabDivider(),
          for (final List<String> row in _rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(row[0],
                        style: _usiLabMono.copyWith(fontSize: 12)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(row[1],
                        style: _usiLabSans.copyWith(fontSize: 12)),
                  ),
                  Expanded(
                    flex: 3,
                    child: _UsiLabBadge(label: row[2], tone: _usiLabTeal),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Scenario 5: Diagram — how an intent travels through the Actions tree
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabFlowDiagram extends StatelessWidget {
  const _UsiLabFlowDiagram();

  static const List<_UsiLabFlowStep> _steps = <_UsiLabFlowStep>[
    _UsiLabFlowStep('user gesture',
        'tap / keyboard / drag / force press etc.', _usiLabSteelDeep),
    _UsiLabFlowStep('gesture recognizer',
        'EditableText selection handlers detect the gesture.', _usiLabTeal),
    _UsiLabFlowStep(
        'intent construction',
        'UpdateSelectionIntent(currentValue, newSelection, cause) is built.',
        _usiLabTealDeep),
    _UsiLabFlowStep(
        'Actions.maybeInvoke',
        'Walks the ancestor Actions widgets looking for a match on\nUpdateSelectionIntent.',
        _usiLabViolet),
    _UsiLabFlowStep(
        'first handler wins',
        'If an overridable action returns non-null, propagation stops; else the\ndefault action runs.',
        _usiLabAmber),
    _UsiLabFlowStep(
        'default UpdateSelectionAction',
        'EditableTextState._updateSelection mutates the controller\'s\nTextEditingValue and notifies listeners.',
        _usiLabRose),
    _UsiLabFlowStep(
        'onSelectionChanged',
        'Consumers observe the change; UI repaints selection handles.',
        _usiLabTealDeep),
  ];

  @override
  Widget build(BuildContext context) {
    return _UsiLabPanel(
      title: 'Flow — from gesture to caret',
      subtitle: 'Seven checkpoints that describe the intent\'s journey',
      trailing: const _UsiLabBadge(label: 'diagram', tone: _usiLabViolet),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < _steps.length; i++)
            _flowStepRow(i, _steps[i], i == _steps.length - 1),
        ],
      ),
    );
  }

  Widget _flowStepRow(int index, _UsiLabFlowStep step, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: step.tone,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (step.tone ?? const Color(0xFF000000)).withValues(alpha: 0.4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text('${index + 1}',
                    style: _usiLabMono.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800)),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: _usiLabDivider,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.title, style: _usiLabSerif.copyWith(fontSize: 14)),
                  const SizedBox(height: 3),
                  Text(step.description,
                      style: _usiLabSans.copyWith(fontSize: 12.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsiLabFlowStep {
  const _UsiLabFlowStep(this.title, this.description, this.tone);
  final String title;
  final String description;
  final Color tone;
}

// ───────────────────────────────────────────────────────────────────────────
// Scenario 6: Glossary — a long flat vocabulary list
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabGlossary extends StatelessWidget {
  const _UsiLabGlossary();

  static const List<List<String>> _terms = <List<String>>[
    <String>['TextEditingValue',
        'Immutable triple of {text, selection, composing}. Your controller\'s v.'],
    <String>['TextSelection',
        'A selection into TextEditingValue.text using base/extent offsets.'],
    <String>['base',
        'The offset where the user started selecting (anchor).'],
    <String>['extent',
        'The offset where the selection currently ends (caret).'],
    <String>['affinity',
        'upstream/downstream — disambiguates the same visual offset at a line-break.'],
    <String>['isCollapsed',
        'A collapsed selection equals a caret: base == extent.'],
    <String>['Intent',
        'A small marker class describing what the user wants, with no behaviour.'],
    <String>['Action<T>',
        'The behaviour that fires when an Intent of type T is invoked nearby.'],
    <String>['Actions widget',
        'Associates Intent types to Action instances for the subtree.'],
    <String>['Actions.maybeInvoke',
        'Safely dispatch; returns null if no nearby action matched.'],
    <String>['Actions.invoke',
        'Strict dispatch; asserts that an action exists.'],
    <String>['SelectionChangedCause',
        'Informational enum describing the origin of the selection change.'],
    <String>['CallbackAction<T>',
        'Convenience Action that delegates to an onInvoke callback.'],
    <String>['Action.overridable',
        'Construct override-friendly actions that defer to the default.'],
    <String>['UpdateSelectionAction',
        'The default handler inside EditableTextState.'],
    <String>['UpdateSelectionIntent',
        'Our class: the payload describing a selection mutation.'],
  ];

  @override
  Widget build(BuildContext context) {
    return _UsiLabPanel(
      title: 'Glossary',
      subtitle: 'Vocabulary used throughout this laboratory',
      trailing: const _UsiLabBadge(label: '16 terms', tone: _usiLabTealDeep),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final List<String> t in _terms) _glossaryRow(t[0], t[1]),
        ],
      ),
    );
  }

  Widget _glossaryRow(String term, String def) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(term,
                style: _usiLabMono.copyWith(
                    fontSize: 12.5, color: _usiLabTealDeep)),
          ),
          Expanded(
            child: Text(def, style: _usiLabSans.copyWith(fontSize: 12.5)),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Scenario 7: Comparison — UpdateSelectionIntent vs siblings
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabComparison extends StatelessWidget {
  const _UsiLabComparison();

  static const List<_UsiLabComparisonRow> _rows = <_UsiLabComparisonRow>[
    _UsiLabComparisonRow(
      name: 'UpdateSelectionIntent',
      carries: 'currentValue, newSelection, cause',
      notes: 'Directly sets the target selection.',
      tone: _usiLabTealDeep,
    ),
    _UsiLabComparisonRow(
      name: 'ExtendSelectionByCharacterIntent',
      carries: 'forward, collapseSelection',
      notes: 'Delta-based: moves caret by one character in a direction.',
      tone: _usiLabAmber,
    ),
    _UsiLabComparisonRow(
      name: 'ExtendSelectionByPageIntent',
      carries: 'forward',
      notes: 'Page-sized selection change (PgUp/PgDn).',
      tone: _usiLabViolet,
    ),
    _UsiLabComparisonRow(
      name: 'ExpandSelectionToLineBreakIntent',
      carries: 'forward',
      notes: 'Grows selection to the next newline boundary.',
      tone: _usiLabRose,
    ),
    _UsiLabComparisonRow(
      name: 'ReplaceTextIntent',
      carries: 'currentValue, replacementText, replacementRange, cause',
      notes: 'Inserts or replaces; may also change selection as a side effect.',
      tone: _usiLabSteelDeep,
    ),
    _UsiLabComparisonRow(
      name: 'CopySelectionTextIntent',
      carries: 'cause, collapseSelection',
      notes: 'Copies the currently-selected text; may collapse afterwards.',
      tone: _usiLabTeal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _UsiLabPanel(
      title: 'Comparison — intents in the family',
      subtitle: 'UpdateSelectionIntent vs sibling text-editing intents',
      trailing: const _UsiLabBadge(label: 'table', tone: _usiLabSteelDeep),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text('intent',
                      style: _usiLabSans.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w800))),
              Expanded(
                  flex: 4,
                  child: Text('fields',
                      style: _usiLabSans.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w800))),
              Expanded(
                  flex: 5,
                  child: Text('notes',
                      style: _usiLabSans.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w800))),
            ],
          ),
          const _UsiLabDivider(),
          for (final _UsiLabComparisonRow r in _rows) _row(r),
        ],
      ),
    );
  }

  Widget _row(_UsiLabComparisonRow r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: _UsiLabBadge(label: r.name, tone: r.tone),
          ),
          Expanded(
            flex: 4,
            child: Text(r.carries,
                style: _usiLabMono.copyWith(fontSize: 11.5)),
          ),
          Expanded(
            flex: 5,
            child:
                Text(r.notes, style: _usiLabSans.copyWith(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _UsiLabComparisonRow {
  const _UsiLabComparisonRow({
    required this.name,
    required this.carries,
    required this.notes,
    required this.tone,
  });

  final String name;
  final String carries;
  final String notes;
  final Color tone;
}

// ───────────────────────────────────────────────────────────────────────────
// Header banner (title + decorative dish)
// ───────────────────────────────────────────────────────────────────────────
class _UsiLabBanner extends StatelessWidget {
  const _UsiLabBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            (_usiLabTealPale ?? const Color(0xFF000000)).withValues(alpha: 0.55),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (_usiLabTealDeep ?? const Color(0xFF000000)).withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: (_usiLabTeal ?? const Color(0xFF000000)).withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: CustomPaint(
              painter: _UsiLabPetriPainter(
                seed: 12345,
                tone: _usiLabTealDeep,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('UpdateSelectionIntent — a laboratory',
                    style: _usiLabSerif.copyWith(fontSize: 22)),
                const SizedBox(height: 4),
                Text(
                  'Observe, mutate, chain, and veto text selection intents inside Flutter\'s Actions pipeline.',
                  style: _usiLabSans.copyWith(fontSize: 13.5),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: const [
                    _UsiLabBadge(label: 'Intent', tone: _usiLabTealDeep),
                    _UsiLabBadge(label: 'Actions', tone: _usiLabViolet),
                    _UsiLabBadge(label: 'EditableText', tone: _usiLabAmber),
                    _UsiLabBadge(label: 'SelectionChangedCause', tone: _usiLabRose),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Top-level build — the d4rt harness entry point
// ───────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // Keyboard shortcuts reference helps the analyzer keep 'services' in use.
  const Map<LogicalKeySet, Intent> demoShortcuts = <LogicalKeySet, Intent>{};
  assert(demoShortcuts.isEmpty, 'shortcuts are constant');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'UpdateSelectionIntent Lab',
    theme: ThemeData(
      scaffoldBackgroundColor: _usiLabPaper,
      dividerColor: _usiLabDivider,
      colorScheme: const ColorScheme.light(
        primary: _usiLabTealDeep,
        secondary: _usiLabAmber,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _usiLabInk,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _usiLabInk),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _usiLabInk,
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: _usiLabDivider)),
        title: Text(
          'UpdateSelectionIntent — deep demo',
          style: _usiLabSerif.copyWith(fontSize: 16, color: _usiLabInk),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: Center(
              child: _UsiLabBadge(label: 'flutter/widgets', tone: _usiLabTealDeep),
            ),
          ),
        ],
      ),
      body: const _UsiLabScaffoldBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _UsiLabBanner(),
                _UsiLabPreamble(),
                _UsiLabFlowDiagram(),
                _UsiLabLaboratory(),
                _UsiLabComparison(),
                _UsiLabCheatSheet(),
                _UsiLabEpilogue(),
                _UsiLabGlossary(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
