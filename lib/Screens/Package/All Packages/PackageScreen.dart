import 'package:flutter/material.dart';
import 'package:newautobox/Provider/AddPackageController.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Package/All%20Packages/NormalAddPackages.dart';
import 'package:newautobox/Screens/Package/All%20Packages/TopAddPacakage.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/Const/FontStyle.dart';
import 'package:newautobox/Widgets/CustomRoundButton.dart';
import 'package:provider/provider.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  @override
  void initState() {
    setInit();
    // TODO: implement initState
    super.initState();
  }

  Future<void> setInit() async {
    Future.microtask(() async {
      final delarcontrller =
          Provider.of<DelarController>(context, listen: false);
      final usercontroller =
          Provider.of<Userdatacontroller>(context, listen: false);
      Provider.of<Userdatacontroller>(context, listen: false);

      await delarcontrller.fetchDelarData(
        usercontroller.userData!.user.id,
        context,
      );
      final addcontroller =
          Provider.of<Addpackagecontroller>(context, listen: false);
      await addcontroller.fetchNormalAds(context);
      await addcontroller.fetchTopAds(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopAddpackage(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Top Ad Package',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeights.bold,
                              decorationColor: Theme.of(context).primaryColor,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Package Not Active',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeights.regular,
                          decorationColor: Theme.of(context).primaryColor,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomRoundedButton(
                        widthPercentage: 0.55,
                        backgroundColor: AppColors.PRIMARY_COLOR,
                        buttonTitle: 'Buy Package',
                        radius: 10,
                        showBorder: false,
                        height: 50,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TopAddpackage(),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NormalAddPackage(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Ad Package',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeights.bold,
                              decorationColor: Theme.of(context).primaryColor,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Package Not Active',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeights.regular,
                          decorationColor: Theme.of(context).primaryColor,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomRoundedButton(
                        widthPercentage: 0.55,
                        backgroundColor: AppColors.PRIMARY_COLOR,
                        buttonTitle: 'Buy Package',
                        radius: 10,
                        showBorder: false,
                        height: 50,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NormalAddPackage(),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
