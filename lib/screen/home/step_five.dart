import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Backend models/insurance_model.dart';
import '../../computation/computation.dart';
import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';
import '../../provider/new_insurance_provider.dart';
import '../../widget/certificate_policy.dart';
import 'new_insurance.dart';
// import '../../widget/text_fields.dart';

class StepFive extends StatefulWidget {
  InsuranceModel model;
  double? ebb;
  double? flood;
  double? srcc;
  double? tpd;


  StepFive({required this.model, this.ebb, this.flood, this.srcc, this.tpd, });

  @override
  State<StepFive> createState() => _StepFiveState();
}

class _StepFiveState extends State<StepFive> {
  Computation? computation;
  double sumInsured=0;




  @override
  void initState() {
    computation=Computation(model: widget.model);
    computation!.getVehicleLicence();
    computation!.getRoadWorthinessLicence();
    computation!.getHackneyPermit();
    super.initState();
  }


  sendTotalPremium(BuildContext context){
    final ref = context.read<NewInsuranceManager>();
    Navigator.push(context,MaterialPageRoute(builder: (context)=> NewInsurance(
      myModel: widget.model,
      summary: double.parse(widget.model.premiumPaid!),
    ) ));
    ref.nextStep();
  }

  @override
  Widget build(BuildContext context) {
    widget.model.sumInsured== 0? sumInsured=0: sumInsured= widget.model.sumInsured;
    double basicpremium= (0.02 * sumInsured);


    widget.model.step3Extensions.toString().contains("ebb")?   widget.ebb= (0.005* sumInsured):widget.ebb= 0;
    widget.model.step3Extensions.toString().contains("flood")? widget.flood= (0.005* sumInsured):widget.flood= 0;
    widget.model.step3Extensions.toString().contains("srcc")?   widget.srcc= (0.005* sumInsured):widget.srcc= 0;
    // model.step3Extensions.toString().contains("atp")?   tpd= 5000:tpd= 0;
    widget.model.atp==null? widget.tpd=0: widget.tpd= double.parse(widget.model.atp.toString().replaceAll(RegExp('[^0-9.]'), ''));


    widget.model.premiumPaid= (basicpremium+widget.ebb!+widget.flood!+widget.srcc!+widget.tpd!+computation!.getVlc+ computation!.getRRW+ computation!.getHP).toString();

    final ref = context.read<NewInsuranceManager>();
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 64),
      children: [
        Container(
          height: 72,
          color: InsuremartTheme.pink1,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildRow('Sum Insured', '₦${widget.model.sumInsured.toString()}'),
              const SizedBox(height: 20),
              buildRow('Period of Insurance', widget.model.insurancePeriod.toString()),
              const SizedBox(height: 20),
              buildRow('Basic Premuim', '₦${basicpremium.toString()}'),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              Text(
                'Add-Ons',
                style: InsuremartTheme.lightTextTheme.headline3!
                    .copyWith(fontSize: 12, color: InsuremartTheme.pink2),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("ebb")?   addOnsRow('Excess buy back', '₦${widget.ebb.toString()}') : Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("flood")?  addOnsRow('Flood Extension',  '₦${widget.flood.toString()}' ):Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("srcc")? addOnsRow('SRCC',  '₦${widget.srcc.toString()}'):Container(),
              const SizedBox(height: 10),
              widget.model.atp != null? addOnsRow('Third Party Property Damage',  '₦${widget.tpd.toString()}'):Container(),
              const SizedBox(height: 10),
              computation!.getVlc != 0? addOnsRow('Vehicle Licence',  '₦${computation!.getVlc}'):Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("rrw")? addOnsRow('Road Worthiness',  '₦${computation!.getRRW}'):Container(),

              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("rhp")? addOnsRow('Hackney Permit',  '₦${computation!.getHP}'):Container(),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              buildRow('Discounts', 'Nill'),
              const SizedBox(height: 20),
              buildRow('Promo', 'Nill'),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total Premuim',
                    style: InsuremartTheme.lightTextTheme.bodyText2!
                        .copyWith(color: InsuremartTheme.black4),
                  ),
                  Text(
                    '₦${widget.model.premiumPaid}',
                    style: InsuremartTheme.lightTextTheme.headline2!
                        .copyWith(color: InsuremartTheme.blue1),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              // stepFiveExpansion(
              //     'Certificate And Policy Document',
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         CertificatePolicy(
              //           onTap: () {},
              //           imageUrl: 'assets/images/screenshot.png',
              //           title: 'Motor insurance certificate',
              //         ),
              //         CertificatePolicy(
              //           onTap: () {},
              //           imageUrl: 'assets/images/screenshot.png',
              //           title: ' Motor insurance policy document',
              //         ),
              //       ],
              //     )),
              // const SizedBox(height: 13),
              // stepFiveExpansion(
              //   'Other Similar packages',
              //   ListView.separated(
              //     shrinkWrap: true,
              //     primary: false,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: 2,
              //     itemBuilder: (_, index) => Container(
              //       padding: const EdgeInsets.all(15),
              //       decoration: BoxDecoration(
              //         color: InsuremartTheme.white1,
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   text('Covers', '4 Cars'),
              //                   const SizedBox(height: 20),
              //                   text('Add-ons', '4 Add-ons'),
              //                 ],
              //               ),
              //               const SizedBox(width: 52),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   text('Period of Insurance', '12 Months'),
              //                   const SizedBox(height: 20),
              //                   text(
              //                     'Price',
              //                     '₦195,800',
              //                     color: InsuremartTheme.green1,
              //                     fontWeight: FontWeight.w700,
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //           const SizedBox(height: 20),
              //           LongButton(
              //             title: 'SELECT THIS',
              //             onPressed: () {},
              //             color: InsuremartTheme.pink2,
              //             textColor: InsuremartTheme.white1,
              //             height: 48,
              //           )
              //         ],
              //       ),
              //     ),
              //     separatorBuilder: (_, __) => const SizedBox(height: 15),
              //   ),
              // ),
              // const SizedBox(height: 13),
              stepFiveExpansion(
                'Benefits',
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    benefitText(
                      1,
                      'Accidental damage to own vehicle. ',
                    ),
                    benefitText(
                      2,
                      'Loss/damage to own vehicle by fire or theft. ',
                    ),
                    benefitText(
                      3,
                      'Covers damage to another’s property up to N1 million naira. ',
                    ),
                    benefitText(
                      4,
                      'Accidental total and permanent disability to the insured to a limit of ₦1,000,000.00 ',
                    ),
                    benefitText(
                      5,
                      'We cover your medical expense including that of other vehicle’s passenger(s) to a limit of ₦100,000.00 in the event of a hospitalization due to accident.',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 17),
              LongButton(
                title: 'CONTINUE',
                onPressed: (){
                  sendTotalPremium(context);
                },

                color: InsuremartTheme.pink2,
              ),
            ],
          ),
        )
      ],
    );
  }

  Column text(
      String text,
      String subtext, {
        Color color = InsuremartTheme.black1,
        FontWeight? fontWeight,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: InsuremartTheme.lightTextTheme.headline5,
        ),
        const SizedBox(height: 5),
        Text(
          subtext,
          style: InsuremartTheme.lightTextTheme.subtitle1!.copyWith(
            color: color,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }

  Widget benefitText(int number, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$number. '),
        Expanded(
          child: Text(
            text,
            style: InsuremartTheme.lightTextTheme.subtitle1,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  ClipRRect stepFiveExpansion(String title, Widget children) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          childrenPadding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 15,
            top: 0,
          ),
          backgroundColor: const Color(0xfff6f4f4),
          collapsedBackgroundColor: const Color(0xfff6f4f4),
          textColor: InsuremartTheme.pink2,
          collapsedTextColor: InsuremartTheme.black1,
          iconColor: InsuremartTheme.pink2,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          children: [children],
        ),
      ),
    );
  }

  Row addOnsRow(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: InsuremartTheme.lightTextTheme.bodyText2!
              .copyWith(color: InsuremartTheme.black4),
        ),
        Text(
          subTitle,
          style:
          InsuremartTheme.lightTextTheme.bodyText2!.copyWith(fontSize: 13),
        ),
      ],
    );
  }

  Row buildRow(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: InsuremartTheme.lightTextTheme.headline3!
              .copyWith(fontSize: 12, color: InsuremartTheme.pink2),
        ),
        Text(
          subTitle,
          style: InsuremartTheme.lightTextTheme.bodyText2!
              .copyWith(color: InsuremartTheme.black4),
        ),
      ],
    );
  }
}
