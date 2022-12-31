import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/app_theme.dart';

class ConnectSocials extends StatelessWidget {
  const ConnectSocials({Key? key}) : super(key: key);
  static const route = '/connectSocials';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Socials'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            socialContainer(
              'Google',
              const Icon(
                FontAwesomeIcons.google,
                color: InsuremartTheme.red1,
              ),
              connected: true,
            ),
            const SizedBox(height: 20),
            socialContainer(
              'Facebook',
              const Icon(
                FontAwesomeIcons.squareFacebook,
                color: Color(0xff3B5998),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container socialContainer(String name, Icon icon, {bool connected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      alignment: AlignmentDirectional.center,
      height: 90,
      decoration: BoxDecoration(
        color: connected ? InsuremartTheme.green3 : InsuremartTheme.white2,
        border: Border.all(
            width: connected ? 2 : 1,
            color: connected ? InsuremartTheme.green2 : InsuremartTheme.white3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 22.32),
              Text(
                name,
                style: InsuremartTheme.lightTextTheme.bodyText1,
              ),
            ],
          ),
          Text(
            connected ? 'Connected' : 'Not Connected',
            style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                fontSize: 12, color: InsuremartTheme.black1.withOpacity(0.5)),
          )
        ],
      ),
    );
  }
}
