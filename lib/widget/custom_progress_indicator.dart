import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({
    Key? key,
    required this.max,
    required this.current,
    required this.color,
    this.notleft = false,
  }) : super(key: key);
  final double max;
  final double current;
  final Color color;
  final bool notleft;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, boxConstraints) {
      double width = boxConstraints.maxWidth;
      double percent = (current / max) * width;
      return Stack(
        children: [
          Container(
            height: 15,
            width: width,
            decoration: BoxDecoration(
              color: InsuremartTheme.black4.withOpacity(notleft ? 0.05 : 0.1),
              borderRadius: notleft ? null : BorderRadius.circular(5),
            ),
          ),
          AnimatedContainer(
            height: notleft ? 17 : 15,
            width: percent,
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: color,
              borderRadius: notleft
                  ? const BorderRadius.only(
                      topRight: Radius.circular(8.5),
                      bottomRight: Radius.circular(8.5),
                    )
                  : BorderRadius.circular(5),
            ),
          ),
        ],
      );
    });
  }
}
