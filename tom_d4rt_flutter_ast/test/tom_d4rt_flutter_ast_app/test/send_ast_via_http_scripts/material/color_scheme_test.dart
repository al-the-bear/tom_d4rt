// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFFBFAF7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(children: const <Widget>[
            _HeroCard(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '01',
              title: 'Role Catalog',
              subtitle: 'All Material 3 color roles in one grid',
              tintA: Color(0xFF6750A4),
              tintB: Color(0xFF9A82DB),
            ),
            SizedBox(height: 16.0),
            _RoleCatalogGrid(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '02',
              title: 'Light vs Dark',
              subtitle: 'Six main roles side-by-side at both brightnesses',
              tintA: Color(0xFF1F2937),
              tintB: Color(0xFF4B5563),
            ),
            SizedBox(height: 16.0),
            _LightDarkPairsSection(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '03',
              title: 'Surface Elevation Tiers',
              subtitle: 'surfaceContainerLowest -> surfaceContainerHighest',
              tintA: Color(0xFF065F46),
              tintB: Color(0xFF34D399),
            ),
            SizedBox(height: 16.0),
            _SurfaceElevationSection(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '04',
              title: 'Role Relationships',
              subtitle: 'How primary, onPrimary, primaryContainer relate',
              tintA: Color(0xFF7C2D12),
              tintB: Color(0xFFEA580C),
            ),
            SizedBox(height: 16.0),
            _RoleRelationshipDiagram(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '05',
              title: 'Contrast & Accessibility',
              subtitle: 'Foreground on background, with target ratios',
              tintA: Color(0xFF155E75),
              tintB: Color(0xFF22D3EE),
            ),
            SizedBox(height: 16.0),
            _ContrastCardsSection(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '06',
              title: 'ColorScheme.fromSeed()',
              subtitle: 'Generate a full scheme from one seed color',
              tintA: Color(0xFF4A148C),
              tintB: Color(0xFFAB47BC),
            ),
            SizedBox(height: 16.0),
            _FromSeedCard(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '07',
              title: 'Tonal Palette',
              subtitle: '13 tones (0, 10, 20, ..., 100) for one seed',
              tintA: Color(0xFFB91C1C),
              tintB: Color(0xFFF59E0B),
            ),
            SizedBox(height: 16.0),
            _TonalPaletteSection(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '08',
              title: 'Migration v2 -> v3',
              subtitle: 'Renamed and removed roles',
              tintA: Color(0xFF1E3A8A),
              tintB: Color(0xFF60A5FA),
            ),
            SizedBox(height: 16.0),
            _MigrationTable(),
            SizedBox(height: 28.0),
            _SectionHeader(
              index: '09',
              title: 'Common Pitfalls',
              subtitle: 'Five warnings worth pinning to your monitor',
              tintA: Color(0xFF7F1D1D),
              tintB: Color(0xFFEF4444),
            ),
            SizedBox(height: 16.0),
            _PitfallsList(),
            SizedBox(height: 28.0),
            _FooterCard(),
          ]),
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION: Hero
// =====================================================================

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF6750A4),
            Color(0xFF9A82DB),
            Color(0xFFEADDFF),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x336750A4),
            blurRadius: 30.0,
            offset: Offset(0.0, 12.0),
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
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFFFFFFFF), Color(0xFFEADDFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0x331F1A2C),
                      blurRadius: 14.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.palette_outlined,
                  color: Color(0xFF6750A4),
                  size: 30.0,
                ),
              ),
              const SizedBox(width: 18.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ColorScheme',
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Material 3 Role System',
                      style: const TextStyle(
                        color: Color(0xCCFFFFFF),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22.0),
          Text(
            'A semantic naming layer over colors. Roles like primary, onPrimary, '
            'surfaceContainerHigh, outline, and tertiary drive every Material 3 widget '
            'so themes stay consistent across light and dark schemes.',
            style: const TextStyle(
              color: Color(0xE6FFFFFF),
              fontSize: 14.5,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            children: const <Widget>[
              _HeroStatChip(label: '30+ roles', icon: Icons.grid_view_outlined),
              SizedBox(width: 10.0),
              _HeroStatChip(label: 'tonal palette', icon: Icons.gradient),
              SizedBox(width: 10.0),
              _HeroStatChip(label: 'dark + light', icon: Icons.brightness_4_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStatChip extends StatelessWidget {
  const _HeroStatChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(color: const Color(0x66FFFFFF), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14.0, color: const Color(0xFFFFFFFF)),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION: Section header
// =====================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.tintA,
    required this.tintB,
  });

  final String index;
  final String title;
  final String subtitle;
  final Color tintA;
  final Color tintB;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0F1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 52.0,
            height: 52.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[tintA, tintB],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: tintA.withValues(alpha: 0.35),
                  blurRadius: 12.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Text(
              index,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1C1B1F),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
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

// =====================================================================
// SECTION: Role catalog (01)
// =====================================================================

class _RoleSwatch extends StatelessWidget {
  const _RoleSwatch({
    required this.role,
    required this.hex,
    required this.color,
    required this.onColor,
    required this.hint,
  });

  final String role;
  final String hex;
  final Color color;
  final Color onColor;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 8.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 56.0,
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
            ),
            child: Text(
              'Aa',
              style: TextStyle(
                color: onColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1B1F),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2.0),
                Text(
                  hex,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  hint,
                  style: const TextStyle(
                    fontSize: 9.5,
                    color: Color(0xFF9CA3AF),
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleCatalogGrid extends StatelessWidget {
  const _RoleCatalogGrid();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        children: const <Widget>[
          _CatalogRow(<_SwatchData>[
            _SwatchData('primary', '0xFF6750A4', Color(0xFF6750A4),
                Color(0xFFFFFFFF), 'Main brand accent'),
            _SwatchData('onPrimary', '0xFFFFFFFF', Color(0xFFFFFFFF),
                Color(0xFF6750A4), 'Foreground on primary'),
            _SwatchData('primaryContainer', '0xFFEADDFF', Color(0xFFEADDFF),
                Color(0xFF21005D), 'Tonal container'),
            _SwatchData('onPrimaryContainer', '0xFF21005D', Color(0xFF21005D),
                Color(0xFFEADDFF), 'Text on container'),
          ]),
          SizedBox(height: 12.0),
          _CatalogRow(<_SwatchData>[
            _SwatchData('secondary', '0xFF625B71', Color(0xFF625B71),
                Color(0xFFFFFFFF), 'Less prominent accent'),
            _SwatchData('onSecondary', '0xFFFFFFFF', Color(0xFFFFFFFF),
                Color(0xFF625B71), 'Foreground on secondary'),
            _SwatchData('secondaryContainer', '0xFFE8DEF8', Color(0xFFE8DEF8),
                Color(0xFF1D192B), 'Secondary tonal layer'),
            _SwatchData('onSecondaryContainer', '0xFF1D192B', Color(0xFF1D192B),
                Color(0xFFE8DEF8), 'Text on it'),
          ]),
          SizedBox(height: 12.0),
          _CatalogRow(<_SwatchData>[
            _SwatchData('tertiary', '0xFF7D5260', Color(0xFF7D5260),
                Color(0xFFFFFFFF), 'Contrasting accent'),
            _SwatchData('onTertiary', '0xFFFFFFFF', Color(0xFFFFFFFF),
                Color(0xFF7D5260), 'Foreground on tertiary'),
            _SwatchData('tertiaryContainer', '0xFFFFD8E4', Color(0xFFFFD8E4),
                Color(0xFF31111D), 'Tertiary tonal layer'),
            _SwatchData('onTertiaryContainer', '0xFF31111D', Color(0xFF31111D),
                Color(0xFFFFD8E4), 'Text on it'),
          ]),
          SizedBox(height: 12.0),
          _CatalogRow(<_SwatchData>[
            _SwatchData('error', '0xFFB3261E', Color(0xFFB3261E),
                Color(0xFFFFFFFF), 'Destructive / invalid'),
            _SwatchData('onError', '0xFFFFFFFF', Color(0xFFFFFFFF),
                Color(0xFFB3261E), 'Foreground on error'),
            _SwatchData('errorContainer', '0xFFF9DEDC', Color(0xFFF9DEDC),
                Color(0xFF410E0B), 'Error tonal layer'),
            _SwatchData('onErrorContainer', '0xFF410E0B', Color(0xFF410E0B),
                Color(0xFFF9DEDC), 'Text on it'),
          ]),
          SizedBox(height: 12.0),
          _CatalogRow(<_SwatchData>[
            _SwatchData('surface', '0xFFFFFBFE', Color(0xFFFFFBFE),
                Color(0xFF1C1B1F), 'Default surface'),
            _SwatchData('onSurface', '0xFF1C1B1F', Color(0xFF1C1B1F),
                Color(0xFFFFFBFE), 'Foreground on surface'),
            _SwatchData('surfaceVariant', '0xFFE7E0EC', Color(0xFFE7E0EC),
                Color(0xFF49454F), 'Subtle surface tier'),
            _SwatchData('onSurfaceVariant', '0xFF49454F', Color(0xFF49454F),
                Color(0xFFE7E0EC), 'Foreground variant'),
          ]),
          SizedBox(height: 12.0),
          _CatalogRow(<_SwatchData>[
            _SwatchData('outline', '0xFF79747E', Color(0xFF79747E),
                Color(0xFFFFFFFF), 'Borders, dividers'),
            _SwatchData('outlineVariant', '0xFFCAC4D0', Color(0xFFCAC4D0),
                Color(0xFF1C1B1F), 'Subtler borders'),
            _SwatchData('shadow', '0xFF000000', Color(0xFF000000),
                Color(0xFFFFFFFF), 'Drop-shadow color'),
            _SwatchData('scrim', '0xFF000000', Color(0xFF000000),
                Color(0xFFFFFFFF), 'Modal scrim layer'),
          ]),
          SizedBox(height: 12.0),
          _CatalogRow(<_SwatchData>[
            _SwatchData('inverseSurface', '0xFF313033', Color(0xFF313033),
                Color(0xFFF4EFF4), 'Inverted surface'),
            _SwatchData('onInverseSurface', '0xFFF4EFF4', Color(0xFFF4EFF4),
                Color(0xFF313033), 'Text on inverse'),
            _SwatchData('inversePrimary', '0xFFD0BCFF', Color(0xFFD0BCFF),
                Color(0xFF381E72), 'Primary on inverse'),
            _SwatchData('surfaceTint', '0xFF6750A4', Color(0xFF6750A4),
                Color(0xFFFFFFFF), 'Elevation tint color'),
          ]),
          SizedBox(height: 12.0),
          _CatalogRow(<_SwatchData>[
            _SwatchData('surfaceContainer', '0xFFF3EDF7', Color(0xFFF3EDF7),
                Color(0xFF1C1B1F), 'Default container'),
            _SwatchData('surfaceContainerLow', '0xFFF7F2FA', Color(0xFFF7F2FA),
                Color(0xFF1C1B1F), 'Less elevated'),
            _SwatchData('surfaceContainerHigh', '0xFFECE6F0', Color(0xFFECE6F0),
                Color(0xFF1C1B1F), 'More elevated'),
            _SwatchData('surfaceBright', '0xFFFFF8F8', Color(0xFFFFF8F8),
                Color(0xFF1C1B1F), 'Bright surface'),
          ]),
        ],
      ),
    );
  }
}

class _SwatchData {
  const _SwatchData(this.role, this.hex, this.color, this.onColor, this.hint);
  final String role;
  final String hex;
  final Color color;
  final Color onColor;
  final String hint;
}

class _CatalogRow extends StatelessWidget {
  const _CatalogRow(this.entries);
  final List<_SwatchData> entries;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < entries.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(width: 10.0),
          Expanded(
            child: _RoleSwatch(
              role: entries[i].role,
              hex: entries[i].hex,
              color: entries[i].color,
              onColor: entries[i].onColor,
              hint: entries[i].hint,
            ),
          ),
        ],
      ],
    );
  }
}

// =====================================================================
// SECTION: Light vs Dark (02)
// =====================================================================

class _LightDarkPairsSection extends StatelessWidget {
  const _LightDarkPairsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        children: const <Widget>[
          _LightDarkPair(
            role: 'primary',
            lightHex: '0xFF6750A4',
            darkHex: '0xFFD0BCFF',
            light: Color(0xFF6750A4),
            lightOn: Color(0xFFFFFFFF),
            dark: Color(0xFFD0BCFF),
            darkOn: Color(0xFF381E72),
          ),
          SizedBox(height: 10.0),
          _LightDarkPair(
            role: 'secondary',
            lightHex: '0xFF625B71',
            darkHex: '0xFFCCC2DC',
            light: Color(0xFF625B71),
            lightOn: Color(0xFFFFFFFF),
            dark: Color(0xFFCCC2DC),
            darkOn: Color(0xFF332D41),
          ),
          SizedBox(height: 10.0),
          _LightDarkPair(
            role: 'tertiary',
            lightHex: '0xFF7D5260',
            darkHex: '0xFFEFB8C8',
            light: Color(0xFF7D5260),
            lightOn: Color(0xFFFFFFFF),
            dark: Color(0xFFEFB8C8),
            darkOn: Color(0xFF492532),
          ),
          SizedBox(height: 10.0),
          _LightDarkPair(
            role: 'error',
            lightHex: '0xFFB3261E',
            darkHex: '0xFFF2B8B5',
            light: Color(0xFFB3261E),
            lightOn: Color(0xFFFFFFFF),
            dark: Color(0xFFF2B8B5),
            darkOn: Color(0xFF601410),
          ),
          SizedBox(height: 10.0),
          _LightDarkPair(
            role: 'surface',
            lightHex: '0xFFFFFBFE',
            darkHex: '0xFF1C1B1F',
            light: Color(0xFFFFFBFE),
            lightOn: Color(0xFF1C1B1F),
            dark: Color(0xFF1C1B1F),
            darkOn: Color(0xFFE6E1E5),
          ),
          SizedBox(height: 10.0),
          _LightDarkPair(
            role: 'outline',
            lightHex: '0xFF79747E',
            darkHex: '0xFF938F99',
            light: Color(0xFF79747E),
            lightOn: Color(0xFFFFFFFF),
            dark: Color(0xFF938F99),
            darkOn: Color(0xFF1C1B1F),
          ),
        ],
      ),
    );
  }
}

class _LightDarkPair extends StatelessWidget {
  const _LightDarkPair({
    required this.role,
    required this.lightHex,
    required this.darkHex,
    required this.light,
    required this.lightOn,
    required this.dark,
    required this.darkOn,
  });

  final String role;
  final String lightHex;
  final String darkHex;
  final Color light;
  final Color lightOn;
  final Color dark;
  final Color darkOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FC),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 120.0,
            child: Text(
              role,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1B1F),
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _BrightnessChip(
                    label: 'LIGHT',
                    hex: lightHex,
                    background: light,
                    foreground: lightOn,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: _BrightnessChip(
                    label: 'DARK',
                    hex: darkHex,
                    background: dark,
                    foreground: darkOn,
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

class _BrightnessChip extends StatelessWidget {
  const _BrightnessChip({
    required this.label,
    required this.hex,
    required this.background,
    required this.foreground,
  });

  final String label;
  final String hex;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
              color: foreground.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            hex,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION: Surface elevation tiers (03)
// =====================================================================

class _SurfaceElevationSection extends StatelessWidget {
  const _SurfaceElevationSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFFFFBFE), Color(0xFFF3EDF7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        children: const <Widget>[
          _ElevationTier(
            name: 'surfaceContainerLowest',
            hex: '0xFFFFFFFF',
            color: Color(0xFFFFFFFF),
            elevation: 0,
            description: 'Most receded, nearly white',
          ),
          SizedBox(height: 8.0),
          _ElevationTier(
            name: 'surfaceContainerLow',
            hex: '0xFFF7F2FA',
            color: Color(0xFFF7F2FA),
            elevation: 1,
            description: 'Slightly raised',
          ),
          SizedBox(height: 8.0),
          _ElevationTier(
            name: 'surfaceContainer',
            hex: '0xFFF3EDF7',
            color: Color(0xFFF3EDF7),
            elevation: 2,
            description: 'Default container tier',
          ),
          SizedBox(height: 8.0),
          _ElevationTier(
            name: 'surfaceContainerHigh',
            hex: '0xFFECE6F0',
            color: Color(0xFFECE6F0),
            elevation: 3,
            description: 'Distinct elevation',
          ),
          SizedBox(height: 8.0),
          _ElevationTier(
            name: 'surfaceContainerHighest',
            hex: '0xFFE6E0E9',
            color: Color(0xFFE6E0E9),
            elevation: 4,
            description: 'Most elevated tier',
          ),
        ],
      ),
    );
  }
}

class _ElevationTier extends StatelessWidget {
  const _ElevationTier({
    required this.name,
    required this.hex,
    required this.color,
    required this.elevation,
    required this.description,
  });

  final String name;
  final String hex;
  final Color color;
  final int elevation;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1F2937).withValues(alpha: 0.04 + elevation * 0.02),
            blurRadius: 4.0 + elevation * 3.0,
            offset: Offset(0.0, 1.0 + elevation.toDouble()),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF6750A4),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Text(
              'L$elevation',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1B1F),
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF6B7280),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Text(
            hex,
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION: Role relationships (04)
// =====================================================================

class _RoleRelationshipDiagram extends StatelessWidget {
  const _RoleRelationshipDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'primary',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B7280),
              fontFamily: 'monospace',
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFF6750A4), Color(0xFF7F67BE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x336750A4),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'primary  -  0xFF6750A4',
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const <Widget>[
                    _RoleBubble(
                      label: 'onPrimary',
                      hex: '0xFFFFFFFF',
                      bg: Color(0xFFFFFFFF),
                      fg: Color(0xFF6750A4),
                    ),
                    SizedBox(width: 10.0),
                    _ArrowDescriptor(text: 'foreground'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          _DiagramArrow(),
          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFFEADDFF), Color(0xFFD0BCFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              border: Border.all(color: const Color(0xFFCFC0E8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'primaryContainer  -  0xFFEADDFF',
                  style: const TextStyle(
                    color: Color(0xFF21005D),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const <Widget>[
                    _RoleBubble(
                      label: 'onPrimaryContainer',
                      hex: '0xFF21005D',
                      bg: Color(0xFF21005D),
                      fg: Color(0xFFEADDFF),
                    ),
                    SizedBox(width: 10.0),
                    _ArrowDescriptor(text: 'foreground'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Color(0xFFF3EDF7),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.info_outline, size: 18.0, color: Color(0xFF6750A4)),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Each pair encodes background + foreground. Use the on-prefix role '
                    'whenever drawing text or icons on the corresponding color.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF49454F),
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

class _RoleBubble extends StatelessWidget {
  const _RoleBubble({
    required this.label,
    required this.hex,
    required this.bg,
    required this.fg,
  });

  final String label;
  final String hex;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: const Color(0x33000000), width: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: 1.0,
            height: 12.0,
            color: fg.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 8.0),
          Text(
            hex,
            style: TextStyle(
              color: fg.withValues(alpha: 0.85),
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowDescriptor extends StatelessWidget {
  const _ArrowDescriptor({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 16.0,
          height: 1.5,
          color: const Color(0x66FFFFFF),
        ),
        const SizedBox(width: 6.0),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 10.5,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

class _DiagramArrow extends StatelessWidget {
  const _DiagramArrow();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 2.0,
            height: 18.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF6750A4), Color(0xFFEADDFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Color(0xFFEADDFF), size: 22.0),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION: Contrast / accessibility (05)
// =====================================================================

class _ContrastCardsSection extends StatelessWidget {
  const _ContrastCardsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        children: const <Widget>[
          _ContrastRow(<_ContrastData>[
            _ContrastData(
              role: 'onPrimary on primary',
              bg: Color(0xFF6750A4),
              fg: Color(0xFFFFFFFF),
              ratio: 'AAA 8.4:1',
              level: 'AAA',
            ),
            _ContrastData(
              role: 'onSurface on surface',
              bg: Color(0xFFFFFBFE),
              fg: Color(0xFF1C1B1F),
              ratio: 'AAA 17.1:1',
              level: 'AAA',
            ),
          ]),
          SizedBox(height: 12.0),
          _ContrastRow(<_ContrastData>[
            _ContrastData(
              role: 'onPrimaryContainer',
              bg: Color(0xFFEADDFF),
              fg: Color(0xFF21005D),
              ratio: 'AAA 13.0:1',
              level: 'AAA',
            ),
            _ContrastData(
              role: 'onError on error',
              bg: Color(0xFFB3261E),
              fg: Color(0xFFFFFFFF),
              ratio: 'AA 7.0:1',
              level: 'AA',
            ),
          ]),
          SizedBox(height: 12.0),
          _ContrastRow(<_ContrastData>[
            _ContrastData(
              role: 'onSurfaceVariant',
              bg: Color(0xFFE7E0EC),
              fg: Color(0xFF49454F),
              ratio: 'AA 5.4:1',
              level: 'AA',
            ),
            _ContrastData(
              role: 'outline on surface',
              bg: Color(0xFFFFFBFE),
              fg: Color(0xFF79747E),
              ratio: 'AA 4.5:1',
              level: 'AA',
            ),
          ]),
          SizedBox(height: 12.0),
          _ContrastRow(<_ContrastData>[
            _ContrastData(
              role: 'onTertiary on tertiary',
              bg: Color(0xFF7D5260),
              fg: Color(0xFFFFFFFF),
              ratio: 'AAA 7.5:1',
              level: 'AAA',
            ),
            _ContrastData(
              role: 'onSecondaryContainer',
              bg: Color(0xFFE8DEF8),
              fg: Color(0xFF1D192B),
              ratio: 'AAA 15.6:1',
              level: 'AAA',
            ),
          ]),
        ],
      ),
    );
  }
}

class _ContrastData {
  const _ContrastData({
    required this.role,
    required this.bg,
    required this.fg,
    required this.ratio,
    required this.level,
  });
  final String role;
  final Color bg;
  final Color fg;
  final String ratio;
  final String level;
}

class _ContrastRow extends StatelessWidget {
  const _ContrastRow(this.entries);
  final List<_ContrastData> entries;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < entries.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(width: 10.0),
          Expanded(child: _ContrastCard(data: entries[i])),
        ],
      ],
    );
  }
}

class _ContrastCard extends StatelessWidget {
  const _ContrastCard({required this.data});

  final _ContrastData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
      decoration: BoxDecoration(
        color: data.bg,
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.role,
            style: TextStyle(
              color: data.fg,
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Lorem ipsum dolor sit amet.',
            style: TextStyle(
              color: data.fg,
              fontSize: 12.0,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: data.fg.withValues(alpha: 0.15),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                ),
                child: Text(
                  data.level,
                  style: TextStyle(
                    color: data.fg,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                data.ratio,
                style: TextStyle(
                  color: data.fg.withValues(alpha: 0.85),
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION: fromSeed (06)
// =====================================================================

class _FromSeedCard extends StatelessWidget {
  const _FromSeedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFF1E1B2E), Color(0xFF332D4A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5F56),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFBD2E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF27C93F),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'color_scheme.dart',
                      style: TextStyle(
                        color: Color(0x99FFFFFF),
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'final scheme = ColorScheme.fromSeed(',
                  style: TextStyle(
                    color: Color(0xFFEADDFF),
                    fontSize: 13.0,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
                const Text(
                  '  seedColor: Color(0xFF6750A4),',
                  style: TextStyle(
                    color: Color(0xFFD0BCFF),
                    fontSize: 13.0,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
                const Text(
                  '  brightness: Brightness.light,',
                  style: TextStyle(
                    color: Color(0xFFD0BCFF),
                    fontSize: 13.0,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
                const Text(
                  ');',
                  style: TextStyle(
                    color: Color(0xFFEADDFF),
                    fontSize: 13.0,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  '// derives 30+ roles from one color',
                  style: TextStyle(
                    color: Color(0xFF8B7AA8),
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18.0),
          const Text(
            'Derived roles:',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B7280),
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: const <Widget>[
              _SeedDerivedSwatch(label: 'primary', hex: '0xFF6750A4', color: Color(0xFF6750A4)),
              SizedBox(width: 8.0),
              _SeedDerivedSwatch(label: 'secondary', hex: '0xFF625B71', color: Color(0xFF625B71)),
              SizedBox(width: 8.0),
              _SeedDerivedSwatch(label: 'tertiary', hex: '0xFF7D5260', color: Color(0xFF7D5260)),
              SizedBox(width: 8.0),
              _SeedDerivedSwatch(
                  label: 'primaryCont.', hex: '0xFFEADDFF', color: Color(0xFFEADDFF)),
              SizedBox(width: 8.0),
              _SeedDerivedSwatch(
                  label: 'surface', hex: '0xFFFFFBFE', color: Color(0xFFFFFBFE)),
              SizedBox(width: 8.0),
              _SeedDerivedSwatch(label: 'outline', hex: '0xFF79747E', color: Color(0xFF79747E)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SeedDerivedSwatch extends StatelessWidget {
  const _SeedDerivedSwatch({
    required this.label,
    required this.hex,
    required this.color,
  });

  final String label;
  final String hex;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 44.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1B1F),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            hex,
            style: const TextStyle(
              fontSize: 8.5,
              fontFamily: 'monospace',
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION: Tonal palette (07)
// =====================================================================

class _TonalPaletteSection extends StatelessWidget {
  const _TonalPaletteSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFFFFFFF), Color(0xFFFAF8FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32.0,
                height: 32.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF6750A4),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'Seed: deepPurple (0xFF6750A4)',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1B1F),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            height: 56.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
            ),
            child: Row(
              children: const <Widget>[
                _TonalBand(tone: 0, color: Color(0xFF000000), text: Color(0xFFFFFFFF)),
                _TonalBand(tone: 10, color: Color(0xFF21005D), text: Color(0xFFFFFFFF)),
                _TonalBand(tone: 20, color: Color(0xFF381E72), text: Color(0xFFFFFFFF)),
                _TonalBand(tone: 30, color: Color(0xFF4F378B), text: Color(0xFFFFFFFF)),
                _TonalBand(tone: 40, color: Color(0xFF6750A4), text: Color(0xFFFFFFFF)),
                _TonalBand(tone: 50, color: Color(0xFF7F67BE), text: Color(0xFFFFFFFF)),
                _TonalBand(tone: 60, color: Color(0xFF9A82DB), text: Color(0xFF1C1B1F)),
                _TonalBand(tone: 70, color: Color(0xFFB69DF8), text: Color(0xFF1C1B1F)),
                _TonalBand(tone: 80, color: Color(0xFFD0BCFF), text: Color(0xFF1C1B1F)),
                _TonalBand(tone: 90, color: Color(0xFFEADDFF), text: Color(0xFF1C1B1F)),
                _TonalBand(tone: 95, color: Color(0xFFF6EDFF), text: Color(0xFF1C1B1F)),
                _TonalBand(tone: 99, color: Color(0xFFFFFBFE), text: Color(0xFF1C1B1F)),
                _TonalBand(tone: 100, color: Color(0xFFFFFFFF), text: Color(0xFF1C1B1F)),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          const Text(
            'Material 3 builds 13 tonal values (HCT lightness). Roles map to specific '
            'tones: primary = tone 40 in light scheme, tone 80 in dark scheme. '
            'Containers use tone 90 / 30. Surfaces use tones close to 99 / 10.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF49454F),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _TonalBand extends StatelessWidget {
  const _TonalBand({
    required this.tone,
    required this.color,
    required this.text,
  });

  final int tone;
  final Color color;
  final Color text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: Text(
          '$tone',
          style: TextStyle(
            color: text,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION: Migration v2 -> v3 (08)
// =====================================================================

class _MigrationTable extends StatelessWidget {
  const _MigrationTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    'OLD (v2)',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'NEW (v3)',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'STATUS',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          const _MigrationRow(
            oldName: 'background',
            newName: 'surface',
            status: 'renamed',
            statusColor: Color(0xFFEA580C),
          ),
          const _MigrationRow(
            oldName: 'onBackground',
            newName: 'onSurface',
            status: 'renamed',
            statusColor: Color(0xFFEA580C),
          ),
          const _MigrationRow(
            oldName: 'surfaceVariant',
            newName: 'surfaceContainerHighest',
            status: 'replaced',
            statusColor: Color(0xFFB91C1C),
          ),
          const _MigrationRow(
            oldName: 'primaryVariant',
            newName: 'primaryContainer',
            status: 'replaced',
            statusColor: Color(0xFFB91C1C),
          ),
          const _MigrationRow(
            oldName: 'secondaryVariant',
            newName: 'secondaryContainer',
            status: 'replaced',
            statusColor: Color(0xFFB91C1C),
          ),
          const _MigrationRow(
            oldName: '(none)',
            newName: 'surfaceContainerLowest',
            status: 'new',
            statusColor: Color(0xFF065F46),
          ),
          const _MigrationRow(
            oldName: '(none)',
            newName: 'surfaceContainerLow',
            status: 'new',
            statusColor: Color(0xFF065F46),
          ),
          const _MigrationRow(
            oldName: '(none)',
            newName: 'surfaceContainerHigh',
            status: 'new',
            statusColor: Color(0xFF065F46),
          ),
          const _MigrationRow(
            oldName: '(none)',
            newName: 'surfaceBright',
            status: 'new',
            statusColor: Color(0xFF065F46),
          ),
          const _MigrationRow(
            oldName: '(none)',
            newName: 'surfaceDim',
            status: 'new',
            statusColor: Color(0xFF065F46),
          ),
        ],
      ),
    );
  }
}

class _MigrationRow extends StatelessWidget {
  const _MigrationRow({
    required this.oldName,
    required this.newName,
    required this.status,
    required this.statusColor,
  });

  final String oldName;
  final String newName;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FC),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              oldName,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: oldName == '(none)'
                    ? const Color(0xFFBDBDBD)
                    : const Color(0xFF1C1B1F),
                fontWeight: FontWeight.w600,
                decoration: oldName == '(none)'
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              newName,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: Color(0xFF065F46),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.13),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
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

// =====================================================================
// SECTION: Pitfalls (09)
// =====================================================================

class _PitfallsList extends StatelessWidget {
  const _PitfallsList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A1F2937),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        children: const <Widget>[
          _PitfallItem(
            number: '1',
            title: 'Don\'t hard-code colors',
            body:
                'Use Theme.of(context).colorScheme.primary instead of Color(0xFF6750A4). '
                'Themes stop working as soon as you bake values in.',
            accent: Color(0xFFB91C1C),
          ),
          SizedBox(height: 10.0),
          _PitfallItem(
            number: '2',
            title: 'Respect brightness',
            body:
                'Build separate light and dark ColorScheme instances. Don\'t reuse '
                'one scheme and tweak colors at draw time.',
            accent: Color(0xFFEA580C),
          ),
          SizedBox(height: 10.0),
          _PitfallItem(
            number: '3',
            title: 'Always pair on- roles with their base',
            body:
                'When drawing text on primaryContainer, use onPrimaryContainer for '
                'the foreground. Mixing pairs ruins contrast.',
            accent: Color(0xFF4338CA),
          ),
          SizedBox(height: 10.0),
          _PitfallItem(
            number: '4',
            title: 'Prefer fromSeed for new themes',
            body:
                'fromSeed derives every role from a single seed color and guarantees '
                'consistent tonal relationships across all 30+ roles.',
            accent: Color(0xFF065F46),
          ),
          SizedBox(height: 10.0),
          _PitfallItem(
            number: '5',
            title: 'background / surfaceVariant are dead',
            body:
                'Migrate v2 names: background -> surface, surfaceVariant -> '
                'surfaceContainerHighest. The deprecated names emit warnings.',
            accent: Color(0xFF1E40AF),
          ),
        ],
      ),
    );
  }
}

class _PitfallItem extends StatelessWidget {
  const _PitfallItem({
    required this.number,
    required this.title,
    required this.body,
    required this.accent,
  });

  final String number;
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border(
          left: BorderSide(color: accent, width: 3.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30.0,
            height: 30.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
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
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: accent,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF49454F),
                    height: 1.5,
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

// =====================================================================
// SECTION: Footer
// =====================================================================

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1C1B1F), Color(0xFF332D41)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x331C1B1F),
            blurRadius: 18.0,
            offset: Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFFD0BCFF), Color(0xFFEADDFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF381E72),
              size: 24.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'ColorScheme deep demo',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  'Static snapshot - Flutter Material 3 - v1.0',
                  style: TextStyle(
                    color: Color(0xCCEADDFF),
                    fontSize: 11.5,
                    fontFamily: 'monospace',
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
