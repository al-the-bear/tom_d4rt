import 'package:flutter/material.dart';

/// Deep visual demo for AutocompleteHighlightedOption.
/// Shows highlighted option tracking in autocomplete.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AutocompleteHighlightedOption')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Use arrow keys to navigate options', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Autocomplete<String>(
            optionsBuilder: (v) => ['Apple', 'Apricot', 'Avocado', 'Banana', 'Blueberry']
              .where((o) => o.toLowerCase().contains(v.text.toLowerCase())),
            optionsViewBuilder: (ctx, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: SizedBox(
                    height: 200,
                    width: 280,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (ctx2, i) {
                        final opt = options.elementAt(i);
                        final highlighted = AutocompleteHighlightedOption.of(ctx2) == i;
                        return ListTile(
                          tileColor: highlighted ? Colors.blue.shade100 : null,
                          title: Text(opt, style: TextStyle(fontWeight: highlighted ? FontWeight.bold : FontWeight.normal)),
                          onTap: () => onSelected(opt),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const Text('AutocompleteHighlightedOption.of(context) returns current highlighted index',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ),
  );
}
