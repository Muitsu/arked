import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../components/platform_image.dart';

class SkillButton extends StatefulWidget {
  final void Function()? onTap;
  final String skillName;
  final String asset;
  const SkillButton(
      {super.key, this.onTap, required this.skillName, required this.asset});

  @override
  State<SkillButton> createState() => _SkillButtonState();
}

class _SkillButtonState extends State<SkillButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: widget.onTap,
            child: Column(
              children: [
                PlatformAwareAssetImage(
                  asset: widget.asset,
                  height: 55,
                ),
                Text(widget.skillName,
                    style: const TextStyle(color: Colors.white))
              ],
            ))
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .then(delay: 800.ms)
        .shimmer(duration: const Duration(seconds: 3));
  }
}
