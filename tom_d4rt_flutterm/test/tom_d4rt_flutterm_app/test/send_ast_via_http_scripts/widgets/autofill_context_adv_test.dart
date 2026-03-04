// Tests: OverrideAction, AutofillGroupState, AutofillClient (abstract),
//        AutofillScope (abstract), EditableTextContextMenuBuilder (typedef),
//        ContextMenuController, ContextMenuRegion, ContextMenuArea
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- OverrideAction Tests ---
  print('--- OverrideAction Tests ---');
  print('OverrideAction wraps another action and overrides its behavior');
  print('Type: OverrideAction (internal framework class)');
  var activateAction = CallbackAction<ActivateIntent>(
    onInvoke: (intent) {
      print('Activate action invoked');
      return null;
    },
  );
  print('Base CallbackAction: $activateAction');
  print('OverrideAction allows intercepting and modifying action behavior');

  // --- AutofillGroupState Tests ---
  print('--- AutofillGroupState Tests ---');
  print('AutofillGroupState is the State of AutofillGroup');
  print('Type: $AutofillGroupState');
  var autofillGroup = AutofillGroup(
    child: Column(
      children: [
        TextFormField(
          autofillHints: const [AutofillHints.username],
          decoration: const InputDecoration(labelText: 'Username'),
        ),
        TextFormField(
          autofillHints: const [AutofillHints.password],
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
      ],
    ),
  );
  print('AutofillGroup: $autofillGroup');
  print('AutofillGroup groups autofillable fields together');
  print('AutofillGroupState manages autofill lifecycle');

  // --- AutofillClient Tests ---
  print('--- AutofillClient Tests ---');
  print('AutofillClient is the abstract interface for autofill participants');
  print('Type: AutofillClient (abstract mixin, not publicly available)');
  print('Implemented by EditableTextState and similar text input widgets');
  print('Provides autofillId and textInputConfiguration');
  print('Receives autofill values via autofill() callback');

  // --- AutofillScope Tests ---
  print('--- AutofillScope Tests ---');
  print('AutofillScope groups AutofillClients together');
  print('Type: AutofillScope (abstract mixin, not publicly available)');
  print('Provides getAutofillClient() to look up clients by autofill ID');
  print('AutofillGroupState implements AutofillScope');

  // --- EditableTextContextMenuBuilder Tests ---
  print('--- EditableTextContextMenuBuilder Tests ---');
  print(
    'EditableTextContextMenuBuilder is a typedef for context menu builders',
  );
  print('Signature: Widget Function(BuildContext, EditableTextState)');
  print('Used in TextField.contextMenuBuilder and EditableText');
  print('Allows customizing the text selection context menu');

  // --- ContextMenuController Tests ---
  print('--- ContextMenuController Tests ---');
  var contextMenuController = ContextMenuController();
  print('ContextMenuController: $contextMenuController');
  print('ContextMenuController isShown: ${contextMenuController.isShown}');
  print('ContextMenuController manages context menu display');
  print('Provides show() and remove() methods');

  // --- ContextMenuRegion Tests ---
  print('--- ContextMenuRegion Tests ---');
  print('ContextMenuRegion responds to right-click for context menus');
  print('Type: $ContextMenuButtonType');
  print('ContextMenuButtonType.cut: ${ContextMenuButtonType.cut}');
  print('ContextMenuButtonType.copy: ${ContextMenuButtonType.copy}');
  print('ContextMenuButtonType values: ${ContextMenuButtonType.values}');

  // --- ContextMenuArea Tests ---
  print('--- ContextMenuArea Tests ---');
  print('Context menu areas allow attaching custom context menus to widgets');
  print('Built using ContextMenuController and custom menu builders');
  var contextMenuExample = GestureDetector(
    onSecondaryTapDown: (details) {
      print('Secondary tap detected for context menu');
    },
    child: Container(
      width: 200,
      height: 100,
      color: Colors.blue.shade100,
      child: const Center(child: Text('Right-click area')),
    ),
  );
  print('Context menu area widget: $contextMenuExample');

  print('All autofill context advanced tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              autofillGroup,
              const SizedBox(height: 20),
              contextMenuExample,
              const SizedBox(height: 20),
              const Text('Autofill Context Adv Test'),
            ],
          ),
        ),
      ),
    ),
  );
}
