// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo of NavigationDrawerTheme / NavigationDrawerThemeData
// ----------------------------------------------------------------------------
// NavigationDrawerThemeData defines default property values for descendant
// NavigationDrawer widgets. It can be supplied via two routes:
//
//   1. ThemeData(navigationDrawerTheme: NavigationDrawerThemeData(...))
//      This bakes the theme into the application-wide Theme. Every
//      NavigationDrawer in the tree resolves NavigationDrawerTheme.of(context)
//      to this default unless a closer NavigationDrawerTheme intercepts.
//
//   2. NavigationDrawerTheme(data: NavigationDrawerThemeData(...), child: ...)
//      An InheritedTheme subtype. Wrap any subtree to scope drawer styling
//      to that subtree only. .of(context) walks up the tree, returning the
//      first NavigationDrawerTheme it finds, then falls back to
//      Theme.of(context).navigationDrawerTheme.
//
// Themed properties: backgroundColor, elevation, shadowColor, surfaceTintColor,
// indicatorColor, indicatorShape, indicatorSize, labelTextStyle (WidgetState
// resolvable), iconTheme (WidgetState resolvable), tileHeight.
//
// labelTextStyle and iconTheme are WidgetStateProperty<T?> which means they
// resolve based on a Set<WidgetState> the destination is in. The interesting
// states for a NavigationDrawerDestination are WidgetState.selected and
// WidgetState.disabled. Use WidgetStateProperty.resolveWith((states) => ...)
// to vary the style per state.
// ----------------------------------------------------------------------------

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== NavigationDrawerTheme Deep Demo ===');

  // ===========================================================================
  // PALETTE CONSTANTS - one palette per section, never reused.
  // ===========================================================================

  // Section 2 - indigo
  const Color indigoBg = Color(0xFFE8EAF6);
  const Color indigoSurface = Color(0xFFFFFFFF);
  const Color indigoIndicator = Color(0xFF3949AB);
  const Color indigoTint = Color(0xFF7986CB);
  const Color indigoSelectedFg = Color(0xFFFFFFFF);
  const Color indigoUnselectedFg = Color(0xFF1A237E);

  // Section 3 - deep purple
  const Color purpleBg = Color(0xFFEDE7F6);
  const Color purpleIndicator = Color(0xFF5E35B1);
  const Color purpleTint = Color(0xFF9575CD);
  const Color purpleSelectedFg = Color(0xFFEDE7F6);
  const Color purpleUnselectedFg = Color(0xFF311B92);
  const Color purpleShadow = Color(0xFF311B92);

  // Section 4 - teal
  const Color tealBg = Color(0xFFE0F2F1);
  const Color tealIndicator = Color(0xFF00897B);
  const Color tealTint = Color(0xFF4DB6AC);
  const Color tealSelectedFg = Color(0xFFFFFFFF);
  const Color tealUnselectedFg = Color(0xFF004D40);

  // Section 5 - blue grey
  const Color bgBlueGreyBg = Color(0xFFECEFF1);
  const Color bgBlueGreyIndicator = Color(0xFF455A64);
  const Color bgBlueGreyTint = Color(0xFF90A4AE);
  const Color bgBlueGreySelectedFg = Color(0xFFFFFFFF);
  const Color bgBlueGreyUnselectedFg = Color(0xFF263238);

  // Section 6 - brand custom
  const Color brandBg = Color(0xFFFFF3E0);
  const Color brandIndicator = Color(0xFFFB8C00);
  const Color brandTint = Color(0xFFFFB74D);
  const Color brandSelectedFg = Color(0xFF3E2723);
  const Color brandUnselectedFg = Color(0xFFBF360C);
  const Color brandShadow = Color(0xFFE65100);

  // Section 7 - elevation explorer (forest)
  const Color forestBg = Color(0xFFE8F5E9);
  const Color forestIndicator = Color(0xFF2E7D32);
  const Color forestTint = Color(0xFF66BB6A);
  const Color forestShadow = Color(0xFF1B5E20);
  const Color forestSelectedFg = Color(0xFFFFFFFF);
  const Color forestUnselectedFg = Color(0xFF1B5E20);

  // Section 8 - inherited-widget vs ThemeData (rose)
  const Color roseBg = Color(0xFFFCE4EC);
  const Color roseIndicator = Color(0xFFC2185B);
  const Color roseTint = Color(0xFFF06292);
  const Color roseSelectedFg = Color(0xFFFFFFFF);
  const Color roseUnselectedFg = Color(0xFF880E4F);

  // Section 9 - readout (slate)
  const Color slateBg = Color(0xFFCFD8DC);
  const Color slateIndicator = Color(0xFF37474F);
  const Color slateTint = Color(0xFF607D8B);
  const Color slateSelectedFg = Color(0xFFECEFF1);
  const Color slateUnselectedFg = Color(0xFF263238);

  // ===========================================================================
  // SHARED DESTINATION LIST - icons and labels reused across sections so the
  // theming differences pop without label noise.
  // ===========================================================================

  List<Widget> standardDestinations() {
    return const <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Mailbox',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.inbox_outlined),
        selectedIcon: Icon(Icons.inbox),
        label: Text('Inbox'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.send_outlined),
        selectedIcon: Icon(Icons.send),
        label: Text('Sent'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.drafts_outlined),
        selectedIcon: Icon(Icons.drafts),
        label: Text('Drafts'),
      ),
      Divider(height: 1, indent: 28, endIndent: 28),
      Padding(
        padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Folders',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.star_outline),
        selectedIcon: Icon(Icons.star),
        label: Text('Starred'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.archive_outlined),
        selectedIcon: Icon(Icons.archive),
        label: Text('Archive'),
      ),
    ];
  }

  // The non-destination widgets above are at indices 0, 4, 5. selectedIndex on
  // a NavigationDrawer counts only NavigationDrawerDestination widgets in the
  // children list. So mapping is: 0=Inbox, 1=Sent, 2=Drafts, 3=Starred, 4=Archive.

  // ===========================================================================
  // FACTORY: build a themed drawer inside a fixed-height SizedBox using a
  // NavigationDrawerTheme inherited widget. This is the "scoped subtree"
  // pattern - good when only part of the app needs custom drawer styling.
  // ===========================================================================

  Widget themedDrawerBox({
    required NavigationDrawerThemeData theme,
    required int initialIndex,
    required Color paletteBackdrop,
    double height = 460,
  }) {
    return StatefulBuilder(
      builder: (BuildContext sbContext, StateSetter setState) {
        int selected = initialIndex;
        return Container(
          decoration: BoxDecoration(
            color: paletteBackdrop,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black.withOpacity(0.06)),
          ),
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 304,
                  child: Material(
                    type: MaterialType.transparency,
                    child: NavigationDrawerTheme(
                      data: theme,
                      child: NavigationDrawer(
                        selectedIndex: selected,
                        onDestinationSelected: (int i) {
                          setState(() => selected = i);
                        },
                        children: standardDestinations(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Selected destination index: $selected',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tap a destination in the drawer on the left. The '
                          'NavigationDrawerTheme inherited widget around the '
                          'drawer is the only thing controlling its colors, '
                          'shape, and label styles in this section.',
                          style: TextStyle(fontSize: 13, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // FACTORY: scaffold-with-drawer demo. A real NavigationDrawer normally lives
  // in Scaffold.drawer. We use a GlobalKey<ScaffoldState> and a button that
  // calls openDrawer() on demand. This is the "real Scaffold" pattern - the
  // closest match to how applications wire drawers in production.
  // ===========================================================================

  Widget scaffoldDrawerBox({
    required NavigationDrawerThemeData theme,
    required int initialIndex,
    required String label,
    required Color appBarColor,
    double height = 360,
  }) {
    return StatefulBuilder(
      builder: (BuildContext sbContext, StateSetter setState) {
        final GlobalKey<ScaffoldState> scaffoldKey =
            GlobalKey<ScaffoldState>();
        int selected = initialIndex;
        return SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: NavigationDrawerTheme(
              data: theme,
              child: Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  backgroundColor: appBarColor,
                  foregroundColor: Colors.white,
                  title: Text(label),
                  leading: Builder(
                    builder: (BuildContext ctx) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.maybeOf(ctx)?.openDrawer();
                        },
                      );
                    },
                  ),
                ),
                drawer: NavigationDrawer(
                  selectedIndex: selected,
                  onDestinationSelected: (int i) {
                    setState(() => selected = i);
                    Navigator.of(sbContext).maybePop();
                  },
                  children: standardDestinations(),
                ),
                body: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Tap the menu icon to open the themed drawer.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Currently selected index: $selected',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () =>
                            scaffoldKey.currentState?.openDrawer(),
                        icon: const Icon(Icons.menu_open),
                        label: const Text('Open drawer'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // SECTION CARD HELPER
  // ===========================================================================

  Widget sectionCard({
    required String title,
    required String description,
    required Widget body,
    String? footer,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 16),
              body,
              if (footer != null) ...<Widget>[
                const SizedBox(height: 12),
                Text(
                  footer,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 1 - DEFAULT THEME BASELINE
  // No NavigationDrawerTheme around it. Resolves entirely from the
  // ambient Theme.of(context).navigationDrawerTheme (which is the framework
  // default if the application has not set one).
  // ===========================================================================

  final Widget section1 = sectionCard(
    title: '1. Default theme baseline',
    description:
        'A NavigationDrawer with no NavigationDrawerTheme override. Every '
        'visible value comes from the ambient ThemeData. This is what users '
        'see if you supply nothing - useful as a reference point for the '
        'themed sections that follow.',
    body: themedDrawerBox(
      theme: const NavigationDrawerThemeData(),
      initialIndex: 0,
      paletteBackdrop: const Color(0xFFF5F5F5),
    ),
    footer:
        'NavigationDrawerThemeData() with all-null fields is functionally '
        'identical to no theme at all.',
  );

  // ===========================================================================
  // SECTION 2 - SCOPED INHERITED-WIDGET THEME (INDIGO)
  // Demonstrates the NavigationDrawerTheme(data: ...) inherited widget. The
  // theme applies only to descendants of this widget.
  // ===========================================================================

  final NavigationDrawerThemeData indigoTheme = NavigationDrawerThemeData(
    backgroundColor: indigoBg,
    surfaceTintColor: indigoTint,
    indicatorColor: indigoIndicator,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    indicatorSize: const Size(248, 48),
    elevation: 2,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: indigoSelectedFg,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          );
        }
        return const TextStyle(
          color: indigoUnselectedFg,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: indigoSelectedFg, size: 24);
        }
        return const IconThemeData(color: indigoUnselectedFg, size: 22);
      },
    ),
  );

  final Widget section2 = sectionCard(
    title: '2. Inherited widget: NavigationDrawerTheme (indigo)',
    description:
        'Wrap a subtree in NavigationDrawerTheme to scope styling to that '
        'subtree. The drawer below shows backgroundColor, surfaceTintColor, '
        'indicatorColor, an indicatorShape with rounded corners, and a custom '
        'indicatorSize. Selected vs unselected label color and weight come '
        'from labelTextStyle resolved through WidgetStateProperty. Same idea '
        'for the icon color via iconTheme.',
    body: themedDrawerBox(
      theme: indigoTheme,
      initialIndex: 0,
      paletteBackdrop: const Color(0xFFC5CAE9),
    ),
    footer: 'Use the inherited-widget form when only part of the app needs '
        'this look - e.g., a settings flow with a custom palette.',
  );

  // ===========================================================================
  // SECTION 3 - SHADOW + ELEVATION + SHAPE (DEEP PURPLE)
  // ===========================================================================

  final NavigationDrawerThemeData purpleTheme = NavigationDrawerThemeData(
    backgroundColor: indigoSurface,
    surfaceTintColor: purpleTint,
    indicatorColor: purpleIndicator,
    indicatorShape: const StadiumBorder(),
    indicatorSize: const Size(252, 52),
    elevation: 8,
    shadowColor: purpleShadow,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: purpleSelectedFg,
            fontWeight: FontWeight.w800,
            fontSize: 14,
            letterSpacing: 0.4,
          );
        }
        return const TextStyle(
          color: purpleUnselectedFg,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: purpleSelectedFg, size: 24);
        }
        return const IconThemeData(color: purpleUnselectedFg, size: 22);
      },
    ),
  );

  final Widget section3 = sectionCard(
    title: '3. Elevation, shadowColor, stadium indicator (deep purple)',
    description:
        'elevation determines the implicit Material elevation of the drawer '
        'surface. shadowColor controls the cast shadow. indicatorShape can '
        'be any ShapeBorder - here a StadiumBorder gives a pill-shaped '
        'selection capsule. indicatorSize fixes the highlight footprint so '
        'all destinations have a uniform highlight regardless of label width.',
    body: themedDrawerBox(
      theme: purpleTheme,
      initialIndex: 1,
      paletteBackdrop: purpleBg,
    ),
    footer: 'shadowColor is composited at the configured elevation - lower '
        'elevation values dampen the visible cast.',
  );

  // ===========================================================================
  // SECTION 4 - ICON THEME + LABEL TEXT STYLE EMPHASIS (TEAL)
  // Selected destinations get larger bolder labels and bigger icons. This
  // section is purely about the WidgetStateProperty resolvers.
  // ===========================================================================

  final NavigationDrawerThemeData tealTheme = NavigationDrawerThemeData(
    backgroundColor: tealBg,
    surfaceTintColor: tealTint,
    indicatorColor: tealIndicator,
    indicatorShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    indicatorSize: const Size(256, 50),
    elevation: 1,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return TextStyle(
            color: Colors.grey.shade400,
            fontStyle: FontStyle.italic,
          );
        }
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: tealSelectedFg,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            letterSpacing: 0.3,
          );
        }
        return const TextStyle(
          color: tealUnselectedFg,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        );
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return IconThemeData(color: Colors.grey.shade400, size: 20);
        }
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: tealSelectedFg, size: 26);
        }
        return const IconThemeData(color: tealUnselectedFg, size: 22);
      },
    ),
  );

  final Widget section4 = sectionCard(
    title: '4. WidgetStateProperty resolvers (teal)',
    description:
        'labelTextStyle and iconTheme are WidgetStateProperty<T?>. The '
        'resolver receives the destination current Set<WidgetState>. We '
        'inspect that set for WidgetState.selected and WidgetState.disabled '
        'and return different TextStyle / IconThemeData accordingly. Notice '
        'the selected destination has a bigger, bolder label and a slightly '
        'larger icon - all driven by state, not by per-destination overrides.',
    body: themedDrawerBox(
      theme: tealTheme,
      initialIndex: 2,
      paletteBackdrop: const Color(0xFFB2DFDB),
    ),
    footer: 'The same pattern is what NavigationBarTheme, NavigationRailTheme, '
        'and SegmentedButtonTheme use - learn it once, reuse it everywhere.',
  );

  // ===========================================================================
  // SECTION 5 - REAL SCAFFOLD.DRAWER (BLUE GREY)
  // Wires the themed NavigationDrawer into Scaffold.drawer so it opens via
  // the AppBar menu icon - the real production wiring.
  // ===========================================================================

  final NavigationDrawerThemeData blueGreyTheme = NavigationDrawerThemeData(
    backgroundColor: bgBlueGreyBg,
    surfaceTintColor: bgBlueGreyTint,
    indicatorColor: bgBlueGreyIndicator,
    indicatorShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    indicatorSize: const Size(260, 46),
    elevation: 4,
    tileHeight: 56,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: bgBlueGreySelectedFg,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          );
        }
        return const TextStyle(
          color: bgBlueGreyUnselectedFg,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: bgBlueGreySelectedFg, size: 24);
        }
        return const IconThemeData(color: bgBlueGreyUnselectedFg, size: 22);
      },
    ),
  );

  final Widget section5 = sectionCard(
    title: '5. Real Scaffold.drawer wiring (blue grey)',
    description:
        'A NavigationDrawer normally lives in Scaffold.drawer. Here we wrap '
        'the Scaffold in a NavigationDrawerTheme so the drawer inherits the '
        'blue-grey palette. Tap the menu icon to open it. We also set '
        'tileHeight=56 to demonstrate vertical density tuning.',
    body: scaffoldDrawerBox(
      theme: blueGreyTheme,
      initialIndex: 0,
      label: 'Scaffold + themed drawer',
      appBarColor: bgBlueGreyIndicator,
    ),
    footer: 'tileHeight overrides the default destination row height. Use '
        'larger values for accessibility, smaller for dense desktop UIs.',
  );

  // ===========================================================================
  // SECTION 6 - BRAND CUSTOM PALETTE
  // ===========================================================================

  final NavigationDrawerThemeData brandTheme = NavigationDrawerThemeData(
    backgroundColor: brandBg,
    surfaceTintColor: brandTint,
    indicatorColor: brandIndicator,
    indicatorShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    indicatorSize: const Size(252, 50),
    elevation: 6,
    shadowColor: brandShadow,
    tileHeight: 60,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: brandSelectedFg,
            fontWeight: FontWeight.w800,
            fontSize: 15,
            letterSpacing: 0.5,
          );
        }
        return const TextStyle(
          color: brandUnselectedFg,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        );
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: brandSelectedFg, size: 26);
        }
        return const IconThemeData(color: brandUnselectedFg, size: 22);
      },
    ),
  );

  final Widget section6 = sectionCard(
    title: '6. Brand custom palette',
    description:
        'A bespoke palette using a custom Color hex value (no Material colors) '
        'illustrates that NavigationDrawerThemeData accepts any Color you can '
        'construct. Use this approach to align drawers with your brand book.',
    body: themedDrawerBox(
      theme: brandTheme,
      initialIndex: 3,
      paletteBackdrop: const Color(0xFFFFE0B2),
    ),
    footer: 'When the brand palette is reused across many widgets, define '
        'the colors as static class constants and import them everywhere.',
  );

  // ===========================================================================
  // SECTION 7 - ELEVATION VARIATIONS SIDE BY SIDE
  // Three identical drawer themes differing only in elevation. Confirms that
  // elevation is independent of color choice and shadowColor.
  // ===========================================================================

  NavigationDrawerThemeData forestThemeAt(double elev) {
    return NavigationDrawerThemeData(
      backgroundColor: forestBg,
      surfaceTintColor: forestTint,
      indicatorColor: forestIndicator,
      indicatorShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      indicatorSize: const Size(248, 48),
      elevation: elev,
      shadowColor: forestShadow,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: forestSelectedFg,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            );
          }
          return const TextStyle(
            color: forestUnselectedFg,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          );
        },
      ),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: forestSelectedFg, size: 24);
          }
          return const IconThemeData(color: forestUnselectedFg, size: 22);
        },
      ),
    );
  }

  Widget elevationLane(double elev) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 4),
            child: Text(
              'elevation: ${elev.toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            width: 320,
            height: 360,
            child: Material(
              type: MaterialType.transparency,
              child: NavigationDrawerTheme(
                data: forestThemeAt(elev),
                child: NavigationDrawer(
                  selectedIndex: 0,
                  onDestinationSelected: (_) {},
                  children: standardDestinations(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section7 = sectionCard(
    title: '7. Elevation variations (forest)',
    description:
        'Three drawers, identical except for elevation: 0, 6, and 16. The '
        'shadow grows progressively, confirming that elevation drives the '
        'cast shadow and surfaceTintColor blend without altering background '
        'or indicator hues.',
    body: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          elevationLane(0),
          elevationLane(6),
          elevationLane(16),
        ],
      ),
    ),
    footer: 'In Material 3, surfaceTintColor blends with backgroundColor as '
        'a function of elevation - higher elevation, more tint shows through.',
  );

  // ===========================================================================
  // SECTION 8 - INHERITED WIDGET vs THEMEDATA(navigationDrawerTheme: ...)
  // Side-by-side comparison: same theme reached two different ways.
  // ===========================================================================

  final NavigationDrawerThemeData roseTheme = NavigationDrawerThemeData(
    backgroundColor: roseBg,
    surfaceTintColor: roseTint,
    indicatorColor: roseIndicator,
    indicatorShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
    indicatorSize: const Size(248, 48),
    elevation: 3,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: roseSelectedFg,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          );
        }
        return const TextStyle(
          color: roseUnselectedFg,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: roseSelectedFg, size: 24);
        }
        return const IconThemeData(color: roseUnselectedFg, size: 22);
      },
    ),
  );

  Widget inheritedLane = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(bottom: 6, left: 4),
        child: Text(
          'NavigationDrawerTheme inherited widget',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ),
      SizedBox(
        width: 320,
        height: 360,
        child: Material(
          type: MaterialType.transparency,
          child: NavigationDrawerTheme(
            data: roseTheme,
            child: NavigationDrawer(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              children: standardDestinations(),
            ),
          ),
        ),
      ),
    ],
  );

  Widget themeDataLane = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(bottom: 6, left: 4),
        child: Text(
          'ThemeData(navigationDrawerTheme: ...)',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ),
      SizedBox(
        width: 320,
        height: 360,
        child: Theme(
          data: ThemeData(
            useMaterial3: true,
            navigationDrawerTheme: roseTheme,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: NavigationDrawer(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              children: standardDestinations(),
            ),
          ),
        ),
      ),
    ],
  );

  final Widget section8 = sectionCard(
    title: '8. Inherited widget vs ThemeData (rose)',
    description:
        'Same NavigationDrawerThemeData, two delivery routes. Left: a '
        'NavigationDrawerTheme inherited widget directly above the drawer. '
        'Right: a Theme widget supplying a ThemeData whose '
        'navigationDrawerTheme field carries the same data. Both produce '
        'identical visuals because NavigationDrawerTheme.of falls back to '
        'Theme.of(context).navigationDrawerTheme when no inherited theme is '
        'found.',
    body: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          inheritedLane,
          const SizedBox(width: 24),
          themeDataLane,
        ],
      ),
    ),
    footer: 'Use ThemeData.navigationDrawerTheme for app-wide defaults. Use '
        'NavigationDrawerTheme to override locally for one screen.',
  );

  // ===========================================================================
  // SECTION 9 - DEBUG-STYLE READOUT VIA NavigationDrawerTheme.of(context)
  // We use a Builder under a NavigationDrawerTheme to show what .of() returns.
  // ===========================================================================

  final NavigationDrawerThemeData slateTheme = NavigationDrawerThemeData(
    backgroundColor: slateBg,
    surfaceTintColor: slateTint,
    indicatorColor: slateIndicator,
    indicatorShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    indicatorSize: const Size(252, 48),
    elevation: 2,
    tileHeight: 54,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: slateSelectedFg,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          );
        }
        return const TextStyle(
          color: slateUnselectedFg,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: slateSelectedFg, size: 24);
        }
        return const IconThemeData(color: slateUnselectedFg, size: 22);
      },
    ),
  );

  Widget readoutRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section9 = sectionCard(
    title: '9. NavigationDrawerTheme.of(context) readout (slate)',
    description:
        'Wrap a Builder in a NavigationDrawerTheme, then call '
        'NavigationDrawerTheme.of(context) inside the builder. This is what '
        'every NavigationDrawer descendant does internally - we just print '
        'the result so you can see the resolved data.',
    body: NavigationDrawerTheme(
      data: slateTheme,
      child: Builder(
        builder: (BuildContext ctx) {
          final NavigationDrawerThemeData resolved =
              NavigationDrawerTheme.of(ctx);
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black12),
            ),
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 304,
                  height: 380,
                  child: Material(
                    type: MaterialType.transparency,
                    child: NavigationDrawer(
                      selectedIndex: 1,
                      onDestinationSelected: (_) {},
                      children: standardDestinations(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'NavigationDrawerTheme.of(context) ->',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        readoutRow(
                          'backgroundColor',
                          '${resolved.backgroundColor}',
                        ),
                        readoutRow(
                          'surfaceTintColor',
                          '${resolved.surfaceTintColor}',
                        ),
                        readoutRow(
                          'indicatorColor',
                          '${resolved.indicatorColor}',
                        ),
                        readoutRow(
                          'indicatorShape',
                          '${resolved.indicatorShape}',
                        ),
                        readoutRow(
                          'indicatorSize',
                          '${resolved.indicatorSize}',
                        ),
                        readoutRow(
                          'elevation',
                          '${resolved.elevation}',
                        ),
                        readoutRow(
                          'shadowColor',
                          '${resolved.shadowColor}',
                        ),
                        readoutRow(
                          'tileHeight',
                          '${resolved.tileHeight}',
                        ),
                        readoutRow(
                          'labelTextStyle',
                          resolved.labelTextStyle == null
                              ? 'null'
                              : 'WidgetStateProperty<TextStyle?>',
                        ),
                        readoutRow(
                          'iconTheme',
                          resolved.iconTheme == null
                              ? 'null'
                              : 'WidgetStateProperty<IconThemeData?>',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
    footer: 'Note: when you wrap with the inherited widget, .of(context) '
        'returns the inherited data verbatim. Without the wrapper it returns '
        'Theme.of(context).navigationDrawerTheme.',
  );

  // ===========================================================================
  // SECTION 10 - EDUCATIONAL SUMMARY
  // ===========================================================================

  final Widget section10 = sectionCard(
    title: '10. When to use which form',
    description:
        'A short rules-of-thumb summary so you can pick the right tool fast.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _BulletLine(
          title: 'ThemeData.navigationDrawerTheme',
          body:
              'App-wide defaults. Set this once on your top-level ThemeData '
              'and every NavigationDrawer in the app inherits it. Use for '
              'consistent branding across the whole product.',
        ),
        SizedBox(height: 6),
        _BulletLine(
          title: 'NavigationDrawerTheme inherited widget',
          body:
              'Local override. Wrap one screen, dialog, or feature subtree '
              'with a different palette without affecting the rest of the '
              'app. The .of() lookup walks up to the closest one.',
        ),
        SizedBox(height: 6),
        _BulletLine(
          title: 'WidgetStateProperty.resolveWith',
          body:
              'Used in labelTextStyle and iconTheme. The framework hands you '
              'a Set<WidgetState> describing the destination current state '
              '(selected, hovered, focused, disabled). Return the styling '
              'for that state. Always handle the empty-set case as the '
              'default unselected style.',
        ),
        SizedBox(height: 6),
        _BulletLine(
          title: 'indicatorShape + indicatorSize together',
          body:
              'indicatorSize fixes the highlight footprint per destination. '
              'indicatorShape decides whether that footprint is a stadium, '
              'rounded rectangle, or any custom ShapeBorder. They work '
              'independently of the destination tile height set by tileHeight.',
        ),
        SizedBox(height: 6),
        _BulletLine(
          title: 'elevation + shadowColor + surfaceTintColor',
          body:
              'In Material 3, elevation drives both the cast shadow '
              '(modulated by shadowColor) and a tonal blend that mixes '
              'surfaceTintColor into backgroundColor. Tune all three for '
              'depth control.',
        ),
      ],
    ),
    footer:
        'A single ThemeData.navigationDrawerTheme covers 95 percent of apps. '
        'Reach for the inherited widget only when you need a localized look.',
  );

  // ===========================================================================
  // PROGRAMMATIC SUMMARY (printed for log inspection)
  // ===========================================================================

  final List<Map<String, String>> summary = <Map<String, String>>[
    <String, String>{
      'section': '1. baseline',
      'palette': 'system default',
      'elevation': '(default)',
      'indicatorShape': '(default)',
    },
    <String, String>{
      'section': '2. inherited indigo',
      'palette': 'indigo',
      'elevation': '2',
      'indicatorShape': 'RoundedRectangleBorder(12)',
    },
    <String, String>{
      'section': '3. shadow purple',
      'palette': 'deepPurple',
      'elevation': '8',
      'indicatorShape': 'StadiumBorder',
    },
    <String, String>{
      'section': '4. resolver teal',
      'palette': 'teal',
      'elevation': '1',
      'indicatorShape': 'RoundedRectangleBorder(8)',
    },
    <String, String>{
      'section': '5. scaffold blueGrey',
      'palette': 'blueGrey',
      'elevation': '4',
      'indicatorShape': 'RoundedRectangleBorder(4)',
    },
    <String, String>{
      'section': '6. brand custom',
      'palette': 'brand orange',
      'elevation': '6',
      'indicatorShape': 'RoundedRectangleBorder(20)',
    },
    <String, String>{
      'section': '7. elevation lanes',
      'palette': 'forest',
      'elevation': '0 / 6 / 16',
      'indicatorShape': 'RoundedRectangleBorder(10)',
    },
    <String, String>{
      'section': '8. inherited vs ThemeData',
      'palette': 'rose',
      'elevation': '3',
      'indicatorShape': 'RoundedRectangleBorder(14)',
    },
    <String, String>{
      'section': '9. readout',
      'palette': 'slate',
      'elevation': '2',
      'indicatorShape': 'RoundedRectangleBorder(6)',
    },
  ];

  for (final Map<String, String> row in summary) {
    print('  ${row['section']} -> palette=${row['palette']}, '
        'elevation=${row['elevation']}, shape=${row['indicatorShape']}');
  }

  // ===========================================================================
  // RETURN APP
  // ===========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'NavigationDrawerTheme deep demo',
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('NavigationDrawerTheme Deep Demo'),
        backgroundColor: const Color(0xFF263238),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Text(
                  'NavigationDrawerTheme & NavigationDrawerThemeData',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: Text(
                  'Ten side-by-side scenarios demonstrating every property '
                  'on NavigationDrawerThemeData and the two routes for '
                  'supplying it: the NavigationDrawerTheme inherited widget '
                  'and ThemeData.navigationDrawerTheme.',
                  style: TextStyle(fontSize: 14, height: 1.5),
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
              section9,
              section10,
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SUPPORT WIDGETS
// =============================================================================

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 6, color: Colors.black54),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.45,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: '$title  ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
