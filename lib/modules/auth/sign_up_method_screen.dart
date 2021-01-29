import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room/core/router/route_names.dart';
import 'package:room/core/utils/ui_utils.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/resources/colors_res.dart';
import 'package:room/resources/images.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpMethodScreen extends StatefulWidget {
  @override
  _SignUpMethodScreenState createState() => _SignUpMethodScreenState();
}

class _SignUpMethodScreenState extends State<SignUpMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: ColorsRes.black,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const SizedBox(height: 10.0),
          _buildTitle(),
          const SizedBox(height: 20.0),
          _buildFacebookButton(),
          const SizedBox(height: 14.0),
          _buildGoogleButton(),
          const SizedBox(height: 14.0),
          _buildDivider(),
          const SizedBox(height: 14.0),
          _buildEmailButton(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: UiUtils.buildDivider()),
        Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            getLocalized(context, 'auth_method_or'),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 11.0,
            ),
          ),
        ),
        Expanded(child: UiUtils.buildDivider()),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      getLocalized(context, 'auth_method_sign_up_or_login'),
      style: const TextStyle(
        color: ColorsRes.black,
        fontSize: 26.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildFacebookButton() {
    return DesignButton(
      title: getLocalized(context, 'auth_method_continue_with_facebook'),
      color: ColorsRes.blue,
      textColor: ColorsRes.white,
      onTap: _onContinueWithFacebookTap,
      leading: Container(height: 25.0, width: 25.0, child: Image.asset(Images.icFacebook)),
    );
  }

  void _onContinueWithFacebookTap() {

  }

  Widget _buildGoogleButton() {
    return DesignButton(
      title: getLocalized(context, 'auth_method_continue_with_google'),
      color: ColorsRes.grey,
      textColor: ColorsRes.darkBlue,
      onTap: _onContinueWithGoogleTap,
      leading: Container(height: 25.0, width: 25.0, child: Image.asset(Images.icGoogle)),
    );
  }

  void _onContinueWithGoogleTap() async {
    try {
      GoogleSignInAccount account = await GoogleSignIn().signIn();
      GoogleSignInAuthentication authentication = await account.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      UserCredential credentials = await FirebaseAuth.instance.signInWithCredential(credential);


    } on FirebaseAuthException catch (err) {
      print(err);
    }
  }

  Widget _buildEmailButton() {
    return DesignButton(
      title: getLocalized(context, 'auth_method_continue_with_email'),
      color: ColorsRes.grey,
      textColor: ColorsRes.darkBlue,
      onTap: _onContinueWithEmailTap,
    );
  }

  void _onContinueWithEmailTap() {
    Navigator.pushNamed(context, RouteNames.logInRoute);
  }
}
