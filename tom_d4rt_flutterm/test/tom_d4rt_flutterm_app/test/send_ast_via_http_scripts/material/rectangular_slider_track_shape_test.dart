// ignore_for_file: avoid_print
// D4rt test script: Tests RectangularSliderTrackShape from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RectangularSliderTrackShape Demo - Building widget tree');
  print('Testing rectangular slider track shape that draws a rectangle');
  
  var sliderValue1 = 0.5;
  var sliderValue2 = 0.3;
  var sliderValue3 = 0.7;
  var sliderValue4 = 0.25;
  var sliderValue5 = 0.6;
  var sliderValue6 = 0.8;
  var sliderValue7 = 0.4;
  var sliderValue8 = 0.55;
  var sliderValue9 = 0.15;
  var sliderValue10 = 0.9;
  
  print('Initialized slider values for demonstrations');
  
  var rectangularTrackShape = RectangularSliderTrackShape();
  print('Created RectangularSliderTrackShape instance');
  print('Track shape type: ${rectangularTrackShape.runtimeType}');
  
  Widget buildSectionHeader(String title, String subtitle) {
    print('Building section header: $title');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade800,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget buildSliderCard(String label, Widget sliderWidget, String description) {
    print('Building slider card: $label');
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            sliderWidget,
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget buildComparisonRow(String shape1Name, Widget slider1, String shape2Name, Widget slider2) {
    print('Building comparison row: $shape1Name vs $shape2Name');
    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shape1Name,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    slider1,
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shape2Name,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    slider2,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget buildInfoBox(String title, String content) {
    print('Building info box: $title');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
  }
  
  print('Building Section 1: Basic Sliders with Rectangular Track');
  
  var basicSlider1 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 4.0,
    ),
    child: Slider(
      value: sliderValue1,
      onChanged: (value) {
        print('Basic slider 1 changed to: $value');
      },
    ),
  );
  
  var basicSlider2 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
    ),
    child: Slider(
      value: sliderValue2,
      min: 0.0,
      max: 1.0,
      onChanged: (value) {
        print('Basic slider 2 changed to: $value');
      },
    ),
  );
  
  var basicSlider3 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 8.0,
    ),
    child: Slider(
      value: sliderValue3,
      min: 0.0,
      max: 100.0,
      divisions: 10,
      onChanged: (value) {
        print('Basic slider 3 with divisions changed to: $value');
      },
    ),
  );
  
  var basicSlider4 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 2.0,
    ),
    child: Slider(
      value: sliderValue4,
      onChanged: (value) {
        print('Basic thin slider changed to: $value');
      },
    ),
  );
  
  print('Building Section 2: Color Variations');
  
  var colorSlider1 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.red,
      inactiveTrackColor: Colors.red.shade100,
      thumbColor: Colors.red.shade700,
    ),
    child: Slider(
      value: sliderValue5,
      onChanged: (value) {
        print('Red slider changed to: $value');
      },
    ),
  );
  
  var colorSlider2 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.green,
      inactiveTrackColor: Colors.green.shade100,
      thumbColor: Colors.green.shade700,
    ),
    child: Slider(
      value: sliderValue6,
      onChanged: (value) {
        print('Green slider changed to: $value');
      },
    ),
  );
  
  var colorSlider3 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.purple,
      inactiveTrackColor: Colors.purple.shade100,
      thumbColor: Colors.purple.shade700,
    ),
    child: Slider(
      value: sliderValue7,
      onChanged: (value) {
        print('Purple slider changed to: $value');
      },
    ),
  );
  
  var colorSlider4 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.orange,
      inactiveTrackColor: Colors.orange.shade100,
      thumbColor: Colors.orange.shade700,
    ),
    child: Slider(
      value: sliderValue8,
      onChanged: (value) {
        print('Orange slider changed to: $value');
      },
    ),
  );
  
  var colorSlider5 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.teal,
      inactiveTrackColor: Colors.teal.shade100,
      thumbColor: Colors.teal.shade700,
    ),
    child: Slider(
      value: sliderValue9,
      onChanged: (value) {
        print('Teal slider changed to: $value');
      },
    ),
  );
  
  var colorSlider6 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.indigo,
      inactiveTrackColor: Colors.indigo.shade100,
      thumbColor: Colors.indigo.shade700,
    ),
    child: Slider(
      value: sliderValue10,
      onChanged: (value) {
        print('Indigo slider changed to: $value');
      },
    ),
  );
  
  print('Building Section 3: Track Height Demos');
  
  var heightSlider1 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 2.0,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.blue.shade100,
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Height 2.0 slider changed to: $value');
      },
    ),
  );
  
  var heightSlider2 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 4.0,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.blue.shade100,
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Height 4.0 slider changed to: $value');
      },
    ),
  );
  
  var heightSlider3 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 8.0,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.blue.shade100,
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Height 8.0 slider changed to: $value');
      },
    ),
  );
  
  var heightSlider4 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 12.0,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.blue.shade100,
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Height 12.0 slider changed to: $value');
      },
    ),
  );
  
  var heightSlider5 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 16.0,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.blue.shade100,
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Height 16.0 slider changed to: $value');
      },
    ),
  );
  
  var heightSlider6 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 20.0,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.blue.shade100,
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Height 20.0 slider changed to: $value');
      },
    ),
  );
  
  print('Building Section 4: SliderTheme Integration');
  
  var themedSlider1 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 8.0,
      activeTrackColor: Colors.deepPurple,
      inactiveTrackColor: Colors.deepPurple.shade100,
      thumbColor: Colors.deepPurple,
      overlayColor: Colors.deepPurple.withAlpha(50),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
    ),
    child: Slider(
      value: 0.6,
      onChanged: (value) {
        print('Themed slider 1 changed to: $value');
      },
    ),
  );
  
  var themedSlider2 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 10.0,
      activeTrackColor: Colors.amber,
      inactiveTrackColor: Colors.amber.shade100,
      thumbColor: Colors.amber.shade800,
      overlayColor: Colors.amber.withAlpha(50),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14.0),
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: Colors.amber.shade700,
      showValueIndicator: ShowValueIndicator.onDrag,
    ),
    child: Slider(
      value: 0.75,
      label: '75%',
      onChanged: (value) {
        print('Themed slider 2 with indicator changed to: $value');
      },
    ),
  );
  
  var themedSlider3 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.cyan,
      inactiveTrackColor: Colors.cyan.shade50,
      thumbColor: Colors.cyan.shade800,
      activeTickMarkColor: Colors.cyan.shade800,
      inactiveTickMarkColor: Colors.cyan.shade200,
    ),
    child: Slider(
      value: 0.4,
      divisions: 10,
      onChanged: (value) {
        print('Themed slider 3 with tick marks changed to: $value');
      },
    ),
  );
  
  var themedSlider4 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 8.0,
      activeTrackColor: Colors.pink,
      inactiveTrackColor: Colors.pink.shade50,
      thumbColor: Colors.pink,
      overlayColor: Colors.pink.withAlpha(30),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0, disabledThumbRadius: 8.0),
    ),
    child: Slider(
      value: 0.35,
      onChanged: (value) {
        print('Themed slider 4 changed to: $value');
      },
    ),
  );
  
  var disabledThemedSlider = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      disabledActiveTrackColor: Colors.grey.shade400,
      disabledInactiveTrackColor: Colors.grey.shade200,
      disabledThumbColor: Colors.grey.shade400,
    ),
    child: Slider(
      value: 0.5,
      onChanged: null,
    ),
  );
  
  print('Building Section 5: Comparison with Other Track Shapes');
  
  var rectangularCompare = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.blue.shade100,
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Rectangular comparison slider changed to: $value');
      },
    ),
  );
  
  var roundedCompare = SliderTheme(
    data: SliderThemeData(
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.blue.shade100,
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Rounded comparison slider changed to: $value');
      },
    ),
  );
  
  var rectangularThin = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 2.0,
      activeTrackColor: Colors.green,
      inactiveTrackColor: Colors.green.shade100,
    ),
    child: Slider(
      value: 0.6,
      onChanged: (value) {
        print('Thin rectangular slider changed to: $value');
      },
    ),
  );
  
  var roundedThin = SliderTheme(
    data: SliderThemeData(
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: 2.0,
      activeTrackColor: Colors.green,
      inactiveTrackColor: Colors.green.shade100,
    ),
    child: Slider(
      value: 0.6,
      onChanged: (value) {
        print('Thin rounded slider changed to: $value');
      },
    ),
  );
  
  var rectangularThick = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 14.0,
      activeTrackColor: Colors.red,
      inactiveTrackColor: Colors.red.shade100,
    ),
    child: Slider(
      value: 0.7,
      onChanged: (value) {
        print('Thick rectangular slider changed to: $value');
      },
    ),
  );
  
  var roundedThick = SliderTheme(
    data: SliderThemeData(
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: 14.0,
      activeTrackColor: Colors.red,
      inactiveTrackColor: Colors.red.shade100,
    ),
    child: Slider(
      value: 0.7,
      onChanged: (value) {
        print('Thick rounded slider changed to: $value');
      },
    ),
  );
  
  print('Building Section 6: Custom Configurations');
  
  var customSlider1 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 10.0,
      activeTrackColor: Color(0xFF1E88E5),
      inactiveTrackColor: Color(0xFFBBDEFB),
      thumbColor: Color(0xFF0D47A1),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
      overlayColor: Color(0x291E88E5),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
    ),
    child: Slider(
      value: 0.5,
      onChanged: (value) {
        print('Custom slider 1 changed to: $value');
      },
    ),
  );
  
  var customSlider2 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 8.0,
      activeTrackColor: Color(0xFF43A047),
      inactiveTrackColor: Color(0xFFC8E6C9),
      thumbColor: Color(0xFF1B5E20),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: Color(0xFF2E7D32),
      valueIndicatorTextStyle: TextStyle(color: Colors.white, fontSize: 14.0),
      showValueIndicator: ShowValueIndicator.onlyForContinuous,
    ),
    child: Slider(
      value: 0.65,
      label: '65%',
      onChanged: (value) {
        print('Custom slider 2 with value indicator changed to: $value');
      },
    ),
  );
  
  var customSlider3 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 12.0,
      activeTrackColor: Color(0xFFE53935),
      inactiveTrackColor: Color(0xFFFFCDD2),
      thumbColor: Color(0xFFB71C1C),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14.0),
      activeTickMarkColor: Color(0xFFB71C1C),
      inactiveTickMarkColor: Color(0xFFEF9A9A),
    ),
    child: Slider(
      value: 0.4,
      divisions: 8,
      onChanged: (value) {
        print('Custom slider 3 with divisions changed to: $value');
      },
    ),
  );
  
  var customSlider4 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 6.0,
      activeTrackColor: Color(0xFF7B1FA2),
      inactiveTrackColor: Color(0xFFE1BEE7),
      thumbColor: Color(0xFF4A148C),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayColor: Color(0x297B1FA2),
    ),
    child: Slider(
      value: 0.8,
      onChanged: (value) {
        print('Custom slider 4 changed to: $value');
      },
    ),
  );
  
  var customSlider5 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 16.0,
      activeTrackColor: Color(0xFFFF6F00),
      inactiveTrackColor: Color(0xFFFFE0B2),
      thumbColor: Color(0xFFE65100),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 16.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
    ),
    child: Slider(
      value: 0.3,
      onChanged: (value) {
        print('Custom slider 5 extra large changed to: $value');
      },
    ),
  );
  
  var customSlider6 = SliderTheme(
    data: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 4.0,
      activeTrackColor: Color(0xFF00838F),
      inactiveTrackColor: Color(0xFFB2EBF2),
      thumbColor: Color(0xFF006064),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
    ),
    child: Slider(
      value: 0.55,
      onChanged: (value) {
        print('Custom slider 6 minimal changed to: $value');
      },
    ),
  );
  
  print('Building additional demonstrations');
  
  var gradientBgSlider = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.purple.shade50],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
    child: SliderTheme(
      data: SliderThemeData(
        trackShape: RectangularSliderTrackShape(),
        trackHeight: 8.0,
        activeTrackColor: Colors.deepPurple,
        inactiveTrackColor: Colors.deepPurple.shade100,
        thumbColor: Colors.deepPurple,
      ),
      child: Slider(
        value: 0.5,
        onChanged: (value) {
          print('Gradient background slider changed to: $value');
        },
      ),
    ),
  );
  
  var darkModeSlider = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: SliderTheme(
      data: SliderThemeData(
        trackShape: RectangularSliderTrackShape(),
        trackHeight: 6.0,
        activeTrackColor: Colors.tealAccent,
        inactiveTrackColor: Colors.grey.shade700,
        thumbColor: Colors.tealAccent,
        overlayColor: Colors.tealAccent.withAlpha(40),
      ),
      child: Slider(
        value: 0.6,
        onChanged: (value) {
          print('Dark mode slider changed to: $value');
        },
      ),
    ),
  );
  
  var multipleSliderColumn = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Volume', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
        SliderTheme(
          data: SliderThemeData(
            trackShape: RectangularSliderTrackShape(),
            trackHeight: 4.0,
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.blue.shade100,
          ),
          child: Slider(
            value: 0.7,
            onChanged: (value) {
              print('Volume slider changed: $value');
            },
          ),
        ),
        SizedBox(height: 8.0),
        Text('Brightness', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
        SliderTheme(
          data: SliderThemeData(
            trackShape: RectangularSliderTrackShape(),
            trackHeight: 4.0,
            activeTrackColor: Colors.amber,
            inactiveTrackColor: Colors.amber.shade100,
          ),
          child: Slider(
            value: 0.5,
            onChanged: (value) {
              print('Brightness slider changed: $value');
            },
          ),
        ),
        SizedBox(height: 8.0),
        Text('Contrast', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
        SliderTheme(
          data: SliderThemeData(
            trackShape: RectangularSliderTrackShape(),
            trackHeight: 4.0,
            activeTrackColor: Colors.grey.shade700,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: Slider(
            value: 0.6,
            onChanged: (value) {
              print('Contrast slider changed: $value');
            },
          ),
        ),
      ],
    ),
  );
  
  print('Building main layout');
  
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade700, Colors.blueGrey.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RectangularSliderTrackShape',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'A slider track shape that draws rectangular track',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        
        buildInfoBox(
          'About RectangularSliderTrackShape',
          'RectangularSliderTrackShape creates a slider track with sharp corners instead of rounded ends. It is useful for designs that require a more geometric appearance.'
        ),
        
        buildSectionHeader(
          'Section 1: Basic Sliders with Rectangular Track',
          'Demonstrating basic rectangular track sliders with different heights'
        ),
        
        buildSliderCard(
          'Default Rectangular Track (4.0 height)',
          basicSlider1,
          'Basic slider with rectangular track shape and default styling',
        ),
        
        buildSliderCard(
          'Rectangular Track (6.0 height)',
          basicSlider2,
          'Slider with slightly thicker rectangular track',
        ),
        
        buildSliderCard(
          'Rectangular Track with Divisions',
          basicSlider3,
          'Slider with rectangular track and 10 divisions for stepped control',
        ),
        
        buildSliderCard(
          'Thin Rectangular Track (2.0 height)',
          basicSlider4,
          'Minimal height rectangular track slider',
        ),
        
        buildSectionHeader(
          'Section 2: Color Variations',
          'Rectangular track sliders with various color themes'
        ),
        
        buildSliderCard('Red Theme', colorSlider1, 'Red colored rectangular track slider'),
        buildSliderCard('Green Theme', colorSlider2, 'Green colored rectangular track slider'),
        buildSliderCard('Purple Theme', colorSlider3, 'Purple colored rectangular track slider'),
        buildSliderCard('Orange Theme', colorSlider4, 'Orange colored rectangular track slider'),
        buildSliderCard('Teal Theme', colorSlider5, 'Teal colored rectangular track slider'),
        buildSliderCard('Indigo Theme', colorSlider6, 'Indigo colored rectangular track slider'),
        
        buildSectionHeader(
          'Section 3: Track Height Demonstrations',
          'Comparing different track heights with rectangular shape'
        ),
        
        buildSliderCard('Track Height: 2.0', heightSlider1, 'Extra thin rectangular track'),
        buildSliderCard('Track Height: 4.0', heightSlider2, 'Thin rectangular track (default-like)'),
        buildSliderCard('Track Height: 8.0', heightSlider3, 'Medium rectangular track'),
        buildSliderCard('Track Height: 12.0', heightSlider4, 'Thick rectangular track'),
        buildSliderCard('Track Height: 16.0', heightSlider5, 'Extra thick rectangular track'),
        buildSliderCard('Track Height: 20.0', heightSlider6, 'Maximum thickness rectangular track'),
        
        buildSectionHeader(
          'Section 4: SliderTheme Integration',
          'Combining rectangular track with various SliderTheme customizations'
        ),
        
        buildSliderCard(
          'Custom Thumb Size',
          themedSlider1,
          'Rectangular track with enlarged thumb (12.0 radius)',
        ),
        
        buildSliderCard(
          'With Value Indicator',
          themedSlider2,
          'Rectangular track with paddle value indicator',
        ),
        
        buildSliderCard(
          'With Tick Marks',
          themedSlider3,
          'Rectangular track with visible tick marks and divisions',
        ),
        
        buildSliderCard(
          'Pink Theme with Custom Overlay',
          themedSlider4,
          'Rectangular track with custom overlay appearance',
        ),
        
        buildSliderCard(
          'Disabled State',
          disabledThemedSlider,
          'Rectangular track slider in disabled state',
        ),
        
        buildSectionHeader(
          'Section 5: Comparison with Other Track Shapes',
          'Visual comparison between rectangular and rounded track shapes'
        ),
        
        buildComparisonRow(
          'Rectangular Track (Standard)',
          rectangularCompare,
          'Rounded Track (Standard)',
          roundedCompare,
        ),
        
        buildComparisonRow(
          'Rectangular Track (Thin)',
          rectangularThin,
          'Rounded Track (Thin)',
          roundedThin,
        ),
        
        buildComparisonRow(
          'Rectangular Track (Thick)',
          rectangularThick,
          'Rounded Track (Thick)',
          roundedThick,
        ),
        
        buildInfoBox(
          'Shape Comparison Notes',
          'The rectangular track shape has sharp 90-degree corners at the ends, while the rounded track shape has smooth semicircular ends. Choose based on your design requirements.'
        ),
        
        buildSectionHeader(
          'Section 6: Custom Configurations',
          'Advanced customizations for rectangular track sliders'
        ),
        
        buildSliderCard(
          'Blue Theme with Large Overlay',
          customSlider1,
          'Custom blue slider with 24.0 overlay radius',
        ),
        
        buildSliderCard(
          'Green with Value Indicator',
          customSlider2,
          'Custom green slider showing value on drag',
        ),
        
        buildSliderCard(
          'Red with 8 Divisions',
          customSlider3,
          'Bold red slider with stepped divisions',
        ),
        
        buildSliderCard(
          'Purple Compact',
          customSlider4,
          'Compact purple slider with small thumb',
        ),
        
        buildSliderCard(
          'Orange Extra Large',
          customSlider5,
          'Extra large slider with 16.0 thumb radius',
        ),
        
        buildSliderCard(
          'Cyan Minimal',
          customSlider6,
          'Minimal cyan slider with small footprint',
        ),
        
        buildSectionHeader(
          'Additional Demonstrations',
          'Special use cases and styling combinations'
        ),
        
        buildSliderCard(
          'Gradient Background Container',
          gradientBgSlider,
          'Rectangular track slider on gradient background',
        ),
        
        buildSliderCard(
          'Dark Mode Style',
          darkModeSlider,
          'Rectangular track slider styled for dark interfaces',
        ),
        
        buildSliderCard(
          'Multiple Sliders Group',
          multipleSliderColumn,
          'Group of rectangular track sliders for settings panel',
        ),
        
        SizedBox(height: 32.0),
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                'RectangularSliderTrackShape provides a clean geometric look for sliders. '
                'It pairs well with modern, minimalist design systems and works '
                'effectively with various track heights and color schemes.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                'Key points:',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '- Sharp corners create a more geometric appearance\n'
                '- Works with all SliderTheme properties\n'
                '- Supports divisions, value indicators, and custom thumbs\n'
                '- Can be combined with any color scheme\n'
                '- Ideal for modern, flat design interfaces',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 24.0),
      ],
    ),
  );
}
