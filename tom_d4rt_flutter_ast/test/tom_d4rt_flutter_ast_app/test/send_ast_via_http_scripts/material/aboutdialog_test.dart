// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AboutDialog from Flutter material
// Deep Demo: Visual demonstration of AboutDialog widget rendered inline,
// field showcase, prebuilt variants, showAboutDialog() integration code,
// AboutListTile companion, license page reference, and footguns guide.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AboutDialog Deep Demo executing');

  // ============================================================
  // Color palette: Material purple/blue for the entire demo
  // ============================================================
  final purplePrimary = Colors.deepPurple;
  final purpleSoft = Colors.deepPurple.shade100;
  final purpleDark = Colors.deepPurple.shade900;
  final bluePrimary = Colors.indigo;

  // ============================================================
  // SECTION 1: Title Banner — Material-purple gradient
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.purple.shade400,
          Colors.indigo.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.6),
              width: 2.0,
            ),
          ),
          child: Icon(Icons.info_outline, size: 56.0, color: Colors.white),
        ),
        SizedBox(height: 16.0),
        Text(
          'AboutDialog',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Material pre-built dialog · App identity, legalese & licenses',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.88),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'package: flutter/material.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title banner created');

  // ============================================================
  // SECTION 2: Anatomy Diagram of AboutDialog layout
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: bluePrimary.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of AboutDialog',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: purpleDark,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _anatomyRow(
                Icons.image_outlined,
                'applicationIcon',
                'Widget? · Top-left visual mark',
                Colors.indigo,
              ),
              SizedBox(height: 8.0),
              _anatomyRow(
                Icons.label_important_outline,
                'applicationName',
                'String? · Bold heading next to icon',
                Colors.deepPurple,
              ),
              SizedBox(height: 8.0),
              _anatomyRow(
                Icons.numbers,
                'applicationVersion',
                'String? · Subtle subtitle',
                Colors.purple,
              ),
              SizedBox(height: 8.0),
              _anatomyRow(
                Icons.gavel,
                'applicationLegalese',
                'String? · Small print copyright',
                Colors.blueGrey,
              ),
              SizedBox(height: 8.0),
              _anatomyRow(
                Icons.view_list,
                'children',
                'List<Widget>? · Extra body content',
                Colors.teal,
              ),
              SizedBox(height: 8.0),
              _anatomyRow(
                Icons.menu_book,
                'View Licenses',
                'Auto button → opens LicensePage',
                Colors.orange,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: purpleSoft,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'All fields are optional. The dialog renders only what you give it.',
            style: TextStyle(
              fontSize: 12.0,
              color: purpleDark,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram created');

  // ============================================================
  // SECTION 3: Real AboutDialog rendered inline (360x500)
  // ============================================================
  print('=== Section 3: Real AboutDialog inline ===');

  final realAboutDialog = AboutDialog(
    applicationName: 'Tom Demo',
    applicationVersion: '1.0.0',
    applicationIcon: Container(
      width: 48.0,
      height: 48.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.4),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Icon(Icons.auto_awesome, color: Colors.white, size: 28.0),
    ),
    applicationLegalese:
        '\u00a9 2026 Tom AI Workspace. All trademarks belong to their respective owners.',
    children: [
      SizedBox(height: 16.0),
      Text(
        'Built with the Tom Framework — D4rt scripting, Flutter UI, '
        'and AI-driven workflows.',
        style: TextStyle(fontSize: 13.0, color: Colors.black87),
      ),
      SizedBox(height: 8.0),
      Text(
        'Visit the documentation for more details on the framework, '
        'guidelines, and quest-driven development.',
        style: TextStyle(fontSize: 12.0, color: Colors.black54),
      ),
    ],
  );
  print('AboutDialog instance constructed');

  final realInlineSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.indigo.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purplePrimary.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.2),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.dashboard, color: purpleDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Live AboutDialog (inline render)',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: purpleDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 18.0,
                  offset: Offset(0.0, 8.0),
                ),
                BoxShadow(
                  color: Colors.deepPurple.withValues(alpha: 0.12),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: SizedBox(
              width: 360.0,
              height: 500.0,
              child: realAboutDialog,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Tip: AboutDialog renders its complete content layout — icon, name, '
            'version, legalese, children, and "View Licenses" — inside any '
            'sized container without needing a Navigator.',
            style: TextStyle(fontSize: 12.0, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
  print('Live AboutDialog section created');

  // ============================================================
  // SECTION 4: Field Showcase — 5 cards, each shows ONE field's effect
  // ============================================================
  print('=== Section 4: Field showcase ===');

  final showcaseNameOnly = AboutDialog(applicationName: 'Name Only');
  final showcaseVersionOnly = AboutDialog(
    applicationName: 'Demo',
    applicationVersion: '7.2.1-beta',
  );
  final showcaseIconOnly = AboutDialog(
    applicationName: 'Icon Demo',
    applicationIcon: FlutterLogo(size: 40.0),
  );
  final showcaseLegaleseOnly = AboutDialog(
    applicationName: 'Legal Demo',
    applicationLegalese: '\u00a9 2026 Acme Industries — Patent Pending.',
  );
  final showcaseChildrenOnly = AboutDialog(
    applicationName: 'Children Demo',
    children: [
      SizedBox(height: 12.0),
      Text(
        'Custom child #1',
        style: TextStyle(fontSize: 13.0, color: Colors.black87),
      ),
      SizedBox(height: 6.0),
      Text(
        'Custom child #2',
        style: TextStyle(fontSize: 13.0, color: Colors.black87),
      ),
      SizedBox(height: 6.0),
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          'Children appear above the License button.',
          style: TextStyle(fontSize: 11.0, color: Colors.indigo),
        ),
      ),
    ],
  );
  print('Field showcase dialog instances built');

  final fieldShowcaseSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: bluePrimary.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Field Showcase — One field at a time',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: purpleDark,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            _showcaseCard(
              'applicationName',
              'Only the name set — version/icon defaults are blank.',
              Colors.deepPurple,
              showcaseNameOnly,
            ),
            _showcaseCard(
              'applicationVersion',
              'Subtle version subtitle below the name.',
              Colors.indigo,
              showcaseVersionOnly,
            ),
            _showcaseCard(
              'applicationIcon',
              'Leading icon next to the name (FlutterLogo here).',
              Colors.purple,
              showcaseIconOnly,
            ),
            _showcaseCard(
              'applicationLegalese',
              'Tiny legal text beneath the heading.',
              Colors.blueGrey,
              showcaseLegaleseOnly,
            ),
            _showcaseCard(
              'children',
              'Custom widgets inserted above the View Licenses button.',
              Colors.teal,
              showcaseChildrenOnly,
            ),
          ],
        ),
      ],
    ),
  );
  print('Field showcase section created');

  // ============================================================
  // SECTION 5: Three pre-built variants
  // ============================================================
  print('=== Section 5: Pre-built variants ===');

  final variantMinimal = AboutDialog(
    applicationName: 'Minimal',
    applicationVersion: '0.1.0',
  );

  final variantBranded = AboutDialog(
    applicationName: 'BrandX Studio',
    applicationVersion: '4.2.0',
    applicationIcon: Container(
      width: 44.0,
      height: 44.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade400, Colors.deepPurple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.45),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Icon(Icons.diamond, color: Colors.white, size: 24.0),
    ),
    applicationLegalese: '\u00a9 2026 BrandX. All rights reserved.',
  );

  final variantVerbose = AboutDialog(
    applicationName: 'VerboseApp',
    applicationVersion: '2.5.1',
    applicationIcon: Icon(
      Icons.menu_book,
      color: Colors.indigo,
      size: 40.0,
    ),
    applicationLegalese: '\u00a9 2026 VerboseApp Inc.',
    children: [
      SizedBox(height: 14.0),
      Text(
        'FAQ',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
      ),
      SizedBox(height: 6.0),
      Text(
        'Q: How do I update? A: Use the in-app updater.',
        style: TextStyle(fontSize: 11.0),
      ),
      SizedBox(height: 4.0),
      Text(
        'Q: Where are my settings? A: Drawer → Settings.',
        style: TextStyle(fontSize: 11.0),
      ),
      SizedBox(height: 4.0),
      Text(
        'Q: How do I report a bug? A: Help → Report.',
        style: TextStyle(fontSize: 11.0),
      ),
    ],
  );
  print('Three variants built');

  final variantsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purplePrimary.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pre-built Variants',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: purpleDark,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          alignment: WrapAlignment.center,
          children: [
            _variantPreviewCard(
              'Minimal',
              'Name + version only',
              Colors.indigo,
              Icons.minimize,
              variantMinimal,
            ),
            _variantPreviewCard(
              'Branded with logo',
              'Name + version + custom logo + legalese',
              Colors.pink,
              Icons.brush,
              variantBranded,
            ),
            _variantPreviewCard(
              'Verbose with FAQ',
              'Full set + several FAQ children',
              Colors.teal,
              Icons.menu_book,
              variantVerbose,
            ),
          ],
        ),
      ],
    ),
  );
  print('Variants section created');

  // ============================================================
  // SECTION 6: showAboutDialog() integration code-block
  // ============================================================
  print('=== Section 6: showAboutDialog code block ===');

  final showAboutCode = '// Open the dialog imperatively from a button:\n'
      'showAboutDialog(\n'
      '  context: context,\n'
      '  applicationName: "Tom Demo",\n'
      '  applicationVersion: "1.0.0",\n'
      '  applicationIcon: Icon(Icons.auto_awesome),\n'
      '  applicationLegalese: "\u00a9 2026 Tom AI",\n'
      '  children: [\n'
      '    Text("Custom info block."),\n'
      '  ],\n'
      ');';

  final showAboutSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.indigo.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
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
            Icon(Icons.terminal, color: Colors.cyan.shade300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'showAboutDialog() — imperative entry point',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade100,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.cyan.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            showAboutCode,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent.shade100,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'showAboutDialog() internally wraps AboutDialog inside showDialog() '
            'and supplies the Material barrier + transitions for free.',
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          ),
        ),
      ],
    ),
  );
  print('showAboutDialog code section created');

  // ============================================================
  // SECTION 7: AboutListTile companion
  // ============================================================
  print('=== Section 7: AboutListTile companion ===');

  final mockDrawer = Container(
    width: 260.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          height: 110.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.bottomLeft,
          child: Text(
            'Drawer Header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home, color: purplePrimary),
          title: Text('Home'),
        ),
        ListTile(
          leading: Icon(Icons.settings, color: purplePrimary),
          title: Text('Settings'),
        ),
        Divider(height: 1.0),
        AboutListTile(
          icon: Icon(Icons.info_outline, color: purplePrimary),
          applicationName: 'Tom Demo',
          applicationVersion: '1.0.0',
          applicationLegalese: '\u00a9 2026 Tom AI',
          aboutBoxChildren: [
            SizedBox(height: 12.0),
            Text(
              'Embedded directly in the drawer.',
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ],
    ),
  );

  final aboutListTileSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purplePrimary.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AboutListTile — Drawer companion',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: purpleDark,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'AboutListTile is a Material list tile that, when tapped, calls '
          'showAboutDialog() with the same configuration. Drop it into a '
          'Drawer to give users a one-tap "About" entry.',
          style: TextStyle(fontSize: 13.0, color: Colors.black87),
        ),
        SizedBox(height: 16.0),
        Center(child: mockDrawer),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.amber.shade800, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Tip: pass aboutBoxChildren to populate the About dialog\'s '
                  'children when the tile is tapped.',
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('AboutListTile section created');

  // ============================================================
  // SECTION 8: License page link
  // ============================================================
  print('=== Section 8: License page ===');

  final licensePageSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.25),
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
            Icon(Icons.menu_book, color: Colors.orange.shade900, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'View Licenses → LicensePage',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'AboutDialog automatically renders a "View Licenses" button. Tapping '
          'it pushes a LicensePage which lists every entry registered in '
          'LicenseRegistry — including the Flutter SDK and your dependencies.',
          style: TextStyle(fontSize: 13.0, color: Colors.black87),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.orange.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.list_alt, color: Colors.orange, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'LicenseRegistry entries',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              _licenseRow('Flutter SDK', 'BSD-3-Clause'),
              _licenseRow('Material Icons', 'Apache-2.0'),
              _licenseRow('Roboto Font', 'Apache-2.0'),
              _licenseRow('Your packages', 'depends on each pubspec'),
              _licenseRow('Custom entries', 'LicenseRegistry.addLicense(...)'),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade200.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Add custom licenses by calling LicenseRegistry.addLicense(...) '
            'before runApp() — they will appear automatically.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.brown.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('License page section created');

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final footgunsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
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
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _footgunRow(
          'Nullable applicationName',
          'When omitted, Flutter falls back to the platform/runtime name. '
          'The dialog title becomes "About <fallback>" — usually not what '
          'you want for branded apps.',
          Colors.red,
        ),
        SizedBox(height: 10.0),
        _footgunRow(
          'Legalese is small print only',
          'applicationLegalese is rendered with a small, low-contrast style. '
          'Do not stuff long terms-of-service or critical info there — users '
          'will skip it. Use children for actual prose.',
          Colors.deepOrange,
        ),
        SizedBox(height: 10.0),
        _footgunRow(
          'Dialog is immutable after open',
          'AboutDialog reads its props at build time. Once visible, you cannot '
          'edit name/version/legalese; you must dismiss and re-show with new '
          'arguments.',
          Colors.orange,
        ),
        SizedBox(height: 10.0),
        _footgunRow(
          'Children appear ABOVE the License button',
          'Order matters: children render between the legalese and the '
          '"View Licenses" button. Plan layout accordingly.',
          Colors.brown,
        ),
        SizedBox(height: 10.0),
        _footgunRow(
          'No onClose callback',
          'AboutDialog has no built-in close hook. If you need to react to '
          'dismissal, await showAboutDialog() and act on the future\'s '
          'completion.',
          Colors.purple,
        ),
      ],
    ),
  );
  print('Footguns section created');

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');

  final recapSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade400,
          Colors.indigo.shade500,
          Colors.blue.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.fact_check, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
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
        _recapBullet(
          'AboutDialog is a Material pre-built dialog — drop in app metadata, '
          'get a polished About screen.',
        ),
        _recapBullet(
          'Five optional fields: applicationName, applicationVersion, '
          'applicationIcon, applicationLegalese, children.',
        ),
        _recapBullet(
          'A "View Licenses" button is rendered automatically and pushes a '
          'LicensePage backed by LicenseRegistry.',
        ),
        _recapBullet(
          'Open imperatively via showAboutDialog(context: ...). For drawers, '
          'use the AboutListTile companion.',
        ),
        _recapBullet(
          'Avoid stuffing critical info into legalese; use children for body '
          'content, and remember the dialog is immutable once open.',
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'AboutDialog · Material · Flutter',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Recap section created');

  print('AboutDialog Deep Demo completed successfully');

  // ============================================================
  // Final layout: Scaffold → SingleChildScrollView → Column
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          Text(
            '1. Title Banner',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            'Material-purple gradient header introducing the widget.',
            style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 24.0),
          Text(
            '2. Anatomy',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          anatomyDiagram,
          SizedBox(height: 24.0),
          Text(
            '3. Real AboutDialog (inline)',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          realInlineSection,
          SizedBox(height: 24.0),
          Text(
            '4. Field Showcase',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          fieldShowcaseSection,
          SizedBox(height: 24.0),
          Text(
            '5. Pre-built Variants',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          variantsSection,
          SizedBox(height: 24.0),
          Text(
            '6. showAboutDialog() Code',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          showAboutSection,
          SizedBox(height: 24.0),
          Text(
            '7. AboutListTile Companion',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          aboutListTileSection,
          SizedBox(height: 24.0),
          Text(
            '8. License Page',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          licensePageSection,
          SizedBox(height: 24.0),
          Text(
            '9. Footguns',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          footgunsSection,
          SizedBox(height: 24.0),
          Text(
            '10. Recap',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          recapSection,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helper: anatomy row
// ============================================================
Widget _anatomyRow(IconData icon, String label, String desc, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
        child: Icon(icon, color: color, size: 20.0),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              desc,
              style: TextStyle(fontSize: 11.0, color: Colors.black87),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================
// Helper: showcase card holding a real AboutDialog preview
// ============================================================
Widget _showcaseCard(
  String fieldLabel,
  String desc,
  Color color,
  Widget aboutDialog,
) {
  return Container(
    width: 320.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            fieldLabel,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          desc,
          style: TextStyle(fontSize: 11.0, color: Colors.black87),
        ),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: SizedBox(
            width: 296.0,
            height: 280.0,
            child: aboutDialog,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: variant preview card
// ============================================================
Widget _variantPreviewCard(
  String name,
  String tag,
  Color color,
  IconData icon,
  Widget aboutDialog,
) {
  return Container(
    width: 280.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          tag,
          style: TextStyle(fontSize: 11.0, color: Colors.black54),
        ),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: SizedBox(
            width: 256.0,
            height: 320.0,
            child: aboutDialog,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: license registry row
// ============================================================
Widget _licenseRow(String name, String license) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        Icon(Icons.circle, color: Colors.orange.shade400, size: 8.0),
        SizedBox(width: 6.0),
        SizedBox(
          width: 130.0,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            license,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: footgun row
// ============================================================
Widget _footgunRow(String title, String body, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.priority_high, color: color, size: 20.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: recap bullet
// ============================================================
Widget _recapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.white, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
