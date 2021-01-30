import 'package:flutter/material.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/resources/colors_res.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              _buildBackButtonWidget(),
              const SizedBox(height: 20.0),
              _buildTitle(),
              const SizedBox(height: 15.0),
              _buildThemeItemWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BackButton(color: Colors.black87),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        getLocalized(context, 'theme_set_sc_english'),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorsRes.black,
          fontSize: 22.0,
        ),
      ),
    );
  }

  Widget _buildThemeItemWidget() {
    return GridView.builder(
      itemCount: 3,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return _buildThemeWidget(index.toString());
      },
    );
  }

  Widget _buildThemeWidget(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.black54, fontSize: 15.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
