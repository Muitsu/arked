import 'package:flutter/material.dart';

class DarkenEdgeFilter extends StatelessWidget {
  final List<Color>? colors;
  const DarkenEdgeFilter({
    super.key,
    this.colors,
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
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.4),
        )
      ],
    );
  }
}
