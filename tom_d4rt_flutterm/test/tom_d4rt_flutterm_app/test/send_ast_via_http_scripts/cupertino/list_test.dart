// D4rt test script: Tests CupertinoListSection, CupertinoListTile from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino list test executing');

  // ========== CUPERTINOLISTSECTION ==========
  print('--- CupertinoListSection Tests ---');

  // Test basic CupertinoListSection
  final basicListSection = CupertinoListSection(
    children: [
      CupertinoListTile(title: Text('Item 1')),
      CupertinoListTile(title: Text('Item 2')),
      CupertinoListTile(title: Text('Item 3')),
    ],
  );
  print('Basic CupertinoListSection created');

  // Test CupertinoListSection with header
  final headerListSection = CupertinoListSection(
    header: Text('Settings'),
    children: [
      CupertinoListTile(title: Text('General')),
      CupertinoListTile(title: Text('Privacy')),
    ],
  );
  print('CupertinoListSection with header created');

  // Test CupertinoListSection with footer
  final footerListSection = CupertinoListSection(
    footer: Text('Additional options'),
    children: [CupertinoListTile(title: Text('About'))],
  );
  print('CupertinoListSection with footer created');

  // Test CupertinoListSection with margin
  final marginListSection = CupertinoListSection(
    margin: EdgeInsets.all(20.0),
    children: [CupertinoListTile(title: Text('Margined'))],
  );
  print('CupertinoListSection with margin created');

  // Test CupertinoListSection with backgroundColor
  final bgListSection = CupertinoListSection(
    backgroundColor: CupertinoColors.systemGrey6,
    children: [CupertinoListTile(title: Text('Colored Background'))],
  );
  print('CupertinoListSection with backgroundColor created');

  // Test CupertinoListSection with decoration
  final decoratedListSection = CupertinoListSection(
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    children: [CupertinoListTile(title: Text('Decorated'))],
  );
  print('CupertinoListSection with decoration created');

  // Test CupertinoListSection with clipBehavior
  final clippedListSection = CupertinoListSection(
    clipBehavior: Clip.antiAlias,
    children: [CupertinoListTile(title: Text('Clipped'))],
  );
  print('CupertinoListSection with clipBehavior created');

  // Test CupertinoListSection with dividerMargin
  final dividerListSection = CupertinoListSection(
    dividerMargin: 20.0,
    children: [
      CupertinoListTile(title: Text('With divider margin')),
      CupertinoListTile(title: Text('Second item')),
    ],
  );
  print('CupertinoListSection with dividerMargin created');

  // Test CupertinoListSection with additionalDividerMargin
  final additionalDividerListSection = CupertinoListSection(
    additionalDividerMargin: 10.0,
    children: [
      CupertinoListTile(title: Text('Additional divider')),
      CupertinoListTile(title: Text('Next item')),
    ],
  );
  print('CupertinoListSection with additionalDividerMargin created');

  // Test CupertinoListSection with topMargin
  final topMarginListSection = CupertinoListSection(
    topMargin: 30.0,
    children: [CupertinoListTile(title: Text('Top margin'))],
  );
  print('CupertinoListSection with topMargin created');

  // Test CupertinoListSection with hasLeading
  final hasLeadingListSection = CupertinoListSection(
    hasLeading: true,
    children: [
      CupertinoListTile(
        leading: Icon(CupertinoIcons.person),
        title: Text('With leading'),
      ),
    ],
  );
  print('CupertinoListSection with hasLeading created');

  // Test CupertinoListSection.insetGrouped
  final insetGroupedListSection = CupertinoListSection.insetGrouped(
    header: Text('Inset Grouped'),
    children: [
      CupertinoListTile(title: Text('Inset Item 1')),
      CupertinoListTile(title: Text('Inset Item 2')),
    ],
  );
  print('CupertinoListSection.insetGrouped created');

  // ========== CUPERTINOLISTTILE ==========
  print('--- CupertinoListTile Tests ---');

  // Test basic CupertinoListTile
  final basicListTile = CupertinoListTile(title: Text('Basic Tile'));
  print('Basic CupertinoListTile created');

  // Test CupertinoListTile with subtitle
  final subtitleListTile = CupertinoListTile(
    title: Text('Title'),
    subtitle: Text('Subtitle text'),
  );
  print('CupertinoListTile with subtitle created');

  // Test CupertinoListTile with leading
  final leadingListTile = CupertinoListTile(
    leading: Icon(CupertinoIcons.bell),
    title: Text('Notifications'),
  );
  print('CupertinoListTile with leading created');

  // Test CupertinoListTile with trailing
  final trailingListTile = CupertinoListTile(
    title: Text('More Info'),
    trailing: CupertinoListTileChevron(),
  );
  print('CupertinoListTile with trailing created');

  // Test CupertinoListTile with additionalInfo
  final additionalInfoListTile = CupertinoListTile(
    title: Text('Storage'),
    additionalInfo: Text('64GB'),
  );
  print('CupertinoListTile with additionalInfo created');

  // Test CupertinoListTile with onTap
  final tappableListTile = CupertinoListTile(
    title: Text('Tappable'),
    onTap: () {
      print('Tile tapped');
    },
  );
  print('CupertinoListTile with onTap created');

  // Test CupertinoListTile with backgroundColor
  final bgListTile = CupertinoListTile(
    title: Text('Colored'),
    backgroundColor: CupertinoColors.systemGrey5,
  );
  print('CupertinoListTile with backgroundColor created');

  // Test CupertinoListTile with backgroundColorActivated
  final activatedBgListTile = CupertinoListTile(
    title: Text('Activated Color'),
    backgroundColorActivated: CupertinoColors.systemGrey4,
    onTap: () {},
  );
  print('CupertinoListTile with backgroundColorActivated created');

  // Test CupertinoListTile with padding
  final paddedListTile = CupertinoListTile(
    title: Text('Padded'),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
  );
  print('CupertinoListTile with padding created');

  // Test CupertinoListTile with leadingSize
  final leadingSizeListTile = CupertinoListTile(
    leading: Icon(CupertinoIcons.person_circle, size: 40.0),
    leadingSize: 40.0,
    title: Text('Large Leading'),
  );
  print('CupertinoListTile with leadingSize created');

  // Test CupertinoListTile with leadingToTitle
  final leadingToTitleListTile = CupertinoListTile(
    leading: Icon(CupertinoIcons.star),
    leadingToTitle: 20.0,
    title: Text('Custom Spacing'),
  );
  print('CupertinoListTile with leadingToTitle created');

  // Test CupertinoListTile.notched
  final notchedListTile = CupertinoListTile.notched(
    leading: Icon(CupertinoIcons.settings),
    title: Text('Settings'),
    trailing: CupertinoListTileChevron(),
  );
  print('CupertinoListTile.notched created');

  // Test CupertinoListTile with all properties
  final fullListTile = CupertinoListTile(
    leading: Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(
        CupertinoIcons.airplane,
        color: CupertinoColors.white,
        size: 24.0,
      ),
    ),
    title: Text('Airplane Mode'),
    subtitle: Text('Turn off all wireless connections'),
    additionalInfo: Text('Off'),
    trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
    leadingSize: 40.0,
    leadingToTitle: 12.0,
    backgroundColor: CupertinoColors.white,
    backgroundColorActivated: CupertinoColors.systemGrey5,
  );
  print('CupertinoListTile with all properties created');

  // ========== CUPERTINOLISTTILECHEVRON ==========
  print('--- CupertinoListTileChevron Tests ---');

  // Test basic CupertinoListTileChevron
  final basicChevron = CupertinoListTileChevron();
  print('Basic CupertinoListTileChevron created');

  print('Cupertino list test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('List Widgets')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Standard list section
              CupertinoListSection(
                header: Text('GENERAL'),
                children: [
                  CupertinoListTile(
                    leading: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemOrange,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Icon(
                        CupertinoIcons.airplane,
                        color: CupertinoColors.white,
                        size: 18.0,
                      ),
                    ),
                    title: Text('Airplane Mode'),
                    trailing: CupertinoSwitch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  CupertinoListTile(
                    leading: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Icon(
                        CupertinoIcons.wifi,
                        color: CupertinoColors.white,
                        size: 18.0,
                      ),
                    ),
                    title: Text('Wi-Fi'),
                    additionalInfo: Text('Home Network'),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    leading: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Icon(
                        CupertinoIcons.bluetooth,
                        color: CupertinoColors.white,
                        size: 18.0,
                      ),
                    ),
                    title: Text('Bluetooth'),
                    additionalInfo: Text('On'),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                ],
              ),

              // Inset grouped section
              CupertinoListSection.insetGrouped(
                header: Text('ACCOUNT'),
                children: [
                  CupertinoListTile.notched(
                    leading: CircleAvatar(
                      backgroundColor: CupertinoColors.systemGrey,
                      child: Icon(
                        CupertinoIcons.person,
                        color: CupertinoColors.white,
                      ),
                    ),
                    title: Text('John Doe'),
                    subtitle: Text('Apple ID, iCloud, Media & Purchases'),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                ],
              ),

              // Section with subtitles
              CupertinoListSection.insetGrouped(
                header: Text('PREFERENCES'),
                footer: Text('Customize your experience'),
                children: [
                  CupertinoListTile(
                    leading: Icon(
                      CupertinoIcons.bell,
                      color: CupertinoColors.systemRed,
                    ),
                    title: Text('Notifications'),
                    subtitle: Text('Banners, Sounds, Badges'),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    leading: Icon(
                      CupertinoIcons.moon,
                      color: CupertinoColors.systemIndigo,
                    ),
                    title: Text('Focus'),
                    subtitle: Text('Do Not Disturb, Sleep, Work'),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    leading: Icon(
                      CupertinoIcons.clock,
                      color: CupertinoColors.systemGreen,
                    ),
                    title: Text('Screen Time'),
                    subtitle: Text('App & Website Activity'),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                ],
              ),

              // Simple list section
              CupertinoListSection.insetGrouped(
                header: Text('ABOUT'),
                children: [
                  CupertinoListTile(
                    title: Text('Name'),
                    additionalInfo: Text('iPhone'),
                  ),
                  CupertinoListTile(
                    title: Text('Software Version'),
                    additionalInfo: Text('17.0'),
                  ),
                  CupertinoListTile(
                    title: Text('Model Name'),
                    additionalInfo: Text('iPhone 15 Pro'),
                  ),
                ],
              ),

              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    ),
  );
}
