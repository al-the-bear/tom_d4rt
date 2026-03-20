// D4rt test script: Comprehensive demo for ContainerRenderObjectMixin from rendering
//
// ContainerRenderObjectMixin manages children in render objects:
//   - firstChild/lastChild: Access to child list endpoints
//   - childCount: Number of children
//   - insert/remove/move: Child manipulation methods
//   - visitChildren: Iteration over all children
//
// This demo shows:
//   1. What ContainerRenderObjectMixin provides
//   2. Child list management operations
//   3. Integration with ParentData
//   4. Common usage patterns
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kTeal50 = Color(0xFFE0F2F1);
const _kTeal100 = Color(0xFFB2DFDB);
const _kTeal200 = Color(0xFF80CBC4);
const _kTeal300 = Color(0xFF4DB6AC);
const _kTeal400 = Color(0xFF26A69A);
const _kTeal500 = Color(0xFF009688);
const _kTeal600 = Color(0xFF00897B);
const _kTeal700 = Color(0xFF00796B);
const _kTeal800 = Color(0xFF00695C);
const _kTeal900 = Color(0xFF004D40);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kTeal800, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kTeal900,
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
      color: _kTeal50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kTeal100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kTeal800, size: 24),
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
                  color: _kTeal900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kTeal800),
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
      color: _kTeal900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kTeal800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kTeal200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kTeal100,
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
              color: Color(0xFFE0F2F1),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Mixin purpose card
Widget _buildMixinPurposeCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What This Mixin Does',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal900,
          ),
        ),
        const SizedBox(height: 16),
        _buildPurposeItem(
          Icons.folder,
          'Container Management',
          'Manages a collection of child render objects',
        ),
        _buildPurposeItem(
          Icons.link,
          'Doubly-Linked List',
          'Children stored in linked list for efficient traversal',
        ),
        _buildPurposeItem(
          Icons.data_object,
          'ParentData Integration',
          'Works with ContainerParentDataMixin',
        ),
        _buildPurposeItem(
          Icons.build,
          'Common Operations',
          'Insert, remove, move, and visit children',
        ),
      ],
    ),
  );
}

Widget _buildPurposeItem(IconData icon, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kTeal500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: _kTeal900,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 10, color: _kTeal700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Properties and methods card
Widget _buildPropertiesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Properties & Methods',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal900,
          ),
        ),
        const SizedBox(height: 16),
        _buildApiSection('Properties', [
          ('firstChild', 'ChildType?', 'First child in list'),
          ('lastChild', 'ChildType?', 'Last child in list'),
          ('childCount', 'int', 'Number of children'),
        ]),
        const SizedBox(height: 12),
        _buildApiSection('Methods', [
          ('insert', 'void', 'Add child to list'),
          ('remove', 'void', 'Remove child from list'),
          ('move', 'void', 'Move child in list'),
          ('visitChildren', 'void', 'Iterate over children'),
        ]),
      ],
    ),
  );
}

Widget _buildApiSection(String title, List<(String, String, String)> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _kTeal600,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 8),
      ...items.map((item) => _buildApiItem(item.$1, item.$2, item.$3)),
    ],
  );
}

Widget _buildApiItem(String name, String type, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _kTeal50,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: _kTeal800,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: _kTeal200,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: _kTeal800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 9, color: _kTeal700),
          ),
        ),
      ],
    ),
  );
}

/// Child list visualization
Widget _buildChildListVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Child List Structure',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal900,
          ),
        ),
        const SizedBox(height: 16),
        // Render object with children
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kTeal700,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.widgets, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'RenderBox with ContainerRenderObjectMixin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPointerField('firstChild', 'A'),
                  _buildPointerField('lastChild', 'D'),
                  _buildPointerField('childCount', '4'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Icon(Icons.arrow_downward, color: _kTeal500, size: 24),
        ),
        const SizedBox(height: 8),
        // Children chain
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildChildNode('A', true, false),
              _buildLinkArrow(),
              _buildChildNode('B', false, false),
              _buildLinkArrow(),
              _buildChildNode('C', false, false),
              _buildLinkArrow(),
              _buildChildNode('D', false, true),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kTeal50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: _kTeal700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Children are linked via ParentData (ContainerParentDataMixin)',
                  style: TextStyle(fontSize: 11, color: _kTeal800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPointerField(String label, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(50),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildChildNode(String id, bool isFirst, bool isLast) {
  return Container(
    width: 70,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: (isFirst || isLast) ? _kTeal200 : _kTeal100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: (isFirst || isLast) ? _kTeal600 : _kTeal400,
        width: (isFirst || isLast) ? 2 : 1,
      ),
    ),
    child: Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _kTeal600,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            id,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isFirst
              ? 'first'
              : isLast
              ? 'last'
              : 'child',
          style: TextStyle(
            fontSize: 9,
            color: _kTeal700,
            fontWeight: (isFirst || isLast)
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLinkArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      children: [
        Row(
          children: [
            Container(width: 16, height: 2, color: _kTeal500),
            const Icon(Icons.arrow_forward_ios, size: 10, color: _kTeal500),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.arrow_back_ios, size: 10, color: _kTeal400),
            Container(width: 16, height: 2, color: _kTeal400),
          ],
        ),
      ],
    ),
  );
}

/// Interactive operations demo
Widget _buildInteractiveOperationsDemo() {
  return _InteractiveOperationsWidget();
}

class _InteractiveOperationsWidget extends StatefulWidget {
  @override
  State<_InteractiveOperationsWidget> createState() =>
      _InteractiveOperationsWidgetState();
}

class _InteractiveOperationsWidgetState
    extends State<_InteractiveOperationsWidget> {
  List<String> _children = ['A', 'B', 'C'];
  int _nextId = 4;

  String _getNextId() {
    final chars = 'DEFGHIJKLMNOPQRSTUVWXYZ';
    if (_nextId - 4 < chars.length) {
      return chars[_nextId++ - 4];
    }
    return 'X${_nextId++}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kTeal400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Operations Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kTeal900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Simulate child list operations:',
            style: TextStyle(fontSize: 11, color: _kTeal700),
          ),
          const SizedBox(height: 16),
          // Operation buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildOpButton('insert', Icons.add, _children.length < 8, () {
                setState(() => _children.add(_getNextId()));
              }),
              _buildOpButton('remove', Icons.remove, _children.isNotEmpty, () {
                setState(() => _children.removeLast());
              }),
              _buildOpButton(
                'move first→last',
                Icons.swap_horiz,
                _children.length > 1,
                () {
                  setState(() {
                    final first = _children.removeAt(0);
                    _children.add(first);
                  });
                },
              ),
              _buildOpButton(
                'clear',
                Icons.clear_all,
                _children.isNotEmpty,
                () {
                  setState(() {
                    _children.clear();
                    _nextId = 4;
                  });
                },
              ),
              _buildOpButton('reset', Icons.refresh, true, () {
                setState(() {
                  _children = ['A', 'B', 'C'];
                  _nextId = 4;
                });
              }),
            ],
          ),
          const SizedBox(height: 16),
          // Children visualization
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: _kTeal50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _children.isEmpty
                ? const Center(
                    child: Text(
                      'No children',
                      style: TextStyle(
                        color: _kTeal400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(12),
                    itemCount: _children.length,
                    separatorBuilder: (_, __) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: _kTeal400,
                        size: 16,
                      ),
                    ),
                    itemBuilder: (_, i) => Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: _kTeal500,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _children[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          // State info
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kTeal100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStateItem('childCount', '${_children.length}'),
                _buildStateItem(
                  'firstChild',
                  _children.isNotEmpty ? _children.first : 'null',
                ),
                _buildStateItem(
                  'lastChild',
                  _children.isNotEmpty ? _children.last : 'null',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpButton(
    String label,
    IconData icon,
    bool enabled,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: enabled ? _kTeal600 : _kTeal200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: enabled ? Colors.white : _kTeal400, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: enabled ? Colors.white : _kTeal400,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: _kTeal700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: value == 'null' ? _kTeal200 : _kTeal500,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: value == 'null' ? _kTeal500 : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontStyle: value == 'null' ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}

/// Use cases card
Widget _buildUseCasesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kTeal100, _kTeal50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Classes Using This Mixin',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal900,
          ),
        ),
        const SizedBox(height: 16),
        _buildUseCase('RenderFlex', 'Row/Column layouts'),
        _buildUseCase('RenderStack', 'Stack layouts'),
        _buildUseCase('RenderWrap', 'Wrap layouts'),
        _buildUseCase('RenderListBody', 'Simple list layouts'),
        _buildUseCase('RenderViewport', 'Scrollable viewports'),
      ],
    ),
  );
}

Widget _buildUseCase(String name, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kTeal200),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kTeal500,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.widgets, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: _kTeal800,
              ),
            ),
            Text(desc, style: const TextStyle(fontSize: 9, color: _kTeal600)),
          ],
        ),
      ],
    ),
  );
}

/// Integration diagram
Widget _buildIntegrationDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Integration with ParentData',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal900,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildIntegrationBox(
                'ContainerRenderObjectMixin',
                'On RenderObject',
                _kTeal700,
                ['firstChild', 'lastChild', 'childCount'],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const Icon(Icons.sync_alt, color: _kTeal500, size: 24),
                  const Text(
                    'uses',
                    style: TextStyle(fontSize: 9, color: _kTeal600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildIntegrationBox(
                'ContainerParentDataMixin',
                'On ParentData',
                _kTeal600,
                ['previousSibling', 'nextSibling'],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kTeal50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'The mixin on RenderObject manages children, while ParentData stores '
            'the sibling links that form the doubly-linked list.',
            style: TextStyle(fontSize: 11, color: _kTeal800),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildIntegrationBox(
  String title,
  String subtitle,
  Color color,
  List<String> props,
) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 8, color: color.withAlpha(180)),
        ),
        const SizedBox(height: 8),
        ...props.map(
          (p) => Container(
            margin: const EdgeInsets.only(bottom: 2),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              p,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 8,
                color: Colors.white,
              ),
            ),
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
      color: _kTeal600,
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
  // Print information about ContainerRenderObjectMixin
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║       ContainerRenderObjectMixin Deep Demo                       ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- ContainerRenderObjectMixin Overview ---');
  print('A mixin for RenderObject that provides child list management.');
  print('Works with ContainerParentDataMixin for sibling navigation.');

  print('\n--- Key Properties ---');
  print('firstChild: First child in list');
  print('lastChild: Last child in list');
  print('childCount: Number of children');

  print('\n--- Key Methods ---');
  print('insert: Add child to list');
  print('remove: Remove child from list');
  print('move: Reposition child in list');
  print('visitChildren: Iterate over all children');

  print('\nContainerRenderObjectMixin test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF0FAFA), Color(0xFFE0F2F1)],
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
                colors: [_kTeal700, _kTeal900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kTeal800.withAlpha(80),
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
                        Icons.folder_special,
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
                            'ContainerRenderObjectMixin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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
                    'A mixin for RenderObject that provides child list management, '
                    'including firstChild, lastChild, insert, remove, and visitChildren.',
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
            'Child Management',
            'Full API for managing a list of child render objects.',
            Icons.folder,
          ),
          _buildInfoCard(
            'Efficient Traversal',
            'Uses doubly-linked list for O(1) insertion/removal.',
            Icons.speed,
          ),

          // Purpose
          _buildSectionTitle('Purpose', Icons.info),
          _buildMixinPurposeCard(),
          const SizedBox(height: 20),

          // Properties
          _buildSectionTitle('API Surface', Icons.api),
          _buildPropertiesCard(),
          const SizedBox(height: 20),

          // Child list visualization
          _buildSectionTitle('Child List', Icons.account_tree),
          _buildChildListVisualization(),
          const SizedBox(height: 20),

          // Interactive demo
          _buildSectionTitle('Operations Demo', Icons.touch_app),
          _buildInteractiveOperationsDemo(),
          const SizedBox(height: 20),

          // Integration
          _buildSectionTitle('Integration', Icons.sync_alt),
          _buildIntegrationDiagram(),
          const SizedBox(height: 20),

          // Use cases
          _buildSectionTitle('Use Cases', Icons.category),
          _buildUseCasesCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet(
            'Using the Mixin',
            '''class RenderMyContainer extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData>,
         RenderBoxContainerDefaultsMixin<RenderBox, ContainerBoxParentData> {
  
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! ContainerBoxParentData) {
      child.parentData = ContainerBoxParentData<RenderBox>();
    }
  }
}''',
          ),
          _buildCodeSnippet('Iterating Children', '''void performLayout() {
  RenderBox? child = firstChild;
  while (child != null) {
    // Layout each child
    child.layout(constraints, parentUsesSize: true);
    child = childAfter(child);
  }
}'''),
          _buildCodeSnippet('Painting Children', '''@override
void paint(PaintingContext context, Offset offset) {
  defaultPaint(context, offset); // From defaults mixin
  // Or manually:
  RenderBox? child = firstChild;
  while (child != null) {
    final pd = child.parentData as BoxParentData;
    context.paintChild(child, pd.offset + offset);
    child = childAfter(child);
  }
}'''),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'ContainerRenderObjectMixin'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kTeal100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kTeal700, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kTeal900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ContainerRenderObjectMixin provides child list management for '
                  'RenderObjects. It works with ContainerParentDataMixin to create '
                  'efficient doubly-linked list navigation for multi-child layouts.',
                  style: TextStyle(fontSize: 12, color: _kTeal800, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('children', Icons.folder),
                    const SizedBox(width: 8),
                    _buildSummaryChip('link', Icons.link),
                    const SizedBox(width: 8),
                    _buildSummaryChip('mixin', Icons.extension),
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
