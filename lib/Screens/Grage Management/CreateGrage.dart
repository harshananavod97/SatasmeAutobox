import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/MyGragesController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Grage%20Management/Widgets/My_City_Drop_Down.dart';
import 'package:newautobox/Screens/Grage%20Management/Widgets/My_District_Drop_Down.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/DefultTextFiled.dart';
import 'package:newautobox/Utils/ImageSourceDialog.dart';
import 'package:newautobox/Utils/Scaffholdmessanger.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/CommonCachedNetworkImage.dart';
import 'package:newautobox/Widgets/CustomRoundButton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateGrage extends StatefulWidget {
  const CreateGrage({super.key});

  @override
  State<CreateGrage> createState() => _CreateGrageState();
}

class _CreateGrageState extends State<CreateGrage> {
  int userId = 0;
  bool isLoading = false;

  final garageName = TextEditingController();
  final garagePhoneNumber = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final MapUrl = TextEditingController();

  late FocusNode _garageName;
  late FocusNode garagePhonenumber;
  late FocusNode _garageMapurl;
  late FocusNode _description;
  late FocusNode _address;

  void initState() {
    super.initState();
    _garageName = FocusNode();
    garagePhonenumber = FocusNode();
    _garageMapurl = FocusNode();
    _description = FocusNode();
    _address = FocusNode();

    setInit();
  }

  void initialFocusNode() {}

  Future<void> setInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.microtask(() async {
      setState(() async {
        final userController =
            Provider.of<Userdatacontroller>(context, listen: false);
        final delarcontrller =
            Provider.of<DelarController>(context, listen: false);

        // Fetch user data

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
          Consumer<MyGragesDataController>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                padding:
                    EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center(
                      //   child: Text(
                      //     'Create Garage',
                      //     style: TextStyle(
                      //       fontSize: 25,
                      //       fontWeight: FontWeights.bold,
                      //       decorationColor: Theme.of(context).primaryColor,
                      //       color: AppColors.PRIMARY_COLOR,
                      //     ),
                      //   ),
                      // ),
                      Stack(
                        children: [
                          profileImage(),
                          // if (sharedPref.getString(LOGIN_TYPE) != LoginTypeGoogle)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(top: 100, right: 20),
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
                                icon: Icon(Icons.edit,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: garageName,
                        textFieldType: TextFieldType.NAME,
                        focus: _garageName,
                        nextFocus: garagePhonenumber,
                        decoration: inputDecoration(label: 'Garage Name'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: garagePhoneNumber,
                        textFieldType: TextFieldType.PHONE,
                        focus: garagePhonenumber,
                        nextFocus: garagePhonenumber,
                        decoration: inputDecoration(label: 'Phone Number'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: MapUrl,
                        textFieldType: TextFieldType.URL,
                        focus: _garageMapurl,
                        nextFocus: _address,
                        decoration: inputDecoration(label: 'Gooogle Map Url'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: addressController,
                        textFieldType: TextFieldType.ADDRESS,
                        focus: _address,
                        nextFocus: _description,
                        decoration: inputDecoration(label: 'Address'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: descriptionController,
                        textFieldType: TextFieldType.ADDRESS,
                        focus: _description,
                        nextFocus: _description,
                        decoration: inputDecoration(label: 'Description'),
                        onTap: () {},
                      ),
                      SizedBox(height: 10),
                      MyDistrictDropDown(
                        District: '',
                      ),
                      SizedBox(height: 20),
                      MyCityDropDown(
                        city: '',
                      ),
                      SizedBox(height: 20),
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
                                  final usercontroller =
                                      Provider.of<Userdatacontroller>(context,
                                          listen: false);

                                  final delarcontrller =
                                      Provider.of<DelarController>(context,
                                          listen: false);

                                  if (delarcontrller.delarData!.stat
                                          .toString() ==
                                      'ok') {
                                    if (_formKey.currentState!.validate()) {
                                      if (DelarProfileImage != null) {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        Logger().i(value.City.toString());

                                        ApiService()
                                            .CreateGrage(
                                                usercontroller
                                                    .userData!.user.id,
                                                garageName.text,
                                                value.City,
                                                garagePhoneNumber.text,
                                                MapUrl.text,
                                                descriptionController.text,
                                                addressController.text,
                                                DelarProfileImage != null
                                                    ? File(
                                                        DelarProfileImage!.path)
                                                    : null,
                                                context)
                                            .then((_) {
                                          setState(() {
                                            isLoading = false;
                                            garageName.clear();
                                            garagePhoneNumber.clear();
                                            descriptionController.clear();
                                            addressController.clear();
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
                                          duration: Duration(seconds: 3),
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
                            : Center(child: CircularProgressContainer()),
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
      border: OutlineInputBorder(),
      isDense: isDense, // Makes the input compact if set to true
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
