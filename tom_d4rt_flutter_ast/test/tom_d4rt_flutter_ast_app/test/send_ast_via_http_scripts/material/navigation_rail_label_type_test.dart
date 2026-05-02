// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - NavigationRailLabelType (Material).
// Comprehensive demonstration of NavigationRailLabelType with real
// NavigationRail widgets across multiple realistic scenarios.
//
// NavigationRailLabelType controls how destination labels are presented in a
// vertical NavigationRail.  The three enum values are:
//
//   * none     — labels are never shown next to icons (icons only).
//   * selected — only the selected destination shows its label inline.
//   * all      — every destination shows its label, regardless of selection.
//
// In addition, when the rail is `extended: true`, labels are always shown
// horizontally next to the icon, which effectively overrides labelType.
//
// This deep-demo file walks through each value with side-by-side rails, lets
// the user toggle the enum live via a SegmentedButton, demonstrates the
// extended rail, crosses labelType with groupAlignment, illustrates theming
// via NavigationRailTheme/NavigationRailThemeData, and finally shows compact
// vs comfortable density via minWidth / minExtendedWidth.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== NavigationRailLabelType Deep Demo ===');
  print('values: ${NavigationRailLabelType.values.length}');
  for (final v in NavigationRailLabelType.values) {
    print('  ${v.index}: ${v.name}');
  }

  // ==========================================================================
  // Shared destinations used by most rails.  Keeping them in one place ensures
  // the visuals stay consistent across sections so visitors compare the
  // labelType behaviour, not the destination set.
  // ==========================================================================

  const sharedDestinations = <NavigationRailDestination>[
    NavigationRailDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: Text('Overview'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.inbox_outlined),
      selectedIcon: Icon(Icons.inbox),
      label: Text('Inbox'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.task_alt_outlined),
      selectedIcon: Icon(Icons.task_alt),
      label: Text('Tasks'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.calendar_today_outlined),
      selectedIcon: Icon(Icons.calendar_today),
      label: Text('Calendar'),
    ),
  ];

  const sharedLabels = ['Overview', 'Inbox', 'Tasks', 'Calendar'];
  const sharedIcons = [
    Icons.dashboard,
    Icons.inbox,
    Icons.task_alt,
    Icons.calendar_today,
  ];

  // ==========================================================================
  // Helpers
  // ==========================================================================

  Widget chip(String label, Color colour) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget sectionHeader({
    required String number,
    required String title,
    required String subtitle,
    required Color accent,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
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
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget caption(String text, Color colour, Color textColour) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColour.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: textColour),
      ),
    );
  }

  Widget bodyContent({
    required String title,
    required IconData icon,
    required Color accent,
    required Color background,
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withOpacity(0.4)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: accent),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: accent.withOpacity(0.85),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================================================
  // Section 1 — All three values side by side.
  //
  // We render three separate rails using the three NavigationRailLabelType
  // values.  Each rail manages its own selectedIndex via StatefulBuilder, so
  // taps cause the rail to rebuild and you can see the label behaviour live.
  // ==========================================================================

  Widget railFrame({
    required String title,
    required Color frameColour,
    required Color bodyColour,
    required Color accent,
    required NavigationRailLabelType labelType,
    required int initialIndex,
  }) {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        var idx = initialIndex;
        return _LocalRailFrame(
          title: title,
          frameColour: frameColour,
          bodyColour: bodyColour,
          accent: accent,
          getIndex: () => idx,
          setIndex: (n) => setLocal(() => idx = n),
          labelType: labelType,
          extended: false,
          destinations: sharedDestinations,
          labels: sharedLabels,
          icons: sharedIcons,
        );
      },
    );
  }

  // ==========================================================================
  // Section 2 — Interactive toggle.
  //
  // A single rail rebuilds live when the user changes the labelType through a
  // SegmentedButton above it.  Demonstrates how trivial it is to flip
  // behaviour by changing one enum.
  // ==========================================================================

  Widget interactiveToggleSection() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        var labelType = NavigationRailLabelType.selected;
        var idx = 1;

        return _LocalToggle(
          accent: const Color(0xFF6A1B9A),
          getLabelType: () => labelType,
          setLabelType: (t) => setLocal(() => labelType = t),
          getIndex: () => idx,
          setIndex: (n) => setLocal(() => idx = n),
          destinations: sharedDestinations,
          labels: sharedLabels,
          icons: sharedIcons,
        );
      },
    );
  }

  // ==========================================================================
  // Section 3 — Extended rail.
  //
  // When `extended: true`, the rail expands horizontally, the label is
  // displayed inline next to the icon, and the configured labelType is
  // effectively ignored (Flutter even asserts that labelType must be `none`
  // when extended is true).  This section demonstrates that explicitly.
  // ==========================================================================

  Widget extendedRailSection() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        var idx = 0;
        var extended = true;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'extended:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF004D40),
                  ),
                ),
                const SizedBox(width: 12),
                Switch(
                  value: extended,
                  activeColor: const Color(0xFF00897B),
                  onChanged: (v) => setLocal(() => extended = v),
                ),
                const SizedBox(width: 12),
                Text(
                  extended ? 'expanded' : 'collapsed',
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF00695C),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF26A69A)),
              ),
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 320,
                child: Row(
                  children: [
                    NavigationRail(
                      extended: extended,
                      selectedIndex: idx,
                      // When extended is true, labelType MUST be none.  We
                      // toggle accordingly so this code remains valid in both
                      // states without fighting Flutter assertions.
                      labelType: extended
                          ? NavigationRailLabelType.none
                          : NavigationRailLabelType.all,
                      backgroundColor: const Color(0xFFFFFFFF),
                      minExtendedWidth: 200,
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF00897B),
                          radius: 18,
                          child: const Text(
                            'AB',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: IconButton(
                          icon: const Icon(Icons.logout),
                          color: const Color(0xFF00897B),
                          onPressed: () =>
                              print('extended rail logout pressed'),
                        ),
                      ),
                      destinations: sharedDestinations,
                      onDestinationSelected: (n) {
                        setLocal(() => idx = n);
                        print('extended rail tapped -> $n');
                      },
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: bodyContent(
                          title: sharedLabels[idx],
                          icon: sharedIcons[idx],
                          accent: const Color(0xFF00695C),
                          background: const Color(0xFFE0F2F1),
                          subtitle: extended
                              ? 'Extended rail — labels shown inline'
                              : 'Collapsed rail — labelType=all',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================================
  // Section 4 — labelType crossed with groupAlignment.
  //
  // groupAlignment shifts the destinations vertically:
  //   * -1.0 → top
  //   *  0.0 → centre
  //   * +1.0 → bottom
  //
  // We render a 3x3 grid (three groupAlignment values × three labelType
  // values) so the interaction is obvious.
  // ==========================================================================

  Widget alignmentMatrix() {
    final alignments = <double>[-1.0, 0.0, 1.0];
    final alignmentNames = <String>['top (-1)', 'centre (0)', 'bottom (+1)'];
    final labelTypes = NavigationRailLabelType.values;

    return Column(
      children: [
        for (var i = 0; i < alignments.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      'groupAlignment\n${alignmentNames[i]}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4527A0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                for (final lt in labelTypes)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE7F6),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF9575CD)),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          children: [
                            Text(
                              'labelType.${lt.name}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF311B92),
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              height: 220,
                              child: Row(
                                children: [
                                  NavigationRail(
                                    selectedIndex: 1,
                                    backgroundColor:
                                        const Color(0xFFFFFFFF),
                                    labelType: lt,
                                    groupAlignment: alignments[i],
                                    destinations: sharedDestinations,
                                    onDestinationSelected: (n) =>
                                        print('alignment cell tapped -> $n'),
                                  ),
                                  const VerticalDivider(width: 1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  // ==========================================================================
  // Section 5 — NavigationRailTheme integration.
  //
  // Use a Theme override to set selected/unselected label and icon styles, an
  // indicator colour, indicator shape, and the labelType itself.  The rail
  // does not pass any of those in its constructor, so the theme drives the
  // visuals.  This is the pattern most apps actually use.
  // ==========================================================================

  Widget themedRailSection() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        var idx = 2;
        return Theme(
          data: ThemeData(
            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: const Color(0xFF1A237E),
              elevation: 8,
              selectedLabelTextStyle: const TextStyle(
                color: Color(0xFFFFEB3B),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelTextStyle: const TextStyle(
                color: Color(0xFFC5CAE9),
                fontSize: 11,
              ),
              selectedIconTheme: const IconThemeData(
                color: Color(0xFFFFEB3B),
                size: 28,
              ),
              unselectedIconTheme: const IconThemeData(
                color: Color(0xFFC5CAE9),
                size: 22,
              ),
              indicatorColor: const Color(0xFF3949AB),
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              useIndicator: true,
              labelType: NavigationRailLabelType.all,
              groupAlignment: -0.8,
              minWidth: 88,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF3949AB)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 360,
                child: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: idx,
                      // Note: no labelType / colours here — Theme wins.
                      destinations: sharedDestinations,
                      onDestinationSelected: (n) {
                        setLocal(() => idx = n);
                        print('themed rail tapped -> $n');
                      },
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Container(
                        color: const Color(0xFFE8EAF6),
                        padding: const EdgeInsets.all(16),
                        child: bodyContent(
                          title: sharedLabels[idx],
                          icon: sharedIcons[idx],
                          accent: const Color(0xFF1A237E),
                          background: const Color(0xFFFFFFFF),
                          subtitle:
                              'Themed via NavigationRailThemeData — labels '
                              'and indicator come from the theme.',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ==========================================================================
  // Section 6 — Density (compact vs comfortable).
  //
  // Compares two rails using `labelType: all` but with different minWidth
  // values so visitors can see how density affects the same enum.  Also
  // illustrates minExtendedWidth on the comfortable variant by toggling
  // extended on it.
  // ==========================================================================

  Widget densityFrame({
    required String title,
    required Color accent,
    required double minWidth,
    required double minExtendedWidth,
    required NavigationRailLabelType labelType,
  }) {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        var idx = 0;
        return Container(
          width: 320,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: accent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                height: 280,
                child: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: idx,
                      labelType: labelType,
                      minWidth: minWidth,
                      minExtendedWidth: minExtendedWidth,
                      backgroundColor: accent.withOpacity(0.05),
                      destinations: sharedDestinations,
                      onDestinationSelected: (n) {
                        setLocal(() => idx = n);
                        print('density rail "$title" tapped -> $n');
                      },
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: bodyContent(
                          title: sharedLabels[idx],
                          icon: sharedIcons[idx],
                          accent: accent,
                          background: accent.withOpacity(0.08),
                          subtitle:
                              'minWidth=${minWidth.toStringAsFixed(0)}\n'
                              'minExtendedWidth=${minExtendedWidth.toStringAsFixed(0)}',
                        ),
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
  }

  // ==========================================================================
  // Section 7 — When to use which.
  //
  // Short, opinionated guidance on which labelType to choose in which
  // scenario.  Static content rendered as cards.
  // ==========================================================================

  final guidanceRows = <Map<String, dynamic>>[
    {
      'value': 'none',
      'colour': const Color(0xFF455A64),
      'use':
          'Icons are universally recognisable, screen real estate is tight, '
              'and a tooltip on hover is acceptable.',
      'avoid':
          'New users would not recognise the icons unaided, or you have more '
              'than ~5 destinations.',
    },
    {
      'value': 'selected',
      'colour': const Color(0xFF1565C0),
      'use':
          'You want a calm icons-only rail in the resting state, but want to '
              'reaffirm the active section with its label visible inline.',
      'avoid':
          'When destinations have similar icons that need labels at all times '
              'for accessibility (consider `all` instead).',
    },
    {
      'value': 'all',
      'colour': const Color(0xFF2E7D32),
      'use':
          'You have horizontal space, all destinations need labels for '
              'discoverability/accessibility, or you must comply with text '
              'requirements for screen readers and translations.',
      'avoid':
          'Very narrow layouts where the label cannot fit without truncation, '
              'or extended:true is also being used (extended takes over).',
    },
  ];

  // ==========================================================================
  // ROOT BUILD
  // ==========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'NavigationRailLabelType Deep Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4527A0),
        foregroundColor: const Color(0xFFFFFFFF),
        title: const Text('NavigationRailLabelType — Deep Demo'),
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================================================================
              // HERO HEADER
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF311B92), Color(0xFF6A1B9A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'NavigationRailLabelType',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Controls how destination labels are shown in a vertical '
                      'NavigationRail.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFD1C4E9),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      children: [
                        chip('values: 3', const Color(0x33FFFFFF)),
                        chip('none', const Color(0xFF455A64)),
                        chip('selected', const Color(0xFF1565C0)),
                        chip('all', const Color(0xFF2E7D32)),
                        chip('extended overrides', const Color(0xFFAD1457)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 1: ALL THREE VALUES SIDE-BY-SIDE
              // ================================================================
              sectionHeader(
                number: '1',
                title: 'All three values, side-by-side (interactive)',
                subtitle:
                    'Each rail uses the same destinations, but a different '
                    'NavigationRailLabelType.  Tap any destination to see the '
                    'rail rebuild — the active state is per-rail.',
                accent: const Color(0xFF1565C0),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  railFrame(
                    title: 'labelType.none',
                    frameColour: const Color(0xFF455A64),
                    bodyColour: const Color(0xFFECEFF1),
                    accent: const Color(0xFF455A64),
                    labelType: NavigationRailLabelType.none,
                    initialIndex: 0,
                  ),
                  railFrame(
                    title: 'labelType.selected',
                    frameColour: const Color(0xFF1565C0),
                    bodyColour: const Color(0xFFE3F2FD),
                    accent: const Color(0xFF1565C0),
                    labelType: NavigationRailLabelType.selected,
                    initialIndex: 1,
                  ),
                  railFrame(
                    title: 'labelType.all',
                    frameColour: const Color(0xFF2E7D32),
                    bodyColour: const Color(0xFFE8F5E9),
                    accent: const Color(0xFF2E7D32),
                    labelType: NavigationRailLabelType.all,
                    initialIndex: 2,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              caption(
                'none → icons-only at rest, label appears as a Tooltip on '
                'hover.\n'
                'selected → only the active destination shows its label '
                'beside the icon.\n'
                'all → every destination always shows its label, taking up '
                'more horizontal space.',
                const Color(0xFFE3F2FD),
                const Color(0xFF0D47A1),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 2: INTERACTIVE TOGGLE
              // ================================================================
              sectionHeader(
                number: '2',
                title: 'Live toggle with SegmentedButton',
                subtitle:
                    'Pick a labelType using the segmented button below — the '
                    'rail rebuilds in place, keeping its current selectedIndex.',
                accent: const Color(0xFF6A1B9A),
              ),
              const SizedBox(height: 12),
              interactiveToggleSection(),
              const SizedBox(height: 12),
              caption(
                'Switching labelType is a one-property change.  No data flow '
                'changes are required because labelType only affects how the '
                'rail draws itself; selectedIndex and destinations stay the '
                'same.',
                const Color(0xFFF3E5F5),
                const Color(0xFF4A148C),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 3: EXTENDED RAIL
              // ================================================================
              sectionHeader(
                number: '3',
                title: 'Extended rail (labelType is overridden)',
                subtitle:
                    'When `extended: true`, labels are always shown inline '
                    'beside the icon. Flutter requires labelType to be '
                    'NavigationRailLabelType.none in that mode — the value is '
                    'effectively replaced by the extended layout.',
                accent: const Color(0xFF00695C),
              ),
              const SizedBox(height: 12),
              extendedRailSection(),
              const SizedBox(height: 12),
              caption(
                'Extended rails are useful on tablets and desktops where you '
                'have horizontal room for full labels.  Use `minExtendedWidth` '
                'to control the expanded width and avoid wrapping the longest '
                'label.',
                const Color(0xFFE0F2F1),
                const Color(0xFF004D40),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 4: GROUPALIGNMENT × LABELTYPE MATRIX
              // ================================================================
              sectionHeader(
                number: '4',
                title: 'groupAlignment × labelType matrix',
                subtitle:
                    'Three groupAlignment values (-1, 0, +1) crossed with the '
                    'three labelType values.  groupAlignment shifts the entire '
                    'destination group vertically; labelType controls only the '
                    'label rendering of each destination.',
                accent: const Color(0xFF4527A0),
              ),
              const SizedBox(height: 12),
              alignmentMatrix(),
              const SizedBox(height: 8),
              caption(
                'groupAlignment is independent of labelType.  Choose '
                'groupAlignment based on where you want the destinations '
                'visually anchored on the rail; choose labelType based on '
                'how much label information you want next to each icon.',
                const Color(0xFFEDE7F6),
                const Color(0xFF311B92),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 5: NavigationRailTheme
              // ================================================================
              sectionHeader(
                number: '5',
                title: 'NavigationRailThemeData integration',
                subtitle:
                    'Themed rail driven entirely by NavigationRailThemeData. '
                    'The widget passes no styling — colours, indicator, label '
                    'styles, labelType and groupAlignment all come from the '
                    'theme.',
                accent: const Color(0xFF1A237E),
              ),
              const SizedBox(height: 12),
              themedRailSection(),
              const SizedBox(height: 12),
              caption(
                'Use NavigationRailThemeData for app-wide consistency. It '
                'lets you change the indicator colour, the indicator shape '
                '(here a 20-radius rounded rectangle), the selected and '
                'unselected text and icon themes, and even the default '
                'labelType.',
                const Color(0xFFE8EAF6),
                const Color(0xFF1A237E),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 6: DENSITY
              // ================================================================
              sectionHeader(
                number: '6',
                title: 'Compact vs comfortable density',
                subtitle:
                    'Same labelType, different minWidth (and minExtendedWidth '
                    'used by the extended layout).  Compact rails save space; '
                    'comfortable rails make taps easier and let labels '
                    'breathe.',
                accent: const Color(0xFFAD1457),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  densityFrame(
                    title: 'Compact (minWidth: 56)',
                    accent: const Color(0xFFAD1457),
                    minWidth: 56,
                    minExtendedWidth: 180,
                    labelType: NavigationRailLabelType.all,
                  ),
                  densityFrame(
                    title: 'Default (minWidth: 72)',
                    accent: const Color(0xFFC2185B),
                    minWidth: 72,
                    minExtendedWidth: 220,
                    labelType: NavigationRailLabelType.all,
                  ),
                  densityFrame(
                    title: 'Comfortable (minWidth: 96)',
                    accent: const Color(0xFFD81B60),
                    minWidth: 96,
                    minExtendedWidth: 280,
                    labelType: NavigationRailLabelType.all,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              caption(
                'Pick density based on the surrounding chrome and the user '
                'context. Comfortable density on desktop with a mouse, '
                'compact density on a tablet split-view, default density '
                'when in doubt.',
                const Color(0xFFFCE4EC),
                const Color(0xFF880E4F),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 7: WHEN TO USE WHICH (GUIDANCE)
              // ================================================================
              sectionHeader(
                number: '7',
                title: 'When to use which value',
                subtitle:
                    'Concrete guidance on choosing between none / selected / '
                    'all in real apps. Includes accessibility considerations.',
                accent: const Color(0xFFE65100),
              ),
              const SizedBox(height: 12),
              for (final row in guidanceRows)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: (row['colour'] as Color)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: row['colour'] as Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'NavigationRailLabelType.${row['value']}',
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF263238),
                            ),
                            children: [
                              const TextSpan(
                                text: 'Use when: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B5E20),
                                ),
                              ),
                              TextSpan(text: row['use'] as String),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF263238),
                            ),
                            children: [
                              const TextSpan(
                                text: 'Avoid when: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB71C1C),
                                ),
                              ),
                              TextSpan(text: row['avoid'] as String),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 8: ACCESSIBILITY NOTES
              // ================================================================
              sectionHeader(
                number: '8',
                title: 'Accessibility & screen readers',
                subtitle:
                    'How labelType affects assistive technologies, and how to '
                    'pair it with other Material 3 features.',
                accent: const Color(0xFF00838F),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F7FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF00838F)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Screen-reader behaviour',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006064),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• Each NavigationRailDestination already exposes its '
                      'label to assistive technology, even when '
                      'labelType.none hides it visually. Screen readers will '
                      'still announce the label.',
                      style:
                          TextStyle(fontSize: 12, color: Color(0xFF004D40)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• Visual labels (selected / all) help discoverability '
                      'for sighted users with low icon literacy and improve '
                      'task completion times in usability studies.',
                      style:
                          TextStyle(fontSize: 12, color: Color(0xFF004D40)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• On Material 3, useIndicator: true draws a pill-shaped '
                      'indicator behind the selected icon. It works with all '
                      'labelType values and is the default in M3. The shape '
                      'and colour can be controlled via indicatorShape and '
                      'indicatorColor on the rail or its theme.',
                      style:
                          TextStyle(fontSize: 12, color: Color(0xFF004D40)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• Combine labelType.all with a sufficient minWidth so '
                      'translations (German, Finnish) do not truncate. '
                      'Ellipsis on a primary nav label is a usability red flag.',
                      style:
                          TextStyle(fontSize: 12, color: Color(0xFF004D40)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // ENUM REFERENCE
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF263238),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'NavigationRailLabelType.values',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final v in NavigationRailLabelType.values)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: switch (v) {
                                  NavigationRailLabelType.none =>
                                    const Color(0xFF455A64),
                                  NavigationRailLabelType.selected =>
                                    const Color(0xFF1565C0),
                                  NavigationRailLabelType.all =>
                                    const Color(0xFF2E7D32),
                                },
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  '${v.index}',
                                  style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'NavigationRailLabelType.${v.name}',
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'monospace',
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ================================================================
              // SUMMARY
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF311B92), Color(0xFF4527A0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Summary',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• none → icons-only resting state, labels surface only '
                      'as tooltips. Best when icons are universally clear.',
                      style: TextStyle(
                          color: Color(0xFFD1C4E9), fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• selected → minimal visual noise, but still confirms '
                      'the active section with an inline label.',
                      style: TextStyle(
                          color: Color(0xFFD1C4E9), fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• all → labels always visible. Best for accessibility '
                      'and discoverability, requires more horizontal space.',
                      style: TextStyle(
                          color: Color(0xFFD1C4E9), fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• extended: true overrides labelType — Flutter requires '
                      'labelType to be `none` while extended is true.',
                      style: TextStyle(
                          color: Color(0xFFD1C4E9), fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• NavigationRailThemeData lets you set labelType, '
                      'indicator, and label/icon styling app-wide.',
                      style: TextStyle(
                          color: Color(0xFFD1C4E9), fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Deep Demo • NavigationRailLabelType • Material',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Local widgets used by build().  These are top-level types because they hold
// stateful parameters; the build() function above instantiates them inside
// StatefulBuilder closures so that the rails respond to taps in place.
// =============================================================================

class _LocalRailFrame extends StatelessWidget {
  const _LocalRailFrame({
    required this.title,
    required this.frameColour,
    required this.bodyColour,
    required this.accent,
    required this.getIndex,
    required this.setIndex,
    required this.labelType,
    required this.extended,
    required this.destinations,
    required this.labels,
    required this.icons,
  });

  final String title;
  final Color frameColour;
  final Color bodyColour;
  final Color accent;
  final int Function() getIndex;
  final void Function(int) setIndex;
  final NavigationRailLabelType labelType;
  final bool extended;
  final List<NavigationRailDestination> destinations;
  final List<String> labels;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    final idx = getIndex();
    return Container(
      width: 360,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: frameColour, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: frameColour,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 320,
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: idx,
                  labelType: labelType,
                  extended: extended,
                  backgroundColor: const Color(0xFFFFFFFF),
                  destinations: destinations,
                  onDestinationSelected: (n) {
                    setIndex(n);
                    print('rail "$title" tapped -> $n');
                  },
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Container(
                    color: bodyColour,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icons[idx], size: 36, color: accent),
                        const SizedBox(height: 8),
                        Text(
                          labels[idx],
                          style: TextStyle(
                            color: accent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'selectedIndex = $idx',
                          style: TextStyle(
                            color: accent.withOpacity(0.85),
                            fontSize: 11,
                          ),
                        ),
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
}

class _LocalToggle extends StatelessWidget {
  const _LocalToggle({
    required this.accent,
    required this.getLabelType,
    required this.setLabelType,
    required this.getIndex,
    required this.setIndex,
    required this.destinations,
    required this.labels,
    required this.icons,
  });

  final Color accent;
  final NavigationRailLabelType Function() getLabelType;
  final void Function(NavigationRailLabelType) setLabelType;
  final int Function() getIndex;
  final void Function(int) setIndex;
  final List<NavigationRailDestination> destinations;
  final List<String> labels;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    final lt = getLabelType();
    final idx = getIndex();
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.6)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'labelType:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SegmentedButton<NavigationRailLabelType>(
                  segments: const <ButtonSegment<NavigationRailLabelType>>[
                    ButtonSegment<NavigationRailLabelType>(
                      value: NavigationRailLabelType.none,
                      label: Text('none'),
                      icon: Icon(Icons.visibility_off_outlined),
                    ),
                    ButtonSegment<NavigationRailLabelType>(
                      value: NavigationRailLabelType.selected,
                      label: Text('selected'),
                      icon: Icon(Icons.center_focus_strong_outlined),
                    ),
                    ButtonSegment<NavigationRailLabelType>(
                      value: NavigationRailLabelType.all,
                      label: Text('all'),
                      icon: Icon(Icons.format_list_bulleted_outlined),
                    ),
                  ],
                  selected: <NavigationRailLabelType>{lt},
                  onSelectionChanged: (s) {
                    final next = s.first;
                    setLabelType(next);
                    print('toggle labelType -> ${next.name}');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 320,
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: idx,
                  labelType: lt,
                  backgroundColor: const Color(0xFFF3E5F5),
                  destinations: destinations,
                  onDestinationSelected: (n) {
                    setIndex(n);
                    print('toggle rail tapped -> $n');
                  },
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Container(
                    color: const Color(0xFFFFFFFF),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Currently: labelType.${lt.name}',
                          style: TextStyle(
                            color: accent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(icons[idx], color: accent, size: 28),
                            const SizedBox(width: 10),
                            Text(
                              labels[idx],
                              style: TextStyle(
                                color: accent,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          switch (lt) {
                            NavigationRailLabelType.none =>
                              'Labels are hidden. Hover an icon for a tooltip.',
                            NavigationRailLabelType.selected =>
                              'Only the active destination shows its label.',
                            NavigationRailLabelType.all =>
                              'Every destination shows its label inline.',
                          },
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555555),
                          ),
                        ),
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
}
