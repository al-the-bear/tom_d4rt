// ignore_for_file: avoid_print
// D4rt deep demo: LiveTextInputStatusNotifier — async notifier for Live Text availability
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Tawny / Copper ────────────────────────────────────────
  const darkTawny = Color(0xFF5D3A1A);
  const burnishedCopper = Color(0xFF7B4B2A);
  const warmBronze = Color(0xFF96603A);
  const caramel = Color(0xFFB07D4F);
  const honeyTan = Color(0xFFC9976B);
  const sandBeige = Color(0xFFDEB887);
  const paleHoney = Color(0xFFEED9BE);
  const creamIvory = Color(0xFFFFF5E6);
  const alertCrimson = Color(0xFFC62828);
  const activeGreen = Color(0xFF2E7D32);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
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
                  color: fg,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text, style: TextStyle(fontSize: 13, color: darkTawny)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkTawny)),
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  Widget apiCard(String name, String returns, String desc, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: creamIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: darkTawny,
                        fontFamily: 'monospace')),
              ),
              tag(returns, accent.withValues(alpha: 0.15), accent),
            ],
          ),
          const SizedBox(height: 4),
          Text(desc, style: TextStyle(fontSize: 12, color: burnishedCopper)),
        ],
      ),
    );
  }

  Widget flowStep(int number, String title, String detail, Color bg) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: darkTawny,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text('$number',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: darkTawny)),
                const SizedBox(height: 2),
                Text(detail,
                    style: TextStyle(fontSize: 12, color: burnishedCopper)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statusIndicator(String label, LiveTextInputStatus status, Color bg) {
    final statusColor = status == LiveTextInputStatus.enabled
        ? activeGreen
        : status == LiveTextInputStatus.disabled
            ? alertCrimson
            : caramel;
    final icon = status == LiveTextInputStatus.enabled
        ? Icons.check_circle
        : status == LiveTextInputStatus.disabled
            ? Icons.cancel
            : Icons.help_outline;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: statusColor, width: 3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: statusColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: darkTawny)),
          ),
          tag(status.name, statusColor.withValues(alpha: 0.12), statusColor),
        ],
      ),
    );
  }

  // ── Create notifiers and gather data ───────────────────────────────
  print('LiveTextInputStatusNotifier deep demo executing');
  print('=' * 60);

  // Section 1 — what is it
  print('\n--- What is LiveTextInputStatusNotifier ---');
  print('A ValueNotifier that tracks Live Text input availability');
  print('Monitors platform capability for camera-based text OCR');
  print('Observes app lifecycle to re-check on resume');

  // Section 2 — creation
  final defaultNotifier = LiveTextInputStatusNotifier();
  print('\n--- Default creation ---');
  print('Default notifier value: ${defaultNotifier.value}');
  print('runtimeType: ${defaultNotifier.runtimeType}');

  // Section 3 — with initial values
  final enabledNotifier = LiveTextInputStatusNotifier(
    value: LiveTextInputStatus.enabled,
  );
  final disabledNotifier = LiveTextInputStatusNotifier(
    value: LiveTextInputStatus.disabled,
  );
  print('\n--- Initial values ---');
  print('Enabled notifier: ${enabledNotifier.value}');
  print('Disabled notifier: ${disabledNotifier.value}');

  // Section 4 — inheritance
  print('\n--- Inheritance ---');
  print('runtimeType: ${defaultNotifier.runtimeType}');
  print('Extends ValueNotifier<LiveTextInputStatus>');
  print('Extends ChangeNotifier, Listenable');

  // Section 5 — listener tracking
  var listenerCallCount = 0;
  void listener() {
    listenerCallCount++;
    print('  Listener called #$listenerCallCount');
  }
  defaultNotifier.addListener(listener);
  print('\n--- Listener added ---');
  print('Listener registered');

  // Section 6 — value changes
  defaultNotifier.value = LiveTextInputStatus.enabled;
  print('\n--- Value changed to enabled ---');
  print('Listener call count: $listenerCallCount');

  defaultNotifier.value = LiveTextInputStatus.disabled;
  print('Value changed to disabled');
  print('Listener call count: $listenerCallCount');

  // Section 7 — lifecycle states
  print('\n--- App lifecycle states ---');
  for (final state in AppLifecycleState.values) {
    print('  ${state.name}: ${state == AppLifecycleState.resumed ? "triggers update()" : "no action"}');
  }

  // Section 8 — cleanup
  defaultNotifier.removeListener(listener);
  print('\n--- Listener removed ---');
  print('Final listener call count: $listenerCallCount');

  // Dispose all
  defaultNotifier.dispose();
  enabledNotifier.dispose();
  disabledNotifier.dispose();
  print('All notifiers disposed');

  print('\n${'=' * 60}');
  print('LiveTextInputStatusNotifier deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [darkTawny, burnishedCopper, warmBronze],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LiveTextInputStatusNotifier',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                  'Async notifier for platform Live Text input availability',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('ValueNotifier', warmBronze, Colors.white),
                tag('Lifecycle', caramel, darkTawny),
                tag('Platform', honeyTan, darkTawny),
                tag('OCR', sandBeige, darkTawny),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner(
            '1 \u00b7 What Is LiveTextInputStatusNotifier',
            'A ValueNotifier that monitors Live Text capability',
            darkTawny,
            Colors.white),
        noteBox(
          'LiveTextInputStatusNotifier is a ValueNotifier<LiveTextInputStatus> '
          'that tracks whether the device supports Live Text input — the '
          'iOS feature that uses the camera to scan and insert text. It '
          'automatically observes the app lifecycle and re-checks '
          'availability when the app resumes from the background.',
          darkTawny,
          creamIvory,
        ),
        dataRow('Extends', 'ValueNotifier<LiveTextInputStatus>', burnishedCopper),
        dataRow('Implements', 'WidgetsBindingObserver', warmBronze),
        dataRow('Purpose', 'Track Live Text OCR availability', caramel),
        dataRow('Platform', 'Primarily iOS 15+', honeyTan),
        const SizedBox(height: 14),

        // ── 3. Creation with initial values ──────────────────────────
        sectionBanner(
            '2 \u00b7 Creation — Three Starting States',
            'Default, enabled, or disabled initial value',
            burnishedCopper,
            Colors.white),
        statusIndicator(
            'Default (unknown) — status not yet checked', LiveTextInputStatus.unknown, creamIvory),
        statusIndicator(
            'Enabled — Live Text confirmed available', LiveTextInputStatus.enabled, creamIvory),
        statusIndicator(
            'Disabled — Live Text not available', LiveTextInputStatus.disabled, creamIvory),
        noteBox(
          'The default initial value is LiveTextInputStatus.unknown. The '
          'notifier then calls update() asynchronously to determine the '
          'actual status. In testing or when the status is already known, '
          'you can pass the initial value directly.',
          burnishedCopper,
          paleHoney,
        ),
        const SizedBox(height: 14),

        // ── 4. API surface ───────────────────────────────────────────
        sectionBanner('3 \u00b7 API Surface',
            'Methods and properties specific to this notifier',
            warmBronze, Colors.white),
        apiCard(
          'value',
          'LiveTextInputStatus',
          'The current Live Text availability status. Changes trigger '
          'listeners. Can be unknown, enabled, or disabled.',
          darkTawny,
        ),
        apiCard(
          'update()',
          'Future<void>',
          'Asynchronously checks LiveText.isLiveTextInputAvailable() and '
          'updates the value. Called automatically on creation and when '
          'the app resumes from the background.',
          burnishedCopper,
        ),
        apiCard(
          'addListener(listener)',
          'void',
          'Adds a listener that is called when the status changes. The '
          'first listener also registers this notifier as a '
          'WidgetsBindingObserver for lifecycle events.',
          warmBronze,
        ),
        apiCard(
          'removeListener(listener)',
          'void',
          'Removes a listener. When the last listener is removed, the '
          'notifier unregisters as a WidgetsBindingObserver.',
          caramel,
        ),
        apiCard(
          'didChangeAppLifecycleState(state)',
          'void',
          'Called by the framework when the app lifecycle changes. Only '
          'AppLifecycleState.resumed triggers a re-check via update().',
          honeyTan,
        ),
        apiCard(
          'dispose()',
          'void',
          'Cleans up resources, removes the lifecycle observer, and '
          'disposes the underlying ChangeNotifier.',
          darkTawny,
        ),
        const SizedBox(height: 14),

        // ── 5. Observer pattern ──────────────────────────────────────
        sectionBanner('4 \u00b7 The Observer Pattern',
            'How the notifier watches the app lifecycle',
            darkTawny, Colors.white),
        noteBox(
          'LiveTextInputStatusNotifier implements WidgetsBindingObserver. '
          'When the first listener is added, it registers itself with '
          'WidgetsBinding.instance to receive lifecycle callbacks. When '
          'the last listener is removed, it unregisters. This lazy '
          'registration avoids unnecessary overhead when unused.',
          darkTawny,
          creamIvory,
        ),
        flowStep(1, 'First addListener() call',
            'Registers as WidgetsBindingObserver', creamIvory),
        flowStep(2, 'App goes to background',
            'didChangeAppLifecycleState(paused) — no action', paleHoney),
        flowStep(3, 'App resumes',
            'didChangeAppLifecycleState(resumed) → update()', creamIvory),
        flowStep(4, 'update() checks platform',
            'LiveText.isLiveTextInputAvailable()', paleHoney),
        flowStep(5, 'Value updated',
            'Notifies all listeners of new status', creamIvory),
        flowStep(6, 'Last removeListener()',
            'Unregisters as WidgetsBindingObserver', paleHoney),
        const SizedBox(height: 14),

        // ── 6. Lifecycle state handling ──────────────────────────────
        sectionBanner('5 \u00b7 App Lifecycle Response',
            'Which states trigger a re-check',
            burnishedCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamIvory,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final state in AppLifecycleState.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 110,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: state == AppLifecycleState.resumed
                              ? activeGreen.withValues(alpha: 0.12)
                              : Colors.grey.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: state == AppLifecycleState.resumed
                                ? activeGreen
                                : Colors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(state.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: state == AppLifecycleState.resumed
                                    ? activeGreen
                                    : darkTawny)),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        state == AppLifecycleState.resumed
                            ? Icons.refresh
                            : Icons.remove_circle_outline,
                        size: 18,
                        color: state == AppLifecycleState.resumed
                            ? activeGreen
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state == AppLifecycleState.resumed
                              ? 'Calls update() → re-checks platform'
                              : 'No action taken',
                          style: TextStyle(
                              fontSize: 12,
                              color: state == AppLifecycleState.resumed
                                  ? activeGreen
                                  : Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Listener lifecycle dashboard ──────────────────────────
        sectionBanner('6 \u00b7 Listener Lifecycle Dashboard',
            'Visualizing listener count and observer state',
            warmBronze, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamIvory,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('0 listeners', 'Not registered', Icons.visibility_off, false),
                ('1st addListener', 'Registers observer', Icons.visibility, true),
                ('2nd addListener', 'Already registered', Icons.visibility, true),
                ('1st removeListener', 'Still registered', Icons.visibility, true),
                ('Last removeListener', 'Unregisters', Icons.visibility_off, false),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: scenario.$4 ? paleHoney : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(scenario.$3,
                          size: 20,
                          color: scenario.$4 ? darkTawny : Colors.grey),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 120,
                        child: Text(scenario.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: darkTawny)),
                      ),
                      Expanded(
                        child: Text(scenario.$2,
                            style: TextStyle(
                                fontSize: 12,
                                color: scenario.$4
                                    ? burnishedCopper
                                    : Colors.grey.shade600)),
                      ),
                      Container(
                        width: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: scenario.$4
                              ? activeGreen.withValues(alpha: 0.12)
                              : alertCrimson.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          scenario.$4 ? 'ACTIVE' : 'IDLE',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: scenario.$4
                                  ? activeGreen
                                  : alertCrimson),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Value change visualization ────────────────────────────
        sectionBanner('7 \u00b7 Value Transitions',
            'How the notifier value changes over time',
            darkTawny, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamIvory,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final transition in [
                ('Created', 'unknown', caramel, '\u2192'),
                ('update() completes', 'enabled', activeGreen, '\u2192'),
                ('App paused', 'enabled', activeGreen, '\u2022'),
                ('App resumed', 'enabled', activeGreen, '\u2192'),
                ('Device changes', 'disabled', alertCrimson, '\u2192'),
                ('App resumed again', 'disabled', alertCrimson, '\u2022'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Text(transition.$4,
                          style: TextStyle(
                              fontSize: 16, color: transition.$3)),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 140,
                        child: Text(transition.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: darkTawny)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: transition.$3.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: transition.$3.withValues(alpha: 0.3)),
                        ),
                        child: Text(transition.$2,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: transition.$3)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. ValueListenableBuilder integration ────────────────────
        sectionBanner('8 \u00b7 ValueListenableBuilder Pattern',
            'Reactive UI that responds to status changes',
            burnishedCopper, Colors.white),
        noteBox(
          'Since LiveTextInputStatusNotifier extends ValueNotifier, it '
          'works perfectly with ValueListenableBuilder. This allows your '
          'UI to reactively show/hide the Live Text button based on '
          'platform availability — no manual listener management needed.',
          burnishedCopper,
          creamIvory,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: paleHoney,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: sandBeige),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Simulated Live Text Button States:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: darkTawny)),
              const SizedBox(height: 12),
              for (final state in LiveTextInputStatus.values)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: state == LiveTextInputStatus.enabled
                              ? activeGreen.withValues(alpha: 0.1)
                              : Colors.grey.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          state == LiveTextInputStatus.enabled
                              ? Icons.camera_alt
                              : state == LiveTextInputStatus.disabled
                                  ? Icons.camera_alt
                                  : Icons.hourglass_empty,
                          size: 22,
                          color: state == LiveTextInputStatus.enabled
                              ? activeGreen
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status: ${state.name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: darkTawny)),
                            Text(
                              state == LiveTextInputStatus.enabled
                                  ? 'Show Live Text button in text field'
                                  : state == LiveTextInputStatus.disabled
                                      ? 'Hide Live Text button'
                                      : 'Show loading/placeholder',
                              style: TextStyle(
                                  fontSize: 12, color: burnishedCopper),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: state == LiveTextInputStatus.enabled
                              ? activeGreen
                              : state == LiveTextInputStatus.disabled
                                  ? alertCrimson
                                  : caramel,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          state == LiveTextInputStatus.enabled
                              ? 'VISIBLE'
                              : state == LiveTextInputStatus.disabled
                                  ? 'HIDDEN'
                                  : 'PENDING',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. TextField integration ────────────────────────────────
        sectionBanner('9 \u00b7 Real-World: TextField Integration',
            'How text fields use Live Text status',
            warmBronze, Colors.white),
        noteBox(
          'Flutter\'s TextField and CupertinoTextField check the Live Text '
          'status to decide whether to show a camera icon in the toolbar. '
          'The notifier is typically created once (singleton pattern) and '
          'shared across all text fields in the app.',
          warmBronze,
          creamIvory,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: creamIvory,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: sandBeige),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Enter text...',
                          style: TextStyle(
                              color: Colors.grey.shade400, fontSize: 15)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: activeGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(Icons.camera_alt,
                          size: 18, color: activeGreen),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.arrow_upward, size: 14, color: burnishedCopper),
                  const SizedBox(width: 4),
                  Text('Camera icon shown when Live Text is enabled',
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: burnishedCopper)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Comparison with other notifiers ──────────────────────
        sectionBanner('10 \u00b7 Comparison with Other Notifiers',
            'How it fits in the ValueNotifier family',
            darkTawny, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamIvory,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: darkTawny),
                children: [
                  for (final h in ['Notifier', 'Value Type', 'Lifecycle', 'Async'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('LiveTextInputStatus\nNotifier', 'LiveText\nInputStatus', 'Yes', 'Yes'),
                ('ValueNotifier<T>', 'T', 'No', 'No'),
                ('TextEditingController', 'TextEditing\nValue', 'No', 'No'),
                ('ScrollController', 'double', 'No', 'No'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: darkTawny)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(fontSize: 10, color: burnishedCopper)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10,
                              color: row.$3 == 'Yes'
                                  ? activeGreen
                                  : Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$4,
                          style: TextStyle(
                              fontSize: 10,
                              color: row.$4 == 'Yes'
                                  ? activeGreen
                                  : Colors.grey)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Platform specifics ───────────────────────────────────
        sectionBanner('11 \u00b7 Platform Behavior',
            'How Live Text works across platforms',
            burnishedCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamIvory,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (final platform in [
                ('iOS 15+', Icons.phone_iphone, 'Full Live Text support', activeGreen),
                ('iPadOS 15+', Icons.tablet_mac, 'Full Live Text support', activeGreen),
                ('macOS 12+', Icons.laptop_mac, 'Partial support (camera-based)', caramel),
                ('Android', Icons.phone_android, 'Not supported — always disabled', alertCrimson),
                ('Web', Icons.language, 'Not supported — always disabled', alertCrimson),
                ('Windows', Icons.desktop_windows, 'Not supported — always disabled', alertCrimson),
                ('Linux', Icons.computer, 'Not supported — always disabled', alertCrimson),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Icon(platform.$2, size: 18, color: platform.$4),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 90,
                        child: Text(platform.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: darkTawny)),
                      ),
                      Expanded(
                        child: Text(platform.$3,
                            style: TextStyle(
                                fontSize: 12, color: platform.$4)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Inheritance hierarchy ────────────────────────────────
        sectionBanner('12 \u00b7 Inheritance Hierarchy',
            'Class relationships', caramel, darkTawny),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamIvory,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                'Object',
                '  \u2514\u2500 ChangeNotifier',
                '       \u2514\u2500 ValueNotifier<LiveTextInputStatus>',
                '            \u2514\u2500 LiveTextInputStatusNotifier  \u2605',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: line.contains('\u2605')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: line.contains('\u2605')
                              ? darkTawny
                              : warmBronze)),
                ),
            ],
          ),
        ),
        noteBox(
          'Also implements: WidgetsBindingObserver (for lifecycle events)',
          caramel,
          paleHoney,
        ),
        const SizedBox(height: 14),

        // ── 14. Dispose sequence ─────────────────────────────────────
        sectionBanner('13 \u00b7 Dispose Sequence',
            'Clean shutdown order', warmBronze, Colors.white),
        flowStep(1, 'Remove lifecycle observer',
            'Unregisters from WidgetsBinding', creamIvory),
        flowStep(2, 'Clear listeners',
            'All registered listeners are removed', paleHoney),
        flowStep(3, 'Super.dispose()',
            'ValueNotifier cleanup runs', creamIvory),
        flowStep(4, 'Ready for GC',
            'No references held, safe for garbage collection', paleHoney),
        noteBox(
          'Always dispose the notifier when the widget that owns it is '
          'disposed. Failing to dispose leaks the WidgetsBindingObserver '
          'registration and prevents garbage collection.',
          alertCrimson,
          const Color(0xFFFCE4EC),
        ),
        const SizedBox(height: 14),

        // ── 15. Common patterns ──────────────────────────────────────
        sectionBanner('14 \u00b7 Common Patterns',
            'Best practices for using this notifier',
            darkTawny, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamIvory,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final pattern in [
                ('Singleton', 'Create once in app state, share across fields'),
                ('Conditional UI', 'Show/hide camera button based on value'),
                ('Late init', 'Create in initState, dispose in dispose'),
                ('Builder', 'Use ValueListenableBuilder for reactive updates'),
                ('Fallback', 'Default to disabled on non-iOS platforms'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 90,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: darkTawny.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(pattern.$1,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: darkTawny)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(pattern.$2,
                            style: TextStyle(
                                fontSize: 12, color: burnishedCopper)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', darkTawny, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [darkTawny, burnishedCopper],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'ValueNotifier<LiveTextInputStatus> for camera OCR tracking',
                'Observes app lifecycle — re-checks on resume',
                'Lazy registration: first listener activates observer',
                'Last listener removal deactivates observer',
                'Three states: unknown, enabled, disabled',
                'Works with ValueListenableBuilder for reactive UI',
                'Primarily iOS 15+ — disabled on all other platforms',
                'Must be disposed to prevent lifecycle observer leaks',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: sandBeige,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
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
