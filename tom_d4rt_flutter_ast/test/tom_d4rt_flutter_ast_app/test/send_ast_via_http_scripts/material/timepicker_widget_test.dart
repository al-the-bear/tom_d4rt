// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: TimePickerDialog and the Material time-picker family.
// Showcases TimeOfDay, TimePickerEntryMode, TimePickerThemeData and a custom
// CustomPaint analog clock face. All risky constructors are wrapped in
// try/catch. Single build() function returning a Scaffold.
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimePickerDialog deep visual demo: starting');

  // ---------------------------------------------------------------------------
  // Palette - "Midnight Brass" - unique to this file.
  // ---------------------------------------------------------------------------
  const Color cInkDeep = Color(0xFF0F1E2D);
  const Color cInkMid = Color(0xFF1E3247);
  const Color cInkSoft = Color(0xFF2C465F);
  const Color cBrass = Color(0xFFC9A85E);
  const Color cBrassBright = Color(0xFFE8C97C);
  const Color cParchment = Color(0xFFF6ECD4);
  const Color cTeal = Color(0xFF3FA9A2);
  const Color cCoral = Color(0xFFE0625A);
  const Color cVioletDawn = Color(0xFF6E5BA3);
  const Color cMintTwilight = Color(0xFF7CC6A4);
  const Color cGoldShadow = Color(0xFF7A6228);

  // ---------------------------------------------------------------------------
  // Helper: section title bar.
  // ---------------------------------------------------------------------------
  Widget sectionTitle(String index, String title, String subtitle, Color tint) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 28, 20, 14),
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [tint.withValues(alpha: 0.92), cInkDeep],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cBrass.withValues(alpha: 0.45), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cBrass.withValues(alpha: 0.85),
              shape: BoxShape.circle,
              border: Border.all(color: cParchment, width: 1.5),
            ),
            child: Text(
              index,
              style: const TextStyle(
                color: cInkDeep,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: cParchment,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: cParchment.withValues(alpha: 0.78),
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: chip with caption.
  // ---------------------------------------------------------------------------
  Widget brassChip(String label, Color background, Color foreground) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cBrass.withValues(alpha: 0.55), width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 1: Hero header
  // ---------------------------------------------------------------------------
  final Widget hero = Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(20, 24, 20, 8),
    padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cInkDeep, cInkMid, cInkSoft],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: cBrass, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cBrass,
                shape: BoxShape.circle,
                border: Border.all(color: cParchment, width: 2.5),
              ),
              child: const Icon(
                Icons.access_time,
                color: cInkDeep,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Midnight Brass',
                    style: TextStyle(
                      color: cBrassBright,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Material Time Picking',
                    style: TextStyle(
                      color: cParchment,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'A guided tour of TimePickerDialog, TimeOfDay, TimePickerEntryMode '
          'and TimePickerThemeData. We render every variation we can build '
          'statically, mock the entry-mode chrome, paint a custom analog '
          'clock face, and document the showTimePicker entry point.',
          style: TextStyle(
            color: cParchment.withValues(alpha: 0.88),
            fontSize: 13.6,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: [
            brassChip('TimePickerDialog', cBrass, cInkDeep),
            brassChip('TimeOfDay', cTeal, cParchment),
            brassChip('TimePickerEntryMode', cVioletDawn, cParchment),
            brassChip('TimePickerThemeData', cCoral, cParchment),
            brassChip('CustomPaint clock', cMintTwilight, cInkDeep),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2: Gallery of TimePickerDialog instances.
  // We try to construct multiple dialogs with different parameters and render
  // them inside SizedBoxes so they actually lay out. Each one is wrapped in
  // try/catch in case a parameter combination throws under test conditions.
  // ---------------------------------------------------------------------------
  Widget buildDialogCard(
    String label,
    String detail,
    Widget? dialog,
    Color tint,
  ) {
    return Container(
      width: 320,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cInkMid,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.85),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: cInkDeep,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: TextStyle(
                    color: cInkDeep.withValues(alpha: 0.78),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 460,
            child: dialog ??
                Container(
                  alignment: Alignment.center,
                  color: cInkSoft,
                  child: const Text(
                    '(dialog construction failed)',
                    style: TextStyle(color: cParchment),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget? safeDialog(Widget Function() factory) {
    try {
      return factory();
    } catch (e) {
      print('TimePickerDialog construction failed: $e');
      return null;
    }
  }

  final Widget? dlgBasic = safeDialog(() => TimePickerDialog(
        initialTime: const TimeOfDay(hour: 10, minute: 30),
      ));
  final Widget? dlgHelp = safeDialog(() => TimePickerDialog(
        initialTime: const TimeOfDay(hour: 14, minute: 0),
        helpText: 'Pick a meeting time',
      ));
  final Widget? dlgLabels = safeDialog(() => TimePickerDialog(
        initialTime: const TimeOfDay(hour: 8, minute: 15),
        cancelText: 'Dismiss',
        confirmText: 'Schedule',
        hourLabelText: 'Hour',
        minuteLabelText: 'Min',
      ));
  final Widget? dlgInput = safeDialog(() => TimePickerDialog(
        initialTime: const TimeOfDay(hour: 16, minute: 45),
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'Type the time',
      ));
  final Widget? dlgInputOnly = safeDialog(() => TimePickerDialog(
        initialTime: const TimeOfDay(hour: 23, minute: 59),
        initialEntryMode: TimePickerEntryMode.inputOnly,
        errorInvalidText: 'Out of range',
      ));
  final Widget? dlgDialOnly = safeDialog(() => TimePickerDialog(
        initialTime: const TimeOfDay(hour: 6, minute: 0),
        initialEntryMode: TimePickerEntryMode.dialOnly,
      ));
  final Widget? dlgRestore = safeDialog(() => TimePickerDialog(
        initialTime: const TimeOfDay(hour: 12, minute: 0),
        restorationId: 'demo-time-picker',
      ));
  final Widget? dlgErrorish = safeDialog(() => TimePickerDialog(
        initialTime: const TimeOfDay(hour: 9, minute: 0),
        errorInvalidText: 'Invalid time entered',
        hourLabelText: 'HH',
        minuteLabelText: 'MM',
      ));

  final Widget gallery = Wrap(
    alignment: WrapAlignment.center,
    children: [
      buildDialogCard(
        'Basic',
        'initialTime: 10:30',
        dlgBasic,
        cBrass,
      ),
      buildDialogCard(
        'helpText',
        'Custom prompt',
        dlgHelp,
        cTeal,
      ),
      buildDialogCard(
        'Labels & buttons',
        'cancelText / confirmText / hourLabelText',
        dlgLabels,
        cVioletDawn,
      ),
      buildDialogCard(
        'Entry: input',
        'Type-first 16:45',
        dlgInput,
        cCoral,
      ),
      buildDialogCard(
        'Entry: inputOnly',
        'Dial hidden, late 23:59',
        dlgInputOnly,
        cMintTwilight,
      ),
      buildDialogCard(
        'Entry: dialOnly',
        'No keyboard fallback',
        dlgDialOnly,
        cBrassBright,
      ),
      buildDialogCard(
        'restorationId',
        'State restoration enabled',
        dlgRestore,
        cTeal,
      ),
      buildDialogCard(
        'errorInvalidText',
        'Custom error copy',
        dlgErrorish,
        cCoral,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // SECTION 3: Custom analog clock face via CustomPaint.
  // ---------------------------------------------------------------------------
  final Widget clockFace12 = Container(
    width: 240,
    height: 240,
    margin: const EdgeInsets.all(10),
    child: CustomPaint(
      painter: _ClockFacePainter(
        ringColor: cBrass,
        hubColor: cInkDeep,
        markerColor: cParchment,
        handHourColor: cBrassBright,
        handMinuteColor: cCoral,
        background: cInkMid,
        hour: 10,
        minute: 10,
        is24Hour: false,
      ),
    ),
  );
  final Widget clockFace24 = Container(
    width: 240,
    height: 240,
    margin: const EdgeInsets.all(10),
    child: CustomPaint(
      painter: _ClockFacePainter(
        ringColor: cTeal,
        hubColor: cInkDeep,
        markerColor: cParchment,
        handHourColor: cMintTwilight,
        handMinuteColor: cBrassBright,
        background: cInkSoft,
        hour: 17,
        minute: 35,
        is24Hour: true,
      ),
    ),
  );

  final Widget clockSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cInkMid,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: cBrass.withValues(alpha: 0.45), width: 1.2),
    ),
    child: Column(
      children: [
        const Text(
          'Static analog clock face (CustomPaint)',
          style: TextStyle(
            color: cParchment,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Column(
              children: [
                clockFace12,
                const Text(
                  '12-hour face - 10:10',
                  style: TextStyle(color: cParchment, fontSize: 12),
                ),
              ],
            ),
            Column(
              children: [
                clockFace24,
                const Text(
                  '24-hour face - 17:35',
                  style: TextStyle(color: cParchment, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 4: Digital clock readout.
  // ---------------------------------------------------------------------------
  Widget digitalReadout(TimeOfDay t, String caption, Color accent) {
    final String hh = t.hour.toString().padLeft(2, '0');
    final String mm = t.minute.toString().padLeft(2, '0');
    return Container(
      width: 220,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: cInkDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: TextStyle(
              color: accent,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$hh:$mm',
                style: TextStyle(
                  color: cParchment,
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: accent.withValues(alpha: 0.6),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  t.period == DayPeriod.am ? 'AM' : 'PM',
                  style: TextStyle(
                    color: accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'periodOffset = ${t.periodOffset}',
            style: TextStyle(
              color: cParchment.withValues(alpha: 0.7),
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }

  final Widget digitalGallery = Wrap(
    alignment: WrapAlignment.center,
    children: [
      digitalReadout(
        const TimeOfDay(hour: 0, minute: 0),
        'MIDNIGHT',
        cVioletDawn,
      ),
      digitalReadout(const TimeOfDay(hour: 6, minute: 30), 'DAWN', cTeal),
      digitalReadout(const TimeOfDay(hour: 12, minute: 0), 'NOON', cBrass),
      digitalReadout(
        const TimeOfDay(hour: 18, minute: 45),
        'EVENING',
        cCoral,
      ),
      digitalReadout(
        const TimeOfDay(hour: 23, minute: 59),
        'LATE NIGHT',
        cMintTwilight,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // SECTION 5: Mock TimePickerEntryMode renderings.
  // ---------------------------------------------------------------------------
  Widget mockDial(Color base) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: base,
        shape: BoxShape.circle,
        border: Border.all(color: cBrass, width: 2),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _MiniDialPainter(
                ringColor: cParchment,
                handColor: cBrassBright,
                tickColor: cParchment.withValues(alpha: 0.7),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: cBrassBright,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mockInputBox(String value, Color accent) {
    return Container(
      width: 76,
      height: 76,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cInkDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent, width: 2),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: accent,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget mockEntryMode(String label, String description, Widget body) {
    return Container(
      width: 280,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cInkSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cBrass.withValues(alpha: 0.4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: cBrassBright,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              color: cParchment.withValues(alpha: 0.78),
              fontSize: 11.5,
            ),
          ),
          const SizedBox(height: 12),
          Center(child: body),
        ],
      ),
    );
  }

  final Widget entryModeGallery = Wrap(
    alignment: WrapAlignment.center,
    children: [
      mockEntryMode(
        'TimePickerEntryMode.dial',
        'Default. Dial is shown first; user can switch to input via icon.',
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            mockDial(cInkMid),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mockInputBox('10', cBrass),
                const SizedBox(width: 6),
                const Text(
                  ':',
                  style: TextStyle(
                    color: cParchment,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 6),
                mockInputBox('30', cInkSoft),
              ],
            ),
          ],
        ),
      ),
      mockEntryMode(
        'TimePickerEntryMode.input',
        'Keyboard-first. Two text fields shown; user can switch to dial.',
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            mockInputBox('14', cBrass),
            const SizedBox(width: 6),
            const Text(
              ':',
              style: TextStyle(
                color: cParchment,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 6),
            mockInputBox('00', cBrass),
          ],
        ),
      ),
      mockEntryMode(
        'TimePickerEntryMode.dialOnly',
        'Dial is the only option. No switch icon is shown.',
        mockDial(cInkMid),
      ),
      mockEntryMode(
        'TimePickerEntryMode.inputOnly',
        'Text fields are the only option. No dial fallback.',
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            mockInputBox('23', cCoral),
            const SizedBox(width: 6),
            const Text(
              ':',
              style: TextStyle(
                color: cParchment,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 6),
            mockInputBox('59', cCoral),
          ],
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // SECTION 6: TimeOfDay arithmetic and formatting.
  // ---------------------------------------------------------------------------
  Widget todRow(String label, String value, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: cInkDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 28,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: cParchment.withValues(alpha: 0.8),
                fontSize: 12.5,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: cBrassBright,
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  // Build several values without using for-in on bridged data.
  String safeFormat(TimeOfDay t) {
    try {
      return t.format(context);
    } catch (e) {
      return '${t.hour.toString().padLeft(2, "0")}:'
          '${t.minute.toString().padLeft(2, "0")}';
    }
  }

  const TimeOfDay todA = TimeOfDay(hour: 9, minute: 15);
  const TimeOfDay todB = TimeOfDay(hour: 17, minute: 45);
  final TimeOfDay todC = todA.replacing(minute: 0);
  final TimeOfDay todD = todB.replacing(hour: 23);
  final bool sameAB = todA == todB;
  final bool sameAA = todA == const TimeOfDay(hour: 9, minute: 15);

  final Widget todSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cInkMid,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: cTeal.withValues(alpha: 0.5), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'TimeOfDay arithmetic and formatting',
          style: TextStyle(
            color: cParchment,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        todRow('todA = TimeOfDay(9, 15)', safeFormat(todA), cTeal),
        todRow('todB = TimeOfDay(17, 45)', safeFormat(todB), cBrass),
        todRow('todA.replacing(minute: 0)', safeFormat(todC), cVioletDawn),
        todRow('todB.replacing(hour: 23)', safeFormat(todD), cCoral),
        todRow('todA.period', todA.period.toString(), cMintTwilight),
        todRow('todB.period', todB.period.toString(), cMintTwilight),
        todRow('todA.periodOffset', todA.periodOffset.toString(), cBrass),
        todRow('todB.periodOffset', todB.periodOffset.toString(), cBrass),
        todRow('todA == todB', sameAB.toString(), cCoral),
        todRow('todA == TimeOfDay(9, 15)', sameAA.toString(), cTeal),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7: TimePickerThemeData mock cards.
  // ---------------------------------------------------------------------------
  Widget mockThemedDialog({
    required String title,
    required Color background,
    required Color hourMinuteColor,
    required Color hourMinuteTextColor,
    required Color dialBackground,
    required Color dialHandColor,
  }) {
    return Container(
      width: 280,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cBrass.withValues(alpha: 0.5), width: 1.2),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: hourMinuteTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Icon(Icons.keyboard, color: hourMinuteTextColor, size: 18),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hourMinuteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '10',
                    style: TextStyle(
                      color: hourMinuteTextColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  ':',
                  style: TextStyle(
                    color: hourMinuteTextColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 70,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hourMinuteColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '30',
                    style: TextStyle(
                      color: hourMinuteTextColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: 160,
            height: 160,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: dialBackground,
              shape: BoxShape.circle,
            ),
            child: CustomPaint(
              painter: _MiniDialPainter(
                ringColor: hourMinuteTextColor.withValues(alpha: 0.7),
                handColor: dialHandColor,
                tickColor: hourMinuteTextColor.withValues(alpha: 0.6),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'CANCEL',
                  style: TextStyle(
                    color: hourMinuteTextColor.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'OK',
                  style: TextStyle(
                    color: dialHandColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget themeGallery = Wrap(
    alignment: WrapAlignment.center,
    children: [
      mockThemedDialog(
        title: 'Theme: Brass Default',
        background: cInkMid,
        hourMinuteColor: cBrass,
        hourMinuteTextColor: cInkDeep,
        dialBackground: cInkSoft,
        dialHandColor: cBrassBright,
      ),
      mockThemedDialog(
        title: 'Theme: Teal Mist',
        background: cInkDeep,
        hourMinuteColor: cTeal,
        hourMinuteTextColor: cParchment,
        dialBackground: cInkMid,
        dialHandColor: cMintTwilight,
      ),
      mockThemedDialog(
        title: 'Theme: Coral Sunset',
        background: cInkDeep,
        hourMinuteColor: cCoral,
        hourMinuteTextColor: cParchment,
        dialBackground: cGoldShadow,
        dialHandColor: cBrassBright,
      ),
      mockThemedDialog(
        title: 'Theme: Violet Dawn',
        background: cInkSoft,
        hourMinuteColor: cVioletDawn,
        hourMinuteTextColor: cParchment,
        dialBackground: cInkDeep,
        dialHandColor: cMintTwilight,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // SECTION 8: Code card describing showTimePicker.
  // ---------------------------------------------------------------------------
  Widget codeCard(String title, String code, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: cInkDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.code, color: cBrassBright, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: tint,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              code,
              style: const TextStyle(
                color: cParchment,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  const String codeShowTimePicker =
      'final TimeOfDay? picked = await showTimePicker(\n'
      '  context: context,\n'
      '  initialTime: TimeOfDay.now(),\n'
      '  initialEntryMode: TimePickerEntryMode.dial,\n'
      '  helpText: "Pick a meeting time",\n'
      '  cancelText: "Dismiss",\n'
      '  confirmText: "Schedule",\n'
      '  hourLabelText: "Hour",\n'
      '  minuteLabelText: "Minute",\n'
      '  errorInvalidText: "Out of range",\n'
      '  orientation: Orientation.portrait,\n'
      '  builder: (BuildContext ctx, Widget? child) => child!,\n'
      ');\n'
      'if (picked != null) {\n'
      r'  print("user picked $picked");' '\n'
      '}';

  const String codeDialogDirect = 'showDialog<TimeOfDay>(\n'
      '  context: context,\n'
      '  builder: (_) => TimePickerDialog(\n'
      '    initialTime: TimeOfDay(hour: 9, minute: 30),\n'
      '    initialEntryMode: TimePickerEntryMode.input,\n'
      '  ),\n'
      ');';

  // ---------------------------------------------------------------------------
  // SECTION 9: Reference table of TimePickerDialog parameters.
  // ---------------------------------------------------------------------------
  Widget refRow(String name, String type, String defaultValue, String note) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: cBrass.withValues(alpha: 0.25),
            width: 0.6,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              name,
              style: const TextStyle(
                color: cBrassBright,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              type,
              style: TextStyle(
                color: cMintTwilight.withValues(alpha: 0.9),
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              defaultValue,
              style: const TextStyle(
                color: cCoral,
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: TextStyle(
                color: cParchment.withValues(alpha: 0.82),
                fontSize: 11.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget refTable = Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
      color: cInkMid,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cBrass.withValues(alpha: 0.45), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          decoration: const BoxDecoration(
            color: cInkDeep,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
          ),
          child: const Text(
            'TimePickerDialog parameter reference',
            style: TextStyle(
              color: cParchment,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        refRow(
          'initialTime',
          'TimeOfDay',
          'required',
          'Time to display when the dialog first opens.',
        ),
        refRow(
          'helpText',
          'String?',
          'null',
          'Header label, e.g. "Select time".',
        ),
        refRow(
          'cancelText',
          'String?',
          'null',
          'Override for the cancel button label.',
        ),
        refRow(
          'confirmText',
          'String?',
          'null',
          'Override for the confirm button label.',
        ),
        refRow(
          'errorInvalidText',
          'String?',
          'null',
          'Shown when input mode parses an out-of-range value.',
        ),
        refRow(
          'hourLabelText',
          'String?',
          'null',
          'Label above the hour text field in input mode.',
        ),
        refRow(
          'minuteLabelText',
          'String?',
          'null',
          'Label above the minute text field in input mode.',
        ),
        refRow(
          'restorationId',
          'String?',
          'null',
          'Enables state restoration across app restarts.',
        ),
        refRow(
          'initialEntryMode',
          'TimePickerEntryMode',
          'dial',
          'dial / input / dialOnly / inputOnly.',
        ),
        refRow(
          'orientation',
          'Orientation?',
          'null',
          'Force portrait or landscape layout.',
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 10: Edge-case strip.
  // ---------------------------------------------------------------------------
  Widget edgeChip(String title, TimeOfDay tod, Color tint) {
    return Container(
      width: 180,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: cInkDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: tint,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${tod.hour.toString().padLeft(2, '0')}:'
            '${tod.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(
              color: cParchment,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'period: ${tod.period}',
            style: TextStyle(
              color: cParchment.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  final Widget edgeStrip = Wrap(
    alignment: WrapAlignment.center,
    children: [
      edgeChip(
        'MIDNIGHT',
        const TimeOfDay(hour: 0, minute: 0),
        cVioletDawn,
      ),
      edgeChip('NOON', const TimeOfDay(hour: 12, minute: 0), cBrass),
      edgeChip(
        '23:59',
        const TimeOfDay(hour: 23, minute: 59),
        cCoral,
      ),
      edgeChip(
        'REPLACE MINUTE',
        const TimeOfDay(hour: 9, minute: 15).replacing(minute: 45),
        cTeal,
      ),
      edgeChip(
        'REPLACE HOUR',
        const TimeOfDay(hour: 9, minute: 15).replacing(hour: 22),
        cMintTwilight,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // SECTION 11: Footer.
  // ---------------------------------------------------------------------------
  final Widget footer = Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(20, 24, 20, 28),
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [cInkMid, cInkDeep],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cBrass.withValues(alpha: 0.6), width: 1.2),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, color: cBrass, size: 20),
            const SizedBox(width: 8),
            const Text(
              'End of TimePickerDialog deep dive',
              style: TextStyle(
                color: cParchment,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Static demo only. In a live app, prefer showTimePicker so the '
          'framework wires modal routing, focus and a11y for you.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: cParchment.withValues(alpha: 0.78),
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('TimePickerDialog deep visual demo: assembled');

  // Print a few diagnostics that exercise the dart:ui import.
  final ui.TextDirection dir = ui.TextDirection.ltr;
  print('text direction: $dir');
  final double diagAngle = math.pi / 4;
  print('diagAngle (math.pi/4): $diagAngle');

  return Scaffold(
    backgroundColor: cInkDeep,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          hero,
          sectionTitle(
            '1',
            'TimePickerDialog gallery',
            'Real instances at multiple initialTime + initialEntryMode values',
            cBrass,
          ),
          gallery,
          sectionTitle(
            '2',
            'Custom analog clock face',
            'CustomPaint - 12 hour markers and a fixed-time hand pair',
            cTeal,
          ),
          clockSection,
          sectionTitle(
            '3',
            'Digital readouts',
            'TimeOfDay rendered as stylised digital displays',
            cVioletDawn,
          ),
          digitalGallery,
          sectionTitle(
            '4',
            'TimePickerEntryMode',
            'Mock illustrations of dial / input / dialOnly / inputOnly',
            cCoral,
          ),
          entryModeGallery,
          sectionTitle(
            '5',
            'TimeOfDay arithmetic',
            'replacing(), period, periodOffset, equality, format(context)',
            cMintTwilight,
          ),
          todSection,
          sectionTitle(
            '6',
            'TimePickerThemeData mock',
            'Four palette overrides, each painting a faux dialog',
            cBrassBright,
          ),
          themeGallery,
          sectionTitle(
            '7',
            'showTimePicker code',
            'How a real app wires the dialog with await and a builder',
            cTeal,
          ),
          codeCard(
            'await showTimePicker(...)',
            codeShowTimePicker,
            cTeal,
          ),
          codeCard(
            'showDialog<TimeOfDay>(...)',
            codeDialogDirect,
            cVioletDawn,
          ),
          sectionTitle(
            '8',
            'Parameter reference',
            'TimePickerDialog constructor parameters with defaults',
            cBrass,
          ),
          refTable,
          sectionTitle(
            '9',
            'Edge cases',
            'Midnight, noon, 23:59 and replacing single fields',
            cCoral,
          ),
          edgeStrip,
          footer,
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// CustomPainter classes - top-level so build() stays single-function.
// ---------------------------------------------------------------------------

class _ClockFacePainter extends CustomPainter {
  _ClockFacePainter({
    required this.ringColor,
    required this.hubColor,
    required this.markerColor,
    required this.handHourColor,
    required this.handMinuteColor,
    required this.background,
    required this.hour,
    required this.minute,
    required this.is24Hour,
  });

  final Color ringColor;
  final Color hubColor;
  final Color markerColor;
  final Color handHourColor;
  final Color handMinuteColor;
  final Color background;
  final int hour;
  final int minute;
  final bool is24Hour;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 6;

    // Disc.
    final Paint discPaint = Paint()..color = background;
    canvas.drawCircle(center, radius, discPaint);

    // Outer ring.
    final Paint ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, ringPaint);

    // Markers - index based loop, no for-in over bridged data.
    final int markerCount = is24Hour ? 24 : 12;
    for (int i = 0; i < markerCount; i++) {
      final double angle = (i / markerCount) * 2 * math.pi - math.pi / 2;
      final double r1 = radius - 4;
      final double r2 = radius - (i % (is24Hour ? 6 : 3) == 0 ? 18 : 10);
      final Offset p1 = center + Offset(math.cos(angle) * r1, math.sin(angle) * r1);
      final Offset p2 = center + Offset(math.cos(angle) * r2, math.sin(angle) * r2);
      final Paint markerPaint = Paint()
        ..color = markerColor
        ..strokeWidth = i % (is24Hour ? 6 : 3) == 0 ? 2.4 : 1.2;
      canvas.drawLine(p1, p2, markerPaint);
    }

    // Hour numbers (12-hour face only).
    if (!is24Hour) {
      for (int i = 1; i <= 12; i++) {
        final double angle = (i / 12.0) * 2 * math.pi - math.pi / 2;
        final double r = radius - 30;
        final Offset p = center + Offset(math.cos(angle) * r, math.sin(angle) * r);
        final TextPainter tp = TextPainter(
          text: TextSpan(
            text: '$i',
            style: TextStyle(
              color: markerColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(canvas, p - Offset(tp.width / 2, tp.height / 2));
      }
    }

    // Minute hand.
    final double minuteAngle = (minute / 60.0) * 2 * math.pi - math.pi / 2;
    final Paint minutePaint = Paint()
      ..color = handMinuteColor
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      center +
          Offset(
            math.cos(minuteAngle) * (radius - 16),
            math.sin(minuteAngle) * (radius - 16),
          ),
      minutePaint,
    );

    // Hour hand.
    final int displayHour = is24Hour ? hour : hour % 12;
    final double hourAngle =
        ((displayHour + minute / 60.0) / (is24Hour ? 24.0 : 12.0)) *
                2 *
                math.pi -
            math.pi / 2;
    final Paint hourPaint = Paint()
      ..color = handHourColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      center +
          Offset(
            math.cos(hourAngle) * (radius - 36),
            math.sin(hourAngle) * (radius - 36),
          ),
      hourPaint,
    );

    // Hub.
    final Paint hubPaint = Paint()..color = hubColor;
    canvas.drawCircle(center, 5.5, hubPaint);
    final Paint hubRing = Paint()
      ..color = handHourColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawCircle(center, 5.5, hubRing);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _MiniDialPainter extends CustomPainter {
  _MiniDialPainter({
    required this.ringColor,
    required this.handColor,
    required this.tickColor,
  });

  final Color ringColor;
  final Color handColor;
  final Color tickColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 4;

    final Paint ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, ringPaint);

    for (int i = 0; i < 12; i++) {
      final double angle = (i / 12.0) * 2 * math.pi - math.pi / 2;
      final Offset p1 = center +
          Offset(math.cos(angle) * (radius - 2), math.sin(angle) * (radius - 2));
      final Offset p2 = center +
          Offset(math.cos(angle) * (radius - 8), math.sin(angle) * (radius - 8));
      final Paint tickPaint = Paint()
        ..color = tickColor
        ..strokeWidth = i % 3 == 0 ? 2 : 1;
      canvas.drawLine(p1, p2, tickPaint);
    }

    final Paint handPaint = Paint()
      ..color = handColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final double handAngle = -math.pi / 3;
    canvas.drawLine(
      center,
      center +
          Offset(
            math.cos(handAngle) * (radius - 14),
            math.sin(handAngle) * (radius - 14),
          ),
      handPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
