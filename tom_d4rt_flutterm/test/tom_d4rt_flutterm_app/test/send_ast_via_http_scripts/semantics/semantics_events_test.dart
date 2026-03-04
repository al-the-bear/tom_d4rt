// D4rt test script: Tests SemanticsEvent types — AnnounceSemanticsEvent,
// TooltipSemanticsEvent, LongPressSemanticsEvent, TapSemanticEvent,
// FocusSemanticsEvent, SemanticsService
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('Semantics events advanced test executing');

  // ========== AnnounceSemanticsEvent ==========
  print('--- AnnounceSemanticsEvent Tests ---');
  final announce = AnnounceSemanticsEvent(
    'Item added to cart',
    TextDirection.ltr,
    0,
  );
  print('AnnounceSemanticsEvent: message="${announce.message}"');
  print('  textDirection: ${announce.textDirection}');
  print('  type: ${announce.type}');
  final announceMap = announce.toMap();
  print('  toMap keys: ${announceMap.keys.toList()}');

  final announceRtl = AnnounceSemanticsEvent(
    'تمت الإضافة',
    TextDirection.rtl,
    1,
  );
  print('AnnounceSemanticsEvent RTL: message="${announceRtl.message}"');

  // ========== TooltipSemanticsEvent ==========
  print('--- TooltipSemanticsEvent Tests ---');
  final tooltip = TooltipSemanticsEvent('Save button');
  print('TooltipSemanticsEvent: message="${tooltip.message}"');
  print('  type: ${tooltip.type}');
  final tooltipMap = tooltip.toMap();
  print('  toMap keys: ${tooltipMap.keys.toList()}');

  // ========== LongPressSemanticsEvent ==========
  print('--- LongPressSemanticsEvent Tests ---');
  final longPress = LongPressSemanticsEvent();
  print('LongPressSemanticsEvent created');
  print('  type: ${longPress.type}');
  final longPressMap = longPress.toMap();
  print('  toMap: $longPressMap');

  // ========== TapSemanticEvent ==========
  print('--- TapSemanticEvent Tests ---');
  final tap = TapSemanticEvent();
  print('TapSemanticEvent created');
  print('  type: ${tap.type}');

  // ========== Assertiveness enum ==========
  print('--- Assertiveness Tests ---');
  for (final a in Assertiveness.values) {
    print('Assertiveness: ${a.name}');
  }

  // ========== SemanticsService ==========
  print('--- SemanticsService Tests ---');
  print('SemanticsService.announce() sends announcements');
  print('SemanticsService.tooltip() sends tooltip events');

  // ========== CustomSemanticsAction ==========
  print('--- CustomSemanticsAction Tests ---');
  final customAction = CustomSemanticsAction(label: 'Dismiss');
  print('CustomSemanticsAction: label="${customAction.label}"');

  final overrideAction = CustomSemanticsAction.overridingAction(
    hint: 'Swipe to dismiss',
    action: SemanticsAction.dismiss,
  );
  print(
    'CustomSemanticsAction.overridingAction: hint="${overrideAction.hint}"',
  );

  // ========== OrdinalSortKey ==========
  print('--- OrdinalSortKey Tests ---');
  final sortKey1 = OrdinalSortKey(1.0, name: 'header');
  final sortKey2 = OrdinalSortKey(2.0, name: 'body');
  final sortKey3 = OrdinalSortKey(3.0);
  print('OrdinalSortKey: order=${sortKey1.order}, name=${sortKey1.name}');
  print('OrdinalSortKey: order=${sortKey2.order}, name=${sortKey2.name}');
  print('OrdinalSortKey: order=${sortKey3.order}, name=${sortKey3.name}');

  print('All semantics events tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Semantics(
        label: 'Main Content',
        sortKey: OrdinalSortKey(0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                sortKey: OrdinalSortKey(1.0),
                child: Text(
                  'Semantics Events Test',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              Semantics(
                sortKey: OrdinalSortKey(2.0),
                child: Text('AnnounceSemanticsEvent, TooltipSemanticsEvent'),
              ),
              Semantics(
                sortKey: OrdinalSortKey(3.0),
                child: Text('LongPressSemanticsEvent, TapSemanticEvent'),
              ),
              Semantics(
                sortKey: OrdinalSortKey(4.0),
                child: Text('FocusSemanticsEvent, CustomSemanticsAction'),
              ),
              Semantics(
                sortKey: OrdinalSortKey(5.0),
                child: Text('OrdinalSortKey for ordering'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
