// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// Visual deep demo: iOS-flavoured segmented controls in Flutter.
// Subjects:
//   - CupertinoSegmentedControl<T>          (iOS 12 style boxed segments)
//   - CupertinoSlidingSegmentedControl<T>   (iOS 13+ style sliding thumb)
// Both come from package:flutter/cupertino.dart and let the user pick a single
// value out of a small fixed set. The boxed one paints a hard pill shape with
// segment dividers; the sliding one paints a soft floating thumb behind the
// selected segment. The two are visually different but share most semantics:
// they expose `children: Map<T, Widget>`, `groupValue: T?`, and
// `onValueChanged` and they are typically wired up to a controller- or
// ValueNotifier-driven state in real apps.
//
// This file is an analyzer-free, statically-rendered demo: a single static
// build(BuildContext) entry point that returns a CupertinoApp. There is no
// state, no controllers, no setState, no async, no streams. Each control just
// pins a different `groupValue` so the reader can see what each visual state
// looks like.

import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

// ===========================================================================
// Static "selected value" sources. Each segmented control gets its own
// pre-baked groupValue so we can render different visual states side by side
// without any state management.
// ===========================================================================

const int _kBoxedDefaultValue = 1;
const int _kBoxedStyledValue = 2;
const int _kBoxedDisabledValue = 0;
const int _kBoxedNoneValue = -1;

const String _kSlidingDefaultValue = 'mid';
const String _kSlidingStyledValue = 'far';
const String _kSlidingMatrixA = 'one';
const String _kSlidingMatrixB = 'two';
const String _kSlidingMatrixC = 'three';
const String _kSlidingMatrixD = 'four';

const int _kNavBarSegmentValue = 1;

// Soft Cupertino-flavoured palette for the demo cards. We stay close to
// the system colors so that the controls look at home on iOS.
const Color _kPageBg = Color(0xFFF2F2F7);
const Color _kCardBg = CupertinoColors.white;
const Color _kCardBorder = Color(0xFFE5E5EA);
const Color _kHeadingColor = Color(0xFF1C1C1E);
const Color _kBodyColor = Color(0xFF3C3C43);
const Color _kSubtleColor = Color(0xFF8E8E93);
const Color _kAccentBlue = Color(0xFF007AFF);
const Color _kAccentTeal = Color(0xFF30B0C7);
const Color _kAccentPink = Color(0xFFFF2D55);
const Color _kAccentOrange = Color(0xFFFF9500);
const Color _kAccentGreen = Color(0xFF34C759);

// ---------------------------------------------------------------------------
// _PrivateNoop: every control needs an onValueChanged callback in real life.
// We pin a no-op so the demo stays static.
// ---------------------------------------------------------------------------

void _privateNoopInt(int? value) {
  // Intentionally empty: this is a static visual demo, no state changes.
}

void _privateNoopString(String? value) {
  // Intentionally empty: see _privateNoopInt.
}

// ===========================================================================
// _PrivateText: a small typography helper. Keeps text crisp without pulling
// in Material's TextTheme.
// ===========================================================================

class _PrivateText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final double? height;
  final double? letterSpacing;
  final int? maxLines;

  const _PrivateText(
    this.text, {
    this.size = 15.0,
    this.weight = FontWeight.w400,
    this.color = _kBodyColor,
    this.height,
    this.letterSpacing,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        decoration: TextDecoration.none,
        fontFamily: '.SF Pro Text',
      ),
    );
  }
}

// ===========================================================================
// _PrivateSection: every demo block wraps in this card to keep alignment and
// visual grouping consistent. Title + subtitle + body in a soft rounded box.
// ===========================================================================

class _PrivateSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final Color accent;
  final IconData? icon;

  const _PrivateSection({
    required this.title,
    required this.subtitle,
    required this.child,
    this.accent = _kAccentBlue,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _kCardBorder, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.04),
            blurRadius: 18.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon ?? CupertinoIcons.square_split_2x1,
                  size: 18.0,
                  color: accent,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PrivateText(
                      title,
                      size: 17.0,
                      weight: FontWeight.w700,
                      color: _kHeadingColor,
                    ),
                    const SizedBox(height: 2.0),
                    _PrivateText(
                      subtitle,
                      size: 12.5,
                      color: _kSubtleColor,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          child,
        ],
      ),
    );
  }
}

// ===========================================================================
// _PrivatePill: stylized iOS pill graphic for the hero section. Two layered
// rounded rectangles to evoke a sliding-segmented control thumb.
// ===========================================================================

class _PrivatePill extends StatelessWidget {
  final double width;
  final double height;
  final int segments;
  final int selectedIndex;

  const _PrivatePill({
    this.width = 240.0,
    this.height = 36.0,
    this.segments = 4,
    this.selectedIndex = 1,
  });

  static const Color background = Color(0x33FFFFFF);
  static const Color thumb = CupertinoColors.white;
  static const Color border = Color(0x40FFFFFF);

  @override
  Widget build(BuildContext context) {
    final double segWidth = width / segments;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(height / 2.0),
        border: Border.all(color: border, width: 1.0),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: segWidth * selectedIndex + 3.0,
            top: 3.0,
            child: Container(
              width: segWidth - 6.0,
              height: height - 6.0,
              decoration: BoxDecoration(
                color: thumb,
                borderRadius: BorderRadius.circular((height - 6.0) / 2.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withValues(alpha: 0.18),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
          Row(
            // Use Expanded children so the Row distributes exactly the
            // parent width across segments without floating-point overflow
            // (e.g. width=280, segments=3 → 280/3=93.333… × 3 can exceed
            // 280 by a sub-pixel and trigger a "RenderFlex overflowed by
            // 2.0 px on the right" assertion).
            children: List<Widget>.generate(segments, (int i) {
              return Expanded(
                child: SizedBox(
                  height: height,
                  child: Center(
                    child: _PrivateText(
                      String.fromCharCode(65 + i),
                      size: 12.0,
                      weight: FontWeight.w600,
                      color: i == selectedIndex
                          ? _kHeadingColor
                          : CupertinoColors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// _PrivateChip: small rounded label used in tag rows.
// ===========================================================================

class _PrivateChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const _PrivateChip({
    required this.label,
    this.color = _kAccentBlue,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(
          color: color.withValues(alpha: 0.30),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12.0, color: color),
            const SizedBox(width: 4.0),
          ],
          _PrivateText(
            label,
            size: 11.5,
            weight: FontWeight.w600,
            color: color,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// _PrivateTable: a small two-column property table used to lay out the
// anatomy of each class.
// ===========================================================================

class _PrivateTable extends StatelessWidget {
  final List<List<String>> rows;
  final Color headerColor;

  const _PrivateTable({
    required this.rows,
    this.headerColor = _kAccentBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kPageBg,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kCardBorder, width: 1.0),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i == 0 ? headerColor.withValues(alpha: 0.08) : null,
                border: Border(
                  bottom: BorderSide(
                    color: i == rows.length - 1
                        ? const Color(0x00000000)
                        : _kCardBorder,
                    width: 1.0,
                  ),
                ),
                borderRadius: i == 0
                    ? const BorderRadius.vertical(top: Radius.circular(12.0))
                    : null,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _PrivateText(
                      rows[i][0],
                      size: 12.5,
                      weight: i == 0 ? FontWeight.w700 : FontWeight.w600,
                      color: i == 0 ? headerColor : _kHeadingColor,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: _PrivateText(
                      rows[i][1],
                      size: 12.5,
                      weight: i == 0 ? FontWeight.w700 : FontWeight.w400,
                      color: i == 0 ? headerColor : _kBodyColor,
                      maxLines: 4,
                      height: 1.35,
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

// ===========================================================================
// _PrivateCodeListing: monospaced "fake" code block. It is just text, but it
// looks like a Xcode editor pane so the reader can map field names to a real
// constructor invocation.
// ===========================================================================

class _PrivateCodeListing extends StatelessWidget {
  final String code;
  final String? caption;

  const _PrivateCodeListing({
    required this.code,
    this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (caption != null) ...[
            Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: _kAccentPink,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: _kAccentOrange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: _kAccentGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12.0),
                _PrivateText(
                  caption!,
                  size: 11.5,
                  weight: FontWeight.w500,
                  color: const Color(0xFFAEAEB2),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
          Text(
            code,
            style: const TextStyle(
              fontFamily: 'Menlo',
              fontSize: 12.0,
              height: 1.55,
              color: Color(0xFFE5E5EA),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// _PrivateBullet: a single dot + text row, used in pitfall and notes lists.
// ===========================================================================

class _PrivateBullet extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const _PrivateBullet({
    required this.text,
    this.icon = CupertinoIcons.checkmark_circle_fill,
    this.color = _kAccentGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.0, color: color),
          const SizedBox(width: 10.0),
          Expanded(
            child: _PrivateText(
              text,
              size: 13.0,
              color: _kBodyColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// _PrivateLabel: a label + value chip used to call out a specific groupValue.
// ===========================================================================

class _PrivateLabel extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _PrivateLabel({
    required this.label,
    required this.value,
    this.color = _kAccentBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: _kPageBg,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kCardBorder, width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PrivateText(
            '$label: ',
            size: 11.5,
            weight: FontWeight.w500,
            color: _kSubtleColor,
          ),
          _PrivateText(
            value,
            size: 11.5,
            weight: FontWeight.w700,
            color: color,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section builders. Each returns the body widget that gets dropped into a
// _PrivateSection card.
// ===========================================================================

Widget _buildHero() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF007AFF),
          Color(0xFF5856D6),
          Color(0xFFAF52DE),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5856D6).withValues(alpha: 0.30),
          blurRadius: 24.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const _PrivateChip(
              label: 'Cupertino',
              color: CupertinoColors.white,
              icon: CupertinoIcons.device_phone_portrait,
            ),
            const SizedBox(width: 8.0),
            const _PrivateChip(
              label: 'iOS 13+',
              color: CupertinoColors.white,
              icon: CupertinoIcons.sparkles,
            ),
            const SizedBox(width: 8.0),
            const _PrivateChip(
              label: 'Visual Demo',
              color: CupertinoColors.white,
              icon: CupertinoIcons.eye_fill,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const _PrivateText(
          'Cupertino Segmented Controls',
          size: 30.0,
          weight: FontWeight.w800,
          color: CupertinoColors.white,
          height: 1.05,
          letterSpacing: -0.6,
        ),
        const SizedBox(height: 10.0),
        _PrivateText(
          'Single-choice pickers in the iOS visual language. The boxed variant '
          'predates iOS 13; the sliding variant introduces the floating thumb. '
          'Both are stateless from Flutter\'s POV: pick a groupValue and a '
          'callback, and you own the state.',
          size: 14.0,
          color: CupertinoColors.white.withValues(alpha: 0.92),
          height: 1.45,
        ),
        const SizedBox(height: 24.0),
        const _PrivatePill(
          width: 280.0,
          height: 38.0,
          segments: 4,
          selectedIndex: 1,
        ),
        const SizedBox(height: 12.0),
        const _PrivatePill(
          width: 280.0,
          height: 38.0,
          segments: 3,
          selectedIndex: 2,
        ),
      ],
    ),
  );
}

Widget _buildAnatomyBoxed() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _PrivateText(
        'CupertinoSegmentedControl<T>',
        size: 14.0,
        weight: FontWeight.w700,
        color: _kHeadingColor,
      ),
      const SizedBox(height: 4.0),
      const _PrivateText(
        'Older iOS 12 visual style: hard-edged pill, with a colored border, '
        'colored fill on the selected segment, and 1px dividers between '
        'segments.',
        size: 12.5,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 12.0),
      const _PrivateTable(
        rows: [
          ['Field', 'Description'],
          ['children', 'Map<T, Widget>: the segments. ≥ 2 entries required.'],
          ['groupValue', 'The currently-selected key, or null for none.'],
          ['onValueChanged', 'Called when the user taps a segment.'],
          ['selectedColor', 'Fill color of the selected segment.'],
          ['unselectedColor', 'Fill color of the non-selected segments.'],
          ['borderColor', 'Outer border color of the entire pill.'],
          ['pressedColor', 'Tint while a finger is down on a segment.'],
          ['padding', 'Padding around the whole control.'],
          ['disabledChildren', 'Set<T> of keys that should not respond.'],
        ],
      ),
    ],
  );
}

Widget _buildAnatomySliding() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _PrivateText(
        'CupertinoSlidingSegmentedControl<T>',
        size: 14.0,
        weight: FontWeight.w700,
        color: _kHeadingColor,
      ),
      const SizedBox(height: 4.0),
      const _PrivateText(
        'Newer iOS 13+ visual style: a soft rounded background with a '
        'floating thumb that slides between segments when the selection '
        'changes.',
        size: 12.5,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 12.0),
      const _PrivateTable(
        rows: [
          ['Field', 'Description'],
          ['children', 'Map<T, Widget>: the segments. ≥ 2 entries required.'],
          ['groupValue', 'The currently-selected key, or null for thumbless.'],
          ['onValueChanged', 'Called when the user taps a segment.'],
          ['thumbColor', 'Fill color of the floating thumb.'],
          ['backgroundColor', 'Fill color of the rounded background track.'],
          ['padding', 'Padding around the whole control.'],
          ['proportionalWidth', 'If true, segments size to their child width.'],
          ['disabledChildren', 'Set<T> of keys that should not respond.'],
        ],
        headerColor: _kAccentTeal,
      ),
    ],
  );
}

Widget _buildBoxedDefault() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _PrivateText(
        'A bare CupertinoSegmentedControl<int> uses the system blue tint '
        '(CupertinoColors.activeBlue) as both the border and the selected '
        'fill, with a white unselected fill.',
        size: 13.0,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 16.0),
      Center(
        child: SizedBox(
          width: 320.0,
          child: CupertinoSegmentedControl<int>(
            groupValue: _kBoxedDefaultValue,
            onValueChanged: _privateNoopInt,
            children: const <int, Widget>{
              0: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                child: Text('Day'),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                child: Text('Week'),
              ),
              2: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                child: Text('Month'),
              ),
            },
          ),
        ),
      ),
      const SizedBox(height: 12.0),
      Row(
        children: [
          _PrivateLabel(
            label: 'groupValue',
            value: '$_kBoxedDefaultValue',
            color: _kAccentBlue,
          ),
          const SizedBox(width: 8.0),
          const _PrivateLabel(
            label: 'children',
            value: '3',
            color: _kAccentTeal,
          ),
          const SizedBox(width: 8.0),
          const _PrivateLabel(
            label: 'style',
            value: 'boxed',
            color: _kAccentPink,
          ),
        ],
      ),
    ],
  );
}

Widget _buildBoxedStyled() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _PrivateText(
        'Customized colors: pink border, pink-on-white selected segment, '
        'soft pink press tint. Showcases selectedColor / unselectedColor / '
        'borderColor / pressedColor working together.',
        size: 13.0,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 16.0),
      Center(
        child: SizedBox(
          width: 360.0,
          child: CupertinoSegmentedControl<int>(
            groupValue: _kBoxedStyledValue,
            onValueChanged: _privateNoopInt,
            selectedColor: _kAccentPink,
            unselectedColor: CupertinoColors.white,
            borderColor: _kAccentPink,
            pressedColor: _kAccentPink.withValues(alpha: 0.18),
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 4.0,
            ),
            children: const <int, Widget>{
              0: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text('Tracks'),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text('Albums'),
              ),
              2: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text('Artists'),
              ),
              3: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text('Mixes'),
              ),
            },
          ),
        ),
      ),
      const SizedBox(height: 14.0),
      Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          _PrivateLabel(
            label: 'selectedColor',
            value: '#FF2D55',
            color: _kAccentPink,
          ),
          const _PrivateLabel(
            label: 'unselectedColor',
            value: '#FFFFFF',
            color: _kSubtleColor,
          ),
          _PrivateLabel(
            label: 'borderColor',
            value: '#FF2D55',
            color: _kAccentPink,
          ),
          _PrivateLabel(
            label: 'pressedColor',
            value: '18% pink',
            color: _kAccentPink,
          ),
        ],
      ),
    ],
  );
}

Widget _buildSlidingDefault() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _PrivateText(
        'A bare CupertinoSlidingSegmentedControl<String> uses the iOS system '
        'gray-5 background (#E5E5EA-ish in light mode) and a white thumb, '
        'matching the look of stock iOS 13+ segmented controls.',
        size: 13.0,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 16.0),
      Center(
        child: SizedBox(
          width: 360.0,
          child: CupertinoSlidingSegmentedControl<String>(
            groupValue: _kSlidingDefaultValue,
            onValueChanged: _privateNoopString,
            children: const <String, Widget>{
              'near': Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Text('Near'),
              ),
              'mid': Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Text('Mid'),
              ),
              'far': Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Text('Far'),
              ),
              'auto': Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Text('Auto'),
              ),
            },
          ),
        ),
      ),
      const SizedBox(height: 12.0),
      Row(
        children: [
          _PrivateLabel(
            label: 'groupValue',
            value: '"$_kSlidingDefaultValue"',
            color: _kAccentTeal,
          ),
          const SizedBox(width: 8.0),
          const _PrivateLabel(
            label: 'children',
            value: '4',
            color: _kAccentBlue,
          ),
          const SizedBox(width: 8.0),
          const _PrivateLabel(
            label: 'style',
            value: 'sliding',
            color: _kAccentGreen,
          ),
        ],
      ),
    ],
  );
}

Widget _buildSlidingStyled() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _PrivateText(
        'Customized thumb and track. Use thumbColor for the floating thumb '
        'and backgroundColor for the rounded track behind it. Both are '
        'safe to set to any Cupertino-friendly color.',
        size: 13.0,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 16.0),
      Center(
        child: SizedBox(
          width: 360.0,
          child: CupertinoSlidingSegmentedControl<String>(
            groupValue: _kSlidingStyledValue,
            onValueChanged: _privateNoopString,
            thumbColor: _kAccentTeal,
            backgroundColor: _kAccentTeal.withValues(alpha: 0.12),
            children: <String, Widget>{
              'near': Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                child: _PrivateText(
                  'Near',
                  size: 13.0,
                  weight: FontWeight.w600,
                  color: _kSlidingStyledValue == 'near'
                      ? CupertinoColors.white
                      : _kHeadingColor,
                ),
              ),
              'mid': Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                child: _PrivateText(
                  'Mid',
                  size: 13.0,
                  weight: FontWeight.w600,
                  color: _kSlidingStyledValue == 'mid'
                      ? CupertinoColors.white
                      : _kHeadingColor,
                ),
              ),
              'far': Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                child: _PrivateText(
                  'Far',
                  size: 13.0,
                  weight: FontWeight.w600,
                  color: _kSlidingStyledValue == 'far'
                      ? CupertinoColors.white
                      : _kHeadingColor,
                ),
              ),
              'auto': Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                child: _PrivateText(
                  'Auto',
                  size: 13.0,
                  weight: FontWeight.w600,
                  color: _kSlidingStyledValue == 'auto'
                      ? CupertinoColors.white
                      : _kHeadingColor,
                ),
              ),
            },
          ),
        ),
      ),
      const SizedBox(height: 14.0),
      Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          _PrivateLabel(
            label: 'thumbColor',
            value: '#30B0C7',
            color: _kAccentTeal,
          ),
          _PrivateLabel(
            label: 'backgroundColor',
            value: '12% teal',
            color: _kAccentTeal,
          ),
        ],
      ),
    ],
  );
}

Widget _buildMatrixCell({
  required String selected,
  required Color accent,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kPageBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kCardBorder, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            _PrivateText(
              'groupValue: "$selected"',
              size: 11.5,
              weight: FontWeight.w600,
              color: _kSubtleColor,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<String>(
            groupValue: selected,
            onValueChanged: _privateNoopString,
            thumbColor: accent,
            backgroundColor: accent.withValues(alpha: 0.12),
            children: <String, Widget>{
              'one': Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 6.0,
                ),
                child: _PrivateText(
                  'One',
                  size: 12.0,
                  weight: FontWeight.w600,
                  color: selected == 'one'
                      ? CupertinoColors.white
                      : _kHeadingColor,
                ),
              ),
              'two': Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 6.0,
                ),
                child: _PrivateText(
                  'Two',
                  size: 12.0,
                  weight: FontWeight.w600,
                  color: selected == 'two'
                      ? CupertinoColors.white
                      : _kHeadingColor,
                ),
              ),
              'three': Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 6.0,
                ),
                child: _PrivateText(
                  'Three',
                  size: 12.0,
                  weight: FontWeight.w600,
                  color: selected == 'three'
                      ? CupertinoColors.white
                      : _kHeadingColor,
                ),
              ),
              'four': Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 6.0,
                ),
                child: _PrivateText(
                  'Four',
                  size: 12.0,
                  weight: FontWeight.w600,
                  color: selected == 'four'
                      ? CupertinoColors.white
                      : _kHeadingColor,
                ),
              ),
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildSelectionMatrix() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _PrivateText(
        'Each row pins a different groupValue so the floating thumb shows '
        'every position. The control itself is identical in all four — only '
        'the static groupValue changes.',
        size: 13.0,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 12.0),
      _buildMatrixCell(selected: _kSlidingMatrixA, accent: _kAccentBlue),
      _buildMatrixCell(selected: _kSlidingMatrixB, accent: _kAccentTeal),
      _buildMatrixCell(selected: _kSlidingMatrixC, accent: _kAccentOrange),
      _buildMatrixCell(selected: _kSlidingMatrixD, accent: _kAccentPink),
    ],
  );
}

Widget _buildComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _PrivateText(
        'Both classes solve the same UX problem (pick one of N) but with '
        'different visual languages. Here is when to reach for which.',
        size: 13.0,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 12.0),
      const _PrivateTable(
        rows: [
          ['Aspect', 'Boxed vs Sliding'],
          [
            'Era',
            'Boxed: iOS 12-style. Sliding: iOS 13+ style.',
          ],
          [
            'Selection cue',
            'Boxed: filled segment. Sliding: floating thumb.',
          ],
          [
            'Animation',
            'Boxed: cross-fade. Sliding: thumb position animates.',
          ],
          [
            'Border',
            'Boxed: visible borderColor. Sliding: no outer border.',
          ],
          [
            'Background',
            'Boxed: unselectedColor per segment. Sliding: a single track.',
          ],
          [
            'Press feedback',
            'Boxed: pressedColor tint. Sliding: subtle thumb scale.',
          ],
          [
            'Disabled',
            'Both expose disabledChildren as a Set<T>.',
          ],
          [
            'Recommended',
            'Sliding for new apps; boxed only if you must match legacy.',
          ],
        ],
        headerColor: _kAccentOrange,
      ),
    ],
  );
}

Widget _buildNavBarUsage() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _PrivateText(
        'A common iOS pattern: put a sliding segmented control as the middle '
        'of a CupertinoNavigationBar. The bar tints itself with the system '
        'background and the segmented control handles the page-level filter.',
        size: 13.0,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 14.0),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: _kCardBorder, width: 1.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            CupertinoNavigationBar(
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Icon(
                  CupertinoIcons.back,
                  color: _kAccentBlue,
                ),
              ),
              middle: SizedBox(
                width: 220.0,
                child: CupertinoSlidingSegmentedControl<int>(
                  groupValue: _kNavBarSegmentValue,
                  onValueChanged: _privateNoopInt,
                  children: const <int, Widget>{
                    0: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 4.0,
                      ),
                      child: Text('Inbox'),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 4.0,
                      ),
                      child: Text('Sent'),
                    ),
                    2: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 4.0,
                      ),
                      child: Text('All'),
                    ),
                  },
                ),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Icon(
                  CupertinoIcons.add,
                  color: _kAccentBlue,
                ),
              ),
              backgroundColor: _kCardBg,
              border: const Border(
                bottom: BorderSide(
                  color: _kCardBorder,
                  width: 0.5,
                ),
              ),
            ),
            Container(
              height: 120.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    CupertinoIcons.tray_full,
                    size: 32.0,
                    color: _kSubtleColor,
                  ),
                  SizedBox(height: 8.0),
                  _PrivateText(
                    'Sent items would render here',
                    size: 13.0,
                    color: _kSubtleColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12.0),
      const _PrivateBullet(
        text: 'Wrap the control in a SizedBox to constrain its width inside '
            'the nav bar middle slot.',
        icon: CupertinoIcons.info_circle_fill,
        color: _kAccentBlue,
      ),
      const _PrivateBullet(
        text: 'Use CupertinoNavigationBar for static height; pair with '
            'CupertinoSliverNavigationBar if you want a large title that '
            'collapses.',
        icon: CupertinoIcons.info_circle_fill,
        color: _kAccentBlue,
      ),
    ],
  );
}

Widget _buildCodeListing() {
  const String code = '''
// Sliding control wired to a state holder:
CupertinoSlidingSegmentedControl<String>(
  groupValue: filter,
  onValueChanged: (String? next) {
    if (next != null) {
      // Persist `next` to your state holder.
    }
  },
  thumbColor: CupertinoColors.systemTeal,
  backgroundColor: CupertinoColors.systemGrey5,
  padding: const EdgeInsets.all(4.0),
  children: const <String, Widget>{
    'near': Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Text('Near'),
    ),
    'mid': Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Text('Mid'),
    ),
    'far': Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Text('Far'),
    ),
  },
);

// Boxed control with custom palette:
CupertinoSegmentedControl<int>(
  groupValue: tab,
  onValueChanged: (int next) {/* persist `next` */},
  selectedColor: CupertinoColors.systemPink,
  unselectedColor: CupertinoColors.white,
  borderColor: CupertinoColors.systemPink,
  pressedColor: CupertinoColors.systemPink.withValues(alpha: 0.18),
  children: const <int, Widget>{
    0: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Text('Tracks'),
    ),
    1: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Text('Albums'),
    ),
    2: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Text('Artists'),
    ),
  },
);
''';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _PrivateText(
        'Real-world constructor literals you can paste straight in. The first '
        'block is the sliding variant; the second is the boxed one.',
        size: 13.0,
        color: _kBodyColor,
        height: 1.45,
      ),
      const SizedBox(height: 12.0),
      const _PrivateCodeListing(
        code: code,
        caption: 'segmented_examples.dart',
      ),
    ],
  );
}

Widget _buildPitfalls() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      _PrivateBullet(
        text: 'children must contain at least 2 entries. Both classes assert '
            'this at construction; a single-segment control is a button.',
        icon: CupertinoIcons.exclamationmark_triangle_fill,
        color: _kAccentOrange,
      ),
      _PrivateBullet(
        text: 'groupValue must either be null or be a key present in '
            'children. A non-null mismatched value is treated as none-selected '
            'and the thumb / fill disappears.',
        icon: CupertinoIcons.exclamationmark_triangle_fill,
        color: _kAccentOrange,
      ),
      _PrivateBullet(
        text: 'Colors that come from CupertinoColors.* are dynamic — they '
            'resolve differently in light and dark mode. Pinning a const Color '
            'short-circuits that, so prefer system colors when possible.',
        icon: CupertinoIcons.moon_stars_fill,
        color: _kAccentBlue,
      ),
      _PrivateBullet(
        text: 'onValueChanged on the boxed variant takes a non-nullable T, '
            'while the sliding variant takes a nullable T?. Watch the '
            'signature when refactoring between the two.',
        icon: CupertinoIcons.exclamationmark_triangle_fill,
        color: _kAccentOrange,
      ),
      _PrivateBullet(
        text: 'Wrapping a sliding control in a fixed SizedBox is the '
            'reliable way to control its width — by default it expands to '
            'fill its parent.',
        icon: CupertinoIcons.checkmark_circle_fill,
        color: _kAccentGreen,
      ),
      _PrivateBullet(
        text: 'disabledChildren is a Set<T>, not a Map; use it to mark '
            'segments that should be visible but not selectable.',
        icon: CupertinoIcons.info_circle_fill,
        color: _kAccentTeal,
      ),
    ],
  );
}

Widget _buildFooter() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 32.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kCardBorder, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kAccentBlue, _kAccentTeal],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                CupertinoIcons.checkmark_seal_fill,
                color: CupertinoColors.white,
                size: 18.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: _PrivateText(
                'End of demo',
                size: 15.0,
                weight: FontWeight.w700,
                color: _kHeadingColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const _PrivateText(
          'CupertinoSegmentedControl and CupertinoSlidingSegmentedControl '
          'cover the same single-choice picker idiom in two different visual '
          'eras of iOS. Pick the sliding variant for new code, fall back to '
          'the boxed one only when you specifically need the iOS 12 look.',
          size: 12.5,
          color: _kBodyColor,
          height: 1.45,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: const [
            _PrivateChip(
              label: 'Cupertino',
              color: _kAccentBlue,
              icon: CupertinoIcons.device_phone_portrait,
            ),
            _PrivateChip(
              label: 'Segmented',
              color: _kAccentTeal,
              icon: CupertinoIcons.square_split_2x1,
            ),
            _PrivateChip(
              label: 'Sliding',
              color: _kAccentGreen,
              icon: CupertinoIcons.slider_horizontal_3,
            ),
            _PrivateChip(
              label: 'Boxed',
              color: _kAccentPink,
              icon: CupertinoIcons.square_grid_2x2,
            ),
            _PrivateChip(
              label: 'Demo',
              color: _kAccentOrange,
              icon: CupertinoIcons.eye_fill,
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// build entry
// ===========================================================================

dynamic build(BuildContext context) {
  // Defensive: keep dart:math reachable so the import is not dead. We use it
  // for nothing critical, just a clamp on the hero pill segment count.
  final int segments = math.max(3, 4);

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      backgroundColor: _kPageBg,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHero(),
              _PrivateSection(
                title: 'Anatomy: CupertinoSegmentedControl',
                subtitle:
                    'The boxed iOS 12-style picker. Hard pill, colored fill.',
                accent: _kAccentBlue,
                icon: CupertinoIcons.square_grid_2x2,
                child: _buildAnatomyBoxed(),
              ),
              _PrivateSection(
                title: 'Anatomy: CupertinoSlidingSegmentedControl',
                subtitle:
                    'The sliding iOS 13+ style picker. Soft track, floating thumb.',
                accent: _kAccentTeal,
                icon: CupertinoIcons.slider_horizontal_3,
                child: _buildAnatomySliding(),
              ),
              _PrivateSection(
                title: 'Default boxed control',
                subtitle: 'Default colors only — system blue tint.',
                accent: _kAccentBlue,
                icon: CupertinoIcons.circle_grid_3x3,
                child: _buildBoxedDefault(),
              ),
              _PrivateSection(
                title: 'Styled boxed control',
                subtitle:
                    'Custom selectedColor, unselectedColor, borderColor, '
                    'pressedColor.',
                accent: _kAccentPink,
                icon: CupertinoIcons.paintbrush_fill,
                child: _buildBoxedStyled(),
              ),
              _PrivateSection(
                title: 'Default sliding control',
                subtitle:
                    'Default colors only — system grey track + white thumb.',
                accent: _kAccentTeal,
                icon: CupertinoIcons.slider_horizontal_below_rectangle,
                child: _buildSlidingDefault(),
              ),
              _PrivateSection(
                title: 'Styled sliding control',
                subtitle: 'Custom thumbColor and backgroundColor.',
                accent: _kAccentTeal,
                icon: CupertinoIcons.paintbrush_fill,
                child: _buildSlidingStyled(),
              ),
              _PrivateSection(
                title: 'Selection-state matrix',
                subtitle:
                    'Same control, four different groupValues — see the '
                    'thumb in every position.',
                accent: _kAccentOrange,
                icon: CupertinoIcons.square_grid_3x2_fill,
                child: _buildSelectionMatrix(),
              ),
              _PrivateSection(
                title: 'Boxed vs sliding',
                subtitle: 'Side-by-side comparison of the two variants.',
                accent: _kAccentOrange,
                icon: CupertinoIcons.arrow_left_right_circle_fill,
                child: _buildComparison(),
              ),
              _PrivateSection(
                title: 'Navigation bar usage',
                subtitle:
                    'A typical iOS pattern: segmented control in a '
                    'CupertinoNavigationBar middle slot.',
                accent: _kAccentBlue,
                icon: CupertinoIcons.rectangle_stack,
                child: _buildNavBarUsage(),
              ),
              _PrivateSection(
                title: 'Code listing',
                subtitle:
                    'Realistic constructor literals for both classes.',
                accent: _kAccentGreen,
                icon: CupertinoIcons.chevron_left_slash_chevron_right,
                child: _buildCodeListing(),
              ),
              _PrivateSection(
                title: 'Pitfalls and notes',
                subtitle:
                    'Edge cases worth knowing before shipping a Cupertino '
                    'segmented control.',
                accent: _kAccentOrange,
                icon: CupertinoIcons.exclamationmark_triangle_fill,
                child: _buildPitfalls(),
              ),
              _buildFooter(),
              SizedBox(height: 8.0 + segments.toDouble() * 0.0),
            ],
          ),
        ),
      ),
    ),
  );
}
