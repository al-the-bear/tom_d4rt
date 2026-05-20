// D4rt test script: Deep Demo - DropdownButtonFormField<T> from Material
// Comprehensive visual tour of every parameter family on
// DropdownButtonFormField, with comparative spotlights on DropdownButton,
// DropdownMenu and DropdownMenuFormField. Rendered via SendTestRunner.
//
// Sections:
//   1.  Cover & key facts
//   2.  Anatomy diagram (label / chevron / menu / underline)
//   3.  items + DropdownMenuItem gallery
//   4.  InputDecoration spectrum (border, fill, prefix/suffix, helper, error)
//   5.  validator + autovalidateMode showcase
//   6.  onChanged / onSaved (no-op forms safe for d4rt)
//   7.  value, hint, disabledHint, enabled states
//   8.  isExpanded vs intrinsic width
//   9.  isDense vs spacious
//   10. icon / iconSize / iconEnabledColor / iconDisabledColor
//   11. focusNode + autofocus indicator
//   12. dropdownColor + menuMaxHeight
//   13. enableFeedback + alignment + borderRadius + padding
//   14. Sister widgets: DropdownButton, DropdownMenu, DropdownMenuFormField
//   15. Real-world booking form (country / currency / timezone / cabin)
//   16. Closing card with cheat sheet
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ===========================================================================
// PALETTE & TYPOGRAPHY HELPERS
// ===========================================================================

const Color kInk = Color(0xFF101728);
const Color kInkSoft = Color(0xFF334155);
const Color kInkMute = Color(0xFF64748B);
const Color kPaper = Color(0xFFF8FAFC);
const Color kCard = Color(0xFFFFFFFF);
const Color kAccent = Color(0xFF4338CA);
const Color kAccentSoft = Color(0xFFC7D2FE);
const Color kHighlight = Color(0xFFF59E0B);
const Color kSuccess = Color(0xFF059669);
const Color kDanger = Color(0xFFDC2626);
const Color kLavender = Color(0xFFEDE9FE);
const Color kMint = Color(0xFFD1FAE5);
const Color kRose = Color(0xFFFFE4E6);
const Color kSky = Color(0xFFE0F2FE);
const Color kPeach = Color(0xFFFFEDD5);

TextStyle _heading(double size, {Color color = kInk, FontWeight weight = FontWeight.w800}) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: -0.4,
    height: 1.15,
  );
}

TextStyle _mono(double size, {Color color = kInkSoft}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: 'monospace',
    height: 1.4,
  );
}

TextStyle _body(double size, {Color color = kInkSoft, FontWeight weight = FontWeight.w400}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: 1.4,
  );
}

// ===========================================================================
// REUSABLE LAYOUT PRIMITIVES
// ===========================================================================

Widget _sectionDivider(int index, String title, String subtitle, Color tint) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 32, 0, 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[tint, kPaper],
      ),
      border: Border.all(color: tint, width: 1.5),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kInk,
            borderRadius: BorderRadius.circular(16),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kInk.withValues(alpha: 0.2),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            index.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _heading(20)),
              const SizedBox(height: 4),
              Text(subtitle, style: _body(13, color: kInkMute)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({
  required String title,
  required String subtitle,
  required Widget body,
  Color? accent,
  List<String> tags = const <String>[],
  String? footer,
}) {
  final Color trim = accent ?? kAccentSoft;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: kCard,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: trim, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInk.withValues(alpha: 0.05),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  color: trim,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: _heading(15, weight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: _body(12, color: kInkMute)),
                  ],
                ),
              ),
            ],
          ),
          if (tags.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags
                  .map((String t) => _chip(t, trim))
                  .toList(growable: false),
            ),
          ],
          const SizedBox(height: 14),
          body,
          if (footer != null) ...<Widget>[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPaper,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: trim.withValues(alpha: 0.6)),
              ),
              child: Text(footer, style: _mono(11)),
            ),
          ],
        ],
      ),
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: kInk.withValues(alpha: 0.75),
      ),
    ),
  );
}

Widget _calloutBanner({
  required IconData icon,
  required String title,
  required String body,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      border: Border(left: BorderSide(color: color, width: 4)),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(body, style: _body(12, color: kInkSoft)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// CONTENT DATA STRUCTURES
// ===========================================================================

class FormOption {
  const FormOption(this.value, this.label, this.icon, this.tint);
  final String value;
  final String label;
  final IconData icon;
  final Color tint;
}

const List<FormOption> _animalOptions = <FormOption>[
  FormOption('fox', 'Arctic fox', Icons.pets, Color(0xFF60A5FA)),
  FormOption('owl', 'Snowy owl', Icons.nightlight_round, Color(0xFFA78BFA)),
  FormOption('whale', 'Beluga whale', Icons.water, Color(0xFF38BDF8)),
  FormOption('bear', 'Polar bear', Icons.ac_unit, Color(0xFF94A3B8)),
];

const List<FormOption> _planetOptions = <FormOption>[
  FormOption('mercury', 'Mercury', Icons.brightness_high, Color(0xFFFB923C)),
  FormOption('venus', 'Venus', Icons.local_florist, Color(0xFFFBBF24)),
  FormOption('earth', 'Earth', Icons.public, Color(0xFF22C55E)),
  FormOption('mars', 'Mars', Icons.terrain, Color(0xFFEF4444)),
];

const List<FormOption> _toolOptions = <FormOption>[
  FormOption('hammer', 'Hammer', Icons.handyman, Color(0xFF64748B)),
  FormOption('wrench', 'Wrench', Icons.build, Color(0xFF0EA5E9)),
  FormOption('screw', 'Screwdriver', Icons.settings, Color(0xFFA855F7)),
  FormOption('saw', 'Hand saw', Icons.precision_manufacturing, Color(0xFFF97316)),
];

const List<String> _countries = <String>[
  'Switzerland',
  'Japan',
  'Iceland',
  'New Zealand',
  'Portugal',
];

const List<String> _currencies = <String>[
  'CHF', 'JPY', 'ISK', 'NZD', 'EUR',
];

const List<String> _timezones = <String>[
  'UTC+0',
  'UTC+1',
  'UTC+2',
  'UTC+9',
  'UTC-5',
];

const List<String> _cabinClasses = <String>[
  'Economy', 'Premium', 'Business', 'First',
];

// ===========================================================================
// DROPDOWN BUILDERS
// ===========================================================================

List<DropdownMenuItem<String>> _basicItems(List<FormOption> options) {
  return options
      .map(
        (FormOption o) => DropdownMenuItem<String>(
          value: o.value,
          child: Row(
            children: <Widget>[
              Icon(o.icon, color: o.tint, size: 18),
              const SizedBox(width: 8),
              Text(o.label),
            ],
          ),
        ),
      )
      .toList(growable: false);
}

List<DropdownMenuItem<String>> _textOnlyItems(List<String> values) {
  return values
      .map(
        (String v) => DropdownMenuItem<String>(
          value: v,
          child: Text(v),
        ),
      )
      .toList(growable: false);
}

// ===========================================================================
// COVER & HEADER
// ===========================================================================

Widget _coverCard() {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1E1B4B), Color(0xFF4338CA), Color(0xFF7C3AED)],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccent.withValues(alpha: 0.35),
          blurRadius: 22,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'flutter • material',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down_circle, color: Colors.white, size: 28),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'DropdownButtonFormField<T>',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'A FormField wrapper around DropdownButton that integrates with\n'
          'Form, FormState, validators, autovalidateMode and onSaved.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.86),
            fontSize: 14,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _coverPill('items', Icons.list),
            _coverPill('decoration', Icons.layers),
            _coverPill('validator', Icons.check_circle_outline),
            _coverPill('onSaved', Icons.save_outlined),
            _coverPill('autovalidate', Icons.auto_mode),
            _coverPill('hint', Icons.lightbulb_outline),
            _coverPill('disabledHint', Icons.lock_outline),
            _coverPill('isExpanded', Icons.unfold_more),
            _coverPill('isDense', Icons.density_small),
            _coverPill('icon', Icons.expand_more),
            _coverPill('iconSize', Icons.swap_vert),
            _coverPill('iconEnabledColor', Icons.palette),
            _coverPill('iconDisabledColor', Icons.contrast),
            _coverPill('focusNode', Icons.center_focus_strong),
            _coverPill('autofocus', Icons.start),
            _coverPill('dropdownColor', Icons.format_color_fill),
            _coverPill('menuMaxHeight', Icons.height),
            _coverPill('enableFeedback', Icons.vibration),
            _coverPill('alignment', Icons.align_horizontal_center),
            _coverPill('borderRadius', Icons.rounded_corner),
            _coverPill('padding', Icons.padding),
          ],
        ),
      ],
    ),
  );
}

Widget _coverPill(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// ANATOMY DIAGRAM
// ===========================================================================

Widget _anatomyDiagram() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: kCard,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: kAccentSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Anatomy', style: _heading(18)),
        const SizedBox(height: 4),
        Text(
          'Visual breakdown of the parts you can theme via DropdownButtonFormField.',
          style: _body(12, color: kInkMute),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kPaper,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kAccentSoft),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _anatomyLabel('label', 'InputDecoration.labelText', kAccent),
                    const SizedBox(height: 6),
                    _anatomyLabel('prefix', 'InputDecoration.prefixIcon', kSky),
                    const SizedBox(height: 6),
                    _anatomyLabel('value/hint', 'value, hint, disabledHint', kHighlight),
                    const SizedBox(height: 6),
                    _anatomyLabel('chevron', 'icon, iconSize, iconEnabledColor', kSuccess),
                    const SizedBox(height: 6),
                    _anatomyLabel('border', 'InputDecoration.border / borderRadius', kDanger),
                    const SizedBox(height: 6),
                    _anatomyLabel('menu', 'dropdownColor, menuMaxHeight', kAccent),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: _fakeDropdownPreview()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyLabel(String name, String code, Color color) {
  return Row(
    children: <Widget>[
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 8),
      Text(name, style: _body(12, color: kInk, weight: FontWeight.w700)),
      const SizedBox(width: 6),
      Expanded(
        child: Text(
          code,
          style: _mono(11, color: kInkMute),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

Widget _fakeDropdownPreview() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kDanger, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Country',
          style: TextStyle(fontSize: 11, color: kAccent, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Icon(Icons.public, color: kSky, size: 18),
            const SizedBox(width: 8),
            Text('Switzerland', style: _body(14, color: kInk)),
            const Spacer(),
            Icon(Icons.expand_more, color: kSuccess, size: 22),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          color: kInkMute.withValues(alpha: 0.2),
        ),
        const SizedBox(height: 8),
        Text(
          'Menu opens with dropdownColor /\nmenuMaxHeight constraints.',
          style: _body(10, color: kInkMute),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION BUILDERS
// ===========================================================================

Widget _buildSection01() {
  // ITEMS gallery
  final Widget basic = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'fox',
      items: _basicItems(_animalOptions),
      decoration: const InputDecoration(
        labelText: 'Arctic species',
        border: OutlineInputBorder(),
      ),
      onChanged: (_) {},
    ),
  );

  final Widget complexItems = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'earth',
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Planet (rich items)',
        border: OutlineInputBorder(),
      ),
      items: _planetOptions
          .map(
            (FormOption o) => DropdownMenuItem<String>(
              value: o.value,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: o.tint.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(o.icon, color: o.tint, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            o.label,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'id: ${o.value}',
                            style: _mono(10, color: kInkMute),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(growable: false),
      onChanged: (_) {},
    ),
  );

  final Widget intItems = Form(
    child: DropdownButtonFormField<int>(
      initialValue: 3,
      decoration: const InputDecoration(
        labelText: 'Priority (typed int)',
        border: OutlineInputBorder(),
      ),
      items: List<DropdownMenuItem<int>>.generate(
        5,
        (int i) => DropdownMenuItem<int>(
          value: i + 1,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 10,
                backgroundColor: Color.lerp(kSuccess, kDanger, i / 4)!,
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const SizedBox(width: 10),
              Text('Level ${i + 1}'),
            ],
          ),
        ),
      ),
      onChanged: (_) {},
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(1, 'items + DropdownMenuItem<T>',
          'The list of selectable rows. T is inferred from items.value.', kLavender),
      _card(
        title: 'Basic items with icon + label',
        subtitle: 'List<DropdownMenuItem<String>>',
        body: basic,
        tags: const <String>['items', 'DropdownMenuItem'],
        accent: kAccentSoft,
        footer: 'items: _basicItems(_animalOptions)',
      ),
      _card(
        title: 'Complex items with two-line layout',
        subtitle: 'Items may contain arbitrary widget subtrees',
        body: complexItems,
        tags: const <String>['items', 'isExpanded'],
        accent: kMint,
        footer: 'DropdownMenuItem(value:..., child: Row(Column(...)))',
      ),
      _card(
        title: 'Typed items (List.generate avoids closure capture)',
        subtitle: 'DropdownButtonFormField<int>',
        body: intItems,
        tags: const <String>['items', 'List.generate'],
        accent: kPeach,
        footer: 'List.generate(5, (i) => DropdownMenuItem<int>(value: i+1, ...))',
      ),
    ],
  );
}

Widget _buildSection02() {
  final Widget filled = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'wrench',
      decoration: InputDecoration(
        labelText: 'Tool',
        helperText: 'Used to repair workbench items.',
        prefixIcon: const Icon(Icons.construction),
        filled: true,
        fillColor: kSky,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      items: _basicItems(_toolOptions),
      onChanged: (_) {},
    ),
  );

  final Widget outlined = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'fox',
      decoration: const InputDecoration(
        labelText: 'Sighting',
        hintText: 'Pick an animal you saw today',
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.bookmark_outline),
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      items: _basicItems(_animalOptions),
      onChanged: (_) {},
    ),
  );

  final Widget errorState = Form(
    child: DropdownButtonFormField<String>(
      initialValue: null,
      decoration: const InputDecoration(
        labelText: 'Mandatory',
        errorText: 'Please select a value',
        prefixIcon: Icon(Icons.error_outline),
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  final Widget underline = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'mars',
      decoration: const InputDecoration(
        labelText: 'Underline only',
        prefixIcon: Icon(Icons.straighten),
      ),
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(2, 'InputDecoration spectrum',
          'Borders, fill, prefix/suffix, helpers and error states.', kSky),
      _card(
        title: 'Filled + rounded border',
        subtitle: 'fillColor + borderRadius',
        body: filled,
        accent: kSky,
        tags: const <String>['filled', 'fillColor', 'borderRadius'],
      ),
      _card(
        title: 'Outlined + prefix + suffix',
        subtitle: 'Pinned floating label, prefix + suffix icons',
        body: outlined,
        accent: kLavender,
        tags: const <String>['prefixIcon', 'suffixIcon', 'floatingLabelBehavior'],
      ),
      _card(
        title: 'Error decoration',
        subtitle: 'errorText is rendered below the dropdown',
        body: errorState,
        accent: kRose,
        tags: const <String>['errorText'],
      ),
      _card(
        title: 'Underline-only (default)',
        subtitle: 'No outline border, just the implicit underline',
        body: underline,
        accent: kPeach,
        tags: const <String>['no-border', 'default'],
      ),
    ],
  );
}

Widget _buildSection03() {
  final Widget validatorDemo = Form(
    autovalidateMode: AutovalidateMode.always,
    child: DropdownButtonFormField<String>(
      initialValue: null,
      autovalidateMode: AutovalidateMode.always,
      decoration: const InputDecoration(
        labelText: 'Required choice',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_animalOptions),
      validator: (String? value) {
        if (value == null) {
          return 'Please pick a creature.';
        }
        if (value == 'bear') {
          return 'No polar bears in the lobby.';
        }
        return null;
      },
      onChanged: (_) {},
    ),
  );

  final Widget interactionDemo = Form(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: DropdownButtonFormField<String>(
      initialValue: null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        labelText: 'Validates after interaction',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_toolOptions),
      validator: (String? value) => value == null ? 'pick one' : null,
      onChanged: (_) {},
    ),
  );

  final Widget disabledDemo = Form(
    child: DropdownButtonFormField<String>(
      initialValue: null,
      autovalidateMode: AutovalidateMode.disabled,
      decoration: const InputDecoration(
        labelText: 'Validation disabled',
        helperText: 'Validator only runs on submit',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_planetOptions),
      validator: (String? value) => 'never visible here',
      onChanged: (_) {},
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(3, 'validator + autovalidateMode',
          'How errors surface and when the validator is invoked.', kRose),
      _calloutBanner(
        icon: Icons.info_outline,
        title: 'AutovalidateMode',
        body:
            'always: validate on every rebuild · onUserInteraction: only after the\n'
            'user changes the value · disabled: only via form.validate().',
        color: kAccent,
      ),
      const SizedBox(height: 12),
      _card(
        title: 'AutovalidateMode.always',
        subtitle: 'Errors render immediately on first build',
        body: validatorDemo,
        accent: kRose,
        tags: const <String>['validator', 'autovalidateMode'],
        footer: 'validator: (v) => v == null ? "Please pick..." : null',
      ),
      _card(
        title: 'AutovalidateMode.onUserInteraction',
        subtitle: 'Pristine: no error. After change: validate.',
        body: interactionDemo,
        accent: kLavender,
        tags: const <String>['onUserInteraction'],
      ),
      _card(
        title: 'AutovalidateMode.disabled',
        subtitle: 'Validator never runs implicitly',
        body: disabledDemo,
        accent: kMint,
        tags: const <String>['disabled'],
      ),
    ],
  );
}

Widget _buildSection04() {
  final Widget onChangedDemo = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'venus',
      decoration: const InputDecoration(
        labelText: 'onChanged (no-op)',
        helperText: 'Receives the new value; we ignore it for d4rt.',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  final Widget onSavedDemo = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'hammer',
      decoration: const InputDecoration(
        labelText: 'onSaved (form.save)',
        helperText: 'Called when the enclosing Form.save() runs.',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_toolOptions),
      onSaved: (_) {},
      onChanged: (_) {},
    ),
  );

  final Widget disabledOnChanged = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'bear',
      decoration: const InputDecoration(
        labelText: 'Disabled (onChanged: null)',
        helperText: 'Setting onChanged: null disables the field.',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_animalOptions),
      onChanged: null,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(4, 'onChanged & onSaved',
          'Callback patterns that play well with stateless d4rt rendering.', kMint),
      _card(
        title: 'onChanged: (_) {}',
        subtitle: 'Interactivity rendered; callback is a no-op',
        body: onChangedDemo,
        accent: kMint,
        tags: const <String>['onChanged', 'no-op'],
      ),
      _card(
        title: 'onSaved: (_) {}',
        subtitle: 'Invoked from Form.save() only',
        body: onSavedDemo,
        accent: kLavender,
        tags: const <String>['onSaved', 'Form.save'],
      ),
      _card(
        title: 'onChanged: null → disabled',
        subtitle: 'The chevron greys out; menu is unreachable',
        body: disabledOnChanged,
        accent: kRose,
        tags: const <String>['onChanged: null', 'disabled'],
      ),
    ],
  );
}

Widget _buildSection05() {
  final Widget valueDemo = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'earth',
      decoration: const InputDecoration(
        labelText: 'Preselected value',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  final Widget hintDemo = Form(
    child: DropdownButtonFormField<String>(
      initialValue: null,
      hint: const Text('Choose a planet'),
      decoration: const InputDecoration(
        labelText: 'Hint shown when value is null',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  final Widget disabledHintDemo = Form(
    child: DropdownButtonFormField<String>(
      initialValue: null,
      hint: const Text('Pick a tool'),
      disabledHint: const Text('No tools available'),
      decoration: const InputDecoration(
        labelText: 'disabledHint',
        border: OutlineInputBorder(),
      ),
      items: const <DropdownMenuItem<String>>[],
      onChanged: null,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(5, 'value / hint / disabledHint',
          'Three ways to communicate the current state to the user.', kPeach),
      _card(
        title: 'value',
        subtitle: 'Must match exactly one item.value',
        body: valueDemo,
        accent: kPeach,
        tags: const <String>['value'],
      ),
      _card(
        title: 'hint (value == null)',
        subtitle: 'Renders in muted style as a placeholder',
        body: hintDemo,
        accent: kSky,
        tags: const <String>['hint', 'placeholder'],
      ),
      _card(
        title: 'disabledHint (disabled + null value)',
        subtitle: 'Wins over hint when the field is disabled',
        body: disabledHintDemo,
        accent: kRose,
        tags: const <String>['disabledHint'],
      ),
    ],
  );
}

Widget _buildSection06() {
  final Widget expanded = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'fox',
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'isExpanded: true (fills parent)',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_animalOptions),
      onChanged: (_) {},
    ),
  );

  final Widget intrinsic = Form(
    child: Row(
      children: <Widget>[
        DropdownButtonFormField<String>(
          initialValue: 'mars',
          decoration: const InputDecoration(
            labelText: 'intrinsic',
            border: OutlineInputBorder(),
          ),
          items: _basicItems(_planetOptions),
          onChanged: (_) {},
        ),
        const Spacer(),
      ],
    ),
  );

  final Widget dense = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'wrench',
      isDense: true,
      decoration: const InputDecoration(
        labelText: 'isDense: true',
        helperText: 'Compact vertical rhythm',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_toolOptions),
      onChanged: (_) {},
    ),
  );

  final Widget spacious = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'wrench',
      decoration: const InputDecoration(
        labelText: 'isDense: false (default)',
        helperText: 'Generous spacing',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_toolOptions),
      onChanged: (_) {},
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(6, 'Layout: isExpanded vs isDense',
          'Controls horizontal stretching and vertical compactness.', kAccentSoft),
      _card(
        title: 'isExpanded: true',
        subtitle: 'Fills the available horizontal space',
        body: expanded,
        accent: kAccentSoft,
        tags: const <String>['isExpanded'],
      ),
      _card(
        title: 'isExpanded: false (default)',
        subtitle: 'Sized to widest item; extra space trails after it',
        body: intrinsic,
        accent: kLavender,
        tags: const <String>['intrinsic'],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _card(
              title: 'isDense: true',
              subtitle: 'Compact',
              body: dense,
              accent: kMint,
              tags: const <String>['isDense: true'],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _card(
              title: 'isDense: false',
              subtitle: 'Spacious',
              body: spacious,
              accent: kPeach,
              tags: const <String>['isDense: false'],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildSection07() {
  final Widget customIcon = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'mars',
      decoration: const InputDecoration(
        labelText: 'icon: Icons.arrow_drop_down_circle',
        border: OutlineInputBorder(),
      ),
      icon: const Icon(Icons.arrow_drop_down_circle),
      iconSize: 28,
      iconEnabledColor: kAccent,
      iconDisabledColor: kInkMute,
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  final Widget bigIcon = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'fox',
      decoration: const InputDecoration(
        labelText: 'iconSize: 36',
        border: OutlineInputBorder(),
      ),
      icon: const Icon(Icons.expand_circle_down),
      iconSize: 36,
      iconEnabledColor: kHighlight,
      items: _basicItems(_animalOptions),
      onChanged: (_) {},
    ),
  );

  final Widget disabledIcon = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'hammer',
      decoration: const InputDecoration(
        labelText: 'iconDisabledColor (disabled)',
        border: OutlineInputBorder(),
      ),
      icon: const Icon(Icons.expand_more),
      iconSize: 28,
      iconEnabledColor: kSuccess,
      iconDisabledColor: kDanger,
      items: _basicItems(_toolOptions),
      onChanged: null,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(7, 'Chevron: icon / iconSize / iconColor',
          'Theme the drop-down indicator itself.', kSuccess.withValues(alpha: 0.25)),
      _card(
        title: 'Custom icon + iconEnabledColor',
        subtitle: 'icon, iconSize, iconEnabledColor',
        body: customIcon,
        accent: kAccentSoft,
        tags: const <String>['icon', 'iconSize', 'iconEnabledColor'],
      ),
      _card(
        title: 'Oversized chevron',
        subtitle: 'iconSize: 36, accent color',
        body: bigIcon,
        accent: kPeach,
        tags: const <String>['iconSize'],
      ),
      _card(
        title: 'iconDisabledColor',
        subtitle: 'Visible only when onChanged is null',
        body: disabledIcon,
        accent: kRose,
        tags: const <String>['iconDisabledColor', 'disabled'],
      ),
    ],
  );
}

Widget _buildSection08() {
  final FocusNode focusNode = FocusNode(debugLabel: 'demoFocus');

  final Widget focusDemo = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'fox',
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: 'focusNode',
        helperText: 'Attach a FocusNode to read or move focus.',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_animalOptions),
      onChanged: (_) {},
    ),
  );

  final Widget autofocusDemo = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'mars',
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'autofocus: true',
        helperText: 'Receives focus when first inserted into the tree.',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(8, 'focusNode & autofocus',
          'Keyboard / a11y plumbing for the field.', kAccentSoft),
      _card(
        title: 'focusNode',
        subtitle: 'External FocusNode injected into the dropdown',
        body: focusDemo,
        accent: kAccentSoft,
        tags: const <String>['focusNode'],
        footer: 'final FocusNode focusNode = FocusNode(debugLabel: "demoFocus");',
      ),
      _card(
        title: 'autofocus',
        subtitle: 'Self-requests focus on mount',
        body: autofocusDemo,
        accent: kLavender,
        tags: const <String>['autofocus'],
      ),
    ],
  );
}

Widget _buildSection09() {
  final Widget palette = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'fox',
      dropdownColor: kLavender,
      decoration: const InputDecoration(
        labelText: 'dropdownColor: lavender',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_animalOptions),
      onChanged: (_) {},
    ),
  );

  final Widget maxHeight = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'a',
      menuMaxHeight: 200,
      decoration: const InputDecoration(
        labelText: 'menuMaxHeight: 200',
        helperText: 'Many items, but menu capped to 200 logical pixels.',
        border: OutlineInputBorder(),
      ),
      items: List<DropdownMenuItem<String>>.generate(
        26,
        (int i) {
          final String letter = String.fromCharCode(65 + i);
          return DropdownMenuItem<String>(
            value: letter.toLowerCase(),
            child: Text('Letter $letter'),
          );
        },
      ),
      onChanged: (_) {},
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(9, 'Menu: dropdownColor / menuMaxHeight',
          'Restyle the popped surface and cap its scroll extent.', kHighlight.withValues(alpha: 0.25)),
      _card(
        title: 'dropdownColor',
        subtitle: 'Background colour for the opened menu',
        body: palette,
        accent: kLavender,
        tags: const <String>['dropdownColor'],
      ),
      _card(
        title: 'menuMaxHeight (26 items)',
        subtitle: 'Caps the menu height; scroll within',
        body: maxHeight,
        accent: kPeach,
        tags: const <String>['menuMaxHeight', 'scroll'],
        footer: 'List.generate(26, (i) => DropdownMenuItem(...))',
      ),
    ],
  );
}

Widget _buildSection10() {
  final Widget feedback = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'hammer',
      enableFeedback: true,
      decoration: const InputDecoration(
        labelText: 'enableFeedback: true',
        helperText: 'Click / haptic feedback enabled (default).',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_toolOptions),
      onChanged: (_) {},
    ),
  );

  final Widget feedbackOff = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'hammer',
      enableFeedback: false,
      decoration: const InputDecoration(
        labelText: 'enableFeedback: false',
        helperText: 'No haptic; silent tap.',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_toolOptions),
      onChanged: (_) {},
    ),
  );

  final Widget alignmentStart = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'fox',
      alignment: AlignmentDirectional.centerStart,
      decoration: const InputDecoration(
        labelText: 'alignment: centerStart',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_animalOptions),
      onChanged: (_) {},
    ),
  );

  final Widget alignmentCenter = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'fox',
      isExpanded: true,
      alignment: AlignmentDirectional.center,
      decoration: const InputDecoration(
        labelText: 'alignment: center',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_animalOptions),
      onChanged: (_) {},
    ),
  );

  final Widget borderRadius = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'venus',
      borderRadius: BorderRadius.circular(20),
      decoration: const InputDecoration(
        labelText: 'borderRadius: 20',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  final Widget padding = Form(
    child: DropdownButtonFormField<String>(
      initialValue: 'venus',
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const InputDecoration(
        labelText: 'padding (around child)',
        border: OutlineInputBorder(),
      ),
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(10, 'Polish: feedback / alignment / radius / padding',
          'The fine-tuning knobs at the bottom of the constructor.',
          kSuccess.withValues(alpha: 0.25)),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _card(
              title: 'enableFeedback: true',
              subtitle: 'Default',
              body: feedback,
              accent: kMint,
              tags: const <String>['enableFeedback'],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _card(
              title: 'enableFeedback: false',
              subtitle: 'Silent tap',
              body: feedbackOff,
              accent: kRose,
              tags: const <String>['silent'],
            ),
          ),
        ],
      ),
      _card(
        title: 'alignment: centerStart',
        subtitle: 'Default alignment of the selected child',
        body: alignmentStart,
        accent: kAccentSoft,
        tags: const <String>['alignment'],
      ),
      _card(
        title: 'alignment: center',
        subtitle: 'Centers the selected child horizontally',
        body: alignmentCenter,
        accent: kLavender,
        tags: const <String>['alignment', 'center'],
      ),
      _card(
        title: 'borderRadius',
        subtitle: 'Rounds the menu corners (and InputBorder)',
        body: borderRadius,
        accent: kPeach,
        tags: const <String>['borderRadius'],
      ),
      _card(
        title: 'padding',
        subtitle: 'Inset around the selected child',
        body: padding,
        accent: kSky,
        tags: const <String>['padding'],
      ),
    ],
  );
}

Widget _buildSection11() {
  // Sister widgets contrast
  final Widget rawButton = DropdownButton<String>(
    value: 'fox',
    items: _basicItems(_animalOptions),
    onChanged: (_) {},
  );

  final Widget rawHide = DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      value: 'mars',
      items: _basicItems(_planetOptions),
      onChanged: (_) {},
    ),
  );

  final Widget m3Menu = DropdownMenu<String>(
    initialSelection: 'wrench',
    label: const Text('DropdownMenu (M3)'),
    dropdownMenuEntries: _toolOptions
        .map(
          (FormOption o) => DropdownMenuEntry<String>(
            value: o.value,
            label: o.label,
            leadingIcon: Icon(o.icon, color: o.tint),
          ),
        )
        .toList(growable: false),
  );

  final Widget m3FormMenu = Form(
    child: DropdownMenuFormField<String>(
      initialSelection: 'fox',
      requestFocusOnTap: true,
      label: const Text('DropdownMenuFormField'),
      dropdownMenuEntries: _animalOptions
          .map(
            (FormOption o) => DropdownMenuEntry<String>(
              value: o.value,
              label: o.label,
              leadingIcon: Icon(o.icon, color: o.tint),
            ),
          )
          .toList(growable: false),
      validator: (String? v) => v == null ? 'pick one' : null,
      onSaved: (_) {},
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionDivider(11, 'Sister widgets',
          'How DropdownButton, DropdownMenu and DropdownMenuFormField compare.',
          kAccentSoft),
      _card(
        title: 'DropdownButton<T>',
        subtitle: 'Material 2 base, no InputDecoration / FormField',
        body: rawButton,
        accent: kAccentSoft,
        tags: const <String>['Material 2', 'no Form integration'],
      ),
      _card(
        title: 'DropdownButtonHideUnderline',
        subtitle: 'Hides the underline beneath a DropdownButton',
        body: rawHide,
        accent: kLavender,
        tags: const <String>['hide underline'],
      ),
      _card(
        title: 'DropdownMenu<T> (Material 3)',
        subtitle: 'Filter-as-you-type, leading icons, no FormField wrapper',
        body: m3Menu,
        accent: kMint,
        tags: const <String>['Material 3', 'filter'],
      ),
      _card(
        title: 'DropdownMenuFormField<T>',
        subtitle: 'M3 menu + FormField behaviour (validate / save)',
        body: m3FormMenu,
        accent: kPeach,
        tags: const <String>['Material 3', 'FormField'],
      ),
    ],
  );
}

// ===========================================================================
// REAL-WORLD BOOKING FLOW
// ===========================================================================

Widget _buildBookingForm() {
  return Container(
    margin: const EdgeInsets.only(top: 32),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: kCard,
      border: Border.all(color: kAccentSoft, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccent.withValues(alpha: 0.08),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kAccent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.flight_takeoff, color: kAccent),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Real-world example', style: _heading(20)),
                  const SizedBox(height: 4),
                  Text(
                    'Itinerary builder using four DropdownButtonFormField instances',
                    style: _body(12, color: kInkMute),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _bookingRow(
                left: DropdownButtonFormField<String>(
                  initialValue: _countries.first,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    prefixIcon: Icon(Icons.public),
                    border: OutlineInputBorder(),
                  ),
                  items: _textOnlyItems(_countries),
                  validator: (String? v) =>
                      v == null ? 'Country required' : null,
                  onChanged: (_) {},
                ),
                right: DropdownButtonFormField<String>(
                  initialValue: _currencies.first,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Currency',
                    prefixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(),
                  ),
                  items: _textOnlyItems(_currencies),
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(height: 16),
              _bookingRow(
                left: DropdownButtonFormField<String>(
                  initialValue: _timezones[0],
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Timezone',
                    prefixIcon: Icon(Icons.schedule),
                    border: OutlineInputBorder(),
                  ),
                  items: _textOnlyItems(_timezones),
                  onChanged: (_) {},
                ),
                right: DropdownButtonFormField<String>(
                  initialValue: _cabinClasses[2],
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(16),
                  decoration: const InputDecoration(
                    labelText: 'Cabin class',
                    prefixIcon: Icon(Icons.airline_seat_recline_extra),
                    border: OutlineInputBorder(),
                  ),
                  items: _textOnlyItems(_cabinClasses),
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: 'wrench',
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Travel kit',
                  helperText: 'Tools packed for the trip',
                  border: OutlineInputBorder(),
                ),
                items: _basicItems(_toolOptions),
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                initialValue: 2,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Passengers',
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(),
                ),
                items: List<DropdownMenuItem<int>>.generate(
                  6,
                  (int i) => DropdownMenuItem<int>(
                    value: i + 1,
                    child: Text('${i + 1} passenger${i == 0 ? '' : 's'}'),
                  ),
                ),
                onChanged: (_) {},
              ),
              const SizedBox(height: 22),
              _summary(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _bookingRow({required Widget left, required Widget right}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: left),
      const SizedBox(width: 14),
      Expanded(child: right),
    ],
  );
}

Widget _summary() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFEF3C7), Color(0xFFFFE4E6)],
      ),
      border: Border.all(color: kHighlight.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.summarize, color: kHighlight),
            const SizedBox(width: 8),
            Text(
              'Booking summary',
              style: _heading(15, color: kInk),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _summaryRow('Country', 'Switzerland'),
        _summaryRow('Currency', 'CHF'),
        _summaryRow('Timezone', 'UTC+0'),
        _summaryRow('Cabin', 'Business'),
        _summaryRow('Kit', 'Wrench'),
        _summaryRow('Passengers', '2'),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: kAccent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'Confirm booking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _summaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: _body(12, color: kInkSoft, weight: FontWeight.w600),
          ),
        ),
        Text(value, style: _mono(12)),
      ],
    ),
  );
}

// ===========================================================================
// CHEAT SHEET FOOTER
// ===========================================================================

Widget _cheatSheet() {
  final List<List<String>> rows = <List<String>>[
    <String>['items', 'Required. List<DropdownMenuItem<T>>.'],
    <String>['value', 'Selected value. Must match exactly one item.value or be null.'],
    <String>['hint', 'Shown when value == null and the field is enabled.'],
    <String>['disabledHint', 'Shown when disabled and value == null.'],
    <String>['onChanged', 'New-value callback. null = disabled.'],
    <String>['onSaved', 'Called from Form.save().'],
    <String>['validator', 'Returns String? error or null. Drives errorText.'],
    <String>['autovalidateMode', 'always · onUserInteraction · disabled.'],
    <String>['decoration', 'InputDecoration: border, fill, prefix/suffix, helper, error.'],
    <String>['isExpanded', 'Fills the horizontal space available.'],
    <String>['isDense', 'Compact vertical layout.'],
    <String>['icon / iconSize', 'Trailing chevron and its size.'],
    <String>['iconEnabledColor', 'Chevron tint when field is enabled.'],
    <String>['iconDisabledColor', 'Chevron tint when field is disabled.'],
    <String>['focusNode', 'External FocusNode to drive focus.'],
    <String>['autofocus', 'Requests focus on first mount.'],
    <String>['dropdownColor', 'Background color of the opened menu.'],
    <String>['menuMaxHeight', 'Cap on the menu height.'],
    <String>['enableFeedback', 'Haptic + click feedback toggle.'],
    <String>['alignment', 'Where the selected child sits inside the field.'],
    <String>['borderRadius', 'Radius applied to the opened menu surface.'],
    <String>['padding', 'Inset around the selected child.'],
  ];

  return Container(
    margin: const EdgeInsets.only(top: 28),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: kInk,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.menu_book, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Cheat sheet',
              style: _heading(18, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...rows.map(
          (List<String> r) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 160,
                  child: Text(
                    r[0],
                    style: TextStyle(
                      color: kAccentSoft,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    r[1],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.functions, color: kAccentSoft, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'random sanity: ${(math.Random(7).nextDouble() * 100).toStringAsFixed(2)}'
                  ' — confirms dart:math import is exercised at script load.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'monospace',
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

// ===========================================================================
// BUILD ENTRY POINT
// ===========================================================================

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kPaper,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _coverCard(),
            const SizedBox(height: 22),
            _anatomyDiagram(),
            _buildSection01(),
            _buildSection02(),
            _buildSection03(),
            _buildSection04(),
            _buildSection05(),
            _buildSection06(),
            _buildSection07(),
            _buildSection08(),
            _buildSection09(),
            _buildSection10(),
            _buildSection11(),
            _buildBookingForm(),
            _cheatSheet(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
