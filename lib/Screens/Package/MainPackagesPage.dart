import 'package:flutter/material.dart';
import 'package:newautobox/Screens/Package/All%20Packages/PackageScreen.dart';
import 'package:newautobox/Screens/Package/My%20Packages/MyPackages.dart';

class MainpackagesPage extends StatelessWidget {
  const MainpackagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Packages Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Packages'),
              Tab(text: 'My Packages'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PackageScreen(),
            MyPackages(),
          ],
        ),
      ),
    );
  }
}
