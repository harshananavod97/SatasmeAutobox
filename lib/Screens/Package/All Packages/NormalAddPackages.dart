import 'package:flutter/material.dart';
import 'package:newautobox/Provider/AddPackageController.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Package/Widgets/PackageCard.dart';
import 'package:newautobox/Utils/Scaffholdmessanger.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:provider/provider.dart';

class NormalAddPackage extends StatefulWidget {
  const NormalAddPackage({super.key});

  @override
  State<NormalAddPackage> createState() => _NormalAddPackageState();
}

class _NormalAddPackageState extends State<NormalAddPackage> {
  @override
  void initState() {
    super.initState();
    // Uncomment and modify this if you need to fetch data on init
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<Addpackagecontroller>(context, listen: false)
    //       .fetchNormalAds(context);
    // });
  }

  void _handleActivation(BuildContext context, dynamic package) {
    try {
      final delarController =
          Provider.of<DelarController>(context, listen: false);
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);

      if (delarController.delarData?.stat == 'ok') {
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

        // PaymentHandler paymentHandler = PaymentHandler(context);
        // paymentHandler.startOneTimePayment(
        //   istop: false,
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
      } else {
        showSnackBar(
          'Please Create Dealer profile',
          context,
          showAction: false,
          duration: const Duration(seconds: 3),
        );
      }
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
        title: const Text('Buy Ads Packages'),
      ),
      body: Consumer<Addpackagecontroller>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressContainer(),
            );
          }

          if (controller.NormalAdData == null) {
            return const Center(
              child: Text('No data available!'),
            );
          }

          final normalAdData = controller.NormalAdData!;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: normalAdData.packages.length,
            itemBuilder: (context, index) {
              final package = normalAdData.packages[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: PackageCard(
                  key: ValueKey(package.id),
                  buttonText: index == 0 ? 'Activate' : 'Buy Now',
                  adsAmount: package.packageAdCount,
                  adsDuration: package.packageDuration.toString(),
                  imageCount: package.imageCount,
                  onActivate: () => _handleActivation(context, package),
                  packageName: package.packageName,
                  packagePrice: package.packagePrice.toString(),
                  topAds: package.topupCount,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
