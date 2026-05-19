// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for Flutter LicensePage.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LicensePage Deep Demo executing');

  // ============================================================
  // Palette - Material deep purple / indigo family
  // ============================================================
  final Color deepPurple = Color(0xFF512DA8);
  final Color deepPurpleDark = Color(0xFF311B92);
  final Color indigo = Color(0xFF3949AB);
  final Color indigoLight = Color(0xFF7986CB);
  final Color purpleAccent = Color(0xFFD1C4E9);
  final Color amberAccent = Color(0xFFFFB300);
  final Color tealAccent = Color(0xFF26A69A);
  final Color pinkAccent = Color(0xFFEC407A);
  final Color slateBg = Color(0xFFF3F1FA);
  final Color slateBorder = Color(0xFFB39DDB);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');
  final Widget titleBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 36.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          deepPurpleDark,
          deepPurple,
          indigo,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: indigo.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.gavel_rounded,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LicensePage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Deep Visual Demo - Material master/detail license browser',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _chipWhite('package:flutter/material.dart'),
            _chipWhite('LicensePage'),
            _chipWhite('LicenseRegistry'),
            _chipWhite('showLicensePage()'),
            _chipWhite('AboutDialog companion'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy - master/detail layout diagram
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');
  final Widget anatomy = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          purpleAccent.withValues(alpha: 0.4),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: slateBorder, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          icon: Icons.dashboard_rounded,
          color: deepPurple,
          title: 'Section 2 - Anatomy',
          subtitle: 'Two-pane master/detail layout',
        ),
        SizedBox(height: 18.0),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: slateBg,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: slateBorder, width: 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: deepPurple.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: deepPurple, width: 1.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MASTER',
                        style: TextStyle(
                          color: deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'Header card\n(name, version,\nicon, legalese)',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(height: 8.0),
                      Divider(color: deepPurple.withValues(alpha: 0.4)),
                      Text('flutter', style: TextStyle(fontSize: 11.0)),
                      Text('http', style: TextStyle(fontSize: 11.0)),
                      Text('sqflite', style: TextStyle(fontSize: 11.0)),
                      Text('dio', style: TextStyle(fontSize: 11.0)),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: indigo.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: indigo, width: 1.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DETAIL',
                        style: TextStyle(
                          color: indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'Selectable license body\nrendered as paragraphs',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        height: 6.0,
                        color: indigo.withValues(alpha: 0.3),
                      ),
                      SizedBox(height: 6.0),
                      Container(
                        height: 6.0,
                        width: 160.0,
                        color: indigo.withValues(alpha: 0.3),
                      ),
                      SizedBox(height: 6.0),
                      Container(
                        height: 6.0,
                        width: 120.0,
                        color: indigo.withValues(alpha: 0.3),
                      ),
                      SizedBox(height: 6.0),
                      Container(
                        height: 6.0,
                        width: 200.0,
                        color: indigo.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'On wide screens both panes are shown side by side. On narrow screens '
          'the master is shown first and the detail opens as a sub-route.',
          style: TextStyle(fontSize: 13.0, color: Colors.black87),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Real LicensePage rendered inline
  // ============================================================
  print('=== Section 3: Real LicensePage inline ===');
  final Widget realLicensePage = LicensePage(
    applicationName: 'Tom Demo',
    applicationVersion: '1.0.0',
    applicationLegalese: 'Copyright 2026 Tom Workspace.',
    applicationIcon: Padding(
      padding: EdgeInsets.all(8.0),
      child: FlutterLogo(size: 56.0),
    ),
  );

  final Widget realLicensePageCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          indigoLight.withValues(alpha: 0.18),
          deepPurple.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: indigo, width: 1.3),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.25),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          icon: Icons.preview_rounded,
          color: indigo,
          title: 'Section 3 - Live LicensePage',
          subtitle: 'Embedded with applicationName "Tom Demo"',
        ),
        SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: slateBorder, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.0),
            child: SizedBox(
              height: 600.0,
              child: realLicensePage,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Field showcase - 4 cards each rendering a preview
  // ============================================================
  print('=== Section 4: Field showcase ===');
  final Widget fieldShowcase = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          deepPurple.withValues(alpha: 0.06),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: slateBorder, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          icon: Icons.tune_rounded,
          color: deepPurple,
          title: 'Section 4 - Field Showcase',
          subtitle: 'Each card isolates one constructor parameter',
        ),
        SizedBox(height: 16.0),
        _fieldCard(
          color: deepPurple,
          accent: amberAccent,
          label: 'applicationName',
          desc: 'Shown as the page title and master header text.',
          page: LicensePage(applicationName: 'Name Only'),
        ),
        SizedBox(height: 14.0),
        _fieldCard(
          color: indigo,
          accent: tealAccent,
          label: 'applicationVersion',
          desc: 'Rendered as the version subtitle below the name.',
          page: LicensePage(
            applicationName: 'Versioned',
            applicationVersion: 'v2.7.3',
          ),
        ),
        SizedBox(height: 14.0),
        _fieldCard(
          color: deepPurpleDark,
          accent: pinkAccent,
          label: 'applicationIcon',
          desc: 'Any Widget; usually FlutterLogo, Image.asset or AssetImage.',
          page: LicensePage(
            applicationName: 'With Icon',
            applicationIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: FlutterLogo(size: 48.0),
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _fieldCard(
          color: indigoLight,
          accent: amberAccent,
          label: 'applicationLegalese',
          desc: 'Free-form copyright/legal blurb shown under the name.',
          page: LicensePage(
            applicationName: 'Legalese',
            applicationLegalese:
                'Copyright 2026 Demo Corp. All rights reserved.',
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: showLicensePage() integration
  // ============================================================
  print('=== Section 5: showLicensePage integration ===');
  final Widget integration = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          deepPurpleDark,
          indigo,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: deepPurpleDark.withValues(alpha: 0.4),
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
            Icon(Icons.code_rounded, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Section 5 - showLicensePage() wiring',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'The convenience function pushes a LicensePage as a route. Wire it '
          'to a button onPressed to expose licenses from your settings menu.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.0,
            ),
          ),
          child: Text(
            'ElevatedButton(\n'
            '  onPressed: () => showLicensePage(\n'
            '    context: context,\n'
            '    applicationName: "Tom Demo",\n'
            '    applicationVersion: "1.0.0",\n'
            '    applicationIcon: FlutterLogo(size: 48),\n'
            '    applicationLegalese: "Copyright 2026 Tom",\n'
            '  ),\n'
            '  child: Text("Open Licenses"),\n'
            ')',
            style: TextStyle(
              color: Color(0xFFE1BEE7),
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: amberAccent,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: amberAccent.withValues(alpha: 0.6),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.open_in_new, size: 16.0, color: Colors.black87),
                  SizedBox(width: 6.0),
                  Text(
                    'Open Licenses',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              '-> pushes LicensePage as a Material route',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: LicenseRegistry.addLicense()
  // ============================================================
  print('=== Section 6: LicenseRegistry ===');
  final Widget registry = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          tealAccent.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: tealAccent, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: tealAccent.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          icon: Icons.library_books_rounded,
          color: tealAccent,
          title: 'Section 6 - LicenseRegistry.addLicense()',
          subtitle: 'This is what populates LicensePage with entries',
        ),
        SizedBox(height: 14.0),
        Text(
          'Plugins call LicenseRegistry.addLicense(...) at startup to register '
          'their license text. LicensePage simply reads from the registry.',
          style: TextStyle(fontSize: 13.0),
        ),
        SizedBox(height: 14.0),
        _registryEntry(
          color: deepPurple,
          name: 'flutter',
          summary: 'BSD-3-Clause',
          snippet: 'Copyright 2014 The Flutter Authors. All rights reserved.',
        ),
        SizedBox(height: 10.0),
        _registryEntry(
          color: indigo,
          name: 'sqflite',
          summary: 'BSD-2-Clause',
          snippet: 'Copyright 2017, the SQFlite project authors.',
        ),
        SizedBox(height: 10.0),
        _registryEntry(
          color: pinkAccent,
          name: 'http',
          summary: 'BSD-3-Clause',
          snippet: 'Copyright 2014 the Dart project authors. All rights '
              'reserved.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Mock master/detail with 4 fake packages
  // ============================================================
  print('=== Section 7: Mock master/detail ===');
  final Widget mockMasterDetail = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          purpleAccent.withValues(alpha: 0.45),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: deepPurple, width: 1.3),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.22),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          icon: Icons.view_column_rounded,
          color: deepPurpleDark,
          title: 'Section 7 - Mock master/detail',
          subtitle: 'Faux UI showing how the page is composed',
        ),
        SizedBox(height: 16.0),
        Container(
          height: 320.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: slateBorder, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: slateBg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.0),
                      bottomLeft: Radius.circular(13.0),
                    ),
                    border: Border(
                      right: BorderSide(color: slateBorder, width: 1.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [deepPurple, indigo],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tom Demo',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              '1.0.0',
                              style: TextStyle(
                                color: Colors.white
                                    .withValues(alpha: 0.85),
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _mockRow('flutter', '1 license', deepPurple, true),
                      _mockRow('sqflite', '1 license', deepPurple, false),
                      _mockRow('http', '1 license', deepPurple, false),
                      _mockRow('dio', '2 licenses', deepPurple, false),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'flutter',
                        style: TextStyle(
                          color: deepPurpleDark,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'BSD 3-Clause License',
                        style: TextStyle(
                          color: indigo,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        'Copyright 2014 The Flutter Authors. All rights '
                        'reserved.\n\nRedistribution and use in source and '
                        'binary forms, with or without modification, are '
                        'permitted provided that the following conditions '
                        'are met...',
                        style: TextStyle(fontSize: 12.0, height: 1.45),
                      ),
                    ],
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
  // SECTION 8: Localization
  // ============================================================
  print('=== Section 8: Localization ===');
  final Widget localization = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          indigoLight.withValues(alpha: 0.20),
          purpleAccent.withValues(alpha: 0.30),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: indigoLight, width: 1.3),
      boxShadow: [
        BoxShadow(
          color: indigoLight.withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          icon: Icons.translate_rounded,
          color: indigo,
          title: 'Section 8 - Localization',
          subtitle: 'MaterialLocalizations supplies all strings',
        ),
        SizedBox(height: 14.0),
        _localeRow('en', 'Licenses', 'Powered by Flutter', indigo),
        _localeRow('de', 'Lizenzen', 'Mit Flutter erstellt', deepPurple),
        _localeRow('fr', 'Licences', 'Propulsé par Flutter', pinkAccent),
        _localeRow('ja', 'ライセンス', 'Flutter で動作', tealAccent),
        SizedBox(height: 10.0),
        Text(
          'Add MaterialApp(localizationsDelegates: ...) and the LicensePage '
          'automatically translates its UI chrome.',
          style: TextStyle(fontSize: 12.5, color: Colors.black87),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');
  final Widget footguns = Container(
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
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: amberAccent, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: amberAccent.withValues(alpha: 0.35),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          icon: Icons.warning_amber_rounded,
          color: Color(0xFFE65100),
          title: 'Section 9 - Footguns',
          subtitle: 'What bites teams using LicensePage',
        ),
        SizedBox(height: 14.0),
        _footgun(
          'Master/detail needs space',
          'LicensePage assumes a full Scaffold body. Embedding it in a small '
              'box clips both panes. Always give it >= 600 dp height.',
        ),
        SizedBox(height: 10.0),
        _footgun(
          'License text is selectable',
          'Body text uses SelectableText. Don\'t wrap in widgets that swallow '
              'pointer events or selection breaks.',
        ),
        SizedBox(height: 10.0),
        _footgun(
          'applicationName must match AboutDialog',
          'If you also use AboutDialog or showAboutDialog, keep the name '
              'identical so users see one consistent identity.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');
  final Widget recap = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          deepPurple,
          indigo,
          deepPurpleDark,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: indigo.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark_rounded, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Section 10 - Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recapBullet('LicensePage is the canonical OSS-license screen'),
        _recapBullet('Four optional fields: name, version, icon, legalese'),
        _recapBullet('Master/detail layout reads from LicenseRegistry'),
        _recapBullet('Companion to AboutDialog and showLicensePage()'),
        _recapBullet('Localized via MaterialLocalizations automatically'),
        _recapBullet('Selectable, scrollable, accessible by default'),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            'Demo complete - LicensePage Deep Demo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
        ),
      ],
    ),
  );

  print('LicensePage Deep Demo complete');
  return Scaffold(
    backgroundColor: slateBg,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 22.0),
          anatomy,
          SizedBox(height: 22.0),
          realLicensePageCard,
          SizedBox(height: 22.0),
          fieldShowcase,
          SizedBox(height: 22.0),
          integration,
          SizedBox(height: 22.0),
          registry,
          SizedBox(height: 22.0),
          mockMasterDetail,
          SizedBox(height: 22.0),
          localization,
          SizedBox(height: 22.0),
          footguns,
          SizedBox(height: 22.0),
          recap,
          SizedBox(height: 20.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers - small inline widgets to keep the build readable
// ============================================================

Widget _chipWhite(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.45),
        width: 1.0,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _sectionHeading({
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
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
                color: color,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _fieldCard({
  required Color color,
  required Color accent,
  required String label,
  required String desc,
  required Widget page,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  desc,
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #46, P2):
        // The original `SizedBox(height: 240)` was too tight for the
        // tallest LicensePage configurations: each of the four
        // `_fieldCard` calls passes a slightly different LicensePage
        // (Name Only, Versioned, With Icon (FlutterLogo size 48 in 8 px
        // padding), Legalese) whose internal master/body layout exceeds
        // 240 px by 26 / 64 / 90 / 42 px respectively (4 distinct
        // bottom-overflow assertions per build). Bumped the clamp to
        // 340 px — the largest overflow + small breathing margin — so
        // every variant lays out inside the card.
        SizedBox(
          height: 340.0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(13.0),
              bottomRight: Radius.circular(13.0),
            ),
            child: page,
          ),
        ),
      ],
    ),
  );
}

Widget _registryEntry({
  required Color color,
  required String name,
  required String summary,
  required String snippet,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.20),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(Icons.description_rounded, color: color, size: 20.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      summary,
                      style: TextStyle(
                        color: color,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                snippet,
                style: TextStyle(fontSize: 11.5, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _mockRow(String name, String count, Color color, bool selected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: selected ? color.withValues(alpha: 0.15) : Colors.transparent,
      border: Border(
        bottom: BorderSide(color: color.withValues(alpha: 0.15), width: 0.5),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: selected ? color : color.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              color: selected ? color : Colors.black87,
              fontSize: 13.0,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          count,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );
}

Widget _localeRow(String code, String label, String legalese, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 36.0,
          padding: EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            legalese,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _footgun(String title, String body) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.error_outline, color: Color(0xFFE65100), size: 20.0),
      SizedBox(width: 10.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
                color: Color(0xFFBF360C),
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              body,
              style: TextStyle(fontSize: 12.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
