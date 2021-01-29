import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:room/localization/locale_repository.dart';
import 'package:room/resources/images.dart';
import 'package:room/resources/colors_res.dart';

class LanguageSelectionWidget extends StatefulWidget {

  final Function onTap;

  const LanguageSelectionWidget(this.onTap);

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
          onTap: () => _onFlagTap('uk'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: SvgPicture.asset(
                  Images.icUkraine,
                  width: 60.0,
                  height: 30.0,
                ),
              ),
              const SizedBox(height: 12.0),
              Text("Ukrainian",
                style: TextStyle(
                  color: ColorsRes.black,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 30.0),
        GestureDetector(
          onTap: () => _onFlagTap('en'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: SvgPicture.asset(
                  Images.icUnitedKingdom,
                  width: 60.0,
                  height: 30.0,
                ),
              ),
              const SizedBox(height: 12.0),
              Text("English",
                style: TextStyle(
                  color: ColorsRes.black,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onFlagTap(String languageCode) {
    _onLanguageSelect(languageCode);
    widget.onTap();
  }

  void _onLanguageSelect(String languageCode) {
    LocaleRepository.getInstance().saveLocale(languageCode);
  }
}
