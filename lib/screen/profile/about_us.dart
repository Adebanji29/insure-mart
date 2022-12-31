import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);
  static const route = '/aboutUs';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/group.png', width: 212),
            SizedBox(height: 26, width: size.width),
            Text(
              'Insuremart',
              style: InsuremartTheme.lightTextTheme.headline2!
                  .copyWith(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              'V1.01',
              style: InsuremartTheme.lightTextTheme.bodyText2!.copyWith(
                color: InsuremartTheme.black1.withOpacity(.5),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Gravida ullamcorper accumsan sed adipiscing sit.\nDiam dignissim in ut lectus sed semper augue\nproin. Aenean mauris nunc at augue vel.',
              textAlign: TextAlign.center,
              style: InsuremartTheme.lightTextTheme.bodyText2!
                  .copyWith(color: InsuremartTheme.black1.withOpacity(.5)),
            ),
            const SizedBox(height: 20),
            Text(
              'Privacy Policy',
              style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                color: InsuremartTheme.blue4,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Terms & Conditions',
              style: InsuremartTheme.lightTextTheme.bodyText1!
                  .copyWith(color: InsuremartTheme.blue4),
            ),
          ],
        ),
      ),
    );
  }
}
