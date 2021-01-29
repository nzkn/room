import 'package:flutter/material.dart';

class DesignButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final bool enabled;

  const DesignButton({
    @required this.title,
    @required this.onTap,
    this.color = Colors.yellow,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: enabled
              ? color
              : color.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: enabled
                  ? Colors.black
                  : Colors.black26,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
