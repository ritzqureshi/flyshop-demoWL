import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadiusValue;
  final VoidCallback onClick;
  final String btnTxt;
  final TextStyle? btnTextStyle;
  final double? elevation;
  final Color backgroundColor;
  final Gradient? gradient;
  final List<BoxShadow>? shadow;

  const MyButton({
    super.key,
    this.width,
    this.height = 50,
    this.margin,
    this.padding,
    required this.onClick,
    required this.btnTxt,
    this.btnTextStyle,
    this.elevation = 0,
    this.borderRadiusValue = 15,
    this.backgroundColor = Colors.orange,
    this.gradient,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? backgroundColor : null,
        borderRadius: BorderRadius.circular(borderRadiusValue),
        boxShadow: shadow,
      ),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding ?? EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        child: Center(
          child: Text(
            btnTxt,
            style: btnTextStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
