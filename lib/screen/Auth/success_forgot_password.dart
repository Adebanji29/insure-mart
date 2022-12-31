import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';

class ForgotPasswordSuccess extends StatelessWidget {
  const ForgotPasswordSuccess({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recovery Email Sent',
            style: InsuremartTheme.lightTextTheme.headline2!
                .copyWith(fontSize: 24),
            textAlign: TextAlign.start,
          ),
          const CustomSizedBox(height: 5),
            Text(
            'An email has been sent to you with a link to recover your password',
            style: InsuremartTheme.lightTextTheme.bodyText2,
            textAlign: TextAlign.start,
          ),
          const CustomSizedBox(height: 25),
          LongButton(
            title: 'Go back to login',
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
