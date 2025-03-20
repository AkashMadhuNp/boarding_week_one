import 'package:bw_project/screens/auth/login/widget/custom_text_field.dart';
import 'package:bw_project/screens/auth/login/widget/logbutton.dart';
import 'package:bw_project/screens/auth/login/widget/lottie.dart';
import 'package:bw_project/screens/auth/signUp/widget/custom_create.dart';
import 'package:bw_project/screens/auth/utils/validators/validators.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function(BuildContext) onSignUp;

  const SignUpForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CreateAccountText(),
        const SizedBox(height: 20),
        LottieWidget(),
        CustomTextFormField(
          label: "Username",
          controller: usernameController,
          validator: FormValidators.validateUsername,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          label: "Email",
          controller: emailController,
          validator: FormValidators.validateEmail,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          label: "Password",
          isPassword: true,
          controller: passwordController,
          validator: FormValidators.validatePassword,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          label: "Confirm Password",
          isPassword: true,
          controller: confirmPasswordController,
          validator: (value) => FormValidators.validateConfirmPassword(
            value, 
            passwordController.text
          ),
        ),
        const SizedBox(height: 20),
        Logbutton(
          text: "Sign Up",
          onPressed: () => onSignUp(context),
        ),
      ],
    );
  }
}