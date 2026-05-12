// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for ObstructingPreferredSizeWidget
// and the CupertinoNavigationBar / PreferredSize family
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔══════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║   ObstructingPreferredSizeWidget — Deep Visual Demo                  ║',
  );
  print(
    '║   Cupertino navigation bars, PreferredSize, and SafeArea handshake   ║',
  );
  print(
    '╚══════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═════════════════════════════════════════════════════════════════════════
  // CONSTANTS, COLORS, TEXT STYLES
  // ═════════════════════════════════════════════════════════════════════════
  final headingStyle = const TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    color: CupertinoColors.label,
    letterSpacing: -0.4,
  );
  final subHeadingStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: CupertinoColors.secondaryLabel,
  );
  final bodyStyle = const TextStyle(
    fontSize: 14.0,
    color: CupertinoColors.label,
    height: 1.35,
  );
  final codeStyle = const TextStyle(
    fontSize: 13.0,
    fontFamily: 'Menlo',
    color: CupertinoColors.activeBlue,
  );
  final mutedStyle = const TextStyle(
    fontSize: 12.5,
    color: CupertinoColors.tertiaryLabel,
    height: 1.3,
  );

  final dividerColor = CupertinoColors.systemGrey4;
  final tintBlue = CupertinoColors.activeBlue;
  final tintOrange = CupertinoColors.activeOrange;
  final tintGreen = CupertinoColors.activeGreen;

  // ─────────────────────────────────────────────────────────────────────────
  // Helper: section header card
  // ─────────────────────────────────────────────────────────────────────────
  Widget sectionHeader(int index, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            tintBlue.withOpacity(0.10),
            tintBlue.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tintBlue.withOpacity(0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tintBlue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: CupertinoColors.white,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: headingStyle),
                const SizedBox(height: 4.0),
                Text(subtitle, style: mutedStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helper: explanatory card
  // ─────────────────────────────────────────────────────────────────────────
  Widget explainCard(String title, List<String> lines, Color accent) {
    final children = <Widget>[
      Text(title, style: subHeadingStyle),
      const SizedBox(height: 6.0),
    ];
    for (int i = 0; i < lines.length; i++) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 6.0,
                height: 6.0,
                margin: const EdgeInsets.only(top: 7.0, right: 8.0),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              Expanded(child: Text(lines[i], style: bodyStyle)),
            ],
          ),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withOpacity(0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withOpacity(0.06),
            blurRadius: 12.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helper: code block
  // ─────────────────────────────────────────────────────────────────────────
  Widget codeBlock(String label, String code) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FB),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: mutedStyle),
          const SizedBox(height: 4.0),
          Text(code, style: codeStyle),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helper: chip
  // ─────────────────────────────────────────────────────────────────────────
  Widget chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helper: key/value row
  // ─────────────────────────────────────────────────────────────────────────
  Widget kvRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              key,
              style: const TextStyle(
                fontSize: 13.0,
                color: CupertinoColors.secondaryLabel,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13.0,
                color: CupertinoColors.label,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════════
  // ANATOMY: What is PreferredSizeWidget / ObstructingPreferredSizeWidget?
  // ═════════════════════════════════════════════════════════════════════════
  print('Stage 0: assembling anatomy reference for PreferredSize family.');

  final anatomyBlock = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: tintBlue.withOpacity(0.06),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tintBlue.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              CupertinoIcons.book,
              size: 22.0,
              color: CupertinoColors.activeBlue,
            ),
            const SizedBox(width: 8.0),
            Text('Anatomy reference', style: subHeadingStyle),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'PreferredSizeWidget',
          style: bodyStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4.0),
        Text(
          'A widget that contracts to a specific Size when measured by its '
          'parent. AppBar, TabBar, CupertinoNavigationBar and friends all '
          'implement this so Scaffold-like hosts can lay them out predictably.',
          style: bodyStyle,
        ),
        const SizedBox(height: 10.0),
        Text(
          'ObstructingPreferredSizeWidget',
          style: bodyStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4.0),
        Text(
          'A PreferredSizeWidget that additionally answers '
          'shouldFullyObstruct(BuildContext). When it returns true the host '
          'page can shrink its MediaQuery padding because the bar is fully '
          'opaque — nothing behind it is visible.',
          style: bodyStyle,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            chip('PreferredSizeWidget', tintBlue),
            chip('ObstructingPreferredSizeWidget', tintOrange),
            chip('CupertinoNavigationBar', tintGreen),
            chip('AppBar', CupertinoColors.systemPurple),
            chip('PreferredSize', CupertinoColors.systemTeal),
          ],
        ),
      ],
    ),
  );

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 1: CupertinoNavigationBar configuration gallery
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 1: building CupertinoNavigationBar configuration gallery.');

  final navBarPlain = CupertinoNavigationBar(middle: const Text('Plain'));
  final navBarLeading = CupertinoNavigationBar(
    leading: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: const Text('Cancel'),
    ),
    middle: const Text('Leading'),
  );
  final navBarTrailing = CupertinoNavigationBar(
    middle: const Text('Trailing'),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: const Icon(CupertinoIcons.add),
    ),
  );
  final navBarFull = CupertinoNavigationBar(
    leading: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: const Text('Cancel'),
    ),
    middle: const Text('Full'),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: const Text('Done'),
    ),
  );
  final navBarBranded = CupertinoNavigationBar(
    backgroundColor: tintBlue,
    brightness: Brightness.dark,
    middle: const Text(
      'Branded',
      style: TextStyle(color: CupertinoColors.white),
    ),
    trailing: const Icon(
      CupertinoIcons.bell_fill,
      color: CupertinoColors.white,
    ),
  );
  final navBarBorderless = CupertinoNavigationBar(
    middle: const Text('Borderless'),
    border: null,
    backgroundColor: CupertinoColors.systemBackground,
  );
  final navBarTranslucent = CupertinoNavigationBar(
    middle: const Text('Translucent'),
    backgroundColor: CupertinoColors.systemGrey.withOpacity(0.45),
  );

  final navBarSamples = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Plain',
      'bar': navBarPlain,
      'notes': 'middle only — defaults to system grouped background',
    },
    <String, dynamic>{
      'label': 'Leading',
      'bar': navBarLeading,
      'notes': 'leading button + middle title',
    },
    <String, dynamic>{
      'label': 'Trailing',
      'bar': navBarTrailing,
      'notes': 'middle + trailing action button',
    },
    <String, dynamic>{
      'label': 'Full',
      'bar': navBarFull,
      'notes': 'leading + middle + trailing classic layout',
    },
    <String, dynamic>{
      'label': 'Branded',
      'bar': navBarBranded,
      'notes': 'tinted background with dark brightness',
    },
    <String, dynamic>{
      'label': 'Borderless',
      'bar': navBarBorderless,
      'notes': 'border: null — no hairline divider',
    },
    <String, dynamic>{
      'label': 'Translucent',
      'bar': navBarTranslucent,
      'notes': 'semi-transparent background — does not fully obstruct',
    },
  ];

  Widget navBarSampleTile(Map<String, dynamic> sample) {
    final CupertinoNavigationBar bar = sample['bar'] as CupertinoNavigationBar;
    final String label = sample['label'] as String;
    final String notes = sample['notes'] as String;
    final bool obstructs = bar.shouldFullyObstruct(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
            child: SizedBox(
              height: bar.preferredSize.height,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ColoredBox(
                      color: CupertinoColors.systemGrey6,
                    ),
                  ),
                  Positioned.fill(child: bar),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(label, style: subHeadingStyle),
                    const Spacer(),
                    chip(
                      'preferred ${bar.preferredSize.height.toStringAsFixed(1)}',
                      tintBlue,
                    ),
                    const SizedBox(width: 6.0),
                    chip(
                      obstructs ? 'obstructs' : 'see-through',
                      obstructs ? tintGreen : tintOrange,
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(notes, style: mutedStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final navBarGallery = <Widget>[];
  for (int i = 0; i < navBarSamples.length; i++) {
    navBarGallery.add(navBarSampleTile(navBarSamples[i]));
  }

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 2: shouldFullyObstruct — opaque vs translucent
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 2: building shouldFullyObstruct comparison table.');

  final obstructionSamples = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'pure white',
      'color': CupertinoColors.white,
    },
    <String, dynamic>{
      'name': 'pure black',
      'color': CupertinoColors.black,
    },
    <String, dynamic>{
      'name': 'system blue',
      'color': CupertinoColors.activeBlue,
    },
    <String, dynamic>{
      'name': 'orange 90%',
      'color': CupertinoColors.activeOrange.withOpacity(0.9),
    },
    <String, dynamic>{
      'name': 'grey 50%',
      'color': CupertinoColors.systemGrey.withOpacity(0.5),
    },
    <String, dynamic>{
      'name': 'transparent',
      'color': const Color(0x00000000),
    },
    <String, dynamic>{
      'name': 'tile 25%',
      'color': CupertinoColors.systemTeal.withOpacity(0.25),
    },
  ];

  final obstructionRows = <Widget>[];
  obstructionRows.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: tintBlue.withOpacity(0.10),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              'background',
              style: bodyStyle.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 90.0,
            child: Text(
              'alpha',
              style: bodyStyle.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(
              'shouldFullyObstruct',
              style: bodyStyle.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < obstructionSamples.length; i++) {
    final sample = obstructionSamples[i];
    final color = sample['color'] as Color;
    final bar = CupertinoNavigationBar(
      middle: const Text('x'),
      backgroundColor: color,
    );
    final bool obstructs = bar.shouldFullyObstruct(context);
    obstructionRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: dividerColor)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 130.0,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 16.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: dividerColor),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(sample['name'] as String, style: bodyStyle),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                color.opacity.toStringAsFixed(2),
                style: bodyStyle,
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(
                    obstructs
                        ? CupertinoIcons.check_mark_circled_solid
                        : CupertinoIcons.xmark_circle,
                    color: obstructs ? tintGreen : tintOrange,
                    size: 18.0,
                  ),
                  const SizedBox(width: 6.0),
                  Text(obstructs ? 'true' : 'false', style: bodyStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  final obstructionTable = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: dividerColor),
    ),
    child: Column(children: obstructionRows),
  );

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 3: CupertinoSliverNavigationBar showcase
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 3: building CupertinoSliverNavigationBar showcase.');

  Widget sliverShowcase(String label, Widget largeTitle, Widget? trailing) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      height: 220.0,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: dividerColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: largeTitle,
              trailing: trailing,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(label, style: subHeadingStyle),
                    const SizedBox(height: 6.0),
                    Text(
                      'CupertinoSliverNavigationBar can only render inside a '
                      'sliver host. It collapses the largeTitle into a small '
                      'middle area as the user scrolls.',
                      style: bodyStyle,
                    ),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        chip('sliver', tintBlue),
                        const SizedBox(width: 6.0),
                        chip('largeTitle', tintGreen),
                        const SizedBox(width: 6.0),
                        chip('obstructing', tintOrange),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final sliverShowcases = <Widget>[
    sliverShowcase('Inbox', const Text('Inbox'), null),
    sliverShowcase(
      'Mailboxes',
      const Text('Mailboxes'),
      const Icon(CupertinoIcons.add),
    ),
    sliverShowcase(
      'Settings',
      const Text('Settings'),
      const Icon(CupertinoIcons.search),
    ),
  ];

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 4: CupertinoNavigationBarBackButton
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 4: building CupertinoNavigationBarBackButton showcase.');

  Widget backButtonRow(String label, String? text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: dividerColor),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(label, style: subHeadingStyle),
          ),
          Container(
            height: 36.0,
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: <Widget>[
                Icon(CupertinoIcons.back, size: 22.0, color: color),
                const SizedBox(width: 4.0),
                Text(
                  text ?? '',
                  style: TextStyle(color: color, fontSize: 15.0),
                ),
              ],
            ),
          ),
          const Spacer(),
          chip('back button', color),
        ],
      ),
    );
  }

  final backButtonShowcase = <Widget>[
    backButtonRow('default', 'Back', tintBlue),
    backButtonRow('custom', 'Inbox', tintBlue),
    backButtonRow('orange', 'Cancel', tintOrange),
    backButtonRow('green', 'Done', tintGreen),
    backButtonRow('icon only', '', tintBlue),
  ];

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 5: PreferredSize wrapper recipes
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 5: building PreferredSize wrapper recipes.');

  Widget recipeCard(
    String title,
    String description,
    PreferredSizeWidget bar,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
            child: SizedBox(
              height: bar.preferredSize.height,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ColoredBox(color: CupertinoColors.systemGrey5),
                  ),
                  Positioned.fill(child: bar),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: subHeadingStyle),
                const SizedBox(height: 4.0),
                Text(description, style: bodyStyle),
                const SizedBox(height: 6.0),
                Row(
                  children: <Widget>[
                    chip(
                      'preferredSize ${bar.preferredSize.width.toStringAsFixed(0)}×'
                      '${bar.preferredSize.height.toStringAsFixed(1)}',
                      tintBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final tallBar = PreferredSize(
    preferredSize: const Size.fromHeight(88.0),
    child: Container(
      color: tintBlue,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      alignment: Alignment.bottomLeft,
      child: const Text(
        'Tall PreferredSize',
        style: TextStyle(
          color: CupertinoColors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  final stripedBar = PreferredSize(
    preferredSize: const Size.fromHeight(54.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[tintOrange, tintGreen],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        'Gradient PreferredSize',
        style: TextStyle(
          color: CupertinoColors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  final searchBar = PreferredSize(
    preferredSize: const Size.fromHeight(60.0),
    child: Container(
      color: CupertinoColors.systemGrey6,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: dividerColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            const Icon(
              CupertinoIcons.search,
              size: 16.0,
              color: CupertinoColors.tertiaryLabel,
            ),
            const SizedBox(width: 6.0),
            Text(
              'Search PreferredSize wrapper',
              style: mutedStyle.copyWith(fontSize: 13.0),
            ),
          ],
        ),
      ),
    ),
  );

  final cupertinoInsidePreferred = PreferredSize(
    preferredSize: navBarFull.preferredSize,
    child: navBarFull,
  );

  final recipes = <Widget>[
    recipeCard(
      'Tall hero bar',
      'PreferredSize lets you fix a non-standard height (88.0 here) so the '
          'parent reserves room for the hero title.',
      tallBar,
    ),
    recipeCard(
      'Gradient strip',
      'PreferredSize wraps any custom widget — no need to subclass anything '
          'just to satisfy the preferredSize contract.',
      stripedBar,
    ),
    recipeCard(
      'Search dock',
      'A search field can be promoted to a "preferred-size" slot for '
          'AppBar.bottom or scaffold-style hosts.',
      searchBar,
    ),
    recipeCard(
      'Wrapping Cupertino',
      'You can re-wrap a CupertinoNavigationBar in PreferredSize for hosts '
          'that only accept PreferredSizeWidget (not ObstructingPreferredSizeWidget).',
      cupertinoInsidePreferred,
    ),
  ];

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 6: AppBar comparison (Material) — for contrast
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 6: building Material AppBar comparison card.');

  final materialAppBar = AppBar(
    title: const Text('Material AppBar'),
    backgroundColor: tintBlue,
    foregroundColor: CupertinoColors.white,
    elevation: 0.0,
    actions: const <Widget>[
      Icon(CupertinoIcons.bell_fill, color: CupertinoColors.white),
      SizedBox(width: 12.0),
    ],
  );

  final appBarCompareCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: dividerColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14.0),
            topRight: Radius.circular(14.0),
          ),
          child: SizedBox(
            height: materialAppBar.preferredSize.height,
            child: materialAppBar,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('AppBar (Material)', style: subHeadingStyle),
              const SizedBox(height: 4.0),
              Text(
                'AppBar implements PreferredSizeWidget but NOT '
                'ObstructingPreferredSizeWidget. Material Scaffolds compute '
                'their content padding without ever calling shouldFullyObstruct.',
                style: bodyStyle,
              ),
              const SizedBox(height: 6.0),
              kvRow(
                'preferredSize',
                materialAppBar.preferredSize.toString(),
              ),
              kvRow('is PreferredSizeWidget', 'true'),
              kvRow('is ObstructingPreferredSizeWidget', 'false'),
            ],
          ),
        ),
      ],
    ),
  );

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 7: Full obstruction vs translucent — SafeArea consequences
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 7: building obstruction vs translucent layout pair.');

  Widget pageScaffoldThumb(
    String title,
    CupertinoNavigationBar bar,
    String story,
    Color tint,
  ) {
    final bool obstructs = bar.shouldFullyObstruct(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: SizedBox(
              height: 240.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            tint.withOpacity(0.20),
                            tint.withOpacity(0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: bar.preferredSize.height + 8.0,
                    left: 12.0,
                    right: 12.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: bodyStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(story, style: bodyStyle),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: SizedBox(
                      height: bar.preferredSize.height,
                      child: bar,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                chip(
                  obstructs ? 'obstruct: TRUE' : 'obstruct: FALSE',
                  obstructs ? tintGreen : tintOrange,
                ),
                const SizedBox(width: 6.0),
                chip(
                  'height ${bar.preferredSize.height.toStringAsFixed(1)}',
                  tintBlue,
                ),
                const Spacer(),
                Icon(
                  obstructs
                      ? CupertinoIcons.shield_lefthalf_fill
                      : CupertinoIcons.eye_slash,
                  color: obstructs ? tintGreen : tintOrange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final obstructionLayouts = <Widget>[
    pageScaffoldThumb(
      'Opaque page',
      CupertinoNavigationBar(
        middle: const Text('Inbox'),
        backgroundColor: CupertinoColors.white,
      ),
      'shouldFullyObstruct returns true → the page child receives top padding '
          'of 0 (content can start at y = bar.height). The SafeArea above the '
          'bar is consumed by the bar itself.',
      tintGreen,
    ),
    pageScaffoldThumb(
      'Translucent page',
      CupertinoNavigationBar(
        middle: const Text('Inbox'),
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.35),
      ),
      'shouldFullyObstruct returns false → the scaffold leaves top padding so '
          'content scrolls under the translucent bar, producing the classic '
          'iOS frosted effect.',
      tintOrange,
    ),
    pageScaffoldThumb(
      'Branded opaque',
      CupertinoNavigationBar(
        middle: const Text('Brand'),
        backgroundColor: tintBlue,
        brightness: Brightness.dark,
      ),
      'Fully opaque tint also fully obstructs. Useful for branded headers '
          'that should not show any blurred backdrop.',
      tintBlue,
    ),
  ];

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 8: Sample CupertinoPageScaffold layouts (one rendered live)
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 8: building sample CupertinoPageScaffold layouts.');

  Widget livePageScaffold(String label, CupertinoNavigationBar bar) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      height: 260.0,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: dividerColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: CupertinoPageScaffold(
          navigationBar: bar,
          child: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: <Widget>[
                Text(label, style: subHeadingStyle),
                const SizedBox(height: 6.0),
                Text(
                  'This is a live CupertinoPageScaffold using the bar above. '
                  'The scaffold honors the bar\'s preferredSize and consults '
                  'shouldFullyObstruct to decide how to lay out child content.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: tintBlue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text('content tile A'),
                ),
                const SizedBox(height: 6.0),
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: tintGreen.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text('content tile B'),
                ),
                const SizedBox(height: 6.0),
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: tintOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text('content tile C'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final samplePages = <Widget>[
    livePageScaffold(
      'Live: opaque white bar',
      CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Text('Edit'),
        ),
        middle: const Text('Inbox'),
        trailing: const Icon(CupertinoIcons.add),
        backgroundColor: CupertinoColors.white,
      ),
    ),
    livePageScaffold(
      'Live: translucent bar',
      CupertinoNavigationBar(
        middle: const Text('Translucent'),
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.35),
      ),
    ),
    livePageScaffold(
      'Live: branded bar',
      CupertinoNavigationBar(
        middle: const Text(
          'Brand',
          style: TextStyle(color: CupertinoColors.white),
        ),
        backgroundColor: tintBlue,
        brightness: Brightness.dark,
        trailing: const Icon(
          CupertinoIcons.gear,
          color: CupertinoColors.white,
        ),
      ),
    ),
  ];

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 9: API reference cards
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 9: building API reference cards.');

  final apiCards = <Widget>[
    explainCard(
      'PreferredSizeWidget',
      <String>[
        'abstract interface implemented by widgets that have a preferred size.',
        'exposes preferredSize: Size — width may be infinite for flexible bars.',
        'examples: AppBar, TabBar, CupertinoNavigationBar, PreferredSize.',
      ],
      tintBlue,
    ),
    explainCard(
      'ObstructingPreferredSizeWidget',
      <String>[
        'extends PreferredSizeWidget with shouldFullyObstruct(BuildContext).',
        'returns true when the bar paints fully opaque pixels (no see-through).',
        'examples: CupertinoNavigationBar, CupertinoSliverNavigationBar.',
      ],
      tintOrange,
    ),
    explainCard(
      'CupertinoNavigationBar',
      <String>[
        'top navigation bar matching iOS design language.',
        'preferredSize.height = kMinInteractiveDimensionCupertino (44.0).',
        'shouldFullyObstruct(context) is true iff backgroundColor alpha = 1.',
      ],
      tintGreen,
    ),
    explainCard(
      'CupertinoSliverNavigationBar',
      <String>[
        'sliver variant with collapsing largeTitle.',
        'must live inside a CustomScrollView (or other sliver host).',
        'also implements ObstructingPreferredSizeWidget — same opacity rule.',
      ],
      CupertinoColors.systemTeal,
    ),
    explainCard(
      'CupertinoNavigationBarBackButton',
      <String>[
        'standard back chevron used inside CupertinoNavigationBar.leading.',
        'reads previousPageTitle from the route to render its caption.',
        'inherits tint colors from the surrounding nav bar.',
      ],
      CupertinoColors.systemPurple,
    ),
    explainCard(
      'PreferredSize',
      <String>[
        'concrete widget that wraps any child with a fixed preferredSize.',
        'lets you satisfy PreferredSizeWidget hosts without subclassing.',
        'does NOT implement ObstructingPreferredSizeWidget.',
      ],
      CupertinoColors.systemPink,
    ),
  ];

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 10: Code blocks
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 10: building code reference blocks.');

  final codeBlocks = <Widget>[
    codeBlock(
      'PreferredSizeWidget contract',
      'abstract class PreferredSizeWidget implements Widget {\n'
          '  Size get preferredSize;\n'
          '}',
    ),
    codeBlock(
      'ObstructingPreferredSizeWidget contract',
      'abstract class ObstructingPreferredSizeWidget\n'
          '    extends PreferredSizeWidget {\n'
          '  bool shouldFullyObstruct(BuildContext context);\n'
          '}',
    ),
    codeBlock(
      'CupertinoNavigationBar usage',
      'CupertinoPageScaffold(\n'
          '  navigationBar: CupertinoNavigationBar(\n'
          '    leading: CupertinoNavigationBarBackButton(),\n'
          '    middle: Text(\'Inbox\'),\n'
          '    trailing: Icon(CupertinoIcons.add),\n'
          '  ),\n'
          '  child: ...\n'
          ')',
    ),
    codeBlock(
      'PreferredSize wrapper',
      'PreferredSize(\n'
          '  preferredSize: const Size.fromHeight(88.0),\n'
          '  child: myCustomHeader,\n'
          ')',
    ),
    codeBlock(
      'AppBar comparison',
      'AppBar(\n'
          '  title: Text(\'Material\'),\n'
          '  // implements PreferredSizeWidget but NOT obstructing variant\n'
          ')',
    ),
  ];

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 11: Numeric metrics summary
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 11: building metrics summary card.');

  final metricsCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: tintGreen.withOpacity(0.06),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tintGreen.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              CupertinoIcons.chart_bar_alt_fill,
              color: CupertinoColors.activeGreen,
            ),
            const SizedBox(width: 8.0),
            Text('Numeric metrics', style: subHeadingStyle),
          ],
        ),
        const SizedBox(height: 8.0),
        kvRow(
          'navBarPlain.preferredSize',
          navBarPlain.preferredSize.toString(),
        ),
        kvRow(
          'navBarFull.preferredSize',
          navBarFull.preferredSize.toString(),
        ),
        kvRow(
          'navBarBranded.preferredSize',
          navBarBranded.preferredSize.toString(),
        ),
        kvRow(
          'shouldFullyObstruct(opaque white)',
          navBarPlain.shouldFullyObstruct(context).toString(),
        ),
        kvRow(
          'shouldFullyObstruct(translucent)',
          navBarTranslucent.shouldFullyObstruct(context).toString(),
        ),
        kvRow(
          'AppBar.preferredSize',
          materialAppBar.preferredSize.toString(),
        ),
        kvRow(
          'tallBar.preferredSize',
          tallBar.preferredSize.toString(),
        ),
        kvRow(
          'stripedBar.preferredSize',
          stripedBar.preferredSize.toString(),
        ),
      ],
    ),
  );

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 12: Decision flow chart for "should my bar obstruct?"
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 12: building decision flow card.');

  Widget flowNode(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 18.0),
          const SizedBox(width: 6.0),
          Flexible(child: Text(text, style: bodyStyle)),
        ],
      ),
    );
  }

  Widget flowArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Icon(
        CupertinoIcons.arrow_down,
        size: 18.0,
        color: CupertinoColors.systemGrey,
      ),
    );
  }

  final decisionFlow = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: dividerColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Decision flow — does my bar obstruct?', style: subHeadingStyle),
        const SizedBox(height: 10.0),
        flowNode(
          'Start: I have a top bar widget',
          tintBlue,
          CupertinoIcons.play_arrow_solid,
        ),
        flowArrow(),
        flowNode(
          'Does it implement PreferredSizeWidget?',
          tintBlue,
          CupertinoIcons.question_circle,
        ),
        flowArrow(),
        flowNode(
          'Yes → exposes preferredSize for the parent',
          tintGreen,
          CupertinoIcons.check_mark,
        ),
        flowArrow(),
        flowNode(
          'Does it implement ObstructingPreferredSizeWidget?',
          tintBlue,
          CupertinoIcons.question_circle,
        ),
        flowArrow(),
        flowNode(
          'Yes → host can call shouldFullyObstruct(context)',
          tintOrange,
          CupertinoIcons.arrow_branch,
        ),
        flowArrow(),
        flowNode(
          'shouldFullyObstruct true → trim top padding',
          tintGreen,
          CupertinoIcons.shield_lefthalf_fill,
        ),
        flowArrow(),
        flowNode(
          'shouldFullyObstruct false → leave SafeArea padding',
          tintOrange,
          CupertinoIcons.eye_slash,
        ),
      ],
    ),
  );

  // ═════════════════════════════════════════════════════════════════════════
  // SECTION 13: Common pitfalls
  // ═════════════════════════════════════════════════════════════════════════
  print('Section 13: building common pitfalls list.');

  Widget pitfall(String title, String body, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 20.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: bodyStyle.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4.0),
                Text(body, style: bodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final pitfalls = <Widget>[
    pitfall(
      'Returning translucent yet expecting top inset of 0',
      'If shouldFullyObstruct returns false, the page child still receives '
          'top padding. Make the bar fully opaque or accept the inset.',
      tintOrange,
      CupertinoIcons.exclamationmark_triangle,
    ),
    pitfall(
      'Putting CupertinoSliverNavigationBar inside a regular Column',
      'It is a Sliver — it only renders inside a sliver host. Use '
          'CustomScrollView or NestedScrollView.',
      CupertinoColors.systemRed,
      CupertinoIcons.exclamationmark_octagon,
    ),
    pitfall(
      'Wrapping AppBar in CupertinoPageScaffold',
      'CupertinoPageScaffold expects an ObstructingPreferredSizeWidget. '
          'AppBar only implements PreferredSizeWidget — use '
          'CupertinoNavigationBar instead.',
      tintBlue,
      CupertinoIcons.info_circle,
    ),
    pitfall(
      'Forgetting to set preferredSize on custom PreferredSize children',
      'PreferredSize\'s preferredSize parameter is required — set a '
          'Size.fromHeight or Size(width, height) explicitly.',
      tintGreen,
      CupertinoIcons.checkmark_seal,
    ),
  ];

  // ═════════════════════════════════════════════════════════════════════════
  // ASSEMBLE LIST OF SECTIONS
  // ═════════════════════════════════════════════════════════════════════════
  print('Assembling final ListView body.');

  final body = <Widget>[];
  body.add(const SizedBox(height: 12.0));
  body.add(sectionHeader(
    0,
    'Anatomy: PreferredSize family',
    'Classes and contracts you will see in this demo.',
  ));
  body.add(anatomyBlock);

  body.add(sectionHeader(
    1,
    'CupertinoNavigationBar gallery',
    'Seven hand-tuned configurations rendered side-by-side.',
  ));
  for (int i = 0; i < navBarGallery.length; i++) {
    body.add(navBarGallery[i]);
  }

  body.add(sectionHeader(
    2,
    'shouldFullyObstruct — opaque vs translucent',
    'How the background color drives the obstruction decision.',
  ));
  body.add(obstructionTable);

  body.add(sectionHeader(
    3,
    'CupertinoSliverNavigationBar',
    'Live sliver hosts with collapsing largeTitle.',
  ));
  for (int i = 0; i < sliverShowcases.length; i++) {
    body.add(sliverShowcases[i]);
  }

  body.add(sectionHeader(
    4,
    'CupertinoNavigationBarBackButton',
    'The classic iOS chevron-with-caption used in leading slots.',
  ));
  for (int i = 0; i < backButtonShowcase.length; i++) {
    body.add(backButtonShowcase[i]);
  }

  body.add(sectionHeader(
    5,
    'PreferredSize wrapper recipes',
    'Plain PreferredSize lets any widget satisfy the contract.',
  ));
  for (int i = 0; i < recipes.length; i++) {
    body.add(recipes[i]);
  }

  body.add(sectionHeader(
    6,
    'AppBar (Material) for comparison',
    'AppBar is PreferredSize but NOT obstructing.',
  ));
  body.add(appBarCompareCard);

  body.add(sectionHeader(
    7,
    'fullObstruction true vs false',
    'Layout consequence of shouldFullyObstruct in action.',
  ));
  for (int i = 0; i < obstructionLayouts.length; i++) {
    body.add(obstructionLayouts[i]);
  }

  body.add(sectionHeader(
    8,
    'Sample CupertinoPageScaffold layouts',
    'Three live scaffolds, each with a different navigation bar.',
  ));
  for (int i = 0; i < samplePages.length; i++) {
    body.add(samplePages[i]);
  }

  body.add(sectionHeader(
    9,
    'API reference cards',
    'Short bullet summaries for each class in the family.',
  ));
  for (int i = 0; i < apiCards.length; i++) {
    body.add(apiCards[i]);
  }

  body.add(sectionHeader(
    10,
    'Code reference blocks',
    'Idiomatic snippets you can copy into your own scaffolds.',
  ));
  for (int i = 0; i < codeBlocks.length; i++) {
    body.add(codeBlocks[i]);
  }

  body.add(sectionHeader(
    11,
    'Numeric metrics',
    'Concrete preferredSize and obstruction values from this demo.',
  ));
  body.add(metricsCard);

  body.add(sectionHeader(
    12,
    'Decision flow',
    'When should my bar opt into obstruction?',
  ));
  body.add(decisionFlow);

  body.add(sectionHeader(
    13,
    'Common pitfalls',
    'Mistakes to avoid when combining these classes.',
  ));
  for (int i = 0; i < pitfalls.length; i++) {
    body.add(pitfalls[i]);
  }

  body.add(const SizedBox(height: 24.0));
  body.add(Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'End of ObstructingPreferredSizeWidget deep visual demo.',
        textAlign: TextAlign.center,
        style: mutedStyle,
      ),
    ),
  ));
  body.add(const SizedBox(height: 40.0));

  print('Section count: 14 (sections 0..13)');
  print('Body widget count: ${body.length}');
  print('ObstructingPreferredSizeWidget deep visual demo ready.');

  // ═════════════════════════════════════════════════════════════════════════
  // FINAL CUPERTINO PAGE SCAFFOLD
  // ═════════════════════════════════════════════════════════════════════════
  final hostNavBar = CupertinoNavigationBar(
    leading: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: const Icon(CupertinoIcons.back),
    ),
    middle: const Text('ObstructingPreferredSize'),
    trailing: const Icon(CupertinoIcons.info),
    backgroundColor: CupertinoColors.systemBackground,
  );

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: hostNavBar,
      child: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: body,
        ),
      ),
    ),
  );
}
