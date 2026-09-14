// ignore_for_file: avoid_print
// D4rt deep demo: PageRouteBuilder — convenience class for custom page routes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Ember / Crimson ───────────────────────────────────────
  const deepCrimson = Color(0xFFB71C1C);
  const crimson = Color(0xFFC62828);
  const ember = Color(0xFFD32F2F);
  const softEmber = Color(0xFFEF5350);
  const lightEmber = Color(0xFFFFCDD2);
  const paleEmber = Color(0xFFFFEBEE);
  const whiteEmber = Color(0xFFFFF5F5);
  const darkEmber = Color(0xFF4A0A0A);
  const accentGold = Color(0xFFFF8F00);
  const accentTeal = Color(0xFF00796B);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget heading(String title, String sub, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.72)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (sub.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(sub,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget note(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkEmber)),
    );
  }

  Widget kvRow(String key, String val, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(key,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(val,
                style: TextStyle(fontSize: 13, color: darkEmber)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('PageRouteBuilder deep demo executing');
  print('=' * 60);

  print('\n--- PageRouteBuilder overview ---');
  print('Convenience class for one-off page routes without subclassing');
  print('Defined in widgets/pages.dart line 89');
  print('Extends PageRoute<T> with callback-based buildPage/buildTransitions');

  print('\n--- Inheritance chain ---');
  print('PageRouteBuilder<T> extends PageRoute<T>');
  print('  extends ModalRoute<T>');
  print('    extends TransitionRoute<T>');
  print('      extends OverlayRoute<T>');
  print('        extends Route<T>');

  print('\n--- Constructor parameters ---');
  print('pageBuilder: required RoutePageBuilder callback');
  print('transitionsBuilder: RouteTransitionsBuilder (default: child passthrough)');
  print('transitionDuration: Duration (default: 300ms)');
  print('reverseTransitionDuration: Duration (default: 300ms)');
  print('opaque: bool (default: true)');
  print('barrierDismissible: bool (default: false)');
  print('barrierColor: Color? (default: null)');
  print('barrierLabel: String? (default: null)');
  print('maintainState: bool (default: true)');
  print('fullscreenDialog: bool (default: false)');
  print('allowSnapshotting: bool (default: true)');
  print('settings: RouteSettings?');
  print('requestFocus: bool (default: true)');

  print('\n--- Transition patterns ---');
  print('Fade: FadeTransition(opacity: animation)');
  print('Slide: SlideTransition(position: Tween<Offset>)');
  print('Scale: ScaleTransition(scale: animation)');
  print('Rotation: RotationTransition(turns: animation)');

  print('\n${'=' * 60}');
  print('PageRouteBuilder deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title ─────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepCrimson, crimson, ember],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.route, size: 28, color: lightEmber),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('PageRouteBuilder<T>',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('A convenience class for building one-off page '
                  'routes with custom transitions. Instead of '
                  'subclassing PageRoute, provide pageBuilder and '
                  'transitionsBuilder callbacks to define the page '
                  'content and animation.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('PageRoute<T>', crimson, Colors.white),
                tag('pageBuilder', ember, Colors.white),
                tag('transitionsBuilder', softEmber, Colors.white),
                tag('callback-based', lightEmber, darkEmber),
              ]),
            ],
          ),
        ),

        // ── 2. Inheritance chain ─────────────────────────────────────
        heading('1 \u00b7 Inheritance Chain',
            'Six levels from Route to PageRouteBuilder',
            deepCrimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightEmber),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 6; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: [deepCrimson, crimson, ember, softEmber, accentGold, accentTeal][i]
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepCrimson, crimson, ember, softEmber, accentGold, accentTeal][i],
                        width: i == 5 ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: [deepCrimson, crimson, ember, softEmber, accentGold, accentTeal][i],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text([
                              'Route<T>',
                              'OverlayRoute<T>',
                              'TransitionRoute<T>',
                              'ModalRoute<T>',
                              'PageRoute<T>',
                              'PageRouteBuilder<T>',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: [deepCrimson, crimson, ember, softEmber, accentGold, accentTeal][i])),
                            Text([
                              'Abstract base — defines install, dispose, navigator',
                              'Manages overlay entries for visual display',
                              'Adds animation controller, secondaryAnimation, duration',
                              'Adds barrier, scoped navigation, focus management',
                              'Adds fullscreenDialog, canTransitionTo/From, buildPage',
                              'Callback-based — delegates to pageBuilder/transitionsBuilder',
                            ][i],
                                style: TextStyle(
                                    fontSize: 9, color: darkEmber)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 5)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Icon(Icons.arrow_downward,
                        size: 12, color: softEmber),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. Constructor anatomy ───────────────────────────────────
        heading('2 \u00b7 Constructor Parameters',
            'All parameters with defaults',
            crimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final param in [
                ('pageBuilder', 'RoutePageBuilder', 'required', 'Callback that builds the page content widget',
                    Icons.pages, deepCrimson),
                ('transitionsBuilder', 'RouteTransitionsBuilder', '_defaultTransitionsBuilder', 'Wraps page in transition animation',
                    Icons.animation, crimson),
                ('transitionDuration', 'Duration', '300ms', 'Forward animation duration',
                    Icons.timer, ember),
                ('reverseTransitionDuration', 'Duration', '300ms', 'Reverse (pop) animation duration',
                    Icons.timer_off, softEmber),
                ('opaque', 'bool', 'true', 'Whether route obscures previous route (performance)',
                    Icons.opacity, accentGold),
                ('barrierDismissible', 'bool', 'false', 'Tap outside to pop the route',
                    Icons.touch_app, accentTeal),
                ('barrierColor', 'Color?', 'null', 'Overlay color behind route for modal effect',
                    Icons.format_color_fill, deepCrimson),
                ('barrierLabel', 'String?', 'null', 'Accessibility label for the barrier',
                    Icons.label, crimson),
                ('maintainState', 'bool', 'true', 'Keep previous route alive in memory',
                    Icons.memory, ember),
                ('fullscreenDialog', 'bool', 'false', 'Show close button instead of back arrow',
                    Icons.fullscreen, softEmber),
                ('allowSnapshotting', 'bool', 'true', 'Allow snapshotting for predictive back',
                    Icons.camera_alt, accentGold),
                ('settings', 'RouteSettings?', 'null', 'Route name and arguments for identification',
                    Icons.settings, accentTeal),
                ('requestFocus', 'bool', 'true', 'Auto-focus route content on push',
                    Icons.center_focus_strong, deepCrimson),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: param.$6.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: param.$6, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(param.$5, size: 16, color: param.$6),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(param.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: param.$6)),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: param.$6.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(param.$2,
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 8,
                                          color: param.$6)),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: paleEmber,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('= ${param.$3}',
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 8,
                                          color: darkEmber)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 1),
                            Text(param.$4,
                                style: TextStyle(
                                    fontSize: 10, color: darkEmber)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. pageBuilder callback ──────────────────────────────────
        heading('3 \u00b7 pageBuilder Callback',
            'RoutePageBuilder — the page content factory',
            deepCrimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepCrimson.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepCrimson.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'typedef RoutePageBuilder = Widget Function(\n'
                    '  BuildContext context,\n'
                    '  Animation<double> animation,\n'
                    '  Animation<double> secondaryAnimation,\n'
                    ');',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepCrimson)),
              ),
              const SizedBox(height: 8),
              for (final param in [
                ('context', 'Standard BuildContext of the route', deepCrimson),
                ('animation', 'Primary animation — drives entrance/exit transitions (0.0 to 1.0)', crimson),
                ('secondaryAnimation', 'Secondary animation — driven by the NEXT route pushing on top', ember),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: param.$3.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: param.$3, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(param.$1,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: param.$3)),
                      ),
                      Expanded(
                        child: Text(param.$2,
                            style: TextStyle(
                                fontSize: 10, color: darkEmber)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        note(
          'pageBuilder is called every time the route needs to rebuild. '
          'The animation parameter can be used to animate your page '
          'content directly, separate from the transition defined in '
          'transitionsBuilder.',
          deepCrimson,
          paleEmber,
        ),
        const SizedBox(height: 14),

        // ── 5. transitionsBuilder ────────────────────────────────────
        heading('4 \u00b7 transitionsBuilder Callback',
            'RouteTransitionsBuilder — wrapping the page in animation',
            crimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: crimson.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: crimson.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'typedef RouteTransitionsBuilder \n'
                    '    = Widget Function(\n'
                    '  BuildContext context,\n'
                    '  Animation<double> animation,\n'
                    '  Animation<double> secondaryAnimation,\n'
                    '  Widget child,  // pageBuilder output\n'
                    ');',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: crimson)),
              ),
              const SizedBox(height: 10),
              // Default behavior box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentGold.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: accentGold),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 14, color: accentGold),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                          'Default: returns child as-is (no transition animation). '
                          'Override to add fade, slide, scale, or custom effects.',
                          style: TextStyle(
                              fontSize: 10, color: darkEmber)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Four transition patterns ──────────────────────────────
        heading('5 \u00b7 Transition Patterns',
            'Four common animations built with transitionsBuilder',
            ember, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final t in [
                ('Fade', 'FadeTransition(\n  opacity: animation,\n  child: child,\n)',
                    Icons.blur_on, deepCrimson,
                    'Opacity goes from 0.0 to 1.0'),
                ('Slide from Right', 'SlideTransition(\n  position: Tween(\n'
                    '    begin: Offset(1.0, 0.0),\n    end: Offset.zero,\n'
                    '  ).animate(animation),\n  child: child,\n)',
                    Icons.arrow_forward, crimson,
                    'Slides in from the right edge'),
                ('Scale', 'ScaleTransition(\n  scale: animation,\n  child: child,\n)',
                    Icons.zoom_out_map, ember,
                    'Grows from center (0.0 to 1.0 scale)'),
                ('Rotation', 'RotationTransition(\n  turns: animation,\n  child: child,\n)',
                    Icons.rotate_right, softEmber,
                    'Rotates one full turn (0.0 to 1.0 turns)'),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: t.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: t.$4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(t.$3, size: 18, color: t.$4),
                          const SizedBox(width: 8),
                          Text(t.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: t.$4)),
                          const Spacer(),
                          Text(t.$5,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontStyle: FontStyle.italic,
                                  color: t.$4)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: t.$4.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(t.$2,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: t.$4)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Combined transitions ──────────────────────────────────
        heading('6 \u00b7 Combining Transitions',
            'Chain multiple animations together',
            deepCrimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepCrimson.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepCrimson.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'transitionsBuilder: (ctx, anim, secAnim, child) {\n'
                    '  final curved = CurvedAnimation(\n'
                    '    parent: anim,\n'
                    '    curve: Curves.easeInOutCubic,\n'
                    '  );\n'
                    '  return FadeTransition(\n'
                    '    opacity: curved,\n'
                    '    child: SlideTransition(\n'
                    '      position: Tween(\n'
                    '        begin: const Offset(0, 0.3),\n'
                    '        end: Offset.zero,\n'
                    '      ).animate(curved),\n'
                    '      child: child,\n'
                    '    ),\n'
                    '  );\n'
                    '}',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: deepCrimson)),
              ),
              const SizedBox(height: 8),
              note(
                'Combine fade + slide for a polished entrance. Use '
                'CurvedAnimation to apply easing curves for natural '
                'motion. Nest transitions from outer to inner.',
                crimson,
                paleEmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Duration control ──────────────────────────────────────
        heading('7 \u00b7 Duration Control',
            'transitionDuration and reverseTransitionDuration',
            crimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: crimson.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: crimson),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.play_arrow, color: crimson, size: 24),
                          const SizedBox(height: 4),
                          Text('Forward',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: crimson)),
                          Text('transitionDuration',
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 9,
                                  color: crimson)),
                          const SizedBox(height: 4),
                          Text('Default: 300ms',
                              style: TextStyle(
                                  fontSize: 10, color: darkEmber)),
                          Text('When route is pushed',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontStyle: FontStyle.italic,
                                  color: darkEmber)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.compare_arrows,
                        size: 20, color: softEmber),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ember.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ember),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.fast_rewind, color: ember, size: 24),
                          const SizedBox(height: 4),
                          Text('Reverse',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: ember)),
                          Text('reverseTransitionDuration',
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 9,
                                  color: ember)),
                          const SizedBox(height: 4),
                          Text('Default: 300ms',
                              style: TextStyle(
                                  fontSize: 10, color: darkEmber)),
                          Text('When route is popped',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontStyle: FontStyle.italic,
                                  color: darkEmber)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (final speed in [
                ('Instant', '0ms', 'No animation — jump cut', accentGold),
                ('Fast', '150ms', 'Quick transitions for frequent navigation', ember),
                ('Standard', '300ms', 'Material default — balanced feel', crimson),
                ('Dramatic', '600ms+', 'Showcase transitions, onboarding flows', deepCrimson),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: speed.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: speed.$4, width: 2)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(speed.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: speed.$4)),
                      ),
                      SizedBox(
                        width: 48,
                        child: Text(speed.$2,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: speed.$4)),
                      ),
                      Expanded(
                        child: Text(speed.$3,
                            style: TextStyle(
                                fontSize: 10, color: darkEmber)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Opaque vs non-opaque ──────────────────────────────────
        heading('8 \u00b7 Opaque vs Non-Opaque',
            'Route obscuring behavior for performance and visuals',
            ember, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentTeal, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle,
                              size: 14, color: accentTeal),
                          const SizedBox(width: 4),
                          Text('opaque: true',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: accentTeal)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('Default. Route fully covers '
                          'the previous route.',
                          style: TextStyle(
                              fontSize: 10, color: darkEmber)),
                      const SizedBox(height: 4),
                      Text('Previous route is NOT painted '
                          '(better performance).',
                          style: TextStyle(
                              fontSize: 9,
                              fontStyle: FontStyle.italic,
                              color: accentTeal)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentGold.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentGold, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.layers,
                              size: 14, color: accentGold),
                          const SizedBox(width: 4),
                          Text('opaque: false',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: accentGold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('Route is semi-transparent. '
                          'Previous route shows through.',
                          style: TextStyle(
                              fontSize: 10, color: darkEmber)),
                      const SizedBox(height: 4),
                      Text('Previous route IS painted '
                          '(needed for see-through).',
                          style: TextStyle(
                              fontSize: 9,
                              fontStyle: FontStyle.italic,
                              color: accentGold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Barrier properties ───────────────────────────────────
        heading('9 \u00b7 Barrier Properties',
            'barrierDismissible, barrierColor, barrierLabel',
            deepCrimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final bp in [
                ('barrierDismissible', 'false', 'When true, tapping outside the route pops it. '
                    'Useful for modal-like routes where tapping the '
                    'scrim area should dismiss.',
                    Icons.touch_app, crimson),
                ('barrierColor', 'null', 'If set, paints a colored overlay behind the route. '
                    'Common: Colors.black54 for dark scrim. Requires '
                    'opaque: false to be visible.',
                    Icons.format_color_fill, ember),
                ('barrierLabel', 'null', 'Semantic label for the barrier, read by screen '
                    'readers. Should describe the dismissable area, '
                    'e.g. "Dismiss dialog".',
                    Icons.accessibility, softEmber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: bp.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: bp.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(bp.$4, size: 16, color: bp.$5),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(bp.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: bp.$5)),
                                const SizedBox(width: 6),
                                Text('default: ${bp.$2}',
                                    style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 9,
                                        color: darkEmber)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(bp.$3,
                                style: TextStyle(
                                    fontSize: 10, color: darkEmber)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. fullscreenDialog ─────────────────────────────────────
        heading('10 \u00b7 fullscreenDialog Mode',
            'Switch from back arrow to close button',
            crimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: crimson.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: crimson),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_back, size: 24, color: crimson),
                          const SizedBox(height: 4),
                          Text('false (default)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: crimson)),
                          Text('Back arrow in AppBar\nNavigational flow',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9, color: darkEmber)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_forward,
                        size: 16, color: softEmber),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ember.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ember, width: 2),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.close, size: 24, color: ember),
                          const SizedBox(height: 4),
                          Text('true',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: ember)),
                          Text('Close button in AppBar\nModal/creation flow',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9, color: darkEmber)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              note(
                'Use fullscreenDialog: true for creation flows (new item, '
                'compose email). The system will show a close icon instead '
                'of a back arrow, signaling to the user that this is a '
                'modal task rather than drill-down navigation.',
                crimson,
                paleEmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. maintainState ────────────────────────────────────────
        heading('11 \u00b7 maintainState',
            'Keep previous route alive or dispose it',
            ember, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final ms in [
                (true, 'Previous route stays in widget tree', 'State preserved on pop',
                    'Higher memory usage', accentTeal),
                (false, 'Previous route disposed when obscured', 'State lost — rebuilds on pop',
                    'Lower memory usage', accentGold),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ms.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ms.$5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('maintainState: ${ms.$1}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: ms.$5)),
                      const SizedBox(height: 4),
                      kvRow('Behavior', ms.$2, ms.$5),
                      kvRow('On pop back', ms.$3, ms.$5),
                      kvRow('Trade-off', ms.$4, ms.$5),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Comparison with MaterialPageRoute ────────────────────
        heading('12 \u00b7 Comparison: Route Builders',
            'PageRouteBuilder vs MaterialPageRoute vs CupertinoPageRoute',
            deepCrimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepCrimson),
                children: [
                  for (final h in [
                    'Feature',
                    'PageRouteBuilder',
                    'MaterialPageRoute',
                    'CupertinoPageRoute',
                  ])
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(h,
                          style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                ],
              ),
              for (final row in [
                ('Transition', 'Custom', 'Fade+Slide up', 'Slide right'),
                ('Subclassing', 'Not needed', 'Optional', 'Optional'),
                ('Callbacks', 'pageBuilder + transitionsBuilder', 'builder', 'builder'),
                ('Platform feel', 'Custom', 'Material', 'iOS'),
                ('Duration ctrl', 'Full control', 'Fixed 300ms', 'Fixed 400ms'),
                ('Use case', 'One-off custom', 'Material apps', 'iOS apps'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              color: darkEmber)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 8, color: crimson)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 8, color: accentTeal)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$4,
                          style: TextStyle(
                              fontSize: 8, color: accentGold)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Navigation usage ─────────────────────────────────────
        heading('13 \u00b7 Navigation Usage',
            'Pushing a PageRouteBuilder via Navigator',
            crimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: crimson.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: crimson.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'Navigator.of(context).push(\n'
                    '  PageRouteBuilder(\n'
                    '    settings: RouteSettings(name: "/detail"),\n'
                    '    pageBuilder: (ctx, anim, secAnim) {\n'
                    '      return DetailPage(itemId: 42);\n'
                    '    },\n'
                    '    transitionsBuilder:\n'
                    '        (ctx, anim, secAnim, child) {\n'
                    '      return FadeTransition(\n'
                    '        opacity: anim,\n'
                    '        child: child,\n'
                    '      );\n'
                    '    },\n'
                    '    transitionDuration:\n'
                    '        const Duration(milliseconds: 200),\n'
                    '  ),\n'
                    ');',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: crimson)),
              ),
              const SizedBox(height: 8),
              // Usage patterns
              for (final use in [
                ('push', 'Standard forward navigation', Icons.arrow_forward, ember),
                ('pushReplacement', 'Replace current route', Icons.swap_horiz, crimson),
                ('pushAndRemoveUntil', 'Clear stack to root', Icons.layers_clear, deepCrimson),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: use.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: use.$4, width: 2)),
                  ),
                  child: Row(
                    children: [
                      Icon(use.$3, size: 14, color: use.$4),
                      const SizedBox(width: 6),
                      Text('Navigator.${use.$1}',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: use.$4)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(use.$2,
                            style: TextStyle(
                                fontSize: 10, color: darkEmber)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Secondary animation ──────────────────────────────────
        heading('14 \u00b7 Secondary Animation',
            'Reacting when another route pushes on top',
            ember, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ember.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: ember.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'transitionsBuilder:\n'
                    '    (ctx, anim, secAnim, child) {\n'
                    '  // anim: 0\u21921 when this route enters\n'
                    '  // secAnim: 0\u21921 when NEXT route enters\n'
                    '  return SlideTransition(\n'
                    '    position: Tween(\n'
                    '      begin: Offset.zero,\n'
                    '      end: const Offset(-0.3, 0.0),\n'
                    '    ).animate(secAnim),\n'
                    '    child: FadeTransition(\n'
                    '      opacity: anim,\n'
                    '      child: child,\n'
                    '    ),\n'
                    '  );\n'
                    '}',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: ember)),
              ),
              const SizedBox(height: 8),
              // Animation timeline visual
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: crimson.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: crimson),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Animation Timeline',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: crimson)),
                    const SizedBox(height: 6),
                    for (final phase in [
                      ('Route A pushed', 'A.animation: 0\u21921', 'A enters with transition', deepCrimson),
                      ('Route B pushed', 'A.secAnimation: 0\u21921', 'A slides left as B enters', crimson),
                      ('Route B popped', 'A.secAnimation: 1\u21920', 'A slides back to center', ember),
                      ('Route A popped', 'A.animation: 1\u21920', 'A exits with reverse transition', softEmber),
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: phase.$4,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 90,
                              child: Text(phase.$1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                      color: phase.$4)),
                            ),
                            SizedBox(
                              width: 110,
                              child: Text(phase.$2,
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 8,
                                      color: phase.$4)),
                            ),
                            Expanded(
                              child: Text(phase.$3,
                                  style: TextStyle(
                                      fontSize: 8, color: darkEmber)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Performance ──────────────────────────────────────────
        heading('15 \u00b7 Performance',
            'Route transition optimization tips',
            deepCrimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteEmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Keep opaque: true', 'Prevents painting the obscured route behind. '
                    'Only set false when you need transparency.',
                    Icons.visibility, crimson),
                ('Use CurvedAnimation', 'Apply easing curves for smooth, natural-feeling '
                    'motion without linear jumps.',
                    Icons.show_chart, ember),
                ('Avoid heavy rebuilds', 'pageBuilder is called on every frame during '
                    'animation. Keep the widget tree lightweight.',
                    Icons.speed, deepCrimson),
                ('allowSnapshotting', 'Enables predictive back gestures on Android. '
                    'Only disable if your page cannot be snapshotted.',
                    Icons.camera_alt, softEmber),
                ('Reuse routes carefully', 'PageRouteBuilder is for one-off routes. For '
                    'repeated patterns, create a named PageRoute subclass.',
                    Icons.repeat, accentGold),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: perf.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: perf.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(perf.$3, size: 16, color: perf.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${perf.$1}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: perf.$4)),
                            TextSpan(
                                text: perf.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkEmber)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 17. Summary ──────────────────────────────────────────────
        heading('16 \u00b7 Summary',
            'Key takeaways', deepCrimson, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepCrimson, crimson],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends PageRoute<T> with callback-based page building and transitions',
                'pageBuilder provides the page widget with access to both animations',
                'transitionsBuilder wraps the page in entrance/exit animation effects',
                'Supports fade, slide, scale, rotation, and combined transition patterns',
                'transitionDuration and reverseTransitionDuration default to 300ms each',
                'opaque: true (default) skips painting the previous route for performance',
                'barrierDismissible + barrierColor create dismissable modal overlays',
                'fullscreenDialog: true switches AppBar from back arrow to close button',
                'maintainState: true keeps previous route alive; false disposes it',
                'secondaryAnimation reacts when another route pushes on top of this one',
                'Use for one-off custom transitions; create PageRoute subclass for reuse',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightEmber,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
