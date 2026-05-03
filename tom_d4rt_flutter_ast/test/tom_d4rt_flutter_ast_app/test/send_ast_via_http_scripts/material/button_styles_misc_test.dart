// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of ButtonStyle / styleFrom / WidgetStateProperty.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Visual primitives
// ---------------------------------------------------------------------------

Widget _buildSectionHeader({
  required String title,
  required String subtitle,
  required IconData icon,
  required List<Color> gradient,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(40),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withAlpha(220),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildExplanation(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        height: 1.45,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

Widget _buildLabel(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
        color: color,
      ),
    ),
  );
}

Widget _buildChip({
  required String label,
  required IconData icon,
  required List<Color> gradient,
  required double elevation,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: gradient),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: gradient.last.withAlpha(120),
          blurRadius: 6 + elevation,
          offset: Offset(0, 2 + elevation / 2),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionCard({required List<Widget> children}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(28),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...children,
        const SizedBox(height: 16),
      ],
    ),
  );
}

Widget _buildContentPadding({required Widget child}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
    child: child,
  );
}

Widget _buildBadge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withAlpha(40),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(120)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.5,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Intro card
// ---------------------------------------------------------------------------

Widget _buildIntroCard() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'ButtonStyle Composition',
        subtitle: 'A comprehensive tour of Material 3 button styling',
        icon: Icons.palette_outlined,
        gradient: const [Color(0xFF673AB7), Color(0xFF3F51B5)],
      ),
      _buildExplanation(
        'ButtonStyle is the central object that controls every visual aspect '
        'of a Material button. It is composed almost entirely of '
        'WidgetStateProperty<T> fields, which means the value used for any '
        'given attribute can change depending on the current set of widget '
        'states (hovered, pressed, focused, disabled, selected, and more).',
      ),
      _buildExplanation(
        'There are two common ways to build a ButtonStyle. The raw '
        'ButtonStyle(...) constructor lets you supply each property '
        'explicitly, typically using WidgetStatePropertyAll for static '
        'values or WidgetStateProperty.resolveWith for state dependent '
        'values. The styleFrom(...) shortcut on each button class accepts '
        'plain values and wraps them in the right WidgetStateProperty for '
        'you, which is convenient for the common case.',
      ),
      _buildExplanation(
        'This demo walks through nine distinct facets of ButtonStyle '
        'including shape, padding, elevation, side, color permutations, '
        'state resolution, mouse cursors, visual density and the styleFrom '
        'shortcut. Each section explains when the technique is appropriate '
        'and shows multiple visual variants side by side.',
      ),
      _buildContentPadding(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildBadge('SHAPE', Colors.deepPurple),
            _buildBadge('PADDING', Colors.indigo),
            _buildBadge('ELEVATION', Colors.blue),
            _buildBadge('SIDE', Colors.teal),
            _buildBadge('COLORS', Colors.green),
            _buildBadge('STATES', Colors.orange),
            _buildBadge('CURSOR', Colors.deepOrange),
            _buildBadge('DENSITY', Colors.red),
            _buildBadge('STYLEFROM', Colors.pink),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Shape showcase
// ---------------------------------------------------------------------------

Widget _buildShapeShowcase() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'Shape',
        subtitle: 'RoundedRectangle, Stadium, Circle, Beveled, Continuous',
        icon: Icons.crop_square,
        gradient: const [Color(0xFF1976D2), Color(0xFF26C6DA)],
      ),
      _buildExplanation(
        'The shape property determines the outline used both for hit '
        'testing and the painted background. Material 3 ships several '
        'built in shapes that cover the most common visual styles: '
        'rectangles with sharp or rounded corners, pill shaped stadiums, '
        'circular icon buttons, beveled corners and the more organic '
        'continuous corner border.',
      ),
      _buildExplanation(
        'Use a RoundedRectangleBorder when you want the conventional '
        'rectangular button with a configurable corner radius. Reach for '
        'StadiumBorder when the button should feel pill shaped and '
        'CircleBorder when it should feel like an action token. The '
        'BeveledRectangleBorder gives a hard cut technical look while '
        'ContinuousRectangleBorder smooths the curvature for a soft, '
        'modern aesthetic.',
      ),
      _buildExplanation(
        'Picking the right shape is mostly about hierarchy and tone. '
        'Stadium and circle borders read as primary calls to action, '
        'while RoundedRectangle works well for grids of equally weighted '
        'options. Beveled and continuous borders are excellent accents '
        'when you want a single button to break out of a uniform layout.',
      ),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              child: const Text('Radius 4'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: const Text('Radius 12'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
              ),
              child: const Text('Radius 24'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Stadium'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: const Icon(Icons.favorite),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text('Beveled'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 14,
                ),
              ),
              child: const Text('Continuous'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
              child: const Text('Sharp'),
            ),
          ],
        ),
      ),
      _buildContentPadding(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildChip(
              label: 'RoundedRectangleBorder',
              icon: Icons.crop_din,
              gradient: const [Color(0xFF1976D2), Color(0xFF42A5F5)],
              elevation: 2,
            ),
            _buildChip(
              label: 'StadiumBorder',
              icon: Icons.stadium_outlined,
              gradient: const [Color(0xFF00838F), Color(0xFF26C6DA)],
              elevation: 3,
            ),
            _buildChip(
              label: 'CircleBorder',
              icon: Icons.circle_outlined,
              gradient: const [Color(0xFF512DA8), Color(0xFF7E57C2)],
              elevation: 4,
            ),
            _buildChip(
              label: 'BeveledRectangleBorder',
              icon: Icons.diamond_outlined,
              gradient: const [Color(0xFFAD1457), Color(0xFFEC407A)],
              elevation: 5,
            ),
            _buildChip(
              label: 'ContinuousRectangleBorder',
              icon: Icons.waves,
              gradient: const [Color(0xFF2E7D32), Color(0xFF66BB6A)],
              elevation: 6,
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Elevation showcase
// ---------------------------------------------------------------------------

Widget _buildElevationShowcase() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'Elevation',
        subtitle: 'Shadow depth from flat surfaces to floating tokens',
        icon: Icons.layers_outlined,
        gradient: const [Color(0xFF00897B), Color(0xFF26A69A)],
      ),
      _buildExplanation(
        'Elevation controls the size and softness of the shadow rendered '
        'underneath the button. In Material 3 the shadow is also colored '
        'by the surface tint, which couples elevation to color. Use higher '
        'elevation to push a button forward visually, and zero elevation '
        'when the button should sit flush with its container.',
      ),
      _buildExplanation(
        'Common elevation values are 0, 1, 2, 4, 8 and 16. These map to '
        'standard Material elevation tokens and provide enough range for '
        'most layouts. Resist using arbitrary values; the standard tokens '
        'help maintain a consistent depth language across an application.',
      ),
      _buildExplanation(
        'Elevation can also be made stateful through WidgetStateProperty. '
        'A common pattern is to lift the button on hover and press it '
        'down to a lower elevation when active, communicating affordance '
        'without requiring text labels.',
      ),
      _buildLabel('ELEVATION TOKENS', Colors.teal.shade700),
      _buildContentPadding(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 0),
              child: const Text('elev 0'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 1),
              child: const Text('elev 1'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 2),
              child: const Text('elev 2'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 4),
              child: const Text('elev 4'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 8),
              child: const Text('elev 8'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 16),
              child: const Text('elev 16'),
            ),
          ],
        ),
      ),
      _buildLabel('ELEVATION VIA RAW BUTTONSTYLE', Colors.teal.shade700),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(0),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Color(0xFFB2DFDB),
                ),
              ),
              child: const Text('flat'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(3),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Color(0xFF4DB6AC),
                ),
                foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
              ),
              child: const Text('mid'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(12),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Color(0xFF00695C),
                ),
                foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
              ),
              child: const Text('high'),
            ),
          ],
        ),
      ),
      _buildContentPadding(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildChip(
              label: 'level 0',
              icon: Icons.flatware,
              gradient: const [Color(0xFFB2DFDB), Color(0xFF80CBC4)],
              elevation: 0,
            ),
            _buildChip(
              label: 'level 1',
              icon: Icons.layers,
              gradient: const [Color(0xFF80CBC4), Color(0xFF4DB6AC)],
              elevation: 1,
            ),
            _buildChip(
              label: 'level 2',
              icon: Icons.layers,
              gradient: const [Color(0xFF4DB6AC), Color(0xFF26A69A)],
              elevation: 2,
            ),
            _buildChip(
              label: 'level 4',
              icon: Icons.layers,
              gradient: const [Color(0xFF26A69A), Color(0xFF009688)],
              elevation: 4,
            ),
            _buildChip(
              label: 'level 8',
              icon: Icons.layers,
              gradient: const [Color(0xFF009688), Color(0xFF00897B)],
              elevation: 8,
            ),
            _buildChip(
              label: 'level 16',
              icon: Icons.layers,
              gradient: const [Color(0xFF00897B), Color(0xFF00695C)],
              elevation: 12,
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Padding showcase
// ---------------------------------------------------------------------------

Widget _buildPaddingShowcase() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'Padding',
        subtitle: 'EdgeInsets.all, .symmetric, .only and .fromLTRB',
        icon: Icons.unfold_more_outlined,
        gradient: const [Color(0xFFEF6C00), Color(0xFFFFB300)],
      ),
      _buildExplanation(
        'The padding property of ButtonStyle determines how much space '
        'sits between the buttons content and its outer edge. Generous '
        'padding makes a button feel inviting and easy to hit, while '
        'tight padding is appropriate for dense toolbars and inline '
        'actions.',
      ),
      _buildExplanation(
        'EdgeInsets exposes four constructors that cover almost every '
        'real layout. Use EdgeInsets.all for symmetric padding, '
        'EdgeInsets.symmetric to balance horizontal and vertical, '
        'EdgeInsets.only for asymmetric padding such as a left aligned '
        'icon, and EdgeInsets.fromLTRB when each edge needs an '
        'independent value.',
      ),
      _buildExplanation(
        'Padding interacts with tapTargetSize. Even when padding is '
        'visually small, Material may expand the touch region to meet '
        'the recommended forty eight pixel minimum. Setting '
        'tapTargetSize to MaterialTapTargetSize.shrinkWrap removes that '
        'expansion when you are sure the button has another way to be '
        'reached comfortably.',
      ),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
              ),
              child: const Text('all 8'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('all 16'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(24),
              ),
              child: const Text('all 24'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 8,
                ),
              ),
              child: const Text('h 32 / v 8'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
              ),
              child: const Text('tall'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 12,
                  top: 10,
                  bottom: 10,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back, size: 16),
                  SizedBox(width: 6),
                  Text('Back'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 24,
                  top: 10,
                  bottom: 10,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Next'),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
              ),
              child: const Text('LTRB 28/14'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('compact'),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Side and Border
// ---------------------------------------------------------------------------

Widget _buildSideAndBorderShowcase() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'Side and Border',
        subtitle: 'BorderSide width, color and style variants',
        icon: Icons.border_style,
        gradient: const [Color(0xFF00695C), Color(0xFF26A69A)],
      ),
      _buildExplanation(
        'The side property paints a stroke around the button using a '
        'BorderSide. BorderSide accepts a color, a width and a style. '
        'BorderStyle.solid renders a continuous line, while '
        'BorderStyle.none disables the stroke even when one was inherited '
        'from a theme.',
      ),
      _buildExplanation(
        'Strokes are particularly important for OutlinedButton, where the '
        'side is the primary visual indicator of affordance. Adjusting '
        'the width and color of the side communicates emphasis: a thicker '
        'and more saturated stroke reads as primary, while a thinner '
        'desaturated stroke reads as secondary.',
      ),
      _buildExplanation(
        'When you need different strokes per state, drop down to a raw '
        'ButtonStyle with WidgetStateProperty.resolveWith. This lets you '
        'thicken or recolor the border on hover, focus or selection '
        'without rebuilding the widget tree.',
      ),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.indigo,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Text('width 1'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.indigo,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Text('width 2'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.indigo,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Text('width 3'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.indigo,
                  width: 4,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Text('width 4'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Colors.green.shade700,
                  width: 2,
                ),
                shape: const StadiumBorder(),
              ),
              child: const Text('green stadium'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Colors.deepOrange.shade400,
                  width: 2,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              child: const Text('orange'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.transparent,
                  width: 0,
                  style: BorderStyle.none,
                ),
                backgroundColor: Colors.indigo.shade50,
              ),
              child: const Text('no stroke'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    );
                  }
                  if (states.contains(WidgetState.pressed)) {
                    return const BorderSide(
                      color: Colors.deepPurple,
                      width: 4,
                    );
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return const BorderSide(
                      color: Colors.deepPurple,
                      width: 3,
                    );
                  }
                  return const BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  );
                }),
              ),
              child: const Text('stateful side'),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: Color permutations
// ---------------------------------------------------------------------------

Widget _buildColorPermutations() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'Color Permutations',
        subtitle: 'background, foreground, overlay and surface tint',
        icon: Icons.color_lens_outlined,
        gradient: const [Color(0xFFC2185B), Color(0xFFEC407A)],
      ),
      _buildExplanation(
        'Color is split across four ButtonStyle properties. backgroundColor '
        'paints the buttons fill, foregroundColor sets the label and icon '
        'color, overlayColor controls the splash and hover tint, and '
        'surfaceTintColor adds an elevation aware tint that helps Material '
        '3 buttons feel grounded against varied surfaces.',
      ),
      _buildExplanation(
        'These properties combine to express semantic intent. Solid '
        'background and white foreground reads as primary, while a '
        'transparent background with a colored foreground feels like a '
        'secondary text button. The overlay color is what makes the '
        'pressed and hovered effects visible, so it should harmonize with '
        'the foreground rather than the background.',
      ),
      _buildExplanation(
        'Surface tint is most useful when buttons sit over images or '
        'gradients. By blending with the surface tone it prevents the '
        'button from looking pasted on. Setting surfaceTintColor to '
        'Colors.transparent disables the effect when you need a strict '
        'flat appearance.',
      ),
      _buildLabel('PRIMARY VARIANTS', Colors.pink.shade700),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Deep Purple'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text('Indigo'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Teal'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Green'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black87,
              ),
              child: const Text('Orange'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Red'),
            ),
          ],
        ),
      ),
      _buildLabel('OVERLAY AND SURFACE TINT', Colors.pink.shade700),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll<Color>(
                  Color(0xFF1A237E),
                ),
                foregroundColor: const WidgetStatePropertyAll<Color>(
                  Colors.white,
                ),
                overlayColor: WidgetStatePropertyAll<Color>(
                  Colors.white.withAlpha(60),
                ),
              ),
              child: const Text('white overlay'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll<Color>(
                  Color(0xFFE0F7FA),
                ),
                foregroundColor: const WidgetStatePropertyAll<Color>(
                  Color(0xFF00695C),
                ),
                overlayColor: WidgetStatePropertyAll<Color>(
                  Colors.teal.withAlpha(60),
                ),
              ),
              child: const Text('teal overlay'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Color(0xFFFFF3E0),
                ),
                foregroundColor: WidgetStatePropertyAll<Color>(
                  Color(0xFFE65100),
                ),
                surfaceTintColor: WidgetStatePropertyAll<Color>(
                  Colors.transparent,
                ),
              ),
              child: const Text('no tint'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Color(0xFFFCE4EC),
                ),
                foregroundColor: WidgetStatePropertyAll<Color>(
                  Color(0xFFAD1457),
                ),
                surfaceTintColor: WidgetStatePropertyAll<Color>(
                  Color(0xFFEC407A),
                ),
              ),
              child: const Text('pink tint'),
            ),
          ],
        ),
      ),
      _buildLabel('TEXT BUTTON COLOR', Colors.pink.shade700),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
              child: const Text('Purple text'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              child: const Text('Green text'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Red text'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.indigo,
                backgroundColor: Colors.indigo.shade50,
              ),
              child: const Text('tonal text'),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: WidgetStateProperty.resolveWith
// ---------------------------------------------------------------------------

Widget _buildWidgetStatePropertySection() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'WidgetStateProperty',
        subtitle: 'resolveWith over hovered, pressed, focused, disabled',
        icon: Icons.touch_app_outlined,
        gradient: const [Color(0xFFE65100), Color(0xFFFF7043)],
      ),
      _buildExplanation(
        'WidgetStateProperty is the foundation of every animatable button '
        'attribute. Each property accepts a Set<WidgetState> describing '
        'the buttons current condition and returns the value to use. The '
        'most common states are hovered, pressed, focused, disabled and '
        'selected.',
      ),
      _buildExplanation(
        'WidgetStatePropertyAll<T> ignores the state set and always '
        'returns the same value. This is appropriate for static styling '
        'and is what styleFrom emits internally for plain values. When '
        'you need state aware values, switch to '
        'WidgetStateProperty.resolveWith which receives the state set as '
        'an argument so you can branch on it.',
      ),
      _buildExplanation(
        'A useful pattern is to test states in priority order. Disabled '
        'usually wins over everything else, then pressed, then hovered, '
        'then focused. The default branch at the bottom of the resolver '
        'handles the rest state. Keeping the order consistent across '
        'properties ensures the visual transitions feel coherent.',
      ),
      _buildLabel('STATIC RESOLVERS', Colors.deepOrange.shade700),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.indigo),
                foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                elevation: WidgetStatePropertyAll<double>(2),
              ),
              child: const Text('PropertyAll'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.grey.shade300;
                  }
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.deepPurple.shade900;
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return Colors.deepPurple.shade400;
                  }
                  return Colors.deepPurple;
                }),
                foregroundColor: const WidgetStatePropertyAll<Color>(
                  Colors.white,
                ),
              ),
              child: const Text('resolve bg'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll<Color>(
                  Color(0xFF263238),
                ),
                foregroundColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.white38;
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return Colors.amber;
                  }
                  return Colors.white;
                }),
              ),
              child: const Text('resolve fg'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: WidgetStateProperty.resolveWith<double>((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return 0;
                  }
                  if (states.contains(WidgetState.pressed)) {
                    return 1;
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return 8;
                  }
                  return 4;
                }),
                backgroundColor: const WidgetStatePropertyAll<Color>(
                  Color(0xFF1565C0),
                ),
                foregroundColor: const WidgetStatePropertyAll<Color>(
                  Colors.white,
                ),
              ),
              child: const Text('resolve elev'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: WidgetStateProperty.resolveWith<OutlinedBorder>((
                  states,
                ) {
                  if (states.contains(WidgetState.pressed)) {
                    return const StadiumBorder();
                  }
                  return const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  );
                }),
                backgroundColor: const WidgetStatePropertyAll<Color>(
                  Color(0xFF00695C),
                ),
                foregroundColor: const WidgetStatePropertyAll<Color>(
                  Colors.white,
                ),
              ),
              child: const Text('resolve shape'),
            ),
          ],
        ),
      ),
      _buildLabel('STATE LEGEND', Colors.deepOrange.shade700),
      _buildContentPadding(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildChip(
              label: 'hovered',
              icon: Icons.mouse_outlined,
              gradient: const [Color(0xFFFB8C00), Color(0xFFFFB300)],
              elevation: 2,
            ),
            _buildChip(
              label: 'pressed',
              icon: Icons.touch_app,
              gradient: const [Color(0xFFE65100), Color(0xFFFB8C00)],
              elevation: 4,
            ),
            _buildChip(
              label: 'focused',
              icon: Icons.center_focus_strong,
              gradient: const [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
              elevation: 3,
            ),
            _buildChip(
              label: 'disabled',
              icon: Icons.block,
              gradient: const [Color(0xFF616161), Color(0xFF9E9E9E)],
              elevation: 1,
            ),
            _buildChip(
              label: 'selected',
              icon: Icons.check_circle_outline,
              gradient: const [Color(0xFF00695C), Color(0xFF26A69A)],
              elevation: 2,
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Mouse cursor
// ---------------------------------------------------------------------------

Widget _buildMouseCursorShowcase() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'Mouse Cursor',
        subtitle: 'SystemMouseCursors driven by ButtonStyle',
        icon: Icons.mouse,
        gradient: const [Color(0xFF4527A0), Color(0xFF7E57C2)],
      ),
      _buildExplanation(
        'On platforms with pointer input the mouse cursor that appears '
        'over a button is configurable through ButtonStyle.mouseCursor. '
        'Most buttons default to SystemMouseCursors.click, but you can '
        'change it to communicate a different intent or to indicate a '
        'forbidden action.',
      ),
      _buildExplanation(
        'A common refinement is to switch to forbidden when the button '
        'is disabled. WidgetStateMouseCursor.clickable does this for you, '
        'and resolving WidgetStateProperty<MouseCursor> manually allows '
        'finer control such as showing a basic cursor on hover for a '
        'subtle button.',
      ),
      _buildExplanation(
        'Choose cursors carefully. Mismatched cursors are a strong '
        'signal of broken interactivity. Reserve the help cursor for '
        'real help affordances and the move cursor for genuinely '
        'movable surfaces; do not use them as decoration.',
      ),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ).copyWith(
                mouseCursor: const WidgetStatePropertyAll<MouseCursor>(
                  SystemMouseCursors.click,
                ),
              ),
              child: const Text('click'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade300,
                foregroundColor: Colors.white,
              ).copyWith(
                mouseCursor: const WidgetStatePropertyAll<MouseCursor>(
                  SystemMouseCursors.basic,
                ),
              ),
              child: const Text('basic'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade400,
                foregroundColor: Colors.white,
              ).copyWith(
                mouseCursor: const WidgetStatePropertyAll<MouseCursor>(
                  SystemMouseCursors.help,
                ),
              ),
              child: const Text('help'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade500,
                foregroundColor: Colors.white,
              ).copyWith(
                mouseCursor: const WidgetStatePropertyAll<MouseCursor>(
                  SystemMouseCursors.move,
                ),
              ),
              child: const Text('move'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade600,
                foregroundColor: Colors.white,
              ).copyWith(
                mouseCursor: const WidgetStatePropertyAll<MouseCursor>(
                  SystemMouseCursors.grab,
                ),
              ),
              child: const Text('grab'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade700,
                foregroundColor: Colors.white,
              ).copyWith(
                mouseCursor: const WidgetStatePropertyAll<MouseCursor>(
                  SystemMouseCursors.text,
                ),
              ),
              child: const Text('text'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade800,
                foregroundColor: Colors.white,
              ).copyWith(
                mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((
                  states,
                ) {
                  if (states.contains(WidgetState.disabled)) {
                    return SystemMouseCursors.forbidden;
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return SystemMouseCursors.click;
                  }
                  return SystemMouseCursors.basic;
                }),
              ),
              child: const Text('resolved cursor'),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Visual density
// ---------------------------------------------------------------------------

Widget _buildVisualDensitySection() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'Visual Density and Tap Target',
        subtitle: 'Tuning compactness for desktop and mobile',
        icon: Icons.density_medium,
        gradient: const [Color(0xFFB71C1C), Color(0xFFEF5350)],
      ),
      _buildExplanation(
        'visualDensity adjusts the buttons intrinsic size by adding or '
        'removing pixels around the content. Negative values produce '
        'tighter buttons appropriate for desktop dense layouts, while '
        'positive values inflate the button for touch friendly contexts.',
      ),
      _buildExplanation(
        'tapTargetSize is a related but independent property. With '
        'MaterialTapTargetSize.padded the buttons hit region is expanded '
        'to at least forty eight pixels, even when the visual size is '
        'smaller. shrinkWrap removes that expansion, which can be useful '
        'inside dense toolbars where buttons are kept close together.',
      ),
      _buildExplanation(
        'These two properties combine into the overall feel of the '
        'application. Use VisualDensity.standard for general usage, '
        'VisualDensity.compact for power user surfaces, and '
        'VisualDensity.comfortable when the audience favors larger '
        'targets.',
      ),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
              child: const Text('compact'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity.standard,
              ),
              child: const Text('standard'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity.comfortable,
              ),
              child: const Text('comfortable'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                visualDensity: const VisualDensity(
                  horizontal: -2,
                  vertical: -2,
                ),
              ),
              child: const Text('tight (-2/-2)'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                visualDensity: const VisualDensity(
                  horizontal: 2,
                  vertical: 2,
                ),
              ),
              child: const Text('roomy (2/2)'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              child: const Text('padded target'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('shrinkWrap'),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 10: styleFrom shortcut
// ---------------------------------------------------------------------------

Widget _buildStyleFromShortcutSection() {
  return _buildSectionCard(
    children: [
      _buildSectionHeader(
        title: 'styleFrom Shortcuts',
        subtitle: 'ElevatedButton, FilledButton, OutlinedButton, IconButton',
        icon: Icons.bolt_outlined,
        gradient: const [Color(0xFF1B5E20), Color(0xFF66BB6A)],
      ),
      _buildExplanation(
        'Each Material button class exposes a static styleFrom helper. '
        'It accepts plain values for the most common ButtonStyle '
        'properties and wraps them in WidgetStateProperty for you. The '
        'helper also performs sensible defaulting; for example, the '
        'overlay color is derived from the foreground color so press and '
        'hover feedback works automatically.',
      ),
      _buildExplanation(
        'Reach for styleFrom whenever the desired styling does not vary '
        'by state. It is concise, easy to read and integrates well with '
        'theme tokens. Drop down to the raw ButtonStyle constructor only '
        'when you need different values per state, when you want to call '
        'copyWith repeatedly, or when you must opt out of a default that '
        'styleFrom adds.',
      ),
      _buildExplanation(
        'IconButton has its own IconButton.styleFrom variant that '
        'exposes iconSize and iconColor. These are not present on the '
        'other helpers because they are specific to icon based buttons. '
        'For icon size adjustments on FilledButton.icon or '
        'ElevatedButton.icon, set the icons size directly on the Icon '
        'widget passed as the icon argument.',
      ),
      _buildLabel('ELEVATEDBUTTON.styleFrom', Colors.green.shade800),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                elevation: 4,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                shape: const StadiumBorder(),
              ),
              child: const Text('Save'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('Upload'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
              label: const Text('Delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      _buildLabel('FILLEDBUTTON.styleFrom', Colors.green.shade800),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Filled'),
            ),
            FilledButton.tonal(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
              ),
              child: const Text('Tonal'),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send_outlined),
              label: const Text('Send'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      _buildLabel('OUTLINEDBUTTON.styleFrom', Colors.green.shade800),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.indigo,
                side: const BorderSide(color: Colors.indigo, width: 2),
              ),
              child: const Text('Outlined'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.teal,
                side: const BorderSide(color: Colors.teal, width: 2),
                shape: const StadiumBorder(),
              ),
              child: const Text('Teal pill'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepOrange,
                side: const BorderSide(color: Colors.deepOrange, width: 2),
              ),
            ),
          ],
        ),
      ),
      _buildLabel('ICONBUTTON.styleFrom', Colors.green.shade800),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
              style: IconButton.styleFrom(
                backgroundColor: Colors.pink.shade50,
                foregroundColor: Colors.pink,
                iconSize: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_outline),
              style: IconButton.styleFrom(
                backgroundColor: Colors.amber.shade50,
                foregroundColor: Colors.amber.shade800,
                iconSize: 24,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
              style: IconButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
                foregroundColor: Colors.blue.shade700,
                iconSize: 28,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.grey.shade800,
                iconSize: 32,
              ),
            ),
          ],
        ),
      ),
      _buildLabel('TEXTBUTTON.styleFrom', Colors.green.shade800),
      _buildContentPadding(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Discard'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.help_outline),
              label: const Text('Learn more'),
              style: TextButton.styleFrom(foregroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Top-level entrypoint
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'Button Styles Misc Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
    home: Scaffold(
      appBar: AppBar(title: const Text('ButtonStyle Composition')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildIntroCard(),
          _buildShapeShowcase(),
          _buildElevationShowcase(),
          _buildPaddingShowcase(),
          _buildSideAndBorderShowcase(),
          _buildColorPermutations(),
          _buildWidgetStatePropertySection(),
          _buildMouseCursorShowcase(),
          _buildVisualDensitySection(),
          _buildStyleFromShortcutSection(),
        ],
      ),
    ),
  );
}
