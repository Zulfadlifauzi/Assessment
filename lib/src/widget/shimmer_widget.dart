import 'package:flutter/material.dart';

import 'shimmer_animation_widget.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder? shapeBorder;
  const ShimmerWidget.rectangular(
      {super.key,
      required this.height,
      this.width = double.infinity,
      this.shapeBorder});
  const ShimmerWidget.circular(
      {super.key,
      required this.height,
      this.width = double.infinity,
      this.shapeBorder = const CircleBorder()});
  @override
  Widget build(BuildContext context) {
    return ShimmerFunctionWidget(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.grey,
          shape: shapeBorder ?? const RoundedRectangleBorder(),
        ),
        width: width,
        height: height,
      ),
    );
  }
}
