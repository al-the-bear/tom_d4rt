// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of secondary Cupertino widgets.
//
// Showcases the iOS-style helper widgets that supplement the core
// Cupertino UI: CupertinoNavigationBarBackButton, the three CupertinoButton
// styles (plain / tinted / filled), a hand-styled CupertinoCloseButton
// surrogate, CupertinoSearchTextField, plus surrogate renderings of
// CupertinoContextMenu / CupertinoContextMenuAction, CupertinoActionSheet,
// CupertinoAlertDialog, CupertinoSliverNavigationBar, and
// CupertinoPopupSurface.
//
// Constraints: static `dynamic build(BuildContext context)`, no setState,
// no animations, no controllers, no for-in over BridgedInstance, all
// onPressed/onTap/onChanged callbacks empty `() {}` or `(v) {}`, no
// TextEditingController, no Tween.animate().value, must pass `dart analyze`
// with zero issues.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

dynamic build(BuildContext context) {
  return CupertinoApp(
    title: 'Cupertino Secondary',
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemBlue,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Secondary Widgets'),
        backgroundColor: Color(0xF8F8F8FA),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildIntroCard(),
            _buildButtonVariants(),
            _buildBackAndCloseButtons(),
            _buildSearchTextFieldSection(),
            _buildContextMenuSurrogate(),
            _buildActionSheetSurrogate(),
            _buildAlertDialogSurrogate(),
            _buildSliverNavBarSection(),
            _buildPopupSurfaceSection(),
            _buildUsageGuide(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Section 01: Intro Card
// ============================================================================

Widget _buildIntroCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0A84FF),
          Color(0xFF5E5CE6),
          Color(0xFFAF52DE),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x335E5CE6),
          blurRadius: 18,
          offset: Offset(0, 10),
        ),
        BoxShadow(
          color: Color(0x220A84FF),
          blurRadius: 4,
          offset: Offset(0, 2),
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
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: CupertinoColors.white.withOpacity(0.35),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.square_grid_2x2_fill,
                color: CupertinoColors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cupertino Secondary Widgets',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Buttons, search, dialogs, popups',
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
        const SizedBox(height: 16),
        const Text(
          'A tour of the small but essential iOS-style helpers that surround '
          'the main Cupertino canvas. CupertinoButton supplies the plain, '
          'tinted, and filled styles. CupertinoNavigationBarBackButton drops '
          'the iconic chevron + label affordance into custom navigation bars. '
          'CupertinoSearchTextField mirrors the rounded grey search pill from '
          'the iOS Mail and Settings apps. The dialog family — alert, action '
          'sheet, context menu, popup surface — assembles on top of '
          'CupertinoPopupSurface to match Apple Human Interface Guidelines.',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _heroChip('CupertinoButton'),
            _heroChip('.tinted'),
            _heroChip('.filled'),
            _heroChip('BackButton'),
            _heroChip('CloseButton'),
            _heroChip('SearchTextField'),
            _heroChip('ContextMenu'),
            _heroChip('ActionSheet'),
            _heroChip('AlertDialog'),
            _heroChip('SliverNavBar'),
            _heroChip('PopupSurface'),
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
      border: Border.all(color: CupertinoColors.white.withOpacity(0.35)),
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
// Section 02: CupertinoButton variants
// ============================================================================

Widget _buildButtonVariants() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '02',
          title: 'CupertinoButton — plain, tinted, filled',
          subtitle: 'The three iOS button emphases plus size variants',
          gradient: const LinearGradient(
            colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
          ),
          icon: CupertinoIcons.rectangle_fill_on_rectangle_fill,
        ),
        const SizedBox(height: 12),
        _buttonAnatomyCard(),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallLabel('Plain (text-only emphasis)'),
              const SizedBox(height: 6),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    onPressed: () {},
                    sizeStyle: CupertinoButtonSize.small,
                    child: const Text('Small'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _smallLabel('Tinted (subtle accent fill)'),
              const SizedBox(height: 6),
              Row(
                children: [
                  CupertinoButton.tinted(
                    onPressed: () {},
                    child: const Text('Subscribe'),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton.tinted(
                    onPressed: () {},
                    color: CupertinoColors.systemRed,
                    child: const Text('Delete'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _smallLabel('Filled (high-emphasis primary)'),
              const SizedBox(height: 6),
              Row(
                children: [
                  CupertinoButton.filled(
                    onPressed: () {},
                    child: const Text('Continue'),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton.filled(
                    onPressed: () {},
                    sizeStyle: CupertinoButtonSize.small,
                    child: const Text('Save'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _smallLabel('Disabled (onPressed: null)'),
              const SizedBox(height: 6),
              Row(
                children: [
                  const CupertinoButton(
                    onPressed: null,
                    child: Text('Plain off'),
                  ),
                  const SizedBox(width: 8),
                  const CupertinoButton.tinted(
                    onPressed: null,
                    child: Text('Tinted off'),
                  ),
                  const SizedBox(width: 8),
                  const CupertinoButton.filled(
                    onPressed: null,
                    child: Text('Filled off'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _smallLabel('Custom color + icon child'),
              const SizedBox(height: 6),
              Row(
                children: [
                  CupertinoButton.filled(
                    onPressed: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          CupertinoIcons.cloud_download,
                          size: 18,
                          color: CupertinoColors.white,
                        ),
                        SizedBox(width: 8),
                        Text('Get'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton.tinted(
                    onPressed: () {},
                    color: CupertinoColors.systemPurple,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          CupertinoIcons.share,
                          size: 18,
                          color: CupertinoColors.systemPurple,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Share',
                          style:
                              TextStyle(color: CupertinoColors.systemPurple),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoButton has three named entry points. The default '
          'constructor renders text in the theme primary color with no fill. '
          '`.tinted` adds a translucent tint of the theme primary color (or a '
          'custom `color`). `.filled` renders the high-emphasis CTA used on '
          'sign-in screens and modal confirmations. The `sizeStyle` parameter '
          'switches between `large`, `medium`, and `small` heights.',
        ),
      ],
    ),
  );
}

Widget _buttonAnatomyCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFAFCFF),
          Color(0xFFE8F1FF),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFB3D4FF)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14007AFF),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              CupertinoIcons.square_split_2x2,
              color: Color(0xFF007AFF),
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Button anatomy',
              style: TextStyle(
                color: Color(0xFF003E80),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _slotRow(
          icon: CupertinoIcons.textformat,
          label: 'child',
          description: 'Text or icon, padded inside the touch target.',
        ),
        _slotRow(
          icon: CupertinoIcons.paintbrush,
          label: 'color / disabledColor',
          description: 'Background fill (filled / tinted) or no fill (plain).',
        ),
        _slotRow(
          icon: CupertinoIcons.text_cursor,
          label: 'foregroundColor',
          description: 'Resolved text + icon color across all three styles.',
        ),
        _slotRow(
          icon: CupertinoIcons.resize_h,
          label: 'sizeStyle',
          description: 'large (default), medium, small height presets.',
        ),
        _slotRow(
          icon: CupertinoIcons.app_badge,
          label: 'borderRadius',
          description: 'Defaults to size-aware iOS pill curvature.',
        ),
        _slotRow(
          icon: CupertinoIcons.hand_point_left_fill,
          label: 'pressedOpacity',
          description: 'Opacity applied during a press, default 0.4.',
        ),
        _slotRow(
          icon: CupertinoIcons.cursor_rays,
          label: 'onPressed / onLongPress',
          description: 'Tap and long-press callbacks. Null disables the button.',
        ),
      ],
    ),
  );
}

Widget _slotRow({
  required IconData icon,
  required String label,
  required String description,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF007AFF), size: 18),
        const SizedBox(width: 10),
        Container(
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0FE),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF99C2FF)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1A237E),
              fontSize: 12,
              fontFamily: 'Menlo',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 03: BackButton + CloseButton
// ============================================================================

Widget _buildBackAndCloseButtons() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '03',
          title: 'CupertinoNavigationBarBackButton + close button',
          subtitle: 'Iconic chevron+label and a styled X button surrogate',
          gradient: const LinearGradient(
            colors: [Color(0xFF34C759), Color(0xFF30D158)],
          ),
          icon: CupertinoIcons.back,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallLabel('Mock navigation bar with back button + close'),
              const SizedBox(height: 8),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xF8F8F8FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E5EA)),
                ),
                child: Row(
                  children: [
                    CupertinoNavigationBarBackButton(
                      previousPageTitle: 'Inbox',
                      color: CupertinoColors.systemBlue,
                      onPressed: () {},
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Message',
                          style: TextStyle(
                            color: Color(0xFF1C1C1E),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    _closeButtonSurrogate(),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _smallLabel('Back-button color overrides'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFF7E6), Color(0xFFFFE0A3)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          CupertinoNavigationBarBackButton(
                            previousPageTitle: 'Reading',
                            color: const Color(0xFFCC7A00),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFCEFFF), Color(0xFFE5C8FF)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          CupertinoNavigationBarBackButton(
                            previousPageTitle: 'Library',
                            color: const Color(0xFF8E2DE2),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _smallLabel('Close button surrogates'),
              const SizedBox(height: 8),
              Row(
                children: [
                  _closeButtonSurrogate(),
                  const SizedBox(width: 14),
                  _closeButtonSurrogate(
                    background: const Color(0xFFFFEBEB),
                    iconColor: CupertinoColors.systemRed,
                  ),
                  const SizedBox(width: 14),
                  _closeButtonSurrogate(
                    background: const Color(0xFFE6F1FF),
                    iconColor: CupertinoColors.systemBlue,
                  ),
                  const SizedBox(width: 14),
                  _closeButtonSurrogate(
                    background: const Color(0xFFE9F8EE),
                    iconColor: CupertinoColors.systemGreen,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _smallLabel('Material vs Cupertino close glyph'),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E5EA)),
                ),
                child: Row(
                  children: [
                    _materialIconCompare(),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Icons.close (Material) and CupertinoIcons.xmark '
                        '(Cupertino) — visually similar but the Cupertino '
                        'glyph is slightly thinner.',
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoNavigationBarBackButton renders the iconic chevron and '
          'previous-page label affordance used in Apple navigation bars. '
          'Provide `onPressed` to drive a custom navigation action and the '
          'system pop assertion is bypassed. CupertinoCloseButton is not part '
          'of the Cupertino library; the surrogate above mirrors the pill-X '
          'used inside iOS modal sheets and is built from a CupertinoButton '
          'with a circular grey fill.',
        ),
      ],
    ),
  );
}

Widget _closeButtonSurrogate({
  Color background = const Color(0xFFE5E5EA),
  Color iconColor = const Color(0xFF8E8E93),
}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: () {},
    child: Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(CupertinoIcons.xmark, color: iconColor, size: 14),
    ),
  );
}

// ============================================================================
// Section 04: CupertinoSearchTextField
// ============================================================================

Widget _buildSearchTextFieldSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '04',
          title: 'CupertinoSearchTextField',
          subtitle: 'Rounded grey search pill with prefix + suffix',
          gradient: const LinearGradient(
            colors: [Color(0xFFAF52DE), Color(0xFFBF5AF2)],
          ),
          icon: CupertinoIcons.search,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallLabel('Default search field'),
              const SizedBox(height: 6),
              CupertinoSearchTextField(
                placeholder: 'Search',
                onChanged: (v) {},
                onSubmitted: (v) {},
              ),
              const SizedBox(height: 14),
              _smallLabel('Custom placeholder + suffix always visible'),
              const SizedBox(height: 6),
              CupertinoSearchTextField(
                placeholder: 'Search messages, people, attachments',
                suffixMode: OverlayVisibilityMode.always,
                onChanged: (v) {},
              ),
              const SizedBox(height: 14),
              _smallLabel('Tinted background + custom prefix icon'),
              const SizedBox(height: 6),
              CupertinoSearchTextField(
                placeholder: 'Filter library',
                backgroundColor: const Color(0xFFF1E8FF),
                prefixIcon: const Icon(
                  CupertinoIcons.line_horizontal_3_decrease,
                  color: Color(0xFF7D2FBE),
                  size: 18,
                ),
                suffixIcon: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: Color(0xFF7D2FBE),
                  size: 18,
                ),
                style: const TextStyle(
                  color: Color(0xFF441A66),
                  fontSize: 15,
                ),
                onChanged: (v) {},
              ),
              const SizedBox(height: 14),
              _smallLabel('Boxed decoration with border'),
              const SizedBox(height: 6),
              CupertinoSearchTextField(
                placeholder: 'Search the catalog',
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FBFF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF99C2FF)),
                ),
                onChanged: (v) {},
              ),
              const SizedBox(height: 14),
              _smallLabel('Disabled state'),
              const SizedBox(height: 6),
              const CupertinoSearchTextField(
                placeholder: 'Search disabled',
                enabled: false,
              ),
              const SizedBox(height: 14),
              _smallLabel('Anatomy diagram'),
              const SizedBox(height: 6),
              _searchAnatomy(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoSearchTextField wraps a Cupertino text field with a '
          'rounded translucent grey background, a magnifying-glass prefix '
          'icon, and an optional clear-mark suffix. `suffixMode` controls '
          'when the X appears: `editing`, `notEditing`, `always`, or `never`. '
          'The widget accepts a `decoration` for full visual control or a '
          '`backgroundColor` shortcut. No controller is required when only '
          'reading values via `onChanged` / `onSubmitted`.',
        ),
      ],
    ),
  );
}

Widget _searchAnatomy() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFFAF5FF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD9B3FF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _searchSlotChip('prefixIcon', const Color(0xFFE0C2FF)),
            const SizedBox(width: 6),
            const Icon(
              CupertinoIcons.right_chevron,
              size: 14,
              color: Color(0xFF8E8E93),
            ),
            const SizedBox(width: 6),
            _searchSlotChip('placeholder', const Color(0xFFD0E5FF)),
            const SizedBox(width: 6),
            const Icon(
              CupertinoIcons.right_chevron,
              size: 14,
              color: Color(0xFF8E8E93),
            ),
            const SizedBox(width: 6),
            _searchSlotChip('suffixIcon', const Color(0xFFFFE0C2)),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'prefixIcon → typing area showing placeholder or text → '
          'suffixIcon (visibility controlled by suffixMode).',
          style: TextStyle(
            color: Color(0xFF441A66),
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _searchSlotChip(String label, Color background) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFF1C1C1E),
        fontSize: 12,
        fontFamily: 'Menlo',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ============================================================================
// Section 05: CupertinoContextMenu surrogate
// ============================================================================

Widget _buildContextMenuSurrogate() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '05',
          title: 'CupertinoContextMenu — sheet surrogate',
          subtitle: 'Default, destructive, and trailing-icon actions',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9500), Color(0xFFFFCC00)],
          ),
          icon: CupertinoIcons.square_grid_3x2,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallLabel('Static preview tile (the "child")'),
              const SizedBox(height: 8),
              Container(
                height: 130,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFF9500), Color(0xFFFF3B30)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33FF9500),
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.photo,
                      color: CupertinoColors.white,
                      size: 36,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Press-and-hold preview',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _smallLabel('Sheet of CupertinoContextMenuActions'),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F8),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CupertinoContextMenuAction(
                        isDefaultAction: true,
                        trailingIcon: CupertinoIcons.eye,
                        onPressed: () {},
                        child: const Text('View'),
                      ),
                      _menuDivider(),
                      CupertinoContextMenuAction(
                        trailingIcon: CupertinoIcons.share,
                        onPressed: () {},
                        child: const Text('Share'),
                      ),
                      _menuDivider(),
                      CupertinoContextMenuAction(
                        trailingIcon: CupertinoIcons.bookmark,
                        onPressed: () {},
                        child: const Text('Save to Reading List'),
                      ),
                      _menuDivider(),
                      CupertinoContextMenuAction(
                        isDestructiveAction: true,
                        trailingIcon: CupertinoIcons.delete,
                        onPressed: () {},
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _smallLabel('Variant: editing actions'),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F8),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CupertinoContextMenuAction(
                        trailingIcon: CupertinoIcons.pencil,
                        onPressed: () {},
                        child: const Text('Edit'),
                      ),
                      _menuDivider(),
                      CupertinoContextMenuAction(
                        trailingIcon: CupertinoIcons.doc_on_doc,
                        onPressed: () {},
                        child: const Text('Duplicate'),
                      ),
                      _menuDivider(),
                      CupertinoContextMenuAction(
                        trailingIcon: CupertinoIcons.tray_arrow_down,
                        onPressed: () {},
                        child: const Text('Archive'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoContextMenu opens on long-press and reveals a floating '
          'sheet of CupertinoContextMenuAction rows. Each action exposes '
          '`isDefaultAction` (bold blue), `isDestructiveAction` (red), and a '
          '`trailingIcon` slot rendered to the right of the label. Because '
          'the lifecycle would require gestures, we render the action sheet '
          'directly — the visual output matches the popped-open state.',
        ),
      ],
    ),
  );
}

Widget _menuDivider() {
  return Container(
    height: 1,
    color: const Color(0xFFE5E5EA),
  );
}

// ============================================================================
// Section 06: CupertinoActionSheet surrogate
// ============================================================================

Widget _buildActionSheetSurrogate() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '06',
          title: 'CupertinoActionSheet — surrogate',
          subtitle: 'Title, message, actions, and a separated cancel button',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF3B30), Color(0xFFFF6482)],
          ),
          icon: CupertinoIcons.tray_full,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF1F0), Color(0xFFFFE3E0)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallLabel('Hand-rendered action sheet (visual surrogate)'),
              const SizedBox(height: 10),
              _actionSheetCard(
                title: 'Move to Folder',
                message:
                    'Choose where to save this thread. You can move it back '
                    'later from the message view.',
                items: const [
                  _ActionItem(label: 'Personal', isDefault: true),
                  _ActionItem(label: 'Work'),
                  _ActionItem(label: 'Newsletters'),
                  _ActionItem(label: 'Junk', isDestructive: true),
                ],
                cancelLabel: 'Cancel',
              ),
              const SizedBox(height: 16),
              _smallLabel('Sheet without a title'),
              const SizedBox(height: 10),
              _actionSheetCard(
                title: null,
                message: 'Select a sharing option',
                items: const [
                  _ActionItem(label: 'AirDrop', isDefault: true),
                  _ActionItem(label: 'Messages'),
                  _ActionItem(label: 'Mail'),
                ],
                cancelLabel: 'Cancel',
              ),
              const SizedBox(height: 16),
              _smallLabel('Destructive primary action'),
              const SizedBox(height: 10),
              _actionSheetCard(
                title: 'Discard Draft?',
                message: 'Are you sure you want to permanently delete this '
                    'draft? This cannot be undone.',
                items: const [
                  _ActionItem(
                    label: 'Discard Draft',
                    isDestructive: true,
                  ),
                ],
                cancelLabel: 'Keep Editing',
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoActionSheet is a modal sheet that slides up from the '
          'bottom edge. It accepts an optional `title`, `message`, an '
          '`actions` list of CupertinoActionSheetAction widgets, and a '
          'separated `cancelButton`. Showing it requires '
          '`showCupertinoModalPopup`, which is gesture-driven and unsuited '
          'for this static demo — the surrogate here mirrors the rendered '
          'frame down to the rounded card and divider stroke.',
        ),
      ],
    ),
  );
}

class _ActionItem {
  const _ActionItem({
    required this.label,
    this.isDefault = false,
    this.isDestructive = false,
  });

  final String label;
  final bool isDefault;
  final bool isDestructive;
}

Widget _actionSheetCard({
  required String? title,
  required String message,
  required List<_ActionItem> items,
  required String cancelLabel,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F8),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              if (title != null || message.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Column(
                    children: [
                      if (title != null)
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF1C1C1E),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      if (title != null) const SizedBox(height: 4),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              if (title != null || message.isNotEmpty) _menuDivider(),
              ..._actionRows(items),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Color(0xFFF7F7F8)),
          child: Text(
            cancelLabel,
            style: const TextStyle(
              color: CupertinoColors.systemBlue,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ],
  );
}

List<Widget> _actionRows(List<_ActionItem> items) {
  final rows = <Widget>[];
  for (var i = 0; i < items.length; i++) {
    final item = items[i];
    Color color = CupertinoColors.systemBlue;
    FontWeight weight = FontWeight.w400;
    if (item.isDestructive) {
      color = CupertinoColors.systemRed;
    }
    if (item.isDefault) {
      weight = FontWeight.w700;
    }
    rows.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        child: Text(
          item.label,
          style: TextStyle(
            color: color,
            fontSize: 17,
            fontWeight: weight,
          ),
        ),
      ),
    );
    if (i < items.length - 1) {
      rows.add(_menuDivider());
    }
  }
  return rows;
}

// ============================================================================
// Section 07: CupertinoAlertDialog surrogate
// ============================================================================

Widget _buildAlertDialogSurrogate() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '07',
          title: 'CupertinoAlertDialog — surrogate',
          subtitle: 'Title, content, and stacked / split action layouts',
          gradient: const LinearGradient(
            colors: [Color(0xFF5856D6), Color(0xFF7D5BFF)],
          ),
          icon: CupertinoIcons.exclamationmark_circle,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEFECFF), Color(0xFFD9D2FF)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x145856D6),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallLabel('Two-button horizontal layout'),
              const SizedBox(height: 10),
              Center(
                child: _alertDialogCard(
                  title: 'Allow Photos Access?',
                  content: 'Photos lets you import images from your library '
                      'into this draft.',
                  actions: const [
                    _DialogActionItem(
                      label: "Don't Allow",
                    ),
                    _DialogActionItem(
                      label: 'Allow',
                      isDefault: true,
                    ),
                  ],
                  layout: _DialogActionLayout.horizontal,
                ),
              ),
              const SizedBox(height: 18),
              _smallLabel('Vertical (3+ actions) layout'),
              const SizedBox(height: 10),
              Center(
                child: _alertDialogCard(
                  title: 'Software Update Available',
                  content: 'iOS 18.1.2 is ready to install. The update '
                      'includes important security improvements.',
                  actions: const [
                    _DialogActionItem(
                      label: 'Install Now',
                      isDefault: true,
                    ),
                    _DialogActionItem(label: 'Install Tonight'),
                    _DialogActionItem(label: 'Remind Me Later'),
                    _DialogActionItem(
                      label: 'Discard Update',
                      isDestructive: true,
                    ),
                  ],
                  layout: _DialogActionLayout.vertical,
                ),
              ),
              const SizedBox(height: 18),
              _smallLabel('Single confirmation'),
              const SizedBox(height: 10),
              Center(
                child: _alertDialogCard(
                  title: 'Saved',
                  content: 'Your changes have been saved to iCloud.',
                  actions: const [
                    _DialogActionItem(
                      label: 'OK',
                      isDefault: true,
                    ),
                  ],
                  layout: _DialogActionLayout.horizontal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoAlertDialog presents a centered modal with `title`, '
          '`content`, and a list of `actions`. With two actions Apple lays '
          'them out horizontally; with three or more, vertically. The '
          'default action draws in semibold blue, destructive in red. The '
          'surrogate above renders the same frame Apple ships, including '
          'the hairline divider stroke between actions.',
        ),
      ],
    ),
  );
}

enum _DialogActionLayout { horizontal, vertical }

class _DialogActionItem {
  const _DialogActionItem({
    required this.label,
    this.isDefault = false,
    this.isDestructive = false,
  });

  final String label;
  final bool isDefault;
  final bool isDestructive;
}

Widget _alertDialogCard({
  required String title,
  required String content,
  required List<_DialogActionItem> actions,
  required _DialogActionLayout layout,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Container(
      width: 270,
      decoration: const BoxDecoration(
        color: Color(0xF2F7F7F8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          _menuDivider(),
          if (layout == _DialogActionLayout.horizontal)
            _horizontalActions(actions)
          else
            _verticalActions(actions),
        ],
      ),
    ),
  );
}

Widget _horizontalActions(List<_DialogActionItem> actions) {
  final rows = <Widget>[];
  for (var i = 0; i < actions.length; i++) {
    rows.add(
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Text(
            actions[i].label,
            style: TextStyle(
              color: actions[i].isDestructive
                  ? CupertinoColors.systemRed
                  : CupertinoColors.systemBlue,
              fontSize: 17,
              fontWeight:
                  actions[i].isDefault ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
    if (i < actions.length - 1) {
      rows.add(
        Container(
          width: 1,
          height: 44,
          color: const Color(0xFFE5E5EA),
        ),
      );
    }
  }
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _verticalActions(List<_DialogActionItem> actions) {
  final rows = <Widget>[];
  for (var i = 0; i < actions.length; i++) {
    rows.add(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          actions[i].label,
          style: TextStyle(
            color: actions[i].isDestructive
                ? CupertinoColors.systemRed
                : CupertinoColors.systemBlue,
            fontSize: 17,
            fontWeight:
                actions[i].isDefault ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
    if (i < actions.length - 1) {
      rows.add(_menuDivider());
    }
  }
  return Column(children: rows);
}

// ============================================================================
// Section 08: CupertinoSliverNavigationBar
// ============================================================================

Widget _buildSliverNavBarSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '08',
          title: 'CupertinoSliverNavigationBar',
          subtitle: 'Large title with leading + trailing actions',
          gradient: const LinearGradient(
            colors: [Color(0xFF00C7BE), Color(0xFF63E6E2)],
          ),
          icon: CupertinoIcons.rectangle_stack,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallLabel('Embedded sliver nav bar inside CustomScrollView'),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5E5EA)),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        CupertinoSliverNavigationBar(
                          largeTitle: const Text('Library'),
                          leading: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Icon(
                              CupertinoIcons.line_horizontal_3_decrease,
                              size: 22,
                              color: CupertinoColors.systemBlue,
                            ),
                          ),
                          trailing: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Icon(
                              CupertinoIcons.add,
                              size: 24,
                              color: CupertinoColors.systemBlue,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: _libraryRow(
                            CupertinoIcons.book_fill,
                            const Color(0xFF007AFF),
                            'All Books',
                            '423 items',
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: _libraryRow(
                            CupertinoIcons.bookmark_fill,
                            const Color(0xFFFF9500),
                            'Reading List',
                            '12 items',
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: _libraryRow(
                            CupertinoIcons.heart_fill,
                            const Color(0xFFFF3B30),
                            'Favorites',
                            '38 items',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _smallLabel('Tinted variant'),
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFEAF7FF),
                          Color(0xFFD0EBFF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        CupertinoSliverNavigationBar(
                          backgroundColor: const Color(0xCCEAF7FF),
                          largeTitle: const Text('Discover'),
                          trailing: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Icon(
                              CupertinoIcons.search,
                              size: 22,
                              color: CupertinoColors.systemBlue,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x14000000),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'A featured article appears here. The large '
                                'title collapses into the middle slot as the '
                                'user scrolls.',
                                style: TextStyle(
                                  color: Color(0xFF1C1C1E),
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoSliverNavigationBar replaces the static '
          'CupertinoNavigationBar inside a CustomScrollView. The `largeTitle` '
          'sits in its own row when expanded and animates into the middle '
          'slot as the user scrolls. `leading` and `trailing` accept any '
          'widget — usually a CupertinoButton with a SF Symbol — and the '
          '`backgroundColor` adopts a translucent blur for the iconic Apple '
          'frosted-glass look.',
        ),
      ],
    ),
  );
}

Widget _libraryRow(
  IconData icon,
  Color color,
  String label,
  String trailing,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFE5E5EA), width: 0.5),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: CupertinoColors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1C1C1E),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 6),
        const Icon(
          CupertinoIcons.right_chevron,
          size: 14,
          color: Color(0xFFC7C7CC),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 09: CupertinoPopupSurface
// ============================================================================

Widget _buildPopupSurfaceSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '09',
          title: 'CupertinoPopupSurface',
          subtitle: 'Painted vs unpainted iOS-style rounded surface',
          gradient: const LinearGradient(
            colors: [Color(0xFF8E8E93), Color(0xFFC7C7CC)],
          ),
          icon: CupertinoIcons.square_arrow_up,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE9E9EB),
                Color(0xFFFAFAFA),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallLabel('isSurfacePainted: true (default white fill)'),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  height: 130,
                  child: CupertinoPopupSurface(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'iOS modal popup',
                            style: TextStyle(
                              color: Color(0xFF1C1C1E),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'CupertinoPopupSurface renders the rounded '
                            'translucent backdrop seen behind action sheets '
                            'and alert dialogs.',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _smallLabel('isSurfacePainted: false (custom interior)'),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  height: 150,
                  child: CupertinoPopupSurface(
                    isSurfacePainted: false,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF34C759),
                            Color(0xFF30D158),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: CupertinoColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              CupertinoIcons.checkmark_seal_fill,
                              color: CupertinoColors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Verified',
                                  style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Custom interior — surface fill is '
                                  'disabled so the gradient can take over.',
                                  style: TextStyle(
                                    color: Color(0xCCFFFFFF),
                                    fontSize: 13,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _smallLabel('Stacked surfaces visualizing layering'),
              const SizedBox(height: 10),
              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Positioned(
                      left: 12,
                      top: 12,
                      right: 60,
                      bottom: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFFE5B4),
                                Color(0xFFFFCC80),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Background',
                            style: TextStyle(
                              color: Color(0xFF8B5A00),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 30,
                      right: 18,
                      bottom: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: const CupertinoPopupSurface(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Painted CupertinoPopupSurface on top — '
                                'soft white fills the rounded card.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1C1C1E),
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoPopupSurface is the rounded, frosted-glass background '
          'shared by CupertinoActionSheet and CupertinoAlertDialog. With '
          '`isSurfacePainted: true` the surface receives a translucent white '
          'fill on top of the blurred backdrop — the default look. Setting '
          '`isSurfacePainted: false` removes the white wash so the child can '
          'paint its own interior, useful for full-bleed gradients or '
          'imagery inside the popup.',
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 10: Usage Guide
// ============================================================================

Widget _buildUsageGuide() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '10',
          title: 'Usage guide & best practices',
          subtitle: 'When to reach for each helper',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF2D55), Color(0xFFFF375F)],
          ),
          icon: CupertinoIcons.book_fill,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _guideRow(
                CupertinoIcons.checkmark_seal_fill,
                const Color(0xFF34C759),
                'Use .filled for the primary CTA',
                'Reserve CupertinoButton.filled for the single highest-'
                    'emphasis action on a screen — Continue, Get, Sign Up.',
              ),
              _guideRow(
                CupertinoIcons.checkmark_seal_fill,
                const Color(0xFF34C759),
                'Use .tinted for secondary actions',
                'CupertinoButton.tinted carries weight without competing '
                    'with the primary, perfect for Subscribe / Open / Share.',
              ),
              _guideRow(
                CupertinoIcons.checkmark_seal_fill,
                const Color(0xFF34C759),
                'Use plain CupertinoButton for nav bars',
                'The default constructor renders text-only iOS bar buttons. '
                    'Pair with `padding: EdgeInsets.zero` for tight slots.',
              ),
              _guideRow(
                CupertinoIcons.checkmark_seal_fill,
                const Color(0xFF34C759),
                'Adopt the back button when building custom nav bars',
                'CupertinoNavigationBarBackButton produces the canonical '
                    'chevron + previous-page label that users expect.',
              ),
              _guideRow(
                CupertinoIcons.checkmark_seal_fill,
                const Color(0xFF34C759),
                'CupertinoSearchTextField for search affordances',
                'It already renders the rounded grey pill, magnifying-glass '
                    'prefix, and X clear icon Apple ships across system apps.',
              ),
              _guideRow(
                CupertinoIcons.exclamationmark_triangle_fill,
                const Color(0xFFFF9500),
                'Action sheets must always offer a cancel option',
                'iOS guidelines require a separated Cancel button so users '
                    'can dismiss without committing.',
              ),
              _guideRow(
                CupertinoIcons.exclamationmark_triangle_fill,
                const Color(0xFFFF9500),
                'Alert dialogs collapse to vertical with 3+ actions',
                'Two horizontal actions feels balanced; three or more '
                    'should stack vertically to remain readable.',
              ),
              _guideRow(
                CupertinoIcons.xmark_seal_fill,
                const Color(0xFFFF3B30),
                'Do not nest CupertinoPopupSurface inside Material Card',
                'It already provides the iOS rounded surface; wrapping in '
                    'Material widgets stacks two card backgrounds.',
              ),
              _guideRow(
                CupertinoIcons.xmark_seal_fill,
                const Color(0xFFFF3B30),
                'Avoid mixing Material and Cupertino dialogs on the same flow',
                'Pick one dialog idiom per platform branch; toggling them '
                    'feels jarring to users on iOS.',
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEFFCEF), Color(0xFFE6F4FF)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF99C2FF)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'These secondary widgets close the loop between the '
                      'core CupertinoApp surface and the rich set of '
                      'modal interactions Apple users expect. Buttons '
                      'cover three emphases. Search, back, and close '
                      'cover navigation. Context menus, action sheets, '
                      'alert dialogs, and the popup surface cover the '
                      'modal vocabulary. Combined, they give a Cupertino '
                      'app every interaction surface the iOS Settings, '
                      'Mail, and Photos apps rely on.',
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _guideRow(
  IconData icon,
  Color color,
  String title,
  String description,
) {
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
// Shared helpers
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
                      horizontal: 8,
                      vertical: 2,
                    ),
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

Widget _smallLabel(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Color(0xFF6E6E73),
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
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

// Material icon reference used in the comparison footer below. The Icons
// symbol is imported from material.dart at the top of the file so the
// surrogate close-button section can quote a Material counterpart icon
// alongside the Cupertino `xmark` glyph, keeping the comparison literal.
Widget _materialIconCompare() {
  return const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.close, size: 16, color: Color(0xFF8E8E93)),
      SizedBox(width: 4),
      Icon(
        CupertinoIcons.xmark,
        size: 14,
        color: Color(0xFF8E8E93),
      ),
    ],
  );
}
