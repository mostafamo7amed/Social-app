import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';


class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  const SkeletonContainer({
    required this.width,
    required this.height,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
      ),
    );
  }


}
