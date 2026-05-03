// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of advanced Cupertino input controls.
//
// Showcases CupertinoSegmentedControl, CupertinoSlidingSegmentedControl,
// CupertinoSlider, CupertinoSwitch, CupertinoPicker (fixed-frame),
// CupertinoActivityIndicator (static), CupertinoTimerPicker (fixed-frame)
// and CupertinoDatePicker (fixed-frame). Each control is rendered in
// multiple configurations to demonstrate the parameter surface.
//
// Constraints: static `dynamic build(BuildContext context)`, no setState,
// no animations, no controllers, no for-in over BridgedInstance, all
// onChanged callbacks empty `(v) {}`, must pass `dart analyze` with zero
// issues. CupertinoActivityIndicator uses animating: false because the
// d4rt static-only sandbox cannot drive ticker-based animations.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

enum _SegOption { left, center, right, justify }

enum _ViewMode { list, grid, table }

enum _Density { compact, regular, comfortable }

enum _Sort { name, date, size, type }

dynamic build(BuildContext context) {
  return CupertinoApp(
    title: 'Cupertino Controls Advanced',
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemIndigo,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Advanced Cupertino Controls'),
        backgroundColor: Color(0xF8F8F8FA),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildIntroCard(),
            _buildSegmentedControlSection(),
            _buildSlidingSegmentedSection(),
            _buildSliderSection(),
            _buildSwitchSection(),
            _buildPickerSection(),
            _buildActivityIndicatorSection(),
            _buildTimerPickerSection(),
            _buildDatePickerSection(),
            _buildComparisonCard(),
            _buildUsageGuide(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Section: Intro Card
// ============================================================================

Widget _buildIntroCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF5E5CE6),
          Color(0xFF007AFF),
          Color(0xFF32ADE6),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x335E5CE6),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
        BoxShadow(
          color: Color(0x22007AFF),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: CupertinoColors.white.withOpacity(0.4),
                  width: 1.2,
                ),
              ),
              child: const Icon(
                CupertinoIcons.slider_horizontal_3,
                color: CupertinoColors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Advanced Cupertino Controls',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Pickers, sliders, switches and segmented inputs',
                    style: TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'iOS interface controls cover three major axes of user input: '
          'discrete choice (segmented controls), continuous range (sliders), '
          'binary state (switches), and multi-column wheel selection (pickers). '
          'This deep demo renders each in multiple configurations so the visual '
          'differences are obvious at a glance.',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _heroChip('CupertinoSegmentedControl'),
            _heroChip('CupertinoSlidingSegmentedControl'),
            _heroChip('CupertinoSlider'),
            _heroChip('CupertinoSwitch'),
            _heroChip('CupertinoPicker'),
            _heroChip('CupertinoActivityIndicator'),
            _heroChip('CupertinoTimerPicker'),
            _heroChip('CupertinoDatePicker'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: CupertinoColors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: CupertinoColors.white.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );
}

// ============================================================================
// Section 01: CupertinoSegmentedControl (older sliding segment)
// ============================================================================

Widget _buildSegmentedControlSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '01',
          title: 'CupertinoSegmentedControl',
          subtitle: 'Classic outlined segment selector',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9500), Color(0xFFFF6F00)],
          ),
          icon: CupertinoIcons.rectangle_split_3x1,
        ),
        const SizedBox(height: 12),
        _explanation(
          'CupertinoSegmentedControl is the original iOS segmented control. '
          'The selected value is fully filled with the active color while '
          'unselected segments stay outlined. Best for 2-4 options where the '
          'choice is mutually exclusive and visible at all times.',
        ),
        const SizedBox(height: 14),
        _whiteCard(
          title: 'Default colors, three values',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSegmentedControl<int>(
              groupValue: 1,
              children: const {
                0: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text('One'),
                ),
                1: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text('Two'),
                ),
                2: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text('Three'),
                ),
              },
              onValueChanged: (v) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Custom indigo color, four values',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSegmentedControl<_SegOption>(
              groupValue: _SegOption.center,
              selectedColor: const Color(0xFF5E5CE6),
              borderColor: const Color(0xFF5E5CE6),
              pressedColor: const Color(0x335E5CE6),
              unselectedColor: CupertinoColors.white,
              children: {
                _SegOption.left: _segIcon(CupertinoIcons.text_alignleft),
                _SegOption.center: _segIcon(CupertinoIcons.text_aligncenter),
                _SegOption.right: _segIcon(CupertinoIcons.text_alignright),
                _SegOption.justify: _segIcon(CupertinoIcons.text_justify),
              },
              onValueChanged: (v) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Green accent, view mode',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSegmentedControl<_ViewMode>(
              groupValue: _ViewMode.grid,
              selectedColor: const Color(0xFF34C759),
              borderColor: const Color(0xFF34C759),
              pressedColor: const Color(0x3334C759),
              children: const {
                _ViewMode.list: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  child: Text('List'),
                ),
                _ViewMode.grid: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  child: Text('Grid'),
                ),
                _ViewMode.table: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  child: Text('Table'),
                ),
              },
              onValueChanged: (v) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Pink accent, density',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSegmentedControl<_Density>(
              groupValue: _Density.regular,
              selectedColor: const Color(0xFFFF2D55),
              borderColor: const Color(0xFFFF2D55),
              pressedColor: const Color(0x33FF2D55),
              children: const {
                _Density.compact: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Compact'),
                ),
                _Density.regular: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Regular'),
                ),
                _Density.comfortable: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Comfy'),
                ),
              },
              onValueChanged: (v) {},
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _segIcon(IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
    child: Icon(icon, size: 18),
  );
}

// ============================================================================
// Section 02: CupertinoSlidingSegmentedControl (newer)
// ============================================================================

Widget _buildSlidingSegmentedSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '02',
          title: 'CupertinoSlidingSegmentedControl',
          subtitle: 'Modern iOS 13+ pill-style segment',
          gradient: const LinearGradient(
            colors: [Color(0xFF34C759), Color(0xFF30D158)],
          ),
          icon: CupertinoIcons.rectangle_grid_2x2,
        ),
        const SizedBox(height: 12),
        _explanation(
          'CupertinoSlidingSegmentedControl is the modern segment style used '
          'across iOS 13+. The selected segment is rendered as a floating '
          'rounded pill that slides between options. The unselected '
          'background is a subtle gray.',
        ),
        const SizedBox(height: 14),
        _whiteCard(
          title: 'Default style, four sort modes',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<_Sort>(
              groupValue: _Sort.date,
              children: const {
                _Sort.name: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Name'),
                ),
                _Sort.date: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Date'),
                ),
                _Sort.size: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Size'),
                ),
                _Sort.type: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Type'),
                ),
              },
              onValueChanged: (v) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Custom thumb color, two values',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<bool>(
              groupValue: true,
              thumbColor: const Color(0xFF007AFF),
              backgroundColor: const Color(0xFFE5E5EA),
              children: const {
                false: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text(
                    'Off',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                true: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text(
                    'On',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              },
              onValueChanged: (v) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Icon-only, three values',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<_ViewMode>(
              groupValue: _ViewMode.list,
              thumbColor: const Color(0xFF5E5CE6),
              backgroundColor: const Color(0xFFE0E0E5),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              children: const {
                _ViewMode.list: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Icon(
                    CupertinoIcons.list_bullet,
                    color: CupertinoColors.white,
                    size: 18,
                  ),
                ),
                _ViewMode.grid: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Icon(
                    CupertinoIcons.square_grid_2x2,
                    color: Color(0xFF333333),
                    size: 18,
                  ),
                ),
                _ViewMode.table: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Icon(
                    CupertinoIcons.table,
                    color: Color(0xFF333333),
                    size: 18,
                  ),
                ),
              },
              onValueChanged: (v) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Wide labels, three values',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<int>(
              groupValue: 0,
              thumbColor: CupertinoColors.white,
              backgroundColor: const Color(0xFFEAEAEF),
              children: const {
                0: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Text(
                    'Subscription',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                1: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Text('One-time'),
                ),
                2: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Text('Trial'),
                ),
              },
              onValueChanged: (v) {},
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 03: CupertinoSlider
// ============================================================================

Widget _buildSliderSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '03',
          title: 'CupertinoSlider',
          subtitle: 'Continuous and stepped value selection',
          gradient: const LinearGradient(
            colors: [Color(0xFF007AFF), Color(0xFF32ADE6)],
          ),
          icon: CupertinoIcons.slider_horizontal_3,
        ),
        const SizedBox(height: 12),
        _explanation(
          'CupertinoSlider supports continuous values along [min..max] or '
          'stepped values via the divisions parameter. Active and thumb '
          'colors map to the current iOS theme by default; the trackColor is '
          'a soft gray.',
        ),
        const SizedBox(height: 14),
        _sliderRow('value: 0.0 (min)', 0.0, const Color(0xFF007AFF)),
        const SizedBox(height: 8),
        _sliderRow('value: 0.25', 0.25, const Color(0xFF34C759)),
        const SizedBox(height: 8),
        _sliderRow('value: 0.5 (mid)', 0.5, const Color(0xFFFF9500)),
        const SizedBox(height: 8),
        _sliderRow('value: 0.7', 0.7, const Color(0xFF5E5CE6)),
        const SizedBox(height: 8),
        _sliderRow('value: 1.0 (max)', 1.0, const Color(0xFFFF2D55)),
        const SizedBox(height: 14),
        _whiteCard(
          title: 'Stepped slider, divisions: 10',
          child: Column(
            children: [
              CupertinoSlider(
                value: 0.6,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                activeColor: const Color(0xFF5E5CE6),
                thumbColor: CupertinoColors.white,
                onChanged: (v) {},
              ),
              const SizedBox(height: 4),
              const Text(
                'value 0.6, snaps to 0.1 increments',
                style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Wide range, min: -50, max: 50, divisions: 20',
          child: Column(
            children: [
              CupertinoSlider(
                value: 12.0,
                min: -50.0,
                max: 50.0,
                divisions: 20,
                activeColor: const Color(0xFFFF6F00),
                onChanged: (v) {},
              ),
              const SizedBox(height: 4),
              const Text(
                'value 12.0 of [-50..50], 20 divisions',
                style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Volume row with leading/trailing icons',
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.volume_off,
                color: Color(0xFF888888),
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CupertinoSlider(
                  value: 0.42,
                  activeColor: const Color(0xFF007AFF),
                  thumbColor: CupertinoColors.white,
                  onChanged: (v) {},
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                CupertinoIcons.volume_up,
                color: Color(0xFF888888),
                size: 18,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Brightness row',
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.sun_min,
                color: Color(0xFF888888),
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CupertinoSlider(
                  value: 0.85,
                  activeColor: const Color(0xFFFF9500),
                  onChanged: (v) {},
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                CupertinoIcons.sun_max_fill,
                color: Color(0xFFFF9500),
                size: 18,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sliderRow(String label, double value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE5E5EA)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF222222),
            ),
          ),
        ),
        Expanded(
          child: CupertinoSlider(
            value: value,
            activeColor: color,
            onChanged: (v) {},
          ),
        ),
        SizedBox(
          width: 42,
          child: Text(
            value.toStringAsFixed(2),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 04: CupertinoSwitch
// ============================================================================

Widget _buildSwitchSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '04',
          title: 'CupertinoSwitch',
          subtitle: 'Binary toggle with custom colors',
          gradient: const LinearGradient(
            colors: [Color(0xFF34C759), Color(0xFF00C7BE)],
          ),
          icon: CupertinoIcons.power,
        ),
        const SizedBox(height: 12),
        _explanation(
          'CupertinoSwitch is a single binary toggle. The active color fills '
          'the track when on; the trackColor sets the off-state background; '
          'thumbColor overrides the white knob. Use one switch per setting.',
        ),
        const SizedBox(height: 14),
        _switchRow(
          icon: CupertinoIcons.wifi,
          color: const Color(0xFF007AFF),
          title: 'Wi-Fi',
          subtitle: 'Connect to wireless networks',
          value: true,
        ),
        _switchRow(
          icon: CupertinoIcons.bluetooth,
          color: const Color(0xFF5E5CE6),
          title: 'Bluetooth',
          subtitle: 'Pair with nearby devices',
          value: true,
        ),
        _switchRow(
          icon: CupertinoIcons.airplane,
          color: const Color(0xFFFF9500),
          title: 'Airplane Mode',
          subtitle: 'Disable all wireless',
          value: false,
        ),
        _switchRow(
          icon: CupertinoIcons.moon_fill,
          color: const Color(0xFF8E8E93),
          title: 'Do Not Disturb',
          subtitle: 'Silence notifications',
          value: false,
        ),
        _switchRow(
          icon: CupertinoIcons.location_fill,
          color: const Color(0xFF34C759),
          title: 'Location Services',
          subtitle: 'Allow apps to use location',
          value: true,
        ),
        const SizedBox(height: 14),
        _whiteCard(
          title: 'Color spectrum: trackColor + activeColor',
          child: Column(
            children: [
              _coloredSwitchRow('System default', true,
                  activeColor: const Color(0xFF34C759)),
              _coloredSwitchRow('Indigo accent', true,
                  activeColor: const Color(0xFF5E5CE6)),
              _coloredSwitchRow('Pink accent', true,
                  activeColor: const Color(0xFFFF2D55)),
              _coloredSwitchRow('Orange accent', true,
                  activeColor: const Color(0xFFFF9500)),
              _coloredSwitchRow('Off (default)', false,
                  activeColor: const Color(0xFF34C759)),
              _coloredSwitchRow('Off, custom track', false,
                  activeColor: const Color(0xFF34C759),
                  trackColor: const Color(0xFFD1D1D6)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _switchRow({
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
  required bool value,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.35),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: CupertinoColors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
            ],
          ),
        ),
        CupertinoSwitch(
          value: value,
          activeColor: color,
          onChanged: (v) {},
        ),
      ],
    ),
  );
}

Widget _coloredSwitchRow(
  String label,
  bool value, {
  required Color activeColor,
  Color? trackColor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF333333),
            ),
          ),
        ),
        CupertinoSwitch(
          value: value,
          activeColor: activeColor,
          trackColor: trackColor,
          onChanged: (v) {},
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 05: CupertinoPicker (fixed-frame demo)
// ============================================================================

Widget _buildPickerSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '05',
          title: 'CupertinoPicker',
          subtitle: 'Wheel-style selection in a fixed frame',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF2D55), Color(0xFFFF6F00)],
          ),
          icon: CupertinoIcons.rectangle_dock,
        ),
        const SizedBox(height: 12),
        _explanation(
          'CupertinoPicker shows a vertical scroll wheel with magnification '
          'around the center selection. Wrap it in a SizedBox of a fixed '
          'height so the wheel can lay out. Use itemExtent to control the '
          'spacing of each row.',
        ),
        const SizedBox(height: 14),
        _whiteCard(
          title: 'Default itemExtent: 32, 12 items',
          child: SizedBox(
            height: 180,
            child: CupertinoPicker(
              itemExtent: 32.0,
              backgroundColor: CupertinoColors.white,
              onSelectedItemChanged: (i) {},
              children: const [
                Center(child: Text('Apple')),
                Center(child: Text('Banana')),
                Center(child: Text('Cherry')),
                Center(child: Text('Durian')),
                Center(child: Text('Elderberry')),
                Center(child: Text('Fig')),
                Center(child: Text('Grape')),
                Center(child: Text('Honeydew')),
                Center(child: Text('Iceberg')),
                Center(child: Text('Jackfruit')),
                Center(child: Text('Kiwi')),
                Center(child: Text('Lemon')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Magnifier on, large itemExtent',
          child: SizedBox(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 44.0,
              useMagnifier: true,
              magnification: 1.22,
              squeeze: 1.2,
              backgroundColor: const Color(0xFFFAFAFA),
              onSelectedItemChanged: (i) {},
              children: const [
                Center(
                  child: Text('Espresso',
                      style: TextStyle(fontSize: 18)),
                ),
                Center(
                  child: Text('Cappuccino',
                      style: TextStyle(fontSize: 18)),
                ),
                Center(
                  child: Text('Latte', style: TextStyle(fontSize: 18)),
                ),
                Center(
                  child:
                      Text('Macchiato', style: TextStyle(fontSize: 18)),
                ),
                Center(
                  child:
                      Text('Americano', style: TextStyle(fontSize: 18)),
                ),
                Center(
                  child: Text('Mocha', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Looping wheel, itemExtent: 30',
          child: SizedBox(
            height: 160,
            child: CupertinoPicker(
              itemExtent: 30.0,
              looping: true,
              backgroundColor: CupertinoColors.white,
              onSelectedItemChanged: (i) {},
              children: const [
                Center(child: Text('Mon')),
                Center(child: Text('Tue')),
                Center(child: Text('Wed')),
                Center(child: Text('Thu')),
                Center(child: Text('Fri')),
                Center(child: Text('Sat')),
                Center(child: Text('Sun')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Two-column picker, fruits + counts',
          child: SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    backgroundColor: CupertinoColors.white,
                    onSelectedItemChanged: (i) {},
                    children: const [
                      Center(child: Text('Apple')),
                      Center(child: Text('Orange')),
                      Center(child: Text('Pear')),
                      Center(child: Text('Plum')),
                      Center(child: Text('Mango')),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    backgroundColor: CupertinoColors.white,
                    onSelectedItemChanged: (i) {},
                    children: const [
                      Center(child: Text('1')),
                      Center(child: Text('2')),
                      Center(child: Text('3')),
                      Center(child: Text('4')),
                      Center(child: Text('5')),
                      Center(child: Text('6')),
                      Center(child: Text('7')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 06: CupertinoActivityIndicator (static)
// ============================================================================

Widget _buildActivityIndicatorSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '06',
          title: 'CupertinoActivityIndicator',
          subtitle: 'Static spinner samples (animating: false)',
          gradient: const LinearGradient(
            colors: [Color(0xFF8E8E93), Color(0xFF48484A)],
          ),
          icon: CupertinoIcons.arrow_2_circlepath,
        ),
        const SizedBox(height: 12),
        _explanation(
          'CupertinoActivityIndicator is the iOS spinner. The d4rt sandbox '
          'is static, so this demo uses animating: false to render the '
          'frozen spinner shape — useful for layout previews. In production, '
          'leave animating: true (the default) for the rotating animation.',
        ),
        const SizedBox(height: 14),
        _whiteCard(
          title: 'Default radius (10)',
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CupertinoActivityIndicator(animating: false),
              CupertinoActivityIndicator(animating: false),
              CupertinoActivityIndicator(animating: false),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Different radii',
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(animating: false, radius: 8),
              CupertinoActivityIndicator(animating: false, radius: 12),
              CupertinoActivityIndicator(animating: false, radius: 16),
              CupertinoActivityIndicator(animating: false, radius: 22),
              CupertinoActivityIndicator(animating: false, radius: 30),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Custom colors',
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CupertinoActivityIndicator(
                animating: false,
                radius: 14,
                color: Color(0xFF007AFF),
              ),
              CupertinoActivityIndicator(
                animating: false,
                radius: 14,
                color: Color(0xFF34C759),
              ),
              CupertinoActivityIndicator(
                animating: false,
                radius: 14,
                color: Color(0xFFFF9500),
              ),
              CupertinoActivityIndicator(
                animating: false,
                radius: 14,
                color: Color(0xFFFF2D55),
              ),
              CupertinoActivityIndicator(
                animating: false,
                radius: 14,
                color: Color(0xFF5E5CE6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'In context: loading row',
          child: Row(
            children: const [
              CupertinoActivityIndicator(animating: false, radius: 11),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Loading content...',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'In context: button busy state',
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF007AFF),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33007AFF),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActivityIndicator(
                  animating: false,
                  radius: 9,
                  color: CupertinoColors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'Submitting…',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 07: CupertinoTimerPicker (fixed-frame)
// ============================================================================

Widget _buildTimerPickerSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '07',
          title: 'CupertinoTimerPicker',
          subtitle: 'Duration selection wheel',
          gradient: const LinearGradient(
            colors: [Color(0xFF5E5CE6), Color(0xFFAF52DE)],
          ),
          icon: CupertinoIcons.timer,
        ),
        const SizedBox(height: 12),
        _explanation(
          'CupertinoTimerPicker is used for selecting durations. The mode '
          'parameter switches between hour-minute (hm), minute-second (ms) '
          'and full hour-minute-second (hms). Wrap in a fixed-height frame.',
        ),
        const SizedBox(height: 14),
        _whiteCard(
          title: 'Mode: hm (hour + minute)',
          child: SizedBox(
            height: 180,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              initialTimerDuration: const Duration(hours: 2, minutes: 30),
              onTimerDurationChanged: (d) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Mode: ms (minute + second)',
          child: SizedBox(
            height: 180,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.ms,
              initialTimerDuration: const Duration(minutes: 5, seconds: 30),
              onTimerDurationChanged: (d) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Mode: hms (full)',
          child: SizedBox(
            height: 200,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hms,
              initialTimerDuration:
                  const Duration(hours: 1, minutes: 15, seconds: 45),
              minuteInterval: 5,
              secondInterval: 5,
              onTimerDurationChanged: (d) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Custom background and minute interval',
          child: SizedBox(
            height: 180,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              initialTimerDuration: const Duration(hours: 0, minutes: 45),
              minuteInterval: 15,
              backgroundColor: const Color(0xFFF2F2F7),
              onTimerDurationChanged: (d) {},
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 08: CupertinoDatePicker (fixed-frame)
// ============================================================================

Widget _buildDatePickerSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '08',
          title: 'CupertinoDatePicker',
          subtitle: 'Calendar wheel selection',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6F00), Color(0xFFFF2D55)],
          ),
          icon: CupertinoIcons.calendar,
        ),
        const SizedBox(height: 12),
        _explanation(
          'CupertinoDatePicker supports four modes: time, date, dateAndTime '
          'and monthYear. Constrain available range with minimumDate and '
          'maximumDate. Wrap in a fixed-height frame for layout.',
        ),
        const SizedBox(height: 14),
        _whiteCard(
          title: 'Mode: time',
          child: SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime(2026, 5, 3, 14, 30),
              use24hFormat: false,
              minuteInterval: 1,
              onDateTimeChanged: (d) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Mode: date',
          child: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2026, 5, 3),
              minimumDate: DateTime(2020, 1, 1),
              maximumDate: DateTime(2030, 12, 31),
              onDateTimeChanged: (d) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Mode: dateAndTime, 24h format',
          child: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: DateTime(2026, 5, 3, 9, 15),
              use24hFormat: true,
              minuteInterval: 5,
              onDateTimeChanged: (d) {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        _whiteCard(
          title: 'Mode: monthYear',
          child: SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.monthYear,
              initialDateTime: DateTime(2026, 5, 1),
              minimumDate: DateTime(2020, 1, 1),
              maximumDate: DateTime(2030, 12, 31),
              onDateTimeChanged: (d) {},
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 09: Comparison decision card
// ============================================================================

Widget _buildComparisonCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF9500), Color(0xFFFF6F00)],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x55FF9500),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.lightbulb_fill,
                color: CupertinoColors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Which control to use?',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _comparisonRow(
          'Discrete choice (2-4 options)',
          'CupertinoSegmentedControl or CupertinoSlidingSegmentedControl',
          const Color(0xFF34C759),
        ),
        _comparisonRow(
          'Continuous numeric range',
          'CupertinoSlider (with optional divisions for steps)',
          const Color(0xFF007AFF),
        ),
        _comparisonRow(
          'Binary on/off setting',
          'CupertinoSwitch',
          const Color(0xFF5E5CE6),
        ),
        _comparisonRow(
          'Choose from many options',
          'CupertinoPicker (vertical wheel)',
          const Color(0xFFFF2D55),
        ),
        _comparisonRow(
          'Pick a duration',
          'CupertinoTimerPicker',
          const Color(0xFFAF52DE),
        ),
        _comparisonRow(
          'Pick a date or time',
          'CupertinoDatePicker',
          const Color(0xFFFF9500),
        ),
        _comparisonRow(
          'Indicate work in progress',
          'CupertinoActivityIndicator',
          const Color(0xFF8E8E93),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(String when, String pick, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.55),
                blurRadius: 6,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                when,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                pick,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 10: Usage guide
// ============================================================================

Widget _buildUsageGuide() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFF5E6), Color(0xFFFFE9CC)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFFFD08A)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22FF9500),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(
              Icons.menu_book,
              color: Color(0xFFFF6F00),
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              'Usage guide',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A4A00),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _guideItem(
          CupertinoIcons.checkmark_seal_fill,
          'Wrap pickers in a fixed-height SizedBox',
          'CupertinoPicker, CupertinoTimerPicker and CupertinoDatePicker '
              'render only when given a bounded vertical extent.',
        ),
        _guideItem(
          CupertinoIcons.checkmark_seal_fill,
          'Prefer Sliding over classic Segmented for new UIs',
          'CupertinoSlidingSegmentedControl matches modern iOS 13+ design '
              'while the classic CupertinoSegmentedControl is retained for '
              'backwards style.',
        ),
        _guideItem(
          CupertinoIcons.checkmark_seal_fill,
          'Use divisions on sliders for stepped values',
          'When the user should pick from N discrete steps, supply '
              'divisions: N. Otherwise the slider is fully continuous.',
        ),
        _guideItem(
          CupertinoIcons.checkmark_seal_fill,
          'CupertinoSwitch works one setting at a time',
          'Each switch toggles a single boolean. For mutually exclusive '
              'choices use a segmented control instead.',
        ),
        _guideItem(
          CupertinoIcons.exclamationmark_triangle_fill,
          'Activity indicator must animate in production',
          'The default is animating: true. The animating: false flag in '
              'this demo only exists to satisfy the static d4rt sandbox.',
        ),
        _guideItem(
          CupertinoIcons.info_circle_fill,
          'Picker use24hFormat affects only time fields',
          'Date-only modes ignore use24hFormat. Combine with minuteInterval '
              'for coarser steps (e.g. 5, 15, 30).',
        ),
        _guideItem(
          CupertinoIcons.info_circle_fill,
          'TimerPicker mode picks the visible columns',
          'hm = hour+minute, ms = minute+second, hms = all three. Choose '
              'the mode based on the granularity the user actually needs.',
        ),
      ],
    ),
  );
}

Widget _guideItem(IconData icon, String title, String description) {
  Color color;
  if (icon == CupertinoIcons.exclamationmark_triangle_fill) {
    color = const Color(0xFFFF9500);
  } else if (icon == CupertinoIcons.info_circle_fill) {
    color = const Color(0xFF007AFF);
  } else {
    color = const Color(0xFF34C759);
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Helpers
// ============================================================================

Widget _sectionHeader({
  required String number,
  required String title,
  required String subtitle,
  required Gradient gradient,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: CupertinoColors.white.withOpacity(0.22),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: CupertinoColors.white.withOpacity(0.4),
            ),
          ),
          child: Icon(icon, color: CupertinoColors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      number,
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xE6FFFFFF),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _whiteCard({required String title, required Widget child}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE5E5EA)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF666666),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

Widget _explanation(String text) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE5E5EA)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          CupertinoIcons.info_circle_fill,
          color: Color(0xFF007AFF),
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF333333),
            ),
          ),
        ),
      ],
    ),
  );
}
