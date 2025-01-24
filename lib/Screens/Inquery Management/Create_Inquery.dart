import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Provider/DelarController.dart';
import 'package:newautobox/Provider/InqueryController.dart';
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

class CreateInquery extends StatefulWidget {
  const CreateInquery({super.key});

  @override
  State<CreateInquery> createState() => _CreateInqueryState();
}

class _CreateInqueryState extends State<CreateInquery> {
  int userId = 0;
  bool isLoading = false;

  final inqueryTitle = TextEditingController();
  final inqueryPhoneNumber = TextEditingController();
  final inqueryadditionalInformation = TextEditingController();

  late FocusNode _inqueryTittle;
  late FocusNode _inqueryPhonenumber;

  late FocusNode _inqueryAdditionalInformation;

  void initState() {
    super.initState();
    _inqueryTittle = FocusNode();
    _inqueryPhonenumber = FocusNode();
    _inqueryAdditionalInformation = FocusNode();

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
          Consumer<InqueryController>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                padding:
                    EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
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
                        controller: inqueryTitle,
                        textFieldType: TextFieldType.NAME,
                        focus: _inqueryTittle,
                        nextFocus: _inqueryPhonenumber,
                        decoration: inputDecoration(label: 'Inquiry Title'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: inqueryPhoneNumber,
                        textFieldType: TextFieldType.PHONE,
                        focus: _inqueryPhonenumber,
                        nextFocus: _inqueryAdditionalInformation,
                        decoration: inputDecoration(label: 'Phone Number'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: inqueryadditionalInformation,
                        textFieldType: TextFieldType.ADDRESS,
                        focus: _inqueryAdditionalInformation,
                        nextFocus: _inqueryAdditionalInformation,
                        decoration:
                            inputDecoration(label: 'Additional Information'),
                        onTap: () {},
                      ),
                      SizedBox(height: 10),
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

                                  if (delarcontrller.delarData!.stat == 'ok') {
                                    if (_formKey.currentState!.validate()) {
                                      if (DelarProfileImage != null) {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        ApiService()
                                            .CreateInquery(
                                                inqueryTitle.text,
                                                inqueryPhoneNumber.text,
                                                usercontroller
                                                    .userData!.user.id,
                                                inqueryadditionalInformation
                                                    .text,
                                                DelarProfileImage != null
                                                    ? File(
                                                        DelarProfileImage!.path)
                                                    : null,
                                                context)
                                            .then((_) {
                                          setState(() {
                                            isLoading = false;
                                            inqueryPhoneNumber.clear();
                                            inqueryTitle.clear();
                                            inqueryadditionalInformation
                                                .clear();
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
