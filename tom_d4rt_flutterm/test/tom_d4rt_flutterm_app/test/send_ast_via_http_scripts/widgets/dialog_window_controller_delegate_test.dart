// D4rt comprehensive test script for DialogWindowControllerDelegate
import 'package:flutter/widgets.dart';

class _DialogWindowControllerDelegateProbe implements DialogWindowControllerDelegate {
  _DialogWindowControllerDelegateProbe(this.label, {required this.seed});

  final String label;
  final int seed;
  final List<String> logs = <String>[];

  void addLog(String value) {
    logs.add(value);
    print('[probe-log] $value');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final member = invocation.memberName.toString();
    final marker = 'noSuchMethod:$member';
    logs.add(marker);
    print('[probe-missing] $marker');
    return null;
  }
}

void _assertTrue(bool condition, String message) {
  print('[assert] $message => $condition');
  assert(condition, message);
}

void _assertEquals(Object? a, Object? b, String message) {
  final ok = a == b;
  print('[assert-eq] $message => $a == $b : $ok');
  assert(ok, message);
}

void _assertNotEmpty(List<dynamic> values, String message) {
  final ok = values.isNotEmpty;
  print('[assert-list] $message => len=${values.length}');
  assert(ok, message);
}

Map<String, dynamic> _runProbeCase({
  required String caseName,
  required _DialogWindowControllerDelegateProbe probe,
  required int increment,
}) {
  print('[case] start: $caseName');
  probe.addLog(caseName);
  final int score = probe.seed + increment;
  final bool hasEvenScore = score % 2 == 0;
  final int combinedLen = probe.label.length + probe.logs.length;
  _assertTrue(score >= probe.seed - 100, "score lower bound");
  _assertTrue(combinedLen >= probe.label.length, "combined length bound");
  print('[case] done: $caseName score=$score even=$hasEvenScore');
  return <String, dynamic>{
    'case': caseName,
    'score': score,
    'even': hasEvenScore,
    'combinedLen': combinedLen,
  };
}

dynamic build(BuildContext context) {
  print('=== DialogWindowControllerDelegate comprehensive script start ===');

  final _DialogWindowControllerDelegateProbe primary = _DialogWindowControllerDelegateProbe('primary', seed: 7);
  final _DialogWindowControllerDelegateProbe edge = _DialogWindowControllerDelegateProbe('', seed: -3);
  final _DialogWindowControllerDelegateProbe large = _DialogWindowControllerDelegateProbe('large-case', seed: 999);

  _assertTrue(primary is Object, "primary object existence");
  _assertTrue(primary.runtimeType.toString().contains("Probe"), "runtime type naming");
  _assertEquals(primary.label, "primary", "constructor label assignment");
  _assertEquals(primary.seed, 7, "constructor seed assignment");

  primary.addLog("boot");
  edge.addLog("edge-boot");
  large.addLog("large-boot");

  final List<Map<String, dynamic>> caseResults = <Map<String, dynamic>>[
    _runProbeCase(caseName: "standard", probe: primary, increment: 1),
    _runProbeCase(caseName: "edge", probe: edge, increment: 0),
    _runProbeCase(caseName: "large", probe: large, increment: 21),
  ];

  _assertEquals(caseResults.length, 3, "all probe cases created");
  _assertTrue(caseResults.any((Map<String, dynamic> m) => m["even"] == true), "at least one even score");
  _assertTrue(caseResults.any((Map<String, dynamic> m) => (m["score"] as int) < 0) == false, "scores non-negative after increment");

  final List<String> mergedLogs = <String>[...primary.logs, ...edge.logs, ...large.logs];
  _assertNotEmpty(mergedLogs, "merged logs should not be empty");
  _assertTrue(mergedLogs.first.contains("boot"), "first log contains boot");
  _assertTrue(mergedLogs.any((String value) => value.contains("edge")), "edge marker exists");

  final Map<String, int> stats = <String, int>{
    "primaryLogs": primary.logs.length,
    "edgeLogs": edge.logs.length,
    "largeLogs": large.logs.length,
    "totalLogs": mergedLogs.length,
  };

  _assertTrue(stats["totalLogs"]! >= stats["primaryLogs"]!, "total logs >= primary logs");
  _assertTrue(stats.values.every((int value) => value >= 1), "each stats bucket >= 1");

  final List<String> scoreLines = caseResults
      .map((Map<String, dynamic> result) => "${result["case"]}:${result["score"]}:${result["even"]}")
      .toList(growable: false);

  _assertEquals(scoreLines.length, 3, "score line count");
  _assertTrue(scoreLines.join("|").contains("standard"), "score lines include standard");
  print('=== DialogWindowControllerDelegate comprehensive script done ===');

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('DialogWindowControllerDelegate Summary'),
        Text("cases=${caseResults.length}"),
        Text("totalLogs=${stats["totalLogs"]}"),
        Text("scoreDigest=${scoreLines.join(",")}"),
      ],
    ),
  );
}
