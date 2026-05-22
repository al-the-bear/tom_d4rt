// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for CupertinoIcons (SF Symbols-inspired set).
//
// Design Plan
// -----------
// This file is a hand-crafted, narrative deep-demo for `CupertinoIcons`. The
// goal is to render a single scrollable Flutter page that explores Apple's
// SF Symbols-inspired glyph catalogue available inside Flutter.
//
// Sections (each numbered, each renders real widgets):
//   1. Header banner + introduction to CupertinoIcons.
//   2. Categorized icon grids (navigation, actions, media, system,
//      communication, social, file, people) - 8 to 12 icons per category.
//   3. CupertinoIcons vs Material Icons side-by-side comparison.
//   4. Size ramp (12, 16, 24, 32, 48, 64) and color variations.
//   5. Interaction wrappers - IconButton, CupertinoButton, CupertinoListTile
//      and navigation-bar leading / trailing usage.
//   6. Code recipes for common idioms.
//   7. Glossary of terminology and naming conventions.
//
// Conventions: Material 3 ColorScheme palette via container hues (primary /
// secondary / tertiary / error containers). No dialogs, no async, no
// dart:io, no navigation. Plain ASCII narrative only.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ============================================================================
// Curated icon data
// ============================================================================
//
// We collect the icons up-front so each section can consume the same lookup
// tables. Each entry is (label, icon). We keep the lists hand-curated so the
// demo does not look auto-generated.

class _IconEntry {
  final String name;
  final IconData icon;
  const _IconEntry(this.name, this.icon);
}

class _CategoryGroup {
  final String title;
  final String subtitle;
  final IconData heading;
  final Color seed;
  final List<_IconEntry> items;
  const _CategoryGroup({
    required this.title,
    required this.subtitle,
    required this.heading,
    required this.seed,
    required this.items,
  });
}

const List<_IconEntry> _navIcons = [
  _IconEntry('back', CupertinoIcons.back),
  _IconEntry('forward', CupertinoIcons.forward),
  _IconEntry('chevron_left', CupertinoIcons.chevron_left),
  _IconEntry('chevron_right', CupertinoIcons.chevron_right),
  _IconEntry('chevron_up', CupertinoIcons.chevron_up),
  _IconEntry('chevron_down', CupertinoIcons.chevron_down),
  _IconEntry('arrow_up', CupertinoIcons.arrow_up),
  _IconEntry('arrow_down', CupertinoIcons.arrow_down),
  _IconEntry('arrow_left', CupertinoIcons.arrow_left),
  _IconEntry('arrow_right', CupertinoIcons.arrow_right),
  _IconEntry('house', CupertinoIcons.house),
  _IconEntry('home', CupertinoIcons.home),
];

const List<_IconEntry> _actionIcons = [
  _IconEntry('add', CupertinoIcons.add),
  _IconEntry('add_circled', CupertinoIcons.add_circled),
  _IconEntry('delete', CupertinoIcons.delete),
  _IconEntry('trash', CupertinoIcons.trash),
  _IconEntry('pencil', CupertinoIcons.pencil),
  _IconEntry('square_pencil', CupertinoIcons.square_pencil),
  _IconEntry('share', CupertinoIcons.share),
  _IconEntry('refresh', CupertinoIcons.refresh),
  _IconEntry('arrow_2_circlepath', CupertinoIcons.arrow_2_circlepath),
  _IconEntry('cloud_download', CupertinoIcons.cloud_download),
  _IconEntry('cloud_upload', CupertinoIcons.cloud_upload),
  _IconEntry('printer', CupertinoIcons.printer),
];

const List<_IconEntry> _mediaIcons = [
  _IconEntry('play', CupertinoIcons.play),
  _IconEntry('play_arrow', CupertinoIcons.play_arrow),
  _IconEntry('pause', CupertinoIcons.pause),
  _IconEntry('stop', CupertinoIcons.stop),
  _IconEntry('forward_fill', CupertinoIcons.forward_fill),
  _IconEntry('backward_fill', CupertinoIcons.backward_fill),
  _IconEntry('volume_off', CupertinoIcons.volume_off),
  _IconEntry('volume_down', CupertinoIcons.volume_down),
  _IconEntry('volume_up', CupertinoIcons.volume_up),
  _IconEntry('music_note', CupertinoIcons.music_note),
  _IconEntry('film', CupertinoIcons.film),
  _IconEntry('mic', CupertinoIcons.mic),
];

const List<_IconEntry> _systemIcons = [
  _IconEntry('settings', CupertinoIcons.settings),
  _IconEntry('gear', CupertinoIcons.gear),
  _IconEntry('info', CupertinoIcons.info),
  _IconEntry('exclamationmark_triangle', CupertinoIcons.exclamationmark_triangle),
  _IconEntry('checkmark', CupertinoIcons.checkmark),
  _IconEntry('xmark', CupertinoIcons.xmark),
  _IconEntry('bell', CupertinoIcons.bell),
  _IconEntry('bell_fill', CupertinoIcons.bell_fill),
  _IconEntry('lock', CupertinoIcons.lock),
  _IconEntry('lock_fill', CupertinoIcons.lock_fill),
  _IconEntry('eye', CupertinoIcons.eye),
  _IconEntry('eye_slash', CupertinoIcons.eye_slash),
];

const List<_IconEntry> _communicationIcons = [
  _IconEntry('mail', CupertinoIcons.mail),
  _IconEntry('envelope', CupertinoIcons.envelope),
  _IconEntry('envelope_fill', CupertinoIcons.envelope_fill),
  _IconEntry('phone', CupertinoIcons.phone),
  _IconEntry('phone_fill', CupertinoIcons.phone_fill),
  _IconEntry('chat_bubble', CupertinoIcons.chat_bubble),
  _IconEntry('chat_bubble_text', CupertinoIcons.chat_bubble_text),
  _IconEntry('chat_bubble_2', CupertinoIcons.chat_bubble_2),
  _IconEntry('paperplane', CupertinoIcons.paperplane),
  _IconEntry('paperplane_fill', CupertinoIcons.paperplane_fill),
  _IconEntry('video_camera', CupertinoIcons.video_camera),
  _IconEntry('at', CupertinoIcons.at),
];

const List<_IconEntry> _socialIcons = [
  _IconEntry('heart', CupertinoIcons.heart),
  _IconEntry('heart_fill', CupertinoIcons.heart_fill),
  _IconEntry('star', CupertinoIcons.star),
  _IconEntry('star_fill', CupertinoIcons.star_fill),
  _IconEntry('star_circle', CupertinoIcons.star_circle),
  _IconEntry('bookmark', CupertinoIcons.bookmark),
  _IconEntry('bookmark_fill', CupertinoIcons.bookmark_fill),
  _IconEntry('flag', CupertinoIcons.flag),
  _IconEntry('flag_fill', CupertinoIcons.flag_fill),
  _IconEntry('hand_thumbsup', CupertinoIcons.hand_thumbsup),
  _IconEntry('hand_thumbsdown', CupertinoIcons.hand_thumbsdown),
  _IconEntry('smiley', CupertinoIcons.smiley),
];

const List<_IconEntry> _fileIcons = [
  _IconEntry('folder', CupertinoIcons.folder),
  _IconEntry('folder_fill', CupertinoIcons.folder_fill),
  _IconEntry('folder_open', CupertinoIcons.folder_open),
  _IconEntry('doc', CupertinoIcons.doc),
  _IconEntry('doc_text', CupertinoIcons.doc_text),
  _IconEntry('doc_on_doc', CupertinoIcons.doc_on_doc),
  _IconEntry('photo', CupertinoIcons.photo),
  _IconEntry('photo_fill', CupertinoIcons.photo_fill),
  _IconEntry('calendar', CupertinoIcons.calendar),
  _IconEntry('calendar_today', CupertinoIcons.calendar_today),
  _IconEntry('archivebox', CupertinoIcons.archivebox),
  _IconEntry('tray', CupertinoIcons.tray),
];

const List<_IconEntry> _peopleIcons = [
  _IconEntry('person', CupertinoIcons.person),
  _IconEntry('person_fill', CupertinoIcons.person_fill),
  _IconEntry('person_alt', CupertinoIcons.person_alt),
  _IconEntry('person_alt_circle', CupertinoIcons.person_alt_circle),
  _IconEntry('person_2', CupertinoIcons.person_2),
  _IconEntry('person_2_fill', CupertinoIcons.person_2_fill),
  _IconEntry('person_3', CupertinoIcons.person_3),
  _IconEntry('person_3_fill', CupertinoIcons.person_3_fill),
  _IconEntry('person_crop_circle', CupertinoIcons.person_crop_circle),
  _IconEntry('person_crop_square', CupertinoIcons.person_crop_square),
  _IconEntry('group', CupertinoIcons.group),
  _IconEntry('group_solid', CupertinoIcons.group_solid),
];

const List<_CategoryGroup> _categories = [
  _CategoryGroup(
    title: 'Navigation',
    subtitle: 'Move between screens, scroll, drill into hierarchies',
    heading: CupertinoIcons.arrow_right_arrow_left,
    seed: Color(0xFF1565C0),
    items: _navIcons,
  ),
  _CategoryGroup(
    title: 'Actions',
    subtitle: 'Create, edit, share, refresh and other verbs',
    heading: CupertinoIcons.pencil_circle,
    seed: Color(0xFF2E7D32),
    items: _actionIcons,
  ),
  _CategoryGroup(
    title: 'Media',
    subtitle: 'Playback transport and volume controls',
    heading: CupertinoIcons.play_circle,
    seed: Color(0xFFAD1457),
    items: _mediaIcons,
  ),
  _CategoryGroup(
    title: 'System',
    subtitle: 'Settings, alerts, security and visibility',
    heading: CupertinoIcons.gear_alt,
    seed: Color(0xFF6A1B9A),
    items: _systemIcons,
  ),
  _CategoryGroup(
    title: 'Communication',
    subtitle: 'Mail, phone, chat, and outbound messages',
    heading: CupertinoIcons.envelope_open,
    seed: Color(0xFF00838F),
    items: _communicationIcons,
  ),
  _CategoryGroup(
    title: 'Social',
    subtitle: 'Reactions, favourites and bookmarks',
    heading: CupertinoIcons.heart_circle,
    seed: Color(0xFFC62828),
    items: _socialIcons,
  ),
  _CategoryGroup(
    title: 'Files',
    subtitle: 'Folders, documents, photos and calendar',
    heading: CupertinoIcons.folder_circle,
    seed: Color(0xFFEF6C00),
    items: _fileIcons,
  ),
  _CategoryGroup(
    title: 'People',
    subtitle: 'Single, paired, grouped and crop avatars',
    heading: CupertinoIcons.person_2_square_stack,
    seed: Color(0xFF4527A0),
    items: _peopleIcons,
  ),
];

// ============================================================================
// AST entrypoint expected by the D4rt test runner.
// ============================================================================

dynamic build(BuildContext context) {
  print('CupertinoIcons Deep Demo executing');

  // ==========================================================================
  // SECTION 1: Header banner + introduction
  // ==========================================================================
  print('=== Section 1: Header and Introduction ===');

  final headerBanner = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF0A84FF),
          Color(0xFF5E5CE6),
          Color(0xFFBF5AF2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.4,
                ),
              ),
              child: const Icon(
                CupertinoIcons.app_badge,
                size: 48.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CupertinoIcons',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Apple SF Symbols-inspired glyph set for Flutter',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _badge('Deep Demo', CupertinoIcons.sparkles),
            _badge('8 categories', CupertinoIcons.square_grid_2x2),
            _badge('Sizes 12-64', CupertinoIcons.textformat_size),
            _badge('Material 3', CupertinoIcons.paintbrush),
          ],
        ),
      ],
    ),
  );

  final introCard = Container(
    margin: const EdgeInsets.only(bottom: 28.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.info_circle, color: Colors.blueGrey.shade700),
            const SizedBox(width: 8.0),
            Text(
              'What is CupertinoIcons?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'CupertinoIcons is a curated icon font that mirrors Apple\'s SF '
          'Symbols visual language. Each glyph in the font is exposed as a '
          'static `IconData` constant on the `CupertinoIcons` class, e.g. '
          '`CupertinoIcons.heart_fill`. The naming follows snake_case and '
          'common variants are appended as suffixes such as `_fill`, '
          '`_circle`, `_circled`, `_solid`, `_slash` and `_alt`.',
          style: TextStyle(
            color: Colors.blueGrey.shade800,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2: Categorized icon grids
  // ==========================================================================
  print('=== Section 2: Categorized Icon Grids ===');

  final categorySections = <Widget>[];
  for (final cat in _categories) {
    print('Rendering category ${cat.title} (${cat.items.length} icons)');
    final tiles = <Widget>[];
    for (final entry in cat.items) {
      tiles.add(_iconTile(entry, cat.seed));
    }
    categorySections.add(_categoryCard(cat, tiles));
    categorySections.add(const SizedBox(height: 18.0));
  }

  // ==========================================================================
  // SECTION 3: CupertinoIcons vs Material Icons comparison
  // ==========================================================================
  print('=== Section 3: CupertinoIcons vs Material Icons ===');

  // Hand-paired equivalents (best-effort visual match). Each row shows the
  // Cupertino glyph on the left and the closest Material Icons cousin on the
  // right.
  final compareRows = <_ComparePair>[
    _ComparePair('Home', CupertinoIcons.home, Icons.home),
    _ComparePair('Search', CupertinoIcons.search, Icons.search),
    _ComparePair('Settings', CupertinoIcons.settings, Icons.settings),
    _ComparePair('Favorite', CupertinoIcons.heart_fill, Icons.favorite),
    _ComparePair('Mail', CupertinoIcons.mail, Icons.mail),
    _ComparePair('Phone', CupertinoIcons.phone, Icons.phone),
    _ComparePair('Camera', CupertinoIcons.camera, Icons.camera_alt),
    _ComparePair('Add', CupertinoIcons.add, Icons.add),
    _ComparePair('Close', CupertinoIcons.xmark, Icons.close),
    _ComparePair('Check', CupertinoIcons.checkmark, Icons.check),
    _ComparePair('Trash', CupertinoIcons.trash, Icons.delete),
    _ComparePair('Share', CupertinoIcons.share, Icons.share),
    _ComparePair('Calendar', CupertinoIcons.calendar, Icons.calendar_today),
    _ComparePair('Person', CupertinoIcons.person, Icons.person),
    _ComparePair('Lock', CupertinoIcons.lock_fill, Icons.lock),
    _ComparePair('Refresh', CupertinoIcons.refresh, Icons.refresh),
  ];

  final compareWidgets = <Widget>[];
  for (final pair in compareRows) {
    compareWidgets.add(_compareRow(pair));
  }

  final compareSection = Container(
    margin: const EdgeInsets.only(top: 12.0, bottom: 28.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.square_split_2x1, color: Colors.deepPurple.shade700),
            const SizedBox(width: 8.0),
            Text(
              'Cupertino vs Material side-by-side',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            _compareHeader('Concept', Colors.deepPurple.shade900, flex: 2),
            _compareHeader('CupertinoIcons', Colors.deepPurple.shade900, flex: 3),
            _compareHeader('Material Icons', Colors.deepPurple.shade900, flex: 3),
          ],
        ),
        const SizedBox(height: 6.0),
        ...compareWidgets,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 4: Size ramp + color variations
  // ==========================================================================
  print('=== Section 4: Size Ramp and Color Variations ===');

  const sizeRamp = [12.0, 16.0, 24.0, 32.0, 48.0, 64.0];

  final sizeTiles = <Widget>[];
  for (final size in sizeRamp) {
    sizeTiles.add(
      Container(
        width: size + 56.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Column(
          children: [
            Icon(
              CupertinoIcons.bolt_fill,
              size: size,
              color: Colors.teal.shade700,
            ),
            const SizedBox(height: 6.0),
            Text(
              '${size.toInt()} px',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.teal.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Color variations: primary, secondary, tertiary, error containers (M3).
  final colorVariants = <_ColorVariant>[
    _ColorVariant('primary', Color(0xFF6750A4), Color(0xFFEADDFF)),
    _ColorVariant('secondary', Color(0xFF625B71), Color(0xFFE8DEF8)),
    _ColorVariant('tertiary', Color(0xFF7D5260), Color(0xFFFFD8E4)),
    _ColorVariant('error', Color(0xFFB3261E), Color(0xFFF9DEDC)),
    _ColorVariant('success', Color(0xFF1B5E20), Color(0xFFC8E6C9)),
    _ColorVariant('warning', Color(0xFFE65100), Color(0xFFFFE0B2)),
  ];

  final colorTiles = <Widget>[];
  for (final variant in colorVariants) {
    colorTiles.add(
      Container(
        width: 132.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: variant.container,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: variant.fg.withValues(alpha: 0.35)),
        ),
        child: Column(
          children: [
            Icon(CupertinoIcons.star_fill, size: 40.0, color: variant.fg),
            const SizedBox(height: 8.0),
            Text(
              variant.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: variant.fg,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: variant.fg.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'container',
                style: TextStyle(fontSize: 10.0, color: variant.fg),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final sizeSection = Container(
    margin: const EdgeInsets.only(bottom: 18.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade50.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size ramp - 12, 16, 24, 32, 48, 64',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: sizeTiles),
      ],
    ),
  );

  final colorSection = Container(
    margin: const EdgeInsets.only(bottom: 28.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Material 3 ColorScheme idioms',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        const SizedBox(height: 12.0),
        Wrap(children: colorTiles),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5: Interaction wrappers - IconButton, CupertinoButton, ListTile,
  //            and navigation bar usage.
  // ==========================================================================
  print('=== Section 5: Interaction Wrappers ===');

  final iconButtonRow = Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IconButton wrap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade900,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.heart),
              tooltip: 'Like',
              color: Colors.pink,
              onPressed: null,
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.bookmark),
              tooltip: 'Save',
              color: Colors.indigo,
              onPressed: null,
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.share),
              tooltip: 'Share',
              color: Colors.teal,
              onPressed: null,
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.ellipsis),
              tooltip: 'More',
              color: Colors.grey,
              onPressed: null,
            ),
          ],
        ),
      ],
    ),
  );

  final cupertinoButtonRow = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.lightBlue.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.lightBlue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CupertinoButton with leading glyph',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue.shade900,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton.filled(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 8.0,
              ),
              onPressed: null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(CupertinoIcons.cloud_download_fill, size: 18.0),
                  SizedBox(width: 6.0),
                  Text('Download'),
                ],
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 8.0,
              ),
              onPressed: null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(CupertinoIcons.share, size: 18.0),
                  SizedBox(width: 6.0),
                  Text('Share'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  final listTileSample = Container(
    margin: const EdgeInsets.only(top: 12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: const [
        CupertinoListTile(
          leading: Icon(CupertinoIcons.bell_fill, color: CupertinoColors.activeOrange),
          title: Text('Notifications'),
          subtitle: Text('Sounds, banners and badges'),
          trailing: Icon(CupertinoIcons.chevron_right),
        ),
        Divider(height: 1),
        CupertinoListTile(
          leading: Icon(CupertinoIcons.lock_fill, color: CupertinoColors.systemGrey),
          title: Text('Privacy'),
          subtitle: Text('Location, photos and camera'),
          trailing: Icon(CupertinoIcons.chevron_right),
        ),
        Divider(height: 1),
        CupertinoListTile(
          leading: Icon(CupertinoIcons.wifi, color: CupertinoColors.activeBlue),
          title: Text('Wi-Fi'),
          subtitle: Text('Networks and hotspots'),
          trailing: Icon(CupertinoIcons.chevron_right),
        ),
        Divider(height: 1),
        CupertinoListTile(
          leading: Icon(CupertinoIcons.airplane, color: CupertinoColors.activeOrange),
          title: Text('Airplane mode'),
          subtitle: Text('Disable all radios'),
          trailing: Icon(CupertinoIcons.chevron_right),
        ),
      ],
    ),
  );

  final navBarSample = Container(
    margin: const EdgeInsets.only(top: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    clipBehavior: Clip.antiAlias,
    child: const CupertinoNavigationBar(
      leading: Icon(CupertinoIcons.back),
      middle: Text('Inbox'),
      trailing: Icon(CupertinoIcons.square_pencil),
    ),
  );

  final interactionSection = Container(
    margin: const EdgeInsets.only(bottom: 28.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.orange.shade50.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.hand_point_right_fill, color: Colors.orange.shade700),
            const SizedBox(width: 8.0),
            Text(
              'Icons inside interactive widgets',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        iconButtonRow,
        cupertinoButtonRow,
        listTileSample,
        navBarSample,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 6: Recipes
  // ==========================================================================
  print('=== Section 6: Recipes ===');

  final recipes = <_Recipe>[
    _Recipe(
      title: 'Centered glyph',
      code: 'const Icon(CupertinoIcons.heart_fill,\n'
          '            size: 32, color: Colors.pink);',
      color: Colors.pink,
      glyph: CupertinoIcons.heart_fill,
    ),
    _Recipe(
      title: 'Tappable circular avatar',
      code: 'CircleAvatar(\n'
          '  backgroundColor: Colors.indigo,\n'
          '  child: Icon(CupertinoIcons.person_fill,\n'
          '              color: Colors.white),\n'
          ');',
      color: Colors.indigo,
      glyph: CupertinoIcons.person_fill,
    ),
    _Recipe(
      title: 'IconButton with tooltip',
      code: 'IconButton(\n'
          '  icon: const Icon(CupertinoIcons.bell_fill),\n'
          '  tooltip: "Alerts",\n'
          '  onPressed: () {},\n'
          ');',
      color: Colors.amber.shade800,
      glyph: CupertinoIcons.bell_fill,
    ),
    _Recipe(
      title: 'Cupertino nav-bar trailing action',
      code: 'CupertinoNavigationBar(\n'
          '  middle: Text("Inbox"),\n'
          '  trailing: Icon(CupertinoIcons.square_pencil),\n'
          ');',
      color: Colors.blue,
      glyph: CupertinoIcons.square_pencil,
    ),
    _Recipe(
      title: 'Filled vs outlined variants',
      code: 'const Icon(CupertinoIcons.bookmark);       // outline\n'
          'const Icon(CupertinoIcons.bookmark_fill);  // filled',
      color: Colors.deepPurple,
      glyph: CupertinoIcons.bookmark_fill,
    ),
    _Recipe(
      title: 'Slashed-state toggle',
      code: 'final muted = true;\n'
          'Icon(muted ? CupertinoIcons.volume_off\n'
          '           : CupertinoIcons.volume_up);',
      color: Colors.teal,
      glyph: CupertinoIcons.volume_off,
    ),
  ];

  final recipeWidgets = <Widget>[];
  for (final r in recipes) {
    recipeWidgets.add(_recipeCard(r));
  }

  final recipesSection = Container(
    margin: const EdgeInsets.only(bottom: 28.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.book, color: Colors.cyan.shade300),
            const SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                color: Colors.cyan.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        ...recipeWidgets,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 7: Glossary
  // ==========================================================================
  print('=== Section 7: Glossary ===');

  final glossaryItems = <_GlossaryItem>[
    _GlossaryItem(
      'IconData',
      'The lightweight font code-point + metadata. Every CupertinoIcons '
          'constant is an IconData.',
      CupertinoIcons.tag,
      Colors.blue,
    ),
    _GlossaryItem(
      'Icon',
      'A widget that draws an IconData with a given size, color and '
          'semantic label.',
      CupertinoIcons.square_grid_2x2,
      Colors.indigo,
    ),
    _GlossaryItem(
      '_fill suffix',
      'Filled variant of an outlined glyph (e.g. heart vs heart_fill).',
      CupertinoIcons.heart_fill,
      Colors.pink,
    ),
    _GlossaryItem(
      '_circle / _circled suffix',
      'Glyph enclosed in a circle - typical for status badges.',
      CupertinoIcons.checkmark_circle,
      Colors.green,
    ),
    _GlossaryItem(
      '_solid suffix',
      'Solid (filled) version of a circled glyph (e.g. add_circled_solid).',
      CupertinoIcons.add_circled_solid,
      Colors.deepOrange,
    ),
    _GlossaryItem(
      '_slash suffix',
      'Indicates a disabled or muted state (volume_off, eye_slash).',
      CupertinoIcons.eye_slash,
      Colors.grey,
    ),
    _GlossaryItem(
      '_alt suffix',
      'Alternate version of an existing glyph (gear_alt, person_alt).',
      CupertinoIcons.gear_alt,
      Colors.brown,
    ),
    _GlossaryItem(
      'CupertinoIcons font',
      'The TTF font shipped with Flutter that backs every CupertinoIcons '
          'codepoint. Must be declared as a font asset in pubspec.',
      CupertinoIcons.textformat,
      Colors.teal,
    ),
    _GlossaryItem(
      'Semantic label',
      'Accessibility text that screen-readers announce; pass via the '
          '`semanticLabel` argument on Icon.',
      CupertinoIcons.speaker_2_fill,
      Colors.purple,
    ),
  ];

  final glossaryWidgets = <Widget>[];
  for (final item in glossaryItems) {
    glossaryWidgets.add(_glossaryRow(item));
  }

  final glossarySection = Container(
    margin: const EdgeInsets.only(bottom: 28.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.book_fill, color: Colors.indigo.shade700),
            const SizedBox(width: 8.0),
            Text(
              'Glossary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        ...glossaryWidgets,
      ],
    ),
  );

  // ==========================================================================
  // Final assembly
  // ==========================================================================
  print('CupertinoIcons Deep Demo completed successfully');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        headerBanner,
        introCard,
        const _SectionTitle('1. Categorized icon grids', CupertinoIcons.square_grid_2x2),
        ...categorySections,
        const _SectionTitle('2. CupertinoIcons vs Material Icons',
            CupertinoIcons.square_split_2x1),
        compareSection,
        const _SectionTitle('3. Size ramp', CupertinoIcons.textformat_size),
        sizeSection,
        const _SectionTitle('4. Color variations (Material 3)',
            CupertinoIcons.paintbrush_fill),
        colorSection,
        const _SectionTitle('5. Interaction wrappers',
            CupertinoIcons.hand_point_right_fill),
        interactionSection,
        const _SectionTitle('6. Recipes', CupertinoIcons.book),
        recipesSection,
        const _SectionTitle('7. Glossary', CupertinoIcons.book_fill),
        glossarySection,
      ],
    ),
  );
}

// ============================================================================
// Helper widgets and value classes
// ============================================================================

Widget _badge(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
        Icon(icon, size: 14.0, color: Colors.white),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _iconTile(_IconEntry entry, Color seed) {
  return Container(
    width: 96.0,
    margin: const EdgeInsets.all(4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: seed.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: seed.withValues(alpha: 0.25)),
    ),
    child: Column(
      children: [
        Icon(entry.icon, size: 32.0, color: seed),
        const SizedBox(height: 6.0),
        Text(
          entry.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10.5,
            color: seed,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _categoryCard(_CategoryGroup cat, List<Widget> tiles) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: cat.seed.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: cat.seed.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: cat.seed.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(cat.heading, color: cat.seed),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cat.seed,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    cat.subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: cat.seed.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: cat.seed.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '${cat.items.length} icons',
                style: TextStyle(
                  fontSize: 11.0,
                  color: cat.seed,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Wrap(alignment: WrapAlignment.start, children: tiles),
      ],
    ),
  );
}

class _ComparePair {
  final String label;
  final IconData cupertino;
  final IconData material;
  const _ComparePair(this.label, this.cupertino, this.material);
}

Widget _compareHeader(String text, Color color, {required int flex}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: 12.0,
        ),
      ),
    ),
  );
}

Widget _compareRow(_ComparePair pair) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.deepPurple.shade100),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            pair.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Icon(pair.cupertino, color: Colors.blue.shade700),
              const SizedBox(width: 8.0),
              Text(
                'CupertinoIcons',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.blue.shade700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Icon(pair.material, color: Colors.red.shade700),
              const SizedBox(width: 8.0),
              Text(
                'Icons',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.red.shade700,
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

class _ColorVariant {
  final String label;
  final Color fg;
  final Color container;
  const _ColorVariant(this.label, this.fg, this.container);
}

class _Recipe {
  final String title;
  final String code;
  final Color color;
  final IconData glyph;
  const _Recipe({
    required this.title,
    required this.code,
    required this.color,
    required this.glyph,
  });
}

Widget _recipeCard(_Recipe r) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: r.color.withValues(alpha: 0.6), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: r.color.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(r.glyph, color: r.color, size: 18.0),
            ),
            const SizedBox(width: 8.0),
            Text(
              r.title,
              style: TextStyle(
                color: r.color,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            r.code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

class _GlossaryItem {
  final String term;
  final String description;
  final IconData glyph;
  final Color color;
  const _GlossaryItem(this.term, this.description, this.glyph, this.color);
}

Widget _glossaryRow(_GlossaryItem item) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: item.color.withValues(alpha: 0.35)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(item.glyph, color: item.color, size: 18.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.term,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: item.color,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                item.description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade800,
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

class _SectionTitle extends StatelessWidget {
  final String text;
  final IconData icon;
  const _SectionTitle(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 22.0, color: Colors.indigo.shade700),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              height: 2.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade200,
                    Colors.indigo.shade50.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Stateless root widget + main entrypoint
// ============================================================================
//
// The D4rt test runner invokes the top-level `build(BuildContext)` function
// directly; outside of the AST runner, the file can also be executed as a
// regular Flutter program through `main()` below. The root is intentionally
// stateless: all data is hand-curated above.

class CupertinoIconsDemoApp extends StatelessWidget {
  const CupertinoIconsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CupertinoIcons Deep Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6750A4),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CupertinoIcons Deep Demo'),
          leading: const Icon(CupertinoIcons.app_badge),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(builder: (ctx) => build(ctx)),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const CupertinoIconsDemoApp());
