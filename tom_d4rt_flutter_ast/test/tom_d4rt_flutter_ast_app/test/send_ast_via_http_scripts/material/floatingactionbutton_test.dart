// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// FloatingActionButton — Deep Visual Demo
// =============================================================================
// This script renders a long-form visual catalog of the Material
// FloatingActionButton widget for the D4rt analyzer-free Flutter interpreter.
//
// Sections demonstrated:
//   1.  Header / anatomy
//   2.  Size family (small / regular / large / extended)
//   3.  Shape variants
//   4.  Color variants
//   5.  Elevation showcase
//   6.  Disabled state pairing
//   7.  Extended FAB catalog
//   8.  Badge composition
//   9.  Scaffold placement mockup
//   10. Theme override
//   11. Edge cases (long children / extreme sizes)
//
// Every FAB declares a unique heroTag of the form '<section>-<index>' so the
// Hero animation system does not assert on duplicates when many FABs share a
// single Element tree.
// =============================================================================

dynamic build(BuildContext context) {
  return Container(
    color: const Color(0xFFF1F3F6),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPageTitle(),
          const SizedBox(height: 16.0),
          _buildSectionAnatomy(),
          const SizedBox(height: 32.0),
          _buildSectionSizeFamily(),
          const SizedBox(height: 32.0),
          _buildSectionShapeVariants(),
          const SizedBox(height: 32.0),
          _buildSectionColorVariants(),
          const SizedBox(height: 32.0),
          _buildSectionElevationShowcase(),
          const SizedBox(height: 32.0),
          _buildSectionDisabledState(),
          const SizedBox(height: 32.0),
          _buildSectionExtendedCatalog(),
          const SizedBox(height: 32.0),
          _buildSectionBadgeComposition(),
          const SizedBox(height: 32.0),
          _buildSectionScaffoldPlacement(),
          const SizedBox(height: 32.0),
          _buildSectionThemeOverride(),
          const SizedBox(height: 32.0),
          _buildSectionEdgeCases(),
          const SizedBox(height: 32.0),
          _buildFooter(),
        ],
      ),
    ),
  );
}

// =============================================================================
// SHARED HELPERS
// =============================================================================

Widget _buildPageTitle() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1E88E5), Color(0xFF42A5F5)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'FloatingActionButton — Visual Catalog',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A reference page covering every constructor, shape, color, '
          'elevation, and placement of the Material FAB widget.',
          style: TextStyle(color: Colors.white, fontSize: 13.0),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: const Color(0xFF263238),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 6.0),
      Text(
        description,
        style: const TextStyle(fontSize: 12.5, color: Color(0xFF455A64)),
      ),
      const SizedBox(height: 12.0),
    ],
  );
}

Widget _buildCard({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: child,
  );
}

Widget _buildCaption(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 11.0, color: Color(0xFF37474F)),
  );
}

Widget _buildFooter() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFB0BEC5)),
    ),
    child: const Text(
      'End of FloatingActionButton catalog. Each FAB above declares a unique '
      'heroTag so multiple FABs can coexist without Hero animation collisions.',
      style: TextStyle(fontSize: 11.0, color: Color(0xFF37474F)),
    ),
  );
}

// =============================================================================
// SECTION 1 — ANATOMY
// =============================================================================

Widget _buildSectionAnatomy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '1 — Anatomy',
        'A FloatingActionButton is built from four visual layers: the elevated '
            'circular Material surface, an inner child (icon or label), a ripple/'
            'splash overlay, and an animated drop shadow proportional to '
            'elevation.',
      ),
      _buildCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // The anatomical example FAB.
            FloatingActionButton(
              onPressed: () {},
              heroTag: 'anatomy-1',
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
              elevation: 8.0,
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 18.0),
            Expanded(child: _buildAnatomyLabels()),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'A regular FAB with elevation 8 — the standard Material elevation for '
        'resting state.',
      ),
    ],
  );
}

Widget _buildAnatomyLabels() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildAnatomyRow('child', 'The icon or extended label widget.'),
      _buildAnatomyRow('backgroundColor', 'Color of the circular surface.'),
      _buildAnatomyRow('foregroundColor', 'Color of the child / icon.'),
      _buildAnatomyRow('elevation', 'Drop shadow distance (0.0 – 24.0).'),
      _buildAnatomyRow('splashColor', 'Ripple overlay during tap.'),
      _buildAnatomyRow('shape', 'Outer geometry (circle / stadium / rect).'),
      _buildAnatomyRow('heroTag', 'Unique identifier for Hero animations.'),
    ],
  );
}

Widget _buildAnatomyRow(String name, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 110.0,
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFF37474F)),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — SIZE FAMILY
// =============================================================================

Widget _buildSectionSizeFamily() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '2 — Size family',
        'The FAB ships in four canonical sizes: small (40dp), regular (56dp), '
            'large (96dp), and extended (pill-shaped, variable width).',
      ),
      _buildCard(
        child: Wrap(
          spacing: 24.0,
          runSpacing: 18.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            _buildSizeColumn(
              'small',
              FloatingActionButton.small(
                onPressed: () {},
                heroTag: 'size-1',
                child: const Icon(Icons.add),
              ),
              '40 x 40 dp',
            ),
            _buildSizeColumn(
              'regular',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'size-2',
                child: const Icon(Icons.add),
              ),
              '56 x 56 dp (default)',
            ),
            _buildSizeColumn(
              'large',
              FloatingActionButton.large(
                onPressed: () {},
                heroTag: 'size-3',
                child: const Icon(Icons.add),
              ),
              '96 x 96 dp',
            ),
            _buildSizeColumn(
              'extended',
              FloatingActionButton.extended(
                onPressed: () {},
                heroTag: 'size-4',
                icon: const Icon(Icons.add),
                label: const Text('Add Item'),
              ),
              'pill, variable width',
            ),
            _buildSizeColumn(
              'mini',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'size-5',
                mini: true,
                child: const Icon(Icons.add),
              ),
              'mini:true (legacy, ~40dp)',
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'Note: `mini: true` predates `FloatingActionButton.small` and produces '
        'a similar but slightly different visual footprint.',
      ),
    ],
  );
}

Widget _buildSizeColumn(String label, Widget fab, String dimensions) {
  return SizedBox(
    width: 130.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 100.0, child: Center(child: fab)),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2.0),
        Text(
          dimensions,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10.0, color: Color(0xFF607D8B)),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3 — SHAPE VARIANTS
// =============================================================================

Widget _buildSectionShapeVariants() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '3 — Shape variants',
        'The `shape` argument accepts any ShapeBorder. The four classic options '
            'are CircleBorder (default), RoundedRectangleBorder (square / soft), '
            'StadiumBorder (pill), and a tightly-rounded RoundedRectangleBorder.',
      ),
      _buildCard(
        child: Wrap(
          spacing: 22.0,
          runSpacing: 18.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            _buildShapeColumn(
              'circle (default)',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'shape-1',
                shape: const CircleBorder(),
                backgroundColor: const Color(0xFF26A69A),
                foregroundColor: Colors.white,
                child: const Icon(Icons.circle_outlined),
              ),
              'CircleBorder()',
            ),
            _buildShapeColumn(
              'square',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'shape-2',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                backgroundColor: const Color(0xFFEF5350),
                foregroundColor: Colors.white,
                child: const Icon(Icons.crop_square),
              ),
              'RoundedRectangleBorder(r=6)',
            ),
            _buildShapeColumn(
              'stadium',
              FloatingActionButton.extended(
                onPressed: () {},
                heroTag: 'shape-3',
                shape: const StadiumBorder(),
                backgroundColor: const Color(0xFFAB47BC),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.bolt),
                label: const Text('Stadium'),
              ),
              'StadiumBorder()',
            ),
            _buildShapeColumn(
              'soft rounded',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'shape-4',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: const Color(0xFFFFA726),
                foregroundColor: Colors.white,
                child: const Icon(Icons.bubble_chart),
              ),
              'RoundedRectangleBorder(r=20)',
            ),
            _buildShapeColumn(
              'beveled',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'shape-5',
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                backgroundColor: const Color(0xFF7E57C2),
                foregroundColor: Colors.white,
                child: const Icon(Icons.diamond),
              ),
              'BeveledRectangleBorder',
            ),
            _buildShapeColumn(
              'outlined',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'shape-6',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: const BorderSide(color: Color(0xFF1B5E20), width: 2.0),
                ),
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1B5E20),
                child: const Icon(Icons.eco),
              ),
              'outlined rounded',
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'Custom shapes change the silhouette but preserve elevation and ripple '
        'behavior — Flutter clips ink reactions to the chosen border path.',
      ),
    ],
  );
}

Widget _buildShapeColumn(String label, Widget fab, String code) {
  return SizedBox(
    width: 160.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 80.0, child: Center(child: fab)),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2.0),
        Text(
          code,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 9.5,
            color: Color(0xFF455A64),
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4 — COLOR VARIANTS
// =============================================================================

Widget _buildSectionColorVariants() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '4 — Color variants',
        'Background and foreground colors can be paired arbitrarily, but Material '
            'guidelines suggest using your primary, secondary, tertiary, and accent '
            'palette tokens to integrate with the rest of the surface.',
      ),
      _buildCard(
        child: Wrap(
          spacing: 18.0,
          runSpacing: 18.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            _buildColorColumn(
              'primary',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'color-1',
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
              '#1976D2 / white',
            ),
            _buildColorColumn(
              'secondary',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'color-2',
                backgroundColor: const Color(0xFFFFA000),
                foregroundColor: Colors.white,
                child: const Icon(Icons.star),
              ),
              '#FFA000 / white',
            ),
            _buildColorColumn(
              'tertiary',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'color-3',
                backgroundColor: const Color(0xFF8E24AA),
                foregroundColor: Colors.white,
                child: const Icon(Icons.favorite),
              ),
              '#8E24AA / white',
            ),
            _buildColorColumn(
              'accent',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'color-4',
                backgroundColor: const Color(0xFF00ACC1),
                foregroundColor: const Color(0xFF004D40),
                child: const Icon(Icons.flash_on),
              ),
              '#00ACC1 / #004D40',
            ),
            _buildColorColumn(
              'success',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'color-5',
                backgroundColor: const Color(0xFF43A047),
                foregroundColor: Colors.white,
                child: const Icon(Icons.check),
              ),
              '#43A047 / white',
            ),
            _buildColorColumn(
              'danger',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'color-6',
                backgroundColor: const Color(0xFFD32F2F),
                foregroundColor: Colors.white,
                child: const Icon(Icons.delete_forever),
              ),
              '#D32F2F / white',
            ),
            _buildColorColumn(
              'splash demo',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'color-7',
                backgroundColor: const Color(0xFF455A64),
                foregroundColor: Colors.white,
                splashColor: const Color(0xFFFFEB3B),
                child: const Icon(Icons.water_drop),
              ),
              'splashColor: yellow',
            ),
            _buildColorColumn(
              'inverse',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'color-8',
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF263238),
                child: const Icon(Icons.dark_mode),
              ),
              'white / #263238',
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'splashColor only becomes visible during a tap — it tints the ripple '
        'rather than the resting surface.',
      ),
    ],
  );
}

Widget _buildColorColumn(String label, Widget fab, String tokens) {
  return SizedBox(
    width: 120.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 70.0, child: Center(child: fab)),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2.0),
        Text(
          tokens,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 9.5,
            color: Color(0xFF455A64),
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5 — ELEVATION SHOWCASE
// =============================================================================

Widget _buildSectionElevationShowcase() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '5 — Elevation showcase',
        'Elevation controls the drop shadow. Resting elevation is typically 6, '
            'with 12 used during press / drag. Compare these four FABs side by side '
            'with elevations 0, 4, 8, and 16.',
      ),
      _buildCard(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildElevationColumn(0.0, 'elevation-1'),
                _buildElevationColumn(4.0, 'elevation-2'),
                _buildElevationColumn(8.0, 'elevation-3'),
                _buildElevationColumn(16.0, 'elevation-4'),
              ],
            ),
            const SizedBox(height: 18.0),
            const Divider(height: 1.0),
            const SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildElevationPropertyDemo(
                  'highlightElevation',
                  FloatingActionButton(
                    onPressed: () {},
                    heroTag: 'elevation-5',
                    elevation: 4.0,
                    highlightElevation: 18.0,
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.touch_app),
                  ),
                  'pressed shadow',
                ),
                _buildElevationPropertyDemo(
                  'focusElevation',
                  FloatingActionButton(
                    onPressed: () {},
                    heroTag: 'elevation-6',
                    elevation: 4.0,
                    focusElevation: 12.0,
                    backgroundColor: const Color(0xFF6A1B9A),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.center_focus_strong),
                  ),
                  'keyboard focus',
                ),
                _buildElevationPropertyDemo(
                  'hoverElevation',
                  FloatingActionButton(
                    onPressed: () {},
                    heroTag: 'elevation-7',
                    elevation: 4.0,
                    hoverElevation: 10.0,
                    backgroundColor: const Color(0xFFE65100),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.mouse),
                  ),
                  'pointer hover',
                ),
                _buildElevationPropertyDemo(
                  'disabledElevation',
                  FloatingActionButton(
                    onPressed: null,
                    heroTag: 'elevation-8',
                    elevation: 4.0,
                    disabledElevation: 0.0,
                    backgroundColor: const Color(0xFF9E9E9E),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.block),
                  ),
                  'flat when disabled',
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'Each elevation property responds to a specific interaction state. '
        'Tweaking them lets you express depth changes without animating opacity.',
      ),
    ],
  );
}

Widget _buildElevationColumn(double elevation, String heroTag) {
  return SizedBox(
    width: 80.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 70.0,
          child: Center(
            child: FloatingActionButton(
              onPressed: () {},
              heroTag: heroTag,
              elevation: elevation,
              backgroundColor: const Color(0xFF37474F),
              foregroundColor: Colors.white,
              child: const Icon(Icons.layers),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'e=$elevation',
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _buildElevationPropertyDemo(String prop, Widget fab, String note) {
  return SizedBox(
    width: 110.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 60.0, child: Center(child: fab)),
        const SizedBox(height: 4.0),
        Text(
          prop,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          note,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 9.5, color: Color(0xFF607D8B)),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6 — DISABLED STATE
// =============================================================================

Widget _buildSectionDisabledState() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '6 — Disabled state',
        'Passing `onPressed: null` disables the FAB. Visually it desaturates and '
            'drops its shadow when paired with `disabledElevation: 0`. Compare an '
            'enabled FAB with its disabled twin.',
      ),
      _buildCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildDisabledPair(
              'regular',
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'disabled-1a',
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: null,
                heroTag: 'disabled-1b',
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                disabledElevation: 0.0,
                child: const Icon(Icons.add),
              ),
            ),
            _buildDisabledPair(
              'extended',
              FloatingActionButton.extended(
                onPressed: () {},
                heroTag: 'disabled-2a',
                backgroundColor: const Color(0xFF6A1B9A),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.send),
                label: const Text('Send'),
              ),
              FloatingActionButton.extended(
                onPressed: null,
                heroTag: 'disabled-2b',
                backgroundColor: const Color(0xFF6A1B9A),
                foregroundColor: Colors.white,
                disabledElevation: 0.0,
                icon: const Icon(Icons.send),
                label: const Text('Send'),
              ),
            ),
            _buildDisabledPair(
              'large',
              FloatingActionButton.large(
                onPressed: () {},
                heroTag: 'disabled-3a',
                backgroundColor: const Color(0xFF00897B),
                foregroundColor: Colors.white,
                child: const Icon(Icons.cloud_upload),
              ),
              FloatingActionButton.large(
                onPressed: null,
                heroTag: 'disabled-3b',
                backgroundColor: const Color(0xFF00897B),
                foregroundColor: Colors.white,
                disabledElevation: 0.0,
                child: const Icon(Icons.cloud_upload),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'Best practice: even though Flutter visually mutes the FAB, also '
        'lower `disabledElevation` to 0 so the shadow does not imply '
        'interactivity.',
      ),
    ],
  );
}

Widget _buildDisabledPair(String label, Widget enabled, Widget disabled) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              enabled,
              const SizedBox(height: 4.0),
              const Text(
                'enabled',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF388E3C)),
              ),
            ],
          ),
          const SizedBox(width: 14.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Opacity(opacity: 0.55, child: disabled),
              const SizedBox(height: 4.0),
              const Text(
                'disabled',
                style: TextStyle(fontSize: 10.0, color: Color(0xFFD84315)),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 6.0),
      Text(
        label,
        style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

// =============================================================================
// SECTION 7 — EXTENDED FAB CATALOG
// =============================================================================

Widget _buildSectionExtendedCatalog() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '7 — Extended FAB catalog',
        'Extended FABs combine an icon and a label for cases where a single '
            'glyph would not communicate the action. They are wider and shorter '
            'than the regular FAB.',
      ),
      _buildCard(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-1',
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.add_task),
                  label: const Text('Add Task'),
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-2',
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.edit_note),
                  label: const Text('Compose'),
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-3',
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.description),
                  label: const Text('New Doc'),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-4',
                  backgroundColor: const Color(0xFFEF6C00),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filter'),
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-5',
                  backgroundColor: const Color(0xFFC2185B),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-6',
                  backgroundColor: const Color(0xFF455A64),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.settings),
                  label: const Text('Settings'),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            const Divider(height: 1.0),
            const SizedBox(height: 14.0),
            // Demonstrate the "label only" extended fab.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-7',
                  backgroundColor: const Color(0xFF00838F),
                  foregroundColor: Colors.white,
                  label: const Text('LABEL ONLY'),
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-8',
                  backgroundColor: const Color(0xFF1B5E20),
                  foregroundColor: Colors.white,
                  isExtended: true,
                  icon: const Icon(Icons.check),
                  label: const Text('CONFIRM'),
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'extended-9',
                  backgroundColor: const Color(0xFFAD1457),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.error_outline),
                  label: const Text('Report Bug'),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'The label can be any widget — typically a Text, but you may compose a '
        'Row of Text + indicator for more elaborate prompts.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 8 — BADGE COMPOSITION
// =============================================================================

Widget _buildSectionBadgeComposition() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '8 — Badge composition',
        'FABs can carry small badges via a Stack. Place the FAB at the bottom of '
            'the Stack, then a Positioned numeric Container at the top-right.',
      ),
      _buildCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildBadgedFab(
              'mail-1',
              const Color(0xFF1565C0),
              Icons.mail,
              '3',
              Colors.red,
            ),
            _buildBadgedFab(
              'mail-2',
              const Color(0xFF6A1B9A),
              Icons.notifications,
              '12',
              Colors.orange,
            ),
            _buildBadgedFab(
              'mail-3',
              const Color(0xFF2E7D32),
              Icons.chat,
              '99+',
              Colors.deepOrange,
            ),
            _buildBadgedFab(
              'mail-4',
              const Color(0xFFD32F2F),
              Icons.shopping_cart,
              '7',
              Colors.amber,
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'The badge is purely decorative — it does not handle taps. The whole '
        'Stack falls inside the FAB`s tap target.',
      ),
    ],
  );
}

Widget _buildBadgedFab(
  String heroTag,
  Color background,
  IconData icon,
  String badgeText,
  Color badgeColor,
) {
  return SizedBox(
    width: 80.0,
    height: 80.0,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () {},
          heroTag: heroTag,
          backgroundColor: background,
          foregroundColor: Colors.white,
          child: Icon(icon),
        ),
        Positioned(
          top: 2.0,
          right: 2.0,
          child: Container(
            constraints: const BoxConstraints(minWidth: 22.0, minHeight: 22.0),
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(11.0),
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: Text(
              badgeText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9 — SCAFFOLD PLACEMENT
// =============================================================================

Widget _buildSectionScaffoldPlacement() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '9 — Scaffold placement',
        'FloatingActionButtonLocation has more than 14 named anchors. The four '
            'shown below are the most common: endFloat (default), centerDocked, '
            'startFloat, and endTop. The mock Scaffold below is purely geometric.',
      ),
      _buildCard(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            _buildMockScaffold(
              'endFloat',
              fabAlignment: Alignment.bottomRight,
              docked: false,
              heroTag: 'placement-1',
              color: const Color(0xFF1976D2),
            ),
            _buildMockScaffold(
              'centerDocked',
              fabAlignment: Alignment.bottomCenter,
              docked: true,
              heroTag: 'placement-2',
              color: const Color(0xFFEF6C00),
            ),
            _buildMockScaffold(
              'startFloat',
              fabAlignment: Alignment.bottomLeft,
              docked: false,
              heroTag: 'placement-3',
              color: const Color(0xFF2E7D32),
            ),
            _buildMockScaffold(
              'endTop',
              fabAlignment: Alignment.topRight,
              docked: false,
              heroTag: 'placement-4',
              color: const Color(0xFFAD1457),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'In a real Scaffold, the FAB is passed via the `floatingActionButton` '
        'parameter and positioned via `floatingActionButtonLocation`.',
      ),
    ],
  );
}

Widget _buildMockScaffold(
  String label, {
  required Alignment fabAlignment,
  required bool docked,
  required String heroTag,
  required Color color,
}) {
  return SizedBox(
    width: 220.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 220.0,
          height: 160.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFB0BEC5)),
          ),
          child: Stack(
            children: <Widget>[
              // App bar mock.
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                child: Container(
                  height: 30.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF263238),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'AppBar',
                    style: TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
                ),
              ),
              // Body mock content.
              const Positioned(
                left: 10.0,
                right: 10.0,
                top: 40.0,
                child: Text(
                  'Body content lorem ipsum',
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF607D8B)),
                ),
              ),
              // Bottom app bar mock.
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: 26.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCFD8DC),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    // notch indicator when docked
                    border: docked
                        ? const Border(
                            top: BorderSide(
                              color: Color(0xFF90A4AE),
                              width: 1.0,
                            ),
                          )
                        : null,
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: const Text(
                    'BottomBar',
                    style: TextStyle(fontSize: 9.5, color: Color(0xFF37474F)),
                  ),
                ),
              ),
              // FAB at chosen position.
              Align(
                alignment: fabAlignment,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: fabAlignment == Alignment.bottomLeft ? 12.0 : 0.0,
                    right: (fabAlignment == Alignment.bottomRight ||
                            fabAlignment == Alignment.topRight)
                        ? 12.0
                        : 0.0,
                    top: fabAlignment == Alignment.topRight ? 16.0 : 0.0,
                    bottom: docked
                        ? 12.0
                        : (fabAlignment == Alignment.bottomLeft ||
                                  fabAlignment == Alignment.bottomRight)
                              ? 30.0
                              : 0.0,
                  ),
                  child: FloatingActionButton.small(
                    onPressed: () {},
                    heroTag: heroTag,
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    elevation: 6.0,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'FloatingActionButtonLocation.$label',
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 — THEME OVERRIDE
// =============================================================================

Widget _buildSectionThemeOverride() {
  // Build a custom theme to cascade onto child FABs.
  final ThemeData customTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF263238),
      foregroundColor: Color(0xFFFFEB3B),
      elevation: 10.0,
      highlightElevation: 14.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
      ),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '10 — Theme override',
        'Wrapping FABs in a Theme widget with a custom floatingActionButtonTheme '
            'lets you cascade defaults — background, foreground, elevation, shape '
            '— to all FABs in the subtree without repeating arguments.',
      ),
      _buildCard(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {},
                      heroTag: 'theme-default-1',
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'default theme',
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FloatingActionButton.extended(
                      onPressed: () {},
                      heroTag: 'theme-default-2',
                      icon: const Icon(Icons.send),
                      label: const Text('Send'),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'default extended',
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 10.0),
            const Text(
              'inside custom Theme:',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
            const SizedBox(height: 10.0),
            Theme(
              data: customTheme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {},
                        heroTag: 'theme-custom-1',
                        child: const Icon(Icons.bolt),
                      ),
                      const SizedBox(height: 6.0),
                      const Text(
                        'themed regular',
                        style: TextStyle(fontSize: 11.0),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'theme-custom-2',
                        icon: const Icon(Icons.star),
                        label: const Text('Boost'),
                      ),
                      const SizedBox(height: 6.0),
                      const Text(
                        'themed extended',
                        style: TextStyle(fontSize: 11.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'The two themed FABs inherit dark background, yellow foreground, '
        'rounded-rect shape, and elevated drop shadow from a single '
        'FloatingActionButtonThemeData declaration.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 11 — EDGE CASES
// =============================================================================

Widget _buildSectionEdgeCases() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader(
        '11 — Edge cases',
        'When the child is more than a single icon, the FAB grows to fit. '
            'Unusually small mini FABs and unusually wide extended FABs both work, '
            'though they stretch the Material guidelines.',
      ),
      _buildCard(
        child: Column(
          children: <Widget>[
            // Edge 1: composite child (avatar + text).
            // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #45, P3):
            // The original demo placed `Row(mainAxisSize.min,
            // [SizedBox, CircleAvatar(r:12), SizedBox, Text('Profile'
            // bold), SizedBox])` directly as the `child` of a regular
            // `FloatingActionButton`. The inner Row has a natural width
            // of ~100 px, but a regular `FloatingActionButton` hard-codes
            // `BoxConstraints.tightFor(width: 56, height: 56)`, forcing
            // the child into 56 px and producing a
            // "RenderFlex overflowed by 41 pixels on the right"
            // assertion every layout pass. The widget actually designed
            // for "avatar + inline label" is
            // `FloatingActionButton.extended`, which sizes its pill to
            // the natural width of `icon + label`. Switched the demo to
            // `FloatingActionButton.extended` so the visual intent
            // (avatar inside a stadium-shaped FAB next to a bold label)
            // is preserved without overflow; the surrounding caption
            // already describes the composite-child idea.
            Row(
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'edge-1',
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  icon: const CircleAvatar(
                    radius: 12.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF1565C0),
                      size: 16.0,
                    ),
                  ),
                  label: const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                const Expanded(
                  child: Text(
                    'Composite child: an avatar plus inline label, '
                    'rendered via FloatingActionButton.extended so the pill '
                    'naturally sizes to its icon + label content.',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF37474F)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 16.0),
            // Edge 2: unusually small mini.
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  heroTag: 'edge-2',
                  mini: true,
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.close, size: 14.0),
                ),
                const SizedBox(width: 16.0),
                const Expanded(
                  child: Text(
                    'Unusually small mini: mini:true is the smallest the FAB '
                    'goes natively. Pair with a small Icon size to keep the '
                    'glyph visually balanced.',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF37474F)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 16.0),
            // Edge 3: unusually wide extended.
            FloatingActionButton.extended(
              onPressed: () {},
              heroTag: 'edge-3',
              backgroundColor: const Color(0xFFAD1457),
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              icon: const Icon(Icons.rocket_launch),
              label: const Text(
                'Initialize the deep-space probe with full systems calibration',
              ),
            ),
            const SizedBox(height: 6.0),
            const Text(
              'Unusually wide extended: an overlong label balloons the pill, '
              'illustrating that the extended variant accepts essentially any '
              'inline content but should be kept short for usability.',
              style: TextStyle(fontSize: 11.5, color: Color(0xFF37474F)),
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 16.0),
            // Edge 4: very low elevation + flat color.
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  heroTag: 'edge-4',
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  backgroundColor: const Color(0xFFFFEB3B),
                  foregroundColor: const Color(0xFF263238),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color(0xFF263238),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(Icons.lightbulb),
                ),
                const SizedBox(width: 16.0),
                const Expanded(
                  child: Text(
                    'Flat FAB: elevation 0 + outlined border yields a non-'
                    'elevated button that visually behaves more like an icon '
                    'chip. Useful inside dense surfaces where a shadow would '
                    'compete with surrounding cards.',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF37474F)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 16.0),
            // Edge 5: clipBehavior + custom shape.
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  heroTag: 'edge-5',
                  clipBehavior: Clip.antiAlias,
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  child: Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xFF80DEEA),
                          Color(0xFF00838F),
                        ],
                      ),
                    ),
                    child: const Icon(Icons.waves, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16.0),
                const Expanded(
                  child: Text(
                    'clipBehavior: Clip.antiAlias allows a child Container with '
                    'its own gradient to be clipped to the FAB`s outer shape. '
                    'The ripple still respects the clipped border path.',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF37474F)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 16.0),
            // Edge 6: large extended with custom font.
            FloatingActionButton.large(
              onPressed: () {},
              heroTag: 'edge-6',
              backgroundColor: const Color(0xFF1B5E20),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.cloud_done, size: 28.0),
                  SizedBox(height: 2.0),
                  Text(
                    'SYNCED',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6.0),
            const Text(
              'Multi-line child: a large FAB carrying an Icon plus a tiny status '
              'label stacked vertically — useful for status-emitting actions in '
              'sync-heavy apps.',
              style: TextStyle(fontSize: 11.5, color: Color(0xFF37474F)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _buildCaption(
        'Edge cases stretch the visual contract of the FAB but stay within the '
        'parameters of the Material widget — no custom painters needed.',
      ),
    ],
  );
}
