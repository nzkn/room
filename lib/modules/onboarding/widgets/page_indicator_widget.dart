import 'package:flutter/material.dart';

class PagesIndicatorWidget extends StatelessWidget {
  final int count;
  final int selectedIndex;
  final Color color;

  PagesIndicatorWidget({
    @required this.count,
    this.color = Colors.grey,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          count,
              (index) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: index == selectedIndex
                    ? color
                    : color.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              width: 10.0,
              height: 10.0,
            );
          }
      ),
    );
  }
}