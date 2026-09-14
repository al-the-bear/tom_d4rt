// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// **DatePickerEntryMode Deep Demo**
///
/// This demonstration explores the DatePickerEntryMode enum, which controls
/// how users initially interact with date picker dialogs in Flutter.
///
/// **The Four Modes:**
/// - DatePickerEntryMode.calendar → User picks via calendar grid (default)
/// - DatePickerEntryMode.input → User types date in text field
/// - DatePickerEntryMode.calendarOnly → Calendar only, no input toggle
/// - DatePickerEntryMode.inputOnly → Input only, no calendar toggle
///
/// Understanding entry modes helps create optimal UX for different scenarios:
/// - calendar: Best for selecting dates within visible range
/// - input: Best for known dates (birthdays, specific events)
/// - calendarOnly: When visual selection must be enforced
/// - inputOnly: When rapid entry of known dates is priority

dynamic build(BuildContext context) {
  print('╔═══════════════════════════════════════════════════════════════════╗');
  print('║          DatePickerEntryMode Deep Demonstration                   ║');
  print('║    Exploring Initial Interaction Modes for Date Pickers          ║');
  print('╚═══════════════════════════════════════════════════════════════════╝');

  print('\n📋 DatePickerEntryMode enum values:');
  for (final mode in DatePickerEntryMode.values) {
    print('   • ${mode.name} (index: ${mode.index})');
  }

  return MaterialApp(
    title: 'DatePickerEntryMode Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        brightness: Brightness.light,
      ),
    ),
    home: const DatePickerEntryModeShowcase(),
  );
}

/// Color palette for consistent styling
class _DemoColors {
  static const indigo50 = Color(0xFFEEF2FF);
  static const indigo100 = Color(0xFFE0E7FF);
  static const indigo200 = Color(0xFFC7D2FE);
  static const indigo400 = Color(0xFF818CF8);
  static const indigo500 = Color(0xFF6366F1);
  static const indigo600 = Color(0xFF4F46E5);
  static const indigo700 = Color(0xFF4338CA);
  static const indigo800 = Color(0xFF3730A3);
  static const indigo900 = Color(0xFF312E81);

  static const emerald500 = Color(0xFF10B981);
  static const emerald600 = Color(0xFF059669);
  static const amber500 = Color(0xFFF59E0B);
  static const rose500 = Color(0xFFF43F5E);
  static const sky500 = Color(0xFF0EA5E9);

  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate800 = Color(0xFF1E293B);
  static const slate900 = Color(0xFF0F172A);
}

/// Mode data holder for display
class _ModeInfo {
  final DatePickerEntryMode mode;
  final String title;
  final String shortDescription;
  final String detailedDescription;
  final IconData icon;
  final Color color;
  final List<String> useCases;
  final List<String> pros;
  final List<String> cons;

  const _ModeInfo({
    required this.mode,
    required this.title,
    required this.shortDescription,
    required this.detailedDescription,
    required this.icon,
    required this.color,
    required this.useCases,
    required this.pros,
    required this.cons,
  });
}

/// Main showcase widget
class DatePickerEntryModeShowcase extends StatefulWidget {
  const DatePickerEntryModeShowcase({super.key});

  @override
  State<DatePickerEntryModeShowcase> createState() =>
      _DatePickerEntryModeShowcaseState();
}

class _DatePickerEntryModeShowcaseState
    extends State<DatePickerEntryModeShowcase> {
  DateTime? _selectedDate;
  DatePickerEntryMode _currentMode = DatePickerEntryMode.calendar;

  // Comprehensive mode information
  static final List<_ModeInfo> _modeInfoList = [
    const _ModeInfo(
      mode: DatePickerEntryMode.calendar,
      title: 'Calendar Mode',
      shortDescription: 'Visual grid selection with input toggle',
      detailedDescription:
          'Opens the date picker showing a calendar grid by default. '
          'Users can tap any date to select it. A toggle button allows '
          'switching to text input mode if needed. This is the default '
          'mode and provides the most flexibility.',
      icon: Icons.calendar_month,
      color: _DemoColors.indigo600,
      useCases: [
        'Event scheduling apps',
        'Booking systems',
        'General date selection',
        'When date range is visible',
        'Mobile-first applications',
      ],
      pros: [
        'Visual context (weekdays, month layout)',
        'Easy to pick relative dates',
        'Can toggle to input if needed',
        'Most intuitive for touch interfaces',
      ],
      cons: [
        'Slower for known specific dates',
        'Requires more screen space',
        'Multiple taps needed to navigate months/years',
      ],
    ),
    const _ModeInfo(
      mode: DatePickerEntryMode.input,
      title: 'Input Mode',
      shortDescription: 'Text field entry with calendar toggle',
      detailedDescription:
          'Opens the date picker with a text input field for typing '
          'the date directly. Includes format validation and a toggle '
          'to switch to calendar view. Ideal when users already know '
          'the exact date they want to enter.',
      icon: Icons.edit_calendar,
      color: _DemoColors.emerald600,
      useCases: [
        'Birth date entry',
        'Invoice date fields',
        'Historical date records',
        'Desktop/keyboard users',
        'Form-heavy applications',
      ],
      pros: [
        'Fast entry for known dates',
        'Works great with keyboard',
        'Less vertical space needed',
        'Can toggle to calendar if needed',
      ],
      cons: [
        'Requires knowing the date format',
        'More error prone than visual selection',
        'Less intuitive for casual users',
      ],
    ),
    const _ModeInfo(
      mode: DatePickerEntryMode.calendarOnly,
      title: 'Calendar Only',
      shortDescription: 'Visual selection without input option',
      detailedDescription:
          'Opens a calendar grid without any option to toggle to text '
          'input. Users must select dates visually. Use this when you '
          'want to ensure consistent interaction or prevent invalid '
          'input from manual typing.',
      icon: Icons.calendar_view_month,
      color: _DemoColors.amber500,
      useCases: [
        'Appointment booking interfaces',
        'Date restriction enforcement',
        'Accessibility-focused apps',
        'Limited date range selection',
        'When format errors must be avoided',
      ],
      pros: [
        'Consistent user experience',
        'Prevents format-related errors',
        'Enforces valid date selection',
        'Simpler UI (no toggle)',
      ],
      cons: [
        'Slower for known dates',
        'Users may miss input option',
        'Less flexible',
      ],
    ),
    const _ModeInfo(
      mode: DatePickerEntryMode.inputOnly,
      title: 'Input Only',
      shortDescription: 'Text entry without calendar option',
      detailedDescription:
          'Opens a text input field without any option to toggle to '
          'calendar view. Ideal for rapid data entry scenarios where '
          'users always know the exact date and prefer typing. '
          'Validates input format and shows errors inline.',
      icon: Icons.keyboard,
      color: _DemoColors.rose500,
      useCases: [
        'Data entry applications',
        'Database record editing',
        'Power user interfaces',
        'Date import verification',
        'Keyboard-only workflows',
      ],
      pros: [
        'Fastest entry method',
        'Minimal UI footprint',
        'Great for keyboard power users',
        'Efficient for batch entry',
      ],
      cons: [
        'Requires format knowledge',
        'Higher error potential',
        'No visual date context',
        'Less accessible',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _DemoColors.indigo50,
              Color(0xFFF5F3FF),
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
                _buildEnumOverview(),
                const SizedBox(height: 32),
                _buildInteractiveShowcase(),
                const SizedBox(height: 32),
                _buildModeComparisonGrid(),
                const SizedBox(height: 32),
                _buildDetailedModeCards(),
                const SizedBox(height: 32),
                _buildCodeExamples(),
                const SizedBox(height: 32),
                _buildBestPractices(),
                const SizedBox(height: 32),
                _buildAccessibilityNotes(),
                const SizedBox(height: 40),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Header section with title and intro
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_DemoColors.indigo600, _DemoColors.indigo500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _DemoColors.indigo600.withOpacity(0.4),
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
                  Icons.date_range,
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
                      'DatePickerEntryMode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Material Design Date Selection',
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
              'DatePickerEntryMode determines the initial state of date picker '
              'dialogs. It controls whether users see a calendar grid, a text '
              'input field, or if they can toggle between both. Choosing the '
              'right mode improves data entry efficiency and user experience.',
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

  /// Enum overview showing all values
  Widget _buildEnumOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.indigo100),
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
              Icon(Icons.code, color: _DemoColors.indigo600, size: 22),
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
                  'enum DatePickerEntryMode {',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Color(0xFF89DDFF),
                  ),
                ),
                const SizedBox(height: 4),
                ...DatePickerEntryMode.values.map((mode) => Padding(
                      padding: const EdgeInsets.only(left: 16, top: 2),
                      child: Text(
                        '${mode.name},  // index ${mode.index}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          color: Color(0xFFA6ACCD),
                        ),
                      ),
                    )),
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

  /// Interactive mode showcase with buttons to try each mode
  Widget _buildInteractiveShowcase() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.indigo100),
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
              Icon(Icons.touch_app, color: _DemoColors.indigo600, size: 22),
              SizedBox(width: 10),
              Text(
                'Interactive Demo',
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
            'Tap any mode button below to open a date picker with that entry mode:',
            style: TextStyle(
              fontSize: 13,
              color: _DemoColors.slate600,
            ),
          ),
          const SizedBox(height: 20),

          // Mode selection buttons
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _modeInfoList.map((info) {
              final isSelected = _currentMode == info.mode;
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showDatePicker(info.mode),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? info.color.withOpacity(0.15)
                          : _DemoColors.slate50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? info.color
                            : _DemoColors.slate200,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(info.icon, color: info.color, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          info.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? info.color
                                : _DemoColors.slate700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),

          // Selected date display
          Row(
            children: [
              const Icon(Icons.event_available,
                  color: _DemoColors.emerald600, size: 20),
              const SizedBox(width: 8),
              Text(
                _selectedDate != null
                    ? 'Selected: ${_formatDate(_selectedDate!)}'
                    : 'No date selected yet',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      _selectedDate != null ? FontWeight.w600 : FontWeight.w400,
                  color: _selectedDate != null
                      ? _DemoColors.emerald600
                      : _DemoColors.slate600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Current mode: ${_currentMode.name}',
            style: const TextStyle(
              fontSize: 12,
              color: _DemoColors.slate600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  /// Show date picker with specified mode
  Future<void> _showDatePicker(DatePickerEntryMode mode) async {
    setState(() {
      _currentMode = mode;
    });

    print('Opening date picker with mode: ${mode.name}');

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialEntryMode: mode,
      helpText: 'SELECT DATE (${mode.name.toUpperCase()} MODE)',
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      print('Date selected: ${_formatDate(picked)}');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Side-by-side comparison grid
  Widget _buildModeComparisonGrid() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DemoColors.indigo100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.compare, color: _DemoColors.indigo600, size: 22),
              SizedBox(width: 10),
              Text(
                'Mode Comparison',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.slate800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Comparison table header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _DemoColors.indigo50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _DemoColors.indigo800,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Calendar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _DemoColors.indigo800,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Input',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _DemoColors.indigo800,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Toggle',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _DemoColors.indigo800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Table rows
          _buildComparisonRow('calendar', true, false, true,
              'Opens to calendar, can switch to input'),
          _buildComparisonRow('input', false, true, true,
              'Opens to input, can switch to calendar'),
          _buildComparisonRow('calendarOnly', true, false, false,
              'Calendar only, no toggle available'),
          _buildComparisonRow('inputOnly', false, true, false,
              'Input only, no toggle available'),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
      String mode, bool hasCalendar, bool hasInput, bool canToggle, String note) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _DemoColors.slate100),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  mode,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _DemoColors.indigo700,
                  ),
                ),
              ),
              Expanded(child: _buildCheckIcon(hasCalendar)),
              Expanded(child: _buildCheckIcon(hasInput)),
              Expanded(child: _buildCheckIcon(canToggle)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            note,
            style: const TextStyle(
              fontSize: 11,
              color: _DemoColors.slate600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckIcon(bool checked) {
    return Icon(
      checked ? Icons.check_circle : Icons.cancel,
      size: 18,
      color: checked ? _DemoColors.emerald500 : _DemoColors.slate200,
    );
  }

  /// Detailed cards for each mode
  Widget _buildDetailedModeCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 16),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: _DemoColors.indigo600, size: 22),
              SizedBox(width: 10),
              Text(
                'Detailed Mode Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.slate800,
                ),
              ),
            ],
          ),
        ),
        ..._modeInfoList.map((info) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildModeDetailCard(info),
            )),
      ],
    );
  }

  Widget _buildModeDetailCard(_ModeInfo info) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: info.color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: info.color.withOpacity(0.08),
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
              color: info.color.withOpacity(0.1),
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
                    color: info.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(info.icon, color: info.color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: info.color,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'DatePickerEntryMode.${info.mode.name}',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          color: info.color.withOpacity(0.7),
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
                  info.detailedDescription,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: _DemoColors.slate700,
                  ),
                ),
                const SizedBox(height: 16),

                // Use cases
                _buildInfoSection(
                  'Use Cases',
                  Icons.lightbulb_outline,
                  info.useCases,
                  _DemoColors.amber500,
                ),
                const SizedBox(height: 12),

                // Pros and Cons in a row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInfoSection(
                        'Pros',
                        Icons.thumb_up_outlined,
                        info.pros,
                        _DemoColors.emerald500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoSection(
                        'Cons',
                        Icons.thumb_down_outlined,
                        info.cons,
                        _DemoColors.rose500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
      String title, IconData icon, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(color: color, fontSize: 12),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _DemoColors.slate600,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  /// Code examples section
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
              Icon(Icons.terminal, color: _DemoColors.indigo200, size: 22),
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
            'Basic Usage with Calendar Mode',
            '''
final DateTime? picked = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),
  initialEntryMode: DatePickerEntryMode.calendar,
);''',
          ),
          const SizedBox(height: 16),
          _buildCodeBlock(
            'Input Only for Birth Date Entry',
            '''
final DateTime? birthDate = await showDatePicker(
  context: context,
  initialDate: DateTime(2000, 1, 1),
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
  initialEntryMode: DatePickerEntryMode.inputOnly,
  helpText: 'Enter your birth date',
  fieldLabelText: 'Birth date',
);''',
          ),
          const SizedBox(height: 16),
          _buildCodeBlock(
            'Calendar Only for Appointment Booking',
            '''
final DateTime? appointmentDate = await showDatePicker(
  context: context,
  initialDate: DateTime.now().add(Duration(days: 1)),
  firstDate: DateTime.now(),
  lastDate: DateTime.now().add(Duration(days: 90)),
  initialEntryMode: DatePickerEntryMode.calendarOnly,
  selectableDayPredicate: (DateTime date) {
    // Exclude weekends
    return date.weekday != DateTime.saturday &&
           date.weekday != DateTime.sunday;
  },
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
            color: _DemoColors.indigo200,
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

  /// Best practices section
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
            'Match mode to user context',
            'Use calendar for browsing dates, input for known dates like birthdays.',
          ),
          _buildPracticeItem(
            '2',
            'Consider accessibility',
            'Calendar mode is generally more accessible; inputOnly may exclude users '
                'who struggle with format requirements.',
          ),
          _buildPracticeItem(
            '3',
            'Provide clear help text',
            'Use the helpText parameter to guide users, especially in input modes.',
          ),
          _buildPracticeItem(
            '4',
            'Use calendarOnly wisely',
            'Only remove the toggle when you have a specific UX reason to enforce '
                'visual selection.',
          ),
          _buildPracticeItem(
            '5',
            'Test on multiple devices',
            'Input mode works better on desktop; calendar mode is more touch-friendly.',
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

  /// Accessibility considerations
  Widget _buildAccessibilityNotes() {
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
                'Accessibility Considerations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _DemoColors.sky500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Different entry modes have varying accessibility implications:',
            style: TextStyle(
              fontSize: 13,
              color: _DemoColors.slate700,
            ),
          ),
          const SizedBox(height: 12),
          _buildAccessibilityNote(
            Icons.calendar_month,
            'Calendar modes',
            'Work well with screen readers that can announce day and month. '
                'Touch target sizes are important on mobile.',
          ),
          _buildAccessibilityNote(
            Icons.keyboard,
            'Input modes',
            'Rely on users understanding date formats. Always provide clear '
                'format hints and validation messages.',
          ),
          _buildAccessibilityNote(
            Icons.toggle_on,
            'Toggle availability',
            'Allowing toggle gives users choice. Some may prefer keyboard entry, '
                'others visual selection.',
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
            Icons.date_range,
            color: _DemoColors.indigo600,
            size: 36,
          ),
          const SizedBox(height: 12),
          const Text(
            'DatePickerEntryMode Demo Complete',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _DemoColors.slate800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This deep demonstration covered all four entry modes, '
            'their use cases, trade-offs, and implementation patterns.',
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
            children: DatePickerEntryMode.values
                .map((mode) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _DemoColors.indigo100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        mode.name,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _DemoColors.indigo700,
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
