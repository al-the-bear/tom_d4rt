// ignore_for_file: avoid_print
// D4rt test script: Comprehensive demo for ContainerBoxParentData from rendering
//
// ContainerBoxParentData provides data for children in box container:
//   - Extends BoxParentData (offset positioning)
//   - Implements ContainerParentDataMixin<RenderBox>
//   - Links children in doubly-linked list via previousSibling/nextSibling
//
// This demo shows:
//   1. ContainerBoxParentData structure and purpose
//   2. Sibling navigation (previous/next)
//   3. Box offset positioning
//   4. How RenderBox containers use this data
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kGreen50 = Color(0xFFE8F5E9);
const _kGreen100 = Color(0xFFC8E6C9);
const _kGreen200 = Color(0xFFA5D6A7);
const _kGreen300 = Color(0xFF81C784);
const _kGreen400 = Color(0xFF66BB6A);
const _kGreen500 = Color(0xFF4CAF50);
const _kGreen600 = Color(0xFF43A047);
const _kGreen700 = Color(0xFF388E3C);
const _kGreen800 = Color(0xFF2E7D32);
const _kGreen900 = Color(0xFF1B5E20);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kGreen800, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kGreen900,
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card with description
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kGreen50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kGreen200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kGreen100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kGreen800, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kGreen900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kGreen800),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code snippet display
Widget _buildCodeSnippet(String title, String code) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kGreen900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kGreen800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kGreen200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kGreen100,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFFE8F5E9),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Class hierarchy visualization
Widget _buildClassHierarchyCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kGreen300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Class Hierarchy',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kGreen900,
          ),
        ),
        const SizedBox(height: 16),
        _buildHierarchyItem('ParentData', 0, 'Base class', false),
        _buildHierarchyItem('BoxParentData', 1, 'Adds offset property', false),
        _buildHierarchyItem(
          'ContainerBoxParentData<T>',
          2,
          'Adds sibling links',
          true,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kGreen50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: _kGreen700, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Plus mixin: ContainerParentDataMixin<RenderBox>',
                  style: TextStyle(fontSize: 11, color: _kGreen800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyItem(String name, int depth, String desc, bool isTarget) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 20.0, bottom: 8),
    child: Row(
      children: [
        if (depth > 0) ...[
          Container(width: 16, height: 2, color: _kGreen300),
          const SizedBox(width: 4),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isTarget ? _kGreen500 : _kGreen100,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isTarget ? _kGreen700 : _kGreen300),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isTarget ? Colors.white : _kGreen800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(desc, style: const TextStyle(fontSize: 10, color: _kGreen700)),
      ],
    ),
  );
}

/// Properties visualization
Widget _buildPropertiesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kGreen400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Properties',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kGreen900,
          ),
        ),
        const SizedBox(height: 16),
        _buildPropertyItem(
          'offset',
          'Offset',
          'Position relative to parent',
          Icons.open_with,
        ),
        _buildPropertyItem(
          'previousSibling',
          'ChildType?',
          'Previous child in list (null if first)',
          Icons.arrow_back,
        ),
        _buildPropertyItem(
          'nextSibling',
          'ChildType?',
          'Next child in list (null if last)',
          Icons.arrow_forward,
        ),
      ],
    ),
  );
}

Widget _buildPropertyItem(
  String name,
  String type,
  String desc,
  IconData icon,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kGreen50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kGreen200),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kGreen500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kGreen900,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _kGreen200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9,
                        color: _kGreen800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(fontSize: 10, color: _kGreen700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Sibling chain visualization
Widget _buildSiblingChainVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kGreen400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sibling Chain (Doubly-Linked List)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kGreen900,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildChainNode('Child 0', 'null', 'Child 1', true),
              _buildChainArrow(true),
              _buildChainNode('Child 1', 'Child 0', 'Child 2', false),
              _buildChainArrow(true),
              _buildChainNode('Child 2', 'Child 1', 'Child 3', false),
              _buildChainArrow(true),
              _buildChainNode('Child 3', 'Child 2', 'null', true),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kGreen50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.link, color: _kGreen700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Each child knows its previous and next sibling for efficient traversal',
                  style: TextStyle(fontSize: 11, color: _kGreen800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildChainNode(String name, String prev, String next, bool isEnd) {
  return Container(
    width: 100,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: isEnd ? _kGreen100 : _kGreen50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: isEnd ? _kGreen500 : _kGreen300),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _kGreen500,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_back, size: 10, color: _kGreen700),
            Text(prev, style: const TextStyle(fontSize: 8, color: _kGreen700)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_forward, size: 10, color: _kGreen700),
            Text(next, style: const TextStyle(fontSize: 8, color: _kGreen700)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildChainArrow(bool bidirectional) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      children: [
        Icon(Icons.arrow_forward, color: _kGreen500, size: 16),
        if (bidirectional) Icon(Icons.arrow_back, color: _kGreen400, size: 14),
      ],
    ),
  );
}

/// Interactive offset demo
Widget _buildInteractiveOffsetDemo() {
  return _InteractiveOffsetWidget();
}

class _InteractiveOffsetWidget extends StatefulWidget {
  @override
  State<_InteractiveOffsetWidget> createState() =>
      _InteractiveOffsetWidgetState();
}

class _InteractiveOffsetWidgetState extends State<_InteractiveOffsetWidget> {
  double _offsetX = 20;
  double _offsetY = 20;
  int _selectedChild = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kGreen400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Offset Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kGreen900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Adjust the offset property for child positioning:',
            style: TextStyle(fontSize: 11, color: _kGreen700),
          ),
          const SizedBox(height: 12),
          // Child selector
          Row(
            children: List.generate(
              4,
              (i) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedChild = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedChild == i ? _kGreen500 : _kGreen100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Child $i',
                      style: TextStyle(
                        fontSize: 11,
                        color: _selectedChild == i ? Colors.white : _kGreen800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Offset sliders
          Row(
            children: [
              const Text(
                'X: ',
                style: TextStyle(fontSize: 11, color: _kGreen800),
              ),
              Expanded(
                child: Slider(
                  value: _offsetX,
                  min: 0,
                  max: 150,
                  onChanged: (v) => setState(() => _offsetX = v),
                  activeColor: _kGreen600,
                ),
              ),
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: _kGreen500,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${_offsetX.toInt()}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Y: ',
                style: TextStyle(fontSize: 11, color: _kGreen800),
              ),
              Expanded(
                child: Slider(
                  value: _offsetY,
                  min: 0,
                  max: 100,
                  onChanged: (v) => setState(() => _offsetY = v),
                  activeColor: _kGreen600,
                ),
              ),
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: _kGreen500,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${_offsetY.toInt()}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Preview
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: _kGreen50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kGreen300),
            ),
            child: Stack(
              children: [
                // Grid lines
                ...List.generate(
                  9,
                  (i) => Positioned(
                    top: 0,
                    bottom: 0,
                    left: (i + 1) * 30.0,
                    child: Container(width: 1, color: _kGreen200),
                  ),
                ),
                ...List.generate(
                  5,
                  (i) => Positioned(
                    left: 0,
                    right: 0,
                    top: (i + 1) * 30.0,
                    child: Container(height: 1, color: _kGreen200),
                  ),
                ),
                // Origin marker
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _kGreen800,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                // Children
                ...List.generate(
                  4,
                  (i) => Positioned(
                    left: i == _selectedChild ? _offsetX : (i + 1) * 50.0,
                    top: i == _selectedChild ? _offsetY : (i * 20.0) + 30,
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: i == _selectedChild ? _kGreen600 : _kGreen300,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: i == _selectedChild
                            ? [
                                BoxShadow(
                                  color: _kGreen700.withAlpha(80),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: i == _selectedChild
                              ? Colors.white
                              : _kGreen800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kGreen100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.code, color: _kGreen700, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'parentData.offset = Offset(${_offsetX.toInt()}, ${_offsetY.toInt()})',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: _kGreen800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Memory layout visualization
Widget _buildMemoryLayoutCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kGreen100, _kGreen50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Memory Layout',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kGreen900,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMemoryBlock('RenderFlex', 'Parent', _kGreen700),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: _kGreen600, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMemoryBlock('firstChild', 'Pointer', _kGreen600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildMemoryDetail('RenderBox', 'Child 0')),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMemoryDetail('ContainerBoxParentData', 'ParentData'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kGreen300),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDataField('offset', '(20, 30)'),
                    const SizedBox(width: 12),
                    _buildDataField('prev', 'null'),
                    const SizedBox(width: 12),
                    _buildDataField('next', 'Child1'),
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

Widget _buildMemoryBlock(String name, String type, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        Text(type, style: const TextStyle(color: Colors.white70, fontSize: 9)),
      ],
    ),
  );
}

Widget _buildMemoryDetail(String name, String type) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kGreen300),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: _kGreen800,
          ),
        ),
        Text(type, style: const TextStyle(fontSize: 8, color: _kGreen600)),
      ],
    ),
  );
}

Widget _buildDataField(String name, String value) {
  return Column(
    children: [
      Text(name, style: const TextStyle(fontSize: 9, color: _kGreen600)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: _kGreen100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: _kGreen800,
          ),
        ),
      ),
    ],
  );
}

/// Use cases card
Widget _buildUseCasesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kGreen300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Where ContainerBoxParentData is Used',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kGreen900,
          ),
        ),
        const SizedBox(height: 16),
        _buildUseCaseItem(
          Icons.view_column,
          'RenderFlex',
          'Row and Column layouts',
          'FlexParentData extends ContainerBoxParentData',
        ),
        _buildUseCaseItem(
          Icons.layers,
          'RenderStack',
          'Stack and Positioned widgets',
          'StackParentData extends ContainerBoxParentData',
        ),
        _buildUseCaseItem(
          Icons.wrap_text,
          'RenderWrap',
          'Wrap flow layouts',
          'WrapParentData extends ContainerBoxParentData',
        ),
        _buildUseCaseItem(
          Icons.view_list,
          'RenderListBody',
          'Simple list layouts',
          'ListBodyParentData extends ContainerBoxParentData',
        ),
      ],
    ),
  );
}

Widget _buildUseCaseItem(
  IconData icon,
  String name,
  String desc,
  String detail,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kGreen50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kGreen500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kGreen800,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kGreen700),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9,
                  color: _kGreen600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Traversal operations card
Widget _buildTraversalCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kGreen400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Traversal Operations',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kGreen900,
          ),
        ),
        const SizedBox(height: 16),
        _buildTraversalItem(
          'Forward',
          'child = firstChild;\nwhile (child != null) {\n  // process child\n  child = (child.parentData as ContainerBoxParentData).nextSibling;\n}',
          Icons.arrow_forward,
        ),
        const SizedBox(height: 12),
        _buildTraversalItem(
          'Backward',
          'child = lastChild;\nwhile (child != null) {\n  // process child\n  child = (child.parentData as ContainerBoxParentData).previousSibling;\n}',
          Icons.arrow_back,
        ),
      ],
    ),
  );
}

Widget _buildTraversalItem(String title, String code, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kGreen900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: _kGreen200, size: 16),
            const SizedBox(width: 8),
            Text(
              '$title Traversal',
              style: const TextStyle(
                color: _kGreen100,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 9,
            color: _kGreen100,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

/// Build results card
Widget _buildResultsCard(bool success, String className) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: success ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: success ? Colors.green[300]! : Colors.red[300]!,
      ),
    ),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error,
          color: success ? Colors.green[700] : Colors.red[700],
          size: 32,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                success ? 'Demo Successful' : 'Demo Failed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: success ? Colors.green[800] : Colors.red[800],
                ),
              ),
              Text(
                '$className concepts demonstrated',
                style: TextStyle(
                  fontSize: 12,
                  color: success ? Colors.green[600] : Colors.red[600],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _kGreen600,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // Print information about ContainerBoxParentData
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║       ContainerBoxParentData Deep Demo                           ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- ContainerBoxParentData Overview ---');
  print('Provides parent data for children in box containers.');
  print('Extends BoxParentData, mixes in ContainerParentDataMixin<RenderBox>.');

  print('\n--- Key Properties ---');
  print('offset: Position relative to parent (inherited from BoxParentData)');
  print('previousSibling: Previous child in linked list');
  print('nextSibling: Next child in linked list');

  print('\n--- Usage ---');
  print('Used by RenderFlex (Row/Column), RenderStack, RenderWrap, etc.');
  print('Enables efficient child traversal in both directions.');

  print('\nContainerBoxParentData test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF1F8E9), Color(0xFFE8F5E9)],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kGreen700, _kGreen900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kGreen800.withAlpha(80),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.account_tree,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ContainerBoxParentData',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'rendering library',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Parent data for box children in containers with offset positioning '
                    'and doubly-linked sibling navigation.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Info cards
          _buildInfoCard(
            'Position Management',
            'Stores offset for positioning children within parent bounds.',
            Icons.open_with,
          ),
          _buildInfoCard(
            'Sibling Navigation',
            'Maintains linked list of siblings for efficient traversal.',
            Icons.swap_horiz,
          ),

          // Class hierarchy
          _buildSectionTitle('Class Hierarchy', Icons.account_tree),
          _buildClassHierarchyCard(),
          const SizedBox(height: 20),

          // Properties
          _buildSectionTitle('Properties', Icons.list),
          _buildPropertiesCard(),
          const SizedBox(height: 20),

          // Sibling chain
          _buildSectionTitle('Sibling Chain', Icons.link),
          _buildSiblingChainVisualization(),
          const SizedBox(height: 20),

          // Interactive demo
          _buildSectionTitle('Offset Demo', Icons.tune),
          _buildInteractiveOffsetDemo(),
          const SizedBox(height: 20),

          // Memory layout
          _buildSectionTitle('Memory Layout', Icons.memory),
          _buildMemoryLayoutCard(),
          const SizedBox(height: 20),

          // Use cases
          _buildSectionTitle('Use Cases', Icons.apps),
          _buildUseCasesCard(),
          const SizedBox(height: 20),

          // Traversal
          _buildSectionTitle('Traversal', Icons.repeat),
          _buildTraversalCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet(
            'Custom ParentData Class',
            '''class MyParentData extends ContainerBoxParentData<RenderBox> {
  // Custom data
  int? flex;
  Alignment? alignment;
}''',
          ),
          _buildCodeSnippet('Setting Up ParentData', '''@override
void setupParentData(RenderObject child) {
  if (child.parentData is! ContainerBoxParentData) {
    child.parentData = ContainerBoxParentData<RenderBox>();
  }
}'''),
          _buildCodeSnippet('Using Offset in Layout', '''void performLayout() {
  RenderBox? child = firstChild;
  double y = 0;
  while (child != null) {
    final data = child.parentData as ContainerBoxParentData;
    data.offset = Offset(0, y);
    y += child.size.height;
    child = data.nextSibling;
  }
}'''),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'ContainerBoxParentData'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kGreen100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kGreen700, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kGreen900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ContainerBoxParentData combines box offset positioning with '
                  'doubly-linked sibling navigation, forming the foundation for '
                  'multi-child box layouts like Row, Column, Stack, and Wrap.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kGreen800,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('offset', Icons.open_with),
                    const SizedBox(width: 8),
                    _buildSummaryChip('siblings', Icons.swap_horiz),
                    const SizedBox(width: 8),
                    _buildSummaryChip('box', Icons.crop_square),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
