import 'package:flutter/material.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Ads%20Management/MainAddPage.dart';
import 'package:newautobox/Screens/Grage%20Management/MainGragePage.dart';
import 'package:newautobox/Screens/Inquery%20Management/Main_Page.dart';
import 'package:newautobox/Screens/Package/MainPackagesPage.dart';
import 'package:newautobox/Screens/Profile/Main_Profile.dart';
import 'package:newautobox/Screens/SplashScreen.dart';
import 'package:newautobox/Widgets/CommonCachedNetworkImage.dart';
import 'package:newautobox/Widgets/DrawerWideget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerComponent extends StatefulWidget {
  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  void initState() {
    super.initState();
    setInit();
    // Use Future.microtask to avoid calling setState during build
  }

  Future<void> setInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.microtask(() {
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);
      userController.fetchProducts(
              prefs.getString('isUserEmail').toString(), context) ??
          '';
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Consumer<Userdatacontroller>(
            builder: (context, userController, child) {
              final userData = userController.userData;

              // if (userData == null) {
              //   return Center(
              //     child: CircularProgressContainer(),
              //   );
              // }

              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          userData!.user.profileImage.toString() == 'null'
                              ? commonCachedNetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: userData.user.profileImage != null &&
                                          userData.user.profileImage!.isNotEmpty
                                      ? commonCachedNetworkImage(
                                          'https://jobhelp.test.satasmewebdev.online/assets/myCustomThings/vehicleTypes/' +
                                              userData.user.profileImage
                                                  .toString(),
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        )
                                      : commonCachedNetworkImage(
                                          userData.user.profileImage.toString(),
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData!.user.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  userData.user.email ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, height: 20),
                    DrawerWidget(
                        title: 'Package Management',
                        iconData: Icons.gif_box,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainpackagesPage(),
                              ));
                        }),
                    Divider(thickness: 1, height: 20),
                    DrawerWidget(
                        title: 'Profile Management',
                        iconData: Icons.gif_box,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainProfile(),
                              ));
                        }),
                    Divider(thickness: 1, height: 20),
                    DrawerWidget(
                        title: 'Garage Management',
                        iconData: Icons.gif_box,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainGragePage(),
                              ));
                        }),
                    Divider(thickness: 1, height: 20),
                    DrawerWidget(
                        title: 'Ads Management',
                        iconData: Icons.add_box_sharp,
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainAddPage(),
                              ));
                        }),
                    Divider(thickness: 1, height: 20),
                    DrawerWidget(
                      title: 'Inquery Management',
                      iconData: Icons.gif_box,
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainInqueryPage(),
                            ));
                      },
                    ),
                    Divider(thickness: 1, height: 20),
                    DrawerWidget(
                        title: 'Log Out',
                        iconData: Icons.exit_to_app,
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SplashScreen(),
                              ));

                          prefs.clear();
                        }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
