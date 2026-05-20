// D4rt test script: Deep Demo - Material Form Controls Family
// Comprehensive visual gallery of Form, FormField, TextFormField,
// DropdownButtonFormField, Checkbox, CheckboxListTile, Radio, RadioListTile,
// Switch, SwitchListTile, Slider, RangeSlider, InputDecoration, validators
// and AutovalidateMode, ending in a complete realistic booking form.
import 'dart:math' as math;
import 'package:flutter/material.dart';

// ============================================================================
// COLOR PALETTE
// ============================================================================
// Centralized palette so the gallery has a consistent visual language. Each
// section reuses these accents to avoid clashing tones.
const Color kPaletteIndigoDeep = Color(0xFF1A237E);
const Color kPaletteIndigo = Color(0xFF3949AB);
const Color kPaletteIndigoSoft = Color(0xFFC5CAE9);
const Color kPaletteIndigoSurface = Color(0xFFE8EAF6);
const Color kPaletteTeal = Color(0xFF00796B);
const Color kPaletteTealSoft = Color(0xFFB2DFDB);
const Color kPaletteTealSurface = Color(0xFFE0F2F1);
const Color kPaletteAmber = Color(0xFFEF6C00);
const Color kPaletteAmberSoft = Color(0xFFFFE0B2);
const Color kPaletteAmberSurface = Color(0xFFFFF3E0);
const Color kPalettePink = Color(0xFFC2185B);
const Color kPalettePinkSoft = Color(0xFFF8BBD0);
const Color kPalettePinkSurface = Color(0xFFFCE4EC);
const Color kPaletteGreen = Color(0xFF2E7D32);
const Color kPaletteGreenSoft = Color(0xFFC8E6C9);
const Color kPaletteGreenSurface = Color(0xFFE8F5E9);
const Color kPaletteBlueGrey = Color(0xFF455A64);
const Color kPaletteSlate = Color(0xFF263238);
const Color kPaletteCloud = Color(0xFFECEFF1);
const Color kPaletteSnow = Color(0xFFFAFAFA);
const Color kPaletteWhite = Color(0xFFFFFFFF);
const Color kPaletteInk = Color(0xFF212121);
const Color kPaletteMuted = Color(0xFF607D8B);

// ============================================================================
// SECTION DATA RECORDS
// ============================================================================
// Pre-computed data tables used across visual sections. Keeping them as plain
// records keeps the build() body declarative and analyzer-friendly.
class GalleryEntry {
  final String name;
  final String detail;
  final String tag;
  final Color accent;
  const GalleryEntry({
    required this.name,
    required this.detail,
    required this.tag,
    required this.accent,
  });
}

class ValidationCase {
  final String label;
  final String input;
  final String? error;
  final bool valid;
  const ValidationCase({
    required this.label,
    required this.input,
    required this.error,
    required this.valid,
  });
}

class AutovalidateRow {
  final AutovalidateMode mode;
  final String headline;
  final String detail;
  const AutovalidateRow({
    required this.mode,
    required this.headline,
    required this.detail,
  });
}

class DropdownOption {
  final String value;
  final String label;
  final IconData icon;
  const DropdownOption({
    required this.value,
    required this.label,
    required this.icon,
  });
}

// ============================================================================
// CUSTOM FORM FIELD SUBCLASS
// ============================================================================
// A custom FormField<int> renders as a row of selectable star icons. It shows
// the canonical recipe for extending FormField: forward state via the builder
// callback, expose validator + initialValue, and update via state.didChange.
class StarRatingFormField extends FormField<int> {
  StarRatingFormField({
    super.key,
    required String label,
    int initialValue = 0,
    super.validator,
    super.autovalidateMode,
    super.onSaved,
  }) : super(
         initialValue: initialValue,
         builder: (FormFieldState<int> state) {
           final int rating = state.value ?? 0;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Text(
                 label,
                 style: const TextStyle(
                   fontSize: 13.0,
                   fontWeight: FontWeight.w600,
                   color: kPaletteSlate,
                 ),
               ),
               const SizedBox(height: 6.0),
               Row(
                 children: List<Widget>.generate(5, (int i) {
                   final bool filled = i < rating;
                   return Padding(
                     padding: const EdgeInsets.only(right: 4.0),
                     child: Icon(
                       filled ? Icons.star_rounded : Icons.star_border_rounded,
                       color: filled ? kPaletteAmber : kPaletteMuted,
                       size: 28.0,
                     ),
                   );
                 }),
               ),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 4.0),
                   child: Text(
                     state.errorText ?? '',
                     style: const TextStyle(
                       color: kPalettePink,
                       fontSize: 12.0,
                     ),
                   ),
                 ),
             ],
           );
         },
       );
}

// A second custom FormField that exposes a color swatch picker. Demonstrates
// non-textual FormField composition with a non-primitive value type.
class ColorSwatchFormField extends FormField<Color> {
  ColorSwatchFormField({
    super.key,
    required String label,
    required List<Color> options,
    Color? initialValue,
    super.validator,
    super.autovalidateMode,
  }) : super(
         initialValue: initialValue ?? options.first,
         builder: (FormFieldState<Color> state) {
           final Color current = state.value ?? options.first;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Text(
                 label,
                 style: const TextStyle(
                   fontSize: 13.0,
                   fontWeight: FontWeight.w600,
                   color: kPaletteSlate,
                 ),
               ),
               const SizedBox(height: 6.0),
               Wrap(
                 spacing: 8.0,
                 runSpacing: 8.0,
                 children: options.map((Color option) {
                   final bool selected = option.toARGB32() == current.toARGB32();
                   return Container(
                     width: 32.0,
                     height: 32.0,
                     decoration: BoxDecoration(
                       color: option,
                       borderRadius: BorderRadius.circular(8.0),
                       border: Border.all(
                         color: selected ? kPaletteInk : kPaletteCloud,
                         width: selected ? 3.0 : 1.0,
                       ),
                     ),
                   );
                 }).toList(),
               ),
             ],
           );
         },
       );
}

// ============================================================================
// SMALL VISUAL HELPERS
// ============================================================================
// Pure widget builders that compose into the section grid. Keeping them as
// top-level functions makes the build() flow read top to bottom.
Widget _sectionShell({
  required String title,
  required String subtitle,
  required Color surface,
  required Color border,
  required Color titleColor,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12.5, color: kPaletteBlueGrey),
        ),
        const SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

Widget _captionRow(String left, String right) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          left,
          style: const TextStyle(
            fontSize: 12.0,
            color: kPaletteMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          right,
          style: const TextStyle(
            fontSize: 12.0,
            color: kPaletteInk,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _tagPill(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: kPaletteWhite,
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _galleryCard({
  required GalleryEntry entry,
  required Widget control,
}) {
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(14.0),
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    decoration: BoxDecoration(
      color: kPaletteWhite,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kPaletteCloud, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                entry.name,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: kPaletteInk,
                ),
              ),
            ),
            _tagPill(entry.tag, entry.accent),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          entry.detail,
          style: const TextStyle(fontSize: 11.5, color: kPaletteBlueGrey),
        ),
        const SizedBox(height: 12.0),
        Align(alignment: Alignment.centerLeft, child: control),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  // ==========================================================================
  // SECTION 0: SHARED DATA TABLES
  // ==========================================================================
  // Validators reused across the gallery. They return null on success and a
  // human message on failure — exactly the contract the Form machinery expects.
  String? requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? minLengthValidator(int minimum, String? value) {
    if (value == null || value.length < minimum) {
      return 'Min $minimum characters';
    }
    return null;
  }

  String? digitsValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    final RegExp digits = RegExp(r'^[0-9]+$');
    if (!digits.hasMatch(value)) {
      return 'Digits only';
    }
    return null;
  }

  String? rangeValidator(int low, int high, String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    final int? parsed = int.tryParse(value);
    if (parsed == null) {
      return 'Not a number';
    }
    if (parsed < low || parsed > high) {
      return 'Must be $low..$high';
    }
    return null;
  }

  // Static option tables. These never change during a build() pass, so they
  // are perfectly safe inside an interpreted script — no shared mutable state.
  const List<DropdownOption> destinationOptions = <DropdownOption>[
    DropdownOption(
      value: 'tokyo',
      label: 'Tokyo, Japan',
      icon: Icons.location_city,
    ),
    DropdownOption(
      value: 'lisbon',
      label: 'Lisbon, Portugal',
      icon: Icons.beach_access,
    ),
    DropdownOption(
      value: 'reykjavik',
      label: 'Reykjavik, Iceland',
      icon: Icons.ac_unit,
    ),
    DropdownOption(
      value: 'capetown',
      label: 'Cape Town, South Africa',
      icon: Icons.terrain,
    ),
    DropdownOption(
      value: 'montreal',
      label: 'Montreal, Canada',
      icon: Icons.park,
    ),
  ];

  const List<DropdownOption> cabinOptions = <DropdownOption>[
    DropdownOption(
      value: 'economy',
      label: 'Economy',
      icon: Icons.airline_seat_recline_normal,
    ),
    DropdownOption(
      value: 'premium',
      label: 'Premium Economy',
      icon: Icons.airline_seat_recline_extra,
    ),
    DropdownOption(
      value: 'business',
      label: 'Business',
      icon: Icons.business_center,
    ),
    DropdownOption(
      value: 'first',
      label: 'First Class',
      icon: Icons.workspace_premium,
    ),
  ];

  // Validation case tables visualize the validator contract without mutation.
  const List<ValidationCase> emailCases = <ValidationCase>[
    ValidationCase(
      label: 'empty',
      input: '',
      error: 'Required',
      valid: false,
    ),
    ValidationCase(
      label: 'no at',
      input: 'noatsign.com',
      error: 'Enter a valid email',
      valid: false,
    ),
    ValidationCase(
      label: 'no dot',
      input: 'name@host',
      error: 'Enter a valid email',
      valid: false,
    ),
    ValidationCase(
      label: 'valid',
      input: 'alex@tom.dev',
      error: null,
      valid: true,
    ),
    ValidationCase(
      label: 'unicode',
      input: 'jürgen@bücher.de',
      error: null,
      valid: true,
    ),
  ];

  const List<ValidationCase> passwordCases = <ValidationCase>[
    ValidationCase(
      label: 'too short',
      input: 'abc',
      error: 'Min 8 characters',
      valid: false,
    ),
    ValidationCase(
      label: 'exactly 8',
      input: 'abcdefgh',
      error: null,
      valid: true,
    ),
    ValidationCase(
      label: 'long',
      input: 'correcthorsebatterystaple',
      error: null,
      valid: true,
    ),
  ];

  const List<ValidationCase> ageCases = <ValidationCase>[
    ValidationCase(
      label: 'empty',
      input: '',
      error: 'Required',
      valid: false,
    ),
    ValidationCase(
      label: 'text',
      input: 'twelve',
      error: 'Not a number',
      valid: false,
    ),
    ValidationCase(
      label: 'too low',
      input: '4',
      error: 'Must be 13..120',
      valid: false,
    ),
    ValidationCase(
      label: 'too high',
      input: '500',
      error: 'Must be 13..120',
      valid: false,
    ),
    ValidationCase(
      label: 'okay',
      input: '32',
      error: null,
      valid: true,
    ),
  ];

  const List<AutovalidateRow> autovalidateRows = <AutovalidateRow>[
    AutovalidateRow(
      mode: AutovalidateMode.disabled,
      headline: 'AutovalidateMode.disabled',
      detail:
          'Validators only fire when Form.validate() or FormState.save() is called explicitly.',
    ),
    AutovalidateRow(
      mode: AutovalidateMode.always,
      headline: 'AutovalidateMode.always',
      detail:
          'Each rebuild revalidates every field, even before the user types. Use sparingly.',
    ),
    AutovalidateRow(
      mode: AutovalidateMode.onUserInteraction,
      headline: 'AutovalidateMode.onUserInteraction',
      detail:
          'Fields start clean; validation begins after the first interaction. The friendliest default.',
    ),
    AutovalidateRow(
      mode: AutovalidateMode.onUnfocus,
      headline: 'AutovalidateMode.onUnfocus',
      detail:
          'Validation defers until the field loses focus, useful for slow checks.',
    ),
  ];

  // Pre-computed enumeration rows for the AutovalidateMode demo.
  final List<Map<String, Object>> autovalidateIndexed =
      autovalidateRows.asMap().entries.map((MapEntry<int, AutovalidateRow> e) {
    return <String, Object>{
      'index': e.key,
      'headline': e.value.headline,
      'detail': e.value.detail,
      'name': e.value.mode.name,
    };
  }).toList();

  // ==========================================================================
  // SECTION 1: HEADER + TABLE OF CONTENTS
  // ==========================================================================
  // The header sets the visual tone for the rest of the document. The TOC
  // gives a quick map of what the demo covers.
  const List<String> tableOfContents = <String>[
    '1. TextFormField gallery',
    '2. InputDecoration showcase',
    '3. DropdownButtonFormField',
    '4. Checkbox & CheckboxListTile',
    '5. Radio & RadioListTile',
    '6. Switch & SwitchListTile',
    '7. Slider & RangeSlider',
    '8. Validators & error patterns',
    '9. AutovalidateMode states',
    '10. Custom FormField subclasses',
    '11. Complete booking form',
  ];

  final Widget header = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kPaletteIndigoDeep, kPaletteIndigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(
                Icons.dynamic_form_rounded,
                color: kPaletteWhite,
                size: 32.0,
              ),
            ),
            const SizedBox(width: 16.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Material Form Controls',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: kPaletteWhite,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Form, FormField, validators, AutovalidateMode',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFFC5CAE9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _tagPill('TextFormField', kPaletteTeal),
            _tagPill('Dropdown', kPalettePink),
            _tagPill('Checkbox', kPaletteAmber),
            _tagPill('Radio', kPaletteGreen),
            _tagPill('Switch', kPaletteBlueGrey),
            _tagPill('Slider', kPaletteIndigo),
          ],
        ),
      ],
    ),
  );

  final Widget tocBox = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kPaletteSnow,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kPaletteCloud, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.menu_book_rounded, color: kPaletteIndigo, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Table of Contents',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: kPaletteIndigoDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        ...tableOfContents.map((String entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '•  ',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: kPaletteIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    entry,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: kPaletteInk,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2: TEXTFORMFIELD GALLERY
  // ==========================================================================
  // Six TextFormField presets demonstrating the most common configurations.
  // Each lives in a gallery card with a short caption.
  final TextFormField textFieldPlain = TextFormField(
    initialValue: 'Plain text',
    decoration: const InputDecoration(
      labelText: 'Name',
      hintText: 'Your full name',
    ),
    onChanged: (_) {},
  );

  final TextFormField textFieldEmail = TextFormField(
    initialValue: 'alex@tom.dev',
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      labelText: 'Email',
      prefixIcon: Icon(Icons.mail_outline),
      border: OutlineInputBorder(),
    ),
    validator: emailValidator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onChanged: (_) {},
  );

  final TextFormField textFieldPassword = TextFormField(
    initialValue: 'correct-horse-battery',
    obscureText: true,
    decoration: const InputDecoration(
      labelText: 'Password',
      prefixIcon: Icon(Icons.lock_outline),
      suffixIcon: Icon(Icons.visibility_off_outlined),
      border: OutlineInputBorder(),
    ),
    onChanged: (_) {},
  );

  final TextFormField textFieldMulti = TextFormField(
    initialValue:
        'A short note that wraps across multiple lines to demonstrate the multiline configuration.',
    maxLines: 3,
    decoration: const InputDecoration(
      labelText: 'Notes',
      alignLabelWithHint: true,
      border: OutlineInputBorder(),
    ),
    onChanged: (_) {},
  );

  final TextFormField textFieldNumber = TextFormField(
    initialValue: '42',
    keyboardType: TextInputType.number,
    decoration: const InputDecoration(
      labelText: 'Quantity',
      prefixText: '#',
      border: OutlineInputBorder(),
    ),
    validator: digitsValidator,
    onChanged: (_) {},
  );

  final TextFormField textFieldHelper = TextFormField(
    initialValue: 'tom-dev',
    decoration: const InputDecoration(
      labelText: 'Handle',
      helperText: 'Lowercase letters, digits, and dashes',
      prefixText: '@',
      counterText: '7 / 24',
      border: UnderlineInputBorder(),
    ),
    onChanged: (_) {},
  );

  final Widget textFieldGallery = _sectionShell(
    title: '1. TextFormField gallery',
    subtitle:
        'The Material text input field, configured for the common shapes: plain, email, password, multiline, numeric, and helper-text styles.',
    surface: kPaletteIndigoSurface,
    border: kPaletteIndigoSoft,
    titleColor: kPaletteIndigoDeep,
    child: Wrap(
      children: <Widget>[
        _galleryCard(
          entry: const GalleryEntry(
            name: 'Plain',
            detail: 'Just a labelText + hintText, default underline border.',
            tag: 'basic',
            accent: kPaletteIndigo,
          ),
          control: SizedBox(width: 190.0, child: textFieldPlain),
        ),
        _galleryCard(
          entry: const GalleryEntry(
            name: 'Email',
            detail: 'Outlined border, prefix icon, live email validation.',
            tag: 'email',
            accent: kPaletteTeal,
          ),
          control: SizedBox(width: 190.0, child: textFieldEmail),
        ),
        _galleryCard(
          entry: const GalleryEntry(
            name: 'Password',
            detail: 'obscureText with leading lock and trailing toggle.',
            tag: 'secure',
            accent: kPalettePink,
          ),
          control: SizedBox(width: 190.0, child: textFieldPassword),
        ),
        _galleryCard(
          entry: const GalleryEntry(
            name: 'Multiline',
            detail: 'maxLines=3 with alignLabelWithHint for natural editing.',
            tag: 'multi',
            accent: kPaletteAmber,
          ),
          control: SizedBox(width: 190.0, child: textFieldMulti),
        ),
        _galleryCard(
          entry: const GalleryEntry(
            name: 'Numeric',
            detail: 'Digits-only validator and a prefixText marker.',
            tag: 'number',
            accent: kPaletteGreen,
          ),
          control: SizedBox(width: 190.0, child: textFieldNumber),
        ),
        _galleryCard(
          entry: const GalleryEntry(
            name: 'Helper + counter',
            detail: 'Helper text, counter, prefix and underline border.',
            tag: 'helper',
            accent: kPaletteBlueGrey,
          ),
          control: SizedBox(width: 190.0, child: textFieldHelper),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 3: INPUTDECORATION SHOWCASE
  // ==========================================================================
  // InputDecoration is the most important piece of polish a form gets. The
  // showcase walks through the most expressive options.
  final InputDecoration decorOutlined = InputDecoration(
    labelText: 'Outlined',
    hintText: 'rounded outline border',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: kPaletteIndigo, width: 1.4),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: kPaletteIndigoSoft, width: 1.2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: kPaletteIndigoDeep, width: 2.0),
    ),
    prefixIcon: const Icon(Icons.tag_outlined),
  );

  final InputDecoration decorFilled = InputDecoration(
    labelText: 'Filled',
    hintText: 'soft filled background',
    filled: true,
    fillColor: kPaletteTealSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    prefixIcon: const Icon(Icons.search, color: kPaletteTeal),
  );

  final InputDecoration decorError = InputDecoration(
    labelText: 'With error',
    hintText: 'shows the error treatment',
    errorText: 'Must be a valid value',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    prefixIcon: const Icon(Icons.error_outline, color: kPalettePink),
  );

  final InputDecoration decorIcons = InputDecoration(
    labelText: 'Icons',
    hintText: 'leading icon outside, trailing suffixIcon',
    icon: const Icon(Icons.public, color: kPaletteIndigoDeep),
    suffixIcon: const Icon(Icons.cancel_outlined),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
  );

  final InputDecoration decorPrefixSuffix = InputDecoration(
    labelText: 'Currency',
    hintText: '0.00',
    prefixText: 'US\$ ',
    suffixText: 'USD',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
  );

  final InputDecoration decorDense = InputDecoration(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 8.0,
    ),
    labelText: 'Dense',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
  );

  final List<MapEntry<String, InputDecoration>> decorationTour =
      <MapEntry<String, InputDecoration>>[
    MapEntry<String, InputDecoration>('Outlined', decorOutlined),
    MapEntry<String, InputDecoration>('Filled', decorFilled),
    MapEntry<String, InputDecoration>('Error', decorError),
    MapEntry<String, InputDecoration>('Icons', decorIcons),
    MapEntry<String, InputDecoration>('Prefix / suffix', decorPrefixSuffix),
    MapEntry<String, InputDecoration>('Dense', decorDense),
  ];

  final Widget decorationSection = _sectionShell(
    title: '2. InputDecoration showcase',
    subtitle:
        'A walk through the dial that controls how every Material text input looks: borders, icons, fills, and density.',
    surface: kPaletteTealSurface,
    border: kPaletteTealSoft,
    titleColor: kPaletteTeal,
    child: Column(
      children: decorationTour.map((MapEntry<String, InputDecoration> entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: kPaletteWhite,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: kPaletteCloud, width: 1.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 130.0,
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: kPaletteTeal,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: 'sample',
                    decoration: entry.value,
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );

  // ==========================================================================
  // SECTION 4: DROPDOWNBUTTONFORMFIELD
  // ==========================================================================
  // Two dropdowns: a destination picker with icons + labels, and a cabin class
  // picker rendered with a different shape and color treatment.
  final DropdownButtonFormField<String> destinationDropdown =
      DropdownButtonFormField<String>(
        initialValue: 'tokyo',
        decoration: InputDecoration(
          labelText: 'Destination',
          prefixIcon: const Icon(Icons.flight_takeoff),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: destinationOptions.map((DropdownOption option) {
          return DropdownMenuItem<String>(
            value: option.value,
            child: Row(
              children: <Widget>[
                Icon(option.icon, size: 18.0, color: kPaletteIndigo),
                const SizedBox(width: 8.0),
                Text(option.label),
              ],
            ),
          );
        }).toList(),
        validator: (String? value) =>
            value == null ? 'Pick a destination' : null,
        onChanged: (_) {},
      );

  final DropdownButtonFormField<String> cabinDropdown =
      DropdownButtonFormField<String>(
        initialValue: 'premium',
        decoration: InputDecoration(
          labelText: 'Cabin class',
          filled: true,
          fillColor: kPalettePinkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
        items: cabinOptions.map((DropdownOption option) {
          return DropdownMenuItem<String>(
            value: option.value,
            child: Row(
              children: <Widget>[
                Icon(option.icon, size: 18.0, color: kPalettePink),
                const SizedBox(width: 8.0),
                Text(option.label),
              ],
            ),
          );
        }).toList(),
        onChanged: (_) {},
      );

  final DropdownButtonFormField<int> partySize =
      DropdownButtonFormField<int>(
        initialValue: 2,
        decoration: const InputDecoration(
          labelText: 'Party size',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.group_outlined),
        ),
        items: List<DropdownMenuItem<int>>.generate(
          8,
          (int i) => DropdownMenuItem<int>(
            value: i + 1,
            child: Text('${i + 1} traveler${i == 0 ? '' : 's'}'),
          ),
        ),
        onChanged: (_) {},
      );

  final Widget dropdownSection = _sectionShell(
    title: '3. DropdownButtonFormField',
    subtitle:
        'Dropdowns are FormFields too — they participate in validators, save, and reset just like text inputs.',
    surface: kPalettePinkSurface,
    border: kPalettePinkSoft,
    titleColor: kPalettePink,
    child: Column(
      children: <Widget>[
        destinationDropdown,
        const SizedBox(height: 14.0),
        cabinDropdown,
        const SizedBox(height: 14.0),
        partySize,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5: CHECKBOX & CHECKBOXLISTTILE
  // ==========================================================================
  final List<Widget> checkboxRow = <Widget>[
    const Checkbox(value: true, onChanged: null),
    const SizedBox(width: 8.0),
    Checkbox(value: false, onChanged: (_) {}),
    const SizedBox(width: 8.0),
    Checkbox(value: true, onChanged: (_) {}),
    const SizedBox(width: 8.0),
    Checkbox(value: null, tristate: true, onChanged: (_) {}),
    const SizedBox(width: 8.0),
    Checkbox(
      value: true,
      activeColor: kPaletteIndigo,
      checkColor: kPaletteWhite,
      onChanged: (_) {},
    ),
    const SizedBox(width: 8.0),
    Checkbox(
      value: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      activeColor: kPaletteAmber,
      onChanged: (_) {},
    ),
  ];

  final List<Widget> checkboxTiles = <Widget>[
    CheckboxListTile(
      value: true,
      onChanged: (_) {},
      title: const Text('Subscribe to newsletter'),
      subtitle: const Text('Monthly product updates'),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: kPaletteIndigo,
    ),
    CheckboxListTile(
      value: false,
      onChanged: (_) {},
      title: const Text('Marketing emails'),
      subtitle: const Text('Promotions and partner offers'),
      controlAffinity: ListTileControlAffinity.trailing,
      activeColor: kPaletteAmber,
    ),
    CheckboxListTile(
      value: null,
      tristate: true,
      onChanged: (_) {},
      title: const Text('Bundle notifications'),
      subtitle: const Text('Tristate: roll-up undecided'),
      activeColor: kPaletteTeal,
    ),
  ];

  final Widget checkboxSection = _sectionShell(
    title: '4. Checkbox & CheckboxListTile',
    subtitle:
        'Inline checkboxes, tristate, and the prepackaged ListTile variant for settings-style screens.',
    surface: kPaletteAmberSurface,
    border: kPaletteAmberSoft,
    titleColor: kPaletteAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Inline variants',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: checkboxRow,
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'CheckboxListTile',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: Column(children: checkboxTiles),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 6: RADIO & RADIOLISTTILE
  // ==========================================================================
  final Widget radioRow = RadioGroup<int>(
    groupValue: 1,
    onChanged: (_) {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Radio<int>(value: 1),
        const Radio<int>(value: 2),
        const Radio<int>(value: 3, activeColor: kPaletteGreen),
        Radio<int>(
          value: 4,
          fillColor: WidgetStateProperty.all(kPaletteAmber),
        ),
        const Radio<int>(value: 5),
      ],
    ),
  );

  final List<Map<String, Object>> radioOptions = <Map<String, Object>>[
    <String, Object>{
      'value': 'fiber',
      'title': 'Fiber 1 Gbps',
      'detail': 'Best for streaming and downloads',
      'icon': Icons.fiber_smart_record,
      'color': kPaletteIndigo,
    },
    <String, Object>{
      'value': 'cable',
      'title': 'Cable 300 Mbps',
      'detail': 'Reliable everyday connection',
      'icon': Icons.cable,
      'color': kPaletteTeal,
    },
    <String, Object>{
      'value': 'satellite',
      'title': 'Satellite 50 Mbps',
      'detail': 'Available everywhere',
      'icon': Icons.satellite_alt,
      'color': kPaletteAmber,
    },
  ];

  final Widget radioTiles = RadioGroup<String>(
    groupValue: 'fiber',
    onChanged: (_) {},
    child: Column(
      children: radioOptions.map((Map<String, Object> opt) {
        final bool selected = opt['value'] == 'fiber';
        return RadioListTile<String>(
          value: opt['value'] as String,
          title: Row(
            children: <Widget>[
              Icon(opt['icon'] as IconData, color: opt['color'] as Color),
              const SizedBox(width: 8.0),
              Text(opt['title'] as String),
            ],
          ),
          subtitle: Text(opt['detail'] as String),
          activeColor: opt['color'] as Color,
          secondary: selected
              ? const Icon(Icons.check_circle, color: kPaletteGreen)
              : const Icon(Icons.radio_button_unchecked, color: kPaletteMuted),
        );
      }).toList(),
    ),
  );

  final Widget radioSection = _sectionShell(
    title: '5. Radio & RadioListTile',
    subtitle:
        'Radio binds a single value out of a mutually-exclusive set. RadioListTile pairs that with a rich title row.',
    surface: kPaletteGreenSurface,
    border: kPaletteGreenSoft,
    titleColor: kPaletteGreen,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Inline variants',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: radioRow,
        ),
        const SizedBox(height: 16.0),
        const Text(
          'RadioListTile group',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: radioTiles,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 7: SWITCH & SWITCHLISTTILE
  // ==========================================================================
  final List<Widget> switchRow = <Widget>[
    Switch(value: true, onChanged: (_) {}),
    const SizedBox(width: 8.0),
    Switch(value: false, onChanged: (_) {}),
    const SizedBox(width: 8.0),
    Switch(
      value: true,
      activeThumbColor: kPaletteIndigo,
      activeTrackColor: kPaletteIndigoSoft,
      onChanged: (_) {},
    ),
    const SizedBox(width: 8.0),
    Switch(
      value: true,
      thumbColor: WidgetStateProperty.all(kPaletteAmber),
      trackColor: WidgetStateProperty.all(kPaletteAmberSoft),
      onChanged: (_) {},
    ),
    const SizedBox(width: 8.0),
    Switch.adaptive(value: true, onChanged: (_) {}),
    const SizedBox(width: 8.0),
    const Switch(value: true, onChanged: null),
  ];

  final List<Map<String, Object>> switchTilesData = <Map<String, Object>>[
    <String, Object>{
      'title': 'Push notifications',
      'subtitle': 'Alerts for booking changes',
      'icon': Icons.notifications_active_outlined,
      'value': true,
      'color': kPaletteIndigo,
    },
    <String, Object>{
      'title': 'Dark mode',
      'subtitle': 'Use device-wide appearance',
      'icon': Icons.dark_mode_outlined,
      'value': false,
      'color': kPaletteBlueGrey,
    },
    <String, Object>{
      'title': 'Two-factor auth',
      'subtitle': 'TOTP on every sign-in',
      'icon': Icons.security,
      'value': true,
      'color': kPaletteGreen,
    },
    <String, Object>{
      'title': 'Travel insurance',
      'subtitle': 'Cover unexpected cancellations',
      'icon': Icons.shield_outlined,
      'value': false,
      'color': kPaletteAmber,
    },
  ];

  final Widget switchTiles = Column(
    children: switchTilesData.map((Map<String, Object> tile) {
      return SwitchListTile(
        value: tile['value'] as bool,
        onChanged: (_) {},
        title: Row(
          children: <Widget>[
            Icon(tile['icon'] as IconData, color: tile['color'] as Color),
            const SizedBox(width: 8.0),
            Text(tile['title'] as String),
          ],
        ),
        subtitle: Text(tile['subtitle'] as String),
        activeThumbColor: tile['color'] as Color,
      );
    }).toList(),
  );

  final Widget switchSection = _sectionShell(
    title: '6. Switch & SwitchListTile',
    subtitle:
        'Switches model an immediate on/off setting. The adaptive variant follows the host platform.',
    surface: const Color(0xFFECEFF1),
    border: const Color(0xFFCFD8DC),
    titleColor: kPaletteBlueGrey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Inline variants',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: switchRow,
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'SwitchListTile group',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: switchTiles,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 8: SLIDER & RANGESLIDER
  // ==========================================================================
  final List<Map<String, Object>> sliderRows = <Map<String, Object>>[
    <String, Object>{
      'name': 'Continuous',
      'detail': 'value 0..1',
      'value': 0.42,
      'min': 0.0,
      'max': 1.0,
      'divisions': 0,
      'label': '42%',
      'color': kPaletteIndigo,
    },
    <String, Object>{
      'name': 'Discrete',
      'detail': '10 divisions',
      'value': 30.0,
      'min': 0.0,
      'max': 100.0,
      'divisions': 10,
      'label': '30',
      'color': kPaletteTeal,
    },
    <String, Object>{
      'name': 'Wide range',
      'detail': '-50..50',
      'value': -12.0,
      'min': -50.0,
      'max': 50.0,
      'divisions': 100,
      'label': '-12',
      'color': kPaletteAmber,
    },
    <String, Object>{
      'name': 'Custom colors',
      'detail': 'active + inactive',
      'value': 0.7,
      'min': 0.0,
      'max': 1.0,
      'divisions': 0,
      'label': '0.7',
      'color': kPalettePink,
    },
  ];

  final Widget sliderCards = Column(
    children: sliderRows.map((Map<String, Object> row) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      row['name'] as String,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _tagPill(row['detail'] as String, row['color'] as Color),
                ],
              ),
              Slider(
                value: row['value'] as double,
                min: row['min'] as double,
                max: row['max'] as double,
                divisions: (row['divisions'] as int) == 0
                    ? null
                    : row['divisions'] as int,
                label: row['label'] as String,
                activeColor: row['color'] as Color,
                inactiveColor: kPaletteCloud,
                onChanged: (_) {},
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );

  final RangeSlider priceRange = RangeSlider(
    values: const RangeValues(180.0, 920.0),
    min: 0.0,
    max: 1500.0,
    divisions: 30,
    labels: const RangeLabels('\$180', '\$920'),
    activeColor: kPaletteIndigo,
    inactiveColor: kPaletteIndigoSoft,
    onChanged: (_) {},
  );

  final RangeSlider timeRange = RangeSlider(
    values: const RangeValues(7.0, 19.0),
    min: 0.0,
    max: 24.0,
    divisions: 24,
    labels: const RangeLabels('07:00', '19:00'),
    activeColor: kPaletteTeal,
    inactiveColor: kPaletteTealSoft,
    onChanged: (_) {},
  );

  final Widget sliderSection = _sectionShell(
    title: '7. Slider & RangeSlider',
    subtitle:
        'Continuous and discrete sliders, and the RangeSlider for low/high pairs.',
    surface: kPaletteIndigoSurface,
    border: kPaletteIndigoSoft,
    titleColor: kPaletteIndigoDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sliderCards,
        const SizedBox(height: 8.0),
        const Text(
          'RangeSlider — price band',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        priceRange,
        _captionRow('min', '\$180'),
        _captionRow('max', '\$920'),
        const SizedBox(height: 8.0),
        const Text(
          'RangeSlider — time of day',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        timeRange,
        _captionRow('open', '07:00'),
        _captionRow('close', '19:00'),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 9: VALIDATORS & ERROR PATTERNS
  // ==========================================================================
  Widget validationTable(
    String title,
    Color accent,
    List<ValidationCase> cases,
    String? Function(String?) validator,
  ) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: kPaletteWhite,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kPaletteCloud, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ...cases.map((ValidationCase c) {
            final String? actual = validator(c.input);
            final bool matches = actual == c.error;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: c.valid ? kPaletteGreenSoft : kPalettePinkSoft,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      c.label,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      c.input.isEmpty ? '(empty)' : c.input,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: matches ? kPaletteGreen : kPalettePink,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      actual ?? 'ok',
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: kPaletteWhite,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  final Widget validatorSection = _sectionShell(
    title: '8. Validators & error patterns',
    subtitle:
        'Validators return null on success or a human message on failure. Below: live evaluation against a fixture table.',
    surface: kPalettePinkSurface,
    border: kPalettePinkSoft,
    titleColor: kPalettePink,
    child: Column(
      children: <Widget>[
        validationTable(
          'Email validator',
          kPaletteIndigo,
          emailCases,
          emailValidator,
        ),
        validationTable(
          'Password (min 8)',
          kPaletteTeal,
          passwordCases,
          (String? v) => minLengthValidator(8, v),
        ),
        validationTable(
          'Age (13..120)',
          kPaletteAmber,
          ageCases,
          (String? v) => rangeValidator(13, 120, v),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 10: AUTOVALIDATEMODE STATES
  // ==========================================================================
  final Widget autovalidateSection = _sectionShell(
    title: '9. AutovalidateMode states',
    subtitle:
        'AutovalidateMode controls when a Form/FormField runs its validators automatically.',
    surface: kPaletteAmberSurface,
    border: kPaletteAmberSoft,
    titleColor: kPaletteAmber,
    child: Column(
      children: autovalidateIndexed.map((Map<String, Object> row) {
        final int idx = row['index'] as int;
        final Color accent = <Color>[
          kPaletteIndigo,
          kPalettePink,
          kPaletteGreen,
          kPaletteTeal,
        ][idx % 4];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: kPaletteWhite,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: kPaletteCloud, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 30.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        '${idx + 1}',
                        style: const TextStyle(
                          color: kPaletteWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        row['headline'] as String,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _tagPill(row['name'] as String, accent),
                  ],
                ),
                const SizedBox(height: 6.0),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    row['detail'] as String,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: kPaletteBlueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );

  // ==========================================================================
  // SECTION 11: CUSTOM FORMFIELD SUBCLASSES
  // ==========================================================================
  final StarRatingFormField starField = StarRatingFormField(
    label: 'Rate this experience',
    initialValue: 4,
    validator: (int? value) =>
        (value == null || value < 1) ? 'Pick a rating' : null,
  );

  final ColorSwatchFormField swatchField = ColorSwatchFormField(
    label: 'Tag color',
    options: const <Color>[
      kPaletteIndigo,
      kPaletteTeal,
      kPaletteAmber,
      kPalettePink,
      kPaletteGreen,
      kPaletteBlueGrey,
    ],
    initialValue: kPaletteTeal,
  );

  final Widget customSection = _sectionShell(
    title: '10. Custom FormField subclasses',
    subtitle:
        'Extending FormField<T> wires any visual idea into the standard form lifecycle: initialValue, validator, save, reset.',
    surface: kPaletteTealSurface,
    border: kPaletteTealSoft,
    titleColor: kPaletteTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: starField,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: swatchField,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 12: COMPLETE REALISTIC FORM — TRIP PLANNER
  // ==========================================================================
  // A larger, realistic Form that composes most of the earlier widgets into a
  // single submission flow: traveller info, trip preferences, pricing, and
  // confirmations. It uses a GlobalKey<FormState> exactly the way real apps do.
  final GlobalKey<FormState> tripFormKey = GlobalKey<FormState>();

  final TextFormField bookFullName = TextFormField(
    initialValue: 'Alex Tomar',
    decoration: const InputDecoration(
      labelText: 'Full name',
      prefixIcon: Icon(Icons.person_outline),
      border: OutlineInputBorder(),
    ),
    validator: requiredValidator,
    onChanged: (_) {},
  );

  final TextFormField bookEmail = TextFormField(
    initialValue: 'alex@tom.dev',
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      labelText: 'Email',
      prefixIcon: Icon(Icons.mail_outline),
      border: OutlineInputBorder(),
    ),
    validator: emailValidator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onChanged: (_) {},
  );

  final TextFormField bookPhone = TextFormField(
    initialValue: '+15551234567',
    keyboardType: TextInputType.phone,
    decoration: const InputDecoration(
      labelText: 'Phone',
      prefixIcon: Icon(Icons.phone_outlined),
      border: OutlineInputBorder(),
    ),
    onChanged: (_) {},
  );

  final TextFormField bookSpecialRequests = TextFormField(
    initialValue:
        'Window seat preferred. Vegetarian meal. Pickup at terminal 2 around noon.',
    maxLines: 3,
    decoration: const InputDecoration(
      labelText: 'Special requests',
      alignLabelWithHint: true,
      border: OutlineInputBorder(),
    ),
    onChanged: (_) {},
  );

  final DropdownButtonFormField<String> bookDestination =
      DropdownButtonFormField<String>(
        initialValue: 'reykjavik',
        decoration: const InputDecoration(
          labelText: 'Destination',
          prefixIcon: Icon(Icons.public),
          border: OutlineInputBorder(),
        ),
        items: destinationOptions.map((DropdownOption option) {
          return DropdownMenuItem<String>(
            value: option.value,
            child: Row(
              children: <Widget>[
                Icon(option.icon, size: 16.0, color: kPaletteIndigo),
                const SizedBox(width: 6.0),
                Text(option.label),
              ],
            ),
          );
        }).toList(),
        onChanged: (_) {},
      );

  final DropdownButtonFormField<String> bookCabin =
      DropdownButtonFormField<String>(
        initialValue: 'business',
        decoration: const InputDecoration(
          labelText: 'Cabin class',
          prefixIcon: Icon(Icons.airline_seat_recline_extra),
          border: OutlineInputBorder(),
        ),
        items: cabinOptions.map((DropdownOption option) {
          return DropdownMenuItem<String>(
            value: option.value,
            child: Text(option.label),
          );
        }).toList(),
        onChanged: (_) {},
      );

  final DropdownButtonFormField<int> bookTravelers =
      DropdownButtonFormField<int>(
        initialValue: 3,
        decoration: const InputDecoration(
          labelText: 'Travelers',
          prefixIcon: Icon(Icons.group_outlined),
          border: OutlineInputBorder(),
        ),
        items: List<DropdownMenuItem<int>>.generate(
          8,
          (int i) => DropdownMenuItem<int>(
            value: i + 1,
            child: Text('${i + 1}'),
          ),
        ),
        onChanged: (_) {},
      );

  final Widget bookCheckboxes = Container(
    decoration: BoxDecoration(
      color: kPaletteWhite,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kPaletteCloud, width: 1.0),
    ),
    child: Column(
      children: <Widget>[
        CheckboxListTile(
          value: true,
          onChanged: (_) {},
          title: const Text('Checked baggage'),
          subtitle: const Text('1 piece per traveler, up to 23 kg'),
          activeColor: kPaletteIndigo,
        ),
        CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('In-flight meals'),
          subtitle: const Text('Add a hot meal on long-haul segments'),
          activeColor: kPaletteAmber,
        ),
        CheckboxListTile(
          value: true,
          onChanged: (_) {},
          title: const Text('Lounge access'),
          subtitle: const Text('Star Alliance lounges where available'),
          activeColor: kPaletteTeal,
        ),
      ],
    ),
  );

  final Widget bookRadioGroup = Container(
    decoration: BoxDecoration(
      color: kPaletteWhite,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kPaletteCloud, width: 1.0),
    ),
    child: RadioGroup<String>(
      groupValue: 'standard',
      onChanged: (_) {},
      child: const Column(
        children: <Widget>[
          RadioListTile<String>(
            value: 'standard',
            title: Text('Standard refundable'),
            subtitle: Text('Refundable up to 48h before travel'),
            activeColor: kPaletteIndigo,
          ),
          RadioListTile<String>(
            value: 'flex',
            title: Text('Flex'),
            subtitle: Text('Free changes any time'),
            activeColor: kPaletteAmber,
          ),
          RadioListTile<String>(
            value: 'basic',
            title: Text('Basic'),
            subtitle: Text('Non-refundable, lowest price'),
            activeColor: kPaletteGreen,
          ),
        ],
      ),
    ),
  );

  final Widget bookSwitches = Container(
    decoration: BoxDecoration(
      color: kPaletteWhite,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kPaletteCloud, width: 1.0),
    ),
    child: Column(
      children: <Widget>[
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text('Email confirmations'),
          subtitle: const Text('Booking, check-in, and gate updates'),
          activeThumbColor: kPaletteIndigo,
        ),
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text('SMS updates'),
          subtitle: const Text('Carrier message charges may apply'),
          activeThumbColor: kPaletteTeal,
        ),
        SwitchListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('Carbon offset'),
          subtitle: const Text('Add an offset contribution to each leg'),
          activeThumbColor: kPaletteGreen,
        ),
      ],
    ),
  );

  final Widget bookPriceBand = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kPaletteWhite,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kPaletteCloud, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Acceptable price band (per traveler)',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
        ),
        RangeSlider(
          values: const RangeValues(420.0, 1850.0),
          min: 0.0,
          max: 3000.0,
          divisions: 60,
          labels: const RangeLabels('\$420', '\$1850'),
          activeColor: kPaletteIndigo,
          inactiveColor: kPaletteIndigoSoft,
          onChanged: (_) {},
        ),
        _captionRow('min', '\$420'),
        _captionRow('max', '\$1850'),
      ],
    ),
  );

  final Widget bookTimeSlider = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kPaletteWhite,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kPaletteCloud, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Departure window',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
        ),
        Slider(
          value: 12.0,
          min: 0.0,
          max: 24.0,
          divisions: 24,
          label: '12:00',
          activeColor: kPaletteTeal,
          inactiveColor: kPaletteTealSoft,
          onChanged: (_) {},
        ),
        _captionRow('preferred', '12:00'),
      ],
    ),
  );

  final StarRatingFormField bookStarRating = StarRatingFormField(
    label: 'Past trip rating with us',
    initialValue: 5,
  );

  final ColorSwatchFormField bookSwatch = ColorSwatchFormField(
    label: 'Itinerary highlight color',
    options: const <Color>[
      kPaletteIndigo,
      kPaletteTeal,
      kPaletteAmber,
      kPalettePink,
      kPaletteGreen,
    ],
    initialValue: kPaletteAmber,
  );

  final Widget bookingFormBody = Form(
    key: tripFormKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Traveller information',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: kPaletteIndigoDeep,
          ),
        ),
        const SizedBox(height: 10.0),
        bookFullName,
        const SizedBox(height: 10.0),
        bookEmail,
        const SizedBox(height: 10.0),
        bookPhone,
        const SizedBox(height: 18.0),
        const Text(
          'Trip details',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: kPaletteIndigoDeep,
          ),
        ),
        const SizedBox(height: 10.0),
        bookDestination,
        const SizedBox(height: 10.0),
        bookCabin,
        const SizedBox(height: 10.0),
        bookTravelers,
        const SizedBox(height: 18.0),
        const Text(
          'Add-ons',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: kPaletteIndigoDeep,
          ),
        ),
        const SizedBox(height: 8.0),
        bookCheckboxes,
        const SizedBox(height: 18.0),
        const Text(
          'Fare type',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: kPaletteIndigoDeep,
          ),
        ),
        const SizedBox(height: 8.0),
        bookRadioGroup,
        const SizedBox(height: 18.0),
        const Text(
          'Communication preferences',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: kPaletteIndigoDeep,
          ),
        ),
        const SizedBox(height: 8.0),
        bookSwitches,
        const SizedBox(height: 18.0),
        const Text(
          'Constraints',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: kPaletteIndigoDeep,
          ),
        ),
        const SizedBox(height: 8.0),
        bookPriceBand,
        const SizedBox(height: 10.0),
        bookTimeSlider,
        const SizedBox(height: 18.0),
        const Text(
          'Personalization',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: kPaletteIndigoDeep,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: bookStarRating,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: kPaletteWhite,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPaletteCloud, width: 1.0),
          ),
          child: bookSwatch,
        ),
        const SizedBox(height: 18.0),
        bookSpecialRequests,
        const SizedBox(height: 20.0),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: kPaletteBlueGrey,
                  side: const BorderSide(color: kPaletteCloud, width: 1.0),
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.flight_takeoff),
                label: const Text('Book the trip'),
                style: FilledButton.styleFrom(
                  backgroundColor: kPaletteIndigoDeep,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  final Widget bookingSection = _sectionShell(
    title: '11. Complete trip-booking form',
    subtitle:
        'A realistic Form that composes every control above into one submission flow with a GlobalKey<FormState> and onUserInteraction validation.',
    surface: kPaletteSnow,
    border: kPaletteCloud,
    titleColor: kPaletteIndigoDeep,
    child: bookingFormBody,
  );

  // ==========================================================================
  // SECTION 13: SUMMARY FOOTER
  // ==========================================================================
  // A compact summary that doubles as documentation for the gallery.
  final List<Map<String, Object>> summaryStats = <Map<String, Object>>[
    <String, Object>{
      'label': 'Widgets covered',
      'value': '13',
      'color': kPaletteIndigo,
    },
    <String, Object>{
      'label': 'Validators',
      'value': '5',
      'color': kPaletteTeal,
    },
    <String, Object>{
      'label': 'AutovalidateModes',
      'value': '4',
      'color': kPaletteAmber,
    },
    <String, Object>{
      'label': 'Custom fields',
      'value': '2',
      'color': kPalettePink,
    },
    <String, Object>{
      'label': 'Sections',
      'value': '11',
      'color': kPaletteGreen,
    },
  ];

  final Widget summaryFooter = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kPaletteSlate, kPaletteBlueGrey],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.summarize_outlined, color: kPaletteWhite, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Demo summary',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: kPaletteWhite,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: summaryStats.map((Map<String, Object> stat) {
            return Container(
              width: 130.0,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    stat['value'] as String,
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: kPaletteWhite,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    stat['label'] as String,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFFCFD8DC),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18.0),
        const Text(
          'Every control on this page is a fully-formed Material widget interpreted by D4rt at runtime — no compilation step. The complete booking form combines them under a single Form/FormState lifecycle.',
          style: TextStyle(
            fontSize: 13.0,
            color: kPaletteWhite,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Generated for the SendTestRunner harness • golden-ratio spacing ≈ ${(1.0 / ((1.0 + math.sqrt(5.0)) / 2.0)).toStringAsFixed(3)}',
          style: const TextStyle(
            fontSize: 11.5,
            color: Color(0xFFB0BEC5),
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // FINAL LAYOUT: Scaffold -> SingleChildScrollView -> Column
  // ==========================================================================
  return Scaffold(
    backgroundColor: kPaletteCloud,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            header,
            const SizedBox(height: 20.0),
            tocBox,
            const SizedBox(height: 24.0),
            textFieldGallery,
            const SizedBox(height: 20.0),
            decorationSection,
            const SizedBox(height: 20.0),
            dropdownSection,
            const SizedBox(height: 20.0),
            checkboxSection,
            const SizedBox(height: 20.0),
            radioSection,
            const SizedBox(height: 20.0),
            switchSection,
            const SizedBox(height: 20.0),
            sliderSection,
            const SizedBox(height: 20.0),
            validatorSection,
            const SizedBox(height: 20.0),
            autovalidateSection,
            const SizedBox(height: 20.0),
            customSection,
            const SizedBox(height: 24.0),
            bookingSection,
            const SizedBox(height: 24.0),
            summaryFooter,
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    ),
  );
}
