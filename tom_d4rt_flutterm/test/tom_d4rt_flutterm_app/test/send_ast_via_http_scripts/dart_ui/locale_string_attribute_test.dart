import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for LocaleStringAttribute - locale annotation for text.
/// Demonstrates marking text spans with language locale.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('LocaleStringAttribute Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Locale String Attribute', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Annotate text spans with language locale', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.indigo.shade100, Colors.blue.shade100]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Multi-language Text:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildLocalizedText('Hello', 'en', Colors.blue),
                _buildLocalizedText('Bonjour', 'fr', Colors.red),
                _buildLocalizedText('こんにちは', 'ja', Colors.green),
                _buildLocalizedText('Hola', 'es', Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Used by accessibility tools and TTS to pronounce text correctly per locale.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildLocalizedText(String text, String locale, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
          child: Text(locale, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 18)),
      ],
    ),
  );
}
