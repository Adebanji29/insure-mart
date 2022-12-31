import 'package:flutter/material.dart';


import '../utils/app_theme.dart';
import 'boxes.dart';

class InsuranceTypeCard extends StatelessWidget {
  const InsuranceTypeCard({
    Key? key,
    required this.logo,
    required this.type,
    required this.description,
    this.comingSoon = false,
    required this.onTap,
  }) : super(key: key);
  final String logo;
  final String type;
  final String description;
  final bool comingSoon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 135,
        decoration: BoxDecoration(
          color: InsuremartTheme.blue2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: .2,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
                width: size.width,
              ),
            ),
            Positioned(
              top: 20,
              left: 15,
              child: Image.asset(logo),
            ),
            Positioned(
              top: 77,
              left: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: InsuremartTheme.lightTextTheme.headline3!
                        .copyWith(color: InsuremartTheme.white1),
                  ),
                  if (comingSoon) const CustomSizedBox(width: 5),
                  if (comingSoon)
                    Container(
                      alignment: AlignmentDirectional.center,
                      height: 20,
                      width: 74,
                      decoration: BoxDecoration(
                        color: InsuremartTheme.green2,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Coming Soon',
                        style: InsuremartTheme.lightTextTheme.headline5!
                            .copyWith(color: InsuremartTheme.white1),
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              top: 77,
              right: 15,
              child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      //action coe when button is pressed
                    },
                    icon: const Icon(
                      Icons.info_rounded,
                      size: 30.0,
                      color: InsuremartTheme.white1,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
