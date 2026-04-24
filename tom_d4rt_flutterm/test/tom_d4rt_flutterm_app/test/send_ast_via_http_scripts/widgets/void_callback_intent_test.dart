// Deep visual demo for Flutter's `VoidCallbackIntent`.
//
// `VoidCallbackIntent` is an `Intent` subclass whose payload is a bare
// `VoidCallback` — a zero-argument closure. Unlike most domain-specific
// intents, it carries its action with itself; the accompanying
// `VoidCallbackAction` is a thin shim whose `invoke(intent)` simply calls
// `intent.callback()`. This inversion makes VoidCallbackIntent ideal for:
//
//   * Testable callback dispatch from buttons and keyboard shortcuts.
//   * Routing named operations through an `Actions` scope.
//   * Wiring animations or focus-aware widgets without creating a bespoke
//     Action subclass for every verb.
//
// The demo below is a "Telegraph Operator's Desk" — a visual metaphor where
// each VoidCallbackIntent is an envelope carrying a small closure. A control
// panel dispatches envelopes into a brass-trimmed queue; an Actions scope
// (or, optionally, no scope) consumes them. The interpreter can observe the
// scene purely by inspecting the tree; there is no `main()` and no
// `runApp()` — only a top-level `build(BuildContext)` function, as required
// by the d4rt AST harness.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Palette & typography — telegraph operator's desk.
// ---------------------------------------------------------------------------

const Color _kDeskOak = Color(0xFF7A4A22);
const Color _kDeskOakDark = Color(0xFF5C3414);
const Color _kDeskOakLight = Color(0xFF9C6A3E);
const Color _kOliveFelt = Color(0xFF4E5A2A);
const Color _kOliveFeltDark = Color(0xFF333D18);
const Color _kBrass = Color(0xFFC9A24A);
const Color _kBrassBright = Color(0xFFE6C260);
const Color _kBrassDark = Color(0xFF8A6A20);
const Color _kTelegramPaper = Color(0xFFF7E9A6);
const Color _kTelegramPaperDark = Color(0xFFD7C778);
const Color _kInkBlack = Color(0xFF1A140A);
const Color _kInkDark = Color(0xFF2E241A);
const Color _kRedStamp = Color(0xFFB23A2A);
const Color _kGreenStamp = Color(0xFF2E6A3A);
const Color _kEnvelopeCream = Color(0xFFEFE2B8);
const Color _kEnvelopeShadow = Color(0xFFB59E60);

// ---------------------------------------------------------------------------
// Helper: a brass rivet used all over the demo.
// ---------------------------------------------------------------------------

class _VciDispatchRivet extends StatelessWidget {
  const _VciDispatchRivet({this.size = 10});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.3, -0.3),
          colors: <Color>[_kBrassBright, _kBrass, _kBrassDark],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        border: Border.all(color: _kInkBlack.withAlpha(120), width: 0.6),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Panel: a wooden-framed surface with brass rivets in each corner.
// ---------------------------------------------------------------------------

class _VciDispatchPanel extends StatelessWidget {
  const _VciDispatchPanel({
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  static const Color accent = _kBrass;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kDeskOakLight, _kDeskOak, _kDeskOakDark],
          stops: <double>[0.0, 0.45, 1.0],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDeskOakDark, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _kOliveFelt,
              border: Border(
                bottom: BorderSide(color: accent, width: 1.2),
              ),
            ),
            child: Row(
              children: <Widget>[
                const _VciDispatchRivet(),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: _kTelegramPaper,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                ?trailing,
                const SizedBox(width: 10),
                const _VciDispatchRivet(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section heading on yellow telegram paper.
// ---------------------------------------------------------------------------

class _VciDispatchHeading extends StatelessWidget {
  const _VciDispatchHeading(this.label, {this.stamp});

  final String label;
  final String? stamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 14, 18, 4),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: _kTelegramPaper,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kTelegramPaperDark, width: 1),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 6,
            height: 26,
            color: _kOliveFelt,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _kInkBlack,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
          if (stamp != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: _kRedStamp, width: 1.5),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                stamp!,
                style: const TextStyle(
                  color: _kRedStamp,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// A telegram paper block — used for explanatory body copy.
// ---------------------------------------------------------------------------

class _VciDispatchTelegram extends StatelessWidget {
  const _VciDispatchTelegram({
    required this.lines,
  });

  final List<String> lines;
  static const Color tint = _kTelegramPaper;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: _kTelegramPaperDark, width: 1),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int index = 0; index < lines.length; index++)
            Padding(
              padding: EdgeInsets.only(
                bottom: index == lines.length - 1 ? 0 : 6,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 10),
                    child: _VciDispatchDot(),
                  ),
                  Expanded(
                    child: Text(
                      lines[index],
                      style: const TextStyle(
                        color: _kInkDark,
                        fontSize: 13,
                        height: 1.4,
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
}

class _VciDispatchDot extends StatelessWidget {
  const _VciDispatchDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: _kOliveFelt,
        shape: BoxShape.circle,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Custom painter — an envelope with a wax seal.
// ---------------------------------------------------------------------------

class _VciDispatchEnvelopePainter extends CustomPainter {
  const _VciDispatchEnvelopePainter({
    required this.sealColor,
    required this.stampLabel,
  });

  final Color sealColor;
  final String stampLabel;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect body = Offset.zero & size;
    final Paint envelopeFill = Paint()..color = _kEnvelopeCream;
    final Paint envelopeEdge = Paint()
      ..color = _kEnvelopeShadow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final RRect rounded = RRect.fromRectAndRadius(
      body,
      const Radius.circular(6),
    );
    canvas.drawRRect(rounded, envelopeFill);
    canvas.drawRRect(rounded, envelopeEdge);

    final Path flap = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height * 0.55)
      ..lineTo(size.width, 0)
      ..close();
    final Paint flapFill = Paint()..color = _kEnvelopeCream.withAlpha(220);
    canvas.drawPath(flap, flapFill);
    canvas.drawPath(flap, envelopeEdge);

    final Paint seal = Paint()..color = sealColor;
    final Offset sealCenter = Offset(
      size.width / 2,
      size.height * 0.55,
    );
    canvas.drawCircle(sealCenter, size.height * 0.18, seal);
    canvas.drawCircle(
      sealCenter,
      size.height * 0.18,
      Paint()
        ..color = Colors.black.withAlpha(80)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: stampLabel,
        style: const TextStyle(
          color: _kTelegramPaper,
          fontSize: 8,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      sealCenter - Offset(tp.width / 2, tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(_VciDispatchEnvelopePainter oldDelegate) {
    return oldDelegate.sealColor != sealColor ||
        oldDelegate.stampLabel != stampLabel;
  }
}

// ---------------------------------------------------------------------------
// Custom painter — a brass telegraph key.
// ---------------------------------------------------------------------------

class _VciDispatchTelegraphKeyPainter extends CustomPainter {
  const _VciDispatchTelegraphKeyPainter({required this.pressed});

  final bool pressed;

  @override
  void paint(Canvas canvas, Size size) {
    // Wooden base.
    final Rect base = Rect.fromLTWH(
      0,
      size.height * 0.65,
      size.width,
      size.height * 0.35,
    );
    final Paint baseFill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_kDeskOak, _kDeskOakDark],
      ).createShader(base);
    canvas.drawRRect(
      RRect.fromRectAndRadius(base, const Radius.circular(4)),
      baseFill,
    );

    // Brass pillars.
    final Paint brass = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_kBrassBright, _kBrass, _kBrassDark],
      ).createShader(Offset.zero & size);
    final Rect leftPillar = Rect.fromLTWH(
      size.width * 0.18,
      size.height * 0.3,
      size.width * 0.08,
      size.height * 0.4,
    );
    final Rect rightPillar = Rect.fromLTWH(
      size.width * 0.74,
      size.height * 0.3,
      size.width * 0.08,
      size.height * 0.4,
    );
    canvas.drawRect(leftPillar, brass);
    canvas.drawRect(rightPillar, brass);

    // Key arm.
    final double armY = pressed ? size.height * 0.55 : size.height * 0.4;
    final Rect arm = Rect.fromLTWH(
      size.width * 0.16,
      armY,
      size.width * 0.72,
      size.height * 0.08,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(arm, const Radius.circular(3)),
      brass,
    );

    // Knob.
    final Offset knob = Offset(
      size.width * 0.52,
      armY + size.height * 0.04,
    );
    canvas.drawCircle(knob, size.height * 0.13, brass);
    canvas.drawCircle(
      knob,
      size.height * 0.13,
      Paint()
        ..color = _kInkBlack.withAlpha(120)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // Spark line when pressed.
    if (pressed) {
      final Paint spark = Paint()
        ..color = _kBrassBright
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      for (int i = 0; i < 4; i++) {
        final double dx = size.width * (0.30 + i * 0.12);
        final double dy = armY - 6;
        canvas.drawLine(
          Offset(dx, dy),
          Offset(dx - 3, dy - 5),
          spark,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_VciDispatchTelegraphKeyPainter oldDelegate) {
    return oldDelegate.pressed != pressed;
  }
}

// ---------------------------------------------------------------------------
// Envelope pill widget — used across scenarios.
// ---------------------------------------------------------------------------

class _VciDispatchEnvelopePill extends StatelessWidget {
  const _VciDispatchEnvelopePill({
    required this.label,
    required this.sealColor,
    required this.stampLabel,
  });

  final String label;
  final Color sealColor;
  final String stampLabel;
  static const double width = 120;
  static const double height = 72;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            painter: _VciDispatchEnvelopePainter(
              sealColor: sealColor,
              stampLabel: stampLabel,
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: width,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _kTelegramPaper,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Key-value strip used for labeled data rows.
// ---------------------------------------------------------------------------

class _VciDispatchKeyValue extends StatelessWidget {
  const _VciDispatchKeyValue({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
  static const Color valueColor = _kInkBlack;
  static const bool monospace = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: _kOliveFeltDark,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 13,
                fontFamily: monospace ? 'monospace' : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 0 — masthead banner.
// ---------------------------------------------------------------------------

class _VciDispatchMasthead extends StatelessWidget {
  const _VciDispatchMasthead();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 16, 18, 0),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_kDeskOak, _kDeskOakDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBrass, width: 2),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 90,
            height: 90,
            child: CustomPaint(
              painter: _VciDispatchTelegraphKeyPainter(pressed: false),
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'TELEGRAPH OPERATOR\'S DESK',
                  style: TextStyle(
                    color: _kBrassBright,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Dispatching VoidCallbackIntent envelopes across an Actions scope',
                  style: TextStyle(
                    color: _kTelegramPaper,
                    fontSize: 13,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _kBrass,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text(
                  'CH.VCI — 1849',
                  style: TextStyle(
                    color: _kInkBlack,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Line Open',
                style: TextStyle(
                  color: _kTelegramPaper,
                  fontSize: 11,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 1 — Preamble Anatomy.
// ---------------------------------------------------------------------------

class _VciDispatchAnatomy extends StatelessWidget {
  const _VciDispatchAnatomy();

  @override
  Widget build(BuildContext context) {
    return _VciDispatchPanel(
      title: 'I · ANATOMY OF VoidCallbackIntent',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kBrass,
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Text(
          'final VoidCallback callback',
          style: TextStyle(
            color: _kInkBlack,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kTelegramPaper,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kTelegramPaperDark),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _VciDispatchKeyValue(
                  label: 'Declared in',
                  value: 'package:flutter/src/widgets/actions.dart',
                ),
                _VciDispatchKeyValue(
                  label: 'Extends',
                  value: 'Intent',
                ),
                _VciDispatchKeyValue(
                  label: 'Signature',
                  value: 'const VoidCallbackIntent(this.callback)',
                ),
                _VciDispatchKeyValue(
                  label: 'Payload',
                  value: 'final VoidCallback callback',
                ),
                _VciDispatchKeyValue(
                  label: 'Companion',
                  value: 'VoidCallbackAction extends Action<…>',
                ),
                _VciDispatchKeyValue(
                  label: 'invoke()',
                  value: '=> intent.callback()  // that is it',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _VciDispatchTelegram(
            lines: const <String>[
              'An Intent is a marker object describing "what the user means". '
                  'Most Intents carry domain data and rely on an Action '
                  'subclass to define the behavior.',
              'VoidCallbackIntent inverts that: the Intent carries the '
                  'behavior, and VoidCallbackAction simply calls it. This is '
                  'pragmatic glue for wiring arbitrary closures into an '
                  'Actions scope or Shortcuts map.',
              'Because VoidCallback takes no arguments and returns no value, '
                  'side effects are the whole point — counters tick, state '
                  'flips, widgets animate, logs are written.',
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 2 — Telegram Console.
// ---------------------------------------------------------------------------

class _VciDispatchEnvelopeRecord {
  const _VciDispatchEnvelopeRecord({
    required this.id,
    required this.label,
    required this.sealColor,
    required this.stamp,
    required this.callbackHash,
    required this.intentHash,
  });

  final int id;
  final String label;
  final Color sealColor;
  final String stamp;
  final int callbackHash;
  final int intentHash;
}

class _VciDispatchConsoleState {
  _VciDispatchConsoleState({
    required this.queue,
    required this.greetingCount,
    required this.alarmCount,
    required this.refreshCount,
    required this.lastDispatchedId,
    required this.scopeBypassed,
  });

  final List<_VciDispatchEnvelopeRecord> queue;
  final int greetingCount;
  final int alarmCount;
  final int refreshCount;
  final int lastDispatchedId;
  final bool scopeBypassed;
}

class _VciDispatchConsole extends StatefulWidget {
  const _VciDispatchConsole();

  @override
  State<_VciDispatchConsole> createState() => _VciDispatchConsoleStateImpl();
}

class _VciDispatchConsoleStateImpl extends State<_VciDispatchConsole> {
  final List<_VciDispatchEnvelopeRecord> _queue =
      <_VciDispatchEnvelopeRecord>[];
  int _greetingCount = 0;
  int _alarmCount = 0;
  int _refreshCount = 0;
  int _lastDispatchedId = -1;
  bool _scopeBypassed = false;
  String _selectedKind = 'greeting';
  int _dispatchSerial = 0;

  // Three named callback methods declared as instance methods.
  void _handleGreeting() {
    setState(() {
      _greetingCount++;
    });
  }

  void _handleAlarm() {
    setState(() {
      _alarmCount++;
    });
  }

  void _handleRefresh() {
    setState(() {
      _refreshCount++;
    });
  }

  // Cached tear-offs — same tear-off evaluates to the same Function
  // instance, so identityHashCode stays stable across dispatches.
  late final VoidCallback _cbGreeting = _handleGreeting;
  late final VoidCallback _cbAlarm = _handleAlarm;
  late final VoidCallback _cbRefresh = _handleRefresh;

  void _dispatch(String kind) {
    final VoidCallback callback;
    final String label;
    final Color seal;
    final String stamp;
    switch (kind) {
      case 'alarm':
        callback = _cbAlarm;
        label = 'Alarm';
        seal = _kRedStamp;
        stamp = 'ALM';
      case 'refresh':
        callback = _cbRefresh;
        label = 'Refresh';
        seal = _kGreenStamp;
        stamp = 'RFS';
      case 'greeting':
      default:
        callback = _cbGreeting;
        label = 'Greeting';
        seal = _kBrassDark;
        stamp = 'GRT';
    }

    final VoidCallbackIntent intent = VoidCallbackIntent(callback);
    final _VciDispatchEnvelopeRecord record = _VciDispatchEnvelopeRecord(
      id: _dispatchSerial++,
      label: label,
      sealColor: seal,
      stamp: stamp,
      callbackHash: identityHashCode(callback),
      intentHash: intent.hashCode,
    );

    // Actions.maybeInvoke honours the nearest ancestor; if the scope is
    // bypassed we simply drop the intent to illustrate an inert dispatch.
    if (!_scopeBypassed) {
      Actions.maybeInvoke<VoidCallbackIntent>(context, intent);
    }

    setState(() {
      _queue.insert(0, record);
      if (_queue.length > 8) {
        _queue.removeLast();
      }
      _lastDispatchedId = record.id;
    });
  }

  void _clearQueue() {
    setState(() {
      _queue.clear();
      _greetingCount = 0;
      _alarmCount = 0;
      _refreshCount = 0;
      _lastDispatchedId = -1;
    });
  }

  _VciDispatchConsoleState get _snapshot {
    return _VciDispatchConsoleState(
      queue: List<_VciDispatchEnvelopeRecord>.unmodifiable(_queue),
      greetingCount: _greetingCount,
      alarmCount: _alarmCount,
      refreshCount: _refreshCount,
      lastDispatchedId: _lastDispatchedId,
      scopeBypassed: _scopeBypassed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _VciDispatchConsoleState snap = _snapshot;
    return Actions(
      actions: <Type, Action<Intent>>{
        VoidCallbackIntent: VoidCallbackAction(),
      },
      child: Column(
        children: <Widget>[
          _VciDispatchPanel(
            title: 'II · TELEGRAM CONSOLE',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Bypass scope',
                  style: TextStyle(
                    color: _kTelegramPaper,
                    fontSize: 11,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(width: 6),
                Switch(
                  value: _scopeBypassed,
                  onChanged: (bool value) {
                    setState(() {
                      _scopeBypassed = value;
                    });
                  },
                  activeThumbColor: _kBrassBright,
                  activeTrackColor: _kBrassDark,
                  inactiveThumbColor: _kTelegramPaper,
                  inactiveTrackColor: _kOliveFeltDark,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _VciDispatchButtonRow(
                  onGreeting: () => _dispatch('greeting'),
                  onAlarm: () => _dispatch('alarm'),
                  onRefresh: () => _dispatch('refresh'),
                  bypassed: _scopeBypassed,
                ),
                const SizedBox(height: 12),
                _VciDispatchCountersBar(snapshot: snap),
                const SizedBox(height: 14),
                _VciDispatchDropdownFire(
                  selectedKind: _selectedKind,
                  onChanged: (String value) {
                    setState(() {
                      _selectedKind = value;
                    });
                  },
                  onFire: () => _dispatch(_selectedKind),
                ),
                const SizedBox(height: 14),
                _VciDispatchQueueStrip(
                  queue: snap.queue,
                  highlightId: snap.lastDispatchedId,
                ),
                const SizedBox(height: 10),
                _VciDispatchQueueControls(
                  onClear: _clearQueue,
                  total: snap.greetingCount +
                      snap.alarmCount +
                      snap.refreshCount,
                ),
                const SizedBox(height: 6),
                if (_scopeBypassed)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _kRedStamp.withAlpha(60),
                      border: Border.all(color: _kRedStamp, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.warning_amber_rounded,
                          color: _kRedStamp,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Scope bypassed: intents are dropped. Counters '
                            'will stop advancing even though envelopes queue.',
                            style: TextStyle(
                              color: _kTelegramPaper,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          _VciDispatchInspector(snapshot: snap),
          _VciDispatchRedispatch(snapshot: snap),
        ],
      ),
    );
  }
}

class _VciDispatchButtonRow extends StatelessWidget {
  const _VciDispatchButtonRow({
    required this.onGreeting,
    required this.onAlarm,
    required this.onRefresh,
    required this.bypassed,
  });

  final VoidCallback onGreeting;
  final VoidCallback onAlarm;
  final VoidCallback onRefresh;
  final bool bypassed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _VciDispatchButton(
            label: 'Send Greeting',
            stamp: 'GRT',
            sealColor: _kBrassDark,
            onPressed: onGreeting,
            disabled: false,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _VciDispatchButton(
            label: 'Send Alarm',
            stamp: 'ALM',
            sealColor: _kRedStamp,
            onPressed: onAlarm,
            disabled: false,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _VciDispatchButton(
            label: 'Send Refresh',
            stamp: 'RFS',
            sealColor: _kGreenStamp,
            onPressed: onRefresh,
            disabled: false,
          ),
        ),
      ],
    );
  }
}

class _VciDispatchButton extends StatelessWidget {
  const _VciDispatchButton({
    required this.label,
    required this.stamp,
    required this.sealColor,
    required this.onPressed,
    required this.disabled,
  });

  final String label;
  final String stamp;
  final Color sealColor;
  final VoidCallback onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[_kBrassBright, _kBrass, _kBrassDark],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kInkDark, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 96,
                height: 56,
                child: CustomPaint(
                  painter: _VciDispatchEnvelopePainter(
                    sealColor: sealColor,
                    stampLabel: stamp,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  color: _kInkBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VciDispatchCountersBar extends StatelessWidget {
  const _VciDispatchCountersBar({required this.snapshot});

  final _VciDispatchConsoleState snapshot;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _VciDispatchCounterChip(
            label: 'Greetings',
            value: snapshot.greetingCount,
            tint: _kBrassDark,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _VciDispatchCounterChip(
            label: 'Alarms',
            value: snapshot.alarmCount,
            tint: _kRedStamp,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _VciDispatchCounterChip(
            label: 'Refreshes',
            value: snapshot.refreshCount,
            tint: _kGreenStamp,
          ),
        ),
      ],
    );
  }
}

class _VciDispatchCounterChip extends StatelessWidget {
  const _VciDispatchCounterChip({
    required this.label,
    required this.value,
    required this.tint,
  });

  final String label;
  final int value;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: _kOliveFelt,
        border: Border.all(color: tint, width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$value',
              style: const TextStyle(
                color: _kTelegramPaper,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _kTelegramPaper,
                fontSize: 12,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VciDispatchDropdownFire extends StatelessWidget {
  const _VciDispatchDropdownFire({
    required this.selectedKind,
    required this.onChanged,
    required this.onFire,
  });

  final String selectedKind;
  final ValueChanged<String> onChanged;
  final VoidCallback onFire;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: _kOliveFeltDark,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kBrass, width: 1),
      ),
      child: Row(
        children: <Widget>[
          const Text(
            'Compose intent:',
            style: TextStyle(
              color: _kTelegramPaper,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: _kTelegramPaper,
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedKind,
                  isDense: true,
                  dropdownColor: _kTelegramPaper,
                  style: const TextStyle(
                    color: _kInkBlack,
                    fontSize: 13,
                  ),
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'greeting',
                      child: Text('Greeting — brass seal'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'alarm',
                      child: Text('Alarm — red seal'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'refresh',
                      child: Text('Refresh — green seal'),
                    ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) onChanged(value);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: onFire,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: _kBrass,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _kInkDark),
              ),
              child: const Text(
                'FIRE',
                style: TextStyle(
                  color: _kInkBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VciDispatchQueueStrip extends StatelessWidget {
  const _VciDispatchQueueStrip({
    required this.queue,
    required this.highlightId,
  });

  final List<_VciDispatchEnvelopeRecord> queue;
  final int highlightId;

  @override
  Widget build(BuildContext context) {
    if (queue.isEmpty) {
      return Container(
        height: 110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _kOliveFeltDark,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kBrassDark),
        ),
        child: const Text(
          'Queue empty — press a button to dispatch an envelope',
          style: TextStyle(
            color: _kTelegramPaper,
            fontSize: 12,
            letterSpacing: 0.6,
          ),
        ),
      );
    }
    return Container(
      height: 130,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kOliveFeltDark,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kBrassDark),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: queue.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (BuildContext context, int index) {
          final _VciDispatchEnvelopeRecord e = queue[index];
          final bool isLast = e.id == highlightId;
          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isLast ? _kBrassBright : Colors.transparent,
                width: 2,
              ),
            ),
            child: _VciDispatchEnvelopePill(
              label: '#${e.id} ${e.label}',
              sealColor: e.sealColor,
              stampLabel: e.stamp,
            ),
          );
        },
      ),
    );
  }
}

class _VciDispatchQueueControls extends StatelessWidget {
  const _VciDispatchQueueControls({
    required this.onClear,
    required this.total,
  });

  final VoidCallback onClear;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Invocations so far: $total',
            style: const TextStyle(
              color: _kTelegramPaper,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
        ),
        InkWell(
          onTap: onClear,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: _kOliveFelt,
              border: Border.all(color: _kBrass),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'CLEAR LINE',
              style: TextStyle(
                color: _kBrassBright,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 3 — Intent Inspector.
// ---------------------------------------------------------------------------

class _VciDispatchInspector extends StatelessWidget {
  const _VciDispatchInspector({required this.snapshot});

  final _VciDispatchConsoleState snapshot;

  @override
  Widget build(BuildContext context) {
    return _VciDispatchPanel(
      title: 'III · INTENT INSPECTOR',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          border: Border.all(color: _kBrass),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          'Last ID: ${snapshot.lastDispatchedId == -1 ? "—" : snapshot.lastDispatchedId}',
          style: const TextStyle(
            color: _kTelegramPaper,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          if (snapshot.queue.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kTelegramPaper,
                border: Border.all(color: _kTelegramPaperDark),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Dispatch an envelope to inspect its callback identity '
                'and Intent hash.',
                style: TextStyle(
                  color: _kInkDark,
                  fontSize: 12,
                ),
              ),
            )
          else
            Column(
              children: <Widget>[
                for (int i = 0; i < snapshot.queue.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _VciDispatchInspectorRow(
                      record: snapshot.queue[i],
                      isLast: snapshot.queue[i].id ==
                          snapshot.lastDispatchedId,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _VciDispatchInspectorRow extends StatelessWidget {
  const _VciDispatchInspectorRow({
    required this.record,
    required this.isLast,
  });

  final _VciDispatchEnvelopeRecord record;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: _kTelegramPaper,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isLast ? _kBrassDark : _kTelegramPaperDark,
          width: isLast ? 1.6 : 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 80,
            height: 44,
            child: CustomPaint(
              painter: _VciDispatchEnvelopePainter(
                sealColor: record.sealColor,
                stampLabel: record.stamp,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '#${record.id}  ${record.label}Intent',
                  style: const TextStyle(
                    color: _kInkBlack,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'callback#${record.callbackHash}  ·  '
                  'intent#${record.intentHash}',
                  style: const TextStyle(
                    color: _kInkDark,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          if (isLast)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: _kBrassDark,
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Text(
                'LATEST',
                style: TextStyle(
                  color: _kTelegramPaper,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 4 — Re-dispatch Gallery.
// ---------------------------------------------------------------------------

class _VciDispatchRedispatch extends StatelessWidget {
  const _VciDispatchRedispatch({required this.snapshot});

  final _VciDispatchConsoleState snapshot;

  @override
  Widget build(BuildContext context) {
    final Map<int, int> callbackCounts = <int, int>{};
    for (final _VciDispatchEnvelopeRecord r in snapshot.queue) {
      callbackCounts.update(
        r.callbackHash,
        (int v) => v + 1,
        ifAbsent: () => 1,
      );
    }
    return _VciDispatchPanel(
      title: 'IV · RE-DISPATCH GALLERY',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kOliveFeltDark,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          '${callbackCounts.length} distinct callbacks',
          style: const TextStyle(
            color: _kTelegramPaper,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          _VciDispatchTelegram(
            lines: const <String>[
              'Each button builds a fresh VoidCallbackIntent, but they share '
                  'the same three underlying VoidCallback closures. Because '
                  'identityHashCode is stable per object, repeated dispatches '
                  'of the same kind collapse into one callback hash with a '
                  'growing count — a cheap way to prove "same closure" at a '
                  'glance.',
            ],
          ),
          const SizedBox(height: 8),
          if (callbackCounts.isEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kTelegramPaper,
                border: Border.all(color: _kTelegramPaperDark),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'No re-dispatches yet.',
                style: TextStyle(color: _kInkDark, fontSize: 12),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final MapEntry<int, int> entry
                    in callbackCounts.entries)
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                    decoration: BoxDecoration(
                      color: _kTelegramPaper,
                      border: Border.all(color: _kBrassDark),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'callback#${entry.key}',
                          style: const TextStyle(
                            color: _kInkBlack,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _kBrassDark,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            'x${entry.value}',
                            style: const TextStyle(
                              color: _kTelegramPaper,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 5 — Named-intent routing.
// ---------------------------------------------------------------------------

class _VciDispatchNamedRoute {
  const _VciDispatchNamedRoute({
    required this.title,
    required this.description,
    required this.sealColor,
    required this.stamp,
    required this.operator,
  });

  final String title;
  final String description;
  final Color sealColor;
  final String stamp;
  final String operator;
}

class _VciDispatchNamedRouting extends StatefulWidget {
  const _VciDispatchNamedRouting();

  @override
  State<_VciDispatchNamedRouting> createState() =>
      _VciDispatchNamedRoutingState();
}

class _VciDispatchNamedRoutingState extends State<_VciDispatchNamedRouting> {
  final List<String> _log = <String>[];
  int _counterA = 0;
  int _counterB = 0;
  int _counterC = 0;

  void _logAndTick(String scope, int which) {
    setState(() {
      if (which == 1) _counterA++;
      if (which == 2) _counterB++;
      if (which == 3) _counterC++;
      _log.insert(0, '$scope invoked intent #$which');
      if (_log.length > 5) _log.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<_VciDispatchNamedRoute> routes = const <_VciDispatchNamedRoute>[
      _VciDispatchNamedRoute(
        title: 'Channel A',
        description:
            'Handled by the outer Actions scope — invoking its bound VoidCallback.',
        sealColor: _kBrassDark,
        stamp: 'CH-A',
        operator: 'Hughes',
      ),
      _VciDispatchNamedRoute(
        title: 'Channel B',
        description:
            'Nested Actions scope overrides the handler for channel B only.',
        sealColor: _kGreenStamp,
        stamp: 'CH-B',
        operator: 'Morse',
      ),
      _VciDispatchNamedRoute(
        title: 'Channel C',
        description:
            'Disabled route — Actions.maybeInvoke returns null and nothing happens.',
        sealColor: _kRedStamp,
        stamp: 'CH-C',
        operator: '—',
      ),
    ];

    return _VciDispatchPanel(
      title: 'V · NAMED-INTENT ROUTING',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kBrass,
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Text(
          '3 scopes',
          style: TextStyle(
            color: _kInkBlack,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          _VciDispatchTelegram(
            lines: const <String>[
              'A single VoidCallbackAction handles every VoidCallbackIntent '
                  'in its scope. To route by name, wrap subtrees in different '
                  'Actions scopes. The innermost scope wins, letting you '
                  'override behavior for a sub-section of the tree.',
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              for (int i = 0; i < routes.length; i++) ...<Widget>[
                if (i != 0) const SizedBox(width: 10),
                Expanded(
                  child: _VciDispatchRouteTile(
                    route: routes[i],
                    count: i == 0
                        ? _counterA
                        : i == 1
                            ? _counterB
                            : _counterC,
                    onFire: () {
                      // Build a fresh intent whose callback is the logger.
                      final int which = i + 1;
                      final VoidCallbackIntent intent =
                          VoidCallbackIntent(() {
                        _logAndTick(routes[i].title, which);
                      });
                      // In Channel C we intentionally do not wrap the
                      // invocation in an Actions scope — mimic an unbound
                      // route.
                      if (i == 2) {
                        // Directly discard — no action bound.
                        setState(() {
                          _log.insert(
                            0,
                            '${routes[i].title} dispatched but '
                            'no handler (inert)',
                          );
                          if (_log.length > 5) _log.removeLast();
                        });
                      } else {
                        Actions.maybeInvoke<VoidCallbackIntent>(
                          context,
                          intent,
                        );
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kOliveFeltDark,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kBrassDark),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'ROUTING LOG',
                  style: TextStyle(
                    color: _kBrassBright,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                if (_log.isEmpty)
                  const Text(
                    'No dispatches yet.',
                    style: TextStyle(
                      color: _kTelegramPaper,
                      fontSize: 12,
                    ),
                  )
                else
                  for (final String line in _log)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text(
                        '• $line',
                        style: const TextStyle(
                          color: _kTelegramPaper,
                          fontSize: 12,
                          fontFamily: 'monospace',
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
}

class _VciDispatchRouteTile extends StatelessWidget {
  const _VciDispatchRouteTile({
    required this.route,
    required this.count,
    required this.onFire,
  });

  final _VciDispatchNamedRoute route;
  final int count;
  final VoidCallback onFire;

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        VoidCallbackIntent: VoidCallbackAction(),
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _kTelegramPaper,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: route.sealColor, width: 1.6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    route.title,
                    style: const TextStyle(
                      color: _kInkBlack,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: route.sealColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    route.stamp,
                    style: const TextStyle(
                      color: _kTelegramPaper,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              route.description,
              style: const TextStyle(
                color: _kInkDark,
                fontSize: 11,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Operator: ${route.operator}  ·  ticks: $count',
              style: const TextStyle(
                color: _kOliveFeltDark,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: onFire,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _kOliveFelt,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'DISPATCH',
                  style: TextStyle(
                    color: _kBrassBright,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 6 — Keyboard shortcut demo.
// ---------------------------------------------------------------------------

class _VciDispatchKeyboard extends StatefulWidget {
  const _VciDispatchKeyboard();

  @override
  State<_VciDispatchKeyboard> createState() => _VciDispatchKeyboardState();
}

class _VciDispatchKeyboardState extends State<_VciDispatchKeyboard> {
  int _ctrl1 = 0;
  int _ctrl2 = 0;
  int _ctrl3 = 0;
  bool _keyPressed = false;
  String _lastShortcut = '—';

  void _flash(String label) {
    setState(() {
      _lastShortcut = label;
      _keyPressed = true;
    });
  }

  void _resetFlash() {
    setState(() {
      _keyPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<ShortcutActivator, Intent> shortcuts =
        <ShortcutActivator, Intent>{
      const SingleActivator(LogicalKeyboardKey.digit1, control: true):
          VoidCallbackIntent(() {
        setState(() {
          _ctrl1++;
        });
        _flash('Ctrl+1');
      }),
      const SingleActivator(LogicalKeyboardKey.digit2, control: true):
          VoidCallbackIntent(() {
        setState(() {
          _ctrl2++;
        });
        _flash('Ctrl+2');
      }),
      const SingleActivator(LogicalKeyboardKey.digit3, control: true):
          VoidCallbackIntent(() {
        setState(() {
          _ctrl3++;
        });
        _flash('Ctrl+3');
      }),
    };

    return _VciDispatchPanel(
      title: 'VI · KEYBOARD SHORTCUTS',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kOliveFelt,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: _kBrass),
        ),
        child: Text(
          'Last: $_lastShortcut',
          style: const TextStyle(
            color: _kTelegramPaper,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ),
      child: Shortcuts(
        shortcuts: shortcuts,
        child: Actions(
          actions: <Type, Action<Intent>>{
            VoidCallbackIntent: VoidCallbackAction(),
          },
          child: Focus(
            autofocus: false,
            onFocusChange: (bool focused) {
              if (!focused) _resetFlash();
            },
            child: Builder(
              builder: (BuildContext inner) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _VciDispatchTelegram(
                      lines: const <String>[
                        'Focus the operator pad and press Ctrl+1, Ctrl+2 or '
                            'Ctrl+3. Each SingleActivator maps to a separate '
                            'VoidCallbackIntent whose callback ticks its own '
                            'counter — proof that Shortcuts → Intents → '
                            'Actions is a clean pipeline.',
                      ],
                    ),
                    const SizedBox(height: 10),
                    _VciDispatchKeyboardPad(
                      pressed: _keyPressed,
                      onTap: () {
                        FocusScope.of(inner).requestFocus();
                        _flash('focus');
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _VciDispatchCounterChip(
                            label: 'Ctrl+1',
                            value: _ctrl1,
                            tint: _kBrassDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _VciDispatchCounterChip(
                            label: 'Ctrl+2',
                            value: _ctrl2,
                            tint: _kGreenStamp,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _VciDispatchCounterChip(
                            label: 'Ctrl+3',
                            value: _ctrl3,
                            tint: _kRedStamp,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _VciDispatchKeyboardPad extends StatelessWidget {
  const _VciDispatchKeyboardPad({
    required this.pressed,
    required this.onTap,
  });

  final bool pressed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kOliveFeltDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kBrass, width: 1.2),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 92,
              height: 72,
              child: CustomPaint(
                painter: _VciDispatchTelegraphKeyPainter(pressed: pressed),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'OPERATOR PAD',
                    style: TextStyle(
                      color: _kBrassBright,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Click to focus, then tap Ctrl+1/2/3 to fire shortcuts.',
                    style: TextStyle(
                      color: _kTelegramPaper,
                      fontSize: 11,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 7 — Epilogue / recipes.
// ---------------------------------------------------------------------------

class _VciDispatchEpilogue extends StatelessWidget {
  const _VciDispatchEpilogue();

  @override
  Widget build(BuildContext context) {
    return _VciDispatchPanel(
      title: 'VII · RECIPES & PITFALLS',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kBrass,
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Text(
          '7 rules of thumb',
          style: TextStyle(
            color: _kInkBlack,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          _VciDispatchRecipeRow(
            index: '01',
            title: 'Prefer const Intents for plain commands',
            body:
                'For intents with no payload (Save, Reload, Close) use const '
                'Intent subclasses. Reach for VoidCallbackIntent only when '
                'you actually need a closure.',
          ),
          _VciDispatchRecipeRow(
            index: '02',
            title: 'Pair with Actions + VoidCallbackAction',
            body:
                'Register VoidCallbackAction against VoidCallbackIntent once '
                'near the top of your subtree; everything below dispatches '
                'the same way.',
          ),
          _VciDispatchRecipeRow(
            index: '03',
            title: 'Wire Shortcuts → Intent → Action',
            body:
                'Use SingleActivator in Shortcuts to declare the key, then '
                'Actions handles the dispatch. Each activator may carry a '
                'different VoidCallbackIntent.',
          ),
          _VciDispatchRecipeRow(
            index: '04',
            title: 'Beware of rebuilt closures',
            body:
                'Creating a fresh closure each build rebuilds the Intent '
                'too. For stable identity, hoist the VoidCallback into '
                'State fields or module-level finals.',
          ),
          _VciDispatchRecipeRow(
            index: '05',
            title: 'Compose with FocusableActionDetector',
            body:
                'FocusableActionDetector can register both shortcuts and '
                'actions, making hover/focus-aware controls trivial.',
          ),
          _VciDispatchRecipeRow(
            index: '06',
            title: 'Test via Actions.maybeInvoke',
            body:
                'In widget tests, dispatch the intent directly; the '
                'callback is executed synchronously, so there are no '
                'animation gymnastics to wait on.',
          ),
          _VciDispatchRecipeRow(
            index: '07',
            title: 'Avoid hidden captures',
            body:
                'Closures bound to a BuildContext that could be disposed '
                'cause the classic "unmounted setState" warning. Guard '
                'with `if (!mounted) return;` when needed.',
          ),
        ],
      ),
    );
  }
}

class _VciDispatchRecipeRow extends StatelessWidget {
  const _VciDispatchRecipeRow({
    required this.index,
    required this.title,
    required this.body,
  });

  final String index;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          color: _kTelegramPaper,
          border: Border.all(color: _kTelegramPaperDark),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _kOliveFelt,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                index,
                style: const TextStyle(
                  color: _kBrassBright,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      color: _kInkBlack,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: const TextStyle(
                      color: _kInkDark,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer — signature plate.
// ---------------------------------------------------------------------------

class _VciDispatchFooter extends StatelessWidget {
  const _VciDispatchFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 8, 18, 20),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: _kDeskOakDark,
        border: Border.all(color: _kBrass),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          const _VciDispatchRivet(size: 12),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'End of transmission. All envelopes archived. '
              '— Operator Desk #7, night shift',
              style: TextStyle(
                color: _kTelegramPaper,
                fontSize: 12,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const _VciDispatchRivet(size: 12),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top-level build() entry — no main(), no runApp().
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'VoidCallbackIntent — Telegraph Operator\'s Desk',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF3A2A18),
      colorScheme: const ColorScheme.dark(
        primary: _kBrass,
        onPrimary: _kInkBlack,
        secondary: _kOliveFelt,
        onSecondary: _kTelegramPaper,
        surface: _kDeskOak,
        onSurface: _kTelegramPaper,
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFF3A2A18),
      appBar: AppBar(
        backgroundColor: _kDeskOakDark,
        foregroundColor: _kTelegramPaper,
        elevation: 0,
        title: const Row(
          children: <Widget>[
            Icon(Icons.mail_outline, color: _kBrassBright),
            SizedBox(width: 8),
            Text(
              'VoidCallbackIntent · Dispatch Desk',
              style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: ColoredBox(
            color: _kBrass,
            child: SizedBox(height: 4, width: double.infinity),
          ),
        ),
      ),
      body: ListView(
        children: const <Widget>[
          _VciDispatchMasthead(),
          _VciDispatchHeading(
            'SECTION I — ANATOMY',
            stamp: 'SDK',
          ),
          _VciDispatchAnatomy(),
          _VciDispatchHeading(
            'SECTION II — CONSOLE',
            stamp: 'LIVE',
          ),
          _VciDispatchConsole(),
          _VciDispatchHeading(
            'SECTION V — NAMED ROUTING',
            stamp: 'ROUTE',
          ),
          _VciDispatchNamedRouting(),
          _VciDispatchHeading(
            'SECTION VI — SHORTCUTS',
            stamp: 'KEYS',
          ),
          _VciDispatchKeyboard(),
          _VciDispatchHeading(
            'SECTION VII — RECIPES',
            stamp: 'NOTES',
          ),
          _VciDispatchEpilogue(),
          _VciDispatchFooter(),
        ],
      ),
    ),
  );
}
