import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/GarageDataController.dart';
import 'package:newautobox/Provider/GetVehicleControllers.dart';
import 'package:newautobox/Provider/LatestAddConteroller.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Provider/allAdsController.dart';
import 'package:newautobox/Screens/Ads%20Management/MainAddPage.dart';
import 'package:newautobox/Screens/Grage%20Management/MainGragePage.dart';
import 'package:newautobox/Screens/Home/HomeScreens.dart';
import 'package:newautobox/Screens/Profile/Main_Profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  String email;
  DashboardScreen({super.key, required this.email});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    MainProfile(),
    MainAddPage(),
    MainGragePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);
      userController.fetchProducts(
        prefs.getString('isUserEmail').toString(),
        context,
      );
      final garagecontroller =
          Provider.of<GrageDataController>(context, listen: false);

      garagecontroller.fetchProducts(
          context, userController.userData!.user.city.toString());

      final vehicledata =
          Provider.of<Getvehiclecontrollers>(context, listen: false);
      final Addpackagecontroller =
          Provider.of<AllAdsController>(context, listen: false);
      final delarcontrller =
          Provider.of<DelarController>(context, listen: false);

      // Fetch user data
      await Addpackagecontroller.fetchProducts(context, vehicledata.Vehicleid,
          vehicledata.BrandID, vehicledata.ModelID);

      await delarcontrller.fetchDelarData(
          userController.userData!.user.id, context);

      final latestAdsController =
          Provider.of<LatestAdsController>(context, listen: false);
      latestAdsController.fetchProducts(context);

      // Fetch user data
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Do you want to exit from this application ? "),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // return true;
                },
                child: Text("No"),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                  // return true;
                },
                child: Text("Yes"),
              ),
            ],
          ),
        );

        return false;
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white, // Color of the selected item
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.add_box),
              label: 'My Ads',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.store),
              label: 'My Garage',
            ),
          ],
        ),
      ),
    );
  }
}
