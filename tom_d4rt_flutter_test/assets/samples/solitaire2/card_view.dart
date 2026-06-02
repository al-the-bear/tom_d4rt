import 'package:flutter/material.dart';

import 'engine.dart';

class CardView extends StatelessWidget {
  final PlayingCard card;
  final double width;
  final bool highlight;
  const CardView({
    super.key,
    required this.card,
    required this.width,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final height = width * 1.4;
    if (!card.faceUp) {
      return _Back(width: width, height: height);
    }
    final color = card.isRed
        ? const Color(0xFFC62828)
        : const Color(0xFF1A1A1A);
    final radius = width * 0.10;
    final corner = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          card.rankStr,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w800,
            fontSize: width * 0.30,
            height: 1.0,
          ),
        ),
        Text(
          card.suitStr,
          style: TextStyle(
            color: color,
            fontSize: width * 0.24,
            height: 1.0,
          ),
        ),
      ],
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: highlight
              ? Colors.amber
              : Colors.black.withOpacity(0.25),
          width: highlight ? 2.0 : 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: width * 0.06,
            left: width * 0.08,
            child: corner,
          ),
          Center(
            child: Text(
              card.suitStr,
              style: TextStyle(
                color: color.withOpacity(0.85),
                fontSize: width * 0.6,
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            bottom: width * 0.06,
            right: width * 0.08,
            child: Transform.rotate(
              angle: 3.14159265,
              child: corner,
            ),
          ),
        ],
      ),
    );
  }
}

class _Back extends StatelessWidget {
  final double width;
  final double height;
  const _Back({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final radius = width * 0.10;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius * 0.7),
            border: Border.all(
              color: Colors.white.withOpacity(0.55),
              width: 1.2,
            ),
          ),
          child: Center(
            child: Text(
              '\u2660\u2665\u2666\u2663',
              style: TextStyle(
                color: Colors.white.withOpacity(0.55),
                fontSize: width * 0.18,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptySlot extends StatelessWidget {
  final double width;
  final IconData? icon;
  final String? label;
  final bool highlight;
  const EmptySlot({
    super.key,
    required this.width,
    this.icon,
    this.label,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final h = width * 1.4;
    return Container(
      width: width,
      height: h,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.18),
        borderRadius: BorderRadius.circular(width * 0.10),
        border: Border.all(
          color: highlight
              ? Colors.amber
              : Colors.white.withOpacity(0.30),
          width: highlight ? 2.0 : 1.2,
        ),
      ),
      child: Center(
        child: icon != null
            ? Icon(
                icon,
                color: Colors.white.withOpacity(0.55),
                size: width * 0.42,
              )
            : (label != null
                ? Text(
                    label!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: width * 0.36,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}
