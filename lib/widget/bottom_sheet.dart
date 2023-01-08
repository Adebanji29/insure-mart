import 'package:flutter/material.dart';
import 'package:insuremart_app/screen/insurance/insurance.dart';
import 'package:provider/provider.dart';

import '../provider/app_state_manager.dart';
import '../provider/new_insurance_provider.dart';
import '../screen/home/new_insurance.dart';
import '../screen/insurance/renew_policy.dart';
import '../utils/app_theme.dart';
import 'boxes.dart';
import 'buttons.dart';

Future<dynamic> carBottomSheet(BuildContext context) {
  final insure = context.read<NewInsuranceManager>();
  return showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 44),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
              const CustomSizedBox(width: 70),
              Text(
                'Car Insurance',
                style: InsuremartTheme.lightTextTheme.headline2!
                    .copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              )
            ],
          ),
          const CustomSizedBox(height: 23),
          LongButton(
            title: 'NEW CAR INSURANCE',
            onPressed: () {
              insure.clearStep3Extensions();
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(NewInsurance.route);
            },
          ),
          const CustomSizedBox(height: 10),
          LongButton(
              title: 'RENEW EXISTING INSURANCE',
              onPressed: () {
                Navigator.of(context).pushNamed(RenewPolicy.route);
                context.read<AppStateManager>().goToTab(1);
              }),
          // const CustomSizedBox(height: 10),
          // LongButton(
          //     title: 'GET A PREMIUM QUOTATION',
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     }),
        ],
      ),
    ),
  );
}
