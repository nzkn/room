import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/route_names.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/core/widgets/design_input_field.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/resources/colors_res.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isEmailValidated;
  bool _isPwdValidated;
  bool _isContinueEnabled;

  @override
  void initState() {
    super.initState();
    _isEmailValidated = false;
    _isPwdValidated = false;
    _isContinueEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: ColorsRes.black,
        ),
        actions: [
          _buildResetPasswordWidget(context),
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  _buildTitleWidget(),
                  const SizedBox(height: 25.0),
                  _buildInputFieldsWidget(),
                  const SizedBox(height: 25.0),
                  Spacer(),
                  _buildNextButtonWidget(context),
                  const SizedBox(height: 15.0),
                  _buildCreateAccountWidget(),
                  const SizedBox(height: 20.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Text(
      getLocalized(context, 'login_sc_log_into_account'),
      style: const TextStyle(
        color: ColorsRes.black,
        fontSize: 26.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildResetPasswordWidget(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _onForgotPasswordTap,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            getLocalized(context, 'login_sc_forgot_password'),
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _onForgotPasswordTap() {
    Navigator.pushNamed(context, RouteNames.resetPasswordRoute);
  }

  Widget _buildInputFieldsWidget() {
    return Column(
      children: [
        DesignInputField(
          hint: getLocalized(context, 'email'),
          controller: _emailController,
          onChanged: (email) => _validateEmail(email),
        ),
        const SizedBox(height: 15.0),
        DesignInputField(
          hint: getLocalized(context, 'password'),
          controller: _passwordController,
          obscure: true,
          onChanged: (pwd) => _validatePwd(pwd),
        ),
      ],
    );
  }

  void _validateEmail(String email) {
    _isEmailValidated = EmailValidator.validate(email);
    _updateContinueEnabled();
  }

  void _validatePwd(String password) {
    _isPwdValidated = password.length > 7;
    _updateContinueEnabled();
  }

  void _updateContinueEnabled () {
    setState(() {
      _isContinueEnabled = _isEmailValidated && _isPwdValidated;
    });
  }

  Widget _buildNextButtonWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DesignButton(
            title: getLocalized(context, 'login_sc_log_in'),
            onTap: () => _onLogInTap(context),
            enabled: _isContinueEnabled,
          ),
        ),
      ],
    );
  }

  Future<void> _onLogInTap(BuildContext context) async {
    final firebaseAuth = FirebaseAuthRepository();
    final email = _emailController.text;
    final password = _passwordController.text;

    final uid = await firebaseAuth.logInWithEmail(email, password);
    if (uid == null) {
      _showLogInErrorSnackBar(context);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.mainRoute);
    }
  }

  Widget _buildCreateAccountWidget() {
    return Center(
      child: GestureDetector(
        onTap: _onSignUpClick,
        child: Text(
          getLocalized(context, 'login_sc_no_account'),
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _onSignUpClick() {
    Navigator.pushReplacementNamed(context, RouteNames.signUpRoute);
  }

  void _showLogInErrorSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Authentication failed"),
          elevation: 4.0,
          margin: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
          behavior: SnackBarBehavior.floating,
        ),
    );
  }
}
