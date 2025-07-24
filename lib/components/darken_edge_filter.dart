import 'package:flutter/material.dart';

class DarkenEdgeFilter extends StatelessWidget {
  final List<Color>? colors;
  final bool isDarken;
  const DarkenEdgeFilter({
    super.key,
    this.colors,
    this.isDarken = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors ??
                  [
                    const Color(0xCC000000),
                    const Color(0x00000000),
                    const Color(0x00000000),
                    const Color(0xCC000000),
                  ],
            ),
          ),
        ),
        Visibility(
          visible: isDarken,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.4),
          ),
        )
      ],
    );
  }
}
