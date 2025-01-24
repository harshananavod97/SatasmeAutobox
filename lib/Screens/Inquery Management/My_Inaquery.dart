import 'package:flutter/material.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Model/InqueryModel.dart';
import 'package:newautobox/Provider/InqueryController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Inquery%20Management/Widgets/InqueryView.dart';
import 'package:newautobox/Screens/Inquery%20Management/Widgets/MyInqueryCard.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/DrawerWideget.dart';
import 'package:newautobox/Widgets/no_data.dart';
import 'package:provider/provider.dart';

class MyInquery extends StatefulWidget {
  const MyInquery({super.key});

  @override
  State<MyInquery> createState() => _MyInqueryState();
}

class _MyInqueryState extends State<MyInquery> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);
      final inquerycontroller =
          Provider.of<InqueryController>(context, listen: false);
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
            child: NearGrageList(),
          ),
        ],
      ),
    );
  }

  Widget NearGrageList() {
    return Builder(
      builder: (context) {
        final provider = Provider.of<InqueryController>(context,
            listen: true); // Changed to listen: true

        return StreamBuilder<InqueryModel?>(
          stream: provider.dataStream,
          builder: (context, snapshot) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressContainer());
            }

            if (!snapshot.hasData ||
                snapshot.data?.inq == null ||
                snapshot.data!.inq!.data.isEmpty) {
              return const NoDataAvailable(); // Added const
            }

            final data = snapshot.data!;

            return ListView.builder(
              shrinkWrap: true, // Added shrinkWrap
              scrollDirection: Axis.vertical,
              itemCount: data.inq!.data.length,
              itemBuilder: (context, index) {
                final inquery = data.inq!.data[index]; // Extract garage data
                return inkWellWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InqueryView(
                                phoneNumber: inquery.phone,
                                additionalInformation:
                                    inquery.additionalInformation,
                                image: inquery.image,
                                title: inquery.title,
                                onBackPressed: () {
                                  Navigator.pop(context);
                                },
                              )),
                    );
                  },
                  child: MyInqueryCard(
                    description: inquery.additionalInformation,
                    phoneNumber: inquery.phone,
                    title: inquery.title,
                    imageUrl: inquery.image,
                    onDelete: () async {
                      final userController = Provider.of<Userdatacontroller>(
                          context,
                          listen: false);
                      await ApiService().deleteInquery(inquery.id, context);

                      provider.fetchProducts(
                          context, userController.userData!.user.id);
                    },
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
