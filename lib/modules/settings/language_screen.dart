import 'package:flutter/material.dart';
import 'package:room/core/utils/ui_utils.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/localization/locale_builder.dart';
import 'package:room/localization/locale_repository.dart';
import 'package:room/resources/colors_res.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
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
              _buildLanguageButton(
                label: getLocalized(context, 'language_set_sc_ukrainian'),
                onTap: () => _onLanguageSelect('uk'),
                languageCode: 'uk',
              ),
              _buildDivider(),
              _buildLanguageButton(
                label: getLocalized(context, 'language_set_sc_english'),
                onTap: () => _onLanguageSelect('en'),
                languageCode: 'en',
              ),
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
        getLocalized(context, 'language_set_sc_language'),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorsRes.black,
          fontSize: 22.0,
        ),
      ),
    );
  }

  Widget _buildLanguageButton({String label, Function onTap, String languageCode}) {
    return InkWell(
      onTap: onTap,
      child: LocaleBuilder(
        builder: (context, locale) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: ColorsRes.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                _buildSelectedIndicatorWidget(locale.languageCode == languageCode),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedIndicatorWidget(bool isSelected) {
    return Container(
      height: 25.0,
      width: 25.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorsRes.primary2,
      ),
      child: Center(
        child: Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: isSelected ? ColorsRes.black : Colors.transparent,
            shape: BoxShape.circle,
          ),
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

  void _onLanguageSelect(String languageCode) {
    LocaleRepository.getInstance().saveLocale(languageCode);
  }
}
