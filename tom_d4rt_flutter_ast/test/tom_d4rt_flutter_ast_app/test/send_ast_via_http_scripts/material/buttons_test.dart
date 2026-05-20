// D4rt test script: Deep visual demo of the Material 3 button library.
// Theme: "the M3 button library: pick the right press".
//
// Demonstrates the full Material 3 button family — ElevatedButton,
// FilledButton, FilledButton.tonal, OutlinedButton, TextButton, IconButton
// (default / filled / filledTonal / outlined), FloatingActionButton
// (small / standard / large / extended) — plus their styling surface area:
// ButtonStyle, ButtonStyle.copyWith, ElevatedButton.styleFrom,
// WidgetStateProperty.resolveWith, WidgetStateProperty.all, and the
// WidgetState values (hovered / pressed / focused / selected / disabled /
// dragged), as well as ButtonStyleButton.iconAlignment.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('Buttons deep visual demo executing');

  // ==========================================================================
  // SECTION 1: Hero header — when to use which button
  // ==========================================================================
  // The M3 button hierarchy ranks emphasis from high to low:
  //   filled > tonal > elevated > outlined > text.
  // Pick the highest emphasis that still matches the action's gravity. A
  // checkout flow's primary CTA is "filled". A "Cancel" is almost always
  // "text". An "Apply filter" peer-of-cancel is "outlined" or "tonal".
  debugPrint('=== Section 1: Hero header ===');

  const Widget heroHeader = Card(
    elevation: 6.0,
    margin: EdgeInsets.all(16.0),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.touch_app, size: 36.0, color: Colors.indigo),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'The M3 Button Library: Pick the Right Press',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            'Material 3 ranks button emphasis from high to low:\n'
            '  filled  >  tonal  >  elevated  >  outlined  >  text\n\n'
            'Pick the highest emphasis that still matches the action\'s '
            'gravity. Primary CTAs are filled. Cancels are text. Peer-of-'
            'cancel actions are outlined or tonal.',
            style: TextStyle(fontSize: 13.0, height: 1.45),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 2: The five button families — side by side
  // ==========================================================================
  // Same label "Continue", same default size: lets you compare the visual
  // weight of each variant at a glance.
  debugPrint('=== Section 2: Five button families side by side ===');

  Widget familyCard({
    required String title,
    required String emphasis,
    required Color accent,
    required Widget button,
  }) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: Container(
        width: 180.0,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: accent, width: 4.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accent,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              emphasis,
              style: const TextStyle(fontSize: 11.0, color: Colors.black54),
            ),
            const SizedBox(height: 10.0),
            Center(child: button),
          ],
        ),
      ),
    );
  }

  final Widget familyRow = Wrap(
    alignment: WrapAlignment.center,
    children: <Widget>[
      familyCard(
        title: 'FilledButton',
        emphasis: 'highest emphasis',
        accent: Colors.indigo,
        button: FilledButton(
          onPressed: () => debugPrint('Filled tapped'),
          child: const Text('Continue'),
        ),
      ),
      familyCard(
        title: 'FilledButton.tonal',
        emphasis: 'medium-high emphasis',
        accent: Colors.teal,
        button: FilledButton.tonal(
          onPressed: () => debugPrint('Tonal tapped'),
          child: const Text('Continue'),
        ),
      ),
      familyCard(
        title: 'ElevatedButton',
        emphasis: 'medium emphasis',
        accent: Colors.deepPurple,
        button: ElevatedButton(
          onPressed: () => debugPrint('Elevated tapped'),
          child: const Text('Continue'),
        ),
      ),
      familyCard(
        title: 'OutlinedButton',
        emphasis: 'medium-low emphasis',
        accent: Colors.orange,
        button: OutlinedButton(
          onPressed: () => debugPrint('Outlined tapped'),
          child: const Text('Continue'),
        ),
      ),
      familyCard(
        title: 'TextButton',
        emphasis: 'lowest emphasis',
        accent: Colors.grey,
        button: TextButton(
          onPressed: () => debugPrint('Text tapped'),
          child: const Text('Continue'),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 3: ElevatedButton deep dive — elevation x tint matrix
  // ==========================================================================
  // A 3x3 matrix walking through elevation (low/medium/high) crossed with
  // shadowColor + surfaceTintColor. Surface tint is the M3 way to indicate
  // elevation without a literal shadow on light surfaces.
  debugPrint('=== Section 3: ElevatedButton elevation x tint matrix ===');

  Widget elevatedCell({
    required double elevation,
    required Color tint,
    required Color shadow,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () => debugPrint('Cell tapped: $label'),
            style: ElevatedButton.styleFrom(
              elevation: elevation,
              shadowColor: shadow,
              surfaceTintColor: tint,
              minimumSize: const Size(110.0, 40.0),
            ),
            child: Text(label),
          ),
          const SizedBox(height: 4.0),
          Text(
            'e=$elevation',
            style: const TextStyle(fontSize: 10.0, color: Colors.black45),
          ),
        ],
      ),
    );
  }

  final Widget elevationMatrix = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ElevatedButton — elevation x surfaceTint matrix',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Rows: elevation 0 / 4 / 12. Columns: indigo / teal / pink tint.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              elevatedCell(
                elevation: 0.0,
                tint: Colors.indigo,
                shadow: Colors.indigo,
                label: 'flat',
              ),
              elevatedCell(
                elevation: 0.0,
                tint: Colors.teal,
                shadow: Colors.teal,
                label: 'flat',
              ),
              elevatedCell(
                elevation: 0.0,
                tint: Colors.pink,
                shadow: Colors.pink,
                label: 'flat',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              elevatedCell(
                elevation: 4.0,
                tint: Colors.indigo,
                shadow: Colors.indigo,
                label: 'lifted',
              ),
              elevatedCell(
                elevation: 4.0,
                tint: Colors.teal,
                shadow: Colors.teal,
                label: 'lifted',
              ),
              elevatedCell(
                elevation: 4.0,
                tint: Colors.pink,
                shadow: Colors.pink,
                label: 'lifted',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              elevatedCell(
                elevation: 12.0,
                tint: Colors.indigo,
                shadow: Colors.indigo,
                label: 'floating',
              ),
              elevatedCell(
                elevation: 12.0,
                tint: Colors.teal,
                shadow: Colors.teal,
                label: 'floating',
              ),
              elevatedCell(
                elevation: 12.0,
                tint: Colors.pink,
                shadow: Colors.pink,
                label: 'floating',
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 4: FilledButton + FilledButton.tonal — palette demos
  // ==========================================================================
  // M3 reserves the primary palette for the screen's single most important
  // action. Secondary backs supporting actions. Tertiary highlights an
  // accent or contrasting moment (e.g. a celebratory state).
  debugPrint('=== Section 4: Filled + Tonal palette demos ===');

  Widget paletteRow({
    required String paletteLabel,
    required String usage,
    required Color filledBg,
    required Color filledFg,
    required Color tonalBg,
    required Color tonalFg,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100.0,
            child: Text(
              paletteLabel,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          FilledButton(
            onPressed: () => debugPrint('Filled $paletteLabel'),
            style: FilledButton.styleFrom(
              backgroundColor: filledBg,
              foregroundColor: filledFg,
            ),
            child: const Text('Save'),
          ),
          const SizedBox(width: 12.0),
          FilledButton.tonal(
            onPressed: () => debugPrint('Tonal $paletteLabel'),
            style: FilledButton.styleFrom(
              backgroundColor: tonalBg,
              foregroundColor: tonalFg,
            ),
            child: const Text('Save'),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              usage,
              style: const TextStyle(fontSize: 11.0, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  final Widget paletteCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'FilledButton + FilledButton.tonal — by M3 palette role',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Filled = solid container. Tonal = same shape, secondary tint.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          paletteRow(
            paletteLabel: 'Primary',
            usage: 'The screen\'s single most important action.',
            filledBg: Colors.indigo,
            filledFg: Colors.white,
            tonalBg: Colors.indigo.shade100,
            tonalFg: Colors.indigo.shade900,
          ),
          paletteRow(
            paletteLabel: 'Secondary',
            usage: 'Supporting actions that sit next to primary.',
            filledBg: Colors.teal,
            filledFg: Colors.white,
            tonalBg: Colors.teal.shade100,
            tonalFg: Colors.teal.shade900,
          ),
          paletteRow(
            paletteLabel: 'Tertiary',
            usage: 'Accent moments — celebratory, contrasting, decorative.',
            filledBg: Colors.deepOrange,
            filledFg: Colors.white,
            tonalBg: Colors.deepOrange.shade100,
            tonalFg: Colors.deepOrange.shade900,
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 5: OutlinedButton — border + radius variants
  // ==========================================================================
  // Outlined buttons read as "important but not primary". Their personality
  // comes almost entirely from their BorderSide (color + width) and shape.
  debugPrint('=== Section 5: OutlinedButton border + radius variants ===');

  Widget outlinedCell({
    required String label,
    required double width,
    required Color color,
    required OutlinedBorder shape,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: OutlinedButton(
        onPressed: () => debugPrint('Outlined $label'),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: width),
          shape: shape,
          foregroundColor: color,
        ),
        child: Text(label),
      ),
    );
  }

  final Widget outlinedCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'OutlinedButton — border thickness, color, and shape',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Stadium shape is the M3 default. Rounded and square are common '
            'overrides for chip-like or tile-like presentations.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          const Text('Border widths (1 / 2 / 3 px):',
              style: TextStyle(fontSize: 12.0)),
          Wrap(
            children: <Widget>[
              outlinedCell(
                label: 'Thin',
                width: 1.0,
                color: Colors.indigo,
                shape: const StadiumBorder(),
              ),
              outlinedCell(
                label: 'Medium',
                width: 2.0,
                color: Colors.indigo,
                shape: const StadiumBorder(),
              ),
              outlinedCell(
                label: 'Thick',
                width: 3.0,
                color: Colors.indigo,
                shape: const StadiumBorder(),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text('Border colors (semantic):',
              style: TextStyle(fontSize: 12.0)),
          Wrap(
            children: <Widget>[
              outlinedCell(
                label: 'Edit',
                width: 2.0,
                color: Colors.blueGrey,
                shape: const StadiumBorder(),
              ),
              outlinedCell(
                label: 'Warn',
                width: 2.0,
                color: Colors.orange,
                shape: const StadiumBorder(),
              ),
              outlinedCell(
                label: 'Delete',
                width: 2.0,
                color: Colors.red,
                shape: const StadiumBorder(),
              ),
              outlinedCell(
                label: 'Confirm',
                width: 2.0,
                color: Colors.green,
                shape: const StadiumBorder(),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text('Shape variants (stadium / rounded / square):',
              style: TextStyle(fontSize: 12.0)),
          Wrap(
            children: <Widget>[
              outlinedCell(
                label: 'Stadium',
                width: 2.0,
                color: Colors.deepPurple,
                shape: const StadiumBorder(),
              ),
              outlinedCell(
                label: 'Rounded',
                width: 2.0,
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              outlinedCell(
                label: 'Square',
                width: 2.0,
                color: Colors.deepPurple,
                shape: const RoundedRectangleBorder(),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 6: TextButton — typography sizes + low-stakes actions
  // ==========================================================================
  // TextButtons are the right call for low-stakes actions like "Cancel",
  // "Skip", "Learn more", or footer links inside dialogs and cards.
  debugPrint('=== Section 6: TextButton typography and alignment ===');

  Widget textButtonRow({
    required String label,
    required double fontSize,
    required FontWeight weight,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            child: Text(
              '${fontSize.toInt()}px',
              style: const TextStyle(
                fontSize: 11.0,
                color: Colors.black54,
              ),
            ),
          ),
          TextButton(
            onPressed: () => debugPrint('Text $label'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.indigo,
              textStyle: TextStyle(fontSize: fontSize, fontWeight: weight),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }

  final Widget textButtonCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'TextButton — the "low-stakes action" workhorse',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Cancel, Skip, Learn more, "Forgot password?", dialog footers.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          textButtonRow(
            label: 'Small',
            fontSize: 12.0,
            weight: FontWeight.normal,
          ),
          textButtonRow(
            label: 'Medium',
            fontSize: 14.0,
            weight: FontWeight.w500,
          ),
          textButtonRow(
            label: 'Large',
            fontSize: 18.0,
            weight: FontWeight.bold,
          ),
          const Divider(),
          const Text('Alignment inside a constrained box:',
              style: TextStyle(fontSize: 12.0)),
          SizedBox(
            width: 280.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () => debugPrint('Skip'),
                  child: const Text('Skip'),
                ),
                TextButton(
                  onPressed: () => debugPrint('Continue'),
                  style: TextButton.styleFrom(foregroundColor: Colors.indigo),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 7: IconButton variants — default / filled / filledTonal / outlined
  // ==========================================================================
  // The four M3 IconButton presentations form a parallel hierarchy to the
  // text buttons. Their visualDensity + padding control how tightly they
  // pack into toolbars and headers.
  debugPrint('=== Section 7: IconButton variants + density ===');

  Widget iconButtonCell({
    required String label,
    required Widget button,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          button,
          const SizedBox(height: 4.0),
          Text(
            label,
            style: const TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  final Widget iconButtonCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'IconButton — four M3 presentations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Default / filled / filledTonal / outlined map to the same '
            'emphasis ladder as the text buttons.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              iconButtonCell(
                label: 'default',
                button: IconButton(
                  onPressed: () => debugPrint('IconButton default'),
                  icon: const Icon(Icons.favorite_border),
                ),
              ),
              iconButtonCell(
                label: 'filled',
                button: IconButton.filled(
                  onPressed: () => debugPrint('IconButton filled'),
                  icon: const Icon(Icons.favorite),
                ),
              ),
              iconButtonCell(
                label: 'filledTonal',
                button: IconButton.filledTonal(
                  onPressed: () => debugPrint('IconButton tonal'),
                  icon: const Icon(Icons.bookmark),
                ),
              ),
              iconButtonCell(
                label: 'outlined',
                button: IconButton.outlined(
                  onPressed: () => debugPrint('IconButton outlined'),
                  icon: const Icon(Icons.share),
                ),
              ),
            ],
          ),
          const Divider(),
          const Text('Padding + visualDensity matrix:',
              style: TextStyle(fontSize: 12.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              iconButtonCell(
                label: 'compact',
                button: IconButton(
                  onPressed: () => debugPrint('compact'),
                  padding: const EdgeInsets.all(4.0),
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.settings),
                ),
              ),
              iconButtonCell(
                label: 'standard',
                button: IconButton(
                  onPressed: () => debugPrint('standard'),
                  icon: const Icon(Icons.settings),
                ),
              ),
              iconButtonCell(
                label: 'comfortable',
                button: IconButton(
                  onPressed: () => debugPrint('comfortable'),
                  padding: const EdgeInsets.all(16.0),
                  visualDensity: VisualDensity.comfortable,
                  icon: const Icon(Icons.settings),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 8: FAB family — small / standard / large / extended
  // ==========================================================================
  // FABs anchor the screen's single hero action. Extended adds a label and
  // is the right call when the icon is ambiguous on its own.
  debugPrint('=== Section 8: FAB family ===');

  Widget fabCell({
    required String label,
    required Widget fab,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          fab,
          const SizedBox(height: 6.0),
          Text(
            label,
            style: const TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  final Widget fabCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'FloatingActionButton — sizes + shape variants',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'small / standard / large / extended. Extended carries a label.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              fabCell(
                label: 'small',
                fab: FloatingActionButton.small(
                  onPressed: () => debugPrint('FAB small'),
                  child: const Icon(Icons.add),
                ),
              ),
              fabCell(
                label: 'standard',
                fab: FloatingActionButton(
                  onPressed: () => debugPrint('FAB standard'),
                  child: const Icon(Icons.edit),
                ),
              ),
              fabCell(
                label: 'large',
                fab: FloatingActionButton.large(
                  onPressed: () => debugPrint('FAB large'),
                  child: const Icon(Icons.create),
                ),
              ),
              fabCell(
                label: 'extended',
                fab: FloatingActionButton.extended(
                  onPressed: () => debugPrint('FAB extended'),
                  icon: const Icon(Icons.send),
                  label: const Text('Send invite'),
                ),
              ),
            ],
          ),
          const Divider(),
          const Text('Shape variants (circular / squircle / rounded square):',
              style: TextStyle(fontSize: 12.0)),
          Wrap(
            children: <Widget>[
              fabCell(
                label: 'circular',
                fab: FloatingActionButton(
                  onPressed: () => debugPrint('shape circle'),
                  shape: const CircleBorder(),
                  child: const Icon(Icons.star),
                ),
              ),
              fabCell(
                label: 'squircle',
                fab: FloatingActionButton(
                  onPressed: () => debugPrint('shape squircle'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Icon(Icons.star),
                ),
              ),
              fabCell(
                label: 'rounded',
                fab: FloatingActionButton(
                  onPressed: () => debugPrint('shape rounded'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Icon(Icons.star),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 9: ButtonStyle anatomy — what each field controls
  // ==========================================================================
  // ButtonStyle is a bag of WidgetStateProperty<T>. Every visual hook is
  // here. The card below annotates each field with a one-line description.
  debugPrint('=== Section 9: ButtonStyle anatomy ===');

  Widget anatomyRow(String field, String purpose) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170.0,
            child: Text(
              field,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Colors.indigo,
              ),
            ),
          ),
          Expanded(
            child: Text(
              purpose,
              style: const TextStyle(fontSize: 12.0, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  final Widget anatomyCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ButtonStyle anatomy — every field, what it controls',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Each field is a WidgetStateProperty<T>: the value can vary '
            'with the button\'s current WidgetState set.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          anatomyRow('backgroundColor', 'Container fill color.'),
          anatomyRow('foregroundColor', 'Label + icon color.'),
          anatomyRow('overlayColor', 'Hover / pressed / focused ink layer.'),
          anatomyRow('shadowColor', 'Color of the drop shadow.'),
          anatomyRow('surfaceTintColor', 'M3 elevation tint over the surface.'),
          anatomyRow('elevation', 'Resting / hovered / pressed elevation.'),
          anatomyRow('padding', 'Inner padding around label + icon.'),
          anatomyRow('minimumSize', 'Smallest allowed (width, height).'),
          anatomyRow('fixedSize', 'Locked (width, height); overrides min/max.'),
          anatomyRow('maximumSize', 'Largest allowed (width, height).'),
          anatomyRow('iconColor', 'Icon-specific color override.'),
          anatomyRow('iconSize', 'Icon-specific size override.'),
          anatomyRow('side', 'BorderSide (color + width) for outlined.'),
          anatomyRow('shape', 'OutlinedBorder: stadium, rounded, circle...'),
          anatomyRow('mouseCursor', 'Cursor style on web/desktop.'),
          anatomyRow('visualDensity', 'Compact / standard / comfortable spacing.'),
          anatomyRow('tapTargetSize', 'shrinkWrap or padded 48dp target.'),
          anatomyRow('animationDuration', 'State change tween duration.'),
          anatomyRow('enableFeedback', 'Haptics + click sounds.'),
          anatomyRow('alignment', 'Alignment of child inside the button.'),
          anatomyRow('splashFactory', 'InkRipple, InkSparkle, noSplash...'),
          anatomyRow('backgroundBuilder',
              'Wrap the background with a custom widget.'),
          anatomyRow('foregroundBuilder',
              'Wrap the label + icon with a custom widget.'),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 10: WidgetStateProperty walkthrough
  // ==========================================================================
  // Three live examples showing how to resolve a property against the
  // current WidgetState set: hover changes color, pressed changes
  // elevation, disabled changes opacity. The same recipe applies to every
  // ButtonStyle field.
  debugPrint('=== Section 10: WidgetStateProperty walkthrough ===');

  // Example A — hover changes background color.
  final ButtonStyle hoverStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        // States observed during the button's lifecycle.
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade300;
        }
        if (states.contains(WidgetState.hovered)) {
          // Hover swap — try mousing over the button.
          return Colors.indigo.shade700;
        }
        if (states.contains(WidgetState.focused)) {
          return Colors.indigo.shade400;
        }
        return Colors.indigo;
      },
    ),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );

  // Example B — pressed changes elevation.
  final ButtonStyle pressedElevationStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.deepPurple),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.resolveWith<double>(
      (Set<WidgetState> states) {
        // Higher elevation while pressed gives a "push-down" rebound feel.
        if (states.contains(WidgetState.pressed)) {
          return 12.0;
        }
        if (states.contains(WidgetState.hovered)) {
          return 6.0;
        }
        return 2.0;
      },
    ),
  );

  // Example C — disabled changes opacity via overlayColor + foreground.
  final ButtonStyle disabledOpacityStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.teal.withValues(alpha: 0.25);
        }
        return Colors.teal;
      },
    ),
    foregroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white.withValues(alpha: 0.6);
        }
        return Colors.white;
      },
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        // Selected + pressed combine into a darker ink.
        if (states.contains(WidgetState.selected) &&
            states.contains(WidgetState.pressed)) {
          return Colors.black.withValues(alpha: 0.2);
        }
        if (states.contains(WidgetState.dragged)) {
          return Colors.amber.withValues(alpha: 0.4);
        }
        return Colors.white.withValues(alpha: 0.1);
      },
    ),
  );

  Widget stateExample({
    required String title,
    required String narration,
    required ButtonStyle style,
    required bool enabled,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: enabled
                ? () => debugPrint('state demo: $title')
                : null,
            style: style,
            child: Text(enabled ? 'Try me' : 'Disabled'),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              narration,
              style: const TextStyle(fontSize: 11.0, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  final Widget stateCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'WidgetStateProperty walkthrough — three live examples',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'WidgetState values: hovered, pressed, focused, selected, '
            'disabled, dragged, error, scrolledUnder.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          stateExample(
            title: 'Hover swap',
            narration: 'backgroundColor resolves indigo -> indigo.700 on hover.',
            style: hoverStyle,
            enabled: true,
          ),
          stateExample(
            title: 'Pressed lift',
            narration: 'elevation resolves 2 -> 6 (hover) -> 12 (pressed).',
            style: pressedElevationStyle,
            enabled: true,
          ),
          stateExample(
            title: 'Disabled fade',
            narration: 'background and foreground fade via alpha when disabled.',
            style: disabledOpacityStyle,
            enabled: false,
          ),
          stateExample(
            title: 'Same, enabled',
            narration: 'Same style, but enabled — overlayColor reacts to ink.',
            style: disabledOpacityStyle,
            enabled: true,
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 11: With-icon variants + iconAlignment
  // ==========================================================================
  // Each main button family has an .icon constructor. iconAlignment lets
  // you put the icon at the start (default, like "send" arrow before the
  // word) or at the end (common for "next" affordances).
  debugPrint('=== Section 11: With-icon variants and iconAlignment ===');

  Widget iconVariantRow({
    required String family,
    required Widget startAligned,
    required Widget endAligned,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              family,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          startAligned,
          const SizedBox(width: 12.0),
          endAligned,
        ],
      ),
    );
  }

  final Widget iconVariantsCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'With-icon variants — iconAlignment start vs end',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'ButtonStyleButton.iconAlignment defaults to start. Use end for '
            '"Next ->" affordances.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          iconVariantRow(
            family: 'Elevated.icon',
            startAligned: ElevatedButton.icon(
              onPressed: () => debugPrint('Elevated.icon start'),
              icon: const Icon(Icons.download),
              label: const Text('Download'),
            ),
            endAligned: ElevatedButton.icon(
              onPressed: () => debugPrint('Elevated.icon end'),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
              iconAlignment: IconAlignment.end,
            ),
          ),
          iconVariantRow(
            family: 'Filled.icon',
            startAligned: FilledButton.icon(
              onPressed: () => debugPrint('Filled.icon start'),
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Buy now'),
            ),
            endAligned: FilledButton.icon(
              onPressed: () => debugPrint('Filled.icon end'),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Checkout'),
              iconAlignment: IconAlignment.end,
            ),
          ),
          iconVariantRow(
            family: 'Tonal.icon',
            startAligned: FilledButton.tonalIcon(
              onPressed: () => debugPrint('Tonal.icon start'),
              icon: const Icon(Icons.favorite),
              label: const Text('Favorite'),
            ),
            endAligned: FilledButton.tonalIcon(
              onPressed: () => debugPrint('Tonal.icon end'),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Open'),
              iconAlignment: IconAlignment.end,
            ),
          ),
          iconVariantRow(
            family: 'Outlined.icon',
            startAligned: OutlinedButton.icon(
              onPressed: () => debugPrint('Outlined.icon start'),
              icon: const Icon(Icons.refresh),
              label: const Text('Reload'),
            ),
            endAligned: OutlinedButton.icon(
              onPressed: () => debugPrint('Outlined.icon end'),
              icon: const Icon(Icons.chevron_right),
              label: const Text('Details'),
              iconAlignment: IconAlignment.end,
            ),
          ),
          iconVariantRow(
            family: 'Text.icon',
            startAligned: TextButton.icon(
              onPressed: () => debugPrint('Text.icon start'),
              icon: const Icon(Icons.help_outline),
              label: const Text('Learn more'),
            ),
            endAligned: TextButton.icon(
              onPressed: () => debugPrint('Text.icon end'),
              icon: const Icon(Icons.launch),
              label: const Text('Open docs'),
              iconAlignment: IconAlignment.end,
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 12: Themed-via-Theme demo
  // ==========================================================================
  // Wrapping a button row in a Theme(...) widget lets you push button
  // styling down through the tree without touching individual buttons.
  // This is the right home for "all primary buttons in this dialog are
  // teal, rounded, slightly taller".
  debugPrint('=== Section 12: Themed via Theme demo ===');

  final ButtonStyle themedElevatedStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
    minimumSize: WidgetStateProperty.all<Size>(const Size(120.0, 48.0)),
  );

  // ButtonStyle.copyWith — derive a tweaked variant from a base.
  final ButtonStyle themedElevatedStylePressed = themedElevatedStyle.copyWith(
    elevation: WidgetStateProperty.resolveWith<double>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) return 10.0;
        return 1.0;
      },
    ),
  );

  final Widget themedDemo = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Themed-via-Theme demo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Theme(...) overrides elevatedButtonTheme for this subtree only.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          Theme(
            data: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: themedElevatedStylePressed,
              ),
            ),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => debugPrint('themed save'),
                  child: const Text('Save draft'),
                ),
                const SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: () => debugPrint('themed publish'),
                  child: const Text('Publish'),
                ),
                const SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: () => debugPrint('themed cancel'),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Outside the Theme, ElevatedButton goes back to its default look:',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => debugPrint('default save'),
                child: const Text('Save draft'),
              ),
              const SizedBox(width: 12.0),
              ElevatedButton(
                onPressed: () => debugPrint('default publish'),
                child: const Text('Publish'),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 13: Disabled vs enabled — full family
  // ==========================================================================
  // Every button family rendered twice: with onPressed: () {} and with
  // onPressed: null. The null form is what Flutter uses to detect a
  // "disabled" widget state and apply the disabled style overlay.
  debugPrint('=== Section 13: Disabled vs enabled ===');

  Widget disabledRow({
    required String family,
    required Widget enabled,
    required Widget disabled,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              family,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          enabled,
          const SizedBox(width: 12.0),
          disabled,
        ],
      ),
    );
  }

  final Widget disabledCard = Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(12.0),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Disabled vs enabled — onPressed: () {} vs onPressed: null',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Passing null for onPressed flips the WidgetState.disabled flag.',
            style: TextStyle(fontSize: 11.0, color: Colors.black54),
          ),
          const SizedBox(height: 8.0),
          disabledRow(
            family: 'ElevatedButton',
            enabled: ElevatedButton(
              onPressed: () => debugPrint('Enabled elevated'),
              child: const Text('Submit'),
            ),
            disabled: const ElevatedButton(
              onPressed: null,
              child: Text('Submit'),
            ),
          ),
          disabledRow(
            family: 'FilledButton',
            enabled: FilledButton(
              onPressed: () => debugPrint('Enabled filled'),
              child: const Text('Save'),
            ),
            disabled: const FilledButton(
              onPressed: null,
              child: Text('Save'),
            ),
          ),
          disabledRow(
            family: 'FilledButton.tonal',
            enabled: FilledButton.tonal(
              onPressed: () => debugPrint('Enabled tonal'),
              child: const Text('Apply'),
            ),
            disabled: const FilledButton.tonal(
              onPressed: null,
              child: Text('Apply'),
            ),
          ),
          disabledRow(
            family: 'OutlinedButton',
            enabled: OutlinedButton(
              onPressed: () => debugPrint('Enabled outlined'),
              child: const Text('Cancel'),
            ),
            disabled: const OutlinedButton(
              onPressed: null,
              child: Text('Cancel'),
            ),
          ),
          disabledRow(
            family: 'TextButton',
            enabled: TextButton(
              onPressed: () => debugPrint('Enabled text'),
              child: const Text('Skip'),
            ),
            disabled: const TextButton(
              onPressed: null,
              child: Text('Skip'),
            ),
          ),
          disabledRow(
            family: 'IconButton',
            enabled: IconButton(
              onPressed: () => debugPrint('Enabled icon'),
              icon: const Icon(Icons.delete),
            ),
            disabled: const IconButton(
              onPressed: null,
              icon: Icon(Icons.delete),
            ),
          ),
          disabledRow(
            family: 'FloatingActionButton',
            enabled: FloatingActionButton.small(
              onPressed: () => debugPrint('Enabled fab'),
              child: const Icon(Icons.add),
            ),
            disabled: const FloatingActionButton.small(
              onPressed: null,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 14: Cheat-sheet card — button -> emphasis -> typical use
  // ==========================================================================
  debugPrint('=== Section 14: Cheat sheet ===');

  Widget sheetRow(String button, String emphasis, String use) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              button,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(
            width: 110.0,
            child: Text(
              emphasis,
              style: const TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              use,
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }

  final Widget cheatSheet = Card(
    elevation: 2.0,
    margin: const EdgeInsets.all(12.0),
    color: Colors.indigo.shade50,
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Cheat sheet — which button for which job',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(height: 8.0),
          sheetRow('FilledButton', 'highest',
              'Primary CTA. "Buy now", "Submit", "Create account".'),
          sheetRow('FilledButton.tonal', 'med-high',
              'Important but not the screen\'s hero. "Apply filter".'),
          sheetRow('ElevatedButton', 'medium',
              'Floating affordance on a busy surface. "Open editor".'),
          sheetRow('OutlinedButton', 'med-low',
              'Peer-of-cancel actions. "Cancel" next to "Save".'),
          sheetRow('TextButton', 'lowest',
              '"Skip", "Learn more", footer links inside dialogs.'),
          sheetRow('IconButton', 'low',
              'Compact actions in toolbars. "Edit", "Share", "Delete".'),
          sheetRow('IconButton.filled', 'med',
              'Standalone icon CTA with strong visual weight.'),
          sheetRow('IconButton.outlined', 'med-low',
              'Icon CTA that needs a frame to register as tappable.'),
          sheetRow('FAB', 'screen hero',
              'The single most important action of the whole screen.'),
          sheetRow('FAB.extended', 'screen hero',
              'Same, but with a label — when the icon alone is ambiguous.'),
        ],
      ),
    ),
  );

  // ==========================================================================
  // Assemble the gallery
  // ==========================================================================
  debugPrint('=== Assembling gallery ===');

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      title: const Text('The M3 Button Library'),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 2: Five families, side by side',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          familyRow,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 3: ElevatedButton deep dive',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          elevationMatrix,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 4: Filled + tonal palette',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          paletteCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 5: OutlinedButton variants',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          outlinedCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 6: TextButton typography',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          textButtonCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 7: IconButton variants',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          iconButtonCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 8: FAB family',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          fabCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 9: ButtonStyle anatomy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          anatomyCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 10: WidgetStateProperty walkthrough',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          stateCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 11: With-icon variants',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          iconVariantsCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 12: Themed via Theme',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          themedDemo,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 13: Disabled vs enabled',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          disabledCard,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SECTION 14: Cheat sheet',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
          cheatSheet,
          const SizedBox(height: 32.0),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () => debugPrint('Gallery FAB tapped'),
      icon: const Icon(Icons.touch_app),
      label: const Text('Pick the right press'),
    ),
  );
}
