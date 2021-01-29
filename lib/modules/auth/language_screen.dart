import 'package:flutter/material.dart';
import 'package:room/resources/colors_res.dart';
import 'package:room/modules/auth/widgets/language_selection_widget.dart';
import 'package:room/core/router/route_names.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.primary2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1, child: SizedBox()),
          _buildLogo(),
          const SizedBox(height: 15.0),
          _buildDescription(),
          const SizedBox(height: 22.0),
          LanguageSelectionWidget(_onFlagTap),
          Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }

  void _onFlagTap() {
    Navigator.pushNamed(context, RouteNames.signUpMethodScreen);
  }

  Widget _buildLogo() {
    return Text("Room",
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
        color: ColorsRes.black,
      ),
    );
  }

  Widget _buildDescription() {
    return Text("Choose your language",
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }
}
