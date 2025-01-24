import 'package:flutter/material.dart';
import 'package:newautobox/Model/MyAddPackages.dart';
import 'package:newautobox/Model/myAddPackageController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Package/Widgets/PackageCard.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/no_data.dart';
import 'package:provider/provider.dart';

class MyPackages extends StatefulWidget {
  const MyPackages({super.key});

  @override
  State<MyPackages> createState() => _MyPackagesState();
}

class _MyPackagesState extends State<MyPackages> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);
      final packageController =
          Provider.of<MyAdsPackagesController>(context, listen: false);
      await packageController.fetchProducts(
          context, userController.userData!.user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: MyPackagesWidget(),
          ),
        ],
      ),
    );
  }

  Widget MyPackagesWidget() {
    return Builder(
      builder: (context) {
        final provider = Provider.of<MyAdsPackagesController>(context,
            listen: true); // Changed to listen: true

        return StreamBuilder<MyAddPackagesModel?>(
          stream: provider.dataStream,
          builder: (context, snapshot) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressContainer());
            }

            if (!snapshot.hasData ||
                snapshot.data?.mypack == null ||
                snapshot.data!.mypack.packageName == '') {
              return const NoDataAvailable(); // Added const
            }

            final data = snapshot.data!;

            return ListView.builder(
              shrinkWrap: true, // Added shrinkWrap
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, index) {
                final package = data.mypack; // Extract package data
                return MyPackageCard(
                  buttonText: 'Actived',
                  imageCount: package.imageCount,
                  adsDuration: package.packageExpireDate.toString(),
                  packageName: package.packageName,
                  adsAmount: package.availableAdCount,
                  topAds: package.availableTopCount,
                  onActivate: () {},
                );
              },
            );
          },
        );
      },
    );
  }
}
