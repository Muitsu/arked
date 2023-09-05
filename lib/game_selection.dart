import 'package:flutter/material.dart';
import 'package:muitsu_arked/constants/responsive_size.dart';
import 'package:muitsu_arked/platform_image.dart';

class GameSelection extends StatelessWidget {
  const GameSelection(
      {super.key,
      required this.game,
      this.isActive = false,
      this.onTap,
      required this.icon});
  final bool isActive;
  final String game;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInSine,
              height: isActive ? size.height * 0.25 : size.height * 0.20,
              width: isActive ? size.height * 0.25 : size.height * 0.20,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(14),
                  border: isActive
                      ? Border.all(color: Colors.white, width: 4)
                      : null),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: PlatformAwareAssetImage(
                      asset: icon,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                      left: 10,
                      bottom: 10,
                      child: Text(
                        game,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: responsiveSize(context,
                                max: 16, mid: 12, min: 8)),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
