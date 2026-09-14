// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_full_hex_values_for_flutter_colors
// D4rt test script: Tests Icon class from package:flutter/material.dart
// Deep Demo: Visual demonstration of Icon constructor parameters,
// size scales, color palettes, Material symbol categories,
// shadows, gradients via ShaderMask, RTL flipping, and integration
// in cards, chips and tiles.
import 'package:flutter/material.dart';

// Themed palette - reused across all sections.
const Color _kPrimary = Color(0xFF3949AB); // Indigo 600
const Color _kPrimaryDark = Color(0xFF1A237E); // Indigo 900
const Color _kAccent = Color(0xFFFF7043); // Deep Orange 400
const Color _kSecondary = Color(0xFF26A69A); // Teal 400
const Color _kHighlight = Color(0xFFFFCA28); // Amber 400
const Color _kOnSurface = Color(0xFF212121);
const Color _kMuted = Color(0xFF616161);

dynamic build(BuildContext context) {
  print('Icon Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner with stylized big icons
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final heroBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _kPrimaryDark,
          _kPrimary,
          Color(0xFF5C6BC0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: _kPrimaryDark.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
          spreadRadius: 2.0,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, -2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.emoji_symbols,
                color: Colors.white,
                size: 44.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Icon',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/material.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(
          'A graphical icon widget drawn with a glyph from a font described '
          'in an IconData. Icons are not interactive - for a clickable icon '
          'use IconButton. The Icon widget participates in icon themes and '
          'inherits size, color, opacity and shadows from the surrounding '
          'IconTheme.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.95),
            height: 1.55,
          ),
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.start,
          children: [
            _buildHeroBigIcon(Icons.favorite, _kAccent),
            _buildHeroBigIcon(Icons.star, _kHighlight),
            _buildHeroBigIcon(Icons.bolt, Color(0xFFFFEB3B)),
            _buildHeroBigIcon(Icons.cloud, Color(0xFF81D4FA)),
            _buildHeroBigIcon(Icons.eco, Color(0xFFA5D6A7)),
            _buildHeroBigIcon(Icons.diamond, Color(0xFFCE93D8)),
            _buildHeroBigIcon(Icons.local_fire_department, Color(0xFFFFAB91)),
            _buildHeroBigIcon(Icons.spa, Color(0xFFB2DFDB)),
          ],
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildHeroChip('extends StatelessWidget', Icons.account_tree),
            _buildHeroChip('IconData driven', Icons.font_download),
            _buildHeroChip('IconTheme aware', Icons.palette),
            _buildHeroChip('non-interactive', Icons.do_disturb),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of the Icon constructor
  // ============================================================
  print('=== Section 2: Anatomy of Icon ===');

  final anatomyPanel = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF263238),
          Color(0xFF37474F),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFF80CBC4), size: 24.0),
            SizedBox(width: 12.0),
            Text(
              'Icon() Constructor Parameters',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildAnatomyEntry(
          'icon',
          'IconData?',
          'The required positional argument - which glyph to render. '
          'Typically one of the Icons.* constants which reference the '
          'Material font.',
        ),
        _buildAnatomyEntry(
          'size',
          'double?',
          'Logical pixel height (and width) of the rendered glyph. '
          'Defaults to IconTheme.of(context).size, often 24.',
        ),
        _buildAnatomyEntry(
          'fill',
          'double?',
          'Variable font axis from 0.0 (outlined) to 1.0 (filled). '
          'Only meaningful for variable Material Symbols fonts.',
        ),
        _buildAnatomyEntry(
          'weight',
          'double?',
          'Stroke weight of the glyph between 100 and 700. '
          'Defaults to 400. Maps to the Material Symbols wght axis.',
        ),
        _buildAnatomyEntry(
          'grade',
          'double?',
          'Granular weight for emphasis between -25 and 200. '
          'Subtle visual adjustment without changing icon size.',
        ),
        _buildAnatomyEntry(
          'opticalSize',
          'double?',
          'Optical size adjustment between 20 and 48. '
          'Tunes stroke contrast for the rendered size.',
        ),
        _buildAnatomyEntry(
          'color',
          'Color?',
          'Color of the rendered glyph. Defaults to IconTheme.color.',
        ),
        _buildAnatomyEntry(
          'shadows',
          'List<Shadow>?',
          'Drop shadows applied behind the glyph - same model as TextStyle.shadows.',
        ),
        _buildAnatomyEntry(
          'semanticLabel',
          'String?',
          'Description used by screen readers. Defaults to no announcement.',
        ),
        _buildAnatomyEntry(
          'textDirection',
          'TextDirection?',
          'Used to flip glyphs whose IconData has matchTextDirection: true. '
          'Defaults to Directionality.of(context).',
        ),
        _buildAnatomyEntry(
          'applyTextScaling',
          'bool?',
          'Whether MediaQuery.textScaler should scale the icon size. '
          'Defaults to false.',
        ),
        _buildAnatomyEntry(
          'blendMode',
          'BlendMode?',
          'BlendMode applied when drawing the glyph onto the canvas.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Size scale 8 -> 96
  // ============================================================
  print('=== Section 3: Size Scale ===');

  final sizeStops = <double>[
    8.0,
    12.0,
    16.0,
    20.0,
    24.0,
    32.0,
    40.0,
    48.0,
    56.0,
    64.0,
    80.0,
    96.0,
  ];

  final sizeScale = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE8EAF6),
          Color(0xFFC5CAE9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: _kPrimary.withValues(alpha: 0.3),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: _kPrimary.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.straighten, color: _kPrimary, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Size Scale (8px to 96px)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: _kPrimaryDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'The same Icon (Icons.bolt) rendered at twelve increasing sizes. '
          'Notice the optical thickness stays proportional - each glyph is '
          'redrawn from the font, not pixel-scaled.',
          style: TextStyle(
            fontSize: 12.0,
            color: _kPrimaryDark.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: sizeStops.map((s) {
            return _buildSizeStop(Icons.bolt, s, _kPrimary);
          }).toList(),
        ),
        SizedBox(height: 18.0),
        Divider(color: _kPrimary.withValues(alpha: 0.4)),
        SizedBox(height: 12.0),
        Text(
          'A second size walk using a glyph with finer detail (Icons.flutter_dash):',
          style: TextStyle(
            fontSize: 12.0,
            color: _kPrimaryDark,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: sizeStops.map((s) {
            return _buildSizeStop(Icons.flutter_dash, s, _kSecondary);
          }).toList(),
        ),
        SizedBox(height: 18.0),
        Divider(color: _kPrimary.withValues(alpha: 0.4)),
        SizedBox(height: 12.0),
        Text(
          'And one more with a directional glyph (Icons.arrow_circle_right):',
          style: TextStyle(
            fontSize: 12.0,
            color: _kPrimaryDark,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: sizeStops.map((s) {
            return _buildSizeStop(Icons.arrow_circle_right, s, _kAccent);
          }).toList(),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Color palette across Material colors
  // ============================================================
  print('=== Section 4: Color Palette ===');

  final colorPalette = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: _kAccent, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Material Color Palette',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: _kOnSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Icons inherit IconTheme.color by default but may be overridden '
          'with the color parameter. Below is a sweep across the full '
          'Material 2 palette.',
          style: TextStyle(
            fontSize: 12.0,
            color: _kMuted,
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        _buildColorRow('Reds', [
          _buildColorChip('red 50', Color(0xFFFFEBEE), Icons.favorite),
          _buildColorChip('red 100', Color(0xFFFFCDD2), Icons.favorite),
          _buildColorChip('red 300', Color(0xFFE57373), Icons.favorite),
          _buildColorChip('red 500', Color(0xFFF44336), Icons.favorite),
          _buildColorChip('red 700', Color(0xFFD32F2F), Icons.favorite),
          _buildColorChip('red 900', Color(0xFFB71C1C), Icons.favorite),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Pinks', [
          _buildColorChip('pink 100', Color(0xFFF8BBD0), Icons.favorite_border),
          _buildColorChip('pink 300', Color(0xFFF06292), Icons.favorite_border),
          _buildColorChip('pink 500', Color(0xFFE91E63), Icons.favorite_border),
          _buildColorChip('pink 700', Color(0xFFC2185B), Icons.favorite_border),
          _buildColorChip('pink 900', Color(0xFF880E4F), Icons.favorite_border),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Purples', [
          _buildColorChip('purple 100', Color(0xFFE1BEE7), Icons.diamond),
          _buildColorChip('purple 300', Color(0xFFBA68C8), Icons.diamond),
          _buildColorChip('purple 500', Color(0xFF9C27B0), Icons.diamond),
          _buildColorChip('purple 700', Color(0xFF7B1FA2), Icons.diamond),
          _buildColorChip('purple 900', Color(0xFF4A148C), Icons.diamond),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Blues', [
          _buildColorChip('blue 100', Color(0xFFBBDEFB), Icons.water_drop),
          _buildColorChip('blue 300', Color(0xFF64B5F6), Icons.water_drop),
          _buildColorChip('blue 500', Color(0xFF2196F3), Icons.water_drop),
          _buildColorChip('blue 700', Color(0xFF1976D2), Icons.water_drop),
          _buildColorChip('blue 900', Color(0xFF0D47A1), Icons.water_drop),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Cyans', [
          _buildColorChip('cyan 100', Color(0xFFB2EBF2), Icons.air),
          _buildColorChip('cyan 300', Color(0xFF4DD0E1), Icons.air),
          _buildColorChip('cyan 500', Color(0xFF00BCD4), Icons.air),
          _buildColorChip('cyan 700', Color(0xFF0097A7), Icons.air),
          _buildColorChip('cyan 900', Color(0xFF006064), Icons.air),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Greens', [
          _buildColorChip('green 100', Color(0xFFC8E6C9), Icons.eco),
          _buildColorChip('green 300', Color(0xFF81C784), Icons.eco),
          _buildColorChip('green 500', Color(0xFF4CAF50), Icons.eco),
          _buildColorChip('green 700', Color(0xFF388E3C), Icons.eco),
          _buildColorChip('green 900', Color(0xFF1B5E20), Icons.eco),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Yellows', [
          _buildColorChip('yellow 100', Color(0xFFFFF9C4), Icons.wb_sunny),
          _buildColorChip('yellow 300', Color(0xFFFFF176), Icons.wb_sunny),
          _buildColorChip('yellow 500', Color(0xFFFFEB3B), Icons.wb_sunny),
          _buildColorChip('yellow 700', Color(0xFFFBC02D), Icons.wb_sunny),
          _buildColorChip('yellow 900', Color(0xFFF57F17), Icons.wb_sunny),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Oranges', [
          _buildColorChip('orange 100', Color(0xFFFFE0B2), Icons.local_fire_department),
          _buildColorChip('orange 300', Color(0xFFFFB74D), Icons.local_fire_department),
          _buildColorChip('orange 500', Color(0xFFFF9800), Icons.local_fire_department),
          _buildColorChip('orange 700', Color(0xFFF57C00), Icons.local_fire_department),
          _buildColorChip('orange 900', Color(0xFFE65100), Icons.local_fire_department),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Browns', [
          _buildColorChip('brown 200', Color(0xFFBCAAA4), Icons.coffee),
          _buildColorChip('brown 400', Color(0xFF8D6E63), Icons.coffee),
          _buildColorChip('brown 600', Color(0xFF6D4C41), Icons.coffee),
          _buildColorChip('brown 800', Color(0xFF4E342E), Icons.coffee),
        ]),
        SizedBox(height: 12.0),
        _buildColorRow('Greys', [
          _buildColorChip('grey 300', Color(0xFFE0E0E0), Icons.lens),
          _buildColorChip('grey 500', Color(0xFF9E9E9E), Icons.lens),
          _buildColorChip('grey 700', Color(0xFF616161), Icons.lens),
          _buildColorChip('grey 900', Color(0xFF212121), Icons.lens),
        ]),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Material symbol categories
  // ============================================================
  print('=== Section 5: Symbol Categories ===');

  final actionGrid = _buildCategoryGrid(
    title: 'Action',
    description:
        'Generic user-action glyphs - search, settings, edit, delete and friends.',
    accent: _kPrimary,
    icon: Icons.touch_app,
    icons: [
      _LabelledIcon(Icons.search, 'search'),
      _LabelledIcon(Icons.settings, 'settings'),
      _LabelledIcon(Icons.edit, 'edit'),
      _LabelledIcon(Icons.delete, 'delete'),
      _LabelledIcon(Icons.add, 'add'),
      _LabelledIcon(Icons.remove, 'remove'),
      _LabelledIcon(Icons.check, 'check'),
      _LabelledIcon(Icons.close, 'close'),
      _LabelledIcon(Icons.refresh, 'refresh'),
      _LabelledIcon(Icons.sync, 'sync'),
      _LabelledIcon(Icons.share, 'share'),
      _LabelledIcon(Icons.download, 'download'),
      _LabelledIcon(Icons.upload, 'upload'),
      _LabelledIcon(Icons.print, 'print'),
      _LabelledIcon(Icons.save, 'save'),
      _LabelledIcon(Icons.save_alt, 'save_alt'),
      _LabelledIcon(Icons.copy, 'copy'),
      _LabelledIcon(Icons.cut, 'cut'),
      _LabelledIcon(Icons.paste, 'paste'),
      _LabelledIcon(Icons.lock, 'lock'),
      _LabelledIcon(Icons.lock_open, 'lock_open'),
      _LabelledIcon(Icons.visibility, 'visibility'),
      _LabelledIcon(Icons.visibility_off, 'visibility_off'),
      _LabelledIcon(Icons.favorite, 'favorite'),
    ],
  );

  final navGrid = _buildCategoryGrid(
    title: 'Navigation',
    description:
        'Wayfinding glyphs - chevrons, arrows, menu and tab affordances.',
    accent: _kAccent,
    icon: Icons.explore,
    icons: [
      _LabelledIcon(Icons.menu, 'menu'),
      _LabelledIcon(Icons.more_vert, 'more_vert'),
      _LabelledIcon(Icons.more_horiz, 'more_horiz'),
      _LabelledIcon(Icons.arrow_back, 'arrow_back'),
      _LabelledIcon(Icons.arrow_forward, 'arrow_forward'),
      _LabelledIcon(Icons.arrow_upward, 'arrow_upward'),
      _LabelledIcon(Icons.arrow_downward, 'arrow_downward'),
      _LabelledIcon(Icons.chevron_left, 'chevron_left'),
      _LabelledIcon(Icons.chevron_right, 'chevron_right'),
      _LabelledIcon(Icons.expand_less, 'expand_less'),
      _LabelledIcon(Icons.expand_more, 'expand_more'),
      _LabelledIcon(Icons.unfold_less, 'unfold_less'),
      _LabelledIcon(Icons.unfold_more, 'unfold_more'),
      _LabelledIcon(Icons.first_page, 'first_page'),
      _LabelledIcon(Icons.last_page, 'last_page'),
      _LabelledIcon(Icons.home, 'home'),
      _LabelledIcon(Icons.apps, 'apps'),
      _LabelledIcon(Icons.dashboard, 'dashboard'),
    ],
  );

  final contentGrid = _buildCategoryGrid(
    title: 'Content',
    description: 'Document, list, formatting and clipboard glyphs.',
    accent: _kSecondary,
    icon: Icons.description,
    icons: [
      _LabelledIcon(Icons.description, 'description'),
      _LabelledIcon(Icons.article, 'article'),
      _LabelledIcon(Icons.note, 'note'),
      _LabelledIcon(Icons.notes, 'notes'),
      _LabelledIcon(Icons.format_bold, 'format_bold'),
      _LabelledIcon(Icons.format_italic, 'format_italic'),
      _LabelledIcon(Icons.format_underline, 'format_underline'),
      _LabelledIcon(Icons.format_align_left, 'align_left'),
      _LabelledIcon(Icons.format_align_center, 'align_center'),
      _LabelledIcon(Icons.format_align_right, 'align_right'),
      _LabelledIcon(Icons.format_list_bulleted, 'list_bulleted'),
      _LabelledIcon(Icons.format_list_numbered, 'list_numbered'),
      _LabelledIcon(Icons.format_quote, 'format_quote'),
      _LabelledIcon(Icons.link, 'link'),
      _LabelledIcon(Icons.attach_file, 'attach_file'),
      _LabelledIcon(Icons.bookmark, 'bookmark'),
      _LabelledIcon(Icons.bookmark_border, 'bookmark_border'),
      _LabelledIcon(Icons.flag, 'flag'),
    ],
  );

  final commGrid = _buildCategoryGrid(
    title: 'Communication',
    description: 'Mail, chat, phone and presence glyphs.',
    accent: Color(0xFF7B1FA2),
    icon: Icons.forum,
    icons: [
      _LabelledIcon(Icons.email, 'email'),
      _LabelledIcon(Icons.mail_outline, 'mail_outline'),
      _LabelledIcon(Icons.send, 'send'),
      _LabelledIcon(Icons.inbox, 'inbox'),
      _LabelledIcon(Icons.drafts, 'drafts'),
      _LabelledIcon(Icons.chat, 'chat'),
      _LabelledIcon(Icons.chat_bubble, 'chat_bubble'),
      _LabelledIcon(Icons.forum, 'forum'),
      _LabelledIcon(Icons.phone, 'phone'),
      _LabelledIcon(Icons.call, 'call'),
      _LabelledIcon(Icons.call_end, 'call_end'),
      _LabelledIcon(Icons.voicemail, 'voicemail'),
      _LabelledIcon(Icons.contact_mail, 'contact_mail'),
      _LabelledIcon(Icons.contact_phone, 'contact_phone'),
      _LabelledIcon(Icons.contacts, 'contacts'),
      _LabelledIcon(Icons.notifications, 'notifications'),
      _LabelledIcon(Icons.notifications_active, 'notifications_active'),
      _LabelledIcon(Icons.person, 'person'),
    ],
  );

  final deviceGrid = _buildCategoryGrid(
    title: 'Device',
    description: 'Hardware, battery and connectivity glyphs.',
    accent: Color(0xFF00897B),
    icon: Icons.devices,
    icons: [
      _LabelledIcon(Icons.smartphone, 'smartphone'),
      _LabelledIcon(Icons.tablet, 'tablet'),
      _LabelledIcon(Icons.laptop, 'laptop'),
      _LabelledIcon(Icons.computer, 'computer'),
      _LabelledIcon(Icons.tv, 'tv'),
      _LabelledIcon(Icons.watch, 'watch'),
      _LabelledIcon(Icons.headphones, 'headphones'),
      _LabelledIcon(Icons.speaker, 'speaker'),
      _LabelledIcon(Icons.battery_full, 'battery_full'),
      _LabelledIcon(Icons.battery_charging_full, 'battery_charging'),
      _LabelledIcon(Icons.battery_alert, 'battery_alert'),
      _LabelledIcon(Icons.wifi, 'wifi'),
      _LabelledIcon(Icons.wifi_off, 'wifi_off'),
      _LabelledIcon(Icons.bluetooth, 'bluetooth'),
      _LabelledIcon(Icons.bluetooth_connected, 'bluetooth_connected'),
      _LabelledIcon(Icons.signal_cellular_4_bar, 'signal_4'),
      _LabelledIcon(Icons.gps_fixed, 'gps_fixed'),
      _LabelledIcon(Icons.usb, 'usb'),
    ],
  );

  final imageGrid = _buildCategoryGrid(
    title: 'Image / Media',
    description: 'Photography, gallery and media-control glyphs.',
    accent: Color(0xFFD81B60),
    icon: Icons.image,
    icons: [
      _LabelledIcon(Icons.image, 'image'),
      _LabelledIcon(Icons.photo, 'photo'),
      _LabelledIcon(Icons.photo_library, 'photo_library'),
      _LabelledIcon(Icons.photo_camera, 'photo_camera'),
      _LabelledIcon(Icons.camera_alt, 'camera_alt'),
      _LabelledIcon(Icons.camera, 'camera'),
      _LabelledIcon(Icons.movie, 'movie'),
      _LabelledIcon(Icons.video_library, 'video_library'),
      _LabelledIcon(Icons.play_arrow, 'play_arrow'),
      _LabelledIcon(Icons.pause, 'pause'),
      _LabelledIcon(Icons.stop, 'stop'),
      _LabelledIcon(Icons.skip_next, 'skip_next'),
      _LabelledIcon(Icons.skip_previous, 'skip_previous'),
      _LabelledIcon(Icons.fast_forward, 'fast_forward'),
      _LabelledIcon(Icons.fast_rewind, 'fast_rewind'),
      _LabelledIcon(Icons.volume_up, 'volume_up'),
      _LabelledIcon(Icons.volume_down, 'volume_down'),
      _LabelledIcon(Icons.volume_mute, 'volume_mute'),
    ],
  );

  final socialGrid = _buildCategoryGrid(
    title: 'Social',
    description: 'People, groups and reaction glyphs.',
    accent: Color(0xFFEF6C00),
    icon: Icons.people,
    icons: [
      _LabelledIcon(Icons.person, 'person'),
      _LabelledIcon(Icons.people, 'people'),
      _LabelledIcon(Icons.group, 'group'),
      _LabelledIcon(Icons.group_add, 'group_add'),
      _LabelledIcon(Icons.person_add, 'person_add'),
      _LabelledIcon(Icons.person_remove, 'person_remove'),
      _LabelledIcon(Icons.thumb_up, 'thumb_up'),
      _LabelledIcon(Icons.thumb_down, 'thumb_down'),
      _LabelledIcon(Icons.mood, 'mood'),
      _LabelledIcon(Icons.mood_bad, 'mood_bad'),
      _LabelledIcon(Icons.emoji_emotions, 'emoji_emotions'),
      _LabelledIcon(Icons.celebration, 'celebration'),
      _LabelledIcon(Icons.cake, 'cake'),
      _LabelledIcon(Icons.public, 'public'),
    ],
  );

  final placeGrid = _buildCategoryGrid(
    title: 'Places / Maps',
    description: 'Location, transit and venue glyphs.',
    accent: Color(0xFF1565C0),
    icon: Icons.place,
    icons: [
      _LabelledIcon(Icons.place, 'place'),
      _LabelledIcon(Icons.map, 'map'),
      _LabelledIcon(Icons.location_on, 'location_on'),
      _LabelledIcon(Icons.location_off, 'location_off'),
      _LabelledIcon(Icons.my_location, 'my_location'),
      _LabelledIcon(Icons.navigation, 'navigation'),
      _LabelledIcon(Icons.directions, 'directions'),
      _LabelledIcon(Icons.directions_car, 'directions_car'),
      _LabelledIcon(Icons.directions_bike, 'directions_bike'),
      _LabelledIcon(Icons.directions_walk, 'directions_walk'),
      _LabelledIcon(Icons.directions_bus, 'directions_bus'),
      _LabelledIcon(Icons.flight, 'flight'),
      _LabelledIcon(Icons.train, 'train'),
      _LabelledIcon(Icons.local_cafe, 'local_cafe'),
      _LabelledIcon(Icons.restaurant, 'restaurant'),
      _LabelledIcon(Icons.hotel, 'hotel'),
    ],
  );

  // ============================================================
  // SECTION 6: IconButton vs raw Icon comparison
  // ============================================================
  print('=== Section 6: IconButton vs Icon ===');

  final iconButtonComparison = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFF3E0),
          Color(0xFFFFE0B2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _kAccent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: _kAccent, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Icon vs IconButton',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Icon is a passive widget - it draws a glyph and does not '
          'respond to touch. IconButton wraps an Icon in a Material '
          'tap target with hover, focus and splash effects.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFFE65100).withValues(alpha: 0.85),
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildComparisonPanel(
                title: 'Icon (passive)',
                accent: _kPrimary,
                code: "Icon(\n  Icons.thumb_up,\n  size: 32,\n  color: Colors.indigo,\n)",
                child: Icon(
                  Icons.thumb_up,
                  size: 32.0,
                  color: _kPrimary,
                ),
                notes: const [
                  'No tap target',
                  'No splash effect',
                  'No hover state',
                  'Inherits IconTheme',
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _buildComparisonPanel(
                title: 'IconButton (interactive)',
                accent: _kAccent,
                code: "IconButton(\n  onPressed: () {},\n  icon: Icon(Icons.thumb_up),\n)",
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.thumb_up,
                    size: 32.0,
                    color: _kAccent,
                  ),
                ),
                notes: const [
                  '48x48 tap target',
                  'Splash + hover',
                  'Focusable',
                  'Tooltip + a11y',
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: _kAccent.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: _kAccent, size: 22.0),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'Rule of thumb: use Icon when the glyph is decorative '
                  'or part of a larger compound widget. Use IconButton '
                  'whenever the glyph itself triggers an action.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF424242),
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

  // ============================================================
  // SECTION 7: Shadows + ShaderMask gradients
  // ============================================================
  print('=== Section 7: Shadows + Gradients ===');

  final shadowSamples = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFEDE7F6),
          Color(0xFFD1C4E9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF512DA8).withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.blur_on, color: Color(0xFF512DA8), size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Shadows & Gradients',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Icon.shadows accepts a list of Shadow objects. ShaderMask '
          'wraps an Icon to apply a gradient shader to its glyph.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF311B92).withValues(alpha: 0.85),
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            _buildShadowCase(
              label: 'soft drop',
              code: 'Shadow(\n  color: black54,\n  blurRadius: 4,\n  offset: (2,2),\n)',
              child: Icon(
                Icons.star,
                size: 64.0,
                color: _kHighlight,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 4.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            _buildShadowCase(
              label: 'glow',
              code: 'Shadow(\n  color: amber,\n  blurRadius: 16,\n  offset: (0,0),\n)',
              child: Icon(
                Icons.bolt,
                size: 64.0,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: _kHighlight,
                    blurRadius: 16.0,
                    offset: Offset(0.0, 0.0),
                  ),
                  Shadow(
                    color: _kHighlight,
                    blurRadius: 24.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            _buildShadowCase(
              label: 'long shadow',
              code: 'Shadow(\n  color: black87,\n  blurRadius: 0,\n  offset: (6,6),\n)',
              child: Icon(
                Icons.cloud,
                size: 64.0,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black87,
                    blurRadius: 0.0,
                    offset: Offset(6.0, 6.0),
                  ),
                ],
              ),
            ),
            _buildShadowCase(
              label: 'duotone',
              code: 'two shadows in opposite\noffsets create a 3D pop',
              child: Icon(
                Icons.favorite,
                size: 64.0,
                color: _kAccent,
                shadows: [
                  Shadow(
                    color: Color(0xFFC62828),
                    blurRadius: 0.0,
                    offset: Offset(-2.0, -2.0),
                  ),
                  Shadow(
                    color: Color(0xFFFFAB91),
                    blurRadius: 0.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Divider(color: Color(0xFF512DA8).withValues(alpha: 0.4)),
        SizedBox(height: 12.0),
        Text(
          'Gradient icons via ShaderMask:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            _buildGradientIcon(
              icon: Icons.local_fire_department,
              gradient: LinearGradient(
                colors: [Color(0xFFFFEB3B), Color(0xFFE65100)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              label: 'fire',
            ),
            _buildGradientIcon(
              icon: Icons.water_drop,
              gradient: LinearGradient(
                colors: [Color(0xFF81D4FA), Color(0xFF0D47A1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              label: 'water',
            ),
            _buildGradientIcon(
              icon: Icons.eco,
              gradient: LinearGradient(
                colors: [Color(0xFFA5D6A7), Color(0xFF1B5E20)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              label: 'leaf',
            ),
            _buildGradientIcon(
              icon: Icons.diamond,
              gradient: LinearGradient(
                colors: [Color(0xFFE1BEE7), Color(0xFF4A148C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              label: 'gem',
            ),
            _buildGradientIcon(
              icon: Icons.wb_sunny,
              gradient: LinearGradient(
                colors: [Color(0xFFFFF59D), Color(0xFFFF6F00)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              label: 'sun',
            ),
            _buildGradientIcon(
              icon: Icons.nights_stay,
              gradient: LinearGradient(
                colors: [Color(0xFFB39DDB), Color(0xFF1A237E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              label: 'night',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Icon in cards / tiles / chips
  // ============================================================
  print('=== Section 8: Cards / Tiles / Chips ===');

  final featureCards = Wrap(
    spacing: 16.0,
    runSpacing: 16.0,
    children: [
      _buildFeatureCard(
        icon: Icons.bolt,
        accent: _kHighlight,
        title: 'Fast',
        body: 'Lightning fast rendering with the Skia compositor.',
      ),
      _buildFeatureCard(
        icon: Icons.shield,
        accent: _kPrimary,
        title: 'Secure',
        body: 'End-to-end encryption keeps your data safe.',
      ),
      _buildFeatureCard(
        icon: Icons.eco,
        accent: Color(0xFF388E3C),
        title: 'Sustainable',
        body: 'Carbon-neutral hosting and efficient runtime.',
      ),
      _buildFeatureCard(
        icon: Icons.favorite,
        accent: Color(0xFFD81B60),
        title: 'Loved',
        body: 'Crafted by developers, polished by designers.',
      ),
    ],
  );

  final listTiles = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        _buildSettingsTile(
          icon: Icons.notifications,
          accent: _kPrimary,
          title: 'Notifications',
          subtitle: '3 active rules',
        ),
        Divider(height: 1.0),
        _buildSettingsTile(
          icon: Icons.lock,
          accent: _kAccent,
          title: 'Privacy',
          subtitle: 'Two-factor enabled',
        ),
        Divider(height: 1.0),
        _buildSettingsTile(
          icon: Icons.palette,
          accent: _kSecondary,
          title: 'Appearance',
          subtitle: 'System default',
        ),
        Divider(height: 1.0),
        _buildSettingsTile(
          icon: Icons.language,
          accent: Color(0xFF7B1FA2),
          title: 'Language',
          subtitle: 'English (US)',
        ),
        Divider(height: 1.0),
        _buildSettingsTile(
          icon: Icons.help_outline,
          accent: _kHighlight,
          title: 'Help & Feedback',
          subtitle: 'Knowledge base',
        ),
      ],
    ),
  );

  final chipRow = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE0F2F1),
          Color(0xFFB2DFDB),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _kSecondary.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.label, color: _kSecondary, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Icons inside Chips',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildIconChip(Icons.flight, 'Flight', _kPrimary),
            _buildIconChip(Icons.train, 'Train', _kAccent),
            _buildIconChip(Icons.directions_car, 'Car', _kSecondary),
            _buildIconChip(Icons.directions_bus, 'Bus', Color(0xFF7B1FA2)),
            _buildIconChip(Icons.directions_bike, 'Bike', Color(0xFF388E3C)),
            _buildIconChip(Icons.directions_walk, 'Walk', Color(0xFFD81B60)),
            _buildIconChip(Icons.local_taxi, 'Taxi', Color(0xFFEF6C00)),
            _buildIconChip(Icons.directions_boat, 'Boat', Color(0xFF1565C0)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: RTL-aware icons
  // ============================================================
  print('=== Section 9: RTL-aware Icons ===');

  final rtlPanel = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFCE4EC),
          Color(0xFFF8BBD0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFD81B60).withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz, color: Color(0xFFAD1457), size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'RTL-aware Icons',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF880E4F),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Some IconData entries set matchTextDirection: true. When an '
          'ambient TextDirection is RTL, those glyphs are mirrored to '
          'preserve their semantic meaning (forward = toward the next '
          'page in the reading direction).',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF880E4F).withValues(alpha: 0.85),
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildDirectionalityPanel(
                label: 'TextDirection.ltr',
                accent: _kPrimary,
                direction: TextDirection.ltr,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _buildDirectionalityPanel(
                label: 'TextDirection.rtl',
                accent: _kAccent,
                direction: TextDirection.rtl,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Color(0xFFAD1457).withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFFAD1457), size: 22.0),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'Tip: Icons with matchTextDirection=true include arrow_forward, '
                  'arrow_back, send, reply, redo, undo, chevron_left, chevron_right '
                  'and many list-style ordering glyphs.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF880E4F),
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

  // ============================================================
  // SECTION 10: Recap
  // ============================================================
  print('=== Section 10: Recap ===');

  final recapCard = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF263238),
          Color(0xFF37474F),
          Color(0xFF455A64),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.32),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark_added, color: Color(0xFF80CBC4), size: 26.0),
            SizedBox(width: 12.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Icon is the smallest visible building block in Material - a '
          'glyph drawn from a font, controlled by a handful of style '
          'properties, and aware of the surrounding IconTheme and '
          'Directionality. It composes naturally inside almost every '
          'other Material widget: buttons, chips, list tiles, app bars, '
          'cards and dialogs.',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFFCFD8DC),
            height: 1.6,
          ),
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildRecapTag('IconData driven', Color(0xFF80CBC4)),
            _buildRecapTag('IconTheme aware', Color(0xFFFFAB91)),
            _buildRecapTag('decorative', Color(0xFFCE93D8)),
            _buildRecapTag('a11y via semanticLabel', Color(0xFF90CAF9)),
            _buildRecapTag('shadows + gradients', Color(0xFFA5D6A7)),
            _buildRecapTag('RTL flips', Color(0xFFFFE082)),
            _buildRecapTag('text-scaling optional', Color(0xFFB39DDB)),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.tips_and_updates, color: Color(0xFFFFE082), size: 22.0),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'When in doubt: prefer Icons.* constants, set a size and '
                  'color explicitly inside compound widgets, and add a '
                  'semanticLabel whenever the icon is the sole content of '
                  'a control.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFFCFD8DC),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE
  // ============================================================
  print('=== Assembling SingleChildScrollView ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroBanner,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '2. Anatomy of Icon',
          'Every parameter accepted by the Icon constructor',
          _kPrimary,
          Icons.code,
        ),
        SizedBox(height: 12.0),
        anatomyPanel,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '3. Size Scale',
          'From 8px to 96px in twelve steps',
          _kSecondary,
          Icons.straighten,
        ),
        SizedBox(height: 12.0),
        sizeScale,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '4. Color Palette',
          'Material 2 hues sweep across the rainbow',
          _kAccent,
          Icons.palette,
        ),
        SizedBox(height: 12.0),
        colorPalette,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '5. Symbol Categories',
          'Action / Navigation / Content / Communication / Device / ...',
          Color(0xFF7B1FA2),
          Icons.category,
        ),
        SizedBox(height: 12.0),
        actionGrid,
        SizedBox(height: 16.0),
        navGrid,
        SizedBox(height: 16.0),
        contentGrid,
        SizedBox(height: 16.0),
        commGrid,
        SizedBox(height: 16.0),
        deviceGrid,
        SizedBox(height: 16.0),
        imageGrid,
        SizedBox(height: 16.0),
        socialGrid,
        SizedBox(height: 16.0),
        placeGrid,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '6. IconButton vs Icon',
          'Passive glyph vs interactive control',
          _kAccent,
          Icons.compare_arrows,
        ),
        SizedBox(height: 12.0),
        iconButtonComparison,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '7. Shadows & Gradients',
          'Icon.shadows and ShaderMask combinations',
          Color(0xFF512DA8),
          Icons.blur_on,
        ),
        SizedBox(height: 12.0),
        shadowSamples,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '8. Cards, Tiles & Chips',
          'Icon as part of larger compound widgets',
          _kSecondary,
          Icons.dashboard_customize,
        ),
        SizedBox(height: 12.0),
        featureCards,
        SizedBox(height: 16.0),
        listTiles,
        SizedBox(height: 16.0),
        chipRow,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '9. RTL-aware Icons',
          'TextDirection mirrors directional glyphs',
          Color(0xFFAD1457),
          Icons.swap_horiz,
        ),
        SizedBox(height: 12.0),
        rtlPanel,
        SizedBox(height: 28.0),
        _buildSectionHeader(
          '10. Recap',
          'Quick reference summary',
          Color(0xFF455A64),
          Icons.bookmark_added,
        ),
        SizedBox(height: 12.0),
        recapCard,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

class _LabelledIcon {
  final IconData icon;
  final String label;
  const _LabelledIcon(this.icon, this.label);
}

Widget _buildHeroBigIcon(IconData icon, Color color) {
  return Container(
    width: 56.0,
    height: 56.0,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.3),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Center(
      child: Icon(
        icon,
        color: color,
        size: 32.0,
        shadows: [
          Shadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
    ),
  );
}

Widget _buildHeroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(
  String title,
  String subtitle,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.02),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: color.withValues(alpha: 0.75),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomyEntry(String name, String type, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6.0,
          height: 6.0,
          margin: EdgeInsets.only(top: 6.0, right: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF80CBC4),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFAB91),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF455A64),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: Color(0xFFB2DFDB),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFFCFD8DC),
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

Widget _buildSizeStop(IconData icon, double size, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 100.0,
        width: size + 16.0 < 40.0 ? 40.0 : size + 16.0,
        child: Center(
          child: Icon(
            icon,
            size: size,
            color: color,
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          '${size.toInt()}px',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Widget _buildColorRow(String label, List<Widget> chips) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: _kMuted,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: chips,
          ),
        ),
      ],
    ),
  );
}

Widget _buildColorChip(String label, Color color, IconData icon) {
  return Container(
    width: 88.0,
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color.withValues(alpha: 0.5),
        width: 1.0,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: _kOnSurface,
            fontFamily: 'monospace',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildCategoryGrid({
  required String title,
  required String description,
  required Color accent,
  required IconData icon,
  required List<_LabelledIcon> icons,
}) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.3),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.14),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: accent, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: _kMuted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${icons.length}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: icons.map((li) {
            return _buildLabelledIconTile(li, accent);
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildLabelledIconTile(_LabelledIcon li, Color accent) {
  return Container(
    width: 88.0,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.04),
          accent.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.18),
        width: 1.0,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(li.icon, color: accent, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          li.label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: _kOnSurface,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _buildComparisonPanel({
  required String title,
  required Color accent,
  required String code,
  required Widget child,
  required List<String> notes,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.4),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(child: child),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Color(0xFF80CBC4),
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: notes.map((n) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: accent, size: 12.0),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      n,
                      style: TextStyle(
                        fontSize: 11.0,
                        color: _kMuted,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildShadowCase({
  required String label,
  required String code,
  required Widget child,
}) {
  return Container(
    width: 160.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: Color(0xFF512DA8).withValues(alpha: 0.3),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF512DA8).withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        SizedBox(
          height: 80.0,
          child: Center(child: child),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Color(0xFF512DA8).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF311B92),
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.5,
              color: Color(0xFF80CBC4),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildGradientIcon({
  required IconData icon,
  required LinearGradient gradient,
  required String label,
}) {
  return Container(
    width: 110.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: Color(0xFF512DA8).withValues(alpha: 0.3),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF512DA8).withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return gradient.createShader(bounds);
          },
          child: Icon(
            icon,
            size: 56.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFeatureCard({
  required IconData icon,
  required Color accent,
  required String title,
  required String body,
}) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.3),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent.withValues(alpha: 0.18),
                accent.withValues(alpha: 0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Icon(icon, color: accent, size: 32.0),
        ),
        SizedBox(height: 14.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: _kOnSurface,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.5,
            color: _kMuted,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSettingsTile({
  required IconData icon,
  required Color accent,
  required String title,
  required String subtitle,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: accent, size: 22.0),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: _kOnSurface,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _kMuted,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.chevron_right,
          color: Color(0xFFBDBDBD),
          size: 20.0,
        ),
      ],
    ),
  );
}

Widget _buildIconChip(IconData icon, String label, Color accent) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.4),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: accent, size: 16.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: accent,
          ),
        ),
      ],
    ),
  );
}

Widget _buildDirectionalityPanel({
  required String label,
  required Color accent,
  required TextDirection direction,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.4),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Directionality(
          textDirection: direction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDirectionalRow(
                Icons.arrow_forward,
                'arrow_forward',
                accent,
              ),
              _buildDirectionalRow(
                Icons.arrow_back,
                'arrow_back',
                accent,
              ),
              _buildDirectionalRow(
                Icons.send,
                'send',
                accent,
              ),
              _buildDirectionalRow(
                Icons.reply,
                'reply',
                accent,
              ),
              _buildDirectionalRow(
                Icons.redo,
                'redo',
                accent,
              ),
              _buildDirectionalRow(
                Icons.chevron_right,
                'chevron_right',
                accent,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDirectionalRow(IconData icon, String name, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      children: [
        Icon(icon, color: accent, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kOnSurface,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecapTag(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}
