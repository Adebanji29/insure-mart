// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/card_provider.dart';
import '../../utils/color.dart';
import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';
import '../../widget/card_widgets.dart';
import '../../widget/linear_progress_bar.dart';
import '../../widget/text_fields.dart';

class MyCards extends StatefulWidget {
  const MyCards({Key? key}) : super(key: key);
  static const route = '/myCard';

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cards'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                builder: (context) => GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: const BottomSheet(),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.add,
                    size: 20,
                  ),
                  Text(
                    'Add New Card',
                    style: InsuremartTheme.lightTextTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: InsuremartTheme.blue2),
                  )
                ],
              ),
            ),
            const SizedBox(height: 22),
              CardListView(),
          ],
        ),
      ),
      // bottomSheet: ,
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

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

      // Navigator.push(context, MaterialPageRoute(builder: (c)=> Main()));

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
                color: InsuremartColor.blue2,
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
          uploading == true ? linearProgressBar() : Container(),
          const SizedBox(height: 19),
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
            title: 'SAVE',
            onPressed: () {
              uploading == true ? null : validateUploadForm();
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
