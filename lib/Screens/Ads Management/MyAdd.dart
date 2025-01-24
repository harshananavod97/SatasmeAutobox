import 'package:flutter/material.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/MyAdModel.dart';
import 'package:newautobox/Provider/MyAdController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Ads%20Management/My_Add_Edit.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/My_Add_Card.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/no_data.dart';
import 'package:provider/provider.dart';

class MyAddPage extends StatefulWidget {
  const MyAddPage({super.key});

  @override
  State<MyAddPage> createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);
      final inquerycontroller =
          Provider.of<MyAdController>(context, listen: false);
      await inquerycontroller.fetchProducts(
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
            child: myAdWideget(),
          ),
        ],
      ),
    );
  }

  Widget myAdWideget() {
    return Builder(
      builder: (context) {
        final provider = Provider.of<MyAdController>(context,
            listen: true); // Changed to listen: true

        return StreamBuilder<MyAdModel?>(
          stream: provider.dataStream,
          builder: (context, snapshot) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressContainer());
            }

            if (!snapshot.hasData ||
                snapshot.data?.ad == null ||
                snapshot.data!.ad!.isEmpty) {
              return const NoDataAvailable(); // Added const
            }

            final data = snapshot.data!;

            return ListView.builder(
              shrinkWrap: true, // Added shrinkWrap
              scrollDirection: Axis.vertical,
              itemCount: data.ad!.length,
              itemBuilder: (context, index) {
                final inquery = data.ad![index]; // Extract garage data
                return MyAddCard(
                  imageUrl: inquery.name,
                  title: inquery.adTitle,
                  description: inquery.adDescription,
                  price: double.parse(inquery.adPrice.toString()),
                  location: inquery.adDistrict,
                  phoneNumber: inquery.adNumber.toString(),
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('disable Advertisement'),
                          content: const Text(
                              'Are you sure you want to  disable advertisement?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Yes'),
                              onPressed: () {
                                ApiService().disableAd(inquery.id, context);

                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onEdit: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyAddEdit(
                            url: inquery.name,
                            price: inquery.adPrice.toString(),
                            AdCondition: inquery.adsCondition,
                            negotiable: inquery.negotiable,
                            addid: inquery.id,
                            addName: inquery.adTitle,
                            addDescription: inquery.adDescription,
                          ),
                        ));
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
