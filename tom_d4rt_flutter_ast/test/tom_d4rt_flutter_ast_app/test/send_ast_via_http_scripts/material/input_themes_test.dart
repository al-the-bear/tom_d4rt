// D4rt test script: Deep Demo - InputDecorationTheme, InputDecoration
// Comprehensive visual demonstration of Material text-field theming.
// Covers filled, outlined, underlined, none borders, labelStyle,
// floatingLabelStyle, floatingLabelBehavior, hintStyle, helperStyle,
// errorStyle, prefixStyle, suffixStyle, contentPadding, isDense,
// isCollapsed, prefixIcon, suffixIcon, prefix/suffix Text widgets,
// counter customisation, errorBorder, focusedBorder, disabledBorder,
// enabledBorder, semantic counterText, and Theme-applied
// InputDecorationTheme.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PALETTE TOKENS
  // ===========================================================================

  const Color paletteInk = Color(0xFF101828);
  const Color paletteInkSoft = Color(0xFF475467);
  const Color paletteInkFaint = Color(0xFF98A2B3);
  const Color paletteAccent = Color(0xFF2E5AAC);
  const Color paletteAccentSoft = Color(0xFFE2EBFB);
  const Color paletteAccentDark = Color(0xFF1C3B7B);
  const Color paletteSuccess = Color(0xFF079455);
  const Color paletteSuccessSoft = Color(0xFFDCFAE6);
  const Color paletteWarn = Color(0xFFB54708);
  const Color paletteWarnSoft = Color(0xFFFEF0C7);
  const Color paletteDanger = Color(0xFFB42318);
  const Color paletteDangerSoft = Color(0xFFFEE4E2);
  const Color paletteMagenta = Color(0xFFBA24D5);
  const Color paletteMagentaSoft = Color(0xFFFBE8FF);
  const Color paletteTeal = Color(0xFF0E9384);
  const Color paletteTealSoft = Color(0xFFCCFBEF);
  const Color paletteIndigo = Color(0xFF3538CD);
  const Color paletteIndigoSoft = Color(0xFFE0EAFF);
  const Color paletteOrange = Color(0xFFEF6820);
  const Color paletteSurface = Color(0xFFF9FAFB);
  const Color paletteSurfaceAlt = Color(0xFFEFF1F5);
  const Color paletteSurfaceMuted = Color(0xFFF2F4F7);
  const Color paletteOutline = Color(0xFFD0D5DD);
  const Color paletteOutlineSoft = Color(0xFFEAECF0);

  // ===========================================================================
  // SECTION SHELL HELPER
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
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: border, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: titleColor.withValues(alpha: 0.08),
            blurRadius: 14.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 14.0),
            decoration: BoxDecoration(
              color: titleColor.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(17.0),
                topRight: Radius.circular(17.0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: titleColor.withValues(alpha: 0.25),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 6.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: titleColor,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: paletteInkSoft,
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget sectionHeader({
    required int number,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 4.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.92),
            color.withValues(alpha: 0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56.0,
            height: 56.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1.4,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'SECTION ${number.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 11.0,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
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

  Widget narrative(String text, {Color color = paletteSurfaceAlt}) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 10.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12.0),
        border: const Border(
          left: BorderSide(color: paletteAccent, width: 4.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: paletteInk,
          fontSize: 13.0,
          height: 1.5,
        ),
      ),
    );
  }

  Widget badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget propertyChip(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            value,
            style: const TextStyle(
              color: paletteInk,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // HERO BANNER
  // ===========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0B1F4D),
          Color(0xFF2E5AAC),
          Color(0xFF6FA0E6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 22.0,
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
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(
                Icons.edit_note,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'InputDecorationTheme — Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Filled, outlined, underlined, custom borders, label / '
                    'hint / helper / error styling, prefix and suffix slots, '
                    'counters, padding and density — all interpreted '
                    'through D4rt at runtime.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            badge('filled', Colors.white),
            badge('outlined', Colors.white),
            badge('underline', Colors.white),
            badge('labelStyle', Colors.white),
            badge('floatingLabel', Colors.white),
            badge('helperStyle', Colors.white),
            badge('errorStyle', Colors.white),
            badge('prefixIcon', Colors.white),
            badge('suffixIcon', Colors.white),
            badge('counterStyle', Colors.white),
            badge('contentPadding', Colors.white),
            badge('isDense', Colors.white),
            badge('isCollapsed', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 1 - FILLED INPUTS
  // ===========================================================================

  final Widget filledInputsSection = sectionShell(
    title: 'Filled inputs',
    subtitle:
        'filled: true with explicit fillColor across the colour spectrum.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Default filled',
            hintText: 'Enter some text',
            filled: true,
            fillColor: paletteAccentSoft,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Filled success',
            hintText: 'Operation will succeed',
            filled: true,
            fillColor: paletteSuccessSoft,
            prefixIcon: Icon(Icons.check_circle, color: paletteSuccess),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Filled warning',
            hintText: 'Proceed with caution',
            filled: true,
            fillColor: paletteWarnSoft,
            prefixIcon: Icon(Icons.warning_amber, color: paletteWarn),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Filled danger',
            hintText: 'Sensitive operation',
            filled: true,
            fillColor: paletteDangerSoft,
            prefixIcon: Icon(Icons.error_outline, color: paletteDanger),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Filled magenta',
            hintText: 'Custom branded fill',
            filled: true,
            fillColor: paletteMagentaSoft,
            prefixIcon: Icon(Icons.auto_awesome, color: paletteMagenta),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Filled teal',
            hintText: 'Aquatic palette',
            filled: true,
            fillColor: paletteTealSoft,
            prefixIcon: Icon(Icons.waves, color: paletteTeal),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: paletteSurfaceMuted,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: paletteOutlineSoft, width: 1.0),
          ),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 4.0,
            children: <Widget>[
              propertyChip('filled', 'true', paletteAccent),
              propertyChip('fillColor', 'Color(0xFFE2EBFB)', paletteAccent),
              propertyChip('border', 'OutlineInputBorder', paletteAccent),
              propertyChip('borderSide', 'BorderSide.none', paletteAccent),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 - OUTLINED INPUTS
  // ===========================================================================

  final Widget outlinedInputsSection = sectionShell(
    title: 'Outlined inputs',
    subtitle: 'OutlineInputBorder with custom radii, widths and colours.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteIndigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Standard outlined',
            hintText: 'Default 4px radius',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Rounded 12px',
            hintText: 'borderRadius: 12.0',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Rounded 24px',
            hintText: 'Pill shape with high radius',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Thick border 3px',
            hintText: 'Heavier outline',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: paletteIndigo, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Asymmetric radii',
            hintText: 'Different corners',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Coloured outline (orange)',
            hintText: 'Branded outline',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: paletteOrange, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Coloured outline (teal)',
            hintText: 'Calm aquatic outline',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: paletteTeal, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Filled + outlined',
            hintText: 'Combine fill with outline',
            filled: true,
            fillColor: paletteIndigoSoft,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: paletteIndigo, width: 1.6),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 - UNDERLINED INPUTS
  // ===========================================================================

  final Widget underlinedInputsSection = sectionShell(
    title: 'Underline inputs',
    subtitle:
        'UnderlineInputBorder — the classic Material 2 single-line look.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Default underline',
            hintText: 'Material 2 underline',
            border: UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Teal underline',
            hintText: 'Coloured underline',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteTeal, width: 2.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Magenta underline',
            hintText: 'Custom accent colour',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteMagenta, width: 2.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Thick underline 4px',
            hintText: 'Bold base line',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteAccent, width: 4.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Filled underline',
            hintText: 'Combine filled and underline',
            filled: true,
            fillColor: paletteTealSoft,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteTeal, width: 2.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Underline with rounded top corners',
            hintText: 'Top radius + base line',
            filled: true,
            fillColor: paletteSurfaceMuted,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteAccentDark, width: 2.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 - NONE BORDER
  // ===========================================================================

  final Widget noneBorderSection = sectionShell(
    title: 'Border-less inputs',
    subtitle: 'InputBorder.none — invisible decoration for chrome-free fields.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteInkSoft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: paletteSurfaceAlt,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search anything…',
              prefixIcon: Icon(Icons.search, color: paletteInkSoft),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: paletteAccentSoft,
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Pill-style search bar',
              prefixIcon: Icon(Icons.search, color: paletteAccent),
              suffixIcon: Icon(Icons.tune, color: paletteAccent),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Card-elevated borderless input',
              prefixIcon: Icon(
                Icons.workspaces_outlined,
                color: paletteAccentDark,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: paletteOutline, width: 1.0),
            ),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Manual external border',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 - LABEL STYLE / FLOATING LABEL STYLE / BEHAVIOR
  // ===========================================================================

  final Widget labelStylesSection = sectionShell(
    title: 'Label styling',
    subtitle:
        'labelStyle, floatingLabelStyle and floatingLabelBehavior options.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Default label',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Custom labelStyle',
            labelStyle: TextStyle(
              color: paletteMagenta,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Distinct floatingLabelStyle',
            labelStyle: TextStyle(
              color: paletteInkFaint,
              fontSize: 14.0,
            ),
            floatingLabelStyle: TextStyle(
              color: paletteMagenta,
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'floatingLabelBehavior.always',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'floatingLabelBehavior.never',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: 'Label never floats — used as inline placeholder',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'floatingLabelBehavior.auto',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintText: 'Default behaviour',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'floatingLabelAlignment.center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Italic label',
            labelStyle: TextStyle(
              fontStyle: FontStyle.italic,
              color: paletteAccentDark,
            ),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 - HINT, HELPER, ERROR STYLES
  // ===========================================================================

  final Widget supportingTextSection = sectionShell(
    title: 'Hint, helper and error styles',
    subtitle:
        'hintStyle, helperStyle, helperMaxLines, errorStyle, errorMaxLines.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteOrange,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Plain hint',
            hintText: 'This is a hint',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Styled hint',
            hintText: 'Italic, slightly translucent hint text',
            hintStyle: TextStyle(
              color: paletteOrange,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Hint with maxLines',
            hintText:
                'A long multi-line hint that wraps when the user has plenty '
                'of vertical space and wants instructions inside the field.',
            hintMaxLines: 3,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Plain helper',
            helperText: 'This text helps the user fill in the field.',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Styled helper',
            helperText: 'Helper text using a custom style — bold and orange.',
            helperStyle: TextStyle(
              color: paletteOrange,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Wrapped helper',
            helperText:
                'Helper text can wrap over multiple lines when helperMaxLines '
                'is set — useful for longer instructions that explain the '
                'expected format or constraints.',
            helperMaxLines: 4,
            helperStyle: TextStyle(
              color: paletteInkSoft,
              fontSize: 12.0,
              height: 1.4,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Plain error',
            errorText: 'This field is required.',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 18.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Styled error',
            errorText: 'Email format is invalid — please check the domain.',
            errorStyle: TextStyle(
              color: paletteDanger,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 18.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Wrapped error',
            errorText:
                'The submitted value failed several validation rules — the '
                'string must be at least eight characters, contain a digit '
                'and avoid common dictionary words.',
            errorMaxLines: 4,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 - PREFIX TEXT / SUFFIX TEXT
  // ===========================================================================

  final Widget prefixSuffixTextSection = sectionShell(
    title: 'Prefix and suffix text',
    subtitle:
        'prefixText, suffixText, prefixStyle, suffixStyle and floating label.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteSuccess,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Amount',
            prefixText: '\$ ',
            prefixStyle: TextStyle(
              color: paletteSuccess,
              fontWeight: FontWeight.w800,
              fontSize: 16.0,
            ),
            hintText: '0.00',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Weight',
            suffixText: ' kg',
            suffixStyle: TextStyle(
              color: paletteAccent,
              fontWeight: FontWeight.w800,
              fontSize: 14.0,
            ),
            hintText: '0.0',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Code',
            prefixText: '> ',
            prefixStyle: TextStyle(
              color: paletteTeal,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
            suffixText: ' ;',
            suffixStyle: TextStyle(
              color: paletteTeal,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'URL',
            prefixText: 'https://',
            prefixStyle: TextStyle(
              color: paletteInkSoft,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            suffixText: '.com',
            suffixStyle: TextStyle(
              color: paletteInkSoft,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            hintText: 'myhost',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Tweet',
            prefixText: '@',
            prefixStyle: TextStyle(
              color: paletteIndigo,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
            hintText: 'username',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Hashtag',
            prefixText: '#',
            prefixStyle: TextStyle(
              color: paletteMagenta,
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
            ),
            hintText: 'topic',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Bytes',
            suffixText: ' MB',
            suffixStyle: TextStyle(
              color: paletteOrange,
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
            hintText: '0',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 - PREFIX/SUFFIX WIDGETS
  // ===========================================================================

  final Widget prefixSuffixWidgetSection = sectionShell(
    title: 'Prefix and suffix widgets',
    subtitle:
        'prefix / suffix accept arbitrary Widgets — not only icons or text.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteIndigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Country selector prefix',
            prefix: Container(
              margin: const EdgeInsets.only(right: 6.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: paletteIndigoSoft,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'DE',
                style: TextStyle(
                  color: paletteIndigo,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.0,
                ),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Currency suffix chip',
            suffix: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: paletteSuccessSoft,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'EUR',
                style: TextStyle(
                  color: paletteSuccess,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.0,
                ),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Avatar prefix',
            prefix: Container(
              margin: const EdgeInsets.only(right: 8.0),
              width: 24.0,
              height: 24.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: paletteAccent,
                shape: BoxShape.circle,
              ),
              child: const Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.0,
                ),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Multi-segment prefix',
            prefix: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: paletteAccent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text(
                    '+49',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 6.0),
              ],
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Status suffix',
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                SizedBox(
                  width: 8.0,
                  height: 8.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: paletteSuccess,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Text(
                  'live',
                  style: TextStyle(
                    color: paletteSuccess,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 - PREFIX/SUFFIX ICONS WITH COLOURS
  // ===========================================================================

  final List<Map<String, dynamic>> iconRecipes = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Email',
      'hint': 'name@example.com',
      'icon': Icons.email_outlined,
      'suffix': Icons.send,
      'color': paletteAccent,
    },
    <String, dynamic>{
      'label': 'Password',
      'hint': '••••••••',
      'icon': Icons.lock_outline,
      'suffix': Icons.visibility_outlined,
      'color': paletteIndigo,
    },
    <String, dynamic>{
      'label': 'Search',
      'hint': 'Search products',
      'icon': Icons.search,
      'suffix': Icons.tune,
      'color': paletteTeal,
    },
    <String, dynamic>{
      'label': 'Location',
      'hint': 'Berlin',
      'icon': Icons.location_on_outlined,
      'suffix': Icons.gps_fixed,
      'color': paletteOrange,
    },
    <String, dynamic>{
      'label': 'Calendar',
      'hint': '2026-05-20',
      'icon': Icons.calendar_today,
      'suffix': Icons.event_available,
      'color': paletteMagenta,
    },
    <String, dynamic>{
      'label': 'Phone',
      'hint': '+49 30 1234567',
      'icon': Icons.phone_outlined,
      'suffix': Icons.call_made,
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'label': 'Money',
      'hint': '0.00',
      'icon': Icons.attach_money,
      'suffix': Icons.calculate_outlined,
      'color': paletteSuccess,
    },
    <String, dynamic>{
      'label': 'Tag',
      'hint': 'tag-name',
      'icon': Icons.label_outline,
      'suffix': Icons.add,
      'color': paletteWarn,
    },
  ];

  final List<Widget> iconRows =
      List<Widget>.generate(iconRecipes.length, (int i) {
    final Map<String, dynamic> spec = iconRecipes[i];
    final Color color = spec['color'] as Color;
    final String label = spec['label'] as String;
    final String hint = spec['hint'] as String;
    final IconData prefixIcon = spec['icon'] as IconData;
    final IconData suffixIcon = spec['suffix'] as IconData;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(prefixIcon, color: color),
          suffixIcon: Icon(suffixIcon, color: color.withValues(alpha: 0.7)),
          labelStyle: TextStyle(color: color),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: color.withValues(alpha: 0.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: color.withValues(alpha: 0.45)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: color, width: 2.0),
          ),
        ),
      ),
    );
  });

  final Widget iconRecipesSection = sectionShell(
    title: 'Prefix and suffix icons',
    subtitle: 'Distinct icon palettes across eight real-world field roles.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: iconRows,
    ),
  );

  // ===========================================================================
  // SECTION 10 - CONTENT PADDING VARIATIONS
  // ===========================================================================

  final Widget contentPaddingSection = sectionShell(
    title: 'contentPadding variations',
    subtitle:
        'Tune horizontal and vertical content padding for spacing density.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteWarn,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Default padding',
            hintText: 'No override',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Tight padding 4 / 4',
            hintText: 'EdgeInsets.symmetric(h:8, v:4)',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Standard 16 / 12',
            hintText: 'EdgeInsets.symmetric(h:16, v:12)',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Generous 24 / 20',
            hintText: 'EdgeInsets.symmetric(h:24, v:20)',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Asymmetric',
            hintText: 'fromLTRB(28, 8, 12, 24)',
            contentPadding: EdgeInsets.fromLTRB(28.0, 8.0, 12.0, 24.0),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Tall padding 8 / 28',
            hintText: 'Lots of vertical space',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 28.0,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Wide padding 32 / 6',
            hintText: 'Lots of horizontal space',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 6.0,
            ),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 - isDense / isCollapsed
  // ===========================================================================

  final Widget densitySection = sectionShell(
    title: 'Density and collapsed layout',
    subtitle: 'isDense compresses height; isCollapsed removes label space.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteIndigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'isDense: false (default)',
          style: TextStyle(
            color: paletteInkSoft,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Standard height',
            hintText: 'Default vertical padding',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 18.0),
        const Text(
          'isDense: true',
          style: TextStyle(
            color: paletteInkSoft,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Dense height',
            hintText: 'Compressed for lists',
            isDense: true,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 18.0),
        const Text(
          'isCollapsed: true',
          style: TextStyle(
            color: paletteInkSoft,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: paletteSurfaceMuted,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'No label slot at all',
              isCollapsed: true,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        const Text(
          'isDense + filled',
          style: TextStyle(
            color: paletteInkSoft,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Dense filled',
            hintText: 'For data tables',
            isDense: true,
            filled: true,
            fillColor: paletteIndigoSoft,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        const Text(
          'Dense row layout',
          style: TextStyle(
            color: paletteInkSoft,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        const Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'qty',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'price',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'tax',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 - COUNTER CUSTOMIZATION
  // ===========================================================================

  final Widget counterSection = sectionShell(
    title: 'Counter customisation',
    subtitle:
        'counterText, counterStyle and custom counter Widget for character limits.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          maxLength: 40,
          decoration: InputDecoration(
            labelText: 'Default counter',
            hintText: 'Built-in length counter',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          maxLength: 40,
          decoration: InputDecoration(
            labelText: 'Custom counterText',
            counterText: '40 chars max',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          maxLength: 40,
          decoration: InputDecoration(
            labelText: 'Styled counter',
            counterText: '0 / 40',
            counterStyle: TextStyle(
              color: paletteMagenta,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
              letterSpacing: 0.6,
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        TextField(
          maxLength: 120,
          decoration: InputDecoration(
            labelText: 'Custom counter widget',
            counter: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: paletteMagentaSoft,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'AI tokens: 0 / 120',
                    style: TextStyle(
                      color: paletteMagenta,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ],
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          maxLength: 280,
          decoration: InputDecoration(
            labelText: 'Tweet (semantic counterText)',
            counterText: '',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14.0),
        TextField(
          maxLength: 100,
          decoration: InputDecoration(
            labelText: 'Counter with semantic label',
            counter: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: paletteSuccessSoft,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'within budget',
                style: TextStyle(
                  color: paletteSuccess,
                  fontWeight: FontWeight.w700,
                  fontSize: 10.5,
                ),
              ),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 13 - BORDER STATE VARIANTS
  // ===========================================================================

  final Widget borderStatesSection = sectionShell(
    title: 'Border state variants',
    subtitle:
        'enabledBorder, focusedBorder, disabledBorder, errorBorder, focusedErrorBorder.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteDanger,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Custom enabledBorder',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteInkFaint, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteAccent, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Focused vs enabled (teal accent)',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteTealSoft, width: 1.6),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteTeal, width: 2.6),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Disabled border',
            hintText: 'Cannot edit',
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteOutlineSoft, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            filled: true,
            fillColor: paletteSurfaceMuted,
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Error border',
            errorText: 'Required field',
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteDanger, width: 1.6),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteDanger, width: 2.4),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Custom focusedErrorBorder',
            errorText: 'Field rejected',
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteDanger, width: 1.2),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: paletteMagenta, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Underline border family',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteInkFaint, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteAccent, width: 2.4),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteDanger, width: 1.4),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: paletteDanger, width: 2.6),
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 14 - InputDecorationTheme via Theme
  // ===========================================================================

  final Widget themeSection = sectionShell(
    title: 'InputDecorationTheme via Theme',
    subtitle:
        'Apply a theme to a subtree so every TextField inherits the same look.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteAccentDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: paletteAccentSoft,
              labelStyle: TextStyle(
                color: paletteAccent,
                fontWeight: FontWeight.w700,
              ),
              hintStyle: TextStyle(color: paletteInkFaint),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: paletteAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 14.0,
              ),
            ),
          ),
          child: Column(
            children: const <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'First name',
                  hintText: 'Ada',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Last name',
                  hintText: 'Lovelace',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'ada@example.org',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22.0),
        Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: const InputDecorationTheme(
              filled: false,
              labelStyle: TextStyle(color: paletteSuccess),
              floatingLabelStyle: TextStyle(
                color: paletteSuccess,
                fontWeight: FontWeight.w800,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: paletteSuccess, width: 1.6),
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: paletteSuccess, width: 1.6),
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: paletteSuccess, width: 2.4),
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
            ),
          ),
          child: Column(
            children: const <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Habit goal',
                  hintText: 'Drink 2L of water',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Streak',
                  hintText: 'days in a row',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 15 - FULL SHOWCASE FORM
  // ===========================================================================

  final Widget showcaseFormSection = sectionShell(
    title: 'Composite showcase form',
    subtitle:
        'Bringing every concept together inside one cohesive form layout.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAccent,
    child: Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: paletteInkSoft,
            fontWeight: FontWeight.w600,
          ),
          floatingLabelStyle: TextStyle(
            color: paletteAccent,
            fontWeight: FontWeight.w800,
          ),
          hintStyle: TextStyle(color: paletteInkFaint),
          helperStyle: TextStyle(
            color: paletteInkSoft,
            fontStyle: FontStyle.italic,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: paletteOutline, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: paletteAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 14.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Full name',
              hintText: 'Ada Lovelace',
              prefixIcon: Icon(Icons.person_outline, color: paletteAccent),
              helperText: 'The name shown on your profile.',
            ),
          ),
          SizedBox(height: 14.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'ada@example.org',
              prefixIcon: Icon(Icons.alternate_email, color: paletteAccent),
              helperText: 'We never share your email.',
            ),
          ),
          SizedBox(height: 14.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: '••••••••',
              prefixIcon: Icon(Icons.lock_outline, color: paletteAccent),
              suffixIcon:
                  Icon(Icons.visibility_outlined, color: paletteInkSoft),
              helperText: 'At least 12 characters, 1 digit, 1 symbol.',
            ),
          ),
          SizedBox(height: 14.0),
          TextField(
            maxLength: 280,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'About yourself',
              hintText: 'Write a few sentences about your work.',
              alignLabelWithHint: true,
            ),
          ),
          SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Hourly rate',
                    prefixText: '\$ ',
                    suffixText: '/ h',
                    hintText: '0.00',
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Tax',
                    suffixText: ' %',
                    hintText: '0',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 16 - PALETTE LEGEND
  // ===========================================================================

  final List<Map<String, dynamic>> paletteEntries = <Map<String, dynamic>>[
    <String, dynamic>{'name': 'accent', 'color': paletteAccent},
    <String, dynamic>{'name': 'accentSoft', 'color': paletteAccentSoft},
    <String, dynamic>{'name': 'accentDark', 'color': paletteAccentDark},
    <String, dynamic>{'name': 'success', 'color': paletteSuccess},
    <String, dynamic>{'name': 'warn', 'color': paletteWarn},
    <String, dynamic>{'name': 'danger', 'color': paletteDanger},
    <String, dynamic>{'name': 'magenta', 'color': paletteMagenta},
    <String, dynamic>{'name': 'teal', 'color': paletteTeal},
    <String, dynamic>{'name': 'indigo', 'color': paletteIndigo},
    <String, dynamic>{'name': 'orange', 'color': paletteOrange},
    <String, dynamic>{'name': 'ink', 'color': paletteInk},
    <String, dynamic>{'name': 'inkSoft', 'color': paletteInkSoft},
    <String, dynamic>{'name': 'inkFaint', 'color': paletteInkFaint},
    <String, dynamic>{'name': 'surface', 'color': paletteSurface},
    <String, dynamic>{'name': 'surfaceAlt', 'color': paletteSurfaceAlt},
    <String, dynamic>{'name': 'outline', 'color': paletteOutline},
  ];

  final List<Widget> paletteTiles =
      List<Widget>.generate(paletteEntries.length, (int i) {
    final Map<String, dynamic> entry = paletteEntries[i];
    final String name = entry['name'] as String;
    final Color color = entry['color'] as Color;
    return Container(
      width: 150.0,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: paletteOutlineSoft, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: paletteOutline, width: 0.8),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: paletteInk,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  });

  final Widget paletteSection = sectionShell(
    title: 'Palette legend',
    subtitle: 'Colour tokens used throughout this demo.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteInk,
    child: Wrap(children: paletteTiles),
  );

  // ===========================================================================
  // SCAFFOLD
  // ===========================================================================

  return Scaffold(
    backgroundColor: paletteSurface,
    appBar: AppBar(
      backgroundColor: paletteAccentDark,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'InputDecorationTheme deep demo',
        style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.3),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroBanner,
          sectionHeader(
            number: 1,
            title: 'Filled inputs',
            subtitle: 'fillColor across the spectrum',
            icon: Icons.format_color_fill,
            color: paletteAccent,
          ),
          narrative(
            'A filled TextField is the most common Material 3 look. Set '
            'filled: true and provide an explicit fillColor — the border is '
            'usually OutlineInputBorder with BorderSide.none so the fill is '
            'the only chrome the user sees.',
          ),
          filledInputsSection,
          sectionHeader(
            number: 2,
            title: 'Outlined inputs',
            subtitle: 'OutlineInputBorder customised',
            icon: Icons.crop_square,
            color: paletteIndigo,
          ),
          narrative(
            'OutlineInputBorder draws a rounded rectangle around the field. '
            'Tune borderRadius, borderSide.color and borderSide.width to '
            'match the surrounding chrome. Combine with filled and a soft '
            'colour for a distinct branded look.',
          ),
          outlinedInputsSection,
          sectionHeader(
            number: 3,
            title: 'Underline inputs',
            subtitle: 'UnderlineInputBorder family',
            icon: Icons.minimize,
            color: paletteTeal,
          ),
          narrative(
            'UnderlineInputBorder is the classic Material 2 look. Only the '
            'bottom edge is rendered. Combine with a filled background to '
            'get the popular "Material 2 filled" style used in many forms.',
          ),
          underlinedInputsSection,
          sectionHeader(
            number: 4,
            title: 'Border-less inputs',
            subtitle: 'InputBorder.none for chrome-free fields',
            icon: Icons.layers_clear,
            color: paletteInkSoft,
          ),
          narrative(
            'When you want the field to live inside another container — a '
            'search bar, a card, a custom shape — drop the border entirely '
            'with InputBorder.none. Provide your own background and shape '
            'in the parent container.',
          ),
          noneBorderSection,
          sectionHeader(
            number: 5,
            title: 'Label styling',
            subtitle: 'labelStyle, floatingLabelStyle, behaviour',
            icon: Icons.label_important_outline,
            color: paletteMagenta,
          ),
          narrative(
            'labelStyle is used when the label sits inside the field; '
            'floatingLabelStyle is used after the label has floated up. '
            'floatingLabelBehavior controls when the float happens — auto, '
            'always or never. floatingLabelAlignment can centre it.',
          ),
          labelStylesSection,
          sectionHeader(
            number: 6,
            title: 'Hint, helper and error',
            subtitle: 'Supporting text styling',
            icon: Icons.help_outline,
            color: paletteOrange,
          ),
          narrative(
            'Three slots live below or inside the field: hint, helper and '
            'error. Each one accepts a custom TextStyle and a maxLines so '
            'longer instructions remain readable. The error slot overrides '
            'helperText when present.',
          ),
          supportingTextSection,
          sectionHeader(
            number: 7,
            title: 'Prefix and suffix text',
            subtitle: 'prefixText, suffixText and their styles',
            icon: Icons.text_fields,
            color: paletteSuccess,
          ),
          narrative(
            'prefixText and suffixText are rendered inside the input frame, '
            'before and after the editing value. Use them for currency '
            'symbols, units, mention prefixes or any short static decoration.',
          ),
          prefixSuffixTextSection,
          sectionHeader(
            number: 8,
            title: 'Prefix and suffix widgets',
            subtitle: 'Arbitrary widgets in the prefix/suffix slot',
            icon: Icons.extension,
            color: paletteIndigo,
          ),
          narrative(
            'When you need more than a string, use prefix and suffix — they '
            'accept any Widget. Common patterns: country chip, currency '
            'badge, avatar, status dot, multi-segment row.',
          ),
          prefixSuffixWidgetSection,
          sectionHeader(
            number: 9,
            title: 'Prefix and suffix icons',
            subtitle: 'prefixIcon, suffixIcon and per-state borders',
            icon: Icons.input,
            color: paletteAccent,
          ),
          narrative(
            'prefixIcon and suffixIcon are Material affordances. They '
            'inherit their colour from iconColor or the surrounding label '
            'style. Use enabledBorder/focusedBorder to align outline colour '
            'with the icon palette.',
          ),
          iconRecipesSection,
          sectionHeader(
            number: 10,
            title: 'contentPadding',
            subtitle: 'Density via padding overrides',
            icon: Icons.padding,
            color: paletteWarn,
          ),
          narrative(
            'contentPadding controls the spacing between the field border '
            'and its content. Use small values for compact tables, generous '
            'values for marketing forms. Asymmetric padding is rare but '
            'useful for icons on one side only.',
          ),
          contentPaddingSection,
          sectionHeader(
            number: 11,
            title: 'isDense and isCollapsed',
            subtitle: 'Two switches for tight layouts',
            icon: Icons.unfold_less,
            color: paletteIndigo,
          ),
          narrative(
            'isDense reduces the vertical padding so the field becomes '
            'shorter. isCollapsed removes the label slot entirely — the '
            'input collapses to a bare editing surface. Useful for dense '
            'forms inside spreadsheets, command palettes or inline editors.',
          ),
          densitySection,
          sectionHeader(
            number: 12,
            title: 'Counter customisation',
            subtitle: 'counterText, counterStyle, counter Widget',
            icon: Icons.numbers,
            color: paletteMagenta,
          ),
          narrative(
            'maxLength brings a counter for free. Override it with '
            'counterText for a custom string, counterStyle to restyle it, '
            'or counter for a fully custom widget. Pass an empty counterText '
            'to remove it while keeping maxLength behaviour.',
          ),
          counterSection,
          sectionHeader(
            number: 13,
            title: 'Border state variants',
            subtitle: 'enabled / focused / disabled / error / focusedError',
            icon: Icons.border_outer,
            color: paletteDanger,
          ),
          narrative(
            'InputDecoration exposes five border slots — one for each '
            'visual state. Provide distinct borders to make the focus and '
            'error transitions clearer for users who rely on visual '
            'feedback.',
          ),
          borderStatesSection,
          sectionHeader(
            number: 14,
            title: 'InputDecorationTheme via Theme',
            subtitle: 'Inherit decoration through a Theme subtree',
            icon: Icons.style,
            color: paletteAccentDark,
          ),
          narrative(
            'Wrap a subtree with Theme(data: …copyWith(inputDecorationTheme: '
            '…)) so every TextField inside picks up the same look. This is '
            'the recommended pattern for branded forms — define the theme '
            'once, never repeat the decoration.',
          ),
          themeSection,
          sectionHeader(
            number: 15,
            title: 'Composite showcase',
            subtitle: 'Everything you saw, glued together',
            icon: Icons.dashboard_customize,
            color: paletteAccent,
          ),
          narrative(
            'A real-world signup-style form. The InputDecorationTheme '
            'covers fill, label, hint, helper and border states. Each '
            'field uses prefix icons aligned with the theme accent colour, '
            'and the row at the bottom shows prefix/suffix text together.',
          ),
          showcaseFormSection,
          sectionHeader(
            number: 16,
            title: 'Palette legend',
            subtitle: 'Tokens used in this demo',
            icon: Icons.palette,
            color: paletteInk,
          ),
          paletteSection,
          const SizedBox(height: 32.0),
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFF1C3B7B),
                  Color(0xFF2E5AAC),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.check_circle, color: Colors.white, size: 30.0),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Demo complete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'InputDecorationTheme, InputDecoration, filled, '
                        'outlined, underline, none, labelStyle, '
                        'floatingLabelStyle, floatingLabelBehavior, '
                        'hintStyle, helperStyle, errorStyle, prefixStyle, '
                        'suffixStyle, contentPadding, isDense, isCollapsed, '
                        'prefixIcon, suffixIcon, prefix/suffix widgets, '
                        'counter customisation and border state variants — '
                        'every InputDecoration knob is demonstrated above.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
