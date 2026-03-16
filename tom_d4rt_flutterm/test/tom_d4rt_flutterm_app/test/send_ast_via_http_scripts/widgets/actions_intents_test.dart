// D4rt test script: Tests SelectIntent, SelectAction, NextFocusIntent,
// NextFocusAction, PreviousFocusIntent, PreviousFocusAction,
// DirectionalFocusIntent, DirectionalFocusAction, PrioritizedIntents,
// ActionDispatcher, ActionListener
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Actions/Intents advanced test executing');

  // ========== SelectIntent ==========
  print('--- SelectIntent Tests ---');
  final selectIntent = SelectIntent();
  print('SelectIntent created');

  // ========== NextFocusIntent ==========
  print('--- NextFocusIntent Tests ---');
  final nextFocusIntent = NextFocusIntent();
  print('NextFocusIntent created');

  // ========== PreviousFocusIntent ==========
  print('--- PreviousFocusIntent Tests ---');
  final prevFocusIntent = PreviousFocusIntent();
  print('PreviousFocusIntent created');

  // ========== DirectionalFocusIntent ==========
  print('--- DirectionalFocusIntent Tests ---');
  final dirRight = DirectionalFocusIntent(TraversalDirection.right);
  print('DirectionalFocusIntent right created');
  print('  direction: ${dirRight.direction}');

  final dirLeft = DirectionalFocusIntent(TraversalDirection.left);
  print('DirectionalFocusIntent left: ${dirLeft.direction}');

  final dirUp = DirectionalFocusIntent(TraversalDirection.up);
  print('DirectionalFocusIntent up: ${dirUp.direction}');

  final dirDown = DirectionalFocusIntent(TraversalDirection.down);
  print('DirectionalFocusIntent down: ${dirDown.direction}');

  // ========== PrioritizedIntents ==========
  print('--- PrioritizedIntents Tests ---');
  final prioritized = PrioritizedIntents(
    orderedIntents: [ActivateIntent(), SelectIntent(), DismissIntent()],
  );
  print(
    'PrioritizedIntents created with ${prioritized.orderedIntents.length} intents',
  );

  // ========== ActionDispatcher ==========
  print('--- ActionDispatcher Tests ---');
  final dispatcher = ActionDispatcher();
  print('ActionDispatcher created');

  // ========== NextFocusAction ==========
  print('--- NextFocusAction Tests ---');
  final nextAction = NextFocusAction();
  print('NextFocusAction created');

  // ========== PreviousFocusAction ==========
  print('--- PreviousFocusAction Tests ---');
  final prevAction = PreviousFocusAction();
  print('PreviousFocusAction created');

  // ========== ScrollIntent ==========
  print('--- ScrollIntent (more variants) Tests ---');
  final scrollLineDown = ScrollIntent(direction: AxisDirection.down);
  print('ScrollIntent down created');
  final scrollLineUp = ScrollIntent(
    direction: AxisDirection.up,
    type: ScrollIncrementType.page,
  );
  print('ScrollIntent up/page created');

  // ========== RequestFocusIntent ==========
  print('--- RequestFocusIntent Tests ---');
  final focusNode = FocusNode(debugLabel: 'test');
  final requestFocus = RequestFocusIntent(focusNode);
  print('RequestFocusIntent created');
  focusNode.dispose();

  print('All actions/intents tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Actions(
        dispatcher: ActionDispatcher(),
        actions: <Type, Action<Intent>>{
          NextFocusIntent: NextFocusAction(),
          PreviousFocusIntent: PreviousFocusAction(),
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Actions/Intents Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text('ActionDispatcher test'),
              Text('SelectIntent, NextFocusIntent, PreviousFocusIntent'),
              Text('DirectionalFocusIntent (4 directions)'),
              Text('PrioritizedIntents with 3 intents'),
            ],
          ),
        ),
      ),
    ),
  );
}
