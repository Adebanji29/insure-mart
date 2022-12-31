import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../provider/insurance_provider.dart';
import '../../Backend models/insurance_model.dart';
import '../../widget/buttons.dart';
import '../../widget/boxes.dart';
import '../../utils/app_theme.dart';

class InsuranceDetail extends StatelessWidget {

  static const route = '/insuranceDetail';
  final InsuranceModel model;
  const InsuranceDetail({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    // final insuranceId = ModalRoute.of(context)!.settings.arguments as int;
    // final insurance = context.read<InsuranceProvider>().findById(insuranceId);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF6E27),
        foregroundColor: InsuremartTheme.white1,
        title: const Text('Insurance Details'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
        ],
      ),
      body: Container(
        color: const Color(0xffEA5B0C).withOpacity(.1),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox(
                height: 50,
                width: 60.65,
                child: Image.asset(model.carMakeImage.toString()),
              ),
              const CustomSizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    carDetail('Car Make', model.carmake.toString()),
                    const CustomSizedBox(width: 70),
                    carDetail('Car Model', model.carmodel.toString()),
                    const CustomSizedBox(width: 70),
                    carDetail('Car Year', '${model.carYear}', year: true),
                  ],
                ),
              ),
              const CustomSizedBox(height: 30),
              const Divider(),
              const CustomSizedBox(height: 30),
              Row(
                children: [
                  textSubtext('Class', model.insuranceClass.toString()),
                  const CustomSizedBox(width: 25),
                  textSubtext('Type', model.coverType.toString()),
                ],
              ),
              const CustomSizedBox(height: 30),
              const Divider(),
              const CustomSizedBox(height: 30),
              buildProvider(model.providerImage.toString(), model.providerName.toString()),
              const CustomSizedBox(height: 30),
              const Divider(),
              const CustomSizedBox(height: 30),
              textSubtext('Policy period', '${model.insurancePeriod} '),
              const CustomSizedBox(height: 20),
              Row(
                children: [
                  textSubtext('Purchase date', model.purchaceDate.toString().substring(0,10)),
                  const CustomSizedBox(width: 34),
                  textSubtext('Renewal date', model.renewalDate.toString()),
                ],
              ),
              const CustomSizedBox(height: 30),
              const Divider(),
              const CustomSizedBox(height: 30),
              premiumPaid(model.premiumPaid.toString()),
              const CustomSizedBox(height: 20),
              sumInsured('₦${model.sumInsured.toString()}'),
              const CustomSizedBox(height: 30),
              const Divider(),
              const CustomSizedBox(height: 30),
              Text(
                'Certificate & policy',
                style: InsuremartTheme.lightTextTheme.headline5!
                    .copyWith(fontSize: 12),
              ),
              const CustomSizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  certificate(
                    onTap: () {},
                    text: 'View Certificate',
                    size: size,
                  ),
                  certificate(
                    onTap: () {},
                    text: 'View Policy',
                    size: size,
                  ),
                ],
              ),
              const CustomSizedBox(height: 30),
              const Divider(),
              const CustomSizedBox(height: 30),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View endorsement',
                  style: InsuremartTheme.lightTextTheme.headline3!
                      .copyWith(fontSize: 14),
                ),
              ),
              const CustomSizedBox(height: 30),
              LongButton(
                title: 'REPORT CLAIM',
                onPressed: () {},
                color: const Color(0xffd6d6d6),
                textColor: InsuremartTheme.blue4,
              ),
              const CustomSizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }

  Container certificate({
    required GestureTapCallback onTap,
    required String text,
    required Size size,
  }) {
    return Container(
      alignment: AlignmentDirectional.center,
      height: size.height * (.00124 * 210),
      width: size.width * (.00264 * 157.5),
      decoration: BoxDecoration(
        color: InsuremartTheme.black4.withOpacity(.8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            Text(
              text,
              style: InsuremartTheme.lightTextTheme.headline3!
                  .copyWith(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Column sumInsured(String sum) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sum Insured',
            style: InsuremartTheme.lightTextTheme.headline5!
                .copyWith(fontSize: 12),
          ),
          const CustomSizedBox(height: 5),
          Text(
            sum,
            style: InsuremartTheme.lightTextTheme.headline2!
                .copyWith(fontSize: 14),
          ),
        ],
      );

  Column premiumPaid(String amount) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium Paid',
            style: InsuremartTheme.lightTextTheme.headline5!
                .copyWith(fontSize: 12),
          ),
          const CustomSizedBox(height: 5),
          Wrap(
            children: [
              Text(
                amount,
                style: InsuremartTheme.lightTextTheme.headline2!
                    .copyWith(fontSize: 14),
              ),
              Text(
                '/year',
                style: InsuremartTheme.lightTextTheme.bodyText2!
                    .copyWith(color: InsuremartTheme.black1.withOpacity(.5)),
              )
            ],
          )
        ],
      );

  Column buildProvider(String logo, String provider) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Provider',
            style: InsuremartTheme.lightTextTheme.headline5!
                .copyWith(fontSize: 12),
          ),
          const CustomSizedBox(height: 5),
          CustomSizedBox(
            height: 50,
            width: 50,
            child: Image.asset(logo),
          ),
          const CustomSizedBox(height: 5),
          Text(
            provider,
            style: InsuremartTheme.lightTextTheme.bodyText2,
          )
        ],
      );

  Column textSubtext(String title, String subtitle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: InsuremartTheme.lightTextTheme.headline5!
                .copyWith(fontSize: 12),
          ),
          const CustomSizedBox(height: 5),
          Text(
            subtitle,
            style: InsuremartTheme.lightTextTheme.bodyText2,
          ),
        ],
      );

  Column carDetail(
    String title,
    String subtitle, {
    bool year = false,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: InsuremartTheme.lightTextTheme.headline5!
                .copyWith(fontSize: 12),
          ),
          const CustomSizedBox(height: 5),
          Text(
            subtitle,
            style: !year
                ? InsuremartTheme.lightTextTheme.headline3!.copyWith(
                    fontSize: 12,
                    color: InsuremartTheme.green1,
                  )
                : InsuremartTheme.lightTextTheme.subtitle1,
          )
        ],
      );
}
