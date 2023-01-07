// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Backend models/insurance_model.dart';
import '../../provider/new_insurance_provider.dart';
import '../claims/new_claim.dart';
import '../../widget/text_fields.dart';
import '../../widget/buttons.dart';

class StepTwo extends StatefulWidget {
  final InsuranceModel model;
  const StepTwo({super.key, required this.model});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  @override
  Widget build(BuildContext context) {
    final ref = context.read<NewInsuranceManager>();
    final watchProvider = context.watch<NewInsuranceManager>();
    return ListView(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 40,
      ),
      children: [
        label('Car Front (optional)'),
        ImageContainer(
          imageFile: watchProvider.carFront,
          which: 'front',
          isClaim: false,
        ),
        const SizedBox(height: 25),
        label('Car Left Side (optional)'),
        ImageContainer(
          imageFile: watchProvider.carLeft,
          which: 'left',
          isClaim: false,
        ),
        const SizedBox(height: 25),
        label('Car Right Side (optional)'),
        ImageContainer(
          imageFile: watchProvider.carRight,
          which: 'right',
          isClaim: false,
        ),
        const SizedBox(height: 25),
        label('Car Back (optional)'),
        ImageContainer(
          imageFile: watchProvider.carBack,
          which: 'back',
          isClaim: false,
        ),
        const SizedBox(height: 25),
        label('Car Interior 1 (optional)'),
        ImageContainer(
          imageFile: watchProvider.carInterior1,
          which: 'interior1',
          isClaim: false,
        ),
        const SizedBox(height: 25),
        label('Car Interior 2 (optional)'),
        ImageContainer(
          imageFile: watchProvider.carInterior2,
          which: 'interior2',
          isClaim: false,
        ),
        const SizedBox(height: 25),
        label('Car Interior 3 (optional)s'),
        ImageContainer(
          imageFile: watchProvider.carInterior3,
          which: 'interior3',
          isClaim: false,
        ),
        const SizedBox(height: 25),
        LongButton(title: 'CONTINUE', onPressed: ref.nextStep),

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
