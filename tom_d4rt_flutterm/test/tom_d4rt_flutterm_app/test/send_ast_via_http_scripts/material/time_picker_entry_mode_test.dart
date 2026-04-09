// ignore_for_file: avoid_print
// D4rt deep demo: TimePickerEntryMode — controls the initial input mode
// of the time picker and whether the user can switch modes.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimePickerEntryMode deep demo executing');
  print('=' * 60);

  for (final v in TimePickerEntryMode.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${TimePickerEntryMode.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const tePrimary = Color(0xFF7B1FA2);   // orchid
  const teAccent = Color(0xFFCE93D8);    // lavender
  const teLight = Color(0xFFF3E5F5);     // pale lavender
  const teDark = Color(0xFF4A0072);      // deep orchid
  const teSurface = Color(0xFFFDF5FF);
  const teOnSurface = Color(0xFF2E1038);
  const teMuted = Color(0xFF7E6B8A);

  // mode-specific colours
  const teDial = Color(0xFF1565C0);     // blue for dial
  const teInput = Color(0xFF2E7D32);    // green for input

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> teModes = [
    {
      'value': 'dial',
      'title': 'Dial',
      'icon': 'watch_later',
      'initial': 'Clock dial with draggable hand',
      'switchable': 'Yes — user can tap keyboard icon to switch',
      'best': 'Casual time selection, touchscreen devices',
      'desc': 'Shows a circular clock face. The user selects hours and '
          'minutes by tapping or dragging the clock hand. A small '
          'keyboard icon allows switching to text input.',
    },
    {
      'value': 'input',
      'title': 'Input',
      'icon': 'keyboard',
      'initial': 'Text fields for hour and minute',
      'switchable': 'Yes — user can tap clock icon to switch',
      'best': 'Precise time entry, keyboard-heavy workflows',
      'desc': 'Shows text input fields where the user types hour and '
          'minute values. A clock icon allows switching to the dial. '
          'Faster for users who know the exact time.',
    },
    {
      'value': 'dialOnly',
      'title': 'Dial Only',
      'icon': 'watch_later',
      'initial': 'Clock dial (no switch icon)',
      'switchable': 'No — locked to dial mode',
      'best': 'Simplified UX, restricted interaction',
      'desc': 'Same as dial, but the toggle icon is hidden. The user '
          'cannot switch to text input. Use this when you want to '
          'enforce a consistent clock-dial-only experience.',
    },
    {
      'value': 'inputOnly',
      'title': 'Input Only',
      'icon': 'keyboard',
      'initial': 'Text fields (no switch icon)',
      'switchable': 'No — locked to input mode',
      'best': 'Desktop apps, accessibility, rapid entry',
      'desc': 'Same as input, but the toggle icon is hidden. The user '
          'cannot switch to the dial. Ideal for desktop or keyboard-'
          'focused applications.',
    },
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget teSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: teAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: tePrimary.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tePrimary, teDark],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child ??
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children ?? []),
          ),
        ],
      ),
    );
  }

  Widget teLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: teOnSurface)),
    );
  }

  Widget teBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: teMuted, height: 1.5)),
    );
  }

  Widget teChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? teLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: teAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget teDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: teAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // Mode icon helper
  IconData teModeIcon(String mode) {
    switch (mode) {
      case 'dial':
      case 'dialOnly':
        return Icons.watch_later_outlined;
      case 'input':
      case 'inputOnly':
        return Icons.keyboard_outlined;
      default:
        return Icons.help_outline;
    }
  }

  // ══════════════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Container(
      color: teSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Title Banner ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 42, 24, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [teDark, tePrimary, teAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TimePickerEntryMode',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Controls the initial input method of the time picker '
                  'and whether the user is allowed to switch between '
                  'dial and text input.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    teChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    teChip('TimePicker',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    teChip('UX control',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          teSection('Enum Overview',
            children: [
              teBody(
                'TimePickerEntryMode is passed to showTimePicker() '
                'as the initialEntryMode parameter. It determines '
                'whether the dialog opens with a clock dial or text '
                'input fields, and whether the user can toggle between '
                'the two modes.'),
              teBody(
                'Two modes are switchable (user can toggle) and two '
                'are locked (toggle button is hidden):'),
              Wrap(
                children: [
                  for (final v in TimePickerEntryMode.values)
                    teChip(v.name),
                ],
              ),
            ],
          ),

          // ── 3. Individual Value Cards ────────────────────────
          for (final m in teModes)
            teSection(m['title']!,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: m['value']!.contains('dial')
                            ? teDial.withValues(alpha: 0.12)
                            : teInput.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        teModeIcon(m['value']!),
                        color: m['value']!.contains('dial') ? teDial : teInput,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    teChip('TimePickerEntryMode.${m['value']}'),
                  ],
                ),
                const SizedBox(height: 10),
                teBody(m['desc']!),
                teLabel('Initial View'),
                teBody(m['initial']!),
                teLabel('Switchable?'),
                teBody(m['switchable']!),
                teLabel('Best For'),
                teBody(m['best']!),
              ],
            ),

          // ── 4. Visual Mode Comparison ────────────────────────
          teSection('Visual Mode Comparison',
            children: [
              teBody(
                'Side-by-side views of what each mode looks like '
                'when the time picker opens:'),
              Row(
                children: [
                  // Dial preview
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: teDial.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: teDial.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        children: [
                          // Simulated clock face
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: teDial.withValues(alpha: 0.08),
                              border: Border.all(
                                  color: teDial.withValues(alpha: 0.3),
                                  width: 2),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Clock numbers at 12, 3, 6, 9
                                Positioned(
                                  top: 8,
                                  child: Text('12',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: teDial)),
                                ),
                                Positioned(
                                  right: 8,
                                  child: Text('3',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: teDial)),
                                ),
                                Positioned(
                                  bottom: 8,
                                  child: Text('6',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: teDial)),
                                ),
                                Positioned(
                                  left: 8,
                                  child: Text('9',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: teDial)),
                                ),
                                // Center dot
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: teDial,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Dial Mode',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: teDial)),
                          Text('Tap or drag the hand',
                              style: TextStyle(
                                  fontSize: 10, color: teMuted)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Input preview
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: teInput.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: teInput.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        children: [
                          // Simulated text fields
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 36,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: teInput.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: teInput.withValues(alpha: 0.4)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('14',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: teInput)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(':',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                ),
                                Container(
                                  width: 36,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: teInput.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: teInput.withValues(alpha: 0.4)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('30',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: teInput)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Input Mode',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: teInput)),
                          Text('Type hour and minute',
                              style: TextStyle(
                                  fontSize: 10, color: teMuted)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 5. Switchable vs Locked ──────────────────────────
          teSection('Switchable vs Locked Modes',
            children: [
              teBody(
                'The key distinction is whether the toggle button '
                'is visible in the time picker header:'),
              SizedBox(
                width: double.infinity,
                child: Table(
                  border: TableBorder.all(
                      color: teAccent.withValues(alpha: 0.3), width: 1),
                  columnWidths: const {
                    0: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: tePrimary),
                      children: [
                        for (final h in [
                          'Mode', 'Initial', 'Toggle', 'Locked'
                        ])
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(h,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center),
                          ),
                      ],
                    ),
                    for (int i = 0; i < teModes.length; i++)
                      TableRow(
                        decoration: BoxDecoration(
                          color: i.isEven ? teLight : Colors.white,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(teModes[i]['value']!,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'monospace')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                                teModes[i]['value']!.contains('dial')
                                    ? 'Dial'
                                    : 'Text',
                                style: TextStyle(
                                    fontSize: 10, color: teMuted),
                                textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              teModes[i]['switchable']!.startsWith('Yes')
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: teModes[i]['switchable']!
                                      .startsWith('Yes')
                                  ? teInput
                                  : Colors.red,
                              size: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              teModes[i]['switchable']!.startsWith('No')
                                  ? Icons.lock
                                  : Icons.lock_open,
                              color: teModes[i]['switchable']!.startsWith('No')
                                  ? tePrimary
                                  : teMuted,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 6. showTimePicker Usage ──────────────────────────
          teSection('showTimePicker Usage',
            children: [
              teBody(
                'Pass the mode to showTimePicker via initialEntryMode:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: teLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      'final time = await showTimePicker(',
                      '  context: context,',
                      '  initialTime: TimeOfDay.now(),',
                      '  initialEntryMode:',
                      '      TimePickerEntryMode.dial,',
                      ');',
                      '',
                      '// Lock to input only:',
                      'final time2 = await showTimePicker(',
                      '  context: context,',
                      '  initialTime: TimeOfDay.now(),',
                      '  initialEntryMode:',
                      '      TimePickerEntryMode.inputOnly,',
                      ');',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(line,
                            style: const TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 7. UX Considerations ─────────────────────────────
          teSection('UX Considerations',
            children: [
              for (final ux in [
                {
                  'title': 'Mobile Devices',
                  'icon': Icons.phone_android,
                  'rec': 'Use dial — touch-friendly circular UI',
                  'detail': 'The clock dial is optimised for finger '
                      'interaction on touchscreens. Users can quickly '
                      'drag the hand to the desired time.',
                },
                {
                  'title': 'Desktop Applications',
                  'icon': Icons.desktop_mac,
                  'rec': 'Use input or inputOnly — keyboard-first',
                  'detail': 'Desktop users with a physical keyboard '
                      'find typing times faster than clicking a dial. '
                      'Consider inputOnly for consistency.',
                },
                {
                  'title': 'Accessibility',
                  'icon': Icons.accessibility_new,
                  'rec': 'Use input — screen reader friendly',
                  'detail': 'Text input fields are easier for screen '
                      'readers to announce and navigate. The dial '
                      'requires spatial awareness.',
                },
                {
                  'title': 'Kiosk/POS Systems',
                  'icon': Icons.point_of_sale,
                  'rec': 'Use dialOnly — no mode confusion',
                  'detail': 'Locking to a single mode prevents '
                      'accidental switches in unattended or shared '
                      'device scenarios.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: teLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: tePrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Icon(ux['icon'] as IconData,
                            color: tePrimary, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ux['title'] as String,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 3),
                            Text(ux['rec'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: tePrimary)),
                            const SizedBox(height: 3),
                            Text(ux['detail'] as String,
                                style: TextStyle(
                                    fontSize: 11, color: teMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 8. Theme Customisation ───────────────────────────
          teSection('TimePickerThemeData',
            children: [
              teBody(
                'The visual appearance of both modes can be '
                'customised through TimePickerThemeData:'),
              for (final prop in [
                ['backgroundColor', 'Dialog background colour'],
                ['dayPeriodColor', 'AM/PM toggle background'],
                ['dayPeriodTextColor', 'AM/PM toggle text colour'],
                ['dialBackgroundColor', 'Clock face background'],
                ['dialHandColor', 'Clock hand colour'],
                ['dialTextColor', 'Numbers on clock face'],
                ['entryModeIconColor', 'Toggle button icon colour'],
                ['hourMinuteColor', 'Hour/minute field background'],
                ['hourMinuteTextColor', 'Hour/minute field text'],
                ['inputDecorationTheme', 'Input field decoration'],
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 5, right: 8),
                        decoration: BoxDecoration(
                          color: tePrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 190,
                        child: Text(prop[0],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace')),
                      ),
                      Expanded(
                        child: Text(prop[1],
                            style: TextStyle(fontSize: 11, color: teMuted)),
                      ),
                    ],
                  ),
                ),
              teDivider(),
              teBody(
                'The entryModeIconColor only applies when the mode '
                'is switchable (dial or input). In locked modes, '
                'the icon is not rendered at all.'),
            ],
          ),

          // ── 9. Mode Switching Behaviour ──────────────────────
          teSection('Mode Switching Behaviour',
            children: [
              teBody(
                'When the user switches modes, Flutter calls the '
                'onEntryModeChanged callback:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: teLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      'showTimePicker(',
                      '  context: context,',
                      '  initialTime: TimeOfDay.now(),',
                      '  initialEntryMode:',
                      '      TimePickerEntryMode.dial,',
                      '  onEntryModeChanged: (mode) {',
                      '    // mode is the NEW mode',
                      '    debugPrint(',
                      '      \'Switched to: \${mode.name}\',',
                      '    );',
                      '  },',
                      ');',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(line,
                            style: const TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              teBody(
                'This callback is useful for analytics (tracking which '
                'mode users prefer) and for persisting the user '
                'preference for future picker invocations.'),
            ],
          ),

          // ── 10. Mode Transition Diagram ──────────────────────
          teSection('Mode Transition Diagram',
            children: [
              teBody(
                'Visual flow of how modes transition:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: teLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Switchable modes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: teDial.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: teDial.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.watch_later_outlined,
                                  color: teDial, size: 24),
                              const SizedBox(height: 4),
                              Text('dial',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: teDial)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              const Text('⇄',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700)),
                              Text('toggle',
                                  style: TextStyle(
                                      fontSize: 9, color: teMuted)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: teInput.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: teInput.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.keyboard_outlined,
                                  color: teInput, size: 24),
                              const SizedBox(height: 4),
                              Text('input',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: teInput)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Switchable (toggle visible)',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: tePrimary)),
                    const SizedBox(height: 16),
                    // Locked modes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Icon(Icons.watch_later_outlined,
                                      color: teDial, size: 24),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(Icons.lock,
                                        color: tePrimary, size: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('dialOnly',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: teDial)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Icon(Icons.keyboard_outlined,
                                      color: teInput, size: 24),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(Icons.lock,
                                        color: tePrimary, size: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('inputOnly',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: teInput)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Locked (no toggle)',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: teMuted)),
                  ],
                ),
              ),
            ],
          ),

          // ── 11. Orientation Behaviour ────────────────────────
          teSection('Orientation Behaviour',
            children: [
              teBody(
                'The time picker adapts its layout based on '
                'orientation. Both dial and input modes respond:'),
              for (final orient in [
                {
                  'name': 'Portrait',
                  'dial': 'Clock face above buttons, stacked layout',
                  'input': 'Text fields above buttons, full width',
                  'icon': Icons.stay_current_portrait,
                },
                {
                  'name': 'Landscape',
                  'dial': 'Clock face beside buttons, side-by-side',
                  'input': 'Text fields beside buttons, compact',
                  'icon': Icons.stay_current_landscape,
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: teLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(orient['icon'] as IconData,
                          color: tePrimary, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(orient['name'] as String,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('Dial: ${orient['dial']}',
                                style: TextStyle(
                                    fontSize: 11, color: teMuted)),
                            Text('Input: ${orient['input']}',
                                style: TextStyle(
                                    fontSize: 11, color: teMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 12. Common Pitfalls ──────────────────────────────
          teSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'Using dialOnly on desktop',
                  'detail':
                      'The dial mode is difficult to use with a mouse — '
                      'no precise click targets. Prefer input or '
                      'inputOnly for desktop applications.',
                },
                {
                  'title': 'Not persisting user preference',
                  'detail':
                      'If a user switches from dial to input, they likely '
                      'prefer input. Capture this via onEntryModeChanged '
                      'and reuse as initialEntryMode next time.',
                },
                {
                  'title': 'Ignoring locked mode in tests',
                  'detail':
                      'Widget tests that try to find the toggle button '
                      'will fail silently with dialOnly/inputOnly. '
                      'Test the correct mode explicitly.',
                },
                {
                  'title': 'Confusing with DatePickerEntryMode',
                  'detail':
                      'DatePickerEntryMode has similar values but '
                      'controls the date picker, not the time picker. '
                      'They are separate enums with different APIs.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: tePrimary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: teDark, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(pit['title']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(pit['detail']!,
                          style: TextStyle(fontSize: 11, color: teMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. Decision Guide ───────────────────────────────
          teSection('Decision Guide',
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: teLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      'Is app primarily touch-based?',
                      '  YES → Use dial (default)',
                      '  NO  → Use input',
                      '',
                      'Should user be able to switch?',
                      '  YES → dial or input (toggle visible)',
                      '  NO  → dialOnly or inputOnly (locked)',
                      '',
                      'Is this a kiosk or controlled device?',
                      '  YES → Use a locked mode (Only variant)',
                      '',
                      'Want to remember user preference?',
                      '  → Use onEntryModeChanged callback',
                      '  → Store and pass as initialEntryMode',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(step,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 14. Material 3 Notes ─────────────────────────────
          teSection('Material 3 Updates',
            children: [
              teBody(
                'In Material 3, the time picker design has been '
                'updated with new visual styles:'),
              for (final note in [
                'Dial mode uses a larger clock face with bolder numerals',
                'Input fields follow M3 text field design with outlines',
                'Toggle icon is smaller and positioned in the header',
                'AM/PM selector uses SegmentedButton style',
                'Colour tokens follow the M3 colour scheme',
                'Shape follows M3 container shape (rounded rectangle)',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 5, right: 8),
                        decoration: BoxDecoration(
                          color: tePrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(note,
                            style: TextStyle(fontSize: 12, color: teMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          teSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'showTimePicker',
                  'rel': 'Function that accepts initialEntryMode',
                },
                {
                  'name': 'TimeOfDay',
                  'rel': 'Time value class returned by picker',
                },
                {
                  'name': 'TimeOfDayFormat',
                  'rel': 'Controls time display format (12/24 hr)',
                },
                {
                  'name': 'TimePickerThemeData',
                  'rel': 'Visual customisation for both modes',
                },
                {
                  'name': 'DatePickerEntryMode',
                  'rel': 'Similar enum for date picker (separate)',
                },
                {
                  'name': 'MaterialLocalizations',
                  'rel': 'Provides locale-specific picker strings',
                },
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(api['name']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: teDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: teMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          teSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: tePrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${TimePickerEntryMode.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: teDark)),
                            const Text('Entry Modes',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: teAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('2',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: teDark)),
                            const Text('Switchable',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: teLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('2',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: teDark)),
                            const Text('Locked',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: teLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'TimePickerEntryMode gives precise control over '
                    'the time picker UX — choosing between dial and '
                    'keyboard input, with optional mode locking for '
                    'streamlined user experiences.',
                    style: TextStyle(
                        fontSize: 12, color: teMuted, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Footer ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: teDark,
            child: Column(
              children: [
                const Text('TimePickerEntryMode Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Orchid/Lavender theme  •  Batch 62  •  '
                  '${TimePickerEntryMode.values.length} entry modes  •  '
                  'dial + input visualization',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
