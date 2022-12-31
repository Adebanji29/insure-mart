import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../../utils/color.dart';


class TwoStepVerification extends StatelessWidget {
  const TwoStepVerification({Key? key}) : super(key: key);
  static const route = '/twoStep';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2-step Verification'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          tileColor: InsuremartColor.blue2.withOpacity(.1),
          title: Text('2-step Verification',
              style: InsuremartTheme.lightTextTheme.bodyText1),
          subtitle: Text(
            'Send an OTP to your phone number each\ntime you want to login',
            style: InsuremartTheme.lightTextTheme.bodyText2!.copyWith(
              fontSize: 12,
              color: InsuremartColor.black1.withOpacity(.5),
            ),
          ),
          trailing: Switch(
            activeColor: InsuremartTheme.blue2,
            activeTrackColor: InsuremartTheme.blue2.withOpacity(.5),
            value: true,
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }
}
