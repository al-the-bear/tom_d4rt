import 'package:flutter/material.dart';

/// Deep visual demo for SnackBarClosedReason
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SnackBarClosedReason Demo')), body: Center(child: ElevatedButton(onPressed: () async { final reason = await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Swipe or wait'), action: SnackBarAction(label: 'Dismiss', onPressed: () {}), duration: Duration(seconds: 3))).closed; ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Closed: \$reason'), duration: Duration(seconds: 1))); }, child: Text('Show SnackBar'))));
}
