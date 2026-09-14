// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ChangeNotifier, ValueNotifier, Listenable, ValueListenable from foundation
// Deep Demo: Visual demonstration of the notifier family — construction, listeners, notifyListeners, mutation, disposal, and Listenable.merge composition
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Notifier family Deep Demo executing');

  // ============================================================
  // SECTION 1: Notifier Family Concept Overview
  // ============================================================
  print('=== Section 1: Notifier Family Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: ChangeNotifier
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.broadcast_on_personal,
              size: 44.0, color: Colors.indigo.shade700),
          SizedBox(height: 10.0),
          Text(
            'ChangeNotifier',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Mixin / class with\naddListener, removeListener,\nand notifyListeners()',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.indigo.shade700),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'extends Listenable',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Concept 2: ValueNotifier<T>
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.tune, size: 44.0, color: Colors.teal.shade700),
          SizedBox(height: 10.0),
          Text(
            'ValueNotifier<T>',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Holds a single value\nand notifies only when\nthe value actually changes',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.teal.shade700),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'extends ChangeNotifier',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.teal.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Concept 3: Listenable / ValueListenable
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.pink.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.hub, size: 44.0, color: Colors.purple.shade700),
          SizedBox(height: 10.0),
          Text(
            'Listenable',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Abstract interface for\nany object that can be\nlistened to. Includes merge.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.purple.shade700),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'ValueListenable<T>',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.purple.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: ValueNotifier<int> + ValueListenableBuilder<int>
  // ============================================================
  print('=== Section 2: ValueNotifier<int> + ValueListenableBuilder ===');

  final intCounter = ValueNotifier<int>(0);
  print('ValueNotifier<int>(0) created — initial value: ${intCounter.value}');

  // Track every step
  final counterSteps = <int>[];
  counterSteps.add(intCounter.value);

  // Programmatic mutations
  intCounter.value = 5;
  print('Set value = 5 -> ${intCounter.value}');
  counterSteps.add(intCounter.value);

  intCounter.value = 12;
  print('Set value = 12 -> ${intCounter.value}');
  counterSteps.add(intCounter.value);

  // Identical assignment: ValueNotifier suppresses notification
  intCounter.value = 12;
  print('Set value = 12 again (no-notify) -> ${intCounter.value}');

  intCounter.value = 7;
  print('Set value = 7 -> ${intCounter.value}');
  counterSteps.add(intCounter.value);

  // Final rendered value is whatever the notifier currently holds.
  print('Final intCounter.value = ${intCounter.value}');

  final counterTimelineDots = <Widget>[];
  for (int i = 0; i < counterSteps.length; i++) {
    final v = counterSteps[i];
    final isLast = i == counterSteps.length - 1;
    counterTimelineDots.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isLast ? Colors.teal.shade600 : Colors.teal.shade100,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.teal.shade700, width: 1.5),
        ),
        child: Text(
          '$v',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isLast ? Colors.white : Colors.teal.shade900,
          ),
        ),
      ),
    );
    if (!isLast) {
      counterTimelineDots.add(
        Icon(Icons.arrow_forward, size: 18.0, color: Colors.teal.shade400),
      );
    }
  }

  final intCounterCard = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade100, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.exposure_plus_1, color: Colors.teal.shade800),
            SizedBox(width: 8.0),
            Text(
              'ValueListenableBuilder<int>',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // The real ValueListenableBuilder reflects the current value.
        ValueListenableBuilder<int>(
          valueListenable: intCounter,
          builder: (context, value, child) {
            return Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withValues(alpha: 0.2),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Counter',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.teal.shade700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 56.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'rendered via builder',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 14.0),
        Text(
          'Mutation timeline',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: counterTimelineDots,
        ),
      ],
    ),
  );
  print('Built ValueNotifier<int> counter card');

  // ============================================================
  // SECTION 3: ValueNotifier<Color> driving a coloured square
  // ============================================================
  print('=== Section 3: ValueNotifier<Color> + ValueListenableBuilder ===');

  final colorNotifier = ValueNotifier<Color>(Colors.red);
  print('Initial colour: ${colorNotifier.value}');

  final colorSequence = <Color>[
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.green,
    Colors.blue,
    Colors.indigo,
  ];

  for (final c in colorSequence) {
    colorNotifier.value = c;
    print('colorNotifier.value = $c');
  }

  // Land on something distinct for the final render
  colorNotifier.value = Colors.indigo;
  print('Final colour: ${colorNotifier.value}');

  final colorSwatches = <Widget>[];
  for (final c in colorSequence) {
    final isCurrent = c == colorNotifier.value;
    colorSwatches.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isCurrent ? Colors.black : Colors.transparent,
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.5),
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: isCurrent
            ? Icon(Icons.check, color: Colors.white, size: 18.0)
            : null,
      ),
    );
  }

  final colorCard = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.5),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: Colors.deepPurple),
            SizedBox(width: 8.0),
            Text(
              'ValueListenableBuilder<Color>',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        ValueListenableBuilder<Color>(
          valueListenable: colorNotifier,
          builder: (context, value, child) {
            return Container(
              width: 160.0,
              height: 160.0,
              decoration: BoxDecoration(
                color: value,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: value.withValues(alpha: 0.5),
                    blurRadius: 16.0,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'current',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 14.0),
        Text(
          'Swatch sequence (current highlighted)',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: colorSwatches,
        ),
      ],
    ),
  );
  print('Built ValueNotifier<Color> card');

  // ============================================================
  // SECTION 4: ValueNotifier<bool> driving an icon toggle
  // ============================================================
  print('=== Section 4: ValueNotifier<bool> + ValueListenableBuilder ===');

  final boolNotifier = ValueNotifier<bool>(false);
  print('Initial bool: ${boolNotifier.value}');

  boolNotifier.value = true;
  print('Toggled -> ${boolNotifier.value}');

  boolNotifier.value = false;
  print('Toggled -> ${boolNotifier.value}');

  boolNotifier.value = true;
  print('Final bool: ${boolNotifier.value}');

  final boolCard = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.yellow.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.amber.shade400, width: 2.0),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.toggle_on, color: Colors.amber.shade800),
            SizedBox(width: 8.0),
            Text(
              'ValueListenableBuilder<bool>',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        ValueListenableBuilder<bool>(
          valueListenable: boolNotifier,
          builder: (context, value, child) {
            return Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: value ? Colors.amber.shade300 : Colors.grey.shade300,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: value
                        ? Colors.amber.withValues(alpha: 0.6)
                        : Colors.grey.withValues(alpha: 0.3),
                    blurRadius: value ? 24.0 : 6.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                value ? Icons.lightbulb : Icons.lightbulb_outline,
                size: 64.0,
                color: value ? Colors.orange.shade900 : Colors.grey.shade700,
              ),
            );
          },
        ),
        SizedBox(height: 12.0),
        ValueListenableBuilder<bool>(
          valueListenable: boolNotifier,
          builder: (context, value, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: value ? Colors.orange.shade700 : Colors.grey.shade600,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                value ? 'ON' : 'OFF',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
  print('Built ValueNotifier<bool> toggle card');

  // ============================================================
  // SECTION 5: Custom _CartModel extends ChangeNotifier + AnimatedBuilder
  // ============================================================
  print('=== Section 5: Custom ChangeNotifier + AnimatedBuilder ===');

  final cart = _CartModel();
  print('Cart created. Items: ${cart.items.length}');

  // Track listener invocations
  var cartListenerCalls = 0;
  void cartListener() {
    cartListenerCalls++;
    print('  cart listener fired (#$cartListenerCalls)');
  }

  cart.addListener(cartListener);
  print('Attached cart listener');

  cart.addItem('Notebook', 4.50);
  cart.addItem('Pen', 1.25);
  cart.addItem('Highlighter', 2.10);
  cart.addItem('Eraser', 0.75);
  print('Added 4 items. Total = ${cart.total.toStringAsFixed(2)}');

  cart.removeItem('Pen');
  print('Removed Pen. Items left: ${cart.items.length}');

  cart.addItem('Sticky Notes', 3.40);
  print('Added Sticky Notes. Total = ${cart.total.toStringAsFixed(2)}');

  print('cart listener total invocations: $cartListenerCalls');

  final cartCard = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.shopping_cart, color: Colors.deepOrange),
            SizedBox(width: 8.0),
            Text(
              'AnimatedBuilder(animation: cart, …)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Real AnimatedBuilder listening to the ChangeNotifier subclass.
        AnimatedBuilder(
          animation: cart,
          builder: (context, child) {
            final rows = <Widget>[];
            for (int i = 0; i < cart.items.length; i++) {
              final item = cart.items[i];
              rows.add(
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border:
                        Border.all(color: Colors.deepOrange.shade200, width: 1.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28.0,
                        height: 28.0,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange.shade900,
                          ),
                        ),
                      ),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...rows,
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade700,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total (${cart.items.length} items)',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${cart.total.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'cart listener fired $cartListenerCalls times during mutations',
            style: TextStyle(
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
              color: Colors.deepOrange.shade900,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built cart card');

  // ============================================================
  // SECTION 6: Listenable.merge([a, b, c]) + AnimatedBuilder
  // ============================================================
  print('=== Section 6: Listenable.merge composition ===');

  final tempNotifier = ValueNotifier<int>(18);
  final humidityNotifier = ValueNotifier<int>(40);
  final windNotifier = ValueNotifier<int>(5);

  final merged = Listenable.merge(<Listenable?>[
    tempNotifier,
    humidityNotifier,
    windNotifier,
  ]);
  print('Merged listenable created across 3 ValueNotifiers');

  var mergedListenerCalls = 0;
  void mergedListener() {
    mergedListenerCalls++;
    print(
      '  merged listener fired (#$mergedListenerCalls) '
      'temp=${tempNotifier.value} '
      'hum=${humidityNotifier.value} '
      'wind=${windNotifier.value}',
    );
  }

  merged.addListener(mergedListener);

  tempNotifier.value = 22;
  humidityNotifier.value = 55;
  windNotifier.value = 12;
  tempNotifier.value = 24;
  humidityNotifier.value = 60;
  windNotifier.value = 18;
  print('merged total listener calls: $mergedListenerCalls');

  merged.removeListener(mergedListener);
  print('Removed merged listener');

  final mergedCard = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightBlue.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.merge_type, color: Colors.indigo.shade700),
            SizedBox(width: 8.0),
            Text(
              'Listenable.merge([t, h, w])',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        AnimatedBuilder(
          animation: merged,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statBox(
                  Icons.thermostat,
                  'Temperature',
                  '${tempNotifier.value}°C',
                  Colors.red,
                ),
                _statBox(
                  Icons.water_drop,
                  'Humidity',
                  '${humidityNotifier.value}%',
                  Colors.blue,
                ),
                _statBox(
                  Icons.air,
                  'Wind',
                  '${windNotifier.value} km/h',
                  Colors.teal,
                ),
              ],
            );
          },
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'A single AnimatedBuilder rebuilds when ANY of the three notifiers fires.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built merged listenable card');

  // ============================================================
  // SECTION 7: Listener Operation Timeline
  // ============================================================
  print('=== Section 7: Listener Operation Timeline ===');

  final timelineNotifier = ValueNotifier<int>(0);
  var lAcalls = 0;
  var lBcalls = 0;
  void lA() {
    lAcalls++;
  }

  void lB() {
    lBcalls++;
  }

  final ops = <Map<String, dynamic>>[];

  // Op 1: initial
  ops.add({
    'op': 'Initial state',
    'desc': 'ValueNotifier<int>(0) — no listeners',
    'icon': Icons.flag,
    'color': Colors.grey,
    'lA': lAcalls,
    'lB': lBcalls,
  });

  // Op 2: add listener A
  timelineNotifier.addListener(lA);
  ops.add({
    'op': 'addListener(A)',
    'desc': 'First listener registered',
    'icon': Icons.add_circle,
    'color': Colors.green,
    'lA': lAcalls,
    'lB': lBcalls,
  });
  print('Added listener A');

  // Op 3: notify (set value)
  timelineNotifier.value = 1;
  ops.add({
    'op': 'value = 1 (notify)',
    'desc': 'A fires',
    'icon': Icons.flash_on,
    'color': Colors.amber,
    'lA': lAcalls,
    'lB': lBcalls,
  });

  // Op 4: add listener B
  timelineNotifier.addListener(lB);
  ops.add({
    'op': 'addListener(B)',
    'desc': 'Second listener registered',
    'icon': Icons.add_circle_outline,
    'color': Colors.blue,
    'lA': lAcalls,
    'lB': lBcalls,
  });
  print('Added listener B');

  // Op 5: notify with both
  timelineNotifier.value = 2;
  ops.add({
    'op': 'value = 2 (notify)',
    'desc': 'Both A and B fire',
    'icon': Icons.flash_on,
    'color': Colors.amber,
    'lA': lAcalls,
    'lB': lBcalls,
  });

  // Op 6: same value — suppressed
  timelineNotifier.value = 2;
  ops.add({
    'op': 'value = 2 (same)',
    'desc': 'ValueNotifier suppresses identical assignment',
    'icon': Icons.do_not_disturb_on,
    'color': Colors.grey,
    'lA': lAcalls,
    'lB': lBcalls,
  });

  // Op 7: remove listener A
  timelineNotifier.removeListener(lA);
  ops.add({
    'op': 'removeListener(A)',
    'desc': 'Only B remains',
    'icon': Icons.remove_circle,
    'color': Colors.orange,
    'lA': lAcalls,
    'lB': lBcalls,
  });
  print('Removed listener A');

  // Op 8: notify
  timelineNotifier.value = 3;
  ops.add({
    'op': 'value = 3 (notify)',
    'desc': 'Only B fires',
    'icon': Icons.flash_on,
    'color': Colors.amber,
    'lA': lAcalls,
    'lB': lBcalls,
  });

  // Op 9: remove listener B and dispose
  timelineNotifier.removeListener(lB);
  ops.add({
    'op': 'removeListener(B) + dispose()',
    'desc': 'No listeners — safe to dispose',
    'icon': Icons.delete_forever,
    'color': Colors.red,
    'lA': lAcalls,
    'lB': lBcalls,
  });
  timelineNotifier.dispose();
  print('Removed listener B and disposed notifier');

  final timelineWidgets = <Widget>[];
  for (int i = 0; i < ops.length; i++) {
    final op = ops[i];
    final color = op['color'] as Color;
    final isLast = i == ops.length - 1;
    timelineWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  op['icon'] as IconData,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 32.0,
                  color: color.withValues(alpha: 0.5),
                ),
            ],
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 14.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    op['op'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    op['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'A: ${op['lA']}',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontFamily: 'monospace',
                            color: Colors.green.shade900,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'B: ${op['lB']}',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontFamily: 'monospace',
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  print('Created ${timelineWidgets.length} timeline rows');

  // ============================================================
  // SECTION 8: Code Pattern Panels
  // ============================================================
  print('=== Section 8: Code Pattern Panels ===');

  final codePanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Common Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          'ValueNotifier<int> + builder',
          '// 1. Create a ValueNotifier.\n'
              'final counter = ValueNotifier<int>(0);\n'
              '\n'
              '// 2. Listen in the widget tree.\n'
              'ValueListenableBuilder<int>(\n'
              '  valueListenable: counter,\n'
              '  builder: (ctx, value, child) => Text("\$value"),\n'
              ');\n'
              '\n'
              '// 3. Mutate — only fires when value changes.\n'
              'counter.value = counter.value + 1;',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          'Custom ChangeNotifier',
          'class CartModel extends ChangeNotifier {\n'
              '  final List<Item> items = <Item>[];\n'
              '\n'
              '  void add(Item i) {\n'
              '    items.add(i);\n'
              '    notifyListeners();\n'
              '  }\n'
              '\n'
              '  void remove(Item i) {\n'
              '    items.remove(i);\n'
              '    notifyListeners();\n'
              '  }\n'
              '}\n'
              '\n'
              'AnimatedBuilder(\n'
              '  animation: cart,\n'
              '  builder: (ctx, _) => CartView(cart),\n'
              ');',
          Colors.purpleAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          'Listenable.merge',
          '// Combine multiple sources into one.\n'
              'final merged = Listenable.merge(<Listenable?>[\n'
              '  temperature,\n'
              '  humidity,\n'
              '  wind,\n'
              ']);\n'
              '\n'
              'AnimatedBuilder(\n'
              '  animation: merged,\n'
              '  builder: (ctx, _) => Dashboard(),\n'
              ');',
          Colors.amberAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          'Listener lifecycle',
          'final n = ValueNotifier<int>(0);\n'
              'void onChange() => print(n.value);\n'
              '\n'
              'n.addListener(onChange);\n'
              'n.value = 1;            // fires\n'
              'n.value = 1;            // does NOT fire\n'
              'n.removeListener(onChange);\n'
              'n.dispose();            // release resources',
          Colors.cyanAccent.shade100,
        ),
      ],
    ),
  );
  print('Built code panel');

  // ============================================================
  // SECTION 9: Summary Panel
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.broadcast_on_personal,
          'ChangeNotifier',
          'Call notifyListeners() to broadcast changes',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.tune,
          'ValueNotifier<T>',
          'Holds a value; skips notifying when value is identical',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.widgets,
          'ValueListenableBuilder',
          'Cleanest way to rebuild a subtree for a single value',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.animation,
          'AnimatedBuilder',
          'Rebuild whenever any Listenable fires — great for models',
          Colors.deepOrange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.merge_type,
          'Listenable.merge',
          'Compose multiple sources into one trigger surface',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.delete_forever,
          'dispose()',
          'Always remove listeners and dispose to free resources',
          Colors.red,
        ),
      ],
    ),
  );
  print('Built summary panel');

  print('Notifier family Deep Demo completed successfully');

  // ============================================================
  // Return the complete scrollable visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.broadcast_on_personal,
                  size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ChangeNotifier & ValueNotifier',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'The foundation observable family',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1: Concept overview
        Text(
          '1. Notifier Family Concepts',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: conceptCards,
        ),
        SizedBox(height: 32.0),

        // Section 2: int counter
        Text(
          '2. ValueNotifier<int> Counter',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        intCounterCard,
        SizedBox(height: 32.0),

        // Section 3: color square
        Text(
          '3. ValueNotifier<Color> Driving a Square',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        colorCard,
        SizedBox(height: 32.0),

        // Section 4: bool toggle
        Text(
          '4. ValueNotifier<bool> Icon Toggle',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        boolCard,
        SizedBox(height: 32.0),

        // Section 5: cart model
        Text(
          '5. Custom ChangeNotifier (_CartModel)',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        cartCard,
        SizedBox(height: 32.0),

        // Section 6: merge
        Text(
          '6. Listenable.merge Across 3 Notifiers',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        mergedCard,
        SizedBox(height: 32.0),

        // Section 7: timeline
        Text(
          '7. Listener Operation Timeline',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: timelineWidgets),
        ),
        SizedBox(height: 32.0),

        // Section 8: code
        Text(
          '8. Code Patterns',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codePanel,
        SizedBox(height: 32.0),

        // Section 9: summary
        Text(
          '9. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// ---------------------------------------------------------------
// Custom ChangeNotifier — a tiny shopping cart model
// ---------------------------------------------------------------
class _CartItem {
  final String name;
  final double price;
  _CartItem(this.name, this.price);
}

class _CartModel extends ChangeNotifier {
  final List<_CartItem> _items = <_CartItem>[];

  List<_CartItem> get items => List<_CartItem>.unmodifiable(_items);

  double get total {
    var sum = 0.0;
    for (final i in _items) {
      sum += i.price;
    }
    return sum;
  }

  void addItem(String name, double price) {
    _items.add(_CartItem(name, price));
    notifyListeners();
  }

  void removeItem(String name) {
    final idx = _items.indexWhere((i) => i.name == name);
    if (idx >= 0) {
      _items.removeAt(idx);
      notifyListeners();
    }
  }

  void clear() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}

// ---------------------------------------------------------------
// Helper: small stat box used inside the merge AnimatedBuilder
// ---------------------------------------------------------------
Widget _statBox(IconData icon, String label, String value, Color color) {
  return Container(
    width: 96.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            letterSpacing: 0.5,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------
// Helper: dark-theme code block used in section 8
// ---------------------------------------------------------------
Widget _codeBlock(String title, String code, Color codeColor) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: codeColor,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------
// Helper: summary row used in section 9
// ---------------------------------------------------------------
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
