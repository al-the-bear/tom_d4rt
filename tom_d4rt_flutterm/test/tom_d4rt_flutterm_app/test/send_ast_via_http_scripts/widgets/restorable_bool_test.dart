// =============================================================================
// RestorableBool — Deep Visual Demo ("Settings Hub")
// =============================================================================
//
// This demo showcases Flutter's `RestorableBool`, a `RestorableProperty<bool>`
// designed to participate in Flutter's State Restoration framework.
//
// WHAT IS `RestorableBool`?
// -------------------------
// `RestorableBool` is a thin wrapper around a primitive `bool` value that
// knows how to serialize/deserialize itself into a `RestorationBucket`. When
// a `State` mixes in `RestorationMixin` and calls
// `registerForRestoration(property, restorationId)`, Flutter takes care of
// persisting the value across events such as:
//
//   * App process death and resurrection on Android / iOS.
//   * Engine re-attach after the host OS tears down the Flutter view.
//   * "Don't keep activities" developer option on Android.
//   * Predictive back gestures that eagerly dispose and restore state.
//
// Without restoration, a user who turned on "Dark Mode" and then had the
// process killed in the background would come back to a bright white screen
// even though the UI "remembered" it a second ago. With `RestorableBool` the
// value survives because it is written to the platform-provided restoration
// bucket.
//
// WHY A "SETTINGS HUB" STORY?
// ---------------------------
// Settings screens are the canonical home of boolean preferences — dark mode,
// notification toggles, "don't show again" dialogs, and feature flags. Each
// of these is a perfect candidate for `RestorableBool` because:
//
//   * Users expect these to *stick* even without explicit save buttons.
//   * Most settings surfaces live behind a few taps — users rarely tolerate
//     losing the selection because the OS killed the process.
//   * The boolean semantics map cleanly onto `Switch`, `SwitchListTile`,
//     `Checkbox`, and tile-based toggles.
//
// SCRIPT SHAPE
// ------------
// This file is executed by the D4rt interpreter through a test harness, so
// there is no `main()` and no `runApp(...)`. Instead, a top-level
// `dynamic build(BuildContext context)` returns a `MaterialApp(home: ...)`.
//
// A single `StatefulWidget` (`SettingsHubDemo`) owns *all* of the
// `RestorableBool` instances and registers them one by one in `restoreState`.
// The build method composes five distinct visual sections (hero toggle, list,
// dismissible banner, 3x3 flag grid, teaching panel) into one scrollable page.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Top-level entry point required by the D4rt test harness.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('[RestorableBool demo] Building MaterialApp shell...');
  return MaterialApp(
    title: 'RestorableBool Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    // `restorationScopeId` opts the whole app into the restoration framework.
    // Without this, `RestorableBool` registrations are effectively no-ops —
    // the values still work in-memory, but nothing is persisted to a bucket.
    restorationScopeId: 'restorable_bool_demo',
    home: const SettingsHubDemo(),
  );
}

// =============================================================================
// SettingsHubDemo
// =============================================================================
/// A single, chunky demo widget that owns every `RestorableBool` on the
/// screen. Each field is registered with a stable, unique restoration id in
/// `restoreState`. The build method composes five visually distinct sections.
class SettingsHubDemo extends StatefulWidget {
  const SettingsHubDemo({super.key});

  @override
  State<SettingsHubDemo> createState() => _SettingsHubDemoState();
}

class _SettingsHubDemoState extends State<SettingsHubDemo>
    with RestorationMixin {
  // ---------------------------------------------------------------------------
  // Scenario 1 — Theme toggle.
  //
  // This is the hero toggle at the top of the page. Flipping it instantly
  // re-skins the preview card. Persisting it with `RestorableBool` means a
  // user who picked dark mode and then had the OS kill the app comes back
  // to dark mode, not whatever the default was.
  // ---------------------------------------------------------------------------
  final RestorableBool _darkMode = RestorableBool(false);

  // ---------------------------------------------------------------------------
  // Scenario 2 — Privacy & preferences list.
  //
  // Each row is a boolean preference. In a real app these would be backed
  // by both `RestorableBool` (for restoration) *and* a persisted preferences
  // store (for cross-launch durability). Restoration complements — not
  // replaces — disk-based preferences.
  // ---------------------------------------------------------------------------
  final RestorableBool _notifications = RestorableBool(true);
  final RestorableBool _locationSharing = RestorableBool(false);
  final RestorableBool _analyticsOptIn = RestorableBool(true);
  final RestorableBool _autoplayVideo = RestorableBool(false);
  final RestorableBool _betaFeatures = RestorableBool(false);

  // ---------------------------------------------------------------------------
  // Scenario 3 — "Don't show again" dismissible welcome banner.
  //
  // `_welcomeDismissed` gates the banner. If the OS kills the app mid-tour,
  // users would hate seeing the welcome banner again. Restoring this bool
  // keeps the "I've already seen this" state intact.
  // ---------------------------------------------------------------------------
  final RestorableBool _welcomeDismissed = RestorableBool(false);

  // ---------------------------------------------------------------------------
  // Scenario 4 — Feature-flag grid.
  //
  // Each flag is an independent `RestorableBool`. In production these might
  // be driven by a remote flag service; locally, using `RestorableBool`
  // lets QA and developers freely flip flags during testing without losing
  // the configuration when the process is recreated.
  // ---------------------------------------------------------------------------
  final RestorableBool _flagExperimentalSearch = RestorableBool(true);
  final RestorableBool _flagNewDashboard = RestorableBool(false);
  final RestorableBool _flagAiCompanion = RestorableBool(true);
  final RestorableBool _flagOfflineMode = RestorableBool(false);
  final RestorableBool _flagSmartReplies = RestorableBool(true);
  final RestorableBool _flagVoiceNotes = RestorableBool(false);
  final RestorableBool _flagCustomThemes = RestorableBool(false);
  final RestorableBool _flagLowDataMode = RestorableBool(true);
  final RestorableBool _flagSyncOverCellular = RestorableBool(false);

  // ---------------------------------------------------------------------------
  // RestorationMixin boilerplate.
  //
  // `restorationId` provides the namespace for this widget's bucket. All
  // `RestorableProperty` instances are registered with ids that are unique
  // *within* this bucket, so short readable names are fine.
  // ---------------------------------------------------------------------------
  @override
  String? get restorationId => 'settings_hub_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // Each `registerForRestoration` call wires a property into the bucket.
    // If there is a previously saved value, the property is rehydrated from
    // the bucket automatically — no extra work required here.
    registerForRestoration(_darkMode, 'dark_mode');

    registerForRestoration(_notifications, 'pref_notifications');
    registerForRestoration(_locationSharing, 'pref_location');
    registerForRestoration(_analyticsOptIn, 'pref_analytics');
    registerForRestoration(_autoplayVideo, 'pref_autoplay_video');
    registerForRestoration(_betaFeatures, 'pref_beta_features');

    registerForRestoration(_welcomeDismissed, 'welcome_dismissed');

    registerForRestoration(_flagExperimentalSearch, 'flag_exp_search');
    registerForRestoration(_flagNewDashboard, 'flag_new_dashboard');
    registerForRestoration(_flagAiCompanion, 'flag_ai_companion');
    registerForRestoration(_flagOfflineMode, 'flag_offline_mode');
    registerForRestoration(_flagSmartReplies, 'flag_smart_replies');
    registerForRestoration(_flagVoiceNotes, 'flag_voice_notes');
    registerForRestoration(_flagCustomThemes, 'flag_custom_themes');
    registerForRestoration(_flagLowDataMode, 'flag_low_data');
    registerForRestoration(_flagSyncOverCellular, 'flag_sync_cellular');
  }

  @override
  void dispose() {
    // Restorable properties are owned by the State and must be disposed.
    // Forgetting this is a memory leak and will trigger a framework assert.
    _darkMode.dispose();

    _notifications.dispose();
    _locationSharing.dispose();
    _analyticsOptIn.dispose();
    _autoplayVideo.dispose();
    _betaFeatures.dispose();

    _welcomeDismissed.dispose();

    _flagExperimentalSearch.dispose();
    _flagNewDashboard.dispose();
    _flagAiCompanion.dispose();
    _flagOfflineMode.dispose();
    _flagSmartReplies.dispose();
    _flagVoiceNotes.dispose();
    _flagCustomThemes.dispose();
    _flagLowDataMode.dispose();
    _flagSyncOverCellular.dispose();

    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Helper: uniform section header used by every scenario.
  // ---------------------------------------------------------------------------
  Widget _sectionHeader(String title, IconData icon, Color accent) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accent.withValues(alpha: 0.4)),
            ),
            child: Icon(icon, color: accent, size: 20),
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
                    color: accent.withValues(alpha: 0.95),
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent,
                        accent.withValues(alpha: 0.05),
                      ],
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

  // ===========================================================================
  // Scenario 1 — Dark mode toggle with live preview.
  //
  // The `AnimatedContainer` below smoothly transitions colors when the theme
  // bool is flipped. In a real app you might additionally swap the entire
  // `ThemeData` via the parent `MaterialApp`; here we stay local so the user
  // can see the exact effect of a single `RestorableBool`.
  // ===========================================================================
  Widget _buildThemeSection() {
    // Derive preview colors from the dark-mode bool.
    final bool dark = _darkMode.value;
    final Color bg = dark ? const Color(0xFF121821) : const Color(0xFFF4F6FB);
    final Color card = dark ? const Color(0xFF1E2533) : Colors.white;
    final Color text = dark ? Colors.white : const Color(0xFF1C1F26);
    final Color muted = dark ? Colors.white70 : Colors.black54;
    final Color accent = dark ? Colors.tealAccent : Colors.indigo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader('Appearance', Icons.dark_mode_outlined, Colors.indigo),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 6,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                // Hero strip with the big switch.
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: dark
                          ? [
                              const Color(0xFF1F2A44),
                              const Color(0xFF0E1320),
                            ]
                          : [
                              const Color(0xFFE8ECFF),
                              const Color(0xFFFDFDFF),
                            ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: dark
                                ? [Colors.indigo.shade700, Colors.black]
                                : [Colors.indigo, Colors.indigoAccent],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.indigo.withValues(alpha: 0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          dark ? Icons.nightlight_round : Icons.wb_sunny,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dark Mode',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: dark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              dark
                                  ? 'Easier on the eyes after sunset.'
                                  : 'Bright & airy daytime palette.',
                              style: TextStyle(
                                fontSize: 13,
                                color: dark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Binding the `Switch` to a `RestorableBool` is as simple
                      // as reading `.value` and writing back via setState.
                      Switch(
                        value: _darkMode.value,
                        onChanged: (v) {
                          setState(() {
                            _darkMode.value = v;
                          });
                          debugPrint('[RestorableBool demo] dark mode -> $v');
                        },
                      ),
                    ],
                  ),
                ),
                // Live preview pane — an in-card mini app that flips colors.
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  color: bg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Faux app bar inside the preview.
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: card,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.menu, color: text, size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Preview App',
                                style: TextStyle(
                                  color: text,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(Icons.search, color: muted, size: 18),
                            const SizedBox(width: 10),
                            Icon(Icons.notifications_none,
                                color: muted, size: 18),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Faux list item.
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: card,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: accent.withValues(alpha: 0.2),
                              child: Icon(
                                Icons.bolt,
                                color: accent,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Daily digest ready',
                                    style: TextStyle(
                                      color: text,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '7 new items since yesterday',
                                    style: TextStyle(
                                      color: muted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Chip(
                              label: const Text('NEW'),
                              labelStyle: TextStyle(
                                color: dark ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                              ),
                              backgroundColor: accent,
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Faux primary button.
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: accent.withValues(alpha: 0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: dark ? Colors.black : Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Open digest',
                                style: TextStyle(
                                  color: dark ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Footer annotation: status banner driven by the bool.
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: muted,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              dark
                                  ? 'Dark palette persists across restart (RestorableBool).'
                                  : 'Light palette persists across restart (RestorableBool).',
                              style: TextStyle(
                                color: muted,
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
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
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // Scenario 2 — Five-row privacy & preferences list.
  //
  // Each SwitchListTile is a separate `RestorableBool` registered with its
  // own id. Because restoration keys are stable strings, reordering these
  // rows in a later release will not break restoration for existing users.
  // ===========================================================================
  Widget _buildSettingsListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(
          'Privacy & Preferences',
          Icons.tune,
          Colors.deepPurple,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _prefTile(
                  icon: Icons.notifications_active,
                  iconColor: Colors.orange,
                  title: 'Push notifications',
                  subtitle:
                      'Receive alerts for new messages, reminders, and updates.',
                  boolRef: _notifications,
                ),
                const Divider(height: 1, indent: 64),
                _prefTile(
                  icon: Icons.location_on,
                  iconColor: Colors.redAccent,
                  title: 'Share precise location',
                  subtitle:
                      'Used by maps, local search, and nearby recommendations.',
                  boolRef: _locationSharing,
                ),
                const Divider(height: 1, indent: 64),
                _prefTile(
                  icon: Icons.analytics_outlined,
                  iconColor: Colors.blueAccent,
                  title: 'Share anonymous analytics',
                  subtitle:
                      'Helps us measure feature adoption and crash rates.',
                  boolRef: _analyticsOptIn,
                ),
                const Divider(height: 1, indent: 64),
                _prefTile(
                  icon: Icons.play_circle_fill,
                  iconColor: Colors.teal,
                  title: 'Autoplay videos',
                  subtitle: 'Automatically start videos while scrolling feeds.',
                  boolRef: _autoplayVideo,
                ),
                const Divider(height: 1, indent: 64),
                _prefTile(
                  icon: Icons.science,
                  iconColor: Colors.pinkAccent,
                  title: 'Beta features',
                  subtitle:
                      'Opt in to experiments. May be unstable or change quickly.',
                  boolRef: _betaFeatures,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Single preference row. Extracted so the 5 rows above read compactly
  /// without creating identical subtrees by hand.
  Widget _prefTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required RestorableBool boolRef,
  }) {
    return SwitchListTile(
      secondary: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ),
      value: boolRef.value,
      onChanged: (v) {
        setState(() {
          boolRef.value = v;
        });
        debugPrint('[RestorableBool demo] $title -> $v');
      },
    );
  }

  // ===========================================================================
  // Scenario 3 — Dismissible welcome banner with lifecycle diagram.
  //
  // Classic "don't show again" pattern. The bool gates the visibility of
  // the amber banner. The second card demonstrates the inverse state and
  // provides a reset button. Below both, a Row-based diagram illustrates
  // the three restoration-visible states.
  // ===========================================================================
  Widget _buildDismissSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(
          'First-Run Banner',
          Icons.waving_hand,
          Colors.amber.shade800,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _welcomeDismissed.value
                ? _buildDismissedCard()
                : _buildActiveBanner(),
          ),
        ),
        const SizedBox(height: 16),
        // Lifecycle diagram: three stacked containers with arrows between.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Bool lifecycle (restored across app death):',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _lifecycleStep(
                        label: 'never shown',
                        icon: Icons.visibility_off,
                        active: !_welcomeDismissed.value,
                        color: Colors.grey,
                      ),
                    ),
                    _lifecycleArrow(),
                    Expanded(
                      child: _lifecycleStep(
                        label: 'shown once',
                        icon: Icons.campaign,
                        active: !_welcomeDismissed.value,
                        color: Colors.amber.shade700,
                      ),
                    ),
                    _lifecycleArrow(),
                    Expanded(
                      child: _lifecycleStep(
                        label: 'dismissed',
                        icon: Icons.check_circle,
                        active: _welcomeDismissed.value,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveBanner() {
    // Shown when `_welcomeDismissed` is false — the banner has not yet been
    // acknowledged by the user. This is the typical initial state after a
    // fresh install, and the state we DO NOT want to revert to after a
    // process kill (hence RestorableBool).
    return Container(
      key: const ValueKey('welcome-active'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.amber.shade200,
            Colors.orange.shade300,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tap the close icon to dismiss this tour. '
                  'Your decision is remembered across app restart.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _welcomeDismissed.value = true;
              });
              debugPrint('[RestorableBool demo] welcome banner dismissed');
            },
            icon: const Icon(Icons.close, color: Colors.white),
            tooltip: 'Dismiss',
          ),
        ],
      ),
    );
  }

  Widget _buildDismissedCard() {
    // Shown once the user has dismissed the banner. The reset button flips
    // the bool back to false so you can see the restoration round-trip in
    // either direction.
    return Card(
      key: const ValueKey('welcome-dismissed'),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Banner dismissed',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '`_welcomeDismissed.value == true` is stored in the '
                    'restoration bucket until reset.',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _welcomeDismissed.value = false;
                });
                debugPrint(
                    '[RestorableBool demo] first-run state reset to false');
              },
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lifecycleStep({
    required String label,
    required IconData icon,
    required bool active,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.15) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: active ? color : Colors.grey.shade300,
          width: active ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: active ? color : Colors.grey, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: active ? color : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _lifecycleArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.arrow_forward, size: 16, color: Colors.brown),
    );
  }

  // ===========================================================================
  // Scenario 4 — 3x3 feature-flag grid.
  //
  // Nine distinct flags, each its own `RestorableBool`. We intentionally
  // enumerate each tile descriptor (icon, label, color, bool reference) as
  // an explicit record rather than a for-loop of template clones, so the
  // grid looks hand-crafted — each cell has a unique identity.
  // ===========================================================================
  Widget _buildFeatureFlagsSection() {
    // Bundling descriptors into a small list keeps the grid tidy while
    // still giving each tile its own icon, color, and `RestorableBool`.
    final List<_FlagDescriptor> flags = <_FlagDescriptor>[
      _FlagDescriptor(
        name: 'Experimental Search',
        icon: Icons.search,
        color: Colors.teal,
        boolRef: _flagExperimentalSearch,
      ),
      _FlagDescriptor(
        name: 'New Dashboard',
        icon: Icons.dashboard_customize,
        color: Colors.indigo,
        boolRef: _flagNewDashboard,
      ),
      _FlagDescriptor(
        name: 'AI Companion',
        icon: Icons.auto_awesome,
        color: Colors.purple,
        boolRef: _flagAiCompanion,
      ),
      _FlagDescriptor(
        name: 'Offline Mode',
        icon: Icons.cloud_off,
        color: Colors.blueGrey,
        boolRef: _flagOfflineMode,
      ),
      _FlagDescriptor(
        name: 'Smart Replies',
        icon: Icons.smart_toy,
        color: Colors.deepPurple,
        boolRef: _flagSmartReplies,
      ),
      _FlagDescriptor(
        name: 'Voice Notes',
        icon: Icons.mic,
        color: Colors.pink,
        boolRef: _flagVoiceNotes,
      ),
      _FlagDescriptor(
        name: 'Custom Themes',
        icon: Icons.palette,
        color: Colors.orange,
        boolRef: _flagCustomThemes,
      ),
      _FlagDescriptor(
        name: 'Low-Data Mode',
        icon: Icons.data_saver_on,
        color: Colors.green,
        boolRef: _flagLowDataMode,
      ),
      _FlagDescriptor(
        name: 'Cellular Sync',
        icon: Icons.signal_cellular_alt,
        color: Colors.redAccent,
        boolRef: _flagSyncOverCellular,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(
          'Feature Flags',
          Icons.toggle_on,
          Colors.green.shade700,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade50,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.95,
              children: <Widget>[
                for (final _FlagDescriptor f in flags) _flagTile(f),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _flagTile(_FlagDescriptor f) {
    final bool on = f.boolRef.value;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            f.boolRef.value = !on;
          });
          debugPrint(
              '[RestorableBool demo] flag "${f.name}" -> ${f.boolRef.value}');
        },
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: on
                ? f.color.withValues(alpha: 0.15)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: on ? f.color : Colors.grey.shade300,
              width: on ? 2 : 1,
              style: on ? BorderStyle.solid : BorderStyle.solid,
            ),
            boxShadow: on
                ? [
                    BoxShadow(
                      color: f.color.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                f.icon,
                color: on ? f.color : Colors.grey,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                f.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: on ? f.color : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 6),
              // Indicator dot: filled when on, hollow when off.
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: on ? f.color : Colors.transparent,
                  border: Border.all(
                    color: on ? f.color : Colors.grey,
                    width: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // Scenario 5 — Teaching panel.
  //
  // Three side-by-side explainer cards. The first contrasts a plain
  // `setState` with a reload that wipes the value; the second shows how a
  // restoration bucket preserves it; the third lists real-world use cases.
  // ===========================================================================
  Widget _buildTeachingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(
          'How `RestorableBool` works',
          Icons.school,
          Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Stack teaching cards vertically on narrow screens, row-wise
              // otherwise. Keeps the demo responsive without MediaQuery fuss.
              final bool wide = constraints.maxWidth > 680;
              final List<Widget> cards = <Widget>[
                _teachingWithoutRestoration(),
                _teachingWithRestoration(),
                _teachingUseCases(),
              ];
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (int i = 0; i < cards.length; i++) ...[
                      Expanded(child: cards[i]),
                      if (i < cards.length - 1) const SizedBox(width: 12),
                    ],
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (int i = 0; i < cards.length; i++) ...[
                    cards[i],
                    if (i < cards.length - 1) const SizedBox(height: 12),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _teachingWithoutRestoration() {
    // Illustrates what happens with a plain `bool` field + setState when
    // the engine restarts: the value is simply lost because nothing
    // persisted it.
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber, color: Colors.redAccent),
                const SizedBox(width: 8),
                Text(
                  'Without restoration',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'bool dark = false;',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'setState(() => dark = true);',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Process restart wipes the value — user sees the default.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // A visual "break" arrow across a small bool indicator.
            Row(
              children: [
                _miniStatePill('true', Colors.green),
                const Icon(Icons.flash_on, color: Colors.amber, size: 18),
                _miniStatePill('??', Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _teachingWithRestoration() {
    // Counter-example with a `RestorableBool`: the value round-trips through
    // the restoration bucket. Even after a full process kill the user sees
    // the preserved value.
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.verified, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'With RestorableBool',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'final _dark = RestorableBool(false);',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "registerForRestoration(_dark, 'dark');",
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.savings, color: Colors.green),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'The bucket preserves the value across restart.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _miniStatePill('true', Colors.green),
                const Icon(Icons.arrow_forward, color: Colors.green, size: 18),
                _miniStatePill('true', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _teachingUseCases() {
    // A punch-list of real-world places in a production app where
    // `RestorableBool` materially improves UX. These are not academic —
    // missing restoration here results in visible user pain.
    final List<_UseCase> items = <_UseCase>[
      _UseCase(
        icon: Icons.menu_book,
        label: 'Navigation drawer open/closed',
        color: Colors.indigo,
      ),
      _UseCase(
        icon: Icons.toggle_on,
        label: 'User-level preferences & settings',
        color: Colors.teal,
      ),
      _UseCase(
        icon: Icons.campaign,
        label: 'One-shot dialog / tutorial gates',
        color: Colors.amber,
      ),
      _UseCase(
        icon: Icons.flag,
        label: 'Developer / QA feature flags',
        color: Colors.green,
      ),
      _UseCase(
        icon: Icons.filter_alt,
        label: 'List / search filter toggles',
        color: Colors.purple,
      ),
      _UseCase(
        icon: Icons.visibility,
        label: 'Expandable section "expanded" state',
        color: Colors.blueGrey,
      ),
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.lightbulb, color: Colors.blueGrey),
                SizedBox(width: 8),
                Text(
                  'Where to use it',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            for (final _UseCase u in items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: u.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(u.icon, color: u.color, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        u.label,
                        style: const TextStyle(fontSize: 12),
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

  Widget _miniStatePill(String label, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  // ===========================================================================
  // Page assembly.
  //
  // Five sections, separated by generous whitespace and thin dividers. The
  // ambient background uses a subtle gradient so each card pops.
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    debugPrint('[RestorableBool demo] _SettingsHubDemoState.build()');
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestorableBool - Settings Hub'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEDEFF7),
              Color(0xFFFAFAFC),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildThemeSection(),
              const SizedBox(height: 16),
              const Divider(indent: 24, endIndent: 24, height: 1),
              _buildSettingsListSection(),
              const SizedBox(height: 16),
              const Divider(indent: 24, endIndent: 24, height: 1),
              _buildDismissSection(),
              const SizedBox(height: 16),
              const Divider(indent: 24, endIndent: 24, height: 1),
              _buildFeatureFlagsSection(),
              const SizedBox(height: 16),
              const Divider(indent: 24, endIndent: 24, height: 1),
              _buildTeachingSection(),
              const SizedBox(height: 24),
              // Footer summary: counts the number of registered RestorableBools.
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: Colors.indigo.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.indigo),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'This demo registers ${1 + 5 + 1 + 9} `RestorableBool` '
                          'instances across five visual sections. Each one is '
                          'namespaced by a unique string id inside the '
                          '`settings_hub_demo` restoration bucket.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Helper descriptor types.
//
// These tiny immutable classes keep the scenario-4 grid and the use-case list
// readable without resorting to unbounded Map<String, dynamic> trickery.
// =============================================================================

/// Describes a single feature-flag tile in the 3x3 grid.
class _FlagDescriptor {
  _FlagDescriptor({
    required this.name,
    required this.icon,
    required this.color,
    required this.boolRef,
  });

  final String name;
  final IconData icon;
  final Color color;
  final RestorableBool boolRef;
}

/// Describes a single use-case row in the teaching panel.
class _UseCase {
  _UseCase({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
}
