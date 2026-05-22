// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for NavigationDestinationLabelBehavior.
//
// Design plan:
//   The Material 3 NavigationBar exposes three label-display strategies via
//   the NavigationDestinationLabelBehavior enum: alwaysShow, alwaysHide and
//   onlyShowSelected. This demo unpacks each value with hands-on specimens
//   instead of merely listing API entries.
//
//   The narrative is structured as eight numbered sections (plus a gradient
//   header banner and a closing glossary panel):
//     1. Concept primer - enum surface area and intent.
//     2. Per-value specimens - one labelled NavigationBar per enum value.
//     3. Side-by-side comparison - all three behaviours in a fixed-height
//        frame, sharing the same destination list.
//     4. NavigationDestination anatomy - icon, selectedIcon, label, tooltip.
//     5. App shell recipes - mobile bottom nav, tablet rail comparison with
//        NavigationRailLabelType, responsive switching ideas.
//     6. Accessibility notes - tooltips, semantics, label visibility tactics.
//     7. Decision matrix - when to pick each behaviour.
//     8. Code recipe gallery - copy-ready snippets and review checklist.
//   The file closes with a glossary and a calm summary chip strip.
//   No emojis are used anywhere in the file.
import 'package:flutter/material.dart';

void main() => runApp(const NavigationDestinationLabelBehaviorDemoApp());

// ============================================================================
// Root widget. Stateless. Hosts MaterialApp + Scaffold + SingleChildScrollView.
// ============================================================================
class NavigationDestinationLabelBehaviorDemoApp extends StatelessWidget {
  const NavigationDestinationLabelBehaviorDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('NavigationDestinationLabelBehavior deep demo: booting');
    print('Enum values covered: alwaysShow, alwaysHide, onlyShowSelected');

    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3949AB),
      brightness: Brightness.light,
    );

    final ThemeData theme = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      navigationBarTheme: NavigationBarThemeData(
        height: 72.0,
        indicatorColor: scheme.secondaryContainer,
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          final bool selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
            fontSize: 12.0,
          );
        }),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NavigationDestinationLabelBehavior Demo',
      theme: theme,
      home: Scaffold(
        backgroundColor: scheme.surfaceContainerLowest,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _GradientHeaderBanner(),
              const SizedBox(height: 28.0),
              _SectionTitle(
                number: 1,
                title: 'Concept primer',
                subtitle:
                    'What NavigationDestinationLabelBehavior actually controls.',
                scheme: scheme,
              ),
              _Section1ConceptPrimer(scheme: scheme),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 2,
                title: 'Per-value specimens',
                subtitle:
                    'One labelled NavigationBar instance for each enum value.',
                scheme: scheme,
              ),
              _Section2PerValueSpecimens(scheme: scheme),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 3,
                title: 'Side-by-side comparison',
                subtitle:
                    'Three identical destination lists, three different '
                    'behaviours, one frame.',
                scheme: scheme,
              ),
              _Section3SideBySide(scheme: scheme),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 4,
                title: 'NavigationDestination anatomy',
                subtitle:
                    'How each field interacts with the chosen label behaviour.',
                scheme: scheme,
              ),
              _Section4DestinationAnatomy(scheme: scheme),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 5,
                title: 'App shell recipes',
                subtitle:
                    'Mobile bottom nav, tablet rail and a responsive sketch.',
                scheme: scheme,
              ),
              _Section5AppShellRecipes(scheme: scheme),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 6,
                title: 'Accessibility notes',
                subtitle:
                    'Tooltips, semantics and label visibility trade-offs.',
                scheme: scheme,
              ),
              _Section6Accessibility(scheme: scheme),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 7,
                title: 'Decision matrix',
                subtitle:
                    'Quick rules of thumb for picking the right behaviour.',
                scheme: scheme,
              ),
              _Section7DecisionMatrix(scheme: scheme),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 8,
                title: 'Code recipe gallery',
                subtitle:
                    'Drop-in snippets and a short review checklist.',
                scheme: scheme,
              ),
              _Section8RecipeGallery(scheme: scheme),
              const SizedBox(height: 36.0),
              _GlossaryAndRecipesFooter(scheme: scheme),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Shared destination list used across many specimens.
// ============================================================================
List<NavigationDestination> _baseDestinations() {
  return const <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: 'Dashboard',
      tooltip: 'Open the home dashboard',
    ),
    NavigationDestination(
      icon: Icon(Icons.assignment_outlined),
      selectedIcon: Icon(Icons.assignment),
      label: 'Tasks',
      tooltip: 'Browse and triage tasks',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_bubble_outline),
      selectedIcon: Icon(Icons.chat_bubble),
      label: 'Messages',
      tooltip: 'Direct messages and channels',
    ),
    NavigationDestination(
      icon: Icon(Icons.account_circle_outlined),
      selectedIcon: Icon(Icons.account_circle),
      label: 'Profile',
      tooltip: 'Your profile and preferences',
    ),
  ];
}

// ============================================================================
// Header banner with a gradient and a label-behavior cheat strip.
// ============================================================================
class _GradientHeaderBanner extends StatelessWidget {
  const _GradientHeaderBanner();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 26.0, 24.0, 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
            scheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.32),
            blurRadius: 28.0,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.45),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.navigation,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'NavigationDestinationLabelBehavior',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Material 3 enum  -  controls labels under '
                      'NavigationBar destinations',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: const <Widget>[
              _ValueChip(
                label: 'alwaysShow',
                icon: Icons.visibility_outlined,
              ),
              _ValueChip(
                label: 'alwaysHide',
                icon: Icons.visibility_off_outlined,
              ),
              _ValueChip(
                label: 'onlyShowSelected',
                icon: Icons.adjust_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ValueChip extends StatelessWidget {
  const _ValueChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.45),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16.0, color: Colors.white),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Reusable section title.
// ============================================================================
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
    // The print call doubles as a section delimiter when the AST host streams
    // stdout into the visual report.
    print('=== Section $number: $title ===');
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  color: scheme.onPrimaryContainer,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 13.0,
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

// ============================================================================
// Card shell used by many sections to keep the visual rhythm even.
// ============================================================================
class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.background,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background ?? scheme.surface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: scheme.outlineVariant,
          width: 1.0,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.06),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================================
// SECTION 1 - Concept primer.
// ============================================================================
class _Section1ConceptPrimer extends StatelessWidget {
  const _Section1ConceptPrimer({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'A small enum with outsized UX impact',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'NavigationDestinationLabelBehavior is read by NavigationBar to '
            'decide whether the text labels under each destination are '
            'visible, hidden or only shown for the active destination. The '
            'enum has exactly three values and no other state. The widget '
            'composes the choice with its own selectedIndex, theme tokens '
            'and (optionally) a NavigationBarTheme.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: _ConceptCard(
                  scheme: scheme,
                  icon: Icons.visibility,
                  title: 'alwaysShow',
                  description:
                      'Render every label all of the time. Great for nav '
                      'bars with short labels and users who scan text.',
                  accent: scheme.primary,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: _ConceptCard(
                  scheme: scheme,
                  icon: Icons.visibility_off,
                  title: 'alwaysHide',
                  description:
                      'Never render labels. Tooltips remain reachable via '
                      'long-press; treat icons as the sole affordance.',
                  accent: scheme.tertiary,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: _ConceptCard(
                  scheme: scheme,
                  icon: Icons.adjust,
                  title: 'onlyShowSelected',
                  description:
                      'Show only the active destination label. Reduces '
                      'visual noise yet keeps a written cue for context.',
                  accent: scheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline,
                    color: scheme.primary, size: 22.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Heuristic: alwaysShow is the safe default for first-time '
                    'users; onlyShowSelected is a sensible compromise when '
                    'screen width is tight; alwaysHide is reserved for '
                    'expert-only experiences where the iconography alone is '
                    'already well learned.',
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 12.5,
                      height: 1.4,
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
}

class _ConceptCard extends StatelessWidget {
  const _ConceptCard({
    required this.scheme,
    required this.icon,
    required this.title,
    required this.description,
    required this.accent,
  });

  final ColorScheme scheme;
  final IconData icon;
  final String title;
  final String description;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: accent.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: accent, size: 22.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
              color: accent,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            description,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.0,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 2 - Per-value specimens.
// ============================================================================
class _Section2PerValueSpecimens extends StatelessWidget {
  const _Section2PerValueSpecimens({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _SpecimenFrame(
          scheme: scheme,
          title: 'alwaysShow',
          summary:
              'Labels visible under every destination, regardless of which '
              'one is selected. The selected destination uses the bolder '
              'label style from the NavigationBarTheme.',
          accent: scheme.primary,
          behavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: 0,
        ),
        const SizedBox(height: 16.0),
        _SpecimenFrame(
          scheme: scheme,
          title: 'alwaysHide',
          summary:
              'No labels render at all. The bar collapses to a row of icon '
              'targets; rely on tooltips and well-known glyphs.',
          accent: scheme.tertiary,
          behavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: 1,
        ),
        const SizedBox(height: 16.0),
        _SpecimenFrame(
          scheme: scheme,
          title: 'onlyShowSelected',
          summary:
              'Only the active destination shows its label. Unselected '
              'destinations are icon-only. This is the Material 3 default '
              'in some templates and a strong compromise.',
          accent: scheme.secondary,
          behavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: 2,
        ),
      ],
    );
  }
}

class _SpecimenFrame extends StatelessWidget {
  const _SpecimenFrame({
    required this.scheme,
    required this.title,
    required this.summary,
    required this.accent,
    required this.behavior,
    required this.selectedIndex,
  });

  final ColorScheme scheme;
  final String title;
  final String summary;
  final Color accent;
  final NavigationDestinationLabelBehavior behavior;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    print('Specimen: $title (selectedIndex=$selectedIndex)');
    return _SurfaceCard(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: accent,
                    fontSize: 12.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                'selectedIndex: $selectedIndex',
                style: TextStyle(
                  fontSize: 12.0,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            summary,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14.0),
          // The actual NavigationBar specimen. onDestinationSelected is null
          // because this is a static AST render with no interactivity.
          Container(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: scheme.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: null,
              labelBehavior: behavior,
              destinations: _baseDestinations(),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 3 - Side-by-side comparison frame.
// ============================================================================
class _Section3SideBySide extends StatelessWidget {
  const _Section3SideBySide({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Three bars stacked vertically share the same destinations and '
            'the same selectedIndex (1, "Tasks"). Only labelBehavior differs.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16.0),
          _CompareRow(
            scheme: scheme,
            label: 'alwaysShow',
            color: scheme.primary,
            behavior: NavigationDestinationLabelBehavior.alwaysShow,
          ),
          const SizedBox(height: 12.0),
          _CompareRow(
            scheme: scheme,
            label: 'alwaysHide',
            color: scheme.tertiary,
            behavior: NavigationDestinationLabelBehavior.alwaysHide,
          ),
          const SizedBox(height: 12.0),
          _CompareRow(
            scheme: scheme,
            label: 'onlyShowSelected',
            color: scheme.secondary,
            behavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.tertiaryContainer.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: scheme.tertiary.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.compare_arrows,
                    color: scheme.tertiary, size: 22.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Notice how the bar height stays identical across all '
                    'three values: NavigationBar reserves room for labels '
                    'even when they are hidden, so swapping between values '
                    'will not jiggle the layout. This is by design and is '
                    'why labelBehavior is safe to flip at runtime.',
                    style: TextStyle(
                      color: scheme.onTertiaryContainer,
                      fontSize: 12.5,
                      height: 1.4,
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
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.scheme,
    required this.label,
    required this.color,
    required this.behavior,
  });

  final ColorScheme scheme;
  final String label;
  final Color color;
  final NavigationDestinationLabelBehavior behavior;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 4.0, vertical: 2.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.label_outline, color: color, size: 16.0),
                const SizedBox(width: 6.0),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: NavigationBar(
              selectedIndex: 1,
              onDestinationSelected: null,
              labelBehavior: behavior,
              destinations: _baseDestinations(),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 4 - NavigationDestination anatomy.
// ============================================================================
class _Section4DestinationAnatomy extends StatelessWidget {
  const _Section4DestinationAnatomy({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'A NavigationDestination has four user-facing inputs: icon, '
            'selectedIcon, label and tooltip. The labelBehavior on the '
            'enclosing NavigationBar decides which of those are visible '
            'when the bar is at rest.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16.0),
          _AnatomyRow(
            scheme: scheme,
            label: 'icon',
            description:
                'Default outline glyph; shown when the destination is not '
                'selected. Use the outlined Material variant for clarity.',
            iconWidget: const Icon(Icons.chat_bubble_outline),
            color: scheme.primary,
          ),
          _AnatomyRow(
            scheme: scheme,
            label: 'selectedIcon',
            description:
                'Filled variant rendered when the destination is active. '
                'If omitted, the icon field is reused.',
            iconWidget: const Icon(Icons.chat_bubble),
            color: scheme.secondary,
          ),
          _AnatomyRow(
            scheme: scheme,
            label: 'label',
            description:
                'The visible string. With alwaysHide it never paints; with '
                'onlyShowSelected it paints only for the active index.',
            iconWidget:
                Icon(Icons.label_important_outline, color: scheme.tertiary),
            color: scheme.tertiary,
          ),
          _AnatomyRow(
            scheme: scheme,
            label: 'tooltip',
            description:
                'Long-press hint. Critical accessibility hook for hidden '
                'labels: pair it with a meaningful label string.',
            iconWidget: Icon(Icons.info_outline, color: scheme.primary),
            color: scheme.primary,
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Live preview with all four fields:',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 10.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: NavigationBar(
                    selectedIndex: 2,
                    onDestinationSelected: null,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysShow,
                    destinations: const <NavigationDestination>[
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: 'Home',
                        tooltip: 'Go to home',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.search_outlined),
                        selectedIcon: Icon(Icons.search),
                        label: 'Search',
                        tooltip: 'Search content',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.notifications_none),
                        selectedIcon: Icon(Icons.notifications),
                        label: 'Inbox',
                        tooltip: 'Notifications and alerts',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: 'Settings',
                        tooltip: 'App settings',
                      ),
                    ],
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

class _AnatomyRow extends StatelessWidget {
  const _AnatomyRow({
    required this.scheme,
    required this.label,
    required this.description,
    required this.iconWidget,
    required this.color,
  });

  final ColorScheme scheme;
  final String label;
  final String description;
  final Widget iconWidget;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 42.0,
            height: 42.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: IconTheme(
              data: IconThemeData(color: color, size: 22.0),
              child: iconWidget,
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
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12.0,
                    height: 1.35,
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

// ============================================================================
// SECTION 5 - App shell recipes.
// ============================================================================
class _Section5AppShellRecipes extends StatelessWidget {
  const _Section5AppShellRecipes({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _MobileShellRecipe(scheme: scheme),
        const SizedBox(height: 16.0),
        _TabletShellRecipe(scheme: scheme),
        const SizedBox(height: 16.0),
        _ResponsiveSwitchRecipe(scheme: scheme),
      ],
    );
  }
}

class _MobileShellRecipe extends StatelessWidget {
  const _MobileShellRecipe({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeHeader(
            icon: Icons.phone_iphone,
            title: 'Mobile bottom navigation',
            scheme: scheme,
          ),
          const SizedBox(height: 12.0),
          Text(
            'A typical mobile shell uses alwaysShow for first-time users and '
            'keeps the bar pinned to the bottom of the Scaffold. The faux '
            'phone frame below contains a tiny preview of body content over '
            'the live NavigationBar.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14.0),
          Center(
            child: Container(
              width: 260.0,
              height: 480.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.0),
                child: Container(
                  color: scheme.surfaceContainerLow,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 28.0,
                        color: scheme.primary,
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                            color: scheme.onPrimary,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _FakeListTile(scheme: scheme, title: 'Today'),
                              _FakeListTile(
                                  scheme: scheme, title: 'This week'),
                              _FakeListTile(scheme: scheme, title: 'Pinned'),
                              _FakeListTile(scheme: scheme, title: 'Recent'),
                              _FakeListTile(
                                  scheme: scheme, title: 'Suggestions'),
                              _FakeListTile(scheme: scheme, title: 'Notes'),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      NavigationBar(
                        height: 64.0,
                        selectedIndex: 0,
                        onDestinationSelected: null,
                        labelBehavior:
                            NavigationDestinationLabelBehavior.alwaysShow,
                        destinations: _baseDestinations(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FakeListTile extends StatelessWidget {
  const _FakeListTile({required this.scheme, required this.title});

  final ColorScheme scheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.check, size: 16.0, color: scheme.primary),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(Icons.chevron_right,
              size: 16.0, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
}

class _TabletShellRecipe extends StatelessWidget {
  const _TabletShellRecipe({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeHeader(
            icon: Icons.tablet_mac,
            title: 'Tablet rail + NavigationRailLabelType',
            scheme: scheme,
          ),
          const SizedBox(height: 12.0),
          Text(
            'On wider surfaces NavigationBar is typically swapped for '
            'NavigationRail. The rail uses NavigationRailLabelType '
            '(none, selected, all) which mirrors NavigationDestinationLabel'
            'Behavior almost one-to-one. Side-by-side mappings below.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14.0),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _RailPreview(
                    title: 'none',
                    mappedTo: 'alwaysHide',
                    scheme: scheme,
                    labelType: NavigationRailLabelType.none,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: _RailPreview(
                    title: 'selected',
                    mappedTo: 'onlyShowSelected',
                    scheme: scheme,
                    labelType: NavigationRailLabelType.selected,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: _RailPreview(
                    title: 'all',
                    mappedTo: 'alwaysShow',
                    scheme: scheme,
                    labelType: NavigationRailLabelType.all,
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

class _RailPreview extends StatelessWidget {
  const _RailPreview({
    required this.title,
    required this.mappedTo,
    required this.scheme,
    required this.labelType,
  });

  final String title;
  final String mappedTo;
  final ColorScheme scheme;
  final NavigationRailLabelType labelType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              color: scheme.primary,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'maps to $mappedTo',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 11.0,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 220.0,
            child: NavigationRail(
              selectedIndex: 1,
              onDestinationSelected: null,
              labelType: labelType,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment),
                  label: Text('Tasks'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.account_circle_outlined),
                  selectedIcon: Icon(Icons.account_circle),
                  label: Text('Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveSwitchRecipe extends StatelessWidget {
  const _ResponsiveSwitchRecipe({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _RecipeHeader(
            icon: Icons.devices,
            title: 'Responsive switching idea',
            scheme: scheme,
          ),
          const SizedBox(height: 10.0),
          Text(
            'A common pattern is to pick the label behaviour from a '
            'breakpoint and a user preference. The sketch below pretends '
            'to display three breakpoints; the code recipe in section 8 '
            'shows the real selection function.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              Expanded(
                child: _BreakpointPill(
                  scheme: scheme,
                  title: 'compact',
                  body: 'width < 600\nonlyShowSelected',
                  icon: Icons.smartphone,
                  accent: scheme.primary,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _BreakpointPill(
                  scheme: scheme,
                  title: 'medium',
                  body: 'width 600 - 840\nalwaysShow',
                  icon: Icons.tablet_android,
                  accent: scheme.secondary,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _BreakpointPill(
                  scheme: scheme,
                  title: 'expanded',
                  body: 'width > 840\nrail with selected',
                  icon: Icons.desktop_windows_outlined,
                  accent: scheme.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BreakpointPill extends StatelessWidget {
  const _BreakpointPill({
    required this.scheme,
    required this.title,
    required this.body,
    required this.icon,
    required this.accent,
  });

  final ColorScheme scheme;
  final String title;
  final String body;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: accent, size: 26.0),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            body,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeHeader extends StatelessWidget {
  const _RecipeHeader({
    required this.icon,
    required this.title,
    required this.scheme,
  });

  final IconData icon;
  final String title;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: scheme.onPrimaryContainer, size: 22.0),
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 6 - Accessibility notes.
// ============================================================================
class _Section6Accessibility extends StatelessWidget {
  const _Section6Accessibility({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_A11yNote> notes = <_A11yNote>[
      const _A11yNote(
        icon: Icons.record_voice_over,
        title: 'Screen readers always announce the label',
        body:
            'Regardless of labelBehavior, NavigationDestination exposes the '
            'label string through Semantics. Hiding it visually does not '
            'hide it from TalkBack or VoiceOver.',
        accentRole: _A11yAccent.primary,
      ),
      const _A11yNote(
        icon: Icons.touch_app,
        title: 'Tooltips back up hidden labels',
        body:
            'When alwaysHide is in use, the tooltip is the only on-screen '
            'recovery for forgotten icons. Always provide a tooltip that '
            'matches or expands the label.',
        accentRole: _A11yAccent.secondary,
      ),
      const _A11yNote(
        icon: Icons.accessibility_new,
        title: 'Touch targets stay 48 dp',
        body:
            'The bar height is unaffected by labelBehavior, so touch '
            'targets remain large. The label area is empty rather than '
            'collapsed.',
        accentRole: _A11yAccent.tertiary,
      ),
      const _A11yNote(
        icon: Icons.translate,
        title: 'Avoid alwaysHide for long-tail languages',
        body:
            'Languages that lack established iconography or that require '
            'context to disambiguate verbs do worse with hidden labels. '
            'Default to alwaysShow until you measure.',
        accentRole: _A11yAccent.error,
      ),
      const _A11yNote(
        icon: Icons.contrast,
        title: 'Selected vs unselected label contrast',
        body:
            'The NavigationBarTheme.labelTextStyle should yield WCAG AA '
            'contrast for both states. Test with a colour-vision simulator '
            'before shipping onlyShowSelected.',
        accentRole: _A11yAccent.primary,
      ),
    ];

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final _A11yNote note in notes) ...<Widget>[
            note,
            const SizedBox(height: 10.0),
          ],
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.errorContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: scheme.error.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.warning_amber_rounded,
                    color: scheme.error, size: 22.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Anti-pattern: setting label to an empty string just to '
                    'hide it. Use labelBehavior.alwaysHide instead so the '
                    'label remains available for assistive technology.',
                    style: TextStyle(
                      color: scheme.onErrorContainer,
                      fontSize: 12.5,
                      height: 1.4,
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
}

enum _A11yAccent { primary, secondary, tertiary, error }

class _A11yNote extends StatelessWidget {
  const _A11yNote({
    required this.icon,
    required this.title,
    required this.body,
    required this.accentRole,
  });

  final IconData icon;
  final String title;
  final String body;
  final _A11yAccent accentRole;

  Color _resolve(ColorScheme scheme) {
    switch (accentRole) {
      case _A11yAccent.primary:
        return scheme.primary;
      case _A11yAccent.secondary:
        return scheme.secondary;
      case _A11yAccent.tertiary:
        return scheme.tertiary;
      case _A11yAccent.error:
        return scheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color accent = _resolve(scheme);
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: accent, size: 22.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
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
  }
}

// ============================================================================
// SECTION 7 - Decision matrix.
// ============================================================================
class _Section7DecisionMatrix extends StatelessWidget {
  const _Section7DecisionMatrix({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_MatrixRow> rows = <_MatrixRow>[
      const _MatrixRow(
        scenario: 'Consumer app, broad audience',
        showLabel: 'YES',
        hideLabel: 'no',
        onlyLabel: 'ok',
        recommendation: 'alwaysShow',
      ),
      const _MatrixRow(
        scenario: 'Power-user tooling, narrow audience',
        showLabel: 'ok',
        hideLabel: 'YES',
        onlyLabel: 'ok',
        recommendation: 'alwaysHide',
      ),
      const _MatrixRow(
        scenario: 'Limited horizontal space (5+ destinations)',
        showLabel: 'no',
        hideLabel: 'ok',
        onlyLabel: 'YES',
        recommendation: 'onlyShowSelected',
      ),
      const _MatrixRow(
        scenario: 'Mixed languages (long German words)',
        showLabel: 'ok',
        hideLabel: 'no',
        onlyLabel: 'YES',
        recommendation: 'onlyShowSelected',
      ),
      const _MatrixRow(
        scenario: 'Tutorial mode for new users',
        showLabel: 'YES',
        hideLabel: 'no',
        onlyLabel: 'no',
        recommendation: 'alwaysShow',
      ),
      const _MatrixRow(
        scenario: 'Pure-iconography enterprise dashboard',
        showLabel: 'no',
        hideLabel: 'YES',
        onlyLabel: 'ok',
        recommendation: 'alwaysHide',
      ),
    ];

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Read top-down: pick the row that matches your context, then '
            'follow the highlighted column. The right-hand recommendation '
            'is the value to set on NavigationBar.labelBehavior.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12.0),
          _MatrixHeader(scheme: scheme),
          const SizedBox(height: 6.0),
          for (final _MatrixRow row in rows) ...<Widget>[
            row,
            const SizedBox(height: 4.0),
          ],
        ],
      ),
    );
  }
}

class _MatrixHeader extends StatelessWidget {
  const _MatrixHeader({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              'Scenario',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'show',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'hide',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'selected',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'pick',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({
    required this.scenario,
    required this.showLabel,
    required this.hideLabel,
    required this.onlyLabel,
    required this.recommendation,
  });

  final String scenario;
  final String showLabel;
  final String hideLabel;
  final String onlyLabel;
  final String recommendation;

  Color _cellColor(String value, ColorScheme scheme) {
    switch (value) {
      case 'YES':
        return scheme.primary.withValues(alpha: 0.22);
      case 'ok':
        return scheme.secondary.withValues(alpha: 0.12);
      case 'no':
      default:
        return scheme.surfaceContainerHighest;
    }
  }

  Color _cellText(String value, ColorScheme scheme) {
    switch (value) {
      case 'YES':
        return scheme.primary;
      case 'ok':
        return scheme.onSurface;
      case 'no':
      default:
        return scheme.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              scenario,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: _MatrixCell(
              text: showLabel,
              background: _cellColor(showLabel, scheme),
              textColor: _cellText(showLabel, scheme),
            ),
          ),
          Expanded(
            child: _MatrixCell(
              text: hideLabel,
              background: _cellColor(hideLabel, scheme),
              textColor: _cellText(hideLabel, scheme),
            ),
          ),
          Expanded(
            child: _MatrixCell(
              text: onlyLabel,
              background: _cellColor(onlyLabel, scheme),
              textColor: _cellText(onlyLabel, scheme),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              padding: const EdgeInsets.symmetric(
                  horizontal: 6.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                recommendation,
                style: TextStyle(
                  color: scheme.onPrimaryContainer,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 11.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  const _MatrixCell({
    required this.text,
    required this.background,
    required this.textColor,
  });

  final String text;
  final Color background;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 11.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ============================================================================
// SECTION 8 - Code recipe gallery.
// ============================================================================
class _Section8RecipeGallery extends StatelessWidget {
  const _Section8RecipeGallery({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      background: scheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Snippets for the three behaviours plus a small responsive '
            'helper. Each snippet is intentionally minimal; drop them into '
            'a Scaffold.bottomNavigationBar slot.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14.0),
          const _CodeBlock(
            title: 'Recipe 1 - alwaysShow (default-friendly)',
            code:
                'NavigationBar(\n'
                '  selectedIndex: selectedIndex,\n'
                '  labelBehavior:\n'
                '      NavigationDestinationLabelBehavior.alwaysShow,\n'
                '  destinations: const <NavigationDestination>[\n'
                '    NavigationDestination(\n'
                '      icon: Icon(Icons.dashboard_outlined),\n'
                '      selectedIcon: Icon(Icons.dashboard),\n'
                '      label: \'Dashboard\',\n'
                '    ),\n'
                '    NavigationDestination(\n'
                '      icon: Icon(Icons.assignment_outlined),\n'
                '      selectedIcon: Icon(Icons.assignment),\n'
                '      label: \'Tasks\',\n'
                '    ),\n'
                '  ],\n'
                '  onDestinationSelected: (i) => setState(() {\n'
                '    selectedIndex = i;\n'
                '  }),\n'
                ');',
          ),
          const SizedBox(height: 12.0),
          const _CodeBlock(
            title: 'Recipe 2 - alwaysHide (expert tools)',
            code:
                'NavigationBar(\n'
                '  selectedIndex: selectedIndex,\n'
                '  labelBehavior:\n'
                '      NavigationDestinationLabelBehavior.alwaysHide,\n'
                '  destinations: const <NavigationDestination>[\n'
                '    NavigationDestination(\n'
                '      icon: Icon(Icons.bolt_outlined),\n'
                '      selectedIcon: Icon(Icons.bolt),\n'
                '      label: \'Live\',\n'
                '      tooltip: \'Live monitoring view\',\n'
                '    ),\n'
                '    NavigationDestination(\n'
                '      icon: Icon(Icons.bug_report_outlined),\n'
                '      selectedIcon: Icon(Icons.bug_report),\n'
                '      label: \'Issues\',\n'
                '      tooltip: \'Triage open issues\',\n'
                '    ),\n'
                '  ],\n'
                ');',
          ),
          const SizedBox(height: 12.0),
          const _CodeBlock(
            title: 'Recipe 3 - onlyShowSelected (compact)',
            code:
                'NavigationBar(\n'
                '  selectedIndex: selectedIndex,\n'
                '  labelBehavior: NavigationDestinationLabelBehavior\n'
                '      .onlyShowSelected,\n'
                '  destinations: destinations,\n'
                ');',
          ),
          const SizedBox(height: 12.0),
          const _CodeBlock(
            title: 'Recipe 4 - pick from width',
            code:
                'NavigationDestinationLabelBehavior pickBehavior('
                'double width) {\n'
                '  if (width < 360) {\n'
                '    return NavigationDestinationLabelBehavior\n'
                '        .onlyShowSelected;\n'
                '  }\n'
                '  if (width < 600) {\n'
                '    return NavigationDestinationLabelBehavior\n'
                '        .alwaysShow;\n'
                '  }\n'
                '  return NavigationDestinationLabelBehavior.alwaysShow;\n'
                '}',
          ),
          const SizedBox(height: 18.0),
          _Checklist(scheme: scheme),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.title, required this.code});

  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF14202B),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.terminal,
                  size: 16.0, color: scheme.tertiary),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: scheme.tertiary,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFD2E7FF),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _Checklist extends StatelessWidget {
  const _Checklist({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<String> items = <String>[
      'Set selectedIndex from a single source of truth.',
      'Provide both icon and selectedIcon when meaningful.',
      'Always set a label, even when using alwaysHide.',
      'Provide tooltip for any non-trivial glyph.',
      'Choose labelBehavior consciously, not by accident.',
      'Test with TalkBack/VoiceOver and a colour-vision simulator.',
    ];

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.checklist_rtl,
                  color: scheme.onSecondaryContainer, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Review checklist',
                style: TextStyle(
                  color: scheme.onSecondaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          for (final String item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.check_circle_outline,
                      color: scheme.onSecondaryContainer, size: 16.0),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: scheme.onSecondaryContainer,
                        fontSize: 12.5,
                        height: 1.4,
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
}

// ============================================================================
// Glossary and recipes footer.
// ============================================================================
class _GlossaryAndRecipesFooter extends StatelessWidget {
  const _GlossaryAndRecipesFooter({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_GlossaryEntry> entries = const <_GlossaryEntry>[
      _GlossaryEntry(
        term: 'NavigationBar',
        definition:
            'Material 3 bottom navigation widget. Hosts 3 to 5 '
            'NavigationDestination children and respects labelBehavior.',
      ),
      _GlossaryEntry(
        term: 'NavigationDestination',
        definition:
            'A single destination in NavigationBar. Carries icon, '
            'selectedIcon, label and tooltip.',
      ),
      _GlossaryEntry(
        term: 'NavigationDestinationLabelBehavior',
        definition:
            'Enum with three values controlling label visibility under '
            'destinations: alwaysShow, alwaysHide, onlyShowSelected.',
      ),
      _GlossaryEntry(
        term: 'NavigationBarTheme',
        definition:
            'InheritedTheme that provides default labelBehavior, '
            'indicatorColor, labelTextStyle and height.',
      ),
      _GlossaryEntry(
        term: 'NavigationRail',
        definition:
            'Vertical navigation surface used on wide screens. Uses '
            'NavigationRailLabelType, which is conceptually parallel to '
            'NavigationDestinationLabelBehavior.',
      ),
      _GlossaryEntry(
        term: 'NavigationRailLabelType',
        definition:
            'Enum with values none, selected, all; mirrors alwaysHide, '
            'onlyShowSelected and alwaysShow respectively.',
      ),
      _GlossaryEntry(
        term: 'selectedIndex',
        definition:
            'Integer pointer into the destinations list, identifying the '
            'currently active destination.',
      ),
      _GlossaryEntry(
        term: 'tooltip',
        definition:
            'Long-press hint string. Critical for accessibility when '
            'labels are hidden.',
      ),
    ];

    return _SurfaceCard(
      background: scheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book_outlined,
                  color: scheme.primary, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Glossary',
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          for (final _GlossaryEntry entry in entries) ...<Widget>[
            entry,
            const SizedBox(height: 6.0),
          ],
          const SizedBox(height: 8.0),
          Divider(color: scheme.outlineVariant),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Icon(Icons.local_library_outlined,
                  color: scheme.primary, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Final recap',
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _SummaryChip(
                label: 'Three enum values',
                icon: Icons.format_list_numbered,
                scheme: scheme,
              ),
              _SummaryChip(
                label: 'No layout shift',
                icon: Icons.straighten,
                scheme: scheme,
              ),
              _SummaryChip(
                label: 'Tooltip is mandatory',
                icon: Icons.help_outline,
                scheme: scheme,
              ),
              _SummaryChip(
                label: 'Mirrors NavigationRailLabelType',
                icon: Icons.swap_horiz,
                scheme: scheme,
              ),
              _SummaryChip(
                label: 'Default: alwaysShow',
                icon: Icons.star_outline,
                scheme: scheme,
              ),
              _SummaryChip(
                label: 'Accessible by design',
                icon: Icons.accessible,
                scheme: scheme,
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.flag_outlined,
                    color: scheme.onPrimaryContainer, size: 22.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Bottom line: pick alwaysShow unless you have a measured '
                    'reason to deviate. onlyShowSelected is a strong '
                    'compromise when horizontal space is tight or label '
                    'strings vary widely in length. Reserve alwaysHide for '
                    'expert tooling where the iconography is unambiguous.',
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontSize: 12.5,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
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
}

class _GlossaryEntry extends StatelessWidget {
  const _GlossaryEntry({required this.term, required this.definition});

  final String term;
  final String definition;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            term,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: scheme.primary,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            definition,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.icon,
    required this.scheme,
  });

  final String label;
  final IconData icon;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: scheme.onSecondaryContainer, size: 16.0),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              color: scheme.onSecondaryContainer,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
