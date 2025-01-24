import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newautobox/Model/myAddPackageController.dart';
import 'package:newautobox/Provider/AddPackageController.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/GarageDataController.dart';
import 'package:newautobox/Provider/GetVehicleControllers.dart';
import 'package:newautobox/Provider/InqueryController.dart';
import 'package:newautobox/Provider/LatestAddConteroller.dart';
import 'package:newautobox/Provider/LocationController.dart';
import 'package:newautobox/Provider/MyAdController.dart';
import 'package:newautobox/Provider/MyGragesController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Provider/allAdsController.dart';
import 'package:newautobox/Screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Userdatacontroller()),
        ChangeNotifierProvider(create: (_) => Addpackagecontroller()),
        ChangeNotifierProvider(create: (_) => GrageDataController()),
        ChangeNotifierProvider(create: (_) => DelarController()),
        ChangeNotifierProvider(create: (_) => Getvehiclecontrollers()),
        ChangeNotifierProvider(create: (_) => Locationcontroller()),
        ChangeNotifierProvider(create: (_) => AllAdsController()),
        ChangeNotifierProvider(create: (_) => MyGragesDataController()),
        ChangeNotifierProvider(create: (_) => InqueryController()),
        ChangeNotifierProvider(create: (_) => MyAdController()),
        ChangeNotifierProvider(create: (_) => LatestAdsController()),
        ChangeNotifierProvider(create: (_) => MyAdsPackagesController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AutoBox',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
            ScreenUtilInit(designSize: Size(375, 812), child: SplashScreen()));
  }
}
