import 'package:flutter/material.dart';

/// Deep visual demo for AutofillScopeMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Autofill Scope')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('AutofillGroup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange, width: 2), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Login Form', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
        SizedBox(height: 12),
        TextField(decoration: InputDecoration(labelText: 'Email', hintText: 'user@example.com', border: OutlineInputBorder()), autofillHints: [AutofillHints.email]),
        SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()), obscureText: true, autofillHints: [AutofillHints.password]),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('AutofillGroup groups fields for batch autofill', style: TextStyle(fontSize: 11))),
  ])));
}
