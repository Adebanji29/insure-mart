import 'package:flutter/material.dart';

import './buttons.dart';
import '../utils/color.dart';

class IdContainer extends StatelessWidget {
  const IdContainer({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);
  final String buttonText;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      height: 176,
      decoration: BoxDecoration(
        color: InsuremartColor.blue2.withOpacity(.05),
        borderRadius: BorderRadius.circular(5),
      ),
      child: MediumButton(
        onPressed: onPressed,
        title: buttonText,
      ),
    );
  }
}


