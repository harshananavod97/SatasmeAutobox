import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newautobox/Api%20Service/ApiService.dart';
import 'package:newautobox/Screens/SignUpScreen.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/Const/FontStyle.dart';
import 'package:newautobox/Utils/EmailTextFiled.dart';
import 'package:newautobox/Utils/PasswordTextFiled.dart';
import 'package:newautobox/Widgets/CircleProcessContainer.dart';
import 'package:newautobox/Widgets/CustomRoundButton.dart';

class SignInScreen extends StatefulWidget {
  String Email;
  String Password;
  SignInScreen({super.key, required this.Email, required this.Password});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    SetCredintals();
  }

  void SetCredintals() {
    setState(() {
      emailController.text = widget.Email;
      pswdController.text = widget.Password;
    });
  }

  final _formKey = GlobalKey<FormState>();
  // final _formKeyDialog = GlobalKey<FormState>();

  bool isLoading = false;

  final emailController = TextEditingController();
  final forgotPswdController = TextEditingController();
  final pswdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Do you want to exit from this application ? "),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // return true;
                },
                child: Text("No"),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                  // return true;
                },
                child: Text("Yes"),
              ),
            ],
          ),
        );

        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        body: SingleChildScrollView(
          child: showForm(context),
        ),
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
              'Login an Account',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeights.bold,
                decorationColor: Theme.of(context).primaryColor,
                color: AppColors.Kwhite,
              ),
            ),
            SizedBox(height: size.height * .09),
            // const AppLogo(),
            SizedBox(height: size.height * .08),
            EmailTextField(controller: emailController),
            SizedBox(height: size.height * .02),
            PswdTextField(controller: pswdController),
            SizedBox(height: size.height * .04),

            isLoading
                ? CircularProgressContainer()
                : CustomRoundedButton(
                    widthPercentage: 0.55,
                    backgroundColor: Colors.red,
                    buttonTitle: 'lOGIN',
                    radius: 10,
                    showBorder: false,
                    height: 50,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        ApiService()
                            .UserLogin(
                          emailController.text.toString(),
                          pswdController.text.toString(),
                          context,
                        )
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

            // SizedBox(height: size.height * 0.02),
            // showSignIn(context),
            SizedBox(height: size.height * 0.02),
            showGoSignup(),
            // orLabel(),
            // SizedBox(height: size.height * 0.03),
            // loginWith(),
            // showSocialMedia(context),
            // SizedBox(height: size.height * 0.05),
            // const TermsAndCondition(),
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
          'Do You Have Account',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeights.regular,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        CupertinoButton(
          onPressed: () {
            _formKey.currentState!.reset();

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ));
          },
          padding: EdgeInsets.zero,
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeights.bold,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).primaryColor,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
