import 'package:flutter/material.dart';

extension MediaQueryData on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}
