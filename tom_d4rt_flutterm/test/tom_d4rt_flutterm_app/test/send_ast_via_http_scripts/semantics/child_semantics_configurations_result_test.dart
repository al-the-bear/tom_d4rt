// ignore_for_file: avoid_print
// D4rt deep demo: ChildSemanticsConfigurationsResult
// Explores how semantics configurations are partitioned into merge-up
// vs sibling-merge-up lists during the assembleSemanticsNode process.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Sage / Herb palette ───
  const Color sage = Color(0xFF9CAF88);
  const Color herb = Color(0xFF6B7F5E);
  const Color mintCream = Color(0xFFF5FFF0);
  const Color darkOlive = Color(0xFF3B4A2F);
  const Color fernGreen = Color(0xFF4F7942);
  const Color paleLeaf = Color(0xFFD4E7C5);
  const Color thyme = Color(0xFF7D9B6A);
  const Color rosemary = Color(0xFF5C7A4B);
  const Color chamomile = Color(0xFFF0E68C);
  const Color lavender = Color(0xFFB4A7D6);

  // ─── Helper builders ───
  Widget srHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [herb, sage],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: herb.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 3),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12, color: Colors.white.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget srCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: mintCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sage.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget srBullet(String text, {Color dotColor = herb}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 7,
            height: 7,
            margin: const EdgeInsets.only(top: 5, right: 8),
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 12.5, color: darkOlive)),
          ),
        ],
      ),
    );
  }

  Widget srLabel(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }

  Widget srTreeRow(String label,
      {int indent = 0, IconData icon = Icons.circle, Color? color}) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 22.0, top: 3, bottom: 3),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color ?? fernGreen),
          const SizedBox(width: 6),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: color ?? darkOlive)),
          ),
        ],
      ),
    );
  }

  Widget srDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              sage.withValues(alpha: 0.0),
              sage,
              sage.withValues(alpha: 0.0),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Section 1: Purpose & context
  // ─────────────────────────────────────────────
  print('sr01 ChildSemanticsConfigurationsResult — purpose');
  Widget sr01Purpose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr01 — What is ChildSemanticsConfigurationsResult?',
            'Return type from assembleSemanticsNode\'s partitioning logic'),
        const SizedBox(height: 10),
        srCard([
          const Text(
            'ChildSemanticsConfigurationsResult is a data class that holds '
            'the outcome of partitioning a child\'s semantics configurations '
            'into two groups during the assembleSemanticsNode process:',
            style: TextStyle(fontSize: 13, color: darkOlive),
          ),
          const SizedBox(height: 10),
          srBullet(
              'mergeUp — configurations that merge into the parent node'),
          srBullet(
              'siblingMergeUp — configurations that become sibling nodes, not merged'),
          srBullet(
              'The builder (ChildSemanticsConfigurationsResultBuilder) '
              'creates these lists through markAsSiblingMergeUp() calls'),
          srBullet(
              'Used internally by RenderObject.assembleSemanticsNode'),
        ]),
        const SizedBox(height: 8),
        // Visual: two-bucket diagram
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleLeaf.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: fernGreen.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sage.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: sage),
                  ),
                  child: Column(
                    children: [
                      const Text('mergeUp',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: herb)),
                      const SizedBox(height: 6),
                      const Icon(Icons.merge_type, size: 28, color: herb),
                      const SizedBox(height: 4),
                      const Text('→ parent node',
                          style: TextStyle(fontSize: 11, color: darkOlive)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.compare_arrows, size: 24, color: darkOlive),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: lavender.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: lavender),
                  ),
                  child: Column(
                    children: [
                      const Text('siblingMergeUp',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B68AE))),
                      const SizedBox(height: 6),
                      const Icon(Icons.call_split,
                          size: 28, color: Color(0xFF7B68AE)),
                      const SizedBox(height: 4),
                      const Text('→ sibling node',
                          style: TextStyle(fontSize: 11, color: darkOlive)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget srFieldRow(String name, String type, Color indicator) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: sage.withValues(alpha: 0.3))),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(color: indicator, shape: BoxShape.circle),
          ),
          SizedBox(
            width: 148,
            child: Text(name,
                style: const TextStyle(
                    fontSize: 12, fontFamily: 'monospace', color: darkOlive)),
          ),
          Expanded(
            child: Text(type,
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: herb.withValues(alpha: 0.9))),
          ),
        ],
      ),
    );
  }


  // ─────────────────────────────────────────────
  // Section 2: Class anatomy
  // ─────────────────────────────────────────────
  print('sr02 ChildSemanticsConfigurationsResult — class anatomy');
  Widget sr02Anatomy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr02 — Class Anatomy',
            'Fields, construction, and immutability'),
        const SizedBox(height: 10),
        srCard([
          const Text('ChildSemanticsConfigurationsResult',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: herb)),
          const SizedBox(height: 8),
          // field table
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: sage),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  color: sage.withValues(alpha: 0.3),
                  child: const Row(
                    children: [
                      SizedBox(
                          width: 160,
                          child: Text('Field',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: darkOlive))),
                      Expanded(
                          child: Text('Type',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: darkOlive))),
                    ],
                  ),
                ),
                srFieldRow('mergeUp',
                    'List<SemanticsConfiguration>', fernGreen),
                srFieldRow('siblingMergeUp',
                    'List<SemanticsConfiguration>', rosemary),
              ],
            ),
          ),
          const SizedBox(height: 10),
          srBullet('Both lists are final and set during construction'),
          srBullet(
              'Created exclusively by ChildSemanticsConfigurationsResultBuilder.build()'),
          srBullet(
              'The result is consumed by RenderObject during semantics assembly'),
        ]),
      ],
    );
  }
  Widget srPipelineStep(
      int step, String title, String code, Color stepColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: stepColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: stepColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: stepColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$step',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: stepColor)),
                Text(code,
                    style: const TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: darkOlive)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ─────────────────────────────────────────────
  // Section 3: Relationship to the Builder
  // ─────────────────────────────────────────────
  print('sr03 Builder → Result relationship');
  Widget sr03Builder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr03 — Builder → Result Pipeline',
            'How ChildSemanticsConfigurationsResultBuilder produces the result'),
        const SizedBox(height: 10),
        srCard([
          const Text(
            'The Builder iterates over child SemanticsConfigurations and '
            'decides for each one whether it should merge into the parent '
            'or stay as a sibling. Here is the pipeline:',
            style: TextStyle(fontSize: 12.5, color: darkOlive),
          ),
          const SizedBox(height: 12),
          // Pipeline steps
          srPipelineStep(1, 'Create Builder',
              'new ChildSemanticsConfigurationsResultBuilder()', sage),
          const SizedBox(height: 4),
          const Icon(Icons.arrow_downward, size: 18, color: herb),
          const SizedBox(height: 4),
          srPipelineStep(2, 'Mark siblings',
              'builder.markAsSiblingMergeUp(config)', thyme),
          const SizedBox(height: 4),
          const Icon(Icons.arrow_downward, size: 18, color: herb),
          const SizedBox(height: 4),
          srPipelineStep(3, 'Build result',
              'final result = builder.build()', fernGreen),
          const SizedBox(height: 4),
          const Icon(Icons.arrow_downward, size: 18, color: herb),
          const SizedBox(height: 4),
          srPipelineStep(4, 'Access lists',
              'result.mergeUp / result.siblingMergeUp', rosemary),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 4: Merge tree — visual
  // ─────────────────────────────────────────────
  print('sr04 Merge tree visualization');
  Widget sr04MergeTree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr04 — Merge Tree Visualization',
            'How configurations partition into the accessibility tree'),
        const SizedBox(height: 10),
        srCard([
          const Text('Before partitioning:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: darkOlive)),
          const SizedBox(height: 6),
          srTreeRow('RenderCustom (parent)', icon: Icons.account_tree),
          srTreeRow('├─ Config A: label="Save"',
              indent: 1, icon: Icons.settings),
          srTreeRow('├─ Config B: label="Delete"',
              indent: 1, icon: Icons.settings),
          srTreeRow('└─ Config C: label="Cancel"',
              indent: 1, icon: Icons.settings),
          srDivider(),
          const Text('After partitioning (B marked as sibling):',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: darkOlive)),
          const SizedBox(height: 6),
          srTreeRow('SemanticsNode (parent)',
              icon: Icons.account_tree, color: fernGreen),
          srTreeRow('├─ A: "Save" (merged up)',
              indent: 1, icon: Icons.merge_type, color: fernGreen),
          srTreeRow('├─ C: "Cancel" (merged up)',
              indent: 1, icon: Icons.merge_type, color: fernGreen),
          srTreeRow('SemanticsNode (sibling)',
              icon: Icons.call_split, color: const Color(0xFF7B68AE)),
          srTreeRow('└─ B: "Delete" (sibling merge up)',
              indent: 1,
              icon: Icons.call_split,
              color: const Color(0xFF7B68AE)),
          const SizedBox(height: 8),
          Row(
            children: [
              srLabel('mergeUp: [A, C]', fernGreen),
              const SizedBox(width: 8),
              srLabel('siblingMergeUp: [B]', const Color(0xFF7B68AE)),
            ],
          ),
        ]),
      ],
    );
  }
  Widget srPropertyTile(
      String name, String type, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: color)),
                    const SizedBox(width: 6),
                    Text(type,
                        style: TextStyle(
                            fontSize: 10.5,
                            fontFamily: 'monospace',
                            color: color.withValues(alpha: 0.7))),
                  ],
                ),
                Text(desc,
                    style:
                        const TextStyle(fontSize: 11.5, color: darkOlive)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ─────────────────────────────────────────────
  // Section 5: SemanticsConfiguration properties
  // ─────────────────────────────────────────────
  print('sr05 SemanticsConfiguration properties that affect merge');
  Widget sr05Properties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr05 — Key SemanticsConfiguration Properties',
            'Properties that influence whether a config merges or splits'),
        const SizedBox(height: 10),
        srCard([
          srPropertyTile('isSemanticBoundary', 'bool',
              'When true, creates a new SemanticsNode boundary', Icons.border_all, sage),
          const SizedBox(height: 6),
          srPropertyTile('isMergingSemanticsOfDescendants', 'bool',
              'Merges all descendant semantics into this node', Icons.merge, thyme),
          const SizedBox(height: 6),
          srPropertyTile('label', 'String',
              'Accessibility label read by screen readers', Icons.label, fernGreen),
          const SizedBox(height: 6),
          srPropertyTile('isBlockingSemanticsOfPreviouslyPaintedNodes', 'bool',
              'Blocks semantics from nodes painted before this one', Icons.block, rosemary),
          const SizedBox(height: 6),
          srPropertyTile('textDirection', 'TextDirection?',
              'Text reading direction for the semantics node', Icons.format_textdirection_l_to_r, herb),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 6: Live Semantics widget demo
  // ─────────────────────────────────────────────
  print('sr06 Semantics widget demo — merged vs standalone');
  Widget sr06SemanticsWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr06 — Semantics Widget: Merged vs Standalone',
            'Visual demo of how Semantics widget produces the merge behavior'),
        const SizedBox(height: 10),
        // Merged example
        srCard([
          const Text('Merged (MergeSemantics wraps children):',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: herb)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: sage.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: sage, width: 2),
            ),
            child: MergeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: chamomile, size: 20),
                      const SizedBox(width: 6),
                      Semantics(
                        label: 'Favorite',
                        child: const Text('Favorite',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: darkOlive)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Semantics(
                    label: 'This item is marked as favorite',
                    child: const Text(
                      'This item is marked as favorite',
                      style: TextStyle(fontSize: 11.5, color: darkOlive),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '→ Screen reader announces: "Favorite, This item is marked as favorite"',
            style: TextStyle(
                fontSize: 11.5, fontStyle: FontStyle.italic, color: thyme),
          ),
        ]),
        const SizedBox(height: 8),
        // Standalone example
        srCard([
          const Text('Standalone (separate Semantics nodes):',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: rosemary)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lavender.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: lavender, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: 'Save button',
                  button: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: fernGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  label: 'Delete button',
                  button: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '→ Screen reader focuses each: "Save button" then "Delete button"',
            style: TextStyle(
                fontSize: 11.5, fontStyle: FontStyle.italic, color: thyme),
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 7: ExcludeSemantics & BlockSemantics
  // ─────────────────────────────────────────────
  print('sr07 ExcludeSemantics & BlockSemantics');
  Widget sr07ExcludeBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr07 — ExcludeSemantics & BlockSemantics',
            'Removing nodes from the accessibility tree'),
        const SizedBox(height: 10),
        srCard([
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: Colors.red.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.visibility_off,
                          size: 28, color: Colors.red),
                      const SizedBox(height: 6),
                      const Text('ExcludeSemantics',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                      const SizedBox(height: 4),
                      ExcludeSemantics(
                        child: Semantics(
                          label: 'This is hidden',
                          child: const Text('Hidden from A11Y',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Drops subtree from\naccessibility tree',
                        style: TextStyle(fontSize: 10.5, color: darkOlive),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.block, size: 28, color: Colors.orange),
                      const SizedBox(height: 6),
                      const Text('BlockSemantics',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                      const SizedBox(height: 4),
                      BlockSemantics(
                        child: Semantics(
                          label: 'Blocks earlier siblings',
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            color: Colors.orange.withValues(alpha: 0.1),
                            child: const Text('Blocks earlier siblings',
                                style: TextStyle(
                                    fontSize: 11, color: darkOlive)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Hides previously-painted\nsiblings from A11Y',
                        style: TextStyle(fontSize: 10.5, color: darkOlive),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ],
    );
  }
  Widget srFlowStep(
      String title, String desc, IconData icon, Color stepColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: stepColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: stepColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: stepColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: stepColor)),
                Text(desc,
                    style:
                        const TextStyle(fontSize: 11.5, color: darkOlive)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget srFlowArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Center(
        child: Icon(Icons.arrow_downward, size: 16, color: herb),
      ),
    );
  }



  // ─────────────────────────────────────────────
  // Section 8: assembleSemanticsNode flow chart
  // ─────────────────────────────────────────────
  print('sr08 assembleSemanticsNode flow');
  Widget sr08AssembleFlow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr08 — assembleSemanticsNode Flow',
            'Where ChildSemanticsConfigurationsResult fits in the pipeline'),
        const SizedBox(height: 10),
        srCard([
          srFlowStep('1. Render tree traversal',
              'Framework walks the render tree bottom-up', Icons.account_tree,
              sage),
          srFlowArrow(),
          srFlowStep('2. Collect child configs',
              'Each child provides its SemanticsConfiguration', Icons.list,
              thyme),
          srFlowArrow(),
          srFlowStep('3. Build partitioning result',
              'Builder partitions configs into mergeUp / siblingMergeUp',
              Icons.call_split, fernGreen),
          srFlowArrow(),
          srFlowStep('4. Create/update SemanticsNode',
              'mergeUp items merge into parent node', Icons.merge_type,
              rosemary),
          srFlowArrow(),
          srFlowStep('5. Create sibling nodes',
              'siblingMergeUp items become separate sibling nodes',
              Icons.horizontal_split, herb),
          srFlowArrow(),
          srFlowStep('6. Update semantics tree',
              'New nodes are sent to the engine for platform A11Y',
              Icons.send, darkOlive),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 9: Visual — accessibility tree depth
  // ─────────────────────────────────────────────
  print('sr09 Accessibility tree depth visualization');
  Widget sr09TreeDepth() {
    final List<Map<String, dynamic>> treeNodes = [
      {'label': 'MaterialApp', 'depth': 0, 'icon': Icons.phone_android, 'color': sage},
      {'label': 'Scaffold', 'depth': 1, 'icon': Icons.web, 'color': thyme},
      {'label': 'AppBar: "My App"', 'depth': 2, 'icon': Icons.title, 'color': fernGreen},
      {'label': 'Body (Column)', 'depth': 2, 'icon': Icons.view_column, 'color': fernGreen},
      {'label': 'Card: "User profile"', 'depth': 3, 'icon': Icons.person, 'color': rosemary},
      {'label': 'Avatar (excluded)', 'depth': 4, 'icon': Icons.visibility_off, 'color': Colors.grey},
      {'label': 'Name: "Alice"', 'depth': 4, 'icon': Icons.label, 'color': herb},
      {'label': 'Role: "Admin"', 'depth': 4, 'icon': Icons.badge, 'color': herb},
      {'label': 'Button: "Edit Profile"', 'depth': 3, 'icon': Icons.edit, 'color': rosemary},
      {'label': 'FAB: "Add item"', 'depth': 2, 'icon': Icons.add_circle, 'color': fernGreen},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr09 — Accessibility Tree Depth',
            'Typical Flutter app semantics tree structure'),
        const SizedBox(height: 10),
        srCard([
          const Text('Semantics tree for a typical screen:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: darkOlive)),
          const SizedBox(height: 8),
          ...treeNodes.map((node) => Padding(
                padding: EdgeInsets.only(
                    left: (node['depth'] as int) * 20.0, top: 3, bottom: 3),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: (node['color'] as Color).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: (node['color'] as Color)
                                .withValues(alpha: 0.5)),
                      ),
                      child: Icon(node['icon'] as IconData,
                          size: 13, color: node['color'] as Color),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(node['label'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: node['color'] == Colors.grey
                                  ? Colors.grey
                                  : darkOlive,
                              decoration: node['color'] == Colors.grey
                                  ? TextDecoration.lineThrough
                                  : null)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 8),
          srBullet('Each node maps to a SemanticsNode in the engine'),
          srBullet(
              'Excluded nodes are omitted from the accessibility tree'),
          srBullet(
              'Merged nodes combine labels from multiple render objects'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 10: Actions & handlers
  // ─────────────────────────────────────────────
  print('sr10 Semantic actions grid');
  Widget sr10ActionsGrid() {
    final List<Map<String, dynamic>> actions = [
      {'name': 'tap', 'icon': Icons.touch_app, 'desc': 'Activate / press'},
      {'name': 'longPress', 'icon': Icons.pan_tool, 'desc': 'Long press action'},
      {'name': 'scrollLeft', 'icon': Icons.arrow_back, 'desc': 'Scroll left'},
      {'name': 'scrollRight', 'icon': Icons.arrow_forward, 'desc': 'Scroll right'},
      {'name': 'scrollUp', 'icon': Icons.arrow_upward, 'desc': 'Scroll up'},
      {'name': 'scrollDown', 'icon': Icons.arrow_downward, 'desc': 'Scroll down'},
      {'name': 'increase', 'icon': Icons.add, 'desc': 'Increase value'},
      {'name': 'decrease', 'icon': Icons.remove, 'desc': 'Decrease value'},
      {'name': 'copy', 'icon': Icons.copy, 'desc': 'Copy to clipboard'},
      {'name': 'paste', 'icon': Icons.paste, 'desc': 'Paste from clipboard'},
      {'name': 'dismiss', 'icon': Icons.close, 'desc': 'Dismiss / clear'},
      {'name': 'focus', 'icon': Icons.center_focus_strong, 'desc': 'Request focus'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr10 — Semantic Actions',
            'Actions that can be attached to SemanticsConfiguration'),
        const SizedBox(height: 10),
        srCard([
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: actions
                .map((a) => Container(
                      width: 135,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: sage.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: sage.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(a['icon'] as IconData,
                              size: 16, color: fernGreen),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a['name'] as String,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'monospace',
                                        color: herb)),
                                Text(a['desc'] as String,
                                    style: const TextStyle(
                                        fontSize: 9.5, color: darkOlive)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          srBullet(
              'Actions are attached to SemanticsConfiguration and forwarded '
              'to the platform accessibility service'),
          srBullet(
              'When mergeUp occurs, actions from children are combined; '
              'siblingMergeUp keeps them separate'),
        ]),
      ],
    );
  }
  Widget srCompRow(String aspect, String mergeUp, String sibling) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: sage.withValues(alpha: 0.3))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(aspect,
                style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: darkOlive)),
          ),
          Expanded(
            child: Text(mergeUp,
                style: const TextStyle(fontSize: 11.5, color: fernGreen)),
          ),
          Expanded(
            child: Text(sibling,
                style: const TextStyle(
                    fontSize: 11.5, color: Color(0xFF7B68AE))),
          ),
        ],
      ),
    );
  }


  // ─────────────────────────────────────────────
  // Section 11: Merge behavior comparison table
  // ─────────────────────────────────────────────
  print('sr11 Merge behavior comparison');
  Widget sr11ComparisonTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr11 — Merge Behavior Comparison',
            'mergeUp vs siblingMergeUp side-by-side'),
        const SizedBox(height: 10),
        srCard([
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: sage),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                // Header row
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  color: herb.withValues(alpha: 0.2),
                  child: const Row(
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text('Aspect',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: darkOlive))),
                      Expanded(
                          child: Text('mergeUp',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: fernGreen))),
                      Expanded(
                          child: Text('siblingMergeUp',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF7B68AE)))),
                    ],
                  ),
                ),
                srCompRow('Destination', 'Parent node', 'New sibling node'),
                srCompRow('Labels', 'Concatenated', 'Separate'),
                srCompRow('Actions', 'Combined', 'Independent'),
                srCompRow('Focus', 'Single focus target', 'Own focus target'),
                srCompRow(
                    'Use case', 'Icon + label', 'Distinct buttons'),
                srCompRow(
                    'Screen reader', 'One announcement', 'Separate stops'),
              ],
            ),
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 12: Real world pattern — form fields
  // ─────────────────────────────────────────────
  print('sr12 Real world pattern: form with merged labels');
  Widget sr12FormPattern() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr12 — Real-World Pattern: Form Fields',
            'How merge semantics improves form accessibility'),
        const SizedBox(height: 10),
        srCard([
          const Text('A form field typically merges its label + input + hint:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: darkOlive)),
          const SizedBox(height: 10),
          // Mock form field with merged semantics
          MergeSemantics(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: sage),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    label: 'Email address',
                    child: const Text('Email address',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: herb)),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: sage.withValues(alpha: 0.5)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('user@example.com',
                          style: TextStyle(
                              fontSize: 13,
                              color: darkOlive,
                              fontFamily: 'monospace')),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Semantics(
                    label: 'Enter your email address',
                    child: Text('Enter your email address',
                        style: TextStyle(
                            fontSize: 11,
                            color: thyme.withValues(alpha: 0.7))),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '→ All three parts (label + input + hint) are announced together',
            style: TextStyle(
                fontSize: 11.5, fontStyle: FontStyle.italic, color: thyme),
          ),
        ]),
        const SizedBox(height: 8),
        // Separate field — sibling behavior
        srCard([
          const Text('Adjacent buttons should remain separate (sibling):',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: darkOlive)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Semantics(
                  button: true,
                  label: 'Submit',
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: fernGreen,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text('Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Semantics(
                  button: true,
                  label: 'Cancel',
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '→ Submit and Cancel are separate focus targets (not merged)',
            style: TextStyle(
                fontSize: 11.5, fontStyle: FontStyle.italic, color: thyme),
          ),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 13: Semantic flags overview
  // ─────────────────────────────────────────────
  print('sr13 Semantic flags');
  Widget sr13Flags() {
    final flags = [
      {'name': 'hasCheckedState', 'desc': 'Widget has on/off state (checkbox)', 'icon': Icons.check_box},
      {'name': 'isChecked', 'desc': 'Current checked state', 'icon': Icons.check_circle},
      {'name': 'isSelected', 'desc': 'Widget is selected in a group', 'icon': Icons.radio_button_checked},
      {'name': 'isButton', 'desc': 'Acts as a button', 'icon': Icons.smart_button},
      {'name': 'isLink', 'desc': 'Acts as a hyperlink', 'icon': Icons.link},
      {'name': 'isHeader', 'desc': 'Is a heading element', 'icon': Icons.title},
      {'name': 'isTextField', 'desc': 'Accepts text input', 'icon': Icons.text_fields},
      {'name': 'isSlider', 'desc': 'Acts as a slider', 'icon': Icons.tune},
      {'name': 'isReadOnly', 'desc': 'Read-only (not editable)', 'icon': Icons.lock},
      {'name': 'isFocusable', 'desc': 'Can receive focus', 'icon': Icons.center_focus_strong},
      {'name': 'isFocused', 'desc': 'Currently has focus', 'icon': Icons.highlight},
      {'name': 'isEnabled', 'desc': 'Widget is enabled', 'icon': Icons.power_settings_new},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr13 — Semantic Flags',
            'Boolean flags that describe widget role and state'),
        const SizedBox(height: 10),
        srCard([
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: flags
                .map((f) => Container(
                      width: 175,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: paleLeaf.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: sage.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(f['icon'] as IconData,
                              size: 16, color: herb),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(f['name'] as String,
                                    style: const TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'monospace',
                                        color: darkOlive)),
                                Text(f['desc'] as String,
                                    style: const TextStyle(
                                        fontSize: 9.5, color: thyme)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          srBullet('Flags are set on SemanticsConfiguration objects'),
          srBullet(
              'When merged, flags from children combine via logical OR'),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 14: Live Semantics interactive demo
  // ─────────────────────────────────────────────
  print('sr14 Interactive Semantics showcase');
  Widget sr14Interactive() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr14 — Interactive Semantics Showcase',
            'Widgets with various semantic annotations'),
        const SizedBox(height: 10),
        srCard([
          // Checkbox-like semantics
          Semantics(
            checked: true,
            label: 'Accept terms',
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: sage.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: sage),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_box, color: fernGreen, size: 22),
                  const SizedBox(width: 8),
                  const Text('Accept terms and conditions',
                      style: TextStyle(fontSize: 13, color: darkOlive)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Slider-like semantics
          Semantics(
            slider: true,
            label: 'Volume',
            value: '75%',
            increasedValue: '80%',
            decreasedValue: '70%',
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: thyme.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: thyme),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Volume: 75%',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: darkOlive)),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox(
                      height: 10,
                      child: LinearProgressIndicator(
                        value: 0.75,
                        backgroundColor: sage.withValues(alpha: 0.3),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(fernGreen),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Image semantics
          Semantics(
            image: true,
            label: 'Profile photo of Alice',
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: lavender.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: lavender, width: 2),
              ),
              child:
                  const Icon(Icons.person, size: 40, color: Color(0xFF7B68AE)),
            ),
          ),
        ]),
      ],
    );
  }
  Widget srTestCard(
      String name, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: color)),
                Text(desc,
                    style:
                        const TextStyle(fontSize: 11.5, color: darkOlive)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ─────────────────────────────────────────────
  // Section 15: Testing semantics
  // ─────────────────────────────────────────────
  print('sr15 Testing semantics');
  Widget sr15Testing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr15 — Testing Semantics',
            'Approaches and tools for verifying accessibility'),
        const SizedBox(height: 10),
        srCard([
          const Text('Key testing strategies:',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: darkOlive)),
          const SizedBox(height: 8),
          srTestCard('find.bySemanticsLabel()',
              'Find widgets by their semantic label in tests',
              Icons.search, sage),
          const SizedBox(height: 6),
          srTestCard('matchesSemantics()',
              'Matcher that verifies semantic properties like label, flags, actions',
              Icons.fact_check, thyme),
          const SizedBox(height: 6),
          srTestCard('containsSemantics()',
              'Checks that a SemanticsNode tree contains specific properties',
              Icons.account_tree, fernGreen),
          const SizedBox(height: 6),
          srTestCard('debugDumpSemanticsTree()',
              'Prints the full semantics tree for debugging',
              Icons.bug_report, rosemary),
          const SizedBox(height: 6),
          srTestCard('SemanticsDebugger',
              'Widget that overlays accessibility info on the UI',
              Icons.visibility, herb),
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // Section 16: Summary dashboard
  // ─────────────────────────────────────────────
  print('sr16 Summary dashboard');
  Widget sr16Dashboard() {
    final stats = [
      {'label': 'Fields', 'value': '2', 'sub': 'mergeUp + siblingMergeUp', 'color': fernGreen},
      {'label': 'Builder Steps', 'value': '4', 'sub': 'create → mark → build → access', 'color': thyme},
      {'label': 'Semantic Actions', 'value': '12+', 'sub': 'tap, scroll, copy...', 'color': rosemary},
      {'label': 'Semantic Flags', 'value': '12+', 'sub': 'isButton, isChecked...', 'color': herb},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        srHeader('sr16 — Summary Dashboard',
            'ChildSemanticsConfigurationsResult at a glance'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: stats
              .map((s) => Container(
                    width: 170,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (s['color'] as Color).withValues(alpha: 0.15),
                          (s['color'] as Color).withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color:
                              (s['color'] as Color).withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(s['value'] as String,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: s['color'] as Color)),
                        Text(s['label'] as String,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: darkOlive)),
                        const SizedBox(height: 2),
                        Text(s['sub'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                color:
                                    darkOlive.withValues(alpha: 0.7)),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 12),
        srCard([
          srBullet(
              'ChildSemanticsConfigurationsResult partitions semantics configs into two groups'),
          srBullet(
              'mergeUp items merge into the parent SemanticsNode'),
          srBullet(
              'siblingMergeUp items create separate sibling SemanticsNodes'),
          srBullet(
              'The builder pattern ensures configs are correctly classified'),
          srBullet(
              'This mechanism is critical for Flutter\'s accessibility tree structure'),
        ]),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  // Main scaffold
  // ═══════════════════════════════════════════════
  print('sr: Building ChildSemanticsConfigurationsResult deep demo');

  return Scaffold(
    appBar: AppBar(
      title: const Text('ChildSemanticsConfigurationsResult Deep Demo'),
      backgroundColor: herb,
      foregroundColor: Colors.white,
    ),
    body: Container(
      color: mintCream.withValues(alpha: 0.5),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sr01Purpose(),
            srDivider(),
            sr02Anatomy(),
            srDivider(),
            sr03Builder(),
            srDivider(),
            sr04MergeTree(),
            srDivider(),
            sr05Properties(),
            srDivider(),
            sr06SemanticsWidgets(),
            srDivider(),
            sr07ExcludeBlock(),
            srDivider(),
            sr08AssembleFlow(),
            srDivider(),
            sr09TreeDepth(),
            srDivider(),
            sr10ActionsGrid(),
            srDivider(),
            sr11ComparisonTable(),
            srDivider(),
            sr12FormPattern(),
            srDivider(),
            sr13Flags(),
            srDivider(),
            sr14Interactive(),
            srDivider(),
            sr15Testing(),
            srDivider(),
            sr16Dashboard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ),
  );
}
