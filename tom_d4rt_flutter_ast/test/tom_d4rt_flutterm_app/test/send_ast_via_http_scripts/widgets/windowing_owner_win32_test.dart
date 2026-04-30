// D4rt AST demo: WindowingOwnerWin32 — a deep educational tour of Flutter's
// Win32 windowing owner, rendered as a "control tower" with simulated Win32
// chrome. This file is intentionally long, self-contained, and does not
// attempt to actually instantiate the (internal, experimental) windowing
// APIs. Everything is mocked in pure Flutter widgets.
//
// The subject class is `WindowingOwnerWin32` — a concrete, platform-specific
// implementation of the abstract `WindowingOwner` that lives inside the
// Flutter SDK at `package:flutter/src/widgets/_window_win32.dart`. Because
// the symbol is marked `@internal` and guarded by `isWindowingEnabled`, we
// do not import it. Instead we describe, diagram, and simulate its behavior.

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  Entry point used by the D4rt AST harness.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WindowingOwnerWin32 — Control Tower',
    home: _Wow32Shell(),
  );
}

// ---------------------------------------------------------------------------
//  Design tokens: Win32 / aero-glass inspired palette.
// ---------------------------------------------------------------------------

class _Wow32Palette {
  const _Wow32Palette();

  // Cool slate backdrop, evocative of a Win32 desktop wallpaper.
  static const Color desktopTop = Color(0xFF1E3A5F);
  static const Color desktopMid = Color(0xFF2C5178);
  static const Color desktopBottom = Color(0xFF3A6C9A);

  // Taskbar: dark steel with a faint blue tint.
  static const Color taskbarBase = Color(0xFF1C2734);
  static const Color taskbarHighlight = Color(0xFF2A394A);

  // Window chrome.
  static const Color chromeActiveTop = Color(0xFFB8CCE4);
  static const Color chromeActiveBottom = Color(0xFF7FA4C9);
  static const Color chromeInactiveTop = Color(0xFFD4D9DF);
  static const Color chromeInactiveBottom = Color(0xFFA8B1BA);

  // Panels and cards in the control-tower scaffolding.
  static const Color panelBg = Color(0xFFF3F5F8);
  static const Color panelStroke = Color(0xFFC9D1DB);
  static const Color panelStrokeStrong = Color(0xFF7A8A9E);

  // Accents.
  static const Color accentBlue = Color(0xFF2E6FC9);
  static const Color accentTeal = Color(0xFF1E8A8A);
  static const Color accentAmber = Color(0xFFD08A2A);
  static const Color accentRed = Color(0xFFC0392B);
  static const Color accentGreen = Color(0xFF2E8B57);

  // Text.
  static const Color textPrimary = Color(0xFF13202F);
  static const Color textSecondary = Color(0xFF425468);
  static const Color textMuted = Color(0xFF7A8A9E);
  static const Color textOnDark = Color(0xFFE8EEF5);

  // Code block.
  static const Color codeBg = Color(0xFF13202F);
  static const Color codeAccent = Color(0xFF6FAEE8);
  static const Color codeText = Color(0xFFDCE4EE);
}

// Text styles tuned to feel Segoe-flavored. We cannot guarantee the font is
// actually installed, so we rely on system sans-serif fallbacks and tune the
// weight/tracking to approximate a Win32 feel.
class _Wow32TextStyles {
  const _Wow32TextStyles();

  static const TextStyle pageTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 30,
    fontWeight: FontWeight.w300,
    color: _Wow32Palette.textOnDark,
    letterSpacing: 0.25,
    height: 1.1,
  );

  static const TextStyle pageSubtitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFFB7C4D6),
    height: 1.4,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: _Wow32Palette.textPrimary,
    letterSpacing: 0.15,
  );

  static const TextStyle sectionIntro = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _Wow32Palette.textSecondary,
    height: 1.45,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: _Wow32Palette.textPrimary,
    letterSpacing: 0.1,
  );

  static const TextStyle cardBody = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: _Wow32Palette.textSecondary,
    height: 1.45,
  );

  static const TextStyle label = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: _Wow32Palette.textMuted,
    letterSpacing: 1.3,
  );

  static const TextStyle code = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    color: _Wow32Palette.codeText,
    height: 1.45,
  );

  static const TextStyle logLine = TextStyle(
    fontFamily: 'monospace',
    fontSize: 11.5,
    fontWeight: FontWeight.w400,
    color: _Wow32Palette.textSecondary,
    height: 1.35,
  );
}

// ---------------------------------------------------------------------------
//  Desktop backdrop painter — simulates a Win32 wallpaper and taskbar.
// ---------------------------------------------------------------------------

class _Wow32DesktopBackdropPainter extends CustomPainter {
  _Wow32DesktopBackdropPainter({required this.clockText});

  final String clockText;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;

    // Wallpaper gradient.
    final Paint gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          _Wow32Palette.desktopTop,
          _Wow32Palette.desktopMid,
          _Wow32Palette.desktopBottom,
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ).createShader(bounds);
    canvas.drawRect(bounds, gradientPaint);

    // Subtle radial spotlight in the upper-left, evoking a Vista-era gloss.
    final Paint spotlight = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.6, -0.8),
        radius: 0.9,
        colors: <Color>[
          Colors.white.withValues(alpha: 0.12),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(bounds);
    canvas.drawRect(bounds, spotlight);

    // Scan-line grid hinting at pixel density, very faint.
    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1.0;
    for (double y = 0; y < size.height; y += 48) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (double x = 0; x < size.width; x += 64) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    // Taskbar strip along the bottom.
    const double taskbarHeight = 44;
    final Rect taskbar = Rect.fromLTWH(
      0,
      size.height - taskbarHeight,
      size.width,
      taskbarHeight,
    );
    final Paint taskbarPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          _Wow32Palette.taskbarHighlight,
          _Wow32Palette.taskbarBase,
        ],
      ).createShader(taskbar);
    canvas.drawRect(taskbar, taskbarPaint);

    // Thin blue glow line along the top edge of the taskbar.
    final Paint taskbarGlow = Paint()
      ..color = const Color(0xFF3A78C0).withValues(alpha: 0.55)
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(0, taskbar.top),
      Offset(size.width, taskbar.top),
      taskbarGlow,
    );

    // Start button — rounded pill with a Windows-flag mark.
    final Rect startBtn = Rect.fromLTWH(10, taskbar.top + 6, 52, 32);
    final RRect startRR = RRect.fromRectAndRadius(
      startBtn,
      const Radius.circular(4),
    );
    final Paint startFill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          const Color(0xFF2A4C7A).withValues(alpha: 0.9),
          const Color(0xFF1A3556).withValues(alpha: 0.9),
        ],
      ).createShader(startBtn);
    canvas.drawRRect(startRR, startFill);
    canvas.drawRRect(
      startRR,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = const Color(0xFF4F7DB5).withValues(alpha: 0.8),
    );
    _paintWindowsFlag(canvas, Rect.fromLTWH(startBtn.left + 14, startBtn.top + 6, 22, 20));

    // Pinned taskbar icons (three faux squares).
    for (int i = 0; i < 3; i++) {
      final Rect icon = Rect.fromLTWH(
        72.0 + i * 44.0,
        taskbar.top + 8,
        32,
        28,
      );
      final RRect iconRR = RRect.fromRectAndRadius(icon, const Radius.circular(3));
      canvas.drawRRect(
        iconRR,
        Paint()..color = Colors.white.withValues(alpha: 0.06),
      );
      canvas.drawRRect(
        iconRR,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.white.withValues(alpha: 0.14),
      );
      final TextPainter glyph = TextPainter(
        text: TextSpan(
          text: <String>['F', 'E', 'V'][i],
          style: const TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFFBDD1EA),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      glyph.paint(
        canvas,
        Offset(
          icon.left + (icon.width - glyph.width) / 2,
          icon.top + (icon.height - glyph.height) / 2,
        ),
      );
    }

    // Tray clock on the right.
    final TextPainter clockPainter = TextPainter(
      text: TextSpan(
        text: clockText,
        style: const TextStyle(
          fontFamily: 'Segoe UI',
          fontSize: 12,
          color: _Wow32Palette.textOnDark,
          height: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    clockPainter.paint(
      canvas,
      Offset(
        size.width - clockPainter.width - 14,
        taskbar.top + (taskbarHeight - clockPainter.height) / 2,
      ),
    );

    // Tray separator line.
    final Paint traySep = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    final double sepX = size.width - clockPainter.width - 28;
    canvas.drawLine(
      Offset(sepX, taskbar.top + 8),
      Offset(sepX, taskbar.bottom - 8),
      traySep,
    );
  }

  void _paintWindowsFlag(Canvas canvas, Rect rect) {
    final double cw = rect.width / 2;
    final double ch = rect.height / 2;
    const List<Color> quadColors = <Color>[
      Color(0xFFF25022), // top-left (red)
      Color(0xFF7FBA00), // top-right (green)
      Color(0xFF00A4EF), // bottom-left (blue)
      Color(0xFFFFB900), // bottom-right (amber)
    ];
    for (int r = 0; r < 2; r++) {
      for (int c = 0; c < 2; c++) {
        final Rect quad = Rect.fromLTWH(
          rect.left + c * cw + 1,
          rect.top + r * ch + 1,
          cw - 2,
          ch - 2,
        );
        canvas.drawRect(quad, Paint()..color = quadColors[r * 2 + c]);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _Wow32DesktopBackdropPainter old) {
    return old.clockText != clockText;
  }
}

// ---------------------------------------------------------------------------
//  Win32-style window chrome painter.
// ---------------------------------------------------------------------------

enum _Wow32WindowKind { regular, dialog, popup, tooltip }

class _Wow32ChromePainter extends CustomPainter {
  _Wow32ChromePainter({
    required this.focused,
    required this.kind,
    required this.pulse,
  });

  final bool focused;
  final _Wow32WindowKind kind;
  final double pulse; // 0..1, used to animate focus glow.

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;
    const double titleBarH = 30;
    final Rect titleRect = Rect.fromLTWH(0, 0, size.width, titleBarH);
    final Rect bodyRect = Rect.fromLTWH(0, titleBarH, size.width, size.height - titleBarH);

    // Body background.
    canvas.drawRect(
      bodyRect,
      Paint()..color = const Color(0xFFFAFBFD),
    );

    // Title bar gradient — aero-ish.
    final List<Color> topColors = focused
        ? <Color>[_Wow32Palette.chromeActiveTop, _Wow32Palette.chromeActiveBottom]
        : <Color>[_Wow32Palette.chromeInactiveTop, _Wow32Palette.chromeInactiveBottom];
    final Paint titlePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: topColors,
      ).createShader(titleRect);
    canvas.drawRect(titleRect, titlePaint);

    // Soft inner highlight on the top edge of the title bar.
    final Paint highlight = Paint()
      ..color = Colors.white.withValues(alpha: focused ? 0.45 : 0.25)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, 0.5),
      Offset(size.width, 0.5),
      highlight,
    );

    // Focus pulse — a subtle cyan glow under the title bar when focused.
    if (focused) {
      final Paint glow = Paint()
        ..color = const Color(0xFF6FAEE8)
            .withValues(alpha: 0.15 + 0.15 * pulse)
        ..strokeWidth = 1.5;
      canvas.drawLine(
        Offset(0, titleBarH - 0.75),
        Offset(size.width, titleBarH - 0.75),
        glow,
      );
    }

    // Frame border.
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = focused
          ? const Color(0xFF4A6B90)
          : const Color(0xFF8A97A7);
    canvas.drawRect(bounds.deflate(0.5), border);

    // Title bar / body separator.
    final Paint sep = Paint()
      ..color = focused
          ? const Color(0xFF4A6B90).withValues(alpha: 0.6)
          : const Color(0xFF8A97A7).withValues(alpha: 0.6)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, titleBarH),
      Offset(size.width, titleBarH),
      sep,
    );

    // Faux app icon on the left (Win32 titlebar convention).
    _paintAppIcon(canvas, Rect.fromLTWH(6, 7, 16, 16));

    // Control buttons on the right: min, max, close (kind-dependent).
    _paintControlButtons(canvas, titleRect);

    // Kind badge painted faintly in the body (e.g. "REGULAR", "DIALOG").
    final TextPainter badge = TextPainter(
      text: TextSpan(
        text: _kindLabel(kind),
        style: TextStyle(
          fontFamily: 'Segoe UI',
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          color: const Color(0xFF13202F).withValues(alpha: 0.12),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    badge.paint(
      canvas,
      Offset(size.width - badge.width - 10, size.height - badge.height - 8),
    );
  }

  void _paintAppIcon(Canvas canvas, Rect rect) {
    // A small four-quadrant flag.
    final double cw = rect.width / 2;
    final double ch = rect.height / 2;
    const List<Color> flag = <Color>[
      Color(0xFF2E6FC9),
      Color(0xFF2E8B57),
      Color(0xFFD08A2A),
      Color(0xFFC0392B),
    ];
    for (int r = 0; r < 2; r++) {
      for (int c = 0; c < 2; c++) {
        final Rect quad = Rect.fromLTWH(
          rect.left + c * cw + 0.5,
          rect.top + r * ch + 0.5,
          cw - 1,
          ch - 1,
        );
        canvas.drawRect(quad, Paint()..color = flag[r * 2 + c]);
      }
    }
  }

  void _paintControlButtons(Canvas canvas, Rect titleRect) {
    // Width per button. Rightmost is always close (unless disabled for
    // modeless dialog; we paint a disabled state).
    const double bw = 34;
    const double bh = 22;
    final double y = titleRect.top + (titleRect.height - bh) / 2;
    final List<_ButtonSpec> specs = switch (kind) {
      _Wow32WindowKind.regular => const <_ButtonSpec>[
        _ButtonSpec(glyph: _Glyph.minimize, enabled: true, close: false),
        _ButtonSpec(glyph: _Glyph.maximize, enabled: true, close: false),
        _ButtonSpec(glyph: _Glyph.close, enabled: true, close: true),
      ],
      _Wow32WindowKind.dialog => const <_ButtonSpec>[
        _ButtonSpec(glyph: _Glyph.minimize, enabled: true, close: false),
        _ButtonSpec(glyph: _Glyph.close, enabled: false, close: true),
      ],
      _Wow32WindowKind.popup => const <_ButtonSpec>[],
      _Wow32WindowKind.tooltip => const <_ButtonSpec>[],
    };

    double right = titleRect.right - 2;
    for (int i = specs.length - 1; i >= 0; i--) {
      final _ButtonSpec s = specs[i];
      final Rect btn = Rect.fromLTWH(right - bw, y, bw, bh);
      right -= bw;
      final Color bg = s.close
          ? (s.enabled
              ? const Color(0xFFE81123).withValues(alpha: 0.0)
              : Colors.transparent)
          : Colors.transparent;
      canvas.drawRect(btn, Paint()..color = bg);
      _paintGlyph(canvas, btn, s.glyph, s.enabled);
    }
  }

  void _paintGlyph(Canvas canvas, Rect btn, _Glyph glyph, bool enabled) {
    final Paint p = Paint()
      ..color = enabled
          ? _Wow32Palette.textPrimary.withValues(alpha: 0.85)
          : _Wow32Palette.textMuted.withValues(alpha: 0.4)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;
    final Offset c = btn.center;
    switch (glyph) {
      case _Glyph.minimize:
        canvas.drawLine(
          Offset(c.dx - 5, c.dy + 3),
          Offset(c.dx + 5, c.dy + 3),
          p,
        );
      case _Glyph.maximize:
        canvas.drawRect(
          Rect.fromCenter(center: c, width: 10, height: 8),
          p,
        );
      case _Glyph.close:
        canvas.drawLine(
          Offset(c.dx - 5, c.dy - 4),
          Offset(c.dx + 5, c.dy + 4),
          p,
        );
        canvas.drawLine(
          Offset(c.dx - 5, c.dy + 4),
          Offset(c.dx + 5, c.dy - 4),
          p,
        );
    }
  }

  String _kindLabel(_Wow32WindowKind k) {
    return switch (k) {
      _Wow32WindowKind.regular => 'REGULAR',
      _Wow32WindowKind.dialog => 'DIALOG',
      _Wow32WindowKind.popup => 'POPUP',
      _Wow32WindowKind.tooltip => 'TOOLTIP',
    };
  }

  @override
  bool shouldRepaint(covariant _Wow32ChromePainter old) {
    return old.focused != focused || old.kind != kind || old.pulse != pulse;
  }
}

enum _Glyph { minimize, maximize, close }

class _ButtonSpec {
  const _ButtonSpec({
    required this.glyph,
    required this.enabled,
    required this.close,
  });
  final _Glyph glyph;
  final bool enabled;
  final bool close;
}

// ---------------------------------------------------------------------------
//  Event routing diagram painter.
// ---------------------------------------------------------------------------

class _Wow32RoutingPainter extends CustomPainter {
  _Wow32RoutingPainter({required this.highlightedHop, required this.progress});

  final int highlightedHop; // 0..4, -1 for none.
  final double progress; // 0..1, for flowing dashed line.

  static const List<String> _hops = <String>[
    'OS event (e.g. WM_SIZE)',
    'Win32 message loop',
    'Flutter engine / windowing bridge',
    'WindowingOwnerWin32._onMessage',
    'Framework (WidgetsBinding + frame)',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF7F9FC);
    canvas.drawRect(Offset.zero & size, bg);

    final double boxW = (size.width - 80) / _hops.length;
    const double boxH = 58;
    final double y = (size.height - boxH) / 2;

    final List<Rect> boxes = <Rect>[];
    for (int i = 0; i < _hops.length; i++) {
      final Rect r = Rect.fromLTWH(
        20 + i * (boxW + (i == 0 ? 0 : 0)) + (i * 10),
        y,
        boxW - 10,
        boxH,
      );
      boxes.add(r);
    }

    // Connector arrows.
    for (int i = 0; i < boxes.length - 1; i++) {
      final Offset a = boxes[i].centerRight;
      final Offset b = boxes[i + 1].centerLeft;
      final Paint line = Paint()
        ..color = const Color(0xFFB7C4D6)
        ..strokeWidth = 1.5;
      canvas.drawLine(a, b, line);
      // Arrow head.
      final Paint head = Paint()
        ..color = const Color(0xFF7A8A9E)
        ..style = PaintingStyle.fill;
      final Path p = Path()
        ..moveTo(b.dx - 6, b.dy - 4)
        ..lineTo(b.dx, b.dy)
        ..lineTo(b.dx - 6, b.dy + 4)
        ..close();
      canvas.drawPath(p, head);
    }

    // Flowing dashed line overlay to indicate active message traffic.
    final Paint dash = Paint()
      ..color = _Wow32Palette.accentBlue.withValues(alpha: 0.75)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < boxes.length - 1; i++) {
      final Offset a = boxes[i].centerRight;
      final Offset b = boxes[i + 1].centerLeft;
      final double seg = 6.0;
      final double gap = 6.0;
      final double total = (b.dx - a.dx);
      double x = a.dx + (progress * (seg + gap)) % (seg + gap) - seg;
      while (x < b.dx) {
        final double x0 = math.max(a.dx, x);
        final double x1 = math.min(b.dx, x + seg);
        if (x1 > x0) {
          canvas.drawLine(
            Offset(x0, a.dy),
            Offset(x1, a.dy),
            dash,
          );
        }
        x += seg + gap;
      }
      // Reference `total` so the analyzer doesn't complain of unused value.
      // (It influences the offset step via `progress`, but we keep it local.)
      assert(total >= 0);
    }

    // Boxes.
    for (int i = 0; i < boxes.length; i++) {
      final Rect r = boxes[i];
      final bool hit = i == highlightedHop;
      final Paint fill = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: hit
              ? <Color>[
                  _Wow32Palette.accentBlue.withValues(alpha: 0.95),
                  _Wow32Palette.accentBlue.withValues(alpha: 0.80),
                ]
              : <Color>[
                  Colors.white,
                  const Color(0xFFE7ECF3),
                ],
        ).createShader(r);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(6)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(6)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = hit
              ? _Wow32Palette.accentBlue
              : _Wow32Palette.panelStrokeStrong.withValues(alpha: 0.6),
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: _hops[i],
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: hit ? Colors.white : _Wow32Palette.textPrimary,
            height: 1.2,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: r.width - 8);
      tp.paint(
        canvas,
        Offset(
          r.left + (r.width - tp.width) / 2,
          r.top + (r.height - tp.height) / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _Wow32RoutingPainter old) {
    return old.highlightedHop != highlightedHop || old.progress != progress;
  }
}

// ---------------------------------------------------------------------------
//  Lifecycle timeline painter.
// ---------------------------------------------------------------------------

class _Wow32TimelinePainter extends CustomPainter {
  _Wow32TimelinePainter({required this.stage, required this.stageCount});

  final double stage; // 0..stageCount-1
  final int stageCount;

  @override
  void paint(Canvas canvas, Size size) {
    final double padding = 24;
    final double y = size.height / 2;
    final double x0 = padding;
    final double x1 = size.width - padding;

    // Base line.
    canvas.drawLine(
      Offset(x0, y),
      Offset(x1, y),
      Paint()
        ..color = _Wow32Palette.panelStroke
        ..strokeWidth = 3,
    );

    // Progressed portion.
    final double progressX = x0 + (x1 - x0) * (stage / (stageCount - 1));
    canvas.drawLine(
      Offset(x0, y),
      Offset(progressX, y),
      Paint()
        ..color = _Wow32Palette.accentBlue
        ..strokeWidth = 3,
    );

    // Ticks.
    for (int i = 0; i < stageCount; i++) {
      final double tx = x0 + (x1 - x0) * (i / (stageCount - 1));
      final bool reached = i <= stage + 0.01;
      canvas.drawCircle(
        Offset(tx, y),
        6,
        Paint()
          ..color = reached
              ? _Wow32Palette.accentBlue
              : Colors.white,
      );
      canvas.drawCircle(
        Offset(tx, y),
        6,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = reached
              ? _Wow32Palette.accentBlue
              : _Wow32Palette.panelStrokeStrong,
      );
    }

    // Moving cursor.
    canvas.drawCircle(
      Offset(progressX, y),
      10,
      Paint()
        ..color = _Wow32Palette.accentBlue.withValues(alpha: 0.22),
    );
    canvas.drawCircle(
      Offset(progressX, y),
      5,
      Paint()
        ..color = Colors.white,
    );
    canvas.drawCircle(
      Offset(progressX, y),
      5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = _Wow32Palette.accentBlue,
    );
  }

  @override
  bool shouldRepaint(covariant _Wow32TimelinePainter old) {
    return old.stage != stage || old.stageCount != stageCount;
  }
}

// ---------------------------------------------------------------------------
//  Main shell.
// ---------------------------------------------------------------------------

class _Wow32Shell extends StatefulWidget {
  const _Wow32Shell();

  @override
  State<_Wow32Shell> createState() => _Wow32ShellState();
}

class _Wow32ShellState extends State<_Wow32Shell>
    with TickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final AnimationController _lifecycleCtrl;
  late final AnimationController _routingCtrl;

  final List<String> _log = <String>[
    '[boot] WindowingOwnerWin32 control tower initialized',
    '[sim ] This demo does not touch the real @internal API',
  ];
  int _highlightedHop = -1;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _lifecycleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();

    _routingCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _lifecycleCtrl.dispose();
    _routingCtrl.dispose();
    super.dispose();
  }

  void _addLog(String line) {
    setState(() {
      _log.insert(0, line);
      if (_log.length > 80) {
        _log.removeRange(80, _log.length);
      }
    });
    debugPrint('[Wow32] $line');
  }

  void _highlightHop(int index) {
    setState(() => _highlightedHop = index);
    _addLog('[hop ] Highlighted routing hop #$index');
  }

  String get _clockText {
    final DateTime now = DateTime.now();
    final String hh = now.hour.toString().padLeft(2, '0');
    final String mm = now.minute.toString().padLeft(2, '0');
    return '$hh:$mm\n${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Wow32Palette.desktopTop,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Painted desktop backdrop behind everything.
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _Wow32DesktopBackdropPainter(clockText: _clockText),
              ),
            ),
          ),

          // Scrollable content column, padded so the taskbar remains visible.
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 52),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(child: _buildHeader()),
                    SliverToBoxAdapter(child: _Wow32Section1Dossier()),
                    SliverToBoxAdapter(child: _Wow32Section2Anatomy()),
                    SliverToBoxAdapter(
                      child: _Wow32Section3Chrome(
                        pulseCtrl: _pulseCtrl,
                        onChromeEvent: _addLog,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _Wow32Section4Lifecycle(controller: _lifecycleCtrl),
                    ),
                    const SliverToBoxAdapter(child: _Wow32Section5TypeGallery()),
                    const SliverToBoxAdapter(child: _Wow32Section6PlatformMatrix()),
                    SliverToBoxAdapter(
                      child: _Wow32Section7Routing(
                        controller: _routingCtrl,
                        highlightedHop: _highlightedHop,
                        onHopTap: _highlightHop,
                      ),
                    ),
                    const SliverToBoxAdapter(child: _Wow32Section8Recipes()),
                    const SliverToBoxAdapter(child: _Wow32Section9Comparison()),
                    SliverToBoxAdapter(child: _Wow32Section10Glossary(log: _log)),
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.window,
              size: 28,
              color: _Wow32Palette.textOnDark,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'WindowingOwnerWin32',
                  style: _Wow32TextStyles.pageTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  'Control tower: a deep tour of Flutter\'s Win32 '
                  'windowing owner — from HWND message plumbing to '
                  'RegularWindow / DialogWindow / PopupWindow controllers.',
                  style: _Wow32TextStyles.pageSubtitle,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: const <Widget>[
                    _Pill(
                      text: '@internal',
                      color: _Wow32Palette.accentAmber,
                    ),
                    _Pill(
                      text: 'experimental',
                      color: _Wow32Palette.accentRed,
                    ),
                    _Pill(
                      text: 'Windows only',
                      color: _Wow32Palette.accentBlue,
                    ),
                    _Pill(
                      text: 'extends WindowingOwner',
                      color: _Wow32Palette.accentTeal,
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

// ---------------------------------------------------------------------------
//  Generic building blocks reused across sections.
// ---------------------------------------------------------------------------

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Segoe UI',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          color: color,
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _Wow32Palette.panelBg.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Wow32Palette.panelStroke),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title, style: _Wow32TextStyles.sectionTitle),
          if (subtitle != null) ...<Widget>[
            const SizedBox(height: 6),
            Text(subtitle!, style: _Wow32TextStyles.sectionIntro),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.body,
    this.icon,
    this.accent = _Wow32Palette.accentBlue,
  });

  final String title;
  final String body;
  final IconData? icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Wow32Palette.panelStroke),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Icon(icon ?? Icons.memory, size: 16, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title, style: _Wow32TextStyles.cardTitle),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(body, style: _Wow32TextStyles.cardBody),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code, this.caption});

  final String code;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _Wow32Palette.codeBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _Wow32Palette.codeAccent.withValues(alpha: 0.25),
            ),
          ),
          child: SelectableText(code, style: _Wow32TextStyles.code),
        ),
        if (caption != null) ...<Widget>[
          const SizedBox(height: 6),
          Text(
            caption!,
            style: _Wow32TextStyles.cardBody.copyWith(
              fontStyle: FontStyle.italic,
              color: _Wow32Palette.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}

class _DataTableLite extends StatelessWidget {
  const _DataTableLite({required this.headers, required this.rows});

  final List<String> headers;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Wow32Palette.panelStroke),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE7ECF3),
              borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                for (final String h in headers)
                  Expanded(
                    child: Text(
                      h,
                      style: _Wow32TextStyles.label.copyWith(
                        color: _Wow32Palette.textPrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i.isEven ? Colors.white : const Color(0xFFF8FAFC),
                border: const Border(
                  top: BorderSide(color: _Wow32Palette.panelStroke, width: 0.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final String c in rows[i])
                    Expanded(
                      child: Text(c, style: _Wow32TextStyles.cardBody),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Section 1 — Dossier.
// ---------------------------------------------------------------------------

class _Wow32Section1Dossier extends StatelessWidget {
  const _Wow32Section1Dossier();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '1. Dossier',
      subtitle:
          'Six framing cards describing what WindowingOwnerWin32 is, where it '
          'fits in Flutter\'s multi-window abstraction, and how applications '
          'obtain an owner via WidgetsBinding.instance.windowingOwner.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints cons) {
          final int cols = cons.maxWidth >= 900 ? 3 : 2;
          return GridView.count(
            crossAxisCount: cols,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.35,
            children: const <Widget>[
              _Card(
                title: 'What it is',
                body:
                    'A concrete implementation of the abstract WindowingOwner '
                    'for the Win32 platform. It owns native HWND creation, '
                    'dispatches WndProc messages, and returns controllers for '
                    'regular and dialog windows.',
                icon: Icons.layers_outlined,
                accent: _Wow32Palette.accentBlue,
              ),
              _Card(
                title: 'Role in multi-window',
                body:
                    'Sits between WidgetsBinding and the engine\'s Windows '
                    'embedder. Each platform — Win32, macOS, Linux — ships '
                    'a sibling owner; the framework picks one at startup via '
                    'createDefaultWindowingOwner().',
                icon: Icons.hub_outlined,
                accent: _Wow32Palette.accentTeal,
              ),
              _Card(
                title: 'Platform gating',
                body:
                    'The constructor asserts Platform.isWindows and '
                    'isWindowingEnabled. On any other OS (or when the feature '
                    'flag is off) it throws UnsupportedError with the canonical '
                    'experimental-API message.',
                icon: Icons.shield_outlined,
                accent: _Wow32Palette.accentAmber,
              ),
              _Card(
                title: 'Contract fulfilled',
                body:
                    'Overrides createRegularWindowController and '
                    'createDialogWindowController with Win32 subclasses. '
                    'createTooltipWindowController and createPopupWindowController '
                    'currently throw UnimplementedError — Win32 does not yet '
                    'implement those flavors.',
                icon: Icons.checklist_rtl_outlined,
                accent: _Wow32Palette.accentGreen,
              ),
              _Card(
                title: 'Lifecycle events',
                body:
                    'WM_CLOSE → delegate.onWindowCloseRequested. '
                    'WM_DESTROY → delegate.onWindowDestroyed and handler '
                    'removal. WM_SIZE and WM_ACTIVATE → notifyListeners on '
                    'the controller so widgets rebuild.',
                icon: Icons.timeline_outlined,
                accent: _Wow32Palette.accentRed,
              ),
              _Card(
                title: 'Obtaining the owner',
                body:
                    'Applications do not instantiate WindowingOwnerWin32 '
                    'directly. They read WidgetsBinding.instance.windowingOwner '
                    '(set at binding init by createDefaultWindowingOwner()), '
                    'or simply use RegularWindowController()/DialogWindowController() '
                    'factories, which internally call the owner.',
                icon: Icons.api_outlined,
                accent: _Wow32Palette.accentBlue,
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Section 2 — Anatomy.
// ---------------------------------------------------------------------------

class _Wow32Section2Anatomy extends StatelessWidget {
  const _Wow32Section2Anatomy();

  static const String _classDecl = '''
// package:flutter/src/widgets/_window_win32.dart
@internal
class WindowingOwnerWin32 extends WindowingOwner {
  WindowingOwnerWin32() : allocator = _CallocAllocator() {
    if (!isWindowingEnabled) {
      throw UnsupportedError('Windowing APIs are not enabled.');
    }
    if (!Platform.isWindows) {
      throw UnsupportedError('Only available on the Win32 platform');
    }
    _Win32PlatformInterface.initializeWindowing(
      allocator,
      WidgetsBinding.instance.platformDispatcher.engineId!,
      _onMessage,
    );
  }

  final ffi.Allocator allocator;
  final List<_WindowsMessageHandler> _messageHandlers = <_WindowsMessageHandler>[];

  @override
  RegularWindowController createRegularWindowController({ ... });
  @override
  DialogWindowController createDialogWindowController({ ... });
  @override
  TooltipWindowController createTooltipWindowController({ ... }); // throws
  @override
  PopupWindowController createPopupWindowController({ ... });     // throws

  void _onMessage(ffi.Pointer<_WindowsMessage> message) { ... }
}''';

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '2. Anatomy',
      subtitle:
          'The class declaration, pulled verbatim from the pinned Flutter SDK '
          '(shape-preserving trim), followed by the exposed method/getter '
          'surface on the controllers it produces.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _CodeBlock(
            code: _classDecl,
            caption:
                'WindowingOwnerWin32 is @internal — it is not exported through '
                '`package:flutter/widgets.dart`. Applications interact with it '
                'only through WindowingOwner and the public controller factories.',
          ),
          const SizedBox(height: 16),
          Text(
            'RegularWindowControllerWin32 — visible surface',
            style: _Wow32TextStyles.cardTitle,
          ),
          const SizedBox(height: 8),
          _DataTableLite(
            headers: const <String>['Member', 'Kind', 'Purpose'],
            rows: const <List<String>>[
              <String>['contentSize', 'getter (Size)',
                  'Reports drawable area; calls GetWindowRect on the HWND.'],
              <String>['title', 'getter (String)',
                  'GetWindowTextW on the HWND via the owner\'s allocator.'],
              <String>['isActivated', 'getter (bool)',
                  'True iff GetForegroundWindow() equals the window\'s HWND.'],
              <String>['isMaximized', 'getter (bool)',
                  'Wraps the IsZoomed() Win32 API.'],
              <String>['isMinimized', 'getter (bool)',
                  'Wraps the IsIconic() Win32 API.'],
              <String>['isFullscreen', 'getter (bool)',
                  'Queries the Flutter engine fullscreen flag for the HWND.'],
              <String>['setSize(size)', 'method',
                  'Requests a content-size change; platform may clamp.'],
              <String>['setConstraints(c)', 'method',
                  'Sets min/max constraints; notifyListeners afterwards.'],
              <String>['setTitle(t)', 'method',
                  'SetWindowTextW on the HWND; notifyListeners.'],
              <String>['activate()', 'method',
                  'ShowWindow(SW_RESTORE) — brings to front if possible.'],
              <String>['setMaximized(b)', 'method',
                  'ShowWindow(SW_MAXIMIZE) or SW_RESTORE.'],
              <String>['setMinimized(b)', 'method',
                  'ShowWindow(SW_MINIMIZE) or SW_RESTORE.'],
              <String>['setFullscreen(b)', 'method',
                  'Delegates to engine fullscreen transition.'],
              <String>['getWindowHandle()', 'method',
                  'Returns the raw HWND (Pointer<Void>) — internal only.'],
              <String>['destroy()', 'method',
                  'DestroyWindow + idempotent; fires WM_DESTROY via the loop.'],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'DialogWindowControllerWin32 — visible surface',
            style: _Wow32TextStyles.cardTitle,
          ),
          const SizedBox(height: 8),
          _DataTableLite(
            headers: const <String>['Member', 'Kind', 'Purpose'],
            rows: const <List<String>>[
              <String>['parent', 'getter',
                  'Parent BaseWindowController or null (modeless).'],
              <String>['contentSize/title/isActivated', 'getters',
                  'Mirror the regular controller\'s HWND queries.'],
              <String>['isMinimized', 'getter',
                  'IsIconic() — dialogs may minimize but not maximize.'],
              <String>['setSize/setConstraints/setTitle', 'methods',
                  'As on the regular controller; honored by the platform.'],
              <String>['activate()', 'method',
                  'SW_RESTORE — parent dialogs may not take focus away.'],
              <String>['setMinimized(b)', 'method',
                  'No-op when parent != null (modal dialogs can\'t minimize).'],
              <String>['destroy()', 'method',
                  'DestroyWindow; idempotent.'],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Message handling',
            style: _Wow32TextStyles.cardTitle,
          ),
          const SizedBox(height: 8),
          const _CodeBlock(
            code: '''
abstract class _WindowsMessageHandler {
  int? handleWindowsMessage(
    FlutterView view,
    HWND windowHandle,
    int message,
    int wParam,
    int lParam,
  );
}

// Delivered message → _onMessage → each handler in registration order.
// Returning non-null stops propagation and becomes the LRESULT.
// WM_CLOSE   → delegate.onWindowCloseRequested(this)
// WM_DESTROY → delegate.onWindowDestroyed()
// WM_SIZE    → notifyListeners()
// WM_ACTIVATE→ notifyListeners()
''',
            caption:
                '_WindowsMessageHandler is private. Each controller registers '
                'a thin adapter that forwards to its _handleWindowsMessage.',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Section 3 — Simulated Win32 window chrome.
// ---------------------------------------------------------------------------

class _Wow32Section3Chrome extends StatefulWidget {
  const _Wow32Section3Chrome({
    required this.pulseCtrl,
    required this.onChromeEvent,
  });

  final AnimationController pulseCtrl;
  final void Function(String) onChromeEvent;

  @override
  State<_Wow32Section3Chrome> createState() => _Wow32Section3ChromeState();
}

class _Wow32Section3ChromeState extends State<_Wow32Section3Chrome> {
  int _focusedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<_ChromeSpec> specs = <_ChromeSpec>[
      const _ChromeSpec(
        kind: _Wow32WindowKind.regular,
        title: 'Notepad — Untitled.txt',
        body:
            'This is a simulated RegularWindowControllerWin32 frame.\n'
            'Clicking the minimize / maximize / close buttons emits\n'
            'log entries below. Behind the scenes the real controller\n'
            'would translate these to ShowWindow(SW_*) or '
            'DestroyWindow calls.',
        width: 440,
        height: 160,
      ),
      const _ChromeSpec(
        kind: _Wow32WindowKind.dialog,
        title: 'Confirm delete',
        body:
            'Modal DialogWindowControllerWin32. Parent != null, so the\n'
            'close button is disabled (the user must answer the dialog)\n'
            'and setMinimized() becomes a no-op while the parent is\n'
            'active.',
        width: 380,
        height: 150,
      ),
      const _ChromeSpec(
        kind: _Wow32WindowKind.popup,
        title: '',
        body:
            'Popup / context menu.\n'
            'createPopupWindowController currently throws\n'
            'UnimplementedError on Win32 — popups are not yet\n'
            'backed by a real HWND.',
        width: 240,
        height: 120,
      ),
    ];

    return _Panel(
      title: '3. Simulated Win32 chrome',
      subtitle:
          'Three windows painted entirely in Flutter widgets. Only one is '
          'focused at a time; the focused frame gets the active aero gradient '
          'and a soft cyan glow pulsed by an AnimationController.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints cons) {
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: <Widget>[
              for (int i = 0; i < specs.length; i++)
                _buildChromeFrame(specs[i], i),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChromeFrame(_ChromeSpec spec, int index) {
    final bool focused = _focusedIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() => _focusedIndex = index);
          widget.onChromeEvent(
            '[focus] ${spec.kind.name} "${spec.title.isEmpty ? "(no title)" : spec.title}" '
            'now activated (WM_ACTIVATE simulated)',
          );
        },
        child: SizedBox(
          width: spec.width,
          height: spec.height,
          child: AnimatedBuilder(
            animation: widget.pulseCtrl,
            builder: (BuildContext ctx, Widget? child) {
              return CustomPaint(
                painter: _Wow32ChromePainter(
                  focused: focused,
                  kind: spec.kind,
                  pulse: widget.pulseCtrl.value,
                ),
                child: child,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        spec.body,
                        style: _Wow32TextStyles.cardBody.copyWith(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ),
                  // Invisible hit targets over title buttons, so clicks
                  // produce log output without interfering with the painter.
                  _buildTitleButtonHits(spec),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleButtonHits(_ChromeSpec spec) {
    final List<_HitSpec> hits = switch (spec.kind) {
      _Wow32WindowKind.regular => const <_HitSpec>[
        _HitSpec(label: 'minimize', offsetRight: 3, message: 'SW_MINIMIZE'),
        _HitSpec(label: 'maximize', offsetRight: 2, message: 'SW_MAXIMIZE'),
        _HitSpec(label: 'close', offsetRight: 1, message: 'WM_CLOSE'),
      ],
      _Wow32WindowKind.dialog => const <_HitSpec>[
        _HitSpec(label: 'minimize', offsetRight: 2, message: 'SW_MINIMIZE'),
        _HitSpec(label: 'close', offsetRight: 1, message: 'WM_CLOSE (disabled)'),
      ],
      _Wow32WindowKind.popup => const <_HitSpec>[],
      _Wow32WindowKind.tooltip => const <_HitSpec>[],
    };

    return Positioned(
      top: -30,
      right: 2,
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final _HitSpec h in hits.reversed)
            SizedBox(
              width: 34,
              height: 22,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => widget.onChromeEvent(
                    '[btn ] ${spec.kind.name} ${h.label} → ${h.message}',
                  ),
                  hoverColor: Colors.white.withValues(alpha: 0.35),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
        ].reversed.toList(),
      ),
    );
  }
}

class _ChromeSpec {
  const _ChromeSpec({
    required this.kind,
    required this.title,
    required this.body,
    required this.width,
    required this.height,
  });
  final _Wow32WindowKind kind;
  final String title;
  final String body;
  final double width;
  final double height;
}

class _HitSpec {
  const _HitSpec({
    required this.label,
    required this.offsetRight,
    required this.message,
  });
  final String label;
  final int offsetRight;
  final String message;
}

// ---------------------------------------------------------------------------
//  Section 4 — Lifecycle timeline.
// ---------------------------------------------------------------------------

class _Wow32Section4Lifecycle extends StatefulWidget {
  const _Wow32Section4Lifecycle({required this.controller});

  final AnimationController controller;

  @override
  State<_Wow32Section4Lifecycle> createState() =>
      _Wow32Section4LifecycleState();
}

class _Wow32Section4LifecycleState extends State<_Wow32Section4Lifecycle> {
  static const List<_LifeStage> _stages = <_LifeStage>[
    _LifeStage(
      name: 'create',
      description:
          'Constructor runs: _Win32PlatformInterface.initializeWindowing '
          'allocates the callback pointer and registers _onMessage with '
          'the engine. A view id is obtained and RegularWindowControllerWin32 '
          'stores it as rootView.',
      message: '— (no WM_* yet; pre-show initialization)',
    ),
    _LifeStage(
      name: 'show',
      description:
          'The embedder creates the HWND and the first paint is scheduled. '
          'FlutterView is now driven by the engine\'s window bridge, and '
          'the owner begins receiving WndProc callbacks.',
      message: 'WM_NCCREATE → WM_CREATE → WM_SHOWWINDOW',
    ),
    _LifeStage(
      name: 'focus',
      description:
          'The user clicks the title bar. Windows dispatches WM_ACTIVATE; '
          'the owner forwards it to the controller, which calls '
          'notifyListeners(). WindowScope aspect "activated" fires rebuilds '
          'only for widgets that depend on it.',
      message: 'WM_ACTIVATE → controller.notifyListeners()',
    ),
    _LifeStage(
      name: 'resize',
      description:
          'User drags the edge. Windows streams WM_SIZE messages. The '
          'owner calls notifyListeners each tick, which refreshes '
          'WindowScope.contentSizeOf dependents (e.g. a status bar that '
          'prints "800 × 600").',
      message: 'WM_SIZE → controller.notifyListeners()',
    ),
    _LifeStage(
      name: 'minimize',
      description:
          'setMinimized(true) on the controller calls ShowWindow with '
          'SW_MINIMIZE. The engine suspends frame scheduling while the '
          'window is iconic; IsIconic() returns 1.',
      message: 'ShowWindow(SW_MINIMIZE) / IsIconic == 1',
    ),
    _LifeStage(
      name: 'restore',
      description:
          'setMinimized(false) — or the user clicks the taskbar icon — '
          'issues SW_RESTORE. A new WM_SIZE follows, frames resume.',
      message: 'ShowWindow(SW_RESTORE) → WM_SIZE',
    ),
    _LifeStage(
      name: 'close',
      description:
          'The user clicks X. WM_CLOSE reaches _onMessage, which calls '
          'delegate.onWindowCloseRequested; the default implementation '
          'calls controller.destroy(). That issues DestroyWindow, which '
          'triggers WM_DESTROY, _destroyed = true, handler removal, and '
          'delegate.onWindowDestroyed().',
      message: 'WM_CLOSE → destroy() → WM_DESTROY',
    ),
  ];

  int _activeStage(double t) {
    final int n = _stages.length;
    return (t * n).floor().clamp(0, n - 1);
  }

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '4. Lifecycle timeline',
      subtitle:
          'A continuous 14-second sweep through the seven canonical stages '
          'of a top-level window\'s life. The active stage describes what '
          'WindowingOwnerWin32 and the controller are doing in the '
          'framework layer.',
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (BuildContext ctx, Widget? child) {
          final double t = widget.controller.value;
          final int idx = _activeStage(t);
          final _LifeStage stage = _stages[idx];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 64,
                child: CustomPaint(
                  painter: _Wow32TimelinePainter(
                    stage: t * (_stages.length - 1),
                    stageCount: _stages.length,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (final _LifeStage s in _stages)
                    SizedBox(
                      width: 70,
                      child: Text(
                        s.name,
                        textAlign: TextAlign.center,
                        style: _Wow32TextStyles.label.copyWith(
                          color: s == stage
                              ? _Wow32Palette.accentBlue
                              : _Wow32Palette.textMuted,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _Wow32Palette.panelStroke),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _Wow32Palette.accentBlue
                                .withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'stage ${idx + 1}/${_stages.length}',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _Wow32Palette.accentBlue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          stage.name.toUpperCase(),
                          style: _Wow32TextStyles.cardTitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(stage.description, style: _Wow32TextStyles.cardBody),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _Wow32Palette.codeBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        stage.message,
                        style: _Wow32TextStyles.code.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LifeStage {
  const _LifeStage({
    required this.name,
    required this.description,
    required this.message,
  });
  final String name;
  final String description;
  final String message;
}

// ---------------------------------------------------------------------------
//  Section 5 — Window type gallery.
// ---------------------------------------------------------------------------

class _Wow32Section5TypeGallery extends StatelessWidget {
  const _Wow32Section5TypeGallery();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '5. Window type gallery',
      subtitle:
          'The four window kinds the framework defines. On Win32 only regular '
          'and dialog windows are currently backed — tooltip and popup '
          'controllers throw UnimplementedError until the embedder is wired up.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints cons) {
          final int cols = cons.maxWidth >= 900 ? 2 : 1;
          return GridView.count(
            crossAxisCount: cols,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.9,
            children: const <Widget>[
              _TypeGalleryCard(
                title: 'Regular window',
                kind: _Wow32WindowKind.regular,
                supported: true,
                summary:
                    'Traditional top-level window. Resizable, can minimize / '
                    'maximize / close. WindowingOwnerWin32 implements this via '
                    'RegularWindowControllerWin32.',
                code:
                    '''final controller = RegularWindowController(
  preferredSize: const Size(800, 600),
  preferredConstraints: const BoxConstraints(
    minWidth: 640, minHeight: 480,
  ),
  title: 'Example',
);
runWidget(RegularWindow(
  controller: controller,
  child: MaterialApp(home: Container()),
));''',
              ),
              _TypeGalleryCard(
                title: 'Dialog window',
                kind: _Wow32WindowKind.dialog,
                supported: true,
                summary:
                    'Modal with non-null parent or modeless with null parent. '
                    'On Win32, modal dialogs disable the close chrome and '
                    'setMinimized() becomes a no-op.',
                code:
                    '''DialogWindow(
  controller: DialogWindowController(
    preferredSize: const Size(420, 260),
    parent: WindowScope.of(context),
    title: 'Confirm',
  ),
  child: const _ConfirmBody(),
)''',
              ),
              _TypeGalleryCard(
                title: 'Popup window',
                kind: _Wow32WindowKind.popup,
                supported: false,
                summary:
                    'Transient window for menus / context menus. On Win32 '
                    'createPopupWindowController currently throws '
                    'UnimplementedError. Linux and macOS owners implement it.',
                code:
                    '''PopupWindowController(
  parent: WindowScope.of(context),
  anchorRect: ... ,
  positioner: WindowPositioner.right,
);''',
              ),
              _TypeGalleryCard(
                title: 'Tooltip window',
                kind: _Wow32WindowKind.tooltip,
                supported: false,
                summary:
                    'Small, non-focusable hover window. Same status on Win32 — '
                    'createTooltipWindowController throws. Documented as a '
                    'future capability.',
                code:
                    '''TooltipWindowController(
  parent: WindowScope.of(context),
  anchorRect: ... ,
  positioner: WindowPositioner.below,
);''',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TypeGalleryCard extends StatelessWidget {
  const _TypeGalleryCard({
    required this.title,
    required this.kind,
    required this.supported,
    required this.summary,
    required this.code,
  });

  final String title;
  final _Wow32WindowKind kind;
  final bool supported;
  final String summary;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Wow32Palette.panelStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(title, style: _Wow32TextStyles.cardTitle),
              ),
              _Pill(
                text: supported ? 'implemented' : 'throws',
                color: supported
                    ? _Wow32Palette.accentGreen
                    : _Wow32Palette.accentRed,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 140,
                height: 90,
                child: CustomPaint(
                  painter: _Wow32ChromePainter(
                    focused: true,
                    kind: kind,
                    pulse: 0.5,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(summary, style: _Wow32TextStyles.cardBody)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _Wow32Palette.codeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(code, style: _Wow32TextStyles.code),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Section 6 — Platform matrix.
// ---------------------------------------------------------------------------

class _Wow32Section6PlatformMatrix extends StatelessWidget {
  const _Wow32Section6PlatformMatrix();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '6. Platform matrix',
      subtitle:
          'createDefaultWindowingOwner() picks a concrete WindowingOwner per '
          'platform. The selection is hard-wired at engine-start and cannot '
          'be swapped at runtime except by assigning to '
          'WidgetsBinding.instance.windowingOwner.',
      child: Column(
        children: <Widget>[
          _PlatformRow(
            os: 'Windows',
            owner: 'WindowingOwnerWin32',
            chromeKind: _Wow32WindowKind.regular,
            accent: _Wow32Palette.accentBlue,
            note:
                'Full HWND plumbing. Regular + Dialog supported. Popup + Tooltip throw.',
            active: true,
          ),
          _PlatformRow(
            os: 'macOS',
            owner: 'WindowingOwnerMacOS',
            chromeKind: _Wow32WindowKind.regular,
            accent: _Wow32Palette.accentTeal,
            note:
                'NSWindow-backed. Traffic-light chrome, native menu bar, popup support.',
            active: false,
          ),
          _PlatformRow(
            os: 'Linux',
            owner: 'WindowingOwnerLinux',
            chromeKind: _Wow32WindowKind.regular,
            accent: _Wow32Palette.accentAmber,
            note:
                'GTK/X11 or Wayland-backed. Popup/Tooltip implemented via surface roles.',
            active: false,
          ),
          _PlatformRow(
            os: 'Web',
            owner: '_WindowingOwnerUnsupported',
            chromeKind: _Wow32WindowKind.popup,
            accent: _Wow32Palette.accentRed,
            note:
                'No multi-window on the web embedder today — all controllers throw.',
            active: false,
          ),
          _PlatformRow(
            os: 'Mobile (iOS/Android)',
            owner: '_WindowingOwnerUnsupported',
            chromeKind: _Wow32WindowKind.popup,
            accent: _Wow32Palette.accentRed,
            note:
                'Mobile embedders do not expose multi-window semantics; the '
                'experimental feature flag is gated off.',
            active: false,
          ),
        ],
      ),
    );
  }
}

class _PlatformRow extends StatelessWidget {
  const _PlatformRow({
    required this.os,
    required this.owner,
    required this.chromeKind,
    required this.accent,
    required this.note,
    required this.active,
  });

  final String os;
  final String owner;
  final _Wow32WindowKind chromeKind;
  final Color accent;
  final String note;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: active
            ? accent.withValues(alpha: 0.07)
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active ? accent.withValues(alpha: 0.6) : _Wow32Palette.panelStroke,
          width: active ? 1.4 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(os, style: _Wow32TextStyles.cardTitle),
                const SizedBox(height: 2),
                if (active)
                  const _Pill(
                    text: 'this page',
                    color: _Wow32Palette.accentBlue,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 150,
            height: 70,
            child: CustomPaint(
              painter: _Wow32ChromePainter(
                focused: active,
                kind: chromeKind,
                pulse: 0.5,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  owner,
                  style: _Wow32TextStyles.cardTitle.copyWith(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(note, style: _Wow32TextStyles.cardBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Section 7 — Event routing diagram.
// ---------------------------------------------------------------------------

class _Wow32Section7Routing extends StatelessWidget {
  const _Wow32Section7Routing({
    required this.controller,
    required this.highlightedHop,
    required this.onHopTap,
  });

  final AnimationController controller;
  final int highlightedHop;
  final void Function(int) onHopTap;

  static const List<String> _hopDescriptions = <String>[
    'The OS posts a WM_* message (for example WM_SIZE when the user drags the '
        'window edge). The message lands in the window\'s thread message queue.',
    'The Win32 message loop — implemented in the Flutter Windows embedder — '
        'pumps GetMessage / DispatchMessage. DispatchMessage drives the WndProc '
        'that the embedder registered for Flutter-owned windows.',
    'The engine\'s embedder-side WndProc marshals the message into an FFI '
        'struct (_WindowsMessage) and invokes the Dart callback that '
        'WindowingOwnerWin32 installed via InternalFlutterWindows_WindowManager_Initialize.',
    'WindowingOwnerWin32._onMessage walks its list of registered '
        '_WindowsMessageHandler instances in order. Each controller has added '
        'a thin adapter that forwards to its _handleWindowsMessage.',
    'The controller interprets the message — WM_CLOSE invokes the delegate, '
        'WM_SIZE / WM_ACTIVATE call notifyListeners — which in turn drives '
        'WidgetsBinding to schedule a frame through WindowScope aspect '
        'subscriptions.',
  ];

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '7. Event routing',
      subtitle:
          'From the moment a Win32 WM_* arrives to the point a Flutter frame '
          'is scheduled. Tap a hop to highlight it and surface an explanation.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 120,
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext ctx, Widget? child) {
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _Wow32RoutingPainter(
                          highlightedHop: highlightedHop,
                          progress: controller.value,
                        ),
                      ),
                    ),
                    // Tap targets over the five boxes.
                    Positioned.fill(
                      child: LayoutBuilder(
                        builder: (BuildContext ctx, BoxConstraints cons) {
                          final double w = cons.maxWidth;
                          final double boxW = (w - 80) / 5;
                          return Stack(
                            children: <Widget>[
                              for (int i = 0; i < 5; i++)
                                Positioned(
                                  left: 20 + i * (boxW + 10),
                                  top: (cons.maxHeight - 58) / 2,
                                  width: boxW - 10,
                                  height: 58,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(6),
                                      onTap: () => onHopTap(i),
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _Wow32Palette.panelStroke),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.route_outlined,
                  size: 22,
                  color: _Wow32Palette.accentBlue,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    highlightedHop >= 0 && highlightedHop < _hopDescriptions.length
                        ? _hopDescriptions[highlightedHop]
                        : 'Tap a hop above to learn what WindowingOwnerWin32 is doing there.',
                    style: _Wow32TextStyles.cardBody,
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

// ---------------------------------------------------------------------------
//  Section 8 — Recipes.
// ---------------------------------------------------------------------------

class _Wow32Section8Recipes extends StatelessWidget {
  const _Wow32Section8Recipes();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '8. Recipes',
      subtitle:
          'Six small-scale recipes. Recipes marked "conceptual" describe use '
          'cases the API does not yet expose on Win32 (popups, tooltips, '
          'custom title bars, DPI events). They are labeled honestly.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _Recipe(
            number: '8.1',
            title: 'Spawn a secondary regular window',
            supported: true,
            description:
                'Use the public factory RegularWindowController(). The '
                'factory routes to '
                'WidgetsBinding.instance.windowingOwner.createRegularWindowController, '
                'which on Windows returns a RegularWindowControllerWin32.',
            code: '''final secondary = RegularWindowController(
  preferredSize: const Size(640, 400),
  preferredConstraints: const BoxConstraints(
    minWidth: 480, minHeight: 320,
  ),
  title: 'Secondary',
);
runWidget(RegularWindow(
  controller: secondary,
  child: const SecondaryContent(),
));''',
          ),
          _Recipe(
            number: '8.2',
            title: 'Observe focus changes',
            supported: true,
            description:
                'The controller is a ChangeNotifier. WindowScope exposes an '
                '"activated" aspect so only focus-dependent widgets rebuild.',
            code: '''Widget build(BuildContext context) {
  final bool focused = WindowScope.isActivatedOf(context);
  return Container(
    color: focused ? Colors.white : const Color(0xFFF0F0F0),
    child: const ChildContent(),
  );
}''',
          ),
          _Recipe(
            number: '8.3',
            title: 'Intercept close requests',
            supported: true,
            description:
                'Subclass RegularWindowControllerDelegate.onWindowCloseRequested '
                'and decline to call destroy() if state is dirty — ask the '
                'user first.',
            code: '''class _SaveDelegate extends RegularWindowControllerDelegate {
  _SaveDelegate(this.onDirty);
  final ValueGetter<bool> onDirty;

  @override
  void onWindowCloseRequested(RegularWindowController c) {
    if (onDirty()) {
      _showConfirm(c); // do not destroy yet
    } else {
      c.destroy();
    }
  }
}''',
          ),
          _Recipe(
            number: '8.4',
            title: 'Custom title bar',
            supported: false,
            description:
                'Conceptual. The framework does not currently expose a hook '
                'to opt out of the native non-client area. Most approaches go '
                'through the embedder (set a borderless style then draw a '
                'custom bar in Flutter).',
            code: '''// Pseudocode — not supported by the public windowing API today.
// await FlutterWindow.setStyle(hwnd, WS_POPUP);
// then paint a Row(minimize, maximize, close) at the top of the widget tree.''',
          ),
          _Recipe(
            number: '8.5',
            title: 'React to DPI change',
            supported: false,
            description:
                'Conceptual on the framework side. WM_DPICHANGED is handled '
                'by the embedder and surfaces as a FlutterView devicePixelRatio '
                'change; WindowScope does not expose a DPI aspect yet.',
            code: '''final double dpr = View.of(context).devicePixelRatio;
// Rebuild on MediaQueryData.devicePixelRatioOf(context) if needed.''',
          ),
          _Recipe(
            number: '8.6',
            title: 'Multi-monitor positioning',
            supported: false,
            description:
                'Conceptual. setFullscreen(true, display: d) accepts a '
                'dart:ui Display for fullscreen targeting, but non-fullscreen '
                'placement across monitors has no public API — use the '
                'embedder extension.',
            code: '''final Display? secondary = PlatformDispatcher.instance
    .displays
    .skip(1)
    .firstOrNull;
controller.setFullscreen(true, display: secondary);''',
          ),
        ],
      ),
    );
  }
}

class _Recipe extends StatelessWidget {
  const _Recipe({
    required this.number,
    required this.title,
    required this.supported,
    required this.description,
    required this.code,
  });

  final String number;
  final String title;
  final bool supported;
  final String description;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Wow32Palette.panelStroke),
      ),
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
                  color: _Wow32Palette.panelStrokeStrong.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  number,
                  style: _Wow32TextStyles.label.copyWith(
                    color: _Wow32Palette.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title, style: _Wow32TextStyles.cardTitle),
              ),
              _Pill(
                text: supported ? 'supported' : 'conceptual',
                color: supported
                    ? _Wow32Palette.accentGreen
                    : _Wow32Palette.accentAmber,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(description, style: _Wow32TextStyles.cardBody),
          const SizedBox(height: 10),
          _CodeBlock(code: code),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Section 9 — Comparison table.
// ---------------------------------------------------------------------------

class _Wow32Section9Comparison extends StatelessWidget {
  const _Wow32Section9Comparison();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '9. Comparison with sibling owners',
      subtitle:
          'Four rows, four columns — how WindowingOwnerWin32 stacks against '
          'the macOS, Linux, and Web implementations.',
      child: _DataTableLite(
        headers: const <String>['Capability', 'Win32', 'macOS', 'Linux', 'Web'],
        rows: const <List<String>>[
          <String>[
            'Chrome control',
            'Full native; no '
                'framework hook to '
                'hide the title bar.',
            'Native NSWindow; '
                'traffic lights '
                'exposed.',
            'GTK client-side '
                'decorations; '
                'customizable.',
            'n/a — single '
                'view in a browser '
                'tab.',
          ],
          <String>[
            'Popup windows',
            'Throws '
                'UnimplementedError.',
            'Implemented via '
                'NSPanel.',
            'Implemented with '
                'xdg-popup / GTK '
                'menu surfaces.',
            'Throws.',
          ],
          <String>[
            'DPI handling',
            'Embedder translates '
                'WM_DPICHANGED into '
                'view devicePixelRatio.',
            'NSWindow backing '
                'scale factor.',
            'Monitor scale '
                'hinting (fractional '
                'scaling caveats).',
            'Browser devicePixelRatio.',
          ],
          <String>[
            'Multi-monitor',
            'Via engine + '
                'setFullscreen(display).',
            'Native space '
                'switching supported.',
            'Per-monitor via '
                'xdg_output.',
            'Not applicable.',
          ],
          <String>[
            'Custom message hooks',
            'Private '
                '_WindowsMessageHandler '
                '(embedder extensions '
                'only).',
            'Delegate subclass '
                'pattern.',
            'Event filter (GTK) '
                'or Wayland '
                'listener.',
            'None exposed.',
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Section 10 — Glossary + epilogue + live event log.
// ---------------------------------------------------------------------------

class _Wow32Section10Glossary extends StatelessWidget {
  const _Wow32Section10Glossary({required this.log});

  final List<String> log;

  static const List<List<String>> _entries = <List<String>>[
    <String>[
      'WindowingOwner',
      'Abstract class in package:flutter/src/widgets/_window.dart. Defines '
          'createRegularWindowController, createDialogWindowController, '
          'createTooltipWindowController, and createPopupWindowController. '
          'Per-platform subclasses implement the concrete calls.',
    ],
    <String>[
      'WindowingOwnerWin32',
      'Win32 subclass. Instantiated only on Platform.isWindows and only '
          'when isWindowingEnabled. Registers a Dart-side _onMessage callback '
          'with the engine and holds a list of _WindowsMessageHandler '
          'instances that controllers add on creation.',
    ],
    <String>[
      'RegularWindowController',
      'Public abstract controller for top-level resizable windows. Backed '
          'on Win32 by RegularWindowControllerWin32. Extends ChangeNotifier '
          'so views subscribing via WindowScope aspects rebuild when the '
          'native window changes state.',
    ],
    <String>[
      'DialogWindowController',
      'Controller for modal/modeless dialogs. Modal dialogs (non-null parent) '
          'disable the Win32 close chrome and cannot minimize.',
    ],
    <String>[
      'PopupWindowController',
      'Controller for menus/context menus. On Win32 the factory currently '
          'throws UnimplementedError. Linux and macOS implement it.',
    ],
    <String>[
      'TooltipWindowController',
      'Controller for non-focusable hover windows. Throws UnimplementedError '
          'on Win32 today.',
    ],
    <String>[
      'WindowScope',
      'InheritedModel that exposes the nearest BaseWindowController, with '
          'aspects for contentSize, title, activated, minimized, maximized, '
          'and fullscreen. Use WindowScope.isActivatedOf(context) etc. to '
          'subscribe to only one aspect.',
    ],
    <String>[
      'WidgetsBinding.windowingOwner',
      'The process-wide owner instance. Assigned to '
          'createDefaultWindowingOwner() at binding initialization; can be '
          'replaced in tests.',
    ],
    <String>[
      'PlatformDispatcher',
      'Global dispatcher for views and displays. On Windows, '
          'platformDispatcher.engineId is the 64-bit handle the owner passes '
          'through every FFI call into the embedder.',
    ],
    <String>[
      'FlutterView',
      'The Dart-side representation of a native window surface. Each window '
          'controller owns exactly one root view (controller.rootView).',
    ],
    <String>[
      'HWND',
      'typedef HWND = ffi.Pointer<ffi.Void>. The opaque Win32 window handle. '
          'Owned by the embedder; the controller obtains it via '
          'InternalFlutterWindows_WindowManager_GetTopLevelWindowHandle.',
    ],
    <String>[
      'WndProc',
      'The classic Win32 window procedure. The Flutter Windows embedder '
          'registers its own WndProc and forwards messages into Dart as '
          '_WindowsMessage structs.',
    ],
    <String>[
      'Message loop',
      'The GetMessage / DispatchMessage pump that the embedder runs. Ticks '
          'once per UI event; each tick may deliver zero or more WM_* to '
          'WindowingOwnerWin32._onMessage.',
    ],
    <String>[
      'DPI scaling',
      'Windows concept of per-monitor DPI. WM_DPICHANGED updates the view\'s '
          'devicePixelRatio; MediaQuery reflects the change on the next frame.',
    ],
    <String>[
      'isWindowingEnabled',
      'Feature-flag getter in package:flutter/src/foundation/_features.dart. '
          'When false, every windowing API throws UnsupportedError — this is '
          'the main reason the demo on this page is painted rather than '
          'instantiated.',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: '10. Glossary + epilogue + live log',
      subtitle:
          'The vocabulary this demo leans on, followed by a narrative on when '
          'an application developer actually has to think about '
          'WindowingOwnerWin32, and a running log of the in-demo interactions.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _Wow32Palette.panelStroke),
            ),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < _entries.length; i++)
                  Container(
                    decoration: BoxDecoration(
                      color: i.isEven ? Colors.white : const Color(0xFFF8FAFC),
                      borderRadius: i == 0
                          ? const BorderRadius.vertical(
                              top: Radius.circular(7),
                            )
                          : i == _entries.length - 1
                              ? const BorderRadius.vertical(
                                  bottom: Radius.circular(7),
                                )
                              : null,
                      border: i == 0
                          ? null
                          : const Border(
                              top: BorderSide(
                                color: _Wow32Palette.panelStroke,
                                width: 0.5,
                              ),
                            ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 180,
                          child: Text(
                            _entries[i][0],
                            style: _Wow32TextStyles.cardTitle.copyWith(
                              fontFamily: 'monospace',
                              fontSize: 12.5,
                              color: _Wow32Palette.accentBlue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _entries[i][1],
                            style: _Wow32TextStyles.cardBody,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFE9F2FC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _Wow32Palette.accentBlue.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(
                      Icons.lightbulb_outline,
                      size: 18,
                      color: _Wow32Palette.accentBlue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Epilogue — when do you actually care?',
                      style: _Wow32TextStyles.cardTitle,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'The short answer is: almost never. For the overwhelming '
                  'majority of Flutter desktop apps, the only surface you '
                  'touch is the public abstraction: RegularWindow, '
                  'DialogWindow, WindowScope.of(context), and the controller '
                  'factories. The framework picks a WindowingOwner for you at '
                  'boot and you never see its concrete type.',
                  style: _Wow32TextStyles.cardBody,
                ),
                const SizedBox(height: 10),
                Text(
                  'You start to care about WindowingOwnerWin32 specifically '
                  'when you need to reach below the public API — replacing '
                  'the default owner in tests, writing a plugin that hooks '
                  'additional WM_* messages, or shipping an embedder '
                  'extension that needs per-platform behavior. And you care '
                  'when a feature simply is not there yet: popups and '
                  'tooltips throw on Win32 today, DPI events do not surface '
                  'as an aspect, and there is no framework-level hook for '
                  'custom title bars. In those cases, knowing exactly what '
                  'WindowingOwnerWin32 does — and what it does not yet do — '
                  'is the difference between writing an embedder patch and '
                  'spending an afternoon debugging an UnsupportedError.',
                  style: _Wow32TextStyles.cardBody,
                ),
                const SizedBox(height: 10),
                Text(
                  'Until the windowing APIs stabilize (tracked in issue '
                  '#30701), treat every example here as a contract sketch, '
                  'not a promise. The goal of this page is literacy: you '
                  'should be able to read the SDK source, recognize the '
                  'roles, and pick the right abstraction level when you '
                  'need to extend it.',
                  style: _Wow32TextStyles.cardBody,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Wow32Palette.codeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.terminal,
                      size: 16,
                      color: _Wow32Palette.codeAccent,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Event log (most recent first)',
                      style: _Wow32TextStyles.label.copyWith(
                        color: _Wow32Palette.codeAccent,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${log.length} lines',
                      style: _Wow32TextStyles.logLine.copyWith(
                        color: _Wow32Palette.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1624),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _Wow32Palette.codeAccent.withValues(alpha: 0.2),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: log.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          log[index],
                          style: _Wow32TextStyles.logLine.copyWith(
                            color: index == 0
                                ? _Wow32Palette.codeAccent
                                : _Wow32Palette.codeText,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Flutter SDK · package:flutter/src/widgets/_window_win32.dart',
                style: _Wow32TextStyles.logLine.copyWith(
                  color: _Wow32Palette.textMuted,
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
//  Utility: we import services and foundation primarily for their types.
//  End of file.
// ---------------------------------------------------------------------------

