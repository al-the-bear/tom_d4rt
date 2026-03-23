// ignore_for_file: avoid_print
// D4rt test script: Tests LinearGradient, BoxShadow from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Painting gradient shadow test executing');

  // ========== LINEARGRADIENT ==========
  print('--- LinearGradient Tests ---');

  // Test basic LinearGradient
  final basicGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
  );
  print('Basic LinearGradient: colors=${basicGradient.colors}');

  // Test LinearGradient with begin/end
  final horizontalGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
  );
  print(
    'Horizontal gradient: begin=${horizontalGradient.begin}, end=${horizontalGradient.end}',
  );

  final verticalGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
  );
  print(
    'Vertical gradient: begin=${verticalGradient.begin}, end=${verticalGradient.end}',
  );

  final diagonalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
  );
  print(
    'Diagonal gradient: begin=${diagonalGradient.begin}, end=${diagonalGradient.end}',
  );

  // Test LinearGradient with multiple colors
  final multiColorGradient = LinearGradient(
    colors: [
      Color(0xFFE53935), // Red
      Color(0xFFFF9800), // Orange
      Color(0xFFFFEB3B), // Yellow
      Color(0xFF4CAF50), // Green
      Color(0xFF2196F3), // Blue
      Color(0xFF9C27B0), // Purple
    ],
  );
  print('Multi-color gradient: ${multiColorGradient.colors.length} colors');

  // Test LinearGradient with stops
  final stopsGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935), Color(0xFF4CAF50)],
    stops: [0.0, 0.3, 1.0],
  );
  print('Gradient with stops: ${stopsGradient.stops}');

  // Test LinearGradient with tileMode
  final clampGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    tileMode: TileMode.clamp,
  );
  print('Gradient tileMode clamp: ${clampGradient.tileMode}');

  final repeatGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    tileMode: TileMode.repeated,
  );
  print('Gradient tileMode repeated: ${repeatGradient.tileMode}');

  final mirrorGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    tileMode: TileMode.mirror,
  );
  print('Gradient tileMode mirror: ${mirrorGradient.tileMode}');

  final decalGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    tileMode: TileMode.decal,
  );
  print('Gradient tileMode decal: ${decalGradient.tileMode}');

  // Test LinearGradient.lerp
  final gradientStart = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF2196F3)],
  );
  final gradientEnd = LinearGradient(
    colors: [Color(0xFFE53935), Color(0xFFE53935)],
  );
  final lerpedGradient = LinearGradient.lerp(gradientStart, gradientEnd, 0.5);
  print('LinearGradient.lerp at 0.5: colors=${lerpedGradient?.colors}');

  // Test LinearGradient with transform
  final transformedGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    transform: GradientRotation(0.785), // 45 degrees
  );
  print('Gradient with transform: ${transformedGradient.transform}');

  // Test LinearGradient scale
  final scaledGradient = basicGradient.scale(0.5);
  print('Gradient.scale(0.5): colors=${scaledGradient.colors}');

  // Test createShader
  final shader = basicGradient.createShader(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  print('createShader created: ${true} [${shader.hashCode}]');

  // ========== BOXSHADOW ==========
  print('--- BoxShadow Tests ---');

  // Test basic BoxShadow
  final basicShadow = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(2.0, 2.0),
    blurRadius: 4.0,
  );
  print(
    'Basic BoxShadow: color=${basicShadow.color}, offset=${basicShadow.offset}, blurRadius=${basicShadow.blurRadius}',
  );

  // Test BoxShadow with default values
  final defaultShadow = BoxShadow();
  print(
    'BoxShadow() default: color=${defaultShadow.color}, offset=${defaultShadow.offset}',
  );

  // Test BoxShadow with spreadRadius
  final spreadShadow = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(0.0, 4.0),
    blurRadius: 8.0,
    spreadRadius: 2.0,
  );
  print(
    'BoxShadow with spreadRadius: spreadRadius=${spreadShadow.spreadRadius}',
  );

  // Test BoxShadow with negative spreadRadius
  final negativeSreadShadow = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(0.0, 2.0),
    blurRadius: 8.0,
    spreadRadius: -2.0,
  );
  print(
    'BoxShadow with negative spreadRadius: ${negativeSreadShadow.spreadRadius}',
  );

  // Test BoxShadow with blurStyle
  final normalBlurShadow = BoxShadow(
    color: Color(0x80000000),
    blurRadius: 8.0,
    blurStyle: BlurStyle.normal,
  );
  print('BoxShadow blurStyle normal: ${normalBlurShadow.blurStyle}');

  final solidBlurShadow = BoxShadow(
    color: Color(0x80000000),
    blurRadius: 8.0,
    blurStyle: BlurStyle.solid,
  );
  print('BoxShadow blurStyle solid: ${solidBlurShadow.blurStyle}');

  final outerBlurShadow = BoxShadow(
    color: Color(0x80000000),
    blurRadius: 8.0,
    blurStyle: BlurStyle.outer,
  );
  print('BoxShadow blurStyle outer: ${outerBlurShadow.blurStyle}');

  final innerBlurShadow = BoxShadow(
    color: Color(0x80000000),
    blurRadius: 8.0,
    blurStyle: BlurStyle.inner,
  );
  print('BoxShadow blurStyle inner: ${innerBlurShadow.blurStyle}');

  // Test BoxShadow scale
  final scaledShadow = basicShadow.scale(2.0);
  print(
    'BoxShadow.scale(2.0): blurRadius=${scaledShadow.blurRadius}, offset=${scaledShadow.offset}',
  );

  // Test BoxShadow.lerp
  final shadowStart = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(0.0, 0.0),
    blurRadius: 0.0,
  );
  final shadowEnd = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(10.0, 10.0),
    blurRadius: 20.0,
  );
  final lerpedShadow = BoxShadow.lerp(shadowStart, shadowEnd, 0.5);
  print(
    'BoxShadow.lerp at 0.5: offset=${lerpedShadow?.offset}, blurRadius=${lerpedShadow?.blurRadius}',
  );

  // Test BoxShadow.lerpList
  final shadowList1 = [BoxShadow(color: Color(0x80000000), blurRadius: 4.0)];
  final shadowList2 = [
    BoxShadow(color: Color(0x80000000), blurRadius: 8.0),
    BoxShadow(color: Color(0x40000000), blurRadius: 16.0),
  ];
  final lerpedList = BoxShadow.lerpList(shadowList1, shadowList2, 0.5);
  print('BoxShadow.lerpList: ${lerpedList?.length} shadows');

  // Test BoxShadow toPaint
  final paint = basicShadow.toPaint();
  print('BoxShadow.toPaint: color=${paint.color}');

  // Test elevated shadow patterns (Material Design)
  final elevation2Shadow = [
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0.0, 1.0),
      blurRadius: 3.0,
      spreadRadius: 0.0,
    ),
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0.0, 1.0),
      blurRadius: 1.0,
      spreadRadius: 0.0,
    ),
  ];
  print('Material elevation 2 shadow: ${elevation2Shadow.length} shadows');

  final elevation8Shadow = [
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0.0, 5.0),
      blurRadius: 5.0,
      spreadRadius: -3.0,
    ),
    BoxShadow(
      color: Color(0x24000000),
      offset: Offset(0.0, 8.0),
      blurRadius: 10.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0.0, 3.0),
      blurRadius: 14.0,
      spreadRadius: 2.0,
    ),
  ];
  print('Material elevation 8 shadow: ${elevation8Shadow.length} shadows');

  print('Painting gradient shadow test completed');

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
              'Gradient & Shadow Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // LinearGradient examples
            Text(
              'LinearGradient:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Text('Horizontal:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF2196F3), Color(0xFFE53935)],
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text('Vertical:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2196F3), Color(0xFFE53935)],
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text('Diagonal:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2196F3), Color(0xFFE53935)],
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text('Rainbow:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE53935),
                    Color(0xFFFF9800),
                    Color(0xFFFFEB3B),
                    Color(0xFF4CAF50),
                    Color(0xFF2196F3),
                    Color(0xFF9C27B0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text('With stops [0, 0.3, 1]:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2196F3),
                    Color(0xFFE53935),
                    Color(0xFF4CAF50),
                  ],
                  stops: [0.0, 0.3, 1.0],
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // BoxShadow examples
            Text('BoxShadow:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),

            Row(
              children: [
                Column(
                  children: [
                    Text('Low', style: TextStyle(fontSize: 10.0)),
                    SizedBox(height: 4.0),
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0.0, 2.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    Text('Medium', style: TextStyle(fontSize: 10.0)),
                    SizedBox(height: 4.0),
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0.0, 4.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    Text('High', style: TextStyle(fontSize: 10.0)),
                    SizedBox(height: 4.0),
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.0),

            Text(
              'Colored Shadows:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2196F3),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x802196F3),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 12.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE53935),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x80E53935),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 12.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x804CAF50),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 12.0,
                      ),
                    ],
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
