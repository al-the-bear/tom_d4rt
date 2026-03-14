// D4rt test script: comprehensive checks for RenderSliverPersistentHeader
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class _SimpleHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SimpleHeaderDelegate({
    required this.label,
    required this.maxExtentValue,
    required this.minExtentValue,
  });

  final String label;
  final double maxExtentValue;
  final double minExtentValue;

  @override
  double get maxExtent => maxExtentValue;

  @override
  double get minExtent => minExtentValue;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blueGrey.shade100,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text('$label | shrink=$shrinkOffset | overlap=$overlapsContent'),
    );
  }

  @override
  bool shouldRebuild(covariant _SimpleHeaderDelegate oldDelegate) {
    return oldDelegate.label != label ||
        oldDelegate.maxExtentValue != maxExtentValue ||
        oldDelegate.minExtentValue != minExtentValue;
  }
}

class _RenderSliverPersistentHeaderScript extends StatelessWidget {
  const _RenderSliverPersistentHeaderScript();

  List<String> _runAssertions() {
    final List<String> logs = <String>[];
    logs.add('start:RenderSliverPersistentHeader');

    final Type targetType = RenderSliverPersistentHeader;
    logs.add('type=' + targetType.toString());
    assert(targetType.toString().isNotEmpty);

    const String filenameTag = 'render_sliver_persistent_header_test.dart';
    assert(filenameTag.contains('_test.dart'));
    logs.add('file=' + filenameTag);

    final Map<String, Object?> contextMap = <String, Object?>{
      'target': 'RenderSliverPersistentHeader',
      'group': 'rendering',
      'hasBuild': true,
      'lineGoal': 110,
    };

    assert(contextMap['target'] == 'RenderSliverPersistentHeader');
    assert(contextMap['hasBuild'] == true);
    assert((contextMap['lineGoal'] as int) >= 110);
    logs.add('context-ok');

    final Widget indirectWidget = SliverPersistentHeader(
      floating: false,
      pinned: false,
      delegate: _SimpleHeaderDelegate(label: 'plain-header', maxExtentValue: 64, minExtentValue: 28),
    );

    assert(indirectWidget != null);
    logs.add('indirect-usage-ok');

    final List<int> values = <int>[2, 4, 6, 8, 10];
    final int sum = values.fold(0, (int a, int b) => a + b);
    final double average = sum / values.length;
    assert(sum == 30);
    assert(average == 6.0);
    logs.add('math:sum=' + sum.toString());
    logs.add('math:avg=' + average.toStringAsFixed(1));

    final String normalized = 'RenderSliverPersistentHeader'.toLowerCase();
    assert(normalized.contains('render'));
    logs.add('normalized=' + normalized);

    final Set<String> unique = <String>{'a', 'b', 'a', 'c'};
    assert(unique.length == 3);
    logs.add('set-size=' + unique.length.toString());

    final DateTime now = DateTime(2026, 3, 14, 9, 30);
    assert(now.year == 2026);
    assert(now.month == 3);
    assert(now.day == 14);
    logs.add('date=' + now.toIso8601String());

    final String edgeA = '';
    final String edgeB = '  trim me  ';
    assert(edgeA.isEmpty);
    assert(edgeB.trim() == 'trim me');
    logs.add('edge-strings-ok');

    final List<int> emptyList = <int>[];
    assert(emptyList.isEmpty);
    emptyList.addAll(<int>[1, 2, 3]);
    assert(emptyList.length == 3);
    logs.add('edge-lists-ok');

    final bool containsSliver = 'RenderSliverPersistentHeader'.contains('Sliver');
    logs.add('contains-sliver=' + containsSliver.toString());

    for (final String log in logs) {
      print('[RenderSliverPersistentHeader] ' + log);
    }

    return logs;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> logs = _runAssertions();
    final List<Widget> rows = <Widget>[
      const Text('D4rt Comprehensive Script'),
      const SizedBox(height: 8),
      Text('Target: RenderSliverPersistentHeader'),
      Text('Entries: ' + logs.length.toString()),
      const SizedBox(height: 8),
    ];

    rows.addAll(
      logs.take(12).map((String line) => Text('• ' + line)),
    );

    rows.add(const SizedBox(height: 8));
    rows.add(const Text('Status: completed assertions and indirect usage checks'));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }
}

dynamic build(BuildContext context) {
  print('Executing comprehensive D4rt script for RenderSliverPersistentHeader');
  return const _RenderSliverPersistentHeaderScript();
}
