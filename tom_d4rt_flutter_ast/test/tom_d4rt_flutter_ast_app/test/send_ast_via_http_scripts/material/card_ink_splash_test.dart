// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt deep-demo test: Material Surface and Ripple Atelier
// Theme: A tactile gallery exploring Card variants, Material elevation,
// InkWell/InkResponse interaction surfaces, and splash factory aesthetics.
// Covers: Card (default/filled/outlined), Material elevation steps, InkWell,
// InkResponse, InkSplash, InkRipple, NoSplash, splashColor, highlightColor,
// splashFactory, Material elevation/shape/color.
import 'package:flutter/material.dart';

// ============================================================================
// COLOR PALETTES (one palette per section, evoking the "atelier" theme)
// ============================================================================

// Section 1 palette: warm parchment (Card variants)
const Color _s1Deep = Color(0xFF5D4037);
const Color _s1Mid = Color(0xFF8D6E63);
const Color _s1Soft = Color(0xFFD7CCC8);
const Color _s1Wash = Color(0xFFEFEBE9);
const Color _s1Accent = Color(0xFFFF8A65);

// Section 2 palette: cool slate (Material elevation)
const Color _s2Deep = Color(0xFF263238);
const Color _s2Mid = Color(0xFF455A64);
const Color _s2Soft = Color(0xFFB0BEC5);
const Color _s2Wash = Color(0xFFECEFF1);
const Color _s2Accent = Color(0xFF26C6DA);

// Section 3 palette: viridian (InkWell)
const Color _s3Deep = Color(0xFF1B5E20);
const Color _s3Mid = Color(0xFF388E3C);
const Color _s3Soft = Color(0xFFA5D6A7);
const Color _s3Wash = Color(0xFFE8F5E9);
const Color _s3Accent = Color(0xFFFFEB3B);

// Section 4 palette: amethyst (InkResponse)
const Color _s4Deep = Color(0xFF4A148C);
const Color _s4Mid = Color(0xFF7B1FA2);
const Color _s4Soft = Color(0xFFCE93D8);
const Color _s4Wash = Color(0xFFF3E5F5);
const Color _s4Accent = Color(0xFFFFD54F);

// Section 5 palette: rose ember (InkSplash)
const Color _s5Deep = Color(0xFFB71C1C);
const Color _s5Mid = Color(0xFFE53935);
const Color _s5Soft = Color(0xFFFFCDD2);
const Color _s5Wash = Color(0xFFFFEBEE);
const Color _s5Accent = Color(0xFFFFCA28);

// Section 6 palette: ocean ripple (InkRipple)
const Color _s6Deep = Color(0xFF01579B);
const Color _s6Mid = Color(0xFF0288D1);
const Color _s6Soft = Color(0xFFB3E5FC);
const Color _s6Wash = Color(0xFFE1F5FE);
const Color _s6Accent = Color(0xFF80DEEA);

// Section 7 palette: graphite (splashFactory variants / NoSplash)
const Color _s7Deep = Color(0xFF212121);
const Color _s7Mid = Color(0xFF424242);
const Color _s7Soft = Color(0xFFBDBDBD);
const Color _s7Wash = Color(0xFFF5F5F5);
const Color _s7Accent = Color(0xFF00BFA5);

// Section 8 palette: marigold (custom shape & border)
const Color _s8Deep = Color(0xFFE65100);
const Color _s8Mid = Color(0xFFFB8C00);
const Color _s8Soft = Color(0xFFFFE0B2);
const Color _s8Wash = Color(0xFFFFF3E0);
const Color _s8Accent = Color(0xFF6D4C41);

// Section 9 palette: comparison grid (steel)
const Color _s9Deep = Color(0xFF1A237E);
const Color _s9Mid = Color(0xFF3949AB);
const Color _s9Soft = Color(0xFFC5CAE9);
const Color _s9Wash = Color(0xFFE8EAF6);
const Color _s9Accent = Color(0xFFFFA000);

// Hero palette
const Color _heroA = Color(0xFF1A237E);
const Color _heroB = Color(0xFF311B92);
const Color _heroC = Color(0xFFAD1457);

// ============================================================================
// HELPER BUILDERS
// ============================================================================

Widget _sectionBanner({
  required String number,
  required String title,
  required String subtitle,
  required Color deep,
  required Color accent,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [deep, accent],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0x55FFFFFF),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFEEEEEE),
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

Widget _recipeCard({
  required String title,
  required List<String> lines,
  required Color deep,
  required Color soft,
  required Color wash,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: wash,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: deep,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'RECIPE',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: deep,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              line,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _propertyChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _tableHeader(List<String> cells, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
    ),
    child: Row(
      children: [
        for (final cell in cells)
          Expanded(
            child: Text(
              cell,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, Color zebra) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(color: zebra),
    child: Row(
      children: [
        for (final cell in cells)
          Expanded(
            child: Text(
              cell,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
      ],
    ),
  );
}

/// Static "snapshot" of a splash — a circular radial gradient simulating
/// the ink expanding from a tap point, plus a translucent highlight overlay.
Widget _splashSnapshot({
  required double size,
  required double progress,
  required Color splashColor,
  required Color highlightColor,
  required Alignment origin,
}) {
  // We freeze the splash at a given progress (0..1) for visual demonstration.
  // No animation controllers used — purely static decoration.
  final frozen = AlwaysStoppedAnimation<double>(progress);
  final radius = size * frozen.value;
  return SizedBox(
    width: size,
    height: size,
    child: Stack(
      children: [
        // Highlight wash (entire surface)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: highlightColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        // Radial splash bloom
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: RadialGradient(
                center: origin,
                radius: frozen.value.clamp(0.05, 1.5),
                colors: [
                  splashColor,
                  splashColor.withOpacity(0.4),
                  splashColor.withOpacity(0.0),
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
        ),
        // Progress badge
        Positioned(
          right: 6.0,
          top: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xCC000000),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'r=${radius.toStringAsFixed(1)}',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 9.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _elevationTile({
  required double elevation,
  required Color color,
  required Color shadow,
  required String label,
}) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    child: Material(
      color: color,
      elevation: elevation,
      shadowColor: shadow,
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: 90.0,
        height: 70.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF263238),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'dp ${elevation.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Color(0xFF455A64),
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HERO HEADER
// ============================================================================

Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_heroA, _heroB, _heroC],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: const Color(0x66000000),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                'M',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Material Surface & Ripple Atelier',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    'A deep-demo tour of Card, Material, Ink, and Splash factories',
                    style: TextStyle(
                      color: Color(0xFFE1BEE7),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Wrap(
          children: [
            _propertyChip('Card', const Color(0x55FFFFFF)),
            _propertyChip('Material', const Color(0x55FFFFFF)),
            _propertyChip('InkWell', const Color(0x55FFFFFF)),
            _propertyChip('InkResponse', const Color(0x55FFFFFF)),
            _propertyChip('InkSplash', const Color(0x55FFFFFF)),
            _propertyChip('InkRipple', const Color(0x55FFFFFF)),
            _propertyChip('NoSplash', const Color(0x55FFFFFF)),
            _propertyChip('splashColor', const Color(0x55FFFFFF)),
            _propertyChip('highlightColor', const Color(0x55FFFFFF)),
            _propertyChip('splashFactory', const Color(0x55FFFFFF)),
            _propertyChip('elevation', const Color(0x55FFFFFF)),
            _propertyChip('shape', const Color(0x55FFFFFF)),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0x33000000),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Welcome to the Atelier — a visual workshop where each Material '
            'surface, ink overlay, and splash factory is dissected, swatched, '
            'and re-assembled. Every section is a curated bench: the recipe '
            'card states intent, the demo shows the result, and the property '
            'chips capture the API surface in one glance.',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// CONCEPT OVERVIEW PANEL
// ============================================================================

Widget _conceptOverview() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _heroA,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'i',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Concept Overview',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'In Material Design, every interactive surface is built on three '
          'layers: a Material (the physical surface with elevation and shape), '
          'an Ink layer (where decorations are painted), and an Ink Feature '
          '(the splash or highlight that responds to touch). Cards bundle '
          'these into ready-made elevated panels. Splash factories let you '
          'swap the visual language of the ripple itself.',
          style: TextStyle(fontSize: 13.0, height: 1.55),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Sections in this atelier:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 8.0),
        const Text('1. Card variants — default, filled, outlined',
            style: TextStyle(fontSize: 12.5)),
        const Text('2. Material elevation — 0/1/2/4/8/12/16/24',
            style: TextStyle(fontSize: 12.5)),
        const Text('3. InkWell — bounded splash surfaces',
            style: TextStyle(fontSize: 12.5)),
        const Text('4. InkResponse — unbounded splash with custom radius',
            style: TextStyle(fontSize: 12.5)),
        const Text('5. InkSplash factory — the classic radial bloom',
            style: TextStyle(fontSize: 12.5)),
        const Text('6. InkRipple factory — the modern Material 3 wave',
            style: TextStyle(fontSize: 12.5)),
        const Text('7. NoSplash and custom factories',
            style: TextStyle(fontSize: 12.5)),
        const Text('8. Custom shape & border',
            style: TextStyle(fontSize: 12.5)),
        const Text('9. Comparison grid — all factories side by side',
            style: TextStyle(fontSize: 12.5)),
        const Text('10. Glossary & epilogue',
            style: TextStyle(fontSize: 12.5)),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1: CARD VARIANTS
// ============================================================================

Widget _section1CardVariants() {
  // Variant 1: Default elevated Card with custom shadow and shape.
  final elevatedCard = Card(
    color: const Color(0xFFFFFFFF),
    shadowColor: const Color(0x66000000),
    surfaceTintColor: _s1Wash,
    elevation: 4.0,
    margin: const EdgeInsets.all(8.0),
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: const BorderSide(color: _s1Soft),
    ),
    semanticContainer: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_s1Mid, _s1Accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Text(
              'Elevated',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card (default)',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: _s1Deep,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'elevation: 4.0\nclipBehavior: antiAlias',
                style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // Variant 2: Filled Card — no shadow, tinted surface.
  final filledCard = Card.filled(
    color: _s1Wash,
    shadowColor: const Color(0x00000000),
    elevation: 0.0,
    margin: const EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card.filled',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: _s1Deep,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'A tinted surface with no shadow.\nUseful inside scaffolds where '
            'elevation noise would compete with content.',
            style: TextStyle(fontSize: 12.0, height: 1.4),
          ),
        ],
      ),
    ),
  );

  // Variant 3: Outlined Card — explicit border, flat surface.
  final outlinedCard = Card.outlined(
    color: const Color(0xFFFFFFFF),
    elevation: 0.0,
    margin: const EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: const BorderSide(color: _s1Mid, width: 1.2),
    ),
    child: const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card.outlined',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: _s1Deep,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Hairline border replaces elevation. Calm, geometric.',
            style: TextStyle(fontSize: 12.0, height: 1.4),
          ),
        ],
      ),
    ),
  );

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s1Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s1Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '1',
          title: 'Card Variants',
          subtitle: 'Default, filled, outlined — the three faces of Card',
          deep: _s1Deep,
          accent: _s1Accent,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          children: [
            _propertyChip('elevation', _s1Mid),
            _propertyChip('shape', _s1Mid),
            _propertyChip('color', _s1Mid),
            _propertyChip('shadowColor', _s1Mid),
            _propertyChip('surfaceTintColor', _s1Mid),
            _propertyChip('margin', _s1Mid),
            _propertyChip('clipBehavior', _s1Mid),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: elevatedCard),
            Expanded(child: filledCard),
            Expanded(child: outlinedCard),
          ],
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'Choose your Card flavor',
          lines: const [
            '• Default: elevation > 0, casts a shadow',
            '• Card.filled: tinted surface, elevation 0',
            '• Card.outlined: hairline border, elevation 0',
            '• All three honor shape/clipBehavior/margin',
          ],
          deep: _s1Deep,
          soft: _s1Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(
              const ['Variant', 'Elevation', 'Border', 'Use'],
              _s1Deep,
            ),
            _tableRow(
              const ['default', '0+', 'none', 'general'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['filled', '0', 'none', 'in-scaffold'],
              _s1Wash,
            ),
            _tableRow(
              const ['outlined', '0', 'side', 'low-noise'],
              const Color(0xFFFFFFFF),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2: MATERIAL ELEVATION STEPS
// ============================================================================

Widget _section2Elevation() {
  const elevations = [0.0, 1.0, 2.0, 4.0, 8.0, 12.0, 16.0, 24.0];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s2Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s2Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '2',
          title: 'Material Elevation',
          subtitle: 'Eight canonical steps from flush to floating',
          deep: _s2Deep,
          accent: _s2Accent,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: [
            _propertyChip('Material', _s2Mid),
            _propertyChip('elevation', _s2Mid),
            _propertyChip('shadowColor', _s2Mid),
            _propertyChip('borderRadius', _s2Mid),
            _propertyChip('color', _s2Mid),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              for (final e in elevations)
                _elevationTile(
                  elevation: e,
                  color: const Color(0xFFFFFFFF),
                  shadow: _s2Deep,
                  label: 'level',
                ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'Reading the elevation ladder',
          lines: const [
            '• 0 dp: flush with parent surface',
            '• 1-2 dp: cards, switches at rest',
            '• 4 dp: AppBars, raised elements',
            '• 8 dp: navigation drawers, FABs',
            '• 12-16 dp: pickers, snackbars',
            '• 24 dp: modal dialogs, top-most surfaces',
          ],
          deep: _s2Deep,
          soft: _s2Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(const ['dp', 'Role', 'Example'], _s2Deep),
            _tableRow(const ['0', 'flush', 'inline panel'],
                const Color(0xFFFFFFFF)),
            _tableRow(const ['1', 'resting', 'card'], _s2Wash),
            _tableRow(const ['2', 'resting+', 'switch'],
                const Color(0xFFFFFFFF)),
            _tableRow(const ['4', 'raised', 'AppBar'], _s2Wash),
            _tableRow(const ['8', 'hovered', 'FAB'],
                const Color(0xFFFFFFFF)),
            _tableRow(const ['12', 'menu', 'submenu'], _s2Wash),
            _tableRow(const ['16', 'sheet', 'nav drawer'],
                const Color(0xFFFFFFFF)),
            _tableRow(const ['24', 'top', 'modal'], _s2Wash),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3: INKWELL
// ============================================================================

Widget _section3InkWell() {
  // Bounded splash surface — visualised statically as a Material + Ink frame.
  Widget inkWellDemo({
    required String label,
    required Color splash,
    required Color highlight,
    required BorderRadius radius,
  }) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      width: 150.0,
      height: 90.0,
      child: Material(
        color: const Color(0xFFFFFFFF),
        borderRadius: radius,
        elevation: 1.0,
        child: InkWell(
          onTap: () {},
          onDoubleTap: () {},
          onLongPress: () {},
          onHover: (_) {},
          onHighlightChanged: (_) {},
          splashColor: splash,
          highlightColor: highlight,
          borderRadius: radius,
          child: Stack(
            children: [
              // Frozen snapshot underlay
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: radius,
                  child: _splashSnapshot(
                    size: 150.0,
                    progress: 0.6,
                    splashColor: splash,
                    highlightColor: highlight,
                    origin: Alignment.center,
                  ),
                ),
              ),
              Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: _s3Deep,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s3Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s3Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '3',
          title: 'InkWell',
          subtitle: 'Bounded splash region — the everyday tap surface',
          deep: _s3Deep,
          accent: _s3Accent,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: [
            _propertyChip('onTap', _s3Mid),
            _propertyChip('onDoubleTap', _s3Mid),
            _propertyChip('onLongPress', _s3Mid),
            _propertyChip('onHover', _s3Mid),
            _propertyChip('splashColor', _s3Mid),
            _propertyChip('highlightColor', _s3Mid),
            _propertyChip('borderRadius', _s3Mid),
            _propertyChip('splashFactory', _s3Mid),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            inkWellDemo(
              label: 'Soft',
              splash: _s3Mid.withOpacity(0.4),
              highlight: _s3Soft.withOpacity(0.3),
              radius: BorderRadius.circular(12.0),
            ),
            inkWellDemo(
              label: 'Vivid',
              splash: _s3Accent.withOpacity(0.55),
              highlight: _s3Soft.withOpacity(0.4),
              radius: BorderRadius.circular(8.0),
            ),
            inkWellDemo(
              label: 'Pill',
              splash: _s3Mid.withOpacity(0.5),
              highlight: _s3Accent.withOpacity(0.25),
              radius: BorderRadius.circular(40.0),
            ),
            inkWellDemo(
              label: 'Square',
              splash: _s3Deep.withOpacity(0.35),
              highlight: _s3Soft.withOpacity(0.35),
              radius: BorderRadius.zero,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'InkWell anatomy',
          lines: const [
            '• Lives inside a Material — paints its splash on that surface',
            '• onTap / onDoubleTap / onLongPress define the gesture set',
            '• splashColor is the bloom, highlightColor is the resting wash',
            '• borderRadius clips the splash to a rounded region',
            '• Pass splashFactory to switch between InkSplash/InkRipple/NoSplash',
          ],
          deep: _s3Deep,
          soft: _s3Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(
              const ['Callback', 'Trigger', 'Typical use'],
              _s3Deep,
            ),
            _tableRow(
              const ['onTap', 'single tap', 'select'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['onDoubleTap', 'double tap', 'zoom'],
              _s3Wash,
            ),
            _tableRow(
              const ['onLongPress', 'hold', 'context menu'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['onHover', 'pointer enter/exit', 'cursor swap'],
              _s3Wash,
            ),
            _tableRow(
              const ['onHighlightChanged', 'press state', 'analytics'],
              const Color(0xFFFFFFFF),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4: INK RESPONSE
// ============================================================================

Widget _section4InkResponse() {
  Widget inkResponseDemo({
    required String label,
    required double radius,
    required bool containedInk,
    required Color splash,
    required Color highlight,
  }) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 160.0,
      height: 100.0,
      child: Material(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        elevation: 2.0,
        child: InkResponse(
          onTap: () {},
          onLongPress: () {},
          containedInkWell: containedInk,
          highlightShape:
              containedInk ? BoxShape.rectangle : BoxShape.circle,
          radius: radius,
          splashColor: splash,
          highlightColor: highlight,
          child: Stack(
            children: [
              // Static visual surrogate for the splash
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: _splashSnapshot(
                    size: 160.0,
                    progress: 0.45,
                    splashColor: splash,
                    highlightColor: highlight,
                    origin: containedInk
                        ? Alignment.centerLeft
                        : Alignment.center,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: _s4Deep,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'r=${radius.toStringAsFixed(0)} ${containedInk ? 'bounded' : 'unbounded'}',
                      style: const TextStyle(
                        color: _s4Mid,
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s4Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s4Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '4',
          title: 'InkResponse',
          subtitle: 'Unbounded splash with custom radius and shape',
          deep: _s4Deep,
          accent: _s4Accent,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: [
            _propertyChip('containedInkWell', _s4Mid),
            _propertyChip('highlightShape', _s4Mid),
            _propertyChip('radius', _s4Mid),
            _propertyChip('splashFactory', _s4Mid),
            _propertyChip('splashColor', _s4Mid),
            _propertyChip('highlightColor', _s4Mid),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            inkResponseDemo(
              label: 'Bounded',
              radius: 30.0,
              containedInk: true,
              splash: _s4Mid.withOpacity(0.5),
              highlight: _s4Soft.withOpacity(0.4),
            ),
            inkResponseDemo(
              label: 'Unbounded',
              radius: 60.0,
              containedInk: false,
              splash: _s4Accent.withOpacity(0.5),
              highlight: _s4Soft.withOpacity(0.4),
            ),
            inkResponseDemo(
              label: 'Wide',
              radius: 90.0,
              containedInk: false,
              splash: _s4Deep.withOpacity(0.45),
              highlight: _s4Soft.withOpacity(0.4),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'InkResponse vs InkWell',
          lines: const [
            '• InkWell is shorthand for a bounded InkResponse',
            '• InkResponse lets you set radius explicitly',
            '• containedInkWell: false allows the splash to overflow',
            '• highlightShape: circle gives radial selection feedback',
            '• Use for icon buttons and tappable avatars',
          ],
          deep: _s4Deep,
          soft: _s4Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(
              const ['Param', 'Default', 'Effect'],
              _s4Deep,
            ),
            _tableRow(
              const ['containedInkWell', 'false', 'overflow on/off'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['highlightShape', 'circle', 'wash shape'],
              _s4Wash,
            ),
            _tableRow(
              const ['radius', 'auto', 'splash size'],
              const Color(0xFFFFFFFF),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5: INKSPLASH FACTORY
// ============================================================================

Widget _section5InkSplash() {
  // Frozen snapshots of an InkSplash at four progress steps.
  Widget frame(double progress, String label) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: _splashSnapshot(
              size: 120.0,
              progress: progress,
              splashColor: _s5Mid.withOpacity(0.55),
              highlightColor: _s5Soft.withOpacity(0.35),
              origin: Alignment.center,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'p=${(progress * 100).toStringAsFixed(0)}% $label',
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _s5Deep,
            ),
          ),
        ],
      ),
    );
  }

  // Reference the actual factory so the symbol is exercised.
  final InteractiveInkFeatureFactory splashFactory = InkSplash.splashFactory;
  final factoryName = splashFactory.runtimeType.toString();

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s5Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s5Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '5',
          title: 'InkSplash Factory',
          subtitle: 'The classic radial bloom — a single circle expanding outward',
          deep: _s5Deep,
          accent: _s5Accent,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: [
            _propertyChip('InkSplash.splashFactory', _s5Mid),
            _propertyChip('radial bloom', _s5Mid),
            _propertyChip('static origin', _s5Mid),
            _propertyChip(factoryName, _s5Mid),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              frame(0.1, 'seed'),
              frame(0.35, 'rise'),
              frame(0.6, 'crest'),
              frame(0.9, 'fade'),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'InkSplash characteristics',
          lines: const [
            '• Origin = tap point',
            '• Single radial circle, opacity fades out at end',
            '• Cheap to render; works well on any device',
            '• Use for: classic Material 2 surfaces, dense lists',
            '• Set via: splashFactory: InkSplash.splashFactory',
          ],
          deep: _s5Deep,
          soft: _s5Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(
              const ['Phase', 'Progress', 'Visual'],
              _s5Deep,
            ),
            _tableRow(
              const ['seed', '0-15%', 'tiny dot'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['rise', '15-50%', 'expanding'],
              _s5Wash,
            ),
            _tableRow(
              const ['crest', '50-75%', 'full bloom'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['fade', '75-100%', 'dissolving'],
              _s5Wash,
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6: INKRIPPLE FACTORY
// ============================================================================

Widget _section6InkRipple() {
  // The InkRipple factory animates a wave that begins at the tap and expands
  // beyond the surface. We illustrate three overlaid concentric rings.
  Widget rippleFrame(double progress) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      width: 130.0,
      height: 130.0,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _s6Soft, width: 1.0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: _splashSnapshot(
                size: 130.0,
                progress: progress,
                splashColor: _s6Mid.withOpacity(0.45),
                highlightColor: _s6Soft.withOpacity(0.35),
                origin: Alignment.topLeft,
              ),
            ),
          ),
          // Secondary ring for the "wave" feel
          Center(
            child: Container(
              width: 80.0 * progress + 20.0,
              height: 80.0 * progress + 20.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _s6Mid.withOpacity(1.0 - progress),
                  width: 2.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 6.0,
            bottom: 6.0,
            child: Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: _s6Deep,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final InteractiveInkFeatureFactory rippleFactory = InkRipple.splashFactory;

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s6Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s6Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '6',
          title: 'InkRipple Factory',
          subtitle: 'The modern wave — origin-aware, surface-filling',
          deep: _s6Deep,
          accent: _s6Accent,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: [
            _propertyChip('InkRipple.splashFactory', _s6Mid),
            _propertyChip('origin-aware', _s6Mid),
            _propertyChip('surface-filling', _s6Mid),
            _propertyChip(rippleFactory.runtimeType.toString(), _s6Mid),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            rippleFrame(0.15),
            rippleFrame(0.4),
            rippleFrame(0.7),
            rippleFrame(0.95),
          ],
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'InkRipple characteristics',
          lines: const [
            '• Animates from tap origin to the far edge',
            '• Two-tone: a foreground splash and a background wash',
            '• Used by Material 3 default theme',
            '• Feels lively on large surfaces and FABs',
            '• Set via: splashFactory: InkRipple.splashFactory',
          ],
          deep: _s6Deep,
          soft: _s6Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(
              const ['Factor', 'InkSplash', 'InkRipple'],
              _s6Deep,
            ),
            _tableRow(
              const ['shape', 'circle', 'circle+wash'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['fills surface', 'no', 'yes'],
              _s6Wash,
            ),
            _tableRow(
              const ['cost', 'low', 'medium'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['era', 'M2', 'M3'],
              _s6Wash,
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7: NOSPLASH AND CUSTOM SPLASHFACTORY
// ============================================================================

Widget _section7SplashFactories() {
  Widget cell({
    required String label,
    required Color splash,
    required Color highlight,
    required InteractiveInkFeatureFactory factory,
    required double progress,
  }) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      width: 150.0,
      child: Material(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        elevation: 1.0,
        child: InkWell(
          onTap: () {},
          splashFactory: factory,
          splashColor: splash,
          highlightColor: highlight,
          borderRadius: BorderRadius.circular(10.0),
          child: SizedBox(
            height: 80.0,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: _splashSnapshot(
                      size: 150.0,
                      progress: progress,
                      splashColor: splash,
                      highlightColor: highlight,
                      origin: Alignment.center,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: _s7Deep,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s7Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s7Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '7',
          title: 'splashFactory Variants',
          subtitle: 'Swap the splash language: classic, modern, none',
          deep: _s7Deep,
          accent: _s7Accent,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: [
            _propertyChip('InkSplash.splashFactory', _s7Mid),
            _propertyChip('InkRipple.splashFactory', _s7Mid),
            _propertyChip('NoSplash.splashFactory', _s7Mid),
            _propertyChip('Custom factory', _s7Mid),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            cell(
              label: 'InkSplash',
              splash: _s7Accent.withOpacity(0.55),
              highlight: _s7Soft.withOpacity(0.4),
              factory: InkSplash.splashFactory,
              progress: 0.65,
            ),
            cell(
              label: 'InkRipple',
              splash: _s7Mid.withOpacity(0.55),
              highlight: _s7Soft.withOpacity(0.4),
              factory: InkRipple.splashFactory,
              progress: 0.65,
            ),
            cell(
              label: 'NoSplash',
              splash: const Color(0x00000000),
              highlight: const Color(0x00000000),
              factory: NoSplash.splashFactory,
              progress: 0.0,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'When to override splashFactory',
          lines: const [
            '• NoSplash for desktop hover, where a splash is distracting',
            '• InkRipple for Material 3 visual consistency',
            '• InkSplash for retro / dense / low-power surfaces',
            '• Custom factories swap the ink primitive entirely',
            '• Set on InkWell, InkResponse, or ThemeData.splashFactory',
          ],
          deep: _s7Deep,
          soft: _s7Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(
              const ['Factory', 'Visual', 'When'],
              _s7Deep,
            ),
            _tableRow(
              const ['InkSplash', 'circle', 'M2 lists'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['InkRipple', 'wave', 'M3 default'],
              _s7Wash,
            ),
            _tableRow(
              const ['NoSplash', 'none', 'desktop'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['custom', 'any', 'theming'],
              _s7Wash,
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8: CUSTOM SHAPE AND BORDER
// ============================================================================

Widget _section8CustomShape() {
  Widget shapedCard({
    required ShapeBorder shape,
    required String label,
    required String spec,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color(0xFFFFFFFF),
        elevation: 3.0,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Container(
          width: 170.0,
          height: 100.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_s8Wash, _s8Soft],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _s8Deep,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                spec,
                style: const TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _s8Accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s8Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s8Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '8',
          title: 'Custom Shape & Border',
          subtitle: 'Bend the silhouette — rounded, beveled, stadium, circle',
          deep: _s8Deep,
          accent: _s8Accent,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: [
            _propertyChip('RoundedRectangleBorder', _s8Mid),
            _propertyChip('BeveledRectangleBorder', _s8Mid),
            _propertyChip('StadiumBorder', _s8Mid),
            _propertyChip('CircleBorder', _s8Mid),
            _propertyChip('BorderSide', _s8Mid),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            shapedCard(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: _s8Mid, width: 1.5),
              ),
              label: 'Rounded',
              spec: 'radius: 16, side: 1.5',
            ),
            shapedCard(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                side: BorderSide(color: _s8Deep, width: 2.0),
              ),
              label: 'Beveled',
              spec: 'beveled corners',
            ),
            shapedCard(
              shape: const StadiumBorder(
                side: BorderSide(color: _s8Accent, width: 1.5),
              ),
              label: 'Stadium',
              spec: 'pill silhouette',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 110.0,
                height: 110.0,
                child: Card(
                  color: const Color(0xFFFFFFFF),
                  elevation: 4.0,
                  shape: const CircleBorder(
                    side: BorderSide(color: _s8Mid, width: 2.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.zero,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        colors: [_s8Accent, _s8Soft],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Circle',
                        style: TextStyle(
                          color: _s8Deep,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'Shaping the surface',
          lines: const [
            '• shape: RoundedRectangleBorder(radius, side)',
            '• shape: BeveledRectangleBorder for cut corners',
            '• shape: StadiumBorder for pill buttons',
            '• shape: CircleBorder for avatars and FAB-like cards',
            '• Pair with clipBehavior: Clip.antiAlias for clean ink',
          ],
          deep: _s8Deep,
          soft: _s8Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(
              const ['Shape', 'Corners', 'Use case'],
              _s8Deep,
            ),
            _tableRow(
              const ['Rounded', 'curved', 'cards'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['Beveled', 'angular', 'badges'],
              _s8Wash,
            ),
            _tableRow(
              const ['Stadium', 'fully round', 'chips'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['Circle', 'circular', 'avatars'],
              _s8Wash,
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9: COMPARISON GRID
// ============================================================================

Widget _section9ComparisonGrid() {
  Widget gridCell(String title, String factory, Color color, double progress) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: 150.0,
      height: 130.0,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            factory,
            style: const TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: _s9Deep,
            ),
          ),
          const SizedBox(height: 6.0),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: _splashSnapshot(
                size: 130.0,
                progress: progress,
                splashColor: color.withOpacity(0.55),
                highlightColor: color.withOpacity(0.2),
                origin: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _s9Wash,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _s9Soft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionBanner(
          number: '9',
          title: 'Comparison Grid',
          subtitle: 'All splash factories side by side at three progress steps',
          deep: _s9Deep,
          accent: _s9Accent,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            gridCell('InkSplash 25%', 'InkSplash.splashFactory', _s5Mid, 0.25),
            gridCell('InkSplash 60%', 'InkSplash.splashFactory', _s5Mid, 0.6),
            gridCell('InkSplash 95%', 'InkSplash.splashFactory', _s5Mid, 0.95),
            gridCell('InkRipple 25%', 'InkRipple.splashFactory', _s6Mid, 0.25),
            gridCell('InkRipple 60%', 'InkRipple.splashFactory', _s6Mid, 0.6),
            gridCell('InkRipple 95%', 'InkRipple.splashFactory', _s6Mid, 0.95),
            gridCell('NoSplash all', 'NoSplash.splashFactory', _s7Mid, 0.0),
          ],
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          title: 'Reading the grid',
          lines: const [
            '• Rows fix the factory; columns fix the progress',
            '• Note how InkRipple covers more surface at high progress',
            '• NoSplash row is flat — there is no visual feedback',
            '• In practice, pick by motion language not by speed',
            '• splashColor + highlightColor define the visible palette',
          ],
          deep: _s9Deep,
          soft: _s9Soft,
          wash: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: [
            _tableHeader(
              const ['Factory', 'Origin', 'Reaches edge?'],
              _s9Deep,
            ),
            _tableRow(
              const ['InkSplash', 'tap point', 'no'],
              const Color(0xFFFFFFFF),
            ),
            _tableRow(
              const ['InkRipple', 'tap point', 'yes'],
              _s9Wash,
            ),
            _tableRow(
              const ['NoSplash', 'n/a', 'n/a'],
              const Color(0xFFFFFFFF),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// GLOSSARY PANEL
// ============================================================================

Widget _glossaryPanel() {
  Widget entry(String term, String def, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  term,
                  style: TextStyle(
                    color: color,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  def,
                  style: const TextStyle(
                    fontSize: 12.0,
                    height: 1.45,
                    color: Color(0xFF37474F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFCFD8DC), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _heroB,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'G',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Atelier Glossary',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        entry(
          'Material',
          'The physical surface widget. Owns elevation, shadow, shape and is '
              'where Ink features paint themselves.',
          _s2Deep,
        ),
        entry(
          'Card',
          'Pre-styled Material panel with sensible defaults. Comes in three '
              'flavors: default elevated, filled (tinted), and outlined.',
          _s1Deep,
        ),
        entry(
          'Ink',
          'A widget that paints decorations on the enclosing Material so '
              'splash features render correctly on top of imagery.',
          _s3Deep,
        ),
        entry(
          'InkWell / InkResponse',
          'Gesture detectors that schedule InteractiveInkFeatures. InkWell is '
              'a bounded InkResponse with rectangular highlight.',
          _s4Deep,
        ),
        entry(
          'InteractiveInkFeatureFactory',
          'A constructor for ink features. Built-in factories: '
              'InkSplash.splashFactory, InkRipple.splashFactory, '
              'NoSplash.splashFactory.',
          _s5Deep,
        ),
        entry(
          'splashColor / highlightColor',
          'Two-layer color contract: the splash blooms briefly; the highlight '
              'is the resting wash while the press is held.',
          _s6Deep,
        ),
        entry(
          'Elevation',
          'Logical Z-depth in dp. Controls shadow and surface tint on '
              'Material 3 themes. Canonical steps: 0, 1, 2, 4, 8, 12, 16, 24.',
          _s2Mid,
        ),
        entry(
          'ShapeBorder',
          'Outline of a Material surface. Rounded, beveled, stadium, and '
              'circle shapes are typical; clipBehavior controls ink clipping.',
          _s8Deep,
        ),
      ],
    ),
  );
}

// ============================================================================
// EPILOGUE
// ============================================================================

Widget _epilogue() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_heroC, _heroB, _heroA],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Epilogue',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'You have walked the full benches of the Material Surface & Ripple '
          'Atelier — from the three Cards of the entryway, past the elevation '
          'ladder, through the InkWell and InkResponse studios, into the '
          'splash factory workshop, and out via shape and comparison galleries.',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0x33000000),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Key takeaways:\n'
            '  • Card is a Material with opinionated defaults.\n'
            '  • Elevation is a ladder, not a slider — pick a step.\n'
            '  • InkWell binds gestures; InkResponse adds custom radius.\n'
            '  • splashFactory swaps the visual language wholesale.\n'
            '  • NoSplash is a first-class citizen — silence is a style.\n'
            '  • Always pair splashColor with highlightColor for two-tone feel.\n'
            '  • Custom shapes need Clip.antiAlias to keep ink in bounds.',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12.5,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Atelier closed for the night',
              style: TextStyle(
                color: Color(0xFFE1BEE7),
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x55FFFFFF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                'PASS',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  // Theme: "Material Surface & Ripple Atelier" — a curated visual workshop
  // exploring Card variants, Material elevation, ink overlays, and splash
  // factories. Every section is a bench; every demo is a static snapshot.
  //
  // Animation policy: because ink splashes are inherently interactive and we
  // cannot use AnimationController in this analyzer-free corpus, splashes are
  // simulated using RadialGradient overlays at a frozen progress. The widgets
  // InkWell / InkResponse / InkSplash / InkRipple / NoSplash are wired live
  // but never receive a real tap during build, so visual fidelity comes from
  // the gradient surrogates we paint underneath.

  // Provide a sample CardThemeData so MaterialApp can carry it.
  final cardTheme = CardThemeData(
    color: const Color(0xFFFFFFFF),
    shadowColor: const Color(0x44000000),
    surfaceTintColor: _s1Wash,
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    margin: const EdgeInsets.all(8.0),
    clipBehavior: Clip.antiAlias,
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      cardTheme: cardTheme,
      splashFactory: InkRipple.splashFactory,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heroHeader(),
              const SizedBox(height: 22.0),
              _conceptOverview(),
              const SizedBox(height: 22.0),
              _section1CardVariants(),
              const SizedBox(height: 22.0),
              _section2Elevation(),
              const SizedBox(height: 22.0),
              _section3InkWell(),
              const SizedBox(height: 22.0),
              _section4InkResponse(),
              const SizedBox(height: 22.0),
              _section5InkSplash(),
              const SizedBox(height: 22.0),
              _section6InkRipple(),
              const SizedBox(height: 22.0),
              _section7SplashFactories(),
              const SizedBox(height: 22.0),
              _section8CustomShape(),
              const SizedBox(height: 22.0),
              _section9ComparisonGrid(),
              const SizedBox(height: 22.0),
              _glossaryPanel(),
              const SizedBox(height: 22.0),
              _epilogue(),
              const SizedBox(height: 16.0),
              const Center(
                child: Text(
                  'Material Surface & Ripple Atelier  •  Deep Demo  •  d4rt corpus',
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 11.0,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    ),
  );
}
