// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of ElevatedButton from material
// Sections: title banner, anatomy, defaults, palette, shapes, sizing,
// elevation, disabled vs enabled, icon variants, real-world groups,
// footguns, recap.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ElevatedButton Deep Demo executing');

  // ============================================================
  // SHARED CONSTANTS / THEME
  // ============================================================
  final Color emerald = Color(0xFF10B981);
  final Color emeraldDark = Color(0xFF047857);
  final Color teal = Color(0xFF0D9488);
  final Color slate = Color(0xFF334155);
  final Color amber = Color(0xFFF59E0B);
  final Color rose = Color(0xFFE11D48);
  final Color indigo = Color(0xFF4F46E5);

  print('Theme constants prepared');

  // ============================================================
  // SECTION 1: TITLE BANNER
  // ============================================================
  print('=== Section 1: Title banner ===');

  final Widget titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [emeraldDark, teal, indigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: emerald.withValues(alpha: 0.4),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: indigo.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 4.0),
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
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(
                Icons.touch_app,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ElevatedButton',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'Material 3 prominent action — Deep Demo',
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
        SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildBadge('onPressed', Colors.white),
            _buildBadge('style', Colors.white),
            _buildBadge('child', Colors.white),
            _buildBadge('.icon', Colors.white),
            _buildBadge('styleFrom', Colors.white),
            _buildBadge('elevation', Colors.white),
            _buildBadge('shape', Colors.white),
          ],
        ),
      ],
    ),
  );
  print('Title banner created');

  // ============================================================
  // SECTION 2: ANATOMY DIAGRAM
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, emerald.withValues(alpha: 0.06)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: emerald.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: emerald.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('2. Anatomy', emerald, Icons.architecture),
        SizedBox(height: 16.0),
        Container(
          height: 220.0,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: Stack(
            children: [
              // The faux button frame
              Center(
                child: Container(
                  width: 220.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [emerald, emeraldDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28.0),
                    boxShadow: [
                      BoxShadow(
                        color: emerald.withValues(alpha: 0.5),
                        blurRadius: 16.0,
                        offset: Offset(0.0, 8.0),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send, color: Colors.white, size: 20.0),
                      SizedBox(width: 8.0),
                      Text(
                        'LABEL',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Annotation: shadow
              Positioned(
                left: 8.0,
                top: 8.0,
                child: _buildAnnotation('Elevation shadow', amber),
              ),
              // Annotation: label
              Positioned(
                right: 8.0,
                top: 8.0,
                child: _buildAnnotation('Label text', indigo),
              ),
              // Annotation: icon
              Positioned(
                left: 8.0,
                bottom: 8.0,
                child: _buildAnnotation('Optional icon', teal),
              ),
              // Annotation: ripple
              Positioned(
                right: 8.0,
                bottom: 8.0,
                child: _buildAnnotation('Ripple region', rose),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _buildCodeStrip(
          'ElevatedButton(onPressed: fn, style: ButtonStyle, child: Widget)',
          slate,
        ),
      ],
    ),
  );
  print('Anatomy diagram created');

  // ============================================================
  // SECTION 3: DEFAULT VARIANTS
  // ============================================================
  print('=== Section 3: Default variants ===');

  final Widget defaultsBasic = ElevatedButton(
    onPressed: () {
      print('clicked basic');
    },
    child: Text('Basic Button'),
  );

  final Widget defaultsIcon = ElevatedButton.icon(
    onPressed: () {
      print('clicked icon');
    },
    icon: Icon(Icons.send),
    label: Text('Send'),
  );

  final Widget defaultsIconOnly = ElevatedButton(
    onPressed: () {
      print('clicked iconOnly');
    },
    style: ElevatedButton.styleFrom(
      shape: CircleBorder(),
      padding: EdgeInsets.all(16.0),
    ),
    child: Icon(Icons.favorite),
  );

  final Widget defaultsSection = _buildCard(
    title: '3. Defaults — three variants',
    icon: Icons.widgets,
    accent: emerald,
    child: Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultsBasic,
            SizedBox(height: 6.0),
            _buildCaption('text label'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultsIcon,
            SizedBox(height: 6.0),
            _buildCaption('.icon → icon + label'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultsIconOnly,
            SizedBox(height: 6.0),
            _buildCaption('icon-only (CircleBorder)'),
          ],
        ),
      ],
    ),
  );
  print('Defaults section created');

  // ============================================================
  // SECTION 4: COLOR PALETTE GRID
  // ============================================================
  print('=== Section 4: Color palette ===');

  final List<Map<String, Object>> paletteData = <Map<String, Object>>[
    <String, Object>{'name': 'emerald', 'bg': emerald, 'fg': Colors.white},
    <String, Object>{'name': 'teal', 'bg': teal, 'fg': Colors.white},
    <String, Object>{'name': 'indigo', 'bg': indigo, 'fg': Colors.white},
    <String, Object>{'name': 'amber', 'bg': amber, 'fg': Colors.black87},
    <String, Object>{'name': 'rose', 'bg': rose, 'fg': Colors.white},
    <String, Object>{'name': 'slate', 'bg': slate, 'fg': Colors.white},
    <String, Object>{
      'name': 'sky',
      'bg': Color(0xFF0EA5E9),
      'fg': Colors.white,
    },
    <String, Object>{
      'name': 'lime',
      'bg': Color(0xFF84CC16),
      'fg': Colors.black87,
    },
  ];

  final List<Widget> paletteButtons = <Widget>[];
  for (int i = 0; i < paletteData.length; i++) {
    final Map<String, Object> p = paletteData[i];
    final Color bg = p['bg'] as Color;
    final Color fg = p['fg'] as Color;
    final String name = p['name'] as String;
    print('palette[$i] -> $name');

    paletteButtons.add(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              print('clicked palette $name');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: bg,
              foregroundColor: fg,
              padding: EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 4.0),
          _buildCaption('#${bg.value.toRadixString(16).substring(2)}'),
        ],
      ),
    );
  }

  final Widget paletteSection = _buildCard(
    title: '4. styleFrom: backgroundColor / foregroundColor',
    icon: Icons.palette,
    accent: teal,
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: paletteButtons,
    ),
  );
  print('Palette section created with ${paletteButtons.length} buttons');

  // ============================================================
  // SECTION 5: SHAPES
  // ============================================================
  print('=== Section 5: Shapes ===');

  final Widget shapeRounded = ElevatedButton(
    onPressed: () {
      print('clicked rounded');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: emerald,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    child: Text('Rounded'),
  );

  final Widget shapeStadium = ElevatedButton(
    onPressed: () {
      print('clicked stadium');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: teal,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      shape: StadiumBorder(),
    ),
    child: Text('Stadium'),
  );

  final Widget shapeBeveled = ElevatedButton(
    onPressed: () {
      print('clicked beveled');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: indigo,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child: Text('Beveled'),
  );

  final Widget shapeContinuous = ElevatedButton(
    onPressed: () {
      print('clicked continuous');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: amber,
      foregroundColor: Colors.black87,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
    ),
    child: Text('Continuous'),
  );

  final Widget shapeRectangle = ElevatedButton(
    onPressed: () {
      print('clicked rectangle');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: rose,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
    child: Text('Rectangle'),
  );

  final Widget shapesSection = _buildCard(
    title: '5. styleFrom: shape variations',
    icon: Icons.crop_square,
    accent: indigo,
    child: Column(
      children: [
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                shapeRounded,
                SizedBox(height: 4.0),
                _buildCaption('RoundedRectangleBorder'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                shapeStadium,
                SizedBox(height: 4.0),
                _buildCaption('StadiumBorder'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                shapeBeveled,
                SizedBox(height: 4.0),
                _buildCaption('BeveledRectangleBorder'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                shapeContinuous,
                SizedBox(height: 4.0),
                _buildCaption('ContinuousRectangleBorder'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                shapeRectangle,
                SizedBox(height: 4.0),
                _buildCaption('Sharp Rectangle'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
  print('Shapes section created');

  // ============================================================
  // SECTION 6: PADDING & MIN-SIZE
  // ============================================================
  print('=== Section 6: Padding / minimumSize ===');

  final Widget sizeSmall = ElevatedButton(
    onPressed: () {
      print('clicked small');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: emerald,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      minimumSize: Size(60.0, 28.0),
      textStyle: TextStyle(fontSize: 11.0),
    ),
    child: Text('Small'),
  );

  final Widget sizeRegular = ElevatedButton(
    onPressed: () {
      print('clicked regular');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: emerald,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      minimumSize: Size(96.0, 40.0),
    ),
    child: Text('Regular'),
  );

  final Widget sizeLarge = ElevatedButton(
    onPressed: () {
      print('clicked large');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: emerald,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
      minimumSize: Size(140.0, 52.0),
      textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    ),
    child: Text('Large'),
  );

  final Widget sizeJumbo = ElevatedButton(
    onPressed: () {
      print('clicked jumbo');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: emeraldDark,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      minimumSize: Size(200.0, 72.0),
      textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    child: Text('JUMBO'),
  );

  final Widget sizingSection = _buildCard(
    title: '6. Padding & minimumSize variations',
    icon: Icons.aspect_ratio,
    accent: emerald,
    child: Wrap(
      spacing: 14.0,
      runSpacing: 14.0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [sizeSmall, SizedBox(height: 4.0), _buildCaption('60x28')],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            sizeRegular,
            SizedBox(height: 4.0),
            _buildCaption('96x40'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [sizeLarge, SizedBox(height: 4.0), _buildCaption('140x52')],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [sizeJumbo, SizedBox(height: 4.0), _buildCaption('200x72')],
        ),
      ],
    ),
  );
  print('Sizing section created');

  // ============================================================
  // SECTION 7: ELEVATION ROW
  // ============================================================
  print('=== Section 7: Elevation row ===');

  final List<double> elevationLevels = <double>[0.0, 2.0, 4.0, 8.0, 16.0];
  final List<Widget> elevationButtons = <Widget>[];
  for (int i = 0; i < elevationLevels.length; i++) {
    final double e = elevationLevels[i];
    print('elevation[$i] -> $e');
    elevationButtons.add(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              print('clicked elevation $e');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: emerald,
              foregroundColor: Colors.white,
              elevation: e,
              padding: EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
            ),
            child: Text('e=$e'),
          ),
          SizedBox(height: 6.0),
          Container(
            width: 80.0,
            height: 4.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  emerald.withValues(alpha: 0.0),
                  emerald.withValues(alpha: 0.3 + (e / 32.0)),
                ],
              ),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          SizedBox(height: 4.0),
          _buildCaption('${e.toStringAsFixed(0)} dp'),
        ],
      ),
    );
  }

  final Widget elevationSection = _buildCard(
    title: '7. Elevation: 0, 2, 4, 8, 16',
    icon: Icons.layers,
    accent: teal,
    child: Wrap(
      spacing: 14.0,
      runSpacing: 14.0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: elevationButtons,
    ),
  );
  print('Elevation section created');

  // ============================================================
  // SECTION 8: DISABLED VS ENABLED
  // ============================================================
  print('=== Section 8: Disabled vs enabled ===');

  final Widget enabledBtn = ElevatedButton(
    onPressed: () {
      print('clicked enabled');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: emerald,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    ),
    child: Text('Enabled'),
  );

  final Widget disabledBtn = ElevatedButton(
    onPressed: null,
    style: ElevatedButton.styleFrom(
      backgroundColor: emerald,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    ),
    child: Text('Disabled'),
  );

  final Widget enabledIcon = ElevatedButton.icon(
    onPressed: () {
      print('clicked enabled icon');
    },
    icon: Icon(Icons.check),
    label: Text('Submit'),
    style: ElevatedButton.styleFrom(
      backgroundColor: indigo,
      foregroundColor: Colors.white,
    ),
  );

  final Widget disabledIcon = ElevatedButton.icon(
    onPressed: null,
    icon: Icon(Icons.check),
    label: Text('Submit'),
    style: ElevatedButton.styleFrom(
      backgroundColor: indigo,
      foregroundColor: Colors.white,
    ),
  );

  final Widget enabledDisabledSection = _buildCard(
    title: '8. Disabled vs enabled',
    icon: Icons.toggle_on,
    accent: rose,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                enabledBtn,
                SizedBox(height: 6.0),
                _buildPill('onPressed: fn', emerald),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                disabledBtn,
                SizedBox(height: 6.0),
                _buildPill('onPressed: null', Colors.grey),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                enabledIcon,
                SizedBox(height: 6.0),
                _buildPill('icon enabled', indigo),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                disabledIcon,
                SizedBox(height: 6.0),
                _buildPill('icon disabled', Colors.grey),
              ],
            ),
          ],
        ),
      ],
    ),
  );
  print('Enabled/disabled section created');

  // ============================================================
  // SECTION 9: ICON VARIANTS
  // ============================================================
  print('=== Section 9: Icon variants ===');

  final Widget iconLeading = ElevatedButton.icon(
    onPressed: () {
      print('clicked leading');
    },
    icon: Icon(Icons.cloud_download),
    label: Text('Download'),
    style: ElevatedButton.styleFrom(
      backgroundColor: teal,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
    ),
  );

  final Widget iconTrailing = ElevatedButton(
    onPressed: () {
      print('clicked trailing');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: teal,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Continue'),
        SizedBox(width: 8.0),
        Icon(Icons.arrow_forward, size: 18.0),
      ],
    ),
  );

  final Widget iconPure = ElevatedButton(
    onPressed: () {
      print('clicked pure icon');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: teal,
      foregroundColor: Colors.white,
      padding: EdgeInsets.all(14.0),
      shape: CircleBorder(),
    ),
    child: Icon(Icons.add),
  );

  final Widget iconWithBadge = ElevatedButton(
    onPressed: () {
      print('clicked badge');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: teal,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.notifications, size: 18.0),
        SizedBox(width: 8.0),
        Text('Inbox'),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: rose,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '3',
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );

  final Widget iconVariantsSection = _buildCard(
    title: '9. Icon variants',
    icon: Icons.emoji_objects,
    accent: teal,
    child: Wrap(
      spacing: 14.0,
      runSpacing: 14.0,
      alignment: WrapAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconLeading,
            SizedBox(height: 4.0),
            _buildCaption('leading (.icon)'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconTrailing,
            SizedBox(height: 4.0),
            _buildCaption('trailing (Row child)'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconPure,
            SizedBox(height: 4.0),
            _buildCaption('pure icon (CircleBorder)'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWithBadge,
            SizedBox(height: 4.0),
            _buildCaption('icon + badge'),
          ],
        ),
      ],
    ),
  );
  print('Icon variants section created');

  // ============================================================
  // SECTION 10: REAL-WORLD GROUPS
  // ============================================================
  print('=== Section 10: Real-world groups ===');

  // confirm/cancel pair
  final Widget confirmCancelPair = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ElevatedButton(
        onPressed: () {
          print('clicked cancel');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          foregroundColor: slate,
          elevation: 0.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        ),
        child: Text('Cancel'),
      ),
      SizedBox(width: 12.0),
      ElevatedButton(
        onPressed: () {
          print('clicked confirm');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: emerald,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        ),
        child: Text('Confirm'),
      ),
    ],
  );

  // hero CTA
  final Widget heroCta = ElevatedButton.icon(
    onPressed: () {
      print('clicked hero');
    },
    icon: Icon(Icons.rocket_launch),
    label: Text('Get started for free'),
    style: ElevatedButton.styleFrom(
      backgroundColor: emeraldDark,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
      textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      shape: StadiumBorder(),
      elevation: 8.0,
    ),
  );

  // login form (full-width style)
  final Widget loginForm = Container(
    width: 280.0,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.email, size: 16.0, color: Colors.grey.shade600),
              SizedBox(width: 8.0),
              Text('user@host.tld',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13.0)),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.lock, size: 16.0, color: Colors.grey.shade600),
              SizedBox(width: 8.0),
              Text('••••••••',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13.0)),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              print('clicked login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: indigo,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              'Sign in',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
        ),
      ],
    ),
  );

  // segmented action row
  final Widget segmentedRow = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ElevatedButton.icon(
        onPressed: () {
          print('clicked share');
        },
        icon: Icon(Icons.share, size: 16.0),
        label: Text('Share'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: slate,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
          ),
        ),
      ),
      ElevatedButton.icon(
        onPressed: () {
          print('clicked copy');
        },
        icon: Icon(Icons.copy, size: 16.0),
        label: Text('Copy'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: slate,
          elevation: 1.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
      ElevatedButton.icon(
        onPressed: () {
          print('clicked archive');
        },
        icon: Icon(Icons.archive, size: 16.0),
        label: Text('Archive'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: slate,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
        ),
      ),
    ],
  );

  // FAB-replacement style
  final Widget fabReplacement = ElevatedButton(
    onPressed: () {
      print('clicked fab');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: emerald,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
      padding: EdgeInsets.all(20.0),
      elevation: 8.0,
    ),
    child: Icon(Icons.add, size: 28.0),
  );

  final Widget realWorldSection = _buildCard(
    title: '10. Real-world groups',
    icon: Icons.business_center,
    accent: indigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSubtitle('Confirm / cancel pair'),
        SizedBox(height: 8.0),
        Center(child: confirmCancelPair),
        SizedBox(height: 20.0),
        _buildSubtitle('Hero CTA'),
        SizedBox(height: 8.0),
        Center(child: heroCta),
        SizedBox(height: 20.0),
        _buildSubtitle('Login form'),
        SizedBox(height: 8.0),
        Center(child: loginForm),
        SizedBox(height: 20.0),
        _buildSubtitle('Segmented action row'),
        SizedBox(height: 8.0),
        Center(child: segmentedRow),
        SizedBox(height: 20.0),
        _buildSubtitle('FAB-replacement style'),
        SizedBox(height: 8.0),
        Center(child: fabReplacement),
      ],
    ),
  );
  print('Real-world section created');

  // ============================================================
  // SECTION 11: FOOTGUNS
  // ============================================================
  print('=== Section 11: Footguns ===');

  // Footgun 1: too many ElevatedButtons (M3 prominence)
  final List<Widget> tooMany = <Widget>[];
  for (int i = 0; i < 6; i++) {
    tooMany.add(
      Padding(
        padding: EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            print('clicked too-many $i');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: emerald,
            foregroundColor: Colors.white,
          ),
          child: Text('Action ${i + 1}'),
        ),
      ),
    );
  }

  // Footgun 2: Color vs WidgetStateProperty footgun shown via labels only
  final Widget styleFromVsButtonStyle = Column(
    children: [
      ElevatedButton(
        onPressed: () {
          print('clicked styleFrom');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: emerald,
          foregroundColor: Colors.white,
        ),
        child: Text('styleFrom OK'),
      ),
      SizedBox(height: 8.0),
      _buildPill('styleFrom: takes Color (easy)', emerald),
      SizedBox(height: 12.0),
      ElevatedButton(
        onPressed: () {
          print('clicked buttonStyle');
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(rose),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        ),
        child: Text('ButtonStyle OK'),
      ),
      SizedBox(height: 8.0),
      _buildPill('ButtonStyle: needs WidgetStateProperty', rose),
    ],
  );

  // Footgun 3: padding swallowing
  final Widget paddingSwallow = Column(
    children: [
      ElevatedButton(
        onPressed: () {
          print('clicked tiny');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: amber,
          foregroundColor: Colors.black87,
          padding: EdgeInsets.zero,
          minimumSize: Size(40.0, 24.0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text('tiny', style: TextStyle(fontSize: 10.0)),
      ),
      SizedBox(height: 6.0),
      _buildPill(
        'EdgeInsets.zero + shrinkWrap = sub-44dp tap target',
        amber,
      ),
    ],
  );

  // Footgun 4: visually-grayed but enabled mismatch
  final Widget grayMismatch = Column(
    children: [
      ElevatedButton(
        onPressed: () {
          print('clicked fakeDisabled');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.grey.shade500,
        ),
        child: Text('Looks disabled'),
      ),
      SizedBox(height: 6.0),
      _buildPill(
        'Gray colors but onPressed: fn → confusing!',
        Colors.grey.shade600,
      ),
    ],
  );

  final Widget footgunsSection = _buildCard(
    title: '11. Footguns',
    icon: Icons.warning_amber,
    accent: rose,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSubtitle('Too many prominent actions (M3 says: pick one)'),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: rose.withValues(alpha: 0.06),
            border: Border.all(color: rose.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Wrap(alignment: WrapAlignment.center, children: tooMany),
        ),
        SizedBox(height: 20.0),
        _buildSubtitle('styleFrom (Color) vs ButtonStyle (WidgetStateProperty)'),
        SizedBox(height: 8.0),
        Center(child: styleFromVsButtonStyle),
        SizedBox(height: 20.0),
        _buildSubtitle('Padding swallowing → tap target too small'),
        SizedBox(height: 8.0),
        Center(child: paddingSwallow),
        SizedBox(height: 20.0),
        _buildSubtitle('Disabled-looking but enabled'),
        SizedBox(height: 8.0),
        Center(child: grayMismatch),
      ],
    ),
  );
  print('Footguns section created');

  // ============================================================
  // SECTION 12: RECAP
  // ============================================================
  print('=== Section 12: Recap ===');

  final Widget recap = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [emeraldDark, teal, indigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: emerald.withValues(alpha: 0.35),
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
            Icon(Icons.check_circle, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapLine('Use ElevatedButton for the primary, prominent action.'),
        _recapLine('Customize via styleFrom(...) for ergonomic Color args.'),
        _recapLine('Drop to ButtonStyle + WidgetStateProperty for per-state.'),
        _recapLine('Disabled state = onPressed: null (Material handles look).'),
        _recapLine('.icon constructor places icon before label.'),
        _recapLine('M3 says: at most one ElevatedButton per region.'),
        _recapLine('Mind tap targets — keep ≥48dp on touch surfaces.'),
      ],
    ),
  );
  print('Recap created');

  print('ElevatedButton Deep Demo completed successfully');

  // ============================================================
  // FINAL LAYOUT: Scaffold → SingleChildScrollView → Column
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF7FAFC),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 20.0),
          anatomy,
          SizedBox(height: 20.0),
          defaultsSection,
          SizedBox(height: 20.0),
          paletteSection,
          SizedBox(height: 20.0),
          shapesSection,
          SizedBox(height: 20.0),
          sizingSection,
          SizedBox(height: 20.0),
          elevationSection,
          SizedBox(height: 20.0),
          enabledDisabledSection,
          SizedBox(height: 20.0),
          iconVariantsSection,
          SizedBox(height: 20.0),
          realWorldSection,
          SizedBox(height: 20.0),
          footgunsSection,
          SizedBox(height: 20.0),
          recap,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPERS — visual building blocks
// ============================================================

// Helper: chip-style badge for the title banner
Widget _buildBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Helper: annotation box for the anatomy diagram
Widget _buildAnnotation(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.0),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// Helper: code strip displayed under the anatomy diagram
Widget _buildCodeStrip(String code, Color accent) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: accent.withValues(alpha: 0.0) == accent
            ? Colors.greenAccent.shade100
            : Colors.greenAccent.shade100,
      ),
    ),
  );
}

// Helper: a section title row with icon, used inside the anatomy card
Widget _buildSectionTitle(String text, Color accent, IconData icon) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(icon, color: accent, size: 18.0),
      ),
      SizedBox(width: 10.0),
      Text(
        text,
        style: TextStyle(
          color: accent,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

// Helper: caption under buttons
Widget _buildCaption(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'monospace',
      fontSize: 10.0,
      color: Colors.grey.shade700,
    ),
  );
}

// Helper: pill-shaped label
Widget _buildPill(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.45)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 10.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Helper: subtitle inside large cards
Widget _buildSubtitle(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

// Helper: line in the recap card
Widget _recapLine(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: gradient-decorated card wrapper for sections
Widget _buildCard({
  required String title,
  required IconData icon,
  required Color accent,
  required Widget child,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          accent.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
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
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: accent, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        child,
      ],
    ),
  );
}
