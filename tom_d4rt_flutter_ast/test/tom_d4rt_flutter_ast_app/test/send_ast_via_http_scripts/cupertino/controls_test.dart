// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of Cupertino controls.
//
// This file is part of the D4rt flutter-test corpus. It is intended to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)`
// - which is invoked a single time, and which returns a Widget tree.
//
// The rendered output is a long static gallery that walks through each of
// the Cupertino controls offered by Flutter's iOS-style component library:
//
//   * CupertinoButton (text, filled, with icon, disabled, dark, custom)
//   * CupertinoSwitch (off, on, custom thumb, disabled, dark)
//   * CupertinoSlider (4 variants including divisions and custom colour)
//   * CupertinoSegmentedControl<int> (3-item, 5-item, custom colour)
//   * CupertinoSlidingSegmentedControl<String> (short/long labels)
//   * CupertinoCheckbox and CupertinoRadio<T>
//   * CupertinoTextField (brief, default + placeholder)
//   * CupertinoActivityIndicator (4 sizes)
//   * CupertinoPicker (rendered statically with a fixed extent controller)
//
// Each section is followed by a code block illustrating idiomatic usage,
// a comparison table that pairs Cupertino controls with their Material
// counterparts, a pitfalls panel with five callouts and finally a
// cheat-sheet footer.  Because the script runs in a static, no-interaction
// environment, every `onChanged` callback is either `null` (disabled state)
// or `(_) {}` (a no-op consumer). No `setState`, `Timer`, `Future` or
// `AnimationController` are used anywhere in this file.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// The demo deliberately uses literal ARGB colours instead of CupertinoColors
// resolved against context, because some helper widgets are constructed
// without a live CupertinoTheme. The constants below are kept close to the
// real iOS palette so the gallery still feels native.
const Color _kCanvas = Color(0xFFF2F2F7);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1C1C1E);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1C1C1E);
const Color _kInkSecondary = Color(0xFF3C3C43);
const Color _kInkTertiary = Color(0xFF8E8E93);
const Color _kInkOnDark = Color(0xFFEDEDF0);
const Color _kInkOnDarkSecondary = Color(0xFFA1A1A6);
const Color _kAccent = Color(0xFF007AFF); // systemBlue
const Color _kAccentGreen = Color(0xFF34C759);
const Color _kAccentOrange = Color(0xFFFF9500);
const Color _kAccentRed = Color(0xFFFF3B30);
const Color _kAccentIndigo = Color(0xFF5856D6);
const Color _kAccentPink = Color(0xFFFF2D55);
const Color _kAccentTeal = Color(0xFF30B0C7);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);
const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
// All helpers are top-level `_camelCase` functions returning `Widget`s. They
// are intentionally not made into StatelessWidget subclasses to keep the
// file approachable to anyone reading top-to-bottom.
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child, Color background = _kCardBg, EdgeInsets padding = _kCardPadding, EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0)}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(String title, {String? subtitle, Color titleColor = _kInk, Color subtitleColor = _kInkSecondary}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF2A2D32)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Row(
            children: [
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
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kCodeAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        Text(code, style: _kCodeStyle),
      ],
    ),
  );
}

Widget _variantLabel(String label, {Color colour = _kInkSecondary}) {
  return Padding(
    padding: const EdgeInsets.only(top: 6.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.5,
        color: colour,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _variantTile({required Widget child, required String label, Color background = _kCardBg, Color labelColour = _kInkSecondary, EdgeInsets innerPadding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0)}) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    padding: innerPadding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 56.0,
          child: Center(child: child),
        ),
        _variantLabel(label, colour: labelColour),
      ],
    ),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    height: 1.0,
    color: _kHairline,
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All state must live in
// local variables and be passed by closure to the widgets below.
// ===========================================================================
dynamic build(BuildContext context) {
  print('Cupertino controls deep visual demo executing');
  final math.Random rng = math.Random(7);
  final int dummyEntropy = rng.nextInt(100);
  print('  rng warm-up: $dummyEntropy');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card explains what Cupertino controls are and why an iOS app
  // would prefer them over their Material equivalents. The intro is a big
  // gradient card with two columns: a title block and a list of bullets.
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF007AFF),
          Color(0xFF5856D6),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33007AFF),
          offset: Offset(0.0, 4.0),
          blurRadius: 14.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const <Widget>[
            Icon(CupertinoIcons.app, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'Cupertino Controls',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'iOS-flavoured Flutter widgets, head to toe',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Cupertino is Flutter\'s native-feeling component set for iOS apps. '
          'Each widget mirrors a UIKit control - the buttons feel like UIButton, '
          'the switches feel like UISwitch, and the segmented controls behave like '
          'UISegmentedControl. They obey the iOS HIG out of the box: tap target sizes, '
          'spring animations, San Francisco-style typography, blur and translucency.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.5,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('iOS Look',    colour: const Color(0xFFFFFFFF)),
            _pill('HIG Aware',   colour: const Color(0xFFFFFFFF)),
            _pill('Theme-aware', colour: const Color(0xFFFFFFFF)),
            _pill('Dart-only',   colour: const Color(0xFFFFFFFF)),
            _pill('No Material', colour: const Color(0xFFFFFFFF)),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.checkmark_seal_fill, color: Color(0xFFFFFFFF), size: 18.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Prefer Cupertino for apps that need to feel native on iOS, '
                'or for any in-house tooling that wants the Apple aesthetic.',
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xE6FFFFFF),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - BUTTON GALLERY
  // -------------------------------------------------------------------------
  // Six variants, each rendered inside a `_variantTile`. The tiles share a
  // common size envelope so the rows align horizontally even when label
  // strings have different lengths.
  // -------------------------------------------------------------------------
  // Variant A: plain text button (transparent background, blue label).
  final Widget buttonPlain = CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    onPressed: () {},
    child: const Text(
      'Plain',
      style: TextStyle(color: _kAccent, fontWeight: FontWeight.w500),
    ),
  );

  // Variant B: filled button (CupertinoButton.filled - blue background).
  final Widget buttonFilled = CupertinoButton.filled(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    onPressed: () {},
    child: const Text('Filled'),
  );

  // Variant C: button with a leading icon and a trailing label.
  final Widget buttonWithIcon = CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    onPressed: () {},
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Icon(CupertinoIcons.cloud_download, color: _kAccent, size: 18.0),
        SizedBox(width: 6.0),
        Text('Download', style: TextStyle(color: _kAccent, fontWeight: FontWeight.w500)),
      ],
    ),
  );

  // Variant D: disabled button. `onPressed: null` is the conventional way to
  // disable a CupertinoButton; the framework renders it greyed out.
  final Widget buttonDisabled = CupertinoButton.filled(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    onPressed: null,
    child: const Text('Disabled'),
  );

  // Variant E: dark-mode button (sitting on a dark card). The text colour is
  // forced to white because the surrounding card has dark background.
  final Widget buttonDark = CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    color: const Color(0xFF2C2C2E),
    onPressed: () {},
    child: const Text(
      'Dark',
      style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500),
    ),
  );

  // Variant F: button with a custom colour (orange) and a custom radius.
  final Widget buttonCustom = CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    color: _kAccentOrange,
    borderRadius: BorderRadius.circular(20.0),
    onPressed: () {},
    child: const Text(
      'Custom',
      style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
    ),
  );

  final Widget buttonGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.square_grid_2x2_fill, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoButton',
              subtitle: 'Six tap-targets covering text, filled, icon, disabled, dark and custom variants',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            _variantTile(child: buttonPlain,    label: 'text'),
            _variantTile(child: buttonFilled,   label: 'filled'),
            _variantTile(child: buttonWithIcon, label: 'icon+label'),
            _variantTile(child: buttonDisabled, label: 'disabled'),
            _variantTile(child: buttonDark,     label: 'dark', background: _kCardDark, labelColour: _kInkOnDarkSecondary),
            _variantTile(child: buttonCustom,   label: 'custom radius'),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - CUPERTINOSWITCH GALLERY
  // -------------------------------------------------------------------------
  // Five variants. Notes:
  //   * `onChanged: (_) {}` is a no-op consumer that keeps the switch
  //     interactive even though we never call setState.
  //   * `onChanged: null` produces a disabled switch.
  //   * `activeColor` and `thumbColor` change the look while the value
  //     remains `false`/`true` from the constructor.
  // -------------------------------------------------------------------------
  final Widget switchOff = CupertinoSwitch(
    value: false,
    onChanged: (_) {},
  );
  final Widget switchOn = CupertinoSwitch(
    value: true,
    onChanged: (_) {},
  );
  final Widget switchCustomThumb = CupertinoSwitch(
    value: true,
    activeColor: _kAccentGreen,
    thumbColor: const Color(0xFFFFF7E0),
    onChanged: (_) {},
  );
  final Widget switchDisabled = CupertinoSwitch(
    value: false,
    onChanged: null,
  );
  final Widget switchDark = CupertinoSwitch(
    value: true,
    activeColor: _kAccentPink,
    onChanged: (_) {},
  );

  final Widget switchGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.switch_camera, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoSwitch',
              subtitle: 'Boolean toggle - default off/on, custom thumb, disabled, and a dark-mode tinted variant',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            _variantTile(child: switchOff,         label: 'off'),
            _variantTile(child: switchOn,          label: 'on'),
            _variantTile(child: switchCustomThumb, label: 'custom thumb'),
            _variantTile(child: switchDisabled,    label: 'disabled'),
            _variantTile(child: switchDark,        label: 'dark / pink', background: _kCardDark, labelColour: _kInkOnDarkSecondary),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - CUPERTINOSLIDER GALLERY
  // -------------------------------------------------------------------------
  // Four sliders. Each has a fixed `value` so the rendering is static:
  //   * value = 0.0 (slider all the way to the left)
  //   * value = 0.5 (slider centred)
  //   * value = 1.0 (slider all the way to the right)
  //   * `divisions` + a custom `activeColor` to show tick behaviour.
  // -------------------------------------------------------------------------
  Widget _sliderTile(double value, String label, {int? divisions, Color activeColor = _kAccent}) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
      width: 260.0,
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(label, style: _kCaptionStyle)),
              Text(
                value.toStringAsFixed(2),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: _kInkSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          CupertinoSlider(
            value: value,
            divisions: divisions,
            activeColor: activeColor,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  final Widget sliderGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.slider_horizontal_3, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoSlider',
              subtitle: 'Continuous and discrete value selection - four snapshots across the value range',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            _sliderTile(0.0,  'value = 0.0'),
            _sliderTile(0.5,  'value = 0.5'),
            _sliderTile(1.0,  'value = 1.0'),
            _sliderTile(0.4,  'divisions = 5, activeColor = orange', divisions: 5, activeColor: _kAccentOrange),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - CUPERTINOSEGMENTEDCONTROL<int>
  // -------------------------------------------------------------------------
  // CupertinoSegmentedControl expects a Map<T, Widget> for children. Because
  // the demo is static, we choose a different `groupValue` per variant so
  // the user can see how the selection highlight moves between cells.
  // -------------------------------------------------------------------------
  Widget _segmented3() {
    const Map<int, Widget> children = <int, Widget>{
      0: Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0), child: Text('Day')),
      1: Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0), child: Text('Week')),
      2: Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0), child: Text('Month')),
    };
    return CupertinoSegmentedControl<int>(
      children: children,
      groupValue: 1,
      onValueChanged: (_) {},
    );
  }

  Widget _segmented5() {
    const Map<int, Widget> children = <int, Widget>{
      0: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('XS')),
      1: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('S')),
      2: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('M')),
      3: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('L')),
      4: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('XL')),
    };
    return CupertinoSegmentedControl<int>(
      children: children,
      groupValue: 2,
      onValueChanged: (_) {},
    );
  }

  Widget _segmentedCustom() {
    const Map<int, Widget> children = <int, Widget>{
      0: Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0), child: Text('Off')),
      1: Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0), child: Text('Auto')),
      2: Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0), child: Text('On')),
    };
    return CupertinoSegmentedControl<int>(
      children: children,
      groupValue: 2,
      selectedColor: _kAccentGreen,
      borderColor: _kAccentGreen,
      unselectedColor: const Color(0xFFFFFFFF),
      pressedColor: const Color(0x2234C759),
      onValueChanged: (_) {},
    );
  }

  final Widget segmentedGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.rectangle_split_3x1, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoSegmentedControl<int>',
              subtitle: 'Discrete picker styled like a UISegmentedControl - 3/5 items and a custom-coloured variant',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              decoration: BoxDecoration(
                color: _kCardBg,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _kHairline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('3 items, groupValue = 1', style: _kCaptionStyle),
                  const SizedBox(height: 8.0),
                  Center(child: _segmented3()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              decoration: BoxDecoration(
                color: _kCardBg,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _kHairline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('5 items, groupValue = 2', style: _kCaptionStyle),
                  const SizedBox(height: 8.0),
                  Center(child: _segmented5()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              decoration: BoxDecoration(
                color: _kCardBg,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _kHairline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('custom selectedColor / borderColor (green), groupValue = 2', style: _kCaptionStyle),
                  const SizedBox(height: 8.0),
                  Center(child: _segmentedCustom()),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - CUPERTINOSLIDINGSEGMENTEDCONTROL<String>
  // -------------------------------------------------------------------------
  // The sliding variant takes a Map<T, Widget> just like the regular
  // segmented control, but renders an animated indicator instead of filling
  // the entire selected cell. We use String as the generic parameter.
  // -------------------------------------------------------------------------
  final Widget slidingShort = CupertinoSlidingSegmentedControl<String>(
    groupValue: 'b',
    onValueChanged: (_) {},
    children: const <String, Widget>{
      'a': Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0), child: Text('One')),
      'b': Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0), child: Text('Two')),
      'c': Padding(padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0), child: Text('Three')),
    },
  );

  final Widget slidingLong = CupertinoSlidingSegmentedControl<String>(
    groupValue: 'replies',
    onValueChanged: (_) {},
    thumbColor: const Color(0xFFFFFFFF),
    backgroundColor: const Color(0xFFE5E5EA),
    children: const <String, Widget>{
      'mentions':   Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('Mentions')),
      'replies':    Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('Replies')),
      'reactions':  Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('Reactions')),
      'bookmarked': Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), child: Text('Bookmarked')),
    },
  );

  final Widget slidingGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.rectangle_3_offgrid, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoSlidingSegmentedControl<String>',
              subtitle: 'Modern animated segmented selector - short labels and long labels',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('short labels, groupValue = "b"', style: _kCaptionStyle),
              const SizedBox(height: 8.0),
              Center(child: slidingShort),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('longer labels, groupValue = "replies"', style: _kCaptionStyle),
              const SizedBox(height: 8.0),
              Center(child: slidingLong),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - CUPERTINOCHECKBOX AND CUPERTINORADIO<T>
  // -------------------------------------------------------------------------
  // Cupertino added a native-looking checkbox and radio button. We show two
  // rows: a row of checkboxes in unchecked/checked/disabled/custom-colour
  // states, and a row of radio buttons with `groupValue` set to demonstrate
  // selection across a three-option group.
  // -------------------------------------------------------------------------
  Widget _checkRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoCheckbox(value: false, onChanged: (_) {}),
            _variantLabel('off'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoCheckbox(value: true, onChanged: (_) {}),
            _variantLabel('on'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoCheckbox(value: false, onChanged: null),
            _variantLabel('disabled'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoCheckbox(
              value: true,
              activeColor: _kAccentGreen,
              checkColor: const Color(0xFFFFFFFF),
              onChanged: (_) {},
            ),
            _variantLabel('green'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoCheckbox(
              value: true,
              activeColor: _kAccentPink,
              checkColor: const Color(0xFFFFFFFF),
              onChanged: (_) {},
            ),
            _variantLabel('pink'),
          ],
        ),
      ],
    );
  }

  Widget _radioRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoRadio<String>(
              value: 'small',
              groupValue: 'medium',
              onChanged: (_) {},
            ),
            _variantLabel('small'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoRadio<String>(
              value: 'medium',
              groupValue: 'medium',
              onChanged: (_) {},
            ),
            _variantLabel('medium (selected)'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoRadio<String>(
              value: 'large',
              groupValue: 'medium',
              onChanged: (_) {},
            ),
            _variantLabel('large'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoRadio<String>(
              value: 'huge',
              groupValue: 'medium',
              onChanged: null,
            ),
            _variantLabel('disabled'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoRadio<String>(
              value: 'orange',
              groupValue: 'orange',
              activeColor: _kAccentOrange,
              onChanged: (_) {},
            ),
            _variantLabel('orange'),
          ],
        ),
      ],
    );
  }

  final Widget checkRadioGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.check_mark_circled, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoCheckbox & CupertinoRadio<T>',
              subtitle: 'Single-state toggle and exclusive-choice picker, rendered Cupertino-style',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: _checkRow(),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: _radioRow(),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - CUPERTINOTEXTFIELD (brief)
  // -------------------------------------------------------------------------
  // The text field gallery is brief because there is an entire dedicated
  // file (`cupertino/textfield_test.dart`) for it. Two variants are enough:
  // a vanilla field with placeholder and a field with a decoration / prefix.
  // -------------------------------------------------------------------------
  final Widget textFieldVariants = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.text_cursor, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoTextField (brief)',
              subtitle: 'A quick look - see textfield_test.dart for the full gallery',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: CupertinoTextField(
            placeholder: 'Search...',
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: CupertinoTextField(
            placeholder: 'name@example.com',
            prefix: const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 6.0),
              child: Icon(CupertinoIcons.mail, color: _kInkTertiary, size: 18.0),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F8),
              border: Border.all(color: _kHairline),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - CUPERTINOACTIVITYINDICATOR
  // -------------------------------------------------------------------------
  // Four indicators in a row. Sizes:
  //   * default (no radius override)
  //   * small (radius = 8.0)
  //   * large (radius = 18.0)
  //   * custom (radius = 24.0 + custom colour)
  // -------------------------------------------------------------------------
  final Widget indicatorGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.arrow_2_circlepath, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoActivityIndicator',
              subtitle: 'Four sizes - default, small, large, custom colour/radius',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  CupertinoActivityIndicator(),
                  SizedBox(height: 6.0),
                  Text('default', style: TextStyle(fontSize: 11.0, color: _kInkSecondary)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  CupertinoActivityIndicator(radius: 8.0),
                  SizedBox(height: 6.0),
                  Text('radius = 8', style: TextStyle(fontSize: 11.0, color: _kInkSecondary)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  CupertinoActivityIndicator(radius: 18.0),
                  SizedBox(height: 6.0),
                  Text('radius = 18', style: TextStyle(fontSize: 11.0, color: _kInkSecondary)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  CupertinoActivityIndicator(
                    radius: 24.0,
                    color: _kAccentOrange,
                  ),
                  SizedBox(height: 6.0),
                  Text('radius = 24, orange', style: TextStyle(fontSize: 11.0, color: _kInkSecondary)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - CUPERTINOPICKER (static wheel)
  // -------------------------------------------------------------------------
  // The picker needs a `FixedExtentScrollController` to render a non-default
  // initial selection. We build the controller eagerly and pass it in.
  // -------------------------------------------------------------------------
  final FixedExtentScrollController pickerController = FixedExtentScrollController(initialItem: 3);
  final List<String> _pickerEntries = const <String>[
    'Avocado',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Iceberg',
    'Jackfruit',
  ];

  final Widget pickerGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.selection_pin_in_out, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'CupertinoPicker',
              subtitle: 'Wheel-style selector - rendered with a FixedExtentScrollController(initialItem: 3)',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: SizedBox(
            height: 180.0,
            child: CupertinoPicker(
              scrollController: pickerController,
              itemExtent: 36.0,
              onSelectedItemChanged: (_) {},
              children: <Widget>[
                for (final String fruit in _pickerEntries)
                  Center(
                    child: Text(
                      fruit,
                      style: const TextStyle(fontSize: 16.0, color: _kInk),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'The picker is fully static; the third entry is initially highlighted via the controller.',
          style: _kCaptionStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - CODE-BLOCK CARDS
  // -------------------------------------------------------------------------
  // For every control above, an idiomatic code snippet. The snippets are
  // intentionally short - enough to learn the API shape - and use the same
  // monospace styling as a code editor would.
  // -------------------------------------------------------------------------
  final Widget codeButtonBlock = _codeBlock(
    title: 'cupertino_button.dart',
    '''CupertinoButton.filled(
  onPressed: () => _submit(),
  child: const Text('Submit'),
);

CupertinoButton(
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  color: CupertinoColors.systemOrange,
  borderRadius: BorderRadius.circular(20),
  onPressed: _onTap,
  child: const Text('Custom'),
);''',
  );

  final Widget codeSwitchBlock = _codeBlock(
    title: 'cupertino_switch.dart',
    '''CupertinoSwitch(
  value: notificationsEnabled,
  activeColor: CupertinoColors.systemGreen,
  onChanged: (bool next) {
    setState(() => notificationsEnabled = next);
  },
);

// Disabled - the framework greys out the track.
CupertinoSwitch(value: false, onChanged: null);''',
  );

  final Widget codeSliderBlock = _codeBlock(
    title: 'cupertino_slider.dart',
    '''CupertinoSlider(
  value: brightness,
  min: 0.0,
  max: 1.0,
  divisions: 10,           // turns it into a discrete slider
  activeColor: CupertinoColors.activeOrange,
  onChanged: (double next) {
    setState(() => brightness = next);
  },
);''',
  );

  final Widget codeSegmentedBlock = _codeBlock(
    title: 'cupertino_segmented_control.dart',
    '''CupertinoSegmentedControl<int>(
  groupValue: rangeIndex,
  // children is a Map<T, Widget>; T must implement ==/hashCode.
  children: const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(8), child: Text('Day')),
    1: Padding(padding: EdgeInsets.all(8), child: Text('Week')),
    2: Padding(padding: EdgeInsets.all(8), child: Text('Month')),
  },
  onValueChanged: (int next) => setState(() => rangeIndex = next),
);''',
  );

  final Widget codeSlidingBlock = _codeBlock(
    title: 'cupertino_sliding_segmented_control.dart',
    '''CupertinoSlidingSegmentedControl<String>(
  groupValue: tab,
  thumbColor: CupertinoColors.white,
  backgroundColor: CupertinoColors.systemGrey5,
  children: const <String, Widget>{
    'mentions':  Padding(padding: EdgeInsets.all(6), child: Text('Mentions')),
    'replies':   Padding(padding: EdgeInsets.all(6), child: Text('Replies')),
    'reactions': Padding(padding: EdgeInsets.all(6), child: Text('Reactions')),
  },
  onValueChanged: (String? next) {
    if (next != null) setState(() => tab = next);
  },
);''',
  );

  final Widget codeCheckRadioBlock = _codeBlock(
    title: 'cupertino_checkbox_and_radio.dart',
    '''CupertinoCheckbox(
  value: agreedToTerms,
  activeColor: CupertinoColors.activeGreen,
  onChanged: (bool? next) {
    setState(() => agreedToTerms = next ?? false);
  },
);

CupertinoRadio<String>(
  value: 'medium',
  groupValue: selectedSize,
  onChanged: (String? next) {
    setState(() => selectedSize = next ?? 'small');
  },
);''',
  );

  final Widget codeIndicatorBlock = _codeBlock(
    title: 'cupertino_activity_indicator.dart',
    '''const CupertinoActivityIndicator();                   // default
const CupertinoActivityIndicator(radius: 8.0);        // small
const CupertinoActivityIndicator(radius: 18.0);       // large
const CupertinoActivityIndicator(
  radius: 24.0,
  color: CupertinoColors.systemOrange,                // custom tint
);''',
  );

  final Widget codePickerBlock = _codeBlock(
    title: 'cupertino_picker.dart',
    '''final ctrl = FixedExtentScrollController(initialItem: 3);

CupertinoPicker(
  scrollController: ctrl,                  // determines initial selection
  itemExtent: 36.0,
  onSelectedItemChanged: (int idx) {
    setState(() => selectedFruit = fruits[idx]);
  },
  children: <Widget>[
    for (final String f in fruits) Center(child: Text(f)),
  ],
);''',
  );

  final Widget codeBlocksSection = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.doc_text, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Idiomatic Usage - Code Snippets',
              subtitle: 'Short, copy-pasteable examples for every control in the gallery',
            ),
          ],
        ),
        codeButtonBlock,
        codeSwitchBlock,
        codeSliderBlock,
        codeSegmentedBlock,
        codeSlidingBlock,
        codeCheckRadioBlock,
        codeIndicatorBlock,
        codePickerBlock,
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 12 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // Side-by-side mapping from Cupertino controls to their Material
  // counterparts, with a one-line note on behavioural differences.
  // -------------------------------------------------------------------------
  Widget _tableRow(String cupertino, String material, String note, {bool header = false}) {
    final TextStyle style = header
        ? const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: _kInk,
            letterSpacing: 0.4,
          )
        : const TextStyle(fontSize: 12.5, color: _kInk);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: header ? const Color(0xFFF7F7F8) : const Color(0x00000000),
        border: Border(
          bottom: BorderSide(color: _kHairline),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 3, child: Text(cupertino, style: style)),
          Expanded(flex: 3, child: Text(material,  style: style)),
          Expanded(flex: 4, child: Text(note,      style: style)),
        ],
      ),
    );
  }

  final Widget comparisonTable = _card(
    padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: <Widget>[
              const Icon(CupertinoIcons.rectangle_grid_2x2, color: _kAccent, size: 20.0),
              const SizedBox(width: 6.0),
              _cardTitle(
                'Cupertino vs Material',
                subtitle: 'Quick mapping between control families - same intent, different feel',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: _kHairline)),
          ),
          child: Column(
            children: <Widget>[
              _tableRow('Cupertino', 'Material', 'Behaviour / visual difference', header: true),
              _tableRow('CupertinoButton',                 'TextButton / FilledButton',  'Cupertino fades on press; Material runs an ink ripple animation.'),
              _tableRow('CupertinoButton.filled',          'FilledButton',               'Cupertino uses systemBlue + 8px radius; Material uses primary.'),
              _tableRow('CupertinoSwitch',                 'Switch',                     'Cupertino track is taller and rounded; Material is rectangular w/ thumb shadow.'),
              _tableRow('CupertinoSlider',                 'Slider',                     'Cupertino has thinner track and a circular thumb without ripple.'),
              _tableRow('CupertinoSegmentedControl',       'SegmentedButton',            'Cupertino fills selected; SegmentedButton uses outlined chips.'),
              _tableRow('CupertinoSlidingSegmentedControl','ToggleButtons (animated)',   'Sliding control animates a single thumb; ToggleButtons toggle independently.'),
              _tableRow('CupertinoCheckbox',               'Checkbox',                   'Visually similar; Cupertino is sharper-cornered and lacks ink splash.'),
              _tableRow('CupertinoRadio<T>',               'Radio<T>',                   'Same API shape; visual stroke widths differ slightly.'),
              _tableRow('CupertinoTextField',              'TextField',                  'Cupertino has rounded border and no floating label by default.'),
              _tableRow('CupertinoActivityIndicator',      'CircularProgressIndicator',  'Cupertino spins 8 ticks (UIKit style); Material has a sweeping arc.'),
              _tableRow('CupertinoPicker',                 'DropdownButton / ListWheelScrollView', 'Cupertino is a wheel; Material is a flat dropdown menu.'),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 13 - PITFALLS
  // -------------------------------------------------------------------------
  // Five callouts covering the most common mistakes when first using these
  // controls. Each callout has a leading icon, a title and a short body.
  // -------------------------------------------------------------------------
  Widget _pitfall(IconData icon, String title, String body, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: tint, size: 22.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: tint,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: _kInk,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfalls = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.exclamationmark_triangle_fill, color: _kAccentOrange, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Pitfalls',
              subtitle: 'Five mistakes that ship far too often when wiring up Cupertino controls',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfall(
          CupertinoIcons.xmark_octagon,
          'onChanged: null is not the same as () {}',
          'Passing null to a CupertinoSwitch/Slider/Checkbox/Radio disables the control '
          '(the visual changes to grey). Passing an empty (_) {} keeps the control enabled '
          'but discards the user\'s input - typically a bug rather than a UX choice.',
          _kAccentRed,
        ),
        _pitfall(
          CupertinoIcons.lightbulb,
          'Many controls require a CupertinoTheme ancestor',
          'CupertinoButton, CupertinoSlider, CupertinoSwitch read from the surrounding '
          'CupertinoTheme to obtain accent colours. Outside a CupertinoApp / CupertinoTheme, '
          'they fall back to defaults that may look out-of-place in your design.',
          _kAccentOrange,
        ),
        _pitfall(
          CupertinoIcons.rectangle_split_3x1,
          'CupertinoSegmentedControl needs Map<T, Widget>',
          'children is a Map, not a List. The keys are the candidate values and must implement '
          '== and hashCode (use int, String, or a Dart enum). The Map must not be empty - the '
          'framework asserts at construction time.',
          _kAccentIndigo,
        ),
        _pitfall(
          CupertinoIcons.rectangle_3_offgrid,
          'Sliding segmented control: same Map<T, Widget> rule',
          'CupertinoSlidingSegmentedControl shares the segmented-control contract but also '
          'animates a thumb between cells. The Map must contain at least two entries; with '
          'one entry, the thumb never has anywhere to slide.',
          _kAccentTeal,
        ),
        _pitfall(
          CupertinoIcons.selection_pin_in_out,
          'CupertinoPicker initial selection needs a FixedExtentScrollController',
          'You cannot set the initial item via a constructor parameter - instead, pass a '
          'FixedExtentScrollController(initialItem: N). Hold the controller in state so '
          'rebuilds don\'t reset the wheel back to item 0.',
          _kAccentGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 14 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  // A compact summary card with one row per control listing its primary
  // constructor signature and a single bullet of guidance.
  // -------------------------------------------------------------------------
  Widget _cheatRow(String control, String constructor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200.0,
            child: Text(
              control,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: _kInk,
              ),
            ),
          ),
          Expanded(
            child: Text(
              constructor,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: _kInkSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget cheatSheet = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 24.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(CupertinoIcons.bookmark_fill, color: Color(0xFFFFD60A), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Cheat Sheet',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'One-liners you can keep in your back pocket.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 14.0),
        DefaultTextStyle(
          style: const TextStyle(color: _kInkOnDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _cheatRow('CupertinoButton',                  'CupertinoButton(onPressed:, child:)'),
              _cheatRow('CupertinoButton.filled',           'CupertinoButton.filled(onPressed:, child:)'),
              _cheatRow('CupertinoSwitch',                  'CupertinoSwitch(value:, onChanged:)'),
              _cheatRow('CupertinoSlider',                  'CupertinoSlider(value:, onChanged:, divisions:?)'),
              _cheatRow('CupertinoSegmentedControl<T>',     'CupertinoSegmentedControl<T>(children: Map<T,Widget>, groupValue:, onValueChanged:)'),
              _cheatRow('CupertinoSlidingSegmentedControl<T>', 'CupertinoSlidingSegmentedControl<T>(children: Map<T,Widget>, groupValue:, onValueChanged:)'),
              _cheatRow('CupertinoCheckbox',                'CupertinoCheckbox(value:, onChanged:)'),
              _cheatRow('CupertinoRadio<T>',                'CupertinoRadio<T>(value:, groupValue:, onChanged:)'),
              _cheatRow('CupertinoTextField',               'CupertinoTextField(placeholder:?, controller:?, decoration:?)'),
              _cheatRow('CupertinoActivityIndicator',       'CupertinoActivityIndicator(radius:?, color:?)'),
              _cheatRow('CupertinoPicker',                  'CupertinoPicker(itemExtent:, onSelectedItemChanged:, children: List<Widget>)'),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            children: <Widget>[
              const Icon(CupertinoIcons.info_circle, color: Color(0xFFFFD60A), size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Wrap your app in CupertinoApp (or include a CupertinoTheme) so accent colours and '
                  'system defaults resolve correctly. Mixing Cupertino widgets inside MaterialApp '
                  'works, but loses the global theme link.',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: _kInkOnDark,
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

  // -------------------------------------------------------------------------
  // ASSEMBLE THE FULL SCROLLABLE GALLERY
  // -------------------------------------------------------------------------
  // Each section is preceded by a numbered header. The whole thing lives
  // inside a CupertinoPageScaffold for the navigation bar, with a single
  // ListView body to keep memory footprint and build time low.
  // -------------------------------------------------------------------------
  print('  building widget tree with 13 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'Buttons',          'CupertinoButton + CupertinoButton.filled'),
    buttonGallery,
    _sectionHeader(3, 'Switches',         'CupertinoSwitch in five states'),
    switchGallery,
    _sectionHeader(4, 'Sliders',          'CupertinoSlider continuous and discrete'),
    sliderGallery,
    _sectionHeader(5, 'Segmented',        'CupertinoSegmentedControl<int>'),
    segmentedGallery,
    _sectionHeader(6, 'Sliding Segmented','CupertinoSlidingSegmentedControl<String>'),
    slidingGallery,
    _sectionHeader(7, 'Check / Radio',    'CupertinoCheckbox + CupertinoRadio<T>'),
    checkRadioGallery,
    _sectionHeader(8, 'Text Field',       'CupertinoTextField (brief)'),
    textFieldVariants,
    _sectionHeader(9, 'Activity Indicator','CupertinoActivityIndicator'),
    indicatorGallery,
    _sectionHeader(10, 'Picker',          'CupertinoPicker static wheel'),
    pickerGallery,
    _sectionDivider(),
    _sectionHeader(11, 'Code',            'Idiomatic usage snippets'),
    codeBlocksSection,
    _sectionHeader(12, 'Comparison',      'Cupertino vs Material counterparts'),
    comparisonTable,
    _sectionHeader(13, 'Pitfalls',        'Five common mistakes'),
    pitfalls,
    _sectionHeader(14, 'Cheat Sheet',     'Constructors at a glance'),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  final Widget app = CupertinoApp(
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: _kAccent,
      scaffoldBackgroundColor: _kCanvas,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: _kCanvas,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Controls'),
        previousPageTitle: 'Gallery',
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  print('Cupertino controls deep visual demo built successfully');
  return app;
}
