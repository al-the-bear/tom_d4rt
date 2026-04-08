// ignore_for_file: avoid_print
// RawTooltipState – comprehensive deep demo
// Amber Gold / Cream palette – state object for the RawTooltip widget:
// manages lifecycle, visibility, animation, and overlay positioning.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color tsAmber = Color(0xFFFF8F00);
  const Color tsCream = Color(0xFFFFF8E1);
  const Color tsOnAmber = Color(0xFFFFFFFF);
  const Color tsDeepAmber = Color(0xFFE65100);
  const Color tsLightCream = Color(0xFFFFFDF4);
  const Color tsTextDark = Color(0xFF3E2700);
  const Color tsAccent = Color(0xFFFFB300);
  const Color tsMuted = Color(0xFFFFCC80);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget tsHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [tsAmber, tsDeepAmber],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: tsOnAmber)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: tsOnAmber.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget tsSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: tsLightCream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tsAmber.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: tsAmber.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: tsAmber)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ],
      ),
    );
  }

  Widget tsBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('▸ ',
              style: TextStyle(color: tsAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: tsTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget tsCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1800),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: tsCream,
              height: 1.5)),
    );
  }

  Widget tsKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: tsDeepAmber)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: tsTextDark)),
          ),
        ],
      ),
    );
  }

  Widget tsHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tsAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: tsAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: tsDeepAmber,
              height: 1.4)),
    );
  }

  Widget tsDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: tsMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget tsInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tsAmber.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: tsAmber)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: tsDeepAmber)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: tsTextDark)),
          ),
        ],
      ),
    );
  }

  Widget tsPhase(String name, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: tsAmber,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$name: ',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: tsDeepAmber)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: tsTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: tsCream,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          tsHeader(
            'RawTooltipState',
            'State object for the RawTooltip widget – manages tooltip '
                'visibility, animation, overlay positioning, and lifecycle',
          ),

          // ── 1. class overview ──
          tsSection('1 · Class Identity & Role', [
            tsKeyValue('Class', 'RawTooltipState'),
            tsKeyValue('Extends', 'State<RawTooltip>'),
            tsKeyValue('Mixins',
                'SingleTickerProviderStateMixin'),
            tsKeyValue('Purpose',
                'Manages internal state for RawTooltip widget'),
            tsDivider(),
            tsBullet(
                'RawTooltipState is the State object that backs the '
                'RawTooltip widget. It manages the tooltip overlay entry, '
                'animation controller, and visibility logic.'),
            tsBullet(
                'Unlike TooltipState (which extends RawTooltipState and adds '
                'Material Design styling), RawTooltipState provides the raw '
                'mechanismwithout any visual design.'),
            tsBullet(
                'You access RawTooltipState via a GlobalKey to '
                'programmatically show or hide the tooltip.'),
          ]),

          // ── 2. state lifecycle ──
          tsSection('2 · State Lifecycle', [
            tsPhase('initState',
                'Creates the AnimationController for tooltip fade, sets '
                'initial visibility from widget.triggerMode'),
            tsPhase('didUpdateWidget',
                'Checks for changes in waitDuration, showDuration, '
                'triggerMode, and re-configures timers accordingly'),
            tsPhase('dispose',
                'Disposes the AnimationController, cancels hover/show '
                'timers, removes the overlay entry if visible'),
            tsDivider(),
            tsCodeBlock(
                '// Typical lifecycle:\n'
                '// initState → build → (user hover) → show → animate\n'
                '//   → showDuration expires → hide → animate out\n'
                '//   → remove overlay → dispose (on widget removal)'),
            tsBullet(
                'The AnimationController uses a SingleTickerProviderStateMixin, '
                'meaning RawTooltip should not be deeply nested in a widget '
                'with another SingleTickerProviderStateMixin.'),
          ]),

          // ── 3. ensureTooltipVisible ──
          tsSection('3 · ensureTooltipVisible()', [
            tsBullet(
                'The public API method to programmatically show the tooltip. '
                'Returns a bool indicating whether the tooltip was newly shown.'),
            tsCodeBlock(
                '// Programmatic show via GlobalKey\n'
                'final key = GlobalKey<RawTooltipState>();\n'
                '\n'
                'RawTooltip(\n'
                '  key: key,\n'
                '  message: \'Tooltip content\',\n'
                '  child: Icon(Icons.info),\n'
                ')\n'
                '\n'
                '// Later, to show:\n'
                'key.currentState?.ensureTooltipVisible();'),
            tsDivider(),
            tsBullet(
                'If the tooltip is already visible, ensureTooltipVisible() '
                'resets the showDuration timer and returns false.'),
            tsBullet(
                'If the tooltip is not visible, it creates the overlay entry, '
                'starts the forward animation, and returns true.'),
            tsHighlight(
                'This is the only public method on RawTooltipState for showing '
                'the tooltip. There is no static or top-level API – you must '
                'use a GlobalKey to access the state object.'),
          ]),

          // ── 4. show / hide mechanics ──
          tsSection('4 · Show / Hide Mechanics', [
            tsBullet(
                'Show: creates an OverlayEntry and inserts it into the '
                'nearest Overlay ancestor. The tooltip then fades in.'),
            tsBullet(
                'Hide: starts the reverse animation, and after the animation '
                'completes, removes the OverlayEntry.'),
            tsBullet(
                'The showDuration timer automatically triggers hide after '
                'the specified duration (default: 1500ms for long-press).'),
            tsCodeBlock(
                '// Internal show flow:\n'
                '// 1. _createOverlayEntry()\n'
                '// 2. Overlay.of(context).insert(_overlayEntry)\n'
                '// 3. _animationController.forward()\n'
                '// 4. Timer(showDuration, _hide)\n'
                '\n'
                '// Internal hide flow:\n'
                '// 1. _animationController.reverse()\n'
                '// 2. _animationController.addStatusListener\n'
                '// 3. When dismissed → _overlayEntry.remove()'),
          ]),

          // ── 5. animation ──
          tsSection('5 · Animation Controller', [
            tsKeyValue('Controller',
                'AnimationController with vsync from mixin'),
            tsKeyValue('Duration', '150ms (default fade-in/out)'),
            tsKeyValue('Curve', 'Curves.linear (default)'),
            tsKeyValue('Property', 'Opacity (0.0 → 1.0)'),
            tsDivider(),
            tsBullet(
                'The animation drives a FadeTransition wrapping the tooltip '
                'content. Custom animations can be achieved by wrapping '
                'RawTooltip in your own AnimatedBuilder.'),
            tsBullet(
                'The animationController duration is NOT configurable via '
                'RawTooltip constructor. To customize, subclass RawTooltipState '
                'and override initState.'),
            tsCodeBlock(
                '// The overlay entry contains:\n'
                'FadeTransition(\n'
                '  opacity: _animationController,\n'
                '  child: /* positioned tooltip content */,\n'
                ')'),
          ]),

          // ── 6. overlay positioning ──
          tsSection('6 · Overlay Positioning', [
            tsBullet(
                'The tooltip is positioned relative to its child widget '
                'using the TooltipPosition class (above, below, left, right, '
                'or auto).'),
            tsBullet(
                'Positioning logic accounts for screen edges: if the tooltip '
                'would overflow, it flips to the opposite side.'),
            tsKeyValue('preferBelow', 'true → try below first, flip to above'),
            tsKeyValue('preferBelow', 'false → try above first, flip to below'),
            tsKeyValue('verticalOffset',
                'Gap between child and tooltip (default: 24.0)'),
            tsDivider(),
            tsCodeBlock(
                '// Positioning calculation (simplified)\n'
                'Offset calculatePosition({\n'
                '  required Size childSize,\n'
                '  required Size tooltipSize,\n'
                '  required Size screenSize,\n'
                '  required bool preferBelow,\n'
                '  required double verticalOffset,\n'
                '}) {\n'
                '  final below = childBottom + verticalOffset;\n'
                '  final above = childTop - verticalOffset - tooltipH;\n'
                '  if (preferBelow && below + tooltipH <= screenH) {\n'
                '    return Offset(centeredX, below);\n'
                '  }\n'
                '  return Offset(centeredX, above);\n'
                '}'),
          ]),

          // ── 7. trigger modes ──
          tsSection('7 · Trigger Modes', [
            tsInfoRow('H', 'Hover:', 'Mouse enter triggers show after waitDuration'),
            tsInfoRow('L', 'LongPress:',
                'Touch hold triggers show after waitDuration'),
            tsInfoRow('T', 'Tap:', 'Single tap triggers show immediately'),
            tsInfoRow('M', 'Manual:', 'Only via ensureTooltipVisible()'),
            tsDivider(),
            tsBullet(
                'triggerMode determines which user gesture activates the '
                'tooltip. Default is TooltipTriggerMode.longPress on '
                'mobile, TooltipTriggerMode.hover on desktop.'),
            tsCodeBlock(
                '// Configure trigger mode\n'
                'RawTooltip(\n'
                '  triggerMode: TooltipTriggerMode.tap,\n'
                '  message: \'Appears on tap\',\n'
                '  child: Icon(Icons.help),\n'
                ')'),
          ]),

          // ── 8. mouse hover behavior ──
          tsSection('8 · Mouse Hover Behavior', [
            tsBullet(
                'On desktop platforms, mouse enter starts a waitDuration '
                'timer (default: 0ms). When the timer fires, the tooltip '
                'appears.'),
            tsBullet(
                'Mouse exit starts the hide process immediately (or after '
                'a brief delay for mouse-over-tooltip scenarios).'),
            tsBullet(
                'The tooltip itself has a hit-testable region: moving the '
                'mouse from the child to the tooltip keeps it visible.'),
            tsHighlight(
                'This mouse-over-tooltip behavior means the tooltip acts as '
                'an interactive element on desktop, unlike mobile where it '
                'automatically dismisses after showDuration.'),
            tsDivider(),
            tsKeyValue('waitDuration', 'Delay before showing (default: 0ms)'),
            tsKeyValue('showDuration',
                'Auto-hide after show (default: 1500ms on mobile)'),
          ]),

          // ── 9. long-press trigger ──
          tsSection('9 · Long-Press Trigger Details', [
            tsBullet(
                'On mobile, the default trigger is long-press. The user '
                'must hold their finger on the child widget for the '
                'waitDuration before the tooltip appears.'),
            tsBullet(
                'The tooltip appears near the press point, respecting '
                'the verticalOffset and preferBelow settings.'),
            tsBullet(
                'Lifting the finger does NOT immediately hide the tooltip. '
                'Instead, the showDuration timer starts counting down.'),
            tsCodeBlock(
                '// Long-press flow:\n'
                '// 1. GestureDetector.onLongPress fires\n'
                '// 2. RawTooltipState shows tooltip\n'
                '// 3. showDuration timer starts (1500ms default)\n'
                '// 4. Timer fires → tooltip hides with animation'),
          ]),

          // ── 10. RawTooltip vs Tooltip ──
          tsSection('10 · RawTooltip vs Tooltip', [
            tsPhase('RawTooltip',
                'Unstyled, provides only mechanics: overlay, positioning, '
                'animation, triggers. No default visual decoration.'),
            tsPhase('Tooltip',
                'Material Design wrapper: adds rounded card, shadow, padding, '
                'text style from ThemeData.tooltipTheme.'),
            tsDivider(),
            tsBullet(
                'Use RawTooltip when building a custom design system or '
                'non-Material UI. Use Tooltip for standard Material apps.'),
            tsBullet(
                'TooltipState extends RawTooltipState, so all state management '
                'logic in this demo applies to Tooltip as well.'),
            tsCodeBlock(
                '// RawTooltip – no styling\n'
                'RawTooltip(\n'
                '  message: \'Raw content\',\n'
                '  child: Icon(Icons.info),\n'
                '  decoration: BoxDecoration(\n'
                '    color: Colors.black87,\n'
                '    borderRadius: BorderRadius.circular(4),\n'
                '  ),\n'
                ')\n'
                '\n'
                '// Tooltip – Material styled\n'
                'Tooltip(\n'
                '  message: \'Material tooltip\',\n'
                '  child: Icon(Icons.info),\n'
                ')'),
          ]),

          // ── 11. overlay entry management ──
          tsSection('11 · Overlay Entry Management', [
            tsBullet(
                'The tooltip creates a single OverlayEntry that is inserted '
                'into the nearest Overlay (typically the Navigator overlay).'),
            tsBullet(
                'The overlay entry is positioned using a CustomSingleChildLayout '
                'that calculates position based on the child RenderBox.'),
            tsBullet(
                'If the widget scrolls while the tooltip is visible, the '
                'overlay entry position is NOT automatically updated. This '
                'can cause visual misalignment.'),
            tsHighlight(
                'To handle scroll scenarios, wrap the tooltip in a builder '
                'that dismisses the tooltip on scroll, or use a '
                'ScrollController listener.'),
          ]),

          // ── 12. GlobalKey usage ──
          tsSection('12 · GlobalKey Access Pattern', [
            tsBullet(
                'GlobalKey<RawTooltipState> is the standard way to '
                'programmatically control a tooltip.'),
            tsCodeBlock(
                'class MyWidget extends StatelessWidget {\n'
                '  final _tooltipKey = GlobalKey<RawTooltipState>();\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    return Column(\n'
                '      children: [\n'
                '        RawTooltip(\n'
                '          key: _tooltipKey,\n'
                '          triggerMode: TooltipTriggerMode.manual,\n'
                '          message: \'Programmatic tooltip\',\n'
                '          child: const Text(\'Hover target\'),\n'
                '        ),\n'
                '        ElevatedButton(\n'
                '          onPressed: () {\n'
                '            _tooltipKey.currentState\n'
                '                ?.ensureTooltipVisible();\n'
                '          },\n'
                '          child: const Text(\'Show tooltip\'),\n'
                '        ),\n'
                '      ],\n'
                '    );\n'
                '  }\n'
                '}'),
          ]),

          // ── 13. rich tooltip content ──
          tsSection('13 · Rich Tooltip Content', [
            tsBullet(
                'RawTooltip supports both a simple message (String) and '
                'a rich content widget via the richMessage parameter.'),
            tsBullet(
                'When richMessage is provided, message is ignored. Use '
                'richMessage for tooltips with InlineSpan trees.'),
            tsCodeBlock(
                '// Rich tooltip with styled text\n'
                'RawTooltip(\n'
                '  richMessage: TextSpan(\n'
                '    children: [\n'
                '      TextSpan(\n'
                '        text: \'Bold: \',\n'
                '        style: TextStyle(fontWeight: FontWeight.bold),\n'
                '      ),\n'
                '      TextSpan(text: \'Normal text follows\'),\n'
                '    ],\n'
                '  ),\n'
                '  child: Icon(Icons.info_outline),\n'
                ')'),
            tsDivider(),
            tsKeyValue('message', 'Simple String tooltip text'),
            tsKeyValue('richMessage', 'InlineSpan for rich formatted text'),
          ]),

          // ── 14. dismissal behavior ──
          tsSection('14 · Dismissal Behavior', [
            tsBullet(
                'Automatic: showDuration timer triggers hide.'),
            tsBullet(
                'User action: tapping outside the tooltip dismisses it.'),
            tsBullet(
                'Programmatic: calling Navigator.pop() or removing the '
                'widget tree dismisses the overlay.'),
            tsBullet(
                'Scroll: by default, scrolling does NOT dismiss the tooltip '
                '(it just visually separates from the child).'),
            tsDivider(),
            tsBullet(
                'The dismiss-on-tap-outside behavior is achieved through a '
                'GestureDetector on the overlay that calls hide.'),
            tsBullet(
                'RawTooltip does not have a dismiss() method. To force hide, '
                'you must use the internal state API or rebuild with '
                'different parameters.'),
          ]),

          // ── 15. semantics ──
          tsSection('15 · Semantics & Accessibility', [
            tsBullet(
                'The tooltip message is exposed as a Semantics label on the '
                'child widget, accessible by screen readers.'),
            tsBullet(
                'The excludeFromSemantics property can suppress this to avoid '
                'redundant announcements when the child already has a label.'),
            tsCodeBlock(
                '// Tooltip adds semantics automatically\n'
                'Semantics(\n'
                '  label: widget.message,\n'
                '  child: widget.child,\n'
                ')\n'
                '\n'
                '// Suppress with:\n'
                'RawTooltip(\n'
                '  excludeFromSemantics: true,\n'
                '  message: \'Already labeled\',\n'
                '  child: Semantics(\n'
                '    label: \'My custom label\',\n'
                '    child: Icon(Icons.info),\n'
                '  ),\n'
                ')'),
          ]),

          // ── 16. edge cases ──
          tsSection('16 · Edge Cases & Gotchas', [
            tsBullet(
                'Tooltip in a scrollable: overlay position goes stale if the '
                'child scrolls off-screen while tooltip is visible.'),
            tsBullet(
                'Multiple tooltips: only one tooltip should be visible at a time. '
                'Showing a second tooltip does not auto-hide the first.'),
            tsBullet(
                'Hot reload: tooltip overlay may persist across hot reloads. '
                'A full restart resolves orphaned overlays.'),
            tsBullet(
                'Dispose during animation: if the widget is removed while the '
                'animation is running, the AnimationController is safely '
                'disposed and the overlay entry is removed.'),
            tsBullet(
                'Empty message: providing an empty string hides the tooltip '
                'entirely (no overlay is created).'),
          ]),

          // ── 17. testing strategies ──
          tsSection('17 · Testing Strategies', [
            tsCodeBlock(
                'testWidgets(\'tooltip shows on long press\',\n'
                '    (WidgetTester tester) async {\n'
                '  await tester.pumpWidget(MaterialApp(\n'
                '    home: Scaffold(\n'
                '      body: RawTooltip(\n'
                '        message: \'Hello\',\n'
                '        child: const Text(\'Target\'),\n'
                '      ),\n'
                '    ),\n'
                '  ));\n'
                '  // Trigger long press\n'
                '  await tester.longPress(find.text(\'Target\'));\n'
                '  await tester.pump(const Duration(seconds: 1));\n'
                '  expect(find.text(\'Hello\'), findsOneWidget);\n'
                '});'),
            tsDivider(),
            tsBullet(
                'Use pumpAndSettle to wait for the fade animation to complete '
                'before asserting tooltip visibility.'),
            tsBullet(
                'Test mouse hover using TestGesture: gesture.moveTo(center) '
                'then pump to trigger the waitDuration timer.'),
          ]),

          // ── 18. API summary ──
          tsSection('18 · Quick API Reference', [
            tsKeyValue('Class', 'RawTooltipState'),
            tsKeyValue('Widget', 'RawTooltip'),
            tsKeyValue('Key method', 'ensureTooltipVisible()'),
            tsKeyValue('Animation', '150ms fade (AnimationController)'),
            tsKeyValue('Overlay', 'Single OverlayEntry, auto-positioned'),
            tsKeyValue('Triggers', 'Hover / LongPress / Tap / Manual'),
            tsDivider(),
            tsCodeBlock(
                '// Complete RawTooltip example\n'
                'final key = GlobalKey<RawTooltipState>();\n'
                'RawTooltip(\n'
                '  key: key,\n'
                '  message: \'Tooltip text\',\n'
                '  waitDuration: Duration(milliseconds: 500),\n'
                '  showDuration: Duration(seconds: 2),\n'
                '  preferBelow: true,\n'
                '  verticalOffset: 24.0,\n'
                '  triggerMode: TooltipTriggerMode.longPress,\n'
                '  decoration: BoxDecoration(\n'
                '    color: Colors.grey.shade900,\n'
                '    borderRadius: BorderRadius.circular(4),\n'
                '  ),\n'
                '  textStyle: TextStyle(\n'
                '    color: Colors.white,\n'
                '    fontSize: 12,\n'
                '  ),\n'
                '  child: Icon(Icons.info),\n'
                ')'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: tsAmber.withValues(alpha: 0.06),
            child: const Text(
              'RawTooltipState · Amber Gold Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: tsMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
