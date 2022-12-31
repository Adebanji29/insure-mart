import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import 'boxes.dart';

class MediumButton extends StatelessWidget {
  const MediumButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color = InsuremartTheme.blue2,
    this.titleColor = InsuremartTheme.white1,
    this.height = 47,
    this.width = 160,
  }) : super(key: key);
  final String title;
  final GestureTapCallback onPressed;
  final Color color;
  final Color titleColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          // minimumSize: const Size(160, 47),
          // shape: ,
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(fontSize: 12, color: titleColor),
        ),
      ),
    );
  }
}

class LongButton extends StatelessWidget {
  const LongButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color = InsuremartTheme.blue2,
    this.textColor,
    this.isBorder = false,
    this.height = 56,
    this.borderColor = InsuremartTheme.blue2,
  }) : super(key: key);
  final String title;
  final GestureTapCallback? onPressed;
  final Color color;
  final Color? textColor;
  final bool isBorder;
  final double height;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: isBorder
              ? BorderSide(width: 3, color: borderColor)
              : BorderSide.none,
        ),
        minimumSize: Size(size.width, height),
        // shape: ,
      ),
      child: Text(
        title,
        style: textColor == null
            ? Theme.of(context).textTheme.button
            : Theme.of(context).textTheme.button!.copyWith(color: textColor),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
    required this.title,
    required this.loadingTitle,
  }) : super(key: key);
  final VoidCallback onPressed;
  final bool isLoading;
  final String title;
  final String loadingTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              InsuremartTheme.blue2.withOpacity(isLoading ? 0.5 : 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: !isLoading
            ? Text(title)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: InsuremartTheme.white1,
                    ),
                  ),
                  const CustomSizedBox(width: 10),
                  Text(loadingTitle),
                ],
              ),
      ),
    );
  }
}

GestureDetector switchPageBtn(IconData icon, VoidCallback onTap,
    {Color? color}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 24,
      width: 24,
      alignment: AlignmentDirectional.center,
      decoration: const BoxDecoration(
        color: InsuremartTheme.white1,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 12,
        color: color,
      ),
    ),
  );
}
