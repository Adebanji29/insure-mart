import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../provider/user_provider.dart';
// import '../../service/user_service.dart';
import '../../utils/app_theme.dart';
import '../Auth/login.dart';
import './about_us.dart';
import './connect_socials.dart';
import './edit_profile.dart';
import './help_support.dart';
import './my_cards.dart';
import './notification_setting.dart';
import './security_password.dart';
import './share_insuremart.dart';
import '../../widget/profile_image.dart';
import '../../widget/profile_list_tile.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    UserProvider userprovider = Provider.of<UserProvider>(context);
    userprovider.getUserData();
    List<UserModel> userModel = userprovider.getUsermodelList;

    // To use elementAt method
    // String firstname= userModel.elementAt(0).firstname.toString();
    // String lastname=userModel.elementAt(0).lastname.toString();
    // String email=userModel.elementAt(0).email.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
        titleSpacing: 20,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: SingleChildScrollView(
          child: Column(
              children: userModel
                  .map(
                    (e) => Column(
                      children: [
                      ProfileImage(),
                        const SizedBox(height: 10),
                        Text(
                          "${e.firstname} ${e.lastname}",
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          e.email.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Divider(),
                        ProfileListTile(
                          leading: Icons.create,
                          title: 'Edit Profile',
                          onTap: () {
                            Navigator.of(context).pushNamed(EditProfile.route);
                          },
                          badge: true,
                        ),
                        ProfileListTile(
                          leading: FontAwesomeIcons.facebook,
                          title: 'Connect Socials',
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ConnectSocials.route);
                          },
                        ),
                        ProfileListTile(
                          leading: FontAwesomeIcons.creditCard,
                          title: 'My Cards',
                          onTap: () {
                            Navigator.of(context).pushNamed(MyCards.route);
                          },
                        ),
                        ProfileListTile(
                          leading: Icons.notifications,
                          title: 'Notification Settings',
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(NotificationSettings.route);
                          },
                        ),
                        ProfileListTile(
                          leading: Icons.lock,
                          title: 'Security & Password',
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(SecurityPassword.route);
                          },
                          badge: true,
                        ),
                        ProfileListTile(
                          leading: Icons.share,
                          title: 'Share Insuremart',
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ShareInsuremart.route);
                          },
                        ),
                        ProfileListTile(
                          leading: Icons.support_agent,
                          title: 'Help & Support',
                          onTap: () {
                            Navigator.of(context).pushNamed(HelpSupport.route);
                          },
                        ),
                        ProfileListTile(
                          leading: Icons.create,
                          title: 'About Us',
                          onTap: () {
                            Navigator.of(context).pushNamed(AboutUs.route);
                          },
                        ),
                        ProfileListTile(
                            leading: Icons.arrow_circle_down_outlined,
                            title: 'Logout',
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: const Text(
                                        "Are you sure you want to log out?",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "cancel",
                                              style: TextStyle(
                                                  color: InsuremartTheme.blue1),
                                            )),
                                        TextButton(
                                            onPressed: () async {
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: InsuremartTheme.blue1,
                                                ),
                                              );
                                              await FirebaseAuth.instance
                                                  .signOut();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Login()));
                                            },
                                            child: const Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: InsuremartTheme.blue1),
                                            )),
                                      ],
                                    );
                                  });
                            }

                            //_trySignout(context),
                            ),
                      ],
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}
