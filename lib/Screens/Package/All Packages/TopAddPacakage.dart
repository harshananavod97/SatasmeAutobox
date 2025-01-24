import 'package:flutter/material.dart';
import 'package:newautobox/Provider/AddPackageController.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Package/Widgets/PackageCard.dart';

import 'package:provider/provider.dart';
import '../../../Utils/Scaffholdmessanger.dart';
import '../../../Widgets/CircleProcessContainer.dart';

class TopAddpackage extends StatefulWidget {
  const TopAddpackage({super.key});

  @override
  State<TopAddpackage> createState() => _TopAddpackageState();
}

class _TopAddpackageState extends State<TopAddpackage> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback instead of Future.delayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<Addpackagecontroller>(context, listen: false)
            .fetchTopAds(context);
      }
    });
  }

  void _handleBuyNow(BuildContext context, dynamic package) {
    try {
      final delarController =
          Provider.of<DelarController>(context, listen: false);
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);

      if (delarController.delarData?.stat != 'ok') {
        showSnackBar(
          'Please Create Dealer profile',
          context,
          showAction: false,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      final userData = userController.userData?.user;
      if (userData == null) {
        showSnackBar(
          'User data not available',
          context,
          showAction: false,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // final paymentHandler = PaymentHandler(context);
      // paymentHandler.startOneTimePayment(
      //   istop: true,
      //   packageId: package.id,
      //   userid: userData.id,
      //   amount: double.parse(package.packagePrice.toString()),
      //   orderId: package.id.toString(),
      //   items: package.packageName,
      //   firstName: userData.firstName?.toString() ?? '',
      //   lastName: userData.lastName?.toString() ?? '',
      //   email: userData.email?.toString() ?? '',
      //   phone: userData.phone?.toString() ?? '',
      //   address: '${userData.city ?? ''} ${userData.district ?? ''}',
      //   city: userData.city?.toString() ?? '',
      //   country: "Sri Lanka",
      // );
    } catch (e) {
      showSnackBar(
        'An error occurred: ${e.toString()}',
        context,
        showAction: false,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Top Ads Packages'),
      ),
      body: Consumer<Addpackagecontroller>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressContainer(),
            );
          }

          final topAdData = controller.TopAdData;
          if (topAdData == null || topAdData.packages.isEmpty) {
            return const Center(
              child: Text('No packages available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: topAdData.packages.length,
            itemBuilder: (context, index) {
              final package = topAdData.packages[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: AdPackageCard(
                  key: ValueKey(package.id),
                  onBuyNow: () => _handleBuyNow(context, package),
                  packageName: package.packageName,
                  packagePrice: package.packagePrice.toString(),
                  topAds: package.count,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
