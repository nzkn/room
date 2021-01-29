import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/route_names.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/core/widgets/design_input_field.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/resources/colors_res.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  bool _emailValidated;

  @override
  void initState() {
    super.initState();
    _emailValidated = false;
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
                  _buildInputFieldWidget(),
                  Spacer(),
                  _buildResetPasswordButtonWidget(context),
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
      getLocalized(context, 'reset_pass_sc_enter_email'),
      style: const TextStyle(
        color: ColorsRes.black,
        fontSize: 26.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildInputFieldWidget() {
    return DesignInputField(
      hint: getLocalized(context, 'email'),
      controller: _emailController,
      onChanged: (email) => _validateEmail(email),
    );
  }

  void _validateEmail(String email) {
    var _emailIsValid = EmailValidator.validate(email);
    if (_emailIsValid != _emailValidated) {
      setState(() {
        _emailValidated = _emailIsValid;
      });
    }
  }

  Widget _buildResetPasswordButtonWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DesignButton(
            title: getLocalized(context, 'reset_pass_sc_reset_password'),
            onTap: () => _onResetPasswordTap(context),
            enabled: _emailValidated,
          ),
        ),
      ],
    );
  }

  Future<void> _onResetPasswordTap(BuildContext context) async {
    final firebaseAuth = FirebaseAuthRepository();
    final email = _emailController.text;

    await firebaseAuth.resetPasswordWithEmail(email);
    _showEmailWasSentSnackBar(context);
    Navigator.pushReplacementNamed(context, RouteNames.logInRoute);
  }

  void _showEmailWasSentSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Email with recovery link was successfully sent to you email!"),
      ),
    );
  }

}
