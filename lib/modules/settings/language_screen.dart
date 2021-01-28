import 'package:flutter/material.dart';
import 'package:room/core/utils/ui_utils.dart';
import 'package:room/core/widgets/design_app_bar.dart';
import 'package:room/resources/colors_res.dart';

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.white,
      appBar: DesignAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        children: [
          _buildTitle(),
          const SizedBox(height: 15.0),
          _buildLanguageButton('Ukrainian', _onLanguageTap),
          _buildDivider(),
          _buildLanguageButton('English', _onLanguageTap),
          _buildDivider(),
          _buildLanguageButton('Chinese', _onLanguageTap),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Language',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorsRes.black,
          fontSize: 24.0,
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String label, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: ColorsRes.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsRes.primary2,
                    border: Border.all(
                      color: 0 == 1 ? Colors.black26 : Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: 0 == 1
                        ? const SizedBox()
                        : Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              color: ColorsRes.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: UiUtils.buildDivider(),
    );
  }

  void _onLanguageTap() {}
}
