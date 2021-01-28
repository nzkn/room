import 'package:flutter/material.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/router.gr.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              children: [
                _buildProfileInfo(),
                const SizedBox(height: 20.0),
                _buildLogOutButton(),
              ],
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

  Widget _buildProfileInfo() {
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
          'Denis J',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'email@gmail.com',
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
    return Column(
      children: [
        Divider(color: Colors.black54),
        InkWell(
          onTap: () => _onLogOutTap(),
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.black54),
              const SizedBox(width: 10.0),
              Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.black54),
      ],
    );
  }

  void _onLogOutTap() async {
    final _authRepository = FirebaseAuthRepository();
    await _authRepository.signOut();
    Navigator.pushReplacementNamed(context, Routes.logInScreen);
  }

}
