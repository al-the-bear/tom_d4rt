import 'package:flutter_test/flutter_test.dart';

import 'package:tom_d4rt_flutterm_app/main.dart';

void main() {
  testWidgets('App renders and shows waiting state', (WidgetTester tester) async {
    await tester.pumpWidget(const D4rtFlutterApp());

    expect(find.text('D4rt Flutter Bridge Test'), findsOneWidget);
    expect(find.text('Waiting for D4rt widget...'), findsOneWidget);
  });
}
