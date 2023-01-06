// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

import '../../Backend models/insurance_model.dart';
import '../../Backend models/cardModel.dart';
import '../../Payment/payment_page.dart';
import '../../computation/computation.dart';
import '../../provider/insurance_provider.dart';
// import './request_hardcopy.dart';
import '../../utils/app_theme.dart';
import '../../provider/card_provider.dart';
// import '../../provider/new_insurance_provider.dart';
import '../../widget/buttons.dart';
import '../../widget/card_widgets.dart';
import '../../widget/text_fields.dart';

class StepSix extends StatefulWidget {
  final InsuranceModel model;
  String summary;
 StepSix({super.key, required this.model,required this.summary});

  @override
  State<StepSix> createState() => _StepSixState();
}

class _StepSixState extends State<StepSix> {

  var selectedIndex;

  CardModel mycardModel = CardModel();

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    InsuranceProvider insuranceProvider =
        Provider.of<InsuranceProvider>(context);
    CardProvider cardprovider = Provider.of<CardProvider>(context);

    cardprovider.getCardData();
    List<CardModel> cardmodelList = cardprovider.getCardList;

    final card = context.read<CardProvider>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 67),
      children: [
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: TextButton.icon(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: false,
              builder: (context) => GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: BottomSheet(),
              ),
            ),
            icon: const Icon(
              Icons.add,
              color: InsuremartTheme.blue2,
            ),
            label: Text(
              'Add New Card',
              style: InsuremartTheme.lightTextTheme.headline3!
                  .copyWith(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(height: 2),
        const Text("Swipe down to see list of cards added"),
        const SizedBox(height: 46),
        cardmodelList.isNotEmpty
            ? SizedBox(
                height: 270,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CardTile(
                          onClick: () {
                            setState(() {
                              mycardModel = cardmodelList[index];
                              selectedIndex = index;
                            });
                          },
                          myIndex: index,
                          model: cardmodelList[index],
                          context: context,
                          SelectedIndex: selectedIndex);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: cardprovider.getCardListLength),
              )
            : const SizedBox(
                height: 270,
                child: Center(
                  child: Text(
                    "There are no cards yet",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
        const SizedBox(height: 76),
        const Divider(),
        const SizedBox(height: 25),
        textRow('Amount Insured', widget.model.sumInsured.toString()),
        const SizedBox(height: 10),
        textRow('Extensions + Addons',
            widget.model.step3Extensions.toString() != null? widget.model.step3Extensions.length.toString():"0",),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Summary',
              style: InsuremartTheme.lightTextTheme.headline3!
                  .copyWith(color: InsuremartTheme.green1),
            ),
            Text(
              '₦${widget.summary.toString()}',
              style: InsuremartTheme.lightTextTheme.headline3!
                  .copyWith(fontSize: 18, color: InsuremartTheme.green1),
            ),
          ],
        ),
        const SizedBox(height: 25),
        LongButton(
            title: 'Pay',
            onPressed: () {
              if (selectedIndex == null) {
                Fluttertoast.showToast(msg: "Kindly select a payment card");
              } else {
                // insuranceProvider.saveNewInsuranceInfo(widget.model);//
                setState(() {
                  widget.model.premiumPaid=widget.summary;
                });
                MakePayment(
                        cardModel: mycardModel,
                        insurancemodel: widget.model,
                        context: context,
                        email: "emogbolu@theinsuremart.com",
                        price: double.parse(widget.summary.toString()).toInt())
                    .chargeCardAndMakePayment();}
            }),
        const SizedBox(height: 10),
        // LongButton(
        //   title: 'SAVE & CONTINUE LATER',
        //   onPressed: () {},
        //   color: InsuremartTheme.white1,
        //   textColor: InsuremartTheme.blue4,
        //   isBorder: true,
        // ),
      ],
    );
  }

  Row textRow(String otext, String ttext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(otext),
        text(ttext),
      ],
    );
  }

  Text text(String text) {
    return Text(
      text,
      style: InsuremartTheme.lightTextTheme.bodyText2!.copyWith(fontSize: 13),
    );
  }
}

class BottomSheet extends StatefulWidget {
  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  late TextEditingController _name;
  late TextEditingController _number;
  late TextEditingController _exp;
  late TextEditingController _cvv;

  @override
  void initState() {
    _name = TextEditingController();
    _number = TextEditingController();
    _exp = TextEditingController();
    _cvv = TextEditingController();
    super.initState();
  }

  String cardUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool uploading = false;

  validateUploadForm() async {
    if (_name.text.isEmpty ||
        _number.text.isEmpty ||
        _exp.text.isEmpty ||
        _cvv.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all details correctyly.");
    } else if (_number.text.length < 16 || _number.text.length > 16) {
      Fluttertoast.showToast(msg: "Enter correct Card Number");
    } else {
      setState(() {
        uploading = true;
      });

      CardProvider cardProvider =
          Provider.of<CardProvider>(context, listen: false);
      cardProvider.saveCardInfo(_name.text.trim(), _number.text.trim(),
          _exp.text.trim(), _cvv.text.trim());

      setState(() {
        uploading = false;
        cardUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 32,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 27,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                iconSize: 19,
                color: InsuremartTheme.blue2,
                icon: const Icon(Icons.close),
              ),
              const SizedBox(width: 83),
              Text(
                'Add New Card',
                style: InsuremartTheme.lightTextTheme.headline2!
                    .copyWith(fontSize: 16),
              )
            ],
          ),
          const SizedBox(height: 19),
          uploading == true ? const LinearProgressIndicator() : Container(),
          label('Name on card'),
          const SizedBox(height: 5),
          CustomTextField(
            controller: _name,
            label: 'Full name on card',
          ),
          const SizedBox(height: 25),
          label('Card number'),
          const SizedBox(height: 5),
          CustomTextField(
              controller: _number, label: '16-digit number on card'),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label('Expiry date'),
                    CustomTextField(controller: _exp, label: 'MM/YY'),
                  ],
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label('CVV'),
                    CustomTextField(controller: _cvv, label: '3-digit number'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          LongButton(
            title: 'CONTINUE',
            onPressed: () {
              validateUploadForm();
            },
          )
        ],
      ),
    );
  }

  SizedBox textField(String label, {double? width}) {
    return SizedBox(
      width: width,
      height: 48,
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            labelStyle: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w400,
              color: InsuremartTheme.white3,
            ),
            floatingLabelStyle:
                InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w400,
              color: InsuremartTheme.blue2,
            ),
            fillColor: InsuremartTheme.white2,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: InsuremartTheme.white3,
                ))),
      ),
    );
  }

  Text label(String title) {
    return Text(
      title,
      style: InsuremartTheme.lightTextTheme.bodyText1,
      textAlign: TextAlign.start,
    );
  }
}
