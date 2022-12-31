import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/app_state_manager.dart';
import '../utils/app_theme.dart';
import './insurance/insurance.dart';
import './claims/claims.dart';
import './profile/profile.dart';
import 'home/home.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  static const route = '/main';

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  static List<Widget> screens = const [
    Home(),
    MyInsurance(),
    MyClaims(),
    Profile(),
  ];
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  void checkInternetConnection() async {
    // bool ActiveConnection = false;
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     setState(() {
    //       ActiveConnection = true;
    //       T = "Turn off the data and repress again";
    //     });
    //   }
    // } on SocketException catch (_) {
    //   setState(() {
    //     ActiveConnection = false;
    //     T = "Turn On the data and repress again";
    // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final readTab = context.read<AppStateManager>();
    final watchTab = context.watch<AppStateManager>();
    return Scaffold(
      body: IndexedStack(
        index: watchTab.getSelectedTab,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: watchTab.getSelectedTab,
        onTap: (index) => readTab.goToTab(index),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        showUnselectedLabels: true,
        selectedLabelStyle:
            InsuremartTheme.lightTextTheme.headline2!.copyWith(fontSize: 9),
        unselectedLabelStyle:
            InsuremartTheme.lightTextTheme.headline2!.copyWith(fontSize: 9),
        selectedItemColor: InsuremartTheme.green1,
        unselectedItemColor: InsuremartTheme.black1.withOpacity(.5),
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user), label: 'My Insurance'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'My Claims'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
