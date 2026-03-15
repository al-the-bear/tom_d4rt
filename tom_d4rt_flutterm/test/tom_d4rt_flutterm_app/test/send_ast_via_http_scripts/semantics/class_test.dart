import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  final config = SemanticsConfiguration()
    ..label = 'Demo Button'
    ..isButton = true;
  final tag = SemanticsTag('test-tag');
  final localeAttr = LocaleStringAttribute(
    range: const TextRange(start: 0, end: 5),
    locale: const Locale('en', 'US'),
  );
  final spellAttr = SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 4),
  );
  final announce = AnnounceSemanticsEvent('hello', TextDirection.ltr, 0);
  const tap = TapSemanticEvent();
  const longPress = LongPressSemanticsEvent();

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Semantics Class Visual Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: config.label,
          button: config.isButton,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Accessible Button'),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(label: Text('Tag: ${tag.name}')),
            Chip(label: Text('Locale: ${localeAttr.locale.toLanguageTag()}')),
            Chip(label: Text('Spell range: ${spellAttr.range}')),
            Chip(label: Text('Announce: ${announce.type}')),
            Chip(label: Text('Tap: ${tap.type}')),
            Chip(label: Text('LongPress: ${longPress.type}')),
            Chip(label: Text('Actions: ${SemanticsAction.values.length}')),
          ],
        ),
      ],
    ),
  );
}
