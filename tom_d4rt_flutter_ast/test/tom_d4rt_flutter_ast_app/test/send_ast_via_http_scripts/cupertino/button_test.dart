// D4rt test script: CupertinoButton anatomy & uses — an iOS press field guide.
// Deep visual demonstration of CupertinoButton, CupertinoButton.filled and
// CupertinoButton.tinted across the parameters exposed by the Flutter SDK.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('CupertinoButton deep demo executing');

  // ============================================================
  // SECTION 1: Hero header — what CupertinoButton is
  // ============================================================
  debugPrint('=== Section 1: Hero header ===');

  final Widget heroHeader = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0A84FF),
          Color(0xFF5E5CE6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0A84FF).withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              CupertinoIcons.app_badge,
              color: CupertinoColors.white,
              size: 36.0,
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'CupertinoButton field guide',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'CupertinoButton is the iOS-flavoured press surface. It animates '
          'opacity on press instead of using a Material ripple, sits flat in '
          'most contexts, and reads as system-blue text by default.',
          style: TextStyle(
            fontSize: 14.0,
            color: CupertinoColors.white,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Material vs Cupertino: Material buttons announce themselves with '
          'elevation and splashes; CupertinoButtons recede until pressed and '
          'rely on tint to signal interactivity.',
          style: TextStyle(
            fontSize: 12.0,
            color: CupertinoColors.white,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  debugPrint('=== Section 2: Anatomy diagram ===');

  Widget anatomyLabel(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            CupertinoIcons.arrow_right,
            size: 12.0,
            color: CupertinoColors.systemBlue,
          ),
          const SizedBox(width: 6.0),
          SizedBox(
            width: 110.0,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12.0,
                color: Color(0xFF3A3A3C),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget anatomyCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: CupertinoColors.systemGrey4,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Anatomy of a CupertinoButton',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: CupertinoButton(
            color: CupertinoColors.systemBlue,
            padding: const EdgeInsets.symmetric(
              horizontal: 28.0,
              vertical: 14.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
            pressedOpacity: 0.55,
            onPressed: () {
              debugPrint('Anatomy button pressed');
            },
            child: const Text(
              'Sample',
              style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        anatomyLabel('child', 'The label or content rendered inside.'),
        anatomyLabel('padding', 'Inner spacing — defines the tap target.'),
        anatomyLabel('color', 'Background fill when set; otherwise text-only.'),
        anatomyLabel('pressedOpacity', 'Opacity dip on press, default 0.4.'),
        anatomyLabel('borderRadius', 'Corner rounding of the filled rectangle.'),
        anatomyLabel('disabledColor', 'Fill used when onPressed is null.'),
        anatomyLabel('onPressed', 'Tap callback; null disables the button.'),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Three variants side-by-side
  // ============================================================
  debugPrint('=== Section 3: Variants — default, filled, tinted ===');

  Widget variantTile(String title, String note, Widget button) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: CupertinoColors.systemGrey4),
        ),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
            const SizedBox(height: 10.0),
            button,
            const SizedBox(height: 10.0),
            Text(
              note,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.0,
                color: Color(0xFF6E6E73),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Note: CupertinoButton.tinted exists on newer Flutter SDKs; if absent in a
  // given SDK we simulate it with a muted filled button. Here we use the real
  // tinted constructor.
  final Widget variantsRow = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        variantTile(
          'default',
          'Text-only system-blue label. Press dims to ~40% opacity.',
          CupertinoButton(
            onPressed: () => debugPrint('default pressed'),
            child: const Text('Continue'),
          ),
        ),
        variantTile(
          '.filled',
          'Background fill; high-emphasis primary actions.',
          CupertinoButton.filled(
            onPressed: () => debugPrint('filled pressed'),
            child: const Text('Continue'),
          ),
        ),
        variantTile(
          '.tinted',
          'Muted background, system-blue label; secondary actions.',
          CupertinoButton.tinted(
            onPressed: () => debugPrint('tinted pressed'),
            child: const Text('Continue'),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: sizeStyle catalogue
  // ============================================================
  debugPrint('=== Section 4: sizeStyle catalogue ===');

  Widget sizeRow(String label, CupertinoButtonSize size, String note) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 70.0,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          CupertinoButton.filled(
            sizeStyle: size,
            onPressed: () => debugPrint('size $label pressed'),
            child: const Text('Tap'),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                fontSize: 11.0,
                color: Color(0xFF3A3A3C),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget sizeStyleSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Text(
          'sizeStyle — small, medium, large',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
      ),
      sizeRow(
        'small',
        CupertinoButtonSize.small,
        'Compact controls inside tight layouts (lists, toolbars).',
      ),
      sizeRow(
        'medium',
        CupertinoButtonSize.medium,
        'Default for most flows; balanced tap target and density.',
      ),
      sizeRow(
        'large',
        CupertinoButtonSize.large,
        'Hero CTA; thumb-friendly across one-handed reach.',
      ),
    ],
  );

  // ============================================================
  // SECTION 5: pressedOpacity scale
  // ============================================================
  debugPrint('=== Section 5: pressedOpacity scale ===');

  Widget pressedTile(double value, String feel) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: CupertinoColors.systemGrey4),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'opacity ${value.toStringAsFixed(1)}',
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1C1E),
            ),
          ),
          const SizedBox(height: 4.0),
          CupertinoButton.filled(
            pressedOpacity: value,
            onPressed: () => debugPrint('press opacity $value'),
            child: const Text('Press'),
          ),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 90.0,
            child: Text(
              feel,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10.0,
                color: Color(0xFF6E6E73),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget pressedOpacitySection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'pressedOpacity — the feel of the press',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            pressedTile(0.2, 'Very deep dip; reads as forceful.'),
            pressedTile(0.4, 'iOS default; familiar.'),
            pressedTile(0.6, 'Subtle dip; gentle CTA.'),
            pressedTile(0.8, 'Barely-there acknowledgement.'),
            pressedTile(1.0, 'No visual change on press.'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: borderRadius palette
  // ============================================================
  debugPrint('=== Section 6: borderRadius palette ===');

  Widget radiusTile(String label, BorderRadius radius) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: CupertinoColors.systemGrey4),
      ),
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1C1E),
            ),
          ),
          const SizedBox(height: 4.0),
          CupertinoButton.filled(
            borderRadius: radius,
            onPressed: () => debugPrint('radius $label pressed'),
            child: const Text('Tap'),
          ),
        ],
      ),
    );
  }

  final Widget radiusSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'borderRadius palette — from square to stadium',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: <Widget>[
            radiusTile('zero', BorderRadius.zero),
            radiusTile('4', BorderRadius.circular(4.0)),
            radiusTile('8', BorderRadius.circular(8.0)),
            radiusTile('16', BorderRadius.circular(16.0)),
            radiusTile('24', BorderRadius.circular(24.0)),
            radiusTile('40', BorderRadius.circular(40.0)),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Stadium-shaped CTAs (high radius) read as friendlier; sharper '
          'corners feel utilitarian and database-like.',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6E6E73),
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Custom padding
  // ============================================================
  debugPrint('=== Section 7: Custom padding ===');

  Widget paddingTile(String label, EdgeInsets pad) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: CupertinoColors.systemGrey4),
      ),
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1C1E),
            ),
          ),
          const SizedBox(height: 6.0),
          CupertinoButton.filled(
            padding: pad,
            onPressed: () => debugPrint('padding $label pressed'),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  final Widget paddingSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'padding — sculpting the tap target',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            paddingTile(
              'tight',
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            ),
            paddingTile(
              'comfy',
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            ),
            paddingTile(
              'roomy',
              const EdgeInsets.symmetric(horizontal: 40.0, vertical: 18.0),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Color + disabledColor
  // ============================================================
  debugPrint('=== Section 8: color and disabledColor ===');

  final Widget colorPairSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'color and disabledColor',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                CupertinoButton(
                  color: CupertinoColors.activeGreen,
                  onPressed: () => debugPrint('enabled green pressed'),
                  child: const Text(
                    'Enabled',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'color: activeGreen',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF6E6E73),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const CupertinoButton(
                  color: CupertinoColors.activeGreen,
                  disabledColor: CupertinoColors.systemGrey3,
                  onPressed: null,
                  child: Text(
                    'Disabled',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'disabledColor: systemGrey3',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF6E6E73),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'When onPressed is null the button paints disabledColor instead of '
          'color; the label opacity is also reduced.',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6E6E73),
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Embedded icons (Add / Share / Edit / Delete)
  // ============================================================
  debugPrint('=== Section 9: Embedded icon buttons ===');

  Widget iconButton(IconData icon, String label, Color tint) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      onPressed: () => debugPrint('icon $label pressed'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: tint, size: 18.0),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              color: tint,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  final Widget iconSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CupertinoButton with embedded icons',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: <Widget>[
            iconButton(CupertinoIcons.add, 'Add', CupertinoColors.systemBlue),
            iconButton(
              CupertinoIcons.share,
              'Share',
              CupertinoColors.systemIndigo,
            ),
            iconButton(
              CupertinoIcons.pencil,
              'Edit',
              CupertinoColors.systemOrange,
            ),
            iconButton(
              CupertinoIcons.trash,
              'Delete',
              CupertinoColors.systemRed,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Icon + label children are the canonical iOS pattern for action '
          'rows inside detail screens and toolbars.',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6E6E73),
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Inside CupertinoNavigationBar
  // ============================================================
  debugPrint('=== Section 10: Inside a navigation bar ===');

  final Widget navBarFrame = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          decoration: const BoxDecoration(
            color: CupertinoColors.systemGrey6,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => debugPrint('nav back pressed'),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.systemBlue,
                    ),
                    Text(
                      'Inbox',
                      style: TextStyle(color: CupertinoColors.systemBlue),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Message',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => debugPrint('nav compose pressed'),
                child: const Icon(
                  CupertinoIcons.pencil,
                  color: CupertinoColors.systemBlue,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(14.0),
          child: Text(
            'CupertinoButtons with padding:EdgeInsets.zero are the standard '
            'leading and trailing actions in a CupertinoNavigationBar.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF3A3A3C),
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Inside an ActionSheet-style frame
  // ============================================================
  debugPrint('=== Section 11: ActionSheet-style frame ===');

  Widget sheetAction(String label, Color tint, {bool bold = false}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: CupertinoColors.systemGrey4),
        ),
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        borderRadius: BorderRadius.zero,
        onPressed: () => debugPrint('sheet $label pressed'),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: tint,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final Widget actionSheetFrame = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ActionSheet-style stack',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Move file',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C1C1E),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Choose a destination folder.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF6E6E73),
                      ),
                    ),
                  ],
                ),
              ),
              sheetAction('Documents', CupertinoColors.systemBlue),
              sheetAction('Archive', CupertinoColors.systemBlue),
              sheetAction(
                'Delete',
                CupertinoColors.systemRed,
                bold: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'CupertinoActionSheet uses its own action widget type, but the '
          'visual idiom — a stack of full-width Cupertino-styled press '
          'targets — looks identical.',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6E6E73),
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Composite — badge over a CupertinoButton
  // ============================================================
  debugPrint('=== Section 12: Badged button ===');

  final Widget badgedSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Composite — CupertinoButton + badge',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              CupertinoButton(
                color: CupertinoColors.systemBlue,
                borderRadius: BorderRadius.circular(14.0),
                onPressed: () => debugPrint('badged button pressed'),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.bell_fill,
                      color: CupertinoColors.white,
                      size: 18.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Notifications',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -4.0,
                right: -4.0,
                child: Container(
                  width: 22.0,
                  height: 22.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemRed,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CupertinoColors.white,
                      width: 2.0,
                    ),
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Stack a small dot or count over a CupertinoButton to advertise '
          'unread state without breaking the iOS look.',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6E6E73),
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 13: Real-world micro-app — Reminders
  // ============================================================
  debugPrint('=== Section 13: Reminders micro-app ===');

  Widget reminderRow(String title, String due, IconData icon, Color tint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: tint, size: 20.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                Text(
                  due,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF6E6E73),
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => debugPrint('complete $title'),
            child: const Icon(
              CupertinoIcons.circle,
              color: CupertinoColors.systemBlue,
            ),
          ),
        ],
      ),
    );
  }

  final Widget remindersApp = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: CupertinoColors.black.withValues(alpha: 0.08),
          blurRadius: 12.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          decoration: const BoxDecoration(
            color: CupertinoColors.systemGrey6,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(18.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => debugPrint('reminders edit pressed'),
                child: const Text(
                  'Edit',
                  style: TextStyle(color: CupertinoColors.systemBlue),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Reminders',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => debugPrint('reminders new pressed'),
                child: const Icon(
                  CupertinoIcons.add,
                  color: CupertinoColors.systemBlue,
                ),
              ),
            ],
          ),
        ),
        reminderRow(
          'Renew passport',
          'Today, 5:00 PM',
          CupertinoIcons.airplane,
          CupertinoColors.systemBlue,
        ),
        reminderRow(
          'Submit timesheet',
          'Tomorrow, 9:00 AM',
          CupertinoIcons.clock,
          CupertinoColors.systemOrange,
        ),
        reminderRow(
          'Call dentist',
          'Friday',
          CupertinoIcons.phone,
          CupertinoColors.systemPink,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton.tinted(
                onPressed: () => debugPrint('reminders later pressed'),
                child: const Text('Snooze all'),
              ),
              CupertinoButton.filled(
                onPressed: () => debugPrint('reminders complete pressed'),
                child: const Text('Complete day'),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 14: Cheat-sheet card
  // ============================================================
  debugPrint('=== Section 14: Cheat sheet ===');

  Widget cheatRow(String name, String effect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
                fontFamily: 'Menlo',
              ),
            ),
          ),
          Expanded(
            child: Text(
              effect,
              style: const TextStyle(
                fontSize: 12.0,
                color: Color(0xFF3A3A3C),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget cheatSheet = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Parameter cheat sheet',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8.0),
        cheatRow('onPressed', 'Tap callback; null disables the button.'),
        cheatRow('padding', 'Inner spacing around the child / tap target.'),
        cheatRow('color', 'Background fill; default leaves it text-only.'),
        cheatRow('disabledColor', 'Background when onPressed is null.'),
        cheatRow('pressedOpacity', 'Opacity dip on press (0..1, default 0.4).'),
        cheatRow('borderRadius', 'Rounding of the filled rectangle.'),
        cheatRow('alignment', 'Aligns the child within the press surface.'),
        cheatRow('sizeStyle', 'small / medium / large iOS size class.'),
        cheatRow('focusNode', 'Accept focus for keyboard navigation.'),
        cheatRow('.filled', 'Named ctor: emphasised primary CTA.'),
        cheatRow('.tinted', 'Named ctor: muted secondary CTA.'),
      ],
    ),
  );

  // ============================================================
  // Alignment + focusNode demonstration (extra detail)
  // ============================================================
  debugPrint('=== Extra: alignment and focusNode ===');

  final FocusNode demoFocusNode = FocusNode(debugLabel: 'CupertinoButtonFocus');

  final Widget alignmentSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'alignment and focusNode',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton.filled(
            alignment: Alignment.centerLeft,
            focusNode: demoFocusNode,
            onPressed: () => debugPrint('alignment demo pressed'),
            child: const Text('Left-aligned child'),
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'alignment lets you push the child off-centre inside a wide button. '
          'focusNode enables keyboard-driven focus highlight on iPad and Mac.',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6E6E73),
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Compose the page
  // ============================================================
  debugPrint('Composing the page');

  final List<Widget> sections = <Widget>[
    heroHeader,
    anatomyCard,
    variantsRow,
    sizeStyleSection,
    pressedOpacitySection,
    radiusSection,
    paddingSection,
    colorPairSection,
    iconSection,
    navBarFrame,
    actionSheetFrame,
    badgedSection,
    remindersApp,
    alignmentSection,
    cheatSheet,
  ];

  return Scaffold(
    backgroundColor: const Color(0xFFF2F2F7),
    appBar: AppBar(
      title: const Text('CupertinoButton field guide'),
      backgroundColor: const Color(0xFF0A84FF),
      foregroundColor: CupertinoColors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sections,
      ),
    ),
  );
}
