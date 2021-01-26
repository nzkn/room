import 'package:flutter/material.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/router.gr.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/core/widgets/design_input_field.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                _buildResetPasswordWidget(),
                Spacer(),
                _buildTitleWidget(),
                const SizedBox(height: 25.0),
                _buildInputFieldsWidget(),
                Spacer(),
                _buildNextButtonWidget(context),
                const SizedBox(height: 15.0),
                _buildCreateAccountWidget(),
                const SizedBox(height: 20.0),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildResetPasswordWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: _onForgotPasswordTap,
            child: Text(
              'Forgot password?',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onForgotPasswordTap() {
    Navigator.pushNamed(context, Routes.resetPasswordScreen);
  }

  Widget _buildTitleWidget() {
    return Text(
      'Log in',
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

  Widget _buildNextButtonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: DesignButton(
              title: 'Log in',
              onTap: () => _onLogInTap(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onLogInTap(BuildContext context) async {
    final firebaseAuth = FirebaseAuthRepository();
    final email = _emailController.text;
    final password = _passwordController.text;

    final uid = await firebaseAuth.logInWithEmail(email, password);
    if (uid == null) {
      _showLogInErrorSnackBar(context);
      print('err');
    } else {
      Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen, (route) => false);
    }
  }

  Widget _buildCreateAccountWidget() {
    return GestureDetector(
      onTap: _onSignUpClick,
      child: Text(
        'Doesn\'t have an account?  Create one',
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _onSignUpClick() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.signUpScreen, (route) => false);
  }

  void _showLogInErrorSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("hi"),
          elevation: 4.0,
        ),
    );
  }
}
