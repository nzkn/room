import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:room/localization/locale_repository.dart';
import 'package:room/resources/images.dart';

class LanguageSelectionWidget extends StatefulWidget {
  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _onLanguageSelect('uk'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: SvgPicture.asset(
              Images.icUkraine,
              width: 60.0,
              height: 30.0,
            ),
          ),
        ),
        const SizedBox(width: 30.0),
        GestureDetector(
          onTap: () => _onLanguageSelect('en'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: SvgPicture.asset(
              Images.icUnitedKingdom,
              width: 60.0,
              height: 30.0,
            ),
          ),
        ),
      ],
    );
  }

  void _onLanguageSelect(String languageCode) {
    LocaleRepository.getInstance().saveLocale(languageCode);
  }
}
