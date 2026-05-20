// D4rt test script: Deep Demo - ToggleButtons
// Comprehensive visual demonstration of the Material ToggleButtons widget.
// Covers single-select, multi-select, icon-only, text-only, vertical
// orientation, custom colors, custom borders, mixed icon+text, formatting
// toolbars, alignment pickers, settings panels, day-of-week pickers,
// disabled state demos and a composed showcase. Every section is manually
// authored, with its own colour palette and surface treatment.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PALETTE COLOR CONSTANTS
  // ===========================================================================

  const Color paletteInk = Color(0xFF131322);
  const Color paletteInkSoft = Color(0xFF3F4067);
  const Color paletteInkMuted = Color(0xFF6E708F);
  const Color paletteSurface = Color(0xFFF7F6FB);
  const Color paletteSurfaceAlt = Color(0xFFEDEAF6);
  const Color paletteOutline = Color(0xFFDAD5E8);

  const Color paletteIndigo = Color(0xFF3F51B5);
  const Color paletteIndigoSoft = Color(0xFFE0E3FA);
  const Color paletteViolet = Color(0xFF6750A4);
  const Color paletteVioletSoft = Color(0xFFEADDFF);
  const Color paletteTeal = Color(0xFF00897B);
  const Color paletteTealSoft = Color(0xFFD0F0EC);
  const Color paletteAmber = Color(0xFFB36100);
  const Color paletteAmberSoft = Color(0xFFFFE6C2);
  const Color paletteRose = Color(0xFFC2185B);
  const Color paletteRoseSoft = Color(0xFFFAD7E4);
  const Color paletteEmerald = Color(0xFF1B873F);
  const Color paletteEmeraldSoft = Color(0xFFD7F5DC);
  const Color paletteCobalt = Color(0xFF1565C0);
  const Color paletteCobaltSoft = Color(0xFFD6E7FA);
  const Color paletteCoral = Color(0xFFE64A19);
  const Color paletteCoralSoft = Color(0xFFFCDCCC);
  const Color paletteSlate = Color(0xFF455A64);
  const Color paletteSlateSoft = Color(0xFFD7E0E5);
  const Color palettePlum = Color(0xFF7B1FA2);
  const Color palettePlumSoft = Color(0xFFE9D7F1);
  const Color paletteForest = Color(0xFF2E7D32);
  const Color paletteForestSoft = Color(0xFFD4ECD6);

  // ===========================================================================
  // SHARED SECTION SHELL HELPER
  // ===========================================================================

  Widget sectionShell({
    required String title,
    required String subtitle,
    required Color surface,
    required Color border,
    required Color titleColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: border, width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: titleColor.withValues(alpha: 0.12),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  titleColor.withValues(alpha: 0.16),
                  titleColor.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19.0),
                topRight: Radius.circular(19.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 8.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: titleColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: paletteInkSoft,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 22.0),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget chipBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget infoLine(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 90.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: accent,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: paletteInk,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget narrativeNote(String text, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: accent, width: 4.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: paletteInk,
          fontSize: 12.5,
          height: 1.5,
        ),
      ),
    );
  }

  // ===========================================================================
  // HERO BANNER
  // ===========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1A1B41),
          Color(0xFF4C3A8C),
          Color(0xFF8E7CC3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.28),
          blurRadius: 24.0,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.4,
                ),
              ),
              child: const Icon(
                Icons.toggle_on,
                color: Colors.white,
                size: 38.0,
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Material ToggleButtons — Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'Single-select, multi-select, icon, text, vertical, '
                    'custom colours, borders, toolbars, pickers — all '
                    'authored by hand and interpreted via D4rt.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.94),
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chipBadge('ToggleButtons', Colors.white),
            chipBadge('isSelected', Colors.white),
            chipBadge('onPressed', Colors.white),
            chipBadge('selectedColor', Colors.white),
            chipBadge('fillColor', Colors.white),
            chipBadge('borderColor', Colors.white),
            chipBadge('borderRadius', Colors.white),
            chipBadge('direction', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 01 — BASIC 3-BUTTON SINGLE-SELECT
  // ===========================================================================

  final Widget section01 = sectionShell(
    title: '01 — Basic Single-Select',
    subtitle:
        'Three exclusive options. Tapping a button selects only itself and '
        'deselects the others. The classic radio-style behaviour.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteIndigo,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> selection = <bool>[true, false, false];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'Single-select toggle groups behave like a segmented control. '
              'They are perfect for switching between mutually exclusive '
              'view modes such as List / Grid / Compact.',
              paletteIndigo,
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ToggleButtons(
                isSelected: selection,
                onPressed: (int i) {
                  setState(() {
                    for (int j = 0; j < selection.length; j++) {
                      selection[j] = j == i;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(10.0),
                selectedColor: Colors.white,
                fillColor: paletteIndigo,
                color: paletteIndigo,
                borderColor: paletteIndigo,
                selectedBorderColor: paletteIndigo,
                constraints: const BoxConstraints(
                  minHeight: 44.0,
                  minWidth: 96.0,
                ),
                children: const <Widget>[
                  Text('List'),
                  Text('Grid'),
                  Text('Compact'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: paletteIndigoSoft.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  infoLine(
                    'pattern',
                    'one-of-many (only one element can be true)',
                    paletteIndigo,
                  ),
                  infoLine(
                    'callback',
                    'flip booleans manually inside onPressed',
                    paletteIndigo,
                  ),
                  infoLine(
                    'a11y',
                    'reads as a segmented button group',
                    paletteIndigo,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 02 — MULTI-SELECT
  // ===========================================================================

  final Widget section02 = sectionShell(
    title: '02 — Multi-Select Filter',
    subtitle:
        'Any number of buttons can be toggled on simultaneously. Useful for '
        'filter chips, capability checkboxes, or tag pickers.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteTeal,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> filters = <bool>[true, false, true, false, true];
        const List<String> labels = <String>[
          'Wi-Fi',
          'Pets',
          'Pool',
          'Gym',
          'Parking',
        ];
        const List<IconData> icons = <IconData>[
          Icons.wifi,
          Icons.pets,
          Icons.pool,
          Icons.fitness_center,
          Icons.local_parking,
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'The handler simply inverts the boolean at the given index. '
              'No deselection of the others happens.',
              paletteTeal,
            ),
            const SizedBox(height: 12.0),
            Center(
              child: ToggleButtons(
                isSelected: filters,
                onPressed: (int i) {
                  setState(() {
                    filters[i] = !filters[i];
                  });
                },
                borderRadius: BorderRadius.circular(28.0),
                selectedColor: Colors.white,
                fillColor: paletteTeal,
                color: paletteTeal,
                borderColor: paletteTeal,
                selectedBorderColor: paletteTeal,
                borderWidth: 1.6,
                constraints: const BoxConstraints(
                  minHeight: 56.0,
                  minWidth: 78.0,
                ),
                children: List<Widget>.generate(labels.length, (int idx) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(icons[idx], size: 18.0),
                        const SizedBox(height: 3.0),
                        Text(
                          labels[idx],
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List<Widget>.generate(labels.length, (int idx) {
                final bool active = filters[idx];
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? paletteTealSoft.withValues(alpha: 0.85)
                        : paletteSurfaceAlt,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: active
                          ? paletteTeal.withValues(alpha: 0.55)
                          : paletteOutline,
                    ),
                  ),
                  child: Text(
                    '${labels[idx]}: ${active ? "ON" : "off"}',
                    style: TextStyle(
                      color: active ? paletteTeal : paletteInkMuted,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 03 — ICON-ONLY TOGGLE GROUP
  // ===========================================================================

  final Widget section03 = sectionShell(
    title: '03 — Icon-Only Compact Group',
    subtitle:
        'Icons without labels are great for crowded toolbars. We pair them '
        'with tooltips for discoverability, even though only the visuals '
        'matter for ToggleButtons itself.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteRose,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> icons = <bool>[
          false,
          true,
          false,
          true,
          false,
          true,
        ];
        const List<IconData> iconList = <IconData>[
          Icons.favorite,
          Icons.star,
          Icons.bookmark,
          Icons.flag,
          Icons.label,
          Icons.share,
        ];
        const List<String> tooltips = <String>[
          'Like',
          'Star',
          'Bookmark',
          'Flag',
          'Label',
          'Share',
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'Icon-only buttons keep the row tight. Combined with hover '
              'tooltips they remain accessible for power users.',
              paletteRose,
            ),
            const SizedBox(height: 12.0),
            Center(
              child: ToggleButtons(
                isSelected: icons,
                onPressed: (int i) {
                  setState(() {
                    icons[i] = !icons[i];
                  });
                },
                borderRadius: BorderRadius.circular(8.0),
                selectedColor: Colors.white,
                fillColor: paletteRose,
                color: paletteRose,
                borderColor: paletteRose.withValues(alpha: 0.6),
                selectedBorderColor: paletteRose,
                constraints: const BoxConstraints(
                  minHeight: 42.0,
                  minWidth: 50.0,
                ),
                children: List<Widget>.generate(iconList.length, (int idx) {
                  return Tooltip(
                    message: tooltips[idx],
                    child: Icon(iconList[idx], size: 20.0),
                  );
                }),
              ),
            ),
            const SizedBox(height: 14.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: paletteRoseSoft.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: List<Widget>.generate(tooltips.length, (int idx) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: icons[idx]
                          ? paletteRose
                          : Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: paletteRose.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      tooltips[idx],
                      style: TextStyle(
                        color: icons[idx] ? Colors.white : paletteRose,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 04 — TEXT-ONLY PRICING PERIOD SELECTOR
  // ===========================================================================

  final Widget section04 = sectionShell(
    title: '04 — Text-Only Period Selector',
    subtitle:
        'Pure text labels with generous padding. This style is common on '
        'pricing pages where the buttons feel like real pills.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteViolet,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> period = <bool>[true, false, false];
        const List<String> labels = <String>[
          'Monthly',
          'Annual',
          'Lifetime',
        ];
        const List<String> hints = <String>[
          '\$9.99 / mo',
          '\$99 / yr (save 17%)',
          '\$299 once',
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'Wider constraints and a large pill radius make the buttons '
              'feel like premium pricing controls.',
              paletteViolet,
            ),
            const SizedBox(height: 14.0),
            Center(
              child: ToggleButtons(
                isSelected: period,
                onPressed: (int i) {
                  setState(() {
                    for (int j = 0; j < period.length; j++) {
                      period[j] = j == i;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(40.0),
                selectedColor: Colors.white,
                fillColor: paletteViolet,
                color: paletteViolet,
                borderColor: paletteViolet,
                selectedBorderColor: paletteViolet,
                borderWidth: 1.4,
                constraints: const BoxConstraints(
                  minHeight: 52.0,
                  minWidth: 140.0,
                ),
                children: List<Widget>.generate(labels.length, (int idx) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      labels[idx],
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 18.0),
            Row(
              children: List<Widget>.generate(labels.length, (int idx) {
                final bool active = period[idx];
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: active ? paletteVioletSoft : paletteSurfaceAlt,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: active ? paletteViolet : paletteOutline,
                        width: active ? 1.6 : 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          labels[idx],
                          style: TextStyle(
                            color: paletteViolet,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          hints[idx],
                          style: TextStyle(
                            color: paletteInkSoft,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 05 — VERTICAL ORIENTATION
  // ===========================================================================

  final Widget section05 = sectionShell(
    title: '05 — Vertical Orientation',
    subtitle:
        'Set direction to Axis.vertical and the buttons stack top-to-bottom. '
        'Good for side panels, tool rails, and column-based UIs.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteCobalt,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> verticalSel = <bool>[false, true, false, false];
        const List<IconData> icons = <IconData>[
          Icons.dashboard,
          Icons.inventory_2,
          Icons.analytics,
          Icons.settings,
        ];
        const List<String> labels = <String>[
          'Dashboard',
          'Inventory',
          'Analytics',
          'Settings',
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'A vertical ToggleButtons can serve as a sidebar nav. The '
              'callback still receives a flat index — orientation is purely '
              'visual.',
              paletteCobalt,
            ),
            const SizedBox(height: 12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ToggleButtons(
                  isSelected: verticalSel,
                  direction: Axis.vertical,
                  onPressed: (int i) {
                    setState(() {
                      for (int j = 0; j < verticalSel.length; j++) {
                        verticalSel[j] = j == i;
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(12.0),
                  selectedColor: Colors.white,
                  fillColor: paletteCobalt,
                  color: paletteCobalt,
                  borderColor: paletteCobalt,
                  selectedBorderColor: paletteCobalt,
                  constraints: const BoxConstraints(
                    minHeight: 64.0,
                    minWidth: 64.0,
                  ),
                  children: List<Widget>.generate(icons.length, (int idx) {
                    return Icon(icons[idx], size: 24.0);
                  }),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: paletteCobaltSoft.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: paletteCobalt.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List<Widget>.generate(labels.length, (
                        int idx,
                      ) {
                        final bool active = verticalSel[idx];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 12.0,
                                height: 12.0,
                                decoration: BoxDecoration(
                                  color: active
                                      ? paletteCobalt
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                    color: paletteCobalt,
                                    width: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                labels[idx],
                                style: TextStyle(
                                  color: active
                                      ? paletteCobalt
                                      : paletteInkSoft,
                                  fontSize: 13.0,
                                  fontWeight: active
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 06 — CUSTOM COLOR SYSTEM
  // ===========================================================================

  final Widget section06 = sectionShell(
    title: '06 — Custom Colour System',
    subtitle:
        'All colour knobs are wired up: color, selectedColor, fillColor, '
        'borderColor, selectedBorderColor, disabledBorderColor, '
        'splashColor, focusColor, hoverColor and highlightColor.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAmber,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> tones = <bool>[false, true, false];
        const List<String> labels = <String>['Light', 'Medium', 'Bold'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'Every interaction colour is overridable. Hovering or '
              'focusing the toggle still respects the disabled vs selected '
              'colour rules.',
              paletteAmber,
            ),
            const SizedBox(height: 14.0),
            Center(
              child: ToggleButtons(
                isSelected: tones,
                onPressed: (int i) {
                  setState(() {
                    for (int j = 0; j < tones.length; j++) {
                      tones[j] = j == i;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(14.0),
                color: paletteAmber,
                selectedColor: Colors.white,
                fillColor: paletteAmber,
                disabledColor: paletteInkMuted,
                disabledBorderColor: paletteOutline,
                borderColor: paletteAmber.withValues(alpha: 0.5),
                selectedBorderColor: paletteAmber,
                splashColor: paletteAmber.withValues(alpha: 0.35),
                focusColor: paletteAmber.withValues(alpha: 0.25),
                hoverColor: paletteAmber.withValues(alpha: 0.15),
                highlightColor: paletteAmber.withValues(alpha: 0.18),
                borderWidth: 1.8,
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                  minWidth: 110.0,
                ),
                children: List<Widget>.generate(labels.length, (int idx) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      labels[idx],
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 18.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: paletteAmberSoft.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: <Widget>[
                  infoLine('color', 'unselected foreground', paletteAmber),
                  infoLine(
                    'selectedColor',
                    'foreground when selected',
                    paletteAmber,
                  ),
                  infoLine(
                    'fillColor',
                    'background when selected',
                    paletteAmber,
                  ),
                  infoLine(
                    'borderColor',
                    'outline colour when not selected',
                    paletteAmber,
                  ),
                  infoLine(
                    'splashColor',
                    'ripple colour on tap',
                    paletteAmber,
                  ),
                  infoLine(
                    'hoverColor',
                    'tint on pointer hover',
                    paletteAmber,
                  ),
                  infoLine(
                    'focusColor',
                    'tint when keyboard-focused',
                    paletteAmber,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 07 — CUSTOM BORDER RADIUS / WIDTH
  // ===========================================================================

  final Widget section07 = sectionShell(
    title: '07 — Custom Border Radius & Width',
    subtitle:
        'Compare different border treatments side by side. The same content '
        'with different radius and width values radically changes the feel.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteEmerald,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> sharp = <bool>[true, false, false];
        final List<bool> rounded = <bool>[false, true, false];
        final List<bool> pill = <bool>[false, false, true];
        final List<bool> thick = <bool>[false, true, false];
        const List<String> labels = <String>['A', 'B', 'C'];
        Widget row(
          String title,
          BorderRadius radius,
          double width,
          List<bool> selection,
          void Function() onTap,
        ) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: paletteEmerald,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                    ),
                  ),
                ),
                ToggleButtons(
                  isSelected: selection,
                  onPressed: (int i) {
                    setState(() {
                      for (int j = 0; j < selection.length; j++) {
                        selection[j] = j == i;
                      }
                    });
                    onTap();
                  },
                  borderRadius: radius,
                  borderWidth: width,
                  color: paletteEmerald,
                  selectedColor: Colors.white,
                  fillColor: paletteEmerald,
                  borderColor: paletteEmerald,
                  selectedBorderColor: paletteEmerald,
                  constraints: const BoxConstraints(
                    minHeight: 44.0,
                    minWidth: 56.0,
                  ),
                  children: List<Widget>.generate(labels.length, (int idx) {
                    return Text(
                      labels[idx],
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0,
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'Border radius affects only the outer corners — the dividers '
              'between buttons remain straight. Width applies uniformly.',
              paletteEmerald,
            ),
            row(
              'Sharp (r=2)',
              BorderRadius.circular(2.0),
              1.0,
              sharp,
              () {},
            ),
            row(
              'Soft (r=10)',
              BorderRadius.circular(10.0),
              1.4,
              rounded,
              () {},
            ),
            row(
              'Pill (r=40)',
              BorderRadius.circular(40.0),
              1.6,
              pill,
              () {},
            ),
            row(
              'Thick (w=3)',
              BorderRadius.circular(12.0),
              3.0,
              thick,
              () {},
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: paletteEmeraldSoft.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: <Widget>[
                  infoLine(
                    'radius',
                    'BorderRadius.circular(N) sets all corners',
                    paletteEmerald,
                  ),
                  infoLine(
                    'asymmetric',
                    'use BorderRadius.only for non-uniform',
                    paletteEmerald,
                  ),
                  infoLine(
                    'width',
                    'borderWidth applies to outer + dividers',
                    paletteEmerald,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 08 — MIXED ICON + TEXT
  // ===========================================================================

  final Widget section08 = sectionShell(
    title: '08 — Mixed Icon + Text',
    subtitle:
        'Each button carries an icon and a label. The icon teaches what the '
        'option does; the label disambiguates it.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: palettePlum,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> sel = <bool>[true, false, false, false];
        const List<IconData> icons = <IconData>[
          Icons.email,
          Icons.sms,
          Icons.phone,
          Icons.notifications_off,
        ];
        const List<String> labels = <String>[
          'Email',
          'SMS',
          'Call',
          'Silent',
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'Each child is a small Row with an icon followed by text. The '
              'whole row counts as one toggle entry.',
              palettePlum,
            ),
            const SizedBox(height: 12.0),
            Center(
              child: ToggleButtons(
                isSelected: sel,
                onPressed: (int i) {
                  setState(() {
                    for (int j = 0; j < sel.length; j++) {
                      sel[j] = j == i;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(12.0),
                color: palettePlum,
                selectedColor: Colors.white,
                fillColor: palettePlum,
                borderColor: palettePlum,
                selectedBorderColor: palettePlum,
                constraints: const BoxConstraints(
                  minHeight: 52.0,
                  minWidth: 110.0,
                ),
                children: List<Widget>.generate(labels.length, (int idx) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(icons[idx], size: 18.0),
                        const SizedBox(width: 8.0),
                        Text(
                          labels[idx],
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: List<Widget>.generate(labels.length, (int idx) {
                final bool active = sel[idx];
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: active
                          ? palettePlumSoft
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: active ? palettePlum : paletteOutline,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          icons[idx],
                          color: active ? palettePlum : paletteInkMuted,
                          size: 22.0,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          labels[idx],
                          style: TextStyle(
                            color: active ? palettePlum : paletteInkMuted,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 09 — FORMATTING TOOLBAR (BOLD / ITALIC / UNDERLINE)
  // ===========================================================================

  final Widget section09 = sectionShell(
    title: '09 — Formatting Toolbar',
    subtitle:
        'Classic rich-text editor toolbar. Each toggle is independent and '
        'affects only its own formatting bit on the selected text.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteSlate,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> formats = <bool>[true, true, false, false];
        const List<IconData> icons = <IconData>[
          Icons.format_bold,
          Icons.format_italic,
          Icons.format_underline,
          Icons.strikethrough_s,
        ];
        const List<String> names = <String>[
          'Bold',
          'Italic',
          'Underline',
          'Strike',
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'Multiple bits can be active at once — bold + italic + '
              'underline all together is perfectly fine.',
              paletteSlate,
            ),
            const SizedBox(height: 14.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: paletteSlateSoft.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: paletteSlate.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: <Widget>[
                  ToggleButtons(
                    isSelected: formats,
                    onPressed: (int i) {
                      setState(() {
                        formats[i] = !formats[i];
                      });
                    },
                    borderRadius: BorderRadius.circular(8.0),
                    color: paletteSlate,
                    selectedColor: Colors.white,
                    fillColor: paletteSlate,
                    borderColor: paletteSlate,
                    selectedBorderColor: paletteSlate,
                    constraints: const BoxConstraints(
                      minHeight: 38.0,
                      minWidth: 42.0,
                    ),
                    children: List<Widget>.generate(icons.length, (int idx) {
                      return Tooltip(
                        message: names[idx],
                        child: Icon(icons[idx], size: 18.0),
                      );
                    }),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    width: 1.0,
                    height: 30.0,
                    color: paletteSlate.withValues(alpha: 0.4),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      'The quick brown fox',
                      style: TextStyle(
                        fontWeight: formats[0]
                            ? FontWeight.w900
                            : FontWeight.w400,
                        fontStyle: formats[1]
                            ? FontStyle.italic
                            : FontStyle.normal,
                        decoration: TextDecoration.combine(<TextDecoration>[
                          if (formats[2]) TextDecoration.underline,
                          if (formats[3]) TextDecoration.lineThrough,
                        ]),
                        color: paletteInk,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 6.0,
              children: List<Widget>.generate(names.length, (int idx) {
                return chipBadge(
                  '${names[idx]}: ${formats[idx] ? "on" : "off"}',
                  paletteSlate,
                );
              }),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 10 — ALIGNMENT SELECTOR
  // ===========================================================================

  final Widget section10 = sectionShell(
    title: '10 — Text Alignment Selector',
    subtitle:
        'Four-way alignment chooser. Single-select semantics — only one '
        'alignment can be active at a time.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteCoral,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> align = <bool>[false, true, false, false];
        const List<IconData> icons = <IconData>[
          Icons.format_align_left,
          Icons.format_align_center,
          Icons.format_align_right,
          Icons.format_align_justify,
        ];
        const List<TextAlign> aligns = <TextAlign>[
          TextAlign.left,
          TextAlign.center,
          TextAlign.right,
          TextAlign.justify,
        ];
        const List<String> names = <String>[
          'Left',
          'Center',
          'Right',
          'Justify',
        ];
        int activeIdx = 1;
        for (int i = 0; i < align.length; i++) {
          if (align[i]) {
            activeIdx = i;
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'Pairing an icon group with a live preview pane is a great '
              'pattern for visual editors.',
              paletteCoral,
            ),
            const SizedBox(height: 12.0),
            Center(
              child: ToggleButtons(
                isSelected: align,
                onPressed: (int i) {
                  setState(() {
                    for (int j = 0; j < align.length; j++) {
                      align[j] = j == i;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(10.0),
                color: paletteCoral,
                selectedColor: Colors.white,
                fillColor: paletteCoral,
                borderColor: paletteCoral,
                selectedBorderColor: paletteCoral,
                constraints: const BoxConstraints(
                  minHeight: 44.0,
                  minWidth: 56.0,
                ),
                children: List<Widget>.generate(icons.length, (int idx) {
                  return Icon(icons[idx], size: 20.0);
                }),
              ),
            ),
            const SizedBox(height: 18.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: paletteCoralSoft.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: paletteCoral.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Preview — ${names[activeIdx]}',
                    style: TextStyle(
                      color: paletteCoral,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing '
                    'elit. Aliquam erat volutpat. Sed do eiusmod tempor '
                    'incididunt ut labore et dolore magna aliqua.',
                    textAlign: aligns[activeIdx],
                    style: const TextStyle(
                      color: paletteInk,
                      fontSize: 13.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 11 — SETTINGS PANEL CONTEXT
  // ===========================================================================

  final Widget section11 = sectionShell(
    title: '11 — Settings Panel Integration',
    subtitle:
        'ToggleButtons embedded as a value editor inside a labelled '
        'settings row. The selection drives a setting in the surrounding '
        'card.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteForest,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> themeSel = <bool>[false, true, false];
        final List<bool> densitySel = <bool>[true, false, false];
        final List<bool> motionSel = <bool>[false, false, true];
        const List<String> themes = <String>['Light', 'System', 'Dark'];
        const List<String> densities = <String>[
          'Cozy',
          'Default',
          'Compact',
        ];
        const List<String> motion = <String>['Off', 'Reduced', 'Full'];

        Widget settingRow(
          IconData icon,
          String label,
          String hint,
          List<bool> selection,
          List<String> labels,
          Color tone,
        ) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: paletteOutline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 36.0,
                      height: 36.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: tone.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(icon, color: tone, size: 20.0),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            label,
                            style: const TextStyle(
                              color: paletteInk,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            hint,
                            style: TextStyle(
                              color: paletteInkMuted,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Center(
                  child: ToggleButtons(
                    isSelected: selection,
                    onPressed: (int i) {
                      setState(() {
                        for (int j = 0; j < selection.length; j++) {
                          selection[j] = j == i;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    color: tone,
                    selectedColor: Colors.white,
                    fillColor: tone,
                    borderColor: tone,
                    selectedBorderColor: tone,
                    constraints: const BoxConstraints(
                      minHeight: 38.0,
                      minWidth: 90.0,
                    ),
                    children: List<Widget>.generate(labels.length, (int idx) {
                      return Text(
                        labels[idx],
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: <Widget>[
            settingRow(
              Icons.palette,
              'Appearance',
              'Choose the visual mode',
              themeSel,
              themes,
              paletteForest,
            ),
            settingRow(
              Icons.density_medium,
              'List Density',
              'How tightly items pack into the layout',
              densitySel,
              densities,
              paletteForest,
            ),
            settingRow(
              Icons.animation,
              'Motion',
              'Animation intensity throughout the app',
              motionSel,
              motion,
              paletteForest,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: paletteForestSoft.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.bolt, color: paletteForest, size: 18.0),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Each setting is its own ToggleButtons instance, so '
                      'changing one does not influence the others.',
                      style: TextStyle(
                        color: paletteInkSoft,
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 12 — DAY-OF-WEEK PICKER GRID
  // ===========================================================================

  final Widget section12 = sectionShell(
    title: '12 — Day-of-Week Picker',
    subtitle:
        'A row of seven equal-sized toggles. Multi-select semantics, ideal '
        'for repeat-on-days scheduling.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteIndigo,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> days = <bool>[
          true,
          true,
          true,
          true,
          true,
          false,
          false,
        ];
        const List<String> labels = <String>[
          'Mon',
          'Tue',
          'Wed',
          'Thu',
          'Fri',
          'Sat',
          'Sun',
        ];
        const List<String> short = <String>[
          'M',
          'T',
          'W',
          'T',
          'F',
          'S',
          'S',
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            narrativeNote(
              'A repeat-on-days control is one of the most idiomatic uses '
              'of ToggleButtons. Compact, scannable, multi-select.',
              paletteIndigo,
            ),
            const SizedBox(height: 14.0),
            Center(
              child: ToggleButtons(
                isSelected: days,
                onPressed: (int i) {
                  setState(() {
                    days[i] = !days[i];
                  });
                },
                borderRadius: BorderRadius.circular(50.0),
                color: paletteIndigo,
                selectedColor: Colors.white,
                fillColor: paletteIndigo,
                borderColor: paletteIndigo,
                selectedBorderColor: paletteIndigo,
                constraints: const BoxConstraints(
                  minHeight: 44.0,
                  minWidth: 44.0,
                ),
                children: List<Widget>.generate(short.length, (int idx) {
                  return Text(
                    short[idx],
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 18.0),
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: paletteIndigoSoft.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: paletteIndigo,
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Schedule summary',
                        style: TextStyle(
                          color: paletteIndigo,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: List<Widget>.generate(labels.length, (int idx) {
                      final bool on = days[idx];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          color: on ? paletteIndigo : Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: paletteIndigo),
                        ),
                        child: Text(
                          labels[idx],
                          style: TextStyle(
                            color: on ? Colors.white : paletteIndigo,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 13 — DISABLED STATE DEMOS
  // ===========================================================================

  final Widget section13 = sectionShell(
    title: '13 — Disabled State Variations',
    subtitle:
        'When onPressed is null, the whole ToggleButtons is disabled. '
        'disabledColor and disabledBorderColor control its muted look.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        narrativeNote(
          'Disabling a ToggleButtons is not the same as visually fading '
          'one button — the entire group is locked at its current state.',
          paletteAmber,
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: paletteAmberSoft.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: paletteAmber.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Disabled, value preserved',
                style: TextStyle(
                  color: paletteAmber,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: ToggleButtons(
                  isSelected: const <bool>[false, true, false],
                  onPressed: null,
                  borderRadius: BorderRadius.circular(10.0),
                  color: paletteAmber,
                  selectedColor: Colors.white,
                  fillColor: paletteAmber,
                  borderColor: paletteAmber,
                  selectedBorderColor: paletteAmber,
                  disabledColor: paletteInkMuted,
                  disabledBorderColor: paletteOutline,
                  constraints: const BoxConstraints(
                    minHeight: 44.0,
                    minWidth: 100.0,
                  ),
                  children: const <Widget>[
                    Text('Draft'),
                    Text('Review'),
                    Text('Live'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: paletteSurfaceAlt,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: paletteOutline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Disabled all-off — discoverable but inactive',
                style: TextStyle(
                  color: paletteInkSoft,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: ToggleButtons(
                  isSelected: const <bool>[false, false, false, false],
                  onPressed: null,
                  borderRadius: BorderRadius.circular(8.0),
                  color: paletteInkMuted,
                  selectedColor: Colors.white,
                  fillColor: paletteInkMuted,
                  borderColor: paletteOutline,
                  selectedBorderColor: paletteOutline,
                  disabledColor: paletteInkMuted,
                  disabledBorderColor: paletteOutline,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 70.0,
                  ),
                  children: const <Widget>[
                    Icon(Icons.format_bold, size: 18.0),
                    Icon(Icons.format_italic, size: 18.0),
                    Icon(Icons.format_underline, size: 18.0),
                    Icon(Icons.strikethrough_s, size: 18.0),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: paletteRoseSoft.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: paletteRose.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Mixed orientation — vertical disabled',
                style: TextStyle(
                  color: paletteRose,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: ToggleButtons(
                  isSelected: const <bool>[true, false, true],
                  direction: Axis.vertical,
                  onPressed: null,
                  borderRadius: BorderRadius.circular(10.0),
                  color: paletteRose,
                  selectedColor: Colors.white,
                  fillColor: paletteRose,
                  borderColor: paletteRose,
                  selectedBorderColor: paletteRose,
                  disabledColor: paletteInkMuted,
                  disabledBorderColor: paletteOutline,
                  constraints: const BoxConstraints(
                    minHeight: 44.0,
                    minWidth: 60.0,
                  ),
                  children: const <Widget>[
                    Icon(Icons.arrow_upward, size: 18.0),
                    Icon(Icons.remove, size: 18.0),
                    Icon(Icons.arrow_downward, size: 18.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 14 — COMPOSED SHOWCASE (EDITOR-LIKE)
  // ===========================================================================

  final Widget section14 = sectionShell(
    title: '14 — Composed Editor Showcase',
    subtitle:
        'A larger composition that combines many toggle groups into a '
        'single editor surface. Each group governs a different facet of '
        'the document.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteViolet,
    child: StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setState) {
        final List<bool> styleSel = <bool>[true, false, false];
        final List<bool> sizeSel = <bool>[false, true, false, false];
        final List<bool> alignSel = <bool>[false, true, false];
        final List<bool> formatSel = <bool>[true, false, true];
        const List<String> styles = <String>['Body', 'Title', 'Code'];
        const List<String> sizes = <String>['S', 'M', 'L', 'XL'];
        const List<IconData> alignIcons = <IconData>[
          Icons.format_align_left,
          Icons.format_align_center,
          Icons.format_align_right,
        ];
        const List<IconData> formatIcons = <IconData>[
          Icons.format_bold,
          Icons.format_italic,
          Icons.format_underline,
        ];

        int activeStyle = 0;
        for (int i = 0; i < styleSel.length; i++) {
          if (styleSel[i]) {
            activeStyle = i;
          }
        }
        int activeSize = 1;
        for (int i = 0; i < sizeSel.length; i++) {
          if (sizeSel[i]) {
            activeSize = i;
          }
        }
        int activeAlign = 1;
        for (int i = 0; i < alignSel.length; i++) {
          if (alignSel[i]) {
            activeAlign = i;
          }
        }
        const List<TextAlign> alignVals = <TextAlign>[
          TextAlign.left,
          TextAlign.center,
          TextAlign.right,
        ];
        const List<double> sizeVals = <double>[12.0, 16.0, 22.0, 30.0];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: paletteVioletSoft.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: paletteViolet.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.text_fields,
                        color: paletteViolet,
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Style',
                        style: TextStyle(
                          color: paletteViolet,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const Spacer(),
                      ToggleButtons(
                        isSelected: styleSel,
                        onPressed: (int i) {
                          setState(() {
                            for (int j = 0; j < styleSel.length; j++) {
                              styleSel[j] = j == i;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        color: paletteViolet,
                        selectedColor: Colors.white,
                        fillColor: paletteViolet,
                        borderColor: paletteViolet,
                        selectedBorderColor: paletteViolet,
                        constraints: const BoxConstraints(
                          minHeight: 32.0,
                          minWidth: 60.0,
                        ),
                        children: List<Widget>.generate(styles.length, (
                          int idx,
                        ) {
                          return Text(
                            styles[idx],
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.format_size,
                        color: paletteViolet,
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Size',
                        style: TextStyle(
                          color: paletteViolet,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const Spacer(),
                      ToggleButtons(
                        isSelected: sizeSel,
                        onPressed: (int i) {
                          setState(() {
                            for (int j = 0; j < sizeSel.length; j++) {
                              sizeSel[j] = j == i;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        color: paletteViolet,
                        selectedColor: Colors.white,
                        fillColor: paletteViolet,
                        borderColor: paletteViolet,
                        selectedBorderColor: paletteViolet,
                        constraints: const BoxConstraints(
                          minHeight: 32.0,
                          minWidth: 40.0,
                        ),
                        children: List<Widget>.generate(sizes.length, (
                          int idx,
                        ) {
                          return Text(
                            sizes[idx],
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.format_align_justify,
                        color: paletteViolet,
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Align',
                        style: TextStyle(
                          color: paletteViolet,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const Spacer(),
                      ToggleButtons(
                        isSelected: alignSel,
                        onPressed: (int i) {
                          setState(() {
                            for (int j = 0; j < alignSel.length; j++) {
                              alignSel[j] = j == i;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        color: paletteViolet,
                        selectedColor: Colors.white,
                        fillColor: paletteViolet,
                        borderColor: paletteViolet,
                        selectedBorderColor: paletteViolet,
                        constraints: const BoxConstraints(
                          minHeight: 32.0,
                          minWidth: 40.0,
                        ),
                        children: List<Widget>.generate(alignIcons.length, (
                          int idx,
                        ) {
                          return Icon(alignIcons[idx], size: 16.0);
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.format_color_text,
                        color: paletteViolet,
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Format',
                        style: TextStyle(
                          color: paletteViolet,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const Spacer(),
                      ToggleButtons(
                        isSelected: formatSel,
                        onPressed: (int i) {
                          setState(() {
                            formatSel[i] = !formatSel[i];
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        color: paletteViolet,
                        selectedColor: Colors.white,
                        fillColor: paletteViolet,
                        borderColor: paletteViolet,
                        selectedBorderColor: paletteViolet,
                        constraints: const BoxConstraints(
                          minHeight: 32.0,
                          minWidth: 40.0,
                        ),
                        children: List<Widget>.generate(formatIcons.length, (
                          int idx,
                        ) {
                          return Icon(formatIcons[idx], size: 16.0);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(20.0),
              constraints: const BoxConstraints(minHeight: 140.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: paletteOutline),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: paletteViolet.withValues(alpha: 0.08),
                    blurRadius: 10.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                activeStyle == 2
                    ? 'const message = "Hello, world!";'
                    : 'A composed editor showing how multiple ToggleButtons '
                          'work in concert to drive a real preview.',
                textAlign: alignVals[activeAlign],
                style: TextStyle(
                  color: paletteInk,
                  fontSize: sizeVals[activeSize],
                  fontWeight: activeStyle == 1
                      ? FontWeight.w900
                      : (formatSel[0] ? FontWeight.w800 : FontWeight.w400),
                  fontStyle: formatSel[1]
                      ? FontStyle.italic
                      : FontStyle.normal,
                  decoration: formatSel[2]
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  fontFamily: activeStyle == 2 ? 'monospace' : null,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: <Widget>[
                chipBadge('style=${styles[activeStyle]}', paletteViolet),
                chipBadge('size=${sizes[activeSize]}', paletteViolet),
                chipBadge('bold=${formatSel[0]}', paletteViolet),
                chipBadge('italic=${formatSel[1]}', paletteViolet),
                chipBadge('underline=${formatSel[2]}', paletteViolet),
              ],
            ),
          ],
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 15 — RECAP CARD
  // ===========================================================================

  final Widget section15 = sectionShell(
    title: '15 — Recap & API Cheatsheet',
    subtitle:
        'A quick reference for every constructor argument touched in this '
        'demo, plus best-practice guidance.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteSlate,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: paletteSlateSoft.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: <Widget>[
              infoLine(
                'isSelected',
                'List<bool> of identical length to children',
                paletteSlate,
              ),
              infoLine(
                'onPressed',
                'callback (int index) → mutate isSelected',
                paletteSlate,
              ),
              infoLine(
                'children',
                'List<Widget> — icons, text, or rows of both',
                paletteSlate,
              ),
              infoLine(
                'direction',
                'Axis.horizontal (default) or Axis.vertical',
                paletteSlate,
              ),
              infoLine(
                'borderRadius',
                'BorderRadius for outer corners',
                paletteSlate,
              ),
              infoLine(
                'borderWidth',
                'thickness of outer + divider strokes',
                paletteSlate,
              ),
              infoLine(
                'color',
                'foreground colour when unselected',
                paletteSlate,
              ),
              infoLine(
                'selectedColor',
                'foreground colour when selected',
                paletteSlate,
              ),
              infoLine(
                'fillColor',
                'background colour when selected',
                paletteSlate,
              ),
              infoLine(
                'disabledColor',
                'foreground colour when disabled',
                paletteSlate,
              ),
              infoLine(
                'borderColor',
                'outline when unselected',
                paletteSlate,
              ),
              infoLine(
                'selectedBorderColor',
                'outline when selected',
                paletteSlate,
              ),
              infoLine(
                'splashColor',
                'ripple colour when tapped',
                paletteSlate,
              ),
              infoLine(
                'hoverColor',
                'tint when pointer hovers',
                paletteSlate,
              ),
              infoLine(
                'focusColor',
                'tint when keyboard-focused',
                paletteSlate,
              ),
              infoLine(
                'constraints',
                'min/max sizes for every child cell',
                paletteSlate,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: paletteOutline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.lightbulb,
                    color: paletteAmber,
                    size: 18.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Best practices',
                    style: TextStyle(
                      color: paletteAmber,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                '• Use ToggleButtons for 2-7 options; for more, use a '
                'dropdown or chips.\n'
                '• Prefer ChoiceChip / FilterChip for free-flowing tag-like '
                'controls.\n'
                '• Wrap icon-only toggles with Tooltip to retain '
                'discoverability.\n'
                '• Always keep isSelected length equal to children length, '
                'otherwise Flutter asserts.\n'
                '• Pair single-select toggles with a clear default — never '
                'allow all-off if a value is required.',
                style: TextStyle(
                  color: paletteInkSoft,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                paletteViolet.withValues(alpha: 0.15),
                paletteIndigo.withValues(alpha: 0.10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.celebration,
                color: paletteViolet,
                size: 22.0,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'You have just seen 15 distinct ToggleButtons '
                  'compositions — every one of them authored from scratch '
                  'and interpreted live by D4rt.',
                  style: TextStyle(
                    color: paletteInk,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // ROOT SCAFFOLD
  // ===========================================================================

  return Scaffold(
    backgroundColor: paletteSurface,
    appBar: AppBar(
      backgroundColor: paletteViolet,
      foregroundColor: Colors.white,
      elevation: 4.0,
      title: const Text(
        'ToggleButtons — Deep Demo',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          letterSpacing: 0.4,
        ),
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'D4rt',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroBanner,
          section01,
          section02,
          section03,
          section04,
          section05,
          section06,
          section07,
          section08,
          section09,
          section10,
          section11,
          section12,
          section13,
          section14,
          section15,
          const SizedBox(height: 30.0),
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: paletteInk,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.toggle_on,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 28.0,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'End of ToggleButtons deep demo — generated by hand, '
                    'interpreted live, 15 sections strong.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    ),
  );
}
