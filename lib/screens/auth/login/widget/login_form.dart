import 'package:bw_project/screens/auth/login/widget/create_account_text.dart';
import 'package:bw_project/screens/auth/login/widget/custom_text_field.dart';
import 'package:bw_project/screens/auth/login/widget/forgot_password_text.dart';
import 'package:bw_project/screens/auth/login/widget/google_signin_button.dart';
import 'package:bw_project/screens/auth/login/widget/logbutton.dart';
import 'package:bw_project/screens/auth/login/widget/lottie.dart';
import 'package:bw_project/screens/auth/login/widget/seperation_divider.dart';
import 'package:bw_project/screens/auth/utils/validators/validators.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(BuildContext) onLogin;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        LottieWidget(),
        const SizedBox(height: 40),
        GoogleSignInButton(),
        SeperationDivider(),
        CustomTextFormField(
          label: 'Email',
          controller: emailController,
          validator: FormValidators.validateEmail,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          label: 'Password',
          isPassword: true,
          controller: passwordController,
          validator: FormValidators.validatePassword,
        ),
        ForgotPasswordText(),
        const SizedBox(height: 10),
        Logbutton(
          text: "Login",
          onPressed: () => onLogin(context),
        ),
        const SizedBox(height: 15),
        const AccountText(),
      ],
    );
  }
}