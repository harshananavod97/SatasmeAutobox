import 'package:flutter/material.dart';
import 'package:newautobox/Screens/Ads%20Management/CreatedAdd.dart';
import 'package:newautobox/Screens/Ads%20Management/MyAdd.dart';

class MainAddPage extends StatelessWidget {
  const MainAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ads Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Create ADs'),
              Tab(text: 'My Ads'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CreateAdd(),
            MyAddPage(),
          ],
        ),
      ),
    );
  }
}
