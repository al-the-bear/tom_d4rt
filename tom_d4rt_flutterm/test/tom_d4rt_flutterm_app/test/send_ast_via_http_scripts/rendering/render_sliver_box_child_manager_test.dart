// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderSliverBoxChildManager Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Sliver Box Child Manager',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverList.list(
              children: const [
                ListTile(title: Text('Child 1')),
                ListTile(title: Text('Child 2')),
                ListTile(title: Text('Child 3')),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
