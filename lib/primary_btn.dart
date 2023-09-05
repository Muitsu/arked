import 'package:flutter/material.dart';

import 'constants/assets_color.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double? fontSize;
  final double? height;
  final Color? bgColor;
  final double? width;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.fontSize,
    this.height,
    this.width,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: -3,
          left: -2,
          child: SizedBox(
            width: width,
            height: height,
            child: ElevatedButton(
                onPressed: () {
                  return;
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: AssetsColor.blackMatte,
                  backgroundColor: AssetsColor.blackMatte,
                ),
                child: Text(title)),
          ),
        ),
        SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  backgroundColor: bgColor,
                  foregroundColor: AssetsColor.blackMatte),
              child: Text(
                title,
                style: TextStyle(fontSize: fontSize),
              )),
        ),
      ],
    );
  }
}
