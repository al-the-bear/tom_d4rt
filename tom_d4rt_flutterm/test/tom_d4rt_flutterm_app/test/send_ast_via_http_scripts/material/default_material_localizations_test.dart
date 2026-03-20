// D4rt test script: Tests DefaultMaterialLocalizations from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF004D40),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper to build a demo card
Widget buildDemoCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// Helper: info row
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF616161)),
          ),
        ),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 13, color: Color(0xFF212121))),
        ),
      ],
    ),
  );
}

// Helper: localized string display
Widget buildLocalizedString(String getter, String value, Color accentColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(getter, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF424242))),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 12, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: format example
Widget buildFormatExample(String method, String params, String result) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(method, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
        SizedBox(height: 2),
        Text('Input: $params', style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
        Row(
          children: [
            Text('Output: ', style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFF004D40),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(result, style: TextStyle(fontSize: 11, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper: day name row
Widget buildDayNameRow(List<String> names, Color color) {
  return Row(
    children: names.map((name) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList(),
  );
}

// Helper: month name grid
Widget buildMonthGrid(List<String> months, Color color) {
  List<Widget> rows = [];
  for (int r = 0; r < 3; r++) {
    List<Widget> cells = [];
    for (int c = 0; c < 4; c++) {
      int idx = r * 4 + c;
      cells.add(
        Expanded(
          child: Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              idx < months.length ? months[idx] : '',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    rows.add(Row(children: cells));
  }
  return Column(children: rows);
}

// Helper: semantic label display
Widget buildSemanticLabel(String widget, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Icon(Icons.accessibility, size: 16, color: Color(0xFF004D40)),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF424242))),
              Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: script tag badge
Widget buildScriptBadge(String scriptName, Color color) {
  return Container(
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(scriptName, style: TextStyle(fontSize: 12, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600)),
  );
}

// Helper: tooltip string entry
Widget buildTooltipEntry(String key, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 14, color: Color(0xFF004D40)),
        SizedBox(width: 6),
        Expanded(child: Text(key, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
        Text(value, style: TextStyle(fontSize: 12, color: Color(0xFF004D40), fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== DefaultMaterialLocalizations Deep Demo ===');
  debugPrint('Testing localized strings, date/time formats, and accessibility labels');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DefaultMaterialLocalizations Demo'),
        backgroundColor: Color(0xFF004D40),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Overview
            buildSectionHeader('1. DefaultMaterialLocalizations Overview'),
            buildDemoCard(
              'US English implementation of MaterialLocalizations',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Class', 'DefaultMaterialLocalizations'),
                  buildInfoRow('Locale', 'US English (en_US)'),
                  buildInfoRow('Purpose', 'Provides localized strings for Material widgets'),
                  buildInfoRow('Extends', 'MaterialLocalizations'),
                  buildInfoRow('Usage', 'MaterialLocalizations.of(context)'),
                ],
              ),
            ),
            Text('Section 1: Overview displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 2: Button Labels
            buildSectionHeader('2. Button Labels'),
            buildDemoCard(
              'Standard button text strings',
              Column(
                children: [
                  buildLocalizedString('okButtonLabel', 'OK', Color(0xFF004D40)),
                  buildLocalizedString('cancelButtonLabel', 'Cancel', Color(0xFF004D40)),
                  buildLocalizedString('closeButtonLabel', 'Close', Color(0xFF004D40)),
                  buildLocalizedString('continueButtonLabel', 'Continue', Color(0xFF004D40)),
                  buildLocalizedString('copyButtonLabel', 'Copy', Color(0xFF00695C)),
                  buildLocalizedString('cutButtonLabel', 'Cut', Color(0xFF00695C)),
                  buildLocalizedString('pasteButtonLabel', 'Paste', Color(0xFF00695C)),
                  buildLocalizedString('selectAllButtonLabel', 'Select all', Color(0xFF00695C)),
                  buildLocalizedString('viewLicensesButtonLabel', 'View licenses', Color(0xFF00796B)),
                  buildLocalizedString('anteMeridiemAbbreviation', 'AM', Color(0xFF00796B)),
                  buildLocalizedString('postMeridiemAbbreviation', 'PM', Color(0xFF00796B)),
                ],
              ),
            ),
            Text('Section 2: Button labels displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 3: Navigation Labels
            buildSectionHeader('3. Navigation Labels'),
            buildDemoCard(
              'Drawer, popup, and navigation strings',
              Column(
                children: [
                  buildLocalizedString('openAppDrawerTooltip', 'Open navigation menu', Color(0xFF004D40)),
                  buildLocalizedString('backButtonTooltip', 'Back', Color(0xFF004D40)),
                  buildLocalizedString('closeButtonTooltip', 'Close', Color(0xFF004D40)),
                  buildLocalizedString('deleteButtonTooltip', 'Delete', Color(0xFF00695C)),
                  buildLocalizedString('moreButtonTooltip', 'More', Color(0xFF00695C)),
                  buildLocalizedString('nextMonthTooltip', 'Next month', Color(0xFF00796B)),
                  buildLocalizedString('previousMonthTooltip', 'Previous month', Color(0xFF00796B)),
                  buildLocalizedString('nextPageTooltip', 'Next page', Color(0xFF00897B)),
                  buildLocalizedString('previousPageTooltip', 'Previous page', Color(0xFF00897B)),
                  buildLocalizedString('firstPageTooltip', 'First page', Color(0xFF26A69A)),
                  buildLocalizedString('lastPageTooltip', 'Last page', Color(0xFF26A69A)),
                  buildLocalizedString('showMenuTooltip', 'Show menu', Color(0xFF4DB6AC)),
                ],
              ),
            ),
            Text('Section 3: Navigation labels displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 4: Dialog and Alert Strings
            buildSectionHeader('4. Dialog Strings'),
            buildDemoCard(
              'Dialog-related localized strings',
              Column(
                children: [
                  buildLocalizedString('alertDialogLabel', 'Alert', Color(0xFF004D40)),
                  buildLocalizedString('dialogLabel', 'Dialog', Color(0xFF004D40)),
                  buildLocalizedString('drawerLabel', 'Navigation menu', Color(0xFF00695C)),
                  buildLocalizedString('popupMenuLabel', 'Popup menu', Color(0xFF00695C)),
                  buildLocalizedString('menuBarMenuLabel', 'Menu bar menu', Color(0xFF00796B)),
                  buildLocalizedString('bottomSheetLabel', 'Bottom sheet', Color(0xFF00796B)),
                  buildLocalizedString('modalBarrierDismissLabel', 'Dismiss', Color(0xFF00897B)),
                  buildLocalizedString('searchFieldLabel', 'Search', Color(0xFF00897B)),
                ],
              ),
            ),
            Text('Section 4: Dialog strings displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 5: Day Names
            buildSectionHeader('5. Day Names'),
            buildDemoCard(
              'Narrow weekday names (Mo, Tu, etc.)',
              buildDayNameRow(['S', 'M', 'T', 'W', 'T', 'F', 'S'], Color(0xFF004D40)),
            ),
            buildDemoCard(
              'Full weekday names',
              Column(
                children: [
                  buildLocalizedString('Sunday', 'Sunday', Color(0xFFC62828)),
                  buildLocalizedString('Monday', 'Monday', Color(0xFF004D40)),
                  buildLocalizedString('Tuesday', 'Tuesday', Color(0xFF004D40)),
                  buildLocalizedString('Wednesday', 'Wednesday', Color(0xFF004D40)),
                  buildLocalizedString('Thursday', 'Thursday', Color(0xFF004D40)),
                  buildLocalizedString('Friday', 'Friday', Color(0xFF004D40)),
                  buildLocalizedString('Saturday', 'Saturday', Color(0xFFC62828)),
                ],
              ),
            ),
            Text('Section 5: Day names displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 6: Month Names
            buildSectionHeader('6. Month Names'),
            buildDemoCard(
              'All twelve months',
              buildMonthGrid(
                ['January', 'February', 'March', 'April', 'May', 'June',
                 'July', 'August', 'September', 'October', 'November', 'December'],
                Color(0xFF004D40),
              ),
            ),
            Text('Section 6: Month names displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 7: Date Formatting
            buildSectionHeader('7. Date Formatting Methods'),
            buildDemoCard(
              'formatYear, formatMediumDate, etc.',
              Column(
                children: [
                  buildFormatExample('formatYear()', 'DateTime(2025, 6, 15)', '2025'),
                  buildFormatExample('formatMonthYear()', 'DateTime(2025, 6, 15)', 'June 2025'),
                  buildFormatExample('formatMediumDate()', 'DateTime(2025, 6, 15)', 'Sun, Jun 15'),
                  buildFormatExample('formatFullDate()', 'DateTime(2025, 6, 15)', 'Sunday, June 15, 2025'),
                  buildFormatExample('formatCompactDate()', 'DateTime(2025, 6, 15)', '06/15/2025'),
                  buildFormatExample('formatShortDate()', 'DateTime(2025, 6, 15)', '6/15/2025'),
                  buildFormatExample('formatShortMonthDay()', 'DateTime(2025, 6, 15)', 'Jun 15'),
                ],
              ),
            ),
            Text('Section 7: Date formatting displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 8: Time Formatting
            buildSectionHeader('8. Time Formatting'),
            buildDemoCard(
              'Time-of-day formatting with AM/PM',
              Column(
                children: [
                  buildFormatExample('formatTimeOfDay()', 'TimeOfDay(9, 30)', '9:30 AM'),
                  buildFormatExample('formatTimeOfDay()', 'TimeOfDay(14, 0)', '2:00 PM'),
                  buildFormatExample('formatTimeOfDay()', 'TimeOfDay(0, 0)', '12:00 AM'),
                  buildFormatExample('formatTimeOfDay()', 'TimeOfDay(12, 0)', '12:00 PM'),
                  buildFormatExample('formatTimeOfDay()', 'TimeOfDay(23, 59)', '11:59 PM'),
                ],
              ),
            ),
            Text('Section 8: Time formatting displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 9: Semantic / Accessibility Labels
            buildSectionHeader('9. Accessibility Labels'),
            buildDemoCard(
              'Semantic labels for screen readers',
              Column(
                children: [
                  buildSemanticLabel('AppBar', 'Back button reads "Back"'),
                  buildSemanticLabel('Drawer', 'Open reads "Open navigation menu"'),
                  buildSemanticLabel('SnackBar', 'Dismiss reads "Dismiss"'),
                  buildSemanticLabel('Tooltip', 'Shows tooltip text on long press'),
                  buildSemanticLabel('TabBar', 'Tab N of M format'),
                  buildSemanticLabel('Dialog', 'Announced as "Alert" or "Dialog"'),
                  buildSemanticLabel('DatePicker', 'Navigation reads month/year'),
                  buildSemanticLabel('TimePicker', 'AM/PM and hour:minute labels'),
                ],
              ),
            ),
            Text('Section 9: Accessibility labels displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 10: Pagination and Range Strings
            buildSectionHeader('10. Pagination Strings'),
            buildDemoCard(
              'Page and item range descriptions',
              Column(
                children: [
                  buildLocalizedString('pageRowsInfoTitle', '1-10 of 100', Color(0xFF004D40)),
                  buildLocalizedString('pageRowsInfoTitle (approx)', '1-10 of about 100', Color(0xFF00695C)),
                  buildLocalizedString('rowsPerPageTitle', 'Rows per page:', Color(0xFF00796B)),
                  buildLocalizedString('selectedRowCountTitle (1)', '1 item selected', Color(0xFF00897B)),
                  buildLocalizedString('selectedRowCountTitle (5)', '5 items selected', Color(0xFF26A69A)),
                ],
              ),
            ),
            buildDemoCard(
              'Pagination display example',
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rows per page:', style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF004D40)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('10', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                    Text('1-10 of 100', style: TextStyle(fontSize: 13, color: Color(0xFF616161))),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left, size: 20),
                          onPressed: () { debugPrint('Previous page'); },
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right, size: 20),
                          onPressed: () { debugPrint('Next page'); },
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text('Section 10: Pagination strings displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 11: Script Direction and Misc
            buildSectionHeader('11. Script Direction and Misc'),
            buildDemoCard(
              'Text direction and script properties',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('scriptCategory', 'englishLike'),
                  buildInfoRow('textDirection', 'TextDirection.ltr'),
                  buildInfoRow('firstDayOfWeekIndex', '0 (Sunday)'),
                  SizedBox(height: 8),
                  Text('Script categories:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF424242))),
                  SizedBox(height: 4),
                  Wrap(
                    children: [
                      buildScriptBadge('englishLike', Color(0xFF004D40)),
                      buildScriptBadge('dense', Color(0xFF1565C0)),
                      buildScriptBadge('tall', Color(0xFF6A1B9A)),
                    ],
                  ),
                ],
              ),
            ),
            buildDemoCard(
              'Tooltip strings from various widgets',
              Column(
                children: [
                  buildTooltipEntry('Calendar', 'Select date'),
                  buildTooltipEntry('Refresh', 'Refresh'),
                  buildTooltipEntry('Expansion', 'Show more / less'),
                  buildTooltipEntry('Reorder', 'Move item'),
                  buildTooltipEntry('License page', 'View licenses'),
                  buildTooltipEntry('About dialog', 'About'),
                ],
              ),
            ),
            Text('Section 11: Script and misc displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'DefaultMaterialLocalizations Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'Class overview and purpose'),
                  buildInfoRow('2', 'Button labels (OK, Cancel, etc.)'),
                  buildInfoRow('3', 'Navigation labels and tooltips'),
                  buildInfoRow('4', 'Dialog and alert strings'),
                  buildInfoRow('5', 'Narrow and full day names'),
                  buildInfoRow('6', 'Month name grid'),
                  buildInfoRow('7', 'Date formatting methods'),
                  buildInfoRow('8', 'Time formatting with AM/PM'),
                  buildInfoRow('9', 'Accessibility semantic labels'),
                  buildInfoRow('10', 'Pagination range strings'),
                  buildInfoRow('11', 'Script direction and tooltips'),
                ],
              ),
            ),
            Text('=== DefaultMaterialLocalizations Deep Demo Complete ===', style: TextStyle(fontSize: 10, color: Colors.grey)),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
