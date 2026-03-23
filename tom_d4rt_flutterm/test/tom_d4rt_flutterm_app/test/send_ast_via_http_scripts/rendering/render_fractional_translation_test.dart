// Deep demo: RenderFractionalTranslation / FractionalTranslation widget
// FractionalTranslation translates its child by a fraction of the child's own size.
// Offset(0.5, 0.5) moves the child 50% of its width right and 50% of its height down.

import 'package:flutter/material.dart';

Widget _buildHeader(String title, String subtitle) {
  print('Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF4A148C), Color(0xFF880E4F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 12.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xCCFFFFFF),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  print('Building section: $title');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 28.0, bottom: 12.0),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF283593), Color(0xFF5C6BC0)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF37474F),
      ),
    ),
  );
}

Widget _buildFractionalBox(Offset translation, Color color, String label) {
  print('  FractionalTranslation offset=(${translation.dx}, ${translation.dy}) label=$label');
  return Container(
    width: 200.0,
    height: 80.0,
    margin: EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      color: Color(0xFFEEEEEE),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Ghost outline at original position
        Positioned(
          left: 20.0,
          top: 15.0,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0x44000000), width: 1.0),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        // Fractionally translated child
        Positioned(
          left: 20.0,
          top: 15.0,
          child: FractionalTranslation(
            translation: translation,
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 4.0,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 9.0, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 1: Horizontal offsets
Widget _buildHorizontalOffsets() {
  print('Section 1: Horizontal fractional offsets');
  List<Map<String, dynamic>> items = [
    {'offset': Offset(0.0, 0.0), 'color': Color(0xFF43A047), 'label': '0,0'},
    {'offset': Offset(0.25, 0.0), 'color': Color(0xFF1E88E5), 'label': '.25,0'},
    {'offset': Offset(0.5, 0.0), 'color': Color(0xFFE53935), 'label': '.5,0'},
    {'offset': Offset(1.0, 0.0), 'color': Color(0xFF8E24AA), 'label': '1,0'},
    {'offset': Offset(-0.5, 0.0), 'color': Color(0xFFFF6F00), 'label': '-.5,0'},
  ];
  List<Widget> children = [];
  for (int i = 0; i < items.length; i++) {
    Map<String, dynamic> item = items[i];
    Offset off = item['offset'] as Offset;
    Color col = item['color'] as Color;
    String lab = item['label'] as String;
    children.add(_buildLabel('Offset(${off.dx}, ${off.dy})'));
    children.add(_buildFractionalBox(off, col, lab));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children,
  );
}

// Section 2: Vertical offsets
Widget _buildVerticalOffsets() {
  print('Section 2: Vertical fractional offsets');
  List<Map<String, dynamic>> items = [
    {'offset': Offset(0.0, 0.25), 'color': Color(0xFF00897B), 'label': '0,.25'},
    {'offset': Offset(0.0, 0.5), 'color': Color(0xFF3949AB), 'label': '0,.5'},
    {'offset': Offset(0.0, 1.0), 'color': Color(0xFFC62828), 'label': '0,1'},
  ];
  List<Widget> children = [];
  for (int i = 0; i < items.length; i++) {
    Map<String, dynamic> item = items[i];
    Offset off = item['offset'] as Offset;
    Color col = item['color'] as Color;
    String lab = item['label'] as String;
    children.add(_buildLabel('Offset(${off.dx}, ${off.dy})'));
    children.add(_buildFractionalBox(off, col, lab));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children,
  );
}

// Section 3: Diagonal offsets
Widget _buildDiagonalOffsets() {
  print('Section 3: Diagonal fractional offsets');
  List<Map<String, dynamic>> items = [
    {'offset': Offset(0.5, 0.5), 'color': Color(0xFFD81B60), 'label': '.5,.5'},
    {'offset': Offset(-0.5, -0.5), 'color': Color(0xFF6A1B9A), 'label': '-.5,-.5'},
    {'offset': Offset(1.0, 1.0), 'color': Color(0xFFEF6C00), 'label': '1,1'},
    {'offset': Offset(-1.0, -1.0), 'color': Color(0xFF2E7D32), 'label': '-1,-1'},
  ];
  List<Widget> children = [];
  for (int i = 0; i < items.length; i++) {
    Map<String, dynamic> item = items[i];
    Offset off = item['offset'] as Offset;
    Color col = item['color'] as Color;
    String lab = item['label'] as String;
    children.add(_buildLabel('Offset(${off.dx}, ${off.dy})'));
    children.add(_buildFractionalBox(off, col, lab));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children,
  );
}

// Section 4: transformHitTests parameter
Widget _buildTransformHitTests() {
  print('Section 4: transformHitTests parameter comparison');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel('transformHitTests: true (default) - hits follow visual position'),
      Container(
        width: 280.0,
        height: 100.0,
        margin: EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          border: Border.all(color: Color(0xFFBDBDBD)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 30.0,
              top: 20.0,
              child: FractionalTranslation(
                translation: Offset(1.0, 0.0),
                transformHitTests: true,
                child: Container(
                  width: 80.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Hits: TRUE',
                      style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      _buildLabel('transformHitTests: false - hits stay at original position'),
      Container(
        width: 280.0,
        height: 100.0,
        margin: EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          border: Border.all(color: Color(0xFFBDBDBD)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 30.0,
              top: 20.0,
              child: FractionalTranslation(
                translation: Offset(1.0, 0.0),
                transformHitTests: false,
                child: Container(
                  width: 80.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Hits: FALSE',
                      style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 4.0),
        child: Text(
          'When transformHitTests is false, taps register at the original (untranslated) position.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161), fontStyle: FontStyle.italic),
        ),
      ),
    ],
  );
}

// Section 5: FractionalTranslation vs Transform.translate
Widget _buildComparison() {
  print('Section 5: FractionalTranslation vs Transform.translate');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel('FractionalTranslation(translation: Offset(0.5, 0))'),
      Container(
        width: 260.0,
        height: 80.0,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFF3E0),
          border: Border.all(color: Color(0xFFFFCC80)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 10.0,
              top: 10.0,
              child: FractionalTranslation(
                translation: Offset(0.5, 0.0),
                child: Container(
                  width: 80.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE65100),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      'Fractional\n50% of 80px',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 9.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      _buildLabel('Transform.translate(offset: Offset(40, 0)) - same 40px shift'),
      Container(
        width: 260.0,
        height: 80.0,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Color(0xFFE8EAF6),
          border: Border.all(color: Color(0xFF9FA8DA)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 10.0,
              top: 10.0,
              child: Transform.translate(
                offset: Offset(40.0, 0.0),
                child: Container(
                  width: 80.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF283593),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      'Transform\n40px fixed',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 9.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 6.0),
        child: Text(
          'FractionalTranslation shifts by a fraction of the child size.\n'
          'Transform.translate shifts by fixed pixel amount.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF455A64)),
        ),
      ),
    ],
  );
}

// Section 6: SlideTransition animation patterns
Widget _buildSlideTransitionPatterns() {
  print('Section 6: SlideTransition / animation patterns');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          'SlideTransition wraps FractionalTranslation with an Animation<Offset>.\n'
          'Below are static snapshots of slide animation keyframes.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF546E7A)),
        ),
      ),
      _buildLabel('Slide-in from left: Offset(-1,0) -> Offset(0,0)'),
      Row(
        children: [
          _buildSlideFrame(Offset(-1.0, 0.0), 'Start', Color(0xFFB71C1C)),
          SizedBox(width: 8.0),
          _buildSlideFrame(Offset(-0.5, 0.0), 'Mid', Color(0xFFE53935)),
          SizedBox(width: 8.0),
          _buildSlideFrame(Offset(0.0, 0.0), 'End', Color(0xFF43A047)),
        ],
      ),
      SizedBox(height: 12.0),
      _buildLabel('Slide-in from bottom: Offset(0,1) -> Offset(0,0)'),
      Row(
        children: [
          _buildSlideFrame(Offset(0.0, 1.0), 'Start', Color(0xFF4A148C)),
          SizedBox(width: 8.0),
          _buildSlideFrame(Offset(0.0, 0.5), 'Mid', Color(0xFF7B1FA2)),
          SizedBox(width: 8.0),
          _buildSlideFrame(Offset(0.0, 0.0), 'End', Color(0xFF43A047)),
        ],
      ),
      SizedBox(height: 12.0),
      _buildLabel('Slide-out to right: Offset(0,0) -> Offset(1,0)'),
      Row(
        children: [
          _buildSlideFrame(Offset(0.0, 0.0), 'Start', Color(0xFF43A047)),
          SizedBox(width: 8.0),
          _buildSlideFrame(Offset(0.5, 0.0), 'Mid', Color(0xFFFF8F00)),
          SizedBox(width: 8.0),
          _buildSlideFrame(Offset(1.0, 0.0), 'End', Color(0xFFB71C1C)),
        ],
      ),
    ],
  );
}

Widget _buildSlideFrame(Offset offset, String label, Color color) {
  print('    SlideFrame offset=(${offset.dx}, ${offset.dy}) label=$label');
  return Container(
    width: 90.0,
    height: 70.0,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      border: Border.all(color: Color(0xFFBDBDBD)),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 15.0,
          top: 10.0,
          child: FractionalTranslation(
            translation: offset,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 8.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 2.0,
          left: 0.0,
          right: 0.0,
          child: Text(
            '(${offset.dx},${offset.dy})',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 8.0, color: Color(0xFF757575)),
          ),
        ),
      ],
    ),
  );
}

// Section 7: Overlapping content
Widget _buildOverlappingContent() {
  print('Section 7: Overlapping content with FractionalTranslation');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel('Cards overlapping each other via negative fractional offsets'),
      Container(
        width: 300.0,
        height: 160.0,
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          border: Border.all(color: Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Base card
            Positioned(
              left: 20.0,
              top: 20.0,
              child: Container(
                width: 120.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text('Card A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            // Overlapping card B
            Positioned(
              left: 80.0,
              top: 30.0,
              child: FractionalTranslation(
                translation: Offset(0.3, 0.2),
                child: Container(
                  width: 120.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE53935).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 6.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('Card B\n+30%,+20%', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 11.0)),
                  ),
                ),
              ),
            ),
            // Overlapping card C
            Positioned(
              left: 40.0,
              top: 60.0,
              child: FractionalTranslation(
                translation: Offset(-0.2, 0.5),
                child: Container(
                  width: 100.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF43A047).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 6.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('Card C\n-20%,+50%', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12.0),
      _buildLabel('Stacked avatar overlap pattern'),
      Container(
        width: 300.0,
        height: 70.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color(0xFFF3E5F5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            _buildAvatar(0, Color(0xFF1565C0), 'A'),
            Positioned(
              left: 30.0,
              child: FractionalTranslation(
                translation: Offset(-0.15, 0.0),
                child: _buildAvatarCircle(Color(0xFFE53935), 'B'),
              ),
            ),
            Positioned(
              left: 60.0,
              child: FractionalTranslation(
                translation: Offset(-0.15, 0.0),
                child: _buildAvatarCircle(Color(0xFF43A047), 'C'),
              ),
            ),
            Positioned(
              left: 90.0,
              child: FractionalTranslation(
                translation: Offset(-0.15, 0.0),
                child: _buildAvatarCircle(Color(0xFFFF6F00), 'D'),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildAvatar(double left, Color color, String letter) {
  return Positioned(
    left: left,
    top: 0.0,
    child: _buildAvatarCircle(color, letter),
  );
}

Widget _buildAvatarCircle(Color color, String letter) {
  return Container(
    width: 44.0,
    height: 44.0,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2.0),
    ),
    child: Center(
      child: Text(letter, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0)),
    ),
  );
}

// Section 8: Practical patterns
Widget _buildPracticalPatterns() {
  print('Section 8: Practical patterns with FractionalTranslation');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Peek-in effect
      _buildLabel('Peek-in effect: element partially visible from edge'),
      Container(
        width: 280.0,
        height: 90.0,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFF90CAF9)),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0.0,
              top: 15.0,
              child: FractionalTranslation(
                translation: Offset(0.7, 0.0),
                child: Container(
                  width: 100.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text('Peek!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12.0,
              top: 30.0,
              child: Text('Swipe to reveal ->', style: TextStyle(fontSize: 13.0, color: Color(0xFF1565C0))),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      // Offset badge
      _buildLabel('Offset badge: notification count overlapping icon'),
      Container(
        width: 280.0,
        height: 90.0,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFFF1F8E9),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFFA5D6A7)),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(Icons.mail_outline, color: Colors.white, size: 28.0),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: FractionalTranslation(
                    translation: Offset(0.3, -0.3),
                    child: Container(
                      width: 22.0,
                      height: 22.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: Center(
                        child: Text('5', style: TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.0),
            // Second icon with badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(Icons.notifications_none, color: Colors.white, size: 28.0),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: FractionalTranslation(
                    translation: Offset(0.4, -0.4),
                    child: Container(
                      width: 22.0,
                      height: 22.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6F00),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: Center(
                        child: Text('12', style: TextStyle(color: Colors.white, fontSize: 9.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.0),
            Text('Badge offset via\nFractionalTranslation', style: TextStyle(fontSize: 11.0, color: Color(0xFF455A64))),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      // Slide-out hint
      _buildLabel('Slide-out hint: content peeking from bottom'),
      Container(
        width: 280.0,
        height: 110.0,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Color(0xFFFCE4EC),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFFF48FB1)),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0.0,
              left: 20.0,
              right: 20.0,
              child: FractionalTranslation(
                translation: Offset(0.0, 0.6),
                child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFC62828),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 40.0,
                          height: 4.0,
                          decoration: BoxDecoration(
                            color: Color(0x66FFFFFF),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text('Pull up for details', style: TextStyle(color: Colors.white, fontSize: 12.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16.0,
              left: 16.0,
              child: Text(
                'Bottom sheet hint effect',
                style: TextStyle(fontSize: 13.0, color: Color(0xFFC62828), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      // Tooltip arrow offset
      _buildLabel('Tooltip-style offset: arrow pointing to anchor'),
      Container(
        width: 280.0,
        height: 100.0,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color(0xFFF3E5F5),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFFCE93D8)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Anchor element
            Positioned(
              left: 40.0,
              top: 40.0,
              child: Container(
                width: 60.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: Color(0xFF6A1B9A),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Text('Anchor', style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
              ),
            ),
            // Tooltip offset above anchor
            Positioned(
              left: 30.0,
              top: 40.0,
              child: FractionalTranslation(
                translation: Offset(0.0, -1.2),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text('Tooltip text', style: TextStyle(color: Colors.white, fontSize: 11.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Summary section
Widget _buildSummary() {
  print('Building summary section');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FractionalTranslation Summary',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
        ),
        SizedBox(height: 10.0),
        Text('- Translates child by fraction of child size', style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F))),
        SizedBox(height: 4.0),
        Text('- Offset(0.5, 0) = move right by 50% of child width', style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F))),
        SizedBox(height: 4.0),
        Text('- Negative offsets move left/up', style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F))),
        SizedBox(height: 4.0),
        Text('- transformHitTests controls whether taps follow visual position', style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F))),
        SizedBox(height: 4.0),
        Text('- SlideTransition animates FractionalTranslation with Animation<Offset>', style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F))),
        SizedBox(height: 4.0),
        Text('- Does NOT affect layout - siblings do not move', style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F))),
        SizedBox(height: 4.0),
        Text('- Useful for badges, peek-in effects, overlapping cards, tooltips', style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F))),
        SizedBox(height: 4.0),
        Text('- Unlike Transform.translate, offset is relative to child size', style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F))),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== RenderFractionalTranslation Deep Demo ===');
  print('FractionalTranslation translates child by a fraction of the child own size.');
  print('Offset(0.5, 0.5) moves child 50% right and 50% down relative to its own dimensions.');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          'RenderFractionalTranslation',
          'FractionalTranslation widget - translates child by a fraction of its own size',
        ),

        // Section 1: Horizontal offsets
        _buildSectionTitle('1. Horizontal Fractional Offsets'),
        _buildHorizontalOffsets(),

        // Section 2: Vertical offsets
        _buildSectionTitle('2. Vertical Fractional Offsets'),
        _buildVerticalOffsets(),

        // Section 3: Diagonal offsets
        _buildSectionTitle('3. Diagonal Fractional Offsets'),
        _buildDiagonalOffsets(),

        // Section 4: transformHitTests
        _buildSectionTitle('4. transformHitTests Parameter'),
        _buildTransformHitTests(),

        // Section 5: Comparison with Transform.translate
        _buildSectionTitle('5. FractionalTranslation vs Transform.translate'),
        _buildComparison(),

        // Section 6: SlideTransition patterns
        _buildSectionTitle('6. SlideTransition Animation Patterns'),
        _buildSlideTransitionPatterns(),

        // Section 7: Overlapping content
        _buildSectionTitle('7. Overlapping Content'),
        _buildOverlappingContent(),

        // Section 8: Practical patterns
        _buildSectionTitle('8. Practical Patterns'),
        _buildPracticalPatterns(),

        // Summary
        _buildSectionTitle('Summary'),
        _buildSummary(),

        SizedBox(height: 40.0),
      ],
    ),
  );
}
