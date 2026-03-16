import 'package:flutter/material.dart';

/// Deep visual demo for DefaultMaterialLocalizations - US English localization.
/// Shows localized strings for Material widgets.
dynamic build(BuildContext context) {
  final loc = DefaultMaterialLocalizations();
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DefaultMaterialLocalizations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LocaleEntry('okButtonLabel', loc.okButtonLabel),
            _LocaleEntry('cancelButtonLabel', loc.cancelButtonLabel),
            _LocaleEntry('copyButtonLabel', loc.copyButtonLabel),
            _LocaleEntry('pasteButtonLabel', loc.pasteButtonLabel),
            _LocaleEntry('selectAllButtonLabel', loc.selectAllButtonLabel),
            _LocaleEntry('cutButtonLabel', loc.cutButtonLabel),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Extend for custom localizations', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _LocaleEntry extends StatelessWidget {
  final String localeKey;
  final String value;
  const _LocaleEntry(this.localeKey, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(localeKey, style: const TextStyle(fontSize: 10, fontFamily: 'monospace'))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: Colors.green.shade200, borderRadius: BorderRadius.circular(4)),
            child: Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
