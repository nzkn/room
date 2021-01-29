import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/route_names.dart';
import 'package:room/core/utils/ui_utils.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/models/user.dart';
import 'package:room/modules/main/blocs/user_bloc.dart';
import 'package:room/modules/main/blocs/user_state.dart';
import 'package:room/resources/colors_res.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.white,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            // return ListView(
            //   padding: const EdgeInsets.symmetric(
            //       vertical: 30.0, horizontal: 20.0),
            //   children: [
            //     _buildProfileInfo(state.user),
            //     const SizedBox(height: 20.0),
            //     UiUtils.buildDivider(),
            //     _buildLanguageButton(),
            //     UiUtils.buildDivider(),
            //     _buildLogOutButton(),
            //     UiUtils.buildDivider(),
            //   ],
            // );
            return StreamBuilder(
              stream: state.user,
              builder: (context, snapshot) {
                if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final User user = snapshot.data;
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20.0),
                    children: [
                      _buildProfileInfo(user),
                      const SizedBox(height: 20.0),
                      UiUtils.buildDivider(),
                      _buildLanguageButton(),
                      UiUtils.buildDivider(),
                      _buildLogOutButton(),
                      UiUtils.buildDivider(),
                    ],
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileInfo(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(50.0))
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          (user?.fullName?.isNotEmpty ?? false) ? user?.fullName : 'Full Name',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          user?.email ?? 'email',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLogOutButton() {
    return _buildButton(_onLogOutTap, Icons.logout, 'main_sc_log_out');
  }

  void _onLogOutTap() async {
    final _authRepository = FirebaseAuthRepository();
    await _authRepository.signOut();
    Navigator.pushReplacementNamed(context, RouteNames.logInRoute);
  }

  Widget _buildLanguageButton() {
    return _buildButton(_onLanguageTap, Icons.language, 'main_sc_language');
  }

  void _onLanguageTap() {
    Navigator.pushNamed(context, RouteNames.languageSettingsRoute);
  }

  Widget _buildButton(Function() onTap, IconData icon, String textKey) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 10.0),
            Text(
              getLocalized(context, textKey),
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
