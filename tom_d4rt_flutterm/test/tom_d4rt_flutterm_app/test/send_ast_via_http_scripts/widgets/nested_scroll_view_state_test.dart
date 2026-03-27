// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NestedScrollViewState from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NestedScrollViewState test executing');
  print('=' * 50);

  // === Test NestedScrollViewState class ===
  print('\nNestedScrollViewState manages NestedScrollView state');

  // Describe NestedScrollViewState
  print('\n--- Understanding NestedScrollViewState ---');
  print('State class for NestedScrollView widget');
  print('Manages coordination between outer/inner scroll');
  print('Provides innerController and outerController');

  // Test via NestedScrollView
  print('\n--- Testing via NestedScrollView ---');
  final nestedScrollView = NestedScrollView(
    headerSliverBuilder: (context, innerBoxIsScrolled) {
      return [
        SliverAppBar(
          title: Text('Header'),
          floating: true,
          snap: true,
          expandedHeight: 150,
        ),
      ];
    },
    body: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(
        title: Text('Item $index'),
      ),
    ),
  );
  print('Created NestedScrollView');
  print('nestedScrollView.runtimeType: ${nestedScrollView.runtimeType}');

  // Key properties
  print('\n--- Key properties via State ---');
  print('innerController: ScrollController for body');
  print('outerController: ScrollController for header area');

  // Test floatHeaderSlivers
  print('\n--- Testing floatHeaderSlivers ---');
  final floatingView = NestedScrollView(
    floatHeaderSlivers: true,
    headerSliverBuilder: (ctx, scrolled) => [
      SliverAppBar(title: Text('Floating')),
    ],
    body: Center(child: Text('Body')),
  );
  print('Created with floatHeaderSlivers: true');
  print('floatingView.floatHeaderSlivers: ${floatingView.floatHeaderSlivers}');

  // Test clipBehavior
  print('\n--- Testing clipBehavior ---');
  print('Default: Clip.hardEdge');

  // Test scrollDirection
  print('\n--- Testing scrollDirection ---');
  print('Default: Axis.vertical');
  print('Horizontal not commonly used');

  // State access pattern
  print('\n--- Accessing State ---');
  print('final state = key.currentState as NestedScrollViewState');
  print('state.innerController');
  print('state.outerController');

  print('\n' + '=' * 50);
  print('NestedScrollViewState test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NestedScrollViewState Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('floatHeaderSlivers: ${floatingView.floatHeaderSlivers}'),
      Text('Purpose: Coordinate nested scrolls'),
      SizedBox(height: 100, child: nestedScrollView),
    ],
  );
}
