import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/insurance.dart';
import '../../provider/insurance_provider.dart';
import '../../utils/app_theme.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';

class RenewPolicy extends StatelessWidget {
  const RenewPolicy({Key? key}) : super(key: key);
  static const route = '/renewPolicy';

  @override
  Widget build(BuildContext context) {
    final insurance = context.read<InsuranceProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Renew Policies'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
      body: insurance.item.isNotEmpty
          ? ListView(
        primary: true,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 49),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemCount: insurance.item.length,
            itemBuilder: (context, index) {
              var insure = insurance.item[index];
              return ChangeNotifierProvider.value(
                value: insure,
                child: const RenewPolicyItem(),
              );
            },
            separatorBuilder: (_, __) => const CustomSizedBox(height: 20),
          ),
          const CustomSizedBox(height: 29),
          Consumer<InsuranceProvider>(builder: (context, insurance, _) {
            return LongButton(
              onPressed: insurance.isSelected
                  ? () => showModalBottomSheet(
                context: context,
                builder: (context) =>
                    buildButtomSheet(context, insurance),
              )
                  : null,
              title: 'Renew',
            );
          }),
        ],
      )
          : const EmptyPolicy(),
    );
  }

  Widget buildButtomSheet(BuildContext context, InsuranceProvider insure) =>
      Padding(
        padding:
        const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 44),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  iconSize: 20,
                  icon: const Icon(Icons.close),
                ),
                const CustomSizedBox(width: 50),
                Text(
                  'Renew ${insure.showSelected().length} Policies',
                  style: InsuremartTheme.lightTextTheme.headline2!
                      .copyWith(fontSize: 18),
                )
              ],
            ),
            Text(
              'Are you sure you want to renew ${insure.showSelected().length}\nexpired policies?',
              style: InsuremartTheme.lightTextTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            const CustomSizedBox(height: 25),
            LongButton(title: 'YES, RENEW', onPressed: () {}),
            const CustomSizedBox(height: 15),
            LongButton(
              title: 'NO, DO NOT RENEW',
              color: InsuremartTheme.white1,
              textColor: InsuremartTheme.blue4,
              isBorder: true,
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
}

class EmptyPolicy extends StatelessWidget {
  const EmptyPolicy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 49, top: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty.png'),
              const CustomSizedBox(height: 38.35),
              Text(
                'You have no policies to renew.\nYou can first retrive your policies',
                style: InsuremartTheme.lightTextTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              const CustomSizedBox(height: 20),
              Text(
                'Retrive Your Policy',
                style: InsuremartTheme.lightTextTheme.button!.copyWith(
                  color: InsuremartTheme.blue2,
                ),
              ),
            ],
          ),
          const LongButton(title: 'Renew', onPressed: null),
        ],
      ),
    );
  }
}

class RenewPolicyItem extends StatelessWidget {
  const RenewPolicyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insurancew = context.watch<Insurance>();
    final insurance = context.read<Insurance>();
    final insure = context.read<InsuranceProvider>();
    return GestureDetector(
      onTap: () {
        insurance.toggleSelected();
        insure.isSelect();
      },
      child: Container(
        alignment: AlignmentDirectional.topStart,
        padding:
        const EdgeInsets.only(left: 15, bottom: 15, top: 15.75, right: 15),
        decoration: BoxDecoration(
          color: InsuremartTheme.white4,
          borderRadius: BorderRadius.circular(10),
          border: insurancew.selected
              ? Border.all(
            color: InsuremartTheme.green1,
            width: 3,
          )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  insurancew.selected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: insurance.selected
                      ? InsuremartTheme.blue2
                      : const Color(0xff808080),
                  size: 22.5,
                ),
                const CustomSizedBox(height: 43.75),
                CustomSizedBox(
                  height: 50,
                  width: 60.65,
                  child: Image.asset(insurance.carMakeImage),
                ),
                const CustomSizedBox(height: 21),
                Row(
                  children: [
                    carDetail('Car Make', insurance.carMake),
                    const CustomSizedBox(width: 70),
                    carDetail('Car Model', insurance.carModel),
                  ],
                ),
                const CustomSizedBox(height: 25),
                buildPolicy(insurance.policy),
                const CustomSizedBox(height: 25),
                buildProvider(insurance.providerImage, insurance.provider),
                const CustomSizedBox(height: 25),
                Row(
                  children: [
                    textSubtext('Sum Insured', insurance.sumInsured,
                        money: true),
                    const CustomSizedBox(width: 30),
                    textSubtext('Expiry Date', insurance.expDate),
                  ],
                ),
                const CustomSizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textSubtext(
                      'Registration N0.',
                      '*****${insurance.regNum.substring(insurance.regNum.length - 4)}',
                    ),
                    textSubtext(
                      'Chassis N0.',
                      '*****${insurance.chassisNum.substring(insurance.chassisNum.length - 4)}',
                    ),
                    textSubtext(
                      'Engine N0.',
                      '*****${insurance.engineNum.substring(insurance.engineNum.length - 4)}',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column carDetail(String title, String subtitle) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: InsuremartTheme.lightTextTheme.headline5,
      ),
      const CustomSizedBox(height: 5),
      Text(
        subtitle,
        style: InsuremartTheme.lightTextTheme.headline3!.copyWith(
          fontSize: 12,
          color: InsuremartTheme.green1,
        ),
      )
    ],
  );

  Column buildPolicy(String policy) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        'Policy',
        style: InsuremartTheme.lightTextTheme.headline5,
      ),
      const CustomSizedBox(height: 5),
      Text(
        policy,
        style: InsuremartTheme.lightTextTheme.headline3!
            .copyWith(fontSize: 12),
      ),
    ],
  );

  Column buildProvider(String logo, String provider) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Provider',
        style: InsuremartTheme.lightTextTheme.headline5,
      ),
      const CustomSizedBox(height: 5),
      Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(logo),
          ),
          const SizedBox(width: 5),
          Text(
            provider,
            style: InsuremartTheme.lightTextTheme.bodyText2!
                .copyWith(fontSize: 12),
          ),
        ],
      )
    ],
  );

  Column textSubtext(String title, String subtitle, {bool money = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: InsuremartTheme.lightTextTheme.headline5,
        ),
        const CustomSizedBox(height: 5),
        Text(
          subtitle,
          style: money
              ? InsuremartTheme.lightTextTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xff4F4F4F),
          )
              : InsuremartTheme.lightTextTheme.subtitle1,
        ),
      ],
    );
  }
}
