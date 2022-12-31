import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile(
    {
    Key? key,
    required this.leading,
    required this.title,
    required this.onTap, 
    this.badge = false,
  }) : super(key: key);
  final IconData leading;
  final String title;
  final GestureTapCallback onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          Icon(
            leading,
            size: 26,
            color: InsuremartTheme.blue3,
          ),
          if (badge)
            const Positioned(
              top: 0,
              left: 4,
              child: Icon(
                Icons.brightness_1,
                size: 8,
                color: Color(0xffF00000),
              ),
            ),
        ],
      ),
      minLeadingWidth: 23,
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
