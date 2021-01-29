import 'package:flutter/material.dart';
import 'package:room/resources/colors_res.dart';

class DesignButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final bool enabled;
  final Widget leading;


  const DesignButton({
    @required this.title,
    @required this.onTap,
    this.color = Colors.yellow,
    this.textColor = ColorsRes.black,
    this.enabled = true,
    this.leading = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: enabled ? color : color.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: enabled ? textColor : textColor.withOpacity(0.26),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: leading,
            ),
          ),
        ),
      ],
    );
  }
}
