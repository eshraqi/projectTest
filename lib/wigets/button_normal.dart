import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_color.dart';

class ButtonNormal extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final double? fontSize;
  final bool enable;
  final VoidCallback? onPressed;
  final FontWeight? fontWeight;
  final String? icon;
  final double borderRadius;

  const ButtonNormal({
    required this.text,
    this.width = double.infinity,
    this.height = 50,
    this.enable = true,
    this.onPressed,
    this.backgroundColor = AppColor.colorPrimary,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w700,
    this.textColor = Colors.white,
    this.icon,
    this.borderRadius = 10,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: enable ? onPressed ?? () {} : null,
          style: ElevatedButton.styleFrom(elevation: 0, primary: backgroundColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(icon!),
                    const SizedBox(width: 7),
                    Text(
                      text,
                      style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight),
                )),
    );
  }
}
