import 'package:flutter/material.dart';
import 'package:newautobox/Screens/Profile/Delar/CreateDelar.dart';
import 'package:newautobox/Screens/Profile/User/ProfileScreen.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'User Profile'),
              Tab(text: 'Delar Profile'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProfileScreen(),
            CreateDelar(),
          ],
        ),
      ),
    );
  }
}
