// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
//  MaterialBannerClosedReason — exhaustive demo
// ----------------------------------------------------------------------------
//  This file is a hand-rolled "deep demo" exercising every value of the
//  MaterialBannerClosedReason enum together with the live ScaffoldMessenger
//  APIs that emit it.
//
//  Each section below is fully self-contained: a hero card, per-value frozen
//  frames, a live trigger panel, action mapping, a history log, a stacked
//  queue stress demo, three realistic banner recipes, and a reference table.
// ============================================================================

dynamic build(BuildContext context) {
  print('=== MaterialBannerClosedReason Deep Demo ===');
  for (final reason in MaterialBannerClosedReason.values) {
    print('  enum[${reason.index}] -> ${reason.name}');
  }

  // --------------------------------------------------------------------------
  // Shared state for the live trigger panel.
  // We use a plain instance (not in a State) — the StatefulBuilder closures
  // hold references and call setState when the dismissal Futures resolve.
  // --------------------------------------------------------------------------
  final ValueNotifier<List<_LoggedReason>> historyLog =
      ValueNotifier<List<_LoggedReason>>(<_LoggedReason>[]);

  final ValueNotifier<int> queueLength = ValueNotifier<int>(0);
  final ValueNotifier<MaterialBannerClosedReason?> lastReason =
      ValueNotifier<MaterialBannerClosedReason?>(null);

  // Mapping each enum value to a colour for chips/cards across the demo.
  Color colourForReason(MaterialBannerClosedReason r) {
    switch (r) {
      case MaterialBannerClosedReason.dismiss:
        return const Color(0xFF1976D2);
      case MaterialBannerClosedReason.swipe:
        return const Color(0xFFEF6C00);
      case MaterialBannerClosedReason.hide:
        return const Color(0xFF6A1B9A);
      case MaterialBannerClosedReason.remove:
        return const Color(0xFFC62828);
    }
  }

  String descriptionForReason(MaterialBannerClosedReason r) {
    switch (r) {
      case MaterialBannerClosedReason.dismiss:
        return 'User tapped a dismissive action on the banner.';
      case MaterialBannerClosedReason.swipe:
        return 'Deprecated alias of dismiss; banners do not currently '
            'support swipe-to-dismiss but the value remains in the enum.';
      case MaterialBannerClosedReason.hide:
        return 'Banner was hidden via hideCurrentMaterialBanner().';
      case MaterialBannerClosedReason.remove:
        return 'Banner was removed via removeCurrentMaterialBanner() — '
            'usually because a queued banner pre-empts it.';
    }
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MaterialBannerClosedReason Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        title: const Text('MaterialBannerClosedReason'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // SECTION 1 — HERO CARD: enum overview & lifecycle states
              // ============================================================
              _heroCard(),
              const SizedBox(height: 24),

              // ============================================================
              // SECTION 2 — PER-VALUE FROZEN FRAMES
              // ============================================================
              _perValueFrozenFrames(colourForReason, descriptionForReason),
              const SizedBox(height: 24),

              // ============================================================
              // SECTION 3 — LIVE TRIGGER PANEL
              // ============================================================
              _liveTriggerPanel(
                historyLog: historyLog,
                queueLength: queueLength,
                lastReason: lastReason,
                colourForReason: colourForReason,
              ),
              const SizedBox(height: 24),

              // ============================================================
              // SECTION 4 — ACTION BUTTON MAPPING
              // ============================================================
              _actionMappingPanel(
                historyLog: historyLog,
                colourForReason: colourForReason,
              ),
              const SizedBox(height: 24),

              // ============================================================
              // SECTION 5 — REASON HISTORY LOG
              // ============================================================
              _historyLogPanel(
                historyLog: historyLog,
                colourForReason: colourForReason,
              ),
              const SizedBox(height: 24),

              // ============================================================
              // SECTION 6 — STACKED BANNER QUEUE
              // ============================================================
              _queuePanel(
                historyLog: historyLog,
                queueLength: queueLength,
                colourForReason: colourForReason,
              ),
              const SizedBox(height: 24),

              // ============================================================
              // SECTION 7 — REALISTIC RECIPES
              // ============================================================
              _realisticRecipesPanel(
                historyLog: historyLog,
                colourForReason: colourForReason,
              ),
              const SizedBox(height: 24),

              // ============================================================
              // SECTION 8 — REFERENCE CARD: enum value table
              // ============================================================
              _referenceCard(colourForReason, descriptionForReason),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// Helper class: a single entry in the dismissal history log.
// ============================================================================
class _LoggedReason {
  _LoggedReason(this.reason, this.label, this.at);
  final MaterialBannerClosedReason reason;
  final String label;
  final DateTime at;
}

// ============================================================================
// SECTION 1 — HERO CARD
// ============================================================================
Widget _heroCard() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF42A5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x331976D2),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 1 — MaterialBannerClosedReason',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The enum reported when a MaterialBanner is dismissed. '
          'Returned via the Future from showMaterialBanner(). '
          'Six values cover every closure path: dismiss, swipe (deprecated '
          'alias of dismiss), hide, remove, timeout, internal.',
          style: TextStyle(color: Colors.white, height: 1.4, fontSize: 14),
        ),
        const SizedBox(height: 20),
        // Three painted lifecycle "states".
        Row(
          children: [
            Expanded(child: _lifecycleState('Visible', 0xFF4CAF50, true)),
            const SizedBox(width: 8),
            Expanded(child: _lifecycleState('Dismissing', 0xFFFFB300, false)),
            const SizedBox(width: 8),
            Expanded(child: _lifecycleState('Closed', 0xFFE53935, false)),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Lifecycle: a banner is shown, becomes visible, then is dismissed '
          'via one of the closed reasons. The Future returned from '
          'showMaterialBanner() completes with a MaterialBannerClosedReason.',
          style: TextStyle(
            color: Color(0xFFE3F2FD),
            fontStyle: FontStyle.italic,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleState(String label, int colorValue, bool emphasised) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(emphasised ? 0.25 : 0.12),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white.withOpacity(0.4)),
    ),
    child: Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Color(colorValue),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(color: Color(0x55000000), blurRadius: 4),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — PER-VALUE FROZEN FRAMES
// ============================================================================
Widget _perValueFrozenFrames(
  Color Function(MaterialBannerClosedReason) colourForReason,
  String Function(MaterialBannerClosedReason) descriptionForReason,
) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFFFB300)),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 2 — Per-Value Frozen Frames',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A static "frozen-frame" mockup of a MaterialBanner for each enum '
          'value. The label below each card describes the closure path that '
          'would emit that reason.',
          style: TextStyle(color: Color(0xFF6D4C41), fontSize: 13),
        ),
        const SizedBox(height: 16),
        ..._buildFrozenFrames(colourForReason, descriptionForReason),
      ],
    ),
  );
}

List<Widget> _buildFrozenFrames(
  Color Function(MaterialBannerClosedReason) colourForReason,
  String Function(MaterialBannerClosedReason) descriptionForReason,
) {
  final frames = <Widget>[];
  for (final r in MaterialBannerClosedReason.values) {
    final color = colourForReason(r);
    frames.add(
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The frozen-frame banner mockup.
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(11),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color,
                    radius: 18,
                    child: Text(
                      r.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MaterialBannerClosedReason.${r.name}',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'enum index = ${r.index}',
                          style: TextStyle(
                            color: color.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: color),
                    child: const Text('Action'),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: color),
                    child: const Text('Dismiss'),
                  ),
                ],
              ),
            ),
            // The label area.
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Will be reported when…',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descriptionForReason(r),
                    style: const TextStyle(fontSize: 13, height: 1.35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  return frames;
}

// ============================================================================
// SECTION 3 — LIVE TRIGGER PANEL
// ============================================================================
Widget _liveTriggerPanel({
  required ValueNotifier<List<_LoggedReason>> historyLog,
  required ValueNotifier<int> queueLength,
  required ValueNotifier<MaterialBannerClosedReason?> lastReason,
  required Color Function(MaterialBannerClosedReason) colourForReason,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF2E7D32)),
    ),
    padding: const EdgeInsets.all(20),
    child: StatefulBuilder(
      builder: (BuildContext ctx, StateSetter setState) {
        void record(MaterialBannerClosedReason r, String label) {
          lastReason.value = r;
          historyLog.value = <_LoggedReason>[
            ...historyLog.value,
            _LoggedReason(r, label, DateTime.now()),
          ];
          setState(() {});
        }

        Future<void> showAndDismiss({
          required String label,
          required MaterialBannerClosedReason reason,
        }) async {
          final messenger = ScaffoldMessenger.of(ctx);
          final color = colourForReason(reason);
          final controller = messenger.showMaterialBanner(
            MaterialBanner(
              backgroundColor: color.withOpacity(0.08),
              leading: CircleAvatar(
                backgroundColor: color,
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
              content: Text(
                'Live banner — about to be closed with $label.',
                style: TextStyle(color: color),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: color),
                  onPressed: () {
                    messenger.hideCurrentMaterialBanner(
                      reason: MaterialBannerClosedReason.dismiss,
                    );
                  },
                  child: const Text('Dismiss'),
                ),
              ],
            ),
          );
          // Programmatically close with the desired reason after a short delay
          // to let the banner appear.
          await Future<void>.delayed(const Duration(milliseconds: 250));
          if (reason == MaterialBannerClosedReason.remove) {
            messenger.removeCurrentMaterialBanner(reason: reason);
          } else {
            messenger.hideCurrentMaterialBanner(reason: reason);
          }
          final closed = await controller.closed;
          record(closed, label);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Section 3 — Live Trigger Panel',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Each button below calls ScaffoldMessenger.showMaterialBanner(), '
              'awaits 250ms, then closes it programmatically with a specific '
              'MaterialBannerClosedReason. The reported reason from '
              'controller.closed is shown in the status card.',
              style: TextStyle(color: Color(0xFF33691E), fontSize: 13),
            ),
            const SizedBox(height: 16),
            // Status card showing the most-recent observed reason.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF66BB6A)),
              ),
              child: ValueListenableBuilder<MaterialBannerClosedReason?>(
                valueListenable: lastReason,
                builder: (BuildContext c, MaterialBannerClosedReason? r, _) {
                  if (r == null) {
                    return const Text(
                      'Most-recent observed reason: (none yet — '
                      'press a button below)',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF555555),
                      ),
                    );
                  }
                  final color = colourForReason(r);
                  return Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Last observed reason: ',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'MaterialBannerClosedReason.${r.name}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Five buttons — each fires a banner and closes with a reason.
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _triggerButton(
                  label: 'dismiss',
                  reason: MaterialBannerClosedReason.dismiss,
                  colourForReason: colourForReason,
                  onPressed: () => showAndDismiss(
                    label: 'dismiss',
                    reason: MaterialBannerClosedReason.dismiss,
                  ),
                ),
                _triggerButton(
                  label: 'hide',
                  reason: MaterialBannerClosedReason.hide,
                  colourForReason: colourForReason,
                  onPressed: () => showAndDismiss(
                    label: 'hide',
                    reason: MaterialBannerClosedReason.hide,
                  ),
                ),
                _triggerButton(
                  label: 'remove',
                  reason: MaterialBannerClosedReason.remove,
                  colourForReason: colourForReason,
                  onPressed: () => showAndDismiss(
                    label: 'remove',
                    reason: MaterialBannerClosedReason.remove,
                  ),
                ),
                _triggerButton(
                  label: 'swipe',
                  reason: MaterialBannerClosedReason.swipe,
                  colourForReason: colourForReason,
                  onPressed: () => showAndDismiss(
                    label: 'swipe',
                    reason: MaterialBannerClosedReason.swipe,
                  ),
                ),
                _triggerButton(
                  label: 'remove (auto)',
                  reason: MaterialBannerClosedReason.remove,
                  colourForReason: colourForReason,
                  onPressed: () => showAndDismiss(
                    label: 'remove (auto)',
                    reason: MaterialBannerClosedReason.remove,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Counter showing how many reasons have been logged so far.
            ValueListenableBuilder<List<_LoggedReason>>(
              valueListenable: historyLog,
              builder: (BuildContext c, List<_LoggedReason> log, _) {
                return Text(
                  'Logged events so far: ${log.length}',
                  style: const TextStyle(
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ],
        );
      },
    ),
  );
}

Widget _triggerButton({
  required String label,
  required MaterialBannerClosedReason reason,
  required Color Function(MaterialBannerClosedReason) colourForReason,
  required VoidCallback onPressed,
}) {
  final color = colourForReason(reason);
  return ElevatedButton.icon(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    ),
    icon: const Icon(Icons.notifications_active_outlined, size: 18),
    label: Text(
      'Show & close .$label',
      style: const TextStyle(fontFamily: 'monospace'),
    ),
  );
}

// ============================================================================
// SECTION 4 — ACTION MAPPING
// ============================================================================
Widget _actionMappingPanel({
  required ValueNotifier<List<_LoggedReason>> historyLog,
  required Color Function(MaterialBannerClosedReason) colourForReason,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF6A1B9A)),
    ),
    padding: const EdgeInsets.all(20),
    child: StatefulBuilder(
      builder: (BuildContext ctx, StateSetter setState) {
        Future<void> runScenario({
          required String title,
          required String message,
          required String primaryLabel,
          required MaterialBannerClosedReason primaryReason,
          required String secondaryLabel,
          required MaterialBannerClosedReason secondaryReason,
        }) async {
          final messenger = ScaffoldMessenger.of(ctx);
          final color = colourForReason(primaryReason);
          final controller = messenger.showMaterialBanner(
            MaterialBanner(
              backgroundColor: color.withOpacity(0.10),
              leading: CircleAvatar(
                backgroundColor: color,
                child: const Icon(Icons.touch_app, color: Colors.white),
              ),
              content: Text(
                message,
                style: TextStyle(color: color),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: color),
                  onPressed: () {
                    messenger.hideCurrentMaterialBanner(
                      reason: secondaryReason,
                    );
                  },
                  child: Text(secondaryLabel),
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: color),
                  onPressed: () {
                    messenger.hideCurrentMaterialBanner(
                      reason: primaryReason,
                    );
                  },
                  child: Text(primaryLabel),
                ),
              ],
            ),
          );
          // Auto-tap the primary action after a brief delay so the demo runs
          // even without manual interaction.
          await Future<void>.delayed(const Duration(milliseconds: 350));
          messenger.hideCurrentMaterialBanner(reason: primaryReason);
          final closed = await controller.closed;
          historyLog.value = <_LoggedReason>[
            ...historyLog.value,
            _LoggedReason(closed, title, DateTime.now()),
          ];
          setState(() {});
        }

        Widget buildScenarioCard({
          required String title,
          required String description,
          required String primaryLabel,
          required MaterialBannerClosedReason primaryReason,
          required String secondaryLabel,
          required MaterialBannerClosedReason secondaryReason,
        }) {
          final color = colourForReason(primaryReason);
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.touch_app, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _miniChip(
                      'Primary → .${primaryReason.name}',
                      colourForReason(primaryReason),
                    ),
                    _miniChip(
                      'Secondary → .${secondaryReason.name}',
                      colourForReason(secondaryReason),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Run live banner'),
                  onPressed: () => runScenario(
                    title: title,
                    message: description,
                    primaryLabel: primaryLabel,
                    primaryReason: primaryReason,
                    secondaryLabel: secondaryLabel,
                    secondaryReason: secondaryReason,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Section 4 — Action Button Mapping',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'A MaterialBanner action that calls hideCurrentMaterialBanner() '
              'with no reason defaults to dismiss. Custom code paths can pass '
              'a different reason — e.g. hide for a "Mute" action.',
              style: TextStyle(color: Color(0xFF4527A0), fontSize: 13),
            ),
            const SizedBox(height: 14),
            buildScenarioCard(
              title: 'Standard "Dismiss" action',
              description:
                  'Tapping Dismiss closes the banner with the default '
                  'MaterialBannerClosedReason.dismiss.',
              primaryLabel: 'Dismiss',
              primaryReason: MaterialBannerClosedReason.dismiss,
              secondaryLabel: 'Cancel',
              secondaryReason: MaterialBannerClosedReason.dismiss,
            ),
            buildScenarioCard(
              title: 'Custom "Mute" action → hide',
              description:
                  'A non-dismissive action (e.g. mute notifications) closes '
                  'the banner programmatically with .hide rather than .dismiss.',
              primaryLabel: 'Mute',
              primaryReason: MaterialBannerClosedReason.hide,
              secondaryLabel: 'Keep',
              secondaryReason: MaterialBannerClosedReason.dismiss,
            ),
            buildScenarioCard(
              title: 'Auto-replace → remove',
              description:
                  'A higher-priority banner pushes the current one out via '
                  'removeCurrentMaterialBanner(reason: remove).',
              primaryLabel: 'Replace',
              primaryReason: MaterialBannerClosedReason.remove,
              secondaryLabel: 'Cancel',
              secondaryReason: MaterialBannerClosedReason.dismiss,
            ),
          ],
        );
      },
    ),
  );
}

Widget _miniChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.w600,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// ============================================================================
// SECTION 5 — REASON HISTORY LOG
// ============================================================================
Widget _historyLogPanel({
  required ValueNotifier<List<_LoggedReason>> historyLog,
  required Color Function(MaterialBannerClosedReason) colourForReason,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFC62828)),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 5 — Reason History Log',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A ValueNotifier<List<MaterialBannerClosedReason>> accumulates each '
          'time a banner is dismissed via the live triggers in sections 3, 4, '
          '6 and 7. Each row shows a timestamp and a colour-coded chip.',
          style: TextStyle(color: Color(0xFF6D4C41), fontSize: 13),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<List<_LoggedReason>>(
          valueListenable: historyLog,
          builder: (BuildContext c, List<_LoggedReason> log, _) {
            if (log.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEF9A9A)),
                ),
                child: const Text(
                  'No dismissals yet. Trigger a live banner above to log one.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFB71C1C),
                  ),
                ),
              );
            }
            return Column(
              children: [
                for (int i = log.length - 1; i >= 0; i--)
                  _historyRow(log[i], i, colourForReason),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget _historyRow(
  _LoggedReason entry,
  int index,
  Color Function(MaterialBannerClosedReason) colourForReason,
) {
  final color = colourForReason(entry.reason);
  final ts =
      '${entry.at.hour.toString().padLeft(2, '0')}:'
      '${entry.at.minute.toString().padLeft(2, '0')}:'
      '${entry.at.second.toString().padLeft(2, '0')}';
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 30,
          child: Text(
            '#${index + 1}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF555555),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            entry.reason.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            entry.label,
            style: const TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          ts,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFF888888),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6 — STACKED BANNER QUEUE
// ============================================================================
Widget _queuePanel({
  required ValueNotifier<List<_LoggedReason>> historyLog,
  required ValueNotifier<int> queueLength,
  required Color Function(MaterialBannerClosedReason) colourForReason,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF00838F)),
    ),
    padding: const EdgeInsets.all(20),
    child: StatefulBuilder(
      builder: (BuildContext ctx, StateSetter setState) {
        Future<void> fireThree() async {
          final messenger = ScaffoldMessenger.of(ctx);
          queueLength.value = 3;
          setState(() {});

          final futures = <Future<MaterialBannerClosedReason>>[];
          for (int i = 0; i < 3; i++) {
            final color = colourForReason(MaterialBannerClosedReason.remove);
            final controller = messenger.showMaterialBanner(
              MaterialBanner(
                backgroundColor: color.withOpacity(0.10),
                leading: CircleAvatar(
                  backgroundColor: color,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                content: Text(
                  'Queued banner #${i + 1} of 3',
                  style: TextStyle(color: color),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: color),
                    onPressed: () {
                      messenger.hideCurrentMaterialBanner(
                        reason: MaterialBannerClosedReason.dismiss,
                      );
                    },
                    child: const Text('Dismiss'),
                  ),
                ],
              ),
            );
            futures.add(controller.closed);
          }
          // Burn through the first two with .remove so the queue advances.
          await Future<void>.delayed(const Duration(milliseconds: 300));
          messenger.removeCurrentMaterialBanner(
            reason: MaterialBannerClosedReason.remove,
          );
          queueLength.value = 2;
          setState(() {});
          await Future<void>.delayed(const Duration(milliseconds: 300));
          messenger.removeCurrentMaterialBanner(
            reason: MaterialBannerClosedReason.remove,
          );
          queueLength.value = 1;
          setState(() {});
          await Future<void>.delayed(const Duration(milliseconds: 300));
          messenger.hideCurrentMaterialBanner(
            reason: MaterialBannerClosedReason.dismiss,
          );
          queueLength.value = 0;
          setState(() {});

          for (int i = 0; i < futures.length; i++) {
            final r = await futures[i];
            historyLog.value = <_LoggedReason>[
              ...historyLog.value,
              _LoggedReason(r, 'Queue #${i + 1}', DateTime.now()),
            ];
          }
          setState(() {});
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Section 6 — Stacked Banner Queue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Fire three banners back-to-back so the ScaffoldMessenger queue '
              'has multiple in flight. The first two are removed via '
              'removeCurrentMaterialBanner(reason: remove); the last is '
              'closed with dismiss.',
              style: TextStyle(color: Color(0xFF00695C), fontSize: 13),
            ),
            const SizedBox(height: 14),
            ValueListenableBuilder<int>(
              valueListenable: queueLength,
              builder: (BuildContext c, int n, _) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF00838F)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.layers, color: Color(0xFF006064)),
                      const SizedBox(width: 10),
                      Text(
                        'Queue length: $n banner(s) in flight',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF006064),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00838F),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.queue_play_next),
              label: const Text('Fire 3 stacked banners'),
              onPressed: fireThree,
            ),
          ],
        );
      },
    ),
  );
}

// ============================================================================
// SECTION 7 — REALISTIC RECIPES
// ============================================================================
Widget _realisticRecipesPanel({
  required ValueNotifier<List<_LoggedReason>> historyLog,
  required Color Function(MaterialBannerClosedReason) colourForReason,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFFF8F00)),
    ),
    padding: const EdgeInsets.all(20),
    child: StatefulBuilder(
      builder: (BuildContext ctx, StateSetter setState) {
        Future<void> showRecipe({
          required String label,
          required Color accent,
          required IconData icon,
          required String title,
          required String message,
          required List<_RecipeAction> actions,
        }) async {
          final messenger = ScaffoldMessenger.of(ctx);
          final controller = messenger.showMaterialBanner(
            MaterialBanner(
              backgroundColor: accent.withOpacity(0.08),
              leading: CircleAvatar(
                backgroundColor: accent,
                child: Icon(icon, color: Colors.white),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(message, style: TextStyle(color: accent)),
                ],
              ),
              actions: [
                for (final a in actions)
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: accent),
                    onPressed: () {
                      messenger.hideCurrentMaterialBanner(reason: a.reason);
                    },
                    child: Text(a.label),
                  ),
              ],
            ),
          );
          await Future<void>.delayed(const Duration(milliseconds: 350));
          messenger.hideCurrentMaterialBanner(
            reason: actions.first.reason,
          );
          final closed = await controller.closed;
          historyLog.value = <_LoggedReason>[
            ...historyLog.value,
            _LoggedReason(closed, label, DateTime.now()),
          ];
          setState(() {});
        }

        Widget recipeCard({
          required String label,
          required Color accent,
          required IconData icon,
          required String title,
          required String message,
          required List<_RecipeAction> actions,
        }) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: accent.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: accent),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(message, style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  children: [
                    for (final a in actions)
                      _miniChip(
                        '${a.label} → .${a.reason.name}',
                        colourForReason(a.reason),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.send, size: 18),
                  label: const Text('Show real banner'),
                  onPressed: () => showRecipe(
                    label: label,
                    accent: accent,
                    icon: icon,
                    title: title,
                    message: message,
                    actions: actions,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Section 7 — Realistic Recipes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Three real-world banners — privacy policy, offline mode, and '
              'update available — each implemented with a real MaterialBanner '
              'and its own action set.',
              style: TextStyle(color: Color(0xFFBF360C), fontSize: 13),
            ),
            const SizedBox(height: 14),
            recipeCard(
              label: 'Privacy policy',
              accent: const Color(0xFF00695C),
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy policy update',
              message: 'We have updated our privacy policy. Please review '
                  'and accept the changes to continue using the app.',
              actions: [
                _RecipeAction('Accept', MaterialBannerClosedReason.dismiss),
                _RecipeAction('Later', MaterialBannerClosedReason.hide),
              ],
            ),
            recipeCard(
              label: 'Offline mode',
              accent: const Color(0xFF5D4037),
              icon: Icons.signal_wifi_off,
              title: 'You are offline',
              message: 'Changes will be saved locally and synced once your '
                  'connection is restored.',
              actions: [
                _RecipeAction('Retry', MaterialBannerClosedReason.dismiss),
                _RecipeAction('Hide',  MaterialBannerClosedReason.hide),
                _RecipeAction(
                  'Replace',
                  MaterialBannerClosedReason.remove,
                ),
              ],
            ),
            recipeCard(
              label: 'Update available',
              accent: const Color(0xFF1565C0),
              icon: Icons.system_update_alt,
              title: 'A new version is available',
              message: 'Version 2.4.0 brings performance improvements and '
                  'bug fixes. Update now to get the latest features.',
              actions: [
                _RecipeAction(
                  'Update',
                  MaterialBannerClosedReason.dismiss,
                ),
                _RecipeAction(
                  'Skip',
                  MaterialBannerClosedReason.hide,
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

class _RecipeAction {
  const _RecipeAction(this.label, this.reason);
  final String label;
  final MaterialBannerClosedReason reason;
}

// ============================================================================
// SECTION 8 — REFERENCE CARD
// ============================================================================
Widget _referenceCard(
  Color Function(MaterialBannerClosedReason) colourForReason,
  String Function(MaterialBannerClosedReason) descriptionForReason,
) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF455A64)),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Section 8 — Reference: enum value table',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Quick reference for every MaterialBannerClosedReason value: '
          'name, declaration index, when emitted, and a one-line description.',
          style: TextStyle(color: Color(0xFF37474F), fontSize: 13),
        ),
        const SizedBox(height: 16),
        // Table header.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF455A64),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: const Row(
            children: [
              SizedBox(
                width: 36,
                child: Text(
                  '#',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 92,
                child: Text(
                  'name',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'when emitted',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (final r in MaterialBannerClosedReason.values)
          _referenceRow(r, colourForReason, descriptionForReason),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFB0BEC5)),
          ),
          child: const Text(
            'API surface used in this demo:\n'
            '• ScaffoldMessenger.of(context).showMaterialBanner(...)\n'
            '• ScaffoldMessenger.of(context).hideCurrentMaterialBanner('
            'reason: ...)\n'
            '• ScaffoldMessenger.of(context).removeCurrentMaterialBanner('
            'reason: ...)\n'
            '• ScaffoldFeatureController<MaterialBanner, '
            'MaterialBannerClosedReason>.closed',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.4,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _referenceRow(
  MaterialBannerClosedReason r,
  Color Function(MaterialBannerClosedReason) colourForReason,
  String Function(MaterialBannerClosedReason) descriptionForReason,
) {
  final color = colourForReason(r);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: r.index.isEven ? Colors.white : const Color(0xFFF5F7FA),
      border: const Border(
        bottom: BorderSide(color: Color(0xFFCFD8DC)),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 36,
          child: Text(
            '${r.index}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF455A64),
            ),
          ),
        ),
        SizedBox(
          width: 92,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              r.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            descriptionForReason(r),
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      ],
    ),
  );
}
