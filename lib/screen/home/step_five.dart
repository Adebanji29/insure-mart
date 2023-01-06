import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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




  StepFive({required this.model });

  @override
  State<StepFive> createState() => _StepFiveState();
}

class _StepFiveState extends State<StepFive> {
  late Computation computation;

  double sumInsured=0;
  double basicPremium= 0;
  double ebb =0;
  double flood=0;
  double srcc=0;
  double tpd=0;
  String summary="";

  getPremium(){
    final ref = context.read<NewInsuranceManager>();
    Navigator.push(context,MaterialPageRoute(builder: (context)=> NewInsurance(
      myModel: widget.model,
      summary:summary,
    ) ));

    ref.nextStep();
  }



@override
  void initState() {
  computation=Computation(model: widget.model);
  computation.getVehicleLicence();
    computation.getHackneyPermit();
    computation.getRoadWorthiness();
    computation.getClassOfInsurane();
    // computation.getThirdPartyInsuranceCost();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
var formatter= NumberFormat('#,##,000');
  var vlc= computation.getVlc;
   var rrw= computation.getRRW;
   var hp=computation.getHP;

  double rdPartyCost= 3000000.00;

   widget.model.sumInsured== 0? sumInsured=0: sumInsured= widget.model.sumInsured;
     basicPremium= (0.02 * sumInsured);


    widget.model.step3Extensions.toString().contains("ebb")?   ebb= (0.005* sumInsured):ebb= 0;
    widget.model.step3Extensions.toString().contains("flood")? flood= (0.005* sumInsured):flood= 0;
    widget.model.step3Extensions.toString().contains("srcc")?   srcc= (0.005* sumInsured):srcc= 0;
    // model.step3Extensions.toString().contains("atp")?   tpd= 5000:tpd= 0;
    widget.model.atp==null? tpd=0: tpd= double.parse(widget.model.atp.toString().replaceAll(RegExp('[^0-9.]'), ''));


     widget.model.coverType.toString().contains('party')? summary= (rdPartyCost+vlc+ rrw+ hp).toString():summary= (basicPremium+ebb+flood+srcc+tpd+vlc+ rrw+ hp).toString();


    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 64),
      children: [
        Container(
          child: widget.model.providerName.toString().contains("Cornerstone")?
          Image.asset("assets/images/cnimg.png"):Image.asset("assets/images/alimg.jpg"),
          height: 72,
          color: InsuremartTheme.pink1,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              widget.model.coverType.toString().contains('party')?Container():buildRow('Sum Insured', '₦${widget.model.sumInsured.toString()}'),
              const SizedBox(height: 20),
              buildRow('Period of Insurance', widget.model.insurancePeriod.toString()),
              const SizedBox(height: 20),
               buildRow('Basic Premuim',  widget.model.coverType.toString().contains('party')? '₦${rdPartyCost}':'₦${basicPremium.toString()}'),
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
              widget.model.step3Extensions.toString().contains("ebb")?   addOnsRow('Excess buy back', '₦${ebb.toString()}') : Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("flood")?  addOnsRow('Flood Extension',  '₦${flood.toString()}' ):Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("srcc")? addOnsRow('SRCC',  '₦${srcc.toString()}'):Container(),
              const SizedBox(height: 10),
              widget.model.atp != null? addOnsRow('Third Party Property Damage',  '₦${tpd.toString()}'):Container(),
              const SizedBox(height: 10),
              vlc != 0? addOnsRow('Vehicle Licence',  '₦${vlc}'):Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("rrw")? addOnsRow('Road Worthiness',  '₦${rrw}'):Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("rhp")? addOnsRow('Hackney Permit',  '₦${hp}'):Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("vtd")? addOnsRow('Vehicle Tracking Device',  '₦0'):Container(),
              const SizedBox(height: 10),
              widget.model.step3Extensions.toString().contains("rtd")? addOnsRow('Install/Renew Tracking Device',  '₦0'):Container(),
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
                    '₦${summary}',
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
               widget.model.coverType.toString().contains("party")?
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   benefitText(
                     1,
                     "Accidental damage to third party's properties up to a limit of ₦1,000,000.00",
                   ),
                   benefitText(
                     2,
                     'ECOWAS brown card coverage to other West African countries',
                   ),
                 ],
               ):Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    benefitText(
                      1,
                      'Accidental damage to own vehicle to the limit of the sum insured, i.e value of the vehicle',
                    ),
                    benefitText(
                      2,
                      'Loss as a result of fire or theft',
                    ),
                    benefitText(
                      3,
                      "Accidental damage to third party's properties up to a limit of ₦1,000,000.00",
                    ),
                    benefitText(
                      4,
                      'Total and partial disability coverage in the event of an accident, up to a limit of ₦1,000,000.00',
                    ),
                    benefitText(
                      5,
                      'Medical expenses in the event of an accident up to a limit of ₦1,000,000.00',
                    )

                // Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // children: [
                //   benefitText(
                //     1,
                //     'Accidental damage to own vehicle. ',
                //   ),
                //   benefitText(
                //     2,
                //     'Loss/damage to own vehicle by fire or theft. ',
                //   ),
                //   benefitText(
                //     3,
                //     'Covers damage to another’s property up to N1 million naira. ',
                //   ),
                //   benefitText(
                //     4,
                //     'Accidental total and permanent disability to the insured to a limit of ₦1,000,000.00 ',
                //   ),
                //   benefitText(
                //     5,
                //     'We cover your medical expense including that of other vehicle’s passenger(s) to a limit of ₦100,000.00 in the event of a hospitalization due to accident.',
                //   )
                  ],
                ),
              ),
              const SizedBox(height: 17),
              LongButton(
                title: 'CONTINUE',
                onPressed: (){
                  getPremium();
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
