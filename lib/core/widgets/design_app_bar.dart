import 'package:flutter/material.dart';
import 'package:room/resources/colors_res.dart';

class DesignAppBar extends StatelessWidget implements PreferredSize {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: ColorsRes.black,
      ),
      backgroundColor: ColorsRes.primary,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
