// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for MaterialPageRoute,
// PageRoute, PageRouteBuilder, ModalRoute, and the surrounding transition
// machinery. The visual conceit is a grand-central railway departure board
// rendered in dark burgundy, brass, and cream tones.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('pageroute_test: building Material navigation departure board');

  // ------------------------------------------------------------------------
  // PALETTE — Grand Central departure board
  // ------------------------------------------------------------------------
  // The script uses a small fixed palette so every section feels like a
  // single coherent installation. Burgundy is the body, brass is the
  // accent, cream is the parchment text background.
  const Color burgundyDeep = Color(0xFF3B1116);
  const Color burgundy = Color(0xFF5C1A22);
  const Color burgundySoft = Color(0xFF7A2630);
  const Color brass = Color(0xFFC9A24A);
  const Color brassLight = Color(0xFFE6CE8F);
  const Color cream = Color(0xFFF4ECD8);
  const Color creamSoft = Color(0xFFFBF6E8);
  const Color ink = Color(0xFF1B0A0D);
  const Color rail = Color(0xFF2A1015);
  const Color steam = Color(0xFFEAE2C9);
  const Color signalGreen = Color(0xFF2E6B3F);
  const Color signalAmber = Color(0xFFE08A1A);
  const Color signalRed = Color(0xFFB23A2E);

  // ------------------------------------------------------------------------
  // SHARED TEXT STYLES
  // ------------------------------------------------------------------------
  const TextStyle titleStyle = TextStyle(
    color: cream,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.4,
  );
  const TextStyle subTitleStyle = TextStyle(
    color: brassLight,
    fontSize: 14.0,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.8,
  );
  const TextStyle bodyStyle = TextStyle(
    color: ink,
    fontSize: 13.5,
    height: 1.45,
  );
  const TextStyle monoStyle = TextStyle(
    color: burgundyDeep,
    fontFamily: 'monospace',
    fontSize: 12.5,
    fontWeight: FontWeight.bold,
  );
  const TextStyle monoFlap = TextStyle(
    color: brassLight,
    fontFamily: 'monospace',
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 2.5,
  );

  // ------------------------------------------------------------------------
  // HELPER WIDGETS
  // ------------------------------------------------------------------------
  Widget chip(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: brass, width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontFamily: 'monospace',
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget brassDivider() {
    return Container(
      height: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            brass.withOpacity(0.0),
            brass,
            brass,
            brass.withOpacity(0.0),
          ],
          stops: const <double>[0.0, 0.15, 0.85, 1.0],
        ),
      ),
    );
  }

  Widget flapLetter(String ch) {
    return Container(
      width: 28.0,
      height: 38.0,
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      decoration: BoxDecoration(
        color: ink,
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(color: brass, width: 0.6),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF111111), Color(0xFF2A2A2A), Color(0xFF111111)],
          stops: <double>[0.0, 0.5, 1.0],
        ),
      ),
      alignment: Alignment.center,
      child: Text(ch, style: monoFlap),
    );
  }

  Widget flapRow(String text) {
    final List<Widget> letters = <Widget>[];
    for (int i = 0; i < text.length; i = i + 1) {
      letters.add(flapLetter(text[i]));
    }
    return Row(mainAxisSize: MainAxisSize.min, children: letters);
  }

  Widget sectionHeader(String number, String title, String subtitle, IconData icon) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[burgundyDeep, burgundy, burgundySoft],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: brass, width: 1.5),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black54, blurRadius: 8.0, offset: Offset(0.0, 4.0)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: ink,
              shape: BoxShape.circle,
              border: Border.all(color: brass, width: 2.0),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: brass,
                fontFamily: 'monospace',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: titleStyle),
                const SizedBox(height: 4.0),
                Text(subtitle, style: subTitleStyle),
              ],
            ),
          ),
          Icon(icon, color: brass, size: 38.0),
        ],
      ),
    );
  }

  Widget parchmentCard(String heading, List<Widget> body) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: creamSoft,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: brass.withOpacity(0.5), width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black26, blurRadius: 4.0, offset: Offset(0.0, 2.0)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            heading,
            style: const TextStyle(
              color: burgundyDeep,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8.0),
          ...body,
        ],
      ),
    );
  }

  Widget bodyLine(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(text, style: bodyStyle),
    );
  }

  Widget paramRow(String name, String type, String defaultV, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(name, style: monoStyle),
          ),
          SizedBox(
            width: 130.0,
            child: Text(
              type,
              style: const TextStyle(
                color: signalGreen,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          SizedBox(
            width: 80.0,
            child: Text(
              defaultV,
              style: const TextStyle(
                color: signalAmber,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              role,
              style: const TextStyle(fontSize: 12.0, height: 1.35, color: ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget propRow(String label, String value, {Color valueColor = burgundy}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170.0,
            child: Text(
              label,
              style: const TextStyle(
                color: ink,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget hierarchyNode(String name, String role, Color color, bool isAbstract) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: brass, width: 1.2),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: isAbstract ? signalAmber : signalGreen,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(
              isAbstract ? 'ABS' : 'CON',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 160.0,
            child: Text(
              name,
              style: const TextStyle(
                color: cream,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              role,
              style: const TextStyle(
                color: brassLight,
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget downArrow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Icon(Icons.arrow_downward, color: brass, size: 18.0),
      ),
    );
  }

  // ------------------------------------------------------------------------
  // CONSTRUCT REAL ROUTE OBJECTS for inspection
  // ------------------------------------------------------------------------
  // We construct several MaterialPageRoute instances with varying parameters
  // and read their publicly accessible properties. We deliberately never
  // push these routes onto a Navigator; this is a stateless inspection.
  print('pageroute_test: constructing route specimens');

  Widget placeholderPage(String label, Color tint) {
    return Container(
      color: tint,
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: cream,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  final MaterialPageRoute<dynamic> standardRoute = MaterialPageRoute<dynamic>(
    settings: const RouteSettings(name: '/timetable'),
    builder: (BuildContext ctx) => placeholderPage('Timetable', burgundy),
  );

  final MaterialPageRoute<dynamic> dialogRoute = MaterialPageRoute<dynamic>(
    settings: const RouteSettings(name: '/ticket-booth', arguments: 'first-class'),
    fullscreenDialog: true,
    builder: (BuildContext ctx) => placeholderPage('Ticket Booth', burgundyDeep),
  );

  final MaterialPageRoute<dynamic> ephemeralRoute = MaterialPageRoute<dynamic>(
    settings: const RouteSettings(name: '/announcement'),
    maintainState: false,
    builder: (BuildContext ctx) => placeholderPage('Announcement', burgundySoft),
  );

  final MaterialPageRoute<String> stringResultRoute = MaterialPageRoute<String>(
    settings: const RouteSettings(name: '/pick-destination'),
    builder: (BuildContext ctx) => placeholderPage('Pick Destination', burgundy),
  );

  final MaterialPageRoute<bool> boolResultRoute = MaterialPageRoute<bool>(
    settings: const RouteSettings(name: '/confirm-boarding'),
    fullscreenDialog: true,
    builder: (BuildContext ctx) => placeholderPage('Confirm Boarding', burgundyDeep),
  );

  final List<MaterialPageRoute<dynamic>> allRoutes = <MaterialPageRoute<dynamic>>[
    standardRoute,
    dialogRoute,
    ephemeralRoute,
    stringResultRoute,
    boolResultRoute,
  ];

  // Safely read route properties; properties available pre-attachment
  // include settings, maintainState, fullscreenDialog, opaque, barrierColor,
  // barrierLabel, barrierDismissible, and transitionDuration. We still
  // wrap with try/catch as a defensive measure.
  String safeStr(String Function() reader) {
    try {
      return reader();
    } catch (_) {
      return 'not-readable';
    }
  }

  // ========================================================================
  // SECTION 1 — Hero header
  // ========================================================================
  print('pageroute_test: section 1 — hero header');

  final Widget heroHeader = Container(
    width: double.infinity,
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[ink, burgundyDeep, burgundy],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: brass, width: 2.5),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black, blurRadius: 16.0, offset: Offset(0.0, 6.0)),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.train, color: brass, size: 36.0),
                const SizedBox(width: 10.0),
                Text(
                  'GRAND CENTRAL',
                  style: TextStyle(
                    color: brassLight,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
                ),
              ],
            ),
            chip('PLATFORM 7', burgundy, brassLight),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: brass, width: 1.5),
          ),
          child: Column(
            children: <Widget>[
              flapRow('MATERIALPAGEROUTE'),
              const SizedBox(height: 6.0),
              Text(
                'the Material navigator\'s standard transition',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: brassLight,
                  fontSize: 13.0,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'PageRoute<T> is the locomotive of Material navigation. It carries '
          'a builder, a settings object, a result type, and a transition. '
          'MaterialPageRoute<T> is the platform-styled concrete class that '
          'most apps push onto their Navigator.',
          textAlign: TextAlign.center,
          style: TextStyle(color: cream, fontSize: 13.5, height: 1.5),
        ),
      ],
    ),
  );

  // ========================================================================
  // SECTION 2 — Concept overview
  // ========================================================================
  print('pageroute_test: section 2 — concept overview');

  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '02',
        'Concept overview',
        'What a route is, what T means, push/pop semantics',
        Icons.lightbulb_outline,
      ),
      parchmentCard('PageRoute as abstract base', <Widget>[
        bodyLine(
          'PageRoute<T> is the abstract base class for routes that occupy '
          'the entire navigator overlay. It inherits from ModalRoute<T>, '
          'which gives it a modal barrier and focus management, and from '
          'TransitionRoute<T>, which gives it an animation that drives '
          'forward and reverse transitions.',
        ),
        bodyLine(
          'MaterialPageRoute<T> is the concrete platform-aware subclass. '
          'On Android it uses an upward-fade transition; on iOS it uses '
          'a horizontal slide that mimics CupertinoPageRoute.',
        ),
      ]),
      parchmentCard('The T type parameter', <Widget>[
        bodyLine(
          'The T in MaterialPageRoute<T> is the result type. When the '
          'pushed page calls Navigator.pop(context, value), the value '
          'is delivered to the caller as a Future<T?>. Use bool for '
          'confirm dialogs, String for picker results, or a model class '
          'for richer payloads.',
        ),
        const SizedBox(height: 6.0),
        Row(children: <Widget>[
          chip('MaterialPageRoute<String>', burgundy, cream),
          const SizedBox(width: 8.0),
          chip('Future<String?>', signalGreen, Colors.white),
        ]),
        const SizedBox(height: 4.0),
        Row(children: <Widget>[
          chip('MaterialPageRoute<bool>', burgundy, cream),
          const SizedBox(width: 8.0),
          chip('Future<bool?>', signalGreen, Colors.white),
        ]),
        const SizedBox(height: 4.0),
        Row(children: <Widget>[
          chip('MaterialPageRoute<MyModel>', burgundy, cream),
          const SizedBox(width: 8.0),
          chip('Future<MyModel?>', signalGreen, Colors.white),
        ]),
      ]),
      parchmentCard('Push/pop semantics', <Widget>[
        bodyLine(
          'Navigator.push(context, route) pushes onto the stack and '
          'returns a Future<T?> that resolves when the pushed route is '
          'popped. Navigator.pop(context, value) pops the top route '
          'and delivers value to the awaiting future.',
        ),
        bodyLine(
          'Routes are single-use. Once popped, a MaterialPageRoute '
          'cannot be pushed again — construct a new instance.',
        ),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 3 — Class hierarchy diagram
  // ========================================================================
  print('pageroute_test: section 3 — class hierarchy');

  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '03',
        'Class hierarchy',
        'From abstract Route<T> down to MaterialPageRoute<T>',
        Icons.account_tree_outlined,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        decoration: BoxDecoration(
          color: rail,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: brass, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hierarchyNode(
              'Route<T>',
              'abstract entry in the Navigator stack',
              burgundyDeep,
              true,
            ),
            downArrow(),
            hierarchyNode(
              'OverlayRoute<T>',
              'manages OverlayEntry instances',
              burgundy,
              true,
            ),
            downArrow(),
            hierarchyNode(
              'TransitionRoute<T>',
              'drives forward/reverse animation',
              burgundy,
              true,
            ),
            downArrow(),
            hierarchyNode(
              'ModalRoute<T>',
              'blocks input via a ModalBarrier',
              burgundySoft,
              true,
            ),
            downArrow(),
            hierarchyNode(
              'PageRoute<T>',
              'full-screen, opaque page with hero animation',
              burgundySoft,
              true,
            ),
            downArrow(),
            hierarchyNode(
              'MaterialPageRoute<T>',
              'platform-aware slide+fade transition',
              signalGreen,
              false,
            ),
          ],
        ),
      ),
      parchmentCard('Capability progression', <Widget>[
        propRow('Route<T>', 'install / didPush / dispose'),
        propRow('OverlayRoute<T>', '+ createOverlayEntries'),
        propRow('TransitionRoute<T>', '+ animation, secondaryAnimation'),
        propRow('ModalRoute<T>', '+ barrierColor, barrierDismissible'),
        propRow('PageRoute<T>', '+ fullscreenDialog, allowSnapshotting'),
        propRow('MaterialPageRoute<T>', '+ platform-specific transitions'),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 4 — Constructor anatomy (boarding pass)
  // ========================================================================
  print('pageroute_test: section 4 — constructor anatomy boarding pass');

  Widget boardingPassRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100.0,
            child: Text(
              label,
              style: const TextStyle(
                color: cream,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: brassLight,
              fontFamily: 'monospace',
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #49, P1):
  // The boarding-pass Row uses `crossAxisAlignment: stretch` so the
  // left brass strip and the right "SEAT 07A" box span the full pass
  // height. That works inside a Row whose vertical extent is bounded,
  // but this widget lives in `SingleChildScrollView > Column(stretch)`
  // where vertical constraints are unbounded — Flutter throws
  // "BoxConstraints forces an infinite height" because the stretch
  // children are asked to fill an infinite axis. Wrapping the Row in
  // `IntrinsicHeight` resolves the stretch against the Expanded
  // middle column's intrinsic height (the tallest non-stretch child),
  // so the strip and seat box stretch to a finite, content-derived
  // height.
  final Widget boardingPass = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: burgundyDeep,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: brass, width: 1.5),
    ),
    child: IntrinsicHeight(
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          width: 12.0,
          decoration: const BoxDecoration(
            color: brass,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'BOARDING PASS — Constructor',
                      style: TextStyle(
                        color: brassLight,
                        fontSize: 11.0,
                        letterSpacing: 2.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.confirmation_number, color: brass, size: 22.0),
                  ],
                ),
                const SizedBox(height: 4.0),
                Container(height: 1.0, color: brass.withOpacity(0.4)),
                const SizedBox(height: 8.0),
                boardingPassRow('CLASS', 'MaterialPageRoute<T>'),
                boardingPassRow('TRACK', 'Material → PageRoute → ModalRoute'),
                boardingPassRow('FACTORY', 'const not supported'),
                boardingPassRow('RESULT', 'Future<T?>'),
                const SizedBox(height: 6.0),
                Text(
                  'Tear here to push onto the Navigator stack.',
                  style: TextStyle(
                    color: brassLight,
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 70.0,
          decoration: BoxDecoration(
            color: burgundy,
            border: Border(
              left: BorderSide(color: brass.withOpacity(0.4), width: 1.0, style: BorderStyle.solid),
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'SEAT',
                style: TextStyle(
                  color: brassLight,
                  fontSize: 9.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '07A',
                style: TextStyle(
                  color: brass,
                  fontFamily: 'monospace',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    ),
  );

  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '04',
        'Constructor anatomy',
        'Every parameter on the boarding pass',
        Icons.confirmation_number_outlined,
      ),
      boardingPass,
      parchmentCard('Parameter table', <Widget>[
        paramRow('builder', 'WidgetBuilder', 'required', 'The page contents — receives a BuildContext.'),
        paramRow('settings', 'RouteSettings?', 'null', 'Name and arguments associated with this route.'),
        paramRow('maintainState', 'bool', 'true', 'If false, the route is destroyed when not visible.'),
        paramRow('fullscreenDialog', 'bool', 'false', 'Vertical slide + close icon instead of back arrow.'),
        paramRow('allowSnapshotting', 'bool', 'true', 'Permits rasterized snapshots during transitions.'),
        paramRow('barrierDismissible', 'bool', 'false', 'Whether tapping the barrier dismisses the route.'),
      ]),
      parchmentCard('Inherited from ModalRoute / TransitionRoute', <Widget>[
        paramRow('barrierColor', 'Color?', 'null', 'Modal scrim color; null means no scrim.'),
        paramRow('barrierLabel', 'String?', 'null', 'Semantic label announced for the barrier.'),
        paramRow('opaque', 'bool', 'true', 'PageRoute is always opaque by default.'),
        paramRow('transitionDuration', 'Duration', '300ms', 'Forward animation length.'),
        paramRow('reverseTransitionDuration', 'Duration', '300ms', 'Reverse animation length.'),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 5 — Live specimen property table
  // ========================================================================
  print('pageroute_test: section 5 — live specimens');

  Widget specimenCard(String name, MaterialPageRoute<dynamic> route, Color tint) {
    final String settingsName = safeStr(() => '${route.settings.name}');
    final String settingsArgs = safeStr(() => '${route.settings.arguments}');
    final String fsDialog = safeStr(() => '${route.fullscreenDialog}');
    final String maintain = safeStr(() => '${route.maintainState}');
    final String opaque = safeStr(() => '${route.opaque}');
    final String barrierC = safeStr(() => '${route.barrierColor}');
    final String tDur = safeStr(() => '${route.transitionDuration}');
    final String rtDur = safeStr(() => '${route.reverseTransitionDuration}');
    final String allowSnap = safeStr(() => '${route.allowSnapshotting}');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: brass, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.directions_train, color: brassLight, size: 18.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: cream,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                chip('LIVE', signalGreen, Colors.white),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                propRow('settings.name', settingsName),
                propRow('settings.arguments', settingsArgs),
                propRow('fullscreenDialog', fsDialog),
                propRow('maintainState', maintain),
                propRow('opaque', opaque),
                propRow('barrierColor', barrierC),
                propRow('transitionDuration', tDur),
                propRow('reverseTransitionDuration', rtDur),
                propRow('allowSnapshotting', allowSnap),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '05',
        'Live specimens',
        'Five constructed routes with their properties exposed',
        Icons.science_outlined,
      ),
      specimenCard('Standard route — /timetable', standardRoute, burgundy),
      specimenCard('Fullscreen dialog — /ticket-booth', dialogRoute, burgundyDeep),
      specimenCard('Ephemeral route — /announcement', ephemeralRoute, burgundySoft),
      specimenCard('Typed (String) — /pick-destination', stringResultRoute, burgundy),
      specimenCard('Typed (bool) — /confirm-boarding', boolResultRoute, burgundyDeep),
      parchmentCard('Reading order', <Widget>[
        bodyLine(
          'These properties are safe to read before the route is attached '
          'to a Navigator. Properties that depend on the route\'s '
          'animation (e.g., animation.value) require the route to be '
          'installed first — those reads are wrapped in try/catch.',
        ),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 6 — Transition snapshot strip
  // ========================================================================
  print('pageroute_test: section 6 — transition snapshots');

  Widget snapshotFrame(double t, String label, bool isHorizontal) {
    // Compose a faux snapshot of the slide+fade transition. The page
    // appears from the right (or bottom for fullscreenDialog) and fades
    // in. We never animate; we draw a single still frame.
    final double dx = isHorizontal ? (1.0 - t) * 80.0 : 0.0;
    final double dy = isHorizontal ? 0.0 : (1.0 - t) * 80.0;
    final double opacity = t;
    return Container(
      width: 130.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: ink,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: brass, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            alignment: Alignment.center,
            child: Text(
              't = ${t.toStringAsFixed(2)}',
              style: const TextStyle(
                color: brassLight,
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(height: 1.0, color: brass.withOpacity(0.4)),
          Container(
            height: 110.0,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 110.0,
                  height: 95.0,
                  decoration: BoxDecoration(
                    color: burgundyDeep.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'prev',
                    style: TextStyle(
                      color: cream.withOpacity(0.45),
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(dx, dy),
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      width: 110.0,
                      height: 95.0,
                      decoration: BoxDecoration(
                        color: burgundy,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: brass, width: 0.8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'next',
                        style: TextStyle(
                          color: brassLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            alignment: Alignment.center,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: brass,
                fontSize: 10.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '06',
        'Transition snapshots',
        'Still frames at t=0.0, 0.25, 0.5, 0.75, 1.0',
        Icons.movie_outlined,
      ),
      parchmentCard('Standard (horizontal slide + fade)', <Widget>[
        bodyLine(
          'On iOS, MaterialPageRoute uses a horizontal slide. On Android, '
          'an upward fade. The frames below approximate the iOS variant.',
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              snapshotFrame(0.0, 'about to arrive', true),
              snapshotFrame(0.25, 'arriving', true),
              snapshotFrame(0.5, 'mid-transition', true),
              snapshotFrame(0.75, 'almost docked', true),
              snapshotFrame(1.0, 'fully installed', true),
            ],
          ),
        ),
      ]),
      parchmentCard('Fullscreen dialog (vertical slide + fade)', <Widget>[
        bodyLine(
          'When fullscreenDialog is true, the page slides up from the '
          'bottom of the screen and the leading button becomes a close '
          'icon instead of a back arrow.',
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              snapshotFrame(0.0, 'rising', false),
              snapshotFrame(0.25, 'rising', false),
              snapshotFrame(0.5, 'mid-rise', false),
              snapshotFrame(0.75, 'almost set', false),
              snapshotFrame(1.0, 'docked', false),
            ],
          ),
        ),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 7 — fullscreenDialog vs standard comparison
  // ========================================================================
  print('pageroute_test: section 7 — fullscreenDialog vs standard');

  Widget compareCard(String title, IconData icon, Color bg, List<String> bullets) {
    final List<Widget> rows = <Widget>[];
    for (final String b in bullets) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.fiber_manual_record, size: 7.0, color: brass),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  b,
                  style: const TextStyle(
                    color: cream,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: brass, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: brassLight, size: 26.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: cream,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Container(height: 1.0, color: brass.withOpacity(0.4)),
            const SizedBox(height: 6.0),
            ...rows,
          ],
        ),
      ),
    );
  }

  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '07',
        'fullscreenDialog vs standard',
        'Two routing flavours, two different gestures',
        Icons.compare_arrows,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            compareCard(
              'Standard route',
              Icons.arrow_back,
              burgundy,
              <String>[
                'Horizontal slide on iOS, upward fade on Android.',
                'Leading button is a back arrow.',
                'Swipe-back gesture supported on iOS.',
                'Use for in-flow navigation steps.',
                'fullscreenDialog: false (default).',
              ],
            ),
            compareCard(
              'Fullscreen dialog',
              Icons.close,
              burgundyDeep,
              <String>[
                'Vertical slide from bottom on both platforms.',
                'Leading button is a close (X) icon.',
                'No swipe-back gesture by default.',
                'Use for modal tasks (compose, settings).',
                'fullscreenDialog: true.',
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ========================================================================
  // SECTION 8 — PageRouteBuilder showcase
  // ========================================================================
  print('pageroute_test: section 8 — PageRouteBuilder showcase');

  // Construct PageRouteBuilder specimens with different transitionsBuilder
  // implementations. We do not push them, only inspect them.
  final PageRouteBuilder<dynamic> fadeBuilder = PageRouteBuilder<dynamic>(
    settings: const RouteSettings(name: '/fade'),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (BuildContext ctx, Animation<double> a, Animation<double> b) {
      return placeholderPage('Fade Page', burgundy);
    },
    transitionsBuilder: (BuildContext ctx, Animation<double> a, Animation<double> b, Widget child) {
      return FadeTransition(opacity: a, child: child);
    },
  );

  final PageRouteBuilder<dynamic> slideBuilder = PageRouteBuilder<dynamic>(
    settings: const RouteSettings(name: '/slide'),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (BuildContext ctx, Animation<double> a, Animation<double> b) {
      return placeholderPage('Slide Page', burgundyDeep);
    },
    transitionsBuilder: (BuildContext ctx, Animation<double> a, Animation<double> b, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(a),
        child: child,
      );
    },
  );

  final PageRouteBuilder<dynamic> scaleBuilder = PageRouteBuilder<dynamic>(
    settings: const RouteSettings(name: '/scale'),
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (BuildContext ctx, Animation<double> a, Animation<double> b) {
      return placeholderPage('Scale Page', burgundySoft);
    },
    transitionsBuilder: (BuildContext ctx, Animation<double> a, Animation<double> b, Widget child) {
      return ScaleTransition(scale: a, child: child);
    },
  );

  final PageRouteBuilder<dynamic> rotationBuilder = PageRouteBuilder<dynamic>(
    settings: const RouteSettings(name: '/rotate'),
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (BuildContext ctx, Animation<double> a, Animation<double> b) {
      return placeholderPage('Rotate Page', burgundy);
    },
    transitionsBuilder: (BuildContext ctx, Animation<double> a, Animation<double> b, Widget child) {
      return RotationTransition(turns: a, child: child);
    },
  );

  // Build snapshot-style cards showing each transition wrapping a sample
  // child. We use AlwaysStoppedAnimation to drive the transition at a
  // fixed value, so the visual is deterministic.
  Widget sampleChild(String label, Color tint) {
    return Container(
      width: 110.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: brass, width: 1.0),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: cream,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget builderCard(String title, String routeName, Duration dur, Widget sample) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: brass, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 130.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: ink,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: brass.withOpacity(0.5), width: 0.8),
            ),
            alignment: Alignment.center,
            child: sample,
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: burgundyDeep,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(children: <Widget>[
                  chip('settings.name', burgundy, cream),
                  const SizedBox(width: 6.0),
                  Text(routeName, style: monoStyle),
                ]),
                const SizedBox(height: 4.0),
                Row(children: <Widget>[
                  chip('duration', signalAmber, Colors.white),
                  const SizedBox(width: 6.0),
                  Text('${dur.inMilliseconds}ms', style: monoStyle),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Use Always-stopped animation at t=0.5 for visible mid-transition.
  final Animation<double> mid = const AlwaysStoppedAnimation<double>(0.5);
  final Animation<double> end = const AlwaysStoppedAnimation<double>(1.0);

  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '08',
        'PageRouteBuilder showcase',
        'Custom transitions via transitionsBuilder',
        Icons.transform,
      ),
      parchmentCard('Four custom transitions', <Widget>[
        bodyLine(
          'PageRouteBuilder accepts a pageBuilder (the contents) and a '
          'transitionsBuilder (how it arrives). The transitionsBuilder '
          'receives the route animation, secondary animation, and the '
          'built child, and wraps the child in any animated widget.',
        ),
      ]),
      builderCard(
        'FadeTransition',
        fadeBuilder.settings.name ?? '',
        fadeBuilder.transitionDuration,
        FadeTransition(opacity: mid, child: sampleChild('fade', burgundy)),
      ),
      builderCard(
        'SlideTransition',
        slideBuilder.settings.name ?? '',
        slideBuilder.transitionDuration,
        SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.5, 0.0), end: Offset.zero).animate(mid),
          child: sampleChild('slide', burgundyDeep),
        ),
      ),
      builderCard(
        'ScaleTransition',
        scaleBuilder.settings.name ?? '',
        scaleBuilder.transitionDuration,
        ScaleTransition(scale: mid, child: sampleChild('scale', burgundySoft)),
      ),
      builderCard(
        'RotationTransition',
        rotationBuilder.settings.name ?? '',
        rotationBuilder.transitionDuration,
        RotationTransition(
          turns: const AlwaysStoppedAnimation<double>(0.125),
          child: sampleChild('rotate', burgundy),
        ),
      ),
      parchmentCard('Combining transitions', <Widget>[
        bodyLine(
          'Multiple transitions can be composed by nesting: e.g., a fade '
          'around a slide. The transitionsBuilder is a plain widget '
          'builder; you can wrap with Transform, Opacity, ClipRect, or '
          'any animated widget.',
        ),
        const SizedBox(height: 8.0),
        Container(
          width: 130.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: brass.withOpacity(0.5), width: 0.8),
          ),
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: end,
            child: ScaleTransition(
              scale: mid,
              child: sampleChild('fade+scale', burgundyDeep),
            ),
          ),
        ),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 9 — Result type T demonstration
  // ========================================================================
  print('pageroute_test: section 9 — result type T');

  Widget typedRouteCard(String title, String t, String example, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: brass, width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black26, blurRadius: 3.0, offset: Offset(0.0, 2.0)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  t.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: cream,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: burgundyDeep,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: ink,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              example,
              style: const TextStyle(
                color: brassLight,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '09',
        'Result type T',
        'Pushing a route returns Future<T?>',
        Icons.swap_horizontal_circle_outlined,
      ),
      typedRouteCard(
        'MaterialPageRoute<String>',
        'String',
        'final String? city = await Navigator.push<String>(\n'
            '  context,\n'
            '  MaterialPageRoute<String>(\n'
            '    builder: (ctx) => CityPicker(),\n'
            '  ),\n'
            ');\n'
            '// in CityPicker: Navigator.pop(context, "Vienna");',
        burgundy,
      ),
      typedRouteCard(
        'MaterialPageRoute<bool>',
        'bool',
        'final bool? confirmed = await Navigator.push<bool>(\n'
            '  context,\n'
            '  MaterialPageRoute<bool>(\n'
            '    fullscreenDialog: true,\n'
            '    builder: (ctx) => ConfirmDialog(),\n'
            '  ),\n'
            ');\n'
            '// in ConfirmDialog: Navigator.pop(context, true);',
        burgundyDeep,
      ),
      typedRouteCard(
        'MaterialPageRoute<MyModel>',
        'MyModel',
        'final Ticket? t = await Navigator.push<Ticket>(\n'
            '  context,\n'
            '  MaterialPageRoute<Ticket>(\n'
            '    builder: (ctx) => TicketEditor(),\n'
            '  ),\n'
            ');\n'
            '// in TicketEditor: Navigator.pop(context, ticket);',
        burgundySoft,
      ),
      parchmentCard('Why Future<T?> and not Future<T>', <Widget>[
        bodyLine(
          'Routes can be popped without a value (via the back button, '
          'gesture, or Navigator.pop without a second argument). In that '
          'case the future completes with null. Always handle the '
          'nullable return.',
        ),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 10 — Lifecycle ladder
  // ========================================================================
  print('pageroute_test: section 10 — lifecycle ladder');

  Widget ladderRung(int n, String name, String role) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 2.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: burgundy,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: brass, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: ink,
              shape: BoxShape.circle,
              border: Border.all(color: brass, width: 1.2),
            ),
            alignment: Alignment.center,
            child: Text(
              '$n',
              style: const TextStyle(
                color: brass,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          SizedBox(
            width: 170.0,
            child: Text(
              name,
              style: const TextStyle(
                color: brassLight,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              role,
              style: const TextStyle(
                color: cream,
                fontSize: 12.0,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '10',
        'Lifecycle ladder',
        'install → didPush → ... → dispose',
        Icons.stairs_outlined,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        decoration: BoxDecoration(
          color: rail,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: brass, width: 1.2),
        ),
        child: Column(
          children: <Widget>[
            ladderRung(1, 'install()', 'Adds overlay entries and prepares the route.'),
            ladderRung(2, 'didPush()', 'Called when pushed; returns the entry animation future.'),
            ladderRung(3, 'didChangeNext()', 'Notified when a new route is pushed on top.'),
            ladderRung(4, 'didChangePrevious()', 'Notified when the route below changes.'),
            ladderRung(5, 'didPopNext()', 'Notified when the route on top pops off.'),
            ladderRung(6, 'didPop(result)', 'Called when this route is popped; emits result.'),
            ladderRung(7, 'dispose()', 'Tear down. Single-use: cannot be pushed again.'),
          ],
        ),
      ),
      parchmentCard('RouteAware', <Widget>[
        bodyLine(
          'Widgets in a route can implement RouteAware and register with a '
          'RouteObserver to receive didPush/didPop/didPushNext/didPopNext '
          'callbacks. This is the canonical way to know "my screen is now '
          'visible" or "another screen covered mine".',
        ),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 11 — Recipe cards
  // ========================================================================
  print('pageroute_test: section 11 — recipe cards');

  Widget recipe(String title, String when, String code, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: brass, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: burgundy,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(icon, color: brassLight, size: 20.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: cream,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  when,
                  style: const TextStyle(
                    color: burgundyDeep,
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: ink,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    code,
                    style: const TextStyle(
                      color: brassLight,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '11',
        'Recipe cards',
        'Common navigation patterns at a glance',
        Icons.menu_book_outlined,
      ),
      recipe(
        'Basic push',
        'Push and forget — no result handling needed.',
        'Navigator.push(\n'
            '  context,\n'
            '  MaterialPageRoute(builder: (ctx) => DetailPage()),\n'
            ');',
        Icons.north_east,
      ),
      recipe(
        'Push and await result',
        'Wait for the pushed page to pop with a value.',
        'final result = await Navigator.push<String>(\n'
            '  context,\n'
            '  MaterialPageRoute<String>(\n'
            '    builder: (ctx) => CityPicker(),\n'
            '  ),\n'
            ');',
        Icons.swap_horiz,
      ),
      recipe(
        'pushReplacement',
        'Replace the current route (e.g., login → home).',
        'Navigator.pushReplacement(\n'
            '  context,\n'
            '  MaterialPageRoute(builder: (ctx) => HomePage()),\n'
            ');',
        Icons.swap_vert,
      ),
      recipe(
        'pushAndRemoveUntil',
        'Push a new route and clear the stack down to a predicate.',
        'Navigator.pushAndRemoveUntil(\n'
            '  context,\n'
            '  MaterialPageRoute(builder: (ctx) => HomePage()),\n'
            '  (Route<dynamic> route) => false,\n'
            ');',
        Icons.delete_sweep_outlined,
      ),
      recipe(
        'popUntil',
        'Pop until a route matching a predicate is on top.',
        'Navigator.popUntil(\n'
            '  context,\n'
            '  ModalRoute.withName("/home"),\n'
            ');',
        Icons.south_west,
      ),
      recipe(
        'Pop with result',
        'Deliver a value to the awaiting future.',
        'Navigator.pop<bool>(context, true);',
        Icons.check_circle_outline,
      ),
      recipe(
        'Named routes',
        'Push via name lookup configured in MaterialApp.routes.',
        'Navigator.pushNamed(\n'
            '  context,\n'
            '  "/detail",\n'
            '  arguments: {"id": 42},\n'
            ');',
        Icons.label_outline,
      ),
    ],
  );

  // ========================================================================
  // SECTION 12 — Comparison table
  // ========================================================================
  print('pageroute_test: section 12 — comparison table');

  Widget tableRow(
    String col1,
    String col2,
    String col3,
    String col4,
    String col5,
    Color bg,
    Color fg,
    bool isHeader,
  ) {
    final TextStyle s = TextStyle(
      color: fg,
      fontSize: isHeader ? 12.0 : 11.5,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      fontFamily: isHeader ? null : 'monospace',
      letterSpacing: isHeader ? 0.6 : 0.0,
    );
    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 130.0, child: Text(col1, style: s)),
          SizedBox(width: 90.0, child: Text(col2, style: s)),
          SizedBox(width: 110.0, child: Text(col3, style: s)),
          SizedBox(width: 80.0, child: Text(col4, style: s)),
          Expanded(child: Text(col5, style: s)),
        ],
      ),
    );
  }

  final Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '12',
        'Route comparison',
        'MaterialPageRoute vs Cupertino vs Builder vs Dialog',
        Icons.table_chart_outlined,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: brass, width: 1.2),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: <Widget>[
            tableRow(
              'Route type',
              'Platform',
              'Default transition',
              'Gesture',
              'Notes',
              burgundyDeep,
              cream,
              true,
            ),
            tableRow(
              'MaterialPageRoute',
              'Material',
              'slide+fade',
              'iOS swipe',
              'Adapts to platform; default for MaterialApp navigation.',
              creamSoft,
              ink,
              false,
            ),
            tableRow(
              'CupertinoPageRoute',
              'Cupertino',
              'horizontal slide',
              'iOS swipe',
              'iOS-style; identical transition cross-platform.',
              cream,
              ink,
              false,
            ),
            tableRow(
              'PageRouteBuilder',
              'any',
              'caller-defined',
              'depends',
              'Bring-your-own transition via transitionsBuilder.',
              creamSoft,
              ink,
              false,
            ),
            tableRow(
              'DialogRoute',
              'Material',
              'fade',
              'barrier-tap',
              'For showDialog; non-opaque with barrierColor.',
              cream,
              ink,
              false,
            ),
            tableRow(
              'ModalBottomSheetRoute',
              'Material',
              'slide-up',
              'drag-down',
              'For showModalBottomSheet; bottom-anchored.',
              creamSoft,
              ink,
              false,
            ),
          ],
        ),
      ),
      parchmentCard('Choosing the right route', <Widget>[
        bodyLine(
          'For most app-level navigation, MaterialPageRoute is correct: '
          'it adapts to the platform. Reach for PageRouteBuilder when '
          'you need a bespoke transition that the Material/Cupertino '
          'defaults cannot express.',
        ),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 13 — Pitfalls
  // ========================================================================
  print('pageroute_test: section 13 — pitfalls');

  Widget pitfallCard(IconData icon, String title, String body, Color signal) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: signal, width: 1.4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(color: signal, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 24.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: burgundyDeep,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
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

  final Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '13',
        'Pitfalls',
        'Common mistakes and how to avoid them',
        Icons.warning_amber_outlined,
      ),
      pitfallCard(
        Icons.error_outline,
        'Routes are single-use',
        'A MaterialPageRoute instance must not be reused after it has '
            'been popped. Always construct a new instance for each push.',
        signalRed,
      ),
      pitfallCard(
        Icons.error_outline,
        'Build inside the builder, not outside',
        'Place widget construction inside the builder callback so it runs '
            'with the correct BuildContext and InheritedWidget scope. '
            'Building outside captures stale context.',
        signalRed,
      ),
      pitfallCard(
        Icons.warning_amber,
        'settings.arguments is dynamic',
        'RouteSettings.arguments has type Object?. Always cast or type-'
            'check before use, or use a typed pageBuilder/onGenerateRoute '
            'wrapper that does the cast in one place.',
        signalAmber,
      ),
      pitfallCard(
        Icons.warning_amber,
        'Awaited push may return null',
        'If the user dismisses the pushed route without supplying a '
            'value (swipe-back, back button), the future completes with '
            'null. Always handle that case.',
        signalAmber,
      ),
      pitfallCard(
        Icons.warning_amber,
        'maintainState: false',
        'When false, the route is destroyed when not visible. State '
            'inside the route is lost. Use only for ephemeral pages.',
        signalAmber,
      ),
      pitfallCard(
        Icons.info_outline,
        'fullscreenDialog changes the leading button',
        'Setting fullscreenDialog: true causes AppBar to use a close (X) '
            'icon instead of a back arrow. This is automatic and usually '
            'desirable, but worth knowing.',
        signalGreen,
      ),
    ],
  );

  // ========================================================================
  // SECTION 14 — Glossary
  // ========================================================================
  print('pageroute_test: section 14 — glossary');

  Widget glossaryEntry(String term, String def) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: creamSoft,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: brass.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              term,
              style: const TextStyle(
                color: burgundyDeep,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              def,
              style: const TextStyle(
                color: ink,
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '14',
        'Glossary',
        'Vocabulary of Material navigation',
        Icons.menu_book,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: brass, width: 1.0),
        ),
        child: Column(
          children: <Widget>[
            glossaryEntry('Navigator',
                'Widget that manages a stack of Route<T> objects. '
                'Found at the root of MaterialApp.'),
            glossaryEntry('Overlay',
                'A stack of OverlayEntry widgets layered on top of the '
                'app. Routes install entries here.'),
            glossaryEntry('OverlayEntry',
                'A single layer in the overlay; a route can install '
                'multiple to support layered content.'),
            glossaryEntry('ModalBarrier',
                'The full-screen widget that blocks input behind a '
                'modal route; can be tinted via barrierColor.'),
            glossaryEntry('Hero',
                'Widget that animates a shared element between two '
                'routes during a push/pop transition.'),
            glossaryEntry('MaterialPageRoute<T>',
                'Concrete PageRoute that uses platform-appropriate '
                'slide+fade transitions.'),
            glossaryEntry('PageRoute<T>',
                'Abstract opaque modal route covering the full screen.'),
            glossaryEntry('TransitionRoute<T>',
                'Abstract Route that drives an animation for entry '
                'and exit.'),
            glossaryEntry('ModalRoute<T>',
                'Abstract Route with a modal barrier and focus '
                'management.'),
            glossaryEntry('OverlayRoute<T>',
                'Abstract Route that installs OverlayEntry instances.'),
            glossaryEntry('RouteSettings',
                'Immutable name + arguments pair attached to a route.'),
            glossaryEntry('NavigatorState',
                'State object exposing push/pop/replace methods. '
                'Accessed via Navigator.of(context).'),
            glossaryEntry('RouteAware',
                'Mixin for widgets that want to be notified when '
                'their route\'s visibility changes.'),
            glossaryEntry('RouteObserver',
                'NavigatorObserver subclass that dispatches RouteAware '
                'callbacks to subscribed widgets.'),
            glossaryEntry('HeroController',
                'NavigatorObserver that coordinates Hero animations '
                'between routes.'),
          ],
        ),
      ),
    ],
  );

  // ========================================================================
  // SECTION 15 — Cupertino comparison cameo
  // ========================================================================
  print('pageroute_test: section 15 — Cupertino cameo');

  final CupertinoPageRoute<dynamic> cupertinoSpecimen = CupertinoPageRoute<dynamic>(
    settings: const RouteSettings(name: '/cupertino-cameo'),
    builder: (BuildContext ctx) => placeholderPage('Cupertino', burgundyDeep),
  );

  final Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionHeader(
        '15',
        'Cupertino cameo',
        'CupertinoPageRoute side-by-side',
        Icons.apple,
      ),
      parchmentCard('CupertinoPageRoute properties', <Widget>[
        propRow('settings.name', safeStr(() => '${cupertinoSpecimen.settings.name}')),
        propRow('fullscreenDialog', safeStr(() => '${cupertinoSpecimen.fullscreenDialog}')),
        propRow('maintainState', safeStr(() => '${cupertinoSpecimen.maintainState}')),
        propRow('opaque', safeStr(() => '${cupertinoSpecimen.opaque}')),
        propRow('transitionDuration', safeStr(() => '${cupertinoSpecimen.transitionDuration}')),
      ]),
      parchmentCard('When to pick which', <Widget>[
        bodyLine(
          'MaterialPageRoute adapts: on iOS it already mimics the '
          'Cupertino transition. Reach for CupertinoPageRoute only '
          'when you want the iOS look on every platform — including '
          'Android — for an app that intentionally pursues an iOS '
          'aesthetic.',
        ),
      ]),
    ],
  );

  // ========================================================================
  // SECTION 16 — Epilogue
  // ========================================================================
  print('pageroute_test: section 16 — epilogue');

  final Widget epilogue = Container(
    width: double.infinity,
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[burgundyDeep, ink],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brass, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.train, color: brass, size: 30.0),
            const SizedBox(width: 10.0),
            Text(
              'END OF LINE',
              style: TextStyle(
                color: brassLight,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 4.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Icon(Icons.train, color: brass, size: 30.0),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: brass.withOpacity(0.4)),
          ),
          child: Text(
            'MaterialPageRoute<T> is the locomotive of Material '
            'navigation. It carries a builder, a settings object, a '
            'result type, and a transition. Most apps will use it '
            'directly for in-flow navigation, and reach for '
            'PageRouteBuilder only when the stock transition is not '
            'enough.\n\n'
            'Remember: routes are single-use, T can be anything that '
            'survives a Navigator.pop, fullscreenDialog flips the slide '
            'axis, and Future<T?> is always nullable.',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: cream,
              fontSize: 13.0,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            chip('SPECIMENS: ${allRoutes.length}', burgundy, brassLight),
            chip('SECTIONS: 16', burgundy, brassLight),
            chip('THEME: GRAND CENTRAL', burgundy, brassLight),
          ],
        ),
      ],
    ),
  );

  // ------------------------------------------------------------------------
  // Final assembly
  // ------------------------------------------------------------------------
  print('pageroute_test: assembling final widget tree');

  return Container(
    color: steam,
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          brassDivider(),
          section2,
          brassDivider(),
          section3,
          brassDivider(),
          section4,
          brassDivider(),
          section5,
          brassDivider(),
          section6,
          brassDivider(),
          section7,
          brassDivider(),
          section8,
          brassDivider(),
          section9,
          brassDivider(),
          section10,
          brassDivider(),
          section11,
          brassDivider(),
          section12,
          brassDivider(),
          section13,
          brassDivider(),
          section14,
          brassDivider(),
          section15,
          brassDivider(),
          epilogue,
        ],
      ),
    ),
  );
}
