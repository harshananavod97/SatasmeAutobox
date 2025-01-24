import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Model/GetGrageData.dart';
import 'package:newautobox/Provider/GarageDataController.dart';
import 'package:newautobox/Provider/GetVehicleControllers.dart';
import 'package:newautobox/Provider/LatestAddConteroller.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Provider/allAdsController.dart';
import 'package:newautobox/Screens/Home/DrawerComponent.dart';
import 'package:newautobox/Screens/Home/Widgets/GarageComponent.dart';
import 'package:newautobox/Screens/Home/Widgets/GrageviewDeatils.dart';
import 'package:newautobox/Screens/Home/Widgets/LatetsAds.dart';
import 'package:newautobox/Screens/Home/Widgets/MainSponserAds.dart';
import 'package:newautobox/Screens/Home/Widgets/No_Near_Grage_Component.dart';
import 'package:newautobox/Screens/Home/Widgets/Vechile_Select_Drop_Down_Menu.dart';
import 'package:newautobox/Screens/Home/Widgets/Vehicle_Brand_Drop_Down_Menu.dart';
import 'package:newautobox/Screens/Home/Widgets/Vehicle_Model_Drop_Down_Menu.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/Const/FontStyle.dart';
import 'package:newautobox/Widgets/DrawerWideget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widgets/NormalAds.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userEmail = prefs.getString('isUserEmail');

      if (userEmail == null) {
        Logger().e("User email not found in SharedPreferences");
        setState(() => _isLoading = false);
        return;
      }

      // Get user controller and fetch user data
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);
      await userController.fetchProducts(userEmail, context);

      if (userController.userData == null) {
        Logger().e("User data is null after fetching");
        setState(() => _isLoading = false);
        return;
      }

      // Get garage controller and fetch garage data
      final garageController =
          Provider.of<GrageDataController>(context, listen: false);
      await garageController.fetchProducts(
          context, userController.userData?.user.city ?? '');

      // Get vehicle and ads controllers
      final vehicleData =
          Provider.of<Getvehiclecontrollers>(context, listen: false);
      final adsController =
          Provider.of<AllAdsController>(context, listen: false);

      // Fetch ads data
      await adsController.fetchProducts(
        context,
        vehicleData.Vehicleid,
        vehicleData.BrandID,
        vehicleData.ModelID,
      );

      final latestAdsController =
          Provider.of<LatestAdsController>(context, listen: false);
      latestAdsController.fetchProducts(context);

      setState(() => _isLoading = false);
    } catch (e, stackTrace) {
      Logger().e("Error initializing data: $e\n$stackTrace");
      setState(() => _isLoading = false);
    }
  }

  final searchController = TextEditingController();
  final modelsearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: AppColors.PRIMARY_COLOR),
                  ),
                  style: TextStyle(color: AppColors.PRIMARY_COLOR),
                  onChanged: (value) {
                    // Handle search text changes here
                    print("Searching for: $value");
                  },
                  onSubmitted: (value) {
                    final adsController =
                        Provider.of<AllAdsController>(context, listen: false);

                    adsController.fetchSearchAds(context, value.toString());
                    Logger().i('Submitted');
                  },
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'AUTOBOX',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeights.bold,
                      decorationColor: Theme.of(context).primaryColor,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ),
          actions: [
            IconButton(
              icon: Icon(
                _isSearching ? Icons.close : Icons.search,
                color: AppColors.PRIMARY_COLOR,
              ),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                });
              },
            ),
          ],
        ),
        drawer: DrawerComponent(),
        body: SingleChildScrollView(
          child: FeedScreen(context),
        ));
  }

  Widget FeedScreen(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          VehicleTypesDropDown(),
          VehicleBrandDropDown(
            brad: '',
          ),
          Vehiclemodeldropdown(
            brad: '',
          ),

          SizedBox(height: size.height * .02),
          // Center(child: FilterSvcreen()),
          SizedBox(height: size.height * .02),
          MainTitle(),
          SizedBox(height: size.height * .02),

          MainSponserAds(),
          SizedBox(height: size.height * .02),
          // TitleWidget('Search Auto Parts'),
          // SizedBox(height: size.height * .02),
          // SearchAutoParts(),
          SizedBox(height: size.height * .02),
          TitleWidget('Featured Auto Parts and Accessories'),
          SizedBox(height: size.height * .02),

          // FeactyureAutoParts(),
          NormalAds(),
          SizedBox(height: size.height * .02),
          // TitleWidget('Latest Promotion'),
          // SizedBox(height: size.height * .02),

          // SubAds(),
          SizedBox(height: size.height * .02),
          TitleWidget('Latest Auto Parts'),
          SizedBox(height: size.height * .02),

          LatestAds(),
          SizedBox(height: size.height * .02),
          TitleWidget('Nearby  Garage'),
          SizedBox(height: size.height * .02),

          LayoutBuilder(
            builder: (context, constraints) {
              final orientation = MediaQuery.of(context).orientation;
              final size = MediaQuery.of(context).size;

              return Container(
                height: orientation == Orientation.portrait
                    ? size.height * 0.50
                    : size.height * 0.90,
                width: size.width,
                child: NearGrageList(),
              );
            },
          ),
          SizedBox(height: size.height * .05),
        ],
      ),
    );
  }

  Widget MainTitle() {
    return const Column(
      children: [
        Text(
          'The Largest Auto Parts Market Place In Sri Lanka ',
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
            fontSize: 24,
            fontWeight: FontWeights.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Lorem ipsum dolor sit amet consectetur. Commodo neque blandit elementum diam tristique.',
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
            fontSize: 15,
            fontWeight: FontWeights.regular,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget FilterSvcreen() {
    return Container(
      color: const Color(0xff1E5C40),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Search By Filters',
          style: TextStyle(
            color: AppColors.Kwhite,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget TitleWidget(String title) {
    final size = MediaQuery.of(context).size;
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.PRIMARY_COLOR,
        fontSize: 18,
        fontWeight: FontWeights.semiBold,
      ),
    );
  }

  Widget SearchAutoParts() {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.20,
      width: size.width,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Set scroll direction to horizontal
        itemCount: 10, // Number of items in the list
        itemBuilder: (context, index) {
          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 8), // Add some spacing
            width: size.height * 0.25, // Width for each item
            color: Colors.blue, // Background color for items
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget SubAds() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .25,
      width: size.width,
      color: Colors.red,
    );
  }

  Widget NearGrageList() {
    return Builder(
      builder: (context) {
        final provider =
            Provider.of<GrageDataController>(context, listen: false);

        return StreamBuilder<GetGrageData?>(
          stream: provider.dataStream,
          builder: (context, snapshot) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData ||
                snapshot.data?.garages == null ||
                snapshot.data!.garages!.data.isEmpty) {
              return NonearGrage();
            }

            final data = snapshot.data!;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.garages!.data.length,
              itemBuilder: (context, index) {
                return inkWellWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GrageViewCard(
                          imageUrl: data.garages!.data[index].image,
                          location: data.garages!.data[index].address,
                          phoneNumber: data.garages!.data[index].number,
                          title: data.garages!.data[index].name,
                          onCallPressed: () {},
                          onDirectionsPressed: () {},
                          description: data.garages!.data[index].name,
                        ),
                      ),
                    );
                  },
                  child: GarageComponent(
                    image: data.garages!.data[index].image,
                    city: data.garages!.data[index].city,
                    name: data.garages!.data[index].name,
                    number: data.garages!.data[index].number,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
