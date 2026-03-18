// D4rt test script: Tests Color, Offset, Size from dart:ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dart:UI Primitives Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text('Color:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(width: 40.0, height: 40.0, color: Color(0xFFFF0000)),
                Container(width: 40.0, height: 40.0, color: Color(0xFF00FF00)),
                Container(width: 40.0, height: 40.0, color: Color(0xFF0000FF)),
                Container(width: 40.0, height: 40.0, color: Color(0xFFFFFF00)),
                Container(width: 40.0, height: 40.0, color: Color(0xFF00FFFF)),
                Container(width: 40.0, height: 40.0, color: Color(0xFFFF00FF)),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (var i = 0; i <= 10; i++)
                  Container(
                    width: 20.0,
                    height: 20.0,
                    color: Color.lerp(
                      Color(0xFFFF0000),
                      Color(0xFF0000FF),
                      i / 10.0,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Offset:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              width: 150.0,
              height: 100.0,
              color: Color(0xFFE0E0E0),
              child: Stack(
                children: [
                  Positioned(
                    left: 10.0,
                    top: 20.0,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF2196F3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 60.0,
                    top: 40.0,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 100.0,
                    top: 60.0,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text('Size:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(width: 30.0, height: 30.0, color: Color(0xFFFF9800)),
                SizedBox(width: 8.0),
                Container(width: 50.0, height: 40.0, color: Color(0xFFFF9800)),
                SizedBox(width: 8.0),
                Container(width: 80.0, height: 60.0, color: Color(0xFFFF9800)),
                SizedBox(width: 8.0),
                Container(width: 100.0, height: 80.0, color: Color(0xFFFF9800)),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Radius (BorderRadius):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('FontWeight:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('w100', style: TextStyle(fontWeight: FontWeight.w100)),
                SizedBox(width: 8.0),
                Text('w300', style: TextStyle(fontWeight: FontWeight.w300)),
                SizedBox(width: 8.0),
                Text('w400', style: TextStyle(fontWeight: FontWeight.w400)),
                SizedBox(width: 8.0),
                Text('w600', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 8.0),
                Text('w900', style: TextStyle(fontWeight: FontWeight.w900)),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Shadow:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('4px', style: TextStyle(fontSize: 12.0)),
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(4.0, 4.0),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('8px', style: TextStyle(fontSize: 12.0)),
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(8.0, 8.0),
                        blurRadius: 16.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('16px', style: TextStyle(fontSize: 12.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
