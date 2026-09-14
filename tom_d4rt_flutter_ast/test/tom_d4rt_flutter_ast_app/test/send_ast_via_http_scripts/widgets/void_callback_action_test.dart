// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable
// D4rt test script: Deep Demo — VoidCallbackAction
//
// VoidCallbackAction is the tiny but powerful Flutter Action<VoidCallbackIntent>
// that simply invokes the callback carried by a VoidCallbackIntent. In SDK
// source (flutter/lib/src/widgets/actions.dart):
//
//   class VoidCallbackIntent extends Intent {
//     const VoidCallbackIntent(this.callback);
//     final VoidCallback callback;
//   }
//
//   class VoidCallbackAction extends Action<VoidCallbackIntent> {
//     @override
//     Object? invoke(VoidCallbackIntent intent) {
//       intent.callback();
//       return null;
//     }
//   }
//
// This demo reimagines the Actions/Intents machinery as an executive boardroom
// — mahogany panels, brass rims, red leather fire buttons, cream paper log
// tape printed in gold foil. Across several scenarios we wire up
// VoidCallbackAction in different scopes, fire VoidCallbackIntents from
// buttons, keyboard shortcuts, and programmatic sources, visualise the
// disabled/enabled state of a custom subclass, and compose multiple subtrees
// to show how Actions scoping routes intents to the nearest handler.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('VoidCallbackAction Deep Demo executing');

  // =========================================================================
  // Palette — executive boardroom. Mahogany, brass, oxblood red, cream paper,
  // gold foil. Every colour is named so the demo is self-documenting.
  // =========================================================================
  final Color mahoganyDeep = const Color(0xFF4A1C0E);
  final Color mahoganyMid = const Color(0xFF6B2A12);
  final Color mahoganyLight = const Color(0xFF8B3A1E);
  final Color mahoganyGrain = const Color(0xFF3A1508);
  final Color brassBright = const Color(0xFFD4A942);
  final Color brassMid = const Color(0xFFB8912E);
  final Color brassDim = const Color(0xFF8C6A20);
  final Color redLeather = const Color(0xFF8B1A1A);
  final Color redLeatherHi = const Color(0xFFB83838);
  final Color redLeatherLo = const Color(0xFF5A0E0E);
  final Color creamPaper = const Color(0xFFF5ECD7);
  final Color creamPaperShade = const Color(0xFFE8DCC0);
  final Color inkBrown = const Color(0xFF2E1A0A);
  final Color goldFoil = const Color(0xFFC9A244);
  final Color feltGreen = const Color(0xFF1F3A2B);
  final Color feltGreenHi = const Color(0xFF2E5740);
  final Color ivoryBone = const Color(0xFFF3E9D2);
  final Color shadowSoft = const Color(0x552E1A0A);

  print('  Palette prepared: mahogany, brass, red leather, cream paper');

  // =========================================================================
  // SECTION 1 — Preamble anatomy
  // =========================================================================
  print('=== Section 1: Preamble anatomy ===');

  final preambleFacts = <Map<String, dynamic>>[
    {
      'icon': Icons.flash_on,
      'title': 'What VoidCallbackAction is',
      'body': 'VoidCallbackAction extends Action<VoidCallbackIntent>. Its '
          'sole override is invoke(VoidCallbackIntent intent) { '
          'intent.callback(); return null; }. That is the entire '
          'implementation. The action is a universal adapter that '
          'lets any subtree fire any void callback via the Actions '
          'dispatch system.',
      'ribbon': 'adapter',
    },
    {
      'icon': Icons.inventory_2,
      'title': 'The intent carries the payload',
      'body': 'Unlike CallbackAction (where the callback is configured on '
          'the Action), VoidCallbackIntent carries the callback itself. '
          'Each intent instance holds its own VoidCallback, so the '
          'action stays stateless and reusable while every firing '
          'site supplies the exact behaviour it wants executed.',
      'ribbon': 'payload',
    },
    {
      'icon': Icons.account_tree,
      'title': 'Where it fits in Actions/Intents',
      'body': 'Shortcuts map a KeyActivator to an Intent. Actions map an '
          'Intent type to an Action instance. When the intent is '
          'dispatched, the framework walks up the tree, finds the '
          'nearest enabled Action<VoidCallbackIntent>, and calls '
          'invoke. VoidCallbackAction is usually that handler.',
      'ribbon': 'routing',
    },
    {
      'icon': Icons.checklist,
      'title': 'When to reach for it',
      'body': 'Use VoidCallbackAction whenever you want to wire a named '
          'intent (from menus, shortcuts, programmatic Actions.invoke '
          'calls) to a local closure that captures state. It is the '
          'go-to for dialog dismissals, form submissions, command '
          'palettes, and anywhere keyboard shortcuts need to run '
          'already-written void callbacks.',
      'ribbon': 'recipe',
    },
  ];

  print('  Prepared ${preambleFacts.length} preamble cards');

  final preambleCards = <Widget>[];
  for (int i = 0; i < preambleFacts.length; i++) {
    final fact = preambleFacts[i];
    preambleCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: creamPaper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: brassMid, width: 2),
          boxShadow: [
            BoxShadow(
              color: shadowSoft,
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: mahoganyMid,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: brassBright,
                      shape: BoxShape.circle,
                      border: Border.all(color: brassDim, width: 1),
                    ),
                    child: Icon(
                      fact['icon'] as IconData,
                      size: 20,
                      color: mahoganyDeep,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      fact['title'] as String,
                      style: TextStyle(
                        color: goldFoil,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: redLeather,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: brassBright, width: 1),
                    ),
                    child: Text(
                      (fact['ribbon'] as String).toUpperCase(),
                      style: TextStyle(
                        color: ivoryBone,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                fact['body'] as String,
                style: TextStyle(
                  color: inkBrown,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // SECTION 2 — Executive dashboard (the big red fire button)
  // =========================================================================
  print('=== Section 2: Executive dashboard ===');

  final dashboardStats = <Map<String, dynamic>>[
    {'label': 'Fires routed', 'value': '147', 'tint': brassBright},
    {'label': 'Avg latency', 'value': '0.3 ms', 'tint': creamPaper},
    {'label': 'Active scopes', 'value': '4', 'tint': brassDim},
    {'label': 'Muted actions', 'value': '1', 'tint': redLeatherHi},
  ];

  final dashboardChips = dashboardStats.map<Widget>((stat) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: mahoganyGrain,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: brassMid, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            stat['value'] as String,
            style: TextStyle(
              color: stat['tint'] as Color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            (stat['label'] as String).toUpperCase(),
            style: TextStyle(
              color: goldFoil,
              fontSize: 9,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }).toList();

  Widget fireButton() {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [redLeatherHi, redLeather, redLeatherLo],
          stops: const [0.0, 0.6, 1.0],
        ),
        border: Border.all(color: brassBright, width: 6),
        boxShadow: [
          BoxShadow(
            color: redLeatherLo.withOpacity(0.8),
            blurRadius: 24,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: shadowSoft,
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: brassDim, width: 2),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bolt, color: ivoryBone, size: 54),
              const SizedBox(height: 4),
              Text(
                'FIRE',
                style: TextStyle(
                  color: ivoryBone,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'VoidCallbackIntent',
                style: TextStyle(
                  color: brassBright,
                  fontSize: 10,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final dashboardPanel = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [mahoganyDeep, mahoganyMid, mahoganyLight, mahoganyMid],
        stops: const [0.0, 0.4, 0.7, 1.0],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassBright, width: 3),
      boxShadow: [
        BoxShadow(
          color: shadowSoft,
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: brassBright,
                shape: BoxShape.circle,
                border: Border.all(color: brassDim, width: 2),
              ),
              child: Icon(Icons.dashboard, color: mahoganyDeep, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Executive Dashboard',
                    style: TextStyle(
                      color: goldFoil,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    'Actions.maybeInvoke<VoidCallbackIntent>(ctx, VoidCallbackIntent(...))',
                    style: TextStyle(
                      color: creamPaperShade,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: feltGreen,
                border: Border.all(color: brassMid, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'ROUTER ONLINE',
                    style: TextStyle(
                      color: ivoryBone,
                      fontSize: 10,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dashboardChips,
        ),
        const SizedBox(height: 22),
        Center(child: fireButton()),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mahoganyGrain,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: brassDim, width: 1),
          ),
          child: Text(
            'Tapping this button calls Actions.maybeInvoke with a fresh '
            'VoidCallbackIntent that carries a closure over counter++. The '
            'nearest VoidCallbackAction in the ancestor Actions scope receives '
            'the intent and invokes the callback. Because the action is '
            'stateless, every button in the app can share it.',
            style: TextStyle(
              color: creamPaper,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 3 — Log tape of fires
  // =========================================================================
  print('=== Section 3: Log tape of fires ===');

  final tapeLines = <Map<String, String>>[
    {
      'ts': '09:14:02.118',
      'label': 'openAnnualReport',
      'origin': 'fire-button',
      'result': 'ok'
    },
    {
      'ts': '09:14:05.443',
      'label': 'toggleSidebar',
      'origin': 'shortcut-⌘B',
      'result': 'ok'
    },
    {
      'ts': '09:14:07.972',
      'label': 'dismissDialog',
      'origin': 'shortcut-Esc',
      'result': 'ok'
    },
    {
      'ts': '09:14:11.205',
      'label': 'submitQuarterly',
      'origin': 'menu-item',
      'result': 'ok'
    },
    {
      'ts': '09:14:14.610',
      'label': 'restartInference',
      'origin': 'programmatic',
      'result': 'ok'
    },
    {
      'ts': '09:14:17.081',
      'label': 'lockConsole',
      'origin': 'shortcut-⌘L',
      'result': 'muted'
    },
    {
      'ts': '09:14:19.992',
      'label': 'openAnnualReport',
      'origin': 'fire-button',
      'result': 'ok'
    },
    {
      'ts': '09:14:24.301',
      'label': 'exportBoardDeck',
      'origin': 'dropdown-pick',
      'result': 'ok'
    },
    {
      'ts': '09:14:27.810',
      'label': 'rotateCeremony',
      'origin': 'Enter-key',
      'result': 'ok'
    },
    {
      'ts': '09:14:31.544',
      'label': 'closeMeeting',
      'origin': 'fire-button',
      'result': 'ok'
    },
  ];

  print('  Assembled ${tapeLines.length} tape lines');

  final tapeRows = <Widget>[];
  for (int i = 0; i < tapeLines.length; i++) {
    final line = tapeLines[i];
    final bool muted = line['result'] == 'muted';
    tapeRows.add(
      Container(
        decoration: BoxDecoration(
          color: i.isEven ? creamPaper : creamPaperShade,
          border: Border(
            bottom: BorderSide(color: brassDim.withOpacity(0.4), width: 0.8),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: muted ? redLeather : goldFoil,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 110,
              child: Text(
                line['ts']!,
                style: TextStyle(
                  color: inkBrown,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                line['label']!,
                style: TextStyle(
                  color: muted ? redLeatherLo : inkBrown,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  decoration: muted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                line['origin']!,
                style: TextStyle(
                  color: mahoganyMid,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: muted ? redLeather : feltGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                muted ? 'MUTED' : 'FIRED',
                style: TextStyle(
                  color: ivoryBone,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final logTapePanel = Container(
    margin: const EdgeInsets.only(bottom: 18),
    decoration: BoxDecoration(
      color: creamPaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassBright, width: 3),
      boxShadow: [
        BoxShadow(
          color: shadowSoft,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: mahoganyDeep,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.receipt_long, color: goldFoil, size: 22),
              const SizedBox(width: 10),
              Text(
                'Log Tape — VoidCallbackIntent fires',
                style: TextStyle(
                  color: goldFoil,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              const Spacer(),
              Text(
                'gold foil · cream bond',
                style: TextStyle(
                  color: creamPaperShade,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: mahoganyGrain,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                child: Text(
                  '·',
                  style: TextStyle(color: brassBright, fontSize: 12),
                ),
              ),
              SizedBox(
                width: 110,
                child: Text(
                  'timestamp',
                  style: TextStyle(
                    color: brassBright,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'callback label',
                  style: TextStyle(
                    color: brassBright,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'origin trigger',
                  style: TextStyle(
                    color: brassBright,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              Text(
                'state',
                style: TextStyle(
                  color: brassBright,
                  fontSize: 10,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
        ...tapeRows,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: creamPaperShade,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(9),
              bottomRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: mahoganyMid, size: 14),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Each row is one invoke(VoidCallbackIntent) call. Muted '
                  'rows came from a disabled subclass that refused the '
                  'intent.',
                  style: TextStyle(
                    color: inkBrown,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 4 — Keyboard shortcut binding
  // =========================================================================
  print('=== Section 4: Keyboard shortcut binding ===');

  final shortcutRows = <Map<String, dynamic>>[
    {
      'keys': 'Enter',
      'intent': 'VoidCallbackIntent(submitForm)',
      'desc': 'Submit the annual report draft to the board review queue.',
      'active': true,
    },
    {
      'keys': 'Ctrl + Enter',
      'intent': 'VoidCallbackIntent(submitAndSign)',
      'desc': 'Submit and co-sign with the auditor token.',
      'active': true,
    },
    {
      'keys': 'Esc',
      'intent': 'VoidCallbackIntent(dismissDialog)',
      'desc': 'Close the currently open dismissable dialog.',
      'active': true,
    },
    {
      'keys': '⌘ K',
      'intent': 'VoidCallbackIntent(openCommandPalette)',
      'desc': 'Summon the command palette and focus the search box.',
      'active': true,
    },
    {
      'keys': '⌘ L',
      'intent': 'VoidCallbackIntent(lockConsole)',
      'desc': 'Disabled: isEnabled returns false when no session is active.',
      'active': false,
    },
  ];

  final shortcutCards = <Widget>[];
  for (int i = 0; i < shortcutRows.length; i++) {
    final row = shortcutRows[i];
    final bool active = row['active'] as bool;
    shortcutCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? creamPaper : creamPaperShade,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active ? brassMid : redLeather.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 90,
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: active ? mahoganyDeep : mahoganyGrain.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: active ? brassBright : brassDim,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowSoft,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  row['keys'] as String,
                  style: TextStyle(
                    color: active ? goldFoil : brassDim,
                    fontSize: 13,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row['intent'] as String,
                    style: TextStyle(
                      color: active ? inkBrown : redLeatherLo,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    row['desc'] as String,
                    style: TextStyle(
                      color: active ? inkBrown : redLeatherLo.withOpacity(0.8),
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: active ? feltGreen : redLeather,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                active ? 'ENABLED' : 'DISABLED',
                style: TextStyle(
                  color: ivoryBone,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build an actually-wired Shortcuts/Actions scope so the Flutter framework
  // itself is exercised. The Shortcuts widget maps the Enter key to a
  // VoidCallbackIntent carrying a print callback. VoidCallbackAction invokes
  // that callback when the focused child receives the key.
  final liveShortcutScope = Shortcuts(
    shortcuts: <ShortcutActivator, Intent>{
      const SingleActivator(LogicalKeyboardKey.enter): VoidCallbackIntent(() {
        print('[shortcut] Enter fired -> submitDraft() dispatched');
      }),
    },
    child: Actions(
      actions: <Type, Action<Intent>>{
        VoidCallbackIntent: VoidCallbackAction(),
      },
      child: Focus(
        autofocus: false,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: feltGreen,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: brassBright, width: 2),
          ),
          child: Row(
            children: [
              Icon(Icons.keyboard_return, color: brassBright, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Focused keyboard region',
                      style: TextStyle(
                        color: goldFoil,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Pressing Enter dispatches VoidCallbackIntent → '
                      'VoidCallbackAction.invoke() → print.',
                      style: TextStyle(
                        color: creamPaperShade,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  final shortcutPanel = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: mahoganyMid,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassBright, width: 3),
      boxShadow: [
        BoxShadow(
          color: shadowSoft,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard, color: goldFoil, size: 26),
            const SizedBox(width: 10),
            Text(
              'Keyboard Shortcut Binding',
              style: TextStyle(
                color: goldFoil,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: mahoganyDeep,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: brassMid, width: 1),
              ),
              child: Text(
                'Shortcuts → Actions',
                style: TextStyle(
                  color: creamPaperShade,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Each row describes a SingleActivator mapped to a '
          'VoidCallbackIntent. The surrounding Actions scope binds '
          'VoidCallbackIntent to a single VoidCallbackAction instance, so '
          'every shortcut can share it.',
          style: TextStyle(
            color: creamPaper,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        ...shortcutCards,
        const SizedBox(height: 6),
        liveShortcutScope,
      ],
    ),
  );

  // =========================================================================
  // SECTION 5 — Composition demo: scoped subtrees
  // =========================================================================
  print('=== Section 5: Composition — scoped subtrees ===');

  final scopeDefinitions = <Map<String, dynamic>>[
    {
      'name': 'Boardroom',
      'icon': Icons.meeting_room,
      'color': mahoganyDeep,
      'accent': goldFoil,
      'actionName': 'BoardroomVoidCallbackAction',
      'handled': 'openAnnualReport · dismissAgenda',
      'note': 'Nearest handler for intents fired from seats #1-#12.',
    },
    {
      'name': 'Auditor Booth',
      'icon': Icons.verified_user,
      'color': feltGreenHi,
      'accent': brassBright,
      'actionName': 'AuditorVoidCallbackAction',
      'handled': 'signLedger · stampReceipt',
      'note': 'Actions scope wraps only the auditor panel; intents fired '
          'elsewhere never reach this action.',
    },
    {
      'name': 'Visitor Gallery',
      'icon': Icons.chair,
      'color': mahoganyLight,
      'accent': creamPaper,
      'actionName': 'GalleryVoidCallbackAction',
      'handled': 'requestMinutes · waveToSpeaker',
      'note': 'Gallery subtree has its own VoidCallbackAction — visitors '
          'cannot reach boardroom callbacks.',
    },
    {
      'name': 'Central Router (root)',
      'icon': Icons.hub,
      'color': mahoganyGrain,
      'accent': brassBright,
      'actionName': 'VoidCallbackAction (shared default)',
      'handled': 'fallback for any unhandled VoidCallbackIntent',
      'note': 'Only reached when no nearer Actions scope claims the '
          'intent type.',
    },
  ];

  final scopeCards = <Widget>[];
  for (int i = 0; i < scopeDefinitions.length; i++) {
    final scope = scopeDefinitions[i];
    scopeCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: scope['color'] as Color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: brassMid, width: 2),
          boxShadow: [
            BoxShadow(
              color: shadowSoft,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: scope['accent'] as Color,
                borderRadius: BorderRadius.circular(21),
                border: Border.all(color: brassDim, width: 1),
              ),
              child: Icon(
                scope['icon'] as IconData,
                color: mahoganyDeep,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        scope['name'] as String,
                        style: TextStyle(
                          color: scope['accent'] as Color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: mahoganyDeep,
                          borderRadius: BorderRadius.circular(4),
                          border:
                              Border.all(color: brassDim, width: 0.8),
                        ),
                        child: Text(
                          'Actions scope',
                          style: TextStyle(
                            color: creamPaperShade,
                            fontSize: 9,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    scope['actionName'] as String,
                    style: TextStyle(
                      color: creamPaperShade,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Handles: ${scope['handled']}',
                    style: TextStyle(
                      color: creamPaper,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    scope['note'] as String,
                    style: TextStyle(
                      color: creamPaperShade,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final compositionPanel = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: mahoganyDeep,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassBright, width: 3),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_outlined,
                color: goldFoil, size: 28),
            const SizedBox(width: 10),
            Text(
              'Composition — Scoped Subtrees',
              style: TextStyle(
                color: goldFoil,
                fontSize: 21,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'An Actions widget registers an Action for a particular Intent '
          'type scoped to its subtree. When a VoidCallbackIntent is '
          'dispatched, Flutter walks up the tree and invokes the first '
          'VoidCallbackAction it finds. This lets different boardroom '
          'zones respond to the same intent type in their own way.',
          style: TextStyle(
            color: creamPaper,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        ...scopeCards,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mahoganyGrain,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: brassDim, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dispatch walk order',
                style: TextStyle(
                  color: goldFoil,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Focused widget → nearest Actions ancestor → walks up → '
                'first Actions scope that maps VoidCallbackIntent handles '
                'it → if isEnabled returns false, keep walking → root '
                'router catches anything unclaimed.',
                style: TextStyle(
                  color: creamPaper,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 6 — Disabled / enabled via custom subclass
  // =========================================================================
  print('=== Section 6: Disabled/Enabled via custom subclass ===');

  final gateDefinitions = <Map<String, dynamic>>[
    {
      'label': 'approveMotion',
      'enabled': true,
      'reason': 'Quorum met, chair seated, no conflicts.',
      'count': 14,
    },
    {
      'label': 'escalateBreach',
      'enabled': true,
      'reason': 'Auditor present, escalation window open.',
      'count': 3,
    },
    {
      'label': 'lockConsole',
      'enabled': false,
      'reason': 'No active session — isEnabled returned false.',
      'count': 0,
    },
    {
      'label': 'fireRotation',
      'enabled': false,
      'reason': 'Disabled outside of ceremonial window (Thu 14:00).',
      'count': 0,
    },
    {
      'label': 'signProtocol',
      'enabled': true,
      'reason': 'Token valid for another 23 minutes.',
      'count': 7,
    },
  ];

  final gateCards = <Widget>[];
  for (int i = 0; i < gateDefinitions.length; i++) {
    final gate = gateDefinitions[i];
    final bool enabled = gate['enabled'] as bool;
    gateCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: enabled ? creamPaper : creamPaperShade,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: enabled ? brassMid : redLeather,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: enabled ? feltGreen : redLeather,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    enabled ? Icons.check_circle : Icons.block,
                    color: ivoryBone,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    gate['label'] as String,
                    style: TextStyle(
                      color: ivoryBone,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'fires: ${gate['count']}',
                    style: TextStyle(
                      color: ivoryBone,
                      fontSize: 11,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: enabled ? mahoganyMid : redLeather,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      gate['reason'] as String,
                      style: TextStyle(
                        color: enabled ? inkBrown : redLeatherLo,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Illustrative button row — shows what the enable/disable visually looks
  // like when a subclass overrides isEnabled.
  Widget disableDial(String label, bool enabled) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: enabled ? redLeather : redLeather.withOpacity(0.35),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: enabled ? brassBright : brassDim,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              enabled ? Icons.power_settings_new : Icons.power_off,
              color: enabled ? ivoryBone : creamPaperShade.withOpacity(0.5),
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: enabled ? ivoryBone : creamPaperShade.withOpacity(0.6),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              enabled ? 'ready' : 'refused',
              style: TextStyle(
                color: enabled ? brassBright : creamPaperShade.withOpacity(0.4),
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final gatePanel = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: mahoganyLight,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassBright, width: 3),
      boxShadow: [
        BoxShadow(
          color: shadowSoft,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.toggle_on_outlined, color: goldFoil, size: 28),
            const SizedBox(width: 10),
            Text(
              'Disabled / Enabled — subclass override',
              style: TextStyle(
                color: goldFoil,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mahoganyGrain,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: brassDim, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'class GatedVoidCallbackAction extends VoidCallbackAction {',
                style: TextStyle(
                  color: creamPaper,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '  GatedVoidCallbackAction(this.gate);',
                style: TextStyle(
                  color: creamPaper,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '  final bool Function() gate;',
                style: TextStyle(
                  color: creamPaper,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '  @override bool isEnabled(VoidCallbackIntent _) => gate();',
                style: TextStyle(
                  color: goldFoil,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '}',
                style: TextStyle(
                  color: creamPaper,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            disableDial('approveMotion', true),
            disableDial('lockConsole', false),
            disableDial('signProtocol', true),
            disableDial('fireRotation', false),
          ],
        ),
        const SizedBox(height: 16),
        ...gateCards,
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: feltGreen,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: brassMid, width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: goldFoil, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'When isEnabled returns false, the framework walks past '
                  'this action to the next ancestor. Buttons wired via '
                  'Actions.maybeInvoke reflect this by rendering as '
                  'disabled until a higher-up handler exists.',
                  style: TextStyle(
                    color: creamPaper,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 7 — Interactive controls (static snapshot)
  // =========================================================================
  print('=== Section 7: Interactive controls ===');

  final intentLabelChoices = <String>[
    'openAnnualReport',
    'dismissDialog',
    'submitQuarterly',
    'rotateCeremony',
    'restartInference',
    'lockConsole',
    'exportBoardDeck',
  ];

  final intentDropdownRows = <Widget>[];
  for (int i = 0; i < intentLabelChoices.length; i++) {
    final bool selected = i == 2;
    intentDropdownRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? goldFoil.withOpacity(0.25)
              : (i.isEven ? creamPaper : creamPaperShade),
          border: Border(
            bottom: BorderSide(color: brassDim.withOpacity(0.5), width: 0.8),
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? redLeather : mahoganyMid,
              size: 16,
            ),
            const SizedBox(width: 10),
            Text(
              intentLabelChoices[i],
              style: TextStyle(
                color: inkBrown,
                fontSize: 13,
                fontFamily: 'monospace',
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (selected)
              Text(
                'selected',
                style: TextStyle(
                  color: redLeather,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget switchTile(String label, String sub, bool on) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: creamPaper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: brassMid, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 26,
            decoration: BoxDecoration(
              color: on ? feltGreen : mahoganyGrain,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: brassMid, width: 1),
            ),
            child: Align(
              alignment: on ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: brassBright,
                  shape: BoxShape.circle,
                  border: Border.all(color: brassDim, width: 0.8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: inkBrown,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(
                    color: inkBrown.withOpacity(0.75),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: on ? feltGreen : redLeather,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              on ? 'ON' : 'OFF',
              style: TextStyle(
                color: ivoryBone,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final interactivePanel = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: mahoganyMid,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassBright, width: 3),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: goldFoil, size: 26),
            const SizedBox(width: 10),
            Text(
              'Interactive Controls',
              style: TextStyle(
                color: goldFoil,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'In the live app these controls mutate the VoidCallbackAction '
          'wiring: the switch flips isEnabled; the dropdown selects which '
          'label is carried by the next VoidCallbackIntent; the keyboard '
          'area shows the active SingleActivator binding.',
          style: TextStyle(
            color: creamPaper,
            fontSize: 12,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        switchTile(
          'GatedVoidCallbackAction.isEnabled',
          'When OFF, the action refuses VoidCallbackIntents and the big '
              'red button renders greyed out.',
          true,
        ),
        switchTile(
          'Log tape auto-scroll',
          'When ON, the cream paper ribbon scrolls to the newest fire.',
          true,
        ),
        switchTile(
          'Keyboard-area focus latch',
          'When ON, the focused Focus region keeps keyboard focus across '
              'fires, so Enter keeps dispatching VoidCallbackIntent.',
          false,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: creamPaper,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: brassMid, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: mahoganyDeep,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_drop_down_circle,
                        color: goldFoil, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Next intent label',
                      style: TextStyle(
                        color: goldFoil,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'dropdown',
                      style: TextStyle(
                        color: creamPaperShade,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              ...intentDropdownRows,
            ],
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 8 — Epilogue recipes
  // =========================================================================
  print('=== Section 8: Epilogue recipes ===');

  final recipes = <Map<String, dynamic>>[
    {
      'icon': Icons.menu,
      'title': 'Menus',
      'body': 'Bind a menu item to VoidCallbackIntent(() => runCmd()). One '
          'shared VoidCallbackAction powers the entire menu; every item '
          'supplies its own closure. No action registry plumbing needed.',
      'code':
          'MenuItemButton(onPressed: () => Actions.invoke(ctx, VoidCallbackIntent(runCmd)))',
    },
    {
      'icon': Icons.close_fullscreen,
      'title': 'Dismissable dialogs',
      'body': 'Wrap a dialog in Actions with VoidCallbackAction mapped, and '
          'bind Esc in a Shortcuts widget to VoidCallbackIntent(Navigator.of(ctx).pop). '
          'Esc always dismisses regardless of which child is focused.',
      'code':
          'SingleActivator(Escape) -> VoidCallbackIntent(() => Navigator.of(ctx).pop())',
    },
    {
      'icon': Icons.assignment_turned_in,
      'title': 'Form submissions',
      'body': 'Attach VoidCallbackIntent(submitForm) to Ctrl+Enter. The '
          'submit closure lives next to the form state; the action is a '
          'reusable singleton at the top of the route.',
      'code':
          'SingleActivator(Enter, control: true) -> VoidCallbackIntent(submitForm)',
    },
    {
      'icon': Icons.history_edu,
      'title': 'Undo / redo stacks',
      'body': 'Push VoidCallbackIntent(() => stack.push(cmd)) from every '
          'action site. Centralised handling at the root keeps the undo '
          'stack in one place while every caller stays decoupled.',
      'code': 'Actions.invoke(rootCtx, VoidCallbackIntent(() => undo.push(...)))',
    },
    {
      'icon': Icons.dry_cleaning,
      'title': 'Analytics taps',
      'body': 'Override the nearest VoidCallbackAction with a subclass that '
          'logs before delegating to super.invoke. Transparent analytics '
          'without touching any callsite.',
      'code':
          'class LoggingVca extends VoidCallbackAction { @override invoke(i) { log(i); return super.invoke(i); } }',
    },
    {
      'icon': Icons.gps_fixed,
      'title': 'Focused keyboard-only flows',
      'body': 'In keyboard-heavy UIs, prefer Shortcuts + VoidCallbackIntent '
          'over onKey handlers: you keep focus semantics, propagation, and '
          'override control that bare key listeners lose.',
      'code':
          'Shortcuts(shortcuts: { ... : VoidCallbackIntent(openPalette) })',
    },
  ];

  final recipeCards = <Widget>[];
  for (int i = 0; i < recipes.length; i++) {
    final recipe = recipes[i];
    recipeCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: creamPaper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: brassMid, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: mahoganyDeep,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: brassBright,
                      shape: BoxShape.circle,
                      border: Border.all(color: brassDim, width: 1),
                    ),
                    child: Icon(
                      recipe['icon'] as IconData,
                      color: mahoganyDeep,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Recipe — ${recipe['title']}',
                    style: TextStyle(
                      color: goldFoil,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['body'] as String,
                    style: TextStyle(
                      color: inkBrown,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: mahoganyGrain,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      recipe['code'] as String,
                      style: TextStyle(
                        color: creamPaper,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final epiloguePanel = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: mahoganyDeep,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassBright, width: 3),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: goldFoil, size: 26),
            const SizedBox(width: 10),
            Text(
              'Epilogue — Recipes',
              style: TextStyle(
                color: goldFoil,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Patterns that show up again and again when you reach for '
          'VoidCallbackAction — the tiny action that quietly glues the '
          'keyboard, menus, dialogs, and shortcuts to plain Dart closures.',
          style: TextStyle(
            color: creamPaper,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        ...recipeCards,
      ],
    ),
  );

  // =========================================================================
  // Section header helper
  // =========================================================================
  Widget sectionRibbon(int index, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [mahoganyDeep, mahoganyMid, mahoganyDeep],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: brassBright, width: 2),
        boxShadow: [
          BoxShadow(
            color: shadowSoft,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: brassBright,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: brassDim, width: 1.5),
            ),
            child: Center(
              child: Text(
                '$index',
                style: TextStyle(
                  color: mahoganyDeep,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
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
                  style: TextStyle(
                    color: goldFoil,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: creamPaperShade,
                    fontSize: 11,
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

  // =========================================================================
  // Preamble top ribbon
  // =========================================================================
  final topRibbon = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [mahoganyDeep, mahoganyGrain],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: brassBright, width: 3),
      boxShadow: [
        BoxShadow(
          color: shadowSoft,
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: brassBright,
                shape: BoxShape.circle,
                border: Border.all(color: brassDim, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: shadowSoft,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(Icons.flash_on, color: mahoganyDeep, size: 36),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VoidCallbackAction — Boardroom Edition',
                    style: TextStyle(
                      color: goldFoil,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Action<VoidCallbackIntent> · invokes intent.callback() · '
                    'stateless adapter',
                    style: TextStyle(
                      color: creamPaperShade,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mahoganyMid,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: brassDim, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Source',
                      style: TextStyle(
                        color: brassBright,
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'flutter/src/widgets/actions.dart',
                      style: TextStyle(
                        color: creamPaper,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mahoganyMid,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: brassDim, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoke contract',
                      style: TextStyle(
                        color: brassBright,
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'invoke(i) => i.callback()',
                      style: TextStyle(
                        color: creamPaper,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mahoganyMid,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: brassDim, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Returns',
                      style: TextStyle(
                        color: brassBright,
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'null',
                      style: TextStyle(
                        color: creamPaper,
                        fontSize: 12,
                        fontFamily: 'monospace',
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
  );

  // =========================================================================
  // Closing plaque
  // =========================================================================
  final closingPlaque = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: mahoganyGrain,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassBright, width: 2),
    ),
    child: Column(
      children: [
        Icon(Icons.military_tech, color: goldFoil, size: 34),
        const SizedBox(height: 8),
        Text(
          'End of VoidCallbackAction Deep Demo',
          style: TextStyle(
            color: goldFoil,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Struck on cream paper · stamped in gold foil · mahogany panel',
          style: TextStyle(
            color: creamPaperShade,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // _VcaBoard assembly
  // =========================================================================
  final _VcaBoard board = _VcaBoard(
    backdrop: mahoganyGrain,
    woodGrain: mahoganyDeep,
    sections: <Widget>[
      topRibbon,
      sectionRibbon(1, 'Preamble anatomy',
          'What VoidCallbackAction is and why it matters.'),
      ...preambleCards,
      sectionRibbon(2, 'Executive dashboard',
          'The big red leather button that fires a VoidCallbackIntent.'),
      dashboardPanel,
      sectionRibbon(3, 'Log tape',
          'Cream paper ribbon of every fire: timestamp · label · origin.'),
      logTapePanel,
      sectionRibbon(4, 'Keyboard shortcut binding',
          'Shortcuts → VoidCallbackIntent → VoidCallbackAction → callback.'),
      shortcutPanel,
      sectionRibbon(5, 'Composition',
          'Multiple subtrees route intents to the nearest scoped handler.'),
      compositionPanel,
      sectionRibbon(6, 'Disabled / enabled',
          'A custom subclass overrides isEnabled to gate fires.'),
      gatePanel,
      sectionRibbon(7, 'Interactive controls',
          'Switch, dropdown, keyboard region — how the user steers fires.'),
      interactivePanel,
      sectionRibbon(8, 'Epilogue recipes',
          'Menus, dialogs, form submissions, analytics taps.'),
      epiloguePanel,
      closingPlaque,
    ],
  );

  print('  _VcaBoard assembled with ${board.sections.length} sections');

  return MaterialApp(
    title: 'VoidCallbackAction Boardroom',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: mahoganyGrain,
      primaryColor: mahoganyDeep,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: creamPaper),
        bodyMedium: TextStyle(color: creamPaper),
      ),
    ),
    home: Scaffold(
      backgroundColor: mahoganyGrain,
      appBar: AppBar(
        backgroundColor: mahoganyDeep,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.flash_on, color: goldFoil, size: 26),
            const SizedBox(width: 10),
            Text(
              'VoidCallbackAction Deep Demo',
              style: TextStyle(
                color: goldFoil,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [brassDim, brassBright, brassDim],
              ),
            ),
          ),
        ),
      ),
      body: board,
    ),
  );
}

// =============================================================================
// _VcaBoard — private board widget with mahogany backdrop, brass rim, and a
// vertical stack of composed sections. Scrolls the full boardroom demo.
// =============================================================================
class _VcaBoard extends StatelessWidget {
  const _VcaBoard({
    required this.backdrop,
    required this.woodGrain,
    required this.sections,
  });

  final Color backdrop;
  final Color woodGrain;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [backdrop, woodGrain, backdrop],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: sections,
        ),
      ),
    );
  }
}
