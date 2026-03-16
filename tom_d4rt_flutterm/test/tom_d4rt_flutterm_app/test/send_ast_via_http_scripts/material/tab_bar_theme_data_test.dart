import 'package:flutter/material.dart';

/// Deep visual demo for TabBarThemeData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TabBarThemeData Demo')), body: Theme(data: Theme.of(context).copyWith(tabBarTheme: TabBarThemeData(labelColor: Colors.purple, unselectedLabelColor: Colors.grey, indicatorColor: Colors.purple, indicatorSize: TabBarIndicatorSize.label)), child: DefaultTabController(length: 3, child: Column(children: [TabBar(tabs: [Tab(icon: Icon(Icons.home), text: 'Home'), Tab(icon: Icon(Icons.star), text: 'Starred'), Tab(icon: Icon(Icons.settings), text: 'Settings')]), Expanded(child: TabBarView(children: [Center(child: Text('Home Page')), Center(child: Text('Starred Page')), Center(child: Text('Settings Page'))]))]))));
}
