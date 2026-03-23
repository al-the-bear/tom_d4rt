// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RestorableTimeOfDay from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildTimeDisplay(
  String label,
  TimeOfDay time,
  Color accentColor,
) {
  print('Building time display: $label - ${time.hour}:${time.minute}');
  String periodText = time.period == DayPeriod.am ? 'AM' : 'PM';
  int displayHour = time.hourOfPeriod;
  if (displayHour == 0) {
    displayHour = 12;
  }
  String formattedMinute =
      time.minute < 10 ? '0${time.minute}' : '${time.minute}';

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(100)),
      boxShadow: [
        BoxShadow(
          color: accentColor.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: accentColor.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.access_time,
            color: accentColor,
            size: 32,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '$displayHour:$formattedMinute',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      periodText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '24h: ${time.hour}:$formattedMinute',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Hour: ${time.hour}, Min: ${time.minute}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildFormatComparisonCard(TimeOfDay time, String description) {
  print('Building format comparison for: $description');
  int hour12 = time.hourOfPeriod;
  if (hour12 == 0) {
    hour12 = 12;
  }
  String minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
  String period = time.period == DayPeriod.am ? 'AM' : 'PM';

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade700,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      '12-Hour',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue.shade600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$hour12:$minute $period',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      '24-Hour',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green.shade600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${time.hour}:$minute',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'periodOffset: ${time.periodOffset} | hourOfPeriod: ${time.hourOfPeriod}',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    ),
  );
}

Widget buildPeriodOffsetDisplay() {
  print('Building period offset display');
  List<Widget> items = [];

  items.add(
    Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        children: [
          Text(
            'AM Period (periodOffset = 0)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Hours 0-11 have periodOffset of 0',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 4),
          Text(
            'hourOfPeriod ranges from 0 to 11',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
  );

  items.add(SizedBox(height: 12));

  items.add(
    Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
      child: Column(
        children: [
          Text(
            'PM Period (periodOffset = 12)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Hours 12-23 have periodOffset of 12',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 4),
          Text(
            'hourOfPeriod ranges from 0 to 11',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
  );

  return Column(children: items);
}

Widget buildHourGrid() {
  print('Building hour grid');
  List<Widget> rows = [];
  int row = 0;

  for (row = 0; row < 4; row = row + 1) {
    List<Widget> cells = [];
    int col = 0;
    for (col = 0; col < 6; col = col + 1) {
      int hour = row * 6 + col;
      TimeOfDay time = TimeOfDay(hour: hour, minute: 0);
      String period = time.period == DayPeriod.am ? 'AM' : 'PM';
      Color bgColor =
          hour < 12 ? Colors.amber.shade100 : Colors.deepPurple.shade100;
      Color textColor =
          hour < 12 ? Colors.amber.shade800 : Colors.deepPurple.shade800;

      cells.add(
        Expanded(
          child: Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Text(
                  '${time.hour}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 10,
                    color: textColor.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    rows.add(Row(children: cells));
  }

  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(children: rows),
  );
}

Widget buildMinuteRangeDisplay() {
  print('Building minute range display');
  List<Widget> items = [];
  List<int> sampleMinutes = [0, 5, 15, 30, 45, 59];

  int i = 0;
  for (i = 0; i < sampleMinutes.length; i = i + 1) {
    int minute = sampleMinutes[i];
    String formatted = minute < 10 ? '0$minute' : '$minute';

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  formatted,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minute: $minute',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  Text(
                    'Formatted: :$formatted',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '9:$formatted AM',
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: items);
}

Widget buildTimeComparisonScenarios() {
  print('Building time comparison scenarios');
  List<Widget> items = [];

  TimeOfDay time1 = TimeOfDay(hour: 9, minute: 30);
  TimeOfDay time2 = TimeOfDay(hour: 14, minute: 45);
  TimeOfDay time3 = TimeOfDay(hour: 9, minute: 30);

  int time1Minutes = time1.hour * 60 + time1.minute;
  int time2Minutes = time2.hour * 60 + time2.minute;
  int time3Minutes = time3.hour * 60 + time3.minute;

  items.add(
    Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time A: 9:30 AM ($time1Minutes total minutes)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Time B: 2:45 PM ($time2Minutes total minutes)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'A < B: ${time1Minutes < time2Minutes}',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          Text(
            'Difference: ${time2Minutes - time1Minutes} minutes',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ],
      ),
    ),
  );

  items.add(
    Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Equality Check',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Time A: 9:30 AM | Time C: 9:30 AM',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          SizedBox(height: 4),
          Text(
            'A == C: ${time1Minutes == time3Minutes}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  TimeOfDay morning = TimeOfDay(hour: 6, minute: 0);
  TimeOfDay noon = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay evening = TimeOfDay(hour: 18, minute: 0);
  TimeOfDay midnight = TimeOfDay(hour: 0, minute: 0);

  items.add(SizedBox(height: 8));
  items.add(
    Text(
      'Day Periods',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade700,
      ),
    ),
  );
  items.add(SizedBox(height: 8));

  List<List<dynamic>> dayPeriods = [
    ['Morning', morning, Colors.orange],
    ['Noon', noon, Colors.amber],
    ['Evening', evening, Colors.deepPurple],
    ['Midnight', midnight, Colors.blueGrey],
  ];

  int idx = 0;
  for (idx = 0; idx < dayPeriods.length; idx = idx + 1) {
    String periodName = dayPeriods[idx][0] as String;
    TimeOfDay periodTime = dayPeriods[idx][1] as TimeOfDay;
    MaterialColor periodColor = dayPeriods[idx][2] as MaterialColor;

    String periodLabel =
        periodTime.period == DayPeriod.am ? 'AM' : 'PM';
    int displayHour = periodTime.hourOfPeriod;
    if (displayHour == 0) {
      displayHour = 12;
    }

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: periodColor.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.schedule,
              color: periodColor,
              size: 24,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                periodName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: periodColor.shade800,
                ),
              ),
            ),
            Text(
              '$displayHour:00 $periodLabel',
              style: TextStyle(
                fontSize: 14,
                color: periodColor.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items,
  );
}

Widget buildDefaultValuesSection() {
  print('Building default values section');
  TimeOfDay defaultMorning = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay defaultAfternoon = TimeOfDay(hour: 14, minute: 0);
  TimeOfDay defaultEvening = TimeOfDay(hour: 19, minute: 30);
  TimeOfDay defaultNight = TimeOfDay(hour: 22, minute: 0);

  List<Widget> items = [];

  items.add(
    Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableTimeOfDay Usage',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'RestorableTimeOfDay is a RestorableProperty that preserves TimeOfDay values across app restarts.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          SizedBox(height: 4),
          Text(
            'The value is serialized and restored automatically by the restoration framework.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ],
      ),
    ),
  );

  items.add(SizedBox(height: 12));

  List<List<dynamic>> defaults = [
    ['Morning Default', defaultMorning, Icons.wb_sunny, Colors.orange],
    ['Afternoon Default', defaultAfternoon, Icons.wb_cloudy, Colors.blue],
    ['Evening Default', defaultEvening, Icons.nights_stay, Colors.deepPurple],
    ['Night Default', defaultNight, Icons.bedtime, Colors.blueGrey],
  ];

  int i = 0;
  for (i = 0; i < defaults.length; i = i + 1) {
    String name = defaults[i][0] as String;
    TimeOfDay time = defaults[i][1] as TimeOfDay;
    IconData icon = defaults[i][2] as IconData;
    MaterialColor color = defaults[i][3] as MaterialColor;

    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = time.hourOfPeriod;
    if (hour == 0) {
      hour = 12;
    }
    String minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$hour:$minute $period',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  'hour: ${time.hour}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: items);
}

Widget buildLocalizationDemo(BuildContext context) {
  print('Building localization demo');
  List<Widget> items = [];

  TimeOfDay morning = TimeOfDay(hour: 9, minute: 15);
  TimeOfDay afternoon = TimeOfDay(hour: 15, minute: 45);
  TimeOfDay evening = TimeOfDay(hour: 20, minute: 30);

  List<TimeOfDay> times = [morning, afternoon, evening];
  List<String> labels = ['Morning', 'Afternoon', 'Evening'];
  List<MaterialColor> colors = [Colors.orange, Colors.blue, Colors.deepPurple];

  items.add(
    Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MaterialLocalizations.formatTimeOfDay',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Formats TimeOfDay according to locale settings',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
  );

  items.add(SizedBox(height: 12));

  int i = 0;
  for (i = 0; i < times.length; i = i + 1) {
    TimeOfDay time = times[i];
    String label = labels[i];
    MaterialColor color = colors[i];

    String formatted12 = MaterialLocalizations.of(context).formatTimeOfDay(
      time,
      alwaysUse24HourFormat: false,
    );
    String formatted24 = MaterialLocalizations.of(context).formatTimeOfDay(
      time,
      alwaysUse24HourFormat: true,
    );

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: color, size: 22),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: color.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: color.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '12-Hour Format',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          formatted12,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '24-Hour Format',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          formatted24,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: items);
}

Widget buildRestorablePropertyInfo() {
  print('Building restorable property info');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.restore, color: Colors.indigo.shade700, size: 28),
            SizedBox(width: 10),
            Text(
              'Restoration Properties',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildPropertyRow('Type', 'RestorableTimeOfDay'),
        buildPropertyRow('Extends', 'RestorableValue<TimeOfDay>'),
        buildPropertyRow('Serialization', 'hour and minute as list'),
        buildPropertyRow('Default', 'Required in constructor'),
        buildPropertyRow('Nullable', 'Use RestorableTimeOfDayN for null'),
      ],
    ),
  );
}

Widget buildPropertyRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTimeRangeVisualization() {
  print('Building time range visualization');
  List<Widget> hourBlocks = [];

  int hour = 0;
  for (hour = 0; hour < 24; hour = hour + 1) {
    Color blockColor;
    String label;
    if (hour >= 0 && hour < 6) {
      blockColor = Colors.blueGrey.shade400;
      label = 'Night';
    } else if (hour >= 6 && hour < 12) {
      blockColor = Colors.orange.shade400;
      label = 'Morning';
    } else if (hour >= 12 && hour < 18) {
      blockColor = Colors.blue.shade400;
      label = 'Afternoon';
    } else {
      blockColor = Colors.deepPurple.shade400;
      label = 'Evening';
    }

    hourBlocks.add(
      Expanded(
        child: Tooltip(
          message: '$hour:00 - $label',
          child: Container(
            height: 30,
            margin: EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: blockColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                '$hour',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '24-Hour Timeline',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 10),
        Row(children: hourBlocks),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildLegendItem(Colors.blueGrey.shade400, 'Night 0-5'),
            buildLegendItem(Colors.orange.shade400, 'Morning 6-11'),
            buildLegendItem(Colors.blue.shade400, 'Afternoon 12-17'),
            buildLegendItem(Colors.deepPurple.shade400, 'Evening 18-23'),
          ],
        ),
      ],
    ),
  );
}

Widget buildLegendItem(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
      ),
    ],
  );
}

Widget buildTimePickerIntegration() {
  print('Building time picker integration info');
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: Colors.indigo, size: 24),
            SizedBox(width: 10),
            Text(
              'Time Picker Integration',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'RestorableTimeOfDay works seamlessly with showTimePicker:',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Create RestorableTimeOfDay with default',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4),
              Text(
                '2. Register with RestorationMixin',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4),
              Text(
                '3. Pass .value to showTimePicker initialTime',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4),
              Text(
                '4. Update .value with picker result',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTimeArithmeticSection() {
  print('Building time arithmetic section');
  TimeOfDay baseTime = TimeOfDay(hour: 10, minute: 30);
  int baseMinutes = baseTime.hour * 60 + baseTime.minute;

  int addMinutes1 = 45;
  int totalMinutes1 = baseMinutes + addMinutes1;
  int hour1 = (totalMinutes1 ~/ 60) % 24;
  int minute1 = totalMinutes1 % 60;
  TimeOfDay result1 = TimeOfDay(hour: hour1, minute: minute1);

  int addMinutes2 = 120;
  int totalMinutes2 = baseMinutes + addMinutes2;
  int hour2 = (totalMinutes2 ~/ 60) % 24;
  int minute2 = totalMinutes2 % 60;
  TimeOfDay result2 = TimeOfDay(hour: hour2, minute: minute2);

  String formatTime(TimeOfDay t) {
    int h = t.hourOfPeriod;
    if (h == 0) h = 12;
    String m = t.minute < 10 ? '0${t.minute}' : '${t.minute}';
    String p = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$m $p';
  }

  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calculate, color: Colors.orange.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'Time Arithmetic',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Base time: ${formatTime(baseTime)} ($baseMinutes total minutes)',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '+ 45 minutes = ${formatTime(result1)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '+ 120 minutes (2 hours) = ${formatTime(result2)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSpecialTimesSection() {
  print('Building special times section');
  List<Widget> items = [];

  List<List<dynamic>> specialTimes = [
    ['Midnight', TimeOfDay(hour: 0, minute: 0), Icons.dark_mode, Colors.blueGrey],
    ['Dawn', TimeOfDay(hour: 5, minute: 30), Icons.wb_twilight, Colors.purple],
    ['Sunrise', TimeOfDay(hour: 6, minute: 45), Icons.wb_sunny, Colors.orange],
    ['Noon', TimeOfDay(hour: 12, minute: 0), Icons.light_mode, Colors.amber],
    ['Sunset', TimeOfDay(hour: 18, minute: 30), Icons.wb_twilight, Colors.deepOrange],
    ['Dusk', TimeOfDay(hour: 19, minute: 45), Icons.nights_stay, Colors.indigo],
  ];

  int i = 0;
  for (i = 0; i < specialTimes.length; i = i + 1) {
    String name = specialTimes[i][0] as String;
    TimeOfDay time = specialTimes[i][1] as TimeOfDay;
    IconData icon = specialTimes[i][2] as IconData;
    MaterialColor color = specialTimes[i][3] as MaterialColor;

    int h = time.hourOfPeriod;
    if (h == 0) h = 12;
    String m = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    String p = time.period == DayPeriod.am ? 'AM' : 'PM';

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.shade50, color.shade100],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color.shade800, size: 22),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$h:$m $p',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color.shade700,
                  ),
                ),
                Text(
                  '${time.hour}:$m (24h)',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: items);
}

dynamic build(BuildContext context) {
  print('Building RestorableTimeOfDay deep demo');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey.shade50,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RestorableTimeOfDay Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'RestorableTimeOfDay'),
            buildInfoCard(
              'Purpose',
              'Restorable property that holds a TimeOfDay value',
            ),
            buildInfoCard(
              'Extends',
              'RestorableValue<TimeOfDay>',
            ),
            buildInfoCard(
              'Use Case',
              'Preserve selected time across app restarts',
            ),

            buildSectionHeader('2. Visual Time Displays'),
            buildTimeDisplay(
              'Morning Alarm',
              TimeOfDay(hour: 7, minute: 30),
              Colors.orange,
            ),
            buildTimeDisplay(
              'Lunch Time',
              TimeOfDay(hour: 12, minute: 0),
              Colors.amber.shade700,
            ),
            buildTimeDisplay(
              'Meeting',
              TimeOfDay(hour: 14, minute: 15),
              Colors.blue,
            ),
            buildTimeDisplay(
              'Evening Workout',
              TimeOfDay(hour: 18, minute: 45),
              Colors.deepPurple,
            ),
            buildTimeDisplay(
              'Bedtime',
              TimeOfDay(hour: 22, minute: 30),
              Colors.blueGrey,
            ),

            buildSectionHeader('3. Time Formatting (12/24 Hour)'),
            buildFormatComparisonCard(
              TimeOfDay(hour: 0, minute: 0),
              'Midnight',
            ),
            buildFormatComparisonCard(
              TimeOfDay(hour: 6, minute: 30),
              'Early Morning',
            ),
            buildFormatComparisonCard(
              TimeOfDay(hour: 12, minute: 0),
              'Noon',
            ),
            buildFormatComparisonCard(
              TimeOfDay(hour: 15, minute: 45),
              'Afternoon',
            ),
            buildFormatComparisonCard(
              TimeOfDay(hour: 23, minute: 59),
              'Late Night',
            ),

            buildSectionHeader('4. Period Offset Values'),
            buildPeriodOffsetDisplay(),
            SizedBox(height: 12),
            buildInfoCard(
              'AM Period',
              'periodOffset = 0, hours 0-11',
            ),
            buildInfoCard(
              'PM Period',
              'periodOffset = 12, hours 12-23',
            ),

            buildSectionHeader('5. Hour/Minute Ranges'),
            Text(
              'All 24 Hours',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 8),
            buildHourGrid(),
            SizedBox(height: 16),
            Text(
              'Sample Minute Values',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 8),
            buildMinuteRangeDisplay(),

            buildSectionHeader('6. MaterialLocalizations.formatTimeOfDay'),
            buildLocalizationDemo(context),

            buildSectionHeader('7. Time Comparison Scenarios'),
            buildTimeComparisonScenarios(),

            buildSectionHeader('8. Default Values'),
            buildDefaultValuesSection(),

            buildSectionHeader('9. Restoration Properties'),
            buildRestorablePropertyInfo(),

            buildSectionHeader('10. Time Range Visualization'),
            buildTimeRangeVisualization(),

            buildSectionHeader('11. Time Picker Integration'),
            buildTimePickerIntegration(),

            buildSectionHeader('12. Time Arithmetic'),
            buildTimeArithmeticSection(),

            buildSectionHeader('13. Special Times of Day'),
            buildSpecialTimesSection(),

            buildSectionHeader('14. Additional Info'),
            buildInfoCard(
              'toMinutes',
              'Convert to total minutes: hour * 60 + minute',
            ),
            buildInfoCard(
              'hourOfPeriod',
              'Hour in 12-hour format (0-11)',
            ),
            buildInfoCard(
              'period',
              'DayPeriod.am or DayPeriod.pm',
            ),
            buildInfoCard(
              'replacing',
              'Use replacing() to create modified copies',
            ),
            buildInfoCard(
              'format',
              'Use MaterialLocalizations for locale-aware formatting',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RestorableTimeOfDay deep demo completed');
  return result;
}
