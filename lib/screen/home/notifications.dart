import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  static const route = '/notifications';

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 22, right: 20),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Mark all as read',
                style: InsuremartTheme.lightTextTheme.headline3!
                    .copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: 2,
        itemBuilder: (_, index) => const NotificationItem(read: true),
        separatorBuilder: (_, __) => const CustomSizedBox(height: 30),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.read,
  }) : super(key: key);
  final bool read;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.notifications,
              color: !read
                  ? InsuremartTheme.blue1
                  : InsuremartTheme.black1.withOpacity(.4),
              size: 20,
            ),
            const CustomSizedBox(width: 10),
            SizedBox(
              width: size.width - 100,
              child: Text(
                'Your Claim has been approved',
                style: InsuremartTheme.lightTextTheme.headline3!.copyWith(
                  fontWeight: !read ? FontWeight.w700 : FontWeight.w600,
                  color: !read
                      ? InsuremartTheme.blue1
                      : InsuremartTheme.black1.withOpacity(.7),
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
        const CustomSizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Notification body Pellentesque lobortis quam eget faucibus ultrices molestie.',
            style: InsuremartTheme.lightTextTheme.bodyText2!.copyWith(
                fontWeight: !read ? FontWeight.w500 : FontWeight.w400,
                color: InsuremartTheme.black1.withOpacity(!read ? 1 : .5)),
          ),
        ),
        const CustomSizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            '04/15/2021, 00:08',
            style: InsuremartTheme.lightTextTheme.subtitle1!.copyWith(
              fontSize: 10,
              color: InsuremartTheme.black4.withOpacity(.6),
            ),
          ),
        ),
        const CustomSizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: MediumButton(
            onPressed: () {},
            title: 'VIEW CLAIM',
            color: InsuremartTheme.blue2.withOpacity(!read ? 1 : 0.7),
          ),
        )
      ],
    );
  }
}
