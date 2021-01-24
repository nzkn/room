import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:room/resources/colors_res.dart';
import 'package:room/resources/images.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogoWidget(),
        const SizedBox(height: 40.0),
        _buildFlagsWidget(),
      ],
    );
  }

  Widget _buildLogoWidget() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.imLogo)
        ),
      ),
      width: 100.0,
      height: 100.0,
    );
  }

  Widget _buildFlagsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Select language',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: ColorsRes.black,
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFlagWidget(Images.icUkraine, "Ukrainian"),
            const SizedBox(width: 20.0),
            _buildFlagWidget(Images.icUnitedKingdom, "English"),
          ],
        ),
      ],
    );
  }

  Widget _buildFlagWidget(String image, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(),
        const SizedBox(height: 10.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: ColorsRes.black,
          ),
        ),
      ],
    );
  }
}
