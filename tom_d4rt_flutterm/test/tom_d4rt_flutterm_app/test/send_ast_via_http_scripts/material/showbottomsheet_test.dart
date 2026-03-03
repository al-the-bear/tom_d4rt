// D4rt test script: Tests showModalBottomSheet, showBottomSheet from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('showBottomSheet test executing');

  // Schedule showModalBottomSheet via Future.microtask
  Future.microtask(() {
    showModalBottomSheet<String>(
      context: context,
      builder: (ctx) {
        print('showModalBottomSheet builder called');
        return Container(
          height: 250,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Modal Bottom Sheet',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('This bottom sheet was shown via Future.microtask'),
              SizedBox(height: 16.0),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () {
                  print('Share tapped');
                  Navigator.pop(ctx, 'share');
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Get link'),
                onTap: () {
                  print('Get link tapped');
                  Navigator.pop(ctx, 'link');
                },
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: false,
    ).then((result) {
      print('showModalBottomSheet result: $result');
    });
    print('showModalBottomSheet called');
  });

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('showModalBottomSheet scheduled'),
        SizedBox(height: 8.0),
        Text('Bottom sheet should appear from below'),
        SizedBox(height: 16.0),
        // Button for showModalBottomSheet with different shape
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (ctx) => DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.4,
                minChildSize: 0.2,
                maxChildSize: 0.8,
                builder: (scrollCtx, scrollController) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Text(
                          'Draggable Bottom Sheet',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ...List.generate(
                          10,
                          (i) => ListTile(title: Text('Item ${i + 1}')),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
            print('Draggable bottom sheet shown');
          },
          child: Text('Show Draggable Sheet'),
        ),
        SizedBox(height: 8.0),
        // Button to test showBottomSheet (persistent, via Scaffold)
        Builder(
          builder: (scaffoldCtx) {
            return ElevatedButton(
              onPressed: () {
                try {
                  Scaffold.of(scaffoldCtx).showBottomSheet(
                    (ctx) => Container(
                      height: 150,
                      color: Colors.blue.shade100,
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Persistent Bottom Sheet'),
                          SizedBox(height: 8.0),
                          Text(
                            'Shown via Scaffold.of(context).showBottomSheet',
                          ),
                        ],
                      ),
                    ),
                  );
                  print('showBottomSheet (persistent) called');
                } catch (e) {
                  print('showBottomSheet failed: $e');
                }
              },
              child: Text('Show Persistent Sheet'),
            );
          },
        ),
      ],
    ),
  );
}
