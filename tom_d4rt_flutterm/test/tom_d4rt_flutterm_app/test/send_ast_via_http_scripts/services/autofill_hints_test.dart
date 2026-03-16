import 'package:flutter/material.dart';

/// Deep visual demo for AutofillHints
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Autofill Hints')), body: Padding(padding: EdgeInsets.all(8), child: Column(children: [
    Text('AutofillHints', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 8),
    Expanded(child: GridView.count(crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4, childAspectRatio: 2,
      children: [
        _HintCard('email', Icons.email),
        _HintCard('password', Icons.lock),
        _HintCard('username', Icons.person),
        _HintCard('name', Icons.badge),
        _HintCard('phone', Icons.phone),
        _HintCard('address', Icons.home),
        _HintCard('postalCode', Icons.markunread_mailbox),
        _HintCard('city', Icons.location_city),
        _HintCard('country', Icons.flag),
        _HintCard('creditCard', Icons.credit_card),
        _HintCard('birthday', Icons.cake),
        _HintCard('newPassword', Icons.vpn_key),
      ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Platform fills matching fields automatically', style: TextStyle(fontSize: 10))),
  ])));
}

class _HintCard extends StatelessWidget {
  final String name; final IconData icon;
  const _HintCard(this.name, this.icon);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(6)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 18, color: Colors.purple), Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 8))]));
}
