import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../provider/user_provider.dart';
import '../../push_notifications/push_notifications_system.dart';
import '../../utils/app_theme.dart';
import '../../utils/constant.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import 'notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    PushNotificationsSystem pushNotificationsSystem=  PushNotificationsSystem();
    pushNotificationsSystem.generateDeviceRecognitionToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserProvider userprovider = Provider.of<UserProvider>(context);
    userprovider.getUserData();
    List<UserModel> userModel= userprovider.getUsermodelList;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: userModel.map((e) =>  Row(children:
              [
          Text(
            'Hello, ',
            style: InsuremartTheme.lightTextTheme.headline1!.copyWith(
              color: InsuremartTheme.black1.withOpacity(.5),
            ),
          ),
            Text(
              e.firstname.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )


              ]),).toList()


        ),
        centerTitle: false,
        titleSpacing: 20,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(Notifications.route),
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Which insurance do you want to get?',
              style: InsuremartTheme.lightTextTheme.subtitle1!
                  .copyWith(color: InsuremartTheme.blue3),
              textAlign: TextAlign.start,
            ),
            const CustomSizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                itemCount: insuranceTypeList(context).length,
                itemBuilder: (_, index) => insuranceTypeList(context)[index],
                separatorBuilder: (_, __) => const CustomSizedBox(height: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> profileBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 44),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                const CustomSizedBox(width: 70),
                Text(
                  'Complete Profile',
                  style: InsuremartTheme.lightTextTheme.headline2!
                      .copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const CustomSizedBox(height: 10),
            Text(
              'Kindly first go to your profile to update your\nsettings and security requirements',
              style: InsuremartTheme.lightTextTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            const CustomSizedBox(height: 25),
            LongButton(title: 'Go TO PROFILE', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
