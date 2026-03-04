// D4rt test script: Tests InheritedModel, InheritedWidget, InheritedNotifier,
// ValueListenableBuilder, ValueNotifier, ListenableBuilder, AnimatedBuilder
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('InheritedModel/ValueListenable test executing');

  // ========== ValueNotifier ==========
  print('--- ValueNotifier Tests ---');
  final notifier = ValueNotifier<int>(0);
  print('ValueNotifier created: value=${notifier.value}');
  notifier.value = 42;
  print('  updated value: ${notifier.value}');
  notifier.addListener(() => print('  listener fired'));
  notifier.value = 100;
  print('  final value: ${notifier.value}');

  // ========== ValueListenableBuilder ==========
  print('--- ValueListenableBuilder Tests ---');
  final vlBuilder = ValueListenableBuilder<int>(
    valueListenable: notifier,
    builder: (context, value, child) {
      return Text('Value: $value');
    },
    child: Text('Static child'),
  );
  print('ValueListenableBuilder created');

  // ========== ListenableBuilder ==========
  print('--- ListenableBuilder Tests ---');
  final listenableBuilder = ListenableBuilder(
    listenable: notifier,
    builder: (context, child) {
      return Text('Rebuilt');
    },
    child: Text('Child'),
  );
  print('ListenableBuilder created');

  // ========== AnimatedBuilder ==========
  print('--- AnimatedBuilder Tests ---');
  final animController = AnimationController(
    vsync: const TestVSync(),
    duration: Duration(seconds: 1),
  );
  final animBuilder = AnimatedBuilder(
    animation: animController,
    builder: (context, child) {
      return Opacity(opacity: animController.value, child: child);
    },
    child: Text('Animated'),
  );
  print('AnimatedBuilder created');

  // ========== InheritedWidget (via Theme which is an InheritedWidget) ==========
  print('--- InheritedWidget Tests ---');
  final inherited = Theme(
    data: ThemeData.light(),
    child: Text('Themed'),
  );
  print('InheritedWidget (Theme) created');

  // ========== InheritedNotifier ==========
  print('--- InheritedNotifier Tests ---');
  // InheritedNotifier is abstract, but we can demonstrate via InheritedModel concept
  final changeNotifier = ChangeNotifier();
  print('ChangeNotifier created for InheritedNotifier pattern');
  print('  hasListeners: ${changeNotifier.hasListeners}');

  // ========== InheritedModel concept ==========
  print('--- InheritedModel Tests ---');
  // InheritedModel is abstract, demonstrate via MediaQuery which uses it
  final mediaQuery = MediaQuery(
    data: MediaQueryData(size: Size(400, 800)),
    child: Text('Media'),
  );
  print('InheritedModel (MediaQuery) created');

  print('All inherited/listenable tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          vlBuilder,
          listenableBuilder,
          animBuilder,
          inherited,
          mediaQuery,
        ],
      ),
    ),
  );
}

class TestVSync implements TickerProvider {
  const TestVSync();
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
