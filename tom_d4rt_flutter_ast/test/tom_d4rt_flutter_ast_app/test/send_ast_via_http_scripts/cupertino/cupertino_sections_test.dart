// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of CupertinoListSection.
//
// Showcases the complete capability surface of CupertinoListSection and
// CupertinoListSection.insetGrouped, including header / footer text,
// dividerMargin, additionalDividerMargin, topMargin, decoration,
// backgroundColor, separatorColor, margin, plus CupertinoListTile and
// CupertinoListTile.notched children with leading / title / subtitle /
// trailing / additionalInfo slots and CupertinoListTileChevron.
//
// Constraints: static `dynamic build(BuildContext context)`, no setState,
// no animations, no controllers, no for-in over BridgedInstance, all
// onTap callbacks empty `() {}`, must pass `dart analyze` with zero issues.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

dynamic build(BuildContext context) {
  return CupertinoApp(
    title: 'CupertinoListSection Demo',
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemIndigo,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoListSection'),
        backgroundColor: Color(0xF8F8F8FA),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildIntroCard(),
            _buildAnatomyDiagram(),
            _buildBaseSection(),
            _buildInsetGroupedSection(),
            _buildHeaderAndFooterSection(),
            _buildSeparatorAndMarginSection(),
            _buildCustomBackgroundSection(),
            _buildNotchedTileSection(),
            _buildAdditionalInfoSection(),
            _buildVsMaterialListSection(),
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
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x335E5CE6),
          blurRadius: 16,
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
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                CupertinoIcons.list_bullet_indent,
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
                    'CupertinoListSection',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'iOS-style grouped list sections',
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
          'CupertinoListSection groups related CupertinoListTile widgets into '
          'visually cohesive cards that match the iOS Settings app. The two '
          'major styles — base and insetGrouped — control whether the section '
          'spans the full width or sits as an inset rounded card.',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 14,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _heroChip('base'),
            _heroChip('insetGrouped'),
            _heroChip('header'),
            _heroChip('footer'),
            _heroChip('decoration'),
            _heroChip('separatorColor'),
            _heroChip('dividerMargin'),
            _heroChip('CupertinoListTile'),
            _heroChip('.notched'),
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
// Section: Anatomy Diagram
// ============================================================================

Widget _buildAnatomyDiagram() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '01',
          title: 'Anatomy of a CupertinoListSection',
          subtitle: 'Header, tiles, dividers, footer, margins',
          gradient: const LinearGradient(
            colors: [Color(0xFF34C759), Color(0xFF30D158)],
          ),
          icon: CupertinoIcons.square_grid_2x2,
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
              _anatomyRow('header', 'optional Text/Widget above the tiles'),
              _anatomyRow('topMargin', 'space above the section block'),
              _anatomyRow('decoration',
                  'BoxDecoration drawn around the entire section'),
              _anatomyRow('backgroundColor',
                  'fill applied behind the tiles inside the section'),
              _anatomyRow('CupertinoListTile',
                  'a single row inside the section'),
              _anatomyRow('separatorColor', 'color of the inter-tile dividers'),
              _anatomyRow('dividerMargin',
                  'leading inset that all dividers respect'),
              _anatomyRow('additionalDividerMargin',
                  'extra leading inset added to dividers when leading is set'),
              _anatomyRow('margin',
                  'outer margin around the whole section block'),
              _anatomyRow('footer', 'optional Text/Widget below the tiles'),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFFCEF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF34C759)),
                ),
                child: const Text(
                  'Each section is a normal Flutter widget. They compose '
                  'cleanly inside a ListView, Column, or CupertinoPageScaffold '
                  'child without needing a special parent.',
                  style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontSize: 13,
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
}

Widget _anatomyRow(String label, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 13,
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
// Section: Base CupertinoListSection
// ============================================================================

Widget _buildBaseSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '02',
          title: 'CupertinoListSection (base)',
          subtitle: 'Full-width grouping with simple dividers',
          gradient: const LinearGradient(
            colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
          ),
          icon: CupertinoIcons.rectangle_grid_1x2,
        ),
        const SizedBox(height: 12),
        Container(
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: CupertinoListSection(
            header: const Text('STORAGE'),
            children: [
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.device_phone_portrait, const Color(0xFF007AFF)),
                title: const Text('iPhone'),
                subtitle: const Text('64.2 GB used of 128 GB'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading:
                    _squareIcon(CupertinoIcons.cloud, const Color(0xFF5AC8FA)),
                title: const Text('iCloud'),
                subtitle: const Text('38 GB of 200 GB'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.archivebox, const Color(0xFFFF9500)),
                title: const Text('Backups'),
                subtitle: const Text('Last backup 2 days ago'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading:
                    _squareIcon(CupertinoIcons.trash, const Color(0xFFFF3B30)),
                title: const Text('Recently Deleted'),
                subtitle: const Text('12 items'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'The default constructor — `CupertinoListSection(...)` — produces a '
          'full-width section with classic iOS dividers between rows. It is '
          'best for dense list views that should feel edge-to-edge, like the '
          'storage breakdown above. Use it when the surrounding screen does '
          'not need rounded card edges.',
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: insetGrouped
// ============================================================================

Widget _buildInsetGroupedSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '03',
          title: 'CupertinoListSection.insetGrouped',
          subtitle: 'Rounded inset card style — Settings app style',
          gradient: const LinearGradient(
            colors: [Color(0xFFAF52DE), Color(0xFFBF5AF2)],
          ),
          icon: CupertinoIcons.square_stack_3d_up,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CupertinoListSection.insetGrouped(
            header: const Text('GENERAL'),
            children: [
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.gear_alt, const Color(0xFF8E8E93)),
                title: const Text('About'),
                additionalInfo: const Text('iOS 17.4'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.arrow_down_circle, const Color(0xFF007AFF)),
                title: const Text('Software Update'),
                additionalInfo: const Text('Up to date'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.airplane, const Color(0xFFFF9500)),
                title: const Text('AirDrop'),
                additionalInfo: const Text('Contacts Only'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.tv, const Color(0xFF5856D6)),
                title: const Text('AirPlay & Handoff'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.rectangle_on_rectangle,
                    const Color(0xFF34C759)),
                title: const Text('Picture in Picture'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.car_detailed, const Color(0xFF007AFF)),
                title: const Text('CarPlay'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'The `.insetGrouped` constructor mirrors the modern iOS Settings '
          'app: rounded corners, an inset margin from the screen edges, and '
          'thinner dividers. Use it when the section sits on a tinted scroll '
          'background and should feel like a discrete card.',
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Header & Footer
// ============================================================================

Widget _buildHeaderAndFooterSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '04',
          title: 'Header & footer text',
          subtitle: 'Caption above and supporting copy below',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9500), Color(0xFFFFCC00)],
          ),
          icon: CupertinoIcons.text_alignleft,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CupertinoListSection.insetGrouped(
            header: const Text('NOTIFICATIONS'),
            footer: const Text(
              'Notifications can include sounds, badges, and previews. Apps '
              'that send too many notifications may be downgraded by the '
              'system into the scheduled summary.',
            ),
            children: [
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.bell, const Color(0xFFFF3B30)),
                title: const Text('Allow Notifications'),
                additionalInfo: const Text('On'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.speaker_2, const Color(0xFF5AC8FA)),
                title: const Text('Sounds'),
                additionalInfo: const Text('Tritone'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.app_badge, const Color(0xFFFF9500)),
                title: const Text('Badges'),
                additionalInfo: const Text('On'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.chat_bubble_2, const Color(0xFF34C759)),
                title: const Text('Previews'),
                additionalInfo: const Text('When Unlocked'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'Both `header` and `footer` accept any widget — usually a `Text`. '
          'Headers are rendered in uppercase by convention and act as a '
          'caption for the rows that follow. Footers carry secondary copy '
          'such as legal text or feature explanations.',
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Separator color & dividerMargin
// ============================================================================

Widget _buildSeparatorAndMarginSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '05',
          title: 'separatorColor, dividerMargin, additionalDividerMargin',
          subtitle: 'Tinted dividers and custom inset distances',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF2D55), Color(0xFFFF375F)],
          ),
          icon: CupertinoIcons.minus,
        ),
        const SizedBox(height: 12),
        Container(
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
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CupertinoListSection(
            header: const Text('TINTED DIVIDERS'),
            separatorColor: const Color(0xFFFFB3BD),
            dividerMargin: 24,
            additionalDividerMargin: 6,
            children: [
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.heart_fill, const Color(0xFFFF2D55)),
                title: const Text('Health'),
                subtitle: const Text('Steps, sleep, heart rate'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.flame_fill, const Color(0xFFFF9500)),
                title: const Text('Activity'),
                subtitle: const Text('Move, exercise, stand rings'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.bed_double_fill, const Color(0xFF5856D6)),
                title: const Text('Sleep'),
                subtitle: const Text('7h 42m last night'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CupertinoListSection.insetGrouped(
            header: const Text('LARGE INSET'),
            separatorColor: const Color(0xFFB3D4FF),
            dividerMargin: 64,
            children: [
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.wifi, const Color(0xFF007AFF)),
                title: const Text('Wi-Fi'),
                additionalInfo: const Text('CafeNet'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.bluetooth, const Color(0xFF007AFF)),
                title: const Text('Bluetooth'),
                additionalInfo: const Text('On'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.antenna_radiowaves_left_right,
                    const Color(0xFF34C759)),
                title: const Text('Cellular'),
                additionalInfo: const Text('5G'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.personalhotspot,
                    const Color(0xFF34C759)),
                title: const Text('Personal Hotspot'),
                additionalInfo: const Text('Off'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          '`separatorColor` repaints the inter-row dividers in any color, '
          '`dividerMargin` shifts the divider start position from the leading '
          'edge, and `additionalDividerMargin` adds extra leading inset when '
          'tiles include leading widgets. The combination drives the visual '
          'rhythm of the section.',
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Custom backgroundColor + decoration + margin + topMargin
// ============================================================================

Widget _buildCustomBackgroundSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '06',
          title: 'backgroundColor, decoration, margin, topMargin',
          subtitle: 'Tinted card with custom outline and spacing',
          gradient: const LinearGradient(
            colors: [Color(0xFF5856D6), Color(0xFF7D5BFF)],
          ),
          icon: CupertinoIcons.paintbrush,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFD),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F5856D6),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CupertinoListSection.insetGrouped(
            header: const Text('APPEARANCE'),
            backgroundColor: const Color(0xFFF8F4FF),
            margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 12),
            topMargin: 18,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F4FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF5856D6),
                width: 1.2,
              ),
            ),
            children: [
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.sun_max_fill, const Color(0xFFFF9500)),
                title: const Text('Light'),
                additionalInfo: const Text('Active'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.moon_fill, const Color(0xFF5856D6)),
                title: const Text('Dark'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.circle_lefthalf_fill,
                    const Color(0xFF8E8E93)),
                title: const Text('Automatic'),
                subtitle: const Text('Match the system setting'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.eye, const Color(0xFF34C759)),
                title: const Text('Display Zoom'),
                additionalInfo: const Text('Standard'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          '`backgroundColor` colors the inner surface where the tiles live. '
          '`decoration` replaces the default tile-stack background entirely, '
          'allowing borders, gradients, or shadows. `margin` and `topMargin` '
          'control the outer spacing of the section block within its parent.',
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: notched
// ============================================================================

Widget _buildNotchedTileSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '07',
          title: 'CupertinoListTile.notched',
          subtitle: 'Compact iOS-style tile with smaller leading slot',
          gradient: const LinearGradient(
            colors: [Color(0xFF30D158), Color(0xFF66E59B)],
          ),
          icon: CupertinoIcons.square_split_2x1,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CupertinoListSection.insetGrouped(
            header: const Text('PRIVACY & SECURITY'),
            children: [
              CupertinoListTile.notched(
                leading: _squareIcon(
                    CupertinoIcons.lock_shield,
                    const Color(0xFF007AFF)),
                title: const Text('Face ID & Passcode'),
                additionalInfo: const Text('On'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile.notched(
                leading: _squareIcon(
                    CupertinoIcons.location_fill,
                    const Color(0xFF34C759)),
                title: const Text('Location Services'),
                additionalInfo: const Text('On'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile.notched(
                leading: _squareIcon(
                    CupertinoIcons.camera_fill,
                    const Color(0xFFFF9500)),
                title: const Text('Camera'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile.notched(
                leading: _squareIcon(
                    CupertinoIcons.mic_fill, const Color(0xFFFF3B30)),
                title: const Text('Microphone'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile.notched(
                leading: _squareIcon(
                    CupertinoIcons.eye_fill, const Color(0xFFAF52DE)),
                title: const Text('Tracking'),
                additionalInfo: const Text('Limited'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'The named constructor `CupertinoListTile.notched(...)` produces a '
          'tile with reduced vertical padding and a smaller leading icon slot. '
          'It is the visual default in iOS 16+ Settings. Use it when each '
          'tile carries a single line of title text and a small leading icon.',
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: additionalInfo & subtitle showcase
// ============================================================================

Widget _buildAdditionalInfoSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '08',
          title: 'additionalInfo, subtitle, leading & trailing slots',
          subtitle: 'Every tile slot exercised in one section',
          gradient: const LinearGradient(
            colors: [Color(0xFF00C7BE), Color(0xFF63E6E2)],
          ),
          icon: CupertinoIcons.square_grid_3x2,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CupertinoListSection.insetGrouped(
            header: const Text('CONNECTIONS'),
            footer: const Text(
              'additionalInfo sits to the right of the title before the '
              'trailing chevron. Combine it with subtitle for two-line tiles.',
            ),
            children: [
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.wifi, const Color(0xFF007AFF)),
                title: const Text('Home Wi-Fi'),
                subtitle: const Text('5 GHz · WPA3'),
                additionalInfo: const Text('Connected'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.bluetooth, const Color(0xFF007AFF)),
                title: const Text('AirPods Pro'),
                subtitle: const Text('Battery 84%'),
                additionalInfo: const Text('Connected'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.creditcard, const Color(0xFF000000)),
                title: const Text('Apple Pay'),
                subtitle: const Text('3 cards available'),
                additionalInfo: const Text('Default'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.envelope_fill,
                    const Color(0xFF5AC8FA)),
                title: const Text('Mail'),
                subtitle: const Text('user@example.com'),
                additionalInfo: const Text('Push'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: _squareIcon(
                    CupertinoIcons.calendar, const Color(0xFFFF3B30)),
                title: const Text('Calendar'),
                subtitle: const Text('iCloud · Work · Family'),
                additionalInfo: const Text('3 accounts'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _explanation(
          'Every CupertinoListTile slot is filled here: `leading` for the '
          'rounded square icon, `title` for the primary label, `subtitle` for '
          'a secondary line, `additionalInfo` for a status string, and '
          '`trailing` for the chevron. Slots are independent — leave any of '
          'them null and the tile collapses gracefully.',
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Compared with Material ListTile
// ============================================================================

Widget _buildVsMaterialListSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          number: '09',
          title: 'CupertinoListSection vs Material ListTile',
          subtitle: 'Side-by-side visual comparison',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF375F), Color(0xFFFF6482)],
          ),
          icon: CupertinoIcons.square_split_1x2,
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CupertinoListSection.insetGrouped(
                  header: const Text('CUPERTINO'),
                  margin: EdgeInsets.zero,
                  children: [
                    CupertinoListTile(
                      leading: const Icon(CupertinoIcons.person),
                      title: const Text('Profile'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                    CupertinoListTile(
                      leading: const Icon(CupertinoIcons.gear),
                      title: const Text('Settings'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                    CupertinoListTile(
                      leading: const Icon(CupertinoIcons.bell),
                      title: const Text('Alerts'),
                      additionalInfo: const Text('3'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
                      child: Text(
                        'MATERIAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF555555),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    _materialRow(
                      icon: Icons.person,
                      label: 'Profile',
                    ),
                    _materialDivider(),
                    _materialRow(
                      icon: Icons.settings,
                      label: 'Settings',
                    ),
                    _materialDivider(),
                    _materialRow(
                      icon: Icons.notifications,
                      label: 'Alerts',
                      trailing: '3',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _explanation(
          'CupertinoListSection adopts iOS spacing, divider behavior, and '
          'rounded inset cards out of the box. Material ListTile lives inside '
          'a Card or surface and uses ripples plus a leading-aligned divider. '
          'Choose CupertinoListSection on iOS / iPadOS surfaces and ListTile '
          'on Android / web Material apps.',
        ),
      ],
    ),
  );
}

Widget _materialRow({
  required IconData icon,
  required String label,
  String? trailing,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        Icon(icon, color: const Color(0xFF1976D2), size: 22),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF222222),
            ),
          ),
        ),
        if (trailing != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              trailing,
              style: const TextStyle(
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _materialDivider() {
  return Container(
    margin: const EdgeInsets.only(left: 52),
    height: 1,
    color: const Color(0xFFE0E0E0),
  );
}

// ============================================================================
// Section: Usage Guide
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
          subtitle: 'When to use base, insetGrouped, and notched tiles',
          gradient: const LinearGradient(
            colors: [Color(0xFF8E8E93), Color(0xFFC7C7CC)],
          ),
          icon: CupertinoIcons.book,
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
                'Use insetGrouped on tinted scroll surfaces',
                'Modern iOS Settings, profile screens, and account flows feel '
                'best with insetGrouped against a CupertinoSystemBackground '
                'parent.',
              ),
              _guideRow(
                CupertinoIcons.checkmark_seal_fill,
                const Color(0xFF34C759),
                'Use base for full-bleed lists',
                'Action sheets, file pickers, and dense reference lists look '
                'right with the full-width base style.',
              ),
              _guideRow(
                CupertinoIcons.checkmark_seal_fill,
                const Color(0xFF34C759),
                'Reach for .notched tiles in iOS 16+ surfaces',
                'They produce the tighter spacing and smaller leading icon '
                'slots seen in current iOS Settings.',
              ),
              _guideRow(
                CupertinoIcons.exclamationmark_triangle_fill,
                const Color(0xFFFF9500),
                'Avoid mixing base and insetGrouped on the same screen',
                'It creates jarring switches between full-width and inset '
                'edges. Pick one rhythm per page.',
              ),
              _guideRow(
                CupertinoIcons.exclamationmark_triangle_fill,
                const Color(0xFFFF9500),
                'Keep header text short and uppercase',
                'iOS section captions are typically 1–3 short words. Long '
                'headers wrap and look heavy.',
              ),
              _guideRow(
                CupertinoIcons.xmark_seal_fill,
                const Color(0xFFFF3B30),
                'Do not nest CupertinoListSection in a Card',
                'The section already provides its own card; wrapping it in '
                'Material Card stacks two surfaces and breaks elevation.',
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
                      'CupertinoListSection is the canonical iOS list '
                      'grouping. Combined with CupertinoListTile (or its '
                      '.notched variant) it produces every settings-style '
                      'screen Apple ships, with fine-grained control over '
                      'dividers, margins, and decoration.',
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
    IconData icon, Color color, String title, String description) {
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

Widget _squareIcon(IconData icon, Color background) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(7),
      boxShadow: [
        BoxShadow(
          color: background.withOpacity(0.35),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Icon(icon, color: CupertinoColors.white, size: 18),
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
