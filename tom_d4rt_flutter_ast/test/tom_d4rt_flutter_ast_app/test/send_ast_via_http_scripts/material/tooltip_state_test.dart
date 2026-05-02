// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo - TooltipState (Material)
// ---------------------------------------------------------------------------
// `TooltipState` is the public State class behind `Tooltip`. Most apps never
// hold a reference to it directly: a `Tooltip` is constructed with a message
// (or richMessage) and the state is owned internally. The single reason to
// reach for it is when you want to OPEN a tooltip programmatically - in
// response to focus, in response to a help button, or from a tutorial
// overlay. Doing that requires a `GlobalKey<TooltipState>` so you can call
// `key.currentState?.ensureTooltipVisible()`.
//
// ensureTooltipVisible() returns `true` when a tooltip was newly shown (or
// reset) and `false` when the tooltip was already visible. It triggers the
// same animation pipeline as a real user interaction (hover, long-press,
// tap, depending on the trigger mode).
//
// This file is a hand-written deep demo, not a generated test. It demonstrates
// the full surface area of `Tooltip` - basic usage, programmatic show via
// `TooltipState`, every triggerMode, waitDuration / showDuration tuning, the
// preferBelow / verticalOffset / padding knobs, rich text via richMessage,
// theming via TooltipTheme, subtree disabling via TooltipVisibility, an
// activation log driven by the `onTriggered` callback, and two practical
// recipes (a focus-triggered help popover form and a truncated-cell data
// table).
//
// All sections live inside `dynamic build(BuildContext context)`; there is
// no `main()`, no `runApp()`, no `testWidgets()` - the harness wraps the
// returned `MaterialApp` itself.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TooltipState Deep Demo ===');
  print('TooltipState exposes ensureTooltipVisible() so you can show a');
  print('Tooltip programmatically via a GlobalKey<TooltipState>.');

  // ---------------------------------------------------------------------------
  // Activation log shared across sections. Multiple sections push entries
  // here from their `onTriggered` callbacks so the reader can correlate
  // user gestures with the resulting tooltip activations. The log is read
  // inside StatefulBuilder children, so a top-level mutable list works
  // (each setState rebuild reads the latest list).
  // ---------------------------------------------------------------------------
  final activationLog = ValueNotifier<List<String>>(<String>[]);
  void logActivation(String section) {
    final next = <String>['[$section] activated', ...activationLog.value];
    if (next.length > 10) {
      next.removeLast();
    }
    activationLog.value = next;
    print('tooltip activated [$section]');
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TooltipState Deep Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('TooltipState - Deep Demo'),
        backgroundColor: const Color(0xFF124559),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ===================================================================
              // SECTION 1 - HERO CARD
              // -------------------------------------------------------------------
              // Elevator pitch for `TooltipState`. The card explains why most
              // tooltips never need a key, when you actually want one, and the
              // single API you really care about: ensureTooltipVisible().
              // Visual identity: deep teal background, monospace tokens for
              // code references.
              // ===================================================================
              Card(
                color: const Color(0xFF124559),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.help_outline,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'class TooltipState',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'TooltipState is the State subclass behind Tooltip. '
                        'You rarely need a reference to it because Tooltip '
                        'reacts to hover, long-press and tap on its own. '
                        'When you DO need to show a tooltip from code - for '
                        'a tutorial, on focus, from a help button - capture '
                        'the State with a GlobalKey<TooltipState> and call '
                        'ensureTooltipVisible().',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 18),
                      _heroBullet(
                        token: 'GlobalKey<TooltipState>',
                        body: 'Attach to a Tooltip via its `key` parameter to '
                            'capture the live State.',
                      ),
                      const SizedBox(height: 10),
                      _heroBullet(
                        token: 'ensureTooltipVisible()',
                        body: 'Shows the tooltip if it is not already visible. '
                            'Returns true when newly shown, false otherwise.',
                      ),
                      const SizedBox(height: 10),
                      _heroBullet(
                        token: 'onTriggered callback',
                        body: 'Fires every time the tooltip becomes visible '
                            '(user gesture or programmatic). Great for '
                            'analytics or activity logs.',
                      ),
                      const SizedBox(height: 10),
                      _heroBullet(
                        token: 'TooltipTheme / TooltipVisibility',
                        body: 'Theme an entire subtree, or disable tooltips '
                            'in a subtree with TooltipVisibility(visible: false).',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 2 - BASIC TOOLTIP USAGE
              // -------------------------------------------------------------------
              // The simplest possible tooltips: an IconButton, a FilledButton,
              // and a plain Text. No keys, no programmatic control. The point
              // of the section is to remind readers what "default" tooltip
              // behaviour feels like before we start poking at TooltipState.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF2E7D32),
                title: '2. Basic Tooltip - hover / long-press defaults',
                subtitle: 'Three garden-variety tooltips. Hover on desktop, '
                    'long-press on mobile. Nothing special - this is the '
                    '"99% of cases" baseline.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    color: const Color(0xFFE8F5E9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Wrap(
                        spacing: 24,
                        runSpacing: 16,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _BasicTooltipTile(
                            title: 'IconButton',
                            description:
                                'The classic case - a glyph that needs a '
                                'label. Tooltip.message is read by screen '
                                'readers via Semantics.',
                            child: Tooltip(
                              message: 'Save the current document (Ctrl+S)',
                              onTriggered: () => logActivation('basic.icon'),
                              child: IconButton(
                                icon: const Icon(Icons.save_outlined),
                                color: const Color(0xFF2E7D32),
                                iconSize: 32,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          _BasicTooltipTile(
                            title: 'FilledButton',
                            description:
                                'A labelled button with extra context on hover. '
                                'Use sparingly - the label should already be '
                                'self-explanatory.',
                            child: Tooltip(
                              message: 'Sends the form to the server. '
                                  'You will receive an email confirmation.',
                              onTriggered: () => logActivation('basic.filled'),
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D32),
                                ),
                                onPressed: () {},
                                icon: const Icon(Icons.send),
                                label: const Text('Submit'),
                              ),
                            ),
                          ),
                          _BasicTooltipTile(
                            title: 'Plain Text',
                            description:
                                'You can wrap any widget. Useful when the UI '
                                'shows a value whose units are not obvious.',
                            child: Tooltip(
                              message: 'Temperature in degrees Celsius',
                              onTriggered: () => logActivation('basic.text'),
                              child: const Text(
                                '23.4 \u00B0',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 3 - PROGRAMMATIC SHOW VIA GlobalKey<TooltipState>
              // -------------------------------------------------------------------
              // The headline section. Three Tooltip widgets, each with its
              // own GlobalKey<TooltipState>. External buttons drive the
              // tooltips by calling ensureTooltipVisible(). A counter tracks
              // how many times each tooltip has been activated, illustrating
              // that programmatic shows fire onTriggered just like real
              // gestures.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF6A1B9A),
                title: '3. Programmatic show via GlobalKey<TooltipState>',
                subtitle: 'Click the "Show tip" buttons. Each one calls '
                    'ensureTooltipVisible() on its sibling Tooltip - this is '
                    'the central use case for TooltipState.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  // We create the keys once per build of this StatefulBuilder.
                  // Re-creating them on every setState() is fine because the
                  // builder rebuild only reattaches them to the same Tooltip
                  // widgets in the same positions, so the State elements are
                  // preserved by Flutter's element tree reconciliation.
                  final keyAlpha = GlobalKey<TooltipState>();
                  final keyBeta = GlobalKey<TooltipState>();
                  final keyGamma = GlobalKey<TooltipState>();

                  int countAlpha = 0;
                  int countBeta = 0;
                  int countGamma = 0;

                  void show(GlobalKey<TooltipState> key, String name) {
                    final shown = key.currentState?.ensureTooltipVisible();
                    print('ensureTooltipVisible($name) -> $shown');
                    setState(() {
                      switch (name) {
                        case 'alpha':
                          countAlpha++;
                          break;
                        case 'beta':
                          countBeta++;
                          break;
                        case 'gamma':
                          countGamma++;
                          break;
                      }
                      logActivation('prog.$name');
                    });
                  }

                  return Card(
                    elevation: 2,
                    color: const Color(0xFFF3E5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Each row pairs a Tooltip with an external trigger '
                            'button. The trigger does not interact with the '
                            'wrapped widget directly - it calls '
                            'ensureTooltipVisible() on the captured State.',
                            style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 16),
                          _ProgrammaticRow(
                            accent: const Color(0xFF6A1B9A),
                            label: 'alpha',
                            description:
                                'Tooltip on a star icon. Click "Show alpha" '
                                'to open it programmatically.',
                            count: countAlpha,
                            tooltip: Tooltip(
                              key: keyAlpha,
                              message: 'Mark this item as a favourite. '
                                  'Favourites appear at the top of your list.',
                              onTriggered: () => logActivation('alpha.fired'),
                              child: const Icon(
                                Icons.star_rounded,
                                size: 36,
                                color: Color(0xFF6A1B9A),
                              ),
                            ),
                            onShow: () => show(keyAlpha, 'alpha'),
                          ),
                          const Divider(height: 28),
                          _ProgrammaticRow(
                            accent: const Color(0xFF6A1B9A),
                            label: 'beta',
                            description:
                                'Tooltip on a button. Notice that calling '
                                'ensureTooltipVisible() does NOT activate '
                                'onPressed - it only opens the tooltip.',
                            count: countBeta,
                            tooltip: Tooltip(
                              key: keyBeta,
                              message: 'Compute the next batch (Ctrl+Enter)',
                              onTriggered: () => logActivation('beta.fired'),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6A1B9A),
                                  foregroundColor: Colors.white,
                                ),
                                icon: const Icon(Icons.bolt),
                                label: const Text('Run'),
                                onPressed: () {},
                              ),
                            ),
                            onShow: () => show(keyBeta, 'beta'),
                          ),
                          const Divider(height: 28),
                          _ProgrammaticRow(
                            accent: const Color(0xFF6A1B9A),
                            label: 'gamma',
                            description:
                                'Repeated calls return false - the tooltip '
                                'is already visible, so the second call does '
                                'not re-trigger the show animation.',
                            count: countGamma,
                            tooltip: Tooltip(
                              key: keyGamma,
                              message: 'Connection latency to the API '
                                  'gateway in milliseconds.',
                              onTriggered: () => logActivation('gamma.fired'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF6A1B9A),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Text(
                                  '42 ms',
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF6A1B9A),
                                  ),
                                ),
                              ),
                            ),
                            onShow: () => show(keyGamma, 'gamma'),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: const Text(
                              'Implementation note: ensureTooltipVisible() '
                              'returns a bool that is true if a new tooltip '
                              'was shown, false if the tooltip was already '
                              'visible. Use that return value to avoid '
                              'double-firing analytics.',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 4 - TRIGGER MODES (tap / longPress / manual)
              // -------------------------------------------------------------------
              // SegmentedButton picker drives a single Tooltip's triggerMode.
              // The user can flip between tap, longPress and manual and try
              // the same chip. In `manual` mode, only ensureTooltipVisible()
              // can show the tooltip - native gestures do nothing.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFFEF6C00),
                title: '4. triggerMode - tap / longPress / manual',
                subtitle: 'Pick a mode and try interacting with the chip. '
                    'In manual mode only the side button can open the '
                    'tooltip - that is exactly what TooltipState is for.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  TooltipTriggerMode mode = TooltipTriggerMode.tap;
                  final modeKey = GlobalKey<TooltipState>();

                  return Card(
                    elevation: 2,
                    color: const Color(0xFFFFF3E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SegmentedButton<TooltipTriggerMode>(
                            segments: const [
                              ButtonSegment(
                                value: TooltipTriggerMode.tap,
                                label: Text('tap'),
                                icon: Icon(Icons.touch_app),
                              ),
                              ButtonSegment(
                                value: TooltipTriggerMode.longPress,
                                label: Text('longPress'),
                                icon: Icon(Icons.timer),
                              ),
                              ButtonSegment(
                                value: TooltipTriggerMode.manual,
                                label: Text('manual'),
                                icon: Icon(Icons.do_not_touch),
                              ),
                            ],
                            selected: <TooltipTriggerMode>{mode},
                            onSelectionChanged: (s) {
                              setState(() => mode = s.first);
                            },
                          ),
                          const SizedBox(height: 18),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Tooltip(
                                key: modeKey,
                                message: 'Active triggerMode: ${mode.name}',
                                triggerMode: mode,
                                onTriggered: () =>
                                    logActivation('mode.${mode.name}'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEF6C00),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.label, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text(
                                        'Try me',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFEF6C00),
                                  side: const BorderSide(
                                      color: Color(0xFFEF6C00)),
                                ),
                                icon: const Icon(Icons.visibility),
                                label: const Text('ensureTooltipVisible()'),
                                onPressed: () {
                                  modeKey.currentState
                                      ?.ensureTooltipVisible();
                                  logActivation('mode.button');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Text(
                              _modeExplanation(mode),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 5 - waitDuration / showDuration
              // -------------------------------------------------------------------
              // Two sliders adjust waitDuration (delay before opening on
              // hover) and showDuration (how long the tooltip stays after
              // the gesture ends). The configured Tooltip uses both knobs
              // live - hover the chip to feel the effect.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF00838F),
                title: '5. waitDuration & showDuration',
                subtitle: 'Slide to tune the appearance and disappearance '
                    'delays. waitDuration only applies on hover. '
                    'showDuration applies to all trigger modes.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  double waitMs = 600;
                  double showMs = 1500;
                  final durKey = GlobalKey<TooltipState>();

                  return Card(
                    elevation: 2,
                    color: const Color(0xFFE0F7FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DurationSlider(
                            label: 'waitDuration',
                            valueMs: waitMs,
                            min: 0,
                            max: 2000,
                            accent: const Color(0xFF00838F),
                            onChanged: (v) => setState(() => waitMs = v),
                            description:
                                'Hover this long over the child before the '
                                'tooltip appears. Default is 0 (instant).',
                          ),
                          const SizedBox(height: 12),
                          _DurationSlider(
                            label: 'showDuration',
                            valueMs: showMs,
                            min: 200,
                            max: 5000,
                            accent: const Color(0xFF00838F),
                            onChanged: (v) => setState(() => showMs = v),
                            description:
                                'Once visible, the tooltip stays for this '
                                'long after the gesture ends.',
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Tooltip(
                                key: durKey,
                                message: 'Wait ${waitMs.toInt()} ms, then '
                                    'stay for ${showMs.toInt()} ms.',
                                waitDuration:
                                    Duration(milliseconds: waitMs.toInt()),
                                showDuration:
                                    Duration(milliseconds: showMs.toInt()),
                                onTriggered: () =>
                                    logActivation('duration.hover'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00838F),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Hover me',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              FilledButton.tonalIcon(
                                onPressed: () {
                                  durKey.currentState?.ensureTooltipVisible();
                                  logActivation('duration.button');
                                },
                                icon: const Icon(Icons.flash_on),
                                label: const Text('Show now'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 6 - preferBelow, verticalOffset, padding
              // -------------------------------------------------------------------
              // Switch + sliders to play with the geometry knobs. The
              // Tooltip chip is placed in a fixed-size box so the user can
              // see the orientation flip when preferBelow toggles.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF455A64),
                title: '6. preferBelow / verticalOffset / padding',
                subtitle: 'Geometry knobs. preferBelow chooses orientation, '
                    'verticalOffset is the distance from the child, padding '
                    'inflates the tooltip body.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  bool preferBelow = true;
                  double offset = 24;
                  double pad = 12;
                  final geomKey = GlobalKey<TooltipState>();

                  return Card(
                    elevation: 2,
                    color: const Color(0xFFECEFF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'preferBelow',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Switch(
                                value: preferBelow,
                                onChanged: (v) =>
                                    setState(() => preferBelow = v),
                                activeColor: const Color(0xFF455A64),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                preferBelow
                                    ? 'true (under the child)'
                                    : 'false (above the child)',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          _DurationSlider(
                            label: 'verticalOffset',
                            valueMs: offset,
                            min: 0,
                            max: 80,
                            accent: const Color(0xFF455A64),
                            unit: 'px',
                            onChanged: (v) => setState(() => offset = v),
                            description:
                                'Distance between the child and the tooltip.',
                          ),
                          const SizedBox(height: 8),
                          _DurationSlider(
                            label: 'padding',
                            valueMs: pad,
                            min: 4,
                            max: 32,
                            accent: const Color(0xFF455A64),
                            unit: 'px',
                            onChanged: (v) => setState(() => pad = v),
                            description:
                                'Inner padding of the tooltip itself.',
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 220,
                            child: Center(
                              child: Tooltip(
                                key: geomKey,
                                message:
                                    'preferBelow=$preferBelow, offset=${offset.toInt()}, pad=${pad.toInt()}',
                                preferBelow: preferBelow,
                                verticalOffset: offset,
                                padding: EdgeInsets.all(pad),
                                onTriggered: () =>
                                    logActivation('geometry'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF455A64),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Anchor box',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF455A64),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                geomKey.currentState
                                    ?.ensureTooltipVisible();
                                logActivation('geometry.button');
                              },
                              icon: const Icon(Icons.center_focus_strong),
                              label: const Text('Show tooltip programmatically'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 7 - richMessage with formatted text
              // -------------------------------------------------------------------
              // A Tooltip whose body is built from TextSpan(s), giving us
              // bold, coloured, monospaced inline text. richMessage is a
              // dedicated alternative to message - they are mutually
              // exclusive.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFFC2185B),
                title: '7. richMessage - mixed-style content',
                subtitle: 'Use richMessage instead of message when the body '
                    'needs bold, colour, or monospaced spans.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  final richKey = GlobalKey<TooltipState>();
                  return Card(
                    elevation: 2,
                    color: const Color(0xFFFCE4EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hover or click the chip below; the tooltip '
                            'mixes regular text with bold and monospace '
                            'spans, plus a coloured warning suffix.',
                            style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Tooltip(
                                key: richKey,
                                triggerMode: TooltipTriggerMode.tap,
                                onTriggered: () => logActivation('rich'),
                                richMessage: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Run the '),
                                    const TextSpan(
                                      text: 'maintenance ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const TextSpan(text: 'task '),
                                    const TextSpan(
                                      text: 'cron --vacuum',
                                      style: TextStyle(
                                        fontFamily: 'monospace',
                                        backgroundColor: Color(0xFF512630),
                                      ),
                                    ),
                                    const TextSpan(text: '. '),
                                    const TextSpan(
                                      text: 'May lock the database '
                                          'briefly.',
                                      style: TextStyle(
                                        color: Color(0xFFFFB300),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC2185B),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Vacuum DB',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFC2185B),
                                  side: const BorderSide(
                                      color: Color(0xFFC2185B)),
                                ),
                                onPressed: () {
                                  richKey.currentState
                                      ?.ensureTooltipVisible();
                                  logActivation('rich.button');
                                },
                                child: const Text('Show rich tooltip'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 8 - TooltipTheme
              // -------------------------------------------------------------------
              // A subtree wrapped in TooltipTheme. All tooltips inside the
              // subtree pick up the custom decoration, text style, padding
              // and excludeFromSemantics flag without configuring each one.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF1B5E20),
                title: '8. TooltipTheme - subtree-wide styling',
                subtitle: 'Wrap a subtree in TooltipTheme to override '
                    'decoration, textStyle, enableTapToDismiss, etc. for '
                    'every Tooltip inside it.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    color: const Color(0xFFE8F5E9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: TooltipTheme(
                        data: TooltipThemeData(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B5E20),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFA5D6A7),
                              width: 1.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          textStyle: const TextStyle(
                            color: Color(0xFFE8F5E9),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'monospace',
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          waitDuration:
                              const Duration(milliseconds: 100),
                          showDuration:
                              const Duration(milliseconds: 2500),
                          excludeFromSemantics: false,
                          preferBelow: true,
                        ),
                        child: Wrap(
                          spacing: 18,
                          runSpacing: 14,
                          children: [
                            Tooltip(
                              message: 'compile()',
                              onTriggered: () =>
                                  logActivation('themed.compile'),
                              child: _ThemedChip(
                                icon: Icons.build,
                                label: 'Compile',
                              ),
                            ),
                            Tooltip(
                              message: 'analyze()',
                              onTriggered: () =>
                                  logActivation('themed.analyze'),
                              child: _ThemedChip(
                                icon: Icons.search,
                                label: 'Analyze',
                              ),
                            ),
                            Tooltip(
                              message: 'deploy(--prod)',
                              onTriggered: () =>
                                  logActivation('themed.deploy'),
                              child: _ThemedChip(
                                icon: Icons.cloud_upload,
                                label: 'Deploy',
                              ),
                            ),
                            Tooltip(
                              message: 'rollback()',
                              onTriggered: () =>
                                  logActivation('themed.rollback'),
                              child: _ThemedChip(
                                icon: Icons.undo,
                                label: 'Rollback',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 9 - TooltipVisibility(visible: false, ...)
              // -------------------------------------------------------------------
              // Two identical chip rows. The second row is wrapped in
              // TooltipVisibility(visible: false) so all tooltips in that
              // subtree are silenced - useful for screenshots, demos, or
              // accessibility modes where tooltips would clutter the UI.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF7B1FA2),
                title: '9. TooltipVisibility - mute a subtree',
                subtitle: 'Two identical rows. The second row is wrapped in '
                    'TooltipVisibility(visible: false) so its tooltips never '
                    'appear, even on hover.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  Widget row(bool tooltipsOn, Color accent, String banner) {
                    final children = <Widget>[
                      Tooltip(
                        message: 'Edit the document',
                        onTriggered: () => logActivation('vis.$banner.edit'),
                        child: _PillIcon(
                          icon: Icons.edit,
                          label: 'Edit',
                          accent: accent,
                        ),
                      ),
                      Tooltip(
                        message: 'Share with collaborators',
                        onTriggered: () => logActivation('vis.$banner.share'),
                        child: _PillIcon(
                          icon: Icons.share,
                          label: 'Share',
                          accent: accent,
                        ),
                      ),
                      Tooltip(
                        message: 'Move to trash',
                        onTriggered: () =>
                            logActivation('vis.$banner.trash'),
                        child: _PillIcon(
                          icon: Icons.delete,
                          label: 'Delete',
                          accent: accent,
                        ),
                      ),
                    ];
                    final inner = Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final c in children) ...[
                          c,
                          const SizedBox(width: 12),
                        ],
                      ],
                    );
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: accent.withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            banner,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: accent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          tooltipsOn
                              ? inner
                              : TooltipVisibility(
                                  visible: false,
                                  child: inner,
                                ),
                        ],
                      ),
                    );
                  }

                  return Card(
                    elevation: 2,
                    color: const Color(0xFFF3E5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          row(true, const Color(0xFF7B1FA2),
                              'Tooltips ENABLED'),
                          row(false, const Color(0xFFAD1457),
                              'Tooltips MUTED'),
                          const SizedBox(height: 8),
                          const Text(
                            'TooltipVisibility is great for screenshot tools, '
                            'guided tour overlays, or kiosk mode where '
                            'transient overlays would distract.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 10 - ACTIVATION LOG
              // -------------------------------------------------------------------
              // A live log of every onTriggered fire across the demo.
              // Backed by ValueNotifier<List<String>> so it does not need
              // its own StatefulBuilder - ValueListenableBuilder rebuilds
              // exactly when entries change.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF263238),
                title: '10. Activation log (onTriggered callback)',
                subtitle: 'Every Tooltip in the demo pushes an entry here '
                    'via its onTriggered callback - both real gestures and '
                    'programmatic ensureTooltipVisible() calls fire it.',
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<List<String>>(
                valueListenable: activationLog,
                builder: (context, log, _) {
                  return Card(
                    elevation: 2,
                    color: const Color(0xFFECEFF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recent activations',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${log.length} entries',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: log.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      '(no activations yet - hover or '
                                      'click a tooltip above)',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (final entry in log)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            entry,
                                            style: const TextStyle(
                                              fontFamily: 'monospace',
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
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 11 - RECIPE: focus-triggered help icons
              // -------------------------------------------------------------------
              // A practical form recipe. Each field has a help icon next to
              // it. When the field gains focus, we open the help tooltip via
              // ensureTooltipVisible() on a captured GlobalKey<TooltipState>.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF1565C0),
                title: '11. Recipe - focus-triggered help icons',
                subtitle: 'Tab through the fields. The help tooltip beside '
                    'the active field opens automatically via '
                    'ensureTooltipVisible() called from a FocusNode listener.',
              ),
              const SizedBox(height: 12),
              _FocusHelpRecipe(
                accent: const Color(0xFF1565C0),
                onTrigger: (which) => logActivation('focus.$which'),
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 12 - RECIPE: truncated data table cell
              // -------------------------------------------------------------------
              // A DataTable where one column shows a long URL truncated with
              // ellipsis. Each cell wraps its truncated text in a Tooltip
              // whose message is the full URL. A "peek" button on each row
              // demonstrates programmatic open via TooltipState.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF00695C),
                title: '12. Recipe - truncated cell + full-value tooltip',
                subtitle: 'Common spreadsheet pattern. Hover the truncated '
                    'URL to see the whole thing; the peek button calls '
                    'ensureTooltipVisible() on the row\'s key.',
              ),
              const SizedBox(height: 12),
              _TruncationRecipe(
                accent: const Color(0xFF00695C),
                onTrigger: (row) => logActivation('table.$row'),
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 13 - DECISION CARD: Tooltip vs Snackbar vs Banner
              // -------------------------------------------------------------------
              // A small reference card answering the perennial question of
              // when to use which transient surface. Plain text with a
              // colour swatch per option.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFFAD1457),
                title: '13. When to use Tooltip vs Snackbar vs Banner',
                subtitle: 'Three different transient surfaces. Pick by '
                    'urgency and semantics, not by visual preference.',
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                color: const Color(0xFFFCE4EC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _DecisionRow(
                        accent: const Color(0xFFAD1457),
                        title: 'Tooltip',
                        when: 'On-demand context for a single widget.',
                        why: 'Triggered by user gesture (hover/long-press/'
                            'tap). Disappears on its own. No interaction.',
                      ),
                      const SizedBox(height: 10),
                      _DecisionRow(
                        accent: const Color(0xFF6A1B9A),
                        title: 'SnackBar',
                        when: 'Confirm an action just took effect.',
                        why: 'Bottom strip with optional action button. '
                            'Self-dismissing. One at a time.',
                      ),
                      const SizedBox(height: 10),
                      _DecisionRow(
                        accent: const Color(0xFFEF6C00),
                        title: 'MaterialBanner',
                        when: 'Persistent, important message that needs a '
                            'response.',
                        why: 'Sticks until the user dismisses it. Used for '
                            'errors, sign-in prompts, capability nags.',
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: const Text(
                          'Rule of thumb: if the user does NOT need to act, '
                          'and the info is widget-specific, use a Tooltip. '
                          'Tooltips are read by screen readers via the '
                          'wrapped child\'s Semantics, so they double as '
                          'accessibility labels for icon-only buttons.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 14 - REFERENCE CARD
              // -------------------------------------------------------------------
              // Final reference table summarising every Tooltip parameter
              // touched in the demo plus a one-liner default.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF263238),
                title: '14. Reference card',
                subtitle: 'Tooltip parameters at a glance.',
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                color: const Color(0xFFECEFF1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: const [
                            _RefHeader(),
                            _RefRow(
                              name: 'message',
                              defaultValue: '-',
                              note:
                                  'Plain string body. Mutually exclusive with '
                                  'richMessage.',
                            ),
                            _RefRow(
                              name: 'richMessage',
                              defaultValue: '-',
                              note: 'InlineSpan body for mixed-style content.',
                            ),
                            _RefRow(
                              name: 'triggerMode',
                              defaultValue: 'longPress (mobile) / hover',
                              note: 'tap, longPress, manual.',
                            ),
                            _RefRow(
                              name: 'waitDuration',
                              defaultValue: '0 ms',
                              note: 'Hover delay before showing.',
                            ),
                            _RefRow(
                              name: 'showDuration',
                              defaultValue: '~1.5 s',
                              note: 'How long the tooltip lingers after the '
                                  'gesture ends.',
                            ),
                            _RefRow(
                              name: 'preferBelow',
                              defaultValue: 'true',
                              note: 'Show the tooltip below the child by '
                                  'default.',
                            ),
                            _RefRow(
                              name: 'verticalOffset',
                              defaultValue: '24 px',
                              note:
                                  'Distance between the child and the tooltip.',
                            ),
                            _RefRow(
                              name: 'padding',
                              defaultValue: 'EdgeInsets.symmetric(h:16,v:4)',
                              note: 'Inner padding of the tooltip body.',
                            ),
                            _RefRow(
                              name: 'enableTapToDismiss',
                              defaultValue: 'true',
                              note: 'Whether tapping anywhere dismisses the '
                                  'tooltip.',
                            ),
                            _RefRow(
                              name: 'excludeFromSemantics',
                              defaultValue: 'false',
                              note: 'Set true to opt out of screen-reader '
                                  'announcement.',
                            ),
                            _RefRow(
                              name: 'onTriggered',
                              defaultValue: 'null',
                              note: 'Callback fired every time the tooltip '
                                  'is shown.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Accessibility note: by default the tooltip\'s '
                        'message is announced by screen readers as the '
                        'wrapped child\'s semantic label. Set '
                        'excludeFromSemantics: true only when the message '
                        'duplicates an existing announcement.',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // -------------------------------------------------------------------
              // FOOTER
              // -------------------------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    'TooltipState - hand-rolled deep demo',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.45),
                      fontStyle: FontStyle.italic,
                    ),
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

// ---------------------------------------------------------------------------
// Below: helper widgets and free functions used by the sections above. They
// live below build() so the top-of-file flow reads as a single demo script.
// ---------------------------------------------------------------------------

String _modeExplanation(TooltipTriggerMode mode) {
  switch (mode) {
    case TooltipTriggerMode.tap:
      return 'tap: a single tap on the child shows the tooltip. The child '
          'can still receive taps for its own onPressed handlers (the '
          'tooltip listens via Listener and does not consume the event).';
    case TooltipTriggerMode.longPress:
      return 'longPress: the user has to hold the child for ~500 ms before '
          'the tooltip appears. This is the default on mobile platforms.';
    case TooltipTriggerMode.manual:
      return 'manual: native gestures do nothing - only ensureTooltipVisible() '
          'will show the tooltip. This is the mode you pair with '
          'GlobalKey<TooltipState> when a tooltip is purely controlled by '
          'app logic (tutorials, validation, focus events).';
  }
}

Widget _heroBullet({required String token, required String body}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          token,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          body,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.accent,
    required this.title,
    required this.subtitle,
  });

  final Color accent;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 44,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 helper: a basic tooltip tile with a title, description and the
// actual Tooltip-wrapped widget.
// ---------------------------------------------------------------------------
class _BasicTooltipTile extends StatelessWidget {
  const _BasicTooltipTile({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2E7D32).withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF2E7D32),
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 14),
            Center(child: child),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 helper: one row of the programmatic-show recipe. Lays out the
// label, description, the tooltip-wrapped widget, an external trigger button,
// and the "shown N times" counter.
// ---------------------------------------------------------------------------
class _ProgrammaticRow extends StatelessWidget {
  const _ProgrammaticRow({
    required this.accent,
    required this.label,
    required this.description,
    required this.count,
    required this.tooltip,
    required this.onShow,
  });

  final Color accent;
  final String label;
  final String description;
  final int count;
  final Widget tooltip;
  final VoidCallback onShow;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: accent,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  tooltip,
                  const SizedBox(width: 18),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.visibility),
                    label: Text('Show $label'),
                    onPressed: onShow,
                  ),
                  const SizedBox(width: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      'shown: $count',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Sections 5 & 6 helper: a labelled Slider with caption and value pill. We
// reuse it for both Duration sliders and pixel sliders (just override unit).
// ---------------------------------------------------------------------------
class _DurationSlider extends StatelessWidget {
  const _DurationSlider({
    required this.label,
    required this.valueMs,
    required this.min,
    required this.max,
    required this.accent,
    required this.onChanged,
    required this.description,
    this.unit = 'ms',
  });

  final String label;
  final double valueMs;
  final double min;
  final double max;
  final Color accent;
  final ValueChanged<double> onChanged;
  final String description;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: accent,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                '${valueMs.toInt()} $unit',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: valueMs,
          min: min,
          max: max,
          activeColor: accent,
          onChanged: onChanged,
        ),
        Text(
          description,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 helper: a chip-shaped child for the themed wall of buttons.
// Visual styling is dark on light-green so the themed tooltip reads well.
// ---------------------------------------------------------------------------
class _ThemedChip extends StatelessWidget {
  const _ThemedChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1B5E20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF1B5E20), size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1B5E20),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9 helper: a small icon+label pill used in the TooltipVisibility
// rows. Coloured to match the row's accent.
// ---------------------------------------------------------------------------
class _PillIcon extends StatelessWidget {
  const _PillIcon({
    required this.icon,
    required this.label,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: accent, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 11 - focus-triggered help icon recipe. Stateful so it can own its
// FocusNodes and GlobalKey<TooltipState> instances.
// ---------------------------------------------------------------------------
class _FocusHelpRecipe extends StatefulWidget {
  const _FocusHelpRecipe({
    required this.accent,
    required this.onTrigger,
  });

  final Color accent;
  final ValueChanged<String> onTrigger;

  @override
  State<_FocusHelpRecipe> createState() => _FocusHelpRecipeState();
}

class _FocusHelpRecipeState extends State<_FocusHelpRecipe> {
  late final FocusNode nameFocus;
  late final FocusNode emailFocus;
  late final FocusNode passwordFocus;
  final GlobalKey<TooltipState> nameTip = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> emailTip = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> passwordTip = GlobalKey<TooltipState>();

  @override
  void initState() {
    super.initState();
    nameFocus = FocusNode()..addListener(_onNameFocus);
    emailFocus = FocusNode()..addListener(_onEmailFocus);
    passwordFocus = FocusNode()..addListener(_onPasswordFocus);
  }

  void _onNameFocus() {
    if (nameFocus.hasFocus) {
      nameTip.currentState?.ensureTooltipVisible();
      widget.onTrigger('name');
    }
  }

  void _onEmailFocus() {
    if (emailFocus.hasFocus) {
      emailTip.currentState?.ensureTooltipVisible();
      widget.onTrigger('email');
    }
  }

  void _onPasswordFocus() {
    if (passwordFocus.hasFocus) {
      passwordTip.currentState?.ensureTooltipVisible();
      widget.onTrigger('password');
    }
  }

  @override
  void dispose() {
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  Widget _row({
    required String label,
    required String hint,
    required FocusNode focus,
    required GlobalKey<TooltipState> tipKey,
    required String tipMessage,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: widget.accent,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: focus,
              decoration: InputDecoration(
                hintText: hint,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Tooltip(
            key: tipKey,
            message: tipMessage,
            triggerMode: TooltipTriggerMode.tap,
            preferBelow: false,
            onTriggered: () => widget.onTrigger('$label-tip'),
            child: Icon(
              Icons.help_outline,
              color: widget.accent,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color(0xFFE3F2FD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account form',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: widget.accent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Click into a field to focus it. The corresponding help '
              'tooltip beside the field opens automatically.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 6),
            _row(
              label: 'Full name',
              hint: 'Jane Smith',
              focus: nameFocus,
              tipKey: nameTip,
              tipMessage:
                  'Use the name on your government-issued ID for KYC '
                  'verification.',
            ),
            _row(
              label: 'Email',
              hint: 'jane@example.com',
              focus: emailFocus,
              tipKey: emailTip,
              tipMessage:
                  'We send a verification link here. Make sure you can '
                  'access this inbox.',
            ),
            _row(
              label: 'Password',
              hint: '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
              focus: passwordFocus,
              tipKey: passwordTip,
              tipMessage:
                  'At least 12 characters, with one digit and one symbol. '
                  'Use a passphrase if you can.',
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: const Text(
                'Why programmatic? Hover does not exist on touch devices, so '
                'a help icon driven by FocusNode + ensureTooltipVisible() is '
                'an accessible way to surface field guidance.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
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
// Section 12 - truncated table cell recipe. Each row owns its own Tooltip
// key so we can demonstrate one-row-at-a-time programmatic open.
// ---------------------------------------------------------------------------
class _TruncationRecipe extends StatefulWidget {
  const _TruncationRecipe({
    required this.accent,
    required this.onTrigger,
  });

  final Color accent;
  final ValueChanged<String> onTrigger;

  @override
  State<_TruncationRecipe> createState() => _TruncationRecipeState();
}

class _TruncationRecipeState extends State<_TruncationRecipe> {
  static const _rows = <_TableRow>[
    _TableRow(
      id: 'evt-001',
      url: 'https://api.example.com/v1/events/8a91c5fb-2e3f-4c2a-bd2f-feed/'
          'verbose-payload?since=2026-04-01T00:00:00Z&limit=500',
    ),
    _TableRow(
      id: 'evt-002',
      url: 'https://billing.example.com/invoices/2026/april/'
          'org-12345/cycle-renewal/full-text-summary.pdf',
    ),
    _TableRow(
      id: 'evt-003',
      url: 'https://logs.example.com/search?q=error&from=2026-04-29T00:00:00Z'
          '&to=2026-05-02T00:00:00Z&service=tooltip-state-demo',
    ),
  ];

  late final Map<String, GlobalKey<TooltipState>> _keys;

  @override
  void initState() {
    super.initState();
    _keys = {
      for (final row in _rows) row.id: GlobalKey<TooltipState>(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color(0xFFE0F2F1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent webhook events',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: widget.accent,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: widget.accent.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: Text(
                            'ID',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: widget.accent,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'URL (truncated)',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: widget.accent,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            'Peek',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: widget.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (final row in _rows)
                    _row(row, _keys[row.id]!),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The truncated cell wraps a Text in a Tooltip whose message '
              'is the full URL. The peek button calls '
              'ensureTooltipVisible() on the row\'s key so users on '
              'touch-only devices can see the URL without a long-press.',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(_TableRow row, GlobalKey<TooltipState> key) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              row.id,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Tooltip(
              key: key,
              message: row.url,
              triggerMode: TooltipTriggerMode.tap,
              preferBelow: false,
              waitDuration: const Duration(milliseconds: 200),
              onTriggered: () => widget.onTrigger(row.id),
              child: Text(
                row.url,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Color(0xFF00695C),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.zoom_in,
                  color: widget.accent,
                ),
                tooltip: 'Show full URL',
                onPressed: () {
                  key.currentState?.ensureTooltipVisible();
                  widget.onTrigger('${row.id}.peek');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableRow {
  const _TableRow({required this.id, required this.url});
  final String id;
  final String url;
}

// ---------------------------------------------------------------------------
// Section 13 helper: a single decision-card row.
// ---------------------------------------------------------------------------
class _DecisionRow extends StatelessWidget {
  const _DecisionRow({
    required this.accent,
    required this.title,
    required this.when,
    required this.why,
  });

  final Color accent;
  final String title;
  final String when;
  final String why;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 60,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: accent,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Use when: $when',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  why,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
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
// Section 14 helpers: header and data rows for the reference table.
// ---------------------------------------------------------------------------
class _RefHeader extends StatelessWidget {
  const _RefHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFCFD8DC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: const [
          SizedBox(
            width: 160,
            child: Text(
              'Parameter',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              'Default',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(
              'Note',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefRow extends StatelessWidget {
  const _RefRow({
    required this.name,
    required this.defaultValue,
    required this.note,
  });

  final String name;
  final String defaultValue;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              defaultValue,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(child: Text(note)),
        ],
      ),
    );
  }
}
