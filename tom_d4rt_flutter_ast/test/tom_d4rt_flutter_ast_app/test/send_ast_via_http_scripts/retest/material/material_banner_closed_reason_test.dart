// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// Deep visual demo: MaterialBannerClosedReason
//
// MaterialBannerClosedReason is the small enum returned by the close future
// when a MaterialBanner is removed from the ScaffoldMessenger. The four
// canonical values (dismiss, swipe, hide, remove) each describe a distinct
// cause for closure and inform how the surrounding feature should react.
// Two related conceptual reasons (timeout, action) appear in SnackBar's
// closed-reason enum and are surfaced here as design-time analogues so the
// demo can reason about the entire family of close signals a developer is
// likely to encounter when picking between MaterialBanner and SnackBar.
//
// Design plan:
//   Section 1 - Header gradient banner introducing the enum and the use case.
//   Section 2 - Reason catalogue: one state card per reason with trigger,
//               consumer responsibility and notes. Uses Material 3 tonal
//               palette derived from the ColorScheme.
//   Section 3 - Anatomy of a static MaterialBanner specimen with each part
//               labelled (leadingIcon, content, actions, dividerColor,
//               padding) rendered inline since ScaffoldMessenger is not
//               available in a static AST render.
//   Section 4 - Reason -> trigger mapping table (data driven, no DataTable
//               to keep layout deterministic in AST execution).
//   Section 5 - State machine diagram: idle -> shown -> closed/<reason>
//               drawn with nested containers, arrows and reason chips.
//   Section 6 - Recipes: when to pick MaterialBanner versus SnackBar; how to
//               handle action versus dismiss in the awaited close future.
//   Section 7 - Glossary, code reference patterns and final summary card.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialBannerClosedReasonDemoApp());

class MaterialBannerClosedReasonDemoApp extends StatelessWidget {
  const MaterialBannerClosedReasonDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('MaterialBannerClosedReason Deep Demo executing');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaterialBannerClosedReason Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      home: const _DemoScaffold(),
    );
  }
}

// =========================================================================
// Data model classes (top-level so the script body stays readable).
// =========================================================================

class _ReasonCard {
  const _ReasonCard({
    required this.label,
    required this.qualifiedName,
    required this.canonical,
    required this.trigger,
    required this.consumer,
    required this.notes,
    required this.icon,
    required this.accent,
  });

  /// Short identifier used as the card title (e.g. dismiss).
  final String label;

  /// Fully qualified enum-style name shown under the title.
  final String qualifiedName;

  /// True for the four canonical MaterialBannerClosedReason values.
  /// False for conceptual cousins drawn from SnackBar's closed-reason
  /// enum that round out the design discussion.
  final bool canonical;

  final String trigger;
  final String consumer;
  final String notes;
  final IconData icon;
  final Color accent;
}

class _MappingRow {
  const _MappingRow({
    required this.reason,
    required this.triggeredBy,
    required this.userIntent,
    required this.shouldRestore,
  });

  final String reason;
  final String triggeredBy;
  final String userIntent;
  final bool shouldRestore;
}

class _StateNode {
  const _StateNode({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
}

class _Recipe {
  const _Recipe({
    required this.headline,
    required this.body,
    required this.icon,
    required this.tone,
  });

  final String headline;
  final String body;
  final IconData icon;
  final Color tone;
}

class _GlossaryEntry {
  const _GlossaryEntry({
    required this.term,
    required this.definition,
  });

  final String term;
  final String definition;
}

// =========================================================================
// Root demo widget.
// =========================================================================

class _DemoScaffold extends StatelessWidget {
  const _DemoScaffold();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    print('Building MaterialBannerClosedReason layout');
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeaderBanner(scheme: scheme),
              const SizedBox(height: 28),
              _ReasonCatalogueSection(scheme: scheme),
              const SizedBox(height: 28),
              _AnatomySection(scheme: scheme),
              const SizedBox(height: 28),
              _MappingTableSection(scheme: scheme),
              const SizedBox(height: 28),
              _StateMachineSection(scheme: scheme),
              const SizedBox(height: 28),
              _RecipesSection(scheme: scheme),
              const SizedBox(height: 28),
              _GlossarySection(scheme: scheme),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// Section 1: Header gradient banner.
// =========================================================================

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 1: Header ===');
    final reasons = MaterialBannerClosedReason.values;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.30),
            blurRadius: 18,
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.campaign_outlined,
                  color: scheme.onPrimary,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'MaterialBannerClosedReason',
                      style: TextStyle(
                        color: scheme.onPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Six discrete reasons returned when a MaterialBanner is closed.',
                      style: TextStyle(
                        color: scheme.onPrimary.withValues(alpha: 0.85),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final reason in reasons)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.onPrimary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: scheme.onPrimary.withValues(alpha: 0.30),
                    ),
                  ),
                  child: Text(
                    reason.name,
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// Section 2: Reason catalogue.
// =========================================================================

class _ReasonCatalogueSection extends StatelessWidget {
  const _ReasonCatalogueSection({required this.scheme});

  final ColorScheme scheme;

  static const List<_ReasonCard> _cards = <_ReasonCard>[
    _ReasonCard(
      label: 'dismiss',
      qualifiedName: 'MaterialBannerClosedReason.dismiss',
      canonical: true,
      trigger: 'Closed through a SemanticsAction.dismiss.',
      consumer: 'Treat as silent close. Do not nag the user.',
      notes:
          'Accessibility-driven dismissal: the banner is taken down without a user-visible swipe.',
      icon: Icons.power_settings_new,
      accent: Color(0xFF5E5CE6),
    ),
    _ReasonCard(
      label: 'hide',
      qualifiedName: 'MaterialBannerClosedReason.hide',
      canonical: true,
      trigger:
          'ScaffoldMessengerState.hideCurrentMaterialBanner() or the close callback.',
      consumer: 'Animate out; banner may return if conditions persist.',
      notes:
          'Hide is the gentler cousin of remove: animation runs but state is not destroyed.',
      icon: Icons.visibility_off_outlined,
      accent: Color(0xFF2A9D8F),
    ),
    _ReasonCard(
      label: 'remove',
      qualifiedName: 'MaterialBannerClosedReason.remove',
      canonical: true,
      trigger:
          'Banner removed via ScaffoldMessengerState.removeCurrentMaterialBanner().',
      consumer:
          'Hard removal, the queue advances. Cancel any pending follow-ups.',
      notes:
          'Common when a newer banner supersedes the current one programmatically.',
      icon: Icons.delete_sweep_outlined,
      accent: Color(0xFFE76F51),
    ),
    _ReasonCard(
      label: 'swipe',
      qualifiedName: 'MaterialBannerClosedReason.swipe',
      canonical: true,
      trigger: "User's swipe gesture closed the banner.",
      consumer: 'Respect the dismissal, do not auto-restore.',
      notes:
          'Swipe is a stronger user signal than hide; record analytics about the rejection.',
      icon: Icons.swipe_outlined,
      accent: Color(0xFFF4A261),
    ),
    _ReasonCard(
      label: 'timeout (cousin)',
      qualifiedName: 'SnackBarClosedReason.timeout',
      canonical: false,
      trigger:
          'Auto-close after the visible duration elapsed - a SnackBar-only reason included for comparison.',
      consumer:
          'MaterialBanner has no timeout, so a banner equivalent must be modelled in host code.',
      notes:
          'Useful when discussing whether to switch from a banner to a SnackBar for ephemeral hints.',
      icon: Icons.hourglass_bottom,
      accent: Color(0xFF118AB2),
    ),
    _ReasonCard(
      label: 'action (cousin)',
      qualifiedName: 'SnackBarClosedReason.action',
      canonical: false,
      trigger:
          'User tapped a SnackBarAction. The closest banner analogue is the host coding a custom completer when an action button is pressed.',
      consumer: 'Run the requested workflow; banner is dismissed.',
      notes:
          'The most positive signal. Always log the action label for telemetry.',
      icon: Icons.touch_app_outlined,
      accent: Color(0xFF06D6A0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print('=== Section 2: Reason Catalogue ===');
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 2,
          title: 'Reason Catalogue',
          subtitle: 'One card per MaterialBannerClosedReason value.',
          scheme: scheme,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext _, BoxConstraints constraints) {
            final cards = <Widget>[
              for (final card in _cards)
                _ReasonStateCard(card: card, scheme: scheme, theme: theme),
            ];
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: <Widget>[
                for (final w in cards)
                  SizedBox(width: 320, child: w),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ReasonStateCard extends StatelessWidget {
  const _ReasonStateCard({
    required this.card,
    required this.scheme,
    required this.theme,
  });

  final _ReasonCard card;
  final ColorScheme scheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: card.accent.withValues(alpha: 0.35),
          width: 1.4,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: card.accent.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: card.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(card.icon, color: card.accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            card.label,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: card.accent,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: card.canonical
                                ? card.accent.withValues(alpha: 0.18)
                                : scheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: card.accent.withValues(alpha: 0.40),
                            ),
                          ),
                          child: Text(
                            card.canonical ? 'enum' : 'cousin',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: card.accent,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      card.qualifiedName,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _KeyValueLine(
            label: 'Trigger',
            value: card.trigger,
            accent: card.accent,
            scheme: scheme,
          ),
          const SizedBox(height: 8),
          _KeyValueLine(
            label: 'Consumer',
            value: card.consumer,
            accent: card.accent,
            scheme: scheme,
          ),
          const SizedBox(height: 8),
          _KeyValueLine(
            label: 'Notes',
            value: card.notes,
            accent: card.accent,
            scheme: scheme,
          ),
        ],
      ),
    );
  }
}

class _KeyValueLine extends StatelessWidget {
  const _KeyValueLine({
    required this.label,
    required this.value,
    required this.accent,
    required this.scheme,
  });

  final String label;
  final String value;
  final Color accent;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              color: scheme.onSurface,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// Section 3: Anatomy of a static MaterialBanner specimen.
// =========================================================================

class _AnatomySection extends StatelessWidget {
  const _AnatomySection({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 3: Banner Anatomy ===');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 3,
          title: 'Banner Anatomy',
          subtitle:
              'Static MaterialBanner specimens rendered inline. ScaffoldMessenger is not used in static AST execution.',
          scheme: scheme,
        ),
        const SizedBox(height: 16),
        _AnatomySpecimen(
          scheme: scheme,
          headline: 'Standard banner with two actions',
          banner: _buildStandardBanner(scheme),
          callouts: const <_AnatomyCallout>[
            _AnatomyCallout(
              label: 'leadingIcon',
              note: 'Sets the iconography on the left side.',
            ),
            _AnatomyCallout(
              label: 'content',
              note: 'Main message. Keep under two lines for legibility.',
            ),
            _AnatomyCallout(
              label: 'actions',
              note: 'Up to two TextButtons. The chosen one fires the future.',
            ),
            _AnatomyCallout(
              label: 'dividerColor',
              note:
                  'Separator beneath the banner. Pass Colors.transparent to hide.',
            ),
            _AnatomyCallout(
              label: 'padding',
              note: 'Inner padding around content.',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _AnatomySpecimen(
          scheme: scheme,
          headline: 'Compact informational banner',
          banner: _buildCompactBanner(scheme),
          callouts: const <_AnatomyCallout>[
            _AnatomyCallout(
              label: 'forceActionsBelow',
              note: 'Stacks actions on a new line for narrow widths.',
            ),
            _AnatomyCallout(
              label: 'overflowAlignment',
              note: 'Aligns wrapped actions when forceActionsBelow is true.',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _AnatomySpecimen(
          scheme: scheme,
          headline: 'Destructive banner with single action',
          banner: _buildDestructiveBanner(scheme),
          callouts: const <_AnatomyCallout>[
            _AnatomyCallout(
              label: 'backgroundColor',
              note: 'Use error container to imply severity.',
            ),
            _AnatomyCallout(
              label: 'action.onPressed',
              note:
                  'Tapping resolves the close future with reason action.',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStandardBanner(ColorScheme scheme) {
    return MaterialBanner(
      backgroundColor: scheme.surfaceContainerHighest,
      dividerColor: scheme.outlineVariant,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      leading: CircleAvatar(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        child: const Icon(Icons.cloud_sync_outlined),
      ),
      content: Text(
        'You have unsynced notes from your last session. Choose how to proceed.',
        style: TextStyle(color: scheme.onSurface),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: null,
          child: Text(
            'DISMISS',
            style: TextStyle(color: scheme.primary),
          ),
        ),
        TextButton(
          onPressed: null,
          child: Text(
            'SYNC NOW',
            style: TextStyle(color: scheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactBanner(ColorScheme scheme) {
    return MaterialBanner(
      backgroundColor: scheme.secondaryContainer,
      dividerColor: Colors.transparent,
      forceActionsBelow: true,
      overflowAlignment: OverflowBarAlignment.end,
      content: Text(
        'Offline mode is active. Some features may be unavailable.',
        style: TextStyle(color: scheme.onSecondaryContainer),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: null,
          child: Text(
            'GOT IT',
            style: TextStyle(color: scheme.onSecondaryContainer),
          ),
        ),
      ],
    );
  }

  Widget _buildDestructiveBanner(ColorScheme scheme) {
    return MaterialBanner(
      backgroundColor: scheme.errorContainer,
      dividerColor: scheme.error.withValues(alpha: 0.30),
      leading: Icon(Icons.warning_amber_outlined, color: scheme.onErrorContainer),
      content: Text(
        'A required permission was revoked. Re-grant access to keep syncing.',
        style: TextStyle(color: scheme.onErrorContainer),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: null,
          child: Text(
            'OPEN SETTINGS',
            style: TextStyle(color: scheme.onErrorContainer),
          ),
        ),
      ],
    );
  }
}

class _AnatomyCallout {
  const _AnatomyCallout({required this.label, required this.note});

  final String label;
  final String note;
}

class _AnatomySpecimen extends StatelessWidget {
  const _AnatomySpecimen({
    required this.scheme,
    required this.headline,
    required this.banner,
    required this.callouts,
  });

  final ColorScheme scheme;
  final String headline;
  final Widget banner;
  final List<_AnatomyCallout> callouts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.flag_outlined, color: scheme.primary, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  headline,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: banner,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: <Widget>[
              for (final callout in callouts)
                Container(
                  constraints: const BoxConstraints(maxWidth: 260),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 2, right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          callout.label,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          callout.note,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: scheme.onSurfaceVariant,
                            height: 1.3,
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

// =========================================================================
// Section 4: Reason -> Trigger mapping table.
// =========================================================================

class _MappingTableSection extends StatelessWidget {
  const _MappingTableSection({required this.scheme});

  final ColorScheme scheme;

  static const List<_MappingRow> _rows = <_MappingRow>[
    _MappingRow(
      reason: 'dismiss',
      triggeredBy: 'Programmatic dismissal (no animation)',
      userIntent: 'None - host code decision',
      shouldRestore: false,
    ),
    _MappingRow(
      reason: 'hide',
      triggeredBy: 'hideCurrentMaterialBanner()',
      userIntent: 'Host code wants the banner to slide out',
      shouldRestore: true,
    ),
    _MappingRow(
      reason: 'remove',
      triggeredBy: 'removeCurrentMaterialBanner()',
      userIntent: 'Host code wants the banner gone',
      shouldRestore: false,
    ),
    _MappingRow(
      reason: 'swipe',
      triggeredBy: 'User gesture (where supported)',
      userIntent: 'Explicit user rejection',
      shouldRestore: false,
    ),
    _MappingRow(
      reason: 'timeout',
      triggeredBy: 'Auto-close timer',
      userIntent: 'None - user ignored the banner',
      shouldRestore: true,
    ),
    _MappingRow(
      reason: 'action',
      triggeredBy: 'User tapped an action button',
      userIntent: 'Positive engagement',
      shouldRestore: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print('=== Section 4: Mapping Table ===');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 4,
          title: 'Reason -> Trigger Mapping',
          subtitle: 'Cheat sheet for choosing the right follow-up behaviour.',
          scheme: scheme,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: scheme.outlineVariant),
            color: scheme.surfaceContainerHigh,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              _MappingHeader(scheme: scheme),
              for (int i = 0; i < _rows.length; i++)
                _MappingRowView(
                  row: _rows[i],
                  scheme: scheme,
                  zebra: i.isOdd,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MappingHeader extends StatelessWidget {
  const _MappingHeader({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: scheme.onPrimary,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
      fontSize: 12,
    );
    return Container(
      color: scheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(flex: 2, child: Text('Reason', style: style)),
          Expanded(flex: 4, child: Text('Triggered by', style: style)),
          Expanded(flex: 4, child: Text('User intent', style: style)),
          Expanded(flex: 2, child: Text('Restore?', style: style)),
        ],
      ),
    );
  }
}

class _MappingRowView extends StatelessWidget {
  const _MappingRowView({
    required this.row,
    required this.scheme,
    required this.zebra,
  });

  final _MappingRow row;
  final ColorScheme scheme;
  final bool zebra;

  @override
  Widget build(BuildContext context) {
    final cellStyle = TextStyle(
      fontSize: 12.5,
      color: scheme.onSurface,
      height: 1.35,
    );
    return Container(
      color: zebra ? scheme.surfaceContainer : scheme.surfaceContainerHigh,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                row.reason,
                style: TextStyle(
                  color: scheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(flex: 4, child: Text(row.triggeredBy, style: cellStyle)),
          Expanded(flex: 4, child: Text(row.userIntent, style: cellStyle)),
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Icon(
                  row.shouldRestore ? Icons.replay : Icons.block,
                  color: row.shouldRestore
                      ? scheme.tertiary
                      : scheme.error,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  row.shouldRestore ? 'maybe' : 'no',
                  style: TextStyle(
                    color: row.shouldRestore
                        ? scheme.tertiary
                        : scheme.error,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
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

// =========================================================================
// Section 5: State machine diagram (idle -> shown -> closed/<reason>).
// =========================================================================

class _StateMachineSection extends StatelessWidget {
  const _StateMachineSection({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 5: State Machine ===');
    final nodes = <_StateNode>[
      _StateNode(
        title: 'idle',
        subtitle: 'No banner queued.',
        color: scheme.outline,
        icon: Icons.power_settings_new,
      ),
      _StateNode(
        title: 'shown',
        subtitle: 'Banner visible. Future not yet completed.',
        color: scheme.primary,
        icon: Icons.visibility_outlined,
      ),
      _StateNode(
        title: 'closed',
        subtitle: 'Future resolved with one of six reasons.',
        color: scheme.tertiary,
        icon: Icons.check_circle_outline,
      ),
    ];

    final reasons = <_ReasonNode>[
      _ReasonNode(name: 'action', color: const Color(0xFF06D6A0)),
      _ReasonNode(name: 'dismiss', color: const Color(0xFF5E5CE6)),
      _ReasonNode(name: 'hide', color: const Color(0xFF2A9D8F)),
      _ReasonNode(name: 'remove', color: const Color(0xFFE76F51)),
      _ReasonNode(name: 'swipe', color: const Color(0xFFF4A261)),
      _ReasonNode(name: 'timeout', color: const Color(0xFF118AB2)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 5,
          title: 'State Machine',
          subtitle:
              'idle -> shown -> closed/<reason>. Six exits from a single visible state.',
          scheme: scheme,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: _StateNodeChip(node: nodes[0])),
                  const _ArrowChip(label: 'show'),
                  Expanded(child: _StateNodeChip(node: nodes[1])),
                  const _ArrowChip(label: 'close'),
                  Expanded(child: _StateNodeChip(node: nodes[2])),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Six closed substates',
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        for (final r in reasons)
                          _ReasonStateChip(node: r, scheme: scheme),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _DiagramLegend(scheme: scheme),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReasonNode {
  const _ReasonNode({required this.name, required this.color});

  final String name;
  final Color color;
}

class _StateNodeChip extends StatelessWidget {
  const _StateNodeChip({required this.node});

  final _StateNode node;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: node.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: node.color.withValues(alpha: 0.40)),
      ),
      child: Column(
        children: <Widget>[
          Icon(node.icon, color: node.color, size: 28),
          const SizedBox(height: 8),
          Text(
            node.title,
            style: TextStyle(
              color: node.color,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            node.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: node.color,
              fontSize: 11,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowChip extends StatelessWidget {
  const _ArrowChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.east, color: scheme.onSurfaceVariant),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReasonStateChip extends StatelessWidget {
  const _ReasonStateChip({required this.node, required this.scheme});

  final _ReasonNode node;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: node.color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: node.color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: node.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'closed/${node.name}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: node.color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagramLegend extends StatelessWidget {
  const _DiagramLegend({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.info_outline, color: scheme.onSurfaceVariant, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'A MaterialBanner can only transition out of shown once. The reason value is final once delivered.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// Section 6: Recipes (snackbar vs banner, action vs dismiss).
// =========================================================================

class _RecipesSection extends StatelessWidget {
  const _RecipesSection({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 6: Recipes ===');
    final recipes = <_Recipe>[
      _Recipe(
        headline: 'Pick MaterialBanner when persistence matters',
        body:
            'SnackBar is ephemeral and lives near the bottom edge. MaterialBanner stays at the top of the body until the user reacts. Choose it when the message must remain visible across navigation.',
        icon: Icons.push_pin_outlined,
        tone: scheme.primary,
      ),
      _Recipe(
        headline: 'Pick SnackBar for low-stakes confirmations',
        body:
            'Status confirmations that do not require a response belong in SnackBar. Use MaterialBanner only when the user can act on the message.',
        icon: Icons.bolt_outlined,
        tone: scheme.tertiary,
      ),
      _Recipe(
        headline: 'Branch on reason == action immediately',
        body:
            'When the awaited reason is action, run the workflow the user asked for. For every other reason, treat the banner as silently closed.',
        icon: Icons.alt_route,
        tone: scheme.secondary,
      ),
      _Recipe(
        headline: 'Never restore on swipe or remove',
        body:
            'Swipe and remove are explicit signals to stop nagging. Restoring would feel like a fight with the user.',
        icon: Icons.do_not_disturb_on_outlined,
        tone: scheme.error,
      ),
      _Recipe(
        headline: 'Use hide + timeout for transient hints',
        body:
            'When the underlying state is fluid, hide allows the banner to be shown again later without losing context.',
        icon: Icons.timelapse_outlined,
        tone: const Color(0xFF118AB2),
      ),
      _Recipe(
        headline: 'Log the reason for telemetry',
        body:
            'Aggregating reason counts surfaces UX issues. High timeout counts often indicate the message is being ignored.',
        icon: Icons.analytics_outlined,
        tone: const Color(0xFF06D6A0),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 6,
          title: 'Recipes',
          subtitle:
              'Tactical guidance for choosing MaterialBanner and handling each reason.',
          scheme: scheme,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: <Widget>[
            for (final recipe in recipes)
              SizedBox(
                width: 320,
                child: _RecipeCard(recipe: recipe, scheme: scheme),
              ),
          ],
        ),
        const SizedBox(height: 18),
        _CodeBlock(scheme: scheme),
      ],
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.recipe, required this.scheme});

  final _Recipe recipe;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: recipe.tone.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: recipe.tone.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(recipe.icon, color: recipe.tone),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  recipe.headline,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            recipe.body,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const String snippet =
        '// Awaiting the close future\n'
        'final controller = ScaffoldMessenger.of(context)\n'
        '    .showMaterialBanner(banner);\n'
        '\n'
        'final reason = await controller.closed;\n'
        'switch (reason) {\n'
        '  case MaterialBannerClosedReason.action:\n'
        '    runSync();\n'
        '    break;\n'
        '  case MaterialBannerClosedReason.swipe:\n'
        '  case MaterialBannerClosedReason.remove:\n'
        '    markSuppressed();\n'
        '    break;\n'
        '  case MaterialBannerClosedReason.dismiss:\n'
        '  case MaterialBannerClosedReason.hide:\n'
        '  case MaterialBannerClosedReason.timeout:\n'
        '    // silent close, no follow-up needed\n'
        '    break;\n'
        '}';
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B22),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.code, color: scheme.tertiary, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Branching on the close future',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            snippet,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFA7E2C8),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// Section 7: Glossary + final summary.
// =========================================================================

class _GlossarySection extends StatelessWidget {
  const _GlossarySection({required this.scheme});

  final ColorScheme scheme;

  static const List<_GlossaryEntry> _entries = <_GlossaryEntry>[
    _GlossaryEntry(
      term: 'MaterialBanner',
      definition:
          'A persistent message displayed at the top of the body with up to two actions.',
    ),
    _GlossaryEntry(
      term: 'ScaffoldMessenger',
      definition:
          'Coordinates banners and snackbars across descendant Scaffolds.',
    ),
    _GlossaryEntry(
      term: 'showMaterialBanner',
      definition:
          'Returns a controller whose closed future resolves to a MaterialBannerClosedReason.',
    ),
    _GlossaryEntry(
      term: 'close future',
      definition:
          'The Future<MaterialBannerClosedReason> exposed by the controller.',
    ),
    _GlossaryEntry(
      term: 'forceActionsBelow',
      definition:
          'Stacks actions on a new line when the content row is narrow.',
    ),
    _GlossaryEntry(
      term: 'dividerColor',
      definition:
          'The hairline drawn beneath the banner; transparent hides it.',
    ),
    _GlossaryEntry(
      term: 'OverflowBarAlignment',
      definition:
          'Used with overflowAlignment to position wrapped actions.',
    ),
    _GlossaryEntry(
      term: 'reason.action',
      definition:
          'User tapped an action button. Positive engagement signal.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print('=== Section 7: Glossary and Summary ===');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 7,
          title: 'Glossary and Summary',
          subtitle: 'Vocabulary and the takeaway card.',
          scheme: scheme,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < _entries.length; i++) ...<Widget>[
                _GlossaryRow(entry: _entries[i], scheme: scheme),
                if (i < _entries.length - 1)
                  Divider(
                    color: scheme.outlineVariant,
                    height: 18,
                    thickness: 0.6,
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        _FinalSummaryCard(scheme: scheme),
      ],
    );
  }
}

class _GlossaryRow extends StatelessWidget {
  const _GlossaryRow({required this.entry, required this.scheme});

  final _GlossaryEntry entry;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            entry.term,
            style: TextStyle(
              color: scheme.primary,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            entry.definition,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _FinalSummaryCard extends StatelessWidget {
  const _FinalSummaryCard({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primaryContainer,
            scheme.tertiaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.flag, color: scheme.onPrimaryContainer),
              const SizedBox(width: 8),
              Text(
                'Takeaway',
                style: TextStyle(
                  color: scheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'MaterialBannerClosedReason is small but consequential: it is the single value that captures user intent (or its absence) after a banner closes. Branch on action for engagement, treat swipe and remove as do-not-restore signals, and use dismiss, hide, and timeout as silent closures.',
            style: TextStyle(
              color: scheme.onPrimaryContainer,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (final v in MaterialBannerClosedReason.values)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: scheme.onPrimaryContainer.withValues(alpha: 0.40),
                    ),
                  ),
                  child: Text(
                    v.name,
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// Shared bits.
// =========================================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.scheme,
  });

  final int number;
  final String title;
  final String subtitle;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '=== Section $number: $title ===',
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
