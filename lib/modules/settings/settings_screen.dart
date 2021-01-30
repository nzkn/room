import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room/core/repositories/firebase_auth_repository.dart';
import 'package:room/core/router/route_names.dart';
import 'package:room/core/utils/ui_utils.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/models/user.dart';
import 'package:room/modules/main/blocs/user_bloc.dart';
import 'package:room/modules/main/blocs/user_event.dart';
import 'package:room/modules/main/blocs/user_state.dart';
import 'package:room/resources/colors_res.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _controller;
  bool _isEditingName;

  @override
  void initState() {
    _controller = TextEditingController();
    _isEditingName = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.white,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
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
                    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                    children: [
                      _buildProfileInfo(user),
                      const SizedBox(height: 20.0),
                      UiUtils.buildDivider(),
                      _buildLanguageButton(),
                      UiUtils.buildDivider(),
                      _buildThemeButton(),
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
        _buildProfileImageWidget(user),
        const SizedBox(height: 20.0),
        Container(
          height: 40.0,
          width: MediaQuery.of(context).size.width / 2.5,
          child: _buildUserNicknameWidget(user.fullName),
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

  Widget _buildProfileImageWidget(User user) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTakeImageTap,
      child: user.image == null
          ? Container(
              width: 100.0,
              height: 100.0,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              ),
            )
          : Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                image: DecorationImage(
                  image: NetworkImage(user.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }

  void _onTakeImageTap() async {
    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        context.read<UserBloc>().add(UpdateUserAvatar(_image));
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _buildUserNicknameWidget(String fullName) {
    if (!_isEditingName) {
      return InkWell(
        onTap: () => _onNicknameTap(fullName),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (fullName?.isNotEmpty ?? false) ? fullName : 'Full Name',
              style: TextStyle(
                fontSize: 20.0,
                color: (fullName?.isNotEmpty ?? false) ? Colors.black87 : Colors.black26,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5.0),
            Icon(Icons.edit_outlined, color: Colors.black87, size: 20.0),
          ],
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Full Name',
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          InkWell(
            onTap: () {
              setState(() {
                _isEditingName = !_isEditingName;
              });
              context.read<UserBloc>().add(UpdateUserName(_controller.text));
            },
            child: Icon(Icons.save, color: Colors.black87, size: 20.0),
          ),
        ],
      );
    }
  }

  void _onNicknameTap(String fullName) {
    setState(() {
      _isEditingName = !_isEditingName;
      if (fullName != null) {
        _controller.text = fullName;
      }
    });
  }

  Widget _buildThemeButton() {
    return _buildButton(_onThemeTap, Icons.color_lens, 'main_sc_background');
  }

  void _onThemeTap() {
    Navigator.pushNamed(context, RouteNames.themeSettingsRoute);
  }

  Widget _buildLogOutButton() {
    return _buildButton(_onLogOutTap, Icons.logout, 'main_sc_log_out');
  }

  void _onLogOutTap() async {
    final _authRepository = FirebaseAuthRepository();
    await _authRepository.signOut();
    Navigator.pushNamedAndRemoveUntil(context, RouteNames.languageRoute, (route) => false);
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
