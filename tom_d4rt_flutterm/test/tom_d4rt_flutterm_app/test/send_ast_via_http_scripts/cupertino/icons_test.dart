// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoIcons from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino icons test executing');

  // ========== CUPERTINOICONS ==========
  print('--- CupertinoIcons Tests ---');

  // Test common action icons
  print('Action icons:');
  final addIcon = Icon(CupertinoIcons.add);
  final addCircleIcon = Icon(CupertinoIcons.add_circled);
  final addCircleFillIcon = Icon(CupertinoIcons.add_circled_solid);
  final minusIcon = Icon(CupertinoIcons.minus);
  final minusCircleIcon = Icon(CupertinoIcons.minus_circled);
  final clearIcon = Icon(CupertinoIcons.clear);
  final clearCircleIcon = Icon(CupertinoIcons.clear_circled);
  final clearCircleFillIcon = Icon(CupertinoIcons.clear_circled_solid);
  print('Action icons created [${clearCircleFillIcon.hashCode }] [${clearCircleIcon.hashCode }] [${clearIcon.hashCode }] [${minusCircleIcon.hashCode }] [${minusIcon.hashCode }] [${addCircleFillIcon.hashCode }] [${addCircleIcon.hashCode }] [${addIcon.hashCode }]');

  // Test navigation icons
  print('Navigation icons:');
  final backIcon = Icon(CupertinoIcons.back);
  final forwardIcon = Icon(CupertinoIcons.forward);
  final chevronLeftIcon = Icon(CupertinoIcons.chevron_left);
  final chevronRightIcon = Icon(CupertinoIcons.chevron_right);
  final chevronUpIcon = Icon(CupertinoIcons.chevron_up);
  final chevronDownIcon = Icon(CupertinoIcons.chevron_down);
  final arrowLeftIcon = Icon(CupertinoIcons.arrow_left);
  final arrowRightIcon = Icon(CupertinoIcons.arrow_right);
  final arrowUpIcon = Icon(CupertinoIcons.arrow_up);
  final arrowDownIcon = Icon(CupertinoIcons.arrow_down);
  print('Navigation icons created [${arrowDownIcon.hashCode }] [${arrowUpIcon.hashCode }] [${arrowRightIcon.hashCode }] [${arrowLeftIcon.hashCode }] [${chevronDownIcon.hashCode }] [${chevronUpIcon.hashCode }] [${chevronRightIcon.hashCode }] [${chevronLeftIcon.hashCode }] [${forwardIcon.hashCode }] [${backIcon.hashCode }]');

  // Test common UI icons
  print('Common UI icons:');
  final homeIcon = Icon(CupertinoIcons.home);
  final settingsIcon = Icon(CupertinoIcons.settings);
  final gearIcon = Icon(CupertinoIcons.gear);
  final searchIcon = Icon(CupertinoIcons.search);
  final shareIcon = Icon(CupertinoIcons.share);
  final infoIcon = Icon(CupertinoIcons.info);
  final questionIcon = Icon(CupertinoIcons.question);
  final exclamationIcon = Icon(CupertinoIcons.exclamationmark);
  print('Common UI icons created [${exclamationIcon.hashCode }] [${questionIcon.hashCode }] [${infoIcon.hashCode }] [${shareIcon.hashCode }] [${searchIcon.hashCode }] [${gearIcon.hashCode }] [${settingsIcon.hashCode }] [${homeIcon.hashCode }]');

  // Test communication icons
  print('Communication icons:');
  final mailIcon = Icon(CupertinoIcons.mail);
  final mailFillIcon = Icon(CupertinoIcons.mail_solid);
  final phoneIcon = Icon(CupertinoIcons.phone);
  final phoneFillIcon = Icon(CupertinoIcons.phone_solid);
  final chatIcon = Icon(CupertinoIcons.chat_bubble);
  final chatFillIcon = Icon(CupertinoIcons.chat_bubble_fill);
  final chat2Icon = Icon(CupertinoIcons.chat_bubble_2);
  final chat2FillIcon = Icon(CupertinoIcons.chat_bubble_2_fill);
  print('Communication icons created [${chat2FillIcon.hashCode }] [${chat2Icon.hashCode }] [${chatFillIcon.hashCode }] [${chatIcon.hashCode }] [${phoneFillIcon.hashCode }] [${phoneIcon.hashCode }] [${mailFillIcon.hashCode }] [${mailIcon.hashCode }]');

  // Test media icons
  print('Media icons:');
  final playIcon = Icon(CupertinoIcons.play);
  final playFillIcon = Icon(CupertinoIcons.play_fill);
  final pauseIcon = Icon(CupertinoIcons.pause);
  final pauseFillIcon = Icon(CupertinoIcons.pause_fill);
  final stopIcon = Icon(CupertinoIcons.stop);
  final stopFillIcon = Icon(CupertinoIcons.stop_fill);
  final rewindIcon = Icon(CupertinoIcons.backward);
  final fastforwardIcon = Icon(CupertinoIcons.forward_fill);
  final volumeUpIcon = Icon(CupertinoIcons.volume_up);
  final volumeDownIcon = Icon(CupertinoIcons.volume_down);
  final volumeMuteIcon = Icon(CupertinoIcons.volume_mute);
  final volumeOffIcon = Icon(CupertinoIcons.volume_off);
  print('Media icons created [${volumeOffIcon.hashCode }] [${volumeMuteIcon.hashCode }] [${volumeDownIcon.hashCode }] [${volumeUpIcon.hashCode }] [${fastforwardIcon.hashCode }] [${rewindIcon.hashCode }] [${stopFillIcon.hashCode }] [${stopIcon.hashCode }] [${pauseFillIcon.hashCode }] [${pauseIcon.hashCode }] [${playFillIcon.hashCode }] [${playIcon.hashCode }]');

  // Test editing icons
  print('Editing icons:');
  final pencilIcon = Icon(CupertinoIcons.pencil);
  final trashIcon = Icon(CupertinoIcons.trash);
  final trashFillIcon = Icon(CupertinoIcons.trash_fill);
  final docIcon = Icon(CupertinoIcons.doc);
  final docFillIcon = Icon(CupertinoIcons.doc_fill);
  final docTextIcon = Icon(CupertinoIcons.doc_text);
  final docTextFillIcon = Icon(CupertinoIcons.doc_text_fill);
  final folderIcon = Icon(CupertinoIcons.folder);
  final folderFillIcon = Icon(CupertinoIcons.folder_fill);
  final copyIcon = Icon(CupertinoIcons.doc_on_doc);
  final pasteIcon = Icon(CupertinoIcons.doc_on_clipboard);
  print('Editing icons created [${pasteIcon.hashCode }] [${copyIcon.hashCode }] [${folderFillIcon.hashCode }] [${folderIcon.hashCode }] [${docTextFillIcon.hashCode }] [${docTextIcon.hashCode }] [${docFillIcon.hashCode }] [${docIcon.hashCode }] [${trashFillIcon.hashCode }] [${trashIcon.hashCode }] [${pencilIcon.hashCode }]');

  // Test personal icons
  print('Personal icons:');
  final personIcon = Icon(CupertinoIcons.person);
  final personFillIcon = Icon(CupertinoIcons.person_fill);
  final personCircleIcon = Icon(CupertinoIcons.person_circle);
  final personCircleFillIcon = Icon(CupertinoIcons.person_circle_fill);
  final person2Icon = Icon(CupertinoIcons.person_2);
  final person2FillIcon = Icon(CupertinoIcons.person_2_fill);
  final person3Icon = Icon(CupertinoIcons.person_3);
  final person3FillIcon = Icon(CupertinoIcons.person_3_fill);
  print('Personal icons created [${person3FillIcon.hashCode }] [${person3Icon.hashCode }] [${person2FillIcon.hashCode }] [${person2Icon.hashCode }] [${personCircleFillIcon.hashCode }] [${personCircleIcon.hashCode }] [${personFillIcon.hashCode }] [${personIcon.hashCode }]');

  // Test weather/time icons
  print('Weather/time icons:');
  final sunIcon = Icon(CupertinoIcons.sun_max);
  final sunFillIcon = Icon(CupertinoIcons.sun_max_fill);
  final moonIcon = Icon(CupertinoIcons.moon);
  final moonFillIcon = Icon(CupertinoIcons.moon_fill);
  final cloudIcon = Icon(CupertinoIcons.cloud);
  final cloudFillIcon = Icon(CupertinoIcons.cloud_fill);
  final clockIcon = Icon(CupertinoIcons.clock);
  final clockFillIcon = Icon(CupertinoIcons.clock_fill);
  final timerIcon = Icon(CupertinoIcons.timer);
  final calendarIcon = Icon(CupertinoIcons.calendar);
  print('Weather/time icons created [${calendarIcon.hashCode }] [${timerIcon.hashCode }] [${clockFillIcon.hashCode }] [${clockIcon.hashCode }] [${cloudFillIcon.hashCode }] [${cloudIcon.hashCode }] [${moonFillIcon.hashCode }] [${moonIcon.hashCode }] [${sunFillIcon.hashCode }] [${sunIcon.hashCode }]');

  // Test status icons
  print('Status icons:');
  final checkmarkIcon = Icon(CupertinoIcons.checkmark);
  final checkmarkCircleIcon = Icon(CupertinoIcons.checkmark_circle);
  final checkmarkCircleFillIcon = Icon(CupertinoIcons.checkmark_circle_fill);
  final xmarkIcon = Icon(CupertinoIcons.xmark);
  final xmarkCircleIcon = Icon(CupertinoIcons.xmark_circle);
  final xmarkCircleFillIcon = Icon(CupertinoIcons.xmark_circle_fill);
  final bellIcon = Icon(CupertinoIcons.bell);
  final bellFillIcon = Icon(CupertinoIcons.bell_fill);
  final bellSlashIcon = Icon(CupertinoIcons.bell_slash);
  final bellSlashFillIcon = Icon(CupertinoIcons.bell_slash_fill);
  print('Status icons created [${bellSlashFillIcon.hashCode }] [${bellSlashIcon.hashCode }] [${bellFillIcon.hashCode }] [${bellIcon.hashCode }] [${xmarkCircleFillIcon.hashCode }] [${xmarkCircleIcon.hashCode }] [${xmarkIcon.hashCode }] [${checkmarkCircleFillIcon.hashCode }] [${checkmarkCircleIcon.hashCode }] [${checkmarkIcon.hashCode }]');

  // Test favorite icons
  print('Favorite icons:');
  final heartIcon = Icon(CupertinoIcons.heart);
  final heartFillIcon = Icon(CupertinoIcons.heart_fill);
  final starIcon = Icon(CupertinoIcons.star);
  final starFillIcon = Icon(CupertinoIcons.star_fill);
  final bookmarkIcon = Icon(CupertinoIcons.bookmark);
  final bookmarkFillIcon = Icon(CupertinoIcons.bookmark_fill);
  final flagIcon = Icon(CupertinoIcons.flag);
  final flagFillIcon = Icon(CupertinoIcons.flag_fill);
  print('Favorite icons created [${flagFillIcon.hashCode }] [${flagIcon.hashCode }] [${bookmarkFillIcon.hashCode }] [${bookmarkIcon.hashCode }] [${starFillIcon.hashCode }] [${starIcon.hashCode }] [${heartFillIcon.hashCode }] [${heartIcon.hashCode }]');

  // Test device icons
  print('Device icons:');
  final devicePhoneIcon = Icon(CupertinoIcons.device_phone_portrait);
  final deviceTabletIcon = Icon(CupertinoIcons.device_laptop);
  final deviceDesktopIcon = Icon(CupertinoIcons.desktopcomputer);
  final wifiIcon = Icon(CupertinoIcons.wifi);
  final bluetoothIcon = Icon(CupertinoIcons.bluetooth);
  final batteryFullIcon = Icon(CupertinoIcons.battery_full);
  final batteryEmptyIcon = Icon(CupertinoIcons.battery_empty);
  final battery25Icon = Icon(CupertinoIcons.battery_25);
  print('Device icons created [${battery25Icon.hashCode }] [${batteryEmptyIcon.hashCode }] [${batteryFullIcon.hashCode }] [${bluetoothIcon.hashCode }] [${wifiIcon.hashCode }] [${deviceDesktopIcon.hashCode }] [${deviceTabletIcon.hashCode }] [${devicePhoneIcon.hashCode }]');

  // Test misc icons
  print('Misc icons:');
  final locationIcon = Icon(CupertinoIcons.location);
  final locationFillIcon = Icon(CupertinoIcons.location_fill);
  final mapIcon = Icon(CupertinoIcons.map);
  final mapFillIcon = Icon(CupertinoIcons.map_fill);
  final cameraIcon = Icon(CupertinoIcons.camera);
  final cameraFillIcon = Icon(CupertinoIcons.camera_fill);
  final photoIcon = Icon(CupertinoIcons.photo);
  final photoFillIcon = Icon(CupertinoIcons.photo_fill);
  final qrcodeIcon = Icon(CupertinoIcons.qrcode);
  final barcodeIcon = Icon(CupertinoIcons.barcode);
  print('Misc icons created [${barcodeIcon.hashCode }] [${qrcodeIcon.hashCode }] [${photoFillIcon.hashCode }] [${photoIcon.hashCode }] [${cameraFillIcon.hashCode }] [${cameraIcon.hashCode }] [${mapFillIcon.hashCode }] [${mapIcon.hashCode }] [${locationFillIcon.hashCode }] [${locationIcon.hashCode }]');

  // Test text formatting icons
  print('Text formatting icons:');
  final boldIcon = Icon(CupertinoIcons.bold);
  final italicIcon = Icon(CupertinoIcons.italic);
  final underlineIcon = Icon(CupertinoIcons.underline);
  final strikethroughIcon = Icon(CupertinoIcons.strikethrough);
  final textLeftIcon = Icon(CupertinoIcons.text_alignleft);
  final textCenterIcon = Icon(CupertinoIcons.text_aligncenter);
  final textRightIcon = Icon(CupertinoIcons.text_alignright);
  final textJustifyIcon = Icon(CupertinoIcons.text_justify);
  final listBulletIcon = Icon(CupertinoIcons.list_bullet);
  final listNumberIcon = Icon(CupertinoIcons.list_number);
  print('Text formatting icons created [${listNumberIcon.hashCode }] [${listBulletIcon.hashCode }] [${textJustifyIcon.hashCode }] [${textRightIcon.hashCode }] [${textCenterIcon.hashCode }] [${textLeftIcon.hashCode }] [${strikethroughIcon.hashCode }] [${underlineIcon.hashCode }] [${italicIcon.hashCode }] [${boldIcon.hashCode }]');

  // Test transport icons
  print('Transport icons:');
  final carIcon = Icon(CupertinoIcons.car);
  final carFillIcon = Icon(CupertinoIcons.car_fill);
  final airplaneIcon = Icon(CupertinoIcons.airplane);
  final busIcon = Icon(CupertinoIcons.bus);
  final tramIcon = Icon(CupertinoIcons.tram_fill);
  print('Transport icons created [${tramIcon.hashCode }] [${busIcon.hashCode }] [${airplaneIcon.hashCode }] [${carFillIcon.hashCode }] [${carIcon.hashCode }]');

  // Test commerce icons
  print('Commerce icons:');
  final cartIcon = Icon(CupertinoIcons.cart);
  final cartFillIcon = Icon(CupertinoIcons.cart_fill);
  final bagIcon = Icon(CupertinoIcons.bag);
  final bagFillIcon = Icon(CupertinoIcons.bag_fill);
  final creditcardIcon = Icon(CupertinoIcons.creditcard);
  final creditcardFillIcon = Icon(CupertinoIcons.creditcard_fill);
  final tagIcon = Icon(CupertinoIcons.tag);
  final tagFillIcon = Icon(CupertinoIcons.tag_fill);
  print('Commerce icons created [${tagFillIcon.hashCode }] [${tagIcon.hashCode }] [${creditcardFillIcon.hashCode }] [${creditcardIcon.hashCode }] [${bagFillIcon.hashCode }] [${bagIcon.hashCode }] [${cartFillIcon.hashCode }] [${cartIcon.hashCode }]');

  print('Cupertino icons test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('CupertinoIcons')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action icons
              _buildIconSection('Actions', [
                _iconItem(CupertinoIcons.add, 'add'),
                _iconItem(CupertinoIcons.add_circled, 'add_circled'),
                _iconItem(CupertinoIcons.minus, 'minus'),
                _iconItem(CupertinoIcons.minus_circled, 'minus_circled'),
                _iconItem(CupertinoIcons.clear, 'clear'),
                _iconItem(CupertinoIcons.clear_circled, 'clear_circled'),
              ]),

              // Navigation icons
              _buildIconSection('Navigation', [
                _iconItem(CupertinoIcons.back, 'back'),
                _iconItem(CupertinoIcons.forward, 'forward'),
                _iconItem(CupertinoIcons.chevron_left, 'chevron_left'),
                _iconItem(CupertinoIcons.chevron_right, 'chevron_right'),
                _iconItem(CupertinoIcons.chevron_up, 'chevron_up'),
                _iconItem(CupertinoIcons.chevron_down, 'chevron_down'),
              ]),

              // Common UI icons
              _buildIconSection('Common UI', [
                _iconItem(CupertinoIcons.home, 'home'),
                _iconItem(CupertinoIcons.settings, 'settings'),
                _iconItem(CupertinoIcons.gear, 'gear'),
                _iconItem(CupertinoIcons.search, 'search'),
                _iconItem(CupertinoIcons.share, 'share'),
                _iconItem(CupertinoIcons.info, 'info'),
              ]),

              // Communication icons
              _buildIconSection('Communication', [
                _iconItem(CupertinoIcons.mail, 'mail'),
                _iconItem(CupertinoIcons.mail_solid, 'mail_solid'),
                _iconItem(CupertinoIcons.phone, 'phone'),
                _iconItem(CupertinoIcons.phone_solid, 'phone_solid'),
                _iconItem(CupertinoIcons.chat_bubble, 'chat_bubble'),
                _iconItem(CupertinoIcons.chat_bubble_fill, 'chat_bubble_fill'),
              ]),

              // Media icons
              _buildIconSection('Media', [
                _iconItem(CupertinoIcons.play, 'play'),
                _iconItem(CupertinoIcons.play_fill, 'play_fill'),
                _iconItem(CupertinoIcons.pause, 'pause'),
                _iconItem(CupertinoIcons.pause_fill, 'pause_fill'),
                _iconItem(CupertinoIcons.volume_up, 'volume_up'),
                _iconItem(CupertinoIcons.volume_mute, 'volume_mute'),
              ]),

              // Editing icons
              _buildIconSection('Editing', [
                _iconItem(CupertinoIcons.pencil, 'pencil'),
                _iconItem(CupertinoIcons.trash, 'trash'),
                _iconItem(CupertinoIcons.trash_fill, 'trash_fill'),
                _iconItem(CupertinoIcons.doc, 'doc'),
                _iconItem(CupertinoIcons.folder, 'folder'),
                _iconItem(CupertinoIcons.doc_on_doc, 'doc_on_doc'),
              ]),

              // Person icons
              _buildIconSection('People', [
                _iconItem(CupertinoIcons.person, 'person'),
                _iconItem(CupertinoIcons.person_fill, 'person_fill'),
                _iconItem(CupertinoIcons.person_circle, 'person_circle'),
                _iconItem(CupertinoIcons.person_2, 'person_2'),
                _iconItem(CupertinoIcons.person_3, 'person_3'),
                _iconItem(
                  CupertinoIcons.person_badge_plus,
                  'person_badge_plus',
                ),
              ]),

              // Status icons
              _buildIconSection('Status', [
                _iconItem(CupertinoIcons.checkmark, 'checkmark'),
                _iconItem(CupertinoIcons.checkmark_circle, 'checkmark_circle'),
                _iconItem(CupertinoIcons.xmark, 'xmark'),
                _iconItem(CupertinoIcons.xmark_circle, 'xmark_circle'),
                _iconItem(CupertinoIcons.bell, 'bell'),
                _iconItem(CupertinoIcons.bell_fill, 'bell_fill'),
              ]),

              // Favorite icons
              _buildIconSection('Favorites', [
                _iconItem(CupertinoIcons.heart, 'heart'),
                _iconItem(CupertinoIcons.heart_fill, 'heart_fill'),
                _iconItem(CupertinoIcons.star, 'star'),
                _iconItem(CupertinoIcons.star_fill, 'star_fill'),
                _iconItem(CupertinoIcons.bookmark, 'bookmark'),
                _iconItem(CupertinoIcons.bookmark_fill, 'bookmark_fill'),
              ]),

              // Weather/Time
              _buildIconSection('Weather & Time', [
                _iconItem(CupertinoIcons.sun_max, 'sun_max'),
                _iconItem(CupertinoIcons.moon, 'moon'),
                _iconItem(CupertinoIcons.cloud, 'cloud'),
                _iconItem(CupertinoIcons.clock, 'clock'),
                _iconItem(CupertinoIcons.timer, 'timer'),
                _iconItem(CupertinoIcons.calendar, 'calendar'),
              ]),

              // Commerce
              _buildIconSection('Commerce', [
                _iconItem(CupertinoIcons.cart, 'cart'),
                _iconItem(CupertinoIcons.cart_fill, 'cart_fill'),
                _iconItem(CupertinoIcons.bag, 'bag'),
                _iconItem(CupertinoIcons.creditcard, 'creditcard'),
                _iconItem(CupertinoIcons.tag, 'tag'),
                _iconItem(CupertinoIcons.tag_fill, 'tag_fill'),
              ]),

              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildIconSection(String title, List<Widget> icons) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ),
      Wrap(spacing: 8.0, runSpacing: 8.0, children: icons),
      SizedBox(height: 16.0),
    ],
  );
}

Widget _iconItem(IconData icon, String name) {
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      children: [
        Icon(icon, size: 28.0, color: CupertinoColors.systemBlue),
        SizedBox(height: 4.0),
        Text(
          name,
          style: TextStyle(fontSize: 10.0, color: CupertinoColors.systemGrey),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
