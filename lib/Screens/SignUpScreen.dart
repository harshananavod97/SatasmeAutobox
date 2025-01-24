import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Screens/SignInScreen.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/Const/FontStyle.dart';
import 'package:newautobox/Utils/EmailTextFiled.dart';
import 'package:newautobox/Utils/PasswordTextFiled.dart';
import 'package:newautobox/Utils/UserNameTextFiled.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/CustomRoundButton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  // final _formKeyDialog = GlobalKey<FormState>();

  bool isLoading = false;

  final emailController = TextEditingController();
  final forgotPswdController = TextEditingController();
  final UserNameController = TextEditingController();
  final pswdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SingleChildScrollView(
        child: showForm(context),
      ),
    );
  }

  Widget showForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Padding(
        // padding: const EdgeInsets.all(30),
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: size.height * .09),
            Text(
              'AUTOBOX',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeights.bold,
                decorationColor: Theme.of(context).primaryColor,
                color: AppColors.Kwhite,
              ),
            ),
            Text(
              'Create an Account',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeights.bold,
                decorationColor: Theme.of(context).primaryColor,
                color: AppColors.Kwhite,
              ),
            ),
            SizedBox(height: size.height * .08),
            UserNameTextFiled(controller: UserNameController),
            SizedBox(height: size.height * .02),
            EmailTextField(controller: emailController),
            SizedBox(height: size.height * .02),
            PswdTextField(controller: pswdController),
            SizedBox(height: size.height * .04),
            isLoading
                ? CircularProgressContainer()
                : CustomRoundedButton(
                    widthPercentage: 0.55,
                    backgroundColor: Colors.red,
                    buttonTitle: 'SignUp',
                    radius: 10,
                    showBorder: false,
                    height: 50,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        ApiService()
                            .UserRegister(
                                emailController.text.toString(),
                                UserNameController.text.toString(),
                                pswdController.text.toString(),
                                context)
                            .then((_) {
                          setState(() {
                            isLoading = false; // Reset the loading state
                          });
                        }).catchError((_) {
                          setState(() {
                            isLoading =
                                false; // Reset the loading state on error
                          });
                        });
                      }
                    },
                  ),
            showGoSignup()
          ],
        ),
      ),
    );
  }

  Widget showGoSignup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeights.regular,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 2),
        CupertinoButton(
          onPressed: () {
            _formKey.currentState!.reset();

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(
                    Email: '',
                    Password: '',
                  ),
                ));
          },
          padding: EdgeInsets.zero,
          child: Text(
            'Login',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeights.bold,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).primaryColor,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}
