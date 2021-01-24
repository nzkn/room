import 'package:flutter/material.dart';
import 'package:room/core/router/router.gr.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/core/widgets/design_input_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            Spacer(),
            _buildTitleWidget(),
            const SizedBox(height: 25.0),
            _buildInputFieldsWidget(),
            Spacer(),
            _buildNextButtonWidget(),
            const SizedBox(height: 15.0),
            _buildLogInWidget(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Text(
      'Log into your account',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black87,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildInputFieldsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          DesignInputField(
            hint: 'Email',
            controller: _emailController,
          ),
          const SizedBox(height: 15.0),
          DesignInputField(
            hint: 'Password',
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _buildNextButtonWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: DesignButton(
              title: 'Sign up',
              onTap: _onSignUpTap,
            ),
          ),
        ],
      ),
    );
  }

  void _onSignUpTap() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen, (route) => false);
  }

  Widget _buildLogInWidget() {
    return GestureDetector(
      onTap: _onSignInTap,
      child: Text(
        'Already have an account?  Log in',
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _onSignInTap() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.logInScreen, (route) => false);
  }
}
