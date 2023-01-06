import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insuremart_app/screen/home/step_one.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';

import 'package:provider/provider.dart';
// import 'package:insuremart/widget/text_fields.dartimport '../../Backend models/insurance_model.dart';



import '../../Backend models/insurance_model.dart';
import '../../provider/new_insurance_provider.dart';
import '../../utils/app_theme.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import '../../widget/custom_progress_indicator.dart';
import '../Auth/login.dart';
import 'step_five.dart';
import 'step_four.dart';
import 'step_six.dart';
import 'step_three.dart';
import 'step_two.dart';

class NewInsurance extends StatefulWidget {
  InsuranceModel myModel;
  String? summary;


  NewInsurance({required this.myModel, this.summary});

  static const route = '/newInsurance';


  @override
  State<NewInsurance> createState() => _NewInsuranceState();
}

class _NewInsuranceState extends State<NewInsurance> {

  Timer? _rootTimer;
@override
  void initState() {
     initializeTimer();

    super.initState();
  }

  void initializeTimer() {
    if (_rootTimer != null) _rootTimer!.cancel();
    const time = const Duration(minutes: 10);
    _rootTimer = Timer(time, () {
      logOutUser();
    });
  }


  void logOutUser() async {
    // Log out the user if they're logged in, then cancel the timer.
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));

    _rootTimer?.cancel();
  }

  void _handleUserInteraction([_]) {
    if (_rootTimer != null && !_rootTimer!.isActive) {
      // This means the user has been logged out
      return;
    }
    _rootTimer?.cancel();

    initializeTimer();
  }


  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Car Insurance'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: Consumer<NewInsuranceManager>(builder: (context, insurance, _) {
          final step = insurance.currentStep + 1;
          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: _handleUserInteraction,
            onPointerMove: _handleUserInteraction,
            onPointerUp: _handleUserInteraction,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: AlignmentDirectional.topStart,
                  decoration: BoxDecoration(
                    color: insurance.currentStep == 4
                        ? InsuremartTheme.pink1
                        : InsuremartTheme.green2.withOpacity(.1),
                  ),
                  child: Column(
                    children: [
                      CustomLinearProgressIndicator(
                        max: 6,
                        current: step.toDouble(),
                        color: insurance.currentStep == 4
                            ? InsuremartTheme.pink2
                            : InsuremartTheme.blue1,
                        notleft: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Step $step 0f 6',
                                  style: InsuremartTheme.lightTextTheme.subtitle1!
                                      .copyWith(
                                    color: InsuremartTheme.black1.withOpacity(.5),
                                  ),
                                ),
                                const CustomSizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      insurance.stepTitle(),
                                      style: InsuremartTheme
                                          .lightTextTheme.bodyText1!
                                          .copyWith(fontSize: 14),
                                    ),
                                    if (insurance.currentStep == 1)
                                      Text(
                                        '(optional)',
                                        style: InsuremartTheme
                                            .lightTextTheme.subtitle1!
                                            .copyWith(
                                          color: InsuremartTheme.black1
                                              .withOpacity(.5),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                switchPageBtn(
                                  Icons.arrow_back_ios,
                                  insurance.previousStep,
                                  color: insurance.currentStep == 4
                                      ? InsuremartTheme.pink2
                                      : null,
                                ),
                                const CustomSizedBox(width: 30),
                                switchPageBtn(
                                  Icons.arrow_forward_ios,
                                  insurance.nextStep,
                                  color: insurance.currentStep == 4
                                      ? InsuremartTheme.pink2
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: insurance.currentStep,
                    children:  [
                      StepOne(model:widget.myModel),
                      StepTwo(model: widget.myModel,),
                      StepThree(model: widget.myModel,),
                      StepFour(model: widget.myModel),
                      StepFive(model:widget.myModel,),
                      StepSix(model:widget.myModel,summary: widget.summary.toString(),),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

List<String> make = ['toyota', 'bmw', 'bugati'];
