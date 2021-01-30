import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:room/core/repositories/user_repository.dart';
import 'package:room/core/router/route_names.dart';
import 'package:room/core/utils/ui_utils.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/models/user.dart';
import 'package:room/resources/colors_res.dart';
import 'package:room/resources/images.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart' as dio;

class SignUpMethodScreen extends StatefulWidget {
  @override
  _SignUpMethodScreenState createState() => _SignUpMethodScreenState();
}

class _SignUpMethodScreenState extends State<SignUpMethodScreen> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();

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
      leading: Container(
          height: 25.0,
          width: 25.0,
          child: Image.asset(Images.icFacebook),
      ),
    );
  }

  void _onContinueWithFacebookTap() async {
    final FacebookLoginResult loginResult = await facebookSignIn.logIn(['email']);

    if (loginResult.status == FacebookLoginStatus.loggedIn) {
      final accessToken = loginResult.accessToken.token;
      final userName = await _getUserName(accessToken);
      final credential = auth.FacebookAuthProvider.credential(accessToken);
      await auth.FirebaseAuth.instance.signInWithCredential(credential);
      _createUser(userName);
      _navigateToMainScreen();
    } else if (loginResult.status == FacebookLoginStatus.cancelledByUser) {
      _showMessage(context, 'Login cancelled by the user.');
    } else {
      _showMessage(context, 'Authentication failed');
    }
  }

  Future<String> _getUserName(String accessToken) async {
    try {
      final dio = Dio();
      final response = await dio.get('https://graph.facebook.com/v2.12/me?fields=name&access_token=$accessToken');
      return response.data['name'];
    } on DioError catch (e) {
      print(e);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }

  Widget _buildGoogleButton() {
    return DesignButton(
      title: getLocalized(context, 'auth_method_continue_with_google'),
      color: ColorsRes.grey,
      textColor: ColorsRes.darkBlue,
      onTap: _onContinueWithGoogleTap,
      leading: Container(
          height: 25.0,
          width: 25.0,
          child: Image.asset(Images.icGoogle),
      ),
    );
  }

  void _onContinueWithGoogleTap() async {
    try {
      final googleAccount = await GoogleSignIn().signIn();
      final authentication = await googleAccount.authentication;
      final oAuthCredential = auth.GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken);
      final userCredentials = await auth.FirebaseAuth.instance.signInWithCredential(oAuthCredential);

      if (userCredentials?.user?.uid?.isNotEmpty ?? false) {
        final userName = userCredentials?.user?.displayName;
        await _createUser(userName);
        _navigateToMainScreen();
      }
    } on auth.FirebaseAuthException catch (err) {
      print(err);
    }
  }

  Future<DocumentReference> _createUser(String userName) async {
    final repository = UserRepository();
    final user = auth.FirebaseAuth.instance.currentUser;

    final id = user.uid;
    return await repository.createUser(
      User(id, userName, user.email),
    );
  }

  void _navigateToMainScreen() {
    Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainRoute, (route) => false);
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

  void _showMessage(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
