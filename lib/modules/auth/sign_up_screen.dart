import 'package:flutter/material.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/router.gr.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/core/widgets/design_input_field.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/localization/locale_repository.dart';
import 'package:room/modules/auth/widgets/language_selection_widget.dart';

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
            const SizedBox(height: 25.0),
            LanguageSelectionWidget(),
            Spacer(),
            _buildNextButtonWidget(context),
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
      getLocalized(context, 'signup_sc_create_account'),
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
            hint: getLocalized(context, 'email'),
            controller: _emailController,
          ),
          const SizedBox(height: 15.0),
          DesignInputField(
            hint: getLocalized(context, 'password'),
            controller: _passwordController,
            obscure: true,
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
              title: getLocalized(context, 'signup_sc_sign_up'),
              onTap: () => _onSignUpTap(context),
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

    final uid = await firebaseAuth.signUpWithEmail(email, password);
    if (uid == null) {
      _showLogInErrorSnackBar(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen, (route) => false);
    }
  }

  Widget _buildLogInWidget() {
    return GestureDetector(
      onTap: _onSignInTap,
      child: Text(
        getLocalized(context, 'signup_sc_already_have_account'),
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
