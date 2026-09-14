// D4rt visual demo: PrimaryPointerGestureRecognizer (abstract base class)
// from package:flutter/gestures.dart.
//
// PrimaryPointerGestureRecognizer is the second tier of Flutter's gesture
// recognizer hierarchy. It sits between OneSequenceGestureRecognizer (which
// just promises to track one pointer sequence at a time) and the concrete
// recognisers an app actually uses (TapGestureRecognizer,
// LongPressGestureRecognizer, ForcePressGestureRecognizer, the
// BaseTapAndDragGestureRecognizer family). Its job is narrower than its
// parent's: it picks the FIRST pointer that lands on its target and treats
// that one pointer as the "primary" pointer for the entire gesture, ignoring
// any other pointers that arrive in the meantime. It also adds two extra
// pieces of machinery: a deadline timer and a slop tolerance pair.
//
// This file is a hand-authored static reference card. It does not animate,
// does not subscribe to any pointer streams, and does not instantiate
// PrimaryPointerGestureRecognizer directly (the class is abstract and
// cannot be constructed). Instead it walks through the API surface, the
// lifecycle states, the slop geometry, the override hooks, and a handful of
// real-world subclass examples. The harness invokes build() once and
// renders the resulting widget tree.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Type literals from package:flutter/gestures.dart, referenced here to
// document the API surface this demo describes. Touching these types at
// the top level keeps the gestures import meaningful without instantiating
// the abstract recognizer class itself.
const Type kPrimaryPointerOffsetPairType = OffsetPair;
const Type kPrimaryPointerDeviceKindType = PointerDeviceKind;

dynamic build(BuildContext context) {
  const Color goldDeep = Color(0xFF7C4A00);
  const Color goldRich = Color(0xFFB8860B);
  const Color goldBright = Color(0xFFE3A82B);
  const Color amberSoft = Color(0xFFFFD180);
  const Color amberPale = Color(0xFFFFF3D6);
  const Color parchment = Color(0xFFFFF8E7);
  const Color inkDark = Color(0xFF2B1B00);
  const Color inkMedium = Color(0xFF4F3A12);
  const Color slateMute = Color(0xFF6E5A2E);

  // ==================================================================
  // SECTION 1: Hero header
  // ==================================================================
  final Widget heroHeader = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF3A2400),
            Color(0xFF7C4A00),
            Color(0xFFB8860B),
            Color(0xFFE3A82B),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x66B8860B),
            blurRadius: 28.0,
            offset: Offset(0.0, 12.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Color(0x33FFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  border: Border.fromBorderSide(
                    BorderSide(color: Color(0x66FFFFFF), width: 1.0),
                  ),
                ),
                child: Icon(
                  Icons.touch_app,
                  size: 44.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 18.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'PrimaryPointerGestureRecognizer',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'package:flutter/gestures.dart  ·  abstract class',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFFFE9B0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18.0),
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Color(0x40000000),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Text(
              'Tracks ONE primary pointer through down, move, and up events. '
              'Picks the first pointer to land and ignores all others until '
              'the gesture resolves. Adds a deadline timer for time-based '
              'recognition (long-press, force-press) and a pre/post-accept '
              'slop tolerance pair so subclasses can decide how far the '
              'finger may wander before the gesture cancels.',
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.white,
                height: 1.55,
              ),
            ),
          ),
          SizedBox(height: 14.0),
          Wrap(
            spacing: 10.0,
            runSpacing: 8.0,
            children: <Widget>[
              Chip(
                backgroundColor: Color(0xFFFFE082),
                label: Text(
                  'abstract',
                  style: TextStyle(
                    color: Color(0xFF3A2400),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Chip(
                backgroundColor: Color(0xFFFFD54F),
                label: Text(
                  'one primary pointer',
                  style: TextStyle(color: Color(0xFF3A2400)),
                ),
              ),
              Chip(
                backgroundColor: Color(0xFFFFCA28),
                label: Text(
                  'deadline timer',
                  style: TextStyle(color: Color(0xFF3A2400)),
                ),
              ),
              Chip(
                backgroundColor: Color(0xFFFFB300),
                label: Text(
                  'slop tolerance',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 2: Class hierarchy diagram
  // ==================================================================
  final Widget hierarchySection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.account_tree, color: goldDeep, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'Section 2 · Class hierarchy',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3D6),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.fromBorderSide(
                BorderSide(color: Color(0xFFE0B95E), width: 1.0),
              ),
            ),
            child: Text(
              'GestureRecognizer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14.0,
                color: inkDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text('│', style: TextStyle(color: goldRich, fontSize: 18.0)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFE9B0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.fromBorderSide(
                BorderSide(color: Color(0xFFD4A442), width: 1.0),
              ),
            ),
            child: Text(
              'OneSequenceGestureRecognizer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14.0,
                color: inkDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text('│', style: TextStyle(color: goldRich, fontSize: 18.0)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[goldRich, goldBright],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Text(
              'PrimaryPointerGestureRecognizer  ◄── this class',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              '├── TapGestureRecognizer (via BaseTapGestureRecognizer)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: inkMedium,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              '├── LongPressGestureRecognizer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: inkMedium,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              '├── ForcePressGestureRecognizer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: inkMedium,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              '└── BaseTapAndDragGestureRecognizer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: inkMedium,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 56.0),
            child: Text(
              '├── TapAndPanGestureRecognizer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: slateMute,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 56.0),
            child: Text(
              '├── TapAndHorizontalDragGestureRecognizer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: slateMute,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 56.0),
            child: Text(
              '└── TapAndDragGestureRecognizer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: slateMute,
              ),
            ),
          ),
          SizedBox(height: 14.0),
          Text(
            'Each subclass adds its own callbacks (onTap, onLongPress, '
            'onForcePressStart…) but inherits the primary-pointer logic '
            'and the deadline/slop machinery from this layer.',
            style: TextStyle(
              fontSize: 12.5,
              color: inkMedium,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 3: Lifecycle state machine
  // ==================================================================
  final Widget lifecycleSection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFFF8E7), Color(0xFFFFE9B0)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFD4A442), width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.timeline, color: goldDeep, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'Section 3 · Lifecycle state machine',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                width: 96.0,
                height: 96.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFE9B0),
                  border: Border.fromBorderSide(
                    BorderSide(color: goldRich, width: 2.5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'idle',
                  style: TextStyle(
                    color: inkDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.arrow_forward, color: goldDeep, size: 28.0),
                  Text(
                    'down',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: inkMedium,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              Container(
                width: 110.0,
                height: 110.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFD180),
                  border: Border.fromBorderSide(
                    BorderSide(color: goldDeep, width: 2.5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'tracking',
                  style: TextStyle(
                    color: inkDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.call_split, color: goldDeep, size: 28.0),
                  Text(
                    'resolve',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: inkMedium,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 110.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      color: Color(0xFFC8E6C9),
                      border: Border.fromBorderSide(
                        BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'accepted',
                      style: TextStyle(
                        color: Color(0xFF1B5E20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: 110.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      color: Color(0xFFFFCDD2),
                      border: Border.fromBorderSide(
                        BorderSide(color: Color(0xFFC62828), width: 2.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'rejected',
                      style: TextStyle(
                        color: Color(0xFFB71C1C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward, color: goldDeep, size: 28.0),
              Container(
                width: 96.0,
                height: 96.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFE9B0),
                  border: Border.fromBorderSide(
                    BorderSide(color: goldRich, width: 2.5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'idle',
                  style: TextStyle(
                    color: inkDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Color(0x33FFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.fromBorderSide(
                BorderSide(color: Color(0x55B8860B), width: 1.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Transition cheat sheet',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: inkDark,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'idle → tracking : first PointerDownEvent inside hit region\n'
                  'tracking → tracking : PointerMoveEvent within slop bounds\n'
                  'tracking → accepted : arena gives this recognizer the win\n'
                  'tracking → rejected : another recognizer wins or slop exceeded\n'
                  'accepted/rejected → idle : pointer lifts or is cancelled',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: inkMedium,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 4: Constructor parameters
  // ==================================================================
  final Widget paramsHeader = Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: <Widget>[
        Icon(Icons.tune, color: goldDeep, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          'Section 4 · Constructor parameters',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: inkDark,
          ),
        ),
      ],
    ),
  );

  final Widget paramDeadline = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.timer, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'deadline',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'Duration?',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: slateMute,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'default: null   ·   sample: Duration(milliseconds: 500)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: inkMedium,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'If non-null, didExceedDeadline() fires after this duration. '
            'LongPress uses 500ms; ForcePress uses null and resolves on '
            'pressure changes instead.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget paramPreSlop = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.adjust, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'preAcceptSlopTolerance',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'double?',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: slateMute,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'default: kTouchSlop (≈ 18.0)   ·   sample: 12.0',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: inkMedium,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Maximum distance the pointer may travel BEFORE this recognizer '
            'is accepted by the arena. Exceeding it rejects the gesture. '
            'Setting to null disables the pre-accept slop check entirely.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget paramPostSlop = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.adjust, color: goldRich, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'postAcceptSlopTolerance',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'double?',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: slateMute,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'default: null (no post-accept limit)   ·   sample: 36.0',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: inkMedium,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Maximum distance the pointer may travel AFTER acceptance before '
            'the gesture is cancelled. LongPress uses null so the user can '
            'drag freely once the long-press fires.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget paramKind = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.devices, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'kind',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'PointerDeviceKind?  (deprecated)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: slateMute,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'default: null   ·   sample: PointerDeviceKind.touch',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: inkMedium,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Restricts the recognizer to ONE device kind. The match is '
            'exact: PointerDeviceKind.mouse will not catch trackpad events. '
            'Prefer supportedDevices for multi-kind sets.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget paramSupported = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.checklist, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'supportedDevices',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'Set<PointerDeviceKind>?',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: slateMute,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'default: null (all kinds)   ·   sample: { touch, stylus }',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: inkMedium,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Modern replacement for kind. The recognizer ignores any '
            'pointer whose device kind is NOT in this set. If both kind '
            'and supportedDevices are provided, supportedDevices wins.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget paramOwner = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.label, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'debugOwner',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'Object?',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: slateMute,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'default: null   ·   sample: this  // (the State or Widget)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: inkMedium,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Purely diagnostic. Appears in Flutter Inspector and assertion '
            'messages so you can tell which widget owns a recognizer when '
            'multiple are competing in the arena.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget paramsSection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: amberPale,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          paramsHeader,
          paramDeadline,
          paramPreSlop,
          paramPostSlop,
          paramKind,
          paramSupported,
          paramOwner,
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 5: Slop tolerance visualizer
  // ==================================================================
  final Widget slopStage = SizedBox(
    width: 320.0,
    height: 220.0,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Outer post-accept slop circle (radius 90 ≈ visible diameter 180)
        Container(
          width: 180.0,
          height: 180.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0x22B8860B),
            border: Border.fromBorderSide(
              BorderSide(
                color: Color(0xFFB8860B),
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        // Inner pre-accept slop circle (radius 45 ≈ diameter 90)
        Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0x33E3A82B),
            border: Border.fromBorderSide(
              BorderSide(color: Color(0xFFE3A82B), width: 1.5),
            ),
          ),
        ),
        // Centre Down dot
        Container(
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF3A2400),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 4.0,
                offset: Offset(0.0, 1.0),
              ),
            ],
          ),
        ),
        // Path A: stays inside (accepted) — green dot near centre
        Positioned(
          left: 175.0,
          top: 95.0,
          child: SizedBox(
            width: 14.0,
            height: 14.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
        ),
        // Path B: exits inner (rejected) — orange dot just past inner ring
        Positioned(
          left: 215.0,
          top: 70.0,
          child: SizedBox(
            width: 14.0,
            height: 14.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEF6C00),
              ),
            ),
          ),
        ),
        // Path C: exits outer (cancelled) — red dot well past outer ring
        Positioned(
          left: 270.0,
          top: 30.0,
          child: SizedBox(
            width: 14.0,
            height: 14.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFC62828),
              ),
            ),
          ),
        ),
        // Labels
        Positioned(
          left: 8.0,
          top: 8.0,
          child: Text(
            'pre-accept slop  (inner)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF7C4A00),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          left: 8.0,
          top: 24.0,
          child: Text(
            'post-accept slop (outer)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF7C4A00),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  final Widget slopSection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.bubble_chart, color: goldDeep, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'Section 5 · Slop tolerance visualizer',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Center(child: slopStage),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Path A — pointer stays inside both circles → accepted, '
                  'gesture fires normally.',
                  style: TextStyle(fontSize: 12.5, color: inkMedium),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEF6C00),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Path B — pointer exits inner ring before acceptance → '
                  'rejected by arena (e.g. tap becomes drag).',
                  style: TextStyle(fontSize: 12.5, color: inkMedium),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFC62828),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Path C — pointer exits outer ring after acceptance → '
                  'gesture cancelled (already-fired callback receives a '
                  'cancel event).',
                  style: TextStyle(fontSize: 12.5, color: inkMedium),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3D6),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Text(
              'Implementation note: distance is computed as squared euclidean '
              'distance and compared against the squared tolerance, so the '
              'framework never has to call sqrt on the hot path.',
              style: TextStyle(
                fontSize: 12.0,
                color: inkMedium,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 6: Override surface
  // ==================================================================
  final Widget overrideSection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFF2B1B00),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldBright, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.code, color: goldBright, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'Section 6 · Override surface',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: amberSoft,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Text(
            'abstract class MyRecognizer extends PrimaryPointerGestureRecognizer {\n'
            '  // 1. Called for EVERY pointer event of the primary pointer.\n'
            '  //    Use it to inspect deltas, pressure, kind, etc.\n'
            '  @override\n'
            '  void handlePrimaryPointer(PointerEvent event) { … }\n'
            '\n'
            '  // 2. Called once if `deadline` (Duration) elapses while the\n'
            '  //    pointer is still being tracked. Optional override.\n'
            '  @override\n'
            '  void didExceedDeadline() { … }\n'
            '\n'
            '  // 3. Arena hook — called when this recognizer wins.\n'
            '  //    Fire your "gesture started" callback here.\n'
            '  @override\n'
            '  void acceptGesture(int pointer) { … }\n'
            '\n'
            '  // 4. Arena hook — called when another recognizer wins or\n'
            '  //    when the gesture is cancelled. Clean up here.\n'
            '  @override\n'
            '  void rejectGesture(int pointer) { … }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: amberSoft,
              height: 1.55,
            ),
          ),
          SizedBox(height: 14.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0x33E3A82B),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Text(
              'You almost never override addAllowedPointer / handleEvent at '
              'this layer — the parent class already routes the primary '
              'pointer through handlePrimaryPointer for you.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 7: Subclass cookbook
  // ==================================================================
  final Widget cookTap = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.touch_app, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'TapGestureRecognizer',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'Overrides handlePrimaryPointer to detect up events; uses '
            'preAcceptSlopTolerance = kTouchSlop and a null deadline. '
            'Cancels if the pointer moves outside slop (becomes a drag).',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget cookLongPress = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.timer, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'LongPressGestureRecognizer',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'Sets deadline ≈ 500ms and overrides didExceedDeadline to '
            'declare itself the winner. Disables postAcceptSlopTolerance '
            'so the long-press can morph into a drag after firing.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget cookForce = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.compress, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'ForcePressGestureRecognizer',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'No deadline. handlePrimaryPointer inspects event.pressure '
            'against startPressure / peakPressure thresholds. Resolves '
            'when the pressure curve crosses the start threshold.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget cookTapDrag = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.swipe, color: goldDeep, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'BaseTapAndDragGestureRecognizer',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'Tracks tap count via consecutiveTapCount, then promotes the '
            'sequence to a drag once slop is exceeded post-accept. Uses '
            'an internal sub-state machine on top of the primary-pointer '
            'lifecycle.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget cookbookSection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: amberPale,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: goldDeep, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'Section 7 · Subclass cookbook',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          cookTap,
          cookLongPress,
          cookForce,
          cookTapDrag,
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 8: Comparison panel
  // ==================================================================
  final Widget compareOneSeq = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'OneSequenceGestureRecognizer',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: inkDark,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Tracks one pointer sequence. No notion of "primary pointer" — '
            'all allowed pointers feed handleEvent. Used for scale, drag, '
            'and other multi-touch-aware gestures that still resolve as a '
            'single sequence in the arena.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget comparePrimary = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[Color(0xFFFFE9B0), Color(0xFFFFD180)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldDeep, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'PrimaryPointerGestureRecognizer',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              color: inkDark,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Locks onto the FIRST pointer and routes only its events to '
            'handlePrimaryPointer. Adds deadline + slop machinery. Best '
            'for tap, long-press, force-press — anything intrinsically '
            'single-finger.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget compareMultiDrag = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'MultiDragGestureRecognizer',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: inkDark,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'A different branch entirely: each pointer gets its own '
            'MultiDragPointerState object so they can be tracked '
            'independently. Used for drag-and-drop of multiple items at '
            'once. Has no concept of a "primary" pointer.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget compareSection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.compare_arrows, color: goldDeep, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'Section 8 · Comparison',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          compareOneSeq,
          comparePrimary,
          compareMultiDrag,
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 9: Real-world examples
  // ==================================================================
  final Widget exHold = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFF2B1B00),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldBright, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hold-to-confirm recognizer',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: amberSoft,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            '• deadline: Duration(seconds: 2)\n'
            '• preAcceptSlopTolerance: 24.0\n'
            '• postAcceptSlopTolerance: null  (no cancel after fire)\n'
            '• didExceedDeadline → fires onConfirm callback',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: amberSoft,
              height: 1.55,
            ),
          ),
        ],
      ),
    ),
  );

  final Widget exRateLimit = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFF2B1B00),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldBright, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Rate-limited tap',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: amberSoft,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            '• subclass that overrides acceptGesture\n'
            '• tracks lastFiredTimestamp in instance state\n'
            '• swallows accept if too soon since previous fire\n'
            '• preAcceptSlopTolerance: kTouchSlop (default tap behaviour)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: amberSoft,
              height: 1.55,
            ),
          ),
        ],
      ),
    ),
  );

  final Widget exHover = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFF2B1B00),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldBright, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hover-only recognizer (mouse + stylus)',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: amberSoft,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            '• supportedDevices: { mouse, stylus }\n'
            '• preAcceptSlopTolerance: null  (hover never gets cancelled)\n'
            '• overrides handlePrimaryPointer to forward only hover events\n'
            '• ignores touch entirely so finger taps fall through',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: amberSoft,
              height: 1.55,
            ),
          ),
        ],
      ),
    ),
  );

  final Widget examplesSection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: amberPale,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.lightbulb, color: goldDeep, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'Section 9 · Real-world examples',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          exHold,
          exRateLimit,
          exHover,
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 10: Caveats
  // ==================================================================
  final Widget caveatOwner = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFE0B2),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFEF6C00), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.warning_amber,
                color: Color(0xFFEF6C00),
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'debugOwner is debug-only',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C4A00),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'Never key behaviour off debugOwner. It is stripped or stubbed '
            'in profile/release builds. It exists only so the inspector '
            'can attribute orphaned recognizers to the widget that '
            'created them.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget caveatArena = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFE0B2),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFEF6C00), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.warning_amber,
                color: Color(0xFFEF6C00),
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Arena interaction is implicit',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C4A00),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'Calling resolve(GestureDisposition.accepted) before the '
            'deadline fires will short-circuit the slop checks. Avoid '
            'doing this unless you really mean to bypass the framework '
            'safety net.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget caveatSquared = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFE0B2),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFEF6C00), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.warning_amber,
                color: Color(0xFFEF6C00),
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Slop math is squared internally',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C4A00),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'You pass slop tolerances as a euclidean distance, but the '
            'recognizer compares squared distances to avoid sqrt on every '
            'move event. Doubling tolerance therefore quadruples the '
            'allowed area.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget caveatKind = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFE0B2),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFEF6C00), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.warning_amber,
                color: Color(0xFFEF6C00),
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'kind filter is exact match only',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C4A00),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'kind == PointerDeviceKind.mouse will NOT catch trackpad '
            'pointers, even though both are non-touch. If you want a '
            'set, switch to supportedDevices.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget caveatFallback = Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFE0B2),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0xFFEF6C00), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.warning_amber,
                color: Color(0xFFEF6C00),
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'supportedDevices fallback is null, not empty',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C4A00),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'Passing supportedDevices: <PointerDeviceKind>{} accepts '
            'NOTHING. Pass null (or omit the parameter) to accept every '
            'kind. This trips up developers migrating from kind.',
            style: TextStyle(fontSize: 12.5, color: inkMedium, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final Widget caveatsSection = Padding(
    padding: EdgeInsets.only(bottom: 20.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: parchment,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.fromBorderSide(
          BorderSide(color: goldRich, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.report_problem, color: goldDeep, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'Section 10 · Caveats',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: inkDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          caveatOwner,
          caveatArena,
          caveatSquared,
          caveatKind,
          caveatFallback,
        ],
      ),
    ),
  );

  // ==================================================================
  // SECTION 11: Footer takeaways
  // ==================================================================
  final Widget footer = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF7C4A00), Color(0xFFB8860B)],
      ),
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.check_circle, color: Colors.white, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Takeaways',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '• PrimaryPointerGestureRecognizer is abstract — extend it, never '
          'instantiate it.\n'
          '• Override handlePrimaryPointer for routing, didExceedDeadline '
          'for time-based recognition, accept/rejectGesture for arena '
          'transitions.\n'
          '• deadline + slop tolerances are the two big knobs you tune in '
          'subclasses.\n'
          '• Distance comparisons are squared internally — keep that in '
          'mind when reasoning about thresholds.\n'
          '• Prefer supportedDevices over the legacy kind parameter for '
          'multi-device recognizers.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white,
            height: 1.6,
          ),
        ),
      ],
    ),
  );

  return Scaffold(
    backgroundColor: amberPale,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          hierarchySection,
          lifecycleSection,
          paramsSection,
          slopSection,
          overrideSection,
          cookbookSection,
          compareSection,
          examplesSection,
          caveatsSection,
          footer,
        ],
      ),
    ),
  );
}
