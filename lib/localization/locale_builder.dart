import 'package:flutter/cupertino.dart';
import 'package:room/localization/locale_repository.dart';

class LocaleBuilder extends StatelessWidget {
  final Function(BuildContext, Locale) builder;

  const LocaleBuilder({this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: LocaleRepository.getInstance().observeLocale(),
      builder: (context, snapshot) {
        return builder(context, Locale(snapshot.data ?? 'en'));
      },
    );
  }
}