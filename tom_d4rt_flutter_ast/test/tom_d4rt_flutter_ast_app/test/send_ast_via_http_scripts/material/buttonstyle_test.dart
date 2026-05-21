// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ButtonStyle from material
// Deep Demo: Visual demonstration of ButtonStyle, WidgetStateProperty and WidgetState
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonStyle Deep Demo executing');

  // ============================================================
  // SECTION 1: ButtonStyle Concept Overview
  // ============================================================
  print('=== Section 1: ButtonStyle Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: ButtonStyle as a bag of state-dependent properties
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.style, size: 48.0, color: Colors.blue),
          SizedBox(height: 12.0),
          Text(
            'ButtonStyle',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'A bundle of visual properties\napplied to a Material button',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.blue.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: WidgetStateProperty resolves per state
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.swap_horiz, size: 48.0, color: Colors.orange),
          SizedBox(height: 12.0),
          Text(
            'WidgetStateProperty<T>',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Resolves a value of type T\nbased on the current state set',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: WidgetState enum
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.pink.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.touch_app, size: 48.0, color: Colors.purple),
          SizedBox(height: 12.0),
          Text(
            'WidgetState',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'hovered • focused • pressed\nselected • dragged • disabled',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.purple.shade700),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Default Style Gallery (all four kinds side-by-side)
  // ============================================================
  print('=== Section 2: Default Style Gallery ===');

  final defaultElevated = ElevatedButton(
    onPressed: () => print('Default ElevatedButton pressed'),
    child: Text('Elevated'),
  );
  final defaultFilled = FilledButton(
    onPressed: () => print('Default FilledButton pressed'),
    child: Text('Filled'),
  );
  final defaultOutlined = OutlinedButton(
    onPressed: () => print('Default OutlinedButton pressed'),
    child: Text('Outlined'),
  );
  final defaultText = TextButton(
    onPressed: () => print('Default TextButton pressed'),
    child: Text('Text'),
  );

  final defaultGallery = <Widget>[
    _buildButtonCard('ElevatedButton', defaultElevated, Colors.blue),
    _buildButtonCard('FilledButton', defaultFilled, Colors.indigo),
    _buildButtonCard('OutlinedButton', defaultOutlined, Colors.teal),
    _buildButtonCard('TextButton', defaultText, Colors.deepPurple),
  ];
  print('Created ${defaultGallery.length} default gallery cards');

  // ============================================================
  // SECTION 3: Styled Gallery — backgroundColor, foregroundColor, overlayColor
  // ============================================================
  print('=== Section 3: Styled Gallery (colors) ===');

  // backgroundColor (WidgetStateProperty.all)
  final bgStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.deepOrange),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );
  print('bgStyle created: backgroundColor=deepOrange');

  // foregroundColor (text/icon tint)
  final fgStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.amber.shade100),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.brown.shade900),
  );
  print('fgStyle created: foregroundColor=brown.900');

  // overlayColor (splash/ink)
  final overlayStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.cyan.shade600),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    overlayColor: WidgetStateProperty.all<Color>(
      Colors.yellow.withValues(alpha: 0.4),
    ),
  );
  print('overlayStyle created: overlayColor=yellow @ 0.4');

  // shadowColor + elevation
  final shadowStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.pink.shade400),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    shadowColor: WidgetStateProperty.all<Color>(Colors.pink.shade900),
    elevation: WidgetStateProperty.all<double>(10.0),
  );
  print('shadowStyle created: shadowColor + elevation=10');

  // surfaceTintColor
  final surfaceTintStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.green.shade100),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.green.shade900),
    surfaceTintColor: WidgetStateProperty.all<Color>(Colors.green.shade400),
  );
  print('surfaceTintStyle created: surfaceTintColor=green.400');

  // iconColor + iconSize
  final iconStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.indigo.shade50),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.indigo.shade900),
    iconColor: WidgetStateProperty.all<Color>(Colors.indigo.shade700),
    iconSize: WidgetStateProperty.all<double>(22.0),
  );
  print('iconStyle created: iconColor + iconSize=22');

  final styledGallery = <Widget>[
    _buildButtonCard(
      'backgroundColor',
      ElevatedButton(
        style: bgStyle,
        onPressed: () => print('bgStyle pressed'),
        child: Text('Press Me'),
      ),
      Colors.deepOrange,
    ),
    _buildButtonCard(
      'foregroundColor',
      FilledButton(
        style: fgStyle,
        onPressed: () => print('fgStyle pressed'),
        child: Text('Press Me'),
      ),
      Colors.brown,
    ),
    _buildButtonCard(
      'overlayColor',
      ElevatedButton(
        style: overlayStyle,
        onPressed: () => print('overlayStyle pressed'),
        child: Text('Press Me'),
      ),
      Colors.cyan,
    ),
    _buildButtonCard(
      'shadowColor',
      ElevatedButton(
        style: shadowStyle,
        onPressed: () => print('shadowStyle pressed'),
        child: Text('Press Me'),
      ),
      Colors.pink,
    ),
    _buildButtonCard(
      'surfaceTintColor',
      ElevatedButton(
        style: surfaceTintStyle,
        onPressed: () => print('surfaceTintStyle pressed'),
        child: Text('Press Me'),
      ),
      Colors.green,
    ),
    _buildButtonCard(
      'iconColor + iconSize',
      ElevatedButton.icon(
        style: iconStyle,
        onPressed: () => print('iconStyle pressed'),
        icon: Icon(Icons.favorite),
        label: Text('Like'),
      ),
      Colors.indigo,
    ),
  ];
  print('Created ${styledGallery.length} styled gallery cards');

  // ============================================================
  // SECTION 4: State-Dependent Gallery — WidgetStateProperty.resolveWith
  // ============================================================
  print('=== Section 4: State-Dependent Gallery ===');

  // The renderer is static, but resolveWith is invoked for real.
  // We call it manually with faked state sets to demonstrate the values
  // each WidgetState would yield, and tag the rendered button accordingly.
  final stateBackground = WidgetStateProperty.resolveWith<Color?>((
    Set<WidgetState> states,
  ) {
    if (states.contains(WidgetState.disabled)) {
      return Colors.grey.shade400;
    }
    if (states.contains(WidgetState.pressed)) {
      return Colors.green.shade900;
    }
    if (states.contains(WidgetState.hovered)) {
      return Colors.green.shade400;
    }
    return Colors.green.shade600;
  });

  final stateForeground = WidgetStateProperty.resolveWith<Color?>((
    Set<WidgetState> states,
  ) {
    if (states.contains(WidgetState.disabled)) {
      return Colors.grey.shade700;
    }
    return Colors.white;
  });

  final stateElevation = WidgetStateProperty.resolveWith<double?>((
    Set<WidgetState> states,
  ) {
    if (states.contains(WidgetState.disabled)) return 0.0;
    if (states.contains(WidgetState.pressed)) return 2.0;
    if (states.contains(WidgetState.hovered)) return 8.0;
    return 4.0;
  });

  // Resolve each faked state set so we can label what would render.
  final normalSet = <WidgetState>{};
  final hoveredSet = <WidgetState>{WidgetState.hovered};
  final pressedSet = <WidgetState>{WidgetState.pressed};
  final disabledSet = <WidgetState>{WidgetState.disabled};

  final normalBg = stateBackground.resolve(normalSet);
  final hoveredBg = stateBackground.resolve(hoveredSet);
  final pressedBg = stateBackground.resolve(pressedSet);
  final disabledBg = stateBackground.resolve(disabledSet);

  final normalElev = stateElevation.resolve(normalSet);
  final hoveredElev = stateElevation.resolve(hoveredSet);
  final pressedElev = stateElevation.resolve(pressedSet);
  final disabledElev = stateElevation.resolve(disabledSet);

  print('resolved normal:   bg=$normalBg   elevation=$normalElev');
  print('resolved hovered:  bg=$hoveredBg  elevation=$hoveredElev');
  print('resolved pressed:  bg=$pressedBg  elevation=$pressedElev');
  print('resolved disabled: bg=$disabledBg elevation=$disabledElev');

  final statefulStyle = ButtonStyle(
    backgroundColor: stateBackground,
    foregroundColor: stateForeground,
    elevation: stateElevation,
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );

  final stateGallery = <Widget>[
    _buildStateCard(
      'NORMAL',
      normalBg ?? Colors.green,
      ElevatedButton(
        style: statefulStyle,
        onPressed: () => print('stateful (normal) pressed'),
        child: Text('Submit'),
      ),
    ),
    _buildStateCard(
      'HOVERED',
      hoveredBg ?? Colors.green,
      ElevatedButton(
        style: statefulStyle,
        onPressed: () => print('stateful (hovered) pressed'),
        child: Text('Submit'),
      ),
    ),
    _buildStateCard(
      'PRESSED',
      pressedBg ?? Colors.green,
      ElevatedButton(
        style: statefulStyle,
        onPressed: () => print('stateful (pressed) pressed'),
        child: Text('Submit'),
      ),
    ),
    _buildStateCard(
      'DISABLED',
      disabledBg ?? Colors.grey,
      ElevatedButton(
        style: statefulStyle,
        onPressed: null,
        child: Text('Submit'),
      ),
    ),
  ];
  print('Created ${stateGallery.length} state cards');

  // ============================================================
  // SECTION 5: Shape Gallery — RoundedRectangle / Stadium / Beveled / Circle
  // ============================================================
  print('=== Section 5: Shape Gallery ===');

  final roundedShape = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.shade600),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
  );

  final stadiumShape = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.orange.shade600),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 28.0, vertical: 14.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(StadiumBorder()),
  );

  final beveledShape = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.teal.shade600),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      BeveledRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  );

  final circleShape = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.pink.shade500),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)),
    minimumSize: WidgetStateProperty.all<Size>(Size(72.0, 72.0)),
    shape: WidgetStateProperty.all<OutlinedBorder>(CircleBorder()),
  );

  final shapeGallery = <Widget>[
    _buildButtonCard(
      'RoundedRectangle',
      ElevatedButton(
        style: roundedShape,
        onPressed: () => print('rounded shape pressed'),
        child: Text('Round'),
      ),
      Colors.blue,
    ),
    _buildButtonCard(
      'Stadium',
      ElevatedButton(
        style: stadiumShape,
        onPressed: () => print('stadium shape pressed'),
        child: Text('Stadium'),
      ),
      Colors.orange,
    ),
    _buildButtonCard(
      'Beveled',
      ElevatedButton(
        style: beveledShape,
        onPressed: () => print('beveled shape pressed'),
        child: Text('Bevel'),
      ),
      Colors.teal,
    ),
    _buildButtonCard(
      'Circle',
      ElevatedButton(
        style: circleShape,
        onPressed: () => print('circle shape pressed'),
        child: Icon(Icons.add),
      ),
      Colors.pink,
    ),
  ];

  // Side gallery — different borders
  final sideThin = ButtonStyle(
    side: WidgetStateProperty.all<BorderSide>(
      BorderSide(color: Colors.blue.shade700, width: 1.0),
    ),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.blue.shade700),
  );
  final sideThick = ButtonStyle(
    side: WidgetStateProperty.all<BorderSide>(
      BorderSide(color: Colors.red.shade700, width: 3.0),
    ),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.red.shade700),
  );
  final sideDashed = ButtonStyle(
    side: WidgetStateProperty.all<BorderSide>(
      BorderSide(color: Colors.green.shade700, width: 2.0),
    ),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.green.shade700),
  );

  final sideGallery = <Widget>[
    _buildButtonCard(
      'side: thin',
      OutlinedButton(
        style: sideThin,
        onPressed: () => print('thin side pressed'),
        child: Text('Thin'),
      ),
      Colors.blue,
    ),
    _buildButtonCard(
      'side: thick',
      OutlinedButton(
        style: sideThick,
        onPressed: () => print('thick side pressed'),
        child: Text('Thick'),
      ),
      Colors.red,
    ),
    _buildButtonCard(
      'side: colored',
      OutlinedButton(
        style: sideDashed,
        onPressed: () => print('colored side pressed'),
        child: Text('Color'),
      ),
      Colors.green,
    ),
  ];
  print(
    'Created ${shapeGallery.length} shape cards and ${sideGallery.length} side cards',
  );

  // ============================================================
  // SECTION 6: Padding / Size Gallery
  // ============================================================
  print('=== Section 6: Padding / Size Gallery ===');

  final tightPaddingStyle = ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    ),
    backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.shade400),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );

  final loosePaddingStyle = ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
    ),
    backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.shade400),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );

  final minimumSizeStyle = ButtonStyle(
    minimumSize: WidgetStateProperty.all<Size>(Size(200.0, 60.0)),
    backgroundColor: WidgetStateProperty.all<Color>(Colors.orange.shade400),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );

  final fixedSizeStyle = ButtonStyle(
    fixedSize: WidgetStateProperty.all<Size>(Size(150.0, 50.0)),
    backgroundColor: WidgetStateProperty.all<Color>(Colors.orange.shade400),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );

  final maximumSizeStyle = ButtonStyle(
    maximumSize: WidgetStateProperty.all<Size>(Size(140.0, 44.0)),
    backgroundColor: WidgetStateProperty.all<Color>(Colors.orange.shade400),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );

  final paddingSizeGallery = <Widget>[
    _buildButtonCard(
      'tight padding',
      ElevatedButton(
        style: tightPaddingStyle,
        onPressed: () => print('tight padding pressed'),
        child: Text('T'),
      ),
      Colors.blue,
    ),
    _buildButtonCard(
      'loose padding',
      ElevatedButton(
        style: loosePaddingStyle,
        onPressed: () => print('loose padding pressed'),
        child: Text('Loose'),
      ),
      Colors.blue,
    ),
    _buildButtonCard(
      'minimumSize 200x60',
      ElevatedButton(
        style: minimumSizeStyle,
        onPressed: () => print('minSize pressed'),
        child: Text('Min'),
      ),
      Colors.orange,
    ),
    _buildButtonCard(
      'fixedSize 150x50',
      ElevatedButton(
        style: fixedSizeStyle,
        onPressed: () => print('fixedSize pressed'),
        child: Text('Fixed'),
      ),
      Colors.orange,
    ),
    _buildButtonCard(
      'maximumSize 140x44',
      ElevatedButton(
        style: maximumSizeStyle,
        onPressed: () => print('maxSize pressed'),
        child: Text('Long Label Clipped'),
      ),
      Colors.orange,
    ),
  ];
  print('Created ${paddingSizeGallery.length} padding/size cards');

  // ============================================================
  // SECTION 7: ButtonStyle.lerp Gallery
  // ============================================================
  print('=== Section 7: ButtonStyle.lerp Gallery ===');

  final lerpStart = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.shade600),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.all<double>(2.0),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
  );

  final lerpEnd = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.red.shade600),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.all<double>(12.0),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(StadiumBorder()),
  );

  final lerpTs = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpGallery = <Widget>[];
  for (final t in lerpTs) {
    final lerped = ButtonStyle.lerp(lerpStart, lerpEnd, t);
    print('ButtonStyle.lerp(start, end, $t) -> $lerped');
    lerpGallery.add(
      _buildButtonCard(
        't = $t',
        ElevatedButton(
          style: lerped,
          onPressed: () => print('lerp t=$t pressed'),
          child: Text('Lerp'),
        ),
        Color.lerp(Colors.blue.shade600, Colors.red.shade600, t) ??
            Colors.purple,
      ),
    );
  }
  print('Created ${lerpGallery.length} lerp cards');

  // ============================================================
  // SECTION 8: ElevatedButton.styleFrom factory gallery
  // ============================================================
  print('=== Section 8: ElevatedButton.styleFrom Factory Gallery ===');

  final factoryStyleA = ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    elevation: 4.0,
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  );
  print('factoryStyleA created');

  final factoryStyleB = ElevatedButton.styleFrom(
    backgroundColor: Colors.green.shade700,
    foregroundColor: Colors.white,
    shadowColor: Colors.green.shade900,
    elevation: 8.0,
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 14.0),
    shape: StadiumBorder(),
  );
  print('factoryStyleB created');

  final factoryStyleC = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.deepPurple,
    side: BorderSide(color: Colors.deepPurple, width: 2.0),
    elevation: 0.0,
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  );
  print('factoryStyleC created');

  final factoryStyleD = ElevatedButton.styleFrom(
    backgroundColor: Colors.amber.shade400,
    foregroundColor: Colors.brown.shade900,
    minimumSize: Size(140.0, 48.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  );
  print('factoryStyleD created');

  final factoryGallery = <Widget>[
    _buildButtonCard(
      'styleFrom: A',
      ElevatedButton(
        style: factoryStyleA,
        onPressed: () => print('factoryA pressed'),
        child: Text('Save'),
      ),
      Colors.indigo,
    ),
    _buildButtonCard(
      'styleFrom: B',
      ElevatedButton(
        style: factoryStyleB,
        onPressed: () => print('factoryB pressed'),
        child: Text('Continue'),
      ),
      Colors.green,
    ),
    _buildButtonCard(
      'styleFrom: C',
      ElevatedButton(
        style: factoryStyleC,
        onPressed: () => print('factoryC pressed'),
        child: Text('Cancel'),
      ),
      Colors.deepPurple,
    ),
    _buildButtonCard(
      'styleFrom: D',
      ElevatedButton(
        style: factoryStyleD,
        onPressed: () => print('factoryD pressed'),
        child: Text('Buy Now'),
      ),
      Colors.amber,
    ),
  ];
  print('Created ${factoryGallery.length} factory cards');

  // ============================================================
  // SECTION 9: Real-world button bar — primary / secondary / tertiary
  // ============================================================
  print('=== Section 9: Real-world Button Bar ===');

  final primaryAction = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return Colors.grey.shade400;
      if (states.contains(WidgetState.pressed)) return Colors.indigo.shade900;
      if (states.contains(WidgetState.hovered)) return Colors.indigo.shade600;
      return Colors.indigo.shade700;
    }),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    ),
    elevation: WidgetStateProperty.all<double>(2.0),
    animationDuration: Duration(milliseconds: 200),
    mouseCursor: WidgetStateProperty.all<MouseCursor>(SystemMouseCursors.click),
  );

  final secondaryAction = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.indigo.shade700),
    side: WidgetStateProperty.all<BorderSide>(
      BorderSide(color: Colors.indigo.shade700, width: 1.5),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    ),
  );

  final tertiaryAction = ButtonStyle(
    foregroundColor: WidgetStateProperty.all<Color>(Colors.grey.shade700),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    ),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    ),
    overlayColor: WidgetStateProperty.all<Color>(
      Colors.grey.withValues(alpha: 0.1),
    ),
  );

  final realWorldBar = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 12.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Order',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'Review your selection before confirming.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: tertiaryAction,
              onPressed: () => print('tertiary: Help pressed'),
              child: Text('Help'),
            ),
            SizedBox(width: 8.0),
            OutlinedButton(
              style: secondaryAction,
              onPressed: () => print('secondary: Cancel pressed'),
              child: Text('Cancel'),
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              style: primaryAction,
              onPressed: () => print('primary: Confirm pressed'),
              child: Text('Confirm'),
            ),
          ],
        ),
      ],
    ),
  );
  print('Real-world button bar created');

  // Also demo ButtonStyle.merge
  final mergeBase = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.shade600),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    ),
  );
  final mergeOverlay = ButtonStyle(
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.all<double>(6.0),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );
  final mergedStyle = mergeBase.merge(mergeOverlay);
  print('ButtonStyle.merge created: $mergedStyle');

  final mergeDemo = _buildButtonCard(
    'merge(base, overlay)',
    ElevatedButton(
      style: mergedStyle,
      onPressed: () => print('merged pressed'),
      child: Text('Merged'),
    ),
    Colors.blue,
  );

  // ============================================================
  // SECTION 10: Code Example Panels
  // ============================================================
  print('=== Section 10: Code Example Panels ===');

  final codePanel1 = _buildCodePanel(
    'ButtonStyle with WidgetStateProperty.all',
    '// Single value across every state\n'
        'final style = ButtonStyle(\n'
        '  backgroundColor: WidgetStateProperty.all(Colors.blue),\n'
        '  foregroundColor: WidgetStateProperty.all(Colors.white),\n'
        '  padding: WidgetStateProperty.all(\n'
        '    EdgeInsets.symmetric(horizontal: 24, vertical: 12),\n'
        '  ),\n'
        ');\n'
        '\n'
        'ElevatedButton(style: style, onPressed: () {}, child: Text("OK"));',
    Colors.cyan,
  );

  final codePanel2 = _buildCodePanel(
    'State-dependent with resolveWith',
    '// Resolve per WidgetState\n'
        'final bg = WidgetStateProperty.resolveWith<Color?>((states) {\n'
        '  if (states.contains(WidgetState.disabled)) return Colors.grey;\n'
        '  if (states.contains(WidgetState.pressed))  return Colors.indigo.shade900;\n'
        '  if (states.contains(WidgetState.hovered))  return Colors.indigo.shade400;\n'
        '  return Colors.indigo.shade700;\n'
        '});',
    Colors.lightGreen,
  );

  final codePanel3 = _buildCodePanel(
    'ButtonStyle.lerp and merge',
    '// Tween between two styles for animation\n'
        'final mid = ButtonStyle.lerp(start, end, 0.5);\n'
        '\n'
        '// Combine two partial styles\n'
        'final combined = base.merge(overlay);\n'
        '\n'
        '// ElevatedButton.styleFrom is a typed factory\n'
        'final quick = ElevatedButton.styleFrom(\n'
        '  backgroundColor: Colors.indigo,\n'
        '  foregroundColor: Colors.white,\n'
        '  elevation: 4,\n'
        ');',
    Colors.amber,
  );

  // ============================================================
  // SECTION 11: Summary
  // ============================================================
  print('=== Section 11: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.style,
          'ButtonStyle is data',
          'It is a value object passed to .style on Material buttons.',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.swap_horiz,
          'Properties are WidgetStateProperty',
          'Every visual property resolves against the current state set.',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.touch_app,
          'WidgetState describes interaction',
          'hovered, pressed, focused, selected, dragged, disabled, error.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.merge_type,
          'Compose with merge/lerp/copyWith',
          'Combine partial styles, animate transitions, or tweak one field.',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.factory,
          'styleFrom factories',
          'ElevatedButton.styleFrom / FilledButton.styleFrom / etc. wrap raw values.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.brush,
          'Every kind shares the API',
          'Elevated, Filled, Outlined and Text buttons all accept ButtonStyle.',
          Colors.pink,
        ),
      ],
    ),
  );
  print('Summary panel created');

  print('ButtonStyle Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.smart_button, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ButtonStyle Deep Demo',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'WidgetStateProperty • WidgetState • lerp • merge • styleFrom',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1: Concept overview
        Text(
          '1. ButtonStyle Concept Overview',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2: Default style gallery
        Text(
          '2. Default Style Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          'Each button kind ships with a sensible default style.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: defaultGallery),
        SizedBox(height: 32.0),

        // Section 3: Styled gallery (colors)
        Text(
          '3. Color Properties via WidgetStateProperty.all',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          'backgroundColor, foregroundColor, overlayColor, shadowColor, '
          'surfaceTintColor, iconColor.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: styledGallery),
        SizedBox(height: 32.0),

        // Section 4: State-dependent
        Text(
          '4. State-Dependent Properties (resolveWith)',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          'Same button, four labelled states. The renderer is static but '
          'WidgetStateProperty.resolve(...) was invoked for real.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: stateGallery),
        SizedBox(height: 32.0),

        // Section 5: Shapes + sides
        Text(
          '5. Shape & Side Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: shapeGallery),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: sideGallery),
        SizedBox(height: 32.0),

        // Section 6: Padding / Size
        Text(
          '6. Padding & Size Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          'padding, minimumSize, fixedSize, maximumSize.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: paddingSizeGallery),
        SizedBox(height: 32.0),

        // Section 7: lerp
        Text(
          '7. ButtonStyle.lerp(start, end, t)',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          'Blue rounded → Red stadium at t = 0, 0.25, 0.5, 0.75, 1.0.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: lerpGallery),
        SizedBox(height: 32.0),

        // Section 8: styleFrom factory
        Text(
          '8. ElevatedButton.styleFrom Factory',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          'Typed factory takes raw values and wraps them as WidgetStateProperty.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: factoryGallery),
        SizedBox(height: 32.0),

        // Section 9: real-world bar + merge demo
        Text(
          '9. Real-World Button Bar (primary / secondary / tertiary)',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        realWorldBar,
        SizedBox(height: 12.0),
        Text(
          'Bonus: ButtonStyle.merge',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: [mergeDemo]),
        SizedBox(height: 32.0),

        // Section 10: Code panels
        Text(
          '10. Construction Patterns',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        codePanel1,
        codePanel2,
        codePanel3,
        SizedBox(height: 32.0),

        // Section 11: Summary
        Text(
          '11. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

// Builds a label/button card used throughout the galleries.
Widget _buildButtonCard(String label, Widget button, Color accent) {
  return Container(
    width: 200.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.1),
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Center(child: button),
      ],
    ),
  );
}

// Builds a state-tagged card for Section 4.
Widget _buildStateCard(String stateLabel, Color tint, Widget button) {
  return Container(
    width: 200.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tint.withValues(alpha: 0.6), width: 2.0),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            stateLabel,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Center(child: button),
        SizedBox(height: 8.0),
        Text(
          'would render with\nthis state active',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

// Builds a dark code panel.
Widget _buildCodePanel(String title, String code, Color accent) {
  return Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: accent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
      ],
    ),
  );
}

// Builds a summary row.
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
