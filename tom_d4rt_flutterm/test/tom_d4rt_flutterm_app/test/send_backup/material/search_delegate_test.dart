import 'package:flutter/material.dart';

/// Deep visual demo for SearchDelegate abstract class.
/// Defines search UI and behavior for showSearch().
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SearchDelegate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 130,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Container(
              height: 36,
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.centerLeft,
                      child: const Text('flutter', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.clear, color: Colors.white, size: 14),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: const [
                  _SuggestionItem('flutter widgets'),
                  _SuggestionItem('flutter material'),
                  _SuggestionItem('flutter cupertino'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('buildSuggestions, buildResults, buildActions', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _SuggestionItem extends StatelessWidget {
  final String text;
  const _SuggestionItem(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.history, size: 14, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
