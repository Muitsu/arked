import 'package:flutter/material.dart';

import 'constants/assets_color.dart';

class BackBtn extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  const BackBtn({super.key, this.mainAxisAlignment = MainAxisAlignment.end});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -3,
              left: -2,
              child: Container(
                height: 56,
                width: 88,
                decoration: BoxDecoration(
                    color: AssetsColor.blackMatte,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            mainAxisAlignment == MainAxisAlignment.end
                                ? 55
                                : 0),
                        bottomRight: Radius.circular(
                            mainAxisAlignment == MainAxisAlignment.start
                                ? 55
                                : 0))),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 50,
                width: 80,
                padding: EdgeInsets.only(
                    left: mainAxisAlignment == MainAxisAlignment.end ? 14 : 0,
                    right:
                        mainAxisAlignment == MainAxisAlignment.start ? 14 : 0),
                decoration: BoxDecoration(
                    color: AssetsColor.whiteMatte,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            mainAxisAlignment == MainAxisAlignment.end
                                ? 55
                                : 0),
                        bottomRight: Radius.circular(
                            mainAxisAlignment == MainAxisAlignment.start
                                ? 55
                                : 0))),
                child: Icon(
                  mainAxisAlignment == MainAxisAlignment.end
                      ? Icons.power_settings_new
                      : Icons.undo_rounded,
                  color: AssetsColor.blackMatte,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
