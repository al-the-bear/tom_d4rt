// ignore_for_file: avoid_print
// D4rt test script: Tests IconButtonThemeData from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  print('Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF1565C0),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildSubHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 12, bottom: 6),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1565C0),
      ),
    ),
  );
}

Widget _buildInfoCard(String title, String description) {
  print('Info card: $title');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFBBDEFB), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
        ),
      ],
    ),
  );
}

Widget buildLabeledRow(String label, Widget child) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF616161),
            ),
          ),
        ),
        Expanded(child: child),
      ],
    ),
  );
}

Widget _buildComparisonCard(String label, Color bgColor, Widget child) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFF424242),
            ),
          ),
          SizedBox(height: 8),
          child,
        ],
      ),
    ),
  );
}

Widget _buildDefaultIconButtons() {
  print('Building default icon buttons (no theme)');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Default IconButtons (No Theme Applied)',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                print('Default home pressed');
              },
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                print('Default settings pressed');
              },
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('Default search pressed');
              },
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                print('Default favorite pressed');
              },
            ),
            SizedBox(width: 8),
            IconButton(icon: Icon(Icons.delete), onPressed: null),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Note: Last button is disabled (onPressed: null)',
          style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
        ),
      ],
    ),
  );
}

Widget _buildThemedIconButtons() {
  print('Building themed icon buttons');
  ButtonStyle customStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Color(0xFF1565C0)),
    iconSize: WidgetStateProperty.all(28.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(12)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  IconButtonThemeData themeData = IconButtonThemeData(style: customStyle);
  print('IconButtonThemeData created with custom style');
  print('Style foreground: white, background: blue, iconSize: 28');

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IconButtons with IconButtonTheme',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 8),
        IconButtonTheme(
          data: themeData,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  print('Themed home pressed');
                },
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  print('Themed settings pressed');
                },
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print('Themed search pressed');
                },
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  print('Themed favorite pressed');
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildForegroundColorStyles() {
  print('Building foreground color variations');
  List<Color> colors = [
    Color(0xFFD32F2F),
    Color(0xFF388E3C),
    Color(0xFF1565C0),
    Color(0xFFF57C00),
    Color(0xFF7B1FA2),
  ];
  List<String> names = ['Red', 'Green', 'Blue', 'Orange', 'Purple'];
  List<IconData> icons = [
    Icons.favorite,
    Icons.eco,
    Icons.water_drop,
    Icons.wb_sunny,
    Icons.star,
  ];

  List<Widget> buttons = [];
  int idx = 0;
  for (int i = 0; i < colors.length; i++) {
    Color c = colors[i];
    String n = names[i];
    IconData ic = icons[i];
    ButtonStyle style = ButtonStyle(
      foregroundColor: WidgetStateProperty.all(c),
      iconSize: WidgetStateProperty.all(26.0),
    );
    IconButtonThemeData data = IconButtonThemeData(style: style);
    print('Foreground color $n: $c');
    buttons.add(
      Column(
        children: [
          IconButtonTheme(
            data: data,
            child: IconButton(
              icon: Icon(ic),
              onPressed: () {
                print('$n icon pressed');
              },
            ),
          ),
          Text(n, style: TextStyle(fontSize: 11, color: c)),
        ],
      ),
    );
    if (i < colors.length - 1) {
      buttons.add(SizedBox(width: 12));
    }
    idx = idx + 1;
  }

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Foreground Color Variations',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 8),
        Row(children: buttons),
      ],
    ),
  );
}

Widget _buildBackgroundColorStyles() {
  print('Building background color variations');
  List<Color> bgColors = [
    Color(0xFFFFCDD2),
    Color(0xFFC8E6C9),
    Color(0xFFBBDEFB),
    Color(0xFFFFE0B2),
    Color(0xFFE1BEE7),
  ];
  List<Color> fgColors = [
    Color(0xFFB71C1C),
    Color(0xFF1B5E20),
    Color(0xFF0D47A1),
    Color(0xFFE65100),
    Color(0xFF4A148C),
  ];
  List<String> names = ['Rose', 'Mint', 'Sky', 'Peach', 'Lilac'];
  List<IconData> icons = [
    Icons.local_florist,
    Icons.park,
    Icons.cloud,
    Icons.light_mode,
    Icons.auto_awesome,
  ];

  List<Widget> buttons = [];
  for (int i = 0; i < bgColors.length; i++) {
    Color bg = bgColors[i];
    Color fg = fgColors[i];
    String n = names[i];
    IconData ic = icons[i];
    ButtonStyle style = ButtonStyle(
      foregroundColor: WidgetStateProperty.all(fg),
      backgroundColor: WidgetStateProperty.all(bg),
      iconSize: WidgetStateProperty.all(24.0),
      padding: WidgetStateProperty.all(EdgeInsets.all(10)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    IconButtonThemeData data = IconButtonThemeData(style: style);
    print('Background style $n: bg=$bg fg=$fg');
    buttons.add(
      Column(
        children: [
          IconButtonTheme(
            data: data,
            child: IconButton(
              icon: Icon(ic),
              onPressed: () {
                print('$n bg icon pressed');
              },
            ),
          ),
          Text(n, style: TextStyle(fontSize: 11, color: fg)),
        ],
      ),
    );
    if (i < bgColors.length - 1) {
      buttons.add(SizedBox(width: 8));
    }
  }

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Background Color Variations',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 8),
        Row(children: buttons),
      ],
    ),
  );
}

Widget _buildIconSizeVariations() {
  print('Building icon size variations');
  List<double> sizes = [16.0, 20.0, 24.0, 32.0, 40.0, 48.0];

  List<Widget> items = [];
  for (int i = 0; i < sizes.length; i++) {
    double s = sizes[i];
    ButtonStyle style = ButtonStyle(
      iconSize: WidgetStateProperty.all(s),
      foregroundColor: WidgetStateProperty.all(Color(0xFF1565C0)),
    );
    IconButtonThemeData data = IconButtonThemeData(style: style);
    int sInt = s.toInt();
    print('Icon size: $s');
    items.add(
      Column(
        children: [
          IconButtonTheme(
            data: data,
            child: IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                print('Size $s icon pressed');
              },
            ),
          ),
          Text(
            '${sInt}px',
            style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
          ),
        ],
      ),
    );
    if (i < sizes.length - 1) {
      items.add(SizedBox(width: 8));
    }
  }

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon Size Variations (via theme)',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 8),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: items),
      ],
    ),
  );
}

Widget _buildPaddingVariations() {
  print('Building padding variations');
  List<double> paddings = [0.0, 4.0, 8.0, 12.0, 16.0, 24.0];

  List<Widget> items = [];
  for (int i = 0; i < paddings.length; i++) {
    double p = paddings[i];
    ButtonStyle style = ButtonStyle(
      padding: WidgetStateProperty.all(EdgeInsets.all(p)),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      backgroundColor: WidgetStateProperty.all(Color(0xFF42A5F5)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    IconButtonThemeData data = IconButtonThemeData(style: style);
    int pInt = p.toInt();
    print('Padding: $p');
    items.add(
      Column(
        children: [
          IconButtonTheme(
            data: data,
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print('Padding $p icon pressed');
              },
            ),
          ),
          Text(
            '${pInt}px',
            style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
          ),
        ],
      ),
    );
    if (i < paddings.length - 1) {
      items.add(SizedBox(width: 6));
    }
  }

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Padding Variations (via theme)',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 8),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: items),
      ],
    ),
  );
}

Widget _buildShapeCircle() {
  print('Building circle shape theme');
  ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Color(0xFFE53935)),
    shape: WidgetStateProperty.all(CircleBorder()),
    padding: WidgetStateProperty.all(EdgeInsets.all(12)),
    iconSize: WidgetStateProperty.all(28.0),
  );
  IconButtonThemeData data = IconButtonThemeData(style: style);

  return IconButtonTheme(
    data: data,
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            print('Circle play pressed');
          },
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.pause),
          onPressed: () {
            print('Circle pause pressed');
          },
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.stop),
          onPressed: () {
            print('Circle stop pressed');
          },
        ),
      ],
    ),
  );
}

Widget _buildShapeRoundedRect() {
  print('Building rounded rectangle shape theme');
  ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Color(0xFF43A047)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.all(12)),
    iconSize: WidgetStateProperty.all(28.0),
  );
  IconButtonThemeData data = IconButtonThemeData(style: style);

  return IconButtonTheme(
    data: data,
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.folder),
          onPressed: () {
            print('RoundedRect folder pressed');
          },
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.file_copy),
          onPressed: () {
            print('RoundedRect file pressed');
          },
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            print('RoundedRect save pressed');
          },
        ),
      ],
    ),
  );
}

Widget _buildShapeStadium() {
  print('Building stadium shape theme');
  ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Color(0xFF7B1FA2)),
    shape: WidgetStateProperty.all(StadiumBorder()),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    iconSize: WidgetStateProperty.all(28.0),
  );
  IconButtonThemeData data = IconButtonThemeData(style: style);

  return IconButtonTheme(
    data: data,
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            print('Stadium send pressed');
          },
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            print('Stadium share pressed');
          },
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.bookmark),
          onPressed: () {
            print('Stadium bookmark pressed');
          },
        ),
      ],
    ),
  );
}

Widget _buildShapeVariations() {
  print('Building shape variations section');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeader('Circle Shape'),
        _buildShapeCircle(),
        SizedBox(height: 12),
        _buildSubHeader('Rounded Rectangle Shape'),
        _buildShapeRoundedRect(),
        SizedBox(height: 12),
        _buildSubHeader('Stadium Shape'),
        _buildShapeStadium(),
      ],
    ),
  );
}

Widget _buildNestedThemes() {
  print('Building nested themes (override behavior)');

  ButtonStyle outerStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Color(0xFF1565C0)),
    iconSize: WidgetStateProperty.all(24.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(10)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
  IconButtonThemeData outerTheme = IconButtonThemeData(style: outerStyle);
  print('Outer theme: blue background, white foreground');

  ButtonStyle innerStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Color(0xFF1B5E20)),
    backgroundColor: WidgetStateProperty.all(Color(0xFFC8E6C9)),
    iconSize: WidgetStateProperty.all(30.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(14)),
    shape: WidgetStateProperty.all(CircleBorder()),
  );
  IconButtonThemeData innerTheme = IconButtonThemeData(style: innerStyle);
  print('Inner theme: green background circle, overrides outer');

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nested IconButtonTheme Override',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          'Outer theme: Blue rounded rect',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 4),
        IconButtonTheme(
          data: outerTheme,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Outer: ',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () {
                      print('Outer theme button pressed');
                    },
                  ),
                  SizedBox(width: 4),
                  IconButton(
                    icon: Icon(Icons.thumb_down),
                    onPressed: () {
                      print('Outer theme button 2 pressed');
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Inner theme overrides: Green circle',
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 4),
              IconButtonTheme(
                data: innerTheme,
                child: Row(
                  children: [
                    Text(
                      'Inner: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.check_circle),
                      onPressed: () {
                        print('Inner theme button pressed');
                      },
                    ),
                    SizedBox(width: 4),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        print('Inner theme button 2 pressed');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildThemedVsUnthemed() {
  print('Building themed vs unthemed comparison');

  ButtonStyle themedStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Color(0xFFFF6F00)),
    iconSize: WidgetStateProperty.all(28.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(12)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    elevation: WidgetStateProperty.all(4.0),
  );
  IconButtonThemeData themedData = IconButtonThemeData(style: themedStyle);
  print('Comparison theme: orange background, elevated');

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Themed vs Unthemed Comparison',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildComparisonCard(
              'Unthemed',
              Color(0xFFF5F5F5),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      print('Unthemed notification pressed');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.mail),
                    onPressed: () {
                      print('Unthemed mail pressed');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      print('Unthemed chat pressed');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            _buildComparisonCard(
              'Themed',
              Color(0xFFFFF3E0),
              IconButtonTheme(
                data: themedData,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        print('Themed notification pressed');
                      },
                    ),
                    SizedBox(height: 4),
                    IconButton(
                      icon: Icon(Icons.mail),
                      onPressed: () {
                        print('Themed mail pressed');
                      },
                    ),
                    SizedBox(height: 4),
                    IconButton(
                      icon: Icon(Icons.chat),
                      onPressed: () {
                        print('Themed chat pressed');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStandardVariant() {
  print('Building standard IconButton variant under theme');
  ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Color(0xFF1565C0)),
    iconSize: WidgetStateProperty.all(26.0),
  );
  IconButtonThemeData data = IconButtonThemeData(style: style);

  return IconButtonTheme(
    data: data,
    child: Row(
      children: [
        Text(
          'Standard: ',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            print('Standard add pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            print('Standard remove pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            print('Standard refresh pressed');
          },
        ),
      ],
    ),
  );
}

Widget _buildFilledVariant() {
  print('Building filled IconButton variant under theme');
  ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Color(0xFF1565C0)),
    iconSize: WidgetStateProperty.all(26.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(10)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  IconButtonThemeData data = IconButtonThemeData(style: style);

  return IconButtonTheme(
    data: data,
    child: Row(
      children: [
        Text(
          'Filled: ',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            print('Filled add pressed');
          },
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            print('Filled remove pressed');
          },
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            print('Filled refresh pressed');
          },
        ),
      ],
    ),
  );
}

Widget _buildFilledTonalVariant() {
  print('Building filledTonal IconButton variant under theme');
  ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Color(0xFF0D47A1)),
    backgroundColor: WidgetStateProperty.all(Color(0xFFBBDEFB)),
    iconSize: WidgetStateProperty.all(26.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(10)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  IconButtonThemeData data = IconButtonThemeData(style: style);

  return IconButtonTheme(
    data: data,
    child: Row(
      children: [
        Text(
          'Tonal: ',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            print('Tonal add pressed');
          },
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            print('Tonal remove pressed');
          },
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            print('Tonal refresh pressed');
          },
        ),
      ],
    ),
  );
}

Widget _buildOutlinedVariant() {
  print('Building outlined IconButton variant under theme');
  ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Color(0xFF1565C0)),
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    iconSize: WidgetStateProperty.all(26.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(10)),
    side: WidgetStateProperty.all(
      BorderSide(color: Color(0xFF1565C0), width: 1.5),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  IconButtonThemeData data = IconButtonThemeData(style: style);

  return IconButtonTheme(
    data: data,
    child: Row(
      children: [
        Text(
          'Outlined: ',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            print('Outlined add pressed');
          },
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            print('Outlined remove pressed');
          },
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            print('Outlined refresh pressed');
          },
        ),
      ],
    ),
  );
}

Widget _buildVariantsSection() {
  print('Building all icon button variants section');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IconButton Visual Variants Under Theme',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 12),
        _buildStandardVariant(),
        SizedBox(height: 8),
        Divider(height: 1, color: Color(0xFFEEEEEE)),
        SizedBox(height: 8),
        _buildFilledVariant(),
        SizedBox(height: 8),
        Divider(height: 1, color: Color(0xFFEEEEEE)),
        SizedBox(height: 8),
        _buildFilledTonalVariant(),
        SizedBox(height: 8),
        Divider(height: 1, color: Color(0xFFEEEEEE)),
        SizedBox(height: 8),
        _buildOutlinedVariant(),
      ],
    ),
  );
}

Widget _buildPropertyReference() {
  print('Building property/info reference section');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IconButtonThemeData Property Reference',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 12),
        _buildInfoCard(
          'style (ButtonStyle?)',
          'The ButtonStyle applied to all descendant IconButtons. '
              'Controls foreground, background, icon size, padding, shape, '
              'elevation, overlay color, shadow color, and more.',
        ),
        _buildInfoCard(
          'IconButtonTheme Widget',
          'An InheritedWidget that propagates IconButtonThemeData '
              'to all descendant IconButton widgets. Wrap a subtree '
              'with IconButtonTheme to apply a consistent style.',
        ),
        _buildInfoCard(
          'Merge Behavior',
          'When nested, the inner IconButtonThemeData fully replaces '
              'the outer one. There is no automatic merging of properties. '
              'To merge, manually combine styles before passing to the theme.',
        ),
        _buildInfoCard(
          'ButtonStyle Properties Used',
          'foregroundColor, backgroundColor, overlayColor, shadowColor, '
              'surfaceTintColor, elevation, padding, minimumSize, maximumSize, '
              'iconSize, side, shape, mouseCursor, visualDensity, tapTargetSize, '
              'animationDuration, enableFeedback, alignment, splashFactory.',
        ),
        _buildInfoCard(
          'WidgetStateProperty',
          'Style properties use WidgetStateProperty to resolve values '
              'based on button states: hovered, focused, pressed, disabled, '
              'selected, and more. Use WidgetStateProperty.all() for uniform '
              'values or WidgetStateProperty.resolveWith() for state-based logic.',
        ),
        _buildInfoCard(
          'Usage Pattern',
          'Create ButtonStyle -> Wrap in IconButtonThemeData -> '
              'Pass to IconButtonTheme widget -> All child IconButtons inherit style.',
        ),
      ],
    ),
  );
}

Widget _buildMultiIconRow() {
  print('Building multi-icon themed row');
  ButtonStyle rowStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Color(0xFF37474F)),
    iconSize: WidgetStateProperty.all(22.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(8)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
  );
  IconButtonThemeData rowTheme = IconButtonThemeData(style: rowStyle);

  List<IconData> iconList = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
    Icons.settings,
    Icons.notifications,
    Icons.mail,
    Icons.camera,
  ];
  List<String> iconNames = [
    'Home',
    'Search',
    'Favorite',
    'Person',
    'Settings',
    'Alerts',
    'Mail',
    'Camera',
  ];

  List<Widget> iconWidgets = [];
  for (int i = 0; i < iconList.length; i++) {
    IconData ic = iconList[i];
    String name = iconNames[i];
    print('Multi-row icon: $name');
    iconWidgets.add(
      Column(
        children: [
          IconButton(
            icon: Icon(ic),
            onPressed: () {
              print('$name pressed');
            },
          ),
          Text(name, style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
        ],
      ),
    );
    if (i < iconList.length - 1) {
      iconWidgets.add(SizedBox(width: 4));
    }
  }

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Themed Icon Button Row (Toolbar Style)',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        SizedBox(height: 8),
        IconButtonTheme(
          data: rowTheme,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: iconWidgets),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDebugOutput() {
  print('=== Debug Output Summary ===');
  print('IconButtonThemeData holds a ButtonStyle? property');

  ButtonStyle debugStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Color(0xFF1565C0)),
    backgroundColor: WidgetStateProperty.all(Color(0xFFE3F2FD)),
    iconSize: WidgetStateProperty.all(24.0),
  );
  IconButtonThemeData debugTheme = IconButtonThemeData(style: debugStyle);
  print('Debug theme created: $debugTheme');
  print('Debug style: $debugStyle');

  IconButtonThemeData emptyTheme = IconButtonThemeData();
  print('Empty theme (no style): $emptyTheme');

  IconButtonThemeData nullStyleTheme = IconButtonThemeData(style: null);
  print('Null style theme: $nullStyleTheme');

  bool areEqual = debugTheme == nullStyleTheme;
  print('Debug theme == null style theme: $areEqual');

  int hashVal = debugTheme.hashCode;
  print('Debug theme hashCode: $hashVal');

  print('=== End Debug Output ===');

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Debug and Print Output',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Check console for detailed print() output including:',
          style: TextStyle(fontSize: 13),
        ),
        SizedBox(height: 4),
        Text(
          '- Theme creation logs for each section',
          style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
        Text(
          '- Button press callbacks',
          style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
        Text(
          '- Style property values',
          style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
        Text(
          '- Equality and hash code checks',
          style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
        Text(
          '- Empty and null style comparisons',
          style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== IconButtonThemeData Visual Demo ===');
  print('Demonstrating IconButtonThemeData and IconButtonTheme usage');
  print(
    'IconButtonThemeData customizes IconButton appearance via IconButtonTheme',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('IconButtonThemeData Demo'),
        backgroundColor: Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Default IconButtons (No Theme)'),
            SizedBox(height: 8),
            _buildDefaultIconButtons(),
            SizedBox(height: 24),

            _buildSectionHeader('2. Themed IconButtons'),
            SizedBox(height: 8),
            _buildThemedIconButtons(),
            SizedBox(height: 24),

            _buildSectionHeader('3. Foreground Color Styles'),
            SizedBox(height: 8),
            _buildForegroundColorStyles(),
            SizedBox(height: 24),

            _buildSectionHeader('4. Background Color Styles'),
            SizedBox(height: 8),
            _buildBackgroundColorStyles(),
            SizedBox(height: 24),

            _buildSectionHeader('5. Icon Size Variations'),
            SizedBox(height: 8),
            _buildIconSizeVariations(),
            SizedBox(height: 24),

            _buildSectionHeader('6. Padding Variations'),
            SizedBox(height: 8),
            _buildPaddingVariations(),
            SizedBox(height: 24),

            _buildSectionHeader('7. Shape Variations'),
            SizedBox(height: 8),
            _buildShapeVariations(),
            SizedBox(height: 24),

            _buildSectionHeader('8. Nested Theme Override'),
            SizedBox(height: 8),
            _buildNestedThemes(),
            SizedBox(height: 24),

            _buildSectionHeader('9. Themed vs Unthemed'),
            SizedBox(height: 8),
            _buildThemedVsUnthemed(),
            SizedBox(height: 24),

            _buildSectionHeader('10. Multi-Icon Toolbar Row'),
            SizedBox(height: 8),
            _buildMultiIconRow(),
            SizedBox(height: 24),

            _buildSectionHeader('11. IconButton Variants Under Theme'),
            SizedBox(height: 8),
            _buildVariantsSection(),
            SizedBox(height: 24),

            _buildSectionHeader('12. Property Reference'),
            SizedBox(height: 8),
            _buildPropertyReference(),
            SizedBox(height: 24),

            _buildSectionHeader('13. Debug Output'),
            SizedBox(height: 8),
            _buildDebugOutput(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
