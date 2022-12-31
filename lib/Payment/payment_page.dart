import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';

import '../Backend models/insurance_model.dart';
import '../Backend models/cardModel.dart';
import '../Constant/key.dart';
import '../provider/insurance_provider.dart';
import '../provider/new_insurance_provider.dart';
import '../screen/home/request_hardcopy.dart';
import '../screen/main_screen.dart';
import '../utils/app_theme.dart';
import '../widget/buttons.dart';

class MakePayment{
  InsuranceModel insurancemodel;
  CardModel cardModel;
  BuildContext context;
  String email;
  int price;
  PaystackPlugin _paystack= PaystackPlugin();
  MakePayment({required this.context, required this.email, required this.price, required this.cardModel, required this.insurancemodel});



  String getReference(){
    String platform;
    if(Platform.isIOS){
      platform= "iOS";
    }
    else
    {platform= "Android";}

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard getCardUI(){
    return PaymentCard(
        number:cardModel.cardNumber,
        cvc: cardModel.cardCVV,
        expiryMonth: 0,
        expiryYear: 0);
  }

  Future initializeplugin() async{
    await _paystack.initialize(publicKey: ConstantKey.PAYSTACK_KEY);
  }

  chargeCardAndMakePayment() async{

    initializeplugin().then((_) async {
      Charge charge= Charge()
        ..amount= price*100
        ..email= email
        ..reference= getReference()
        ..card= getCardUI();

      CheckoutResponse response= await _paystack.checkout(
          context,
          charge:charge,
          method: CheckoutMethod.card,
          fullscreen: false,
          logo: FlutterLogo(
            size: 24,
          ));
      print('Response $response');
      if(response.status == true){
        print("Transaction successful");
        InsuranceProvider insuranceProvider= Provider.of<InsuranceProvider>(context, listen: false);
        insuranceProvider.saveNewInsuranceInfo(insurancemodel,context);

        final ref = context.read<NewInsuranceManager>();
        showModalBottomSheet(
            enableDrag: false,
            backgroundColor: InsuremartTheme.white1.withOpacity(.9),
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/insured.png'),
                  const SizedBox(height: 20),
                  Text(
                    'Your Car Is Insured!',
                    style: InsuremartTheme.lightTextTheme.headline2!.copyWith(
                      fontSize: 24,
                      color: InsuremartTheme.blue1,
                    ),
                  ),
                  Text(
                    'Order number: ${insurancemodel.purchaseId.toString()}',
                    style: InsuremartTheme.lightTextTheme.bodyText2!.copyWith(
                      fontSize: 13,
                      color: InsuremartTheme.black4.withOpacity(.5),
                    ),
                  ),
                  const SizedBox(height: 50),
                  LongButton(title: 'VIEW CERTIFICATE', onPressed: () {}),
                  const SizedBox(height: 15),
                  LongButton(title: 'VIEW POLICY DOCUMENT', onPressed: () {}),
                  const SizedBox(height: 15),
                  LongButton(
                    title: 'REQUEST FOR HARD COPY',
                    onPressed: () {
                      ref.gotoStep(0);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(RequestHardcopy.route);
                    },
                  ),
                  const SizedBox(height: 15),
                  LongButton(
                    title: 'BUY ANOTHER ONE',
                    onPressed: () {
                      ref.gotoStep(0);
                      Navigator.of(context).pop();
                    },
                    isBorder: true,
                    color: InsuremartTheme.white1,
                    textColor: InsuremartTheme.blue2,
                  ),
                  const SizedBox(height: 15),
                  LongButton(
                    title: 'GO HOME',
                    onPressed: () {
                      ref.gotoStep(0);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    isBorder: true,
                    color: InsuremartTheme.white1,
                    textColor: InsuremartTheme.blue2,
                  ),
                ],
              ),
            ));
        //



      }
      else{
        print ("Transaction failed");
        showDialog(context: context, builder:(context) =>
            AlertDialog(
              content: Text(
                  "Transaction failed"
              ),
            ));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Main()));


      }
    }
    );

  }

}