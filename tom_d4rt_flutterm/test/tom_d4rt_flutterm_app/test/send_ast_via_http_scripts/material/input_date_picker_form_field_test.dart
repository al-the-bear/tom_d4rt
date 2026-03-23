// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InputDatePickerFormField from material
import 'package:flutter/material.dart';

// ============================================================
// Helper Functions
// ============================================================

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

Widget _buildSubSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xFF1E88E5),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildInfoCard(String title, String description) {
  print('Info card: $title');
  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPropertyRow(String property, String type, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            property,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFF0D47A1),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              color: Colors.purple[700],
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[800]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLabeledDatePicker(
  String label,
  String description,
  Widget picker,
) {
  return Card(
    elevation: 1,
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          picker,
        ],
      ),
    ),
  );
}

Widget _buildNoteBox(String text) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      border: Border.all(color: Color(0xFFFFB300)),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 18, color: Color(0xFFF57F17)),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Color(0xFF5D4037)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDateRangeIndicator(
  String label,
  String firstDate,
  String lastDate,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Icon(Icons.date_range, size: 20, color: color),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: color,
              ),
            ),
            Text(
              'From: $firstDate  To: $lastDate',
              style: TextStyle(fontSize: 11, color: Colors.grey[700]),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDividerLine() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Divider(color: Colors.grey[300], thickness: 1),
  );
}

Widget buildStatusBadge(String text, Color bgColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text, style: TextStyle(color: Colors.white, fontSize: 11)),
  );
}

Widget _buildDebugLine(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  > ',
          style: TextStyle(
            fontSize: 12,
            color: Colors.green[700],
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[900],
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPrintDebugSection(
  DateTime now,
  DateTime yearStart,
  DateTime yearEnd,
  DateTime monthStart,
  DateTime monthEnd,
) {
  print('--- Debug Output Summary ---');
  print('Current reference date: $now');
  print('Year range: $yearStart to $yearEnd');
  print('Month range: $monthStart to $monthEnd');
  print('InputDatePickerFormField requires firstDate and lastDate');
  print('initialDate is optional, field starts empty if not provided');
  print('errorFormatText: shown when text cannot be parsed as a date');
  print('errorInvalidText: shown when date is outside firstDate..lastDate');
  print('fieldLabelText: custom label on the input field');
  print('fieldHintText: custom hint/placeholder text');
  print('autofocus: requests focus on build when true');
  print('acceptEmptyDate: allows empty value to pass validation');
  print('keyboardType: controls mobile keyboard layout');
  print('onDateSubmitted: fires on keyboard submit with valid date');
  print('onDateSaved: fires on Form.save() with valid date');
  print('selectableDayPredicate: filters selectable days');
  print('--- End Debug Summary ---');

  return Card(
    elevation: 1,
    color: Color(0xFFF5F5F5),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bug_report, size: 18, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text(
                'Console Debug Output',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          _buildDebugLine('Current ref date', '$now'),
          _buildDebugLine('Year range', '$yearStart to $yearEnd'),
          _buildDebugLine('Month range', '$monthStart to $monthEnd'),
          _buildDebugLine('Required props', 'firstDate, lastDate'),
          _buildDebugLine('Optional initial', 'initialDate'),
          _buildDebugLine('Error custom', 'errorFormatText, errorInvalidText'),
          _buildDebugLine('Label custom', 'fieldLabelText, fieldHintText'),
          _buildDebugLine('Focus control', 'autofocus (default: false)'),
          _buildDebugLine('Empty handling', 'acceptEmptyDate (default: false)'),
          _buildDebugLine('Keyboard', 'keyboardType (default: datetime)'),
          _buildDebugLine('Callbacks', 'onDateSubmitted, onDateSaved'),
          _buildDebugLine('Day filter', 'selectableDayPredicate'),
        ],
      ),
    ),
  );
}

// ============================================================
// build() function
// ============================================================

dynamic build(BuildContext context) {
  print('=== InputDatePickerFormField Visual Demo ===');
  print('Demonstrating date picker text input form fields');
  print('Widget: InputDatePickerFormField from Material library');

  // Date references used throughout the demo
  DateTime now = DateTime(2026, 3, 21);
  DateTime yearStart = DateTime(2026, 1, 1);
  DateTime yearEnd = DateTime(2026, 12, 31);
  DateTime decadeStart = DateTime(2020, 1, 1);
  DateTime decadeEnd = DateTime(2030, 12, 31);
  DateTime monthStart = DateTime(2026, 3, 1);
  DateTime monthEnd = DateTime(2026, 3, 31);
  DateTime halfYearStart = DateTime(2026, 1, 1);
  DateTime halfYearEnd = DateTime(2026, 6, 30);
  DateTime q1Start = DateTime(2026, 1, 1);
  DateTime q1End = DateTime(2026, 3, 31);
  DateTime q2Start = DateTime(2026, 4, 1);
  DateTime q2End = DateTime(2026, 6, 30);
  DateTime christmasDay = DateTime(2026, 12, 25);
  DateTime newYearsDay = DateTime(2026, 1, 1);
  DateTime valentinesDay = DateTime(2026, 2, 14);
  DateTime independenceDay = DateTime(2026, 7, 4);
  DateTime summerStart = DateTime(2026, 6, 21);
  DateTime summerEnd = DateTime(2026, 9, 22);

  print('Date references created');
  print('Now: $now');
  print('Year range: $yearStart - $yearEnd');

  // Form key for the Form widget context section
  GlobalKey formKeyA = GlobalKey();
  GlobalKey formKeyB = GlobalKey();

  print('Form keys created');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Color(0xFF1565C0), useMaterial3: true),
    home: Scaffold(
      appBar: AppBar(
        title: Text('InputDatePickerFormField Demo'),
        backgroundColor: Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================
            // Section 1: Introduction
            // ========================================
            _buildSectionHeader('1. Introduction'),
            SizedBox(height: 8),
            _buildInfoCard(
              'InputDatePickerFormField',
              'A text form field for entering a date manually via text input. '
                  'It validates the date against firstDate and lastDate, and supports '
                  'custom formatting hints, error messages, and form integration.',
            ),
            _buildInfoCard(
              'When to Use',
              'Use this when users need to type a date rather than picking from '
                  'a calendar. Ideal for forms where keyboard input is preferred or '
                  'when the date is known exactly by the user.',
            ),
            _buildNoteBox(
              'InputDatePickerFormField is part of the Material date picker '
              'system. It can be used standalone or within showDatePicker dialogs.',
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 2: Basic Default Configuration
            // ========================================
            _buildSectionHeader('2. Basic Default Configuration'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Minimal Setup',
              'At minimum, InputDatePickerFormField requires firstDate and '
                  'lastDate to define the valid date range.',
            ),
            _buildLabeledDatePicker(
              'Default Date Picker Field',
              'Uses current year range with no initial date',
              InputDatePickerFormField(firstDate: yearStart, lastDate: yearEnd),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'With Initial Date Set',
              'Pre-filled with March 21, 2026',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: yearStart,
                lastDate: yearEnd,
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Wide Date Range',
              'Allows dates from 2020 to 2030',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: decadeStart,
                lastDate: decadeEnd,
              ),
            ),
            _buildNoteBox(
              'The initial date must fall between firstDate and lastDate '
              'inclusive. If not provided, the field starts empty.',
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 3: Custom Date Ranges
            // ========================================
            _buildSectionHeader('3. Custom Date Range Configurations'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Date Range Control',
              'firstDate and lastDate define the valid date window. '
                  'Any entered date outside this range triggers a validation error.',
            ),
            _buildDateRangeIndicator(
              'Current Month Only',
              'Mar 1, 2026',
              'Mar 31, 2026',
              Colors.blue,
            ),
            _buildLabeledDatePicker(
              'Month-Restricted Field',
              'Only accepts dates in March 2026',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: monthStart,
                lastDate: monthEnd,
              ),
            ),
            SizedBox(height: 8),
            _buildDateRangeIndicator(
              'First Half of Year',
              'Jan 1, 2026',
              'Jun 30, 2026',
              Colors.green,
            ),
            _buildLabeledDatePicker(
              'Half-Year Field',
              'Accepts dates from January to June 2026',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: halfYearStart,
                lastDate: halfYearEnd,
              ),
            ),
            SizedBox(height: 8),
            _buildDateRangeIndicator(
              'Q1 Only',
              'Jan 1, 2026',
              'Mar 31, 2026',
              Colors.orange,
            ),
            _buildLabeledDatePicker(
              'Quarter 1 Field',
              'Restricted to Q1 2026',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: q1Start,
                lastDate: q1End,
              ),
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 4: Multiple Fields with Different Dates
            // ========================================
            _buildSectionHeader(
              '4. Multiple Fields with Different Initial Dates',
            ),
            SizedBox(height: 8),
            _buildInfoCard(
              'Side by Side Comparison',
              'Multiple InputDatePickerFormField widgets each initialized '
                  'with a different date to demonstrate independent state.',
            ),
            _buildLabeledDatePicker(
              'New Years Day',
              'Initial date: January 1, 2026',
              InputDatePickerFormField(
                initialDate: newYearsDay,
                firstDate: yearStart,
                lastDate: yearEnd,
              ),
            ),
            _buildLabeledDatePicker(
              'Valentines Day',
              'Initial date: February 14, 2026',
              InputDatePickerFormField(
                initialDate: valentinesDay,
                firstDate: yearStart,
                lastDate: yearEnd,
              ),
            ),
            _buildLabeledDatePicker(
              'Today (March 21)',
              'Initial date: March 21, 2026',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: yearStart,
                lastDate: yearEnd,
              ),
            ),
            _buildLabeledDatePicker(
              'Independence Day',
              'Initial date: July 4, 2026',
              InputDatePickerFormField(
                initialDate: independenceDay,
                firstDate: yearStart,
                lastDate: yearEnd,
              ),
            ),
            _buildLabeledDatePicker(
              'Christmas Day',
              'Initial date: December 25, 2026',
              InputDatePickerFormField(
                initialDate: christmasDay,
                firstDate: yearStart,
                lastDate: yearEnd,
              ),
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 5: Custom Label and Hint Text
            // ========================================
            _buildSectionHeader('5. Custom Label and Hint Text'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Field Customization',
              'fieldLabelText and fieldHintText allow custom labels and '
                  'placeholder text for the date input field.',
            ),
            _buildLabeledDatePicker(
              'Default Label/Hint',
              'No custom label or hint text specified',
              InputDatePickerFormField(firstDate: yearStart, lastDate: yearEnd),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Custom Birth Date Label',
              'Custom label for date of birth',
              InputDatePickerFormField(
                firstDate: DateTime(1920, 1, 1),
                lastDate: now,
                fieldLabelText: 'Date of Birth',
                fieldHintText: 'Enter your birth date',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Event Date Label',
              'Custom label for event scheduling',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: yearStart,
                lastDate: yearEnd,
                fieldLabelText: 'Event Date',
                fieldHintText: 'Pick an event date',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Appointment Date Label',
              'Custom label for appointment booking',
              InputDatePickerFormField(
                firstDate: now,
                lastDate: yearEnd,
                fieldLabelText: 'Appointment Date',
                fieldHintText: 'Select your appointment',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Travel Departure Label',
              'Custom label for travel planning',
              InputDatePickerFormField(
                initialDate: summerStart,
                firstDate: yearStart,
                lastDate: yearEnd,
                fieldLabelText: 'Departure Date',
                fieldHintText: 'When do you depart?',
              ),
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 6: Custom Error Messages
            // ========================================
            _buildSectionHeader('6. Custom Error Messages'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Error Message Customization',
              'errorFormatText specifies the message shown when the date '
                  'format is wrong. errorInvalidText is shown when the date '
                  'is outside the valid range.',
            ),
            _buildLabeledDatePicker(
              'Custom Format Error',
              'Shows custom message for date format errors',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                errorFormatText: 'Please use MM/DD/YYYY format',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Custom Invalid Date Error',
              'Shows custom message when date is out of range',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                errorInvalidText: 'Date must be within the year 2026',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Both Custom Errors',
              'Custom messages for both format and range errors',
              InputDatePickerFormField(
                firstDate: monthStart,
                lastDate: monthEnd,
                errorFormatText: 'Invalid date format entered',
                errorInvalidText: 'Only March 2026 dates are allowed',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Booking System Errors',
              'Errors tailored to a booking system context',
              InputDatePickerFormField(
                firstDate: now,
                lastDate: decadeEnd,
                errorFormatText: 'Please enter a valid booking date',
                errorInvalidText: 'Booking date must be in the future',
                fieldLabelText: 'Booking Date',
                fieldHintText: 'Enter reservation date',
              ),
            ),
            _buildNoteBox(
              'Custom error messages help guide users to enter valid dates. '
              'errorFormatText fires when text cannot be parsed, '
              'errorInvalidText fires when the date is outside the range.',
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 7: Form Widget Context
            // ========================================
            _buildSectionHeader('7. Fields in a Form Widget Context'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Form Integration',
              'InputDatePickerFormField works with Form widgets. '
                  'onDateSaved is called when Form.save() is invoked, and '
                  'the field participates in form validation.',
            ),
            _buildSubSectionHeader('Form A: Event Registration'),
            SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: formKeyA,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event Registration Form',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Start Date',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4),
                      InputDatePickerFormField(
                        initialDate: now,
                        firstDate: yearStart,
                        lastDate: yearEnd,
                        fieldLabelText: 'Event Start',
                        fieldHintText: 'Enter start date',
                        onDateSubmitted: (date) {
                          print('Event start submitted: $date');
                        },
                        onDateSaved: (date) {
                          print('Event start saved: $date');
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'End Date',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4),
                      InputDatePickerFormField(
                        firstDate: yearStart,
                        lastDate: yearEnd,
                        fieldLabelText: 'Event End',
                        fieldHintText: 'Enter end date',
                        onDateSubmitted: (date) {
                          print('Event end submitted: $date');
                        },
                        onDateSaved: (date) {
                          print('Event end saved: $date');
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Registration Deadline',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4),
                      InputDatePickerFormField(
                        firstDate: yearStart,
                        lastDate: yearEnd,
                        fieldLabelText: 'Deadline',
                        fieldHintText: 'Enter deadline date',
                        errorInvalidText: 'Deadline must be in 2026',
                        onDateSubmitted: (date) {
                          print('Deadline submitted: $date');
                        },
                        onDateSaved: (date) {
                          print('Deadline saved: $date');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildSubSectionHeader('Form B: Travel Booking'),
            SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: formKeyB,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Travel Booking Form',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF00695C),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Departure',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4),
                      InputDatePickerFormField(
                        initialDate: summerStart,
                        firstDate: now,
                        lastDate: decadeEnd,
                        fieldLabelText: 'Departure Date',
                        fieldHintText: 'When do you leave?',
                        errorFormatText: 'Enter a valid departure date',
                        errorInvalidText: 'Departure must be today or later',
                        onDateSubmitted: (date) {
                          print('Departure submitted: $date');
                        },
                        onDateSaved: (date) {
                          print('Departure saved: $date');
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Return',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4),
                      InputDatePickerFormField(
                        initialDate: summerEnd,
                        firstDate: now,
                        lastDate: decadeEnd,
                        fieldLabelText: 'Return Date',
                        fieldHintText: 'When do you return?',
                        errorFormatText: 'Enter a valid return date',
                        errorInvalidText: 'Return must be today or later',
                        onDateSubmitted: (date) {
                          print('Return submitted: $date');
                        },
                        onDateSaved: (date) {
                          print('Return saved: $date');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 8: Date Range Comparisons
            // ========================================
            _buildSectionHeader('8. Date Range Configuration Comparison'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Range Comparison',
              'Different firstDate/lastDate configurations side by side '
                  'to illustrate how date restrictions affect user input.',
            ),
            _buildDateRangeIndicator(
              'Full Decade',
              '2020-01-01',
              '2030-12-31',
              Colors.purple,
            ),
            _buildLabeledDatePicker(
              'Decade Range',
              '10-year window for selecting dates',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: decadeStart,
                lastDate: decadeEnd,
                fieldLabelText: 'Any date 2020-2030',
              ),
            ),
            SizedBox(height: 8),
            _buildDateRangeIndicator(
              'Current Year',
              '2026-01-01',
              '2026-12-31',
              Colors.teal,
            ),
            _buildLabeledDatePicker(
              'Single Year Range',
              'Restricted to calendar year 2026',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: yearStart,
                lastDate: yearEnd,
                fieldLabelText: 'Any date in 2026',
              ),
            ),
            SizedBox(height: 8),
            _buildDateRangeIndicator(
              'Q2 Only',
              '2026-04-01',
              '2026-06-30',
              Colors.deepOrange,
            ),
            _buildLabeledDatePicker(
              'Quarter 2 Range',
              'Only April through June 2026',
              InputDatePickerFormField(
                initialDate: q2Start,
                firstDate: q2Start,
                lastDate: q2End,
                fieldLabelText: 'Q2 2026 date',
              ),
            ),
            SizedBox(height: 8),
            _buildDateRangeIndicator(
              'Summer',
              '2026-06-21',
              '2026-09-22',
              Colors.amber,
            ),
            _buildLabeledDatePicker(
              'Summer Range',
              'Summer 2026 only',
              InputDatePickerFormField(
                initialDate: summerStart,
                firstDate: summerStart,
                lastDate: summerEnd,
                fieldLabelText: 'Summer 2026 date',
              ),
            ),
            SizedBox(height: 8),
            _buildDateRangeIndicator(
              'Single Month',
              '2026-03-01',
              '2026-03-31',
              Colors.indigo,
            ),
            _buildLabeledDatePicker(
              'March Only',
              'Limited to March 2026',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: monthStart,
                lastDate: monthEnd,
                fieldLabelText: 'March 2026 date',
              ),
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 9: Autofocus
            // ========================================
            _buildSectionHeader('9. Autofocus Configuration'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Autofocus Property',
              'When autofocus is true, the field requests focus when first built. '
                  'Useful when the date field is the primary input on a page.',
            ),
            _buildLabeledDatePicker(
              'Autofocus Disabled (default)',
              'autofocus: false - field does not auto-request focus',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                autofocus: false,
                fieldLabelText: 'No Autofocus',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Autofocus Enabled',
              'autofocus: true - field auto-requests focus on build',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                autofocus: true,
                fieldLabelText: 'With Autofocus',
              ),
            ),
            _buildNoteBox(
              'Only one field should have autofocus: true in a given page. '
              'Having multiple autofocus fields leads to unpredictable behavior.',
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 10: Property Reference
            // ========================================
            _buildSectionHeader('10. Property Reference'),
            SizedBox(height: 8),
            _buildInfoCard(
              'All Properties',
              'Complete list of InputDatePickerFormField properties, types, '
                  'and descriptions.',
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              'Property',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              'Type',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Description',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDividerLine(),
                    _buildPropertyRow(
                      'initialDate',
                      'DateTime?',
                      'The initially selected date. Must be between firstDate and lastDate.',
                    ),
                    _buildPropertyRow(
                      'firstDate',
                      'DateTime',
                      'The earliest allowable date. Required parameter.',
                    ),
                    _buildPropertyRow(
                      'lastDate',
                      'DateTime',
                      'The latest allowable date. Required parameter.',
                    ),
                    _buildPropertyRow(
                      'onDateSubmitted',
                      'ValueChanged?',
                      'Called when the user submits a valid date via the keyboard.',
                    ),
                    _buildPropertyRow(
                      'onDateSaved',
                      'ValueChanged?',
                      'Called when the enclosing Form is saved.',
                    ),
                    _buildDividerLine(),
                    _buildPropertyRow(
                      'selectableDayPredicate',
                      'Function?',
                      'A function that returns false for days that should not be selectable.',
                    ),
                    _buildPropertyRow(
                      'errorFormatText',
                      'String?',
                      'Custom error message when date text cannot be parsed.',
                    ),
                    _buildPropertyRow(
                      'errorInvalidText',
                      'String?',
                      'Custom error message when date is outside valid range.',
                    ),
                    _buildDividerLine(),
                    _buildPropertyRow(
                      'fieldHintText',
                      'String?',
                      'Custom hint text for the text field.',
                    ),
                    _buildPropertyRow(
                      'fieldLabelText',
                      'String?',
                      'Custom label text for the text field.',
                    ),
                    _buildPropertyRow(
                      'keyboardType',
                      'TextInputType?',
                      'The keyboard type to use for the text field.',
                    ),
                    _buildDividerLine(),
                    _buildPropertyRow(
                      'autofocus',
                      'bool',
                      'Whether the field should automatically request focus. Defaults to false.',
                    ),
                    _buildPropertyRow(
                      'acceptEmptyDate',
                      'bool',
                      'Whether an empty date is considered valid. Defaults to false.',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // ========================================
            // Section 11: Debug Output Summary
            // ========================================
            _buildSectionHeader('11. Debug Output Summary'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Debug Information',
              'The following section displays all debug print output '
                  'generated during widget construction.',
            ),
            _buildPrintDebugSection(
              now,
              yearStart,
              yearEnd,
              monthStart,
              monthEnd,
            ),
            SizedBox(height: 24),

            // ========================================
            // Additional: Keyboard Type Variations
            // ========================================
            _buildSectionHeader('12. Keyboard Type Variations'),
            SizedBox(height: 8),
            _buildInfoCard(
              'keyboardType Property',
              'Controls the keyboard layout shown on mobile devices. '
                  'Defaults to TextInputType.datetime.',
            ),
            _buildLabeledDatePicker(
              'Default Keyboard (datetime)',
              'Uses TextInputType.datetime (default)',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                fieldLabelText: 'Default keyboard',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Number Keyboard',
              'Uses TextInputType.number',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                keyboardType: TextInputType.number,
                fieldLabelText: 'Number keyboard',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Text Keyboard',
              'Uses TextInputType.text',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                keyboardType: TextInputType.text,
                fieldLabelText: 'Text keyboard',
              ),
            ),
            SizedBox(height: 24),

            // ========================================
            // Additional: acceptEmptyDate
            // ========================================
            _buildSectionHeader('13. Accept Empty Date'),
            SizedBox(height: 8),
            _buildInfoCard(
              'acceptEmptyDate Property',
              'When true, an empty field value is considered valid and will not '
                  'trigger a validation error. Useful for optional date fields.',
            ),
            _buildLabeledDatePicker(
              'Required Date (default)',
              'acceptEmptyDate: false - empty value triggers error',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                acceptEmptyDate: false,
                fieldLabelText: 'Required Date',
                errorFormatText: 'Date is required',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Optional Date',
              'acceptEmptyDate: true - empty value is accepted',
              InputDatePickerFormField(
                firstDate: yearStart,
                lastDate: yearEnd,
                acceptEmptyDate: true,
                fieldLabelText: 'Optional Date',
              ),
            ),
            _buildNoteBox(
              'acceptEmptyDate is useful for forms where a date field is '
              'not mandatory. When true, the field validates successfully '
              'even without user input.',
            ),
            SizedBox(height: 24),

            // ========================================
            // Additional: Callback Demonstrations
            // ========================================
            _buildSectionHeader('14. Callback Demonstrations'),
            SizedBox(height: 8),
            _buildInfoCard(
              'onDateSubmitted and onDateSaved',
              'onDateSubmitted is called when the user presses enter with a valid date. '
                  'onDateSaved is called when the enclosing Form calls save().',
            ),
            _buildLabeledDatePicker(
              'Submit Callback',
              'Prints to console when a date is submitted',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: yearStart,
                lastDate: yearEnd,
                fieldLabelText: 'Submit to test',
                onDateSubmitted: (date) {
                  print('Date submitted callback fired: $date');
                },
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Save Callback',
              'Prints to console when form is saved',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: yearStart,
                lastDate: yearEnd,
                fieldLabelText: 'Save to test',
                onDateSaved: (date) {
                  print('Date saved callback fired: $date');
                },
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Both Callbacks',
              'Both onDateSubmitted and onDateSaved configured',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: yearStart,
                lastDate: yearEnd,
                fieldLabelText: 'Full callback field',
                onDateSubmitted: (date) {
                  print('Submitted: $date');
                },
                onDateSaved: (date) {
                  print('Saved: $date');
                },
              ),
            ),
            SizedBox(height: 24),

            // ========================================
            // Additional: Combined Configurations
            // ========================================
            _buildSectionHeader('15. Combined Configurations'),
            SizedBox(height: 8),
            _buildInfoCard(
              'Real-World Scenarios',
              'Combining multiple properties to show practical use cases.',
            ),
            _buildLabeledDatePicker(
              'Employee Onboarding',
              'Start date field for new employee onboarding form',
              InputDatePickerFormField(
                initialDate: now,
                firstDate: now,
                lastDate: decadeEnd,
                fieldLabelText: 'Start Date',
                fieldHintText: 'Your first day at work',
                errorFormatText: 'Please enter a valid date',
                errorInvalidText: 'Start date cannot be in the past',
                onDateSubmitted: (date) {
                  print('Onboarding start date: $date');
                },
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Medical Appointment',
              'Appointment scheduling with future-only dates',
              InputDatePickerFormField(
                firstDate: now,
                lastDate: yearEnd,
                fieldLabelText: 'Appointment Date',
                fieldHintText: 'Select available date',
                errorFormatText: 'Invalid date format',
                errorInvalidText:
                    'Appointments must be this year and in the future',
                onDateSubmitted: (date) {
                  print('Appointment date selected: $date');
                },
                onDateSaved: (date) {
                  print('Appointment date saved: $date');
                },
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'Historical Record Entry',
              'Date entry for archival records spanning decades',
              InputDatePickerFormField(
                firstDate: DateTime(1900, 1, 1),
                lastDate: now,
                fieldLabelText: 'Record Date',
                fieldHintText: 'Date of the historical event',
                errorFormatText: 'Invalid date format for record',
                errorInvalidText: 'Date must be between 1900 and today',
              ),
            ),
            SizedBox(height: 8),
            _buildLabeledDatePicker(
              'School Enrollment',
              'Enrollment date for upcoming school year',
              InputDatePickerFormField(
                initialDate: DateTime(2026, 9, 1),
                firstDate: DateTime(2026, 8, 1),
                lastDate: DateTime(2026, 9, 30),
                fieldLabelText: 'Enrollment Date',
                fieldHintText: 'Aug-Sep 2026 only',
                errorFormatText: 'Not a valid date',
                errorInvalidText: 'Must be August or September 2026',
                onDateSubmitted: (date) {
                  print('Enrollment date: $date');
                },
              ),
            ),
            SizedBox(height: 32),

            // Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF1565C0)),
              ),
              child: Column(
                children: [
                  Text(
                    'InputDatePickerFormField Demo Complete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This demo covers basic usage, custom date ranges, labels, '
                    'hints, error messages, form integration, autofocus, keyboard '
                    'types, optional dates, callbacks, and combined configurations.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
