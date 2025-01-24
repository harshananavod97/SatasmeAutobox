import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/DefultTextFiled.dart';
import 'package:newautobox/Utils/ImageSourceDialog.dart';
import 'package:newautobox/Utils/Scaffholdmessanger.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/CommonCachedNetworkImage.dart';
import 'package:newautobox/Widgets/CustomRoundButton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateDelar extends StatefulWidget {
  const CreateDelar({super.key});

  @override
  State<CreateDelar> createState() => _CreateDelarState();
}

class _CreateDelarState extends State<CreateDelar> {
  int userId = 0;
  bool isLoading = false;
  bool isLoadingss = false;
  bool isLoadings = false;
  final companynameController = TextEditingController();
  final addressController = TextEditingController();
  final googleUrl = TextEditingController();

  late FocusNode _companyfocusnode;
  late FocusNode _adderssfocusnode;
  late FocusNode _googleurlfocusnode;

  void initState() {
    super.initState();
    _companyfocusnode = FocusNode();
    _adderssfocusnode = FocusNode();
    _googleurlfocusnode = FocusNode();

    setInit();
  }

  void initialFocusNode() {}

  Future<void> setInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.microtask(() async {
      final usercontroller =
          Provider.of<Userdatacontroller>(context, listen: false);
      final delarcontrller =
          Provider.of<DelarController>(context, listen: false);

      await delarcontrller.fetchDelarData(
        usercontroller.userData!.user.id,
        context,
      );

      setState(() {
        companynameController.text =
            delarcontrller.delarData!.companyName.toString();
        addressController.text = delarcontrller.delarData!.address.toString();
        googleUrl.text = delarcontrller.delarData!.googleLocation.toString();
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
          Consumer<DelarController>(
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
                      //     'Beacome Delar',
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
                        controller: companynameController,
                        textFieldType: TextFieldType.NAME,
                        focus: _companyfocusnode,
                        nextFocus: _adderssfocusnode,
                        decoration: inputDecoration(label: 'Company Name'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: addressController,
                        textFieldType: TextFieldType.ADDRESS,
                        focus: _adderssfocusnode,
                        nextFocus: _adderssfocusnode,
                        decoration: inputDecoration(label: 'Company Address'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: googleUrl,
                        textFieldType: TextFieldType.URL,
                        focus: _googleurlfocusnode,
                        nextFocus: _googleurlfocusnode,
                        decoration:
                            inputDecoration(label: 'gooogle location url'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: isLoading == false ||
                                isLoadings == false ||
                                isLoadings == false
                            ? CustomRoundedButton(
                                widthPercentage: 0.55,
                                backgroundColor: AppColors.PRIMARY_COLOR,
                                buttonTitle: 'Update Profile',
                                radius: 10,
                                showBorder: false,
                                height: 50,
                                onTap: () async {
                                  final usercontroller =
                                      Provider.of<Userdatacontroller>(context,
                                          listen: false);

                                  if (usercontroller.userData!.user.phone
                                          .toString() !=
                                      'null') {
                                    if (_formKey.currentState!.validate()) {
                                      if (value
                                          .delarData!.companyName.isEmpty) {
                                        setState(() {
                                          isLoadingss = true;
                                        });

                                        if (DelarProfileImage != null) {
                                          ApiService()
                                              .CreateDelar(
                                                  usercontroller
                                                      .userData!.user.id
                                                      .toString(),
                                                  companynameController.text,
                                                  addressController.text,
                                                  googleUrl.text,
                                                  DelarProfileImage != null
                                                      ? File(DelarProfileImage!
                                                          .path)
                                                      : null,
                                                  context)
                                              .then((_) async {
                                            await value.fetchDelarData(
                                              usercontroller.userData!.user.id,
                                              context,
                                            );
                                            setState(() {
                                              isLoadingss = false;
                                            });
                                          }).catchError((_) {
                                            setState(() {
                                              isLoadingss = false;
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

                                        await value.fetchDelarData(
                                            usercontroller.userData!.user.id,
                                            context);
                                      } else {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        ApiService()
                                            .UpdateDelar(
                                                usercontroller.userData!.user.id
                                                    .toString(),
                                                companynameController.text,
                                                addressController.text,
                                                googleUrl.text,
                                                context)
                                            .then((_) async {
                                          await value.fetchDelarData(
                                            usercontroller.userData!.user.id,
                                            context,
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }).catchError((_) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });

                                        setState(() {
                                          isLoadings = true;
                                        });

                                        ApiService()
                                            .DelarProfileImageUpload(
                                                usercontroller
                                                    .userData!.user.id,
                                                DelarProfileImage != null
                                                    ? File(
                                                        DelarProfileImage!.path)
                                                    : null,
                                                context)
                                            .then((_) async {
                                          await value.fetchDelarData(
                                            usercontroller.userData!.user.id,
                                            context,
                                          );
                                          setState(() {
                                            isLoadings = false;
                                          });
                                        }).catchError((_) {
                                          setState(() {
                                            isLoadings = false;
                                          });
                                        });
                                      }
                                    }
                                  } else {
                                    showSnackBar(
                                      'Please Complete User profile',
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
    return Consumer<DelarController>(
      builder: (context, model, child) {
        // ignore: unnecessary_null_comparison
        if (model.delarData == null) {
          return Center(child: CircularProgressContainer());
        }

        if (DelarProfileImage != null) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.file(File(DelarProfileImage!.path),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  alignment: Alignment.center),
            ),
          );
        } else {
          if (model.delarData!.companylogo != null &&
              model.delarData!.companylogo.isNotEmpty) {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: commonCachedNetworkImage(
                    'https://jobhelp.test.satasmewebdev.online/assets/myCustomThings/dealer/' +
                        model.delarData!.companylogo,
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
                      'https://jobhelp.test.satasmewebdev.online/assets/myCustomThings/dealer/' +
                          model.delarData!.companylogo,
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
      isDense: isDense,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
