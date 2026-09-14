// ignore_for_file: avoid_print
// D4rt deep-demo: ChildSemanticsConfigurationsResultBuilder — Coral / Shell theme, prefix cb
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget cbSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFE65100), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Color(0xFFBF360C))),
        ),
      ],
    ),
  );
}

Widget cbChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12.0)),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget cbInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 150.0,
          child: Text(label, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFFBF360C)))),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 12.0, color: Color(0xFF8D6E63)))),
      ],
    ),
  );
}

Widget cbCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(color: Color(0xFFFBE9E7), borderRadius: BorderRadius.circular(6.0)),
    child: Text(code, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFFBF360C))),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ── Section 1: Title ──────────────────────────────────────────
  print('\n[1] ChildSemanticsConfigurationsResultBuilder');
  print('  Builder pattern for assembling semantics node results');
  print('  Used in RenderObject.assembleSemanticsNode');

  final cbTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE65100), Color(0xFFBF360C)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('ChildSemanticsConfigurationsResultBuilder',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Builder for partitioning child semantics configurations into merged/siblingMergeUp groups',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFFFCCBC))),
        SizedBox(height: 8.0),
        Wrap(children: [
          cbChip('Builder Pattern', Color(0xFFF4511E)),
          cbChip('Semantics', Color(0xFFE64A19)),
          cbChip('Accessibility', Color(0xFFD84315)),
          cbChip('RenderObject', Color(0xFFBF360C)),
        ]),
      ],
    ),
  );

  // ── Section 2: What It Does ──────────────────────────────────
  print('\n[2] Purpose & Context');
  print('  Partitions child SemanticsConfiguration into groups');
  print('  Determines which configs merge into parent vs stay separate');

  final cbPurposeSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('During semantics assembly, child configurations must be sorted:',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color(0xFFE65100).withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.merge_type, color: Color(0xFFE65100), size: 28.0),
                    SizedBox(height: 4.0),
                    Text('Merged', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xFFE65100))),
                    SizedBox(height: 4.0),
                    Text('Configs folded into the parent semantics node',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color(0xFFBF360C).withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.call_split, color: Color(0xFFBF360C), size: 28.0),
                    SizedBox(height: 4.0),
                    Text('Sibling Merge Up', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xFFBF360C))),
                    SizedBox(height: 4.0),
                    Text('Configs that become separate sibling nodes',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ── Section 3: Class API ─────────────────────────────────────
  print('\n[3] Class API');
  print('  markAsSiblingMergeUp() — mark a config as sibling');
  print('  build() — produce the ChildSemanticsConfigurationsResult');

  final apiMethods = <Map<String, dynamic>>[
    {'method': 'markAsSiblingMergeUp()', 'color': Color(0xFFF4511E),
     'sig': 'void markAsSiblingMergeUp(SemanticsConfiguration config)',
     'desc': 'Marks a child configuration to be merged as a sibling node rather than into the parent'},
    {'method': 'build()', 'color': Color(0xFFE64A19),
     'sig': 'ChildSemanticsConfigurationsResult build()',
     'desc': 'Produces the partitioned result with mergeUp and siblingMergeUp lists'},
  ];

  final cbApiSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      children: apiMethods.map((am) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border(left: BorderSide(color: am['color'] as Color, width: 4.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(am['method'] as String,
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                      fontFamily: 'monospace', color: am['color'] as Color)),
              SizedBox(height: 2.0),
              Text(am['sig'] as String,
                  style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFFBF360C))),
              SizedBox(height: 4.0),
              Text(am['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 4: ChildSemanticsConfigurationsResult ────────────
  print('\n[4] ChildSemanticsConfigurationsResult');
  print('  mergeUp: List<SemanticsConfiguration>');
  print('  siblingMergeUp: List<SemanticsConfiguration>');

  final cbResultSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The output of the builder — two lists of configurations',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ChildSemanticsConfigurationsResult',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                      fontFamily: 'monospace', color: Color(0xFFE65100))),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(width: 4.0, height: 40.0, color: Color(0xFFF4511E)),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('mergeUp', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                            fontFamily: 'monospace', color: Color(0xFFF4511E))),
                        Text('Configs that fold into the parent SemanticsNode',
                            style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63))),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Row(
                children: [
                  Container(width: 4.0, height: 40.0, color: Color(0xFFBF360C)),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('siblingMergeUp', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                            fontFamily: 'monospace', color: Color(0xFFBF360C))),
                        Text('Configs that become separate sibling SemanticsNodes',
                            style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        cbCodeBlock('ChildSemanticsConfigurationsResult(\n  mergeUp: [config1, config2],\n  siblingMergeUp: [config3],\n)'),
      ],
    ),
  );

  // ── Section 5: Usage Context ─────────────────────────────────
  print('\n[5] Where It Lives: assembleSemanticsNode');

  final cbUsageSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The builder is typically used inside childSemanticsConfigurationsDelegate',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 10.0),
        cbCodeBlock('// In a custom RenderObject or via Semantics widget:\nSemantics(\n  child: myWidget,\n  // The delegate receives all child configs\n  // and uses the builder to partition them\n)'),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Flow:', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Color(0xFFE65100))),
              SizedBox(height: 6.0),
              Row(
                children: [
                  Container(width: 24.0, height: 24.0,
                    decoration: BoxDecoration(color: Color(0xFFF4511E), shape: BoxShape.circle),
                    child: Center(child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)))),
                  SizedBox(width: 8.0),
                  Expanded(child: Text('Framework collects child SemanticsConfigurations',
                      style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63)))),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Container(width: 24.0, height: 24.0,
                    decoration: BoxDecoration(color: Color(0xFFE64A19), shape: BoxShape.circle),
                    child: Center(child: Text('2', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)))),
                  SizedBox(width: 8.0),
                  Expanded(child: Text('Delegate receives list and builder instance',
                      style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63)))),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Container(width: 24.0, height: 24.0,
                    decoration: BoxDecoration(color: Color(0xFFD84315), shape: BoxShape.circle),
                    child: Center(child: Text('3', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)))),
                  SizedBox(width: 8.0),
                  Expanded(child: Text('Delegate marks configs as siblingMergeUp or leaves for merge',
                      style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63)))),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Container(width: 24.0, height: 24.0,
                    decoration: BoxDecoration(color: Color(0xFFBF360C), shape: BoxShape.circle),
                    child: Center(child: Text('4', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)))),
                  SizedBox(width: 8.0),
                  Expanded(child: Text('Builder.build() returns partitioned result',
                      style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63)))),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 6: SemanticsConfiguration ────────────────────────
  print('\n[6] SemanticsConfiguration');

  final semanticsProps = <Map<String, dynamic>>[
    {'prop': 'isSemanticBoundary', 'desc': 'Creates a new SemanticsNode', 'color': Color(0xFFF4511E)},
    {'prop': 'hasBeenAnnotated', 'desc': 'Whether properties have been set', 'color': Color(0xFFE64A19)},
    {'prop': 'isBlockingSemanticsOfPreviouslyPaintedNodes', 'desc': 'Blocks earlier siblings', 'color': Color(0xFFD84315)},
    {'prop': 'isMergingSemanticsOfDescendants', 'desc': 'Merges all descendant info', 'color': Color(0xFFBF360C)},
    {'prop': 'label / value / hint', 'desc': 'Accessibility text properties', 'color': Color(0xFFE65100)},
    {'prop': 'textDirection', 'desc': 'Direction for accessibility text', 'color': Color(0xFFF4511E)},
  ];

  final cbSemConfigSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The configuration object the builder partitions',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 8.0),
        ...semanticsProps.map((sp) {
          return Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                Container(width: 8.0, height: 8.0,
                  decoration: BoxDecoration(color: sp['color'] as Color, shape: BoxShape.circle)),
                SizedBox(width: 8.0),
                SizedBox(width: 150.0,
                  child: Text(sp['prop'] as String,
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                          fontFamily: 'monospace', color: sp['color'] as Color))),
                Expanded(child: Text(sp['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63)))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 7: Visual — Merge Tree ───────────────────────────
  print('\n[7] Visual: Merge vs SiblingMergeUp Tree');

  final cbTreeSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 160.0,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Stack(
            children: [
              // Parent node
              Positioned(left: 120.0, top: 10.0,
                child: Container(
                  width: 100.0, height: 30.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE65100),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(child: Text('Parent Node',
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white))),
                ),
              ),
              // Merge up configs
              Positioned(left: 30.0, top: 60.0,
                child: Container(
                  width: 80.0, height: 30.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4511E).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Color(0xFFF4511E)),
                  ),
                  child: Center(child: Text('config A\n(mergeUp)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 7.0, color: Color(0xFFF4511E)))),
                ),
              ),
              Positioned(left: 130.0, top: 60.0,
                child: Container(
                  width: 80.0, height: 30.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4511E).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Color(0xFFF4511E)),
                  ),
                  child: Center(child: Text('config B\n(mergeUp)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 7.0, color: Color(0xFFF4511E)))),
                ),
              ),
              // Sibling merge up
              Positioned(left: 230.0, top: 60.0,
                child: Container(
                  width: 80.0, height: 30.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFBF360C).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Color(0xFFBF360C)),
                  ),
                  child: Center(child: Text('config C\n(siblingMerge)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 7.0, color: Color(0xFFBF360C)))),
                ),
              ),
              // Arrows
              Positioned(left: 60.0, top: 42.0,
                child: Icon(Icons.arrow_upward, size: 14.0, color: Color(0xFFF4511E))),
              Positioned(left: 160.0, top: 42.0,
                child: Icon(Icons.arrow_upward, size: 14.0, color: Color(0xFFF4511E))),
              Positioned(left: 260.0, top: 42.0,
                child: Icon(Icons.call_split, size: 14.0, color: Color(0xFFBF360C))),
              // Labels
              Positioned(left: 10.0, top: 100.0,
                child: Text('mergeUp: fold into parent',
                    style: TextStyle(fontSize: 9.0, color: Color(0xFFF4511E)))),
              Positioned(left: 200.0, top: 100.0,
                child: Text('siblingMergeUp: separate node',
                    style: TextStyle(fontSize: 9.0, color: Color(0xFFBF360C)))),
              // Result
              Positioned(left: 30.0, top: 120.0,
                child: Text('Result: Parent merges A+B, C becomes sibling',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xFF8D6E63)))),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 8: Builder Pattern Deep Dive ─────────────────────
  print('\n[8] Builder Pattern');
  print('  Construct → mark → build');

  final builderSteps = <Map<String, dynamic>>[
    {'step': 'Create', 'desc': 'Framework creates builder with child config list',
     'color': Color(0xFFF4511E), 'icon': Icons.add_circle_outline},
    {'step': 'Iterate', 'desc': 'Delegate iterates over child configurations',
     'color': Color(0xFFE64A19), 'icon': Icons.loop},
    {'step': 'Mark', 'desc': 'Call markAsSiblingMergeUp for configs that should separate',
     'color': Color(0xFFD84315), 'icon': Icons.bookmark_border},
    {'step': 'Build', 'desc': 'Call build() to get the partitioned result',
     'color': Color(0xFFBF360C), 'icon': Icons.build},
  ];

  final cbBuilderSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      children: builderSteps.map((bs) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Icon(bs['icon'] as IconData, color: bs['color'] as Color, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bs['step'] as String,
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: bs['color'] as Color)),
                      Text(bs['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 9: Semantics Widget Integration ──────────────────
  print('\n[9] Semantics Widget Integration');

  final cbSemanticsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The Semantics widget provides high-level access to configuration',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Example tree
              Text('Widget Tree → Semantics Tree',
                  style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Color(0xFFE65100))),
              SizedBox(height: 8.0),
              Row(
                children: [
                  // Widget side
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFBE9E7),
                        borderRadius: BorderRadius.circular(6.0)),
                      child: Column(
                        children: [
                          Text('Widgets', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w700, color: Color(0xFFE65100))),
                          SizedBox(height: 4.0),
                          Text('Container\n  Semantics(label: "Btn")\n    ElevatedButton\n  Text("Hi")',
                              style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: Color(0xFF8D6E63))),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.arrow_forward, color: Color(0xFFE65100), size: 20.0),
                  ),
                  // Semantics side
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(6.0)),
                      child: Column(
                        children: [
                          Text('SemanticsNodes', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w700, color: Color(0xFFBF360C))),
                          SizedBox(height: 4.0),
                          Text('Node[label="Btn"]\n  button\nNode[label="Hi"]\n  text',
                              style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: Color(0xFF8D6E63))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        cbCodeBlock('Semantics(\n  label: \'Submit button\',\n  button: true,\n  onTap: () => submit(),\n  child: myButton,\n)'),
      ],
    ),
  );

  // ── Section 10: SemanticsNode Tree ───────────────────────────
  print('\n[10] SemanticsNode Tree Structure');

  final cbNodeTreeSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The semantics tree parallels the render tree for accessibility',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cbInfoRow('Root:', 'SemanticsOwner holds the tree root'),
              cbInfoRow('Nodes:', 'Each has id, rect, transform, properties'),
              cbInfoRow('Children:', 'childrenInTraversalOrder / childrenInInverseHitTestOrder'),
              cbInfoRow('Actions:', 'tap, longPress, scrollLeft, etc.'),
              cbInfoRow('Flags:', 'hasCheckedState, isSelected, isFocused, etc.'),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 11: Accessibility Actions ────────────────────────
  print('\n[11] Accessibility Actions');

  final actions = <Map<String, dynamic>>[
    {'action': 'tap', 'icon': Icons.touch_app, 'color': Color(0xFFF4511E)},
    {'action': 'longPress', 'icon': Icons.pan_tool, 'color': Color(0xFFE64A19)},
    {'action': 'scrollLeft', 'icon': Icons.arrow_back, 'color': Color(0xFFD84315)},
    {'action': 'scrollRight', 'icon': Icons.arrow_forward, 'color': Color(0xFFBF360C)},
    {'action': 'increase', 'icon': Icons.add, 'color': Color(0xFFE65100)},
    {'action': 'decrease', 'icon': Icons.remove, 'color': Color(0xFFF4511E)},
    {'action': 'copy', 'icon': Icons.content_copy, 'color': Color(0xFFE64A19)},
    {'action': 'paste', 'icon': Icons.content_paste, 'color': Color(0xFFD84315)},
  ];

  final cbActionsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actions available through the semantics tree',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0, runSpacing: 6.0,
          children: actions.map((a) {
            return Container(
              width: 80.0,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
              child: Column(
                children: [
                  Icon(a['icon'] as IconData, color: a['color'] as Color, size: 20.0),
                  SizedBox(height: 2.0),
                  Text(a['action'] as String,
                      style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: a['color'] as Color)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );

  // ── Section 12: Merging Semantics ────────────────────────────
  print('\n[12] MergeSemantics Widget');

  final cbMergeSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MergeSemantics combines descendants into one node',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Color(0xFFF4511E).withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text('Without merge', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFFF4511E))),
                    SizedBox(height: 4.0),
                    Text('Node: Icon\nNode: "Label"',
                        style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF8D6E63))),
                    Text('(2 separate nodes)', style: TextStyle(fontSize: 8.0, color: Color(0xFF8D6E63))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Color(0xFFBF360C).withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text('With merge', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFFBF360C))),
                    SizedBox(height: 4.0),
                    Text('Node: Icon + "Label"',
                        style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF8D6E63))),
                    Text('(1 combined node)', style: TextStyle(fontSize: 8.0, color: Color(0xFF8D6E63))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        cbCodeBlock('MergeSemantics(\n  child: Row(children: [\n    Icon(Icons.star),\n    Text(\'Favorite\'),\n  ]),\n  // Screen reader: "Favorite" (combined)\n)'),
      ],
    ),
  );

  // ── Section 13: ExcludeSemantics ─────────────────────────────
  print('\n[13] ExcludeSemantics & BlockSemantics');

  final cbExcludeSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Icon(Icons.visibility_off, color: Color(0xFFE65100), size: 24.0),
                    SizedBox(height: 4.0),
                    Text('ExcludeSemantics', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFFE65100))),
                    SizedBox(height: 4.0),
                    Text('Removes subtree from semantics',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9.0, color: Color(0xFF8D6E63))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Icon(Icons.block, color: Color(0xFFBF360C), size: 24.0),
                    SizedBox(height: 4.0),
                    Text('BlockSemantics', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFFBF360C))),
                    SizedBox(height: 4.0),
                    Text('Blocks semantics from earlier siblings',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9.0, color: Color(0xFF8D6E63))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        cbCodeBlock('ExcludeSemantics(\n  excluding: true, // default\n  child: decorativeImage,\n)'),
      ],
    ),
  );

  // ── Section 14: Semantic Flags ───────────────────────────────
  print('\n[14] Common Semantic Flags');

  final flags = <Map<String, dynamic>>[
    {'flag': 'isButton', 'desc': 'Element is a button', 'color': Color(0xFFF4511E)},
    {'flag': 'isLink', 'desc': 'Element is a link', 'color': Color(0xFFE64A19)},
    {'flag': 'isTextField', 'desc': 'Element is a text field', 'color': Color(0xFFD84315)},
    {'flag': 'isSlider', 'desc': 'Element is a slider', 'color': Color(0xFFBF360C)},
    {'flag': 'isHeader', 'desc': 'Element is a heading', 'color': Color(0xFFE65100)},
    {'flag': 'isReadOnly', 'desc': 'Element is read-only', 'color': Color(0xFFF4511E)},
    {'flag': 'isFocusable', 'desc': 'Element can receive focus', 'color': Color(0xFFE64A19)},
    {'flag': 'isToggled', 'desc': 'Element is toggled on', 'color': Color(0xFFD84315)},
  ];

  final cbFlagsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      children: [
        Wrap(
          spacing: 6.0, runSpacing: 6.0,
          children: flags.map((f) {
            return Container(
              width: 130.0,
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border(left: BorderSide(color: f['color'] as Color, width: 3.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(f['flag'] as String,
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                          fontFamily: 'monospace', color: f['color'] as Color)),
                  Text(f['desc'] as String, style: TextStyle(fontSize: 8.0, color: Color(0xFF8D6E63))),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );

  // ── Section 15: Testing Semantics ────────────────────────────
  print('\n[15] Testing Semantics');

  final cbTestingSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFCCBC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flutter provides tools to verify semantics in widget tests',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
        SizedBox(height: 8.0),
        cbInfoRow('Finder:', 'find.bySemanticsLabel(\'text\')'),
        cbInfoRow('Matcher:', 'matchesSemantics(label: ..., ...)'),
        cbInfoRow('Debug:', 'debugDumpSemanticsTree()'),
        cbInfoRow('Tester:', 'tester.getSemantics(finder)'),
        SizedBox(height: 8.0),
        cbCodeBlock('testWidgets(\'has semantics\', (tester) async {\n  await tester.pumpWidget(myApp);\n  expect(\n    tester.getSemantics(find.byType(MyWidget)),\n    matchesSemantics(label: \'Submit\', isButton: true),\n  );\n});'),
      ],
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  Builder: markAsSiblingMergeUp() → build()');
  print('  Result: mergeUp + siblingMergeUp lists');

  final cbSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFBF360C), Color(0xFFE65100)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('Semantics Builder Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Icon(Icons.merge_type, color: Color(0xFFFFCCBC), size: 28.0),
              Text('Merge Up', style: TextStyle(fontSize: 11.0, color: Color(0xFFFFCCBC))),
            ]),
            Column(children: [
              Icon(Icons.call_split, color: Color(0xFFFFCCBC), size: 28.0),
              Text('Sibling', style: TextStyle(fontSize: 11.0, color: Color(0xFFFFCCBC))),
            ]),
            Column(children: [
              Icon(Icons.build, color: Color(0xFFFFCCBC), size: 28.0),
              Text('Build', style: TextStyle(fontSize: 11.0, color: Color(0xFFFFCCBC))),
            ]),
            Column(children: [
              Icon(Icons.accessibility, color: Color(0xFFFFCCBC), size: 28.0),
              Text('A11y', style: TextStyle(fontSize: 11.0, color: Color(0xFFFFCCBC))),
            ]),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0, runSpacing: 4.0, alignment: WrapAlignment.center,
          children: [
            cbChip('ResultBuilder', Color(0xFFF4511E)),
            cbChip('SemanticsConfiguration', Color(0xFFE64A19)),
            cbChip('MergeSemantics', Color(0xFFD84315)),
            cbChip('ExcludeSemantics', Color(0xFFBF360C)),
          ],
        ),
      ],
    ),
  );

  print('\nChildSemanticsConfigurationsResultBuilder Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cbTitleSection,
        cbSectionHeader('Purpose & Context', Icons.info_outline),
        cbPurposeSection,
        cbSectionHeader('Class API', Icons.code),
        cbApiSection,
        cbSectionHeader('Result Structure', Icons.account_tree),
        cbResultSection,
        cbSectionHeader('Usage Context', Icons.place),
        cbUsageSection,
        cbSectionHeader('SemanticsConfiguration', Icons.settings),
        cbSemConfigSection,
        cbSectionHeader('Merge Tree Visual', Icons.merge_type),
        cbTreeSection,
        cbSectionHeader('Builder Pattern', Icons.build),
        cbBuilderSection,
        cbSectionHeader('Semantics Widget', Icons.widgets),
        cbSemanticsSection,
        cbSectionHeader('SemanticsNode Tree', Icons.account_tree),
        cbNodeTreeSection,
        cbSectionHeader('Accessibility Actions', Icons.touch_app),
        cbActionsSection,
        cbSectionHeader('MergeSemantics', Icons.merge),
        cbMergeSection,
        cbSectionHeader('Exclude & Block', Icons.block),
        cbExcludeSection,
        cbSectionHeader('Semantic Flags', Icons.flag),
        cbFlagsSection,
        cbSectionHeader('Testing Semantics', Icons.science),
        cbTestingSection,
        SizedBox(height: 8.0),
        cbSummarySection,
      ],
    ),
  );
}
