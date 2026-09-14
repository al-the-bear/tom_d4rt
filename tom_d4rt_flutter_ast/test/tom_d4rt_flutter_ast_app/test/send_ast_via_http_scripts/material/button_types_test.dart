// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of Material button types.
//
// This file walks the entire Material 3 button family, side-by-side, with
// gradient-decorated section headers, shadow-lifted cards, and instructive
// paragraphs that explain when to choose each variant. The intent is to
// render a meaningful, varied surface inside the d4rt-driven Flutter test
// app — every section is a static composition (no setState, no controllers,
// no Tween reads), and every onPressed/onLongPress callback is a no-op.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Shared visual primitives
// ---------------------------------------------------------------------------

Widget _sectionCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required List<Color> headerGradient,
  required Widget body,
  required String paragraph,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _gradientHeader(
            icon: icon,
            title: title,
            subtitle: subtitle,
            gradient: headerGradient,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: body,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: _paragraph(paragraph),
          ),
        ],
      ),
    ),
  );
}

Widget _gradientHeader({
  required IconData icon,
  required String title,
  required String subtitle,
  required List<Color> gradient,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _paragraph(String text) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F6FB),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE0E3EE)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.lightbulb_outline, size: 18, color: Color(0xFF7C4DFF)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF333650),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _variantLabel(String label) {
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 6),
    child: Row(
      children: <Widget>[
        Container(
          width: 6,
          height: 14,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xFF7C4DFF), Color(0xFF448AFF)],
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333650),
          ),
        ),
      ],
    ),
  );
}

Widget _variantWrap(List<Widget> children) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: children,
  );
}

Widget _captionedCell(String caption, Widget child) {
  return Container(
    constraints: const BoxConstraints(minWidth: 96),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFE),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE6E8F1)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: child,
        ),
        const SizedBox(height: 4),
        Text(
          caption,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B6F86),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Intro Card
// ---------------------------------------------------------------------------

Widget _buildIntroCard() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF1A237E),
              Color(0xFF3949AB),
              Color(0xFF5E35B1),
            ],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x55000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.touch_app,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Material Button Types',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'A side-by-side tour of the Material 3 button family',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white24),
              ),
              child: const Text(
                'Each section below renders one button family with several '
                'variants — default, with leading icon, with custom shape, '
                'with custom color, and disabled. The closing card distills '
                'the choice into a quick decision matrix so you can pick the '
                'right call-to-action surface in seconds.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _introChip(Icons.layers, 'Elevated'),
                _introChip(Icons.format_color_fill, 'Filled'),
                _introChip(Icons.invert_colors, 'Tonal'),
                _introChip(Icons.crop_square, 'Outlined'),
                _introChip(Icons.text_fields, 'Text'),
                _introChip(Icons.radio_button_checked, 'Icon'),
                _introChip(Icons.add_circle, 'FAB'),
                _introChip(Icons.menu_open, 'Menu'),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _introChip(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white30),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — ElevatedButton
// ---------------------------------------------------------------------------

Widget _buildElevatedButtonSection() {
  final Widget defaultElevated = ElevatedButton(
    onPressed: () {},
    child: const Text('Save'),
  );
  final Widget withIcon = ElevatedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.save_alt, size: 18),
    label: const Text('Save draft'),
  );
  final Widget largeIcon = ElevatedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.cloud_upload, size: 22),
    label: const Text('Upload archive'),
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
  final Widget colored = ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF00897B),
      shadowColor: const Color(0xFF004D40),
      elevation: 6,
    ),
    child: const Text('Publish'),
  );
  final Widget pillShape = ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFFE91E63),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
    ),
    child: const Text('Subscribe'),
  );
  final Widget squareShape = ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF455A64),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
    ),
    child: const Text('Confirm'),
  );
  final Widget longPress = ElevatedButton(
    onPressed: () {},
    onLongPress: () {},
    child: const Text('Press & hold'),
  );
  final Widget disabled = ElevatedButton(
    onPressed: null,
    child: const Text('Disabled'),
  );

  return _sectionCard(
    icon: Icons.layers,
    title: 'ElevatedButton',
    subtitle: 'Container-filled, raised surface with shadow',
    headerGradient: const <Color>[Color(0xFF3F51B5), Color(0xFF5C6BC0)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('Default and with icon'),
        _variantWrap(<Widget>[
          _captionedCell('default', defaultElevated),
          _captionedCell('with icon', withIcon),
          _captionedCell('large + icon', largeIcon),
        ]),
        _variantLabel('Custom color and shape'),
        _variantWrap(<Widget>[
          _captionedCell('teal fill', colored),
          _captionedCell('pill', pillShape),
          _captionedCell('square', squareShape),
        ]),
        _variantLabel('Press behaviour'),
        _variantWrap(<Widget>[
          _captionedCell('long-press', longPress),
          _captionedCell('disabled', disabled),
        ]),
      ],
    ),
    paragraph:
        'Use ElevatedButton for the single highest-priority action on a '
        'screen — a "Save", "Submit" or "Publish" CTA that should visually '
        'lift off the surface. Prefer it over FilledButton when the rest '
        'of the surface is light or neutral, and the elevation drop shadow '
        'is the strongest available emphasis cue. Avoid using more than '
        'one ElevatedButton per visible surface; competing shadows muddy '
        'the visual hierarchy and dilute the call-to-action.',
  );
}

// ---------------------------------------------------------------------------
// Section 3 — FilledButton
// ---------------------------------------------------------------------------

Widget _buildFilledButtonSection() {
  final Widget filledDefault = FilledButton(
    onPressed: () {},
    child: const Text('Continue'),
  );
  final Widget filledIcon = FilledButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.send, size: 18),
    label: const Text('Send invite'),
  );
  final Widget filledLarge = FilledButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.lock_open, size: 22),
    label: const Text('Unlock account'),
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
  final Widget filledColor = FilledButton(
    onPressed: () {},
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFFD32F2F),
      foregroundColor: Colors.white,
    ),
    child: const Text('Delete'),
  );
  final Widget filledPill = FilledButton(
    onPressed: () {},
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFF6A1B9A),
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
    ),
    child: const Text('Get Pro'),
  );
  final Widget filledRounded = FilledButton(
    onPressed: () {},
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFF1976D2),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    child: const Text('Apply'),
  );
  final Widget filledLongPress = FilledButton(
    onPressed: () {},
    onLongPress: () {},
    child: const Text('Press & hold'),
  );
  final Widget filledDisabled = FilledButton(
    onPressed: null,
    child: const Text('Disabled'),
  );

  return _sectionCard(
    icon: Icons.format_color_fill,
    title: 'FilledButton',
    subtitle: 'Solid colour, no shadow — the new "primary" of M3',
    headerGradient: const <Color>[Color(0xFF6A1B9A), Color(0xFF8E24AA)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('Default and with icon'),
        _variantWrap(<Widget>[
          _captionedCell('default', filledDefault),
          _captionedCell('with icon', filledIcon),
          _captionedCell('large', filledLarge),
        ]),
        _variantLabel('Custom color and shape'),
        _variantWrap(<Widget>[
          _captionedCell('destructive', filledColor),
          _captionedCell('pill / pro', filledPill),
          _captionedCell('square-r4', filledRounded),
        ]),
        _variantLabel('Press behaviour'),
        _variantWrap(<Widget>[
          _captionedCell('long-press', filledLongPress),
          _captionedCell('disabled', filledDisabled),
        ]),
      ],
    ),
    paragraph:
        'FilledButton is the Material 3 successor to the classic raised '
        'button — same visual weight, no drop shadow. Use it when the '
        'surrounding surface already provides enough contrast and you want '
        'the action to read as "filled in colour, owned by the brand". '
        'Prefer FilledButton over ElevatedButton on dense screens with '
        'multiple high-priority actions; the absence of shadow keeps the '
        'composition clean while still drawing the eye through colour.',
  );
}

// ---------------------------------------------------------------------------
// Section 4 — FilledButton.tonal
// ---------------------------------------------------------------------------

Widget _buildFilledTonalSection() {
  final Widget tonalDefault = FilledButton.tonal(
    onPressed: () {},
    child: const Text('Snooze'),
  );
  final Widget tonalIcon = FilledButton.tonalIcon(
    onPressed: () {},
    icon: const Icon(Icons.schedule, size: 18),
    label: const Text('Remind me later'),
  );
  final Widget tonalColor = FilledButton.tonal(
    onPressed: () {},
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFFFFE0B2),
      foregroundColor: const Color(0xFFE65100),
    ),
    child: const Text('Review'),
  );
  final Widget tonalPill = FilledButton.tonal(
    onPressed: () {},
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFFD7CCC8),
      foregroundColor: const Color(0xFF4E342E),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    child: const Text('Maybe later'),
  );
  final Widget tonalLong = FilledButton.tonal(
    onPressed: () {},
    onLongPress: () {},
    child: const Text('Hold to confirm'),
  );
  final Widget tonalDisabled = FilledButton.tonal(
    onPressed: null,
    child: const Text('Disabled'),
  );

  return _sectionCard(
    icon: Icons.invert_colors,
    title: 'FilledButton.tonal',
    subtitle: 'Soft "secondary" container — quieter than full filled',
    headerGradient: const <Color>[Color(0xFFFF8F00), Color(0xFFFFA726)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('Default and with icon'),
        _variantWrap(<Widget>[
          _captionedCell('default', tonalDefault),
          _captionedCell('with icon', tonalIcon),
        ]),
        _variantLabel('Custom color and shape'),
        _variantWrap(<Widget>[
          _captionedCell('amber tonal', tonalColor),
          _captionedCell('pill brown', tonalPill),
        ]),
        _variantLabel('Press behaviour'),
        _variantWrap(<Widget>[
          _captionedCell('long-press', tonalLong),
          _captionedCell('disabled', tonalDisabled),
        ]),
      ],
    ),
    paragraph:
        'Use FilledButton.tonal for the second-most-important action in a '
        'pair — typically next to an ElevatedButton or FilledButton acting '
        'as the primary CTA. The lighter "tonal" container reads as '
        '"important but not the headline". Prefer it over OutlinedButton '
        'when the surface needs more visual weight than a thin border, '
        'such as in dialogs and bottom sheets where the secondary action '
        'is still expected to be tapped frequently.',
  );
}

// ---------------------------------------------------------------------------
// Section 5 — OutlinedButton
// ---------------------------------------------------------------------------

Widget _buildOutlinedButtonSection() {
  final Widget outlinedDefault = OutlinedButton(
    onPressed: () {},
    child: const Text('Cancel'),
  );
  final Widget outlinedIcon = OutlinedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.add, size: 18),
    label: const Text('Add filter'),
  );
  final Widget outlinedColor = OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF00838F),
      side: const BorderSide(color: Color(0xFF00838F), width: 1.5),
    ),
    child: const Text('Connect'),
  );
  final Widget outlinedThick = OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFFAD1457),
      side: const BorderSide(color: Color(0xFFAD1457), width: 2.4),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
    ),
    child: const Text('Verify'),
  );
  final Widget outlinedPill = OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF2E7D32),
      side: const BorderSide(color: Color(0xFF2E7D32), width: 1.5),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    child: const Text('Follow'),
  );
  final Widget outlinedDashedFeel = OutlinedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.upload_file, size: 18),
    label: const Text('Choose file'),
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF455A64),
      side: const BorderSide(color: Color(0xFF90A4AE), width: 1.2),
    ),
  );
  final Widget outlinedLongPress = OutlinedButton(
    onPressed: () {},
    onLongPress: () {},
    child: const Text('Press & hold'),
  );
  final Widget outlinedDisabled = OutlinedButton(
    onPressed: null,
    child: const Text('Disabled'),
  );

  return _sectionCard(
    icon: Icons.crop_square,
    title: 'OutlinedButton',
    subtitle: 'Bordered, transparent fill — "secondary" with low weight',
    headerGradient: const <Color>[Color(0xFF00838F), Color(0xFF26A69A)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('Default and with icon'),
        _variantWrap(<Widget>[
          _captionedCell('default', outlinedDefault),
          _captionedCell('with icon', outlinedIcon),
          _captionedCell('upload', outlinedDashedFeel),
        ]),
        _variantLabel('Custom color and shape'),
        _variantWrap(<Widget>[
          _captionedCell('cyan', outlinedColor),
          _captionedCell('thick pink', outlinedThick),
          _captionedCell('pill green', outlinedPill),
        ]),
        _variantLabel('Press behaviour'),
        _variantWrap(<Widget>[
          _captionedCell('long-press', outlinedLongPress),
          _captionedCell('disabled', outlinedDisabled),
        ]),
      ],
    ),
    paragraph:
        'OutlinedButton is the standard "Cancel" or "Decline" companion to '
        'a filled primary action. The thin border keeps it readable without '
        'shouting, which is why it pairs naturally with an ElevatedButton '
        'or FilledButton on a confirmation dialog. Prefer OutlinedButton '
        'over TextButton when the action still needs a visible target — '
        'borders raise affordance on touch screens. Avoid using thick '
        'custom borders just to make the button look "primary"; reach for '
        'FilledButton instead.',
  );
}

// ---------------------------------------------------------------------------
// Section 6 — TextButton
// ---------------------------------------------------------------------------

Widget _buildTextButtonSection() {
  final Widget textDefault = TextButton(
    onPressed: () {},
    child: const Text('Learn more'),
  );
  final Widget textIcon = TextButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.open_in_new, size: 18),
    label: const Text('Open docs'),
  );
  final Widget textColor = TextButton(
    onPressed: () {},
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFFD81B60),
    ),
    child: const Text('Forget password?'),
  );
  final Widget textBoldStyle = TextButton(
    onPressed: () {},
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF1565C0),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        letterSpacing: 0.4,
      ),
    ),
    child: const Text('SIGN IN'),
  );
  final Widget textPaddedFooter = TextButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.arrow_forward, size: 16),
    label: const Text('Read full article'),
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF6A1B9A),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    ),
  );
  final Widget textLong = TextButton(
    onPressed: () {},
    onLongPress: () {},
    child: const Text('Hold for menu'),
  );
  final Widget textDisabled = TextButton(
    onPressed: null,
    child: const Text('Disabled'),
  );

  return _sectionCard(
    icon: Icons.text_fields,
    title: 'TextButton',
    subtitle: 'No container at all — text-only affordance',
    headerGradient: const <Color>[Color(0xFFD81B60), Color(0xFFEC407A)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('Default and with icon'),
        _variantWrap(<Widget>[
          _captionedCell('default', textDefault),
          _captionedCell('with icon', textIcon),
          _captionedCell('inline link', textPaddedFooter),
        ]),
        _variantLabel('Custom color and weight'),
        _variantWrap(<Widget>[
          _captionedCell('pink link', textColor),
          _captionedCell('bold caps', textBoldStyle),
        ]),
        _variantLabel('Press behaviour'),
        _variantWrap(<Widget>[
          _captionedCell('long-press', textLong),
          _captionedCell('disabled', textDisabled),
        ]),
      ],
    ),
    paragraph:
        'Use TextButton for the lowest-emphasis action on a surface — '
        '"Learn more", "Cancel" inside a snackbar, or any tertiary navigation '
        'that should feel like a hyperlink. Prefer TextButton over '
        'OutlinedButton when the surrounding text density is high and any '
        'extra border would compete with the prose. Avoid TextButton for '
        'destructive actions — without a container they are too easy to '
        'tap by accident.',
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Icon button family
// ---------------------------------------------------------------------------

Widget _buildIconButtonFamily() {
  final Widget iconDefault = IconButton(
    onPressed: () {},
    icon: const Icon(Icons.favorite_border),
    tooltip: 'Like',
  );
  final Widget iconColored = IconButton(
    onPressed: () {},
    icon: const Icon(Icons.favorite),
    color: const Color(0xFFE53935),
    tooltip: 'Liked',
  );
  final Widget iconLarge = IconButton(
    onPressed: () {},
    icon: const Icon(Icons.notifications_active),
    iconSize: 30,
    tooltip: 'Notifications',
  );
  final Widget iconSelected = IconButton(
    onPressed: () {},
    icon: const Icon(Icons.bookmark_border),
    selectedIcon: const Icon(Icons.bookmark),
    isSelected: true,
    tooltip: 'Bookmarked',
  );
  final Widget iconDisabled = IconButton(
    onPressed: null,
    icon: const Icon(Icons.delete_outline),
    tooltip: 'Disabled',
  );
  final Widget iconStyled = IconButton(
    onPressed: () {},
    icon: const Icon(Icons.share),
    style: IconButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF7B1FA2),
      padding: const EdgeInsets.all(12),
    ),
    tooltip: 'Share',
  );

  final Widget filledIcon = IconButton.filled(
    onPressed: () {},
    icon: const Icon(Icons.play_arrow),
    tooltip: 'Play',
  );
  final Widget filledIconLarge = IconButton.filled(
    onPressed: () {},
    icon: const Icon(Icons.skip_next),
    iconSize: 28,
    tooltip: 'Next',
  );
  final Widget filledIconColor = IconButton.filled(
    onPressed: () {},
    icon: const Icon(Icons.stop),
    style: IconButton.styleFrom(
      backgroundColor: const Color(0xFFD32F2F),
      foregroundColor: Colors.white,
    ),
    tooltip: 'Stop',
  );
  final Widget filledIconDisabled = IconButton.filled(
    onPressed: null,
    icon: const Icon(Icons.fast_forward),
    tooltip: 'Disabled',
  );

  final Widget filledTonalIcon = IconButton.filledTonal(
    onPressed: () {},
    icon: const Icon(Icons.pause),
    tooltip: 'Pause',
  );
  final Widget filledTonalColor = IconButton.filledTonal(
    onPressed: () {},
    icon: const Icon(Icons.replay),
    style: IconButton.styleFrom(
      backgroundColor: const Color(0xFFC8E6C9),
      foregroundColor: const Color(0xFF1B5E20),
    ),
    tooltip: 'Replay',
  );
  final Widget filledTonalDisabled = IconButton.filledTonal(
    onPressed: null,
    icon: const Icon(Icons.shuffle),
    tooltip: 'Disabled',
  );

  final Widget outlinedIcon = IconButton.outlined(
    onPressed: () {},
    icon: const Icon(Icons.more_horiz),
    tooltip: 'More',
  );
  final Widget outlinedIconColor = IconButton.outlined(
    onPressed: () {},
    icon: const Icon(Icons.edit_outlined),
    style: IconButton.styleFrom(
      foregroundColor: const Color(0xFF1565C0),
      side: const BorderSide(color: Color(0xFF1565C0), width: 1.5),
    ),
    tooltip: 'Edit',
  );
  final Widget outlinedIconDisabled = IconButton.outlined(
    onPressed: null,
    icon: const Icon(Icons.lock_outline),
    tooltip: 'Disabled',
  );

  return _sectionCard(
    icon: Icons.radio_button_checked,
    title: 'IconButton family',
    subtitle: 'Default · filled · filledTonal · outlined',
    headerGradient: const <Color>[Color(0xFF00695C), Color(0xFF26A69A)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('IconButton (default)'),
        _variantWrap(<Widget>[
          _captionedCell('default', iconDefault),
          _captionedCell('coloured', iconColored),
          _captionedCell('large', iconLarge),
          _captionedCell('selected', iconSelected),
          _captionedCell('styled bg', iconStyled),
          _captionedCell('disabled', iconDisabled),
        ]),
        _variantLabel('IconButton.filled'),
        _variantWrap(<Widget>[
          _captionedCell('default', filledIcon),
          _captionedCell('large', filledIconLarge),
          _captionedCell('destructive', filledIconColor),
          _captionedCell('disabled', filledIconDisabled),
        ]),
        _variantLabel('IconButton.filledTonal'),
        _variantWrap(<Widget>[
          _captionedCell('default', filledTonalIcon),
          _captionedCell('green tonal', filledTonalColor),
          _captionedCell('disabled', filledTonalDisabled),
        ]),
        _variantLabel('IconButton.outlined'),
        _variantWrap(<Widget>[
          _captionedCell('default', outlinedIcon),
          _captionedCell('blue edit', outlinedIconColor),
          _captionedCell('disabled', outlinedIconDisabled),
        ]),
      ],
    ),
    paragraph:
        'IconButton ships in four flavours that mirror the four labelled '
        'button containers — default (no container), filled, filledTonal '
        'and outlined. Use the default when the icon sits inside an AppBar '
        'or toolbar where a container would clutter the row, and reach for '
        'filled when the icon is the page\'s primary affordance (a play '
        'button on a media card, for example). Filled-tonal works well as '
        'a secondary "favourite" or "save" toggle, and outlined is the '
        'right call when the icon needs an explicit border for affordance '
        'inside a busy data table.',
  );
}

// ---------------------------------------------------------------------------
// Section 8 — FloatingActionButton family
// ---------------------------------------------------------------------------

Widget _buildFabFamily() {
  final Widget fabDefault = FloatingActionButton(
    onPressed: () {},
    tooltip: 'Compose',
    child: const Icon(Icons.edit),
  );
  final Widget fabColored = FloatingActionButton(
    onPressed: () {},
    backgroundColor: const Color(0xFFFF6F00),
    foregroundColor: Colors.white,
    tooltip: 'Add note',
    child: const Icon(Icons.note_add),
  );
  final Widget fabHeroless = FloatingActionButton(
    onPressed: () {},
    heroTag: 'compose-2',
    tooltip: 'Quick action',
    child: const Icon(Icons.bolt),
  );
  final Widget fabSmall = FloatingActionButton.small(
    onPressed: () {},
    tooltip: 'Add small',
    child: const Icon(Icons.add),
  );
  final Widget fabSmallColored = FloatingActionButton.small(
    onPressed: () {},
    backgroundColor: const Color(0xFF00897B),
    foregroundColor: Colors.white,
    tooltip: 'Reply',
    child: const Icon(Icons.reply),
  );
  final Widget fabLarge = FloatingActionButton.large(
    onPressed: () {},
    tooltip: 'Capture',
    child: const Icon(Icons.camera_alt),
  );
  final Widget fabLargeColored = FloatingActionButton.large(
    onPressed: () {},
    backgroundColor: const Color(0xFF6A1B9A),
    foregroundColor: Colors.white,
    tooltip: 'Record',
    child: const Icon(Icons.fiber_manual_record),
  );
  final Widget fabExtended = FloatingActionButton.extended(
    onPressed: () {},
    icon: const Icon(Icons.add),
    label: const Text('New event'),
    tooltip: 'Create event',
  );
  final Widget fabExtendedColored = FloatingActionButton.extended(
    onPressed: () {},
    icon: const Icon(Icons.send),
    label: const Text('Send message'),
    backgroundColor: const Color(0xFF1976D2),
    foregroundColor: Colors.white,
  );
  final Widget fabExtendedLabelOnly = FloatingActionButton.extended(
    onPressed: () {},
    label: const Text('Save'),
    backgroundColor: const Color(0xFF43A047),
    foregroundColor: Colors.white,
  );
  final Widget fabShape = FloatingActionButton(
    onPressed: () {},
    tooltip: 'Square FAB',
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: const Icon(Icons.dashboard),
  );

  return _sectionCard(
    icon: Icons.add_circle,
    title: 'FloatingActionButton family',
    subtitle: 'small · regular · large · extended',
    headerGradient: const <Color>[Color(0xFFC62828), Color(0xFFEF5350)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('Regular FloatingActionButton'),
        _variantWrap(<Widget>[
          _captionedCell('default', fabDefault),
          _captionedCell('amber', fabColored),
          _captionedCell('alt heroTag', fabHeroless),
          _captionedCell('square', fabShape),
        ]),
        _variantLabel('FloatingActionButton.small'),
        _variantWrap(<Widget>[
          _captionedCell('default', fabSmall),
          _captionedCell('teal', fabSmallColored),
        ]),
        _variantLabel('FloatingActionButton.large'),
        _variantWrap(<Widget>[
          _captionedCell('default', fabLarge),
          _captionedCell('purple', fabLargeColored),
        ]),
        _variantLabel('FloatingActionButton.extended'),
        _variantWrap(<Widget>[
          _captionedCell('icon + label', fabExtended),
          _captionedCell('blue send', fabExtendedColored),
          _captionedCell('label only', fabExtendedLabelOnly),
        ]),
      ],
    ),
    paragraph:
        'A FloatingActionButton represents the single most important action '
        'on a screen — composing a new email, capturing a photo, starting '
        'a recording. Use the regular size for most cases, .small when the '
        'FAB sits inside dense scrollable content, and .large when the page '
        'is purpose-built around the action (e.g. a camera screen). Prefer '
        'FloatingActionButton.extended when the icon alone is ambiguous '
        '("add what?") and a single short verb-noun label removes the '
        'guesswork.',
  );
}

// ---------------------------------------------------------------------------
// Section 9 — MenuItemButton
// ---------------------------------------------------------------------------

Widget _buildMenuItemButtonSection() {
  final Widget menuPlain = MenuItemButton(
    onPressed: () {},
    child: const Text('Open file'),
  );
  final Widget menuLeading = MenuItemButton(
    onPressed: () {},
    leadingIcon: const Icon(Icons.content_copy, size: 18),
    child: const Text('Copy'),
  );
  final Widget menuLeadingTrailing = MenuItemButton(
    onPressed: () {},
    leadingIcon: const Icon(Icons.content_paste, size: 18),
    trailingIcon: const Icon(Icons.keyboard, size: 18),
    child: const Text('Paste'),
  );
  final Widget menuShortcut = MenuItemButton(
    onPressed: () {},
    leadingIcon: const Icon(Icons.save_outlined, size: 18),
    trailingIcon: const Text(
      'Ctrl+S',
      style: TextStyle(fontSize: 11, color: Color(0xFF666884)),
    ),
    child: const Text('Save'),
  );
  final Widget menuDestructive = MenuItemButton(
    onPressed: () {},
    leadingIcon: const Icon(
      Icons.delete_outline,
      size: 18,
      color: Color(0xFFD32F2F),
    ),
    style: MenuItemButton.styleFrom(
      foregroundColor: const Color(0xFFD32F2F),
    ),
    child: const Text('Delete'),
  );
  final Widget menuDisabled = MenuItemButton(
    onPressed: null,
    leadingIcon: const Icon(Icons.print, size: 18),
    child: const Text('Print (disabled)'),
  );

  final Widget menuColumn = Container(
    width: 240,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE0E3EE)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        menuPlain,
        menuLeading,
        menuLeadingTrailing,
        menuShortcut,
        const Divider(height: 1, indent: 12, endIndent: 12),
        menuDestructive,
        menuDisabled,
      ],
    ),
  );

  return _sectionCard(
    icon: Icons.menu_open,
    title: 'MenuItemButton',
    subtitle: 'Single row inside a Material 3 menu',
    headerGradient: const <Color>[Color(0xFF455A64), Color(0xFF607D8B)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('Mocked menu column'),
        Center(child: menuColumn),
        _variantLabel('Variants in isolation'),
        _variantWrap(<Widget>[
          _captionedCell('plain', menuPlain),
          _captionedCell('leading', menuLeading),
          _captionedCell('lead+trail', menuLeadingTrailing),
          _captionedCell('shortcut', menuShortcut),
          _captionedCell('destructive', menuDestructive),
          _captionedCell('disabled', menuDisabled),
        ]),
      ],
    ),
    paragraph:
        'MenuItemButton is the row primitive used by MenuBar, MenuAnchor and '
        'context menus. Its anatomy is leadingIcon · label · trailingIcon, '
        'where the trailing slot conventionally holds a keyboard shortcut '
        'or a chevron pointing to a submenu. Use it inside a Material 3 '
        'menu surface; reach for ListTile when you need similar spacing '
        'inside a regular ListView. Prefer placing the destructive item '
        'after a Divider so destructive taps require a deliberate scroll.',
  );
}

// ---------------------------------------------------------------------------
// Section 10 — BackButton, CloseButton, DropdownButton
// ---------------------------------------------------------------------------

Widget _buildBackAndCloseButtons() {
  final Widget backDefault = const BackButton();
  final Widget backColored = BackButton(
    color: const Color(0xFF1565C0),
    onPressed: () {},
  );
  final Widget closeDefault = const CloseButton();
  final Widget closeColored = CloseButton(
    color: const Color(0xFFC62828),
    onPressed: () {},
  );

  final Widget mockedAppBar = Container(
    height: 56,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[Color(0xFF512DA8), Color(0xFF7E57C2)],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      children: <Widget>[
        IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: BackButton(onPressed: () {}),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'Detail screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.white),
          tooltip: 'Search',
        ),
        IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: CloseButton(onPressed: () {}),
        ),
      ],
    ),
  );

  final Widget mockedDialogHeader = Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFFE0B2)),
    ),
    padding: const EdgeInsets.fromLTRB(16, 10, 6, 10),
    child: Row(
      children: <Widget>[
        const Icon(Icons.warning_amber, color: Color(0xFFE65100)),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Discard unsaved changes?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4E342E),
            ),
          ),
        ),
        CloseButton(onPressed: () {}, color: const Color(0xFFE65100)),
      ],
    ),
  );

  final Widget dropdown = DropdownButton<String>(
    value: 'Recent',
    onChanged: (String? value) {},
    items: const <DropdownMenuItem<String>>[
      DropdownMenuItem<String>(value: 'Recent', child: Text('Recent')),
      DropdownMenuItem<String>(value: 'Oldest', child: Text('Oldest')),
      DropdownMenuItem<String>(value: 'A-Z', child: Text('A-Z')),
      DropdownMenuItem<String>(value: 'Z-A', child: Text('Z-A')),
    ],
  );

  final Widget dropdownIcon = DropdownButton<String>(
    value: 'Grid',
    icon: const Icon(Icons.expand_more, color: Color(0xFF1565C0)),
    underline: Container(height: 2, color: const Color(0xFF1565C0)),
    onChanged: (String? value) {},
    items: const <DropdownMenuItem<String>>[
      DropdownMenuItem<String>(
        value: 'Grid',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.grid_view, size: 16, color: Color(0xFF1565C0)),
            SizedBox(width: 6),
            Text('Grid'),
          ],
        ),
      ),
      DropdownMenuItem<String>(
        value: 'List',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.view_list, size: 16, color: Color(0xFF1565C0)),
            SizedBox(width: 6),
            Text('List'),
          ],
        ),
      ),
      DropdownMenuItem<String>(
        value: 'Cards',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.view_agenda, size: 16, color: Color(0xFF1565C0)),
            SizedBox(width: 6),
            Text('Cards'),
          ],
        ),
      ),
    ],
  );

  return _sectionCard(
    icon: Icons.arrow_back,
    title: 'Back, Close & Dropdown',
    subtitle: 'Navigation glyphs and a brief DropdownButton tour',
    headerGradient: const <Color>[Color(0xFF512DA8), Color(0xFF7E57C2)],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _variantLabel('BackButton & CloseButton, isolated'),
        _variantWrap(<Widget>[
          _captionedCell('back default', backDefault),
          _captionedCell('back blue', backColored),
          _captionedCell('close default', closeDefault),
          _captionedCell('close red', closeColored),
        ]),
        _variantLabel('Inside a mocked AppBar'),
        mockedAppBar,
        _variantLabel('Inside a mocked dialog header'),
        mockedDialogHeader,
        _variantLabel('DropdownButton (brief)'),
        _variantWrap(<Widget>[
          _captionedCell('plain', dropdown),
          _captionedCell('icon + underline', dropdownIcon),
        ]),
      ],
    ),
    paragraph:
        'BackButton and CloseButton are thin convenience wrappers around '
        'IconButton that respect the platform-specific glyph and the '
        'localized tooltip ("Back" on Android, "Cancel" on iOS-like surfaces). '
        'Use BackButton when the user is navigating up a stack, and '
        'CloseButton when the user is dismissing a transient surface like '
        'a dialog or full-screen sheet. DropdownButton is the legacy '
        'value-picker affordance — for new Material 3 surfaces, prefer '
        'DropdownMenu, but DropdownButton remains the right call when a '
        'compact, inline picker is enough.',
  );
}

// ---------------------------------------------------------------------------
// Section 11 — Selection guide / decision matrix
// ---------------------------------------------------------------------------

Widget _buildSelectionGuide() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _gradientHeader(
            icon: Icons.account_tree,
            title: 'Selection guide',
            subtitle: 'Pick the right button in 30 seconds',
            gradient: const <Color>[Color(0xFF263238), Color(0xFF455A64)],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _variantLabel('Decision matrix'),
                _decisionMatrix(),
                _variantLabel('Pairing examples'),
                _pairingExamples(),
                _variantLabel('Anti-patterns to avoid'),
                _antiPatterns(),
                const SizedBox(height: 12),
                _paragraph(
                  'When in doubt, follow the rule of one: a single '
                  'screen should host exactly one "headline" action — '
                  'an ElevatedButton, FilledButton or FAB. Every other '
                  'button on the screen should drop a tier in emphasis '
                  '(filled tonal, outlined, text). Keeping that '
                  'hierarchy intact is what makes a screen feel '
                  'considered rather than busy, and it is the single '
                  'most common Material-design mistake to fix in code '
                  'review.',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _decisionMatrix() {
  final List<List<String>> rows = <List<String>>[
    <String>['Type', 'Emphasis', 'Container', 'Use it for'],
    <String>['ElevatedButton', 'High', 'Filled + shadow', 'Single primary CTA'],
    <String>['FilledButton', 'High', 'Filled, no shadow', 'Primary on dense screens'],
    <String>['FilledButton.tonal', 'Medium', 'Tonal fill', 'Secondary, still tappable'],
    <String>['OutlinedButton', 'Medium-low', 'Border only', 'Cancel / decline'],
    <String>['TextButton', 'Low', 'No container', 'Tertiary / link-like'],
    <String>['IconButton', 'Variable', 'Optional', 'Compact toolbar action'],
    <String>['FAB', 'Highest', 'Circular fill', 'Hero action of the screen'],
    <String>['MenuItemButton', 'N/A', 'Menu row', 'Inside a Material menu'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE0E3EE)),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: <Widget>[
        _matrixHeader(rows[0]),
        _matrixRow(rows[1], const Color(0xFFF7F8FC)),
        _matrixRow(rows[2], Colors.white),
        _matrixRow(rows[3], const Color(0xFFF7F8FC)),
        _matrixRow(rows[4], Colors.white),
        _matrixRow(rows[5], const Color(0xFFF7F8FC)),
        _matrixRow(rows[6], Colors.white),
        _matrixRow(rows[7], const Color(0xFFF7F8FC)),
        _matrixRow(rows[8], Colors.white),
      ],
    ),
  );
}

Widget _matrixHeader(List<String> cells) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF263238), Color(0xFF37474F)],
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      children: <Widget>[
        Expanded(flex: 3, child: _matrixCellText(cells[0], header: true)),
        Expanded(flex: 2, child: _matrixCellText(cells[1], header: true)),
        Expanded(flex: 3, child: _matrixCellText(cells[2], header: true)),
        Expanded(flex: 4, child: _matrixCellText(cells[3], header: true)),
      ],
    ),
  );
}

Widget _matrixRow(List<String> cells, Color background) {
  return Container(
    color: background,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      children: <Widget>[
        Expanded(flex: 3, child: _matrixCellText(cells[0])),
        Expanded(flex: 2, child: _matrixCellText(cells[1])),
        Expanded(flex: 3, child: _matrixCellText(cells[2])),
        Expanded(flex: 4, child: _matrixCellText(cells[3])),
      ],
    ),
  );
}

Widget _matrixCellText(String text, {bool header = false}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: header ? 12 : 12.5,
      color: header ? Colors.white : const Color(0xFF333650),
      fontWeight: header ? FontWeight.bold : FontWeight.w500,
      letterSpacing: header ? 0.4 : 0,
    ),
  );
}

Widget _pairingExamples() {
  final Widget primaryWithCancel = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFBBDEFB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Confirm + Cancel pair',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {},
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () {},
              child: const Text('Confirm'),
            ),
          ],
        ),
      ],
    ),
  );

  final Widget destructiveWithCancel = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFEBEE), Color(0xFFFFFFFF)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFFCDD2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Destructive + Cancel pair',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        ),
      ],
    ),
  );

  final Widget tertiaryRow = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE8F5E9), Color(0xFFFFFFFF)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFC8E6C9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Onboarding: primary + tertiary',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text('Skip'),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text('Next'),
            ),
          ],
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      primaryWithCancel,
      const SizedBox(height: 10),
      destructiveWithCancel,
      const SizedBox(height: 10),
      tertiaryRow,
    ],
  );
}

Widget _antiPatterns() {
  return Column(
    children: <Widget>[
      _antiRow(
        Icons.error_outline,
        const Color(0xFFC62828),
        'Two ElevatedButtons fighting for attention',
        'If both look "primary", neither is. Drop the second tier.',
      ),
      _antiRow(
        Icons.layers_clear,
        const Color(0xFFEF6C00),
        'Custom thick borders to fake a primary OutlinedButton',
        'Reach for FilledButton instead — that\'s the role you want.',
      ),
      _antiRow(
        Icons.flash_off,
        const Color(0xFF6A1B9A),
        'TextButton used for a destructive action',
        'No container = no affordance. At least use OutlinedButton.',
      ),
      _antiRow(
        Icons.disabled_by_default,
        const Color(0xFF455A64),
        'Disabling a button instead of explaining "why"',
        'Pair the disabled state with a tooltip or helper text.',
      ),
    ],
  );
}

Widget _antiRow(IconData icon, Color color, String title, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF333650),
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

// ---------------------------------------------------------------------------
// Entrypoint
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'ButtonTypes Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: Scaffold(
      appBar: AppBar(title: const Text('Material Button Types')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildIntroCard(),
          _buildElevatedButtonSection(),
          _buildFilledButtonSection(),
          _buildFilledTonalSection(),
          _buildOutlinedButtonSection(),
          _buildTextButtonSection(),
          _buildIconButtonFamily(),
          _buildFabFamily(),
          _buildMenuItemButtonSection(),
          _buildBackAndCloseButtons(),
          _buildSelectionGuide(),
        ],
      ),
    ),
  );
}
