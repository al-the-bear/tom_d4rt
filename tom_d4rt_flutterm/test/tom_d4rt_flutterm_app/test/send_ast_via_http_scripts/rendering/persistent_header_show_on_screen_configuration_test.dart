// Deep demo for PersistentHeaderShowOnScreenConfiguration
// Configuration for showing persistent headers on screen with controlled expansion

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PersistentHeaderShowOnScreenConfiguration Demo', () {
    group('Constructor and properties', () {
      testWidgets('default configuration has infinite bounds',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration();

        expect(configuration.minShowOnScreenExtent, double.negativeInfinity);
        expect(configuration.maxShowOnScreenExtent, double.infinity);
      });

      testWidgets('custom min extent configuration',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 100.0,
        );

        expect(configuration.minShowOnScreenExtent, 100.0);
        expect(configuration.maxShowOnScreenExtent, double.infinity);
      });

      testWidgets('custom max extent configuration',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          maxShowOnScreenExtent: 250.0,
        );

        expect(configuration.minShowOnScreenExtent, double.negativeInfinity);
        expect(configuration.maxShowOnScreenExtent, 250.0);
      });

      testWidgets('both custom extents configuration',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 50.0,
          maxShowOnScreenExtent: 200.0,
        );

        expect(configuration.minShowOnScreenExtent, 50.0);
        expect(configuration.maxShowOnScreenExtent, 200.0);
      });

      testWidgets('zero extent values are valid', (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 0.0,
          maxShowOnScreenExtent: 0.0,
        );

        expect(configuration.minShowOnScreenExtent, 0.0);
        expect(configuration.maxShowOnScreenExtent, 0.0);
      });

      testWidgets('negative min extent is valid', (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: -100.0,
          maxShowOnScreenExtent: 100.0,
        );

        expect(configuration.minShowOnScreenExtent, -100.0);
        expect(configuration.maxShowOnScreenExtent, 100.0);
      });

      testWidgets('equal min and max extents are valid',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 150.0,
          maxShowOnScreenExtent: 150.0,
        );

        expect(configuration.minShowOnScreenExtent, 150.0);
        expect(configuration.maxShowOnScreenExtent, 150.0);
      });

      testWidgets('very large extent values are handled',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 1000000.0,
          maxShowOnScreenExtent: 9999999.0,
        );

        expect(configuration.minShowOnScreenExtent, 1000000.0);
        expect(configuration.maxShowOnScreenExtent, 9999999.0);
      });

      testWidgets('configuration properties are immutable',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 75.0,
          maxShowOnScreenExtent: 175.0,
        );

        var minExtent = configuration.minShowOnScreenExtent;
        var maxExtent = configuration.maxShowOnScreenExtent;

        expect(minExtent, 75.0);
        expect(maxExtent, 175.0);

        expect(configuration.minShowOnScreenExtent, minExtent);
        expect(configuration.maxShowOnScreenExtent, maxExtent);
      });

      testWidgets('multiple configurations can coexist independently',
          (WidgetTester tester) async {
        var config1 = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 50.0,
          maxShowOnScreenExtent: 100.0,
        );

        var config2 = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 75.0,
          maxShowOnScreenExtent: 200.0,
        );

        var config3 = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 100.0,
          maxShowOnScreenExtent: 300.0,
        );

        expect(config1.minShowOnScreenExtent, 50.0);
        expect(config2.minShowOnScreenExtent, 75.0);
        expect(config3.minShowOnScreenExtent, 100.0);

        expect(config1.maxShowOnScreenExtent, 100.0);
        expect(config2.maxShowOnScreenExtent, 200.0);
        expect(config3.maxShowOnScreenExtent, 300.0);
      });
    });

    group('minShowOnScreenExtent behavior', () {
      testWidgets('min extent affects header expansion lower bound',
          (WidgetTester tester) async {
        var headerHeight = ValueNotifier<double>(60.0);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: false,
                    floating: true,
                    delegate: _FlexibleHeaderDelegate(
                      minHeight: 50.0,
                      maxHeight: 150.0,
                      onHeightChanged: (height) {
                        headerHeight.value = height;
                      },
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 80.0,
                          color: index.isEven ? Colors.blue : Colors.green,
                          child: Center(
                            child: Text('Item $index'),
                          ),
                        );
                      },
                      childCount: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Item 0'), findsOneWidget);
        expect(find.byType(SliverPersistentHeader), findsOneWidget);
      });

      testWidgets('min extent with zero value constrains expansion',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 0.0,
        );

        expect(configuration.minShowOnScreenExtent, 0.0);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    floating: true,
                    delegate: _SimpleHeaderDelegate(
                      minExtent: 0.0,
                      maxExtent: 120.0,
                    ),
                  ),
                  SliverFillRemaining(
                    child: Container(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(CustomScrollView), findsOneWidget);
      });

      testWidgets('min extent near max extent restricts range',
          (WidgetTester tester) async {
        var config1 = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 95.0,
          maxShowOnScreenExtent: 100.0,
        );

        var range1 =
            config1.maxShowOnScreenExtent - config1.minShowOnScreenExtent;
        expect(range1, 5.0);

        var config2 = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 99.0,
          maxShowOnScreenExtent: 100.0,
        );

        var range2 =
            config2.maxShowOnScreenExtent - config2.minShowOnScreenExtent;
        expect(range2, 1.0);
      });

      testWidgets('min extent with negative infinity allows full collapse',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: double.negativeInfinity,
          maxShowOnScreenExtent: 200.0,
        );

        expect(configuration.minShowOnScreenExtent, double.negativeInfinity);
        expect(configuration.minShowOnScreenExtent.isNegative, true);
        expect(configuration.minShowOnScreenExtent.isInfinite, true);
      });

      testWidgets('min extent calculation with various values',
          (WidgetTester tester) async {
        var testValues = [10.0, 25.0, 50.0, 75.0, 100.0, 150.0, 200.0];

        for (var value in testValues) {
          var config = PersistentHeaderShowOnScreenConfiguration(
            minShowOnScreenExtent: value,
            maxShowOnScreenExtent: 500.0,
          );

          expect(config.minShowOnScreenExtent, value);
          expect(config.maxShowOnScreenExtent, 500.0);
        }
      });

      testWidgets('min extent affects floating header behavior',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    floating: true,
                    pinned: false,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 56.0,
                      maxExtent: 200.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 56.0,
                        maxShowOnScreenExtent: 200.0,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(title: Text('List item $index'));
                      },
                      childCount: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(SliverPersistentHeader), findsOneWidget);
      });
    });

    group('maxShowOnScreenExtent behavior', () {
      testWidgets('max extent limits header expansion upper bound',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          maxShowOnScreenExtent: 150.0,
        );

        expect(configuration.maxShowOnScreenExtent, 150.0);
        expect(configuration.maxShowOnScreenExtent.isFinite, true);
      });

      testWidgets('max extent with infinity allows unlimited expansion',
          (WidgetTester tester) async {
        var configuration = PersistentHeaderShowOnScreenConfiguration(
          maxShowOnScreenExtent: double.infinity,
        );

        expect(configuration.maxShowOnScreenExtent, double.infinity);
        expect(configuration.maxShowOnScreenExtent.isInfinite, true);
      });

      testWidgets('max extent boundary conditions',
          (WidgetTester tester) async {
        var config = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 0.0,
          maxShowOnScreenExtent: 0.1,
        );

        expect(config.maxShowOnScreenExtent, 0.1);
        expect(config.maxShowOnScreenExtent > config.minShowOnScreenExtent,
            true);
      });

      testWidgets('max extent with large values',
          (WidgetTester tester) async {
        var largeValues = [1000.0, 5000.0, 10000.0, 50000.0];

        for (var value in largeValues) {
          var config = PersistentHeaderShowOnScreenConfiguration(
            maxShowOnScreenExtent: value,
          );

          expect(config.maxShowOnScreenExtent, value);
        }
      });

      testWidgets('max extent affects sliver behavior in scroll view',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 60.0,
                      maxExtent: 180.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 60.0,
                        maxShowOnScreenExtent: 180.0,
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 60.0,
                          color: index.isEven ? Colors.red : Colors.orange,
                          child: Center(child: Text('Nested item $index')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(SliverPersistentHeader), findsOneWidget);
      });

      testWidgets('max extent interaction with scroll position',
          (WidgetTester tester) async {
        var scrollController = ScrollController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverPersistentHeader(
                    floating: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 50.0,
                      maxExtent: 200.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        maxShowOnScreenExtent: 150.0,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 100.0,
                          color: Colors.primaries[index % Colors.primaries.length],
                          child: Text('Item $index'),
                        );
                      },
                      childCount: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        scrollController.jumpTo(300.0);
        await tester.pumpAndSettle();

        scrollController.jumpTo(0.0);
        await tester.pumpAndSettle();

        expect(scrollController.offset, 0.0);

        scrollController.dispose();
      });
    });

    group('Integration with SliverPersistentHeader', () {
      testWidgets('configuration with pinned header',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 60.0,
                      maxExtent: 200.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 60.0,
                        maxShowOnScreenExtent: 200.0,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _ListItemWidget(index: index);
                      },
                      childCount: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(SliverPersistentHeader), findsOneWidget);
      });

      testWidgets('configuration with floating header',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    floating: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 56.0,
                      maxExtent: 150.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 56.0,
                        maxShowOnScreenExtent: 150.0,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _ListItemWidget(index: index);
                      },
                      childCount: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(SliverPersistentHeader), findsOneWidget);
      });

      testWidgets('configuration with pinned and floating header',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 48.0,
                      maxExtent: 180.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 48.0,
                        maxShowOnScreenExtent: 180.0,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _ListItemWidget(index: index);
                      },
                      childCount: 45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(SliverPersistentHeader), findsOneWidget);
      });

      testWidgets('multiple headers with different configurations',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 40.0,
                      maxExtent: 100.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 40.0,
                        maxShowOnScreenExtent: 100.0,
                      ),
                      label: 'Header 1',
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 50.0,
                          color: Colors.blue.shade100,
                          child: Text('Section 1 - Item $index'),
                        );
                      },
                      childCount: 10,
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 50.0,
                      maxExtent: 120.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 50.0,
                        maxShowOnScreenExtent: 120.0,
                      ),
                      label: 'Header 2',
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 50.0,
                          color: Colors.green.shade100,
                          child: Text('Section 2 - Item $index'),
                        );
                      },
                      childCount: 10,
                    ),
                  ),
                  SliverPersistentHeader(
                    floating: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 45.0,
                      maxExtent: 90.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 45.0,
                        maxShowOnScreenExtent: 90.0,
                      ),
                      label: 'Header 3',
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 50.0,
                          color: Colors.orange.shade100,
                          child: Text('Section 3 - Item $index'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(SliverPersistentHeader), findsNWidgets(3));
      });

      testWidgets('header with SliverAppBar uses configuration',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('App Bar'),
                      background: Container(color: Colors.purple),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _ListItemWidget(index: index);
                      },
                      childCount: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(SliverAppBar), findsOneWidget);
      });

      testWidgets('scroll interaction with configured header',
          (WidgetTester tester) async {
        var scrollController = ScrollController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 56.0,
                      maxExtent: 200.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 56.0,
                        maxShowOnScreenExtent: 200.0,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 80.0,
                          color: Colors.primaries[index % Colors.primaries.length],
                          child: Center(child: Text('Item $index')),
                        );
                      },
                      childCount: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        await tester.drag(find.byType(CustomScrollView), Offset(0, -500));
        await tester.pumpAndSettle();

        expect(scrollController.offset > 0, true);

        await tester.drag(find.byType(CustomScrollView), Offset(0, 500));
        await tester.pumpAndSettle();

        scrollController.dispose();
      });
    });

    group('Visual comparison of different configurations', () {
      testWidgets('minimal configuration vs maximal configuration',
          (WidgetTester tester) async {
        var minimalConfig = PersistentHeaderShowOnScreenConfiguration();
        var maximalConfig = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 0.0,
          maxShowOnScreenExtent: 1000.0,
        );

        expect(minimalConfig.minShowOnScreenExtent, double.negativeInfinity);
        expect(maximalConfig.minShowOnScreenExtent, 0.0);

        expect(minimalConfig.maxShowOnScreenExtent, double.infinity);
        expect(maximalConfig.maxShowOnScreenExtent, 1000.0);
      });

      testWidgets('tight configuration with small range',
          (WidgetTester tester) async {
        var tightConfig = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 55.0,
          maxShowOnScreenExtent: 60.0,
        );

        var range =
            tightConfig.maxShowOnScreenExtent - tightConfig.minShowOnScreenExtent;
        expect(range, 5.0);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 55.0,
                      maxExtent: 60.0,
                      showOnScreenConfiguration: tightConfig,
                      label: 'Tight Header',
                    ),
                  ),
                  SliverFillRemaining(
                    child: Container(color: Colors.grey.shade200),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Tight Header'), findsOneWidget);
      });

      testWidgets('wide configuration with large range',
          (WidgetTester tester) async {
        var wideConfig = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 50.0,
          maxShowOnScreenExtent: 500.0,
        );

        var range =
            wideConfig.maxShowOnScreenExtent - wideConfig.minShowOnScreenExtent;
        expect(range, 450.0);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    floating: true,
                    delegate: _ConfigurableHeaderDelegate(
                      minExtent: 50.0,
                      maxExtent: 500.0,
                      showOnScreenConfiguration: wideConfig,
                      label: 'Wide Header',
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 70.0,
                          color: Colors.teal.shade100,
                          child: Text('Wide content $index'),
                        );
                      },
                      childCount: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Wide Header'), findsOneWidget);
      });

      testWidgets('comparison of pinned vs floating with same configuration',
          (WidgetTester tester) async {
        var sharedConfig = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 48.0,
          maxShowOnScreenExtent: 150.0,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _ConfigurableHeaderDelegate(
                            minExtent: 48.0,
                            maxExtent: 150.0,
                            showOnScreenConfiguration: sharedConfig,
                            label: 'Pinned',
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Container(
                                height: 40.0,
                                alignment: Alignment.centerLeft,
                                color: Colors.blue.shade50,
                                child: Text('P-$index'),
                              );
                            },
                            childCount: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverPersistentHeader(
                          floating: true,
                          delegate: _ConfigurableHeaderDelegate(
                            minExtent: 48.0,
                            maxExtent: 150.0,
                            showOnScreenConfiguration: sharedConfig,
                            label: 'Floating',
                            backgroundColor: Colors.green,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Container(
                                height: 40.0,
                                alignment: Alignment.centerLeft,
                                color: Colors.green.shade50,
                                child: Text('F-$index'),
                              );
                            },
                            childCount: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Pinned'), findsOneWidget);
        expect(find.text('Floating'), findsOneWidget);
      });

      testWidgets('extreme configurations boundary test',
          (WidgetTester tester) async {
        var extremeMin = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: double.negativeInfinity,
          maxShowOnScreenExtent: 1.0,
        );

        var extremeMax = PersistentHeaderShowOnScreenConfiguration(
          minShowOnScreenExtent: 999999.0,
          maxShowOnScreenExtent: double.infinity,
        );

        expect(extremeMin.minShowOnScreenExtent.isInfinite, true);
        expect(extremeMin.maxShowOnScreenExtent.isFinite, true);

        expect(extremeMax.minShowOnScreenExtent.isFinite, true);
        expect(extremeMax.maxShowOnScreenExtent.isInfinite, true);
      });

      testWidgets('visual test with colored headers showing extent ranges',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ColoredExtentHeaderDelegate(
                      minExtent: 60.0,
                      maxExtent: 120.0,
                      collapsedColor: Colors.red.shade700,
                      expandedColor: Colors.red.shade200,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 60.0,
                        maxShowOnScreenExtent: 120.0,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 60.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(child: Text('Content item $index')),
                        );
                      },
                      childCount: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(SliverPersistentHeader), findsOneWidget);
      });

      testWidgets('configuration effect on nested scroll views',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverPersistentHeader(
                        pinned: true,
                        delegate: _ConfigurableHeaderDelegate(
                          minExtent: 56.0,
                          maxExtent: 200.0,
                          showOnScreenConfiguration:
                              PersistentHeaderShowOnScreenConfiguration(
                            minShowOnScreenExtent: 56.0,
                            maxShowOnScreenExtent: 200.0,
                          ),
                          label: 'Nested Header',
                        ),
                      ),
                    ),
                  ];
                },
                body: Builder(
                  builder: (context) {
                    return CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Container(
                                height: 72.0,
                                color: index.isEven
                                    ? Colors.amber.shade50
                                    : Colors.amber.shade100,
                                child: ListTile(
                                  title: Text('Nested item $index'),
                                  subtitle: Text('Subtitle for item $index'),
                                ),
                              );
                            },
                            childCount: 30,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Nested Header'), findsOneWidget);
      });

      testWidgets('visual demo with animated scroll interactions',
          (WidgetTester tester) async {
        var scrollController = ScrollController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _AnimatedHeaderDelegate(
                      minExtent: 64.0,
                      maxExtent: 256.0,
                      showOnScreenConfiguration:
                          PersistentHeaderShowOnScreenConfiguration(
                        minShowOnScreenExtent: 64.0,
                        maxShowOnScreenExtent: 256.0,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 88.0,
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.primaries[index % Colors.primaries.length]
                                    .shade300,
                                Colors.primaries[index % Colors.primaries.length]
                                    .shade100,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              'Animated item $index',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        for (var i = 0; i < 5; i++) {
          await tester.drag(find.byType(CustomScrollView), Offset(0, -100));
          await tester.pump(Duration(milliseconds: 100));
        }
        await tester.pumpAndSettle();

        for (var i = 0; i < 3; i++) {
          await tester.drag(find.byType(CustomScrollView), Offset(0, 150));
          await tester.pump(Duration(milliseconds: 100));
        }
        await tester.pumpAndSettle();

        scrollController.dispose();
      });

      testWidgets('configuration comparison table visualization',
          (WidgetTester tester) async {
        var configurations = <String, PersistentHeaderShowOnScreenConfiguration>{
          'Default': PersistentHeaderShowOnScreenConfiguration(),
          'Constrained': PersistentHeaderShowOnScreenConfiguration(
            minShowOnScreenExtent: 50.0,
            maxShowOnScreenExtent: 100.0,
          ),
          'Expansive': PersistentHeaderShowOnScreenConfiguration(
            minShowOnScreenExtent: 0.0,
            maxShowOnScreenExtent: 500.0,
          ),
          'Fixed': PersistentHeaderShowOnScreenConfiguration(
            minShowOnScreenExtent: 75.0,
            maxShowOnScreenExtent: 75.0,
          ),
        };

        expect(configurations.length, 4);

        for (var entry in configurations.entries) {
          var name = entry.key;
          var config = entry.value;

          if (name == 'Default') {
            expect(config.minShowOnScreenExtent, double.negativeInfinity);
            expect(config.maxShowOnScreenExtent, double.infinity);
          } else if (name == 'Constrained') {
            expect(config.minShowOnScreenExtent, 50.0);
            expect(config.maxShowOnScreenExtent, 100.0);
          } else if (name == 'Expansive') {
            expect(config.minShowOnScreenExtent, 0.0);
            expect(config.maxShowOnScreenExtent, 500.0);
          } else if (name == 'Fixed') {
            expect(config.minShowOnScreenExtent, 75.0);
            expect(config.maxShowOnScreenExtent, 75.0);
          }
        }
      });
    });
  });
}

class _FlexibleHeaderDelegate extends SliverPersistentHeaderDelegate {
  _FlexibleHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    this.onHeightChanged,
  });

  final double minHeight;
  final double maxHeight;
  final void Function(double)? onHeightChanged;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var currentHeight = maxHeight - shrinkOffset;
    if (currentHeight < minHeight) {
      currentHeight = minHeight;
    }
    onHeightChanged?.call(currentHeight);

    return Container(
      height: currentHeight,
      color: Colors.blue.shade300,
      child: Center(
        child: Text(
          'Height: ${currentHeight.toStringAsFixed(1)}',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _FlexibleHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight;
  }
}

class _SimpleHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SimpleHeaderDelegate({
    required double minExtent,
    required double maxExtent,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent;

  final double _minExtent;
  final double _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.teal,
      child: Center(
        child: Text('Simple Header'),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SimpleHeaderDelegate oldDelegate) {
    return _minExtent != oldDelegate._minExtent ||
        _maxExtent != oldDelegate._maxExtent;
  }
}

class _ConfigurableHeaderDelegate extends SliverPersistentHeaderDelegate {
  _ConfigurableHeaderDelegate({
    required double minExtent,
    required double maxExtent,
    PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration,
    this.label,
    this.backgroundColor,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent,
        _showOnScreenConfiguration = showOnScreenConfiguration;

  final double _minExtent;
  final double _maxExtent;
  final PersistentHeaderShowOnScreenConfiguration? _showOnScreenConfiguration;
  final String? label;
  final Color? backgroundColor;

  @override
  double get minExtent => _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      _showOnScreenConfiguration;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var progress = shrinkOffset / (maxExtent - minExtent);
    if (progress > 1.0) progress = 1.0;
    if (progress < 0.0) progress = 0.0;

    return Container(
      color: backgroundColor ?? Colors.indigo.shade400,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 16.0,
            bottom: 12.0,
            child: Text(
              label ?? 'Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0 - (progress * 4.0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 16.0,
            bottom: 12.0,
            child: Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _ConfigurableHeaderDelegate oldDelegate) {
    return _minExtent != oldDelegate._minExtent ||
        _maxExtent != oldDelegate._maxExtent ||
        label != oldDelegate.label ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}

class _ColoredExtentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _ColoredExtentHeaderDelegate({
    required double minExtent,
    required double maxExtent,
    required this.collapsedColor,
    required this.expandedColor,
    PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent,
        _showOnScreenConfiguration = showOnScreenConfiguration;

  final double _minExtent;
  final double _maxExtent;
  final Color collapsedColor;
  final Color expandedColor;
  final PersistentHeaderShowOnScreenConfiguration? _showOnScreenConfiguration;

  @override
  double get minExtent => _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      _showOnScreenConfiguration;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var progress = shrinkOffset / (maxExtent - minExtent);
    if (progress > 1.0) progress = 1.0;
    if (progress < 0.0) progress = 0.0;

    var currentColor = Color.lerp(expandedColor, collapsedColor, progress);

    return Container(
      color: currentColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Extent Range Demo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Progress: ${(progress * 100).toStringAsFixed(1)}%',
              style: TextStyle(color: Colors.white70, fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _ColoredExtentHeaderDelegate oldDelegate) {
    return _minExtent != oldDelegate._minExtent ||
        _maxExtent != oldDelegate._maxExtent ||
        collapsedColor != oldDelegate.collapsedColor ||
        expandedColor != oldDelegate.expandedColor;
  }
}

class _AnimatedHeaderDelegate extends SliverPersistentHeaderDelegate {
  _AnimatedHeaderDelegate({
    required double minExtent,
    required double maxExtent,
    PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent,
        _showOnScreenConfiguration = showOnScreenConfiguration;

  final double _minExtent;
  final double _maxExtent;
  final PersistentHeaderShowOnScreenConfiguration? _showOnScreenConfiguration;

  @override
  double get minExtent => _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      _showOnScreenConfiguration;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var progress = shrinkOffset / (maxExtent - minExtent);
    if (progress > 1.0) progress = 1.0;
    if (progress < 0.0) progress = 0.0;

    var backgroundColor = ColorTween(
      begin: Colors.deepPurple.shade400,
      end: Colors.deepPurple.shade900,
    ).lerp(progress);

    var iconSize = 48.0 - (progress * 24.0);
    var titleSize = 24.0 - (progress * 8.0);

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 16.0 + (progress * 40.0),
              top: 0,
              bottom: 0,
              child: Center(
                child: Icon(
                  Icons.animation,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 80.0 + (progress * 20.0),
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  'Animated Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (progress < 0.5)
              Positioned(
                left: 80.0,
                bottom: 8.0,
                child: Opacity(
                  opacity: 1.0 - (progress * 2.0),
                  child: Text(
                    'Scroll to see animation',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _AnimatedHeaderDelegate oldDelegate) {
    return _minExtent != oldDelegate._minExtent ||
        _maxExtent != oldDelegate._maxExtent;
  }
}

class _ListItemWidget extends StatelessWidget {
  _ListItemWidget({required this.index}) : _creationTime = DateTime.now();

  final int index;
  final DateTime _creationTime;

  @override
  Widget build(BuildContext context) {
    var alphaValue = ((_creationTime.millisecond % 100) / 100.0 * 0.1 + 0.9);
    return Container(
      height: 72.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: alphaValue),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Colors.primaries[index % Colors.primaries.length].shade200,
          child: Text('${index + 1}'),
        ),
        title: Text('List Item ${index + 1}'),
        subtitle: Text('Description for item ${index + 1}'),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
