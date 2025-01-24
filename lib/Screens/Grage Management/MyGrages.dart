import 'package:flutter/material.dart';
import 'package:newautobox/Model/MygargesModel.dart';
import 'package:newautobox/Provider/MyGragesController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Grage%20Management/Widgets/MyGarageCard.dart';
import 'package:newautobox/Screens/Home/Widgets/GrageviewDeatils.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/no_data.dart';
import 'package:provider/provider.dart';

import '../../Widgets/DrawerWideget.dart';

class MyGrage extends StatefulWidget {
  const MyGrage({super.key});

  @override
  State<MyGrage> createState() => _MyGrageState();
}

class _MyGrageState extends State<MyGrage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);
      final garageController =
          Provider.of<MyGragesDataController>(context, listen: false);
      await garageController.fetchProducts(
          context, userController.userData!.user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            // Wrap with Expanded
            child: NearGrageList(),
          ),
        ],
      ),
    );
  }

  Widget NearGrageList() {
    return Builder(
      builder: (context) {
        final provider = Provider.of<MyGragesDataController>(context,
            listen: true); // Changed to listen: true

        return StreamBuilder<MyGrages?>(
          stream: provider.dataStream,
          builder: (context, snapshot) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressContainer());
            }

            if (!snapshot.hasData ||
                snapshot.data?.garages == null ||
                snapshot.data!.garages!.data.isEmpty) {
              return const NoDataAvailable(); // Added const
            }

            final data = snapshot.data!;

            return ListView.builder(
              shrinkWrap: true, // Added shrinkWrap
              scrollDirection: Axis.vertical,
              itemCount: data.garages!.data.length,
              itemBuilder: (context, index) {
                final garage = data.garages!.data[index]; // Extract garage data
                return inkWellWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GrageViewCard(
                          imageUrl: garage.image,
                          location: garage.address,
                          phoneNumber: garage.number,
                          title: garage.name,
                          onCallPressed: () {},
                          onDirectionsPressed: () {},
                          description: garage.name,
                        ),
                      ),
                    );
                  },
                  child: MyGrageCard(
                    imageUrl: garage.image,
                    description: garage.name,
                    location: garage.city,
                    phoneNumber: garage.number,
                    title: garage.name,
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
