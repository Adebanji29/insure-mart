import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Backend models/insurance_model.dart';
import '../../provider/new_insurance_provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import '../../widget/info_screen.dart';
import 'new_insurance.dart';

class StepThree extends StatefulWidget {
  final InsuranceModel model;
  const StepThree({super.key, required this.model});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  @override
  Widget build(BuildContext context) {
    NewInsuranceManager provider = Provider.of<NewInsuranceManager>(context);
    List<String> selectedSnapshot = provider.selectedExtension;
    final insure = context.read<NewInsuranceManager>();
    final insurance = context.watch<NewInsuranceManager>();

    return ListView(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 40,
      ),
      children: [
        CustomListTile(
          title: 'Excess Buy Back (EBB)',
          tapSelect: () async {
            insure.step3Switch('ebb');
          },
          toastTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPage(
                          title: Utils.extension_descript[0]["name"],
                          message: Utils.extension_descript[0]["descript"],
                        )));
          },
          selected: insurance.ebb,
        ),
        const SizedBox(height: 25),
        CustomListTile(
          title: 'Flood Extension',
          tapSelect: () async {
            insure.step3Switch('flood');
          },
          toastTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPage(
                          title: Utils.extension_descript[2]["name"],
                          message: Utils.extension_descript[2]["descript"],
                        )));
          },
          selected: insurance.flood,
        ),
        const SizedBox(height: 25),
        CustomListTile(
          title: 'SRCC Extension',
          tapSelect: () async {
            insure.step3Switch('srcc');
          },
          toastTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPage(
                          title: Utils.extension_descript[1]["name"],
                          message: Utils.extension_descript[1]["descript"],
                        )));
          },
          selected: insurance.srcc,
        ),
        const SizedBox(height: 25),
        CustomListTile(
          title: 'Additional Third Party Property Damage',
          tapSelect: () {
            insure.step3Switch('atp');
          },
          toastTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPage(
                          title: Utils.extension_descript[4]["name"],
                          message: Utils.extension_descript[5]["descript"],
                        )));
          },
          selected: insurance.atp,
        ),
        const SizedBox(height: 25),
        CustomExpansion(
          title: 'Vehicle tracking device',
          selected: insurance.atp,
          childern: const [],
        ),
        const SizedBox(height: 25),
        CustomExpansion(
          title: 'Renew tracking device',
          selected: insurance.atp,
          childern: const [],
        ),
        const SizedBox(height: 25),
        CustomExpansion(
          title: 'Renew vehicle license',
          selected: insurance.atp,
          childern: const [],
        ),
        const SizedBox(height: 25),
        CustomListTile(
          title: 'Renew road worthiness',
          tapSelect: () async {
            insure.step3Switch('rrw');
          },
          toastTap: () {},
          selected: insurance.rrw,
        ),
        const SizedBox(height: 25),
        CustomListTile(
          title: 'Renew Hackney Permit',
          tapSelect: () {
            insure.step3Switch('rhp');
          },
          toastTap: () {},
          selected: insurance.rhp,
        ),
        const SizedBox(height: 25),
        CustomListTile(
          title: 'Delete personal effects',
          tapSelect: () {
            insure.step3Switch('dpe');
          },
          toastTap: () {},
          selected: insurance.dpe,
        ),
        const CustomSizedBox(height: 10),
        LongButton(
            title: 'CONTINUE',
            onPressed: () async {
              setState(() {
                widget.model.step3Extensions = selectedSnapshot;
              });
              print(widget.model.step3Extensions);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewInsurance(
                            myModel: widget.model,
                            summary: 0,
                          )));
              insure.nextStep();
            }),
      ],
    );
  }
}

class CustomExpansion extends StatelessWidget {
  const CustomExpansion({
    Key? key,
    this.isExpanded = false,
    this.selected = false,
    required this.title,
    required this.childern,
  }) : super(key: key);
  final bool isExpanded;
  final bool selected;
  final String title;
  final List<Widget> childern;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: selected ? InsuremartTheme.green3 : InsuremartTheme.white2,
        border: Border.all(
          width: selected ? 2 : 1,
          color: selected ? InsuremartTheme.green2 : InsuremartTheme.white3,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 24),
          title: Text(
            title,
            style: InsuremartTheme.lightTextTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          trailing: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.info_outlined,
              color: InsuremartTheme.black3,
            ),
          ),
          children: [
            Divider(color: InsuremartTheme.black4.withOpacity(.2)),
            ...childern,
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.selected = false,
    required this.toastTap,
    required this.tapSelect,
    required this.title,
  }) : super(key: key);
  final String title;
  final bool selected;
  final GestureTapCallback toastTap;
  final GestureTapCallback tapSelect;

  // my addditional stuffs

  @override
  Widget build(BuildContext context) {
    // print('object');
    return GestureDetector(
      onTap: tapSelect,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 78,
        decoration: BoxDecoration(
          color: selected == true
              ? InsuremartTheme.green3
              : InsuremartTheme.white2,
          border: Border.all(
            width: selected ? 2 : 1,
            color: selected ? InsuremartTheme.green2 : InsuremartTheme.white3,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: InsuremartTheme.lightTextTheme.bodyText1!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                selected
                    ? const Icon(Icons.check, color: InsuremartTheme.blue1)
                    : Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                          color: InsuremartTheme.black4.withOpacity(.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                const SizedBox(width: 22),
                InkWell(
                  onTap: toastTap,
                  child: const Icon(
                    Icons.info_outlined,
                    color: InsuremartTheme.black3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
