import 'package:flutter/material.dart';

import 'landmarks.dart';
import 'plan_painter.dart';

class PlanHome extends StatefulWidget {
  const PlanHome({super.key});

  @override
  State<PlanHome> createState() => _PlanHomeState();
}

class _PlanHomeState extends State<PlanHome> {
  Landmark? _selected;

  void _selectById(String id) {
    final lm = kLandmarks.firstWhere((l) => l.id == id,
        orElse: () => kLandmarks.first);
    setState(() => _selected = lm);
    print('selected ${lm.id}');
  }

  void _handleTapOnPlan(Offset localPos, Size planSize) {
    final nx = localPos.dx / planSize.width;
    final ny = localPos.dy / planSize.height;

    // Walk the list in REVERSE so the most specific landmark (drawn last,
    // like the obelisk inside the square) wins over the bigger area below
    // it.
    Landmark? hit;
    for (int i = kLandmarks.length - 1; i >= 0; i--) {
      final lm = kLandmarks[i];
      if (lm.hitRect.contains(Offset(nx, ny))) {
        // Prefer the SMALLEST matching rect (most specific).
        if (hit == null ||
            lm.hitRect.width * lm.hitRect.height <
                hit.hitRect.width * hit.hitRect.height) {
          hit = lm;
        }
      }
    }

    if (hit != null) {
      setState(() => _selected = hit);
      print('tap hit ${hit!.id} at ($nx, $ny)');
    } else {
      setState(() => _selected = null);
      print('tap miss at ($nx, $ny)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("St. Peter's Basilica — Plan"),
        backgroundColor: const Color(0xFFB08D57),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Landmarks',
            icon: const Icon(Icons.list),
            onPressed: _showLandmarkList,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Decide layout: wide -> plan + side panel; tall -> plan + bottom panel.
          final wide = constraints.maxWidth >= 760;
          final plan = _buildPlan();
          final info = _buildInfoPanel();
          if (wide) {
            return Row(
              children: [
                Expanded(flex: 3, child: plan),
                SizedBox(width: 280, child: info),
              ],
            );
          }
          return Column(
            children: [
              Expanded(child: plan),
              SizedBox(
                height: 180,
                child: info,
              ),
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
          aspectRatio: 1.4,
          child: LayoutBuilder(
            builder: (context, c) {
              final size = Size(c.maxWidth, c.maxHeight);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (d) => _handleTapOnPlan(d.localPosition, size),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    painter: PlanPainter(highlightId: _selected?.id),
                    size: size,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPanel() {
    final lm = _selected;
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB5A074)),
      ),
      child: lm == null
          ? const _HintPanel()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(lm.icon, color: const Color(0xFF8A6E2E)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        lm.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3D2F14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  lm.italian,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF7A5E2A),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      lm.description,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF3D2F14), height: 1.35),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _showLandmarkList() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFFF4ECD8),
      builder: (ctx) {
        return SafeArea(
          child: ListView(
            children: kLandmarks.map((lm) {
              return ListTile(
                leading: Icon(lm.icon, color: const Color(0xFF8A6E2E)),
                title: Text(lm.name),
                subtitle: Text(lm.italian,
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _selectById(lm.id);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _HintPanel extends StatelessWidget {
  const _HintPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Row(
          children: [
            Icon(Icons.touch_app, color: Color(0xFF8A6E2E)),
            SizedBox(width: 8),
            Text(
              'Tap a landmark on the plan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D2F14),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'North is up. The basilica faces east toward St. Peter’s Square; '
          'Via della Conciliazione leads to the Tiber and Castel Sant’Angelo.',
          style: TextStyle(fontSize: 12, color: Color(0xFF3D2F14)),
        ),
      ],
    );
  }
}
