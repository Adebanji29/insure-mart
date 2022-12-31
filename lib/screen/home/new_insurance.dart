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
import 'step_five.dart';
import 'step_four.dart';
import 'step_six.dart';
import 'step_three.dart';
import 'step_two.dart';

class NewInsurance extends StatefulWidget {
  InsuranceModel myModel;
  double summary;
  NewInsurance({required this.myModel, required this.summary});

  static const route = '/newInsurance';


  @override
  State<NewInsurance> createState() => _NewInsuranceState();
}

class _NewInsuranceState extends State<NewInsurance> {
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
          return Column(
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
                    StepSix(model:widget.myModel, summary: widget.summary,),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

List<String> make = ['toyota', 'bmw', 'bugati'];
