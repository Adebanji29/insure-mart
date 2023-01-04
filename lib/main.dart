import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insuremart_app/computation/computation.dart';
import 'package:insuremart_app/provider/flutterconnectivity.dart';
import 'package:insuremart_app/provider/user_provider.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './provider/app_state_manager.dart';
import './provider/card_provider.dart';
import './provider/claim_provider.dart';
import './provider/insurance_provider.dart';
import './provider/new_insurance_provider.dart';
import './provider/notification.dart';
import './screen/Auth/forget_password.dart';
import './screen/Auth/login.dart';
import './screen/Auth/signup.dart';
import './screen/claims/claim_discharge.dart';
import './screen/claims/new_claim.dart';
import './screen/claims/reject_claim.dart';
import './screen/home/new_insurance.dart';
import './screen/home/notifications.dart';
import './screen/insurance/insurance_detail.dart';
import './screen/insurance/renew_policy.dart';
import './screen/main_screen.dart';
import './screen/profile/about_us.dart';
import './screen/profile/bvn.dart';
import './screen/profile/change_password.dart';
import './screen/profile/connect_socials.dart';
import './screen/profile/edit_profile.dart';
import './screen/profile/help_support.dart';
import './screen/profile/id_verification.dart';
import './screen/profile/my_cards.dart';
import './screen/profile/next_of_kin.dart';
import './screen/profile/notification_setting.dart';
import './screen/profile/phone_number.dart';
import './screen/profile/security_password.dart';
import './screen/profile/share_insuremart.dart';
import './screen/profile/two_step_verification.dart';
import './screen/profile/utility_bills.dart';
import './utils/app_theme.dart';
import '../screen/home/request_hardcopy.dart';
import 'Backend models/insurance_model.dart';
import 'firebase_options.dart';
import 'global/global.dart';
import 'provider/new_claim_provider.dart';
import 'screen/home/home.dart';
import 'screen/onboarding/onboard.dart';
import 'screen/splashScreen/my_splash_screen.dart';
import 'service/auth_service.dart';
import 'service/user_service.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'insuremart',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPreferences = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //Firebase.initializeApp();
  ConnectionStatusSingleton connectionStatus =
  ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context) => Connectivity().onConnectivityChanged,
          initialData: "No Internet Connection",
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AppStateManager()),
        ChangeNotifierProvider(create: (_) => ClaimProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => CardProvider()),
        ChangeNotifierProvider(create: (_) => InsuranceProvider()),
        ChangeNotifierProvider(create: (_) => NewInsuranceManager()),
        ChangeNotifierProvider(create: (_)=> NewClaimProvider()),
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<UserService>(create: (_) => UserService()),
        FutureProvider(
            create: (_) => UserService().getUserDetails(), initialData: null)
        // StreamProvider<User?>.value(
        //   value: AuthService().authStateChanges,
        //   initialData: null,
        // )
      ],
      child: const MaterialApplication(),
    );
  }
}

class MaterialApplication extends StatelessWidget {
  const MaterialApplication({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InsuranceModel model= InsuranceModel(sumInsured: 0, step3Extensions: []);
    return MaterialApp(
      title: 'Insuremart',
      debugShowCheckedModeBanner: false,
      theme: InsuremartTheme.light(),
      home:
      MySplashScreen(),
      // VerifyScreen()
      // InfoPage(title: "",message: "",),
      routes: {
        OnBoard.route: (_) => const OnBoard(),
        Login.route: (_) => const Login(),
        ForgetPassword.route: (_) => const ForgetPassword(),
        SignUp.route: (_) => const SignUp(),
        Main.route: (_) => const Main(),
        Notifications.route: (_) => const Notifications(),
        NewInsurance.route: (_) =>  NewInsurance(myModel: model),
        RequestHardcopy.route: (_) => const RequestHardcopy(),
        ClaimDischarge.route: (_) => const ClaimDischarge(),
        NewClaim.route: (_) => const NewClaim(),
        RejectClaim.route: (_) => const RejectClaim(),
        EditProfile.route: (_) => const EditProfile(),
        ConnectSocials.route: (_) => const ConnectSocials(),
        MyCards.route: (_) => const MyCards(),
        NotificationSettings.route: (_) => const NotificationSettings(),
        SecurityPassword.route: (_) => const SecurityPassword(),
        ShareInsuremart.route: (_) => const ShareInsuremart(),
        HelpSupport.route: (_) => const HelpSupport(),
        AboutUs.route: (_) => const AboutUs(),
        Bvn.route: (_) => const Bvn(),
        IdVerification.route: (_) => const IdVerification(),
        UtilityBills.route: (_) => UtilityBills(),
        PhoneNumber.route: (_) => const PhoneNumber(),
        TwoStepVerification.route: (_) => const TwoStepVerification(),
        NextofKin.route: (_) => const NextofKin(),
        ChangePassword.route: (_) => const ChangePassword(),
        InsuranceDetail.route: (_) => InsuranceDetail(model: model,),
        RenewPolicy.route: (_) => const RenewPolicy(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.watch<AuthService>().authStateChanges,
      // initialData:  null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return const Main();
          return Login();
        } else {
          return const Login();
        }
      },
    );
  }
}
