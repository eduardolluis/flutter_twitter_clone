import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/rounded_small_button.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/auth/widget/auth_field.dart';
import 'package:twitter_clone/theme/pallete.dart';

class SignUpView extends StatefulWidget {
  static dynamic route() =>
      MaterialPageRoute(builder: (context) => const SignUpView());
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final appbar = UiConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AuthField(controller: emailController, hintText: "Email"),
                const SizedBox(height: 25),
                AuthField(controller: passwordController, hintText: "Password"),
                const SizedBox(height: 25),

                AuthField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                ),
                const SizedBox(height: 45),
                Align(
                  alignment: Alignment.centerRight,
                  child: RoundedSmallButton(
                    onTap: () {},
                    label: 'Done',
                    backgroundColor: Pallete.whiteColor,
                    textColor: Pallete.backgroundColor,
                  ),
                ),
                const SizedBox(height: 45),
                RichText(
                  text: TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                        text: " Log in",
                        style: TextStyle(
                          color: Pallete.blueColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, LoginView.route());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
