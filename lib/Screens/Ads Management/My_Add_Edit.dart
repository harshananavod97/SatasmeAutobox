import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Provider/MyAdController.dart';
import 'package:newautobox/Provider/UserDataControlller.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/Ad_Negotiable_State.dart';
import 'package:newautobox/Screens/Ads%20Management/Widgets/Add_Condition.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/Const/Constant.dart';
import 'package:newautobox/Utils/DefultTextFiled.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/CommonCachedNetworkImage.dart';
import 'package:newautobox/Widgets/CustomRoundButton.dart';

import 'package:provider/provider.dart';

class MyAddEdit extends StatefulWidget {
  String price;
  String addName;

  String AdCondition;
  int negotiable;
  String url;

  String addDescription;
  int addid;

  MyAddEdit({
    super.key,
    required this.url,
    required this.negotiable,
    required this.AdCondition,
    required this.price,
    required this.addName,
    required this.addid,
    required this.addDescription,
  });

  @override
  State<MyAddEdit> createState() => _MyAddEditState();
}

class _MyAddEditState extends State<MyAddEdit> {
  bool isLoading = false;
  int negotiable = 0;
  String image = '';

  XFile? DelarProfileImage;

  final AddName = TextEditingController();
  final addphonenumber = TextEditingController();

  final AddDescriptionController = TextEditingController();
  final addConditionController = TextEditingController();

  final addpriceController = TextEditingController();

  late FocusNode _AddName;

  late FocusNode _AddPrice;

  late FocusNode _adddescription;

  void initState() {
    super.initState();
    _AddPrice = FocusNode();
    _AddName = FocusNode();

    _adddescription = FocusNode();

    setState(() {
      image = widget.url;

      AddDescriptionController.text = widget.addDescription;

      negotiable = widget.negotiable;

      AddName.text = widget.addName;
      addConditionController.text = widget.AdCondition;
      addpriceController.text = widget.price;
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<MyAdController>(
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
                          profileImage(image),
                          // if (sharedPref.getString(LOGIN_TYPE) != LoginTypeGoogle)
                        ],
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: AddName,
                        textFieldType: TextFieldType.NAME,
                        focus: _AddName,
                        nextFocus: _adddescription,
                        decoration: inputDecoration(label: 'Add Title'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: AddDescriptionController,
                        textFieldType: TextFieldType.ADDRESS,
                        focus: _adddescription,
                        nextFocus: _AddPrice,
                        decoration: inputDecoration(label: 'Add Description'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      AppTextField(
                        readOnly: false,
                        controller: addpriceController,
                        textFieldType: TextFieldType.PRICE,
                        focus: _AddPrice,
                        nextFocus: _AddPrice,
                        decoration: inputDecoration(label: 'Ad Price'),
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      ConditionDropdown(
                        defaultValue: addConditionController.text,
                        onChanged: (String? condition) {
                          addConditionController.text = condition ?? '';

                          print('Selected condition: $condition');
                        },
                      ),
                      SizedBox(height: 20),
                      NegotiableStatusDropdown(
                        defaultValue: negotiable,
                        onChanged: (int value) {
                          negotiable = value;

                          print('Selected value: $value');
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: isLoading == false
                            ? CustomRoundedButton(
                                widthPercentage: 0.55,
                                backgroundColor: AppColors.PRIMARY_COLOR,
                                buttonTitle: 'Update',
                                radius: 10,
                                showBorder: false,
                                height: 50,
                                onTap: () async {
                                  Logger().i(addConditionController.text);
                                  final usercontroller =
                                      Provider.of<Userdatacontroller>(context,
                                          listen: false);
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    ApiService()
                                        .UpdateAdd(
                                            widget.addid,
                                            AddName.text,
                                            AddDescriptionController.text,
                                            addConditionController.text,
                                            addpriceController.text,
                                            negotiable,
                                            context)
                                        .then((_) {
                                      setState(() async {
                                        AddName.clear();
                                        AddDescriptionController.clear();
                                        addConditionController.clear();
                                        addpriceController.clear();
                                        addphonenumber.clear();

                                        await value.fetchProducts(context,
                                            usercontroller.userData!.user.id);
                                        isLoading = false;
                                        image = '';
                                      });
                                    }).catchError((_) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
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

  Widget profileImage(String url) {
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
        child: commonCachedNetworkImage(AdsImageUrl + url,
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
