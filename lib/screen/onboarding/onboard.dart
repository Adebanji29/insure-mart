import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import '../main_screen.dart';
import '../Auth/login.dart';
import './onboarding_model.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);
  static const route = '/onboard';

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("onBoard", isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xff03588C),
          Color(0xff213267),
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                _storeOnBoardInfo();
                Navigator.of(context).pushReplacementNamed(Login.route);
              },
              child: const Text("Skip",
                  style: TextStyle(
                      color: Color(0xff03A688),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Raleway")),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            // physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Image.asset(screens[index].img,
                      height: 329.24, width: 274.18),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Raleway"),
                  ),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: "Raleway"),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    height: 10.0,
                    child: ListView.builder(
                        itemCount: screens.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  width: currentIndex == index ? 25.0 : 8.0,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            ],
                          );
                        }),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  InkWell(
                    onTap: () async {
                      if (index == screens.length - 1) {
                      final contex = Navigator.of(context);
                        await _storeOnBoardInfo();
                        contex.pushReplacementNamed(Login.route);
                      }
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceIn);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(screens[index].bttext,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Raleway",
                                color: Color(0xff213267),
                              )),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.05)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
