// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live demo gallery - NavigationDestinationLabelBehavior.
//
// This file renders a long, hand-authored Material gallery that exercises every
// value of NavigationDestinationLabelBehavior in real NavigationBar widgets.
// Each section uses StatefulBuilder for selectedIndex state, distinct palettes,
// distinct destinations, and distinct themed surroundings so the visual tradeoffs
// of alwaysShow / alwaysHide / onlyShowSelected become obvious side-by-side.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== NavigationDestinationLabelBehavior Deep Demo (Material Harness) ===');
  for (final v in NavigationDestinationLabelBehavior.values) {
    print('  ${v.index}: ${v.name}');
  }

  // ===========================================================================
  // PALETTES - one distinct palette per section so the page is visually banded
  // and the user can tell at a glance which behavior they are looking at.
  // ===========================================================================
  const palette1Surface = Color(0xFFEEF2FF); // indigo-tinted
  const palette1Border = Color(0xFF3F51B5);
  const palette1Caption = Color(0xFF1A237E);

  const palette2Surface = Color(0xFFE0F2F1); // teal-tinted
  const palette2Border = Color(0xFF00897B);
  const palette2Caption = Color(0xFF004D40);

  const palette3Surface = Color(0xFFFBE9E7); // deepOrange-tinted
  const palette3Border = Color(0xFFE64A19);
  const palette3Caption = Color(0xFFBF360C);

  const palette4Surface = Color(0xFFF3E5F5); // purple-tinted
  const palette4Border = Color(0xFF8E24AA);
  const palette4Caption = Color(0xFF4A148C);

  const palette5Surface = Color(0xFFE8F5E9); // green-tinted
  const palette5Border = Color(0xFF43A047);
  const palette5Caption = Color(0xFF1B5E20);

  const palette6Surface = Color(0xFFFFF8E1); // amber-tinted
  const palette6Border = Color(0xFFFFA000);
  const palette6Caption = Color(0xFF7F4F01);

  const palette7Surface = Color(0xFFE3F2FD); // blue-tinted
  const palette7Border = Color(0xFF1976D2);
  const palette7Caption = Color(0xFF0D47A1);

  const palette8Surface = Color(0xFFFCE4EC); // pink-tinted
  const palette8Border = Color(0xFFD81B60);
  const palette8Caption = Color(0xFF880E4F);

  // ===========================================================================
  // SECTION 1 - SIDE-BY-SIDE COMPARISON OF ALL THREE ENUM VALUES
  // The most important section: three NavigationBars, each pinned to one of
  // the enum values, all sharing the same selected index so the difference is
  // exclusively a function of the labelBehavior property.
  // ===========================================================================
  final section1 = Card(
    color: palette1Surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: palette1Border, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) {
          int selected = 1;
          return StatefulBuilder(
            builder: (context, innerSetState) {
              void choose(int i) => innerSetState(() => selected = i);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. Side-by-side: alwaysShow / onlyShowSelected / alwaysHide',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: palette1Caption,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Three identical destination sets. Only the labelBehavior '
                    'differs. Tap a destination in any bar to drive the shared '
                    'selectedIndex; watch how each behavior reacts.',
                    style: TextStyle(color: palette1Caption),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'alwaysShow',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: palette1Caption,
                              ),
                            ),
                            const SizedBox(height: 6),
                            NavigationBar(
                              selectedIndex: selected,
                              labelBehavior:
                                  NavigationDestinationLabelBehavior.alwaysShow,
                              onDestinationSelected: choose,
                              destinations: const [
                                NavigationDestination(
                                  icon: Icon(Icons.home_outlined),
                                  selectedIcon: Icon(Icons.home),
                                  label: 'Home',
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.search_outlined),
                                  selectedIcon: Icon(Icons.search),
                                  label: 'Search',
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.person_outline),
                                  selectedIcon: Icon(Icons.person),
                                  label: 'Profile',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'onlyShowSelected',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: palette1Caption,
                              ),
                            ),
                            const SizedBox(height: 6),
                            NavigationBar(
                              selectedIndex: selected,
                              labelBehavior: NavigationDestinationLabelBehavior
                                  .onlyShowSelected,
                              onDestinationSelected: choose,
                              destinations: const [
                                NavigationDestination(
                                  icon: Icon(Icons.home_outlined),
                                  selectedIcon: Icon(Icons.home),
                                  label: 'Home',
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.search_outlined),
                                  selectedIcon: Icon(Icons.search),
                                  label: 'Search',
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.person_outline),
                                  selectedIcon: Icon(Icons.person),
                                  label: 'Profile',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'alwaysHide',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: palette1Caption,
                              ),
                            ),
                            const SizedBox(height: 6),
                            NavigationBar(
                              selectedIndex: selected,
                              labelBehavior:
                                  NavigationDestinationLabelBehavior.alwaysHide,
                              onDestinationSelected: choose,
                              destinations: const [
                                NavigationDestination(
                                  icon: Icon(Icons.home_outlined),
                                  selectedIcon: Icon(Icons.home),
                                  label: 'Home',
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.search_outlined),
                                  selectedIcon: Icon(Icons.search),
                                  label: 'Search',
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.person_outline),
                                  selectedIcon: Icon(Icons.person),
                                  label: 'Profile',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: palette1Border, width: 1),
                    ),
                    child: const Text(
                      'Caption: notice the height of each bar stays the same '
                      'across behaviors, but the visible text differs. '
                      '"alwaysShow" wastes the least click target uncertainty, '
                      '"alwaysHide" trades clarity for icon-only minimalism.',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: palette1Caption,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Currently selected: index $selected '
                    '(${[
                      'Home',
                      'Search',
                      'Profile',
                    ][selected]})',
                    style: const TextStyle(color: palette1Caption),
                  ),
                ],
              );
            },
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 2 - INTERACTIVE BEHAVIOR PICKER VIA SEGMENTEDBUTTON
  // One bar, but the user picks the labelBehavior at runtime via a
  // SegmentedButton. Useful for demonstrating that the same destinations can
  // be expressed three different ways depending on UX needs.
  // ===========================================================================
  final section2 = Card(
    color: palette2Surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: palette2Border, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) {
          NavigationDestinationLabelBehavior currentBehavior =
              NavigationDestinationLabelBehavior.alwaysShow;
          int currentIndex = 0;
          return StatefulBuilder(
            builder: (context, innerSetState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '2. Interactive picker (SegmentedButton drives behavior)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: palette2Caption,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Use the segmented control to swap label behaviors live. '
                    'The selected index is preserved across behavior changes, '
                    'demonstrating that labelBehavior is a presentation knob, '
                    'not a state knob.',
                    style: TextStyle(color: palette2Caption),
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<NavigationDestinationLabelBehavior>(
                    segments: const [
                      ButtonSegment(
                        value: NavigationDestinationLabelBehavior.alwaysShow,
                        label: Text('alwaysShow'),
                        icon: Icon(Icons.label_outline),
                      ),
                      ButtonSegment(
                        value:
                            NavigationDestinationLabelBehavior.onlyShowSelected,
                        label: Text('onlyShowSelected'),
                        icon: Icon(Icons.adjust),
                      ),
                      ButtonSegment(
                        value: NavigationDestinationLabelBehavior.alwaysHide,
                        label: Text('alwaysHide'),
                        icon: Icon(Icons.label_off_outlined),
                      ),
                    ],
                    selected: <NavigationDestinationLabelBehavior>{
                      currentBehavior,
                    },
                    onSelectionChanged: (s) {
                      innerSetState(() => currentBehavior = s.first);
                    },
                  ),
                  const SizedBox(height: 16),
                  NavigationBar(
                    selectedIndex: currentIndex,
                    labelBehavior: currentBehavior,
                    onDestinationSelected: (i) =>
                        innerSetState(() => currentIndex = i),
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: 'Dashboard',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.bar_chart_outlined),
                        selectedIcon: Icon(Icons.bar_chart),
                        label: 'Reports',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.event_note_outlined),
                        selectedIcon: Icon(Icons.event_note),
                        label: 'Tasks',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.notifications_none),
                        selectedIcon: Icon(Icons.notifications),
                        label: 'Alerts',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: palette2Border, width: 1),
                    ),
                    child: Text(
                      'Active behavior: ${currentBehavior.name}. '
                      'Active index: $currentIndex.',
                      style: const TextStyle(
                        color: palette2Caption,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 3 - CHOICECHIP-DRIVEN PICKER (ALTERNATIVE INTERACTION)
  // Same idea as section 2, but through ChoiceChips, to show that the
  // mechanism for swapping behavior is independent of the demonstration.
  // ===========================================================================
  final section3 = Card(
    color: palette3Surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: palette3Border, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) {
          NavigationDestinationLabelBehavior chip =
              NavigationDestinationLabelBehavior.onlyShowSelected;
          int idx = 2;
          return StatefulBuilder(
            builder: (context, innerSetState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '3. ChoiceChip picker (alternative control surface)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: palette3Caption,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Demonstrates that behavior selection is orthogonal to the '
                    'NavigationBar itself. ChoiceChips are a great fit for '
                    'settings screens where labelBehavior is a user preference.',
                    style: TextStyle(color: palette3Caption),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: NavigationDestinationLabelBehavior.values
                        .map(
                          (b) => ChoiceChip(
                            label: Text(b.name),
                            selected: chip == b,
                            onSelected: (sel) {
                              if (sel) {
                                innerSetState(() => chip = b);
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  NavigationBar(
                    selectedIndex: idx,
                    labelBehavior: chip,
                    onDestinationSelected: (i) =>
                        innerSetState(() => idx = i),
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.local_cafe_outlined),
                        selectedIcon: Icon(Icons.local_cafe),
                        label: 'Cafe',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.restaurant_outlined),
                        selectedIcon: Icon(Icons.restaurant),
                        label: 'Dine',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.local_pizza_outlined),
                        selectedIcon: Icon(Icons.local_pizza),
                        label: 'Pizza',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.local_bar_outlined),
                        selectedIcon: Icon(Icons.local_bar),
                        label: 'Bar',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.icecream_outlined),
                        selectedIcon: Icon(Icons.icecream),
                        label: 'Sweets',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Behavior=${chip.name}, index=$idx',
                    style: const TextStyle(color: palette3Caption),
                  ),
                ],
              );
            },
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 4 - THEMED VIA NAVIGATIONBARTHEMEDATA
  // Demonstrates that NavigationBarThemeData.labelBehavior provides a default,
  // but a per-instance labelBehavior can override the theme.
  // ===========================================================================
  final section4 = Card(
    color: palette4Surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: palette4Border, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) {
          int themedIdx = 1;
          return StatefulBuilder(
            builder: (context, innerSetState) {
              final themed = Theme.of(context).copyWith(
                navigationBarTheme: const NavigationBarThemeData(
                  backgroundColor: Color(0xFFEDE7F6),
                  indicatorColor: Color(0xFFB39DDB),
                  surfaceTintColor: Colors.transparent,
                  labelTextStyle: WidgetStatePropertyAll(
                    TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF311B92),
                    ),
                  ),
                  iconTheme: WidgetStatePropertyAll(
                    IconThemeData(color: Color(0xFF311B92)),
                  ),
                  labelBehavior:
                      NavigationDestinationLabelBehavior.onlyShowSelected,
                ),
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '4. Theme-driven default vs. per-instance override',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: palette4Caption,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'A NavigationBarThemeData defaults the bar to '
                    'onlyShowSelected. The first bar inherits the theme; the '
                    'second forces alwaysShow for itself; the third forces '
                    'alwaysHide. The shared theme also customizes colors and '
                    'label typography.',
                    style: TextStyle(color: palette4Caption),
                  ),
                  const SizedBox(height: 16),
                  Theme(
                    data: themed,
                    child: Column(
                      children: [
                        const Text(
                          'inherits theme (onlyShowSelected)',
                          style: TextStyle(
                            color: palette4Caption,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        NavigationBar(
                          selectedIndex: themedIdx,
                          onDestinationSelected: (i) =>
                              innerSetState(() => themedIdx = i),
                          destinations: const [
                            NavigationDestination(
                              icon: Icon(Icons.book_outlined),
                              selectedIcon: Icon(Icons.book),
                              label: 'Library',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.shopping_bag_outlined),
                              selectedIcon: Icon(Icons.shopping_bag),
                              label: 'Shop',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.favorite_outline),
                              selectedIcon: Icon(Icons.favorite),
                              label: 'Wishlist',
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'overrides to alwaysShow',
                          style: TextStyle(
                            color: palette4Caption,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        NavigationBar(
                          selectedIndex: themedIdx,
                          labelBehavior:
                              NavigationDestinationLabelBehavior.alwaysShow,
                          onDestinationSelected: (i) =>
                              innerSetState(() => themedIdx = i),
                          destinations: const [
                            NavigationDestination(
                              icon: Icon(Icons.book_outlined),
                              selectedIcon: Icon(Icons.book),
                              label: 'Library',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.shopping_bag_outlined),
                              selectedIcon: Icon(Icons.shopping_bag),
                              label: 'Shop',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.favorite_outline),
                              selectedIcon: Icon(Icons.favorite),
                              label: 'Wishlist',
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'overrides to alwaysHide',
                          style: TextStyle(
                            color: palette4Caption,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        NavigationBar(
                          selectedIndex: themedIdx,
                          labelBehavior:
                              NavigationDestinationLabelBehavior.alwaysHide,
                          onDestinationSelected: (i) =>
                              innerSetState(() => themedIdx = i),
                          destinations: const [
                            NavigationDestination(
                              icon: Icon(Icons.book_outlined),
                              selectedIcon: Icon(Icons.book),
                              label: 'Library',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.shopping_bag_outlined),
                              selectedIcon: Icon(Icons.shopping_bag),
                              label: 'Shop',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.favorite_outline),
                              selectedIcon: Icon(Icons.favorite),
                              label: 'Wishlist',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 5 - TEXT SCALING (MEDIAQUERY.TEXTSCALER)
  // Same labelBehavior set, but each row has a different MediaQuery textScaler.
  // Showcases how labels swell at large textScale and how alwaysHide turns into
  // an accessibility-friendly fallback for very large text.
  // ===========================================================================
  final section5 = Card(
    color: palette5Surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: palette5Border, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) {
          int idx5 = 0;
          double scale = 1.0;
          return StatefulBuilder(
            builder: (context, innerSetState) {
              Widget bar(NavigationDestinationLabelBehavior b, String tag) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(scale),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$tag @ ${scale.toStringAsFixed(2)}x',
                        style: const TextStyle(
                          color: palette5Caption,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      NavigationBar(
                        selectedIndex: idx5,
                        labelBehavior: b,
                        onDestinationSelected: (i) =>
                            innerSetState(() => idx5 = i),
                        destinations: const [
                          NavigationDestination(
                            icon: Icon(Icons.brightness_5_outlined),
                            selectedIcon: Icon(Icons.brightness_5),
                            label: 'Light',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.brightness_2_outlined),
                            selectedIcon: Icon(Icons.brightness_2),
                            label: 'Dark',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.contrast_outlined),
                            selectedIcon: Icon(Icons.contrast),
                            label: 'Auto',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '5. Behavior under different MediaQuery textScaler values',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: palette5Caption,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'When users opt into large text via system settings, label '
                    'behavior choices ripple through layout. alwaysShow may '
                    'wrap or truncate labels; alwaysHide stays compact; '
                    'onlyShowSelected expands only the focused destination.',
                    style: TextStyle(color: palette5Caption),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text(
                        'textScaler:',
                        style: TextStyle(color: palette5Caption),
                      ),
                      Expanded(
                        child: Slider(
                          min: 0.85,
                          max: 1.85,
                          divisions: 10,
                          value: scale,
                          label: scale.toStringAsFixed(2),
                          onChanged: (v) =>
                              innerSetState(() => scale = v),
                        ),
                      ),
                      Text(
                        scale.toStringAsFixed(2),
                        style: const TextStyle(color: palette5Caption),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  bar(NavigationDestinationLabelBehavior.alwaysShow,
                      'alwaysShow'),
                  const SizedBox(height: 14),
                  bar(NavigationDestinationLabelBehavior.onlyShowSelected,
                      'onlyShowSelected'),
                  const SizedBox(height: 14),
                  bar(NavigationDestinationLabelBehavior.alwaysHide,
                      'alwaysHide'),
                ],
              );
            },
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 6 - SELECTEDICON DIFFERENCES
  // Custom destination set where selectedIcon contrasts strongly with icon.
  // Useful for comparing how the indicator and selected icon together
  // communicate selection when the label is hidden.
  // ===========================================================================
  final section6 = Card(
    color: palette6Surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: palette6Border, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) {
          int idx6 = 1;
          return StatefulBuilder(
            builder: (context, innerSetState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '6. selectedIcon contrast across behaviors',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: palette6Caption,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'When labels are hidden, the selectedIcon (and the active '
                    'indicator pill) does the bulk of the talking. Each bar '
                    'below uses outlined icons for unselected and filled icons '
                    'for selected, so the visual jump on selection is loud.',
                    style: TextStyle(color: palette6Caption),
                  ),
                  const SizedBox(height: 16),
                  for (final entry in const [
                    [
                      'alwaysShow',
                      NavigationDestinationLabelBehavior.alwaysShow,
                    ],
                    [
                      'onlyShowSelected',
                      NavigationDestinationLabelBehavior.onlyShowSelected,
                    ],
                    [
                      'alwaysHide',
                      NavigationDestinationLabelBehavior.alwaysHide,
                    ],
                  ])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Column(
                        children: [
                          Text(
                            entry[0] as String,
                            style: const TextStyle(
                              color: palette6Caption,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          NavigationBar(
                            selectedIndex: idx6,
                            labelBehavior:
                                entry[1] as NavigationDestinationLabelBehavior,
                            onDestinationSelected: (i) =>
                                innerSetState(() => idx6 = i),
                            destinations: const [
                              NavigationDestination(
                                icon: Icon(Icons.flight_outlined),
                                selectedIcon: Icon(Icons.flight),
                                label: 'Flights',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.hotel_outlined),
                                selectedIcon: Icon(Icons.hotel),
                                label: 'Hotels',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.directions_car_outlined),
                                selectedIcon: Icon(Icons.directions_car),
                                label: 'Cars',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.train_outlined),
                                selectedIcon: Icon(Icons.train),
                                label: 'Rail',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 7 - WHEN TO USE WHICH (ANNOTATED PAIRS)
  // Two-up layout. Each row shows a "good fit" example next to a "bad fit"
  // example for a given behavior, with annotated commentary.
  // ===========================================================================
  final section7 = Card(
    color: palette7Surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: palette7Border, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) {
          int compactIdx = 0;
          int roomyIdx = 1;
          return StatefulBuilder(
            builder: (context, innerSetState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '7. When to use which (compact vs. roomy bars)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: palette7Caption,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Pick alwaysHide for icon-literate audiences and tight '
                    'horizontal space; pick alwaysShow when destinations are '
                    'unfamiliar; pick onlyShowSelected when labels are '
                    'helpful but you want to declutter idle states.',
                    style: TextStyle(color: palette7Caption),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: palette7Border, width: 1),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'compact bar - alwaysHide is great here',
                                style: TextStyle(
                                  color: palette7Caption,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 220,
                                child: NavigationBar(
                                  selectedIndex: compactIdx,
                                  labelBehavior:
                                      NavigationDestinationLabelBehavior
                                          .alwaysHide,
                                  onDestinationSelected: (i) =>
                                      innerSetState(() => compactIdx = i),
                                  destinations: const [
                                    NavigationDestination(
                                      icon: Icon(Icons.play_arrow_outlined),
                                      selectedIcon: Icon(Icons.play_arrow),
                                      label: 'Play',
                                    ),
                                    NavigationDestination(
                                      icon: Icon(Icons.pause_outlined),
                                      selectedIcon: Icon(Icons.pause),
                                      label: 'Pause',
                                    ),
                                    NavigationDestination(
                                      icon: Icon(Icons.stop_outlined),
                                      selectedIcon: Icon(Icons.stop),
                                      label: 'Stop',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Universally recognized icons + tight space '
                                '= label-free is fine.',
                                style: TextStyle(
                                  color: palette7Caption,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: palette7Border, width: 1),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'roomy bar - alwaysShow improves discovery',
                                style: TextStyle(
                                  color: palette7Caption,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              NavigationBar(
                                selectedIndex: roomyIdx,
                                labelBehavior:
                                    NavigationDestinationLabelBehavior
                                        .alwaysShow,
                                onDestinationSelected: (i) =>
                                    innerSetState(() => roomyIdx = i),
                                destinations: const [
                                  NavigationDestination(
                                    icon: Icon(Icons.assignment_outlined),
                                    selectedIcon: Icon(Icons.assignment),
                                    label: 'Briefs',
                                  ),
                                  NavigationDestination(
                                    icon: Icon(Icons.fact_check_outlined),
                                    selectedIcon: Icon(Icons.fact_check),
                                    label: 'Audits',
                                  ),
                                  NavigationDestination(
                                    icon: Icon(Icons.insights_outlined),
                                    selectedIcon: Icon(Icons.insights),
                                    label: 'Insights',
                                  ),
                                  NavigationDestination(
                                    icon: Icon(Icons.workspaces_outlined),
                                    selectedIcon: Icon(Icons.workspaces),
                                    label: 'Spaces',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Specialised destinations users may not '
                                'recognise by icon alone.',
                                style: TextStyle(
                                  color: palette7Caption,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: palette7Border, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'onlyShowSelected: a balanced middle ground',
                          style: TextStyle(
                            color: palette7Caption,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        NavigationBar(
                          selectedIndex: 2,
                          labelBehavior: NavigationDestinationLabelBehavior
                              .onlyShowSelected,
                          destinations: const [
                            NavigationDestination(
                              icon: Icon(Icons.email_outlined),
                              selectedIcon: Icon(Icons.email),
                              label: 'Inbox',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.send_outlined),
                              selectedIcon: Icon(Icons.send),
                              label: 'Sent',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.drafts_outlined),
                              selectedIcon: Icon(Icons.drafts),
                              label: 'Drafts',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.archive_outlined),
                              selectedIcon: Icon(Icons.archive),
                              label: 'Archive',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.delete_outline),
                              selectedIcon: Icon(Icons.delete),
                              label: 'Trash',
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Tip: pair onlyShowSelected with a custom indicator '
                          'colour so the active label still feels distinct.',
                          style: TextStyle(
                            color: palette7Caption,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 8 - PROGRAMMATIC INSPECTION
  // Print-style section that surfaces every value of the enum and its index.
  // Useful for harness logs and for confirming the d4rt interpreter resolves
  // the enum properly.
  // ===========================================================================
  final section8 = Card(
    color: palette8Surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: palette8Border, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    ),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '8. Programmatic inspection of the enum',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: palette8Caption,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Every NavigationDestinationLabelBehavior value, its index, and '
            'an at-a-glance summary of when to use it. Useful for docs pages '
            'and onboarding screens.',
            style: TextStyle(color: palette8Caption),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: palette8Border, width: 1),
            ),
            child: Column(
              children: [
                for (final v in NavigationDestinationLabelBehavior.values)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: palette8Border.withAlpha(40),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: palette8Border,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            '${v.index}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                v.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: palette8Caption,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _summaryFor(v),
                                style: const TextStyle(
                                  color: palette8Caption,
                                ),
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
        ],
      ),
    ),
  );

  // ===========================================================================
  // PAGE ASSEMBLY
  // ===========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F51B5)),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('NavigationDestinationLabelBehavior - Deep Demo'),
        backgroundColor: const Color(0xFF3F51B5),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Text(
                  'A guided tour of NavigationDestinationLabelBehavior. Each '
                  'card below isolates one aspect of the enum: comparison, '
                  'interaction, theming, accessibility, selectedIcon, '
                  'when-to-use, and programmatic inspection.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              section1,
              section2,
              section3,
              section4,
              section5,
              section6,
              section7,
              section8,
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'End of NavigationDestinationLabelBehavior gallery',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

String _summaryFor(NavigationDestinationLabelBehavior v) {
  switch (v) {
    case NavigationDestinationLabelBehavior.alwaysShow:
      return 'Show every label at all times. Best for unfamiliar destinations '
          'or when discoverability outweighs visual density.';
    case NavigationDestinationLabelBehavior.onlyShowSelected:
      return 'Show the label of the active destination only. A balanced '
          'choice that highlights the user\'s current location while keeping '
          'the rest of the bar uncluttered.';
    case NavigationDestinationLabelBehavior.alwaysHide:
      return 'Never show labels. Best when destinations are conveyed by '
          'universally recognized icons and screen real estate is precious.';
  }
}
