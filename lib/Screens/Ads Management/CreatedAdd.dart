import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/MyAdController.dart';
import 'package:newautobox/Provider/MyGragesController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/Ad_Negotiable_State.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/Ad_Vehicle_Brand_Doop_Down.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/Ad_Vehicle_Drop_down.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/Ad_Vehicle_Model_Drop_Down.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/Add_Condition.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/Add_Type.dart';
import 'package:newautobox/Screens/Grage%20Management/Widgets/My_City_Drop_Down.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/DefultTextFiled.dart';
import 'package:newautobox/Utils/ImageSourceDialog.dart';
import 'package:newautobox/Utils/Scaffholdmessanger.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/CommonCachedNetworkImage.dart';
import 'package:newautobox/Widgets/CustomRoundButton.dart';
import 'package:provider/provider.dart';

import '../Grage Management/Widgets/My_District_Drop_Down.dart';

class CreateAdd extends StatefulWidget {
  const CreateAdd({super.key});

  @override
  State<CreateAdd> createState() => _CreateAddState();
}

class _CreateAddState extends State<CreateAdd> {
  int userId = 0;
  bool isLoading = false;

  final AddName = TextEditingController();
  final addphonenumber = TextEditingController();
  final AddPrice = TextEditingController();
  final AddDescriptionController = TextEditingController();
  final AddCondition = TextEditingController();
  int topAdd = 0;
  int nogotiable = 0;

  late FocusNode _AddName;
  late FocusNode _addphonenumber;

  late FocusNode _adddescription;
  late FocusNode _AddPrice;

  void initState() {
    super.initState();

    setInit();
    _AddName = FocusNode();
    _addphonenumber = FocusNode();

    _adddescription = FocusNode();
    _AddPrice = FocusNode();
  }

  Future<void> setInit() async {
    Future.microtask(() async {
      setState(() async {
        final userController =
            Provider.of<Userdatacontroller>(context, listen: false);
        final delarcontrller =
            Provider.of<DelarController>(context, listen: false);

        await delarcontrller.fetchDelarData(
            userController.userData!.user.id, context);
      });
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? DelarProfileImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<MyAdController>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 16, top: 10, right: 16, bottom: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          profileImage(),
                          // if (sharedPref.getString(LOGIN_TYPE) != LoginTypeGoogle)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 100, right: 20),
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.PRIMARY_COLOR),
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return ImageSourceDialog(
                                        onCamera: () async {
                                          // Navigator.pop(context);
                                          DelarProfileImage =
                                              await ImagePicker().pickImage(
                                                  source: ImageSource.camera,
                                                  imageQuality: 100);
                                          setState(() {});
                                        },
                                        onGallery: () async {
                                          // Navigator.pop(context);
                                          DelarProfileImage =
                                              await ImagePicker().pickImage(
                                                  source: ImageSource.gallery,
                                                  imageQuality: 100);
                                          setState(() {});
                                        },
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: AddName,
                        textFieldType: TextFieldType.NAME,
                        focus: _AddName,
                        nextFocus: _adddescription,
                        decoration: inputDecoration(label: 'Add Title'),
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: AddDescriptionController,
                        textFieldType: TextFieldType.ADDRESS,
                        focus: _adddescription,
                        nextFocus: _addphonenumber,
                        decoration: inputDecoration(label: 'Add Description'),
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: addphonenumber,
                        textFieldType: TextFieldType.PHONE,
                        focus: _addphonenumber,
                        nextFocus: _AddPrice,
                        decoration: inputDecoration(label: 'Phone Number'),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        readOnly: false,
                        controller: AddPrice,
                        textFieldType: TextFieldType.PRICE,
                        focus: _AddPrice,
                        nextFocus: _AddPrice,
                        decoration: inputDecoration(label: 'Ad Price'),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      const MyDistrictDropDown(
                        District: '',
                      ),
                      const SizedBox(height: 20),
                      const MyCityDropDown(
                        city: '',
                      ),
                      const SizedBox(height: 20),
                      ConditionDropdown(
                        onChanged: (String? condition) {
                          AddCondition.text = condition ?? '';

                          print('Selected condition: $condition');
                        },
                      ),
                      const SizedBox(height: 20),
                      AdTypeDropdown(
                        onChanged: (int value) {
                          topAdd = value;

                          print('Selected value: $value');
                        },
                      ),
                      const SizedBox(height: 20),
                      NegotiableStatusDropdown(
                        onChanged: (int value) {
                          nogotiable = value;

                          print('Selected value: $value');
                        },
                      ),
                      const SizedBox(height: 10),
                      AdVehicleTypesDropDown(
                        vname: '',
                      ),
                      const SizedBox(height: 10),
                      const AdVehicleBrandDropDown(
                        brad: '',
                      ),
                      const SizedBox(height: 10),
                      const AdVehiclemodeldropdown(
                        brad: '',
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: isLoading == false
                            ? CustomRoundedButton(
                                widthPercentage: 0.55,
                                backgroundColor: AppColors.PRIMARY_COLOR,
                                buttonTitle: 'Submit',
                                radius: 10,
                                showBorder: false,
                                height: 50,
                                onTap: () async {
                                  final vehicleData =
                                      Provider.of<MyAdController>(context,
                                          listen: false);

                                  final usercontroller =
                                      Provider.of<Userdatacontroller>(context,
                                          listen: false);

                                  final gargecontroller =
                                      Provider.of<MyGragesDataController>(
                                          context,
                                          listen: false);

                                  final delarcontrller =
                                      Provider.of<DelarController>(context,
                                          listen: false);

                                  if (delarcontrller.delarData!.stat == 'ok') {
                                    if (_formKey.currentState!.validate()) {
                                      if (DelarProfileImage != null) {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        ApiService()
                                            .CreateAdd(
                                                AddName.text,
                                                gargecontroller.District,
                                                gargecontroller.City,
                                                AddDescriptionController.text,
                                                int.parse(AddPrice.text),
                                                vehicleData.Vehicleid,
                                                vehicleData.BrandID,
                                                vehicleData.ModelID,
                                                AddCondition.text,
                                                usercontroller
                                                    .userData!.user.id,
                                                topAdd,
                                                nogotiable,
                                                DelarProfileImage != null
                                                    ? File(
                                                        DelarProfileImage!.path)
                                                    : null,
                                                context)
                                            .then((_) {
                                          setState(() {
                                            isLoading = false;
                                            AddName.clear();
                                            AddDescriptionController.clear();
                                            AddPrice.clear();
                                            addphonenumber.clear();

                                            AddCondition.clear();

                                            value.fetchProducts(
                                              context,
                                              usercontroller.userData!.user.id,
                                            );
                                          });
                                        }).catchError((_) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      } else {
                                        showSnackBar(
                                          'Please add profile Image',
                                          context,
                                          showAction: false,
                                          onPressedAction: () {},
                                          duration: const Duration(seconds: 3),
                                        );
                                      }
                                    }
                                  } else {
                                    showSnackBar(
                                      'Please Create Delar profile',
                                      context,
                                      showAction: false,
                                      onPressedAction: () {},
                                      duration: Duration(seconds: 3),
                                    );
                                  }
                                },
                              )
                            : const Center(child: CircularProgressContainer()),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget profileImage() {
    if (DelarProfileImage != null) {
      return Center(
        child: Image.file(File(DelarProfileImage!.path),
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: Alignment.center),
      );
    } else {
      return Center(
        child: commonCachedNetworkImage('https://i.sstatic.net/l60Hf.png',
            fit: BoxFit.fill, height: 150, width: double.infinity),
      );
    }
  }

  InputDecoration inputDecoration({
    required String label,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isDense = false,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      border: const OutlineInputBorder(),
      isDense: isDense, // Makes the input compact if set to true
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
