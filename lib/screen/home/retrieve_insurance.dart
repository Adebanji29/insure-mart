import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/new_insurance_provider.dart';
import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';
import '../../widget/custom_progress_indicator.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

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
        body: Consumer<RetrieveInsuranceManager>(
            builder: (context, insurance, _) {
          final step = insurance.currentStep + 1;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: AlignmentDirectional.topStart,
                decoration: BoxDecoration(
                  color: InsuremartTheme.green2.withOpacity(.1),
                ),
                child: Column(
                  children: [
                    CustomLinearProgressIndicator(
                      max: 6,
                      current: step.toDouble(),
                      color: InsuremartTheme.blue1,
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
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    insurance.currentStep == 0
                                        ? 'Choose Insurance'
                                        : 'Insurance Details',
                                    style: InsuremartTheme
                                        .lightTextTheme.bodyText1!
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              switchPageBtn(
                                Icons.arrow_back_ios,
                                () => insurance.gotoStep(0),
                              ),
                              const SizedBox(width: 30),
                              switchPageBtn(
                                Icons.arrow_forward_ios,
                                () => insurance.gotoStep(1),
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
                  children: const [],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
