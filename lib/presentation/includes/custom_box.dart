import 'package:flutter/cupertino.dart';

class CustomBox extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color color;
  final Color shadowColor;
  final double blurRadius;
  final Widget child;
  final double horizontalMargin;
  final double verticalMargin;
  const CustomBox({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    required this.blurRadius,
    required this.shadowColor,
    required this.color,
    required this.child,
    required this.horizontalMargin,
    required this.verticalMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            blurRadius: blurRadius,
            color: shadowColor,
          ),
        ],
      ),
      child: child,
    );
  }
}
