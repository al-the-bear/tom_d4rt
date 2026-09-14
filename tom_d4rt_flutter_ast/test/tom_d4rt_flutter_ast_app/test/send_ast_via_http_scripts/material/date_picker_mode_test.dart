// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// **DatePickerMode Deep Demo**
///
/// This demonstration explores the DatePickerMode enum, which determines
/// the initial view displayed in a date picker calendar interface.
///
/// **The Two Modes:**
/// - DatePickerMode.day → Shows the day grid for selecting a specific day
/// - DatePickerMode.year → Shows the year selector for faster year navigation
///
/// Understanding when to use each mode improves UX:
/// - day: Default for most date selections within current year
/// - year: Better for distant dates like birth dates or historical records
///
/// Note: DatePickerMode is different from DatePickerEntryMode.
/// - DatePickerMode: Controls which VIEW is shown (day grid vs year picker)
/// - DatePickerEntryMode: Controls HOW users interact (calendar vs text input)

dynamic build(BuildContext context) {
  print('╔═══════════════════════════════════════════════════════════════════╗');
  print('║              DatePickerMode Deep Demonstration                     ║');
  print('║       Exploring Calendar View Modes: Day Grid vs Year             ║');
  print('╚═══════════════════════════════════════════════════════════════════╝');

  print('\n📋 DatePickerMode enum values:');
  for (final mode in DatePickerMode.values) {
    print('   • ${mode.name} (index: ${mode.index})');
  }

  print('\n🔍 Key difference from DatePickerEntryMode:');
  print('   DatePickerMode = which VIEW to show (day/year)');
  print('   DatePickerEntryMode = HOW to interact (calendar/input)');

  return MaterialApp(
    title: 'DatePickerMode Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF059669),
        brightness: Brightness.light,
      ),
    ),
    home: const DatePickerModeShowcase(),
  );
}

/// Color palette for consistent styling
class _DemoColors {
  static const emerald50 = Color(0xFFECFDF5);
  static const emerald100 = Color(0xFFD1FAE5);
  static const emerald200 = Color(0xFFA7F3D0);
  static const emerald600 = Color(0xFF059669);
  static const emerald700 = Color(0xFF047857);

  static const indigo600 = Color(0xFF4F46E5);
  static const indigo700 = Color(0xFF4338CA);
  static const amber200 = Color(0xFFFDE68A);
  static const amber600 = Color(0xFFD97706);
  static const sky500 = Color(0xFF0EA5E9);
  static const violet500 = Color(0xFF8B5CF6);

  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate400 = Color(0xFF94A3B8);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate800 = Color(0xFF1E293B);
  static const slate900 = Color(0xFF0F172A);
}

/// Main showcase widget
class DatePickerModeShowcase extends StatefulWidget {
  const DatePickerModeShowcase({super.key});

  @override
  State<DatePickerModeShowcase> createState() => _DatePickerModeShowcaseState();
}

class _DatePickerModeShowcaseState extends State<DatePickerModeShowcase> {
  DateTime? _dayModeSelectedDate;
  DateTime? _yearModeSelectedDate;
  DatePickerMode _lastUsedMode = DatePickerMode.day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _DemoColors.emerald50,
              Color(0xFFF0FDF4),
              _DemoColors.slate50,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 28),
                _buildEnumDefinition(),
                const SizedBox(height: 32),
                _buildModeExplanation(),
                const SizedBox(height: 32),
                _buildInteractiveDemo(),
                const SizedBox(height: 32),
                _buildVisualComparison(),
                const SizedBox(height: 32),
                _buildUseCasesSection(),
                const SizedBox(height: 32),
                _buildVsEntryModeSection(),
                const SizedBox(height: 32),
                _buildCodeExamples(),
                const SizedBox(height: 32),
                _buildBestPractices(),
                const SizedBox(height: 32),
                _buildAccessibilitySection(),
                const SizedBox(height: 40),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Header with title and introduction
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_DemoColors.emerald700, _DemoColors.emerald600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _DemoColors.emerald700.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_view_day,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DatePickerMode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Calendar View Selection',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'DatePickerMode controls which view is initially displayed when '
              'opening a date picker: the day grid for selecting specific days, '
              'or the year selector for quickly navigating to a different year. '
              'Choose wisely based on how far from current date users typically select.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Enum definition display
  Widget _buildEnumDefinition() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.emerald100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.code, color: _DemoColors.emerald600, size: 22),
              SizedBox(width: 10),
              Text(
                'Enum Definition',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.slate800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _DemoColors.slate800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'enum DatePickerMode {',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Color(0xFF89DDFF),
                  ),
                ),
                const SizedBox(height: 4),
                _buildEnumValue('day', 0, 'Shows calendar day grid'),
                _buildEnumValue('year', 1, 'Shows year selection list'),
                const SizedBox(height: 4),
                const Text(
                  '}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Color(0xFF89DDFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnumValue(String name, int index, String comment) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
          ),
          children: [
            TextSpan(
              text: name,
              style: const TextStyle(color: Color(0xFFFFCB6B)),
            ),
            const TextSpan(
              text: ',  ',
              style: TextStyle(color: Color(0xFFA6ACCD)),
            ),
            TextSpan(
              text: '// index $index - $comment',
              style: const TextStyle(color: Color(0xFF676E95)),
            ),
          ],
        ),
      ),
    );
  }

  /// Detailed mode explanation cards
  Widget _buildModeExplanation() {
    return Column(
      children: [
        // Day mode card
        _buildModeCard(
          mode: DatePickerMode.day,
          title: 'Day Mode',
          icon: Icons.calendar_view_month,
          color: _DemoColors.emerald600,
          description:
              'Displays a monthly calendar grid showing all days. Users can tap '
              'any day to select it. Navigation arrows allow moving between months. '
              'The month/year header can be tapped to switch to year mode.',
          visualDescription: 'Grid of 7 columns (weekdays) × 4-6 rows (weeks)',
          bestFor: [
            'Selecting dates within the current month',
            'When users know the approximate date',
            'Scheduling events in near future',
            'Most general date picking scenarios',
          ],
        ),
        const SizedBox(height: 16),
        // Year mode card
        _buildModeCard(
          mode: DatePickerMode.year,
          title: 'Year Mode',
          icon: Icons.calendar_today,
          color: _DemoColors.amber600,
          description:
              'Displays a scrollable list of years. Users tap a year to select it, '
              'then the picker automatically transitions to day mode showing that '
              'year\'s calendar. Efficient for navigating across decades.',
          visualDescription: 'Scrollable grid of year numbers',
          bestFor: [
            'Entering birth dates',
            'Historical date records',
            'Dates many years in past/future',
            'When year is more important than exact day',
          ],
        ),
      ],
    );
  }

  Widget _buildModeCard({
    required DatePickerMode mode,
    required String title,
    required IconData icon,
    required Color color,
    required String description,
    required String visualDescription,
    required List<String> bestFor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'DatePickerMode.${mode.name}',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: color.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: _DemoColors.slate700,
                  ),
                ),
                const SizedBox(height: 14),

                // Visual description
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _DemoColors.slate100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.visibility,
                          size: 16, color: _DemoColors.slate600),
                      const SizedBox(width: 8),
                      Text(
                        visualDescription,
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: _DemoColors.slate600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Best for list
                const Text(
                  'Best for:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _DemoColors.slate700,
                  ),
                ),
                const SizedBox(height: 8),
                ...bestFor.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle,
                              size: 14, color: color),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 12,
                                color: _DemoColors.slate600,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Interactive demo section
  Widget _buildInteractiveDemo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.emerald100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.touch_app, color: _DemoColors.emerald600, size: 22),
              SizedBox(width: 10),
              Text(
                'Try It Yourself',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.slate800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap each button to see the date picker open in different modes:',
            style: TextStyle(fontSize: 13, color: _DemoColors.slate600),
          ),
          const SizedBox(height: 20),

          // Mode buttons
          Row(
            children: [
              Expanded(
                child: _buildDemoButton(
                  mode: DatePickerMode.day,
                  icon: Icons.calendar_view_month,
                  label: 'Open Day Mode',
                  color: _DemoColors.emerald600,
                  selectedDate: _dayModeSelectedDate,
                  onPressed: () => _openDatePicker(DatePickerMode.day),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDemoButton(
                  mode: DatePickerMode.year,
                  icon: Icons.calendar_today,
                  label: 'Open Year Mode',
                  color: _DemoColors.amber600,
                  selectedDate: _yearModeSelectedDate,
                  onPressed: () => _openDatePicker(DatePickerMode.year),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),

          // Results display
          Row(
            children: [
              const Icon(Icons.info_outline,
                  size: 16, color: _DemoColors.slate600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Last used mode: ${_lastUsedMode.name}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: _DemoColors.slate600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDemoButton({
    required DatePickerMode mode,
    required IconData icon,
    required String label,
    required Color color,
    required DateTime? selectedDate,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                selectedDate != null
                    ? _formatDate(selectedDate)
                    : 'No selection',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: selectedDate != null ? color : _DemoColors.slate600,
                  fontWeight:
                      selectedDate != null ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openDatePicker(DatePickerMode mode) async {
    print('Opening date picker with mode: ${mode.name}');
    setState(() {
      _lastUsedMode = mode;
    });

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: mode,
      helpText: mode == DatePickerMode.day
          ? 'SELECT DATE (DAY VIEW)'
          : 'SELECT YEAR FIRST',
    );

    if (picked != null) {
      setState(() {
        if (mode == DatePickerMode.day) {
          _dayModeSelectedDate = picked;
        } else {
          _yearModeSelectedDate = picked;
        }
      });
      print('Selected date: ${_formatDate(picked)} via ${mode.name} mode');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Visual comparison section
  Widget _buildVisualComparison() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.emerald100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.compare, color: _DemoColors.emerald600, size: 22),
              SizedBox(width: 10),
              Text(
                'Visual Comparison',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.slate800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Side-by-side mockups
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildDayModeMockup()),
              const SizedBox(width: 16),
              Expanded(child: _buildYearModeMockup()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayModeMockup() {
    return Container(
      decoration: BoxDecoration(
        color: _DemoColors.slate50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _DemoColors.emerald200),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _DemoColors.emerald600,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_view_month, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  'Day Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Calendar mockup
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Month row
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _DemoColors.emerald100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.chevron_left,
                          size: 14, color: _DemoColors.emerald700),
                      Text(
                        'March 2026',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _DemoColors.emerald700,
                        ),
                      ),
                      Icon(Icons.chevron_right,
                          size: 14, color: _DemoColors.emerald700),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Weekday headers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                      .map((d) => SizedBox(
                            width: 20,
                            child: Text(
                              d,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: _DemoColors.slate600,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 6),
                // Day grid (simplified)
                ...List.generate(
                    4,
                    (row) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(7, (col) {
                              final day = row * 7 + col + 1;
                              final isSelected = day == 25;
                              return Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? _DemoColors.emerald600
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  day <= 31 ? '$day' : '',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: isSelected
                                        ? Colors.white
                                        : _DemoColors.slate700,
                                  ),
                                ),
                              );
                            }),
                          ),
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearModeMockup() {
    return Container(
      decoration: BoxDecoration(
        color: _DemoColors.slate50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _DemoColors.amber200),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _DemoColors.amber600,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  'Year Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Year grid mockup
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard_arrow_up,
                        size: 14, color: _DemoColors.slate400),
                  ],
                ),
                const SizedBox(height: 4),
                ...List.generate(
                    4,
                    (row) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(3, (col) {
                              final year = 2020 + row * 3 + col;
                              final isSelected = year == 2026;
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? _DemoColors.amber600
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '$year',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : _DemoColors.slate700,
                                  ),
                                ),
                              );
                            }),
                          ),
                        )),
                const SizedBox(height: 4),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard_arrow_down,
                        size: 14, color: _DemoColors.slate400),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Use cases section
  Widget _buildUseCasesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.emerald100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb, color: _DemoColors.emerald600, size: 22),
              SizedBox(width: 10),
              Text(
                'When to Use Each Mode',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.slate800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildUseCaseRow(
            scenario: 'Event Scheduling',
            recommendation: 'Day',
            icon: Icons.event,
            color: _DemoColors.emerald600,
            reason: 'Events are usually scheduled within days/weeks',
          ),
          _buildUseCaseRow(
            scenario: 'Birth Date Entry',
            recommendation: 'Year',
            icon: Icons.cake,
            color: _DemoColors.amber600,
            reason: 'Users need to navigate decades back quickly',
          ),
          _buildUseCaseRow(
            scenario: 'Flight Booking',
            recommendation: 'Day',
            icon: Icons.flight,
            color: _DemoColors.emerald600,
            reason: 'Travel dates are typically within a few months',
          ),
          _buildUseCaseRow(
            scenario: 'Historical Records',
            recommendation: 'Year',
            icon: Icons.history,
            color: _DemoColors.amber600,
            reason: 'Dates may span many decades',
          ),
          _buildUseCaseRow(
            scenario: 'Appointment Booking',
            recommendation: 'Day',
            icon: Icons.schedule,
            color: _DemoColors.emerald600,
            reason: 'Appointments are in near future',
          ),
          _buildUseCaseRow(
            scenario: 'ID Expiration Date',
            recommendation: 'Year',
            icon: Icons.badge,
            color: _DemoColors.amber600,
            reason: 'May be years in the future',
          ),
        ],
      ),
    );
  }

  Widget _buildUseCaseRow({
    required String scenario,
    required String recommendation,
    required IconData icon,
    required Color color,
    required String reason,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      scenario,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _DemoColors.slate800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        recommendation,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  reason,
                  style: const TextStyle(
                    fontSize: 11,
                    color: _DemoColors.slate600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Comparison with DatePickerEntryMode
  Widget _buildVsEntryModeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _DemoColors.violet500.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.violet500.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.help_outline, color: _DemoColors.violet500, size: 22),
              SizedBox(width: 10),
              Text(
                'DatePickerMode vs DatePickerEntryMode',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.violet500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'These enums serve different purposes and are often confused:',
            style: TextStyle(
              fontSize: 13,
              color: _DemoColors.slate700,
            ),
          ),
          const SizedBox(height: 16),

          // Comparison table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _DemoColors.violet500.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Aspect',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _DemoColors.violet500,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'DatePickerMode',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _DemoColors.emerald600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'DatePickerEntryMode',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _DemoColors.indigo600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildComparisonRow('Controls', 'Calendar VIEW', 'INPUT METHOD'),
                _buildComparisonRow('Values', 'day, year', 'calendar, input, calendarOnly, inputOnly'),
                _buildComparisonRow('Question', 'Which grid to show?', 'Calendar or text field?'),
                _buildComparisonRow('Parameter', 'initialDatePickerMode', 'initialEntryMode'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String aspect, String mode, String entryMode) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _DemoColors.slate100),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              aspect,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _DemoColors.slate700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              mode,
              style: const TextStyle(
                fontSize: 11,
                color: _DemoColors.emerald700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              entryMode,
              style: const TextStyle(
                fontSize: 11,
                color: _DemoColors.indigo700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Code examples
  Widget _buildCodeExamples() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _DemoColors.slate800,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.terminal, color: _DemoColors.emerald200, size: 22),
              SizedBox(width: 10),
              Text(
                'Code Examples',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCodeBlock(
            'Default Day Mode (most common)',
            '''
final DateTime? picked = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime.now(),
  lastDate: DateTime.now().add(Duration(days: 365)),
  initialDatePickerMode: DatePickerMode.day,
);''',
          ),
          const SizedBox(height: 16),
          _buildCodeBlock(
            'Year Mode for Birth Date',
            '''
final DateTime? birthDate = await showDatePicker(
  context: context,
  initialDate: DateTime(2000, 1, 1),
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
  initialDatePickerMode: DatePickerMode.year,
  helpText: 'Select your birth year first',
);''',
          ),
          const SizedBox(height: 16),
          _buildCodeBlock(
            'Combining Both Mode Parameters',
            '''
// Year mode for calendar VIEW, calendar for INPUT method
final DateTime? date = await showDatePicker(
  context: context,
  initialDate: DateTime(1990, 6, 15),
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
  initialDatePickerMode: DatePickerMode.year,
  initialEntryMode: DatePickerEntryMode.calendar,
);''',
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(String title, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _DemoColors.emerald200,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _DemoColors.slate900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFFA6ACCD),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  /// Best practices
  Widget _buildBestPractices() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _DemoColors.emerald600.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.emerald600.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.verified, color: _DemoColors.emerald600, size: 22),
              SizedBox(width: 10),
              Text(
                'Best Practices',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.emerald600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPracticeItem(
            '1',
            'Match mode to date distance',
            'Use year mode when expected dates are years away from current date.',
          ),
          _buildPracticeItem(
            '2',
            'Consider user knowledge',
            'If users know exact dates, year mode lets them quickly navigate to that year.',
          ),
          _buildPracticeItem(
            '3',
            'Set appropriate firstDate/lastDate',
            'Constrain the range based on your use case to prevent nonsensical selections.',
          ),
          _buildPracticeItem(
            '4',
            'Provide helpful helpText',
            'Guide users: "Select your birth year first" makes year mode intentions clear.',
          ),
          _buildPracticeItem(
            '5',
            'Don\'t confuse with DatePickerEntryMode',
            'Mode controls VIEW (day/year), EntryMode controls INPUT (calendar/text).',
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeItem(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _DemoColors.emerald600,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _DemoColors.slate800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _DemoColors.slate600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Accessibility section
  Widget _buildAccessibilitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _DemoColors.sky500.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.sky500.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.accessibility_new, color: _DemoColors.sky500, size: 22),
              SizedBox(width: 10),
              Text(
                'Accessibility Notes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.sky500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAccessibilityNote(
            Icons.calendar_view_month,
            'Day mode accessibility',
            'Screen readers announce day names and dates. Each cell is focusable. '
                'Good semantic structure for assistive technology.',
          ),
          _buildAccessibilityNote(
            Icons.calendar_today,
            'Year mode accessibility',
            'Year list is scrollable with keyboard. Each year is announced. '
                'May require more navigation steps than day mode.',
          ),
          _buildAccessibilityNote(
            Icons.swap_horiz,
            'Mode switching',
            'Users can switch modes by tapping the month/year header. '
                'Ensure this interaction is communicated to screen reader users.',
          ),
        ],
      ),
    );
  }

  Widget _buildAccessibilityNote(IconData icon, String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: _DemoColors.sky500),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _DemoColors.slate800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _DemoColors.slate600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Footer
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _DemoColors.slate100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.calendar_view_day,
            color: _DemoColors.emerald600,
            size: 36,
          ),
          const SizedBox(height: 12),
          const Text(
            'DatePickerMode Demo Complete',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _DemoColors.slate800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This deep demonstration covered both date picker modes, '
            'their visual differences, use cases, and how they differ from '
            'DatePickerEntryMode.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: _DemoColors.slate600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: DatePickerMode.values
                .map((mode) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: mode == DatePickerMode.day
                            ? _DemoColors.emerald600
                            : _DemoColors.amber600,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        mode.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
