// ignore_for_file: avoid_print
// D4rt test script: Tests SliverFillRemaining and SliverOpacity from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverFillRemaining/SliverOpacity test executing');

  // Variation 1: Basic SliverFillRemaining
  final widget1 = CustomScrollView(
    slivers: [SliverFillRemaining(child: Center(child: Text('Fill')))],
  );
  print('SliverFillRemaining(basic) created');

  // Variation 2: SliverFillRemaining with hasScrollBody: false
  final widget2 = CustomScrollView(
    slivers: [
      SliverAppBar(title: Text('Header')),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          color: Colors.blue.shade100,
          child: Center(child: Text('No scroll body')),
        ),
      ),
    ],
  );
  print('SliverFillRemaining(hasScrollBody: false) created');

  // Variation 3: SliverOpacity at 0.5
  final widget3 = CustomScrollView(
    slivers: [
      SliverOpacity(
        opacity: 0.5,
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 100,
            color: Colors.blue,
            child: Center(child: Text('50% opacity')),
          ),
        ),
      ),
    ],
  );
  print('SliverOpacity(opacity: 0.5) created');

  // Variation 4: SliverOpacity at 1.0 (fully visible)
  final widget4 = CustomScrollView(
    slivers: [
      SliverOpacity(
        opacity: 1.0,
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 100,
            color: Colors.green,
            child: Center(child: Text('100% opacity')),
          ),
        ),
      ),
    ],
  );
  print('SliverOpacity(opacity: 1.0) created');

  // Variation 5: SliverOpacity at 0.0 (invisible)
  final widget5 = CustomScrollView(
    slivers: [
      SliverOpacity(
        opacity: 0.0,
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 100,
            color: Colors.red,
            child: Center(child: Text('0% opacity')),
          ),
        ),
      ),
    ],
  );
  print('SliverOpacity(opacity: 0.0) created');

  // Variation 6: Combined SliverOpacity and SliverFillRemaining
  final widget6 = CustomScrollView(
    slivers: [
      SliverOpacity(
        opacity: 0.7,
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 80,
            color: Colors.orange,
            child: Center(child: Text('Header at 70%')),
          ),
        ),
      ),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          color: Colors.purple.shade100,
          child: Center(child: Text('Remaining content')),
        ),
      ),
    ],
  );
  print('Combined SliverOpacity + SliverFillRemaining created');

  print('SliverFillRemaining/SliverOpacity test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      Expanded(child: widget2),
      Expanded(child: widget3),
      Expanded(child: widget4),
      Expanded(child: widget5),
      Expanded(child: widget6),
    ],
  );
}
