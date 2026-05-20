// D4rt test script: Deep Demo - dart:ui CallbackHandle & PluginUtilities
// Visual exploration of top-level / static callback references in Flutter UI,
// showing how a CallbackHandle conceptually labels a callable function that
// can be passed across isolate boundaries via PluginUtilities. The demo is
// abstract (handles are mostly opaque integers), so we render the *idea* of
// callbacks: gesture sinks, event logs, debounced timers, animation ticks,
// focus transitions and a registration table — all manually composed.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// TOP-LEVEL CALLBACK STUBS
// In a real app these would be passed to PluginUtilities.getCallbackHandle
// which returns a CallbackHandle (an opaque int). The handle can then be
// sent to another isolate which uses
// PluginUtilities.getCallbackFromHandle to recover the callable. Here we
// only *describe* them visually; the demo never executes background work.
// ---------------------------------------------------------------------------

void demoBackgroundLocationCallback() {
  // A reference to a top-level function suitable for handle registration.
}

void demoGeofenceCrossedCallback() {
  // Another candidate for PluginUtilities.getCallbackHandle.
}

void demoAlarmFiredCallback() {
  // Alarm manager style entry point.
}

void demoPushReceivedCallback() {
  // FCM background message handler shape.
}

dynamic build(BuildContext context) {
  // =========================================================================
  // PALETTE
  // =========================================================================

  const Color paletteInk = Color(0xFF101728);
  const Color paletteInkSoft = Color(0xFF3D4663);
  const Color paletteAccent = Color(0xFF2563EB);
  const Color paletteAccentSoft = Color(0xFFDBEAFE);
  const Color paletteMagenta = Color(0xFFB5179E);
  const Color paletteMagentaSoft = Color(0xFFF6D8F0);
  const Color paletteTeal = Color(0xFF0F766E);
  const Color paletteTealSoft = Color(0xFFCCF6F0);
  const Color paletteAmber = Color(0xFFB45309);
  const Color paletteAmberSoft = Color(0xFFFEF1C7);
  const Color paletteCrimson = Color(0xFFBE123C);
  const Color paletteCrimsonSoft = Color(0xFFFCE0E8);
  const Color paletteViolet = Color(0xFF6D28D9);
  const Color paletteVioletSoft = Color(0xFFEDE0FC);
  const Color paletteSurface = Color(0xFFF7F8FC);
  const Color paletteSurfaceAlt = Color(0xFFEEF1F8);
  const Color paletteOutline = Color(0xFFD0D6E2);
  const Color paletteSuccess = Color(0xFF15803D);
  const Color paletteSuccessSoft = Color(0xFFD6F4DF);

  // =========================================================================
  // HELPERS
  // =========================================================================

  Widget sectionShell({
    required String title,
    required String subtitle,
    required Color surface,
    required Color border,
    required Color titleColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: border, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: border.withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: titleColor.withValues(alpha: 0.10),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(17.0),
                topRight: Radius.circular(17.0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: titleColor.withValues(alpha: 0.25),
                  width: 1.0,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: paletteInkSoft,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget pillBadge(String text, Color color, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 13.0, color: color),
            const SizedBox(width: 5.0),
          ],
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget codeBlock(String text, {Color? accent}) {
    final Color a = accent ?? paletteAccent;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: paletteInk,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: a, width: 4.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFE2E8F0),
          fontFamily: 'monospace',
          fontSize: 12.0,
          height: 1.55,
        ),
      ),
    );
  }

  Widget metric(String label, String value, Color color, IconData icon) {
    return Container(
      width: 150.0,
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 16.0),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            value,
            style: const TextStyle(
              color: paletteInk,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget rowDivider(Color c) {
    return Container(
      height: 1.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: c.withValues(alpha: 0.25),
    );
  }

  // =========================================================================
  // SECTION 1 - HERO BANNER
  // =========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0B1736),
          Color(0xFF1E3A8A),
          Color(0xFF4338CA),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 24.0,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 1.4,
                ),
              ),
              child: const Icon(
                Icons.link,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'dart:ui CallbackHandle — Deep Visual Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'PluginUtilities.getCallbackHandle wraps a top-level or '
                    'static function as an opaque integer that travels across '
                    'isolates. This demo visualises callback usage in the UI.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 13.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                'CallbackHandle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                'PluginUtilities',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                'getCallbackHandle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                'getCallbackFromHandle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                'IsolateNameServer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 2 - HANDLE ANATOMY
  // =========================================================================

  final Widget handleAnatomy = sectionShell(
    title: '01 — What is a CallbackHandle?',
    subtitle:
        'An opaque integer identifier. Created by registering a top-level or '
        'static function with PluginUtilities. The integer can survive an '
        'isolate hop and be reversed back into a callable.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 110.0,
              height: 110.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[paletteAccent, paletteViolet],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: paletteAccent.withValues(alpha: 0.4),
                    blurRadius: 16.0,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.tag, color: Colors.white, size: 28.0),
                  SizedBox(height: 4.0),
                  Text(
                    '0xB7E91F',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                      fontSize: 13.0,
                    ),
                  ),
                  Text(
                    'handle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'A handle is just a number.',
                    style: TextStyle(
                      color: paletteInk,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'There is no `Handle` class to subclass and almost no API '
                    'surface to demo visually. The interesting part is what '
                    'the handle *refers to*: a callable that can be revived '
                    'in a background isolate. So this demo focuses on '
                    'callbacks in Flutter UI itself.',
                    style: TextStyle(
                      color: paletteInkSoft,
                      fontSize: 13.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        rowDivider(paletteOutline),
        codeBlock(
          'final CallbackHandle? handle =\n'
          '    PluginUtilities.getCallbackHandle(myTopLevelCallback);\n'
          '\n'
          '// later, in another isolate:\n'
          'final Function? f =\n'
          '    PluginUtilities.getCallbackFromHandle(handle!);\n'
          'f?.call();',
          accent: paletteAccent,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            pillBadge('top-level only', paletteCrimson, icon: Icons.warning),
            pillBadge('or static method', paletteAccent, icon: Icons.bolt),
            pillBadge('no closures', paletteAmber, icon: Icons.block),
            pillBadge('opaque int', paletteTeal, icon: Icons.numbers),
            pillBadge('isolate-safe', paletteViolet, icon: Icons.shield),
          ],
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 3 - TYPED FUNCTION REFERENCES CATALOG
  // =========================================================================

  final List<Map<String, dynamic>> typedRefs = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'VoidCallback',
      'signature': 'void Function()',
      'use': 'Buttons, dismissals, refresh triggers.',
      'color': paletteAccent,
      'soft': paletteAccentSoft,
      'icon': Icons.touch_app,
    },
    <String, dynamic>{
      'name': 'ValueChanged<T>',
      'signature': 'void Function(T value)',
      'use': 'TextField onChanged, Slider onChanged.',
      'color': paletteTeal,
      'soft': paletteTealSoft,
      'icon': Icons.swap_horiz,
    },
    <String, dynamic>{
      'name': 'ValueSetter<T>',
      'signature': 'void Function(T value)',
      'use': 'Sister of ValueChanged for explicit "set this" semantics.',
      'color': paletteMagenta,
      'soft': paletteMagentaSoft,
      'icon': Icons.edit,
    },
    <String, dynamic>{
      'name': 'ValueGetter<T>',
      'signature': 'T Function()',
      'use': 'Lazy producers and on-demand suppliers.',
      'color': paletteAmber,
      'soft': paletteAmberSoft,
      'icon': Icons.download,
    },
    <String, dynamic>{
      'name': 'AsyncCallback',
      'signature': 'Future<void> Function()',
      'use': 'Pull-to-refresh, async submit, lazy boot.',
      'color': paletteViolet,
      'soft': paletteVioletSoft,
      'icon': Icons.hourglass_top,
    },
    <String, dynamic>{
      'name': 'GestureTapCallback',
      'signature': 'void Function()',
      'use': 'GestureDetector onTap / onDoubleTap.',
      'color': paletteCrimson,
      'soft': paletteCrimsonSoft,
      'icon': Icons.tap_and_play,
    },
    <String, dynamic>{
      'name': 'GestureDragUpdateCallback',
      'signature': 'void Function(DragUpdateDetails)',
      'use': 'Pan and drag tracking, custom sliders.',
      'color': paletteAccent,
      'soft': paletteAccentSoft,
      'icon': Icons.drag_indicator,
    },
    <String, dynamic>{
      'name': 'GestureScaleUpdateCallback',
      'signature': 'void Function(ScaleUpdateDetails)',
      'use': 'Pinch-to-zoom and rotation handlers.',
      'color': paletteTeal,
      'soft': paletteTealSoft,
      'icon': Icons.zoom_in,
    },
    <String, dynamic>{
      'name': 'PointerDownEventListener',
      'signature': 'void Function(PointerDownEvent)',
      'use': 'Raw pointer ingestion via Listener.',
      'color': paletteMagenta,
      'soft': paletteMagentaSoft,
      'icon': Icons.south,
    },
    <String, dynamic>{
      'name': 'TickerCallback',
      'signature': 'void Function(Duration elapsed)',
      'use': 'Ticker / AnimationController updates.',
      'color': paletteAmber,
      'soft': paletteAmberSoft,
      'icon': Icons.access_time,
    },
  ];

  final List<Widget> typedRefCards = List<Widget>.generate(typedRefs.length, (
    int idx,
  ) {
    final Map<String, dynamic> r = typedRefs[idx];
    final Color c = r['color'] as Color;
    final Color s = r['soft'] as Color;
    return Container(
      width: 260.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: s.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: c.withValues(alpha: 0.45), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  r['icon'] as IconData,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  r['name'] as String,
                  style: TextStyle(
                    color: c,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: paletteInk,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              r['signature'] as String,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            r['use'] as String,
            style: const TextStyle(
              color: paletteInk,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  });

  final Widget typedRefsSection = sectionShell(
    title: '02 — Typed Callback References',
    subtitle:
        'Flutter ships a typedef zoo for callbacks. These are *the things* '
        'you might want to expose through a CallbackHandle.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteTeal,
    child: Wrap(children: typedRefCards),
  );

  // =========================================================================
  // SECTION 4 - GESTUREDETECTOR CALLBACK MAP
  // =========================================================================

  final List<Map<String, dynamic>> gestureCallbacks = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'onTap',
      'type': 'GestureTapCallback',
      'fires': 'Once on a quick press-release.',
      'icon': Icons.touch_app,
      'color': paletteAccent,
    },
    <String, dynamic>{
      'name': 'onDoubleTap',
      'type': 'GestureTapCallback',
      'fires': 'Two taps within kDoubleTapTimeout (~300ms).',
      'icon': Icons.repeat,
      'color': paletteMagenta,
    },
    <String, dynamic>{
      'name': 'onLongPress',
      'type': 'GestureLongPressCallback',
      'fires': 'After kLongPressTimeout (~500ms) of continuous press.',
      'icon': Icons.timer,
      'color': paletteAmber,
    },
    <String, dynamic>{
      'name': 'onPanUpdate',
      'type': 'GestureDragUpdateCallback',
      'fires': 'Every frame while a single finger drags.',
      'icon': Icons.open_with,
      'color': paletteTeal,
    },
    <String, dynamic>{
      'name': 'onScaleUpdate',
      'type': 'GestureScaleUpdateCallback',
      'fires': 'Every frame while >=1 finger participates in a scale gesture.',
      'icon': Icons.pinch,
      'color': paletteViolet,
    },
    <String, dynamic>{
      'name': 'onTapDown',
      'type': 'GestureTapDownCallback',
      'fires': 'The instant the finger lands; carries position info.',
      'icon': Icons.south_east,
      'color': paletteCrimson,
    },
    <String, dynamic>{
      'name': 'onTapUp',
      'type': 'GestureTapUpCallback',
      'fires': 'When the finger lifts after a tap.',
      'icon': Icons.north_west,
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'name': 'onTapCancel',
      'type': 'GestureTapCancelCallback',
      'fires': 'If the touch sequence aborts before a recognised tap.',
      'icon': Icons.cancel,
      'color': paletteInkSoft,
    },
    <String, dynamic>{
      'name': 'onSecondaryTap',
      'type': 'GestureTapCallback',
      'fires': 'Right-click or secondary touch on supported devices.',
      'icon': Icons.mouse,
      'color': paletteAccent,
    },
    <String, dynamic>{
      'name': 'onVerticalDragStart',
      'type': 'GestureDragStartCallback',
      'fires': 'A pointer crosses the vertical drag threshold.',
      'icon': Icons.swap_vert,
      'color': paletteTeal,
    },
  ];

  final List<Widget> gestureRows = List<Widget>.generate(
    gestureCallbacks.length,
    (int idx) {
      final Map<String, dynamic> g = gestureCallbacks[idx];
      final Color c = g['color'] as Color;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: c.withValues(alpha: 0.30), width: 1.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                g['icon'] as IconData,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        g['name'] as String,
                        style: TextStyle(
                          color: c,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: c.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          g['type'] as String,
                          style: TextStyle(
                            color: c,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    g['fires'] as String,
                    style: const TextStyle(
                      color: paletteInkSoft,
                      fontSize: 12.0,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  final Widget gestureSection = sectionShell(
    title: '03 — GestureDetector Callback Map',
    subtitle:
        'GestureDetector exposes around 30 named callback slots. Each is a '
        'concrete entry point that could be packaged as a CallbackHandle '
        '(if it were top-level).',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteMagenta,
    child: Column(children: gestureRows),
  );

  // =========================================================================
  // SECTION 5 - BUTTON CALLBACK CARDS
  // =========================================================================

  final List<Map<String, dynamic>> buttonCards = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'ElevatedButton',
      'cb': 'onPressed: VoidCallback?',
      'extra': 'onLongPress, onFocusChange, onHover',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'label': 'TextButton',
      'cb': 'onPressed: VoidCallback?',
      'extra': 'onLongPress, onFocusChange, onHover',
      'color': paletteTeal,
    },
    <String, dynamic>{
      'label': 'OutlinedButton',
      'cb': 'onPressed: VoidCallback?',
      'extra': 'onLongPress, onFocusChange, onHover',
      'color': paletteMagenta,
    },
    <String, dynamic>{
      'label': 'IconButton',
      'cb': 'onPressed: VoidCallback?',
      'extra': 'tooltip-aware press only',
      'color': paletteAmber,
    },
    <String, dynamic>{
      'label': 'FloatingActionButton',
      'cb': 'onPressed: VoidCallback?',
      'extra': 'extended variant takes label',
      'color': paletteCrimson,
    },
    <String, dynamic>{
      'label': 'PopupMenuButton<T>',
      'cb': 'onSelected: PopupMenuItemSelected<T>',
      'extra': 'onCanceled when menu dismissed without choice',
      'color': paletteViolet,
    },
    <String, dynamic>{
      'label': 'DropdownButton<T>',
      'cb': 'onChanged: ValueChanged<T?>',
      'extra': 'onTap fires when opened',
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'label': 'Checkbox',
      'cb': 'onChanged: ValueChanged<bool?>',
      'extra': 'tristate allows null',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'label': 'Switch',
      'cb': 'onChanged: ValueChanged<bool>',
      'extra': 'use activeThumbColor (not activeColor)',
      'color': paletteTeal,
    },
    <String, dynamic>{
      'label': 'Radio<T>',
      'cb': 'wrapped in RadioGroup<T>',
      'extra': 'groupValue / onChanged on the group',
      'color': paletteMagenta,
    },
  ];

  final List<Widget> buttonCardWidgets = buttonCards.map((
    Map<String, dynamic> b,
  ) {
    final Color c = b['color'] as Color;
    return Container(
      width: 270.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: c.withValues(alpha: 0.40), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: c.withValues(alpha: 0.15),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 26.0,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  b['label'] as String,
                  style: const TextStyle(
                    color: paletteInk,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: paletteInk,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              b['cb'] as String,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            b['extra'] as String,
            style: const TextStyle(
              color: paletteInkSoft,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }).toList();

  final Widget buttonSection = sectionShell(
    title: '04 — Button Callbacks as Cards',
    subtitle:
        'Every interactive Material widget has one or more callback slots. '
        'Below: an at-a-glance card per major button type.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAccent,
    child: Wrap(children: buttonCardWidgets),
  );

  // =========================================================================
  // SECTION 6 - REGISTRATION TABLE
  // =========================================================================

  final List<Map<String, dynamic>> registrations = <Map<String, dynamic>>[
    <String, dynamic>{
      'fn': 'demoBackgroundLocationCallback',
      'handle': '0x10A37F',
      'isolate': 'background_geo',
      'status': 'registered',
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'fn': 'demoGeofenceCrossedCallback',
      'handle': '0x10A381',
      'isolate': 'background_geo',
      'status': 'registered',
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'fn': 'demoAlarmFiredCallback',
      'handle': '0x110422',
      'isolate': 'alarm_manager',
      'status': 'pending',
      'color': paletteAmber,
    },
    <String, dynamic>{
      'fn': 'demoPushReceivedCallback',
      'handle': '0x12FF09',
      'isolate': 'fcm_bg',
      'status': 'registered',
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'fn': 'unknownClosure',
      'handle': '—',
      'isolate': '—',
      'status': 'rejected',
      'color': paletteCrimson,
    },
    <String, dynamic>{
      'fn': 'unboundInstanceMethod',
      'handle': '—',
      'isolate': '—',
      'status': 'rejected',
      'color': paletteCrimson,
    },
  ];

  final List<Widget> registrationRows = registrations.map((
    Map<String, dynamic> r,
  ) {
    final Color c = r['color'] as Color;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: paletteOutline, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              r['fn'] as String,
              style: const TextStyle(
                color: paletteInk,
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              r['handle'] as String,
              style: TextStyle(
                color: c,
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              r['isolate'] as String,
              style: const TextStyle(
                color: paletteInkSoft,
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: c.withValues(alpha: 0.5), width: 1.0),
            ),
            child: Text(
              r['status'] as String,
              style: TextStyle(
                color: c,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final Widget registrationSection = sectionShell(
    title: '05 — Handle Registration Table (mock)',
    subtitle:
        'A mocked view of the implicit table inside the Flutter engine: '
        'top-level function → CallbackHandle integer → consuming isolate.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteViolet,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: paletteInk,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  'FUNCTION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'HANDLE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'ISOLATE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                width: 100.0,
                child: Text(
                  'STATUS',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        ...registrationRows,
      ],
    ),
  );

  // =========================================================================
  // SECTION 7 - ASYNC CALLBACK FLOW DIAGRAM
  // =========================================================================

  Widget flowNode({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      width: 130.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.4),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget flowArrow(Color color) {
    return Container(
      width: 30.0,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 2.5,
              color: color.withValues(alpha: 0.6),
            ),
          ),
          Icon(Icons.arrow_forward, color: color, size: 18.0),
        ],
      ),
    );
  }

  final Widget asyncFlow = sectionShell(
    title: '06 — Async Callback Flow',
    subtitle:
        'A typical lifecycle: user gesture → debounce → handler future → '
        'completion notification → UI rebuild.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteTeal,
    child: Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              flowNode(
                icon: Icons.touch_app,
                label: 'Gesture',
                color: paletteAccent,
              ),
              flowArrow(paletteAccent),
              flowNode(
                icon: Icons.hourglass_empty,
                label: 'Debounce',
                color: paletteAmber,
              ),
              flowArrow(paletteAmber),
              flowNode(
                icon: Icons.functions,
                label: 'Handler',
                color: paletteMagenta,
              ),
              flowArrow(paletteMagenta),
              flowNode(
                icon: Icons.cloud_sync,
                label: 'Future',
                color: paletteViolet,
              ),
              flowArrow(paletteViolet),
              flowNode(
                icon: Icons.check_circle,
                label: 'Resolve',
                color: paletteSuccess,
              ),
              flowArrow(paletteSuccess),
              flowNode(
                icon: Icons.refresh,
                label: 'Rebuild',
                color: paletteTeal,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        codeBlock(
          'onTap: () async {\n'
          '  setState(() => loading = true);\n'
          '  try {\n'
          '    final v = await fetchSomething();\n'
          '    setState(() => result = v);\n'
          '  } finally {\n'
          '    setState(() => loading = false);\n'
          '  }\n'
          '}',
          accent: paletteTeal,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 8 - CALLBACK CHAINING
  // =========================================================================

  Widget chainStage({
    required int index,
    required String label,
    required String detail,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(
          left: BorderSide(color: color, width: 5.0),
          top: BorderSide(color: color.withValues(alpha: 0.25)),
          right: BorderSide(color: color.withValues(alpha: 0.25)),
          bottom: BorderSide(color: color.withValues(alpha: 0.25)),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38.0,
            height: 38.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  detail,
                  style: const TextStyle(
                    color: paletteInkSoft,
                    fontSize: 12.0,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> chainStages = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'onTapDown',
      'detail': 'Initial press recorded with position via TapDownDetails.',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'label': 'onTap',
      'detail': 'Confirmed short-press tap, kicks off submit handler.',
      'color': paletteTeal,
    },
    <String, dynamic>{
      'label': 'submit() future',
      'detail': 'Async work begins; loading spinner rendered.',
      'color': paletteMagenta,
    },
    <String, dynamic>{
      'label': 'then((value) => …)',
      'detail': 'Future resolves; state updated, banner shown.',
      'color': paletteAmber,
    },
    <String, dynamic>{
      'label': 'whenComplete(() => …)',
      'detail': 'Regardless of outcome, the spinner is cleared.',
      'color': paletteViolet,
    },
    <String, dynamic>{
      'label': 'onComplete callback',
      'detail': 'External observer notified that the chain finished.',
      'color': paletteSuccess,
    },
  ];

  final Widget chainSection = sectionShell(
    title: '07 — Callback Chaining',
    subtitle:
        'A single user tap can fan out into a six-step chain of callbacks. '
        'Each step is a place where a CallbackHandle-style hook could live.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAmber,
    child: Column(
      children: List<Widget>.generate(chainStages.length, (int i) {
        final Map<String, dynamic> s = chainStages[i];
        return chainStage(
          index: i + 1,
          label: s['label'] as String,
          detail: s['detail'] as String,
          color: s['color'] as Color,
        );
      }),
    ),
  );

  // =========================================================================
  // SECTION 9 - DEBOUNCED CALLBACK TIMER UI
  // =========================================================================

  Widget debounceTick({
    required String time,
    required bool fires,
    required Color color,
  }) {
    return Container(
      width: 76.0,
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: (fires ? color : paletteOutline).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: (fires ? color : paletteOutline).withValues(alpha: 0.6),
          width: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            fires ? Icons.notifications_active : Icons.access_time,
            color: fires ? color : paletteInkSoft,
            size: 18.0,
          ),
          const SizedBox(height: 4.0),
          Text(
            time,
            style: TextStyle(
              color: fires ? color : paletteInkSoft,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            fires ? 'fire' : 'idle',
            style: TextStyle(
              color: fires ? color : paletteInkSoft,
              fontSize: 9.5,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> debounceMarks = <Map<String, dynamic>>[
    <String, dynamic>{'t': '0ms', 'fires': false},
    <String, dynamic>{'t': '50ms', 'fires': false},
    <String, dynamic>{'t': '100ms', 'fires': false},
    <String, dynamic>{'t': '150ms', 'fires': false},
    <String, dynamic>{'t': '200ms', 'fires': false},
    <String, dynamic>{'t': '300ms', 'fires': true},
    <String, dynamic>{'t': '350ms', 'fires': false},
    <String, dynamic>{'t': '450ms', 'fires': false},
    <String, dynamic>{'t': '550ms', 'fires': false},
    <String, dynamic>{'t': '650ms', 'fires': true},
  ];

  final Widget debounceSection = sectionShell(
    title: '08 — Debounced Callback Timeline',
    subtitle:
        'Each keystroke restarts a 300ms timer; the callback only fires on '
        'the trailing edge of inactivity.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteCrimson,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          children: List<Widget>.generate(debounceMarks.length, (int i) {
            final Map<String, dynamic> m = debounceMarks[i];
            return debounceTick(
              time: m['t'] as String,
              fires: m['fires'] as bool,
              color: paletteCrimson,
            );
          }),
        ),
        const SizedBox(height: 14.0),
        codeBlock(
          'Timer? _debounce;\n'
          'void onChanged(String value) {\n'
          '  _debounce?.cancel();\n'
          '  _debounce = Timer(\n'
          '    const Duration(milliseconds: 300),\n'
          '    () => commit(value),\n'
          '  );\n'
          '}',
          accent: paletteCrimson,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 10 - THROTTLED SCROLL CALLBACK
  // =========================================================================

  Widget throttleBar({
    required double width,
    required String time,
    required bool fires,
    required Color color,
  }) {
    return SizedBox(
      width: 70.0,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60.0 * (width.clamp(0.0, 1.0)),
              decoration: BoxDecoration(
                color:
                    (fires ? color : paletteInkSoft).withValues(alpha: 0.55),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4.0),
                ),
              ),
            ),
            Container(
              height: 4.0,
              color: fires ? color : paletteOutline,
            ),
            const SizedBox(height: 4.0),
            Text(
              time,
              style: const TextStyle(
                color: paletteInkSoft,
                fontSize: 10.0,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              fires ? 'fired' : '—',
              style: TextStyle(
                color: fires ? color : paletteInkSoft,
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> throttleSamples = <Map<String, dynamic>>[
    <String, dynamic>{'w': 0.30, 't': '0', 'f': true},
    <String, dynamic>{'w': 0.42, 't': '16ms', 'f': false},
    <String, dynamic>{'w': 0.55, 't': '32ms', 'f': false},
    <String, dynamic>{'w': 0.68, 't': '48ms', 'f': false},
    <String, dynamic>{'w': 0.81, 't': '64ms', 'f': false},
    <String, dynamic>{'w': 0.90, 't': '100ms', 'f': true},
    <String, dynamic>{'w': 0.75, 't': '116ms', 'f': false},
    <String, dynamic>{'w': 0.62, 't': '132ms', 'f': false},
    <String, dynamic>{'w': 0.55, 't': '200ms', 'f': true},
    <String, dynamic>{'w': 0.45, 't': '216ms', 'f': false},
  ];

  final Widget throttleSection = sectionShell(
    title: '09 — Throttled Scroll Callback',
    subtitle:
        'Throttling drops intermediate events and only fires on a fixed '
        'interval — perfect for heavy scroll listeners.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteViolet,
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: paletteVioletSoft.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(throttleSamples.length, (int i) {
              final Map<String, dynamic> s = throttleSamples[i];
              return throttleBar(
                width: s['w'] as double,
                time: s['t'] as String,
                fires: s['f'] as bool,
                color: paletteViolet,
              );
            }),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            pillBadge('window: 100ms', paletteViolet, icon: Icons.timer),
            const SizedBox(width: 8.0),
            pillBadge('drops in-between', paletteAccent, icon: Icons.cut),
            const SizedBox(width: 8.0),
            pillBadge(
              'leading-edge fires',
              paletteSuccess,
              icon: Icons.flash_on,
            ),
          ],
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 11 - EVENT LOG VIEWER
  // =========================================================================

  final List<Map<String, dynamic>> eventLog = <Map<String, dynamic>>[
    <String, dynamic>{
      't': '00:00:00.123',
      'src': 'GestureDetector#3a1',
      'cb': 'onTapDown',
      'detail': 'localPosition: (124.0, 88.0)',
      'color': paletteAccent,
    },
    <String, dynamic>{
      't': '00:00:00.145',
      'src': 'GestureDetector#3a1',
      'cb': 'onTap',
      'detail': '—',
      'color': paletteAccent,
    },
    <String, dynamic>{
      't': '00:00:00.146',
      'src': 'submitHandler',
      'cb': 'AsyncCallback start',
      'detail': 'payload=4096B',
      'color': paletteMagenta,
    },
    <String, dynamic>{
      't': '00:00:00.420',
      'src': 'submitHandler',
      'cb': 'AsyncCallback complete',
      'detail': 'status=200 elapsed=274ms',
      'color': paletteSuccess,
    },
    <String, dynamic>{
      't': '00:00:00.421',
      'src': 'ChangeNotifier#ad6',
      'cb': 'listener#0',
      'detail': 'value changed',
      'color': paletteTeal,
    },
    <String, dynamic>{
      't': '00:00:00.422',
      'src': 'ChangeNotifier#ad6',
      'cb': 'listener#1',
      'detail': 'value changed',
      'color': paletteTeal,
    },
    <String, dynamic>{
      't': '00:00:00.423',
      'src': 'ChangeNotifier#ad6',
      'cb': 'listener#2',
      'detail': 'value changed',
      'color': paletteTeal,
    },
    <String, dynamic>{
      't': '00:00:00.601',
      'src': 'FocusNode#emailField',
      'cb': 'onFocusChange',
      'detail': 'hasFocus=false',
      'color': paletteViolet,
    },
    <String, dynamic>{
      't': '00:00:00.612',
      'src': 'ScrollController#main',
      'cb': 'listener',
      'detail': 'offset=128.5',
      'color': paletteAmber,
    },
    <String, dynamic>{
      't': '00:00:00.842',
      'src': 'Ticker#splash',
      'cb': 'TickerCallback',
      'detail': 'elapsed=0:00:00.231000',
      'color': paletteCrimson,
    },
    <String, dynamic>{
      't': '00:00:00.991',
      'src': 'Future#xhr',
      'cb': 'whenComplete',
      'detail': 'cleanup ran',
      'color': paletteInkSoft,
    },
  ];

  final List<Widget> eventLogRows = List<Widget>.generate(eventLog.length, (
    int i,
  ) {
    final Map<String, dynamic> e = eventLog[i];
    final Color c = e['color'] as Color;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: i.isEven
            ? Colors.white
            : paletteSurfaceAlt.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c.withValues(alpha: 0.18), width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110.0,
            child: Text(
              e['t'] as String,
              style: const TextStyle(
                color: paletteInkSoft,
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ),
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 160.0,
            child: Text(
              e['src'] as String,
              style: const TextStyle(
                color: paletteInk,
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 170.0,
            child: Text(
              e['cb'] as String,
              style: TextStyle(
                color: c,
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              e['detail'] as String,
              style: const TextStyle(
                color: paletteInkSoft,
                fontSize: 11.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  });

  final Widget eventLogSection = sectionShell(
    title: '10 — Event Log Viewer',
    subtitle:
        'A realistic snapshot of the callback chatter during one second of '
        'an interactive form submission.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteInk,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: paletteOutline, width: 1.0),
      ),
      child: Column(children: eventLogRows),
    ),
  );

  // =========================================================================
  // SECTION 12 - MULTI-TOUCH HANDLER GRID
  // =========================================================================

  final List<Map<String, dynamic>> pointers = <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'P1',
      'kind': 'touch',
      'cb': 'onPointerDown',
      'pos': '(120, 240)',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'id': 'P2',
      'kind': 'touch',
      'cb': 'onPointerDown',
      'pos': '(280, 240)',
      'color': paletteTeal,
    },
    <String, dynamic>{
      'id': 'P3',
      'kind': 'touch',
      'cb': 'onPointerMove',
      'pos': '(140, 260)',
      'color': paletteMagenta,
    },
    <String, dynamic>{
      'id': 'P4',
      'kind': 'mouse',
      'cb': 'onPointerHover',
      'pos': '(300, 100)',
      'color': paletteAmber,
    },
    <String, dynamic>{
      'id': 'P5',
      'kind': 'stylus',
      'cb': 'onPointerMove',
      'pos': '(420, 320)',
      'color': paletteViolet,
    },
    <String, dynamic>{
      'id': 'P6',
      'kind': 'touch',
      'cb': 'onPointerUp',
      'pos': '(150, 280)',
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'id': 'P7',
      'kind': 'mouse',
      'cb': 'onPointerSignal',
      'pos': '(160, 90)',
      'color': paletteCrimson,
    },
    <String, dynamic>{
      'id': 'P8',
      'kind': 'touch',
      'cb': 'onPointerCancel',
      'pos': '(0, 0)',
      'color': paletteInkSoft,
    },
  ];

  final List<Widget> pointerTiles = pointers.map((Map<String, dynamic> p) {
    final Color c = p['color'] as Color;
    return Container(
      width: 230.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            c.withValues(alpha: 0.12),
            c.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: c.withValues(alpha: 0.45), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  p['id'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                p['kind'] as String,
                style: TextStyle(
                  color: c,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            p['cb'] as String,
            style: const TextStyle(
              color: paletteInk,
              fontSize: 13.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'position: ${p['pos']}',
            style: const TextStyle(
              color: paletteInkSoft,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }).toList();

  final Widget multiTouchSection = sectionShell(
    title: '11 — Multi-Touch Handler Grid',
    subtitle:
        'Listener exposes a richer family of pointer callbacks than '
        'GestureDetector — useful for raw multi-touch tracking.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteSuccess,
    child: Wrap(children: pointerTiles),
  );

  // =========================================================================
  // SECTION 13 - FOCUS CALLBACK DEMO
  // =========================================================================

  final List<Map<String, dynamic>> focusEntries = <Map<String, dynamic>>[
    <String, dynamic>{
      'node': 'usernameField',
      'state': 'hasFocus',
      'detail': 'gained focus from initial route push',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'node': 'passwordField',
      'state': 'idle',
      'detail': 'waiting for tab key',
      'color': paletteInkSoft,
    },
    <String, dynamic>{
      'node': 'submitButton',
      'state': 'idle',
      'detail': 'enabled after form validation',
      'color': paletteInkSoft,
    },
    <String, dynamic>{
      'node': 'forgotPasswordLink',
      'state': 'idle',
      'detail': 'tertiary action',
      'color': paletteInkSoft,
    },
    <String, dynamic>{
      'node': 'rememberMeCheckbox',
      'state': 'hasFocus',
      'detail': 'arrow-key reached',
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'node': 'languageSelector',
      'state': 'idle',
      'detail': 'opens dropdown menu',
      'color': paletteInkSoft,
    },
  ];

  final List<Widget> focusRows = focusEntries.map((Map<String, dynamic> f) {
    final Color c = f['color'] as Color;
    final bool isFocused = f['state'] == 'hasFocus';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isFocused ? c.withValues(alpha: 0.10) : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isFocused ? c : paletteOutline,
          width: isFocused ? 1.8 : 1.0,
        ),
        boxShadow: isFocused
            ? <BoxShadow>[
                BoxShadow(
                  color: c.withValues(alpha: 0.30),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            isFocused
                ? Icons.center_focus_strong
                : Icons.radio_button_unchecked,
            color: c,
            size: 22.0,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'FocusNode#${f['node']}',
                  style: const TextStyle(
                    color: paletteInk,
                    fontSize: 13.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  f['detail'] as String,
                  style: const TextStyle(
                    color: paletteInkSoft,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: c.withValues(alpha: 0.5), width: 1.0),
            ),
            child: Text(
              f['state'] as String,
              style: TextStyle(
                color: c,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final Widget focusSection = sectionShell(
    title: '12 — FocusNode Callback Demo',
    subtitle:
        'FocusNode.addListener registers a callback fired whenever the '
        'focus tree visits or leaves the node.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ...focusRows,
        const SizedBox(height: 12.0),
        codeBlock(
          'final FocusNode node = FocusNode(debugLabel: "username");\n'
          'node.addListener(() {\n'
          '  if (node.hasFocus) onGain(); else onLost();\n'
          '});',
          accent: paletteAccent,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 14 - ANIMATION TICKER CALLBACK DEMO
  // =========================================================================

  final List<Map<String, dynamic>> tickerSamples = <Map<String, dynamic>>[
    <String, dynamic>{'t': 0.000, 'v': 0.00},
    <String, dynamic>{'t': 0.016, 'v': 0.05},
    <String, dynamic>{'t': 0.033, 'v': 0.10},
    <String, dynamic>{'t': 0.050, 'v': 0.18},
    <String, dynamic>{'t': 0.066, 'v': 0.28},
    <String, dynamic>{'t': 0.083, 'v': 0.40},
    <String, dynamic>{'t': 0.100, 'v': 0.52},
    <String, dynamic>{'t': 0.116, 'v': 0.65},
    <String, dynamic>{'t': 0.133, 'v': 0.76},
    <String, dynamic>{'t': 0.150, 'v': 0.86},
    <String, dynamic>{'t': 0.166, 'v': 0.93},
    <String, dynamic>{'t': 0.183, 'v': 0.97},
    <String, dynamic>{'t': 0.200, 'v': 1.00},
  ];

  final List<Widget> tickerBars = List<Widget>.generate(tickerSamples.length, (
    int i,
  ) {
    final Map<String, dynamic> s = tickerSamples[i];
    final double v = s['v'] as double;
    return SizedBox(
      width: 36.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 90.0 * v,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    paletteAccent.withValues(alpha: 0.7),
                    paletteViolet.withValues(alpha: 0.9),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4.0),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${(s['t'] as double).toStringAsFixed(3)}s',
              style: const TextStyle(
                color: paletteInkSoft,
                fontSize: 9.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  });

  final Widget tickerSection = sectionShell(
    title: '13 — Ticker Callback (Animation)',
    subtitle:
        'A TickerCallback is invoked once per vsync (~16ms). The bars below '
        'show interpolated values for an eased animation.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteViolet,
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: paletteVioletSoft.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: tickerBars,
          ),
        ),
        const SizedBox(height: 12.0),
        codeBlock(
          'class _MyState extends State<MyWidget>\n'
          '    with SingleTickerProviderStateMixin {\n'
          '  late final AnimationController controller;\n'
          '  @override void initState() {\n'
          '    super.initState();\n'
          '    controller = AnimationController(\n'
          '      vsync: this,\n'
          '      duration: const Duration(milliseconds: 200),\n'
          '    )..addListener(() => setState(() {}))\n'
          '     ..forward();\n'
          '  }\n'
          '}',
          accent: paletteViolet,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 15 - METRICS DASHBOARD
  // =========================================================================

  final Widget metricsSection = sectionShell(
    title: '14 — Callback Metrics Dashboard',
    subtitle:
        'A glance at the demo state: how many handles registered, how many '
        'fired, average latency, peak fan-out.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteTeal,
    child: Wrap(
      children: <Widget>[
        metric('Handles', '4', paletteAccent, Icons.tag),
        metric('Fired (1s)', '128', paletteSuccess, Icons.bolt),
        metric('Listeners', '17', paletteMagenta, Icons.people),
        metric('Async / s', '3', paletteAmber, Icons.cloud_sync),
        metric('Avg latency', '4.2ms', paletteViolet, Icons.timer),
        metric('Peak fanout', '12', paletteCrimson, Icons.call_split),
        metric('Cancelled', '2', paletteInkSoft, Icons.cancel),
        metric('Throttled', '92', paletteTeal, Icons.filter_alt),
      ],
    ),
  );

  // =========================================================================
  // SECTION 16 - DO / DONT REFERENCE
  // =========================================================================

  final List<Map<String, dynamic>> doDontEntries = <Map<String, dynamic>>[
    <String, dynamic>{
      'text': 'Use top-level (file-scope) functions for callback handles.',
      'color': paletteSuccess,
      'icon': Icons.check_circle,
    },
    <String, dynamic>{
      'text': 'Use static class methods if you need namespacing.',
      'color': paletteSuccess,
      'icon': Icons.check_circle,
    },
    <String, dynamic>{
      'text': 'Persist handles in shared storage when reusing across launches.',
      'color': paletteSuccess,
      'icon': Icons.check_circle,
    },
    <String, dynamic>{
      'text': 'Convert the int handle back via getCallbackFromHandle.',
      'color': paletteSuccess,
      'icon': Icons.check_circle,
    },
    <String, dynamic>{
      'text': 'Pass closures — they cannot survive the isolate hop.',
      'color': paletteCrimson,
      'icon': Icons.cancel,
    },
    <String, dynamic>{
      'text': 'Pass instance methods — receivers are not serialisable.',
      'color': paletteCrimson,
      'icon': Icons.cancel,
    },
    <String, dynamic>{
      'text': 'Capture mutable state in the function — only static state at '
          'startup survives in the background isolate.',
      'color': paletteCrimson,
      'icon': Icons.cancel,
    },
    <String, dynamic>{
      'text': 'Assume the handle remains stable across hot reloads — '
          'always re-register at app start.',
      'color': paletteCrimson,
      'icon': Icons.cancel,
    },
  ];

  final List<Widget> doDontRows = doDontEntries.map((
    Map<String, dynamic> d,
  ) {
    final Color c = d['color'] as Color;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(
          left: BorderSide(color: c, width: 5.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(d['icon'] as IconData, color: c, size: 22.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              d['text'] as String,
              style: const TextStyle(
                color: paletteInk,
                fontSize: 13.0,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final Widget doDontSection = sectionShell(
    title: '15 — Do / Don\'t Reference',
    subtitle:
        'Hard rules that fall out of the underlying handle table: only '
        'identity-stable, isolate-safe references are allowed.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteCrimson,
    child: Column(children: doDontRows),
  );

  // =========================================================================
  // SECTION 17 - SUCCESS NOTE
  // =========================================================================

  final Widget successNote = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: paletteSuccessSoft.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: paletteSuccess.withValues(alpha: 0.5),
        width: 1.2,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: paletteSuccess,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.verified,
            color: Colors.white,
            size: 24.0,
          ),
        ),
        const SizedBox(width: 12.0),
        const Expanded(
          child: Text(
            'When the registration table is non-empty and every entry is a '
            'top-level/static function, the engine guarantees a stable handle '
            '— the precondition for safe isolate hand-off.',
            style: TextStyle(
              color: paletteInk,
              fontSize: 13.0,
              height: 1.55,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 18 - CLOSING SUMMARY
  // =========================================================================

  final Widget summarySection = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF111827),
          Color(0xFF1F2937),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 16.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(
                Icons.summarize,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'Takeaways',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'CallbackHandle is intentionally boring as a class — its job is to '
          'serialise an identity, not to provide behaviour. The interesting '
          'work happens around it: gestures, animations, focus, timers and '
          'async pipelines all converge on top-level functions that can be '
          'safely revived in another isolate. The visual sections above are '
          'each a candidate place where a CallbackHandle could plug a '
          'background isolate into the UI without violating Dart\'s isolate '
          'isolation rules.',
          style: TextStyle(
            color: Color(0xFFE2E8F0),
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            pillBadge(
              'isolate-safe identifiers',
              Colors.white,
              icon: Icons.shield,
            ),
            pillBadge('top-level only', Colors.white, icon: Icons.label),
            pillBadge('opaque integer', Colors.white, icon: Icons.tag),
            pillBadge(
              'round-trip via PluginUtilities',
              Colors.white,
              icon: Icons.swap_horiz,
            ),
          ],
        ),
      ],
    ),
  );

  // =========================================================================
  // FINAL ASSEMBLY
  // =========================================================================

  return Scaffold(
    backgroundColor: paletteSurfaceAlt,
    appBar: AppBar(
      backgroundColor: paletteInk,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'dart:ui CallbackHandle — Deep Demo',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroBanner,
          handleAnatomy,
          typedRefsSection,
          gestureSection,
          buttonSection,
          registrationSection,
          asyncFlow,
          chainSection,
          debounceSection,
          throttleSection,
          eventLogSection,
          multiTouchSection,
          focusSection,
          tickerSection,
          metricsSection,
          doDontSection,
          successNote,
          summarySection,
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
