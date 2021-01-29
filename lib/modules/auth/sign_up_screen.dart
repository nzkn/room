import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:room/core/repositories/database_repository.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/route_names.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/core/widgets/design_input_field.dart';
import 'package:room/models/user.dart';
import 'package:room/modules/main/blocs/user_bloc.dart';
import 'package:room/modules/main/blocs/user_event.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/models/user.dart';
import 'package:room/modules/auth/widgets/language_selection_widget.dart';
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
            onChanged: (email) => _onEmailUpdated(email),
          ),
          const SizedBox(height: 15.0),
          DesignInputField(
            hint: getLocalized(context, 'password'),
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
    _updateContinueEnabled();
  }

  void _onPasswordUpdated(String password) {
    _isPasswordValidated = password.length > 7;
    _updateContinueEnabled();
  }

  void _updateContinueEnabled() {
    setState(() {
      _isContinueEnabled = _isEmailValidated && _isPasswordValidated;
    });
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


    final uid = await firebaseAuth.signUpWithEmail(email, password);

    if (uid == null) {
      _showLogInErrorSnackBar(context);
    } else {
      UserRepository repository = UserRepository();
      auth.User user = auth.FirebaseAuth.instance.currentUser;
      DocumentReference doc = await repository.createUser(
        User(user.uid, user.displayName, user.email),
      );

      if (doc != null) {
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainRoute, (route) => false);
      }
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
    Navigator.pushNamedAndRemoveUntil(context, RouteNames.logInRoute, (route) => false);
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
