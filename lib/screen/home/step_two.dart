import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Backend models/insurance_model.dart';
import '../../provider/new_insurance_provider.dart';
import '../../widget/save_bottom_sheet.dart';
import '../claims/new_claim.dart';
import '../../widget/text_fields.dart';
import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';

class StepTwo extends StatefulWidget {
  final InsuranceModel model;
  const StepTwo({super.key, required this.model});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {

  File? _carFront;
  @override
  Widget build(BuildContext context) {
    final ref = context.read<NewInsuranceManager>();
    return ListView(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 40,
      ),
      children: [
        label('Car Front (optional)'),
        ImageContainer(imageFile: _carFront, which: '',
        ),
        const SizedBox(height: 25),
        label('Car Left Side (optional)'),
        ImageContainer(imageFile: _carFront, which: '',
        ),
        const SizedBox(height: 25),
        label('Car Right Side (optional)'),
        ImageContainer(imageFile: _carFront, which: '',
        ),
        const SizedBox(height: 25),
        label('Car Back (optional)'),
        ImageContainer(imageFile: _carFront, which: '',
        ),
        const SizedBox(height: 25),
        label('Car Interior 1 (optional)'),
        ImageContainer(imageFile: _carFront, which: '',
        ),
        const SizedBox(height: 25),
        label('Car Interior 2 (optional)'),
        ImageContainer(imageFile: _carFront, which: '',
        ),
        const SizedBox(height: 25),
        label('Car Interior 3 (optional)s'),
        ImageContainer(imageFile: _carFront, which: '',
        ),
        const SizedBox(height: 25),
        LongButton(title: 'CONTINUE', onPressed:
        ref.nextStep

        ),


        const SizedBox(height: 10),
        // LongButton(
        //   title: 'SAVE AND CONTINUE LATER',
        //   onPressed: () {
        //     buildBottomSheet(context);
        //   },
        //   color: InsuremartTheme.white1,
        //   textColor: InsuremartTheme.blue2,
        //   isBorder: true,
        // ),
      ],
    );
  }

}
