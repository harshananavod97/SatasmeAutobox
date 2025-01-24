import 'package:flutter/material.dart';
import 'package:newautobox/Screens/Grage%20Management/CreateGrage.dart';
import 'package:newautobox/Screens/Grage%20Management/MyGrages.dart';

class MainGragePage extends StatelessWidget {
  const MainGragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Garage Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Create Garage'),
              Tab(text: 'My Garages'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CreateGrage(),
            MyGrage(),
          ],
        ),
      ),
    );
  }
}
