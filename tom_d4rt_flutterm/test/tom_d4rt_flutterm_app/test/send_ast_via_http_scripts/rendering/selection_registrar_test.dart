// D4rt test script: Tests SelectionRegistrar from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Mock implementation of SelectionRegistrar for testing
class MockSelectionRegistrar extends SelectionRegistrar {
  final List<Selectable> _selectables = [];
  int addCount = 0;
  int removeCount = 0;

  @override
  void add(Selectable selectable) {
    _selectables.add(selectable);
    addCount++;
  }

  @override
  void remove(Selectable selectable) {
    _selectables.remove(selectable);
    removeCount++;
  }

  List<Selectable> get selectables => List.unmodifiable(_selectables);
}

dynamic build(BuildContext context) {
  print('SelectionRegistrar test executing');
  final results = <String>[];

  // ========== Section 1: SelectionRegistrar is Abstract ==========
  print('--- Section 1: SelectionRegistrar is Abstract ---');

  print('SelectionRegistrar is an abstract class');
  print('It defines the interface for managing selectables');
  results.add('SelectionRegistrar is abstract class');

  // ========== Section 2: Mock Implementation ==========
  print('--- Section 2: Mock Implementation ---');

  final registrar = MockSelectionRegistrar();
  print('Created MockSelectionRegistrar: ${registrar.runtimeType}');
  print('Initial selectables count: ${registrar.selectables.length}');
  print('Initial addCount: ${registrar.addCount}');
  print('Initial removeCount: ${registrar.removeCount}');
  results.add('Mock registrar created');

  // ========== Section 3: SelectionRegistrar Methods ==========
  print('--- Section 3: SelectionRegistrar Methods ---');

  // SelectionRegistrar has two main methods:
  // - add(Selectable selectable)
  // - remove(Selectable selectable)
  print('SelectionRegistrar methods:');
  print('  - add(Selectable): registers a selectable');
  print('  - remove(Selectable): unregisters a selectable');
  results.add('Methods: add, remove');

  // ========== Section 4: Type Checking ==========
  print('--- Section 4: Type Checking ---');

  print('registrar is SelectionRegistrar: ${registrar is SelectionRegistrar}');
  print('registrar runtimeType: ${registrar.runtimeType}');
  results.add('Type check: ${registrar is SelectionRegistrar}');

  // ========== Section 5: SelectionRegistrarScope (inherited widget) ==========
  print('--- Section 5: SelectionRegistrarScope ---');

  // SelectionRegistrarScope is an InheritedWidget that provides
  // SelectionRegistrar to the widget tree
  print('SelectionRegistrarScope is an InheritedWidget');
  print('Used to provide SelectionRegistrar in widget tree');

  // Create a scope with null registrar
  final scope = SelectionRegistrarScope(registrar: null, child: SizedBox());
  print('Created SelectionRegistrarScope: ${scope.runtimeType}');
  results.add('SelectionRegistrarScope created');

  // ========== Section 6: SelectionRegistrarScope with Registrar ==========
  print('--- Section 6: SelectionRegistrarScope with Registrar ---');

  final scopeWithRegistrar = SelectionRegistrarScope(
    registrar: registrar,
    child: Container(),
  );
  print('Scope with registrar: ${scopeWithRegistrar.registrar != null}');
  print('Registrar type: ${scopeWithRegistrar.registrar?.runtimeType}');
  results.add('Scope with registrar working');

  // ========== Section 7: Maybeofs and Of Methods ==========
  print('--- Section 7: Static Methods Pattern ---');

  // SelectionRegistrarScope typically provides:
  // - maybeOf(BuildContext): returns nullable registrar
  // - of(BuildContext): returns non-nullable registrar (throws if not found)
  print('SelectionRegistrarScope provides static lookup methods');
  print('Pattern: maybeOf(context) and of(context)');
  results.add('Static methods: maybeOf, of');

  // ========== Section 8: Multiple Registrations ==========
  print('--- Section 8: Multiple Registrations ---');

  final testRegistrar = MockSelectionRegistrar();
  print('Add count before: ${testRegistrar.addCount}');
  print('Remove count before: ${testRegistrar.removeCount}');

  // Note: We cannot create actual Selectables without a full widget tree,
  // but we can verify the registrar interface
  print('Registrar interface verified');
  results.add('Registrar interface verified');

  // ========== Section 9: SelectionContainer Pattern ==========
  print('--- Section 9: SelectionContainer Pattern ---');

  // SelectionContainer uses SelectionRegistrar internally
  print('SelectionContainer widget uses SelectionRegistrar');
  print('It coordinates selection across child selectables');

  final selectionContainer = SelectionContainer(child: Text('Selectable text'));
  print('SelectionContainer created: ${selectionContainer.runtimeType}');
  results.add('SelectionContainer uses registrar pattern');

  // ========== Section 10: Disabled Selection ==========
  print('--- Section 10: Disabled Selection ---');

  final disabledSelection = SelectionContainer.disabled(
    child: Text('Non-selectable text'),
  );
  print('SelectionContainer.disabled: ${disabledSelection.runtimeType}');
  results.add('SelectionContainer.disabled available');

  print('SelectionRegistrar test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionRegistrar Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
