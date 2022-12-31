import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_theme.dart';
import '../../provider/notification.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({Key? key}) : super(key: key);
  static const route = '/notificationSetting';
  @override
  Widget build(BuildContext context) {
    final read = context.read<NotificationProvider>();
    final watch = context.watch<NotificationProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            buildContainer(
              height: 80,
              title: 'All Notifications',
              switchValue: watch.all,
              onChange: (value) {
                read.changeAll();
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            buildContainer(
              height: 50,
              title: 'News and Promos',
              switchValue: watch.news,
              onChange: (value) {
                read.changeNews();
              },
            ),
            const SizedBox(height: 20),
            buildContainer(
              height: 50,
              title: 'My Insurance Updates',
              switchValue: watch.insurance,
              onChange: (value) {
                read.changeInsurance();
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer({
    required double height,
    required String title,
    required bool switchValue,
    required ValueChanged<bool?> onChange,
  }) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: height,
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
          Text(
            title,
            style: InsuremartTheme.lightTextTheme.bodyText1,
          ),
          Switch(
            activeColor: InsuremartTheme.blue2,
            activeTrackColor: InsuremartTheme.blue2.withOpacity(.5),
            value: switchValue,
            onChanged: onChange,
          )
        ],
      ),
    );
  }
}
