// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Icons class from material
import 'package:flutter/material.dart';

// Helper: section header with icon
Widget buildSectionHeader(String title) {
  print('Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF1565C0),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper: sub-section header
Widget buildSubHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    margin: EdgeInsets.only(top: 12, bottom: 8),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFF90CAF9), width: 1),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF0D47A1),
      ),
    ),
  );
}

// Helper: info card with label and value
Widget buildInfoCard(String label, String value) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
          ),
        ),
      ],
    ),
  );
}

// Helper: icon display card with label
Widget buildIconCard(
  IconData iconData,
  String label, {
  Color iconColor = Colors.black87,
  double iconSize = 28,
}) {
  return Container(
    width: 90,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    margin: EdgeInsets.all(3),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x15000000),
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: iconSize, color: iconColor),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 9, color: Color(0xFF616161)),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    ),
  );
}

// Helper: colored icon display
Widget buildColoredIconCard(
  IconData iconData,
  String label,
  Color bgColor,
  Color fgColor,
) {
  return Container(
    width: 80,
    height: 80,
    margin: EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0x20000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: 32, color: fgColor),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 8, color: fgColor),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Helper: icon size comparison card
Widget buildSizedIconCard(IconData iconData, double size, String sizeLabel) {
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: size, color: Color(0xFF37474F)),
        SizedBox(height: 4),
        Text(
          sizeLabel,
          style: TextStyle(fontSize: 10, color: Color(0xFF78909C)),
        ),
      ],
    ),
  );
}

// Helper: icon in context showcase row
Widget buildContextRow(String contextLabel, Widget child) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contextLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF455A64),
          ),
        ),
        SizedBox(height: 8),
        child,
      ],
    ),
  );
}

// Helper: category grid tile
Widget buildCategoryTile(String category, List<Widget> iconWidgets) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFBBDEFB), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x10000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFF42A5F5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        SizedBox(height: 8),
        Wrap(spacing: 4, runSpacing: 4, children: iconWidgets),
      ],
    ),
  );
}

// Helper: mini icon chip
Widget buildMiniIconChip(IconData iconData, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Color(0xFF9FA8DA), width: 0.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: 14, color: Color(0xFF3F51B5)),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: Color(0xFF283593))),
      ],
    ),
  );
}

// Helper: build a navigation icons gallery
Widget buildNavigationGallery() {
  print('Building navigation icons gallery');
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    children: [
      buildIconCard(Icons.home, 'home'),
      buildIconCard(Icons.menu, 'menu'),
      buildIconCard(Icons.arrow_back, 'arrow_back'),
      buildIconCard(Icons.arrow_forward, 'arrow_forward'),
      buildIconCard(Icons.close, 'close'),
      buildIconCard(Icons.more_vert, 'more_vert'),
      buildIconCard(Icons.more_horiz, 'more_horiz'),
      buildIconCard(Icons.expand_more, 'expand_more'),
      buildIconCard(Icons.expand_less, 'expand_less'),
      buildIconCard(Icons.chevron_left, 'chevron_left'),
      buildIconCard(Icons.chevron_right, 'chevron_right'),
      buildIconCard(Icons.fullscreen, 'fullscreen'),
      buildIconCard(Icons.fullscreen_exit, 'fullscreen_exit'),
      buildIconCard(Icons.subdirectory_arrow_right, 'subdir_right'),
      buildIconCard(Icons.subdirectory_arrow_left, 'subdir_left'),
      buildIconCard(Icons.arrow_upward, 'arrow_upward'),
      buildIconCard(Icons.arrow_downward, 'arrow_downward'),
      buildIconCard(Icons.first_page, 'first_page'),
      buildIconCard(Icons.last_page, 'last_page'),
      buildIconCard(Icons.swap_horiz, 'swap_horiz'),
      buildIconCard(Icons.swap_vert, 'swap_vert'),
      buildIconCard(Icons.unfold_more, 'unfold_more'),
      buildIconCard(Icons.unfold_less, 'unfold_less'),
      buildIconCard(Icons.apps, 'apps'),
    ],
  );
}

// Helper: build an action icons gallery
Widget buildActionGallery() {
  print('Building action icons gallery');
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    children: [
      buildIconCard(Icons.search, 'search'),
      buildIconCard(Icons.settings, 'settings'),
      buildIconCard(Icons.delete, 'delete'),
      buildIconCard(Icons.share, 'share'),
      buildIconCard(Icons.favorite, 'favorite'),
      buildIconCard(Icons.favorite_border, 'favorite_border'),
      buildIconCard(Icons.bookmark, 'bookmark'),
      buildIconCard(Icons.bookmark_border, 'bookmark_border'),
      buildIconCard(Icons.visibility, 'visibility'),
      buildIconCard(Icons.visibility_off, 'visibility_off'),
      buildIconCard(Icons.lock, 'lock'),
      buildIconCard(Icons.lock_open, 'lock_open'),
      buildIconCard(Icons.done, 'done'),
      buildIconCard(Icons.done_all, 'done_all'),
      buildIconCard(Icons.thumb_up, 'thumb_up'),
      buildIconCard(Icons.thumb_down, 'thumb_down'),
      buildIconCard(Icons.power_settings_new, 'power'),
      buildIconCard(Icons.build, 'build'),
      buildIconCard(Icons.bug_report, 'bug_report'),
      buildIconCard(Icons.code, 'code'),
      buildIconCard(Icons.info, 'info'),
      buildIconCard(Icons.help, 'help'),
      buildIconCard(Icons.language, 'language'),
      buildIconCard(Icons.open_in_new, 'open_in_new'),
      buildIconCard(Icons.alarm, 'alarm'),
      buildIconCard(Icons.history, 'history'),
      buildIconCard(Icons.zoom_in, 'zoom_in'),
      buildIconCard(Icons.zoom_out, 'zoom_out'),
    ],
  );
}

// Helper: build communication icons gallery
Widget buildCommunicationGallery() {
  print('Building communication icons gallery');
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    children: [
      buildIconCard(Icons.email, 'email'),
      buildIconCard(Icons.phone, 'phone'),
      buildIconCard(Icons.chat, 'chat'),
      buildIconCard(Icons.message, 'message'),
      buildIconCard(Icons.forum, 'forum'),
      buildIconCard(Icons.call, 'call'),
      buildIconCard(Icons.call_end, 'call_end'),
      buildIconCard(Icons.contacts, 'contacts'),
      buildIconCard(Icons.mail, 'mail'),
      buildIconCard(Icons.send, 'send'),
      buildIconCard(Icons.chat_bubble, 'chat_bubble'),
      buildIconCard(Icons.voicemail, 'voicemail'),
      buildIconCard(Icons.comment, 'comment'),
      buildIconCard(Icons.notifications, 'notifications'),
      buildIconCard(Icons.notifications_off, 'notif_off'),
      buildIconCard(Icons.notifications_active, 'notif_active'),
      buildIconCard(Icons.sms, 'sms'),
      buildIconCard(Icons.alternate_email, 'alt_email'),
      buildIconCard(Icons.rss_feed, 'rss_feed'),
      buildIconCard(Icons.wifi, 'wifi'),
    ],
  );
}

// Helper: build content icons gallery
Widget buildContentGallery() {
  print('Building content icons gallery');
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    children: [
      buildIconCard(Icons.add, 'add'),
      buildIconCard(Icons.remove, 'remove'),
      buildIconCard(Icons.add_circle, 'add_circle'),
      buildIconCard(Icons.remove_circle, 'remove_circle'),
      buildIconCard(Icons.flag, 'flag'),
      buildIconCard(Icons.link, 'link'),
      buildIconCard(Icons.link_off, 'link_off'),
      buildIconCard(Icons.content_copy, 'copy'),
      buildIconCard(Icons.content_paste, 'paste'),
      buildIconCard(Icons.content_cut, 'cut'),
      buildIconCard(Icons.save, 'save'),
      buildIconCard(Icons.undo, 'undo'),
      buildIconCard(Icons.redo, 'redo'),
      buildIconCard(Icons.select_all, 'select_all'),
      buildIconCard(Icons.filter_list, 'filter_list'),
      buildIconCard(Icons.sort, 'sort'),
      buildIconCard(Icons.clear, 'clear'),
      buildIconCard(Icons.block, 'block'),
      buildIconCard(Icons.report, 'report'),
      buildIconCard(Icons.gesture, 'gesture'),
    ],
  );
}

// Helper: build file and folder icons gallery
Widget buildFileGallery() {
  print('Building file and folder icons gallery');
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    children: [
      buildIconCard(Icons.folder, 'folder'),
      buildIconCard(Icons.folder_open, 'folder_open'),
      buildIconCard(Icons.create_new_folder, 'new_folder'),
      buildIconCard(Icons.insert_drive_file, 'file'),
      buildIconCard(Icons.cloud, 'cloud'),
      buildIconCard(Icons.cloud_download, 'cloud_dl'),
      buildIconCard(Icons.cloud_upload, 'cloud_ul'),
      buildIconCard(Icons.cloud_off, 'cloud_off'),
      buildIconCard(Icons.attachment, 'attachment'),
      buildIconCard(Icons.file_download, 'download'),
      buildIconCard(Icons.file_upload, 'upload'),
      buildIconCard(Icons.storage, 'storage'),
      buildIconCard(Icons.sd_storage, 'sd_storage'),
      buildIconCard(Icons.archive, 'archive'),
      buildIconCard(Icons.unarchive, 'unarchive'),
      buildIconCard(Icons.description, 'description'),
      buildIconCard(Icons.note, 'note'),
      buildIconCard(Icons.note_add, 'note_add'),
      buildIconCard(Icons.snippet_folder, 'snippet'),
      buildIconCard(Icons.topic, 'topic'),
    ],
  );
}

// Helper: build social icons gallery
Widget buildSocialGallery() {
  print('Building social icons gallery');
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    children: [
      buildIconCard(Icons.person, 'person'),
      buildIconCard(Icons.person_add, 'person_add'),
      buildIconCard(Icons.person_remove, 'person_remove'),
      buildIconCard(Icons.group, 'group'),
      buildIconCard(Icons.group_add, 'group_add'),
      buildIconCard(Icons.public, 'public'),
      buildIconCard(Icons.people, 'people'),
      buildIconCard(Icons.share, 'share'),
      buildIconCard(Icons.thumb_up, 'thumb_up'),
      buildIconCard(Icons.thumb_down, 'thumb_down'),
      buildIconCard(Icons.mood, 'mood'),
      buildIconCard(Icons.mood_bad, 'mood_bad'),
      buildIconCard(Icons.cake, 'cake'),
      buildIconCard(Icons.school, 'school'),
      buildIconCard(Icons.work, 'work'),
      buildIconCard(Icons.location_city, 'city'),
      buildIconCard(Icons.emoji_events, 'events'),
      buildIconCard(Icons.military_tech, 'military'),
      buildIconCard(Icons.psychology, 'psychology'),
      buildIconCard(Icons.diversity_3, 'diversity'),
    ],
  );
}

// Helper: build size comparison section
Widget buildSizeComparison() {
  print('Building icon size comparison');
  List<double> sizes = [12, 18, 24, 36, 48, 72];
  List<String> sizeLabels = ['12px', '18px', '24px', '36px', '48px', '72px'];

  List<Widget> homeItems = [];
  List<Widget> starItems = [];
  List<Widget> settingsItems = [];
  int idx = 0;
  for (double s in sizes) {
    homeItems.add(buildSizedIconCard(Icons.home, s, sizeLabels[idx]));
    starItems.add(buildSizedIconCard(Icons.star, s, sizeLabels[idx]));
    settingsItems.add(buildSizedIconCard(Icons.settings, s, sizeLabels[idx]));
    idx = idx + 1;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSubHeader('home icon at different sizes'),
      Wrap(spacing: 4, runSpacing: 4, children: homeItems),
      SizedBox(height: 12),
      buildSubHeader('star icon at different sizes'),
      Wrap(spacing: 4, runSpacing: 4, children: starItems),
      SizedBox(height: 12),
      buildSubHeader('settings icon at different sizes'),
      Wrap(spacing: 4, runSpacing: 4, children: settingsItems),
    ],
  );
}

// Helper: build color variations section
Widget buildColorVariations() {
  print('Building icon color variations');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSubHeader('Icons with Material Colors'),
      Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          buildColoredIconCard(
            Icons.favorite,
            'Red',
            Color(0xFFFFEBEE),
            Color(0xFFE53935),
          ),
          buildColoredIconCard(
            Icons.star,
            'Amber',
            Color(0xFFFFF8E1),
            Color(0xFFFFB300),
          ),
          buildColoredIconCard(
            Icons.eco,
            'Green',
            Color(0xFFE8F5E9),
            Color(0xFF43A047),
          ),
          buildColoredIconCard(
            Icons.water_drop,
            'Blue',
            Color(0xFFE3F2FD),
            Color(0xFF1E88E5),
          ),
          buildColoredIconCard(
            Icons.palette,
            'Purple',
            Color(0xFFF3E5F5),
            Color(0xFF8E24AA),
          ),
          buildColoredIconCard(
            Icons.bolt,
            'Orange',
            Color(0xFFFFF3E0),
            Color(0xFFF57C00),
          ),
          buildColoredIconCard(
            Icons.ac_unit,
            'Cyan',
            Color(0xFFE0F7FA),
            Color(0xFF00ACC1),
          ),
          buildColoredIconCard(
            Icons.local_fire_department,
            'Deep Or',
            Color(0xFFFBE9E7),
            Color(0xFFE64A19),
          ),
        ],
      ),
      SizedBox(height: 16),
      buildSubHeader('Icons with Custom Colors'),
      Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          buildColoredIconCard(
            Icons.diamond,
            'Diamond',
            Color(0xFF263238),
            Color(0xFF80DEEA),
          ),
          buildColoredIconCard(
            Icons.light_mode,
            'Sun',
            Color(0xFF1A237E),
            Color(0xFFFFD54F),
          ),
          buildColoredIconCard(
            Icons.dark_mode,
            'Moon',
            Color(0xFF0D47A1),
            Color(0xFFB0BEC5),
          ),
          buildColoredIconCard(
            Icons.forest,
            'Forest',
            Color(0xFF1B5E20),
            Color(0xFFA5D6A7),
          ),
          buildColoredIconCard(
            Icons.rocket_launch,
            'Rocket',
            Color(0xFF311B92),
            Color(0xFFFF8A65),
          ),
          buildColoredIconCard(
            Icons.auto_awesome,
            'Sparkle',
            Color(0xFF4A148C),
            Color(0xFFFFEB3B),
          ),
          buildColoredIconCard(
            Icons.nightlight,
            'Night',
            Color(0xFF0D47A1),
            Color(0xFFE1F5FE),
          ),
          buildColoredIconCard(
            Icons.sunny,
            'Sunny',
            Color(0xFFF57F17),
            Color(0xFFFFFFFF),
          ),
        ],
      ),
      SizedBox(height: 16),
      buildSubHeader('Monochrome Shading'),
      Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          buildColoredIconCard(
            Icons.circle,
            '100%',
            Color(0xFFFFFFFF),
            Color(0xFF000000),
          ),
          buildColoredIconCard(
            Icons.circle,
            '87%',
            Color(0xFFFFFFFF),
            Color(0xDD000000),
          ),
          buildColoredIconCard(
            Icons.circle,
            '60%',
            Color(0xFFFFFFFF),
            Color(0x99000000),
          ),
          buildColoredIconCard(
            Icons.circle,
            '38%',
            Color(0xFFFFFFFF),
            Color(0x61000000),
          ),
          buildColoredIconCard(
            Icons.circle,
            '12%',
            Color(0xFFFFFFFF),
            Color(0x1F000000),
          ),
        ],
      ),
    ],
  );
}

// Helper: build icons in context section
Widget buildIconsInContext() {
  print('Building icons in context');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildContextRow(
        'Icons in ElevatedButtons',
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton.icon(
              onPressed: null,
              icon: Icon(Icons.save),
              label: Text('Save'),
            ),
            ElevatedButton.icon(
              onPressed: null,
              icon: Icon(Icons.send),
              label: Text('Send'),
            ),
            ElevatedButton.icon(
              onPressed: null,
              icon: Icon(Icons.download),
              label: Text('Download'),
            ),
          ],
        ),
      ),
      buildContextRow(
        'Icons in TextButtons',
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.edit),
              label: Text('Edit'),
            ),
            TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.delete),
              label: Text('Delete'),
            ),
            TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.refresh),
              label: Text('Refresh'),
            ),
          ],
        ),
      ),
      buildContextRow(
        'Icons in OutlinedButtons',
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: null,
              icon: Icon(Icons.filter_list),
              label: Text('Filter'),
            ),
            OutlinedButton.icon(
              onPressed: null,
              icon: Icon(Icons.sort),
              label: Text('Sort'),
            ),
            OutlinedButton.icon(
              onPressed: null,
              icon: Icon(Icons.tune),
              label: Text('Options'),
            ),
          ],
        ),
      ),
      buildContextRow(
        'Icons in IconButtons',
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            IconButton(onPressed: null, icon: Icon(Icons.play_arrow)),
            IconButton(onPressed: null, icon: Icon(Icons.pause)),
            IconButton(onPressed: null, icon: Icon(Icons.stop)),
            IconButton(onPressed: null, icon: Icon(Icons.skip_previous)),
            IconButton(onPressed: null, icon: Icon(Icons.skip_next)),
            IconButton(onPressed: null, icon: Icon(Icons.replay)),
            IconButton(onPressed: null, icon: Icon(Icons.shuffle)),
            IconButton(onPressed: null, icon: Icon(Icons.repeat)),
          ],
        ),
      ),
      buildContextRow(
        'Icons in Chips',
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(avatar: Icon(Icons.face, size: 18), label: Text('Profile')),
            Chip(
              avatar: Icon(Icons.location_on, size: 18),
              label: Text('Location'),
            ),
            Chip(
              avatar: Icon(Icons.access_time, size: 18),
              label: Text('Schedule'),
            ),
            Chip(avatar: Icon(Icons.label, size: 18), label: Text('Tagged')),
          ],
        ),
      ),
      buildContextRow(
        'Icons in ListTiles',
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.inbox, color: Color(0xFF1976D2)),
              title: Text('Inbox'),
              subtitle: Text('3 new messages'),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.drafts, color: Color(0xFF388E3C)),
              title: Text('Drafts'),
              subtitle: Text('2 items'),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.send, color: Color(0xFFF57C00)),
              title: Text('Sent'),
              subtitle: Text('12 messages'),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.delete, color: Color(0xFFD32F2F)),
              title: Text('Trash'),
              subtitle: Text('Empty'),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    ],
  );
}

// Helper: build categorized icon reference grid
Widget buildCategorizedReference() {
  print('Building categorized icon reference');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildCategoryTile('Media Controls', [
        buildMiniIconChip(Icons.play_arrow, 'play'),
        buildMiniIconChip(Icons.pause, 'pause'),
        buildMiniIconChip(Icons.stop, 'stop'),
        buildMiniIconChip(Icons.fast_forward, 'ff'),
        buildMiniIconChip(Icons.fast_rewind, 'rewind'),
        buildMiniIconChip(Icons.volume_up, 'vol_up'),
        buildMiniIconChip(Icons.volume_down, 'vol_dn'),
        buildMiniIconChip(Icons.volume_off, 'vol_off'),
        buildMiniIconChip(Icons.mic, 'mic'),
        buildMiniIconChip(Icons.mic_off, 'mic_off'),
        buildMiniIconChip(Icons.music_note, 'music'),
        buildMiniIconChip(Icons.movie, 'movie'),
      ]),
      buildCategoryTile('Device & Hardware', [
        buildMiniIconChip(Icons.phone_android, 'android'),
        buildMiniIconChip(Icons.phone_iphone, 'iphone'),
        buildMiniIconChip(Icons.computer, 'computer'),
        buildMiniIconChip(Icons.tablet, 'tablet'),
        buildMiniIconChip(Icons.watch, 'watch'),
        buildMiniIconChip(Icons.tv, 'tv'),
        buildMiniIconChip(Icons.keyboard, 'keyboard'),
        buildMiniIconChip(Icons.mouse, 'mouse'),
        buildMiniIconChip(Icons.headset, 'headset'),
        buildMiniIconChip(Icons.speaker, 'speaker'),
        buildMiniIconChip(Icons.memory, 'memory'),
        buildMiniIconChip(Icons.battery_full, 'battery'),
      ]),
      buildCategoryTile('Maps & Places', [
        buildMiniIconChip(Icons.place, 'place'),
        buildMiniIconChip(Icons.map, 'map'),
        buildMiniIconChip(Icons.directions, 'directions'),
        buildMiniIconChip(Icons.navigation, 'navigate'),
        buildMiniIconChip(Icons.local_parking, 'parking'),
        buildMiniIconChip(Icons.local_hospital, 'hospital'),
        buildMiniIconChip(Icons.restaurant, 'food'),
        buildMiniIconChip(Icons.hotel, 'hotel'),
        buildMiniIconChip(Icons.local_gas_station, 'gas'),
        buildMiniIconChip(Icons.flight, 'flight'),
        buildMiniIconChip(Icons.train, 'train'),
        buildMiniIconChip(Icons.directions_car, 'car'),
      ]),
      buildCategoryTile('Editor & Text', [
        buildMiniIconChip(Icons.edit, 'edit'),
        buildMiniIconChip(Icons.format_bold, 'bold'),
        buildMiniIconChip(Icons.format_italic, 'italic'),
        buildMiniIconChip(Icons.format_underlined, 'underline'),
        buildMiniIconChip(Icons.format_list_bulleted, 'bullets'),
        buildMiniIconChip(Icons.format_list_numbered, 'numbers'),
        buildMiniIconChip(Icons.format_align_left, 'left'),
        buildMiniIconChip(Icons.format_align_center, 'center'),
        buildMiniIconChip(Icons.format_align_right, 'right'),
        buildMiniIconChip(Icons.text_fields, 'text'),
        buildMiniIconChip(Icons.title, 'title'),
        buildMiniIconChip(Icons.format_quote, 'quote'),
      ]),
      buildCategoryTile('Image & Photo', [
        buildMiniIconChip(Icons.image, 'image'),
        buildMiniIconChip(Icons.photo, 'photo'),
        buildMiniIconChip(Icons.camera_alt, 'camera'),
        buildMiniIconChip(Icons.photo_library, 'library'),
        buildMiniIconChip(Icons.crop, 'crop'),
        buildMiniIconChip(Icons.rotate_left, 'rot_left'),
        buildMiniIconChip(Icons.rotate_right, 'rot_right'),
        buildMiniIconChip(Icons.flip, 'flip'),
        buildMiniIconChip(Icons.brightness_6, 'bright'),
        buildMiniIconChip(Icons.contrast, 'contrast'),
        buildMiniIconChip(Icons.filter, 'filter'),
        buildMiniIconChip(Icons.panorama, 'panorama'),
      ]),
      buildCategoryTile('Alert & Status', [
        buildMiniIconChip(Icons.warning, 'warning'),
        buildMiniIconChip(Icons.error, 'error'),
        buildMiniIconChip(Icons.info, 'info'),
        buildMiniIconChip(Icons.check_circle, 'check'),
        buildMiniIconChip(Icons.cancel, 'cancel'),
        buildMiniIconChip(Icons.help, 'help'),
        buildMiniIconChip(Icons.priority_high, 'priority'),
        buildMiniIconChip(Icons.new_releases, 'new'),
        buildMiniIconChip(Icons.verified, 'verified'),
        buildMiniIconChip(Icons.pending, 'pending'),
        buildMiniIconChip(Icons.schedule, 'schedule'),
        buildMiniIconChip(Icons.update, 'update'),
      ]),
    ],
  );
}

// Helper: print debug info about icons
void printIconDebugInfo() {
  print('=== Icons Debug Information ===');
  print('Icons class provides static IconData instances');
  print('Each icon is accessed via Icons.<name>');

  int homeCode = Icons.home.codePoint;
  print('Icons.home codePoint: $homeCode');

  String? homeFontFamily = Icons.home.fontFamily;
  print('Icons.home fontFamily: $homeFontFamily');

  bool homeMatchDirection = Icons.home.matchTextDirection;
  print('Icons.home matchTextDirection: $homeMatchDirection');

  int starCode = Icons.star.codePoint;
  print('Icons.star codePoint: $starCode');

  int searchCode = Icons.search.codePoint;
  print('Icons.search codePoint: $searchCode');

  int settingsCode = Icons.settings.codePoint;
  print('Icons.settings codePoint: $settingsCode');

  int deleteCode = Icons.delete.codePoint;
  print('Icons.delete codePoint: $deleteCode');

  int favoriteCode = Icons.favorite.codePoint;
  print('Icons.favorite codePoint: $favoriteCode');

  int emailCode = Icons.email.codePoint;
  print('Icons.email codePoint: $emailCode');

  int phoneCode = Icons.phone.codePoint;
  print('Icons.phone codePoint: $phoneCode');

  int personCode = Icons.person.codePoint;
  print('Icons.person codePoint: $personCode');

  int folderCode = Icons.folder.codePoint;
  print('Icons.folder codePoint: $folderCode');

  int arrowBackCode = Icons.arrow_back.codePoint;
  print('Icons.arrow_back codePoint: $arrowBackCode');

  bool arrowBackMatch = Icons.arrow_back.matchTextDirection;
  print('Icons.arrow_back matchTextDirection: $arrowBackMatch');

  int addCode = Icons.add.codePoint;
  print('Icons.add codePoint: $addCode');

  int checkCode = Icons.check.codePoint;
  print('Icons.check codePoint: $checkCode');

  int closeCode = Icons.close.codePoint;
  print('Icons.close codePoint: $closeCode');

  String? fontPkg = Icons.home.fontPackage;
  print('Icons.home fontPackage: $fontPkg');

  print('=== End Icons Debug Info ===');
}

dynamic build(BuildContext context) {
  print('=== Icons Deep Demo ===');
  print('Testing Icons class from package:flutter/material.dart');
  print('Icons provides static IconData for all Material Design icons');

  printIconDebugInfo();

  print('Building Icons visual demo...');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFECEFF1),
      appBar: AppBar(
        title: Text('Icons Deep Demo'),
        backgroundColor: Color(0xFF1565C0),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview info
            buildInfoCard('Class:', 'Icons'),
            buildInfoCard('Package:', 'package:flutter/material.dart'),
            buildInfoCard('Type:', 'Static IconData instances'),
            buildInfoCard('Usage:', 'Icons.<name> returns IconData'),
            buildInfoCard('Font:', 'MaterialIcons font family'),
            buildInfoCard('Size:', 'Default 24.0 logical pixels'),

            // 1. Navigation Icons
            buildSectionHeader('1. Navigation Icons'),
            buildNavigationGallery(),

            // 2. Action Icons
            buildSectionHeader('2. Action Icons'),
            buildActionGallery(),

            // 3. Communication Icons
            buildSectionHeader('3. Communication Icons'),
            buildCommunicationGallery(),

            // 4. Content Icons
            buildSectionHeader('4. Content Icons'),
            buildContentGallery(),

            // 5. File & Folder Icons
            buildSectionHeader('5. File & Folder Icons'),
            buildFileGallery(),

            // 6. Social Icons
            buildSectionHeader('6. Social Icons'),
            buildSocialGallery(),

            // 7. Icon Size Comparison
            buildSectionHeader('7. Icon Sizes (12, 18, 24, 36, 48, 72)'),
            buildSizeComparison(),

            // 8. Icon Color Variations
            buildSectionHeader('8. Icon Colors'),
            buildColorVariations(),

            // 9. Icons in Context
            buildSectionHeader('9. Icons in Various Contexts'),
            buildIconsInContext(),

            // 10. Categorized Reference Grid
            buildSectionHeader('10. Categorized Icon Reference'),
            buildCategorizedReference(),

            // 11. Icon Pairings & Toggles
            buildSectionHeader('11. Icon Pairings & Toggles'),
            buildSubHeader('Toggle States'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                buildIconCard(
                  Icons.visibility,
                  'visible',
                  iconColor: Color(0xFF1976D2),
                ),
                buildIconCard(
                  Icons.visibility_off,
                  'hidden',
                  iconColor: Color(0xFF9E9E9E),
                ),
                buildIconCard(
                  Icons.lock,
                  'locked',
                  iconColor: Color(0xFFD32F2F),
                ),
                buildIconCard(
                  Icons.lock_open,
                  'unlocked',
                  iconColor: Color(0xFF388E3C),
                ),
                buildIconCard(
                  Icons.volume_up,
                  'sound on',
                  iconColor: Color(0xFF1976D2),
                ),
                buildIconCard(
                  Icons.volume_off,
                  'muted',
                  iconColor: Color(0xFF9E9E9E),
                ),
                buildIconCard(
                  Icons.star,
                  'starred',
                  iconColor: Color(0xFFFFC107),
                ),
                buildIconCard(
                  Icons.star_border,
                  'unstarred',
                  iconColor: Color(0xFF9E9E9E),
                ),
                buildIconCard(
                  Icons.toggle_on,
                  'on',
                  iconColor: Color(0xFF43A047),
                ),
                buildIconCard(
                  Icons.toggle_off,
                  'off',
                  iconColor: Color(0xFFBDBDBD),
                ),
                buildIconCard(
                  Icons.check_box,
                  'checked',
                  iconColor: Color(0xFF1976D2),
                ),
                buildIconCard(
                  Icons.check_box_outline_blank,
                  'unchecked',
                  iconColor: Color(0xFF757575),
                ),
                buildIconCard(
                  Icons.radio_button_checked,
                  'selected',
                  iconColor: Color(0xFF1976D2),
                ),
                buildIconCard(
                  Icons.radio_button_unchecked,
                  'deselected',
                  iconColor: Color(0xFF757575),
                ),
                buildIconCard(
                  Icons.expand_more,
                  'expand',
                  iconColor: Color(0xFF455A64),
                ),
                buildIconCard(
                  Icons.expand_less,
                  'collapse',
                  iconColor: Color(0xFF455A64),
                ),
              ],
            ),

            // 12. Weather & Nature Icons
            buildSectionHeader('12. Weather & Nature Icons'),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                buildIconCard(
                  Icons.wb_sunny,
                  'sunny',
                  iconColor: Color(0xFFFFA000),
                ),
                buildIconCard(
                  Icons.cloud,
                  'cloudy',
                  iconColor: Color(0xFF78909C),
                ),
                buildIconCard(
                  Icons.water_drop,
                  'rain',
                  iconColor: Color(0xFF42A5F5),
                ),
                buildIconCard(
                  Icons.ac_unit,
                  'snow',
                  iconColor: Color(0xFF90CAF9),
                ),
                buildIconCard(
                  Icons.bolt,
                  'thunder',
                  iconColor: Color(0xFFFFC107),
                ),
                buildIconCard(Icons.air, 'wind', iconColor: Color(0xFF80CBC4)),
                buildIconCard(
                  Icons.thermostat,
                  'temp',
                  iconColor: Color(0xFFEF5350),
                ),
                buildIconCard(
                  Icons.waves,
                  'waves',
                  iconColor: Color(0xFF29B6F6),
                ),
                buildIconCard(Icons.park, 'park', iconColor: Color(0xFF66BB6A)),
                buildIconCard(
                  Icons.forest,
                  'forest',
                  iconColor: Color(0xFF2E7D32),
                ),
                buildIconCard(
                  Icons.grass,
                  'grass',
                  iconColor: Color(0xFF4CAF50),
                ),
                buildIconCard(Icons.eco, 'eco', iconColor: Color(0xFF43A047)),
                buildIconCard(Icons.pets, 'pets', iconColor: Color(0xFF8D6E63)),
                buildIconCard(
                  Icons.terrain,
                  'terrain',
                  iconColor: Color(0xFF795548),
                ),
                buildIconCard(
                  Icons.landscape,
                  'landscape',
                  iconColor: Color(0xFF558B2F),
                ),
                buildIconCard(
                  Icons.nightlight,
                  'night',
                  iconColor: Color(0xFF5C6BC0),
                ),
              ],
            ),

            // 13. Properties Summary
            buildSectionHeader('13. Icon Properties Summary'),
            buildInfoCard('Default size:', '24.0 logical pixels'),
            buildInfoCard('Font family:', 'MaterialIcons'),
            buildInfoCard('Semantic label:', 'Optional accessibility label'),
            buildInfoCard('Text direction:', 'Some icons are direction-aware'),
            buildInfoCard('Color:', 'Inherits from IconTheme or explicit'),
            buildInfoCard(
              'Opacity:',
              'Controlled via color alpha or Opacity widget',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
