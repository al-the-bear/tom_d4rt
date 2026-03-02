// D4rt test script: Tests NestedScrollView from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NestedScrollView test executing');

  // Variation 1: Basic NestedScrollView with SliverAppBar and ListView body
  final widget1 = NestedScrollView(
    headerSliverBuilder: (context, innerBoxScrolled) => [
      SliverAppBar(
        title: Text('Nested'),
        floating: true,
      ),
    ],
    body: ListView(
      children: [
        Container(height: 50, color: Colors.blue),
        Container(height: 50, color: Colors.red),
      ],
    ),
  );
  print('NestedScrollView(SliverAppBar floating) created');

  // Variation 2: NestedScrollView with SliverToBoxAdapter header
  final widget2 = NestedScrollView(
    headerSliverBuilder: (context, innerBoxScrolled) => [
      SliverToBoxAdapter(
        child: Container(
          height: 100,
          color: Colors.green,
          child: Center(child: Text('Header')),
        ),
      ),
    ],
    body: ListView(
      children: [
        Container(height: 50, color: Colors.orange),
        Container(height: 50, color: Colors.purple),
      ],
    ),
  );
  print('NestedScrollView(SliverToBoxAdapter header) created');

  // Variation 3: NestedScrollView with pinned SliverAppBar
  final widget3 = NestedScrollView(
    headerSliverBuilder: (context, innerBoxScrolled) => [
      SliverAppBar(
        title: Text('Pinned'),
        pinned: true,
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(color: Colors.teal),
        ),
      ),
    ],
    body: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    ),
  );
  print('NestedScrollView(pinned SliverAppBar) created');

  // Variation 4: NestedScrollView with multiple sliver headers
  final widget4 = NestedScrollView(
    headerSliverBuilder: (context, innerBoxScrolled) => [
      SliverAppBar(
        title: Text('Multi Header'),
        floating: true,
        snap: true,
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 60,
          color: Colors.amber,
          child: Center(child: Text('Sub-header')),
        ),
      ),
    ],
    body: ListView(
      children: [
        Container(height: 80, color: Colors.cyan),
        Container(height: 80, color: Colors.lime),
      ],
    ),
  );
  print('NestedScrollView(multiple sliver headers) created');

  print('NestedScrollView test completed');
  return Column(children: [
    Expanded(child: widget1),
    Expanded(child: widget2),
    Expanded(child: widget3),
    Expanded(child: widget4),
  ]);
}
