import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/app_theme.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';

class ShareInsuremart extends StatefulWidget {
  const ShareInsuremart({Key? key}) : super(key: key);
  static const route = 'shareInsuremart';

  @override
  State<ShareInsuremart> createState() => _ShareInsuremartState();
}

class _ShareInsuremartState extends State<ShareInsuremart> {
  late TextEditingController _phoneNumber;
  @override
  void initState() {
    _phoneNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Share Insuremart'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  InsuremartTheme.blue4,
                  InsuremartTheme.blue2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const CustomSizedBox(height: 30, width: 74.47),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialButton(
                      title: 'Copy Link',
                      icon: Icons.link,
                      color: InsuremartTheme.white1.withOpacity(.2),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 45),
                    socialButton(
                      title: 'Share',
                      icon: Icons.ios_share,
                      color: InsuremartTheme.white1.withOpacity(.2),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 45),
                    socialButton(
                      title: 'Whatsapp',
                      icon: Icons.whatsapp,
                      iconSize: 30,
                      color: const Color(0xff1BD741),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialButton(
                      title: 'Facebook',
                      icon: FontAwesomeIcons.facebook,
                      iconSize: 26,
                      color: const Color(0xff0B6CFF),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 45),
                    socialButton(
                      title: 'Twitter',
                      icon: FontAwesomeIcons.twitter,
                      iconSize: 25,
                      color: const Color(0xff28A2FE),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 45),
                    socialButton(
                      title: 'Instagram',
                      icon: FontAwesomeIcons.instagram,
                      iconSize: 30,
                      gradient: true,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Phone Number to invite',
                        style: InsuremartTheme.lightTextTheme.bodyText1!
                            .copyWith(color: InsuremartTheme.white1),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      phoneFrom(),
                      const SizedBox(height: 26),
                      LongButton(
                        title: 'Invite',
                        onPressed: () {},
                        color: InsuremartTheme.green2,
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(height: 106),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/share-friends.png'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton({
    required IconData icon,
    required String title,
    required GestureTapCallback onPressed,
    Color? color,
    double? iconSize,
    bool gradient = false,
  }) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !gradient ? color : null,
            gradient: gradient
                ? const LinearGradient(
                    colors: [
                      Color(0xffC837AB),
                      Color(0xffFF543E),
                      Color(0xffFFDD55),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )
                : null,
          ),
          child: IconButton(
            onPressed: onPressed,
            color: InsuremartTheme.white1,
            iconSize: iconSize,
            icon: Icon(icon),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
            color: InsuremartTheme.white1,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  SizedBox phoneFrom() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: _phoneNumber,
        cursorColor: InsuremartTheme.blue2,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          label: Text(
            'Phone number',
            style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w400,
                color: InsuremartTheme.black1.withOpacity(.5)),
          ),
          suffixIcon: const Icon(Icons.contacts),
          filled: true,
          fillColor: InsuremartTheme.white1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: InsuremartTheme.white3,
            ),
          ),
        ),
      ),
    );
  }
}
