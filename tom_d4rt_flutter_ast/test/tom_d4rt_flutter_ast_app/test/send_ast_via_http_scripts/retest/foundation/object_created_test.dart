// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
//
// Deep visual demo — `ObjectCreated` from `package:flutter/foundation.dart`.
//
// This file is a *retest* of the ObjectCreated topic: same surface area as the
// production demo, rewritten from scratch with a different visual angle so the
// SendTestRunner can compare AST fidelity across two independent renderings of
// the same Flutter foundation API.
//
// Topic summary
// -------------
// Flutter's `foundation` library exposes a thin, opt-in observability layer
// for object lifecycles called `MemoryAllocations` (also reachable through
// `FlutterMemoryAllocations.instance`). It is the same plumbing the Dart VM
// service / DevTools uses to flag potential memory leaks. The pattern is:
//
//   * Code that wants to be observable calls
//       `MemoryAllocations.instance.dispatchObjectCreated(
//           library: 'package:foo/bar.dart',
//           className: 'Bar',
//           object: this,
//         );`
//     inside its constructor and a matching `dispatchObjectDisposed(...)`
//     inside its `dispose()` method.
//
//   * Subscribers register a listener with
//       `MemoryAllocations.instance.addListener(callback)`
//     where `callback` takes a single `ObjectEvent` parameter. The runtime
//     fans events out to every listener.
//
//   * `ObjectCreated` is the concrete `ObjectEvent` subclass dispatched on the
//     creation half of the lifecycle. Its three observable fields are
//     `library`, `className` and `object`. The `object` reference is held
//     weakly in spirit: listeners must not retain it past the synchronous
//     callback, otherwise they themselves are the leak.
//
// The demo statically illustrates what a tracked creation looks like, how the
// event is shaped, when Flutter dispatches them, the anatomy of a listener,
// and the relationship to `ObjectDisposed`. We never actually subscribe to
// `MemoryAllocations.instance.addListener` because the SendTestRunner does not
// keep async handlers alive: the d4rt interpreter executes `build()` once and
// returns the resulting widget tree. All side-effects are described in prose,
// rendered code snippets and decorated panels instead.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------
// Each section card gets its own colour family so the demo reads like a
// chapter book rather than a flat list of code samples. We keep all colour
// constants top-level so they can be referenced from both the painter classes
// and the section builders.

const Color _bgPage = Color(0xFF0F1320);
const Color _bgIntro = Color(0xFF1A2236);
const Color _bgAnatomy = Color(0xFF1F1632);
const Color _bgLifecycle = Color(0xFF152431);
const Color _bgListener = Color(0xFF2A1F18);
const Color _bgPayload = Color(0xFF1B2D24);
const Color _bgDecision = Color(0xFF2C1D2B);
const Color _bgPalette = Color(0xFF1A2A2F);
const Color _bgCode = Color(0xFF10131C);
const Color _bgPitfalls = Color(0xFF2A1417);
const Color _bgReference = Color(0xFF1D1F2B);

const Color _accentIntro = Color(0xFF6BA8FF);
const Color _accentAnatomy = Color(0xFFB892FF);
const Color _accentLifecycle = Color(0xFF4ECDC4);
const Color _accentListener = Color(0xFFFFB36B);
const Color _accentPayload = Color(0xFF8BD89B);
const Color _accentDecision = Color(0xFFE57FB7);
const Color _accentPalette = Color(0xFF7DD4D4);
const Color _accentCode = Color(0xFF9ECBFF);
const Color _accentPitfalls = Color(0xFFFF8A8A);
const Color _accentReference = Color(0xFFC8C8E8);

const Color _textPrimary = Color(0xFFF2F4FA);
const Color _textSecondary = Color(0xFFB8BCC9);
const Color _textMuted = Color(0xFF7F8597);
const Color _codeBg = Color(0xFF0A0C12);
const Color _codeBorder = Color(0xFF2A2E40);

const TextStyle _codeStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  height: 1.5,
  color: Color(0xFFD8DDEC),
);

// ---------------------------------------------------------------------------
// Small data-bags used by the section builders. Keeping these as plain Dart
// classes (rather than Dart records) makes the AST predictable across the
// flutter-AST generator's snapshot diffs.
// ---------------------------------------------------------------------------

class _SamplePayload {
  const _SamplePayload({
    required this.library,
    required this.className,
    required this.objectLabel,
    required this.icon,
    required this.tint,
    required this.note,
  });

  final String library;
  final String className;
  final String objectLabel;
  final IconData icon;
  final Color tint;
  final String note;
}

class _LifecyclePhase {
  const _LifecyclePhase({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.detail,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String detail;
}

class _DecisionRow {
  const _DecisionRow({
    required this.scenario,
    required this.useIt,
    required this.alternative,
    required this.rationale,
  });

  final String scenario;
  final String useIt;
  final String alternative;
  final String rationale;
}

class _Pitfall {
  const _Pitfall({
    required this.title,
    required this.bad,
    required this.good,
    required this.explanation,
  });

  final String title;
  final String bad;
  final String good;
  final String explanation;
}

class _ReferenceRow {
  const _ReferenceRow({
    required this.member,
    required this.kind,
    required this.summary,
  });

  final String member;
  final String kind;
  final String summary;
}

// ---------------------------------------------------------------------------
// CustomPainter — anatomy diagram for the ObjectCreatedEvent shape.
// We draw a three-slot record-like box: [library | className | object] with
// dashed connectors going to a "listener" pill on the right.
// ---------------------------------------------------------------------------

class _AnatomyPainter extends CustomPainter {
  const _AnatomyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint frame = Paint()
      ..color = const Color(0xFF3D2D5C)
      ..style = PaintingStyle.fill;
    final Paint stroke = Paint()
      ..color = _accentAnatomy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Paint slot = Paint()..style = PaintingStyle.fill;

    // The big rounded "ObjectCreated" envelope on the left half of the canvas.
    final RRect envelope = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 18, size.width * 0.58, size.height - 36),
      const Radius.circular(12),
    );
    canvas.drawRRect(envelope, frame);
    canvas.drawRRect(envelope, stroke);

    // Header bar "ObjectCreated".
    final Paint header = Paint()..color = _accentAnatomy.withAlpha(72);
    final RRect headerRect = RRect.fromLTRBR(
      14,
      24,
      8 + size.width * 0.58 - 6,
      48,
      const Radius.circular(6),
    );
    canvas.drawRRect(headerRect, header);

    final TextPainter title = TextPainter(
      text: const TextSpan(
        text: 'ObjectCreated',
        style: TextStyle(
          color: _textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    title.paint(canvas, const Offset(22, 28));

    // Three field slots.
    final List<String> labels = <String>['library', 'className', 'object'];
    final List<Color> slotColors = <Color>[
      const Color(0xFF6BA8FF),
      const Color(0xFFFFB36B),
      const Color(0xFF8BD89B),
    ];
    final double slotTop = 60;
    final double slotHeight = (size.height - 36 - 60) / 3 - 6;
    for (int i = 0; i < 3; i++) {
      final double top = slotTop + i * (slotHeight + 6);
      slot.color = slotColors[i].withAlpha(48);
      final RRect r = RRect.fromLTRBR(
        18,
        top,
        8 + size.width * 0.58 - 14,
        top + slotHeight,
        const Radius.circular(6),
      );
      canvas.drawRRect(r, slot);
      final TextPainter t = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: slotColors[i],
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      t.paint(canvas, Offset(28, top + slotHeight / 2 - 8));
    }

    // Listener pill on the right.
    final RRect listener = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.72,
        size.height / 2 - 18,
        size.width * 0.25,
        36,
      ),
      const Radius.circular(18),
    );
    final Paint listenerFill = Paint()..color = const Color(0xFF4B2D2C);
    canvas.drawRRect(listener, listenerFill);
    canvas.drawRRect(listener, stroke);
    final TextPainter listenerText = TextPainter(
      text: const TextSpan(
        text: 'listener',
        style: TextStyle(
          color: _accentListener,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    listenerText.paint(
      canvas,
      Offset(
        size.width * 0.72 + (size.width * 0.25 - listenerText.width) / 2,
        size.height / 2 - 8,
      ),
    );

    // Dashed connector from envelope right edge to listener.
    final Paint dash = Paint()
      ..color = _accentAnatomy.withAlpha(160)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final double startX = 8 + size.width * 0.58;
    final double endX = size.width * 0.72;
    final double y = size.height / 2;
    double x = startX;
    while (x < endX) {
      final double seg = (x + 6 < endX) ? x + 6 : endX;
      canvas.drawLine(Offset(x, y), Offset(seg, y), dash);
      x += 10;
    }
    // Arrow head.
    final Path arrow = Path()
      ..moveTo(endX, y)
      ..lineTo(endX - 6, y - 4)
      ..lineTo(endX - 6, y + 4)
      ..close();
    canvas.drawPath(arrow, Paint()..color = _accentAnatomy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// CustomPainter — lifecycle timeline.
// ---------------------------------------------------------------------------

class _TimelinePainter extends CustomPainter {
  const _TimelinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height / 2;
    final Paint line = Paint()
      ..color = _accentLifecycle.withAlpha(120)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(20, midY), Offset(size.width - 20, midY), line);

    // Three stops: constructor, addListener fan-out, dispose.
    final List<String> labels = <String>[
      'ctor()',
      'dispatchObjectCreated',
      'listener fan-out',
      'dispose()',
    ];
    final List<Color> stopColors = <Color>[
      const Color(0xFF6BA8FF),
      const Color(0xFFB892FF),
      const Color(0xFFFFB36B),
      const Color(0xFF8A8A8A),
    ];

    for (int i = 0; i < labels.length; i++) {
      final double x = 20 + (size.width - 40) * (i / (labels.length - 1));
      final Paint stop = Paint()..color = stopColors[i];
      canvas.drawCircle(Offset(x, midY), 8, stop);
      canvas.drawCircle(
        Offset(x, midY),
        8,
        Paint()
          ..color = Colors.white.withAlpha(80)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: stopColors[i],
            fontSize: 11,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      // Alternate above/below to avoid overlap.
      final double labelY = (i.isEven) ? midY - 28 : midY + 14;
      tp.paint(canvas, Offset(x - tp.width / 2, labelY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Top-level helpers — every section is built by its own function so the
// `build()` function below remains a clean flat list of cards.
// ---------------------------------------------------------------------------

BoxDecoration _cardDecoration({
  required Color background,
  required Color accent,
  bool radial = false,
}) {
  return BoxDecoration(
    gradient: radial
        ? RadialGradient(
            center: const Alignment(-0.6, -0.8),
            radius: 1.2,
            colors: <Color>[
              accent.withAlpha(48),
              background,
              background,
            ],
            stops: const <double>[0.0, 0.55, 1.0],
          )
        : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              background,
              Color.lerp(background, accent, 0.18) ?? background,
            ],
          ),
    borderRadius: const BorderRadius.all(Radius.circular(18)),
    border: Border.all(color: accent.withAlpha(90), width: 1.2),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black.withAlpha(120),
        offset: const Offset(0, 12),
        blurRadius: 28,
        spreadRadius: -8,
      ),
      BoxShadow(
        color: accent.withAlpha(40),
        offset: const Offset(0, 0),
        blurRadius: 24,
        spreadRadius: -2,
      ),
      BoxShadow(
        color: Colors.white.withAlpha(8),
        offset: const Offset(0, 1),
        blurRadius: 0,
      ),
    ],
  );
}

Widget _sectionHeader({
  required IconData icon,
  required Color accent,
  required String number,
  required String title,
  required String tagline,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              accent.withAlpha(220),
              accent.withAlpha(120),
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: accent.withAlpha(120),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withAlpha(50),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(6)),
                    border: Border.all(color: accent.withAlpha(120)),
                  ),
                  child: Text(
                    number,
                    style: TextStyle(
                      color: accent,
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              tagline,
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 12,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _paragraph(String body) {
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Text(
      body,
      style: const TextStyle(
        color: _textSecondary,
        fontSize: 13,
        height: 1.55,
      ),
    ),
  );
}

Widget _codeBlock({
  required String code,
  Color accent = _accentCode,
  String? caption,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      color: _codeBg,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: _codeBorder),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withAlpha(100),
          offset: const Offset(0, 4),
          blurRadius: 12,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withAlpha(28),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border(bottom: BorderSide(color: _codeBorder)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  caption ?? 'dart',
                  style: TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Text(code, style: _codeStyle),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Intro
// ---------------------------------------------------------------------------

Widget _buildIntroSection() {
  // Build a "live" event instance just so we can show its real runtime values
  // (library / className / object) further down. We never dispatch it.
  final Object subject = Object();
  final ObjectCreated event = ObjectCreated(
    library: 'package:flutter/foundation.dart',
    className: 'ChangeNotifier',
    object: subject,
  );

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgIntro,
      accent: _accentIntro,
      radial: true,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.add_box_outlined,
          accent: _accentIntro,
          number: '01',
          title: 'What is ObjectCreated?',
          tagline: 'A creation half-life event in Flutter\'s memory '
              'observability layer.',
        ),
        _paragraph(
          'ObjectCreated is the concrete event class dispatched by '
          'MemoryAllocations.instance.dispatchObjectCreated() when a '
          'memory-observable object enters the world. It is a plain data '
          'carrier — three fields, no behaviour — that lets DevTools and '
          'leak-tracker map a constructor call to the object reference it '
          'returned. The companion event ObjectDisposed closes the half-life '
          'when dispose() is called. Together they describe the lifespan '
          'that the Flutter framework uses to flag leaked notifiers, '
          'controllers, ticker providers and other disposable types.',
        ),
        Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _accentIntro.withAlpha(22),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: _accentIntro.withAlpha(80)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.bolt_outlined,
                    color: _accentIntro,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Live event snapshot',
                    style: TextStyle(
                      color: _accentIntro,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _kvRow('runtimeType', '${event.runtimeType}'),
              _kvRow('library', event.library),
              _kvRow('className', event.className),
              _kvRow('object.hashCode', '${event.object.hashCode}'),
              _kvRow('object.runtimeType', '${event.object.runtimeType}'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _codeBlock(
          accent: _accentIntro,
          caption: 'package:flutter/foundation.dart',
          code: 'class ObjectCreated extends ObjectEvent {\n'
              '  ObjectCreated({\n'
              '    required this.library,\n'
              '    required this.className,\n'
              '    required this.object,\n'
              '  });\n\n'
              '  final String library;\n'
              '  final String className;\n'
              '  final Object object;\n'
              '}',
        ),
      ],
    ),
  );
}

Widget _kvRow(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 132,
          child: Text(
            k,
            style: const TextStyle(
              color: _textMuted,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(
              color: _textPrimary,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — Anatomy diagram (CustomPainter)
// ---------------------------------------------------------------------------

Widget _buildAnatomySection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgAnatomy,
      accent: _accentAnatomy,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.account_tree_outlined,
          accent: _accentAnatomy,
          number: '02',
          title: 'Anatomy of an ObjectCreated event',
          tagline: 'Three named fields, dispatched synchronously to every '
              'listener.',
        ),
        _paragraph(
          'The event is intentionally minimal: a library string (where the '
          'class lives), a className string (no runtime introspection so '
          'tree-shaking is preserved), and an object reference (so listeners '
          'can group events by identity). The diagram below shows the shape '
          'of the event leaving the dispatcher and reaching a listener. The '
          'object field is the most dangerous one — a listener that keeps a '
          'strong reference to it past the callback becomes the leak.',
        ),
        const SizedBox(height: 14),
        Container(
          height: 170,
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(72),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: _accentAnatomy.withAlpha(60)),
          ),
          child: const CustomPaint(
            painter: _AnatomyPainter(),
            child: SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            Expanded(
              child: _fieldChip(
                'library',
                'package:foo/bar.dart',
                const Color(0xFF6BA8FF),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _fieldChip(
                'className',
                'Bar',
                const Color(0xFFFFB36B),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _fieldChip(
                'object',
                'Bar@0x4f23a',
                const Color(0xFF8BD89B),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _fieldChip(String label, String value, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: accent.withAlpha(28),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: accent.withAlpha(120)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: _textPrimary,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — Lifecycle timeline (CustomPainter + phase cards)
// ---------------------------------------------------------------------------

Widget _buildLifecycleSection() {
  const List<_LifecyclePhase> phases = <_LifecyclePhase>[
    _LifecyclePhase(
      title: 'Constructor returns',
      subtitle: 'this is fully constructed',
      icon: Icons.bolt,
      color: Color(0xFF6BA8FF),
      detail: 'The owning class has just finished initialising its fields. '
          'Calling dispatchObjectCreated in the constructor is conventional '
          'because the object is in a known-good state and a stack frame '
          'still pointing at the constructor makes the DevTools trace useful.',
    ),
    _LifecyclePhase(
      title: 'dispatchObjectCreated',
      subtitle: 'event allocated',
      icon: Icons.send_outlined,
      color: Color(0xFFB892FF),
      detail: 'MemoryAllocations.instance allocates an ObjectCreated event. '
          'If there are zero listeners the dispatcher fast-paths and does '
          'not even build the event — that is the price of free observability.',
    ),
    _LifecyclePhase(
      title: 'Listener fan-out',
      subtitle: 'each callback runs',
      icon: Icons.podcasts_outlined,
      color: Color(0xFFFFB36B),
      detail: 'Listeners run synchronously in registration order. They MUST '
          'NOT call addListener / removeListener during dispatch — the same '
          'rule that applies to ChangeNotifier — and they MUST NOT retain '
          'the object reference past the callback frame.',
    ),
    _LifecyclePhase(
      title: 'dispose()',
      subtitle: 'matching ObjectDisposed',
      icon: Icons.power_settings_new,
      color: Color(0xFF8A8A8A),
      detail: 'Eventually the owner calls dispose() and a paired '
          'dispatchObjectDisposed event closes the lifespan. The (library, '
          'className, identity-hash) pair is how leak-tracker tells which '
          'created event has no matching disposed event.',
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgLifecycle,
      accent: _accentLifecycle,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.timeline,
          accent: _accentLifecycle,
          number: '03',
          title: 'The four-stop lifecycle',
          tagline: 'Construction → dispatch → fan-out → matching disposal.',
        ),
        _paragraph(
          'ObjectCreated does not stand alone — it is the first half of a '
          'paired lifecycle. The framework relies on each created event '
          'having a matching ObjectDisposed for the same (library, '
          'className, identity-hash) triple. The timeline below traces a '
          'single object through both halves.',
        ),
        const SizedBox(height: 14),
        Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(64),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: _accentLifecycle.withAlpha(60)),
          ),
          child: const CustomPaint(
            painter: _TimelinePainter(),
            child: SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 14),
        Column(
          children: <Widget>[
            for (final _LifecyclePhase p in phases) _phaseRow(p),
          ],
        ),
      ],
    ),
  );
}

Widget _phaseRow(_LifecyclePhase p) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: p.color.withAlpha(22),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: p.color.withAlpha(90)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: p.color.withAlpha(60),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: p.color.withAlpha(160)),
          ),
          child: Icon(p.icon, color: p.color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    p.title,
                    style: TextStyle(
                      color: p.color,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    p.subtitle,
                    style: const TextStyle(
                      color: _textMuted,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                p.detail,
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Listener registration pattern
// ---------------------------------------------------------------------------

Widget _buildListenerSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgListener,
      accent: _accentListener,
      radial: true,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.podcasts_outlined,
          accent: _accentListener,
          number: '04',
          title: 'Registering a listener',
          tagline: 'addListener takes a single Object-Event callback.',
        ),
        _paragraph(
          'Subscribers register a single callback that receives the '
          'ObjectEvent superclass. The callback decides at runtime whether '
          'this particular event is an ObjectCreated, an ObjectDisposed, or '
          'something custom (third-party packages may dispatch their own '
          'ObjectEvent subclasses). The idiomatic shape is a type-switch with '
          'an if-is pattern; do not assume the event is always an '
          'ObjectCreated. Always pair addListener with removeListener using '
          'a stable function reference (a top-level function or a stored '
          'field) — anonymous closures cannot be unregistered.',
        ),
        _codeBlock(
          accent: _accentListener,
          caption: 'subscribe / unsubscribe',
          code: 'void _onMemoryEvent(ObjectEvent event) {\n'
              '  if (event is ObjectCreated) {\n'
              '    print(\'created  \${event.className}\'\n'
              '          \' in \${event.library}\');\n'
              '  } else if (event is ObjectDisposed) {\n'
              '    print(\'disposed \${event.className}\');\n'
              '  }\n'
              '}\n\n'
              'void wireUp() {\n'
              '  MemoryAllocations.instance.addListener(_onMemoryEvent);\n'
              '}\n\n'
              'void tearDown() {\n'
              '  MemoryAllocations.instance.removeListener(_onMemoryEvent);\n'
              '}',
        ),
        const SizedBox(height: 14),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Local visual toggle — never actually subscribes to anything.
            // The state is purely for the indicator dot. We use a list slot
            // so the analyzer can't fold the value away as a constant.
            final List<bool> armedSlot = <bool>[true];
            final bool armed = armedSlot.first;
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _accentListener.withAlpha(20),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: _accentListener.withAlpha(90)),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: armed
                          ? const Color(0xFF8BD89B)
                          : const Color(0xFF8A8A8A),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: (armed
                                  ? const Color(0xFF8BD89B)
                                  : const Color(0xFF8A8A8A))
                              .withAlpha(140),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Listener slot: ready (illustrative; this demo never '
                      'actually attaches it)',
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — Sample payloads (Wrap of variation cards)
// ---------------------------------------------------------------------------

Widget _buildSamplePayloadsSection() {
  const List<_SamplePayload> payloads = <_SamplePayload>[
    _SamplePayload(
      library: 'package:flutter/foundation.dart',
      className: 'ChangeNotifier',
      objectLabel: 'ChangeNotifier@0x21ac',
      icon: Icons.notifications_active_outlined,
      tint: Color(0xFF6BA8FF),
      note: 'Base class for reactive state; the most common observable.',
    ),
    _SamplePayload(
      library: 'package:flutter/widgets.dart',
      className: 'FocusNode',
      objectLabel: 'FocusNode@0x82e0',
      icon: Icons.center_focus_strong_outlined,
      tint: Color(0xFFFFB36B),
      note: 'Long-lived; leaks here drag entire focus trees with them.',
    ),
    _SamplePayload(
      library: 'package:flutter/widgets.dart',
      className: 'ScrollController',
      objectLabel: 'ScrollController@0x9bb1',
      icon: Icons.swap_vert_circle_outlined,
      tint: Color(0xFF8BD89B),
      note: 'Created by widgets, owned by you — always dispose in State.',
    ),
    _SamplePayload(
      library: 'package:flutter/widgets.dart',
      className: 'TextEditingController',
      objectLabel: 'TextEditingController@0x77c4',
      icon: Icons.text_fields_outlined,
      tint: Color(0xFFB892FF),
      note: 'Wraps a ValueNotifier<TextEditingValue>; same lifecycle rules.',
    ),
    _SamplePayload(
      library: 'package:flutter/animation.dart',
      className: 'AnimationController',
      objectLabel: 'AnimationController@0x4f23',
      icon: Icons.animation,
      tint: Color(0xFFE57FB7),
      note: 'Holds a Ticker — leaking it leaks vsync callbacks.',
    ),
    _SamplePayload(
      library: 'package:my_app/state/cart.dart',
      className: 'CartModel',
      objectLabel: 'CartModel@0x12af',
      icon: Icons.shopping_basket_outlined,
      tint: Color(0xFF7DD4D4),
      note: 'User-defined ChangeNotifier; opt in by dispatching manually.',
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgPayload,
      accent: _accentPayload,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.dataset_outlined,
          accent: _accentPayload,
          number: '05',
          title: 'Sample event payloads',
          tagline: 'What real ObjectCreated events look like in the wild.',
        ),
        _paragraph(
          'A representative gallery of the (library, className, object) '
          'triples the framework emits during a typical Flutter app session. '
          'These are statically rendered: we never instantiate the listed '
          'controllers, we only show the shape of the events they would '
          'dispatch on construction. Notice that the library string is '
          'always the *defining* library, never the consumer\'s — that is '
          'what makes the class identifier globally unique without runtime '
          'reflection.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            for (final _SamplePayload p in payloads) _payloadCard(p),
          ],
        ),
      ],
    ),
  );
}

Widget _payloadCard(_SamplePayload p) {
  return Container(
    width: 250,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          p.tint.withAlpha(36),
          p.tint.withAlpha(10),
        ],
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: p.tint.withAlpha(120)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: p.tint.withAlpha(50),
          offset: const Offset(0, 4),
          blurRadius: 12,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: p.tint.withAlpha(60),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(p.icon, size: 16, color: p.tint),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                p.className,
                style: TextStyle(
                  color: p.tint,
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          p.library,
          style: const TextStyle(
            color: _textMuted,
            fontFamily: 'monospace',
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          p.objectLabel,
          style: const TextStyle(
            color: _textPrimary,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          p.note,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Decision matrix (Table)
// ---------------------------------------------------------------------------

Widget _buildDecisionMatrixSection() {
  const List<_DecisionRow> rows = <_DecisionRow>[
    _DecisionRow(
      scenario: 'New ChangeNotifier subclass',
      useIt: 'Yes',
      alternative: '—',
      rationale:
          'Frameworks expect it. Costs one extra line in the constructor.',
    ),
    _DecisionRow(
      scenario: 'Plain immutable value class',
      useIt: 'No',
      alternative: 'const ctor',
      rationale:
          'No dispose, no allocations to track, no leak surface to monitor.',
    ),
    _DecisionRow(
      scenario: 'Singleton service',
      useIt: 'No',
      alternative: 'manual logging',
      rationale:
          'A singleton outlives the app; "creation" only happens once.',
    ),
    _DecisionRow(
      scenario: 'Test fixture',
      useIt: 'Optional',
      alternative: 'addTearDown',
      rationale:
          'Useful when verifying that test code doesn\'t leak controllers.',
    ),
    _DecisionRow(
      scenario: 'Disposable resource pool',
      useIt: 'Yes',
      alternative: '—',
      rationale:
          'Each pooled object reports both create and dispose; the pool acts '
          'as the owner.',
    ),
    _DecisionRow(
      scenario: 'Hot-path inner loop',
      useIt: 'Caution',
      alternative: 'sample',
      rationale:
          'Dispatch is cheap when there are no listeners, but if DevTools is '
          'attached the listener call site is on the hot path.',
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgDecision,
      accent: _accentDecision,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.fact_check_outlined,
          accent: _accentDecision,
          number: '06',
          title: 'When to dispatch ObjectCreated',
          tagline: 'A decision matrix for opting in to memory observability.',
        ),
        _paragraph(
          'Not every class wants to be observable. Dispatching creation '
          'events has a small cost (an event object is allocated only when '
          'listeners are attached, but the call site still runs) and a '
          'larger semantic cost: you are claiming the object has a '
          'meaningful lifecycle. The matrix below summarises the common '
          'situations and the recommended choice.',
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(70),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: _accentDecision.withAlpha(80)),
          ),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2.4),
              1: FlexColumnWidth(1.0),
              2: FlexColumnWidth(1.4),
              3: FlexColumnWidth(3.4),
            },
            border: TableBorder.all(
              color: _accentDecision.withAlpha(40),
              width: 1,
            ),
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                  color: _accentDecision.withAlpha(40),
                ),
                children: const <Widget>[
                  _TableHeaderCell('Scenario'),
                  _TableHeaderCell('Use it?'),
                  _TableHeaderCell('Alternative'),
                  _TableHeaderCell('Rationale'),
                ],
              ),
              for (final _DecisionRow r in rows)
                TableRow(
                  children: <Widget>[
                    _TableBodyCell(r.scenario),
                    _TableBodyCell(r.useIt, bold: true),
                    _TableBodyCell(r.alternative, mono: true),
                    _TableBodyCell(r.rationale),
                  ],
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: _textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _TableBodyCell extends StatelessWidget {
  const _TableBodyCell(this.text, {this.bold = false, this.mono = false});
  final String text;
  final bool bold;
  final bool mono;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          color: _textSecondary,
          fontSize: 12,
          height: 1.5,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          fontFamily: mono ? 'monospace' : null,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 — Variation palette (Wrap)
// ---------------------------------------------------------------------------

Widget _buildPaletteSection() {
  // Every event in the palette is a real ObjectCreated instance; we render
  // its actual library/className without ever dispatching it.
  final List<ObjectCreated> events = <ObjectCreated>[
    ObjectCreated(
      library: 'dart:core',
      className: 'List',
      object: const <int>[1, 2, 3],
    ),
    ObjectCreated(
      library: 'dart:core',
      className: 'Map',
      object: const <String, int>{'a': 1},
    ),
    ObjectCreated(
      library: 'package:flutter/foundation.dart',
      className: 'ValueNotifier',
      object: ValueNotifier<int>(0),
    ),
    ObjectCreated(
      library: 'package:flutter/widgets.dart',
      className: 'Container',
      object: Container(),
    ),
    ObjectCreated(
      library: 'package:my_app/models/user.dart',
      className: 'User',
      object: Object(),
    ),
    ObjectCreated(
      library: 'package:my_app/services/cache.dart',
      className: 'LruCache',
      object: Object(),
    ),
    ObjectCreated(
      library: '',
      className: 'Anonymous',
      object: Object(),
    ),
    ObjectCreated(
      library: 'lib/utils.dart',
      className: 'Helper',
      object: Object(),
    ),
  ];

  const List<Color> tints = <Color>[
    Color(0xFF6BA8FF),
    Color(0xFFB892FF),
    Color(0xFF8BD89B),
    Color(0xFFFFB36B),
    Color(0xFFE57FB7),
    Color(0xFF7DD4D4),
    Color(0xFFD9C46B),
    Color(0xFFFF8A8A),
  ];

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgPalette,
      accent: _accentPalette,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.palette_outlined,
          accent: _accentPalette,
          number: '07',
          title: 'Library string variations',
          tagline: 'dart:, package:, relative paths, empty — all legal.',
        ),
        _paragraph(
          'The library field is a free-form string. The convention is the '
          'fully-qualified Dart library URI (the same string the analyzer '
          'reports), but neither the framework nor the event constructor '
          'enforce it. The palette below shows the variations you can '
          'expect to see in the wild. Listeners must NOT pattern-match on '
          'the string format; instead use \'startsWith\' or a parser to '
          'classify, and always treat unknown shapes as opaque.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            for (int i = 0; i < events.length; i++)
              _libraryChip(events[i], tints[i % tints.length]),
          ],
        ),
      ],
    ),
  );
}

Widget _libraryChip(ObjectCreated e, Color tint) {
  final String shown = e.library.isEmpty ? '(empty)' : e.library;
  return Container(
    constraints: const BoxConstraints(maxWidth: 320),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          tint.withAlpha(50),
          tint.withAlpha(14),
        ],
      ),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: tint.withAlpha(140)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          e.className,
          style: TextStyle(
            color: tint,
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '· $shown',
          style: const TextStyle(
            color: _textMuted,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Full code snippet card (dispatch + subscribe end-to-end)
// ---------------------------------------------------------------------------

Widget _buildCodeSnippetSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgCode,
      accent: _accentCode,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.terminal,
          accent: _accentCode,
          number: '08',
          title: 'End-to-end code snippet',
          tagline: 'A complete dispatch + subscribe + tear-down cycle.',
        ),
        _paragraph(
          'The snippet below shows the canonical end-to-end shape: a custom '
          'observable class dispatching its own ObjectCreated and '
          'ObjectDisposed pair, and a leak-detector subscriber that counts '
          'unmatched creations. The exception in the dispose hot path is the '
          'one thing every project gets wrong on first try — note how the '
          'dispatchObjectDisposed call sits before super.dispose() so '
          'subclasses cannot accidentally skip it.',
        ),
        _codeBlock(
          accent: _accentCode,
          caption: 'observable_widget_state.dart',
          code: 'class MyState extends ChangeNotifier {\n'
              '  MyState() {\n'
              '    if (kFlutterMemoryAllocationsEnabled) {\n'
              '      MemoryAllocations.instance.dispatchObjectCreated(\n'
              '        library: \'package:my_app/state.dart\',\n'
              '        className: \'MyState\',\n'
              '        object: this,\n'
              '      );\n'
              '    }\n'
              '  }\n\n'
              '  @override\n'
              '  void dispose() {\n'
              '    if (kFlutterMemoryAllocationsEnabled) {\n'
              '      MemoryAllocations.instance.dispatchObjectDisposed(\n'
              '        object: this,\n'
              '      );\n'
              '    }\n'
              '    super.dispose();\n'
              '  }\n'
              '}',
        ),
        _codeBlock(
          accent: _accentCode,
          caption: 'leak_detector.dart',
          code: 'final Set<int> _live = <int>{};\n\n'
              'void _leakDetector(ObjectEvent event) {\n'
              '  if (event is ObjectCreated) {\n'
              '    _live.add(identityHashCode(event.object));\n'
              '  } else if (event is ObjectDisposed) {\n'
              '    _live.remove(identityHashCode(event.object));\n'
              '  }\n'
              '}\n\n'
              'void install() {\n'
              '  MemoryAllocations.instance.addListener(_leakDetector);\n'
              '}',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Pitfall gallery (BAD vs GOOD)
// ---------------------------------------------------------------------------

Widget _buildPitfallSection() {
  const List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      title: 'Retaining event.object',
      bad: '_history.add(event);  // captures the object — leak!',
      good: '_history.add(event.className);  // capture by value',
      explanation:
          'Storing the event keeps a strong reference to the object you '
          'were supposed to merely observe. Project to a string or hash code.',
    ),
    _Pitfall(
      title: 'Anonymous listener',
      bad: 'instance.addListener((e) => print(e));',
      good: 'instance.addListener(_onEvent);  // named field/function',
      explanation:
          'You cannot removeListener an anonymous closure — the equality '
          'check is identity-based. Always use a stable reference.',
    ),
    _Pitfall(
      title: 'Throwing in the callback',
      bad: 'void cb(e) { if (e is ObjectCreated) throw \'oops\'; }',
      good: 'void cb(e) { try { ... } catch (_) { /* swallow */ } }',
      explanation:
          'Exceptions in a listener propagate to the dispatcher and break '
          'every subsequent subscriber for the same event.',
    ),
    _Pitfall(
      title: 'Forgetting kFlutterMemoryAllocationsEnabled guard',
      bad: 'instance.dispatchObjectCreated(...);  // always',
      good: 'if (kFlutterMemoryAllocationsEnabled) instance.dispatch...',
      explanation:
          'The flag tree-shakes the entire telemetry layer out of release '
          'builds when nobody opted in. Skipping the guard inflates binary '
          'size and slows the hot path.',
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgPitfalls,
      accent: _accentPitfalls,
      radial: true,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.warning_amber_outlined,
          accent: _accentPitfalls,
          number: '09',
          title: 'Pitfalls and anti-patterns',
          tagline: 'The four mistakes every codebase makes on first contact.',
        ),
        _paragraph(
          'ObjectCreated looks innocuous — three fields, no behaviour — but '
          'the four pitfalls below account for the majority of bug reports '
          'against the framework\'s memory observability layer. Each row '
          'pairs a wrong (BAD) snippet with the right (GOOD) one, plus a '
          'short explanation of the underlying invariant that the BAD code '
          'violates.',
        ),
        const SizedBox(height: 14),
        Column(
          children: <Widget>[
            for (final _Pitfall p in pitfalls) _pitfallRow(p),
          ],
        ),
      ],
    ),
  );
}

Widget _pitfallRow(_Pitfall p) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.black.withAlpha(80),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: _accentPitfalls.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.bug_report_outlined,
              size: 16,
              color: _accentPitfalls,
            ),
            const SizedBox(width: 6),
            Text(
              p.title,
              style: const TextStyle(
                color: _accentPitfalls,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _miniSnippet('BAD', p.bad, _accentPitfalls)),
            const SizedBox(width: 8),
            Expanded(child: _miniSnippet('GOOD', p.good, _accentPayload)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          p.explanation,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _miniSnippet(String label, String body, Color tint) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _codeBg,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(color: tint.withAlpha(140)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: tint,
            fontFamily: 'monospace',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(body, style: _codeStyle),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Listener simulation (StatefulBuilder)
// ---------------------------------------------------------------------------

Widget _buildSimulationSection() {
  // We pre-build a small static "event log" so the StatefulBuilder only has
  // to toggle a visual index — no async work, no real listener wiring.
  final List<ObjectCreated> log = <ObjectCreated>[
    ObjectCreated(
      library: 'package:flutter/widgets.dart',
      className: 'ScrollController',
      object: Object(),
    ),
    ObjectCreated(
      library: 'package:flutter/foundation.dart',
      className: 'ValueNotifier<int>',
      object: ValueNotifier<int>(0),
    ),
    ObjectCreated(
      library: 'package:flutter/animation.dart',
      className: 'AnimationController',
      object: Object(),
    ),
    ObjectCreated(
      library: 'package:my_app/state/cart.dart',
      className: 'CartModel',
      object: Object(),
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgListener,
      accent: _accentListener,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.receipt_long_outlined,
          accent: _accentListener,
          number: '10',
          title: 'Listener inbox simulation',
          tagline: 'What a console-style listener output would look like.',
        ),
        _paragraph(
          'This section pretends to be the rendered output of a debug '
          'listener that prints every ObjectCreated it sees. We never '
          'actually attach the listener — the events are pre-built and the '
          'StatefulBuilder lets you mark them as "acknowledged" purely for '
          'visual feedback. In a real app, this is exactly the kind of '
          'stream you would post-process into a leak report.',
        ),
        const SizedBox(height: 14),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final List<bool> ack = <bool>[false, true, false, true];
            return Container(
              decoration: BoxDecoration(
                color: _codeBg,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: _codeBorder),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.podcasts_outlined,
                        size: 14,
                        color: _accentListener,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'listener@console',
                        style: TextStyle(
                          color: _accentListener,
                          fontFamily: 'monospace',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  for (int i = 0; i < log.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            ack[i]
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 14,
                            color: ack[i]
                                ? _accentPayload
                                : _accentListener.withAlpha(160),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '[${i.toString().padLeft(2, '0')}] '
                              '${log[i].className}  '
                              '<${log[i].library}>',
                              style: _codeStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 11 — Comparison with ObjectDisposed
// ---------------------------------------------------------------------------

Widget _buildComparisonSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgLifecycle,
      accent: _accentLifecycle,
      radial: true,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.compare_arrows,
          accent: _accentLifecycle,
          number: '11',
          title: 'ObjectCreated vs ObjectDisposed',
          tagline: 'Two events, one identity, complementary fields.',
        ),
        _paragraph(
          'The two events share the same `ObjectEvent` parent and carry the '
          'same `object` reference. The created event additionally carries '
          'the (library, className) pair so leak-tracker can attribute the '
          'leak to a class without keeping the object alive. The disposed '
          'event omits the strings because by then the (library, className) '
          'is already recorded for that identity-hash — only the closing '
          'half-life signal is needed.',
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _comparisonColumn(
                title: 'ObjectCreated',
                accent: _accentIntro,
                fields: const <List<String>>[
                  <String>['library', 'String'],
                  <String>['className', 'String'],
                  <String>['object', 'Object'],
                ],
                note: 'Dispatched from constructors. Used to register the '
                    'identity-hash with the leak-tracker.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _comparisonColumn(
                title: 'ObjectDisposed',
                accent: _accentPitfalls,
                fields: const <List<String>>[
                  <String>['object', 'Object'],
                ],
                note: 'Dispatched from dispose(). Used to unregister the '
                    'identity-hash. No (library, className) needed.',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _comparisonColumn({
  required String title,
  required Color accent,
  required List<List<String>> fields,
  required String note,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withAlpha(20),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: accent.withAlpha(120)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withAlpha(40),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontFamily: 'monospace',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        for (final List<String> f in fields)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  f[0],
                  style: const TextStyle(
                    color: _textPrimary,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  ': ${f[1]}',
                  style: const TextStyle(
                    color: _textMuted,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        Text(
          note,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 11,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 12 — Reference card (DataTable)
// ---------------------------------------------------------------------------

Widget _buildReferenceSection() {
  const List<_ReferenceRow> rows = <_ReferenceRow>[
    _ReferenceRow(
      member: 'ObjectCreated',
      kind: 'class',
      summary:
          'Event dispatched when an observable object is constructed. Carries '
          '(library, className, object). Extends ObjectEvent.',
    ),
    _ReferenceRow(
      member: 'ObjectCreated.library',
      kind: 'String',
      summary:
          'The Dart library URI where the class is defined. Conventionally a '
          '"package:..." or "dart:..." string, but free-form.',
    ),
    _ReferenceRow(
      member: 'ObjectCreated.className',
      kind: 'String',
      summary:
          'The compile-time class name. Not the runtime type — generic type '
          'arguments are typically rendered as part of the string by hand.',
    ),
    _ReferenceRow(
      member: 'ObjectCreated.object',
      kind: 'Object',
      summary:
          'A reference to the object that was created. Listeners must NOT '
          'retain this reference past the callback frame.',
    ),
    _ReferenceRow(
      member: 'ObjectEvent',
      kind: 'class',
      summary:
          'Abstract base class for both ObjectCreated and ObjectDisposed. '
          'Use \'is\' to discriminate in listeners.',
    ),
    _ReferenceRow(
      member: 'MemoryAllocations.instance',
      kind: 'singleton',
      summary:
          'The global dispatcher. Has dispatchObjectCreated, '
          'dispatchObjectDisposed, addListener, removeListener.',
    ),
    _ReferenceRow(
      member: 'dispatchObjectCreated',
      kind: 'method',
      summary:
          'Allocates and dispatches an ObjectCreated. Cheap when no '
          'listeners are attached. Should be guarded by '
          'kFlutterMemoryAllocationsEnabled.',
    ),
    _ReferenceRow(
      member: 'addListener',
      kind: 'method',
      summary:
          'Attaches a `void Function(ObjectEvent)` callback. Always pair '
          'with removeListener using a stable function reference.',
    ),
    _ReferenceRow(
      member: 'kFlutterMemoryAllocationsEnabled',
      kind: 'const bool',
      summary:
          'Compile-time flag. Lets the tree-shaker drop the entire '
          'telemetry layer in release builds.',
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: _cardDecoration(
      background: _bgReference,
      accent: _accentReference,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          icon: Icons.menu_book_outlined,
          accent: _accentReference,
          number: '12',
          title: 'API reference card',
          tagline: 'Every member of the surface, with a one-line summary.',
        ),
        _paragraph(
          'A flat reference to every symbol the rest of this demo touches. '
          'Keep it on screen while reading the previous sections so you can '
          'orient between the conceptual material and the concrete API.',
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.resolveWith(
              (Set<WidgetState> _) => _accentReference.withAlpha(40),
            ),
            dataRowMinHeight: 36,
            dataRowMaxHeight: 72,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Member',
                  style: TextStyle(
                    color: _textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Kind',
                  style: TextStyle(
                    color: _textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Summary',
                  style: TextStyle(
                    color: _textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            rows: <DataRow>[
              for (final _ReferenceRow r in rows)
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 240),
                        child: Text(
                          r.member,
                          style: const TextStyle(
                            color: _accentReference,
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _accentReference.withAlpha(30),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Text(
                          r.kind,
                          style: const TextStyle(
                            color: _textPrimary,
                            fontFamily: 'monospace',
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 360),
                        child: Text(
                          r.summary,
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
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

// ---------------------------------------------------------------------------
// Top-level build()
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'ObjectCreated — Deep Visual Demo (retest)',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _bgPage,
      colorScheme: const ColorScheme.dark(
        primary: _accentIntro,
        secondary: _accentAnatomy,
        surface: _bgPage,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _textPrimary, fontSize: 13),
      ),
    ),
    home: Scaffold(
      backgroundColor: _bgPage,
      appBar: AppBar(
        backgroundColor: _bgIntro,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[_accentIntro, _accentAnatomy],
                ),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _accentIntro.withAlpha(120),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_box_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'ObjectCreated · deep visual demo',
              style: TextStyle(
                color: _textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: _accentPayload.withAlpha(40),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: _accentPayload.withAlpha(120)),
              ),
              child: const Text(
                'retest',
                style: TextStyle(
                  color: _accentPayload,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildIntroSection(),
              const SizedBox(height: 16),
              _buildAnatomySection(),
              const SizedBox(height: 16),
              _buildLifecycleSection(),
              const SizedBox(height: 16),
              _buildListenerSection(),
              const SizedBox(height: 16),
              _buildSamplePayloadsSection(),
              const SizedBox(height: 16),
              _buildDecisionMatrixSection(),
              const SizedBox(height: 16),
              _buildPaletteSection(),
              const SizedBox(height: 16),
              _buildCodeSnippetSection(),
              const SizedBox(height: 16),
              _buildPitfallSection(),
              const SizedBox(height: 16),
              _buildSimulationSection(),
              const SizedBox(height: 16),
              _buildComparisonSection(),
              const SizedBox(height: 16),
              _buildReferenceSection(),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                child: Text(
                  'end · ObjectCreated retest demo',
                  style: TextStyle(
                    color: _textMuted.withAlpha(180),
                    fontFamily: 'monospace',
                    fontSize: 11,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
