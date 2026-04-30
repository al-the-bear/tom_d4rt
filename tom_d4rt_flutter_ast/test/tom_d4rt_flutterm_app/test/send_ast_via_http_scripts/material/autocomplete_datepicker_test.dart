// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Autocomplete with date picker concept from material
// Demonstrates combined autocomplete and date picking visual patterns
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.green.shade700,
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

// Helper to build a date display chip
Widget buildDateChip(String dateStr, Color color, {bool isSelected = false}) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: isSelected ? color : color.withAlpha(20),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color),
    ),
    child: Text(
      dateStr,
      style: TextStyle(
        fontSize: 13,
        color: isSelected ? Colors.white : color,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// Helper to build a suggestion item row
Widget buildSuggestionItem(
  String title,
  String subtitle,
  IconData icon,
  Color color, {
  bool isHighlighted = false,
  String? trailing,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: isHighlighted ? color.withAlpha(15) : Colors.white,
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
            ],
          ),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
      ],
    ),
  );
}

// Helper to build a text field with autocomplete dropdown
Widget buildAutocompleteField(
  String label,
  String hintText,
  String typedText,
  List<Widget> suggestions,
  Color accentColor, {
  bool showDropdown = true,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: showDropdown ? accentColor : Colors.grey.shade300,
              width: showDropdown ? 2 : 1,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(showDropdown ? 0 : 8),
              bottomRight: Radius.circular(showDropdown ? 0 : 8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Text(
                    typedText.isEmpty ? hintText : typedText,
                    style: TextStyle(
                      fontSize: 16,
                      color: typedText.isEmpty
                          ? Colors.grey.shade400
                          : Colors.black87,
                    ),
                  ),
                ),
              ),
              if (typedText.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.clear,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  showDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        if (showDropdown && suggestions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: accentColor, width: 2),
                right: BorderSide(color: accentColor, width: 2),
                bottom: BorderSide(color: accentColor, width: 2),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(children: suggestions),
          ),
      ],
    ),
  );
}

// Helper to build a mini calendar month
Widget buildMiniCalendar(
  String monthName,
  int year,
  int startDayOfWeek,
  int daysInMonth,
  int selectedDay,
  Color color,
) {
  List<String> dayHeaders = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  List<Widget> dayWidgets = [];

  // Day headers
  for (int i = 0; i < 7; i++) {
    dayWidgets.add(
      SizedBox(
        width: 32,
        height: 24,
        child: Center(
          child: Text(
            dayHeaders[i],
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Empty cells before first day
  for (int i = 0; i < startDayOfWeek; i++) {
    dayWidgets.add(SizedBox(width: 32, height: 32));
  }

  // Day cells
  for (int day = 1; day <= daysInMonth; day++) {
    bool isToday = day == selectedDay;
    dayWidgets.add(
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isToday ? color : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$day',
            style: TextStyle(
              fontSize: 12,
              color: isToday ? Colors.white : Colors.grey.shade800,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.chevron_left, color: Colors.grey.shade600),
            Text(
              '$monthName $year',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade600),
          ],
        ),
        SizedBox(height: 8),
        Wrap(children: dayWidgets),
      ],
    ),
  );
}

// Helper to build a date range selector visual
Widget buildDateRangeSelector(
  String startDate,
  String endDate,
  Color color, {
  String? label,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(10),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          SizedBox(height: 8),
        ],
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: color),
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: color),
                    SizedBox(width: 8),
                    Text(startDate, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.arrow_forward, color: color, size: 20),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: color),
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: color),
                    SizedBox(width: 8),
                    Text(endDate, style: TextStyle(fontSize: 14)),
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

// Helper to build a formatted date display
Widget buildFormattedDateDisplay(String format, String result, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            format,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Icon(Icons.arrow_right, color: Colors.grey.shade400, size: 20),
        SizedBox(width: 8),
        Text(
          result,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Helper for search-with-suggestions field
Widget buildSearchSuggestionField(
  String query,
  List<Map<String, String>> suggestions,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: Border.all(color: color),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: color, size: 22),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  query,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              Icon(Icons.clear, color: Colors.grey.shade400, size: 20),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: suggestions.map((s) {
              return buildSuggestionItem(
                s['title'] ?? '',
                s['subtitle'] ?? '',
                Icons.event,
                color,
                trailing: s['date'],
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

// Helper to build time slot picker
Widget buildTimeSlotPicker(
  String date,
  List<String> slots,
  Color color,
  int selectedIndex,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: color, size: 18),
            SizedBox(width: 8),
            Text(
              date,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: List.generate(slots.length, (i) {
            bool selected = i == selectedIndex;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? color : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? color : Colors.grey.shade300,
                ),
              ),
              child: Text(
                slots[i],
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? Colors.white : Colors.grey.shade700,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== Autocomplete Datepicker Test Script ===');
  debugPrint('Testing autocomplete-like patterns with date picking visuals');
  debugPrint('Demonstrates text fields with suggestions and date displays');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.teal.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Autocomplete + DatePicker',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Combined autocomplete and date selection patterns',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Date Autocomplete
        buildSectionHeader('1. Date Autocomplete Field'),
        buildAutocompleteField(
          'Select Date',
          'Type a date or month name...',
          'Jan',
          [
            buildSuggestionItem(
              'January 2024',
              '31 days',
              Icons.calendar_month,
              Colors.green.shade700,
              isHighlighted: true,
            ),
            buildSuggestionItem(
              'January 2025',
              '31 days',
              Icons.calendar_month,
              Colors.green.shade700,
            ),
            buildSuggestionItem(
              'June 2024',
              '30 days',
              Icons.calendar_month,
              Colors.green.shade700,
            ),
          ],
          Colors.green.shade700,
        ),

        // Section 2: Event Autocomplete
        buildSectionHeader('2. Event Search with Date Suggestions'),
        buildSearchSuggestionField('Team meet', [
          {
            'title': 'Team Meeting - Sprint Planning',
            'subtitle': 'Recurring weekly',
            'date': 'Mon 10:00',
          },
          {
            'title': 'Team Meeting - Retro',
            'subtitle': 'Recurring bi-weekly',
            'date': 'Fri 14:00',
          },
          {
            'title': 'Team Meetup - Social',
            'subtitle': 'Monthly social event',
            'date': 'Mar 15',
          },
        ], Colors.blue.shade700),

        // Section 3: Calendar Display
        buildSectionHeader('3. Mini Calendar Views'),
        buildMiniCalendar('January', 2025, 2, 31, 15, Colors.blue.shade700),
        buildMiniCalendar('February', 2025, 5, 28, 22, Colors.green.shade700),

        // Section 4: Date Chips
        buildSectionHeader('4. Quick Date Selection Chips'),
        Wrap(
          children: [
            buildDateChip('Today', Colors.green.shade700, isSelected: true),
            buildDateChip('Tomorrow', Colors.green.shade700),
            buildDateChip('This Week', Colors.blue.shade700),
            buildDateChip('Next Week', Colors.blue.shade700),
            buildDateChip('This Month', Colors.purple.shade700),
            buildDateChip('Custom...', Colors.grey.shade700),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          children: [
            buildDateChip('Mon Jan 13', Colors.teal.shade700),
            buildDateChip('Tue Jan 14', Colors.teal.shade700, isSelected: true),
            buildDateChip('Wed Jan 15', Colors.teal.shade700),
            buildDateChip('Thu Jan 16', Colors.teal.shade700),
            buildDateChip('Fri Jan 17', Colors.teal.shade700),
          ],
        ),

        // Section 5: Date Range Selection
        buildSectionHeader('5. Date Range Selectors'),
        buildDateRangeSelector(
          'Jan 10, 2025',
          'Jan 20, 2025',
          Colors.blue.shade700,
          label: 'Sprint Duration',
        ),
        buildDateRangeSelector(
          'Feb 01, 2025',
          'Feb 28, 2025',
          Colors.green.shade700,
          label: 'Report Period',
        ),
        buildDateRangeSelector(
          'Mar 15, 2025',
          'Mar 22, 2025',
          Colors.orange.shade700,
          label: 'Vacation',
        ),

        // Section 6: Date Format Display
        buildSectionHeader('6. Date Format Variations'),
        Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'For January 15, 2025:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                buildFormattedDateDisplay(
                  'yyyy-MM-dd',
                  '2025-01-15',
                  Colors.blue.shade700,
                ),
                buildFormattedDateDisplay(
                  'MM/dd/yyyy',
                  '01/15/2025',
                  Colors.blue.shade700,
                ),
                buildFormattedDateDisplay(
                  'dd.MM.yyyy',
                  '15.01.2025',
                  Colors.blue.shade700,
                ),
                buildFormattedDateDisplay(
                  'MMMM d, yyyy',
                  'January 15, 2025',
                  Colors.blue.shade700,
                ),
                buildFormattedDateDisplay(
                  'd MMM yyyy',
                  '15 Jan 2025',
                  Colors.blue.shade700,
                ),
                buildFormattedDateDisplay(
                  'EEE, MMM d',
                  'Wed, Jan 15',
                  Colors.blue.shade700,
                ),
                buildFormattedDateDisplay(
                  'EEEE',
                  'Wednesday',
                  Colors.blue.shade700,
                ),
                buildFormattedDateDisplay(
                  'Relative',
                  '2 days ago',
                  Colors.green.shade700,
                ),
              ],
            ),
          ),
        ),

        // Section 7: Time Slot Picker
        buildSectionHeader('7. Time Slot Selection'),
        buildTimeSlotPicker(
          'Wednesday, Jan 15',
          [
            '09:00',
            '09:30',
            '10:00',
            '10:30',
            '11:00',
            '11:30',
            '14:00',
            '14:30',
            '15:00',
            '15:30',
            '16:00',
          ],
          Colors.green.shade700,
          4,
        ),
        buildTimeSlotPicker(
          'Thursday, Jan 16',
          ['09:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00'],
          Colors.blue.shade700,
          2,
        ),

        // Section 8: Location Autocomplete with Date
        buildSectionHeader('8. Location + Date Autocomplete'),
        buildAutocompleteField(
          'Meeting Location',
          'Search for a room...',
          'Conf',
          [
            buildSuggestionItem(
              'Conference Room A',
              'Floor 2 - Seats 10',
              Icons.meeting_room,
              Colors.teal.shade700,
              isHighlighted: true,
              trailing: 'Available',
            ),
            buildSuggestionItem(
              'Conference Room B',
              'Floor 3 - Seats 6',
              Icons.meeting_room,
              Colors.teal.shade700,
              trailing: 'Busy until 11:00',
            ),
            buildSuggestionItem(
              'Conference Hall',
              'Floor 1 - Seats 50',
              Icons.meeting_room,
              Colors.teal.shade700,
              trailing: 'Available',
            ),
          ],
          Colors.teal.shade700,
        ),
        SizedBox(height: 8),
        buildAutocompleteField('Attendees', 'Type a name...', 'Al', [
          buildSuggestionItem(
            'Alice Johnson',
            'alice@example.com',
            Icons.person,
            Colors.purple.shade700,
            isHighlighted: true,
          ),
          buildSuggestionItem(
            'Alex Smith',
            'alex@example.com',
            Icons.person,
            Colors.purple.shade700,
          ),
          buildSuggestionItem(
            'Albert Brown',
            'albert@example.com',
            Icons.person,
            Colors.purple.shade700,
          ),
        ], Colors.purple.shade700),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of Autocomplete Datepicker Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
