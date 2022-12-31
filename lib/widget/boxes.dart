import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  /// custom SizedBoxes to calculate the width and height depending on the device
  /// size
  /// if you dont care about the width or height just pass in 74.47 into the field
  /// you dont want
  const CustomSizedBox({
    Key? key,
    this.height,
    this.width,
    this.child,
  }) : super(key: key);
  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: height != null ? size.height * (.00124 * height!) : null,
      width: width != null ? size.width * (.00264 * width!) : null,
      child: child,
    );
  }
}
