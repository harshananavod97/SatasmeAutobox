import 'package:flutter/material.dart';
import 'package:newautobox/Screens/Inquery%20Management/Create_Inquery.dart';
import 'package:newautobox/Screens/Inquery%20Management/My_Inaquery.dart';

class MainInqueryPage extends StatelessWidget {
  const MainInqueryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inquery Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Create Inquery'),
              Tab(text: 'My Inquerys'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CreateInquery(),
            MyInquery(),
          ],
        ),
      ),
    );
  }
}
