import 'package:flutter/material.dart';
import 'package:insuremart_app/service/insurance_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/insurance.dart';
import './renew_policy.dart';
import './insurance_detail.dart';
import '../../widget/text_fields.dart';
import '../../widget/boxes.dart';
import '../../utils/app_theme.dart';

// how to get data from firebase firestore using future?
class MyInsurance extends StatefulWidget {
  const MyInsurance({Key? key}) : super(key: key);
  @override
  State<MyInsurance> createState() => _MyInsuranceState();
}

class _MyInsuranceState extends State<MyInsurance> {
  late Stream<List<Insurance>> streamData;
  final List<String> menuItem = [
    'Renew My Policy',
  ];

  @override
  void initState() {
    streamData = InsuranceService().insuranceList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final insurance = context.read<List<Insurance>>();

    var items = ['Car Insurance', 'Insurance'];
    String? value = items[0];
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Insurance'),
          centerTitle: false,
          titleSpacing: 20,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) => onMenuSelected(context, value),
              position: PopupMenuPosition.under,
              icon: const Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              itemBuilder: (_) => menuItem
                  .map(
                    (item) => PopupMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: InsuremartTheme.lightTextTheme.headline3,
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
        body: StreamBuilder<List<Insurance>>(
            stream: streamData,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      children: [
                        CustomDropDownButton(
                          items: items,
                          value: value,
                          onChanged: (val) {
                            setState(() {
                              value = val;
                            });
                          },
                        ),
                        const CustomSizedBox(height: 9.65),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: insurance.length,
                          itemBuilder: (context, index) {
                            final insure = insurance[index];
                            return InsuranceItem(
                              insurance: insure,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const CustomSizedBox(height: 20),
                        ),
                      ],
                    );
                  } else {
                    return const Text('No Insurance');
                  }
              }
            }
            // child:
            ),
      ),
    );
  }

  void onMenuSelected(BuildContext context, String value) {
    switch (value) {
      case 'Renew My Policy':
        Navigator.of(context).pushNamed(RenewPolicy.route);
        break;
      default:
    }
  }
}

class InsuranceItem extends StatelessWidget {
  const InsuranceItem({
    Key? key,
    required this.insurance,
  }) : super(key: key);
  final Insurance insurance;

  @override
  Widget build(BuildContext context) {
    // final insurance = context.read<Insurance>();
    var formatter = NumberFormat.decimalPattern('en_us');

    // insuranceModel.carmake == "Toyota"
    //     ? insuranceModel.carMakeImage = 'assets/images/toyota_logo.png'
    //     : insuranceModel.carMakeImage = 'assets/images/jeep.png';
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(15),
      // height: size.height * (.00124 * 450),
      decoration: BoxDecoration(
        color: InsuremartTheme.white4,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(insurance.carMakeImage),
          const CustomSizedBox(height: 25),
          Row(
            children: [
              carDetail('Car Make', insurance.carMake),
              const CustomSizedBox(width: 70),
              carDetail('Car Model', insurance.carModel),
            ],
          ),
          const CustomSizedBox(height: 25),
          // buildPolicy(insurance.policy),
          // const CustomSizedBox(height: 25),
          buildProvider(insurance.providerImage, insurance.provider),
          const CustomSizedBox(height: 25),
          Row(
            children: [
              textSubtext('Sum Insured', insurance.sumInsured, money: true),
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
          const CustomSizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button(
                  text: 'MORE DETAILS',
                  onPressed: () => Navigator.of(context).pushNamed(
                        InsuranceDetail.route,
                        arguments: insurance.id,
                      ),
                  size: size),
              button(
                  text: 'REPORT CLAIM',
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const NewClaim(),
                    //   ),
                    // );
                  },
                  size: size),
            ],
          )
        ],
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

  ElevatedButton button({
    required String text,
    required VoidCallback onPressed,
    required Size size,
  }) =>
      ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffD6D6D6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          minimumSize:
              Size(size.width * (.00265 * 147.5), size.height * (.00124 * 56)),
        ),
        child: Text(
          text,
          style: InsuremartTheme.lightTextTheme.button!.copyWith(
            color: InsuremartTheme.blue4,
          ),
        ),
      );
}
