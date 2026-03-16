import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for HapticFeedback
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Haptic Feedback')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('HapticFeedback', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _FeedbackButton('vibrate', 'Standard vibration', Colors.blue, () => HapticFeedback.vibrate()),
    _FeedbackButton('lightImpact', 'Light tap', Colors.green, () => HapticFeedback.lightImpact()),
    _FeedbackButton('mediumImpact', 'Medium tap', Colors.orange, () => HapticFeedback.mediumImpact()),
    _FeedbackButton('heavyImpact', 'Heavy tap', Colors.red, () => HapticFeedback.heavyImpact()),
    _FeedbackButton('selectionClick', 'Selection feedback', Colors.purple, () => HapticFeedback.selectionClick()),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Tap buttons to feel haptics (mobile only)', style: TextStyle(fontSize: 11))),
  ])));
}

class _FeedbackButton extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final VoidCallback onTap;
  const _FeedbackButton(this.name, this.desc, this.color, this.onTap);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8),
    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: color.shade100, foregroundColor: color.shade800, padding: EdgeInsets.all(16)),
      onPressed: onTap, child: Row(children: [Icon(Icons.vibration, color: color), SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 10))])])));
}
