import 'package:flutter/material.dart';

responsiveSize(BuildContext context,
    {required double max, required double mid, required double min}) {
  Size size = MediaQuery.of(context).size;
  return size.width >= 800
      ? max
      : size.width >= 601
          ? mid
          : size.width >= 400
              ? min
              : 14;
}
