import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/router.gr.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/core/widgets/design_input_field.dart';
import 'package:room/models/user.dart';
import 'package:room/modules/main/blocs/user_bloc.dart';
import 'package:room/modules/main/blocs/user_event.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isEmailValidated;
  bool _isPasswordValidated;
  bool _isContinueEnabled;

  @override
  void initState() {
    super.initState();
    _isEmailValidated = false;
    _isPasswordValidated = false;
    _isContinueEnabled = false;
  }

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
                Spacer(),
                _buildTitleWidget(),
                const SizedBox(height: 25.0),
                _buildInputFieldsWidget(),
                Spacer(),
                _buildNextButtonWidget(context),
                const SizedBox(height: 15.0),
                _buildLogInWidget(),
                const SizedBox(height: 20.0),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Text(
      'Create new account',
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
            onChanged: (email) => _onEmailUpdated(email),
          ),
          const SizedBox(height: 15.0),
          DesignInputField(
            hint: 'Password',
            controller: _passwordController,
            obscure: true,
            onChanged: (pwd) => _onPasswordUpdated(pwd),
          ),
        ],
      ),
    );
  }

  void _onEmailUpdated(String email) {
    _isEmailValidated = EmailValidator.validate(_emailController.text);
    _checkIfContinueEnabled();
  }

  void _onPasswordUpdated(String password) {
    _isPasswordValidated = password.length > 7;
    _checkIfContinueEnabled();
  }

  void _checkIfContinueEnabled() {
    if (_isEmailValidated && _isPasswordValidated) {
      setState(() {
        _isContinueEnabled = true;
      });
    }
  }

  Widget _buildNextButtonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: DesignButton(
              title: 'Sign up',
              onTap: () => _onSignUpTap(context),
              enabled: _isContinueEnabled,
            ),
          ),
        ],
      ),
    );
  }

  void _onSignUpTap(BuildContext context) async {
    final firebaseAuth = FirebaseAuthRepository();
    final email = _emailController.text;
    final password = _passwordController.text;
    final id = await firebaseAuth.signUpWithEmail(email, password);

    if (id == null) {
      _showLogInErrorSnackBar(context);
    } else {
      final user = User.fromJson({'id': id});
      UserBloc().add(CreateUserEvent(user));
      Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen, (route) => false);
    }
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

  void _showLogInErrorSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Authentication error occurred. Check entered email and password."),
        elevation: 4.0,
        margin: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

}
