import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class CertificatePolicy extends StatelessWidget {
  const CertificatePolicy({
    Key? key,
    required this.onTap,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);
  final GestureTapCallback onTap;
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 197,
        width: 145.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: [
              Image.asset(imageUrl),
              Container(
                height: 197,
                width: 145.5,
                color: InsuremartTheme.black4.withOpacity(.8),
                alignment: AlignmentDirectional.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      color: InsuremartTheme.white1,
                    ),
                    Text(
                      title,
                      style: InsuremartTheme.lightTextTheme.headline3!.copyWith(
                        fontSize: 14,
                        color: InsuremartTheme.white1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
