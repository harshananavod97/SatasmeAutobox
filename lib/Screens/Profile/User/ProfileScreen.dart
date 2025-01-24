import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Provider/GarageDataController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Profile/Widgets/city_drop_down_menu.dart';
import 'package:newautobox/Screens/Profile/Widgets/distrct_drop_down_menu.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/DefultTextFiled.dart';
import 'package:newautobox/Utils/ImageSourceDialog.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/CommonCachedNetworkImage.dart';
import 'package:newautobox/Widgets/CustomRoundButton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String finalCity = '';
  String finalDistrict = '';
  bool isLoading = false;
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final userId = TextEditingController();

  late FocusNode _emailfocusNode;

  late FocusNode _firstnamefocusNode;
  late FocusNode _lastnamefocusNode;
  late FocusNode _phonenumberfocusNode;
  late FocusNode _districtfocusNode;
  late FocusNode _cityfocusNode;

  int CityId = 1;
  int DistrctId = 1;

  void initState() {
    super.initState();
    _emailfocusNode = FocusNode();
    _firstnamefocusNode = FocusNode();
    _lastnamefocusNode = FocusNode();
    _phonenumberfocusNode = FocusNode();
    _districtfocusNode = FocusNode();
    _cityfocusNode = FocusNode();

    setInit();
  }

  void initialFocusNode() {}

  Future<void> setInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.microtask(() async {
      final userController =
          Provider.of<Userdatacontroller>(context, listen: false);

      // Fetch user data
      await userController.fetchProducts(
        prefs.getString('isUserEmail').toString(),
        context,
      );

      Logger().i(userController.userData!.user.phone);

      // Assign fetched data to TextEditingControllers
      setState(() {
        emailController.text = userController.userData!.user.email ?? "";
        firstnameController.text =
            userController.userData!.user.firstName ?? "";
        lastnameController.text = userController.userData!.user.lastName ?? "";

        userController.userData!.user.phone.toString() != 'null'
            ? phonenumberController.text =
                userController.userData!.user.phone.toString() ?? ""
            : phonenumberController.text = "";
        userId.text = userController.userData!.user.id.toString();
        districtController.text = userController.District.toString();
        cityController.text = userController.City.toString() ?? "";
        CityId = userController.Cityid;
        DistrctId = userController.DistrictID;
        finalCity = userController.userData!.user.city ?? "";
        finalDistrict = userController.userData!.user.district ?? '';

        Logger().e(userController.userData!.user.profileImage.toString() +
            "jjjjj" +
            DistrctId.toString());
      });
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageProfile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Consumer<Userdatacontroller>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  padding:
                      EdgeInsets.only(left: 16, top: 30, right: 16, bottom: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Center(
                        //   child: Text(
                        //     'Edit Profile',
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
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(top: 60, left: 80),
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
                                            imageProfile = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera,
                                                    imageQuality: 100);
                                            // Navigator.pop(context);
                                            setState(() {});
                                          },
                                          onGallery: () async {
                                            // Navigator.pop(context);
                                            imageProfile = await ImagePicker()
                                                .pickImage(
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
                          controller: emailController,
                          textFieldType: TextFieldType.EMAIL,
                          focus: _emailfocusNode,
                          nextFocus: _firstnamefocusNode,
                          decoration: inputDecoration(label: 'Email'),
                          onTap: () {},
                        ),
                        SizedBox(height: 20),
                        AppTextField(
                          readOnly: false,
                          controller: firstnameController,
                          textFieldType: TextFieldType.NAME,
                          focus: _firstnamefocusNode,
                          nextFocus: _lastnamefocusNode,
                          decoration: inputDecoration(label: 'First Name'),
                          onTap: () {},
                        ),
                        SizedBox(height: 20),
                        AppTextField(
                          readOnly: false,
                          controller: lastnameController,
                          textFieldType: TextFieldType.NAME,
                          focus: _lastnamefocusNode,
                          nextFocus: _phonenumberfocusNode,
                          decoration: inputDecoration(label: 'Last Name'),
                          onTap: () {},
                        ),
                        SizedBox(height: 20),
                        AppTextField(
                          readOnly: false,
                          controller: phonenumberController,
                          textFieldType: TextFieldType.PHONE,
                          focus: _phonenumberfocusNode,
                          nextFocus: _districtfocusNode,
                          decoration: inputDecoration(label: 'Phone Number'),
                          onTap: () {},
                        ),
                        SizedBox(height: 10),
                        DistrictDropDown(
                          District: finalDistrict,
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 5,
                        ),
                        CityDroDown(
                          city: finalCity,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: isLoading == false
                              ? CustomRoundedButton(
                                  widthPercentage: 0.55,
                                  backgroundColor: AppColors.PRIMARY_COLOR,
                                  buttonTitle: 'Update Profile',
                                  radius: 10,
                                  showBorder: false,
                                  height: 50,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final userController =
                                          Provider.of<Userdatacontroller>(
                                              context,
                                              listen: false);

                                      ApiService()
                                          .UserProfileUpdate(
                                              emailController.text ?? '',
                                              firstnameController.text ?? '',
                                              lastnameController.text ?? '',
                                              phonenumberController.text ?? '',
                                              userController.District ?? '',
                                              userController.City ?? '',
                                              context)
                                          .then((_) {
                                        setState(() {
                                          isLoading =
                                              false; // Reset the loading state
                                        });
                                      }).catchError((_) {
                                        setState(() {
                                          isLoading =
                                              false; // Reset the loading state on error
                                        });
                                      });
                                      final garagecontroller =
                                          Provider.of<GrageDataController>(
                                              context,
                                              listen: false);

                                      garagecontroller.fetchProducts(
                                          context, userController.City);

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'IscITY',
                                          Provider.of<Userdatacontroller>(
                                                  context,
                                                  listen: false)
                                              .City);

                                      imageProfile!.path == null &&
                                              imageProfile!.path.isEmpty
                                          ? () {}
                                          : ApiService()
                                              .UserProfileImageUpload(
                                              userId.text,
                                              imageProfile != null
                                                  ? File(imageProfile!.path)
                                                  : null,
                                              context,
                                            )
                                              .then((_) {
                                              setState(() async {
                                                await userController
                                                    .fetchProducts(
                                                  prefs
                                                      .getString('isUserEmail')
                                                      .toString(),
                                                  context,
                                                );

                                                isLoading =
                                                    false; // Reset the loading state
                                              });
                                            }).catchError((_) {
                                              setState(() {
                                                isLoading =
                                                    false; // Reset the loading state on error
                                              });
                                            });

                                      await userController.fetchProducts(
                                        emailController.text,
                                        context,
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
      ),
    );
  }

  Widget profileImage() {
    return Consumer<Userdatacontroller>(
      builder: (context, model, child) {
        // https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png
        if (model.userData!.user.profileImage.toString() == 'null' &&
            imageProfile == null) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: commonCachedNetworkImage(
                  'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100),
            ),
          );
        }

        if (imageProfile != null) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.file(File(imageProfile!.path),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  alignment: Alignment.center),
            ),
          );
        } else {
          // sharedPref.getString(USER_PROFILE_PHOTO)!=null && sharedPref.getString(USER_PROFILE_PHOTO)!.isNotEmpty

          if (model.userData!.user.profileImage != null &&
              model.userData!.user.profileImage!.isNotEmpty) {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: commonCachedNetworkImage(
                    'https://jobhelp.test.satasmewebdev.online/assets/myCustomThings/vehicleTypes/' +
                        model.userData!.user.profileImage.toString(),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100),
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(left: 4, bottom: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: commonCachedNetworkImage(
                      ' https://jobhelp.test.satasmewebdev.online/assets/myCustomThings/vehicleTypes/' +
                          model.userData!.user.profileImage.toString(),
                      height: 90,
                      width: 90),
                ),
              ),
            );
          }
        }
      },
    );
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
