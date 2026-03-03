// D4rt test script: Tests showDialog from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('showDialog test executing');

  // Schedule showDialog via Future.microtask so it runs after the build completes
  // The dialog appears as an overlay on top of the current route
  Future.microtask(() {
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        print('showDialog builder called');
        return AlertDialog(
          title: Text('Test Dialog'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('showDialog works!'),
              SizedBox(height: 8.0),
              Text('This dialog was created via Future.microtask'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                print('Cancel pressed');
                Navigator.pop(ctx);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                print('OK pressed');
                Navigator.pop(ctx, 'ok');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    ).then((result) {
      print('showDialog result: $result');
    });
    print('showDialog called successfully');
  });

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('showDialog scheduled'),
        SizedBox(height: 8.0),
        Text('Dialog should appear as overlay'),
        SizedBox(height: 16.0),
        // Also provide a button to show dialog on demand
        ElevatedButton(
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (ctx) => SimpleDialog(
                title: Text('Simple Dialog'),
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      print('Option 1 selected');
                      Navigator.pop(ctx);
                    },
                    child: Text('Option 1'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      print('Option 2 selected');
                      Navigator.pop(ctx);
                    },
                    child: Text('Option 2'),
                  ),
                ],
              ),
            );
            print('SimpleDialog shown from button');
          },
          child: Text('Show SimpleDialog'),
        ),
      ],
    ),
  );
}
