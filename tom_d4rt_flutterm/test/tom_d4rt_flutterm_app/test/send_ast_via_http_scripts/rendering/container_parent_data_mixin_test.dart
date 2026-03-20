// D4rt test script: Comprehensive demo for ContainerParentDataMixin from rendering
//
// ContainerParentDataMixin adds sibling navigation to ParentData:
//   - previousSibling: Link to previous child
//   - nextSibling: Link to next child
//   - Forms a doubly-linked list of children
//
// This demo shows:
//   1. What ContainerParentDataMixin provides
//   2. How mixins work in Dart
//   3. Doubly-linked list navigation pattern
//   4. Integration with RenderObject containers
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kPurple50 = Color(0xFFF3E5F5);
const _kPurple100 = Color(0xFFE1BEE7);
const _kPurple200 = Color(0xFFCE93D8);
const _kPurple300 = Color(0xFFBA68C8);
const _kPurple400 = Color(0xFFAB47BC);
const _kPurple500 = Color(0xFF9C27B0);
const _kPurple600 = Color(0xFF8E24AA);
const _kPurple700 = Color(0xFF7B1FA2);
const _kPurple800 = Color(0xFF6A1B9A);
const _kPurple900 = Color(0xFF4A148C);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kPurple800, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
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
      color: _kPurple50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPurple200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kPurple100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kPurple800, size: 24),
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
                  color: _kPurple900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kPurple800),
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
      color: _kPurple900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kPurple800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kPurple200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kPurple100,
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
              color: Color(0xFFF3E5F5),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Mixin concept visualization
Widget _buildMixinConceptCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPurple300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is a Mixin?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMixinDiagramItem(
                'Base Class',
                Icons.category,
                _kPurple300,
              ),
            ),
            const Icon(Icons.add, color: _kPurple500, size: 24),
            Expanded(
              child: _buildMixinDiagramItem(
                'Mixin',
                Icons.extension,
                _kPurple500,
              ),
            ),
            const Icon(Icons.arrow_forward, color: _kPurple700, size: 24),
            Expanded(
              child: _buildMixinDiagramItem(
                'Combined',
                Icons.merge_type,
                _kPurple700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kPurple50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: _kPurple700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Mixins add functionality without full inheritance - like plugins for classes!',
                  style: TextStyle(fontSize: 11, color: _kPurple800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMixinDiagramItem(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(40),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

/// Mixin properties card
Widget _buildMixinPropertiesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPurple400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ContainerParentDataMixin Properties',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 16),
        _buildPropertyItem(
          'previousSibling',
          'ChildType?',
          'Reference to previous child in linked list',
          Icons.arrow_back,
        ),
        _buildPropertyItem(
          'nextSibling',
          'ChildType?',
          'Reference to next child in linked list',
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
      color: _kPurple50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPurple200),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kPurple500,
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
                      color: _kPurple900,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _kPurple200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9,
                        color: _kPurple800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(fontSize: 10, color: _kPurple700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Doubly linked list visualization
Widget _buildDoublyLinkedListVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPurple400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Doubly-Linked List Structure',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 16),
        // Parent container
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPurple100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kPurple300),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.folder, color: _kPurple700, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Parent Container',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _kPurple800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPointerBox('firstChild', 'A'),
                  _buildPointerBox('lastChild', 'C'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Icon(Icons.arrow_downward, color: _kPurple500, size: 24),
        ),
        const SizedBox(height: 8),
        // Children chain
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLinkedNode('A', null, 'B'),
              _buildLinkArrows(),
              _buildLinkedNode('B', 'A', 'C'),
              _buildLinkArrows(),
              _buildLinkedNode('C', 'B', null),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kPurple50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: _kPurple700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Each child has both previousSibling and nextSibling references',
                  style: TextStyle(fontSize: 11, color: _kPurple800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPointerBox(String label, String target) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: _kPurple500,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.arrow_forward, color: Colors.white70, size: 12),
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            target,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLinkedNode(String id, String? prev, String? next) {
  return Container(
    width: 80,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kPurple50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPurple400, width: 2),
    ),
    child: Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _kPurple600,
            borderRadius: BorderRadius.circular(18),
          ),
          alignment: Alignment.center,
          child: Text(
            id,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              prev ?? 'null',
              style: TextStyle(
                fontSize: 8,
                color: prev == null ? _kPurple300 : _kPurple700,
                fontStyle: prev == null ? FontStyle.italic : FontStyle.normal,
              ),
            ),
            Text(
              next ?? 'null',
              style: TextStyle(
                fontSize: 8,
                color: next == null ? _kPurple300 : _kPurple700,
                fontStyle: next == null ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLinkArrows() {
  return Column(
    children: [
      Row(
        children: [
          Container(width: 20, height: 2, color: _kPurple500),
          const Icon(Icons.arrow_forward_ios, size: 10, color: _kPurple500),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          const Icon(Icons.arrow_back_ios, size: 10, color: _kPurple400),
          Container(width: 20, height: 2, color: _kPurple400),
        ],
      ),
    ],
  );
}

/// Interactive navigation demo
Widget _buildInteractiveNavigationDemo() {
  return _InteractiveNavigationWidget();
}

class _InteractiveNavigationWidget extends StatefulWidget {
  @override
  State<_InteractiveNavigationWidget> createState() =>
      _InteractiveNavigationWidgetState();
}

class _InteractiveNavigationWidgetState
    extends State<_InteractiveNavigationWidget> {
  int _currentIndex = 0;
  final _children = ['A', 'B', 'C', 'D', 'E'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPurple400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Navigation Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kPurple900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Navigate through siblings using previousSibling and nextSibling:',
            style: TextStyle(fontSize: 11, color: _kPurple700),
          ),
          const SizedBox(height: 16),
          // Children visualization
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_children.length, (i) {
              final isSelected = i == _currentIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? _kPurple600 : _kPurple100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? _kPurple800 : _kPurple300,
                      width: isSelected ? 3 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: _kPurple500.withAlpha(80),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _children[i],
                    style: TextStyle(
                      color: isSelected ? Colors.white : _kPurple800,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavButton(
                'previousSibling',
                Icons.arrow_back,
                _currentIndex > 0,
                () => setState(() => _currentIndex--),
              ),
              const SizedBox(width: 20),
              _buildNavButton(
                'nextSibling',
                Icons.arrow_forward,
                _currentIndex < _children.length - 1,
                () => setState(() => _currentIndex++),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Current state display
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPurple50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildStateRow('Current', _children[_currentIndex]),
                _buildStateRow(
                  'previousSibling',
                  _currentIndex > 0 ? _children[_currentIndex - 1] : 'null',
                ),
                _buildStateRow(
                  'nextSibling',
                  _currentIndex < _children.length - 1
                      ? _children[_currentIndex + 1]
                      : 'null',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    String label,
    IconData icon,
    bool enabled,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: enabled ? _kPurple600 : _kPurple200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: enabled ? Colors.white : _kPurple400, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: enabled ? Colors.white : _kPurple400,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: _kPurple700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: value == 'null' ? _kPurple200 : _kPurple500,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: value == 'null' ? _kPurple500 : Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontStyle: value == 'null'
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Type parameter explanation
Widget _buildTypeParameterCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPurple100, _kPurple50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Generic Type Parameter',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kPurple300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _kPurple500,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '<ChildType extends RenderObject>',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'The mixin is generic over the child type, ensuring type-safe sibling navigation.',
                style: TextStyle(fontSize: 11, color: _kPurple700),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTypeExample('RenderBox', 'Box children')),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTypeExample('RenderSliver', 'Sliver children'),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTypeExample(String type, String desc) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPurple200),
    ),
    child: Column(
      children: [
        Text(
          type,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: _kPurple800,
          ),
        ),
        Text(desc, style: const TextStyle(fontSize: 9, color: _kPurple600)),
      ],
    ),
  );
}

/// Classes using the mixin
Widget _buildUsersCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPurple300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Classes Using This Mixin',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 16),
        _buildUserItem('ContainerBoxParentData', 'For RenderBox children'),
        _buildUserItem('SliverPhysicalParentData', 'For RenderSliver children'),
        _buildUserItem('FlexParentData', 'For Flex layout children'),
        _buildUserItem('StackParentData', 'For Stack layout children'),
      ],
    ),
  );
}

Widget _buildUserItem(String name, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kPurple50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kPurple500,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.class_, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _kPurple800,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 9, color: _kPurple600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Operations card
Widget _buildOperationsCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPurple400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Common Operations',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 16),
        _buildOperationItem(
          Icons.repeat,
          'Forward Iteration',
          'child = firstChild\nwhile (child != null)\n  child = child.nextSibling',
        ),
        _buildOperationItem(
          Icons.repeat_one,
          'Backward Iteration',
          'child = lastChild\nwhile (child != null)\n  child = child.previousSibling',
        ),
        _buildOperationItem(
          Icons.search,
          'Find by Index',
          'iterate n times from firstChild\nusing nextSibling',
        ),
      ],
    ),
  );
}

Widget _buildOperationItem(IconData icon, String title, String pseudo) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kPurple900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _kPurple200, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _kPurple100,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                pseudo,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9,
                  color: _kPurple200,
                  height: 1.4,
                ),
              ),
            ],
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
      color: _kPurple600,
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
  // Print information about ContainerParentDataMixin
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║       ContainerParentDataMixin Deep Demo                         ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- ContainerParentDataMixin Overview ---');
  print('A mixin that adds sibling navigation to ParentData classes.');
  print('Creates a doubly-linked list of children.');

  print('\n--- Key Properties ---');
  print('previousSibling: Reference to previous child');
  print('nextSibling: Reference to next child');

  print('\n--- Type Parameter ---');
  print('ChildType extends RenderObject');
  print('Ensures type-safe navigation between siblings.');

  print('\nContainerParentDataMixin test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF8F4FC), Color(0xFFF3E5F5)],
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
                colors: [_kPurple700, _kPurple900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kPurple800.withAlpha(80),
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
                        Icons.extension,
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
                            'ContainerParentDataMixin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'rendering library • mixin',
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
                    'A mixin for ParentData that adds sibling navigation capabilities, '
                    'forming a doubly-linked list of children for efficient traversal.',
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
            'Mixin Pattern',
            'Adds functionality to classes without full inheritance hierarchy.',
            Icons.extension,
          ),
          _buildInfoCard(
            'Sibling Links',
            'Enables bidirectional navigation between adjacent children.',
            Icons.swap_horiz,
          ),

          // Mixin concept
          _buildSectionTitle('What is a Mixin?', Icons.school),
          _buildMixinConceptCard(),
          const SizedBox(height: 20),

          // Properties
          _buildSectionTitle('Properties', Icons.list),
          _buildMixinPropertiesCard(),
          const SizedBox(height: 20),

          // Doubly linked list
          _buildSectionTitle('Linked List', Icons.link),
          _buildDoublyLinkedListVisualization(),
          const SizedBox(height: 20),

          // Interactive demo
          _buildSectionTitle('Navigate Siblings', Icons.navigation),
          _buildInteractiveNavigationDemo(),
          const SizedBox(height: 20),

          // Type parameter
          _buildSectionTitle('Type Parameter', Icons.code),
          _buildTypeParameterCard(),
          const SizedBox(height: 20),

          // Users
          _buildSectionTitle('Classes Using Mixin', Icons.category),
          _buildUsersCard(),
          const SizedBox(height: 20),

          // Operations
          _buildSectionTitle('Operations', Icons.settings),
          _buildOperationsCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet(
            'Mixin Definition',
            '''mixin ContainerParentDataMixin<
    ChildType extends RenderObject> on ParentData {
  ChildType? previousSibling;
  ChildType? nextSibling;
}''',
          ),
          _buildCodeSnippet(
            'Using the Mixin',
            '''class MyParentData extends ParentData
    with ContainerParentDataMixin<RenderBox> {
  // previousSibling and nextSibling are available
  // Additional custom data can be added here
}''',
          ),
          _buildCodeSnippet(
            'Traversing Children',
            '''void visitChildren(RenderObjectVisitor visitor) {
  RenderBox? child = firstChild;
  while (child != null) {
    visitor(child);
    final pd = child.parentData as ContainerParentDataMixin;
    child = pd.nextSibling as RenderBox?;
  }
}''',
          ),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'ContainerParentDataMixin'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kPurple100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kPurple700, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kPurple900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ContainerParentDataMixin adds previousSibling and nextSibling '
                  'properties to ParentData, creating a doubly-linked list for '
                  'efficient bidirectional child traversal in container render objects.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kPurple800,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('mixin', Icons.extension),
                    const SizedBox(width: 8),
                    _buildSummaryChip('linked', Icons.link),
                    const SizedBox(width: 8),
                    _buildSummaryChip('generic', Icons.code),
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
