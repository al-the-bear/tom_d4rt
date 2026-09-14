// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoPicker, CupertinoDatePicker, CupertinoTimerPicker
// Deep Demo: Visual demonstration of Cupertino picker widgets and real-world panels
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino Pickers Deep Demo executing');

  // ============================================================
  // SECTION 1: CupertinoPicker Variants
  // ============================================================
  print('=== Section 1: CupertinoPicker Variants ===');

  // Variant 1: Basic picker (itemExtent only)
  final basicPicker = CupertinoPicker(
    itemExtent: 32.0,
    onSelectedItemChanged: (int index) {
      print('Basic picker selected: $index');
    },
    children: [
      Center(child: Text('Apple')),
      Center(child: Text('Banana')),
      Center(child: Text('Cherry')),
      Center(child: Text('Date')),
      Center(child: Text('Elderberry')),
    ],
  );
  print('Basic CupertinoPicker created');

  // Variant 2: diameterRatio for curvature
  final diameterPicker = CupertinoPicker(
    itemExtent: 32.0,
    diameterRatio: 1.1,
    onSelectedItemChanged: (index) {
      print('Diameter picker selected: $index');
    },
    children: [
      Center(child: Text('Curve A')),
      Center(child: Text('Curve B')),
      Center(child: Text('Curve C')),
      Center(child: Text('Curve D')),
      Center(child: Text('Curve E')),
    ],
  );
  print('CupertinoPicker with diameterRatio created');

  // Variant 3: magnification + useMagnifier
  final magnifiedPicker = CupertinoPicker(
    itemExtent: 32.0,
    magnification: 1.3,
    useMagnifier: true,
    onSelectedItemChanged: (index) {
      print('Magnified picker selected: $index');
    },
    children: [
      Center(child: Text('Mag 1')),
      Center(child: Text('Mag 2')),
      Center(child: Text('Mag 3')),
      Center(child: Text('Mag 4')),
      Center(child: Text('Mag 5')),
    ],
  );
  print('CupertinoPicker with magnification created');

  // Variant 4: looping
  final loopingPicker = CupertinoPicker(
    itemExtent: 32.0,
    looping: true,
    onSelectedItemChanged: (index) {
      print('Looping picker selected: $index');
    },
    children: [
      Center(child: Text('Loop 1')),
      Center(child: Text('Loop 2')),
      Center(child: Text('Loop 3')),
      Center(child: Text('Loop 4')),
      Center(child: Text('Loop 5')),
    ],
  );
  print('CupertinoPicker with looping created');

  // Variant 5: custom selectionOverlay
  final overlayPicker = CupertinoPicker(
    itemExtent: 32.0,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: CupertinoColors.systemBlue.withValues(alpha: 0.15),
    ),
    onSelectedItemChanged: (index) {
      print('Overlay picker selected: $index');
    },
    children: [
      Center(child: Text('Blue Pick 1')),
      Center(child: Text('Blue Pick 2')),
      Center(child: Text('Blue Pick 3')),
      Center(child: Text('Blue Pick 4')),
      Center(child: Text('Blue Pick 5')),
    ],
  );
  print('CupertinoPicker with custom selectionOverlay created');

  // Variant 6: backgroundColor + squeeze + offAxisFraction
  final bgPicker = CupertinoPicker(
    itemExtent: 32.0,
    backgroundColor: CupertinoColors.systemGrey6,
    squeeze: 1.45,
    offAxisFraction: 0.2,
    onSelectedItemChanged: (index) {
      print('Background picker selected: $index');
    },
    children: [
      Center(child: Text('BG One')),
      Center(child: Text('BG Two')),
      Center(child: Text('BG Three')),
      Center(child: Text('BG Four')),
      Center(child: Text('BG Five')),
    ],
  );
  print('CupertinoPicker with backgroundColor created');

  final pickerVariants = <Map<String, dynamic>>[
    {
      'label': 'Basic',
      'desc': 'Just itemExtent: 32',
      'icon': Icons.list,
      'color': Colors.blue,
      'widget': basicPicker,
    },
    {
      'label': 'Diameter Ratio',
      'desc': 'diameterRatio: 1.1',
      'icon': Icons.circle_outlined,
      'color': Colors.teal,
      'widget': diameterPicker,
    },
    {
      'label': 'Magnification',
      'desc': 'magnification: 1.3 + useMagnifier',
      'icon': Icons.zoom_in,
      'color': Colors.purple,
      'widget': magnifiedPicker,
    },
    {
      'label': 'Looping',
      'desc': 'looping: true (infinite scroll)',
      'icon': Icons.loop,
      'color': Colors.orange,
      'widget': loopingPicker,
    },
    {
      'label': 'Custom Overlay',
      'desc': 'Tinted selection overlay',
      'icon': Icons.layers,
      'color': Colors.indigo,
      'widget': overlayPicker,
    },
    {
      'label': 'Background+Squeeze',
      'desc': 'grey6 bg, squeeze 1.45',
      'icon': Icons.palette,
      'color': Colors.brown,
      'widget': bgPicker,
    },
  ];

  final pickerVariantCards = <Widget>[];
  for (final v in pickerVariants) {
    final color = v['color'] as Color;
    pickerVariantCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      v['icon'] as IconData,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          v['label'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          v['desc'] as String,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 180.0,
              width: 260.0,
              child: v['widget'] as Widget,
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
  print('Created ${pickerVariantCards.length} picker variant cards');

  // ============================================================
  // SECTION 2: CupertinoPicker.builder + FixedExtentScrollController
  // ============================================================
  print('=== Section 2: CupertinoPicker.builder ===');

  final countries = <String>[
    'United States',
    'Canada',
    'Mexico',
    'Brazil',
    'Argentina',
    'United Kingdom',
    'France',
    'Germany',
    'Italy',
    'Spain',
    'Japan',
    'China',
    'India',
    'Australia',
    'New Zealand',
  ];

  final countryController = FixedExtentScrollController(initialItem: 5);
  print('FixedExtentScrollController created with initialItem=5');

  final countryPicker = CupertinoPicker.builder(
    itemExtent: 36.0,
    scrollController: countryController,
    backgroundColor: CupertinoColors.systemGrey6,
    onSelectedItemChanged: (index) {
      print('Country selected: ${countries[index]}');
    },
    itemBuilder: (BuildContext ctx, int index) {
      return Center(
        child: Text(
          countries[index],
          style: TextStyle(fontSize: 15.0, color: Colors.indigo.shade900),
        ),
      );
    },
    childCount: countries.length,
  );
  print('CupertinoPicker.builder with ${countries.length} countries created');

  // Also create a numeric builder picker (0-99)
  final numberPicker = CupertinoPicker.builder(
    itemExtent: 30.0,
    scrollController: FixedExtentScrollController(initialItem: 42),
    onSelectedItemChanged: (index) {
      print('Number selected: $index');
    },
    itemBuilder: (BuildContext ctx, int index) {
      return Center(
        child: Text(
          index.toString().padLeft(3, '0'),
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'monospace',
            color: Colors.deepPurple.shade900,
          ),
        ),
      );
    },
    childCount: 100,
  );
  print('Numeric CupertinoPicker.builder (0-99) created');

  Widget buildBuilderCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required Widget picker,
  }) {
    return Container(
      width: 320.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SizedBox(height: 200.0, width: 290.0, child: picker),
          ),
        ],
      ),
    );
  }

  final builderCards = <Widget>[
    buildBuilderCard(
      title: 'Country Builder',
      subtitle: '15 items, FixedExtentScrollController(initialItem: 5)',
      color: Colors.indigo,
      icon: Icons.public,
      picker: countryPicker,
    ),
    buildBuilderCard(
      title: 'Numeric Builder',
      subtitle: '100 items, initialItem: 42',
      color: Colors.deepPurple,
      icon: Icons.numbers,
      picker: numberPicker,
    ),
  ];
  print('Created ${builderCards.length} builder picker cards');

  // ============================================================
  // SECTION 3: CupertinoDatePicker Modes
  // ============================================================
  print('=== Section 3: CupertinoDatePicker Modes ===');

  // Mode 1: time
  final dpTime = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    initialDateTime: DateTime(2026, 5, 21, 9, 30),
    onDateTimeChanged: (dateTime) {
      print('Time mode changed: $dateTime');
    },
  );
  print('CupertinoDatePicker mode=time created');

  // Mode 2: date
  final dpDate = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2026, 5, 21),
    minimumYear: 2000,
    maximumYear: 2050,
    onDateTimeChanged: (dateTime) {
      print('Date mode changed: $dateTime');
    },
  );
  print('CupertinoDatePicker mode=date created');

  // Mode 3: dateAndTime
  final dpDateAndTime = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.dateAndTime,
    initialDateTime: DateTime(2026, 5, 21, 14, 45),
    minimumDate: DateTime(2020, 1, 1),
    maximumDate: DateTime(2030, 12, 31),
    onDateTimeChanged: (dateTime) {
      print('DateAndTime mode changed: $dateTime');
    },
  );
  print('CupertinoDatePicker mode=dateAndTime created');

  // Mode 4: monthYear
  final dpMonthYear = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.monthYear,
    initialDateTime: DateTime(2026, 5),
    minimumYear: 2000,
    maximumYear: 2050,
    onDateTimeChanged: (dateTime) {
      print('MonthYear mode changed: $dateTime');
    },
  );
  print('CupertinoDatePicker mode=monthYear created');

  // Variant 5: 24h format + minuteInterval
  final dp24h = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    use24hFormat: true,
    minuteInterval: 15,
    initialDateTime: DateTime(2026, 5, 21, 18, 0),
    onDateTimeChanged: (dateTime) {
      print('24h time changed: $dateTime');
    },
  );
  print('CupertinoDatePicker 24h+interval=15 created');

  // Variant 6: ymd order + showDayOfWeek
  final dpYmd = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    dateOrder: DatePickerDateOrder.ymd,
    showDayOfWeek: true,
    backgroundColor: CupertinoColors.systemGrey6,
    initialDateTime: DateTime(2026, 5, 21),
    onDateTimeChanged: (dateTime) {
      print('YMD date changed: $dateTime');
    },
  );
  print('CupertinoDatePicker ymd+showDayOfWeek created');

  final datePickerVariants = <Map<String, dynamic>>[
    {
      'label': 'Mode: time',
      'desc': 'Hour:Minute am/pm',
      'icon': Icons.access_time,
      'color': Colors.blue,
      'widget': dpTime,
    },
    {
      'label': 'Mode: date',
      'desc': 'Month, day, year',
      'icon': Icons.calendar_today,
      'color': Colors.green,
      'widget': dpDate,
    },
    {
      'label': 'Mode: dateAndTime',
      'desc': 'Day + time wheel',
      'icon': Icons.schedule,
      'color': Colors.orange,
      'widget': dpDateAndTime,
    },
    {
      'label': 'Mode: monthYear',
      'desc': 'Month + year only',
      'icon': Icons.event,
      'color': Colors.purple,
      'widget': dpMonthYear,
    },
    {
      'label': '24h + interval',
      'desc': 'use24hFormat, minuteInterval=15',
      'icon': Icons.timer,
      'color': Colors.teal,
      'widget': dp24h,
    },
    {
      'label': 'YMD + day of week',
      'desc': 'dateOrder.ymd, showDayOfWeek',
      'icon': Icons.view_week,
      'color': Colors.indigo,
      'widget': dpYmd,
    },
  ];

  final datePickerCards = <Widget>[];
  for (final v in datePickerVariants) {
    final color = v['color'] as Color;
    datePickerCards.add(
      Container(
        width: 320.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.7),
                    color.withValues(alpha: 0.45),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    v['icon'] as IconData,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          v['label'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          v['desc'] as String,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200.0,
              width: 320.0,
              child: v['widget'] as Widget,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${datePickerCards.length} date picker cards');

  // ============================================================
  // SECTION 4: CupertinoTimerPicker Modes
  // ============================================================
  print('=== Section 4: CupertinoTimerPicker Modes ===');

  // Mode hm
  final tpHm = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    initialTimerDuration: Duration(hours: 1, minutes: 30),
    onTimerDurationChanged: (Duration d) {
      print('Timer hm changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=hm created');

  // Mode ms
  final tpMs = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.ms,
    initialTimerDuration: Duration(minutes: 5, seconds: 30),
    onTimerDurationChanged: (Duration d) {
      print('Timer ms changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=ms created');

  // Mode hms
  final tpHms = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    initialTimerDuration: Duration(hours: 0, minutes: 25, seconds: 15),
    onTimerDurationChanged: (Duration d) {
      print('Timer hms changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=hms created');

  // Variant: minuteInterval
  final tpMinInt = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    minuteInterval: 5,
    initialTimerDuration: Duration(hours: 2, minutes: 15),
    onTimerDurationChanged: (Duration d) {
      print('Timer min-interval changed: $d');
    },
  );
  print('CupertinoTimerPicker minuteInterval=5 created');

  // Variant: secondInterval
  final tpSecInt = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    secondInterval: 10,
    initialTimerDuration: Duration(minutes: 1, seconds: 20),
    onTimerDurationChanged: (Duration d) {
      print('Timer sec-interval changed: $d');
    },
  );
  print('CupertinoTimerPicker secondInterval=10 created');

  // Variant: backgroundColor + alignment
  final tpBg = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    backgroundColor: CupertinoColors.systemGrey6,
    alignment: Alignment.center,
    itemExtent: 36.0,
    initialTimerDuration: Duration(minutes: 10, seconds: 45),
    onTimerDurationChanged: (Duration d) {
      print('Timer bg changed: $d');
    },
  );
  print('CupertinoTimerPicker bg+alignment created');

  final timerPickerVariants = <Map<String, dynamic>>[
    {
      'label': 'Mode: hm',
      'desc': 'Hours + minutes',
      'icon': Icons.hourglass_top,
      'color': Colors.deepOrange,
      'widget': tpHm,
    },
    {
      'label': 'Mode: ms',
      'desc': 'Minutes + seconds',
      'icon': Icons.timer_10,
      'color': Colors.pink,
      'widget': tpMs,
    },
    {
      'label': 'Mode: hms',
      'desc': 'Hours + minutes + seconds',
      'icon': Icons.timelapse,
      'color': Colors.cyan,
      'widget': tpHms,
    },
    {
      'label': 'minuteInterval: 5',
      'desc': '0, 5, 10, ... minutes',
      'icon': Icons.av_timer,
      'color': Colors.amber,
      'widget': tpMinInt,
    },
    {
      'label': 'secondInterval: 10',
      'desc': '0, 10, 20, ... seconds',
      'icon': Icons.alarm,
      'color': Colors.lightGreen,
      'widget': tpSecInt,
    },
    {
      'label': 'bg+itemExtent',
      'desc': 'grey6, itemExtent=36',
      'icon': Icons.color_lens,
      'color': Colors.brown,
      'widget': tpBg,
    },
  ];

  final timerPickerCards = <Widget>[];
  for (final v in timerPickerVariants) {
    final color = v['color'] as Color;
    timerPickerCards.add(
      Container(
        width: 320.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.07),
              color.withValues(alpha: 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      v['icon'] as IconData,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          v['label'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          v['desc'] as String,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200.0,
              width: 320.0,
              child: v['widget'] as Widget,
            ),
            SizedBox(height: 6.0),
          ],
        ),
      ),
    );
  }
  print('Created ${timerPickerCards.length} timer picker cards');

  // ============================================================
  // SECTION 5: Real-World Picker Panels
  // ============================================================
  print('=== Section 5: Real-World Panels ===');

  // Panel A: Tip calculator (CupertinoPicker for tip %)
  final tipOptions = <int>[0, 5, 10, 12, 15, 18, 20, 25, 30];
  final tipController = FixedExtentScrollController(initialItem: 4);
  final tipPicker = CupertinoPicker(
    itemExtent: 36.0,
    scrollController: tipController,
    backgroundColor: Colors.green.shade50,
    onSelectedItemChanged: (index) {
      print('Tip selected: ${tipOptions[index]}%');
    },
    children: tipOptions.map((p) {
      return Center(
        child: Text(
          '$p%',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
        ),
      );
    }).toList(),
  );

  final tipCalculatorPanel = Container(
    width: 320.0,
    margin: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade100, Colors.lime.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade400, width: 2.0),
    ),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Row(
            children: [
              Icon(Icons.attach_money, color: Colors.green.shade800, size: 28.0),
              SizedBox(width: 8.0),
              Text(
                'Tip Calculator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bill: \$45.80', style: TextStyle(fontSize: 14.0)),
              Text(
                'Tip wheel below',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        SizedBox(height: 200.0, width: 320.0, child: tipPicker),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Roll the wheel to select tip percentage',
            style: TextStyle(fontSize: 11.0, color: Colors.green.shade800),
          ),
        ),
      ],
    ),
  );
  print('Tip calculator panel created');

  // Panel B: Alarm setter (CupertinoDatePicker time)
  final alarmPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    use24hFormat: false,
    minuteInterval: 5,
    initialDateTime: DateTime(2026, 5, 21, 7, 0),
    onDateTimeChanged: (dt) {
      print('Alarm set to: ${dt.hour}:${dt.minute}');
    },
  );
  final alarmPanel = Container(
    width: 320.0,
    margin: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade100, Colors.indigo.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade400, width: 2.0),
    ),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Row(
            children: [
              Icon(
                Icons.alarm_on,
                color: Colors.deepPurple.shade800,
                size: 28.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Alarm Setter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Wake-up time (5 min steps)',
            style: TextStyle(fontSize: 13.0, color: Colors.deepPurple.shade700),
          ),
        ),
        SizedBox(height: 200.0, width: 320.0, child: alarmPicker),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Default: 7:00 AM',
            style: TextStyle(fontSize: 11.0, color: Colors.deepPurple.shade800),
          ),
        ),
      ],
    ),
  );
  print('Alarm setter panel created');

  // Panel C: Age picker (CupertinoDatePicker date)
  final agePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(1990, 1, 1),
    minimumYear: 1900,
    maximumYear: 2026,
    onDateTimeChanged: (dt) {
      print('Birth date selected: $dt');
    },
  );
  final agePanel = Container(
    width: 320.0,
    margin: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade100, Colors.blue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade400, width: 2.0),
    ),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Row(
            children: [
              Icon(Icons.cake, color: Colors.cyan.shade800, size: 28.0),
              SizedBox(width: 8.0),
              Text(
                'Birth Date Picker',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.cyan.shade900,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Years 1900 - 2026',
            style: TextStyle(fontSize: 13.0, color: Colors.cyan.shade800),
          ),
        ),
        SizedBox(height: 200.0, width: 320.0, child: agePicker),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Used to compute age',
            style: TextStyle(fontSize: 11.0, color: Colors.cyan.shade900),
          ),
        ),
      ],
    ),
  );
  print('Birth date picker panel created');

  // Panel D: Cook timer (CupertinoTimerPicker hms)
  final cookTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    initialTimerDuration: Duration(minutes: 15, seconds: 0),
    backgroundColor: Colors.orange.shade50,
    onTimerDurationChanged: (Duration d) {
      print('Cook timer: $d');
    },
  );
  final cookPanel = Container(
    width: 320.0,
    margin: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade100, Colors.red.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade400, width: 2.0),
    ),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Colors.orange.shade800,
                size: 28.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Cooking Timer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.orange.shade900,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Hours / Minutes / Seconds',
            style: TextStyle(fontSize: 13.0, color: Colors.orange.shade800),
          ),
        ),
        SizedBox(height: 200.0, width: 320.0, child: cookTimer),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Default: 15 minutes',
            style: TextStyle(fontSize: 11.0, color: Colors.orange.shade900),
          ),
        ),
      ],
    ),
  );
  print('Cook timer panel created');

  final realWorldPanels = <Widget>[
    tipCalculatorPanel,
    alarmPanel,
    agePanel,
    cookPanel,
  ];
  print('Created ${realWorldPanels.length} real-world panels');

  // ============================================================
  // SECTION 6: Code Panels for Each Variant
  // ============================================================
  print('=== Section 6: Code Examples ===');

  Widget buildCodePanel(String title, String code, Color accent) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: accent, size: 18.0),
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
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Colors.greenAccent.shade100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final codePanels = <Widget>[
    buildCodePanel(
      'CupertinoPicker — basic',
      '// Itemized picker with onChanged\n'
          'CupertinoPicker(\n'
          '  itemExtent: 32.0,\n'
          '  onSelectedItemChanged: (i) => print(i),\n'
          '  children: [\n'
          '    Center(child: Text("Apple")),\n'
          '    Center(child: Text("Banana")),\n'
          '    Center(child: Text("Cherry")),\n'
          '  ],\n'
          ');',
      Colors.cyan.shade300,
    ),
    buildCodePanel(
      'CupertinoPicker — magnification + looping',
      '// Magnified, infinite scroll\n'
          'CupertinoPicker(\n'
          '  itemExtent: 32.0,\n'
          '  magnification: 1.3,\n'
          '  useMagnifier: true,\n'
          '  looping: true,\n'
          '  onSelectedItemChanged: (i) {},\n'
          '  children: [...],\n'
          ');',
      Colors.purpleAccent.shade100,
    ),
    buildCodePanel(
      'CupertinoPicker.builder',
      '// Lazy item construction\n'
          'CupertinoPicker.builder(\n'
          '  itemExtent: 36.0,\n'
          '  scrollController:\n'
          '      FixedExtentScrollController(initialItem: 5),\n'
          '  childCount: countries.length,\n'
          '  itemBuilder: (ctx, i) => Center(\n'
          '    child: Text(countries[i]),\n'
          '  ),\n'
          '  onSelectedItemChanged: (i) {},\n'
          ');',
      Colors.lightBlueAccent.shade100,
    ),
    buildCodePanel(
      'CupertinoDatePicker — modes',
      '// 4 supported modes\n'
          'CupertinoDatePicker(\n'
          '  mode: CupertinoDatePickerMode.time,\n'
          '  onDateTimeChanged: (dt) {},\n'
          ');\n'
          'CupertinoDatePicker(\n'
          '  mode: CupertinoDatePickerMode.date,\n'
          '  minimumYear: 2000, maximumYear: 2050,\n'
          '  onDateTimeChanged: (dt) {},\n'
          ');\n'
          'CupertinoDatePicker(\n'
          '  mode: CupertinoDatePickerMode.dateAndTime,\n'
          '  onDateTimeChanged: (dt) {},\n'
          ');\n'
          'CupertinoDatePicker(\n'
          '  mode: CupertinoDatePickerMode.monthYear,\n'
          '  onDateTimeChanged: (dt) {},\n'
          ');',
      Colors.amberAccent.shade100,
    ),
    buildCodePanel(
      'CupertinoTimerPicker — modes',
      '// 3 supported modes\n'
          'CupertinoTimerPicker(\n'
          '  mode: CupertinoTimerPickerMode.hm,\n'
          '  initialTimerDuration: Duration(hours: 1, minutes: 30),\n'
          '  onTimerDurationChanged: (d) {},\n'
          ');\n'
          'CupertinoTimerPicker(\n'
          '  mode: CupertinoTimerPickerMode.ms,\n'
          '  minuteInterval: 5,\n'
          '  onTimerDurationChanged: (d) {},\n'
          ');\n'
          'CupertinoTimerPicker(\n'
          '  mode: CupertinoTimerPickerMode.hms,\n'
          '  secondInterval: 10,\n'
          '  onTimerDurationChanged: (d) {},\n'
          ');',
      Colors.pinkAccent.shade100,
    ),
    buildCodePanel(
      'Custom selection overlay',
      '// Tinted overlay around selected row\n'
          'CupertinoPicker(\n'
          '  itemExtent: 32.0,\n'
          '  selectionOverlay:\n'
          '      CupertinoPickerDefaultSelectionOverlay(\n'
          '    background:\n'
          '        CupertinoColors.systemBlue.withValues(alpha: 0.15),\n'
          '  ),\n'
          '  onSelectedItemChanged: (i) {},\n'
          '  children: [...],\n'
          ');',
      Colors.tealAccent.shade100,
    ),
  ];
  print('Created ${codePanels.length} code panels');

  // ============================================================
  // SECTION 7: Comparison Table + Summary
  // ============================================================
  print('=== Section 7: Comparison Table + Summary ===');

  Widget tableHeader(String text, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.indigo.shade700,
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget tableCell(String text, double width, {Color? color}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color ?? Colors.indigo.shade50,
        border: Border.all(color: Colors.indigo.shade100, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11.0, color: Colors.indigo.shade900),
      ),
    );
  }

  final comparisonRows = <List<String>>[
    ['Widget', 'Output Type', 'Modes', 'Common Use'],
    ['CupertinoPicker', 'int (index)', '—', 'Generic list selection'],
    ['CupertinoPicker.builder', 'int (index)', '—', 'Large / lazy lists'],
    [
      'CupertinoDatePicker',
      'DateTime',
      'time / date / dateAndTime / monthYear',
      'Birthdays, schedules',
    ],
    [
      'CupertinoTimerPicker',
      'Duration',
      'hm / ms / hms',
      'Timers, durations',
    ],
  ];

  final colWidths = <double>[170.0, 110.0, 220.0, 170.0];

  final comparisonTable = Container(
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Column(
        children: [
          Row(
            children: List<Widget>.generate(
              comparisonRows[0].length,
              (i) => tableHeader(comparisonRows[0][i], colWidths[i]),
            ),
          ),
          for (int r = 1; r < comparisonRows.length; r++)
            Row(
              children: List<Widget>.generate(
                comparisonRows[r].length,
                (i) => tableCell(
                  comparisonRows[r][i],
                  colWidths[i],
                  color: r.isEven
                      ? Colors.indigo.shade50
                      : Colors.indigo.shade100.withValues(alpha: 0.4),
                ),
              ),
            ),
        ],
      ),
    ),
  );
  print('Comparison table created');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.cyan.shade100],
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
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 14.0),
        _buildSummaryItem(
          Icons.list_alt,
          'CupertinoPicker',
          'Wheel-style picker for any list of widgets',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.layers,
          'CupertinoPicker.builder',
          'Lazy variant for large/infinite item counts',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.calendar_today,
          'CupertinoDatePicker',
          '4 modes: time, date, dateAndTime, monthYear',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.timer,
          'CupertinoTimerPicker',
          '3 modes: hm, ms, hms — outputs Duration',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.control_camera,
          'FixedExtentScrollController',
          'Programmatic control over initial / selected item',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.style,
          'CupertinoPickerDefaultSelectionOverlay',
          'Customize the highlighted selection band',
          Colors.deepPurple,
        ),
      ],
    ),
  );
  print('Summary panel created');

  print('Cupertino Pickers Deep Demo completed successfully');

  // ============================================================
  // Final layout: MaterialApp -> Scaffold -> SingleChildScrollView -> Column
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header banner
              Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.cyan],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withValues(alpha: 0.3),
                      blurRadius: 14.0,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.view_carousel,
                      size: 56.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Cupertino Pickers Deep Demo',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Wheel pickers, date / time pickers, timer pickers',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),

              // Section 1
              Text(
                '1. CupertinoPicker Variants',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Six visual variations of CupertinoPicker showing itemExtent, '
                'diameterRatio, magnification, looping, custom selection overlay '
                'and background colours.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: pickerVariantCards,
              ),
              SizedBox(height: 32.0),

              // Section 2
              Text(
                '2. CupertinoPicker.builder + FixedExtentScrollController',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Lazy item construction via itemBuilder, with programmatic '
                'selection through a FixedExtentScrollController.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12.0),
              Wrap(alignment: WrapAlignment.center, children: builderCards),
              SizedBox(height: 32.0),

              // Section 3
              Text(
                '3. CupertinoDatePicker Modes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'All four CupertinoDatePickerMode values plus 24h format, '
                'dateOrder.ymd and showDayOfWeek variants.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: datePickerCards,
              ),
              SizedBox(height: 32.0),

              // Section 4
              Text(
                '4. CupertinoTimerPicker Modes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'All three CupertinoTimerPickerMode values (hm, ms, hms) plus '
                'minuteInterval, secondInterval, alignment and backgroundColor '
                'variants.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: timerPickerCards,
              ),
              SizedBox(height: 32.0),

              // Section 5
              Text(
                '5. Real-World Panels',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Four realistic panels: tip calculator, alarm setter, birth '
                'date picker and cooking timer.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: realWorldPanels,
              ),
              SizedBox(height: 32.0),

              // Section 6
              Text(
                '6. Code Examples',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Reference snippets for every picker variant in this demo.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12.0),
              ...codePanels,
              SizedBox(height: 32.0),

              // Section 7
              Text(
                '7. Comparison + Summary',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Side-by-side comparison of the four Cupertino picker widgets '
                'followed by the takeaways summary.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: comparisonTable,
              ),
              summaryPanel,
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13.0,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
