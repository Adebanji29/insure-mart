import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

import '../../Backend models/insurance_model.dart';
import '../../provider/new_insurance_provider.dart';
import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';
import '../../widget/save_bottom_sheet.dart';
import 'new_insurance.dart';

class StepFour extends StatefulWidget {
  InsuranceModel model;
  StepFour({required this.model});

  @override
  State<StepFour> createState() => _StepFourState();
}

class _StepFourState extends State<StepFour> {
  final List<String> sortBy = [
    'Best Matched',
    'Price: Highest to Lowest',
    'Price: Lowest to Highest',
    'Policy Term: Lowest to Highest',
    'Cover: Lowest to Highest',
  ];
  String? selectedValue;
  var _selectedIndex;
  String? selectedProviderName;
  String? selectedProviderImage;

  @override
  Widget build(BuildContext context) {
    final ref = context.read<NewInsuranceManager>();
    return ListView(
      padding: const EdgeInsets.only(
        // left: 20,
        // right: 20,
        top: 2,
        bottom: 40,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => sortByBottomSheet(context),
                icon: Icon(
                  Icons.sort,
                  color: InsuremartTheme.black1.withOpacity(.8),
                ),
                label: Text(
                  'Sort',
                  style: InsuremartTheme.lightTextTheme.bodyText1!
                      .copyWith(fontSize: 14),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: InsuremartTheme.black1.withOpacity(.8),
                ),
                label: Text(
                  'Filter',
                  style: InsuremartTheme.lightTextTheme.bodyText1!
                      .copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: company.length,
            itemBuilder: (context, index) => SelectInsurance(
              myIndex: index,
              SelectedIndex: _selectedIndex,
              onClick: (){
                setState(() {
                  _selectedIndex=index;
                  selectedProviderName=company[index].name;
                  selectedProviderImage=company[index].logo;
                });
              },
              context: context,
              title: company[index].name,
              logoUrl: company[index].logo,
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 15)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LongButton(title: 'CONTINUE', onPressed: ()async{
            setState(() {
              widget.model.providerName= selectedProviderName;
              widget.model.providerImage=selectedProviderImage;
            });
            print(widget.model.providerName);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewInsurance(myModel: widget.model, summary: 0,)));
           widget.model.providerImage==null? Fluttertoast.showToast(msg: "Kindly select a provider"): ref.nextStep();

          }),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LongButton(
            title: 'SAVE AND CONTINUE LATER',
            onPressed: () {
              buildBottomSheet(context);
            },
            color: InsuremartTheme.white1,
            textColor: InsuremartTheme.blue2,
            isBorder: true,
          ),
        ),
      ],
    );
  }

  Future<dynamic> sortByBottomSheet(BuildContext context) {
    List<Widget> buildRadio() => sortBy
        .map(
          (value) => RadioListTile<String>(
            contentPadding: const EdgeInsets.only(left: 5),
            value: value,
            groupValue: selectedValue,
            onChanged: (val) {
              setState(() {
                selectedValue = val;
              });
            },
            title: Text(
              value,
          style: InsuremartTheme.lightTextTheme.bodyText1!
              .copyWith(fontWeight: FontWeight.w400),
        ),
      ),
    )
        .toList();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 44),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                const SizedBox(width: 70),
                Text(
                  'Sort By',
                  style: InsuremartTheme.lightTextTheme.headline2!
                      .copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...buildRadio(),
            const SizedBox(height: 20),
            LongButton(title: 'APPLY', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class CustomRadioTile extends StatelessWidget {
  const CustomRadioTile({
    Key? key,
    required this.title,
    required this.onchanged,
  }) : super(key: key);
  final String title;
  final ValueChanged onchanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      contentPadding: const EdgeInsets.only(left: 5),
      value: 'value',
      groupValue: 'groupValue',
      onChanged: onchanged,
      title: Text(
        title,
        style: InsuremartTheme.lightTextTheme.bodyText1!
            .copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}

class SelectInsurance extends StatelessWidget {
  var SelectedIndex;
  final String title;
  final String logoUrl;
  int myIndex;
  BuildContext context;
  VoidCallback onClick;

  SelectInsurance({
    Key? key,
    required this.SelectedIndex,
    required this.context,
    required this.title,
    required this.logoUrl,
    required this.myIndex,
    required this.onClick
  }) : super(key: key);

  // final String

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              height: 91,
              decoration: BoxDecoration(
                color:
                SelectedIndex== myIndex? InsuremartTheme.green3 : InsuremartTheme.white2,
                border: Border.all(
                  width: SelectedIndex== myIndex? 2 : 1,
                  color:SelectedIndex== myIndex?
                  InsuremartTheme.green2
                      : InsuremartTheme.white3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(logoUrl),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: InsuremartTheme.lightTextTheme.headline2!
                        .copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          SelectedIndex== myIndex?
          const Positioned(
            right: 7,
            top: -2,
            child: Icon(
              Icons.check_circle,
              size: 30,
            ),
          )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class InsuranceCompany {
  final String name;
  final String logo;

  const InsuranceCompany({
    required this.name,
    required this.logo,
  });
}

const List<InsuranceCompany> company = [
  InsuranceCompany(
      name: 'Custodian & Allied Insurance', logo: 'assets/images/camel.png'),
  InsuranceCompany(
      name: 'Leadway Assurance Plc', logo: 'assets/images/camel.png'),
  InsuranceCompany(
      name: 'Allianz Nigeria Insurance Plc', logo: 'assets/images/camel.png'),
  InsuranceCompany(
      name: 'Mansard Insurance Plc', logo: 'assets/images/camel.png'),
  InsuranceCompany(
      name: 'Mutual Benefits Assurance Plc', logo: 'assets/images/camel.png'),

];
