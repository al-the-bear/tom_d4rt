// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demonstration of DeviceGestureSettings
// from package:flutter/gestures.dart.
//
// DeviceGestureSettings is an immutable configuration class derived from
// the platform's ui.GestureSettings, scaled into logical pixels. It exposes
// a single backing field, [touchSlop], plus a derived [panSlop] (touchSlop * 2).
// Typical platform-default values:
//
//   * Android phones / tablets   ~ 18 logical pixels
//   * iOS devices                ~ 12 logical pixels (Cupertino-tuned)
//   * Desktop (Win/macOS/Linux)  ~  4-8 logical pixels (mouse precision)
//   * Web (mobile UA)            ~ 18 logical pixels
//
// The factory DeviceGestureSettings.fromView(view) reads physicalTouchSlop
// from the FlutterView and divides it by devicePixelRatio.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Sentinel instances we will visualize across the page.
  // ============================================================
  final DeviceGestureSettings androidPhone =
      DeviceGestureSettings(touchSlop: 18.0);
  final DeviceGestureSettings iosPhone = DeviceGestureSettings(touchSlop: 12.0);
  final DeviceGestureSettings desktopMouse =
      DeviceGestureSettings(touchSlop: 4.0);
  final DeviceGestureSettings tabletLarge =
      DeviceGestureSettings(touchSlop: 24.0);
  final DeviceGestureSettings unsetSlop =
      DeviceGestureSettings(touchSlop: null);
  final DeviceGestureSettings androidPhoneCopy =
      DeviceGestureSettings(touchSlop: 18.0);

  final bool equality1 = androidPhone == androidPhoneCopy;
  final bool equality2 = androidPhone == iosPhone;
  final int hashA = androidPhone.hashCode;
  final int hashB = androidPhoneCopy.hashCode;
  final int hashC = iosPhone.hashCode;
  final String description = androidPhone.toString();

  final List<DeviceGestureSettings> gallery = <DeviceGestureSettings>[
    desktopMouse,
    iosPhone,
    androidPhone,
    tabletLarge,
    unsetSlop,
  ];

  // ============================================================
  // SECTION 1 — Hero header with class identity.
  // ============================================================
  final Widget heroHeader = Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1A237E),
          Color(0xFF3949AB),
          Color(0xFF5C6BC0),
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 18.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Color(0x331A237E),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFFD54F), Color(0xFFFFA000)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x55FFA000),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(Icons.touch_app, color: Colors.white, size: 36.0),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'DeviceGestureSettings',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Color(0xFFE8EAF6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0x66FFFFFF), width: 1.0),
          ),
          child: Text(
            'Immutable. Scaled into logical pixels. Single field: touchSlop.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _heroChip('@immutable', Color(0xFFB39DDB)),
            _heroChip('const-able', Color(0xFF80DEEA)),
            _heroChip('value-eq', Color(0xFFA5D6A7)),
            _heroChip('view-derived', Color(0xFFFFAB91)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 — Anatomy of touch slop: concentric rings.
  // ============================================================
  // The fade animation is static; static motion only.
  final Animation<double> fadeIn = AlwaysStoppedAnimation<double>(1.0);

  final Widget anatomySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFECB3)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33FFA000),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.gps_fixed, color: Color(0xFFE65100), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of touch slop',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'touchSlop is the distance (in logical pixels) the pointer may move before a tap escalates to a drag. panSlop is exactly 2x.',
          style: TextStyle(fontSize: 13.0, color: Color(0xFF6D4C41)),
        ),
        SizedBox(height: 16.0),
        FadeTransition(
          opacity: fadeIn,
          child: Center(
            child: SizedBox(
              width: 280.0,
              height: 280.0,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // panSlop ring (2x touchSlop)
                  _slopRing(
                    diameter: 240.0,
                    label: 'panSlop',
                    radiusValue: androidPhone.panSlop ?? 0.0,
                    color: Color(0xFF8D6E63),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0x228D6E63),
                        Color(0x668D6E63),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  // touchSlop ring
                  _slopRing(
                    diameter: 160.0,
                    label: 'touchSlop',
                    radiusValue: androidPhone.touchSlop ?? 0.0,
                    color: Color(0xFFD84315),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0x33D84315),
                        Color(0x77D84315),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  // Pointer dot
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFBDBDBD)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x66000000),
                          blurRadius: 6.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFFFB300), width: 1.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.lightbulb_outline,
                  color: Color(0xFFFFA000), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Inside touchSlop ring → tap. Outside → drag escalation.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF6D4C41),
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
  // SECTION 3 — Per-field cards (touchSlop, panSlop, hashCode, ==).
  // ============================================================
  final Widget fieldsSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x332E7D32),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.view_in_ar, color: Color(0xFF2E7D32), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Surface API: fields & overrides',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _fieldCard(
              name: 'touchSlop',
              type: 'final double?',
              description:
                  'Distance threshold (logical pixels) before a pointer move turns into a drag. null when the platform did not supply a value.',
              icon: Icons.straighten,
              accent: Color(0xFFD84315),
              value: '${androidPhone.touchSlop}',
            ),
            _fieldCard(
              name: 'panSlop',
              type: 'double? get',
              description:
                  'Derived: touchSlop * 2. Used by horizontal/vertical drag recognizers that require a larger commitment distance.',
              icon: Icons.swap_horiz,
              accent: Color(0xFF6A1B9A),
              value: '${androidPhone.panSlop}',
            ),
            _fieldCard(
              name: 'hashCode',
              type: 'int get',
              description:
                  'Object.hash(touchSlop, 23). The literal 23 disambiguates from a bare double hash.',
              icon: Icons.tag,
              accent: Color(0xFF00838F),
              value: '${androidPhone.hashCode}',
            ),
            _fieldCard(
              name: 'operator ==',
              type: 'bool',
              description:
                  'Value equality on touchSlop only — runtimeType is also checked, so subclasses are not equal.',
              icon: Icons.balance,
              accent: Color(0xFF1565C0),
              value: '$equality1',
            ),
            _fieldCard(
              name: 'toString()',
              type: 'String',
              description:
                  'Returns "DeviceGestureSettings(touchSlop: \$touchSlop)" — handy for debugPrint output.',
              icon: Icons.text_fields,
              accent: Color(0xFF4E342E),
              value: description,
            ),
            _fieldCard(
              name: 'fromView()',
              type: 'factory',
              description:
                  'Builds settings from a FlutterView by dividing physicalTouchSlop by devicePixelRatio.',
              icon: Icons.tv,
              accent: Color(0xFFAD1457),
              value: 'factory',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4 — Platform comparison gallery (Android/iOS/desktop/tablet).
  // ============================================================
  final Widget platformSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x331565C0),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.devices, color: Color(0xFF1565C0), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Platform-default touch slop',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _platformCard(
              platform: 'Android',
              icon: Icons.android,
              accent: Color(0xFF2E7D32),
              settings: androidPhone,
              note: 'Material default',
            ),
            _platformCard(
              platform: 'iOS',
              icon: Icons.phone_iphone,
              accent: Color(0xFF455A64),
              settings: iosPhone,
              note: 'Cupertino-tuned',
            ),
            _platformCard(
              platform: 'Desktop',
              icon: Icons.computer,
              accent: Color(0xFF6A1B9A),
              settings: desktopMouse,
              note: 'Mouse-precision',
            ),
            _platformCard(
              platform: 'Tablet',
              icon: Icons.tablet_mac,
              accent: Color(0xFFD84315),
              settings: tabletLarge,
              note: 'Larger digit',
            ),
            _platformCard(
              platform: 'Unset',
              icon: Icons.help_outline,
              accent: Color(0xFF455A64),
              settings: unsetSlop,
              note: 'null fallback',
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x111565C0),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bar chart: touchSlop vs panSlop (logical pixels)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: gallery
                    .where((DeviceGestureSettings s) => s.touchSlop != null)
                    .map<Widget>(_chartBar)
                    .toList(),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _legendDot(Color(0xFF1976D2), 'touchSlop'),
                  _legendDot(Color(0xFF8E24AA), 'panSlop'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5 — Recipes: integrating with MediaQuery.
  // ============================================================
  final Widget recipesSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF263238), Color(0xFF37474F)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Color(0xFF80CBC4), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          title: 'Read from MediaQuery',
          accent: Color(0xFF80DEEA),
          code:
              "final DeviceGestureSettings s = MediaQuery.of(context).gestureSettings;\nfinal double slop = s.touchSlop ?? kTouchSlop;",
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          title: 'Build a recognizer with platform slop',
          accent: Color(0xFFA5D6A7),
          code:
              "final TapGestureRecognizer tap = TapGestureRecognizer()\n  ..gestureSettings = settings;\n// recognizer now respects view-supplied touchSlop.",
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          title: 'Override touchSlop for an a11y zone',
          accent: Color(0xFFFFCC80),
          code:
              "MediaQuery(\n  data: MediaQuery.of(context).copyWith(\n    gestureSettings: const DeviceGestureSettings(touchSlop: 32.0),\n  ),\n  child: child,\n);",
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          title: 'Derive from a FlutterView',
          accent: Color(0xFFEF9A9A),
          code:
              "final DeviceGestureSettings fromV =\n    DeviceGestureSettings.fromView(View.of(context));",
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 — Pitfalls.
  // ============================================================
  final Widget pitfallsSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFC62828), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33C62828),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded,
                color: Color(0xFFC62828), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & sharp edges',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallCard(
          title: 'touchSlop can be null',
          body:
              'Always coalesce against kTouchSlop (or your own constant). Calling panSlop on a null touchSlop also returns null.',
        ),
        _pitfallCard(
          title: 'Equality ignores subclasses',
          body:
              'operator == enforces runtimeType equality, so a subclass with the same touchSlop is NOT equal to the base.',
        ),
        _pitfallCard(
          title: 'Logical, not physical, pixels',
          body:
              'Values are already divided by devicePixelRatio. Do not divide a second time when sourcing from gestureSettings.',
        ),
        _pitfallCard(
          title: 'Const-construction for stable equality',
          body:
              'Use const DeviceGestureSettings(...) so identical configurations canonicalize and unbalance fewer InheritedWidget rebuilds.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 — Equality matrix and live values.
  // ============================================================
  final Widget liveSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x336A1B9A),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.compare_arrows,
                color: Color(0xFF6A1B9A), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Equality & live values',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _miniMetric('androidPhone == androidPhoneCopy', '$equality1',
                Color(0xFF2E7D32)),
            _miniMetric(
                'androidPhone == iosPhone', '$equality2', Color(0xFFC62828)),
            _miniMetric('hashA == hashB', '${hashA == hashB}',
                Color(0xFF1565C0)),
            _miniMetric('hashA == hashC', '${hashA == hashC}',
                Color(0xFFAD1457)),
            _miniMetric('toString()', description, Color(0xFF4E342E)),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hashes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 6.0),
              Text('hashA = $hashA',
                  style: TextStyle(
                      fontFamily: 'monospace', fontSize: 12.0)),
              Text('hashB = $hashB',
                  style: TextStyle(
                      fontFamily: 'monospace', fontSize: 12.0)),
              Text('hashC = $hashC',
                  style: TextStyle(
                      fontFamily: 'monospace', fontSize: 12.0)),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8 — Quick reference card.
  // ============================================================
  final Widget quickRef = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33EF6C00),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bookmark_border,
                color: Color(0xFFE65100), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFBF360C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Table(
          border: TableBorder.all(
            color: Color(0xFFFFB74D),
            width: 1.0,
            borderRadius: BorderRadius.circular(8.0),
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.0),
            1: FlexColumnWidth(3.0),
          },
          children: <TableRow>[
            _refRow('Member', 'Notes', header: true),
            _refRow('touchSlop',
                'final double? — null-safe, in logical pixels'),
            _refRow('panSlop', 'getter — touchSlop * 2 or null'),
            _refRow('hashCode', 'Object.hash(touchSlop, 23)'),
            _refRow('operator ==', 'value equality on touchSlop only'),
            _refRow('fromView(view)', 'factory from FlutterView'),
            _refRow('toString()',
                "'DeviceGestureSettings(touchSlop: ...)'"),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFECB3)],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.tips_and_updates,
                  color: Color(0xFFFFA000), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Tip: prefer reading from MediaQuery so OS-level a11y settings reach your recognizer.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF6D4C41),
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
  // SECTION 9 — ASCII footer / signature.
  // ============================================================
  final Widget asciiFooter = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF212121), Color(0xFF424242)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Color(0xFF80CBC4), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ASCII summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '+----------------------------------------------------------+\n'
          '| DeviceGestureSettings (immutable, value-eq)              |\n'
          '+----------------------------------------------------------+\n'
          '| touchSlop : double?     ~ 12-24 logical px (platform)    |\n'
          '| panSlop   : double? get touchSlop * 2 (or null)          |\n'
          '| hashCode  : int  get    Object.hash(touchSlop, 23)       |\n'
          '| ==        : runtimeType + touchSlop equality             |\n'
          '| fromView  : factory     physicalTouchSlop / dpr          |\n'
          '+----------------------------------------------------------+\n'
          '| android=18  ios=12  desktop=4-8  tablet=24  unset=null   |\n'
          '+----------------------------------------------------------+',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFF80CBC4),
            fontSize: 11.0,
            height: 1.35,
          ),
        ),
        SizedBox(height: 10.0),
        // Static motion only — Duration.zero on AnimatedContainer.
        AnimatedContainer(
          duration: Duration.zero,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Color(0xFF1B5E20), Color(0xFF388E3C)],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.verified, color: Colors.white, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Demo render: deep visualization complete.',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Final assembly into MaterialApp / Scaffold.
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroHeader,
            SizedBox(height: 16.0),
            anatomySection,
            SizedBox(height: 16.0),
            fieldsSection,
            SizedBox(height: 16.0),
            platformSection,
            SizedBox(height: 16.0),
            recipesSection,
            SizedBox(height: 16.0),
            pitfallsSection,
            SizedBox(height: 16.0),
            liveSection,
            SizedBox(height: 16.0),
            quickRef,
            SizedBox(height: 16.0),
            asciiFooter,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------------
// Helper widgets (private; pulled out for readability).
// ----------------------------------------------------------------------

Widget _heroChip(String text, Color tint) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[tint.withValues(alpha: 0.85), tint],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _slopRing({
  required double diameter,
  required String label,
  required double radiusValue,
  required Color color,
  required Gradient gradient,
}) {
  return Container(
    width: diameter,
    height: diameter,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: gradient,
      border: Border.all(color: color, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 12.0,
          spreadRadius: 1.0,
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: color, width: 1.0),
              ),
              child: Text(
                '$label = ${radiusValue.toStringAsFixed(1)} lp',
                style: TextStyle(
                  fontSize: 10.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fieldCard({
  required String name,
  required String type,
  required String description,
  required IconData icon,
  required Color accent,
  required String value,
}) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          accent.withValues(alpha: 0.08),
        ],
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accent, size: 18.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: accent,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(fontSize: 11.5, color: Color(0xFF424242)),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.chevron_right,
                  size: 14.0, color: Color(0xFF455A64)),
              SizedBox(width: 4.0),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: Color(0xFF263238),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _platformCard({
  required String platform,
  required IconData icon,
  required Color accent,
  required DeviceGestureSettings settings,
  required String note,
}) {
  final String slop = settings.touchSlop != null
      ? settings.touchSlop!.toStringAsFixed(1)
      : 'null';
  final String pan =
      settings.panSlop != null ? settings.panSlop!.toStringAsFixed(1) : 'null';
  return Container(
    width: 160.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          accent.withValues(alpha: 0.12),
        ],
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 22.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                platform,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: accent,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Color(0xFF616161),
          ),
        ),
        SizedBox(height: 8.0),
        _platformMetric('touchSlop', slop, accent),
        SizedBox(height: 4.0),
        _platformMetric('panSlop', pan, accent),
        SizedBox(height: 8.0),
        // Visual ring proxy (size scaled).
        Center(
          child: Container(
            width: settings.touchSlop != null
                ? (settings.touchSlop! * 2.0).clamp(12.0, 56.0)
                : 12.0,
            height: settings.touchSlop != null
                ? (settings.touchSlop! * 2.0).clamp(12.0, 56.0)
                : 12.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 2.0),
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.15),
                  accent.withValues(alpha: 0.45),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _platformMetric(String label, String value, Color accent) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: accent,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
      ],
    ),
  );
}

Widget _chartBar(DeviceGestureSettings s) {
  final double slop = s.touchSlop ?? 0.0;
  final double pan = s.panSlop ?? 0.0;
  final double touchHeight = (slop * 3.0).clamp(4.0, 100.0);
  final double panHeight = (pan * 3.0).clamp(4.0, 100.0);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 14.0,
              height: touchHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(3.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x331976D2),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.0),
            Container(
              width: 14.0,
              height: panHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Color(0xFF4A148C), Color(0xFF8E24AA)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(3.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x338E24AA),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          '${slop.toStringAsFixed(0)}lp',
          style: TextStyle(fontSize: 9.0, color: Color(0xFF455A64)),
        ),
      ],
    ),
  );
}

Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 4.0),
      Text(label, style: TextStyle(fontSize: 11.0)),
    ],
  );
}

Widget _recipeCard({
  required String title,
  required Color accent,
  required String code,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1B1B1B),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF000000),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFE0F7FA),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallCard({required String title, required String body}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFFEF9A9A), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x22C62828),
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.error_outline,
              color: Color(0xFFC62828), size: 18.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB71C1C),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _miniMetric(String label, String value, Color accent) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          accent.withValues(alpha: 0.12),
        ],
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: accent,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Color(0xFF263238),
          ),
        ),
      ],
    ),
  );
}

TableRow _refRow(String left, String right, {bool header = false}) {
  return TableRow(
    decoration: BoxDecoration(
      color: header ? Color(0xFFFFE0B2) : Colors.white,
    ),
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          left,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: header ? FontWeight.bold : FontWeight.normal,
            color: header ? Color(0xFFBF360C) : Color(0xFF263238),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          right,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: header ? FontWeight.bold : FontWeight.normal,
            color: header ? Color(0xFFBF360C) : Color(0xFF424242),
          ),
        ),
      ),
    ],
  );
}
