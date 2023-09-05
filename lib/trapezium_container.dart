import 'package:flutter/material.dart';

class TrapeziumContainer extends StatelessWidget {
  final Widget? child;
  const TrapeziumContainer({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: TrapeziumClipper(), child: child);
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.1258333, size.height * 0.9985714);
    path0.lineTo(0, 0);
    path0.lineTo(size.width, size.height * 0.0014286);
    path0.lineTo(size.width * 0.8741667, size.height);
    path0.lineTo(size.width * 0.1258333, size.height * 0.9985714);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}

class StraightContainer extends StatelessWidget {
  final Widget? child;
  const StraightContainer({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: StraightClipper(), child: child);
  }
}

class StraightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width * 0.3228600, 0);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(StraightClipper oldClipper) => false;
}
