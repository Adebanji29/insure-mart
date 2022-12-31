import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import 'bvn.dart';
import 'id_verification.dart';
import 'utility_bills.dart';
import 'phone_number.dart';
import './two_step_verification.dart';
import 'change_password.dart';
import 'next_of_kin.dart';

class SecurityPassword extends StatelessWidget {
  const SecurityPassword({Key? key}) : super(key: key);
  static const route = '/securityPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security & Password'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            securityPassContainer(
              'BVN',
              () => Navigator.of(context).pushNamed(Bvn.route),
              subTitle: 'Connected',
            ),
            const SizedBox(height: 20),
            securityPassContainer(
              'ID Verification',
              () => Navigator.of(context).pushNamed(IdVerification.route),
              subTitle: 'Not verified',
            ),
            const SizedBox(height: 20),
            securityPassContainer(
              'Utility Bill',
              () => Navigator.of(context).pushNamed(UtilityBills.route),
              subTitle: 'Connected',
            ),
            const SizedBox(height: 20),
            securityPassContainer(
              'Phone Number',
              () => Navigator.of(context).pushNamed(PhoneNumber.route),
              subTitle: 'Not connected',
            ),
            const SizedBox(height: 20),
            securityPassContainer(
              '2-step verification',
              () => Navigator.of(context).pushNamed(TwoStepVerification.route),
              subTitle: 'Off',
            ),
            const SizedBox(height: 20),
            securityPassContainer(
              'Next of kin',
              () => Navigator.of(context).pushNamed(NextofKin.route),
              subTitle: 'Not added',
            ),
            const SizedBox(height: 20),
            securityPassContainer(
              'Change Password',
              () => Navigator.of(context).pushNamed(ChangePassword.route),
              cPassword: true,
            ),
          ],
        ),
      ),
    );
  }

  InkWell securityPassContainer(String title, GestureTapCallback onTap,
      {bool cPassword = false, String? subTitle}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 26.67),
        height: 80,
        decoration: BoxDecoration(
          color: InsuremartTheme.blue2.withOpacity(.05),
          border: Border.all(
            color: InsuremartTheme.black2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: InsuremartTheme.lightTextTheme.bodyText1),
            Row(
              children: [
                if (!cPassword)
                  Text(
                    subTitle!,
                    style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                      fontSize: 12,
                      color: InsuremartTheme.black1.withOpacity(.5),
                    ),
                  ),
                const SizedBox(width: 22.16),
                Icon(
                  Icons.chevron_right,
                  color: InsuremartTheme.black1.withOpacity(.5),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
