import 'package:flutter/material.dart';

import 'context_map.dart';
import 'hotspots.dart';
import 'plan_painter.dart';

class PlanHome extends StatefulWidget {
  const PlanHome({super.key});

  @override
  State<PlanHome> createState() => _PlanHomeState();
}

class _PlanHomeState extends State<PlanHome> {
  String? _selectedId;

  Hotspot? get _selected {
    if (_selectedId == null) return null;
    for (final h in kHotspots) {
      if (h.id == _selectedId) return h;
    }
    return null;
  }

  void _handleTap(Offset local, Size renderSize) {
    final sx = renderSize.width / kPlanW;
    final sy = renderSize.height / kPlanH;
    final designX = local.dx / sx;
    final designY = local.dy / sy;

    String? hit;
    // hotspots are checked in declaration order; the smaller ones
    // (statue, baldachin) are later in the list and win over their
    // enclosing room because we keep iterating.
    for (final h in kHotspots) {
      if (h.rect.contains(Offset(designX, designY))) {
        hit = h.id;
      }
    }
    setState(() => _selectedId = hit);
    if (hit != null) {
      print('Selected hotspot: $hit');
    } else {
      print('Tapped empty area at design ($designX, $designY)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5E6),
      appBar: AppBar(
        title: const Text("Basilica of St. Paul Outside the Walls"),
        backgroundColor: const Color(0xFF8B6F3F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 820;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 3, child: _buildPlan()),
                SizedBox(
                  width: 320,
                  child: _buildSidePanel(),
                ),
              ],
            );
          }
          return Column(
            children: [
              Expanded(child: _buildPlan()),
              SizedBox(height: 260, child: _buildSidePanel()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlan() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: AspectRatio(
          aspectRatio: kPlanW / kPlanH,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = Size(constraints.maxWidth, constraints.maxHeight);
              return GestureDetector(
                onTapDown: (details) => _handleTap(details.localPosition, size),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF6B5530)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    painter: PlanPainter(selectedId: _selectedId),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSidePanel() {
    final sel = _selected;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 12, 12, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0D2A8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ContextMap(),
          const SizedBox(height: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: sel == null
                  ? _buildIntro()
                  : _buildSelectedInfo(sel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return SingleChildScrollView(
      key: const ValueKey('intro'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'San Paolo fuori le Mura',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5A4520),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'One of the four major papal basilicas of Rome, built '
            'over the tomb of the Apostle Paul. Originally raised by '
            'Constantine in the 4th century, enlarged by Theodosius, '
            'destroyed by fire in 1823 and rebuilt to the same plan.',
            style: TextStyle(fontSize: 13, height: 1.35),
          ),
          SizedBox(height: 12),
          Text(
            'Tap a coloured zone on the plan to read about it.',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Color(0xFF6B5530),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedInfo(Hotspot h) {
    return SingleChildScrollView(
      key: ValueKey<String>('info-${h.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E6CC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(h.icon, color: const Color(0xFF8B6F3F)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  h.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5A4520),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            h.description,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => setState(() => _selectedId = null),
              icon: const Icon(Icons.close, size: 16),
              label: const Text('Clear'),
            ),
          ),
        ],
      ),
    );
  }
}
